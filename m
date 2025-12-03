Return-Path: <bpf+bounces-75985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03112CA0ED0
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712C13002166
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA43081DF;
	Wed,  3 Dec 2025 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5feTn+a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA588260569
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786238; cv=none; b=R8DdeIkpwlh1fPrP5Y1P0iUnB3ni1Upef+upJwJs4yvr+lqDcYmRV++kciEnTyH7MqWkIHmj1yvxA23/w6UBS8L0o3GbAhrtcOUWXwc+N+5BgppsFY9/nQHpvF3jqkxFTlawF+v/Zd0U3d8yKljKJSy7xJ0QZi4Ug7rwvszprBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786238; c=relaxed/simple;
	bh=JvZgeUEK/69O5/cC54XZ90cPGtKnuFkBqicR9uNdtBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4ORDOYCigsMGQSI16nMvhWNeYyExVjRf67IAL+tea47odysAQoCbwZNYl+IzX0NHi8irHpFYNgvXKMzbpZmnujB4u6BgSRvdtC4erFlYsNrPeU87sMMm5423Cj7Y8MZRsR3StcJyhQLIcxfh9S9MUADl/uN12jti9aq91Oo348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5feTn+a; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso56703f8f.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764786235; x=1765391035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWlqvDt/6IWbGV6XkG19G8HZXGwyr7gs/bHnFxe9H4M=;
        b=A5feTn+ajxzvMoVtouzojy49LuLrwyk8ypagRD0Q/pjCJGe2TCJvup9/qjvAPggUzR
         D24vDUEeiMLarDiShpSSBjjqVZJWlqI2oatvCE/J7VwQZGSlpiBqp7OLoiHK4lOz89zG
         e/5sfuo9b5hXAVAbExFFu4OBQcCkmPYlD38Ie5Sx9NApRQF6eGi/Q+zpB3oOZjo6sINj
         RWbbS3TNKzH1hBSTAWvOjdPWy0yr0GO4khNzTSmybaU2u/UZgyITXLyiXZIno68q3CN9
         NRTrOy0VJYQAE1Lnr9c2PrFD/YbuldLXbqKKEKYUsXl9HgLof3st3trooAizL/mcS/Vz
         5cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764786235; x=1765391035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWlqvDt/6IWbGV6XkG19G8HZXGwyr7gs/bHnFxe9H4M=;
        b=a8avjAjN5ZlMw45zGtH6LHTiVAYtTtOGJa9yUwZ+llfnI2HZy5S8+q5bLFd/pd/JOb
         DHmPo/eBUM7h2M+eBfyq2jq4NrbUUW+fdc2B3hDC8dCh0/oww4cmuUMqELaVKC50iz7C
         +jU+F9DW1Uxpzsvdxr7ey0lEJpGnC7f1WD6qzic7OUs73hpyW84DQak/4QYrFrJ7kHos
         upVhSQK0nPNOqmsbLqOH06SKxi9CeKbxjCyeA+73BtcKlgfcaTjZQdDWgvYmIRZ4EDMt
         6esup5WJ4tb8UZ/K5Yu1KIEzAvWDlE2cYguVoTF9XrXcMeTMmrziPsUXipkwWXvptNdQ
         EtUw==
X-Forwarded-Encrypted: i=1; AJvYcCXqBAef0rPRSXM/TwFnL1YyADlqu7KPr1aTR8+9Q+nXSrk53rvfnsnkhm3I74SNlcoe03Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJyjXCRva7Fv6agRLGzgwNll23ZESdOuH1sEcEyuSNBQRhXEu
	fL8le3MpThEYgcgg6FE39HTid1GPQjyDf2/efd6je0b08htHfT9XB/H/Pu2eP1MGsCfxFzHEtvm
	c+0LEotJ1maEMCWz8p7c2DNM5zqNkc6c=
X-Gm-Gg: ASbGncsEJTu6+P5Ehr3MIR1nqPWAlpUvVTHZtBXJNhp2/kVLKbIVuskk/cK2WyrIVYK
	uVvAcc89cYsatng+mP0uRc5ET3/NITyICNJfiFTa4fd8ue1t0unuEgjOOy9CP8y0l3/SS8hGctz
	ymaMxw2R/6IivqIf6ZC2Ud4QwysEBGrCTRrxr89OyxumwG0IRbGUZ5nMDXDZigH93wl2vKXs2Z8
	mWKWeb4iV4xE3XBvppij3qBf130oVC1BwDzxtXaXtL6w7Cm5ojfvkskH9l2zSR3YNWynwF7hqNE
	xHpX8j2TOABLKzSZkvQ6WXwZ7JjL
X-Google-Smtp-Source: AGHT+IF7kn7idrbT6A1vy12p6Ewu3ZOCzCQbEq839qDPwX9OoUC5cgr2VLeuDdfpD4o1kBEVghidaZQjOhyhfLPQVEw=
X-Received: by 2002:a05:6000:1acc:b0:42b:55a1:2174 with SMTP id
 ffacd0b85a97d-42f731cbfcfmr3271165f8f.59.1764786234965; Wed, 03 Dec 2025
 10:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com> <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
 <aS87V-zpo-ZHZzu0@google.com> <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>
 <aS_5K_CJcB1rIEVj@google.com>
In-Reply-To: <aS_5K_CJcB1rIEVj@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Dec 2025 10:23:43 -0800
X-Gm-Features: AWmQ_bk4a5WpQJOq-d4n8wJw6H7-KtLwXDF75dbTGkV1icn8uSfRK3AakKN16TM
Message-ID: <CAADnVQLf10J688CXFWg+=UaOv_zPTr3ViqNFcjbe5u4no2o_GA@mail.gmail.com>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, hust-os-kernel-patches@googlegroups.com, 
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:47=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> > We can play tricks with __weak. Like:
> >
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 7cb6e8d4282c..60d269a85bf1 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -21,7 +21,7 @@
> >   * function where a BPF program can be attached.
> >   */
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> > -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> > +__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> >
> > diff kernel/bpf/bpf_lsm_proto.c
> >
> > +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqpr=
ot,
> > +                     unsigned long prot, unsigned long flags)
> > +{
> > +       return 0;
> > +}
> >
> > and above one with __nullable will be in vmlinux BTF.
> >
> > afaik __weak functions are not removed by linker when in non-LTO,
> > but it's still better than
> > +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> > No need to change bpf_lsm.h either.
>
> Annotating with a weak attribute would be quite nice, but the compiler
> will complain about the redefinition of the symbol
> bpf_lsm_mmap_file. To avoid this, we'd still need to rely on the
> rename and ignore dance by using the aforementioned define, which at
> that point would still result in both symbols being exposed in both
> BTF and the .text section.

Not quite. You missed this part in the above:

> > diff kernel/bpf/bpf_lsm_proto.c

it's a different file.

