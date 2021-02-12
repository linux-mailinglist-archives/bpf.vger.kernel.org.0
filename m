Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B253E31A276
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhBLQQV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 11:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBLQQT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 11:16:19 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A78C061574
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 08:15:37 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id u8so6751448qvm.5
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=ahB6/7Gq/h9v1DFgh8qWSrgBGPTGy9CC5B0P9rGS7P0=;
        b=vjpt0pBpj4SvkEch5tTsHS3y7qcd56FqPLXnn+o3w1s4B0emMy/g1qqiFW/jkqdcE+
         tVdwK0SJ/4fTjJ6JKOYMiFcul1HfL4tHGF6Y+LSduIdFtM0TubphrIxG4SzB8X522mrl
         gv0rLn6R++rxVuDIJRBApFswXqYE4aVhUvAp34uymd3FKqKC8DMWk3vgoypfG+Iflq5u
         c80MvPvnvKfjxIS3OnGfsBOMOupGh5X0rTlJpmv9ieZQpeFLhWDhi0oDfGJRci8LW0yV
         KrTVx+tbj6fVsPZExZn5b9vgsIJ9EZoymSPQfGc5XGEECdjG3Ihv5nXbkrsK8cparxAM
         M9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ahB6/7Gq/h9v1DFgh8qWSrgBGPTGy9CC5B0P9rGS7P0=;
        b=i0FNRtLB1HfDRfIAbOuj71P8wN9erehpN+FOW4gt1Rk+oFQob/N5Jf3QJMrI8JqHhs
         Zr0gP72po5iI79kM3XDVfFJZbCyBZBUi5ATTwxPVN+2W5rm9lOBp22OMpIETjrhk2Uzh
         kZMQ25shNMCuqdCjVkJn1dy6n3F9MkTDfNkU2cAkyHiHLjMCpHAvQkuem1dCsaUfPE9u
         nEJypvEyOkh8OZAlIT37s4MjySzdHicqTiCXA86a1k6majbWgtG+/Gs2kFdy18TXcGMO
         YProhYVL23gio964OmNSRuyMs4SzLVyxMM21p3oEHuG3RrrF37I08LSMPOqeX2RqzcLM
         glmQ==
X-Gm-Message-State: AOAM5318vY7zY3hgGHHrc11d1/Ori5ef1JtKIn6btMn3RtwyFsyk4Gyb
        pk1Ib+YFRFw9M/gKhSPo/h5X/UQ=
X-Google-Smtp-Source: ABdhPJygaEHH2Zu1ZIcH+4pEgWFi4sQLbjkdVmP0PNR324CtTek8wnRBexnAVgovHxSbKUVihl+fv3s=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7009:7a82:4a5c:f303])
 (user=sdf job=sendgmr) by 2002:a05:6214:883:: with SMTP id
 cz3mr3093875qvb.43.1613146536223; Fri, 12 Feb 2021 08:15:36 -0800 (PST)
Date:   Fri, 12 Feb 2021 08:15:34 -0800
In-Reply-To: <CAJ+HfNhtZvvqj0pvEu0bysrwAvxngtC3z-2RUpP1HY3iU7gg5w@mail.gmail.com>
Message-Id: <YCappsaKUg6o1oSU@google.com>
Mime-Version: 1.0
References: <20210209221826.922940-1-sdf@google.com> <CAJ+HfNhtZvvqj0pvEu0bysrwAvxngtC3z-2RUpP1HY3iU7gg5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: use AF_LOCAL instead of AF_INET in xsk.c
From:   sdf@google.com
To:     "=?iso-8859-1?Q?Bj=F6rn_T=F6pel?=" <bjorn.topel@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDIvMTIsIEJq77+9cm4gVO+/vXBlbCB3cm90ZToNCj4gT24gVHVlLCA5IEZlYiAyMDIxIGF0
IDIzOjUwLCBTdGFuaXNsYXYgRm9taWNoZXYgPHNkZkBnb29nbGUuY29tPiB3cm90ZToNCj4gPg0K
PiA+IFdlIGhhdmUgdGhlIGVudmlyb25tZW50cyB3aGVyZSB1c2FnZSBvZiBBRl9JTkVUIGlzIHBy
b2hpYml0ZWQNCj4gPiAoY2dyb3VwL3NvY2tfY3JlYXRlIHJldHVybnMgRVBFUk0gZm9yIEFGX0lO
RVQpLiBMZXQncyB1c2UNCj4gPiBBRl9MT0NBTCBpbnN0ZWFkIG9mIEFGX0lORVQsIGl0IHNob3Vs
ZCBwZXJmZWN0bHkgd29yayB3aXRoIFNJT0NFVEhUT09MLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU3RhbmlzbGF2IEZvbWljaGV2IDxzZGZAZ29vZ2xlLmNvbT4NCg0KPiBTdGFuaXNsYXYsIGFw
b2xvZ2llcyBmb3IgdGhlIGRlbGF5IQ0KTm8gd29ycmllcywgdGhhbmsgeW91IGZvciB0aGUgcmV2
aWV3IGFuZCB0ZXN0aW5nIQ0KDQo+IFRlc3RlZC1ieTogQmrvv71ybiBU77+9cGVsIDxiam9ybi50
b3BlbEBpbnRlbC5jb20+DQo+IEFja2VkLWJ5OiBCau+/vXJuIFTvv71wZWwgPGJqb3JuLnRvcGVs
QGludGVsLmNvbT4NCg0KDQo+IEJq77+9cm4NCg0KPiA+IC0tLQ0KPiA+ICB0b29scy9saWIvYnBm
L3hzay5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL3hzay5jIGIvdG9v
bHMvbGliL2JwZi94c2suYw0KPiA+IGluZGV4IDIwNTAwZmIxZjE3ZS4uZmZiYjU4ODcyNGQ4IDEw
MDY0NA0KPiA+IC0tLSBhL3Rvb2xzL2xpYi9icGYveHNrLmMNCj4gPiArKysgYi90b29scy9saWIv
YnBmL3hzay5jDQo+ID4gQEAgLTUxNyw3ICs1MTcsNyBAQCBzdGF0aWMgaW50IHhza19nZXRfbWF4
X3F1ZXVlcyhzdHJ1Y3QgeHNrX3NvY2tldCAgDQo+ICp4c2spDQo+ID4gICAgICAgICBzdHJ1Y3Qg
aWZyZXEgaWZyID0ge307DQo+ID4gICAgICAgICBpbnQgZmQsIGVyciwgcmV0Ow0KPiA+DQo+ID4g
LSAgICAgICBmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsNCj4gPiArICAgICAg
IGZkID0gc29ja2V0KEFGX0xPQ0FMLCBTT0NLX0RHUkFNLCAwKTsNCj4gPiAgICAgICAgIGlmIChm
ZCA8IDApDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtZXJybm87DQo+ID4NCj4gPiAtLQ0K
PiA+IDIuMzAuMC40NzguZzhhMGQxNzhjMDEtZ29vZw0KPiA+DQo=
