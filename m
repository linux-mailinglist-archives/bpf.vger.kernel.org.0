Return-Path: <bpf+bounces-253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1171B6FCA25
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC37B281360
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925566116;
	Tue,  9 May 2023 15:24:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5824C17FE9
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 15:24:44 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA01729;
	Tue,  9 May 2023 08:24:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f1fe1208a4so3885793e87.2;
        Tue, 09 May 2023 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645881; x=1686237881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko7fzt9nOGMj8UcJACPmdJ37rpoFvFpIcWe4r0HuiUA=;
        b=sTgTHurDmGKxDtOnlVSkAhLPkTW1zo3AeBefovmRj/j61oY+wmDqzx3EK5fembdMXn
         fedDkv/XL9zQOZbz0OHhjmU20y29cAXQIa6oMDih0EfFzRSXYvz865vlB9yQZnuGMpwz
         LWNw1WVOO0NQUj8BY+F7Y3O1Vbpi2uUUzdxHpW49kEfdn9CJCXKaFhXIePtAwKTJFF9m
         SDAitzKH+ViHP0jcp1ZhIx4jQb2dtuRt9ccYJ2Bxd59GEZZIXoEEVZsKafK/Ot2DueJm
         aXGzw760HZrwAvbkLUCndnGUaD/XNpvmUj6OUnmjhIlJXH/Dk8+DA39gy1Ng2lxZNG9D
         dp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645881; x=1686237881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko7fzt9nOGMj8UcJACPmdJ37rpoFvFpIcWe4r0HuiUA=;
        b=SP3PLfEn3MIlrPReK5GM5luhl0roitz3p/wxHSLCtX7eH2NFR4E6TP4SqOeFsV5Qvx
         t/1Fy7gvF5rX9T8C8oqvX2CgFtENTiwoGFlIA1UUx5PCQeRajW2kcpaSnaEcjK3kPkS8
         BlOq/dZL/EQ4MOJLVS17dEtt/DRDXRf0alCqidm6Cz0cERDu7IvgxLj2IRjc2DZjk/19
         6kRixxxt006sVz8Z+rHr7LP5PJe4AqdQw52hLoWV3LYIhYUqA+867xM6U+Lj1L0Kw13K
         J9BLyRpgTuLzQcZO4eXJb3C7gGqyYP+7KlaLYoRsFBnJ6n9VWAKeR60QUxCQmJnRIWrc
         79RQ==
X-Gm-Message-State: AC+VfDx6kWOjqP2zHh6VFxqipiTq+7OuJn1B0UFqTOA0IYZwhIcms6aI
	n3JMTW9OSDK47brV4VYYJdBfNDlY9HIZyeKrwpAC9sBHSbY=
X-Google-Smtp-Source: ACHHUZ4SjZ4qo86WxxKUIJ/Bu0/inKxyyPbh66X5cGqOTGy6JV7MupaZQuR+oDw6wgU+MgNXDKdthrDInbs0bXQYFmg=
X-Received: by 2002:a2e:3012:0:b0:2a7:a719:5943 with SMTP id
 w18-20020a2e3012000000b002a7a7195943mr885570ljw.40.1683645880861; Tue, 09 May
 2023 08:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
In-Reply-To: <20230508163751.841-1-beaub@linux.microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 May 2023 08:24:29 -0700
Message-ID: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 8, 2023 at 9:38=E2=80=AFAM Beau Belgrave <beaub@linux.microsoft=
.com> wrote:
>
> Programs that utilize user_events today only get the event payloads via
> perf or ftrace when writing event data. When BPF programs are attached
> to tracepoints created by user_events the BPF programs do not get run
> even though the attach succeeds. This causes confusion by the users of
> the programs, as they expect the data to be available via BPF programs
> they write. We have several projects that have hit this and requested
> BPF program support when publishing data via user_events from their
> user processes in production.
>
> Swap out perf_trace_buf_submit() for perf_trace_run_bpf_submit() to
> ensure BPF programs that are attached are run in addition to writing to
> perf or ftrace buffers. This requires no changes to the BPF infrastructur=
e
> and only utilizes the GPL exported function that modules and other
> components may use for the same purpose. This keeps user_events consisten=
t
> with how other kernel, modules, and probes expose tracepoint data to allo=
w
> attachment of a BPF program.

Sorry, I have to keep my Nack here.

I see no practical use case for bpf progs to be connected to user events.

There must be a different way to solve your user needs
and this is not bpf.

