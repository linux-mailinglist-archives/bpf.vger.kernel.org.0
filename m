Return-Path: <bpf+bounces-27588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AE8AF7CF
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 22:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E1B280299
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C23142633;
	Tue, 23 Apr 2024 20:12:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E91422D6
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903123; cv=none; b=Su9oa4io5ww4A1VnF6MxaRUoyfq4eg2A2IXrjGCNXRgo60yb0czTaNONiDPK6UlwMmzRz4q+eS3Q3GLX2BQAoNWdy/+sThnB1L0D9DzO+CYIby0KMXITbOiRVwYuWliDRJcq6Fu7FAshKxCRz/SvEFllO+JnusSAuZbmAMUCfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903123; c=relaxed/simple;
	bh=CL9H7qrBkSHa0SKx4USGzg6hw0l8s8AaYHcKL8Y6U48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhyZb9rL3feevUY0pTKe3ZDKDYS1nsDjxeCwNPYhkKwHgNhq5isVfkZwosET+fu64ldmYU3I3x4PGz12g0gahXb32bVfQCl77K/DnK7iahICnM4vjtnyJoo3Ch8EH0+Nx+vssDXJQqTXqLv3kfdrBXJA+7txtGC4iVB8/cTXgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7dad81110cfso81619239f.1
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 13:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903120; x=1714507920;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3aP+FmqqZb2PiRqw+THTIveevSLD0UDyr8x8U+Bw7Y=;
        b=WwDD+6IohR1TAHSZn7/gnPhu29+nI366A7K/kH8qZV/j6A5APMUM2nKIyveSDq0Ipw
         p2SSqIRK1HW9EnAo86wnW1kK0NAH4HZZpEKI8TLVPiCGjKjDKaMyBB2ROR4reey2Ozn5
         Pqh+ghF5tj8/DvYJ0gQgtTTzqGwvL7cpzhJnwJMpojFCRhopJnoyr14wOqZ2RUBILRqI
         ak5V1FhkYddrif9QW5O0qgGJkquydkPD+k9a8CxyyHjh/fqjvxkxjO4NJXi5sTUIYsS2
         +pMBxxhgt0PWbIh0Lfl5HSwhomYD253ISzaOBSthMRt/hJig81vWA9LdT+ovw43fLn1S
         YZww==
X-Gm-Message-State: AOJu0Yy3wf9G/5A/XQQOuSZkSOHZIhnaMuqiVFfRpymopGKIHI9ehyfU
	Di3pv5th8qk82Cr6iNNUrE5wfKv1cZxNpEnlkvUElODY2+J6ZgCl
X-Google-Smtp-Source: AGHT+IGv8DSprWITp8lNkzx0B1M0+oFfF8OoIHbda3A/PXH39lq70Gi4rGRRpzV1CiwpOTvlNZbcZg==
X-Received: by 2002:a05:6602:2568:b0:7da:b30e:df6e with SMTP id dj8-20020a056602256800b007dab30edf6emr659741iob.0.1713903120482;
        Tue, 23 Apr 2024 13:12:00 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id lb2-20020a056638950200b00486cc2a8c36sm381565jab.44.2024.04.23.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:12:00 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:11:57 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Add introduction for use in
 the ISA Internet Draft
Message-ID: <20240423201157.GA89570@maniforge>
References: <20240422190942.24658-1-dthaler1968@gmail.com>
 <20240422193847.GB18561@maniforge>
 <15c701da94f2$30a7c9f0$91f75dd0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VJ5kLZQ0n0fSb94c"
Content-Disposition: inline
In-Reply-To: <15c701da94f2$30a7c9f0$91f75dd0$@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--VJ5kLZQ0n0fSb94c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 01:18:05PM -0700, dthaler1968@googlemail.com wrote:
> David Vernet <void@manifault.com> writes:=20
> > On Mon, Apr 22, 2024 at 12:09:42PM -0700, Dave Thaler wrote:
> > > The proposed intro paragraph text is derived from the first paragraph
> > > of the IETF BPF WG charter at
> > > https://datatracker.ietf.org/wg/bpf/about/
> > >
> > > Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> > > ---
> > >  Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > > b/Documentation/bpf/standardization/instruction-set.rst
> > > index d03d90afb..b44bdacd0 100644
> > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > @@ -5,7 +5,11 @@
> > >  BPF Instruction Set Architecture (ISA)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > -This document specifies the BPF instruction set architecture (ISA).
> > > +eBPF (which is no longer an acronym for anything), also commonly
> > > +referred to as BPF, is a technology with origins in the Linux kernel
> > > +that can run untrusted programs in a privileged context such as an
> >=20
> > Perhaps this should be phrased as:
> >=20
> > ...that can run untrusted programs in privileged contexts such as the
> > operating system kernel.
> >=20
> > Not sure if that's actually a grammar correction but it sounds more
> > correct in my head. Wdyt?
>=20
> That sounds less grammatically correct to my reading, since "contexts"
> would be plural but "kernel" is singular.   The intent of the original
> sentence was that multiple programs (plural) can run in the same
> privileged context (singular) such as a kernel (singular).

Fair enough. My ack above stands.

Thanks,
David

--VJ5kLZQ0n0fSb94c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZigWDQAKCRBZ5LhpZcTz
ZNFyAP94Y3m+iIzWFNWz60YlG+5VsSoQm4uRiXnLDYb0qcXksgD/ZKb27CycgiDx
/B1aSLzZdhhhjl44n4/UfWgIwzBXCQE=
=8+UF
-----END PGP SIGNATURE-----

--VJ5kLZQ0n0fSb94c--

