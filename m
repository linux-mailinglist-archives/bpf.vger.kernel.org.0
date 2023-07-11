Return-Path: <bpf+bounces-4717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D101974E540
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F32815E5
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696D3FE3;
	Tue, 11 Jul 2023 03:25:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE83D6E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:25:04 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04883C2
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:25:01 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A1012C19E0FE
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689045901; bh=zkJEpH7ylmudp7l2+OwvDBcVv4f4/gKhv7RZ8y7egpI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=TDZVkgCu3DIRmdx7vfjTGPGq+BYC9DD1rCZj2bnFvGWPKwbQtxN1UXMuvqrD8CzWh
	 jU5fJYBpAeLADjvD8qTQK2MFbqmQbAQ2q5EHptPDajTLVdHDQl3kOaat5BbwKBHYhj
	 B0XWfWq9yeJ9c8ttIp9VBnO8W9EQa0Gxkcyg5/3U=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 20:25:01 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7B717C1782A0;
	Mon, 10 Jul 2023 20:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689045901; bh=zkJEpH7ylmudp7l2+OwvDBcVv4f4/gKhv7RZ8y7egpI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=TDZVkgCu3DIRmdx7vfjTGPGq+BYC9DD1rCZj2bnFvGWPKwbQtxN1UXMuvqrD8CzWh
	 jU5fJYBpAeLADjvD8qTQK2MFbqmQbAQ2q5EHptPDajTLVdHDQl3kOaat5BbwKBHYhj
	 B0XWfWq9yeJ9c8ttIp9VBnO8W9EQa0Gxkcyg5/3U=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 632A9C1782A0
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 20:25:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.895
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
 with ESMTP id Ulfcckrb-Unz for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 20:24:56 -0700 (PDT)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 76CC1C169530
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:24:56 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-635e3ceb152so26120046d6.2
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689045895; x=1691637895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRrBHyxlTn8ItFZqGDsaTFG1bK3+seEFvi8lbsGP7n8=;
 b=A7fl8QTt4NCecxWEfbm/KnF+XYGfw+guubIr8HPXrU2AtE4aXlmW5n5X6KDyS1b3xI
 8FullbXSZE4xAG4tznGuTmShRlkILZmEQ/005IQXbzB4v6CRMxAQLmKcwhpxZwa3B3YJ
 zclBKKMkp7XaRbw9XaVTc1YgtlW58NtMM7VFtkcAh28ujPUf4Ib5uQAnsSsbb5WSz13i
 GWsSEi0Yr07O+cBZanzFKJnEt7/iYKHNBGrZ1u9yKL3E/2rpHPnFmjTA49JX0YfPWPlE
 fwPV29+j1ec7RuDTTWHW/OxKkTOt01qkdgx8PiXp2oPMGtPsBQzsGEaIAWIO9xGuBuun
 OAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689045895; x=1691637895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRrBHyxlTn8ItFZqGDsaTFG1bK3+seEFvi8lbsGP7n8=;
 b=aBSz5rrHRGdByrvdty4+3Oj6miKp3QMOvjTiWV/oxOzcYe7ixAFN9Yb/7R15Rh3SYd
 dMgTeb0yw7BQsnWhAOUQYn9BtCyzBw4G8VqauK2neODGQwMWTaOQJgVX7RvC474O0BvL
 /im+M/Ey0iFGbCyEYaJNcOTbV8/gePEGdo8sOJDg8q5SC1NlEhopGNRdznVlNp0UyWoh
 UPe4L+6XGy0EnwFsQpyNWF4aX1ZJYiqXIk8rY/M+0BjMwAY2TqCwe1qFzVDBsLdM3NLC
 FRabFchgzF6u+c5hbRpIGC7+ZE4vtigk78asBu1ZuE+s37VfAepDO4+COt4KxIA/qoVc
 DH1g==
X-Gm-Message-State: ABy/qLZWR5VuKxBJiPTPce80GHxuDkQCNv4FGFhE24yX+RkTLp7/Bp6t
 D4UGSPwxlumH+Al9PyTuGJz84LEfnfphnaE7I5XFgA==
X-Google-Smtp-Source: APBJJlHScF0oeOrxMIy/NhuInzroJ6APwFktJ37YBj1NBVLdMqpG2VoP2M5jHaKfcU4T3X5y5VoLb5GTMlFUdgbOwDQ=
X-Received: by 2002:a0c:e38c:0:b0:631:e696:7b1 with SMTP id
 a12-20020a0ce38c000000b00631e69607b1mr11326022qvl.62.1689045895050; Mon, 10
 Jul 2023 20:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr>
 <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
 <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
