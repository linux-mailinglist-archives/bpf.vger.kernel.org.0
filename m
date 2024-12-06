Return-Path: <bpf+bounces-46322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1519E7900
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C261626E8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE641D9359;
	Fri,  6 Dec 2024 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCfCJiQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C048194A63
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513543; cv=none; b=OyBGiRVxz7/2OObKLr1R11g++CbrALwalqlS5RzyiblblYR0bElb1P2nS0M+Sa9BHPLCqSQHPQkyFdWHNjwWQKiw2qjZz3YSmBpPE8aQnsoa9OJpEWq9Me12jpXjiUhgsYo6RpulZeDo+JEB4dfJAFIlR3LFdFz2rKjuBxVW5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513543; c=relaxed/simple;
	bh=phCSCRABnfSx/yjf7O7DAkEaux2BhWAvVCxqeifLdDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0H5aoW1oDMrdBnmmGarfyA0drt2PeleiSF6zQjDu6k57ZckW0qModURmkuzGd1F4SAo4J35ISvcun4HKrFE1rR4vA9TmOksWDKI7Kf5GykEp9MoofBYXD8VvoLnyybOldm01na23g6VjtYFHUB/NNh+LI3bElMOo0pVwTfsHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCfCJiQ9; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so1243089a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733513540; x=1734118340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phCSCRABnfSx/yjf7O7DAkEaux2BhWAvVCxqeifLdDk=;
        b=bCfCJiQ9dtT/Q6SqKMjzRAPo+w7fTMvrs45jv5UrN479kWLS1eVYJt9ic4IGGCJkmH
         5j6ZWBUF9oQ7w2YliXuZkVuruKTSP0sKAKKf2jIAYSK+rm9Jgm/El3SfdcUzceFJoFYo
         p231YpewbhMwrh8IpBSf9pUidBxatw6945AWsSCU7bnGPtmQWrf8caif5PdBvT57bwnJ
         bMGL7xSpEa3YoLiB5ccWXh53W1TpsMSyxctRdHFcFJm8ScQD8+vnNkR0Xbqr3hpdKfgb
         Tya0X+nERZHqeRVTtu9VFZOWCrTSoA13fqOIbdvWz/E1TUuXIgmoY2/K0a6AlDO8Vsp3
         4CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733513540; x=1734118340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phCSCRABnfSx/yjf7O7DAkEaux2BhWAvVCxqeifLdDk=;
        b=vinTwXnYX0/mxxkePQVUhw7oBMsOlHcXCq9RADcfx/6iRDGTkglsb7Uee5XRKi9Duc
         7Y1twzi9ewzxhjJ40Z0JqLfAtKAvj3CsIcgevIZO0M3lukZBIqFSgTllE4e3FkrE8YXJ
         wkRUpCd633RjJ0IpfgtOFAdPJxi909FLyPlE8jytUVUlw9uPb1DMyXOMwSIiUe59BDeV
         /5sjCrmnRjiMMa/L+GFU3VpZPjUnvn/NsJ37eemv0MdkeEZSDPXMMtudGnVGhlqou/zD
         FfgJxibpyXQbk3OL0ZyW3qMuNxBIh7vUkIp8rwHraj+wZn8A5qDs101pMrw3CrQ5JK/+
         YXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJGDNvaLgwQk7QEPGt8E0kAytjKJ1ZsULzDAUkoGz7tJUsDL4ERc0fvBvrSQSpFW8zbA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSAP+2HFtv16c3McJ3GYaUPSk5r5Tg4B8/B0itsZmbRh1ExOd
	stPe7/T9R9Gmv7jp2MG1jc1unqzgVtc5VID+7yUkba6MwdQGcLS5cHBP7wh5PG6AdlblWteufj8
	vDdxmQLY86bpt1wGjv5Ji/gZQHy4=
X-Gm-Gg: ASbGncsPFFOkcBCqK++IQc+qz8FvTT/7FDEZNb3IYeDKZi6DAe5WQCjGNHzu+mW6JBt
	r7fG72YG7PAozwzxTWOBfalovzSX8Xmx+lNMhUeMRg63/JjLsCsfshjDPa6B9EXVR
X-Google-Smtp-Source: AGHT+IF7UYHyyMaEjk7QbE8kiFEL1+cXB4gCrwtfDcY9tOpJR6No47IQZljnFN9FLZSEf0QapKUi67nVW/Wc3ygAv6E=
X-Received: by 2002:a05:6402:3717:b0:5d0:fe7d:41cf with SMTP id
 4fb4d7f45d1cf-5d3be6be0ebmr4585056a12.5.1733513539708; Fri, 06 Dec 2024
 11:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
 <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
 <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com>
 <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com>
 <CAP01T77rBvM9sTQMbJBk2Ku5SRYHzQgvGaNf36v=BA7=nHTmeA@mail.gmail.com> <CAADnVQK+-5oGLF15iuZ9_ckOZQ7QjR0ax0VL_R=tP_831Fa9yg@mail.gmail.com>
In-Reply-To: <CAADnVQK+-5oGLF15iuZ9_ckOZQ7QjR0ax0VL_R=tP_831Fa9yg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 20:31:43 +0100
Message-ID: <CAP01T75gAsxnmLthFBYkMOr3iw4R8xB=sp0yOHgv2KVXTcvQmg@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky <mejedi@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 19:30, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 10:24=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > I think Andrii has a good point here, this would be an entirely
> > plausible scenario,
> > and with summarization alone we would reject such freplace. Then, the u=
ser,
> > due to the lack of explicit tagging, will insert an extra helper call
> > that does nothing
> > just to indicate "invalidates all packets" side effect when it could
> > have been done explicitly.
> > So in effect they just explicitly declared their intent, not through a
> > tag, but through code.
>
> Exactly and that's how it should be done. Through the code.
> C is the language to do that. Magic tag is an extra language hack
> that people need to learn, remember, teach others, etc.

I agree that ascertaining stuff from C itself is friendlier with no
extra burden,
but that is only as long as the C expression itself has a clear meaning.

When you need to write extra stuff to tell the verifier something, C
or not C doesn't really matter.
Like your example, people will still need to remember and tell others
that to ensure they can freplace
with a pkt invalidating global prog, they need this dummy
bpf_skb_pull_data trick.

The medium used to express the intent at that point matters less,
the bigger picture is that the user still needs to communicate it somehow.

We can agree or disagree whether tags are the better or worse way to
do it, but you're doing the same thing in both cases.

>
> We've introduced __arg_ctx and so far the only adopters were
> the programs where Andrii added it by himself.
> Anyone reading it has no idea what __arg* do.
> It's all magic. While C has clear meaning.

