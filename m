Return-Path: <bpf+bounces-6119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FF7660EE
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA3282546
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450E015CC;
	Fri, 28 Jul 2023 00:56:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12A7C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:56:17 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DB2D51
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:56:13 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 94226C1519B0
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690505773; bh=brfZRIKFr1qID4ubPQ4zqax72k/VK1+7bkj4AhhUKDw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=urjM/bgHj61tePRjej3ohcbzGdAC9c5jWhytj+VWzhyFuSxyjbvZqJBPaC1HKjAvj
	 DswUawVEZU8X+hrETfV+gFmUiGAPnnV3HP8rILcPZh85UTqPHCTn062Rzg731cs6mw
	 6dA+SwIwNxkUHF3pep6MsUYyxl2zR2j62ximTthM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul 27 17:56:13 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 61CA6C151709;
	Thu, 27 Jul 2023 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690505773; bh=brfZRIKFr1qID4ubPQ4zqax72k/VK1+7bkj4AhhUKDw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=urjM/bgHj61tePRjej3ohcbzGdAC9c5jWhytj+VWzhyFuSxyjbvZqJBPaC1HKjAvj
	 DswUawVEZU8X+hrETfV+gFmUiGAPnnV3HP8rILcPZh85UTqPHCTn062Rzg731cs6mw
	 6dA+SwIwNxkUHF3pep6MsUYyxl2zR2j62ximTthM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8A0AEC151709
 for <bpf@ietfa.amsl.com>; Thu, 27 Jul 2023 17:56:11 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.105
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
 with ESMTP id Wdfc6KT27ABO for <bpf@ietfa.amsl.com>;
 Thu, 27 Jul 2023 17:56:07 -0700 (PDT)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4D2D6C151066
 for <bpf@ietf.org>; Thu, 27 Jul 2023 17:56:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b9cdbf682eso4866851fa.2
 for <bpf@ietf.org>; Thu, 27 Jul 2023 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690505765; x=1691110565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVVw9V6+eXMOzrYrZNj/SaWARDVdKVJviBLcx53P3ZQ=;
 b=dMNXoWyVBnPDl67ZivzX2VxwxYcYXIq9KlAxmVZA80nQm4okJonRgaMrA8V/2NBPzk
 mHCpq5fkQDfIqcI3Cq697fRDSSB5NIvvB/5/dSV3tjKjqTvLCAXUUx8bXoFyal9mkpB6
 //oCKHZkHc5sIWxp5nVOL3BoY9kxmUDLcZd4jeNJ/sm8WPri9gBLeoe4BpB5OKmdyrja
 VehpGJvV8oZcR6VrZz4oZak5aawtdnM1/rbcTdzHUikzvqzWphpsFMHfDV431k24iOgy
 T9cScWlpCyes8nvMd+d+3Wd9TXltyxpMhzOIzDtm2jhYGtBP0BO+EUfNr/VkTw50FGgQ
 gT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690505765; x=1691110565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVVw9V6+eXMOzrYrZNj/SaWARDVdKVJviBLcx53P3ZQ=;
 b=jmfabwc/nxVPqN0fwJAbyEX5ty4DQi3FP9b32Wqwu6o3Co86ybiT3V3uYNVKUoE+Hd
 qwzD+JkPWmX/rAQtWbWyHyf9YKwe2nEpIRCB/mHvz/HEzkSeHlogaW4hg8bic1Qovkuz
 ODT/iGBMu4x5HMRLUlI4oUef6B79tHgQWmJ9UbGfNrgnA6KJ0Y+57Top6wWpFaE2ye2h
 lte3zGEMBg91WBIg3KuH/B4esp4Y+0gr3spNIs+wG3n3a4cLr1GOO9ym0AKWyKMT+d+P
 3T4zh71ljjmscHay14A8TBxHzFYanQtUY7xjgup92cvYL1F7ztsWXkhQBwsPuyt20mN4
 X5zQ==
X-Gm-Message-State: ABy/qLYibBRNacUFQ758wUM/KlZygWoSPQaFbK1brwtEpw7tspBtTuNu
 UlDfxFLrtaCqT89yPcNbuVe5QFwPguEmYMAgtSI=
