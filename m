Return-Path: <bpf+bounces-4468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10374B607
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E18F1C2102F
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8D171A2;
	Fri,  7 Jul 2023 17:56:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9248168BC
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 17:56:47 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710E1709
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 10:56:45 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 016C1C1519BF
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688752605; bh=2mI4KmabANXKXcjVZ9KXnZ3hDL4NNdNX0MNfJMyfY18=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Si90l7jMOzwzQedsGHW5RCaMLAeJhZIAeiZX4bltDTFmKwSvmDeCuiqiSqDDuv/mV
	 jwGDmZRWSgIXGXIjYBifmSow/jwrDI5wffJVOQA5TKFaMhg/N4xUaFy+hpuHIfYSNL
	 aNtwTSpepmf5IYXFLp7sPqwcyqWGyI5dx8o7cUMA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul  7 10:56:44 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CF705C15199C;
	Fri,  7 Jul 2023 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688752604; bh=2mI4KmabANXKXcjVZ9KXnZ3hDL4NNdNX0MNfJMyfY18=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Ry6cW/tuPxBY5ATftKpigLbO6dquuWxir71830U+O6e3eYKFKE3mabG1f5rDBg9h4
	 L3puG49479BimugWePqmrjxUdr1knCiWoW1jwBQGUA7oJjqAZmfSdT5dS9D6pZxQCZ
	 W0cl5yFvWJ6LswQMlfSWI4HzyibT+UyEifOwBWvc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9E6B5C15199C
 for <bpf@ietfa.amsl.com>; Fri,  7 Jul 2023 10:56:43 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.096
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=sandelman.ca
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nIIZ5AaFpZa8 for <bpf@ietfa.amsl.com>;
 Fri,  7 Jul 2023 10:56:39 -0700 (PDT)
Received: from tuna.sandelman.ca (tuna.sandelman.ca
 [IPv6:2607:f0b0:f:3:216:3eff:fe7c:d1f3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 99C2BC151999
 for <bpf@ietf.org>; Fri,  7 Jul 2023 10:56:39 -0700 (PDT)
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
In-Reply-To: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 27.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;
 <'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 07 Jul 2023 13:56:36 -0400
Message-ID: <23460.1688752596@localhost>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/i_lOCrQ-lPkwR6BZaX7TqVxe9v8>
Subject: Re: [Bpf] Instruction set extension policy
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0682268535968767534=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============0682268535968767534==
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"

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


--===============0682268535968767534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0682268535968767534==--


