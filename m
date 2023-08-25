Return-Path: <bpf+bounces-8641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7470788CFE
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A591C20FE4
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598E17735;
	Fri, 25 Aug 2023 16:12:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FB2571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:12:10 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A41FD0
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565e395e7a6so526627a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979930; x=1693584730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJKdAvSeO4VOH3RXUmPYFWaBoLletQWHD1bi3Jy/+zE=;
        b=Wv+Aikc5fWzgctUffCSl5SpZmaqfLaajo7F4H7Gbi9R5PdH0Wk34EM+4qVUjXVkrYm
         0r2jn0Znwix7CHuX5Wko9ocul/EzipKwQHlqG0OtdTkNTsZcDWRjS8WH3K554sASZWpH
         7bxBNQz2cJIvLHM5BvsIf8m6athGePEeOqE7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979930; x=1693584730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJKdAvSeO4VOH3RXUmPYFWaBoLletQWHD1bi3Jy/+zE=;
        b=C6zzfad+7s/y7UBpZZpEUs29ixBvZZsVQ7Rr6MAzoM1eEMgCfMrK8vT9HspzKcV0n2
         bBkOn0VWotixxdRCiaSaTtUWxMVx1x8V9swe/0Z+ETEQj82Xo66sFmPd4KJFycKvsxOW
         q8FpyUp7NA/jFpcfvFPISneMdEdWqOqvU38SU/b3nG/eGx0hGV84MGJ2qmkEaOZiXR0/
         tXKhz0Kd+TFsLILeQnShz65na1lcksrKyalqz0J9Dt4wBa70CbccXYSb0XGYdX5LoL8w
         RNGk+jW5RhMdFupKOhQ1jnLM1EaRBGsBRfOTUa8Ug2QVVX82tqKkjpEH1N63DOqZ/xQy
         bUBA==
X-Gm-Message-State: AOJu0YwUJXNvaWVL9H9a4Wv8mOpXUqQ6TxlvhPrZn2D1W5SYUOBmCpYW
	YY0eC7xPxsU99oqG2Ugci5JifzH+g+tyBl17H3ZuNQ==
X-Google-Smtp-Source: AGHT+IEBHrqFG6LWnHGYuq/piq4gWrUiBxMwJVIvmD6hHxN9kT9eSyLoZ0oEcz6Qd/pumOLSwMISfSv3U10PbgFxNME=
X-Received: by 2002:a17:90a:bc92:b0:267:ee56:4c59 with SMTP id
 x18-20020a17090abc9200b00267ee564c59mr14047892pjr.35.1692979929795; Fri, 25
 Aug 2023 09:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280375109.282662.4109179404470188137.stgit@devnote2>
In-Reply-To: <169280375109.282662.4109179404470188137.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Fri, 25 Aug 2023 18:11:58 +0200
Message-ID: <CABRcYmKjv7rvhHQCbXHhUQm+W4coWJAHM+0epA58cnGHerx=yw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] fprobe: Use fprobe_regs in fprobe entry handler
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
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> on arm64.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>

