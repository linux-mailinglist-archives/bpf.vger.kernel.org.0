Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1776969835C
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 19:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBOSdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 13:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBOSdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 13:33:43 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D69392AC
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:33:42 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p4-20020a654904000000b004fb64e929f2so5526845pgs.7
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676486022;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UXTvWwUFJWr5BzlgUFMsM18ujQqqLYolMUOknwRGJg=;
        b=W/Ih9D6nPk4LWSTgKRVtAhgmh/04VKATBtUdyECOK+FsIVvWDvP3OjJbmMnI98sPLG
         +p9ZXP2UcdDXFUSWkw558phr78z6IqYxluIvZIgrfDzzq0gBpup4Ei65FfDidYtKNVdi
         mg24cIO9ipFRvItHHhFpv5Ck8FR2zf3oAzIhFpPm3JEAkGt0whobDY03+9rqxoGaC2ew
         xec0h2GsRq6BNuBShHjiDMf0psvCx+1NbJ+T5nrb1NfVJqfdMkCMLuXu8QniA9bIv/We
         0GYgG1vqim5FEnAxnM9axnTiS/Yb4bSDT9HCm82llzBacyuBTyWjpVZ0bSt7U0xqK4oy
         8PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676486022;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6UXTvWwUFJWr5BzlgUFMsM18ujQqqLYolMUOknwRGJg=;
        b=gra+uEcsdz7w4k81Q78C67FbAMQZ+yfme+leasBL7XAxZ5O/Vj9n2yyjkhSjzL+uaV
         8AbaymH6wuAKIIuzf9jJJ/WhjvTGZ+lLUmQBmM4srxWN80ZyUE19R8UA7QiDcX1TyUoV
         fJqNnwBf8/2kr3YrF5DAFQyHyeI9aTX2kX5l9lnBVIa5fwAclhB+oShC1br9185P5Syp
         d/FAkGLjEJOxIfKPfKdgLub/OonLp7f77K/yTDMMyexdNKY6Ms7gzZEZh9fNKxgh12hj
         4RNuxrgcLCGHlXZDSDNGJmmuyM/1nWnFomd3geReeLGgihH/HiiSkb1NSk6Uj24bAmDT
         AL4A==
X-Gm-Message-State: AO0yUKUS+TBsel713LANnG5Mbz2Jyz4vcNkDcRLqSqZXKosWmQiXHgGg
        Yl5DLNdjx9vygDa9B5spO7NBmjU=
X-Google-Smtp-Source: AK7set8ntGxePsKnOHIgmjUqnnPnKjhMl2BBkaLRrXFaw3WtaMT+san0Pcb4a+86BEaytfVQ7A5EleY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8f04:0:b0:592:5d81:8306 with SMTP id
 x4-20020aa78f04000000b005925d818306mr540460pfr.18.1676486021967; Wed, 15 Feb
 2023 10:33:41 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:33:40 -0800
In-Reply-To: <33d548b6b265af07b7578c529e09751b58fe92ed.camel@linux.ibm.com>
Mime-Version: 1.0
References: <20230214212809.242632-1-iii@linux.ibm.com> <20230214212809.242632-2-iii@linux.ibm.com>
 <Y+wgDzf9zjfwgFwA@google.com> <7a2d61865e0fb1ef8db5bee8f7b95b3e983e59d4.camel@linux.ibm.com>
 <Y+0Zve9/LTWaZ96a@google.com> <33d548b6b265af07b7578c529e09751b58fe92ed.camel@linux.ibm.com>
Message-ID: <Y+0lhD1Um5K9Z1CG@google.com>
Subject: Re: [PATCH RFC bpf-next 1/1] bpf: Support 64-bit pointers to kfuncs
From:   Stanislav Fomichev <sdf@google.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
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

