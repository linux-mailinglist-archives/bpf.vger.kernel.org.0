Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3DA27F5CC
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 01:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgI3XMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 19:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbgI3XMB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 19:12:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEB4C0613D1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 16:12:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j2so3649852eds.9
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5xNLcu2ZBibcOX9eRdIGOJeEwkJ0lfgOo9QwHDvHXzQ=;
        b=Qj7K/vkx1A15tnnaZGTfZl+ftwHdXkr1sOL1XvvbJjxZt6685kUiCjB86O17zRpzT+
         fjB3agEdH+lpJttlavg86WCDK/CZ/w8oa+3tm66zd471+mfvUnVBT4hdtV9fr6yowepg
         +X46wdd3diEHymNJT8fTyl2VcCe6QysxchzK/I0DHPed+T2YFKyVudi6rWQpwhEcD3et
         sd6uMoaB9fxNujxXaN2i+lH8Mzxt31C5S20E50O40rHcNBtvsXjvgoQYX09+AQJ5Z0i6
         m98jq1Z/UM0SauyOxFb+wrxUMwuh71pRjyiDIAwjbJtiW/Y3Mc80NcR6gKB3CqeK9jM1
         /Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5xNLcu2ZBibcOX9eRdIGOJeEwkJ0lfgOo9QwHDvHXzQ=;
        b=jPGa+spOdyXSn0Xvnz03K/I54UNra5XGKX5cLT2bysM6J5C9mo+IWGtrkvQ4oJuu7+
         w4wA1Ww6zUyzgcTXazPn+/FDHFMwOnlwFVDRzxvBFQKrkybjmSRCGTLPc8WmnhBe1nAN
         qwPDlrP5wTFnn5WXtbDyOlF68Yg2HDxXHcRI8WtsMSiHxXMjXIEh+aiQITrAJA/VIYdA
         +bMGVIBUZaOS6hSKtH7sehVmZM2IKqgRZyfbS6v2FH+8EP55ib9+83Q2eQTmgEEFeAUt
         1CgMMEiBHUNbsU3VzWnA7jgj58DBjexnbUaT5PYgosG24dAcUoxdiynTgkShWDncp2Dd
         ZEkA==
X-Gm-Message-State: AOAM531cibNMl3O3+vJ4Z7pQFtnB5SvQnkHXyQ0LOf1Cy9441RVY5D//
        rC0s1z7o9feFgXSHN0p0d3Y69jwPLes5X8vAIqpR4w==
X-Google-Smtp-Source: ABdhPJwrGlHwTQPZ++L0mLOF85y9/7LbEqNJ1w3mzMjO76tBkyLKmj9U5lGPSOwZW9qqkPLK2MLrOgZEPPp5jfWkAiQ=
X-Received: by 2002:a50:e807:: with SMTP id e7mr5401960edn.84.1601507519254;
 Wed, 30 Sep 2020 16:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
In-Reply-To: <20200930230327.GA1260245@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 01:11:33 +0200
Message-ID: <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCBPY3QgMSwgMjAyMCBhdCAxOjAzIEFNIFR5Y2hvIEFuZGVyc2VuIDx0eWNob0B0eWNo
by5waXp6YT4gd3JvdGU6DQo+IE9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0IDEwOjM0OjUxUE0gKzAy
MDAsIE1pY2hhZWwgS2VycmlzayAobWFuLXBhZ2VzKSB3cm90ZToNCj4gPiBPbiA5LzMwLzIwIDU6
MDMgUE0sIFR5Y2hvIEFuZGVyc2VuIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBTZXAgMzAsIDIwMjAg
YXQgMDE6MDc6MzhQTSArMDIwMCwgTWljaGFlbCBLZXJyaXNrIChtYW4tcGFnZXMpIHdyb3RlOg0K
PiA+ID4+ICAgICAgICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilJANCj4gPiA+PiAgICAgICAg4pSCRklYTUUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICDilIINCj4gPiA+PiAgICAgICAg4pSc4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkDQo+ID4gPj4gICAgICAgIOKUgkZy
b20gbXkgZXhwZXJpbWVudHMsICBpdCAgYXBwZWFycyAgdGhhdCAgaWYgIGEgIFNFQ+KAkCDilIIN
Cj4gPiA+PiAgICAgICAg4pSCQ09NUF9JT0NUTF9OT1RJRl9SRUNWICAgaXMgIGRvbmUgIGFmdGVy
ICB0aGUgIHRhcmdldCDilIINCj4gPiA+PiAgICAgICAg4pSCcHJvY2VzcyB0ZXJtaW5hdGVzLCB0
aGVuIHRoZSBpb2N0bCgpICBzaW1wbHkgIGJsb2NrcyDilIINCj4gPiA+PiAgICAgICAg4pSCKHJh
dGhlciB0aGFuIHJldHVybmluZyBhbiBlcnJvciB0byBpbmRpY2F0ZSB0aGF0IHRoZSDilIINCj4g
PiA+PiAgICAgICAg4pSCdGFyZ2V0IHByb2Nlc3Mgbm8gbG9uZ2VyIGV4aXN0cykuICAgICAgICAg
ICAgICAgICAgICDilIINCj4gPiA+DQo+ID4gPiBZZWFoLCBJIHRoaW5rIENocmlzdGlhbiB3YW50
ZWQgdG8gZml4IHRoaXMgYXQgc29tZSBwb2ludCwNCj4gPg0KPiA+IERvIHlvdSBoYXZlIGEgcG9p
bnRlciB0aGF0IGRpc2N1c3Npb24/IEkgY291bGQgbm90IGZpbmQgaXQgd2l0aCBhDQo+ID4gcXVp
Y2sgc2VhcmNoLg0KPiA+DQo+ID4gPiBidXQgaXQncyBhDQo+ID4gPiBiaXQgc3RpY2t5IHRvIGRv
Lg0KPiA+DQo+ID4gQ2FuIHlvdSBzYXkgYSBmZXcgd29yZHMgYWJvdXQgdGhlIG5hdHVyZSBvZiB0
aGUgcHJvYmxlbT8NCj4NCj4gSSByZW1lbWJlcmVkIHdyb25nLCBpdCdzIGFjdHVhbGx5IGluIHRo
ZSB0cmVlOiA5OWNkYjhiOWE1NzMgKCJzZWNjb21wOg0KPiBub3RpZnkgYWJvdXQgdW51c2VkIGZp
bHRlciIpLiBTbyBtYXliZSB0aGVyZSdzIGEgYnVnIGhlcmU/DQoNClRoYXQgdGhpbmcgb25seSBu
b3RpZmllcyBvbiAtPnBvbGwsIGl0IGRvZXNuJ3QgdW5ibG9jayBpb2N0bHM7IGFuZA0KTWljaGFl
bCdzIHNhbXBsZSBjb2RlIHVzZXMgU0VDQ09NUF9JT0NUTF9OT1RJRl9SRUNWIHRvIHdhaXQuIFNv
IHRoYXQNCmNvbW1pdCBkb2Vzbid0IGhhdmUgYW55IGVmZmVjdCBvbiB0aGlzIGtpbmQgb2YgdXNh
Z2UuDQo=
