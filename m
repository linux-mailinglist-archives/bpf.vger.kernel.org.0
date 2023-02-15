Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D6698826
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 23:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBOW6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 17:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBOW6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 17:58:44 -0500
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC7868C
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 14:58:42 -0800 (PST)
Message-ID: <ff8faacb-c972-9698-61da-1ecfa077d716@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676501921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE+zSo+fMINVzI5bHYXXMd0bAJC5Un5aQSXsJj3BSnw=;
        b=XeIX+wrg6nXUjex1oR0DD8+vRKFWyLvjAoakCh27a3+JoSTBxzNmwWf2O1+NWL0iHw2P/V
        RC7xrYtbIlExOJEhVq0b+sT7f5sQczEP3mMcg+3xy4v4be+2HznsC3YoEnPlXxB6dhPej7
        aQ8NJwRCNb0VHsKLIIXW8hie6cyIn7E=
Date:   Wed, 15 Feb 2023 14:58:34 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-2-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
In-Reply-To: <20230214221718.503964-2-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/14/23 2:17 PM, Kui-Feng Lee wrote:
> BPF struct_ops maps are employed directly to register TCP Congestion
> Control algorithms. Unlike other BPF programs that terminate when
> their links gone, the struct_ops program reduces its refcount solely
> upon death of its FD. 

I think the refcount comment probably not needed for this patch.

> The link of a BPF struct_ops map provides a
> uniform experience akin to other types of BPF programs.  A TCP
> Congestion Control algorithm will be unregistered upon destroying the
> FD in the following patches.


> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 17afd2b35ee5..1e6cdd0f355d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

The existing BPF_LINK_TYPE_STRUCT_OPS enum is reused. Please explain why it can 
be reused in the commit message and also add comments around the existing 
"bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS...)" in 
bpf_struct_ops_map_update_elem().

> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>   	BPF_PERF_EVENT,
>   	BPF_TRACE_KPROBE_MULTI,
>   	BPF_LSM_CGROUP,
> +	BPF_STRUCT_OPS_MAP,

nit. Only BPF_STRUCT_OPS. No need for "_MAP".

>   	__MAX_BPF_ATTACH_TYPE
>   };
>   
> @@ -6354,6 +6355,9 @@ struct bpf_link_info {
>   		struct {
>   			__u32 ifindex;
>   		} xdp;
> +		struct {
> +			__u32 map_id;
> +		} struct_ops_map;

nit. Same here, skip the "_map";

This looks good instead of union. In case the user space tool directly uses the 
prog_id without checking the type.

>   	};
>   } __attribute__((aligned(8)));
>   
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index ece9870cab68..621c8e24481a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -698,3 +698,69 @@ void bpf_struct_ops_put(const void *kdata)
>   		call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
>   	}
>   }
> +
> +static void bpf_struct_ops_map_link_release(struct bpf_link *link)
> +{
> +	if (link->map) {
> +		bpf_map_put(link->map);
> +		link->map = NULL;
> +	}
> +}
> +
> +static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
> +{
> +	kfree(link);
> +}
> +
> +static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
> +					    struct seq_file *seq)
> +{
> +	seq_printf(seq, "map_id:\t%d\n",
> +		  link->map->id);
> +}
> +
> +static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
> +					       struct bpf_link_info *info)
> +{
> +	info->struct_ops_map.map_id = link->map->id;
> +	return 0;
> +}
> +
> +static const struct bpf_link_ops bpf_struct_ops_map_lops = {
> +	.release = bpf_struct_ops_map_link_release,
> +	.dealloc = bpf_struct_ops_map_link_dealloc,
> +	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
> +	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
> +};

Can .detach be supported also?

> +
> +int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)

Does it need uattr?

nit. Rename to bpf_struct_ops_link_attach(), like how other link type's "attach" 
functions are named. or may be even just bpf_struct_ops_attach().

> +{
> +	struct bpf_link_primer link_primer;
> +	struct bpf_map *map;
> +	struct bpf_link *link = NULL;
> +	int err;
> +
> +	map = bpf_map_get(attr->link_create.prog_fd);

This one looks weird. passing prog_fd to bpf_map_get(). I think in this case it 
makes sense to union map_fd with prog_fd in attr->link_create ?

> +	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)

map is leaked.

> +		return -EINVAL;
> +
> +	link = kzalloc(sizeof(*link), GFP_USER);
> +	if (!link) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
> +	link->map = map;
> +
> +	err = bpf_link_prime(link, &link_primer);
> +	if (err)
> +		goto err_out;
> +
> +	return bpf_link_settle(&link_primer);
> +
> +err_out:
> +	bpf_map_put(map);
> +	kfree(link);
> +	return err;
> +}
> +

[ ... ]

> +extern int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr);

Move it to bpf.h.

> +
>   #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
>   static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   {
> @@ -4541,6 +4549,9 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   	if (CHECK_ATTR(BPF_LINK_CREATE))
>   		return -EINVAL;
>   
> +	if (attr->link_create.attach_type == BPF_STRUCT_OPS_MAP)
> +		return link_create_struct_ops_map(attr, uattr);
> +
>   	prog = bpf_prog_get(attr->link_create.prog_fd);
>   	if (IS_ERR(prog))
>   		return PTR_ERR(prog);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 17afd2b35ee5..1e6cdd0f355d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>   	BPF_PERF_EVENT,
>   	BPF_TRACE_KPROBE_MULTI,
>   	BPF_LSM_CGROUP,
> +	BPF_STRUCT_OPS_MAP,
>   	__MAX_BPF_ATTACH_TYPE
>   };
>   
> @@ -6354,6 +6355,9 @@ struct bpf_link_info {
>   		struct {
>   			__u32 ifindex;
>   		} xdp;
> +		struct {
> +			__u32 map_id;
> +		} struct_ops_map;
>   	};
>   } __attribute__((aligned(8)));
>   
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9aff98f42a3d..e44d49f17c86 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

Not necessary in this set and could be a follow up. Have you thought about how 
to generate a skel including the struct_ops link?

> @@ -731,6 +731,8 @@ int bpf_link_create(int prog_fd, int target_fd,
>   		if (!OPTS_ZEROED(opts, tracing))
>   			return libbpf_err(-EINVAL);
>   		break;
> +	case BPF_STRUCT_OPS_MAP:
> +		break;
>   	default:
>   		if (!OPTS_ZEROED(opts, flags))
>   			return libbpf_err(-EINVAL);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 35a698eb825d..75ed95b7e455 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
>   	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_reuseport_select_or_migrate",
>   	[BPF_PERF_EVENT]		= "perf_event",
>   	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
> +	[BPF_STRUCT_OPS_MAP]		= "struct_ops_map",
>   };
>   
>   static const char * const link_type_name[] = {

