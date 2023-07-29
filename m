Return-Path: <bpf+bounces-6301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167C767A68
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D91C218BF
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338FE7F7;
	Sat, 29 Jul 2023 00:55:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB627C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:55:30 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8D559F
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:55:10 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A9135C1516EA
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690591598; bh=0VQwq/I71F1cVEnMNtUMQ3HjiyPzLm3rkrXdkb/f0J0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dYJ3s6QiSV97ANBUvebBTQqxmdggIunwFYWc/3vurncR4TQpJDB6KZCHTLOMon86G
	 TCKBMvKwTN0cO7ula/w+EbsNGoIu8JI66dwXpmP2Op9G4cIkSoQwiPAVCrJD2QoEG+
	 FaEIrp/Yj2sGAwm68EcIseqUHW/OYfgvJ6BQb4hk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 17:46:38 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6ABA0C151077;
	Fri, 28 Jul 2023 17:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690591598; bh=0VQwq/I71F1cVEnMNtUMQ3HjiyPzLm3rkrXdkb/f0J0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dYJ3s6QiSV97ANBUvebBTQqxmdggIunwFYWc/3vurncR4TQpJDB6KZCHTLOMon86G
	 TCKBMvKwTN0cO7ula/w+EbsNGoIu8JI66dwXpmP2Op9G4cIkSoQwiPAVCrJD2QoEG+
	 FaEIrp/Yj2sGAwm68EcIseqUHW/OYfgvJ6BQb4hk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3927DC151077
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 17:46:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.905
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
 with ESMTP id RXTRu-6i94wT for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 17:46:31 -0700 (PDT)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D771BC151075
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:46:31 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-63d23473ed5so15844506d6.1
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690591591; x=1691196391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnQ1pJAtnegsZHOqhcVYr5A/jKjI0nebfK5TPS3lN5Y=;
 b=NJRPXOAhlRbmxABzgCbhiIvwMb7yJMoMSWa/FAlShGX6sNXHWAiz1UljJZkiok/ZcX
 7QmblUkVs4g7mFZ9sDAKy5WXELyQnt36mb3BOearoV8vOW1zNYcpNRPy5H2rc6PvkyCj
 YGror3jwIggUoDXF5rVqjKrWc+OK8ulc6aZ25qET7fjmA0dCuJntQ3mwcIhTgHOAjr20
 ONG6GQ/q7wu33hGrYEImMvgR6D+X2zqprAmjMNy0rbJxIsxpf6bwV3UYNi8RI9EbhIdJ
 CiiLtmil6hjK8kAVq7bnofclr+pGMJsHw01IqtOOPI/I5boI5lmn02jjpWMdcn97eZFz
 +O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690591591; x=1691196391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnQ1pJAtnegsZHOqhcVYr5A/jKjI0nebfK5TPS3lN5Y=;
 b=MWRpvZH+C43CsTA4vP4aH6F8plvSBBM1HIiGth0iR7BNlwhj+/w74dQpnme7F+PwkW
 fY/Lha8n7HQDrnqQ+4YRXoZwHOYRnnX1/hTF8xwj3h8hS8+jKyuiRuXADQPqQXhnuhSP
 I++TTV1CFYCOCwuwm99r3SZl8N1CgT1JCLVj03XyCefbO//8TaIjs1VTDw+8zLIemSCS
 xvghtHv0R11jaDyGC7QYoF39nZu7MaPz+AUb89J5nJmjVgTkhix8fCK3nhSyR4xLdvUr
 HTpkNZ2rAQ9/asH1sXdtI9kOct55/B6F+yqAS1bMifolh+5PgYFO6v0X170SGCNaQdp4
 nMeQ==
X-Gm-Message-State: ABy/qLbNfXFMJ6nwwaGzdnnKFzoQxtKMebuy1ZFvqsdS1gSvzEmopLcy
 xyww4cOvlph2Rr6/ghORCIYZxLefVb3QNrKpog6rEA==
