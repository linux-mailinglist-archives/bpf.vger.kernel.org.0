Return-Path: <bpf+bounces-15395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22A7F1D07
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1782C282779
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F633454A;
	Mon, 20 Nov 2023 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Ncp51E0u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600010C
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 11:00:52 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5c8c8f731aaso30399847b3.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 11:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700506852; x=1701111652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQgmN9kiiFUv/yUYDES7+R4dKGmbD4WD6ilxfsVbpNE=;
        b=Ncp51E0ulXr2wQd35a7Jg7WF2tcQ2nqny/EcR4tKlhuY1RyxfTWrb+CjO3z4YJUyPj
         fOpcNxHrNYoLe9dIQVCIC/SzrurTot/MmkO51uEItshWb4vHsiXjl86mCtjhvAPiADjc
         I5gPw/pB0W7XBLM7D+SbYHsgHVH+BdIINBE8nOCpVmM31E0szh59n/5zSFsrGbcDh8K5
         XQd6/rQjSG+27SM+pxIUKEKgYeqO7vuy1qc1z5/nxNKqF/vgnPAClfLjlZcfpN07vqRb
         gpHy9SUpMOcFxYjLQBZlTn2dRu7PM/x1iVEn/Jr4ddXBvanznUJgFLaL6s8UZa+eQFgv
         FfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700506852; x=1701111652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQgmN9kiiFUv/yUYDES7+R4dKGmbD4WD6ilxfsVbpNE=;
        b=eeTL15+Ub+PzsDcSEi425s4Org7036A7lJQT50BlY7PaE0InnjqRnJjaDln3+hX3YG
         kpKYGZ4lbqj15E2Vm2qbj7Nna6PpCd1t9Or2O35WuoU/R81rm+XRvWHR5CLWilB7vc8s
         saeqS0SbUSa18rfnVRqtelYfOeWqHr4PIc+MXDkagDwsMtlOv4i6GPBM/t3mxFXOR0lS
         NndsZG7xkkC1NFo9aoxlgmZB+Gy5TzcQFbU4eOIu2UQp7c2H4fe9InN/xy6tiFsc5llx
         hdhMX1cJ4rNa10eUxhRmehHR6iwJm52zaB0h62CVmIT5mdNPJFQwJ8gnG9I+A3vJi8kh
         omWg==
X-Gm-Message-State: AOJu0YzcPWz/2yvMnlqhboMQtbO/LTzjNbbPUCPzCBdMZMPcgtW+W5Qj
	jchGLVJfS8H+/xhXuUF6Bu/jwjp1ciPUTmLf7Doazg==
X-Google-Smtp-Source: AGHT+IHijewLNdzKmm2yoELtOh3qGSfo7dSjHQYmd7w//b/PorqUuRxCwtJp2L7dj6gkRE7At7EzGA41tq+WakFU0fw=
X-Received: by 2002:a05:690c:b11:b0:5ca:2691:10db with SMTP id
 cj17-20020a05690c0b1100b005ca269110dbmr5124867ywb.6.1700506852018; Mon, 20
 Nov 2023 11:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-16-jhs@mojatatu.com>
 <ZVZGYQDk/LyC7+8z@nanopsycho> <CAM0EoMkW1-a8yuxjEsqSnrmUx+ozn3CxvXTTwvEEPUrpk5UPRA@mail.gmail.com>
 <ZVsXKkD6ts+XcfE6@nanopsycho> <CAM0EoMnD0yWUyd3f42NaXsWmJZ5iuPZcySroFfRFSkk=p2e06g@mail.gmail.com>
 <ZVuI6AA1zM++S9Fu@nanopsycho>
In-Reply-To: <ZVuI6AA1zM++S9Fu@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 14:00:40 -0500
Message-ID: <CAM0EoMnp0g4=a9SUnzPT4mhKwU9Qaa-fgV3rE03k5sOHUd-F_w@mail.gmail.com>
Subject: Re: [PATCH net-next v8 15/15] p4tc: Add P4 extern interface
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 11:27=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Mon, Nov 20, 2023 at 03:02:49PM CET, jhs@mojatatu.com wrote:
> >On Mon, Nov 20, 2023 at 3:22=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Fri, Nov 17, 2023 at 01:14:43PM CET, jhs@mojatatu.com wrote:
> >> >On Thu, Nov 16, 2023 at 11:42=E2=80=AFAM Jiri Pirko <jiri@resnulli.us=
> wrote:
> >> >>
> >> >> Thu, Nov 16, 2023 at 03:59:48PM CET, jhs@mojatatu.com wrote:
> >> >>
> >> >> [...]
> >> >>
> >> >> > include/net/p4tc.h                |  161 +++
> >> >> > include/net/p4tc_ext_api.h        |  199 +++
> >> >> > include/uapi/linux/p4tc.h         |   61 +
> >> >> > include/uapi/linux/p4tc_ext.h     |   36 +
> >> >> > net/sched/p4tc/Makefile           |    2 +-
> >> >> > net/sched/p4tc/p4tc_bpf.c         |   79 +-
> >> >> > net/sched/p4tc/p4tc_ext.c         | 2204 ++++++++++++++++++++++++=
++++
> >> >> > net/sched/p4tc/p4tc_pipeline.c    |   34 +-
> >> >> > net/sched/p4tc/p4tc_runtime_api.c |   10 +-
> >> >> > net/sched/p4tc/p4tc_table.c       |   57 +-
> >> >> > net/sched/p4tc/p4tc_tbl_entry.c   |   25 +-
> >> >> > net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
> >> >> > net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 ++++++++++++++++++++++++=
+++++
> >> >> > 13 files changed, 5083 insertions(+), 10 deletions(-)
> >> >>
> >> >> This is for this patch. Now for the whole patchset you have:
> >> >>  30 files changed, 16676 insertions(+), 39 deletions(-)
> >> >>
> >> >> I understand that you want to fit into 15 patches with all the work=
.
> >> >> But sorry, patches like this are unreviewable. My suggestion is to =
split
> >> >> the patchset into multiple ones including smaller patches and allow
> >> >> people to digest this. I don't believe that anyone can seriously st=
and
> >> >> to review a patch with more than 200 lines changes.
> >> >
> >> >This specific patch is not difficult to split into two. I can do that
> >> >and send out minus the first 8 trivial patches - but not familiar wit=
h
> >> >how to do "here's part 1 of the patches" and "here's patchset two".
> >>
> >> Split into multiple patchsets and send one by one. No need to have all
> >> in at once.
> >>
> >>
> >> >There's dependency between them so not clear how patchwork and
> >>
> >> What dependency. It should compile. Introduce some basic functionality
> >> first and extend it incrementally with other patchsets. The usual way.
> >>
> >
> >Sorry, still not following:
> >Lets say i split the current patchset 1 with patch 1-8 (which are
> >trivial and have been reviewed) then make the rest into patchset 2
> >with a new set 1-8. I dont see how patchset 2 compiles unless it has
> >access to code from patchset 1. Unless patchset 1 is merged i dont see
> >how this works with patchwork or reviewers. Am i missing something?
>
> Why it would not work. Describe your motivation and plans and submit
> part of the work, the rest later on. No problem.

Sorry, still not following ;->
So push the trivial patches 1-8 for merge - then push rest in small increme=
nts?

cheers,
jamal
>
> >
> >cheers,
> >jamal
> >
> >>
> >> >reviewers would deal with it. Thoughts?
> >> >
> >> >Note: The code machinery is really repeatable; for example if you loo=
k
> >> >at the tables control you will see very similar patterns to actions
> >> >etc. i.e spending time to review one will make it easy for the rest.
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >> [...]

