Return-Path: <bpf+bounces-58186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33651AB6A80
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 13:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596CA3B6CDC
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2942749C0;
	Wed, 14 May 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VIq02RZS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFF270EC5
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223388; cv=none; b=ih+nQayKF4/aUM9y6e6ZrmduI/7AD9A+YWP9Rwig/nlub6kNSM4hBUhjcCjzyuj3/twVLxFCMGWAe4IWE6DTmVVWtT+4yfhCBiIbms4YD/4grPEt3s0iN5+KFl/058X6DybDoHp8j+w3CUqwnJERxldx6oHXtLpDUwgSEg4m/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223388; c=relaxed/simple;
	bh=wHkGKmnonszYmzAouw9lwCAd9b5jDgrFKhaTYOQFrsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHKoMiSSVQyz53AM4m7c/GIQNwAi4tscVK9+irjICvtphkUqn+Teve1Vb/h47offldRXXkTmfhdEmlP3NVQhVBx/qZQ6ANq9v8LNc49vH1OsxaOEkNsBQWYGlVjKMzFm74sI9vzJdwNPXpX07FQ0CMvSWwLIQ2i7ZQam+tvfAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VIq02RZS; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so3598017f8f.1
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747223383; x=1747828183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVDInadNESruAdh66j0qSpOh8ieFDLD3Ak5W5M0GS8Y=;
        b=VIq02RZSHrV1kiO0RUQgfxckpDhD6RL6rclD+u2A7QobntNh7NfnEiCquno2ykfiKS
         Zta9SIr3oPbNGP9GDxgO3nRWncm3Na8hZjJJ0kHgsUPlzElBXUSMskixMVpxWWVx6963
         ALTEApkQ2QWtL+r+6NJ11TLc/b8Gu3rshG8TxJ4RFeySDSslhUBhFu2tpBsCRB4aedyX
         WlNDqzZFudf025/HDvHAXI0m2QM3GoGy2i6Lq35SywCr4gMuB47bYto2uSBNQnl4wR2X
         8/uhYfJZud4BFsTB3a0B/hiYAxvMJ6zaCZzVeIduIm3kr0VsFTwOIQMzc4BWL5bUZmSP
         g7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747223383; x=1747828183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVDInadNESruAdh66j0qSpOh8ieFDLD3Ak5W5M0GS8Y=;
        b=SUSktEySIa+NpWbAyxGmmZ4Vd8JjbH8WmOlo5pJhaPFyR/3lmA6zxVm4nQ9bbKdFSJ
         qsEvCtvcar3KjAHFtxuNtPKoe0hv1Wx19SzK0HOuKxN7l6OCCXb3N5JceHbNeBW5tWJk
         MuVb8C2zVOymtwYYCuUZRbu16Z7fFh1DRO8ndEF+B+XW/IgEsl8ivZZlEnWrLoGej1ZM
         j1VFFSASCzf9ZB6m1joGTzv6t1Xb+vSZRTxD3kclWYO60xQU3S20nXAPIjOB7MTeQiOk
         53v+SWSrpi88hi1CBxG6Tn2sc69UwoEZ5x5M4rg1jT9vL6dI58WjwGNdkxObcsF81GwZ
         8AXw==
X-Forwarded-Encrypted: i=1; AJvYcCUYLAWUGBTqDDSzFDyrOt+Zio35+j4GOL6OMAnbNI08syHW51wwPfcrR6G8j3u8gTeeD40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkOcWZEWmMrn7E1CiFA3A/LejZbHwzQLFRXjnVw2WIA68Ldvf
	4oPTHv9THHraQybTZltK29C8I2SHixu4SVvmpi0lRTr9iZfnd990oqNoXAcsT4Y=
X-Gm-Gg: ASbGncvhRI95FeI+fqhtpFF0AMtErtrs2TAYWo+XycPCtX8ZlI8Tf+tv+XD2f6nVOv+
	T5t8axPxjbcL4S+qrGV5YMJaluJS9UeM2i4XHYSOJE16LIbcol0nWEl3s+fksf0pnurkKMor4Bn
	ZLShKTuCY0zt2Xb3A1aIaeWe9WEYwGE7TBZ4QDXvLoVip5ml0VB2Topt6wTWOiGdBmxV/e3GVQe
	I/74aqv6rQpUydnp0O9UA+aD6Gapde23lCk2QLXiv/COMB4INWDGSkonuJIb9Ec7GYiPoo/iZHI
	ZFsehryZNiqV3he/LasdAGKl61V1ELNWJkVnIr7ya8ELfkY=
