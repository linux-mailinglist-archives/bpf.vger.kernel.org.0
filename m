Return-Path: <bpf+bounces-13402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D577D8F2E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 09:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC3A28231D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC78DB641;
	Fri, 27 Oct 2023 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkLliwq6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5FD8F7D
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3219C433CC
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698390356;
	bh=9Rl5Eop7IOaHzUdYZOBqYeKV34UkivO8it/7mphES9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MkLliwq6ge2FOPuaCtLhXnXjPw5Qts3o2/ELu/nUQY2jJhFLiZepayoPRB+xFr0ev
	 nzACmn00DPrI4sy6NgEnh9cFHxHQgjC5VxvpsvWgZcZX44HtXGc+SPPlC2ak/jNOLY
	 o4ndsuDD9ASJxb5m5pHh/Q4VDUoAV67QmiQDliPJwMvYQkHlRzGAKqQxOb4C/C717W
	 oAoIkX+RnQB1JJyD6i8xJsi0wUOVaUK21CO83KJN7KMNRRWQNmF3IhaqH5ddV1jpkb
	 q96GJzB2MqApOr9RTKsQkk3DYfIoTX1fwRLwIih6LafJTL2cm5ycJQylyP+CLHsVco
	 XD4WxdyQGExTA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso2856290a12.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 00:05:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxV4QsAislKlDkQMIv3aF5J7KyG3yYPuoBN4X9eUvHEWvClJOhJ
	qVEtJh25kzOaZYeo8yY5BwHPNzUigGrcUVoCw40=
X-Google-Smtp-Source: AGHT+IHaLXIjFdO6pLnNjqLJf11kex4c+jYE5HWGuSLVKekNDzWi83pvpSj8xZoYeNXfmnbrGmj/7ZiNbGYCEMrxmRo=
X-Received: by 2002:aa7:c649:0:b0:53d:fba2:24be with SMTP id
 z9-20020aa7c649000000b0053dfba224bemr1408372edr.15.1698390355102; Fri, 27 Oct
 2023 00:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026184337.563801-1-hengqi.chen@gmail.com> <20231026184337.563801-9-hengqi.chen@gmail.com>
In-Reply-To: <20231026184337.563801-9-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 27 Oct 2023 15:05:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H57Xxq86of8cfcGtq5hVuZ2Z5hCjZSGQZ+kHShXS83xVw@mail.gmail.com>
Message-ID: <CAAhV-H57Xxq86of8cfcGtq5hVuZ2Z5hCjZSGQZ+kHShXS83xVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Enable cpu v4 tests for LoongArch
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kernel@xen0n.name, 
	yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Fri, Oct 27, 2023 at 2:01=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Enable cpu v4 tests for LoongArch. Currently, we don't
