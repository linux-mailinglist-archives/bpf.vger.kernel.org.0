Return-Path: <bpf+bounces-5999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783C2764119
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3155A281F8D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717FC1BF0A;
	Wed, 26 Jul 2023 21:23:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2961BEEA
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 21:23:56 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4B269E;
	Wed, 26 Jul 2023 14:23:43 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.99.148]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mi2BV-1pta0v23hh-00e1RL; Wed, 26 Jul 2023 23:22:56 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
	id 0EA553E9FD; Wed, 26 Jul 2023 23:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
	t=1690406570; bh=guMxT3zoTwr2vilWiRE+24bgG9Cap5wpXyAUs/XneQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6A0R4fi6QWjrigkfNpm/aqCP2zZqd9hR0eEZAvriHpSMxikVAfQHWcUVK7qVZJII
	 5H9TNx0gEVFDcCbkxuMzCCQW2SgPEF/oc/bJdhhI5/9hC3MCHIfZiurQ4uIlnF+eXH
	 RVVIxbEm90+nqFj9q15CIsxYN0KlpXLilMqJenjU=
Date: Wed, 26 Jul 2023 23:22:49 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: George Guo <guodongtai@kylinos.cn>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, nathan@kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Update sockex2: get the expected output
 results
Message-ID: <ZMGOqYG8oCAQmMtq@fjasle.eu>
References: <20230726070955.178288-1-guodongtai@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lNnXaHDZlVni+dB7"
Content-Disposition: inline
In-Reply-To: <20230726070955.178288-1-guodongtai@kylinos.cn>
X-Provags-ID: V03:K1:PEE9o+FfrnXX+8QFTuay5HcHbTBK8BtYX5C0kcSftKusoLpvWxw
 Y+yRx/pyYDxkC2FzKlPsUe1Zae5lLcVAJ2TM+EpR3C9yjNGMW156C1zqb330QIq7nLWw9xK
 G7bpU3i5/j/KfhuebM+47vwdoD/B8Z0uyrLMpnagZ+RDmLyqXhGjbsW2Pgsyi8455unU202
 wSHf+elj+ZRM5WRSlEzJg==
UI-OutboundReport: notjunk:1;M01:P0:DbSP5bcjtjs=;7ah/Ba7fJBiL9s91hdBn2iE11MB
 THObXZkcooO4XVCmm49FFvGAlIqijqVrecu/5/QfXhyTQGh+qi1HNmHohAbk/WX4nPjCW3ZB0
 SrGAnvCZznKA6y8uBurmuNc84SigXjZRGNGRXItYmu/AKSRNo63+Wnz/LFhO2im3qzinpEC7p
 utBbhTDNoxHT7FjSc1K8sppgQzPb+n07xTr0+6bhTAIh8QtHpAbRCDPDzrMmHUvghpTCKEFcu
 D5fsyMjUM/RwQ6w7uCtkZtiRMhZW4lz3J0JGUZQNHzk97m/olyqLqoHIz+7S/5bLr8F+02AV8
 uSCAsZ6rnlBIefUGJA0bo0h6139g36gP7faxCTcs+DRYSPMwB3vCQtxZbz47EBPEy72zrPo4A
 K1Q/fSBdSCsS+bB/4n//Id1/GLXgF1q4V9HSjhulSBdfw1cHuH4ZW0cc2a7d2qnPlYn+DfMSy
 KZpIQkb0aNW/kUyqM1uFHMtfIcavqCzh/KNfuahitUiFWSc10DALjTCXIPiR0CjKYOESlTcbi
 eqRYISUgtiBIDby4zi2flkv96cseUi5VOdVa0S+pjHPI8Tt2Gsz6/YPnNtuxfwIzV8LcQvqoX
 eFJsArijjxg6cGKWJwLQOEF3cr8LecOD6FZo75mO5VdVg9d31cWSlzVIBRm+gYtk9w15rcEdv
 +mdA9Kys/zUoC9HRluTbBxPuxHH0ZJYQMwfcO+VNjw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--lNnXaHDZlVni+dB7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 03:09:55PM +0800 George Guo wrote:
