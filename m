Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896DB59EB15
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 20:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiHWSdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHWScq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 14:32:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E589D75382
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 09:54:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b5so13451707wrr.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=yML17xWEA74NWTwxWTea+6y6W4iNCroNg9GBSrFDzrE=;
        b=VzBq80+5RGyjmmH3dkkIISy88HfDCp3OyYPovVTkT9kjfiB/hpYT1POCAFYChf/75K
         6OfZyLcscFtnOXZ5wOpDrbyi+c9Fj04qX5gO5qbILfrHL5R0089vyz6BZjA4L71HWHec
         OW4Q6Kv48AledqrbU3qFGahzYl/mlfSQ6hlIYNLu10xQtf9sSLj5mlROTqD6pNjAFJlW
         KhK6uOBkqekrxdGCtDdGPywhRb5ugcW9MXdQx51/E8IXPyJY3fIR69kRoRM6rtzXE/ok
         1PKVcTx8kodr9DpQNYfIjnAR+Z+XjhIdH0k4NWBneVCiDJi0mVjSx6WZkvduBLe44zuI
         4YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=yML17xWEA74NWTwxWTea+6y6W4iNCroNg9GBSrFDzrE=;
        b=KFK/Wv6XtCYnwv9/gIh/YzBfqgemy5WKSYo2m6S1xvDl+GAyz0em1csTMSELrLkjpk
         uIOR5FN1dye5vl4p2f0d9mg0+ZFocIzO8hfXnT15mtRSRYOCX3OtgKQ7MFftjMyiQK2v
         UU+AicFAve5oCfHMLGjrX0gVevE5dLBUQBeK3w2ARVucFKOXD56t0Y0Svz/xMqvMZOec
         mSspFV1e0hq/+/MM/Dv5Xnl3APmeFL2AriP0lg4B94dhpfReOEZ79GdxRhqwnhjCO3BU
         LeX/RCPpZwrXe36h3Yo6VI8iNZ7aGcdtyQQrED4M/17XHP2Frmg/SQPujA//MVRsvewg
         aWgw==
X-Gm-Message-State: ACgBeo09ki6MkQbAi3ekCAQAHO/Htng8hF0Ber0Wx2t6c/XGiStb/u8J
        ekYV9X/4NPL9gy+I+4VkkfA=
X-Google-Smtp-Source: AA6agR5y8Hpfb5u16pCGjva2FhPSIY9II9pxzrxx0y5GW2AgzncC4/ku8CeNzBBRc/39xZYnfFMNow==
X-Received: by 2002:a05:6000:1f0e:b0:221:6d6f:5c7e with SMTP id bv14-20020a0560001f0e00b002216d6f5c7emr14551876wrb.256.1661273669421;
        Tue, 23 Aug 2022 09:54:29 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d6b44000000b002252d897876sm10978678wrw.32.2022.08.23.09.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:54:28 -0700 (PDT)
Message-ID: <dd8e599f-eea4-75ea-2b03-8de2dee856da@gmail.com>
Date:   Tue, 23 Aug 2022 18:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next v2 2/2] scripts/bpf: Set date attribute for
 bpf-helpers(7) man page
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
References: <20220823155327.98888-1-quentin@isovalent.com>
 <20220823155327.98888-2-quentin@isovalent.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220823155327.98888-2-quentin@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7Rm6ZTD1soLPQcCAyK1bL70B"
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
--------------7Rm6ZTD1soLPQcCAyK1bL70B
Content-Type: multipart/mixed; boundary="------------YuoJFMl5qsymyOAcbvfj5dDc";
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
Message-ID: <dd8e599f-eea4-75ea-2b03-8de2dee856da@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] scripts/bpf: Set date attribute for
 bpf-helpers(7) man page
References: <20220823155327.98888-1-quentin@isovalent.com>
 <20220823155327.98888-2-quentin@isovalent.com>
In-Reply-To: <20220823155327.98888-2-quentin@isovalent.com>

