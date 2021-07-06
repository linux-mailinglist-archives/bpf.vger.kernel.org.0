Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C159F3BC502
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 05:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhGFDNw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 23:13:52 -0400
Received: from m13133.mail.163.com ([220.181.13.133]:26033 "EHLO
        m13133.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhGFDNv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 23:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=btXPk
        3NVfKYEXSvZLTMI+hCV7IDA5fc2XMrQib9ZXNQ=; b=mvY7cE1HLC3BBOXupL4B3
        Zl+LqN75Aw5VLWXgYA/SIq9tk4SHcIfSr9oQN1qrJK8og3IgNrVs6eKOkoYRkpCM
        kZdBTlAKNIp2uC9LaCmerMVUP9AtqS5pgqR7Io1QOjYA2d7Y0i8gef3Vr0WuUQ0Z
        1tXPToSPr9czzULXTA2wlY=
Received: from chapterk93$163.com ( [122.96.144.130] ) by
 ajax-webmail-wmsvr133 (Coremail) ; Tue, 6 Jul 2021 11:11:11 +0800 (CST)
X-Originating-IP: [122.96.144.130]
Date:   Tue, 6 Jul 2021 11:11:11 +0800 (CST)
From:   G <chapterk93@163.com>
To:     bpf@vger.kernel.org
Subject: using bpf_map_update_elem and bpf_map_get_next_key at the same time
 when looping through the hash map
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <51e18157.22f7.17a79cc5306.Coremail.chapterk93@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: hcGowABnfwvQyeNgpTj5AA--.36877W
X-CM-SenderInfo: hfkd135hunmji6rwjhhfrp/xtbBHB3G4F3l-rRjkAACsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgQlBGIEV4cGVydHMKCkknbSBoYXZpbmcgYW4gaXNzdWUgd2l0aCB1c2luZyAiYnBmX21hcF91
cGRhdGVfZWxlbSIgYW5kICAiYnBmX21hcF9nZXRfbmV4dF9rZXkiIGF0IHRoZSBzYW1lIHRpbWUg
d2hlbiBsb29waW5nIHRocm91Z2ggdGhlIGJwZiBIYXNoTWFwLgpNeSBwcm9ncmFtIHR1cm5zIHRv
IGFuIGluZmluaXRlIGxvb3AgYW5kIHRoZSBwc2V1ZG9jb2RlIGlzIGFzIGZvbGxvd2luZzoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiAgICBicGYuTWFwQ3JlYXRlICAgICAgICAgIC8vIHR5cGU9QlBG
X01BUF9UWVBFX0hBU0ggc2l6ZT0xMjgKICAgIGZvciB7IGJwZi5NYXBVcGRhdGUgfSAgLy8gYWRk
KHVwZGF0ZSkgMTI4IGVsZW1lbnRzIGF0IG9uY2UKCiAgICB0aGVuIGxvb3AgdGhyb3VnaCB0aGUg
bWFwIHRvIHVwZGF0ZSBlYWNoIGVsZW1lbnQKICAgIGJwZi5NYXBHZXROZXh0S2V5KGZkLCBuaWws
ICZzY2Fua2V5KSAvLyBmaW5kIGZpcnN0IGtleQogICAgZm9yIHsKICAgICAgICAgIGJwZi5NYXBV
cGF0ZShmZCwgJnNjYW5rZXksICZ2YWwsIEJQRl9FWElTVCkKICAgICAgICAgIGJwZi5NYXBHZXRO
ZXh0S2V5KGZkLCAmc2NhbmtleSwgJnNjYW5rZXkpCiAgICB9Ci0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQoKSSBoYXZlIHRyaWVkIHRvIHJlYWQgdGhlIHJlbGV2YW50IGtlcm5lbCBjb2RlLCBhbmQgc2Vl
bXMgbGlrZSBpdCBpcyBtb3ZpbmcgdGhlIGVsZW1lbnQgdG8gdGhlIHRvcCBvZiB0aGUgaGFzIGJ1
Y2tldCB3aGVuIGNhbGxpbmcgdGhlIKGwYnBmX21hcF91cGRhdGVfZWxlbaGxIGV2ZW4gdGhlIGVs
ZW1lbnQgYWxyZWFkeSBleGlzdHMgaW4gdGhlIGhhc2ggbWFwLiBTZWUgdGhlIGZvbGxvd2luZyBz
b3VyY2UgY29kZToKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAgICAvLyBrZXJuZWwvYnBmL2hhc2h0
YWIuYwogICAgaHRhYl9tYXBfdXBkYXRlX2VsZW0gewogICAgICAgIC4uLgogICAgICAgLyogYWRk
IG5ldyBlbGVtZW50IHRvIHRoZSBoZWFkIG9mIHRoZSBsaXN0LCBzbyB0aGF0CiAgICAgICAgKiBj
b25jdXJyZW50IHNlYXJjaCB3aWxsIGZpbmQgaXQgYmVmb3JlIG9sZCBlbGVtCiAgICAgICAgKi8K
ICAgICAgIGhsaXN0X251bGxzX2FkZF9oZWFkX3JjdSgmbF9uZXctPmhhc2hfbm9kZSwgaGVhZCk7
CiAgICAgICAgLi4uCiAgICB9Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKVGhlcmVmb3JlLCB3aGVu
IEkgd2FzIHRyeWluZyB0byB0cmF2ZXJzaW5nIHRoZSB0d28gZWxlbWVudHMgaW4gdGhlIHNhbWUg
aGFzaCBhIGJ1Y2tldCwgaXQgcmFuIGludG8gYW4gaW5maW5pdGUgbG9vcCBieSByZXBlYXRlZGx5
IGdldHRpbmcgdGhlIGtleSBvZiB0aGVzZSB0d28gZWxlbWVudHMuIE5vdCBzdXJlIG15IHVuZGVy
c3RhbmRpbmcgZm9yICJicGZfbWFwX3VwZGF0ZV9lbGVtImFuZCAiYnBmX21hcF9nZXRfbmV4dF9r
ZXkiIGlzIGNvcnJlY3Qgb3Igbm90LiBNeSBxdWVzdGlvbiBpczogaXMgdGhhdCBiZWhhdmUgYXMg
dGhlIGRlc2lnbj8gb3IgaXMgaXQgYSBidWcgZm9yIHRoZSBicGYgaGFzaG1hcD8gUGxlYXNlIGxl
dCBtZSBrbm93LCB0aGFua3MuCgpCZXN0IHJlZ2FyZHMKVy5HYW8=