X-Google-Smtp-Source: AGHT+IHJLQi7YfK26eZC4R5lH78kF+KYCk79EblQnC4/NrvNl/FSk149+M5TMi9OIrmOWs5Mqzr5XQ==
X-Received: by 2002:a05:6000:2dc2:b0:3a1:fd74:4248 with SMTP id ffacd0b85a97d-3a349694826mr2522572f8f.5.1747223383466;
        Wed, 14 May 2025 04:49:43 -0700 (PDT)
Received: from u94a ([2401:e180:8d52:f669:ffb6:2a98:b4eb:f904])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a3d6f5sm9329279b3a.129.2025.05.14.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:49:42 -0700 (PDT)
Date: Wed, 14 May 2025 19:49:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	bpf@vger.kernel.org, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
Message-ID: <g4fpslyse2s6hnprgkbp23ykxn67q5wabbkpivuc3rro5bivo4@sj2o3nd5vwwm>
References: <20250512172044.326436266@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>

On Mon, May 12, 2025 at 07:37:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Running included BPF selftests with a BPF CI fork (i.e. running on
GitHub Action x86-64 machines), I observe that that running the BPF
selftests now takes about 2x the time (from ~25m to ~50m), and
verif_scale_loop3_fail is timing out, taking more than 6 minutes to run
compare to the usual single digit second runtime. See [1] for the log.

  07:59:38.2908767Z #449     verif_scale_loop2:OK
  07:59:48.2920046Z WATCHDOG: test case verif_scale_loop3_fail executes for 10 seconds...
  08:01:38.2921924Z WATCHDOG: test case verif_scale_loop3_fail executes for 120 seconds, terminating with SIGSEGV
  08:01:38.2973073Z #450     verif_scale_loop3_fail:FAIL
  08:01:38.2973500Z Caught signal #11!
  08:01:38.2973808Z Stack trace:
  08:01:38.2974148Z ./test_progs(crash_handler+0x38)[0x564524d62f5c]
  08:01:38.2974682Z /lib/x86_64-linux-gnu/libc.so.6(+0x45330)[0x7f696f47d330]
  08:01:38.2975847Z /lib/x86_64-linux-gnu/libc.so.6(syscall+0x1d)[0x7f696f55f25d]
  08:01:38.2976387Z ./test_progs(+0x41a7cd)[0x564524d9d7cd]
  08:01:38.2976822Z ./test_progs(+0x41a7f5)[0x564524d9d7f5]
  08:01:38.2977236Z ./test_progs(+0x41a82e)[0x564524d9d82e]
  08:01:38.2980004Z ./test_progs(bpf_prog_load+0x681)[0x564524d9e555]
  08:01:38.2980570Z ./test_progs(+0x408ccc)[0x564524d8bccc]
  08:01:38.2980969Z ./test_progs(+0x409b89)[0x564524d8cb89]
  08:01:38.2981337Z ./test_progs(+0x40b87a)[0x564524d8e87a]
  08:01:38.2981674Z ./test_progs(bpf_object__load+0x26)[0x564524d8eb24]
  08:01:38.2981943Z ./test_progs(+0x8c160)[0x564524a0f160]
  08:01:38.2982173Z ./test_progs(+0x8c1c8)[0x564524a0f1c8]
  08:01:38.2982467Z ./test_progs(test_verif_scale_loop3_fail+0x21)[0x564524a0f59b]
  08:01:38.2982752Z ./test_progs(+0x3e0500)[0x564524d63500]
  08:01:38.2982983Z ./test_progs(main+0x5cd)[0x564524d65248]
  08:01:38.2983261Z /lib/x86_64-linux-gnu/libc.so.6(+0x2a1ca)[0x7f696f4621ca]
  08:01:38.2983651Z /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x8b)[0x7f696f46228b]
  08:01:38.2983998Z ./test_progs(_start+0x25)[0x5645249ba4a5]
  08:08:01.6898496Z libbpf: prog 'while_true': BPF program load failed: -E2BIG
  08:08:01.6898956Z libbpf: prog 'while_true': -- BEGIN PROG LOAD LOG --
  08:08:01.6899443Z BPF program is too large. Processed 1000001 insn
  08:08:01.6899823Z verification time 383390707 usec
  08:08:01.6900045Z stack depth 16
  08:08:01.6900621Z processed 1000001 insns (limit 1000000) max_states_per_insn 4 total_states 12347 peak_states 12347 mark_read 1
  08:08:01.6901359Z -- END PROG LOAD LOG --
  08:08:01.6901824Z libbpf: prog 'while_true': failed to load: -E2BIG
  08:08:01.6902368Z libbpf: failed to load object 'loop3.bpf.o'
  08:08:01.6902858Z scale_test:PASS:expect_error 0 nsec
  08:08:01.6903248Z #450     verif_scale_loop3_fail:FAIL

