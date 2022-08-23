Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8324D59E58C
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiHWPDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiHWPBL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 11:01:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19EDF438D
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 05:26:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so16307126wri.13
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 05:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=oiPNIj66B8wGUY+x2I1k5egVGYbEXlHiRid+YDTvl3Q=;
        b=a4fQqwp9WXQngyqxq5vEvcos/YWT0L1knCUoeqqa9kaCQxGNlJWiyTsjBiISIDFB3t
         kepCxUbl7SIhitmq0TnjhwEwSVEL0LxJargmaDUXRc06ZT3o/AhBc8FDrZU9eCaHY0Kn
         moZn9LIMyoVqUGotXu3t43iQ9YD69+sOUQMEtIwYzHDxZWZSG9V5qpRKXfm/M9T34D43
         5Q7uI9NZEciHgVB0U+zcjxGffHCZE36gyLP+Nv401zcIhjfE/WMD7d2rQLG+oIyQHjeL
         b80QsEDAU0YAXAn+UkxP2g1xeb5a7VVv4Z3q9tBGZY67bXsIHkQ3xgguosQWVZRAcDXr
         0pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=oiPNIj66B8wGUY+x2I1k5egVGYbEXlHiRid+YDTvl3Q=;
        b=ZLFbVFjsuFUEN05jlZzasmo/3pfGXOh2N4rWHXUy/bGo1NT7Q2jW2cwml3FH+rVeuj
         EE+kl+t/q71PQ1nxZVMMDoNKYdWFr0Nn4zwQ4Lo+ItkQb4iSdNFi7rsU2SAgrGTUwzZV
         vgeZxAcXzbbqFGxXAShRphONvvsWlt+EroRYJM2xfE0j/ETJkir7vyLqNDnVpUeI6R0G
         b96iCipfyMQMwrxPz6Acq2UhtqqEvX4TBhHEWLxGFc4dzgUqfvyxr2VVTqZIAjMacr/K
         7UHkLsD4MZTLsjfc5NNJDzOlxmj6pqVYMum+BP/CYVLdBxaAi7H2DgfTnTxKJaxqyG0E
         MhTQ==
X-Gm-Message-State: ACgBeo0qgIS1f9Wcos99PCKjXg/GalnpjKFJWWZEe99ztgX8DVQplIFr
        Hb3u3FFQu8sz6pNykSbFRvc=
X-Google-Smtp-Source: AA6agR6UO7IWi5p2ARHVAlec71kogwRpyOCEUCDvcWWN3DIqu9ywS87JAMd5wVQGP53zBS2QJD/Zcw==
X-Received: by 2002:a5d:4e52:0:b0:225:5019:8031 with SMTP id r18-20020a5d4e52000000b0022550198031mr6821814wrt.175.1661257565371;
        Tue, 23 Aug 2022 05:26:05 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id g13-20020adfe40d000000b0021f15514e7fsm17464284wrm.0.2022.08.23.05.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 05:26:04 -0700 (PDT)
Message-ID: <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
Date:   Tue, 23 Aug 2022 14:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7)
 man page
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <20220823084719.13613-1-quentin@isovalent.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220823084719.13613-1-quentin@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jrQ1S25BXPaHDoKx362SUb0g"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jrQ1S25BXPaHDoKx362SUb0g
Content-Type: multipart/mixed; boundary="------------ajs2wyUBAXaC7uyriMmL3akq";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Quentin Monnet <quentin@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org
Message-ID: <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
Subject: Re: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7)
 man page
References: <20220823084719.13613-1-quentin@isovalent.com>
In-Reply-To: <20220823084719.13613-1-quentin@isovalent.com>

