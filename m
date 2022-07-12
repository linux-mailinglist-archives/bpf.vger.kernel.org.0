Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE400572980
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 00:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGLWvK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 18:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiGLWvK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 18:51:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE99CAF3A
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:51:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x12-20020a62fb0c000000b0052af899ae7cso446116pfm.6
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=VVFkg+NtjinRZrHhxZWZk7G1TX3O/wGrIEeGFKO3ln8=;
        b=aqWR1Wf2anv+qgzD/R2zLetgLMGuK/PAA7p0QwFiRpgaAR3ajHr+YcEynKtmTUrzvG
         czn02cYVLKiqR/Msat4iog3KuJ+o2RnYkikk3VZIrHkuPCODb6w5Hh7CImrkNPIjSMB1
         wLJe0g8DnAbkbsEkrI1Ppz7l6YRhMVQG8ndnLhfw1UH0SEHzpjNGFzFOLMqqMXUBpy78
         03R09Nb/49CKy1EMdoanWEBTvsKZf5JlxzAWRs8pXAZF/7KzL/nSpWQ34eZ+4AurBKhj
         ufQEHemTyVTsbCMfSI3rXZfu9so0W9m9HPJIE1fQYhaAjL0FaeHYSaA388EclhYAI3jH
         V+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=VVFkg+NtjinRZrHhxZWZk7G1TX3O/wGrIEeGFKO3ln8=;
        b=UGyAzkmKGKxKMxzuDtd57yyteJOvCB3ppXRMU2TdtafT0tZdH7z3H798GdTGhdPIhc
         LSPmXrF8q0dznpMQqTDHmAhvr+Z/waqibMLI8q9kphS39F0EEc85dWzZHNC9eAOOtx3x
         68SzWYcC5B5oxzHNNZrf68QyyTqK57K6LE50E30zQ9VIFz0ugPu5A9ALwaXgHYM11pAc
         KK+X1C1O0jGjokI2RemEpz07dBSW/WqxbfWU/YlRBbYOaxjebOJv52BTZo2drQkoM6l9
         +2wO3r3q3auGjmdsxI4+XuKHdJkObAZ/1omm+DB5nGVJd8wrid4wllggzel2f9u54cVu
         uYsg==
X-Gm-Message-State: AJIora8wvytWXrZZCRAOYbY1ibO2FUvgy5O8EXqsFwJGRuTvIAFFJPqr
        8514ZLCNlLx35RKH8OW4l7nnzJ4=
X-Google-Smtp-Source: AGRyM1teotprbLUA5Y4kzOssuvWECQTZ41UHNF/KYrWrCKv6YNd5KhIkL4hTpzY35vrFFKVHQusWa+o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:114c:b0:528:2c7a:630e with SMTP id
 b12-20020a056a00114c00b005282c7a630emr348786pfm.86.1657666268823; Tue, 12 Jul
 2022 15:51:08 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:51:06 -0700
In-Reply-To: <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
Message-Id: <Ys362q2b7J3hx1Zi@google.com>
Mime-Version: 1.0
References: <cover.1657576063.git.delyank@fb.com> <Ys24W4RJS0BAfKzP@google.com>
 <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
