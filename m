Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86E6CC93A
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjC1RZZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1RZX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:25:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC28F
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:25:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so12759092ybc.8
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680024318;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDpr4y9SIEftIEZ7uk/JHhcIaADrbR2gmSQ6aOvEkQg=;
        b=ifKLPfbkLZuqUBDePmGBqytYG8SX+ISxrwE8waUB+Hu4XB9axtU1uGJtUdV80Nhlyj
         qBqQ/GraGDJawfnuC8h8HPp5/FPx1JvSK9Fje7uXB5Tz0PqngR7X/VZQBER9seJ747yo
         064URlRiGH4abEFmQh0rfKp8By7wrtBN6rabRDr91JjEgx605eYMUJCi4lozC0ZfnQX7
         LSTCYQQH7uPVrlSfaC8NsiXAo1xTSEWaEcGwIc8Rqkd7aHzuiCJSDfigf2ghauOu3KBe
         2W9p+vFrDt4bWUlCJGe35dsn3T38mLoyw4HzqN4Hadj1I0z6WE2oXxcM58MeJRO1kfRs
         ToSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024318;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDpr4y9SIEftIEZ7uk/JHhcIaADrbR2gmSQ6aOvEkQg=;
        b=x7pQUF42hYhCwWXlIiSrQv8YGsBncgHZuOO9G62A6uWfvN79ikq8qqK6DWDwpt4M7J
         u66RyPMoy+/Usj0m7bIjYeOiw9BH5u7+gYwQW3YOd4zn91tRd/t7F/Odt9JAzvIRdStl
         uGE25yLQZZob09FmLjAypc8Iz+PTSvzV9N3AgAcnMq8cl4lRmUrOyw/8HjwUr1hcPnby
         kpGHbPXP4O6rAABXUW0iQ3TXdaYLGCPnz+hp/9KW6lnxA2fDrUXl88/60J+iA98zPj6j
         amtSH8bRbPu17xfPLaE2DQ8XohmXZzVBe8U9H7dsol7A7OhKC101K0UOWRYZt/eqCT/b
         FagQ==
X-Gm-Message-State: AAQBX9dDBYHBQ3OK0L725qfSaHTT+MpmHSjs0Azs2erTJ99WLL+xhlsL
        M0alM0XBk5ZjXwE6IUww+kgo6co=
X-Google-Smtp-Source: AKy350aNG9RqibXVEdMBP9bhhv3Kp2FazoxpzukCMgflw0K0gXupk92hjy33B6aL2n4qM41+Nw74DIY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:168d:b0:98e:6280:90e7 with SMTP id
 bx13-20020a056902168d00b0098e628090e7mr10526829ybb.13.1680024317827; Tue, 28
 Mar 2023 10:25:17 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:25:16 -0700
