Return-Path: <bpf+bounces-834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B2D7076CD
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE93281777
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 00:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C94196;
	Thu, 18 May 2023 00:11:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63C160
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 00:11:44 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1064ED9;
	Wed, 17 May 2023 17:11:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac831bb762so14973551fa.3;
        Wed, 17 May 2023 17:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684368659; x=1686960659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K4d5YK+mpRfL2+wKbjuMm+AaFZH6AIR6I+UPmGqU/Y=;
        b=q4FcSYo0ZVvY8woxbEUXMbEneDH5IZ7xRida17Z0dgBFWqQKcvWinPASeeQ7nhKl1x
         gQhTr+a6CuwSaboe37hkoCHHZLqUGuohxaDUuk2yXaJ23HWZB2W+x8+fz3p+si/D3fkL
         3KlplqqvFx6qAW0kVj87EweMSU6TGVZgRpD7vpG6WlO5a+BOfNseXCWn1kFl3Tg9aRoT
         DyBHQ4Kh7LnF+rEtPhz1jAVCIm9qk8fti4eTFI7JXai8a22AZWtR59DCY8D8jxOatv08
         ngifggnQ0c2xw7X9TwD4H6UNfY1iRNXFQym8hZmwz2sHFM2xAYyuZlHyRi+c9cLdfNoT
         0wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684368659; x=1686960659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6K4d5YK+mpRfL2+wKbjuMm+AaFZH6AIR6I+UPmGqU/Y=;
        b=D7ThptEyZxAWhM6jDGppzLh1O8j1XWyhqqTgroq6DL0Q/SeyMQxqSuwrF0W/N6N3Q8
         Zj6CvSthYy9Prl0YjW9t/vn4cNQIYe3gBVExYxmSaP/VtZLEscGaTsKiSainAl7opsoN
         fYeMVzOX67LKsuObNtf8EPMGvRIusjC92LzzEeKKdQzPU3BRjKDXKaLxDYwfAT98/hW4
         8zOijgoWzS84J4uyX0thXMfQ2ADQHydJfwcOweIagA42S99UQ0bbXM7aVUWKYBl+nXgv
         /If5u6ghtdPf5AQOVy2N0cnwVRVUc/5SoKV9ehyHLw8+RVNKueBdUaxAyvx/Y+ELnOsT
         TN3A==
X-Gm-Message-State: AC+VfDz13fzDEK4zAwp8Qdqpt5CtbDkULGxEoLHv/Z5SV/pD9ZH8aXL7
	M70JchlTF0URhZ7+0jJJ/5olqoQJsbI1a3E3rio=
X-Google-Smtp-Source: ACHHUZ7r63TL1QTEMvvxRw19dpg2g5Y5FP7GyoaScfrkYDrZNBLodxQbBEhsK3dCexXlsoPkPtvt43TlVJlGKfYLPcM=
X-Received: by 2002:a05:651c:208:b0:2ae:f2ab:c632 with SMTP id
 y8-20020a05651c020800b002aef2abc632mr3312954ljn.7.1684368658470; Wed, 17 May
 2023 17:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517165028.GA71@W11-BEAU-MD.localdomain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 May 2023 17:10:47 -0700
Message-ID: <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Dave Thaler <dthaler@microsoft.com>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 9:50=E2=80=AFAM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
> >
> > >
> > > Looks like user events were designed with intention to be unprivilege=
d.
> > > When I looked at kernel/trace/trace_events_user.c I assumed root.
> > > I doubt other people reviewed it from security perspective.
> > >
> > > Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn'=
t sound like a good idea.
> > >
> > > For example, I think the following is possible:
> > > fd =3D open("/sys/kernel/tracing/user_events_data")
> > > ioclt(fd, DIAG_IOCSDEL)
> > >   user_events_ioctl_del
> > >      delete_user_event(info->group, name);
> > >
> > > 'info' is different for every FD, but info->group is the same for all=
 users/processes/fds,
> > > because only one global init_group is created.
> > > So one user can unregister other user event by knowing 'name'.
> > > A security hole, no?

...

> Regarding deleting events, only users that are given access can delete
> events. They must know the event name, just like users with access to
> delete files must know a path (and have access to it). Since the
> write_index and other details are per-process, unless the user has
> access to either /sys/kernel/tracing/events/user_events/* or
> /sys/kernel/tracing/user_events_status, they do not know which names are
> being used.
>
> If that is not enough, we could require CAP_SYSADMIN to be able to
> delete events even when they have access to the file. Users can also
> apply SELinux policies per-file to achieve further isolation, if
> required.

Whether /sys/kernel/tracing/user_events_status gets g+rw
or it gets a+rw (as your documentation recommends)
it is still a security issue.
The "event name" is trivial to find out by looking at the source code
of the target process or just "string target_binary".
Restricting to cap_sysadmin is not the answer, since you want unpriv.
SElinux is not the answer either.
Since it's unpriv, different processes should not be able to mess with
user events of other processes.
It's a fundamental requirement of any kernel api.
This has to be fixed before any bpf discussion.
If it means that you need to redesign user_events do it now and
excuses like "it's uapi now, so we cannot fix it" are not going to fly.

