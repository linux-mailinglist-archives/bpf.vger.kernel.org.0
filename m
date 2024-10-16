Return-Path: <bpf+bounces-42237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1669A1423
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDBB1C22055
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EED2144A9;
	Wed, 16 Oct 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzpnOB5I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EAF9C1
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111046; cv=none; b=Wpt6i+lpQKHNU0i17ed6rBrNvzVcnqT4+SJEfBfXlUJmuUS5Wrg0DTGXDgX21wp23TfM6DwgAokcOnxv+JLWj8H7gTHUV9rSVCHqM6BL6V76imJLMoNb6J1w6JKIvEwtLU19+1t4xoCYnrdJwyfSh7bvUHJvfdPFNHsZ8wEDzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111046; c=relaxed/simple;
	bh=n+LuRcW6fyH67kn8BZCtb4pyDOVdb2VNmVU/ez7TFeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr+JN8zV9wKP5FchLVz3Aj4J/9lI7jBpcVUX8gsNwr7A53iMTdZ6O/qg6yVPvJIhJ5KviXBvkOAc0kQfYreR5mu9vQPOaOcdoNuOn36qdzFA8O8HhkLenStnC7jdYDM4WbP7awzoDh2Hw1vVIGV3BMv/ErHc9mvWkCnJKRi8O5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzpnOB5I; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so161074a12.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729111044; x=1729715844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApAeu7DuMyN3bcrhgO4z87fgD+XDMMvt1NJmCxRrNMU=;
        b=jzpnOB5IzKpxvruvHf0RpJtb3jjlWK6BnNLYcGfHx1xGo3Po5nW3ATHA6IEr1hjYVI
         pJ76g2UklFci4baULDOeFmDnisv78uOUQsJkxHwYSTVpwi9jWI44B689bOjuN0Ox6xBI
         /boEiEliim2WehwzUeNRiw5Z+RIqacfmWO8dlKHg9EqsXmvGtdir7/QTe8F3T2xdO0dx
         Hi8yDns//TvgNYLAMpjwjTTSVCin4MhqeucTpwY9PuTYDS9MG3VXkf6K0fbBugAgXyJ/
         eTSCuZTOg/bo/00Dhgmfzir5qL6wwUK7snMKeMfqTyxmwtFv2uGE7raLD58lAcXL/G2/
         tN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111044; x=1729715844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApAeu7DuMyN3bcrhgO4z87fgD+XDMMvt1NJmCxRrNMU=;
        b=EUdW3Y9LOgAUggyr7Uoe19u8Q7f1j+zXdue2/h5go0Opnk9RxwAwmygrZ42Mi4K35D
         3EYXV22fPUIgtlHDeD6Y+9gpQEqxPQeFo0blP+7EbGOZPTnVFHCVeypWd7hD0GUe+jhp
         5f/w1yl+QAuFZQnBFCPF4ovh+SkZw8/jWlk1znVMYMHs0Vn/StYzf9L+dJFn/9zn3foe
         kPcg4Eh86lIFMc4Nyflr9bjX8GKPjHioYG/xc2GvpmlKv09IqNeeCGK3cPcnUs0B6Wog
         HdOIVfUkAWHqn1gV6PptkY9LG4jLo5c4eZrS+mBFW+GHQFGh8to0vnEXxLyAijuM6QhM
         osKQ==
X-Gm-Message-State: AOJu0YyGu4chNGzbtSWEeLnWRgkm63N/v7wU9wJ1WaPwmRLyWUyYpk8N
	m66AadxjxhF2dC+LpusZ4OHYHEs8Vn/SQdevFnIh8bruo7E3bed2JwHwPZ77YOEkalIxCuBf8Bj
	whY1SJQ/yWdcW5/sK79DWPL6oz3j0/w==
X-Google-Smtp-Source: AGHT+IHidCLvAjbhPvmPUSqocUiPdlv5dpJZvCCKxs3uCUqs5x0kDk28KBTtA6M96/36o5jvZJLLPNNjB1zvpe1+B/4=
X-Received: by 2002:a17:90a:4d83:b0:2e2:c1b2:26b2 with SMTP id
 98e67ed59e1d1-2e3ab7c4ddbmr5801897a91.5.1729111043894; Wed, 16 Oct 2024
 13:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728975031.git.vmalik@redhat.com> <08becac5b0b536d918adeb90efd63bdd7dcc856c.1728975031.git.vmalik@redhat.com>
In-Reply-To: <08becac5b0b536d918adeb90efd63bdd7dcc856c.1728975031.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Oct 2024 13:37:12 -0700
Message-ID: <CAEf4BzYv6+v_AUp-xF=1z6spjLc0cp55fg-t=b4-bcwR+LFanA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Allow ignoring some flags for
 Clang builds
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:55=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> There exist compiler flags supported by GCC but not supported by Clang
> (e.g. -specs=3D...). Currently, these cannot be passed to BPF selftests
> builds, even when building with GCC, as some binaries (urandom_read and
> liburandom_read.so) are always built with Clang and the unsupported
> flags make the compilation fail (as -Werror is turned on).
>
> Add new Makefile variable CLANG_FILTEROUT_FLAGS which can be used by
> users to specify which flags (from the user-provided CFLAGS or LDFLAGS)
> should be filtered out for Clang invocations.
>
> This allows to do things like:
>
>     $ CFLAGS=3D"-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1" \
>       CLANG_FILTEROUT_FLAGS=3D"-specs=3D%" \
>       make -C tools/testing/selftests/bpf
>
> Without this patch, the compilation would fail with:
>
>     [...]
>     clang: error: argument unused during compilation: '-specs=3D/usr/lib/=
rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]

maybe we should just not error out (i.e., enable
-Wno-unused-command-line-argument)?

>     make: *** [Makefile:273: /bpf-next/tools/testing/selftests/bpf/libura=
ndom_read.so] Error 1
>     [...]
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index d81583b2aef9..89662fe0470a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -31,6 +31,11 @@ SAN_LDFLAGS  ?=3D $(SAN_CFLAGS)
>  RELEASE                ?=3D
>  OPT_FLAGS      ?=3D $(if $(RELEASE),-O2,-O0)
>
> +# Some flags supported by GCC are not supported by Clang.
> +# This variable allows users to specify such flags so that they can use =
custom
> +# CFLAGS and binaries built with Clang do not fail to build.
> +CLANG_FILTEROUT_FLAGS ?=3D
> +
>  LIBELF_CFLAGS  :=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS    :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || e=
cho -lelf)
>
> @@ -271,7 +276,7 @@ endif
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c li=
burandom_read.map
>         $(call msg,LIB,,$@)
>         $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -                    $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
> +                    $(filter-out -static $(CLANG_FILTEROUT_FLAGS),$(CFLA=
GS) $(LDFLAGS)) \
>                      $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>                      -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-=
id=3Dsha1 \
>                      -Wl,--version-script=3Dliburandom_read.map \
> @@ -280,7 +285,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c ura=
ndom_read_lib2.c liburandom
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/libu=
random_read.so
>         $(call msg,BINARY,,$@)
>         $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> -                    $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter =
%.c,$^) \
> +                    $(filter-out -static $(CLANG_FILTEROUT_FLAGS),$(CFLA=
GS) $(LDFLAGS)) $(filter %.c,$^) \
>                      -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(O=
UTPUT) \
>                      -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-=
id=3Dsha1 \
>                      -Wl,-rpath=3D. -o $@
> --
> 2.47.0
>

