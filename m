Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2054D073
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346892AbiFORzg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 13:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiFORze (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 13:55:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC746648
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 10:55:33 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p2-20020a170902e74200b00164081f682cso6871255plf.16
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=hi5+WjPBBPhVXk5dzlXBg5LfGzP8Fl/FiotSQZmIZsU=;
        b=HH71z6mqLi4LAzbq2H2pBg1+WysJ1Fpk0YKhxIDKZiW8grX8qFTwLkzpu4Zr6Svk5v
         pc0WSGwxd2tIbvBtXrwyp08uxxnfnKVimFdUB8EK2GWBqv07HMnpZxMem3uZKY/c/Xpi
         rDWzsiCkWf4k32zYFQELtlhaHRSsV8rKYzk9aZ7E+NmiosqLfc0pYTzcP9hRozEZbLt/
         9AFIdYxcWIEixF/LmC+jsVs5dvvX4XMi/EwzqXPbiJmrK4XJdASH4bVprTn+lmXADxIV
         VzpGlNfXl2GzvptzyFb5RIQ/VUVlr8xyVJouj0VyH7QH6z1cwNJ4ohZAaUOuRFp1XhtA
         ZE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=hi5+WjPBBPhVXk5dzlXBg5LfGzP8Fl/FiotSQZmIZsU=;
        b=4ZJN6h+NkwoCiPaTFO+FxM18a1IQm8EqUqiv9mI5q5jgfl2PpnTMwTE6CpcU9oGXgk
         IgXkP4QpqyUUGGztpXrJ4Zck0ISUaa73jWTBZEm2gtY5tDGziOMsWRL3G9k/tazoUq7F
         uoeB1pdMQ1add/10aAxsQMoSuO+oGWrXy91Zt3QHLa7JRaUjm8KFSiT3yULF3rZl9TlL
         wx6nhwVVp8LhcRvUtZYCwmCHJEb5o4P8K2oT3MVUzyfjunGmMTk0bAs59ROP7qvxJ18q
         1CzdmbV4YjwmKD/Uv4KcQ0fSqhU6MCRcM7SUwMz0j5OTy6chJZ5KP55kos81AQja1mjK
         z7RQ==
X-Gm-Message-State: AJIora/ux4EALjwOUXHwRR2nuB9CsM+pg6phtKkbYwwTJsEb1NmyCQla
        KD+ncTo9Onabq9b5S1t5sE2hYEI=
X-Google-Smtp-Source: AGRyM1sG31ABh2goKI0DjrBHX51fvngwBFc3Ig6vRDAw/MaVJZ7ZrIib+VKqOhfi81fb48jEcV26Z/U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id
 l3-20020a17090ab70300b001dd1e2f97d7mr11559130pjr.62.1655315733027; Wed, 15
 Jun 2022 10:55:33 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:55:31 -0700
In-Reply-To: <CANP3RGcZ4NULOwe+nwxfxsDPSXAUo50hWyN9Sb5b_d=kfDg=qg@mail.gmail.com>
Message-Id: <YqodE5lxUCt6ojIw@google.com>
Mime-Version: 1.0
References: <CAHo-Ooy+8O16k0oyMGHaAcmLm_Pfo=Ju4moTc95kRp2Z6itBcg@mail.gmail.com>
 <CANP3RGed9Vbu=8HfLyNs9zwA=biqgyew=+2tVxC6BAx2ktzNxA@mail.gmail.com>
 <CAADnVQKBqjowbGsSuc2g8yP9MBANhsroB+dhJep93cnx_EmNow@mail.gmail.com> <CANP3RGcZ4NULOwe+nwxfxsDPSXAUo50hWyN9Sb5b_d=kfDg=qg@mail.gmail.com>
Subject: Re: Curious bpf regression in 5.18 already fixed in stable 5.18.3
From:   sdf@google.com
To:     "Maciej =?utf-8?Q?=C5=BBenczykowski?=" <maze@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linux NetDev <netdev@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>,
        Carlos Llamas <cmllamas@google.com>
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

T24gMDYvMTUsIE1hY2llaiDFu2VuY3p5a293c2tpIHdyb3RlOg0KPiBPbiBXZWQsIEp1biAxNSwg
MjAyMiBhdCAxMDozOCBBTSBBbGV4ZWkgU3Rhcm92b2l0b3YNCj4gPGFsZXhlaS5zdGFyb3ZvaXRv
dkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgOTo1
NyBBTSBNYWNpZWogxbtlbmN6eWtvd3NraSA8bWF6ZUBnb29nbGUuY29tPiAgDQo+IHdyb3RlOg0K
PiA+ID4gPg0KPiA+ID4gPiBJJ3ZlIGNvbmZpcm1lZCB2YW5pbGxhIDUuMTguMCBpcyBicm9rZW4s
IGFuZCBhbGwgaXQgdGFrZXMgaXMNCj4gPiA+ID4gY2hlcnJ5cGlja2luZyB0aGF0IHNwZWNpZmlj
IHN0YWJsZSA1LjE4LnggcGF0Y2ggWw0KPiA+ID4gPiA3MTBhODk4OWI0YjQwNjc5MDNmNWI2MTMx
NGVkYTQ5MTY2N2I2YWIzIF0gdG8gZml4IGJlaGF2aW91ci4NCj4gPiAuLi4NCj4gPiA+IGI4YmQz
ZWUxOTcxZDFlZGJjNTNjZjMyMmMxNDljYTAyMjc0NzJlNTYgdGhpcyBpcyB3aGVyZSB3ZSBhZGRl
ZCAgDQo+IEVGQVVMVCBpbiA1LjE2DQo+ID4NCj4gPiBUaGVyZSBhcmUgbm8gc3VjaCBzaGEtcyBp
biB0aGUgdXBzdHJlYW0ga2VybmVsLg0KPiA+IFNvcnJ5IHdlIGNhbm5vdCBoZWxwIHdpdGggZGVi
dWdnaW5nIG9mIGFuZHJvaWQga2VybmVscy4NCg0KPiBZZXMsIHNkZkAgcXVvdGVkIHRoZSB3cm9u
ZyBzaGExLCBpdCdzIGEgY2xlYW4gY2hlcnJ5cGljayB0byBhbg0KPiBpbnRlcm5hbCBicmFuY2gg
b2YNCj4gJ2JwZjogQWRkIGNncm91cCBoZWxwZXJzIGJwZl97Z2V0LHNldH1fcmV0dmFsIHRvIGdl
dC9zZXQgc3lzY2FsbCByZXR1cm4gIA0KPiB2YWx1ZScNCj4gY29tbWl0IGI0NDEyM2I0YTNkY2Fk
NDY2NGQzYTBmNzJjMDExZmZkNGM5YzRkOTMuDQoNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9bGludXgt
NS4xNi55JmlkPWI0NDEyM2I0YTNkY2FkNDY2NGQzYTBmNzJjMDExZmZkNGM5YzRkOTMNCg0KPiBB
bnl3YXksIEkgdGhpbmsgaXQncyB1bnJlbGF0ZWQgLSBvciBhdCBsZWFzdCBub3QgdGhlIGltbWVk
aWF0ZSByb290IGNhdXNlLg0KDQo+IEFsc28gdGhlcmUncyAqbm8qIEFuZHJvaWQga2VybmVscyBp
bnZvbHZlZCBoZXJlLg0KPiBUaGlzIGlzIHRoZSBhbmRyb2lkIG5ldCB0ZXN0cyBmYWlsaW5nIG9u
IHZhbmlsbGEgNS4xOCBhbmQgcGFzc2luZyBvbiAgDQo+IDUuMTguMy4NCg0KWWVhaCwgc29ycnks
IGRpZG4ndCBtZWFuIHRvIHNlbmQgdGhvc2Ugb3V0c2lkZSA6LSkNCg0KQXR0YWNoZWQgdW4tYW5k
cm9pZC1pZmllZCB0ZXN0Y2FzZS4gUGFzc2VzIG9uIGJwZi1uZXh0LCB0cnlpbmcgdG8gc2VlDQp3
aGF0IGhhcHBlbnMgb24gdmFuaWxsYSA1LjE4LiBXaWxsIHVwZGF0ZSBvbmNlIEkgZ2V0IG1vcmUg
ZGF0YS4uDQoNCi0tIA0KDQojIS91c3IvYmluL3B5dGhvbjIuNw0KIyBleHRyYWN0ZWQgc25pcHBl
dCBmcm9tIEFPU1AsIEFwYWNoZTIgbGljZW5zZWQNCg0KaW1wb3J0IGN0eXBlcw0KaW1wb3J0IGN0
eXBlcy51dGlsDQppbXBvcnQgcmUNCmltcG9ydCBlcnJubw0KaW1wb3J0IG9zDQppbXBvcnQgcGxh
dGZvcm0NCmltcG9ydCBzdHJ1Y3QNCmltcG9ydCBzb2NrZXQNCmltcG9ydCB1bml0dGVzdA0KDQpf
X05SX2JwZiA9IHsgICMgcHlsaW50OiBkaXNhYmxlPWludmFsaWQtbmFtZQ0KICAgICAiYWFyY2g2
NC0zMmJpdCI6IDM4NiwNCiAgICAgImFhcmNoNjQtNjRiaXQiOiAyODAsDQogICAgICJhcm12N2wt
MzJiaXQiOiAzODYsDQogICAgICJhcm12OGwtMzJiaXQiOiAzODYsDQogICAgICJhcm12OGwtNjRi
aXQiOiAyODAsDQogICAgICJpNjg2LTMyYml0IjogMzU3LA0KICAgICAiaTY4Ni02NGJpdCI6IDMy
MSwNCiAgICAgIng4Nl82NC0zMmJpdCI6IDM1NywNCiAgICAgIng4Nl82NC02NGJpdCI6IDMyMSwN
Cn1bb3MudW5hbWUoKVs0XSArICItIiArIHBsYXRmb3JtLmFyY2hpdGVjdHVyZSgpWzBdXQ0KDQpM
T0dfTEVWRUwgPSAxDQpMT0dfU0laRSA9IDY1NTM2DQoNCkJQRl9QUk9HX0xPQUQgPSA1DQpCUEZf
UFJPR19BVFRBQ0ggPSA4DQpCUEZfUFJPR19ERVRBQ0ggPSA5DQoNCkJQRl9QUk9HX1RZUEVfQ0dS
T1VQX1NLQiA9IDgNCg0KQlBGX0NHUk9VUF9JTkVUX0VHUkVTUyA9IDENCg0KQlBGX1JFR18wID0g
MA0KDQpCUEZfSk1QID0gMHgwNQ0KQlBGX0sgPSAweDAwDQpCUEZfQUxVNjQgPSAweDA3DQpCUEZf
TU9WID0gMHhiMA0KQlBGX0VYSVQgPSAweDkwDQoNCg0KZGVmIENhbGNTaXplKGZtdCk6DQogICBp
ZiAiQSIgaW4gZm10Og0KICAgICBmbXQgPSBmbXQucmVwbGFjZSgiQSIsICJzIikNCiAgICMgUmVt
b3ZlIHRoZSBsYXN0IGRpZ2l0YWwgc2luY2UgaXQgd2lsbCBjYXVzZSBlcnJvciBpbiBweXRob24z
Lg0KICAgZm10ID0gKHJlLnNwbGl0KCdcZCskJywgZm10KVswXSkNCiAgIHJldHVybiBzdHJ1Y3Qu
Y2FsY3NpemUoZm10KQ0KDQpkZWYgQ2FsY051bUVsZW1lbnRzKGZtdCk6DQogICBwcmV2bGVuID0g
bGVuKGZtdCkNCiAgIGZtdCA9IGZtdC5yZXBsYWNlKCJTIiwgIiIpDQogICBudW1zdHJ1Y3RzID0g
cHJldmxlbiAtIGxlbihmbXQpDQogICBzaXplID0gQ2FsY1NpemUoZm10KQ0KICAgZWxlbWVudHMg
PSBzdHJ1Y3QudW5wYWNrKGZtdCwgYiJceDAwIiAqIHNpemUpDQogICByZXR1cm4gbGVuKGVsZW1l
bnRzKSArIG51bXN0cnVjdHMNCg0KDQpkZWYgU3RydWN0KG5hbWUsIGZtdCwgZmllbGRuYW1lcywg
c3Vic3RydWN0cz17fSk6DQogICAiIiJGdW5jdGlvbiB0aGF0IHJldHVybnMgc3RydWN0IGNsYXNz
ZXMuIiIiDQoNCiAgIGNsYXNzIE1ldGEodHlwZSk6DQoNCiAgICAgZGVmIF9fbGVuX18oY2xzKToN
CiAgICAgICByZXR1cm4gY2xzLl9sZW5ndGgNCg0KICAgICBkZWYgX19pbml0X18oY2xzLCB1bnVz
ZWRfbmFtZSwgdW51c2VkX2Jhc2VzLCBuYW1lc3BhY2UpOg0KICAgICAgICMgTWFrZSB0aGUgY2xh
c3Mgb2JqZWN0IGhhdmUgdGhlIG5hbWUgdGhhdCdzIHBhc3NlZCBpbi4NCiAgICAgICB0eXBlLl9f
aW5pdF9fKGNscywgbmFtZXNwYWNlWyJfbmFtZSJdLCB1bnVzZWRfYmFzZXMsIG5hbWVzcGFjZSkN
Cg0KICAgY2xhc3MgQ1N0cnVjdChvYmplY3QpOg0KICAgICAiIiJDbGFzcyByZXByZXNlbnRpbmcg
YSBDLWxpa2Ugc3RydWN0dXJlLiIiIg0KDQogICAgIF9fbWV0YWNsYXNzX18gPSBNZXRhDQoNCiAg
ICAgIyBOYW1lIG9mIHRoZSBzdHJ1Y3QuDQogICAgIF9uYW1lID0gbmFtZQ0KICAgICAjIExpc3Qg
b2YgZmllbGQgbmFtZXMuDQogICAgIF9maWVsZG5hbWVzID0gZmllbGRuYW1lcw0KICAgICAjIERp
Y3QgbWFwcGluZyBmaWVsZCBpbmRpY2VzIHRvIG5lc3RlZCBzdHJ1Y3QgY2xhc3Nlcy4NCiAgICAg
X25lc3RlZCA9IHt9DQogICAgICMgTGlzdCBvZiBzdHJpbmcgZmllbGRzIHRoYXQgYXJlIEFTQ0lJ
IHN0cmluZ3MuDQogICAgIF9hc2NpaXogPSBzZXQoKQ0KDQogICAgIF9maWVsZG5hbWVzID0gX2Zp
ZWxkbmFtZXMuc3BsaXQoIiAiKQ0KDQogICAgICMgUGFyc2UgZm10IGludG8gX2Zvcm1hdCwgY29u
dmVydGluZyBhbnkgUyBmb3JtYXQgY2hhcmFjdGVycyB0byAiWFhzIiwNCiAgICAgIyB3aGVyZSBY
WCBpcyB0aGUgbGVuZ3RoIG9mIHRoZSBzdHJ1Y3QgdHlwZSdzIHBhY2tlZCByZXByZXNlbnRhdGlv
bi4NCiAgICAgX2Zvcm1hdCA9ICIiDQogICAgIGxhc3RzdHJ1Y3RpbmRleCA9IDANCiAgICAgZm9y
IGkgaW4gcmFuZ2UobGVuKGZtdCkpOg0KICAgICAgIGlmIGZtdFtpXSA9PSAiUyI6DQogICAgICAg
ICAjIE5lc3RlZCBzdHJ1Y3QuIFJlY29yZCB0aGUgaW5kZXggaW4gb3VyIHN0cnVjdCBpdCBzaG91
bGQgZ28gaW50by4NCiAgICAgICAgIGluZGV4ID0gQ2FsY051bUVsZW1lbnRzKGZtdFs6aV0pDQog
ICAgICAgICBfbmVzdGVkW2luZGV4XSA9IHN1YnN0cnVjdHNbbGFzdHN0cnVjdGluZGV4XQ0KICAg
ICAgICAgbGFzdHN0cnVjdGluZGV4ICs9IDENCiAgICAgICAgIF9mb3JtYXQgKz0gIiVkcyIgJSBs
ZW4oX25lc3RlZFtpbmRleF0pDQogICAgICAgZWxpZiBmbXRbaV0gPT0gIkEiOg0KICAgICAgICAg
IyBOdWxsLXRlcm1pbmF0ZWQgQVNDSUkgc3RyaW5nLg0KICAgICAgICAgaW5kZXggPSBDYWxjTnVt
RWxlbWVudHMoZm10WzppXSkNCiAgICAgICAgIF9hc2NpaXouYWRkKGluZGV4KQ0KICAgICAgICAg
X2Zvcm1hdCArPSAicyINCiAgICAgICBlbHNlOg0KICAgICAgICAgIyBTdGFuZGFyZCBzdHJ1Y3Qg
Zm9ybWF0IGNoYXJhY3Rlci4NCiAgICAgICAgIF9mb3JtYXQgKz0gZm10W2ldDQoNCiAgICAgX2xl
bmd0aCA9IENhbGNTaXplKF9mb3JtYXQpDQoNCiAgICAgb2Zmc2V0X2xpc3QgPSBbMF0NCiAgICAg
bGFzdF9vZmZzZXQgPSAwDQogICAgIGZvciBpIGluIHJhbmdlKGxlbihfZm9ybWF0KSk6DQogICAg
ICAgb2Zmc2V0ID0gQ2FsY1NpemUoX2Zvcm1hdFs6aV0pDQogICAgICAgaWYgb2Zmc2V0ID4gbGFz
dF9vZmZzZXQ6DQogICAgICAgICBsYXN0X29mZnNldCA9IG9mZnNldA0KICAgICAgICAgb2Zmc2V0
X2xpc3QuYXBwZW5kKG9mZnNldCkNCg0KICAgICAjIEEgZGljdGlvbmFyeSB0aGF0IG1hcHMgZmll
bGQgbmFtZXMgdG8gdGhlaXIgb2Zmc2V0cyBpbiB0aGUgc3RydWN0Lg0KICAgICBfb2Zmc2V0cyA9
IGRpY3QobGlzdCh6aXAoX2ZpZWxkbmFtZXMsIG9mZnNldF9saXN0KSkpDQoNCiAgICAgIyBDaGVj
ayB0aGF0IHRoZSBudW1iZXIgb2YgZmllbGQgbmFtZXMgbWF0Y2hlcyB0aGUgbnVtYmVyIG9mIGZp
ZWxkcy4NCiAgICAgbnVtZmllbGRzID0gbGVuKHN0cnVjdC51bnBhY2soX2Zvcm1hdCwgYiJceDAw
IiAqIF9sZW5ndGgpKQ0KICAgICBpZiBsZW4oX2ZpZWxkbmFtZXMpICE9IG51bWZpZWxkczoNCiAg
ICAgICByYWlzZSBWYWx1ZUVycm9yKCJJbnZhbGlkIGNzdHJ1Y3Q6IFwiJXNcIiBoYXMgJWQgZWxl
bWVudHMsIFwiJXNcIiAgDQpoYXMgJWQuIg0KICAgICAgICAgICAgICAgICAgICAgICAgJSAoZm10
LCBudW1maWVsZHMsIGZpZWxkbmFtZXMsIGxlbihfZmllbGRuYW1lcykpKQ0KDQogICAgIGRlZiBf
U2V0VmFsdWVzKHNlbGYsIHZhbHVlcyk6DQogICAgICAgIyBSZXBsYWNlIHNlbGYuX3ZhbHVlcyB3
aXRoIHRoZSBnaXZlbiBsaXN0LiBXZSBjYW4ndCBkbyBkaXJlY3QgIA0KYXNzaWdubWVudA0KICAg
ICAgICMgYmVjYXVzZSBvZiB0aGUgX19zZXRhdHRyX18gb3ZlcmxvYWQgb24gdGhpcyBjbGFzcy4N
CiAgICAgICBzdXBlcihDU3RydWN0LCBzZWxmKS5fX3NldGF0dHJfXygiX3ZhbHVlcyIsIGxpc3Qo
dmFsdWVzKSkNCg0KICAgICBkZWYgX1BhcnNlKHNlbGYsIGRhdGEpOg0KICAgICAgIGRhdGEgPSBk
YXRhWzpzZWxmLl9sZW5ndGhdDQogICAgICAgdmFsdWVzID0gbGlzdChzdHJ1Y3QudW5wYWNrKHNl
bGYuX2Zvcm1hdCwgZGF0YSkpDQogICAgICAgZm9yIGluZGV4LCB2YWx1ZSBpbiBlbnVtZXJhdGUo
dmFsdWVzKToNCiAgICAgICAgIGlmIGlzaW5zdGFuY2UodmFsdWUsIHN0cikgYW5kIGluZGV4IGlu
IHNlbGYuX25lc3RlZDoNCiAgICAgICAgICAgdmFsdWVzW2luZGV4XSA9IHNlbGYuX25lc3RlZFtp
bmRleF0odmFsdWUpDQogICAgICAgc2VsZi5fU2V0VmFsdWVzKHZhbHVlcykNCg0KICAgICBkZWYg
X19pbml0X18oc2VsZiwgdHVwbGVfb3JfYnl0ZXM9Tm9uZSwgKiprd2FyZ3MpOg0KICAgICAgICIi
IkNvbnN0cnVjdCBhbiBpbnN0YW5jZSBvZiB0aGlzIFN0cnVjdC4NCg0KICAgICAgIDEuIFdpdGgg
bm8gYXJncywgdGhlIHdob2xlIHN0cnVjdCBpcyB6ZXJvLWluaXRpYWxpemVkLg0KICAgICAgIDIu
IFdpdGgga2V5d29yZCBhcmdzLCB0aGUgbWF0Y2hpbmcgZmllbGRzIGFyZSBwb3B1bGF0ZWQ7IHJl
c3QgYXJlICANCnplcm9lZC4NCiAgICAgICAzLiBXaXRoIG9uZSB0dXBsZSBhcyB0aGUgYXJnLCB0
aGUgZmllbGRzIGFyZSBhc3NpZ25lZCBiYXNlZCBvbiAgDQpwb3NpdGlvbi4NCiAgICAgICA0LiBX
aXRoIG9uZSBzdHJpbmcgYXJnLCB0aGUgU3RydWN0IGlzIHBhcnNlZCBmcm9tIGJ5dGVzLg0KICAg
ICAgICIiIg0KICAgICAgIGlmIHR1cGxlX29yX2J5dGVzIGFuZCBrd2FyZ3M6DQogICAgICAgICBy
YWlzZSBUeXBlRXJyb3IoDQogICAgICAgICAgICAgIiVzOiBjYW5ub3Qgc3BlY2lmeSBib3RoIGEg
dHVwbGUgYW5kIGtleXdvcmQgYXJncyIgJSBzZWxmLl9uYW1lKQ0KDQogICAgICAgaWYgdHVwbGVf
b3JfYnl0ZXMgaXMgTm9uZToNCiAgICAgICAgICMgRGVmYXVsdCBjb25zdHJ1Y3QgZnJvbSBudWxs
IGJ5dGVzLg0KICAgICAgICAgc2VsZi5fUGFyc2UoIlx4MDAiICogbGVuKHNlbGYpKQ0KICAgICAg
ICAgIyBJZiBhbnkga2V5d29yZHMgd2VyZSBzdXBwbGllZCwgc2V0IHRob3NlIGZpZWxkcy4NCiAg
ICAgICAgIGZvciBrLCB2IGluIGt3YXJncy5pdGVtcygpOg0KICAgICAgICAgICBzZXRhdHRyKHNl
bGYsIGssIHYpDQogICAgICAgZWxpZiBpc2luc3RhbmNlKHR1cGxlX29yX2J5dGVzLCBzdHIpOg0K
ICAgICAgICAgIyBJbml0aWFsaXppbmcgZnJvbSBhIHN0cmluZy4NCiAgICAgICAgIGlmIGxlbih0
dXBsZV9vcl9ieXRlcykgPCBzZWxmLl9sZW5ndGg6DQogICAgICAgICAgIHJhaXNlIFR5cGVFcnJv
cigiJXMgcmVxdWlyZXMgc3RyaW5nIG9mIGxlbmd0aCAlZCwgZ290ICVkIiAlDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAoc2VsZi5fbmFtZSwgc2VsZi5fbGVuZ3RoLCBsZW4odHVwbGVfb3Jf
Ynl0ZXMpKSkNCiAgICAgICAgIHNlbGYuX1BhcnNlKHR1cGxlX29yX2J5dGVzKQ0KICAgICAgIGVs
c2U6DQogICAgICAgICAjIEluaXRpYWxpemluZyBmcm9tIGEgdHVwbGUuDQogICAgICAgICBpZiBs
ZW4odHVwbGVfb3JfYnl0ZXMpICE9IGxlbihzZWxmLl9maWVsZG5hbWVzKToNCiAgICAgICAgICAg
cmFpc2UgVHlwZUVycm9yKCIlcyBoYXMgZXhhY3RseSAlZCBmaWVsZG5hbWVzICglZCBnaXZlbiki
ICUNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIChzZWxmLl9uYW1lLCBsZW4oc2VsZi5fZmll
bGRuYW1lcyksDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVuKHR1cGxlX29yX2J5dGVz
KSkpDQogICAgICAgICBzZWxmLl9TZXRWYWx1ZXModHVwbGVfb3JfYnl0ZXMpDQoNCiAgICAgZGVm
IF9GaWVsZEluZGV4KHNlbGYsIGF0dHIpOg0KICAgICAgIHRyeToNCiAgICAgICAgIHJldHVybiBz
ZWxmLl9maWVsZG5hbWVzLmluZGV4KGF0dHIpDQogICAgICAgZXhjZXB0IFZhbHVlRXJyb3I6DQog
ICAgICAgICByYWlzZSBBdHRyaWJ1dGVFcnJvcigiJyVzJyBoYXMgbm8gYXR0cmlidXRlICclcyci
ICUNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzZWxmLl9uYW1lLCBhdHRyKSkNCg0K
ICAgICBkZWYgX19nZXRhdHRyX18oc2VsZiwgbmFtZSk6DQogICAgICAgcmV0dXJuIHNlbGYuX3Zh
bHVlc1tzZWxmLl9GaWVsZEluZGV4KG5hbWUpXQ0KDQogICAgIGRlZiBfX3NldGF0dHJfXyhzZWxm
LCBuYW1lLCB2YWx1ZSk6DQogICAgICAgIyBUT0RPOiBjaGVjayB2YWx1ZSB0eXBlIGFnYWluc3Qg
c2VsZi5fZm9ybWF0IGFuZCB0aHJvdyBoZXJlLCBvciBlbHNlDQogICAgICAgIyBjYWxsZXJzIGdl
dCBhbiB1bmhlbHBmdWwgZXhjZXB0aW9uIHdoZW4gdGhleSBjYWxsIFBhY2soKS4NCiAgICAgICBz
ZWxmLl92YWx1ZXNbc2VsZi5fRmllbGRJbmRleChuYW1lKV0gPSB2YWx1ZQ0KDQogICAgIGRlZiBv
ZmZzZXQoc2VsZiwgbmFtZSk6DQogICAgICAgaWYgIi4iIGluIG5hbWU6DQogICAgICAgICByYWlz
ZSBOb3RJbXBsZW1lbnRlZEVycm9yKCJvZmZzZXQoKSBvbiBuZXN0ZWQgZmllbGQiKQ0KICAgICAg
IHJldHVybiBzZWxmLl9vZmZzZXRzW25hbWVdDQoNCiAgICAgQGNsYXNzbWV0aG9kDQogICAgIGRl
ZiBfX2xlbl9fKGNscyk6DQogICAgICAgcmV0dXJuIGNscy5fbGVuZ3RoDQoNCiAgICAgZGVmIF9f
bmVfXyhzZWxmLCBvdGhlcik6DQogICAgICAgcmV0dXJuIG5vdCBzZWxmLl9fZXFfXyhvdGhlcikN
Cg0KICAgICBkZWYgX19lcV9fKHNlbGYsIG90aGVyKToNCiAgICAgICByZXR1cm4gKGlzaW5zdGFu
Y2Uob3RoZXIsIHNlbGYuX19jbGFzc19fKSBhbmQNCiAgICAgICAgICAgICAgIHNlbGYuX25hbWUg
PT0gb3RoZXIuX25hbWUgYW5kDQogICAgICAgICAgICAgICBzZWxmLl9maWVsZG5hbWVzID09IG90
aGVyLl9maWVsZG5hbWVzIGFuZA0KICAgICAgICAgICAgICAgc2VsZi5fdmFsdWVzID09IG90aGVy
Ll92YWx1ZXMpDQoNCiAgICAgQHN0YXRpY21ldGhvZA0KICAgICBkZWYgX01heWJlUGFja1N0cnVj
dCh2YWx1ZSk6DQogICAgICAgaWYgaGFzYXR0cih2YWx1ZSwgIl9fbWV0YWNsYXNzX18iKTojIGFu
ZCB2YWx1ZS5fX21ldGFjbGFzc19fID09IE1ldGE6DQogICAgICAgICByZXR1cm4gdmFsdWUuUGFj
aygpDQogICAgICAgZWxzZToNCiAgICAgICAgIHJldHVybiB2YWx1ZQ0KDQogICAgIGRlZiBQYWNr
KHNlbGYpOg0KICAgICAgIHZhbHVlcyA9IFtzZWxmLl9NYXliZVBhY2tTdHJ1Y3QodikgZm9yIHYg
aW4gc2VsZi5fdmFsdWVzXQ0KICAgICAgIHJldHVybiBzdHJ1Y3QucGFjayhzZWxmLl9mb3JtYXQs
ICp2YWx1ZXMpDQoNCiAgICAgZGVmIF9fc3RyX18oc2VsZik6DQogICAgICAgZGVmIEZpZWxkRGVz
YyhpbmRleCwgbmFtZSwgdmFsdWUpOg0KICAgICAgICAgaWYgaXNpbnN0YW5jZSh2YWx1ZSwgc3Ry
KToNCiAgICAgICAgICAgaWYgaW5kZXggaW4gc2VsZi5fYXNjaWl6Og0KICAgICAgICAgICAgIHZh
bHVlID0gdmFsdWUucnN0cmlwKCJceDAwIikNCiAgICAgICAgICAgZWxpZiBhbnkoYyBub3QgaW4g
c3RyaW5nLnByaW50YWJsZSBmb3IgYyBpbiB2YWx1ZSk6DQogICAgICAgICAgICAgdmFsdWUgPSB2
YWx1ZS5lbmNvZGUoImhleCIpDQogICAgICAgICByZXR1cm4gIiVzPSVzIiAlIChuYW1lLCB2YWx1
ZSkNCg0KICAgICAgIGRlc2NyaXB0aW9ucyA9IFsNCiAgICAgICAgICAgRmllbGREZXNjKGksIG4s
IHYpIGZvciBpLCAobiwgdikgaW4NCiAgICAgICAgICAgZW51bWVyYXRlKHppcChzZWxmLl9maWVs
ZG5hbWVzLCBzZWxmLl92YWx1ZXMpKV0NCg0KICAgICAgIHJldHVybiAiJXMoJXMpIiAlIChzZWxm
Ll9uYW1lLCAiLCAiLmpvaW4oZGVzY3JpcHRpb25zKSkNCg0KICAgICBkZWYgX19yZXByX18oc2Vs
Zik6DQogICAgICAgcmV0dXJuIHN0cihzZWxmKQ0KDQogICAgIGRlZiBDUG9pbnRlcihzZWxmKToN
CiAgICAgICAiIiJSZXR1cm5zIGEgQyBwb2ludGVyIHRvIHRoZSBzZXJpYWxpemVkIHN0cnVjdHVy
ZS4iIiINCiAgICAgICBidWYgPSBjdHlwZXMuY3JlYXRlX3N0cmluZ19idWZmZXIoc2VsZi5QYWNr
KCkpDQogICAgICAgIyBTdG9yZSB0aGUgQyBidWZmZXIgaW4gdGhlIG9iamVjdCBzbyBpdCBkb2Vz
bid0IGdldCBnYXJiYWdlICANCmNvbGxlY3RlZC4NCiAgICAgICBzdXBlcihDU3RydWN0LCBzZWxm
KS5fX3NldGF0dHJfXygiX2J1ZmZlciIsIGJ1ZikNCiAgICAgICByZXR1cm4gY3R5cGVzLmFkZHJl
c3NvZihzZWxmLl9idWZmZXIpDQoNCiAgIHJldHVybiBDU3RydWN0DQoNCg0KDQoNCkJwZkF0dHJQ
cm9nTG9hZCA9IFN0cnVjdCgNCiAgICAgImJwZl9hdHRyX3Byb2dfbG9hZCIsICI9SUlRUUlJUUki
LCAicHJvZ190eXBlIGluc25fY250IGluc25zIg0KICAgICAiIGxpY2Vuc2UgbG9nX2xldmVsIGxv
Z19zaXplIGxvZ19idWYga2Vybl92ZXJzaW9uIikNCkJwZkF0dHJQcm9nQXR0YWNoID0gU3RydWN0
KA0KICAgICAiYnBmX2F0dHJfcHJvZ19hdHRhY2giLCAiPUlJSSIsICJ0YXJnZXRfZmQgYXR0YWNo
X2JwZl9mZCBhdHRhY2hfdHlwZSIpDQpCcGZJbnNuID0gU3RydWN0KCJicGZfaW5zbiIsICI9QkJo
aSIsICJjb2RlIGRzdF9zcmNfcmVnIG9mZiBpbW0iKQ0KDQpsaWJjID0gY3R5cGVzLkNETEwoY3R5
cGVzLnV0aWwuZmluZF9saWJyYXJ5KCJjIiksIHVzZV9lcnJubz1UcnVlKQ0KDQpkZWYgVm9pZFBv
aW50ZXIocyk6DQogICAgIHJldHVybiBjdHlwZXMuY2FzdChzLkNQb2ludGVyKCksIGN0eXBlcy5j
X3ZvaWRfcCkNCg0KZGVmIE1heWJlUmFpc2VTb2NrZXRFcnJvcihyZXQpOg0KICAgaWYgcmV0IDwg
MDoNCiAgICAgZXJybm8gPSBjdHlwZXMuZ2V0X2Vycm5vKCkNCiAgICAgcmFpc2Ugc29ja2V0LmVy
cm9yKGVycm5vLCBvcy5zdHJlcnJvcihlcnJubykpDQoNCmRlZiBCcGZTeXNjYWxsKG9wLCBhdHRy
KToNCiAgIHJldCA9IGxpYmMuc3lzY2FsbChfX05SX2JwZiwgb3AsIFZvaWRQb2ludGVyKGF0dHIp
LCBsZW4oYXR0cikpDQogICBNYXliZVJhaXNlU29ja2V0RXJyb3IocmV0KQ0KICAgcmV0dXJuIHJl
dA0KDQoNCmRlZiBCcGZQcm9nTG9hZChwcm9nX3R5cGUsIGluc3RydWN0aW9ucywgcHJvZ19saWNl
bnNlPWIiR1BMIik6DQogICBicGZfcHJvZyA9IGIiIi5qb2luKGluc3RydWN0aW9ucykNCiAgIGlu
c25fYnVmZiA9IGN0eXBlcy5jcmVhdGVfc3RyaW5nX2J1ZmZlcihicGZfcHJvZykNCiAgIGdwbF9s
aWNlbnNlID0gY3R5cGVzLmNyZWF0ZV9zdHJpbmdfYnVmZmVyKHByb2dfbGljZW5zZSkNCiAgIGxv
Z19idWYgPSBjdHlwZXMuY3JlYXRlX3N0cmluZ19idWZmZXIoYiIiLCBMT0dfU0laRSkNCiAgIHJl
dHVybiBCcGZTeXNjYWxsKEJQRl9QUk9HX0xPQUQsDQogICAgICAgICAgICAgICAgICAgICBCcGZB
dHRyUHJvZ0xvYWQoKHByb2dfdHlwZSwgbGVuKGluc3RydWN0aW9ucyksDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY3R5cGVzLmFkZHJlc3NvZihpbnNuX2J1ZmYpLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eXBlcy5hZGRyZXNzb2YoZ3BsX2xp
Y2Vuc2UpLCAgDQpMT0dfTEVWRUwsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTE9HX1NJWkUsIGN0eXBlcy5hZGRyZXNzb2YobG9nX2J1ZiksICANCjApKSkNCg0KDQojIEF0
dGFjaCBhIGVCUEYgZmlsdGVyIHRvIGEgY2dyb3VwDQpkZWYgQnBmUHJvZ0F0dGFjaChwcm9nX2Zk
LCB0YXJnZXRfZmQsIHByb2dfdHlwZSk6DQogICBhdHRyID0gQnBmQXR0clByb2dBdHRhY2goKHRh
cmdldF9mZCwgcHJvZ19mZCwgcHJvZ190eXBlKSkNCiAgIHJldHVybiBCcGZTeXNjYWxsKEJQRl9Q
Uk9HX0FUVEFDSCwgYXR0cikNCg0KDQojIERldGFjaCBhIGVCUEYgZmlsdGVyIGZyb20gYSBjZ3Jv
dXANCmRlZiBCcGZQcm9nRGV0YWNoKHRhcmdldF9mZCwgcHJvZ190eXBlKToNCiAgIGF0dHIgPSBC
cGZBdHRyUHJvZ0F0dGFjaCgodGFyZ2V0X2ZkLCAwLCBwcm9nX3R5cGUpKQ0KICAgcmV0dXJuIEJw
ZlN5c2NhbGwoQlBGX1BST0dfREVUQUNILCBhdHRyKQ0KDQoNCmNsYXNzIEJwZkNncm91cEVncmVz
c1Rlc3QodW5pdHRlc3QuVGVzdENhc2UpOg0KICAgZGVmIHNldFVwKHNlbGYpOg0KICAgICBzZWxm
Ll9jZ19mZCA9IG9zLm9wZW4oIi9zeXMvZnMvY2dyb3VwIiwgb3MuT19ESVJFQ1RPUlkgfCBvcy5P
X1JET05MWSkNCiAgICAgQnBmUHJvZ0F0dGFjaChCcGZQcm9nTG9hZChCUEZfUFJPR19UWVBFX0NH
Uk9VUF9TS0IsIFsNCiAgICAgICAgIEJwZkluc24oKEJQRl9BTFU2NCB8IEJQRl9NT1YgfCBCUEZf
SywgQlBGX1JFR18wLCAwLA0KMCkpLlBhY2soKSwgICMgTW92NjRJbW0oUkVHMCwgMCkNCiAgICAg
ICAgIEJwZkluc24oKEJQRl9KTVAgfCBCUEZfRVhJVCwgMCwgMCwgMCkpLlBhY2soKSAgICAgICAg
ICAgICAgICAgICAgIyAgDQpFeGl0DQogICAgIF0pLCBzZWxmLl9jZ19mZCwgQlBGX0NHUk9VUF9J
TkVUX0VHUkVTUykNCg0KICAgZGVmIHRlYXJEb3duKHNlbGYpOg0KICAgICBCcGZQcm9nRGV0YWNo
KHNlbGYuX2NnX2ZkLCBCUEZfQ0dST1VQX0lORVRfRUdSRVNTKQ0KICAgICBvcy5jbG9zZShzZWxm
Ll9jZ19mZCkNCg0KICAgZGVmIHRlc3RDZ3JvdXBFZ3Jlc3NCbG9ja2VkKHNlbGYpOg0KICAgICBz
ID0gc29ja2V0LnNvY2tldChzb2NrZXQuQUZfSU5FVCwgc29ja2V0LlNPQ0tfREdSQU0sIDApDQog
ICAgIHMuYmluZCgoIjEyNy4wLjAuMSIsIDApKQ0KICAgICBhZGRyID0gcy5nZXRzb2NrbmFtZSgp
DQogICAgIHNlbGYuYXNzZXJ0UmFpc2VzUmVnZXhwKEVudmlyb25tZW50RXJyb3IsIG9zLnN0cmVy
cm9yKGVycm5vLkVQRVJNKSwgIA0Kcy5zZW5kdG8sIGIiZm9vIiwgYWRkcikNCg0KaWYgX19uYW1l
X18gPT0gIl9fbWFpbl9fIjoNCiAgIHVuaXR0ZXN0Lm1haW4oKQ0K
