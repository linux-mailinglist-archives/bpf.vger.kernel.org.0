Return-Path: <bpf+bounces-76784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC8CC55E7
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6596230024BA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF733F382;
	Tue, 16 Dec 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3cjKsQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A72223328
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765924558; cv=none; b=ifFZmG4C+Tr+2zIn4rM84SzPezgQYZLiU9XaDZVV8OoxfM+is1Mx+mwzF1XVjIYdL9+z8zGrFnhx+G4Dx1RsUMd2XN9i85xOxaMmHAcIWrgNVxVEIcKkahdWcy1qrTKTdd7lYIbgvjZGRyhSkNWttwRIEhH3xdx+d4cHE1CCX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765924558; c=relaxed/simple;
	bh=WGWXYPcJmuvmwRCa3kvpN8lY0MC0ZrvAzxIclIoxP0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AbUuhI+OG0x1chF6kpeMo+7hW+7MEosOueyyJWmInHfK1AZ0/f4YC0ij4a8k8biCgQwGBGk2T3CYVcbOmYh040YXc9axYqpE9kQeofpBiyct8wmQOa8bgVUjuka1NhFEyPsIiKKGskrXNzeYihgLLmqCo29nFUKCJFco5gZYtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3cjKsQZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0c20ee83dso36291855ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765924556; x=1766529356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WGWXYPcJmuvmwRCa3kvpN8lY0MC0ZrvAzxIclIoxP0U=;
        b=V3cjKsQZyloBKrJuydyxJhM5eXON1SRP//sT3+dwlG09IP/11vXhujon1faWFBnMKD
         XOYIB8RYBUooKrmXezuNZlJj/1y0X93rCOiRefwOlkjSCDAD3rAGy2OvcBE+AzireZeh
         mANyFQhmyS305ArFt1/jCKud5+2bDvHnpPPoxg+XOYfDqm+IxyYjoW4iuspSNfg4JXe0
         6llAsOkxYdh5CQ1k63SWp3jHnB/lWUmitDHBhhR8glcKl3nzJtr21Tk3+FAwT9xsuEi1
         fv/x5jJUNCrvkrKPowncWBh1s+xRHwF/8DZy0jkmeEFffntUtWsZKTfHMC9Ue93ATcLl
         3oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765924556; x=1766529356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGWXYPcJmuvmwRCa3kvpN8lY0MC0ZrvAzxIclIoxP0U=;
        b=fkT0NUqnmbzVsp6XFtzPrYzapSEOj7MJFWNQYQdAwioYpT0dZvTTQ+h+8dC2owNxO4
         EGOpeY9jbIuA3L0/kbOb598zsR44We02Xfebam99BLdXjAZBvmqecRqFtnD/dgCwn+Pv
         oYOBKiDwV2gfO9QB8fIPdG+dddD4YrXUlyKSvtIY9NHpBLYB7nNxAMD+sHlddLgYjWRR
         8tC0n9xKMQSs6/d/xOdXfq6PCEyNL64866EBayqJmmkcTesBZDYoNWEljnX6/F1+kaX9
         9yt7ah4iZadaN20JG/JINWTWzelydeDEu9DjRNJel6mtRNA3PvrCPOQtIpN3pgy9jgtO
         R8tA==
X-Forwarded-Encrypted: i=1; AJvYcCWwmBrKl1WSRE2X2zUO8npm0CDhTHHafKb6A7RROqdPJDs/M4jy5kmc5uLY/ZGx+J40070=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCb96rzXKW0ESbINQRuBHq2TNLa3X1z1VXgq87I9xgD99Ca1UK
	T7tRZ5v9ZrJo5ahw3oGYcIDePStrgEZwt7De0luaTNyRccMSbk7YpSZK
X-Gm-Gg: AY/fxX7fqnsxMYNR9SdRIyVOaomZjZ+bu2/fm/Fm8XYlprgGBZVmBb9pSfN3vWzrTbs
	zN6MJ/snXfzXCiqi6KiRWgL+ieUwNCMoKN9nSI64kX6KSiaDnTFeWPIKAcyVCCFX1SqJuQWJ3M1
	+oF8ZjoUik+YEubEYbc49D8tumW6Nz3CdYZnuSIlEBWjnKS8Aqy8okrXd4t1LggK+cYhTLn4amo
	YE2dWWks0q6zbkeif0i+0eX24Hc33h/q4eTpDDzcqDtT1ziYIHH2a3LFxKaWCuVFgro8/7vo8E3
	x+P2JPtHZI4ThY4Ffpnyah3R/LJAuJymrrAt/3c/1xMJOVhQ04xRM/E8jKIskV/5VqVGg7x4EFu
	LdLNqSsBLLGaJrvKI3okBq4+QnIMeQCelh4xm3YK2hgZfe2oKBO31UdZLlsyniT/Dr6RI6HlFgo
	dF794VrHKo
X-Google-Smtp-Source: AGHT+IFF1TvMbOgaX/N9aJcylJ0T2NIr4wu4xOMd9UY4g2QQhOhOrjjeZfuwhQiKW+MVRe5SVusfOA==
X-Received: by 2002:a17:902:c403:b0:29d:9db2:f833 with SMTP id d9443c01a7336-29f23b77308mr169678295ad.25.1765924556078;
        Tue, 16 Dec 2025 14:35:56 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f13d6a887sm148193835ad.91.2025.12.16.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:35:55 -0800 (PST)
Message-ID: <4b12236c974db52ea19985cc9c5e08e021db9ec1.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 14:35:52 -0800
In-Reply-To: <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
	 <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
	 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
	 <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
	 <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
	 <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com>
	 <26e95f737d2de5133702c9b641946e70ec2d1dae.camel@gmail.com>
	 <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 14:23 -0800, Andrii Nakryiko wrote:

[...]

> Ok, so what you are saying is that if there is layout info we should
> always use that instead of hard-coded knowledge about kind layout,
> right? Ok, I can agree to that, but see note about extensibility
> below.
>
> But that's a bit different from validating that the recorded layout
> of, say, BTF_KIND_STRUCT is what we expect (sizeof(struct btf_type) +
> vlen * sizeof(struct btf_member)). Because if we enforce that, then we
> still preclude any extensions to those layouts in the future. And if
> we do that, what's the point of looking at layout info for kinds we do
> know about?

If full flexibility is allowed, then all places where e.g. libbpf
iterates params or struct members require an update. That's a big
change.

I suggested checking layout sizes for existing types as a half-measure
allowing to avoid such changes.

> > Given that BTF rewrites would only be unsound in presence of unknown
> > types the whole feature looks questionable to me.
>=20
> What are those "BTF rewrites" you are referring to? I'm getting a bit
> lost in this discussion, tbh.

E.g. btf__permute(), as it will not permute all types if some of the
are unknown. Or dedup.

> This feature is designed to allow introducing new (presumably,
> optional) kinds and not break older versions of libbpf/bpftool to at
> least be able to dump known contents. Does the current implementation
> achieve that goal? What other goals do you think this feature should
> support?

I don't think anything other than dump is possible to support.

[...]