--------------YuoJFMl5qsymyOAcbvfj5dDc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yMy8yMiAxNzo1MywgUXVlbnRpbiBNb25uZXQgd3JvdGU6
DQo+IFRoZSBicGYtaGVscGVycyg3KSBtYW51YWwgcGFnZSBzaGlwcGVkIGluIHRoZSBtYW4t
cGFnZXMgcHJvamVjdCBpcw0KPiBnZW5lcmF0ZWQgZnJvbSB0aGUgZG9jdW1lbnRhdGlvbiBj
b250YWluZWQgaW4gdGhlIEJQRiBVQVBJIGhlYWRlciwgaW4NCj4gdGhlIExpbnV4IHJlcG9z
aXRvcnksIHBhcnNlZCBieSBzY3JpcHQvYnBmX2RvYy5weSBhbmQgdGhlbiBmZWQgdG8NCj4g
cnN0Mm1hbi4NCj4gDQo+IFRoZSBtYW4gcGFnZSBzaG91bGQgY29udGFpbiB0aGUgZGF0ZSBv
ZiBsYXN0IG1vZGlmaWNhdGlvbiBvZiB0aGUNCj4gZG9jdW1lbnRhdGlvbi4gVGhpcyBjb21t
aXQgYWRkcyB0aGUgcmVsZXZhbnQgZGF0ZSB3aGVuIGdlbmVyYXRpbmcgdGhlDQo+IHBhZ2Uu
DQo+IA0KPiBCZWZvcmU6DQo+IA0KPiAgICAgICQgLi9zY3JpcHRzL2JwZl9kb2MucHkgaGVs
cGVycyB8IHJzdDJtYW4gfCBncmVwICdcLlRIJw0KPiAgICAgIC5USCBCUEYtSEVMUEVSUyA3
ICIiICJMaW51eCB2NS4xOS0xNDAyMi1nMzBkMmE0ZDc0ZTExIiAiIg0KPiANCj4gQWZ0ZXI6
DQo+IA0KPiAgICAgICQgLi9zY3JpcHRzL2JwZl9kb2MucHkgaGVscGVycyB8IHJzdDJtYW4g
fCBncmVwICdcLlRIJw0KPiAgICAgIC5USCBCUEYtSEVMUEVSUyA3ICIyMDIyLTA4LTE1IiAi
TGludXggdjUuMTktMTQwMjItZzMwZDJhNGQ3NGUxMSIgIiINCj4gDQo+IFdlIGdldCB0aGUg
dmVyc2lvbiBieSB1c2luZyAiZ2l0IGxvZyIgdG8gbG9vayBmb3IgdGhlIGNvbW1pdCBkYXRl
IG9mIHRoZQ0KPiBsYXRlc3QgY2hhbmdlIHRvIHRoZSBzZWN0aW9uIG9mIHRoZSBCUEYgaGVh
ZGVyIGNvbnRhaW5pbmcgdGhlDQo+IGRvY3VtZW50YXRpb24uIElmIHRoZSBjb21tYW5kIGZh
aWxzLCB3ZSBqdXN0IHNraXAgdGhlIGRhdGUgZmllbGQuIGFuZA0KPiBrZWVwIGdlbmVyYXRp
bmcgdGhlIHBhZ2UuDQo+IA0KPiBDYzogQWxlamFuZHJvIENvbG9tYXIgPGFseC5tYW5wYWdl
c0BnbWFpbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBBbGVqYW5kcm8gQ29sb21hciA8YWx4Lm1h
bnBhZ2VzQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUXVlbnRpbiBNb25uZXQgPHF1
ZW50aW5AaXNvdmFsZW50LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZWphbmRybyBDb2xvbWFy
IDxhbHgubWFucGFnZXNAZ21haWwuY29tPg0KDQo+IC0tLQ0KPiAgIHNjcmlwdHMvYnBmX2Rv
Yy5weSB8IDIwICsrKysrKysrKysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2Ny
aXB0cy9icGZfZG9jLnB5IGIvc2NyaXB0cy9icGZfZG9jLnB5DQo+IGluZGV4IDA2MWFkMWRj
MzIxMi4uZjRmM2U3ZWM2ZDQ0IDEwMDc1NQ0KPiAtLS0gYS9zY3JpcHRzL2JwZl9kb2MucHkN
Cj4gKysrIGIvc2NyaXB0cy9icGZfZG9jLnB5DQo+IEBAIC0xMiw2ICsxMiw3IEBAIGltcG9y
dCByZQ0KPiAgIGltcG9ydCBzeXMsIG9zDQo+ICAgaW1wb3J0IHN1YnByb2Nlc3MNCj4gICAN
Cj4gK2hlbHBlcnNEb2NTdGFydCA9ICdTdGFydCBvZiBCUEYgaGVscGVyIGZ1bmN0aW9uIGRl
c2NyaXB0aW9uczonDQo+ICAgDQo+ICAgY2xhc3MgTm9IZWxwZXJGb3VuZChCYXNlRXhjZXB0
aW9uKToNCj4gICAgICAgcGFzcw0KPiBAQCAtMjM1LDcgKzIzNiw3IEBAIGNsYXNzIEhlYWRl
clBhcnNlcihvYmplY3QpOg0KPiAgICAgICAgICAgc2VsZi5lbnVtX3N5c2NhbGxzID0gcmUu
ZmluZGFsbCgnKEJQRlx3KykrJywgYnBmX2NtZF9zdHIpDQo+ICAgDQo+ICAgICAgIGRlZiBw
YXJzZV9kZXNjX2hlbHBlcnMoc2VsZik6DQo+IC0gICAgICAgIHNlbGYuc2Vla190bygnKiBT
dGFydCBvZiBCUEYgaGVscGVyIGZ1bmN0aW9uIGRlc2NyaXB0aW9uczonLA0KPiArICAgICAg
ICBzZWxmLnNlZWtfdG8oaGVscGVyc0RvY1N0YXJ0LA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICdDb3VsZCBub3QgZmluZCBzdGFydCBvZiBlQlBGIGhlbHBlciBkZXNjcmlwdGlvbnMg
bGlzdCcpDQo+ICAgICAgICAgICB3aGlsZSBUcnVlOg0KPiAgICAgICAgICAgICAgIHRyeToN
Cj4gQEAgLTM3Myw2ICszNzQsMTcgQEAgY2xhc3MgUHJpbnRlclJTVChQcmludGVyKToNCj4g
ICAgICAgICAgICAgICAgICAgcmV0dXJuICdMaW51eCcNCj4gICAgICAgICAgIHJldHVybiAn
TGludXgge3ZlcnNpb259Jy5mb3JtYXQodmVyc2lvbj12ZXJzaW9uKQ0KPiAgIA0KPiArICAg
IGRlZiBnZXRfbGFzdF9kb2NfdXBkYXRlKHNlbGYsIGRlbGltaXRlcik6DQo+ICsgICAgICAg
IHRyeToNCj4gKyAgICAgICAgICAgIGNtZCA9IFsnZ2l0JywgJ2xvZycsICctMScsICctLXBy
ZXR0eT1mb3JtYXQ6JWNzJywgJy0tbm8tcGF0Y2gnLA0KPiArICAgICAgICAgICAgICAgICAg
ICctTCcsDQo+ICsgICAgICAgICAgICAgICAgICAgJy97fS8sL1wqXC8vOmluY2x1ZGUvdWFw
aS9saW51eC9icGYuaCcuZm9ybWF0KGRlbGltaXRlcildDQo+ICsgICAgICAgICAgICBkYXRl
ID0gc3VicHJvY2Vzcy5ydW4oY21kLCBjd2Q9bGludXhSb290LA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNhcHR1cmVfb3V0cHV0PVRydWUsIGNoZWNrPVRydWUp
DQo+ICsgICAgICAgICAgICByZXR1cm4gZGF0ZS5zdGRvdXQuZGVjb2RlKCkucnN0cmlwKCkN
Cj4gKyAgICAgICAgZXhjZXB0Og0KPiArICAgICAgICAgICAgcmV0dXJuICcnDQo+ICsNCj4g
ICBjbGFzcyBQcmludGVySGVscGVyc1JTVChQcmludGVyUlNUKToNCj4gICAgICAgIiIiDQo+
ICAgICAgIEEgcHJpbnRlciBmb3IgZHVtcGluZyBjb2xsZWN0ZWQgaW5mb3JtYXRpb24gYWJv
dXQgaGVscGVycyBhcyBhIFJlU3RydWN0dXJlZA0KPiBAQCAtMzk1LDYgKzQwNyw3IEBAIGxp
c3Qgb2YgZUJQRiBoZWxwZXIgZnVuY3Rpb25zDQo+ICAgDQo+ICAgOk1hbnVhbCBzZWN0aW9u
OiA3DQo+ICAgOlZlcnNpb246IHt2ZXJzaW9ufQ0KPiAre2RhdGVfZmllbGR9e2RhdGV9DQo+
ICAgDQo+ICAgREVTQ1JJUFRJT04NCj4gICA9PT09PT09PT09PQ0KPiBAQCAtNDI4LDkgKzQ0
MSwxMiBAQCBIRUxQRVJTDQo+ICAgPT09PT09PQ0KPiAgICcnJw0KPiAgICAgICAgICAga2Vy
bmVsVmVyc2lvbiA9IHNlbGYuZ2V0X2tlcm5lbF92ZXJzaW9uKCkNCj4gKyAgICAgICAgbGFz
dFVwZGF0ZSA9IHNlbGYuZ2V0X2xhc3RfZG9jX3VwZGF0ZShoZWxwZXJzRG9jU3RhcnQpDQo+
ICAgDQo+ICAgICAgICAgICBQcmludGVyUlNULnByaW50X2xpY2Vuc2Uoc2VsZikNCj4gLSAg
ICAgICAgcHJpbnQoaGVhZGVyLmZvcm1hdCh2ZXJzaW9uPWtlcm5lbFZlcnNpb24pKQ0KPiAr
ICAgICAgICBwcmludChoZWFkZXIuZm9ybWF0KHZlcnNpb249a2VybmVsVmVyc2lvbiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRlX2ZpZWxkID0gJzpEYXRlOiAnIGlm
IGxhc3RVcGRhdGUgZWxzZSAnJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
YXRlPWxhc3RVcGRhdGUpKQ0KPiAgIA0KPiAgICAgICBkZWYgcHJpbnRfZm9vdGVyKHNlbGYp
Og0KPiAgICAgICAgICAgZm9vdGVyID0gJycnDQoNCi0tIA0KQWxlamFuZHJvIENvbG9tYXIN
CjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------YuoJFMl5qsymyOAcbvfj5dDc--