Compare to a day before when such behavior wasn't observed[2], the main
difference being these additional patches:

  input-cyttsp5-ensure-minimum-reset-pulse-width.patch
  input-cyttsp5-fix-power-control-issue-on-wakeup.patch
  input-mtk-pmic-keys-fix-possible-null-pointer-dereference.patch
  input-xpad-fix-share-button-on-xbox-one-controllers.patch
  input-xpad-add-support-for-8bitdo-ultimate-2-wireless-controller.patch
  input-xpad-fix-two-controller-table-values.patch
  input-synaptics-enable-intertouch-on-dynabook-portege-x30-d.patch
  input-synaptics-enable-intertouch-on-dynabook-portege-x30l-g.patch
  input-synaptics-enable-intertouch-on-dell-precision-m3800.patch
  input-synaptics-enable-smbus-for-hp-elitebook-850-g1.patch
  input-synaptics-enable-intertouch-on-tuxedo-infinitybook-pro-14-v5.patch
  rust-clean-rust-1.88.0-s-unnecessary_transmutes-lint.patch
  objtool-rust-add-one-more-noreturn-rust-function-for-rust-1.87.0.patch
  rust-clean-rust-1.88.0-s-warning-about-clippy-disallowed_macros-configuration.patch
  uio_hv_generic-fix-sysfs-creation-path-for-ring-buffer.patch
  staging-iio-adc-ad7816-correct-conditional-logic-for-store-mode.patch
  staging-bcm2835-camera-initialise-dev-in-v4l2_dev.patch
  staging-axis-fifo-remove-hardware-resets-for-user-errors.patch
  staging-axis-fifo-correct-handling-of-tx_fifo_depth-for-size-validation.patch
  x86-mm-eliminate-window-where-tlb-flushes-may-be-inadvertently-skipped.patch
  mm-fix-folio_pte_batch-on-xen-pv.patch
  mm-vmalloc-support-more-granular-vrealloc-sizing.patch
  mm-huge_memory-fix-dereferencing-invalid-pmd-migration-entry.patch
  mm-userfaultfd-fix-uninitialized-output-field-for-eagain-race.patch
  selftests-mm-compaction_test-support-platform-with-huge-mount-of-memory.patch
  selftests-mm-fix-a-build-failure-on-powerpc.patch
  selftests-mm-fix-build-break-when-compiling-pkey_util.c.patch
  kvm-x86-mmu-prevent-installing-hugepages-when-mem-attributes-are-changing.patch
  kvm-svm-forcibly-leave-smm-mode-on-shutdown-interception.patch
  drm-amd-display-shift-dmub-aux-reply-command-if-necessary.patch
  riscv-fix-kernel-crash-due-to-pr_set_tagged_addr_ctrl.patch
  io_uring-ensure-deferred-completions-are-flushed-for-multishot.patch
  iio-adc-ad7768-1-fix-insufficient-alignment-of-timestamp.patch
  iio-adc-ad7266-fix-potential-timestamp-alignment-issue.patch
  iio-adc-ad7606-fix-serial-register-access.patch
  iio-adc-rockchip-fix-clock-initialization-sequence.patch
  iio-adis16201-correct-inclinometer-channel-resolution.patch
  iio-chemical-sps30-use-aligned_s64-for-timestamp.patch
  iio-chemical-pms7003-use-aligned_s64-for-timestamp.patch
  iio-hid-sensor-prox-restore-lost-scale-assignments.patch
  iio-hid-sensor-prox-support-multi-channel-scale-calculation.patch
  iio-hid-sensor-prox-fix-incorrect-offset-calculation.patch
  iio-imu-inv_mpu6050-align-buffer-for-timestamp.patch
  iio-imu-st_lsm6dsx-fix-possible-lockup-in-st_lsm6dsx_read_fifo.patch
  iio-imu-st_lsm6dsx-fix-possible-lockup-in-st_lsm6dsx_read_tagged_fifo.patch
  iio-light-opt3001-fix-deadlock-due-to-concurrent-flag-access.patch
  iio-pressure-mprls0025pa-use-aligned_s64-for-timestamp.patch
  revert-drm-amd-stop-evicting-resources-on-apus-in-suspend.patch
  drm-v3d-add-job-to-pending-list-if-the-reset-was-skipped.patch
  drm-xe-add-page-queue-multiplier.patch
  drm-amdgpu-fix-pm-notifier-handling.patch
  drm-amdgpu-vcn-using-separate-vcn1_aon_soc-offset.patch
  drm-amd-display-fix-invalid-context-error-in-dml-helper.patch
  drm-amd-display-more-liberal-vmin-vmax-update-for-freesync.patch
  drm-amd-display-fix-the-checking-condition-in-dmub-aux-handling.patch
  drm-amd-display-remove-incorrect-checking-in-dmub-aux-handler.patch
  drm-amd-display-fix-wrong-handling-for-aux_defer-case.patch
  drm-amd-display-copy-aux-read-reply-data-whenever-length-0.patch
  drm-amdgpu-hdp4-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
  drm-amdgpu-hdp5.2-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
  drm-amdgpu-hdp5-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
  drm-amdgpu-hdp6-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
  drm-amdgpu-hdp7-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
  xhci-dbc-avoid-event-polling-busyloop-if-pending-rx-transfers-are-inactive.patch
  usb-uhci-platform-make-the-clock-really-optional.patch
  smb-client-avoid-race-in-open_cached_dir-with-lease-breaks.patch
  xen-swiotlb-use-swiotlb-bouncing-if-kmalloc-allocation-demands-it.patch
  xenbus-use-kref-to-track-req-lifetime.patch
  accel-ivpu-increase-state-dump-msg-timeout.patch
  arm64-cpufeature-move-arm64_use_ng_mappings-to-the-.data-section-to-prevent-wrong-idmap-generation.patch
  clocksource-i8253-use-raw_spinlock_irqsave-in-clockevent_i8253_disable.patch
  kvm-arm64-fix-uninitialized-memcache-pointer-in-user_mem_abort.patch
  memblock-accept-allocated-memory-before-use-in-memblock_double_array.patch
  module-ensure-that-kobject_put-is-safe-for-module-type-kobjects.patch
  x86-microcode-consolidate-the-loader-enablement-checking.patch
  ocfs2-fix-panic-in-failed-foilio-allocation.patch
  ocfs2-fix-the-issue-with-discontiguous-allocation-in-the-global_bitmap.patch
  ocfs2-switch-osb-disable_recovery-to-enum.patch
  ocfs2-implement-handshaking-with-ocfs2-recovery-thread.patch
  ocfs2-stop-quota-recovery-before-disabling-quotas.patch
  usb-dwc3-gadget-make-gadget_wakeup-asynchronous.patch
  usb-cdnsp-fix-issue-with-resuming-from-l1.patch
  usb-cdnsp-fix-l1-resume-issue-for-rtl_revision_new_lpm-version.patch
  usb-gadget-f_ecm-add-get_status-callback.patch
  usb-gadget-tegra-xudc-ack-st_rc-after-clearing-ctrl_run.patch
  usb-gadget-use-get_status-callback-to-set-remote-wakeup-capability.patch
  usb-host-tegra-prevent-host-controller-crash-when-otg-port-is-used.patch
  usb-misc-onboard_usb_dev-fix-support-for-cypress-hx3-hubs.patch
  usb-typec-tcpm-delay-snk_try_wait_debounce-to-src_trywait-transition.patch
  usb-typec-ucsi-displayport-fix-deadlock.patch
  usb-typec-ucsi-displayport-fix-null-pointer-access.patch
  usb-usbtmc-use-interruptible-sleep-in-usbtmc_read.patch
  usb-usbtmc-fix-erroneous-get_stb-ioctl-error-returns.patch
  usb-usbtmc-fix-erroneous-wait_srq-ioctl-return.patch
  usb-usbtmc-fix-erroneous-generic_read-ioctl-return.patch
  iio-imu-bmi270-fix-initial-sampling-frequency-config.patch
  iio-accel-adxl367-fix-setting-odr-for-activity-time-.patch
  iio-temp-maxim-thermocouple-fix-potential-lack-of-dm.patch
  iio-accel-adxl355-make-timestamp-64-bit-aligned-usin.patch
  iio-adc-dln2-use-aligned_s64-for-timestamp.patch
  mips-fix-idle-vs-timer-enqueue.patch
  mips-move-r4k_wait-to-.cpuidle.text-section.patch
  timekeeping-prevent-coarse-clocks-going-backwards.patch
  accel-ivpu-separate-db-id-and-cmdq-id-allocations-fr.patch
  accel-ivpu-correct-mutex-unlock-order-in-job-submiss.patch
  mips-fix-max_reg_offset.patch
  riscv-misaligned-add-handling-for-zcb-instructions.patch
  loop-factor-out-a-loop_assign_backing_file-helper.patch
  loop-add-sanity-check-for-read-write_iter.patch
  drm-panel-simple-update-timings-for-auo-g101evn010.patch
  nvme-unblock-ctrl-state-transition-for-firmware-upda.patch
  riscv-misaligned-factorize-trap-handling.patch
  riscv-misaligned-enable-irqs-while-handling-misalign.patch
  riscv-disallow-pr_get_tagged_addr_ctrl-without-supm.patch
  drm-xe-tests-mocs-hold-xe_forcewake_all-for-lncf-reg.patch
  drm-xe-release-force-wake-first-then-runtime-power.patch
  io_uring-sqpoll-increase-task_work-submission-batch-.patch
  do_umount-add-missing-barrier-before-refcount-checks.patch
  rust-allow-rust-1.87.0-s-clippy-ptr_eq-lint.patch
  rust-clean-rust-1.88.0-s-clippy-uninlined_format_args-lint.patch
  io_uring-always-arm-linked-timeouts-prior-to-issue.patch
  bluetooth-btmtk-remove-the-resetting-step-before-downloading-the-fw.patch
  mm-page_alloc-don-t-steal-single-pages-from-biggest-buddy.patch
  mm-page_alloc-speed-up-fallbacks-in-rmqueue_bulk.patch
  arm64-insn-add-support-for-encoding-dsb.patch
  arm64-proton-pack-expose-whether-the-platform-is-mitigated-by-firmware.patch
  arm64-proton-pack-expose-whether-the-branchy-loop-k-value.patch
  arm64-bpf-add-bhb-mitigation-to-the-epilogue-for-cbpf-programs.patch
  arm64-bpf-only-mitigate-cbpf-programs-loaded-by-unprivileged-users.patch
  arm64-proton-pack-add-new-cpus-k-values-for-branch-mitigation.patch
  x86-bpf-call-branch-history-clearing-sequence-on-exit.patch
  x86-bpf-add-ibhf-call-at-end-of-classic-bpf.patch
  x86-bhi-do-not-set-bhi_dis_s-in-32-bit-mode.patch
  documentation-x86-bugs-its-add-its-documentation.patch
  x86-its-enumerate-indirect-target-selection-its-bug.patch
  x86-its-add-support-for-its-safe-indirect-thunk.patch
  x86-its-add-support-for-its-safe-return-thunk.patch
  x86-its-enable-indirect-target-selection-mitigation.patch
  x86-its-add-vmexit-option-to-skip-mitigation-on-some-cpus.patch
  x86-its-add-support-for-rsb-stuffing-mitigation.patch
  x86-its-align-rets-in-bhb-clear-sequence-to-avoid-thunking.patch
  x86-ibt-keep-ibt-disabled-during-alternative-patching.patch
  x86-its-use-dynamic-thunks-for-indirect-branches.patch
  selftest-x86-bugs-add-selftests-for-its.patch

