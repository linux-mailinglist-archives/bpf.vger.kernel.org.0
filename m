Return-Path: <bpf+bounces-6303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77342767A78
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 03:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A18E1C2191F
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B76EA41;
	Sat, 29 Jul 2023 01:08:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB57C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 01:08:07 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FF335A5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 18:08:06 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 454C9C151538
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 18:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690592886; bh=sC44n7rXaVHUfBN5u4dA3mpPuSfvtGA/JZQohbSjoJ4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XHrjChwN9kBxPYKmAxQYah62OcrquAR2nXesMzQAG4Ngw49bOwWOCBooALVFuxk6W
	 2EPCktjQPQE700VgMRoiqltmymnEU+xi4Kfj3SJFRvdHlMkC6RY0E4E8H1TRhvLBgu
	 B3lGtzqy1lPnrH/IlxABMkT6hK2KHibsgMrn8frc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 18:08:06 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 20432C14CE40;
	Fri, 28 Jul 2023 18:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690592886; bh=sC44n7rXaVHUfBN5u4dA3mpPuSfvtGA/JZQohbSjoJ4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XHrjChwN9kBxPYKmAxQYah62OcrquAR2nXesMzQAG4Ngw49bOwWOCBooALVFuxk6W
	 2EPCktjQPQE700VgMRoiqltmymnEU+xi4Kfj3SJFRvdHlMkC6RY0E4E8H1TRhvLBgu
	 B3lGtzqy1lPnrH/IlxABMkT6hK2KHibsgMrn8frc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 63C85C14CE40
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 18:08:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.904
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
 with ESMTP id Xv-W8oE3v6sw for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 18:08:00 -0700 (PDT)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 52C61C14CF1B
 for <bpf@ietf.org>; Fri, 28 Jul 2023 18:08:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7672303c831so216142885a.2
 for <bpf@ietf.org>; Fri, 28 Jul 2023 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690592879; x=1691197679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLJ80DF+5jN7vyuJ41+PNgOv/ijdA7DAi2QLpD5CcgQ=;
 b=BSCip9A/qBxMvH8qCng/C2WpZhu0tPayV3Ck82DRbmtYR7ckj9XTw6m3EBsaQ6ZjAW
 eb1hW50dAlGh4zwCSoqqBJT1ccYRuYUAVTMY96Hbg6i9NWHClR9FMlO+OC5FcXP4BziQ
 NsYcnWctecTG574Ef7HR+/jWLzZ5jvALlJqlBHNZPpVRYhgoLLx6P4pj+QfIXn1UjOE2
 YYGbPA5yMS0lVrm6m85f1eBmOnXDAaexPVzlLJRGi0BczhOqD2fHyexWwVfzq/Ve0HbY
 KP5o+HxnFAX5LXRW07eyhezmvjG2B9rclTT8HeZ1HA/3p2AoDdGSlLfaQO43kEKEZ52J
 fi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690592879; x=1691197679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLJ80DF+5jN7vyuJ41+PNgOv/ijdA7DAi2QLpD5CcgQ=;
 b=bwmc+h1vK62Dvzy4Fi/9UEE+iHoTkZwf+YBDJb40JAxwYsP/gmJa78/Wth4uVJVgiW
 0CqgrrS0B7Ppsz6xBaaTCkPQCY399PpLDpPDQTHtfEh02w6h85qxo56dSuFkHVSps75a
 wGyTvJw+BgB+7xyYXVuVRNkTlC2Sb7YWmNhMDV3S/sdpYX8ndQ2c6CVMz8eA8gwwm8xO
 ibjBzP9+wolR9iAcSw1GEQwKZwB3sPL4w74JKZT1Hn/yBAFSlGUmULYxnl1bH8txTbky
 eZ/rhP9q9iNTc0OBUk7zZLglTJVETpjnCj1SoYMPQn4rpSq8F9Rr7YQrqqYPYTV8uUmF
 BayA==
X-Gm-Message-State: ABy/qLbu/9nbuWySqQ7e/CWJ+VEzuZzM3irQaB0MzYvxgSN6m1L7PUGP
 NbDiU21XogfKGfr4FjyAel4N9aa/IEmPgZYONv94FMICOv4nFHTc82E=
