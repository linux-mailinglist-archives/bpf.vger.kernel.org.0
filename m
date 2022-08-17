Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A9596D6E
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiHQLU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiHQLUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 07:20:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB55A8A9;
        Wed, 17 Aug 2022 04:20:51 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-334dc616f86so48917887b3.8;
        Wed, 17 Aug 2022 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Cdj7sd7Vseh67Y++OGPDaeXR5QZkIAKnNJCyIZLL+8g=;
        b=G0kOJTKrJLLMyCKszRSogMsoii1QRm6S4QeYC+118pDT2IxIoZZ7IXBFM79xu84vk7
         lk//8r9Q5gwLjGjNopycso6JlMGQmp+4nfDURp3ispAPr0xHP7KAHw9d+2nqUxYhOXAB
         xALsmhhsygJAXPkhYATp7wFCKqIq2DP6bMaX7qnkoxNsVtwYEBJU0tj2ZEMv9DbyDACF
         K46zNym8dh0KhMYMKsB3HzFWDeZQsI2+EYdXgTLXTuy8egPr/ihLtUM4VH70Dooxg1iE
         0HkXHw5ACDMZl/TeUTSZsalprSv/kBZFtsRRZfnRjN+QskvzgwSEMQ0jwzoMtLkEdBwW
         x2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Cdj7sd7Vseh67Y++OGPDaeXR5QZkIAKnNJCyIZLL+8g=;
        b=8IQMMGdlYAtDym3sJzNmgP+61xijkKJOF/uK5CznOYzRR1SFEia73jUabkDlmlrd/r
         2sQ4VzkKJ06fGoaLQpN8t/nSZheYIGGOgariajXfXgMcFNdfW8JvqhjSxXV7vukLq3Y1
         QCFskcfi8mha3Rn0GudhTvO6qjnI8O46ki/f9nfTHu8iR5cRZe6q4YyztGBPGPmwIk6d
         ONzhBJe7ju77GcijQeezD4pX4DVY0iX4hzczy9Lvf4d+PVUIqG6ccOgmuGJmU4YRr0iv
         DyIphyCT8UWXOmwl71xP0UDo5abpI03PlK09n8F93BrF0bOkaPXxehKxWzstFei8DIP0
         w97g==
X-Gm-Message-State: ACgBeo3TysOKahEM/ULhAC8cHseMZdELvhdswvXITFOZRvFVKOeLBaJq
        1a6UHZmDEGmUbu2qH+PPLyZrAJ5v5/4XsGQaKZw=
X-Google-Smtp-Source: AA6agR4RBgAqZTx3/3jP+L6WNm/r0Oop0W7bQPt0uDVLg33HoFgvAVfqqzRwxUiVY2bIpMS+v3lVVYDPGcwu/q3/7ng=
X-Received: by 2002:a0d:eb0d:0:b0:334:2945:2c1 with SMTP id
 u13-20020a0deb0d000000b00334294502c1mr4944372ywe.104.1660735250856; Wed, 17
 Aug 2022 04:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <5c9edecd-762a-221b-7aa0-f5c2025d32d4@westermo.com>