No patches touch BPF's core component, and while the
verif_scale_loop3_fail test did time out, the verifier is still
correctly rejecting it, so shouldn't have anything to do with
kernel/bpf/. The x86/arm64 BPF patches only affect JIT output, and only
for cBPF.

In comparison, with 6.12.29-rc1 I don't observe any timeout or increase
in runtime[3]. Below is a diff comparing the applied patches in
6.12.29-rc1 and 6.14.7-rc1. Seems like 6.14.7-rc1 does not have the
CALL_NOSPEC patches, but I cannot tell whether that is what makes the
difference.


1: https://github.com/shunghsiyu/libbpf/actions/runs/14979866777/job/42113654856
2: https://github.com/shunghsiyu/libbpf/actions/runs/14958571057/job/42017510267
3: https://github.com/shunghsiyu/libbpf/actions/runs/14979866777/job/42113654879

--- a/6.12.29-rc1-series
+++ b/6.14.7-rc1-series
@@ -17,7 +17,7 @@ openvswitch-fix-unsafe-attribute-parsing-in-output_userspace.patch
 ksmbd-fix-memory-leak-in-parse_lease_state.patch
 s390-entry-fix-last-breaking-event-handling-in-case-.patch
 sch_htb-make-htb_deactivate-idempotent.patch
