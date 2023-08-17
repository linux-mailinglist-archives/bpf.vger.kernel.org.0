Return-Path: <bpf+bounces-7957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E839677EFB5
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 06:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2567C1C2127C
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 04:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DE801;
	Thu, 17 Aug 2023 04:01:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC36638
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 04:01:13 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436C626B6;
	Wed, 16 Aug 2023 21:01:12 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-44bfe8bcf78so33327137.2;
        Wed, 16 Aug 2023 21:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692244871; x=1692849671;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8KWq6YGMzvOgW5tkJv9sGP754TKT/fhTvLza8QPwKc=;
        b=kSBUzD5xWmKFQ49CR3bDNA3FR2/WHjhhk3U1sZy1IGLIJ7YqQ0sCpzKjFQx3T/SJqn
         W3fLL1SIliAcm3/9njIaD23CywbBKqVD7JFKx8Lz+yUI2EaCUL7z6t6/XVz7fz8FhIQ/
         aBcR9iNFltBVTb+ISeB5Axs+cyc8VZlhviRqavs3QstSQ51/liG0o/LQOjGyVxF5JhC2
         KPQHRNGs1af4NuadLpI3slN5ZIpu/aM7H3DEegWF8vw2kTfu3DSPQRUrrq21i5l2g5Ma
         hn1ESQdTaGoXTUHp8Ia2eZRPgHBZq0uKDWiN6zW1zVHhmjj1v0FFep+lUB9qI4K+6l8t
         PGIw==
X-Gm-Message-State: AOJu0YyyUdqvHm2gXf6eQzGg4kofOT6Txd/uBMbecT0r3ZeJygTOzuMN
	dOW37CUtGbk6UEke72IXJQY=
X-Google-Smtp-Source: AGHT+IHx61E+CyAYLOl+G8rajiK9afP2AY1VkLRaoHjcUio0JrTsr0rpebFWIhlD1s5BBt1nW5T5Kg==
X-Received: by 2002:a1f:5e10:0:b0:488:2454:ea4b with SMTP id s16-20020a1f5e10000000b004882454ea4bmr3013075vkb.8.1692244870982;
        Wed, 16 Aug 2023 21:01:10 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:6eb])
        by smtp.gmail.com with ESMTPSA id o12-20020a0ce40c000000b0063d561ea04csm2480933qvl.102.2023.08.16.21.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 21:01:10 -0700 (PDT)
Date: Wed, 16 Aug 2023 23:01:07 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for
 globally-linked kfuncs
Message-ID: <20230817040107.GC1295964@maniforge>
References: <20230816150634.1162838-1-void@manifault.com>
 <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
 <CAADnVQKtWkPWMG+F-Tkf3YXeMnC=Xwi8GA5xJMaqi725tgHSTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKtWkPWMG+F-Tkf3YXeMnC=Xwi8GA5xJMaqi725tgHSTw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 08:48:16PM -0700, Alexei Starovoitov wrote:
> On Wed, Aug 16, 2023 at 8:38 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> >
> >
> > On 8/16/23 8:06 AM, David Vernet wrote:
> > > We recently got an lkp warning about missing declarations, as in e.g.
> > > [0]. This warning is largely redundant with -Wmissing-prototypes, which
> > > we already disable for kfuncs that have global linkage and are meant to
> > > be exported in BTF, and called from BPF programs. Let's also disable
> > > -Wmissing-declarations for kfuncs. For what it's worth, I wasn't able to
> > > reproduce the warning even on W <= 3, so I can't actually be 100% sure
> > > this fixes the issue.
> > >
> > > [0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/
> >
> > Okay, I just got a similar email to [0] which complains
> >    bpf_obj_new_impl, ..., bpf_cast_to_kern_ctx
> > missing declarations.
> >
> > In the email, the used compiler is
> > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> >
> > Unfortunately, I did not have gcc-7 to verify this.
> > Also, what is the minimum gcc version kernel supports? 5.1?
> 
> pahole and BTF might be broken in such old GCC too.
> Maybe we should add:
> config BPF_SYSCALL
>         depends on GCC_VERSION >= 90000 || CLANG_VERSION >= 130000

It seems prudent to formally declare minimum compiler versions. Though
modern gcc and clang also support -Wmissing-declarations, so maybe we
should merge this patch regardless? Just unfortunate to have to add even
more boilerplate just to get the compiler off our backs.

