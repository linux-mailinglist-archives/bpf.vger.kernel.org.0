Return-Path: <bpf+bounces-26646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613B8A362E
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408192814EF
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893814F9E3;
	Fri, 12 Apr 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2PXUCIr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFC14F9CE
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948915; cv=none; b=VZSztmNzxSzqzbpKaYw5ybAWSLZPCl5zMOQDWFdk3mUXtQYkGVH05Eo5sSGk9aSsDK+CRQersIso52uQCwMmsI+aekE7q+Kbomk3FzHxH2cqNw1bxEYagVWqMZliGCv+IhLeOjt3r27q8kZyKCkbFj7YouVrTykClRZI+0cCh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948915; c=relaxed/simple;
	bh=mexy7GN7pUB8lXW1vERuP54uztUn0bp2O5YBfq+ahkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqexjJFn/TIW2JHsJV0Q2JG/KiLLf8I5miFOMN+TxHPCg34qKsRGDpQvruG7+/yXqJRLGNu/Mctj4DGs1iKgB5gc11q5NkZnuRu4M/A8V4HbKgu1XE6NjtGr8vcgzqzyjrv+0gr22tj8ZiIyzMszHMmPliA+fl8OHwvzFUvbWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2PXUCIr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso162465e87.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712948912; x=1713553712; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0zPaY9+X7EHiCPc2N4sSTqd2LwgixlI+XbwU/maszyw=;
        b=d2PXUCIr3OiVdr4LWphjlpH/fj5DsVHV/0hROgwLVkSMHTrJsWLFBoYZa1SlLNfGuQ
         5ls6oCuaHXJtGtcuMLbmxyBd2Tb/3MI/9/p91mvCtm6qLPcR1h7PkmFvRkIDXD9Q5HiP
         h0LrIYqGThbIhFIKdD54DupVni/6kmi177tiDHsxUFqFx38vGt/aZBz0PCLGlH7jf27t
         rfADkaimF5S4Tub5TRxcCJfuAyBoF9DCbMfLo0aQpgJEZlBy9OR1Qmjw8Cm8V0b3ZyTC
         Tu50YwF2QR/NFLVmV3lOjISBfysFx8f7erF4jRmdq7PoV5yyyGhcSkdamxu+c8sT7h0d
         uTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712948912; x=1713553712;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zPaY9+X7EHiCPc2N4sSTqd2LwgixlI+XbwU/maszyw=;
        b=CLStnm8JzEGshV1Zq6MpbwX8P4EIy1IfrBjjftn3KEY4r8Um0P0QZ+74fI+fxpFnTS
         SBIOEkjugyeruGUl3M5T+MexX3tUzqS6VkRQApMMtH2TOuW2je/v26vcvmbQUQWmUBsG
         +QQxzh1Wt5bYG4MRwNcdlddbNFdF8Hw+f995VCQndl41HnLC45uU0y3k9PZ+Z5hHbj1M
         oyqxbrWeEdbUi5fSEi2WvOb46epXpGw41eJZqUEvmX0zVdjXFh5ux0Kejm/+VYFpCCxD
         +mlRQxwotFV9yJfo6sB2yP/Mq2YbvAdaLzE8XRIDikfZqBhud+57h+/AtLkgCaS/PheE
         Z37Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeDEAcNmTJEdC0bUbxEwIKj1K90W4jqfeJ+LNKx/soTcGFnlCIILUzauHF5W4PMQEWFBxpLwMXyRtN/gEOEJKEcQSX
X-Gm-Message-State: AOJu0Yxi00AOSacVcN8UxYlyuGFHCDDxg1hMibvDtFncfeS6uFxYEj6U
	JRl0Qk+XvybbadPQzuKr/AVY6Zje7A4RW5B3vaNYkGX3+7t5t4XM
X-Google-Smtp-Source: AGHT+IGYaUWqLJfzAXoGHU1nayhBHZYvtOccvS+85/4WGU+olysFMR4wW19oPQKhyy0Fdhl826hxtA==
X-Received: by 2002:a19:9151:0:b0:513:cfaa:e618 with SMTP id y17-20020a199151000000b00513cfaae618mr2875830lfj.0.1712948911537;
        Fri, 12 Apr 2024 12:08:31 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id fx14-20020a170906b74e00b00a46aac377e8sm2115368ejb.54.2024.04.12.12.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 12:08:31 -0700 (PDT)
Message-ID: <520f62bee1e1a037c53dafabf4c4b71adee71cd2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/11] bpf: check_map_access() with the
 knowledge of arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 12 Apr 2024 22:08:29 +0300
In-Reply-To: <edea9980-f29f-4589-9a39-d92a715822ce@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-8-thinker.li@gmail.com>
	 <c89a020a219dd2d6e781dce9986d46cbafd6499c.camel@gmail.com>
	 <edea9980-f29f-4589-9a39-d92a715822ce@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 09:32 -0700, Kui-Feng Lee wrote:
>=20
> On 4/11/24 15:14, Eduard Zingerman wrote:
> > On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
> > [...]
> >=20
> > > Any access to elements other than the first one would be rejected.
> >=20
> > I'm not sure this is true, could you please point me to a specific
> > check in the code that enforces access to go to the first element?
> > The check added in this patch only enforces correct alignment with
> > array element start.
>=20
> I mean accessing to elements other than the first one would be rejected
> if we don't have this patch.

Oh, I misunderstood the above statement then.
The way I read it was: "after this patch access to elements other than
the first one would be rejected". While this patch explicitly allows
access to the subsequent array elements, hence confusion.
Sorry for the noise.

>=20
> Before the change, it enforces correct alignment with the start of the
> whole array.  Once the array feature is enabled, the "size" of struct
> btf_field will be the size of entire array. In another word, accessing
> to later elements, other than the first one, doesn't align with the
> beginning of entire array, and will be rejected.