> Running "ping -4 -c5 localhost" only shows 4 times prints not 5:
>=20
> $ sudo ./samples/bpf/sockex2
> ip 127.0.0.1 bytes 392 packets 4
> ip 127.0.0.1 bytes 784 packets 8
> ip 127.0.0.1 bytes 1176 packets 12
> ip 127.0.0.1 bytes 1568 packets 16
>=20
> debug it with num prints:
> $ sudo ./samples/bpf/sockex2
> num =3D 1: ip 127.0.0.1 bytes 392 packets 4
> num =3D 2: ip 127.0.0.1 bytes 784 packets 8
> num =3D 3: ip 127.0.0.1 bytes 1176 packets 12
> num =3D 4: ip 127.0.0.1 bytes 1568 packets 16
>=20
> The reason is that we check it faster, just put sleep(1) before check
> while(bpf_map_get_next_key(map_fd, &key, &next_key) =3D=3D 0).
> Now we get the expected results:
>=20
> $ sudo ./samples/bpf/sockex2
> num =3D 0: ip 127.0.0.1 bytes 392 packets 4
> num =3D 1: ip 127.0.0.1 bytes 784 packets 8
> num =3D 2: ip 127.0.0.1 bytes 1176 packets 12
> num =3D 3: ip 127.0.0.1 bytes 1568 packets 16
> num =3D 4: ip 127.0.0.1 bytes 1960 packets 20
>=20
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---

Thanks, sounds reasonable to me (but I haven't checked it).  Might you want=
 to
minimize the diff to only contain the move of the sleep call?

Kind regards,
Nicolas


>  samples/bpf/sockex2_user.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
> index 2c18471336f0..84bf1ab77649 100644
> --- a/samples/bpf/sockex2_user.c
> +++ b/samples/bpf/sockex2_user.c
> @@ -18,8 +18,8 @@ int main(int ac, char **argv)
>  	struct bpf_program *prog;
>  	struct bpf_object *obj;
>  	int map_fd, prog_fd;
> -	char filename[256];
> -	int i, sock, err;
> +	char filename[256], command[64];
> +	int i, sock, err, num =3D 5;
>  	FILE *f;
> =20
>  	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
> @@ -42,21 +42,22 @@ int main(int ac, char **argv)
>  	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
>  			  sizeof(prog_fd)) =3D=3D 0);
> =20
> -	f =3D popen("ping -4 -c5 localhost", "r");
> +	snprintf(command, sizeof(command), "ping -4 -c%d localhost", num);
> +	f =3D popen(command, "r");
>  	(void) f;
> =20
> -	for (i =3D 0; i < 5; i++) {
> +	for (i =3D 0; i < num; i++) {
>  		int key =3D 0, next_key;
>  		struct pair value;
> =20
> +		sleep(1);
>  		while (bpf_map_get_next_key(map_fd, &key, &next_key) =3D=3D 0) {
>  			bpf_map_lookup_elem(map_fd, &next_key, &value);
> -			printf("ip %s bytes %lld packets %lld\n",
> +			printf("num =3D %d: ip %s bytes %lld packets %lld\n", i,
>  			       inet_ntoa((struct in_addr){htonl(next_key)}),
>  			       value.bytes, value.packets);
>  			key =3D next_key;
>  		}
> -		sleep(1);
>  	}
>  	return 0;
>  }
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--lNnXaHDZlVni+dB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTBjqkACgkQB1IKcBYm
EmnN7g/9HHXKhI3q4rW1w1RUQKsozSPEmGnWmd7f+9Yrt/oW76GQX+XxE9rhOksq
XiKWtS+C/l0vNASQdWCrc77GPy5lKDSySoDzLy461PF9fEVQ1QbjCtoosHuM2eKm
pmI8HUsAcEZbJ5RPr5U4gjKhXuCvNP66ZxmsXAAcbrdWMNVk5L3zMEo8iJGCnYr4
/ry8UyJtP/qgNCJcX4wcUrNOfn9QsmIexLGh/zzG0pcH9PtQCdTBrSb6hFOSgv8J
2yAx5a2PdD2RCKgcntYizbW1bhFIogC+1VcqfPB7Tv6bwZZiYBYsxV8OQr6Dpe5b
sQUvem8wWTZQyjPuihsbAAiAnma2oCQMCgmSlOgDAouxbfrX8QFgDKY32mlpSZHC
Kq21skAOOUR7s/kz3uHLuBdvNv/ayxTFXgupCXPR1xPIHaFIYanVds/pBLyc3FfA
cX8mKCFLJhddSFmCXKdT2c6KmHcFDYQbnPPYh00l80qMfKKqNL/E32XMGNyAgAlO
Agg2+WDAk0efJjb5zl5YSV6BSLRzNV+hUvFODhQUxjYWcWjrrs4eyHQQt6bQjkgk
w69Mho1Wby+Q8LBXtD5DpraG+ZMrzi1dNtomQZtulB0c3o/j6BzN3VhGS7F5KKnk
NYyfYbH4wH4k+XL9sboJxm8wbnn976sjemlM3oVq5l+3CqLvvHI=
=qhta
-----END PGP SIGNATURE-----

--lNnXaHDZlVni+dB7--

