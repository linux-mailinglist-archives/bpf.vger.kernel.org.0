Return-Path: <bpf+bounces-21432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F384D37B
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509AB1C247E7
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E378127B65;
	Wed,  7 Feb 2024 21:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362B12838E
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340145; cv=none; b=T2XENVb3wxfiudd2TpVMrRvEtTLOVIruvA0Koyprg2RBeYlvK3qtWS7vC4aNQD9mlXKlj6dE1r7fiRAEbVDx+EjUZwtLu6F6N7r1oK4LmHUuqwvlJDfFmTEUhWRMmv8Zp3RrU3YFKmqzGnhv6Aknj3UdF62RkNZCn5/oXiKIcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340145; c=relaxed/simple;
	bh=vLGf9XjL3DdNWjhnzmGmZ29RinAxja/8JX39P5DiD/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iEmhx0mG21mnNc+zMYcYcEdhTRjjXaJW6nH8FGIxOdWLhf02Ye0W0BLZpsAaGd50dcREZ/lesvcoKMmpZqm9TV4PB/BpyQbAfNBJWRO4/Z4WZrGQWDUdG7O9T7pn+ZdV3+kdH4QMH5Pa7MwIWKaO9kcmAkq2b6x0Y2pthMsipqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb9b28acb4so839321b6e.2
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 13:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340143; x=1707944943;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLGf9XjL3DdNWjhnzmGmZ29RinAxja/8JX39P5DiD/8=;
        b=E2wSQTXnJu+wtKO3EofVNkHJLN2ZEhsIwA3u9IVBkLtYvL1Fhe+wsIXW5+g2a5oEXK
         FUpYf7Nc1wTY+sAdqivYKSt8Sp5DRxerG5RZlhd9Bu9YB87sEEkgNR9mFrn7UzO5cPie
         knhDr2BfUiaoLWG7mfccBDycWtnfy1YhMDD0rItv9KgDULwPlQNb4M1vL8R5l9bIL/iX
         EGgKQBOy6f9Glm1t+w9fhTezwe6oQYOEI7bhkmWYncLXpMEdJLOyVIH3nwW2j2F8UITT
         eAi+ntYZBe1p/b11tUTadcp6ItZx40qi6BRnIikEM5FsIbKzgqHFawQygEpQjC3xoDgC
         NC6A==
X-Gm-Message-State: AOJu0Ywmo8xAiVslRAPlfvuHcFgVvY6guMLpNnnAjJggv/CktYoHqeIH
	ynfx3jQVatmE97Px7QxFQGv46r6dErDBpxqdL+Y4Btll56ZqIXQm
X-Google-Smtp-Source: AGHT+IFbC0/Hlrl9UFG7hPOi7T/gc6pfIgAr+Nf2yo07xw2KUILAvOM+t7WmmjDSb3rKPKlWJLN4wA==
X-Received: by 2002:a05:6808:1688:b0:3bd:a8a3:7237 with SMTP id bb8-20020a056808168800b003bda8a37237mr7278689oib.10.1707340143044;
        Wed, 07 Feb 2024 13:09:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUjsbKcHTXvcGBt7mgPOoa02M7g44L/Hqgm/ZMRFbYaCesJCdsoPlY9H/yySKS6JTpLlQuY5xRAGlE/TYoXgV9p7DMD4c59Gdtxt4U9L1N6PtYntofb2mZ9OH5KA==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id v19-20020ac87493000000b0042c218eff34sm855634qtq.70.2024.02.07.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:09:02 -0800 (PST)
Date: Wed, 7 Feb 2024 15:09:00 -0600
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, Erik Kline <ek.ietf@gmail.com>,
	Suresh Krishnan <suresh.krishnan@gmail.com>
Subject: IETF 119 Call for Agenda Items
Message-ID: <20240207210900.GA2087153@maniforge.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NY07BRAt1nW1FVXY"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)


--NY07BRAt1nW1FVXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

The BPF working group will be holding a meeting at IETF 119 in a two hour time
slot. The chairs are in the process of setting the agenda. We would like to
solicit agenda items that would be of interest to the WG participants with a
preference to the items that address the topics of interest covered by the
charter. Please send us your request(s) for slots to bpf-chairs@ietf.org,
detailing:

* Topic and presenter info
* Name of associated draft (if any)
* Requested slot duration

Thanks
Suresh and David

--NY07BRAt1nW1FVXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcPxbAAKCRBZ5LhpZcTz
ZDiOAQCWNirpw2d3pmQXmK5GnVEz44TCU2RP+h+xzCbhWA4rdwEA9opTFl975Tzf
YbS5nvBxV1KbGs6IaGF0+grD5G/7oA0=
=0Pb1
-----END PGP SIGNATURE-----

--NY07BRAt1nW1FVXY--

