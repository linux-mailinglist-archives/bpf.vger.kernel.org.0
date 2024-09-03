Return-Path: <bpf+bounces-38800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D17596A566
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C94D1F24409
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AFC18DF91;
	Tue,  3 Sep 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbjv4wZS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95F18BC05;
	Tue,  3 Sep 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384483; cv=none; b=ZYIdRqrI3gh4BMO+y3Y0we5op6z2VEG1vHpK6Lm78TTlHsXfewp9BnnehSLoxTqVdofJlDKL1NR9IfLbOQQaifjTVbFaCyGv7x0YIhI5XoPRQo3hUq0Oyh5AxvsA/H8LLuwupHviXdIzaurVprmGiQhCpaTCqCsR9Tx82nDWwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384483; c=relaxed/simple;
	bh=WZhURiUNTol60UwJCmuV5E8L9XzOE2w/tYB59LnQ8yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+fRDyWgSTNdHfm+hOb8wcCQ5shUXfg+5DhUwsP7tqJlgugfd7C9rkabI0OUzx4hJNap2Rfr7CCIB192XNxMnxRuQ/DvDTrsd/+vlgJznO10bUfc7XWvBmFQQKaCuq/X6J/Wr/EEts+ikt5nO9m+TmP9Jjh2pZfEYj2Xfmj8gTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbjv4wZS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d892997913so2273639a91.3;
        Tue, 03 Sep 2024 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384482; x=1725989282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZhURiUNTol60UwJCmuV5E8L9XzOE2w/tYB59LnQ8yk=;
        b=mbjv4wZSTcK8sXCD5I2DDobmhjLpsgDVy5zE+tABvwVUvTOSpd10/nznNAHrrbTNi8
         gXegvDSxD7oeKWOKCALAJ8M3pOLjaAAeEKiJTzO0bHQv0eC6RlQN0a2LYGKXsUVV+cAm
         ZriOPar0+rWSa4yE1cWlaohgfbISiJsBlTEb01pDZYev592yz29UdVXxylje4BeAz0Ng
         oOGxLblXi7ZrZ/CoOHhcz1OTP7g/RDYnaJhIV56uEO//eyf+4nSkhXI/eY3reG9/H6+I
         EzZ0lPrisHh6IJP7T955DN7PJtaz1QKpUY+qui49YHy1jJzrkJC+KpnOKPxTzPboMOOX
         CsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384482; x=1725989282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZhURiUNTol60UwJCmuV5E8L9XzOE2w/tYB59LnQ8yk=;
        b=VQMJDeWhUZIUSW5fnF8NCtLfjjl29y/u98SWYtgFRDCua+jZ6F5If8tnFfNHYOqGPU
         l0KNmS53QkZlfI7BNR3EtaI9ZRuej123tfMoJMLXYJBGwVPSC4Nh4TuvPdqz3GAmd5DP
         sald5FSDEQqEWls0+StOtmah0b8dtP4QZqhqcZH9x0/XuV9u6gNdNbc8TIu24lp+Ogor
         2OLH8nWzmq7EkedSHh4jFEGZ9Ua9hOztq2okGheeWyJvoxhM+Juy5HFeUMoDvyNTu5af
         vdOue2xNCYlIYvEmrR74fIIZYJgIlViO7FE8khJR1VhifDDLR7PtQudqYaEtcIZIfMJq
         N5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSEGCe4IIfwihO6tL0EewHJwKL8lxdlibmPm9dUCJxaoaF6uORSFmExUk8cn8uhtN1pG1nLdnKj16sCUdIibQpbyl9@vger.kernel.org, AJvYcCUrZr/TglkqGADwD0lXEhpliJxExx9idAGHafDdKJowmq3mEoq083PNhnAH57pEx1sdQrQ=@vger.kernel.org, AJvYcCVbrnRiWYH9gd0B0fkBeaJeVGVwSu0TjoCw7owbZ27wLo774RVr9Sj3YmynvKvI7J2B1iCdqPgTgzTuSXYM@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPih6Chz2Dn3cIKor3DnzzSXKpMOaahA/eya4HJSB4qApk2M6
	U0spCbiRE/Nk08QYJ8EaZpjH9HJSRyv0a1TbskCD6cNlGzRLba4PNd3yDLne70Lv4to8rnDfisX
	4ab+aZzx1/9cGdlI67kToKoy7U+4=
X-Google-Smtp-Source: AGHT+IGameP0HKRUfKRVgGXKvRTBH/w/+aYW01SyIu6o8tpRyb8OJwxrNgvkFe6WM0FBszSSEtDoJZL9LIM33M4rsg0=
X-Received: by 2002:a17:90b:88f:b0:2d8:898c:3e9b with SMTP id
 98e67ed59e1d1-2d890564db2mr10964977a91.25.1725384481802; Tue, 03 Sep 2024
 10:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183741.3331213-1-andrii@kernel.org> <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava> <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava> <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com> <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
 <20240831161914.GA9683@redhat.com>
In-Reply-To: <20240831161914.GA9683@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Sep 2024 10:27:49 -0700
Message-ID: <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 9:19=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/30, Andrii Nakryiko wrote:
> >
> > On Fri, Aug 30, 2024 at 1:21=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > I'll probably write another email (too late for me today), but I agre=
e
> > > that "avoid register_rwsem in handler_chain" is obviously a good goal=
,
> > > lets discuss the possible cleanups or even fixlets later, when this
> > > series is already applied.
> > >
> >
> > Sounds good. It seems like I'll need another revision due to missing
> > include, so if there is any reasonably straightforward clean up we
> > should do, I can just incorporate that into my series.
>
> I was thinking about another seq counter incremented in register(), so
> that handler_chain() can detect the race with uprobe_register() and skip
> unapply_uprobe() in this case. This is what Peter did in one of his serie=
s.
> Still changes the current behaviour, but not too much.

We could do that, but then worst case, when we do detect registration
race, what do we do? We still have to do the same. So instead of
polluting the logic with seq counter it's best to just codify the
protocol and take advantage of that.

But as you said, this all can/should be addressed as a follow up
discussion. You mentioned some clean ups you wanted to do, let's
discuss all that as part of that?

>
> But see below,
>
> > I still think it's fine, tbh.
>
> and perhaps you are right,
>
> > Which uprobe user violates this contract
> > in the kernel?
>
> The only in-kernel user of UPROBE_HANDLER_REMOVE is perf, and it is fine.
>

Well, BPF program can accidentally trigger this as well, but that's a
bug, we should fix it ASAP in the bpf tree.


> But there are out-of-tree users, say systemtap, I have no idea if this
> change can affect them.
>
> And in general, this change makes the API less "flexible".

it maybe makes a weird and too-flexible case a bit more work to
implement. Because if consumer want to be that flexible, they can
still define filter that will be coordinated between filter() and
handler() implementation.

>
> But once again, I agree that it would be better to apply your series firs=
t,
> then add the fixes in (unlikely) case it breaks something.

Yep, agreed, thanks! Will send a new version ASAP, so we have a common
base to work on top of.

>
> But. Since you are going to send another version, may I ask you to add a
> note into the changelog to explain that this patch assumes (and enforces)
> the rule about handler/filter consistency?

Yep, will do. I will also leave a comment next to the filter callback
definition in uprobe_consumer about this.

>
> Oleg.
>

