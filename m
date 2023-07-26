Return-Path: <bpf+bounces-5995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2AB763F67
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 21:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B54E1C213D4
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387718040;
	Wed, 26 Jul 2023 19:16:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23C4CE84
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 19:16:28 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35D2719
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:16:25 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9BF19C16B5C7
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690398985; bh=ZUc3Rr8NEzLfuWqZngH/iY9fgF/jiG17IMUTdmE92Mw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=spvpSqJoh+AXIzgeTSECVG6emaj6D7EVvoq380Dnfx/kUfh9bJuRWrz34wzz69uUJ
	 poTbNyebyvdKAflX713GCnjqUO/CvmP58OXIIhYi4vzE5AZTxoIZGnw8JYKxsIubk6
	 A435EtQYpsduPUXn+Aw3nCeTumTPSuXByksx7vL4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jul 26 12:16:25 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 70E86C15C520;
	Wed, 26 Jul 2023 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690398985; bh=ZUc3Rr8NEzLfuWqZngH/iY9fgF/jiG17IMUTdmE92Mw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=spvpSqJoh+AXIzgeTSECVG6emaj6D7EVvoq380Dnfx/kUfh9bJuRWrz34wzz69uUJ
	 poTbNyebyvdKAflX713GCnjqUO/CvmP58OXIIhYi4vzE5AZTxoIZGnw8JYKxsIubk6
	 A435EtQYpsduPUXn+Aw3nCeTumTPSuXByksx7vL4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CB20AC15C520
 for <bpf@ietfa.amsl.com>; Wed, 26 Jul 2023 12:16:24 -0700 (PDT)
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
 with ESMTP id kPYUQ9JBhPxJ for <bpf@ietfa.amsl.com>;
 Wed, 26 Jul 2023 12:16:20 -0700 (PDT)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6F575C15C501
 for <bpf@ietf.org>; Wed, 26 Jul 2023 12:16:20 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4452fe640fbso59500137.0
 for <bpf@ietf.org>; Wed, 26 Jul 2023 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690398979; x=1691003779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JM0ukKexePxMNw1wW/WLU+P2Zc71N+iGNBjfGQCeoCk=;
 b=Bt4VN8O53f0KG+ZxAAB+hWBFMVXZi01E0yyoSRd2/SdgshfnugBS+zAjbbJb0jmMvc
 x62uJrnWRaZRgArfLTjSGX6xbOApAupL9UMIOmREW9tq4WuEL/oTm83ruLYnySW771m0
 NzM4QKDWGw5b+VVrsQcbSG0JWisv9SjjuvKxrGkPEz4cElxEXHy21h0SrW0BMRNcvi7I
 +IArYh0iJfkmLdrQSz5/DE/qdTztllbp5nYvhc5dDslHoi/s4Pa9kD0Ca4YKf/2gpWFo
 OwXBu6k2VbiUIdrt8BrovNc+1txeHGrsUW0o8Z6FHYWpkNvtI2c4jqNkLIN1WIqdyIJu
 se1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690398979; x=1691003779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JM0ukKexePxMNw1wW/WLU+P2Zc71N+iGNBjfGQCeoCk=;
 b=k/TwIDClPChaUQorXIIdz4VH8aoGxzfEjm7vVTFnxwa6FVTwpHT8+4QpNwie83s6dq
 g7NXy8RHxI+WkRlpl/CQjHKqV4TficwFgOCLF9SyNPICNS4Fvn1QDUuZM3tHnOAghD4t
 tTfA1Wx6W7v0vya6OXnWJOAWCPKQg5WD0iuPpLXXN+KlZ04C7AcaGR4R/LHP9rjNg8Ll
 uDBYT7w1PV5Ho5LGbiDY+tgqjL47TYPa21CdyDs8TvdTTMdR3lWTbD5afqu4Galj6F76
 NO2lw8HXD/z02ireDYCpxjKJcQg6ghmzO8TeEx9OLtqXz63T70HE7YaXuIX1/H3gndE1
 VBcg==
X-Gm-Message-State: ABy/qLaOhmakpq3QBFMyKNo2rsRN8QtvUzXVC2nkNqutNLAfO5rEaW1f
 7GxbOLI48oqgk12JvlG5b12Hd91UFrGMCAe4ppJqqQ==
