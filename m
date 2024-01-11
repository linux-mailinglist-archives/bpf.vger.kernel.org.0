Return-Path: <bpf+bounces-19383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95F82B5E5
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 21:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09BB1C2438D
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C456B86;
	Thu, 11 Jan 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T8tBj8+Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849B56B7C
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1308094b-434d-4372-9546-34d17d350820@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705004915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTEEqJuej7c76jN5VUN7lve+VlLIQFJhZ26dQSaKC6A=;
	b=T8tBj8+QfOFu17t7wPPPS61GfF0Wg6idnJwmPZwFC1sZgwtsj7tSptvOB5HqSoRoF6yeVX
	icoskDYAVtHCwj893MMaLgZhQjNusheyHHTrB4P//UlUn/69PlE9ielmmoacAxzLMvDqP7
	qvOg+cC2jgP0jlzzRaFBRvziyuPez0g=
Date: Thu, 11 Jan 2024 12:28:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: apply map_set_def_max_entries() for inner_maps
 on creation
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240111200513.9254-1-conquistador@yandex-team.ru>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240111200513.9254-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/11/24 12:05 PM, Andrey Grafin wrote:
> This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.
>
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.

Could you add a test case for this so it will be clear from code
what is the previous behavior and what is the new behavior?

>
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
> ---
>   tools/lib/bpf/libbpf.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067be95da3c..8f4d580187aa 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -70,6 +70,7 @@
>   
>   static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
>   static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
> +static int map_set_def_max_entries(struct bpf_map *map);
>   
>   static const char * const attach_type_name[] = {
>   	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
> @@ -5212,6 +5213,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>   
>   	if (bpf_map_type__is_map_in_map(def->type)) {
>   		if (map->inner_map) {
> +			err = map_set_def_max_entries(map->inner_map);
> +			if (err)
> +				return err;
>   			err = bpf_object__create_map(obj, map->inner_map, true);
>   			if (err) {
>   				pr_warn("map '%s': failed to create inner map: %d\n",

