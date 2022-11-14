Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075816286E7
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiKNRV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiKNRVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:21:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB9522B10
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:21:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso6346651pfi.7
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wb+mb9CcaHACfAtfzoJMaJqM5TBiPHNSitzxl2Oq7TQ=;
        b=TKVsf3x3LHJKi40zqLmScpAGIL/P/zioiHrCooztsqllpNtwyjsRMooPUQpdNMlDk6
         Sa1fBq8alsZmR9esENUlYmloIiwbuwM+Ryc4AYAxXVt2IM0t137NtVhDhTh4KBrgBOOl
         gixcZLbxpncxGRIsqPvw7YLnM+KRKiBnC6+IiPKd0j9Jz+eaiCGVq3tjkdePOf5ACraG
         Mj83Sy6oXJys8mBlCZPhtQ36ExP4y+9MfbMAJiZ+P7ZYN9uAYT6uh6X8LzI1ywKP9DRg
         F94et3ORQzxOeNMsyXVqIJ86dPu1IMJ4ZHwGam1x0+x5qNuqxkI+dJgXkrl0nn0YJdRg
         tO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wb+mb9CcaHACfAtfzoJMaJqM5TBiPHNSitzxl2Oq7TQ=;
        b=SdOs96SEz7gpNge4HxDzKZVlDKpt7rg/n0zXyD+pEzyOiMsyoQbdYb56Ci2MvCvMaq
         ym5eXlufll7BmX+0zPQ3RVPNYHg1BF5xFizEi+/DFZCncQye9d5oHq8h0okiAipCYkSv
         ZyfhPns1b0Ops671u4HJ0TA6lNhYvkAaZEpdL1plAjm7kTTnvUqvjez3WTFYqWqVBMxB
         drfY8lo8SVd0jwLPehAjKOsnKdBKf81FRlH2ZvfLgc0vwWmggZm3Kbi0q6S6n04NC+9Y
         06u4avR0ufu+BiucN/+37w7rEyh0wVld/CgVEecK4Z0Bci7YWc5lhtnP7Bpf2PCE9TK5
         mMJg==
X-Gm-Message-State: ANoB5ploivu/7MefQr2JIMv40DcteVWHxFTdMumuYwYtVaqOOw22zrHg
        G0ApqAxIUm2yviSPcUddaj7JK/o=
X-Google-Smtp-Source: AA0mqf73+tpVkesl56ElOr4dvUZ1y3Cd9TOJ9spSOFDJmjNye0KjbIW9ezU40SSLbDFim++atjnC+As=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:7b53:0:b0:56b:83d3:a22 with SMTP id
 w80-20020a627b53000000b0056b83d30a22mr14782313pfc.32.1668446510154; Mon, 14
 Nov 2022 09:21:50 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:21:48 -0800
In-Reply-To: <87zgcu60hq.fsf@gmail.com>
Mime-Version: 1.0
References: <87zgcu60hq.fsf@gmail.com>
Message-ID: <Y3J5LMzdb9+FBCN8@google.com>
Subject: Re: [PATCH] libbpf: Fix uninitialized warning in btf_dump_dump_type_data
From:   sdf@google.com
To:     David Michael <fedora.dm0@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org
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