-virtio_net-xsk-bind-unbind-xsk-for-tx.patch
+virtio-net-don-t-re-enable-refill-work-too-early-whe.patch
 virtio-net-free-xsk_buffs-on-error-in-virtnet_xsk_po.patch
 gre-fix-again-ipv6-link-local-address-generation.patch
 net-ethernet-mtk_eth_soc-reset-all-tx-queues-on-dma-.patch
@@ -26,7 +26,6 @@ can-m_can-m_can_class_allocate_dev-initialize-spin-l.patch
 can-mcp251xfd-fix-tdc-setting-for-low-data-bit-rates.patch
 can-gw-fix-rcu-bh-usage-in-cgw_create_job.patch
 wifi-mac80211-fix-the-type-of-status_code-for-negoti.patch
-ice-initial-support-for-e825c-hardware-in-ice_adapte.patch
 ice-use-dsn-instead-of-pci-bdf-for-ice_adapter-index.patch
 erofs-ensure-the-extra-temporary-copy-is-valid-for-s.patch
 ipvs-fix-uninit-value-for-saddr-in-do_output_route4.patch
@@ -46,6 +45,7 @@ net-dsa-b53-do-not-set-learning-and-unicast-multicas.patch
 fbnic-fix-initialization-of-mailbox-descriptor-rings.patch
 fbnic-gate-axi-read-write-enabling-on-fw-mailbox.patch
 fbnic-actually-flush_tx-instead-of-stalling-out.patch