--------------7Rm6ZTD1soLPQcCAyK1bL70B
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMFBkMACgkQnowa+77/
2zJ+XQ//Ze+Ds0dVfq9McA+IIrzg039R2Q7wBhjeFxbUQBICSMWs9Bc5wwEVrXqn
3i7FvhOf0KPUG+gXuIeuO9bMf6U6Clsl6gYKr2Ph3MZlKB3QtFtb/iLLYqPiv14t
6SR6UZrADZyoxC1v1hs9fQmzRrX1K6U2HKH0aUYnRnp7B51HCOFyG4DA402hREbt
XsD9hqonFolHjgpymsCUM2BYmyFT4DKHHAcQ77bS2rkePyhY96RLK1gef6EiwME6
PCv1bhSy5U87qRdN6+1Kw1Y9I45PKROzVfOnmsjGWxNDydbctZX41Lj1WTTF2iV8
Mxeh6Q7zw6xrRDSiyy8gKGU3/NlhHGZfWhFGzXcM0ODasXeqeDY32XgIM8K+RbY1
IqxW77lLNKtC39XbAQ/FzquUe7+8IImQ7vUDLqqDo3ogmUC5WSndtxoUvOJ2uHPz
jg5eerrECpS/OWL9Vedy36XXhA1qWnseXrIS9SZiEdNqQIRfIQRE29xFKW57pg9J
z0Xg9Z3T4EY0pXaAVmdcB41ETArimCHrSRmtDFo2sayXJY0WIpbVZVKD/lXb/EEI
Ou8PzoezoFCJM4vFVIr4xuAnxoS8RAl+QSc6Sbxh/tgwy7TADrgEmvogBNFcSRQK
SB8LwGzfSCI3izs4yzbzF2rX9OxZqjbCt3eAOSeJrrrjvzjilXU=
=vq6Y
-----END PGP SIGNATURE-----

--------------7Rm6ZTD1soLPQcCAyK1bL70B--
