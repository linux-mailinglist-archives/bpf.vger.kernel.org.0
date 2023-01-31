Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E8682BA6
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 12:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAaLlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 06:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAaLlI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 06:41:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734059DC;
        Tue, 31 Jan 2023 03:41:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so13940495wru.2;
        Tue, 31 Jan 2023 03:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIwBbAkigaLAxAjFU/7Zdz5yk6gqJh0kJJVOs17nD4Y=;
        b=lDU5KwssiW+oRQ6Z+qQbBiowjz+KhGngUJ9AOPijNU0f3suYL0mOUQvDJ9YeEltjhV
         b63abCOPM5j1KwSayzApFiKKWEq5WydtY5xGqOwqHctW0IW2NO9kDe2yviAecLv9iTdD
         33dAer4jmQ51CmcvnKFsJcDdUP/uh2bzUYInk3/NSsxvGeYXZepCTPArizMReA6CHaf1
         Rmp76m9tJYDxji5/VZgPzvrwtHEcOFZggmtBpu1m48MdJAEhoHFinXQS/bNKaR83/sXG
         RbgBVszzvIe95Q4JgNXn7QY6otgl3loI+DRzJXjr+vUiG/DF3RrnTmlcgD/SnrY3AKeo
         BY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VIwBbAkigaLAxAjFU/7Zdz5yk6gqJh0kJJVOs17nD4Y=;
        b=ykflg7PfiBBO4kUrf9jzxw1FuvaFkgyRljwq3pa0N2EMuHQhi9+dczt2RfoXEB4Wqc
         vgNHhlFDVreKaTruSea9tbGF6hPH2iQFJ6v7Ek16dlPy7VMrts3fA1My9H8Xn+nioDcx
         79yixavGRr26yNS5EsAIcXW9vjF4qWhe4WEYfN270HV/LK7tyf4SHCr2sPUtyrNFgPsM
         6kxm7Jg4a2o7fjmZ8egIFwBSqayTyOP7hp10kpZdt5dFRm5nJ+EqPfFNH1vQprdU/FGe
         +z241AmtROjdFj5tMm370iObMBvDs9XJk8iIwswt4M3TJQQ+BET2fCG/IGpOzHNlpJxy
         httw==
X-Gm-Message-State: AO0yUKWMlZJ5YuDXkvANhxy9LiN2z+cUwCJIJAtziZ8XeBdVn3Hy1XaP
        AHQwA0UV7GywtM+IjqNTAZI=
X-Google-Smtp-Source: AK7set9olJrmbIRgnPr55iW9yaN7KZ+nJvqE+tCdasBU4/Zo9TTLn05Z9stxxPpcxxpxN5UnuQ6FlQ==
X-Received: by 2002:a5d:5541:0:b0:2bf:c0e4:1bc5 with SMTP id g1-20020a5d5541000000b002bfc0e41bc5mr17525020wrw.56.1675165266062;
        Tue, 31 Jan 2023 03:41:06 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id e7-20020adfe387000000b002be15ee1377sm14552431wrm.22.2023.01.31.03.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 03:41:05 -0800 (PST)
Message-ID: <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
Date:   Tue, 31 Jan 2023 12:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Typo in the man7 bpf-helpers page
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Zexuan Luo <spacewanderlzx@gmail.com>, bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
 <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
In-Reply-To: <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yvXwZG01YbIOcnzaLPyoz9Aa"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yvXwZG01YbIOcnzaLPyoz9Aa
Content-Type: multipart/mixed; boundary="------------qzxm106cGgfXO2F0TIyIu05s";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Zexuan Luo <spacewanderlzx@gmail.com>, bpf <bpf@vger.kernel.org>,
 Quentin Monnet <quentin@isovalent.com>
Cc: linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Message-ID: <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
Subject: Re: Typo in the man7 bpf-helpers page
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
 <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
In-Reply-To: <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>

--------------qzxm106cGgfXO2F0TIyIu05s
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

