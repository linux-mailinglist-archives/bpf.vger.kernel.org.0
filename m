Return-Path: <bpf+bounces-53223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B57A4EACA
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D522B16EB8E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B6291F84;
	Tue,  4 Mar 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAEzjpCj"
X-Original-To: bpf@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360A284B5B
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110370; cv=pass; b=t41ulrlut7s4blriUOr/bbuGpJYbWO5iTEe58V8zES/kYhacA/h+Ety8L3jv0l6lIJnBixseNa9W9aKs1ZKSFmC2+MZcnNJXhGFHemQrfaM0SYguJw8O7fgaWsHnIl/FcZi38mFWqdNumWvJ0ofsk37bR+BugaFG6dhGA10fyqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110370; c=relaxed/simple;
	bh=t/g0xd3Ux115LiKLycQFMagbToxXU2ApMLqVpDJxUaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja4XWrmsVsvjxyJltOKa1Y0Bkcy2BrjHi8lkyIM97asMQKeRj1oPxrYMszBZZNnZJIHhlb1keCUxZpeYRAMFiwMSC3mx/sKidH+/ZGfdb/IJjePj2xy+IgJM/ZFCKnlfFWcbZnqsVVrffaNZahOueuOpgQWdoAny4H9sZi1AX0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAEzjpCj; arc=none smtp.client-ip=209.85.128.196; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 5B97A40D1F59
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 20:46:07 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fAEzjpCj
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fHP3DgTzFyjY
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 18:09:53 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8D3ED42731; Tue,  4 Mar 2025 18:09:50 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAEzjpCj
X-Envelope-From: <linux-kernel+bounces-541435-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAEzjpCj
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 5744F42A27
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:53:46 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id E016B2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:53:45 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CD33A7A2E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466171F3BB9;
	Mon,  3 Mar 2025 10:53:21 +0000 (UTC)
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C531D86DC;
	Mon,  3 Mar 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999198; cv=none; b=SmBi4JU0Br4KEBa8dR+82D5P3IDHHhlDSD5oJdWlGZFwBFr6v5AWDTn4LjsZZ9n5y8WWyqT+06JA+FKeWIvtEStE3hA+TG1we87wXsqrHfYseqGmpje9VEeHq33znKnSPfxnAwHaVltW5jAi+vEqbaCgxWWZes+vfr9eZR+g8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999198; c=relaxed/simple;
	bh=t/g0xd3Ux115LiKLycQFMagbToxXU2ApMLqVpDJxUaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8sJ1NooKgbzVdOxy3lmdPvPnjRBp0BD3eefm/UmuaZoF3kNG5Dn6Klz7+cADeTi77Bebo6Ue4la+t/9Fi4mwGVWOYSO2dme6dHLUWvaBmGpgMAdmkTRyBAeH2gZcCwulxjqhYTKhI/0f6xOME9g4ShnVLm+71SGID6wudWEqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAEzjpCj; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6f4bc408e49so37593257b3.1;
        Mon, 03 Mar 2025 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740999196; x=1741603996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqcchcl0H3MHX0plBBglpw5tZdbp+fJLEBNYpMMUwBs=;
        b=fAEzjpCj4/f0zaMekcT2KyNbJU3fg+KaZHA9bCIk1iA1r6f1TpSY6qIq4MH14xa8pi
         /UrTwhKwQfvbYkXncpu/gZ1XSaZXAAFrM3UJqZ7yMfQiednG2PfPfeWgaYt8cinCpRiQ
         oHbKlD7HcDSDtUGSUE/CnJNElijfUnckWp9K7fpwxsuTeA3bQ+86FMGmzjjnc14IIr/h
         vX4G1kyG1trTxR+DPy3fikZyjuLkAY3+NsVeITmkuGVdru0WlpQ1CRDjAUwDiYIcTA7E
         AmE3ngWeWgcFVyh/OFu34lksIuf1KJOou3rjMbZUzTiHTgfdDD/np1M/xQHhiDxJoRJb
         KdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999196; x=1741603996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqcchcl0H3MHX0plBBglpw5tZdbp+fJLEBNYpMMUwBs=;
        b=sMBPnW8KKDKXauJZC6pa2LuFUUggQQKRww4N4jKi8oKq0TQUxpfQvGcpAhYBnhRNQe
         gznvq+z8ApDRSUZM3HAroosgH/hzIY0QafuGS0hfrQaN/h4qkpHhNya1CcQjpqr1YMiu
         g4J+phuFt57JJtxAnI9TkB1xtIL+qHzYlcqaYDc+8DJ2cWDJRHTFfKF4WSLgSkWrIXxJ
         SXQoqS365eLePw1DQ7HmgA5e3f0ohTsxodtgWzwH+1tajxZXOT2gi6NAFsk3HQtmW7FX
         YOJ1aX42AQih9dmPH35fc/oYksxgp4QKtQ7oiU788sx6Qo61A3AWlMhFNyxNxSOnSoL+
         Pz3A==
