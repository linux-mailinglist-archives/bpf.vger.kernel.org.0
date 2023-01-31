Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2CA682B08
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 12:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjAaLAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 06:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjAaLAl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 06:00:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E148610;
        Tue, 31 Jan 2023 03:00:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m14so13349439wrg.13;
        Tue, 31 Jan 2023 03:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPqdQy95sUP6RrSyS2VRv9clgTp8DBS73BQ1xVyBRz4=;
        b=BgFI42ANQQU0TGUyWTba74wnoF95GQhgLEC/csm3QDeMw+1zVGwA1s/fyI3gQTDE4k
         EQa99VZ3eIvxwpaC5a894p+InyvSK8WdkEAoJJS22FBKQ0st52ocJiSGcZKaQdzC5qe9
         CsJcfNsangYYgNoNOEYanX2aZfAnjpTNHxxYERixBlgsmkfYUWknwrhq/VWrdISc6UdX
         vTArGMDly+WWcQAJ572Y4x19Q2HQmllXgrqg83Pv3RPqmSE/0jKW7b+NgBHvmozXaz/L
         wMAMBX2JpuynaR/yvBroq5rPJeaXp+GOotyT64eFAjawty8KQjTmIQNg5olf+axJBzvd
         JCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VPqdQy95sUP6RrSyS2VRv9clgTp8DBS73BQ1xVyBRz4=;
        b=kRmT4PLafYmvChMcHPLhZXYuJkMSStpoh0y3EO9uvGQ8ipPn/BH20SjsBQLy+tEBoJ
         HMqnp8DhwAQ5v8O1Am/4nOB7gr+XrozHkDzwgQ6VCIreKuqhjITIahgtlCJ5/eibKb0I
         T7LJb6zwi84ZKmhsSieT44QFFSdWue4sK8Kpvkz2Yf9Bj3yvXmtVtYGhFTzUdBODZqoo
         mcEcBu3Zm3Hbm1G2foFziDY/bWXUUPfIOqDskQLgPM0WjuYxuRE8HLIgnn22IEFXZteE
         h39ErpeZXdZzaRmbqoIG+t4lOJkC+ezCFSX1HIZygqN/IoHblhhutiWGuthYUn8cfQdF
         7lHg==
X-Gm-Message-State: AO0yUKWFTSx5qZ3KWGN9l8W4lMKtkraazOvaXA7fpy61QdgIw0jiw7Ph
        yMnsOGwjsfjoOrUHRw6Mmbo=
X-Google-Smtp-Source: AK7set/jpWjXMWrlZcMDi0HdPMxyKXilexfk5pSQPT5ipzf0lfGNj66o1HP3JfKp6s0yCIfmPQN3Ow==
X-Received: by 2002:a5d:6f03:0:b0:2bf:b140:ae11 with SMTP id ay3-20020a5d6f03000000b002bfb140ae11mr2454363wrb.63.1675162816057;
        Tue, 31 Jan 2023 03:00:16 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b002bc8130cca7sm14489528wrr.23.2023.01.31.03.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 03:00:15 -0800 (PST)
Message-ID: <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
Date:   Tue, 31 Jan 2023 12:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Typo in the man7 bpf-helpers page
Content-Language: en-US
To:     Zexuan Luo <spacewanderlzx@gmail.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        bpf <bpf@vger.kernel.org>
Cc:     linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jz8q6fAXEO0umwoOFmLDS0BC"
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
--------------jz8q6fAXEO0umwoOFmLDS0BC
Content-Type: multipart/mixed; boundary="------------k00wc89bSardHlYqlUpY8Oyg";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Zexuan Luo <spacewanderlzx@gmail.com>,
 Quentin Monnet <quentin.monnet@netronome.com>, bpf <bpf@vger.kernel.org>
Cc: linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Message-ID: <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
Subject: Re: Typo in the man7 bpf-helpers page
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
In-Reply-To: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>

