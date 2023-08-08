Return-Path: <bpf+bounces-7242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B301773D83
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115712800AF
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E813FFF;
	Tue,  8 Aug 2023 16:12:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151303C37
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:12:03 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88496EB94
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:11:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76cded293e8so417546085a.2
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691511073; x=1692115873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR2OPalgZgFVCbBNZrCKIT8XHg7hgxmL/4fBXTDwklA=;
        b=fXr+ejJphcnh++slQIYsqptA9CaCLGCl/4XqJbNMmgHV4gVxEk9SSEZRphLAMU8IVI
         FdAP1719a4GBb3sBWoZXwZFmcnkoof5/xxMh91huH+bTL5T7Wpf9cV0G1Ym9tSLnQTOn
         hlLPlFDbAoznJTrpKXw4a7RItEZobfeX5fgus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511073; x=1692115873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR2OPalgZgFVCbBNZrCKIT8XHg7hgxmL/4fBXTDwklA=;
        b=FIN1m1XkDi0bkgfk2B8o+ZwFrEyOCPEw7Z1u0LTrUPV1jMEOjUkOCmWdKvj3L/kNji
         oWayf+r6jh3WUwXTlPQj6qQWub3DjpLBybKWIcfbhquK8/VCMlQ7PYjBees6Qlc6wrmg
         SXZNWgHCzw0oDIE12tNBk6RT2KSofsVGIJsJfrAuco6bxpidoKEDykQxxhEH4xRI95YN
         b6FoqwU8PyE5MoRuqZ+mHSXT2twzAXYpLgh6TdCc/AjXbOed5a9RPeeI6Xb710mscBA9
         qzRFzsJys4uppNrkIvoMlDjf58xb2sctQAJ4qL8/IzVHuznZFpmUIGGbowYJoinQBzEL
         uvrw==
X-Gm-Message-State: AOJu0Yzuid/hFzRPqFdWruAKmcpS7f55/SQ3TCRZH9VNslqimvTegNEg
	Vz/7TC2EmBANFrTfhRvRA1DSneSfjIgXLF2MTCmbm/m7lIYSAGMqtvY=
X-Google-Smtp-Source: AGHT+IGwh0ywunatAy5MeeHk5SP91VnhUNy/5ce/vmlO7FYlLbSHZH+fvMcUcYsWZGLmPuJjjJUiwXexkRhSyiHdIdI=
X-Received: by 2002:a17:90a:d50d:b0:268:ee6:6bdf with SMTP id
 t13-20020a17090ad50d00b002680ee66bdfmr9968391pju.47.1691504978388; Tue, 08
 Aug 2023 07:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
In-Reply-To: <169139090386.324433.6412259486776991296.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Tue, 8 Aug 2023 16:29:27 +0200
Message-ID: <CABRcYmLYyohzVBzg-maoAwaFwj6VanWiAiv5GQnpagn2-ZDoRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] bpf: fprobe: rethook: Use ftrace_regs instead
 of pt_regs
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Florent, feel free to add your rethook for arm64, but please do not remov=
e
> kretprobe trampoline yet. It is another discussion point. We may be possi=
ble
> to use ftrace_regs for kretprobe by ftrace_partial_regs() but kretprobe
> allows nest probe. (maybe we can skip that case?)

Ack :)

>  arch/Kconfig                    |    1 +
>  arch/arm64/include/asm/ftrace.h |   11 ++++++
>  arch/loongarch/Kconfig          |    1 +
>  arch/s390/Kconfig               |    1 +
>  arch/x86/Kconfig                |    1 +
>  arch/x86/kernel/rethook.c       |    9 +++--
>  include/linux/fprobe.h          |    4 +-
>  include/linux/ftrace.h          |   56 ++++++++++++++++++-----------
>  include/linux/rethook.h         |   11 +++---
>  kernel/kprobes.c                |    9 ++++-
>  kernel/trace/Kconfig            |    9 ++++-
>  kernel/trace/bpf_trace.c        |   14 +++++--
>  kernel/trace/fprobe.c           |    8 ++--
>  kernel/trace/rethook.c          |   16 ++++----
>  kernel/trace/trace_fprobe.c     |   76 ++++++++++++++++++++++++---------=
------
>  kernel/trace/trace_probe_tmpl.h |    2 +
>  lib/test_fprobe.c               |   10 +++--
>  samples/fprobe/fprobe_example.c |    4 +-

I believe that Documentation/trace/fprobe.rst should also be modified
following the API change

