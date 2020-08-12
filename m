Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBB243030
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLUkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLUkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 16:40:20 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44FC061384
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 13:40:19 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l10so2323148qvw.22
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YD9oDnrG8Z6JcBpuq/UbNq0O9QuaBudpHcn6VsItfhQ=;
        b=UySQ3jmVjIpx2pCRgTSQvOKRQVOTvf0/+OGgkB6+TLfojkHoJHsRLrmrOJljrFbci1
         SUYriIRveJrHTEIXY9YxhN+wY55CeXbYoGZNDsfpWN4yHYV+zjY6xPMdOIx6qVZQ4oDB
         zlGKu2pHN3iIE0D+PUtiRJ5DzE6uEbM7ZNBB6QWlWBlP8X2Oy1WR0qLpFfRPklx8jxKh
         eLkm7YrgZxaRQ49hrsBiHJDIkIF7dVdpX8OV/7D/NXXal0nXxUk3oTfjb2uMXUHDOA0K
         cnqgb48OPBL0Lxlfp18eu5pSeeoBU0CJyojSklYHmxup3iVRYGuGFlI85uG9Hsxi9RSt
         BCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YD9oDnrG8Z6JcBpuq/UbNq0O9QuaBudpHcn6VsItfhQ=;
        b=n2tv42fX/c54anyZUXi32gIA3h0AEbHfkrVvx9CfMJm43yrk70gwaRyHaPc7vPwF+V
         dnhaMMRe15w6x5xrZp9IJmXB5aZGvhFQgEd8TxUccXrLdoOeQ/foHUlWAbMf0CMJ4e0B
         ySiH1ns/x5f7aYQLtxhjHj+mVr0GHfmsTntPFW+hlG/zE3KXl4SiokhZ3gmUzG5X6TtK
         2e74JjFHBaAckZZMf/7AkptvUF5JTL9AiOfmJnF09ikyVkqx2j2NeW+yVZ6x3qveo0dj
         lPQcqmtPJRLzDlsGjPsYtq70DdIO0rayE2UGhXP0E7sKOUoZ2jyV/F93dj+gghU6Ex31
         93aw==
X-Gm-Message-State: AOAM533aSWOTwRpd7W7u8m8VIfogKTocsXvjdvJDYEEUeRHt8I+vcTfP
        091lO2pOzft6UjqK6sJzZziLNu0=
X-Google-Smtp-Source: ABdhPJxdubdXW4PwgJu9dM9xj0Z3AIPA09UhdEhSNfFkpA5hDk0es7P764u9/oCxXHhv8FsiOBCtnSc=
X-Received: by 2002:ad4:5425:: with SMTP id g5mr1438708qvt.198.1597264818846;
 Wed, 12 Aug 2020 13:40:18 -0700 (PDT)
