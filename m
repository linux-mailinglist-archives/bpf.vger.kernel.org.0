Return-Path: <bpf+bounces-50590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619BDA29E53
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E383A6E2A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB033CFC;
	Thu,  6 Feb 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIlFDKC3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AD1D540
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805351; cv=none; b=ACpUsm9INnJ0L9NG4tYujmdYUfzxTEdBIpRa1fvKa2nYHu2JGSUyX1/oWwiDb1hjExVi8xtmjZ8ne7Ohao/Sp/WBfwkMxlz2dhOtgzsxztXnTMfdEY0ovViAd1iujDeJJofkmrzj9UHzVgHvKRQ6uhSp7Lstn5o/8SV781QFWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805351; c=relaxed/simple;
	bh=CGLV2REAScP6w8lLQfWrsqn/NAAnchjMnm5dX1e3tPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n53zJc7V2JgDGJVTRcsVCr1jB7hvOtUs9DLUB5u+VHCV64Q9a7t0Z9pV1321M7hsgZ8s3rt/vbABuPOH75zJx18qcCKougDrt5zLewjBlKNB2y6DGSIkT8Jhu+o5QzwaXywxZ69AGCPPSsxGcqUODo+CDUN4Yh6plSXxBYY1mHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIlFDKC3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9c3124f31so482855a91.0
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738805349; x=1739410149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDQcyWl2d0GdEQHgHO2xNvjEbME1IyYFxDu1GJwSJyU=;
        b=TIlFDKC3tAGnncNTulgrYwfooJvyFy99rhcNm4JT9CVNgkdJynuazZib46K+v8h4pC
         a8pWFpND1+XXY3ECkigGXh1XTYjwyfiNz8wGIZCMH1LKYe1eHoSuQ60o0aQkNTHFSWhz
         xOybynlmxskVu+Wl5EyqCjkOiBZ+IPqDEcwrVDDZLDHsru1HWPT25iUrsb2ck4pFXIu4
         GOODJKCEe/dVCMO652jtmWdbpyk7S04yTefgz2/R0fuDJCdfvl/14p2tM8Rb7n8x+HHv
         nJNO8MIsWDri9rPn0jP0a0hiAYmwjIHqDy+vkkxdjWXbGRY4uVjeFEMl/hzC54p/D2wV
         4r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738805349; x=1739410149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDQcyWl2d0GdEQHgHO2xNvjEbME1IyYFxDu1GJwSJyU=;
        b=ANv/po0U17cklTm/UP0J6RZst88Z7XJ72uFqPQk9lA7cY2ud3Lzh/7ffFJ+LgEMn0o
         4tHFzgq60Y4nYUAbZxUyYJcg67hLZW5sG8ZHCaeUu8Ap31SbbPliSx1V1WmU79pKCNe9
         75oqk1Iyf1fUPiXyhEbncQxbo54YsNoZgHoLVk+8mTmqtd9+V4WYd1dmQL9sZ3wbGrTL
         fZ7TCdBJm/K3HyJ3/hs4hfYciZOwtCJJBvgVSZZWZUhfQW36T4P67X/SSbrDMb6bS1yD
         ZWTbY5unRzdA6/h7FkmOOOMqIqJildcZDTGt1YGptEW43m7bFijb7O769+s/Twail4df
         x81w==
X-Gm-Message-State: AOJu0Yw2xju2ANR0UScOwTgYCVCvBt//G/uEE7/gIey6rCu6f/ae+dEt
	aWI2Zc5evS6wEFViD/zwwUbfv44JmjqAOTIK/meYea5VIam2+qnj
X-Gm-Gg: ASbGncv2bDwaWaW46popf7FR3Eb9awxwK2mAmTK3idP9AWeW2iMQ7pTo1S8PeJqxu22
	ZMtVQ4RPjN3cYZGqp2wPWxzj9GdUMFLI2tuIoW/QjT4rMxwHZlBAV36raHK3LHeQnf/U7+OUskx
	MEIOGyUwnT0KTgf16EYLSec7ympoIaQU8tXYGES7On1V6KcomDASs026ptorvKRfBOGkvyBXELy
	Ggj1QzeYS8oey8tjb1jT9P8ek5PQ060t3Sk5pXzGpbuSfz0fa5xIgyXThVGZbFMWgHx8hiU4VvA
	xHhVnop4S5W/
X-Google-Smtp-Source: AGHT+IG1OA8hio+PMNdf38EFz9M4e/ZCzOHDxAf9ifzDJATnbiA1ozmxcbOIMlCxPbLl7qZKwR2kfg==
X-Received: by 2002:a17:90b:4a02:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2f9e08349c6mr7091387a91.22.1738805349048;
        Wed, 05 Feb 2025 17:29:09 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365110f7sm596675ad.42.2025.02.05.17.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 17:29:08 -0800 (PST)
Message-ID: <304d5081ef18c3d933d5d0bb79579922d74437a0.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: implement setting global
 variables in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Wed, 05 Feb 2025 17:29:03 -0800
In-Reply-To: <CAEf4BzayxsGSj5n3A6HAYgg3QC5xFvNcXrCHgLCqiWMj=0EP6w@mail.gmail.com>
References: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
	 <CAEf4BzayxsGSj5n3A6HAYgg3QC5xFvNcXrCHgLCqiWMj=0EP6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-05 at 17:06 -0800, Andrii Nakryiko wrote:

[...]

> but main point from me here would be to avoid parsing multiple values,
> it's better to allow repeated -G uses and treat each value as strictly
> single variable initialization. So instead of:
>=20
> ./veristat wq.bpf.o  --set-global-vars "a =3D 0; b =3D 1; c =3D 2; d =3D =
3;"
>=20
> we'll have:
>=20
> ./veristat wq.bpf.o  -G "a =3D 0" -G "b =3D 1" -G "c =3D 2" -G "d =3D 3"
>=20
> A touch more verbose for many variables, but not significantly so. On
> the other hand, less parsing, and less arbitrary choices of what
> separator (;) to use. WDYT?
>=20
> pw-bot: cr

In a sibling thread I asked about '-g @file' support, allowing to list
variables in files. This could be worked around as $(cat file) in
the command line, of course.

[...]


