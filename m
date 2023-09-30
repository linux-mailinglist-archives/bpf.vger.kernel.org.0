Return-Path: <bpf+bounces-11146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50DF7B3D29
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 02:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4577528245B
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 00:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F1623;
	Sat, 30 Sep 2023 00:12:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF823361;
	Sat, 30 Sep 2023 00:12:21 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A10AC;
	Fri, 29 Sep 2023 17:12:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406650da82bso2157915e9.3;
        Fri, 29 Sep 2023 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696032739; x=1696637539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SClv1LlI8wah9GUgl9MuVq3kI1Q7eEXuNLYhk0MpO5c=;
        b=i1ng1/NqxM88KnRaARjItv8/sTTYn7dgoJKBiZeHcm6ETZh5OkpfJ0Pi9npKWyowEJ
         A1kHmZUwKBW8p8NXqNK1h+hAvNA/u+BCo1zPzzmmUB4JmwlADmFWhRmXRQIADu2ONTjA
         SqKtiphG+zuuhA8XnvLRd9VHLgPgsOs7coPjvfKKh3/iofPJR2GPpF4u2upDPxTaGQEH
         Y/eaGbNdlgloTImBIxAJ+su9i+vENKQU1NyGkmJjmrWK5fheQluAEJfdf1ilEUTyBr1s
         aOXrA4XgcJYM0h/O/VRqv3oGGKVOJwOBdGEprqZmDZIvatgumMkh8+gYo4QiKJljweRX
         eQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696032739; x=1696637539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SClv1LlI8wah9GUgl9MuVq3kI1Q7eEXuNLYhk0MpO5c=;
        b=A0mRLQyBpV/ixJYzTiM/oquPtRrCpxEGDp1UBSV1KrPoz2RgfkmmZ9xjeGeMrPvvGj
         evYgWRu5kiJxNZjwXs8EVKGuKIl2wwooIFTBNe+lSZ/z/lI/0b4B5bP7siO25UNFz5Dn
         AJUyFrW9TBkmgCVJlZwDwTOXpNyEV0Z7pmulNUOsvsBBSdRdsfJl7wkD3z8tmaMDBlnw
         GJseS+G2DkDIWJw3oKy5Lkie+EtGHaDM786omPuk4yGeYcBg67pmyUTaQgYyG4f9E3hc
         SUR70uIbfYZoceQISdCmPS2rgBsSQMAU1p5Lq6TtwJs0Vc+P5wQW5fDbVnCNXHYltkmV
         hi5g==
X-Gm-Message-State: AOJu0YyLFfyDGonOiiJHurXDMu6DJeKLUYSbVrSQv32XDsAomgfUqBol
	wb4fc6dMdMTwuaNhKLTbSO8bb91x4IlPN9hosRA=
X-Google-Smtp-Source: AGHT+IHcDmswGvT/6Qnt+++BtCsQ9K0NDC2StbSRWUKiHGBAV0LHnnBOe9f4srvOYuGY3M1TDQ0PKj62ohUfBH00+f8=
X-Received: by 2002:a05:600c:d3:b0:401:bf56:8ba0 with SMTP id
 u19-20020a05600c00d300b00401bf568ba0mr4570782wmm.28.1696032738486; Fri, 29
 Sep 2023 17:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169556254640.146934.5654329452696494756.stgit@devnote2> <20230929102115.09c015b9af03e188f1fbb25c@kernel.org>
In-Reply-To: <20230929102115.09c015b9af03e188f1fbb25c@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Sep 2023 17:12:07 -0700
Message-ID: <CAADnVQ+HCLx+QUE88uVxeBNYFY4D=2-HADOU1C_czT1S1sRHgA@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] tracing: fprobe: rethook: Use ftrace_regs
 instead of pt_regs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 6:21=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
>
> Thus, what I need is to make fprobe to use function-graph tracer's shadow
> stack and trampoline instead of rethook. This may need to generalize its
> interface so that we can share it between fprobe and function-graph trace=
r,
> but we don't need to involve rethook and kretprobes anymore.

...

> And need to add patches
>
>  - Introduce a generized function exit hook interface for ftrace.
>  - Replace rethook in fprobe with the function exit hook interface.

you mean that rethook will be removed after that?

