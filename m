Return-Path: <bpf+bounces-6300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6283767A4E
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C06C282841
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52980C;
	Sat, 29 Jul 2023 00:53:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42817C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:53:56 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A2B525A
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:53:28 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2DEF9C151545
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690591953; bh=dK2JjgEJTEG9P4imzPuYPx35s97O1w823szvZpFl4jY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dUOfKqGBFwt37jhJah+iwC6LPHjEyqQrRiLNrDsHF2vKNt206vpBpH3CuFJPH7tEg
	 +Ou6Ksz/XbOkZaqzWZY8M0BeaCvoNIinXOcCQi3HsNg5kWSEsk32+Tawouet75ECXB
	 uZAorU+BDsmU3wfmuLC1QG7E6V3qvqij1C2pF3N0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 17:52:33 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0F0ECC151078;
	Fri, 28 Jul 2023 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690591953; bh=dK2JjgEJTEG9P4imzPuYPx35s97O1w823szvZpFl4jY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dUOfKqGBFwt37jhJah+iwC6LPHjEyqQrRiLNrDsHF2vKNt206vpBpH3CuFJPH7tEg
	 +Ou6Ksz/XbOkZaqzWZY8M0BeaCvoNIinXOcCQi3HsNg5kWSEsk32+Tawouet75ECXB
	 uZAorU+BDsmU3wfmuLC1QG7E6V3qvqij1C2pF3N0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 05101C151075
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 17:52:32 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.106
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
 with ESMTP id NTUy-lmlE54D for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 17:52:27 -0700 (PDT)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A93ACC151078
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:52:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b9c66e2e36so27200471fa.1
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690591946; x=1691196746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aM4BL6iGUN1LckaSEABpRw/rJR7OXts8NUN8kOvBUrc=;
 b=Qpe+BCUXXI6yc+TwzLxQOz2Gq8t2lWzuUXZo+bfK+34zxA7QWfQ1K7vpwDPF3Bo74+
 SF3UawbpqPRkRC/NjgLKOBWP+myoVORN/ZfSMTwSu9A0h6pOqGnHctd8RhgK87vDqLSO
 eelWVoGj38dEKEJ/1VbfitHi9A/IxqmjCMpCKPv1i5a75LqQ6R241ciW8BnljfmeCWUs
 32P39XEy55NYJMfTPdMt0lnIHj9/1O/rZptCbQd5KGb0Q8OYiwAXTprRdSB7Ai1adCDC
 F30G9nR6wVyYVfMl1Q2qVGepRqmK4qKxuUCxNtFTMNCZLvs7dboCiascrOy3H3Dygrxd
 bI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690591946; x=1691196746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aM4BL6iGUN1LckaSEABpRw/rJR7OXts8NUN8kOvBUrc=;
 b=k7Fu8bwxXLs6uL2YTMUZpyxFeRNckqnqLMQmVO2lnJXcCefwKkQn1R0b+J9kgN1wxm
 F3VKgTDgplU7bqvhayA052t/bPZs8cV1DOUJh1T77m/EbesTh+Vi+ird0Grbpb1e+YGH
 KjAFBuQf9ltv+OlNEg44Cv6uCJnrvQDxQEX46A6nq6x517L7lg8AfaG7yTQ+QEmcoc4/
 KNJ7B/tsHv7gSG5t2JMyx31zdZkbSFXRw/fFUrPLaAIl92WiyErRGmLB2/rkh8Cvtj2c
 Ub1qXPeMhZjkNAujjpX34U69qiseOkjOyv5IVrL4Ix7AUY1/eoVjOhZEnL0Giwz0+ynN
 B7Gg==
X-Gm-Message-State: ABy/qLbq4jesgmEm14GHuIv6xV39igxwhYL8SYG+OgZtZN40w2YPsvj6
 eta7ffRyzoEo0WxKV8r8OwguFlp3Wf+5k/sEHqM9/Y8e
