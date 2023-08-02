Return-Path: <bpf+bounces-6668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C15476C328
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B004E281AFF
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DAFA5F;
	Wed,  2 Aug 2023 02:55:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097EA3D
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:55:38 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55F213D
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:55:37 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CFD19C151B1A
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690944936; bh=Ks/vhisdlhlnzFObALA9ZAtRawZ4wAOB3KCeML7JwGE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fYAYG/vLmtCl6zq603bUgVGnauNevqYTyxAdBh7SePeTLW+FHxGgfbwtgSqGdDlo/
	 9s8Tx47HNpawQc4vrV3lmw9aOJ4pgf9Ed0kMQvuZtuYs7ZB3plNmcfC/2qt2TIr4Y1
	 vvy1hEK9d+2vKdv7AEpM4IYsywkcuaWXncjElZp8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Aug  1 19:55:36 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 912B8C151AFE;
	Tue,  1 Aug 2023 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690944936; bh=Ks/vhisdlhlnzFObALA9ZAtRawZ4wAOB3KCeML7JwGE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fYAYG/vLmtCl6zq603bUgVGnauNevqYTyxAdBh7SePeTLW+FHxGgfbwtgSqGdDlo/
	 9s8Tx47HNpawQc4vrV3lmw9aOJ4pgf9Ed0kMQvuZtuYs7ZB3plNmcfC/2qt2TIr4Y1
	 vvy1hEK9d+2vKdv7AEpM4IYsywkcuaWXncjElZp8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 54028C1519AA
 for <bpf@ietfa.amsl.com>; Tue,  1 Aug 2023 19:55:35 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.105
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FYB9JPm3MKux for <bpf@ietfa.amsl.com>;
 Tue,  1 Aug 2023 19:55:31 -0700 (PDT)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 19AE0C151AFE
 for <bpf@ietf.org>; Tue,  1 Aug 2023 19:55:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b9e6cc93c6so47344771fa.2
 for <bpf@ietf.org>; Tue, 01 Aug 2023 19:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690944928; x=1691549728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3KawIIdSZsZuxgabCo6IdJKUkHbfL/F//FMoh+PB+w=;
 b=YsdBTrSTbcZxqWcZVhQZumdMuDYewrHBF6URjWoGOp+wigQX+n4shOSxlf5t3VoZVQ
 2VjLF845hq/DM10BQVjzXhrAVkfOjaPuRR0v/PjkeRY6ZKGLFYKHgqkUrm4XvII14L5d
 b2J2VmEIMEOGbPEgVj75lO8M5nxI1qQ5VKTW52crU3xx1eFN/IHIYH7k94+kir+YPNID
 kzRF5Pnq402MuA1AZ/e6ed39Q7jknecVkOrazDo4E7W/SAPNQ/Gj7Hj8RK6tF/IbRjpl
 P4j8MFWMkw1ry144bfLLZodMswwkjI4Ke5iUuKKkbsCpSRwUwRS15eLanPHWJaStgcQU
 p3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690944928; x=1691549728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3KawIIdSZsZuxgabCo6IdJKUkHbfL/F//FMoh+PB+w=;
 b=YVvkVIxI8VnwWiCZufmORspOWzThQJ0r+AlAg2N80PX+2whFd8ib9p9GSrNbKv26bX
 4DQV/HoVGxsznIzHnSUYUaD2ECRlyx66tXPkDTJUSGPefS45VCW2pV9qozOKJl3I9k7X
 R2/TcYgrZeg8s1CeNoBNFYy85SYMdISiNiWg582hcgoJLmwwXOh0KMy9FOOtb50T6Nm8
 6YADy5ZxRLuLeBmOzt51Vva9JOx2jmYfCcVOKjvbNIC15YqDTo70hLxxkLQQNwjN0RaP
 YrNH9iBNanpLn4JIPcSt0trSkqL+daO0Mw+BfThuOERkAe/twbxxmJrWa+vU7gfLta+X
 vnJg==
