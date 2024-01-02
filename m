Return-Path: <bpf+bounces-18824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B4822561
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC1B22481
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD91773B;
	Tue,  2 Jan 2024 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qz/RcS2u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qz/RcS2u"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9C1772B
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DD175C19ECB5
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704236526; bh=hlto+uNBNfggphdxtvSkJL4q0FuNtYnUIpbKtl9OO0Q=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=qz/RcS2u6I8wnJwuVOcMUoK0g/2AMPhVS4QYJizWY7if4itje6j1M2GhLacHtuz3I
	 ImQkm2fc6Kh64mKUEW6PzkWE50xmGNAK4H0haZlzUd1vj4AbKnk6nccYJu/GFF1PvE
	 9pQ0NiLiuh26/oW8hODUnU9P/tFCfYJIQLvGmjWo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan  2 15:02:06 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8C4FAC18DB8E;
	Tue,  2 Jan 2024 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704236526; bh=hlto+uNBNfggphdxtvSkJL4q0FuNtYnUIpbKtl9OO0Q=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=qz/RcS2u6I8wnJwuVOcMUoK0g/2AMPhVS4QYJizWY7if4itje6j1M2GhLacHtuz3I
	 ImQkm2fc6Kh64mKUEW6PzkWE50xmGNAK4H0haZlzUd1vj4AbKnk6nccYJu/GFF1PvE
	 9pQ0NiLiuh26/oW8hODUnU9P/tFCfYJIQLvGmjWo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C9B63C18DB8E
 for <bpf@ietfa.amsl.com>; Tue,  2 Jan 2024 15:02:05 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.407
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nd11ccBCoD56 for <bpf@ietfa.amsl.com>;
 Tue,  2 Jan 2024 15:02:03 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 793D3C15790F
 for <bpf@ietf.org>; Tue,  2 Jan 2024 15:02:03 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4280e3ab14fso25766731cf.2
 for <bpf@ietf.org>; Tue, 02 Jan 2024 15:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704236522; x=1704841322;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbv7eXA0YkHuMGlCtE5D28uGMMy2CbhyvAx7RZCrbOE=;
 b=Hvd3kqvF6cdsQA/1h9GLd/b8azBe3NA4buDOiVRJsTD3litSArXzIT/Z9DIZdUYHLh
 FuyIhybgquy9yDJ3mqK57CYpC99KhsgehMA9vx6GLJ8SU1qYQKEnyy5DResO/XTWaA8S
 OaG3/hiCoq0K3ZP0L6JbggcFPhxxpOuPSoNFMRAAcXCSFU7gLen2rCWWmOUmI+z/FI7p
 IPriNiL7tkNlz/NiP+lHXnhPVwN7Sgmw1zOrImHCGNnZyYKrKYiIOztObF8Ohi9Wouxp
 0w034rNY4V444LcK4v4SkWzXb69+fHwmfGezD6L/Bce5O/J6joc4vXwhJgOT04nSsoiV
 xTvA==
X-Gm-Message-State: AOJu0YyZdib/KLfISfa3w7X7GalhDGhvSUXR7gWk/7VjG905kWdR0YjE
 iSP4dhrtiHvuFrwxBZFeshI=
X-Google-Smtp-Source: AGHT+IEj6RE0ZKjkwh1OaFIa0MuB0v4rJ0cAW79jNt6zCSvpM0Ffk/5klKq9KgrjRh4/OXMETrdbTw==
X-Received: by 2002:ac8:5d88:0:b0:423:70f4:c28d with SMTP id
 d8-20020ac85d88000000b0042370f4c28dmr27602408qtx.67.1704236522367; 
 Tue, 02 Jan 2024 15:02:02 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 br7-20020a05622a1e0700b00425dac6d04csm13496276qtb.3.2024.01.02.15.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 15:02:01 -0800 (PST)
Date: Tue, 2 Jan 2024 17:01:59 -0600
From: David Vernet <void@manifault.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@googlemail.com,
 alexei.starovoitov@gmail.com, hch@infradead.org
Message-ID: <20240102230159.GA1682@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/4czOgX2cmkMdDMiBrvd5cz-Lm2M>
Subject: [Bpf] [LSF/MM/BPF TOPIC] BPF IETF Standardization
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8474092263061492278=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============8474092263061492278==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2qenCBFtpnrJjjDh"
Content-Disposition: inline


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


--===============8474092263061492278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8474092263061492278==--


