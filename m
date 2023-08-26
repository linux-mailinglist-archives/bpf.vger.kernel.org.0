Return-Path: <bpf+bounces-8743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D5789653
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B591D281982
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CAD517;
	Sat, 26 Aug 2023 11:36:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F067E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 11:36:41 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D1E54
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 04:36:38 -0700 (PDT)
Date: Sat, 26 Aug 2023 11:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1693049795; x=1693308995;
	bh=OGBoSNSsrCHKDTgHI0wmKH4R38z77LUTwxdILZJ7ATU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ws4NfQ/NtDSyzdW1IRW9ZrZzR35tFv7vfhyVKN49b6BNfivCxDDk87M2b9GYq8kCW
	 TKnh7j/O+Kv4hN+pKu5aAcBfZ/Bfi4EVsPWRaq9oa4DuoGeuvrxRamgyUw1PnokuiT
	 +Ncs2+xRowYqv3KY+1xPg3wO+ApN/LJsHFEmSy9rtbdLXSI+yCmAb9RaUICLl7vLWJ
	 /sDg9D6dMcllgYw2npU1/xM1j+DfvgMRTptFa2A24hWAtxbjGeAo/+hgqqGnN5o0po
	 uPv/MwGYusVA7O4seqlD5uuFPBAQeqOPadW/Owvn91ZV9luAcgSqgl6cbt/YPjTmh9
	 52bNrYI40LFhA==
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Lasha Khasaia <khasaia@pm.me>
Subject: libbpf: map 'my_pid_map': unsupported map linkage static - xmake
Message-ID: <5rDl7ltwN1XQQwmvJ-PPRNmK9F3FXjI3b5i3mILDbJoFxwZo9Dtb_x-ET2OVCsqC-EQlSd_svSnGEXxkt7etZcnNt8TjrDYGUWfZ8eQLkmI=@pm.me>
Feedback-ID: 6255285:user:proton
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------01be434c0bf771b5269992e6f9e9112d2911f7537dda9121d5a2d23e033dd90a"; charset=utf-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------01be434c0bf771b5269992e6f9e9112d2911f7537dda9121d5a2d23e033dd90a
Content-Type: multipart/mixed;boundary=---------------------2bb99394a2db98ad84114ca586255aeb

-----------------------2bb99394a2db98ad84114ca586255aeb
Content-Type: multipart/alternative;boundary=---------------------5cbb778a1951cd835fd671b23496ecca

-----------------------5cbb778a1951cd835fd671b23496ecca
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,

I have an issue to compile ebpf prog via xmake.

I have following map:
```c
struct
{
=C2=A0 __uint(type, BPF_MAP_TYPE_RINGBUF);
=C2=A0 __uint(max_entries, MAX_ENTRIES);
} ring_map SEC(".maps");
```
under v7.0.0 it works, under v7.1.0 and v7.2.0 getting an error:
"bpftool gen skeleton build/.gens/xxx/android/x86_64/release/rules/bpf/xxx=
.bpf.o -d -p"

```c
libbpf: map 'xxx': unsupported map linkage static.
{
=C2=A0 =C2=A0 "error": "failed to open BPF object file: Operation not supp=
orted"
}
```
---
Reproduce error:
---

On the system there is bpftool v7.0.0 installed:
```
bpftool v7.0.0
using libbpf v1.0
features: libbpf_strict, skeletons
```

Get libbpf-bootstrap repo
`git clone --recurse-submodules https://github.com/libbpf/libbpf-bootstrap=
`

try to compile for Android via xmake according to the readme file:
```
$ git submodule update --init --recursive =C2=A0 =C2=A0 =C2=A0 # check out=
 libbpf
$ cd examples/c
$ xmake f -p android
$ xmake
```

works.

---

Update the bpftool to v7.1.0 or v7.2.0

`git clone --depth 1 --branch v7.1.0 ... && make install`
`bpftool version`:
```
bpftool v7.1.0
using libbpf v1.1
features: llvm, skeletons
```

