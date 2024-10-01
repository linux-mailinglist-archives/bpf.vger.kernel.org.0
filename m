Return-Path: <bpf+bounces-40713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F598C66F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FE71F24E58
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34F1CCB53;
	Tue,  1 Oct 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ST2GLXQw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WB29MYBw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TFxWIYw7"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D321BC072
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813025; cv=none; b=MpeJGhJL4EP0eQNFu62q9VtRDl9DRC5LDMpNfDdakRKs6tWzQHzuQ/0xnswK4ZLODrVe2Ec3wM3OGIxnTb/MUIIa8+fAAgKc25XCIBfC/pU8gp46LINVlEYInj8b75/bNE6kS1CqMYowCeQjFsS4KWRQNvs8K1hYtz0KaYHffRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813025; c=relaxed/simple;
	bh=lrCFfRAGUzOmuDvl5ddi7lgMYWGvj4C9taG2t6AYswE=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=GBbHO8gwFOdO73NZFV1f3+YlXjsUlUS4xJD6xQRN9FJOlx1IFjJw9WYV3gqc/sDb5iA3IVLYeWfkxmxMAWPLMHf86ZrOtw94Kmy5RGcSy9lnxPdAKb4TMdaL3BNztsIQzPvGOjdvOiznNZ/T8ugoFpQBk2IDJHOEuaU6yk7nRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ST2GLXQw; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WB29MYBw reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TFxWIYw7 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4FD48C180B60
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1727812524; bh=lrCFfRAGUzOmuDvl5ddi7lgMYWGvj4C9taG2t6AYswE=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ST2GLXQwDAIqHaF7r8L2QgMMPjd0s825FnYevENgrVXFusde5qDTmqsBA7z7+TaNt
	 v/8uGP2kYGxSOHxVErIfmoQqCsQ/2Y7W1uWnvdOM2Dp74oGqBEewwI/LHTBh3cv+OR
	 6b0iqlPl3S6MSu8Uji2pJcR1ij+u18W4q0SURCXo=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 26760C1519B6
 for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1727812524; bh=lrCFfRAGUzOmuDvl5ddi7lgMYWGvj4C9taG2t6AYswE=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=WB29MYBwH2y4nSdXXQ8FNtu6V2YR0/x5Oumoa9w6NvC5O0fr33vZ9Fgu6zJyHkwZ4
 uFEPu7VEQpJY6ZIjxBiNci0QsjiyyoWWuHZNAKz7LV7QZ7sfiPFurpnoVmU7aUfvJU
 Stv8iUu6Eay8+KhH1dJ5lozq1gFuX8Zfh4ETaS08=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1493EC151068
 for <bpf@ietfa.amsl.com>; Tue,  1 Oct 2024 12:55:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.854
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5yi9arXfnMm for <bpf@ietfa.amsl.com>;
 Tue,  1 Oct 2024 12:55:18 -0700 (PDT)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C18EFC14F703
 for <bpf@ietf.org>; Tue,  1 Oct 2024 12:54:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b7259be6fso32075145ad.0
 for <bpf@ietf.org>; Tue, 01 Oct 2024 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1727812473; x=1728417273;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TuGoJk9ECvqTkdhRfL58HMyKOI+yVlMGcPqLYre0Ahc=;
 b=TFxWIYw7MBEFjnQre+n5GFIGmrZNq0GU4lQzxhO85MDBe+5jp+u2w1FiqAupnOosy/
 B68ozLzIjQWt4LEonoSC54EIAGP6zPbPpc/DDIC8bNLFQyV2zWzK628Wc2o+bSdDqiGd
 KOinqlnWxQcnd3QbTYWke67P29n3p/a3f6tz8CRVYUtwDJHOduyqxcWFa/lgCAaDtZxN
 RF1dTjc9xuTk5/+2Bb/eSP7kmw9i9IzlCPvNXn0Wbz7EYMYFIxj3ri0/DwxkKG5nMMei
 1UbKgeMzHJ5aW8PAPgx/pXP1TKjje6+XILSQZsfq0lpR4FZd5EWG6TsxpBIzymHFwpyd
 wUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727812473; x=1728417273;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TuGoJk9ECvqTkdhRfL58HMyKOI+yVlMGcPqLYre0Ahc=;
 b=AfYTmcFEeZzA++HKEe7vfIk3aEasxVkVoMbH3cn366Rv5CDmrnSIpNcWsg/MKzWB3o
 fCVcBw8wfANLDwUMeTmuGfUxBCgqqG06K/FSb5G8DQF0aia57Ud8Dm1rQD70x8tXedcU
 HTeOOBDO9khxnuztgI8QkwMRBUdYzGum1RRVDIcl4AMsFKLuFQ0Ui2v6Xk79PycfjOpu
 KgJOQVI9Z3Ur1ss7OE7g6pau27B3k/UiOHnrJRSca35LtOAtyuE+VGj3+v3vXgaKMOqH
 b8kEsYWN5ewtQWlYVtcQXkyyx5WdsY5Gcd0GYXVMIl6Dwm+N+hfiJXnk3cgzstMj7zxP
 3CUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4cpTgp83EgAQKbwxr/dbxKUwg1kGooO624sNM8rrPEz9a12vdHMGaU9wD3H+DbdRBKXU=@ietf.org
