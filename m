Return-Path: <bpf+bounces-7035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F47C770707
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A20F28285B
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DC1AA8B;
	Fri,  4 Aug 2023 17:26:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D06EBE7C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 17:26:37 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD6D469A
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 10:26:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686bea20652so2222941b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691169995; x=1691774795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JphLCmILQLQtm6C+8rHqJoDL6onaPDHw9v6WesurCsg=;
        b=r6q7qAGWzvZUiLJlqMhJLhohj7njHjtcTcRVZt2D2xU9JP3MQJ0/83tKG8aLTI0ohy
         DbA7Xk80sbDy4V0owZEd4OmS516M139UsF6WaWF8yPHFJWZjYKEO5tU/L/Ls+v5cP+8r
         zvOoYIwyRhoTMRj8kiRgd72Jh9aGordDV6F0FGpAnOpn+fbtROvFB9Z2LeFqr0WLExyS
         FKiQCat2x6Kb+JIwFHOM2FneSrIoS4YUyV+Zm5ggxPkme3KBaktv1s1hYG+pbaWG1cTp
         IuilMWnUL0u3gqEKHw452Mhh2G4Gktwl+EbrJs2NBI1w+ftaSkEbCSjYWJJHNt/IwFjl
         J+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691169995; x=1691774795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JphLCmILQLQtm6C+8rHqJoDL6onaPDHw9v6WesurCsg=;
        b=VuseNWYESiJWBR2X763OR82/C70XFOhYMEJC7ciJcdZ7RFNbdp5/n7KlBrkHPO51D6
         sbZyugCSjuYr4Mklo0jPOmIvM1G6jb3eXfIC4XJffvXH6hMOlyAF689+l25ydAKl6yHR
         MUWvcdskyDGN/54q6RLoQ3C1U4PPEji2Jvm0igdtpl3Q94+I1rByRBSujg1rO8jBCcuT
         7wRPQG7OLi+RNT6sHlmXDlQXx3n/B76BU3h/43uFh9wjnfrmVwEjdbStPIm4fO9z8K9z
         jtbzSDAv/OoF/nKig6KH4iIgmEtrBAPipgm1pCnaEZdfZWkhRPnK+/hRw/cVta9Ud7PU
         O2OA==
X-Gm-Message-State: AOJu0YyQ1GbSo7E6QtQtD1aNIt4fs21WppwrrhwbV2TIc16ogxIzh1nU
	fRX1fzA74bj6Y7bFsCp4ldBYQw==
X-Google-Smtp-Source: AGHT+IFY3DK0mTMlQh9d2j8+8rCxpiY2bx9LhdMBgQrVPQ7hwkeFF3l5xqJrFOHDkYksAUT9xQx9aw==
X-Received: by 2002:a05:6a00:180c:b0:680:98c:c593 with SMTP id y12-20020a056a00180c00b00680098cc593mr3293062pfa.7.1691169995381;
        Fri, 04 Aug 2023 10:26:35 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v19-20020a62a513000000b006870721fcc5sm1878051pfm.175.2023.08.04.10.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:26:34 -0700 (PDT)
Date: Fri, 4 Aug 2023 10:26:32 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	bpf@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	Nam Cao <namcaov@gmail.com>
Subject: Re: [PATCH 01/10] RISC-V: Expand instruction definitions
Message-ID: <ZM00yFKcDczO50lJ@ghost>
References: <20230803-master-refactor-instructions-v4-v1-0-2128e61fa4ff@rivosinc.com>
 <20230803-master-refactor-instructions-v4-v1-1-2128e61fa4ff@rivosinc.com>
 <20230804-barterer-heritage-ed191081bc47@wendy>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804-barterer-heritage-ed191081bc47@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 08:59:24AM +0100, Conor Dooley wrote:
> On Thu, Aug 03, 2023 at 07:10:26PM -0700, Charlie Jenkins wrote:
> > There are many systems across the kernel that rely on directly creating
> > and modifying instructions. In order to unify them, create shared
> > definitions for instructions and registers.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/insn.h            | 2742 +++++++++++++++++++++++++++---
> 
> "I did a lot of copy-pasting from the RISC-V spec"
> 
> How is anyone supposed to cross check this when there's 1000s of lines
> of a diff here? We've had some subtle bugs in some of the definitions in
> the past, so I would like to be able to check at this opportune moment
> that things are correct.
> 
> >  arch/riscv/include/asm/reg.h             |   88 +
> >  arch/riscv/kernel/kgdb.c                 |    4 +-
> >  arch/riscv/kernel/probes/simulate-insn.c |   39 +-
> >  arch/riscv/kernel/vector.c               |    2 +-
> 
> You need to at least split this up. I doubt a 2742 change diff for
> insn.h was required to make the changes in these 4 files.
Yeah it is kind of a nightmare to look at, I will split it up.
> 
> Then after that, it would be so much easier to reason about these
> changes if the additions to insn.h happened at the same time as the
> removals from the affected locations.
> 
> I would probably split this so that things are done in more stages,
> with the larger patches split between changes that require no new
> definitions and changes that require moving things to insn.h
> 
> >  5 files changed, 2629 insertions(+), 246 deletions(-)
> 
> What you would want to see if this arrived in your inbox as a reviewer?
> 
> Don't get me wrong, I do like what you are doing here, the BPF JIT
> especially is filled with "uhh okay, I guess those offsets are right",
> so I don't mean to be discouraging.
> 
> Thanks,
> Conor.



