Return-Path: <bpf+bounces-11860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E167C48E4
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F5A1C20B80
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 04:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12398354F0;
	Wed, 11 Oct 2023 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WcOV32Ny"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C709811
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 04:44:18 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03C9D
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 21:44:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so4913715b3a.0
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 21:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696999453; x=1697604253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP4b4JzgevJDuqoo7Rpr4koADp7QjWQ1TVT0IwKQygg=;
        b=WcOV32Nyerab2jwd1tzTWYqzurnKYm7stBEkyzT7rIJ/kOE5nvUTTF4iG91uVVfreO
         hhlHyLK2LENjx2YMuBzV+CcJKTV4khMAe3ydL7VMkzmv48oFBNXqtkbLCfzlw56UVzow
         W+cDL/VjwZzdG9AMYLEB8Wy/+MjXjm0wuNMvdrI6sZL2W5Cugzv4HHwzozrcnONpfdzJ
         xpf4SpRe/VYwagZon80+FutnxmXpAnjZLOD8iKPwZQNKULNVuK/kb0TDKKI9h+FL9UMR
         39N2+bi7EoJj1rmWWK3i5opdbePGc+t3sBudHg/8jARPkY3lDX8LovujNx+94GXeRxxF
         N9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696999453; x=1697604253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lP4b4JzgevJDuqoo7Rpr4koADp7QjWQ1TVT0IwKQygg=;
        b=n5DWRr9UqLEjYA+imZfqemtRhQJ16bxwAY7L+QffAaX2677uaNYniqvCsKVMEo46gX
         oFz9UvjLO3zoIzTN+qzhvCrHZ1CeZjW93VoUvYOpSe7dUdLwMfjav7BZqu3MPw8gVzUD
         cqDKHr8HMvgLUWk3CJCj0kgp50+SJiGoGT4JGs6CsXigkhuv70mTsWhj04AnSTocr0FD
         uPrycIrALDxsd3SZ8IZc3KgMD+Olfrz61Fo0h+9YFuVPG6VXTTyzzIRtqz+Hge9IB8sG
         P7fnGzN3dXSUOjRLGlYzoY+Fdvnzu5kaQ7RHwiZcFi+FqvXflRXjMB7NwzzCEDFV44G3
         fQxQ==
X-Gm-Message-State: AOJu0YyC/7uKLfObP85wzWoG9MiBbM3F6rrtGaXhBcPPslh0jB9AFfwo
	kylGoFcLjnGj0erpFDLDgsQAaXRILbMULuSy2AE=
X-Google-Smtp-Source: AGHT+IGZPDR2+zk+cLZC1C124n9Vodl9jExw6pMc1CqBKp5+Yy+Po/2p/quZNzTb61vzBCKiRBDkAw==
X-Received: by 2002:a05:6a21:33a8:b0:16b:8bcf:9e27 with SMTP id yy40-20020a056a2133a800b0016b8bcf9e27mr14605437pzb.20.1696999453635;
        Tue, 10 Oct 2023 21:44:13 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a4d8800b00263f41a655esm10595328pjh.43.2023.10.10.21.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 21:44:12 -0700 (PDT)
Message-ID: <f6fd8209-4808-45e1-b5b5-95ea2dcc0ba4@bytedance.com>
Date: Wed, 11 Oct 2023 12:44:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 4/8] bpf: Introduce css open-coded iterator
 kfuncs
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
 <20231007124522.34834-5-zhouchuyi@bytedance.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20231007124522.34834-5-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/10/7 20:45, Chuyi Zhou 写道:
