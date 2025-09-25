Return-Path: <bpf+bounces-69754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC6BA0D2E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F81189DF3F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0773C30CD9B;
	Thu, 25 Sep 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyCSQdQS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374962FB093
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821095; cv=none; b=TtCh3mcA/reAy8jbzV7b7+5RSP4olj5Ov1ArwGVsU0l7Wt21Ki8hzY84usiCND9D2APvBfLg7nBqe5vIRlGbXW5e9H6b1iOxyj8M40vNUCeynVoPdnpxykw0L6LdUsTJGuUB9jr8hLRx3Z8sfROqroaBeyLyxk5YPMm1olDk54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821095; c=relaxed/simple;
	bh=uic5NLXZ3Gwk6TwZghx+l81X4gMVRQfY7RrGNWUQ7Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auXfI6JZrGuBUntAPZEEJv3MRHFcxFpdi1eq0kBmMYa2ehBLPnq62u4Xsj94/2kRcjc6FqTMiyw5y7hQ0vAIbNjBN2E9sWHwkLGdNSoIMFwYWJ3UedlooX/FyDuNfaPZCMaPWkzSHqc0IPJ0VDZnbIFvuMiL/KL1kQ3XsrTzTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyCSQdQS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-780f6632e64so690443b3a.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821093; x=1759425893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qGWEFcKf1Q/BMH/xe5kNdjXU907WuDD9TQHcEONvz4=;
        b=RyCSQdQSZTqQ0YP26TUxX9cAZt0GZfWmVzcsg/6nKyLw/03GHFvWvwxWSqQO2Gu9y1
         tBMUCPDAt3JjP3VKXyKxmWdwJZtFW9quO+q4MffPo4FNVqakZT9L1w5Hkd9VnLD88mCM
         41wXaNW0XXRMdtqQeojdQ8EkPxSQJ0hRsnyX9TwnuuyE2EIq3Oy9hhlmm85OuktSHZ4Y
         v5hC60uc/Bk7Bd0gBDsfxCwuEd0j1lFone9ONp9RWHUYN8Q0HMAuaaEPkau38MiedbdG
         IljEJAh9J6SqXFjHatvVN/QamYoCUFh0fiL69yAOBgysOdvoS94qBEqWNRrkEzdun3GN
         osrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821093; x=1759425893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qGWEFcKf1Q/BMH/xe5kNdjXU907WuDD9TQHcEONvz4=;
        b=GkgkdRpa2uLarT/pf42bFjU/epYUcJZmDK9AXNhmYzDY0iX7iN3xuja3Yg5Tj+tJSQ
         fEg0jJ/K+ta29kqVBlMniB1UazAUla1EUr4Kil+985kEefDiI6CmWQ7nsKHSVezwOCl9
         rj049wv2Woa8Aw+T+YqeSOrAQv5GDpdVp0TwF+n5BvAp+cS64WE7iMjhAWTBn5K9lOgG
         cmtcVgCbQjdmes6HkhKP5J0jqzH32a2U4NONoIbYvLHMNhKZZQwOJmMh80mXvsQ9SNpI
         wlUBuKmOWIuI0Gw95CF9sRdI8ziWRa04yu8xNl5eb2pDNiUtTt7GLV3IY9FyW7612NGX
         QtGw==
X-Gm-Message-State: AOJu0Yw0o10OAtRldkP8akml8g3iRuJMaM+IlaKR6qCsY5MGM5YpZaA0
	3Obb8JCPxPvo54pIyQXoaCkgs2uxyeMI6ubTGd+Ce7y1FDXQ/b1O1QthgXe1SseXW4o9v3315g/
	KIvKKJlw/p3mqRdA0fsiTU5vLGngSnkQ=
X-Gm-Gg: ASbGnctjX6F04rOW2Eo5ReFv98uRxkM6mh4Bp3GM5jwLlcyZKn8lqbeaEPbSJs9TiVE
	nGutnWdkmjmuRUdgxFENKHEuGeVzUAz4VnzRx+7VSnlKYffyksJuXh8VoYoWuRBtuOwml3PCDZo
	y46470HTGQ1RvkA7ZhLv/0cAFQ4MdEhykGQWqb296IFrKNQSuof9Z15aEfxMMD4dwXU5emiVwk1
	m8MQmGh6Gn5G14aO5YgK48=
X-Google-Smtp-Source: AGHT+IF1cmY38iSiCpyQnw40ZuYKLljDr6khypvNT+srsTL/4Xar1WHSbWp2jzFJi25Z8p7njhvgPwEjacIHTL82YmM=
X-Received: by 2002:a05:6a20:6a26:b0:2e0:9b1a:6425 with SMTP id
 adf61e73a8af0-2e7d37f2c7cmr5674507637.52.1758821093555; Thu, 25 Sep 2025
 10:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev> <20250924211716.1287715-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 10:24:39 -0700
X-Gm-Features: AS18NWAPHXouIW6u15vmyeweW5NUjq0Wu_ulwmAdbjT6wmZjfyVCKaCsh-JWbeM
Message-ID: <CAEf4Bza+fdzaPnFs-NWets5TA=80TPdaiydDXo-ykO9OdD_bvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/6] selftests/bpf: update bpf_wq_set_callback macro
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
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


use bpf_ksym_exists(), it has additional "fool-proofing" checks

> +               bpf_wq_set_callback(timer, cb, flags) : \
> +               bpf_wq_set_callback_impl(timer, cb, flags, NULL))
>
>  struct bpf_iter_kmem_cache;
>  extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __wea=
k __ksym;
> --
> 2.51.0
>

