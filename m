Return-Path: <bpf+bounces-69458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96235B96D34
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379C77A38D8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF0322757;
	Tue, 23 Sep 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gjcHBYQM"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AE1B423C
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644860; cv=none; b=LCoWJsOfaaAnHID9BvPm1epp+bKjBqeV4kLlVFzwFyRHHpEHOVMOpO+sT4YcJSEX+QroWZv9uKWCJ8U4OXxaDLKyrtHe1pbLAc5a4RAnpkzhfuFCiMG+qJnwS1RzSzsrVLMpH3HehbF93g6Y4yWe0qNuSM0G7dOPh63ErewrPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644860; c=relaxed/simple;
	bh=q/FCAaFblffDuWbHWqf5av57+M+Vy5Pog09CvPnrriA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB9ccUf7QeF6ZxixLpwZ5ap1QhrLquIXb71msqeOn0kyesd0+OVv3d+3ZcnfCwiYwDwsOiLOetQSK7sMqkbmRKozsC9zEJG/G3jV9DXaOldZo/MY0v+kyu/AIvYkdGat92w8/lwyxgWuq6W9cwC6BQ8r9+zExsB4lffl+JlV9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gjcHBYQM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da547182-563c-463b-8ac5-ac4b9064cb6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758644855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nql6fitPcEBbu94qpJiqOV95xENQik8imnuiE8p7e80=;
	b=gjcHBYQMBcsyZcI8jti6zzi7yF64THaj6PU/bVQ65zYPZD5Xq3yRLoYTZotMnLSYnSNFxS
	XTsaDoRzDH+9BJQRIaRXaOTs14wGqYrfu4vWiZlHV5SqS7TBEtWtPQ+lDYKlSCDoeFAgtg
	J5dqelSkzitAM9vLkX1C8F/wYonKB0Y=
Date: Wed, 24 Sep 2025 00:27:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 4/6] bpf: Add common attr support for
 map_create
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, menglong8.dong@gmail.com
References: <20250911163328.93490-1-leon.hwang@linux.dev>
 <20250911163328.93490-5-leon.hwang@linux.dev>
 <CAEf4BzbX_j5guUYuNNgR4dANR11tzLriDGOCOfxS9zRFmQdi7g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbX_j5guUYuNNgR4dANR11tzLriDGOCOfxS9zRFmQdi7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/18 05:39, Andrii Nakryiko wrote:
> On Thu, Sep 11, 2025 at 9:33 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Currently, many 'BPF_MAP_CREATE' failures return '-EINVAL' without
>> providing any explanation to user space.
>>
>> With the extended BPF syscall support introduced in the previous patch,
>> detailed error messages can now be reported. This allows users to
>> understand the specific reason for a failed map creation, rather than
>> just receiving a generic '-EINVAL'.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/syscall.c | 82 ++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 63 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 5e5cf0262a14e..2f5e6005671b5 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1340,12 +1340,13 @@ static bool bpf_net_capable(void)
>>
>>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
>>  /* called via syscall */
>> -static int map_create(union bpf_attr *attr, bool kernel)
>> +static int map_create(union bpf_attr *attr, bool kernel, struct bpf_common_attr *common_attrs)
>>  {
>> +       u32 map_type = attr->map_type, log_true_size;
>> +       struct bpf_verifier_log *log = NULL;
>>         const struct bpf_map_ops *ops;
>>         struct bpf_token *token = NULL;
>>         int numa_node = bpf_map_attr_numa_node(attr);
>> -       u32 map_type = attr->map_type;
>>         struct bpf_map *map;
>>         bool token_flag;
>>         int f_flags;
>> @@ -1355,6 +1356,18 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>         if (err)
>>                 return -EINVAL;
>>
>> +       if (common_attrs->log_buf) {
>> +               log = kvzalloc(sizeof(*log), GFP_KERNEL);
>> +               if (!log)
>> +                       return -ENOMEM;
>> +               err = bpf_vlog_init(log, BPF_LOG_FIXED, u64_to_user_ptr(common_attrs->log_buf),
>> +                                   common_attrs->log_size, NULL);
>> +               if (err) {
>> +                       kvfree(log);
>> +                       return err;
>> +               }
>> +       }
>
> what if we keep bpf_verifier_log on stack? It's 1KB, should be still
> fine to be on kernel stack, no?
>

I'm going to follow Alexei's suggestion.

>
>> +
>>         /* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
>>          * to avoid per-map type checks tripping on unknown flag
>>          */
>> @@ -1363,16 +1376,24 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>
>>         if (attr->btf_vmlinux_value_type_id) {
>>                 if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
>> -                   attr->btf_key_type_id || attr->btf_value_type_id)
>> -                       return -EINVAL;
>> +                   attr->btf_key_type_id || attr->btf_value_type_id) {
>> +                       bpf_log(log, "Invalid use of btf_vmlinux_value_type_id.\n");
>
> I don't know how far we want to go here, but I'd split the original
> check into map type check and key_type/value_type check, and log a bit
> more meaningful error:
>
> a) btf_vmlinux_value_type_id can only be used with struct_ops maps.
>
> and
>
> b) btf_vmlinux_value_type_id is mutually exclusive with
> btf_key_type_id and btf_value_type_id
>

