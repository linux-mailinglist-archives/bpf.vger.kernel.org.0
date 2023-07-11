Return-Path: <bpf+bounces-4719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783374E54B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019362815D5
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A994415;
	Tue, 11 Jul 2023 03:28:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED23440F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:28:29 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40CE2
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:28:28 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 218ADC19E0FE
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689046108; bh=IkldAMY02qquUuDBeoCFj42kaHEqUYGk+7+yr4rFUww=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=GqLXNetZ2jD0l2upvC6VKAAln3altYcuJXQ52KODC3D3f4VQ4bmeTYliq1uz0mJDg
	 KsINQzRjD36RSptYapi7Kl2rUer23q50BGjuxLD55rJgsYNZzwhVp62PR34n2aC3Vi
	 11Su0GN++bmG9dyuxokcCD1Okv7+exAAvPucLakE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 20:28:28 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id ED513C151087;
	Mon, 10 Jul 2023 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689046107; bh=IkldAMY02qquUuDBeoCFj42kaHEqUYGk+7+yr4rFUww=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ko5vn+vu7+KDpIepgh3uzFtXg+ngl/JezcXUM5S5mXXfvJ9y4wyIDUVWv5xdZjIDt
	 tx/JvqvJTeBgahC7OtDXqBX4/wvSLjls5DGFoycCDxNv+meZFs6ucwLz3nkSzxu/g+
	 +XLXVd1GNU2ryu5JIwsAM67ywqy4nns5HEV2NlXs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id ED3B1C151087
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 20:28:26 -0700 (PDT)
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
 with ESMTP id SOaAw_g3Xzww for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 20:28:22 -0700 (PDT)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C50B4C14CE30
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:28:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-635dccdf17dso35801536d6.3
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689046102; x=1691638102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPHOpuG0nRzVKLS8XM9h0fEa3eKyMGT7EzxN/swJKAg=;
 b=YznUrHIE3/38DzxSIOJ9dWHnQFG+V4OnoQMkNosYGc0VxdfcZw59gx8EfN9KNZNhDa
 01Ijn3EfEufWMDwr2CYb3YcVdW9At5ueHsTbS8ro5RN9PdagEOMUNjCoeslO72J1nuUu
 R3Uj+ihMjv/mqh/K2PvN3kWcfHn+GPgaRxjqkN7w5pOyn05APkOgmTXvbcgaYa3zggwC
 UyS1rp+nT0U8iRkgjpDv0fm36TjP7QKwdWwlP4ilw7zDsijBToItbEPHoIBfRIs7bTcj
 YxoipDIsbXV/pIkohdvZ0KEncOO3b5/tJ/pSfe8ffVGZzUto60d6v3PwUMryby5soxsp
 w64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689046102; x=1691638102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPHOpuG0nRzVKLS8XM9h0fEa3eKyMGT7EzxN/swJKAg=;
 b=M1oKQkll7GLtr+FAsIdLatOTSzCfnVwaTO4XuIGqG1ib48WTegbmJ3ZMHTqO8JE9F8
 wdH34eQ86u2KNnKOOHjkxFsXlh922WOxklTRg6x3MJowJPxzQ19GKXlA/1mftWkcP3Rm
 BcyjFmYeGTKyAmVq7fdAy0Vd82KoAd0HpaWxALRK/64YYuvJhLzj5XUe2tolNKuGCDJF
 dDFSOHbqvZ9SxX4zg1aCEE4vAwrPUbOeDCzPTZR+aOvhneXhpdSx4iwoX+sQvVkHo4x6
 mYjC6JvpCxrSvoxsMkvhdG7EYKwANhNQ7OiKQrbwXGQLWyZjasq53nXylkn1CZUoMct9
 a5pQ==
X-Gm-Message-State: ABy/qLbEB2Pp9iq6UVtArg+rS9x0WO0rdjos+CcjZKxIP6VoAg7K0NKE
 5VXsaGjsIzXoF3U60uEZQJjNNr3NOkglFRKw1hn8jQ==
X-Google-Smtp-Source: APBJJlEwd9lWr+uix9pe2kGV82O3+oRMScTHHFLH7LePg9HDjgBqMdeuKiotMgVio1VW9WAL52hDDxwXAFSbC7tvXbQ=
X-Received: by 2002:a0c:f0d3:0:b0:637:398f:83be with SMTP id
 d19-20020a0cf0d3000000b00637398f83bemr12649425qvl.14.1689046101931; Mon, 10
 Jul 2023 20:28:21 -0700 (PDT)
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
 <CADx9qWhTi+NetbqbBpMTEAFRsbQQbn3CXRvhC8wyzqQQviy0kA@mail.gmail.com>
