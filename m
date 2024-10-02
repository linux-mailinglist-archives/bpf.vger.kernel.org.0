Return-Path: <bpf+bounces-40790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9C498E402
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6FCB2401E
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0555216A26;
	Wed,  2 Oct 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GRKBkRuH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GRKBkRuH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PImVsuHa"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0491D0E28
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900071; cv=none; b=D75p91cyHRxQMPam509h43jx0zJQTQKSiebysMxVazDT3uUSSje2hW5q7uyBgrk6x7MvSv39uYrGUf46oGgVxjtOkDAbpFL+ZUV4hMz2OGioet98fAU0Zp3asH8cilpgUvVt3gNccP4FJhaI4rP7Lw7WrTqow05xs8dlMW7Peyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900071; c=relaxed/simple;
	bh=zLw3iZ0LbfmU3Bvj30EJweGl4Ssa8H76DIfGsQR7kUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=JHTZCU75XPjWq+InZjmsE8l2EuJsdbeVg+oRm63pz04kjHPukRTa5noUtTj02Mf9F0p+ccbJZy68fFGmDF73AKJUVIN7aMAHfnwxP0sxVPxbJ8HoYaa3C2Qoi53yQUk1XuYHnLZ/M+hQ+V/lPNLIlyci+o7JW3TA5qCLtQZ65Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GRKBkRuH; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GRKBkRuH; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PImVsuHa reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 91B71C1840FE
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1727900063; bh=zLw3iZ0LbfmU3Bvj30EJweGl4Ssa8H76DIfGsQR7kUw=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=GRKBkRuHktcuxWOILeqwjT2p3K3/CoC4HMP93oxoABrBu8c+W61X7qjgFNbK/dtgu
	 Sqrb758hKub+5Ct/AkA9BOEehWxZItczOZDpBjC0v0rQUyI3Umr4Cb9KVie6KSHNEi
	 h3mx0vDtL8XN/RNPkPJpZVTc6/iw5CPgFdXXxHOY=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Wed Oct  2 13:14:23 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8B76EC1CAE67
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1727900063; bh=zLw3iZ0LbfmU3Bvj30EJweGl4Ssa8H76DIfGsQR7kUw=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=GRKBkRuHktcuxWOILeqwjT2p3K3/CoC4HMP93oxoABrBu8c+W61X7qjgFNbK/dtgu
	 Sqrb758hKub+5Ct/AkA9BOEehWxZItczOZDpBjC0v0rQUyI3Umr4Cb9KVie6KSHNEi
	 h3mx0vDtL8XN/RNPkPJpZVTc6/iw5CPgFdXXxHOY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 32652C17C89D
	for <bpf@ietfa.amsl.com>; Wed,  2 Oct 2024 13:14:14 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KEaCXGzjSd6x for <bpf@ietfa.amsl.com>;
	Wed,  2 Oct 2024 13:14:13 -0700 (PDT)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 70C13C16A126
	for <bpf@ietf.org>; Wed,  2 Oct 2024 13:14:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37cc810ce73so139092f8f.1
        for <bpf@ietf.org>; Wed, 02 Oct 2024 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727900051; x=1728504851; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60aPyFZu4LEJZ3NoEJXlgldS/ABC8PSGmDDpW20tAK4=;
        b=PImVsuHaxKl30QCbvox9yP51bzgZmlv0ClTALsz9gT9M5gTf2FmT/E6K8sOw45X2ZD
         0ZN8Sxf5gvna0b/7LTtXnL8SbJFlxJJxv5gnoNSAw4c26k/t/6SS6yJ2mmXGv9WVzMPi
         DeBM9c9uuGV9mLaYypZVfj0oo6Q7xZU5EBEJdqAtV+xlj/quheg82ysSZVBNrreREPA+
         bIAP+FtU2n2bIjn0+/OK/iw9uLui9acpFiKAtEHmSpWiT6i+8QNuWEHww81+L2y10WTl
         aChvJ1gx8avJ5DjX30PWw03v0QfwoE7EnFrYiUD7s2vHIOEBoq79IthxOy+vU66Txlrs
         4saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900051; x=1728504851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60aPyFZu4LEJZ3NoEJXlgldS/ABC8PSGmDDpW20tAK4=;
        b=t7+/eq2TjEKZvNR4I+NZY6lLjUPAHAY3QIn+Fqi5yD/3MW6mH3daAZc61KoKNibqTw
         N9omBExPAOrcI527cQ/Tl9cP/5Ob9dHp19ZZtGFb+fvd6G7cC05IuiPraMNmEwPmTPMT
         tfWjBkEIo+q577xR2uEI/pRWGVvr+JAI4LG686w9WfnwY63cXBvP/qJZH9oAf0x3pe53
         5jFAUiPmHN/fRNa2HmFLBMd27P00kgz9G/WrRfuw0b7EaHuCNvHctPHoksuZX+k6BETi
         LuYLXLjAHWTdpRnKnNkJmuTmr5gFIwIjZceS51LoF5zwvIXIqmxdBFia7VTs85HgWXms
         E7ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVurCvqQvhjlblPh8oeJR5BA/O3A6Fz0rfZ74b4RSu73j9j7ED1zinUdivARa8NdhA8umk=@ietf.org
