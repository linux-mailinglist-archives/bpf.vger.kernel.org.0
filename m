Return-Path: <bpf+bounces-9084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA778F114
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847FD281662
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498CB14269;
	Thu, 31 Aug 2023 16:18:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90711CBA
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 16:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE41BC433C8;
	Thu, 31 Aug 2023 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693498708;
	bh=8mihFSvYYGejx9N0MfZQyqwmoRIFUqz4THpIXBeJ4gQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cm+dXHMYOMpdB+oqp24HHZI0Q743h4HkYXXgCxcV4b0Mq7lVAiVowaIp7S1asTz1Y
	 3HAfbYzQAlgq27ijXObLqIDuufPNgVD2Wcfdp1ges0xBS+e5vW0AciQQmx864OJuqY
	 k5rM7816ErCmqGgU4MdL/awjMDZ8O/xIpAnOmSV7euW0XpczSKxgeru0rkAKyVgdRW
	 P+xKYKL64qdrNt08/R3Mpq1imNqpZ1FtaQmWFokjCFP2FhNiLF1fdC4J8Fy1Q8NIbX
	 +XG0puuzhWK7Eqi8tS3qrRScgUk2YxOx6lO4rDK/k2myORRkNsoLPlb3kz6uMlBysX
	 LsXxV9ZGH8C2g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Alexei
 Starovoitov <ast@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Include build flavors for
 install target
In-Reply-To: <abe27949-6e35-07e6-ef29-bbc749fc40d5@iogearbox.net>
References: <20230828183329.546959-1-bjorn@kernel.org>
 <abe27949-6e35-07e6-ef29-bbc749fc40d5@iogearbox.net>
Date: Thu, 31 Aug 2023 18:18:25 +0200
Message-ID: <87ttsf18z2.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 8/28/23 8:33 PM, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> When using the "install" or targets depending on install,
>> e.g. "gen_tar", the BPF machine flavors weren't included.
>>=20
>> A command like:
>>    | make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- O=3D/workspace=
/kbuild \
>>    |    HOSTCC=3Dgcc FORMAT=3D SKIP_TARGETS=3D"arm64 ia64 powerpc sparc6=
4 x86 sgx" \
>>    |    -C tools/testing/selftests gen_tar
>> would not include bpf/no_alu32, bpf/cpuv4, or bpf/bpf-gcc.
>>=20
>> Include the BPF machine flavors for "install" make target.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Looks good and BPF CI also seems to be fine with it, wrt INSTDIRS could w=
e use
> a more appropriate location where we define it? Was thinking sth like:
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 7c77a21c3371..8b724efb8b7f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -50,14 +50,17 @@ TEST_GEN_PROGS =3D test_verifier test_tag test_maps t=
est_lru_map test_lpm_map test
>          test_cgroup_storage \
>          test_tcpnotify_user test_sysctl \
>          test_progs-no_alu32
> +TEST_INST_SUBDIRS :=3D no_alu32
>
>   # Also test bpf-gcc, if present
>   ifneq ($(BPF_GCC),)
>   TEST_GEN_PROGS +=3D test_progs-bpf_gcc
> +TEST_INST_SUBDIRS +=3D bpf_gcc
>   endif
>
>   ifneq ($(CLANG_CPUV4),)
>   TEST_GEN_PROGS +=3D test_progs-cpuv4
> +TEST_INST_SUBDIRS +=3D cpuv4
>   endif
>
> [...]

Ok! I'll spin a v2!

