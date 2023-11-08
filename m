Return-Path: <bpf+bounces-14471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0567E531E
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 11:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E24281363
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF4B10A12;
	Wed,  8 Nov 2023 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="JgPX+xm2";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="JgPX+xm2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="Znr7lJto"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52021FC0B
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 10:14:01 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E0172D
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 02:14:00 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 928E8C1D2D82
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699438440; bh=C72fl0Vgm3FZ+QsCSp9doIjS2vv9lSq2jsTfSPzEROQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=JgPX+xm28nTOevFr1Ju4fVmIqGAx/VLZNOxAf3aDK6VP9bw7IyUpdfOOulRaNhXp2
	 bmryDtrtaaSzGsGJktTi9glUWsihf47v6mO6pK2e5Rom+ps/XgfJik0nvRhnsIVt3J
	 50xcPTOp/m6fm3uVM5hIQGq4Cy+Ne0/V4w+NDUTM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Nov  8 02:14:00 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6E694C17DBF0;
	Wed,  8 Nov 2023 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699438440; bh=C72fl0Vgm3FZ+QsCSp9doIjS2vv9lSq2jsTfSPzEROQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=JgPX+xm28nTOevFr1Ju4fVmIqGAx/VLZNOxAf3aDK6VP9bw7IyUpdfOOulRaNhXp2
	 bmryDtrtaaSzGsGJktTi9glUWsihf47v6mO6pK2e5Rom+ps/XgfJik0nvRhnsIVt3J
	 50xcPTOp/m6fm3uVM5hIQGq4Cy+Ne0/V4w+NDUTM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 895BCC17DBF0
 for <bpf@ietfa.amsl.com>; Wed,  8 Nov 2023 02:13:59 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.903
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uDFnZPhty3KV for <bpf@ietfa.amsl.com>;
 Wed,  8 Nov 2023 02:13:55 -0800 (PST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 68E3DC17060F
 for <bpf@ietf.org>; Wed,  8 Nov 2023 02:13:50 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d093265dfso41005256d6.3
 for <bpf@ietf.org>; Wed, 08 Nov 2023 02:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699438429; x=1700043229;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39MBlWaOCdGM2CMyzhbTOZ0nGzKaJYGTIKNBLjZ93vU=;
 b=Znr7lJtobcZk0R+PC1Mfseykv1/obzrz6mcAf0Q4POlPhqMxUtSZs9MdKF+JGIBDtc
 QFchhzHk7H9itNkzlY14xG/b89KqLg4xo5qHuJ+EY+8+3cmfs7K1478crNYhAE6VLvG0
 tV6yWinMoLCGA6J4KmL8vR5Dxjh91uH7/p8VKbJn/ljxhlhxsL9nzs+dVAOCNLr6Wm3b
 ri7FqVFZyqIlDc0owXHdTXXa0sh96Ngx8+OVCNZC9aY+jOoPx3oqOSy69cYru5+9Kb58
 7w/PrnPmAlqZ0CV4OEpIsLi6XCa7gvzzVXeKKw7rl6rDalVCbnsL4Sq3X5/z71XDKb5r
 TgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438429; x=1700043229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39MBlWaOCdGM2CMyzhbTOZ0nGzKaJYGTIKNBLjZ93vU=;
 b=RhBzYmrAtjg33oy7dlJZ4suqQqAZxPW6bLg/wbcBPmJmdjL4SDSPtCFx9zwvITiwLe
 9SBeJIbTfq0X1TCK9dTBlobHSLHgd42uBe9nTJFmXJR2T33LCgQ2tR2DQwLvZtpn/hrz
 8glROmkAxXTaAMBRIPArZlRO6Rdt99lmqG7Z8ZqHSkUIJYJsmFIer1jn5baN4Lvh0+3W
 2RTZ/7Mmp4KiO77By6QZRsUd+QL+HopqYlKi7oN6DQRz7BJ3EpJusdrEL7XslCp4yRk3
 SNepBe1P2GUBB5bY/3JqIhydmzHD5gapBccao3kwf8cQRyv/RYnTFizp3J1ROm+C1lTB
 becw==
X-Gm-Message-State: AOJu0YzctAnlU60Kkv7RR3UbwDqOIHVgx9+j7nLt8TlNoWTdSjbh9X9v
 6VnjFs+O3U+HBpopevRlAiGrxSzfow8Jq0pYhly2cj5xuAUR/f8tG3g=
X-Google-Smtp-Source: AGHT+IGqEJoddOk+W6TxKpGKidbrVC9EhhunuqTwpTmxxS0zCUx2ITyge7014RJCSs7nSeX67WLDONGAzI1WlQ0sI0g=
X-Received: by 2002:a05:6214:2509:b0:65b:150e:604b with SMTP id
 gf9-20020a056214250900b0065b150e604bmr1407230qvb.49.1699438428743; Wed, 08
 Nov 2023 02:13:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr>
 <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
 <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
 <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
 <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
 <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
In-Reply-To: <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 8 Nov 2023 05:13:37 -0500
Message-ID: <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/f_g99rRZV1dPppcbt-QXX95XtHg>
Subject: Re: [Bpf] [PATCH v3] bpf,
 docs: Add additional ABI working draft base text
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gVHVlLCBOb3YgNywgMjAyMyBhdCA4OjE34oCvUE0gQWxleGVpIFN0YXJvdm9pdG92CjxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgTm92IDcsIDIwMjMg
YXQgMTE6NTbigK9BTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPgo+
ID4gT24gTW9uLCBOb3YgNiwgMjAyMyBhdCAzOjM44oCvQU0gQWxleGVpIFN0YXJvdm9pdG92Cj4g
PiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFN1
biwgTm92IDUsIDIwMjMgYXQgNDoxN+KAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNy
PiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFN1biwgTm92IDUsIDIwMjMgYXQgNDo1MeKAr0FN
IEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29t
PiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBGcmksIE5vdiAzLCAyMDIzIGF0IDI6MjDi
gK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ID4gK1RoZSBBQkkgaXMgc3BlY2lmaWVkIGluIHR3byBwYXJ0czogYSBnZW5lcmlj
IHBhcnQgYW5kIGEgcHJvY2Vzc29yLXNwZWNpZmljIHBhcnQuCj4gPiA+ID4gPiA+ICtBIHBhaXJp
bmcgb2YgZ2VuZXJpYyBBQkkgd2l0aCB0aGUgcHJvY2Vzc29yLXNwZWNpZmljIEFCSSBmb3IgYSBj
ZXJ0YWluCj4gPiA+ID4gPiA+ICtpbnN0YW50aWF0aW9uIG9mIGEgQlBGIG1hY2hpbmUgcmVwcmVz
ZW50cyBhIGNvbXBsZXRlIGJpbmFyeSBpbnRlcmZhY2UgZm9yIEJQRgo+ID4gPiA+ID4gPiArcHJv
Z3JhbXMgZXhlY3V0aW5nIG9uIHRoYXQgbWFjaGluZS4KPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
PiArVGhpcyBkb2N1bWVudCBpcyB0aGUgZ2VuZXJpYyBBQkkgYW5kIHNwZWNpZmllcyB0aGUgcGFy
YW1ldGVycyBhbmQgYmVoYXZpb3IKPiA+ID4gPiA+ID4gK2NvbW1vbiB0byBhbGwgaW5zdGFudGlh
dGlvbnMgb2YgQlBGIG1hY2hpbmVzLiBJbiBhZGRpdGlvbiwgaXQgZGVmaW5lcyB0aGUKPiA+ID4g
PiA+ID4gK2RldGFpbHMgdGhhdCBtdXN0IGJlIHNwZWNpZmllZCBieSBlYWNoIHByb2Nlc3Nvci1z
cGVjaWZpYyBBQkkuCj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gK1RoZXNlIHBzQUJJcyBhcmUg
dGhlIHNlY29uZCBwYXJ0IG9mIHRoZSBBQkkuIEVhY2ggaW5zdGFudGlhdGlvbiBvZiBhIEJQRgo+
ID4gPiA+ID4gPiArbWFjaGluZSBtdXN0IGRlc2NyaWJlIHRoZSBtZWNoYW5pc20gdGhyb3VnaCB3
aGljaCBiaW5hcnkgaW50ZXJmYWNlCj4gPiA+ID4gPiA+ICtjb21wYXRpYmlsaXR5IGlzIG1haW50
YWluZWQgd2l0aCByZXNwZWN0IHRvIHRoZSBpc3N1ZXMgaGlnaGxpZ2h0ZWQgYnkgdGhpcwo+ID4g
PiA+ID4gPiArZG9jdW1lbnQuIEhvd2V2ZXIsIHRoZSBkZXRhaWxzIHRoYXQgbXVzdCBiZSBkZWZp
bmVkIGJ5IGEgcHNBQkkgYXJlIGEgbWluaW11bSAtLQo+ID4gPiA+ID4gPiArYSBwc0FCSSBtYXkg
c3BlY2lmeSBhZGRpdGlvbmFsIHJlcXVpcmVtZW50cyBmb3IgYmluYXJ5IGludGVyZmFjZSBjb21w
YXRpYmlsaXR5Cj4gPiA+ID4gPiA+ICtvbiBhIHBsYXRmb3JtLgo+ID4gPiA+ID4KPiA+ID4gPiA+
IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNheSBpbiB0aGUgYWJv
dmUuCj4gPiA+ID4gPiBJbiBteSBtaW5kIHRoZXJlIGlzIG9ubHkgb25lIEJQRiBwc0FCSSBhbmQg
aXQgZG9lc24ndCBoYXZlCj4gPiA+ID4gPiBnZW5lcmljIGFuZCBwcm9jZXNzb3IgcGFydHMuIFRo
ZXJlIGlzIG9ubHkgb25lICJwcm9jZXNzb3IiLgo+ID4gPiA+ID4gQlBGIGlzIHN1Y2ggYSBwcm9j
ZXNzb3IuCj4gPiA+ID4KPiA+ID4gPiBXaGF0IEkgd2FzIHRyeWluZyB0byBzYXkgd2FzIHRoYXQg
dGhlIGRvY3VtZW50IGhlcmUgZGVzY3JpYmVzIGEKPiA+ID4gPiBnZW5lcmljIEFCSS4gSW4gdGhp
cyBkb2N1bWVudCB0aGVyZSB3aWxsIGJlIGFyZWFzIHRoYXQgYXJlIHNwZWNpZmljIHRvCj4gPiA+
ID4gZGlmZmVyZW50IGltcGxlbWVudGF0aW9ucyBhbmQgdGhvc2Ugd291bGQgYmUgY29uc2lkZXJl
ZCBwcm9jZXNzb3IKPiA+ID4gPiBzcGVjaWZpYy4gSW4gb3RoZXIgd29yZHMsIHRoZSB1YnBmIHJ1
bnRpbWUgY291bGQgZGVmaW5lIHRob3NlIHRoaW5ncwo+ID4gPiA+IGRpZmZlcmVudGx5IHRoYW4g
dGhlIHJicGYgcnVudGltZSB3aGljaCwgaW4gdHVybiwgY291bGQgZGVmaW5lIHRob3NlCj4gPiA+
ID4gdGhpbmdzIGRpZmZlcmVudGx5IHRoYW4gdGhlIGtlcm5lbCdzIGltcGxlbWVudGF0aW9uLgo+
ID4gPgo+ID4gPiBJIHNlZSB3aGF0IHlvdSBtZWFuLiBUaGVyZSBpcyBvbmx5IG9uZSBCUEYgcHNB
QkkuIFRoZXJlIGNhbm5vdCBiZSB0d28uCj4gPiA+IHVicGYgY2FuIGRlY2lkZSBub3QgdG8gZm9s
bG93IGl0LCBidXQgaXQgY291bGQgb25seSBtZWFuIHRoYXQKPiA+ID4gaXQncyBub24gY29uZm9y
bWFudCBhbmQgbm90IGNvbXBhdGlibGUuCj4gPgo+ID4gT2theS4gVGhhdCB3YXMgbm90IGhvdyBJ
IHdhcyBzdHJ1Y3R1cmluZyB0aGUgQUJJLiBJIHRob3VnaHQgd2UgaGFkCj4gPiBkZWNpZGVkIHRo
YXQsIGFzIHRoZSBkb2N1bWVudCBzYWlkLCBhbiBpbnN0YW50aWF0aW9uIG9mIGEgbWFjaGluZSBo
YWQKPiA+IHRvCj4gPgo+ID4gMS4gbWVldCB0aGUgZ0FCSQo+ID4gMi4gc3BlY2lmeSBpdHMgcmVx
dWlyZW1lbnRzIHZpcyBhIHZpcyB0aGUgcHNBQkkKPiA+IDMuIChvcHRpb25hbGx5KSBkZXNjcmli
ZSBvdGhlciByZXF1aXJlbWVudHMuCj4gPgo+ID4gSWYgdGhhdCBpcyBub3Qgd2hhdCB3ZSBkZWNp
ZGVkIHRoZW4gd2Ugd2lsbCBoYXZlIHRvIHJlc3RydWN0dXJlIHRoZSBkb2N1bWVudC4KPgo+IFRo
aXMgYWJpLnJzdCBmaWxlIGlzIHRoZSBiZWdpbm5pbmcgb2YgIkJQRiBwc0FCSSIgZG9jdW1lbnQu
Cj4gV2UgcHJvYmFibHkgc2hvdWxkIHJlbmFtZSBpdCB0byBwc2FiaS5yc3QgdG8gYXZvaWQgY29u
ZnVzaW9uLgo+IFNlZSBteSBzbGlkZXMgZnJvbSBJRVRGIDExOC4gSSBob3BlIHRoZXkgZXhwbGFp
biB3aGF0ICJCUEYgcHNBQkkiIGlzIGZvci4KCk9mIGNvdXJzZSB0aGV5IGRvISBUaGFuayB5b3Uh
IE15IG9ubHkgcXVlc3Rpb246IEluIHRoZSBsYW5ndWFnZSBJIHdhcwp1c2luZywgSSB3YXMgdGFr
aW5nIGEgY3VlIGZyb20gdGhlIFN5c3RlbSBWIHdvcmxkIHdoZXJlIHRoZXJlIGlzIGEKR2VuZXJp
YyBBQkkgYW5kIGEgcHNBQkkuIFRoZSBHZW5lcmljIEFCSSBhcHBsaWVzIHRvIGFsbCBTeXN0ZW0g
Vgpjb21wYXRpYmxlIHN5c3RlbXMgYW5kIGRlZmluZXMgY2VydGFpbiBwcm9jZXNzb3Itc3BlY2lm
aWMgZGV0YWlscyB0aGF0CmVhY2ggcGxhdGZvcm0gbXVzdCBzcGVjaWZ5IHRvIGRlZmluZSBhIGNv
bXBsZXRlIEFCSS4gSW4gcGFydGljdWxhciwgSQp0b29rIHRoaXMgbGFuZ3VhZ2UgYXMgaW5zcGly
YXRpb24KCiIiIgpUaGUgU3lzdGVtIFYgQUJJIGlzIGNvbXBvc2VkIG9mIHR3byBiYXNpYyBwYXJ0
czogQSBnZW5lcmljIHBhcnQgb2YgdGhlCnNwZWNpZmljYXRpb24gZGVzY3JpYmVzIHRob3NlIHBh
cnRzIG9mIHRoZSBpbnRlcmZhY2UgdGhhdCByZW1haW4KY29uc3RhbnQgYWNyb3NzIGFsbCBoYXJk
d2FyZSBpbXBsZW1lbnRhdGlvbnMgb2YgU3lzdGVtIFYsIGFuZCBhCnByb2Nlc3Nvci1zcGVjaWZp
YyBwYXJ0IG9mIHRoZSBzcGVjaWZpY2F0aW9uIGRlc2NyaWJlcyB0aGUgcGFydHMgb2YKdGhlIHNw
ZWNpZmljYXRpb24gdGhhdCBhcmUgc3BlY2lmaWMgdG8gYSBwYXJ0aWN1bGFyIHByb2Nlc3Nvcgph
cmNoaXRlY3R1cmUuIFRvZ2V0aGVyLCB0aGUgZ2VuZXJpYyBBQkkgKG9yIGdBQkkpIGFuZCB0aGUg
cHJvY2Vzc29yCnNwZWNpZmljIHN1cHBsZW1lbnQgKG9yIHBzQUJJKSBwcm92aWRlIGEgY29tcGxl
dGUgaW50ZXJmYWNlCnNwZWNpZmljYXRpb24gZm9yIGNvbXBpbGVkIGFwcGxpY2F0aW9uIHByb2dy
YW1zIG9uIHN5c3RlbXMgdGhhdCBzaGFyZQphIGNvbW1vbiBoYXJkd2FyZSBhcmNoaXRlY3R1cmUu
CiIiIgoKU2VlIFsxXS4KCklmIHlvdSB3YW50IHRoaXMgZG9jdW1lbnQgdG8ganVzdCBiZSB0aGUg
cHNBQkkgZm9yIExpbnV4LCB0aGVuIHRoYXQgaXMKd2hhdCB3ZSB3aWxsIGRvIC0tIHlvdSBhcmUg
dGhlIGV4cGVydCBhbmQgSSBhbSBqdXN0IHRoZSBkcmFmdGVyLgoKWzFdIGh0dHBzOi8vd3d3LnNj
by5jb20vZGV2ZWxvcGVycy9nYWJpLwpXaWxsCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0
Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

