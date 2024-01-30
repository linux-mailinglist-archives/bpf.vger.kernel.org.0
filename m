Return-Path: <bpf+bounces-20754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE0842AE0
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118181F25C96
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A5129A86;
	Tue, 30 Jan 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="oFBxiOUv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="SuMoV5+q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L3XdLvdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D3129A95
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635666; cv=none; b=iKaHwmRtB3dw6OEJuuSjbNPqsPqEyv9w8sl4l6JKKaWWevPanooeGhKvmsdABlD7BYzCKQiwl6ddOm9VHG7EwQsKoLr/qJN4Gk0YS0xF5dwJQCh/wOoDsZYp1tR6Si9aMhKNW6vuTY+eaz+teWZ3ksPEF7iZUfQVv3nVBQ9TDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635666; c=relaxed/simple;
	bh=WmgyanOoptnwVg4STfbwED+SrsqGlTGXpJf8EW7xfMc=;
	h=To:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=Ga7twnQ9+u5zuNTlGxybHMiHNhcn+4y2RyyTgV61OGkyUIjq5ZZa3p+1dMPwQW1tWICHY0va4hJcEGBQOjr+tMKj7WpiusFlAuxMJj9UxtfZaG+lsmT7bjl79sxzK/UjZMD1D9Ljgo+uuHjhYsjVZ9ZuA59mC9pKW8i5IsLD9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=oFBxiOUv; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=SuMoV5+q reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=L3XdLvdq reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EB2A6C1516E9
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 09:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706635663; bh=WmgyanOoptnwVg4STfbwED+SrsqGlTGXpJf8EW7xfMc=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=oFBxiOUv+Da8EsHAwIRjyThyWzSkrZ41OMBM9ecGVquwKlRHvlGhhDippyWLdbXue
	 Smkk6R4TXQv7tWrxvWJjID9E1WQgcsLMKy6SOZrLj+b04xOUpFXu5ZAt4rpOT0zQbr
	 KBl+eMguQFa/l2kE1CKiZOUIsabXcqJ/lDpMMp2Q=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BE30DC14CEFD;
 Tue, 30 Jan 2024 09:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706635663; bh=WmgyanOoptnwVg4STfbwED+SrsqGlTGXpJf8EW7xfMc=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=SuMoV5+qGu4vVMjQvLmTV3GQf+b2MhDmeud++HP/LGdDuZ/Cq7m5O231DacfcgDpC
 aV7jXTjibzmTfHsAnOzFxbf90z6l8SFzSzph5a066GzwA6PdCKIy6J2a/bFAit4ksH
 ZtTClKq9mqMIYzLaeB45tjjSkR3loyt1NoGkIx5w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 33916C14CEFD
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 09:27:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.356
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4lhsul4BfM6I for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 09:27:39 -0800 (PST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9A0D0C14F5E0
 for <bpf@ietf.org>; Tue, 30 Jan 2024 09:27:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso2014618a12.2
 for <bpf@ietf.org>; Tue, 30 Jan 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706635659; x=1707240459; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9F7EALf2gYWxPbKNSGKMU2hL0Yhx5L3Q6w99eWQcjro=;
 b=L3XdLvdqTtOKuW0rHXYoCuDKivUzUTpXnFDAFS0OSputIYoMsbQeCH8c3tSF78mvDq
 GlWU03EhcFfKeEQ7Q+x2yL5qjmZcz+acGK7fCEC8IjNkA7/Olnv1L7ZP2pTfJV2f/vQ7
 1NJmvvT1I5S2HjRKGV1NmSUnC1WUp5V1sac1rCb069V/zWeD8PPVjrE0TcxYZM4ouy3D
 z2Lv0PHj4mtXVLhnRQmuJ5Nn+aqgv2+qpFizz3nNADrAEYGT+PtexGiw3lVGfdeqXv0i
 ZcUe4phiuU6Wn+PDDD+tCMzQpDkUZNIUEMSY14U8jU3wDJalEgDIjhUDu/S+y4Zy6u5c
 fQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706635659; x=1707240459;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9F7EALf2gYWxPbKNSGKMU2hL0Yhx5L3Q6w99eWQcjro=;
 b=ok0PW5HqNimxUOW3AmqJaQQqCcXWF9CekyViJrk4YD/nmtKY35tEmYbLrq+Y4oJYRn
 zRlK8+pGkKVg2KyOzhFALG/CCFErdepzs2YOOpS44DbX2xbrLxxVNWMo7yEm/13be58d
 XWANRqmK6IeyN9fGyXyG3sTktyFDXgHxX3Rcrs2/RigRZWO9fwvBE3ZKerPRN+yo9DtV
 foWPunBxThjbUdPsnX4Ntwz+Yy2O2MTdckHURmNgZ6Mj2xvCBGoZ6uw8PcldQSbYCDtM
 IwQs2tgVISKBXvS2URL3isbhGbFDEsGEt8dRGSTNVA89EWNsKZtjuWKdZV5YwOF8RBHD
 b0rw==
X-Gm-Message-State: AOJu0Yxb61KiqUCU/XIR9gMTPyZ64/P/av++mgoEI4M2BasDLxMz+aZj
 GisP0q86bOZoSK/n2unTYtfU9/sGE+IScHZutiBMI9oX76WuvLbq/lHsUngciXU=
X-Google-Smtp-Source: AGHT+IG4EGrzvcMtmwAXP1ze5GvGEX5ZCEel40w6VH2UXLOSslITdPqgztEQyjpSKZWn2yDxkoU9GQ==
X-Received: by 2002:a05:6a20:d488:b0:19c:9d37:ec59 with SMTP id
 im8-20020a056a20d48800b0019c9d37ec59mr5955721pzb.28.1706635658825; 
 Tue, 30 Jan 2024 09:27:38 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 m1-20020a62f201000000b006ddc03c425bsm8004664pfh.180.2024.01.30.09.27.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 09:27:38 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'bpf'" <bpf@vger.kernel.org>,
	<bpf@ietf.org>
Date: Tue, 30 Jan 2024 09:27:36 -0800
Message-ID: <076001da53a1$9ebfa210$dc3ee630$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AdpTn/i/+Jdzpl/jQ0iLyOHFFXfaaQ==
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk>
Subject: [Bpf] ISA: BPF_CALL | BPF_X
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

clang generates BPF code with opcode 0x8d (BPF_CALL | BPF_X, which it calls
"callx"),
when compiling with -O0 or -O1.  Of course -O2 is recommended, but if anyone
later
defines opcode 0x8d for anything other than what clang means by it, it could
cause
problems.

On the BPF_MSH thread at
https://mailarchive.ietf.org/arch/msg/bpf/ogmS9qFhdBCxC4VrOWL7nzjSiXU/
Alexei wrote regarding BPF_ABS and BPF_IND:
> DW never existed in classic bpf, so abs/ind never had DW flavor.
> If some assembler/compiler decided to "support" them it's on them.
> The standard must not list such things as deprecated. They never existed.

Technically BPF_CALL | BPF_X never existed either, so can be omitted from
the IANA registry.  But given the widespread deployment of clang's
use, and the WG charter statement:
> The BPF working group is initially tasked with documenting the existing
> state of the BPF ecosystem
I could see a potential argument to list it as reserved or something.

Today, the document doesn't reserve it, so it's open for future use for any
purpose.  I just wanted to verify that the WG is ok with not listing it
in the IANA registry, given the above information.

Dave


-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

