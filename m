Return-Path: <bpf+bounces-63257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1CB0491C
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9663A16E4A7
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3225A33E;
	Mon, 14 Jul 2025 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCTY1pzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E223A58B;
	Mon, 14 Jul 2025 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527225; cv=none; b=lsFsTL6MY4QJzpDNamozQSS0ZArfv5d4dGNsWRYct98TSkiBJ0bTFlsz95d/2CzLNnamwri0fg8Snd2Kj5UjoDs9DlwMNxL7r3XxhJh8IworlsjeNvYZ5qApifMA8hCfnTKAI1EeYFw+Zd5YUXVBQmj9vIYZaYDbL7URo8beLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527225; c=relaxed/simple;
	bh=5JD/kWV2AbuMeGU7rYnfGbFbjnRwFycAkKvVBo3ot2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feD0BIp5+YpvkRzWnInbqiiBECpZU6JIoQz2vuojCvs9WjuP7nxV7Ob3olmZ/Mbr9lblJeKvqImwBr9X97AE1wMmVLb7dSHsRwSH+9AHHG/5TrayuH1GWF5uF2R64aR8+Q1fjW+rxcsfN8Y+9HBokRyscKeGzK8Ue7cqhPX8Y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCTY1pzi; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so3158955a12.3;
        Mon, 14 Jul 2025 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527223; x=1753132023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1g1LocucP6UasQ2e4c4y6j/Tc2Y33sRD4xEcxl2/vA=;
        b=DCTY1pziLFAgDnqe7wt0HAdcLGBvs84pe3QUiMRPqMF1i+lGhk8/qk8yNwMOVqstMv
         SCYRbJKZTP2Pe5+RCW6vfrrLNODNEqdALOQb65CSgD3TkLB/ah5I/VNe7N9x5/X2qe6U
         zCXzuocZA+wUGdd1pJ27v+V9n0Oinv4CaoJVsXt+T9aeUQEwXhAasjotCRJquZDqq6Py
         tEblp6KUbfRX2naV7wNDHAf++KBuy7AfT1+zpPhE8e46Kf7TfmnpVT97nUfjz70Lf3UU
         u0szuOuSKx32ifJcKd9K7UOJ6NXaW90dTbis5NQaAp7/v680l0TDx1FW3T03E3EYNwwR
         fkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527223; x=1753132023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1g1LocucP6UasQ2e4c4y6j/Tc2Y33sRD4xEcxl2/vA=;
        b=vdyo/63VS3QopW4E7RSFhj4SxttRkx/X6uRyfDrTg3xLdk//I2ZHdvfTaaiqcLgJ6x
         Qa4bY7JlxdJLrtP1gKwwbhnjr5jVNAzGUHswJObus8xiOpVzu9k3WNJlP58KOjZna34J
         X3Lso8+Txuq85F83NEYiw67TsrOFHr5mcpUWNQ2wrsd/2bwMb5Mi/j/GLlJ5iJ2j6YDG
         3bjaBRRfqkJuc5womLWvse+JZwQ5z5rVyCy19Ad0QW9FFUEuTgRFhFMAP1zNlORhfoU6
         +w1vsb+9GDqlyswTnhHpEPl4IAlzjAGVge9WZQtDdON3mDQ7KZsG7jiBlesSZ3oG7wSK
         GbOw==
X-Forwarded-Encrypted: i=1; AJvYcCWPe8RYJXXRVfiRSLQiWMxjDIz63yA3OZPoW5is8p3vY6S53zNZsat2COrK5gEdn+4K0sLOytUd2ES1/55m@vger.kernel.org, AJvYcCXHny74UYYZYeQRJqn2FjrCtFiVTrXkH5Zgpe4+Tspbj5nap97ue50ND+xUIAHGO6RWO/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTGmG4zwEdSKJ/suMGnQz4SVtgoS3XuqrQE8e4KvsXYG8NSL+
	FRuYz3OiujnT0QIXGAl4oxnBwnW/6gSlsBjnhodOMLDqjTTE3+rim+kxwg9a9NZ+S4RDBjiyeiL
	MwvFWPWoM6eR589oyDFUFw2Ml9j+0Fvk=