+fbnic-cleanup-handling-of-completions.patch
 fbnic-improve-responsiveness-of-fbnic_mbx_poll_tx_re.patch
 fbnic-pull-fbnic_fw_xmit_cap_msg-use-out-of-interrup.patch
 fbnic-do-not-allow-mailbox-to-toggle-to-ready-outsid.patch
@@ -65,6 +65,7 @@ input-synaptics-enable-intertouch-on-tuxedo-infinitybook-pro-14-v5.patch
 rust-clean-rust-1.88.0-s-unnecessary_transmutes-lint.patch
 objtool-rust-add-one-more-noreturn-rust-function-for-rust-1.87.0.patch
 rust-clean-rust-1.88.0-s-warning-about-clippy-disallowed_macros-configuration.patch
+uio_hv_generic-fix-sysfs-creation-path-for-ring-buffer.patch
 staging-iio-adc-ad7816-correct-conditional-logic-for-store-mode.patch
 staging-bcm2835-camera-initialise-dev-in-v4l2_dev.patch
 staging-axis-fifo-remove-hardware-resets-for-user-errors.patch
@@ -76,17 +77,31 @@ mm-huge_memory-fix-dereferencing-invalid-pmd-migration-entry.patch
 mm-userfaultfd-fix-uninitialized-output-field-for-eagain-race.patch
 selftests-mm-compaction_test-support-platform-with-huge-mount-of-memory.patch
 selftests-mm-fix-a-build-failure-on-powerpc.patch
+selftests-mm-fix-build-break-when-compiling-pkey_util.c.patch
+kvm-x86-mmu-prevent-installing-hugepages-when-mem-attributes-are-changing.patch
 kvm-svm-forcibly-leave-smm-mode-on-shutdown-interception.patch
 drm-amd-display-shift-dmub-aux-reply-command-if-necessary.patch
