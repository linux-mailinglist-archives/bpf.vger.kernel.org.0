Return-Path: <bpf+bounces-6724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B26076D2B9
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 17:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F371C21026
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18288C8E9;
	Wed,  2 Aug 2023 15:46:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C18C0C
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 15:46:39 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D79B
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 08:46:38 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-63d0d38ff97so5337706d6.1
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 08:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991197; x=1691595997;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgXY/nnOitynofwfCJBPGuVMC48TUIQHUTzgQbZZb5g=;
        b=XPz2g2aWOhrRq+ezrsr2NnsAskxVTsD0Tt7WFmlvB3kAplhhXSohvKwfCvqzoP6kCp
         nBPQYflLUoM+Wxo40zlxsgtx5UGNvtAlee11qwd6h972KilCCnMH4nVVW01zfRavxXs0
         M8Y+jLr6k0kqPx6V4oIJPQpxbb89skD8LJomSku0dQwMg5oq41NPC02NGEazrrHOmZUl
         dbWWC8YHmInmTLWpLZ2MwDTNgdov9YVdkkJtRwDGwNGdJRI+MRb8HX8EqAmaMnrsg2Oh
         3UzFdsH3nWesuI/LdrsqFh1lggtCdv3xopUg+FjkVkk5Ypw6mLBJ29nlGkudoXLwa6V7
         ydDw==
X-Gm-Message-State: ABy/qLYVR4UXjjqfCUw/a1pLyjUx8PGhNXtEdMdQ9c0Kl8MaT4RRKzJk
	0wY/FY6Pak7ShneLAmKDHmY=
X-Google-Smtp-Source: APBJJlHu7fiz3GrCy/o44F4iyOHCfNu8dCyrbdTFzncsF4TJqESIZXFP08yzldB10UDlWjN+uOmzqA==
X-Received: by 2002:a0c:f051:0:b0:63c:fae3:416 with SMTP id b17-20020a0cf051000000b0063cfae30416mr19131820qvl.31.1690991197298;
        Wed, 02 Aug 2023 08:46:37 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:e145])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b00632266b569esm5549593qvk.87.2023.08.02.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:46:36 -0700 (PDT)
Date: Wed, 2 Aug 2023 10:46:34 -0500
From: David Vernet <void@manifault.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
Message-ID: <20230802154634.GD472124@maniforge>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
 <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge>
 <8b6b0703-4ed6-c0cb-c61a-9ebcfb5fe668@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b6b0703-4ed6-c0cb-c61a-9ebcfb5fe668@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 11:54:18PM -0700, Yonghong Song wrote:
> 
> 
> On 8/1/23 8:29 PM, David Vernet wrote:
> > On Tue, Aug 01, 2023 at 07:45:57PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Aug 1, 2023 at 7:34 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > 
> > > > > 
> > > > > In kernel, we have a global variable
> > > > >      nr_cpu_ids (also in kernel/bpf/helpers.c)
> > > > > which is used in numerous places for per cpu data struct access.
> > > > > 
> > > > > I am wondering whether we could have bpf code like
> > > > >      int nr_cpu_ids __ksym;
> > 
> > I think this would be useful in general, though any __ksym variable like
> > this would have to be const and mapped in .rodata, right? But yeah,
> > being able to R/O map global variables like this which have static
> > lifetimes would be nice.
> 
> No. There is no map here. __ksym symbol will have a ld_imm64 insn
> to load the value in the bpf code. The address will be the kernel
> address patched by libbpf.

ld_imm64 is fine. I'm talking about stores. BPF progs should not be able
to mutate these variables.

