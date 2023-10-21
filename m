Return-Path: <bpf+bounces-12893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA57D1AB6
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 06:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F32826CD
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 04:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DABC17DB;
	Sat, 21 Oct 2023 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOE4Ljbk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E16817
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 04:14:04 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18DFA
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 21:14:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so1325055b3a.2
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697861641; x=1698466441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoR3512kxKsaORsYP8UEqSnp1optQ4BgOK/TFVCyFno=;
        b=dOE4LjbkYsh+F9fDP0se4nBdQiMQh8Ot7JQZQHxpTqEoDsaj2MOYN4bVdeS4edPGi5
         9AqC2w/by6KY1Eo3oDiWS5ERlFEoUgWz07evLOtjZo/fA8BsM+AKcqxEEx0v2niVI0yg
         hkYjODni8ePBrTpBE21Js4UJ7WSYBJ1K4gOyLpRB14hbDtC+vP80J9WLl+4gxKU+t0k0
         bZ2aht2BER6+KoJgQhxZ+RATqfI+xbTJgzp0TqwxoN+LhdNNMzTUrBQbvRZVKY2K6O1U
         If/BHeKMG8yYZGDnMj3fhEOBRG4Qctth2OBTYdsxTn283+EM6Hj+s6FhqL2RxywZEdUd
         K7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697861641; x=1698466441;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EoR3512kxKsaORsYP8UEqSnp1optQ4BgOK/TFVCyFno=;
        b=v27oWs6Wjopi3FUDr+Rg4gALVctXJkPdYpVaRdwOPlcq7TwZ7z8xc8O7kxJ5fSneqG
         +QH5yOLGWcEUHc1M79TC89awA7nld1yU0//miYBMYi1AXhgyWz0JLXDPUhw3+Ru4zzOv
         qM1343zaytN2NNMhoSZl7E4UUjtLNvi1pJ+KZkCnG5g9nN1vl9edQ0oSrOCS6ChaIutB
         fSo7ydy4xdJOOY6ZmUOGLz7JvbreKzqfU3HxP/wPRF323mBT4irtp/g/RmpWqro0zwSC
         lf02fl4c+JvSh9Fb51Xv4sGvBdEzRnxfEvX1yPWsto3kc6/32RAnudxhnZoYlSBQbT3t
         2LUQ==
X-Gm-Message-State: AOJu0Yx2CiL7R41QmolRySJAas0js2WttJumF66QuXoQAg73Yp7y1ryZ
	d8xyejbwYtxz0JcbhtQB1jw=
X-Google-Smtp-Source: AGHT+IEBQM4XqIQFgda+pMmTYT5hWPO2RXjinXogvaWekavpNqx3vDKm8oeXZesZtKigtdOgl4HsNg==
X-Received: by 2002:a05:6a00:1142:b0:6be:23dd:d612 with SMTP id b2-20020a056a00114200b006be23ddd612mr3691447pfm.16.1697861640645;
        Fri, 20 Oct 2023 21:14:00 -0700 (PDT)
Received: from localhost ([98.97.36.36])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7949d000000b006be5e537b6csm2325165pfk.63.2023.10.20.21.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 21:13:59 -0700 (PDT)
Date: Fri, 20 Oct 2023 21:13:58 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <65335006882f9_6c4082082a@john.notmuch>
In-Reply-To: <20231019042405.2971130-1-andrii@kernel.org>
References: <20231019042405.2971130-1-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 0/7] BPF register bounds logic and testing
 improvements
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> This patch set adds a big set of manual and auto-generated test cases
> validating BPF verifier's register bounds tracking and deduction logic. See
> details in the last patch.
> 
> To make this approach work, BPF verifier's logic needed a bunch of
> improvements to handle some cases that previously were not covered. This had
> no implications as to correctness of verifier logic, but it was incomplete
> enough to cause significant disagreements with alternative implementation of
> register bounds logic that tests in this patch set implement. So we need BPF
> verifier logic improvements to make all the tests pass.
> 
> This is a first part of work with the end goal intended to extend register
> bounds logic to cover range vs range comparisons, which will be submitted
> later assuming changes in this patch set land.
> 
> See individual patches for details.

Nice, I'm about half way through this I'll continue on Monday. The two rounds
of convergence was interesting I didn't expect that. Looks good to me though
so far.

Thanks for doing this I've wanted this cleaned up for awhile!

> 
> v1->v2:
>   - fix compilation when building selftests with llvm-16 toolchain (CI).
> 
> Andrii Nakryiko (7):
>   bpf: improve JEQ/JNE branch taken logic
>   bpf: derive smin/smax from umin/max bounds
>   bpf: enhance subregister bounds deduction logic
>   bpf: improve deduction of 64-bit bounds from 32-bit bounds
>   bpf: try harder to deduce register bounds from different numeric
>     domains
>   bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
>   selftests/bpf: BPF register range bounds tester
> 
>  kernel/bpf/verifier.c                         |  175 +-
>  .../selftests/bpf/prog_tests/reg_bounds.c     | 1668 +++++++++++++++++
>  2 files changed, 1791 insertions(+), 52 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> 
> -- 
> 2.34.1
> 
> 



