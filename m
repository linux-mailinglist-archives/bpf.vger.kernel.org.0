Return-Path: <bpf+bounces-1472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947C717268
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 02:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D20F281387
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09887EA;
	Wed, 31 May 2023 00:29:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9207E1
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 00:29:04 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3845C7
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:29:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2563ca70f64so2985877a91.0
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685492942; x=1688084942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zo5K9Y/LnhQhZ/hKX3/+0a27t19VjORKMgRpiDpoVNk=;
        b=Q+/xs4OviQJdAeOadb7k2Cwc7e2hoZAo7j38WAI3d/3sXnw0G9zIE4nPV1rDryDYFB
         tQYF2F9U4pLyjGrHavLcRtSpc3FL/DNeFrsFfJqn6TxUoMYUzSN4tH6ioBo1uxqCd6X3
         5m96OAkLo7ntn50K0x4jx1M040xvtgCuYkQBXDT6JVoZplbr7fYirY5sQx6WnXYHqaBQ
         ts4VCU+nh3FmzhxvddSGCML0+1riV59Pom1D2wRmpEU4RYyEirzeBFJcP9J2PSkvdOsu
         stdrX6jLRMv0KSq1uGW3iKLamWaNrydvWhXQ/NZuLXaCykKSH/TfpBWukCpN555idxM8
         euyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685492942; x=1688084942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo5K9Y/LnhQhZ/hKX3/+0a27t19VjORKMgRpiDpoVNk=;
        b=APO5lVO/hXTI0i8Wwg1nHrv2cohC4X6JbwpCL9OqPM95ol1AaFiYXPb1pYFhEIilpJ
         n1rRf1o7ivA0gA3TrlZGUG2Wj1uDm++qyA/Zh1OPbWjdCF/ZigFGRVV6edjbQ6H2Mf3k
         O/MAgRa3bTkXBUKKOJvJIB9M671RMKn35WvRw4ZW+0GYQIXkb73VmUFOo7XThspGDfu3
         gzJUrokJtTFKJnCPCRe9IAew7WHrJ+RV2Lf3EgkAuTwKU3as7V3YVbRb0jgIUvilBW3s
         NAaU6mG2suir4kaoH1Ovselxa14O13l0J+hwYLA0KKMpdRDX0vjsxyXPTcf467ksyf0M
         h0IQ==
X-Gm-Message-State: AC+VfDzq0iwVzOCDvQSGcge8zoEWmBgnWY1qUbwyIOy0ar91q91cfJz4
	O1X7ZfyDXDGPHLNsuOKqqEs=
X-Google-Smtp-Source: ACHHUZ6ODsyf5hlkuPXpspkCyAyM5BnYtDsOrKjZSvQ1b+SyT+qfKuag73gC4O7VMuYzibIfsQwXww==
X-Received: by 2002:a17:90a:ea82:b0:256:c915:13ca with SMTP id h2-20020a17090aea8200b00256c91513camr2990670pjz.20.1685492942289;
        Tue, 30 May 2023 17:29:02 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d8f6])
        by smtp.gmail.com with ESMTPSA id fs19-20020a17090af29300b0024744818bc5sm798pjb.9.2023.05.30.17.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:29:01 -0700 (PDT)
Date: Tue, 30 May 2023 17:28:58 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, quentin@isovalent.com, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/8] bpf: Support ->show_fdinfo for
 kprobe_multi
Message-ID: <20230531002858.aiyahbvwpenjsr27@MacBook-Pro-8.local>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
 <20230528142027.5585-2-laoar.shao@gmail.com>
 <ZHSVSWph86bmJyvY@krava>
 <CALOAHbDTiPvawvS5xegiLVERzjh2MgmusDQFhCcfLY=wzw=oTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDTiPvawvS5xegiLVERzjh2MgmusDQFhCcfLY=wzw=oTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 30, 2023 at 09:39:01AM +0800, Yafang Shao wrote:
> On Mon, May 29, 2023 at 8:06 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sun, May 28, 2023 at 02:20:20PM +0000, Yafang Shao wrote:
> > > Currently, there is no way to check which functions are attached to a
> > > kprobe_multi link, causing confusion for users. It is important that we
> > > provide a means to expose these functions. The expected result is as follows,
> > >
> > > $ cat /proc/10936/fdinfo/9
> > > pos:    0
> > > flags:  02000000
> > > mnt_id: 15
> > > ino:    2094
> > > link_type:      kprobe_multi
> > > link_id:        2
> > > prog_tag:       a04f5eef06a7f555
> > > prog_id:        11
> > > func_count:     4
> > > func_addrs:     ffffffffaad475c0
> > >                 ffffffffaad47600
> > >                 ffffffffaad47640
> > >                 ffffffffaad47680
> >
> > I like the idea of exposing this through the link_info syscall,
> > but I'm bit concerned of potentially dumping thousands of addresses
> > through fdinfo file, because I always thought of fdinfo as brief
> > file info, but that might be just my problem ;-)
> 
> In most cases, there are only a few addresses, and it is uncommon to

I doubt you have data to prove that kprobe_multi is "few addresses in most cases",
so please don't throw such arguments without proof.

> have thousands of addresses. To handle this, what about displaying a
> maximum of 16 addresses? For cases where the number of addresses
> exceeds 16, we can use '...' to represent the remaining addresses.

at this point the kernel can pick random 16 kernel funcs and it won't be
much worse.

Asking users to do
$ cat /proc/10936/fdinfo/9 | grep "func_addrs" -A 4 | \
  awk '{ if (NR ==1) {print $2} else {print $1}}' | \
  awk '{"grep " $1 " /proc/kallsyms"| getline f; print f}'
ffffffffaad475c0 T schedule_timeout_interruptible
ffffffffaad47600 T schedule_timeout_killable

isn't a great interface either.

The proper interface through fill_link_info and bpftool is good to have,
but fdinfo shouldn't partially duplicate it. So drop this patch and others.

