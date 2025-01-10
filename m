Return-Path: <bpf+bounces-48607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B604FA09EBC
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F39C188BF8A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0A221DB1;
	Fri, 10 Jan 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B59H8QoJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AC20764C
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552099; cv=none; b=eHWHFXdHTm4Q9wxj/Mh8eYqFCK02j3Bc8/vyOimDako/RmbysPn35PY8BbFz1JnPYaFwu62KkiYueIevoR15pfRabdGn+EWp+syDWIFTN0kpArqH1MavLf3OAyJOfDOaaIRg7+ZatEE0eFQ1uiNgcIaYFhla/1XrejUlk/DdKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552099; c=relaxed/simple;
	bh=PzJ9li7lI1WswrftcBNl/Szk1WBCGGOKNPbmP46dsFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtnU/x1Hqu2xWErv5tqoQLX90KGTGCDBqaqm8hcHgvI7sPMTRPJOb3ZMArs+M1Qi8KP3AseLlxA8OlaR+LDq7HohHXCfEekCa3q0dVRevc71AVZ/4kQfd2l8Zd1VR9OO/aFrsX0dzlVegFYrs7PADsnsXsCBYmzb7quUol4jGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B59H8QoJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f42992f608so3699867a91.0
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 15:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736552097; x=1737156897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5PooC5+1/QVSpL0fd3hgikgwqw3ncwfDbDmHF4lQNA=;
        b=B59H8QoJUDsTMWKtNUjTzbrMKTwIWKKrwpz8fsbZMjgobnsQkr0lWUO1MCO+jLsM+2
         BoFKV+23K0e+tDkTlD3RB7AYWOuqJm7bd/FtcQM5nrMI+PmskXG32rSYG8rxw316sTAn
         ivimPPmMueVVjrkqYv9iAwXVNCMgau541UjjJKMskmB7tn4V2leIPy6UKrr8XstQkO9X
         r23cDSH4BM6qoYnk6Y7J59Fpry9Z9wG3xDWCAwEf0DgMLtTX/7uoD5L9y9pWeRuYgBHU
         2JA8km/BR9IPc8XNkztXsARPdl7wbqTDFUV/Zs3jfJsNd9TgBxpyvY/8dXnaov57c7T/
         wZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736552097; x=1737156897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5PooC5+1/QVSpL0fd3hgikgwqw3ncwfDbDmHF4lQNA=;
        b=BxhtNMaFQQfLyK5+yKWhwD4rNql84d8BhCjGrvxOFT6Z8bHMcFMIGOS8hik5aONAWp
         2YqQs4669YU422gSVVrhEt7Tvym6lVTN6Y+HzJ10d/u+n3Sogk7YxPvb/ZOykfTrddc4
         +eA6TjdaaMeFd2jciNelFcsFo23Y2ZnkHii1nn5UD7cJqYl/pJTFlTBKPVlrcxsQPWMq
         EbMbCPNUSwFwYqndtX5H5wzHxdSYGj2+TWX4M9Y93E1g0R6H0TZGP/YmbuCjTQlecE0g
         exgMr06qnWdzBm+Rqjmae3qAg0nK+UezTFUXgZ1R/5QX1FvT+RYkabJwoojyZbw1w2eW
         rgiA==
X-Gm-Message-State: AOJu0Yzh9PJ28uHxv2xLlFmnSNFDEOIaEFYLRMGI9LBAarJcDS8S6w0+
	zjpwZj2ql+xH56/tLHRzHtXbeFfr7zSvGcLuVmllxH31nV/JUuiSQwFf9bihpFxkSueo7EqnKgv
	tdZgd7gfYsANacQr3l/aPGUxPO4I=
X-Gm-Gg: ASbGncsEQ3zwnglttd/xjoZolVmJNUMTSrjcCIHrXZ3jljau8jP/neDhtPWNjfh2TxG
	7YBpMpdg9YENHabHErcOVCMwjzI+zYiqMzHuNKppyhKhhMRMmi+4yJA==
X-Google-Smtp-Source: AGHT+IHrXiEC7xQ5qL4bLzL5pZZPvn3XR4ukpBWtGbxuU4CRtH3hpykXlkOSh8hZ/KqpysNXryLavnCY1cjq16EJmvo=
X-Received: by 2002:a17:90b:280a:b0:2ee:d186:fe48 with SMTP id
 98e67ed59e1d1-2f548f1b5cfmr17649268a91.28.1736552097049; Fri, 10 Jan 2025
 15:34:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107235813.2964472-1-ihor.solodrai@pm.me>
In-Reply-To: <20250107235813.2964472-1-ihor.solodrai@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 15:34:45 -0800
X-Gm-Features: AbW1kvagH2NPMZPOfCLUW4SgkmcT3auBW5N73-gpZFT1QUWnbiZkJ5S2v3XbU3Y
Message-ID: <CAEf4BzZ_2=CquVPBD-WgzkfSk5UAqyp1SOeZHTfD+OsVRiKPhw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: add -std=gnu11 to BPF_CFLAGS and CFLAGS
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 3:58=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me> =
wrote:
>
> Latest versions of GCC BPF use C23 standard by default. This causes
> compilation errors in vmlinux.h due to bool types declarations.

Do you have an example of an error? Why can't we fix that to work with C23?

>
> Add -std=3Dgnu11 to BPF_CFLAGS and CFLAGS. This aligns with the version
> of the standard used when building the kernel currently [1].
>
> For more details see the discussions at [2] and [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile#n465
> [2] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2=
qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me=
/
> [3] https://lore.kernel.org/bpf/20250106202715.1232864-1-ihor.solodrai@pm=
.me/
>
> CC: Jose E. Marchesi <jose.marchesi@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/testing/selftests/bpf/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index d5be2f94deef..ea9cee5de0f8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -41,7 +41,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
> -CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                                   =
 \
> +CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11                      =
   \
>           -Wall -Werror -fno-omit-frame-pointer                         \
>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> @@ -447,6 +447,7 @@ CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLAN=
G),$(CLANG_TARGET_ARCH))
>  BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)   =
 \
>              -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
>              -I$(abspath $(OUTPUT)/../usr/include)                      \
> +            -std=3Dgnu11                                                =
 \
>              -fno-strict-aliasing                                       \
>              -Wno-compare-distinct-pointer-types
>  # TODO: enable me -Wsign-compare
> @@ -787,9 +788,12 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/net=
work_helpers.o $(OUTPUT)/xdp
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
>  # Make sure we are able to include and link libbpf against c++.
> +CXXFLAGS +=3D $(CFLAGS)
> +CXXFLAGS :=3D $(subst -D_GNU_SOURCE=3D,,$(CXXFLAGS))
> +CXXFLAGS :=3D $(subst -std=3Dgnu11,-std=3Dgnu++11,$(CXXFLAGS))
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPF=
OBJ)
>         $(call msg,CXX,,$@)
> -       $(Q)$(CXX) $(subst -D_GNU_SOURCE=3D,,$(CFLAGS)) $(filter %.a %.o =
%.cpp,$^) $(LDLIBS) -o $@
> +       $(Q)$(CXX) $(CXXFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
>
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
> --
> 2.47.1
>
>
>

