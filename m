Return-Path: <bpf+bounces-53216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8BBA4E94E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C2917F446
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E5027FE9E;
	Tue,  4 Mar 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A6svpFLx"
X-Original-To: bpf@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148524EA8F
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108052; cv=fail; b=VRZ6Ucl8+phbyDDJlGpZ8GF0mNA0dyDVGRAv1RxbResZF+yAzI0bOLgMmR9KxWCji3MkTJe7ADdh+o235/Hx/J+vG5MVPu/iL8mV1NX0woyikXMwi09rBmBvZ1oxVhn4vz64i55yqWbGaUwVgHRxdiDeuHtkqbaB3HcBout2DOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108052; c=relaxed/simple;
	bh=xgkOjTGBuPWiC/vGa3GGgTxvoOaTjkFNA5ftkaM32co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPaVD+N66jh0QduOFLCh+YX3YJez6wNdKUfplNpWn8Sh9jeQAbhTByibKPub4P6q+znFT+ePQwjoj7IqAqTxpR6ItUSBKYfpc6fDrxzeuVlrifkwDWnbhvQtuKtv1bpaSxNZPP3dlOT5zivhgMyJQU1/Ymy3YkUUAeT5XErN4Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A6svpFLx reason="signature verification failed"; arc=none smtp.client-ip=90.155.50.34; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 8CFFF40D1F40
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 20:07:28 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=A6svpFLx
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fmc1djZzG0Xv
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 18:31:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 562C342729; Tue,  4 Mar 2025 18:31:41 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A6svpFLx
X-Envelope-From: <linux-kernel+bounces-541573-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A6svpFLx
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 7A079423C8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:27:44 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 5191F305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:27:44 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710D8188BC47
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2331F4171;
	Mon,  3 Mar 2025 11:25:13 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890D1EEA5F;
	Mon,  3 Mar 2025 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001110; cv=none; b=aKSlEvlHoes7mmsf4FdEt5D3OXzlcTeSaYvhwxCubXEMUAeIfJ1yqNZZKG+2Xf5BBfDLZHQSLU4nhod8Ia5si1iyFk4DfBvTAuz9ymTXOV3J4u4RoWlElW1gCtXMjn8JviIuE1Q0ijxY+tt2cogOt63NppqDS25OO9bv1tMJPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001110; c=relaxed/simple;
	bh=gHkoVUKKkI/RUOL3nlWslvI3CJujVU9I3eG0j1qBMvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv7nzy8t5q6LCrCnnPDZTd47Q9kvjhVgOjBrsS64CykE4qUtKMOnpB+xHQHEsz+UZseB+DSBb02W4svMFWY8MSIBVHij8YXVluP0YCDwN24qZA3hgkorIVf9gQTkkJg4J9/g3lRBXdwjBYW6sfBEHtN5/aazTsWcs0K7gX8Y4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A6svpFLx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=z6iQmFx3kUgte9Kb2AwgmkALnfbli8g8jvKzg5SWVmE=; b=A6svpFLx+pNLGKW0tQeTqsPM61
	1sm+BtaqdI70N/rG9pstcBbdXlHScuTkqQnDqfdrYnfnmHc9BvSWs6YCfM9mtpWuVljrgeOdkC0Mf
	b284F5lp92X7GTV3DQYSjf+23RGk+32PSJDejGnbDytInBeqTNlBuArnjtB1UYjD16srlrNS3TI5Z
	ElkOaUwZxJiCGlzU8HJuBDVHNM8Aze3yU9ran6C78MVRLOpvw8aO5ZgS02CujS7InNxCFfYJ0nErI
	5Ipj4oT8pK0hYd62nQyVqTc/QrCYNI2Wm7/8Mlz6f54WLv1e42wgVY6XMTmAKjaIYUKLdtnxSRnpL
	Si5MMx6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp3uj-0000000BXXv-1WAU;
	Mon, 03 Mar 2025 11:24:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6C223002C7; Mon,  3 Mar 2025 12:24:48 +0100 (CET)
Date: Mon, 3 Mar 2025 12:24:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	samitolvanen@google.com, kees@kernel.org, dongml2@chinatelecom.cn,
	akpm@linux-foundation.org, riel@surriel.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 1/4] x86/ibt: factor out cfi and fineibt
 offset
Message-ID: <20250303112448.GZ11590@noisy.programming.kicks-ass.net>
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
 <20250303065345.229298-2-dongml2@chinatelecom.cn>
 <20250303091811.GH5880@noisy.programming.kicks-ass.net>
 <CADxym3as+KdeBMUigq4xq302g2U7UG-7Gm+vKiYGnSjHouq=bg@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADxym3as+KdeBMUigq4xq302g2U7UG-7Gm+vKiYGnSjHouq=bg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fmc1djZzG0Xv
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712720.51654@9H45m7MiE7w2LqvpF6Csqg
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 06:51:41PM +0800, Menglong Dong wrote:
> On Mon, Mar 3, 2025 at 5:18=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Mon, Mar 03, 2025 at 02:53:42PM +0800, Menglong Dong wrote:
> > > index c71b575bf229..ad050d09cb2b 100644
> > > --- a/arch/x86/kernel/alternative.c
> > > +++ b/arch/x86/kernel/alternative.c
> > > @@ -908,7 +908,7 @@ void __init_or_module noinline apply_seal_endbr=
(s32 *start, s32 *end, struct mod
> > >
> > >               poison_endbr(addr, wr_addr, true);
> > >               if (IS_ENABLED(CONFIG_FINEIBT))
> > > -                     poison_cfi(addr - 16, wr_addr - 16);
> > > +                     poison_cfi(addr, wr_addr);
> > >       }
> > >  }
> >
> > If you're touching this code, please use tip/x86/core or tip/master.
>=20
> Thank you for reminding me that, I were using the linux-next, and

That must've been an very old -next, because that wr_addr crap has been
gone a while now.

Anyway, thanks for moving to a newer tree!


