Return-Path: <bpf+bounces-1608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F1B71F0F4
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F5C281777
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130E4701B;
	Thu,  1 Jun 2023 17:40:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580F42501
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:40:10 +0000 (UTC)
Received: from relay.sandelman.ca (relay.cooperix.net [176.58.120.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836C1B4
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:40:07 -0700 (PDT)
Received: from dyas.sandelman.ca (unknown [142.169.16.93])
	by relay.sandelman.ca (Postfix) with ESMTPS id 318AF209C2;
	Thu,  1 Jun 2023 17:40:06 +0000 (UTC)
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
	id DA5D7A63A4; Thu,  1 Jun 2023 13:40:04 -0400 (EDT)
Received: from dyas (localhost [127.0.0.1])
	by dyas.sandelman.ca (Postfix) with ESMTP id D76DCA6377;
	Thu,  1 Jun 2023 13:40:04 -0400 (EDT)
From: Michael Richardson <mcr+ietf@sandelman.ca>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
cc: "bpf\@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] IETF BPF working group draft charter
In-reply-to: <PH7PR21MB3878F9FEAF8DAD233E2505B4A348A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230523163200.GD20100@maniforge> <18272.1684864698@localhost> <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org> <87y1lclnui.fsf@gnu.org> <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com> <20230526165511.GA1209625@maniforge> <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com> <20230526171929.GB1209625@maniforge> <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com> <ZHbDekB0KderhSTl@infradead.org> <9539.1685561890@dyas> <PH7PR21MB3878F9FEAF8DAD233E2505B4A348A@PH7PR21MB3878.namprd21.prod.outlook.com>
Comments: In-reply-to Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
   message dated "Wed, 31 May 2023 19:44:46 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 01 Jun 2023 13:40:04 -0400
Message-ID: <18718.1685641204@dyas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain


Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org> wrote:
    >> I assume that one use cases is where a VM (windows or Linux inside)
    >> does a eBPF (XDP) load into a virtual network interface, and the
    >> hypervisor manages to push that down to some engine in a physical
    >> card.
    >>
    >> In that case, we might have mixes of Windows, Linux and network card
    >> implementations of eBPF on the same "transaction" path.

    > Yes, exactly right.

Okay, I'm unclear if that implies that we need all the discussed ELF and ABI issues
to be compatible all the way down.  Or if each layer can do it's adaptation
in incompatible ways, and that's okay.


--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-                      *I*LIKE*TRAINS*




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmR41/QACgkQcAKuwszY
gENPPgv/dk7grtwsVPOkgTru+Q3eL8ms9Rf7bQDr5A5HOIDDQ7RPw08McEOTMz7E
Quqkf1py7mP2Ct0RRzRyStjj4gXGX98IXUopxb4ICYHzl4FtYgkiDhU+8hszZPDe
VCHPcW6TJF+pwxDFwvtLRGT5AX1K82mNM0RqG/KNPhcXth/q9GKA6GoPO3UA4Iwl
0CzfPKEbKLKG/MXtfeIr0cw7jxpoMsQ5IpXGNXk+MsSJzUp1SdGA73SMTafDjdTX
2ipYV8qoitfQS1vZgWyaeZTrGsgxZzs4FlEotCchSw1NoTPBTGsfIZXWU9Q49Fs2
n6eM7e86Vlc5Cvaqarnyrvj5OArjuL1rmWJUVsxB8kWTGY9vk9NAWcdq66gkiGGY
8K/n6wwUdeSvtFdoTCCzZbV0dKHFG9cGti2csrQ+6xNG2tAodmYSOtf5fuUU7Yyf
Z9LsyqlFjsviauSX0CiFlOUCSM5Eh0E+SK8aIu3lgfwW58oryzNi1pRcYdH0nXhi
NKUQEKw4
=GjDw
-----END PGP SIGNATURE-----
--=-=-=--

