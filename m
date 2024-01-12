Return-Path: <bpf+bounces-19484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E082C5FF
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D561F253C9
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640815AFD;
	Fri, 12 Jan 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRityevg"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFF1640B
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ee2f4fb3-12b5-41ef-b3bf-b67a73f0105d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705088872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/VqR5Xhj2JZIvBYaCc6cE9Whg2FaHGC6zQ47S6eL2Q=;
	b=WRityevgduaYEAciU7zS1MLAQR4/Rgc2mOJaMAVkUQ0g5KS6U3rfzm6qkxAa/WJcZwLwY1
	6T1XydFd1i/1cb3Y9eoK84j5OueZDoJkBq79SvvBQfW79M3sL7MvrJoI//0s9r3IIEemV0
	OC7EesNWUOKWZvEEAW411PKLMl3ZbgU=
Date: Fri, 12 Jan 2024 11:47:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
Content-Language: en-US
To: Andrey Grafin <conquistador@yandex-team.ru>
Cc: andrii@kernel.org, bpf@vger.kernel.org,
 Yonghong Song <yonghong.song@linux.dev>
References: <20240112121051.17325-1-conquistador@yandex-team.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240112121051.17325-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/24 4:10 AM, Andrey Grafin wrote:
> This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.
> 
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
> 
> A simple bpf snippet to reproduce:
>    struct inner_map {
>      __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>      __uint(key_size, sizeof(int));
>      __uint(value_size, sizeof(u32));
>    } inner_map0 SEC(".maps"), inner_map1 SEC(".maps");
> 
>    struct {
>      __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>      __uint(max_entries, 2);
>      __type(key, u32);
>      __array(values, struct inner_map);
>    } outer_map SEC(".maps") = {
>      .values = {&inner_map0, &inner_map1}};
>    ...
> 
> Previous behaviour:
>    # sudo bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
>      libbpf: map 'outer_map': failed to create inner map: -22
>      libbpf: map 'outer_map': failed to create: Invalid argument(-22)
>      libbpf: failed to load object './bpf_sample.elf'
>      Error: failed to load object file
> 
>    # sudo strace -e bpf bpftool prog load ./bpf_sample.elf /sys/fs/bpf/test
>    ...
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
>      map_name="inner_map0", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 4
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=16, map_flags=0, inner_map_fd=0,
>      map_name="inner_map1", map_ifindex=0, btf_fd=0, btf_key_type_id=0,
>      btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 5
>    bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4,
>      value_size=4, max_entries=0, map_flags=0, inner_map_fd=0,
>      map_name="outer_map.inner", map_ifindex=0, btf_fd=0,
>      btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0,
>      map_extra=0}, 72) = -1 EINVAL (Invalid argument)

The change makes sense. Please help to add a real selftest to catch future 
regression. I believe it is what Yonghong has already asked in v1. Some of the 
existing "progs/*map_in_map*.c" may be a good candidate to add this test case.

pw-bot: cr


