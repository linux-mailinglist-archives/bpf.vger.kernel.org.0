Return-Path: <bpf+bounces-74661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344FC60C6B
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 00:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64DB435293D
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EE239594;
	Sat, 15 Nov 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="GlW30HqG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5122D781
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247899; cv=none; b=ULEe0IlZrY5I7jT88YTdlydDPloHcdm9ej22FSWKoNUlKPKCELIs6u8iYYdJUk0y6c7JC2N+OL/fDNBOnVhRVpjmYKEPNGfEdSmkif322s5gh29g+AggEGdcb25mV4PK4f98WWr9zdqgYUzp5RWn5T+7yNrOBKM1HDr5NTjJ+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247899; c=relaxed/simple;
	bh=R+Yzc8cW+nfD5JfEsBKaXXo9dpl7WafNOik7nvt9UpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxJD6mUn07ebHeIm9THalFrAEsVDezY+vm+6fnzn/HeRezrQm7S5P2NX2lKazhCGsPNqCaXC1fmOcr0ugKhhUZUTIj5wPiM2vJimG/JDwG8VZC0BXQ3gryzNVLLRoLT78u4W+btXu0r/DFtSlB8N8QGzasrqsrYukqjQkfXTWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=GlW30HqG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298145fe27eso39584155ad.1
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 15:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1763247895; x=1763852695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLJ5VnTJbC7vQ6bZl12YPnQhs8ULpbswUF2fA4Crn6k=;
        b=GlW30HqGiFpySiF5AhcULsXMYB+90lFGlUSX7IqBVnc6Dskrbu7nISEJLR97sNfReH
         Q7bzp9GTZbeyW0vn5q90QwHazzvt62YZpVaya2EiKm5cTWC/CA1+l3z3jzFufDMUcFoG
         G+AR45z9kQOaNE8nG0lTmrvE+LmwiXclmGBC1cM01vnQvmAOy4F4A9qVyCDYOpLgAjm+
         MRXKTd/fWSiHzByR3rHuurDqDockP7lUtrRltNHuUBOf/UTcYUAXKCCba1Oixpuht2/4
         vJYPx28aDyTUdhVNa6cY0kz7sx6140X4v4v5FxzUcjbUNhz3fI/ExthkFWFltFcP/hhu
         nggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247895; x=1763852695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLJ5VnTJbC7vQ6bZl12YPnQhs8ULpbswUF2fA4Crn6k=;
        b=Bh/wbHlvi7oL3cW0ICyl82ViLffoomDpeEX/rHl+xITnFFrcFnMzZMsX97Qd+DgkgS
         yJlB5L09QvDpBpHEhXqncPM2AO/lfV8c4X5D6NxpViH6rr45D7D9rO31BiZqjkLqK6Ax
         tz46AyR+AbJdzJHYRAgW85kZBgA2Ph0O3WKo0PCvurDRkilWULh0tkU2IPyLH07ITwOO
         zR275eese6/GQgrGCcNfc6bOsu9kWd95tWjs8KqNaY/431B0tKu5+/ivFbrO/aLilWgl
         cwZgsHApB8T1MB9HyJ1O9nao8+tnAFzCv43UUHHK4TQH4u8DsDX9pkBtHvfax2KmmKyi
         EzNA==
X-Forwarded-Encrypted: i=1; AJvYcCXrzbqmi5p0uT1mAaarvSFhtlyh8yxWND+dEQXFp/9lp2wl/S8q8hSF6tY6ozodUNzNSBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGV+c9UdQSnEGNMH9DwqZjWagfo6Z9LL708paYcNJ6WRnowBE
	t8E0TyKs8XMNjyXyIiIhaLiBtGsHoIQSPaqaGTVH4ogdV8tSb87bgY4byXNHk/FEwTSeVRv+roh
	099a1g66FaZFdccTYQ2GAW7olQg/ydZkL31qjTVeIIQ==
X-Gm-Gg: ASbGncuiq9FeGXynB1ZGJPjP8GEFiRn8d158pAMFbyjTLm+JrSEcxpTIPQgpz0cU3nX
	ynJ3sHs2271wU1Y3kNq9KSn0QnAq3gwAGI8pZB64hr8OC8jasVd0aigWSZH8WJ7au3lXX7RI4ny
	BgZW4E60N0+s4qmL8buIes0w+09qkHvx6o0wPLzRvg5MJJVAIEAIlMhBP7NPOzKglLL6nfHVg+4
	/RSFvZPCgoAFrPFx54xbEowATAuq9w9rwJq2FJiP7QV7vjQ4c6tOFaSFwi/eg==
X-Google-Smtp-Source: AGHT+IFiAAVWADaPlFXapZr6yz6TL2Rq8lseso7lsPZEaJ9kEMA81G6lmJU+LbNp9Bx0MdxSQQ3oVYMlil5tIzs+yNA=
X-Received: by 2002:a17:902:e84c:b0:295:9e4e:4092 with SMTP id
 d9443c01a7336-2986a76b624mr94324725ad.56.1763247895088; Sat, 15 Nov 2025
 15:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
 <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com>
In-Reply-To: <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Sun, 16 Nov 2025 00:04:44 +0100
X-Gm-Features: AWmQ_bkhgH1vmZHnVOIE1dFBea0-P6ObqDSwSP9TR_1Vn9K6MuI9Y3a8LT_kwM0
Message-ID: <CAH6OuBTXwW9WKHRNS53kRgZ3Y5GdH3n0EY4YogOGGSTGnYL9og@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

Thanks for the info! I wasn't aware of that fix, but I just checked,
and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x86_64.

I just installed the kernel sources locally to make sure, and the code
for rqspinlock matches that of the commit you linked (i.e. the
is_nmi() check added in the commit is there). The code for the related
commit  164c246 ("rqspinlock: Protect waiters in queue from stalls")
is also present. You can verify this yourself on Fedora's 6.17.1 git
tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel-6.17.1-1/kern=
el/bpf/rqspinlock.c#L474

So it's good to know issues have already been fixed in this area since
the original commit, but it looks like there's still something lurking
here. To clarify, I'm not exactly sure which of the various timeout
cases in raw_res_spin_lock_irqsave() this recursive lock situation is
hitting.

Thanks,
Ritesh

On Sat, Nov 15, 2025 at 10:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 15, 2025 at 1:52=E2=80=AFPM Ritesh Oedayrajsingh Varma
> <ritesh@superluminal.eu> wrote:
> >
> > Hi,
> >
> > We're developing an eBPF-based sampling CPU profiler, and we've been
> > investigating a bug that causes periodic, brief system freezes on
> > Fedora 43. We've tracked this down to commit a650d38 ("bpf: Convert
> > ringbuf map to rqspinlock") [1], which was introduced to fix a
> > deadlock reported by syzbot [2].
>
> Sounds like your kernel is missing the fix:
> commit 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters=
")

