Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2718269746D
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 03:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBOCjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 21:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBOCju (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 21:39:50 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DA279BA
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:39:48 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u18-20020a62ed12000000b00593cc641da4so8836607pfh.0
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjPSL1cxx2b4t+KSujbD5CBLKNWpK4Wwy608Fi/Tmto=;
        b=mjb9Uh+GGEvRDBahi2iVhGUlrZYZNcoaw0bFh0wIvP7FX297gD0B+Zg1bM9fZhkmRV
         /6cZFNHLDYWH1l8j7/XLTwM8D5QAISm39lhCOp0v5fnkKdzAjT08UT62UjL2NL8+gPaW
         0as85Qc+1AYu6qKptuKe+EwGJziUJ1SP/3MH9rwlWli7ESwhbLujfkPxC0cWpwMf3GlD
         CfxtmrggIjSVAAVgkG26U9W2VebW5aLUB9vujnVfk8iWxBDJnqUwNSVsDr21eRfGacKM
         XgPd14I0xQ3b+ZN4qP+jpYC7gFStH5GE9M2lZA8VE55osxk5LIGPUGtvk/gWF5OLSj87
         3yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjPSL1cxx2b4t+KSujbD5CBLKNWpK4Wwy608Fi/Tmto=;
        b=J3+vzed1so9m9092G1mOSkVLuAhwAyEO9telgQLKZcfoxn15XTRcK9P9FqOJc8ZdY2
         BGpeFbwFdLdKi0U69jnIvicB92i2gViR5IWPpcfT0APbKlXi0bTkaV3QteMzwGQmZXvg
         eURJM9P4j7fRTESLqe4UqXPcGV9YOrUljjdPgmgoiczFzWc9qgQNiCifpf7bxFf7eR3P
         1Gm29RLW8N++a+UYW6pVpVYipvwLU8SBx4A0lQn6kRqqAGMYMcy9rirgx6sEgRPU66pq
         zUx4zeulCFmnWUs/qGrAYlQrjEdJ6snFr3oOZPaDzYUuIBAiVrBdcRziWNSEgJnw0RZa
         HLtg==
X-Gm-Message-State: AO0yUKXAWoJFhwloB6YlEP1lXei6Z1EwZUV53achw3jXyGX0knnBn5dZ
        mySHITxVvTnhzst5FcfuaGhseq4=
X-Google-Smtp-Source: AK7set9gfWdx9soMLn2dFVW28uVEqYm1XQuL8Hnx4jVEivHeDLBs13Jc81Hy2dvF5+iA1u1359ZajhU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3d48:0:b0:4fb:9276:8c80 with SMTP id
 k69-20020a633d48000000b004fb92768c80mr155200pga.5.1676428787626; Tue, 14 Feb
 2023 18:39:47 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:39:46 -0800
In-Reply-To: <20230214221718.503964-2-kuifeng@meta.com>
Mime-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-2-kuifeng@meta.com>
Message-ID: <Y+xF8k8RMiG0xBDY@google.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
From:   Stanislav Fomichev <sdf@google.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/14, Kui-Feng Lee wrote:
> BPF struct_ops maps are employed directly to register TCP Congestion
> Control algorithms. Unlike other BPF programs that terminate when
> their links gone, the struct_ops program reduces its refcount solely
> upon death of its FD. The link of a BPF struct_ops map provides a
> uniform experience akin to other types of BPF programs.  A TCP
> Congestion Control algorithm will be unregistered upon destroying the
> FD in the following patches.

> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   include/linux/bpf.h            |  6 +++-
>   include/uapi/linux/bpf.h       |  4 +++
>   kernel/bpf/bpf_struct_ops.c    | 66 ++++++++++++++++++++++++++++++++++
>   kernel/bpf/syscall.c           | 29 ++++++++++-----
>   tools/include/uapi/linux/bpf.h |  4 +++
>   tools/lib/bpf/bpf.c            |  2 ++
>   tools/lib/bpf/libbpf.c         |  1 +
>   7 files changed, 102 insertions(+), 10 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8b5d0b4c4ada..13683584b071 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1391,7 +1391,11 @@ struct bpf_link {
>   	u32 id;
>   	enum bpf_link_type type;
>   	const struct bpf_link_ops *ops;
> -	struct bpf_prog *prog;

[..]

> +	union {
> +		struct bpf_prog *prog;
> +		/* Backed by a struct_ops (type == BPF_LINK_UPDATE_STRUCT_OPS) */
> +		struct bpf_map *map;
> +	};

Any reason you're not using the approach that has been used for other
links where we create a wrapping structure + container_of?

struct bpt_struct_ops_link {
	struct bpf_link link;
	struct bpf_map *map;
};

>   	struct work_struct work;
>   };

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 17afd2b35ee5..1e6cdd0f355d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>   	BPF_PERF_EVENT,
>   	BPF_TRACE_KPROBE_MULTI,
>   	BPF_LSM_CGROUP,
> +	BPF_STRUCT_OPS_MAP,
>   	__MAX_BPF_ATTACH_TYPE
>   };

