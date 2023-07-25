Return-Path: <bpf+bounces-5856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006F762188
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA84280F43
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338D263A2;
	Tue, 25 Jul 2023 18:37:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603421D52
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 18:37:07 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDE212F
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 11:37:05 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8FE8CC1519BF
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690310225; bh=7Hof+dEDEInvPBrzmb/7NmM2ue05AKCGe9B40F27zMY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=WX8BG4J9MEYGBdIIZjJQcqdcAoogy0hDS4KBapM61veQIYomVzSTHQPI1FS5k39/m
	 9Qo+5IRn8Ie1W0Xd4q9XA2t0EQqBZafuvttrondbe1VAiMpVRIBzIKdDtrnSXZl+Aq
	 ST3sYy35uQOtjalYXpeLX9+aAd8jWj6pd+mFQJIM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jul 25 11:37:05 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 65558C151087;
	Tue, 25 Jul 2023 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690310225; bh=7Hof+dEDEInvPBrzmb/7NmM2ue05AKCGe9B40F27zMY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=WX8BG4J9MEYGBdIIZjJQcqdcAoogy0hDS4KBapM61veQIYomVzSTHQPI1FS5k39/m
	 9Qo+5IRn8Ie1W0Xd4q9XA2t0EQqBZafuvttrondbe1VAiMpVRIBzIKdDtrnSXZl+Aq
	 ST3sYy35uQOtjalYXpeLX9+aAd8jWj6pd+mFQJIM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A3B77C14CE5F
 for <bpf@ietfa.amsl.com>; Tue, 25 Jul 2023 11:37:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.098
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
 with ESMTP id 7XNFJ_fb_2Kn for <bpf@ietfa.amsl.com>;
 Tue, 25 Jul 2023 11:37:00 -0700 (PDT)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 309F5C15109A
 for <bpf@ietf.org>; Tue, 25 Jul 2023 11:37:00 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-565a8d9d832so3692229eaf.1
 for <bpf@ietf.org>; Tue, 25 Jul 2023 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690310219; x=1690915019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeelAk+UG0Z+0Z6zA+f8GznerG9M7rwYV5RDidhYjkk=;
 b=g5zeOHCl+JxQX2YiRSpINPt1lO8AEXC19Y8vuLftI87MpjEB+0izBEJhKmb//srMUI
 KYGCwVwSQddkNF1oUj7TMQM6aIKPiyDpDdnTOatvtGadNgSklJVrUSsCxY7zQsZDZDLH
 wfiiUD4K7ux/rWO+nRnILwopOXccsoZsZv2OoP+P8X68qF/wFesw4wRPGsDXAaYcRDGJ
 bMIu+7AvFOt603+XGzZSBE1co/MA4iSt/HOu0CYbrVT+m4khMwPLTtyBZcYlIfPZ5Iu+
 b7ej1FjLpEw6lf3P8qfdbuGVj7Yqo7q03PKJ+C2WSZMbvPN98JoNpgsWxR8RWXymY5Et
 z09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690310219; x=1690915019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeelAk+UG0Z+0Z6zA+f8GznerG9M7rwYV5RDidhYjkk=;
 b=DnL5OeBOtWUhjwTKYCImB9lfmTeWRX4y/Ag9kKMlIFbGDzk7ZuXQ/8uUZ+FvHVYe/j
 zqgABWviFrfRXr3ZkOp+ul+p/e19EQylgaNT7zKyYd7y0m96kqI8U1l/mq6qVhlSWVoQ
 8rZV6bxoHeJ80W0bM1Cl2McPDEqpEYGQOTr54xIYXLXyVyr9O+EGoLpsJicJOcqbCFAQ
 RJitttIJAGkb3dfRQy9vvU3O40NpZ1uauZ+97Ekgg4Jf4kCHSvAVXQvV1Y8qJpB9v9Zl
 V63ozD+Cce7kVqJeny+OZE1RS2moDlQtPYmLXy4ocfnQaxjS7PZcMDYcKc6xRbrKGIkM
 CteA==
X-Gm-Message-State: ABy/qLY3ds10HxOs5aXI4YrB99aZbHI2IcU0JADmfxTNhkZBQpMqkAJP
 RMuSAFoM2aC6UT5qUKfByjF00fGrJa2y1sSvBy8=
X-Google-Smtp-Source: APBJJlG2KOMCEuu7ue8fjkBhAf5I25AceKARm8COrbZIfzcrYLb8Drhk/6vemvi6s/oQSNb50nCPeJgP+HU/gB8e2yI=
X-Received: by 2002:a4a:dfbc:0:b0:566:f951:d12 with SMTP id
 k28-20020a4adfbc000000b00566f9510d12mr158049ook.1.1690310219400; Tue, 25 Jul
 2023 11:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
