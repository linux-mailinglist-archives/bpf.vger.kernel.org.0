Return-Path: <bpf+bounces-69778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCDBA1400
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 21:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE6D3816F3
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3631E0E3;
	Thu, 25 Sep 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btgMcyXE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495CD31D746
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829448; cv=none; b=tRMxjcGTuS4X0IP8eWtudCA79bSupdDzNzgbavZvgUt6j6gsKFiF/YBKmxqnwsPA9n4mgwrL3Yctz0wGEhghU9PRj75ZuzCxKO/k7OP7BWKRzzDXpCFNvgV90k6fqq0Ar4/1meANZK26QnJ/jRMgcgVD4sAcugRkSmX1AeIzW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829448; c=relaxed/simple;
	bh=pjWJxaDm5i7+W2bvMI0+orl3tlEoItTaV2bGShqdtrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWNaj5gTaaCJQnXGm7N6kQpUUrbA8u2wMfR6GNG4ZyoLDwiyzQgOPedNaQKn8SsuAEPXyP9q7O4jZsM/UNsEmN3Zisi3rqtMGMJUK8VbjVOx8koai4Tf4etaKa11o8jRcfO1wDUUYr/srqWcx1XjcUX5Opbw46INXVJLv4DACto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btgMcyXE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2731ff54949so4055ad.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758829446; x=1759434246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWIVbuiBuwrZgK3Twemi+KiTjZ5ODWZWrr9NFDHeWqg=;
        b=btgMcyXEL+g3cYqyvjU9NPlwAuymKDL1iAhV+7+8ennyphXZg3Wl2NPplcHmSy5Wce
         4wEk4SsT7nThlGGrgLWGq/UMIE/hyDCf6U7DOkiKdHftAiUMGHXznTXXDexJFlAURIgC
         Wg8ZWvsDo5jS5fayYK2ZwN9cKbrC0xEllPRls8x0CM9ULnuBYbPC6maIS2a0II22FWxU
         DipTTkWsITNVo2jt5+Jt8hfIJD0tMdf7HXPRZt3o3P5grVkfQRcFC4bpSgFdtJko/Xym
         0aJRDBDIL0Qx/k+fKDgMHzLGWgh6dntmCzVEvNPvWMGANO3gAyDRLq78/U3dLDoxhX/n
         qOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829446; x=1759434246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWIVbuiBuwrZgK3Twemi+KiTjZ5ODWZWrr9NFDHeWqg=;
        b=wF04GrViRDkd57SVTomtzWmKsOGLhi4HdtA3NRFnaGQlKQES+oNYkdhMykqlWmyEyZ
         ufrrossqAU0gC2tGEK/vefGIQ8lxAihTQguvkEM0IexnCc9iUXZ3SPi7FSbN6aifMGQR
         Ud25pevSmpwkR86CFEhKSjzoju00PrIFzFUN5D5qimscYeNkWc+E6m2OWmdiWtbz8+eH
         0LfOW8JFD8J5FcmK/d0HZliS8BF1nxZAWjRxcqwvvrmX9hppQ/Px2BwKXaHqyTy04eEN
         NJmnlQNaNOiKMH9efuPRo/TH/TFt2EGKYsZM4MaFXTHkx3Kbb55IyuIeSBD8nhjgV5YG
         UWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzScDJgQzFkm/Yaml+rwuc2442xGSZj/9sLzKRUxe757aSyCl4YLoYMGVTKDUFUDuGyvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGX1UrlSRwxOmNUNmlt1vjHTXp6C6qsMTS4qZReGENfnD2VS9j
	bgZ2L8nN4c/Zo5GqR6i8RGSRHD1mn06LBm3AzcrOOSYVrH9MgvcIgCQMwKqKBhvvv2DipXtrqor
	rjmKjg/DkQOQ7goYKfUVBfYp+Z3eH/BkmmGwDJj/0
