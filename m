Return-Path: <bpf+bounces-19702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0382FE9B
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFBE1F2662A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EED138E;
	Wed, 17 Jan 2024 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="JhVKTaH4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UX8VUIGT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U92cjSqa"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE115CC
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456596; cv=none; b=S2Gf3ykTGcaolU0+zhfJXxFL7Xf6u2CghU5CsDpxb/wLWqByeGIhOV5RhCatitioUhE/YVCFWNJQFGaVQLwewP5PUDJnzkHUSgRWH2cP18+kPanRk8W2vHXpytwJ+zHxguPIp60zCRrb+Nx0LVCHTEoAVcKMAXXOf8avvvH1ssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456596; c=relaxed/simple;
	bh=8IrSH15D4OwJWTh97BP6F8jyy8m3+WmNRSDMKJUCR8E=;
	h=Received:DKIM-Signature:Received:DKIM-Signature:X-Original-To:
	 Delivered-To:Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:
	 X-Spam-Level:X-Spam-Status:Received:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:X-Google-Original-From:To:
	 Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:X-Mailer:
	 Thread-Index:Content-Language:Archived-At:Subject:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Content-Type:
	 Content-Transfer-Encoding:Errors-To:Sender:X-Original-From:From;
	b=LbjxSuuT3RoMnmNrAd85wQ1KvTelPYRk3snzCSwzZ0H7LgmFKo8dX8eHQuE7OUotWSGy9aO+qGX0uzAWNw+UWTFFEYk2iAQqGk1PrAOOe0n5dsNXLMsnlhOisNMjJncR41qQ053a3n/6YywAfX4aPPTAtph4QYr/VduZjrH2Yz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=JhVKTaH4; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=UX8VUIGT reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=U92cjSqa reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9347CC14F70F
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 17:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1705456594; bh=8IrSH15D4OwJWTh97BP6F8jyy8m3+WmNRSDMKJUCR8E=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JhVKTaH4bCR4jS7SZF7I5ZhjsbQbdxdN80EaE+8qj+uxwBCSNBi7KxDCVHIaaYviq
	 nmvQt5mU2FP96eE3SShuFIUCgWx20CFAJc6bMcEEya70zD1XFzjIEFgoOJrF7wXgcL
	 aklRuVx3ChuNK4mvjcjSJJJ8ktyRXwHuvS/K05xM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 60E1AC14F61E;
 Tue, 16 Jan 2024 17:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1705456594; bh=8IrSH15D4OwJWTh97BP6F8jyy8m3+WmNRSDMKJUCR8E=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=UX8VUIGTr3IOlJz4NfrNS9IFHzdeBUbV47QulqL9w27wL7EUo164wCqUbn0/uAR+D
 wrdpsBaDXXMmkb4bQsThgewFPS3ADnNnPGym9ZlSKrUdij1QA/gTy8IY13ahspT7Y7
 HPWwXsWMwO5/NibKy4r5XVGf03fd3KBrOys299xI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 15C10C14F5E5
 for <bpf@ietfa.amsl.com>; Tue, 16 Jan 2024 17:56:33 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALa-tL7LILT9 for <bpf@ietfa.amsl.com>;
 Tue, 16 Jan 2024 17:56:29 -0800 (PST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 39BC6C14F68D
 for <bpf@ietf.org>; Tue, 16 Jan 2024 17:56:29 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cf1f4f6c3dso3388965a12.2
 for <bpf@ietf.org>; Tue, 16 Jan 2024 17:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1705456588; x=1706061388; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WlYQ8xY3bxhrkwnIdac4Bo4enzcOpheMtnluaPFlKeU=;
 b=U92cjSqapVU0qCTZKTWaRz0ufsezt7+HkBJOkUNLRWhn6OxoLVucvL5nJLzZr6RIqB
 XMdle2ctVLejNFaicMZJ/uH9U97t+U/NuaJZRcMZQ/oVkTlZmswIuzt/NJGZSbJau5J+
 iuLBcCmQ872BUwDaY4k2HQEh/qTWTz3lRH0MAVhe+eaTuMdHbk+sbTfzW6jZGUyl7vIj
 XvD+3pFTApoM87XUQKETu1SULbT4LR0TaFuaPmkhE/mDFkF6GFrRIaYjDDjoP7oBiSJ8
 u31lIOaLg27EyU9YsvgIttWybkdQyhMj6O336LKhINkrYqxaBF6d9vzt5PBNr5jKOeP9
 Rf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705456588; x=1706061388;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WlYQ8xY3bxhrkwnIdac4Bo4enzcOpheMtnluaPFlKeU=;
 b=lA9LgsecXyMq7vnJaMwQ63tqLIyW5u8RSRbOEmQCefrH3KGpYgez+tuaViIdGYyp/d
 mvulZCoAf1kYsa/kowNEO2Q8iky6hYSi1dZWn710jXfKC8AudHKDRSV7EtGJPhKrjh71
 TJtBZ24p8Mp4q6zNgrJolHQbmQtIMu7CF9rg3S08biaUL+dF62gZL3dU6LmpP6yINW27
 zYFYHAMeRPQ/7m4oa1wd83Mk6BdeCyIagrvY5lOLSUq1nA/kpwc9ogsfE2liU/8esq1q
 dQ5nyRL56mC60CdWEUQXs16vbtSS5zx90925QZTUgmTI4ksq0ALK1ooliFTvJJlFy/8z
 YSBQ==
X-Gm-Message-State: AOJu0YyCm18+rKnP1zM2gChhjjtTZdlYOzhyta15WaNMlf4vXZiUTIiE
 VENnQQ3v3uMrWYDdd1q+h6p9CFsyKtHgFw==
X-Google-Smtp-Source: AGHT+IFHFn4IJRowmrTVJ/B0kDEOC6oMmFT8uA50nzAUqvJB+0qqs9BmqcjvlTcpqWNGWNCw1S9jFg==
X-Received: by 2002:a05:6a20:dd91:b0:19a:7b36:66a2 with SMTP id
 kw17-20020a056a20dd9100b0019a7b3666a2mr3719028pzb.49.1705456587976; 
 Tue, 16 Jan 2024 17:56:27 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 lw8-20020a1709032ac800b001d06b63bb98sm9923253plb.71.2024.01.16.17.56.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jan 2024 17:56:27 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
In-Reply-To: <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
Date: Tue, 16 Jan 2024 17:56:24 -0800
Message-ID: <095f01da48e8$611687d0$23439770$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFAGlkngPAiWOVp2xKfN9gA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/I9cloOgBRnLlxfLfMqA48BNkRT8>
Subject: Re: [Bpf] Sign extension ISA question
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

Yonghong Song <yonghong.song@linux.dev> wrote:
> > Is there any semantic difference between the following two instructions?
> >
> > {.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}
> 
> This is supported. Sign extension of -1 will be put into ALU64 reg.
> 
> >
> > {.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}
> 
> This is not supported. BPF_MOVSX only supports register extension.
> We should make it clear in the doc.

Is that limitation a Linux-specific implementation statement? (i.e., put into
linux-notes.txt)

Or that the meaning is undefined for all runtimes and could be used
for some other purpose in the future?  (i.e., put into instruction-set.rst)

For now I'll interpret it as the latter.

Thanks,
Dave


-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

