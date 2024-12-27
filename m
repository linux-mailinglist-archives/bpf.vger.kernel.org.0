Return-Path: <bpf+bounces-47649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D20B9FCFAB
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 03:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF299163AE2
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDA3595F;
	Fri, 27 Dec 2024 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q00A0dpW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C52C9A;
	Fri, 27 Dec 2024 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735267975; cv=none; b=K4ZoCTva3DDa+3mvO4lnDejP2ufPLrRVdav0CR+TFP/EDu8m6uwIpobmfIj2IynPjqzWIH+k5LrdKuTu58JClzW9VWoXEmU483TsAZK81QX4mBYNKMH4Y/spW1y4xDbXlz6Yn3DlL4xzWrdHPScx/BOi2tLQ7nPV+OPRmoZ+FPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735267975; c=relaxed/simple;
	bh=BtdX5xxb6mmrKi8dmG57x1JKlBg4u7JmhWgV16rWmjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iViiY8O4DYwkZaMsXo9GbNqgG+8Ho9uj41nMcDQt7HzDH8zItjvUyCqpQdtA/4lZO9joogLbeKF/kg7iwDE+WdVPNy2gZlCpQSlhV9JwoC4exgDDNuCPk9PbaePDN8i/a3e/LuNdqTpJg2uJiG2FH/kkUhAD3xzCBe5t0gvdFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q00A0dpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42E5C4CEDD;
	Fri, 27 Dec 2024 02:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735267974;
	bh=BtdX5xxb6mmrKi8dmG57x1JKlBg4u7JmhWgV16rWmjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q00A0dpW+a3yjbiiyBnlDlNxa3QKfsTSDUQV0TI7P9vVpM5R3kjKuzmTe+gKS6QsG
	 3ke3I15t4OZxKck3ya7EMY0V7DWD6wzlWj46sBsDF5c0R/+unp3y5HyF9eK0lZCXYx
	 /aKyZdmmUN4pHvpdf2+7+6luIVrpTvFRmhiA7NQWzDK69r8+UTBPMMwWRoIwLQNbzg
	 sS5BbrRl9OHl+KYCCpNqrwgQ5D8rg285hmREn8W2XY2aOIEz/Sb71wPFOBk6iuo4o8
	 /Lkk/m+2S1tmtT/ymLvKL5BgK9X7UPlOEVAAcBaNx9v65bR2DwEkERrvg4i+7manAg
	 ZVMIMbLTdh1Vw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53f22fd6887so6652866e87.2;
        Thu, 26 Dec 2024 18:52:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4W36Ath7NvJcCt8ZsWgjJMy3Kzi/3XHkOBKoaTYxmtMoijGXA3lE6UL2P/bdohg+DsYp+d+VWfyrMW9NV@vger.kernel.org, AJvYcCVZ4FVC/TwT/9kxE8GFEZbJlFkmNPFmfeGMH8AecR27OYPTbWE7Z9wAqgZRq43kPRB3J04=@vger.kernel.org, AJvYcCVpou8Ps1P9Ovx1NiwM2VK5fHkagS7gdersK1PFhv96lZ5hqUr7mj8tukKxhxOk86ZEt9gDzB6/K5MZlIKommiREpx/@vger.kernel.org, AJvYcCXp7nx6YU5qfwllDPKs+vfnvZTDICOz6wOKtQKv5B7kUTJ5C4XZQ6NuPRtu1hwrZ55/zh84r3hI+vFPn7Jj@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkld762zESGe8ic0m1zWh7mZH3xqtQ0A/XVxVmA1DKQe3QWEc
	dnqH6YgQygGUavwzPasPcHqJOKDjPvo4P1a92M/zZ7E6vIVuQCNWph5bIpNaJAdpy4Pf6OGBKd4
	4jASZDrubHx37xVlppxjeXLFR+1I=
X-Google-Smtp-Source: AGHT+IHRvxi6b/ALonIF1SSHMmgivh+GQCcn5JF34YPmhg1FuebNOsOKQTBGGAC57roqIgusUFr6THIwgAgd8muH2VY=
X-Received: by 2002:a05:6512:6d3:b0:542:1137:611a with SMTP id
 2adb3069b0e04-54229533db1mr9378740e87.17.1735267973360; Thu, 26 Dec 2024
 18:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home> <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
 <20241226211935.02d34076@batman.local.home>
In-Reply-To: <20241226211935.02d34076@batman.local.home>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 27 Dec 2024 11:52:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUCpzr+1ey0MKmyCdTbaVOq8o7_42t4x5BW=4dyy4wPQ@mail.gmail.com>
Message-ID: <CAK7LNARUCpzr+1ey0MKmyCdTbaVOq8o7_42t4x5BW=4dyy4wPQ@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 11:19=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 26 Dec 2024 15:01:07 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Thu, 26 Dec 2024 at 13:49, Steven Rostedt <rostedt@goodmis.org> wrot=
e:
> > >
> > > But then, when the linker removes these functions because they were
> > > overridden, the code does not disappear, leaving the pointers in the
> > > __mcount_loc locations.
> >
> > This seems entirely unrelated to weak functions, and will be true for
> > any other "linker removed it" (which can happen for other reasons
> > too).
> >
> > So your "fix" seems to be hacking around a symptom.
>
> Yeah, that's why this was just a POC.
>
> >
> > And honestly, the kallsyms argument seems bogus too. The problem with
> > kallsyms is that it looks up the size the wrong way. Making up new
> > function names doesn't fix the problem, it - once again - just hacks
> > around the symptom of doing something wrong.
> >
> > Christ, kallsyms looking at nm output and going by "next symbol" was
> > always bogus, but I think that's how the old a.out format worked
> > originally.
> >
> > But "nm" literally takes a "-S" argument. We just don't use it.
> >
> > So I think the fix is literally to just make kallsysms have the size
> > data. Of course, very annoyingly out /proc/kallsyms file format also
> > tracks the (legacy) nm output that doesn't have size information.
> >
> > But I do think that if you hit real problems, you need to fix the
> > *source* of the issue, not add another ugly hack around things.
>
> So basically the real solution is to fix kallsyms to know about the end
> of functions. Peter Zijlstra mentioned that before, but it would take a
> bit more work and understanding of kallsyms to fix it properly.
>
> I'm fine not doing the hack and hopefully one day someone will have the
> time to fix kallsyms. This was just something I could do quickly,
> knowing it is mostly keeping with the status quo and not actually
> fixing the root of the issue. I also needed to refresh my ELF parsing
> abilities ;-)
>
> I may take a look at kallsyms internals. I have some spare time before
> the new year to try and work on things I don't normally get time to
> work on.
>
> -- Steve


So, does the kallsyms patch set from Zheng Yejian fix the issues?

It was a long time ago that I reviewed his v1.
I need to take a look if we decide to go with that approach.

--=20
Best Regards
Masahiro Yamada