try again to compile via xmake:
```
[ 13%]: compiling.bpf uprobe.bpf.c
[ 13%]: compiling.bpf minimal.bpf.c
[ 13%]: compiling.bpf fentry.bpf.c
[ 13%]: compiling.bpf minimal_legacy.bpf.c
[ 17%]: cache compiling.release ../../libbpf/src/libbpf.c
[ 33%]: cache compiling.release ../../libbpf/src/netlink.c
[ 44%]: cache compiling.release ../../libbpf/src/bpf.c
[ 44%]: compiling.bpf bootstrap.bpf.c
libbpf: map 'my_pid_map': unsupported map linkage static.
Error: failed to open BPF object file: Operation not supported
error: execv(bpftool gen skeleton build/.gens/minimal_legacy/android/armea=
bi-v7a/release/rules/bpf/minimal_legacy.bpf.o) failed(161)
```

failed.

Seems like its for all .maps not only ringbuf.

---
Same for `v.7.2.0`

I created ticket as well on GitHub: https://github.com/libbpf/libbpf/issue=
s/720
Seems like it's a bug

Regads,
Grubeli
-----------------------5cbb778a1951cd835fd671b23496ecca
Content-Type: multipart/related;boundary=---------------------998b9d3087abcfd74ee7ec944fe4e934

