Return-Path: <bpf+bounces-13782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381857DDD26
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 08:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E820A281723
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 07:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74D63AA;
	Wed,  1 Nov 2023 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itjQTJf0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B965681
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 07:25:44 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC639107;
	Wed,  1 Nov 2023 00:25:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso2219826a12.3;
        Wed, 01 Nov 2023 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698823541; x=1699428341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0B6t64iTbqlkXV8vHqQhKtKlN8kObrIwOhWS9YPxd2c=;
        b=itjQTJf0hPtSeKP0359/n8uA0SC/CXw5AdojH8UUBlJ8dH4/wKV7IPshyOu3y7Il9C
         XOQdoy429xJNqsVi/uCaClMB62/p08AOxw1o4A1LYufbmjwWyqMftl9tqtkAnkVpPsn6
         zPiQ9s+TiUEXFbdBj+Mxypk0iCGihFQhD2jlyhEKjVbu7yt0uyXO8bZX0mw9DSSgAnBl
         vnO9YMe3Nq06zk0q2rAfPrhY+yKMvbmxtjDa4pxFTrl2NpAtx+yPL+RjYqK5ym3Ag8qR
         guBJc1uzzcecgPMOap2jOudzdDSiy0TIWHST+Oftj8xEv8G7BCq4cOf3w96GeF/zshcC
         4rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698823541; x=1699428341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0B6t64iTbqlkXV8vHqQhKtKlN8kObrIwOhWS9YPxd2c=;
        b=lgwAfpBXQPznVu4Jn3Iwo7a6z1Vt1xGDZ3iiKEFonm1bE1xzQOhIw47X4S9KVW6YcD
         aSghrd7ixmZGe766Wx4tACcs3KI96QSgUH0KFR8yJnvNkmThAyzRWA0c5sVwb5eQZSfd
         rSYJzEf6LsLadI+3liVDV/HBOyXnqMJ6GMwN+sAUaJ1Adko3fG5KOjUfu+9ZLY+sGy0h
         OqUi9OdhU7cA4BHLg3WZzr2MRcMI8POP1fhV32aDdCfQxwhn6+r5MlrmQUDtkvTa4lgP
         B3qN5M/V4v0r5fSdqxr12n4+vtluU4rj7i0+aDBJa3cIk8R86DkKEjvf1fmZR1IXhML/
         7ZYA==
X-Gm-Message-State: AOJu0YxDBIdEzg9eCCgCWj+Do/cpQQFOLXHB8HM/yLBw0xnsyPCwQW4Z
	SJcQkw7hUN0eEjMQIVdNHDM=
X-Google-Smtp-Source: AGHT+IH0nGJpQFa+U2u0tQ+MCqlEtJOEF/OGmjnfNQC0t+iPzP5TdkXUNtOywr7ed1aA/LrThdSvKA==
X-Received: by 2002:a17:907:d21:b0:9c0:eb3e:b070 with SMTP id gn33-20020a1709070d2100b009c0eb3eb070mr1204779ejc.69.1698823540960;
        Wed, 01 Nov 2023 00:25:40 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k12-20020a1709065fcc00b009ce03057c48sm2067069ejv.214.2023.11.01.00.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:25:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Nov 2023 08:25:38 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Matthieu Baerts <matttbe@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>,
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
Message-ID: <ZUH9cveAsjcUgz9e@krava>
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
 <ZUEzzc/Sod8OR28B@krava>
 <CAADnVQKCNFxcpE9Y250iwd8E4+t_Pror0AuRaoRYepUkXj56UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKCNFxcpE9Y250iwd8E4+t_Pror0AuRaoRYepUkXj56UA@mail.gmail.com>

On Tue, Oct 31, 2023 at 08:54:56PM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 31, 2023 at 10:05 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
> > > Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> > > possible to build the kernel without CONFIG_CGROUPS:
> > >
> > >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> > >   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
> > >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> > >         |              ^~~~~~~~~~~~~~~~~~~
> > >   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
> > >   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
> > >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> > >         |                                    ^~~~~~~~~~~~~~~~~~~~~~
> > >   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
> > >     927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
> > >         |                                                            ^~~~~~
> > >   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
> > >     930 |         css_task_iter_start(css, flags, kit->css_it);
> > >         |         ^~~~~~~~~~~~~~~~~~~
> > >         |         task_seq_start
> > >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
> > >   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
> > >     940 |         return css_task_iter_next(kit->css_it);
> > >         |                ^~~~~~~~~~~~~~~~~~
> > >         |                class_dev_iter_next
> > >   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
> > >     940 |         return css_task_iter_next(kit->css_it);
> > >         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
> > >   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
> > >     949 |         css_task_iter_end(kit->css_it);
> > >         |         ^~~~~~~~~~~~~~~~~
> > >
> > > This patch simply surrounds with a #ifdef the new code requiring CGroups
> > > support. It seems enough for the compiler and this is similar to
> > > bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> > > been added in kernel/bpf/helpers.c and in the selftests.
> > >
> > > Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
> > > Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665206927
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@intel.com/
> > > Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> >
> > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> 
> I believe this patch has the same issue as Arnd's patch:
> https://lore.kernel.org/all/CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com/
> 
> I'd like to merge the fix asap. Please make it a complete fix.

ugh, it won't fail the build, it just warns.. I think we should
fail the build in that case, I'll check

jirka

