Return-Path: <bpf+bounces-4724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4912A74E60B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 06:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC531C20D71
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA25249;
	Tue, 11 Jul 2023 04:47:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D50191
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 04:47:08 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE79A9
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:47:07 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3BA2EC17EB6D
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689050827; bh=12/XcpfG3xcTGqMUp9sBtLNZFJZX9ojGxeC5uKqHxlI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qySSgXcZ6hfxpzXxPkdyXXhh+VhsQyvdjxsqLD4anuXsS33gbmxMDbLH7pXLSmj+T
	 hg+juQ4+7Y9XxhiMAbmo6HPAYeHfjwtHf1IcbUu8dY177AG1te1swhEbiGr0Csqo2m
	 +BeRCGjbTW7SKsOd863K9CMhILOMo/IWwH8B5Fn4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 21:47:07 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 03D33C169530;
	Mon, 10 Jul 2023 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689050827; bh=12/XcpfG3xcTGqMUp9sBtLNZFJZX9ojGxeC5uKqHxlI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qySSgXcZ6hfxpzXxPkdyXXhh+VhsQyvdjxsqLD4anuXsS33gbmxMDbLH7pXLSmj+T
	 hg+juQ4+7Y9XxhiMAbmo6HPAYeHfjwtHf1IcbUu8dY177AG1te1swhEbiGr0Csqo2m
	 +BeRCGjbTW7SKsOd863K9CMhILOMo/IWwH8B5Fn4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AE90DC169530
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 21:47:05 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.096
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AGkEWDFF3x9M for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 21:47:01 -0700 (PDT)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D1905C15109B
 for <bpf@ietf.org>; Mon, 10 Jul 2023 21:47:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b717e9d423so27952511fa.1
 for <bpf@ietf.org>; Mon, 10 Jul 2023 21:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689050820; x=1691642820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WtPqk+6efPvU9PidMZCkDRjbOAk0RVLnoir7RR0hoE=;
 b=ZLDb61qbQBSAy/NOC/5lD+sZ21YgRIb/og1ZzwDTexzY0O1zxAjDC0omOkVzfqNTbG
 c3vmW5aeC7KkAQ4cY/gzSrf87sG5hr68gywOn9jRKrWo/ZPd8ZY2sBjFxcg5wxdk/9eS
 t7TRlKBk1Xr4pfoK1+zvMFq/r3CVSUrl0UiGrQjtWvKeuFbGQWtbXKba64KVS4LcyR36
 AYT0lwAKLLAUv+Bi09ofxfKc5tiEnkbVtiod9tfcqm4NYTYmZHeSHabl3XRv7Vwz+awf
 ba25B+LtfPh6K+kOGiNwUkZ8q5QQf0h9aDqThClU1SHONa4vGOtmW8oNgslOJHXy1HL4
 GUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689050820; x=1691642820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WtPqk+6efPvU9PidMZCkDRjbOAk0RVLnoir7RR0hoE=;
 b=OWyXPP3l4vgPuuGm5GyPUwZr65K9G5QR6KXY2aJgB3UslrbOb0YWSxAJxOJZA/8IPn
 K8VeWgxBmEjvr+WUCengLLGQWlXRRCsahVfdfZF4DqgjIekhZQHSu0C8XKYBvNJ0MNf7
 tq9dDKWyqvX2KkeFhpFSvwKmIgYgsuGzXlRq/xxuMQ7P+3dARye+IJ48MvapGC3rP8oR
 iL8EsL9jujSfaEf/owshQJdxj/7Tc1iNNbCGPpValh5S1EB46A8S+Oh3xFUdmvTmccYf
 QQ5cF/UUQ9WmJ2eabBBSOUUbY1++OIJfq5mCetaF+V1izFZcYHJbfDX9wWAaFp+02CHF
 xKMQ==
X-Gm-Message-State: ABy/qLbHm716P4xfj8T+QzprJA1n81ND/r4qzPY8PToiGcgFJJAYDX0A
 C8b2izycGKMtszzFzoOY3bLQ32IipAECN/j/jRw=
X-Google-Smtp-Source: APBJJlFTgw2KDx4ae2+/8cEbMybK19AfRSMlbeWfU9BNuPOKAOhDBJLsk4sTbjqWWAmJObD/5NXYL7hvY3fbaaggSCE=
X-Received: by 2002:a2e:3c04:0:b0:2b6:98c2:635f with SMTP id
 j4-20020a2e3c04000000b002b698c2635fmr5990631lja.11.1689050819712; Mon, 10 Jul
 2023 21:46:59 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 21:46:48 -0700
