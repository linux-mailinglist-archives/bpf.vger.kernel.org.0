Return-Path: <bpf+bounces-4470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD074B610
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A201C20F18
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376D171B3;
	Fri,  7 Jul 2023 18:02:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7C11181
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 18:02:58 +0000 (UTC)
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 11:02:57 PDT
Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781B2110
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 11:02:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 2E15238994;
	Fri,  7 Jul 2023 13:56:37 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SVy8pFdCOld2; Fri,  7 Jul 2023 13:56:36 -0400 (EDT)
Received: from sandelman.ca (unknown [IPv6:2607:f0b0:f:2:40a:34ff:fe10:f571])
	by tuna.sandelman.ca (Postfix) with ESMTP id 675E93898D;
	Fri,  7 Jul 2023 13:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1688752596;
	bh=nqpELVn9tuVPMbDJwkHplUo+RFhg6qY7mk023MF0Cr8=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=c1c2s4tGNKjVMo3iCt4k3luoFCAZ6lleHVW8fRq0/eFFiXierWA9+w3pyZX+5KWo5
	 lgX3l2obwpnsWSN86te57yTqXjouyj46P1HkpbktcsN+PYCH70EVkn78INW4hXznrw
	 vLlfJaD6Jncdx5OFDPOf9TrqNhHB25p0Gj8Ucuo5/ObKdhAg0SMOpSXr5KbhxTrChG
	 RIcdCDCNV56KQdKoP7AotZZU+n8kF6cg0RlkyrZ3QqAwZnOhkqH+FP7b+v1zwdQ+oq
	 89h0W8BWwe8mftsQf5ujhnB8wFzF2jWESz79yH+DxIIPyBEDUe+AotJjIaXDkKoHF9
	 at0i8JkaE5jng==
Received: from localhost (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 4360D9A;
	Fri,  7 Jul 2023 13:56:36 -0400 (EDT)
From: Michael Richardson <mcr+ietf@sandelman.ca>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>,
    "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] Instruction set extension policy
In-Reply-To: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 27.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 07 Jul 2023 13:56:36 -0400
Message-ID: <23460.1688752596@localhost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Dave Thaler <dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
    > Once the BPF ISA is published in an RFC, we expect more instructions
    > may be added over time.  It seems undesirable to delay use such
    > additions until another RFC can be published, although having them
    > appear in an RFC would be a good thing in my view.

agreed.

    > Personally, I envision such additions to appear in an RFC per extensi=
on
    > (i.e., set of additions) rather than obsoleting the original ISA RFC.
    > So I would propose the ability to reference another document (e.g., o=
ne
    > in the Linux kernel tree) in the meantime.

That seems like a really good plan.
They won't have to be long documents either.
It would be nice if there could be sufficient template so that they don't
need a lot of cross-area review to publish.

There is also a thought that there is simply a "yearly" wrap up of all
allocations.

    > Similarly, I would propose as a strawman using an IANA registry (as
    > most IETF standards do) that requires say an IETF Standards Track RFC
    > for "Permanent" status, and "Specification required" (a public
    > specification reviewed by a designated expert) for "Provisional"
    > registrations.  So updating a document in say the Linux kernel tree
    > would be sufficient for Provisional registration, and the status of an
    > instruction would change to Permanent once it appears in an RFC.

    > Thoughts?

I think it important to distinguish for the group between
experimental/private-use space and provisional.

I don't think you want to renumber an instruction when it goes to Permanent
status.  I also think that you want to run this as Early Allocations, so th=
at
they have a sunset clause, and the process for sunsetting such an allocation
should be clear.

You may also need to written policy (in the Linux kernel Documentation) abo=
ut
back-patching of Provisional numbers into vendor branches and/or LTS
branches.

Can there be subtle semantic changes to Provisional allocations?
(Such as what happens when invalid data occurs?  The divide-by-zero
equivalent)



=2D-
Michael Richardson <mcr+IETF@sandelman.ca>   . o O ( IPv6 I=C3=B8T consulti=
ng )
           Sandelman Software Works Inc, Ottawa and Worldwide





--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFKBAEBCgA0FiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmSoUdQWHG1jcitpZXRm
QHNhbmRlbG1hbi5jYQAKCRCAi3D73dDdZTpYB/9DziNKcDHyibQyEXUdcJIi7OzW
kUoZu6jPVHLhiRKsm5xSf65UBz5/qJBk76PI/XVRmRMvGDLm5miy37886W1kpU1a
r4iWYwB+FCwNCTSrU3h41x7D/8jAUBQvecC+LksQFT78wJMSQJ+8cTWIW1dl8YxM
JvFF+iwLOz78n8v5wAX6YcvdJg6m8zOJjBxbu3XPkDoqAT70INtqBHlk7yQd9zFE
SND4Tks39YH27ACtoagaGhcSabP2M7IuJuDtT8Kx+K6BNfAFi+1sHEgUQ4qWylPr
8U+fX1+miIh6/TlK+/bAN8KYjHy7hEdCTPBdXUfYAP/tWhCIwjL+7qO2cwaq
=DZ14
-----END PGP SIGNATURE-----
--=-=-=--

