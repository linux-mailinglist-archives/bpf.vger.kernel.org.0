Return-Path: <bpf+bounces-67656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC5AB46715
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 01:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46891CC6F4B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD6288C36;
	Fri,  5 Sep 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyFcBi4w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32022550AF
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114366; cv=none; b=EJTvq5khznT+N6XEN8vJj8qpXw2RtQVi00y6XZVZdQrXSy3GmAt1Px+8OAehtMosWta+kwoIwpDo6lFA97JNEoY/03mBoLs9x6pd7PJlNNlD49o0Htcd/jKLEajiUYKmkkOk/SPSo07WOhCz9AZ1CRAobBxKr8+bBUHH969scKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114366; c=relaxed/simple;
	bh=aEmIO/htj4VOpMlWosP8EZ//6ya1Pg7geIBY3G5gl74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayAvQplWdSFn3IRRruI4v1N1I2gD0BU9BSF5Krg6vQk7tMzvhgOcl/a1tE3o1le8w5yC3ykk2HvyR61HE8gbv/ON4U9r+3m8yKiJJ5bceGF3v0wow561MSrJ82F6Q8n/L2CvWQE1GWfF45LXjKTeURslvzTs9M2+xH1YKtz63pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyFcBi4w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248df8d82e2so28861835ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757114364; x=1757719164; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cMWz80axYlQRk7JHOzFiM799ojvMx/FC7V7ZhbRtgMc=;
        b=EyFcBi4wCLx5/JZo4E5sV2Bvxh41IiB0rsdi5tim1jqTui9OtkUKCVFYHmKZJO+aaM
         W+KHlkd+ZjX2fJ0PMLxwPh5MfsGkPhPUk5qvfAZADbeM7dDo5QBijRy8zP1V9twi+Hzo
         jDMtvyM6Hemcto9GpMQjAMvPRJoNXttj/95lfLFtvRjBqa+noRfnZi/5RZ3vmMgac6bg
         syjBIG+hueJUSr/a5Jyx0UXKRKBYrbQAptGOBBZGc/ZxfBLXCG3VhS2GYAVUjVO9hLlm
         CDNfe0AvLnkjxO+R52n8Q3eoo45mmIhJ10U8mBzwbdsIF2/s9eykit32CFeREB8LoH9X
         IH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757114364; x=1757719164;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMWz80axYlQRk7JHOzFiM799ojvMx/FC7V7ZhbRtgMc=;
        b=icLZ1dIxAUe80HS7JKuej02AA8UuRQ8UwyDNtNwyh+FVhhxxLpVKDlUYKiCtyiF/UG
         prANoU14G2WomIuoCbRvP2ennBg98ZRqn9ZiX/KbERQGWsIUMpeMUFJFSDgMg4FWq0OT
         /IydgvJ8T1xcJUfhmPmcirNNgwT1KBJDVSh4d2SM+ZQK6lFQ6aOX5l3ilxra2KCbZNSQ
         2ILTFYXjPjVeO12B30YMMRpD57HMAEbeKqWNWyf7pDdb07GntbmP2qqGaVSUM6Oxoa1b
         y2NPGh4hyTZicz6Ry/CpabWAyaHpx3YAuIsypT+ELsRjF3/SQwX0IZcsebv/g+5TjYiz
         7S+g==
X-Forwarded-Encrypted: i=1; AJvYcCVpkiXSWjxSpXKEpQhaSUWn5hq8j9sLOoiYiAYnB7yHEShjM+WP3auQjpZ4fzUVw6Fgf8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvxb6DexwUZ3JAdh26Czxluza8WDrB6JBY1I5xciQ0+2+P2XSa
	/+QFMDlfcD/Af58w3OI5BRbDWv55wmefGMq6EEj2pSa7v7OulyvnOnpF
X-Gm-Gg: ASbGncsyq88jNFjgl9m+A/RfGyt9DQyZdr5n6hFrx5zidpM2fRbAr2Zh2KLJNUH2CZz
	qwY3oWr3L3Bn9L0LpZFdbpx9TKFwn2Wy+IrGUKauW6aJjHgy41xZRzcYgcv89c66af6JIMftbu5
	Oz1udFxdemx9x/kUzbaeAdG20cJefv0D+vKxwI1L/FabLFx/s1TUxBXKAmpMIGYu+nGl2UpC3pb
	n3cSRT9bIgRowW2dmcEJ/ZBpKpwfjhteawPoHvTp3iMW6lopI2cz0HzlqeQOSzvTEh5uccVhg6K
	46iPKuhzwnASnDkfyzG7UgtV2RcWO04NBLoFB3f895GvgH3S3yVc70jKeJzTEhqD1B3PKfESoqD
	L5bWxunuORIrAq25K4FzRFPYsDO/K
X-Google-Smtp-Source: AGHT+IHu7nEAyBTFTWE21IeIWXB0LxRv732ZiQX724VSmwY8uzUnR/vudxhhVWD/SqFnblSB7IOc1A==
X-Received: by 2002:a17:902:ea06:b0:24c:e6fa:2a3b with SMTP id d9443c01a7336-25170e41037mr4702205ad.38.1757114364058;
        Fri, 05 Sep 2025 16:19:24 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1589e4b7sm110705655ad.43.2025.09.05.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:19:23 -0700 (PDT)
Message-ID: <453b077245a1d42385f00ae9a30916e88b07164b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] bpf: extract map key pointer calculation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 16:19:19 -0700
In-Reply-To: <20250905164508.1489482-6-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-6-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:

[...]

> +static void *map_key_from_value(struct bpf_map *map, void *value, u32 *a=
rr_idx)

`arr_idx` is unused at every call site of this function.
And even if it was used, why both set through pointer and return same value=
?

> +{
> +	if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> +		struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> +
> +		*arr_idx =3D ((char *)value - array->value) / array->elem_size;
> +		return arr_idx;
> +	}
> +	BUG_ON(map->map_type !=3D BPF_MAP_TYPE_HASH && map->map_type !=3D BPF_M=
AP_TYPE_LRU_HASH);
> +	return (void *)value - round_up(map->key_size, 8);
> +}
> +

[...]

