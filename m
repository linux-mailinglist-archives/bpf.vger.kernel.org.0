Return-Path: <bpf+bounces-1534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91271718A93
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1A32815C6
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE43C09C;
	Wed, 31 May 2023 19:53:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F919E61
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:53:24 +0000 (UTC)
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 12:53:23 PDT
Received: from relay.sandelman.ca (relay.cooperix.net [176.58.120.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A489D
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:53:23 -0700 (PDT)
Received: from dyas.sandelman.ca (ipv6.dyas.sandelman.ca [IPv6:2607:f0b0:f:6::1])
	by relay.sandelman.ca (Postfix) with ESMTPS id 45973209C2;
	Wed, 31 May 2023 19:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sandelman.ca; s=mail;
	t=1685562211; bh=nh/2E7l9Eo6glIkU2giO2kr4x719RGydgBltRjrWVU4=;
	h=From:To:Subject:In-reply-to:References:Date:From;
	b=PUKKFULOQP48GVZ6LS1gKTGR97kt8dSGZFEvbQUlZ9mZd5mwkshUXZIFSSuAGOgK/
	 FgsRDz/1t4x/tgLbLWFt+1pe0F3zg0L9Yp0obXsufhKpKVbA2oM5rZt6T6k12ga6BY
	 V0XsaIGYInavlBiEWqpqLjsbVA0vZs6fxoUtybzwNCtvruv0wzyblvm/jMeI1+zwMF
	 IUXAj7okLSW6mnY/oFR0rSX+8sJ/6IrJnbfKMO1YveQjwhETwwxfalSCnTxTmBw/3n
	 M6Kz70BXK+kobF+QGLD0d+Eneqni67lCYBYcBKN23sanFxtLE0TVzuRHRvPDo67Fkw
	 8pOi+H1cKryNA==
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
	id 9FCAFA63A6; Wed, 31 May 2023 15:38:10 -0400 (EDT)
Received: from dyas (localhost [127.0.0.1])
	by dyas.sandelman.ca (Postfix) with ESMTP id 9D9D8A6377;
	Wed, 31 May 2023 15:38:10 -0400 (EDT)
From: Michael Richardson <mcr+ietf@sandelman.ca>
To: "bpf\@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] IETF BPF working group draft charter
In-reply-to: <ZHbDekB0KderhSTl@infradead.org>
References: <20230523163200.GD20100@maniforge> <18272.1684864698@localhost> <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org> <87y1lclnui.fsf@gnu.org> <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com> <20230526165511.GA1209625@maniforge> <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com> <20230526171929.GB1209625@maniforge> <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com> <ZHbDekB0KderhSTl@infradead.org>
Comments: In-reply-to Christoph Hellwig <hch@infradead.org>
   message dated "Tue, 30 May 2023 20:48:10 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 31 May 2023 15:38:10 -0400
Message-ID: <9539.1685561890@dyas>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain


I assume that one use cases is where a VM (windows or Linux inside) does a
eBPF (XDP) load into a virtual network interface, and the hypervisor manages
to push that down to some engine in a physical card.

In that case, we might have mixes of Windows, Linux and network card
implementations of eBPF on the same "transaction" path.

--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-                      *I*LIKE*TRAINS*




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmR3oiIACgkQcAKuwszY
gEPNywwApDNYEY1FOZxxA6q+3i2uuLVSgOD5fK7V92DyytX2t7tlWref0mN7EJry
a/N0GgIuTTKWLa/R8mf5hTdpCRQ3I1cHaOYJiupSiF3Gs7/zhwcEJ2qhIfcU4X9d
5N/Rzgif41NFyNJX+f9cvV03r3UStpMJeu2RJ0fRsGTq7Xfkc+7RwTNEzhu0pHfg
PoDitf0w6pSQDKeTBg/hmgpwYQoQ56qAWaeJsUU06baMru6RmfYPedb0g/Maac4o
T9jF2zfcILhBlJ/DGMFAuFypoXBirIuS+xhPpJzYD7gmY+ULCjayAu16mGdeg2kG
gwNMIQZdEDYQB5N4aiQINB4I8JFnlJ7G36EJiKhwINgweFpcuIVMTFNpRaLpOoSv
/9+aaMRnPINYyLixvoiIgZWbWNw5r/5zy2KIIBGqyfVzJFjVqH/9YkYkCrhzLPdN
4j096l0tDbtmoJk2fxlaBegMCm464ohVFBfiev3XUQUCraV9fTeZLXR7FPZVgM1i
iNCYd4NE
=KU0I
-----END PGP SIGNATURE-----
--=-=-=--

