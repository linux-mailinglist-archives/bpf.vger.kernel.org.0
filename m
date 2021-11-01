Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC569441DA8
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 17:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhKAQD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhKAQD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 12:03:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E9C061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 09:01:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so1176207plf.4
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1xIYPSotiL288wgXHkekaZY9mBYegw/cLVKFpQzJ/CY=;
        b=Tx3AMgRNGkJQAPKNFDZU2DuXCeEXWHtNpwtc1oZkT5z7PRloanmNkcKOVv34+lsHrm
         uUvdldlzvG2rb/v//1O8H/7WYzN3tvTIAoBPpjb4ljs/deoYnvIHrphtjc7e9w1/fQG2
         UMfvxjSQY+TA8z2PM6wHK+iAN/qWpgl2fVxvmdEKba4vwOMm88x3Wpvz7xQHLW4pqZA8
         G3cbLAtg/319wmARX6AUuzIY4JG/mKSFgNbePIsZzUswfOPcxaKFnHN1OJkuWwXrqMD+
         ua6e1mbqXo9ykSNH1fRvACuTw+ZtZ6meE94kNJx+P7/f0V6Pf6dEbFqWMzGrNUgZ5AdK
         uYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1xIYPSotiL288wgXHkekaZY9mBYegw/cLVKFpQzJ/CY=;
        b=I7DKJZXQR+LXz9jJ4txYkIXEIDQO/xa8S5rpdJal+Yxw8J/tNe9RWGN+BgZ0HfwAqD
         b7jb4O1cLt5410YD1WnCZMZZf8KE8n93oz14WmzxIS6wu3T8+yxc2pvR1WU5DKVl92VF
         nUordvn1ETajCyMioIQse/RFD3M38c5DMiQ4JLyv8Lf8NuAejsB/zIbLYMqg9rVHplSg
         XWle+yk13QnhzhoZEMC0lnc50F0Yav47EuTwFHWAtWUhvwTTHFusfmlO6UNZFDgQeV2f
         tV/29/nd+Hg5r84dO+CwMAlyH20hU6U1CtrogWgD75OLCYtMHa4K6VjlvghlthrTVAPi
         MWlg==
X-Gm-Message-State: AOAM530SaRYI3FED4TG8v01SW/zO6izOmTutqbBOTzszUCDT84hyGiK5
        peHWLONg++llCJWlqGrbKrk=
X-Google-Smtp-Source: ABdhPJwXUhJLZ/cYK5hih20u4BEfTz23s1ikqTM1q7tMoHsGKrRB8eKEvDyaTHWhDayS/dJ9xeXjWA==
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr30764816pjq.106.1635782485047;
        Mon, 01 Nov 2021 09:01:25 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id j8sm17068896pfu.27.2021.11.01.09.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 09:01:24 -0700 (PDT)
Message-ID: <de592464-480a-ea1f-4702-c275f19f9585@gmail.com>
Date:   Tue, 2 Nov 2021 00:01:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 02/14] libbpf: add bpf() syscall wrapper into
 public API
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20211030045941.3514948-1-andrii@kernel.org>
 <20211030045941.3514948-3-andrii@kernel.org>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <20211030045941.3514948-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/10/30 12:59 PM, Andrii Nakryiko wrote:
> Move internal sys_bpf() helper into bpf.h and expose as public API.
> __NR_bpf definition logic is also moved. Renamed sys_bpf() into bpf() to
> follow libbpf naming conventions. Adapt internal uses accordingly.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/bpf.c | 76 ++++++++++++++-------------------------------
>  tools/lib/bpf/bpf.h | 30 ++++++++++++++++++
>  2 files changed, 54 insertions(+), 52 deletions(-)
> 

A little confuse about this public API. Shouldn't it be annotated with
LIBBPF_API attribute and go into libbpf.map ?

BTW, these headers can now be removed from bpf.c:

  #include <stdlib.h>
  #include <string.h>
  #include <memory.h>
  #include <unistd.h>
  #include <asm/unistd.h>
  #include <errno.h>
  #include <linux/bpf.h>
  #include "libbpf.h"


> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index c09cbb868c9f..4b4fd2dae3bf 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -32,45 +32,17 @@
>  #include "libbpf.h"
>  #include "libbpf_internal.h"
>  
> -/*
> - * When building perf, unistd.h is overridden. __NR_bpf is
> - * required to be defined explicitly.
> - */
> -#ifndef __NR_bpf
> -# if defined(__i386__)
> -#  define __NR_bpf 357
> -# elif defined(__x86_64__)
> -#  define __NR_bpf 321
> -# elif defined(__aarch64__)
> -#  define __NR_bpf 280
> -# elif defined(__sparc__)
> -#  define __NR_bpf 349
> -# elif defined(__s390__)
> -#  define __NR_bpf 351
> -# elif defined(__arc__)
> -#  define __NR_bpf 280
> -# else
> -#  error __NR_bpf not defined. libbpf does not support your arch.
> -# endif
> -#endif
> -
>  static inline __u64 ptr_to_u64(const void *ptr)
>  {
>  	return (__u64) (unsigned long) ptr;
>  }
>  
> -static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> -			  unsigned int size)
> -{
> -	return syscall(__NR_bpf, cmd, attr, size);
> -}
> -
>  static inline int sys_bpf_fd(enum bpf_cmd cmd, union bpf_attr *attr,
>  			     unsigned int size)
>  {
>  	int fd;
>  
> -	fd = sys_bpf(cmd, attr, size);
> +	fd = bpf(cmd, attr, size);
>  	return ensure_good_fd(fd);
>  }
>  
> @@ -465,7 +437,7 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
>  	attr.value = ptr_to_u64(value);
>  	attr.flags = flags;
>  
> -	ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
> +	ret = bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -479,7 +451,7 @@ int bpf_map_lookup_elem(int fd, const void *key, void *value)
>  	attr.key = ptr_to_u64(key);
>  	attr.value = ptr_to_u64(value);
>  
> -	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
> +	ret = bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -494,7 +466,7 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
>  	attr.value = ptr_to_u64(value);
>  	attr.flags = flags;
>  
> -	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
> +	ret = bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -508,7 +480,7 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
>  	attr.key = ptr_to_u64(key);
>  	attr.value = ptr_to_u64(value);
>  
> -	ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
> +	ret = bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -522,7 +494,7 @@ int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, _
>  	attr.value = ptr_to_u64(value);
>  	attr.flags = flags;
>  
> -	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
> +	return bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
>  }
>  
>  int bpf_map_delete_elem(int fd, const void *key)
> @@ -534,7 +506,7 @@ int bpf_map_delete_elem(int fd, const void *key)
>  	attr.map_fd = fd;
>  	attr.key = ptr_to_u64(key);
>  
> -	ret = sys_bpf(BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
> +	ret = bpf(BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -548,7 +520,7 @@ int bpf_map_get_next_key(int fd, const void *key, void *next_key)
>  	attr.key = ptr_to_u64(key);
>  	attr.next_key = ptr_to_u64(next_key);
>  
> -	ret = sys_bpf(BPF_MAP_GET_NEXT_KEY, &attr, sizeof(attr));
> +	ret = bpf(BPF_MAP_GET_NEXT_KEY, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -560,7 +532,7 @@ int bpf_map_freeze(int fd)
>  	memset(&attr, 0, sizeof(attr));
>  	attr.map_fd = fd;
>  
> -	ret = sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
> +	ret = bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -585,7 +557,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>  	attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
>  	attr.batch.flags = OPTS_GET(opts, flags, 0);
>  
> -	ret = sys_bpf(cmd, &attr, sizeof(attr));
> +	ret = bpf(cmd, &attr, sizeof(attr));
>  	*count = attr.batch.count;
>  
>  	return libbpf_err_errno(ret);
> @@ -631,7 +603,7 @@ int bpf_obj_pin(int fd, const char *pathname)
>  	attr.pathname = ptr_to_u64((void *)pathname);
>  	attr.bpf_fd = fd;
>  
> -	ret = sys_bpf(BPF_OBJ_PIN, &attr, sizeof(attr));
> +	ret = bpf(BPF_OBJ_PIN, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -674,7 +646,7 @@ int bpf_prog_attach_xattr(int prog_fd, int target_fd,
>  	attr.attach_flags  = OPTS_GET(opts, flags, 0);
>  	attr.replace_bpf_fd = OPTS_GET(opts, replace_prog_fd, 0);
>  
> -	ret = sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -687,7 +659,7 @@ int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
>  	attr.target_fd	 = target_fd;
>  	attr.attach_type = type;
>  
> -	ret = sys_bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -701,7 +673,7 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
>  	attr.attach_bpf_fd = prog_fd;
>  	attr.attach_type = type;
>  
> -	ret = sys_bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -766,7 +738,7 @@ int bpf_link_detach(int link_fd)
>  	memset(&attr, 0, sizeof(attr));
>  	attr.link_detach.link_fd = link_fd;
>  
> -	ret = sys_bpf(BPF_LINK_DETACH, &attr, sizeof(attr));
> +	ret = bpf(BPF_LINK_DETACH, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -785,7 +757,7 @@ int bpf_link_update(int link_fd, int new_prog_fd,
>  	attr.link_update.flags = OPTS_GET(opts, flags, 0);
>  	attr.link_update.old_prog_fd = OPTS_GET(opts, old_prog_fd, 0);
>  
> -	ret = sys_bpf(BPF_LINK_UPDATE, &attr, sizeof(attr));
> +	ret = bpf(BPF_LINK_UPDATE, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
>  
> @@ -814,7 +786,7 @@ int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
>  	attr.query.prog_cnt	= *prog_cnt;
>  	attr.query.prog_ids	= ptr_to_u64(prog_ids);
>  
> -	ret = sys_bpf(BPF_PROG_QUERY, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_QUERY, &attr, sizeof(attr));
>  
>  	if (attach_flags)
>  		*attach_flags = attr.query.attach_flags;
> @@ -837,7 +809,7 @@ int bpf_prog_test_run(int prog_fd, int repeat, void *data, __u32 size,
>  	attr.test.data_size_in = size;
>  	attr.test.repeat = repeat;
>  
> -	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
>  
>  	if (size_out)
>  		*size_out = attr.test.data_size_out;
> @@ -869,7 +841,7 @@ int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr)
>  	attr.test.ctx_size_out = test_attr->ctx_size_out;
>  	attr.test.repeat = test_attr->repeat;
>  
> -	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
>  
>  	test_attr->data_size_out = attr.test.data_size_out;
>  	test_attr->ctx_size_out = attr.test.ctx_size_out;
> @@ -902,7 +874,7 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
>  	attr.test.data_in = ptr_to_u64(OPTS_GET(opts, data_in, NULL));
>  	attr.test.data_out = ptr_to_u64(OPTS_GET(opts, data_out, NULL));
>  
> -	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
>  
>  	OPTS_SET(opts, data_size_out, attr.test.data_size_out);
>  	OPTS_SET(opts, ctx_size_out, attr.test.ctx_size_out);
> @@ -920,7 +892,7 @@ static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
>  	memset(&attr, 0, sizeof(attr));
>  	attr.start_id = start_id;
>  
> -	err = sys_bpf(cmd, &attr, sizeof(attr));
> +	err = bpf(cmd, &attr, sizeof(attr));
>  	if (!err)
>  		*next_id = attr.next_id;
>  
> @@ -1005,7 +977,7 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
>  	attr.info.info_len = *info_len;
>  	attr.info.info = ptr_to_u64(info);
>  
> -	err = sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
> +	err = bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
>  
>  	if (!err)
>  		*info_len = attr.info.info_len;
> @@ -1065,7 +1037,7 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
>  	attr.task_fd_query.buf = ptr_to_u64(buf);
>  	attr.task_fd_query.buf_len = *buf_len;
>  
> -	err = sys_bpf(BPF_TASK_FD_QUERY, &attr, sizeof(attr));
> +	err = bpf(BPF_TASK_FD_QUERY, &attr, sizeof(attr));
>  
>  	*buf_len = attr.task_fd_query.buf_len;
>  	*prog_id = attr.task_fd_query.prog_id;
> @@ -1102,6 +1074,6 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
>  	attr.prog_bind_map.map_fd = map_fd;
>  	attr.prog_bind_map.flags = OPTS_GET(opts, flags, 0);
>  
> -	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
> +	ret = bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
>  	return libbpf_err_errno(ret);
>  }
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 6fffb3cdf39b..6ef9e1e464c0 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -27,6 +27,10 @@
>  #include <stdbool.h>
>  #include <stddef.h>
>  #include <stdint.h>
> +#include <unistd.h>
> +#include <asm/unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
>  
>  #include "libbpf_common.h"
>  
> @@ -34,6 +38,32 @@
>  extern "C" {
>  #endif
>  
> +/*
> + * Kernel headers might be outdated, so define __NR_bpf explicitly, if necessary.
> + */
> +#ifndef __NR_bpf
> +# if defined(__i386__)
> +#  define __NR_bpf 357
> +# elif defined(__x86_64__)
> +#  define __NR_bpf 321
> +# elif defined(__aarch64__)
> +#  define __NR_bpf 280
> +# elif defined(__sparc__)
> +#  define __NR_bpf 349
> +# elif defined(__s390__)
> +#  define __NR_bpf 351
> +# elif defined(__arc__)
> +#  define __NR_bpf 280
> +# else
> +#  error __NR_bpf not defined. libbpf does not support your arch.
> +# endif
> +#endif
> +
> +static inline long bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
> +{
> +	return syscall(__NR_bpf, cmd, attr, size);
> +}
> +
>  struct bpf_create_map_attr {
>  	const char *name;
>  	enum bpf_map_type map_type;
> 