> @@ -6354,6 +6355,9 @@ struct bpf_link_info {
>   		struct {
>   			__u32 ifindex;
>   		} xdp;
> +		struct {
> +			__u32 map_id;
> +		} struct_ops_map;
>   	};
>   } __attribute__((aligned(8)));

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
> +static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link  
> *link,
> +					    struct seq_file *seq)
> +{
> +	seq_printf(seq, "map_id:\t%d\n",
> +		  link->map->id);
> +}
> +
> +static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link  
> *link,
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
> +
> +int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
> +{

[..]

> +	struct bpf_link_primer link_primer;
> +	struct bpf_map *map;
> +	struct bpf_link *link = NULL;

Are we still trying to keep reverse christmas trees?

> +	int err;
> +
> +	map = bpf_map_get(attr->link_create.prog_fd);

bpf_map_get can fail here?

> +	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
> +		return -EINVAL;
> +
> +	link = kzalloc(sizeof(*link), GFP_USER);
> +	if (!link) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops,  
> NULL);
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
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cda8d00f3762..54e172d8f5d1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2738,7 +2738,9 @@ static void bpf_link_free(struct bpf_link *link)
>   	if (link->prog) {
>   		/* detach BPF program, clean up used resources */
>   		link->ops->release(link);
> -		bpf_prog_put(link->prog);
> +		if (link->type != BPF_LINK_TYPE_STRUCT_OPS)
> +			bpf_prog_put(link->prog);
> +		/* The struct_ops links clean up map by them-selves. */

Why not more generic:

if (link->prog)
	bpf_prog_put(link->prog);

?


>   	}
>   	/* free bpf_link and its containing memory */
>   	link->ops->dealloc(link);
> @@ -2794,16 +2796,19 @@ static void bpf_link_show_fdinfo(struct seq_file  
> *m, struct file *filp)
>   	const struct bpf_prog *prog = link->prog;
>   	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };

> -	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>   	seq_printf(m,
>   		   "link_type:\t%s\n"
> -		   "link_id:\t%u\n"
> -		   "prog_tag:\t%s\n"
> -		   "prog_id:\t%u\n",
> +		   "link_id:\t%u\n",
>   		   bpf_link_type_strs[link->type],
> -		   link->id,
> -		   prog_tag,
> -		   prog->aux->id);
> +		   link->id);
> +	if (link->type != BPF_LINK_TYPE_STRUCT_OPS) {
> +		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> +		seq_printf(m,
> +			   "prog_tag:\t%s\n"
> +			   "prog_id:\t%u\n",
> +			   prog_tag,
> +			   prog->aux->id);
> +	}
>   	if (link->ops->show_fdinfo)
>   		link->ops->show_fdinfo(link, m);
>   }
> @@ -4278,7 +4283,8 @@ static int bpf_link_get_info_by_fd(struct file  
> *file,

>   	info.type = link->type;
>   	info.id = link->id;
> -	info.prog_id = link->prog->aux->id;
> +	if (link->type != BPF_LINK_TYPE_STRUCT_OPS)
> +		info.prog_id = link->prog->aux->id;

Here as well: should we have "link->type != BPF_LINK_TYPE_STRUCT_OPS" vs
"link->prog != NULL" ?


>   	if (link->ops->fill_link_info) {
>   		err = link->ops->fill_link_info(link, &info);
> @@ -4531,6 +4537,8 @@ static int bpf_map_do_batch(const union bpf_attr  
> *attr,
>   	return err;
>   }

> +extern int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t  
> uattr);
> +
>   #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
>   static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   {
> @@ -4541,6 +4549,9 @@ static int link_create(union bpf_attr *attr,  
> bpfptr_t uattr)
>   	if (CHECK_ATTR(BPF_LINK_CREATE))
>   		return -EINVAL;

> +	if (attr->link_create.attach_type == BPF_STRUCT_OPS_MAP)
> +		return link_create_struct_ops_map(attr, uattr);
> +
>   	prog = bpf_prog_get(attr->link_create.prog_fd);
>   	if (IS_ERR(prog))
>   		return PTR_ERR(prog);
> diff --git a/tools/include/uapi/linux/bpf.h  
> b/tools/include/uapi/linux/bpf.h
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

> @@ -6354,6 +6355,9 @@ struct bpf_link_info {
>   		struct {
>   			__u32 ifindex;
>   		} xdp;
> +		struct {
> +			__u32 map_id;
> +		} struct_ops_map;
>   	};
>   } __attribute__((aligned(8)));

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9aff98f42a3d..e44d49f17c86 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
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

>   static const char * const link_type_name[] = {
> --
> 2.30.2

