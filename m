Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7612A1E7D92
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgE2MtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 08:49:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2091 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbgE2MtC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 08:49:02 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 322494E5EEF6D4F22BB4;
        Fri, 29 May 2020 20:48:59 +0800 (CST)
Received: from dggema707-chm.china.huawei.com (10.3.20.71) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 29 May 2020 20:48:58 +0800
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 dggema707-chm.china.huawei.com (10.3.20.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 29 May 2020 20:48:58 +0800
Received: from dggema758-chm.china.huawei.com ([10.9.48.193]) by
 dggema758-chm.china.huawei.com ([10.9.48.193]) with mapi id 15.01.1913.007;
 Fri, 29 May 2020 20:48:58 +0800
From:   "zhujianwei (C)" <zhujianwei7@huawei.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Hehuazhen <hehuazhen@huawei.com>
Subject: new seccomp mode aims to improve performance
Thread-Topic: new seccomp mode aims to improve performance
Thread-Index: AdY1q17j91IY6CMiRsq40mFg/pmPzw==
Date:   Fri, 29 May 2020 12:48:58 +0000
Message-ID: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.215.96]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGksIGFsbA0KDQqhoaGhV2UncmUgdXNpbmcgc2VjY29tcCB0byBpbmNyZWFzZSBjb250YWluZXIg
c2VjdXJpdHksIGJ1dCBicGYgcnVsZXMgZmlsdGVyIGNhdXNlcyBwZXJmb3JtYW5jZSB0byBkZXRl
cmlvcmF0ZS4gU28sIGlzIHRoZXJlIGEgZ29vZCBzb2x1dGlvbiB0byBpbXByb3ZlIHBlcmZvcm1h
bmNlLCBvciBjYW4gd2UgYWRkIGEgc2ltcGxpZmllZCBzZWNjb21wIG1vZGUgdG8gaW1wcm92ZSBw
ZXJmb3JtYW5jZT8NCqGhoaENCqGhoaEvLyBQc2V1ZG8gY29kZQ0KoaGhoWludCBfX3NlY3VyZV9j
b21wdXRpbmcoaW50IHRoaXNfc3lzY2FsbCkNCqGhoaF7DQqhoaGhCS4uLg0KoaGhoQlzd2l0Y2gg
KG1vZGUpIHsNCqGhoaEJY2FzZSBTRUNDT01QX01PREVfU1RSSUNUOg0KoaGhoQkJLi4uDQqhoaGh
CWNhc2UgU0VDQ09NUF9NT0RFX0ZJTFRFUjoNCqGhoaEJCS4uLg0KoaGhoQljYXNlIFNFQ0NPTVBf
TU9ERV9MSUdIVF9GSUxURVI6DQqhoaGhCQkvL2RvIGxpZ2h0IHN5c2NhbGwgZmlsdGVyLg0KoaGh
oQkJLi4uDQqhoaGhCQlicmVhazsNCqGhoaEJfQ0KoaGhoQkuLi4NCqGhoaF9DQqhoaGhCQkNCqGh
oaFpbnQgbGlnaHRfc3lzY2FsbF9maWx0ZXIoaW50IHN5c2NhbGxfbnVtKSB7DQqhoaGhCWlmKHNj
bm8gPiBTWVNOVU1fTUFYKSB7DQqhoaGhCQkuLi4NCqGhoaEJCXJldHVybiAtRUFDQ0VTUzsNCqGh
oaEJfQ0KoaGhoQ0KoaGhoQlib29sICpmaWx0ZXJfbWFwID0gZ2V0X2ZpbHRlcl9tYXAoY3VycmVu
dCk7DQqhoaGhCWlmKGZpbHRlcl9tYXAgPT0gTlVMTCkgew0KoaGhoQkJLi4uDQqhoaGhCQlyZXR1
cm4gLUVGQVVMVDsNCqGhoaEJfQ0KoaGhoQ0KoaGhoQlpZihmaWx0ZXJfbWFwW3N5c2NhbGxfbnVt
XSA9PSB0cnVlKSB7DQqhoaGhCQkuLi4NCqGhoaEJCXJldHVybiAwOw0KoaGhoQl9IGVsc2Ugew0K
oaGhoQkJLi4uDQqhoaGhCQlyZXR1cm4gLUVBQ0NFU1M7DQqhoaGhCX0NCqGhoaEJLi4uDQqhoaGh
fQ0K
