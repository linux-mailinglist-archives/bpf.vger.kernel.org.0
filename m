Return-Path: <bpf+bounces-48223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E020A05212
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 05:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CD6167664
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 04:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F819F11B;
	Wed,  8 Jan 2025 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igUi07pp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AB156653;
	Wed,  8 Jan 2025 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310116; cv=none; b=u19v+PfYdyzCpzPJYRRZwtw7epiY1P/jNf+Ud8Xi3jcAmu+AX4PWWSEstHiEMxfVms/1U/zzsBqLIoZh91tZVqAGx2onrSVmJ3M3hdlG4s8I/+T0atsTv/ro+bPrEDbwgf6RvjNptTH51UQzdvwakMnRVqfgdEzYhlFjYMFpWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310116; c=relaxed/simple;
	bh=v3ZhR9OUMaiz4UxpS5v0kseIQjxdjCq1TAGrukVvko4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx8Moa9dxgg7JvbVwFF4APJUCQ+xZB94jYX7l68oM3XGexKhYGPcpm0S0WJ7reO8SL0VRyHc9WfdhIOnKyT8b/Y/as1ztw7BwvMgl06Kk5h8Uv5rJFAU5xZZ6kd+ZfzJwDRLjRu6Xx///fCQfN0soAWp9JWO2l8k2xadOTZTyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igUi07pp; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e6d1283aso16473439f.1;
        Tue, 07 Jan 2025 20:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736310114; x=1736914914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ybDw31erIY49mMqR7Y7m/OFwL80d9p7qsk2eXpdOQWM=;
        b=igUi07ppSVBDanhpxf5oAM+/tAxsVUxwlDzaTTIjsrT93chBrZqrR/aK1HFyS1cRRe
         yjPJ52+AfeTPo2KSMA8/lcz1Lv5Mrf3Zdlz1TyPF8NJ2Yfxm0WpewZb8NcrsfNu2nmB4
         e7EHDvbN2qM269TtM5e/jo9fDWpLgMDE74aXFjDv79x+mvmRlAMITtY09oOHArt7lGr4
         +429cZoEdRJHJ/TnhcC7eC+BUL5WIMfIc7o29EXb/GZ1UJENmCuwjhwPpvky6MRK8oM/
         A3fYUHZPDjED6QMQ7tkDfYFbTCe03w/t2+ANYb3b+PJvoZIMqma/iCc2ZilYC4PNJ/E1
         S4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736310114; x=1736914914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybDw31erIY49mMqR7Y7m/OFwL80d9p7qsk2eXpdOQWM=;
        b=ULSMFv5xha0L+MBaXp6kOdg5Vlp3FNu6AftLoRjV75dLlb/nUbYvfQqqdIMeYlGK67
         9vq4XH+18NU/S51ptj7kK/+tczHWnw99o6pqLdMusfEkwQ4Pga9r1Ns0F4KUWWxbiOIr
         b8ULRIh4EEG1vwTcY81PVpBMNckwPyuHJP2XOP7vXkvO4lrF/I2JTzaONy0IUIbf9TA/
         tSgOmm77bemyGQpnpt7A8YsFSScxKfEInr/76pQToPosRoEjYQjg+7eqFEr4IJfws5XF
         EYSW2HbJ+s7rPaFZ1BquJACMjEbC1ItuZeXgKYjm8L5HjSDhwTE7SIQrs7K11+zLGbwS
         IjDw==
X-Forwarded-Encrypted: i=1; AJvYcCUA1seSLYhAISfpjmR1/iURa1PbSKMVZ0cJUNSzRjNnrlLYjGMy1QVA+IDKgfwPygTuqaY=@vger.kernel.org, AJvYcCWcV7rfcKMcHcrFVNulaurAKyo2fO5+tyCAvMeEWc8RjmGK1nXKe09H8GSKh4bloYDaProJTMuX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+uwSS0Dnt6gb2fIoBRqLwUnwOKzLlG4IMwWcGuWa/K4cpiNn
	8C/5QxhZK8d8Z3GgYtkm9eJz2OexdNkzOHwYf5VPuMSLWylDpBg10tOCALKUIJSzR55FEdnBDDw
	PC3sSjTF+OjtN8Rjs2GwtCD8jsco=
X-Gm-Gg: ASbGncvG0QFvOSslvRlWrSdeuHL5lwNS7vGn5dJ9AGTpQS3LuGciC4y2tFGE4yhd5s7
	H9gMSKRK115s2RIHIHa/Y+2upGbvSPFLfRhND/w==
X-Google-Smtp-Source: AGHT+IEbvU3fJHLr3HRjEKdfJU0+E0uRIr0UilXzKCohs7YndOChnxAyrqxAlmHdGzRyCVxFrFschDFtZ5Tg7N5Y0Mk=
X-Received: by 2002:a92:c04a:0:b0:3ce:3657:7407 with SMTP id
 e9e14a558f8ab-3ce365775d5mr22761195ab.11.1736310114105; Tue, 07 Jan 2025
 20:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com> <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
In-Reply-To: <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 8 Jan 2025 12:21:17 +0800
X-Gm-Features: AbW1kvb2u9iPnKnBjSCf_ARzKNDVb-nMGS13YwCnscY6UwSM55IzzYBQkA4zJ5k
Message-ID: <CAL+tcoCSrBBaW3Rg1hD0mBAGu_ZTCTfjVBGe_7B=_JB+uJTuYA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP
 bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

> > -     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
> > +     if (sk_is_tcp(sk))
> > +             args[2] = skb_shinfo(skb)->tskey;
>
> Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pass the
> whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets start
> with end_offset = 0 for now so that the bpf prog won't use it to read the
> skb->data. It can be revisited later.
>
>         bpf_skops_init_skb(&sock_ops, skb, 0);
>
> The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get to the
> skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.

In recent days, I've been working on this part. It turns out to be
infeasible to pass "struct __sk_buff *skb" as the second parameter in
skops_sockopt() in patch [11/11]. I cannot find a way to acquire the
skb itself, sorry for that :(

IIUC, there are three approaches to fetch the tskey:
1. Like what I wrote in this patchset, passing the tskey to bpf prog
through calling __cgroup_bpf_run_filter_sock_ops() is simple and
enough.
2. Considering future usability, I feel I can add skb_head, skb_end
fields in sock_ops_convert_ctx_access().
3. Only adding a new field tskey like skb_hwtstamp in
sock_ops_convert_ctx_access()

If there is something wrong, please correct me. Thanks!

patch[11/11]: https://lore.kernel.org/all/20241207173803.90744-12-kerneljasonxing@gmail.com/

