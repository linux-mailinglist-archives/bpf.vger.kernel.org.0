Return-Path: <bpf+bounces-21359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0590184BB39
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2792A1C24C8E
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290D6116;
	Tue,  6 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ha58QylZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="IECVLxIR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="njz9vdQF"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659753A6
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237777; cv=none; b=dviusW9d9Infhl5HytGZmf9+pKP5Oiazd3UES17f/ogIZVz/FyJBe3rdpZiKUMyjmloS7Ohr/FWGW2p0l4c5T9vXgk7lT3fBLK3lUTaFT13UDGWbzBk3BYWzaP3NgpPg9gcJ+XfMySnN+JNVqVY8c9kU91HII2c9y7F2iaZPNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237777; c=relaxed/simple;
	bh=97f+0F8nJdJv0sS5chOkVjGIyDM2NL9XOLmE2+YIQ74=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=GC4MB/LdJWiQnoVdeDV06VT0dzMYqLjBJIOuTF5RCy4a36CVaWbd1nA03dyj2iV/un/vx5LVCCwPBdbcoEnsGYHPAX862mACAESNG8KQuO01FChpSwW+ATI2EeBTRWwC76QQShXXQW6TzqqoHqWfQvdYQqZ/SjpQMiF4xOwxDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ha58QylZ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=IECVLxIR reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=njz9vdQF reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9E65EC1DF553
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707237769; bh=97f+0F8nJdJv0sS5chOkVjGIyDM2NL9XOLmE2+YIQ74=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ha58QylZjUG4SfbsOTdiYFXGzAqT7iUIEFrDr7s8pb3cejJ3DZZF0KOLK/O9EnkNP
	 2X+pqT9i9EQCwoficYKzW0w2AdykRVL4IeWeJnLm8tecQFoKfRusZCmkieCNcpFtf0
	 AIVOild4h6h5e5m8V4DDb2xQ0rPxBE8SfdsKWJ54=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 50646C1C6340;
 Tue,  6 Feb 2024 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707237769; bh=97f+0F8nJdJv0sS5chOkVjGIyDM2NL9XOLmE2+YIQ74=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=IECVLxIRSg+CfFNt/yv2YMPxjEPIEPXRqnExDiJxH3/c5TfOhL8ljnR4V8kUoigN3
 PvTaHkybzGzp9RHFVPcB+BI3gq5IEjmZ/6JatRtxxDqxWYEAiBrpBbaHgdiAS9GIEf
 UdvsS4WA2ag+VWMMatqKcGf7tp0XGfI6tDz2O46o=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 75273C18DBBA
 for <bpf@ietfa.amsl.com>; Tue,  6 Feb 2024 08:42:48 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x9t2RaidhJtk for <bpf@ietfa.amsl.com>;
 Tue,  6 Feb 2024 08:42:44 -0800 (PST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9742DC151099
 for <bpf@ietf.org>; Tue,  6 Feb 2024 08:42:44 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2184133da88so3347613fac.0
 for <bpf@ietf.org>; Tue, 06 Feb 2024 08:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707237763; x=1707842563; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FtVIdTx2855fysMh9Epuxu66E/a8+cgXbRUXIZwycHo=;
 b=njz9vdQFGuN8r3z16+zTSI106cMyZfdrvJga6n7KYDhCtNfblQIPGpT8pUEK8lXeXC
 EFrGI5zjj6HDSL961YtdVotU+K5W1cgEerS24V+ziqB7ZUgb6qdpWf9jLzcD155M9mS6
 0kYoP4udC0wW14GrvL66QEKLj75TMuLbCtzpwMozeAXxEvx0SQVM7BhY0rm/ziwvRxTJ
 BAjeyDMX8Yue3eUrMkN3ZhCeKEtPlv/hUVBTLR8LJkrADVdCAIkEakHYqSkDMqnWwPOW
 ln/NuHA7si/B+VgY11BrjuOIDybG7AK2nv0TeMR/MG+9BDxF07zaGtOxbbrcXJC9SuGy
 Dd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237763; x=1707842563;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FtVIdTx2855fysMh9Epuxu66E/a8+cgXbRUXIZwycHo=;
 b=aqWQQN5Ji7BMeN8SehfEuL2sQmbmv7eiXBB+DL9VeG9YhuGmTpuSWM8V1ykDAM8T7+
 JZ+cok0jXog5mZHGqveQfRiKIIh/PJs9GfxaHIyXTQVrBzUxiEgEegTW45zIOVK6rX05
 ddIO/fS+FInbfLfi9D8RtAKzGw/Mv4wGrdMhKVUijxA3gmxXD3EBcjEWGZMFlu8iGpTI
 ehReUdGMvB3YclZY4b4hda/VPt4ravahfMXMVtlJUSluZxChh2ZQ30zeDhnURc+6pCRd
 6h9XTItpOXkmxXtStVo8JTLWOJ1UW5S4A4TE1AJbxd9Stmrxq8dA+MWfUmy5wRD/vwal
 Z4IA==
X-Gm-Message-State: AOJu0YzGT8fuXOKxGnqy3egXqF2aieFfyT3y7AQYxCOoMrZe3h7LH3sL
 PhxKfUdVRViIGXA4ORUUdYVaWSDOemX0wvZReTY7C6raD2nU8Qbh
X-Google-Smtp-Source: AGHT+IFkp7C+0sIDFa5q9i23dU5VJ2r2+czF/qZi6QQeSZmTolVqM6ArnoDgNOPLMs3ucDxVg2Bkpg==
X-Received: by 2002:a05:6871:821:b0:218:f4fa:bcca with SMTP id
 q33-20020a056871082100b00218f4fabccamr3131361oap.51.1707237763495; 
 Tue, 06 Feb 2024 08:42:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUaGe7D0IhXmqUOdVz3g/CJcUIzjgjM6u/zyatYnuvx84rp9QXUdRpkasED/z12EvEyz7NuPfTcwrvWKqjMlBpX9qwy3GiFzPzjUWXgas4dQMP6QwD91tLqCQ2ZRF4=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 dh1-20020a056830484100b006e1205d4578sm372390otb.23.2024.02.06.08.42.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:42:43 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
Cc: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com>
 <87wmrqiotx.fsf@oracle.com>
 <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
In-Reply-To: <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
Date: Tue, 6 Feb 2024 08:42:41 -0800
Message-ID: <0d8301da591b$813d05a0$83b710e0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLEYKQbFH8DoKfsRCUXp0fT6URjgIX5UybAepfDASw+/3ZUA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/e_CvtuiMXu09udqg7JJPF761dRk>
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
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZTog
Cj4gT24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMTE6NDnigK9BTSBKb3NlIEUuIE1hcmNoZXNpCj4g
PGpvc2UubWFyY2hlc2lAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPiA+IGNsYW5nIGdlbmVyYXRlcyBC
UEYgY29kZSB3aXRoIG9wY29kZSAweDhkIChCUEZfQ0FMTCB8IEJQRl9YLCB3aGljaAo+ID4gPiBp
dCBjYWxscyAiY2FsbHgiKSwgd2hlbiBjb21waWxpbmcgd2l0aCAtTzAgb3IgLU8xLiAgT2YgY291
cnNlIC1PMiBpcwo+ID4gPiByZWNvbW1lbmRlZCwgYnV0IGlmIGFueW9uZSBsYXRlciBkZWZpbmVz
IG9wY29kZSAweDhkIGZvciBhbnl0aGluZwo+ID4gPiBvdGhlciB0aGFuIHdoYXQgY2xhbmcgbWVh
bnMgYnkgaXQsIGl0IGNvdWxkIGNhdXNlIHByb2JsZW1zLgo+ID4KPiA+IEdDQyBhbHNvIGdlbmVy
YXRlcyBCUEZfQ0FMTHxCUEZfWCBhbHNvIG5hbWVkIGNhbGx4LCBidXQgb25seSBpZiB0aGUKPiA+
IGV4cGVyaW1lbnRhbCAtbXhicGYgb3B0aW9uIGlzIHBhc3NlZCB0byB0aGUgY29tcGlsZXIuCj4g
Pgo+ID4gSSByZWNvbW1lbmQgdGhpcyBwYXJ0aWN1bGFyIGVuY29kaW5nIHRvIGJlIHNwZWNpZmlj
YWxseSByZXNlcnZlZCBmb3IgYQo+ID4gZnV0dXJlIGBjYWxsIFJFRycgZm9yIHdoZW4vaWYgYSB0
aW1lIGNvbWVzIHdoZW4gdGhlIEJQRiB2ZXJpZmllcgo+ID4gc3VwcG9ydHMgc29tZSBmb3JtIG9m
IGluZGlyZWN0IGNhbGxzLgo+IAo+ICsxLgo+IFNhbWUgdGhpbmtpbmcgZnJvbSBsbHZtIHBvdi4K
PiBDQUxMfFggaXMgd2hhdCB3ZSB3aWxsIHVzZSB3aGVuIHRoZSBrZXJuZWwgc3VwcG9ydHMgaW5k
aXJlY3QgY2FsbHMuCj4gSSB0aGluayBpdCBtZWFucyB3ZSBuZWVkIHRvIGFkZCBhICdyZXNlcnZl
ZCcgY2F0ZWdvcnkgdG8gdGhlIHNwZWMuCgpNeSByZWFkaW5nIG9mIHRoaXMgdGhyZWFkIGlzIHRo
YXQgdGhlcmUgc2VlbXMgdG8gYmUgY29uc2Vuc3VzIHRoYXQ6CjEpIENBTEx8WCBzaG91bGQgaGF2
ZSBhbiBlbnRyeSBpbiB0aGUgSUFOQSByZWdpc3RyeSB3aXRoIGl0cyBvd24gY29uZm9ybWFuY2Ug
Z3JvdXAsCjIpIFRoZSBpbnRlbmRlZCBtZWFuaW5nIGlzIHVuZGVyc3Rvb2QsCjMpIGNsYW5nIGFu
ZCBnY2MgYm90aCBpbXBsZW1lbnQgaXQgYWxyZWFkeSB3aXRoIHRoZSBpbnRlbmRlZCBtZWFuaW5n
LAo0KSBUaGUgTGludXgga2VybmVsIG1pZ2h0IHN1cHBvcnQgaXQgc29tZWRheS4KCkknZCBwcm9w
b3NlIHdlIG1ha2UgaXQgaXRzIG93biBjb25mb3JtYW5jZSBncm91cCBjYWxsZWQgImNhbGx4IiwK
d2hpY2ggb2YgY291cnNlIHRoZSBMaW51eCBrZXJuZWwgZG9lcyBub3QgeWV0IHN1cHBvcnQsIGJ1
dCBjbGFuZyBhbmQgZ2NjIGRvLgoKUmF0aW9uYWxlOgoqIFRoZXJlIG1heSBiZSBvdGhlciBpbnN0
cnVjdGlvbnMgcmVzZXJ2ZWQgb3ZlciB0aW1lIGluIHRoZSBmdXR1cmUgc28KICAgdXNpbmcgYSBt
b3JlIHNwZWNpZmljIG5hbWUgdGhhbiBqdXN0ICJyZXNlcnZlZCIgaXMgZ29vZCBzaW5jZSBsYXRl
cgogICBhZGRpdGlvbnMgcmVxdWlyZSBuZXcgZ3JvdXBzIHdpdGggZGlmZmVyZW50IG5hbWVzLgoq
IERlZmluaW5nIGl0IG5vdyB3aXRoIHRoZSBtZWFuaW5nIGFscmVhZHkgaW1wbGVtZW50ZWQgYnkg
Y2xhbmcgJiBnY2MKICAgbWVhbnMgdGhhdCBubyBjaGFuZ2VzIGFyZSBuZWVkZWQgbGF0ZXIgb25j
ZSBMaW51eCBzdXBwb3J0cyBpdC4KKiBlYnBmLWZvci13aW5kb3dzIGlzIGxpa2VseSB0byBzdGFy
dCBzdXBwb3J0aW5nIGl0IGluIHRoZSB2ZXJ5IG5lYXIgZnV0dXJlCiAgIGFzIGEgcmVzdWx0IG9m
IHRoaXMgdGhyZWFkLiBUaGVyZSBpcyBhbHJlYWR5IGEgZ2l0aHViIHB1bGwgcmVxdWVzdCB1bmRl
cgogICByZXZpZXcgdG8gYWRkIHN1cHBvcnQgZm9yIGl0IGluIHRoZSBQUkVWQUlMIHZlcmlmaWVy
LgoKRGF2ZQogCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cu
aWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