X-Gm-Gg: ASbGncuTnK7UcoBCSR70O2iuNVw3IcJoEp1xKR4UOkccpofQ7Og5xm/ML2annR/kjH7
	yADo4l8fgTifY6zoZgj9/8Bs37FRkXFU+cbBZtBE5sWQ6/j5AxzHzMTv5runS2pnNMQfBZGPuv5
	E9/nBIQpgosn5pXORc1hH4D6vEDHRS/LtUdqiGqaXEHmlF7BqmEDBQ5KXhmIzDwICTXSGKrw+eX
	3aowwq76tI//3yWAcWc8Mo=
X-Google-Smtp-Source: AGHT+IGnTWL2Euqs4sl9BAoj2ZFNwvelp7J5peGFK2tAmjzN9SFwINRW3YNPMYR6xmxfTVmUEga3Py0aD6bNE+SGlr0=
X-Received: by 2002:a17:90b:1845:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31c4f512a39mr19338367a91.22.1752527222975; Mon, 14 Jul 2025
 14:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711094517.931999-1-chen.dylane@linux.dev>
 <CAEf4BzZzsqu1=Q-3+6uJvgvKd52o+FR=DFp28w+vT5knP9NyCQ@mail.gmail.com> <f580b139-a08b-4705-addd-31f104fd570c@linux.dev>
In-Reply-To: <f580b139-a08b-4705-addd-31f104fd570c@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 14:06:49 -0700
X-Gm-Features: Ac12FXzcSWAnRNRcZk-aeBzzaqe29UMRa7RVHQunDPfem5S6M9cBfgX8VZQSTnI
Message-ID: <CAEf4BzbwRj7XC0rvWDzJX+v3QweYBh=dT6H17piyD=v1QLbi7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com, 
	kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:16=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/7/12 01:10, Andrii Nakryiko =E5=86=99=E9=81=93:
>
> Hi Andrri,
>
> > On Fri, Jul 11, 2025 at 2:45=E2=80=AFAM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> The 'commit 35f96de04127 ("bpf: Introduce BPF token object")' added
> >> BPF token as a new kind of BPF kernel object. And BPF_OBJ_GET_INFO_BY_=
FD
> >> already used to get BPF object info, so we can also get token info wit=
h
> >> this cmd.
> >>
> >
> > Do you have a specific use case in mind for this API? I can see how
> > this might be useful for some hypothetical cases, but I have a few
> > reservations as of right now:
> >
> >    - we don't allow iterating all BPF token objects in the system the
> > same way we do it for progs, maps, and btfs, so bpftool cannot take
> > advantage of this to list all available tokens and their info, which
> > makes this API a bit less useful, IMO;
> >
> >    - BPF token was designed in a way that users don't really need to
> > know allowed_* values (and if they do, they can get it from BPF FS's
> > mount information (e.g., from /proc/mounts).
> >
> > As I said, I can come up with some hypothetical situations where a
> > user might want to avoid doing something that otherwise they'd do
> > outside of userns, but I'm wondering what your motivations are for
> > this?
> >
>
> Sorry for the delay. Recentlly, i tried to use bpf_token feature in our
> production environment, in fact, bpf_token grants permission to prog,
> map, cmd, etc. It would be great if it could indicate which specific
> permission is the issue to user. So i wanted to provide a token info
> query interface. As you said, "mount | grep bpf" may solve it, but
> functionally, can we make it more complete?

I wanted to understand what you need this for. So your case is on
failure to report what BPF token is allowing, so it's easier to debug
what's missing, is that right? I think it makes sense overall, so I
don't really have objections to adding the API.

>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   include/linux/bpf.h            | 11 +++++++++++
> >>   include/uapi/linux/bpf.h       |  8 ++++++++
> >>   kernel/bpf/syscall.c           | 18 ++++++++++++++++++
> >>   kernel/bpf/token.c             | 30 ++++++++++++++++++++++++++++--
> >>   tools/include/uapi/linux/bpf.h |  8 ++++++++
> >>   5 files changed, 73 insertions(+), 2 deletions(-)
> >>
> >
> > [...]
>
>
> --
> Best Regards
> Tao Chen

