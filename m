Return-Path: <bpf+bounces-52118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C971BA3E901
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4F917DA09
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DB215A8;
	Fri, 21 Feb 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ0uSOUp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FEA50
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096524; cv=none; b=IgIHwsru+PaVWx6Gqcgx5n/LawLatp2+7a/X7QvYpoF0LYBlMw2D+RFz9aykBDqvebMzLUyoDnDXYQuGvPWNPkgQui5bS7d+f99TE2wGEL9yjEC23nxxWxqneLpSNFSoXUq0N2eg7IjjNtj25U44VmwU/HBmJt/I9AC5ZTRxQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096524; c=relaxed/simple;
	bh=x9Iy0aQ/0u20HQD/iaQ8yx7I1x7qXkVIIXP1Yhim+BM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9HJTKyK1dLZ9454yWNFRiOkt9gSGStfjfl2l9iDpRI+aPg4C2fJ5appIAR+v3cmdp7uDmbcjeNOruSGl1kKqRUwpZgP8Ox2Mx0GJU4dtr1POyOk5/HUAyVq3F/eGMKDzZu8TVLFxDZ/I/VA7LC9+CLoX8l42GN95GJWW4Rogu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ0uSOUp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e989edb6so42146135ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740096522; x=1740701322; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x9Iy0aQ/0u20HQD/iaQ8yx7I1x7qXkVIIXP1Yhim+BM=;
        b=hZ0uSOUpIwjIcq8nPdbYuwXdwkYP/3684uJBu4LduXDv5dkYhW6riCn+F8LDkviBpX
         sO6l+fyZ4TRc6rx80/KkpRM9k1aJ1TU0+CzmogKgd20kTQRmSd2AAapTYOvWmYAsVStq
         U50eYmE0rNmyMecLBcUpOfC9NCmFvMKCbK2zbz5uwriTgb3HQ8QxQV8hEEe+Qif+qarB
         YIeP4rc2sOCEAhbt1BWins4kUdXP2K+SiWZv1fwOd5FOIvanDBPR39J9sLu/JFjWTraF
         D8BGLPV+fxjKdBACDSbGJ3C6eTPpFWN9dRFHHAz7fCKDloSfwUHNW9qmX9y0epLQSFym
         uApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096522; x=1740701322;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9Iy0aQ/0u20HQD/iaQ8yx7I1x7qXkVIIXP1Yhim+BM=;
        b=c2y/KkSP2TDTB04ajKINr4DKAqyKryxJFyjdpyNHNxTfhsEEmVa9pT4SQz6oKNPYDA
         CVjZ4VcQX9PSjkC+XszO0JxsHG6GgkhKtPyucCJLrqEHsK9096SocPHzSiV48qsjnB68
         TMqOmcRWnNQ+/2mw0d4DUml5YBQA8OHmp7fD25UMQVppHVJYqTFLaos7JNlO8DrSwRJa
         2vVcSCf22zjcuepWcisYi1c9R3UD7b+ERI3EeVJ/dt7yUJGQeEsQwRRY+l7MAZE1R+YI
         +kmrW7HJEnAkaEJQfbdGcHzu9ZsNYpvsDB2K0YSN8ksOr+UhZMFTwbDATIwhILX16qsv
         N4eg==
X-Forwarded-Encrypted: i=1; AJvYcCU46r7kyOuAC33jgzFLLSjsdw/NJ2LkSqSYamaHiy2eHrCXb3i8VkyMIkdt2Ke+ACVjirM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyweD2wplcI0OgOz/VoqUkB9vAsAOweB4mv5D6C2ZSOlHbCm6x+
	P42YKSX+ykf4Yo0WyvFqwpWTmaauUTO3Km0QuTAh5SAlQZRvOdBI8Nm9N0K2
X-Gm-Gg: ASbGncvz4VwtGYdTERu36JDwPQawkjM7yYyS1Sf3xvO2tvKlFt8Wh+0vFsldf15WAlV
	PRDTlEtTmaK18Lze3wUsWjaNAVrmk8bp4P9WcT7RTZdaZ76BVJ+s+jQ1HQ62l4XwUsVuR8LtLLj
	y7FHomeE+kh8LMDUYBMtZH046X6XhEHUWORhcqztpEz3Yg8zVfdWi6YjGgkkIJCj5KQe4Y77uie
	TTncBx47ndQjZOHUUsXPvgsQ2GQgjfTJyCoF3+nfjNr11z2j5o723KdA4cXYuLUJTqSWQPzF+UU
	SqQ4Pl/Y1N01
X-Google-Smtp-Source: AGHT+IGTYHJJlHAeH3nbGav7KChatfpPZXnhs/tZ/YVwOOcoI0PKsMK5yuDFdC6TxVBt/SmFgzQMAg==
X-Received: by 2002:a17:903:2a8d:b0:21f:3abc:b9e8 with SMTP id d9443c01a7336-2219ffc3345mr20362015ad.43.1740096521665;
        Thu, 20 Feb 2025 16:08:41 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm126162225ad.241.2025.02.20.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:08:41 -0800 (PST)
Message-ID: <b64dfd940e7ee594332832e0e522e38e0c94724d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Do not allow tail call in
 strcut_ops program with __ref argument
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Date: Thu, 20 Feb 2025 16:08:36 -0800
In-Reply-To: <20250220221532.1079331-1-ameryhung@gmail.com>
References: <20250220221532.1079331-1-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 14:15 -0800, Amery Hung wrote:
> Reject struct_ops programs with refcounted kptr arguments (arguments
> tagged with __ref suffix) that tail call. Once a refcounted kptr is
> passed to a struct_ops program from the kernel, it can be freed or
> xchged into maps. As there is no guarantee a callee can get the same
> valid refcounted kptr in the ctx, we cannot allow such usage.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

An alternative location for this check would be in the
check_helper_call(). If done there, this would allow dead code
elimination for tail calls within functions with refcounted arguments.
Which would be useful only if in the future tail calls from such
functions would be allowed (e.g. a program having a branch w/o tail
call for old kernel and with tail call for new kernel).
Probably unlikely to happen, so I think current position of the check is ok=
.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