X-Gm-Message-State: ABy/qLaNoTfIWE3SvT9V24WojW8UJM/Qhr13r9wJX9NdxjPsxWQXDfE/
 E4EVfcGIg3+HI/SZQa6S55QCDkL54aV7jp03ofo=
X-Google-Smtp-Source: APBJJlFWHBWllQEsFDmzblSk1xOzJc9L/1BTLjjsGWOcJdSOCSZkLqFKUPChM57tbfYnTFoD+2k/w5ehEQvXz7Ot71A=
X-Received: by 2002:a2e:3c0e:0:b0:2b6:cdfb:d06a with SMTP id
 j14-20020a2e3c0e000000b002b6cdfbd06amr3776757lja.22.1690944928377; Tue, 01
 Aug 2023 19:55:28 -0700 (PDT)
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
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
In-Reply-To: <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:55:17 -0700
Message-ID: <CAADnVQK8sGGA8dwFDH6bJMWv56_s8gzj0yUY5OvMQKiL6d8YHA@mail.gmail.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/gFnwGumOFSpHNef_GYnBGcjzKLs>
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

T24gVHVlLCBBdWcgMSwgMjAyMyBhdCA3OjM04oCvUE0gV2F0c29uIExhZGQgPHdhdHNvbmJsYWRk
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBJbiByZXBseSB0byBhIGxvbmcgY29udmVyc2F0aW9uOgo+
IDxzbmlwPgo+ID4KPiA+IENvdWxkIHlvdSBwbGVhc2UgYmUgc3BlY2lmaWMgd2hpY2ggaW5zdHJ1
Y3Rpb24gaW4gdGFibGUgNCBpcyBub3Qgb2J2aW91cz8KPgo+IFRoZSBxdWVzdGlvbiBpc24ndCBv
YnZpb3VzLCB0aGUgcXVlc3Rpb24gaXMgdW5hbWJpZ2lvdXMsIGFuZCBDIGlzIG5vdAo+IGdyZWF0
IGZvciB0aGlzLiBNYXliZSB3aXRoIGEgcmVmZXJlbmNlIGFuZCBzb21lIHRleHQgaXQgd291bGQg
Z2V0Cj4gYmV0dGVyLgo+ID4KPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGUgZ29vZCBuZXdzIGlzIEkg
dGhpbmsgdGhpcyBpcyB2ZXJ5IGZpeGFibGUgYWx0aG91Z2ggdGVkaW91cy4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gVGhlIG90aGVyIHRob3JuaWVyIGlzc3VlcyBhcmUgbWVtb3J5IG1vZGVsIGV0
Yy4gQnV0IHRoZSBvdmVyYWxsIHN0cnVjdHVyZSBzZWVtcyBnb29kCj4gPiA+ID4gPiA+IGFuZCB0
aGUgZG9jdW1lbnQgb3ZlcmFsbCBtYWtlcyBzZW5zZS4KPiA+ID4gPgo+ID4gPiA+IFdoYXQgZG8g
eW91IG1lYW4gYnkgIm1lbW9yeSBtb2RlbCIgPwo+ID4gPiA+IERvIHlvdSBzZWUgYSByZWZlcmVu
Y2UgdG8gaXQgPyBQbGVhc2UgYmUgc3BlY2lmaWMuCj4gPiA+Cj4gPiA+IE5vLCBhbmQgdGhhdCdz
IHRoZSBwcm9ibGVtLiBTZWN0aW9uIDUuMiB0YWxrcyBhYm91dCBhdG9taWMgb3BlcmF0aW9ucy4K
PiA+ID4gSSdkIGV4cGVjdCB0aGF0IHRvIGJlIHBhaXJlZCB3aXRoIGEgZGVzY3JpcHRpb24gb2Yg
YmFycmllcnMgc28gdGhhdAo+ID4gPiB0aGVzZSB3b3JrLCBvciBhIGJpZyB3YXJuaW5nIGFib3V0
IHdoZW4geW91IG5lZWQgdG8gdXNlIHRoZW0uCj4gPgo+ID4gVGhhdCdzIGEgZ29vZCBzdWdnZXN0
aW9uLgo+ID4gQSB3YXJuaW5nIHBhcmFncmFwaCB0aGF0IEJQRiBJU0EgZG9lcyBub3QgaGF2ZSBi
YXJyaWVyIGluc3RydWN0aW9ucwo+ID4gaXMgbmVjZXNzYXJ5Lgo+ID4KPiA+ID4gRm9yCj4gPiA+
IGNsYXJpdHkgSSdtIHByZXR0eSB1bmZhbWlsaWFyIHdpdGggYnBmIGFzIGEgdGVjaG5vbG9neSwg
YW5kIGl0J3MKPiA+ID4gcG9zc2libGUgdGhhdCB3aXRoIG1vcmUga25vd2xlZGdlIHRoaXMgd291
bGQgbWFrZSBzZW5zZS4gT24gbG9va2luZwo+ID4gPiBiYWNrIG9uIHRoYXQgSSBkb24ndCBldmVu
IGtub3cgaWYgdGhlIG1lbW9yeSBzcGFjZSBpcyBmbGF0LCBvcgo+ID4gPiBzZWdtZW50ZWQ6IGNh
biBJIGFjY2VzcyBtYXBzIHRocm91Z2ggYSB2YWx1ZSBzZXQgdG8gZHN0K29mZnNldCwgb3IKPiA+
ID4gbXVzdCBJIGFsd2F5cyB1c2VkIGluZGV4PyBJJ20ganVzdCB2ZXJ5IGNvbmZ1c2VkLgo+ID4K
PiA+IGZsYXQgdnMgc2VnbWVudGVkIGlzIGFuIG9ydGhvZ29uYWwgdG9waWMuCj4gPiBXZSBkZWZp
bml0ZWx5IG5lZWQgdG8gY292ZXIgaXQgaW4gdGhlIGFyY2hpdGVjdHVyZSBkb2MuCj4gPiBCUEYg
V0cgY2hhcnRlciByZXF1aXJlcyB1cyB0byBwcm9kdWNlIGl0IGFzIEluZm9ybWF0aW9uYWwgZG9j
IGV2ZW50dWFsbHkuCj4KPiBIdWg/IElmIHlvdSBhY2Nlc3MgbWVtb3J5IHRocm91Z2ggc3BlY2lh
bGl6ZWQgZGVzY3JpcHRvcnMrb2Zmc2V0cwo+IHRoYXQncyB2ZXJ5IGRpZmZlcmVudCBmcm9tIGFy
Yml0cmFyeSBjb21wdXRhdGlvbnMgd2l0aCBhZGRyZXNzZXMsIGV2ZW4KPiBpZiB0aGV5IGRvIHRy
YXAuIEEgbGl0dGxlIGV4cGxhbmF0aW9uIG1pZ2h0IG9yaWVudCB0aGUgcmVhZGVyIHRvCj4gdW5k
ZXJzdGFuZCB3aGF0IGlzIGdvaW5nIG9uLiBBcyBpcyBJIHRob3VnaHQgIm9rLCBpdCdzIGZsYXQi
IGFuZCB0aGVuCj4gc2F3IHRoZSBtYXBzIGFuZCByZWFsbHkgZ290IHRocm93biBmb3IgYSBsb29w
LgoKSXQncyBmbGF0LgoKPiA+Cj4gPiBBcyBmYXIgYXMgbWVtb3J5IG1vZGVsIEJQRiBhZG9wdHMg
TEtNTSAoTGludXggS2VybmVsIE1lbW9yeSBNb2RlbCkuCj4gPiBodHRwczovL3d3dy5vcGVuLXN0
ZC5vcmcvanRjMS9zYzIyL3dnMjEvZG9jcy9wYXBlcnMvMjAyMC9wMDEyNHI3Lmh0bWwKPiA+Cj4g
PiBXZSBjYW4gYWRkIGEgcmVmZXJlbmNlIHRvIGl0IGZyb20gQlBGIElTQSBkb2MsIGJ1dCBzaW5j
ZQo+ID4gdGhlcmUgYXJlIG5vIGJhcnJpZXIgaW5zdHJ1Y3Rpb25zIGF0IHRoZSBtb21lbnQgdGhl
IG1lbW9yeSBtb2RlbAo+ID4gc3RhdGVtZW50IHdvdWxkIGJlIHByZW1hdHVyZS4KPiA+IFRoZSB3
b3JrIG9uICJCUEYgTWVtb3J5IE1vZGVsIiBoYXZlIGJlZW4gb25nb2luZyBmb3IgcXVpdGUgc29t
ZSB0aW1lLgo+ID4gRm9yIGV4YW1wbGUgc2VlOgo+ID4gaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50
LzExL2NvbnRyaWJ1dGlvbnMvOTQxL2F0dGFjaG1lbnRzLzg1OS8xNjY3L2JwZi1tZW1vcnktbW9k
ZWwuMjAyMC4wOS4yMmEucGRmCj4gPgo+ID4gQlBGIE1lbW9yeSBNb2RlbCBpcyBjZXJ0YWlubHkg
YW4gaW1wb3J0YW50IHRvcGljLCBidXQgb3V0IG9mIHNjb3BlIGZvciBJU0EuCj4KPiBJIGV4cGVj
dCB0aGF0IGFuIElTQSBkZWZpbmVzIHRoZSBzZW1hbnRpY3Mgb2YgdGhlIGluc3RydWN0aW9ucy4g
V2hpY2gKPiBhYnNvbHV0ZWx5IGluY2x1ZGVzIHRoZSBtZW1vcnkgbW9kZWwuICBOb3cgbWF5YmUg
d2UncmUgZW52aXNpb25pbmcgYQo+IGRpZmZlcmVudCBzcGxpdHRpbmcgb2YgdGhpcyBpbmZvcm1h
dGlvbiwgYnV0IEkgZG9uJ3Qgc2VlIGhvdyBpdCBjYW4ndAo+IGJlIGF0IGEgZGlmZmVyZW50IGxl
dmVsIGlmIHlvdSB3YW50IHRvIGdpdmUgdGhlIGluc3RydWN0aW9ucwo+IHNlbWFudGljcy4KClBs
ZWFzZSByZWFkIHRoZSBsaW5rcyBhYm92ZS4KQlBGIElTQSBpcyBub3QgZ29pbmcgdG8gZGVmaW5l
IFRTTywgZGljdGF0ZSB3ZWFrIG9yZGVyaW5nIG9yIGFueXRoaW5nCmxpa2UgdGhhdC4gSXQgZm9s
bG93cyBMaW51eCBLZXJuZWwgTWVtb3J5IE1vZGVsIHdoaWNoIGlzIGNsb3NlciB0bwpDIG1lbW9y
eSBtb2RlbCB0aGFuIHRvIHdoYXQgSFcgQ1BVcyBzZWUgYXMgbWVtb3J5IG1vZGVsLgpJdCdzIHVu
bGlrZWx5IHRoYXQgd2Ugd2lsbCBldmVyIGludHJvZHVjZSBleHBsaWNpdCBtZW1vcnkgYmFycmll
cgppbnN0cnVjdGlvbnMuIE1vcmUgbGlrZWx5IHRoZXkgd2lsbCBiZSBrZnVuY3MgdGhhdCB3aWxs
IG1hcCB0byBzbXBfbWIoKSwKZG1hX3dtYigpLCBhbmQgZnJpZW5kcyBpbiBrZXJuZWwgRG9jdW1l
bnRhdGlvbi9tZW1vcnktYmFycmllcnMudHh0LgpBbmFsb2dpZXMgd2l0aCBIVyBJU0FzIGFyZSBu
b3QgYXBwbGljYWJsZSBoZXJlLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0
dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

