Return-Path: <bpf+bounces-6305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6591767B87
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 04:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAF7282894
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA8EECA;
	Sat, 29 Jul 2023 02:32:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389738C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 02:32:32 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DE346B4
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 19:32:30 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 33203C151539
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690597950; bh=tYihsgzkQtRmqgfIoBCxtxymXeVfIVFXbzo7qdI5R5g=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=kJdFF6j51U36pFqsyiJBQ1Pp8Q060B8HTPPGQqDXomyx/AKXHba0ETWHzHVSZSZ0A
	 sxI0tqg+7w1zzQ15D+e7r/mWHCXQ0jIdf1K+zqPoPPl29OX/3SH43inkR+7x8IeoxE
	 1EReBdIRPpVM8QsA5NomhgaVjRyICGwR7le+UVuk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 19:32:30 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 148CAC14CF1B;
	Fri, 28 Jul 2023 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690597950; bh=tYihsgzkQtRmqgfIoBCxtxymXeVfIVFXbzo7qdI5R5g=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=kJdFF6j51U36pFqsyiJBQ1Pp8Q060B8HTPPGQqDXomyx/AKXHba0ETWHzHVSZSZ0A
	 sxI0tqg+7w1zzQ15D+e7r/mWHCXQ0jIdf1K+zqPoPPl29OX/3SH43inkR+7x8IeoxE
	 1EReBdIRPpVM8QsA5NomhgaVjRyICGwR7le+UVuk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2B97BC14CF0C
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 19:32:29 -0700 (PDT)
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
 with ESMTP id yvbILwdKeaH8 for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 19:32:24 -0700 (PDT)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 461F9C151066
 for <bpf@ietf.org>; Fri, 28 Jul 2023 19:32:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so4705275e87.2
 for <bpf@ietf.org>; Fri, 28 Jul 2023 19:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690597931; x=1691202731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAGoyjZZQXgD4RaI24L+ENGc18HhRgrS3EKHUcupmOY=;
 b=b2R8xH0UsgfSmpXCR0LisYwkN44xnlQgBH6YYj7RrB+zoyzmfeqv/CtGROYIN5nH7p
 KuvSmzUJBjjeyTGLVES308CqcT2trV6XrJd9vEBjCpR1qHd224BYKWS7nX10KlUbrIZh
 cDSlzCjDOlUDq4YRMUN2ETDqOg+4wrfJcsnf0s4mUnzD3S3sjuXyLtZYMsGIIS6JH1ZU
 TTdMxV6iEsC1J9oUg6P2rQooZ/+oF4ze2SWB7Tny5nI3p2Q2khwMzsTX1DWLzqaqImRX
 RqNk5qLKOy5N5qnGEXKqNq0LRwngfsI2sa+ah9lFYSGsTl7vUzWlsz9dklzPnfAflYk9
 w7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690597931; x=1691202731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAGoyjZZQXgD4RaI24L+ENGc18HhRgrS3EKHUcupmOY=;
 b=OZWO4hgcG1k2Yomk2q4sShm5dZR27tviG08DzfF1F0QVSu84WCW8sav2bUOLRLebfj
 YK6227wbKUURP2tN4Z6ap6Ojl8zSjotNM2Oi7HL28wBC0oaW3bcgwMaJysK3T0j4jVpr
 1jzZ0SlC8tcSJn0uzwcTM0BLKzks1jfyV+A2AGUONjb6CGJpkN80FWkr5tpj/JfUPJYb
 TfnOIJ7WNhLumzRoDPQT3dKYWt8e60b0v/pWhMVk7gFmfJsl0oIylSd6eBtpHfjdirnW
 69D4113EgG8TWjOy5oBkvkkcKUcUr0ahJaxpu3J9uXv8x6kSeb/8aWFJO8ga8ulY5fdQ
 Mzow==
