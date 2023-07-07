Return-Path: <bpf+bounces-4370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7874A83F
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A661C20EFA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC81112;
	Fri,  7 Jul 2023 00:52:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCC7F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 00:52:06 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F8C1FDA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:52:02 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 20CDAC13AE53
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688691122; bh=hLioZupSx8lTGSKceww7aJxCPRCIp3wPHTOb0lKry5w=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=i/d4UyVZQeU8vardp8dsPzGiVyhw31Ia6KPKHiIpLkR7iM772hfyUOLBz+2+gHHgr
	 HSX1cSP7psMt58KvKfPsiSE8wmbQ/DK54sdJLyuRDwfS9J0gOH8BlctrEIFj5vJ7fJ
	 //kqi1M7RqL8fG43tXj5ss4sfEWtswQ7teG1BDa4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 17:52:02 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EFBBDC151081;
	Thu,  6 Jul 2023 17:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688691121; bh=hLioZupSx8lTGSKceww7aJxCPRCIp3wPHTOb0lKry5w=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=uPPCwl85bu448ABl/EDHbZPTkVOXPvc2xxQDNv6NGJyqJjkihtgT9TrNwaPePXXfi
	 AAiEPSGCEr4nu+i2Mowszn0KKSMbMMNOIMeJ0Lbbot9dQGkxOYcpnNFxEuv08Schzf
	 /3pvzwakmoGtEXT288OtnWkdluuhEo2UxMFrvMWE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D963CC151081
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 17:52:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.897
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EOLCk-cHk-rc for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 17:52:00 -0700 (PDT)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4DB05C14CE4C
 for <bpf@ietf.org>; Thu,  6 Jul 2023 17:52:00 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6237faa8677so8163366d6.1
 for <bpf@ietf.org>; Thu, 06 Jul 2023 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688691119; x=1691283119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoyxcZZC5H4ip33QGJEwLd8bZuWDBLTi0NEBZvENWyA=;
 b=ai9RSXDNbvcOj5dsfnYFtvDDbxThGn0cFNBZIE38ZmZylAWM0x+c6bJ0Nz9MGVCaWF
 CpBK0CzKD7hFvzzxiJw8Mtpe17kCG35TPRo9+Ds9BMrgUlIoUKqHcx6SmoR4EFqt8GG4
 gs9c5uNUgYlREO5aX2LXHzeaQWn6rgdelHVzQupZo+Glq4dfYLXCvuT0HzFWupGBNryn
 iPgyX2SBqXOGmBlgxxBl4b4Or1MIHZ+bC6UwBlm0MZqqu5oeCV4WRftzay/guzCd5Mju
 A0XflFxhcKp9iKRTSl5DKYSuGhaAJmCzF7ftPwLf+jAnOGX7176yoaF0534Q2F+269IC
 hl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688691119; x=1691283119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoyxcZZC5H4ip33QGJEwLd8bZuWDBLTi0NEBZvENWyA=;
 b=TYMronil9p8uic/VKbx3rAV7PS/9HtdPmAWttWG/dbcLGu27IX2aFvptZtSgFM+7+3
 fxfdU8docnKfvO2NqeWfDRIPKUerK/RsUOmGCFlglYvTNjnHhNHZtBvpi6xtlMfTt1mo
 lUYJi4S/H7z3drf1Vh7/zGmSiP38tTClnOWCUDLpaUY3d9A3jxMdkJqG4ZneIm/q0n4P
 CcAHMvwISQd7PINN5Qe0yJl2zov4XoT7Qi1Aw6CzwfYTlGC/T9odqNA84ayBDz6ViTPy
 oNomcqLPBAmboCH9FWfzXmRmiLRa7sXsRfrjF/iTqHnpvx62mMkuWnvAcs1BYQ97hIXY
 dInQ==
X-Gm-Message-State: ABy/qLZeKbFW7pdFfDiZoXee23gisvTW+fKAwEtaz8M/1wfNY/rOL04k
 FFc5WRTPgGQ2otfHBm9J8YB73XNCtyrloG1wF/Kl+Gmy+gtUYg1n
X-Google-Smtp-Source: APBJJlGApWOse7/Xbtp325PxtS7/8GYJ3jEqxv2EfD/37YPftN5PSS/Q0sOOuyiR9/3VxUykDEdqYAssGZmEIigTWrA=
X-Received: by 2002:a0c:abc6:0:b0:62f:e0e1:478e with SMTP id
 k6-20020a0cabc6000000b0062fe0e1478emr2651087qvb.63.1688691119358; Thu, 06 Jul
 2023 17:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr>
 <20230706222020.268136-2-hawkinsw@obs.cr>
 <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
 <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com>
 <CAADnVQKdV2A+-+PWpgt7_tUF-0uj-6MSsTSAppQDH=7VeXKFrA@mail.gmail.com>
