Return-Path: <bpf+bounces-2945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44942737291
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30FF2812AB
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025572AB46;
	Tue, 20 Jun 2023 17:17:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD62AB30
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 17:17:27 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B266E11C;
	Tue, 20 Jun 2023 10:17:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f97e08b012so30465345e9.3;
        Tue, 20 Jun 2023 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281442; x=1689873442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GevHbbj7kJP/6gqvWzeD3ebnYmGXYKWeLrXOE2ENGuY=;
        b=HaxPUBFegopx2I86BBzNgH/LzH7dNOK027PDI4tJrr3BGDR8YVZ/AkP1I8B/WuuYDc
         2XD6oxob0yVk6BMrP8/Hm7HA09jXNlmgeq2/Yea+W8kce5N2aHsXQA61KSg0axicKH0y
         g1PhMa4dUpV8HLGUbuyjawqEDTmOJ3OOlD8le5ku5kGqc1lbWWjmfAN/w1qrBgFVHZjS
         cWmPrErU+gLyKU2ft0CyjPWqYLBiba0YbltWY+6i6WzK2zncsVr7OK210yscg0akzsAw
         JW8mB8GAjHMQAp5MdLXz08WPAar6vD8RCnb+73ovWQcLTv41gLnL/7/cgB2OoB+sxbPo
         OCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281442; x=1689873442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GevHbbj7kJP/6gqvWzeD3ebnYmGXYKWeLrXOE2ENGuY=;
        b=P6p/6abl0grwbjWJxD3oJusOvTZJtGmaYjj5C5r9suXnEh8VJSV2Ps3CtuKNmMHe7o
         /o/q2MK6IUDfqaCYYkTvTR6JgZiAFitlYt86aMu1MTvfQQpbEYaGQ+zwKBzFlND3iaOE
         n4NqeKU1Noj0Dzki2r2J+g4Qu/SUoxJ97IoAYRWWPLtjIYQDzyUZVkiu5s98QQqDwIBk
         pcgAr9o2D153V7n7jxxjs9FXdYUgDUsom20h0LImx+WUutxoOjFt7pYwh6VuRl8CjP71
         BIZW0ut7PUfmXDE6EXdyfTCur9g/ltb001L19HFJEMK14tkCOaONcd18sHGBMZpQh/Cq
         9yWA==
X-Gm-Message-State: AC+VfDxzmYOk/qo2uPrBB/gNLWY93oCmz8UfsNXLZyknQBeV0QBBOPgy
	FzC+hYSRo2fFRjTzR9hpKxl9otM6tDurvN6dPPE=
X-Google-Smtp-Source: ACHHUZ4KmIJd96r4Q5vmQwLQIP2m2nJ/cPYX5/HJGjNaM7w1pfrEkrkDBwvgs4eXq2aQU3F0Z0bFDrVth/XIimJo48Y=
X-Received: by 2002:a1c:7212:0:b0:3f5:146a:c79d with SMTP id
 n18-20020a1c7212000000b003f5146ac79dmr10833581wmc.15.1687281441904; Tue, 20
 Jun 2023 10:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-4-laoar.shao@gmail.com>
 <CAEf4BzaZEb_Uz21WDmQr7UC8Q50EfHDr2=dK477Z8fGEinCZ7w@mail.gmail.com> <CALOAHbC=fJfsE=r=o87sT36gq_OP-rLGv4yb-BuTxadu1KQ-pw@mail.gmail.com>
In-Reply-To: <CALOAHbC=fJfsE=r=o87sT36gq_OP-rLGv4yb-BuTxadu1KQ-pw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jun 2023 10:17:09 -0700
Message-ID: <CAEf4BzaySGo4UOxA1YkehPkW4n2A9XpUoeUTOM6zcBCQOB-gGw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 8:09=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sat, Jun 17, 2023 at 1:30=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > Show the already expose kprobe_multi link info in bpftool. The result=
 as
> > > follows,
> > >
> > > 52: kprobe_multi  prog 381
> > >         retprobe 0  func_cnt 7
> > >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> > >               ffffffff9ec44f60        schedule_timeout_killable
> > >               ffffffff9ec44fa0        schedule_timeout_uninterruptibl=
e
> > >               ffffffff9ec44fe0        schedule_timeout_idle
> > >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> > >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> > >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> > >         pids kprobe_multi(559862)
> > > 53: kprobe_multi  prog 381
> > >         retprobe 1  func_cnt 7
> > >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> > >               ffffffff9ec44f60        schedule_timeout_killable
> > >               ffffffff9ec44fa0        schedule_timeout_uninterruptibl=
e
> > >               ffffffff9ec44fe0        schedule_timeout_idle
> > >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> > >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> > >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> >
> > it all subjective, but this format is a bit weird where "addrs" and
> > "funcs" is in first row to the left. Just makes everything wider. Why
> > not something like
> >
> > addr              func
> > ffffffff9ec44f20  schedule_timeout_interruptible
> > ffffffff9ec44f60  schedule_timeout_killable
> > ffffffffc0953a10  xfs_trans_get_buf_map [xfs]
> > ffffffffc0957320  xfs_trans_get_dqtrx [xfs]
>
> It may be a little strange if there's only one function, but I don't
> mind doing it as you suggested.
>
> >
> > Not it's singular (addr and func) because it's column names,
> > basically. Can also do "addr func [module]".
>
> The length of the function name is variable, so it is not easy to
> determine where to put the "[module]". So I prefer to not show  the
> "[module]".

"func [module]" in the header will give a hint of what is that value
in square brackets. I didn't mean to align it into a third column


>
> --
> Regards
> Yafang

