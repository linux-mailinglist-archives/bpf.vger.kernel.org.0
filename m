Return-Path: <bpf+bounces-41444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D099709A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185DA2839F8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665FB1FB3F7;
	Wed,  9 Oct 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRrm/ZpR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485E1E32BB;
	Wed,  9 Oct 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488854; cv=none; b=ZQPTLzK5j4Y9sPVHo3cwt+d3fgOnvq/c2tFFWcu1iL7siVcFgmA/RMxaHjbABXsV4jFi98ekdSpCW8wDRIX7p6Z1TNrKvTowF6Q9/JxukjGIzZIxci/VBjqfM/hn54ssXocoeGZK8gQoCklTPNuYbP1mUdjL0rzoJ5EwbL1gEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488854; c=relaxed/simple;
	bh=xEBUO24ik2NfKd22BHQ9wyBGEOMHQv6JyR0aYMKRXQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTAj1qtebJk1P+6eSCEgD/gPsXdMNg2MM18tY9aU68OBWOWA88sUFo3kRfQ+2nggLnLd4UXxgw9pzxdVaujXlcibs20/maSXjo7RVop0uD9PrYlUXP/IWSsS9UAYL4msn7I2/pCzHk/w6PFd56S5hJJXmK0ABAQQXNHNHqrFtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRrm/ZpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350FAC4AF0B;
	Wed,  9 Oct 2024 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728488853;
	bh=xEBUO24ik2NfKd22BHQ9wyBGEOMHQv6JyR0aYMKRXQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qRrm/ZpR0SGKnG1Gm4fTlBrcPxXQZqdaChybtVwAgMiNvKqNZQ8aUkBYvuNbe9Hoh
	 mrRGu003kgQpPNuOzIAZFNRmMMHvofjQiDpc6tyc+X3FE2Jiu2bTowaWeif0cpUTye
	 IhuUL3Lgt/E1GktiBkpaXzYTHLhx2AGkgnVxkNKBXJ9FO5Mg3rD6LvyWkuLS8YGysN
	 LoAnQVEwEbuynCQdLVDPdIzfK3mmPCcF92slEmdOglnGX8EA0lxbUuUJk5xJo6uAFG
	 4ely8ZCAUxhUL/NMCFJ+EP6dJF8SMfBeK0LJ6ZizG0EwD7ysuvPKxHbC6gOTVPSudk
	 RI01h4KQzK2aA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53995380bb3so8622115e87.1;
        Wed, 09 Oct 2024 08:47:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4D2ThttgOVuvSmwRNcieqIMTcq8n0q2Sxyh6w87HWWdzbXENM5kIKHhHSxEnoE9ycPCQLz4RWgBYwcKYF@vger.kernel.org, AJvYcCXOOwxiD0wFBdBEQ+bINuNQ/OrMkWfMM+wYtFNDduVo2mDDYcg2EoGW0aRQ8ylqzxcZycaIGq+Gn1nNOQkj@vger.kernel.org, AJvYcCXUIbZr9Nm3caAAiShEpqEddvQ6A2v75PB8sJlrMYSxnA7Pc7G6F3uUQu6rkRfiiFRTywdIa1nSS3FP24WlEY0IKhGn@vger.kernel.org, AJvYcCXzrlIj1M0RpsmmF8t9X3gwhyXASBu24UaNps8WiGNnBOgqagv9Z7yjOOuxqlJz5TQ1WCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLL1eDtNcqgfdW4V9VFQzow4MZy8LSfQiAC/UGwSYq7pLU+NU
	MoYKtvl0l2/1CakhoK019cJOw6Jy4j60u1IGLnYsJGbasNPEwXP4ZTSKRsnK3TLiqtruaHd33Lk
	yMNB0pKdMRhWg97odLLwRtJ/JHOI=
X-Google-Smtp-Source: AGHT+IF+us6iJthCHb0RPd5fShdbqSzjc62GDQ0NhFOhcw/X7lkmjVwDuMO8LoBaiDVCsoo//uvOhcXjrhPFJiD5kv0=
X-Received: by 2002:a05:6512:2307:b0:539:8f4d:a7dc with SMTP id
 2adb3069b0e04-539c4958651mr1852775e87.48.1728488851814; Wed, 09 Oct 2024
 08:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