In-Reply-To: <CAADnVQKdV2A+-+PWpgt7_tUF-0uj-6MSsTSAppQDH=7VeXKFrA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 6 Jul 2023 20:51:48 -0400
Message-ID: <CADx9qWhCKUmJPCBYNOr9+FjKF6d_3SrQ3doVLxi4LzPEiMgHDA@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/UveW0tzfx98OOMcnDxmn3HQkvOU>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Describe stack contents of function calls
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCA4OjQ44oCvUE0gQWxleGVpIFN0YXJvdm9pdG92CjxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgSnVsIDYsIDIwMjMg
YXQgNTo0NuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+Cj4g
PiBPbiBUaHUsIEp1bCA2LCAyMDIzIGF0IDc6MzLigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1
LCBKdWwgNiwgMjAyMyBhdCAzOjIw4oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+
IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gVGhlIGV4ZWN1dGlvbiBvZiBldmVyeSBmdW5jdGlvbiBw
cm9jZWVkcyBhcyBpZiBpdCBoYXMgYWNjZXNzIHRvIGl0cyBvd24KPiA+ID4gPiBzdGFjayBzcGFj
ZS4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBEb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlv
bi1zZXQucnN0IHwgNSArKysrKwo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1
Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QKPiA+
ID4gPiBpbmRleCA3NTFlNjU3OTczZjAuLjcxNzI1OTc2N2E0MSAxMDA2NDQKPiA+ID4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiA+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gPiA+IEBAIC0zMCw2ICszMCwx
MSBAQCBUaGUgZUJQRiBjYWxsaW5nIGNvbnZlbnRpb24gaXMgZGVmaW5lZCBhczoKPiA+ID4gPiAg
UjAgLSBSNSBhcmUgc2NyYXRjaCByZWdpc3RlcnMgYW5kIGVCUEYgcHJvZ3JhbXMgbmVlZHMgdG8g
c3BpbGwvZmlsbCB0aGVtIGlmCj4gPiA+ID4gIG5lY2Vzc2FyeSBhY3Jvc3MgY2FsbHMuCj4gPiA+
ID4KPiA+ID4gPiArRXZlcnkgZnVuY3Rpb24gaW52b2NhdGlvbiBwcm9jZWVkcyBhcyBpZiBpdCBo
YXMgZXhjbHVzaXZlIGFjY2VzcyB0byBhbgo+ID4gPiA+ICtpbXBsZW1lbnRhdGlvbi1kZWZpbmVk
IGFtb3VudCBvZiBzdGFjayBzcGFjZS4gUjEwIGlzIGEgcG9pbnRlciB0byB0aGUgYnl0ZSBvZgo+
ID4gPiA+ICttZW1vcnkgd2l0aCB0aGUgaGlnaGVzdCBhZGRyZXNzIGluIHRoYXQgc3RhY2sgc3Bh
Y2UuIFRoZSBjb250ZW50cwo+ID4gPiA+ICtvZiBhIGZ1bmN0aW9uIGludm9jYXRpb24ncyBzdGFj
ayBzcGFjZSBkbyBub3QgcGVyc2lzdCBiZXR3ZWVuIGludm9jYXRpb25zLgo+ID4gPgo+ID4gPiBT
dWNoIGRlc2NyaXB0aW9uIGJlbG9uZ3MgaW4gYSBmdXR1cmUgcHNBQkkgZG9jLgo+ID4gPiBpbnN0
cnVjdGlvbi1zZXQucnN0IGlzIG5vdCBhIHBsYWNlIHRvIGRlc2NyaWJlIGhvdyByZWdpc3RlcnMg
YXJlIHVzZWQuCj4gPgo+ID4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2shCj4gPgo+ID4gSG93
IGRvZXMgeW91ciBjb21tZW50IHNxdWFyZSB3aXRoIHRoZSBpbW1lZGlhdGVseSBwcmVjZWRpbmcK
PiA+IGRlc2NyaXB0aW9uIGluIHRoZSBkb2N1bWVudCB0aGF0IHNheXM6Cj4gPgo+ID4gUjEwOiBy
ZWFkLW9ubHkgZnJhbWUgcG9pbnRlciB0byBhY2Nlc3Mgc3RhY2sKPiA+Cj4gPiAoYW1vbmcgdGhl
IGRlc2NyaXB0aW9uIG9mIGhvdyBvdGhlciByZWdpc3RlcnMgYXJlIHVzZWQgZHVyaW5nIGZ1bmN0
aW9uIGNhbGxzKS4KPgo+IFNlZQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi9DQUFEblZR
K2dMbnNPVmo5czR6cEFQNitVNm5GSFltNkdWWjFGdGVSYWM9WmFKdnBmRGdAbWFpbC5nbWFpbC5j
b20vCj4KPiB0bGRyOiBpdCdzIGEgbWVzcy4KPiBXZSBzaG91bGQgcmVtb3ZlICdSZWdpc3RlcnMg
YW5kIGNhbGxpbmcgY29udmVudGlvbicgc2VjdGlvbiBmcm9tCj4gaW5zdHJ1Y3Rpb24tc2V0LnJz
dAoKVW5kZXJzdG9vZC4gSSBhbSB3b3JraW5nIGNsb3NlbHkgKGF0IGxlYXN0IEkgd291bGQgbGlr
ZSB0byB0aGluayB0aGF0Cml0J3MgY2xvc2VseSkgd2l0aCBEYXZlIGFuZCBoYXZlIGJlZW4gZm9s
bG93aW5nIHRoYXQgdGhyZWFkCmF0dGVudGl2ZWx5LiBJIHdpbGwgaGVscCB3aXRoIGRvY3VtZW50
YXRpb24gYW5kIHdyaXRpbmcgaW4gd2hhdGV2ZXIKd2F5IEkgY2FuLgoKV2lsbAoKLS0gCkJwZiBt
YWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlz
dGluZm8vYnBmCg==

