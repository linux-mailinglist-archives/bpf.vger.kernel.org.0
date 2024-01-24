Return-Path: <bpf+bounces-20244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C97C83AF6A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EC11F2284A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35787E78A;
	Wed, 24 Jan 2024 17:15:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50DB7E77D
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116538; cv=none; b=qdUyNE8yCL/fTT/E0tpTvi7XnOiRD/nUTrasPsxMEtpiDyDY+Rg/CdLDkvUVD9ZNloB1uvm7APCBexRwYLjjfAUZy2CfzzYjxBwamVzpXGILf7Fu2s1k3D8OhxwF2O6nqLhHUuy5JDdWL4NTWEwVQ9/Pm7NAoq/zAGvxycSU1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116538; c=relaxed/simple;
	bh=KUer2mF9B+KGTa4c3UMvtWn4PQw3AE/VZPkuZGRjgY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzB4bAXhjYiC133QUEFCEEW1glbqeh3tXy+UNgU7IDBD3oKyyyF8xaoLIxf9/CNx4lf+AiqiWkAKYZ5RVhIzE+zlVWE3u4cO2dqbaHa0+wos+WAHfPVTBiQYbDbRcknMRC58t9kBu5v3PjxDc8NnKpXIiaoOk2YfsaR5/COFHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4298d7952d9so39696761cf.2
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 09:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116536; x=1706721336;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUer2mF9B+KGTa4c3UMvtWn4PQw3AE/VZPkuZGRjgY8=;
        b=sSFccPi6atEajSflz88kuZXAwjLX36jk4GmZT6X7xFe1xt9qxXII2YQ90fhGfJRu3G
         J8jq8LzhtlhhiO1NYM0IgzD2LwzKfYw4Qb3js+R66o0WVlt7wbgUjjtygJcHp8UDjN9O
         kJeRkuviee9oX/zcec9AzfLm75HpFPQooNGD5x8RYPKKNlX6yBPTqVCYXpT/vZIH+ApA
         96tS+htAosNVu379S/TvnG0ejW9lOp/0waC2j93cVt629vKWJytN7VNijPk+dZz1R/fp
         EyMpio7c5ROoKQpu8mGeoKY0pED8pWjuuET4ZjiJ1F5ZK8SDNlD0piFrex+nouOf5KiZ
         x/Pw==
X-Gm-Message-State: AOJu0YzIiOUHEf8xUKzJg4FO9WLUziqZUucmQl26YvhI5H56YzTbWrR9
	dbjrnrSQcnYm5EayR3c8DGSUXucsJpQSRKmQlka1Ny1P4AQ0hJDk
X-Google-Smtp-Source: AGHT+IFmCrM8s/kA/BllsDOv/eLqOoT6vnUhVd4GQ0AbxvrIInkVHcwR+iQbn4ubgohHg4wNMm96cw==
X-Received: by 2002:ac8:5987:0:b0:42a:2f19:b0f0 with SMTP id e7-20020ac85987000000b0042a2f19b0f0mr3148436qte.11.1706116535725;
        Wed, 24 Jan 2024 09:15:35 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d13-20020ac8534d000000b00429bc01acc5sm4490445qto.68.2024.01.24.09.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:15:35 -0800 (PST)
Date: Wed, 24 Jan 2024 11:15:32 -0600
From: David Vernet <void@manifault.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	Sean Christopherson <seanjc@google.com>,
	Vineeth Pillai <vineethrp@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing KVM vCPU Priority boosting via
 BPF
Message-ID: <20240124171532.GB253330@maniforge>
References: <653c2448-614e-48d6-af31-c5920d688f3e@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVw72lHJuzBnWXgd"
Content-Disposition: inline
In-Reply-To: <653c2448-614e-48d6-af31-c5920d688f3e@joelfernandes.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--iVw72lHJuzBnWXgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 09:59:50PM -0500, Joel Fernandes wrote:
> We should discuss a new approach for increasing KVM virtual CPU (vCPU) pr=
iority
> when guests need low latency. The last RFC posting [1] on this is thought=
 to be
> too rigid and baking too much policy into the kernel. Incorporating compl=
ex
> policy logic directly into KVM seems problematic long-term for maintenanc=
e. Lets
> discuss leveraging BPF programs to offload more scheduling policy decisio=
ns to
> BPF / userspace.
>=20
> Specific issues to discuss:
>=20
> * Add support for enabling BPF programs to share memory and interface wit=
h guest.
>=20
> * Create a kernel function allowing BPF programs to call sched_setschedul=
er(),
> facilitating priority boosting.
>=20
> * UAPI concerns.
>=20
> * Challenges with loading BPF programs in guest userspace we don't contro=
l.
>=20
> [1] https://lore.kernel.org/all/20231214024727.3503870-1-vineeth@bitbytew=
ord.org/

+1 to discussing all of the above at LSFMM, ideally as part of the BPF
track.

--iVw72lHJuzBnWXgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbFFtAAKCRBZ5LhpZcTz
ZNQrAQCVm9P/M2rC7rEK15ADkaBylmfJhtDVSBtXETyRsr4gtgEAt+RdoBZ5uexP
y5fCGBIC30MoNBoMAFDNjEvHtorymwg=
=WZqK
-----END PGP SIGNATURE-----

--iVw72lHJuzBnWXgd--

