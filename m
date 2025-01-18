Return-Path: <bpf+bounces-49251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834B8A15B9F
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 07:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6051188978D
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B5148FED;
	Sat, 18 Jan 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+6n12Vo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DE7CF16;
	Sat, 18 Jan 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737181772; cv=none; b=qnEhsXQJGBOlJ6IFNP6aWLPNzjv/wV4QHhZv9kfcClah4byBy6lIdbB5UhNrRbx/OktIJXOydoPgL1IN98zxQ9+NDa/TxjbDDekklgAalF3yJjrz6rnL+TuUuOoUle7ddai/Ks4xOl44A1eCXrpKdpJKV1a75KszxN6xshbHs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737181772; c=relaxed/simple;
	bh=kNajPM7FJ1DP3cPX2GpEt6xD1TpMiC0bLvzaWq3QO7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjRVDItl7AfIQvWGAzd7YmAMxcGA0nqtUVwzDhYJvhIaVCPVSjSgWoz/kP73IlA/l2aZtRI+zzeDOm6dpdFvH9/YV2xiHqjEENaG2ekpMzQ8XmA9fdYZaPs4Bsw/WyKngmrnq/2GRo1WtI8QEQ6p6nhXq+YKuY/MgWHl9R6GRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+6n12Vo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a8165cfae8so7718235ab.0;
        Fri, 17 Jan 2025 22:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737181770; x=1737786570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgdXEUKh2ebIkCe3AAwPqW7deSJrN8l+kGHJr1UEt+M=;
        b=C+6n12VoqMwXTIfHw23x7cJXemv+r7hI3L0tntb52pAzrSPjDgLdu+Ae6abN3vr5Qw
         fFMaIOb3tC7srTPssHvBcGV16Xm7iiMBhymqzXya0xlgOL6VDel936TMW0Pxyii81oJd
         KrXTGs4oN6cS+vpl1PDcdM+jBjTeC78lqmTmqmeZN/hrkuJXg8yFrL43145X8Sa1V5OG
         SNQt6+LSGxMXfllBFKRtNfaFCD5b6bWIRmgvwAVQIkmjMLcUgZl+TlClGe35bCTg+BTW
         OinfvWECFc2naDyI4bWoX5buVN0TIwcxdfy3E0zIBMHitWsXN9WyqJU1c4o0XsrXugN+
         l7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737181770; x=1737786570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgdXEUKh2ebIkCe3AAwPqW7deSJrN8l+kGHJr1UEt+M=;
        b=uFMKiSk9wFUUwZx/OA4DL98LFVbaJ2Bpq+rTe6px2oY8Q1BvMojRT0iXucPa7BW8xS
         oChyZt6J0UYxvDFz1WYle9OfL0gPJEheV7yZi+2u6ak7bhesMG4Boqj22KYWHm267Jzb
         C7RkQeCjc5WD7BpNWF+FMTzQ18Suxcgj0DZkt83fo8ZJ+8GMCsuozXe605huqf2blcR8
         1EErRXwxuZB9HzHFgqKHtP8w7w3b1ZeHhufQybC7FVWxoj9dLFBsEVU8gLRZsg4L1m+z
         zZYA2LrFSmG6GpUVKq/c2eGcUNNQAT/aRAIP9Nn6+R/k793k93LKL5WKCPlxeaRdOJu8
         Xojg==
X-Forwarded-Encrypted: i=1; AJvYcCVKqrfHwO9jBuWPH3N3qhK8aFHUS/BW2ZKfMontLqF5heeAciMIFYiup8I0NnYtJDWdwQk=@vger.kernel.org, AJvYcCXWH1HkfzhksNK18BqeH7e/5HiIqyIHYbBE8Ozg0Mr4u6t2wiiBWnVCVrIufesvgsjTnEaz5K3a@vger.kernel.org
X-Gm-Message-State: AOJu0YzLg2apX1PDp2c2hgp69rQa1mNJCT8A9wBnTU67nj3UbGogPN0A
	9HgGkQ24u2lhHZ2Ocx6fBqq1nP3T2lKIUeeqEp01HVExu/mre2g18J8xq/gfoDyBofpSXtOsi43
	f83MXI5tbBXdZ4oJ9MC5Lnvf8S1g=
X-Gm-Gg: ASbGnctlgFlYIjm9UWrMwsgAZTENKGQXkj2PCQOi6G2pL5HESPSj8bILcwfselg0Ffa
	tY4qVDHcig5acIUvYMhKCOb+J4WC4jxioosr6KkAngiqhvocGdg==
X-Google-Smtp-Source: AGHT+IGqm/YkppXmpNbA2vzkwvJffN1fLaKwXV+Eks8Mz4lccRNjOwa3fOcFT4PNA7wNixFRSPQPaYILkyC4S1VAYhk=
X-Received: by 2002:a05:6e02:1c23:b0:3cf:6c4f:3960 with SMTP id
 e9e14a558f8ab-3cf744906f8mr35119245ab.19.1737181770251; Fri, 17 Jan 2025
 22:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-6-kerneljasonxing@gmail.com> <ca852e76-2627-4e07-8005-34168271bf12@linux.dev>
 <CAL+tcoAY9jeOmZjVqG=7=FxOdXevvOXroTosaE8QpG2bYbFE_Q@mail.gmail.com> <35e2c693-244f-4d55-88f3-99e1ed1e2745@linux.dev>
In-Reply-To: <35e2c693-244f-4d55-88f3-99e1ed1e2745@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 18 Jan 2025 14:28:53 +0800
X-Gm-Features: AbW1kvaLqr32v74jmgaqoHtg0g8_ikex4QT2XIJe3KuXNSzHW54xWp0If3ahWLU
Message-ID: <CAL+tcoDqnfaZq1VnqJa=RVEqMXyno7xyWJjcbU7ZGuPm7XGi6w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/15] net-timestamp: add strict check in some
 BPF calls
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 10:15=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 1/15/25 3:32 PM, Jason Xing wrote:
> >> +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock=
)
> >> +{
> >> +       return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
> >
> > I wonder if I can use the code snippets in the previous reply in this
> > thread, only checking if we are in the timestamping callback?
> > +#define BPF_SOCK_OPTS_TS               (BPF_SOCK_OPS_TS_SCHED_OPT_CB |=
 \
> > +                                        BPF_SOCK_OPS_TS_SW_OPT_CB | \
> > +                                        BPF_SOCK_OPS_TS_ACK_OPT_CB | \
> > +                                        BPF_SOCK_OPS_TS_TCP_SND_CB)
>
> Note that BPF_SOCK_OPS_*_CB is not a bit.
>
> My understanding is it is a blacklist. Please correct me if I miss-interp=
ret the
> intention.

Yes, blacklist it is.

>
> >
> > Then other developers won't worry too much whether they will cause
> > some safety problems. If not, they will/must add callbacks earlier
> > than BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
>
> It can't be added earlier because it is in uapi. If the future new cb is =
safe to
> use these helpers, then it needs to adjust the BPF_SOCK_OPS_WRITE_HDR_OPT=
_CB
> check. is_locked_tcp_sock_ops() is a whitelist. The worst is someone will
> discover the helpers are not usable in the new cb, so no safety issue.
>
> If forgot to adjust the blacklist and the new cb should not use the helpe=
rs,
> then it is a safety issue.
>
> Anyhow, I don't have a strong opinion here. I did think about checking th=
e new
> TS callback instead. I went with the simplest way in the code and also
> considering the BPF_SOCK_OPS_TS_*_CB is only introduced starting from pat=
ch 7.

Got it, I will follow your instructions :)

Thanks,
Jason

