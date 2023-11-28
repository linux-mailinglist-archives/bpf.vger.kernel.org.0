Return-Path: <bpf+bounces-16032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F47FB617
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD271C21122
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C04A98C;
	Tue, 28 Nov 2023 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="kRJL01DX"
X-Original-To: bpf@vger.kernel.org
Received: from relay.sandelman.ca (relay.cooperix.net [IPv6:2a01:7e00:e000:2bb::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C73BE
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 01:43:39 -0800 (PST)
Received: from dyas.sandelman.ca (dhcp-26-10.mtg.ripe.net [193.0.26.10])
	by relay.sandelman.ca (Postfix) with ESMTPS id E3B881F4A5;
	Tue, 28 Nov 2023 09:43:37 +0000 (UTC)
Authentication-Results: relay.sandelman.ca;
	dkim=pass (2048-bit key; secure) header.d=sandelman.ca header.i=@sandelman.ca header.b="kRJL01DX";
	dkim-atps=neutral
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
	id 6972EA0EA4; Tue, 28 Nov 2023 10:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sandelman.ca; s=dyas;
	t=1701164616; bh=V++t50RdFh97gfStfpihxNegajDRmjgxfyxc4gjCg8M=;
	h=From:To:Subject:In-reply-to:References:Date:From;
	b=kRJL01DXQBAFgrzSOih/I5DXJvXDHIronI6KSvDYFWmfdqTkIeSKqEr9BlktlSevY
	 Y5dBn744SbHPGp5vL0T8pHzEkSIjpAMFO0iAPOZBDoi3JP3hmGBj7z/YrKp7Yd30P6
	 VQr9izeSBY2iyI5KzDoy7V9BOPHDXnzRXxr3r6eESrVZX8x/FhYqgjO9XirQx7qJcn
	 KSKgR4Zwm6PMERmkJTRTYB9Qb9AtjnhjucD3BI/3mfUbvi6Jo7QSW//YtVH9Y3+Yrs
	 FzKbHQNEIdmFZhb+4k7MNYTZrHCdImhQekFx5nmJ9RbLReGIgeBvzvBDXm2xE4aTTc
	 ccQH77jbAzbHQ==
Received: from dyas (localhost [127.0.0.1])
	by dyas.sandelman.ca (Postfix) with ESMTP id 669A4A0EA2;
	Tue, 28 Nov 2023 10:43:36 +0100 (CET)
From: Michael Richardson <mcr+ietf@sandelman.ca>
To: David Vernet <void@manifault.com>, bpf@ietf.org, bpf@vger.kernel.org
Subject: Re: [Bpf] IETF 118 BPF WG summary
In-reply-to: <20231127201817.GB5421@maniforge>
References: <20231127201817.GB5421@maniforge>
Comments: In-reply-to David Vernet <void@manifault.com>
   message dated "Mon, 27 Nov 2023 14:18:17 -0600."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 28 Nov 2023 10:43:36 +0100
Message-ID: <539475.1701164616@dyas>

--=-=-=
Content-Type: text/plain


David Vernet <void@manifault.com> wrote:
    > We had a productive BPF working group meeting at IETF 118, and we
    > wanted to provide a summary to recap what was discussed.

David, this is a most excellent summary, thank you.
(I wasn't there, I had a conflict)

    > subset. Existing language MMs do not properly handle control
    > dependencies, and suffer from issues such as OOTA (Out-of-Thin-Air)
    > reads. The presentation outlined the control dependencies proposed for
    > various types of BPF instructions, such as atomics, jumps, etc.

I didn't know what an OOTA read was, but I think that hte first answer at:
  https://stackoverflow.com/questions/42588079/what-is-out-of-thin-air-safety

explained it, but I just wnated to be sure that this was the same term.

I think that we don't expect compilers emitting BPF code to do things like
the tearing example:
        void threadA() {
            g = 0xAB00;  // "tearing"
            g += 0x00CD;
        }

but an underlying BPF JIT might do this kind of thing, and of course, the
reads could be anywhere, and the variable could be written by C-code (or
RUST!).


--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-                      *I*LIKE*TRAINS*




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmVltkgACgkQcAKuwszY
gEMa/AwAhhnU4ksVpOS6W3Gi8BRUMYr8ZJRH7lWCBKFIlnqyzlRonLHtbRa5b9pY
XVaj5aI/8os+O1xG1/B2aqXJ8OVz30DC/BVDMJjcOKBqP5lgzYwZrrXPSoGWaO+J
gpV0XaWYjubyTwfwZCeuYmp1IN2ElTAYJVjFrrUFggIXfuKOKSqJ1xrjGikbnosH
EO0zkjoSxFHyBnZh6C+0s0K2B+JdC33Ai15zFv9SA8hAFzfJP9/jK+rvwkrvJKWb
AXLan3sYOAFKQZGftqwYhW2lx9KdSxu2raar1x7Vv751zQO4ILB3cGcOYYg/qGP7
nUCVHWRvfQizC7RSFBNhrmiaNdcDryL2/quRHP3ft7wK+CT6Kjzvc/UEhUpBwmxE
M5t2GxHfCKfzNoP5Dzr4i7iHm79DKarFfnBdyjzY4WDSo91JsNy5lNAhum13v4dv
KBY9PP1os2+kp6OQPHKS6G5+5dpc9cFDsp1zHGVMLPOzj1v4yEkhjoROlXvqOyTW
puYGc4ZF
=wl7o
-----END PGP SIGNATURE-----
--=-=-=--