> This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_css in open-coded iterator
> style. These kfuncs actually wrapps css_next_descendant_{pre, post}.
> css_iter can be used to:
> 
> 1) iterating a sepcific cgroup tree with pre/post/up order
> 
> 2) iterating cgroup_subsystem in BPF Prog, like
> for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.
> 
> The API design is consistent with cgroup_iter. bpf_iter_css_new accepts
> parameters defining iteration order and starting css. Here we also reuse
> BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
> BPF_CGROUP_ITER_ANCESTORS_UP enums.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>   kernel/bpf/cgroup_iter.c                      | 59 +++++++++++++++++++
>   kernel/bpf/helpers.c                          |  3 +
>   .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
>   3 files changed, 68 insertions(+)
> 
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index 810378f04fbc..9c6ad892ae82 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -294,3 +294,62 @@ static int __init bpf_cgroup_iter_init(void)
>   }
>   
>   late_initcall(bpf_cgroup_iter_init);
> +
> +struct bpf_iter_css {
> +	__u64 __opaque[3];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_css_kern {
> +	struct cgroup_subsys_state *start;
> +	struct cgroup_subsys_state *pos;
> +	unsigned int flags;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
> +		struct cgroup_subsys_state *start, unsigned int flags)
> +{
> +	struct bpf_iter_css_kern *kit = (void *)it;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
> +

This would cause the fail of netdev/build_32bit CI 
(https://netdev.bots.linux.dev/static/nipa/790929/13412333/build_32bit/stderr):

tools/testing/selftests/kvm/settings: warning: ignored by one of the 
.gitignore files
../kernel/bpf/cgroup_iter.c:308:17: warning: no previous prototype for 
‘bpf_iter_css_new’ [-Wmissing-prototypes]
   308 | __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
       |                 ^~~~~~~~~~~~~~~~
../kernel/bpf/cgroup_iter.c:332:41: warning: no previous prototype for 
‘bpf_iter_css_next’ [-Wmissing-prototypes]
   332 | __bpf_kfunc struct cgroup_subsys_state 
*bpf_iter_css_next(struct bpf_iter_css *it)
       |                                         ^~~~~~~~~~~~~~~~~
../kernel/bpf/cgroup_iter.c:353:18: warning: no previous prototype for 
‘bpf_iter_css_destroy’ [-Wmissing-prototypes]
   353 | __bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
       |                  ^~~~~~~~~~~~~~~~~~~~
In file included from <command-line>:
../kernel/bpf/cgroup_iter.c: In function ‘bpf_iter_css_new’:
./../include/linux/compiler_types.h:425:45: error: call to 
‘__compiletime_assert_322’ declared with attribute error: BUILD_BUG_ON 
failed: sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css)
   425 |         _compiletime_assert(condition, msg, 
__compiletime_assert_, __COUNTER__)
       |                                             ^
./../include/linux/compiler_types.h:406:25: note: in definition of macro 
‘__compiletime_assert’
   406 |                         prefix ## suffix(); 
         \
       |                         ^~~~~~
./../include/linux/compiler_types.h:425:9: note: in expansion of macro 
‘_compiletime_assert’
   425 |         _compiletime_assert(condition, msg, 
__compiletime_assert_, __COUNTER__)
       |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro 
‘compiletime_assert’
    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), 
msg)
       |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:50:9: note: in expansion of macro 
‘BUILD_BUG_ON_MSG’
    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " 
#condition)
       |         ^~~~~~~~~~~~~~~~
../kernel/bpf/cgroup_iter.c:313:9: note: in expansion of macro 
‘BUILD_BUG_ON’
   313 |         BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != 
sizeof(struct bpf_iter_css));


The reason seems on 32-bit machine, sizeof(struct bpf_iter_css) is 24 
and sizeof(struct bpf_iter_css_kern) is 16.

I was wondering whether the BUILD_BUG_ON check is necessary. Looking at 
the struct bpf_list_node and struct bpf_list_node_kern wich are very 
similay to bpf_iter_css, I didn't see the BUILD_BUG_ON check when 
convert from (struct bpf_list_node *) to (struct bpf_list_node_kern *)

/* Non-opaque version of bpf_list_node in uapi/linux/bpf.h */
struct bpf_list_node_kern {
	struct list_head list_head;
	void *owner;
} __attribute__((aligned(8)));

struct bpf_list_node {
	__u64 :64;
	__u64 :64;
	__u64 :64;
} __attribute__((aligned(8)));

__bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
					struct bpf_list_node *node,
					void *meta__ign, u64 off)
{
	struct bpf_list_node_kern *n = (void *)node;

}




