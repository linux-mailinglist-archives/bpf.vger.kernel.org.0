Return-Path: <bpf+bounces-78448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B33D0D061
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 07:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6411303804F
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734333984D;
	Sat, 10 Jan 2026 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XclxCg3Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFAF1A5BB4
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768025131; cv=none; b=sgEdp8VeZgpCA3FoJz7in9rze4dAyTwNvIqXkeulV+n6egJvwAzgOwFzRlubHgtqJcj1Nwmmg8bZ/IqM6Q1fHpcVTBp8EpsWBqmuibz9IAbyKy/9p7qgb/03+tl7xdRyEd8PDoPHKpLgXraiXBPGnelTEMFZ8DybVLE5ZKJXvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768025131; c=relaxed/simple;
	bh=kevaTriPoK7uo2zRxhJdxm5S4k5lh+Y4F4KTuM+3wzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBbAesYykF+4yQoko/g7IOchHBc+soYlMLDIt2onwhHEFkqTjxeG+LYzMBWeTczxfOJQt+EYya3HuBS3ZZ/jGg2wj54fseTiSYEEoio51SdbsIXksu2oJE2UPREZDJKro45ztA+Qpcu9HcY750olIsSRJMK4u7IHpSq3ZJxtDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XclxCg3Y; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f57cd471so2502769f8f.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 22:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768025128; x=1768629928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bglbtsHOxySnlTuSr3LlIYflvRTUmpsnMOYiW/z1XSg=;
        b=XclxCg3YHOW/ach8zwvZEGFCpjKih4E62+62YA6FZ6KCeq7gIiepxrIAkTmcEjiExk
         bj3o3jLx7DBOQKlMaoFd16pQWf1xoPc+BisMXjWTvnFbcCjHZXb/47w51TOACj29Duk3
         T7E3Vb0cXIIzb6Y/AGAAmYSYbPAF3eAqPf5LNwxbKIgpg59lfF6DY+GdiOq3Lqf9h/PX
         At45eKSGjR0lsWQztI9tNK4BKobjob8s3B+Ypj8El/PnfjxNLLbHEmVmHzWMBHZklZGM
         0Yd1fEufcIUAG36+M7vPBfQuIlFfnsSs57ZkGxyjlDmm387JOfXsJlLdsZRXoS8VjBFi
         O6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768025128; x=1768629928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bglbtsHOxySnlTuSr3LlIYflvRTUmpsnMOYiW/z1XSg=;
        b=t1nb/fTXqFa8fceDUVYJj73Tax0CgKv7j3dyKSq+AwbubedCaeLr4qoxPPgpHqLnzg
         WxhjLXnKvxggxx7XjxiBc+bHFKPmLkCCo9osFYHH1YAtoY6Wdtat122BbCvo6os5lqoC
         ydZ6rnT8Onf6LdycPBhTTPQU403VgPKEcW+Z04nyfg7jNnX7Lvzil+Mt2l9cCPm6Vh5a
         b1rNsHJrbzmbt1flpPVhSZkrFWdCDoERiVxVfAPyBej8W37g0MSx2FS0q20HSqhrZguT
         CMeKpsdnywCBPiBs5TIH7IHUTomp6AkbRLeQ8nUAvcFd4OM5a1dVrUAkxFfgTmx1CymS
         H1QA==
X-Forwarded-Encrypted: i=1; AJvYcCVVx8djhLQm5EWuaXPrWcCoRStlR8utkLHTx+xAvsPyF/Lo/uio3OH+xSzt82nAqjRsqzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJt+lR7KTiKaIgoocruCl33mV1OGEvWaSB0Fvf/pOvqcoot0Mt
	niaKj+0ujOKtGjlZDnVJUq2KiFI3hM2Tq4QQg9de1h7mIhQrQyQ2tqAlmlOutInJHFjn80TTHy9
	wojSMTgGEej6tVItx32u+WPHH7RQtdLM=
X-Gm-Gg: AY/fxX4C2eWg3HdhSz9hf7do0yaGLLwnZAs3ufzC3esBmfRr5NRgQ1GN1PPJnHsIvkC
	VPmoe8B31q33IymMF7ajLCBtReitN0SgEY2TgJMagzCWWiGBMgaa3896aXdN6DDA0GZZawc2JHY
	vMgleZsxL3EMytUtEBYYp2iYDdS5lDnfktwsysv+IsqBD2RatPr6p320/7PkFMqSukZ5HmPEAOt
	MjwDu/DWucZ/ZSBas2yVHF7s7/fupbM0T7F47dQYEw2t6MrZ3zVVzmgxMDGO8hnGggZKPajOpJg
	OD0fJJLuqGdFVJ9AHdrh5buDUELT
X-Google-Smtp-Source: AGHT+IFIGMY70drcXjnQqo814e6yw5emZ0xAl+kZ2Ch2S72OzxevXU0Aef6RQ5bd7MfcTI3HfveNSiRcr2htHPQ/eDc=
X-Received: by 2002:a05:6000:420c:b0:431:67d:5390 with SMTP id
 ffacd0b85a97d-432c37757demr16763024f8f.54.1768025127786; Fri, 09 Jan 2026
 22:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
 <20260108022450.88086-5-dongml2@chinatelecom.cn> <CAADnVQLj4c-nc6gLbBiaT24KXWEpG3AzFT=P1tszu_akXhyD=Q@mail.gmail.com>
 <5075208.31r3eYUQgx@7950hx>
In-Reply-To: <5075208.31r3eYUQgx@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 22:05:16 -0800
X-Gm-Features: AZwV_QiyO19oQ1GqYdcTiEpyTcAEmMfkfKsihDLDsu69uCPWQedF0QdILw5JDow
Message-ID: <CAADnVQJTc3qegim-hyzaurnCX-8pRQWoj+r9+0jgBQ-WmpLHuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: support fsession for bpf_session_is_return
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:38=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
>
> >
> > Remove the first hunk and make the 2nd a comment instead of a real func=
tion?
>
> Agree. So it will be:
>
> +static bool bpf_fsession_is_return(void *ctx)
> +{
> +       /* This helper call is implemented and inlined by the verifier, a=
nd the logic is:
> +         *   return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> +         */
> +        return false;
> +}

No need to define an empty function.
A comment next to 'inline-by-bpf-asm' part explaining what is going on
will be enough.

