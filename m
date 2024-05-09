Return-Path: <bpf+bounces-29320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A788C185A
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253781F2260C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8248595F;
	Thu,  9 May 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7GEzkS3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67E770FC
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289961; cv=none; b=K21Q+KLEbG/c5c1Stuhs8UPww9Rf1OXs30TRrWSMJZuT5W5RI/zHn5JzLlonOfyIu0YoHJMqKlPnie+1W72pXpLuU7sxtAkuUwh5C8XuZhIAJfKHbcEtfdFKDr6XzqNL1hIlVkedJAmLd0KPqLM0nwlrA+GQb9lQtCJNFLv2SdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289961; c=relaxed/simple;
	bh=O5hNX5RC2pz1G34D9Ry/Shh8zXqrxcuOUDw6ZowFt7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7PB9dUICFVdE70/+9u7YJBEMeA2d2HoPgeooR+dMDKHu3rY5Q4Hrq5jeuGsqoOBlYLrTkcmbzi4WF6gdAitrfpH6iasWCIIjuQ3dStSpX7c+gxhuyWomccA+2YxDzsK8XgOmOxvEmICSXuPD/yEFl7SmFTOYTzTRIkmtmEoDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7GEzkS3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so11221765ad.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715289960; x=1715894760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5hNX5RC2pz1G34D9Ry/Shh8zXqrxcuOUDw6ZowFt7o=;
        b=d7GEzkS3PYh55XbZGIMDIrgfl6F/bV4sJHRtat9acH5toe2/LqJHibC9jlZUD3rwiv
         LGG8n/2wUOTN0wtX/B2I18+I7nzw+aANvundwsiI+Azp5Q1bFtWjQA5p/PE4Rwt0MSD8
         88/jXTYb9sInIND9SQmFJKlKtpqysSymwvZGy2/Vfc/wSNdZ+OaP7JrtayVgwxi68JHE
         Mx4eZUfju0PkanUB2U9MlxkGa3clkLVOW+xyKqAihDunWDWZ3qNw2BUM7r7VK0Ertpdd
         ZGwhb8hcSSy+rkqagHwyA6sqWGR+nEZapJVBuuuCAHf4zNzDBkgKjPf1YaFhwsNJ2mP1
         GgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289960; x=1715894760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5hNX5RC2pz1G34D9Ry/Shh8zXqrxcuOUDw6ZowFt7o=;
        b=RqLELdN5rxNgifO9qQm7JcdunaelBSydyVd2DGE3DgwEGP8/7LZ8CJzb+XpWPqe8BV
         2Wh6bjkB5aCDXJJJf7+sII3F5CD6FYEcCHp5X8lFQgpUIFW74/7cPj6DOmc26+FCyxA1
         9DWMyBQRkeJfT/84tolYC2p30Ua2YJ7hzE3vf6R8kMpZpyelorKhAaI8wqJTTH0QwwrM
         S0pSdmBfq/ukVHmY+EDaxo5aW/ik6cjBqiqSPrUH/BaSIvw26vNhVsw/mWx9c5Xvs7Tv
         H9Y5o1J6Q+YxpKfZh0hdBdaIklsWzMe1G2JuhR/33HFyT+ovnk9OWg6H3PVcZebSS0Lq
         da0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDwouK3uTnh3cMqFkNkXAIiuH5UAgk2cpbCW4BXdruNuYXwfO9PhXUDZnKMTsq6z4QpIieA5JsH03JcN8P79EL0MtU
X-Gm-Message-State: AOJu0YyTos6nYRMFXjk1lkOBD+LqhM5hQGX0Jre7RkCGXbUAH7HRnYGA
	FFx4aVKLINc+gfJt/OYrtEDxlEG/ih+slX+BuUPGeKWTdjaT13fL
X-Google-Smtp-Source: AGHT+IHsS2553Zz3vkT4EO9TBfYK+GGCI8Ktw0LrTaM4Erb76A2P3Si9PGJBZaVk8Oui8HWJR2S/AA==
X-Received: by 2002:a17:902:654f:b0:1ec:4adc:4154 with SMTP id d9443c01a7336-1ef43e284camr7869135ad.23.1715289959942;
        Thu, 09 May 2024 14:25:59 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03aadbsm18712475ad.227.2024.05.09.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:25:59 -0700 (PDT)
Message-ID: <89f5a2c2750b2d2378a281c3ab193ceddfe19a14.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/9] bpf: refactor btf_find_struct_field()
 and btf_find_datasec_var().
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 09 May 2024 14:25:58 -0700
In-Reply-To: <20240508063218.2806447-4-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
	 <20240508063218.2806447-4-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 23:32 -0700, Kui-Feng Lee wrote:
> Move common code of the two functions to btf_find_field_one().
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Thank you for adding this refactoring.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


