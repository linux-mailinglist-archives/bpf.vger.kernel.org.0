Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF10255F4B
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgH1RAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1RAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 13:00:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA3C061264
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 10:00:13 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i4so1269679qvv.4
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=qVSCDm8AqOY/NN5FUWbHAl4wXL1gIq+ycngXFQDgYlE=;
        b=igZbLsbo9LouaWkh6UIVRC4+6oxbHcOBZWqzv2Cf2e0mS9yxZIQGEeRl2nCPEGGcGg
         esoG/caKDB3NZTnmKfh2z+NpUR/8+NM7jkutuWiUERufKURv0Hdjk2rNr1YbTYj1n8Fz
         C0sslc0tdfGkxFA6W2L/t4cdtozaAEz2ytTeqtguGmko7crDTTx1Ul/NUcpGmqHB8HIS
         krzkOPvZVRZv/xmTKb2rAO3ThyfDrIKZawyq4gtR85iWVE5bbA3+2TbomECggdnW+Jm8
         WDAki2Q5196Io1KxAJmKf+cu2BJ3IAFiT81Vq0nk7Y3nef/QUCRxXZ35YQDOa1xioT5t
         dvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=qVSCDm8AqOY/NN5FUWbHAl4wXL1gIq+ycngXFQDgYlE=;
        b=C0yqTEY/D4AIJ4tg+0EOaWIXkGdY5m2OaNzC24DibTkIj3I/z+DQvkoVqkrl2FlK8g
         jSmUK65EnqewHRiroIDTq91ocW6P6tSsEqTCTYJl28eO6V2KOApwNMKydUKBFo6yD35z
         XaIa7bD/pQQMrVQ3IwakLtxg8LXzc8Nz5EiQvaYEbTSKI2n5oCNXvq+I80Yd7JrclEI1
         fGKE8ZKJdAwle7swxFP71/IY6YnN2QkCHOnUBtrEOikm90r2uO1PDNUNEiI2zQ89ViTf
         EeN1qD4nQ9bRhCwNKWKe7XLs11J6UEX4TnJt5bF/HX89KZ/fuFNTPUXXIg5A+ZH1OLPf
         Q0Tg==
X-Gm-Message-State: AOAM532ZKwX8FNw8KUxsBG9qMqUagiFAhLnpQKcNUUO1kEHJNxhPFFVX
        alCcbXNzenvc67bO2H9JZpyX1ik=
X-Google-Smtp-Source: ABdhPJxucGUIQ8aLUCAvPWJp0rosUMSVDrsXhj57wQLbWOmpxCZBly93HTlWNvKLoAtMQ7IKUtX39Qw=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a05:6214:10e8:: with SMTP id
 q8mr2649915qvt.59.1598634011735; Fri, 28 Aug 2020 10:00:11 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:00:10 -0700
In-Reply-To: <874kot2ors.fsf@toke.dk>
Message-Id: <20200828170010.GB48607@google.com>
Mime-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
 <e02ae4a7-938f-222e-3139-5ba84e95df15@fb.com> <877dts5qah.fsf@toke.dk>
 <CAA-VZP=Jo0iQRpP+QEmB359C5TS=0BnDHTAzd6yC85aOkEJrsA@mail.gmail.com> <874kot2ors.fsf@toke.dk>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
From:   sdf@google.com
To:     "Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=" <toke@redhat.com>
Cc:     YiFei Zhu <zhuyifei@google.com>, Yonghong Song <yhs@fb.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDgvMjMsIFRva2UgSO+/vWlsYW5kLUrvv71yZ2Vuc2VuIHdyb3RlOg0KPiBZaUZlaSBaaHUg
PHpodXlpZmVpQGdvb2dsZS5jb20+IHdyaXRlczoNCg0KPiA+IE9uIEZyaSwgQXVnIDIxLCAyMDIw
IGF0IDM6NTggQU0gVG9rZSBI77+9aWxhbmQtSu+/vXJnZW5zZW4gIA0KPiA8dG9rZUByZWRoYXQu
Y29tPiB3cm90ZToNCj4gPj4gWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3JpdGVzOg0KPiA+
PiA+IE5vdCBzdXJlIHdoZXRoZXIgd2UgbmVlZCBmb3JtYWwgbGliYnBmIEFQSSB0byBhY2Nlc3Mg
bWV0YWRhdGEgb3Igbm90Lg0KPiA+PiA+IFRoaXMgbWF5IGhlbHAgb3RoZXIgYXBwbGljYXRpb25z
IHRvby4gQnV0IHdlIGNhbiBkZWxheSB1bnRpbCBpdCBpcw0KPiA+PiA+IG5lY2Vzc2FyeS4NCj4g
Pj4NCj4gPj4gWWVhaCwgcGxlYXNlIHB1dCBpbiBhIGxpYmJwZiBhY2Nlc3NvciBhcyB3ZWxsOyBJ
IHdvdWxkIGxpa2UgdG8gdXNlIHRoaXMNCj4gPj4gZnJvbSBsaWJ4ZHAgLSB3aXRob3V0IGEgc2tl
bGV0b24gOikNCj4gPj4NCj4gPj4gLVRva2UNCj4gPg0KPiA+IEkgZG9uJ3QgdGhpbmsgSSBoYXZl
IGFuIGlkZWEgb24gYSBnb29kIEFQSSBpbiBsaWJicGYgdGhhdCBjb3VsZCBiZQ0KPiA+IHVzZWQg
dG8gZ2V0IHRoZSBtZXRhZGF0YSBvZiBhbiBleGlzdGluZyBwcm9ncmFtIGluIGtlcm5lbCwgdGhh
dCBjb3VsZA0KPiA+IGJlIHJldXNlZCBieSBicGZ0b29sIHdpdGhvdXQgZHVwbGljYXRpbmcgYWxs
IHRoZSBjb2RlLiBNYXliZSB3ZSBjYW4NCj4gPiBkaXNjdXNzIHRoaXMgaW4gYSBmb2xsb3cgdXAg
c2VyaWVzPw0KDQo+IEkgdGhpbmsgdGhlIG1vc3QgaW1wb3J0YW50IHBhcnQgaXMgZ2V0dGluZyBh
IHJlZmVyZW5jZSB0byB0aGUgbWV0YWRhdGENCj4gbWFwLiBTbyBhIGZ1bmN0aW9uIHRoYXQgYmFz
aWNhbGx5IGRvZXMgd2hhdCB0aGUgdG9wIGhhbGYgb2Ygd2hhdCB5b3VyDQo+IHNob3dfcHJvZ19t
ZXRhZGF0YSgpIGZ1bmN0aW9uIGRvZXM6IGdpdmVuIGEgcHJvZyBmZCwgd2FsayB0aGUgbWFwIGlk
cywNCj4gY2hlY2sgaWYgYW55IG9mIHRoZW0gbG9va3MgbGlrZSBhIG1ldGFkYXRhIG1hcCwgYW5k
IGlmIHNvIHJldHVybiB0aGUgbWFwDQo+IGZkLg0KDQo+IFNob3VsZCBiZSBwcmV0dHkgc3RyYWln
aHQtZm9yd2FyZCB0byByZXVzZSBiZXR3ZWVuIGJwZnRvb2wvbGliYnBmLCBubz8NClNvdW5kcyBn
b29kLCBJJ2xsIGJlIHRha2luZyBvdmVyIHRoaXMgcGF0Y2ggc2VyaWVzIGFzIFlpRmVpJ3MgaW50
ZXJuc2hpcA0KaGFzIGVuZGVkLiBJJ2xsIHRyeSB0byBhZGRyZXNzIHRoYXQuDQo=
