Return-Path: <bpf+bounces-77910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B029CF668A
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 03:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D911530780B4
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 02:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0D233D88;
	Tue,  6 Jan 2026 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZJ3Ih4P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4321B185
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665082; cv=none; b=mjApdsZBrmxoZCA5p2WKHMxQxYU/e22b6Bl4yKSL1hPtLPndjrr+EKy0vFbZpBYZ1vU6f3K6KW3KLzxgDKnbpDCQsre6RQkof1kPRZe7G81GKkFcecKAtQXV1bS2VMbPOjdY/cF+jA1Fesx6V0WTndOiVxjeahU7AxuBSOP12Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665082; c=relaxed/simple;
	bh=Z+RFbaF9RLNUaas8reYiO9DDmsi+GoUhfPY0jj9maLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRG1VntPSgnjJlDpr6k8geDbm+/+OjzKbvRuxKAodZPBc5qt/TcTPif+xSZTn9PlNXzXsAe/IeMKZK2rwv89+AbQXAjgm4a1iJvK7zV7My0FrCnh0/zihyHcDxQV3bcJY04eb2mWFPiH1T6TDveIGKPeCe+fMJ+aQirLnmQtIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZJ3Ih4P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47796a837c7so3831955e9.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 18:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767665079; x=1768269879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+RFbaF9RLNUaas8reYiO9DDmsi+GoUhfPY0jj9maLA=;
        b=FZJ3Ih4PyuYl9aSK8T661ohFtZO8YB+7IX2wLjbwGzQW82dV/D7VdnJuUbk/2LpBPa
         eQotIU9MW+IPAejg0JdpcCiW2fpe+WWOpyVAy6/mWma5c7fjAm96t9UgynQ3KzGNhdoz
         Zm/gryvrQWesjBKUmom6eqEFW0uAPk1ODdcYVowjhJ+h/jTqNHX0VfcImUP3fFwS/VAP
         Mgtu5At/q+gZS46XXMtvk166bMdy9/Mxk2Ss1xk76i3A3M1BRCKIs6R7kA2LNC7tL7i6
         qWjrZslEaoPulQm0T8yeyiWAvbsBtFwCZlBqV0LtpetXCXaiPV0aY6gW7Pp7/LO9wPk8
         33Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665079; x=1768269879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+RFbaF9RLNUaas8reYiO9DDmsi+GoUhfPY0jj9maLA=;
        b=fuhCecruxJ4o3xr5vZ++/j/PMvxaCT3+scIF0p0FxFHRLbXDxccHBAlXhc6JdWua/w
         IXeVfAFwLODwHp7JjmFSLfL/LyRrwWgmDZLytfkD3UdofGQ0yK50ZSDu6lfR8wZmrb+/
         xQF638DECMeun99jP1GgewKW/RkxfXIXc7USghHwrBIyeNRYcb+yMdPsiJS4H7bTvKLi
         0+XpjPrWmG/aMUloAZE/OOK4TWGNOWaGiwQSpF8u8CHM+4drk0qf3aDrEcQb7ScZglVt
         hGn0FU6Hr5Mt2XZhc4VjMpKJixhqZjrKrOYbwcY4fL/SfkbV1nJa2oUjj+BPgEkb+fh0
         nrKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmkWgmJlHh9SjzQMlahZGeB8+0PP787t1yjBCK09rU94kNXgha08akkot0/1tBexM8QC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0li4IPuYowChKFKUgNohBlAgABPF5pjgD5OTvRKU3te9n0Qa
	8DOlQhkrZFzENwB9Kyo9FIBLJT2giGQPswu0figjOAgaRAeTEqltR5LRn3CTqWb2x6mtQSCnmTm
	i9Co8X1sCSw8hpY7uyFNJJbW+5FWTO4Q=
X-Gm-Gg: AY/fxX4GpEF6J6Srn+XKlV+YWbW1bxVCW86RvmsLHtdUgCMmyZHv0w2lEpRpUIhk76Z
	E9s3h2OdzoROIQdhOnE0YacN3vj9e4807xaUBJIURL9obfUXX2nJbT8GXME5r488C0AA/fOOmP0
	U4egyYs/tGTVm2nqCmq8S7fT02BYZn0RZ9D6msIa0sB6C8mCH4MBCMBziUzOyv3l3kX11e/DNxo
	/rh+w5ErMHhu3sgoAFQIRoiX3UjFxWgPuVujfKFiAqUyEzyr6/dI4PTn+XbTxVIi73mW6ZlbP7n
	vPHfJ6SiCij1Pv+GSl2v7DwWHewi
X-Google-Smtp-Source: AGHT+IG6VOicmFgFVu40gmQYPs8tVlvjDRQaekU5p7OgJBiral2QRYj6QsQb00we+4Trr5W0SKQfd7zTsImJJikl1T4=
X-Received: by 2002:a05:6000:178f:b0:430:f97a:6f42 with SMTP id
 ffacd0b85a97d-432bca51214mr2234385f8f.54.1767665079150; Mon, 05 Jan 2026
 18:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
 <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev> <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
 <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev> <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
In-Reply-To: <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 18:04:28 -0800
X-Gm-Features: AQt7F2r09shs4Exhl4o8Hi5VSsbqKNQ1a3W01_CJLja0rQ5djXkgX3jHzqElt1Y
Message-ID: <CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Amery Hung <ameryhung@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 3:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> >
> > >
> > > I guess we can mark such emitted call in insn_aux_data as finalized
> > > and get_func_proto() isn't needed.
> >
> > It is a good idea.
> >
>
> Hmm, insn_aux_data has to be marked in gen_{pro,epi}logue since this
> is the only place we know whether the call needs fixup or not. However
> insn_aux_data is not available yet in gen_{pro,epi}logue because we
> haven't resized insn_aux_data.
>
> Can we do some hack based on the fact that calls emitted by
> BPF_EMIT_CALL() are finalized while calls emitted by BPF_RAW_INSN()
> most likely are not?
> Let BPF_EMIT_CALL() mark the call insn as finalized temporarily (e.g.,
> .off =3D 1). Then, when do_misc_fixups() encounters it just reset off to
> 0 and don't call get_func_proto().

marking inside insn via off=3D1 or whatever is an option,
but once we remove BPF_CALL_KFUNC from gen_prologue we can
delete add_kfunc_in_insns() altogether and replace it with
a similar loop that does
if (bpf_helper_call()) mark insn_aux_data.

That would be a nice benefit, since add_kfunc_call() from there
was always a bit odd, since we're adding kfuncs early before the main
verifier pass and after, because of gen_prologue.

