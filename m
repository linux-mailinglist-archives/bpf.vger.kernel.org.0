Return-Path: <bpf+bounces-29964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C38C8AC2
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A45B221D7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CCF13DBBC;
	Fri, 17 May 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="bZWIi4y+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YnvUmkY8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h0kfOKvp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16413DBAC
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966214; cv=none; b=twBKjxnHxxnYZHgrMfPvb9HxwRdom45MkJELgfv8WlraPoCwiGRQgeyl7ulTV8dnw2FdfCFjM6ZFKoJubauPUGmZPhJjjlupUrjQPjzC1Fbun1mzR61jbrXl4fQatM9JcGWoLVoAbRKMXQay23zNDXQ5usvcUr4f7y+2qKH6OCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966214; c=relaxed/simple;
	bh=NhDDO7dXiqQJB+jJAel1zgsMjyNqf1hpJEh6ag2VeO0=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=eBLMlc1L1qH/9xIs1I4SV+ciIwNK+qGQkMspMNQp3ZSNGCHEIKDEmH+yisbVG8LgdiNXjVNKOJauGUNdF4INu6dTKQ3LNlAgfJclLX/dw4n+MxK4t41dknoFu6NkDuW8tAV8Utv1hP+3VLAtQ1tjX9jGw9+T9Fg8SJqJPo/T0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=bZWIi4y+; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=YnvUmkY8 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=h0kfOKvp reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 84346C169407
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1715966212; bh=NhDDO7dXiqQJB+jJAel1zgsMjyNqf1hpJEh6ag2VeO0=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bZWIi4y+69qUbosuqDQG8z7PXTL733YIP14UoEPYbYLeQBYChkny8EyIB+z9CArpN
	 3hG9hwGW+KgHIIIBHxztFV/G5SOtVnRV2wDNBeeuSZ9dkt6sdVvWEKaIaj0l1fb2NA
	 NKtYRnXVlvsTe1iQr8KTDILzYrru277+QOnFkrEc=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id C9CBEC1D5C76
 for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1715966211; bh=NhDDO7dXiqQJB+jJAel1zgsMjyNqf1hpJEh6ag2VeO0=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=YnvUmkY8OH7bZHVtG/tVcycyNswXqUK7dXkCGHzHTVu1LhjJGKszIsqWLIbUPgY+O
 44YPsFDHaJowaBiNu5UGsRg+5y14An9lVSOhxeAB3kiBqW4NAzyTNJ7Njoe/h1DJPR
 w4umJ8+cPjcX5hvtf6aTYaOpaiI17ZoqtJ7N/B+Y=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 35709C151094
 for <bpf@ietfa.amsl.com>; Fri, 17 May 2024 10:16:40 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NkTFR4a9bOOq for <bpf@ietfa.amsl.com>;
 Fri, 17 May 2024 10:16:36 -0700 (PDT)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 64200C151993
 for <bpf@ietf.org>; Fri, 17 May 2024 10:16:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ed96772f92so15513615ad.0
 for <bpf@ietf.org>; Fri, 17 May 2024 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1715966195; x=1716570995;
 darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BnExOqV+7uRXHFu/y7RSrNtAFBzF2jJxaME1kcwkiDw=;
 b=h0kfOKvp+duPClAluw+LS1+QnzYc5KoFsHEggTqAZP/8qjdxrgSc5g46LEAgBLDmGW
 I6ppnevBOpa7F9wnfWA7sL1t70CI0mksgHuOAjcimMVuNTYDpuz55vlijyUx1XNwYzzy
 3tE2e2IYS6pPYoc/1ITgflVfRSrXDyMK17brd0mCtGsU6BmxQ3UdUwlCM6kVFCCiSqvP
 iPlh61f3pT+dYHY/oRwdI405cCpoamI66spML9gcJzhwrFGyIa1Csm4Rw/zO55Z6Fve4
 P6ts84YZhuZia8LRuufAGWDlUZ8SqoNc83F9HTPdnCmiaR9mh5Fn5bjz0u84fMC4lFzf
 U/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715966195; x=1716570995;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BnExOqV+7uRXHFu/y7RSrNtAFBzF2jJxaME1kcwkiDw=;
 b=J+EvKGkYj6iYcjaDOlsKz2W3KlLS8RelHZgEhn65vakcudttAros5Rnm+XbxIM/eeV
 m5ryhrtzzSvKYmNrr0G1bQ/7+mzGNBGAt2rJQBn9y2a4gVdqrz31awxSX4KiSrNbaGb0
 7+nHricXWhq10U3ELuu9FexmlPcVTs8sTw8J/QtIz/u7S/bIoFJVBiFSatueDHiH/9lL
 +2BRPqPOO2Y8mHD+qP3VGWAluGYMOmDXHYdmDy857HEFB9TqtCHwYUUJRx4oigJcJIN+
 wo8/VFkPnoc/wNo0S32hbtK6EoKkBm6RuwTgGyv9LE5HDr1EXDIbDkPB85QrPaf7VEUz
 AxfQ==
