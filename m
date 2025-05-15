Return-Path: <bpf+bounces-58273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82742AB7C9D
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 06:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01BD8C7E79
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 04:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9285204F99;
	Thu, 15 May 2025 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZutQC7pC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D672605;
	Thu, 15 May 2025 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747282678; cv=none; b=AUxP9DMJUpJeDSS2Q2gTreEhvtavO3nKlkmWpeDft8vfvU3gWbIdNn53O6MbJCUnV97wiblYkwerdw8rHisxQFKTq7kmtcYx8HICKOD/PH/mH5D3+2UDbYD7rqn78zBbtz8GhCwthzk75AyO+tzptaxmt/06eRSjoeDjdwTKQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747282678; c=relaxed/simple;
	bh=oYorAIMsBDyyCSG+trKuqWYvEHEl39Ax0nS9WpLJvGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUjuK8PFQjOdHkcWVLU+W2e67ECj/xt2m2b1vcLwzWgyb3Ak8CIHgpBZud69lYOZGrrdMsIvmcDua4vFzZ+kmijEhWOGCM8S0SQ2NurBL2cU5XJdrHdnWwr5jYJTUQ5W72slGkmX6KZ6hbdXhKGPxIP2K+C9kNHfIO6Hc1G1v70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZutQC7pC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747282677; x=1778818677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oYorAIMsBDyyCSG+trKuqWYvEHEl39Ax0nS9WpLJvGg=;
  b=ZutQC7pCIDjvJL2OF2K4Y2yWkGjJemWDy9e0V7j2Tl/3jcLVGH5Zzord
   0Zn/qnj8kJBroVmv5FSitojAx6G1hcD1wp3K+VsT/NkiTgBIzIk4M1Q+k
   ZldVVbaEsWil5yxh9SJko7cvyQmXHbTDXWEM7pLutS3vOj0u1LGusICov
   hMVSqY052S/SsyP7TD37o4ENVqErIRiYocyCQlcmN2co5fA8P+IwBBdhI
   N378yLy3f+kkc4406XpMBEbfX985nVHeiPS0hc4XWTXylX/RfJuEo2dq8
   1XsgxkYy1GOLkxjIbgXwyJemLSBF7DiuftqJs6FYSU6qrC904XSk1k3l1
   g==;
X-CSE-ConnectionGUID: tf8BtYonS1aL2ISurWEjUw==
X-CSE-MsgGUID: T2fFfzIGSuWTiKew7xnEiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48888925"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="48888925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 21:17:56 -0700
X-CSE-ConnectionGUID: lgV6WdT2TR2+c0kFV7wCrA==
X-CSE-MsgGUID: +/WX806LRQOc0jxdd26R1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143003801"
Received: from mfrick-mobl2.amr.corp.intel.com (HELO desk) ([10.125.146.12])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 21:17:55 -0700
Date: Wed, 14 May 2025 21:17:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
Message-ID: <20250515041659.smhllyarxdwp7cav@desk>
References: <20250512172044.326436266@linuxfoundation.org>
 <g4fpslyse2s6hnprgkbp23ykxn67q5wabbkpivuc3rro5bivo4@sj2o3nd5vwwm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g4fpslyse2s6hnprgkbp23ykxn67q5wabbkpivuc3rro5bivo4@sj2o3nd5vwwm>

