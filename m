Return-Path: <bpf+bounces-30153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D08CB40F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169AB1F23478
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D243149016;
	Tue, 21 May 2024 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIVpjcby"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DC147C8B
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318519; cv=none; b=It5rzDiz+JxFlzDQ9m8BbZynvbDMdjGZ0fgRVnJzISa448uglKXWgE+be4MHGgytnms6yTc/rOI7Ys2QOmi8QaHcZcV6nNQ4d7BkU6mEgvGRDJWmL/u9UMTIZNbeMjZJQN3QO+1fOGS0RMQUh9mvQkseTVS3WOVKxpk2xFfg7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318519; c=relaxed/simple;
	bh=qK9ch46JO7/cUA8kl7QgqJOhmWVbT16Iv+Sx72Ns69w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3e5KBwdwG5WiUoJrrJtXb0FrYrZP4EwaKgaNzdZz02cmO8EazTdVNzLKemqHgSMYU0yJqt0e+/P9CZZ9nc9NMjF0g6OHXXKw18U/ezDdW9ewunLAeCggRWHaDmFV62Bkn2s8yx3HEAE/ZDQ4XYA5X+TAe325zC2W4zyAmcBZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIVpjcby; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso4082025ad.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716318518; x=1716923318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qK9ch46JO7/cUA8kl7QgqJOhmWVbT16Iv+Sx72Ns69w=;
        b=RIVpjcbyYnDFe6ECBcT3KbhSdmfmak9QwJMlV3w/U7Chr3pH4jJ6X3o2jpK76G0lb0
         gLAvhTYr+5G6s6bFLTA4dW27o0NbZ5viVgaiYUluHxQ/1aLPoOx8Qy1p1wsssyoo8S62
         +nsHKRGwO16wW3tS4gKtPZapLrjwkM9jFqPJoFpNYCMXjj3acB5W8OWSS48JV+WH6n7V
         c4glTKUUtgwAPdbya4jqPuBmxOowFQ9RKEyIVguir6CDDBc3qaDRsXRN25zpZErDF6gN
         m6FxQs5t5TyC47GjKO7QUDxzfNrj/ZOTegb7fdbBKfyYhIsiYM9t6NBIf6CYWj7wE+YH
         52dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318518; x=1716923318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qK9ch46JO7/cUA8kl7QgqJOhmWVbT16Iv+Sx72Ns69w=;
        b=gvRGZuMFxbLW0dNYcczOj+/9VU1LwNOmVxx2xgggeKxceS6x2tn/z74vViVsesuCHQ
         0Ziwlmqf924CXSvCd501oOU4cAayyvd9geuajyVYlok4LYLzO2HWKH8uq/jLe71W97uT
         RHsyozjHGAvLjFLTon88Yl4qRyhQA6EsTK+lHNrnjA1RVbuifYQa6F8jCtM2YjQNOiek
         jDIUADsdhroKDvmBFXP4L19tI05MmdLmoPaoDAx5TOWyL9JkrnFOMBOd14U+4f9XKx0D
         yre80nHTzGY4nhzJSdTuOizajJNJeqD2EMssBcQXUpno2qrFaRSJXh1T+cCuE7Tl4M2w
         aokA==
X-Forwarded-Encrypted: i=1; AJvYcCUIBALMxbevsyl2OZreQ36a7IxEZwR581vr3eIt8lsFHW0jgCIpYfSjDKY6drp26PyLhlN/XFYcSQo6n/Xu/EZgQmZb
X-Gm-Message-State: AOJu0Yy7MRtKYlu9OlEgM6V0SjAQjuvT4jNy0x7v+Z999WQYlAQs3Vvt
	Kfp7aeqrRuFSBgOF184z6DgN7RJN4N6eOsS1Usv6VH3ouvnOL35Q
X-Google-Smtp-Source: AGHT+IEBUPQ/DrUWFuOOsoEnLly/9McxoTxIGiyhwrcBqBf32jQrizrFD54Af4A8fxRhl2eMli2vQg==
X-Received: by 2002:a17:902:ecc6:b0:1f2:fe12:b79e with SMTP id d9443c01a7336-1f2fe12b95amr75797955ad.17.1716318517696;
        Tue, 21 May 2024 12:08:37 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bbde9d7sm230739965ad.106.2024.05.21.12.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:08:37 -0700 (PDT)
Message-ID: <eda720142ac52a9bd9599f5444a2c2897255b5c4.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com, mykolal@fb.com,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Tue, 21 May 2024 12:08:36 -0700
In-Reply-To: <CAEf4BzbdoXTeTSx-1Vu+sA6MKphQq91p1TwnSkK3Yv3msa7h9Q@mail.gmail.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
	 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
	 <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com>
	 <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
	 <CAEf4BzbdoXTeTSx-1Vu+sA6MKphQq91p1TwnSkK3Yv3msa7h9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 11:54 -0700, Andrii Nakryiko wrote:

[...]

> I'm probably leaning towards not doing automatic relocations in
> btf__parse(), tbh. Distilled BTF is a rather special kernel-specific
> feature, if we need to teach resolve_btfids and bpftool to do
> something extra for that case (i.e., call another API for relocation,
> if necessary), then it's fine, doesn't seems like a problem.

My point is that with current implementation it does not even make
sense to call btf__parse() for an ELF with distilled base,
because it would fail.

And selecting BTF encoding based on a few retries seems like a kludge
if there is a simple way to check if distilled base has to be used
(presence of the .BTF.base section).

> Much worse is having to do some workarounds to prevent an API from
> doing some undesired extra steps (like in resolve_btfids not wanting a
> relocation). Orthogonality FTW, IMO.

For resolve_btfids it is a bit different, imo.
It does want some base: for in-tree modules it wants vmlinux,
for out-of-tree it wants distilled base.
So it has to be adjusted either way.