In-Reply-To: <CADx9qWhTi+NetbqbBpMTEAFRsbQQbn3CXRvhC8wyzqQQviy0kA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 23:28:11 -0400
Message-ID: <CADx9qWjCpHpdRup306JkUNDypQdOOuUduvmRwA3c1uRzS3Xo1w@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/JEBBYmoZcVou_vCx_E6yW6x8tL4>
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

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6MjTigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3
QG9icy5jcj4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1bCAxMCwgMjAyMyBhdCAxMToxOeKAr1BNIFdp
bGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEp1bCAx
MCwgMjAyMyBhdCAxMTowMOKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPGFsZXhlaS5zdGFy
b3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBNb24sIEp1bCAxMCwgMjAy
MyBhdCAyOjU44oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+IHdyb3RlOgo+ID4g
PiA+Cj4gPiA+ID4gSW4gdGhlIGRvY3VtZW50YXRpb24gb2YgdGhlIGVCUEYgSVNBIGl0IGlzIHVu
c3BlY2lmaWVkIGhvdyBpbnRlZ2VycyBhcmUKPiA+ID4gPiByZXByZXNlbnRlZC4gU3BlY2lmeSB0
aGF0IHR3b3MgY29tcGxlbWVudCBpcyB1c2VkLgo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIERv
Y3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QgfCA1ICsrKysrCj4gPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0IGIvRG9jdW1lbnRhdGlvbi9i
cGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gPiA+IGluZGV4IDc1MWU2NTc5NzNmMC4uNjNkZmNi
YTVlYjlhIDEwMDY0NAo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9u
LXNldC5yc3QKPiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQu
cnN0Cj4gPiA+ID4gQEAgLTE3Myw2ICsxNzMsMTEgQEAgQlBGX0FSU0ggIDB4YzAgICBzaWduIGV4
dGVuZGluZyBkc3QgPj49IChzcmMgJiBtYXNrKQo+ID4gPiA+ICBCUEZfRU5EICAgMHhkMCAgIGJ5
dGUgc3dhcCBvcGVyYXRpb25zIChzZWUgYEJ5dGUgc3dhcCBpbnN0cnVjdGlvbnNgXyBiZWxvdykK
PiA+ID4gPiAgPT09PT09PT0gID09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiA+ID4KPiA+ID4gPiArZUJQRiBzdXBwb3J0
cyAzMi0gYW5kIDY0LWJpdCBzaWduZWQgYW5kIHVuc2lnbmVkIGludGVnZXJzLiBJdCBkb2VzCj4g
PiA+ID4gK25vdCBzdXBwb3J0IGZsb2F0aW5nLXBvaW50IGRhdGEgdHlwZXMuIEFsbCBzaWduZWQg
aW50ZWdlcnMgYXJlIHJlcHJlc2VudGVkIGluCj4gPiA+ID4gK3R3b3MtY29tcGxlbWVudCBmb3Jt
YXQgd2hlcmUgdGhlIHNpZ24gYml0IGlzIHN0b3JlZCBpbiB0aGUgbW9zdC1zaWduaWZpY2FudAo+
ID4gPiA+ICtiaXQuCj4gPiA+Cj4gPiA+IENvdWxkIHlvdSBwb2ludCB0byBhbm90aGVyIElTQSBk
b2N1bWVudCAobGlrZSB4ODYsIGFybSwgLi4uKSB0aGF0Cj4gPiA+IHRhbGtzIGFib3V0IHNpZ25l
ZCBhbmQgdW5zaWduZWQgaW50ZWdlcnM/Cj4gPgo+ID4gVGhhbmsgeW91IGZvciB0aGUgcmVwbHku
IEkgaG9wZSB0aGF0IHRoaXMgY2hhbmdlIGlzIHVzZWZ1bC4gSSBwcm9wb3NlZAo+ID4gdGhpcyBj
aGFuZ2UgdG8gbWltaWMgdGhlIGRvY3VtZW50YXRpb24gb2YgIk51bWVyaWMgRGF0YSBUeXBlcyIg
aW4KPiA+IFZvbHVtZSAxLCBDaGFwdGVyIDQgb2YgIkludGVswq4gNjQgYW5kIElBLTMyIEFyY2hp
dGVjdHVyZXMgU29mdHdhcmUKPiA+IERldmVsb3BlcuKAmXMgTWFudWFsIiBbMV0uCj4gPgo+ID4g
WzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9kZXZlbG9wZXIvYXJ0
aWNsZXMvdGVjaG5pY2FsL2ludGVsLXNkbS5odG1sCgooQXBvbG9naWVzIGZvciBhIHN0cmluZyBv
ZiByZXNwb25zZXMpCgpUaGUgUklTQy1WIElTQSBzcGVjaWZpZXMgaW50ZWdlciByZXByZXNlbnRh
dGlvbiBbMV0uCgpbMV0gaHR0cHM6Ly9yaXNjdi5vcmcvdGVjaG5pY2FsL3NwZWNpZmljYXRpb25z
LwoKPgo+IFBlcmhhcHMgeW91IHdvdWxkIHByZWZlciB0aGF0IHRoaXMgaW5mb3JtYXRpb24gZ29l
cyAoYWdhaW4pIGluIGEgcHNBQkkKPiBkb2N1bWVudD8gSWYgc28sIHRoYXQncyBncmVhdCAtLSBJ
IGFtIHdvcmtpbmcgb24gYSBzdHJhd21hbiB2ZXJzaW9uIG9mCj4gb25lIGFzIHdlIHNwZWFrLCBp
biBmYWN0Lgo+Cj4gV2hhdGV2ZXIgeW91IHRoaW5rIGlzIGJlc3QgaXMgZ3JlYXQgLS0geW91IGFy
ZSB0aGUgZXhwZXJ0IEkgYW0ganVzdAo+IHRyeWluZyB0byBoZWxwIQo+Cj4gU2luY2VyZWx5LAo+
IFdpbGwKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRm
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

