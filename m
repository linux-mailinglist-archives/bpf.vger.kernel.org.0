Return-Path: <bpf+bounces-33584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212391EBE5
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2171B2835A2
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28D6FCB;
	Tue,  2 Jul 2024 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAPvIxVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595C23D7
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880949; cv=none; b=dm8v6m+0rED0pMtZiCQl0MJa7eRuyNdLD016pIRwa3UrG8CqhkcLT7Lt2YClGSQ2/M/FN2gso46wV8Q7k7wptC+KMit33aOZ/pGajsquroyRuU0W1Abb5ikhQg8ICWEcia3Q02do/QQxDtBDFfMI5qUsPT7/SYHFajWklKqxLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880949; c=relaxed/simple;
	bh=lpsE+GwdZgi6ks1tXsYeUFK5u/8BotBFTxp902Liq9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXhZx0uh25fIrKBa6uFp9DxhlWmYHA+JzZSSrzmZWcGb/n7tyf/am4sspYpuDN2kwksR2pQL58puIMq8lKBS/HMELKoIq8oaNYlGZ+Zhk8bdEyXHjeNU6tFQFyzzNWKdhksBszrDFyvZrhsftC7DhpnoATMLF/5Hk9N1JxMvnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAPvIxVZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7066c9741b7so2130828b3a.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880948; x=1720485748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwqqkyjuBHOEXV1WHT6bbORSuaZmXG7FUu+JP6jq/8Q=;
        b=UAPvIxVZBJhRbwvHHqXkU3wi/eSu38uqC7LYqf9yAQKRKSARJqO2KbB5/liZfPjA3r
         n3dZ9NFPYSFd14hhr/4pMX/MNUB+6aYaEwZPYGd4uMB/uIYYUBM5KnSb5l9WOLzgXrGv
         /yx/MpTwzXHpcHl7lPP5xYIhlgla32J3Iq3pxnfog5EboOCdTJlFagzsWSoPOPUKvYu7
         9CCH884ocs7dQlJB05C42Em5XW8CXEioQg1XDpA6oDVg5B5GXEhnidr1WEW4l5tEpzPK
         DI34PBFq243xDT3yDXP+EAbmhfz903kir27OJn9fo22IAczkgRRNK03a3msuk8vWcvkE
         BD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880948; x=1720485748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwqqkyjuBHOEXV1WHT6bbORSuaZmXG7FUu+JP6jq/8Q=;
        b=YYqGJzO+5zmVpWyWslnVROVctAw85rZ8txHbox5vlAmbbuKvPeax2S1vTFmDole1pv
         qp79T+TXmNakGrBIfr2TxH+Dt5eZwKZeQjf64GGo8a+CV8npO4S7YaEV1aZKMdbdGLei
         30DcRSAOVAiW+yEq6Dog0M6/9IK0aQ0sLb+T04ADAPlkeZ45Dtw/xZ9MfxhZYH674kWR
         L73nIwsBUcwkLM7AdwfmL0/dgn/qVPQwrqu7dBklhatY2EumaRAVOqWp5k09mm7D9Ym7
         WFXtCD72MxqEfgmoQYxBNeGi0NeAWSvdIS7imiq8LSR8kbmNfkF5P+vkeRdINkUN7t9X
         01Iw==
X-Gm-Message-State: AOJu0YzmhUwurbeApujf5xlCG05L4qdSeF6XzapM47Fn6CGR+lsakJOk
	jLJsvQZSmvXDh46TAmD4Lx5z/asm98BpsQ+eLQq+lMtF0TYM84VXyFBxG7mLhOHjdeXBhE1Rk5K
	T7CVPuAApsZuTaCXpB4ijTx58FaQ=
