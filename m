Return-Path: <bpf+bounces-29702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D18C5807
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 16:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E541F235FC
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA617BB3E;
	Tue, 14 May 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H435RsdL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9317BB10;
	Tue, 14 May 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697239; cv=none; b=O1g4xahHGzfDeKFN/xRu2bbUpBiOddG68h6XtH3aNTV7oRxpUPuUGUK545aCYAUAiKYTvzbjPLeXOfW+PQZvogSZhkOThidZutfxO7E/xwxhAnGkbFXtYqw0Sjd36wCD7buYLZCJSTQHzG3LtTL/P56mcLusmrjxbj/KBUgM+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697239; c=relaxed/simple;
	bh=9JQ7eiNNZ64JRDb74RE//xWnDSJqnxv76sc+EBu6IA8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+LO2KeAI3vsTTvaHU386GjGEM4Qn+JT6M5Bv8HfY2xdXvWsMVxUFPsgTTZtu2pf2yy3j9zfcEmnVaZQ17jQCkRWAfdCuDXgzLBy+0RUeiGQuRadFIdnosalBl5eVr8XxtRiysZgNfSoklapVSZG28DvZ4pBMz7wMu1G/7X+hZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=H435RsdL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso3826319a91.0;
        Tue, 14 May 2024 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1715697238; x=1716302038; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq8lh+ioOW1FpEAVtAaznZbqqApHq44z6sdGCsyHXFA=;
        b=H435RsdLm2f3aWzBHUyl3FV2C0V6TjQf3L5YKhN/k9XZBIeih7bLkBi0qeyrbkN+VR
         JDGhTAz333DMQlhsJU5H7txZUhvWdqdLz1tijafE1ypbUQ/GB8u8t9fpO5hkqcp3o0Og
         jed9UBPhWaLQLQFY1gvUGwNLBlXEEySdmPHvyc5yDXpoE1wwtY36anyg37klIX1pUmqi
         58N2jx01DOAV2Y7Eue+kfWxaDJIC1QbafO1IWSEx1Nv/1bc3ume+HDQWXWqG2D/ZVHtW
         qoblsBrHXfSbRQtQZKze5FnTCmvaH2rM5p26Gq8mIUNnz1FXbRXeQSu9E+vPPDqxT/NA
         JqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697238; x=1716302038;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq8lh+ioOW1FpEAVtAaznZbqqApHq44z6sdGCsyHXFA=;
        b=dHPU0h9KrY3Lr2A0FaxL/6xhjg1189bjxohlKkv7zVn5pJRf4aVfp9zvgb6VPJ+Ap1
         mlYSAGvmKPvVknL3XQ+DwxjAqmrGnTqWfKDce7iYvTIZ4ZOL6uU2+T88gCrmvvg7gDNi
         1Yl/dUTZsmJCGDbgGm4GiN0qf2bcZwelZETnCdRh1HMmf42OwdCsS1QUd5CYlID6r6FG
         aNW6IeK2wSJlZGMHOMurqgvGK1Ly65C9iUp8PzjMjRqEBdU9FUL4G4P4ICQuBXGH+8S6
         G98qQaeIb2Yzeb8zKJTYNGetRLm/HFGNKfFfdlEGfU3fEYztnHE7GwhIywV55X21Q6zl
         QJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVarU/u4KasBfN3WX4GUGZR1oICgtpr4wtQKNb9oc7yix8ugXxBmjUEQEGJJqP1Zp+hQB7gj64/S/o6wgToc7P1oNSqr13bA5Q7r3Q4Im3hkXvL+LMxu4F1n9Cwp+E35gbFcovR1SL0yQnINVIykOg68L2ndi+1jMZezKVU
X-Gm-Message-State: AOJu0YxJYrzv+P8OWfrYVuiW6Elmx0tW//7tYb1bZSNOpos7Vzw4SWml
	1Wg2QhvwX9HyMCBk7YnHxf+pQWjeiQHZqlU1hDxfrbjfBFCEMHXG
X-Google-Smtp-Source: AGHT+IEhEBfxmSCDQ+qNmAfruffGpVnoNO3Uk5u3oWLvN0oE6s/d9cI16dDjXJDX2fpa2A9RSrERMQ==
X-Received: by 2002:a17:90a:7103:b0:2b6:215b:e236 with SMTP id 98e67ed59e1d1-2b6c76f97b7mr19309942a91.23.1715697237523;
        Tue, 14 May 2024 07:33:57 -0700 (PDT)
Received: from ArmidaleLaptop ([50.204.89.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b99c5eea97sm976337a91.52.2024.05.14.07.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2024 07:33:57 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Puranjay Mohan'" <puranjay@kernel.org>,
	"'David Vernet'" <void@manifault.com>,
	"'Alexei Starovoitov'" <ast@kernel.org>,
	"'Daniel Borkmann'" <daniel@iogearbox.net>,
	"'Andrii Nakryiko'" <andrii@kernel.org>,
	"'Martin KaFai Lau'" <martin.lau@linux.dev>,
	"'Eduard Zingerman'" <eddyz87@gmail.com>,
	"'Song Liu'" <song@kernel.org>,
	"'Yonghong Song'" <yonghong.song@linux.dev>,
	"'John Fastabend'" <john.fastabend@gmail.com>,
	"'KP Singh'" <kpsingh@kernel.org>,
	"'Stanislav Fomichev'" <sdf@google.com>,
	"'Hao Luo'" <haoluo@google.com>,
	"'Jiri Olsa'" <jolsa@kernel.org>,
	"'Jonathan Corbet'" <corbet@lwn.net>,
	"'Dave Thaler'" <dthaler1968@googlemail.com>,
	"'Will Hawkins'" <hawkinsw@obs.cr>,
	<bpf@vger.kernel.org>,
	<bpf@ietf.org>,
	<linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Cc: <puranjay12@gmail.com>
References: <20240514130303.113607-1-puranjay@kernel.org>
In-Reply-To: <20240514130303.113607-1-puranjay@kernel.org>
Subject: RE: [PATCH bpf] bpf, docs: Fix the description of 'src' in ALU instructions
Date: Tue, 14 May 2024 08:33:55 -0600
Message-ID: <019c01daa60b$c08873b0$41995b10$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMgS3ITkG+5x2/Y13ejOoDX0Q3k4K8LgGnA
Content-Language: en-us

Puranjay Mohan <puranjay@kernel.org> wrote: 
> An ALU instruction's source operand can be the value in the source
register or the
> 32-bit immediate value encoded in the instruction. This is controlled by
the 's' bit of
> the 'opcode'.
> 
> The current description explicitly uses the phrase 'value of the source
register'
> when defining the meaning of 'src'.
> 
> Change the description to use 'source operand' in place of 'value of the
source
> register'.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Dave Thaler <dthaler1968@gmail.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst
> b/Documentation/bpf/standardization/instruction-set.rst
> index a5ab00ac0b14..2e17b365388e 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -292,8 +292,9 @@ Arithmetic instructions  ``ALU`` uses 32-bit wide
> operands while ``ALU64`` uses 64-bit wide operands for  otherwise
identical
> operations. ``ALU64`` instructions belong to the
>  base64 conformance group unless noted otherwise.
> -The 'code' field encodes the operation as below, where 'src' and 'dst'
refer -to the
> values of the source and destination registers, respectively.
> +The 'code' field encodes the operation as below, where 'src' refers to
> +the the source operand and 'dst' refers to the value of the destination
> +register.
> 
>  =====  =====  =======
> ==========================================================
>  name   code   offset   description
> --
> 2.40.1



