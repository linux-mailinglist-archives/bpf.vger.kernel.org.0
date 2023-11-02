Return-Path: <bpf+bounces-13932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229CD7DEF3D
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4CD281B85
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669B125B6;
	Thu,  2 Nov 2023 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd0aPXOH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AB125A3;
	Thu,  2 Nov 2023 09:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51702C433C7;
	Thu,  2 Nov 2023 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698918792;
	bh=JQ4IzgN1tIeQMye2/+gyuWS8feDEz0F5Fh8il3PCjmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kd0aPXOHlZgwv3BGBPZU+dOVFXmi6HrzuGTY02GKMwAzImZvnEta3GSFBX4ObnLWE
	 uCxAh3lfEFEvmyolqD1bS2an+KFlsLC4J3OHhI85xVMwZhOc/YzGMW8MyaA0WuFQT6
	 GwsirYTDe6q4aXxc+3a6AdsuzToN9yYpaJtIYVzrHG7f5um5hffoYBo4hW4nSInPib
	 4K3uZ1SAC4q0QrLpe/htwqxltyYhJQ+lAs58n12kDOwa1iIV6tvV0GyyTnEf16dYLj
	 yMXpa7HYIuDSBqf1swD+suQdTvIlOSxjtxzkdC7gdgEfnKJ11OGPmuZgZ/ceApR6xT
	 XSOtymfcbtOug==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, linux-kernel@vger.kernel.org, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@rivosinc.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 bpf@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
 llvm@lists.linux.dev
Subject: Re: [PATCH] tools/build: Add clang cross-compilation flags to
 feature detection
In-Reply-To: <ZUNsFkZWxws6c5Vx@krava>
References: <20231102081441.240280-1-bjorn@kernel.org> <ZUNsFkZWxws6c5Vx@krava>
Date: Thu, 02 Nov 2023 10:53:09 +0100
Message-ID: <871qd81ny2.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa <olsajiri@gmail.com> writes:

> On Thu, Nov 02, 2023 at 09:14:41AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> When a tool cross-build has LLVM=3D1 set, the clang cross-compilation
>> flags are not passed to the feature detection build system. This
>> results in the host's features are detected instead of the targets.
>>=20
>> E.g, triggering a cross-build of bpftool:
>>=20
>>   cd tools/bpf/bpftool
>>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- LLVM=3D1
>>=20
>> would report the host's, and not the target's features.
>>=20
>> Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
>> feature detection makefile.
>>=20
>> Fixes: cebdb7374577 ("tools: Help cross-building with clang")
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  tools/build/Makefile.feature | 2 +-
>>  tools/build/feature/Makefile | 8 ++++----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>> index 934e2777a2db..25b009a6c05f 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -8,7 +8,7 @@ endif
>>=20=20
>>  feature_check =3D $(eval $(feature_check_code))
>>  define feature_check_code
>> -  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$=
(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))=
" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"=
$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATUR=
ES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
>> +  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$=
(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))=
" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"=
$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" CLANG_CROSS_FLAGS=3D"$(CLANG_CROS=
S_FLAGS)" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev=
/null && echo 1 || echo 0)
>>  endef
>>=20=20
>>  feature_set =3D $(eval $(feature_set_code))
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index dad79ede4e0a..0231a53024c7 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -84,12 +84,12 @@ PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>>=20=20
>>  all: $(FILES)
>>=20=20
>> -__BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.=
c,$(@F)) $(LDFLAGS)
>> +__BUILD =3D $(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $=
@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
>>    BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
>>    BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
>>    BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D=
2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED)=
 -DPACKAGE=3D'"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
>>=20=20
>> -__BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.b=
in,%.cpp,$(@F)) $(LDFLAGS)
>> +__BUILDXX =3D $(CXX) $(CXXFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror=
 -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
>>    BUILDXX =3D $(__BUILDXX) > $(@:.bin=3D.make.output) 2>&1
>>=20=20
>>  ###############################
>> @@ -259,10 +259,10 @@ $(OUTPUT)test-reallocarray.bin:
>>  	$(BUILD)
>>=20=20
>>  $(OUTPUT)test-libbfd-liberty.bin:
>> -	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE=3D'"perf"'=
 $(LDFLAGS) -lbfd -ldl -liberty
>> +	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c=
 -DPACKAGE=3D'"perf"' $(LDFLAGS) -lbfd -ldl -liberty
>>=20=20
>>  $(OUTPUT)test-libbfd-liberty-z.bin:
>> -	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE=3D'"perf"'=
 $(LDFLAGS) -lbfd -ldl -liberty -lz
>> +	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c=
 -DPACKAGE=3D'"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
>
> should we add this also to test-compile-32.bin/test-compile-x32.bin
> targets?

Ah, yes!

I'll spin a v2 with:
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0231a53024c7..c4458345e564 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -283,10 +283,10 @@ $(OUTPUT)test-libbabeltrace.bin:
        $(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabe=
ltrace)
=20
 $(OUTPUT)test-compile-32.bin:
-       $(CC) -m32 -o $@ test-compile.c
+       $(CC) $(CLANG_CROSS_FLAGS) -m32 -o $@ test-compile.c
=20
 $(OUTPUT)test-compile-x32.bin:
-       $(CC) -mx32 -o $@ test-compile.c
+       $(CC) $(CLANG_CROSS_FLAGS) -mx32 -o $@ test-compile.c
=20
 $(OUTPUT)test-zlib.bin:
        $(BUILD) -lz


Thanks for having a look, jirka!


Bj=C3=B6rn