X-Forwarded-Encrypted: i=1; AJvYcCV3d0IdGKeY3Wv+WPpZ9Ts0IDdkX2zFYCkfpRWJieio3M8qTU4xXMrlAJUtoh32viHPiJo=@vger.kernel.org, AJvYcCVWx8EVHq7JhM2A5Dl/sl/oCA/WPND3MFQ2KTHM2XCVKlokfnPuI/NVwlYJ7LaNbyC55+qfaniVqcueLfw5t6ME07rG@vger.kernel.org, AJvYcCWDcABtb0+xZslY0PO669sIMEUXq/S+PILTtByt7l8TZnt9h3MQAChCoci5sHxEeLnSylqm3tAD@vger.kernel.org, AJvYcCWs9KYuIUTBCHzAuQam/RHTGm51g+yFsTlD6+iWZK9XuXhnY48LFk0jy+SlT7u1rDr44GZXOrgCc9plPW/J@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKs4bh4j8HIMnt2H5KnuTDtyFtg5QtakEW6qbQDgz2TlAFQlP
	CuLnSLOJR1Q5VkxZBv831ntlJhh5IhOeMgXojarGAtpMPUL9CaypaMcyc8WorTQD2EUzPWyYHkg
	/neROTnAz5FN9V4GQ+tFLZbnMmGc=
X-Gm-Gg: ASbGncsuS+OSbVQ4jPiB2HPeBrgG7kZ4keSpAzlZ0L9lE6rD2dRcVSzwj4KcDX/IVFE
	+F/geXtpVwqEEvo28GSxonTpA73yZrF+ZisVuT/SosrAFUxcp4nGCBbLf8Kgu03k/WV9aV1w7Mk
	Q77tozpTFwKK+H/55m0CCoiqnY6g==
X-Google-Smtp-Source: AGHT+IGPFg7vyGunvepCrP71hctzW/wiFhK2mnTSkLrkuSsp6X2qPRH18XUJIiB5Y7juu2x6EocYr5DNocerNm2QyWM=
X-Received: by 2002:a05:690c:4802:b0:6fd:2f47:f4f9 with SMTP id
 00721157ae682-6fd4a0bad92mr160996667b3.9.1740999195914; Mon, 03 Mar 2025
 02:53:15 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
 <20250303065345.229298-2-dongml2@chinatelecom.cn> <20250303091811.GH5880@noisy.programming.kicks-ass.net>
In-Reply-To: <20250303091811.GH5880@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 3 Mar 2025 18:51:41 +0800
X-Gm-Features: AQ5f1JolBjCiOEE9gVLsf6wdPN2zmwGfmSm6JtRrhu885EwwD4hwEQ1WHKYNmyc
Message-ID: <CADxym3as+KdeBMUigq4xq302g2U7UG-7Gm+vKiYGnSjHouq=bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] x86/ibt: factor out cfi and fineibt offset
To: Peter Zijlstra <peterz@infradead.org>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com, 
	kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org, 
	riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fHP3DgTzFyjY
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715039.4642@fDUYpneJH/xZ5Osp1A0Yag
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025 at 5:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Mar 03, 2025 at 02:53:42PM +0800, Menglong Dong wrote:
> > index c71b575bf229..ad050d09cb2b 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -908,7 +908,7 @@ void __init_or_module noinline apply_seal_endbr(s32=
 *start, s32 *end, struct mod
> >
> >               poison_endbr(addr, wr_addr, true);
> >               if (IS_ENABLED(CONFIG_FINEIBT))
> > -                     poison_cfi(addr - 16, wr_addr - 16);
> > +                     poison_cfi(addr, wr_addr);
> >       }
> >  }
>
> If you're touching this code, please use tip/x86/core or tip/master.

Thank you for reminding me that, I were using the linux-next, and
I notice that you just did some optimization to the FINEIBT :/

I'll send a V4 later, based on the tip/x86/core.

Thanks!
Menglong Dong


