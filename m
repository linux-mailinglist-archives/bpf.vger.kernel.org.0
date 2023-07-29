Return-Path: <bpf+bounces-6291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B642767954
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E211C21171
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC92198;
	Sat, 29 Jul 2023 00:05:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6717E
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:05:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F0544B2
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:05:20 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 17120C15171B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690589120; bh=yx/efpJlmFRmL9pURWgajCreryc0mn+ImKNLNx5IF+Q=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XwYmky9nlGrkpbhBB/GdCMhbojohD5XTWc5cY7zi+ZluxZOd18H05YrV99j75UFGi
	 9fpSqAsYLs442W4MokwnMkFr9XLLQfT9RpbgiWqFn3Xw6VwuwUH2JDV8u0KnVDzKVJ
	 qBDjBV40zIo0OFawGwgLCtg9piI9uPrvZr8QvEPo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 17:05:20 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E6283C15106D;
	Fri, 28 Jul 2023 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690589119; bh=yx/efpJlmFRmL9pURWgajCreryc0mn+ImKNLNx5IF+Q=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=FrN759hIbXXJ/RnewqWxAiUdtQobAK6FLqKPQL/kINy9pCDj/5jktylgOHASXc9Nu
	 5hYGCU7hvEXrZHqwlnvosHZJI+II7UtMHYGKvEP3okNZQFMHepQE+IDGNY49IeXBkC
	 bnQdz/8ryizm2IL2Z3mkw5GLTymxysbI6vr7Dq5g=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 23817C15106D
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 17:05:18 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.105
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EwH4uJeisW3g for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 17:05:13 -0700 (PDT)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DD8E3C14CE33
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:05:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b933bbd3eeso40868221fa.1
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690589111; x=1691193911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQvl+XFQJV/FyplddWoLNv6tROKq+wIg/f+EmRjgswA=;
 b=INpmmkJTSjYfP8EzrNF6YpQv0P9Mk4UzqJzO4icSOsyTCY8iKTqFjGVlV+NxxFrmC8
 evjIOuO6ZMz5fr6BXnZsSnR2D1UNg66HhygdGVGi9qlYtmPdnCbjegLyRr/8sgWQNKua
 6r/iZS7QW6o7QaqUu0X7x8uiNGjNM4/GEXVI/zFSc1tyDd3dxXcp1KSa/tDkf6af+X1M
 57//edYa5Seb0QVOmhFB/5ENo9zt3KamVhituOL1yCqJMEkXIRe/J5I3JAYxPVGLCjN3
 AJvpFwgzeXyzSNU7rV8F8yWXX3s98ezQ2HEbIJclrQVq5yh6h5ZCQyxlRbdUzVc7xmja
 JiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690589111; x=1691193911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQvl+XFQJV/FyplddWoLNv6tROKq+wIg/f+EmRjgswA=;
 b=h6Y49+ZN3+Gsx0j/sRUM/Kq5mAdX2wrPaAj/JmrgP9uQMPQ1o5iiaV5rLnxp0YoRkA
 uyGN6hEMVy+ZLUrCHBGi6ZarORSuSiK9adu8go+U6uLoefVXXicdXzxAtnQVJq6rsNCe
 O3bwRtazAO9azQJxwCOdC1nYj+29sP96XTJybzDkOKgNWi+baCiQW5sx22lTqSW9vpDF
 8NBhgur/48Ld8G8/Xcxz2AojnDqlFUUIPaklhaRUTv5DC82+3xlpyoGD1+4vIBeqMI7z
 eJM1tH0NzQHFN4FptfU+sV16hzl0B7zC/CECVXFhcm0bD9497xUEcEKXrCYiVQI3Ag4z
 cWNQ==
X-Gm-Message-State: ABy/qLZPg5ojJTTY76GWXoA9us4GDiEc71tOcttQieNmX+UBbJomEb3+
 kYTpeTNwEEf6zvkXd7iQQj/cHYu4VXEyNcrdY62Fa2ns
