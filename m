Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9902D46E941
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 14:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhLINnw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 08:43:52 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42807 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbhLINnv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 08:43:51 -0500
Received: by mail-wr1-f42.google.com with SMTP id c4so9726748wrd.9;
        Thu, 09 Dec 2021 05:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=/sESCXEmf0hzex79QNX1fls0JEgS3HA5uEES3FYCF0c=;
        b=cbAJqHCRRFVzOZneVVjLmZnBc5ZxCOEazAsylmkXMH1ZrGHdAb8HxMnCR5C/YNzc1r
         jFgVq2FN9OJ3YvfXwoHz/yDjPM9+dNAtLwFg7pBlYkytjAYM+HbmeqhDDtZKAG84y6Nq
         Lm0C2SmW6nhsCRM6JwhOQvkyzmf8mr8XHqJUDuxa9HQ0b3BuCOXN05a9QuzN7cWag5L8
         SkMSeScLUT/x7Wy+7XbXydCTQVP+1xlRlJG7lKaYGvWTSTV1cCvb7L37a3OeuRUE/8mO
         Gw8y3q+Nl7KaK3fX7bJqHOJz6SYDQjWj6lMvi1rmvTfbO+rUBJL68KFHXaBJ11PyDEt4
         Qmcg==
X-Gm-Message-State: AOAM533xcLsRTCho56yAgaSalDFG2nKh/KzU03Cvwx8MhOIlh3VouIEx
        iA1+dkOQ8eBO3xH9vqwXaKKBNMw9o+c=
X-Google-Smtp-Source: ABdhPJx34AuZzvkYNCHSTeGExyG/2oGwTwIu25FSAeDIM5yJbBthV/AgLCT/aqVjeqrg5VKaWmJHxQ==
X-Received: by 2002:adf:e387:: with SMTP id e7mr6353291wrm.412.1639057216968;
        Thu, 09 Dec 2021 05:40:16 -0800 (PST)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id b197sm5688780wmb.24.2021.12.09.05.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 05:40:16 -0800 (PST)
Message-ID: <5b1e655e96e976f985c8cc9990a590b9c85d7010.camel@debian.org>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
From:   Luca Boccassi <bluca@debian.org>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Thu, 09 Dec 2021 13:40:14 +0000
In-Reply-To: <61b112daa1b84_94d5c208c7@john.notmuch>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
         <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
         <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
         <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
         <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
         <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
         <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
         <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
         <61aae2da8c7b0_68de0208dd@john.notmuch>
         <0079fd757676e62f45f28510a5fd13a9996870be.camel@debian.org>
         <61ae75487d445_c5bd20827@john.notmuch>
         <7ae146389b58f521166e9569be6c64f87359777a.camel@debian.org>
         <f63bef1a56b12a06ed980f9b5e094f84f2434333.camel@debian.org>
         <61b112daa1b84_94d5c208c7@john.notmuch>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-W/ygn3OsmSzVA9s0xH9G"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-W/ygn3OsmSzVA9s0xH9G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-12-08 at 12:17 -0800, John Fastabend wrote:
