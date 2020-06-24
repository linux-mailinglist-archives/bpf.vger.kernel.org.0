Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D32206CD0
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbgFXGpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 02:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbgFXGpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 02:45:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5FC061573;
        Tue, 23 Jun 2020 23:45:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 9so1325833ljc.8;
        Tue, 23 Jun 2020 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:mime-version:message-id
         :content-transfer-encoding;
        bh=Ieyn7x3W0CCQSHHv6jv2m+r/5zOlc9E1mjWtua60lEE=;
        b=eHLiN8J8RnjWRiX3Lb1kuUyfNjUJJhSIdwlwtZSwY10M9p+F9wGXLD15C34PcFudFx
         WZu9tUPC7v88RV2cI5lIYPmCiDXAa+oOUPNzPAUpyyokL8T/RV+u18eJuqUtbVSX6PZo
         AR1a0L3D8js/BEv9xJMvFqCLqN/fn2FVKl/1VKuTsD/loL6j/e0UXu9W4vrnlO/pIFg/
         z9Ab1rAnMzYYuD5J02MJ4RXSeQADHOl9Cq3zQMwo1g3vXfuFX0ti8KKV46EgFIP+ngD8
         2NrfP6u0+zqJpXnBEZ/rJznuAQNXawZBMo29yXV8b/ykpkq73+rMOaKO191wnhcS1J1Q
         bIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:mime-version:message-id
         :content-transfer-encoding;
        bh=Ieyn7x3W0CCQSHHv6jv2m+r/5zOlc9E1mjWtua60lEE=;
        b=K+KEiXs9svDDqfi68yloa6Ilhl3B1ueRGwXYjCjdp7+SxP+6Rc+XHsYT5v/tt9cSkv
         ly5P0Ht6CKc1ThPJtnVTpKgn2DTjP3YhK0KzAAFCvXBi0OAazInggwsi6jONpwRDI0Ii
         fOJjbFF7jqUvNeq6Uw3MGpPzDuaH/PNKQE00yPSFKHriOtNdbtpfD7Xy+v58VPLqvBI0
         9wSEP7tLxlC/DVGNZ4G59HVYYLwJPG8mT9HIPWr+Dbdzx7CYaYdUksJsW/XL17b4UNyN
         ijBG6SnvFBgSPrmsOyeEMA5rrtNhIrqoNwN76xg4tJbiRhj40PiptWozt78pWQxh0NM6
         IkwA==
X-Gm-Message-State: AOAM533ct4uc1JrxB9zzBUKmIeufqzTVCNRrvAHVKV9iDYwxV8mu8l20
        gDbY1tj/L2UJwLfAYba7Au1e8mFr