Sure.

It would be better to separate it like this.

>> +                       err = -EINVAL;
>> +                       goto put_token;
>
> there is no token just yet, add new label for finalizing log?
>

Ack.

>> +               }
>>         } else if (attr->btf_key_type_id && !attr->btf_value_type_id) {
>> -               return -EINVAL;
>> +               bpf_log(log, "Invalid btf_value_type_id.\n");
>> +               err = -EINVAL;
>> +               goto put_token;
>
> ditto about token
>

Ack.

>>         }
>>
>>         if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
>>             attr->map_type != BPF_MAP_TYPE_ARENA &&
>> -           attr->map_extra != 0)
>> -               return -EINVAL;
>> +           attr->map_extra != 0) {
>> +               bpf_log(log, "Invalid map_extra.\n");
>> +               err = -EINVAL;
>> +               goto put_token;

It'll be changed to the new label.

>> +       }
>>
>>         f_flags = bpf_get_file_flag(attr->map_flags);
>>         if (f_flags < 0)
>> @@ -1380,17 +1401,26 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>
>>         if (numa_node != NUMA_NO_NODE &&
>>             ((unsigned int)numa_node >= nr_node_ids ||
>> -            !node_online(numa_node)))
>> -               return -EINVAL;
>> +            !node_online(numa_node))) {
>> +               bpf_log(log, "Invalid or offline numa_node.\n");
>
>
> nit: just "invalid numa_node" ?
>

Ack.

>> +               err = -EINVAL;
>> +               goto put_token;

It'll be changed to the new label.

>> +       }
>>
>>         /* find map type and init map: hashtable vs rbtree vs bloom vs ... */
>>         map_type = attr->map_type;
>> -       if (map_type >= ARRAY_SIZE(bpf_map_types))
>> -               return -EINVAL;
>> +       if (map_type >= ARRAY_SIZE(bpf_map_types)) {
>> +               bpf_log(log, "Invalid map_type.\n");
>> +               err = -EINVAL;
>> +               goto put_token;

It'll be changed to the new label.

>> +       }
>>         map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
>>         ops = bpf_map_types[map_type];
>> -       if (!ops)
>> -               return -EINVAL;
>> +       if (!ops) {
>> +               bpf_log(log, "Invalid map_type.\n");
>> +               err = -EINVAL;
>> +               goto put_token;

It'll be changed to the new label.

>> +       }
>>
>>         if (ops->map_alloc_check) {
>>                 err = ops->map_alloc_check(attr);
>> @@ -1399,13 +1429,20 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>         }
>>         if (attr->map_ifindex)
>>                 ops = &bpf_map_offload_ops;
>> -       if (!ops->map_mem_usage)
>> -               return -EINVAL;
>> +       if (!ops->map_mem_usage) {
>> +               bpf_log(log, "map_mem_usage is required.\n");
>
>
> this is kernel bug, actually, so let's log "bug: " prefix? same above
> with the second "Invalid map_type." message?
>
> and actually, given these are kernel bugs and shouldn't happen, I
> wonder if we should log anything here at all?
>

As it's a kernel bug if no map_mem_usage, would it be better to
WARN_ONCE here instead of reporting a log?

>> +               err = -EINVAL;
>> +               goto put_token;

It'll be changed to the new label.

>> +       }
>>
>>         if (token_flag) {
>>                 token = bpf_token_get_from_fd(attr->map_token_fd);
>> -               if (IS_ERR(token))
>> -                       return PTR_ERR(token);
>> +               if (IS_ERR(token)) {
>> +                       bpf_log(log, "Invalid map_token_fd.\n");
>> +                       err = PTR_ERR(token);
>> +                       token = NULL;
>> +                       goto put_token;
>
> ditto, no token
>

It'll be changed to the new label.

>> +               }
>>
>>                 /* if current token doesn't grant map creation permissions,
>>                  * then we can't use this token, so ignore it and rely on
>> @@ -1487,8 +1524,10 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>
>>         err = bpf_obj_name_cpy(map->name, attr->map_name,
>>                                sizeof(attr->map_name));
>> -       if (err < 0)
>> +       if (err < 0) {
>> +               bpf_log(log, "Invalid map_name.\n");
>>                 goto free_map;
>> +       }
>>
>>         preempt_disable();
>>         map->cookie = gen_cookie_next(&bpf_map_cookie);
>> @@ -1511,6 +1550,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>
>>                 btf = btf_get_by_fd(attr->btf_fd);
>>                 if (IS_ERR(btf)) {
>> +                       bpf_log(log, "Invalid btf_fd.\n");
>>                         err = PTR_ERR(btf);
>>                         goto free_map;
>>                 }
>> @@ -1565,6 +1605,10 @@ static int map_create(union bpf_attr *attr, bool kernel)
>>         bpf_map_free(map);
>>  put_token:
>>         bpf_token_put(token);
>> +       if (err && log)
>> +               (void) bpf_vlog_finalize(log, &log_true_size);
>
> so we'll just drop this size on the floor and never report it to the user?
>
>
> a) let's either teach bpf_vlog_finalize that log_true_size pointer can
> be NULL (and optional),
> or b) let's report it back to user through that same commont_attrs
> struct, just like we do it for verifier and btf logs?
>

Reporting it back to user looks better to me.

>
> Also, what if complicating error handling with this goto jumping, can
> we make use of __cleanup() attribute to do this automatically? Then
> we'd just allocate (or see above, maybe just init on the stack) log
> struct, and declare it with cleanup callback that will do this
> vlog_finalize and, maybe, report back the log actual size?
>

It does seem feasible to simplify error handling with __cleanup().

Instead of initializing log directly on the stack, we could introduce a
small wrapper:

struct bpf_log_wrapper {
    struct bpf_verifier_log *log;
};

with a destructor:

static void bpf_log_wrapper_destructor(struct bpf_log_wrapper *w)
{
    u32 log_true_size;

    if (w->log) {
        (void) bpf_vlog_finalize(w->log, &log_true_size);
        kfree(w->log);
    }
}

In this demo snippet I skipped handling log_true_size, but in practice
it should be dealt with properly.

Then, for example, in map_create():

struct bpf_log_wrapper log_wrapper __cleanup(bpf_log_wrapper_destructor)
= {};

if (common_attrs->log_buf) {
    log_wrapper.log = kzalloc(...);
}

I’ll give this approach a try in the next revision.

Thanks,
Leon

