Return-Path: <bpf+bounces-4374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7174A864
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4E91C20EE2
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2957110B;
	Fri,  7 Jul 2023 01:20:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AC7F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 01:20:41 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020D51BDB
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:20:39 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 95022C13738C
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688692819; bh=Ox9q9RBX1EpcJh/WVfZmbNUGlULwFwc8jeMVtO8EEX0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U+Yz4VBHeMfrH0oqmaiD/6I70OHZKcPcAZT8SM6evTiKVSbAQ0Npncmr9Wl5dNb/d
	 NmjnCDJSXelqE3rlfhxXEIfzN3a9gZScVy24sZeTGgw0OKzBvnju+xETATlAi/MAPW
	 AWVbv5vQSmUIHdaQwzczU7tWrYXYxsOeJuNsg0nI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 18:20:19 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6AAB4C1519A6;
	Thu,  6 Jul 2023 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688692819; bh=Ox9q9RBX1EpcJh/WVfZmbNUGlULwFwc8jeMVtO8EEX0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=U+Yz4VBHeMfrH0oqmaiD/6I70OHZKcPcAZT8SM6evTiKVSbAQ0Npncmr9Wl5dNb/d
	 NmjnCDJSXelqE3rlfhxXEIfzN3a9gZScVy24sZeTGgw0OKzBvnju+xETATlAi/MAPW
	 AWVbv5vQSmUIHdaQwzczU7tWrYXYxsOeJuNsg0nI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DBB03C151078
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 18:20:17 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.095
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nbIznVSzeI92 for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 18:20:14 -0700 (PDT)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id F3CEAC17EB41
 for <bpf@ietf.org>; Thu,  6 Jul 2023 18:20:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b70bfc8db5so6296001fa.2
 for <bpf@ietf.org>; Thu, 06 Jul 2023 18:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688692804; x=1691284804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPAITjGqmZ7YqQV2/ocNxUrr2tpvL7EtxI2PHwtTtwE=;
 b=EHqJzrKGvZO0+FSMCbIJfJvFWkvbLtbAW0BXJb66VfzZYa7+vIfql6xlC6VZ3mt7xx
 jbeooJ+ODGvm7RICD7Y4M0OZvpUYUV/8QXBuS3y5DnNZCGYG3DRfXoRFflW2l4x8+KPg
 gev7rer44bpJSwMBNoCDKb5IoWLPmVY3ctOnWNmYK1ViAoWuwy7a55wUgvHonxrBcdON
 VeFV+PAhu8DOipmvswz0Qk6X7QxLUu5olIL30YewMJQvIN+7HnSCoHH7RY6s8B3HZyJV
 7PpIHFsvd+EMKWBiKtTPI1DutecVtEpps0Ojkn9511eOhau05CwIoIZJxGtIzo2nkpee
 FlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688692804; x=1691284804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPAITjGqmZ7YqQV2/ocNxUrr2tpvL7EtxI2PHwtTtwE=;
 b=D63jQzN92G9IX8eCwDk88etOB7tiUhlzl9BmD8qMFyP1/kNJ/1xMVk1Vxkdef+AtW6
 p7m5JTk0PNj7vBea5aNpZHC1WP+zVjJKX8vNlAz2WGE3vf/HBXfWhtbWiTAIM+rBMyqh
 ix8cyrqJ+5cht94OPk2pSVSxgYDjrwDGAdfnX8uyF/z/h6jE2X0oK+nFtlMHOlUrsFGi
 1Y81a4i4FgRbxr8X8RMtzpxr8RWfPIXFwYZZJVjh/kbrmsZzkTELHuL5Z96KnuAPrzx9
 tV5v73cV1rMle/CJy2IsLxBjklVEMkC7RE8a34rCySRDhppV9o6V5OSOwlczeqimzaGR
 ChuQ==
X-Gm-Message-State: ABy/qLbPYoJ/MDa5U88Kof9wT1zLzCBM6QzanB8U/fQu2Ahpg1ymBPbV
 PXLmOJCWteiA8Uo4GgmzoEIqt1KTHeZciNxWTls=
