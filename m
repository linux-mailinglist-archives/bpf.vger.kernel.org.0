Return-Path: <bpf+bounces-60539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 915CAAD7E85
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8955917B01F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792E02E172B;
	Thu, 12 Jun 2025 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPWCwbPL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22F2E0B75
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767870; cv=none; b=cPuvCTTSEKB1cigyRvKkqno5IaSo5VXykikhRsaaGYl8SKDCk748oHS4cvMQGCTuj7VFBPoAsxf3SWjYSL5Ah5maXCC6sAxVNe6GB4Tz2gxHOpDeRyIw88o2tIbbU+xpUFawNjn4kubv5IKvR+n9IW2TF/YWnH0QQKbDgA7XHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767870; c=relaxed/simple;
	bh=3a7nPZlsPGWRHfAftXsX31zw7DDHkQEQDQD5eHzBAPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbHm6qYZFB9kE+TJ28WEJo9bh5O+oNeYikwkAN3eKlqxnxv4FhVo0kn1nHzeGHge/Q3duECjYw1Ue+Ua5Zx7PZyOJyTbWNMSgH2jA3VLJThf5qTYEtZDDVaNCuasYlg6e01CmPsbKDX8VAg50D6ZdElUe2SwWyDPKc1Ld3URSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPWCwbPL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31393526d0dso1140501a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749767868; x=1750372668; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V2wHpc1TaOEqAK8AlHoW9toI8e+Dijn4cDsCR+hxs74=;
        b=fPWCwbPL84ZK9gv2qMET4zYfA9C4cbrqNrdBRJwQaTjvQWBZV/72l9v6r9q63SPgKN
         eJgfGau3XcQsrGZ031oiK/VcX1pbVDyxdRXGvWl3SolgcNnkRLMfDJMsZY+h2UjI+Zqi
         CUtYXpcv/1fwIczusUuduo8xcufnT8swOfu+FQMHEpWbZgqDM9NAMLNN7UfIfWHhYoLa
         AVkTRWIavyiduJS8v9nAr8lwV99V32Q+EU6p5dxrfUzklft2dfuud0f7hCwfxU/PACE0
         SmTHupM1SkdWebOwELBWpqfzrubnNUFM5oEREE3zJ8QGje8SaAoQv9SlGPg9sJdZzKkV
         Ui4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749767868; x=1750372668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2wHpc1TaOEqAK8AlHoW9toI8e+Dijn4cDsCR+hxs74=;
        b=dQq0weZc9GjfP6Pc9IBZRDKEF1Pv1uZbKBURHs2VG3ySTddGJBMGHI+WZ0+E+LnjRp
         K+gyEdLGowqooVRn20ZxEOmGH5WQX7M7KrZg8JljW+cjvwGdEicSBjHCKirGdYvJPW6Y
         izF4brKvfqJYtI2gERimEQnBeeTRtb3smnihYYTiqoIqafOGZle2vJ+FbN391tJCDWRn
         9Bt0tOOxrnRDz0cwgSu8vJ7OUNjpwc34qpRMa7q0yETIQLb5NGXX96aD0CfluyYWeXtG
         8WTeiNPLWKwJ4D7WYkbrRdFvb+4T48HZlgjCHVITyDKjECp+i+WTvgFDEiLINyGMCpNT
         N9hw==
X-Forwarded-Encrypted: i=1; AJvYcCWP8OvMQbC+C8iPHh2GZIWjrTqvhaptuaMl8AhIlxwliV4vtjseVU/c6p7Gwfd81Wzee8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1+j5Wj6yqUVV//KU3I5GN0/BEaux8jK/pZeu9bUUgy6bNx6T
	eHeXoGkj5t+g3B9ScKq7XnT/1ZVKWJoff/sQGQyw9a6T9c0GyoRduVE5
X-Gm-Gg: ASbGncuWQbFMuH9gx7zd1t3dic6TaZ1xAsjy0FCDvJ38RT37vMP51ZMf+K0lCrUxAGa
	yPnOS0e3nNGK8/tnrmrh5rnE5jkyBCQXaN6jmpDMkCezowb1v37gsS5UI3xHQ7L8yleCDth0sk3
	JWNfLAhPiK5bmxE/mlI9SD+wieQfdGYF4sPNAHCEv5H6BAuefCTFG/rSUnkKZbFizVcoQgFBEoB
	y20eX0n76GWp4UcjZIqFaJwes9fDyajALrjA+3SGu1Li2caSDKDL0Cbth2cWFWBxe/roYn32t5M
	lgqWCImcEgwjSfqbdSOCW7OmVb24TnadGs1jgYrUaNH+ICFdshSpIWOM3RiZV/n+rn5HlA==
X-Google-Smtp-Source: AGHT+IHg4HVQPtXqUPZrvfbrivXQJXse9xAPi7ibWV0+2GKjP/rx+1ds6Z/TnZKIHWFIsHCc1IfFLg==
X-Received: by 2002:a17:90b:264e:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-313d9e93c27mr1204256a91.19.1749767867818;
        Thu, 12 Jun 2025 15:37:47 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78314sm2335865ad.91.2025.06.12.15.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 15:37:47 -0700 (PDT)
Message-ID: <b1b7fa02e26569220612961fceaa53c8050a82bc.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Initialize "tmp" in propagate_liveness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Thu, 12 Jun 2025 15:37:44 -0700
In-Reply-To: <52242417d9fd90cc13c0bbe009adde93384a4748.camel@gmail.com>
References: <20250612221100.2153401-1-song@kernel.org>
	 <52242417d9fd90cc13c0bbe009adde93384a4748.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 15:31 -0700, Eduard Zingerman wrote:
> On Thu, 2025-06-12 at 15:11 -0700, Song Liu wrote:
> > With input changed =3D=3D NULL, a local variable is used for "changed".
> > Initialize tmp properly, so that it can be used in the following:
> >    *changed |=3D err > 0;
> >=20
> > Otherwise, UBSAN will complain:
> >=20
> > UBSAN: invalid-load in kernel/bpf/verifier.c:18924:4
> > load of value <some random value> is not a valid value for type '_Bool'
> >=20
> > Fixes: 6b3f95cd99f8 ("bpf: set 'changed' status if propagate_liveness()=
 did any updates")
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
>=20
> Should add UBSAN to my config, sorry.
> There is also a `tmp` in __mark_chain_precision, unitialized as well.
> Could you please re-send v2 with both fixed?

Nevermind, in __mark_chain_precision it is only written to.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