X-Gm-Message-State: AOJu0YzTdiEDoufH4pyQJn/iolTAMsA61JeNzCY7xYuDSYsCc/1AP7Tn
 7SQY8y6byyps7XOxuV5Os6I8b2b+B1IkEJPmQGrsFjLIUVTYfBJFXXyJRg==
X-Google-Smtp-Source: AGHT+IGpjVtNLxkEf8zt1iFoHwywFhxbIYluUtfkvFJ0mJcM41xIhJ56sgOXLjB4ZF9DoAbBCT3Mpw==
X-Received: by 2002:a17:903:2404:b0:1e2:c8f9:4cd7 with SMTP id
 d9443c01a7336-1ef44059612mr184043395ad.64.1715966195176;
 Fri, 17 May 2024 10:16:35 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31420sm159465345ad.172.2024.05.17.10.16.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 May 2024 10:16:34 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Dave Thaler'" <dthaler1968@googlemail.com>,
	<bpf@vger.kernel.org>
References: <20240517165855.4688-1-dthaler1968@gmail.com>
In-Reply-To: <20240517165855.4688-1-dthaler1968@gmail.com>
Date: Fri, 17 May 2024 10:16:32 -0700
Message-ID: <05d601daa87d$f7a3daa0$e6eb8fe0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQMNxtSz5Xxdo4l4z3k03OfsZBHpa681bcTw
Message-ID-Hash: JFKLYMP7RLZWFPSEDFF4MPEM3EWO5P2U
X-Message-ID-Hash: JFKLYMP7RLZWFPSEDFF4MPEM3EWO5P2U
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Use_RFC_2119_l?=
 =?utf-8?q?anguage_for_ISA_requirements?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/WZbjxWl61Va5uWnpG-E7xeop5aY>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

Wy4uLl0NCj4gIFBsYXRmb3JtcyB0aGF0IHN1cHBvcnQgdGhlIEJQRiBUeXBlIEZvcm1hdCAoQlRG
KSBzdXBwb3J0IGlkZW50aWZ5aW5nICBhDQpoZWxwZXINCj4gZnVuY3Rpb24gYnkgYSBCVEYgSUQg
ZW5jb2RlZCBpbiB0aGUgJ2ltbScgZmllbGQsIHdoZXJlIHRoZSBCVEYgSUQNCi1pZGVudGlmaWVz
IHRoZQ0KPiBoZWxwZXIgbmFtZSBhbmQgdHlwZS4NCj4gK2lkZW50aWZpZXMgdGhlIGhlbHBlciBu
YW1lIGFuZCB0eXBlLiAgRnVydGhlciBkb2N1bWVudGF0aW9uIG9mIEJURiBpcw0KPiArb3V0c2lk
ZSB0aGUgc2NvcGUgb2YgdGhpcyBkb2N1bWVudCBhbmQgaXMgbGVmdCBmb3IgZnV0dXJlIHdvcmsu
DQoNClBlcmhhcHMgd2Ugc2hvdWxkIGluZm9ybWF0aXZlbHkgcmVmZXJlbmNlDQpodHRwczovL3d3
dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9icGYvYnRmLmh0bWwgZm9yIG5vdz8NCg0KRGF2
ZQ0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