X-Google-Smtp-Source: APBJJlGxrbDavYSe9WYUqYj9Y9egecU1sNaONRWlrT90MspDEkfPoVyoyILOzZQL4X+K8o2o3te54aHs68QridEJgbA=
X-Received: by 2002:a2e:98c2:0:b0:2b6:9ed0:46f4 with SMTP id
 s2-20020a2e98c2000000b002b69ed046f4mr2861634ljj.23.1690589111218; Fri, 28 Jul
 2023 17:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
In-Reply-To: <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 17:04:59 -0700
Message-ID: <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ej_v3dHdSo7oS4s1DUH4GjyihUM>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNDozMuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDk6MDXigK9QTSBBbGV4
ZWkgU3Rhcm92b2l0b3YKPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
Pgo+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMTI6MTbigK9QTSBXaWxsIEhhd2tpbnMgPGhh
d2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0
IDI6MzfigK9QTSBXYXRzb24gTGFkZCA8d2F0c29uYmxhZGRAZ21haWwuY29tPiB3cm90ZToKPiA+
ID4gPgo+ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDk6MTXigK9BTSBBbGV4ZWkgU3Rh
cm92b2l0b3YKPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNzowM+KAr0FNIERhdmUg
VGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiBJIGFtIGZvcndhcmRpbmcgdGhlIGVtYWlsIGJlbG93IChhZnRlciBjb252ZXJ0aW5nIEhU
TUwgdG8gcGxhaW4gdGV4dCkKPiA+ID4gPiA+ID4gdG8gdGhlIG1haWx0bzpicGZAdmdlci5rZXJu
ZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4gZ28gdG8gYm90aCBsaXN0cy4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gUGxlYXNlIHVzZSB0aGlzIG9uZSBmb3IgYW55IHJlcGxpZXMuCj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiA+ID4gRGF2ZQo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IEZyb206IEJwZiA8YnBmLWJvdW5jZXNAaWV0Zi5vcmc+IE9uIEJlaGFsZiBPZiBX
YXRzb24gTGFkZAo+ID4gPiA+ID4gPiA+IFNlbnQ6IE1vbmRheSwgSnVseSAyNCwgMjAyMyAxMDow
NSBQTQo+ID4gPiA+ID4gPiA+IFRvOiBicGZAaWV0Zi5vcmcKPiA+ID4gPiA+ID4gPiBTdWJqZWN0
OiBbQnBmXSBSZXZpZXcgb2YgZHJhZnQtdGhhbGVyLWJwZi1pc2EtMDEKPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IERlYXIgQlBGIHdnLAo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSSB0
b29rIGEgbG9vayBhdCB0aGUgZHJhZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21lIGlzc3VlcywgdW5z
dXJwcmlzaW5nbHkgYXQgdGhpcyBzdGFnZS4gT25lIGlzCj4gPiA+ID4gPiA+ID4gdGhlIHNwZWNp
ZmljYXRpb24gc2VlbXMgdG8gdXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNvZGUgZm9y
IG9wZXJhdGlvbnMgdnMKPiA+ID4gPiA+ID4gPiBkZWZpbmluZyB0aGVtIG1hdGhlbWF0aWNhbGx5
Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IEhpIFdhdHNvbiwKPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGlz
IGlzIG5vdCAidW5kZXJzcGVjaWZpZWQgQyIgcHNldWRvIGNvZGUuCj4gPiA+ID4gPiBUaGlzIGlz
IGFzc2VtYmx5IHN5bnRheCBwYXJzZWQgYW5kIGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExp
bnV4IEtlcm5lbCwgZXRjLgo+ID4gPiA+Cj4gPiA+ID4gSSBkb24ndCBzZWUgYSByZWZlcmVuY2Ug
dG8gYW55IGRlc2NyaXB0aW9uIG9mIHRoYXQgaW4gc2VjdGlvbiA0LjEuCj4gPiA+ID4gSXQncyBw
b3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQgdGhpcywgYW5kIGlmIHBlb3BsZSB0aGluayB0aGlzIHN0
eWxlIG9mCj4gPiA+ID4gZGVmaW5pdGlvbiBpcyBnb29kIGVub3VnaCB0aGF0IHdvcmtzIGZvciBt
ZS4gQnV0IEkgZm91bmQgdGFibGUgNAo+ID4gPiA+IHByZXR0eSBzY2FudHkgb24gd2hhdCBleGFj
dGx5IGhhcHBlbnMuCj4gPiA+Cj4gPiA+IEhlbGxvISBCYXNlZCBvbiBXYXRzb24ncyBwb3N0LCBJ
IGhhdmUgZG9uZSBzb21lIHJlc2VhcmNoIGFuZCB3b3VsZAo+ID4gPiBwb3RlbnRpYWxseSBsaWtl
IHRvIG9mZmVyIGEgcGF0aCBmb3J3YXJkLiBUaGVyZSBhcmUgc2V2ZXJhbCBkaWZmZXJlbnQKPiA+
ID4gd2F5cyB0aGF0IElTQXMgc3BlY2lmeSB0aGUgc2VtYW50aWNzIG9mIHRoZWlyIG9wZXJhdGlv
bnM6Cj4gPiA+Cj4gPiA+IDEuIEludGVsIGhhcyBhIHNlY3Rpb24gaW4gdGhlaXIgbWFudWFsIHRo
YXQgZGVzY3JpYmVzIHRoZSBwc2V1ZG9jb2RlCj4gPiA+IHRoZXkgdXNlIHRvIHNwZWNpZnkgdGhl
aXIgSVNBOiBTZWN0aW9uIDMuMS4xLjkgb2YgVGhlIEludGVswq4gNjQgYW5kCj4gPiA+IElBLTMy
IEFyY2hpdGVjdHVyZXMgU29mdHdhcmUgRGV2ZWxvcGVy4oCZcyBNYW51YWwgYXQKPiA+ID4gaHR0
cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvNjcxMTk5Cj4gPiA+IDIuIEFS
TSBoYXMgYW4gZXF1aXZhbGVudCBmb3IgdGhlaXIgdmFyaWV0eSBvZiBwc2V1ZG9jb2RlOiBDaGFw
dGVyIEoxCj4gPiA+IG9mIEFybSBBcmNoaXRlY3R1cmUgUmVmZXJlbmNlIE1hbnVhbCBmb3IgQS1w
cm9maWxlIGFyY2hpdGVjdHVyZSBhdAo+ID4gPiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2Rv
Y3VtZW50YXRpb24vZGRpMDQ4Ny9sYXRlc3QvCj4gPiA+IDMuIFNhaWwgImlzIGEgbGFuZ3VhZ2Ug
Zm9yIGRlc2NyaWJpbmcgdGhlIGluc3RydWN0aW9uLXNldCBhcmNoaXRlY3R1cmUKPiA+ID4gKElT
QSkgc2VtYW50aWNzIG9mIHByb2Nlc3NvcnMuIgo+ID4gPiAoaHR0cHM6Ly93d3cuY2wuY2FtLmFj
LnVrL35wZXMyMC9zYWlsLykKPiA+ID4KPiA+ID4gR2l2ZW4gdGhlIGNvbW1lcmNpYWwgbmF0dXJl
IG9mICgxKSBhbmQgKDIpLCBwZXJoYXBzIFNhaWwgaXMgYSB3YXkgdG8KPiA+ID4gcHJvY2VlZC4g
SWYgcGVvcGxlIGFyZSBpbnRlcmVzdGVkLCBJIHdvdWxkIGJlIGhhcHB5IHRvIGxlYWQgYW4gZWZm
b3J0Cj4gPiA+IHRvIGVuY29kZSB0aGUgZUJQRiBJU0Egc2VtYW50aWNzIGluIFNhaWwgKG9yIGZp
bmQgc29tZW9uZSB3aG8gYWxyZWFkeQo+ID4gPiBoYXMpIGFuZCBpbmNvcnBvcmF0ZSB0aGVtIGlu
IHRoZSBkcmFmdC4KPiA+Cj4gPiBpbW8gU2FpbCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUgcHJh
Y3RpY2FsIHVzZS4KPiA+IExvb2tpbmcgYXQgYXJtNjQgb3IgeDg2IFNhaWwgZGVzY3JpcHRpb24g
SSByZWFsbHkgZG9uJ3Qgc2VlIGhvdwo+ID4gaXQgd291bGQgbWFwIHRvIGFuIElFVEYgc3RhbmRh
cmQuCj4gPiBJdCdzIGRvbmUgaW4gYSAic2FpbCIgbGFuZ3VhZ2UgdGhhdCBwZW9wbGUgbmVlZCB0
byBsZWFybiBmaXJzdCB0byBiZQo+ID4gYWJsZSB0byByZWFkIGl0Lgo+ID4gU2F5IHdlIGhhZCBi
cGYuc2FpbCBzb21ld2hlcmUgb24gZ2l0aHViLiBXaGF0IHZhbHVlIGRvZXMgaXQgYnJpbmcgdG8K
PiA+IEJQRiBJU0Egc3RhbmRhcmQ/IEkgZG9uJ3Qgc2VlIGFuIGltbWVkaWF0ZSBiZW5lZml0IHRv
IHN0YW5kYXJkaXphdGlvbi4KPiA+IFRoZXJlIGNvdWxkIGJlIG90aGVyIHVzZSBjYXNlcywgbm8g
ZG91YnQsIGJ1dCBzdGFuZGFyZGl6YXRpb24gaXMgb3VyIGdvYWwuCj4gPgo+ID4gQXMgZmFyIGFz
IDEgYW5kIDIuIEludGVsIGFuZCBBcm0gdXNlIHRoZWlyIG93biBwc2V1ZG9jb2RlLCBzbyB0aGV5
IGhhZAo+ID4gdG8gYWRkIGEgcGFyYWdyYXBoIHRvIGRlc2NyaWJlIGl0LiBXZSBhcmUgdXNpbmcg
QyB0byBkZXNjcmliZSBCUEYgSVNBCj4KPgo+IEkgY2Fubm90IGZpbmQgYSByZWZlcmVuY2UgaW4g
dGhlIGN1cnJlbnQgdmVyc2lvbiB0aGF0IHNwZWNpZmllcyB3aGF0Cj4gd2UgYXJlIHVzaW5nIHRv
IGRlc2NyaWJlIHRoZSBvcGVyYXRpb25zLiBJJ2QgbGlrZSB0byBhZGQgdGhhdCwgYnV0Cj4gd2Fu
dCB0byBtYWtlIHN1cmUgdGhhdCBJIGNsYXJpZnkgdHdvIHN0YXRlbWVudHMgdGhhdCBzZWVtIHRv
IGJlIGF0Cj4gb2Rkcy4KPgo+IEltbWVkaWF0ZWx5IGFib3ZlIHlvdSBzYXkgdGhhdCB3ZSBhcmUg
dXNpbmcgIkMgdG8gZGVzY3JpYmUgdGhlIEJQRgo+IElTQSIgYW5kIGZ1cnRoZXIgYWJvdmUgeW91
IHNheSAiVGhpcyBpcyBhc3NlbWJseSBzeW50YXggcGFyc2VkIGFuZAo+IGVtaXR0ZWQgYnkgR0ND
LCBMTFZNLCBnYXMsIExpbnV4IEtlcm5lbCwgZXRjLiIKPgo+IE15IG93biByZWFkaW5nIGlzIHRo
YXQgaXQgaXMgdGhlIGZvcm1lciwgYW5kIG5vdCB0aGUgbGF0dGVyLiBCdXQsIEkKPiB3YW50IHRv
IGRvdWJsZSBjaGVjayBiZWZvcmUgYWRkaW5nIHRoZSBhcHByb3ByaWF0ZSBzdGF0ZW1lbnRzIHRv
IHRoZQo+IENvbnZlbnRpb24gc2VjdGlvbi4KCkl0J3MgYm90aC4gSSdtIG5vdCBzdXJlIHdoZXJl
IHlvdSBzZWUgYSBjb250cmFkaWN0aW9uLgpJdCdzIGEgbm9ybWFsIEMgc3ludGF4IGFuZCBpdCdz
IGVtaXR0ZWQgYnkgdGhlIGtlcm5lbCB2ZXJpZmllciwKcGFyc2VkIGJ5IGNsYW5nL2djYyBhc3Nl
bWJsZXJzIGFuZCBlbWl0dGVkIGJ5IGNvbXBpbGVycy4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJw
ZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

