Return-Path: <bpf+bounces-11329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115047B753A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 01:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B168FB20937
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 23:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E4405F7;
	Tue,  3 Oct 2023 23:39:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B303FB09
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 23:39:39 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32AAB4
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 16:39:37 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d81b42a3108so1707607276.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696376377; x=1696981177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYi9a5Lcbt9IRltWB1OppQxmM3lJh7jtqs7RskkmtuM=;
        b=akr0BuFBDqIHKuvrOrenO3ynvmkxFhp6rWxp9depfaFddya30/J3nulma71DBsbDpf
         R0hxKh0LqyEomKXYG/8YIqkRjGdeb+ot7c0gUD3o//v8eTCwRE3GaehFQpu+LyUfjvX/
         oDt/t2MAFumJRJJ6yB5KJegCvC0vQ/tHdtwGsnmAFOX2fh0iosuJmUsAZROgX7n/UFLr
         n4D00lQSK+GMyXk06nQOZqW+Khl9rPMws1xEGWbbXwivrzrE2rnY4o/JrXkl4ITm0Fsv
         ZJbljqf4gX06jo+jv7Fy7VqKVu92VAvHcCra2Y3Hnk4N7tYjf0qkco2tiT3bCouXUXdY
         7nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376377; x=1696981177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYi9a5Lcbt9IRltWB1OppQxmM3lJh7jtqs7RskkmtuM=;
        b=uiEiLAvlekPWM72HvpoALaR8LDzMO2VftPaWFY0ltsUh7Ssu0xTP13pno7Kz8KFfyt
         V8zGfLldcp8b7ydXzx5U0ZsqiD+2KH3bj5ezG3fux4e6+HJLHYrlv3Aj9QcmeeAVF4tp
         dpwS0yOzJ3af1KC06QQ1i9m4NQEB6MXunQ7/Da/SxnDUFiYC3G2v1dF7VpA0fRy3+5+2
         k5gSqt5Sfj5n0npkDIlneviKRiBKwIql2JV5HHzSKhBvvJY4j+jYqAV9UtcHQ2epj2sV
         ohKEdBWtAsfnrKOTr5JPiE9aYu1p0L/rmbyJbdWAJz0Y7ZIa3Yfif61j+jRQOCQYKujf
         mRqA==
X-Gm-Message-State: AOJu0YxBM9GtuFOMoIfXtt8EIcjvfeF6g8CrcRRrDjHVOOFoDy7LLAwI
	0FpiJLa+5cRKWWxdWZ4eFZP3yNRzWA6MBJ/U+hqF
X-Google-Smtp-Source: AGHT+IG/Dus7X+cunbXxgkUMUjQCjirv1MW6BUS7xU1MRXxm2CaYGpDUHnh1CG3uibgQeV4/s5V5YyIpR+DIBl+xXVY=
X-Received: by 2002:a25:2d05:0:b0:d09:96fe:ac23 with SMTP id
 t5-20020a252d05000000b00d0996feac23mr739387ybt.3.1696376376866; Tue, 03 Oct
 2023 16:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com> <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org> <51d6c605-25cc-71fc-9c11-707b78297b38@I-love.SAKURA.ne.jp>
 <202310021000.B494D0DD@keescook>
In-Reply-To: <202310021000.B494D0DD@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Oct 2023 19:39:25 -0400
Message-ID: <CAHC9VhQFywb+CG2hAuHGRkdo3iMEGVogrdV_S6dZhfWJ0ACvOg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 1:06=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Mon, Oct 02, 2023 at 07:04:27PM +0900, Tetsuo Handa wrote:
> > On 2023/10/02 0:44, Kees Cook wrote:
> > > On October 1, 2023 4:31:05 AM PDT, Tetsuo Handa <penguin-kernel@I-lov=
e.SAKURA.ne.jp> wrote:
> > >> Kees Cook said there is no problem if the policy of assigning LSM ID=
 value were
> > >>
> > >>  1) author: "Hello, here is a new LSM I'd like to upstream, here it =
is. I assigned
> > >>              it the next LSM ID."
> > >>     maintainer(s): "Okay, sounds good. *review*"
> > >>
> > >>  2) author: "Hello, here is an LSM that has been in active use at $P=
lace,
> > >>              and we have $Xxx many userspace applications that we ca=
nnot easily
> > >>              rebuild. We used LSM ID $Value that is far away from th=
e sequential
> > >>              list of LSM IDs, and we'd really prefer to keep that as=
signment."
> > >>    maintainer(s): "Okay, sounds good. *review*"
> > >>
> > >> and I agreed at https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-48=
4129c4c0ec@I-love.SAKURA.ne.jp .
> > >>
> > >> But Paul Moore's response was
> > >>
> > >>  No LSM ID value is guaranteed until it is present in a tagged relea=
se
> > >>  from Linus' tree, and once a LSM ID is present in a tagged release
> > >>  from Linus' tree it should not change.  That's *the* policy.
> > >>
> > >> which means that the policy is not what Kees Cook has said.
> > >
> > > These don't conflict at all! Paul is saying an ID isn't guaranteed in=
 upstream
> > > until it's in upstream. I'm saying the id space is large enough that =
you could
> > > make a new out of tree LSM every second for the next billion years. T=
he upstream
> > > assignment process is likely sequential, but that out of sequence LSM=
s that show
> > > a need to be upstream could make a case for their existing value.
> >
> > Excuse me? If the LSM community wants the assignment sequential, the LS=
M community
> > cannot admit the LSM value assigned to a not-yet-in-tree LSM.
> >
> > If "Okay, sounds good." does not imply that the LSM community admits th=
e LSM value
> > assigned to a not-yet-in-tree LSM, what did "Okay, sounds good." mean?
>
> I'm saying that if someone participates with upstream correctly, they'll
> get a sequential ID since that is the expected process.
>
> And if an LSM is out of tree for years and years in some large ecosystem
> that has deeply hard-coded the LSM ID but now wants the LSM to land
> upstream, then it's likely that an out-of-sequence ID would be accepted.
>
> My point is that there is nothing technical stopping an out-of-tree LSM
> from existing, and that the political issues for bringing a large
> out-of-tree LSM upstream are going to have plenty of other negotiations
> around maintaining operational behavior, of which and LSM ID is unlikely
> to be a sticking point. Every release that some code (LSM or not) is out
> of tree makes it that much harder to land upstream. (In other words, the
> challenges to upstreaming a long-time-out-of-tree codebase are much
> larger than dealing with an out-of-sequence LSM ID.)

Tetsuo, just in case there is any doubt in your mind, I agree with
Kees' comments above and I reaffirm my previous statement about LSM ID
guarantees.

As far as I can tell this RFC isn't really about dynamically loadable
LSMs, it's about blocking the LSM syscall work, specifically the LSM
ID tokens.  As I've said many times before, the LSM ID concept is
moving forward and if you can't respect that decision, at least stop
wasting our time.

--=20
paul-moore.com

