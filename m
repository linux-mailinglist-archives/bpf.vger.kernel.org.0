Return-Path: <bpf+bounces-76620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 893F8CBF2D9
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05F233048E61
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96D33C1A2;
	Mon, 15 Dec 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="0s4n8mJL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2733C19F
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818490; cv=none; b=dgV7+GbJETOLt4GHlXLWLlHDGdcpgAdkFOQ+6jkKMvIIvscgjVgosenTQ0HcMGAcQ0PZ0xAwIdHdf/fIqKtGqoXwwNt0sEHcomtj57F516DEz+mW21dkvxZPXjW85onjZuL9ddNqJHkoaQOwztkp6LA4Li1TlspytW/dfhXijeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818490; c=relaxed/simple;
	bh=P8x89JGQ6EkG85mESpv8xTzSQ0N7s+t4Ji+MK6LIjjM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XkBns29mkuSvsqXVLkshxuhmZYiVmDf7fRUYKW+0OEJXBEHS5PawSJfFQ8gDwpXR0U3WX0CXYxce7nTyAqhs/IgNm63DizBE62H0/3oHefrybG2bxPhaBq3WRT+pYP+AA3bjpWgS6U7xQHTg5eUy67g6mGFmEWO7g8GqFhpJjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=0s4n8mJL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee2293e6a2so30826951cf.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 09:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765818487; x=1766423287; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEy6ZHxuqOWIs4RUu9umVm8kZ4sgB/WJK3wQzoMX7ug=;
        b=0s4n8mJLIVUIMVIMsExtGnPilen2buWjXk7sJSgO60O9Ey1BolyzpuMdI4raWYTQ1V
         SUaiZ3HJIqdO/Yf4loMEPa1VL4ql0XmaXdk+XKBIzEpS6hxc/DsmSD/ew4f+TnuHToxm
         bo5ONcjm74/qv9KLRUmN+T/cr0VxnFQC3hwMiKu2i4/N0RUEt0CLbjimE4+Hxwuiw536
         jkVJqauw72EUgktABE5vT0YG501i1lRogyxpU+lfONP6NRy2KlBsS0lbZYs7tKf6nB7N
         mZjFA84BhFxRtEizRlY9/OsiO+P9yHScKFijQQJvYFhZWbdi1VALU5f4NhYnTaoSkMbF
         oyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818487; x=1766423287;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEy6ZHxuqOWIs4RUu9umVm8kZ4sgB/WJK3wQzoMX7ug=;
        b=TNRci+BdYKuHTQ7dPFkwbAMuiNjnqzRzjL3BG8eRRjkMmnATgeoBp+urS2qxglZgK/
         71QRf0NEBZXqmOaSzfp6uHFM3jQDYLY0p8LRazf19vBmW+UTEvvqJDa93yrNzHmSeyej
         KD2hoK2yf0fYAdrdnM7DKeajFJWlLGAj6RR64xTW/FrCJWugzlhESwH/V3cBiQ5VqGvx
         Zq2seZl7EZHAAN6JA6nLnvfUsaKCpcTWzucZ2euNNrRaXd4VlpwwOlxNUCm522o8kMaw
         4Wfp9QrRvXisuoBXyqfdJ0+vvIIsGui/jTJnv29KPOsuobD5r0tc9w5VILpC1kKGaiMR
         JxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGrZ55J67vIItqjQuaxycrbHEk3dtYMX5Q+TWrU1F8WIXcX3aDwkk0ZrZHWqQY0dhzYME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZjA6h97KaDheC1meM7VaAxIz+PHuww0pYWLEADk0f1wsjtbJ
	9nppHlk3gfdfq7rbUTtd+F7E8XmwwZvJ4HQbcNAwvvb0ZmSOLbxDRxG+rqRRqKnFo2I=
X-Gm-Gg: AY/fxX5rQrzwsWeu+y/np89c7APpgs76Q/et6fbVw1X5TkiWSe7JkGw6gb5vUftdXcS
	MhdSPOu9zK+bYMnFCMrpp5+1wp9aBYlb6zmLMrmvJRIYKMiYxc2eR/dXz9pOg6X105duAYO2Psl
	ojhqFWaqJ1FarvYnw+wcmR13w61xHXbsF1Lp6FcPbdHw3DYTkdkEnnDzgURbcNVdJogMOO4TcHI
	kv1NTgx8o7BiVH/z2DYSlh/3ebedzV+1BoYnjHNfeZN7zn5eJxGhd7hXk9CaQr1TNhNeZaSCvh4
	Rl5Gg8ZwVnUo5yp/CCHHAmXfeRkPROXwpA3PxjeukRZpfrdpMg0BsgophElwwGtrcEZFHUhLknk
	sfQN/q1Ot79WVllywq+UBj9gE7g+51hr8t35ypfbS02A6gpK27GiyuL+TRzmCZBiDYHwynVGbnL
	vIWOh2jajQx5Y=
X-Google-Smtp-Source: AGHT+IG27V15SzVKFaStiHsEAxP99TY7J31t+O4n7muTdk2q8wyspBScNxfYYc07eSlZNvFebvirVA==
X-Received: by 2002:ac8:7d8c:0:b0:4ee:418a:73d0 with SMTP id d75a77b69052e-4f1d0626227mr168092861cf.64.1765818486850;
        Mon, 15 Dec 2025 09:08:06 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f1bd70a4adsm95299141cf.32.2025.12.15.09.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 12:08:05 -0500
Message-Id: <DEYYET8EY784.ZN1JWGL84JWG@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <memxor@gmail.com>,
 <yonghong.song@linux.dev>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v3 3/5] libbpf: turn relo_core->sym_off unsigned
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20251215161313.10120-4-emil@etsalapatis.com>
 <9ddeb4c102ee96af6b969ca2894438e94c20e6ac1781a25928b0a5a76ec8702b@mail.kernel.org>
In-Reply-To: <9ddeb4c102ee96af6b969ca2894438e94c20e6ac1781a25928b0a5a76ec8702b@mail.kernel.org>

On Mon Dec 15, 2025 at 11:37 AM EST, bot+bpf-ci wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index c7c79014d46c..5e66bbc2ab85 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -380,7 +380,7 @@ struct reloc_desc {
>>  		const struct bpf_core_relo *core_relo; /* used when type =3D=3D RELO_=
CORE */
>>  		struct {
>>  			int map_idx;
>> -			int sym_off;
>> +			unsigned int sym_off;
>>  			/*
>>  			 * The following two fields can be unionized, as the
>>  			 * ext_idx field is used for extern symbols, and the
>> @@ -763,7 +763,7 @@ struct bpf_object {
>>
>>  	struct {
>>  		struct bpf_program *prog;
>> -		int sym_off;
>> +		unsigned int sym_off;
>>  		int fd;
>>  	} *jumptable_maps;
>>  	size_t jumptable_map_cnt;
>
> The field type change looks correct, but does create_jt_map() defeat
> the purpose of this patch? That function declares a local variable
> "int sym_off" that immediately converts the unsigned field back to
> signed. When sym_off is >=3D 2GiB (the exact scenario this patch enables)=
,
> the local variable will interpret it as negative, causing incorrect
> behavior in the modulo check, bounds check, and pointer arithmetic that
> follow.
>
>

The jumptable relocations handled by create_jt_map() don't have their
symbol offset artificially inflated they way we do for symbols in the
arena section, so keeping the sym_off signed inside create_jt_map()=20
should not cause a problem. We should still change it to handle
sym_off consistently across the codebase.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/202395=
24817


