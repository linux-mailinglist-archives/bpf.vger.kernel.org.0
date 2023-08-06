Return-Path: <bpf+bounces-7093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D377134D
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 04:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842511C20964
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 02:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0A17F6;
	Sun,  6 Aug 2023 02:56:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FA17D1
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 02:56:50 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37295130
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 19:56:48 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DE03BC151983
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691290607; bh=ViONuaIU3A1Hkqf+odXEtwhY6yUdG6dntSKx3RB9nQk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dGvqOo0lBRZxA6C3KJEj5GMweEBUDofKBFXLVXqNKplUuL/4Cx0Sg/jj/MXLHkn2Q
	 lxFtn4jl4+FnHfdKHpV7o8R/j3lade1YDhmyzXqswJ+c3zWuI1RMed4S8xlakhYsnX
	 k1Vr/+PiGYPvasNYm1HK4JOZdUUvrz7phVUDZHAc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Aug  5 19:56:47 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A6B7AC14CE2F;
	Sat,  5 Aug 2023 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691290607; bh=ViONuaIU3A1Hkqf+odXEtwhY6yUdG6dntSKx3RB9nQk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dGvqOo0lBRZxA6C3KJEj5GMweEBUDofKBFXLVXqNKplUuL/4Cx0Sg/jj/MXLHkn2Q
	 lxFtn4jl4+FnHfdKHpV7o8R/j3lade1YDhmyzXqswJ+c3zWuI1RMed4S8xlakhYsnX
	 k1Vr/+PiGYPvasNYm1HK4JOZdUUvrz7phVUDZHAc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 80F5AC14CE2F
 for <bpf@ietfa.amsl.com>; Sat,  5 Aug 2023 19:56:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vfOi5arwAXMS for <bpf@ietfa.amsl.com>;
 Sat,  5 Aug 2023 19:56:45 -0700 (PDT)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E3AFBC14CF1D
 for <bpf@ietf.org>; Sat,  5 Aug 2023 19:56:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-63d0d38ff97so15519846d6.1
 for <bpf@ietf.org>; Sat, 05 Aug 2023 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691290604; x=1691895404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=damG5vm/t1J7f2L/xa/KtKQxE5kVs8bz0pP4WdiMRBg=;
 b=p0NZex5o+2aRJiA22hXKm3Va/8iAB8k87Hkqv3Tbk1P+4env6aCM5YDQgSGP2BoOt4
 V5xk37oP1c2uPvjuNgTCwtbEKg+eeyYl8TqVTPfWM5ohaaeS/kTA8kWusDogfH39/umF
 9oIjQQ2cI6XkZ15Xpy3gf1WXlRezpK1bUrZP2Dd7vTY4Xdg5nBQP6uweCjCK9mW4i3MQ
 lPgxDUTNZWpwYHmh3yx2/GeaEts0EGQG/g1HO+Br8NTjwSzxRBREtjuSUhUKWYwDhOZM
 SNmWyrvHLnzV956WW84yN08bSdMafew+0BZAo8HGTW2Fmh4bmldT/gaTdxMmDORCiNXn
 Q7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691290604; x=1691895404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=damG5vm/t1J7f2L/xa/KtKQxE5kVs8bz0pP4WdiMRBg=;
 b=RUqEsrTvbuZ1a8X5lMTYkV1K98+lu+nC533ZqwmKJCGTBavO8/HB1T9Tj5oYS4ov4g
 IsAHHwn9EjdBUfihUfCUFsyOh8QTBHRgJUU3EBuD1UYsKm2P1FcjJWZdVewTkD103FXb
 WdeTBTkQKFVMKYkbqcOyfUJ0OVx2T6yizKI6HgghZjfEcWVaDAGpTcWV69orcPdySgYf
 DVmqMs5D7u2X3ixHA0cCZc7Qjdc1N/U1Jgf2DB2h9I7JTQ2ma7CBdhcEEfRN+3XyLLrx
 RxeVCZZQlSSgxAS6YMVKi1caUeAzuMCUZvY4HaCgOo6Med3mEFQ9eq7ZKG9TnCpvUQhW
 zRuw==
X-Gm-Message-State: AOJu0YxXDoLPtHlPztlpFZPsvZQY5NjYezayHGJhyz9lZA6ZLtbCn2/J
 uD9eh/znHPAmnaE7majL6cy3u4LfNWLrkSGFQhkJEdYJcCzTXPwQ
X-Google-Smtp-Source: AGHT+IER4QXi06Gwi3d4PW89UL+km9emxHdz72ZAKIBjM7+yi9mch1xdyKLdYs2XcHGOwasWARTrAX1IjhzAKIHduAE=
X-Received: by 2002:ad4:5cc7:0:b0:636:3f18:4c2b with SMTP id
 iu7-20020ad45cc7000000b006363f184c2bmr5136441qvb.29.1691290604587; Sat, 05
 Aug 2023 19:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230805030921.52035-1-hawkinsw@obs.cr>
 <20230805030921.52035-2-hawkinsw@obs.cr>
 <20230805141856.GD519395@maniforge>