+riscv-fix-kernel-crash-due-to-pr_set_tagged_addr_ctrl.patch
 io_uring-ensure-deferred-completions-are-flushed-for-multishot.patch
+iio-adc-ad7768-1-fix-insufficient-alignment-of-timestamp.patch
+iio-adc-ad7266-fix-potential-timestamp-alignment-issue.patch
 iio-adc-ad7606-fix-serial-register-access.patch
 iio-adc-rockchip-fix-clock-initialization-sequence.patch
 iio-adis16201-correct-inclinometer-channel-resolution.patch
+iio-chemical-sps30-use-aligned_s64-for-timestamp.patch
+iio-chemical-pms7003-use-aligned_s64-for-timestamp.patch
+iio-hid-sensor-prox-restore-lost-scale-assignments.patch
+iio-hid-sensor-prox-support-multi-channel-scale-calculation.patch
+iio-hid-sensor-prox-fix-incorrect-offset-calculation.patch
 iio-imu-inv_mpu6050-align-buffer-for-timestamp.patch
 iio-imu-st_lsm6dsx-fix-possible-lockup-in-st_lsm6dsx_read_fifo.patch
 iio-imu-st_lsm6dsx-fix-possible-lockup-in-st_lsm6dsx_read_tagged_fifo.patch
+iio-light-opt3001-fix-deadlock-due-to-concurrent-flag-access.patch
+iio-pressure-mprls0025pa-use-aligned_s64-for-timestamp.patch
+revert-drm-amd-stop-evicting-resources-on-apus-in-suspend.patch
 drm-v3d-add-job-to-pending-list-if-the-reset-was-skipped.patch
 drm-xe-add-page-queue-multiplier.patch
+drm-amdgpu-fix-pm-notifier-handling.patch
 drm-amdgpu-vcn-using-separate-vcn1_aon_soc-offset.patch
 drm-amd-display-fix-invalid-context-error-in-dml-helper.patch
 drm-amd-display-more-liberal-vmin-vmax-update-for-freesync.patch
@@ -99,6 +114,7 @@ drm-amdgpu-hdp5.2-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
 drm-amdgpu-hdp5-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
 drm-amdgpu-hdp6-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
 drm-amdgpu-hdp7-use-memcfg-register-to-post-the-write-for-hdp-flush.patch
+xhci-dbc-avoid-event-polling-busyloop-if-pending-rx-transfers-are-inactive.patch
 usb-uhci-platform-make-the-clock-really-optional.patch
 smb-client-avoid-race-in-open_cached_dir-with-lease-breaks.patch
 xen-swiotlb-use-swiotlb-bouncing-if-kmalloc-allocation-demands-it.patch
@@ -106,9 +122,11 @@ xenbus-use-kref-to-track-req-lifetime.patch
 accel-ivpu-increase-state-dump-msg-timeout.patch
 arm64-cpufeature-move-arm64_use_ng_mappings-to-the-.data-section-to-prevent-wrong-idmap-generation.patch
 clocksource-i8253-use-raw_spinlock_irqsave-in-clockevent_i8253_disable.patch
+kvm-arm64-fix-uninitialized-memcache-pointer-in-user_mem_abort.patch
 memblock-accept-allocated-memory-before-use-in-memblock_double_array.patch
 module-ensure-that-kobject_put-is-safe-for-module-type-kobjects.patch
 x86-microcode-consolidate-the-loader-enablement-checking.patch
+ocfs2-fix-panic-in-failed-foilio-allocation.patch
 ocfs2-fix-the-issue-with-discontiguous-allocation-in-the-global_bitmap.patch
 ocfs2-switch-osb-disable_recovery-to-enum.patch
 ocfs2-implement-handshaking-with-ocfs2-recovery-thread.patch
@@ -122,43 +140,41 @@ usb-gadget-use-get_status-callback-to-set-remote-wakeup-capability.patch
 usb-host-tegra-prevent-host-controller-crash-when-otg-port-is-used.patch
 usb-misc-onboard_usb_dev-fix-support-for-cypress-hx3-hubs.patch
 usb-typec-tcpm-delay-snk_try_wait_debounce-to-src_trywait-transition.patch