T24gMDIvMTUsIElseWEgTGVvc2hrZXZpY2ggd3JvdGU6DQo+IE9uIFdlZCwgMjAyMy0wMi0xNSBh
dCAwOTo0MyAtMDgwMCwgU3RhbmlzbGF2IEZvbWljaGV2IHdyb3RlOg0KPiA+IE9uIDAyLzE1LCBJ
bHlhIExlb3Noa2V2aWNoIHdyb3RlOg0KPiA+ID4gT24gVHVlLCAyMDIzLTAyLTE0IGF0IDE1OjU4
IC0wODAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6DQo+ID4gPiA+IE9uIDAyLzE0LCBJbHlh
IExlb3Noa2V2aWNoIHdyb3RlOg0KPiA+ID4gPiA+IHRlc3Rfa3N5bXNfbW9kdWxlIGZhaWxzIHRv
IGVtaXQgYSBrZnVuYyBjYWxsIHRhcmdldGluZyBhIG1vZHVsZQ0KPiA+ID4gPiA+IG9uDQo+ID4g
PiA+ID4gczM5MHgsIGJlY2F1c2UgdGhlIHZlcmlmaWVyIHN0b3JlcyB0aGUgZGlmZmVyZW5jZSBi
ZXR3ZWVuIGtmdW5jDQo+ID4gPiA+ID4gYWRkcmVzcyBhbmQgX19icGZfY2FsbF9iYXNlIGluIGJw
Zl9pbnNuLmltbSwgd2hpY2ggaXMgczMyLCBhbmQNCj4gPiA+ID4gPiBtb2R1bGVzDQo+ID4gPiA+
ID4gYXJlIHJvdWdobHkgKDEgPDwgNDIpIGJ5dGVzIGF3YXkgZnJvbSB0aGUga2VybmVsIG9uIHMz
OTB4Lg0KPiA+ID4gPg0KPiA+ID4gPiA+IEZpeCBieSBrZWVwaW5nIEJURiBpZCBpbiBicGZfaW5z
bi5pbW0gZm9yDQo+ID4gPiA+ID4gQlBGX1BTRVVET19LRlVOQ19DQUxMcywNCj4gPiA+ID4gPiBh
bmQgc3RvcmluZyB0aGUgYWJzb2x1dGUgYWRkcmVzcyBpbiBicGZfa2Z1bmNfZGVzYywgd2hpY2gg
SklUcw0KPiA+ID4gPiA+IHJldHJpZXZlDQo+ID4gPiA+ID4gYXMgdXN1YWwgYnkgY2FsbGluZyBi
cGZfaml0X2dldF9mdW5jX2FkZHIoKS4NCj4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGFsc28gZml4
ZXMgdGhlIHByb2JsZW0gd2l0aCBYRFAgbWV0YWRhdGEgZnVuY3Rpb25zDQo+ID4gPiA+ID4gb3V0
bGluZWQgaW4NCj4gPiA+ID4gPiB0aGUgZGVzY3JpcHRpb24gb2YgY29tbWl0IDYzZDdiNTNhYjU5
ZiAoInMzOTAvYnBmOiBJbXBsZW1lbnQNCj4gPiA+ID4gPiBicGZfaml0X3N1cHBvcnRzX2tmdW5j
X2NhbGwoKSIpIGJ5IHJlcGxhY2luZyBhZGRyZXNzIGxvb2t1cHMNCj4gPiA+ID4gPiB3aXRoDQo+
ID4gPiA+ID4gQlRGDQo+ID4gPiA+ID4gaWQgbG9va3Vwcy4gVGhpcyBlbGltaW5hdGVzIHRoZSBp
bmNvbnNpc3RlbmN5IGJldHdlZW4NCj4gPiA+ID4gPiAiYWJzdHJhY3QiDQo+ID4gPiA+ID4gWERQ
DQo+ID4gPiA+ID4gbWV0YWRhdGEgZnVuY3Rpb25zJyBCVEYgaWRzIGFuZCB0aGVpciBjb25jcmV0
ZSBhZGRyZXNzZXMuDQo+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSWx5YSBMZW9z
aGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g77+9
IGluY2x1ZGUvbGludXgvYnBmLmjvv73vv70gfO+/vSAyICsrDQo+ID4gPiA+ID4g77+9IGtlcm5l
bC9icGYvY29yZS5j77+977+977+977+9IHwgMjMgKysrKysrKysrKy0tLQ0KPiA+ID4gPiA+IO+/
vSBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgfCA3OSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiA+ID4gLS0tLQ0KPiA+ID4gPiA+IC0tLS0tDQo+ID4gPiA+ID4g77+9IDMg
ZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgNTkgZGVsZXRpb25zKC0pDQo+ID4gPg0K
DQo+IFsuLi5dDQoNCj4gPiA+ID4gPiAraW50IGJwZl9nZXRfa2Z1bmNfYWRkcihjb25zdCBzdHJ1
Y3QgYnBmX3Byb2cgKnByb2csIHUzMg0KPiA+ID4gPiA+IGZ1bmNfaWQsDQo+ID4gPiA+ID4gdTE2
77+9DQo+ID4gPiA+ID4gb2Zmc2V0LA0KPiA+ID4gPiA+ICvvv73vv73vv73vv73vv73vv73vv73v
v73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv73vv70gdTggKipmdW5jX2FkZHIp
DQo+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiAr77+977+977+977+977+977+977+9Y29uc3Qgc3Ry
dWN0IGJwZl9rZnVuY19kZXNjICpkZXNjOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr77+977+9
77+977+977+977+977+9ZGVzYyA9IGZpbmRfa2Z1bmNfZGVzYyhwcm9nLCBmdW5jX2lkLCBvZmZz
ZXQpOw0KPiA+ID4gPiA+ICvvv73vv73vv73vv73vv73vv73vv71pZiAoV0FSTl9PTl9PTkNFKCFk
ZXNjKSkNCj4gPiA+ID4gPiAr77+977+977+977+977+977+977+977+977+977+977+977+977+9
77+977+9cmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvvv73vv73vv73v
v73vv73vv73vv70qZnVuY19hZGRyID0gKHU4ICopZGVzYy0+YWRkcjsNCj4gPiA+ID4gPiAr77+9
77+977+977+977+977+977+9cmV0dXJuIDA7DQo+ID4gPiA+ID4gK30NCj4gPiA+ID4NCj4gPiA+
ID4gVGhpcyBmdW5jdGlvbiBpc24ndCBkb2luZyBtdWNoIGFuZCBoYXMgYSBzaW5nbGUgY2FsbGVy
LiBTaG91bGQgd2UNCj4gPiA+ID4ganVzdA0KPiA+ID4gPiBleHBvcnQgZmluZF9rZnVuY19kZXNj
Pw0KPiA+DQo+ID4gPiBXZSB3b3VsZCBoYXZlIHRvIGV4cG9ydCBzdHJ1Y3QgYnBmX2tmdW5jX2Rl
c2MgYXMgd2VsbDsgSSB0aG91Z2h0DQo+ID4gPiBpdCdzDQo+ID4gPiBiZXR0ZXIgdG8gYWRkIGFu
IGV4dHJhIGZ1bmN0aW9uIHNvIHRoYXQgd2UgY291bGQga2VlcCBoaWRpbmcgdGhlDQo+ID4gPiBz
dHJ1Y3QuDQo+ID4NCj4gPiBBaCwgZ29vZCBwb2ludC4gSW4gdGhpcyBjYXNlIHNlZW1zIG9rIHRv
IGhhdmUgdGhpcyBleHRyYSB3cmFwcGVyLg0KPiA+IE9uIHRoYXQgbm90ZTogd2hhdCdzIHRoZSBw
dXJwb3NlIG9mIFdBUk5fT05fT05DRSBoZXJlPw0KDQo+IFdlIGNhbiBoaXQgdGhpcyBvbmx5IGR1
ZSB0byBhbiBpbnRlcm5hbCB2ZXJpZmllci9KSVQgZXJyb3IsIHNvIGl0IHdvdWxkDQo+IGJlIGdv
b2QgdG8gZ2V0IHNvbWUgaW5kaWNhdGlvbiBvZiB0aGlzIGhhcHBlbmluZy4gSW4gdmVyaWZpZXIu
YyB3ZSBoYXZlDQo+IHZlcmJvc2UoKSBmdW5jdGlvbiBmb3IgdGhhdCwgYnV0IHRoaXMgZnVuY3Rp
b24gaXMgY2FsbGVkIGR1cmluZyBKSVRpbmcuDQoNCj4gWy4uLl0NCg0KIEZyb20gbXkgcG9pbnQg
b2YgdmlldywgcmVhZGluZyB0aGUgY29kZSwgaXQgbWFrZXMgaXQgYSBiaXQgY29uZnVzaW5nLiBJ
ZiAgDQp0aGVyZQ0KaXMgYSBXQVJOX09OX09OQ0UsIEknbSBhc3N1bWluZyBpdCdzIGd1YXJkaW5n
IGFnYWluc3Qgc29tZSBraW5kIG9mIGludGVybmFsDQppbmNvbnNpc3RlbmN5IHRoYXQgY2FuIGhh
cHBlbi4NCg0KV2hhdCBraW5kIG9mIGluY29uc2lzdGVuY3kgaXMgaXQgZ3VhcmRpbmcgYWdhaW5z
dCBoZXJlPyBXZSBzZWVtIHRvIGhhdmUNCmZpbmRfa2Z1bmNfZGVzYyBpbiBmaXh1cF9rZnVuY19j
YWxsIHRoYXQgY2hlY2tzIHRoZSBzYW1lIGluc24tPmltbQ0KYW5kIHJldHVybnMgZWFybHkuDQo=
