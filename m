Return-Path: <bpf+bounces-38334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2EB9636EF
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12B4285C91
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E22BD520;
	Thu, 29 Aug 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1PsqV5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74A23A9
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892096; cv=none; b=JhuYzhOshUNrO0a8yzH4CWObHCT/Cg6FcDCfjvhZd1FumHQGIIlFo6H2RMt4dNWsAEB8z5k8/t+Oyh5DI3PtTB5JfLFYMPtXtdeqGYCNCdxYcjfJCKqug48YYzG8dn9yS61s3GiKzJSioJaCkRStFd7ZW2rLfoTmetcfNLVmoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892096; c=relaxed/simple;
	bh=be7MpkPdEuYehP/xH9JTjK+AQMluv0ufhv22a4d4FdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ef/Ki1ySD2LRhtZhrBrai2vZfdbe0ZHHjBQbHpegOqdisJWkyFQ19Yz2Vvh5xSFCW9Ki9BR0lwxY3KcC+kuWhqj10Q/Itscpvh++AZEdr4qIrfFyeHLDsyBvPleW07gfZmc4eBGbznpEeE47/Sl429di0pYMo2o5Hv67zzmep00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1PsqV5E; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5de8647f0d5so65613eaf.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 17:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724892094; x=1725496894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=be7MpkPdEuYehP/xH9JTjK+AQMluv0ufhv22a4d4FdA=;
        b=Q1PsqV5E/eTP6fXGSvTDiEZsfu/UBTHQQp9oQzniEDL1MccK6yPw1uCb7CFtspbyMV
         783/8gwuN7CFk08Y/5jTla+y01IWSNE0Upv1f6QunWAF0uuyIeKkaZf6QXGMSwZWJ1QP
         hGVII0+yP9sT5N9/3eSz3qMu2FVt5KpLZVa9AoOAyGL2qY0usDG8ni4MgjjE/daDSEf3
         OBYD2U7tc2+JiTpJpjeYxZs0DE02QAa2hx0PVSm53Tnvd1AK+hAEuLqXMvy/3Ka7rXRq
         mj4V3exYAlGPO/YTOZ41Zv8bEy1rC6tZaMuYOVYEUbTkcmPcBcGefQg9ZzHqQFRYs8PM
         oZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724892094; x=1725496894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=be7MpkPdEuYehP/xH9JTjK+AQMluv0ufhv22a4d4FdA=;
        b=kUD9FtxBCR7XNG3uix7G57ntkSzGme1LDwdfUdnZKzVrtuUCiKCGX05YxRBV2oIEAN
         9ZvENboKB0NcNMzdgQk/ScKEqXxiTuLZoq9qlRCrzB7EZD77C3bolLUB7cCVpQSNovRF
         zLBGBnBfu4pl8xLnCPwmOVKv3hAPuhcotdE6Gk0WHKmGpHkukyEdBwFPKa8EAzaQH6+s
         dzmVme4+G25RlUopdmvXu9oc6ffLrXvkR6Da9Fhk6kWfMjGd9b16LZPu4qiHMJaOuBXU
         ttCdod7rQrD0MMNwj3npeBbfOhuHqYBW5pgP8+9cqMrq9efo/4ZOdKTPSLzNtPbVqWMs
         yizA==
X-Forwarded-Encrypted: i=1; AJvYcCV36mmM4fZw+VorR38KThZ6q5w9xnwFnPb+Ic8ZC8UGVcwHITdQxTjltADKbFp0vdkLsqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxER1TCI+91NsbH9QM+/VBe+qNViH5x3a8TorYmW+5sTcQpCqGe
	V7HixS1QvKCpEMe5vZHSnd1T32HaZjRmcva3ijVSZJbgpH5FnKVy
X-Google-Smtp-Source: AGHT+IGgVFxsaYIcxzXV9jcN/4SWtyxw70pHpDzpi23nitBmcZzs+kIV21lbrQNbjp6uJI48KRNb1w==
X-Received: by 2002:a05:6871:ca18:b0:260:f75c:c28b with SMTP id 586e51a60fabf-277900778d4mr1320250fac.8.1724892094232;
        Wed, 28 Aug 2024 17:41:34 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b9cf0sm70679b3a.96.2024.08.28.17.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 17:41:33 -0700 (PDT)
Message-ID: <9bcfc97f011f4b4d5dc312e26074d0c1d744af02.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Move insn_buf[16] to
 bpf_verifier_env
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 28 Aug 2024 17:41:28 -0700
In-Reply-To: <20240827194834.1423815-2-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-2-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> This patch moves the 'struct bpf_insn insn_buf[16]' stack usage
> to the bpf_verifier_env. A '#define INSN_BUF_SIZE 16' is also added
> to replace the ARRAY_SIZE(insn_buf) usages.
>=20
> Both convert_ctx_accesses() and do_misc_fixup() are changed
> to use the env->insn_buf.
>=20
> It is a prep work for adding the epilogue_buf[16] in a later patch.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Not sure if this refactoring is worth it but code looks correct.
Note that there is also inline_bpf_loop()
(it needs a slightly bigger buffer).

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