From:   sdf@google.com
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDcvMTIsIERlbHlhbiBLcmF0dW5vdiB3cm90ZToNCj4gVGhhbmtzIGZvciB0YWtpbmcgYSBs
b29rLCBTdGFuaXNsYXYhDQoNCj4gT24gVHVlLCAyMDIyLTA3LTEyIGF0IDExOjA3IC0wNzAwLCBz
ZGZAZ29vZ2xlLmNvbSB3cm90ZToNCj4gPiAqc25pcCoNCj4gPiA+IDIuIFRoZSBjYWxsYmFjayBh
cmd1bWVudHMgbmVlZCB0byBiZSBpbiBhIG1hcC4gV2UgY2FuIGN1cnJlbnRseSAgDQo+IGV4cHJl
c3MNCj4gPiA+IGhlbHBlciBhcmd1bWVudHMgdGFraW5nIGENCj4gPiA+IHBvaW50ZXIgdG8gYSBt
YXAgdmFsdWUgYnV0IG5vdCBhIHBvaW50ZXIgdG8gX3dpdGhpbl8gYSBtYXAgdmFsdWUuICANCj4g
U2hvdWxkDQo+ID4gPiB3ZSBhZGQgYSBuZXcgYXJndW1lbnQNCj4gPiA+IHR5cGUgb3Igc2hvdWxk
IHdlIGp1c3QgcGFzcyB0aGUgbWFwIHZhbHVlIHBvaW50ZXIgdG8gdGhlIGNhbGxiYWNrPw0KPiA+
DQo+ID4gUGFzc2luZyBtYXAgdmFsdWUgcG9pbnRlciAoYXMgeW91IGRvIGluIHRoZSBzZWxmdGVz
dCkgc2VlbXMgZmluZTsgZG8NCj4gPiB5b3UgdGhpbmsgd2UgbmVlZCBtb3JlIGZsZXhpYmlsaXR5
IGhlcmU/DQoNCj4gSSB0aGluayBpdCBtYWtlcyBhIGNsZWFuZXIgYW5kIG1vcmUgZmFtaWxpYXIg
QVBJIC0gdGhlIHBvaW50ZXIgdG8gbXkgZGF0YSAgDQo+IHRoYXQgSSBnaXZlDQo+IHRvIHRoZSBz
dWJtaXNzaW9uIGZ1bmN0aW9uIGlzIHRoZSBvbmUgSSBnZXQgaW4gdGhlIGNhbGxiYWNrLiBSZXF1
aXJpbmcgaXQgIA0KPiB0byBiZSBhIG1hcA0KPiB2YWx1ZSBpcyBhIGxpdHRsZSBiaXQgcXVpcmt5
IChpdCdzIG5vdCByZWFsbHkgbXkgZGF0YSBpdCdzIHBvaW50aW5nIHRvISkuICANCj4gSSBkb24n
dA0KPiBrbm93IGlmIGl0J3MgYSBsb3Qgb2Ygd29yayBpbiB0aGUgdmVyaWZpZXIgdG8gaXJvbiBv
dXQgdGhpcyBxdWlyayBidXQgaWYgIA0KPiBpdCdzDQo+IHJlYXNvbmFibGUsIEknZCBiZSBoYXBw
eSB0byBtYWtlIHRoZSBkZXZlbG9wZXIgZXhwZXJpZW5jZSBhIGxpdHRsZSBtb3JlICANCj4gcHJl
ZGljdGFibGUuDQoNCj4gPiA+IDMuIEEgbG90IG9mIHRoZSBtYXAgaGFuZGxpbmcgY29kZSBpcyB2
ZXJiYXRpbSBmcm9tIGJwZl90aW1lci4gVGhpcyAgDQo+IGZlZWxzDQo+ID4gPiBpY2t5IGJ1dCBJ
J20gbm90IHN1cmUgaWYgaXQNCj4gPiA+IGp1c3RpZmllcyBhIHJlZmFjdG9yIHF1aXRlIHlldC4g
T3BpbmlvbnMgd2VsY29tZS4NCj4gPg0KPiA+ICsxLCBpdCBkb2VzIHNlZW0gdmVyeSBjbG9zZSB0
byBhIHRpbWVyIHdpdGggZXhwaXJ5IHRpbWUgPT0gMC4NCj4gPg0KPiA+IEkgZG9uJ3Qga25vdyB3
aGF0J3MgdGhlIGV4YWN0IHVzZWNhc2UgeW91J3JlIHRyeWluZyB0byBzb2x2ZSBleGFjdGx5LA0K
DQo+IFRoZSBwcmltYXJ5IG1vdGl2YXRpbmcgZXhhbXBsZXMgYXJlIDEpIEdGUF9BVE9NSUMgdXNh
Z2UgaXMgbm90IHNhZmUgaW4gIA0KPiBOTUkgYWl1aSwgc28NCj4gc3dpdGNoaW5nIGFsbG9jYXRp
b25zIHRvIGhhcmRpcnEgaGVscHMgYW5kIDIpIGNvcHlfZnJvbV91c2VyIGluIHRyYWNpbmcgIA0K
PiBwcm9ncmFtcyAobm1pDQo+IG9yIHNvZnRpcnEgd2hlbiB1c2luZyBzb2Z0d2FyZSBjbG9ja3Mp
LiBUaGUgbGF0dGVyIHNob3dzIHVwIGluIGluc2lkaW91cyAgDQo+IHdheXMgbGlrZQ0KPiBidWls
ZCBpZCBub3QgYmVpbmcgcmVsaWFibGUgd2hlbiByZXRyaWV2aW5nIHN0YWNrIHRyYWNlcyAoWzFd
IGlzIGEgdGhyZWFkICANCj4gZnJvbSBhDQo+IHdoaWxlIGFnbyBhYm91dCBpdCkuDQoNCj4gPiBi
dXQgaGF2ZSB5b3UgdGhvdWdoIG9mIG1heWJlIGluaXRpYWxseSBzdXBwb3J0aW5nIHNvbWV0aGlu
ZyBsaWtlOg0KPiA+DQo+ID4gYnBmX3RpbWVyX2luaXQoJnRpbWVyLCBtYXAsIFNPTUVfTkVXX0RF
RkVSUkVEX05NSV9PTkxZX0ZMQUcpOw0KPiA+IGJwZl90aW1lcl9zZXRfY2FsbGJhY2soJnRpbWVy
LCBjZyk7DQo+ID4gYnBmX3RpbWVyX3N0YXJ0KCZ0aW1lciwgMCwgMCk7DQo+ID4NCj4gPiBJZiB5
b3UgaW5pdCBhIHRpbWVyIHdpdGggdGhhdCBzcGVjaWFsIGZsYWcsIEknbSBhc3N1bWluZyB5b3Ug
Y2FuIGhhdmUNCj4gPiBzcGVjaWFsIGNhc2VzIGluIHRoZSBleGlzdGluZyBoZWxwZXJzIHRvIHNp
bXVsYXRlIHRoZSBkZWxheWVkIHdvcms/DQoNCj4gUG90ZW50aWFsbHkgYnV0IEkgaGF2ZSBzb21l
IHJlc2VydmF0aW9ucyBhYm91dCBkcmF3aW5nIHRoaXMgZXF1aXZhbGVuY2UuDQoNCj4gPiBUaGVu
LCB0aGUgdmVyaWZpZXIgY2hhbmdlcyBzaG91bGQgYmUgbWluaW1hbCBpdCBzZWVtcy4NCj4gPg0K
PiA+IE9UT0gsIGhhdmluZyBhIHNlcGFyYXRlIHNldCBvZiBoZWxwZXJzIHNlZW1zIG1vcmUgY2xl
YXIgQVBJLXdpc2UgOi0vDQoNCj4gVGhlIHByaW1hcnkgd2F5IHRoaXMgZGlmZmVycyBmcm9tIHRp
bWVycyBpcyB0aGF0IHRpbWVycyBhbHJlYWR5IHNwZWNpZnkgIA0KPiBhbiBleGVjdXRpb24NCj4g
Y29udGV4dCAtIHRoZSBjYWxsYmFjayB3aWxsIGJlIGNhbGxlZCBmcm9tIGEgc29mdGlycS7vv70N
Cg0KPiBJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbWUgdG8gaGF2ZSBzb21lICJ0aW1lcnMiIChi
dXQgb25seSAwLWRlbGF5LCAgDQo+IHN1cGVyLXNwZWNpYWwNCj4gdGltZXJzKSBydW4gaW4gaGFy
ZGlycSBvciwgbW9yZSBjb25mdXNpbmdseSwgdXNlciBjb250ZXh0LiBBdCB0aGF0IHBvaW50LCAg
DQo+IHRoZXJlJ3MNCj4gbGl0dGxlIGluIHRoZSBBUEkgdG8gZXhwcmVzcyB0aGVzZSBkaWZmZXJl
bmNlcywgKGUuZy4sICANCj4gYnBmX2NvcHlfZnJvbV91c2VyX3Rhc2sgaXMNCj4gYWNjZXNzaWJs
ZSBpbiAqdGhpcyogY2FsbGJhY2spIGFuZCB0aGUgdmVyaWZpZXIgd29yayB3aWxsIGJlIGZhciBt
b3JlICANCj4gY2hhbGxlbmdpbmcgKGlmDQo+IGF0IGFsbCBwb3NzaWJsZSBzaW5jZSB0aGUgaW5p
dCBhbmQgdGhlIHNldF9jYWxsYmFjayB3b3VsZCBiZSBzcGxpdCkuDQoNCj4gSSB0aGluayBpdCdz
IHdvcnRoIHRoaW5raW5nIGFib3V0IGhvdyB0byB1bmlmeSB0aGUgaGFuZGxpbmcgb2YgdGltZXIt
bGlrZSAgDQo+IG1hcCB2YWx1ZQ0KPiBtZW1iZXJzIGJ1dCBJIGRvbid0IHRoaW5rIGl0J3Mgd29y
dGggaXQgdHJ5aW5nIHRvIHNob2Vob3JuIHRoaXMgIA0KPiBmdW5jdGlvbmFsaXR5IGludG8NCj4g
ZXhpc3RpbmcgaW5mcmEuDQoNCj4gPiAqc25pcCoNCg0KPiAgICBbMV06ICANCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYnBmL0NBK2toVzdnaD12TzhtLV9TVm53V3dqN2t2K0VEZVVQY3VXRnFl
YmYyWm1pOVRfb0VBUUBtYWlsLmdtYWlsLmNvbS8NCg0KDQpBbGwgdmFsaWQgcG9pbnRzLiBJJ20g
YXNzdW1pbmcgQWxleGVpIHdpbGwgdGFrZSBhIGNsb3NlciBsb29rIGF0IHRoaXMNCmV2ZW50dWFs
bHkgc2luY2UgSSBkb24ndCBoYXZlIGEgdG9uIG9mIGNvbnRleHQgYWJvdXQgdGltZXJzIDotKA0K
