Return-Path: <bpf+bounces-44002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C3F9BC414
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739F01F21E1A
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED718BC28;
	Tue,  5 Nov 2024 03:51:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A5185940
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730778669; cv=none; b=Ff4MzbMBMVCBY8wUb4URTFgEoozKinT+SzLJB0zeOXK4/BDae+jkQ64fGdOm7JKexXLFZCCCo8kaurSQaKTgYTPkfSKgpXFwoWcbjlZJRf08DeJs7gqR9Wp2mqyiKQGblX5dkLogMwvwf+cTO4phoah+7n2nsDU8LeV69ih7XF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730778669; c=relaxed/simple;
	bh=xIE+wppkq2N9bJ+dvOaqzWfqJ8+DFB1Ssak9Em9wAho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uUMNHkaRO8yIelo2iB2n4zOQKSL/3MYnSlA23sS6aOXQAEt2QB0s53VQXcgp/vxJc407eK86RCuF3F0D6qTEedtlVYXNrzkNQaVrrCZM6tR4mKbUTzUMO36iGW5Mf4V8qhZ7cbId5Syhv4KaIqwxjIpOOuV3eZi2VH82Tz7nKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4609beb631aso37375631cf.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 19:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730778665; x=1731383465;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4rVjciZSfgxZP8rZ9tySygHmX0BiyLYDvdez+tqAmY=;
        b=syXK51dW6FORch6zkZhsl9HPERjXwIUBtmN+Ao+cgbBZ9PbuXdybnHPeus0QUpP6PV
         dM/MjAfu/hRH/+3D1FeRolXUbmPT5R2FIRo2nJESa79PhmE4JYBWjVZJna9k/HiXvpr8
         DCa9fzhiA24IeF2iDwLGWt+5Cn15yiuSwUQwMl7+IofzghpziJW3fgkS8qxTsVhUmtRv
         RDIOZxIOwxGnHgywhxhtgqAgiEQ31Mbpba5qMU2zKyOwhJLNwq+KVZIaSjwHpnxlknR+
         pDYHpQEWvp/undwXjOpdZGzby/D31VwZFjGo5ubj2Xe5XrxcIH6fqFQyD5v/ZFwu36gY
         sbqw==
X-Gm-Message-State: AOJu0YxMbdhTIeEEcFZqH5efOqgk2NrRvJZjVFMZ8WB2RMLgFBa7zYJB
	69M7sn7zc4XQB8V6oHr7VZGV47k5dYxnmnL+/x/hQNKzf9jsR9GyHSH4QJ9q
X-Google-Smtp-Source: AGHT+IGMf6n4c4UUpZ4d063j0k/EvxRUMN52R/tM0jvx314R+RZiwG8s13WZGPpSRwkYeOzcKuxLKQ==
X-Received: by 2002:a05:6214:45a1:b0:6cb:ee08:d4c1 with SMTP id 6a1803df08f44-6d35c0fa1f3mr204036596d6.13.1730778665286;
        Mon, 04 Nov 2024 19:51:05 -0800 (PST)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc4f7bsm55406676d6.34.2024.11.04.19.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:51:04 -0800 (PST)
Date: Mon, 4 Nov 2024 21:51:01 -0600
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org, bpf-chairs@ietf.org, ek.ietf@gmail.com,
	suresh.krishnan@gmail.com, ast@kernel.org, hch@infradead.org,
	dthaler1968@gmail.com, corbet@lwn.net, kernel-team@meta.com
Subject: RFC 9669: The BPF Instruction Set Architecture
Message-ID: <20241105035101.GD41004@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crKlIWAqZI0Tf5Lg"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--crKlIWAqZI0Tf5Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

We have some exciting news to share: The IETF BPF Instruction Set Architect=
ure
document has officially been published as RFC 9669 [0]. It's been a long ro=
ad,
so I wanted to take this opportunity to talk about the process of bringing =
the
RFC document to fruition, and why it's important that we've standardized co=
re
components of the BPF ecosystem.

[0]: https://www.rfc-editor.org/rfc/rfc9669.html

Why is standardization important to BPF?
----------------------------------------

Those of you who are familiar with the IETF may be wondering why an
organization that has traditionally standardized networking protocols ended=
 up
being the standards body for BPF, and why BPF needed to be standardized in =
the
first place. We all know why it's important for there to be a standard arou=
nd
the encoding and semantics of the bits of an IP packet, for example, but why
would BPF need something similar?

The short answer: device offload. Some device vendors, such as Netronome [1=
],
have already implemented devices that are capable of running XDP programs on
the device directly rather than on the CPU. The use cases for this are quite
straightforward: if you have e.g. a BPF program that will decide to drop a
packet, making that decision on the NIC rather than on the CPU will save CPU
capacity, power consumption, etc.

[1]: https://github.com/Netronome/bpf-samples

Though some vendors have already implemented BPF offloading capabilities
without having a standardized ISA, others are not quite as risk tolerant. As
Christoph discussed [2] at LSFMM 2022, certain NVMe vendors have expressed =
an
interest in building BPF offloading capabilities for various use cases such=
 as
eXpress Resubmission Path (XRP) [3], but they simply can't fund such a proj=
ect
without certain components of BPF being standardized. Hence, the effort to
standardize BPF was born.

[2]: https://www.youtube.com/watch?v=3D9NmDqjfMKfo
[3]: https://www.usenix.org/conference/osdi22/presentation/zhong

Of course, in addition to device offload, the standardization effort may we=
ll
bear fruit in other areas such as software compatibility.

The standardization process
---------------------------

Let's talk briefly about what was involved with the standardization process.
I'm going to skip a lot of details here, and mostly just want to go over the
broad strokes to connect where we started to where we are now.