X-Google-Smtp-Source: APBJJlHfHAOftx+trekNjTBM4bPEeqf0DtP5xzoraFGp9Xm4G/25kuzQ1Fw2DMfRsazVeCyK95AELwH6kiLFQfPkiAM=
X-Received: by 2002:a05:6214:5b0e:b0:632:15e6:a75e with SMTP id
 ma14-20020a0562145b0e00b0063215e6a75emr4015677qvb.46.1690591590888; Fri, 28
 Jul 2023 17:46:30 -0700 (PDT)
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
In-Reply-To: <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 20:46:19 -0400
Message-ID: <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/YhP6FsCB8oB4QCoUJh3eamsl3hI>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgODozNeKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIEp1bCAyOCwgMjAy
MyBhdCA1OjE54oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+IHdyb3RlOgo+ID4K
PiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MDXigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YK
PiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24g
RnJpLCBKdWwgMjgsIDIwMjMgYXQgNDozMuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2Jz
LmNyPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDk6MDXi
gK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWls
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQg
MTI6MTbigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDI6MzfigK9QTSBXYXRzb24g
TGFkZCA8d2F0c29uYmxhZGRAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDk6MTXigK9BTSBBbGV4ZWkgU3Rhcm92b2l0
b3YKPiA+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNzow
M+KAr0FNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIGZvcndhcmRpbmcgdGhlIGVtYWlsIGJl
bG93IChhZnRlciBjb252ZXJ0aW5nIEhUTUwgdG8gcGxhaW4gdGV4dCkKPiA+ID4gPiA+ID4gPiA+
ID4gdG8gdGhlIG1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4g
Z28gdG8gYm90aCBsaXN0cy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gUGxl
YXNlIHVzZSB0aGlzIG9uZSBmb3IgYW55IHJlcGxpZXMuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiA+ID4gPiA+ID4gRGF2ZQo+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEZyb206IEJwZiA8YnBmLWJvdW5jZXNAaWV0Zi5vcmc+
IE9uIEJlaGFsZiBPZiBXYXRzb24gTGFkZAo+ID4gPiA+ID4gPiA+ID4gPiA+IFNlbnQ6IE1vbmRh
eSwgSnVseSAyNCwgMjAyMyAxMDowNSBQTQo+ID4gPiA+ID4gPiA+ID4gPiA+IFRvOiBicGZAaWV0
Zi5vcmcKPiA+ID4gPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBbQnBmXSBSZXZpZXcgb2YgZHJhZnQt
dGhhbGVyLWJwZi1pc2EtMDEKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
IERlYXIgQlBGIHdnLAo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0
b29rIGEgbG9vayBhdCB0aGUgZHJhZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21lIGlzc3VlcywgdW5z
dXJwcmlzaW5nbHkgYXQgdGhpcyBzdGFnZS4gT25lIGlzCj4gPiA+ID4gPiA+ID4gPiA+ID4gdGhl
IHNwZWNpZmljYXRpb24gc2VlbXMgdG8gdXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNv
ZGUgZm9yIG9wZXJhdGlvbnMgdnMKPiA+ID4gPiA+ID4gPiA+ID4gPiBkZWZpbmluZyB0aGVtIG1h
dGhlbWF0aWNhbGx5Lgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEhpIFdhdHNvbiwK
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIG5vdCAidW5kZXJzcGVjaWZp
ZWQgQyIgcHNldWRvIGNvZGUuCj4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGFzc2VtYmx5IHN5bnRh
eCBwYXJzZWQgYW5kIGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtlcm5lbCwgZXRj
Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSSBkb24ndCBzZWUgYSByZWZlcmVuY2UgdG8g
YW55IGRlc2NyaXB0aW9uIG9mIHRoYXQgaW4gc2VjdGlvbiA0LjEuCj4gPiA+ID4gPiA+ID4gSXQn
cyBwb3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQgdGhpcywgYW5kIGlmIHBlb3BsZSB0aGluayB0aGlz
IHN0eWxlIG9mCj4gPiA+ID4gPiA+ID4gZGVmaW5pdGlvbiBpcyBnb29kIGVub3VnaCB0aGF0IHdv
cmtzIGZvciBtZS4gQnV0IEkgZm91bmQgdGFibGUgNAo+ID4gPiA+ID4gPiA+IHByZXR0eSBzY2Fu
dHkgb24gd2hhdCBleGFjdGx5IGhhcHBlbnMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEhlbGxv
ISBCYXNlZCBvbiBXYXRzb24ncyBwb3N0LCBJIGhhdmUgZG9uZSBzb21lIHJlc2VhcmNoIGFuZCB3
b3VsZAo+ID4gPiA+ID4gPiBwb3RlbnRpYWxseSBsaWtlIHRvIG9mZmVyIGEgcGF0aCBmb3J3YXJk
LiBUaGVyZSBhcmUgc2V2ZXJhbCBkaWZmZXJlbnQKPiA+ID4gPiA+ID4gd2F5cyB0aGF0IElTQXMg
c3BlY2lmeSB0aGUgc2VtYW50aWNzIG9mIHRoZWlyIG9wZXJhdGlvbnM6Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+IDEuIEludGVsIGhhcyBhIHNlY3Rpb24gaW4gdGhlaXIgbWFudWFsIHRoYXQgZGVz
Y3JpYmVzIHRoZSBwc2V1ZG9jb2RlCj4gPiA+ID4gPiA+IHRoZXkgdXNlIHRvIHNwZWNpZnkgdGhl
aXIgSVNBOiBTZWN0aW9uIDMuMS4xLjkgb2YgVGhlIEludGVswq4gNjQgYW5kCj4gPiA+ID4gPiA+
IElBLTMyIEFyY2hpdGVjdHVyZXMgU29mdHdhcmUgRGV2ZWxvcGVy4oCZcyBNYW51YWwgYXQKPiA+
ID4gPiA+ID4gaHR0cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvNjcxMTk5
Cj4gPiA+ID4gPiA+IDIuIEFSTSBoYXMgYW4gZXF1aXZhbGVudCBmb3IgdGhlaXIgdmFyaWV0eSBv
ZiBwc2V1ZG9jb2RlOiBDaGFwdGVyIEoxCj4gPiA+ID4gPiA+IG9mIEFybSBBcmNoaXRlY3R1cmUg
UmVmZXJlbmNlIE1hbnVhbCBmb3IgQS1wcm9maWxlIGFyY2hpdGVjdHVyZSBhdAo+ID4gPiA+ID4g
PiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRpMDQ4Ny9sYXRlc3Qv
Cj4gPiA+ID4gPiA+IDMuIFNhaWwgImlzIGEgbGFuZ3VhZ2UgZm9yIGRlc2NyaWJpbmcgdGhlIGlu
c3RydWN0aW9uLXNldCBhcmNoaXRlY3R1cmUKPiA+ID4gPiA+ID4gKElTQSkgc2VtYW50aWNzIG9m
IHByb2Nlc3NvcnMuIgo+ID4gPiA+ID4gPiAoaHR0cHM6Ly93d3cuY2wuY2FtLmFjLnVrL35wZXMy
MC9zYWlsLykKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gR2l2ZW4gdGhlIGNvbW1lcmNpYWwgbmF0
dXJlIG9mICgxKSBhbmQgKDIpLCBwZXJoYXBzIFNhaWwgaXMgYSB3YXkgdG8KPiA+ID4gPiA+ID4g
cHJvY2VlZC4gSWYgcGVvcGxlIGFyZSBpbnRlcmVzdGVkLCBJIHdvdWxkIGJlIGhhcHB5IHRvIGxl
YWQgYW4gZWZmb3J0Cj4gPiA+ID4gPiA+IHRvIGVuY29kZSB0aGUgZUJQRiBJU0Egc2VtYW50aWNz
IGluIFNhaWwgKG9yIGZpbmQgc29tZW9uZSB3aG8gYWxyZWFkeQo+ID4gPiA+ID4gPiBoYXMpIGFu
ZCBpbmNvcnBvcmF0ZSB0aGVtIGluIHRoZSBkcmFmdC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBpbW8g
U2FpbCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUgcHJhY3RpY2FsIHVzZS4KPiA+ID4gPiA+IExv
b2tpbmcgYXQgYXJtNjQgb3IgeDg2IFNhaWwgZGVzY3JpcHRpb24gSSByZWFsbHkgZG9uJ3Qgc2Vl
IGhvdwo+ID4gPiA+ID4gaXQgd291bGQgbWFwIHRvIGFuIElFVEYgc3RhbmRhcmQuCj4gPiA+ID4g
PiBJdCdzIGRvbmUgaW4gYSAic2FpbCIgbGFuZ3VhZ2UgdGhhdCBwZW9wbGUgbmVlZCB0byBsZWFy
biBmaXJzdCB0byBiZQo+ID4gPiA+ID4gYWJsZSB0byByZWFkIGl0Lgo+ID4gPiA+ID4gU2F5IHdl
IGhhZCBicGYuc2FpbCBzb21ld2hlcmUgb24gZ2l0aHViLiBXaGF0IHZhbHVlIGRvZXMgaXQgYnJp
bmcgdG8KPiA+ID4gPiA+IEJQRiBJU0Egc3RhbmRhcmQ/IEkgZG9uJ3Qgc2VlIGFuIGltbWVkaWF0
ZSBiZW5lZml0IHRvIHN0YW5kYXJkaXphdGlvbi4KPiA+ID4gPiA+IFRoZXJlIGNvdWxkIGJlIG90
aGVyIHVzZSBjYXNlcywgbm8gZG91YnQsIGJ1dCBzdGFuZGFyZGl6YXRpb24gaXMgb3VyIGdvYWwu
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gQXMgZmFyIGFzIDEgYW5kIDIuIEludGVsIGFuZCBBcm0gdXNl
IHRoZWlyIG93biBwc2V1ZG9jb2RlLCBzbyB0aGV5IGhhZAo+ID4gPiA+ID4gdG8gYWRkIGEgcGFy
YWdyYXBoIHRvIGRlc2NyaWJlIGl0LiBXZSBhcmUgdXNpbmcgQyB0byBkZXNjcmliZSBCUEYgSVNB
Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEkgY2Fubm90IGZpbmQgYSByZWZlcmVuY2UgaW4gdGhl
IGN1cnJlbnQgdmVyc2lvbiB0aGF0IHNwZWNpZmllcyB3aGF0Cj4gPiA+ID4gd2UgYXJlIHVzaW5n
IHRvIGRlc2NyaWJlIHRoZSBvcGVyYXRpb25zLiBJJ2QgbGlrZSB0byBhZGQgdGhhdCwgYnV0Cj4g
PiA+ID4gd2FudCB0byBtYWtlIHN1cmUgdGhhdCBJIGNsYXJpZnkgdHdvIHN0YXRlbWVudHMgdGhh
dCBzZWVtIHRvIGJlIGF0Cj4gPiA+ID4gb2Rkcy4KPiA+ID4gPgo+ID4gPiA+IEltbWVkaWF0ZWx5
IGFib3ZlIHlvdSBzYXkgdGhhdCB3ZSBhcmUgdXNpbmcgIkMgdG8gZGVzY3JpYmUgdGhlIEJQRgo+
ID4gPiA+IElTQSIgYW5kIGZ1cnRoZXIgYWJvdmUgeW91IHNheSAiVGhpcyBpcyBhc3NlbWJseSBz
eW50YXggcGFyc2VkIGFuZAo+ID4gPiA+IGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4
IEtlcm5lbCwgZXRjLiIKPiA+ID4gPgo+ID4gPiA+IE15IG93biByZWFkaW5nIGlzIHRoYXQgaXQg
aXMgdGhlIGZvcm1lciwgYW5kIG5vdCB0aGUgbGF0dGVyLiBCdXQsIEkKPiA+ID4gPiB3YW50IHRv
IGRvdWJsZSBjaGVjayBiZWZvcmUgYWRkaW5nIHRoZSBhcHByb3ByaWF0ZSBzdGF0ZW1lbnRzIHRv
IHRoZQo+ID4gPiA+IENvbnZlbnRpb24gc2VjdGlvbi4KPiA+ID4KPiA+ID4gSXQncyBib3RoLiBJ
J20gbm90IHN1cmUgd2hlcmUgeW91IHNlZSBhIGNvbnRyYWRpY3Rpb24uCj4gPiA+IEl0J3MgYSBu
b3JtYWwgQyBzeW50YXggYW5kIGl0J3MgZW1pdHRlZCBieSB0aGUga2VybmVsIHZlcmlmaWVyLAo+
ID4gPiBwYXJzZWQgYnkgY2xhbmcvZ2NjIGFzc2VtYmxlcnMgYW5kIGVtaXR0ZWQgYnkgY29tcGls
ZXJzLgo+ID4KPiA+Cj4gPiBPa2F5LiBJIGFwb2xvZ2l6ZS4gSSBhbSBzaW5jZXJlbHkgY29uZnVz
ZWQuIEZvciBpbnN0YW5jZSwKPiA+Cj4gPiBpZiAodTMyKWRzdCA+PSAodTMyKXNyYyBnb3RvICtv
ZmZzZXQKPiA+Cj4gPiBMb29rcyBsaWtlIG5vdGhpbmcgdGhhdCBJIGhhdmUgZXZlciBzZWVuIGlu
ICJub3JtYWwgQyBzeW50YXgiLgo+Cj4gSSB0aG91Z2h0IHdlJ3JlIHRhbGtpbmcgYWJvdXQgdGFi
bGUgNCBhbmQgQUxVIG9wcy4KPiBBYm92ZSBpcyBub3QgYSBwdXJlIEMsIGJ1dCBpdCdzIG9idmlv
dXMgZW5vdWdoIHdpdGhvdXQgZXhwbGFuYXRpb24sIG5vPwoKVG8gInVzIiwgeWVzLiBBbHRob3Vn
aCBJIGFtIG5vdCBhbiBleHBlcnQsIGl0IHNlZW1zIGxpa2UgYmVpbmcKZXhwbGljaXQgaXMgaW1w
b3J0YW50IHdoZW4gaXQgY29tZXMgdG8gd3JpdGluZyBhIHNwZWMuIEkgc3VwcG9zZSB3ZQpzaG91
bGQgbGVhdmUgdGhhdCB0byBEYXZlIGFuZCB0aGUgY2hhaXJzLgoKPiBBbHNvIEkgZG9uJ3Qgc2Vl
IGFib3ZlIGFueXdoZXJlIGluIHRoZSBkb2MuCgpUaGF0IGlzIGZyb20gdGhlIEFwcGVuZGl4LiBJ
dCBpcyBjdXJyZW50bHkgaW4gRGF2ZSdzIHRyZWUgYW5kIGdldHMKYW1hbGdhbWF0ZWQgd2l0aCBv
dGhlciBmaWxlcyB0byBidWlsZCB0aGUgZmluYWwgZHJhZnQuCgpodHRwczovL2RhdGF0cmFja2Vy
LmlldGYub3JnL2RvYy9kcmFmdC10aGFsZXItYnBmLWlzYS8KCj4gV2UgZGVzY3JpYmUgY29uZGl0
aW9uYWxzIGxpa2U6Cj4gQlBGX0pHRSAgIDB4MyAgICBhbnkgIFBDICs9IG9mZnNldCBpZiBkc3Qg
Pj0gc3JjCj4KPiA+IFRoZXJlIGFsc28gYXBwZWFyIHRvIGJlIGEgZmV3IG90aGVyIHBsYWNlcyB3
aGVyZSB0aGluZ3MgbWlnaHQgYmUgYSBiaXQgd29ua3k6Cj4gPgo+ID4gMS4gQWRkcmVzcyBhcml0
aG1ldGljIGluIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgbG9hZC9zdG9yZQo+ID4gaW5zdHJ1Y3Rp
b25zIHdpbGwgZGVwZW5kIG9uIHRoZSB0eXBlIG9mIHRoZSB0YXJnZXQ6IEUuZy4sCj4gPgo+ID4g
Kih1NjQgKikoZHN0ICsgb2Zmc2V0KSA9IGltbQo+ID4KPiA+IFRoZSBhZGRyZXNzIHRvIHdoaWNo
IHRoZSBzdG9yZSBpcyBkb25lIHdpbGwgYmUgb2Zmc2V0KnNpemVvZihYKSBieXRlcwo+ID4gZnJv
bSBkc3Qgd2hlcmUgWCBpcyB0aGUgdHlwZSBvZiB0aGUgdGFyZ2V0IG9mIGRzdC4gSWYgd2UgYXJl
IGFzc3VtaW5nCj4gPiB0aGF0IGRzdCAob3IgaXRzIGVxdWl2YWxlbnQgaW4gc2ltaWxhciBpbnN0
cnVjdGlvbnMpIGlzIGJlaW5nIHRyZWF0ZWQKPiA+IHNpbXBseSBhcyBhbiB1bnNpZ25lZCBpbnRl
Z2VyLCBJIGJlbGlldmUgdGhhdCB3ZSB3aWxsIGhhdmUgdG8gc2F5IHRoYXQKPiA+IGV4cGxpY2l0
bHksIGVzcGVjaWFsbHkgZ2l2ZW4gdGhhdCB3ZSBkZXNjcmliZSBvZmZzZXQgYXMgInNpZ25lZAo+
ID4gaW50ZWdlciBvZmZzZXQgdXNlZCB3aXRoIHBvaW50ZXIgYXJpdGhtZXRpYyIgaW4gdGhlIElu
c3RydWN0aW9uCj4gPiBlbmNvZGluZyBzZWN0aW9uLgo+Cj4gSXQncyBub3Q6Cj4gKigodTY0ICop
KGRzdCkgKyBvZmZzZXQpID0gaW1tCj4KPiBUaGUgZG9jIGRvZXNuJ3Qgc2F5IHRoYXQgJ2RzdCcg
aXMgYSBwb2ludGVyICd1NjQgKmRzdCcgdHlwZS4KPiBJbnN0ZWFkIGl0IHNheXM6Cj4gLS0KPiBU
aGUgJ2NvZGUnIGZpZWxkIGVuY29kZXMgdGhlIG9wZXJhdGlvbiBhcyBiZWxvdywgd2hlcmUgJ3Ny
YycgYW5kICdkc3QnIHJlZmVyCj4gdG8gdGhlIHZhbHVlcyBvZiB0aGUgc291cmNlIGFuZCBkZXN0
aW5hdGlvbiByZWdpc3RlcnMsIHJlc3BlY3RpdmVseS4KPiAtLQo+Cj4gc28gZHN0ICsgb2Zmc2V0
IGlzIGEgcGxhaW4gYWRkaXRpb24gb2YgdHdvIHZhbHVlcyBhbmQgdGhlbiB0eXBlIGNhc3QuCgpB
Z2FpbiBJIG9mIGNvdXJzZSB1bmRlcnN0YW5kIGFuZCAid2UiIGtub3cgd2hhdCB0aGF0IG1lYW5z
LiBIb3dldmVyLAppdCBzZWVtcyB0byBtZSB0aGF0IGFuIGVhcmxpZXIgZGVzY3JpcHRpb24gb2Yg
b2Zmc2V0IGFzICJzaWduZWQKaW50ZWdlciBvZmZzZXQgdXNlZCB3aXRoIHBvaW50ZXIgYXJpdGht
ZXRpYyIgbWlnaHQgc2lnbmFsIHNvbWV0aGluZwplbHNlIHRvIGFuIHVuZmFtaWxpYXIgcmVhZGVy
LgoKV2lsbAoKPgo+ID4KPiA+IDIuIGh0b1tibF1lTiBmdW5jdGlvbnMgYXJlIG5vdCBzcGVjaWZp
ZWQgYnkgc3RhbmRhcmQgQyBhbmQsIHdoaWxlCj4gPiAib2J2aW91cyIgd2hhdCB0aGV5IGRvLCBh
cmUgbm90IGRlZmluZWQgaW4gdGhlIGRvY3VtZW50IGFueXdoZXJlLgo+Cj4geWVhaC4gd2UgY2Fu
IGFkZCBhIHNob3J0IHNlbnRlbmNlIGFib3V0IGh0b2xuLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QK
QnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