In-Reply-To: <CADx9qWgmYu_LVVFtR0R7pcqM_270kQFzvmiSZ-2Umn2pE6qn=g@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 23:24:45 -0400
Message-ID: <CADx9qWhTi+NetbqbBpMTEAFRsbQQbn3CXRvhC8wyzqQQviy0kA@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/depM6tTyLINYLSZgA7FtYG5KLFg>
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

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6MTnigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3
QG9icy5jcj4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1bCAxMCwgMjAyMyBhdCAxMTowMOKAr1BNIEFs
ZXhlaSBTdGFyb3ZvaXRvdgo+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToK
PiA+Cj4gPiBPbiBNb24sIEp1bCAxMCwgMjAyMyBhdCAyOjU44oCvUE0gV2lsbCBIYXdraW5zIDxo
YXdraW5zd0BvYnMuY3I+IHdyb3RlOgo+ID4gPgo+ID4gPiBJbiB0aGUgZG9jdW1lbnRhdGlvbiBv
ZiB0aGUgZUJQRiBJU0EgaXQgaXMgdW5zcGVjaWZpZWQgaG93IGludGVnZXJzIGFyZQo+ID4gPiBy
ZXByZXNlbnRlZC4gU3BlY2lmeSB0aGF0IHR3b3MgY29tcGxlbWVudCBpcyB1c2VkLgo+ID4gPgo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4KPiA+ID4g
LS0tCj4gPiA+ICBEb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0IHwgNSArKysr
Kwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4gPgo+ID4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50
YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QKPiA+ID4gaW5kZXggNzUxZTY1Nzk3M2YwLi42
M2RmY2JhNWViOWEgMTAwNjQ0Cj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0
aW9uLXNldC5yc3QKPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0
LnJzdAo+ID4gPiBAQCAtMTczLDYgKzE3MywxMSBAQCBCUEZfQVJTSCAgMHhjMCAgIHNpZ24gZXh0
ZW5kaW5nIGRzdCA+Pj0gKHNyYyAmIG1hc2spCj4gPiA+ICBCUEZfRU5EICAgMHhkMCAgIGJ5dGUg
c3dhcCBvcGVyYXRpb25zIChzZWUgYEJ5dGUgc3dhcCBpbnN0cnVjdGlvbnNgXyBiZWxvdykKPiA+
ID4gID09PT09PT09ICA9PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQo+ID4gPgo+ID4gPiArZUJQRiBzdXBwb3J0cyAzMi0gYW5k
IDY0LWJpdCBzaWduZWQgYW5kIHVuc2lnbmVkIGludGVnZXJzLiBJdCBkb2VzCj4gPiA+ICtub3Qg
c3VwcG9ydCBmbG9hdGluZy1wb2ludCBkYXRhIHR5cGVzLiBBbGwgc2lnbmVkIGludGVnZXJzIGFy
ZSByZXByZXNlbnRlZCBpbgo+ID4gPiArdHdvcy1jb21wbGVtZW50IGZvcm1hdCB3aGVyZSB0aGUg
c2lnbiBiaXQgaXMgc3RvcmVkIGluIHRoZSBtb3N0LXNpZ25pZmljYW50Cj4gPiA+ICtiaXQuCj4g
Pgo+ID4gQ291bGQgeW91IHBvaW50IHRvIGFub3RoZXIgSVNBIGRvY3VtZW50IChsaWtlIHg4Niwg
YXJtLCAuLi4pIHRoYXQKPiA+IHRhbGtzIGFib3V0IHNpZ25lZCBhbmQgdW5zaWduZWQgaW50ZWdl
cnM/Cj4KPiBUaGFuayB5b3UgZm9yIHRoZSByZXBseS4gSSBob3BlIHRoYXQgdGhpcyBjaGFuZ2Ug
aXMgdXNlZnVsLiBJIHByb3Bvc2VkCj4gdGhpcyBjaGFuZ2UgdG8gbWltaWMgdGhlIGRvY3VtZW50
YXRpb24gb2YgIk51bWVyaWMgRGF0YSBUeXBlcyIgaW4KPiBWb2x1bWUgMSwgQ2hhcHRlciA0IG9m
ICJJbnRlbMKuIDY0IGFuZCBJQS0zMiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlCj4gRGV2ZWxvcGVy
4oCZcyBNYW51YWwiIFsxXS4KPgo+IFsxXSBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC93
d3cvdXMvZW4vZGV2ZWxvcGVyL2FydGljbGVzL3RlY2huaWNhbC9pbnRlbC1zZG0uaHRtbAoKUGVy
aGFwcyB5b3Ugd291bGQgcHJlZmVyIHRoYXQgdGhpcyBpbmZvcm1hdGlvbiBnb2VzIChhZ2Fpbikg
aW4gYSBwc0FCSQpkb2N1bWVudD8gSWYgc28sIHRoYXQncyBncmVhdCAtLSBJIGFtIHdvcmtpbmcg
b24gYSBzdHJhd21hbiB2ZXJzaW9uIG9mCm9uZSBhcyB3ZSBzcGVhaywgaW4gZmFjdC4KCldoYXRl
dmVyIHlvdSB0aGluayBpcyBiZXN0IGlzIGdyZWF0IC0tIHlvdSBhcmUgdGhlIGV4cGVydCBJIGFt
IGp1c3QKdHJ5aW5nIHRvIGhlbHAhCgpTaW5jZXJlbHksCldpbGwKCi0tIApCcGYgbWFpbGluZyBs
aXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Jw
Zgo=

