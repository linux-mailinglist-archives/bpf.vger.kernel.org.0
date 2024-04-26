Return-Path: <bpf+bounces-27974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8D8B402B
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C17285808
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50F1BC31;
	Fri, 26 Apr 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aQrPiYu8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aQrPiYu8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9W5Wv+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1818026
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160224; cv=none; b=ZYQPPp+qMZZwaPEBQMWUckUGkz2m/T6cSNYhtjYOP0HStSxYVoXsdtQabC/eL22wJxkCgORDgldlfAJTYEyiG0bkOlBLi0nq2pJx1pbXIqPKGY+ZR1NtWq67zhYE+GZWSSKIVq05DaOnjC1fbofu/LrMjB8xHNbDgIrkT0pYlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160224; c=relaxed/simple;
	bh=KFVy2Z7LxFXBsZN4eHT7MTjcO7ciRSlEnZ+F+X+D9qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=jKBT08A8VKEjBq4lon96PqFhi8HyeH69U1pwh/EoWBKsgmHEa8cEjSU+uPzIIApjX1Cqo/6EwEJ62EFlmvedUxwmPJHEWAxTbNCuBW5SD/GsDSuGP+dECnvaz+glEsQ+VK700pGRjGa6P85nGxDjBsP2dAULHlcGvMLM1cpe5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aQrPiYu8; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aQrPiYu8; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9W5Wv+9 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5044CC151993
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714160222; bh=KFVy2Z7LxFXBsZN4eHT7MTjcO7ciRSlEnZ+F+X+D9qA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=aQrPiYu8X31Dzm1uExNF0wPu42EEZJKMkgICemHIcnHJzekzZMGt0A2PIIuwhPqyQ
	 FRDogoOhaMK18EHYcoDKg+MZsXoxYNGGCO2+B/ceb/48KEHjk3rs3Vod92D7ggDXx6
	 wif6mLrpeSRt6vsSPKzORb/UJ20w9mJvWYtr8ICw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Apr 26 12:37:02 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2C4DAC14F61E;
	Fri, 26 Apr 2024 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714160222; bh=KFVy2Z7LxFXBsZN4eHT7MTjcO7ciRSlEnZ+F+X+D9qA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=aQrPiYu8X31Dzm1uExNF0wPu42EEZJKMkgICemHIcnHJzekzZMGt0A2PIIuwhPqyQ
	 FRDogoOhaMK18EHYcoDKg+MZsXoxYNGGCO2+B/ceb/48KEHjk3rs3Vod92D7ggDXx6
	 wif6mLrpeSRt6vsSPKzORb/UJ20w9mJvWYtr8ICw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B601FC14F61E
 for <bpf@ietfa.amsl.com>; Fri, 26 Apr 2024 12:37:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id roFBADvK0N86 for <bpf@ietfa.amsl.com>;
 Fri, 26 Apr 2024 12:36:59 -0700 (PDT)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CC30FC14F5F4
 for <bpf@ietf.org>; Fri, 26 Apr 2024 12:36:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-346b146199eso1887444f8f.0
 for <bpf@ietf.org>; Fri, 26 Apr 2024 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714160218; x=1714765018; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33uzk/12JSTqzHrlDliFHquEnnPOJaATS1bFfJZ8ERs=;
 b=A9W5Wv+9YbtAIxueFEKFCqknyDoC+b/FJDQuhlGYu06vGrXntexpNOWUVxP5o/IjAM
 RgheT+yhiZ9sH0anEapftiRQuIbmNj17XLIUU0Bj0PeKZwOdX2YORJMzLPvJCURlYe7X
 XVRhwnInDPJ9uRE0ie9d8BW3XsL0P5Y4DQTeWixUFxMPQtjWq+Dv6SMducFy29ownAW4
 8pJJ7ivr97g+kYYxjlfm/wYp+px8caWaV7yRv72Zzm6zFenxIvUG0PPTLECJou02nWd+
 4DNitM/jnqGM/NwfTnZ0eS3y3QzZfWDczvucnc4ACyRdn06Um8qS2tsimuU3f6KvFkJO
 28rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160218; x=1714765018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33uzk/12JSTqzHrlDliFHquEnnPOJaATS1bFfJZ8ERs=;
 b=pLs2O8DUVnCXzGRGFI2wgx3VA3Pzy3DdVRtZl1Jr/5WaYymX3K2D8KAX8yoUNO8vfY
 1ZdMhCTC+ZfwbpepHjH00UItGg36JXEL0XhgnjNkFiiXYSKXI6FscVgqbfUzqOp8palj
 at90V3ypksexc1i3QWPZmZQtszAUke+s9fYtpvWlUnHE/vluTk5XaOC6IBalPeN0CpiD
 Fym4rQB6EEpFNO7GO0U6PSuDu8373dLJ0zTdfN3BTDsehhc9YQZLiVAhFxD9rhJHRoAC
 CPwpPw2NF2EaSiax3vGeziphVroZ6HUO3LavEaHA5jMRPFKhriMkEGppGcMhOkJWIa54
 YQQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLzTCbre+Jti3rXYoFBh4h2Ica/kYkXrQ5SHnP8RQiBh9QevlEBbNXyH75PCqZiBImwB5tnIDCAzGsFng=