Message-ID: <CAADnVQJR7YFcjqgiGABX-_jJEK7rQTrO8cGFJiZ16oOtpbmVNA@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/V13QQBeDmdsD0HHIvn_WerNL0uI>
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

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgODoxOeKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IE9uIE1vbiwgSnVsIDEwLCAyMDIzIGF0IDExOjAw4oCvUE0gQWxl
eGVpIFN0YXJvdm9pdG92Cj4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+
ID4KPiA+IE9uIE1vbiwgSnVsIDEwLCAyMDIzIGF0IDI6NTjigK9QTSBXaWxsIEhhd2tpbnMgPGhh
d2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEluIHRoZSBkb2N1bWVudGF0aW9uIG9m
IHRoZSBlQlBGIElTQSBpdCBpcyB1bnNwZWNpZmllZCBob3cgaW50ZWdlcnMgYXJlCj4gPiA+IHJl
cHJlc2VudGVkLiBTcGVjaWZ5IHRoYXQgdHdvcyBjb21wbGVtZW50IGlzIHVzZWQuCj4gPiA+Cj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPgo+ID4gPiAt
LS0KPiA+ID4gIERvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QgfCA1ICsrKysr
Cj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0IGIvRG9jdW1lbnRh
dGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gPiBpbmRleCA3NTFlNjU3OTczZjAuLjYz
ZGZjYmE1ZWI5YSAxMDA2NDQKPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rp
b24tc2V0LnJzdAo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQu
cnN0Cj4gPiA+IEBAIC0xNzMsNiArMTczLDExIEBAIEJQRl9BUlNIICAweGMwICAgc2lnbiBleHRl
bmRpbmcgZHN0ID4+PSAoc3JjICYgbWFzaykKPiA+ID4gIEJQRl9FTkQgICAweGQwICAgYnl0ZSBz
d2FwIG9wZXJhdGlvbnMgKHNlZSBgQnl0ZSBzd2FwIGluc3RydWN0aW9uc2BfIGJlbG93KQo+ID4g
PiAgPT09PT09PT0gID09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Cj4gPiA+Cj4gPiA+ICtlQlBGIHN1cHBvcnRzIDMyLSBhbmQg
NjQtYml0IHNpZ25lZCBhbmQgdW5zaWduZWQgaW50ZWdlcnMuIEl0IGRvZXMKPiA+ID4gK25vdCBz
dXBwb3J0IGZsb2F0aW5nLXBvaW50IGRhdGEgdHlwZXMuIEFsbCBzaWduZWQgaW50ZWdlcnMgYXJl
IHJlcHJlc2VudGVkIGluCj4gPiA+ICt0d29zLWNvbXBsZW1lbnQgZm9ybWF0IHdoZXJlIHRoZSBz
aWduIGJpdCBpcyBzdG9yZWQgaW4gdGhlIG1vc3Qtc2lnbmlmaWNhbnQKPiA+ID4gK2JpdC4KPiA+
Cj4gPiBDb3VsZCB5b3UgcG9pbnQgdG8gYW5vdGhlciBJU0EgZG9jdW1lbnQgKGxpa2UgeDg2LCBh
cm0sIC4uLikgdGhhdAo+ID4gdGFsa3MgYWJvdXQgc2lnbmVkIGFuZCB1bnNpZ25lZCBpbnRlZ2Vy
cz8KPgo+IFRoYW5rIHlvdSBmb3IgdGhlIHJlcGx5LiBJIGhvcGUgdGhhdCB0aGlzIGNoYW5nZSBp
cyB1c2VmdWwuIEkgcHJvcG9zZWQKPiB0aGlzIGNoYW5nZSB0byBtaW1pYyB0aGUgZG9jdW1lbnRh
dGlvbiBvZiAiTnVtZXJpYyBEYXRhIFR5cGVzIiBpbgo+IFZvbHVtZSAxLCBDaGFwdGVyIDQgb2Yg
IkludGVswq4gNjQgYW5kIElBLTMyIEFyY2hpdGVjdHVyZXMgU29mdHdhcmUKPiBEZXZlbG9wZXLi
gJlzIE1hbnVhbCIgWzFdLgo+Cj4gWzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3
dy91cy9lbi9kZXZlbG9wZXIvYXJ0aWNsZXMvdGVjaG5pY2FsL2ludGVsLXNkbS5odG1sCgpJIHNl
ZSB3aGVyZSB5b3UgZ290IHRoZSBpbnNwaXJhdGlvbiBmcm9tLgpJdCdzIGEgInNvZnR3YXJlIGRl
dmVsb3BlcidzIG1hbnVhbCIuIE5vdCBhbiBJU0Egc3BlYy4KQnV0LCBzYXksIHdlIGFkb3B0IHRo
aXMgZm9ybSBhbmQgcHJvY2VlZCB0byBjcmVhdGUgYWxsIDUwMCBwYWdlcyBvZiBpdC4KClNETSBo
YXMgdGhpcyB0byBzYXkgYWJvdXQgcG9pbnRlcnM6CiJQb2ludGVycyBhcmUgYWRkcmVzc2VzIG9m
IGxvY2F0aW9ucyBpbiBtZW1vcnkuCkluIG5vbi02NC1iaXQgbW9kZXMsIHRoZSBhcmNoaXRlY3R1
cmUgZGVmaW5lcyB0d28gdHlwZXMgb2YgcG9pbnRlcnM6IGEKbmVhciBwb2ludGVyIGFuZCBhIGZh
ciBwb2ludGVyLiBBIG5lYXIgcG9pbnRlciBpcyBhIDMyLWJpdCAob3IgMTYtYml0KQpvZmZzZXQg
KGFsc28gY2FsbGVkIGFuIGVmZmVjdGl2ZSBhZGRyZXNzKSB3aXRoaW4gYSBzZWdtZW50LiBOZWFy
CnBvaW50ZXJzIGFyZSB1c2VkCmZvciBhbGwgbWVtb3J5IHJlZmVyZW5jZXMgaW4gYSBmbGF0IG1l
bW9yeSBtb2RlbCBvciBmb3IgcmVmZXJlbmNlcyBpbgphIHNlZ21lbnRlZCBtb2RlbCB3aGVyZSB0
aGUgaWRlbnRpdHkgb2YgdGhlIHNlZ21lbnQgYmVpbmcgYWNjZXNzZWQgaXMKaW1wbGllZC4iCgpC
UEYgcnVucyBvbiAzMi1iaXQgYW5kIDY0LWJpdCBDUFVzLCBzbyBpZiB3ZSBkb2N1bWVudCBzaWdu
ZWQgdnMgdW5zaWduZWQKaW50ZWdlcnMgd2UnZCBoYXZlIHRvIHNheSBhIGZldyB3b3JkcyBhYm91
dCBwb2ludGVycywgYml0ZmllbGRzIGFuZCBzdHJpbmdzCihqdXN0IGxpa2UgSW50ZWwgU0RNKS4g
UG9pbnRlcnMgaW4gQlBGIGFyZSBjbGVhcmx5IGxhY2tpbmcgZG9jcy4KCkJleW9uZCBWb2wgMSwg
Q2hhcHRlciA0IHRoZXJlIGFyZSBwbGVudHkgb2Ygb3RoZXIgY2hhcHRlcnMuClNob3VsZCB3ZSBo
YXZlIGFuIGVxdWl2YWxlbnQgZm9yIGFsbCBvZiB0aGVtPwpJIHRoaW5rIGl0IHdvdWxkIGJlIGdy
ZWF0IHRvIGhhdmUgc29tZXRoaW5nIGZvciBhbGwgdGhhdCwKYnV0IGRyb3BwaW5nIGEgcGF0Y2gg
b3IgdHdvIHdvbid0IGdldCB1cyB0aGVyZS4KSXQgbmVlZHMgdG8gYmUgYSBmdWxsIHRpbWUgY29t
bWl0bWVudCB3aXRoIFNPVywgcm9hZG1hcCwgZXRjLgpJIGRvdWJ0IHRoZSBrZXJuZWwgYW5kL29y
IElFVEYgcHJvY2VzcyBjYW4gYWNjb21tb2RhdGUgdGhhdC4KClNheWluZyBpdCBkaWZmZXJlbnRs
eS4gV2hhdCBpcyBtaXNzaW5nIGluIGluc3RydWN0aW9uLXNldC5yc3QKZnJvbSBtYWtpbmcgYW4g
SUVURiBzdGFuZGFyZCBvdXQgb2YgaXQ/CkRvZXMgaXQgbmVlZCBhIHNpZ25lZCB2cyB1bnNpZ25l
ZCBTRE0tbGlrZSBwYXJhZ3JhcGg/CgpMZXQncyBmb2N1cyBvbiBjb252ZXJ0aW5nIGluc3RydWN0
aW9uLXNldC5yc3QgaW50byBhIHN0YW5kYXJkCmFzIGZhc3QgYXMgcG9zc2libGUgYW5kIHRhY2ts
ZSBhbGwgbmljZS10by1oYXZlIGxhdGVyLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYu
b3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

