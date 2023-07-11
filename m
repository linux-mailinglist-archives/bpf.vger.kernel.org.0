Return-Path: <bpf+bounces-4715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D99D74E535
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5912815B4
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC293D81;
	Tue, 11 Jul 2023 03:19:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA323D70
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:19:32 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C1BC
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:19:30 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 836B9C17EE12
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689045570; bh=wJd0JlMVvOpGeFmDptHUNQG8HBuEID+hMcA3eweoJZE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VBuLKEQT/FxnZlwI/Oq8JTku4DECIx2VpjcfPgoxn7bLxmwPbAkUUut/mWdiKo9+4
	 PvscGdJnVOeLvkFT9932Hwer18oSVAZNNv3sqkV6VLywRDLSlMk+/RrgngARLIUx0j
	 Z+Luq+lEo/CSJ3hw4MvxtuQ8zVVfiCiJS58tZX88=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 20:19:30 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 499BCC1782A0;
	Mon, 10 Jul 2023 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689045570; bh=wJd0JlMVvOpGeFmDptHUNQG8HBuEID+hMcA3eweoJZE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VBuLKEQT/FxnZlwI/Oq8JTku4DECIx2VpjcfPgoxn7bLxmwPbAkUUut/mWdiKo9+4
	 PvscGdJnVOeLvkFT9932Hwer18oSVAZNNv3sqkV6VLywRDLSlMk+/RrgngARLIUx0j
	 Z+Luq+lEo/CSJ3hw4MvxtuQ8zVVfiCiJS58tZX88=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9314DC1782A0
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 20:19:29 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.895
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PMre1Gwoqq6i for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 20:19:25 -0700 (PDT)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9A6A2C169530
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:19:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-635dc2f6ef9so34281076d6.3
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689045564; x=1691637564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ik5uHaugDoEAFveCczUWTAZcELGLKgFykeSVZ7+OeIo=;
 b=BvPLe5RPZzpO48IpCOe9aHW+oSte1l+UTQzYffP43/qA97HEuGx5uaUm9vU4LT4Tb7
 83WtyeSQ0RBAm8UrLwbP1JwxLFlK/T9G1Y10TgTiHvKMYm5lmDgx2V21+tydwfZr1d39
 eDyBEffYhUM06hno8pVyxWo17ZtZMQEcXZECjkFerkeMZ1c9RrMXZRECFTTW96oce9oa
 mVOLGLlxd9I5czmlmFpSRKqSm+lDId7S3eylp/SgiDyLPDz/lPvIdSoy5KH+VB9fAa5h
 HiXvtQAJjF/4AMjgHXOYmFMbJ1/vklUk8DGlY2OW3ChxBEIu9/eYzm76lIshQAp97sWZ
 qeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689045564; x=1691637564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ik5uHaugDoEAFveCczUWTAZcELGLKgFykeSVZ7+OeIo=;
 b=fLociIriXjH6V4ldMwQRiftZt+INd8LC+L1GaCOuYh/+JCUN5E9qlsBI3g8z3/GAAv
 XfxsMg2idmExkWuQAMPXaJwiR8jUlRAc1Rx7B7EvcVcDME2TzrJGM2JE2GY8DUcsn54w
 x025VE61kWG4gorVraZBplMGtTY5Ee4jL8Wm7onEF1eWYH/EucJylG6250R8hZGDmlaw
 go6rEzJSTgx7sKMa2PpSj6FPeKR4DPb+2a3RmuX6EI7Uxr9hX4f0/K+ZN1JiGngXrEss
 cUddYeVtPW2BgQEOBmdcMiZ30WlhfkNacvxOeRHTQ9/gedqcrq1ijSia0Eed9UrctK/O
 qC1A==
X-Gm-Message-State: ABy/qLaWzGicTYwM0vLWAhGD1su+A4uLxE5fbRU8YwqQH14VnF3IkFp9
 Gbrm+ek1F7ejandOnQZAQtfr4GIU+4hLkdk56CyhRA==
X-Google-Smtp-Source: APBJJlG1AMIvBJeo0PJxRleyGNGt2oI49pWla0Y6J61AAqFFqdDbsO4kc0PyXW8NNs4kUamT0j73QYuQf2eLtSAlej8=
X-Received: by 2002:a0c:cb87:0:b0:636:4e70:5425 with SMTP id
 p7-20020a0ccb87000000b006364e705425mr10644825qvk.54.1689045564524; Mon, 10
 Jul 2023 20:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr>
 <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
