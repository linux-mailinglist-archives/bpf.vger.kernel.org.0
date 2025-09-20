Return-Path: <bpf+bounces-69115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5CB8D1FD
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 00:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519D37E1F36
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818B0221FC7;
	Sat, 20 Sep 2025 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtIFsb2Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C11B423C
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408111; cv=none; b=KWeigZxhce/Y538jctunCnIwL7DxJmHOMNrD+UXRL9ohewPBIFiV/g9I64slLhUPQ5jAVBB4qZOG3UPFeyZ9AsJt4kgbku2mmUA1Wr5VHR+5PBBuO/2Y8YzKmNdV18dY16IzyIj+6At+9Lb61E3FvoRhmPjBaAVStRgmANP1X5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408111; c=relaxed/simple;
	bh=16cEd0iZXESN2xsU1HTaYT2AvUyfwXK6+Saefem0aPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFRbDdgtqcTdUwcAvp4Jq8U0B/wropUH4urssoZmpHisDMDbm9HhjTv/SJX/ktb9Ycx/xPOPzF6jsHT6W3RXhEXCA3Y3+3E8ygO1klAZGMXtrKXLh1TIU+fK2Ux21xbqgqngigHAUj3hdhAHNkmSsCYDp5JF9JosCvx0ba8tuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtIFsb2Q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f0308469a4so910604f8f.0
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758408107; x=1759012907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNy1DLKtoFtW/q8VaKgqJyIfAQICNLmqLj1iIKwK9+g=;
        b=jtIFsb2QBosO/b5Kkvxy3V3OBoF2KvLcM3gJJzXXr1BhhKNM8uIOw7va31RU6AWhih
         GKCer0T3ol59PiI8gqVqy/VwwKxfbnV+LW+8CY2tm0+aUpVMyTLRbjanZMWFbHjlmD/y
         yW3+obPiEMV4vA6tKVe2PDJDFklN7+/80MOu8O6yFUFsjvjghIAAX6WT9cP9Ea5ZSPcN
         w331SmPkNHTLmfTUGEofzegJo//5qHWI6RQtk62yjHlSEWzepyFyuN2cfErBZ2vgQQa9
         UED30pxR/R1QuO4ykMVEls8ZOa/+LN9KqkSFsvVfL0FYeEBc/y7b4nekcsQ3ucZo2BNG
         URcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758408107; x=1759012907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNy1DLKtoFtW/q8VaKgqJyIfAQICNLmqLj1iIKwK9+g=;
        b=jeY1Mv5CCGAYaPJEz9uTX3pQxQGQwmh+8mJq7R8GG93O8QcRV7CwF8fLFow+v/uG2w
         U8myW7x6K1htWb0J3ocsyJljcfTGGhYkCgdxcwpMrU+j5bDIeph6+29lyBZMCzrd7VtO
         OZelxBRMdsRm/VX6vEgoBSoDK/ujPsvS24WDGyMlHd/me4seOJeOx37ONsJ4Vcynii/y
         +cQMDk5nT1xIG/KhIrju5iwi9ARhb3ieZS7Ci9WWFtDyqfxJ9oYRSqJTMc5Sl3UOqtj9
         PBsfglVwE1dSAQxrTCFEQR9o6t/HlegtiDnl2Z71dXmMPZ2QNqqda+lUjTeJiEad/VE+
         BTYg==
X-Gm-Message-State: AOJu0YxPGSgA5RANBXTwXD6d0+XkvXmz27+XAd0UuLBmzwYMGL0CwyGb
	a+1nGxo/AtIKzABTjn0CqRizny4agSFqR6VT4hv+OSY2yPEnJNWTc6NHQlDIt0VnzSDSXAip61t
	XYMMAUx8yd1e+20LiCbIYzLU0qncfE1M=
X-Gm-Gg: ASbGncvjGKJ+rIba1+e+QWWvw5SOM4NUofyk/6TFYa0GoFpJM+idMFXu9nhZyC3eJn+
	jboTWB6skr1MuRVBvxbouMF6I7ZR7lgu/u9UnhadZz3UniW3iBT+6zwgB4Egl3wLoixICZsuK/h
	NaKOEoYfZmSrsLIWh1Q2Yj/usDxqEQ/VaU2hGokWFyDO/t8xkgH+JTYBTdg+QT4vUrxDWI3GPTt
	g8+D/bhxN+6lXETkJdheVAjf+tht03BTixn
