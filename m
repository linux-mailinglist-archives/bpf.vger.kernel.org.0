Return-Path: <bpf+bounces-7974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6E77F296
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73D3281E25
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFB101EA;
	Thu, 17 Aug 2023 08:58:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50C100AC
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:58:06 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06190271B
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26b4a9205e3so2526403a91.0
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262684; x=1692867484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfLp1c4CQASb52Y25xFQC1k0yj/rlFjQOJxQJThqQmU=;
        b=ho9t7K5YnNQvxLDVMQoh5xm1KUvC6FOjB+27q2YIWPGBsEK1xTmHG1t4a7Ee3T31Ex
         SKeSoS63VoXvRtkhpGG+BaN/dwKaZY0js6KsiZBcoiXMgPY0a8N/kAAIeNSsjokm9WlT
         yZI1f9uvxWx6FbPMxJ3Gl8EMiGLXjB2yWFuDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262684; x=1692867484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfLp1c4CQASb52Y25xFQC1k0yj/rlFjQOJxQJThqQmU=;
        b=CiX277H5YMhFjP19rXkWJHnqcnG4h65u2DWt3LfZn/I0sfPxDyI13faFdTIRWgLj9s
         hpeDPdxULybC7UtbSenmhyb/Syn9najYVexCEAC6V1Oruk770nFg09LkSuIwlIPboQIx
         PupNCPEKqgjzn/eM8cVSVXkcX9YtgvccmT4FDEkYOlZy2ObvZkfAAODCACKprGIn81+H
         PIpcGAKjTWbvkYonP9WLyJPkUQ2dDO+BR8PCSC3ruOIEk+r6ZQES4JJndYXk595WRNK4
         LxtmhyZgsJ1xRF1OcZHrNZw3UmBoa5J/nvo+U6zz8P/O9HZ3+eAXk1XtxzG5O4UElpWe
         3gPg==
X-Gm-Message-State: AOJu0Yxn4TFnHrqJLr66JEeVuxtqrOn0D4+hVlP8wS3NYk4Ft9ihJzDk
	1MePqW08J4FbSG60QvT6yGpTV/s9SzPx1eSANZpBYQ==
X-Google-Smtp-Source: AGHT+IEuEh+F6ilNeOovqEBoQx7IdH5Xb8wY6puO8xnT2cSmh5oD8u4Z75bhE+9E37pBH0xI4F70q7QRYHtpLN1LfH8=
X-Received: by 2002:a17:90b:a12:b0:268:daa4:3a70 with SMTP id
 gg18-20020a17090b0a1200b00268daa43a70mr3495997pjb.32.1692262684544; Thu, 17
 Aug 2023 01:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181866661.505132.3229847361646568033.stgit@devnote2>
In-Reply-To: <169181866661.505132.3229847361646568033.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:57:53 +0200
Message-ID: <CABRcYm+8uASJA+=AmAFVQMO+ZEOKRBca0bYpxTKb1hGV7P0iUg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] ftrace: Add ftrace_partial_regs() for converting
 ftrace_regs to pt_regs
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>