X-Gm-Message-State: ABy/qLbRzaqcglYzaR6yLrVwzrNLOxNF6vsmWh/zwEB992EU0Ijy0+cG
 tFTsG4Rv5u13SYGOk6WF6tMdmw+dvdYGvoP2qOc=
X-Google-Smtp-Source: APBJJlGbakjhlMHw0rA1XkUC3Q4C5K/aUrL7svCSadVImsvyJrnFJMUipEi66l0hrf5m7VLlvmjHLEGWK4q0OqInGwg=
X-Received: by 2002:a05:6512:465:b0:4fb:9129:705b with SMTP id
 x5-20020a056512046500b004fb9129705bmr2611341lfd.6.1690597930830; Fri, 28 Jul
 2023 19:32:10 -0700 (PDT)
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
In-Reply-To: <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 19:31:59 -0700
Message-ID: <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Ol5lYvoo_leg2vErREn337KZe2k>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNjowN+KAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6NTLigK9QTSBBbGV4
ZWkgU3Rhcm92b2l0b3YKPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
Pgo+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNTo0NuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3
a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQg
ODozNeKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdt
YWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBGcmksIEp1bCAyOCwgMjAyMyBhdCA1
OjE54oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+IHdyb3RlOgo+ID4gPiA+ID4K
PiA+ID4gPiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MDXigK9QTSBBbGV4ZWkgU3Rhcm92
b2l0b3YKPiA+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNDozMuKAr1BNIFdp
bGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDk6MDXigK9QTSBBbGV4ZWkgU3Rhcm92b2l0
b3YKPiA+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMTI6
MTbigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDI6MzfigK9Q
TSBXYXRzb24gTGFkZCA8d2F0c29uYmxhZGRAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDk6MTXi
gK9BTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+ID4gPiA+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJv
dm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNzowM+KAr0FNIERhdmUgVGhhbGVy
IDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIGZvcndhcmRpbmcgdGhlIGVtYWlsIGJlbG93IChh
ZnRlciBjb252ZXJ0aW5nIEhUTUwgdG8gcGxhaW4gdGV4dCkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gdG8gdGhlIG1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4g
Z28gdG8gYm90aCBsaXN0cy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gUGxlYXNlIHVzZSB0aGlzIG9uZSBmb3IgYW55IHJlcGxpZXMuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gRGF2ZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IEZyb206IEJwZiA8YnBmLWJvdW5jZXNAaWV0Zi5vcmc+IE9uIEJlaGFsZiBPZiBX
YXRzb24gTGFkZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNlbnQ6IE1vbmRheSwgSnVseSAy
NCwgMjAyMyAxMDowNSBQTQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRvOiBicGZAaWV0Zi5v
cmcKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBbQnBmXSBSZXZpZXcgb2YgZHJh
ZnQtdGhhbGVyLWJwZi1pc2EtMDEKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IERlYXIgQlBGIHdnLAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0b29rIGEgbG9vayBhdCB0aGUgZHJhZnQgYW5kIHRo
aW5rIGl0IGhhcyBzb21lIGlzc3VlcywgdW5zdXJwcmlzaW5nbHkgYXQgdGhpcyBzdGFnZS4gT25l
IGlzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlIHNwZWNpZmljYXRpb24gc2VlbXMgdG8g
dXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNvZGUgZm9yIG9wZXJhdGlvbnMgdnMKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkZWZpbmluZyB0aGVtIG1hdGhlbWF0aWNhbGx5Lgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEhpIFdhdHNvbiwKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIG5vdCAidW5kZXJz
cGVjaWZpZWQgQyIgcHNldWRvIGNvZGUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGFz
c2VtYmx5IHN5bnRheCBwYXJzZWQgYW5kIGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4
IEtlcm5lbCwgZXRjLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gSSBk
b24ndCBzZWUgYSByZWZlcmVuY2UgdG8gYW55IGRlc2NyaXB0aW9uIG9mIHRoYXQgaW4gc2VjdGlv
biA0LjEuCj4gPiA+ID4gPiA+ID4gPiA+ID4gSXQncyBwb3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQg
dGhpcywgYW5kIGlmIHBlb3BsZSB0aGluayB0aGlzIHN0eWxlIG9mCj4gPiA+ID4gPiA+ID4gPiA+
ID4gZGVmaW5pdGlvbiBpcyBnb29kIGVub3VnaCB0aGF0IHdvcmtzIGZvciBtZS4gQnV0IEkgZm91
bmQgdGFibGUgNAo+ID4gPiA+ID4gPiA+ID4gPiA+IHByZXR0eSBzY2FudHkgb24gd2hhdCBleGFj
dGx5IGhhcHBlbnMuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEhlbGxvISBC
YXNlZCBvbiBXYXRzb24ncyBwb3N0LCBJIGhhdmUgZG9uZSBzb21lIHJlc2VhcmNoIGFuZCB3b3Vs
ZAo+ID4gPiA+ID4gPiA+ID4gPiBwb3RlbnRpYWxseSBsaWtlIHRvIG9mZmVyIGEgcGF0aCBmb3J3
YXJkLiBUaGVyZSBhcmUgc2V2ZXJhbCBkaWZmZXJlbnQKPiA+ID4gPiA+ID4gPiA+ID4gd2F5cyB0
aGF0IElTQXMgc3BlY2lmeSB0aGUgc2VtYW50aWNzIG9mIHRoZWlyIG9wZXJhdGlvbnM6Cj4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IDEuIEludGVsIGhhcyBhIHNlY3Rpb24gaW4g
dGhlaXIgbWFudWFsIHRoYXQgZGVzY3JpYmVzIHRoZSBwc2V1ZG9jb2RlCj4gPiA+ID4gPiA+ID4g
PiA+IHRoZXkgdXNlIHRvIHNwZWNpZnkgdGhlaXIgSVNBOiBTZWN0aW9uIDMuMS4xLjkgb2YgVGhl
IEludGVswq4gNjQgYW5kCj4gPiA+ID4gPiA+ID4gPiA+IElBLTMyIEFyY2hpdGVjdHVyZXMgU29m
dHdhcmUgRGV2ZWxvcGVy4oCZcyBNYW51YWwgYXQKPiA+ID4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9j
ZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvNjcxMTk5Cj4gPiA+ID4gPiA+ID4gPiA+
IDIuIEFSTSBoYXMgYW4gZXF1aXZhbGVudCBmb3IgdGhlaXIgdmFyaWV0eSBvZiBwc2V1ZG9jb2Rl
OiBDaGFwdGVyIEoxCj4gPiA+ID4gPiA+ID4gPiA+IG9mIEFybSBBcmNoaXRlY3R1cmUgUmVmZXJl
bmNlIE1hbnVhbCBmb3IgQS1wcm9maWxlIGFyY2hpdGVjdHVyZSBhdAo+ID4gPiA+ID4gPiA+ID4g
PiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRpMDQ4Ny9sYXRlc3Qv
Cj4gPiA+ID4gPiA+ID4gPiA+IDMuIFNhaWwgImlzIGEgbGFuZ3VhZ2UgZm9yIGRlc2NyaWJpbmcg
dGhlIGluc3RydWN0aW9uLXNldCBhcmNoaXRlY3R1cmUKPiA+ID4gPiA+ID4gPiA+ID4gKElTQSkg
c2VtYW50aWNzIG9mIHByb2Nlc3NvcnMuIgo+ID4gPiA+ID4gPiA+ID4gPiAoaHR0cHM6Ly93d3cu
Y2wuY2FtLmFjLnVrL35wZXMyMC9zYWlsLykKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gR2l2ZW4gdGhlIGNvbW1lcmNpYWwgbmF0dXJlIG9mICgxKSBhbmQgKDIpLCBwZXJoYXBz
IFNhaWwgaXMgYSB3YXkgdG8KPiA+ID4gPiA+ID4gPiA+ID4gcHJvY2VlZC4gSWYgcGVvcGxlIGFy
ZSBpbnRlcmVzdGVkLCBJIHdvdWxkIGJlIGhhcHB5IHRvIGxlYWQgYW4gZWZmb3J0Cj4gPiA+ID4g
PiA+ID4gPiA+IHRvIGVuY29kZSB0aGUgZUJQRiBJU0Egc2VtYW50aWNzIGluIFNhaWwgKG9yIGZp
bmQgc29tZW9uZSB3aG8gYWxyZWFkeQo+ID4gPiA+ID4gPiA+ID4gPiBoYXMpIGFuZCBpbmNvcnBv
cmF0ZSB0aGVtIGluIHRoZSBkcmFmdC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBp
bW8gU2FpbCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUgcHJhY3RpY2FsIHVzZS4KPiA+ID4gPiA+
ID4gPiA+IExvb2tpbmcgYXQgYXJtNjQgb3IgeDg2IFNhaWwgZGVzY3JpcHRpb24gSSByZWFsbHkg
ZG9uJ3Qgc2VlIGhvdwo+ID4gPiA+ID4gPiA+ID4gaXQgd291bGQgbWFwIHRvIGFuIElFVEYgc3Rh
bmRhcmQuCj4gPiA+ID4gPiA+ID4gPiBJdCdzIGRvbmUgaW4gYSAic2FpbCIgbGFuZ3VhZ2UgdGhh
dCBwZW9wbGUgbmVlZCB0byBsZWFybiBmaXJzdCB0byBiZQo+ID4gPiA+ID4gPiA+ID4gYWJsZSB0
byByZWFkIGl0Lgo+ID4gPiA+ID4gPiA+ID4gU2F5IHdlIGhhZCBicGYuc2FpbCBzb21ld2hlcmUg
b24gZ2l0aHViLiBXaGF0IHZhbHVlIGRvZXMgaXQgYnJpbmcgdG8KPiA+ID4gPiA+ID4gPiA+IEJQ
RiBJU0Egc3RhbmRhcmQ/IEkgZG9uJ3Qgc2VlIGFuIGltbWVkaWF0ZSBiZW5lZml0IHRvIHN0YW5k
YXJkaXphdGlvbi4KPiA+ID4gPiA+ID4gPiA+IFRoZXJlIGNvdWxkIGJlIG90aGVyIHVzZSBjYXNl
cywgbm8gZG91YnQsIGJ1dCBzdGFuZGFyZGl6YXRpb24gaXMgb3VyIGdvYWwuCj4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gQXMgZmFyIGFzIDEgYW5kIDIuIEludGVsIGFuZCBBcm0gdXNl
IHRoZWlyIG93biBwc2V1ZG9jb2RlLCBzbyB0aGV5IGhhZAo+ID4gPiA+ID4gPiA+ID4gdG8gYWRk
IGEgcGFyYWdyYXBoIHRvIGRlc2NyaWJlIGl0LiBXZSBhcmUgdXNpbmcgQyB0byBkZXNjcmliZSBC
UEYgSVNBCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEkgY2Fubm90
IGZpbmQgYSByZWZlcmVuY2UgaW4gdGhlIGN1cnJlbnQgdmVyc2lvbiB0aGF0IHNwZWNpZmllcyB3
aGF0Cj4gPiA+ID4gPiA+ID4gd2UgYXJlIHVzaW5nIHRvIGRlc2NyaWJlIHRoZSBvcGVyYXRpb25z
LiBJJ2QgbGlrZSB0byBhZGQgdGhhdCwgYnV0Cj4gPiA+ID4gPiA+ID4gd2FudCB0byBtYWtlIHN1
cmUgdGhhdCBJIGNsYXJpZnkgdHdvIHN0YXRlbWVudHMgdGhhdCBzZWVtIHRvIGJlIGF0Cj4gPiA+
ID4gPiA+ID4gb2Rkcy4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEltbWVkaWF0ZWx5IGFi
b3ZlIHlvdSBzYXkgdGhhdCB3ZSBhcmUgdXNpbmcgIkMgdG8gZGVzY3JpYmUgdGhlIEJQRgo+ID4g
PiA+ID4gPiA+IElTQSIgYW5kIGZ1cnRoZXIgYWJvdmUgeW91IHNheSAiVGhpcyBpcyBhc3NlbWJs
eSBzeW50YXggcGFyc2VkIGFuZAo+ID4gPiA+ID4gPiA+IGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBn
YXMsIExpbnV4IEtlcm5lbCwgZXRjLiIKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE15IG93
biByZWFkaW5nIGlzIHRoYXQgaXQgaXMgdGhlIGZvcm1lciwgYW5kIG5vdCB0aGUgbGF0dGVyLiBC
dXQsIEkKPiA+ID4gPiA+ID4gPiB3YW50IHRvIGRvdWJsZSBjaGVjayBiZWZvcmUgYWRkaW5nIHRo
ZSBhcHByb3ByaWF0ZSBzdGF0ZW1lbnRzIHRvIHRoZQo+ID4gPiA+ID4gPiA+IENvbnZlbnRpb24g
c2VjdGlvbi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSXQncyBib3RoLiBJJ20gbm90IHN1cmUg
d2hlcmUgeW91IHNlZSBhIGNvbnRyYWRpY3Rpb24uCj4gPiA+ID4gPiA+IEl0J3MgYSBub3JtYWwg
QyBzeW50YXggYW5kIGl0J3MgZW1pdHRlZCBieSB0aGUga2VybmVsIHZlcmlmaWVyLAo+ID4gPiA+
ID4gPiBwYXJzZWQgYnkgY2xhbmcvZ2NjIGFzc2VtYmxlcnMgYW5kIGVtaXR0ZWQgYnkgY29tcGls
ZXJzLgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBPa2F5LiBJIGFwb2xvZ2l6ZS4gSSBh
bSBzaW5jZXJlbHkgY29uZnVzZWQuIEZvciBpbnN0YW5jZSwKPiA+ID4gPiA+Cj4gPiA+ID4gPiBp
ZiAodTMyKWRzdCA+PSAodTMyKXNyYyBnb3RvICtvZmZzZXQKPiA+ID4gPiA+Cj4gPiA+ID4gPiBM
b29rcyBsaWtlIG5vdGhpbmcgdGhhdCBJIGhhdmUgZXZlciBzZWVuIGluICJub3JtYWwgQyBzeW50
YXgiLgo+ID4gPiA+Cj4gPiA+ID4gSSB0aG91Z2h0IHdlJ3JlIHRhbGtpbmcgYWJvdXQgdGFibGUg
NCBhbmQgQUxVIG9wcy4KPiA+ID4gPiBBYm92ZSBpcyBub3QgYSBwdXJlIEMsIGJ1dCBpdCdzIG9i
dmlvdXMgZW5vdWdoIHdpdGhvdXQgZXhwbGFuYXRpb24sIG5vPwo+ID4gPgo+ID4gPiBUbyAidXMi
LCB5ZXMuIEFsdGhvdWdoIEkgYW0gbm90IGFuIGV4cGVydCwgaXQgc2VlbXMgbGlrZSBiZWluZwo+
ID4gPiBleHBsaWNpdCBpcyBpbXBvcnRhbnQgd2hlbiBpdCBjb21lcyB0byB3cml0aW5nIGEgc3Bl
Yy4gSSBzdXBwb3NlIHdlCj4gPiA+IHNob3VsZCBsZWF2ZSB0aGF0IHRvIERhdmUgYW5kIHRoZSBj
aGFpcnMuCj4gPiA+Cj4gPiA+ID4gQWxzbyBJIGRvbid0IHNlZSBhYm92ZSBhbnl3aGVyZSBpbiB0
aGUgZG9jLgo+ID4gPgo+ID4gPiBUaGF0IGlzIGZyb20gdGhlIEFwcGVuZGl4LiBJdCBpcyBjdXJy
ZW50bHkgaW4gRGF2ZSdzIHRyZWUgYW5kIGdldHMKPiA+ID4gYW1hbGdhbWF0ZWQgd2l0aCBvdGhl
ciBmaWxlcyB0byBidWlsZCB0aGUgZmluYWwgZHJhZnQuCj4gPiA+Cj4gPiA+IGh0dHBzOi8vZGF0
YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2RyYWZ0LXRoYWxlci1icGYtaXNhLwo+ID4KPiA+IFRoaXMg
aXMgYSBtaXJyb3IgYW5kIGl0J3MgYWxyZWFkeSBvdXRkYXRlZC4KPiA+IFlvdSBzaG91bGQgbG9v
ayBhdCB0aGUgc291cmNlLiBXaGljaCBpcyBnaXQga2VybmVsIHRyZWUuCj4KPiBBcyBoZSBkaXNj
dXNzZWQgYXQgdGhlIG1lZXRpbmcsIGhlIGhhcyB0aGUgZ2l0aHViIHdvcmtmbG93IHRoYXQKPiBw
cm9kdWNlcyBhIHZlcnNpb24gb2YgdGhlIGRyYWZ0IFJGQyB0aGF0IGhlIHdpbGwgc3VibWl0IHRv
IHRoZSBXRzoKPgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pZXRmLXdnLWJwZi9lYnBmLWRvY3MvYmxv
Yi91cGRhdGUvLmdpdGh1Yi93b3JrZmxvd3MvYnVpbGQueW1sCj4KPiBUaGF0IHVzZXMKPgo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9pZXRmLXdnLWJwZi9lYnBmLWRvY3MvYmxvYi9tYWluL3JzdC9pbnN0
cnVjdGlvbi1zZXQtc2tlbGV0b24ucnN0Cgpjb3JyZWN0LgoKPiB0byBidWlsZCBpbiB0aGUgYWNr
bm93bGVkZ2VtZW50cyBhbmQgc3Vic2VxdWVudGx5IGJyaW5ncyBpbiB0aGF0Cj4gQXBwZW5kaXgu
Cgpjb3JyZWN0LgoKPiBJZiBoZSBwbGFucyB0byB0YWtlIHRoYXQgb3V0LCB0aGVuIHRoYXQncyBn
cmVhdC4gSSB3YXMganVzdAo+IHRyeWluZyB0byBoZWxwLiBTb3JyeS4KCk5vLiBUaGF0IHdvcmtm
bG93IHdpbGwgc3RheS4KVGhlIGZ1dHVyZSBjaGFuZ2VzIHRvIFJGQyB3aWxsIGJlIGluIHRoZSBm
b3JtIG9mIHBhdGNoZXMgdG8KaW5zdHJ1Y3Rpb24tc2V0LXNrZWxldG9uLnJzdC4gT25jZSB0aGV5
IGxhbmQgdGhlIFJGQyB3aWxsIGJlCnJlZ2VuZXJhdGVkLgpXZSBjYW4gcmVnZW5lcmF0ZSBSRkMg
YXMgb2Z0ZW4gYXMgd2UgbGlrZS4KCkFsbCBJJ20gc2F5aW5nIGlzIHRoYXQgUkZDIGhhcyBidWdz
IHRoYXQgd2VyZSBhbHJlYWR5IGZpeGVkIGluCmluc3RydWN0aW9uLXNldC1za2VsZXRvbi5yc3Qu
IEhlbmNlIGl0J3Mgb3V0ZGF0ZWQuCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcK
aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