--------------ajs2wyUBAXaC7uyriMmL3akq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yMy8yMiAxMDo0NywgUXVlbnRpbiBNb25uZXQgd3JvdGU6
DQo+IFRoZSBicGYtaGVscGVycyg3KSBtYW51YWwgcGFnZSBzaGlwcGVkIGluIHRoZSBtYW4t
cGFnZXMgcHJvamVjdCBpcw0KPiBnZW5lcmF0ZWQgZnJvbSB0aGUgZG9jdW1lbnRhdGlvbiBj
b250YWluZWQgaW4gdGhlIEJQRiBVQVBJIGhlYWRlciwgaW4NCj4gdGhlIExpbnV4IHJlcG9z
aXRvcnksIHBhcnNlZCBieSBzY3JpcHQvYnBmX2RvYy5weSBhbmQgdGhlbiBmZWQgdG8NCj4g
cnN0Mm1hbi4NCj4gDQo+IEFmdGVyIGEgcmVjZW50IHVwZGF0ZSBvZiB0aGF0IHBhZ2UgWzBd
LCBBbGVqYW5kcm8gcmVwb3J0ZWQgdGhhdCB0aGUNCj4gbGludGVyIHVzZWQgdG8gdmFsaWRh
dGUgdGhlIG1hbiBwYWdlcyBjb21wbGFpbnMgYWJvdXQgdGhlIGdlbmVyYXRlZA0KPiBkb2N1
bWVudCBbMV0uIFRoZSBoZWFkZXIgZm9yIHRoZSBwYWdlIGlzIHN1cHBvc2VkIHRvIGNvbnRh
aW4gc29tZQ0KPiBhdHRyaWJ1dGVzIHRoYXQgd2UgZG8gbm90IHNldCBjb3JyZWN0bHkgd2l0
aCB0aGUgc2NyaXB0LiBUaGlzIGNvbW1pdA0KPiB1cGRhdGVzIHNvbWUgb2YgdGhlbTsgcGxl
YXNlIHJlZmVyIHRvIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uIGZvciB0aGUNCj4gbWVhbmlu
ZyBvZiB0aG9zZSBmaWVsZHMgYW5kIHRoZSB2YWx1ZSB3ZSB1c2UgKHRsO2RyOiBzZXR0aW5n
ICJWZXJzaW9uIg0KPiB0byAiTGludXgiIHNlZW1zIGFjY2VwdGFibGUpLg0KPiANCj4gQmVm
b3JlOg0KPiANCj4gICAgICAkIC4vc2NyaXB0cy9icGZfZG9jLnB5IGhlbHBlcnMgfCByc3Qy
bWFuIHwgZ3JlcCAnXC5USCcNCj4gICAgICAuVEggQlBGLUhFTFBFUlMgNyAiIiAiIiAiIg0K
PiANCj4gQWZ0ZXI6DQo+IA0KPiAgICAgICQgLi9zY3JpcHRzL2JwZl9kb2MucHkgaGVscGVy
cyB8IHJzdDJtYW4gfCBncmVwICdcLlRIJw0KPiAgICAgIC5USCBCUEYtSEVMUEVSUyA3ICIi
ICJMaW51eCIgIkxpbnV4IFByb2dyYW1tZXIncyBNYW51YWwiDQo+IA0KPiBOb3RlIHRoYXQg
dGhpcyBjb21taXQgZG9lcyBub3QgdXBkYXRlIHRoZSBkYXRlIGZpZWxkLiBUaGlzIGRhdGUg
c2hvdWxkDQo+IGlkZWFsbHkgYmUgdXBkYXRlZCB3aGVuIGdlbmVyYXRpbmcgdGhlIHBhZ2Ug
dG8gdGhlIGRhdGUgb2YgdGhlIGxhc3QgZWRpdA0KPiBvZiB0aGUgZG9jdW1lbnRhdGlvbiAo
d2hpY2ggd2UgY2FuIG1heWJlIGFwcHJveGltYXRlIHRvIHRoZSBsYXN0IGVkaXQgb2YNCj4g
dGhlIEJQRiBVQVBJIGhlYWRlcikuIFRoZXJlIGlzIGEgLS1kYXRlIG9wdGlvbiBpbiByc3Qy
bWFuOyBpdCBkb2VzIG5vdA0KPiB1cGRhdGUgdGhhdCBmaWVsZCwgYnV0IEFsZWphbmRybyBy
YWlzZWQgYW4gaXNzdWUgYWJvdXQgaXQgWzJdIHNvIGl0DQo+IG1pZ2h0IGRvIGluIHRoZSBm
dXR1cmUuIEFueXdheSwgd2UganVzdCBsZWF2ZSB0aGUgZGF0ZSBlbXB0eSBmb3Igbm93Lg0K
PiANCj4gWzBdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kb2NzL21hbi1wYWdl
cy9tYW4tcGFnZXMuZ2l0L2NvbW1pdC9tYW43L2JwZi1oZWxwZXJzLjc/aWQ9MTljN2Y3ODM5
M2YyYjAzOGU3NjA5OWY4NzMzNWRkZjQzYTg3ZjAzOQ0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjIwNzIxMTEwODIxLjgyNDAtMS1hbHgubWFucGFnZXNAZ21haWwu
Y29tL3QvI204ZTY4OWE4MjJlMDNmNmUyNTMwYTBkNmRlOWQxMjg0MDE5MTZjNWRlDQo+IFsy
XSBodHRwczovL2J1Z3MuZGViaWFuLm9yZy9jZ2ktYmluL2J1Z3JlcG9ydC5jZ2k/YnVnPTEw
MTY1MjcNCj4gDQo+IENjOiBBbGVqYW5kcm8gQ29sb21hciA8YWx4Lm1hbnBhZ2VzQGdtYWls
LmNvbT4NCj4gUmVwb3J0ZWQtYnk6IEFsZWphbmRybyBDb2xvbWFyIDxhbHgubWFucGFnZXNA
Z21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBRdWVudGluIE1vbm5ldCA8cXVlbnRpbkBp
c292YWxlbnQuY29tPg0KDQpIZWgsIHdlIHZlcnkgcmVjZW50bHkgY2hhbmdlZCB0aGUgLlRI
IGxpbmUgaW4gdGhlIExpbnV4IG1hbi1wYWdlcyBmb3IgDQpjb25zaXN0ZW5jeSB3aXRoIHRy
YWRpdGlvbiBhbmQgbW9zdCBvdGhlciBtYW51YWwgcGFnZXMgb3V0IHRoZXJlKToNCg0KPGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kb2NzL21hbi1wYWdlcy9tYW4tcGFnZXMu
Z2l0L2NvbW1pdC8/aWQ9N2JkNjMyOGZkNDA4NzFhZDc1Y2JjM2I2YWE1ZDRhNGI3MGY1M2Fj
Nz4NCjxodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZG9jcy9tYW4tcGFnZXMvbWFu
LXBhZ2VzLmdpdC9jb21taXQvP2lkPTQ1MTg2YTVkYTc0Mjg1ZDcyMTk5NzQ0ZWI1ZDI4ODhm
ZTM0OGY2ODA+DQoNClNvLCB3ZSBub3cgb21pdCB0aGUgbGFzdCAoNXRoKSBhcmd1bWVudCB0
byAuVEgsDQphbmQgdGhlIFZlcnNpb24gb25lIHJlYWxseSBjb250YWlucyBhIHZlcnNpb24g
bm93Lg0KSSdsbCBjb21tZW50IGJlbG93IHdpdGggd2hhdCBJIHRoaW5rIHlvdSBzaG91bGQg
ZG8uDQoNCkFuIGV4YW1wbGUgbWF5IHNob3cgaXQgYmV0dGVyOg0KDQokIGdyZXAgXi5USCA8
bWFuMi9tZW1iYXJyaWVyLjINCi5USCBNRU1CQVJSSUVSIDIgMjAyMS0wOC0yNyAiTGludXgg
bWFuLXBhZ2VzICh1bnJlbGVhc2VkKSINCg0KT2YgY291cnNlLCB0aGF0ICcodW5yZWxlYXNl
ZCknIGlzIHJlcGxhY2VkIGJ5IHRoZSBhY3R1YWwgdmVyc2lvbiBhdCB0aGUgDQp0aW1lIG9m
IGBtYWtlIGRpc3RgIChjcmVhdGluZyB0aGUgdGFyYmFsbCkuDQoNCg0KPiAtLS0NCj4gICBz
Y3JpcHRzL2JwZl9kb2MucHkgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvYnBmX2RvYy5weSBiL3Njcmlw
dHMvYnBmX2RvYy5weQ0KPiBpbmRleCBkZmIyNjBkZTE3YTguLmU2NmVmNGY1NmU5NSAxMDA3
NTUNCj4gLS0tIGEvc2NyaXB0cy9icGZfZG9jLnB5DQo+ICsrKyBiL3NjcmlwdHMvYnBmX2Rv
Yy5weQ0KPiBAQCAtMzc4LDYgKzM3OCw4IEBAIGxpc3Qgb2YgZUJQRiBoZWxwZXIgZnVuY3Rp
b25zDQo+ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIA0KPiAgIDpNYW51YWwg
c2VjdGlvbjogNw0KPiArOk1hbnVhbCBncm91cDogTGludXggUHJvZ3JhbW1lcidzIE1hbnVh
bA0KDQpSZW1vdmUgIk1hbnVhbCBncm91cCIgY29tcGxldGVseS4gIElmIHdlIGRvbid0IHNw
ZWNpZnkgdGhhdCwgZ3JvZmYoMSkgDQoob3IgbWFuZG9jKDEpKSB3aWxsIHByb2R1Y2Ugc2Fu
ZSBkZWZhdWx0cy4gIEZvciBzZWN0aW9uIDcsIGl0IHVzZXMgDQoiTWlzY2VsbGFuZW91cyBJ
bmZvcm1hdGlvbiBNYW51YWwiLg0KDQpJIHdpbGwgcmVwb3J0IGEgYnVnIHRvIHJzdDJtYW4o
MSkgdGhhdCBpdCBzaG91bGRuJ3QgbGVhdmUgdGhlIGZpZWxkIGFzIA0KIiIgaWYgbm90IHNw
ZWNpZmllZCwgYnV0IGl0IHNob3VsZCBqdXN0IG5vdCBhZGQgdGhlIGZpZWxkIGF0IGFsbCBp
ZiBub3QgDQpzcGVjaWZpZWQuDQoNCj4gKzpWZXJzaW9uOiBMaW51eA0KDQpZb3UgY291bGQg
YXBwZW5kIHRoZSB2ZXJzaW9uIGhlcmUuICBPciBtYXliZSBwdXQgYSBwbGFjZWhvbGRlciB0
aGF0IHRoZSANCnNjcmlwdCBzaG91bGQgZmlsbCB3aXRoIGluZm9ybWF0aW9uIGZyb20gdGhl
IG1ha2VmaWxlIG9yIGdpdC1kZXNjcmliZSgxKT8NCg0KPiAgIA0KPiAgIERFU0NSSVBUSU9O
DQo+ICAgPT09PT09PT09PT0NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCi0tIA0KQWxlamFuZHJv
IENvbG9tYXINCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------ajs2wyUBAXaC7uyriMmL3akq--

