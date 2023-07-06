Return-Path: <bpf+bounces-4360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29F74A7BF
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC611C20EB5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317D168C8;
	Thu,  6 Jul 2023 23:32:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413ED2E9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 23:32:05 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A666DC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:32:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b5c2433134so16091951fa.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688686322; x=1691278322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6HGx3BBK3e6NncirqzjfehqKmV8RLD2m05P7jQfvq4=;
        b=T63ZYqhdM8qR/Vsyta6go+eAeIyr6N4yUrP30azBb7axy5Iusz6QvzS9GrcdoxidG9
         BPqzPy7BPs4feaFwNEYhhJv04covUWpjlR/Vrz1h0D+NWjCYC3TkGF4e265jfF0TQImY
         NsZxGAlVSyPJZyGmJxSmTvCYK03pFljjHMqt7XqEAZpwtkCL37tIeV2vrq5Wfu6vqg7y
         a+NznAPFhsSmQiyi+K0P2IH9/WTaliBOeCMmkeU0K3QlS1StN+nNilqZkCRbIHYLcGQw
         Wmk5N3ldacWxAb6nDb5trXcp+1+jAh5QlA8Sr+pcTTmK2iKeP4pD/z+QVJNAkvY54pBU
         rXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688686322; x=1691278322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6HGx3BBK3e6NncirqzjfehqKmV8RLD2m05P7jQfvq4=;
        b=fjH1Z2NVTxoRHBuwXZq/z3O3MC2NA8nYImT8tOBA5ME57xANvg+opdeM5RE4Sg8EQr
         Y0/co0RbdxV4Yd2xRLhDnpJX5DOMJYd5AcP1yF5WlGKNSUfFQBxEZy1qngYWNCPZCYrs
         8Yn0CXgdbH7XJGBpHKmGt+Q2lks0VliuZ9o+nZLduc/dUf7GnXhHZuGgZ5Y8oYaBw/Ma
         M7ONq55fEIERjx1k5GZqnnAJSrkG2ZR+q5tu4Y78MGVGAJg4YJfWqUqGkBD+884INy9B
         xebEm6NZh9JOSubQ5Sv8cXZrVs4NVmpsOXK3zlT6g4UFRD62Knr4EcV7f3ZkLcYJ/8CJ
         2SDA==
X-Gm-Message-State: ABy/qLam0Zvy5AbymsBmIdCTBvPDwFfwpJ1s/Cdn1zFJqt6RiZsWGox5
	gNfjkUUAwRKfocWMLWxaYZu1uhP8wSm4I1BU/hnPVAqKA9s=
X-Google-Smtp-Source: APBJJlEFFF7M+y06+VP2GGB4Fq3B08az07f0fRoWhnGEqrWxhCs6cKkZl1kBcjsx1Nx50cvsRrjmslgeO26pG6LDSqs=
X-Received: by 2002:a2e:81c8:0:b0:2b7:118:a1bc with SMTP id
 s8-20020a2e81c8000000b002b70118a1bcmr1142457ljg.25.1688686321990; Thu, 06 Jul
 2023 16:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr> <20230706222020.268136-2-hawkinsw@obs.cr>
In-Reply-To: <20230706222020.268136-2-hawkinsw@obs.cr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 16:31:50 -0700
Message-ID: <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
Subject: Re: [Bpf] [PATCH 1/1] bpf, docs: Describe stack contents of function calls
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 3:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrote=
:
>
> The execution of every function proceeds as if it has access to its own
> stack space.
>
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>  Documentation/bpf/instruction-set.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/in=
struction-set.rst
> index 751e657973f0..717259767a41 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -30,6 +30,11 @@ The eBPF calling convention is defined as:
>  R0 - R5 are scratch registers and eBPF programs needs to spill/fill them=
 if
>  necessary across calls.
>
> +Every function invocation proceeds as if it has exclusive access to an
> +implementation-defined amount of stack space. R10 is a pointer to the by=
te of
> +memory with the highest address in that stack space. The contents
> +of a function invocation's stack space do not persist between invocation=
s.

Such description belongs in a future psABI doc.
instruction-set.rst is not a place to describe how registers are used.
For example x86-64 JIT maps BPF R10 to RBP.
Yet there is -fomit-frame-pointer.
So we might very well do something like that in the future.

