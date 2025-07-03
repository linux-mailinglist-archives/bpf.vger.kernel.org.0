Return-Path: <bpf+bounces-62324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839FAF811B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309431C87E29
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C0291C29;
	Thu,  3 Jul 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="uv6Rg05O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B9259CB5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569507; cv=none; b=fROeXs/wx8EqRIXhuxZg2tdDtcz3s4KjBqxXO89cvcP2i7QL66NEbokne16+kBoR3FANgOrRbQXHtxuDLFOiQm74mz9P+SiJdzwkomQTTLK1K78aQf6R/nXOU2JmDFJ+VFIcaDiqZEubEZ9ME0n3/+1xF5hEiKz2ze8EiaMtXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569507; c=relaxed/simple;
	bh=RM3ruNfK9GvsjU2eP9l5a9FfDKjwS4oaauaPEStutu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hff4sVd2HjB/gSZOyMCHC9VHBhDsyC3XzcslF+mzuEcYl2Yj96y7drH6vGRV/zkPWx0qCVFMLhlvVmQ+tYoDww25gX9/SaBID2TkEyhLQBlg8TeQSKwKXtomBq11zdXLIQyjUW0y+0SZAC7r5ZniC4PAdGYuRCyl+Z2Pt5R0aKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=uv6Rg05O; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso124806276.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751569504; x=1752174304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3TBJFfLu7z83CNrGFaISYf/Ca1T+wxJPiTkHZ1WfRM=;
        b=uv6Rg05ODGZM2ojGRAQvLbkq6Sd4X8DvyPYHU+JvVGrueNbqVrhAqh0EdvCYcgnPmc
         Q+Pp4vOfe5S9OOHXDCU0w6/RrO4xrsuDzPD5Ow6G4nWl5USy8A3Gnd68OPW1/vkjd4kA
         /+T0YHvo/Fe+D8/XT6bEknz9Xu5G7Tzxy4awBhfsDdTlf0fgXOu1m7wrkkBSiFv7p3j9
         b4zl6ipUBWxAw9AA6mTIKlvL3L1zY3vSSbcZMY9qayQwTOiRS+EtJCyr6xsek4JMZPpr
         Uk8PqxeBFpZR6vaWnL2Inu3xedfUXuOOidGQApJEN+zdzFQjshfuzoP+IxMQ1zUut73z
         1lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751569504; x=1752174304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3TBJFfLu7z83CNrGFaISYf/Ca1T+wxJPiTkHZ1WfRM=;
        b=CRnu950W1HCX/427RBRL1I2S7n/SBSSiiI+3r6odlp1erhzXuUX8X+6DCGpxQhrqd4
         1msyTMK/U4+QEM2IHDQCD7SS/SrQ0FnFv6j+cqEV3cm3jMGb2y2Pd40HhEZATxiUXpbF
         K+Qo9h6DcwsEuJ0ZIVvrc3+RPhzLeFONoljlH/itXnPd08xEggqll75XmVP7/3GV6pEP
         Te0XBb/1dPy5gXmwdWxmRPJNUpYCkZNobn/6xDHk741VoafBmjC2P4AGLbdsIyrqTgk2
         RMoEe0KQ9+CHBPL5c2Ee8+h203IZjAXwGo8qfHKZbreFwxYv4p6AspEAXYqUOtRWcJz8
         fTdw==
X-Gm-Message-State: AOJu0YxGWbysiFobrehI5Arzm69ZjrOONXdGXj9ngpTVk2MJnhWU/WC0
	m5S5Cyx3QX9K0x+0ItxcL5O96oPWxh7H/p6gIeuR1Hs/cAtWzinpl11TpLOdGd8pX10BJAqhb07
	yR1MfaEfNaFoYb2xk7pe+ZnyR0gKlpzrSCRbigBOXKAON8ILPwxf8TRI=
X-Gm-Gg: ASbGnctOO6FNj9r02LT/nWrM0kcbgXO/RIACCuul/1M0gki9nwtDqb3aKzrswMYkMfP
	KZKo+T/OdQPLgVOcXenN9N0kJSgLRilMZ7ndd1EYRM3SKPZYxemZmePbl/sILm4FLgOF0LUeM3s
	KV1HLGiG1tKXIg5fvrbSwLBLSLPBYLeCCSgGpr6HQbH+S/
X-Google-Smtp-Source: AGHT+IFGoqHkXMIpiG2VfGWj2xRQA2EDCK9n6TSr/WGx9wsqjH76vn/hunDTYclMnlr4og4PQzjzj2f0uwYwddPp6QE=
X-Received: by 2002:a05:690c:6007:b0:710:e7ad:9d52 with SMTP id
 00721157ae682-7165a338113mr61803347b3.14.1751569504203; Thu, 03 Jul 2025
 12:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-8-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-8-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 3 Jul 2025 15:04:53 -0400
X-Gm-Features: Ac12FXwHKezTRPLgBq8XEjK4gosL43l6zyGuEatlm96Fz9rZf3SQJsFfBzfEu6c
Message-ID: <CABFh=a6dnmNSgVnuLKZgYwkiyJyG1oOeNp16EgT-j+jAQAjg_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Report may_goto timeout to BPF stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Begin reporting may_goto timeouts to BPF program's stderr stream.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/core.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ab8b3446570c..47dcc4f19050 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3168,6 +3168,22 @@ u64 __weak arch_bpf_timed_may_goto(void)
>         return 0;
>  }
>
> +static noinline void bpf_prog_report_may_goto_violation(void)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +       struct bpf_stream_stage ss;
> +       struct bpf_prog *prog;
> +
> +       prog =3D bpf_prog_find_from_stack();
> +       if (!prog)
> +               return;
> +       bpf_stream_stage(ss, prog, BPF_STDERR, ({
> +               bpf_stream_printk(ss, "ERROR: Timeout detected for may_go=
to instruction\n");
> +               bpf_stream_dump_stack(ss);
> +       }));
> +#endif
> +}
> +
>  u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
>  {
>         u64 time =3D ktime_get_mono_fast_ns();
> @@ -3178,8 +3194,10 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_=
goto *p)
>                 return BPF_MAX_TIMED_LOOPS;
>         }
>         /* Check if we've exhausted our time slice, and zero count. */
> -       if (time - p->timestamp >=3D (NSEC_PER_SEC / 4))
> +       if (unlikely(time - p->timestamp >=3D (NSEC_PER_SEC / 4))) {
> +               bpf_prog_report_may_goto_violation();
>                 return 0;
> +       }
>         /* Refresh the count for the stack frame. */
>         return BPF_MAX_TIMED_LOOPS;
>  }
> --
> 2.47.1
>

