Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3F62609D
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKKRnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 12:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKRnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 12:43:22 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7461B84
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:43:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3697bd55974so49896177b3.15
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vtn8TTYosZ7+OJKOJxsEeTOMiWcqvq7rhY9Vwj9ZEg=;
        b=kTpiGYXCUiUfSy5CL3w/TH4m1K+/lhHz0zYmIgWSk/L9oJwJHvY/2D7kUQu2Swgygx
         fA81nCGV7ZVBeGFLG+H6enn/0c18MIrjGkP0AjESLlBOpfT1Z62b3rX6Rp3GFKUmsLXO
         K+DGo3rUx1Yyga9x634X7lz07tctVQa2aVBg16x2G2B15YV0e+phsrpfRPJDhgjtSeiL
         24W/GOfSPksQzxvD9nwzufezOaeHeLe0Dewzx+y4RR9ip680owFbIENbOa5Xd1nQvTqA
         fMP4G+/FgeAO0HQzEGinq4pT4Zr+o/4PT1L8tMn048G6XL1sWgsZQ2Nchs/OaY4d6LOv
         nEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vtn8TTYosZ7+OJKOJxsEeTOMiWcqvq7rhY9Vwj9ZEg=;
        b=y50CW3yyEMKW2mzyoLSZnPjkaPFyJzRBgqH/ufxmDcttzXinJLj2SWlUScjUXpOs/z
         x4AgpV/ReS+Bau+VnsxKJho6IxZSgU8zM62ro4/cCAazc5/3MNTdOOX0WMVLSnupz0c1
         3fzZBQ3zWopXSAozMkOaCOEof6QD2I/4vPNRPXkYwPnbtMBfnJys5e45e0+L/KEp0zYc
         Drn6TDt6TuTdfsVsJuBbVtmPzfx/13sCioLG4oVgO5dopfTGn3WlGTS9OUP+y6MJ2OFQ
         P7Sj9QImT0rkmPzHrNrCzmnlOl4i0wwAhQRLDdIAirTFHj2nBtjNiDIokKXFSL218v7X
         z9hQ==
X-Gm-Message-State: ANoB5pk9VhVLtbux37g6aP2/d+3mrTJluypJzvV9oazEKvNdG8ied7zP
        KfYjNsjgeOtBiNPHeq9yLWJpZIA=
X-Google-Smtp-Source: AA0mqf4HbnZXhuUut+uIA66PgxAZe7xc+KBqc6wLnehPqoCjXZi54GouHrgV4SWbxnwhP3HWWBOpnYI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:cf54:0:b0:6d3:be:6247 with SMTP id
 f81-20020a25cf54000000b006d300be6247mr2802948ybg.79.1668188600500; Fri, 11
 Nov 2022 09:43:20 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:43:18 -0800
In-Reply-To: <20221111080757.2224969-1-houtao@huaweicloud.com>
Mime-Version: 1.0
References: <20221111080757.2224969-1-houtao@huaweicloud.com>
Message-ID: <Y26JtknJKjnD+dsu@google.com>
Subject: Re: [PATCH bpf-next v2] bpf: Pass map file to .map_update_batch directly
From:   sdf@google.com
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, houtao1@huawei.com
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

On 11/11, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>

> Currently bpf_map_do_batch() first invokes fdget(batch.map_fd) to get
> the target map file, then it invokes generic_map_update_batch() to do
> batch update. generic_map_update_batch() will get the target map file
> by using fdget(batch.map_fd) again and pass it to
> bpf_map_update_value().

> The problem is map file returned by the second fdget() may be NULL or a
> totally different file compared by map file in bpf_map_do_batch(). The
> reason is that the first fdget() only guarantees the liveness of struct
> file instead of file descriptor and the file description may be released
> by concurrent close() through pick_file().

> It doesn't incur any problem as for now, because maps with batch update
> support don't use map file in .map_fd_get_ptr() ops. But it is better to
> fix the access of a potentially invalid map file.

> using __bpf_map_get() again in generic_map_update_batch() can not fix
> the problem, because batch.map_fd may be closed and reopened, and the
> returned map file may be different with map file got in
> bpf_map_do_batch(), so just passing the map file directly to
> .map_update_batch() in bpf_map_do_batch().

> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
> v2:
>   * rewrite the commit message to explain the problem and the reasoning.
> v1:  
> https://lore.kernel.org/bpf/20221107075537.1445644-1-houtao@huaweicloud.com

