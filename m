Return-Path: <bpf+bounces-6625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B276BEA9
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD581C20750
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE972591A;
	Tue,  1 Aug 2023 20:44:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8274DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:44:08 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465F2698
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:44:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b703a0453fso93700121fa.3
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690922645; x=1691527445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLxU+cTW0JOvpOnc1vaBfz5cRaogAnOBhmrUuabB4Tw=;
        b=l3WqT13HzH39NnkGI68PTUEmH2e/JGme1q/E0vWcY1s4Y8oaZEHp7/TAhsqD/Iava5
         4leZHcrvqexg7ygL4KhgmYujubTk8tGlZJJqocnMYAfHRomXk8DyUEom5SXG7NzxEl3s
         g+XON2rBGfjJT4wzXYaUOglh3mDhjBE7SJD5z39Zywqsa7Bkx/qTLIwAmJz5Nd3Qr3KT
         LHxho5KjBfjtOoD4Ho62NXM9N8z1g0FjgxDz6YMICN0JfP4uimMSknvlKcWT0wEkG5bI
         QRtWEoXZmIWJXH/SvPeVjko2UavgLkF+Oc4KxAQE+m6nLEtG5WZTYvKqLj5W4T+vsWGj
         z2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922645; x=1691527445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLxU+cTW0JOvpOnc1vaBfz5cRaogAnOBhmrUuabB4Tw=;
        b=AkJGnKYguBKglLpM/ctX66hejh6GSyBIuH1QWKxxYoZ/0Vi5s3pxONLqreFc2xeRin
         lqY5G0G1TJKtBfan8ts16D2KXIZgBpAtQVWZ/5FXbKlyw/hFRlLdbtYcZcrBMqN74usL
         xodfBYKoOfDNZfL36aPWyH10jfWZ++cqHoMkNXB57wYHcKK+Z6p8yKbBPNFoxYGVD08N
         LGEo96c7aQpqpQ64DEK+yfYAlmPvd/wQO9g1RQS5q47YH7YiFqr9S4kP9ySDdm295wq2
         /YgQpOognyl3J4z8p0JAU9P7c6F6zDAKUhXc8UwTj45CXKRPG5B6L1kctmtP5WgMnot+
         oU7A==
X-Gm-Message-State: ABy/qLb0WhAB2IwQhBnB3+l6HYg3NYVj3Zv4XM6PGFUZmtLX3J19iC3u
	3afUGHxuGbkUrRFPW0gmTZImRINhxRQqFhxJgrc=
X-Google-Smtp-Source: APBJJlGLwQBmJYJDI8bMpGFmUmOi30AdZTK2HWnAdVR65r0757ZeNzW4EnONzLsrtolxYO46IVWY8sUjAD85J0JmF8Q=
X-Received: by 2002:a05:651c:8e:b0:2b7:25b2:e37a with SMTP id
 14-20020a05651c008e00b002b725b2e37amr3106513ljq.44.1690922644929; Tue, 01 Aug
 2023 13:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801073002.1006443-1-jolsa@kernel.org> <20230801073002.1006443-2-jolsa@kernel.org>
 <CALOAHbDdurfzh7jRfqWVVS5RFRT44fx3zjQRNN8B66HJDNogAQ@mail.gmail.com>
 <20f1cf2e-6145-000a-0344-4c03c7b54e28@linux.dev> <10d4b655-6232-efbd-9b5f-7d4637ef197d@linux.dev>
In-Reply-To: <10d4b655-6232-efbd-9b5f-7d4637ef197d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 13:43:53 -0700
Message-ID: <CAADnVQKmSbcYG75=jkhsvekaOkrz26+eO0gSrcbimCD_a-OBoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add support for bpf_get_func_ip helper
 for uprobe program
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 1:18=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 8/1/23 12:44 PM, Yonghong Song wrote:
> >
> >
> > On 8/1/23 4:53 AM, Yafang Shao wrote:
> >> On Tue, Aug 1, 2023 at 3:30=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> >>>
> >>> Adding support for bpf_get_func_ip helper for uprobe program to retur=
n
> >>> probed address for both uprobe and return uprobe.
> >>>
> >>> We discussed this in [1] and agreed that uprobe can have special use
> >>> of bpf_get_func_ip helper that differs from kprobe.
> >>>
> >>> The kprobe bpf_get_func_ip returns:
> >>>    - address of the function if probe is attach on function entry
> >>>      for both kprobe and return kprobe
> >>>    - 0 if the probe is not attach on function entry
> >>>
> >>> The uprobe bpf_get_func_ip returns:
> >>>    - address of the probe for both uprobe and return uprobe
> >>>
> >>> The reason for this semantic change is that kernel can't really tell
> >>> if the probe user space address is function entry.
> >>>
> >>> The uprobe program is actually kprobe type program attached as uprobe=
.
> >>> One of the consequences of this design is that uprobes do not have it=
s
> >>> own set of helpers, but share them with kprobes.
> >>>
> >>> As we need different functionality for bpf_get_func_ip helper for
> >>> uprobe,
> >>> I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
> >>> detect that it's executed in uprobe context and call specific code.
> >>>
> >>> The is_uprobe bool is set as true in bpf_prog_run_array_sleepable whi=
ch
> >>> is currently used only for executing bpf programs in uprobe.
> >>
> >> That is error-prone.  If we don't intend to rename
> >> bpf_prog_run_array_sleepable() to bpf_prog_run_array_uprobe(), I think
> >> we'd better introduce a new parameter 'bool is_uprobe' into it.
> >
> > Agree that renaming bpf_prog_run_array_sleepable() to
> > bpf_prog_run_array_uprobe() probably better. This way, it is
> > self-explainable for `run_ctx.is_uprobe =3D true`.
> >
> > If unlikely case in the future, another sleepable run prog array
> > is needed. They can have their own bpf_prog_run_array_<..>
> > and underlying bpf_prog_run_array_sleepable() can be factored out.
>
> Or if want to avoid unnecessary code churn, at least add
> a comment in bpf_prog_run_array_sleepable() to explain
> that why it is safe to do `run_ctx.is_uprobe =3D true;`.

I think renaming to _uprobe() is a good idea.
I would prefer if we can remove the bool is_uprobe run-time check,
but don't see a way to do it cleanly.

