Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF4698A30
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 02:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBPBmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 20:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBPBmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 20:42:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAC8460AB
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 17:42:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p7-20020a257407000000b0091b90b20cd9so458395ybc.6
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 17:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbBj96U4QHb8LOdV9FuugABpY4gxfDEDWX8zRAQljpU=;
        b=qDT0CIw/60FIkXov38AK4X8NvwFVZ0vfITlBJY4g8O47kcU+6i54n1P63kJZh+xvVJ
         pJm42G1zIZU2UOa2eXEryjSpMDX86DQfM2oEjxQh6x3qVbSOqWuj77o2Cf6ZjtFUm+gq
         y4n9lTjud6pi57Pti0N+hQ+O6MoQzbxXF6CIdqPGzYZ1JyF/EwyP+VEsv1LyJYfisgmY
         LWgukYryStNP3D0yKj80n6r0T8dnpugpeK+tiJfpPtghhLtAEyqpELFejUjxQFKPrTWx
         AvVFSV7y3LiK2Sd8UwIRJ3IA/Bp0j3+2WQO+4kRxZcQOYC9qayCstVrRq4QpYzMm6pVa
         8YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UbBj96U4QHb8LOdV9FuugABpY4gxfDEDWX8zRAQljpU=;
        b=G3vJc8ROcWXW1YpH9QDhEE0NPnZYKciaZMxHN9I2qMscRkcT9A3GArJZO1FXEYQWRd
         CJpaqt1FoczP+Uf/UmSDuMs7501zieawrleSRfJtH1QB3voh7+SuwL0Qum6lAQwP8a9N
         ZFMzluBtKKU5HTwctC1sUpwPRcDQyggCl0HMpBR746Dx85wjYkOVC1XSivbAeqDVH7Ub
         hMX9Fm6BJN/Wyb1o68XBA2YD+XuKMbxKP4K1V0ZvN/DkIEfWKazid3MOznqu83JJoDdG
         5aJx49cPuG3kW9Kd9qp/oCfdZo/NRl4vX3PU8/7VBGJJgPlhR54qVCxqOYToaCDabOB6
         mvXQ==
X-Gm-Message-State: AO0yUKU2uIzR/JK4Mh48oaro4FD95EOhXjnq7xrKkM/dxqlDgPdzMmlW
        5TPe1cTFRaQdCHvqW9JGvzp5KUo=
X-Google-Smtp-Source: AK7set855ZxCzCOCeZWBCSveIkfLcOyebRfAZC4zP27+cziP18j5lHMbodKDjXK6wuRF2xdNRsGg+0U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:251:b0:8e9:abfc:1a35 with SMTP id
 k17-20020a056902025100b008e9abfc1a35mr17ybs.13.1676511740294; Wed, 15 Feb
 2023 17:42:20 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:42:18 -0800
In-Reply-To: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
Mime-Version: 1.0
References: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
Message-ID: <Y+2J+jIFIxGOW32X@google.com>
Subject: Re: [RFC] libbbpf/bpftool: Support 32-bit Architectures.
From:   Stanislav Fomichev <sdf@google.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     bpf@vger.kernel.org, quentin@isovalent.com, ast@kernel.org,
        daniel@iogearbox.net, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDIvMTUsIFB1cmFuamF5IE1vaGFuIHdyb3RlOg0KPiBUaGUgQlBGIHNlbGZ0ZXN0cyBmYWls