X-Google-Smtp-Source: APBJJlFB1Gw9S2W67wARAM9xDb6dhkFdfA6aZDreh0TIBeBwvI+SUoNo6LQKIeAMEl7f8WHqfJJiRoHDiPjVVgQGyBY=
X-Received: by 2002:a05:620a:d82:b0:75b:23a0:d9dc with SMTP id
 q2-20020a05620a0d8200b0075b23a0d9dcmr4249743qkl.50.1690592879338; Fri, 28 Jul
 2023 18:07:59 -0700 (PDT)
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
In-Reply-To: <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 21:07:48 -0400
Message-ID: <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/FFGitLnUSXPHLawX8n_5R3oc2bE>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgODo1MuKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIEp1bCAyOCwgMjAy
MyBhdCA1OjQ24oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+IHdyb3RlOgo+ID4K
PiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MzXigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YK
PiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24g
RnJpLCBKdWwgMjgsIDIwMjMgYXQgNToxOeKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2Jz
LmNyPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MDXi
gK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWls
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQg
NDozMuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgOTowNeKAr1BNIEFsZXhlaSBT
dGFyb3ZvaXRvdgo+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAx
MjoxNuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAyOjM34oCvUE0g
V2F0c29uIExhZGQgPHdhdHNvbmJsYWRkQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDk6MTXigK9BTSBB
bGV4ZWkgU3Rhcm92b2l0b3YKPiA+ID4gPiA+ID4gPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBn
bWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNzowM+KAr0FNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1p
Y3Jvc29mdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IEkgYW0gZm9yd2FyZGluZyB0aGUgZW1haWwgYmVsb3cgKGFmdGVyIGNvbnZlcnRpbmcg
SFRNTCB0byBwbGFpbiB0ZXh0KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdG8gdGhlIG1haWx0bzpi
cGZAdmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4gZ28gdG8gYm90aCBsaXN0cy4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBQbGVhc2UgdXNlIHRo
aXMgb25lIGZvciBhbnkgcmVwbGllcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBEYXZlCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBCcGYgPGJwZi1ib3VuY2Vz
QGlldGYub3JnPiBPbiBCZWhhbGYgT2YgV2F0c29uIExhZGQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gU2VudDogTW9uZGF5LCBKdWx5IDI0LCAyMDIzIDEwOjA1IFBNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IFRvOiBicGZAaWV0Zi5vcmcKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU3ViamVjdDog
W0JwZl0gUmV2aWV3IG9mIGRyYWZ0LXRoYWxlci1icGYtaXNhLTAxCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IERlYXIgQlBGIHdnLAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIHRvb2sgYSBsb29rIGF0IHRoZSBk
cmFmdCBhbmQgdGhpbmsgaXQgaGFzIHNvbWUgaXNzdWVzLCB1bnN1cnByaXNpbmdseSBhdCB0aGlz
IHN0YWdlLiBPbmUgaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlIHNwZWNpZmljYXRpb24g
c2VlbXMgdG8gdXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNvZGUgZm9yIG9wZXJhdGlv
bnMgdnMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZGVmaW5pbmcgdGhlbSBtYXRoZW1hdGljYWxs
eS4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEhpIFdhdHNvbiwKPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgbm90ICJ1bmRlcnNw
ZWNpZmllZCBDIiBwc2V1ZG8gY29kZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGFzc2Vt
Ymx5IHN5bnRheCBwYXJzZWQgYW5kIGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtl
cm5lbCwgZXRjLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBJIGRvbid0IHNl
ZSBhIHJlZmVyZW5jZSB0byBhbnkgZGVzY3JpcHRpb24gb2YgdGhhdCBpbiBzZWN0aW9uIDQuMS4K
PiA+ID4gPiA+ID4gPiA+ID4gSXQncyBwb3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQgdGhpcywgYW5k
IGlmIHBlb3BsZSB0aGluayB0aGlzIHN0eWxlIG9mCj4gPiA+ID4gPiA+ID4gPiA+IGRlZmluaXRp
b24gaXMgZ29vZCBlbm91Z2ggdGhhdCB3b3JrcyBmb3IgbWUuIEJ1dCBJIGZvdW5kIHRhYmxlIDQK
PiA+ID4gPiA+ID4gPiA+ID4gcHJldHR5IHNjYW50eSBvbiB3aGF0IGV4YWN0bHkgaGFwcGVucy4K
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBIZWxsbyEgQmFzZWQgb24gV2F0c29uJ3Mg
cG9zdCwgSSBoYXZlIGRvbmUgc29tZSByZXNlYXJjaCBhbmQgd291bGQKPiA+ID4gPiA+ID4gPiA+
IHBvdGVudGlhbGx5IGxpa2UgdG8gb2ZmZXIgYSBwYXRoIGZvcndhcmQuIFRoZXJlIGFyZSBzZXZl
cmFsIGRpZmZlcmVudAo+ID4gPiA+ID4gPiA+ID4gd2F5cyB0aGF0IElTQXMgc3BlY2lmeSB0aGUg
c2VtYW50aWNzIG9mIHRoZWlyIG9wZXJhdGlvbnM6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gMS4gSW50ZWwgaGFzIGEgc2VjdGlvbiBpbiB0aGVpciBtYW51YWwgdGhhdCBkZXNjcmli
ZXMgdGhlIHBzZXVkb2NvZGUKPiA+ID4gPiA+ID4gPiA+IHRoZXkgdXNlIHRvIHNwZWNpZnkgdGhl
aXIgSVNBOiBTZWN0aW9uIDMuMS4xLjkgb2YgVGhlIEludGVswq4gNjQgYW5kCj4gPiA+ID4gPiA+
ID4gPiBJQS0zMiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlIERldmVsb3BlcuKAmXMgTWFudWFsIGF0
Cj4gPiA+ID4gPiA+ID4gPiBodHRwczovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwvZ2V0Q29udGVu
dC82NzExOTkKPiA+ID4gPiA+ID4gPiA+IDIuIEFSTSBoYXMgYW4gZXF1aXZhbGVudCBmb3IgdGhl
aXIgdmFyaWV0eSBvZiBwc2V1ZG9jb2RlOiBDaGFwdGVyIEoxCj4gPiA+ID4gPiA+ID4gPiBvZiBB
cm0gQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwgZm9yIEEtcHJvZmlsZSBhcmNoaXRlY3R1
cmUgYXQKPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRh
dGlvbi9kZGkwNDg3L2xhdGVzdC8KPiA+ID4gPiA+ID4gPiA+IDMuIFNhaWwgImlzIGEgbGFuZ3Vh
Z2UgZm9yIGRlc2NyaWJpbmcgdGhlIGluc3RydWN0aW9uLXNldCBhcmNoaXRlY3R1cmUKPiA+ID4g
PiA+ID4gPiA+IChJU0EpIHNlbWFudGljcyBvZiBwcm9jZXNzb3JzLiIKPiA+ID4gPiA+ID4gPiA+
IChodHRwczovL3d3dy5jbC5jYW0uYWMudWsvfnBlczIwL3NhaWwvKQo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+IEdpdmVuIHRoZSBjb21tZXJjaWFsIG5hdHVyZSBvZiAoMSkgYW5kICgy
KSwgcGVyaGFwcyBTYWlsIGlzIGEgd2F5IHRvCj4gPiA+ID4gPiA+ID4gPiBwcm9jZWVkLiBJZiBw
ZW9wbGUgYXJlIGludGVyZXN0ZWQsIEkgd291bGQgYmUgaGFwcHkgdG8gbGVhZCBhbiBlZmZvcnQK
PiA+ID4gPiA+ID4gPiA+IHRvIGVuY29kZSB0aGUgZUJQRiBJU0Egc2VtYW50aWNzIGluIFNhaWwg
KG9yIGZpbmQgc29tZW9uZSB3aG8gYWxyZWFkeQo+ID4gPiA+ID4gPiA+ID4gaGFzKSBhbmQgaW5j
b3Jwb3JhdGUgdGhlbSBpbiB0aGUgZHJhZnQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBp
bW8gU2FpbCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUgcHJhY3RpY2FsIHVzZS4KPiA+ID4gPiA+
ID4gPiBMb29raW5nIGF0IGFybTY0IG9yIHg4NiBTYWlsIGRlc2NyaXB0aW9uIEkgcmVhbGx5IGRv
bid0IHNlZSBob3cKPiA+ID4gPiA+ID4gPiBpdCB3b3VsZCBtYXAgdG8gYW4gSUVURiBzdGFuZGFy
ZC4KPiA+ID4gPiA+ID4gPiBJdCdzIGRvbmUgaW4gYSAic2FpbCIgbGFuZ3VhZ2UgdGhhdCBwZW9w
bGUgbmVlZCB0byBsZWFybiBmaXJzdCB0byBiZQo+ID4gPiA+ID4gPiA+IGFibGUgdG8gcmVhZCBp
dC4KPiA+ID4gPiA+ID4gPiBTYXkgd2UgaGFkIGJwZi5zYWlsIHNvbWV3aGVyZSBvbiBnaXRodWIu
IFdoYXQgdmFsdWUgZG9lcyBpdCBicmluZyB0bwo+ID4gPiA+ID4gPiA+IEJQRiBJU0Egc3RhbmRh
cmQ/IEkgZG9uJ3Qgc2VlIGFuIGltbWVkaWF0ZSBiZW5lZml0IHRvIHN0YW5kYXJkaXphdGlvbi4K
PiA+ID4gPiA+ID4gPiBUaGVyZSBjb3VsZCBiZSBvdGhlciB1c2UgY2FzZXMsIG5vIGRvdWJ0LCBi
dXQgc3RhbmRhcmRpemF0aW9uIGlzIG91ciBnb2FsLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gQXMgZmFyIGFzIDEgYW5kIDIuIEludGVsIGFuZCBBcm0gdXNlIHRoZWlyIG93biBwc2V1ZG9j
b2RlLCBzbyB0aGV5IGhhZAo+ID4gPiA+ID4gPiA+IHRvIGFkZCBhIHBhcmFncmFwaCB0byBkZXNj
cmliZSBpdC4gV2UgYXJlIHVzaW5nIEMgdG8gZGVzY3JpYmUgQlBGIElTQQo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIGNhbm5vdCBmaW5kIGEgcmVmZXJlbmNlIGluIHRoZSBj
dXJyZW50IHZlcnNpb24gdGhhdCBzcGVjaWZpZXMgd2hhdAo+ID4gPiA+ID4gPiB3ZSBhcmUgdXNp
bmcgdG8gZGVzY3JpYmUgdGhlIG9wZXJhdGlvbnMuIEknZCBsaWtlIHRvIGFkZCB0aGF0LCBidXQK
PiA+ID4gPiA+ID4gd2FudCB0byBtYWtlIHN1cmUgdGhhdCBJIGNsYXJpZnkgdHdvIHN0YXRlbWVu
dHMgdGhhdCBzZWVtIHRvIGJlIGF0Cj4gPiA+ID4gPiA+IG9kZHMuCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IEltbWVkaWF0ZWx5IGFib3ZlIHlvdSBzYXkgdGhhdCB3ZSBhcmUgdXNpbmcgIkMgdG8g
ZGVzY3JpYmUgdGhlIEJQRgo+ID4gPiA+ID4gPiBJU0EiIGFuZCBmdXJ0aGVyIGFib3ZlIHlvdSBz
YXkgIlRoaXMgaXMgYXNzZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQKPiA+ID4gPiA+ID4gZW1pdHRl
ZCBieSBHQ0MsIExMVk0sIGdhcywgTGludXggS2VybmVsLCBldGMuIgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBNeSBvd24gcmVhZGluZyBpcyB0aGF0IGl0IGlzIHRoZSBmb3JtZXIsIGFuZCBub3Qg
dGhlIGxhdHRlci4gQnV0LCBJCj4gPiA+ID4gPiA+IHdhbnQgdG8gZG91YmxlIGNoZWNrIGJlZm9y
ZSBhZGRpbmcgdGhlIGFwcHJvcHJpYXRlIHN0YXRlbWVudHMgdG8gdGhlCj4gPiA+ID4gPiA+IENv
bnZlbnRpb24gc2VjdGlvbi4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJdCdzIGJvdGguIEknbSBub3Qg
c3VyZSB3aGVyZSB5b3Ugc2VlIGEgY29udHJhZGljdGlvbi4KPiA+ID4gPiA+IEl0J3MgYSBub3Jt
YWwgQyBzeW50YXggYW5kIGl0J3MgZW1pdHRlZCBieSB0aGUga2VybmVsIHZlcmlmaWVyLAo+ID4g
PiA+ID4gcGFyc2VkIGJ5IGNsYW5nL2djYyBhc3NlbWJsZXJzIGFuZCBlbWl0dGVkIGJ5IGNvbXBp
bGVycy4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gT2theS4gSSBhcG9sb2dpemUuIEkgYW0gc2lu
Y2VyZWx5IGNvbmZ1c2VkLiBGb3IgaW5zdGFuY2UsCj4gPiA+ID4KPiA+ID4gPiBpZiAodTMyKWRz
dCA+PSAodTMyKXNyYyBnb3RvICtvZmZzZXQKPiA+ID4gPgo+ID4gPiA+IExvb2tzIGxpa2Ugbm90
aGluZyB0aGF0IEkgaGF2ZSBldmVyIHNlZW4gaW4gIm5vcm1hbCBDIHN5bnRheCIuCj4gPiA+Cj4g
PiA+IEkgdGhvdWdodCB3ZSdyZSB0YWxraW5nIGFib3V0IHRhYmxlIDQgYW5kIEFMVSBvcHMuCj4g
PiA+IEFib3ZlIGlzIG5vdCBhIHB1cmUgQywgYnV0IGl0J3Mgb2J2aW91cyBlbm91Z2ggd2l0aG91
dCBleHBsYW5hdGlvbiwgbm8/Cj4gPgo+ID4gVG8gInVzIiwgeWVzLiBBbHRob3VnaCBJIGFtIG5v
dCBhbiBleHBlcnQsIGl0IHNlZW1zIGxpa2UgYmVpbmcKPiA+IGV4cGxpY2l0IGlzIGltcG9ydGFu
dCB3aGVuIGl0IGNvbWVzIHRvIHdyaXRpbmcgYSBzcGVjLiBJIHN1cHBvc2Ugd2UKPiA+IHNob3Vs
ZCBsZWF2ZSB0aGF0IHRvIERhdmUgYW5kIHRoZSBjaGFpcnMuCj4gPgo+ID4gPiBBbHNvIEkgZG9u
J3Qgc2VlIGFib3ZlIGFueXdoZXJlIGluIHRoZSBkb2MuCj4gPgo+ID4gVGhhdCBpcyBmcm9tIHRo
ZSBBcHBlbmRpeC4gSXQgaXMgY3VycmVudGx5IGluIERhdmUncyB0cmVlIGFuZCBnZXRzCj4gPiBh
bWFsZ2FtYXRlZCB3aXRoIG90aGVyIGZpbGVzIHRvIGJ1aWxkIHRoZSBmaW5hbCBkcmFmdC4KPiA+
Cj4gPiBodHRwczovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9kcmFmdC10aGFsZXItYnBmLWlz
YS8KPgo+IFRoaXMgaXMgYSBtaXJyb3IgYW5kIGl0J3MgYWxyZWFkeSBvdXRkYXRlZC4KPiBZb3Ug
c2hvdWxkIGxvb2sgYXQgdGhlIHNvdXJjZS4gV2hpY2ggaXMgZ2l0IGtlcm5lbCB0cmVlLgoKQXMg
aGUgZGlzY3Vzc2VkIGF0IHRoZSBtZWV0aW5nLCBoZSBoYXMgdGhlIGdpdGh1YiB3b3JrZmxvdyB0
aGF0CnByb2R1Y2VzIGEgdmVyc2lvbiBvZiB0aGUgZHJhZnQgUkZDIHRoYXQgaGUgd2lsbCBzdWJt
aXQgdG8gdGhlIFdHOgoKaHR0cHM6Ly9naXRodWIuY29tL2lldGYtd2ctYnBmL2VicGYtZG9jcy9i
bG9iL3VwZGF0ZS8uZ2l0aHViL3dvcmtmbG93cy9idWlsZC55bWwKClRoYXQgdXNlcwoKaHR0cHM6
Ly9naXRodWIuY29tL2lldGYtd2ctYnBmL2VicGYtZG9jcy9ibG9iL21haW4vcnN0L2luc3RydWN0
aW9uLXNldC1za2VsZXRvbi5yc3QKCnRvIGJ1aWxkIGluIHRoZSBhY2tub3dsZWRnZW1lbnRzIGFu
ZCBzdWJzZXF1ZW50bHkgYnJpbmdzIGluIHRoYXQKQXBwZW5kaXguIElmIGhlIHBsYW5zIHRvIHRh
a2UgdGhhdCBvdXQsIHRoZW4gdGhhdCdzIGdyZWF0LiBJIHdhcyBqdXN0CnRyeWluZyB0byBoZWxw
LiBTb3JyeS4KCldpbGwKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczov
L3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

