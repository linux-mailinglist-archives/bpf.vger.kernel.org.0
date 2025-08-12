Return-Path: <bpf+bounces-65473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C0B23BF0
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCC66269E4
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABF274B29;
	Tue, 12 Aug 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIAw3l7n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD672F067A;
	Tue, 12 Aug 2025 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037976; cv=none; b=PhaSd0GO4AHa62/VQ0Ouo2LVMdxg5KzAnWzr3rsibsY/EkWcNo+irr/+B7ExQNg3kYV7hBBwwbEnBD2oTK1dTj+r17n5vDb2+FGzudDlA2x/OV6B1aIlHMRnrMBeuA7CotvQeaQHj9pvb1SmqKwFJuXExuf/Lfj+Wgij9e+AmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037976; c=relaxed/simple;
	bh=OAaG84eZU+qPGB/fbeTL82s/T/W6TthZU3xvaVe+CQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaHkKHXvAiTuGrCRYPkDIN2AySIUxVDBOxZBxIHg0jxvVfC3yNKhNjuZYqD1lsOmqdxmcbbU3nNhmOkjgdHltR85QNS+IciiVnQ0XsaaFmY9zyPrJI8MmKUmHXi3g5zwFvIQy1P3Oa4lXokx8x44VuXmFIrX58M+xaLDNZACWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIAw3l7n; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3218283cf21so3835880a91.3;
        Tue, 12 Aug 2025 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755037974; x=1755642774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5MOjWlayRrlhOVBwpr6MzdxOCbXWTwIgbhXc4EYyzA=;
        b=VIAw3l7nSguYGbgD0F3ZZXbTO7kIqYl/79SQPDZ2uPXN0nSNvf6Vp39gH5JTT1Q3mc
         poS733j4/e1SyZwuIkXlDyMDZE+y+Bj3E/aVcBE9JWvWvNRlx2N7c3NgSzHDB/5TVNnQ
         VhBQpTMF9drNqdV8gu5ms66V0IRwBs7BYDOZjr8q9lUMRetE4/H8M+8OS8ekWq6qogag
         2LQncbluLadiK5o93KZb2ktWtpVPgAIs0zmmZkMPlcK+ULbYto5e/QfaH2Vmzl23Lv7I
         Oy9xgEXgJLl33GRhvI6FHy75PbcsvfqyvHXJ9BuOSmCmDarOenqK1bkSr51yfMKTvyvI
         +yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037974; x=1755642774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5MOjWlayRrlhOVBwpr6MzdxOCbXWTwIgbhXc4EYyzA=;
        b=mN1CjnW1FO+UsHTAxnkd4s47bh/Rwe6wPGkRIoS8cvTGQWIzC57C0vdWDh/lkTaNt6
         Bm+d/1JhnCZbiIVJIQcmBCLOLw8/oaLh3y3vNfeNxrEQQnLwD1j2g9V8L2mIK+YQMl/O
         fFdahngazB+/FN7ttGPhpTJ5rluk13xMYmdHyVQCcStoiOFHFPI5WF/dvjcrD3om2Hw3
         b5tDq1E9aUnLOpq77ZgefOBk6W6ZF4FwNyKVrAOtj5LG//+rhKYvJWIke7nSLj8lPVJ6
         t4JHMKu9mLD77Wd4BChJwOymgq6UbjpR7p8AIImJCX5y53fdZaFvEU6PK8nM8VPF/4kI
         B7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVewqI9XNh0ft48eMHY4HNQ/gjt71WpjtWCr7bTCxnkUQW51lNsFeQKJv8WadGO3mkHtJ8=@vger.kernel.org, AJvYcCX5o+jktveqRW+DFO0/TIxwtqmuT4XfTIvW9qItmiHtzzpZeFi/Vx++OheVMADQePj1cDEYmTPjzyXfjwtJNcbbWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBmZb/nZzz4ydvQ4PPifIAwG+C4fciRXvl6cynVGn4Lw/6azR
	8bd9HqiDZhumztFq8RxytJC7ZWoSf+F7By0bj2GtPrlxsT5uKwOOGjCOfLHbMOXXM8UVKVix1JY
	EA/uYauTBDwA6iuU4hRIhGfqssYSEW+8=
X-Gm-Gg: ASbGncvJ9hpIu5iMGuz5Pkpd6JITIa2SRNhorBtoZzQjK1LZfz2VBxe8mK3asVge1N4
	nffNMhXGu2QUWXHQIARxczBgChP+cKMvijEtkpwrUq76BfWIQky5ebRrcDtdvhHapYbe1pn0Lww
	cckWe/w/xMUEvxTpI7Zcjv+c6HchaV9Gi3HpzBsPMp81Px+XOxK7AMUrOD24Bo1fkTvlYKvAtQi
	IgjA5z8xsoqsgY2/OMbbO3keBh6BOBNVQ==
X-Google-Smtp-Source: AGHT+IHPyCAR14w4SQDHgp1+FvMbDtpp7vY3wSWbPAWt/p9XpcjJmaFoyXA0NTasFuOinOdpfwCB4zdcbBrsPBwZr+o=
X-Received: by 2002:a17:90a:d88b:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-321d0e8cb0bmr1110379a91.17.1755037974500; Tue, 12 Aug 2025
 15:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812221220.581452-1-jolsa@kernel.org>
In-Reply-To: <20250812221220.581452-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Aug 2025 15:32:40 -0700
X-Gm-Features: Ac12FXy3nfzdD2kAnoojgK5Wv7CqfjJbEsPF-xHjfac4ewfpdB-rKONnmWX5d_4
Message-ID: <CAEf4BzZBe1BkjJDc858W7rv-Eewk+SAoYKGH3qJYO0DP2H3NBQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Check the helper function is valid in get_helper_proto
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 3:12=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> From: Jiri Olsa <olsajiri@gmail.com>
>
> syzbot reported an verifier bug [1] where the helper func pointer
> could be NULL due to disabled config option.
>
> As Alexei suggested we could check on that in get_helper_proto
> directly. Excluding tail_call helper from the check, because it
> is NULL by design and valid in all configs.
>
> [1] https://lore.kernel.org/bpf/68904050.050a0220.7f033.0001.GAE@google.c=
om/
> Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/verifier.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..5e38489656e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11344,6 +11344,13 @@ static bool can_elide_value_nullness(enum bpf_ma=
p_type type)
>         }
>  }
>
> +static bool is_valid_proto(const struct bpf_func_proto *fn)
> +{
> +       if (fn =3D=3D &bpf_tail_call_proto)
> +               return true;

ugh... what if we set bpf_tail_call_proto's .func to (void *)0xDEADBAD
or some such and avoid this special casing?

> +       return fn && fn->func;
> +}
> +
>  static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
>                             const struct bpf_func_proto **ptr)
>  {
> @@ -11354,7 +11361,7 @@ static int get_helper_proto(struct bpf_verifier_e=
nv *env, int func_id,
>                 return -EINVAL;
>
>         *ptr =3D env->ops->get_func_proto(func_id, env->prog);
> -       return *ptr ? 0 : -EINVAL;

so we explicitly do not want WARN/BUG/verifier_bug() if
!is_valid_proto(), is that right?

> +       return is_valid_proto(*ptr) ? 0 : -EINVAL;
>  }
>
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
> --
> 2.50.1
>