X-Gm-Message-State: AOJu0YybD7n8165AralGH+LBPvPgnF4Q4fEMjGM4UlmNm3jLT0iPq57s
	8ExM1ur/ke9tBNaqfoHy2VLug0wGpR6SgmGZWC2ebfdPW3GNnQ1eD4ErJUjNLxkae5wsGvljKnP
	x5J7hmhdemYQ1/3Tq7/0Wt8bUDYo=
X-Google-Smtp-Source: 
 AGHT+IE9MTp/YZZXv7ZngEnj/6BOPPJvM2bKY0XNaaeB47qCt8xlKNRX/emFdzMF3HJ4bPp+wbA2vD5EajwibkG4hdw=
X-Received: by 2002:a05:6000:2a3:b0:37c:cec1:6292 with SMTP id
 ffacd0b85a97d-37cfb8a5e9amr2948597f8f.8.1727900050746; Wed, 02 Oct 2024
 13:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
In-Reply-To: <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Oct 2024 13:13:59 -0700
Message-ID: 
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Message-ID-Hash: 623D7PW4NQ6M424JHJZCLL46RXFKAREC
X-Message-ID-Hash: 623D7PW4NQ6M424JHJZCLL46RXFKAREC
X-MailFrom: alexei.starovoitov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailman-Version: 3.3.9rc5
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_docs/bpf=3A_Document_some_spe?=
	=?utf-8?q?cial_sdiv/smod_operations?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/UBLhxuDMh-bhLtMgNPd54nsvQbs>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBPY3QgMSwgMjAyNCBhdCAxMjo1NOKAr1BNIERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2
