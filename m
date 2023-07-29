Return-Path: <bpf+bounces-6293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9F767967
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534D628280B
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA6382;
	Sat, 29 Jul 2023 00:19:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB34361
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:19:17 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8267E3C22
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:19:14 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 079C6C151527
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690589954; bh=mgdZYNmOSsTFLT0gwwmNhzZLQL07iunIua8walBZk7A=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=uhicRuqrW75P1/Ya1jUOaYEOCO74bK7ENm90VDUyfE5D2Sd6YSru89YKX671+xZV1
	 tKjA850/nX0lLTnWVtE6mWtQZB/yMwPOxXF6bPd83DZQADa4DvglwtkDj24h3hA1kj
	 o+8yzxBcg/9HBJP3NJWc9Yb8LcUF0ldkf0UnEwKI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 17:19:13 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CBDC2C14CF1A;
	Fri, 28 Jul 2023 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690589953; bh=mgdZYNmOSsTFLT0gwwmNhzZLQL07iunIua8walBZk7A=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=S7dm1UFzEjPxjJmX0BgtUCLh6x8Z0lCk/H/upmgTL43L1I+bHBXu9ib6BV4xfdE8q
	 TizOt67/E8ch/RiSVu4Vr9rGKNILnKqPjtZBy9oK1JalA/qlIPk5NoVLhhIlyhLNjD
	 gyVuMUi0dX7SuNXSZ65ZPN798oS/ySDMfOZqNCm0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D7C1FC14CF13
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 17:19:11 -0700 (PDT)
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
 with ESMTP id NDqCHgZm8DMa for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 17:19:07 -0700 (PDT)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 925CCC14CE2E
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:19:07 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-63cf7cce5fbso16637336d6.0
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690589946; x=1691194746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfLv10TFdsrSxqktK+LRaWW5VA/F7ry7098BNaSJwV0=;
 b=MWxFF+s7RWFcm7siS+3A0Tow/rA6WEYvZjlyJDCq/DZsAJ9uGX07G5RkITjsyUUuve
 ocqq9nFgnYi4Hn5AiFWGShoOB3n+0WJmBceGK9U+lDYormH7ofIgeKHDOeq1nCXc3asq
 2EhQCnullSqq3q975LRYJjmFvbVTBCwm54UgFZDLyAZhVwOzSQor4A2ciURR45p69Whg
 mU1qsaAa49I4jgjEgLEw0I0mFW8jgeCXxozhoGh334pLLVoIqIsb3HskmPaKBvcNeMxy
 g5n4abXmElDj9PprfFEGK+T+ujo0vz3IffRbigS7+Fi/kmSrp1ZTEdW+bme+8HcMnJu+
 yJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690589946; x=1691194746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfLv10TFdsrSxqktK+LRaWW5VA/F7ry7098BNaSJwV0=;
 b=lv6EYC0KIQSUXgo/agl2a4qyuDeg82rlicqvu9bWnrY83QTz3yD3PPR9SvWF673wry
 2jCaidQiZeo8vu3nQwDjIywpLjU0hfbHm9J42meXMn6MbrNHz/wfrihqv+8LNsttipxn
 rElE2Q5EFSmKkqlx8tjdhIEsaEaw0IPaUxkduu6qUD1SwlzIs7S6aECXwBa9RTbhWlLR
 Ebm6uMwFo1djxq0+yc93NjHdhDbL49Ud6CU+LHb0DgExkBRCbrVcZl5qKywaMBkiAoBs
 zh72yn1NI+jQnnUX4s59R8n+cNFI+KG16ZYrnjlaz+rzDzr236L/vWo7OY/fuDVjPOii
 6oOQ==
X-Gm-Message-State: ABy/qLYLa+tBnEuNuqPGYnvCvA2KIIaJHQnGHsJf4kq0BcnClItR6w1v
 qHEGQaX3JE5HZSp8BWAurQvSvxvtrMQ1mb1joUlmng==
