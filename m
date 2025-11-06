Return-Path: <bpf+bounces-73876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC5C3CB0F
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FA818938F5
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819B34DB4E;
	Thu,  6 Nov 2025 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXcZJFdY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7933A01E
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448649; cv=none; b=iIe7ITFySEc9hf3MgCVrCJNIYu/lSo9iUWv3AeWAeAhpGk3Y5nFgybsVKAXbJVzSg//AbZhOd95+cuJnQl5M24WBt43oIQuW46E1mXOVuOfmYorBUsmSuOxUMKezSo9idWGCrKiGOZpr/6SWxDNGUJKwE69AlTxPl5wYfFacTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448649; c=relaxed/simple;
	bh=ooTjmqxoccW01NUKc0gS4keVxfN97wLoRDyeWtsB1zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ1YdC2zeuVuJw7cri53z320zXPKJteDT+Y2MJt2Vng8eR20rDFUvCOIbLZiyMyhoYY7jn3UYjBslAbpY+XHQ4LC3SeNK4DWfh3SyyGe/NFv0PFE9AWCrtkZC7oGYbvRNsV2Xw9AdWZCUTacBstIgXUNUp2m9VbabuScc2EpNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXcZJFdY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3c2db014easo223264766b.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448645; x=1763053445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooTjmqxoccW01NUKc0gS4keVxfN97wLoRDyeWtsB1zY=;
        b=YXcZJFdYZZt4bUpTXslGWVV6FNHqCGkOhaPwGV5aIpIXvNQ7lgENRMnf8ZUq12Xvc+
         6CjLV4KJCP1jWJmggXgpzrRO52Rtng59NcIOUAcHqf30tMOTK+/gowwLXcTVdlLVJ9ET
         +31xvTIXbs/VBcZwWwkl3WfB5urXunRG280XbcKvSiZgG7qaPQT5DRpsjUSlWFIVASdN
         oQN1SL0H5b3HsEJFidkmZTYYSL13v+ilhTBnJGDPyrJbasqgXk7HikW3VSRuk6PQlY/n
         JDiOz3WpPScJXojGKmwy0E7jJ4nBn8TTuQO2yobqVcmxsdo0iiw0cX7LFts3kyUdjuQJ
         p5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448645; x=1763053445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooTjmqxoccW01NUKc0gS4keVxfN97wLoRDyeWtsB1zY=;
        b=IWAKdS7eVBPUxVR7k7HyAPtsADBpVVMLSP07gI0ByZHrzmgraWbwGRhaO/MDKuPK+G
         qJ/q6KP6E8sTmj28VlxxwpFCHIbdgAtE3nyOzr2Rf4DrNVHEy/uXcJpNgBv5FwTJCSQN
         jsA4din7jROUmIoJ7+83VBONld+ZlPfLNTVVJ9TFrm8juBRWvpwbCGoj1AM0aFN8wqcx
         T0i47zKgK0xV+PLsYskJ7vhHd3f288fC4ObKQzMGDg3GJF6EoVWOfnlBOsLZvK71qYNH
         SAElsD6l2Vp8XxXnfg85ewB6uajhU7D/GqjslNzC0B8Ldrsob9TrrKCMFi7zDD2wBdUT
         3YYA==
X-Forwarded-Encrypted: i=1; AJvYcCUEXmnvI4FQujIFW3eXHPQe7VL8HoGVksipJKKR0ChBq+TfgnXN51FOh6SkyOQPketR8gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUFBPx4nfToqW4mO/LYXsXNcL7JEI+1hqi/qhZWqTFzafkumO
	5waRvvYG7neTZstCZNqf4Mhb75NM14gek2WWgzLmnm4X1EmHd0MeEkChC+md4zjnikCGreUVMBN
	TNW+681NFvjz1ColDLXkudW03p1oH0Cc=
X-Gm-Gg: ASbGncsQpsnkXwV5oGCFVRICZZzU0631PqzDMo075i3rCNAos2HovQCEQZF+nThpu2k
	QtqdtPqQK4NDw3zdQYgmjr7cccHv3AqcboyhGU/xT5OSJyPCnScYregMSr4W3EgComBb4+024IJ
	PxnNMQI7eSr/IvuvbuN3wKLdQuh77XIuuXP3kcvN8wHY0SnIh80+rajQr9bgZKwYtINAJEMLoPj
	AkipGx8LToCIYkwccmXe68hfaWYdeUVqbPDDGKwl8a3aqqp5hetDFxqJN/jZ358KK+410hUzrl4
	vSBNOOHjBA4=
