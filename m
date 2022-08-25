Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9245A1BB8
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 23:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiHYVzA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbiHYVy6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 17:54:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED50658A;
        Thu, 25 Aug 2022 14:54:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id az27so6188902wrb.6;
        Thu, 25 Aug 2022 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=NRNROM2HcbpI7DotalRvGgFhY8tcTV84PnjIlea9TF8=;
        b=IOn7sLJYHymIx83gAsDAghResn7aEZhvkrIit8wTHnq9wokP82US4SY8+W7zNt+WGe
         9tf/kadCQC2hsbuzbS844/U2CzQ0uhH3QE/4Wuh184cOLOxEtBpZZk/j1tqcaogwLjSh
         2syjpzjml2HYJ/Nzo/ae0WWcvIsON7Zt264ENFfYIEk27nFDHlA2rHcZEElSLJowdquJ
         Cc/NDfSyFmTgjL07LE7AGycLTHwNvMX9jSW9M9aXaPfS/H6L3vYusTdPqJshRO8eMj3C
         VLgRKr9m9F5ndUoHfBd4tULsUaNrJIjJBAn4rrtWY/bn4thWcdaFScmz8F/drFgNItyq
         JS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=NRNROM2HcbpI7DotalRvGgFhY8tcTV84PnjIlea9TF8=;
        b=LZsHHYnEB9df7XqxtqblEyWW/RoN6T4WoKUUKOwqHsYIRNxcZpb/ps2C2fODAoFCeq
         cFBLws7xmO2nzU7eRMhEHLTLMENc5y7CgmONvoCWf+/PuFn1GPx2Y/H+30nwAfz9b1Un
         IsWTe6bZ4yUaOGDpOVcyBXc5Pj3/e2PQYAgUl1Lh5Sbdluj8PS2S/IU7WlOETT+IRu2r
         9I7yN+/yFpxgdUvvIEjtr3rNMbSM1KbvkJsqnFQVP0cRm6IHEs/oylxnIMZiuC2wD4Av
         FExFojuSpY0byHRzlZw82FOU9zYFQqorUaLAzGemXY1ahYYIW89JFS1PZ8ayMIe8Q3K2
         tLCA==
X-Gm-Message-State: ACgBeo3bSJWY/KNHDpUQf+HrUhYSJsDSTmUsMTrs7Rcgh5ediIuYDLCQ
        b2QFGU/WmJ6182oCRTzGFjE=
X-Google-Smtp-Source: AA6agR5D6bLitvZFpCTIAMsjDa9asrOTFDIK+qvjbMXsCE9t8Y1Y87TY/ssrEqfy4PidsB3W3Z7I/A==
X-Received: by 2002:a5d:4649:0:b0:225:309d:1d51 with SMTP id j9-20020a5d4649000000b00225309d1d51mr3499490wrs.450.1661464496531;
        Thu, 25 Aug 2022 14:54:56 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d4f87000000b002206236ab3dsm328585wru.3.2022.08.25.14.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:54:56 -0700 (PDT)
Message-ID: <c4c16145-a05e-474b-f7db-a88aa311a07d@gmail.com>
Date:   Thu, 25 Aug 2022 23:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] Fit line in 80 columns
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
 <CAEf4BzbCgHp0MtsSm_ExPO+EGhFWzLUOiFuh1jyrhWfbsDtL3A@mail.gmail.com>
 <403a8238-12e7-1092-a28b-a52f5d63df2c@gmail.com>
In-Reply-To: <403a8238-12e7-1092-a28b-a52f5d63df2c@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Wnhs4xmlrvschggQDUynsUCe"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Wnhs4xmlrvschggQDUynsUCe
Content-Type: multipart/mixed; boundary="------------Tpoj0lpqPVNxHZliuPfo58Yo";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
 linux-man <linux-man@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <c4c16145-a05e-474b-f7db-a88aa311a07d@gmail.com>
Subject: Re: [PATCH] Fit line in 80 columns
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
 <CAEf4BzbCgHp0MtsSm_ExPO+EGhFWzLUOiFuh1jyrhWfbsDtL3A@mail.gmail.com>
 <403a8238-12e7-1092-a28b-a52f5d63df2c@gmail.com>
In-Reply-To: <403a8238-12e7-1092-a28b-a52f5d63df2c@gmail.com>

