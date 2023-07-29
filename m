Return-Path: <bpf+bounces-6307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F4767BD6
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 05:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244301C2099F
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 03:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB8138E;
	Sat, 29 Jul 2023 03:14:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECB1385
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 03:14:11 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2824B423B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 20:14:08 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B77A2C151556
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690600448; bh=QcG6bh5/7dxTXD4Q7l4Tl1JhMpmzyg+SOHZvYSRYY6Y=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Dwm3Y6iF1zblTet9DpR/7axcatGSJkymH4+zm6sOhvnZe/a3KJHf1AoCDjj64hNPZ
	 I//nT1Y4nmy6n97X0Cv4J0tXEPCgGXIVn4dzvlQvyIExOctgO2YFS+kMusllm6GHP1
	 rqu3K/R+Gthop2w/L1Ky3tv8w5U9mNqxMNrwnrDs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 20:14:08 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8A2B2C14CE44;
	Fri, 28 Jul 2023 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690600448; bh=QcG6bh5/7dxTXD4Q7l4Tl1JhMpmzyg+SOHZvYSRYY6Y=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Dwm3Y6iF1zblTet9DpR/7axcatGSJkymH4+zm6sOhvnZe/a3KJHf1AoCDjj64hNPZ
	 I//nT1Y4nmy6n97X0Cv4J0tXEPCgGXIVn4dzvlQvyIExOctgO2YFS+kMusllm6GHP1
	 rqu3K/R+Gthop2w/L1Ky3tv8w5U9mNqxMNrwnrDs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E11D8C14CE44
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 20:14:07 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.905
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dJmtDqk2fVqA for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 20:14:03 -0700 (PDT)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CB9D4C14CE42
 for <bpf@ietf.org>; Fri, 28 Jul 2023 20:14:03 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-63d2b7d77bfso17501196d6.3
 for <bpf@ietf.org>; Fri, 28 Jul 2023 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690600442; x=1691205242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EynXy1IlHaEgCD2qI++rDAMuUns1Tp8rqlj3v2t27yc=;
 b=ai+Q4F/tEM6xu+fNAtyGfMAQ3zqdftRUxzcrj6muyskibXAivN1fQxA7BXoOX3ZZ8f
 UvVu9akdR+2FhMJm3vcV3ZRccSEt+TbCOAtXGVoHXdZpnDFDZlAOA5fP2U4YSGHPBWCv
 6ZAVEJ0vtr5MD/fvsT/J2fPPuT7QpmNynNJUjKK2zen4fDpeAwmkIwdAdlN0AgA9xe2c
 rq0TOXgDnFiZ8tF/D7YFCQZCx+2pTrIzqVyHTB+PD+g/mb/MeBZrTZ8cC1Ya4oCKnRoR
 yzghVgnqMp5A1eXMEvnPzcI/QbSrODgALL1DbSohmkDW3b425XhsrVUspEFiesVE3Jud
 UuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690600442; x=1691205242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EynXy1IlHaEgCD2qI++rDAMuUns1Tp8rqlj3v2t27yc=;
 b=SvBWe9UvK6MKoEdjll2MjMon5NnrpiI5UumFt/wQQIOcMp43NbQ9OuP4Mg1AlMYAwU
 AJVIaY/mSvpb0xg7i3D8Ypz7+hr7O8qKFVlT1x5sqzqWYdNqLaRxuLK63enoHTmL5Pex
 CDw0gJZbInv/elVwQhxZhs3a+hZpSdkXzlryMbWD+lnVOnrAzfh62umYsnujLO4lBVT3
 h1GhDRiIuBXZj/j+RifWuYLyx1V7VlKRnoDT5/slH+ZNjajwIZsLfSuzuKo7JZciT5FH
 WMqUYycStuCEkyUl8ag85QJET3q19whAPr8bBNV0v8B3wPIkzIU+5fE8vVWWsKbTKkK4
 n0Sg==
X-Gm-Message-State: ABy/qLZOqKjD3EpbAgA0Popa71dmogxnrKBoI/ghMaSv8sjwKkkl+INw
 AyHbzdDVxkW4iy9CfeK70vPlcKMEWjrSnPy+P1XvCw==
