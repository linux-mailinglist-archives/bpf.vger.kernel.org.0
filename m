Return-Path: <bpf+bounces-4439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F97C74B4E6
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5F1281807
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DF10958;
	Fri,  7 Jul 2023 16:08:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02911FA7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:08:06 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C227E1FE7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:08:04 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9C396C151984
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688746084; bh=2xUsHivFilZqCCGjidyc7aCwdZ/VcaNTxhxAaLK+ZWk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fRV53rUK7ab5PStYwQsq+PiBn7q3hqlaZRk0eJZ9BulqfBhDnNEXb8KJY9GV72RlT
	 pcffuI6DwN26y/BCKCto6TzVxnHedXq62qU1CpAp2h7pUArmNB4+FCost0xPedIZpy
	 2yky/eYK30SAV4YmnNA/CXfheFedaA3trHnpfm1o=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul  7 09:08:04 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 45A87C1516E1;
	Fri,  7 Jul 2023 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688746084; bh=2xUsHivFilZqCCGjidyc7aCwdZ/VcaNTxhxAaLK+ZWk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fRV53rUK7ab5PStYwQsq+PiBn7q3hqlaZRk0eJZ9BulqfBhDnNEXb8KJY9GV72RlT
	 pcffuI6DwN26y/BCKCto6TzVxnHedXq62qU1CpAp2h7pUArmNB4+FCost0xPedIZpy
	 2yky/eYK30SAV4YmnNA/CXfheFedaA3trHnpfm1o=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 648D5C1516E1
 for <bpf@ietfa.amsl.com>; Fri,  7 Jul 2023 09:08:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.894
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
 with ESMTP id tQadF3bv1H0B for <bpf@ietfa.amsl.com>;
 Fri,  7 Jul 2023 09:08:00 -0700 (PDT)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 3ADEDC15155C
 for <bpf@ietf.org>; Fri,  7 Jul 2023 09:08:00 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-635de03a85bso12268996d6.3
 for <bpf@ietf.org>; Fri, 07 Jul 2023 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688746079; x=1691338079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWM0laKU80a42A/voRGaDlLTH+dN0QntMFG+DQux1v8=;
 b=Fafnh3WXK8/J6hqhkU4urJnRZCboyP2SkMD1CqUZ8p/k1nhNupKjF3Ee49qoDRo7Ut
 WCbrsJE7nHTvhus0g0lRIKpUXtpKRMA1pP2DVAJJls6OXEHbTqyPDo6RUN45TnTHp8IN
 ZnPKwETx60jZ+q86v7T9s5PcqPOdTpdvBnSboP33rKDECUjBPTCoJm+W4mMlFsNi/+KL
 6IAwZXumwMnumlq85TEJQwVs1EIvyVJuRCcyjNY9ro2qcNepV2DiVPmMPybApD2uVJ09
 IhFUKgmzfRf1dYzGOR1G7qiY17hutm+1op7p7vCrHryszkbFZFrJHJrruKPdp8TGurH/
 g+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688746079; x=1691338079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWM0laKU80a42A/voRGaDlLTH+dN0QntMFG+DQux1v8=;
 b=FLdM5J01x7rSXw5sQqOT3LelbdCM1c1h/YHRmfsPZzPxw0+eWmpliTEW8SkbPebsAP
 wQ+FN40sFkaj5CVG5zvwtV+vE6lKcg26ykA89RqkpvwPodMe4PPK0nEVG9rE8iGy2HQo
 S767DNW59P55DtDR/x/46JJ+oilCb715rWgUHsux4lI+4ATedN80ZFfh1u2/tbAUSP/U
 jpFpujuYHc+bK+Xd1F3ufkTLkLV81ZA865wxEGyhFQNQOGYV4xOrch0RLByTU46XSwfR
 qF08o9MkmWB0MaQua3E+YtbOdGe5Udw31dt9tM9nlim9C8shxcmCXe502Dx1PsxnDmDt
 tRCg==
X-Gm-Message-State: ABy/qLZD5jduZ0N3NTDo+4mjTPCmhtp8TtZNqh/MUTB/XQ3CcOlJYPev
 Cntq2fMdXANqrprLOgfVELIjQapYRiymmSiPG5q0LQ==
X-Google-Smtp-Source: APBJJlF9hwu/9AwIb6dn0bq9nl9llGXQ1RQJ4cmdTWdHnoR0qV3DOtzTpeyISMnSATqCOmyaDpPHAX8GnrXYAJYK9nk=
X-Received: by 2002:a0c:8b8a:0:b0:635:de52:8383 with SMTP id
 r10-20020a0c8b8a000000b00635de528383mr3902296qva.59.1688746079123; Fri, 07
 Jul 2023 09:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
 <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+ogOVdwZSX4315hHe8bxP-yoYEacNPCP6CTHqn=Xp-uQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+ogOVdwZSX4315hHe8bxP-yoYEacNPCP6CTHqn=Xp-uQ@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 7 Jul 2023 12:07:48 -0400
Message-ID: <CADx9qWjUj5YP6Dr9g2GY6Yrf4-1K+5-v6wE6gYV_R9e3OjBnLw@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/HxW224Z72NVVcZGoeVu42RDwkWQ>
Subject: Re: [Bpf] Instruction set extension policy
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

