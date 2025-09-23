Return-Path: <bpf+bounces-69349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F0DB9506B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9518A74C2
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767931D375;
	Tue, 23 Sep 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzZ8x08m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3B1CD1E4;
	Tue, 23 Sep 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616749; cv=none; b=qmly+Xwzloi6ld7/lCG3fodVk3PYOYFxJ7+vQv68h+FM6X7aiczvV1VY/vAv36vcXvLKrY9xTI2nnvy8yyucLgTixYDyUKD/G9Hd47V6t0ExvVhfpR1Uezrt/dAHubRV51OVpZqZqSvXLka8/SmpB9QQATaP+DjvueOP1DfeFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616749; c=relaxed/simple;
	bh=fIv8pEZLBHE7mFQUFDB5ovZLJPZ+5ryuc1FjJKdxEDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f75/tj+bYZThE9fEMpH+7OU83EjHDDQ08JPiF6Cygkehh5VfvZGX/UJdJpYpJt0krkLds/a1enaTorrpPlWo8LnP+inj6vyPG4ijaflDWILou7L6CsPkXUbwDOKzoO4lzPrE/ZACe76iAtpmR5MuONPk/1kb7Oez8JnCZ8/fbtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzZ8x08m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E15C4CEF5;
	Tue, 23 Sep 2025 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616748;
	bh=fIv8pEZLBHE7mFQUFDB5ovZLJPZ+5ryuc1FjJKdxEDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uzZ8x08mCxu30gmAHBfjbv3PFlKZ4gtzGKWcPD59zZ67KxgKLHJrp5O/Ov3TY04CC
	 aTeQHu6WnSJyfLkE93Zrfedjg/UQviiz6bJ0ZM0kno3lROnX5BOw2u4dAGtH8ff68U
	 S4JqBKzJmd3z5pWa226kZgx2INZSCrAAqbAvq6y8oOC/YVkGMyZLlfTa83+sJ2cZKp
	 bUS3219Rh0HfPRr+iP7k8Uj4n8pfZgZ2IdpoKt4iM+gO9FNALcqWGpVxjv/B1YFlK+
	 uHLO/raCiffPLQQ38NbUbxBmBQABQgJZpGyv7zOf3/UMbtbIsWGbXt3ARBpKXIX/t+
	 Jf08jsv3lIf7g==
Message-ID: <eea720eb-59d3-4836-8db1-6cd59406206c@kernel.org>
Date: Tue, 23 Sep 2025 09:39:03 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 4/5] bpftool: Add support for signing BPF
 programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
 Paul Moore <paul@paul-moore.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20250921160120.9711-1-kpsingh@kernel.org>
 <20250921160120.9711-5-kpsingh@kernel.org>
 <ee292661-0ffb-413e-be9c-eb21f5379688@kernel.org>
 <CAADnVQ+S1i5wcW3FK9=KhpTr8nxSBCNCvvZvWShDouTbWt9eig@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAADnVQ+S1i5wcW3FK9=KhpTr8nxSBCNCvvZvWShDouTbWt9eig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-09-22 19:31 UTC-0700 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Mon, Sep 22, 2025 at 4:24 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2025-09-21 18:01 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
