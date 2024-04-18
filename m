Return-Path: <bpf+bounces-27177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F57A8AA4C9
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 23:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B75A1F21B2A
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0FF194C99;
	Thu, 18 Apr 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqqpTSuM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823636D1C7
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476244; cv=none; b=uiu/RBI6wgw+HQtTvoOgeO3/UdcEkOTJmB/45rexO52YREzu8PiEA9vkwV49p8TEIg29e/J9oayVyYHPJ2REw6b83ceB3ty/P1EWF96jkj5xW9Pz/Mh3k8d5uPJA0ut+CLGEFg46KES/vNFMPsBnXbqu47qcObsgWqrwf6qGxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476244; c=relaxed/simple;
	bh=FOfzN7+HqKh+fYRwHjiup/ClGiCG2vt4ZXBuETaodFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOU+tdJp96VU/f/rdjB1bnhDLIsOcXvrG8ZU6mYfYy5agO0pcX6Ieb2xFvBOD8DEkP5XQiNiAl5bc7cnEvINrPEIchUhTMPJ7RjM9KKbO9NNyLPjB6ZqVKPVI7ATUnZYTIlfAy2cDvJZdTXJO1+c0Z4lSZpYIOaLx7npWZ/URZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqqpTSuM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1278476b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713476243; x=1714081043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FOfzN7+HqKh+fYRwHjiup/ClGiCG2vt4ZXBuETaodFc=;
        b=YqqpTSuM2hHBWAOv17dRtT3SXdOsWL9qeW/2ekP3iY6SVZ0cvjrprC4iSLG8Ymt+Lo
         5GFmUHXIvaJbOMlbOPwkn3zX62RRiDaadv6aHLYFURWYFoLXfvmPRfGlLV871mB/H0C6
         k/tF1r/oOMf9zk8d5p+DrqzSx5ZX8Z6e1vTLo5Qn7AF8eK8AnD+Mp0Sm8hkPbnv3Gmx9
         QcnsWJNCPEZZubeDxl2YN44q1B2gOo7AHEQv3KXDw3mDdPdVsVzaW78SdFoAP8b8iuVj
         fJ33KrIdg17Z8N1Gxy/CLlHRpC7KM+aVL/IZVrfDr+nNRMmJlLSGhBTJMvM45T4xrvkY
         0AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713476243; x=1714081043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOfzN7+HqKh+fYRwHjiup/ClGiCG2vt4ZXBuETaodFc=;
        b=clbVIK1m6lEQ34g3s0hptGQCkzmSJ0+B29NNZdIHKMeygpM04FlYeQuzKcuN10jMqh
         CQSAmK7Srs3DlbSFTsz1R2Cx13E04k7v+3pywRrliL8OvGbqPsvMVEiOFwQHmdGz7UFc
         FRR8rXhwjKqp1o5A4NO3epl4o+5nc0fxRAFsQAumvDgUE6z1PIzHh4NQgml/09NRVoth
         TFCOpQ1qPhyC35pQ7RWkGTnDr9+8klqdwYTTna100P7vycUnmVbATugcBPF6CdwoE0je
         dBzqIbO2ohI4Iydk+IhdFkfDhcJ5X4+cKGgNbfWhjyigzKs8W+sK/Jkht8Xwl0e8EK4T
         iuBg==
X-Forwarded-Encrypted: i=1; AJvYcCXtO2CAkeJtJjmHgk5oJ8rIHuLFHGGRfLZkZRLvDnGAtTJkt8iuUS9ttc29NqS88UDBrk8FSH+ZmaPhG4LR4YyU7AuF
X-Gm-Message-State: AOJu0YxAXQbcBBDLrptGMFLPmnk59hOF+G7fRIWGoqyNRqfUVcPKdpth
	P0ZC2mJa71tZCPG92nY8FKZe1jMtYihwsWAIsNAEBeNeQJNNbgvn
X-Google-Smtp-Source: AGHT+IE5J6DVHUcN6wzeOe239ZL76st2OX8guYgWKky9XoT87oHuR6gra1omgZy0p5a70pHas1EH/w==
X-Received: by 2002:a05:6a00:c94:b0:6ed:332:ffbc with SMTP id a20-20020a056a000c9400b006ed0332ffbcmr447224pfv.20.1713476242697;
        Thu, 18 Apr 2024 14:37:22 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:ad05:9ec6:fc65:cf63? ([2604:3d08:9880:5900:ad05:9ec6:fc65:cf63])
        by smtp.gmail.com with ESMTPSA id gj7-20020a056a00840700b006e8f75d3b07sm1950515pfb.181.2024.04.18.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:37:22 -0700 (PDT)
Message-ID: <e504821b4570a9b94c16da88cb6a632a73e4d204.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] Update a struct_ops link through a
 pinned path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 18 Apr 2024 14:37:21 -0700
In-Reply-To: <20240418163509.719335-1-thinker.li@gmail.com>
References: <20240418163509.719335-1-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-18 at 09:35 -0700, Kui-Feng Lee wrote:
> Applications already have the ability to update a struct_ops link with
> another struct_ops map. However, they were unable to open pinned paths
> of the links. This implies that updating a link through its pinned
> paths was not feasible. By allowing the "open" operator on pinned
> paths, applications can pin a struct_ops link and update the link
> through the pinned path later.
>=20
> ---

Not an expert in how bpffs is tied together, but this patch-set seems to be=
 fine.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>