T24gRnJpLCBKdWwgNywgMjAyMyBhdCAxMjowMeKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEp1bCA2LCAyMDIz
IGF0IDY6MzXigK9QTSBEYXZlIFRoYWxlciA8ZHRoYWxlckBtaWNyb3NvZnQuY29tPiB3cm90ZToK
PiA+Cj4gPiBJIGRvbid0IHNlZSBhbnkgcHJvYmxlbSB3aXRoIGRlZmluaW5nIGFuIElBTkEgcmVn
aXN0cnkgd2l0aCBtdWx0aXBsZSAia2V5IiBmaWVsZHMKPiA+IChvcGNvZGUrc3JjK2ltbSkuICBB
bGwgZXhpc3RpbmcgaW5zdHJ1Y3Rpb25zIGNhbiBiZSBkb25lIGFzIHN1Y2guCj4gPgo+ID4gQmVs
b3cgaXMgc3RyYXdtYW4gdGV4dCB0aGF0IEkgdGhpbmsgZm9sbG93cyBJQU5BJ3MgcmVxdWlyZW1l
bnRzIG91dGxpbmVkCj4gPiBpbiBSRkMgODEyNi4uLgo+ID4KPiA+IC1EYXZlCj4gPgo+ID4gLS0t
IHNuaXAgLS0tCj4gPiBJQU5BIENvbnNpZGVyYXRpb25zCj4gPiA9PT09PT09PT09PT09PT09PT09
Cj4gPgo+ID4gVGhpcyBkb2N1bWVudCBwcm9wb3NlcyBhIG5ldyBJQU5BIHJlZ2lzdHJ5IGZvciBC
UEYgaW5zdHJ1Y3Rpb25zLCBhcyBmb2xsb3dzOgo+ID4KPiA+ICogTmFtZSBvZiB0aGUgcmVnaXN0
cnk6IEJQRiBJbnN0cnVjdGlvbiBTZXQKPiA+ICogTmFtZSBvZiB0aGUgcmVnaXN0cnkgZ3JvdXA6
IHNhbWUgYXMgcmVnaXN0cnkgbmFtZQo+ID4gKiBSZXF1aXJlZCBpbmZvcm1hdGlvbiBmb3IgcmVn
aXN0cmF0aW9uczogVGhlIHZhbHVlcyB0byBhcHBlYXIgaW4gdGhlIGVudHJ5IGZpZWxkcy4KPiA+
ICogU3ludGF4IG9mIHJlZ2lzdHJ5IGVudHJpZXM6IEVhY2ggZW50cnkgaGFzIHRoZSBmb2xsb3dp
bmcgZmllbGRzOgo+ID4gICAqIG9wY29kZTogYSAxLWJ5dGUgdmFsdWUgaW4gaGV4IGZvcm1hdCBp
bmRpY2F0aW5nIHRoZSB2YWx1ZSBvZiB0aGUgb3Bjb2RlIGZpZWxkCj4gPiAgICogc3JjOiBhIDQt
Yml0IHZhbHVlIGluIGhleCBmb3JtYXQgaW5kaWNhdGluZyB0aGUgdmFsdWUgb2YgdGhlIHNyYyBm
aWVsZCwgb3IgImFueSIKPiA+ICAgKiBpbW06IGVpdGhlciBhIHZhbHVlIGluIGhleCBmb3JtYXQg
aW5kaWNhdGluZyB0aGUgdmFsdWUgb2YgdGhlIGltbSBmaWVsZCwgb3IgImFueSIKPiA+ICAgKiBk
ZXNjcmlwdGlvbjogZGVzY3JpcHRpb24gb2Ygd2hhdCB0aGUgaW5zdHJ1Y3Rpb24gZG9lcywgdHlw
aWNhbGx5IGluIHBzZXVkb2NvZGUKPiA+ICAgKiByZWZlcmVuY2U6IGEgcmVmZXJlbmNlIHRvIHRo
ZSBkZWZpbmluZyBzcGVjaWZpY2F0aW9uCj4gPiAgICogc3RhdHVzOiBQZXJtYW5lbnQsIFByb3Zp
c2lvbmFsLCBvciBIaXN0b3JpY2FsCj4gPiAqIFJlZ2lzdHJhdGlvbiBwb2xpY3kgKHNlZSBSRkMg
ODEyNiBzZWN0aW9uIDQgZm9yIGRldGFpbHMpOgo+ID4gICAqIFBlcm1hbmVudDogU3RhbmRhcmRz
IGFjdGlvbgo+ID4gICAqIFByb3Zpc2lvbmFsOiBTcGVjaWZpY2F0aW9uIHJlcXVpcmVkCj4gPiAg
ICogSGlzdG9yaWNhbDogU3BlY2lmaWNhdGlvbiByZXF1aXJlZAo+ID4gKiBJbml0aWFsIHJlZ2lz
dHJhdGlvbnM6IFNlZSB0aGUgQXBwZW5kaXguIEluc3RydWN0aW9ucyBvdGhlciB0aGFuIHRob3Nl
IGxpc3RlZAo+ID4gICBhcyBkZXByZWNhdGVkIGFyZSBQZXJtYW5lbnQuIEFueSBsaXN0ZWQgYXMg
ZGVwcmVjYXRlZCBhcmUgSGlzdG9yaWNhbC4KPgo+IEkgdGhpbmsgdGhhdCBtaWdodCB3b3JrLiBX
aGF0IGlzIHRoZSBuZXh0IHN0ZXAgdGhlbj8KPiBXaG8gaXMgZ29pbmcgdG8gZ2VuZXJhdGUgc3Vj
aCBhIGhleCBkYXRhYmFzZT8KCkkgd291bGQgYmUgbW9yZSB0aGFuIGhhcHB5IHRvIGRvIHRoYXQh
CldpbGwKCj4KPiAtLQo+IEJwZiBtYWlsaW5nIGxpc3QKPiBCcGZAaWV0Zi5vcmcKPiBodHRwczov
L3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QK
QnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