X-Google-Smtp-Source: APBJJlEja4qOnluP3YGgEue7c0G5m3ZOjjLi9B/a/FSUyH+u0+cCPKInXYAXJMy7Vim7kvtipq2ZI9oaA8OPYlfEl/g=
X-Received: by 2002:a0c:d692:0:b0:63d:37c1:c063 with SMTP id
 k18-20020a0cd692000000b0063d37c1c063mr3269101qvi.25.1690589946155; Fri, 28
 Jul 2023 17:19:06 -0700 (PDT)
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
In-Reply-To: <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 20:18:55 -0400
Message-ID: <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/8xBPIFPMiZuY2MGwbn0XceValCY>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgODowNeKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIEp1bCAyOCwgMjAy
MyBhdCA0OjMy4oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+IHdyb3RlOgo+ID4K
PiA+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDk6MDXigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YK
PiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24g
V2VkLCBKdWwgMjYsIDIwMjMgYXQgMTI6MTbigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9i
cy5jcj4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAyOjM3
4oCvUE0gV2F0c29uIExhZGQgPHdhdHNvbmJsYWRkQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgOToxNeKAr0FNIEFsZXhlaSBTdGFy
b3ZvaXRvdgo+ID4gPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCA3OjAz4oCvQU0g
RGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWljcm9zb2Z0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBJIGFtIGZvcndhcmRpbmcgdGhlIGVtYWlsIGJlbG93IChhZnRlciBjb252
ZXJ0aW5nIEhUTUwgdG8gcGxhaW4gdGV4dCkKPiA+ID4gPiA+ID4gPiB0byB0aGUgbWFpbHRvOmJw
ZkB2Z2VyLmtlcm5lbC5vcmcgbGlzdCBzbyByZXBsaWVzIGNhbiBnbyB0byBib3RoIGxpc3RzLgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gUGxlYXNlIHVzZSB0aGlzIG9uZSBmb3IgYW55IHJl
cGxpZXMuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4gPiA+ID4g
RGF2ZQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBGcm9tOiBCcGYgPGJwZi1ib3VuY2Vz
QGlldGYub3JnPiBPbiBCZWhhbGYgT2YgV2F0c29uIExhZGQKPiA+ID4gPiA+ID4gPiA+IFNlbnQ6
IE1vbmRheSwgSnVseSAyNCwgMjAyMyAxMDowNSBQTQo+ID4gPiA+ID4gPiA+ID4gVG86IGJwZkBp
ZXRmLm9yZwo+ID4gPiA+ID4gPiA+ID4gU3ViamVjdDogW0JwZl0gUmV2aWV3IG9mIGRyYWZ0LXRo
YWxlci1icGYtaXNhLTAxCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gRGVhciBCUEYg
d2csCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSB0b29rIGEgbG9vayBhdCB0aGUg
ZHJhZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21lIGlzc3VlcywgdW5zdXJwcmlzaW5nbHkgYXQgdGhp
cyBzdGFnZS4gT25lIGlzCj4gPiA+ID4gPiA+ID4gPiB0aGUgc3BlY2lmaWNhdGlvbiBzZWVtcyB0
byB1c2UgYW4gdW5kZXJzcGVjaWZpZWQgQyBwc2V1ZG8gY29kZSBmb3Igb3BlcmF0aW9ucyB2cwo+
ID4gPiA+ID4gPiA+ID4gZGVmaW5pbmcgdGhlbSBtYXRoZW1hdGljYWxseS4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gSGkgV2F0c29uLAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGlzIGlzIG5v
dCAidW5kZXJzcGVjaWZpZWQgQyIgcHNldWRvIGNvZGUuCj4gPiA+ID4gPiA+IFRoaXMgaXMgYXNz
ZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQgZW1pdHRlZCBieSBHQ0MsIExMVk0sIGdhcywgTGludXgg
S2VybmVsLCBldGMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSBkb24ndCBzZWUgYSByZWZlcmVuY2Ug
dG8gYW55IGRlc2NyaXB0aW9uIG9mIHRoYXQgaW4gc2VjdGlvbiA0LjEuCj4gPiA+ID4gPiBJdCdz
IHBvc3NpYmxlIEkndmUgb3Zlcmxvb2tlZCB0aGlzLCBhbmQgaWYgcGVvcGxlIHRoaW5rIHRoaXMg
c3R5bGUgb2YKPiA+ID4gPiA+IGRlZmluaXRpb24gaXMgZ29vZCBlbm91Z2ggdGhhdCB3b3JrcyBm
b3IgbWUuIEJ1dCBJIGZvdW5kIHRhYmxlIDQKPiA+ID4gPiA+IHByZXR0eSBzY2FudHkgb24gd2hh
dCBleGFjdGx5IGhhcHBlbnMuCj4gPiA+ID4KPiA+ID4gPiBIZWxsbyEgQmFzZWQgb24gV2F0c29u
J3MgcG9zdCwgSSBoYXZlIGRvbmUgc29tZSByZXNlYXJjaCBhbmQgd291bGQKPiA+ID4gPiBwb3Rl
bnRpYWxseSBsaWtlIHRvIG9mZmVyIGEgcGF0aCBmb3J3YXJkLiBUaGVyZSBhcmUgc2V2ZXJhbCBk
aWZmZXJlbnQKPiA+ID4gPiB3YXlzIHRoYXQgSVNBcyBzcGVjaWZ5IHRoZSBzZW1hbnRpY3Mgb2Yg
dGhlaXIgb3BlcmF0aW9uczoKPiA+ID4gPgo+ID4gPiA+IDEuIEludGVsIGhhcyBhIHNlY3Rpb24g
aW4gdGhlaXIgbWFudWFsIHRoYXQgZGVzY3JpYmVzIHRoZSBwc2V1ZG9jb2RlCj4gPiA+ID4gdGhl
eSB1c2UgdG8gc3BlY2lmeSB0aGVpciBJU0E6IFNlY3Rpb24gMy4xLjEuOSBvZiBUaGUgSW50ZWzC
riA2NCBhbmQKPiA+ID4gPiBJQS0zMiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlIERldmVsb3BlcuKA
mXMgTWFudWFsIGF0Cj4gPiA+ID4gaHR0cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENv
bnRlbnQvNjcxMTk5Cj4gPiA+ID4gMi4gQVJNIGhhcyBhbiBlcXVpdmFsZW50IGZvciB0aGVpciB2
YXJpZXR5IG9mIHBzZXVkb2NvZGU6IENoYXB0ZXIgSjEKPiA+ID4gPiBvZiBBcm0gQXJjaGl0ZWN0
dXJlIFJlZmVyZW5jZSBNYW51YWwgZm9yIEEtcHJvZmlsZSBhcmNoaXRlY3R1cmUgYXQKPiA+ID4g
PiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRpMDQ4Ny9sYXRlc3Qv
Cj4gPiA+ID4gMy4gU2FpbCAiaXMgYSBsYW5ndWFnZSBmb3IgZGVzY3JpYmluZyB0aGUgaW5zdHJ1
Y3Rpb24tc2V0IGFyY2hpdGVjdHVyZQo+ID4gPiA+IChJU0EpIHNlbWFudGljcyBvZiBwcm9jZXNz
b3JzLiIKPiA+ID4gPiAoaHR0cHM6Ly93d3cuY2wuY2FtLmFjLnVrL35wZXMyMC9zYWlsLykKPiA+
ID4gPgo+ID4gPiA+IEdpdmVuIHRoZSBjb21tZXJjaWFsIG5hdHVyZSBvZiAoMSkgYW5kICgyKSwg
cGVyaGFwcyBTYWlsIGlzIGEgd2F5IHRvCj4gPiA+ID4gcHJvY2VlZC4gSWYgcGVvcGxlIGFyZSBp
bnRlcmVzdGVkLCBJIHdvdWxkIGJlIGhhcHB5IHRvIGxlYWQgYW4gZWZmb3J0Cj4gPiA+ID4gdG8g
ZW5jb2RlIHRoZSBlQlBGIElTQSBzZW1hbnRpY3MgaW4gU2FpbCAob3IgZmluZCBzb21lb25lIHdo
byBhbHJlYWR5Cj4gPiA+ID4gaGFzKSBhbmQgaW5jb3Jwb3JhdGUgdGhlbSBpbiB0aGUgZHJhZnQu
Cj4gPiA+Cj4gPiA+IGltbyBTYWlsIGlzIHRvbyByZXNlYXJjaHkgdG8gaGF2ZSBwcmFjdGljYWwg
dXNlLgo+ID4gPiBMb29raW5nIGF0IGFybTY0IG9yIHg4NiBTYWlsIGRlc2NyaXB0aW9uIEkgcmVh
bGx5IGRvbid0IHNlZSBob3cKPiA+ID4gaXQgd291bGQgbWFwIHRvIGFuIElFVEYgc3RhbmRhcmQu
Cj4gPiA+IEl0J3MgZG9uZSBpbiBhICJzYWlsIiBsYW5ndWFnZSB0aGF0IHBlb3BsZSBuZWVkIHRv
IGxlYXJuIGZpcnN0IHRvIGJlCj4gPiA+IGFibGUgdG8gcmVhZCBpdC4KPiA+ID4gU2F5IHdlIGhh
ZCBicGYuc2FpbCBzb21ld2hlcmUgb24gZ2l0aHViLiBXaGF0IHZhbHVlIGRvZXMgaXQgYnJpbmcg
dG8KPiA+ID4gQlBGIElTQSBzdGFuZGFyZD8gSSBkb24ndCBzZWUgYW4gaW1tZWRpYXRlIGJlbmVm
aXQgdG8gc3RhbmRhcmRpemF0aW9uLgo+ID4gPiBUaGVyZSBjb3VsZCBiZSBvdGhlciB1c2UgY2Fz
ZXMsIG5vIGRvdWJ0LCBidXQgc3RhbmRhcmRpemF0aW9uIGlzIG91ciBnb2FsLgo+ID4gPgo+ID4g
PiBBcyBmYXIgYXMgMSBhbmQgMi4gSW50ZWwgYW5kIEFybSB1c2UgdGhlaXIgb3duIHBzZXVkb2Nv
ZGUsIHNvIHRoZXkgaGFkCj4gPiA+IHRvIGFkZCBhIHBhcmFncmFwaCB0byBkZXNjcmliZSBpdC4g
V2UgYXJlIHVzaW5nIEMgdG8gZGVzY3JpYmUgQlBGIElTQQo+ID4KPiA+Cj4gPiBJIGNhbm5vdCBm
aW5kIGEgcmVmZXJlbmNlIGluIHRoZSBjdXJyZW50IHZlcnNpb24gdGhhdCBzcGVjaWZpZXMgd2hh
dAo+ID4gd2UgYXJlIHVzaW5nIHRvIGRlc2NyaWJlIHRoZSBvcGVyYXRpb25zLiBJJ2QgbGlrZSB0
byBhZGQgdGhhdCwgYnV0Cj4gPiB3YW50IHRvIG1ha2Ugc3VyZSB0aGF0IEkgY2xhcmlmeSB0d28g
c3RhdGVtZW50cyB0aGF0IHNlZW0gdG8gYmUgYXQKPiA+IG9kZHMuCj4gPgo+ID4gSW1tZWRpYXRl
bHkgYWJvdmUgeW91IHNheSB0aGF0IHdlIGFyZSB1c2luZyAiQyB0byBkZXNjcmliZSB0aGUgQlBG
Cj4gPiBJU0EiIGFuZCBmdXJ0aGVyIGFib3ZlIHlvdSBzYXkgIlRoaXMgaXMgYXNzZW1ibHkgc3lu
dGF4IHBhcnNlZCBhbmQKPiA+IGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtlcm5l
bCwgZXRjLiIKPiA+Cj4gPiBNeSBvd24gcmVhZGluZyBpcyB0aGF0IGl0IGlzIHRoZSBmb3JtZXIs
IGFuZCBub3QgdGhlIGxhdHRlci4gQnV0LCBJCj4gPiB3YW50IHRvIGRvdWJsZSBjaGVjayBiZWZv
cmUgYWRkaW5nIHRoZSBhcHByb3ByaWF0ZSBzdGF0ZW1lbnRzIHRvIHRoZQo+ID4gQ29udmVudGlv
biBzZWN0aW9uLgo+Cj4gSXQncyBib3RoLiBJJ20gbm90IHN1cmUgd2hlcmUgeW91IHNlZSBhIGNv
bnRyYWRpY3Rpb24uCj4gSXQncyBhIG5vcm1hbCBDIHN5bnRheCBhbmQgaXQncyBlbWl0dGVkIGJ5
IHRoZSBrZXJuZWwgdmVyaWZpZXIsCj4gcGFyc2VkIGJ5IGNsYW5nL2djYyBhc3NlbWJsZXJzIGFu
ZCBlbWl0dGVkIGJ5IGNvbXBpbGVycy4KCgpPa2F5LiBJIGFwb2xvZ2l6ZS4gSSBhbSBzaW5jZXJl
bHkgY29uZnVzZWQuIEZvciBpbnN0YW5jZSwKCmlmICh1MzIpZHN0ID49ICh1MzIpc3JjIGdvdG8g
K29mZnNldAoKTG9va3MgbGlrZSBub3RoaW5nIHRoYXQgSSBoYXZlIGV2ZXIgc2VlbiBpbiAibm9y
bWFsIEMgc3ludGF4Ii4KClRoZXJlIGFsc28gYXBwZWFyIHRvIGJlIGEgZmV3IG90aGVyIHBsYWNl
cyB3aGVyZSB0aGluZ3MgbWlnaHQgYmUgYSBiaXQgd29ua3k6CgoxLiBBZGRyZXNzIGFyaXRobWV0
aWMgaW4gdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBsb2FkL3N0b3JlCmluc3RydWN0aW9ucyB3aWxs
IGRlcGVuZCBvbiB0aGUgdHlwZSBvZiB0aGUgdGFyZ2V0OiBFLmcuLAoKKih1NjQgKikoZHN0ICsg
b2Zmc2V0KSA9IGltbQoKVGhlIGFkZHJlc3MgdG8gd2hpY2ggdGhlIHN0b3JlIGlzIGRvbmUgd2ls
bCBiZSBvZmZzZXQqc2l6ZW9mKFgpIGJ5dGVzCmZyb20gZHN0IHdoZXJlIFggaXMgdGhlIHR5cGUg
b2YgdGhlIHRhcmdldCBvZiBkc3QuIElmIHdlIGFyZSBhc3N1bWluZwp0aGF0IGRzdCAob3IgaXRz
IGVxdWl2YWxlbnQgaW4gc2ltaWxhciBpbnN0cnVjdGlvbnMpIGlzIGJlaW5nIHRyZWF0ZWQKc2lt
cGx5IGFzIGFuIHVuc2lnbmVkIGludGVnZXIsIEkgYmVsaWV2ZSB0aGF0IHdlIHdpbGwgaGF2ZSB0
byBzYXkgdGhhdApleHBsaWNpdGx5LCBlc3BlY2lhbGx5IGdpdmVuIHRoYXQgd2UgZGVzY3JpYmUg
b2Zmc2V0IGFzICJzaWduZWQKaW50ZWdlciBvZmZzZXQgdXNlZCB3aXRoIHBvaW50ZXIgYXJpdGht
ZXRpYyIgaW4gdGhlIEluc3RydWN0aW9uCmVuY29kaW5nIHNlY3Rpb24uCgoyLiBodG9bYmxdZU4g
ZnVuY3Rpb25zIGFyZSBub3Qgc3BlY2lmaWVkIGJ5IHN0YW5kYXJkIEMgYW5kLCB3aGlsZQoib2J2
aW91cyIgd2hhdCB0aGV5IGRvLCBhcmUgbm90IGRlZmluZWQgaW4gdGhlIGRvY3VtZW50IGFueXdo
ZXJlLgoKQWdhaW4sIEkgYW0gcmVhbGx5IHNvcnJ5IHRvIGJlIGNhdXNpbmcgc28gbXVjaCBjb25m
dXNpb24uIEkgaG9wZSB0aGF0CmF0IGxlYXN0IHNvbWUgb2YgdGhpcyBkaXNjdXNzaW9uIGlzIGhl
bHBmdWwuCgpXaWxsCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93
d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

