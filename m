Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C76CAB93
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjC0RKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjC0RK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 13:10:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B013C34
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:09:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so9317312ybe.16
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679936992;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM0lutb3gRnoqM+uGW40pX2RGiAIW+l60qS4j9UMsrk=;
        b=sFO02bryYdxU+wVRU6RmN+t1quP2Of8oD4DS3VtsikCXv1KBMe0G8cpDXfO5usfEUD
         eJjQT9LVE+LOlWGZVhbQO89rQ5/v4U8tjsy0n5orNMRWXX2iQDXg+1ZWR6+ffYqvnpWj
         cISWxU7fIZnnY/bTSkTf4nHz7AFE5UKI147S5Q0WnH2ja/nioUjIYETkHsvY0OUmzroU
         tKzm1yNk2r4XElkBJYapEWzAu3YNMBmZ1sd9Z06hDoI+J+tAYadEwZBmXrX70Tu2NuAY
         ls//9pJ9FQeUjEyLlMes69tvxIUL2/WCIn0ROcglHC44iwsGY77bBA4HBOrY1J2TUhiW
         mwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936992;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UM0lutb3gRnoqM+uGW40pX2RGiAIW+l60qS4j9UMsrk=;
        b=ORbK/Ld6O2UOdMIu3YPFfTs8CEou3Z7Akd9q69pWn/GNxdo219Xjr7szy8Dnk/gwuu
         dVBZqEemIJmqifs4Yp8PNMDQG14gkV2094Dqgat9xTFGi6E0d2H+SVhZex0Il97AY8GS
         eg4lAbRql/sXZU0ie67CbCD53R/igiEU5ojPT+Jy4eyV3DukQVnprOh1+xvZKnRtcr6y
         58+b8t1ck/9jI5EBmW+dxUg+Bk8Cpshp0xBZH9M2D+zXka/dyEqdiwKgPouFqpn4/88c
         LLv+FmTb0+v8bVlyMb/5baTFoVka60X0K53Fiv+it/ex+CdrGLuCUd4ip7GC6sDmuh+N
         VQFg==
X-Gm-Message-State: AAQBX9dzhTKLk1r812TrICFzCvh0iYJXszxYeoS7fjbLNzkPLcbjbOLp
        ElHqsL4OvQlt1V0A4UIVD2g5zEY=
X-Google-Smtp-Source: AKy350aQv3UfTYLSVzJIUlfFIirmVYy8QxrY1KIyTy8dhRlf2RIQk1zB1goyyfh52BqUSrKZO2P606s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ae21:0:b0:543:bbdb:8c2b with SMTP id
 m33-20020a81ae21000000b00543bbdb8c2bmr5870649ywh.10.1679936992009; Mon, 27
 Mar 2023 10:09:52 -0700 (PDT)
Date:   Mon, 27 Mar 2023 10:09:50 -0700
In-Reply-To: <C8C3B8DB-1CF1-4C51-91A1-6D4C6FEFD6D1@avride.ai>
Mime-Version: 1.0
References: <F75020C7-9247-4F15-96CC-C3E6F11C0429@avride.ai>
 <ZB4F7l0Nh2ZYwjci@google.com> <C8C3B8DB-1CF1-4C51-91A1-6D4C6FEFD6D1@avride.ai>
Message-ID: <ZCHN3sbx2Cr0r0hM@google.com>
Subject: Re: Network RX per process per interface statistics
From:   Stanislav Fomichev <sdf@google.com>
To:     Kamil Zaripov <zaripov-kamil@avride.ai>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
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