> [...]
>=20
> > > > > Hope this makes sense. Thanks!
> > > >=20
> > > > I think I understand your use case. When done as BPF helper you
> > > > can get the behavior you want with a one line BPF program
> > > > loaded at boot.
> > > >=20
> > > > int verify_all(struct bpf_prog **prog) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return verify_signa=
ture(prog->insn,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prog->len * sizeof(struc=
t bpf_insn),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signature, KEYRING, BPF_SIGTY=
PE);
> > > > }
> > > >=20
> > > > And I can write some more specific things as,
> > > >=20
> > > > int verify_blobs(void data) {
> > > > =C2=A0 int reject =3D verify_signature(data, data_len, sig, KEYRING=
, TYPE);
> > > > =C2=A0 struct policy_key *key =3D map_get_key();
> > > >=20
> > > > =C2=A0 return policy(key, reject);=C2=A0=20
> > > > }
> > > >=20
> > > > map_get_key() looks into some datastor with the policy likely using
> > > > 'current' to dig something up. It doesn't just apply to BPF progs
> > > > we can use it on other executables more generally. And I get more
> > > > interesting use cases like, allowing 'tc' programs unsigned, but
> > > > requiring kernel memory reads to require signatures or any N
> > > > other policies that may have value. Or only allowing my dbg user
> > > > to run read-only programs, because the dbg maybe shouldn't ever
> > > > be writing into packets, etc. Driving least privilege use cases
> > > > in fine detail.
> > > >=20
> > > > By making it a BPF program we side step the debate where the kernel
> > > > tries to get the 'right' policy for you, me, everyone now and in
> > > > the future. The only way I can see to do this without getting N
> > > > policies baked into the kernel and at M different hook points is vi=
a
> > > > a BPF helper.
> > > >=20
> > > > Thanks,
> > > > John
> > >=20
> > > Now this sounds like something that could work - we can prove that th=
is
> > > could be loaded before any writable fs comes up anywhere, so in
> > > principle I think it would be acceptable and free of races. Matteo, w=
e
> > > should talk about this tomorrow.
> > > And this requires some infrastructure work right? Is there a WIP git
> > > tree somewhere that we can test out?
> > >=20
> > > Thank you!
> >=20
>=20
> I don't have a WIP tree, but I believe it should be fairly easy.
> First I would add a wrapper BPF helper for verify_signature() so
> we can call it from fentry/freturn context. That can be done on
> its own IMO as its a generally useful operation.
>=20
> Then I would stub a hook point into the BPF load path. The exact
> place to put this is going to have some debate I think, but I
> would place it immediately after the check_bpf call.
>=20
> With above two you have enough to do sig verification iiuc.
>=20
> Early boot loading I would have to check its current status. But I know
> folks have been working on it. Maybe its done?
>=20
> > One question more question: with the signature + kconfig approach,
> > nothing can disable the signature check. But if the signature checker
> > is itself a bpf program, is there/can there be anything stopping root
> > from unloading it?
>=20
> Interesting. Not that I'm aware of. Currently something with sufficient
> privileges could unload the program. Maybe we should have a flag so
> early boot programs can signal they shouldn't be unloaded ever. I would
> be OK with this and also seems generally useful. I have a case where
> I want to always set the socket cookie and we leave it running all the
> time. It would be nice if it came up and was pinned at boot.
>=20
> Maybe slightly better than a flag would be to have a new CAP support
> that only early boot has like CAP_BPF_EARLY. From my point of view
> this both seems doable with just some smallish changes on BPF side.
>=20
> Thanks,
> John

Thanks - again the means of enforcing this are not too important for
our use case, as long as there is something that works reliably and can
be attested.

--=20
Kind regards,
Luca Boccassi

--=-W/ygn3OsmSzVA9s0xH9G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmGyBz4ACgkQKGv37813
JB5i+w//fWzUiiv4sKqlYbqsHWF2b/LBRPXQb5o8U/1sD0otmzXDdP+jsxCZEDid
R4geyVA5lFsfTp1KAu/TIotpFbThl/6R9HgjXPqSTkFRIlY6ySTzBiZHivOhxHfG
siBATBIwbe7GtuhhmxTYDt1pmjaQ4KQOtPyEpe42A69HvW4tQN3cmSksdwsvPPd+
aNz1rJQP1dcCx87rnIdspcsN6CK467mWirTWW1c3qePuzVhVOIUx1279FDsRB7xr
DxbtKSkRDJBicpnw0REm+dk7oj56Wh1wMVauSyfmc+k58DAW4BnYn9mGuVM/1riK
xbMxMQhCnIx9g58xlyEOM8DjClnvSavSVT6XyiklM0398+TI8RSo918nE9F9cn6+
zamAy5TIRKmTcyuRKBciFdmEk6+sZ8nH5wMsjmqAQlhKf6U6yxs0Lm5apwlzdbsi
SX+Cs3Twlts4d56fLJv7EMScE5lEJfWUZZst1pupACIh855VVz24h4g43wnhhDSc
0EUEk/1JD/aeUXzyBkoAn183OnkxUWzO8wIZgWUvP+Jc+slopc7Q+t2pGlLxFGgm
uZJODs06CX0unshpkfj+OLV6kcMeewjZKN72Dc9jDB9SW3OAvJM+A7bGvM3O9akt
4nTlLpM8ure2t63v86GIeabrP54JEd4K/E3j+cWHW+cAqlorM/0=
=MPmE
-----END PGP SIGNATURE-----

--=-W/ygn3OsmSzVA9s0xH9G--