In-Reply-To: <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Tue, 25 Jul 2023 11:36:48 -0700
Message-ID: <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/iW-VpcP7VZp9i7RRLCTEZYoWL3M>
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgOToxNeKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1bCAyNSwgMjAy
MyBhdCA3OjAz4oCvQU0gRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWljcm9zb2Z0LmNvbT4gd3JvdGU6
Cj4gPgo+ID4gSSBhbSBmb3J3YXJkaW5nIHRoZSBlbWFpbCBiZWxvdyAoYWZ0ZXIgY29udmVydGlu
ZyBIVE1MIHRvIHBsYWluIHRleHQpCj4gPiB0byB0aGUgbWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5v
cmcgbGlzdCBzbyByZXBsaWVzIGNhbiBnbyB0byBib3RoIGxpc3RzLgo+ID4KPiA+IFBsZWFzZSB1
c2UgdGhpcyBvbmUgZm9yIGFueSByZXBsaWVzLgo+ID4KPiA+IFRoYW5rcywKPiA+IERhdmUKPiA+
Cj4gPiA+IEZyb206IEJwZiA8YnBmLWJvdW5jZXNAaWV0Zi5vcmc+IE9uIEJlaGFsZiBPZiBXYXRz
b24gTGFkZAo+ID4gPiBTZW50OiBNb25kYXksIEp1bHkgMjQsIDIwMjMgMTA6MDUgUE0KPiA+ID4g
VG86IGJwZkBpZXRmLm9yZwo+ID4gPiBTdWJqZWN0OiBbQnBmXSBSZXZpZXcgb2YgZHJhZnQtdGhh
bGVyLWJwZi1pc2EtMDEKPiA+ID4KPiA+ID4gRGVhciBCUEYgd2csCj4gPiA+Cj4gPiA+IEkgdG9v
ayBhIGxvb2sgYXQgdGhlIGRyYWZ0IGFuZCB0aGluayBpdCBoYXMgc29tZSBpc3N1ZXMsIHVuc3Vy
cHJpc2luZ2x5IGF0IHRoaXMgc3RhZ2UuIE9uZSBpcwo+ID4gPiB0aGUgc3BlY2lmaWNhdGlvbiBz
ZWVtcyB0byB1c2UgYW4gdW5kZXJzcGVjaWZpZWQgQyBwc2V1ZG8gY29kZSBmb3Igb3BlcmF0aW9u
cyB2cwo+ID4gPiBkZWZpbmluZyB0aGVtIG1hdGhlbWF0aWNhbGx5Lgo+Cj4gSGkgV2F0c29uLAo+
Cj4gVGhpcyBpcyBub3QgInVuZGVyc3BlY2lmaWVkIEMiIHBzZXVkbyBjb2RlLgo+IFRoaXMgaXMg
YXNzZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQgZW1pdHRlZCBieSBHQ0MsIExMVk0sIGdhcywgTGlu
dXggS2VybmVsLCBldGMuCgpJIGRvbid0IHNlZSBhIHJlZmVyZW5jZSB0byBhbnkgZGVzY3JpcHRp
b24gb2YgdGhhdCBpbiBzZWN0aW9uIDQuMS4KSXQncyBwb3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQg
dGhpcywgYW5kIGlmIHBlb3BsZSB0aGluayB0aGlzIHN0eWxlIG9mCmRlZmluaXRpb24gaXMgZ29v
ZCBlbm91Z2ggdGhhdCB3b3JrcyBmb3IgbWUuIEJ1dCBJIGZvdW5kIHRhYmxlIDQKcHJldHR5IHNj
YW50eSBvbiB3aGF0IGV4YWN0bHkgaGFwcGVucy4KPgo+ID4gPiBUaGUgZ29vZCBuZXdzIGlzIEkg
dGhpbmsgdGhpcyBpcyB2ZXJ5IGZpeGFibGUgYWx0aG91Z2ggdGVkaW91cy4KPiA+ID4KPiA+ID4g
VGhlIG90aGVyIHRob3JuaWVyIGlzc3VlcyBhcmUgbWVtb3J5IG1vZGVsIGV0Yy4gQnV0IHRoZSBv
dmVyYWxsIHN0cnVjdHVyZSBzZWVtcyBnb29kCj4gPiA+IGFuZCB0aGUgZG9jdW1lbnQgb3ZlcmFs
bCBtYWtlcyBzZW5zZS4KPgo+IFdoYXQgZG8geW91IG1lYW4gYnkgIm1lbW9yeSBtb2RlbCIgPwo+
IERvIHlvdSBzZWUgYSByZWZlcmVuY2UgdG8gaXQgPyBQbGVhc2UgYmUgc3BlY2lmaWMuCgpObywg
YW5kIHRoYXQncyB0aGUgcHJvYmxlbS4gU2VjdGlvbiA1LjIgdGFsa3MgYWJvdXQgYXRvbWljIG9w
ZXJhdGlvbnMuCkknZCBleHBlY3QgdGhhdCB0byBiZSBwYWlyZWQgd2l0aCBhIGRlc2NyaXB0aW9u
IG9mIGJhcnJpZXJzIHNvIHRoYXQKdGhlc2Ugd29yaywgb3IgYSBiaWcgd2FybmluZyBhYm91dCB3
aGVuIHlvdSBuZWVkIHRvIHVzZSB0aGVtLiBGb3IKY2xhcml0eSBJJ20gcHJldHR5IHVuZmFtaWxp
YXIgd2l0aCBicGYgYXMgYSB0ZWNobm9sb2d5LCBhbmQgaXQncwpwb3NzaWJsZSB0aGF0IHdpdGgg
bW9yZSBrbm93bGVkZ2UgdGhpcyB3b3VsZCBtYWtlIHNlbnNlLiBPbiBsb29raW5nCmJhY2sgb24g
dGhhdCBJIGRvbid0IGV2ZW4ga25vdyBpZiB0aGUgbWVtb3J5IHNwYWNlIGlzIGZsYXQsIG9yCnNl
Z21lbnRlZDogY2FuIEkgYWNjZXNzIG1hcHMgdGhyb3VnaCBhIHZhbHVlIHNldCB0byBkc3Qrb2Zm
c2V0LCBvcgptdXN0IEkgYWx3YXlzIHVzZWQgaW5kZXg/IEknbSBqdXN0IHZlcnkgY29uZnVzZWQu
CgpTaW5jZXJlbHksCldhdHNvbgoKLS0gCkFzdHJhIG1vcnRlbXF1ZSBwcmFlc3RhcmUgZ3JhZGF0
aW0KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

