Return-Path: <bpf+bounces-66458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B07B34D7E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27681A87DBB
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF028A73A;
	Mon, 25 Aug 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bslVZ2OQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679028F1
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155923; cv=none; b=GR0kuNgEBIouIEQdyox7uJ2vPI8EVDvVldikRQAyIW4sQnep7qbsKa7Av+AY1/mUGp3+vh/1c+Xa/zUrcODWSgflDSiYMSBHhz8eFU8UTCnyieyejw8qX4RepVF9zr8bZChE/yJRUhQL6kpLFU5MTWh3upQNNIPERXMdMA6hOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155923; c=relaxed/simple;
	bh=Yo7UqxsIS/Yn1FdeMxMNeaYYhgl7EwTAgSRLBOiEhNw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFH+MzkNlsgtxqkEEMtyq1udcpkGlSMe9/5ltoLIf+7pFQ6wLKDX3jXHw4Syh7uZEDdkJ81GVnKWu8PBvttoAql50higdrjPK+0DK+s5m6uSsc/XLcMAyNsJ2xz4OwabpFjYEyHfPGERGmEWeZvU/8AUDq9GZA+QTSV3XrFDWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bslVZ2OQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4256681b3a.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756155921; x=1756760721; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91jCLlnGS9pE4TDLj3Hj2hz7V9CUEdyaHTu2n1p5Kt0=;
        b=bslVZ2OQz0Dh0vmS/gB0sduq5wsiLohy//aWSfWdkg4S03KRQ/IRXMfvQwcLJOV6/2
         KpyvlwUVrvkRiy83YGrL5l+3uY8IG+6AbVu+VcNQkwwQjyltqs2bFYCWVjeLkHBOTp8m
         4Py+fMCWG/ktqcfAbZvWjDDo+FBgh6i72Ghque1liBUozUpi9fM5khqVkBTvKsH5E35O
         LY/fItqLzNN7/FQYu8r9j03R/sgFJlZYN60p2x6L1nkl8PqvExTVEbhJCH3pfR7PAuO9
         Iq1nf1JpPKIfDnB7mh0uLYALfp02XNHPXjS6wZ5hGyI3WDwYkn8aKaInWUYAjn+jysZt
         7pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756155921; x=1756760721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91jCLlnGS9pE4TDLj3Hj2hz7V9CUEdyaHTu2n1p5Kt0=;
        b=YzUdlXdJ1lhhgBqNhjAUc8uFSaJywnsLjqmhbnxWw2wG+Zg7PafrMpO6HJBZoEEtZg
         BrczS3lFxqHJ94J5D5+CBUvgfuas1h4TL566kqOjWpzPTAVu2Ppzreva+SvaqETpxV7k
         z4R1Jj3QRiqPRirRNtdQb21OX9DYpm8mDsjrqekgPRV+supbVS+j1z0JMxfp089kkFvX
         o8G5mbpf77gALtATykihT53BHqiyLqIFcn3O7VralXY9DYOSNLsbHZ+04Thv/2S951/9
         tPTeCpnaQMjx3WT+x/QTxpYNGcz92ElxA7V9417kMFvJQBDu4W1dHRs04JZ8dL1MIgIL
         qUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfieT4NOZq5EjCc6fNZMCzFVZjsIGXFsgr0QEoU44zQXTlnIk5H+6PIO755Js5ZexZ9ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiqtzU4RUt6sZ1/d044LPQMd/tq0hPOh7ACI69slvDZUmxBXwc
	QuTwndWDBmUbBaZIaZG5wiHojWV+wsTGGrmURWZVapXXghz+ETdMhFTj
X-Gm-Gg: ASbGncv1KQgGbdryacMT6Og6PQlirO4rKbS2NRj9bbGh0UvmN5t9hPPQksunXHU1ORJ
	ZFZ54GaVbs06gPBgqw/CzWcLoZuackI8TYxofvtezAxeoJT8y+R7RAvFwXm3pu1lXe5uGtC0wkK
	kX2w/2RY3MddZIg4AEfnils08x/wNKyKBL1NaGmYMEsw5399lqvan2Dk4E42jjtZ27tFnJ9JGLJ
	SHoU1vetgNv+uy/1Hb8MreiJc3Xx+JFbFfzAI8HtUP7r7PIvgUkHPHb/Y6yon9hE3B+jM/PbWub
	HTnKCU17T7WtYQA3aUUE3fGN0dcpxGOtGL+pp/N5P8MGRUY/y0qMogU0X8CXK/UJOJi4zJ27lGO
	juHs+0Hun2zpvxZTFKjPXJfZVSXeb3unHwe2P6RA=
X-Google-Smtp-Source: AGHT+IGs09eGNkeIUAwPyP3vTezl45obzB4faO7VL5HEAE31kPiDkLfWkRyMYPeiQqJdsibwFMl4Zg==
X-Received: by 2002:a05:6a00:3a21:b0:76b:f73a:4457 with SMTP id d2e1a72fcca58-7702fa091b6mr20787270b3a.6.1756155921516;
        Mon, 25 Aug 2025 14:05:21 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:299c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb8229sm8366526b3a.10.2025.08.25.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:05:21 -0700 (PDT)
Message-ID: <8443ca8f17708fa22a3f3b60018513735b6dff5b.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 03/11] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 25 Aug 2025 14:05:19 -0700
In-Reply-To: <20250816180631.952085-4-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-4-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:

[...]

> --- /dev/null
> +++ b/kernel/bpf/bpf_insn_array.c

[...]

> +int bpf_insn_array_ready(struct bpf_map *map)
> +{
> +	struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +	guard(mutex)(&insn_array->state_mutex);
> +	int i;
> +
> +	for (i =3D 0; i < map->max_entries; i++) {
> +		if (insn_array->ptrs[i].user_value.xlated_off =3D=3D INSN_DELETED)
> +			continue;
> +		if (!insn_array->ips[i]) {
> +			/*
> +			 * Set the map free on failure; the program owning it
> +			 * might be re-loaded with different log level
> +			 */
> +			insn_array->state =3D INSN_ARRAY_STATE_FREE;
> +			return -EFAULT;

This shouldn't happen, right?
If so, maybe use verifier_bug here with some description?
(and move bpf_insn_array_ready() call to verifier.c:bpf_check(),
 so that the log pointer is available).

> +		}
> +	}
> +
> +	insn_array->state =3D INSN_ARRAY_STATE_READY;
> +	return 0;
> +}

[...]

