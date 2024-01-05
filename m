Return-Path: <bpf+bounces-19099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F7F824C91
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2363286336
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8C1FBE;
	Fri,  5 Jan 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="NsTgRqK0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nhWPSRio";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UPQ08KP8"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24531FAD
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 01DF1C05DDE7
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 17:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704418303; bh=w7HdWDU9YrTLw3SSveC8w7yFuhhKEQqngYCxHzggt/4=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NsTgRqK03UxNZFbP4gH92+WIi/4Lxr07PgcMujBrgQH4qtjD/3ECzTrChAC2vsTXl
	 aeodiZvlQ0wbL+43SmmCcAZHSeOKE+E9YocSqlGdO7M+wqhX9oyArpLI64dYv2vCO3
	 1BaGvT/CjafXbSUMKHwZzhiwxFsjypLBPWTeEP2Y=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id C7ED1C151556;
 Thu,  4 Jan 2024 17:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1704418302; bh=w7HdWDU9YrTLw3SSveC8w7yFuhhKEQqngYCxHzggt/4=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=nhWPSRio3NvapcllpF81xtI8wWezHAYv5qUGrTpsEmWY/P8tUBBkvZM9bkLsMVTVo
 FE99NioGQCgjqBrIbCqCGqlRHjO7mOMEAVmzA/BMuK1Vo8Wh54KQwwnCZ7C2715Er8
 TJkw3zV4KGNk6l8NVPfwoRs52ou7nGKWNCOnZ90c=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1412BC151556
 for <bpf@ietfa.amsl.com>; Thu,  4 Jan 2024 17:31:42 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id En9yV0uPDij8 for <bpf@ietfa.amsl.com>;
 Thu,  4 Jan 2024 17:31:36 -0800 (PST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D886FC15108E
 for <bpf@ietf.org>; Thu,  4 Jan 2024 17:31:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28c467446f0so99946a91.0
 for <bpf@ietf.org>; Thu, 04 Jan 2024 17:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1704418296; x=1705023096; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=V2ip3HyFSIgJvnIybn9HMd2m8Il7ZR7wesMKa0O8xLI=;
 b=UPQ08KP8GD5v7UEQYZzwii+Q7Jb8g00yNcZDaH+C8JC4tPKLLsCTqfKIf9/T96QQXL
 yfUKzUjNUiXw1eq/Egg57xJFEhi4CtLDsDwo5gkh78MTJCAoStmfZHq7NuW0S7qgxhWz
 bvxWTlcC9sr8HhkaK0fwIYLqrFEv3uNXV5hitILzPpVW/Ped21pRHDu3YeqgtgrskUfi
 JemykC24V+q+1VbcpCiO+TTofLHUqXD126x6jkZo6zwr5Rhxvjgl5iPKNioNpfS/C90E
 KNtTCGy9knFIsEA0cI91M6LBhtkObZLkSkMBHL4FfaGh3I7CK62D+0LgDtHPfu3dtp9Q
 zC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704418296; x=1705023096;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V2ip3HyFSIgJvnIybn9HMd2m8Il7ZR7wesMKa0O8xLI=;
 b=Tj0HCwhTivNCtTEXbdtrbgvbEunnaj4ceuLKmd6rElBpQZySYiaHrJTlUSm1O1EitZ
 pxTa6RRO4aZoXmX4W6QNw5g8Zr1MT0CcIhYMWpdf2AUAc7fOgV0lGcdAVQYkyOoAbmSS
 qNYZ1qOU/KNlQELG58IUj62X4A358MGCWubxRPuEXUVMm6nD5rRIh6bpBvXazKeU7fVy
 jmb3KD0vjBzP6KXN48FIwE3EJO/uBBNq8p9oOfw0ZbY9BicSN/2Gf7GQoQXEjV8gRKaA
 K7SlyF7dFWRkcAonjE/sAY6hrEILgtFsXTIX2K76wRo1pKmRWKdUzJA/8qIkHgJuypwW
 ySVg==
X-Gm-Message-State: AOJu0Yw4AHVqee3fpb3Qic+JsXibNASo3tg5W2riJqA3LaFgkQJ/1YVA
 Vyz9JyeK81LQiVBUOOEhZHc=
X-Google-Smtp-Source: AGHT+IGm42lGvj7Hd2Dqngvfm8PL1uInOI1xwJUAIoTZm1BPLs08wrOFP5SgaAlTzdeXfgco5N1iIA==
X-Received: by 2002:a17:90b:4a0e:b0:28c:65ee:3c37 with SMTP id
 kk14-20020a17090b4a0e00b0028c65ee3c37mr1703007pjb.9.1704418295780; 
 Thu, 04 Jan 2024 17:31:35 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 r23-20020a17090b051700b0028b6759d8c1sm349996pjz.29.2024.01.04.17.31.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jan 2024 17:31:35 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Aoyang Fang \(SSE, 222010547\)'" <aoyangfang@link.cuhk.edu.cn>,
 <dthaler1968@googlemail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <3A7D0A57-02EF-4ACB-A599-1029CFCA7E74@link.cuhk.edu.cn>
 <015701da3f41$eaab4d10$c001e730$@gmail.com>
 <20654405-C500-4A24-B09E-A28B25DF32AC@link.cuhk.edu.cn>
In-Reply-To: <20654405-C500-4A24-B09E-A28B25DF32AC@link.cuhk.edu.cn>
Date: Thu, 4 Jan 2024 17:31:33 -0800
Message-ID: <076801da3f76$eb0cdaf0$c12690d0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJcMuQj7ImLqPZXOVe7T7DiaRKhUwLxzd5EAg7D4uSvnoJBMA==
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/PsPj3vdjbeDHdiVAwS4VcsQ2j5U>
Subject: Re: [Bpf] [PATCH] update the consistency issue in documentation
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

QW95YW5nIEZhbmcgKFNTRSwgMjIyMDEwNTQ3KSA8YW95YW5nZmFuZ0BsaW5rLmN1aGsuZWR1LmNu
PiB3cm90ZTogCj4gSWYgc28sIHRoZSB2YWx1ZSBvZiBhcml0aG1ldGljIGluc3RydWN0aW9uc+KA
mSBjb2RlIHNob3VsZCBiZSA0IGJpdCwgcmF0aGVyIHRoYW4KPiBCUEZfQUREOiAweDAwLCBCUEZf
U1VCOiAweDEwLCBCUEZfTVVMOiAweDIwLiBPdGhlcndpc2UgdGhlIGNvbnZlbnRpb24gb2YKPiBh
cml0aG1ldGljIGluc3RydWN0aW9uIGlzIG5vdCBjb25zaXN0ZW50IHdpdGggdGhlIGNvbnZlbnRp
b24gb2YganVtcAo+IGluc3RydWN0aW9ucy4KCkdvb2QgcG9pbnQsIHlvdSBhcmUgcmlnaHQgdGhh
dCBzZWN0aW9uIDMuMSAoQXJpdGhtZXRpYyBpbnN0cnVjdGlvbnMpIGFuZCAzLjMgKEp1bXAgaW5z
dHJ1Y3Rpb25zKQphcmUgbm90IGNvbnNpc3RlbnQgd2l0aCBlYWNoIG90aGVyLiAgU2luY2UgJ2Nv
ZGUnIGlzIGRlZmluZWQgaW4gc2VjdGlvbiAzIGFzIGEgNC1iaXQgZmllbGQsCkkgYWdyZWUgdGhh
dCBpdCB3b3VsZCBiZSBtb3JlIGNvbnNpc3RlbnQgdG8gY2hhbmdlIHNlY3Rpb24gMy4xIHJhdGhl
ciB0aGFuIGRlZmluaW5nCjgtYml0IHZhbHVlcyBmb3IgYSA0LWJpdCBmaWVsZC4KCkRhdmUKIAoK
Ci0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2JwZgo=

