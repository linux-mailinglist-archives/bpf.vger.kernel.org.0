Return-Path: <bpf+bounces-22549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321588608AC
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 03:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDAC1F24A0A
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B079B67A;
	Fri, 23 Feb 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAU81YnL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D41B64C;
	Fri, 23 Feb 2024 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653890; cv=none; b=Wrm8SmRIHFSahTj4s3vOM0HvSCFtIy/wUHbhZuKxJNvOuM47s3ynxMk63v09Y8DXjqxdU0jkV2Ud3Iooy9rLvsijmn6/mjUM412piTBXTB3zFvw2N/W1QS2suazU703pl0QdcrxLXMWYVPSIILrdUeqLwZCTxnKXj6YucrRU/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653890; c=relaxed/simple;
	bh=8ejT+LrVX/4RdW4wa47l2VUvGiguesRa+VgG4maP9FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lktdSxUNai5DNZBNx3qHBV12qKZl2l0d+F3IR9rNu/rnA8x7TC6R5J23SQbKwpLASem6+yD3g5/PxH0yTO8nVN3V0ID+85Kr9j1/USi6lLwp547zaOH58Gt/kv4IBeyE5SR7g/OjX/ZAggBOAmGKbeXNZUwdFhiczenRuGq6Uw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAU81YnL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso122471f8f.2;
        Thu, 22 Feb 2024 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708653887; x=1709258687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nyxvpi0xE/P/bl5O4PoDj0ei2BsOzwSCujLwQU9ULXc=;
        b=mAU81YnLYcyXMxCLbebhwL5W5Tb1wBu3o4a4/fGXm5g4joALMEUT10k0Uohy/9HPK8
         MaWfgYYrpXe77K+4JycIUOY6Fh/ucT8DY/Nkp3lWW2ZzNpnHcgPbekRr9M8qAo8yqXNA
         DuRrB+Kjxfo6UwbPQKjsT3sdiCxY6WbTSsg2cdX0SauQ+C2vWIFTH/5G63qUHo9aS+QD
         CI/0quemxKQjGdh74oQbRvHDGoRvDfPFoZ5OcMnJbnEYssaZaDpitmBTlHFHrAq916GZ
         ZvaSQClCKIPDNkGwWdRMhhPcT34a9K8Zw/sTPW6FajkH09tJiqmBdEm8RjE0kOY42jLW
         5x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708653887; x=1709258687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nyxvpi0xE/P/bl5O4PoDj0ei2BsOzwSCujLwQU9ULXc=;
        b=XXuYPWQ20c68lYx90XKXI/FbNFgOtkLTt/KGBEwzQ14/8ktcb1hGfY27RTLeVeXQRw
         Gm4HnqLe2JwKniruBvlMI7OstZFB+bmHUTMFWM/c1Yk3yVgySrGhZgGTUIoaV6Iypg3X
         3egY1RBUIvEDhvjfaZufLc4ia4wGiY6x34QcDrrbuIi4zPgg00bH9MdbLg5jcwBbcida
         6Ndrmfgwvo833hLEl/0MZUl8+wcCKMvXK7odZTxQYYuvnUFlCIVpaEcjZe+jouftPvWK
         jlMGVsY3iAX3qC0vDLMyvgza9vQRvl1EG4AEJLzsxJW6+RPYpHiF9lMgWZnpAE2fGXgl
         R5mw==
X-Forwarded-Encrypted: i=1; AJvYcCV64cGbK1Gs3ItCz/OMoRm1m4q3DRvVBbjzA5xTwvctM4Rw2LEk9YT1lV30SqitCzDPacevywc3eT1WIGKvaDHVsQ7hqTKPMDdyBegvi1TfjfoGnKvdnbUO9M3z0C2gYTIO
X-Gm-Message-State: AOJu0YyJs2Rju/nLzbgS7jhYHNpF3fCO+st801Qh4q7zJvnchAE0J5VH
	Hpvt39rt+rNMbr+MOP1PFq25c3LWN/Rw04ATx9UAigXmVt6hKRjb5BvqBHNnanYTKDanA7+d7z2
	aL3otzXWDXTnMnmAKRYtM8AXg1rA=
X-Google-Smtp-Source: AGHT+IHmUwPglAVusOGqOdl5hW5f2mZgmhM3jhm2xeuOiIAE4he5enBJIMd4q7u84smJCQGPeYCb3qzJi4WN3ibmHdQ=
X-Received: by 2002:a5d:6512:0:b0:33d:6984:3f80 with SMTP id
 x18-20020a5d6512000000b0033d69843f80mr461742wru.67.1708653886707; Thu, 22 Feb
 2024 18:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125225.72796-1-puranjay12@gmail.com> <20240201125225.72796-2-puranjay12@gmail.com>
 <ZdegTX9x2ye-7xIt@arm.com>
In-Reply-To: <ZdegTX9x2ye-7xIt@arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 18:04:35 -0800
Message-ID: <CAADnVQLGGTshMiQAWwJ9UzrEVDR4Z8yk+ki9pUqKLgcH0DRAjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] arm64: stacktrace: Implement
 arch_bpf_stack_walk() for the BPF JIT
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Will Deacon <will@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:28=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Feb 01, 2024 at 12:52:24PM +0000, Puranjay Mohan wrote:
> > This will be used by bpf_throw() to unwind till the program marked as
> > exception boundary and run the callback with the stack of the main
> > program.
> >
> > This is required for supporting BPF exceptions on ARM64.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  arch/arm64/kernel/stacktrace.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktr=
ace.c
> > index 7f88028a00c0..66cffc5fc0be 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/efi.h>
> >  #include <linux/export.h>
> > +#include <linux/filter.h>
> >  #include <linux/ftrace.h>
> >  #include <linux/kprobes.h>
> >  #include <linux/sched.h>
> > @@ -266,6 +267,31 @@ noinline noinstr void arch_stack_walk(stack_trace_=
consume_fn consume_entry,
> >       kunwind_stack_walk(arch_kunwind_consume_entry, &data, task, regs)=
;
> >  }
> >
> > +struct bpf_unwind_consume_entry_data {
> > +     bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp);
> > +     void *cookie;
> > +};
> > +
> > +static bool
> > +arch_bpf_unwind_consume_entry(const struct kunwind_state *state, void =
*cookie)
> > +{
> > +     struct bpf_unwind_consume_entry_data *data =3D cookie;
> > +
> > +     return data->consume_entry(data->cookie, state->common.pc, 0,
> > +                                state->common.fp);
> > +}
> > +
> > +noinline noinstr void arch_bpf_stack_walk(bool (*consume_entry)(void *=
cookie, u64 ip, u64 sp,
> > +                                                             u64 fp), =
void *cookie)
> > +{
> > +     struct bpf_unwind_consume_entry_data data =3D {
> > +             .consume_entry =3D consume_entry,
> > +             .cookie =3D cookie,
> > +     };
> > +
> > +     kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, current,=
 NULL);
> > +}
>
> Too many "cookies", I found reading this confusing. If you ever respin,
> please use some different "cookie" names.
>
> I guess you want this to be merged via the bpf tree?

We typically take bpf jit patches through bpf-next, since
we do cross arch jits refactoring from time to time,
but nothing like this is pending for this merge window,
so if you want it to go through arm64 tree that's fine with us.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thank you for the review!