X-Gm-Gg: ASbGncv0+8MkiXLVevPuc/guL7h+MvuqykqddmyHcdvQVleKY0JLQOn55KtIjtlwS/3
	jQjhlE9jnpdNJDEZWLmwyOMZrKSA1mfivAwFRnAUYab+B2r/4dvHl3P73CpzMG1IPJqQXPoEa7l
	8XHvuc5l20wqC8y2xcYbQAVXktZnFAwiYNRfRt/C8eaDtWstu7/XeOCtf8IkeaHBB7rDA1vEtN/
	LVUf3RPNjBK3XxxWVDqRqboX/iLGux9nlGrBIcFdQ==
X-Google-Smtp-Source: AGHT+IEUyAVjqPX29ofytiPs9/vT5tWzpQXe+AgtwNfhcQZ1fspmy16qFs8VgNTSSJwUxGbfDch9a94qyUKDSBMfn+g=
X-Received: by 2002:a17:902:d48b:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-27eec9da82amr1083625ad.4.1758829446064; Thu, 25 Sep 2025
 12:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com> <20250925-perf_build_android_ndk-v1-8-8b35aadde3dc@arm.com>
In-Reply-To: <20250925-perf_build_android_ndk-v1-8-8b35aadde3dc@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Sep 2025 12:43:55 -0700
X-Gm-Features: AS18NWBRqTNACmFmffSTOBpsayhFYwgysTlFqWMT9G5XiIoGQQ5fG2mtSFmvcWI
Message-ID: <CAP-5=fV45npmMUVGakzpB0XDMJ+WudiHoanBXzJtrX2442k-YA@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf docs: Document building with Clang
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Quentin Monnet <qmo@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:27=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Add example commands for building perf with Clang.
>
> Since recent Android NDK releases use Clang as the default compiler, a
> separate Android specific document is no longer needed; point to the
> general build documentation instead.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/Documentation/Build.txt   | 18 ++++++++
>  tools/perf/Documentation/android.txt | 82 ++++--------------------------=
------
>  2 files changed, 26 insertions(+), 74 deletions(-)
>
> diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentatio=
n/Build.txt
> index 83dc87c662b63ecc17553a15cc15a6b8d6f01d83..3e4104e605ac0d7d30b4408ef=
413cf1f90b034c1 100644
> --- a/tools/perf/Documentation/Build.txt
> +++ b/tools/perf/Documentation/Build.txt
> @@ -99,3 +99,21 @@ configuration paths for cross building:
>  In this case, the variable PKG_CONFIG_SYSROOT_DIR can be used alongside =
the
>  variable PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH to prepend the sysroot pat=
h to
>  the library paths for cross compilation.
> +
> +5) Build with clang
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +By default, the makefile uses GCC as compiler. With specifying environme=
nt
> +variables HOSTCC, CC and CXX, it allows to build perf with clang.
> +
> +Using clang for native build:
> +
> +  $ HOSTCC=3Dclang CC=3Dclang CXX=3Dclang++ make -C tools/perf
> +
> +Using clang for cross compilation:
> +
> +  $ HOSTCC=3Dclang CC=3Dclang CXX=3Dclang++ \
> +    make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/perf \
> +    NO_LIBELF=3D1 NO_LIBTRACEEVENT=3D1 NO_JEVENTS=3D1

The three NO_-s here are going to cripple the build quite a lot, I
wonder if we can list package dependencies to install and failing that
use the NO_-s.

> +
> +In the example above, due to lack libelf, python and libtraceevent for
> +cross comiplation, disable the features accordingly.

nit: s/comiplation/compilation/

> diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentat=
ion/android.txt
> index 24a59998fc91e814ad96f658d3481d88d798b60c..e65204cf2921f6bd8a7987578=
4c5b3d5487ce05d 100644
> --- a/tools/perf/Documentation/android.txt
> +++ b/tools/perf/Documentation/android.txt
> @@ -1,78 +1,12 @@
>  How to compile perf for Android
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> -I. Set the Android NDK environment
> -------------------------------------------------
> +There have two ways to build perf and run it on Android.

nit: s/There have/There are/

Thanks for doing this series!
Ian