X-Google-Smtp-Source: APBJJlEKGrHg6PRopzi7buqaWBWihtX851+fIKxgr93RhG9Up0UcmtA+1QjMUyGQezJA6Cq0v7gVDAnjsjTkA4wy4rY=
X-Received: by 2002:a0c:efc6:0:b0:637:85e3:2a28 with SMTP id
 a6-20020a0cefc6000000b0063785e32a28mr4060330qvt.48.1690600442728; Fri, 28 Jul
 2023 20:14:02 -0700 (PDT)
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
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
 <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
In-Reply-To: <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 23:13:51 -0400
Message-ID: <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/_X8ERETHVeu3IGGgrPtVbTlQtsI>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgMTA6MzLigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPGFs
ZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBKdWwgMjgsIDIw
MjMgYXQgNjowN+KAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+
Cj4gPiBPbiBGcmksIEp1bCAyOCwgMjAyMyBhdCA4OjUy4oCvUE0gQWxleGVpIFN0YXJvdm9pdG92
Cj4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9u
IEZyaSwgSnVsIDI4LCAyMDIzIGF0IDU6NDbigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9i
cy5jcj4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBGcmksIEp1bCAyOCwgMjAyMyBhdCA4OjM1
4oCvUE0gQWxleGVpIFN0YXJvdm9pdG92Cj4gPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFp
bC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0
IDU6MTnigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MDXigK9QTSBBbGV4ZWkg
U3Rhcm92b2l0b3YKPiA+ID4gPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdy
b3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQg
NDozMuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCA5OjA14oCvUE0g
QWxleGVpIFN0YXJvdm9pdG92Cj4gPiA+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdt
YWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFdl
ZCwgSnVsIDI2LCAyMDIzIGF0IDEyOjE24oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMu
Y3I+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVl
LCBKdWwgMjUsIDIwMjMgYXQgMjozN+KAr1BNIFdhdHNvbiBMYWRkIDx3YXRzb25ibGFkZEBnbWFp
bC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDk6MTXigK9BTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBK
dWwgMjUsIDIwMjMgYXQgNzowM+KAr0FNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5j
b20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gSSBhbSBmb3J3YXJkaW5nIHRoZSBlbWFpbCBiZWxvdyAoYWZ0ZXIgY29udmVydGluZyBI
VE1MIHRvIHBsYWluIHRleHQpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdG8gdGhlIG1haWx0
bzpicGZAdmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4gZ28gdG8gYm90aCBsaXN0
cy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFBs
ZWFzZSB1c2UgdGhpcyBvbmUgZm9yIGFueSByZXBsaWVzLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IERhdmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gRnJvbTogQnBmIDxicGYtYm91bmNlc0BpZXRmLm9yZz4gT24gQmVoYWxmIE9mIFdh
dHNvbiBMYWRkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTZW50OiBNb25kYXksIEp1bHkg
MjQsIDIwMjMgMTA6MDUgUE0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRvOiBicGZAaWV0
Zi5vcmcKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFN1YmplY3Q6IFtCcGZdIFJldmlldyBv
ZiBkcmFmdC10aGFsZXItYnBmLWlzYS0wMQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IERlYXIgQlBGIHdnLAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgdG9vayBhIGxvb2sgYXQgdGhl
IGRyYWZ0IGFuZCB0aGluayBpdCBoYXMgc29tZSBpc3N1ZXMsIHVuc3VycHJpc2luZ2x5IGF0IHRo
aXMgc3RhZ2UuIE9uZSBpcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlIHNwZWNpZmlj
YXRpb24gc2VlbXMgdG8gdXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNvZGUgZm9yIG9w
ZXJhdGlvbnMgdnMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRlZmluaW5nIHRoZW0gbWF0
aGVtYXRpY2FsbHkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IEhpIFdhdHNvbiwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gVGhpcyBpcyBub3QgInVuZGVyc3BlY2lmaWVkIEMiIHBzZXVkbyBjb2RlLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGFzc2VtYmx5IHN5bnRheCBwYXJzZWQgYW5kIGVtaXR0
ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtlcm5lbCwgZXRjLgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3Qgc2VlIGEgcmVmZXJlbmNlIHRvIGFu
eSBkZXNjcmlwdGlvbiBvZiB0aGF0IGluIHNlY3Rpb24gNC4xLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gSXQncyBwb3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQgdGhpcywgYW5kIGlmIHBlb3BsZSB0aGlu
ayB0aGlzIHN0eWxlIG9mCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkZWZpbml0aW9uIGlzIGdvb2Qg
ZW5vdWdoIHRoYXQgd29ya3MgZm9yIG1lLiBCdXQgSSBmb3VuZCB0YWJsZSA0Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBwcmV0dHkgc2NhbnR5IG9uIHdoYXQgZXhhY3RseSBoYXBwZW5zLgo+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gSGVsbG8hIEJhc2VkIG9uIFdhdHNvbidz
IHBvc3QsIEkgaGF2ZSBkb25lIHNvbWUgcmVzZWFyY2ggYW5kIHdvdWxkCj4gPiA+ID4gPiA+ID4g
PiA+ID4gcG90ZW50aWFsbHkgbGlrZSB0byBvZmZlciBhIHBhdGggZm9yd2FyZC4gVGhlcmUgYXJl
IHNldmVyYWwgZGlmZmVyZW50Cj4gPiA+ID4gPiA+ID4gPiA+ID4gd2F5cyB0aGF0IElTQXMgc3Bl
Y2lmeSB0aGUgc2VtYW50aWNzIG9mIHRoZWlyIG9wZXJhdGlvbnM6Cj4gPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiAxLiBJbnRlbCBoYXMgYSBzZWN0aW9uIGluIHRoZWlyIG1h
bnVhbCB0aGF0IGRlc2NyaWJlcyB0aGUgcHNldWRvY29kZQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRo
ZXkgdXNlIHRvIHNwZWNpZnkgdGhlaXIgSVNBOiBTZWN0aW9uIDMuMS4xLjkgb2YgVGhlIEludGVs
wq4gNjQgYW5kCj4gPiA+ID4gPiA+ID4gPiA+ID4gSUEtMzIgQXJjaGl0ZWN0dXJlcyBTb2Z0d2Fy
ZSBEZXZlbG9wZXLigJlzIE1hbnVhbCBhdAo+ID4gPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vY2Ry
ZHYyLmludGVsLmNvbS92MS9kbC9nZXRDb250ZW50LzY3MTE5OQo+ID4gPiA+ID4gPiA+ID4gPiA+
IDIuIEFSTSBoYXMgYW4gZXF1aXZhbGVudCBmb3IgdGhlaXIgdmFyaWV0eSBvZiBwc2V1ZG9jb2Rl
OiBDaGFwdGVyIEoxCj4gPiA+ID4gPiA+ID4gPiA+ID4gb2YgQXJtIEFyY2hpdGVjdHVyZSBSZWZl
cmVuY2UgTWFudWFsIGZvciBBLXByb2ZpbGUgYXJjaGl0ZWN0dXJlIGF0Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0aW9uL2RkaTA0ODcvbGF0
ZXN0Lwo+ID4gPiA+ID4gPiA+ID4gPiA+IDMuIFNhaWwgImlzIGEgbGFuZ3VhZ2UgZm9yIGRlc2Ny
aWJpbmcgdGhlIGluc3RydWN0aW9uLXNldCBhcmNoaXRlY3R1cmUKPiA+ID4gPiA+ID4gPiA+ID4g
PiAoSVNBKSBzZW1hbnRpY3Mgb2YgcHJvY2Vzc29ycy4iCj4gPiA+ID4gPiA+ID4gPiA+ID4gKGh0
dHBzOi8vd3d3LmNsLmNhbS5hYy51ay9+cGVzMjAvc2FpbC8pCj4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiBHaXZlbiB0aGUgY29tbWVyY2lhbCBuYXR1cmUgb2YgKDEpIGFu
ZCAoMiksIHBlcmhhcHMgU2FpbCBpcyBhIHdheSB0bwo+ID4gPiA+ID4gPiA+ID4gPiA+IHByb2Nl
ZWQuIElmIHBlb3BsZSBhcmUgaW50ZXJlc3RlZCwgSSB3b3VsZCBiZSBoYXBweSB0byBsZWFkIGFu
IGVmZm9ydAo+ID4gPiA+ID4gPiA+ID4gPiA+IHRvIGVuY29kZSB0aGUgZUJQRiBJU0Egc2VtYW50
aWNzIGluIFNhaWwgKG9yIGZpbmQgc29tZW9uZSB3aG8gYWxyZWFkeQo+ID4gPiA+ID4gPiA+ID4g
PiA+IGhhcykgYW5kIGluY29ycG9yYXRlIHRoZW0gaW4gdGhlIGRyYWZ0Lgo+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBpbW8gU2FpbCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUg
cHJhY3RpY2FsIHVzZS4KPiA+ID4gPiA+ID4gPiA+ID4gTG9va2luZyBhdCBhcm02NCBvciB4ODYg
U2FpbCBkZXNjcmlwdGlvbiBJIHJlYWxseSBkb24ndCBzZWUgaG93Cj4gPiA+ID4gPiA+ID4gPiA+
IGl0IHdvdWxkIG1hcCB0byBhbiBJRVRGIHN0YW5kYXJkLgo+ID4gPiA+ID4gPiA+ID4gPiBJdCdz
IGRvbmUgaW4gYSAic2FpbCIgbGFuZ3VhZ2UgdGhhdCBwZW9wbGUgbmVlZCB0byBsZWFybiBmaXJz
dCB0byBiZQo+ID4gPiA+ID4gPiA+ID4gPiBhYmxlIHRvIHJlYWQgaXQuCj4gPiA+ID4gPiA+ID4g
PiA+IFNheSB3ZSBoYWQgYnBmLnNhaWwgc29tZXdoZXJlIG9uIGdpdGh1Yi4gV2hhdCB2YWx1ZSBk
b2VzIGl0IGJyaW5nIHRvCj4gPiA+ID4gPiA+ID4gPiA+IEJQRiBJU0Egc3RhbmRhcmQ/IEkgZG9u
J3Qgc2VlIGFuIGltbWVkaWF0ZSBiZW5lZml0IHRvIHN0YW5kYXJkaXphdGlvbi4KPiA+ID4gPiA+
ID4gPiA+ID4gVGhlcmUgY291bGQgYmUgb3RoZXIgdXNlIGNhc2VzLCBubyBkb3VidCwgYnV0IHN0
YW5kYXJkaXphdGlvbiBpcyBvdXIgZ29hbC4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gQXMgZmFyIGFzIDEgYW5kIDIuIEludGVsIGFuZCBBcm0gdXNlIHRoZWlyIG93biBwc2V1
ZG9jb2RlLCBzbyB0aGV5IGhhZAo+ID4gPiA+ID4gPiA+ID4gPiB0byBhZGQgYSBwYXJhZ3JhcGgg
dG8gZGVzY3JpYmUgaXQuIFdlIGFyZSB1c2luZyBDIHRvIGRlc2NyaWJlIEJQRiBJU0EKPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSBjYW5ub3QgZmluZCBh
IHJlZmVyZW5jZSBpbiB0aGUgY3VycmVudCB2ZXJzaW9uIHRoYXQgc3BlY2lmaWVzIHdoYXQKPiA+
ID4gPiA+ID4gPiA+IHdlIGFyZSB1c2luZyB0byBkZXNjcmliZSB0aGUgb3BlcmF0aW9ucy4gSSdk
IGxpa2UgdG8gYWRkIHRoYXQsIGJ1dAo+ID4gPiA+ID4gPiA+ID4gd2FudCB0byBtYWtlIHN1cmUg
dGhhdCBJIGNsYXJpZnkgdHdvIHN0YXRlbWVudHMgdGhhdCBzZWVtIHRvIGJlIGF0Cj4gPiA+ID4g
PiA+ID4gPiBvZGRzLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEltbWVkaWF0ZWx5
IGFib3ZlIHlvdSBzYXkgdGhhdCB3ZSBhcmUgdXNpbmcgIkMgdG8gZGVzY3JpYmUgdGhlIEJQRgo+
ID4gPiA+ID4gPiA+ID4gSVNBIiBhbmQgZnVydGhlciBhYm92ZSB5b3Ugc2F5ICJUaGlzIGlzIGFz
c2VtYmx5IHN5bnRheCBwYXJzZWQgYW5kCj4gPiA+ID4gPiA+ID4gPiBlbWl0dGVkIGJ5IEdDQywg
TExWTSwgZ2FzLCBMaW51eCBLZXJuZWwsIGV0Yy4iCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gTXkgb3duIHJlYWRpbmcgaXMgdGhhdCBpdCBpcyB0aGUgZm9ybWVyLCBhbmQgbm90IHRo
ZSBsYXR0ZXIuIEJ1dCwgSQo+ID4gPiA+ID4gPiA+ID4gd2FudCB0byBkb3VibGUgY2hlY2sgYmVm
b3JlIGFkZGluZyB0aGUgYXBwcm9wcmlhdGUgc3RhdGVtZW50cyB0byB0aGUKPiA+ID4gPiA+ID4g
PiA+IENvbnZlbnRpb24gc2VjdGlvbi4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEl0J3Mg
Ym90aC4gSSdtIG5vdCBzdXJlIHdoZXJlIHlvdSBzZWUgYSBjb250cmFkaWN0aW9uLgo+ID4gPiA+
ID4gPiA+IEl0J3MgYSBub3JtYWwgQyBzeW50YXggYW5kIGl0J3MgZW1pdHRlZCBieSB0aGUga2Vy
bmVsIHZlcmlmaWVyLAo+ID4gPiA+ID4gPiA+IHBhcnNlZCBieSBjbGFuZy9nY2MgYXNzZW1ibGVy
cyBhbmQgZW1pdHRlZCBieSBjb21waWxlcnMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IE9rYXkuIEkgYXBvbG9naXplLiBJIGFtIHNpbmNlcmVseSBjb25mdXNlZC4gRm9yIGlu
c3RhbmNlLAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBpZiAodTMyKWRzdCA+PSAodTMyKXNyYyBn
b3RvICtvZmZzZXQKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gTG9va3MgbGlrZSBub3RoaW5nIHRo
YXQgSSBoYXZlIGV2ZXIgc2VlbiBpbiAibm9ybWFsIEMgc3ludGF4Ii4KPiA+ID4gPiA+Cj4gPiA+
ID4gPiBJIHRob3VnaHQgd2UncmUgdGFsa2luZyBhYm91dCB0YWJsZSA0IGFuZCBBTFUgb3BzLgo+
ID4gPiA+ID4gQWJvdmUgaXMgbm90IGEgcHVyZSBDLCBidXQgaXQncyBvYnZpb3VzIGVub3VnaCB3
aXRob3V0IGV4cGxhbmF0aW9uLCBubz8KPiA+ID4gPgo+ID4gPiA+IFRvICJ1cyIsIHllcy4gQWx0
aG91Z2ggSSBhbSBub3QgYW4gZXhwZXJ0LCBpdCBzZWVtcyBsaWtlIGJlaW5nCj4gPiA+ID4gZXhw
bGljaXQgaXMgaW1wb3J0YW50IHdoZW4gaXQgY29tZXMgdG8gd3JpdGluZyBhIHNwZWMuIEkgc3Vw
cG9zZSB3ZQo+ID4gPiA+IHNob3VsZCBsZWF2ZSB0aGF0IHRvIERhdmUgYW5kIHRoZSBjaGFpcnMu
Cj4gPiA+ID4KPiA+ID4gPiA+IEFsc28gSSBkb24ndCBzZWUgYWJvdmUgYW55d2hlcmUgaW4gdGhl
IGRvYy4KPiA+ID4gPgo+ID4gPiA+IFRoYXQgaXMgZnJvbSB0aGUgQXBwZW5kaXguIEl0IGlzIGN1
cnJlbnRseSBpbiBEYXZlJ3MgdHJlZSBhbmQgZ2V0cwo+ID4gPiA+IGFtYWxnYW1hdGVkIHdpdGgg
b3RoZXIgZmlsZXMgdG8gYnVpbGQgdGhlIGZpbmFsIGRyYWZ0Lgo+ID4gPiA+Cj4gPiA+ID4gaHR0
cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvZHJhZnQtdGhhbGVyLWJwZi1pc2EvCj4gPiA+
Cj4gPiA+IFRoaXMgaXMgYSBtaXJyb3IgYW5kIGl0J3MgYWxyZWFkeSBvdXRkYXRlZC4KPiA+ID4g
WW91IHNob3VsZCBsb29rIGF0IHRoZSBzb3VyY2UuIFdoaWNoIGlzIGdpdCBrZXJuZWwgdHJlZS4K
PiA+Cj4gPiBBcyBoZSBkaXNjdXNzZWQgYXQgdGhlIG1lZXRpbmcsIGhlIGhhcyB0aGUgZ2l0aHVi
IHdvcmtmbG93IHRoYXQKPiA+IHByb2R1Y2VzIGEgdmVyc2lvbiBvZiB0aGUgZHJhZnQgUkZDIHRo
YXQgaGUgd2lsbCBzdWJtaXQgdG8gdGhlIFdHOgo+ID4KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9p
ZXRmLXdnLWJwZi9lYnBmLWRvY3MvYmxvYi91cGRhdGUvLmdpdGh1Yi93b3JrZmxvd3MvYnVpbGQu
eW1sCj4gPgo+ID4gVGhhdCB1c2VzCj4gPgo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2lldGYtd2ct
YnBmL2VicGYtZG9jcy9ibG9iL21haW4vcnN0L2luc3RydWN0aW9uLXNldC1za2VsZXRvbi5yc3QK
Pgo+IGNvcnJlY3QuCj4KPiA+IHRvIGJ1aWxkIGluIHRoZSBhY2tub3dsZWRnZW1lbnRzIGFuZCBz
dWJzZXF1ZW50bHkgYnJpbmdzIGluIHRoYXQKPiA+IEFwcGVuZGl4Lgo+Cj4gY29ycmVjdC4KPgo+
ID4gSWYgaGUgcGxhbnMgdG8gdGFrZSB0aGF0IG91dCwgdGhlbiB0aGF0J3MgZ3JlYXQuIEkgd2Fz
IGp1c3QKPiA+IHRyeWluZyB0byBoZWxwLiBTb3JyeS4KPgo+IE5vLiBUaGF0IHdvcmtmbG93IHdp
bGwgc3RheS4KPiBUaGUgZnV0dXJlIGNoYW5nZXMgdG8gUkZDIHdpbGwgYmUgaW4gdGhlIGZvcm0g
b2YgcGF0Y2hlcyB0bwo+IGluc3RydWN0aW9uLXNldC1za2VsZXRvbi5yc3QuIE9uY2UgdGhleSBs
YW5kIHRoZSBSRkMgd2lsbCBiZQo+IHJlZ2VuZXJhdGVkLgo+IFdlIGNhbiByZWdlbmVyYXRlIFJG
QyBhcyBvZnRlbiBhcyB3ZSBsaWtlLgo+Cj4gQWxsIEknbSBzYXlpbmcgaXMgdGhhdCBSRkMgaGFz
IGJ1Z3MgdGhhdCB3ZXJlIGFscmVhZHkgZml4ZWQgaW4KPiBpbnN0cnVjdGlvbi1zZXQtc2tlbGV0
b24ucnN0LiBIZW5jZSBpdCdzIG91dGRhdGVkLgoKVGhlIEFwcGVuZGl4ICh0aGUgb3Bjb2RlIHRh
YmxlKSBpcyBub3QgaW4gdGhlIGtlcm5lbCByZXBvIG5vdyBhbmQKc3RpbGwgaGFzIHRoZSBpc3N1
ZXMgdGhhdCBJIG91dGxpbmVkIGFib3ZlLiBXaWxsIHRoYXQgbWFrZSBpdCBpbiB0bwp0aGUga2Vy
bmVsPwoKaHR0cHM6Ly9naXRodWIuY29tL2lldGYtd2ctYnBmL2VicGYtZG9jcy9ibG9iL21haW4v
cnN0L2luc3RydWN0aW9uLXNldC1vcGNvZGVzLnJzdAoKV2lsbAoKLS0gCkJwZiBtYWlsaW5nIGxp
c3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBm
Cg==

