Return-Path: <bpf+bounces-1126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A279770E5DC
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586DD281491
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69D21CEE;
	Tue, 23 May 2023 19:42:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BE1F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:42:20 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34B120
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:42:18 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 906A3C151B3D
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684870938; bh=jGI7qkQtBuyGd+IzDdMZ8y3nbtxttn4llq9tgHY9X1A=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=M+EAbxUapjMtMqZymsWlP68wL4Q6QOxH9zjMyZiK9Yb61Yj2/y9QthZKl4DsBX6mT
	 Wrj7Pdo3aJ/ThaDdUwfjhIYYKItELIDblMmRFxie3KQD95ct8D9RLgKS3p0wf8g+Wl
	 VU8VpF/EqyfwK7cdZNSRDNSvy6b0vchLp8kJsIVs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 23 12:42:18 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8067FC1519AD;
	Tue, 23 May 2023 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684870938; bh=jGI7qkQtBuyGd+IzDdMZ8y3nbtxttn4llq9tgHY9X1A=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=M+EAbxUapjMtMqZymsWlP68wL4Q6QOxH9zjMyZiK9Yb61Yj2/y9QthZKl4DsBX6mT
	 Wrj7Pdo3aJ/ThaDdUwfjhIYYKItELIDblMmRFxie3KQD95ct8D9RLgKS3p0wf8g+Wl
	 VU8VpF/EqyfwK7cdZNSRDNSvy6b0vchLp8kJsIVs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D7E47C151087
 for <bpf@ietfa.amsl.com>; Tue, 23 May 2023 12:42:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.097
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HKQ5neCPcCCe for <bpf@ietfa.amsl.com>;
 Tue, 23 May 2023 12:42:15 -0700 (PDT)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8057DC14CE4B
 for <bpf@ietf.org>; Tue, 23 May 2023 12:42:15 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-783eb20d96cso79351241.0
 for <bpf@ietf.org>; Tue, 23 May 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684870934; x=1687462934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XW4S8/5axXkLQBPo3PMevs9zQMqBWRjleyC7QiXziiU=;
 b=IaVeWnJnKMuIvsYV96OqSC5+ZDVceAvzoYY3ITeCZ/sADIvzkQ3IAJ3b4eLXQQmy9J
 ea6hNRdtGIPBrzvCV31TWWvMBwIAmIsdLap4bvNzLRMTCl7RhEmQg8BImX1yPBh8e/tO
 JDcRWZ0kOUpCi5uuypUxMZqjVAsOoBBlBGwu4IO8gqGBY/oL0R6WueJ6yS0HA8A4vCKb
 Hxbv7zmZrGubiMBk5p7tvW63UCvx65fBuQjzKu5pvlDssolT2ddBCn4jy3fsdWwSar+f
 vRthR43TYnNgl61Clx4/G+z5gQ0bO6cIk36/aSRxb5mspJwuewRoAWrTiYOpMDn3VTno
 0CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684870934; x=1687462934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XW4S8/5axXkLQBPo3PMevs9zQMqBWRjleyC7QiXziiU=;
 b=FCbX4Hf1+V5OkkDOfoIEIiJUsEugbY6eX3dXH+eXD/zRjUcnCvYV+igCKDE0D0sB/G
 CmKv6lk+UF4lsMYK8CAdCi7EvXgx1kAkgZXiZx+7lZLw9Gh6V0Vh/wT1IyU7vk3Ub6iB
 rXQoOzsID1DGOy/Sq7ksyvf/b7Xc5Anh91xb8wN1ShOPpIuttrAcZob3QTObwY89slW9
 65oBkN/qtJYFgnvXtVvkX6G4iHKDqZA9gS3K8VSWo4s4+4aahaNU11ErJOMRZDgv4Awm
 R+EEH47p3Z9ENRaaR8OpV3RDSPcMJk/r9Eexi769leAE3v21fm7YNu9qsZeObTHpMNdI
 SYpA==
X-Gm-Message-State: AC+VfDzcQzrZJyW3Rx3tg7aTVnxm6RjSogvO0T+r0EyKMQwS7WOLPIbW
 T7Q2NjJm4BxPCQwR21iVoUFYOPAgxoa+j7Rtm14=
X-Google-Smtp-Source: ACHHUZ7caSKQCdas5kQndA8od3SkfupivrXiyx+iASBrS2g1h4hVFCchn/Yh3ynvZTAEJCmPUJWHtGCAbQnynW23YGw=
X-Received: by 2002:a05:6102:2f4:b0:437:e5d1:a0e0 with SMTP id
 j20-20020a05610202f400b00437e5d1a0e0mr4526592vsj.19.1684870934366; Tue, 23
 May 2023 12:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523171535.GE20100@maniforge> <20230523190814.GA32582@maniforge>
