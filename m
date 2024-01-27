Return-Path: <bpf+bounces-20492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF683EF90
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6886284E56
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56C2D058;
	Sat, 27 Jan 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="kymDG/Xb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XE9tYpWH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q9MW8/nB"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E082C19C
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706381412; cv=none; b=SRtRkgGHSXNbLrAXNW8RdQT6IOEIvNnvM67LiNUQDCfdK/OeBlVKriq9PDBiDAxVVQO9YkIYxi2Hf/SfTiXhBsUDT4GigXqNepLwrrjAHCMPwDPUAcRahqu8PBqfXOvzsb9fYIUCjtnwsUgmtzD9Psqq8z3OaYSb3l7fGgRPkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706381412; c=relaxed/simple;
	bh=vylQS+pZfYnKLYziHvrB8JPvKmEdcOgo+V6CINcDUA0=;
	h=To:Cc:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=Z+8R8XxC2RXvoEmucMFG/VIEihC++STo6FZa2EkUakIMTOn/zrYQ4R5dAMCs7anMXCmUETQauhEei0vd4mmEDW3EhtXuwu0eW2B5cPCvc21rlXsrIW7mFn4irIU9Gi8UOyLEnAKTNRl5EaWb5A/7LB4s/rMROuGMyj7qZxawTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=kymDG/Xb; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XE9tYpWH reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Q9MW8/nB reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 15A9FC14F75F
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 10:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706381410; bh=vylQS+pZfYnKLYziHvrB8JPvKmEdcOgo+V6CINcDUA0=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kymDG/XbevlSsrrEfTP/7m9J7Zu+mIkru7B6Hoi3tilgQ4QEM/8cR0Cu5j+2+hvz/
	 TX7P7VVuoOpZTuOtSMtCzDlfRjazsvhCXW8xiB/2OU7k8vy2P+OvC0SttImRRYgYjz
	 US9lKG383qkQJj/OvL4pdjrpUajlrER1xrYaCJf8=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id D8EE7C14F6B4;
 Sat, 27 Jan 2024 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706381409; bh=vylQS+pZfYnKLYziHvrB8JPvKmEdcOgo+V6CINcDUA0=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=XE9tYpWHjY3R7iStbGTr5MeWwZ5NmNH/jhRTu9dGpujtdwECHnxkwxawY34wa88gv
 yti7HEOGCqf/L6Wh9zgvzkfnaJrathfjgBNUvHEK+GAYhZo6e/jEbLPpyQ6QWqNd6Q
 M/ZWUVnXnLCPoBuuO/zvzBaRSp4OTv2F/OTPU5NM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5E217C14F6B4
 for <bpf@ietfa.amsl.com>; Sat, 27 Jan 2024 10:50:08 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tNSchXDfEJQc for <bpf@ietfa.amsl.com>;
 Sat, 27 Jan 2024 10:50:03 -0800 (PST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B951BC14F5FC
 for <bpf@ietf.org>; Sat, 27 Jan 2024 10:50:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so1300707a12.3
 for <bpf@ietf.org>; Sat, 27 Jan 2024 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706381403; x=1706986203; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FmSxRIxxEVrSN2b2xD7MZrQdByOFmfJtEY+7wtSfGn4=;
 b=Q9MW8/nBqzTG4P85KZW4VXNGJqyyES/sBBOsINIScW2pKR/BhMJ2B0p5+mniind68n
 fIjlm9F/8DdL93vAaRaWkUnVpJ0BjheraaYL2BJzK+NlVhrz50DMQwnhTu89uhsj+z2T
 OzdirZWXR9fKQKoMSVy7poAqKgu0j5vYEYHqI6V1tM4Ju/o731ixnQPtUZq6gVyG43vD
 lJZ4LrQeHb8dLHovpJ1kVwTPAQ86MZenW7APCTLgnhtsgzuid19eZCmIMrFJnsF8t67p
 tmnERlFUlehgbkrmREwX8KKlXdxtcq+mJ8U+BPcmLR2XcDVIN/4tEuqTMimh4Bgoxr5C
 AbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706381403; x=1706986203;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FmSxRIxxEVrSN2b2xD7MZrQdByOFmfJtEY+7wtSfGn4=;
 b=lnbs7MwO+LQvT0js0qm51PIrBMf0rVe/1KjwUIauu5U5Spwkyp7QZtv/8YkIRLtXwY
 HfrOkxV+dVsL2nT3bYv+31jCQvhbnS2ScLay5cDLePEabpP3Un22opc6kKvh9ExKtjwF
 pnmDGaFM4DX/CMukbtlYtjoa/I5HelnXRr+tDiCl5girXPNA4lLASKIeEjbD/ukhsGsm
 Dzo+Dbzm8T7aWO9kpGh8xxzBetTvoxUUI6tf8rzXEooiOqC+fiqHHyc4Vga48EzVuF5+
 MYtYnFwN2bcx/9G47ZCn2pteHNejqaAqaq+ZFKqCrQt9FiHeQ5XAQ9r8oUZDc0lm0K4m
 isog==
X-Gm-Message-State: AOJu0YxiQZ1EUau4y+PB0JpZf6jiWxCcM3vb6J5OQSweVEM1vbWb2MOc
 3FYGfZBZT7s0Gs+g/TqRT72VGzye3jSj5zIHOAniU5UYnMzswfnD2wMnVfTusaY=
X-Google-Smtp-Source: AGHT+IGLvSJS1CsAz7tLOBBec5fNhI3I8VIaYDe7nUxtT27CQKy0sTZN0mkn9Oo0L6TGIC8taxQ9Rg==
X-Received: by 2002:a05:6a20:9282:b0:19c:61eb:132f with SMTP id
 q2-20020a056a20928200b0019c61eb132fmr2025956pzg.15.1706381402855; 
 Sat, 27 Jan 2024 10:50:02 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 a8-20020a62d408000000b006dbdac1595esm3309019pfh.141.2024.01.27.10.50.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jan 2024 10:50:02 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Date: Sat, 27 Jan 2024 10:50:00 -0800
Message-ID: <006601da5151$a22b2bb0$e6818310$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AdpRUTXsbObYInj9R7O7W5hyfIwmTw==
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zTzeo7zt4NxmLFMj2HNd25k8RYc>
Subject: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
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

Under "Load and store instructions", various mode modifiers are documented.
I notice that BPF_MSH (0xa0) is not documented, but appears to be in use in 
various projects, including Linux, BSD, seccomp, etc. and is even documented
in various books such as
https://www.google.com/books/edition/Programming_Linux_Hacker_Tools_Uncovere
d/yqHVAwAAQBAJ?hl=en&gbpv=1&dq=%22BPF_MSH%22&pg=PA129&printsec=frontcover

Should we document it as deprecated and add it to the set of deprecated
instructions (the legacy conformance group) like BPF_ABS and BPF_IND
already are?

Also, for purposes of the IANA registry of instructions where we list which
opcodes are "(deprecated, implementation-specific)", I currently list all
possible BPF_ABS and BPF_IND opcodes regardless of whether they were
ever used (I didn't check which were used and which might not have been),
so I could just list all possible BPF_MSH opcodes similarly.  But if we know
that some were never used then I don't need to do so, so I guess I should
ask:
do we have a list of which combinations were actually used or should we
continue to just deprecate all combinations?

As an example,
https://github.com/seccomp/libseccomp/blob/main/tools/scmp_bpf_disasm.c#L68
lists 6 variants of BPF_MSH: LD and LDX, for B, H, and W (but not DW).
Other sources like the book page referenced above, and the BSD man page,
list only BPF_LDX | BPF_B | BPF_MSH, which is in Linux sources such as
https://elixir.bootlin.com/linux/v6.8-rc1/source/lib/test_bpf.c#L368

So, should we list the DW variants as deprecated, or never assigned?
Should we list the H, W, and LD variants as deprecated, or never assigned?

What about DW and LDX variants of BPF_IND and BPF_ABS?

Dave


-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