--------------Tpoj0lpqPVNxHZliuPfo58Yo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOC8yNS8yMiAyMzo1MSwgQWxlamFuZHJvIENvbG9tYXIgd3JvdGU6DQo+IE9uIDgvMjUv
MjIgMjM6MzYsIEFuZHJpaSBOYWtyeWlrbyB3cm90ZToNCj4+IE9uIFRodSwgQXVnIDI1LCAy
MDIyIGF0IDExOjA3IEFNIEFsZXhlaSBTdGFyb3ZvaXRvdg0KPj4gPGFsZXhlaS5zdGFyb3Zv
aXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IFdlIGRvbid0IGZvbGxvdyA4MCBjaGFyIGxp
bWl0IGFuZCBhcmUgbm90IGdvaW5nIHRvIGJlY2F1c2Ugb2YgbWFuIHBhZ2VzLg0KPj4NCj4+
IEFuZCBpdCdzIHF1ZXN0aW9uYWJsZSBpbiBnZW5lcmFsIHRvIGVuZm9yY2UgbGluZSBsZW5n
dGggZm9yIHZlcmJhdGltDQo+PiAoY29kZSkgYmxvY2suIEl0J3MgdmVyYmF0aW0gZm9yIGEg
Z29vZCByZWFzb24sIGl0IGNhbid0IGJlIHdyYXBwZWQuDQo+IA0KPiBUaGF0J3Mgd2h5IGlu
c3RlYWQgb2Ygd3JhcHBpbmcsIEkgcmVkdWNlZCB0aGUgbGVuZ3RoIG9mIHNvbWUgDQo+ICJp
ZGVudGlmaWVyIi7CoCBJdCdzIG5vdCBlbmZvcmNlZCwgYnV0IGl0J3MgbmljZXIgaWYgaXQg
Zml0cy7CoCBUaGVyZSBhcmUgDQo+IHNldmVyYWwgb3RoZXIgY2FzZXMsIHdoZXJlIGl0IHdh
c24ndCBlYXN5IHRvIG1ha2UgaXQgc2hvcnRlciwgYW5kIEkgbGVmdCANCj4gaXQgZXhjZWVk
aW5nIHRoZSBtYXJnaW4uDQo+IA0KPiBJdCdzIG5vdCBzbyBjcnVjaWFsIHRvIGZpeCBpdCwg
YW5kIGlmIHlvdSBwcmVmZXIgaXQgbGlrZSBpdCBpcyANCj4gY3VycmVudGx5LCBpdCdzIHJl
YXNvbmFibGUuwqAgVGhpcyBpcyBhIHN1Z2dlc3Rpb24sIHRvIG1ha2UgaXQgZWFzaWVyIHRv
IA0KPiByZWFkLg0KDQpBcyBhbiBleGFtcGxlLCB5b3UgY2FuIHNlZSB0aGlzIGNvbW1pdCBy
ZWNlbnRseSBhcHBsaWVkIHRvIHRoZSBtYW4tcGFnZXM6DQoNCjxodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vZG9jcy9tYW4tcGFnZXMvbWFuLXBhZ2VzLmdpdC9jb21taXQvP2lk
PWU1ZGExNmYxMGYyZDNkNTVkYjBiYjFlZjExNTZhZmNiMTk3ZDhmZGM+DQoNCkkgb25seSBt
YWRlIGxpbmVzIHNob3J0ZXIgaW4gY2FzZXMgd2hlcmUgbm8gaW5mbyB3YXMgbG9zdCAoaW5j
bHVkaW5nIA0KZm9ybWF0KS4NCg0KLS0gDQpBbGVqYW5kcm8gQ29sb21hcg0KPGh0dHA6Ly93
d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------Tpoj0lpqPVNxHZliuPfo58Yo--

--------------Wnhs4xmlrvschggQDUynsUCe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMH764ACgkQnowa+77/
2zJF7A/+PJ7dq++1Tw5HkmqSxWpk57Vv8HYi4lFXGDhd/TddpVTwnd8lIyXi5KMz
0C330+aP3lRsdzCgawzBL+LFaeg3RQAMvH2O7a4nEJbFy9DoI2XIl9/WhFMduuY5
2L7APETMrlpZBMKc8JKpjTJxjUD7aOcr+NI4RHB51/jgV2RbeOcAmvmvYdQXJJfe
fguhokSwY3YP2YlLtnpdvNd4l9YxPSxdUE6Ko3IlgyGnqzrj8Jxoaup9klBvd1d1
cPtnfaXPUb4W0sCxP++KLYG6zOONCK6qegBH/5692QtBEPWyvf1NjT2xRiHx/qca
2LYftachS+x9DQ89NttvanJyCBIq3yId0D6Uq/PY/XszMM9FAUa4AcNAu97HDVIU
3ZKXAoFCZXLE5MefxZ7CPZmndk1UscrE+74Bn6GH7p+GrbhT0j/xLHtd8xwFq/LL
CL8BZj1uTBKtsWc9NPtzj4dxkG6/qSCDTUct3+HfsdhDbfi3WP5Foidn+HGzI1bb
AL+G8Nft7aRk1q/tH+TCFMAw+IHM/gEA02cdGeR10dm3n28u115A2xyz5rG9FI66
CptJjg6W95fGG7WLfgp5W+NgFN/k+KDycy2/Qw31nyCbS2VuHxGT+WhEO2VpeXvm
SYuklcqJCTchI13zTScBd0+40qa6yJzXy1fUoDnDiuwtKzxSkiw=
=Bipr
-----END PGP SIGNATURE-----

--------------Wnhs4xmlrvschggQDUynsUCe--