+usb-typec-ucsi-displayport-fix-deadlock.patch
 usb-typec-ucsi-displayport-fix-null-pointer-access.patch
 usb-usbtmc-use-interruptible-sleep-in-usbtmc_read.patch
 usb-usbtmc-fix-erroneous-get_stb-ioctl-error-returns.patch
 usb-usbtmc-fix-erroneous-wait_srq-ioctl-return.patch
 usb-usbtmc-fix-erroneous-generic_read-ioctl-return.patch
+iio-imu-bmi270-fix-initial-sampling-frequency-config.patch
 iio-accel-adxl367-fix-setting-odr-for-activity-time-.patch
 iio-temp-maxim-thermocouple-fix-potential-lack-of-dm.patch
-types-complement-the-aligned-types-with-signed-64-bi.patch
 iio-accel-adxl355-make-timestamp-64-bit-aligned-usin.patch
 iio-adc-dln2-use-aligned_s64-for-timestamp.patch
 mips-fix-idle-vs-timer-enqueue.patch
 mips-move-r4k_wait-to-.cpuidle.text-section.patch
+timekeeping-prevent-coarse-clocks-going-backwards.patch
+accel-ivpu-separate-db-id-and-cmdq-id-allocations-fr.patch
+accel-ivpu-correct-mutex-unlock-order-in-job-submiss.patch
 mips-fix-max_reg_offset.patch
 riscv-misaligned-add-handling-for-zcb-instructions.patch
-loop-use-bdev-limit-helpers-for-configuring-discard.patch
-loop-simplify-discard-granularity-calc.patch
-loop-fix-abba-locking-race.patch
-loop-refactor-queue-limits-updates.patch
 loop-factor-out-a-loop_assign_backing_file-helper.patch
 loop-add-sanity-check-for-read-write_iter.patch
 drm-panel-simple-update-timings-for-auo-g101evn010.patch
 nvme-unblock-ctrl-state-transition-for-firmware-upda.patch
 riscv-misaligned-factorize-trap-handling.patch
 riscv-misaligned-enable-irqs-while-handling-misalign.patch
-drm-xe-tests-mocs-update-xe_force_wake_get-return-ha.patch
+riscv-disallow-pr_get_tagged_addr_ctrl-without-supm.patch
 drm-xe-tests-mocs-hold-xe_forcewake_all-for-lncf-reg.patch
+drm-xe-release-force-wake-first-then-runtime-power.patch
 io_uring-sqpoll-increase-task_work-submission-batch-.patch
 do_umount-add-missing-barrier-before-refcount-checks.patch
-revert-um-work-around-sched_yield-not-yielding-in-time-travel-mode.patch
 rust-allow-rust-1.87.0-s-clippy-ptr_eq-lint.patch
 rust-clean-rust-1.88.0-s-clippy-uninlined_format_args-lint.patch
 io_uring-always-arm-linked-timeouts-prior-to-issue.patch
-bluetooth-btmtk-remove-resetting-mt7921-before-downloading-the-fw.patch
 bluetooth-btmtk-remove-the-resetting-step-before-downloading-the-fw.patch
 mm-page_alloc-don-t-steal-single-pages-from-biggest-buddy.patch
 mm-page_alloc-speed-up-fallbacks-in-rmqueue_bulk.patch
-sched-eevdf-fix-se-slice-being-set-to-u64_max-and-resulting-crash.patch
 arm64-insn-add-support-for-encoding-dsb.patch
 arm64-proton-pack-expose-whether-the-platform-is-mitigated-by-firmware.patch
 arm64-proton-pack-expose-whether-the-branchy-loop-k-value.patch
@@ -168,9 +184,6 @@ arm64-proton-pack-add-new-cpus-k-values-for-branch-mitigation.patch
 x86-bpf-call-branch-history-clearing-sequence-on-exit.patch
 x86-bpf-add-ibhf-call-at-end-of-classic-bpf.patch
 x86-bhi-do-not-set-bhi_dis_s-in-32-bit-mode.patch
-x86-speculation-simplify-and-make-call_nospec-consistent.patch
-x86-speculation-add-a-conditional-cs-prefix-to-call_nospec.patch
-x86-speculation-remove-the-extra-ifdef-around-call_nospec.patch
 documentation-x86-bugs-its-add-its-documentation.patch
 x86-its-enumerate-indirect-target-selection-its-bug.patch
 x86-its-add-support-for-its-safe-indirect-thunk.patch

