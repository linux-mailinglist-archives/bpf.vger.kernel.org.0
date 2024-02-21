Return-Path: <bpf+bounces-22366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14F85CE41
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 03:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B417CB22DBF
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5E28370;
	Wed, 21 Feb 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eY+mcvmr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111F25623
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483560; cv=none; b=jT7tlKOdhY0r+sMV9COJFXMnfbKrmWhZwH8WZ1ImhifVUFAD9zPZM3uc0JtQlVyb+R5x4UbJCZBPyZ/E3XOEHEdRIl21j/jHmfD7KrQAZ1r+S1+CXVpgKt4yWvk/94raXjj+yMkStEtY0mawzlm4ZLYBviVEq7QSFBHZ91+dydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483560; c=relaxed/simple;
	bh=ve1P36IQxgQSH5e/j0CQ97PbRHxGM/0Cwkl/MH1SMuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mssjdjMNggGCowt3b+Q8MhRnHSeEh2S0NilmtFhqIfgOqPmjkxiKpb7WOYzYTyfDguphlcAuA9PYiPT1gB+zyxgSKPiD2IlmVz1VxxKwzkYHqtF1ESg3+cFus0XRtY6SYra9Bkm6Z3wHlE1kssYnVwzoqcu7KaWTCMwDARqhyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eY+mcvmr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-290fb65531eso3566832a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 18:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708483559; x=1709088359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve1P36IQxgQSH5e/j0CQ97PbRHxGM/0Cwkl/MH1SMuI=;
        b=eY+mcvmrLFndy3vMd8abbvvdkULPrS9j/rbHuiS6BpOmmsCTwnlklWp6M+wxwAdgeN
         UfoXCNMgSyr5wD1t0VfJ/nMZvzlUdWEoo3e9O6+/v4f32pq7c8hJZ6LYGE17SdTBXkEj
         dRg70wiXqBwr4B3w77PZLgPkW8N0tWg6vRSrytbCzsL1e4enAjTMxJbQ5Eg2QIMEARVQ
         Da5+Iyty92uH2Np1ZUyWQ2X2NhtHK8SN9oDQHOLc+TRCKfj5qtrmTgMBaoJUlPpqV2zB
         RB7capCvii6EPMsLb5g+m23QkBLccOm+NdTIDL2hXEna+MSiUfRgQ+HsXk/0IgJ80vla
         rRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483559; x=1709088359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve1P36IQxgQSH5e/j0CQ97PbRHxGM/0Cwkl/MH1SMuI=;
        b=ro/wcfT8BHdHsU36mSHlq8cheQgOI8QLJRebMyKwcMfKFKim1G8COO9hrpjl9CoXat
         07JqhTjbC64v/tfuQkBuFycoATmxUAwqBX6NAkUAwrVve9pHdzeDu3JFNKC+qrgPHSYe
         xNUv7b+GjxxEf09l8jhaYuOvfqWQ6/zMWSYlBIJI4kyWbyEhe0AUD7KGF4Duv9hw0XdN
         267JQbhm8bLzUVVKXbC300MWS6eSSSXrb3ypB1g6zypb634PNQskju3xEFxA6YVzKoPM
         j8SrnYfHsSeE/U85a8L0MF9exya0HDqniaSCThGm+UnYHErHrqYso0hZsBRE4az/zhoO
         8hOg==
X-Forwarded-Encrypted: i=1; AJvYcCVjRwwubFYE8qyNkDy6vQTr3wItvtY//LzZZnN3B7vAT5OUffEYs0UKtFpd2RHwT61SV7uqBhCvcwwcFNw1kLz52wud
X-Gm-Message-State: AOJu0YzMHIEddobPaKtr0+c302rNPMFwxqUzwbR3rz0SBGbWqEzmEG8z
	qM7nYwJuoF0FNMRy4lcGNp2HZ3WV+bNgCj1r3iG5pkV1mW15327LTlhovtmJDI1uV8IPFn+dh/Q
	956j3/ts8KnVXnvw50nNveBR1buexLosfohu9tw==
X-Google-Smtp-Source: AGHT+IGashesbOHbcyrknzxfVk2lf4tXLZJ5jdamBO+1t79MQQSOI9DHPUj6TjyB6Xz8pKhd36pDvEFEfQoRdh2c6sc=
X-Received: by 2002:a17:90b:1281:b0:299:6848:28c1 with SMTP id
 fw1-20020a17090b128100b00299684828c1mr7815650pjb.26.1708483558766; Tue, 20
 Feb 2024 18:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com> <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
In-Reply-To: <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 10:45:47 +0800
Message-ID: <CALz3k9h8CoAP8+ZmNvNGeXL9D_Q83Ovrubz9zHECr6C0TXuoVg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 0/5] bpf: make tracing program
 support multi-attach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Kui-Feng Lee <thinker.li@gmail.com>, 
	Feng Zhou <zhoufeng.zf@bytedance.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:35=E2=80=AFAM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongm=
englong.8@bytedance.com> wrote:
>
> Hello,
>
> On Wed, Feb 21, 2024 at 9:24=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
> > <dongmenglong.8@bytedance.com> wrote:
> > >
> > > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed=
 to
> > > be attached to multiple hooks, and we have to create a BPF program fo=
r
> > > each kernel function, for which we want to trace, even through all th=
e
> > > program have the same (or similar) logic. This can consume extra memo=
ry,
> > > and make the program loading slow if we have plenty of kernel functio=
n to
> > > trace.
> >
> > Should this be combined with multi link ?
> > (As was recently done for kprobe_multi and uprobe_multi).
> > Loading fentry prog once and attaching it through many bpf_links
> > to multiple places is a nice addition,
> > but we should probably add a multi link right away too.
>
> I was planning to implement the multi link for tracing after this
> series in another series. I can do it together with this series
> if you prefer.
>

Should I introduce the multi link for tracing first, then this series?
(Furthermore, this series seems not necessary.)

> Thanks!
> Menglong Dong

