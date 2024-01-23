Return-Path: <bpf+bounces-20143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B23C839D33
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0917D28828C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7C54673;
	Tue, 23 Jan 2024 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="O+SOguk1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="mqsR0YNH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BR2BFK5s"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3753E19
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052594; cv=none; b=T+WBZnfH1OTD/PNzfjSGts/kUo7uXpw3fUuRylO9tIRtY1W0N/PO0xlexyYoyy2CsspUs9aGhM70RIaG2Msdf9FoFmOBMU40USv2dSlp9B2zlx7Q0vyVXXGJLiu+dvaRl+LAHJLA9OdaXCFkBXFFyogAfegZwNkO/7sgSJvuY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052594; c=relaxed/simple;
	bh=SAgKw5Hv5mC6KhBBBcMjAETdaKc8ogZv9YS6G9H1/lU=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=ilKdYswGuEiur6YXWlGikEaLQWNxdMhOeIvgT6FbrwEEz4PS5W1Dl3eux8E2ofWmmlZEvWM7YP2hg0kCW8onVL0FaUP82HNGI+ZawMazQZOlKSCm6Ho75pwd77guT9yDxaMJnG+2klVZjzSzQt3M+vx5Y0cKf2ImWdjvHuZLFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=O+SOguk1; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=mqsR0YNH reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BR2BFK5s reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 698EAC151082
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706052592; bh=SAgKw5Hv5mC6KhBBBcMjAETdaKc8ogZv9YS6G9H1/lU=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+SOguk15WjCk7PuOsB8K1FKZpSvlnfh0u6L87Rs4zX9xpmZ4Bd6wl46WYmJbOzcS
	 +3A/z0ikIWY5CuMNJzIk9+eMgeFhlY+SrH8iVxvZOmqGRxiKawxmAUjYABfaYYWwPq
	 qf7E2Xm0L2yRSrz2i3ZJc95nhjlzz0FnuFnyqvME=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 46670C14CF09;
 Tue, 23 Jan 2024 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706052592; bh=SAgKw5Hv5mC6KhBBBcMjAETdaKc8ogZv9YS6G9H1/lU=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=mqsR0YNH++DZWBJJjNaUQzjx7Cpun+oKLK8anP49yezf19NIllYWdLU9E1b3zaGWQ
 1fBL5VnSmg2rMJ5q7ZAN05Ot/XBJKYVQ90MiUurTKM4P+Gh1dZbXM5FlhI7mVAKBao
 e6I9gJkzFOgknpr377PkRXTlb0zLqW0o0GnCLRl4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A425DC14CF09
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 15:29:50 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dh7Sa7I8y6kn for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 15:29:46 -0800 (PST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 27FE5C14F6E9
 for <bpf@ietf.org>; Tue, 23 Jan 2024 15:29:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-290483f8c7bso3679273a91.3
 for <bpf@ietf.org>; Tue, 23 Jan 2024 15:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706052585; x=1706657385; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uxp7csI7GVkKVo3iyFT9bVz+XlkrKNjW2GUNPvl/QNw=;
 b=BR2BFK5s+p9KLJkifNIbOTTLzKpvB/wux5/EgCr23ppfqokdl9mFEiT/t3s8BhFMxo
 thC53sLVJAe7FcIMrxOd609a8G97dzitP/A34u9fmBWVh5TNrV30trS5YthgOkF/aTfC
 uGoR/93NTOAV/JVWP3nTPjfYLyJlYEpYbpJFhBknBSMsd630/q4W9ncmtuyUaAz0nJEH
 MtxMLergayshR4ecb+JSoAXiZEeOx6NgZvqiOjnKrubRZ94gxM8CJT/YGuuk3GrqVqgW
 5cHfuog3vlJS1U9pp5MUEKTZP9BHBJT9RFDs6yk+wq4OBeGrBIe/nACwzWC0uio+MWFg
 drJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706052585; x=1706657385;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uxp7csI7GVkKVo3iyFT9bVz+XlkrKNjW2GUNPvl/QNw=;
 b=STBTDcrVM22ocGI8rz1oLFXDbbO4rxnv5qdObtg6sh4SLeai/o6MYLRBGdeNFjbUyJ
 PX83Eq8BQNulIpTedpeiGDouQiMoLr6xPPTd51g0yctGctF/WWXntvbMKQpZ4gYYOlUd
 j0ttX3R4oN+BOG8a4y66fyauHd/IaiH1TrCzajZfxf5OBC5l1BIcYf6+zB32P6FmInP6
 r4UKJzaEI6dNo5O9zFQDcNWzkhgrvKdeFFlgECZRDgEO8gKf7KjOUwus0skVr+p/2E+5
 dyKRZXba21i9Wizp10E0Pysa5AkmrUIvE5XgKIyrL2U8pAFU9VaBe+j7gEGiBXsJPJG/
 g6aQ==
X-Gm-Message-State: AOJu0YyGtfL1Iaj8ihbbKQyyTnwoyzUw9f02B1qB/h0dT1pd3IesrU71
 9Mmxv0AHeTqK91qZigLbXjn+EGII7YOIHnL4fY+jljLqP9v41kay
X-Google-Smtp-Source: AGHT+IEGvt/yImDo8Ob1k0Z4lY994xLw3f+pk6Sv7zqAkcyFvFUUx3Hd7wrrrOUxBx08cxEdejrjvQ==
X-Received: by 2002:a17:90a:f614:b0:290:6c4:ad45 with SMTP id
 bw20-20020a17090af61400b0029006c4ad45mr3688918pjb.39.1706052584666; 
 Tue, 23 Jan 2024 15:29:44 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 nc15-20020a17090b37cf00b0028feef1f7adsm12227727pjb.50.2024.01.23.15.29.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:29:44 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
 "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 "'Christoph Hellwig'" <hch@infradead.org>, <bpf@ietf.org>,
 "'bpf'" <bpf@vger.kernel.org>, "'Jakub Kicinski'" <kuba@kernel.org>,
 <david.faust@oracle.com>
References: <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org> <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org>
 <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
 <874jfm68ok.fsf@oracle.com> <20240123213948.GA221862@maniforge>
In-Reply-To: <20240123213948.GA221862@maniforge>
Date: Tue, 23 Jan 2024 15:29:41 -0800
Message-ID: <1f8301da4e54$0b0ad690$212083b0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQClir6lI1sScEFfIiSZU+wYPRcfRwJboihlAe8iqfAB/zVPlgJHtDdIAuBp+8cCBQmzlAH9CezDAX+HGP0B/YYFwQJ+11wssqYPW3A=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ako8ucDfE6AbPMkHyY8DzAMzhHI>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IERhdmlkIFZlcm5ldCA8dm9pZEBt
YW5pZmF1bHQuY29tPgo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjMsIDIwMjQgMTo0MCBQTQo+
IFRvOiBKb3NlIEUuIE1hcmNoZXNpIDxqb3NlLm1hcmNoZXNpQG9yYWNsZS5jb20+Cj4gQ2M6IEFs
ZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT47IENocmlzdG9w
aCBIZWxsd2lnCj4gPGhjaEBpbmZyYWRlYWQub3JnPjsgRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4
QGdvb2dsZW1haWwuY29tPjsKPiBicGZAaWV0Zi5vcmc7IGJwZiA8YnBmQHZnZXIua2VybmVsLm9y
Zz47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Owo+IGRhdmlkLmZhdXN0QG9yYWNs
ZS5jb20KPiBTdWJqZWN0OiBSZTogW0JwZl0gQlBGIElTQSBjb25mb3JtYW5jZSBncm91cHMKPiAK
PiBPbiBUdWUsIEphbiAwOSwgMjAyNCBhdCAxMjozNTozOVBNICswMTAwLCBKb3NlIEUuIE1hcmNo
ZXNpIHdyb3RlOgo+ID4KPiA+ID4gT24gTW9uLCBKYW4gOCwgMjAyNCBhdCA4OjAw4oCvQU0gQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPgo+IHdyb3RlOgo+ID4gPj4KPiA+ID4+
IE9uIEZyaSwgSmFuIDA1LCAyMDI0IGF0IDA0OjA3OjExUE0gLTA2MDAsIERhdmlkIFZlcm5ldCB3
cm90ZToKPiA+ID4+ID4KPiA+ID4+ID4gU28gaG93IGRvIHdlIHdhbnQgdG8gbW92ZSBmb3J3YXJk
IGhlcmU/IEl0IHNvdW5kcyBsaWtlIHdlJ3JlCj4gPiA+PiA+IGxlYW5pbmcgdG93YXJkJ3MgQWxl
eGVpJ3MgcHJvcG9zYWwgb2YgaGF2aW5nOgo+ID4gPj4gPgo+ID4gPj4gPiAtIEJhc2UgSW50ZWdl
ciBJbnN0cnVjdGlvbiBTZXQsIDMyLWJpdAo+ID4gPj4gPiAtIEJhc2UgSW50ZWdlciBJbnN0cnVj
dGlvbiBTZXQsIDY0LWJpdAo+ID4gPj4gPiAtIEludGVnZXIgTXVsdGlwbGljYXRpb24gYW5kIERp
dmlzaW9uCj4gPiA+PiA+IC0gQXRvbWljIEluc3RydWN0aW9ucwo+ID4gPj4KPiA+ID4+IEFzIGlu
IHRoZSA2NC1iaXQgaW50ZWdlciBzZXQgd291bGQgYmUgYW4gYWRkLW9uIHRvIHRoZSBmaXJzdCBv
bmUKPiA+ID4+IHdoaWNoIGlzIHRoZSBjb3JlIHNldD8gIEluIHRoYXQgY2FzZSB0aGF0J3MgZmlu
ZSB3aXRoIG1lLCBidXQgdGhlCj4gPiA+PiBhYm92ZSB3b3JkaW5nIGlzIGEgYml0IHN1Ym9wdGlt
YWwuCj4gPiA+Cj4gPiA+IHllcy4KPiA+ID4gSGVyZSBpcyBob3cgSSB3YXMgdGhpbmtpbmcgYWJv
dXQgdGhlIGdyb3VwaW5nOgo+ID4gPiAzMi1iaXQgc2V0OiBhbGwgMzItYml0IGluc3RydWN0aW9u
cyB0aG9zZSB3aXRoIEJQRl9BTFUgYW5kIEJQRl9KTVAzMgo+ID4gPiBhbmQgbG9hZC9zdG9yZS4K
PiA+ID4KPiA+ID4gNjQtYml0IHNldDogYWJvdmUgcGx1cyBCUEZfQUxVNjQgYW5kIEJQRl9KTVAu
Cj4gPiA+Cj4gPiA+IFRoZSBpZGVhIGlzIHRvIGFsbG93IGZvciBjbGVhbiAzMi1iaXQgSFcgb2Zm
bG9hZHMuCj4gPiA+IFdlIGNhbiBpbnRyb2R1Y2UgYSBjb21waWxlciBmbGFnIHRoYXQgd2lsbCBv
bmx5IHVzZSBzdWNoCj4gPiA+IGluc3RydWN0aW9ucyBhbmQgd2lsbCBlcnJvciB3aGVuIDY0LWJp
dCBtYXRoIGlzIG5lZWRlZC4KPiA+ID4gRGV0YWlscyBuZWVkIHRvIGJlIHRob3VnaHQgdGhyb3Vn
aCwgb2YgY291cnNlLgo+ID4gPiBSaWdodCBub3cgSSdtIG5vdCBzdXJlIHdoZXRoZXIgd2UgbmVl
ZCB0byByZWR1Y2Ugc2l6ZW9mKHZvaWQqKSB0byA0Cj4gPiA+IGluIHN1Y2ggYSBjYXNlIG9yIG5v
cm1hbCA4IHdpbGwgc3RpbGwgd29yaywgYnV0IGZyb20gSVNBIHBlcnNwZWN0aXZlCj4gPiA+IGV2
ZXJ5dGhpbmcgaXMgcmVhZHkuIDMyLWJpdCBzdWJyZWdpc3RlcnMgZml0IHdlbGwuCj4gPiA+IFRo
ZSBjb21waWxlciB3b3JrIHBsdXMgYWRkaXRpb25hbCB2ZXJpZmllciBzbWFydG5lc3MgaXMgbmVl
ZGVkLCBidXQKPiA+ID4gdGhlIGVuZCByZXN1bHQgc2hvdWxkIGJlIHZlcnkgbmljZS4KPiA+ID4g
T2ZmbG9hZCBvZiBicGYgcHJvZ3JhbXMgaW50byAzMi1iaXQgZW1iZWRkZWQgZGV2aWNlcyB3aWxs
IGJlIHBvc3NpYmxlLgo+ID4KPiA+IFRoaXMgaXMgdmVyeSBpbnRlcmVzdGluZy4KPiB0aGlzIGlz
IG5lY2Vzc2FyaWx5IHNvbWV0aGluZyB3ZSBuZWVkIHRvIGZpZ3VyZSBvdXQgbm93LiBIb3BlZnVs
bHkgdGhpcyBpcyBhbGwKPiBzdHVmZiB3ZSBjYW4gaXJvbiBvdXQgb25jZSB3ZSBzdGFydCB0byBy
ZWFsbHkgc2luayBvdXIgdGVldGggaW50byB0aGUgQUJJIGRvYy4KCiJJbnRlZ2VyIE11bHRpcGxp
Y2F0aW9uIGFuZCBEaXZpc2lvbiIgaW4gdGhpcyB0aHJlYWQgZG9lc24ndCBzZWVtIHRvIHNlcGFy
YXRlCmJldHdlZW4gMzItYml0IHZzIDY0LWJpdC4gIElzIHRoZSBwcm9wb3NhbCB0aGF0IG11bHRp
cGxpY2F0aW9uL2RpdmlzaW9uIGlzIG9rCnRvIHJlcXVpcmUgNjQtYml0IG9wZXJhdGlvbnM/ICBJ
IGhhZCBleHBlY3RlZCBvbmUgcmF0aW9uYWxlIGZvciB0aGUgMzJiaXQKbXVsdGlwbGljYXRpb24v
ZGl2aXNpb24gaW5zdHJ1Y3Rpb25zIGlzIHRvIGFjY29tbW9kYXRlIDMyLWJpdC1vbmx5CmltcGxl
bWVudGF0aW9ucy4gICBTbyBzaG91bGQgd2UgaGF2ZSBzZXBhcmF0ZSBncm91cHMgZm9yIDMyLWJp
dCB2cwo2NC1iaXQgZm9yIHRoZSBtdWx0aXBsaWNhdGlvbi9kaXZpc2lvbiBpbnN0cnVjdGlvbnM/
CgpTaW1pbGFyIHF1ZXN0aW9uIGdvZXMgZm9yIHRoZSBhdG9taWMgaW5zdHJ1Y3Rpb25zLCBpLmUu
LCBzaG91bGQgd2UKaGF2ZSBzZXBhcmF0ZSBjb25mb3JtYW5jZSBncm91cHMgZm9yIDMyLWJpdCB2
cyA2NC1iaXQgYXRvbWljcz8gCgpEYXZlCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5v
cmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

