Return-Path: <bpf+bounces-32321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7065C90B860
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 19:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E71F22E72
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FC91891D9;
	Mon, 17 Jun 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNlQZZau"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC201891D3
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646170; cv=none; b=CtMoT9GoUSFLqWZM1yiaEAK3VPc2ACkELf15LLr1fkpK4pXmZDpViGmHdT2dIZdpcUyzsdUZ2lJNDXogRbb8v9aKsvYNqEhLZpwQ/noKt84r4fnlmdbodho4gA0GVdfp9w4wo0yd9CAJhcW5ICR9BqE9edyFwup/6ATvrU01Ohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646170; c=relaxed/simple;
	bh=iTA6tMWoM24GoylsTeEjPK/IflxNC9uS/jEpaXnlqcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ft84NNKzflua6+OCJ+vyKr5ZhWELEntqLBltG7mzNLP0Mz5s+AzxP4Dvr0a3WxS9fhMR8uI9t4hquG/UHigBizZvo6hdTJ+KjK8izx+M+FC7V8/cOo59+r/GRSiXKzC9GfkvXj+Zo7yyEdd8Y2zOUGzhhvp04BpWqv+BaYSm1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNlQZZau; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6f031549bso40799355ad.3
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718646168; x=1719250968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UH6jen21XMe1+or6OOrjBzMHxIqu9X2HqC6nM86B99c=;
        b=mNlQZZauSh8jEK9BJjDzUDi9gx/VCnXPwzv13AllUMj3yu14hRHHbknbbLTRyNNknC
         iYOYsm0UgyhlxQQZTD5UlP8XwT90eqKv+Chn2xtqRwrDtNLxVknOtY5ximj4W9id3F6s
         Z4s46X79YRFeO1+iEpDEPlMKAHEg/jcYZU1zOfklsXqFXH/xH6td6QuqsERW9xu/yqFi
         OWgO47ior10xhDRB2tNLUg8swtp+hAqx+S2JPm/WVHSpVZTx/gVwCiWi/5THkZnNdZTW
         aYZzM53RXA28yfjPRTC1tA3bKn2GbcIRbHcVN8ZGQUbrIkM+AxZx2stpuZfXz/kgFsMy
         EOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718646168; x=1719250968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UH6jen21XMe1+or6OOrjBzMHxIqu9X2HqC6nM86B99c=;
        b=Qr6vDyqqgQuHCS0FM8Zl8re0wPxtNKjauZTCVBkrr54hQbhXWVrwHU99wBMGIm/yka
         /FWVBgYdImjqUKyKCeSrvkgY0qvFt0TEQf+bQi6sGiKHxLuu+9shAtVYglD68m1MdFJH
         HF77v2OB/QmAQXm/o2WCTR+5OV5gbE4WzbHLaVAh2VhJjIg4I4FEhpizK44ELOECv6wV
         t6N04P57MaeHPGKgmr26RcMTNbJBXYyZRKqD9ToRm/LnPKgEdbL01pRGFP62ISqPFsZU
         mBsb7avbqNjLYnc0pXzdOnR30Uh/95Dbs9DL5xihVW6sw76+grE/LtjXmI5GUsCs7b5v
         GdGA==
X-Forwarded-Encrypted: i=1; AJvYcCXsf8q3qb4aBw8Mzg8tqVRMefT6QlhtXsuFUMndCkhw5VEUtliRBh3KUVVJimk5+ewjFl8KBxG+2XFE0XUVdGuC09J8
X-Gm-Message-State: AOJu0YyGCViCNfE9ka48guoC5lw4Nky7F7C2ck5m+T+dpxxEHxTTsmVy
	wFNNRoeIu5+2pDcGkuY0Xpydi5zeUVwk+gwokKNsArT2WU2erMuj
X-Google-Smtp-Source: AGHT+IGdzOh8SHBWbE99eqYWCGbktIaYjdHvqTMDqEejJk61hqdjW5zYg6kyYq9hLsBaXXZDK/3esw==
X-Received: by 2002:a17:903:41c7:b0:1f7:2849:184c with SMTP id d9443c01a7336-1f8625c64d4mr130775175ad.6.1718646168093;
        Mon, 17 Jun 2024 10:42:48 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f2e281sm81807915ad.254.2024.06.17.10.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 10:42:47 -0700 (PDT)
Message-ID: <aa7e01fa40841bc839ecbea6620c39ffc617dd10.camel@gmail.com>
Subject: Re: [PATCH bpf 0/3] bpf: Fix missed var_off related to movsx in
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 17 Jun 2024 10:42:42 -0700
In-Reply-To: <20240615174621.3994321-1-yonghong.song@linux.dev>
References: <20240615174621.3994321-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 10:46 -0700, Yonghong Song wrote:
> Zac reported a verification issue ([1]) where verification unexpectedly s=
ucceeded.
> This is due to missing proper var_off setting in verifier related to
> movsx insn. I found another similar issue as well. This patch set fixed
> both problems and added three inline asm tests to test these fixes.
>=20
>   [1] https://lore.kernel.org/bpf/CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGB=
A72tpg5Xoykw@mail.gmail.com/
>=20
> Yonghong Song (3):
>   bpf: Add missed var_off setting in set_sext32_default_val()
>   bpf: Add missed var_off setting in coerce_subreg_to_size_sx()
>   selftests/bpf: Add a few tests to cover

All looks good, tests cover both patches.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