X-Google-Smtp-Source: APBJJlHc9+cLY9B666i/axrKpgjgN4X/7Xz2vnn5Jz4dIPMGQDLAXYvksl2KaoWn0zW9jwIm91vm+7Wf2IScLay5Nsc=
X-Received: by 2002:a2e:880f:0:b0:2b6:d03a:5d8d with SMTP id
 x15-20020a2e880f000000b002b6d03a5d8dmr1451744ljh.6.1690591945739; Fri, 28 Jul
 2023 17:52:25 -0700 (PDT)
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
In-Reply-To: <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 17:52:14 -0700
Message-ID: <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/tYik4s1db553Qj5Zxo0rVZKNVHs>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNTo0NuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MzXigK9QTSBBbGV4
ZWkgU3Rhcm92b2l0b3YKPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
Pgo+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNToxOeKAr1BNIFdpbGwgSGF3a2lucyA8aGF3
a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQg
ODowNeKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdt
YWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBGcmksIEp1bCAyOCwgMjAyMyBhdCA0
OjMy4oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+IHdyb3RlOgo+ID4gPiA+ID4K
PiA+ID4gPiA+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDk6MDXigK9QTSBBbGV4ZWkgU3Rhcm92
b2l0b3YKPiA+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMTI6MTbigK9QTSBX
aWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAyOjM34oCvUE0gV2F0c29uIExhZGQgPHdh
dHNvbmJsYWRkQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgOToxNeKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+
ID4gPiA+ID4gPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCA3
OjAz4oCvQU0gRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWljcm9zb2Z0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIGZvcndhcmRpbmcgdGhlIGVt
YWlsIGJlbG93IChhZnRlciBjb252ZXJ0aW5nIEhUTUwgdG8gcGxhaW4gdGV4dCkKPiA+ID4gPiA+
ID4gPiA+ID4gPiB0byB0aGUgbWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcgbGlzdCBzbyByZXBs
aWVzIGNhbiBnbyB0byBib3RoIGxpc3RzLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gUGxlYXNlIHVzZSB0aGlzIG9uZSBmb3IgYW55IHJlcGxpZXMuCj4gPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4gPiA+ID4gPiA+ID4g
RGF2ZQo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBCcGYg
PGJwZi1ib3VuY2VzQGlldGYub3JnPiBPbiBCZWhhbGYgT2YgV2F0c29uIExhZGQKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IFNlbnQ6IE1vbmRheSwgSnVseSAyNCwgMjAyMyAxMDowNSBQTQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gVG86IGJwZkBpZXRmLm9yZwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU3Vi
amVjdDogW0JwZl0gUmV2aWV3IG9mIGRyYWZ0LXRoYWxlci1icGYtaXNhLTAxCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRGVhciBCUEYgd2csCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0b29rIGEgbG9vayBhdCB0aGUgZHJh
ZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21lIGlzc3VlcywgdW5zdXJwcmlzaW5nbHkgYXQgdGhpcyBz
dGFnZS4gT25lIGlzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGUgc3BlY2lmaWNhdGlvbiBzZWVt
cyB0byB1c2UgYW4gdW5kZXJzcGVjaWZpZWQgQyBwc2V1ZG8gY29kZSBmb3Igb3BlcmF0aW9ucyB2
cwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZGVmaW5pbmcgdGhlbSBtYXRoZW1hdGljYWxseS4KPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gSGkgV2F0c29uLAo+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIG5vdCAidW5kZXJzcGVjaWZpZWQgQyIgcHNl
dWRvIGNvZGUuCj4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgYXNzZW1ibHkgc3ludGF4IHBhcnNl
ZCBhbmQgZW1pdHRlZCBieSBHQ0MsIExMVk0sIGdhcywgTGludXggS2VybmVsLCBldGMuCj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSBkb24ndCBzZWUgYSByZWZlcmVuY2UgdG8gYW55
IGRlc2NyaXB0aW9uIG9mIHRoYXQgaW4gc2VjdGlvbiA0LjEuCj4gPiA+ID4gPiA+ID4gPiBJdCdz
IHBvc3NpYmxlIEkndmUgb3Zlcmxvb2tlZCB0aGlzLCBhbmQgaWYgcGVvcGxlIHRoaW5rIHRoaXMg
c3R5bGUgb2YKPiA+ID4gPiA+ID4gPiA+IGRlZmluaXRpb24gaXMgZ29vZCBlbm91Z2ggdGhhdCB3
b3JrcyBmb3IgbWUuIEJ1dCBJIGZvdW5kIHRhYmxlIDQKPiA+ID4gPiA+ID4gPiA+IHByZXR0eSBz
Y2FudHkgb24gd2hhdCBleGFjdGx5IGhhcHBlbnMuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiBIZWxsbyEgQmFzZWQgb24gV2F0c29uJ3MgcG9zdCwgSSBoYXZlIGRvbmUgc29tZSByZXNlYXJj
aCBhbmQgd291bGQKPiA+ID4gPiA+ID4gPiBwb3RlbnRpYWxseSBsaWtlIHRvIG9mZmVyIGEgcGF0
aCBmb3J3YXJkLiBUaGVyZSBhcmUgc2V2ZXJhbCBkaWZmZXJlbnQKPiA+ID4gPiA+ID4gPiB3YXlz
IHRoYXQgSVNBcyBzcGVjaWZ5IHRoZSBzZW1hbnRpY3Mgb2YgdGhlaXIgb3BlcmF0aW9uczoKPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IDEuIEludGVsIGhhcyBhIHNlY3Rpb24gaW4gdGhlaXIg
bWFudWFsIHRoYXQgZGVzY3JpYmVzIHRoZSBwc2V1ZG9jb2RlCj4gPiA+ID4gPiA+ID4gdGhleSB1
c2UgdG8gc3BlY2lmeSB0aGVpciBJU0E6IFNlY3Rpb24gMy4xLjEuOSBvZiBUaGUgSW50ZWzCriA2
NCBhbmQKPiA+ID4gPiA+ID4gPiBJQS0zMiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlIERldmVsb3Bl
cuKAmXMgTWFudWFsIGF0Cj4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3Yx
L2RsL2dldENvbnRlbnQvNjcxMTk5Cj4gPiA+ID4gPiA+ID4gMi4gQVJNIGhhcyBhbiBlcXVpdmFs
ZW50IGZvciB0aGVpciB2YXJpZXR5IG9mIHBzZXVkb2NvZGU6IENoYXB0ZXIgSjEKPiA+ID4gPiA+
ID4gPiBvZiBBcm0gQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwgZm9yIEEtcHJvZmlsZSBh
cmNoaXRlY3R1cmUgYXQKPiA+ID4gPiA+ID4gPiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2Rv
Y3VtZW50YXRpb24vZGRpMDQ4Ny9sYXRlc3QvCj4gPiA+ID4gPiA+ID4gMy4gU2FpbCAiaXMgYSBs
YW5ndWFnZSBmb3IgZGVzY3JpYmluZyB0aGUgaW5zdHJ1Y3Rpb24tc2V0IGFyY2hpdGVjdHVyZQo+
ID4gPiA+ID4gPiA+IChJU0EpIHNlbWFudGljcyBvZiBwcm9jZXNzb3JzLiIKPiA+ID4gPiA+ID4g
PiAoaHR0cHM6Ly93d3cuY2wuY2FtLmFjLnVrL35wZXMyMC9zYWlsLykKPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IEdpdmVuIHRoZSBjb21tZXJjaWFsIG5hdHVyZSBvZiAoMSkgYW5kICgyKSwg
cGVyaGFwcyBTYWlsIGlzIGEgd2F5IHRvCj4gPiA+ID4gPiA+ID4gcHJvY2VlZC4gSWYgcGVvcGxl
IGFyZSBpbnRlcmVzdGVkLCBJIHdvdWxkIGJlIGhhcHB5IHRvIGxlYWQgYW4gZWZmb3J0Cj4gPiA+
ID4gPiA+ID4gdG8gZW5jb2RlIHRoZSBlQlBGIElTQSBzZW1hbnRpY3MgaW4gU2FpbCAob3IgZmlu
ZCBzb21lb25lIHdobyBhbHJlYWR5Cj4gPiA+ID4gPiA+ID4gaGFzKSBhbmQgaW5jb3Jwb3JhdGUg
dGhlbSBpbiB0aGUgZHJhZnQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IGltbyBTYWlsIGlzIHRv
byByZXNlYXJjaHkgdG8gaGF2ZSBwcmFjdGljYWwgdXNlLgo+ID4gPiA+ID4gPiBMb29raW5nIGF0
IGFybTY0IG9yIHg4NiBTYWlsIGRlc2NyaXB0aW9uIEkgcmVhbGx5IGRvbid0IHNlZSBob3cKPiA+
ID4gPiA+ID4gaXQgd291bGQgbWFwIHRvIGFuIElFVEYgc3RhbmRhcmQuCj4gPiA+ID4gPiA+IEl0
J3MgZG9uZSBpbiBhICJzYWlsIiBsYW5ndWFnZSB0aGF0IHBlb3BsZSBuZWVkIHRvIGxlYXJuIGZp
cnN0IHRvIGJlCj4gPiA+ID4gPiA+IGFibGUgdG8gcmVhZCBpdC4KPiA+ID4gPiA+ID4gU2F5IHdl
IGhhZCBicGYuc2FpbCBzb21ld2hlcmUgb24gZ2l0aHViLiBXaGF0IHZhbHVlIGRvZXMgaXQgYnJp
bmcgdG8KPiA+ID4gPiA+ID4gQlBGIElTQSBzdGFuZGFyZD8gSSBkb24ndCBzZWUgYW4gaW1tZWRp
YXRlIGJlbmVmaXQgdG8gc3RhbmRhcmRpemF0aW9uLgo+ID4gPiA+ID4gPiBUaGVyZSBjb3VsZCBi
ZSBvdGhlciB1c2UgY2FzZXMsIG5vIGRvdWJ0LCBidXQgc3RhbmRhcmRpemF0aW9uIGlzIG91ciBn
b2FsLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBBcyBmYXIgYXMgMSBhbmQgMi4gSW50ZWwgYW5k
IEFybSB1c2UgdGhlaXIgb3duIHBzZXVkb2NvZGUsIHNvIHRoZXkgaGFkCj4gPiA+ID4gPiA+IHRv
IGFkZCBhIHBhcmFncmFwaCB0byBkZXNjcmliZSBpdC4gV2UgYXJlIHVzaW5nIEMgdG8gZGVzY3Jp
YmUgQlBGIElTQQo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIGNhbm5vdCBmaW5kIGEg
cmVmZXJlbmNlIGluIHRoZSBjdXJyZW50IHZlcnNpb24gdGhhdCBzcGVjaWZpZXMgd2hhdAo+ID4g
PiA+ID4gd2UgYXJlIHVzaW5nIHRvIGRlc2NyaWJlIHRoZSBvcGVyYXRpb25zLiBJJ2QgbGlrZSB0
byBhZGQgdGhhdCwgYnV0Cj4gPiA+ID4gPiB3YW50IHRvIG1ha2Ugc3VyZSB0aGF0IEkgY2xhcmlm
eSB0d28gc3RhdGVtZW50cyB0aGF0IHNlZW0gdG8gYmUgYXQKPiA+ID4gPiA+IG9kZHMuCj4gPiA+
ID4gPgo+ID4gPiA+ID4gSW1tZWRpYXRlbHkgYWJvdmUgeW91IHNheSB0aGF0IHdlIGFyZSB1c2lu
ZyAiQyB0byBkZXNjcmliZSB0aGUgQlBGCj4gPiA+ID4gPiBJU0EiIGFuZCBmdXJ0aGVyIGFib3Zl
IHlvdSBzYXkgIlRoaXMgaXMgYXNzZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQKPiA+ID4gPiA+IGVt
aXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtlcm5lbCwgZXRjLiIKPiA+ID4gPiA+Cj4g
PiA+ID4gPiBNeSBvd24gcmVhZGluZyBpcyB0aGF0IGl0IGlzIHRoZSBmb3JtZXIsIGFuZCBub3Qg
dGhlIGxhdHRlci4gQnV0LCBJCj4gPiA+ID4gPiB3YW50IHRvIGRvdWJsZSBjaGVjayBiZWZvcmUg
YWRkaW5nIHRoZSBhcHByb3ByaWF0ZSBzdGF0ZW1lbnRzIHRvIHRoZQo+ID4gPiA+ID4gQ29udmVu
dGlvbiBzZWN0aW9uLgo+ID4gPiA+Cj4gPiA+ID4gSXQncyBib3RoLiBJJ20gbm90IHN1cmUgd2hl
cmUgeW91IHNlZSBhIGNvbnRyYWRpY3Rpb24uCj4gPiA+ID4gSXQncyBhIG5vcm1hbCBDIHN5bnRh
eCBhbmQgaXQncyBlbWl0dGVkIGJ5IHRoZSBrZXJuZWwgdmVyaWZpZXIsCj4gPiA+ID4gcGFyc2Vk
IGJ5IGNsYW5nL2djYyBhc3NlbWJsZXJzIGFuZCBlbWl0dGVkIGJ5IGNvbXBpbGVycy4KPiA+ID4K
PiA+ID4KPiA+ID4gT2theS4gSSBhcG9sb2dpemUuIEkgYW0gc2luY2VyZWx5IGNvbmZ1c2VkLiBG
b3IgaW5zdGFuY2UsCj4gPiA+Cj4gPiA+IGlmICh1MzIpZHN0ID49ICh1MzIpc3JjIGdvdG8gK29m
ZnNldAo+ID4gPgo+ID4gPiBMb29rcyBsaWtlIG5vdGhpbmcgdGhhdCBJIGhhdmUgZXZlciBzZWVu
IGluICJub3JtYWwgQyBzeW50YXgiLgo+ID4KPiA+IEkgdGhvdWdodCB3ZSdyZSB0YWxraW5nIGFi
b3V0IHRhYmxlIDQgYW5kIEFMVSBvcHMuCj4gPiBBYm92ZSBpcyBub3QgYSBwdXJlIEMsIGJ1dCBp
dCdzIG9idmlvdXMgZW5vdWdoIHdpdGhvdXQgZXhwbGFuYXRpb24sIG5vPwo+Cj4gVG8gInVzIiwg
eWVzLiBBbHRob3VnaCBJIGFtIG5vdCBhbiBleHBlcnQsIGl0IHNlZW1zIGxpa2UgYmVpbmcKPiBl
eHBsaWNpdCBpcyBpbXBvcnRhbnQgd2hlbiBpdCBjb21lcyB0byB3cml0aW5nIGEgc3BlYy4gSSBz
dXBwb3NlIHdlCj4gc2hvdWxkIGxlYXZlIHRoYXQgdG8gRGF2ZSBhbmQgdGhlIGNoYWlycy4KPgo+
ID4gQWxzbyBJIGRvbid0IHNlZSBhYm92ZSBhbnl3aGVyZSBpbiB0aGUgZG9jLgo+Cj4gVGhhdCBp
cyBmcm9tIHRoZSBBcHBlbmRpeC4gSXQgaXMgY3VycmVudGx5IGluIERhdmUncyB0cmVlIGFuZCBn
ZXRzCj4gYW1hbGdhbWF0ZWQgd2l0aCBvdGhlciBmaWxlcyB0byBidWlsZCB0aGUgZmluYWwgZHJh
ZnQuCj4KPiBodHRwczovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9kcmFmdC10aGFsZXItYnBm
LWlzYS8KClRoaXMgaXMgYSBtaXJyb3IgYW5kIGl0J3MgYWxyZWFkeSBvdXRkYXRlZC4KWW91IHNo
b3VsZCBsb29rIGF0IHRoZSBzb3VyY2UuIFdoaWNoIGlzIGdpdCBrZXJuZWwgdHJlZS4KCi0tIApC
cGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2JwZgo=

