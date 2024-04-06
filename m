Return-Path: <bpf+bounces-26096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6371789AC0A
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39B71F2185B
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC43714C;
	Sat,  6 Apr 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt7H+g2Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF4107B3
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421291; cv=none; b=kmd5/LH7wphVO+fdkVv62iE3sCjX0D+Qcmo7ImIAacC2xH68AJCzOP6ZyipINlBiITljeM6fqigtleDRB258MrRjVrBrOJTkdKmJLKkzBWBE1+EFCbUxo1sKChI8dc3lWfNhtbicyEEW7XSTntk1TtJelxFa6En/mJKpwIz9aRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421291; c=relaxed/simple;
	bh=ngAW/MaOLvZgswa/rXBOih7jFqyv+WY+39ZTRZ62Bbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxZG61YPJ5CNfeSNfhK/4PWeNvR/beuLb4v42o6QwHLLz4slPpes9EJ8n5kifXlT2M33u/0MFEmUePP9bZLWTqHelJsGje1utjY4KlrXQq8LhWn7tzGaBVN31MPvKGWsKr0/4gR4HwtuqKcIVgSYjbY3JVbVPdTUgD1FF3m9cpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt7H+g2Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34175878e3cso2189939f8f.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712421288; x=1713026088; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngAW/MaOLvZgswa/rXBOih7jFqyv+WY+39ZTRZ62Bbc=;
        b=Xt7H+g2ZxnWOp2xCL659W+boURtDRZEy71oKO0RGjeAEyA/n1prULbYr6LzQN9i56r
         vJ9/tINt1lwJIFpJaCurftiJ7t/zhSDO3JxxZsJH7eAj9gN+7nKIMznbxBV2RHogGW4f
         vRq1DR45NsrRbGm83Bbueryvkj3rBA5VVZQdxCOwNpkqC/cuS2srZi8VHypTB54tMLB2
         U8XRAvGny0UdenD0sUqQ1eVQm0LoYGMFntXPrUfA+3WIeHIbea8TDvy7V69KvkI5GPKK
         r5+HHUtjMeConEQw+g3OsNTKrx3I9tfmo+OF9KhlNIH+/Ax8US97u/IhZVrUBZB/9h7A
         55PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712421288; x=1713026088;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngAW/MaOLvZgswa/rXBOih7jFqyv+WY+39ZTRZ62Bbc=;
        b=aiyHqZGZ9Ln81I0F6vaHTtPcz8k/Yv2loATuOgLK/JRONEaC+qcmStG6F9k+DdIQg9
         A9Knz0XWz3zVAngEbnydetQ6t4kHP7KLpSv3PTNQYVt4Jp4Ah8eEUdB2wOF25D2g5Fq7
         +0+pEGGEjcrw3jXu7prjy2oY4UlmPkgf2wddfbw1JRH0fGbTAjUIhjQnJiM+zU82OmtO
         WfLC+IsBOXgucvZr2Np9gHMOeHIVgVggrr+F+v9hmvPaCTPJQG1UL3+5wskpJp86J5cR
         /47vpkxCxvue1bvRZe8A7E80Pk4JWrgWslf2Ui05PY+JBjzFyfOhMFnet3Oqw5d2yS2U
         zyYA==
X-Forwarded-Encrypted: i=1; AJvYcCWb6WRz21QXQZdWM0sYb+mKgftWuSeREuxZBT3+fcy6mOI0+LucY/BhvHaPU31N9OuGAYPqAHZlINZYpgRHhv1jXu4m
X-Gm-Message-State: AOJu0YzxmJz2TW2Brr1e+a5d35U8dJPPZqweGQYXn83D7CbKKpoKY4mw
	x9vqpjiyCXi0V5KfPbjzhTWOtnfHbA7o4wqKXd3jMFvbOn7oomVc
X-Google-Smtp-Source: AGHT+IHgiecWJ4g8YYT6nmLy4xfTukGUqZg85IYZlV5xXuwjF7306KzU6HBQ71w4DhOIjuFAuirb1Q==
X-Received: by 2002:a05:6000:1a47:b0:33e:d244:9c62 with SMTP id t7-20020a0560001a4700b0033ed2449c62mr3452158wry.68.1712421288226;
        Sat, 06 Apr 2024 09:34:48 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b003439b45ca08sm4785356wrq.17.2024.04.06.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 09:34:47 -0700 (PDT)
Message-ID: <90f0f7886ea1656eaa196f89c760b01a0d09ddf6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for atomics in
 bpf_arena.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, puranjay@kernel.org, kernel-team@fb.com
Date: Sat, 06 Apr 2024 19:34:46 +0300
In-Reply-To: <20240405231134.17274-2-alexei.starovoitov@gmail.com>
References: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
	 <20240405231134.17274-2-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 16:11 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add selftests for atomic instructions in bpf_arena.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