In-Reply-To: <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 23:19:14 -0400
Message-ID: <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Y1hiwT2Nmzfam_1TKwNkBEir274>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Specify twos complement as format for signed integers
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
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6MDDigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPGFs
ZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMTAsIDIw
MjMgYXQgMjo1OOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+
Cj4gPiBJbiB0aGUgZG9jdW1lbnRhdGlvbiBvZiB0aGUgZUJQRiBJU0EgaXQgaXMgdW5zcGVjaWZp
ZWQgaG93IGludGVnZXJzIGFyZQo+ID4gcmVwcmVzZW50ZWQuIFNwZWNpZnkgdGhhdCB0d29zIGNv
bXBsZW1lbnQgaXMgdXNlZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBXaWxsIEhhd2tpbnMgPGhh
d2tpbnN3QG9icy5jcj4KPiA+IC0tLQo+ID4gIERvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9u
LXNldC5yc3QgfCA1ICsrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0
IGIvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gaW5kZXggNzUxZTY1
Nzk3M2YwLi42M2RmY2JhNWViOWEgMTAwNjQ0Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2JwZi9p
bnN0cnVjdGlvbi1zZXQucnN0Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlv
bi1zZXQucnN0Cj4gPiBAQCAtMTczLDYgKzE3MywxMSBAQCBCUEZfQVJTSCAgMHhjMCAgIHNpZ24g
ZXh0ZW5kaW5nIGRzdCA+Pj0gKHNyYyAmIG1hc2spCj4gPiAgQlBGX0VORCAgIDB4ZDAgICBieXRl
IHN3YXAgb3BlcmF0aW9ucyAoc2VlIGBCeXRlIHN3YXAgaW5zdHJ1Y3Rpb25zYF8gYmVsb3cpCj4g
PiAgPT09PT09PT0gID09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Cj4gPgo+ID4gK2VCUEYgc3VwcG9ydHMgMzItIGFuZCA2NC1i
aXQgc2lnbmVkIGFuZCB1bnNpZ25lZCBpbnRlZ2Vycy4gSXQgZG9lcwo+ID4gK25vdCBzdXBwb3J0
IGZsb2F0aW5nLXBvaW50IGRhdGEgdHlwZXMuIEFsbCBzaWduZWQgaW50ZWdlcnMgYXJlIHJlcHJl
c2VudGVkIGluCj4gPiArdHdvcy1jb21wbGVtZW50IGZvcm1hdCB3aGVyZSB0aGUgc2lnbiBiaXQg
aXMgc3RvcmVkIGluIHRoZSBtb3N0LXNpZ25pZmljYW50Cj4gPiArYml0Lgo+Cj4gQ291bGQgeW91
IHBvaW50IHRvIGFub3RoZXIgSVNBIGRvY3VtZW50IChsaWtlIHg4NiwgYXJtLCAuLi4pIHRoYXQK
PiB0YWxrcyBhYm91dCBzaWduZWQgYW5kIHVuc2lnbmVkIGludGVnZXJzPwoKVGhhbmsgeW91IGZv
ciB0aGUgcmVwbHkuIEkgaG9wZSB0aGF0IHRoaXMgY2hhbmdlIGlzIHVzZWZ1bC4gSSBwcm9wb3Nl
ZAp0aGlzIGNoYW5nZSB0byBtaW1pYyB0aGUgZG9jdW1lbnRhdGlvbiBvZiAiTnVtZXJpYyBEYXRh
IFR5cGVzIiBpbgpWb2x1bWUgMSwgQ2hhcHRlciA0IG9mICJJbnRlbMKuIDY0IGFuZCBJQS0zMiBB
cmNoaXRlY3R1cmVzIFNvZnR3YXJlCkRldmVsb3BlcuKAmXMgTWFudWFsIiBbMV0uCgpbMV0gaHR0
cHM6Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQvd3d3L3VzL2VuL2RldmVsb3Blci9hcnRpY2xlcy90
ZWNobmljYWwvaW50ZWwtc2RtLmh0bWwKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9y
ZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

