Return-Path: <bpf+bounces-4726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE0774E65F
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 07:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2421C20B17
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994915492;
	Tue, 11 Jul 2023 05:34:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2283125B8
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 05:34:48 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A3134
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 22:34:46 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8FE89C17EA47
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689053686; bh=ZhxZFtKO0xnVSlxpmjABVaIZjRV71ugkp12iPiPRXh8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HwFjsQlR8kMqJ1UWvReqyfuR1CFkyRTGBdKQxKGYsxQQHkuPLLEnNKaCh8nX5u3X7
	 kgdbeDqZ6zj2vuBoqM9jRu/VIUPOJAhMievccpdhnggObUuprGMxsCB6BkM9eLhZ92
	 v/35pYxHnFui105QzqsD3Z3uF58QX/K2qvf0Xc1E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 22:34:46 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 53D54C151098;
	Mon, 10 Jul 2023 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689053686; bh=ZhxZFtKO0xnVSlxpmjABVaIZjRV71ugkp12iPiPRXh8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HwFjsQlR8kMqJ1UWvReqyfuR1CFkyRTGBdKQxKGYsxQQHkuPLLEnNKaCh8nX5u3X7
	 kgdbeDqZ6zj2vuBoqM9jRu/VIUPOJAhMievccpdhnggObUuprGMxsCB6BkM9eLhZ92
	 v/35pYxHnFui105QzqsD3Z3uF58QX/K2qvf0Xc1E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 98D70C151098
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 22:34:44 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.893
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
 with ESMTP id HsFHDhqvrn2W for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 22:34:40 -0700 (PDT)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B1310C15107D
 for <bpf@ietf.org>; Mon, 10 Jul 2023 22:34:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-767ca28fb32so103225385a.1
 for <bpf@ietf.org>; Mon, 10 Jul 2023 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689053679; x=1691645679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIwf0DRgkjpa7bcOHOBgKi+H0CPdK3A9qZcBSfK3zR8=;
 b=wHXXXmxYs9YQOrj5t2WFFpthbnwHrAg5bjwSzUd0yy0WBvNnFLSPpvY1R49+kkMk2f
 WQXQsnCSqvaVnMKwq2GMDmQk0CJ7Q4GV0lo4gkhgioqKDx84GolDiISnsgH1qkdUjuFW
 Uuhh4mH6EEDWf5Mn+qQeckcxXwd5h6a5P43Z/Q8qdN78mczYQPx2V1C5fCShwHKM6ss3
 uZw2n2J7SrDDMjQYUoKLqALxUxtYFjk5lfx0rFb5b2oBYe/Euh8VLcrMkekNZb8KaZEV
 XPwABjTxHiKlf1CRn3xV1pjDouLn2n057ldQpfzTZFbPwiWeG3viObLB9jwsFs93wF4k
 +R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689053679; x=1691645679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIwf0DRgkjpa7bcOHOBgKi+H0CPdK3A9qZcBSfK3zR8=;
 b=Z9GIWolZYp1RgrJVugb314HkHLXxmnwgtIgp05lmKXPQE+9wRiIMBRHHnIDiMZD7Al
 R/rUBONDoWEOI52ynPvc41TEvm7/pd50I9qibFOpzYxW7R8aUvbFhhLqdPBsyMaLzZxs
 25O8WH17VYCExKFt8EKsSC992CEljT5i5UkEbQFHFx0/zs8WtfLrjIAZ58DQLqxv1ZGt
 PKhyota4aFa49Ksqz+j/rOp+diZ1CLkyvPHmelPJq2aK7ULokes9FtlyTqvpHcDVGfhy
 2sS7uBreV0hjzFg33wXEZN6Iptbs/pjqGLcofhvvAnttZReS3tJ4lIWqY/WD3YYhRtoG
 OvgQ==
X-Gm-Message-State: ABy/qLbBll5ae2GYdMTful1LEmLD6kW0lD1dxmmoDou1Nc0hWMJPgg0C
 ix3bLsgl06Vs8+1rETXwm6w6ZhRec//8+SwchJ4j/Q==
X-Google-Smtp-Source: APBJJlF3wh2QWP0CsAV7NDrBJUr0sKjUL5tXnd6F7okH8IvlrI9vOLpYlcnuBeAsxImNm6786Y2VhnP2+oUURT+PpAQ=
X-Received: by 2002:a0c:e107:0:b0:635:ddc7:a0fe with SMTP id
 w7-20020a0ce107000000b00635ddc7a0femr16279668qvk.9.1689053679469; Mon, 10 Jul
 2023 22:34:39 -0700 (PDT)
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
 <CAADnVQJR7YFcjqgiGABX-_jJEK7rQTrO8cGFJiZ16oOtpbmVNA@mail.gmail.com>
In-Reply-To: <CAADnVQJR7YFcjqgiGABX-_jJEK7rQTrO8cGFJiZ16oOtpbmVNA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 11 Jul 2023 01:34:29 -0400
Message-ID: <CADx9qWiBxoe6RAvfXq4xRHTshv8YNOtvG6THEx18jVOJ8WFDow@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/XZALIuQm-o9HAibFkY240Kvoe2M>
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

