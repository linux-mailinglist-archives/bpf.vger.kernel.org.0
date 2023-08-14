Return-Path: <bpf+bounces-7742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B525A77BED3
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D221C209C1
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51601C8F1;
	Mon, 14 Aug 2023 17:22:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB0C2FF
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:22:27 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F610D0
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:22:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d664f9c5b92so4247379276.3
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692033746; x=1692638546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4kC8VdwRVtwS3SYD2fsCeGdVP47xqsJs+F+kjoCJt8=;
        b=QqppkQfZcvfWKp0It6PxdXG5wNPjeRybUln6bQP8usjcp6RMH5wdXv1pvsVdvDExGS
         Dr5dCDXITZC90isqbPTyutvnqunbZPro5WAvYsA9voVOv6TaBx1VSZGE802vliYDCYoX
         fcFBS1cIrABZu/1ip1lg34dU3gW4ZKm1j1hheQ1kQHLLoDtvairF5/EPr2G1by0E7KSu
         1Asyfx2MwfavXPE8ucSm9UOGGv77HBqnkZipeuSRLAiBp/M4mMHZnxpo8d6myONS35Qq
         lPZZ3tyF0Vgik1AkmzSM2spr3KzohzpW4y5CJ5dt8t+xi1JuTeJ5mRYZSq5ATh2thErn
         by+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692033746; x=1692638546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4kC8VdwRVtwS3SYD2fsCeGdVP47xqsJs+F+kjoCJt8=;
        b=AzTPOa2JiXWCf/+zNAOUGQOMVqdSEe/nq70y/BcF7O+j5AhUJPuN3eutNASysFLhDk
         bVQOX917HoUcPNL4i1OTRXAwYUxKJzWyc5nZhEZUBDR0rFSLKqwVlSazILrlii3U8Mn0
         NXbFAR6AmzRrth93zgVFipdqRPJBzeFMvanf5XfekiSmd0MkmE2AcOSHHvfGnTlnmtuK
         WK4wJ508G0H9YRMYgRsIcWGKPk3jvoizr0u+TNi6Yi8dqOij+ozdgYlanqt6B5Fotq0Y
         Gr14ccMYT2fsJjl8HxHKBJnlAc2wxdbfvCSO1LB5GAG61KDuiDaJl4DXn62x1DcJP1Ix
         x7bw==
X-Gm-Message-State: AOJu0YyXgT4ZTfkn+IdFdNYL0kntBs9hXn3jgH3NsVZ6Io66TrZzuB94
	0T9xUb37/R+hkhrnSPJzkkhzAu4=
X-Google-Smtp-Source: AGHT+IHZ6W/zTV2xaZIGU94xFjfsD19UE705tAS9fruZGyiFxbrRi8Qkewej2Rt6Eky1W/eR4dbeEbo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1084:b0:d09:17f2:d3b0 with SMTP id
 v4-20020a056902108400b00d0917f2d3b0mr150604ybu.9.1692033746236; Mon, 14 Aug
 2023 10:22:26 -0700 (PDT)
Date: Mon, 14 Aug 2023 10:22:24 -0700
In-Reply-To: <tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230812055703.7218-1-rtoax@foxmail.com> <tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com>
Message-ID: <ZNpi0MWUlFiaBUH6@google.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
From: Stanislav Fomichev <sdf@google.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: ast@kernel.org, rongtao@cestc.cn, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/12, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Static ksyms often have problems because the number of symbols exceeds the
> MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> the problem somewhat, but it's not the perfect way.
> 
> This commit uses dynamic memory allocation, which completely solves the
> problem caused by the limitation of the number of kallsyms.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

I believe this is the one that won the pw race:
https://patchwork.kernel.org/project/netdevbpf/patch/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
> v3: Do not use structs and judge ksyms__add_symbol function return value.
> v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
>     Do the usual len/capacity scheme here to amortize the cost of realloc, and
>     don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 42 ++++++++++++++++-----
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..d8391a2122b4 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,10 +18,32 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> +static struct ksym *syms;
> +static int sym_cap;
>  static int sym_cnt;
>  
> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +	unsigned int new_cap;

Nit: reverse Christmas tree, not sure we care for the tests though..