Date:   Wed, 12 Aug 2020 13:40:17 -0700
In-Reply-To: <20200812140322.132844-1-Jianlin.Lv@arm.com>
Message-Id: <20200812204017.GI184844@google.com>
Mime-Version: 1.0
References: <20200812140322.132844-1-Jianlin.Lv@arm.com>
Subject: Re: [PATCH bpf-next] bpf: fix load XDP program error in test_xdp_vlan
From:   sdf@google.com
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com, Song.Zhu@arm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDgvMTIsIEppYW5saW4gTHYgd3JvdGU6DQo+IHRlc3RfeGRwX3ZsYW4uc2ggcmVwb3J0cyB0
aGUgZXJyb3IgYXMgYmVsb3c6DQoNCj4gJCBzdWRvIC4vdGVzdF94ZHBfdmxhbl9tb2RlX25hdGl2
ZS5zaA0KPiArICdbJyAteiB4ZHBfdmxhbl9tb2RlX25hdGl2ZSAnXScNCj4gKyBYRFBfTU9ERT14
ZHBnZW5lcmljDQo+IOKApuKApg0KPiArIGV4cG9ydCBYRFBfUFJPRz14ZHBfdmxhbl9yZW1vdmVf
b3V0ZXIyDQo+ICsgWERQX1BST0c9eGRwX3ZsYW5fcmVtb3ZlX291dGVyMg0KPiArIGlwIG5ldG5z
IGV4ZWMgbnMxIGlwIGxpbmsgc2V0IHZldGgxIHhkcGRydiBvZmYNCj4gRXJyb3I6IFhEUCBwcm9n
cmFtIGFscmVhZHkgYXR0YWNoZWQuDQoNCj4gaXAgd2lsbCB0aHJvdyBhbiBlcnJvciBpbiBjYXNl
IGEgWERQIHByb2dyYW0gaXMgYWxyZWFkeSBhdHRhY2hlZCB0byB0aGUNCj4gbmV0d29ya2luZyBp
bnRlcmZhY2UsIHRvIHByZXZlbnQgaXQgZnJvbSBiZWluZyBvdmVycmlkZGVuIGJ5IGFjY2lkZW50
Lg0KPiBJbiBvcmRlciB0byByZXBsYWNlIHRoZSBjdXJyZW50bHkgcnVubmluZyBYRFAgcHJvZ3Jh
bSB3aXRoIGEgbmV3IG9uZSwNCj4gdGhlIC1mb3JjZSBvcHRpb24gbXVzdCBiZSB1c2VkLg0KDQo+
IFNpZ25lZC1vZmYtYnk6IEppYW5saW4gTHYgPEppYW5saW4uTHZAYXJtLmNvbT4NCj4gLS0tDQo+
ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfeGRwX3ZsYW4uc2ggfCAyICstDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3hkcF92bGFuLnNoICAN
Cj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF94ZHBfdmxhbi5zaA0KPiBpbmRl
eCBiYjhiMGRhOTE2ODYuLjAzNGU2MDNhZWI1MCAxMDA3NTUNCj4gLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Rlc3RfeGRwX3ZsYW4uc2gNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Rlc3RfeGRwX3ZsYW4uc2gNCj4gQEAgLTIyMCw3ICsyMjAsNyBAQCBpcCBu
ZXRucyBleGVjIG5zMSBwaW5nIC1pIDAuMiAtVyAyIC1jIDIgJElQQUREUjINCj4gICAjIEVUSF9Q
XzgwMjFRIGluZGljYXRpb24sIGFuZCB0aGlzIGNhdXNlIG92ZXJ3cml0aW5nIG9mIG91ciBjaGFu
Z2VzLg0KPiAgICMNCj4gICBleHBvcnQgWERQX1BST0c9eGRwX3ZsYW5fcmVtb3ZlX291dGVyMg0K
PiAtaXAgbmV0bnMgZXhlYyBuczEgaXAgbGluayBzZXQgJERFVk5TMSAkWERQX01PREUgb2ZmDQo+
ICtpcCBuZXRucyBleGVjIG5zMSBpcCAtZm9yY2UgbGluayBzZXQgJERFVk5TMSAkWERQX01PREUg
b2ZmDQo+ICAgaXAgbmV0bnMgZXhlYyBuczEgaXAgbGluayBzZXQgJERFVk5TMSAkWERQX01PREUg
b2JqZWN0ICRGSUxFIHNlY3Rpb24gIA0KPiAkWERQX1BST0cNCg0KPiAgICMgTm93IHRoZSBuYW1l
c3BhY2VzIHNob3VsZCBzdGlsbCBiZSBhYmxlIHJlYWNoIGVhY2gtb3RoZXIsIHRlc3Qgd2l0aCAg
DQo+IHBpbmc6DQo+IC0tDQo+IDIuMTcuMQ0KDQpUaGlzIHNob3VsZCBiZSBhbHJlYWR5IGZpeGVk
IGJ5Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmL0NBS0g4cUJ1ejQ4V3c2Uz1EQ3pLUnIz
ZjQ2RXEzTHlrbnZUakRHUF81UVJQeHRHWl9Id0BtYWlsLmdtYWlsLmNvbS9ULyN0DQo=
