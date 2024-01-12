Return-Path: <bpf+bounces-19455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D682BF9E
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 13:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EC0287879
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B786A024;
	Fri, 12 Jan 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="n9rYEo5W"
X-Original-To: bpf@vger.kernel.org
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371C6A32A
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
	by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 0A1E562192;
	Fri, 12 Jan 2024 15:11:00 +0300 (MSK)
Received: from conquistador.yandex.net (unknown [2a02:6b8:0:40c:d80d:e04a:8a36:b2e9])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id sAjL4VZiA0U0-SIc9gYKc;
	Fri, 12 Jan 2024 15:10:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1705061459;
	bh=H4XESx06/u1IEKAY5UVK18KDptqXyb9fD1SfTJ32MsM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=n9rYEo5W8unpSX7354XSlWkM5dizPzpDPhnoyLYWkq49VlC1MA6G9UvHlR7MeuE/U
	 /keBT7biJ3dUFlDy8VOlwFiRlDmGmJbBUqtNdV3jE9wMKmI9XzLhC3ImOI0jHFVQSp
	 rGg/DQMEWfep8UVd6+iTLbE2UW/Ae5UALm9zdHoE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Grafin <conquistador@yandex-team.ru>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org
Subject: [PATCH bpf v2] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Fri, 12 Jan 2024 15:10:51 +0300
Message-ID: <20240112121051.17325-1-conquistador@yandex-team.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.

Previous behaviour created a zero filled btf_map_def for inner maps and
tried to use it for a map creation but the linux kernel forbids to create
a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.

A simple bpf snippet to reproduce:
  struct inner_map {
    __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
    __uint(key_size, sizeof(int));
    __uint(value_size, sizeof(u32));
  } inner_map0 SEC(".maps"), inner_map1 SEC(".maps");

  struct {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __uint(max_entries, 2);
    __type(key, u32);
    __array(values, struct inner_map);
  } outer_map SEC(".maps") = {
    .values = {&inner_map0, &inner_map1}};
  ...

Previous behaviour:
  # sudo bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
    libbpf: map 'outer_map': failed to create inner map: -22
    libbpf: map 'outer_map': failed to create: Invalid argument(-22)
    libbpf: failed to load object './bpf_sample.elf'
    Error: failed to load object file

  # sudo strace -e bpf bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
  ...
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
    value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
    map_name="inner_map0", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
    btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 4
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
    value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
    map_name="inner_map1", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
    btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 5
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
    value_size=4, max_entries=0, map_flags=0, inner_map_fd=0,
    map_name="outer_map.inner", map_ifindex=0, btf_fd=0,
    btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0,
    map_extra=0}, 72) = -1 EINVAL (Invalid argument)

New behaviour:
  # sudo strace -e bpf bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
  ...
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
    value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
    map_name="inner_map0", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
    btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 4
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
    value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
    map_name="inner_map1", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
    btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 5
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
    value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
    map_name="outer_map.inner", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
    btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 6
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY_OF_MAPS, key_size=4,
    value_size=4, max_entries=2, map_flags=0, inner_map_fd=6,
    map_name="outer_map", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
    btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 7
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0x7ffc89f2de54,
    value=0x7ffc89f2de58,flags=BPF_ANY}, 32) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0x7ffc89f2de54,
    value=0x7ffc89f2de58, flags=BPF_ANY}, 32) = 0
  ...
  +++ exited with 0 +++

Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067be95da3c..8f4d580187aa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -70,6 +70,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
@@ -5212,6 +5213,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
 	if (bpf_map_type__is_map_in_map(def->type)) {
 		if (map->inner_map) {
+			err = map_set_def_max_entries(map->inner_map);
+			if (err)
+				return err;
 			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
 				pr_warn("map '%s': failed to create inner map: %d\n",
-- 
2.41.0