In-Reply-To: <20240915205648.830121-1-hbathini@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 10 Oct 2024 00:46:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzqVAJHFg6OyVR1+YgNKo7S=nN1M7w5GJVG1Ygn0QhUA@mail.gmail.com>
Message-ID: <CAK7LNATzqVAJHFg6OyVR1+YgNKo7S=nN1M7w5GJVG1Ygn0QhUA@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] powerpc: Core ftrace rework, support for ftrace
 direct and bpf trampolines
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Naveen N. Rao" <naveen@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Vishal Chourasia <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000002e85f06240d2c76"

--00000000000002e85f06240d2c76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:57=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
> This is v5 of the series posted here:
> https://lore.kernel.org/all/cover.1720942106.git.naveen@kernel.org/
>
> This series reworks core ftrace support on powerpc to have the function
> profiling sequence moved out of line. This enables us to have a single
> nop at kernel function entry virtually eliminating effect of the
> function tracer when it is not enabled. The function profile sequence is
> moved out of line and is allocated at two separate places depending on a
> new config option.
>
> For 64-bit powerpc, the function profiling sequence is also updated to
> include an additional instruction 'mtlr r0' after the usual
> two-instruction sequence to fix link stack imbalance (return address
> predictor) when ftrace is enabled. This showed an improvement of ~10%
> in null_syscall benchmark (NR_LOOPS=3D10000000) on a Power 10 system
> with ftrace enabled.
>
> Finally, support for ftrace direct calls is added based on support for
> DYNAMIC_FTRACE_WITH_CALL_OPS. BPF Trampoline support is added atop this.
>
> Support for ftrace direct calls is added for 32-bit powerpc. There is
> some code to enable bpf trampolines for 32-bit powerpc, but it is not
> complete and will need to be pursued separately.
>
> Patches 1 to 10 are independent of this series and can go in separately
> though. Rest of the patches depend on the series from Benjamin Gray
> adding support for patch_uint() and patch_ulong():
> https://lore.kernel.org/all/172474280311.31690.1489687786264785049.b4-ty@=
ellerman.id.au/



It is getting better.

I attached a diff for improvements.



Also, please run 'shellcheck' and eliminate
as many warnings as you can.






$ shellcheck  arch/powerpc/tools/ftrace-gen-ool-stubs.sh

