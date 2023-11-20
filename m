Return-Path: <bpf+bounces-15360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D977F1527
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 15:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E190328250E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B121BDF0;
	Mon, 20 Nov 2023 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LC/g2Dpn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8EA1BC2
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 06:03:01 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c85e8fdd2dso30216517b3.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 06:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700488981; x=1701093781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bsm350Oy6uBYyP5hs0aT4LV3EylHgOadx5PqVgsUsmw=;
        b=LC/g2DpnLffW2I5EJ9aV61Zq7Ux6w2babBlD/mn0jOHe6ffo3FOwvy3xUr6hMZW8ZH
         j/dzjkqkPF8lTFT4sIXr+AkL5VsHcyuEkv8gB4DCoKsHdksmVKlrU8x5hqp3cU5kTMx6
         5CbkNh85iTJXKOoBMX7oYpSqPuNLzSWkBiz/r+ASd9smYBIC7dCpKWo3hi9b9ktDsjGY
         3aCs5RH8n1wNvzdb1rk7/Xd3MS97xkSpB/1t6Np4yfaFTVhXZTD3+bZqetyL7WTfgiCc
         6C9kqARj+oElrKh0GnlpZ7fqn2JWMFiaKZi629sIHlROSesbd21J73U618rvaFSSiPp+
         i8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488981; x=1701093781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bsm350Oy6uBYyP5hs0aT4LV3EylHgOadx5PqVgsUsmw=;
        b=RLmQISgnWq4yWyxX8ZztFkT1oDCGWyeiTlZ2vpLV34/M57WyrBAnQOqzzkwL+LXQkh
         Tj0bNeYBAFKyLCbOZb7RC5wBRBe+vLoLc9A8unXji2xs00BUdRRpXXJksV33qGXwc5iZ
         4tEjDJxtSUyTDVcMrJ0EJKK2kH9ehjgauClKOTdnYP67neVObjj3ZYw/2BCqyT9YOftw
         OW5UhhZinXueG882S7Zfa1cN2ElT4za4HuYDC3lAiA+ZKgAEhDF84KxmIQQpjBacvSqO
         5EvzYZWc1bR3ZjAGB84CZ5YgVUGJqVs/xxriUSx2bk8MuF58yhWGSYxNIFRSPWlLoc8y
         FZlg==
X-Gm-Message-State: AOJu0YzIaP7VZodDhgfumsrUBvO9e9Rv1m5nssLY2C+SNx0x1HuaoOfN
	A9DMz1cX7mfg/YzxPYCYSFlbF5R7SyAM7e1h2JsUXA==
X-Google-Smtp-Source: AGHT+IFKlKhCbUeYEIU3PGNDhZdrY+ZFQeiayHFPDQ9mZ1GypHbf1/HfB9bx/9Jos8iGlYVqGJeODLAuCmaYMZ2bFZk=
X-Received: by 2002:a0d:d247:0:b0:589:f9f0:2e8c with SMTP id
 u68-20020a0dd247000000b00589f9f02e8cmr2138727ywd.48.1700488981033; Mon, 20
 Nov 2023 06:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-16-jhs@mojatatu.com>
 <ZVZGYQDk/LyC7+8z@nanopsycho> <CAM0EoMkW1-a8yuxjEsqSnrmUx+ozn3CxvXTTwvEEPUrpk5UPRA@mail.gmail.com>
 <ZVsXKkD6ts+XcfE6@nanopsycho>
In-Reply-To: <ZVsXKkD6ts+XcfE6@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 09:02:49 -0500
Message-ID: <CAM0EoMnD0yWUyd3f42NaXsWmJZ5iuPZcySroFfRFSkk=p2e06g@mail.gmail.com>
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

On Mon, Nov 20, 2023 at 3:22=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Nov 17, 2023 at 01:14:43PM CET, jhs@mojatatu.com wrote:
> >On Thu, Nov 16, 2023 at 11:42=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Thu, Nov 16, 2023 at 03:59:48PM CET, jhs@mojatatu.com wrote:
> >>
> >> [...]
> >>
> >> > include/net/p4tc.h                |  161 +++
> >> > include/net/p4tc_ext_api.h        |  199 +++
> >> > include/uapi/linux/p4tc.h         |   61 +
> >> > include/uapi/linux/p4tc_ext.h     |   36 +
> >> > net/sched/p4tc/Makefile           |    2 +-
> >> > net/sched/p4tc/p4tc_bpf.c         |   79 +-
> >> > net/sched/p4tc/p4tc_ext.c         | 2204 +++++++++++++++++++++++++++=
+
> >> > net/sched/p4tc/p4tc_pipeline.c    |   34 +-
> >> > net/sched/p4tc/p4tc_runtime_api.c |   10 +-
> >> > net/sched/p4tc/p4tc_table.c       |   57 +-
> >> > net/sched/p4tc/p4tc_tbl_entry.c   |   25 +-
> >> > net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
> >> > net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 +++++++++++++++++++++++++++=
++
> >> > 13 files changed, 5083 insertions(+), 10 deletions(-)
> >>
> >> This is for this patch. Now for the whole patchset you have:
> >>  30 files changed, 16676 insertions(+), 39 deletions(-)
> >>
> >> I understand that you want to fit into 15 patches with all the work.
> >> But sorry, patches like this are unreviewable. My suggestion is to spl=
it
> >> the patchset into multiple ones including smaller patches and allow
> >> people to digest this. I don't believe that anyone can seriously stand
> >> to review a patch with more than 200 lines changes.
> >
> >This specific patch is not difficult to split into two. I can do that
> >and send out minus the first 8 trivial patches - but not familiar with
> >how to do "here's part 1 of the patches" and "here's patchset two".
>
> Split into multiple patchsets and send one by one. No need to have all
> in at once.
>
>
> >There's dependency between them so not clear how patchwork and
>
> What dependency. It should compile. Introduce some basic functionality
> first and extend it incrementally with other patchsets. The usual way.
>

Sorry, still not following:
Lets say i split the current patchset 1 with patch 1-8 (which are
trivial and have been reviewed) then make the rest into patchset 2
with a new set 1-8. I dont see how patchset 2 compiles unless it has
access to code from patchset 1. Unless patchset 1 is merged i dont see
how this works with patchwork or reviewers. Am i missing something?

cheers,
jamal

>
> >reviewers would deal with it. Thoughts?
> >
> >Note: The code machinery is really repeatable; for example if you look
> >at the tables control you will see very similar patterns to actions
> >etc. i.e spending time to review one will make it easy for the rest.
> >
> >cheers,
> >jamal
> >
> >> [...]