> have BPF trampoline in LoongArch JIT, so the fentry
> test `test_ptr_struct_arg` still failed, will followup.
> Test result attached below:
>
>   # ./test_progs -t verifier_sdiv,verifier_movsx,verifier_ldsx,verifier_g=
otol,verifier_bswap
>   #316/1   verifier_bswap/BSWAP, 16:OK
>   #316/2   verifier_bswap/BSWAP, 16 @unpriv:OK
>   #316/3   verifier_bswap/BSWAP, 32:OK
>   #316/4   verifier_bswap/BSWAP, 32 @unpriv:OK
>   #316/5   verifier_bswap/BSWAP, 64:OK
>   #316/6   verifier_bswap/BSWAP, 64 @unpriv:OK
>   #316     verifier_bswap:OK
>   #330/1   verifier_gotol/gotol, small_imm:OK
>   #330/2   verifier_gotol/gotol, small_imm @unpriv:OK
>   #330     verifier_gotol:OK
>   #338/1   verifier_ldsx/LDSX, S8:OK
>   #338/2   verifier_ldsx/LDSX, S8 @unpriv:OK
>   #338/3   verifier_ldsx/LDSX, S16:OK
>   #338/4   verifier_ldsx/LDSX, S16 @unpriv:OK
>   #338/5   verifier_ldsx/LDSX, S32:OK
>   #338/6   verifier_ldsx/LDSX, S32 @unpriv:OK
>   #338/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
>   #338/8   verifier_ldsx/LDSX, S16 range checking:OK
>   #338/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
>   #338/10  verifier_ldsx/LDSX, S32 range checking:OK
>   #338/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
>   #338     verifier_ldsx:OK
>   #349/1   verifier_movsx/MOV32SX, S8:OK
>   #349/2   verifier_movsx/MOV32SX, S8 @unpriv:OK
>   #349/3   verifier_movsx/MOV32SX, S16:OK
>   #349/4   verifier_movsx/MOV32SX, S16 @unpriv:OK
>   #349/5   verifier_movsx/MOV64SX, S8:OK
>   #349/6   verifier_movsx/MOV64SX, S8 @unpriv:OK
>   #349/7   verifier_movsx/MOV64SX, S16:OK
>   #349/8   verifier_movsx/MOV64SX, S16 @unpriv:OK
>   #349/9   verifier_movsx/MOV64SX, S32:OK
>   #349/10  verifier_movsx/MOV64SX, S32 @unpriv:OK
>   #349/11  verifier_movsx/MOV32SX, S8, range_check:OK
>   #349/12  verifier_movsx/MOV32SX, S8, range_check @unpriv:OK
>   #349/13  verifier_movsx/MOV32SX, S16, range_check:OK
>   #349/14  verifier_movsx/MOV32SX, S16, range_check @unpriv:OK
>   #349/15  verifier_movsx/MOV32SX, S16, range_check 2:OK
>   #349/16  verifier_movsx/MOV32SX, S16, range_check 2 @unpriv:OK
>   #349/17  verifier_movsx/MOV64SX, S8, range_check:OK
>   #349/18  verifier_movsx/MOV64SX, S8, range_check @unpriv:OK
>   #349/19  verifier_movsx/MOV64SX, S16, range_check:OK
>   #349/20  verifier_movsx/MOV64SX, S16, range_check @unpriv:OK
>   #349/21  verifier_movsx/MOV64SX, S32, range_check:OK
>   #349/22  verifier_movsx/MOV64SX, S32, range_check @unpriv:OK
>   #349/23  verifier_movsx/MOV64SX, S16, R10 Sign Extension:OK
>   #349/24  verifier_movsx/MOV64SX, S16, R10 Sign Extension @unpriv:OK
>   #349     verifier_movsx:OK
>   #361/1   verifier_sdiv/SDIV32, non-zero imm divisor, check 1:OK
>   #361/2   verifier_sdiv/SDIV32, non-zero imm divisor, check 1 @unpriv:OK
>   #361/3   verifier_sdiv/SDIV32, non-zero imm divisor, check 2:OK
>   #361/4   verifier_sdiv/SDIV32, non-zero imm divisor, check 2 @unpriv:OK
>   #361/5   verifier_sdiv/SDIV32, non-zero imm divisor, check 3:OK
>   #361/6   verifier_sdiv/SDIV32, non-zero imm divisor, check 3 @unpriv:OK
>   #361/7   verifier_sdiv/SDIV32, non-zero imm divisor, check 4:OK
>   #361/8   verifier_sdiv/SDIV32, non-zero imm divisor, check 4 @unpriv:OK
>   #361/9   verifier_sdiv/SDIV32, non-zero imm divisor, check 5:OK
>   #361/10  verifier_sdiv/SDIV32, non-zero imm divisor, check 5 @unpriv:OK
>   #361/11  verifier_sdiv/SDIV32, non-zero imm divisor, check 6:OK
>   #361/12  verifier_sdiv/SDIV32, non-zero imm divisor, check 6 @unpriv:OK
>   #361/13  verifier_sdiv/SDIV32, non-zero imm divisor, check 7:OK
>   #361/14  verifier_sdiv/SDIV32, non-zero imm divisor, check 7 @unpriv:OK
>   #361/15  verifier_sdiv/SDIV32, non-zero imm divisor, check 8:OK
>   #361/16  verifier_sdiv/SDIV32, non-zero imm divisor, check 8 @unpriv:OK
>   #361/17  verifier_sdiv/SDIV32, non-zero reg divisor, check 1:OK
>   #361/18  verifier_sdiv/SDIV32, non-zero reg divisor, check 1 @unpriv:OK
>   #361/19  verifier_sdiv/SDIV32, non-zero reg divisor, check 2:OK
>   #361/20  verifier_sdiv/SDIV32, non-zero reg divisor, check 2 @unpriv:OK
>   #361/21  verifier_sdiv/SDIV32, non-zero reg divisor, check 3:OK
>   #361/22  verifier_sdiv/SDIV32, non-zero reg divisor, check 3 @unpriv:OK
>   #361/23  verifier_sdiv/SDIV32, non-zero reg divisor, check 4:OK
>   #361/24  verifier_sdiv/SDIV32, non-zero reg divisor, check 4 @unpriv:OK
>   #361/25  verifier_sdiv/SDIV32, non-zero reg divisor, check 5:OK
>   #361/26  verifier_sdiv/SDIV32, non-zero reg divisor, check 5 @unpriv:OK
>   #361/27  verifier_sdiv/SDIV32, non-zero reg divisor, check 6:OK
>   #361/28  verifier_sdiv/SDIV32, non-zero reg divisor, check 6 @unpriv:OK
>   #361/29  verifier_sdiv/SDIV32, non-zero reg divisor, check 7:OK
>   #361/30  verifier_sdiv/SDIV32, non-zero reg divisor, check 7 @unpriv:OK
>   #361/31  verifier_sdiv/SDIV32, non-zero reg divisor, check 8:OK
>   #361/32  verifier_sdiv/SDIV32, non-zero reg divisor, check 8 @unpriv:OK
>   #361/33  verifier_sdiv/SDIV64, non-zero imm divisor, check 1:OK
>   #361/34  verifier_sdiv/SDIV64, non-zero imm divisor, check 1 @unpriv:OK
>   #361/35  verifier_sdiv/SDIV64, non-zero imm divisor, check 2:OK
>   #361/36  verifier_sdiv/SDIV64, non-zero imm divisor, check 2 @unpriv:OK
>   #361/37  verifier_sdiv/SDIV64, non-zero imm divisor, check 3:OK
>   #361/38  verifier_sdiv/SDIV64, non-zero imm divisor, check 3 @unpriv:OK
>   #361/39  verifier_sdiv/SDIV64, non-zero imm divisor, check 4:OK
>   #361/40  verifier_sdiv/SDIV64, non-zero imm divisor, check 4 @unpriv:OK
>   #361/41  verifier_sdiv/SDIV64, non-zero imm divisor, check 5:OK
>   #361/42  verifier_sdiv/SDIV64, non-zero imm divisor, check 5 @unpriv:OK
>   #361/43  verifier_sdiv/SDIV64, non-zero imm divisor, check 6:OK
>   #361/44  verifier_sdiv/SDIV64, non-zero imm divisor, check 6 @unpriv:OK
>   #361/45  verifier_sdiv/SDIV64, non-zero reg divisor, check 1:OK
>   #361/46  verifier_sdiv/SDIV64, non-zero reg divisor, check 1 @unpriv:OK
>   #361/47  verifier_sdiv/SDIV64, non-zero reg divisor, check 2:OK
>   #361/48  verifier_sdiv/SDIV64, non-zero reg divisor, check 2 @unpriv:OK
>   #361/49  verifier_sdiv/SDIV64, non-zero reg divisor, check 3:OK
>   #361/50  verifier_sdiv/SDIV64, non-zero reg divisor, check 3 @unpriv:OK
>   #361/51  verifier_sdiv/SDIV64, non-zero reg divisor, check 4:OK
>   #361/52  verifier_sdiv/SDIV64, non-zero reg divisor, check 4 @unpriv:OK
>   #361/53  verifier_sdiv/SDIV64, non-zero reg divisor, check 5:OK
>   #361/54  verifier_sdiv/SDIV64, non-zero reg divisor, check 5 @unpriv:OK
>   #361/55  verifier_sdiv/SDIV64, non-zero reg divisor, check 6:OK
>   #361/56  verifier_sdiv/SDIV64, non-zero reg divisor, check 6 @unpriv:OK
>   #361/57  verifier_sdiv/SMOD32, non-zero imm divisor, check 1:OK
>   #361/58  verifier_sdiv/SMOD32, non-zero imm divisor, check 1 @unpriv:OK
>   #361/59  verifier_sdiv/SMOD32, non-zero imm divisor, check 2:OK
>   #361/60  verifier_sdiv/SMOD32, non-zero imm divisor, check 2 @unpriv:OK
>   #361/61  verifier_sdiv/SMOD32, non-zero imm divisor, check 3:OK
>   #361/62  verifier_sdiv/SMOD32, non-zero imm divisor, check 3 @unpriv:OK
>   #361/63  verifier_sdiv/SMOD32, non-zero imm divisor, check 4:OK
>   #361/64  verifier_sdiv/SMOD32, non-zero imm divisor, check 4 @unpriv:OK
>   #361/65  verifier_sdiv/SMOD32, non-zero imm divisor, check 5:OK
>   #361/66  verifier_sdiv/SMOD32, non-zero imm divisor, check 5 @unpriv:OK
>   #361/67  verifier_sdiv/SMOD32, non-zero imm divisor, check 6:OK
>   #361/68  verifier_sdiv/SMOD32, non-zero imm divisor, check 6 @unpriv:OK
>   #361/69  verifier_sdiv/SMOD32, non-zero reg divisor, check 1:OK
>   #361/70  verifier_sdiv/SMOD32, non-zero reg divisor, check 1 @unpriv:OK
>   #361/71  verifier_sdiv/SMOD32, non-zero reg divisor, check 2:OK
>   #361/72  verifier_sdiv/SMOD32, non-zero reg divisor, check 2 @unpriv:OK
>   #361/73  verifier_sdiv/SMOD32, non-zero reg divisor, check 3:OK
>   #361/74  verifier_sdiv/SMOD32, non-zero reg divisor, check 3 @unpriv:OK
>   #361/75  verifier_sdiv/SMOD32, non-zero reg divisor, check 4:OK
>   #361/76  verifier_sdiv/SMOD32, non-zero reg divisor, check 4 @unpriv:OK
>   #361/77  verifier_sdiv/SMOD32, non-zero reg divisor, check 5:OK
>   #361/78  verifier_sdiv/SMOD32, non-zero reg divisor, check 5 @unpriv:OK
>   #361/79  verifier_sdiv/SMOD32, non-zero reg divisor, check 6:OK
>   #361/80  verifier_sdiv/SMOD32, non-zero reg divisor, check 6 @unpriv:OK
>   #361/81  verifier_sdiv/SMOD64, non-zero imm divisor, check 1:OK
>   #361/82  verifier_sdiv/SMOD64, non-zero imm divisor, check 1 @unpriv:OK
>   #361/83  verifier_sdiv/SMOD64, non-zero imm divisor, check 2:OK
>   #361/84  verifier_sdiv/SMOD64, non-zero imm divisor, check 2 @unpriv:OK
>   #361/85  verifier_sdiv/SMOD64, non-zero imm divisor, check 3:OK
>   #361/86  verifier_sdiv/SMOD64, non-zero imm divisor, check 3 @unpriv:OK
>   #361/87  verifier_sdiv/SMOD64, non-zero imm divisor, check 4:OK
>   #361/88  verifier_sdiv/SMOD64, non-zero imm divisor, check 4 @unpriv:OK
>   #361/89  verifier_sdiv/SMOD64, non-zero imm divisor, check 5:OK
>   #361/90  verifier_sdiv/SMOD64, non-zero imm divisor, check 5 @unpriv:OK
>   #361/91  verifier_sdiv/SMOD64, non-zero imm divisor, check 6:OK
>   #361/92  verifier_sdiv/SMOD64, non-zero imm divisor, check 6 @unpriv:OK
>   #361/93  verifier_sdiv/SMOD64, non-zero imm divisor, check 7:OK
>   #361/94  verifier_sdiv/SMOD64, non-zero imm divisor, check 7 @unpriv:OK
>   #361/95  verifier_sdiv/SMOD64, non-zero imm divisor, check 8:OK
>   #361/96  verifier_sdiv/SMOD64, non-zero imm divisor, check 8 @unpriv:OK
>   #361/97  verifier_sdiv/SMOD64, non-zero reg divisor, check 1:OK
>   #361/98  verifier_sdiv/SMOD64, non-zero reg divisor, check 1 @unpriv:OK
>   #361/99  verifier_sdiv/SMOD64, non-zero reg divisor, check 2:OK
>   #361/100 verifier_sdiv/SMOD64, non-zero reg divisor, check 2 @unpriv:OK
>   #361/101 verifier_sdiv/SMOD64, non-zero reg divisor, check 3:OK
>   #361/102 verifier_sdiv/SMOD64, non-zero reg divisor, check 3 @unpriv:OK
>   #361/103 verifier_sdiv/SMOD64, non-zero reg divisor, check 4:OK
>   #361/104 verifier_sdiv/SMOD64, non-zero reg divisor, check 4 @unpriv:OK
>   #361/105 verifier_sdiv/SMOD64, non-zero reg divisor, check 5:OK
>   #361/106 verifier_sdiv/SMOD64, non-zero reg divisor, check 5 @unpriv:OK
>   #361/107 verifier_sdiv/SMOD64, non-zero reg divisor, check 6:OK
>   #361/108 verifier_sdiv/SMOD64, non-zero reg divisor, check 6 @unpriv:OK
>   #361/109 verifier_sdiv/SMOD64, non-zero reg divisor, check 7:OK
>   #361/110 verifier_sdiv/SMOD64, non-zero reg divisor, check 7 @unpriv:OK
>   #361/111 verifier_sdiv/SMOD64, non-zero reg divisor, check 8:OK
>   #361/112 verifier_sdiv/SMOD64, non-zero reg divisor, check 8 @unpriv:OK
>   #361/113 verifier_sdiv/SDIV32, zero divisor:OK
>   #361/114 verifier_sdiv/SDIV32, zero divisor @unpriv:OK
>   #361/115 verifier_sdiv/SDIV64, zero divisor:OK
>   #361/116 verifier_sdiv/SDIV64, zero divisor @unpriv:OK
>   #361/117 verifier_sdiv/SMOD32, zero divisor:OK
>   #361/118 verifier_sdiv/SMOD32, zero divisor @unpriv:OK
>   #361/119 verifier_sdiv/SMOD64, zero divisor:OK
>   #361/120 verifier_sdiv/SMOD64, zero divisor @unpriv:OK
>   #361     verifier_sdiv:OK
>   Summary: 5/163 PASSED, 0 SKIPPED, 0 FAILED
>
>   # ./test_progs -t ldsx_insn
>   test_map_val_and_probed_memory:PASS:test_ldsx_insn__open 0 nsec
>   test_map_val_and_probed_memory:PASS:test_ldsx_insn__load 0 nsec
>   libbpf: prog 'test_ptr_struct_arg': failed to attach: ERROR: strerror_r=
(-524)=3D22
>   libbpf: prog 'test_ptr_struct_arg': failed to auto-attach: -524
>   test_map_val_and_probed_memory:FAIL:test_ldsx_insn__attach unexpected e=
rror: -524 (errno 524)
>   #116/1   ldsx_insn/map_val and probed_memory:FAIL
>   #116/2   ldsx_insn/ctx_member_sign_ext:OK
>   #116/3   ldsx_insn/ctx_member_narrow_sign_ext:OK
>   #116     ldsx_insn:FAIL
Thank you for your effort, but why is there a failure? Can it be solved?