W1Jlc2VuZCB3aXRoIFF1ZW50aW4ncyByaWdodCBhZGRyZXNzLCBJIGhvcGVdDQoNCkhpIFpl
eHVhbiwgUXVlbnRpbiwNCg0KT24gMS8zMS8yMyAxMTowMywgWmV4dWFuIEx1byB3cm90ZToN
CiA+IEhlbGxvIENvbG9tYXIsDQogPg0KID4gSSBqdXN0IGZvdW5kIGEgcG90ZW50aWFsIGJ1
ZyBpbiB0aGUgYnBmLWhlbHBlcnMgcGFnZS4NCg0KVGhhbmtzIGZvciByZXBvcnRpbmcgYnVn
cyA6KQ0KDQogPg0KID4gVW5kZXIgdGhlIGh0dHBzOi8vd3d3Lm1hbjcub3JnL2xpbnV4L21h
bi1wYWdlcy9tYW43L2JwZi1oZWxwZXJzLjcuaHRtbDoNCg0KVGhpcyBwYWdlIGlzIGdlbmVy
YXRlZCBmcm9tIHRoZSBMaW51eCBrZXJuZWwgc291cmNlcy4gIEkndmUgQ0NlZCBRdWVudGlu
IGFuZCB0aGUgDQpCUEYgbGlzdCBzbyB0aGV5IGNhbiBjaGVjayBpdCB0aGVyZS4NCg0KQlRX
LCBJJ20gcmVmcmVzaGluZyB0aGUgcGFnZSBub3cuDQoNClF1ZW50aW4sIEkgcmVhbGl6ZWQg
aW4gdGhlIGRpZmYgdGhhdCB0aGVyZSBpcyBzb21lIGluY29uc2lzdGVuY3kgaW4gdGhlIG51
bWJlciANCm9mIHNwYWNlcyBhZnRlciBhIHNlbnRlbmNlLWVuZGluZyBwZXJpb2QuICBDb3Vs
ZCB5b3UgcGxlYXNlIHVzZSB0d28gc3BhY2VzIGZvciANCnRoYXQ/ICBJdCdzIGVzcGVjaWFs
bHkgaW1wb3J0YW50IGZvciBncm9mZigxKSwgd2hpY2ggd2lsbCByZW5kZXIgaXQgZGlmZmVy
ZW50bHkuIA0KICAgSG93ZXZlciwgaXQncyBub3QgYSBiaWcgaXNzdWUsIHNvIGRvbid0IGZl
ZWwgdXJnZWQgdG8gZG8gdGhhdC4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCiA+DQogPiBgYGAN
CiA+ICAgICAgICAgdTY0IGJwZl9nZXRfc29ja2V0X2Nvb2tpZShzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKQ0KID4NCiA+ICAgICAgICAgICAgICAgIERlc2NyaXB0aW9uDQogPiAgICAgICAgICAg
ICAgICAgICAgICAgSWYgdGhlIHN0cnVjdCBza19idWZmIHBvaW50ZWQgYnkgc2tiIGhhcyBh
IGtub3duDQogPiAgICAgICAgICAgICAgICAgICAgICAgc29ja2V0LCByZXRyaWV2ZSB0aGUg
Y29va2llIChnZW5lcmF0ZWQgYnkgdGhlDQogPiAgICAgICAgICAgICAgICAgICAgICAga2Vy
bmVsKSBvZiB0aGlzIHNvY2tldC4gIElmIG5vIGNvb2tpZSBoYXMgYmVlbiBzZXQNCiA+ICAg
ICAgICAgICAgICAgICAgICAgICB5ZXQsIGdlbmVyYXRlIGEgbmV3IGNvb2tpZS4gT25jZSBn
ZW5lcmF0ZWQsIHRoZQ0KID4gICAgICAgICAgICAgICAgICAgICAgIHNvY2tldCBjb29raWUg
cmVtYWlucyBzdGFibGUgZm9yIHRoZSBsaWZlIG9mIHRoZQ0KID4gICAgICAgICAgICAgICAg
ICAgICAgIHNvY2tldC4gVGhpcyBoZWxwZXIgY2FuIGJlIHVzZWZ1bCBmb3IgbW9uaXRvcmlu
Zw0KID4gICAgICAgICAgICAgICAgICAgICAgIHBlciBzb2NrZXQgbmV0d29ya2luZyB0cmFm
ZmljIHN0YXRpc3RpY3MgYXMgaXQNCiA+ICAgICAgICAgICAgICAgICAgICAgICBwcm92aWRl
cyBhIGdsb2JhbCBzb2NrZXQgaWRlbnRpZmllciB0aGF0IGNhbiBiZQ0KID4gICAgICAgICAg
ICAgICAgICAgICAgIGFzc3VtZWQgdW5pcXVlLg0KID4NCiA+ICAgICAgICAgICAgICAgIFJl
dHVybiBBIDgtYnl0ZSBsb25nIG5vbi1kZWNyZWFzaW5nIG51bWJlciBvbiBzdWNjZXNzLCBv
cg0KID4gICAgICAgICAgICAgICAgICAgICAgIDAgaWYgdGhlIHNvY2tldCBmaWVsZCBpcyBt
aXNzaW5nIGluc2lkZSBza2IuDQogPg0KID4gICAgICAgICB1NjQgYnBmX2dldF9zb2NrZXRf
Y29va2llKHN0cnVjdCBicGZfc29ja19hZGRyICpjdHgpDQogPg0KID4gICAgICAgICAgICAg
ICAgRGVzY3JpcHRpb24NCiA+ICAgICAgICAgICAgICAgICAgICAgICBFcXVpdmFsZW50IHRv
IGJwZl9nZXRfc29ja2V0X2Nvb2tpZSgpIGhlbHBlciB0aGF0DQogPiAgICAgICAgICAgICAg
ICAgICAgICAgYWNjZXB0cyBza2IsIGJ1dCBnZXRzIHNvY2tldCBmcm9tIHN0cnVjdA0KID4g
ICAgICAgICAgICAgICAgICAgICAgIGJwZl9zb2NrX2FkZHIgY29udGV4dC4NCiA+DQogPiAg
ICAgICAgICAgICAgICBSZXR1cm4gQSA4LWJ5dGUgbG9uZyBub24tZGVjcmVhc2luZyBudW1i
ZXIuDQogPg0KID4gICAgICAgICB1NjQgYnBmX2dldF9zb2NrZXRfY29va2llKHN0cnVjdCBi
cGZfc29ja19vcHMgKmN0eCkNCiA+DQogPiAgICAgICAgICAgICAgICBEZXNjcmlwdGlvbg0K
ID4gICAgICAgICAgICAgICAgICAgICAgIEVxdWl2YWxlbnQgdG8gYnBmX2dldF9zb2NrZXRf
Y29va2llKCkgaGVscGVyIHRoYXQNCiA+ICAgICAgICAgICAgICAgICAgICAgICBhY2NlcHRz
IHNrYiwgYnV0IGdldHMgc29ja2V0IGZyb20gc3RydWN0DQogPiAgICAgICAgICAgICAgICAg
ICAgICAgYnBmX3NvY2tfb3BzIGNvbnRleHQuDQogPg0KID4gICAgICAgICAgICAgICAgUmV0
dXJuIEEgOC1ieXRlIGxvbmcgbm9uLWRlY3JlYXNpbmcgbnVtYmVyLg0KID4gYGBgDQogPg0K
ID4gVGhlIGZ1bmN0aW9uIGJwZl9nZXRfc29ja2V0X2Nvb2tpZSByZXBlYXRzIHRocmVlIHRp
bWVzLiBUaGUgc2Vjb25kIG9uZQ0KID4gc2hvdWxkIGJlIGJwZl9nZXRfc29ja2V0X2Nvb2tp
ZV9hZGRyIGFuZCB0aGUgdGhpcmQgb25lIHNob3VsZCBiZQ0KID4gYnBmX2dldF9zb2NrZXRf
Y29va2llX29wcy4NCg0KLS0gDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+
DQo=