In-Reply-To: <5c9edecd-762a-221b-7aa0-f5c2025d32d4@westermo.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 17 Aug 2022 13:20:40 +0200
Message-ID: <CAKXUXMzzXKsXDHe8mZr53Af49=0wpz1-MJYhFNwKS5hvL7Zxyw@mail.gmail.com>
Subject: Re: False-positive in Checkpatch
To:     Matthias May <matthias.may@westermo.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCBBdWcgMTcsIDIwMjIgYXQgMTA6MjkgQU0gTWF0dGhpYXMgTWF5IDxtYXR0aGlhcy5t
YXlAd2VzdGVybW8uY29tPiB3cm90ZToNCj4NCj4gSGkgQ2hlY2twYXRjaCBNYWludGFpbmVycw0K
Pg0KPiBUaGUgc2VsZnRlc3QgcGF0Y2ggYXQNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0
ZGV2LzIwMjIwODE3MDczNjQ5LjI2MTE3LTEtbWF0dGhpYXMubWF5QHdlc3Rlcm1vLmNvbS9ULyN1
DQo+IGNsYWltcyB0b28gbG9uZyBsaW5lcy4NCj4gSG93ZXZlciB0aGlzIHNlZW1zIHRvIGJlIGEg
bWlzaW50ZXJwcmV0YXRpb24gb2YgdGhlIGluZGVudGlvbiBiZWZvcmUgdGhlIHByaW50ZiBzcGxp
dCBvdmVyIDINCj4gbGluZXMgdG8gZXhhY3RseSBub3QgaGF2ZSB0b28gbG9uZyBsaW5lcy4NCj4g
VGhlIGZhbHNlIHBvc2l0aXZlIGNoZWNrcGF0Y2ggcmVzdWx0cyBhcmUgYWxzbyBvbiB0aGUgbmV0
ZGV2IHBhdGNod29yazoNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25l
dGRldmJwZi9wYXRjaC8yMDIyMDgxNzA3MzY0OS4yNjExNy0xLW1hdHRoaWFzLm1heUB3ZXN0ZXJt
by5jb20vDQo+DQoNCkhpIE1hdHRoaWFzLA0KDQpUaGFua3MgZm9yIHJlcG9ydGluZy4gSSB0cmll
ZCBjaGVja3BhdGNoIG9uIHRoaXMgcmVmZXJyZWQgcGF0Y2ggYW5kDQpjYW4gY29uZmlybSB0aGF0
IGl0IHJlcG9ydHM6DQoNCldBUk5JTkc6IGxpbmUgbGVuZ3RoIG9mIDEzMiBleGNlZWRzIDEwMCBj
b2x1bW5zDQojNDEzOiBGSUxFOiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbDJfdG9zX3R0
bF9pbmhlcml0LnNoOjM1OToNCitwcmludGYgIuKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
rOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrCINCg0KV0FSTklORzogbGluZSBs
ZW5ndGggb2YgMTA3IGV4Y2VlZHMgMTAwIGNvbHVtbnMNCiM0MTQ6IEZJTEU6IHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL25ldC9sMl90b3NfdHRsX2luaGVyaXQuc2g6MzYwOg0KK3ByaW50ZiAi4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQXG4iDQoNCldBUk5JTkc6IGxpbmUg
bGVuZ3RoIG9mIDE0OCBleGNlZWRzIDEwMCBjb2x1bW5zDQojNDIwOiBGSUxFOiB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9uZXQvbDJfdG9zX3R0bF9pbmhlcml0LnNoOjM2NjoNCisgcHJpbnRmICLi
lJzilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilLzilIDi
lIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilLwiDQoNCldBUk5JTkc6IGxpbmUgbGVuZ3RoIG9mIDEyMyBleGNlZWRzIDEwMCBjb2x1
bW5zDQojNDIxOiBGSUxFOiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbDJfdG9zX3R0bF9p
bmhlcml0LnNoOjM2NzoNCisgcHJpbnRmICLilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDi
lIDilIDilKRcbiINCg0KV0FSTklORzogbGluZSBsZW5ndGggb2YgMTU2IGV4Y2VlZHMgMTAwIGNv
bHVtbnMNCiM0MjU6IEZJTEU6IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9sMl90b3NfdHRs
X2luaGVyaXQuc2g6MzcxOg0KKyBwcmludGYgIuKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
vOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvCINCg0KV0FSTklORzogbGluZSBs
ZW5ndGggb2YgMTMxIGV4Y2VlZHMgMTAwIGNvbHVtbnMNCiM0MjY6IEZJTEU6IHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL25ldC9sMl90b3NfdHRsX2luaGVyaXQuc2g6MzcyOg0KKyBwcmludGYgIuKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpFxuIg0KDQpXQVJOSU5HOiBsaW5l
IGxlbmd0aCBvZiAxMzIgZXhjZWVkcyAxMDAgY29sdW1ucw0KIzQzOTogRklMRTogdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbmV0L2wyX3Rvc190dGxfaW5oZXJpdC5zaDozODU6DQorcHJpbnRmICLi
lJTilIDilIDilIDilIDilIDilIDilIDilIDilLTilIDilIDilIDilIDilIDilIDilIDilLTilIDi
lIDilIDilIDilIDilIDilIDilLTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilLQiDQoNCldBUk5JTkc6IGxpbmUgbGVuZ3RoIG9mIDEwNyBleGNlZWRzIDEwMCBjb2x1
bW5zDQojNDQwOiBGSUxFOiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbDJfdG9zX3R0bF9p
bmhlcml0LnNoOjM4NjoNCitwcmludGYgIuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUmFxuIg0KDQoNCkluIG15IGVkaXRvciAodmltKSwgdGhlc2UgbGluZXMgYXJlIHJhdGhl
ciBzaG9ydCBidXQgaXQgc2VlbXMgdGhlIHJlYWwNCmxpbmUgbnVtYmVyIGlzIG11Y2ggbGFyZ2Vy
Lg0KDQpGb3IgZXhhbXBsZSwgaW4gbGluZSA0MjAsIHZpbSBzdGF0ZXMgIjQyMCwxMzUtNjYiIGF0
IHRoZSBlbmQgb2YgdGhlDQpsaW5lLiBTbywgdGhlcmUgYXJlIGNsZWFybHkgZGlmZmVyZW50IHdh
eXMgb2YgY291bnRpbmcgdGhlIG51bWJlciBvZg0KY2hhcmFjdGVycyB0aGlzIGxpbmUgaGFzLiBJ
IHRoaW5rIHRoYXQgYXQgbGVhc3QgZXhwbGFpbnMgaXQsIEkgcmVhbGx5DQpkbyBub3Qga25vdyB3
aGljaCB3YXkgb2YgY291bnRpbmcgaXMgdGhlIGJlc3QsIHRob3VnaC4NCg0KTHVrYXMNCg==
