Return-Path: <bpf+bounces-66414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BEDB34902
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B8C1A881B5
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52A308F39;
	Mon, 25 Aug 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuVwu/vl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E03019D1
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143347; cv=none; b=Wal9btKViR4EGql2qkW6zRDutjMPfWWLlEKFhRLKXr87a50g4IAgUfV4IzoD8rEUi0D8j96UNUtabhpygy4FYhuVgqiLZR8fIPPX6qYPKDxC7QlQPmILbOVpvexID186DlLnUDpmQDt0pfBUV7toaJRJtAXwIXraO84MMxdCx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143347; c=relaxed/simple;
	bh=TEsnC12kEdBxpIMtRmZhd3eb/JMGdpFyvQrQUVDya8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFtLeiHfdDQO8AlQVx+SpHGhUKUTMYQx20IfDJM2icB01GZJh4YcePvDxrvG7GjxPGso7Dnk6eHMs3H3B4CrpLL9B0ykDPbK/ACHXhf8uGFKSD0ZD7VabI2ZxKPOe1DtEkdHaOop/ur8PgEllyuZSHqasBz2GSGdLckeJ52NjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuVwu/vl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so3596612b3a.3
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756143345; x=1756748145; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TEsnC12kEdBxpIMtRmZhd3eb/JMGdpFyvQrQUVDya8M=;
        b=PuVwu/vlmHHrje+ZxhCfsFll1JEBYtnYtjksEFOiY22PMw62kAyuqu91dATzYdCNh/
         sTgKyll5b5lKMftTSnkRi7Yivb5IshvpS7zKfTuOjPbAHbEPUt/fQNNjgrRPQS4w6Rx+
         DyLKdOg0UqdV/qRcoWB6PnDnpFNv4/DO60r1tBw2DMQC/QfAS4VbjATtrxiUayquv6es
         3r9JUdeIzI+qx7+hmV3Z0k9DP+YGEdBtH/DCYuPgcygskV2BWZBCYwDReHOEA3IT8efT
         sjChMTtdAs9H4ths9ZN4y5qJVScspg5LDDJxpSqHRS/DlnAABbcm+XnXabq1pEMibMSI
         hexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143345; x=1756748145;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEsnC12kEdBxpIMtRmZhd3eb/JMGdpFyvQrQUVDya8M=;
        b=B6GOwpN3qBpjKIHLR1bYWNQFig4W6F0arEjqrs5XFA1eFPGzSIvx+uRZKEk26EqmXh
         sayieZ8JUmMMmxhqWjFKFhuhXvLUdoI4jyGcQoun7sUhJdep0WMBfudfaMjovONXIdNn
         ozyxU2psqW8rdkk+tObUgiX3zyaKgjqLwuNy3vrEe0btFVXRgxOQBQxzxV9Ynn8SoClB
         7FX2igDZhgcO+ibzFKDbRJqU1Cpq0Av1U7guJM3A73kun32aNyaTjQUz7AJpSHhb6BN9
         U5lkQvxEzqpJj1pUieM+xffJeU/dXw9yg0IDmFOthApXlsdLINI8FCdfj6chGMc8Nojp
         azKg==
X-Gm-Message-State: AOJu0Yx/oTyHH9Fh3jvG5xOgzE7/Eo14b3877ULs7bpN5opO8oU19rSl
	/A1OetogiwVVL45VqyT7mQSl5P7X4rbDJHQpNLhd69HY9N4VR7tdrKb7
X-Gm-Gg: ASbGncspyM/6r3PJFeDLqkz4thOpDt0v4fCYCLbY3cEaP1JGUMOoOEriJSDDG/SsquM
	qSYf++jRqhoLdSmG33dHrafUVWUwY5FfC0vW97hE4CpsWgx8F0NqL5wCv7AWTJ4xqLrozffv9z7
	A1BoCn6dAoZuOLaIhirxaYG1epzaMJb+b+UrlnQjnscvTmyShJ+rNHRslN61jnLzl4SMjfJVC4u
	gQw1cU0xbqMn0sf48uwlpbhD3hXIL9qjxhAUqJq6DpSnFiEMc5a7VvShalBZHyvNSpHJ1+s+4xA
	dck87b2etSj2Zeehe3qMF6+JY8MF2DXn9EAdnGI0jAMksGCi9ZHxGuvePNkwhdNaKL5cflD+Cr3
	eeudK0+zUOIuY8/6fLqGgaIZQw5DI
X-Google-Smtp-Source: AGHT+IGjcjqRVa5Ggu/jUSCdvAiaQTL1IsuOZYcdxPOHTKMoDIehzE+otkXX4WJ7u4cmkcQThjAtQg==
X-Received: by 2002:a17:902:d504:b0:246:dadc:c576 with SMTP id d9443c01a7336-246dadcc9c1mr57480955ad.58.1756143345389;
        Mon, 25 Aug 2025 10:35:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:48d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467a6f5489sm68650195ad.144.2025.08.25.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:35:45 -0700 (PDT)
Message-ID: <a645bd00783d6615c1ab01c0a4eacf440587c001.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/2] bpf: add selftest to check the
 verifier's abstract multiplication
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Mon, 25 Aug 2025 10:35:43 -0700
In-Reply-To: <20250825172946.2141497-2-nandakumar@nandakumar.co.in>
References: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
	 <20250825172946.2141497-2-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 22:59 +0530, Nandakumar Edamana wrote:
> This commit adds selftest to test the abstract multiplication
> technique(s) used by the verifier, following the recent improvement in
> tnum multiplication (tnum_mul). One of the newly added programs,
> verifier_mul/mul_precise, results in a false positive with the old
> tnum_mul, while the program passes with the latest one.
>=20
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