OEBnb29nbGVtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IFlvbmdob25nIFNvbmcgPHlvbmdob25nLnNv
bmdAbGludXguZGV2PiB3cm90ZToNCj4gPiBPbiA5LzMwLzI0IDY6NTAgUE0sIEFsZXhlaSBTdGFy
b3ZvaXRvdiB3cm90ZToNCj4gPiA+IE9uIFRodSwgU2VwIDI2LCAyMDI0IGF0IDg6MznigK9QTSBZ
b25naG9uZyBTb25nIDx5b25naG9uZy5zb25nQGxpbnV4LmRldj4NCj4gPiB3cm90ZToNCj4gPiA+
PiBQYXRjaCBbMV0gZml4ZWQgcG9zc2libGUga2VybmVsIGNyYXNoIGR1ZSB0byBzcGVjaWZpYyBz
ZGl2L3Ntb2QNCj4gPiA+PiBvcGVyYXRpb25zIGluIGJwZiBwcm9ncmFtLiBUaGUgZm9sbG93aW5n
IGFyZSByZWxhdGVkIG9wZXJhdGlvbnMgYW5kDQo+ID4gPj4gdGhlIGV4cGVjdGVkIHJlc3VsdHMg
b2YgdGhvc2Ugb3BlcmF0aW9uczoNCj4gPiA+PiAgICAtIExMT05HX01JTi8tMSA9IExMT05HX01J
Tg0KPiA+ID4+ICAgIC0gSU5UX01JTi8tMSA9IElOVF9NSU4NCj4gPiA+PiAgICAtIExMT05HX01J
TiUtMSA9IDANCj4gPiA+PiAgICAtIElOVF9NSU4lLTEgPSAwDQo+ID4gPj4NCj4gPiA+PiBUaG9z
ZSBvcGVyYXRpb25zIGFyZSByZXBsYWNlZCB3aXRoIGNvZGVzIHdoaWNoIHdvbid0IGNhdXNlIGtl
cm5lbA0KPiA+ID4+IGNyYXNoLiBUaGlzIHBhdGNoIGRvY3VtZW50cyB3aGF0IG9wZXJhdGlvbnMg
bWF5IGNhdXNlIGV4Y2VwdGlvbiBhbmQNCj4gPiA+PiB3aGF0IHJlcGxhY2VtZW50IG9wZXJhdGlv
bnMgYXJlLg0KPiA+ID4+DQo+ID4gPj4gICAgWzFdDQo+ID4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwOTEzMTUwMzI2LjExODc3ODgtMS15b25naG9uZy5zb25nQGxpDQo+ID4g
Pj4gbnV4LmRldi8NCj4gPiA+Pg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IFlvbmdob25nIFNvbmcg
PHlvbmdob25nLnNvbmdAbGludXguZGV2Pg0KPiA+ID4+IC0tLQ0KPiA+ID4+ICAgLi4uL2JwZi9z
dGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCAgIHwgMjUgKysrKysrKysrKysrKysr
LS0tLQ0KPiA+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+ID4gPj4NCj4gPiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvc3Rh
bmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gPiA+PiBiL0RvY3VtZW50YXRpb24v
YnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+ID4gPj4gaW5kZXggYWI4
MjBkNTY1MDUyLi5kMTUwYzFkN2FkM2IgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gPiA+PiArKysgYi9E
b2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPiA+
ID4+IEBAIC0zNDcsMTEgKzM0NywyNiBAQCByZWdpc3Rlci4NCj4gPiA+PiAgICAgPT09PT0gID09
PT09ICA9PT09PT09DQo+ID4gPj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ID4+DQo+ID4gPj4gICBVbmRlcmZsb3cgYW5kIG92
ZXJmbG93IGFyZSBhbGxvd2VkIGR1cmluZyBhcml0aG1ldGljIG9wZXJhdGlvbnMsDQo+ID4gPj4g
bWVhbmluZyAtdGhlIDY0LWJpdCBvciAzMi1iaXQgdmFsdWUgd2lsbCB3cmFwLiBJZiBCUEYgcHJv
Z3JhbQ0KPiA+ID4+IGV4ZWN1dGlvbiB3b3VsZCAtcmVzdWx0IGluIGRpdmlzaW9uIGJ5IHplcm8s
IHRoZSBkZXN0aW5hdGlvbiByZWdpc3RlciBpcyBpbnN0ZWFkIHNldA0KPiA+IHRvIHplcm8uDQo+
ID4gPj4gLUlmIGV4ZWN1dGlvbiB3b3VsZCByZXN1bHQgaW4gbW9kdWxvIGJ5IHplcm8sIGZvciBg
YEFMVTY0YGAgdGhlIHZhbHVlIG9mDQo+ID4gPj4gLXRoZSBkZXN0aW5hdGlvbiByZWdpc3RlciBp
cyB1bmNoYW5nZWQgd2hlcmVhcyBmb3IgYGBBTFVgYCB0aGUgdXBwZXINCj4gPiA+PiAtMzIgYml0
cyBvZiB0aGUgZGVzdGluYXRpb24gcmVnaXN0ZXIgYXJlIHplcm9lZC4NCj4gPiA+PiArdGhlIDY0
LWJpdCBvciAzMi1iaXQgdmFsdWUgd2lsbCB3cmFwLiBUaGVyZSBhcmUgYWxzbyBhIGZldw0KPiA+
ID4+ICthcml0aG1ldGljIG9wZXJhdGlvbnMgd2hpY2ggbWF5IGNhdXNlIGV4Y2VwdGlvbiBmb3Ig
Y2VydGFpbg0KPiA+ID4+ICthcmNoaXRlY3R1cmVzLiBTaW5jZSBjcmFzaGluZyB0aGUga2VybmVs
IGlzIG5vdCBhbiBvcHRpb24sIHRob3NlIG9wZXJhdGlvbnMgYXJlDQo+ID4gcmVwbGFjZWQgd2l0
aCBhbHRlcm5hdGl2ZSBvcGVyYXRpb25zLg0KPiA+ID4+ICsNCj4gPiA+PiArLi4gdGFibGU6OiBB
cml0aG1ldGljIG9wZXJhdGlvbnMgd2l0aCBwb3NzaWJsZSBleGNlcHRpb25zDQo+ID4gPj4gKw0K
PiA+ID4+ICsgID09PT09ICA9PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPj4gKyAgbmFtZSAgIGNsYXNz
ICAgICAgIG9yaWdpbmFsICAgICAgICAgICAgICAgICAgICAgICByZXBsYWNlbWVudA0KPiA+ID4+
ICsgID09PT09ICA9PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
ID09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPj4gKyAgRElWICAgIEFMVTY0L0FMVSAg
IGRzdCAvPSAwICAgICAgICAgICAgICAgICAgICAgICBkc3QgPSAwDQo+ID4gPj4gKyAgU0RJViAg
IEFMVTY0L0FMVSAgIGRzdCBzLz0gMCAgICAgICAgICAgICAgICAgICAgICBkc3QgPSAwDQo+ID4g
Pj4gKyAgTU9EICAgIEFMVTY0ICAgICAgIGRzdCAlPSAwICAgICAgICAgICAgICAgICAgICAgICBk
c3QgPSBkc3QgKG5vIHJlcGxhY2VtZW50KQ0KPiA+ID4+ICsgIE1PRCAgICBBTFUgICAgICAgICBk
c3QgJT0gMCAgICAgICAgICAgICAgICAgICAgICAgZHN0ID0gKHUzMilkc3QNCj4gPiA+PiArICBT
TU9EICAgQUxVNjQgICAgICAgZHN0IHMlPSAwICAgICAgICAgICAgICAgICAgICAgIGRzdCA9IGRz
dCAobm8gcmVwbGFjZW1lbnQpDQo+ID4gPj4gKyAgU01PRCAgIEFMVSAgICAgICAgIGRzdCBzJT0g
MCAgICAgICAgICAgICAgICAgICAgICBkc3QgPSAodTMyKWRzdA0KPg0KPiBBbGwgb2YgdGhlIGFi
b3ZlIGFyZSBhbHJlYWR5IGNvdmVyZWQgaW4gZXhpc3RpbmcgVGFibGUgNSBhbmQgaW4gbXkgb3Bp
bmlvbg0KPiBkb24ndCBuZWVkIHRvIGJlIHJlcGVhdGVkLg0KPg0KPiBUaGF0IGlzLCB0aGUgIm9y
aWdpbmFsIiBpcyBub3Qgd2hhdCBUYWJsZSA1IGhhcywgc28ganVzdCBpbnRyb2R1Y2VzIGNvbmZ1
c2lvbg0KPiBpbiB0aGUgZG9jdW1lbnQgaW4gbXkgb3Bpbmlvbi4NCj4NCj4gPiA+PiArICBTRElW
ICAgQUxVNjQgICAgICAgZHN0IHMvPSAtMSAoZHN0ID0gTExPTkdfTUlOKSAgIGRzdCA9IExMT05H
X01JTg0KPiA+ID4+ICsgIFNESVYgICBBTFUgICAgICAgICBkc3Qgcy89IC0xIChkc3QgPSBJTlRf
TUlOKSAgICAgZHN0ID0gKHUzMilJTlRfTUlODQo+ID4gPj4gKyAgU01PRCAgIEFMVTY0ICAgICAg
IGRzdCBzJT0gLTEgKGRzdCA9IExMT05HX01JTikgICBkc3QgPSAwDQo+ID4gPj4gKyAgU01PRCAg
IEFMVSAgICAgICAgIGRzdCBzJT0gLTEgKGRzdCA9IElOVF9NSU4pICAgICBkc3QgPSAwDQo+DQo+
IFRoZSBhYm92ZSBmb3VyIGFyZSB0aGUgbmV3IG9uZXMgYW5kIEknZCBwcmVmZXIgYSBzb2x1dGlv
biB0aGF0IG1vZGlmaWVzDQo+IGV4aXN0aW5nIHRhYmxlIDUuICBFLmcuIHRhYmxlIDUgaGFzIG5v
dyBmb3IgU01PRDoNCj4NCj4gZHN0ID0gKHNyYyAhPSAwKSA/IChkc3QgcyUgc3JjKSA6IGRzdA0K
Pg0KPiBhbmQgY291bGQgaGF2ZSBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPg0KPiBkc3QgPSAoc3Jj
ID09IDApID8gZHN0IDogKChzcmMgPT0gLTEgJiYgZHN0ID09IElOVF9NSU4pID8gMCA6IChkc3Qg
cyUgc3JjKSkNCj4NCj4gPiA+IFRoaXMgaXMgYSBncmVhdCBhZGRpdGlvbiB0byB0aGUgZG9jLCBi
dXQgdGhpcyBmaWxlIGlzIGN1cnJlbnRseSBiZWluZw0KPiA+ID4gdXNlZCBhcyBhIGJhc2UgZm9y
IElFVEYgc3RhbmRhcmQgd2hpY2ggaXMgaW4gaXRzIGZpbmFsICJlZGl0IiBzdGFnZQ0KPiA+ID4g
d2hpY2ggbWF5IHJlcXVpcmUgZmV3IHBhdGNoZXMsIHNvIHdlIGNhbm5vdCBsYW5kIGFueSBjaGFu
Z2VzIHRvDQo+ID4gPiBpbnN0cnVjdGlvbi1zZXQucnN0IG5vdCByZWxhdGVkIHRvIHN0YW5kYXJk
aXphdGlvbiB1bnRpbCBSRkMgbnVtYmVyIGlzDQo+ID4gPiBpc3N1ZWQgYW5kIGl0IGJlY29tZXMg
aW1tdXRhYmxlLiBBZnRlciB0aGF0IHRoZSBzYW1lDQo+ID4gPiBpbnN0cnVjdGlvbi1zZXQucnN0
IGZpbGUgY2FuIGJlIHJldXNlZCBmb3IgZnV0dXJlIHJldmlzaW9ucyBvbiB0aGUNCj4gPiA+IHN0
YW5kYXJkLg0KPiA+ID4gSG9wZWZ1bGx5IHRoZSBkcmFmdCB3aWxsIGNsZWFyIHRoZSBmaW5hbCBo
dXJkbGUgaW4gYSBjb3VwbGUgd2Vla3MuDQo+ID4gPiBVbnRpbCB0aGVuOg0KPiA+ID4gcHctYm90
OiBjcg0KPiA+DQo+ID4gU3VyZS4gTm8gcHJvYmxlbS4gV2lsbCByZXN1Ym1pdCBvbmNlIHRoZSBS
RkMgbnVtYmVyIGlzIGlzc3VlZC4NCj4NCj4gSSdtIGFkZGluZyBicGZAaWV0Zi5vcmcgdG8gdGhl
IFRvIGxpbmUgc2luY2UgYWxsIGNoYW5nZXMgaW4gdGhlIHN0YW5kYXJkaXphdGlvbg0KPiBkaXJl
Y3Rvcnkgc2hvdWxkIGluY2x1ZGUgdGhhdCBtYWlsaW5nIGxpc3QuDQo+DQo+IFRoZSBXRyBzaG91
bGQgZGlzY3VzcyB3aGV0aGVyIGFueSBjaGFuZ2VzIHNob3VsZCBiZSBkb25lIHZpYSBhIG5ldyBS
RkMNCj4gdGhhdCBvYnNvbGV0ZXMgdGhlIGZpcnN0IG9uZSwgb3IgYXMgUkZDcyB0aGF0IFVwZGF0
ZSBhbmQganVzdCBkZXNjcmliZSBkZWx0YXMNCj4gKGFkZGl0aW9ucywgZXRjLikuDQo+DQo+IFRo
ZXJlIGFyZSBwcmVjZWRlbnRzIGJvdGggd2F5cyBhbmQgSSBkb24ndCBoYXZlIGEgc3Ryb25nIHBy
ZWZlcmVuY2UsIGJ1dCBJDQo+IGhhdmUgYSB3ZWFrIHByZWZlcmVuY2UgZm9yIGRlbHRhLWJhc2Vk
IG9uZXMgc2luY2UgdGhleSdyZSBzaG9ydGVyIGFuZCBhcmUNCj4gbGVzcyBsaWtlbHkgdG8gcmUt
b3BlbiBkaXNjdXNzaW9uIG9uIHByZXZpb3VzbHkgcmVzb2x2ZWQgaXNzdWVzLCB0aHVzIG9mdGVu
DQo+IHNhdmluZyB0aGUgV0cgdGltZS4NCg0KRGVsdGEtYmFzZWQgYWRkaXRpb25zIG1ha2Ugc2Vu
c2UgdG8gbWUuDQoNCj4NCj4gQWxzbyBGWUkgdG8gTGludXgga2VybmVsIGZvbGtzOg0KPiBXaXRo
IFdHIGFuZCBBRCBhcHByb3ZhbCwgaXQncyBhbHNvIHBvc3NpYmxlIChidXQgbm90IGlkZWFsKSB0
byB0YWtlIGNoYW5nZXMNCj4gYXQgQVVUSDQ4LiAgVGhhdCdkIGJlIHVwIHRvIHRoZSBjaGFpcnMg
YW5kIEFEIHRvIGRlY2lkZSB0aG91Z2gsIGFuZCBub3JtYWxseQ0KPiB0aGF0J3MganVzdCBmb3Ig
cHVyZWx5IGVkaXRvcmlhbCBjbGFyaWZpY2F0aW9ucywgZS5nLiwgdG8gY29uZnVzaW9uIGNhbGxl
ZCBvdXQgYnkgdGhlDQo+IFJGQyBlZGl0b3IgcGFzcy4NCg0KQWxzbyBhZ3JlZS4gV2Ugc2hvdWxk
IGtlZXAgQVVUSCBnb2luZyBpdHMgY291cnNlIGFzLWlzLg0KQWxsIElTQSBhZGRpdGlvbnMgY2Fu
IGJlIGluIHRoZSBmdXR1cmUgZGVsdGEgUkZDLg0KDQpBcyBmYXIgYXMgZmlsZSBsb2dpc3RpY3Mu
Li4gbXkgcHJlZmVyZW5jZSBpcyB0byBrZWVwDQpEb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6
YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KdXAgdG8gZGF0ZS4NClJpZ2h0IG5vdyBpdCdzIGVm
ZmVjdGl2ZWx5IGZyb3plbiB3aGlsZSBhd2FpdGluZyBjaGFuZ2VzIChpZiBhbnkpDQpuZWNlc3Nh
cnkgZm9yIEFVVEguIEFmdGVyIG9mZmljaWFsIFJGQyBpcyBpc3N1ZWQNCndlIGNhbiBzdGFydCBs
YW5kaW5nIHBhdGNoZXMgaW50byBpbnN0cnVjdGlvbi1zZXQucnN0IGFuZA0KZ2l0IGRpZmYgMDRl
ZmFlYmQ3MmQxLi53aGF0ZXZlcl9mdXR1cmVfc2hhIGluc3RydWN0aW9uLXNldC5yc3QNCndpbGwg
YXV0b21hdGljYWxseSBnZW5lcmF0ZSB0aGUgZnV0dXJlIGRlbHRhIFJGQy4NCk9uY2UgUkZDIG51
bWJlciBpcyBpc3N1ZWQgd2UgY2FuIGFkZCBhIGdpdCB0YWcgZm9yIHRoZSBwYXJ0aWN1bGFyDQpz
aGEgdGhhdCB3YXMgdGhlIGJhc2UgZm9yIFJGQyBhcyBhIGRvY3VtZW50YXRpb24gc3RlcCBhbmQg
dG8NCnNpbXBsaWZ5IGZ1dHVyZSAnZ2l0IGRpZmYnLg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAt
LSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVA
aWV0Zi5vcmcK