--------------k00wc89bSardHlYqlUpY8Oyg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgWmV4dWFuLCBRdWVudGluLA0KDQpPbiAxLzMxLzIzIDExOjAzLCBaZXh1YW4gTHVvIHdy
b3RlOg0KPiBIZWxsbyBDb2xvbWFyLA0KPiANCj4gSSBqdXN0IGZvdW5kIGEgcG90ZW50aWFs
IGJ1ZyBpbiB0aGUgYnBmLWhlbHBlcnMgcGFnZS4NCg0KVGhhbmtzIGZvciByZXBvcnRpbmcg
YnVncyA6KQ0KDQo+IA0KPiBVbmRlciB0aGUgaHR0cHM6Ly93d3cubWFuNy5vcmcvbGludXgv
bWFuLXBhZ2VzL21hbjcvYnBmLWhlbHBlcnMuNy5odG1sOg0KDQpUaGlzIHBhZ2UgaXMgZ2Vu
ZXJhdGVkIGZyb20gdGhlIExpbnV4IGtlcm5lbCBzb3VyY2VzLiAgSSd2ZSBDQ2VkIFF1ZW50
aW4gYW5kIHRoZSANCkJQRiBsaXN0IHNvIHRoZXkgY2FuIGNoZWNrIGl0IHRoZXJlLg0KDQpC
VFcsIEknbSByZWZyZXNoaW5nIHRoZSBwYWdlIG5vdy4NCg0KUXVlbnRpbiwgSSByZWFsaXpl
ZCBpbiB0aGUgZGlmZiB0aGF0IHRoZXJlIGlzIHNvbWUgaW5jb25zaXN0ZW5jeSBpbiB0aGUg
bnVtYmVyIA0Kb2Ygc3BhY2VzIGFmdGVyIGEgc2VudGVuY2UtZW5kaW5nIHBlcmlvZC4gIENv
dWxkIHlvdSBwbGVhc2UgdXNlIHR3byBzcGFjZXMgZm9yIA0KdGhhdD8gIEl0J3MgZXNwZWNp
YWxseSBpbXBvcnRhbnQgZm9yIGdyb2ZmKDEpLCB3aGljaCB3aWxsIHJlbmRlciBpdCBkaWZm
ZXJlbnRseS4gDQogIEhvd2V2ZXIsIGl0J3Mgbm90IGEgYmlnIGlzc3VlLCBzbyBkb24ndCBm
ZWVsIHVyZ2VkIHRvIGRvIHRoYXQuDQoNCkNoZWVycywNCg0KQWxleA0KDQo+IA0KPiBgYGAN
Cj4gICAgICAgICB1NjQgYnBmX2dldF9zb2NrZXRfY29va2llKHN0cnVjdCBza19idWZmICpz
a2IpDQo+IA0KPiAgICAgICAgICAgICAgICBEZXNjcmlwdGlvbg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgSWYgdGhlIHN0cnVjdCBza19idWZmIHBvaW50ZWQgYnkgc2tiIGhhcyBhIGtu
b3duDQo+ICAgICAgICAgICAgICAgICAgICAgICBzb2NrZXQsIHJldHJpZXZlIHRoZSBjb29r
aWUgKGdlbmVyYXRlZCBieSB0aGUNCj4gICAgICAgICAgICAgICAgICAgICAgIGtlcm5lbCkg
b2YgdGhpcyBzb2NrZXQuICBJZiBubyBjb29raWUgaGFzIGJlZW4gc2V0DQo+ICAgICAgICAg
ICAgICAgICAgICAgICB5ZXQsIGdlbmVyYXRlIGEgbmV3IGNvb2tpZS4gT25jZSBnZW5lcmF0
ZWQsIHRoZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgc29ja2V0IGNvb2tpZSByZW1haW5z
IHN0YWJsZSBmb3IgdGhlIGxpZmUgb2YgdGhlDQo+ICAgICAgICAgICAgICAgICAgICAgICBz
b2NrZXQuIFRoaXMgaGVscGVyIGNhbiBiZSB1c2VmdWwgZm9yIG1vbml0b3JpbmcNCj4gICAg
ICAgICAgICAgICAgICAgICAgIHBlciBzb2NrZXQgbmV0d29ya2luZyB0cmFmZmljIHN0YXRp
c3RpY3MgYXMgaXQNCj4gICAgICAgICAgICAgICAgICAgICAgIHByb3ZpZGVzIGEgZ2xvYmFs
IHNvY2tldCBpZGVudGlmaWVyIHRoYXQgY2FuIGJlDQo+ICAgICAgICAgICAgICAgICAgICAg
ICBhc3N1bWVkIHVuaXF1ZS4NCj4gDQo+ICAgICAgICAgICAgICAgIFJldHVybiBBIDgtYnl0
ZSBsb25nIG5vbi1kZWNyZWFzaW5nIG51bWJlciBvbiBzdWNjZXNzLCBvcg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgMCBpZiB0aGUgc29ja2V0IGZpZWxkIGlzIG1pc3NpbmcgaW5zaWRl
IHNrYi4NCj4gDQo+ICAgICAgICAgdTY0IGJwZl9nZXRfc29ja2V0X2Nvb2tpZShzdHJ1Y3Qg
YnBmX3NvY2tfYWRkciAqY3R4KQ0KPiANCj4gICAgICAgICAgICAgICAgRGVzY3JpcHRpb24N
Cj4gICAgICAgICAgICAgICAgICAgICAgIEVxdWl2YWxlbnQgdG8gYnBmX2dldF9zb2NrZXRf
Y29va2llKCkgaGVscGVyIHRoYXQNCj4gICAgICAgICAgICAgICAgICAgICAgIGFjY2VwdHMg
c2tiLCBidXQgZ2V0cyBzb2NrZXQgZnJvbSBzdHJ1Y3QNCj4gICAgICAgICAgICAgICAgICAg
ICAgIGJwZl9zb2NrX2FkZHIgY29udGV4dC4NCj4gDQo+ICAgICAgICAgICAgICAgIFJldHVy
biBBIDgtYnl0ZSBsb25nIG5vbi1kZWNyZWFzaW5nIG51bWJlci4NCj4gDQo+ICAgICAgICAg
dTY0IGJwZl9nZXRfc29ja2V0X2Nvb2tpZShzdHJ1Y3QgYnBmX3NvY2tfb3BzICpjdHgpDQo+
IA0KPiAgICAgICAgICAgICAgICBEZXNjcmlwdGlvbg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgRXF1aXZhbGVudCB0byBicGZfZ2V0X3NvY2tldF9jb29raWUoKSBoZWxwZXIgdGhhdA0K
PiAgICAgICAgICAgICAgICAgICAgICAgYWNjZXB0cyBza2IsIGJ1dCBnZXRzIHNvY2tldCBm
cm9tIHN0cnVjdA0KPiAgICAgICAgICAgICAgICAgICAgICAgYnBmX3NvY2tfb3BzIGNvbnRl
eHQuDQo+IA0KPiAgICAgICAgICAgICAgICBSZXR1cm4gQSA4LWJ5dGUgbG9uZyBub24tZGVj
cmVhc2luZyBudW1iZXIuDQo+IGBgYA0KPiANCj4gVGhlIGZ1bmN0aW9uIGJwZl9nZXRfc29j
a2V0X2Nvb2tpZSByZXBlYXRzIHRocmVlIHRpbWVzLiBUaGUgc2Vjb25kIG9uZQ0KPiBzaG91
bGQgYmUgYnBmX2dldF9zb2NrZXRfY29va2llX2FkZHIgYW5kIHRoZSB0aGlyZCBvbmUgc2hv
dWxkIGJlDQo+IGJwZl9nZXRfc29ja2V0X2Nvb2tpZV9vcHMuDQoNCi0tIA0KPGh0dHA6Ly93
d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------k00wc89bSardHlYqlUpY8Oyg--