X-Google-Smtp-Source: ABdhPJyTq77+JASEOlqtWJusnVai6E8cGkwqdhV9C+f9BQl6lmWRxg3H53RJqZCw0GF7bAfCMHsojg==
X-Received: by 2002:a2e:b4a3:: with SMTP id q3mr12822506ljm.65.1592981130891;
        Tue, 23 Jun 2020 23:45:30 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id r25sm1933212lfi.70.2020.06.23.23.45.29
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 23:45:30 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:45:29 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: tools/bpf: build failed with defconfig(x86_64) on v5.6 and v5.7
X-Priority: 3
X-GUID: D2F229FE-D9D2-4225-AEEA-33D45A09575F
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2020062414452752504112@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LSBpbmZvcm1hdGlvbiBvZiBtYWNoaW5lCkxpbnV4IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiA0LjE4
LjAtMTkzLjYuMy5lbDhfMi54ODZfNjQgIzEgU01QIFdlZCBKdW4gMTAgMTE6MDk6MzIgVVRDIDIw
MjAgeDg2XzY0IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4CgotIGNvbmZpZ3VyYXRpb25zCm1ha2Ug
ZGVmY29uZmlnCm1ha2Uga3ZtY29uZmlnCgotIGZhaWxlZCBsb2dzIG9uIHY1LjYKYGBgCsKgIExJ
TksgwqAgwqAgL21udC9idWlsZC8xX2J1aWxkLzA1X2J1aWxkX3Y1LjYvYnBmL2JwZnRvb2wvL2xp
YmJwZi9saWJicGYuYQrCoCBMSU5LIMKgIMKgIC9tbnQvYnVpbGQvMV9idWlsZC8wNV9idWlsZF92
NS42L2JwZi9icGZ0b29sL2JwZnRvb2wKwqAgREVTQ0VORCDCoHJ1bnFzbG93ZXIKwqAgR0VOIMKg
IMKgIMKgL21udC9idWlsZC8wX2NvZGUvMF9saW51eC9saW51eC90b29scy9icGYvcnVucXNsb3dl
ci8ub3V0cHV0L2JwZl9oZWxwZXJfZGVmcy5oCm1ha2VbNF06ICoqKiBObyBydWxlIHRvIG1ha2Ug
dGFyZ2V0ICcvbW50L2J1aWxkLzBfY29kZS8wX2xpbnV4L2xpbnV4L3Rvb2xzL2luY2x1ZGUvbGlu
dXgvYnVpbGRfYnVnLmgnLCBuZWVkZWQgYnkgJy9tbnQvYnVpbGQvMF9jb2RlLzBfbGludXgvbGlu
dXgvdG9vbHMvYnBmL3J1bnFzbG93ZXIvLm91dHB1dC9zdGF0aWNvYmpzL2xpYmJwZi5vJy4gwqBT
dG9wLgptYWtlWzNdOiAqKiogW01ha2VmaWxlOjE4MzogL21udC9idWlsZC8wX2NvZGUvMF9saW51
eC9saW51eC90b29scy9icGYvcnVucXNsb3dlci8ub3V0cHV0L3N0YXRpY29ianMvbGliYnBmLWlu
Lm9dIEVycm9yIDIKbWFrZVsyXTogKioqIFtNYWtlZmlsZTo3OTogLm91dHB1dC9saWJicGYuYV0g
RXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjExOTogcnVucXNsb3dlcl0gRXJyb3IgMgpt
YWtlOiAqKiogW01ha2VmaWxlOjY4OiBicGZdIEVycm9yIDIKYGBgCgotIGZhaWxlZCBsb2dzIG9u
IHY1LjcKYGBgCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvbW50L2J1aWxkLzBfY29kZS8wX2xpbnV4
L2xpbnV4L3Rvb2xzL2luY2x1ZGUvbGludXgvYnVpbGRfYnVnLmg6NSwKwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBmcm9tIC9tbnQvYnVpbGQvMF9jb2RlLzBfbGludXgvbGludXgvdG9vbHMvaW5j
bHVkZS9saW51eC9rZXJuZWwuaDo4LArCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gL21u
dC9idWlsZC8wX2NvZGUvMF9saW51eC9saW51eC9rZXJuZWwvYnBmL2Rpc2FzbS5oOjEwLArCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyb20gL21udC9idWlsZC8wX2NvZGUvMF9saW51eC9saW51
eC9rZXJuZWwvYnBmL2Rpc2FzbS5jOjg6Ci9tbnQvYnVpbGQvMF9jb2RlLzBfbGludXgvbGludXgv
a2VybmVsL2JwZi9kaXNhc20uYzogSW4gZnVuY3Rpb24g4oCYX19mdW5jX2dldF9uYW1l4oCZOgov
bW50L2J1aWxkLzBfY29kZS8wX2xpbnV4L2xpbnV4L3Rvb2xzL2luY2x1ZGUvbGludXgvY29tcGls
ZXIuaDozNzozODogd2FybmluZzogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiDigJhfX2Nv
bXBpbGV0aW1lX2Fzc2VydF8w4oCZIFstV25lc3RlZC1leHRlcm5zXQrCoCBfY29tcGlsZXRpbWVf
YXNzZXJ0KGNvbmRpdGlvbiwgbXNnLCBfX2NvbXBpbGV0aW1lX2Fzc2VydF8sIF9fQ09VTlRFUl9f
KQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBefn5+fn5+fn5+fn5+fn5+fn5+fn4KL21udC9idWlsZC8wX2NvZGUvMF9saW51eC9saW51eC90
b29scy9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmg6MTY6MTU6IG5vdGU6IGluIGRlZmluaXRpb24g
b2YgbWFjcm8g4oCYX19jb21waWxldGltZV9hc3NlcnTigJkKwqAgwqBleHRlcm4gdm9pZCBwcmVm
aXggIyMgc3VmZml4KHZvaWQpIF9fY29tcGlsZXRpbWVfZXJyb3IobXNnKTsgXArCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoF5+fn5+fgovbW50L2J1aWxkLzBfY29kZS8wX2xpbnV4L2xpbnV4L3Rvb2xz
L2luY2x1ZGUvbGludXgvY29tcGlsZXIuaDozNzoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8g4oCYX2NvbXBpbGV0aW1lX2Fzc2VydOKAmQrCoCBfY29tcGlsZXRpbWVfYXNzZXJ0KGNvbmRp
dGlvbiwgbXNnLCBfX2NvbXBpbGV0aW1lX2Fzc2VydF8sIF9fQ09VTlRFUl9fKQrCoCBefn5+fn5+
fn5+fn5+fn5+fn5+Ci9tbnQvYnVpbGQvMF9jb2RlLzBfbGludXgvbGludXgvdG9vbHMvaW5jbHVk
ZS9saW51eC9idWlsZF9idWcuaDozOTozNzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mGNvbXBpbGV0aW1lX2Fzc2VydOKAmQrCoCNkZWZpbmUgQlVJTERfQlVHX09OX01TRyhjb25kLCBt
c2cpIGNvbXBpbGV0aW1lX2Fzc2VydCghKGNvbmQpLCBtc2cpCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXn5+fn5+fn5+fn5+fn5+fn5+Ci9t
bnQvYnVpbGQvMF9jb2RlLzBfbGludXgvbGludXgvdG9vbHMvaW5jbHVkZS9saW51eC9idWlsZF9i
dWcuaDo1MDoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYQlVJTERfQlVHX09OX01T
R+KAmQrCoCBCVUlMRF9CVUdfT05fTVNHKGNvbmRpdGlvbiwgIkJVSUxEX0JVR19PTiBmYWlsZWQ6
ICIgI2NvbmRpdGlvbikKwqAgXn5+fn5+fn5+fn5+fn5+fgovbW50L2J1aWxkLzBfY29kZS8wX2xp
bnV4L2xpbnV4L2tlcm5lbC9icGYvZGlzYXNtLmM6MjA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvIOKAmEJVSUxEX0JVR19PTuKAmQrCoCBCVUlMRF9CVUdfT04oQVJSQVlfU0laRShmdW5j
X2lkX3N0cikgIT0gX19CUEZfRlVOQ19NQVhfSUQpOwrCoCBefn5+fn5+fn5+fn4KYGBgCgphbmTC
oApgYGAKwqAgTElOSyDCoCDCoCAvbW50L2J1aWxkLzBfY29kZS8wX2xpbnV4L2xpbnV4L3Rvb2xz
L2JwZi9ydW5xc2xvd2VyLy5vdXRwdXQvbGliYnBmLmEKwqAgR0VOIMKgIMKgIMKgdm1saW51eC5o
CsKgIEJQRiDCoCDCoCDCoHJ1bnFzbG93ZXIuYnBmLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHJ1
bnFzbG93ZXIuYnBmLmM6MzoKLm91dHB1dC92bWxpbnV4Lmg6NToxNTogZXJyb3I6IGF0dHJpYnV0
ZSAncHJlc2VydmVfYWNjZXNzX2luZGV4JyBpcyBub3Qgc3VwcG9ydGVkIGJ5ICcjcHJhZ21hIGNs
YW5nIGF0dHJpYnV0ZScKI3ByYWdtYSBjbGFuZyBhdHRyaWJ1dGUgcHVzaCAoX19hdHRyaWJ1dGVf
XygocHJlc2VydmVfYWNjZXNzX2luZGV4KSksIGFwcGx5X3RvID0gcmVjb3JkKQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCBeCi5vdXRwdXQvdm1saW51eC5oOjk4NjA3OjE1OiBlcnJvcjogJyNwcmFnbWEg
Y2xhbmcgYXR0cmlidXRlIHBvcCcgd2l0aCBubyBtYXRjaGluZyAnI3ByYWdtYSBjbGFuZyBhdHRy
aWJ1dGUgcHVzaCcKI3ByYWdtYSBjbGFuZyBhdHRyaWJ1dGUgcG9wCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIF4KMiBlcnJvcnMgZ2VuZXJhdGVkLgptYWtlWzJdOiAqKiogW01ha2VmaWxlOjU3OiAub3V0
cHV0L3J1bnFzbG93ZXIuYnBmLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMTk6
IHJ1bnFzbG93ZXJdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZTo2ODogYnBmXSBFcnJvciAy
CmBgYAoKT24gdGhpcyBzYW1lIG1hY2hpbmUgYW5kIHdpdGggc2FtZSBjb25maWd1cmF0aW9uLCBJ
J3ZlIHRyaWVkIHY1LjQgYW5kIHY1LjUsIG5vIGZhaWx1cmVzLgoKCg==