Huacai

>
>   All error logs:
>   test_map_val_and_probed_memory:PASS:test_ldsx_insn__open 0 nsec
>   test_map_val_and_probed_memory:PASS:test_ldsx_insn__load 0 nsec
>   libbpf: prog 'test_ptr_struct_arg': failed to attach: ERROR: strerror_r=
(-524)=3D22
>   libbpf: prog 'test_ptr_struct_arg': failed to auto-attach: -524
>   test_map_val_and_probed_memory:FAIL:test_ldsx_insn__attach unexpected e=
rror: -524 (errno 524)
>   #116/1   ldsx_insn/map_val and probed_memory:FAIL
>   #116     ldsx_insn:FAIL
>   Summary: 0/2 PASSED, 0 SKIPPED, 1 FAILED
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_bswap.c | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_gotol.c | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_movsx.c | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/t=
esting/selftests/bpf/progs/test_ldsx_insn.c
> index 3ddcb3777912..2a2a942737d7 100644
> --- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> +++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> @@ -7,7 +7,8 @@
>
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>       (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||       \
> -     defined(__TARGET_ARCH_s390)) && __clang_major__ >=3D 18
> +     defined(__TARGET_ARCH_s390) || defined(__TARGET_ARCH_loongarch)) &&=
 \
> +     __clang_major__ >=3D 18
>  const volatile int skip =3D 0;
>  #else
>  const volatile int skip =3D 1;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/t=
esting/selftests/bpf/progs/verifier_bswap.c
> index 107525fb4a6a..e61755656e8d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
> @@ -6,7 +6,8 @@
>
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
> +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> +       defined(__TARGET_ARCH_loongarch)) && \
>         __clang_major__ >=3D 18
>
>  SEC("socket")
> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/t=
esting/selftests/bpf/progs/verifier_gotol.c
> index 9f202eda952f..d1edbcff9a18 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
> @@ -6,7 +6,8 @@
>
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
> +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> +       defined(__TARGET_ARCH_loongarch)) && \
>         __clang_major__ >=3D 18
>
>  SEC("socket")
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
> index 375525329637..d4427d8e1217 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -6,7 +6,8 @@
>
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
> +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> +       defined(__TARGET_ARCH_loongarch)) && \
>         __clang_major__ >=3D 18
>
>  SEC("socket")
> diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/t=
esting/selftests/bpf/progs/verifier_movsx.c
> index b2a04d1179d0..cbb9d6714f53 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> @@ -6,7 +6,8 @@
>
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
> +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> +       defined(__TARGET_ARCH_loongarch)) && \
>         __clang_major__ >=3D 18
>
>  SEC("socket")
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
> index 8fc5174808b2..2a2271cf0294 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> @@ -6,7 +6,8 @@
>
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
> +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> +       defined(__TARGET_ARCH_loongarch)) && \
>         __clang_major__ >=3D 18
>
>  SEC("socket")
> --
> 2.34.1
>

