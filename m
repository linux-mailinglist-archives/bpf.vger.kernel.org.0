Return-Path: <bpf+bounces-6121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B797660F9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DCD282536
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341915C1;
	Fri, 28 Jul 2023 01:06:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB377C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:06:51 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81973580
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:06:49 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6F7ADC1522AA
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690506409; bh=taEcQqEnWAsFTtgbx0cSf+qVp7V0Ta4fnAne2NXX1v8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=CKavFJ6vy5hLJFMENoz+TRy8vMNnPgB8+H+kLmSS3+Fdum/be4I5kA4+4VaVIQ9OZ
	 UXU4owaF1vi5njywtGHXjMBniJ32zYPo+IKwFUMP1GqHrQclh50ZCaC5QOclXUebXs
	 DA7CbYIpaVk91qlBZdcKyKG7gKIqtMKZJmxchwTs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul 27 18:06:49 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 48C2AC151982;
	Thu, 27 Jul 2023 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690506409; bh=taEcQqEnWAsFTtgbx0cSf+qVp7V0Ta4fnAne2NXX1v8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=CKavFJ6vy5hLJFMENoz+TRy8vMNnPgB8+H+kLmSS3+Fdum/be4I5kA4+4VaVIQ9OZ
	 UXU4owaF1vi5njywtGHXjMBniJ32zYPo+IKwFUMP1GqHrQclh50ZCaC5QOclXUebXs
	 DA7CbYIpaVk91qlBZdcKyKG7gKIqtMKZJmxchwTs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F1351C151990
 for <bpf@ietfa.amsl.com>; Thu, 27 Jul 2023 18:06:47 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.106
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
 with ESMTP id TqPXIkTU0PdP for <bpf@ietfa.amsl.com>;
 Thu, 27 Jul 2023 18:06:43 -0700 (PDT)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 40B08C151982
 for <bpf@ietf.org>; Thu, 27 Jul 2023 18:05:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b93fba1f62so24503421fa.1
 for <bpf@ietf.org>; Thu, 27 Jul 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690506356; x=1691111156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRvF7S6BCKQOHpa/hnG8yDSBjnyYzzktXP0BSYr1PV4=;
 b=eCnXOAzpwp4vq7NmQJ5aKaCKwOGzi6EApZnV9f7A86ZKFNq40vhQgT/66eiKnFv22+
 HZlGeUvJ6/Mw1vTJUqsUlBkLjKorQRdWWFmzkmopxFxQice31QEvq+QaBJX48PRzG6PG
 Zb7m9KgvWP/g+TaS78Conpa9t0BHj+H9/EdR4LKxpQoAxHn/2q8XWwiZItD6m/TegOwe
 gJvie7dbISxrnniLEXMAMN2t8fEbeHjRbbdKniiHTdLipPyTS3r8uawkg19h+8drz/cJ
 KPzcJLlGMNf2yO42CV28ZvassA6jtDc2Ct68wuW7KRwbF2bBcVMJGi4DbV5v/1glzu3N
 dJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690506356; x=1691111156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRvF7S6BCKQOHpa/hnG8yDSBjnyYzzktXP0BSYr1PV4=;
 b=LDXAmf1N3Ej4JZ6MlfpAWrJdPCLS63I6qLd/a4D/NGWpT1o0I4dtV8/1hxwm5BDWSh
 LRSpOCgrgCTuQ6xxqzpL+MSyTGsZ7mnREQ6sxBTXdCFd1NNzlOlkzehYFU3PtYwfzjMb
 rTTnG4LAar4TBAsc9Li8L7hP43f1Yief9tmNf7AMkIk6ehgnwHwNVo3kW3OziDrLQPdZ
 b6IqyvLHF7Wct/VSaMtGjgmB+sa0gwxlTtXoRyLhlVph+pa18Kmk3k0p1fnXc78yltSl
 n3ogTAqPvxdzikGwpJFv7JGujh/aBsFU+saXl6uvxgZB/FCT5BwsBNM/Rrx0GqpF3Gf+
 JG3g==
X-Gm-Message-State: ABy/qLZPQ479fEFTEBppAxl0bM0fCoEKvfA8KI1HhF/yTSQU7T7KNONK
 8GNHhuBhNd9wNgJmuRyb+V4K5j1ZF5ydq57PA+Y=
X-Google-Smtp-Source: APBJJlFpsa9S+MbwDuUpA001xWkpqg8vP9isN2mtCBJKVJix7GUmVZtCItBEoyaul1kXK9WPf7t8cs95jF+g0y69LkE=
X-Received: by 2002:a2e:9b8b:0:b0:2b7:117:e54 with SMTP id
 z11-20020a2e9b8b000000b002b701170e54mr579538lji.4.1690506355615; 
 Thu, 27 Jul 2023 18:05:55 -0700 (PDT)
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
In-Reply-To: <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 18:05:44 -0700
Message-ID: <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/dDzJ-CYLMDxdi2hQamYDfPWJt0g>
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