T24gMTEvMTMsIERhdmlkIE1pY2hhZWwgd3JvdGU6DQo+IEdDQyAxMS4zLjAgZmFpbHMgdG8gY29t
cGlsZSBidGZfZHVtcC5jIGR1ZSB0byB0aGUgZm9sbG93aW5nIGVycm9yLA0KPiB3aGljaCBzZWVt
cyB0byBvcmlnaW5hdGUgaW4gYnRmX2R1bXBfc3RydWN0X2RhdGEgd2hlcmUgdGhlIHJldHVybmVk
DQo+IHZhbHVlIHdvdWxkIGJlIHVuaW5pdGlhbGl6ZWQgaWYgYnRmX3ZsZW4gcmV0dXJucyB6ZXJv
Lg0KDQo+IGJ0Zl9kdW1wLmM6IEluIGZ1bmN0aW9uIOKAmGJ0Zl9kdW1wX2R1bXBfdHlwZV9kYXRh
4oCZOg0KPiBidGZfZHVtcC5jOjIzNjM6MTI6IGVycm9yOiDigJhlcnLigJkgbWF5IGJlIHVzZWQg
dW5pbml0aWFsaXplZCBpbiB0aGlzICANCj4gZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0
aWFsaXplZF0NCj4gICAyMzYzIHwgICAgICAgICBpZiAoZXJyIDwgMCkNCj4gICAgICAgIHwgICAg
ICAgICAgICBeDQoNCj4gRml4ZXM6IDQzMTc0ZjBkNDU5NyAoImxpYmJwZjogU2lsZW5jZSB1bmlu
aXRpYWxpemVkIHdhcm5pbmcvZXJyb3IgaW4gIA0KPiBidGZfZHVtcF9kdW1wX3R5cGVfZGF0YSIp
DQoNClByb2JhYmx5IGJldHRlciB0byByZWZlcmVuY2UgdGhlIG9yaWdpbmFsIHBhdGNoPw0KRml4
ZXM6IDkyMGQxNmFmOWI0MiAoImxpYmJwZjogQlRGIGR1bXBlciBzdXBwb3J0IGZvciB0eXBlZCBk
YXRhIikNCg0KQWNrZWQtYnk6IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGdvb2dsZS5jb20+DQoN
Cj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTWljaGFlbCA8ZmVkb3JhLmRtMEBnbWFpbC5jb20+DQo+
IC0tLQ0KDQo+IEhpLA0KDQo+IEkgZW5jb3VudGVyZWQgdGhpcyBidWlsZCBmYWlsdXJlIHdoZW4g
dXNpbmcgR2VudG9vJ3MgaGFyZGVuZWQgcHJvZmlsZSB0bw0KPiBidWlsZCBzeXMta2VybmVsL2dl
bnRvby1rZXJuZWwgKGF0IGxlYXN0IHNvbWUgNS4xOSBhbmQgNi4wIHZlcnNpb25zKS4NCj4gVGhl
IGZvbGxvd2luZyBwYXRjaCBmaXhlcyBpdC4gIENhbiB0aGlzIGJlIGFwcGxpZWQ/DQoNCj4gVGhh
bmtzLg0KDQo+IERhdmlkDQoNCj4gICB0b29scy9saWIvYnBmL2J0Zl9kdW1wLmMgfCAyICstDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnRmX2R1bXAuYyBiL3Rvb2xzL2xpYi9icGYvYnRmX2R1
bXAuYw0KPiBpbmRleCAxMmY3MDM5ZTAuLmU5Zjg0OWQ4MiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMv
bGliL2JwZi9idGZfZHVtcC5jDQo+ICsrKyBiL3Rvb2xzL2xpYi9icGYvYnRmX2R1bXAuYw0KPiBA
QCAtMTk4OSw3ICsxOTg5LDcgQEAgc3RhdGljIGludCBidGZfZHVtcF9zdHJ1Y3RfZGF0YShzdHJ1
Y3QgYnRmX2R1bXAgKmQsDQo+ICAgew0KPiAgIAljb25zdCBzdHJ1Y3QgYnRmX21lbWJlciAqbSA9
IGJ0Zl9tZW1iZXJzKHQpOw0KPiAgIAlfX3UxNiBuID0gYnRmX3ZsZW4odCk7DQo+IC0JaW50IGks
IGVycjsNCj4gKwlpbnQgaSwgZXJyID0gMDsNCg0KPiAgIAkvKiBub3RlIHRoYXQgd2UgaW5jcmVt
ZW50IGRlcHRoIGJlZm9yZSBjYWxsaW5nIGJ0Zl9kdW1wX3ByaW50KCkgYmVsb3c7DQo+ICAgCSAq
IHRoaXMgaXMgaW50ZW50aW9uYWwuICBidGZfZHVtcF9kYXRhX25ld2xpbmUoKSB3aWxsIG5vdCBw
cmludCBhDQo+IC0tDQo+IDIuMzguMQ0K