X-Google-Smtp-Source: APBJJlGsjuf5OoxN6QW0AzMbWWCa09npGLna6ZYxpcTU+wDG8mVTmhwP5mIkYTwp91cmV5pqVpUIWttkqv6TtmLzlYY=
X-Received: by 2002:a2e:7e08:0:b0:2b4:94ec:e4 with SMTP id
 z8-20020a2e7e08000000b002b494ec00e4mr2602318ljc.22.1688692804052; 
 Thu, 06 Jul 2023 18:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 18:19:52 -0700
Message-ID: <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/1WEHgA0D29KEjeYcFruu0shYDsM>
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCAxMDowMOKAr0FNIERhdmUgVGhhbGVyCjxkdGhhbGVyPTQw
bWljcm9zb2Z0LmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6Cj4KPiBUaGUgY2hhcnRlciBmb3Ig
dGhlIG5ld2x5IGZvcm1lZCBJRVRGIEJQRiBXRyBpbmNsdWRlczoKPgo+IOKAnFRoZSBCUEYgd29y
a2luZyBncm91cCBpcyBpbml0aWFsbHkgdGFza2VkIHdpdGgg4oCmIGNyZWF0aW5nIGEgY2xlYXIg
cHJvY2VzcyBmb3IgZXh0ZW5zaW9ucywg4oCm4oCdCj4KPgo+Cj4gSSB3YW50ZWQgdG8ga2ljayBv
ZmYgYSBkaXNjdXNzaW9uIG9mIHRoaXMgdG9waWMgaW4gcHJlcGFyYXRpb24gZm9yIGRpc2N1c3Np
b24KPiBhdCBJRVRGIDExNy4KPgo+Cj4KPiBPbmNlIHRoZSBCUEYgSVNBIGlzIHB1Ymxpc2hlZCBp
biBhbiBSRkMsIHdlIGV4cGVjdCBtb3JlIGluc3RydWN0aW9ucyBtYXkgYmUKPiBhZGRlZCBvdmVy
IHRpbWUuICBJdCBzZWVtcyB1bmRlc2lyYWJsZSB0byBkZWxheSB1c2Ugc3VjaCBhZGRpdGlvbnMg
dW50aWwKPgo+IGFub3RoZXIgUkZDIGNhbiBiZSBwdWJsaXNoZWQsIGFsdGhvdWdoIGhhdmluZyB0
aGVtIGFwcGVhciBpbiBhbiBSRkMKPiB3b3VsZCBiZSBhIGdvb2QgdGhpbmcgaW4gbXkgdmlldy4K
Pgo+Cj4KPiBQZXJzb25hbGx5LCBJIGVudmlzaW9uIHN1Y2ggYWRkaXRpb25zIHRvIGFwcGVhciBp
biBhbiBSRkMgcGVyIGV4dGVuc2lvbgo+Cj4gKGkuZS4sIHNldCBvZiBhZGRpdGlvbnMpIHJhdGhl
ciB0aGFuIG9ic29sZXRpbmcgdGhlIG9yaWdpbmFsIElTQSBSRkMuICBTbwo+IEkgd291bGQgcHJv
cG9zZSB0aGUgYWJpbGl0eSB0byByZWZlcmVuY2UgYW5vdGhlciBkb2N1bWVudCAoZS5nLiwgb25l
Cj4gaW4gdGhlIExpbnV4IGtlcm5lbCB0cmVlKSBpbiB0aGUgbWVhbnRpbWUuCj4KPgo+Cj4gRm9y
IGNvbXBhcmlzb24sIHRoZSBJQU5BIHJlZ2lzdHJ5IGZvciBVUkkgc2NoZW1lcyBhdAo+IGh0dHBz
Oi8vd3d3LmlhbmEub3JnL2Fzc2lnbm1lbnRzL3VyaS1zY2hlbWVzL3VyaS1zY2hlbWVzLnhodG1s
Cj4gZGVmaW5lcyBzdGF0dXMgdmFsdWVzIGZvciDigJxQZXJtYW5lbnTigJ0gYW5kIOKAnFByb3Zp
c2lvbmFs4oCdIHdpdGggZGlmZmVyZW50Cj4gcmVnaXN0cmF0aW9uIHBvbGljaWVzIGZvciBlYWNo
IG9mIHRob3NlIHR3byBzdGF0dXNlcy4KPgo+Cj4KPiBTaW1pbGFybHksIEkgd291bGQgcHJvcG9z
ZSBhcyBhIHN0cmF3bWFuIHVzaW5nIGFuIElBTkEgcmVnaXN0cnkgKGFzIG1vc3QKPiBJRVRGIHN0
YW5kYXJkcyBkbykgdGhhdCByZXF1aXJlcyBzYXkgYW4gSUVURiBTdGFuZGFyZHMgVHJhY2sgUkZD
IGZvcgo+Cj4g4oCcUGVybWFuZW504oCdIHN0YXR1cywgYW5kIOKAnFNwZWNpZmljYXRpb24gcmVx
dWlyZWTigJ0gKGEgcHVibGljIHNwZWNpZmljYXRpb24KPiByZXZpZXdlZCBieSBhIGRlc2lnbmF0
ZWQgZXhwZXJ0KSBmb3Ig4oCcUHJvdmlzaW9uYWzigJ0gcmVnaXN0cmF0aW9ucy4KPiBTbyB1cGRh
dGluZyBhIGRvY3VtZW50IGluIHNheSB0aGUgTGludXgga2VybmVsIHRyZWUgd291bGQgYmUgc3Vm
ZmljaWVudAo+IGZvciBQcm92aXNpb25hbCByZWdpc3RyYXRpb24sIGFuZCB0aGUgc3RhdHVzIG9m
IGFuIGluc3RydWN0aW9uIHdvdWxkIGNoYW5nZQo+IHRvIFBlcm1hbmVudCBvbmNlIGl0IGFwcGVh
cnMgaW4gYW4gUkZDLgoKVGhlIGRlZmluaXRpb24gb2Ygc3RhdHVzIGFuZCB0aGUgc2VtYW50aWNz
IG1ha2Ugc2Vuc2UsCmJ1dCBJIHN1c3BlY3QgdG8gaW1wbGVtZW50IHRoZW0gdmlhIGZ1bGwgSUFO
QSB3b3VsZCByZXF1aXJlCnRvIGxpc3QgZXZlcnkgaW5zdHJ1Y3Rpb24gZW5jb2RpbmcgaW4gdGhl
IHJlZ2lzdHJ5IGFuZCB0aGF0J3Mgd2hlcmUKSUFOQSBrZXkvdmFsdWUgbWFwcGluZyB3b24ndCB3
b3JrLgo4LWJpdCBvcGNvZGUgaXMgb2Z0ZW4gbm90IGVub3VnaCB0byBkZW5vdGUgYW4gaW5zdHJ1
Y3Rpb24uCkFsbCBvZiB2MSx2Mix2Myx2NCBleGlzdGluZyBleHRlbnNpb25zIHRvIEJQRiBJU0Eg
aGFwcGVuZWQgYnkgYSBjb21iaW5hdGlvbgpvZiBuZXcgOC1iaXQgb3Bjb2RlcyBhbmQgdXNpbmcg
cmVzZXJ2ZWQgYml0cyBpbiBvdGhlciBwYXJ0cyBvZiA2NC1iaXQgaW5zbi4KTm93IHdlIHByZXR0
eSBtdWNoIHJhbiBvdXQgb2YgOC1iaXQgb3Bjb2Rlcy4KU28gdGhlcmUgaXMgcmVhbGx5IG5vdGhp
bmcgdGhlIElBTkEgcmVnaXN0cnkgY2FuIGhlbHAgd2l0aC4KCi0tIApCcGYgbWFpbGluZyBsaXN0
CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

