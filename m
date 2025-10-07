Return-Path: <bpf+bounces-70548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33FBC2D92
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 00:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2EB3A9E7F
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 22:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9425A2BB;
	Tue,  7 Oct 2025 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnj0YDmZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127582441A6
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875395; cv=none; b=qwu90WqJw7iolplQuMCiuo0GNBS6zmvRXMVWp2SaWdqYc3DEC/s4ignJf4j16KQUO1Lez2Z1L7Nj3StpXpxCS52Tm4ROzv3AkfVmmHAnWWHI24hY1eby8k6xHwRDDT+FeMvksGZ7QHRNedrfT0k5NcjNHYr2P3Yj861YjSXfm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875395; c=relaxed/simple;
	bh=PfPm2PDr+Yv+Jq8RFu1Xe/Vre6LI0xWe7Y1eqZTzpwo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iU/xGsknmoZ7j/4rRyDjhEd4ZkxK7aTvVJB9A7XkYu3gakwLPRwMJNu4a+mg9KwWrZXlpe8F+fJ2oNIRznmwkhUv1P7w+zTjy2I4ie+eHLZxTkhjMEpRx4ZiTP2e32l8DszW4erzkEjzYdqj3TkxDg/yWcuuD0UQtwL0NKqP1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnj0YDmZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8983582b3a.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759875393; x=1760480193; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xzF29J4G8Z/A+OjoSK//EYOMjWTz6udya17Lbfuay60=;
        b=Nnj0YDmZu+drfwMwa4LKNppvYSoUWd076w1CZYRTVoIqiaVPX/0RTiKyvdd4SdHShe
         Yb30L4oDYGIB07Wj3NzxnKWU30026CDmVzZo2vzuqKX5R5pUBuEG/p43yuivaqOJ+Dea
         NVhFhTI3GR3d0aLkb8H3u4IzlEFlamR/5Cv0BvLF3zla06ZVZTQqRXIXJr7vmeMhBpfb
         vccbgCA6oez1u/91VXCyAlukN3U5oohK4wV0kiKVoQL4F7bWxfkQqi4TCqeYuwo129Vz
         lTVrmPWAPTLJK4lvSD9h84GlB2ZbLVIQU95TJfFoOoqMF6t0AIUJSj2pISYma6JmoCWU
         Yhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875393; x=1760480193;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzF29J4G8Z/A+OjoSK//EYOMjWTz6udya17Lbfuay60=;
        b=Sj5dZtOxbnix9lSJcTMkPyE5HRlF9A+YtLIPHUfkHuIQY8q0gHL3uC2dM56opYR1HA
         vmY1b1tI6Jl8Cyv8+kQ4NtnccDPquZoRjZX3HjjfZKWeQ8ROk3RskLLFKBeY8ODlXnQC
         kDiS+5Tjf8JsHNFaR/QgXEgNGXW2YKyC8urW9qv7plaCCuawpWRNoPEDwi5yl0bubLES
         p08q48oGPnH9qgGcu17eHj1U2SwJuSuVW/lC/gBsQp6fVqTFdEsm1dmIpYneCQWcFU/w
         NAo9slqHGBFmztIXxUK2wEZPo5kk2hQPoNKlYKLuj7YDkwvsOgWPGWjCnVRoysbjOW57
         cYDA==
X-Forwarded-Encrypted: i=1; AJvYcCVtg8laDTUYZcqUVYjV7SUs49R7Wi8bDXnUyHjb4blrmxJnGp3+tBpdRH+EEAM+UsLdTck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31Laz0A8Nep46QBK6NFsgL/3Pg3ovTdpvLXwHWBgUoAIpx20E
	lzaYK7fOfBCuDv75T8MsO+A03hXYQfFQXrUzasF/m4y1Jx9KI0V4Gz6E
X-Gm-Gg: ASbGncsj1DVcE/P+UIfH2j11m4vp4zTZT+/GXitLUlTY/AbBPlWSRZni38jD3mMIyJy
	XUESBO5pH+qKDabvM6y/CUuJikBnVk0xG386wP02FriMW5utDbLEttBmfd5YA0C6JFHwpEeoV4+
	c0oa2y0kZnmb4G4/hZNdr7LAvpwhNbd3MZ9dGhf3BiopC3WFRVxDQRe0HfD6Am+VcpIOnk1DfV9
	6HKep+260bktniynqxZN7cV/BMXxENV6Lswpr8qJmlryKWlnhzzo+ohWSzAXW6yLdorIcgA62tt
	d8MJDezHMiAP9y2wi71ot0clZNR4ArJ9FrMhGlu/8TNKhGshSLil4Y/sNwzb6Kn4KYFQHyUOsua
	waBOcCo8eFxKVdkkAyfcT56PaOqu9Ys7l7HIGfV5wkWPgNThUQRMSI3UcX9r/DwEHMkR6RPY0
X-Google-Smtp-Source: AGHT+IH+hnAxTGz76bbcqRUiN2z79AijpRf2YSP+LG9f8Eb4UUqDInrbF5yof6GPuHUci77wYdwi8w==
X-Received: by 2002:a05:6a20:2589:b0:2d3:8d14:7fcc with SMTP id adf61e73a8af0-32da80c4a7cmr1309034637.6.1759875393157;
        Tue, 07 Oct 2025 15:16:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1d27sm16877912b3a.36.2025.10.07.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:16:32 -0700 (PDT)
Message-ID: <cfdb482d1b4b59f49cfedd76957f24aa9fcc5152.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Refactor storage_get_func_atomic
 to generic non_sleepable flag
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>,
 kkd@meta.com, kernel-team@meta.com
Date: Tue, 07 Oct 2025 15:16:31 -0700
In-Reply-To: <20251007220349.3852807-3-memxor@gmail.com>
References: <20251007220349.3852807-1-memxor@gmail.com>
	 <20251007220349.3852807-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 22:03 +0000, Kumar Kartikeya Dwivedi wrote:
> Rename the storage_get_func_atomic flag to a more generic non_sleepable
> flag that tracks whether a helper or kfunc may be called from a
> non-sleepable context. This makes the flag more broadly applicable
> beyond just storage_get helpers. See [0] for more context.
>=20
> The flag is now set unconditionally for all helpers and kfuncs when:
> - RCU critical section is active.
> - Preemption is disabled.
> - IRQs are disabled.
> - In a non-sleepable context within a sleepable program (e.g., timer
>   callbacks), which is indicated by !in_sleepable().
>=20
> Previously, the flag was only set for storage_get helpers in these
> contexts. With this change, it can be used by any code that needs to
> differentiate between sleepable and non-sleepable contexts at the
> per-instruction level.
>=20
> The existing usage in do_misc_fixups() for storage_get helpers is
> preserved by checking is_storage_get_function() before using the flag.
>=20
>   [0]: https://lore.kernel.org/bpf/CAP01T76cbaNi4p-y8E0sjE2NXSra2S=3DUja8=
G4hSQDu_SbXxREQ@mail.gmail.com
>=20
> Cc: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

