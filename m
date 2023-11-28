Return-Path: <bpf+bounces-16033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F87FB624
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325A928279A
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D24B5C0;
	Tue, 28 Nov 2023 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Laa0xsNp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Laa0xsNp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="kRJL01DX"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26654109
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 01:43:47 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D9677C15155E
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 01:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1701164626; bh=rjL4vcGTUpKyDeryi78sqJQAgruO217DXlTziBQFS98=;
	h=From:To:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Laa0xsNpmbqIdsIBvnP2+cXmh1y58OeANnb+b55H8RRV0AVIUbNrjmXplXMoc+Keb
	 ptQa9DqV/4CTDJhzArbhuMM6iYbWYJ+Yv1NWsN/7rQq5uIy+c9DlXx2WVxaDm5pfKI
	 DPNrwic1eC5TLSEscRqd99k2g8bYWfwqZ2H+98qY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Nov 28 01:43:46 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9DB85C14CE38;
	Tue, 28 Nov 2023 01:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1701164626; bh=rjL4vcGTUpKyDeryi78sqJQAgruO217DXlTziBQFS98=;
	h=From:To:In-reply-to:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Laa0xsNpmbqIdsIBvnP2+cXmh1y58OeANnb+b55H8RRV0AVIUbNrjmXplXMoc+Keb
	 ptQa9DqV/4CTDJhzArbhuMM6iYbWYJ+Yv1NWsN/7rQq5uIy+c9DlXx2WVxaDm5pfKI
	 DPNrwic1eC5TLSEscRqd99k2g8bYWfwqZ2H+98qY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7995AC14CE38
 for <bpf@ietfa.amsl.com>; Tue, 28 Nov 2023 01:43:45 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=sandelman.ca
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A_wH6vMg1iBi for <bpf@ietfa.amsl.com>;
 Tue, 28 Nov 2023 01:43:40 -0800 (PST)
Received: from relay.sandelman.ca (relay.cooperix.net [176.58.120.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8322CC14F738
 for <bpf@ietf.org>; Tue, 28 Nov 2023 01:43:39 -0800 (PST)
Received: from dyas.sandelman.ca (dhcp-26-10.mtg.ripe.net [193.0.26.10])
 by relay.sandelman.ca (Postfix) with ESMTPS id E3B881F4A5;
 Tue, 28 Nov 2023 09:43:37 +0000 (UTC)
Authentication-Results: relay.sandelman.ca; dkim=pass (2048-bit key;
 secure) header.d=sandelman.ca header.i=@sandelman.ca header.b="kRJL01DX"; 
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
Date: Tue, 28 Nov 2023 10:43:36 +0100
Message-ID: <539475.1701164616@dyas>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/kyJt2V-6rEZkwQF7b62_bSiSnwg>
Subject: Re: [Bpf] IETF 118 BPF WG summary
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============7133031010960809614=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

--===============7133031010960809614==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

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


--===============7133031010960809614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============7133031010960809614==--