In-Reply-To: <20230523190814.GA32582@maniforge>
From: Erik Kline <ek.ietf@gmail.com>
Date: Tue, 23 May 2023 12:42:03 -0700
Message-ID: <CAMGpriVpc5qdtqAObO1nu64kidt6C4UFp_FJ_Ht+DThMHNX-CQ@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>, 
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
 Christoph Hellwig <hch@infradead.org>, Alexei Starovoitov <ast@kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/odGkMnp9tpf8OOrVmiJLYgsTlV0>
Subject: Re: [Bpf] IETF BPF working group draft charter
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

aG93IGFib3V0IGlmIHdlIHB1bGwgQUJJIGJ1dCBsZWF2ZSBFTEY/CgpPbiBUdWUsIE1heSAyMywg
MjAyMyBhdCAxMjowOOKAr1BNIERhdmlkIFZlcm5ldCA8dm9pZEBtYW5pZmF1bHQuY29tPiB3cm90
ZToKPgo+IE9uIFR1ZSwgTWF5IDIzLCAyMDIzIGF0IDEyOjE1OjM1UE0gLTA1MDAsIERhdmlkIFZl
cm5ldCB3cm90ZToKPiA+IE9uIFR1ZSwgTWF5IDIzLCAyMDIzIGF0IDA0OjUwOjQyUE0gKzAwMDAs
IERhdmUgVGhhbGVyIHdyb3RlOgo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4g
PiA+ID4gRnJvbTogRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlmYXVsdC5jb20+Cj4gPiA+ID4gU2Vu
dDogVHVlc2RheSwgTWF5IDIzLCAyMDIzIDk6MzIgQU0KPiA+ID4gPiBUbzogRGF2ZSBUaGFsZXIg
PGR0aGFsZXJAbWljcm9zb2Z0LmNvbT4KPiA+ID4gPiBDYzogSm9zZSBFLiBNYXJjaGVzaSA8amVt
YXJjaEBnbnUub3JnPjsgYnBmQGlldGYub3JnOyBicGYKPiA+ID4gPiA8YnBmQHZnZXIua2VybmVs
Lm9yZz47IEVyaWsgS2xpbmUgPGVrLmlldGZAZ21haWwuY29tPjsgU3VyZXNoIEtyaXNobmFuCj4g
PiA+ID4gKHN1cmVzaGspIDxzdXJlc2hrQGNpc2NvLmNvbT47IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz47Cj4gPiA+ID4gQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVs
Lm9yZz4KPiA+ID4gPiBTdWJqZWN0OiBSZTogW0JwZl0gSUVURiBCUEYgd29ya2luZyBncm91cCBk
cmFmdCBjaGFydGVyCj4gPiA+ID4KPiA+ID4gPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCAwNzo0
MjoxMVBNICswMDAwLCBEYXZlIFRoYWxlciB3cm90ZToKPiA+ID4gPiA+IEpvc2UgRS4gTWFyY2hl
c2kgPGplbWFyY2hAZ251Lm9yZz4gd3JvdGU6Cj4gPiA+ID4gPiA+IEkgd291bGQgdGhpbmsgdGhh
dCB0aGUgd2F5IHRoZSB4ODZfNjQsIGFhcmNoNjQsIHJpc2Mtdiwgc3BhcmMsIG1pcHMsCj4gPiA+
ID4gPiA+IHBvd2VycGMgYXJjaGl0ZWN0dXJlcywgYWxvbmcgd2l0aCB0aGVpciB2YXJpYW50cywg
aGFuZGxlIHRoZWlyIEVMRgo+ID4gPiA+ID4gPiBleHRlbnNpb25zIGFuZCBwc0FCSSwgZW5zdXJl
cyBpbnRlcm9wZXJhYmlsaXR5IGdvb2QgZW5vdWdoIGZvciB0aGUKPiA+ID4gPiBwcm9ibGVtIGF0
IGhhbmQsIGJ1dCBvay4KPiA+ID4gPiA+ID4gSSdtIGRlZmluaXRlbHkgbm90IGFuIGV4cGVydCBp
biB0aGVzZSBtYXR0ZXJzLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgYW0gbm90IGZhbWlsaWFyIGVu
b3VnaCB3aXRoIHRob3NlIHRvIG1ha2UgYW55IGNvbW1lbnQgYWJvdXQgdGhhdC4KPiA+ID4gPgo+
ID4gPiA+IEhpIERhdmUsCj4gPiA+ID4KPiA+ID4gPiBUYWtpbmcgYSBzdGVwIGJhY2sgaGVyZSwg
cGVyaGFwcyB3ZSBuZWVkIHRvIHRoaW5rIGFib3V0IGFsbCBvZiB0aGlzIG1vcmUKPiA+ID4gPiBn
ZW5lcmljYWxseSBhcyAiQUJJIiwgcmF0aGVyIHRoYW4gRUxGICJleHRlbnNpb25zIiwgImJpbmRp
bmdzIiwgZXRjLiAgSW4gbXkKPiA+ID4gPiBvcGluaW9uIHRoaXMgd291bGQgaW5jbHVkZSwgYXQg
YSBtaW5pbXVtLCB0aGUgZm9sbG93aW5nIGl0ZW1zIGZyb20gdGhlIGN1cnJlbnQKPiA+ID4gPiBw
cm9wb3NlZCBXRyBjaGFydGVyOgo+ID4gPiA+Cj4gPiA+ID4gKiB0aGUgZUJQRiBiaW5kaW5ncyBm
b3IgdGhlIEVMRiBleGVjdXRhYmxlIGZpbGUgZm9ybWF0LAo+ID4gPiA+Cj4gPiA+ID4gKiB0aGUg
cGxhdGZvcm0gc3VwcG9ydCBBQkksIGluY2x1ZGluZyBjYWxsaW5nIGNvbnZlbnRpb24sIGxpbmtl
cgo+ID4gPiA+ICAgcmVxdWlyZW1lbnRzLCBhbmQgcmVsb2NhdGlvbnMsCj4gPiA+ID4KPiA+ID4g
PiBBcyBmYXIgYXMgSSBrbm93IChwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcpLCB0aGVy
ZSBpc24ndCByZWFsbHkgYSBwcmVjZWRlbmNlCj4gPiA+ID4gZm9yIHN0YW5kYXJkaXppbmcgQUJJ
cyBsaWtlIHRoaXMuIEZvciBleGFtcGxlLCB4ODYgY2FsbGluZyBjb252ZW50aW9ucyBhcmUgbm90
Cj4gPiA+ID4gc3RhbmRhcmRpemVkLiAgU29sYXJpcywgTGludXgsIEZyZWVCU0QsIG1hY09TLCBl
dGMgYWxsIGZvbGxvdyB0aGUgU3lzdGVtIFYKPiA+ID4gPiBBTUQ2NCBBQkksIGJ1dCBNaWNyb3Nv
ZnQgb2YgY291cnNlIGRvZXMgbm90LiBBcyBKb3NlIHBvaW50ZWQgb3V0LCBzdWNoCj4gPiA+ID4g
c3RhbmRhcmRzIGV4dGVuc2lvbnMgZG8gbm90IGV4aXN0IGZvciBwc0FCSSBFTEYgZXh0ZW5zaW9u
cyBmb3IgdmFyaW91cwo+ID4gPiA+IGFyY2hpdGVjdHVyZXMgZWl0aGVyLgo+ID4gPiA+Cj4gPiA+
ID4gV2hpbGUgaXQgbWF5IGJlIHRoYXQgd2UgZG8gZW5kIHVwIG5lZWRpbmcgdG8gc3RhbmRhcmRp
emUgdGhlc2UgQUJJcyBmb3IgQlBGLAo+ID4gPiA+IEknbSBiZWdpbm5pbmcgdG8gdGhpbmsgdGhh
dCB3ZSBzaG91bGQganVzdCByZW1vdmUgdGhlbSBmcm9tIHRoZSBjdXJyZW50IFdHCj4gPiA+ID4g
Y2hhcnRlciwgYW5kIGNvbnNpZGVyIHN0YW5kYXJkaXppbmcgdGhlbSBhdCBhIGxhdGVyIHRpbWUg
aWYgaXQncyBjbGVhciB0aGF0IGl0J3MKPiA+ID4gPiBhY3R1YWxseSBuZWNlc3NhcnkuIEkgdGhp
bmsgdGhpcyBpcyBlc3BlY2lhbGx5IHRydWUgZ2l2ZW4gdGhhdCB3ZSBkb24ndCBzZWVtIHRvIGJl
Cj4gPiA+ID4gZ2V0dGluZyBhbnkgY2xvc2VyIHRvIGhhdmluZyBjb25zZW5zdXMsIGFuZCB0aGF0
IHdlJ3JlIHZlcnkgc2hvcnQgb24gdGltZSBnaXZlbgo+ID4gPiA+IHRoYXQgRXJpayBpcyBnb2lu
ZyB0byBiZSBwcm9wb3NpbmcgdGhlIGNoYXJ0ZXIgdG8gdGhlIHJlc3Qgb2YgdGhlIEFEcyBpbiBq
dXN0IHR3bwo+ID4gPiA+IGRheXMgb24gNS8yNS4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcywKPiA+
ID4gPiBEYXZpZAo+ID4gPgo+ID4gPiBJIGNhbiB0ZWxsIHlvdSBpdCdzIHZlcnkgaW1wb3J0YW50
IHRvIHRob3NlIHdobyB3b3JrIG9uIHRoZSBlYnBmLWZvci13aW5kb3dzIHByb2plY3QgdGhhdCB0
aGUgRUxGIGZvcm1hdCBpcyBjb21tb24gYmV0d2VlbiBMaW51eCBhbmQgV2luZG93cyBzbyB0aGF0
IHRvb2xzIGxpa2UKPiA+ID4gbGx2bS1vYmpkdW1wIGFuZCBicGZ0b29sIGFuZCBvdGhlciBCUEYt
c3BlY2lmaWMgRUxGIHBhcnNpbmcgdG9vbHMgd29yayBmb3IgYm90aAo+ID4gPiBMaW51eCBhbmQg
V2luZG93cy4gICBXZSBkb24ndCB3YW50IFdpbmRvd3MgdG8gZGl2ZXJnZS4KPiA+Cj4gPiBCZSB0
aGF0IGFzIGl0IG1heSwgYXMgSSBzYWlkIGJlZm9yZSwgdG8gbXkga25vd2xlZGdlIHRoZXJlJ3Mg
bm8KPiA+IHByZWNlZGVuY2UgYXQgYWxsIGZvciBzdGFuZGFyZGl6aW5nIEFCSSBsaWtlIHRoaXMu
IElzIHRoZXJlIGEgcmVhc29uCj4gPiB0aGF0IHlvdSB0aGluayBXaW5kb3dzIHdvdWxkIGRpdmVy
Z2UgaWYgd2UgZGlkbid0IHN0YW5kYXJkaXplIHRoZSBBQkk/Cj4gPgo+ID4gSSByZWFsaXplIHRo
YXQgSSdtIGVzc2VudGlhbGx5IHNheWluZywgIkhleSwgcHJldGVuZCB0aGVyZSdzIGEgc3RhbmRh
cmQKPiA+IGFuZCBkb24ndCBkaXZlcmdlIiwgYnV0IGlmIHRoYXQncyB3aGF0IHRoZSBlbnRpcmUg
cmVzdCBvZiB0aGUgaW5kdXN0cnkKPiA+IGhhcyBkb25lIHVwIHVudGlsIHRoaXMgcG9pbnQgd2l0
aCBhbGwgb3RoZXIgcHNBQklzLCB0aGVuIGl0IHNlZW1zIGxpa2UgYQo+ID4gcmVhc29uYWJsZSBl
eHBlY3RhdGlvbi4KPiA+Cj4gPiA+IEFzIHN1Y2gsIEkgZmVlbCBzdHJvbmdseSB0aGF0IGl0IGlz
IGEgcmVxdWlyZW1lbnQgdG8gYmUgc3RhbmRhcmRpemVkIHJpZ2h0IGF3YXkuCj4gPgo+ID4gSSBo
YXZlIHRvIHJlc3BlY3RmdWxseSBkaXNhZ3JlZS4gSSB0aGluayB0aGVyZSBhcmUgbXVjaCBiaWdn
ZXIgZmlzaCB0bwo+ID4gZnJ5LCBzdWNoIGFzIHN0YW5kYXJkaXppbmcgdGhlIElTQS4gVW5sZXNz
IHdlIHJlYWxseSBoYXZlIGEgZ29vZCByZWFzb24KPiA+IGZvciBkaXZlcmdpbmcgZnJvbSBpbmR1
c3RyeSBub3Jtcywgc3RhbmRhcmRpemluZyBvbiBBQkkgbm93IGZlZWxzIHRvIG1lCj4gPiBsaWtl
IHdlJ3JlIHB1dHRpbmcgdGhlIGNhcnQgYmVmb3JlIHRoZSBob3JzZS4KPgo+IEhpIERhdmUgZXQg
YWwsCj4KPiBGWUksIEkganVzdCBzZW50IG91dCBhIEdpdEh1YiBQUiB0byByZW1vdmUgdGhlc2Ug
bGluZXMgZnJvbSB0aGUgcHJvcG9zZWQKPiBXRyBjaGFydGVyOiBodHRwczovL2dpdGh1Yi5jb20v
ZWtsaW5lL2JwZi9wdWxsLzUvZmlsZXMuIEkgdGhvdWdodCBpdCB3YXMKPiBwcnVkZW50IHRvIGdv
IGFoZWFkIGFuZCBvcGVuIHRoZSBQUiBub3cgZ2l2ZW4gaG93IGNsb3NlIHdlIGFyZSB0byB0aGUK
PiA1LzI1IG1lZXRpbmcsIGFuZCB0aGF0IHdlIGRvbid0IHNlZW0gdG8gYmUgYW55IGNsb3NlciB0
byBnZXR0aW5nCj4gY29uc2Vuc3VzIGhlcmUuCj4KPiBXZSBjYW4gKGFuZCBzaG91bGQpIGNvbnRp
bnVlIHRoZSBkaXNjdXNzaW9uIGhlcmUsIGJ1dCBteSB0d28gY2VudHMgaXMKPiB0aGF0IHVubGVz
cyB0aGVyZSdzIGEgc3Ryb25nIHJlYXNvbiB0byBrZWVwIEFCSSBzdGFuZGFyZGl6YXRpb24gd2l0
aGluCj4gc2NvcGUgb2YgdGhlIFdHLCB0aGF0IGl0IG1ha2VzIHNlbnNlIHRvIHJlbW92ZSB0aGVz
ZSBidWxsZXRzLgo+Cj4gVGhhdCBzYWlkLCBpZiB0aGUgZGlzY3Vzc2lvbiBkaWVzIGRvd24gYW5k
L29yIGRvZXNuJ3QgY29udGludWUsIElNSE8gaXQKPiB3b3VsZCBiZSBwcnVkZW50IHRvIG1lcmdl
IHRoZSBQUi4gSSBkb24ndCB0aGluayBvdXIgZGVmYXVsdCBwb3NpdGlvbgo+IHNob3VsZCBiZSB0
byBkZXZpYXRlIGZyb20gd2VsbC1lc3RhYmxpc2hlZCBpbmR1c3RyeS13aWRlIHByZWNlZGVuY2Us
Cj4gd2l0aCB0aGUgb251cyBiZWluZyBvbiB0aG9zZSBhZHZvY2F0aW5nIGZvciBmb2xsb3dpbmcg
aW5kdXN0cnkgbm9ybXMgdG8KPiBwcm92ZSB0aGF0IHdlIGRvbid0IG5lZWQgdG8gZGlzY3VzcyBp
dC4gQWdhaW4sIEkgbWF5IGJlIG1pc3Npbmcgc29tZQo+IGltcG9ydGFudCBjb250ZXh0IGhlcmUs
IHNvIGFwb2xvZ2llcyBpZiB0aGF0J3MgdGhlIGNhc2UuCj4KPiBUaGFua3MsCj4gRGF2aWQKPgo+
ID4gSnVzdCB0byBiZSB2ZXJ5IGNsZWFyOiBJIGNvdWxkIGJlIHRvdGFsbHkgd3JvbmcgaGVyZSwg
YW5kIGl0IGNvdWxkIGJlCj4gPiB2ZXJ5IGltcG9ydGFudCB0byBkZXZpYXRlIGZyb20gaW5kdXN0
cnkgbm9ybXMgYW5kIHN0YW5kYXJkaXplIEFCSSBhcwo+ID4gcGFydCBvZiB0aGUgaW5pdGlhbCBX
RyBjaGFydGVyLiBIb3dldmVyLCBJTUhPLCBhIHBvc2l0aXZlIGNsYWltIGxpa2UKPiA+IHRoYXQg
bmVlZHMgdG8gY29tZSB3aXRoIGNsZWFyIHN1YnN0YW50aWF0aW9uLiBUaGUgcmVhbGl0eSBpcyB0
aGF0Cj4gPiBkZXZpYXRpbmcgZnJvbSBpbmR1c3RyeSBub3JtcyBhbmQgc3RhbmRhcmRpemluZyBv
biBBQkkgd2lsbCBoYXZlIGl0cyBvd24KPiA+IGNvc3RzIGFuZCBjb25zZXF1ZW5jZXMuCj4gPgo+
ID4gPiBIZW5jZSBJIHdvdWxkIG5vdCB3YW50IHRoaXMgcmVtb3ZlZCBmcm9tIHRoZSBjaGFydGVy
IHVubGVzcyB0aGVyZSdzIGFuIGVmZm9ydAo+ID4gPiB0byBkbyBpdCBzb21ld2hlcmUgZWxzZSBy
aWdodCBhd2F5LCB3aGljaCB3b3VsZCBzZWVtIHRvIGluY3JlYXNlIHRoZSBjb29yZGluYXRpb24K
PiA+ID4gYnVyZGVuLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8v
d3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

