Return-Path: <bpf+bounces-17317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D247A80B5C9
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 19:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665EE1F211C0
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909719471;
	Sat,  9 Dec 2023 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxTqA0Dr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37DD60
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 10:02:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-336166b8143so600507f8f.3
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 10:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702144948; x=1702749748; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1E26II6jQYUBHeOoMfDR34jNmALC2R0ZNZdpdfTzDBM=;
        b=SxTqA0DrqNb4l7w0CGkGpVKbuO6kLi5e8U9i6jI4R3zefOrOD0v710FVYDnZwgppHR
         4rtXQ5c2QpLSYM9ofkcxu/5mdz+Jj0HV6UIS1r3gpctNazyfZit+2B60oViHwAj3Ztzy
         /T/Ufwn9ACXU5uXYSr264bGwq7KhSzEyoSnaHLAtfbwLn503NCyEHw9XXLlgdCPQ2V/s
         WUsi0S/iQ7U8aJMNbSsjKXwpRsdCr4kHsa7WnS3yFacBzciIsRqAnZ/vu+imVQ7dTdVZ
         oGjlKDjIPRoUU0CUPVb8fvZ24lJhPvjMcqWck6I7pWNaBY9Ux2RuGNouHu9++/ZeeNfX
         CbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702144948; x=1702749748;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1E26II6jQYUBHeOoMfDR34jNmALC2R0ZNZdpdfTzDBM=;
        b=s0lHVpf82Sl/K9r6o+hIVo+ijXTMf0s24d+xNKrfz1sJr8jeTGNuoW2J0IE7Ry/+aa
         p1IcGn87QDjsrYDTpgChyaXnGrEuFRE5dS4OJfGXMMr5jGZdqdbH7rzFyT8HtEfx3NUs
         0IQ4sSvF5KPU0d/UOHj1KyBWG87TDNqhoZFdAIsXMyhzU/M6VBlo9PZcRYox+s/N26JB
         HDPD5o0UYTSQdaEv1JzIXCZtniZIa4v2JKnahXIsIuNuU/a4gi+qPlEq7XHReW6tu3St
         2Rd93LiSl9z6IMkBizUr7abphY+iiutmInwwozHqM3sOmImpdhcoaCwypvriSF0znSc0
         1yVg==
X-Gm-Message-State: AOJu0YyK3FWCEJ8UJvvH8cJAGqIYdWL2wKVYLFb0RveR7gtNxJfyywNZ
	T0S68vMFC9JdV06ciunELTZAlJl2FqEDcw==
X-Google-Smtp-Source: AGHT+IHxaMHL1flQo9OKmklM0mSYs+TND+hmf9C53htUodq32v8eXL/EflF/nsgfI8whtZKc7y+UDw==
X-Received: by 2002:a5d:4a0f:0:b0:333:39bb:d050 with SMTP id m15-20020a5d4a0f000000b0033339bbd050mr1277485wrq.139.1702144947790;
        Sat, 09 Dec 2023 10:02:27 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d6606000000b00332ff137c29sm4847004wru.79.2023.12.09.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 10:02:27 -0800 (PST)
Message-ID: <81f377720ebfaef0523951265deb468ddcc0ea22.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: validate fake register
 spill/fill precision backtracking logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 09 Dec 2023 20:02:26 +0200
In-Reply-To: <20231209010958.66758-2-andrii@kernel.org>
References: <20231209010958.66758-1-andrii@kernel.org>
	 <20231209010958.66758-2-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 17:09 -0800, Andrii Nakryiko wrote:
> Add two tests validating that verifier's precision backtracking logic
> handles BPF_ST_MEM instructions that produce fake register spill into
> register slot. This is happening when non-zero constant is written
> directly to a slot, e.g., *(u64 *)(r10 -8) =3D 123.
>=20
> Add both full 64-bit register spill, as well as 32-bit "sub-spill".
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(imho, goto +0 is an overkill, as we should have tests for behavior of
 parent states but not that it would make test cases much simpler).