X-Gm-Message-State: AOJu0YxQMq5C3JLFfuko4YFXy98U26LyEbzGC5ODdWbYRC7cYx4Ro1W1
 QW2ah32jM2mW66Q9+zJhR3AZ0Pum/UOcDDA90F3tThNj8n7M2u6i
X-Google-Smtp-Source: AGHT+IFVhbB/nL9ZYL1sIb+zR/pBa2OyC8tXDQL0EL3nGOyvlR4VqOEyMLN/BUeXrKLcnwyn+SiONw==
X-Received: by 2002:a17:903:1103:b0:20b:9078:707b with SMTP id
 d9443c01a7336-20bc5a10233mr8891435ad.30.1727812473077;
 Tue, 01 Oct 2024 12:54:33 -0700 (PDT)
Received: from ArmidaleLaptop ([2601:600:877f:ae0f:f8cf:32cf:647d:b56e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37d89297sm73751755ad.71.2024.10.01.12.54.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2024 12:54:32 -0700 (PDT)
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>,
 "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>, <bpf@ietf.org>
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
In-Reply-To: <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
Date: Tue, 1 Oct 2024 12:54:27 -0700
Message-ID: <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKzqMffW8FFfWCd3ulEKsb+gfc3egGOkjXjAfqQ6mmwpNlrgA==
Content-Language: en-us
Message-ID-Hash: YWEJP3KQ2OXTQKMEEI4H7RCXD5VLGSAU
X-Message-ID-Hash: YWEJP3KQ2OXTQKMEEI4H7RCXD5VLGSAU
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: 'bpf' <bpf@vger.kernel.org>, 'Alexei Starovoitov' <ast@kernel.org>,
 'Andrii Nakryiko' <andrii@kernel.org>,
 'Daniel Borkmann' <daniel@iogearbox.net>,
 'Martin KaFai Lau' <martin.lau@kernel.org>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_docs/bpf=3A_Document_some_spe?=
 =?utf-8?q?cial_sdiv/smod_operations?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/RIsU3BSetPq3LrX7rc4qFb4bEJw>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

WW9uZ2hvbmcgU29uZyA8eW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY+IHdyb3RlOiANCj4gT24gOS8z
MC8yNCA2OjUwIFBNLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+ID4gT24gVGh1LCBTZXAg
MjYsIDIwMjQgYXQgODozOeKAr1BNIFlvbmdob25nIFNvbmcgPHlvbmdob25nLnNvbmdAbGludXgu
ZGV2Pg0KPiB3cm90ZToNCj4gPj4gUGF0Y2ggWzFdIGZpeGVkIHBvc3NpYmxlIGtlcm5lbCBjcmFz
aCBkdWUgdG8gc3BlY2lmaWMgc2Rpdi9zbW9kDQo+ID4+IG9wZXJhdGlvbnMgaW4gYnBmIHByb2dy
YW0uIFRoZSBmb2xsb3dpbmcgYXJlIHJlbGF0ZWQgb3BlcmF0aW9ucyBhbmQNCj4gPj4gdGhlIGV4
cGVjdGVkIHJlc3VsdHMgb2YgdGhvc2Ugb3BlcmF0aW9uczoNCj4gPj4gICAgLSBMTE9OR19NSU4v
LTEgPSBMTE9OR19NSU4NCj4gPj4gICAgLSBJTlRfTUlOLy0xID0gSU5UX01JTg0KPiA+PiAgICAt
IExMT05HX01JTiUtMSA9IDANCj4gPj4gICAgLSBJTlRfTUlOJS0xID0gMA0KPiA+Pg0KPiA+PiBU
aG9zZSBvcGVyYXRpb25zIGFyZSByZXBsYWNlZCB3aXRoIGNvZGVzIHdoaWNoIHdvbid0IGNhdXNl
IGtlcm5lbA0KPiA+PiBjcmFzaC4gVGhpcyBwYXRjaCBkb2N1bWVudHMgd2hhdCBvcGVyYXRpb25z
IG1heSBjYXVzZSBleGNlcHRpb24gYW5kDQo+ID4+IHdoYXQgcmVwbGFjZW1lbnQgb3BlcmF0aW9u
cyBhcmUuDQo+ID4+DQo+ID4+ICAgIFsxXQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDA5MTMxNTAzMjYuMTE4Nzc4OC0xLXlvbmdob25nLnNvbmdAbGkNCj4gPj4gbnV4LmRl
di8NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWW9uZ2hvbmcgU29uZyA8eW9uZ2hvbmcuc29u
Z0BsaW51eC5kZXY+DQo+ID4+IC0tLQ0KPiA+PiAgIC4uLi9icGYvc3RhbmRhcmRpemF0aW9uL2lu
c3RydWN0aW9uLXNldC5yc3QgICB8IDI1ICsrKysrKysrKysrKysrKy0tLS0NCj4gPj4gICAxIGZp
bGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlv
bi1zZXQucnN0DQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3Ry
dWN0aW9uLXNldC5yc3QNCj4gPj4gaW5kZXggYWI4MjBkNTY1MDUyLi5kMTUwYzFkN2FkM2IgMTAw
NjQ0DQo+ID4+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVj
dGlvbi1zZXQucnN0DQo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlv
bi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+ID4+IEBAIC0zNDcsMTEgKzM0NywyNiBAQCByZWdpc3Rl
ci4NCj4gPj4gICAgID09PT09ICA9PT09PSAgPT09PT09PQ0KPiA+PiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4+DQo+ID4+ICAg
VW5kZXJmbG93IGFuZCBvdmVyZmxvdyBhcmUgYWxsb3dlZCBkdXJpbmcgYXJpdGhtZXRpYyBvcGVy
YXRpb25zLA0KPiA+PiBtZWFuaW5nIC10aGUgNjQtYml0IG9yIDMyLWJpdCB2YWx1ZSB3aWxsIHdy
YXAuIElmIEJQRiBwcm9ncmFtDQo+ID4+IGV4ZWN1dGlvbiB3b3VsZCAtcmVzdWx0IGluIGRpdmlz
aW9uIGJ5IHplcm8sIHRoZSBkZXN0aW5hdGlvbiByZWdpc3RlciBpcyBpbnN0ZWFkIHNldA0KPiB0
byB6ZXJvLg0KPiA+PiAtSWYgZXhlY3V0aW9uIHdvdWxkIHJlc3VsdCBpbiBtb2R1bG8gYnkgemVy
bywgZm9yIGBgQUxVNjRgYCB0aGUgdmFsdWUgb2YNCj4gPj4gLXRoZSBkZXN0aW5hdGlvbiByZWdp
c3RlciBpcyB1bmNoYW5nZWQgd2hlcmVhcyBmb3IgYGBBTFVgYCB0aGUgdXBwZXINCj4gPj4gLTMy
IGJpdHMgb2YgdGhlIGRlc3RpbmF0aW9uIHJlZ2lzdGVyIGFyZSB6ZXJvZWQuDQo+ID4+ICt0aGUg
NjQtYml0IG9yIDMyLWJpdCB2YWx1ZSB3aWxsIHdyYXAuIFRoZXJlIGFyZSBhbHNvIGEgZmV3DQo+
ID4+ICthcml0aG1ldGljIG9wZXJhdGlvbnMgd2hpY2ggbWF5IGNhdXNlIGV4Y2VwdGlvbiBmb3Ig
Y2VydGFpbg0KPiA+PiArYXJjaGl0ZWN0dXJlcy4gU2luY2UgY3Jhc2hpbmcgdGhlIGtlcm5lbCBp
cyBub3QgYW4gb3B0aW9uLCB0aG9zZSBvcGVyYXRpb25zIGFyZQ0KPiByZXBsYWNlZCB3aXRoIGFs
dGVybmF0aXZlIG9wZXJhdGlvbnMuDQo+ID4+ICsNCj4gPj4gKy4uIHRhYmxlOjogQXJpdGhtZXRp
YyBvcGVyYXRpb25zIHdpdGggcG9zc2libGUgZXhjZXB0aW9ucw0KPiA+PiArDQo+ID4+ICsgID09
PT09ICA9PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiA+PiArICBuYW1lICAgY2xhc3MgICAgICAgb3JpZ2luYWwg
ICAgICAgICAgICAgICAgICAgICAgIHJlcGxhY2VtZW50DQo+ID4+ICsgID09PT09ICA9PT09PT09
PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiA+PiArICBESVYgICAgQUxVNjQvQUxVICAgZHN0IC89IDAgICAgICAgICAgICAg
ICAgICAgICAgIGRzdCA9IDANCj4gPj4gKyAgU0RJViAgIEFMVTY0L0FMVSAgIGRzdCBzLz0gMCAg
ICAgICAgICAgICAgICAgICAgICBkc3QgPSAwDQo+ID4+ICsgIE1PRCAgICBBTFU2NCAgICAgICBk
c3QgJT0gMCAgICAgICAgICAgICAgICAgICAgICAgZHN0ID0gZHN0IChubyByZXBsYWNlbWVudCkN
Cj4gPj4gKyAgTU9EICAgIEFMVSAgICAgICAgIGRzdCAlPSAwICAgICAgICAgICAgICAgICAgICAg
ICBkc3QgPSAodTMyKWRzdA0KPiA+PiArICBTTU9EICAgQUxVNjQgICAgICAgZHN0IHMlPSAwICAg
ICAgICAgICAgICAgICAgICAgIGRzdCA9IGRzdCAobm8gcmVwbGFjZW1lbnQpDQo+ID4+ICsgIFNN
T0QgICBBTFUgICAgICAgICBkc3QgcyU9IDAgICAgICAgICAgICAgICAgICAgICAgZHN0ID0gKHUz
Milkc3QNCg0KQWxsIG9mIHRoZSBhYm92ZSBhcmUgYWxyZWFkeSBjb3ZlcmVkIGluIGV4aXN0aW5n
IFRhYmxlIDUgYW5kIGluIG15IG9waW5pb24NCmRvbid0IG5lZWQgdG8gYmUgcmVwZWF0ZWQuDQoN
ClRoYXQgaXMsIHRoZSAib3JpZ2luYWwiIGlzIG5vdCB3aGF0IFRhYmxlIDUgaGFzLCBzbyBqdXN0
IGludHJvZHVjZXMgY29uZnVzaW9uDQppbiB0aGUgZG9jdW1lbnQgaW4gbXkgb3Bpbmlvbi4NCg0K
PiA+PiArICBTRElWICAgQUxVNjQgICAgICAgZHN0IHMvPSAtMSAoZHN0ID0gTExPTkdfTUlOKSAg
IGRzdCA9IExMT05HX01JTg0KPiA+PiArICBTRElWICAgQUxVICAgICAgICAgZHN0IHMvPSAtMSAo
ZHN0ID0gSU5UX01JTikgICAgIGRzdCA9ICh1MzIpSU5UX01JTg0KPiA+PiArICBTTU9EICAgQUxV
NjQgICAgICAgZHN0IHMlPSAtMSAoZHN0ID0gTExPTkdfTUlOKSAgIGRzdCA9IDANCj4gPj4gKyAg
U01PRCAgIEFMVSAgICAgICAgIGRzdCBzJT0gLTEgKGRzdCA9IElOVF9NSU4pICAgICBkc3QgPSAw
DQoNClRoZSBhYm92ZSBmb3VyIGFyZSB0aGUgbmV3IG9uZXMgYW5kIEknZCBwcmVmZXIgYSBzb2x1
dGlvbiB0aGF0IG1vZGlmaWVzDQpleGlzdGluZyB0YWJsZSA1LiAgRS5nLiB0YWJsZSA1IGhhcyBu
b3cgZm9yIFNNT0Q6DQoNCmRzdCA9IChzcmMgIT0gMCkgPyAoZHN0IHMlIHNyYykgOiBkc3QNCg0K
YW5kIGNvdWxkIGhhdmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KZHN0ID0gKHNyYyA9PSAwKSA/
IGRzdCA6ICgoc3JjID09IC0xICYmIGRzdCA9PSBJTlRfTUlOKSA/IDAgOiAoZHN0IHMlIHNyYykp
DQoNCj4gPiBUaGlzIGlzIGEgZ3JlYXQgYWRkaXRpb24gdG8gdGhlIGRvYywgYnV0IHRoaXMgZmls
ZSBpcyBjdXJyZW50bHkgYmVpbmcNCj4gPiB1c2VkIGFzIGEgYmFzZSBmb3IgSUVURiBzdGFuZGFy
ZCB3aGljaCBpcyBpbiBpdHMgZmluYWwgImVkaXQiIHN0YWdlDQo+ID4gd2hpY2ggbWF5IHJlcXVp
cmUgZmV3IHBhdGNoZXMsIHNvIHdlIGNhbm5vdCBsYW5kIGFueSBjaGFuZ2VzIHRvDQo+ID4gaW5z
dHJ1Y3Rpb24tc2V0LnJzdCBub3QgcmVsYXRlZCB0byBzdGFuZGFyZGl6YXRpb24gdW50aWwgUkZD
IG51bWJlciBpcw0KPiA+IGlzc3VlZCBhbmQgaXQgYmVjb21lcyBpbW11dGFibGUuIEFmdGVyIHRo
YXQgdGhlIHNhbWUNCj4gPiBpbnN0cnVjdGlvbi1zZXQucnN0IGZpbGUgY2FuIGJlIHJldXNlZCBm
b3IgZnV0dXJlIHJldmlzaW9ucyBvbiB0aGUNCj4gPiBzdGFuZGFyZC4NCj4gPiBIb3BlZnVsbHkg
dGhlIGRyYWZ0IHdpbGwgY2xlYXIgdGhlIGZpbmFsIGh1cmRsZSBpbiBhIGNvdXBsZSB3ZWVrcy4N
Cj4gPiBVbnRpbCB0aGVuOg0KPiA+IHB3LWJvdDogY3INCj4gDQo+IFN1cmUuIE5vIHByb2JsZW0u
IFdpbGwgcmVzdWJtaXQgb25jZSB0aGUgUkZDIG51bWJlciBpcyBpc3N1ZWQuDQoNCkknbSBhZGRp
bmcgYnBmQGlldGYub3JnIHRvIHRoZSBUbyBsaW5lIHNpbmNlIGFsbCBjaGFuZ2VzIGluIHRoZSBz
dGFuZGFyZGl6YXRpb24NCmRpcmVjdG9yeSBzaG91bGQgaW5jbHVkZSB0aGF0IG1haWxpbmcgbGlz
dC4NCg0KVGhlIFdHIHNob3VsZCBkaXNjdXNzIHdoZXRoZXIgYW55IGNoYW5nZXMgc2hvdWxkIGJl
IGRvbmUgdmlhIGEgbmV3IFJGQw0KdGhhdCBvYnNvbGV0ZXMgdGhlIGZpcnN0IG9uZSwgb3IgYXMg
UkZDcyB0aGF0IFVwZGF0ZSBhbmQganVzdCBkZXNjcmliZSBkZWx0YXMNCihhZGRpdGlvbnMsIGV0
Yy4pLg0KDQpUaGVyZSBhcmUgcHJlY2VkZW50cyBib3RoIHdheXMgYW5kIEkgZG9uJ3QgaGF2ZSBh
IHN0cm9uZyBwcmVmZXJlbmNlLCBidXQgSQ0KaGF2ZSBhIHdlYWsgcHJlZmVyZW5jZSBmb3IgZGVs
dGEtYmFzZWQgb25lcyBzaW5jZSB0aGV5J3JlIHNob3J0ZXIgYW5kIGFyZQ0KbGVzcyBsaWtlbHkg
dG8gcmUtb3BlbiBkaXNjdXNzaW9uIG9uIHByZXZpb3VzbHkgcmVzb2x2ZWQgaXNzdWVzLCB0aHVz
IG9mdGVuDQpzYXZpbmcgdGhlIFdHIHRpbWUuDQoNCkFsc28gRllJIHRvIExpbnV4IGtlcm5lbCBm
b2xrczoNCldpdGggV0cgYW5kIEFEIGFwcHJvdmFsLCBpdCdzIGFsc28gcG9zc2libGUgKGJ1dCBu
b3QgaWRlYWwpIHRvIHRha2UgY2hhbmdlcw0KYXQgQVVUSDQ4LiAgVGhhdCdkIGJlIHVwIHRvIHRo
ZSBjaGFpcnMgYW5kIEFEIHRvIGRlY2lkZSB0aG91Z2gsIGFuZCBub3JtYWxseQ0KdGhhdCdzIGp1
c3QgZm9yIHB1cmVseSBlZGl0b3JpYWwgY2xhcmlmaWNhdGlvbnMsIGUuZy4sIHRvIGNvbmZ1c2lv
biBjYWxsZWQgb3V0IGJ5IHRoZQ0KUkZDIGVkaXRvciBwYXNzLg0KDQpEYXZlDQoNCi0tIApCcGYg
bWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWls
IHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