X-Google-Smtp-Source: APBJJlEXq2/6tNRsFubcck+VptVVbUngHYk+ZDxKWI6bIwM9a1UKEQdvvWeQh1G1/6r+nfRBZ9gMu6l5DMGhOpJ8oK8=
X-Received: by 2002:a2e:8e93:0:b0:2b5:7a87:a85a with SMTP id
 z19-20020a2e8e93000000b002b57a87a85amr519609ljk.13.1690505764821; Thu, 27 Jul
 2023 17:56:04 -0700 (PDT)
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
In-Reply-To: <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 17:55:53 -0700
Message-ID: <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/JuA030SmDR_XAEr0vw7M8vK76A0>
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTE6MzfigK9BTSBXYXRzb24gTGFkZCA8d2F0c29uYmxh
ZGRAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDk6MTXigK9B
TSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3Jv
dGU6Cj4gPgo+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNzowM+KAr0FNIERhdmUgVGhhbGVy
IDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBJIGFtIGZvcndhcmRp
bmcgdGhlIGVtYWlsIGJlbG93IChhZnRlciBjb252ZXJ0aW5nIEhUTUwgdG8gcGxhaW4gdGV4dCkK
PiA+ID4gdG8gdGhlIG1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBj
YW4gZ28gdG8gYm90aCBsaXN0cy4KPiA+ID4KPiA+ID4gUGxlYXNlIHVzZSB0aGlzIG9uZSBmb3Ig
YW55IHJlcGxpZXMuCj4gPiA+Cj4gPiA+IFRoYW5rcywKPiA+ID4gRGF2ZQo+ID4gPgo+ID4gPiA+
IEZyb206IEJwZiA8YnBmLWJvdW5jZXNAaWV0Zi5vcmc+IE9uIEJlaGFsZiBPZiBXYXRzb24gTGFk
ZAo+ID4gPiA+IFNlbnQ6IE1vbmRheSwgSnVseSAyNCwgMjAyMyAxMDowNSBQTQo+ID4gPiA+IFRv
OiBicGZAaWV0Zi5vcmcKPiA+ID4gPiBTdWJqZWN0OiBbQnBmXSBSZXZpZXcgb2YgZHJhZnQtdGhh
bGVyLWJwZi1pc2EtMDEKPiA+ID4gPgo+ID4gPiA+IERlYXIgQlBGIHdnLAo+ID4gPiA+Cj4gPiA+
ID4gSSB0b29rIGEgbG9vayBhdCB0aGUgZHJhZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21lIGlzc3Vl
cywgdW5zdXJwcmlzaW5nbHkgYXQgdGhpcyBzdGFnZS4gT25lIGlzCj4gPiA+ID4gdGhlIHNwZWNp
ZmljYXRpb24gc2VlbXMgdG8gdXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNvZGUgZm9y
IG9wZXJhdGlvbnMgdnMKPiA+ID4gPiBkZWZpbmluZyB0aGVtIG1hdGhlbWF0aWNhbGx5Lgo+ID4K
PiA+IEhpIFdhdHNvbiwKPiA+Cj4gPiBUaGlzIGlzIG5vdCAidW5kZXJzcGVjaWZpZWQgQyIgcHNl
dWRvIGNvZGUuCj4gPiBUaGlzIGlzIGFzc2VtYmx5IHN5bnRheCBwYXJzZWQgYW5kIGVtaXR0ZWQg
YnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtlcm5lbCwgZXRjLgo+Cj4gSSBkb24ndCBzZWUgYSBy
ZWZlcmVuY2UgdG8gYW55IGRlc2NyaXB0aW9uIG9mIHRoYXQgaW4gc2VjdGlvbiA0LjEuCj4gSXQn
cyBwb3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQgdGhpcywgYW5kIGlmIHBlb3BsZSB0aGluayB0aGlz
IHN0eWxlIG9mCj4gZGVmaW5pdGlvbiBpcyBnb29kIGVub3VnaCB0aGF0IHdvcmtzIGZvciBtZS4g
QnV0IEkgZm91bmQgdGFibGUgNAo+IHByZXR0eSBzY2FudHkgb24gd2hhdCBleGFjdGx5IGhhcHBl
bnMuCgpDb3VsZCB5b3UgcGxlYXNlIGJlIHNwZWNpZmljIHdoaWNoIGluc3RydWN0aW9uIGluIHRh
YmxlIDQgaXMgbm90IG9idmlvdXM/Cgo+ID4KPiA+ID4gPiBUaGUgZ29vZCBuZXdzIGlzIEkgdGhp
bmsgdGhpcyBpcyB2ZXJ5IGZpeGFibGUgYWx0aG91Z2ggdGVkaW91cy4KPiA+ID4gPgo+ID4gPiA+
IFRoZSBvdGhlciB0aG9ybmllciBpc3N1ZXMgYXJlIG1lbW9yeSBtb2RlbCBldGMuIEJ1dCB0aGUg
b3ZlcmFsbCBzdHJ1Y3R1cmUgc2VlbXMgZ29vZAo+ID4gPiA+IGFuZCB0aGUgZG9jdW1lbnQgb3Zl
cmFsbCBtYWtlcyBzZW5zZS4KPiA+Cj4gPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJtZW1vcnkgbW9k
ZWwiID8KPiA+IERvIHlvdSBzZWUgYSByZWZlcmVuY2UgdG8gaXQgPyBQbGVhc2UgYmUgc3BlY2lm
aWMuCj4KPiBObywgYW5kIHRoYXQncyB0aGUgcHJvYmxlbS4gU2VjdGlvbiA1LjIgdGFsa3MgYWJv
dXQgYXRvbWljIG9wZXJhdGlvbnMuCj4gSSdkIGV4cGVjdCB0aGF0IHRvIGJlIHBhaXJlZCB3aXRo
IGEgZGVzY3JpcHRpb24gb2YgYmFycmllcnMgc28gdGhhdAo+IHRoZXNlIHdvcmssIG9yIGEgYmln
IHdhcm5pbmcgYWJvdXQgd2hlbiB5b3UgbmVlZCB0byB1c2UgdGhlbS4KClRoYXQncyBhIGdvb2Qg
c3VnZ2VzdGlvbi4KQSB3YXJuaW5nIHBhcmFncmFwaCB0aGF0IEJQRiBJU0EgZG9lcyBub3QgaGF2
ZSBiYXJyaWVyIGluc3RydWN0aW9ucwppcyBuZWNlc3NhcnkuCgo+IEZvcgo+IGNsYXJpdHkgSSdt
IHByZXR0eSB1bmZhbWlsaWFyIHdpdGggYnBmIGFzIGEgdGVjaG5vbG9neSwgYW5kIGl0J3MKPiBw
b3NzaWJsZSB0aGF0IHdpdGggbW9yZSBrbm93bGVkZ2UgdGhpcyB3b3VsZCBtYWtlIHNlbnNlLiBP
biBsb29raW5nCj4gYmFjayBvbiB0aGF0IEkgZG9uJ3QgZXZlbiBrbm93IGlmIHRoZSBtZW1vcnkg
c3BhY2UgaXMgZmxhdCwgb3IKPiBzZWdtZW50ZWQ6IGNhbiBJIGFjY2VzcyBtYXBzIHRocm91Z2gg
YSB2YWx1ZSBzZXQgdG8gZHN0K29mZnNldCwgb3IKPiBtdXN0IEkgYWx3YXlzIHVzZWQgaW5kZXg/
IEknbSBqdXN0IHZlcnkgY29uZnVzZWQuCgpmbGF0IHZzIHNlZ21lbnRlZCBpcyBhbiBvcnRob2dv
bmFsIHRvcGljLgpXZSBkZWZpbml0ZWx5IG5lZWQgdG8gY292ZXIgaXQgaW4gdGhlIGFyY2hpdGVj
dHVyZSBkb2MuCkJQRiBXRyBjaGFydGVyIHJlcXVpcmVzIHVzIHRvIHByb2R1Y2UgaXQgYXMgSW5m
b3JtYXRpb25hbCBkb2MgZXZlbnR1YWxseS4KCkFzIGZhciBhcyBtZW1vcnkgbW9kZWwgQlBGIGFk
b3B0cyBMS01NIChMaW51eCBLZXJuZWwgTWVtb3J5IE1vZGVsKS4KaHR0cHM6Ly93d3cub3Blbi1z
dGQub3JnL2p0YzEvc2MyMi93ZzIxL2RvY3MvcGFwZXJzLzIwMjAvcDAxMjRyNy5odG1sCgpXZSBj
YW4gYWRkIGEgcmVmZXJlbmNlIHRvIGl0IGZyb20gQlBGIElTQSBkb2MsIGJ1dCBzaW5jZQp0aGVy
ZSBhcmUgbm8gYmFycmllciBpbnN0cnVjdGlvbnMgYXQgdGhlIG1vbWVudCB0aGUgbWVtb3J5IG1v
ZGVsCnN0YXRlbWVudCB3b3VsZCBiZSBwcmVtYXR1cmUuClRoZSB3b3JrIG9uICJCUEYgTWVtb3J5
IE1vZGVsIiBoYXZlIGJlZW4gb25nb2luZyBmb3IgcXVpdGUgc29tZSB0aW1lLgpGb3IgZXhhbXBs
ZSBzZWU6Cmh0dHBzOi8vbHBjLmV2ZW50cy9ldmVudC8xMS9jb250cmlidXRpb25zLzk0MS9hdHRh
Y2htZW50cy84NTkvMTY2Ny9icGYtbWVtb3J5LW1vZGVsLjIwMjAuMDkuMjJhLnBkZgoKQlBGIE1l
bW9yeSBNb2RlbCBpcyBjZXJ0YWlubHkgYW4gaW1wb3J0YW50IHRvcGljLCBidXQgb3V0IG9mIHNj
b3BlIGZvciBJU0EuCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93
d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

