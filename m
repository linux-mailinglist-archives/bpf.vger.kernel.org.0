Return-Path: <bpf+bounces-47155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5739F5BDA
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1AD07A5C5A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7A1DFF7;
	Wed, 18 Dec 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxwfmPf7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64E1C6A3;
	Wed, 18 Dec 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482447; cv=none; b=FPZpdwO/oyhEHydq7PiAwGLGEfEsbZdANwljhqFlGzGYvUVk2KfkyuYq7INrpecYR5ZZ9M8XsxT3OcDeQh/F5POEM9O+4P2vtoMzxfISj8O48zPIi83pxXYucz7CcOLVN5HYnsnMoJuaYXdDfj+rMkqUUYmOwkfSqvANggchm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482447; c=relaxed/simple;
	bh=cAVrn6acu9d3HlEYfgUBouiRJmMfYpzJqYfYUzT1ysc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHcDwhwPAXA7xLzOWLm8TpKf1HZuJ135TAm8UCGA4+mlnffraJlVcG7s+r54BiiL1Xk5lYjvfqpGy9+leNHem0esYa4p62oXdvf5d7nMGWRinL6PPUL1gNbnheahbkXU45hwfegCOxmm9hkZhAlZrkRpKPvD0zjb51ka0PCuEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxwfmPf7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-218c8aca5f1so17848705ad.0;
        Tue, 17 Dec 2024 16:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734482445; x=1735087245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f0BI6OdKXBnebpImmhoFMNtXacM93U1r3GdpCS8+UHU=;
        b=QxwfmPf7nj5LsrAijD/gMyI/AlHMAQSiVS7ITSwZ8tGMCse24ICKtL4eu9a8dci3Qy
         R8GwgG4IvDyFU3Tlqzm1vQqiAw2BLDX+hf82xwKJ0fxx2DitxpvTiPAuOTb2u99+EEHS
         gOg3ct99en8HfE530NRONB/vjz9crqROpcxnO8w1ZgIMsck0rZWn7Wc5zPramVBQSTY+
         Ha/WLyBCtbuHtLLhEB2RSwdfCN7+VpbKgK+Z2Uslzd2gl20SXvbWeR+qTDaj5WEH8D15
         VIK8xWrMLlawBUPcy/WY9wYb4RqDAsUgfymLINyHf1/pKJT/8+1E3hZBdBK7m3JOmSYv
         agqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482445; x=1735087245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0BI6OdKXBnebpImmhoFMNtXacM93U1r3GdpCS8+UHU=;
        b=sEE8kC7l9ARu2F2thvpyjXCesGQ02CZ+8TR69CkX4WP5MJOwwAahjGil2/Wg+gFexq
         +NKU+Mzt1S/4eLzfmvvRJINJzoMIJWbxfI3OA1UJoAPD3+j9J+rNVAfymKkLhFYo2K9l
         wAoGZ4ijxWVL6joKJ2gTIYuiES2vyLdDJTDICytuguolpcxp2j5S7yxSR/qgrVV6T1wn
         cYzSZ1sVvWm0OMSz0tWx2VqFTb1+G7N53wMwxSbeQG+uoXX1t0ZhIKROXxipo36e2Rpw
         skOtxR7s4Ri/eAjFT6eJOgGnTKisZ8JwHTKbVNnJRfF1w55STHYgqKcDH9uKUU6rC8vS
         zKeg==
X-Forwarded-Encrypted: i=1; AJvYcCXuXY1upFQYbTjI23nVr64qGWJH3fo4fAe1DAKUyJjhN/81auarHxQByKUB6JK0xmTlZ7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEwqZY6qp/bhSP+JEU6AYHqr7v6MN+oQVt4t/c7Mg5ta0OeUv
	4J/07fVCc7qRElAqhKd2ZsAS4oT2OanjdJR+g/iZdXSQ+S+fSZ4G
X-Gm-Gg: ASbGncvZiGrBYYUmvSRlTmB1rfkj5bXjSgW0ZSfqCMs8Xt8kV/SlXhZUXuRkVP3c5zF
	yWJJy3lyHTfw2H2osO7D5RRuXnpBjElKZBtFTAo+wZd9NSxzibnaE5tPRAMcPYlRWhDe5VSR91P
	Ru86X6uvB56BuuO5Nbi6IJWRXFtyHxycekt7SW4QBMYmCOOolyJTjLW0f2K8YWZ7PLo/Ytp8WRQ
	jL6doFYaLAz06yds8Uc5igfAegEpaqMZ6oARxd9sgfKJt2pelWl4g==
X-Google-Smtp-Source: AGHT+IG9kEh64tuF6IxC0kTz+ZK9LSlqsAzJnnQinRf9ZePXubwfvsU+26nS2CE2xJFeuzk2EQSzvA==
X-Received: by 2002:a17:902:d510:b0:20c:9936:f0ab with SMTP id d9443c01a7336-218d726c05dmr10714595ad.47.1734482445367;
        Tue, 17 Dec 2024 16:40:45 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5034bsm65282945ad.166.2024.12.17.16.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:40:44 -0800 (PST)
Message-ID: <af9404ef750f152afb20b2883aad3b9fc5e5a2dc.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 07/10] btf_encoder: introduce
 btf_encoding_context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai
	 <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Date: Tue, 17 Dec 2024 16:40:40 -0800
In-Reply-To: <CAEf4BzZ-chyzJzCdW0AwjaxhO+yfUCO=Dcu+7=m96Ccyq94Y8g@mail.gmail.com>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
	 <20241213223641.564002-8-ihor.solodrai@pm.me>
	 <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com>
	 <735014fda88330d2124f4956cc9a0507f47176db.camel@gmail.com>
	 <yKpaq5zO0TcrAm1v3p4yd2D9ic0jGUQM0CUSg6CU_31_S1mX7SDljMf36ayteEV2O_MTE2eJkUuu3JoJWPQyIxHibe2zz1W3Uq_RzqiyPVY=@pm.me>
	 <CAEf4BzZ-chyzJzCdW0AwjaxhO+yfUCO=Dcu+7=m96Ccyq94Y8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-17 at 16:03 -0800, Andrii Nakryiko wrote:

[...]

> I agree with Ihor. I think he invested a lot of time into these
> improvements, and asking him to re-do the series just to shuffle a few
> patches around is just an unnecessary overhead (which also delays the
> ultimate outcome: faster BTF generation with pahole).

Patches #1-4 are good refactorings.
Patches #5-7 introduce a global state and complication where this
could be avoided. (These were necessary before Ihor figured out the
trick with patch #10).
E.g. 'elf_functions_list':
- there is no reason for it to be global, it could be a part of the
  encoder, as it is now;
- there is no reason for it to be a list, encoding works with a single
  function table and keeping it as a list just confuses reader.

Same for btf_encoder_list_lock / btf_encoder_list.

> And as Ihor mentioned, we might improve upon this series by
> parallelizing encoders to gain some further improvements, so I think
> all the internal refactoring and preparations are setting up a good
> base for further work.

Not really, the main insight found by Ihor is that parallel BTF
encoding doesn't make much sense: constructing BTF is as cheap as
copying it. I don't see much room for improvement here.

[...]


