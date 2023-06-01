Return-Path: <bpf+bounces-1609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E097371F0F5
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7391F1C20F59
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E274701C;
	Thu,  1 Jun 2023 17:40:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0D42501
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:40:20 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2AE1A8
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:40:14 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 58D73C1522D3
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685641214; bh=IuRswXBUeB3klb/pitXrcU9fxJMVjkuzIl2i7qtiJ74=;
	h=From:To:cc:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=l5AKDvslf7qE5jEApMfbT/0lSJNumo16Fo7O+GnZFwR1qeblUojpklnEWg34TXb/z
	 Prq6C1cZM5pnzYGwjLko75aMYwIreryZhX9N2WFekR3Qe4vRG7nE/bJ9XIeZ7vf83v
	 eeWsWfwtXA/3Ce+GBNiez7E2eLCHDk6NXfS3CvhM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jun  1 10:40:14 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3725FC15153F;
	Thu,  1 Jun 2023 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685641214; bh=IuRswXBUeB3klb/pitXrcU9fxJMVjkuzIl2i7qtiJ74=;
	h=From:To:cc:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=l5AKDvslf7qE5jEApMfbT/0lSJNumo16Fo7O+GnZFwR1qeblUojpklnEWg34TXb/z
	 Prq6C1cZM5pnzYGwjLko75aMYwIreryZhX9N2WFekR3Qe4vRG7nE/bJ9XIeZ7vf83v
	 eeWsWfwtXA/3Ce+GBNiez7E2eLCHDk6NXfS3CvhM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2309CC15106F
 for <bpf@ietfa.amsl.com>; Thu,  1 Jun 2023 10:40:13 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.899
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXN6UlQYSFnQ for <bpf@ietfa.amsl.com>;
 Thu,  1 Jun 2023 10:40:08 -0700 (PDT)
Received: from relay.sandelman.ca (relay.cooperix.net
 [IPv6:2a01:7e00:e000:2bb::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id ABC15C15153F
 for <bpf@ietf.org>; Thu,  1 Jun 2023 10:40:08 -0700 (PDT)
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
In-reply-to: <PH7PR21MB3878F9FEAF8DAD233E2505B4A348A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526171929.GB1209625@maniforge>
 <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <ZHbDekB0KderhSTl@infradead.org> <9539.1685561890@dyas>
 <PH7PR21MB3878F9FEAF8DAD233E2505B4A348A@PH7PR21MB3878.namprd21.prod.outlook.com>
Comments: In-reply-to Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
 message dated "Wed, 31 May 2023 19:44:46 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Jun 2023 13:40:04 -0400
Message-ID: <18718.1685641204@dyas>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/sTh0cCI3VN57xieAFTQ40zX2GfE>
Subject: Re: [Bpf] IETF BPF working group draft charter
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
Content-Type: multipart/mixed; boundary="===============1323393198133874213=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============1323393198133874213==
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"

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


--===============1323393198133874213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============1323393198133874213==--