>   include/linux/bpf.h  |  5 +++--
>   kernel/bpf/syscall.c | 31 ++++++++++++++++++-------------
>   2 files changed, 21 insertions(+), 15 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 798aec816970..20cfe88ee6df 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -85,7 +85,8 @@ struct bpf_map_ops {
>   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>   					   const union bpf_attr *attr,
>   					   union bpf_attr __user *uattr);
> -	int (*map_update_batch)(struct bpf_map *map, const union bpf_attr *attr,
> +	int (*map_update_batch)(struct bpf_map *map, struct file *map_file,
> +				const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
>   	int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
> @@ -1776,7 +1777,7 @@ void bpf_map_init_from_attr(struct bpf_map *map,  
> union bpf_attr *attr);
>   int  generic_map_lookup_batch(struct bpf_map *map,
>   			      const union bpf_attr *attr,
>   			      union bpf_attr __user *uattr);
> -int  generic_map_update_batch(struct bpf_map *map,
> +int  generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   			      const union bpf_attr *attr,
>   			      union bpf_attr __user *uattr);
>   int  generic_map_delete_batch(struct bpf_map *map,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 85532d301124..cb8a87277bf8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -175,8 +175,8 @@ static void maybe_wait_bpf_programs(struct bpf_map  
> *map)
>   		synchronize_rcu();
>   }

> -static int bpf_map_update_value(struct bpf_map *map, struct fd f, void  
> *key,
> -				void *value, __u64 flags)
> +static int bpf_map_update_value(struct bpf_map *map, struct file  
> *map_file,
> +				void *key, void *value, __u64 flags)
>   {
>   	int err;

> @@ -190,7 +190,7 @@ static int bpf_map_update_value(struct bpf_map *map,  
> struct fd f, void *key,
>   		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
>   		return sock_map_update_elem_sys(map, key, value, flags);
>   	} else if (IS_FD_PROG_ARRAY(map)) {
> -		return bpf_fd_array_map_update_elem(map, f.file, key, value,
> +		return bpf_fd_array_map_update_elem(map, map_file, key, value,
>   						    flags);
>   	}

> @@ -205,12 +205,12 @@ static int bpf_map_update_value(struct bpf_map  
> *map, struct fd f, void *key,
>   						       flags);
>   	} else if (IS_FD_ARRAY(map)) {
>   		rcu_read_lock();
> -		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
> +		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
>   						   flags);
>   		rcu_read_unlock();
>   	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
>   		rcu_read_lock();
> -		err = bpf_fd_htab_map_update_elem(map, f.file, key, value,
> +		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
>   						  flags);
>   		rcu_read_unlock();
>   	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
> @@ -1390,7 +1390,7 @@ static int map_update_elem(union bpf_attr *attr,  
> bpfptr_t uattr)
>   		goto free_key;
>   	}

> -	err = bpf_map_update_value(map, f, key, value, attr->flags);
> +	err = bpf_map_update_value(map, f.file, key, value, attr->flags);

>   	kvfree(value);
>   free_key:
> @@ -1576,16 +1576,14 @@ int generic_map_delete_batch(struct bpf_map *map,
>   	return err;
>   }

> -int generic_map_update_batch(struct bpf_map *map,
> +int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   			     const union bpf_attr *attr,
>   			     union bpf_attr __user *uattr)
>   {
>   	void __user *values = u64_to_user_ptr(attr->batch.values);
>   	void __user *keys = u64_to_user_ptr(attr->batch.keys);
>   	u32 value_size, cp, max_count;
> -	int ufd = attr->batch.map_fd;
>   	void *key, *value;
> -	struct fd f;
>   	int err = 0;

>   	if (attr->batch.elem_flags & ~BPF_F_LOCK)
> @@ -1612,7 +1610,6 @@ int generic_map_update_batch(struct bpf_map *map,
>   		return -ENOMEM;
>   	}

> -	f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
>   	for (cp = 0; cp < max_count; cp++) {
>   		err = -EFAULT;
>   		if (copy_from_user(key, keys + cp * map->key_size,
> @@ -1620,7 +1617,7 @@ int generic_map_update_batch(struct bpf_map *map,
>   		    copy_from_user(value, values + cp * value_size, value_size))
>   			break;

> -		err = bpf_map_update_value(map, f, key, value,
> +		err = bpf_map_update_value(map, map_file, key, value,
>   					   attr->batch.elem_flags);

>   		if (err)
> @@ -1633,7 +1630,6 @@ int generic_map_update_batch(struct bpf_map *map,

>   	kvfree(value);
>   	kvfree(key);
> -	fdput(f);
>   	return err;
>   }

> @@ -4435,6 +4431,15 @@ static int bpf_task_fd_query(const union bpf_attr  
> *attr,
>   		err = fn(map, attr, uattr);	\
>   	} while (0)


[..]

> +#define BPF_DO_BATCH_WITH_FILE(fn)			\
> +	do {						\
> +		if (!fn) {				\
> +			err = -ENOTSUPP;		\
> +			goto err_put;			\
> +		}					\
> +		err = fn(map, f.file, attr, uattr);	\
> +	} while (0)
> +

nit: probably not worth defining this for a single user? but not sure
it matters..

>   static int bpf_map_do_batch(const union bpf_attr *attr,
>   			    union bpf_attr __user *uattr,
>   			    int cmd)
> @@ -4470,7 +4475,7 @@ static int bpf_map_do_batch(const union bpf_attr  
> *attr,
>   	else if (cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH)
>   		BPF_DO_BATCH(map->ops->map_lookup_and_delete_batch);
>   	else if (cmd == BPF_MAP_UPDATE_BATCH)
> -		BPF_DO_BATCH(map->ops->map_update_batch);
> +		BPF_DO_BATCH_WITH_FILE(map->ops->map_update_batch);
>   	else
>   		BPF_DO_BATCH(map->ops->map_delete_batch);
>   err_put:
> --
> 2.29.2

