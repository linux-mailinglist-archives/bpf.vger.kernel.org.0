Return-Path: <bpf+bounces-20777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E869842E52
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 22:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6140F1C24822
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5871B58;
	Tue, 30 Jan 2024 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xFU59u0E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xFU59u0E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heaHFYnm"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD171B3A
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648502; cv=none; b=E0w9emBrk1pIELRBeYY8H/NOnafJNzX9VGRuDKIDjpfQX3AzCp5JPSpPI3LHNoTpp6G4EvhI820+t+Oosbw8ZR13GjKANumtKkXPCY3umwBJc0mrq5h7+AFMJMaR2DxGsZ37jjSJOvJqkAo/wXPlCKha9at2g6xjUFMKsZCJBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648502; c=relaxed/simple;
	bh=lBWuJxWy1vqe5rcnJt+AyAwpyMa2YfbW4QWgeA8V1uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=UWVX12Oym1AE35AnYtbressn2Ubcf/ES0k1ZsU8YWaf5uWheJ8oVTP0Tb7HpVSG/RsJrdafd/vw4w7FlqvbIFdnykzOkckW8zr6v6PFY55iyYKv647xsknJv4EVNPjhljVgGQ0WfSFTb72kbUY60ls6nDdkkdjsonCBd086btGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=xFU59u0E; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=xFU59u0E; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heaHFYnm reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3189DC151547
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706648500; bh=lBWuJxWy1vqe5rcnJt+AyAwpyMa2YfbW4QWgeA8V1uc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xFU59u0EQxwNFgi/0+PrZG9cZqLDnI5VnB2uYK9xXJ+hklgz8JR2wCAB3qcdPBAvo
	 Gow+gsFUkrE4YzBJj/EtmmcZjrkf2Bo/gVrpsNZ2g3wIVoJvz9k97SqwXqeO7llc6g
	 VLkkYY2b/3PYTiEfGCMPWix2G5Iv9xXFqQyK41+A=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 30 13:01:40 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id ECBDCC14F6ED;
	Tue, 30 Jan 2024 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706648500; bh=lBWuJxWy1vqe5rcnJt+AyAwpyMa2YfbW4QWgeA8V1uc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xFU59u0EQxwNFgi/0+PrZG9cZqLDnI5VnB2uYK9xXJ+hklgz8JR2wCAB3qcdPBAvo
	 Gow+gsFUkrE4YzBJj/EtmmcZjrkf2Bo/gVrpsNZ2g3wIVoJvz9k97SqwXqeO7llc6g
	 VLkkYY2b/3PYTiEfGCMPWix2G5Iv9xXFqQyK41+A=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E6E35C14F6B3
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 13:01:38 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpKdT4lOiec0 for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 13:01:34 -0800 (PST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7DE2CC14F6ED
 for <bpf@ietf.org>; Tue, 30 Jan 2024 13:01:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso134607f8f.0
 for <bpf@ietf.org>; Tue, 30 Jan 2024 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706648492; x=1707253292; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ7J7exrLBJFWUFLbts2Y5W7nlYiKPxLj7+LYCLHJCc=;
 b=heaHFYnm/BujikZ1bHq9NoqSU7xxf8VUsgD6UXzuR86KvbGdKBsfwq6NPukqtYVhjN
 Uj9XeErvhV5QNPNsAkPlbdDoT+1qEmtSdNK6GjXRG+mMlkPSjRkBxAA076uYGovIP7Gg
 wYD9iBwBJ5wfp7w5thdXuyD4TVIKnGXlHmEv0smwl/iOk7chV7+UR7GZXJjiuAXkD/Fj
 Lm4NRl0ASgHFYrY0+r3qO0L7b2HfeW1VLj8eqD7eKB7SBFIrxWObuzsKC85z8VEwPgaJ
 Quw79Ll20aeecUxzvCO2X2pBeVnJMLsGKp5Lk+RGIGE3KKtkVaWfZxeNoZKeVkn/Kd80
 p0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706648492; x=1707253292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQ7J7exrLBJFWUFLbts2Y5W7nlYiKPxLj7+LYCLHJCc=;
 b=RkXKcH3mBFCs4QjtlydO2twnE0ONak3Kuw1xW5f4khtYPZmQntTJG+o/PNWAIAxYGb
 6HyUlhIK7Lh2OGQ/5jOFvq92+CzGOvOrmRI2tr+uQLuMiBbIvDkEzmD17GGmCCS4JNt6
 I+iOO/jGNB2H4A64VLKc14cCbUoccr1BfdJOWyLNUVkJzUY3iJcqgn+MT+0IRSWEGgab
 Pjj/FBoVe+U7IwMH7zIAnvBgcA7tRQFko2S7PV+SbCvv9olMgN3hOGgQNYSebfYHwmoq
 V6I8Yp1/xu3BNWwBPGZqDcs2GsNtSsoHraMPJUHy0XFwCdO66bPYFVNjlpdRiKHIV8Ny
 bxrw==
X-Gm-Message-State: AOJu0YwDzS1A5cI6kXZ05s/oBgeEOu8JjfCgXNyhFr82aHlCHGt/lCpo
 69is/J76V8XD6P18YEik9aNOpDQGOY5qW2Jk1+SeUnrDtB4XdKb/jynM/Z2uOBv6snipYAKOXNU
 53G3x9MgE9CQeYm6RguRmcacGLmbsyBBU
X-Google-Smtp-Source: AGHT+IG+EVQPQ6EN1V/MbW2cpUmaQrp3Z//E40beAt0YY6rW2i+RwXALPdsZ4jyQJ8l8GxzG3SLisIJKWkWw47g9B50=
X-Received: by 2002:adf:fccb:0:b0:338:8892:fbdd with SMTP id
 f11-20020adffccb000000b003388892fbddmr2676836wrs.4.1706648492349; Tue, 30 Jan
 2024 13:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com>
 <87wmrqiotx.fsf@oracle.com>
In-Reply-To: <87wmrqiotx.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Jan 2024 13:01:20 -0800
Message-ID: <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
 bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/CDQjTO8R8gdPdfeKVnoxWco8_Lw>
Subject: Re: [Bpf] ISA: BPF_CALL | BPF_X
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

T24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMTE6NDnigK9BTSBKb3NlIEUuIE1hcmNoZXNpCjxqb3Nl
Lm1hcmNoZXNpQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4KPiA+IGNsYW5nIGdlbmVyYXRlcyBCUEYg
Y29kZSB3aXRoIG9wY29kZSAweDhkIChCUEZfQ0FMTCB8IEJQRl9YLCB3aGljaCBpdAo+ID4gY2Fs
bHMgImNhbGx4IiksIHdoZW4gY29tcGlsaW5nIHdpdGggLU8wIG9yIC1PMS4gIE9mIGNvdXJzZSAt
TzIgaXMKPiA+IHJlY29tbWVuZGVkLCBidXQgaWYgYW55b25lIGxhdGVyIGRlZmluZXMgb3Bjb2Rl
IDB4OGQgZm9yIGFueXRoaW5nCj4gPiBvdGhlciB0aGFuIHdoYXQgY2xhbmcgbWVhbnMgYnkgaXQs
IGl0IGNvdWxkIGNhdXNlIHByb2JsZW1zLgo+Cj4gR0NDIGFsc28gZ2VuZXJhdGVzIEJQRl9DQUxM
fEJQRl9YIGFsc28gbmFtZWQgY2FsbHgsIGJ1dCBvbmx5IGlmIHRoZQo+IGV4cGVyaW1lbnRhbCAt
bXhicGYgb3B0aW9uIGlzIHBhc3NlZCB0byB0aGUgY29tcGlsZXIuCj4KPiBJIHJlY29tbWVuZCB0
aGlzIHBhcnRpY3VsYXIgZW5jb2RpbmcgdG8gYmUgc3BlY2lmaWNhbGx5IHJlc2VydmVkIGZvciBh
Cj4gZnV0dXJlIGBjYWxsIFJFRycgZm9yIHdoZW4vaWYgYSB0aW1lIGNvbWVzIHdoZW4gdGhlIEJQ
RiB2ZXJpZmllcgo+IHN1cHBvcnRzIHNvbWUgZm9ybSBvZiBpbmRpcmVjdCBjYWxscy4KCisxLgpT
YW1lIHRoaW5raW5nIGZyb20gbGx2bSBwb3YuCkNBTEx8WCBpcyB3aGF0IHdlIHdpbGwgdXNlIHdo
ZW4gdGhlIGtlcm5lbCBzdXBwb3J0cyBpbmRpcmVjdCBjYWxscy4KSSB0aGluayBpdCBtZWFucyB3
ZSBuZWVkIHRvIGFkZCBhICdyZXNlcnZlZCcgY2F0ZWdvcnkgdG8gdGhlIHNwZWMuCgotLSAKQnBm
IG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9icGYK

