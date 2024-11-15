Return-Path: <bpf+bounces-44921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164449CD5CB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 04:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5796AB2360D
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 03:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CD033CFC;
	Fri, 15 Nov 2024 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="B3Xu8zU2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="B3Xu8zU2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6fu8IKS"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB5139CFA
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640693; cv=none; b=VGZNFzuvBekW4VdSxldyCqLH5fjvn+Q/Azikujjht/Aw8K9cOKvUCGkoJTAKv4f9IZRqYjAIST+6xz5t8jiI5aZn8ufIljs+QHADpl9nQX5AI3ZZ9xvQTPV1ighZFqQdMMiVG+TBdHaMNGGrBZN+8bYEj6jOfUev+mPwFlCaJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640693; c=relaxed/simple;
	bh=DBpR/8S2taz3NUt6kFdFeIoIjqIGhPSbpdykUkMpVzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=A67ydJSyh+xUa6tg2mwv//jezOwSl4Rxqzx7Ta//03ShpizKzh+VmiYMm3pC1mpLrOtMqHxLZk0/XKCFr0j+fp6ZYP8xDiHm9p45J95I20N0G4+GdwwrZVL5EZY7Kd1AYhDf8xKNMb8K9xiNHo/g8mrPldbkPed5CDhShog1xRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=B3Xu8zU2; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=B3Xu8zU2; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6fu8IKS reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6A2E3C17C8B3
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 19:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731640685; bh=DBpR/8S2taz3NUt6kFdFeIoIjqIGhPSbpdykUkMpVzY=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=B3Xu8zU2LPgwYwQxuRA+EjJTPBBINN6t4HUEgMBh1K5U0y1P6LoVxnKcYlqxgifjB
	 XvmXPnJ7u1M+m2C4bYMmXTE2GwU+22k2FI+Ak1hTXBQMHG6QKqnlCcJabVqDtwYaH8
	 Wxo0SyazMxVR66jdnVHqkmrJZgj/QjzwQ8Iw8hok=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Thu Nov 14 19:18:05 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 38C98C16941E
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 19:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731640685; bh=DBpR/8S2taz3NUt6kFdFeIoIjqIGhPSbpdykUkMpVzY=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=B3Xu8zU2LPgwYwQxuRA+EjJTPBBINN6t4HUEgMBh1K5U0y1P6LoVxnKcYlqxgifjB
	 XvmXPnJ7u1M+m2C4bYMmXTE2GwU+22k2FI+Ak1hTXBQMHG6QKqnlCcJabVqDtwYaH8
	 Wxo0SyazMxVR66jdnVHqkmrJZgj/QjzwQ8Iw8hok=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 318CEC14CEED
	for <bpf@ietfa.amsl.com>; Thu, 14 Nov 2024 19:17:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqnvWpQu4rfb for <bpf@ietfa.amsl.com>;
	Thu, 14 Nov 2024 19:17:50 -0800 (PST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 24AB7C14F6FA
	for <bpf@ietf.org>; Thu, 14 Nov 2024 19:17:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43193678216so11763825e9.0
        for <bpf@ietf.org>; Thu, 14 Nov 2024 19:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731640668; x=1732245468; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFvAs8uN23uHm61FySfxQfnGVf/qFB+acZJKDr5ZJcM=;
        b=Y6fu8IKSF7mFl9VcfM1VZXf9FCj1nv5Tu7TqNWCKpUISlv7sDpTYfCrFxej/ggtzHE
         HIjmucwWXZuV3l6sZgPFrPZKmpIJxLWoleF9VU/XC7ixOGKvxZb6x/BAppVFWK9inCjE
         JWVcGujTIKzHx+GGvyA8o6f3sPyOcCppTaagmDSzeHeA598XTJ5FhdM5oUlTAcgPl384
         XFTwM+zatfhRt8MhRCvENqboXLStWd/IGoFepb9hvi9iWY6XXM5ua3bmOVGMH4SstGMb
         FKOei4Hd9oHUiHL+OdDemIl4a1rIqAt+9exc+SRIphF9ygN04b1y1zHDbt7hZjIIkZw8
         vcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731640668; x=1732245468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFvAs8uN23uHm61FySfxQfnGVf/qFB+acZJKDr5ZJcM=;
        b=srJipmHzYc3kq3ULJlcNV+bTKU4wUxw9aB9M05/vtXqgU2tFOiPRPP3g8he0ALv8iD
         PssRdyEQJjtpkCoD8Xn9ElOWLaydZvwwg8b0bH52S9Cdy7XbWZkCtOXbJ/fdUx09jrrl
         PpUpIYuzrDpz7QhKvllOtPJSkHetZrlAvTKQyHddhUldq8Wald745Ts0E/P8GREwjX9s
         UZz9mLeURrkUOJYM0AdGYD0A0Kb8N63NBor+DjPc9GyPF+UlCqpGunKYavfQmYrUcIg4
         Rt6db16el6Q1obY00PXJvesOzS/kUm3NRWVimfXAGuHLn+OTTPHKnPCXa3cq/YcUkauU
         NGrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUANDZ2wsHXzPjcKZkO13Riw5NG2PXq9YZPEup2x0TGdSAOASV2p8PyISeqMW8sjXblD7k=@ietf.org
X-Gm-Message-State: AOJu0YyMVKE+Ke/EaUmjHVng5llv7zF4tmm0VGw7OhjdXGeBOQBed9gC
	ki+9zaWbadv+6fZq3OGeuxeLQjnJUcwjHqSqgxhdXibRl6KSbFC75CgLi4e6iauHrwNTxePqguF
	WeZw8xh0BqmZJjl3HFEqliWSLQz4=
X-Google-Smtp-Source: 
 AGHT+IEUBraF53kORdvzfKw/uGdn43ON0vQTpHFm+/f0NjvWsN64gNE0je1uc3i1cfj8jED+i79Bvi6UnC8ybKOUbDM=
X-Received: by 2002:a05:6000:1543:b0:382:228b:4c34 with SMTP id
 ffacd0b85a97d-382258f0863mr650512f8f.2.1731640667467; Thu, 14 Nov 2024
 19:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12b6a2f7-a677-449d-b4f3-e2c29046229a@kernel.org>
In-Reply-To: <12b6a2f7-a677-449d-b4f3-e2c29046229a@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Nov 2024 19:17:36 -0800
Message-ID: 
 <CAADnVQK+zZDHZhoF0g-uLt-r6EN1e6OY=Tmm7nP47P4+bXkv4Q@mail.gmail.com>
To: bpf <bpf@vger.kernel.org>
Message-ID-Hash: N5S57FM4MVKNY6JQ4FRUJY2KK2LX4I6A
X-Message-ID-Hash: N5S57FM4MVKNY6JQ4FRUJY2KK2LX4I6A
X-MailFrom: alexei.starovoitov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: xdp-newbies <xdp-newbies@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, bpf@ietf.org,
 "Jose E. Marchesi" <jemarch@gnu.org>, Quentin Monnet <qmo@kernel.org>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_FOSDEM_2025_eBPF_Devroom_Call_for_Participation?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/RpPxBCtfZUJ2G-_kb8WKe8F1MIo>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlIENGUCBmb3IgQlBGIGRldnJvb20gYXQgRk9TREVNIGNsb3NlcyBvbiBEZWMgMXN0Lg0KDQpQ
bGVhc2Ugc3VibWl0IHlvdXIgcHJvcG9zYWwsDQoNCmFuZC9vciBmb3J3YXJkIHRvIHRoZSBmb2xr
cyB0aGF0IG1pZ2h0IGJlIGludGVyZXN0ZWQgaW4gYXR0ZW5kaW5nIG9yIHNwZWFraW5nLg0KDQoN
Ck9uIEZyaSwgT2N0IDI1LCAyMDI0IGF0IDM6MzLigK9QTSBRdWVudGluIE1vbm5ldCA8cW1vQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPg0KPiBXZSBhcmUgZGVsaWdodGVkIHRvIGFubm91bmNlIHRoZSBD
YWxsIGZvciBQYXJ0aWNpcGF0aW9uIChDRlApIGZvciB0aGUNCj4gdmVyeSBmaXJzdCBlQlBGIERl
dnJvb20gYXQgRk9TREVNIQ0KPg0KPiBNYXJrIHRoZSBEYXRlcw0KPiAtLS0tLS0tLS0tLS0tLQ0K
Pg0KPiAtIERlY2VtYmVyIDFzdCwgMjAyNDogU3VibWlzc2lvbiBkZWFkbGluZQ0KPiAtIERlY2Vt
YmVyIDE1dGgsIDIwMjQ6IEFubm91bmNlbWVudCBvZiBhY2NlcHRlZCB0YWxrcyBhbmQgc2NoZWR1
bGUNCj4gLSBGZWJydWFyeSAxc3QsIDIwMjUgKFNhdHVyZGF5IGFmdGVybm9vbik6IGVCUEYgRGV2
cm9vbSBhdCBGT1NERU0NCj4NCj4gZUJQRiBhdCBGT1NERU0NCj4gLS0tLS0tLS0tLS0tLS0NCj4N
Cj4gRk9TREVNIGlzIGEgZnJlZSwgY29tbXVuaXR5LW9yZ2FuaXplZCBldmVudCBmb2N1c2luZyBv
biBvcGVuIHNvdXJjZSwgYW5kDQo+IGFpbWluZyBhdCBnYXRoZXJpbmcgb3BlbiBzb3VyY2Ugc29m
dHdhcmUgZGV2ZWxvcGVycyBhbmQgY29tbXVuaXRpZXMgdG8NCj4gbWVldCwgbGVhcm4sIGFuZCBz
aGFyZS4gSXQgdGFrZXMgcGxhY2UgYW5udWFsbHkgaW4gQnJ1c3NlbHMsIEJlbGdpdW0uDQo+IEFm
dGVyIGhvc3RpbmcgYSBudW1iZXIgb2YgZUJQRi1yZWxhdGVkIHRhbGtzIGluIHZhcmlvdXMgZGV2
cm9vbXMgb3Zlcg0KPiB0aGUgeWVhcnMsIEZPU0RFTSAyMDI1IHdlbGNvbWVzIGEgZGV2cm9vbSBk
ZWRpY2F0ZWQgdG8gZUJQRiBmb3IgdGhlDQo+IGZpcnN0IHRpbWUhIFRoaXMgZGV2cm9vbSBhaW1z
IGF0IGdhdGhlcmluZyB0YWxrcyBhYm91dCB2YXJpb3VzIGFzcGVjdHMNCj4gb2YgZUJQRiwgaWRl
YWxseSBvbiBtdWx0aXBsZSBwbGF0Zm9ybXMuDQo+DQo+IFRvcGljcyBvZiBJbnRlcmVzdA0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0NCj4NCj4gSWYgeW91IGhhdmUgc29tZXRoaW5nIHRvIHByZXNlbnQg
YWJvdXQgZUJQRiwgd2Ugd291bGQgbG92ZSBmb3IgeW91IHRvDQo+IGNvbnNpZGVyIHN1Ym1pdHRp
bmcgYSBwcm9wb3NhbCB0byB0aGUgRGV2cm9vbS4NCj4NCj4gVGhlIHByb2plY3RzIG9yIHRlY2hu
b2xvZ2llcyBkaXNjdXNzZWQgaW4gdGhlIHRhbGtzIE1VU1QgYmUgb3Blbi1zb3VyY2UuDQo+DQo+
IFRvcGljcyBvZiBpbnRlcmVzdCBmb3IgdGhlIERldnJvb20gaW5jbHVkZSAoYnV0IGFyZSBub3Qg
bGltaXRlZCB0byk6DQo+DQo+IC0gZUJQRiBkZXZlbG9wbWVudDogcmVjZW50IG9yIHByb3Bvc2Vk
IGZlYXR1cmVzIChvbiBMaW51eCwgb24gb3RoZXINCj4gICBwbGF0Zm9ybXMsIG9yIGV2ZW4gY3Jv
c3MtcGxhdGZvcm0pLCBzdWNoIGFzOg0KPiAgICAgLSBlQlBGIHByb2dyYW0gc2lnbmluZyBhbmQg
c3VwcGx5IGNoYWluIHNlY3VyaXR5DQo+ICAgICAtIFByb2ZpbGluZyBlQlBGIHdpdGggZUJQRg0K
PiAgICAgLSBlQlBGLWJhc2VkIHByb2Nlc3Mgc2NoZWR1bGVycw0KPiAgICAgLSBlQlBGIGluIHN0
b3JhZ2UgZGV2aWNlcw0KPiAgICAgLSBlQlBGIHZlcmlmaWVyIGltcHJvdmVtZW50cyBvciBhbHRl
cm5hdGl2ZSBpbXBsZW1lbnRhdGlvbnMNCj4gICAgIC0gTWVtb3J5IG1hbmFnZW1lbnQgZm9yIGVC
UEYNCj4gLSBEZWVwLWRpdmVzIG9uIGV4aXN0aW5nIGVCUEYgZmVhdHVyZXMNCj4gLSBXb3JraW5n
IHdpdGggZUJQRjogYmVzdCBwcmFjdGljZXMsIGNvbW1vbiBtaXN0YWtlcywgZGVidWdnaW5nLCBl
dGMuDQo+IC0gZUJQRiB0b29sY2hhaW4sIGZvciBjb21waWxpbmcsIG1hbmFnaW5nLCBkZWJ1Z2dp
bmcsIHBhY2thZ2luZywgYW5kDQo+ICAgZGVwbG95aW5nIGVCUEYgcHJvZ3JhbXMgYW5kIHJlbGF0
ZWQgb2JqZWN0cw0KPiAtIGVCUEYgbGlicmFyaWVzLCBpbiBDL0MrKywgR28sIFJ1c3QsIG9yIG90
aGVyIGxhbmd1YWdlcw0KPiAtIGVCUEYgaW4gdGhlIHJlYWwgd29ybGQsIHByb2R1Y3Rpb24gdXNl
IGNhc2VzIGFuZCB0aGVpciBpbXBhY3QNCj4gLSBlQlBGIGNvbW11bml0eSBlZmZvcnRzIChkb2N1
bWVudGF0aW9uLCBzdGFuZGFyZGl6YXRpb24sIGNyb3NzLXBsYXRmb3JtDQo+ICAgaW5pdGlhdGl2
ZXMpDQo+DQo+IFRoZSBsaXN0IGlzIG5vdCBleGhhdXN0aXZlLCBkb24ndCBoZXNpdGF0ZSB0byBz
dWJtaXQgeW91ciBwcm9wb3NhbCENCj4NCj4gRm9ybWF0DQo+IC0tLS0tLQ0KPg0KPiBGT1NERU0g
MjAyNSB3aWxsIGJlIGFuIGluLXBlcnNvbiBldmVudCBpbiBCcnVzc2VscywgQmVsZ2l1bS4NCj4g
V2UgZG8gbm90IGFjY2VwdCByZW1vdGUgcHJlc2VudGF0aW9ucy4NCj4NCj4gV2UncmUgbG9va2lu
ZyBmb3IgcHJlc2VudGF0aW9ucyBpbiBvbmUgb2YgdGhlIGZvbGxvd2luZyBzaXplczoNCj4NCj4g
LSAxMCBtaW51dGVzIChmb3IgZXhhbXBsZSwgYSBzaG9ydCBkZW1vKQ0KPiAtIDIwIG1pbnV0ZXMg
KGZvciBleGFtcGxlLCBhIHByb2plY3QgdXBkYXRlKQ0KPiAtIDMwIG1pbnV0ZXMgKGZvciBleGFt
cGxlLCBhbiBpbnRyb2R1Y3Rpb24gdG8gYSBuZXcgdGVjaG5vbG9neSBvciBhIGRlZXANCj4gICBk
aXZlIG9uIGEgY29tcGxleCBmZWF0dXJlKQ0KPg0KPiBUaGUgZHVyYXRpb25zIGFib3ZlIGluY2x1
ZGUgdGltZSBmb3IgcXVlc3Rpb25zOiBhbGxvdyBhdCBsZWFzdCA1IHRvIDEwDQo+IG1pbnV0ZXMs
IGRlcGVuZGluZyBvbiB0aGUgdG90YWwgbGVuZ3RoLCB0byBhbnN3ZXIgcXVlc3Rpb25zIGZyb20g
dGhlDQo+IHB1YmxpYy4NCj4NCj4gSG93IHRvIFN1Ym1pdA0KPiAtLS0tLS0tLS0tLS0tDQo+DQo+
IFBsZWFzZSBzdWJtaXQgeW91ciBwcm9wb3NhbHMgb24gUHJldGFseCwgRk9TREVNJ3Mgc3VibWlz
c2lvbnMgdG9vbCwgYXQNCj4gaHR0cHM6Ly9wcmV0YWx4LmZvc2RlbS5vcmcvZm9zZGVtLTIwMjUv
Y2ZwDQo+DQo+IE1ha2Ugc3VyZSB0byBzZWxlY3QgImVCUEYiIGFzIHRoZSB0cmFjay4NCj4NCj4g
VGhlIG9mZmljaWFsIGNvbW11bmljYXRpb24gY2hhbm5lbCBmb3IgdGhlIERldnJvb20gaXMgdGhl
IGRlZGljYXRlZA0KPiBGT1NERU0gbWFpbGluZyBsaXN0LCBlYnBmLWRldnJvb21AbGlzdHMuZm9z
ZGVtLm9yZy4gSWYgeW91IHN1Ym1pdCBhDQo+IHRhbGssIHBsZWFzZSBtYWtlIHN1cmUgdG8gam9p
biB0aGUgbGlzdDoNCj4gaHR0cHM6Ly9saXN0cy5mb3NkZW0ub3JnL2xpc3RpbmZvL2VicGYtZGV2
cm9vbQ0KPg0KPiBDb2RlIG9mIENvbmR1Y3QNCj4gLS0tLS0tLS0tLS0tLS0tDQo+DQo+IEFsbCBw
YXJ0aWNpcGFudHMgYXQgRk9TREVNIGFyZSBleHBlY3RlZCB0byBhYmlkZSBieSB0aGUgRk9TREVN
J3MgQ29kZSBvZg0KPiBDb25kdWN0LiBJZiB5b3VyIHByb3Bvc2FsIGlzIGFjY2VwdGVkLCB5b3Ug
d2lsbCBiZSByZXF1aXJlZCB0byBjb25maXJtDQo+IHRoYXQgeW91IGFjY2VwdCB0aGlzIENvZGUg
b2YgQ29uZHVjdC4gWW91IGNhbiBmaW5kIHRoaXMgY29kZSBhdA0KPiBodHRwczovL2Zvc2RlbS5v
cmcvMjAyNS9wcmFjdGljYWwvY29uZHVjdC8NCj4NCj4gRGV2cm9vbSBPcmdhbmlzZXJzDQo+IC0t
LS0tLS0tLS0tLS0tLS0tLQ0KPg0KPiAtIEFsYW4gSm93ZXR0DQo+IC0gQWxleGVpIFN0YXJvdm9p
dG92DQo+IC0gQW5kcmlpIE5ha3J5aWtvDQo+IC0gQmlsbCBNdWxsaWdhbg0KPiAtIERhbmllbCBC
b3JrbWFubg0KPiAtIERpbWl0YXIgS2FuYWxpZXYNCj4gLSBRdWVudGluIE1vbm5ldA0KPiAtIFl1
c2hlbmcgWmhlbmcNCj4NCj4gSWYgeW91IGhhdmUgcXVlc3Rpb25zIGFib3V0IGFueSBhc3BlY3Rz
IG9mIHRoaXMgQ2FsbCBmb3IgUGFydGljaXBhdGlvbiwNCj4gcGxlYXNlIGVtYWlsIHVzIGF0IGVi
cGYtZGV2cm9vbS1tYW5hZ2VyQGZvc2RlbS5vcmcsIGFuZCB3ZSB3aWxsIGRvIG91cg0KPiBiZXN0
IHRvIGFzc2lzdCB5b3UuDQo+DQo+IFdlIGtlZXAgYW4gdXAtdG8tZGF0ZSB2ZXJzaW9uIG9mIHRo
aXMgQ2FsbCBmb3IgUGFydGljaXBhdGlvbiBhdA0KPiBodHRwczovL2VicGYuaW8vZm9zZGVtLTIw
MjUuaHRtbA0KPg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