--------------jrQ1S25BXPaHDoKx362SUb0g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMEx1sACgkQnowa+77/
2zKe+g/+KR/WoQZfYoI41rWXNSsl82JtocwfBo4LfbGA1hVPUJU4uDDuH+B8fMNZ
GXMO2mZ2zYwyOGaE1z7U24pdzq9nOYx+OQhtbTlq374EC030yf3VpmrioloPrObC
YQrtScWFA8iBwrScxUBmaKyHByY1CfCnZJLYGlEZmuGLOcLYiowsPCPJ218S3gFl
NTjkBwLqFkRBRt4J+Lc0xqZQhbFs/ws+rO9xRk29N9thZ9HmON4a5fs+478fMN1k
03TfXwGsp+pa4j38FAU4DQYp16f2pSDvWZY0VYkn9TeYPLAJryxHsultKr/7H5WP
v0BgqoigqKieBL29Qgzp+tQ9pylBuNSJQFQf7ugeyjQPGyVdPEJ5Y35AH7RTH/WX
dkwsuTkwa1UNEab6vPIUAjvLlKQnV3lX1CQMMI/FXKrcbhX46j+rMpVYzRU/BGsj
P7UY9sURflVTgDsTvZW6pCaKY+WmQxuPqnxlNQIDDDXXsVNX4nDT5GTsOIPSa1HS
ePpZZATot2OTSGnSW+CZ/8xCcottEDQZNAo16k4AURJCotqbTyl/Odseqavq6qc5
OFGhsoFVmNWmD55MVvAfUIgLdP94dApbgqwhQjC9lIt1/4dTkyo97lMJiAcnB8WQ
w3O+l00ivPHLNv9ozyLafaJ61ZBcaArBU6tXzhO1/Kh3h/KOjy4=
=uPU0
-----END PGP SIGNATURE-----

--------------jrQ1S25BXPaHDoKx362SUb0g--
