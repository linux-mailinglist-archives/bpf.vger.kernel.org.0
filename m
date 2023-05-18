Return-Path: <bpf+bounces-846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A591707856
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 05:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB624280DB6
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 03:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465AF396;
	Thu, 18 May 2023 03:14:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823D391
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 03:14:46 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DB2D4C;
	Wed, 17 May 2023 20:14:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4eed764a10cso1883477e87.0;
        Wed, 17 May 2023 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684379683; x=1686971683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m6r5KOgtp+lWQnV5oKIW5XgjK3Hvy6Rsikt8ZrXkvI=;
        b=XbB1zc3tsIWE6i4QEMLnmu1l5tAMTDLjWRJBLfC/XpoKJHwSQG/b/Dc5z17SLHGKMF
         2arjbOcYeSGy0PqnUf8sAgO839giXbyrJ+0Pp5JPPPXsjAk0AbtwKACAOAmDRjWM5zPJ
         Flr5L/Gas/zNg72tqKBgIoc2QmZZn7iN3L2mjtNJS7RX9GDllSOQ/eb3ajjMLYObGKUr
         +IgjzEg+B4lpBtgM0hdcRffXO8N4AoWB9KExZVR00OwqRFWCuzxNaPcMee9kjxYqpnK3
         ypQZ95HPHTSFJ8LrAMRECqs8iyThWadCUGorAjuiu4RQIP8jRdrgf21C4oL6JVc4XGlA
         i1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684379683; x=1686971683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m6r5KOgtp+lWQnV5oKIW5XgjK3Hvy6Rsikt8ZrXkvI=;
        b=kNusrr/VpbXf0HsDrx/xolG+Lg6kdbv3zKGOdKdhbWOsNngfQDnzFo6zXvaTfWPw0p
         WJJn4OZmYAChmy9GPCDjILZMUsQbSd0TGaUE2VqgOGi+cb9DECxyWsQF4Q4LODC/WBG2
         a0lpO5BP51C+47C4/VD2deCQaGo4YENzmu0ciZTSuvJwbMfrseBHABGyJS/N9pGdkXye
         ohSefTvyEg0IjB8karwpgWJapTl9ve6DebHumdRcNVPUCrqsb0RJTYzn0L6x0JZV2HoI
         +nvk9/AR6GRN+XGLreZ9wKwW7tqO9HRCwLR6eFHzwfC/cLhD5dQpEki12B7lOCq9H5ya
         gx3g==
X-Gm-Message-State: AC+VfDyTMNuQVs0H6lpRouTghOCA/2anIrq3gyt25eEyT9L4nfBfmbk/
	NQ9I5qPyWkZ/tAgFyoRl5yEEC6VUhoMwGV5VbRAunEEVuGw=
X-Google-Smtp-Source: ACHHUZ79Bd0JCp/wqhDU9AQbtm81IjsmPQ+nG4B5LiYFUCyo6QoQRDDsdnGW49pLAatjSDK10Oxs92EELd7cd1TjQdo=
X-Received: by 2002:ac2:42ce:0:b0:4f2:5e4b:3e3f with SMTP id
 n14-20020ac242ce000000b004f25e4b3e3fmr717210lfl.61.1684379682997; Wed, 17 May
 2023 20:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain> <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
 <20230518001916.GB254@W11-BEAU-MD.localdomain> <CAADnVQJwK3p1QyYEvAn9B86M4nkX69kuUvx2W0Yqwy0e=RSPPg@mail.gmail.com>
 <20230518011814.GA294@W11-BEAU-MD.localdomain> <20230517220800.3d4cbad2@gandalf.local.home>
In-Reply-To: <20230517220800.3d4cbad2@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 May 2023 20:14:31 -0700
Message-ID: <CAADnVQLtTOjHG=k5uwP_zrM_af4RdS8d5zgmLnVFSmq_=5m0Cg@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
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

On Wed, May 17, 2023 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 17 May 2023 18:18:14 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
>
> > We should tell folks to use a group and give access to the group like
> > Steven said earlier.
>
> Could we possibly add an "owner" attribute to the event. That is, the
> creator of the event is the only one that can write to that event. Or at
> least by the user that created it (not actually the process).
>
> So if the user "rostedt" creates an event, only "rostedt" can write to or
> delete the event.

That can work, but why name is global in the first place?
Just make everything per-fd.

> The delete IOCTL is different than reg/unreg. I don't see a problem with
> adding a CAP_SYSADMIN check on the delete IOCTL (and other delete paths)
> to prevent this. It shouldn't affect anything we are doing to add this
> and it makes it so non-admins cannot delete any events if they are given
> write access to the user_events_data file.

sysadmin for delete is a pointless.
user_events_ioctl_reg() has the same issue.
Two different processes using you fancy TRACELOGGING_DEFINE_PROVIDER()
macro and picking the same name will race.

TRACELOGGING_DEFINE_PROVIDER( // defines the MyProvider symbol
    MyProvider, // Name of the provider symbol to define
    "MyCompany_MyComponent_MyProvider", // Human-readable provider
name, no ' ' or ':' chars.
    // {d5b90669-1aad-5db8-16c9-6286a7fcfe33} // Provider guid
(ignored on Linux)
    (0xd5b90669,0x1aad,0x5db8,0x16,0xc9,0x62,0x86,0xa7,0xfc,0xfe,0x33));

I totally get it that Beau is copy pasting these ideas from windows,
but windows is likely similarly broken if it's registering names
globally.

FD should be the isolation boundary.
fd =3D open("/sys/kernel/tracing/user_event")
and make sure all events are bound to that file.
when file is closed the events _should be auto deleted_.

That's another issue I just spotted.
Looks like user_events_release() is leaking memory.
user_event_refs are just lost.

tbh the more I look into the code the more I want to suggest to mark it
depends on BROKEN
and go back to redesign.

