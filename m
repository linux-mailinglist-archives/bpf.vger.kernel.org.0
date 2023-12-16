Return-Path: <bpf+bounces-18093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66868159F4
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7E1C2189A
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33B2E3F7;
	Sat, 16 Dec 2023 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/8flqvL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7763033B
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso1949851a12.3
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 07:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702739617; x=1703344417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCCWJFiw8zJ8aKdFkgzDNpEm1k74RVBn3QtHjndJQ/s=;
        b=Q/8flqvL2JlGC+ZWp9EINVrnd5nWQFvyBs8yGY4C27eUcHQFSlD32T/yZtuO0HLrxT
         SgKcg/qcYVp7+Y8X3Aann4C2XTEtv/fZA+USfqxmLr7gvBc7MyXMtNjeJXK8uMzoPqO7
         X7ZIXnSEh0TPVDJUCMOjcoHWwEw1sb3tGB5WVxUuWFKhmeIfh6aLrYO9iJ6ZgQyRV1FU
         CN6aRVmncUiPjpR9nrUHQG7iLRalXoNHpqW2G2JZ4vCS4mv0RLDWoQZPgh1NZsJhWETb
         WtOQ8S3hacEmSxo5GAlhHayESg+2O6g6WtPoj87+Z9iD8AelNt5rOaW4VU6d5fzbSIqZ
         ekOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702739617; x=1703344417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCCWJFiw8zJ8aKdFkgzDNpEm1k74RVBn3QtHjndJQ/s=;
        b=XAO52lF6SIa5kqbR7ZFJFLTlfAm5C4bNMOV/7AuW/ckEOiec9VPWce+BNDd8zNk27d
         LTIaLhIygaUL62l6Gk8deOt9A84HwNebHsmrb3Tu7al5+rR3VlPVx45B1eEtjKzxGpSG
         A0LvDfcVqduCH5kzh+j1jnh7hzhKFrqCwP+W24rT75PRcQFRZX/Ct6NOo8H8V0IHZUtK
         sdXRFFgBkdxms9c85lYT7gWnnK+P42JIJAdcPxlty8rF7i1P7iAf4+0oAqAmEmjWLZm6
         pFz2myhmhTaoLt4+wvmQ4xInHFxvzQYm7gZ1xWrJ/07Mvirn4ejXDAEB0n5eXGmEWGGC
         WTdA==
X-Gm-Message-State: AOJu0Yx0SCYk4Jgn6Io8DfMCxXYqaK/ZXyHdhbOBBb5BBlSpRMMusAhx
	+71ljLmsPfYxWrkKPo8nWho=
X-Google-Smtp-Source: AGHT+IHMNyQtDCdKaTIvsbZtJKHyQ/oQf1kKTu0jF3q6q/IJC23ejOFk3VS0SSxqqMQnYeqziZ5KAg==
X-Received: by 2002:a17:906:2cc:b0:a23:2eed:8117 with SMTP id 12-20020a17090602cc00b00a232eed8117mr239253ejk.152.1702739616479;
        Sat, 16 Dec 2023 07:13:36 -0800 (PST)
Received: from localhost ([185.220.101.137])
        by smtp.gmail.com with ESMTPSA id vo9-20020a170907a80900b00a1d450d6f8esm12165367ejc.17.2023.12.16.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 07:13:36 -0800 (PST)
Date: Sat, 16 Dec 2023 17:13:32 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] bpf: ensure precise is reset to false in
 __mark_reg_const_zero()
Message-ID: <ZX2-nH1IsHNCPIho@mail.gmail.com>
References: <20231215235822.908223-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215235822.908223-1-andrii@kernel.org>

On Fri, 15 Dec 2023 at 15:58:22 -0800, Andrii Nakryiko wrote:
> It is safe to always start with imprecise SCALAR_VALUE register.
> Previously __mark_reg_const_zero() relied on caller to reset precise
> mark, but it's very error prone and we already missed it in a few
> places. So instead make __mark_reg_const_zero() reset precision always,
> as it's a safe default for SCALAR_VALUE. Explanation is basically the
> same as for why we are resetting (or rather not setting) precision in
> current state. If necessary, precision propagation will set it to
> precise correctly.
> 
> As such, also remove a big comment about forward precision propagation
> in mark_reg_stack_read() and avoid unnecessarily setting precision to
> true after reading from STACK_ZERO stack. Again, precision propagation
> will correctly handle this, if that SCALAR_VALUE register will ever be
> needed to be precise.
> 
> Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c                            | 16 +++-------------
>  .../selftests/bpf/progs/verifier_spill_fill.c    | 10 ++++++++--
>  2 files changed, 11 insertions(+), 15 deletions(-)

Thanks for the prompt fix!

Acked-by: Maxim Mikityanskiy <maxtram95@gmail.com>

