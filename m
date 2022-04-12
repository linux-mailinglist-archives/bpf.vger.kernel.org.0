Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0F4FDEC7
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbiDLL7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351861AbiDLL6U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 07:58:20 -0400
X-Greylist: delayed 1812 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 03:48:09 PDT
Received: from m13120.mail.163.com (m13120.mail.163.com [220.181.13.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEEBF63384;
        Tue, 12 Apr 2022 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=y8CH1
        IxFOfKaZYYzoqj/Pq91aVfntCrBc29DxGUhImU=; b=bTwEyVTG8xKAQyky6/tX1
        qeftydDpJ9IIUHuFrhC94IFM9yJwbH4ZRxoOpKxdmrKRvBzBfd1tKuV+ebUCzD77
        Jmb+hoCkNngHGrjO0mLZIUuoxa7K5Kj/j7CXtBItGldU9HyQQP9vPpwAOAOeex7P
        bwelRwPV6SyL9Pua5/hLek=
Received: from wujianguo106$163.com ( [36.111.140.142] ) by
 ajax-webmail-wmsvr120 (Coremail) ; Tue, 12 Apr 2022 18:02:28 +0800 (CST)
X-Originating-IP: [36.111.140.142]
Date:   Tue, 12 Apr 2022 18:02:28 +0800 (CST)
From:   "Jianguo Wu" <wujianguo106@163.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com
Subject: [bpf, Bug report] get an EPOLLRDHUP event before read all data from
 kernel buffer when using sockmap
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
Content-Type: multipart/mixed; 
        boundary="----=_Part_68102_3167284.1649757748392"
MIME-Version: 1.0
Message-ID: <66cf4c3f.4883.1801d397ca8.Coremail.wujianguo106@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: eMGowAAn9Zg0TlVi9zkSAA--.8909W
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9wngkF2MdA4KWgACs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

------=_Part_68102_3167284.1649757748392
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgYWxsLAogICAgSSBkaWQgc29tZSBlYnBmIHNvY2ttYXAgdGVzdCB1c2luZyBkZW1vIGZyb20g
aHR0cHM6Ly9naXRodWIuY29tL0FydGh1ckNoaWFvL3NvY2tldC1hY2NlbGVyYXRpb24td2l0aC1l
YnBmLAp0aGF0IHVzaW5nIGEgQlBGX1BST0dfVFlQRV9TT0NLX09QUyBwcm9nIHRvIHN0b3JlIGxv
Y2FsIHBhc3NpdmUvYWN0aXZlIGVzdGFibGlzaGVkIHNvY2tldCBpbiBhIEJQRl9NQVBfVFlQRV9T
T0NLSEFTSCBtYXAsCmFuZCB0aGVuIHVzZSBhIEJQRl9QUk9HX1RZUEVfU0tfTVNHIHByb2cgdG8g
cmVkaXJlY3QgbWVzc2FnZXMgYmV0d2VlbiB0d28gbG9jYWwgc29ja2V0cy4KICAgIEFuZCBpZiBJ
IHVzZSBuZ2lueCBhcyBhIHByb3h5LCB3ZWJmc2QgYXMgYSB1cHN0cmVhbSBzZXJ2ZXIsIGxpa2Ug
dGhpczogY3VybCA8LS0+IG5naW54KDE5Mi4xNjguMTc0LjEyODo4MCk8LS0+KHdlYmZzZCkxMjcu
MC4wLjE6ODA5MCwKaXQgaGlnaGx5IGRvd25sb2FkIGZhaWxlZCwgY3VybCBvbmx5IHJlY3YgcGFy
dGlhbCBkYXRhIGFuZCB3YXMgc3R1Y2suCiAgICBGcm9tIG5naW54IGRlYnVnIGxvZyhzZWUgdGhl
IGF0dGFjaGVkIGZpbGUpLCBpdCBzZWVtcyBuZ2lueCBnZXQgYW4gRVBPTExSREhVUCBldmVudCBi
ZWZvcmUgcmVhZCBhbGwgZGF0YSBmcm9tIGtlcm5lbCBidWZmZXIuCkkgdGhpbmsgaXQgaGFwcGVu
ZWQgbGlrZSB0aGlzOgogICAgMSlrZXJuZWwgc2VuZCBGSU4gYWZ0ZXIgd2ViZnNkIHNlbmQgb3V0
IGFsbCBkYXRhLCBhbmQgZm9yIG5naW54IHZpZXcsIHdoZW4ga2VybmVsIHJlY3YgdGhlIEZJTiwg
d2lsbCBzaHV0ZG93biByZWN2OgogICAgICB0Y3BfZmluKCk6IHNrLT5za19zaHV0ZG93biB8PSBS
Q1ZfU0hVVERPV047CiAgICAyKWFuZCBuZ2lueCB3aWxsIGdldCBhbiBFUE9MTFJESFVQIGV2ZW50
OgogICAgICB0Y3BfcG9sbCgpOgogICAgICBpZiAoc2stPnNrX3NodXRkb3duICYgUkNWX1NIVVRE
T1dOKQogICAgICAgICAgbWFzayB8PSBFUE9MTElOIHwgRVBPTExSRE5PUk0gfCBFUE9MTFJESFVQ
OwogICAgMylzbyBuZ2lueCB3aWxsIG5vdCByZWFkIGFsbCBkYXRhIHRoYXQgYWxyZWFkeSBpbiBr
ZXJuZWwgcmVjdiBidWZmZXI/CgpJcyB0aGlzIGEga2VybmVsIGVicGYvdGNwIEJVRz8=
------=_Part_68102_3167284.1649757748392
Content-Type: text/plain; name=ngx-access-debug-log.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ngx-access-debug-log.txt"

ICBbcm9vdEBsb2NhbGhvc3QgYnBmXSMgY3VybCAtdm8gL2Rldi9udWxsIGh0dHA6Ly8xOTIuMTY4
LjE3NC4xMjg6ODAvDQogICogQWJvdXQgdG8gY29ubmVjdCgpIHRvIDE5Mi4xNjguMTc0LjEyOCBw
b3J0IDgwICgjMCkNCiAgKiAgIFRyeWluZyAxOTIuMTY4LjE3NC4xMjguLi4NCiAgICAlIFRvdGFs
ICAgICUgUmVjZWl2ZWQgJSBYZmVyZCAgQXZlcmFnZSBTcGVlZCAgIFRpbWUgICAgVGltZSAgICAg
VGltZSAgQ3VycmVudA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEbG9hZCAg
VXBsb2FkICAgVG90YWwgICBTcGVudCAgICBMZWZ0ICBTcGVlZA0KICAgIDAgICAgIDAgICAgMCAg
ICAgMCAgICAwICAgICAwICAgICAgMCAgICAgIDAgLS06LS06LS0gLS06LS06LS0gLS06LS06LS0g
ICAgIDAqIENvbm5lY3RlZCB0byAxOTIuMTY4LjE3NC4xMjggKDE5Mi4xNjguMTc0LjEyOCkgcG9y
dCA4MCAoIzApDQogID4gR0VUIC8gSFRUUC8xLjENCiAgPiBVc2VyLUFnZW50OiBjdXJsLzcuMjku
MA0KICA+IEhvc3Q6IDE5Mi4xNjguMTc0LjEyOA0KICA+IEFjY2VwdDogKi8qDQogID4NCiAgPCBI
VFRQLzEuMSAyMDAgT0sNCiAgPCBTZXJ2ZXI6IG5naW54LzEuMjAuMQ0KICA8IERhdGU6IFR1ZSwg
MTIgQXByIDIwMjIgMDc6MzQ6MzcgR01UDQogIDwgQ29udGVudC1UeXBlOiB0ZXh0L2h0bWwNCiAg
PCBDb250ZW50LUxlbmd0aDogODk0OA0KICA8IENvbm5lY3Rpb246IGtlZXAtYWxpdmUNCiAgPCBB
Y2NlcHQtUmFuZ2VzOiBieXRlcw0KICA8IExhc3QtTW9kaWZpZWQ6IEZyaSwgMDEgQXByIDIwMjIg
MDk6NTM6MDYgR01UDQogIDwNCiAgeyBbZGF0YSBub3Qgc2hvd25dDQogICA4OSAgODk0OCAgIDg5
ICA3OTgyICAgIDAgICAgIDAgICAzNTQ0ICAgICAgMCAgMDowMDowMiAgMDowMDowMiAtLTotLTot
LSAgMzU0NA0KDQo9PT09PW5naW54IGxvZz09PT09PT09PQ0KMjAyMi8wNC8xMSAxNTozMjoyMyBb
ZGVidWddIDQwNDcjNDA0NzogYWNjZXB0IG9uIDAuMC4wLjA6ODAsIHJlYWR5OiAwDQoyMDIyLzA0
LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiBwb3NpeF9tZW1hbGlnbjogMDAwMDU1QzE0
MjZGREE2MDo1MTIgQDE2DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAq
NDUgYWNjZXB0OiAxOTIuMTY4LjE3NC4xMjg6NjE4MjggZmQ6Mw0KMjAyMi8wNC8xMSAxNTozMjoy
MyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGV2ZW50IHRpbWVyIGFkZDogMzogNjAwMDA6NDYyODQ3
MA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHJldXNhYmxlIGNv
bm5lY3Rpb246IDENCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBl
cG9sbCBhZGQgZXZlbnQ6IGZkOjMgb3A6MSBldjo4MDAwMjAwMQ0KMjAyMi8wNC8xMSAxNTozMjoy
MyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgd2FpdCByZXF1ZXN0IGhhbmRsZXINCjIwMjIv
MDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBtYWxsb2M6IDAwMDA1NUMxNDI2
RkRDNzA6MTAyNA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHJl
Y3Y6IGVvZjowLCBhdmFpbDotMQ0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0
NzogKjQ1IHJlY3Y6IGZkOjMgNzkgb2YgMTAyNA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWdd
IDQwNDcjNDA0NzogKjQ1IHJldXNhYmxlIGNvbm5lY3Rpb246IDANCjIwMjIvMDQvMTEgMTU6MzI6
MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwb3NpeF9tZW1hbGlnbjogMDAwMDU1QzE0MjZGMEMx
MDo0MDk2IEAxNg0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0
dHAgcHJvY2VzcyByZXF1ZXN0IGxpbmUNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3
IzQwNDc6ICo0NSBodHRwIHJlcXVlc3QgbGluZTogIkdFVCAvIEhUVFAvMS4xIg0KMjAyMi8wNC8x
MSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgdXJpOiAiLyINCjIwMjIvMDQv
MTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIGFyZ3M6ICIiDQoyMDIyLzA0
LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBleHRlbjogIiINCjIwMjIv
MDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwb3NpeF9tZW1hbGlnbjogMDAw
MDU1QzE0MjZCNUJCMDo0MDk2IEAxNg0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcj
NDA0NzogKjQ1IGh0dHAgcHJvY2VzcyByZXF1ZXN0IGhlYWRlciBsaW5lDQoyMDIyLzA0LzExIDE1
OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBoZWFkZXI6ICJVc2VyLUFnZW50OiBj
dXJsLzcuMjkuMCINCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBo
dHRwIGhlYWRlcjogIkhvc3Q6IDE5Mi4xNjguMTc0LjEyOCINCjIwMjIvMDQvMTEgMTU6MzI6MjMg
W2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIGhlYWRlcjogIkFjY2VwdDogKi8qIg0KMjAyMi8w
NC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgaGVhZGVyIGRvbmUNCjIw
MjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBldmVudCB0aW1lciBkZWw6
IDM6IDQ2Mjg0NzANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBn
ZW5lcmljIHBoYXNlOiAwDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAq
NDUgcmV3cml0ZSBwaGFzZTogMQ0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0
NzogKjQ1IHRlc3QgbG9jYXRpb246ICIvIg0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQw
NDcjNDA0NzogKjQ1IHVzaW5nIGNvbmZpZ3VyYXRpb24gIi8iDQoyMDIyLzA0LzExIDE1OjMyOjIz
IFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBjbDotMSBtYXg6MTA0ODU3Ng0KMjAyMi8wNC8x
MSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHJld3JpdGUgcGhhc2U6IDMNCjIwMjIv
MDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwb3N0IHJld3JpdGUgcGhhc2U6
IDQNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBnZW5lcmljIHBo
YXNlOiA1DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgZ2VuZXJp
YyBwaGFzZTogNg0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGdl
bmVyaWMgcGhhc2U6IDcNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0
NSBnZW5lcmljIHBoYXNlOiA4DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3
OiAqNDUgYWNjZXNzIHBoYXNlOiA5DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0
MDQ3OiAqNDUgYWNjZXNzIHBoYXNlOiAxMA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQw
NDcjNDA0NzogKjQ1IGFjY2VzcyBwaGFzZTogMTENCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVn
XSA0MDQ3IzQwNDc6ICo0NSBwb3N0IGFjY2VzcyBwaGFzZTogMTINCjIwMjIvMDQvMTEgMTU6MzI6
MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBnZW5lcmljIHBoYXNlOiAxMw0KMjAyMi8wNC8xMSAx
NTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGdlbmVyaWMgcGhhc2U6IDE0DQoyMDIyLzA0
LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBpbml0IHVwc3RyZWFtLCBj
bGllbnQgdGltZXI6IDANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0
NSBlcG9sbCBhZGQgZXZlbnQ6IGZkOjMgb3A6MyBldjo4MDAwMjAwNQ0KMjAyMi8wNC8xMSAxNToz
MjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgc2NyaXB0IGNvcHk6ICJIb3N0Ig0KMjAy
Mi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgc2NyaXB0IHZhcjog
IjEyNy4wLjAuMTo4MDkwIg0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0Nzog
KjQ1IGh0dHAgc2NyaXB0IGNvcHk6ICJDb25uZWN0aW9uIg0KMjAyMi8wNC8xMSAxNTozMjoyMyBb
ZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgc2NyaXB0IGNvcHk6ICJjbG9zZSINCjIwMjIvMDQv
MTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIHNjcmlwdCBjb3B5OiAiIg0K
MjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgc2NyaXB0IGNv
cHk6ICIiDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBw
cm94eSBoZWFkZXI6ICJVc2VyLUFnZW50OiBjdXJsLzcuMjkuMCINCjIwMjIvMDQvMTEgMTU6MzI6
MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIHByb3h5IGhlYWRlcjogIkFjY2VwdDogKi8q
Ig0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgcHJveHkg
aGVhZGVyOg0KIkdFVCAvIEhUVFAvMS4wDQpIb3N0OiAxMjcuMC4wLjE6ODA5MA0KQ29ubmVjdGlv
bjogY2xvc2UNClVzZXItQWdlbnQ6IGN1cmwvNy4yOS4wDQpBY2NlcHQ6ICovKg0KDQoiDQoyMDIy
LzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBjbGVhbnVwIGFkZDog
MDAwMDU1QzE0MjZCNjRFMA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0Nzog
KjQ1IGdldCByciBwZWVyLCB0cnk6IDENCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3
IzQwNDc6ICo0NSBzdHJlYW0gc29ja2V0IDQNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0
MDQ3IzQwNDc6ICo0NSBlcG9sbCBhZGQgY29ubmVjdGlvbjogZmQ6NCBldjo4MDAwMjAwNQ0KMjAy
Mi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGNvbm5lY3QgdG8gMTI3LjAu
MC4xOjgwOTAsIGZkOjQgIzQ2DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3
OiAqNDUgaHR0cCB1cHN0cmVhbSBjb25uZWN0OiAtMg0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVi
dWddIDQwNDcjNDA0NzogKjQ1IHBvc2l4X21lbWFsaWduOiAwMDAwNTVDMTQyNkFDNkQwOjEyOCBA
MTYNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBldmVudCB0aW1l
ciBhZGQ6IDQ6IDYwMDAwOjQ2Mjg0NzANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3
IzQwNDc6ICo0NSBodHRwIGZpbmFsaXplIHJlcXVlc3Q6IC00LCAiLz8iIGE6MSwgYzoyDQoyMDIy
LzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCByZXF1ZXN0IGNvdW50
OjIgYmxrOjANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRw
IHJ1biByZXF1ZXN0OiAiLz8iDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3
OiAqNDUgaHR0cCB1cHN0cmVhbSBjaGVjayBjbGllbnQsIHdyaXRlIGV2ZW50OjEsICIvIg0KMjAy
Mi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgdXBzdHJlYW0gcmVx
dWVzdDogIi8/Ig0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0
dHAgdXBzdHJlYW0gc2VuZCByZXF1ZXN0IGhhbmRsZXINCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2Rl
YnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIHVwc3RyZWFtIHNlbmQgcmVxdWVzdA0KMjAyMi8wNC8x
MSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgdXBzdHJlYW0gc2VuZCByZXF1
ZXN0IGJvZHkNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBjaGFp
biB3cml0ZXIgYnVmIGZsOjEgczo5Nw0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcj
NDA0NzogKjQ1IGNoYWluIHdyaXRlciBpbjogMDAwMDU1QzE0MjZCNjUyMA0KMjAyMi8wNC8xMSAx
NTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHdyaXRldjogOTcgb2YgOTcNCjIwMjIvMDQv
MTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBjaGFpbiB3cml0ZXIgb3V0OiAwMDAw
MDAwMDAwMDAwMDAwDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUg
ZXZlbnQgdGltZXIgZGVsOiA0OiA0NjI4NDcwDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10g
NDA0NyM0MDQ3OiAqNDUgZXZlbnQgdGltZXIgYWRkOiA0OiA2MDAwMDo0NjI4NDcwDQoyMDIyLzA0
LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCB1cHN0cmVhbSByZXF1ZXN0
OiAiLz8iDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCB1
cHN0cmVhbSBwcm9jZXNzIGhlYWRlcg0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcj
NDA0NzogKjQ1IG1hbGxvYzogMDAwMDU1QzE0MjZFMjMzMDo0MDk2DQoyMDIyLzA0LzExIDE1OjMy
OjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgcmVjdjogZW9mOjEsIGF2YWlsOi0xDQoyMDIyLzA0
LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgcmVjdjogZmQ6NCA0MDk2IG9mIDQw
OTYNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSByZWN2OiBhdmFp
bDowDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBwcm94
eSBzdGF0dXMgMjAwICIyMDAgT0siDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0
MDQ3OiAqNDUgaHR0cCBwcm94eSBoZWFkZXI6ICJTZXJ2ZXI6IHdlYmZzLzEuMjEiDQoyMDIyLzA0
LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBwcm94eSBoZWFkZXI6ICJD
b25uZWN0aW9uOiBDbG9zZSINCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6
ICo0NSBodHRwIHByb3h5IGhlYWRlcjogIkFjY2VwdC1SYW5nZXM6IGJ5dGVzIg0KMjAyMi8wNC8x
MSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgcHJveHkgaGVhZGVyOiAiQ29u
dGVudC1UeXBlOiB0ZXh0L2h0bWwiDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0
MDQ3OiAqNDUgaHR0cCBwcm94eSBoZWFkZXI6ICJDb250ZW50LUxlbmd0aDogODk0OCINCjIwMjIv
MDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIHByb3h5IGhlYWRlcjog
Ikxhc3QtTW9kaWZpZWQ6IEZyaSwgMDEgQXByIDIwMjIgMDk6NTM6MDYgR01UIg0KMjAyMi8wNC8x
MSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgcHJveHkgaGVhZGVyOiAiRGF0
ZTogTW9uLCAxMSBBcHIgMjAyMiAwNzozMjoyMyBHTVQiDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtk
ZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBwcm94eSBoZWFkZXIgZG9uZQ0KMjAyMi8wNC8xMSAx
NTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IEhUVFAvMS4xIDIwMCBPSw0KU2VydmVyOiBu
Z2lueC8xLjIwLjENCkRhdGU6IE1vbiwgMTEgQXByIDIwMjIgMDc6MzI6MjMgR01UDQpDb250ZW50
LVR5cGU6IHRleHQvaHRtbA0KQ29udGVudC1MZW5ndGg6IDg5NDgNCkNvbm5lY3Rpb246IGtlZXAt
YWxpdmUNCkFjY2VwdC1SYW5nZXM6IGJ5dGVzDQpMYXN0LU1vZGlmaWVkOiBGcmksIDAxIEFwciAy
MDIyIDA5OjUzOjA2IEdNVA0KDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3
OiAqNDUgd3JpdGUgbmV3IGJ1ZiB0OjEgZjowIDAwMDA1NUMxNDI2QjY4NzAsIHBvcyAwMDAwNTVD
MTQyNkI2ODcwLCBzaXplOiAyMTcgZmlsZTogMCwgc2l6ZTogMA0KMjAyMi8wNC8xMSAxNTozMjoy
MyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgd3JpdGUgZmlsdGVyOiBsOjAgZjowIHM6MjE3
DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCBjYWNoZWFi
bGU6IDANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIHBy
b3h5IGZpbHRlciBpbml0IHM6MjAwIGg6MCBjOjAgbDo4OTQ4DQoyMDIyLzA0LzExIDE1OjMyOjIz
IFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCB1cHN0cmVhbSBwcm9jZXNzIHVwc3RyZWFtDQoy
MDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgcGlwZSByZWFkIHVwc3Ry
ZWFtOiAxDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgcGlwZSBw
cmVyZWFkOiAzODg2DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUg
aW5wdXQgYnVmICMwDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUg
bWFsbG9jOiAwMDAwNTVDMTQyNkFGM0EwOjQwOTYNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVn
XSA0MDQ3IzQwNDc6ICo0NSByZWFkdjogZW9mOjEsIGF2YWlsOjANCjIwMjIvMDQvMTEgMTU6MzI6
MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSByZWFkdjogMSwgbGFzdDo0MDk2DQoyMDIyLzA0LzEx
IDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgcmVhZHY6IGF2YWlsOjANCjIwMjIvMDQv
MTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwaXBlIHJlY3YgY2hhaW46IDQwOTYN
CjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBpbnB1dCBidWYgIzEN
CjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwaXBlIGJ1ZiBpbiAg
IHM6MSB0OjEgZjowIDAwMDA1NUMxNDI2RTIzMzAsIHBvcyAwMDAwNTVDMTQyNkUyNDAyLCBzaXpl
OiAzODg2IGZpbGU6IDAsIHNpemU6IDANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3
IzQwNDc6ICo0NSBwaXBlIGJ1ZiBpbiAgIHM6MSB0OjEgZjowIDAwMDA1NUMxNDI2QUYzQTAsIHBv
cyAwMDAwNTVDMTQyNkFGM0EwLCBzaXplOiA0MDk2IGZpbGU6IDAsIHNpemU6IDANCjIwMjIvMDQv
MTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwaXBlIGxlbmd0aDogOTY2IC8vID0g
ODk0OCAtIDM4ODYgLSA0MDk2DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3
OiAqNDUgcGlwZSB3cml0ZSBkb3duc3RyZWFtOiAxDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1
Z10gNDA0NyM0MDQ3OiAqNDUgcGlwZSB3cml0ZSBidXN5OiAwDQoyMDIyLzA0LzExIDE1OjMyOjIz
IFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgcGlwZSB3cml0ZSBidWYgbHM6MSAwMDAwNTVDMTQyNkUy
NDAyIDM4ODYNCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwaXBl
IHdyaXRlIGJ1ZiBsczoxIDAwMDA1NUMxNDI2QUYzQTAgNDA5Ng0KMjAyMi8wNC8xMSAxNTozMjoy
MyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHBpcGUgd3JpdGU6IG91dDowMDAwNTVDMTQyNkI2QTg4
LCBmOjANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBodHRwIG91
dHB1dCBmaWx0ZXIgIi8/Ig0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0Nzog
KjQ1IGh0dHAgY29weSBmaWx0ZXI6ICIvPyINCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0
MDQ3IzQwNDc6ICo0NSBwb3NpeF9tZW1hbGlnbjogMDAwMDU1QzE0MjZCMDNCMDo0MDk2IEAxNg0K
MjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgcG9zdHBvbmUg
ZmlsdGVyICIvPyIgMDAwMDU1QzE0MjZCNkE3OA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWdd
IDQwNDcjNDA0NzogKjQ1IHdyaXRlIG9sZCBidWYgdDoxIGY6MCAwMDAwNTVDMTQyNkI2ODcwLCBw
b3MgMDAwMDU1QzE0MjZCNjg3MCwgc2l6ZTogMjE3IGZpbGU6IDAsIHNpemU6IDANCjIwMjIvMDQv
MTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSB3cml0ZSBuZXcgYnVmIHQ6MSBmOjAg
MDAwMDU1QzE0MjZFMjMzMCwgcG9zIDAwMDA1NUMxNDI2RTI0MDIsIHNpemU6IDM4ODYgZmlsZTog
MCwgc2l6ZTogMA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHdy
aXRlIG5ldyBidWYgdDoxIGY6MCAwMDAwNTVDMTQyNkFGM0EwLCBwb3MgMDAwMDU1QzE0MjZBRjNB
MCwgc2l6ZTogNDA5NiBmaWxlOiAwLCBzaXplOiAwDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1
Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCB3cml0ZSBmaWx0ZXI6IGw6MCBmOjEgczo4MTk5DQoyMDIy
LzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCB3cml0ZSBmaWx0ZXIg
bGltaXQgMA0KMjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHdyaXRl
djogODE5OSBvZiA4MTk5DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAq
NDUgaHR0cCB3cml0ZSBmaWx0ZXIgMDAwMDAwMDAwMDAwMDAwMA0KMjAyMi8wNC8xMSAxNTozMjoy
MyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IGh0dHAgY29weSBmaWx0ZXI6IDAgIi8/Ig0KMjAyMi8w
NC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHBpcGUgd3JpdGUgYnVzeTogMA0K
MjAyMi8wNC8xMSAxNTozMjoyMyBbZGVidWddIDQwNDcjNDA0NzogKjQ1IHBpcGUgd3JpdGU6IG91
dDowMDAwMDAwMDAwMDAwMDAwLCBmOjANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3
IzQwNDc6ICo0NSBwaXBlIHJlYWQgdXBzdHJlYW06IDANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2Rl
YnVnXSA0MDQ3IzQwNDc6ICo0NSBwaXBlIGJ1ZiBmcmVlIHM6MCB0OjEgZjowIDAwMDA1NUMxNDI2
RTIzMzAsIHBvcyAwMDAwNTVDMTQyNkUyMzMwLCBzaXplOiAwIGZpbGU6IDAsIHNpemU6IDANCjIw
MjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6ICo0NSBwaXBlIGJ1ZiBmcmVlIHM6
MCB0OjEgZjowIDAwMDA1NUMxNDI2QUYzQTAsIHBvcyAwMDAwNTVDMTQyNkFGM0EwLCBzaXplOiAw
IGZpbGU6IDAsIHNpemU6IDANCjIwMjIvMDQvMTEgMTU6MzI6MjMgW2RlYnVnXSA0MDQ3IzQwNDc6
ICo0NSBwaXBlIGxlbmd0aDogOTY2DQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0
MDQ3OiAqNDUgZXZlbnQgdGltZXI6IDQsIG9sZDogNDYyODQ3MCwgbmV3OiA0NjI4NDcxDQoyMDIy
LzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0cCB1cHN0cmVhbSByZXF1
ZXN0OiAiLz8iDQoyMDIyLzA0LzExIDE1OjMyOjIzIFtkZWJ1Z10gNDA0NyM0MDQ3OiAqNDUgaHR0
cCB1cHN0cmVhbSBkdW1teSBoYW5kbGVy
------=_Part_68102_3167284.1649757748392--