--------------jz8q6fAXEO0umwoOFmLDS0BC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPY9LgACgkQnowa+77/
2zIVZQ//b3GIQWUGuXDeMqWmm8lSiy1VGqoPFjaDOxASfDVQmu9GxwUvWAYXHCF0
C/AkXyMyiUrz6G6tarJiRKw2IH6EMZG/WVh83AQ74cxKLZEUEfs2iANAOmi5nBpJ
NcVEDZEVGgkvj2muOxS4YOpPF9nUaV2ZtycoodGjAZVcjmrVIRTD38RIJrb5sVFF
adr6kKk/T1M9ELTdW6GVLw+VrBoic7QKgQpg8yIQVfqdccRwakYCZp26qxunnmnH
XQdf5oSeb+SMFuMHlwhg0ZT3G/u+vJD4kVKbJz2cNPP7+ZBDkR1VeCXSBvCcdXpb
obxycVaFRt+xWPSp+5hv7UAPeibYZ+i9SakUpANr9HEsTaDONfJ6j/okqvm1b46u
ME6IL2seOK9mNzSpZRl1Xfe7AOHJGOIUfke/lAH2crtz3EMBdjqlLC3GABAol7t9
W5M9SMmI+Oz5pjx+FU71CLYZUbBtiH4jJLWJXc95l7k+wrd94j3wBGL3tHHRvCIn
zfgbMbUQiEvRBPtOl5yKq2c8aHmcKV5E4Le2ctiLa/0XQuMRngPBRnMDkJ0NgekL
BJq9aZ6wKsiuCf9TcbRkJlzVdNZ4H1NX8r9ulLHI9yPuY0/Q8SdypvGuHSVc3Tlh
Nz0Qjs/oixViPey6yUbwF+DMOu7efPqBySCHa4z6zd3CC+S/JP8=
=ioOq
-----END PGP SIGNATURE-----

--------------jz8q6fAXEO0umwoOFmLDS0BC--
