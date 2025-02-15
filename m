Return-Path: <bpf+bounces-51666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E12A36F5A
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 17:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712CF1894A4E
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50D1DF73D;
	Sat, 15 Feb 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwo7jOPW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC97D529;
	Sat, 15 Feb 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636272; cv=none; b=OYbQHO0LAIpPxca/stCiC2P3gXeWiE8O32XQUuD2uOXG7hONyJkBDazdNHKRgoriJO8a6OtkN/FCwa+XJO8l+TmnxfmM0ly3S9HTiGUNG41dnACvGosIlkXeR5H6GC44gh3nU7odQQKvxJmagW4GtiNCN/YSr/Q/mtjPgOlIdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636272; c=relaxed/simple;
	bh=dayVkNNZGR/ztmrUza7qBRnosSiK9r2YyAAmKPoW6ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sj2EOuH3I1nXkUH9674GVqBWPAwjULhrT6c8O7D0EdM1N1m11dbgs+R5DXtpZnKqneZcxldnLMGpTqnH4mVKga6HZmOREubWFO3zpdW9b64Tv6GJGtXvtSUuifk6aMhodHnvX0LAG1aF/1tB7mfdb4L5DR/Q5CJR3N7kWtEHLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwo7jOPW; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d18f97e98aso20800305ab.3;
        Sat, 15 Feb 2025 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739636270; x=1740241070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOA2Np671lJOr0TWLfDmbBMv+65AFPM77WOjzSSHMOw=;
        b=iwo7jOPWmeWpzNFMljJLt12BEaceAgJfD5U7B3DxHMsM0MNLbXNcWvTmPI0lRxk28o
         4kHhb8rZ1wKzr42acMpJIPRwcHb3i4JP4X3SpMHqWSVFkbE1jDUB0C5hjZFLRELgiab9
         i3xLiya6axFZy02/rzor5BJKF9S8T8Vts9VLQzWVWOet88oF1EoJ4aKZDY4RDkRYxrlP
         JGG3petDZ7tKa0H+UXyw/EZqGT9wS2/4s46vKrOomT4Wqc2GMeJNmD6/KpokRB20Trb3
         cBQgi3J0qXze+aSEfFOz0X/3/bNjlRwTFeeyXogQzVSBBtgJl+ILGd8U/NGAusDzuKC7
         gk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739636270; x=1740241070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOA2Np671lJOr0TWLfDmbBMv+65AFPM77WOjzSSHMOw=;
        b=DmWvvrORWvbJWa73y0O8RqCV1M/mODdI4BAU3p1ifQq37cmxCiX3gomjk83gV8UawW
         mfTPbLY7K+6XpXACdfjPcVog6+0ij0xZsgAxv1F75nDCw+rIGkdAE0FJ4HaqL5j1SR7D
         SR+Bp/lQnqx+JRI+u3wOJcj3aWPK/kMQGPik10AM15VkiY+oSTzmHHQPeak/73K1V01e
         80mAXj89yHy5Xx0eKPpaSc7HC3TMeEoKn6djYfbZ79Q/q4kx+vT6oH5zLemRb7c/gHAC
         4zVwfLlxY9wD+uKDI8njULWwQEtG+CBXdW4qxd3611Gpdn+hR/mHz7vLIy0gKu1BN0ms
         00wg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Q4izaOXP/+EVuJ/hUsj2MoYCUQB//dsKyIurEMP9yg7sIqXz4w0FGM7SAZBod2inUdAPqJBd@vger.kernel.org, AJvYcCWH1kjF4bJ/16PSPAkbH+g8+ibxQsoAq/el54UH8/rQNNXthl062WOoUFKsAGbedYklmSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3m491DF8eIw1ZOESE4T6U5igs1wnaUxV31W5FTKJ8sN8yRzi7
	xazTb4rTaEbQZep1NBJxEPlZzAiz56y1btCCU9l+j7pZADbR8YJnt1xn68kUErc5qG3GOH55gcG
	9sqYUCPY7szmPFb47bR5Jh+5Y9os=
X-Gm-Gg: ASbGnctZAL4Dtk0D1PqRl/5Z9fnQHQ1MG97+aZZ5IYXaAWpPtTH22Zl6Q+mDNvciY4K
	bOdCZcVgnj5YXlyQjQcrOpaqcbTn2iohmu69svVHIQi96+VViAblSHbRN15OTzcgwpNGck5o=
X-Google-Smtp-Source: AGHT+IEE5YY2mLa2CIBpqghDtMZqiNRefpbZCeiY914w1RyzqtF2FBhtwrM37XYQUWacizdP33t13XkBh4Uez64dDcc=
X-Received: by 2002:a05:6e02:3981:b0:3cf:b26f:ff7c with SMTP id
 e9e14a558f8ab-3d28076cc24mr28740565ab.5.1739636270399; Sat, 15 Feb 2025
 08:17:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-13-kerneljasonxing@gmail.com> <67b0af817bb1b_36e34429417@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b0af817bb1b_36e34429417@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 00:17:14 +0800
X-Gm-Features: AWEUYZkU61Pazk67LJ1YG4i3S_0fAsHC5Jx1LEEDIV2HxTCc3CLgB4nUiG9oT-g
Message-ID: <CAL+tcoAN5EZbAzHDsWLpnzZ0sE5--_3qD5SQfVZf-OSZTw_gGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 11:15=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > BPF program calculates a couple of latency deltas between each tx
> > timestamping callbacks. It can be used in the real world to diagnose
> > the kernel behaviour in the tx path.
> >
> > Check the safety issues by accessing a few bpf calls in
> > bpf_test_access_bpf_calls() which are implemented in the patch 3 and 4.
> >
> > Check if the bpf timestamping can co-exist with socket timestamping.
> >
> > There remains a few realistic things[1][2] to highlight:
> > 1. in general a packet may pass through multiple qdiscs. For instance
> > with bonding or tunnel virtual devices in the egress path.
> > 2. packets may be resent, in which case an ACK might precede a repeat
> > SCHED and SND.
> > 3. erroneous or malicious peers may also just never send an ACK.
> >
> > [1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.c.go=
oglers.com.notmuch/
> > [2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@l=
inux.dev/
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>
> > +/* In the timestamping callbacks, we're not allowed to call the follow=
ing
> > + * BPF CALLs for the safety concern. Return false if expected.
> > + */
> > +static bool bpf_test_access_bpf_calls(struct bpf_sock_ops *skops,
> > +                                   const struct sock *sk)
>
> Is this parameter aligned with the one on the previous line?
>
> This line was changed in the latest revision. Still looks off to me.
> But that may just be how the diff is presented in my vi.
>
> > +SEC("fentry/tcp_sendmsg_locked")
> > +int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msghdr =
*msg,
> > +          size_t size)
>
> Same

Weird. I cannot see the problem from my machine. The CI didn't warn me
on this alignment either. Probably your vi went wrong? I'm not sure.

Thanks,
Jason