On Wed, May 14, 2025 at 07:49:29PM +0800, Shung-Hsi Yu wrote:
> On Mon, May 12, 2025 at 07:37:30PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.14.7 release.
> > There are 197 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Running included BPF selftests with a BPF CI fork (i.e. running on
> GitHub Action x86-64 machines), I observe that that running the BPF
> selftests now takes about 2x the time (from ~25m to ~50m), and
> verif_scale_loop3_fail is timing out, taking more than 6 minutes to run
> compare to the usual single digit second runtime. See [1] for the log.
> 
>   07:59:38.2908767Z #449     verif_scale_loop2:OK
>   07:59:48.2920046Z WATCHDOG: test case verif_scale_loop3_fail executes for 10 seconds...
>   08:01:38.2921924Z WATCHDOG: test case verif_scale_loop3_fail executes for 120 seconds, terminating with SIGSEGV
>   08:01:38.2973073Z #450     verif_scale_loop3_fail:FAIL
>   08:01:38.2973500Z Caught signal #11!
>   08:01:38.2973808Z Stack trace:
>   08:01:38.2974148Z ./test_progs(crash_handler+0x38)[0x564524d62f5c]
>   08:01:38.2974682Z /lib/x86_64-linux-gnu/libc.so.6(+0x45330)[0x7f696f47d330]
>   08:01:38.2975847Z /lib/x86_64-linux-gnu/libc.so.6(syscall+0x1d)[0x7f696f55f25d]
>   08:01:38.2976387Z ./test_progs(+0x41a7cd)[0x564524d9d7cd]
>   08:01:38.2976822Z ./test_progs(+0x41a7f5)[0x564524d9d7f5]
>   08:01:38.2977236Z ./test_progs(+0x41a82e)[0x564524d9d82e]
>   08:01:38.2980004Z ./test_progs(bpf_prog_load+0x681)[0x564524d9e555]
>   08:01:38.2980570Z ./test_progs(+0x408ccc)[0x564524d8bccc]
>   08:01:38.2980969Z ./test_progs(+0x409b89)[0x564524d8cb89]
>   08:01:38.2981337Z ./test_progs(+0x40b87a)[0x564524d8e87a]
>   08:01:38.2981674Z ./test_progs(bpf_object__load+0x26)[0x564524d8eb24]
>   08:01:38.2981943Z ./test_progs(+0x8c160)[0x564524a0f160]
>   08:01:38.2982173Z ./test_progs(+0x8c1c8)[0x564524a0f1c8]
>   08:01:38.2982467Z ./test_progs(test_verif_scale_loop3_fail+0x21)[0x564524a0f59b]
>   08:01:38.2982752Z ./test_progs(+0x3e0500)[0x564524d63500]
>   08:01:38.2982983Z ./test_progs(main+0x5cd)[0x564524d65248]
>   08:01:38.2983261Z /lib/x86_64-linux-gnu/libc.so.6(+0x2a1ca)[0x7f696f4621ca]
>   08:01:38.2983651Z /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x8b)[0x7f696f46228b]
>   08:01:38.2983998Z ./test_progs(_start+0x25)[0x5645249ba4a5]
>   08:08:01.6898496Z libbpf: prog 'while_true': BPF program load failed: -E2BIG
>   08:08:01.6898956Z libbpf: prog 'while_true': -- BEGIN PROG LOAD LOG --
>   08:08:01.6899443Z BPF program is too large. Processed 1000001 insn
>   08:08:01.6899823Z verification time 383390707 usec
>   08:08:01.6900045Z stack depth 16
>   08:08:01.6900621Z processed 1000001 insns (limit 1000000) max_states_per_insn 4 total_states 12347 peak_states 12347 mark_read 1
>   08:08:01.6901359Z -- END PROG LOAD LOG --
>   08:08:01.6901824Z libbpf: prog 'while_true': failed to load: -E2BIG
>   08:08:01.6902368Z libbpf: failed to load object 'loop3.bpf.o'
>   08:08:01.6902858Z scale_test:PASS:expect_error 0 nsec
>   08:08:01.6903248Z #450     verif_scale_loop3_fail:FAIL
> 
> Compare to a day before when such behavior wasn't observed[2], the main
> difference being these additional patches:
> 
>   input-cyttsp5-ensure-minimum-reset-pulse-width.patch
>   input-cyttsp5-fix-power-control-issue-on-wakeup.patch
>   input-mtk-pmic-keys-fix-possible-null-pointer-dereference.patch
>   input-xpad-fix-share-button-on-xbox-one-controllers.patch
>   input-xpad-add-support-for-8bitdo-ultimate-2-wireless-controller.patch
>   input-xpad-fix-two-controller-table-values.patch
>   input-synaptics-enable-intertouch-on-dynabook-portege-x30-d.patch
>   input-synaptics-enable-intertouch-on-dynabook-portege-x30l-g.patch
>   input-synaptics-enable-intertouch-on-dell-precision-m3800.patch
>   input-synaptics-enable-smbus-for-hp-elitebook-850-g1.patch
>   input-synaptics-enable-intertouch-on-tuxedo-infinitybook-pro-14-v5.patch
>   rust-clean-rust-1.88.0-s-unnecessary_transmutes-lint.patch
>   objtool-rust-add-one-more-noreturn-rust-function-for-rust-1.87.0.patch
>   rust-clean-rust-1.88.0-s-warning-about-clippy-disallowed_macros-configuration.patch
>   uio_hv_generic-fix-sysfs-creation-path-for-ring-buffer.patch
>   staging-iio-adc-ad7816-correct-conditional-logic-for-store-mode.patch
>   staging-bcm2835-camera-initialise-dev-in-v4l2_dev.patch
>   staging-axis-fifo-remove-hardware-resets-for-user-errors.patch
>   staging-axis-fifo-correct-handling-of-tx_fifo_depth-for-size-validation.patch
>   x86-mm-eliminate-window-where-tlb-flushes-may-be-inadvertently-skipped.patch
>   mm-fix-folio_pte_batch-on-xen-pv.patch
>   mm-vmalloc-support-more-granular-vrealloc-sizing.patch