X-Google-Smtp-Source: AGHT+IHNlxtI/JVMPHyR2Z3tqo6lrMJ91iBd+Gb9TQGi/Q/RZ1cmuJNwlQvKQ2BQLxtl3dEXYaCjoMJZUAcjOf81P2Q=
X-Received: by 2002:a17:907:d644:b0:b72:adfe:10a9 with SMTP id
 a640c23a62f3a-b72adfe1230mr193936366b.11.1762448645279; Thu, 06 Nov 2025
 09:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CAEf4BzZcrWCyC3DhNoefJsWNUhE46_yu0d3XyJZttQ8sRRpyag@mail.gmail.com>
 <CAADnVQ+ZuQS_RSFL8ThrDkZwSygX2Rx49LBAcMpiv3y4nnYunQ@mail.gmail.com> <3660175.iIbC2pHGDl@7950hx>
In-Reply-To: <3660175.iIbC2pHGDl@7950hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 09:03:48 -0800
X-Gm-Features: AWmQ_blXHVq0CyBxiR3axWozOfhTXkCji6HUu3bJQHr4b4xjx0v3XaMrOqRyL3g
Message-ID: <CAEf4BzZoyrSdV6SbcA7in=51==en2aoEcmvS6=vz-fixLS9M_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:15=E2=80=AFAM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2025/11/6 06:00, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 9:30=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Nov 4, 2025 at 6:43=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 4, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> [......]
> > > >
> > > > Instead of all that I have a different suggestion...
> > > >
> > > > how about we introduce this "session" attach type,
> > > > but won't mess with trampoline and whole new session->nr_links.
> > > > Instead the same prog can be added to 'fentry' list
> > > > and 'fexit' list.
> > > > We lose the ability to skip fexit, but I'm still not convinced
> > > > it's necessary.
> > > > The biggest benefit is that it will work for existing JITs and tram=
polines.
> > > > No new complex asm will be necessary.
> > > > As far as writable session_cookie ...
> > > > let's add another 8 byte space to bpf_tramp_run_ctx
> > > > and only allow single 'fsession' prog for a given kernel function.
> > > > Again to avoid changing all trampolines.
> > > > This way the feature can be implemented purely in C and no arch
> > > > specific changes.
> > > > It's more limited, but doesn't sound that the use case for multiple
> > > > fsession-s exist. All this is on/off tracing. Not something
> > > > that will be attached 24/7.
> > >
> > > I'd rather not have a feature at all, than have a feature that might
> > > or might not work depending on circumstances I don't control. If
> > > someone happens to be using fsession program on the same kernel
> > > function I happen to be tracing (e.g., with retsnoop), random failure
> > > to attach would be maddening to debug.
> >
> > fentry won't conflict with fsession. I'm proposing
> > the limit of fsession-s to 1. Due to stack usage there gotta be
>
> I think Andrii means that the problem is the limiting the fsession to
> 1, which can make we attach fail if someone else has already attach
> it.
>

Yeah, I wasn't worried about fsession vs fentry interactions. I was
(still am) worried that whenever I'll be deciding to use fsession I'd
have to think about (and implement) fallback plan in case fsession
attachment fails because (presumably) someone else already used
fsession on the function. Just too much hassle to bother with fsession
at that point.

> If we want to limit the stack usage, I think what we should limit is
> the count of the fsession progs that use session cookie, rather the
> count of the fsessions.
>
> I understand your idea that add the prog to both fentry and fexit list
> instead of introducing a BPF_TRAMP_SESSION in the progs_hlist.
> However, we still have to modify the arch stuff, as we need to store the
> "bpf_fsession_return". What's more, it's a little complex to add a prog
> to both fentry and fexit list, as bpf_tramp_link doesn't support such
> operation.
>
> So I think it's more clear to keep current logic. As Andrii suggested,
> we can reuse the nr_args, and no more room will be used on the
> stack, except the session cookies.
>
> As for the session cookies, how about we limit its number? For example,
> only 4 session cookies are allowed to be used on a target, which
> I think should be enough.

I think Alexei's concern is not so much stack space usage
(realistically you will almost never have more that 1-2-3
fsessions+fentry+fexit programs per trampoline), his concern is code
complexity in arch-specific trampoline generation code. And I share
the concern. But if we do support 4 session cookies, we might as well
just not put any artificial limits because code complexity-wise this
won't change anything.

So I think we should decide whether we add fsession with session
cookie as a concept, and if yes, then not add unnecessary
restrictions, as at that point the code complexity won't really change
much.

>
> I can remove the "fexit skipping" part to make the trampoline simpler
> if you prefer, which I'm OK, considering the optimization I'm making
> to the origin call in x86_64.
>
> Therefore, the logic won't be complex, just reserve the room for the
> session cookies and the call to invoke_bpf().
>
> Thanks!
> Menglong Dong
>
> > a limit anyway. I say, 32 is really the max. which is 256 bytes
> > for cookies plus all the stack usage for args, nr_args, run_ctx, etc.
> > Total of under 512 is ok.
> > So tooling would have to deal with the limit regardless.
> >
>
>
>
>