--------------qzxm106cGgfXO2F0TIyIu05s--

--------------yvXwZG01YbIOcnzaLPyoz9Aa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPY/kkACgkQnowa+77/
2zL8BBAAmrRnP3hx8YqakHnTxms7XuI3HSjKq3kibU0mZS5RGYen1g6+PYBvZ4bA
krLbq06mCDfh2rjNkUAeh5hGxIXM6pzHVxiGI7IL+4PpTrvsRgKe6vnslyCbpCxb
rU+44JtHaftzZrG6KAs3r9yHLvjSSFQnU5e3Kj1EP3iGOguv2adfO8mnyE2BPp2+
nkZ3SmDm7uWL9mUprQhP04x7kHCTSZOBiwwKz5Do1Ucq1veG3Ui+J+Zv49Z59Y13
R2+fLAbx6m5/EZBNRKxrWOpXIJzD9njLagkjvb7klqfCStmGWjH8w3Utmhj4tHyd
vX4ffhbwe+iiXQqHdTBhx4LlZZ+pkCDJcmt8sLJdljpzdxgtRGRq3MKk5RJecOwR
Mn4kmeDizKmRxZzKVLAIunysnizOaVWtgFYhOJuOCIXV6i/KD1sbeVgPNtLzMIW4
AC+/CKGl/55T5LaTrnZmF5SBXVRS/KjlzCqVM1Oi/iJxOQQXhvd9NKo4N7mTPB+t
yC3v9yo9lpSP58Aqt6jOwEvPxlZRPQ5w6SgYBn6SAo663lWyNBWJ1CeoS6fjwqib
kYo2YhPLbPOtrKoAiZSZjXJIBxPnID1O93XiuB4GQAgVlwJ2+eHtyNNIKjp+ZNkU
d+FCLxr+2M24YNnE4IBf96P15PIJNAcbIe/+Ub3IQ5ORQdOsPCY=
=0K7a
-----END PGP SIGNATURE-----

--------------yvXwZG01YbIOcnzaLPyoz9Aa--