X-Gm-Message-State: AOJu0Yz0i2A0Cfhp9r2KoOA0+ZYBMAWEZFqDpzoGArOWCVbWX1aQEkM3
 knXgocXpd1TWXI/F5AM9avU9yvTzqIuKdoFY32V6RSL06MSR3af0hP1/SsamNqIwVDbzIb7fFhv
 lBLXA6XFGnLuE0bb1zGqjP8AjtQU=
X-Google-Smtp-Source: AGHT+IGiqL7P/qGkTA/qqCu/Td3fnc1Zje66+F762HGNfdF0d/b9o+P3CHRFiot10nMPgs4M5H/jmV+CLLRR+rYoLSE=
X-Received: by 2002:a5d:630d:0:b0:34c:4061:5579 with SMTP id
 i13-20020a5d630d000000b0034c40615579mr2250631wru.45.1714160217843; Fri, 26
 Apr 2024 12:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426171103.3496-1-dthaler1968@gmail.com>
 <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
 <0dae01da9810$3a657fc0$af307f40$@gmail.com>
In-Reply-To: <0dae01da9810$3a657fc0$af307f40$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 12:36:46 -0700
Message-ID: <CAADnVQK7W7gQVhB+MqcoDd1xrNqCPqOFrwVWVAi1Zb9t5iyuLw@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/rNOYL_vrsxSZj5T7KSQylGBuOpw>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify PC use in instruction-set.rst
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

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgMTI6MzDigK9QTSA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFp
bC5jb20+IHdyb3RlOgo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gRnJvbTog
QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPgo+ID4gU2Vu
dDogRnJpZGF5LCBBcHJpbCAyNiwgMjAyNCAxMjoyMiBQTQo+ID4gVG86IERhdmUgVGhhbGVyIDxk
dGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbT4KPiA+IENjOiBicGYgPGJwZkB2Z2VyLmtlcm5lbC5v
cmc+OyBicGZAaWV0Zi5vcmc7IERhdmUgVGhhbGVyCj4gPiA8ZHRoYWxlcjE5NjhAZ21haWwuY29t
Pgo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYtbmV4dF0gYnBmLCBkb2NzOiBDbGFyaWZ5IFBD
IHVzZSBpbiBpbnN0cnVjdGlvbi1zZXQucnN0Cj4gPgo+ID4gT24gRnJpLCBBcHIgMjYsIDIwMjQg
YXQgMTA6MTHigK9BTSBEYXZlIFRoYWxlciA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+Cj4g
PiB3cm90ZToKPiA+ID4KPiA+ID4gVGhpcyBwYXRjaCBlbGFib3JhdGVzIG9uIHRoZSB1c2Ugb2Yg
UEMgYnkgZXhwYW5kaW5nIHRoZSBQQyBhY3JvbnltLAo+ID4gPiBleHBsYWluaW5nIHRoZSB1bml0
cywgYW5kIHRoZSByZWxhdGl2ZSBwb3NpdGlvbiB0byB3aGljaCB0aGUgb2Zmc2V0Cj4gPiA+IGFw
cGxpZXMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2
OEBnb29nbGVtYWlsLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBEb2N1bWVudGF0aW9uL2JwZi9zdGFu
ZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCB8IDUgKysrKysKPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiA+IGIvRG9j
dW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QKPiA+ID4g
aW5kZXggYjQ0YmRhY2QwLi41NTkyNjIwY2YgMTAwNjQ0Cj4gPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiA+
IEBAIC00NjksNiArNDY5LDExIEBAIEpTTFQgICAgICAweGMgICAgYW55ICAgICAgUEMgKz0gb2Zm
c2V0IGlmIGRzdCA8IHNyYwo+ID4gc2lnbmVkCj4gPiA+ICBKU0xFICAgICAgMHhkICAgIGFueSAg
ICAgIFBDICs9IG9mZnNldCBpZiBkc3QgPD0gc3JjICAgICAgICAgc2lnbmVkCj4gPiA+ICA9PT09
PT09PSAgPT09PT0gID09PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+
ID4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
PiA+ID4KPiA+ID4gK3doZXJlICdQQycgZGVub3RlcyB0aGUgcHJvZ3JhbSBjb3VudGVyLCBhbmQg
dGhlIG9mZnNldCB0byBpbmNyZW1lbnQKPiA+ID4gK2J5IGlzIGluIHVuaXRzIG9mIDY0LWJpdCBp
bnN0cnVjdGlvbnMgcmVsYXRpdmUgdG8gdGhlIGluc3RydWN0aW9uCj4gPiA+ICtmb2xsb3dpbmcg
dGhlIGp1bXAgaW5zdHJ1Y3Rpb24uICBUaHVzICdQQyArPSAxJyByZXN1bHRzIGluIHRoZSBuZXh0
Cj4gPiA+ICtpbnN0cnVjdGlvbiB0byBleGVjdXRlIGJlaW5nIHR3byA2NC1iaXQgaW5zdHJ1Y3Rp
b25zIGxhdGVyLgo+ID4KPiA+IFRoZSBsYXN0IHBhcnQgaXMgY29uZnVzaW5nLgo+ID4gInR3byA2
NC1iaXQgaW5zdHJ1Y3Rpb25zIGxhdGVyIgo+ID4gSSdtIHN0cnVnZ2xpbmcgdG8gdW5kZXJzdGFu
ZCB0aGF0Lgo+ID4gTWF5YmUgc2F5IHRoYXQgJ1BDICs9IDEnIHNraXBzIGV4ZWN1dGlvbiBvZiB0
aGUgbmV4dCBpbnNuPwo+Cj4gSWYgdGhlIG5leHQgaW5zdHJ1Y3Rpb24gaXMgYSA2NC1iaXQgaW1t
ZWRpYXRlIGluc3RydWN0aW9uCj4gdGhhdCBzcGFucyAxMjggYml0cywgZG8geW91IG5lZWQgUEMg
Kz0gMSBvciBQQyArPSAyIHRvIHNraXAgaXQ/Cj4gSSBhc3N1bWVkIHlvdSdkIG5lZWQgUEMgKz0g
MiwgaW4gd2hpY2ggY2FzZSAiUEMgKz0gMSIgd291bGQKPiBub3Qgc2tpcCBleGVjdXRpb24gb2Yg
InRoZSBuZXh0IGluc3RydWN0aW9uIiBidXQgd291bGQgdHJ5IHRvIGp1bXAKPiBpbnRvIG1pZCBp
bnN0cnVjdGlvbiwgYW5kIGZhaWwgdmVyaWZpY2F0aW9uLgoKQ29ycmVjdC4KCj4gSGVuY2UgbXkg
YXR0ZW1wdCBhdCAiNjQtYml0IGluc3RydWN0aW9uIiB3b3JkaW5nLgo+Cj4gQWx0ZXJuYXRlIHdv
cmRpbmcgc3VnZ2VzdGlvbnMgd2VsY29tZS4KClRoaXMgImp1bXAgaW4gdGhlIG1pZGRsZSIgaXNz
dWUgaXMgbm90IG9idmlvdXMgYXQgYWxsIGZyb20KInR3byA2NC1iaXQgaW5zdHJ1Y3Rpb25zIiBw
YXJ0LgpTYXkgdGhhdCBQQyArPTEgc2tpcHMgZXhlY3V0aW9uIG9mIHRoZSBuZXh0IGluc24gaWYg
aXQncyBhIDY0LWJpdCBpbnNuCmFuZCBmYWlscyB2ZXJpZmljYXRpb24gaWYgdGhlIG5leHQgaW5z
biBpcyAxMjgtYml0LgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8v
d3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

