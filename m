Return-Path: <bpf+bounces-18822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54E822556
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05C41F2305B
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC21772B;
	Tue,  2 Jan 2024 23:02:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017417984
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42832d5ac39so3758221cf.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 15:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704236522; x=1704841322;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbv7eXA0YkHuMGlCtE5D28uGMMy2CbhyvAx7RZCrbOE=;
        b=t2H18VkD08iJETE9CkG1VjK74zLYIgBJprrSJ7tK0q9BUCzy4YtetQMRk+FsIIjYga
         OhVPyHsUeP6I2K6e/D/kp7weivmGTT643NbRRtI8GRCGhCHn/2GbS4PxEGcOC8okZvwN
         VeaFWxm7BeRgaUThL6oyX9FQKrwj2Ag5rG7VBf8/q1GiO0xPkAyNXSRU8TZBOSovac1D
         /slQoSCYpn+F630w0RtFxoDr4fHy8wksnAu+NR/er0XgWvjwkO+HJImGmpxacD5iaszo
         nP/MZKsgdBstg0805xQBwDq8dfIFW0ls5mfBcVZmD93FzZZMx/AGWpEPzc4lHZEK7mE1
         DBLQ==
X-Gm-Message-State: AOJu0Yz9+xLaEiOfY4ZkUGZmr6iCbQTnGsXvQVlNc7UgB/9FwweENfEv
	nTsSrhJsPUFPbpDdi9jHjBY=
X-Google-Smtp-Source: AGHT+IEj6RE0ZKjkwh1OaFIa0MuB0v4rJ0cAW79jNt6zCSvpM0Ffk/5klKq9KgrjRh4/OXMETrdbTw==
X-Received: by 2002:ac8:5d88:0:b0:423:70f4:c28d with SMTP id d8-20020ac85d88000000b0042370f4c28dmr27602408qtx.67.1704236522367;
        Tue, 02 Jan 2024 15:02:02 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id br7-20020a05622a1e0700b00425dac6d04csm13496276qtb.3.2024.01.02.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 15:02:01 -0800 (PST)
Date: Tue, 2 Jan 2024 17:01:59 -0600
From: David Vernet <void@manifault.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@googlemail.com,
	alexei.starovoitov@gmail.com, hch@infradead.org
Subject: [LSF/MM/BPF TOPIC] BPF IETF Standardization
Message-ID: <20240102230159.GA1682@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2qenCBFtpnrJjjDh"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)


--2qenCBFtpnrJjjDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I would like to give an update on the latest regarding the BPF IETF
standardization efforts, and to discuss what I believe will be the long
term standardization roadmap. We're making good headway on standardizing
the BPF ISA, but there's a lot more that we'll eventually need to
formalize and standardize in the BPF ecosystem, and I think it would be
beneficial to discuss and hear folks' perspective on things.

Thanks,
David

--2qenCBFtpnrJjjDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZSV5wAKCRBZ5LhpZcTz
ZAIfAQCdrs3LYC5zbs2o0e4BfkiCZm/FpGD8oCsDNUMGmORfhgD/QnJjx74OC8XU
2wTibuAn/5dLmQsP8KFWplhD/gd36gw=
=hEHY
-----END PGP SIGNATURE-----

--2qenCBFtpnrJjjDh--