>>> Two modes of operation being added:
>>>
>>> Add two modes of operation:
>>>
>>> * For prog load, allow signing a program immediately before loading. This
>>>   is essential for command-line testing and administration.
>>>
>>>       bpftool prog load -S -k <private_key> -i <identity_cert> fentry_test.bpf.o
>>>
>>> * For gen skeleton, embed a pre-generated signature into the C skeleton
>>>   file. This supports the use of signed programs in compiled applications.
>>>
>>>       bpftool gen skeleton -S -k <private_key> -i <identity_cert> fentry_test.bpf.o
>>>
>>> Generation of the loader program and its metadata map is implemented in
>>> libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
>>> the program and automates the required steps: freezing the map, creating
>>> an exclusive map, loading, and running. Users can use standard libbpf
>>> APIs directly or integrate loader program generation into their own
>>> toolchains.
>>>
>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>>
>>
>> Acked-by: Quentin Monnet <qmo@kernel.org>
>>
>> Thanks a lot!
>>
>>
>>> ---
>>>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  13 +-
>>>  .../bpftool/Documentation/bpftool-prog.rst    |  14 +-
>>>  tools/bpf/bpftool/Makefile                    |   6 +-
>>>  tools/bpf/bpftool/cgroup.c                    |   4 +
>>>  tools/bpf/bpftool/gen.c                       |  68 +++++-
>>>  tools/bpf/bpftool/main.c                      |  26 ++-
>>>  tools/bpf/bpftool/main.h                      |  11 +
>>>  tools/bpf/bpftool/prog.c                      |  29 ++-
>>>  tools/bpf/bpftool/sign.c                      | 212 ++++++++++++++++++
>>>  9 files changed, 372 insertions(+), 11 deletions(-)
>>>  create mode 100644 tools/bpf/bpftool/sign.c
>>>
>>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>>> index ca860fd97d8d..d0a36f442db7 100644
>>> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>>> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>>> @@ -16,7 +16,7 @@ SYNOPSIS
>>>
>>>  **bpftool** [*OPTIONS*] **gen** *COMMAND*
>>>
>>> -*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
>>> +*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
>>>
>>>  *COMMAND* := { **object** | **skeleton** | **help** }
>>>
>>> @@ -186,6 +186,17 @@ OPTIONS
>>>      skeleton). A light skeleton contains a loader eBPF program. It does not use
>>>      the majority of the libbpf infrastructure, and does not need libelf.
>>>
>>> +-S, --sign
>>> +    For skeletons, generate a signed skeleton. This option must be used with
>>> +    **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
>>> +
>>> +-k <private_key.pem>
>>> +    Path to the private key file in PEM format, required for signing.
>>> +
>>> +-i <certificate.x509>
>>> +    Path to the X.509 certificate file in PEM or DER format, required for
>>> +    signing.
>>> +
>>>  EXAMPLES
>>>  ========
>>>  **$ cat example1.bpf.c**
>>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>> index f69fd92df8d8..009633294b09 100644
>>> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>> @@ -18,7 +18,7 @@ SYNOPSIS
>>>
>>>  *OPTIONS* := { |COMMON_OPTIONS| |
>>>  { **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | **--nomount** } |
>>> -{ **-L** | **--use-loader** } }
>>> +{ **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> ] }
>>
>>
>> Perfect, thank you!
>>
>>
>>>
>>>  *COMMANDS* :=
>>>  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
>>> @@ -248,6 +248,18 @@ OPTIONS
>>>      creating the maps, and loading the programs (see **bpftool prog tracelog**
>>>      as a way to dump those messages).
>>>
>>> +-S, --sign
>>> +    Enable signing of the BPF program before loading. This option must be
>>> +    used with **-k** and **-i**. Using this flag implicitly enables
>>> +    **--use-loader**.
>>> +
>>> +-k <private_key.pem>
>>> +    Path to the private key file in PEM format, required when signing.
>>> +
>>> +-i <certificate.x509>
>>> +    Path to the X.509 certificate file in PEM or DER format, required when
>>> +    signing.
>>> +
>>>  EXAMPLES
>>>  ========
>>>  **# bpftool prog show**
>>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>>> index 9e9a5f006cd2..586d1b2595d1 100644
>>> --- a/tools/bpf/bpftool/Makefile
>>> +++ b/tools/bpf/bpftool/Makefile
>>> @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
>>>  endif
>>>  endif
>>>
>>> -LIBS = $(LIBBPF) -lelf -lz
>>> -LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
>>> +LIBS = $(LIBBPF) -lelf -lz -lcrypto
>>> +LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
>>>
>>>  ifeq ($(feature-libelf-zstd),1)
>>>  LIBS += -lzstd
>>> @@ -194,7 +194,7 @@ endif
>>>
>>>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>>>
>>> -BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
>>> +BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o sign.o)
>>>  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
>>>
>>>  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
>>> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
>>> index 944ebe21a216..ec356deb27c9 100644
>>> --- a/tools/bpf/bpftool/cgroup.c
>>> +++ b/tools/bpf/bpftool/cgroup.c
>>> @@ -2,6 +2,10 @@
>>>  // Copyright (C) 2017 Facebook
>>>  // Author: Roman Gushchin <guro@fb.com>
>>>
>>> +#undef GCC_VERSION
>>> +#ifndef _GNU_SOURCE
>>> +#define _GNU_SOURCE
>>> +#endif
>>>  #define _XOPEN_SOURCE 500
>>>  #include <errno.h>
>>>  #include <fcntl.h>
>>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>>> index 67a60114368f..993c7d9484a4 100644
>>> --- a/tools/bpf/bpftool/gen.c
>>> +++ b/tools/bpf/bpftool/gen.c
>>
>>> @@ -1930,7 +1990,7 @@ static int do_help(int argc, char **argv)
>>>               "       %1$s %2$s help\n"
>>>               "\n"
>>>               "       " HELP_SPEC_OPTIONS " |\n"
>>> -             "                    {-L|--use-loader} }\n"
>>> +             "                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
>>
>>
>> With regards to our discussion on v4 - Sorry, I had not realised
>> removing the braces would make the sync test fail. ACK for keeping them
>> until this is resolved in the test.
>>
>> As for the bash completion, I agree this should not block this series.
>> Please make sure to follow-up with it. I think it should be as follows:
> 
> Quentin,
> since you wrote the patch can you send it ?
> 


Sure, I will