X-Google-Smtp-Source: AGHT+IFSN88LkE0hoeQPA21Ddx9tTeS2LrbUWhOti6xtPlTVQXxYLVcz9qqYEvVMs4/6ZOK0+maVrnQrlYLD1oHIxdE=
X-Received: by 2002:a05:6000:2001:b0:3f8:e016:41b5 with SMTP id
 ffacd0b85a97d-3f8e01647f7mr1253405f8f.14.1758408107301; Sat, 20 Sep 2025
 15:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920153531.3675700-1-yonghong.song@linux.dev>
 <CAADnVQJ-28Oy9OoKXtnDOZBxkDofuwfWS-cdSFHd1uqpOmNLmQ@mail.gmail.com> <9ba2b2fb-e92c-4b0d-bf39-d655ab8e9f1e@linux.dev>
In-Reply-To: <9ba2b2fb-e92c-4b0d-bf39-d655ab8e9f1e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 20 Sep 2025 15:41:36 -0700
X-Gm-Features: AS18NWDIs6AkFmabxvGpjF1IN6IO3a1Lo0BGp8DUtOjnQj7Am7D6dQu9tiC7lBw
Message-ID: <CAADnVQJmVS3oHpjYJUAoZBpXX4hCzZn=v4v88hx5DzLfofCRiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 11:50=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 9/20/25 8:56 AM, Alexei Starovoitov wrote:
> > On Sat, Sep 20, 2025 at 8:35=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> With latest llvm22, when building bpf selftest, I got the following in=
fo
> >> emitted by libbpf:
> >>    ...
> >>    libbpf: elf: skipping unrecognized data section(14) .comment
> >>    libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
> >>    ...
> >>
> >> The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmInf=
o
> >> inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
> >> MCAsmInfoELF. Such a change added two more sections in the bpf binary,=
 e.g.
> >>    [Nr] Name              Type            Address          Off    Size=
   ES Flg Lk Inf Al
> >>    ...
> >>    [23] .comment          PROGBITS        0000000000000000 0035ac 0000=
6d 01  MS  0   0  1
> >>    [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 0000=
00 00      0   0  1
> >>    ...
> >>
> >> Adding the above two sections in elf section ignore list can avoid the
> >> above info dump during selftest build.
> >>
> >>    [1] https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6f=
bb1e5aef140b00cf62b81
> > Can we revert this instead?
> > Why do we need these sections if we're not doing anything with them?
>
> I did further investigation and it looks like it is hard to revert.
> To make things work at llvm level, we need to revert the following two ll=
vm commits:
>    https://github.com/llvm/llvm-project/commit/87c73f498d3e98c7b6471f81e2=
5b7e08106053fe
> and then
>    https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e5ae=
f140b00cf62b81
>
> The commit
>    https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e5ae=
f140b00cf62b81
> lets BPFMCAsmInfo derives from MCAsmInfoELF, and the commit
>    https://github.com/llvm/llvm-project/commit/87c73f498d3e98c7b6471f81e2=
5b7e08106053fe
> push printSwitchToSection() to each variant of MCAsmInfo. The MCAsmInfo i=
tself contains
>
> +  virtual void printSwitchToSection(const MCSection &, uint32_t Subsecti=
on,
> +                                    const Triple &, raw_ostream &) const=
 {}
>
> and
> MCAsmInfoCOFF, MCAsmInfoDarwin and MCAsmInfoELF have their own specific
> implementation.
>
> So if just revert d9489fd073c0e100c6fbb1e5aef140b00cf62b81, then at BPF b=
ackend,
> printSwitchToSection() will be a noop. This will miss a lot of '.seciton =
...'
> cases. For example, there are totally 89 llvm BPF selftest failures.
>
> For example, for jump table support, all '.jumptables' section name will =
not in
> asm code. Another example, '.BTF' section name will miss as well.
>
> So to make the thing work, reverting both commits are necessary.
> But tt will be hard to revert llvm commit 87c73f498d3e98c7b6471f81e25b7e0=
8106053fe
> since it contains lots of non-BPF changes.

Hmm.
Can filter out these couple section by name in BPFMCAsmInfo ?

> So I recommend to fix the problem at libbpf level.

It's probably ok, but let's see whether we can do something on llvm side.

