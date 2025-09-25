Return-Path: <bpf+bounces-69685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8520B9E82A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241D77ACF08
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF942D7DD1;
	Thu, 25 Sep 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHklCjot"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEF2874E4
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793999; cv=none; b=OQREa1uPLTbTOnwinmP/AvLMStZOmX6ug8aDmGo1yRdvHEicxasseosf7KhZC0vr1N3Uv+2zQ1/h+H3Ylo2yb6x84bYz8at462cEIkxWIOvLZeu7kDHJlg0ntcxPN8if80cAtMKi0imkm8QOfl/Tzkq0lJ2BWEtcFNGoPnhiWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793999; c=relaxed/simple;
	bh=lu9Tc9pURgZ0381dUEwXBCbkX3e5TEeN4qRYRoLV158=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aldyctXvQOomN8dbRIqDDjSijWGQ5ln9fNAWUSGQrwlDC8lqhcIFQBczFu2uNzfvSjJMTrZx949WxwXYVSpMVjMVs4HUerp81z+kjnGl9n2GSkogsEdBFWVHftanCfJfeWCHBX1NFa4v2gQqp9xtT06lpOnfR2S4o4qTkyVYFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHklCjot; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so778770f8f.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758793996; x=1759398796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZcpU2w/VB5YKX06iIgQfBUU6i35jTYfqMGO23xOBP4=;
        b=UHklCjotzVCgszSSsq1v32EDLcxKlRu4szU1a2b3oaBr9pZhVGP0NIOY64YBiSGtzQ
         H8lYKnwa1VzQFAtLSHuTZ6/sBQ9II9ThxzRy6kBMWtokey5FALe2AxmtQfgiI3b7CRZA
         +EsbO0lIzzsSTEu9kL0peL068UUyjUSflva/xP0G+oYhQVN7UcP9PILSimUf5DbdgW6P
         T/uLENxBPymw+kq5ZNQzlitN0miER0HWXlhE8uco4YU/E9zDR80guRW5h+tlRRnMcuc/
         yaAPZc93j6gR9Q7kOpVlojdVVj8bLun/Ta4geqfG0mR4SP6T8Z70ZesYD2Hn9WzGEOSP
         0I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793996; x=1759398796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZcpU2w/VB5YKX06iIgQfBUU6i35jTYfqMGO23xOBP4=;
        b=XUf+DIHNubEjHDd27E9WQ/45XE1P+G4RaPIP3T5S4EGwH43/Hp6h2KzR0lE9B7PVch
         O86JjfP6K6pdlQ+B0tTkPfZ3q01sLQVKvtTZ5REzyAMmVgpmQq5zpijC7Yhc5TtxqDi8
         R7bemdfaZaASGs0pO7hlqQsfKBQfVgkMY9Ufy9sUkDcisf7ozDTlCbCZfhCMLLbH4Wvn
         GlxGRa6n5Yj8fqDSLJ/HbygdS2j9uZGl0QwlRqBNYVCf2ICTKytmVDkX+U9F6bNTeqZH
         mLA8PsSH6V5Gxw0jsdzxuaR+gsu4LqZ7QOxKykSv760n4H5y/8AuMFJGJDkFZliIAwkL
         D2Dw==
X-Gm-Message-State: AOJu0YwhNykR6EFlF6F9h8ufcDoLqdBYnTdYWhNEAtDQ4f1R2HhUIjJZ
	aKBAXc7OfeawGI4ZzrTReeEabfoL/1L9fVUNQXNWK/23REThhwJadJl49Jq15oQgu7BTkPd7esn
	9+OGs7kPdq+CHIwtcjrryatOoji/SDKhn4/dD3qfAAA==
X-Gm-Gg: ASbGncueWwUIUefcz+GrNz3eZ47K65SLWis/Si/4ujacr4Ys2e7gzhSD3iOdTh8Ra3/
	5S77PbtalaEzfcuQvPfCop/drdYRQrj/N/rhLLQCBK/jgmRytl+6hCjRH21BKaMTowkW0js+1Zb
	vCfpoqiZgR5eL68bLxxefXlrZLgl5ELQpwgtmgSkxljfXQXMiM6G9R21Ndh9C4STosCiLMAeVLz
	jAXqsDWhz+9u2aU
X-Google-Smtp-Source: AGHT+IEmU8rnXWa62/3qZo+R7CiKruEkD4ZCa9MZ8GPj2WiUPf+P7ttT+U2icSZcwgkOfcyw7mPkVrfynUcxItvgZY4=
X-Received: by 2002:a05:6000:25c3:b0:3b7:8da6:1bb4 with SMTP id
 ffacd0b85a97d-40e4accc86fmr2650916f8f.58.1758793995865; Thu, 25 Sep 2025
 02:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev> <20250924211716.1287715-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Sep 2025 10:53:03 +0100
X-Gm-Features: AS18NWDbLB5YJC0TDfFpCPIYOHpFNKW8roC_ShfUbE2jyM3iqoVhOozM0foMtQw
Message-ID: <CAADnVQLG1=xr9OWKZna0hjfswZ+pZ8RM3fAtsVd+aYW7xaFFcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/6] selftests/bpf: update bpf_wq_set_callback macro
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> Subsequent patch introduces bpf_wq_set_callback kfunc with an
> implicit bpf_prog_aux argument.
>
> To ensure backward compatibility add a weak declaration and make
> bpf_wq_set_callback macro to check for the new kfunc first.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/testing/selftests/bpf/bpf_experimental.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index d89eda3fd8a3..341408d017ea 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -583,8 +583,13 @@ extern int bpf_wq_start(struct bpf_wq *wq, unsigned =
int flags) __weak __ksym;
>  extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
>                 int (callback_fn)(void *map, int *key, void *value),
>                 unsigned int flags__k, void *aux__ign) __ksym;
> +extern int bpf_wq_set_callback(struct bpf_wq *wq,
> +               int (callback_fn)(void *map, int *key, void *value),
> +               unsigned int flags) __weak __ksym;
>  #define bpf_wq_set_callback(timer, cb, flags) \
> -       bpf_wq_set_callback_impl(timer, cb, flags, NULL)
> +       (bpf_wq_set_callback ? \
> +               bpf_wq_set_callback(timer, cb, flags) : \
> +               bpf_wq_set_callback_impl(timer, cb, flags, NULL))

There is also drivers/hid/bpf/progs/hid_bpf_helpers.h
Pls double check that hid-bpf still compiles and works.

