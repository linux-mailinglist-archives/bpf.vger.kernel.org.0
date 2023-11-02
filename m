Return-Path: <bpf+bounces-13883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F17DEAAD
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D40B2818BA
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D617F9;
	Thu,  2 Nov 2023 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBRtVByp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9115CB
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 02:27:01 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B034110;
	Wed,  1 Nov 2023 19:26:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9dbb3d12aefso12166766b.0;
        Wed, 01 Nov 2023 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698892016; x=1699496816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1Edx65uzC1EnKzLKANbkR7/H53UNBzeK+VuIsp0qtI=;
        b=VBRtVByp26vvz0MemWRyhDkJBTJRz7dQFyQ2gaQYo3FnbKEtg9qgrnfwN53a80qk4r
         JnUsTYxGwJnnrySRh3wuNIfsblBu1pGKJUd81VZji8gyw6xSGAV2iEPNGUKDJJvhsduA
         lQU1A232JHFJS5KCHCHfLigWW3KgF1clUQcXc6zFKn34Up59MrsEuBaBBROSqxJiQgTh
         e/xv03uuFg8bhYiWpbe++jyj/jVnLqBmmnaBPXkNd1K1/08cDG1FQNxRF3RM0n06SIuB
         Tg2iVbVxUdvYPQvPl7q4ofRVhx7efjrzny81HbEPMvpHUpIEK21DNgU9vSw85Z6o6L3Q
         z3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698892016; x=1699496816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1Edx65uzC1EnKzLKANbkR7/H53UNBzeK+VuIsp0qtI=;
        b=jf/8PYHresBVDwNZUjwM2orY9PP4tb9eASZyOrKBvJO8iMDXr2lTO7/LgQaR+Ob+tU
         Lz58uNoTIt0WnQPJuAp8U2HjMZoDKJ28cg6oPlaxK4jswxesiUjSy3QB8YVtZyRMLyZT
         VsZfWBmPuq5haO5cgnt1FlG1zkLIHltU2+xpzv9M397DVdXMAKMdMta00zBYtENvcQ5J
         ZHHdoYWGnWsTiWwDjyRfZfgp/7keyBKRq46uEJc2/Ct6Tf0wyyPltyLZCw3asfKLbk9w
         fQ9KfYzAaXvoP61X9I/EEBu1shVTElD+g8ZfJwQjMNsOl0wrST4xujJrNL+Atb2L2rEB
         qkCA==
X-Gm-Message-State: AOJu0Yx5phsKc+NuxGatzvUMhn8HUEyl8SsAu7aNyb+IZkwrfiXF0qU5
	hhOfLuKEG+1kLqKwUurvzHRgL6Fl7RZSXO9jr1g=
X-Google-Smtp-Source: AGHT+IEVVlY0jOiiXtLyGG3vLFItsRLheKVzg+T13ogj6YzfqCVmovo3/OiRR/efnyeJQ3uVs4XnoVgXYL0Q7cwIHsY=
X-Received: by 2002:a17:907:daa:b0:9bd:a063:39d2 with SMTP id
 go42-20020a1709070daa00b009bda06339d2mr3486558ejc.16.1698892015606; Wed, 01
 Nov 2023 19:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org>
In-Reply-To: <20231102005521.346983-1-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 19:26:44 -0700
Message-ID: <CAEf4BzZ7YW1-DOBtGYGjdAZE6QMcrFLo73Xh-0ayr6x8Fss7mw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 5:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
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
>  include/linux/lsm_count.h | 114 +++++++++++++++++++
>  include/linux/lsm_hooks.h |  81 ++++++++++++--
>  include/linux/unroll.h    |  36 ++++++
>  kernel/bpf/trampoline.c   |  24 ++++
>  security/Kconfig          |  11 ++
>  security/bpf/hooks.c      |  25 ++++-
>  security/security.c       | 226 +++++++++++++++++++++++++-------------
>  8 files changed, 434 insertions(+), 88 deletions(-)
>  create mode 100644 include/linux/lsm_count.h
>  create mode 100644 include/linux/unroll.h
>
> --
> 2.42.0.820.g83a721a137-goog
>
>

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