T24gVHVlLCBKdWwgMTEsIDIwMjMgYXQgMTI6NDfigK9BTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPGFs
ZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMTAsIDIw
MjMgYXQgODoxOeKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+
Cj4gPiBPbiBNb24sIEp1bCAxMCwgMjAyMyBhdCAxMTowMOKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRv
dgo+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBP
biBNb24sIEp1bCAxMCwgMjAyMyBhdCAyOjU44oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gSW4gdGhlIGRvY3VtZW50YXRpb24gb2YgdGhl
IGVCUEYgSVNBIGl0IGlzIHVuc3BlY2lmaWVkIGhvdyBpbnRlZ2VycyBhcmUKPiA+ID4gPiByZXBy
ZXNlbnRlZC4gU3BlY2lmeSB0aGF0IHR3b3MgY29tcGxlbWVudCBpcyB1c2VkLgo+ID4gPiA+Cj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+Cj4gPiA+
ID4gLS0tCj4gPiA+ID4gIERvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QgfCA1
ICsrKysrCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+ID4gPgo+
ID4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0
IGIvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gPiA+IGluZGV4IDc1
MWU2NTc5NzNmMC4uNjNkZmNiYTVlYjlhIDEwMDY0NAo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QKPiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Jw
Zi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiA+ID4gQEAgLTE3Myw2ICsxNzMsMTEgQEAgQlBGX0FS
U0ggIDB4YzAgICBzaWduIGV4dGVuZGluZyBkc3QgPj49IChzcmMgJiBtYXNrKQo+ID4gPiA+ICBC
UEZfRU5EICAgMHhkMCAgIGJ5dGUgc3dhcCBvcGVyYXRpb25zIChzZWUgYEJ5dGUgc3dhcCBpbnN0
cnVjdGlvbnNgXyBiZWxvdykKPiA+ID4gPiAgPT09PT09PT0gID09PT09ICA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiA+ID4KPiA+
ID4gPiArZUJQRiBzdXBwb3J0cyAzMi0gYW5kIDY0LWJpdCBzaWduZWQgYW5kIHVuc2lnbmVkIGlu
dGVnZXJzLiBJdCBkb2VzCj4gPiA+ID4gK25vdCBzdXBwb3J0IGZsb2F0aW5nLXBvaW50IGRhdGEg
dHlwZXMuIEFsbCBzaWduZWQgaW50ZWdlcnMgYXJlIHJlcHJlc2VudGVkIGluCj4gPiA+ID4gK3R3
b3MtY29tcGxlbWVudCBmb3JtYXQgd2hlcmUgdGhlIHNpZ24gYml0IGlzIHN0b3JlZCBpbiB0aGUg
bW9zdC1zaWduaWZpY2FudAo+ID4gPiA+ICtiaXQuCj4gPiA+Cj4gPiA+IENvdWxkIHlvdSBwb2lu
dCB0byBhbm90aGVyIElTQSBkb2N1bWVudCAobGlrZSB4ODYsIGFybSwgLi4uKSB0aGF0Cj4gPiA+
IHRhbGtzIGFib3V0IHNpZ25lZCBhbmQgdW5zaWduZWQgaW50ZWdlcnM/Cj4gPgo+ID4gVGhhbmsg
eW91IGZvciB0aGUgcmVwbHkuIEkgaG9wZSB0aGF0IHRoaXMgY2hhbmdlIGlzIHVzZWZ1bC4gSSBw
cm9wb3NlZAo+ID4gdGhpcyBjaGFuZ2UgdG8gbWltaWMgdGhlIGRvY3VtZW50YXRpb24gb2YgIk51
bWVyaWMgRGF0YSBUeXBlcyIgaW4KPiA+IFZvbHVtZSAxLCBDaGFwdGVyIDQgb2YgIkludGVswq4g
NjQgYW5kIElBLTMyIEFyY2hpdGVjdHVyZXMgU29mdHdhcmUKPiA+IERldmVsb3BlcuKAmXMgTWFu
dWFsIiBbMV0uCj4gPgo+ID4gWzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91
cy9lbi9kZXZlbG9wZXIvYXJ0aWNsZXMvdGVjaG5pY2FsL2ludGVsLXNkbS5odG1sCj4KPiBJIHNl
ZSB3aGVyZSB5b3UgZ290IHRoZSBpbnNwaXJhdGlvbiBmcm9tLgo+IEl0J3MgYSAic29mdHdhcmUg
ZGV2ZWxvcGVyJ3MgbWFudWFsIi4gTm90IGFuIElTQSBzcGVjLgo+IEJ1dCwgc2F5LCB3ZSBhZG9w
dCB0aGlzIGZvcm0gYW5kIHByb2NlZWQgdG8gY3JlYXRlIGFsbCA1MDAgcGFnZXMgb2YgaXQuCgpU
aG91Z2ggdGhlIFJJU0MtViBJU0EgZG9lcyBpbmNsdWRlIGluZm9ybWF0aW9uIGFib3V0IHRoZSBp
bnRlZ2VyCnJlcHJlc2VudGF0aW9uLCB5b3VyIHBvaW50IGlzIHdlbGwgdGFrZW4uCgpBcyBJIHNh
aWQgaW4gYSBwcmV2aW91cyBtZXNzYWdlLCBJIGFtIHdvcmtpbmcgb24gc2V0dGluZyB1cCB0aGUK
c2tlbGV0b24gZm9yIGEgc3RyYXdtYW4gZm9yIGEgcHNBQkkuIEkgd2lsbCBkZXZvdGUgbXkgZWZm
b3J0cyB0aGVyZQp3aGVyZSBJIGhvcGUgdGhhdCB0aGV5IGNhbiBiZSBtb3JlIHVzZWZ1bC4KCldp
bGwKCj4KPiBTRE0gaGFzIHRoaXMgdG8gc2F5IGFib3V0IHBvaW50ZXJzOgo+ICJQb2ludGVycyBh
cmUgYWRkcmVzc2VzIG9mIGxvY2F0aW9ucyBpbiBtZW1vcnkuCj4gSW4gbm9uLTY0LWJpdCBtb2Rl
cywgdGhlIGFyY2hpdGVjdHVyZSBkZWZpbmVzIHR3byB0eXBlcyBvZiBwb2ludGVyczogYQo+IG5l
YXIgcG9pbnRlciBhbmQgYSBmYXIgcG9pbnRlci4gQSBuZWFyIHBvaW50ZXIgaXMgYSAzMi1iaXQg
KG9yIDE2LWJpdCkKPiBvZmZzZXQgKGFsc28gY2FsbGVkIGFuIGVmZmVjdGl2ZSBhZGRyZXNzKSB3
aXRoaW4gYSBzZWdtZW50LiBOZWFyCj4gcG9pbnRlcnMgYXJlIHVzZWQKPiBmb3IgYWxsIG1lbW9y
eSByZWZlcmVuY2VzIGluIGEgZmxhdCBtZW1vcnkgbW9kZWwgb3IgZm9yIHJlZmVyZW5jZXMgaW4K
PiBhIHNlZ21lbnRlZCBtb2RlbCB3aGVyZSB0aGUgaWRlbnRpdHkgb2YgdGhlIHNlZ21lbnQgYmVp
bmcgYWNjZXNzZWQgaXMKPiBpbXBsaWVkLiIKPgo+IEJQRiBydW5zIG9uIDMyLWJpdCBhbmQgNjQt
Yml0IENQVXMsIHNvIGlmIHdlIGRvY3VtZW50IHNpZ25lZCB2cyB1bnNpZ25lZAo+IGludGVnZXJz
IHdlJ2QgaGF2ZSB0byBzYXkgYSBmZXcgd29yZHMgYWJvdXQgcG9pbnRlcnMsIGJpdGZpZWxkcyBh
bmQgc3RyaW5ncwo+IChqdXN0IGxpa2UgSW50ZWwgU0RNKS4gUG9pbnRlcnMgaW4gQlBGIGFyZSBj
bGVhcmx5IGxhY2tpbmcgZG9jcy4KPgo+IEJleW9uZCBWb2wgMSwgQ2hhcHRlciA0IHRoZXJlIGFy
ZSBwbGVudHkgb2Ygb3RoZXIgY2hhcHRlcnMuCj4gU2hvdWxkIHdlIGhhdmUgYW4gZXF1aXZhbGVu
dCBmb3IgYWxsIG9mIHRoZW0/Cj4gSSB0aGluayBpdCB3b3VsZCBiZSBncmVhdCB0byBoYXZlIHNv
bWV0aGluZyBmb3IgYWxsIHRoYXQsCj4gYnV0IGRyb3BwaW5nIGEgcGF0Y2ggb3IgdHdvIHdvbid0
IGdldCB1cyB0aGVyZS4KPiBJdCBuZWVkcyB0byBiZSBhIGZ1bGwgdGltZSBjb21taXRtZW50IHdp
dGggU09XLCByb2FkbWFwLCBldGMuCj4gSSBkb3VidCB0aGUga2VybmVsIGFuZC9vciBJRVRGIHBy
b2Nlc3MgY2FuIGFjY29tbW9kYXRlIHRoYXQuCj4KPiBTYXlpbmcgaXQgZGlmZmVyZW50bHkuIFdo
YXQgaXMgbWlzc2luZyBpbiBpbnN0cnVjdGlvbi1zZXQucnN0Cj4gZnJvbSBtYWtpbmcgYW4gSUVU
RiBzdGFuZGFyZCBvdXQgb2YgaXQ/Cj4gRG9lcyBpdCBuZWVkIGEgc2lnbmVkIHZzIHVuc2lnbmVk
IFNETS1saWtlIHBhcmFncmFwaD8KPgo+IExldCdzIGZvY3VzIG9uIGNvbnZlcnRpbmcgaW5zdHJ1
Y3Rpb24tc2V0LnJzdCBpbnRvIGEgc3RhbmRhcmQKPiBhcyBmYXN0IGFzIHBvc3NpYmxlIGFuZCB0
YWNrbGUgYWxsIG5pY2UtdG8taGF2ZSBsYXRlci4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBp
ZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