In-Reply-To: <20230327185202.1929145-1-andrii@kernel.org>
Mime-Version: 1.0
References: <20230327185202.1929145-1-andrii@kernel.org>
Message-ID: <ZCMi/IN1Z0VN1LdE@google.com>
Subject: Re: [PATCH v4 bpf-next 0/3] veristat: add better support of freplace programs
From:   Stanislav Fomichev <sdf@google.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDMvMjcsIEFuZHJpaSBOYWtyeWlrbyB3cm90ZToNCj4gVGVhY2ggdmVyaXN0YXQgaG93IHRv
IGRlYWwgd2l0aCBmcmVwbGFjZSBCUEYgcHJvZ3JhbXMuIEFzIHRoZXkgY2FuJ3QgYmUNCj4gZGly
ZWN0bHkgbG9hZGVkIGJ5IHZlcmlzdGF0IHdpdGhvdXQgY3VzdG9tIHVzZXItc3BhY2UgcGFydCB0
aGF0IHNldHMgIA0KPiBjb3JyZWN0DQo+IHRhcmdldCBwcm9ncmFtIEZELCB2ZXJpc3RhdCBhbHdh
eXMgZmFpbHMgZnJlcGxhY2UgcHJvZ3JhbXMuIFRoaXMgcGF0Y2ggc2V0DQo+IHRlYWNoZXMgdmVy
aXN0YXQgdG8gZ3Vlc3MgdGFyZ2V0IHByb2dyYW0gdHlwZSB0aGF0IHdpbGwgYmUgaW5oZXJpdGVk
IGJ5DQo+IGZyZXBsYWNlIHByb2dyYW0gaXRzZWxmLCBhbmQgc3VidGl0dXRlIGl0IGZvciBCUEZf
UFJPR19UWVBFX0VYVCAgDQo+IChmcmVwbGFjZSkgb25lDQo+IGZvciB0aGUgcHVycG9zZXMgb2Yg
QlBGIHZlcmlmaWNhdGlvbi4NCg0KQWNrZWQtYnk6IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGdv
b2dsZS5jb20+DQoNCj4gUGF0Y2ggIzEgZml4ZXMgYnVnIGluIGxpYmJwZiBwcmV2ZW50aW5nIG92
ZXJyaWRpbmcgZnJlcGxhY2Ugd2l0aCBzcGVjaWZpYw0KPiBwcm9ncmFtIHR5cGUuDQoNCj4gUGF0
Y2ggIzIgYWRkcyBjb252ZW5pZW50IC1kIGZsYWcgdG8gcmVxdWVzdCB2ZXJpc3RhdCB0byBlbWl0
IGxpYmJwZiBkZWJ1Zw0KPiBsb2dzLiBJdCBoZWxwIGRlYnVnZ2luZyB3aHkgYSBzcGVjaWZpYyBC
UEYgcHJvZ3JhbSBmYWlscyB0byBsb2FkLCBpZiB0aGUNCj4gcHJvYmxlbSBpcyBub3QgZHVlIHRv
IEJQRiB2ZXJpZmljYXRpb24gaXRzZWxmLg0KDQo+IHYzLT52NDoNCj4gICAgLSBmaXggb3B0aW9u
YWwga2Vybl9uYW1lIGNoZWNrIHdoZW4gZ3Vlc3NpbmcgcHJvZyB0eXBlIChBbGV4ZWkpOw0KPiB2
Mi0+djM6DQo+ICAgIC0gZml4IGJwZl9vYmpfaWQgc2VsZnRlc3QgdGhhdCB1c2VzIGxlZ2FjeSBi
cGZfcHJvZ190ZXN0X2xvYWQoKSBoZWxwZXIsDQo+ICAgICAgd2hpY2ggYWx3YXlzIHNldHMgcHJv
Z3JhbSB0eXBlIHByb2dyYW1tYXRpY2FsbHk7IHRlYWNoIHRoZSBoZWxwZXIgdG8gIA0KPiBkbyBp
dA0KPiAgICAgIG9ubHkgaWYgYWN0dWFsbHkgbmVjZXNzYXJ5IChTdGFuaXNsYXYpOw0KPiB2MS0+
djI6DQo+ICAgIC0gZml4IGNvbXBpbGF0aW9uIGVycm9yIHJlcG9ydGVkIGJ5IG9sZCBHQ0MgKG15
IEdDQyB2MTEgZG9lc24ndCBwcm9kdWNlICANCj4gZXZlbg0KPiAgICAgIGEgd2FybmluZykgYW5k
IENsYW5nIChzZWUgQ0kgZmFpbHVyZSBhdCBbMF0pOg0KDQo+IEdDQyB2ZXJzaW9uOg0KDQo+ICAg
IHZlcmlzdGF0LmM6IEluIGZ1bmN0aW9uIOKAmGZpeHVwX29iauKAmToNCj4gICAgdmVyaXN0YXQu
Yzo5MDg6MTogZXJyb3I6IGxhYmVsIGF0IGVuZCBvZiBjb21wb3VuZCBzdGF0ZW1lbnQNCj4gICAg
ICA5MDggfCBza2lwX2ZyZXBsYWNlX2ZpeHVwOg0KPiAgICAgICAgICB8IF5+fn5+fn5+fn5+fn5+
fn5+fn4NCg0KPiBDbGFuZyB2ZXJzaW9uOg0KDQo+ICAgIHZlcmlzdGF0LmM6OTA5OjE6IGVycm9y
OiBsYWJlbCBhdCBlbmQgb2YgY29tcG91bmQgc3RhdGVtZW50IGlzIGEgQzJ4ICANCj4gZXh0ZW5z
aW9uIFstV2Vycm9yLC1XYzJ4LWV4dGVuc2lvbnNdDQo+ICAgIH0NCj4gICAgXg0KPiAgICAxIGVy
cm9yIGdlbmVyYXRlZC4NCg0KPiAgICBbMF0gIA0KPiBodHRwczovL2dpdGh1Yi5jb20va2VybmVs
LXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy80NTE1OTcyMDU5L2pvYnMvNzk1Mzg0NTMzNQ0KDQo+
IEFuZHJpaSBOYWtyeWlrbyAoMyk6DQo+ICAgIGxpYmJwZjogZGlzYXNzb2NpYXRlIHNlY3Rpb24g
aGFuZGxlciBvbiBleHBsaWNpdA0KPiAgICAgIGJwZl9wcm9ncmFtX19zZXRfdHlwZSgpIGNhbGwN
Cj4gICAgdmVyaXN0YXQ6IGFkZCAtZCBkZWJ1ZyBtb2RlIG9wdGlvbiB0byBzZWUgZGVidWcgbGli
YnBmIGxvZw0KPiAgICB2ZXJpc3RhdDogZ3Vlc3MgYW5kIHN1YnN0aXR1ZSB1bmRlcmx5aW5nIHBy
b2dyYW0gdHlwZSBmb3IgZnJlcGxhY2UNCj4gICAgICAoRVhUKSBwcm9ncw0KDQo+ICAgdG9vbHMv
bGliL2JwZi9saWJicGYuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gICB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdGluZ19oZWxwZXJzLmMgfCAgIDIgKy0NCj4gICB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdmVyaXN0YXQuYyAgICAgICAgfCAxMjkgKysrKysr
KysrKysrKysrKystDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCg0KPiAtLQ0KPiAyLjM0LjENCg0K