T24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMTI6MTbigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3
QG9icy5jcj4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAyOjM34oCvUE0gV2F0
c29uIExhZGQgPHdhdHNvbmJsYWRkQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCBK
dWwgMjUsIDIwMjMgYXQgOToxNeKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPGFsZXhlaS5z
dGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIEp1bCAyNSwg
MjAyMyBhdCA3OjAz4oCvQU0gRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWljcm9zb2Z0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4KPiA+ID4gPiBJIGFtIGZvcndhcmRpbmcgdGhlIGVtYWlsIGJlbG93IChhZnRl
ciBjb252ZXJ0aW5nIEhUTUwgdG8gcGxhaW4gdGV4dCkKPiA+ID4gPiB0byB0aGUgbWFpbHRvOmJw
ZkB2Z2VyLmtlcm5lbC5vcmcgbGlzdCBzbyByZXBsaWVzIGNhbiBnbyB0byBib3RoIGxpc3RzLgo+
ID4gPiA+Cj4gPiA+ID4gUGxlYXNlIHVzZSB0aGlzIG9uZSBmb3IgYW55IHJlcGxpZXMuCj4gPiA+
ID4KPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4gRGF2ZQo+ID4gPiA+Cj4gPiA+ID4gPiBGcm9tOiBC
cGYgPGJwZi1ib3VuY2VzQGlldGYub3JnPiBPbiBCZWhhbGYgT2YgV2F0c29uIExhZGQKPiA+ID4g
PiA+IFNlbnQ6IE1vbmRheSwgSnVseSAyNCwgMjAyMyAxMDowNSBQTQo+ID4gPiA+ID4gVG86IGJw
ZkBpZXRmLm9yZwo+ID4gPiA+ID4gU3ViamVjdDogW0JwZl0gUmV2aWV3IG9mIGRyYWZ0LXRoYWxl
ci1icGYtaXNhLTAxCj4gPiA+ID4gPgo+ID4gPiA+ID4gRGVhciBCUEYgd2csCj4gPiA+ID4gPgo+
ID4gPiA+ID4gSSB0b29rIGEgbG9vayBhdCB0aGUgZHJhZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21l
IGlzc3VlcywgdW5zdXJwcmlzaW5nbHkgYXQgdGhpcyBzdGFnZS4gT25lIGlzCj4gPiA+ID4gPiB0
aGUgc3BlY2lmaWNhdGlvbiBzZWVtcyB0byB1c2UgYW4gdW5kZXJzcGVjaWZpZWQgQyBwc2V1ZG8g
Y29kZSBmb3Igb3BlcmF0aW9ucyB2cwo+ID4gPiA+ID4gZGVmaW5pbmcgdGhlbSBtYXRoZW1hdGlj
YWxseS4KPiA+ID4KPiA+ID4gSGkgV2F0c29uLAo+ID4gPgo+ID4gPiBUaGlzIGlzIG5vdCAidW5k
ZXJzcGVjaWZpZWQgQyIgcHNldWRvIGNvZGUuCj4gPiA+IFRoaXMgaXMgYXNzZW1ibHkgc3ludGF4
IHBhcnNlZCBhbmQgZW1pdHRlZCBieSBHQ0MsIExMVk0sIGdhcywgTGludXggS2VybmVsLCBldGMu
Cj4gPgo+ID4gSSBkb24ndCBzZWUgYSByZWZlcmVuY2UgdG8gYW55IGRlc2NyaXB0aW9uIG9mIHRo
YXQgaW4gc2VjdGlvbiA0LjEuCj4gPiBJdCdzIHBvc3NpYmxlIEkndmUgb3Zlcmxvb2tlZCB0aGlz
LCBhbmQgaWYgcGVvcGxlIHRoaW5rIHRoaXMgc3R5bGUgb2YKPiA+IGRlZmluaXRpb24gaXMgZ29v
ZCBlbm91Z2ggdGhhdCB3b3JrcyBmb3IgbWUuIEJ1dCBJIGZvdW5kIHRhYmxlIDQKPiA+IHByZXR0
eSBzY2FudHkgb24gd2hhdCBleGFjdGx5IGhhcHBlbnMuCj4KPiBIZWxsbyEgQmFzZWQgb24gV2F0
c29uJ3MgcG9zdCwgSSBoYXZlIGRvbmUgc29tZSByZXNlYXJjaCBhbmQgd291bGQKPiBwb3RlbnRp
YWxseSBsaWtlIHRvIG9mZmVyIGEgcGF0aCBmb3J3YXJkLiBUaGVyZSBhcmUgc2V2ZXJhbCBkaWZm
ZXJlbnQKPiB3YXlzIHRoYXQgSVNBcyBzcGVjaWZ5IHRoZSBzZW1hbnRpY3Mgb2YgdGhlaXIgb3Bl
cmF0aW9uczoKPgo+IDEuIEludGVsIGhhcyBhIHNlY3Rpb24gaW4gdGhlaXIgbWFudWFsIHRoYXQg
ZGVzY3JpYmVzIHRoZSBwc2V1ZG9jb2RlCj4gdGhleSB1c2UgdG8gc3BlY2lmeSB0aGVpciBJU0E6
IFNlY3Rpb24gMy4xLjEuOSBvZiBUaGUgSW50ZWzCriA2NCBhbmQKPiBJQS0zMiBBcmNoaXRlY3R1
cmVzIFNvZnR3YXJlIERldmVsb3BlcuKAmXMgTWFudWFsIGF0Cj4gaHR0cHM6Ly9jZHJkdjIuaW50
ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvNjcxMTk5Cj4gMi4gQVJNIGhhcyBhbiBlcXVpdmFsZW50
IGZvciB0aGVpciB2YXJpZXR5IG9mIHBzZXVkb2NvZGU6IENoYXB0ZXIgSjEKPiBvZiBBcm0gQXJj
aGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwgZm9yIEEtcHJvZmlsZSBhcmNoaXRlY3R1cmUgYXQK
PiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRpMDQ4Ny9sYXRlc3Qv
Cj4gMy4gU2FpbCAiaXMgYSBsYW5ndWFnZSBmb3IgZGVzY3JpYmluZyB0aGUgaW5zdHJ1Y3Rpb24t
c2V0IGFyY2hpdGVjdHVyZQo+IChJU0EpIHNlbWFudGljcyBvZiBwcm9jZXNzb3JzLiIKPiAoaHR0
cHM6Ly93d3cuY2wuY2FtLmFjLnVrL35wZXMyMC9zYWlsLykKPgo+IEdpdmVuIHRoZSBjb21tZXJj
aWFsIG5hdHVyZSBvZiAoMSkgYW5kICgyKSwgcGVyaGFwcyBTYWlsIGlzIGEgd2F5IHRvCj4gcHJv
Y2VlZC4gSWYgcGVvcGxlIGFyZSBpbnRlcmVzdGVkLCBJIHdvdWxkIGJlIGhhcHB5IHRvIGxlYWQg
YW4gZWZmb3J0Cj4gdG8gZW5jb2RlIHRoZSBlQlBGIElTQSBzZW1hbnRpY3MgaW4gU2FpbCAob3Ig
ZmluZCBzb21lb25lIHdobyBhbHJlYWR5Cj4gaGFzKSBhbmQgaW5jb3Jwb3JhdGUgdGhlbSBpbiB0
aGUgZHJhZnQuCgppbW8gU2FpbCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUgcHJhY3RpY2FsIHVz
ZS4KTG9va2luZyBhdCBhcm02NCBvciB4ODYgU2FpbCBkZXNjcmlwdGlvbiBJIHJlYWxseSBkb24n
dCBzZWUgaG93Cml0IHdvdWxkIG1hcCB0byBhbiBJRVRGIHN0YW5kYXJkLgpJdCdzIGRvbmUgaW4g
YSAic2FpbCIgbGFuZ3VhZ2UgdGhhdCBwZW9wbGUgbmVlZCB0byBsZWFybiBmaXJzdCB0byBiZQph
YmxlIHRvIHJlYWQgaXQuClNheSB3ZSBoYWQgYnBmLnNhaWwgc29tZXdoZXJlIG9uIGdpdGh1Yi4g
V2hhdCB2YWx1ZSBkb2VzIGl0IGJyaW5nIHRvCkJQRiBJU0Egc3RhbmRhcmQ/IEkgZG9uJ3Qgc2Vl
IGFuIGltbWVkaWF0ZSBiZW5lZml0IHRvIHN0YW5kYXJkaXphdGlvbi4KVGhlcmUgY291bGQgYmUg
b3RoZXIgdXNlIGNhc2VzLCBubyBkb3VidCwgYnV0IHN0YW5kYXJkaXphdGlvbiBpcyBvdXIgZ29h
bC4KCkFzIGZhciBhcyAxIGFuZCAyLiBJbnRlbCBhbmQgQXJtIHVzZSB0aGVpciBvd24gcHNldWRv
Y29kZSwgc28gdGhleSBoYWQKdG8gYWRkIGEgcGFyYWdyYXBoIHRvIGRlc2NyaWJlIGl0LiBXZSBh
cmUgdXNpbmcgQyB0byBkZXNjcmliZSBCUEYgSVNBCnNlbWFudGljcy4gSSBkb24ndCB0aGluayB3
ZSBuZWVkIHRvIGV4cGxhaW4gQyBpbiB0aGUgQlBGIElTQSBkb2MuClRoZSBvbmx5IGV4Y2VwdGlv
biBpcyAicz49IiwgYnV0IGl0IGlzIGV4cGxhaW5lZCBpbiB0aGUgZG9jIGFscmVhZHkuCgotLSAK
QnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1h
bi9saXN0aW5mby9icGYK