X-Google-Smtp-Source: AGHT+IGq+EJ0A+tv+ihQZXLnckYXtMjMN+ZOmyY7k/jJ76mBLToyvqm6w1L3etCNw7FzrsUcS8JJ94xd8j6rWQXOSkk=
X-Received: by 2002:a05:6a00:3cc6:b0:705:c0a1:61c5 with SMTP id
 d2e1a72fcca58-70aaad6bcefmr5916216b3a.20.1719880947841; Mon, 01 Jul 2024
 17:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-8-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-8-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:42:11 -0700
Message-ID: <CAEf4Bzb1Bt+N7rKDrcgMSyo9=u+4qkD5mrWJtjwYFMg-ZsWrNA@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 7/8] selftests/bpf: allow checking xlated
 programs in verifier_* tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Add a macro __xlated("...") for use with test_loader tests.
>
> When such annotations are present for the test case:
> - bpf_prog_get_info_by_fd() is used to get BPF program after all
>   rewrites are applied by verifier.
> - the program is diassembled and patterns specified in __xlated are

typo: google says there is a typo in disassembled

>   searched for in the disassembly text.
>
> __xlated matching follows the same mechanics as __msg:
> each subsequent pattern is matched from the point where
> previous pattern ended.
>
> This allows to write tests like below, where the goal is to verify the
> behavior of one of the of the transformations applied by verifier:
>
>     SEC("raw_tp")
>     __xlated("1: w0 =3D ")
>     __xlated("2: r0 =3D &(void __percpu *)(r0)")
>     __xlated("3: r0 =3D *(u32 *)(r0 +0)")
>     __xlated("4: exit")
>     __success __naked void simple(void)
>     {
>             asm volatile (
>             "call %[bpf_get_smp_processor_id];"
>             "exit;"
>             :
>             : __imm(bpf_get_smp_processor_id)
>             : __clobber_all);
>     }
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  6 ++
>  tools/testing/selftests/bpf/test_loader.c    | 80 +++++++++++++++++++-
>  2 files changed, 83 insertions(+), 3 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index 81097a3f15eb..fac131a23578 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -26,6 +26,9 @@
>   *
>   * __regex           Same as __msg, but using a regular expression.
>   * __regex_unpriv    Same as __msg_unpriv but using a regular expression=
.
> + * __xlated          Expect a line in a disassembly log after verifier a=
pplies rewrites.
> + *                   Multiple __xlated attributes could be specified.
> + * __xlated_unpriv   Same as __xlated but for unprivileged mode.
>   *
>   * __success         Expect program load success in privileged mode.
>   * __success_unpriv  Expect program load success in unprivileged mode.
> @@ -63,11 +66,14 @@
>   */
>  #define __msg(msg)             __attribute__((btf_decl_tag("comment:test=
_expect_msg=3D" msg)))
>  #define __regex(regex)         __attribute__((btf_decl_tag("comment:test=
_expect_regex=3D" regex)))
> +#define __xlated(msg)          __attribute__((btf_decl_tag("comment:test=
_expect_xlated=3D" msg)))
>  #define __failure              __attribute__((btf_decl_tag("comment:test=
_expect_failure")))
>  #define __success              __attribute__((btf_decl_tag("comment:test=
_expect_success")))
>  #define __description(desc)    __attribute__((btf_decl_tag("comment:test=
_description=3D" desc)))
>  #define __msg_unpriv(msg)      __attribute__((btf_decl_tag("comment:test=
_expect_msg_unpriv=3D" msg)))
>  #define __regex_unpriv(regex)  __attribute__((btf_decl_tag("comment:test=
_expect_regex_unpriv=3D" regex)))
> +#define __xlated_unpriv(msg)   \
> +       __attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=3D=
" msg)))

nit: keep on a single line? you are ruining the beauty :)

>  #define __failure_unpriv       __attribute__((btf_decl_tag("comment:test=
_expect_failure_unpriv")))
>  #define __success_unpriv       __attribute__((btf_decl_tag("comment:test=
_expect_success_unpriv")))
>  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:test=
_log_level=3D"#lvl)))

[...]

