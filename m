Return-Path: <bpf+bounces-20505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7683F2A7
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 01:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC591C22275
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6DEDF;
	Sun, 28 Jan 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Zv30rbJ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="vFFzIGo2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="goV/Ly96"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD91367
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706403219; cv=none; b=RxgIPgaHcP2GcRAEs7kE0+ikzvsUnKax4hRcLiHJHf8eL5Dh756ccCib80xohB0AY47SdxrdK5jezsVmas1PneidnXOuya2UIPeCqTLa9J3qKleQdd0lV0OyNl0aPvvy62GaJoApsnzCVsDNzy34c2oqiRxr26aUpssSOktf1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706403219; c=relaxed/simple;
	bh=gBDJwfLWod9hP5sIcRQX4yA7+Mo7mUrIzS7LnqTE808=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=IDiH9Uwybs+wP1rEDEHqvXGjU+5dQwhaFprcRa2vKNFiR/ibSBeDXpXN7RcD7VQsXWjoq8k+dC0Jh/XsTkUvhmX0IvTskjwwVhU1FdM9VB2Nzg/x1WytXT7Ft4u3aJhoFGd940bJCwK+Z+ii6uARtmYiliL0YlE6L4UOSh/PalQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Zv30rbJ3; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=vFFzIGo2 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=goV/Ly96 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D671CC1CAF35
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 16:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706403209; bh=gBDJwfLWod9hP5sIcRQX4yA7+Mo7mUrIzS7LnqTE808=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zv30rbJ3GZfFROZN4usm28JtQ0FIYKAoy/SerELG2dByCpquFxDCXv6oBwcRrZNk4
	 Ue/VtMJ42+dQ5VDM+/G/+YjANfS94jWur7fCMbusVkQI/61egX18sVRGuXmgOiDWL+
	 u9QyTUY5s3dOronroMwU+7gdcBdu7YdlN4L2GIbQ=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id B3F62C14F6AE;
 Sat, 27 Jan 2024 16:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706403209; bh=gBDJwfLWod9hP5sIcRQX4yA7+Mo7mUrIzS7LnqTE808=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=vFFzIGo21Yb254BqAq/qJkTKZhKGlRevUsshmvH56+1VELjkoJ8kDtZgu75zWHPjB
 twtGJFvBMkkXAmx4CLdeZYbLws3HHWOV98TP9cDgbOve4MH6a/mcW1swZDXBssRfMM
 O4Dcz/THI9W4x7VwkILb1u5e5SUw9hqQj/+eWJ7U=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6F214C14F6AE
 for <bpf@ietfa.amsl.com>; Sat, 27 Jan 2024 16:53:29 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xxFtl9V8lJDB for <bpf@ietfa.amsl.com>;
 Sat, 27 Jan 2024 16:53:25 -0800 (PST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4B718C14F6AD
 for <bpf@ietf.org>; Sat, 27 Jan 2024 16:53:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bda741ad7dso1560701b6e.1
 for <bpf@ietf.org>; Sat, 27 Jan 2024 16:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706403204; x=1707008004; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Im7YhTaYRhDehpNrv3eU0xpPSS7YJXBfNuKMWuSHYY=;
 b=goV/Ly96AgFuYUuPGp81QlolW+2eEDW1MNhF5XFrzeVlltkyZuctY77zPKjnB0cNQf
 JJeFXdU041KBqiSrE+XbOJt/laAF4mB/J3/FgBaOQwwsxCBkfAy8RY1pqvOGbyOME6U2
 OP3/BS03U842bTODVy5z1CTkVYpNferjXb7lBAXfY+DfLY59EpyAOAxCmSTt7LVfSmBI
 XdpXNafy+jaNJIsy5U5gZHwBFEud+IoIBwGQTe9gKVHdhd6jkc5E6pfJslNiQGrd8uvb
 MZHzV4W8dTxvnB4IJFQn7m7GxQ+ohrP62kdwQ3QrHw70eJH3WEgTCgeiNjpCnfUE6M5f
 he/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706403204; x=1707008004;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Im7YhTaYRhDehpNrv3eU0xpPSS7YJXBfNuKMWuSHYY=;
 b=myWSBmWeqgHNeQ30w/MHp8bpS86+uE9wkigXsNgRPwm3hZB9eUBdykWacleXMGZ5CJ
 YShCu6r3rdxaVlhg41C4gSAbou/osyoKmKKc/tb7GMvyW6YzI4uewnahrJomFXGtBFCL
 RZxzY7ZxcT2NCk9yv2pc8b8znzaX9rjDZ2k2+QB5Qv4HT/2WVKn6c+0dA4jVw218ymZM
 aQq/k9xbLU8vM/5YPOoif2BYi5p4Um31RD2AnYuDhRkduJrhFvScwC4b6llWLfLNLdko
 OWbN4prvv4Rr7FePaSbg3VqXi3VBdGfRuOz9Ms4rk6Y8WfslLNmD9qGC1fjJyS4FPDkT
 qCoA==
X-Gm-Message-State: AOJu0YwYkZ1FYPPSMXMQOu43B8A4BlhV/DTYm7uKsJJv9N0KXcpIBcTZ
 POPaN6yqTqhdsoyhZRLY0EEQ4BRl4Ylpr9d46AKQ4F5Ul2kjrghYJpWfEKkBNso=
X-Google-Smtp-Source: AGHT+IHdJRFravhNWRefXc0X8EJicmnodKw1jgAfDrhh1WVi+obZflBJMLaOfcC3Q1GzQLTxZyim0w==
X-Received: by 2002:a05:6808:399a:b0:3bd:e016:c2c9 with SMTP id
 gq26-20020a056808399a00b003bde016c2c9mr5396026oib.7.1706403204136; 
 Sat, 27 Jan 2024 16:53:24 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 b1-20020a62cf01000000b006d9c65cc854sm3488170pfg.26.2024.01.27.16.53.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jan 2024 16:53:23 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <0c3d023f-0f19-47c3-8615-6c1ec006e2d8@linux.dev>
In-Reply-To: <0c3d023f-0f19-47c3-8615-6c1ec006e2d8@linux.dev>
Date: Sat, 27 Jan 2024 16:53:21 -0800
Message-ID: <018901da5184$647f7ae0$2d7e70a0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QIYN44CsBMUalA=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/XMbso118w8-gRMQ0j6C64aX7fmU>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Saturday, January 27, 2024 4:27 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: ISA: BPF_MSH and deprecated packet access instructions
> 
> 
> On 1/27/24 10:50 AM, dthaler1968@googlemail.com wrote:
> > Under "Load and store instructions", various mode modifiers are
> documented.
> > I notice that BPF_MSH (0xa0) is not documented, but appears to be in
> > use in various projects, including Linux, BSD, seccomp, etc. and is
> > even documented in various books such as
> >
> https://www.google.com/books/edition/Programming_Linux_Hacker_Tools_Un
> > covere
> >
> d/yqHVAwAAQBAJ?hl=en&gbpv=1&dq=%22BPF_MSH%22&pg=PA129&printsec
> =frontco
> > ver
> >
> > Should we document it as deprecated and add it to the set of
> > deprecated instructions (the legacy conformance group) like BPF_ABS
> > and BPF_IND already are?
> >
> > Also, for purposes of the IANA registry of instructions where we list
> > which opcodes are "(deprecated, implementation-specific)", I currently
> > list all possible BPF_ABS and BPF_IND opcodes regardless of whether
> > they were ever used (I didn't check which were used and which might
> > not have been), so I could just list all possible BPF_MSH opcodes
> > similarly.  But if we know that some were never used then I don't need
> > to do so, so I guess I should
> > ask:
> > do we have a list of which combinations were actually used or should
> > we continue to just deprecate all combinations?
> >
> > As an example,
> > https://github.com/seccomp/libseccomp/blob/main/tools/scmp_bpf_disasm.
> > c#L68 lists 6 variants of BPF_MSH: LD and LDX, for B, H, and W (but
> > not DW).
> > Other sources like the book page referenced above, and the BSD man
> > page, list only BPF_LDX | BPF_B | BPF_MSH, which is in Linux sources
> > such as
> > https://elixir.bootlin.com/linux/v6.8-rc1/source/lib/test_bpf.c#L368
> 
>  From kernel source code (net/core/filter.c), the only supported format is
>     BPF_LDX | BPF_MSH | BPF_B
> 
> The insn (BPF_LDX | BPF_MSH | BPF_B) is only used when cBPF (classic BPF) is
> converted to BPF insn set. If the current BPF program has this insn, verifier will
> reject it and bpf kernel interpreter does not support this insn either. So
> technically, (BPF_LDX | BPF_MSH | BPF_B) is not supported by BPF program.
>
> > So, should we list the DW variants as deprecated, or never assigned?
> > Should we list the H, W, and LD variants as deprecated, or never assigned?

Thanks for confirming.  I think the doc is ok as is for this part.

> > What about DW and LDX variants of BPF_IND and BPF_ABS?

What about this question?

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

