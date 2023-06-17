Return-Path: <bpf+bounces-2781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A76733DCC
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 05:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D0C28191B
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 03:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD4A51;
	Sat, 17 Jun 2023 03:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D1A28
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 03:29:50 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4010C8;
	Fri, 16 Jun 2023 20:29:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9b2b7109dso11746961cf.0;
        Fri, 16 Jun 2023 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686972588; x=1689564588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irlWWANwbFv9WUSPO04X12DVZBYZ8ZDthJKp+8AQcVs=;
        b=Cvm+I8uFOumY9HA949yVpP8/xfbfW6hIv9hh/s7GpqLrazyPAAkzXks8mo0D9u9RI7
         AmRQJsHRffBXGqVAkvMi6wdHTwL/xsuyvMPyn/9KlOvwAiCAxkC26ghIPoBWQ5aFezI8
         1RbCnWltMB5kJQqN0M7fo7D05OJO8iI5nYSGawZt87KPbZ9tVLS6LIZ3HyPtV6JreY7X
         jwVoYJdoqJe3dD55HGvpC4r9Mbat0ZaDnBVNc1S80zZ0di1N/lUUZFcIRWUZZ23Bjz3o
         IAseZFmiWR5mDAjv6+u7GBZJaJ+Zs5iCOeIKmat+RoCCYdIjxhRGgGOqDW9j3yhedQM7
         jmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686972588; x=1689564588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irlWWANwbFv9WUSPO04X12DVZBYZ8ZDthJKp+8AQcVs=;
        b=gvkPVirbdhAqdp39J+ODqw4ygzLwlEFoo5JP3W5xQiP2BwsGkjBlLk12V6bHjECr0l
         ElpFk6SEHKF8y1mHhe4yDUvV6Ub/T4/lomeLLYCiJFS7Q6saal7KMbAM0AQ1uDvQEKG0
         rP/2ZBlLl1RyATe5sSkba1Td87qUDYDwcuDEzmdkqu6YmmG89Aw5ZOKOhUY0VWrg7org
         3KWN138/kRIYnHXGjlvVA0ubqfOLSOSxo86vdp5XIdWMwp57Tl5j7lQyRsQz31paCaUF
         FSkCy9gXs8H5Hhm/BxH/YnKM4s6bjUcGmj7IhFwln7A8RrZBt9jwbglKrjVHtBWNiefl
         SHtQ==
X-Gm-Message-State: AC+VfDz04rUVw+Mn+rQFgMUxrm0ZUGw2IlSaK+WjUuPFpLGprUcLfllZ
	FEcj5hC4kKE6g4K3QqqgLP3tPRR1lrHj2POOqCY=
X-Google-Smtp-Source: ACHHUZ56HEma2uylJu2hvdQ1E2uGt4n3b7EAlrKHC4q8M//MIosInZ1tYBSm8NlHkYjG21TJ8paGj2o4i3JKB+EmETw=
X-Received: by 2002:ad4:5be9:0:b0:62f:e5f7:8383 with SMTP id
 k9-20020ad45be9000000b0062fe5f78383mr3710768qvc.15.1686972588518; Fri, 16 Jun
 2023 20:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-11-laoar.shao@gmail.com>
 <CAEf4BzYTxEeaXLLajU-ka=OxPVh4LZERq210_A75mDZH+7t-yg@mail.gmail.com> <CALOAHbBNzu4YeDSwFQvUcZ4ATj-FgbWG--6BgeQryzMRq=mCRQ@mail.gmail.com>
In-Reply-To: <CALOAHbBNzu4YeDSwFQvUcZ4ATj-FgbWG--6BgeQryzMRq=mCRQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Jun 2023 11:29:12 +0800
Message-ID: <CALOAHbDxU94m8DQ_8AwKRyJ5DOw-NJDER7K7AjCLD3=hkPV4=w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/10] bpftool: Show probed function in
 perf_event link info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Sat, Jun 17, 2023 at 11:20=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Sat, Jun 17, 2023 at 4:41=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > Enhance bpftool to display comprehensive information about exposed
> > > perf_event links, covering uprobe, kprobe, tracepoint, and generic pe=
rf
> > > event. The resulting output will include the following details:
> > >
> > > $ tools/bpf/bpftool/bpftool link show
> > > 3: perf_event  prog 14
> > >         event_type software  event_config cpu-clock
> > >         bpf_cookie 0
> > >         pids perf_event(1379330)
> > > 4: perf_event  prog 14
> > >         event_type hw-cache  event_config LLC-load-misses
> > >         bpf_cookie 0
> > >         pids perf_event(1379330)
> > > 5: perf_event  prog 14
> > >         event_type hardware  event_config cpu-cycles
> >
> > how about
> >
> > "event hardware:cpu-cycles" for events
>
> Agree. That is better.
>
> >
> > >         bpf_cookie 0
> > >         pids perf_event(1379330)
> > > 6: perf_event  prog 20
> > >         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0=
x1338
> >
> > for uprobes: "uprobe /home/yafang/bpf/uprobe/a.out+0x1338"
> > for retprobes: "uretprobe /home/yafang/bpf/uprobe/a.out+0x1338"
>
> Agree.

BTW, should we also change the output of `bpftool perf show` that way?

- Old
$ bpftool perf show
pid 11898  fd 7: prog_id 6  kprobe  func kernel_clone  offset 0
pid 11898  fd 9: prog_id 5  kretprobe  func kernel_clone  offset 0
pid 11966  fd 9: prog_id 13  uprobe  filename
/home/dev/waken/bpf/uprobe/a.out  offset 4920
pid 11966  fd 11: prog_id 14  uretprobe  filename
/home/dev/waken/bpf/uprobe/a.out  offset 4920

- New ?
$ bpftool perf show
pid 11898  fd 7: prog_id 6  kprobe kernel_clone
pid 11898  fd 9: prog_id 5  kretprobe kernel_clone
pid 11966  fd 9: prog_id 13  uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
pid 11966  fd 11: prog_id 14  uretprobe /home/dev/waken/bpf/uprobe/a.out+0x=
1338

>
> >
> > >         bpf_cookie 0
> > >         pids uprobe(1379706)
> > > 7: perf_event  prog 21
> > >         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0=
x1338
> > >         bpf_cookie 0
> > >         pids uprobe(1379706)
> > > 8: perf_event  prog 27
> > >         tp_name sched_switch
> >
> > "tracepoint  sched_switch" ?
>
> Agree.
>
> >
> > >         bpf_cookie 0
> > >         pids tracepoint(1381734)
> > > 10: perf_event  prog 43
> > >         retprobe 0  func_name kernel_clone  addr ffffffffad0a9660
> >
> > similar to uprobes:
> >
> > "kprobe kernel_clone  0xffffffffad0a9660"
> > "kretprobe kernel_clone  0xffffffffad0a9660"
> >
> >
> > That is, make this more human readable instead of mechanically
> > translated from kernel info? retprobe 1/0 is quite cumbersome,
> > "uprobe" vs "uretprobe" makes more sense?
>
> Agree. Will do it.
>
> >
> > JSON is where it could be completely mechanically translated, IMO.
>
> Agree.
>
> --
> Regards
> Yafang



--=20
Regards
Yafang

