Return-Path: <bpf+bounces-78254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCEBD065A3
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE60C302D8A5
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 21:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852733D4E9;
	Thu,  8 Jan 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqQXkztT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B47299928
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908617; cv=none; b=louX2HRfIpBPyfU/8T17riEuk+SiKoyz1Mk3V8jJimBspXRWN0yxm9E0FYPGVXb2KUQNlzla9QcGL+7qt1WykPocqcxN7vw77Hj+PF4Mih0iqmgdcAwylgUcIs3EGit20BakIThqSJXyFnCoHRu4Z55V2iGcr5UCa0snEJEhJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908617; c=relaxed/simple;
	bh=fmxiSBWVDk1vJjcA2pz8P8m02hTWUbmVu5dfvA2DDi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5yfTjsmpGln/6L2nzOjNUjTCGo8X/KyGAf8HDtFQ/OnNMiUzZGvU0cyaBAbZiheN1zmpXTRWaAskrF596zA0S4xTfJ+eFz3iCWaEs9E8eVFBM5HfmUcBT3qNGr2nhRQZaxhsglL6tTuZ686blRvv3gxWvpGf3Cup1YbgveKXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqQXkztT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so735476f8f.2
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 13:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767908615; x=1768513415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu0wRyydytWJO9gvWuImfkZVNSnne90b1xi/m4393gs=;
        b=nqQXkztTmSEomYLFSh329y/AlShbA9NaAJEUCnEc9+AiTOwsqJdRg0FGWSh/jlpz5Q
         t+MXwy18ElAaAr6YxDB+5Ojvv3Xe4dKxvrvo1N5gl6gNkPSjFC2S1aYSP6fxWf5h3Of4
         +haFSr0tK375kA8s4hCNHNj1gWYnOOjT5H7yxAVUTMDJpoIruHOpRLXYTg/fuGgHE7Fa
         hPp89zApGbG0YjFlfywPDfuoox7b8dosCFQctdkrVBB1Y252+1uVo+VGh8FQ9/XTd9wO
         pG9m0gOuoRWHlExDA9qQN0AsIPPOBeR8rHsZ6lcUYNqMi/nHI0srMbnucpnXCSzpitfo
         jcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767908615; x=1768513415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pu0wRyydytWJO9gvWuImfkZVNSnne90b1xi/m4393gs=;
        b=jp4m35TI/IP0rQhfiKQdYUplVVmqR3lKXMgIp8meJ1GOBqpwX4F2SVAmsdn3sM6idP
         DreCNKbTBoR+93d6aXbzJajvPPdFZ+WAmVquJ3JS8FY+1WmQdr8HrWFwKcFfCRa9rPTr
         ep1wV8dfq+X9VgWtfPofl0KfdgqG9UQ8KCLqQ3BpKSR6KaAVRHWBPRxJgSofOXtOCf0Y
         R2ASKO5roqdCvSJNQjT6N/v6xmN1X9pPjPMZYa1RXgY8Jt3se8Fgt8os0C8QCh1ZZw9U
         IF+YFoVbneh43gV0/STdaYn24Kvu/D5PoIH+Pre00rqWuGghidreu8frbuhSYie4+sdU
         jiag==
X-Forwarded-Encrypted: i=1; AJvYcCUiz95M7xoWuUbtoXAfbhR0NopiQhevG3cEiBhwA7jPYS/vKGTsohdvo07eMtkiR5Es6js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKKl4fgfAHHfBxahCtektzOc/PKriEoNKvne1jnkwuxtsJYnE
	6N3kaIpXZWTlQ2kebRof3gnjLa7BDwr628yLgUkyPmz018i28Lx12g5v0JIirRTSmlCSF9QzCJm
	EXBNs7b9KaiYW/bGmZAPAbPjGe8rlv1k=
X-Gm-Gg: AY/fxX4eOzkkPtZZp2bYdUBJDNLll3AvxGjXOXdjdwoH5WNSPJd5JNYpWRrWqhw5dOF
	fJITtf1cFwlHHtdcd8Qk9utstq8pBb1hppJA70FiRN9QeaGgaKTpK0mAgTn2E6VMWaufqdQ7Jwa
	qIa3BI8MQ4MM+9/5YfJM+d8SHxAQbKHaFLt/avOU/JsrPih0e6A+j1Ht2bbQMTTIiEqu/jux5tU
	Gwp1M5HuQOiTYLT8kaj13+rg/A4mmhElHzhhC88gJQFZJw27i6J/9tXJDc4zAGOD2Hz+5Or0LL0
	f+z0NSN8JTPRBUnGe/C+BmX2mHxm
X-Google-Smtp-Source: AGHT+IFj++Ne6lFRwroGe93rzSv2rM0ga2g/nqL8gz/t2f87BXA6Eu+2upiiNQZhGZGwpLyAs/n6YhkCeEt+NDvKfoE=
X-Received: by 2002:a05:6000:2384:b0:42b:4185:e58a with SMTP id
 ffacd0b85a97d-432c37758c0mr9257435f8f.14.1767908614642; Thu, 08 Jan 2026
 13:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQ+oMVuUjZi0MtGf52P3Xg9p4RBFarwZ_PiLWMAu+hU=rg@mail.gmail.com>
 <tencent_1F9A6FB02D856F9C9550E80AEC3ECD30790A@qq.com>
In-Reply-To: <tencent_1F9A6FB02D856F9C9550E80AEC3ECD30790A@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Jan 2026 13:43:23 -0800
X-Gm-Features: AQt7F2qeSyjzelCPrIW0p6Y5Qfeyox0gxojkeuDYLifeWUIgRe0ilKPfAzDldSA
Message-ID: <CAADnVQJrrWL-YvUqsfJJHzrTYUpnm9HTSJQp8g3Dyor6=doEKQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Format string can't be empty
To: Edward Adam Davis <eadavis@qq.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzbot+2c29addf92581b410079@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:52=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> On Wed, 7 Jan 2026 19:02:37 -0800, Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index db72b96f9c8c..88da2d0e634c 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -827,7 +827,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_=
size, const u64 *raw_args,
> > >         char fmt_ptype, cur_ip[16], ip_spec[] =3D "%pXX";
> > >
> > >         fmt_end =3D strnchr(fmt, fmt_size, 0);
> > > -       if (!fmt_end)
> > > +       if (!fmt_end || fmt_end =3D=3D fmt)
> > >                 return -EINVAL;
> >
> > I don't think you root caused it correctly.
> > The better fix and analysis:
> I am keeping my analysis and patch.
> The root cause of the problem is that the format string does not contain
> a null terminator ('\0').
> Filtering out map type 0x22 to solve the problem is too hasty, as it
> would prevent all instructions from calling functions with constant
> string arguments.

If you think it's still possible to construct a program that
passes empty const string into this helper then please craft
a selftest that demonstrates that.

