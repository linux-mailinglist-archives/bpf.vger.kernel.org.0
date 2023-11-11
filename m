Return-Path: <bpf+bounces-14810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19A17E86CC
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D1B20C3F
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 00:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460D39D;
	Sat, 11 Nov 2023 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq6Xh41d"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3D373
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 00:07:18 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71163C39;
	Fri, 10 Nov 2023 16:07:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso4141985a12.0;
        Fri, 10 Nov 2023 16:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699661234; x=1700266034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oejyImQL8cx/b1SYjw2AOt2fwAipkrscA0ZrisyqjeE=;
        b=Eq6Xh41dpubLPjNB43+n5wSgxnWQZpHFweiWd9GFzVI9wIR40TUZYPZ3EDcdnk+0pn
         GOFxueyS8W/JRNSi2ZRXBLpMnTDZadIWrvUnCOlEpOUv/SEVmKgSIzKQu7vek8HMGVaT
         FWW/bvh0CwLHqX6ljI0LCzISyMyleareVA6oUKwgxjWqtaWIckZQDHzlc+S09ecknV24
         qI7temxO/jVnUs1XohW8ZA2npwlW4uGYCUwp1e4VuPLHgr/MQpQA74Y0XZ5/B3iPUHxH
         1TTasBBchpAr+l5Gkqj0s1iS8nDin/g22C4aYzkJIbc/9aTF2Tu8ZIQnXjIwPRg4CLCz
         /RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699661234; x=1700266034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oejyImQL8cx/b1SYjw2AOt2fwAipkrscA0ZrisyqjeE=;
        b=dyOYM31rM5w3Z6DLGoFh0KF1AztIQLettydN54+o8zjwO2NMqSg1E5I9Otce57iMMA
         yxrbniZdYMlYIrMFlQX002LkxpqQWSyhVHO0bh4GApbrYFaBbbSMkNjcRtbMEYTLFTy1
         sy+E4ncrLXLS9e8mZoLA2lsx5tYaWzby8vog1u4M7qwLcvIW6k7c/bhOEAtm+y5vHv+5
         4Iq9c+6KC47XiP+9IglrkpFvjQoejKzuEWf/GZvrqpBMurOJOAUcod0n2+EltxnSnfGY
         8Qzzmg0/MmJJWW4wcD4dn/sD/KS72FYArpYt3i+3bLwUPX/vZ/Qef+dtjtOoPjcIZyxm
         /AZQ==
X-Gm-Message-State: AOJu0YxbP59Mr1AdOODusKGH9iVnfZ8GRtoS8TOcJ8R/k5lXw6usc/lO
	uL3ZRnIsGa4SIOZP7T57+n1OuwFaotozd4wPvfY=
X-Google-Smtp-Source: AGHT+IGwAgLaDe4aM1mbP0XaFnl84VNH7U2c2+ESEjGLDM6TpUgFy7MSQDkYgSQcBKuIMn6znjzmbTnLD00dvRBHwSo=
X-Received: by 2002:aa7:cfcf:0:b0:523:100b:462b with SMTP id
 r15-20020aa7cfcf000000b00523100b462bmr526721edy.5.1699661233588; Fri, 10 Nov
 2023 16:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org>
In-Reply-To: <20231110222038.1450156-1-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 16:07:02 -0800
Message-ID: <CAEf4BzY=GvSYPm2zOXowNS0yMuvu1=fqoDey=DyZg0j9KtQyiA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 2:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> # Background
>
> LSM hooks (callbacks) are currently invoked as indirect function calls. T=
hese
> callbacks are registered into a linked list at boot time as the order of =
the
> LSMs can be configured on the kernel command line with the "lsm=3D" comma=
nd line
> parameter.
>
> Indirect function calls have a high overhead due to retpoline mitigation =
for
> various speculative execution attacks.
>
> Retpolines remain relevant even with newer generation CPUs as recently
> discovered speculative attacks, like Spectre BHB need Retpolines to mitig=
ate
> against branch history injection and still need to be used in combination=
 with
> newer mitigation features like eIBRS.
>
> This overhead is especially significant for the "bpf" LSM which allows th=
e user
> to implement LSM functionality with eBPF program. In order to facilitate =
this
> the "bpf" LSM provides a default callback for all LSM hooks. When enabled=
,
> the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
> especially bad in OS hot paths (e.g. in the networking stack).
> This overhead prevents the adoption of bpf LSM on performance critical
> systems, and also, in general, slows down all LSMs.
>
> Since we know the address of the enabled LSM callbacks at compile time an=
d only
> the order is determined at boot time, the LSM framework can allocate stat=
ic
> calls for each of the possible LSM callbacks and these calls can be updat=
ed once
> the order is determined at boot.
>
> This series is a respin of the RFC proposed by Paul Renauld (renauld@goog=
le.com)
> and Brendan Jackman (jackmanb@google.com) [1]
>
> # Performance improvement
>
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benef=
itting
> the most.
>
> Here are the results of the relevant Unixbench system benchmarks with BPF=
 LSM