Not sure why but this commit seems to related to the failure.

Below is log of bisecting v6.14.6 and v6.14.7-rc2 with the test:

  ./tools/testing/selftests/bpf/vmtest.sh -i -- timeout 20 ./test_progs -t verif_scale_loop3_fail

# good: [e2d3e1fdb530198317501eb7ded4f3a5fb6c881c] Linux 6.14.6
git bisect good e2d3e1fdb530198317501eb7ded4f3a5fb6c881c
# status: waiting for bad commit, 1 good commit known
# bad: [6f7a299729d3dff3ffade04ad8fbddb3b172d637] Linux 6.14.7-rc2
git bisect bad 6f7a299729d3dff3ffade04ad8fbddb3b172d637
# bad: [572ca62a1e819e1ebd317e7c0e35cf7ff382aec6] iio: light: opt3001: fix deadlock due to concurrent flag access
git bisect bad 572ca62a1e819e1ebd317e7c0e35cf7ff382aec6
# good: [5b1202a1e881c45d4500afa3f1f67f2fc3cbae10] fbnic: Improve responsiveness of fbnic_mbx_poll_tx_ready
git bisect good 5b1202a1e881c45d4500afa3f1f67f2fc3cbae10
# good: [3eabb5db037e216e2e9a67a36e989c5f13ae7170] mm: fix folio_pte_batch() on XEN PV
git bisect good 3eabb5db037e216e2e9a67a36e989c5f13ae7170
# bad: [93511db927bafab3499f6fb61061779ddd68f20f] iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
git bisect bad 93511db927bafab3499f6fb61061779ddd68f20f
# bad: [569b32a0099bc2b2a8c827b2238bf785f2632fa7] selftests/mm: fix build break when compiling pkey_util.c
git bisect bad 569b32a0099bc2b2a8c827b2238bf785f2632fa7
# bad: [3d5ccf6020b22773d265ecd6f905d19498af9a4e] mm/userfaultfd: fix uninitialized output field for -EAGAIN race
git bisect bad 3d5ccf6020b22773d265ecd6f905d19498af9a4e
# bad: [336f780075f36e0d1181ce44d6d4197e4a22babc] mm/huge_memory: fix dereferencing invalid pmd migration entry
git bisect bad 336f780075f36e0d1181ce44d6d4197e4a22babc
# bad: [665f26e5de2325e3bca107b632bc2ccac1b9806a] mm: vmalloc: support more granular vrealloc() sizing
git bisect bad 665f26e5de2325e3bca107b632bc2ccac1b9806a
# first bad commit: [665f26e5de2325e3bca107b632bc2ccac1b9806a] mm: vmalloc: support more granular vrealloc() sizing

...
> No patches touch BPF's core component, and while the
> verif_scale_loop3_fail test did time out, the verifier is still
> correctly rejecting it, so shouldn't have anything to do with
> kernel/bpf/. The x86/arm64 BPF patches only affect JIT output, and only
> for cBPF.
> 
> In comparison, with 6.12.29-rc1 I don't observe any timeout or increase
> in runtime[3]. Below is a diff comparing the applied patches in
> 6.12.29-rc1 and 6.14.7-rc1. Seems like 6.14.7-rc1 does not have the
> CALL_NOSPEC patches, but I cannot tell whether that is what makes the
> difference.

Thats because CALL_NOSPEC patches were already part of v6.14.

