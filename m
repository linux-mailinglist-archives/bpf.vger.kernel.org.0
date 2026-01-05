Return-Path: <bpf+bounces-77893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F748CF5F66
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 00:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E09030754DA
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6B30FF27;
	Mon,  5 Jan 2026 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiQNpLCj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927762868B2
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655228; cv=none; b=knCA16sJpeXp1bxQYh3ab5H1QvAhXBu8UPooa91WVRcqTCXXFzvAk9TyE5RdPs1Igb9L6nkJU3FAQTJZl20bOFOwihI+XkTuJ0+qN+l972c4Zg+UdNG2QEDd4WPbxCRhjPPKyUmCf/U2ZbR/nFicuSVVIfRbRkH4hpUjQ1I1c+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655228; c=relaxed/simple;
	bh=0E+4QPBstXUcDSUWtVQHs8B2Asrfe/YhSkOUHNYyQP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx52zgMKGap330KQV4G/TvAIx+9uy80VZccVEajjjUR5dcIg8t6DJVjQM0fecavk1/1J0beM2xm6BrpucNHxv8LFWYVD3RXzQ/amt1n/f1jejAcCB30NvK90psgPkHTj3MOKLiykdRM1N3CdBIYKC7kZ7nmq//nZE9pE1lBEdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiQNpLCj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so552199b3a.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 15:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767655226; x=1768260026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E+4QPBstXUcDSUWtVQHs8B2Asrfe/YhSkOUHNYyQP8=;
        b=aiQNpLCjUxuOQ3UJ5FYQRkvtCbWyoZwG12ZeKx7XVgEJJ074poojBtvyedqcgRWjqS
         I8SnlZxW31rzc5xWi6+NGqkVhNrPe31ttRaxriYb8D/KDM9bwF1AYNDdYLI+T/TO+sli
         whhWxdA5JgHubQEV4tGaCCG4xALLn9eZLQa9XEVBOJ/3TLp/Vf3sdDaNCTejFc+QG2Lc
         SaK8X5y7/gpx+ghEr2Caa0HpO+UoudSZfUa0dKFqZwV9OIMXIBvGBdMMSV3tbIr9htfI
         utUHWFZQ1MmU0BfrGEiPeli+py9Qfh7610zInrO+70kKV5w1CVsEqIPsdEOwqEbTO64L
         xXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767655226; x=1768260026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0E+4QPBstXUcDSUWtVQHs8B2Asrfe/YhSkOUHNYyQP8=;
        b=dfJBAi4ZU/yX2ONVMyznqY70MbpSdwrxoDBEjHSd8Twwz8/4sQC8c3MYURHm6NpmyB
         IXc4JTKoaKsPftDXAXdv+8T9Uc7hVcf158U5TeY5ZckjwZmhtbROlQatsB5u3oHtN+x7
         yO+oqe764ZKQp7j1RLhBoAMJ3ByJPo5iBMoBh95t15MIwFu7/ggCSa1lR7MMagNKqHAn
         0zayfKom5Mw8DVGSSouHqjCl6pTYD3MyzqknUeMV7m3ZOUpmAnRKQgt09f6C/743UCGM
         j+xZd+lRmqxs54xWqGNNoSIH5TZod7tvv+wNMc9IQd+PRPDMKQ6F3bXUxFB6w2IFgssc
         vZrw==
X-Forwarded-Encrypted: i=1; AJvYcCU0KLEMIiozJc/zSAlN1kqR++UhOkbvGq/NXjZsQOX2S/sTqJRHLp/BXWUiVyEWlIgeYZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeEtcCW0tInq2YRYv0fL52W7Ia6qfqVB9QKwiHmTNATpM78ex
	D8UP8jvxzT9wXxRlSWKpBkDVwdxfKHjfmpOieeFG7Syx0GXLIQF7FiwrgI4JhHjMBebh57/ajk+
	QT6Q0X7UsU7RiZI/QJOtqzEe9mnVdfEc=
X-Gm-Gg: AY/fxX7RIqGs6olWjJBKw3jUcR0IUItAnid17RBnI1EVYt4A930MUTvPvJ9RU8XjJSe
	kSczFfz66CVPXHBWXoPORJTDx23hprH+y2ECv4keOJK+n4RNl8Pufjw6f1h+NiucGh3a7cpaqcf
	bw8og0AlIBxfUlkDh1xtKCBh5i9XsedPKjQ7r8ZiGwTG+VKCf2IwLi+S2aRMY3qjkAub1cvKaw/
	LqdG9FgT7oJp3+bI5hnrCJHsHnwxku2Ni2ppzP0CCJo83OiJ12lt21kLVCpTNlKcXSQ+3HcoRvo
	nE5HwZWKHUo=
X-Google-Smtp-Source: AGHT+IFuFoCraIRea4qJ15vjHbQ1kIwwD9aKbmZqN1IFqHVG/eU6maV1Menh/bm6z+1shlHBeKJ063tmJwX6QC53aFA=
X-Received: by 2002:a05:6a20:3d21:b0:355:1add:c298 with SMTP id
 adf61e73a8af0-389822f565cmr887636637.21.1767655225850; Mon, 05 Jan 2026
 15:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn> <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
In-Reply-To: <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 15:20:13 -0800
X-Gm-Features: AQt7F2rHkS7ZrHcrANFCtqfQxw4ogv5j_Cyjsb5vUpE0ah3hN7_wtOLCd4Zs2dM
Message-ID: <CAEf4Bza4fD5WWWBxJk0dd_xvgPR0ORZpcp1wiahyMPjvdoWG0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 2:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > In current solution, we can't reuse the existing bpf_session_cookie() a=
nd
> > bpf_session_is_return(), as their prototype is different from
> > bpf_fsession_is_return() and bpf_fsession_cookie(). In
> > bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> > the cookie. However, the prototype of bpf_session_cookie() is "void".
>
> I think it's ok to change proto to bpf_session_cookie(void *ctx)
> for kprobe-session. It's not widely used yet, so proto change is ok
> if it helps to simplify this tramp-session code.
> I see that you adjust get_kfunc_ptr_arg_type(), so the verifier
> will enforce PTR_TO_CTX for kprobe and trampoline.
> Potentially can relax and enforce r1=3D=3Dctx only for trampoline,
> but I would do it for both for consistency.

Yeah, I'd support that. It's early enough that this shouldn't be
breaking a lot of users (if any).

Jiri, do you guys use bpf_session_is_return() or bpf_session_cookie()
anywhere already?