X-Google-Smtp-Source: APBJJlH038bb259dvNC1s2Kh0EZ2ksB/8UiE4ZmHMtZECcEAgle/dnoZe3klf/zzDDbN/4k4M1Lqx5jGP2l5HcooXg0=
X-Received: by 2002:a05:6102:84:b0:440:cbbf:cd72 with SMTP id
 t4-20020a056102008400b00440cbbfcd72mr69039vsp.4.1690398979395; Wed, 26 Jul
 2023 12:16:19 -0700 (PDT)
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
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 26 Jul 2023 15:16:08 -0400
Message-ID: <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/o5cRBOEjodUaQAGILKrEWDRTh30>
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMjozN+KAr1BNIFdhdHNvbiBMYWRkIDx3YXRzb25ibGFk
ZEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgOToxNeKAr0FN
IEFsZXhlaSBTdGFyb3ZvaXRvdgo+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90
ZToKPiA+Cj4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCA3OjAz4oCvQU0gRGF2ZSBUaGFsZXIg
PGR0aGFsZXJAbWljcm9zb2Z0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEkgYW0gZm9yd2FyZGlu
ZyB0aGUgZW1haWwgYmVsb3cgKGFmdGVyIGNvbnZlcnRpbmcgSFRNTCB0byBwbGFpbiB0ZXh0KQo+
ID4gPiB0byB0aGUgbWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcgbGlzdCBzbyByZXBsaWVzIGNh
biBnbyB0byBib3RoIGxpc3RzLgo+ID4gPgo+ID4gPiBQbGVhc2UgdXNlIHRoaXMgb25lIGZvciBh
bnkgcmVwbGllcy4KPiA+ID4KPiA+ID4gVGhhbmtzLAo+ID4gPiBEYXZlCj4gPiA+Cj4gPiA+ID4g
RnJvbTogQnBmIDxicGYtYm91bmNlc0BpZXRmLm9yZz4gT24gQmVoYWxmIE9mIFdhdHNvbiBMYWRk
Cj4gPiA+ID4gU2VudDogTW9uZGF5LCBKdWx5IDI0LCAyMDIzIDEwOjA1IFBNCj4gPiA+ID4gVG86
IGJwZkBpZXRmLm9yZwo+ID4gPiA+IFN1YmplY3Q6IFtCcGZdIFJldmlldyBvZiBkcmFmdC10aGFs
ZXItYnBmLWlzYS0wMQo+ID4gPiA+Cj4gPiA+ID4gRGVhciBCUEYgd2csCj4gPiA+ID4KPiA+ID4g
PiBJIHRvb2sgYSBsb29rIGF0IHRoZSBkcmFmdCBhbmQgdGhpbmsgaXQgaGFzIHNvbWUgaXNzdWVz
LCB1bnN1cnByaXNpbmdseSBhdCB0aGlzIHN0YWdlLiBPbmUgaXMKPiA+ID4gPiB0aGUgc3BlY2lm
aWNhdGlvbiBzZWVtcyB0byB1c2UgYW4gdW5kZXJzcGVjaWZpZWQgQyBwc2V1ZG8gY29kZSBmb3Ig
b3BlcmF0aW9ucyB2cwo+ID4gPiA+IGRlZmluaW5nIHRoZW0gbWF0aGVtYXRpY2FsbHkuCj4gPgo+
ID4gSGkgV2F0c29uLAo+ID4KPiA+IFRoaXMgaXMgbm90ICJ1bmRlcnNwZWNpZmllZCBDIiBwc2V1
ZG8gY29kZS4KPiA+IFRoaXMgaXMgYXNzZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQgZW1pdHRlZCBi
eSBHQ0MsIExMVk0sIGdhcywgTGludXggS2VybmVsLCBldGMuCj4KPiBJIGRvbid0IHNlZSBhIHJl
ZmVyZW5jZSB0byBhbnkgZGVzY3JpcHRpb24gb2YgdGhhdCBpbiBzZWN0aW9uIDQuMS4KPiBJdCdz
IHBvc3NpYmxlIEkndmUgb3Zlcmxvb2tlZCB0aGlzLCBhbmQgaWYgcGVvcGxlIHRoaW5rIHRoaXMg
c3R5bGUgb2YKPiBkZWZpbml0aW9uIGlzIGdvb2QgZW5vdWdoIHRoYXQgd29ya3MgZm9yIG1lLiBC
dXQgSSBmb3VuZCB0YWJsZSA0Cj4gcHJldHR5IHNjYW50eSBvbiB3aGF0IGV4YWN0bHkgaGFwcGVu
cy4KCkhlbGxvISBCYXNlZCBvbiBXYXRzb24ncyBwb3N0LCBJIGhhdmUgZG9uZSBzb21lIHJlc2Vh
cmNoIGFuZCB3b3VsZApwb3RlbnRpYWxseSBsaWtlIHRvIG9mZmVyIGEgcGF0aCBmb3J3YXJkLiBU
aGVyZSBhcmUgc2V2ZXJhbCBkaWZmZXJlbnQKd2F5cyB0aGF0IElTQXMgc3BlY2lmeSB0aGUgc2Vt
YW50aWNzIG9mIHRoZWlyIG9wZXJhdGlvbnM6CgoxLiBJbnRlbCBoYXMgYSBzZWN0aW9uIGluIHRo
ZWlyIG1hbnVhbCB0aGF0IGRlc2NyaWJlcyB0aGUgcHNldWRvY29kZQp0aGV5IHVzZSB0byBzcGVj
aWZ5IHRoZWlyIElTQTogU2VjdGlvbiAzLjEuMS45IG9mIFRoZSBJbnRlbMKuIDY0IGFuZApJQS0z
MiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlIERldmVsb3BlcuKAmXMgTWFudWFsIGF0Cmh0dHBzOi8v
Y2RyZHYyLmludGVsLmNvbS92MS9kbC9nZXRDb250ZW50LzY3MTE5OQoyLiBBUk0gaGFzIGFuIGVx
dWl2YWxlbnQgZm9yIHRoZWlyIHZhcmlldHkgb2YgcHNldWRvY29kZTogQ2hhcHRlciBKMQpvZiBB
cm0gQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwgZm9yIEEtcHJvZmlsZSBhcmNoaXRlY3R1
cmUgYXQKaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0aW9uL2RkaTA0ODcvbGF0
ZXN0LwozLiBTYWlsICJpcyBhIGxhbmd1YWdlIGZvciBkZXNjcmliaW5nIHRoZSBpbnN0cnVjdGlv
bi1zZXQgYXJjaGl0ZWN0dXJlCihJU0EpIHNlbWFudGljcyBvZiBwcm9jZXNzb3JzLiIKKGh0dHBz
Oi8vd3d3LmNsLmNhbS5hYy51ay9+cGVzMjAvc2FpbC8pCgpHaXZlbiB0aGUgY29tbWVyY2lhbCBu
YXR1cmUgb2YgKDEpIGFuZCAoMiksIHBlcmhhcHMgU2FpbCBpcyBhIHdheSB0bwpwcm9jZWVkLiBJ
ZiBwZW9wbGUgYXJlIGludGVyZXN0ZWQsIEkgd291bGQgYmUgaGFwcHkgdG8gbGVhZCBhbiBlZmZv
cnQKdG8gZW5jb2RlIHRoZSBlQlBGIElTQSBzZW1hbnRpY3MgaW4gU2FpbCAob3IgZmluZCBzb21l
b25lIHdobyBhbHJlYWR5CmhhcykgYW5kIGluY29ycG9yYXRlIHRoZW0gaW4gdGhlIGRyYWZ0LgoK
U2luY2VyZWx5LApXaWxsCgo+ID4KPiA+ID4gPiBUaGUgZ29vZCBuZXdzIGlzIEkgdGhpbmsgdGhp
cyBpcyB2ZXJ5IGZpeGFibGUgYWx0aG91Z2ggdGVkaW91cy4KPiA+ID4gPgo+ID4gPiA+IFRoZSBv
dGhlciB0aG9ybmllciBpc3N1ZXMgYXJlIG1lbW9yeSBtb2RlbCBldGMuIEJ1dCB0aGUgb3ZlcmFs
bCBzdHJ1Y3R1cmUgc2VlbXMgZ29vZAo+ID4gPiA+IGFuZCB0aGUgZG9jdW1lbnQgb3ZlcmFsbCBt
YWtlcyBzZW5zZS4KPiA+Cj4gPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJtZW1vcnkgbW9kZWwiID8K
PiA+IERvIHlvdSBzZWUgYSByZWZlcmVuY2UgdG8gaXQgPyBQbGVhc2UgYmUgc3BlY2lmaWMuCj4K
PiBObywgYW5kIHRoYXQncyB0aGUgcHJvYmxlbS4gU2VjdGlvbiA1LjIgdGFsa3MgYWJvdXQgYXRv
bWljIG9wZXJhdGlvbnMuCj4gSSdkIGV4cGVjdCB0aGF0IHRvIGJlIHBhaXJlZCB3aXRoIGEgZGVz
Y3JpcHRpb24gb2YgYmFycmllcnMgc28gdGhhdAo+IHRoZXNlIHdvcmssIG9yIGEgYmlnIHdhcm5p
bmcgYWJvdXQgd2hlbiB5b3UgbmVlZCB0byB1c2UgdGhlbS4gRm9yCj4gY2xhcml0eSBJJ20gcHJl
dHR5IHVuZmFtaWxpYXIgd2l0aCBicGYgYXMgYSB0ZWNobm9sb2d5LCBhbmQgaXQncwo+IHBvc3Np
YmxlIHRoYXQgd2l0aCBtb3JlIGtub3dsZWRnZSB0aGlzIHdvdWxkIG1ha2Ugc2Vuc2UuIE9uIGxv
b2tpbmcKPiBiYWNrIG9uIHRoYXQgSSBkb24ndCBldmVuIGtub3cgaWYgdGhlIG1lbW9yeSBzcGFj
ZSBpcyBmbGF0LCBvcgo+IHNlZ21lbnRlZDogY2FuIEkgYWNjZXNzIG1hcHMgdGhyb3VnaCBhIHZh
bHVlIHNldCB0byBkc3Qrb2Zmc2V0LCBvcgo+IG11c3QgSSBhbHdheXMgdXNlZCBpbmRleD8gSSdt
IGp1c3QgdmVyeSBjb25mdXNlZC4KPgo+IFNpbmNlcmVseSwKPiBXYXRzb24KPgo+IC0tCj4gQXN0
cmEgbW9ydGVtcXVlIHByYWVzdGFyZSBncmFkYXRpbQo+Cj4gLS0KPiBCcGYgbWFpbGluZyBsaXN0
Cj4gQnBmQGlldGYub3JnCj4gaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9i
cGYKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