IHRvIGNvbXBpbGUgb24gMzItYml0IGFyY2hpdGVjdHVyZXMgYXMgdGhlIHNrZWxldG9uDQo+IGdl
bmVyYXRlZCBieSBicGZ0b29sIGRvZXNu4oCZdCB0YWtlIGludG8gY29uc2lkZXJhdGlvbiB0aGUg
c2l6ZSBkaWZmZXJlbmNlICANCj4gb2YNCj4gdmFyaWFibGVzIG9uIDMyLWJpdC82NC1iaXQgYXJj
aGl0ZWN0dXJlcy4NCg0KPiBBcyBhbiBleGFtcGxlLA0KPiBJZiBhIGJwZiBwcm9ncmFtIGhhcyBh
IGdsb2JhbCB2YXJpYWJsZSBvZiB0eXBlOiBsb25nLCBpdHMgc2tlbGV0b24gd2lsbCAgDQo+IGlu
Y2x1ZGUNCj4gYSBic3MgbWFwIHRoYXQgd2lsbCBoYXZlIGEgZmllbGQgZm9yIHRoaXMgdmFyaWFi
bGUuIFRoZSBsb25nIHZhcmlhYmxlIGluICANCj4gQlBGIGlzDQo+IDY0LWJpdC4gaWYgd2UgYXJl
IHdvcmtpbmcgb24gYSAzMi1iaXQgbWFjaGluZSwgdGhlIGdlbmVyYXRlZCBza2VsZXRvbiBoYXMg
IA0KPiB0bw0KPiBjb21waWxlIGZvciB0aGF0IG1hY2hpbmUgd2hlcmUgbG9uZyBpcyAzMi1iaXQu
DQoNCj4gQSByZXByb2R1Y2VyIGZvciB0aGlzIGlzc3VlOg0KPiAgICAgICAgICByb290QDU2ZWM1
OWFhNjMyZjp+IyBjYXQgdGVzdC5icGYuYw0KPiAgICAgICAgICBsb25nIHZhcjsNCg0KPiAgICAg
ICAgICByb290QDU2ZWM1OWFhNjMyZjp+IyBjbGFuZyAtdGFyZ2V0IGJwZiAtZyAtYyB0ZXN0LmJw
Zi5jDQoNCj4gICAgICAgICAgcm9vdEA1NmVjNTlhYTYzMmY6fiMgYnBmdG9vbCBidGYgZHVtcCBm
aWxlIHRlc3QuYnBmLm8gZm9ybWF0IHJhdw0KPiAgICAgICAgICBbMV0gSU5UICdsb25nIGludCcg
c2l6ZT04IGJpdHNfb2Zmc2V0PTAgbnJfYml0cz02NCBlbmNvZGluZz1TSUdORUQNCj4gICAgICAg
ICAgWzJdIFZBUiAndmFyJyB0eXBlX2lkPTEsIGxpbmthZ2U9Z2xvYmFsDQo+ICAgICAgICAgIFsz
XSBEQVRBU0VDICcuYnNzJyBzaXplPTAgdmxlbj0xDQo+ICAgICAgICAgICAgICAgICB0eXBlX2lk
PTIgb2Zmc2V0PTAgc2l6ZT04IChWQVIgJ3ZhcicpDQoNCj4gICAgICAgICByb290QDU2ZWM1OWFh
NjMyZjp+IyBicGZ0b29sIGdlbiBza2VsZXRvbiB0ZXN0LmJwZi5vID4gc2tlbGV0b24uaA0KDQo+
ICAgICAgICAgcm9vdEA1NmVjNTlhYTYzMmY6fiMgZWNobyAiI2luY2x1ZGUgXCJza2VsZXRvbi5o
XCIiID4gdGVzdC5jDQoNCj4gICAgICAgICByb290QDU2ZWM1OWFhNjMyZjp+IyBnY2MgdGVzdC5j
DQo+ICAgICAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHRlc3QuYzoxOg0KPiAgICAgICAgIHNr
ZWxldG9uLmg6IEluIGZ1bmN0aW9uICd0ZXN0X2JwZl9fYXNzZXJ0JzoNCj4gICAgICAgICBza2Vs
ZXRvbi5oOjIzMToyOiBlcnJvcjogc3RhdGljIGFzc2VydGlvbiBmYWlsZWQ6ICJ1bmV4cGVjdGVk
DQo+IHNpemUgb2YgXCd2YXJcJyINCj4gICAgICAgICAgIDIzMSB8ICBfU3RhdGljX2Fzc2VydChz
aXplb2Yocy0+YnNzLT52YXIpID09IDgsICJ1bmV4cGVjdGVkDQo+IHNpemUgb2YgJ3ZhciciKTsN
Cj4gICAgICAgICAgICAgICAgICB8ICBefn5+fn5+fn5+fn5+fg0KDQo+IE9uZSBuYWl2ZSBzb2x1
dGlvbiBmb3IgdGhpcyB3b3VsZCBiZSB0byBtYXAg4oCYbG9uZ+KAmSB0byDigJhsb25nIGxvbmfi
gJkgYW5kDQo+IOKAmHVuc2lnbmVkIGxvbmfigJkgdG8g4oCYdW5zaWduZWQgbG9uZyBsb25n4oCZ
LiBCdXQgdGhpcyBkb2VzbuKAmXQgc29sdmUgZXZlcnl0aGluZw0KPiBiZWNhdXNlIHRoaXMgcHJv
YmxlbSBpcyBhbHNvIHNlZW4gd2l0aCBwb2ludGVycyB0aGF0IGFyZSA2NC1iaXQgaW4gQlBGIGFu
ZA0KPiAzMi1iaXQgaW4gMzItYml0IG1hY2hpbmVzLg0KDQo+IEkgd2FudCB0byB3b3JrIG9uIHNv
bHZpbmcgdGhpcyBhbmQgYW0gbG9va2luZyBmb3IgaWRlYXMgdG8gc29sdmUgaXQgIA0KPiBlZmZp
Y2llbnRseS4NCj4gVGhlIG1haW4gZ29hbCBpcyB0byBtYWtlIGxpYmJicGYvYnBmdG9vbCBob3N0
IGFyY2hpdGVjdHVyZSBhZ25vc3RpYy4NCg0KTG9va3MgbGlrZSBicGZ0b29sIG5lZWRzIHRvIGJl
IGF3YXJlIG9mIHRoZSB0YXJnZXQgYXJjaGl0ZWN0dXJlLiBUaGUNCnNhbWUgd2F5IGdjYyBpcyBk
b2luZyB3aXRoIGJ1aWxkLWhvc3QtdGFyZ2V0IHRyaXBsZXQuIEkgZG9uJ3QNCnRoaW5rIHRoaXMg
Y2FuIGJlIHNvbHZlZCB3aXRoIGEgYnVuY2ggb2YgdHlwZWRlZnM/IEJ1dCBJJ3ZlIGxvbmcNCmZv
cmdvdHRlbiBob3cgYSBwdXJlIDMyLWJpdCBtYWNoaW5lIGxvb2tzLCBzbyBJIGNhbid0IGdpdmUg
YW55DQp1c2VmdWwgaW5wdXQgOi0oDQoNCg0KPiBUaGFua3MsDQo+IFB1cmFuamF5IE1vaGFuLg0K
