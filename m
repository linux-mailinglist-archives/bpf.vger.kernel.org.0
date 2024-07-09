Return-Path: <bpf+bounces-34232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BD92B95A
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AF91C21C84
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840B158A33;
	Tue,  9 Jul 2024 12:25:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40813C687;
	Tue,  9 Jul 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527899; cv=none; b=gHYtNjC/u22JV/wAa5LBra7JfDdwXv5oxtNSAjQJHeB1VsELUPAuJME/sGJ/QU08eYscn/OiJrbIxGjCaPaCOxwBSMD3audSR+Llr0k3yTBGnj5xcaPLxkhf9gX8v9ZlqpnI2hyec/KwptfQ0QRo7Eo224sbJv98mhhaXEIXlbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527899; c=relaxed/simple;
	bh=0BprKiHiOWC22yvJ3wRNAeIBcxMcrBZZnNjbrviQupM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzVHxKw3EWjUAGuQ0JX/u64H5Ohr4sIiKJuSXe04RlthEaQt1O259f8QgL9joSKDF7PeDa4PU/qV+ZTQ7LJcY2+GE2WMOQ+9QQ/2dzrItUHcu7EkV8fagenEs4JbLnOH+HiJQhn1swnJkCTvl+sla5Tfj5cdZeDXbAGNET0LxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f0c08aa45so167812185a.0;
        Tue, 09 Jul 2024 05:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720527897; x=1721132697;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BprKiHiOWC22yvJ3wRNAeIBcxMcrBZZnNjbrviQupM=;
        b=sva3M4qMzzBo8WNVh7qWn/eeTudmk07b6JSfpAlhvDVvcTq+IdPuxb0i5IC+Tj/+Mr
         0/3fDxjlovAukRaGENCLJ2e3pGE2XG2ZtqyRuPGBmYZ49KLvCebaPtjkmTDECeITKgvg
         sjJTZzWH6mWYjfuCkZf7NWF0SM9SU3T6fubED85hy/UvHQ2udRYdB58ecuQqSjZkiX4b
         nzd77VYrkbwXjlc77V/eZIETtoq00lW9yr/uWK98iYMlibZATpIpQfd25s2RFkXe7LuV
         XK0D6sxwupPm3pQwAthanz2apKWAqHUNLKL7JDl1mUYM/C8GhimZmCn8QflH611Gq1dv
         27Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVJTtE/7jxC+yHqMvXbSm9rV5Kh9FDVdUtbsg7QeGOmoB3md4USkQq5ja2EfRdbnFE7wKLbvsRuQNXvtpWtsLRMudU9r+syJvyRrkjO87F+MvzhGmR3JJTAEuJoh0sqKbs8
X-Gm-Message-State: AOJu0YyitNecSoVqi/orZ+E9+wigByJnqvX88njTwMGkZeQuBXfZB+6A
	LRfaJeomiEBobcfpNKN5oicvM6gBJqlu7I63y36AeVdqYRiiFcV/
X-Google-Smtp-Source: AGHT+IF4iZo/ng39n2Gm1San+WSh3mtbiXDnjxac3lRN6m5C0ZhOPX6XbxrfQiqgW4VHL6M8wo8GMQ==
X-Received: by 2002:a05:620a:2093:b0:79e:f8e6:aff with SMTP id af79cd13be357-79f19a64ed7mr243543785a.22.1720527897045;
        Tue, 09 Jul 2024 05:24:57 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190a15f6sm91386685a.104.2024.07.09.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:24:56 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:24:54 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] sched_ext: Take out ->priq and ->flags from
 scx_dsq_node
Message-ID: <20240709122454.GA16568@maniforge>
References: <20240709004041.1111039-1-tj@kernel.org>
 <20240709004041.1111039-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="to9lHaoK6ET5xWOD"
Content-Disposition: inline
In-Reply-To: <20240709004041.1111039-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--to9lHaoK6ET5xWOD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 02:40:22PM -1000, Tejun Heo wrote:
> struct scx_dsq_node contains two data structure nodes to link the contain=
ing
> task to a DSQ and a flags field that is protected by the lock of the
> associated DSQ. One reason why they are grouped into a struct is to use t=
he
> type independently as a cursor node when iterating tasks on a DSQ. Howeve=
r,
> when iterating, the cursor only needs to be linked on the FIFO list and t=
he
> rb_node part ends up inflating the size of the iterator data structure
> unnecessarily making it potentially too expensive to place it on stack.
>=20
> Take ->priq and ->flags out of scx_dsq_node and put them in sched_ext_ent=
ity
> as ->dsq_priq and ->dsq_flags, respectively. scx_dsq_node is renamed to
> scx_dsq_list_node and the field names are renamed accordingly. This will
> help implementing DSQ task iterator that can be allocated on stack.
>=20
> No functional change intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Cc: David Vernet <void@manifault.com>

Reviewed-by: David Vernet <void@manifault.com>

--to9lHaoK6ET5xWOD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo0sFgAKCRBZ5LhpZcTz
ZInPAQCHXEDdTB19SaGIR8E01mQazAHHBxC3efncnS5zXW4UjQEAjOSIVKTSDRFo
E/4Twumza/K39/Bja+9ifI5oSYzvigw=
=rIF1
-----END PGP SIGNATURE-----

--to9lHaoK6ET5xWOD--