In-Reply-To: <20230805141856.GD519395@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 5 Aug 2023 22:56:33 -0400
Message-ID: <CADx9qWi4xvnq9qRO+dyRnRwRm9TEFg3e0YT0zLOMfC40sCmqng@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/RZwLliuCiZRCv2i7hMlaeGApjUU>
Subject: Re: [Bpf] [PATCH v3 2/2] bpf,
 docs: Fix small typo and define semantics of sign extension
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

T24gU2F0LCBBdWcgNSwgMjAyMyBhdCAxMDoxOOKAr0FNIERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgQXVnIDA0LCAyMDIzIGF0IDExOjA5OjE5UE0g
LTA0MDAsIFdpbGwgSGF3a2lucyB3cm90ZToKPiA+IFNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lu
cyA8aGF3a2luc3dAb2JzLmNyPgo+Cj4gSGkgV2lsbCwKPgo+IEdpdmVuIHRoYXQgdGhpcyBpcyBh
IHNlcGFyYXRlIHBhdGNoLCBpdCBzaG91bGQgYWxzbyBoYXZlIGl0cyBvd24gY29tbWl0Cj4gc3Vt
bWFyeSBhcyBpdCB3b3VsZCBiZSBtZXJnZWQgYXMgYSBzZXBhcmF0ZSBjb21taXQgdG8gdGhlIGtl
cm5lbC4KCkFncmVlIC0tIHNvcnJ5IGZvciBhZGRpbmcgaXQgdG8gdGhpcyBzZXQuIEl0IHdhcyBj
b250aW5nZW50IG9uIHRoZQpmaXJzdCBnb2luZyBvbiBzbyB0aGF0IHRoZXJlIHdhcyBub3QgYSBt
ZXJnZSBjb25mbGljdCBzbyBJIGp1c3QgYWRkZWQKaXQgaGVyZS4gSW4gdjMgb2YgdGhlIHBhdGNo
IEkgd2lsbCBtYWtlIHRoZSBjaGFuZ2UhIQoKPgo+IC0gRGF2aWQKPgo+ID4gLS0tCj4gPiAgLi4u
L2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCAgIHwgMzEgKysrKysrKysr
KysrKysrKy0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6
YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXph
dGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiBpbmRleCBmZTI5NmYzNWU1YTcuLjZmM2IzNGVm
N2I3YyAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9p
bnN0cnVjdGlvbi1zZXQucnN0Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6
YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gQEAgLTczLDYgKzczLDI3IEBAIEZ1bmN0aW9u
cwo+ID4gICAgZm9ybWF0IGFuZCByZXR1cm5zIHRoZSBlcXVpdmFsZW50IG51bWJlciB3aXRoIHRo
ZSBzYW1lIGJpdCB3aWR0aCBidXQKPiA+ICAgIG9wcG9zaXRlIGVuZGlhbm5lc3MuCj4gPgo+ID4g
Kwo+ID4gK0RlZmluaXRpb25zCj4gPiArLS0tLS0tLS0tLS0KPiA+ICsKPiA+ICsuLiBnbG9zc2Fy
eTo6Cj4gPiArCj4gPiArICBTaWduIEV4dGVuZAo+ID4gKyAgICBUbyBgc2lnbiBleHRlbmQgYW5g
IGBgWGBgIGAtYml0IG51bWJlciwgQSwgdG8gYWAgYGBZYGAgYC1iaXQgbnVtYmVyLCBCICAsYCBt
ZWFucyB0bwo+ID4gKwo+ID4gKyAgICAjLiBDb3B5IGFsbCBgYFhgYCBiaXRzIGZyb20gYEFgIHRv
IHRoZSBsb3dlciBgYFhgYCBiaXRzIG9mIGBCYC4KPiA+ICsgICAgIy4gU2V0IHRoZSB2YWx1ZSBv
ZiB0aGUgcmVtYWluaW5nIGBgWWBgIC0gYGBYYGAgYml0cyBvZiBgQmAgdG8gdGhlIHZhbHVlIG9m
Cj4gPiArICAgICAgIHRoZSAgbW9zdC1zaWduaWZpY2FudCBiaXQgb2YgYEFgLgo+ID4gKwo+ID4g
Ky4uIGFkbW9uaXRpb246OiBFeGFtcGxlCj4gPiArCj4gPiArICBTaWduIGV4dGVuZCBhbiA4LWJp
dCBudW1iZXIgYGBBYGAgdG8gYSAxNi1iaXQgbnVtYmVyIGBgQmBgIG9uIGEgYmlnLWVuZGlhbiBw
bGF0Zm9ybToKPiA+ICsgIDo6Cj4gPiArCj4gPiArICAgIEE6ICAgICAgICAgIDEwMDAwMTEwCj4g
PiArICAgIEI6IDExMTExMTExIDEwMDAwMTEwCj4gPiArCj4gPiAgUmVnaXN0ZXJzIGFuZCBjYWxs
aW5nIGNvbnZlbnRpb24KPiA+ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4K
PiA+IEBAIC0yNjMsMTcgKzI4NCwxNyBAQCB3aGVyZSAnKHUzMiknIGluZGljYXRlcyB0aGF0IHRo
ZSB1cHBlciAzMiBiaXRzIGFyZSB6ZXJvZWQuCj4gPiAgTm90ZSB0aGF0IG1vc3QgaW5zdHJ1Y3Rp
b25zIGhhdmUgaW5zdHJ1Y3Rpb24gb2Zmc2V0IG9mIDAuIE9ubHkgdGhyZWUgaW5zdHJ1Y3Rpb25z
Cj4gPiAgKGBgQlBGX1NESVZgYCwgYGBCUEZfU01PRGBgLCBgYEJQRl9NT1ZTWGBgKSBoYXZlIGEg
bm9uLXplcm8gb2Zmc2V0Lgo+ID4KPiA+IC1UaGUgZGV2aXNpb24gYW5kIG1vZHVsbyBvcGVyYXRp
b25zIHN1cHBvcnQgYm90aCB1bnNpZ25lZCBhbmQgc2lnbmVkIGZsYXZvcnMuCj4gPiArVGhlIGRp
dmlzaW9uIGFuZCBtb2R1bG8gb3BlcmF0aW9ucyBzdXBwb3J0IGJvdGggdW5zaWduZWQgYW5kIHNp
Z25lZCBmbGF2b3JzLgo+ID4KPiA+ICBGb3IgdW5zaWduZWQgb3BlcmF0aW9ucyAoYGBCUEZfRElW
YGAgYW5kIGBgQlBGX01PRGBgKSwgZm9yIGBgQlBGX0FMVWBgLAo+ID4gICdpbW0nIGlzIGludGVy
cHJldGVkIGFzIGEgMzItYml0IHVuc2lnbmVkIHZhbHVlLiBGb3IgYGBCUEZfQUxVNjRgYCwKPiA+
IC0naW1tJyBpcyBmaXJzdCBzaWduIGV4dGVuZGVkIGZyb20gMzIgdG8gNjQgYml0cywgYW5kIHRo
ZW4gaW50ZXJwcmV0ZWQgYXMKPiA+IC1hIDY0LWJpdCB1bnNpZ25lZCB2YWx1ZS4KPiA+ICsnaW1t
JyBpcyBmaXJzdCA6dGVybTpgc2lnbiBleHRlbmRlZDxTaWduIEV4dGVuZD5gIGZyb20gMzIgdG8g
NjQgYml0cywgYW5kIHRoZW4KPiA+ICtpbnRlcnByZXRlZCBhcyBhIDY0LWJpdCB1bnNpZ25lZCB2
YWx1ZS4KPiA+Cj4gPiAgRm9yIHNpZ25lZCBvcGVyYXRpb25zIChgYEJQRl9TRElWYGAgYW5kIGBg
QlBGX1NNT0RgYCksIGZvciBgYEJQRl9BTFVgYCwKPiA+ICAnaW1tJyBpcyBpbnRlcnByZXRlZCBh
cyBhIDMyLWJpdCBzaWduZWQgdmFsdWUuIEZvciBgYEJQRl9BTFU2NGBgLCAnaW1tJwo+ID4gLWlz
IGZpcnN0IHNpZ24gZXh0ZW5kZWQgZnJvbSAzMiB0byA2NCBiaXRzLCBhbmQgdGhlbiBpbnRlcnBy
ZXRlZCBhcyBhCj4gPiAtNjQtYml0IHNpZ25lZCB2YWx1ZS4KPiA+ICtpcyBmaXJzdCA6dGVybTpg
c2lnbiBleHRlbmRlZDxTaWduIEV4dGVuZD5gIGZyb20gMzIgdG8gNjQgYml0cywgYW5kIHRoZW4K
PiA+ICtpbnRlcnByZXRlZCBhcyBhIDY0LWJpdCBzaWduZWQgdmFsdWUuCj4gPgo+ID4gIFRoZSBg
YEJQRl9NT1ZTWGBgIGluc3RydWN0aW9uIGRvZXMgYSBtb3ZlIG9wZXJhdGlvbiB3aXRoIHNpZ24g
ZXh0ZW5zaW9uLgo+ID4gIGBgQlBGX0FMVSB8IEJQRl9NT1ZTWGBgIHNpZ24gZXh0ZW5kcyA4LWJp
dCBhbmQgMTYtYml0IG9wZXJhbmRzIGludG8gMzIKPgo+IFRoZXJlIGFyZSBzb21lIG90aGVyIHBs
YWNlcyB3aGVyZSB3ZSBzYXkgZS5nLiAic2lnbiBleHRlbmQiLCAic2lnbgo+IGV4dGVuZGluZyIs
IGV0Yy4gQ2FuIHdlIGxpbmsgdGhvc2UgcGxhY2VzIHRvIHlvdXIgaGFuZHkgbmV3IHNlY3Rpb24g
YXMKPiB3ZWxsLCBwbGVhc2U/CgpBYnNvbHV0ZWx5ISBTb3JyeSB0aGF0IEkgbWlzc2VkIHRoZW0h
Cgo+Cj4gVGhhbmtzLAo+IERhdmlkCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcK
aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

