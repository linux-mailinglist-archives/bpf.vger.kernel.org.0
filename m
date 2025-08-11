Return-Path: <bpf+bounces-65367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C1BB2132C
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB611A219BD
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51152D3EC7;
	Mon, 11 Aug 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBOQs3UF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D121F3FF8;
	Mon, 11 Aug 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933385; cv=none; b=har6e66LQBdhHtsJW+2cY2tu39oBkg0GHC0HWSlEVN7DBamZhsSRWSjkSfLGbe4QoyNz8lGM8SG2qoSHf/b/3wwCqNfmDgkmqEfZrnfmyIxlAesoIgCkqNGVdjBJb1CEnwj5fZa19jeCUoSa450yRImwkp+E69/XUxlH/OMJzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933385; c=relaxed/simple;
	bh=/2ShzW/WUuLy/OiwRAPyuou+grVkG/G7LG9IZQ96NwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2EEJKMbsvT+UrSuNXOiXVWwSFiFCkSK4h5/fv5D+hL7QX3aLzZS6ey0ep4uV3EAsOvk1p7X/5r7gGH5y6HapvsKDr9a3zd8GPQjUJvb8lS8WvoWmoA7sTlqIBxXqWvogqqdmUERdIDw4sjl6akfQM6bIIDeiuZAah7WHIZxD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBOQs3UF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4209a0d426so4624026a12.1;
        Mon, 11 Aug 2025 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754933383; x=1755538183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2ShzW/WUuLy/OiwRAPyuou+grVkG/G7LG9IZQ96NwE=;
        b=hBOQs3UFafU4zeWYoH0xwtAmlvTUws1os8fgmwQ1IjralEZukIB8oY2+NqJQml/40x
         OAl2lOcR0HSVp2GUS9J2bqC8l5g0ACCZvEGNzLhxXKXw6evjHZ1Vdn9Te7cmtfTxtpE3
         OkGL8rRyF7OiVGYxckApKoVit77+lYAHl5/ingQ0+fX/4jmZUrR5B1E1uaMCAlVDzk5m
         qyOPGOe+hQ6txQQjk4zIWXVV3cPr1kbFTHrzDc0qtUdZ7IBbwcxJIXbPZut6rf5ODR4l
         dMBmLU+b75eAkR90KWrLsV31JEttrDfJwmJlypXHOVNItLKb+uPJ4QaA7pNAckVGb9Ia
         3uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933383; x=1755538183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2ShzW/WUuLy/OiwRAPyuou+grVkG/G7LG9IZQ96NwE=;
        b=Pf22I9Ipzj/XXe0rU4Mznt44ZtzIngQWS2i/Al0q6n1FJTsRLD87QBvVOyOGro9cYJ
         6sRkZP6ltas3/1IZOQx0Z7/bPOBvZNoU/i8CZBp/PlQoec/RzY5YibzIAgCrZbZRWjKb
         EWkCqK8CNo0wqfxkI1QZBbhaTpwobblRs7JqGVqyzU5TLO7ZCOi/GXyuseAfn3vrz6Me
         6eoZ+GZ1PYf/H7o39vBzZQHaRquYm3A6KYr9zJzHJ7lsWFAr7dAuEdUhNbtvV+WcirWN
         gMqF19fAsJW2+8ae+7zzSCfZEQnV3tneoYTTL2/D1vYi3aFt4Ap3JA+5EOzFskpFDYdu
         lb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8ns64/S1YcMnBkUrA3r7x+mGWgSqsyaYuojSy2kOd9gc/zwrb5CP7x1z5Qqs//2dS8rtjtnfNo6eAZHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4HEn0Fl9vIdjmHjg4PIgdkY6+5OgSjHXKJzIPEbkXKdGhP48S
	3OpCIvLPxHpiqQdsnGTnKUPBbd1Kg0R3FpxtOv9zzJcM2jSBPdQmVOAotvwC2zCZ
X-Gm-Gg: ASbGncupAjBXsfHjPCXb89XpTbU8JC9ndR31jegC1skmDTWPVvb1FFn4PQr4hREgxqW
	ZB/bUIz+eVRBVZ44b1KaIHuCcoKGolpCe9Ni5TB5JaxHm5PPo0Adf5mtSARsywhNR+HxoUc/zay
	YJJPLE/68L/BeJsSemeWtWB//yqP4eIoHrQrB0mywWpBEcSRRCpvd2EXIbTOVF+HdoFNj+kYPav
	uhF907UEztkqnUvnCT2pJ9P8315Idek5yR+DkUcnE8cm6BNzEHKfgXc58XipZ946tdBljerzbvI
	3pJ+NvD8/pk+F4zEmbm0wbZUNX1PE4C6sbIaGErQNvec6htP/vrlcDYYxpihlkVLngR7C7HkjRq
	thD41XEHzxj9It6ZdplKElDvzupU=
X-Google-Smtp-Source: AGHT+IFjgykEGq2OvWiHCETc4+d7Jrzw7+wf1/Rp6hxWBxQPIvb+9EM2FzGSsqyhlg1GmjPZ2vYMkQ==
X-Received: by 2002:a17:902:d486:b0:242:abc2:7f32 with SMTP id d9443c01a7336-242fc210059mr5813885ad.3.1754933383353;
        Mon, 11 Aug 2025 10:29:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::17? ([2620:10d:c090:600::1:56e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f36311sm32008340a91.34.2025.08.11.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:29:42 -0700 (PDT)
Message-ID: <a94bafca6b9a03be3d09b76341c89ddef6ce9bbb.camel@gmail.com>
Subject: Re: [PATCH] bpf: fix reuse of DEVMAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yureka Lilian <yuka@yuka.dev>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 10:29:41 -0700
In-Reply-To: <20250811093945.41028-1-yuka@yuka.dev>
References: <20250811091046.35696-1-yuka@yuka.dev>
	 <20250811093945.41028-1-yuka@yuka.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 11:39 +0200, Yureka Lilian wrote:
> Previously, re-using pinned DEVMAP maps would always fail, because
> get_map_info on a DEVMAP always returns flags with BPF_F_RDONLY_PROG set,
> it BPF_F_RDONLY_PROG being set on a map being created is invalid.
>=20
> Thus, match the BPF_F_RDONLY_PROG flag being set on the new map when
> checking for compatibility with an existing DEVMAP
>=20
> The same problem is handled in third-party ebpf library:
> - https://github.com/cilium/ebpf/issues/925
> - https://github.com/cilium/ebpf/pull/930
>=20
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> ---

The change makes sense to me, could you please add a selftest?

[...]