T24gMDMvMjcsIEthbWlsIFphcmlwb3Ygd3JvdGU6DQo+ID4gQnkgIm1vZGlmaWVzIiAtIGRvIHlv
dSBtZWFuIHRoZSBwYXlsb2FkL2hlYWRlcnM/IFlvdSBjYW4gcHJvYmFibHkgdXNlDQo+ID4gdGhl
IHNrYiBwb2ludGVyIGFkZHJlc3MgYXMgYSB1bmlxdWUgaWRlbnRpZmllciB0byBjb25uZWN0IGFj
cm9zcyAgDQo+IGRpZmZlcmVudA0KPiA+IHRyYWNlcG9pbnRzPw0KDQo+IE5vLCBJIG1lYW4gd2hl
biBzaXR1YXRpb25zIHdoZW4gc2FtZSBwYWNrYWdlIHRocm91Z2ggaXRzIHdheSB0byB0aGUgIA0K
PiBuZXR3b3JrIHN0YWNrIGNoYW5nZSBza19idWZmIHBvaW50ZXIuIEZvciBleGFtcGxlLCBhZnRl
ciBza2JfY2xvbmUoKSAgDQo+IGNhbGwuIEkgaGF2ZSBtYWRlIHNvbWUgdGVzdCBhbmQgZm91bmQg
b3V0IChlbXBpcmljYWxseSkgdGhhdCBwb2ludGVyIHRvICANCj4gdGhlIHNrYi0+aGVhZCBhIG11
Y2ggYmV0dGVyIHRyYWNraW5nIElELiBIb3dldmVyLCBJIGFtIG5vdCBzdXJlIHRoYXQgIA0KPiB0
aGVyZSBpcyBubyBvdGhlciBjb3JuZXIgY2FzZXMgd2hlbiBza2ItPmhlYWQgYWxzbyBjYW4gY2hh
bmdlLg0KDQpZZWFoLCB0aG9zZSBhcmUgdHJpY2t5IDotKA0KDQo+ID4gTm90aGluZyBwb3BzIHRv
IG15IG1pbmQuIEJ1dCBJIHRoaW5rIHRoYXQgaWYgeW91IHN0b3JlIHNrYmFkZHI9ZGV2IGZyb20N
Cj4gPiBuZXRpZl9yZWNlaXZlX3NrYiwgeW91IHNob3VsZCBiZSBhYmxlIHRvIGxvb2sgdGhpcyB1
cCBhdCBhIGxhdGVyIHBvaW50DQo+ID4gd2hlcmUgeW91IGtub3cgc2tiLT5wcm9jZXNzIGFzc29j
aWF0aW9uPw0KDQo+IFllcywgSSBoYXZlIGFscmVhZHkgaW1wbGVtZW50ZWQgYW5kIG1ha2Ugc29t
ZSB0ZXN0IG9mIHRoaXMgYXBwcm9hY2g6IEnigJltICANCj4gbGlzdGVuaW5nIGF0IG5ldGlmX3Jl
Y2VpdmVfc2tiIHRyYWNlcG9pbnQgdG8gY3JlYXRlIHNrYl9oZWFkLT5uZXRpZiBtYXAgIA0KPiBh
bmQgdGhlbiBsaXN0ZW5pbmcgZm9yIF9fa2ZyZWVfc2tiIGNhbGxzIHRvIGNyZWF0ZSBwaWQtPnNr
Yl9oZWFkIG1hcC4gIA0KPiBIb3dldmVyLCB0aGlzIGFwcHJvYWNoIGhhdmUgc29tZSB3ZWFrbmVz
c2VzOg0KPiAtIFBhcnQgb2YgcGFja2FnZXMgb2YgVENQIHByb3RvY29sIHBhY2thZ2VzIChBQ0ss
IGZvciBleGFtcGxlKSBhcmUgIA0KPiBoYW5kbGVkIGJ5IHRoZSBrZXJuZWwsIHNvIEkgYWNjb3Vu
dCB0aGlzIHBhY2thZ2VzIGFzIGtlcm5lbCBhY3Rpdml0eS4gQnV0ICANCj4gYWxtb3N0IGV2ZXJ5
IFRDUCBBQ0sgcGFja2FnZSBoYXZlIHNvbWUgIGFzc29jaWF0ZWQgc29ja2V0LCB3aGljaCwgaW4g
IA0KPiB0dXJuLCBoYXZlIGFzc29jaWF0ZWQgcHJvY2Vzcy4NCj4gLSBJIGFtIG5vdCBzdXJlIHRo
YXQgYWxsIHBhY2thZ2UgY29uc3VtZXMgY2FsbCBfX2tmcmVlX3NrYiBhdCB0aGUgZW5kLiAgDQo+
IE1heWJlIHRoZXJlIGlzIHNvbWUgb3RoZXIgbWlzY291bnRpbmcgaW4gdGhpcyBwbGFjZS4NCg0K
PiBNYXliZSB0aGVyZSBpcyBzb21lIG90aGVyIGFwcHJvYWNoZXMgdG8gbWFwIHBhY2thZ2VzIHRv
IHByb2Nlc3Nlcz8NCg0KSSdtIG5vdCBzdXBlciBmYW1pbGlhciB3aXRoIHRob3NlIHRyYWNpbmcg
aG9va3MuIE1heWJlIHlvdSBuZWVkIHRvDQpoYW5kbGUgY29uc3VtZV9za2IgYXMgd2VsbD8NCg0K
SWYgSSB3ZXJlIHRvIHNvbHZlIHNvbWV0aGluZyBsaWtlIHRoaXMsIEknZCBwcm9iYWJseSBsb29r
IGF0IGNncm91cC9pbmdyZXNzDQpob29rcy4gVGhvc2UgYXJlIGd1YXJhbnRlZWQgdG8gcnVuIGZv
ciBldmVyeSBpbmNvbWluZyBwYWNrZXQgaW50byBjZ3JvdXAncw0Kc29ja2V0cy4gKGF0IGxlYXN0
IHJlbW92ZXMgdGhhdCBrZnJlZV9za2IgdnMgY29uc3VtZV9za2IgaXNzdWUpLg0KDQpCdXQgaXQg
ZG9lc24ndCBzb2x2ZSB5b3VyIHByb2JsZW0gd2l0aCB0aGUgY2xvbmVzLi4uDQo=
