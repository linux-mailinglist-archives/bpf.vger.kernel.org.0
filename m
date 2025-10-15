Return-Path: <bpf+bounces-71054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA38BE0C27
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 23:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D032C345780
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02DE2D24B0;
	Wed, 15 Oct 2025 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHb+43kr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF31E51E1
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562472; cv=none; b=ro2GQbqD/1/nlZU+VcZFQGCKKSUj1qKUzZ0K6KRaTorTM1BewmrAxw3YL8bvMApICxBBTQc9Oz9y46MCJm9VeQHYjeHWglePr8Vw9BOg1sbfsINvWxi8SvwLZIUqs1eaH8SvhTzAcOkXf4dmBfFiVUur7NTp8i+fkECm4VaDNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562472; c=relaxed/simple;
	bh=oXR27VxjUW6E8rQSNtQk/jotpHKBdifxSTOP/JizY8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gfier2qbw+K7E5+1fxDeNVFGt0Dir8kmzALLmrqNzess1BCURJaD5VW9Tcf9RKaFNYD4GweA4RiPaPvI5cvcwiKwupnuWrwJxFfDEPST6Um0ltstQzcUR0qNVN21oD1wuO3YbFIBVqb5AHBvRtq6/a4F2xS7yTIkyeDac7MeXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHb+43kr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so26660a91.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562470; x=1761167270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G1M7H5HaEM2GPUT+GyoIFlGfee93IbbYJvE03m1Iy4Q=;
        b=UHb+43krBNOJbgI4oq85zgFc3t31NIOsapURUr+HEbbCAOUMhRt4GzzU1lTBuk8351
         NfKKuq/P5NzchxMJ/o1HAV4r/3PLJdTcou2O8P+K0RcVpI2QnBj3v1o5UIVFjD1c7UTs
         5grwLvdDqOtflpMUwhHroE6YjWSeeUwbU70HVdYFIgh8/vsIfOPcOMVWJnpocIv2bmep
         kz2ieVKrJ0L6q7yfMpgN4P7PNDVqgD6kr94MQGX3i91aKKz76xXUWqBdwuMD6UamHNhi
         6oGp4oe7GP1QFtbiOsKf4q2CnSrkyDJX78Xc1pdkgRTq/m61HRmHOwFefyAkCDuzPLaA
         5OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562470; x=1761167270;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1M7H5HaEM2GPUT+GyoIFlGfee93IbbYJvE03m1Iy4Q=;
        b=oBwxyfMa19Y5KHxROcKb7AnGCPuHauyuuQ77l38gEmynJ85bQRYT+jsD0oZWoKcfNg
         SyEJQkN3gkZYVcBwdMsi5UCvcWc/wWvJWIBSErTCPPOB1QXnicQ2E+heerDmqxfuXVrK
         Hz+IWGzycckri+N/maCsCIXpWxHpoqs4OBrUx8SlKgi8zbdLXxvo0k3mmQfjDHrlTDjq
         s1TbW58EZMZ/+yWjJZtqKzBLm0lqALf+1MWGwwaUx8B9+5BqzmXzDJEhD0Z/yKrRwDQ8
         hO8PzsxwVIKW55vSyHarytYR7iP68G1zJrElScJMmyFOm0BBg2SZYg8M+74MgAqxMZgH
         OxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVii4Ein8/usUGfqrgwLXFkj7bCwfYZEN91BLUdTuPlNB8+iEPx6hdpsaQYajO9jX7+lhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKGxETewbRgRuD4nBf3MauLpLU6Qwn7OeLxvQ5cV+5qgUFh9P
	v/v95p2cSuebomVUDFt681eQDRLsg1ez44rHXE03JAFxYQTe/4TIZpwT
X-Gm-Gg: ASbGnctJCsG4wfmvY6JI7G4xmWiU5YUUV0Lq8ViJqMNn4ce4VyYrjpSdRQXr7kRdspq
	4FEQ/oqRnzvX6jDHaeLEseH8PTX5sxHMP14xVjEOnFAquRBczVg/u3moVUebOM1weE81C+tMRld
	g8qbT8ELO/I3lMe31kHUJ0jWRTuIGiUgJ5uDwNYRQ07x3460MREBi1yERVuo5fuAj7VQhGe0uW1
	hwXQNo8vygHkCjVUQknuOD1PB4AC6WlaR1ajfA115Vy8qPP/o2jr10E8yO5ZN4AF56s9uiL2Vx/
	HLq/xE1M3DNGEyqLqiecRohtCW2AqVV93q5GF6ypYZJSBhCtro9o+aEbI3pCItJpJX7hgzW83a7
	9kJ/lCWSjPFWOJJ6zB/pck0tGeNlgpmRg9Idzgeg=
X-Google-Smtp-Source: AGHT+IEq+bw8yqULmbmSpWURzoh//8Q+vy7RvSjPs74+Brf+ZoRUuKyAqbSbPlEdGAnu5DltwjqZFw==
X-Received: by 2002:a17:90b:4fcc:b0:33b:6612:67ee with SMTP id 98e67ed59e1d1-33b6612716fmr25527527a91.26.1760562470103;
        Wed, 15 Oct 2025 14:07:50 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d7e4sm21167945a91.3.2025.10.15.14.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:07:49 -0700 (PDT)
Message-ID: <e7a28f6689af43e2f30c1e96b2f955e6183fc899.camel@gmail.com>
Subject: Re: [RFC PATCH v2 10/11] bpf: dispatch to sleepable file dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 14:07:47 -0700
In-Reply-To: <20251015161155.120148-11-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-11-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> File dynptr reads may sleep when the requested folios are not in
> the page cache. To avoid sleeping in non-sleepable contexts while still
> supporting valid sleepable use, given that dynptrs are non-sleepable by
> default, enable sleeping only when bpf_dynptr_from_file() is invoked
> from a sleepable context.
>=20
> This change:
>   * Introduces a sleepable constructor: bpf_dynptr_from_file_sleepable()
>   * Override non-sleepable constructor with sleepable if it's always
>   called in sleepable context
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -4337,6 +4337,11 @@ __bpf_kfunc int bpf_dynptr_from_file(struct file *=
file, u32 flags, struct bpf_dy
>  	return make_file_dynptr(file, flags, false, (struct bpf_dynptr_kern *)p=
tr__uninit);
>  }
> =20
> +int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags, struct =
bpf_dynptr *ptr__uninit)
> +{
> +	return make_file_dynptr(file, flags, true, (struct bpf_dynptr_kern *)pt=
r__uninit);
                                             ^^^^
		  Having may_sleep as a flag seems more logical,
		  but unfortunately, this will make the verifier's job much harder.
		  Hence, I think this patch is fine as it is.
> +}
> +
>  __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
>  {
>  	struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)dynptr;

[...]

