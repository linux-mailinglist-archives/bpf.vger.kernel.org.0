Return-Path: <bpf+bounces-18997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE94823AA3
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325CB1C24366
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A191FB3;
	Thu,  4 Jan 2024 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ1IIZ3D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1101FB4
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d88f9e602so524795e9.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 18:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335207; x=1704940007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W44s0DmqIRqZ74NeFJpp2ccCD63wf6vq4diO8GK1gN4=;
        b=mQ1IIZ3Ds3Nca6CIvVVZl9uTzdeBFbLwZt1Wee6Y98y1o2xAj0eKeflUpEnH6vNYif
         8Wt1lUx4U2vOY63lR67VJ1fSNtMssqpXYNTsmc76x+WgtI5+vgwtQccRc/vIAlaN7uBX
         8yyVz0k2Jj/87I9Onok9Muwsk3NFSaEcLqkB9gO+i/nN1Io1RFnaWuGSTZ7sXeTmT1m3
         WeKDw92VjgFnnq2GKZ+veC/xvx6lffdQCOSAyf+ETOWCASeCuMcv5Kr66DVBoqzBliFW
         7QDHTZ4jmnonpPA/Lxclc+2Mx+66sI4dcILyBeExcK7Hq+FgRqEXxzogttH9ZM37XAvG
         qKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335207; x=1704940007;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W44s0DmqIRqZ74NeFJpp2ccCD63wf6vq4diO8GK1gN4=;
        b=pY7veR5Fw6icS5I8p/K2xbSv2PQ56w54Ir8haLYipINqcW9arGfBRDjaaVP1aAa1pb
         9T9v6eBtMtzVqeJP6/kq6JIUKcf2+SMqbKiZ5zySyVyl+jyYkaV/SInohPTkebhL3v9s
         gh13KmHoagTDOI/Zc7AOZbbOh7UoTZqjrwE8Mu1koW+aXIcShN9zFmLSVxh3qhWmArcv
         1Nxu2CZFfrp5JQTASzrHOrNY0BkoPsfSNqzgOWh6RniKPsoX6L0NxnXHwhKBYvnFqkdR
         MfArvRmUYJTdq45ZNacyJH89olACkhYn+t64pNeFgZrtjJWafnVxhk8yK2zg48Btmsm9
         +6vw==
X-Gm-Message-State: AOJu0Yzmxd8fkFCEYw2d3ybZHFFPiMTrkjlFuqtw+S2dGw5E7iXx5v/j
	afsp0Z3kfhB8he7TyVUQv2cax1BQKliL/A==
X-Google-Smtp-Source: AGHT+IEXNWueWos4hKFAAQ52aqJ9kl4t5Z9IAOVeMKAyvJHj+ZM2WKBdYCXhos5sOzj2A19gR38BLg==
X-Received: by 2002:a05:600c:5190:b0:40e:fba:487 with SMTP id fa16-20020a05600c519000b0040e0fba0487mr2356wmb.130.1704335206767;
        Wed, 03 Jan 2024 18:26:46 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090657d700b00a28e533acabsm4744ejr.190.2024.01.03.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 18:26:46 -0800 (PST)
Message-ID: <e2e2dd7128063984b7133ca88ca7b563b1f45008.camel@gmail.com>
Subject: Re: [PATCH bpf-next 11/15] selftests/bpf: Test tracking spilled
 unbounded scalars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 04 Jan 2024 04:26:45 +0200
In-Reply-To: <20231220214013.3327288-12-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
	 <20231220214013.3327288-12-maxtram95@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 23:40 +0200, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >=20
> > The previous commit added tracking for unbounded scalars on spill. Add
> > the test case to check the new functionality.
> >=20
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

