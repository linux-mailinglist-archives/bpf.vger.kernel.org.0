Return-Path: <bpf+bounces-7325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C1775714
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBFB1C21187
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40956171C0;
	Wed,  9 Aug 2023 10:28:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A644100B6
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 10:28:52 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204031FF9
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 03:28:50 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a78a2c0f81so2987744b6e.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691576929; x=1692181729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q8MkAHQ4z//oNqFY2MVENDhG30E0OZjbLf49uqOaBk=;
        b=crMbapozPwtjeNppbjAxpjpuLGNgFYD9emI6UusfTFZYXC/sp6pXc9xnok3zJTqSgr
         D7E22VtBhnYZIMc5IeWUOTWbm3fQkafC00OZVVnU3trR9jrCtMSJTDkK/QZvMPqfD4jG
         jb4tVCQ9nDPf6zKfQ/TGYPFEKZ9dTG78Ooeqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576929; x=1692181729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q8MkAHQ4z//oNqFY2MVENDhG30E0OZjbLf49uqOaBk=;
        b=fMegXpzelRN9BH+RN9oDvWt+5j0OobJPzHmyKNO/mR5+/3hmSeSHJtEMaRzXW1G28k
         ntshLkUIhiqC4gfKMEjHzYObk/VQo5x3Ph9QNcnkeleKTefSyLK0f04Yi2wZ4hFytZj/
         aTrwz7VMCqP181xmaqhcUDU/Afjwa5g2PS8hjcmzmjM2sLdcSGo641QyOiW75gb+T2HL
         N19TLPN4pqi/8Uq75EGxp0y04L9Rpg3kfpF81GNW9m6PDsdkoqFfe1vj264mX1oob4fM
         eJNzEWk4dxGYTBEuHzIQYwN5ywfjcpQoamYVWtUmoZhjB5gJv4Ox4AH//DSahJ3uobaI
         FlAQ==
X-Gm-Message-State: AOJu0Yxmtcag9vkgdXMGtnL0kZMbhr1MZvRPrXZ5R+VwI9fl+5bGltkh
	EMvs9+8zpttUZU2QWnbQcLCqF7rMA5W9bK+7X0jGpg==
X-Google-Smtp-Source: AGHT+IEby5BA1Rb3TBNtuipAvYfV2qs3Uz9qjee9oiSSDipAwzSRR3crVDKQeJvAjzfmcMJMfmyvZreaIidOcz+N0dQ=
X-Received: by 2002:a05:6808:23c7:b0:3a7:8e1b:9d65 with SMTP id
 bq7-20020a05680823c700b003a78e1b9d65mr2647100oib.47.1691576929466; Wed, 09
 Aug 2023 03:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139091575.324433.13168120610633669432.stgit@devnote2>
In-Reply-To: <169139091575.324433.13168120610633669432.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 12:28:38 +0200
Message-ID: <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry handler
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
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> on arm64.

This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
but fprobe wouldn't run on these builds because fprobe still registers
to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
!WITH_REGS. Shouldn't we also let the fprobe_init callers decide
whether they want REGS or not ?

>  static int
>  kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> -                         unsigned long ret_ip, struct pt_regs *regs,
> +                         unsigned long ret_ip, struct ftrace_regs *fregs=
,
>                           void *data)
>  {
>         struct bpf_kprobe_multi_link *link;
> +       struct pt_regs *regs =3D ftrace_get_regs(fregs);
> +
> +       if (!regs)
> +               return 0;

(with the above comment addressed) this means that BPF multi_kprobe
would successfully attach on builds WITH_ARGS but the programs would
never actually run because here regs would be 0. This is a confusing
failure mode for the user. I think that if multi_kprobe won't work
(because we don't have a pt_regs conversion path yet), the user should
be notified at attachment time that they won't be getting any events.
That's why I think kprobe_multi should inform fprobe_init that it
wants FTRACE_OPS_FL_SAVE_REGS and fail if that's not possible (no
trampoline for it for example)

