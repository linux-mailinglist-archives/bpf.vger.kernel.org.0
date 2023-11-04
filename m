Return-Path: <bpf+bounces-14205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B07E0ED0
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D94B21430
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D9BE6D;
	Sat,  4 Nov 2023 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="SN8g36pI";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="SN8g36pI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB12D616
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 10:52:56 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA8112
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 03:52:54 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 881A7C2E0E9B
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699095174; bh=+CpG8ohQ5B6CoE6eRT6xbE41U/mKPV68ysz7RNcXYJw=;
	h=From:To:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=SN8g36pIqwM0auHMJPyohNHFU9D1WLcxXR5KjHGwy8ArsG+wGVRMu5seuIjzyODZw
	 ZJulqZtdIRb1qxiylDE5vCP+3GXmmHfr8VawqVfvuVHlPxvC3C/kSEdYHMNtUlUEci
	 c8rgWP0Iv5TjbaMnXlGZkDoPyKvocC2Lbbgus3sk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Nov  4 03:52:54 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4F359C090FCB;
	Sat,  4 Nov 2023 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699095174; bh=+CpG8ohQ5B6CoE6eRT6xbE41U/mKPV68ysz7RNcXYJw=;
	h=From:To:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=SN8g36pIqwM0auHMJPyohNHFU9D1WLcxXR5KjHGwy8ArsG+wGVRMu5seuIjzyODZw
	 ZJulqZtdIRb1qxiylDE5vCP+3GXmmHfr8VawqVfvuVHlPxvC3C/kSEdYHMNtUlUEci
	 c8rgWP0Iv5TjbaMnXlGZkDoPyKvocC2Lbbgus3sk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B9764C17DC0A
 for <bpf@ietfa.amsl.com>; Sat,  4 Nov 2023 03:52:52 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.906
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uierGEjyjOu1 for <bpf@ietfa.amsl.com>;
 Sat,  4 Nov 2023 03:52:49 -0700 (PDT)
Received: from relay.sandelman.ca (relay.cooperix.net
 [IPv6:2a01:7e00:e000:2bb::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D6996C187701
 for <bpf@ietf.org>; Sat,  4 Nov 2023 03:52:48 -0700 (PDT)
Received: from dyas.sandelman.ca (x52717996.dyn.telefonica.de [82.113.121.150])
 by relay.sandelman.ca (Postfix) with ESMTPS id 7A9E320B44;
 Sat,  4 Nov 2023 10:52:47 +0000 (UTC)
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
 id 13A07A1B52; Sat,  4 Nov 2023 06:52:30 -0400 (EDT)
Received: from dyas (localhost [127.0.0.1])
 by dyas.sandelman.ca (Postfix) with ESMTP id 11869A1B51;
 Sat,  4 Nov 2023 11:52:30 +0100 (CET)
From: Michael Richardson <mcr+ietf@sandelman.ca>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>,
 "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
 "bpf\@ietf.org" <bpf@ietf.org>
In-reply-to: <PH7PR21MB38787378F01B057C9FF7D25BA3A4A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20231009170843.GA236066@maniforge>
 <PH7PR21MB38787378F01B057C9FF7D25BA3A4A@PH7PR21MB3878.namprd21.prod.outlook.com>
Comments: In-reply-to Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
 message dated "Sat, 04 Nov 2023 10:17:56 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Nov 2023 11:52:30 +0100
Message-ID: <3448856.1699095150@dyas>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/IpNmHvaTt_ybM_qepnaxIVd1pec>
Subject: Re: [Bpf] IETF 118 Call for Agenda Items
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
Content-Type: multipart/mixed; boundary="===============5195997557628782864=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

--===============5195997557628782864==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain


Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org> wrote:
    >> -----Original Message----- From: David Vernet <void@manifault.com>
    >> Sent: Monday, October 9, 2023 7:09 PM To: bpf@ietf.org Cc:
    >> bpf@vger.kernel.org; bpf-chairs@ietf.org; Erik Kline
    >> <ek.ietf@gmail.com>; Suresh Krishnan <suresh.krishnan@gmail.com>
    >> Subject: IETF 118 Call for Agenda Items
    >>
    >> Hello,
    >>
    >> The BPF working group will be holding a meeting at IETF 118 in a two
    >> hour time slot. The chairs are in the process of setting the
    >> agenda. We would like to solicit agenda items that would be of
    >> interest to the WG participants with a preference to the items that
    >> address the topics of interest covered by the charter. Please send us
    >> your request(s) for slots to bpf-chairs@ietf.org, detailing:
    >>
    >> * Topic and presenter info * Name of associated draft (if any) *
    >> Requested slot duration
    >>
    >> Thanks Suresh and David

    > Just wanted to remind everyone that the BPF working group meeting is
    > coming up on Monday 2023-11-06 09:30-11:30 CET (yes that's 1:30am US
    > Pacific time), and anyone who registers can participate online.

1:30am US PST on Monday morning, which many of us think of as being late
Sunday night.  So don't get the day wrong, use a computer calendering program.

    > Registration: https://registration.ietf.org/118/ Online day pass for
    > Monday is $140 USD or $55 for students.

And there are fee waivers available, and for remote speakers, chairs can get single
session logins.

--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-                      *I*LIKE*TRAINS*




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmVGIm0ACgkQcAKuwszY
gEPkOgwAvXcV2fQ3Z62z3r+DdASeT8nacvwQzxEDBF0519izyCNaBWGoAATE9Nv9
ozTjSR0Qzj5iQ/E/E1B+Kp63z7QCoctTTKnms2KraTk/SZyualWQe2/xnbGXpSlx
NffEU5E9cbf0fTkDctOp5/Wu/GtpWdxMa6VP9YanGEfDDtFCyq6RDboOIZO5JSEH
MgqEQUP5fWACDf63O47yQiyz0lTVdvdrNKN9wZE0th1xyrWWYDiqPkeNEQgeKThJ
sGH5zWNEpy03uMsTLVlSmuSHUyUtV6D+Xp11KXicwlFYb49jKLCaZSsrxNc2+mUg
7ZXQiDiYQzqP6mHDHBhaAiglWbpgb/D8Er+LUn+BYyXixzTSOXH1Ij52/aNPHrLq
0wWfnvAtjJ9AnOaD+Ore7Nh36jV5dRzwbrGsR4ge7ZpbPZIjPCipKMEfWjTJBW7A
LTlNGvFOx0PCq+/SuEJqPQyErNrdPN3E9yu4atONLONb9c0pG2iPndpRhfJcxy4w
c0ArTdyc
=6WRB
-----END PGP SIGNATURE-----
--=-=-=--


--===============5195997557628782864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============5195997557628782864==--