>
> -(a). Use the Android NDK
> -------------------------------------------------
> -1. You need to download and install the Android Native Development Kit (=
NDK).
> -Set the NDK variable to point to the path where you installed the NDK:
> -  export NDK=3D/path/to/android-ndk
> +- The first method is to build perf with static linking, please refer to
> +  Build.txt, section "4) Cross compilation" for how to build a static
> +  perf binary.
>
> -2. Set cross-compiling environment variables for NDK toolchain and sysro=
ot.
> -For arm:
> -  export NDK_TOOLCHAIN=3D${NDK}/toolchains/arm-linux-androideabi-4.9/pre=
built/linux-x86_64/bin/arm-linux-androideabi-
> -  export NDK_SYSROOT=3D${NDK}/platforms/android-24/arch-arm
> -For x86:
> -  export NDK_TOOLCHAIN=3D${NDK}/toolchains/x86-4.9/prebuilt/linux-x86_64=
/bin/i686-linux-android-
> -  export NDK_SYSROOT=3D${NDK}/platforms/android-24/arch-x86
> -
> -This method is only tested for Android NDK versions Revision 11b and lat=
er.
> -perf uses some bionic enhancements that are not included in prior NDK ve=
rsions.
> -You can use method (b) described below instead.
> -
> -(b). Use the Android source tree
> ------------------------------------------------
> -1. Download the master branch of the Android source tree.
> -Set the environment for the target you want using:
> -  source build/envsetup.sh
> -  lunch
> -
> -2. Build your own NDK sysroot to contain latest bionic changes and set t=
he
> -NDK sysroot environment variable.
> -  cd ${ANDROID_BUILD_TOP}/ndk
> -For arm:
> -  ./build/tools/build-ndk-sysroot.sh --abi=3Darm
> -  export NDK_SYSROOT=3D${ANDROID_BUILD_TOP}/ndk/build/platforms/android-=
3/arch-arm
> -For x86:
> -  ./build/tools/build-ndk-sysroot.sh --abi=3Dx86
> -  export NDK_SYSROOT=3D${ANDROID_BUILD_TOP}/ndk/build/platforms/android-=
3/arch-x86
> -
> -3. Set the NDK toolchain environment variable.
> -For arm:
> -  export NDK_TOOLCHAIN=3D${ANDROID_TOOLCHAIN}/arm-linux-androideabi-
> -For x86:
> -  export NDK_TOOLCHAIN=3D${ANDROID_TOOLCHAIN}/i686-linux-android-
> -
> -II. Compile perf for Android
> -------------------------------------------------
> -You need to run make with the NDK toolchain and sysroot defined above:
> -For arm:
> -  make WERROR=3D0 ARCH=3Darm CROSS_COMPILE=3D${NDK_TOOLCHAIN} EXTRA_CFLA=
GS=3D"-pie --sysroot=3D${NDK_SYSROOT}"
> -For x86:
> -  make WERROR=3D0 ARCH=3Dx86 CROSS_COMPILE=3D${NDK_TOOLCHAIN} EXTRA_CFLA=
GS=3D"-pie --sysroot=3D${NDK_SYSROOT}"
> -
> -III. Install perf
> ------------------------------------------------
> -You need to connect to your Android device/emulator using adb.
> -Install perf using:
> -  adb push perf /data/perf
> -
> -If you also want to use perf-archive you need busybox tools for Android.
> -For installing perf-archive, you first need to replace #!/bin/bash with =
#!/system/bin/sh:
> -  sed 's/#!\/bin\/bash/#!\/system\/bin\/sh/g' perf-archive >> /tmp/perf-=
archive
> -  chmod +x /tmp/perf-archive
> -  adb push /tmp/perf-archive /data/perf-archive
> -
> -IV. Environment settings for running perf
> -------------------------------------------------
> -Some perf features need environment variables to run properly.
> -You need to set these before running perf on the target:
> -  adb shell
> -  # PERF_PAGER=3Dcat
> -
> -IV. Run perf
> -------------------------------------------------
> -Run perf on your device/emulator to which you previously connected using=
 adb:
> -  # ./data/perf
> +- The second method is to download Android NDK, then use the contained
> +  clang compiler for building perf. Please refer to Build.txt, section
> +  "5) Build with clang" for details.
>
> --
> 2.34.1
>

