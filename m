Return-Path: <bpf+bounces-7971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40077F28D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA21C212C5
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2C100AC;
	Thu, 17 Aug 2023 08:57:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C7FC0D
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:57:47 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307612684
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:46 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a8036d805eso3123048b6e.3
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262665; x=1692867465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ7NMqvFIR2et+D8JZPMfPw5WnBck106F6tUJxbT9Gg=;
        b=b0GhhDLSM9faSxoD0WP+TXbItwqeY4LweTgfy9B593XszXNEq91tklMLWcxdjEXQrJ
         6VMQUM+rWR/ODEx3HE1E3XuNdEIONzAUxF7ibYt1tsebrIKpHhaXHhpXBg67/rQjFrv2
         xLI4IRptekVy+SWo0CuEz3yJxIsjTjMsIgqK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262665; x=1692867465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ7NMqvFIR2et+D8JZPMfPw5WnBck106F6tUJxbT9Gg=;
        b=YKF38OhGgIjOo30MlFr0t2EWz4WDS//yEUH0/0jpEZJdzJHOxHQoFpawRAjdVqIjBV
         vto94dq+j2MWgx49q+9n/m8n3Kz49xPrAzBIPQrYsNsxki9wDhhGl7FpDKhEwlaR3x/c
         d29T3Xw4Cb++MZUEajXobxDqHiBmHJIdLTFlhrGnCSkqXwYO/DcvCULDlWRxgVLp2qyT
         KUOTWkBGQlQg/Xdeb740/Ccw6WWI3m0aYjZvTYwS3mHZ3d8dUzm1aXBmbcofU52XGK59
         Nblts+GfXV0dIRmK6hyyIc3dCjO1uwqYqbMneXR/62VOLg/kKzvoOxOSp6Vvr6jqvveF
         lgWQ==
X-Gm-Message-State: AOJu0Yxx1z9E3dC/urHGinyl6vtJ9K4lRjt82Un/g4a1AltnD6AZXx8Z
	ep3JvH9bFlJZ/11ckQYuFKXrBZpCa8lRC1WL0PkeFg==
X-Google-Smtp-Source: AGHT+IF/lZED8EmuEUmIk6G5RS65+A7NYREGfAS6ecOd1YzcZ0v6Mx9lu+wCelzhQCnQ1D518ZnjHFgRY/sYb2/L/FQ=
X-Received: by 2002:a05:6808:14ca:b0:3a8:3155:bc2e with SMTP id
 f10-20020a05680814ca00b003a83155bc2emr355357oiw.0.1692262665550; Thu, 17 Aug
 2023 01:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181863118.505132.13233554057378608176.stgit@devnote2>
In-Reply-To: <169181863118.505132.13233554057378608176.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:57:34 +0200
Message-ID: <CABRcYm+i1PqVNUC_Hf2wsUdw8Gz-kap9YQ1zFwKKXjb7hp11bg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
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

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> In order to be able to use ftrace_regs even from features unrelated to
> function tracer (e.g. kretprobe), expose ftrace_regs structures and
> APIs even if the CONFIG_FUNCTION_TRACER=3Dn.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>

