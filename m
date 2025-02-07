Return-Path: <bpf+bounces-50754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636B7A2BFF0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 10:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8F17A11D8
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F83F1DC184;
	Fri,  7 Feb 2025 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XvIJjVO2"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2732C8B
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921952; cv=none; b=VD3a7XlMXvioahjmnqZWWsY4bnS9bG2ss3Sz4gm7jYuV7XIYDMNY/4L0W9rDur1yqey84lbTHP2DBYtpf1PG96EqE+KbD7oDokLYk7+Ujha9027Bdq1cxKalO5erc0oIYeHCoHKdTFnjLawujawdkuWeAYQ7fFCs87biYvIbYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921952; c=relaxed/simple;
	bh=USW69VXiJcJJc3R7IxUgwYRRx1REVlezn7K35KRjqrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOVOjTrdX9vbf+18IvpDW7y2icKFXZJAix1fYWC3Ul/mBTYOzMFW+8mTdmI/5uO8IlKJEW+OIxO/65ArdOu7kEcqKczT44xFIOEvzY7StNyNwKQy9pQbVOngUF94aviyIERRGgGLhv3wV/UCP2tT3suRuQvi+h3jo+b//X2w7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XvIJjVO2; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a33f2c3-1f01-4612-83b6-40a79fbdf4d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738921944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDs5i9RLhtZ060wRmA3L5QEgTnkX3JBPQAFmbmRGdnA=;
	b=XvIJjVO2xsGE5rZYLQlFWWCoWAIciAc2Kt9sFQNqfRmxpRppJTsN13gZLnkMMsryqt4cek
	i5XshN65FW1muqQkNPDqr6IcpYIC8iuwnKEdiIgirDQenLDEsBOQ9fmL4N0ACFZYl+1EaY
	n8z+HuU3sz0BrVf5lK/23u5Dbvoutm0=
Date: Fri, 7 Feb 2025 17:52:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/4] bpf, bpftool: Generate skeleton for global
 percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250127162158.84906-1-leon.hwang@linux.dev>
 <20250127162158.84906-4-leon.hwang@linux.dev>
 <CAEf4BzYBo8bGoOEQ6horb=E69txnWN5Ch1+Pzfft0JKpGAaQAA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYBo8bGoOEQ6horb=E69txnWN5Ch1+Pzfft0JKpGAaQAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/2/25 08:09, Andrii Nakryiko wrote:
> On Mon, Jan 27, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch enhances bpftool to generate skeletons for global percpu
>> variables. The generated skeleton includes a dedicated structure for
>> percpu data, allowing users to initialize and access percpu variables
>> efficiently.
>>
>> Changes:
>>
>> 1. skeleton structure:
>>
>> For global percpu variables, the skeleton now includes a nested
>> structure, e.g.:
>>
>> struct test_global_percpu_data {
>>         struct bpf_object_skeleton *skeleton;
>>         struct bpf_object *obj;
>>         struct {
>>                 struct bpf_map *bss;
>>                 struct bpf_map *percpu;
>>         } maps;
>>         // ...
>>         struct test_global_percpu_data__percpu {
>>                 int percpu_data;
>>         } *percpu;
>>
>>         // ...
>> };
>>
>>   * The "struct test_global_percpu_data__percpu" points to initialized
>>     data, which is actually "maps.percpu->data".
>>   * Before loading the skeleton, updating the
>>     "struct test_global_percpu_data__percpu" modifies the initial value
>>     of the corresponding global percpu variables.
>>   * After loading the skeleton, accessing or updating this struct is no
>>     longer meaningful. Instead, users must interact with the global
>>     percpu variables via the "maps.percpu" map.
> 
> can we set this pointer to NULL after load to avoid accidental
> (successful) reads/writes to it?
> 

Good idea. I'll try to achieve it.

>>
>> 2. code changes:
>>
>>   * Added support for ".percpu" sections in bpftool's map identification
>>     logic.
>>   * Modified skeleton generation to handle percpu data maps
>>     appropriately.
>>   * Updated libbpf to make "percpu" pointing to "maps.percpu->data".
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/bpf/bpftool/gen.c | 13 +++++++++----
>>  tools/lib/bpf/libbpf.c  |  3 +++
>>  tools/lib/bpf/libbpf.h  |  1 +
>>  3 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 5a4d3240689ed..975775683ca12 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
>>
>>  static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
>>  {
>> -       static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
>> +       static const char *sfxs[] = { ".data", ".rodata", ".percpu", ".bss", ".kconfig" };
>>         const char *name = bpf_map__name(map);
>>         int i, n;
>>
>> @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
>>
>>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
>>  {
>> -       static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
>> +       static const char *pfxs[] = { ".data", ".rodata", ".percpu", ".bss", ".kconfig" };
>>         int i, n;
>>
>>         /* recognize hard coded LLVM section name */
>> @@ -263,7 +263,9 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>                 return true;
>>         }
>>
>> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> +       if (!bpf_map__is_internal(map) ||
>> +           (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE) &&
>> +            bpf_map__type(map) != BPF_MAP_TYPE_PERCPU_ARRAY))
> 
> there will be no BPF_F_MMAPABLE set for PERCPU_ARRAY, why adding these
> unnecessary extra conditionals?
> 

Ack. It's unnecessary.

>>                 return false;
>>
>>         if (!get_map_ident(map, buf, sz))
>> @@ -903,7 +905,10 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped, bool
>>                         i, bpf_map__name(map), ident);
>>                 /* memory-mapped internal maps */
>>                 if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
>> -                       printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
>> +                       if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>> +                               printf("\tmap->data = (void **)&obj->%s;\n", ident);
>> +                       else
>> +                               printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
>>                 }
>>
>>                 if (populate_links && bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS) {
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6da6004c5c84d..dafb419bc5b86 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -13915,6 +13915,7 @@ static int populate_skeleton_maps(const struct bpf_object *obj,
>>                 struct bpf_map **map = map_skel->map;
>>                 const char *name = map_skel->name;
>>                 void **mmaped = map_skel->mmaped;
>> +               void **data = map_skel->data;
>>
>>                 *map = bpf_object__find_map_by_name(obj, name);
>>                 if (!*map) {
>> @@ -13925,6 +13926,8 @@ static int populate_skeleton_maps(const struct bpf_object *obj,
>>                 /* externs shouldn't be pre-setup from user code */
>>                 if (mmaped && (*map)->libbpf_type != LIBBPF_MAP_KCONFIG)
>>                         *mmaped = (*map)->mmaped;
>> +               if (data && (*map)->libbpf_type == LIBBPF_MAP_PERCPU_DATA)
>> +                       *data = (*map)->data;
>>         }
>>         return 0;
>>  }
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 3020ee45303a0..c49d6e44b5630 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1701,6 +1701,7 @@ struct bpf_map_skeleton {
>>         const char *name;
>>         struct bpf_map **map;
>>         void **mmaped;
>> +       void **data;
> 
> this is breaking backwards/forward compatibility. let's try to reuse mmaped
> 

Indeed. If reuse map->mmaped for global percpu variables, it's
unnecessary to add this "data".

>>         struct bpf_link **link;
>>  };
>>
>> --
>> 2.47.1
>>

Thanks,
Leon



