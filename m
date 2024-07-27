Return-Path: <bpf+bounces-35789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8C93DCB6
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF81C22B08
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5617E9;
	Sat, 27 Jul 2024 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBv7LOsF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988C197;
	Sat, 27 Jul 2024 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722041121; cv=none; b=TJdbaEl41TL7wltHzDOyIGORv2gYdAVwsfnrBkmCbfyjnFvcrQPbHTFplU1JGonB7+P8MjkRobsbYmMMD/I76al2cG4WC89xVc4V73Q4/2ZrHSBssynCTmj4Qf5hh3unBliqn5NV1QfsDUBjFVJQIOS60IweNXEcauVf238j7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722041121; c=relaxed/simple;
	bh=39IPtBtO1GXfvZX6W3ZyPZjcfsLqCBeny94reSVi6OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/uqjPhTI5ULWg3VNtBmMa8Xlk/Vtw6t0EGlYKrrghLh2xaaVg7YGkSB0F5nAIL1WuXH2TvvI/Rli1z/OpXcLY7kS1A85rle9Qi/Zk/MVx6R0ZojqaMTlMdM/Kh0sfCQFu7berWum+4ZVdlKBMAQFWWbbjZ/xRmjlvVPV+9a9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBv7LOsF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso1199860b3a.1;
        Fri, 26 Jul 2024 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722041119; x=1722645919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8egn0fZGF49/xtfoowW3HrzSNDejLgPI0dJ4UiIysM=;
        b=DBv7LOsFyOZLVTEw1VkNNS16W41d+1ln0UxoJKH/V+kpStdtAIuESOCTA6YQhsnNGt
         NhTCOAktPrR5T/EfMp4U1Xo/T6sR04DTtmMRqGvK+6HiaIceFF8y2+YmB1T2ws1qzpPt
         vTkZy1WS7jmmGYt7177E2Nb7PgI9pTbd0/LVGvz4LPJLJdleOewQlo21cy1vz1qgleh7
         GRd72/Ui/4uZO9Q+iSRUeO2kQW/KAZCBqWkHLI6zIsfBjxaufBy2QmylwlI8pjbnkA2M
         UlRvTjIvaabufVEgM6NFKDnaMrnCgL6NHv9B8FM2wIfwM9kJs/f0ddyqrSg1XgHEuQVh
         W1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722041119; x=1722645919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8egn0fZGF49/xtfoowW3HrzSNDejLgPI0dJ4UiIysM=;
        b=VTTJ0GlupxpXcBLAbk2vzbCLYUseslAehTvFGAKgWWM786VAPmJ2lvWpxuy3pYzGq3
         kiBoGBmO+st1V11pQMbCkiLR06XMcqL1Nn/Msv6rVy8DTvZkO8eWZR7zu+JCyvbrieJe
         3X6N4BQn4NEN9xNVd6oElpgglnPxt6NprTmsdTLhOYTvmWoI/AcAqVKEnZ8DCaWRNxrG
         50nl2iGRsdLbVIRdqMJsla2HRarguilp1CuVKLFcPgOOIe0trL0V61WWt2E1M7QjyTpl
         49nL6zCLzt1DuncczGpAq5SMb+V1SmXqS4/p/UCcpv68tzrCnlheosQp8zBlATR6YO/w
         45sw==
X-Forwarded-Encrypted: i=1; AJvYcCUQKEeyQwIKW2EYfQuUrlKgSrYnvAgEQg4W+D0s2K657E2U4GCHSDBpIAD9xFibHpjXw9grTcJvb9fZfaKuDNCbcpD3HMs3
X-Gm-Message-State: AOJu0Yw3xqUHAgaguO7l2Rayoq9X6vaOiv6GyGkVpW3R4lnXwSdsdifY
	ybkUYW4g262ntg2PHx445fDMtja7W2AYCI8TC1xTabNvc2GjsMMc+ziFdvc4QiQDkR6jZrvZTD4
	8hvMmtaW59azmLAALPVHuVIkNhEY=
X-Google-Smtp-Source: AGHT+IHDfi4D+XRK2BCxw9AzXur2gnf0lsYT0ddqabUUg/cpQ3V+GFY7KXbXdS2AyA9SS+scWhUUaA6vvRqx+AKeF0k=
X-Received: by 2002:a05:6a20:bf04:b0:1c2:8af6:31c2 with SMTP id
 adf61e73a8af0-1c4a14e8c6bmr1010772637.44.1722041118851; Fri, 26 Jul 2024
 17:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725214029.1760809-1-sdf@fomichev.me>
In-Reply-To: <20240725214029.1760809-1-sdf@fomichev.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:45:06 -0700
Message-ID: <CAEf4BzYonHCyFr7ivRDDUtsJY3MEgWRKwVZ=N0sWjpMrn1dR6A@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when compiling test_cpp
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 2:40=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Jakub reports build failures when merging linux/master with net tree:
>
> CXX      test_cpp
> In file included from <built-in>:454:
> <command line>:2:9: error: '_GNU_SOURCE' macro redefined [-Werror,-Wmacro=
-redefined]
>     2 | #define _GNU_SOURCE
>       |         ^
> <built-in>:445:9: note: previous definition is here
>   445 | #define _GNU_SOURCE 1
>
> The culprit is commit cc937dad85ae ("selftests: centralize -D_GNU_SOURCE=
=3D to
> CFLAGS in lib.mk") which unconditionally added -D_GNU_SOUCE to CLFAGS.
> Apparently clang++ also unconditionally adds it for the C++ targets [0]
> which causes a conflict. Add small change in the selftests makefile
> to filter it out for test_cpp.
>
> Not sure which tree it should go via, targeting bpf for now, but net
> might be better?
>
> 0: https://stackoverflow.com/questions/11670581/why-is-gnu-source-defined=
-by-default-and-how-to-turn-it-off
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index dd49c1d23a60..81d4757ecd4c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -713,7 +713,7 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/netw=
ork_helpers.o $(OUTPUT)/xdp
>  # Make sure we are able to include and link libbpf against c++.
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPF=
OBJ)
>         $(call msg,CXX,,$@)
> -       $(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
> +       $(Q)$(CXX) $(subst -D_GNU_SOURCE=3D,,$(CFLAGS)) $(filter %.a %.o =
%.cpp,$^) $(LDLIBS) -o $@

or we could

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

(though we have 61 places with that...) so as to not have to update
every target in Makefile.


>
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
> --
> 2.45.2
>