This whole effort really kicked off in earnest by Christoph back at LSFMM in
2022. At the time of Christoph's presentation (linked above), we had decide=
d on
neither the organization we would work with to push through the
standardization, nor the scope of standardization. As discussed on LWN [4],
several different organizations were considered. The first choice was the e=
BPF
Foundation, with the idea of course being that the charter of the organizat=
ion
is to manage the financial and technical direction of the project. Another
candidate was the Organization for the Advancement of Structured Information
Standards (OASIS), as they were the organization that standardized virtio [=
5].
Finally, the IETF was considered, as Dave Thaler (the engineer who drove BPF
adoption at Microsoft and a participant in LSFMM 2022) was a long-time IETF
member, as was Christoph.

[4]: https://lwn.net/Articles/926882/
[5]: https://lwn.net/Articles/580186/

Following LSFMM 2022, a Side Meeting [6] was conducted as part of IETF 115 =
to
discuss whether BPF was an appropriate topic for standardization with the I=
ETF.
The IETF had always primarily focused on networking topics as described abo=
ve,
with the occasional foray into other areas such as file formats [7]. Though
there were some skeptics, the takeaway from IETF 115 was ultimately that the
IETF was eager to be the standardizing body (thanks to strong encouragement
=66rom the then-IETF Chair Lars Eggert), and that we would figure out how t=
o make
it work as we went along.

[6]: https://lore.kernel.org/all/DM4PR21MB3440837AE8F54F8E6EA5D475A3119@DM4=
PR21MB3440.namprd21.prod.outlook.com/
[7]: https://www.rfc-editor.org/info/rfc9116

Fast forward to IETF 116 [8] in Yokohama. After more deliberation and commu=
nity
input, the decision was made to form the BPF working group [9]. The working
group was categorized as part of the Internet Area under the leadership of =
Erik
Kline as our Area Director, and with myself and Suresh Krishnan serving as
co-chairs.

At this point there were still some key unanswered questions, such as how t=
he
Linux kernel community and the IETF would work together given the vastly
different workflow patterns followed by each organization, and how we would
reconcile document licensing and copyright. Though it took some patience and
persistence, these issues were all ultimately addressed, and the group char=
ter
was published with a list of documents that were in scope for our roadmap. =
At
the head of this roadmap was the ISA document:

	[PS] the BPF instruction set architecture (ISA) that defines the
	instructions and low-level virtual machine for BPF programs,

[8]: https://datatracker.ietf.org/meeting/116/session/bpf
[9]: https://datatracker.ietf.org/group/bpf/about/

=46rom that point, it was a matter of iterating on and completing the ISA
document. A large part of this effort was resolving technical consideration=
s,
such as proposed semantics [10] for new instructions such as indirect calls
(CALLX). Others topics were procedural questions, such as what the process
should be for adding new instructions, deprecating old instructions, how to
aggregate instructions into conformance groups [11], etc. Though it sometim=
es
required a lot of discussion and time to resolve a topic, we always managed=
 to
reach consensus. Likely worth noting as well is that discussions often span=
ned
both the mailing list, as well as in person (or virtual) discussions at IETF
conferences.

Eventually, the number of open topics and discussions in the working group =
was
whittled down to zero, and we moved the document to Working Group Last Call=
 in
early March of this year (2024). After a few more steps in the IETF document
lifecycle [12], such as moving to IESG evaluation, getting approval from the
IESG, and then finally having RFC editors review and approve the document, =
our
efforts were rewarded when the document was officially ratified as RFC 9669=
 on
10/31/2024.

[10]: https://lore.kernel.org/bpf/20240213175141.10347-1-dthaler1968@gmail.=
com/
[11]: https://lore.kernel.org/bpf/072101da2558$fe5f5020$fb1df060$@gmail.com/
[12]: https://chairs.ietf.org/documents/lifecycle

What's next?
------------

Getting the ISA document ratified as a Proposed Standard is a significant
milestone. The primary value proposition of the standardization effort was =
to
incentivize vendors to build BPF offload by de-risking their investment. Now
that we have an official Proposed Standard that's been ratified, the plan i=
s to
take a step back and see how the industry responds. If we observe that vend=
ors
have taken notice and either begin investing in BPF offload, or join the IE=
TF
discussions to talk about what other standards they would need, we can plan=
 to
ramp back up on our time investments, start attending IETF conferences agai=
n,
etc. Until then, the plan is to try and minimize the overhead of IETF
processes, while still optimizing for iterating on documents, and meeting in
person as a working group on an ad-hoc basis, when required.

To stress: "minimize" does not mean "cease functioning". Work is continuing=
 in
the background on other documents such as the psABI document, and patches a=
nd
participation in the WG are both accepted, and encouraged.

I want to give a big thank you to everyone who has participated in the BPF =
IETF
working group so far, and helped us to achieve this milestone. There are too
many individuals who helped to enumerate everyone, but I do want to thank D=
ave
Thaler in particular for being the primary author of the document, and for
putting in so much work to drive the document to completion over the last ~=
1.5
years.

Congratulations, everyone, and thank you again for being a part of this.

-----------------------------------------
David Vernet - BPF Working Group Co-Chair

--crKlIWAqZI0Tf5Lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZymWJQAKCRBZ5LhpZcTz
ZIhvAQC8VHqwPN4z7rQNjb0wCPtui/4Vm1k8T6k72yDa3iapyQD9EbMbuUOkvose
MHoE7qruWJDV2cRpfc6uMxy9vJznig4=
=VQKx
-----END PGP SIGNATURE-----

--crKlIWAqZI0Tf5Lg--

