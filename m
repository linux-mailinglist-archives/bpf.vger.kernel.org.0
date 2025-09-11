Return-Path: <bpf+bounces-68181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3AB53AF7
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 20:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BD05637B0
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759702356BA;
	Thu, 11 Sep 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJvHoPrB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B21990A7
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613747; cv=none; b=LXIAZNEkBc8izrDHVa2vpEmLweSn4MYIm+vs+M05A8JsgPdM0sBhBhUi2vZPzw7wGR7Jly0jsDpadrQvw5dPk82NHPEvzRBjnrjAYwJk1m6O4SwczkmiujwB2gmCxfijKCmoamIJzYh5OL6zfUk1M8MwaNKIVg0uOuiHe6x5ZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613747; c=relaxed/simple;
	bh=m6nh+nAIDirljgUmS7AoFDFqrIUgIED7D3aZ95+tg9Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7z8c7J8h9aT5V5w6cenKe2KPJ0QCAYOMhzEQlJSDqu/0W9gFg2nDIZewRwPfYAprWxCMX0FAxeDQZQwvhdPMLyaHNGt+bhjYtYBxcReai8bnw3HQn1N9Mh5x1fZ7sC+tVq1Pd+SXC+1ELj3nlR00VRL8rbmjC8VVi0M4fOGyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJvHoPrB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7742adc1f25so703983b3a.2
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613745; x=1758218545; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6nh+nAIDirljgUmS7AoFDFqrIUgIED7D3aZ95+tg9Q=;
        b=mJvHoPrBPHIMn2p8TcLEJgLV7xy4UyvUX4R2N8F6YMhblFQZ2zzaH8y7Pwy+cxylNJ
         3qTlvDIcEkfCszGgfiOyslTnwLoffnIT1iAZ+BSfY6X71RTAFPTmzFxId09M5j7cKrlZ
         8NH7ZG+AHev/prh6mH/d6tthjpeElB+2RxVhhpLl5v6hv33TAan+EhN5SHX+2k1gFHaz
         Hp7MfmoeWA9ft3RIQA4DqeU3TOLqT5vZDb1ZBf9Yc/pWDhn9YvYTT/HQFIknQgwoohSo
         rBs/WK+uNzgxXBxof69iF5iS/JyVtKdFp4J/dFOuL8CLmTNU0xGZ/uxfHaN8QpB7IcTH
         RmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613745; x=1758218545;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6nh+nAIDirljgUmS7AoFDFqrIUgIED7D3aZ95+tg9Q=;
        b=EpVMSRAuao9lQdksA6IE5uQc0NNDBAM3lSUongJcwj2dU+XtL6JIElm/X5qi//TE7n
         vVarHERIVjbHfV3QmSftmZKQypaSce1zbj9e43Pi6Pka+PY6oUi+StAs6XjUuMFrdA5T
         xmfOps6I8o3gzrJfGtRI1OVHBWPqcoab5bixyx1M8xz9/IvAbcnRm10Lnng+xSLi9xBu
         AGgg0Lf6uRMI77BNfBHX+kI7WHTjB2sPQ1gRpPPdQbemW1gWrha14dIGqwLm0zbvyU/b
         7wCBWcO3yjIoQfCRp1Hl7D8pXDFuDsNFiO9vdbNaFU9YdBtN2W9cHsxYndK8gOP8xM/A
         LRYw==
X-Forwarded-Encrypted: i=1; AJvYcCUZA0uSfBStfOnPrP8kWNmxXR4Mz88ho6jHSuQwlFACS5T932r7IeTxBonwrHiBUKCM0A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/3J79QYcyUxClpfuaU4kANT7HxMNkmgujw+TF9k4035tSYdE
	30FPLZczqUzFzyBMvkcJhGTax8nO2QxBGsgUVplWrAaIM6jOEpcCOWT8tqzC/A==
X-Gm-Gg: ASbGnctYJWP+iKczVYVCUZwZyhUv7IDXugrI79R7VrnCAdSm3+RHCEhn98KFKJBj0hq
	lVrlG+NublqnaNZzPqnZJ6+A+v4LU8IBnJq3xRWzx0ce6Ztr1sRWm3+UwRAvBrNJ+jST28KuWp7
	dIA0sRNKJt7MqFyctHnu5VrOrbnrH5zODfZuCAWkRohZB8DWb6vfMx2ZG0gXvSXQQvTW3tvYWPm
	qH7DsPYBFh+aiJCu5HiKggY7gZtGNfVSNK/K7z0W40dT41EaTmWXNyzKIPjNWchJFwcNAK9CmhC
	ADsmIJ0s4aNKBj66PPmjiPMWBrK2Nyk6lK24z/Aa8BHhCsLW23bLLkOFK9j8UEJuRN5wIyuU4TD
	AXJs0K1qxZ9USOsUKXHJEUb8wS5mT9w==
X-Google-Smtp-Source: AGHT+IGtn9nwNy+zyF5J8gyvol0+0CBkrs/+mkXNwpJfwyScKOUi6cliR52GgNZiHuVU50D20gUhWg==
X-Received: by 2002:a05:6a00:2393:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-776120648f9mr314011b3a.5.1757613744794;
        Thu, 11 Sep 2025 11:02:24 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b393f0sm2661194b3a.88.2025.09.11.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:02:24 -0700 (PDT)
Message-ID: <b44d6bb914c55364a5fd682b6594093587912ed7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 5/6] selftests: bpf: use __stderr in stream
 error tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Thu, 11 Sep 2025 11:02:20 -0700
In-Reply-To: <20250911145808.58042-6-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
	 <20250911145808.58042-6-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 14:58 +0000, Puranjay Mohan wrote:
> Start using __stderr directly in the bpf programs to test the reporting
> of may_goto timeout detection and spin_lock dead lock detection.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