-----------------------998b9d3087abcfd74ee7ec944fe4e934
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXpl
OiAxNHB4OyI+SGVsbG8sPGJyPjxicj5JIGhhdmUgYW4gaXNzdWUgdG8gY29tcGlsZSBlYnBmIHBy
b2cgdmlhIHhtYWtlLjxicj48YnI+PHNwYW4+PC9zcGFuPjxkaXY+PHNwYW4+SSBoYXZlIGZvbGxv
d2luZyBtYXA6PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YGBgYzwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPnN0cnVjdDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPns8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgX191aW50KHR5cGUsIEJQRl9NQVBfVFlQRV9SSU5HQlVGKTs8L3NwYW4+PC9kaXY+
PGRpdj48c3Bhbj4mbmJzcDsgX191aW50KG1heF9lbnRyaWVzLCBNQVhfRU5UUklFUyk7PC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4+fSByaW5nX21hcCBTRUMoIi5tYXBzIik7PC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+YGBgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dW5kZXIgdjcuMC4wIGl0IHdvcmtz
LCB1bmRlciB2Ny4xLjAgYW5kIHY3LjIuMCBnZXR0aW5nIGFuIGVycm9yOjwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPiJicGZ0b29sIGdlbiBza2VsZXRvbiBidWlsZC8uZ2Vucy94eHgvYW5kcm9pZC94
ODZfNjQvcmVsZWFzZS9ydWxlcy9icGYveHh4LmJwZi5vIC1kIC1wIjwvc3Bhbj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PjxzcGFuPmBgYGM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5saWJicGY6
IG1hcCAneHh4JzogdW5zdXBwb3J0ZWQgbWFwIGxpbmthZ2Ugc3RhdGljLjwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPns8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ICJlcnJvciI6
ICJmYWlsZWQgdG8gb3BlbiBCUEYgb2JqZWN0IGZpbGU6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVk
Ijwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPn08L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5gYGA8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4tLS08L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5SZXByb2R1Y2Ug
ZXJyb3I6PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+LS0tPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PHNwYW4+T24gdGhlIHN5c3RlbSB0aGVyZSBpcyBicGZ0b29sIHY3LjAuMCBpbnN0
YWxsZWQ6PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YGBgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
YnBmdG9vbCB2Ny4wLjA8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj51c2luZyBsaWJicGYgdjEuMDwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmZlYXR1cmVzOiBsaWJicGZfc3RyaWN0LCBza2VsZXRvbnM8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5gYGA8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj48c3Bhbj5HZXQgbGliYnBmLWJvb3RzdHJhcCByZXBvPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
YGdpdCBjbG9uZSAtLXJlY3Vyc2Utc3VibW9kdWxlcyA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5j
b20vbGliYnBmL2xpYmJwZi1ib290c3RyYXBgIiByZWw9Im5vcmVmZXJyZXIgbm9mb2xsb3cgbm9v
cGVuZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vbGliYnBmL2xpYmJwZi1i
b290c3RyYXBgPC9hPjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPnRyeSB0
byBjb21waWxlIGZvciBBbmRyb2lkIHZpYSB4bWFrZSBhY2NvcmRpbmcgdG8gdGhlIHJlYWRtZSBm
aWxlOjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmBgYDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiQg
Z2l0IHN1Ym1vZHVsZSB1cGRhdGUgLS1pbml0IC0tcmVjdXJzaXZlICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICMgY2hlY2sgb3V0IGxpYmJwZjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiQgY2QgZXhhbXBs
ZXMvYzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiQgeG1ha2UgZiAtcCBhbmRyb2lkPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+JCB4bWFrZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmBgYDwvc3Bhbj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPndvcmtzLjwvc3Bhbj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PjxzcGFuPi0tLTwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxz
cGFuPlVwZGF0ZSB0aGUgYnBmdG9vbCB0byB2Ny4xLjAgb3IgdjcuMi4wPGJyPjwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuPmBnaXQgY2xvbmUgLS1kZXB0aCAxIC0tYnJhbmNoIHY3LjEuMCAuLi4gJmFt
cDsmYW1wOyBtYWtlIGluc3RhbGxgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YGJwZnRvb2wgdmVy
c2lvbmA6PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YGBgPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
YnBmdG9vbCB2Ny4xLjA8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj51c2luZyBsaWJicGYgdjEuMTwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmZlYXR1cmVzOiBsbHZtLCBza2VsZXRvbnM8L3NwYW4+PC9k
aXY+PGRpdj48c3Bhbj5gYGA8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj50
cnkgYWdhaW4gdG8gY29tcGlsZSB2aWEgeG1ha2U6PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YGBg
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+WyAxMyVdOiBjb21waWxpbmcuYnBmIHVwcm9iZS5icGYu
Yzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPlsgMTMlXTogY29tcGlsaW5nLmJwZiBtaW5pbWFsLmJw
Zi5jPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+WyAxMyVdOiBjb21waWxpbmcuYnBmIGZlbnRyeS5i
cGYuYzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPlsgMTMlXTogY29tcGlsaW5nLmJwZiBtaW5pbWFs
X2xlZ2FjeS5icGYuYzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPlsgMTclXTogY2FjaGUgY29tcGls
aW5nLnJlbGVhc2UgLi4vLi4vbGliYnBmL3NyYy9saWJicGYuYzwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPlsgMzMlXTogY2FjaGUgY29tcGlsaW5nLnJlbGVhc2UgLi4vLi4vbGliYnBmL3NyYy9uZXRs
aW5rLmM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5bIDQ0JV06IGNhY2hlIGNvbXBpbGluZy5yZWxl
YXNlIC4uLy4uL2xpYmJwZi9zcmMvYnBmLmM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5bIDQ0JV06
IGNvbXBpbGluZy5icGYgYm9vdHN0cmFwLmJwZi5jPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+bGli
YnBmOiBtYXAgJ215X3BpZF9tYXAnOiB1bnN1cHBvcnRlZCBtYXAgbGlua2FnZSBzdGF0aWMuPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+RXJyb3I6IGZhaWxlZCB0byBvcGVuIEJQRiBvYmplY3QgZmls
ZTogT3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQ8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5lcnJvcjoK
IGV4ZWN2KGJwZnRvb2wgZ2VuIHNrZWxldG9uIApidWlsZC8uZ2Vucy9taW5pbWFsX2xlZ2FjeS9h
bmRyb2lkL2FybWVhYmktdjdhL3JlbGVhc2UvcnVsZXMvYnBmL21pbmltYWxfbGVnYWN5LmJwZi5v
KQogZmFpbGVkKDE2MSk8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5gYGA8L3NwYW4+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48c3Bhbj5mYWlsZWQuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PHNwYW4+U2VlbXMgbGlrZSBpdHMgZm9yIGFsbCAubWFwcyBub3Qgb25seSByaW5nYnVm
Ljwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPi0tLTwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPlNhbWUgZm9yIGB2LjcuMi4wYDxicj48YnI+PHNwYW4+SSBjcmVhdGVkIHRpY2tl
dCBhcyB3ZWxsIG9uIEdpdEh1YjogPHNwYW4+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL2xp
YmJwZi9saWJicGYvaXNzdWVzLzcyMCIgcmVsPSJub3JlZmVycmVyIG5vZm9sbG93IG5vb3BlbmVy
IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL2xpYmJwZi9saWJicGYvaXNzdWVz
LzcyMDxicj48YnI+PC9hPjxicj5TZWVtcyBsaWtlIGl0J3MgYSBidWc8L3NwYW4+PC9zcGFuPjxi
cj48YnI+UmVnYWRzLDxicj5HcnViZWxpPC9zcGFuPjwvZGl2Pjxicj48L2Rpdj4KPGRpdiBjbGFz
cz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2sgcHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2st
ZW1wdHkiIHN0eWxlPSJmb250LWZhbWlseTogSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNp
emU6IDE0cHg7Ij4KICAgIDxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXVz
ZXIgcHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stZW1wdHkiPgogICAgICAgIAogICAgICAgICAg
ICA8L2Rpdj4KICAgIAogICAgICAgICAgICA8ZGl2IGNsYXNzPSJwcm90b25tYWlsX3NpZ25hdHVy
ZV9ibG9jay1wcm90b24gcHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stZW1wdHkiPgogICAgICAg
IAogICAgICAgICAgICA8L2Rpdj4KPC9kaXY+Cg==
-----------------------998b9d3087abcfd74ee7ec944fe4e934--
-----------------------5cbb778a1951cd835fd671b23496ecca--
-----------------------2bb99394a2db98ad84114ca586255aeb
Content-Type: application/pgp-keys; filename="publickey - khasaia@pm.me - 0xAC812A1F.asc"; name="publickey - khasaia@pm.me - 0xAC812A1F.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - khasaia@pm.me - 0xAC812A1F.asc"; name="publickey - khasaia@pm.me - 0xAC812A1F.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWFBwWmt4WUpLd1lCQkFI
YVJ3OEJBUWRBWFJBR0s2SlJWTXVLcmZIYlVsN1F0Y3pZWTB0Mmhnb2IKajFQL0ZYOW1pN25OSFd0
b1lYTmhhV0ZBY0cwdWJXVWdQR3RvWVhOaGFXRkFjRzB1YldVK3duY0VFQllLCkFCOEZBbHo2V1pN
R0N3a0hDQU1DQkJVSUNnSURGZ0lCQWhrQkFoc0RBaDRCQUFvSkVQcUl4NWxIOUYvagpHUHdBLzBT
SG12czhnR2FKRFQwN1p5aWhVYVh0VkJsOTc4TlBJLzRZbUUrSHZYNW9BUURWUUNhT1lUTHgKQVhH
MnFxaUhSUlBXTVllM3c5OTEzTkozNW5Dd2tpdUVDODQ0QkZ6NldaTVNDaXNHQVFRQmwxVUJCUUVC
CkIwQ3p2TGFKYUh6LzdjREU1cmRCZndjTVpqUEpnOUgxOGZuemV1ZGpWY09BYlFNQkNBZkNZUVFZ
RmdnQQpDUVVDWFBwWmt3SWJEQUFLQ1JENmlNZVpSL1JmNCtRWUFQNG5UeWZTUEF3NUF5NkRwSzRS
ODhrbjZPdncKREZ6bGhYQlhnOEV6Nk1JaHFRRCtKZlRwT3VyRlkzRldzR1dMRnIrQ3FIV1ZSOEl5
aDRNQjR6VmFxNit4CkRBRT0KPXFqeXUKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0t
LQo=
-----------------------2bb99394a2db98ad84114ca586255aeb--

--------01be434c0bf771b5269992e6f9e9112d2911f7537dda9121d5a2d23e033dd90a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmTp45oJkPqIx5lH9F/jFiEErIEqH5eubKnbI0GH+ojHmUf0
X+MAAIIJAP92VaNZD+yFEGwkMQqrI9gqHCoupN3Uaos18kXGHAmCfgD+MbIO
TWZikyC3XjHzik9yZ1fqpG3Ln2pVMZ/258XXBgY=
=kdU0
-----END PGP SIGNATURE-----


--------01be434c0bf771b5269992e6f9e9112d2911f7537dda9121d5a2d23e033dd90a--


