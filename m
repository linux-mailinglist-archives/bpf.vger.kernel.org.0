Return-Path: <bpf+bounces-28396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B8F8B90A9
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B271C2172A
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB013049E;
	Wed,  1 May 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2fD7eLF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEE1527B2
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714595795; cv=none; b=G8d74LVskOmilqt6GLiyc2u9as+qXvAUxhk5Wl6xjFSAHDD4sCZfGeM2cbDPxpZvGKvV1p6QZSTU3LRJF9omdHsTKveA83Ba2tH31kkizj87shhZECaHRPM3z+9IDKpJJUlK3kb/I81umpAzuzBhfAmVqglZ0uecoDT1yA0zFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714595795; c=relaxed/simple;
	bh=EFaemyGohPskUeweK54cTLjtsZrk7L8btTndPcl/bPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRuWBVjTz9HBHKJnvng+uTP9ji8w7dMLviNFclHndaC01r3fC+kBrkxr2nK7HMpy+W66U0G1R3NpqYzW+PUnATK+wvL3nd6mddqHokPlpELfK8gf/pTAKuJBb6WyvsAWSDyJgYPhUCc+tm/vyfGcORnd5CB1bzKvXrcaG9k0tYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2fD7eLF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec5387aed9so18305175ad.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714595793; x=1715200593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gRvDBA5jVpVg3M6DSXrsA9+aWK+kDzo1sdFW990u6A4=;
        b=b2fD7eLF5+oBT4kFSlvwq2SZ5Nru35q09WlBOTzxtxGHHYh3KqgssYxOWNaTH4vYom
         unDCIZLDUVkCDYSCA5fKCxfanBSMK2bICfm1/9IrkHCYqhzMDUwfbesjZGyFkF6XVYPx
         csiilJxq4v+mGW4Ly2uwDL2QTOXlMCR9NVvnZ4ioKPVjzGpbHyeoDzLp4CykpxwUc6/Z
         Fvk8Uounw9vEVQLW3au3CmQPJvLmo4kUNDBCBqQ+sbxRMC4HsjQ8EmcujI4jxFpvp2Yg
         im3+C/YDqalNQaDGDzlKfMBmZ7QjpPm1MkoEt0AIly3GkOEyY+NVRCX3RKSPJFUCFsYl
         BPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714595793; x=1715200593;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRvDBA5jVpVg3M6DSXrsA9+aWK+kDzo1sdFW990u6A4=;
        b=anE3cvgEWkMETiuGhiscch6T6iyaPPe2PhjvmZvobYF8lmY1Brq6KAKNchSJ6+TiO7
         kmT9QmRIzp+Z8oCn4bvN0wABRT4YIg8+XdUFgFXqssYSP5F26NNF2TYbxemb66Gw2qgm
         C2mcIeAl09ayPMy2tD8SwpYw6btPe+SqVkQOT0Ue9IUtYvtGwfiMWDT1S3Jr1m8rLnF2
         Z3KkztlieUntqHTdA3igaT5cVSDPa5k7VVrs8lEVAvDpg721IggOfr0e6ILivI8/rmU5
         l6MYXEu7v7tCasSw5CALCHU/LHUBzR8l82DtVXVAUbtKL2eCSgF1mqV1HRY6l9pE0AU0
         uOxw==
X-Forwarded-Encrypted: i=1; AJvYcCUlIhdK32E4J5fcu59DQcYBSN7bhyim5BikrIno3RCoOPY76nYoF2siX77dX7EEIBzGmdCT7zgp1p/QcOq7JA2tG1Jz
X-Gm-Message-State: AOJu0YynDBcCyj9B6KjeWGyZt7F6P4Pck8b1AspSBgcWzQN8bVM+FfJz
	oFtpl4aBfnVsRTab/6AVZuwBJMFKlzSETrQXKNO6nbWQ6sntFQpr
X-Google-Smtp-Source: AGHT+IEI7rwpQK2aO2P8lq/PHpz7zBGiqCy0scUObdJ5x+yA1YceVqR0kEeu9Uo7KpL0zfa+wTHkkg==
X-Received: by 2002:a17:903:41c7:b0:1eb:86d:3ddb with SMTP id u7-20020a17090341c700b001eb086d3ddbmr4564475ple.56.1714595793257;
        Wed, 01 May 2024 13:36:33 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:7cc5:20b9:bcdc:5d52? ([2604:3d08:6979:1160:7cc5:20b9:bcdc:5d52])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b001e26b7ac950sm24456136pls.272.2024.05.01.13.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:36:32 -0700 (PDT)
Message-ID: <205d41a7b13d5a0eded6fb45d18942359efc52cd.camel@gmail.com>
Subject: Re: [PATCH bpf-next] kbuild,bpf: switch to using --btf_features for
 pahole v1.26 and later
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org
Date: Wed, 01 May 2024 13:36:31 -0700
In-Reply-To: <20240501175035.2476830-1-alan.maguire@oracle.com>
References: <20240501175035.2476830-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 18:50 +0100, Alan Maguire wrote:
> The btf_features list can be used for pahole v1.26 and later -
> it is useful because if a feature is not yet implemented it will
> not exit with a failure message.  This will allow us to add feature
> requests to the pahole options without having to check pahole versions
> in future; if the version of pahole supports the feature it will be
> added.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

I tried building kernel and running bpf selftests using this patch and
two pahole versions: tags 1.25 and 1.26 (from git@github.com:acmel/dwarves.=
git).
Selftests are passing (test_{verifier,progs})

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

