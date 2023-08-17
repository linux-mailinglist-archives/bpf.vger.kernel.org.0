Return-Path: <bpf+bounces-7968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2577F289
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732961C212FB
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E503100A4;
	Thu, 17 Aug 2023 08:57:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BCFC0D
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:57:26 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A826A8
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf0b24d925so6027975ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262645; x=1692867445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ4avl/mz05CnmDkZ4XRfrhEisWAciUAJmphvwfEM2A=;
        b=Vv30KtUNN9X3DCyhblLuDc+5QN4WH17sIufZ4s2NysSZxDPAObOK+RQyUycSz2de/P
         +5sbf5cr3N9siROdEc+KFYHwsvRTeWt/wpORXfGzN3xt6SAxiaiMDS1az3ZVhLt3Ccii
         eHYiAasnpVcYWg5gJFYzO1+AjlDV8bzyQ2Vu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262645; x=1692867445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ4avl/mz05CnmDkZ4XRfrhEisWAciUAJmphvwfEM2A=;
        b=kD17H6GYw0mjiVk/wJEBQ/rsdrU2xvUix1nEsoPPUSbPhxS3oB4q9wELo0AnVFovve
         1ZzrGceLFKPIw3o0F61vm/xN0srdtRb32LQ7VmvJGafD8/4SZS13rE+6eA1gLzIdk6pI
         foD3oKQKl72YUdMlkqHTgB4O1d3Ma6Jk3QmkBgoNAzNsjHg6NBp5CCTWbK7cZFh3TAwb
         FBZkUrNxEm7JDQud233fw82rqpFgim1JNr11wLdzxyRGIgjCl4BkJzyZV1nqBhe4CHUu
         l7Ku7bsVnmJ0Wu1B3VFCF+0bOVnia0Rttg5t9ss45zXAlPeY4C4JS0vKSooMAfReK9rO
         EfVg==
X-Gm-Message-State: AOJu0Yw8Kf6IQPE75zjIxL0QhsH7ZoNapIvjmteVhsqKqsZbQCL7fJYv
	YiD4TJm9SqN/XRc994c1ef8sbePcHNBIQffrfdwIsQ==
X-Google-Smtp-Source: AGHT+IH6xIW34cUhfbm6uS4lGucin/ng4/m/ryyfJico4mCTUTYGDYajeDn/M+ly4sI6E4iuomTaVqg6vaPiGhO2ztA=
X-Received: by 2002:a17:90a:d34a:b0:269:3498:3bad with SMTP id
 i10-20020a17090ad34a00b0026934983badmr3496202pjx.14.1692262644742; Thu, 17
 Aug 2023 01:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:57:13 +0200
Message-ID: <CABRcYmJLbb0_fs2beiNA2QE468JkxB9nHnmQcQW4dt63pPBoFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 7:36=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 3rd version of RFC series to use ftrace_regs instead of pt_re=
gs.
> The previous version is here;
>
> https://lore.kernel.org/all/169139090386.324433.6412259486776991296.stgit=
@devnote2/
>
> This also includes the generic part and minimum modifications of arch
> dependent code. (e.g. not including rethook for arm64.)

I think that one aspect that's missing from the discussion (and maybe
the series) so far is plans to actually save partial registers in the
existing rethook trampolines.

For now the series makes everything called by the rethook trampolines
handle the possibility of having a sparse ftrace_regs but the rethook
trampolines still save full ftrace_regs. I think that to rip the full
benefits of this series, we should have the rethook trampolines save
the equivalent ftrace_regs as the light "args" version of the ftrace
trampoline.

