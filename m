Return-Path: <bpf+bounces-68874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB13B8774A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD35561786
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1A5D8F0;
	Fri, 19 Sep 2025 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT2xMIRz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFC79F2
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758241042; cv=none; b=jq9Z4QZmL/77P54O/dv5S3K50YmJTw8Iuv7WSzLCD4ZO4zONQjWTDK6njq7SsFhGI4y20VV29FnNKNjdyQ2mEYIf2gO8bk6aInucnjG0ZwplRPBqflwy0eRMd0mqfQXq4y7kl/IshZ0v1xyfJS3B76/C7gdCvIPn82y/4n9CX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758241042; c=relaxed/simple;
	bh=XyQ8utEgb2gtu3XP0e+jagGerOUqxsPi8aagWcZNH0w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlBKyhEUdX0+fJ7/Gtz4hBliQSFs3ebLrBPzBvOyYC+87TjWbNRPUxpuek3nZlpb6LPieoOu/eFlf8q/p9ftMekK89381CgD0Wwz39FnMGu+Kf692w6PtCw0X7i19wfQQ08vHay301TRYXeBZA3ZXTMRJiLJe6jARb85Kll6lXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT2xMIRz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445806df50so13143295ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758241040; x=1758845840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKNZvCvGGYDpV9eyXm4ZZLw/G3tMwq8mKMaG6vPCa+E=;
        b=FT2xMIRzLann8CM4MGmeyi7CXh4QWzXpy8BCKSvwD2luwKIRiOjdhooXYbOQbfhigj
         C0QkKjRM6YHZPCB9Afwvr+A7+WklgUzxwXn/NHjU789qT2DHH8yftgTpnt9VuW/4jXf2
         DIIW1c6/koLNBTMn2VoLz3y9wUesJsHiqYMUoJ9RgjdrFeM+bAplOsE6PIadlZNwxuXF
         +zEBKU68medYywOoMICpZsEGmCPZL1mqHjqqRjPehfDeGxg3Uor39nkbcWxzwW8eJ3fw
         Q7yCndRw5HD2WjKa3g8kxhiT+Q33rDgA5YrnVaxnoKRXW2zSF1VZo7Vh8GEHyhfhu1sO
         HcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758241040; x=1758845840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKNZvCvGGYDpV9eyXm4ZZLw/G3tMwq8mKMaG6vPCa+E=;
        b=A29h8p0PbQGcGrX3KH96+1rC+7sZ5EXTWXmb/a4IxaWP3bze3rBO7ccIxXArBAZ296
         lRWLAMqMvHnh1XKIPb4vMWJ6LfkSDA2eIpw5zfs/8kBx/y/COuhXLjHjGSV3ILbZWW2u
         btXxACwE7oJmCnCuBRicd07/+y90pZT0bgBGGghVhEr8BK+ztFQulU8X/tzOH9eNQ0YM
         Ma0lk0SKQ9i0F79ZHAue+S6qekZAucm11TFLpkqSoNv2kMAKWbsd38nQkBzKKMh3/wEX
         TNF7qoCBcuMAlIz9A3JqoUeA/CNAUGpOv96vr5GkCyrsMSKDahUaRVHkGrnWumQuSTXr
         OWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnz3zCj2fCDcxXdzZYTTBLl5BgwP6tZyVp4lfL9Acqzb4MsTwFrxo60ledRTXZcPVHVmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BktlrZvuSrJEh5CQNeSBWr3OHfRwOLzypEi+9lUZUogocPOd
	01oPmsSFt2ZzGpkLMyf9gPtcBk5C57yuw2adGxTeO/qJ9vT5WWIozJbV
X-Gm-Gg: ASbGncuJ2l1HttP1QU5uFSCCC4FQ1M8rSY4mEZR+zoGVcijV5rVGsYE4nuD/Ua4S7ag
	qUnr8BRxyFBs897Or/2NAUMKDEU8HOY30ld0Jue83c/d0JJUV344poaks/apQP9g0fPP/Zm3agT
	+xZw7R9h0FvWS9CqaUZ3LREqPGt/3UM3SsUy55G3hfO38dbsCyj6yO+3/gsrkF9IB/Mu7QMH9wa
	ynUTfUWrKXEZe9Ej4JXkJupAhX+zj7VHnjibYLMJuANdYxe1BiS0exhdJ5gEykHZeSwqWMWNldE
	gJCdczKzDOoXuKqcKN156y7vxSrq1paQZSP29/6BNUzqz+LvK5vv7tgO4yeXB2+057of6Aem/kN
	RimSRCAxuRK9Q7t50qFA=
X-Google-Smtp-Source: AGHT+IFGGYr+RZvCK02As+zMTvv0cPKU+9Ysii/q/wUWWgF3QBGMF7hpeoy52LFAWRWk5RaApkHDPQ==
X-Received: by 2002:a17:902:8bc3:b0:269:b2a5:8827 with SMTP id d9443c01a7336-269ba467eebmr13866275ad.16.1758241040313;
        Thu, 18 Sep 2025 17:17:20 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803303fesm36940325ad.122.2025.09.18.17.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:17:19 -0700 (PDT)
Message-ID: <da197caec5cf8d4aed067c94bbb13ed62252ad62.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/13] bpf: fix the return value of
 push_stack
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 18 Sep 2025 17:17:16 -0700
In-Reply-To: <20250918093850.455051-2-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-2-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> In [1] Eduard mentioned that on push_stack failure verifier code
> should return -ENOMEM instead of -EFAULT. After checking with the
> other call sites I've found that code randomly returns either -ENOMEM
> or -EFAULT. This patch unifies the return values for the push_stack
> (and similar push_async_cb) functions such that error codes are
> always assigned properly.
>=20
>   [1] https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov=
@gmail.com
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -14256,7 +14255,7 @@ sanitize_speculative_path(struct bpf_verifier_env=
 *env,
>  			mark_reg_unknown(env, regs, insn->src_reg);
>  		}
>  	}
> -	return branch;
> +	return IS_ERR(branch) ? PTR_ERR(branch) : 0;

Nit: this is the same as PTR_ERR_OR_ZERO.

>  }
> =20
>  static int sanitize_ptr_alu(struct bpf_verifier_env *env,

[...]