> and SELinux enabled with default policies enabled with and without these
> patches.
>
> Benchmark                                               Delta(%): (+ is b=
etter)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Execl Throughput                                             +1.9356
> File Write 1024 bufsize 2000 maxblocks                       +6.5953
> Pipe Throughput                                              +9.5499
> Pipe-based Context Switching                                 +3.0209
> Process Creation                                             +2.3246
> Shell Scripts (1 concurrent)                                 +1.4975
> System Call Overhead                                         +2.7815
> System Benchmarks Index Score (Partial Only):                +3.4859
>
> In the best case, some syscalls like eventfd_create benefitted to about ~=
10%.
> The full analysis can be viewed at https://kpsingh.ch/lsm-perf
>
> [1] https://lore.kernel.org/linux-security-module/20200820164753.3256899-=
1-jackmanb@chromium.org/
>
>
> # BPF LSM Side effects
>
> Patch 4 of the series also addresses the issues with the side effects of =
the
> default value return values of the BPF LSM callbacks and also removes the
> overheads associated with them making it deployable at hyperscale.
>
> # v7 to v8
>
> * Addressed Andrii's feedback
> * Rebased (this seems to have removed the syscall changes). v7 has the re=
quired
>   conflict resolution incase the conflicts need to be resolved again.
>
> # v6 -> v7
>
> * Rebased with latest LSM id changes merged
>
> NOTE: The warning shown by the kernel test bot is spurious, there is no f=
lex array
> and it seems to come from an older tool chain.
>
> https://lore.kernel.org/bpf/202310111711.wLbijitj-lkp@intel.com/
>
> # v5 -> v6
>
> * Fix a bug in BPF LSM hook toggle logic.
>
> # v4 -> v5
>
> * Rebase to linux-next/master
> * Fixed the case where MAX_LSM_COUNT comes to zero when just CONFIG_SECUR=
ITY
>   is compiled in without any other LSM enabled as reported here:
>
>   https://lore.kernel.org/bpf/202309271206.d7fb60f9-oliver.sang@intel.com
>
> # v3 -> v4
>
> * Refactor LSM count macros to use COUNT_ARGS
> * Change CONFIG_SECURITY_HOOK_LIKELY likely's default value to be based o=
n
>   the LSM enabled and have it depend on CONFIG_EXPERT. There are a lot of=
 subtle
>   options behind CONFIG_EXPERT and this should, hopefully alleviate conce=
rns
>   about yet another knob.
> * __randomize_layout for struct lsm_static_call and, in addition to the c=
over
>   letter add performance numbers to 3rd patch and some minor commit messa=
ge
>   updates.
> * Rebase to linux-next.
>
> # v2 -> v3
>
> * Fixed a build issue on archs which don't have static calls and enable
>   CONFIG_SECURITY.
> * Updated the LSM_COUNT macros based on Andrii's suggestions.
> * Changed the security_ prefix to lsm_prefix based on Casey's suggestion.
> * Inlined static_branch_maybe into lsm_for_each_hook on Kees' feedback.
>
> # v1 -> v2 (based on linux-next, next-20230614)
>
> * Incorporated suggestions from Kees
> * Changed the way MAX_LSMs are counted from a binary based generator to a=
 clever header.
> * Add CONFIG_SECURITY_HOOK_LIKELY to configure the likelihood of LSM hook=
s.
>
>
> KP Singh (5):
>   kernel: Add helper macros for loop unrolling
>   security: Count the LSMs enabled at compile time
>   security: Replace indirect LSM hook calls with static calls
>   bpf: Only enable BPF LSM hooks when an LSM program is attached
>   security: Add CONFIG_SECURITY_HOOK_LIKELY
>
>  include/linux/bpf_lsm.h   |   5 +
>  include/linux/lsm_count.h | 114 +++++++++++++++++++++
>  include/linux/lsm_hooks.h |  81 +++++++++++++--
>  include/linux/unroll.h    |  36 +++++++
>  kernel/bpf/trampoline.c   |  24 +++++
>  security/Kconfig          |  11 ++
>  security/bpf/hooks.c      |  25 ++++-
>  security/security.c       | 209 +++++++++++++++++++++++++-------------
>  8 files changed, 425 insertions(+), 80 deletions(-)
>  create mode 100644 include/linux/lsm_count.h
>  create mode 100644 include/linux/unroll.h
>
> --
> 2.42.0.869.gea05f2083d-goog
>
>

(carrying it over from v7) For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

