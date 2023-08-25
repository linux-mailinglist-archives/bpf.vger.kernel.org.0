Return-Path: <bpf+bounces-8639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB53788CFB
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC31C21022
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F317725;
	Fri, 25 Aug 2023 16:12:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927022571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:12:03 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD61FD0
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26934bc3059so1559226a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979921; x=1693584721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+swS0Fs+/Jidlh626yVLRTU30HTjKLYV7Eqz4GXMuk4=;
        b=SJEctspEFKgbaE90bSPOQjkbytLN6x83WwR3Ye+Do16tmYcwlEkuikSUgw/rVAOFMw
         ivYKoHGCtgYWydal+37rgYsnAU61pDDfJjmvgEzoSr6zh3acSOAZWRagfz6fZHa98e8R
         yxZ2Kk1GE4LWqMUa/rm3Edmoojly0uNCid+js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979921; x=1693584721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+swS0Fs+/Jidlh626yVLRTU30HTjKLYV7Eqz4GXMuk4=;
        b=FQN+UTuA7mPtGeBPGpU3kxR2dIr523sp9qosfYh9D2HqEoHqTveBubQHdfOf1jwABJ
         nQQApYGZaENVz5qledAOrGPhrMc4EVjWYUobvyIAS8SKXEZQWlymJBwNzQf7+yNGk6C2
         4qtQUxCp1d0ELuQX+OmriZG4LNgHCiWaS9boDHP6AB+kvpc7lZ0PXOCdEowa0FvDrQp/
         GvUowWPaZVfVKgE9QKxqWd+IRbeWvz8AjS04I3nvuU7eSiCggG/oEXd3EpQiCAID7n+P
         Kgd0c9YOOXRdwnCKTvkooOZPfLEjqgPLvAT8PJPERTUu/caewUxoFWqgYr0rr8wRqbAZ
         B6Vg==
X-Gm-Message-State: AOJu0YxaiP6rSS0Zgmr4n6HI82BuoP126Azab3KKSA0W3PphUbH90Wg+
	KCqNqLPvsJSxUShVz5pK/+XkmJvQXSmDuaFwyF1PfA==
X-Google-Smtp-Source: AGHT+IHKREHs/rd7bH+N9Ahx9JgFVYEltPJDfwl75y4CnynKUKCSELopuAPThIGR8lqkCZ3hAcygI84sWqmQKen2udg=
X-Received: by 2002:a17:90b:2551:b0:268:808:8e82 with SMTP id
 nw17-20020a17090b255100b0026808088e82mr28189702pjb.1.1692979921252; Fri, 25
 Aug 2023 09:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
In-Reply-To: <169280372795.282662.9784422934484459769.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Fri, 25 Aug 2023 18:11:49 +0200
Message-ID: <CABRcYmJoPiSEu_=fq5y=oLg8+VG=p5myp=aCYam_TvRmkWs4Eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 5:15=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 4th version of the series to use ftrace_regs instead of pt_re=
gs
> in fprobe.
> The previous version is here;
>
> https://lore.kernel.org/all/169181859570.505132.10136520092011157898.stgi=
t@devnote2/
>
> This version fixes the issues pointed in the previous series; fix documen=
t
> description, keep CONFIG_FPROBE dependency for multi-kprobe, add
> static_assert check for ftrace_regs size, reorder the ftrace_partial_regs=
()
> patch for perf fprobe event support, introduce per-cpu pt_regs stack for
> perf fprobe event and add Florent's Ack (Thanks!). Also this adds a new
> documentation patch to clarify that the $argN and $retval is best effort.
>
>  - Document fix for the current fprobe callback prototype
>  - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
>  - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=3Dn.
>  - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a cus=
tom
>    implementation)
>  - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. T=
his
>    introduce a new HAVE_PT_REGS_TO_FTRACE_REGS_CAST which means ftrace_re=
gs is
>    just a wrapper of pt_regs (except for arm64, other architectures do th=
is)
>  - Update fprobe-events to use ftrace_regs natively.
>  - Update bpf multi-kprobe handler use ftrace_partial_regs().
>  - Update document for new fprobe callbacks.
>  - Add notes for the $argN and $retval.
>
> This series can be applied against the probes/core branch on linux-trace =
tree.
>
> This series can also be found below branch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=
=3Dtopic/fprobe-ftrace-regs
>
> Thank you,

FWIW, I verified that I could implement BPF multi_kprobe on arm64 on
top of this series so the BPF multi_kprobe usecase is tested but I
haven't tested the "trace_fprobe" or perf use cases.

