Return-Path: <bpf+bounces-4710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E174E503
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 05:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D7328162B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034FD23D1;
	Tue, 11 Jul 2023 03:01:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F07F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 03:01:44 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C6170A
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:01:16 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A922DC188733
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 20:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689044450; bh=vYFljHXApGPGc/Zl2PqUDiLDLsE14aSKzZdllEEnA1s=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gFfpWHAnKO/PKVeRywcYEs3cbHgNwEo9RRa6DOuY2P5MubaSWIm4dLI4dP7d6Kl4G
	 jBW8ujoN32dB33RohpeiolSFxLRpLVHrfEtF8ZqyQ7lKI/PHF55HSTVNAc/vrMJY1W
	 zXaSozRVgTBOq8SpIvIX2cddeLFGogVnK2x6NcpU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 20:00:50 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7D559C169530;
	Mon, 10 Jul 2023 20:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689044450; bh=vYFljHXApGPGc/Zl2PqUDiLDLsE14aSKzZdllEEnA1s=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gFfpWHAnKO/PKVeRywcYEs3cbHgNwEo9RRa6DOuY2P5MubaSWIm4dLI4dP7d6Kl4G
	 jBW8ujoN32dB33RohpeiolSFxLRpLVHrfEtF8ZqyQ7lKI/PHF55HSTVNAc/vrMJY1W
	 zXaSozRVgTBOq8SpIvIX2cddeLFGogVnK2x6NcpU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A3F24C169530
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 20:00:49 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.098
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxNjmhaymcec for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 20:00:45 -0700 (PDT)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 2A90EC15108D
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:00:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b701e41cd3so84666881fa.3
 for <bpf@ietf.org>; Mon, 10 Jul 2023 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689044443; x=1691636443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yD1/QET0H7GCDRzUTBD6N5PpQd/kikCUI2RLjjjRGxs=;
 b=WRRecegVOujYjoJFDv+plxKF8HYevpAa9A7SuIgY6Z+q7S3zTNKPe/OMqJyKVEXd8S
 NYtv+QW6+gDE7rcKb95nDG55g/G5L6aJsINxmWqB7IZu981TQi3ToqBpJXKGlYSGG8gD
 2cYVrY8RWHyCDakPPCps75INLkItUgFigy9gaeFv6ngm3GqiqdiMd2Avdpm9gLH+E6/5
 97pjAVoHXpg9HzRbYHBp4HM0pX6HP9AdIVAve70Kq4/gsHia/fcf4o9CRQqEHzGTHHdJ
 ToYKhFqYMU5L4ULxKNWfK6ugdQ1UQ/o2CZZQOHI+RZtGm2THDDEvYMmUIGsnfku4eARZ
 wPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044443; x=1691636443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yD1/QET0H7GCDRzUTBD6N5PpQd/kikCUI2RLjjjRGxs=;
 b=b4a62V9Vhu1g2grhMbQcOiwh/gJKV+3YzsvKFvzYGIeW8ujvMIN/DiATxIpHW+2GnQ
 ZuAivuIWn2if0A69JRWX0riR0wsFAcAvo1KM5jjGFWGtUujvtr5ua8mCw7/IFs9PdqQ/
 KQ4UGTfog4Rr+UxG26C3Dwv78vZ9e07APArkuAhu3iIJKzg+S/Rp19OXsl81cRDtw2v/
 rX9cs6+1PpbXd7rM7uzM+Sx04Zv0+0xT3z5XVRzueseIFnH0IG8f8AKzbbnZUrXcHjpd
 qksBMi2F722KQ8JjteSxvJEM5jo7gBxJ6qpAfHGxUHvt9Cx32ZOig0BDS95t4eUakmkn
 zI2A==
X-Gm-Message-State: ABy/qLaKtq603tjj9TbNcbURIIs34HqAXEsFdaV2G812yq5N8kuyDft5
 68Etlqzar2ht7RRc/yjUtAmDUUSQCwRkRt/y6TFRyu+g
X-Google-Smtp-Source: APBJJlHUw3gaBZUJJg5oo6IIH8IbZplYHllIi9LBViqPOkVo4UCV2KlXZef1AztQpcLvoBgB8MbmPNUqN32MrVjHxMI=
X-Received: by 2002:a2e:9a86:0:b0:2b5:86e4:558e with SMTP id
 p6-20020a2e9a86000000b002b586e4558emr12361079lji.38.1689044443268; Mon, 10
 Jul 2023 20:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr>
 <20230710215819.723550-2-hawkinsw@obs.cr>
In-Reply-To: <20230710215819.723550-2-hawkinsw@obs.cr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 20:00:31 -0700
Message-ID: <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/LpNYIzuKShYVJZV2FRaTdl0HqG8>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Specify twos complement as format for signed integers
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

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMjo1OOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IEluIHRoZSBkb2N1bWVudGF0aW9uIG9mIHRoZSBlQlBGIElTQSBp
dCBpcyB1bnNwZWNpZmllZCBob3cgaW50ZWdlcnMgYXJlCj4gcmVwcmVzZW50ZWQuIFNwZWNpZnkg
dGhhdCB0d29zIGNvbXBsZW1lbnQgaXMgdXNlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3
a2lucyA8aGF3a2luc3dAb2JzLmNyPgo+IC0tLQo+ICBEb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVj
dGlvbi1zZXQucnN0IHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdCBi
L0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QKPiBpbmRleCA3NTFlNjU3OTcz
ZjAuLjYzZGZjYmE1ZWI5YSAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVj
dGlvbi1zZXQucnN0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJz
dAo+IEBAIC0xNzMsNiArMTczLDExIEBAIEJQRl9BUlNIICAweGMwICAgc2lnbiBleHRlbmRpbmcg
ZHN0ID4+PSAoc3JjICYgbWFzaykKPiAgQlBGX0VORCAgIDB4ZDAgICBieXRlIHN3YXAgb3BlcmF0
aW9ucyAoc2VlIGBCeXRlIHN3YXAgaW5zdHJ1Y3Rpb25zYF8gYmVsb3cpCj4gID09PT09PT09ICA9
PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQo+Cj4gK2VCUEYgc3VwcG9ydHMgMzItIGFuZCA2NC1iaXQgc2lnbmVkIGFuZCB1bnNp
Z25lZCBpbnRlZ2Vycy4gSXQgZG9lcwo+ICtub3Qgc3VwcG9ydCBmbG9hdGluZy1wb2ludCBkYXRh
IHR5cGVzLiBBbGwgc2lnbmVkIGludGVnZXJzIGFyZSByZXByZXNlbnRlZCBpbgo+ICt0d29zLWNv
bXBsZW1lbnQgZm9ybWF0IHdoZXJlIHRoZSBzaWduIGJpdCBpcyBzdG9yZWQgaW4gdGhlIG1vc3Qt
c2lnbmlmaWNhbnQKPiArYml0LgoKQ291bGQgeW91IHBvaW50IHRvIGFub3RoZXIgSVNBIGRvY3Vt
ZW50IChsaWtlIHg4NiwgYXJtLCAuLi4pIHRoYXQKdGFsa3MgYWJvdXQgc2lnbmVkIGFuZCB1bnNp
Z25lZCBpbnRlZ2Vycz8KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczov
L3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

