Return-Path: <bpf+bounces-34693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F036930157
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD51F22A61
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98A3F9FC;
	Fri, 12 Jul 2024 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSbJ1Rew"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14ABBE40
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817456; cv=none; b=Mii81trRMnGGDtaXJW3ArvgmfKMBkRNuavtQCfffG3LPfdKOO/BER6xEeIqO786mVLYZd8TXUdhQVdMzXXzRqSZtDBNLLxGCGW90inD6KuNApiAdVeEMJVRk8mm5Y6ScdfKg/D9hsxTAEHKWVSBf+2PKfyeZ3rjTElB29fqkU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817456; c=relaxed/simple;
	bh=fIb8yzsN0fYmXhwD4IpAHfo7jg4iVbqKnAYza8YOj8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c22rlz5HFBdwIyfffgfF52sM8RAoonifkscOiLJV57JnhtjZaFatjNluWTaTvSAYtZ9SD9ziF2oTwGeQFMl8x1jr8rBDMYVEqxD0yzG7/mBz7dJkQEJWy+k0I+V6/MYSKOlKXu37Im67nxQcl/xS0nQ4jFfXfzkoWmTE0vfmNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSbJ1Rew; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7276c331f78so2473910a12.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720817454; x=1721422254; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/iqnrLIXgx5ZWaCKpOqxZimw++WA0op+inQUe8/rHEc=;
        b=kSbJ1RewygOSZpIkb2xhOByqVBZAJ2H5gcz5gWbkRiVOTWpS9BAIVhzpYpTLfDbksJ
         m0nAmpFOh76Y2wb7dyTs5mR22yEHZ12DZywSrisDlEZuWO0byd27weWN5IFR/3yRt/RP
         rUz66sQEMZGC8H+6KpmEkC9L9H1BrgIeib92+QRVInNpZNSTPBShbJfSsBPpOgabB8sN
         /NBWGWHpFOKjznDrFVrFvymznK4Kh7AiBJCuPnUdOc0gFJ7PKPwWOvnUkziz2qKE4LyY
         CyrlypCtlatl4fxiYNBqC4Wt757w5ixGoGETxfDUQM4XniQvimtcuBM7BVSqj4De0ude
         sj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720817454; x=1721422254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/iqnrLIXgx5ZWaCKpOqxZimw++WA0op+inQUe8/rHEc=;
        b=vBWgS7Dsngik59LJ7O/YudMiFBXZggTtFEwLJUhKr0XMTxH7cFgEvQuXqoW8v3HXEv
         uw5DZUhnZ0VQn5oLU/YCLqcfNE8hD0moZOAlpgJLwV5sl03Y9oQsgSsa6W0lYtjLGyOL
         sIc9BEiTER/6yX0zVqVKL5EJ97P70miNzDjI+JcBkPfrKMzYTAsLE0BruFw3CbEihB3Z
         cpP7DMMDJ2uyQx4w03UXguvgoE3xU8Jqji0bMKyNEawYBMwMylbczueGGy21cSgRNpY0
         AYdeYS8+b0sDHPk2cgUUibViV14oODyIYHU8RChsI60ouSSq70gG8jKWdKgDElGyYdey
         pGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgUUvjhLRxP5ppqOrWPAulv/ryyxk/MKRx8ddFquA8j9BYtTH5UoKAAGKPeM9gN7p+FwXsnZq3efQ7LTW/89wnvfQk
X-Gm-Message-State: AOJu0Yy7l6se3ju72LozJAl3cmwAcJwzNMDbv5Qi/D02gCqNjjUeVd9A
	kyKATZaTzlHrmHSZulxu7/P0lcP+ql+s2ThbPMOJ0BROUxilgDSV
X-Google-Smtp-Source: AGHT+IEdPy6Xg7cnsJvb2X5PJsjSL3L+//9HDI5CNJS/y/SXtTn+LYPgmUsxu7Pxc72uWjrEo9GtEA==
X-Received: by 2002:a17:90a:db8b:b0:2c9:7f8b:f7d8 with SMTP id 98e67ed59e1d1-2cac6dfc487mr5479544a91.6.1720817454012;
        Fri, 12 Jul 2024 13:50:54 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2caccec7b0csm1998943a91.0.2024.07.12.13.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:50:53 -0700 (PDT)
Message-ID: <fae1d2787b5340209429c83111cb6a1b92a66308.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Get better reg range with ldsx and
 32bit compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Fri, 12 Jul 2024 13:50:49 -0700
In-Reply-To: <20240712202815.3540564-1-yonghong.song@linux.dev>
References: <20240712202815.3540564-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[...]

Also,

> +	/* Here we would like to handle a special case after sign extending loa=
d,
> +	 * when upper bits for a 64-bit range are all 1s or all 0s.
> +	 *
> +	 * Upper bits are all 1s when register is in a rage:
                                                       ^^^^
                                                 I missed 'n' here, sorry

> +	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
> +	 * Upper bits are all 0s when register is in a range:
> +	 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
> +	 * Together this forms are continuous range:
> +	 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]

[...]