In arch/powerpc/tools/ftrace-gen-ool-stubs.sh line 19:
num_ool_stubs_text=3D$(${OBJDUMP} -r -j __patchable_function_entries
${vmlinux_o} |

^----------^ SC2086 (info): Double quote to prevent globbing and word
splitting.

Did you mean:
num_ool_stubs_text=3D$(${OBJDUMP} -r -j __patchable_function_entries
"${vmlinux_o}" |


In arch/powerpc/tools/ftrace-gen-ool-stubs.sh line 20:
     grep -v ".init.text" | grep "${RELOCATION}" | wc -l)
                                            ^------------------^
SC2126 (style): Consider using 'grep -c' instead of 'grep|wc -l'.


In arch/powerpc/tools/ftrace-gen-ool-stubs.sh line 21:
num_ool_stubs_inittext=3D$(${OBJDUMP} -r -j __patchable_function_entries
${vmlinux_o} |

^----------^ SC2086 (info): Double quote to prevent globbing and word
splitting.

Did you mean:
num_ool_stubs_inittext=3D$(${OBJDUMP} -r -j __patchable_function_entries
"${vmlinux_o}" |


In arch/powerpc/tools/ftrace-gen-ool-stubs.sh line 22:
grep ".init.text" | grep "${RELOCATION}" | wc -l)
                                             ^------------------^
SC2126 (style): Consider using 'grep -c' instead of 'grep|wc -l'.


In arch/powerpc/tools/ftrace-gen-ool-stubs.sh line 25:
if [ ${num_ool_stubs_text} -gt ${num_ool_stubs_text_builtin} ]; then
     ^-------------------^ SC2086 (info): Double quote to prevent
globbing and word splitting.
                               ^---------------------------^ SC2086
(info): Double quote to prevent globbing and word splitting.

Did you mean:
if [ "${num_ool_stubs_text}" -gt "${num_ool_stubs_text_builtin}" ]; then


In arch/powerpc/tools/ftrace-gen-ool-stubs.sh line 26:
num_ool_stubs_text_end=3D$(expr ${num_ool_stubs_text} -
${num_ool_stubs_text_builtin})
                                 ^--^ SC2003 (style): expr is
antiquated. Consider rewriting this using $((..)), ${} or [[ ]].
                                      ^-------------------^ SC2086
(info): Double quote to prevent globbing and word splitting.

^---------------------------^ SC2086 (info): Double quote to prevent
globbing and word splitting.

Did you mean:
num_ool_stubs_text_end=3D$(expr "${num_ool_stubs_text}" -
"${num_ool_stubs_text_builtin}")


In arch/powerpc/tools/ftrace-gen-ool-stubs.sh line 31:
cat > ${arch_vmlinux_S} <<EOF
      ^---------------^ SC2086 (info): Double quote to prevent
globbing and word splitting.

Did you mean:
cat > "${arch_vmlinux_S}" <<EOF

For more information:
  https://www.shellcheck.net/wiki/SC2086 -- Double quote to prevent globbin=
g ...
  https://www.shellcheck.net/wiki/SC2003 -- expr is antiquated. Consider re=
wr...
  https://www.shellcheck.net/wiki/SC2126 -- Consider using 'grep -c' instea=
d ...











> Changelog v5:
> * Intermediate files named .vmlinux.arch.* instead of .arch.vmlinux.*
> * Fixed ftrace stack tracer failure due to inadvertent use of
>   'add r7, r3, MCOUNT_INSN_SIZE' instruction instead of
>   'addi r7, r3, MCOUNT_INSN_SIZE'
> * Fixed build error for !CONFIG_MODULES case.
> * .vmlinux.arch.* files compiled under arch/powerpc/tools
> * Made sure .vmlinux.arch.* files are cleaned with `make clean`
> * num_ool_stubs_text_end used for setting up ftrace_ool_stub_text_end
>   set to zero instead of computing to some random negative value when
>   not required.
> * Resolved checkpatch.pl warnings.
> * Dropped RFC tag.
>
> Changelog v4:
> - Patches 1, 10 and 13 are new.
> - Address review comments from Nick. Numerous changes throughout the
>   patch series.
> - Extend support for ftrace ool to vmlinux text up to 64MB (patch 13).
> - Address remaining TODOs in support for BPF Trampolines.
> - Update synchronization when patching instructions during trampoline
>   attach/detach.
>
>
> Naveen N Rao (17):
>   powerpc/trace: Account for -fpatchable-function-entry support by
>     toolchain
>   powerpc/kprobes: Use ftrace to determine if a probe is at function
>     entry
>   powerpc64/ftrace: Nop out additional 'std' instruction emitted by gcc
>     v5.x
>   powerpc32/ftrace: Unify 32-bit and 64-bit ftrace entry code
>   powerpc/module_64: Convert #ifdef to IS_ENABLED()
>   powerpc/ftrace: Remove pointer to struct module from dyn_arch_ftrace
>   powerpc/ftrace: Skip instruction patching if the instructions are the
>     same
>   powerpc/ftrace: Move ftrace stub used for init text before _einittext
>   powerpc64/bpf: Fold bpf_jit_emit_func_call_hlp() into
>     bpf_jit_emit_func_call_rel()
>   powerpc/ftrace: Add a postlink script to validate function tracer
>   kbuild: Add generic hook for architectures to use before the final
>     vmlinux link
>   powerpc64/ftrace: Move ftrace sequence out of line
>   powerpc64/ftrace: Support .text larger than 32MB with out-of-line
>     stubs
>   powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
>   powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   samples/ftrace: Add support for ftrace direct samples on powerpc
>   powerpc64/bpf: Add support for bpf trampolines
>
>  arch/Kconfig                                |   6 +
>  arch/powerpc/Kbuild                         |   2 +-
>  arch/powerpc/Kconfig                        |  23 +-
>  arch/powerpc/Makefile                       |   8 +
>  arch/powerpc/Makefile.postlink              |   8 +
>  arch/powerpc/include/asm/ftrace.h           |  33 +-
>  arch/powerpc/include/asm/module.h           |   5 +
>  arch/powerpc/include/asm/ppc-opcode.h       |  14 +
>  arch/powerpc/kernel/asm-offsets.c           |  11 +
>  arch/powerpc/kernel/kprobes.c               |  18 +-
>  arch/powerpc/kernel/module_64.c             |  66 +-
>  arch/powerpc/kernel/trace/Makefile          |  11 +-
>  arch/powerpc/kernel/trace/ftrace.c          | 298 ++++++-
>  arch/powerpc/kernel/trace/ftrace_64_pg.c    |  69 +-
>  arch/powerpc/kernel/trace/ftrace_entry.S    | 244 ++++--
>  arch/powerpc/kernel/vmlinux.lds.S           |   3 +-
>  arch/powerpc/net/bpf_jit.h                  |  12 +
>  arch/powerpc/net/bpf_jit_comp.c             | 847 +++++++++++++++++++-
>  arch/powerpc/net/bpf_jit_comp32.c           |   7 +-
>  arch/powerpc/net/bpf_jit_comp64.c           |  68 +-
>  arch/powerpc/tools/Makefile                 |  12 +
>  arch/powerpc/tools/ftrace-gen-ool-stubs.sh  |  52 ++
>  arch/powerpc/tools/ftrace_check.sh          |  50 ++
>  samples/ftrace/ftrace-direct-modify.c       |  85 +-
>  samples/ftrace/ftrace-direct-multi-modify.c | 101 ++-
>  samples/ftrace/ftrace-direct-multi.c        |  79 +-
>  samples/ftrace/ftrace-direct-too.c          |  83 +-
>  samples/ftrace/ftrace-direct.c              |  69 +-
>  scripts/Makefile.vmlinux                    |   7 +
>  scripts/link-vmlinux.sh                     |   7 +-
>  30 files changed, 2098 insertions(+), 200 deletions(-)
>  create mode 100644 arch/powerpc/tools/Makefile
>  create mode 100755 arch/powerpc/tools/ftrace-gen-ool-stubs.sh
>  create mode 100755 arch/powerpc/tools/ftrace_check.sh
>
> --
> 2.46.0
>


--=20
Best Regards
Masahiro Yamada

--00000000000002e85f06240d2c76
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-fixup.patch"
Content-Disposition: attachment; filename="0001-fixup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m221jiku0>
X-Attachment-Id: f_m221jiku0

RnJvbSAwZTk2Njg5ZWZjOTc3NTQyYTQ3ZTgxNWE3ODg5MjgzM2UwMzA1ZDc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBXZWQsIDkgT2N0IDIwMjQgMjM6Mzc6NDcgKzA5MDAKU3ViamVjdDogW1BBVENIXSBm
aXh1cAoKU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9y
Zz4KLS0tCiBhcmNoL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICst
CiBhcmNoL3Bvd2VycGMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCA1ICsrLS0tCiBh
cmNoL3Bvd2VycGMvdG9vbHMvLmdpdGlnbm9yZSAgICAgICAgICAgICAgfCAyICsrCiBhcmNoL3Bv
d2VycGMvdG9vbHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgfCA3ICsrLS0tLS0KIGFyY2gvcG93
ZXJwYy90b29scy9mdHJhY2UtZ2VuLW9vbC1zdHVicy5zaCB8IDUgKystLS0KIHNjcmlwdHMvTWFr
ZWZpbGUudm1saW51eCAgICAgICAgICAgICAgICAgICB8IDQgKystLQogc2NyaXB0cy9saW5rLXZt
bGludXguc2ggICAgICAgICAgICAgICAgICAgIHwgMiArLQogNyBmaWxlcyBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Bv
d2VycGMvdG9vbHMvLmdpdGlnbm9yZQoKZGlmZiAtLWdpdCBhL2FyY2gvS2NvbmZpZyBiL2FyY2gv
S2NvbmZpZwppbmRleCA4NzgwNjc1MGNmNGUuLmExNTM4OTI3YzhjMSAxMDA2NDQKLS0tIGEvYXJj
aC9LY29uZmlnCisrKyBiL2FyY2gvS2NvbmZpZwpAQCAtMTY4NSw3ICsxNjg1LDcgQEAgY29uZmln
IEFSQ0hfTkVFRF9DTVBYQ0hHXzFfRU1VCiAJYm9vbAogCiBjb25maWcgQVJDSF9XQU5UU19QUkVf
TElOS19WTUxJTlVYCi0JZGVmX2Jvb2wgbgorCWJvb2wKIAloZWxwCiAJICBBbiBhcmNoaXRlY3R1
cmUgY2FuIHNlbGVjdCB0aGlzIGlmIGl0IHByb3ZpZGVzIGFyY2gvPGFyY2g+L3Rvb2xzL01ha2Vm
aWxlCiAJICB3aXRoIC5hcmNoLnZtbGludXgubyB0YXJnZXQgdG8gYmUgbGlua2VkIGludG8gdm1s
aW51eC4KZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9LY29uZmlnIGIvYXJjaC9wb3dlcnBjL0tj
b25maWcKaW5kZXggOGEzMWY2MWYxYjM0Li5jODU0NzBiMjQxMTggMTAwNjQ0Ci0tLSBhL2FyY2gv
cG93ZXJwYy9LY29uZmlnCisrKyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnCkBAIC01NzUsMTMgKzU3
NSwxMiBAQCBjb25maWcgQVJDSF9VU0lOR19QQVRDSEFCTEVfRlVOQ1RJT05fRU5UUlkKIAogY29u
ZmlnIFBQQ19GVFJBQ0VfT1VUX09GX0xJTkUKIAlkZWZfYm9vbCBQUEM2NCAmJiBBUkNIX1VTSU5H
X1BBVENIQUJMRV9GVU5DVElPTl9FTlRSWQotCWRlcGVuZHMgb24gUFBDNjQKIAlzZWxlY3QgQVJD
SF9XQU5UU19QUkVfTElOS19WTUxJTlVYCiAKIGNvbmZpZyBQUENfRlRSQUNFX09VVF9PRl9MSU5F
X05VTV9SRVNFUlZFCiAJaW50ICJOdW1iZXIgb2YgZnRyYWNlIG91dC1vZi1saW5lIHN0dWJzIHRv
IHJlc2VydmUgd2l0aGluIC50ZXh0IgotCWRlZmF1bHQgMzI3NjggaWYgUFBDX0ZUUkFDRV9PVVRf
T0ZfTElORQotCWRlZmF1bHQgMAorCWRlcGVuZHMgb24gUFBDX0ZUUkFDRV9PVVRfT0ZfTElORQor
CWRlZmF1bHQgMzI3NjgKIAloZWxwCiAJICBOdW1iZXIgb2Ygc3R1YnMgdG8gcmVzZXJ2ZSBmb3Ig
dXNlIGJ5IGZ0cmFjZS4gVGhpcyBzcGFjZSBpcwogCSAgcmVzZXJ2ZWQgd2l0aGluIC50ZXh0LCBh
bmQgaXMgZGlzdGluY3QgZnJvbSBhbnkgYWRkaXRpb25hbCBzcGFjZQpkaWZmIC0tZ2l0IGEvYXJj
aC9wb3dlcnBjL3Rvb2xzLy5naXRpZ25vcmUgYi9hcmNoL3Bvd2VycGMvdG9vbHMvLmdpdGlnbm9y
ZQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmVjMzgwYTE0YTA5YQot
LS0gL2Rldi9udWxsCisrKyBiL2FyY2gvcG93ZXJwYy90b29scy8uZ2l0aWdub3JlCkBAIC0wLDAg
KzEsMiBAQAorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cisvdm1saW51
eC5hcmNoLlMKZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy90b29scy9NYWtlZmlsZSBiL2FyY2gv
cG93ZXJwYy90b29scy9NYWtlZmlsZQppbmRleCA5ZWViNmVkZjAyZmUuLjk2ZGJiYzRmM2U2NiAx
MDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL3Rvb2xzL01ha2VmaWxlCisrKyBiL2FyY2gvcG93ZXJw
Yy90b29scy9NYWtlZmlsZQpAQCAtMywxMCArMyw3IEBACiBxdWlldF9jbWRfZ2VuX2Z0cmFjZV9v
b2xfc3R1YnMgPSBHRU4gICAgICRACiAgICAgICBjbWRfZ2VuX2Z0cmFjZV9vb2xfc3R1YnMgPSAk
PCAkKENPTkZJR19QUENfRlRSQUNFX09VVF9PRl9MSU5FX05VTV9SRVNFUlZFKSB2bWxpbnV4Lm8g
JEAKIAotJChvYmopLy52bWxpbnV4LmFyY2guUzogJChzcmMpL2Z0cmFjZS1nZW4tb29sLXN0dWJz
LnNoIHZtbGludXgubyBGT1JDRQorJChvYmopL3ZtbGludXguYXJjaC5TOiAkKHNyYykvZnRyYWNl
LWdlbi1vb2wtc3R1YnMuc2ggdm1saW51eC5vIEZPUkNFCiAJJChjYWxsIGlmX2NoYW5nZWQsZ2Vu
X2Z0cmFjZV9vb2xfc3R1YnMpCiAKLSQob2JqKS8udm1saW51eC5hcmNoLm86ICQob2JqKS8udm1s
aW51eC5hcmNoLlMgRk9SQ0UKLQkkKGNhbGwgaWZfY2hhbmdlZF9ydWxlLGFzX29fUykKLQotY2xl
YW4tZmlsZXMgKz0gLnZtbGludXguYXJjaC5TIC52bWxpbnV4LmFyY2gubwordGFyZ2V0cyArPSB2
bWxpbnV4LmFyY2guUwpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3Rvb2xzL2Z0cmFjZS1nZW4t
b29sLXN0dWJzLnNoIGIvYXJjaC9wb3dlcnBjL3Rvb2xzL2Z0cmFjZS1nZW4tb29sLXN0dWJzLnNo
CmluZGV4IDMzZjVhZTRiYWNlNS4uYzY5YjM3NTMwOWJjIDEwMDc1NQotLS0gYS9hcmNoL3Bvd2Vy
cGMvdG9vbHMvZnRyYWNlLWdlbi1vb2wtc3R1YnMuc2gKKysrIGIvYXJjaC9wb3dlcnBjL3Rvb2xz
L2Z0cmFjZS1nZW4tb29sLXN0dWJzLnNoCkBAIC0xMCwxNiArMTAsMTUgQEAgaXNfZW5hYmxlZCgp
IHsKIAogdm1saW51eF9vPSR7Mn0KIGFyY2hfdm1saW51eF9TPSR7M30KLWFyY2hfdm1saW51eF9v
PSQoZGlybmFtZSAke2FyY2hfdm1saW51eF9TfSkvJChiYXNlbmFtZSAke2FyY2hfdm1saW51eF9T
fSAuUykubwogCiBSRUxPQ0FUSU9OPVJfUFBDNjRfQUREUjY0CiBpZiBpc19lbmFibGVkIENPTkZJ
R19QUEMzMjsgdGhlbgogCVJFTE9DQVRJT049Ul9QUENfQUREUjMyCiBmaQogCi1udW1fb29sX3N0
dWJzX3RleHQ9JCgke0NST1NTX0NPTVBJTEV9b2JqZHVtcCAtciAtaiBfX3BhdGNoYWJsZV9mdW5j
dGlvbl9lbnRyaWVzICR7dm1saW51eF9vfSB8CitudW1fb29sX3N0dWJzX3RleHQ9JCgke09CSkRV
TVB9IC1yIC1qIF9fcGF0Y2hhYmxlX2Z1bmN0aW9uX2VudHJpZXMgJHt2bWxpbnV4X299IHwKIAkJ
ICAgICBncmVwIC12ICIuaW5pdC50ZXh0IiB8IGdyZXAgIiR7UkVMT0NBVElPTn0iIHwgd2MgLWwp
Ci1udW1fb29sX3N0dWJzX2luaXR0ZXh0PSQoJHtDUk9TU19DT01QSUxFfW9iamR1bXAgLXIgLWog
X19wYXRjaGFibGVfZnVuY3Rpb25fZW50cmllcyAke3ZtbGludXhfb30gfAorbnVtX29vbF9zdHVi
c19pbml0dGV4dD0kKCR7T0JKRFVNUH0gLXIgLWogX19wYXRjaGFibGVfZnVuY3Rpb25fZW50cmll
cyAke3ZtbGludXhfb30gfAogCQkJIGdyZXAgIi5pbml0LnRleHQiIHwgZ3JlcCAiJHtSRUxPQ0FU
SU9OfSIgfCB3YyAtbCkKIAogbnVtX29vbF9zdHVic190ZXh0X2J1aWx0aW49JHsxfQpkaWZmIC0t
Z2l0IGEvc2NyaXB0cy9NYWtlZmlsZS52bWxpbnV4IGIvc2NyaXB0cy9NYWtlZmlsZS52bWxpbnV4
CmluZGV4IDhmMDgxMTdmNGE0OC4uZGRkYWQ1NTRlOTEyIDEwMDY0NAotLS0gYS9zY3JpcHRzL01h
a2VmaWxlLnZtbGludXgKKysrIGIvc2NyaXB0cy9NYWtlZmlsZS52bWxpbnV4CkBAIC0yMyw5ICsy
Myw5IEBAIHZtbGludXg6IC52bWxpbnV4LmV4cG9ydC5vCiBlbmRpZgogCiBpZmRlZiBDT05GSUdf
QVJDSF9XQU5UU19QUkVfTElOS19WTUxJTlVYCi12bWxpbnV4OiBhcmNoLyQoU1JDQVJDSCkvdG9v
bHMvLnZtbGludXguYXJjaC5vCit2bWxpbnV4OiBhcmNoLyQoU1JDQVJDSCkvdG9vbHMvdm1saW51
eC5hcmNoLm8KIAotYXJjaC8kKFNSQ0FSQ0gpL3Rvb2xzLy52bWxpbnV4LmFyY2gubzogdm1saW51
eC5vCithcmNoLyQoU1JDQVJDSCkvdG9vbHMvdm1saW51eC5hcmNoLm86IHZtbGludXgubyBGT1JD
RQogCSQoUSkkKE1BS0UpICQoYnVpbGQpPWFyY2gvJChTUkNBUkNIKS90b29scyAkQAogZW5kaWYK
IApkaWZmIC0tZ2l0IGEvc2NyaXB0cy9saW5rLXZtbGludXguc2ggYi9zY3JpcHRzL2xpbmstdm1s
aW51eC5zaAppbmRleCAzM2MxYWE4ZGQ0NjguLjdhY2Y0ZTMxZTUxYyAxMDA3NTUKLS0tIGEvc2Ny
aXB0cy9saW5rLXZtbGludXguc2gKKysrIGIvc2NyaXB0cy9saW5rLXZtbGludXguc2gKQEAgLTIw
MCw3ICsyMDAsNyBAQCAke01BS0V9IC1mICIke3NyY3RyZWV9L3NjcmlwdHMvTWFrZWZpbGUuYnVp
bGQiIG9iaj1pbml0IGluaXQvdmVyc2lvbi10aW1lc3RhbXAubwogCiBhcmNoX3ZtbGludXhfbz0i
IgogaWYgaXNfZW5hYmxlZCBDT05GSUdfQVJDSF9XQU5UU19QUkVfTElOS19WTUxJTlVYOyB0aGVu
Ci0JYXJjaF92bWxpbnV4X289YXJjaC8ke1NSQ0FSQ0h9L3Rvb2xzLy52bWxpbnV4LmFyY2gubwor
CWFyY2hfdm1saW51eF9vPWFyY2gvJHtTUkNBUkNIfS90b29scy92bWxpbnV4LmFyY2gubwogZmkK
IAogYnRmX3ZtbGludXhfYmluX289Ci0tIAoyLjQzLjAKCg==
--00000000000002e85f06240d2c76--

