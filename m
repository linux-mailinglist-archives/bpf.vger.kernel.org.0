Return-Path: <bpf+bounces-45880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C79DEABC
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 17:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D76163BD1
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0CC14B077;
	Fri, 29 Nov 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjFaf1b5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15612168DA;
	Fri, 29 Nov 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896838; cv=none; b=e5S7x1K6X8NBesEcQoIXhjDrVwk/RJyTuvBdrIeqQLrVxwBpHh09N9z0uuQAsffI+UwWW4u2axKVCHZZa9RkbSFAZGBuWwJeIkGBbtCL9m81l40fuw3p4YBImG+qKaGTb39EDW6ZqGXrXZLIj4vt/70AFNoceoESIKufKPgycAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896838; c=relaxed/simple;
	bh=vfMP9zCAlMii4GyZod2DPvXGPBJW0ySNqa3TU/OSQac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuOfcIAN/LAFSqO/faeAUL6pov1c+cWwVzUjBeMEC9z5hKtb6YCVDm7DvbXKWvOPMT8nurcCbaU63dhD+zZxDtrzlApHZ+tgVmKM3RUMMo7WbkEnEGEfDYPRfYo8d9LpFkERVyMaf6M1gqyzlj46DRzbgvuegHoyTImGNj6IG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjFaf1b5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F36AC4CECF;
	Fri, 29 Nov 2024 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732896837;
	bh=vfMP9zCAlMii4GyZod2DPvXGPBJW0ySNqa3TU/OSQac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjFaf1b5Oe9qzTZsP4BVXbahFLovusmOT5QuL3K6JdKLXjej/ejQlQMmOgvPm+ceB
	 h4Jcll7NgWrkcs4JqDKh38JqJGJkKRlCAVPLT7+cSk2A2rpmnJXF69bmU0IzXSMYW6
	 l0OCiSEUc8k/1EhiVcoIjTZwgkEbBI5FfDXMJzfyGhGuxFd5g1j1nFLuc8chFdxyzW
	 X9haQ2xxbpVItW6VSoQTJ41Cgp6Oe3KDnHF3mVJirUt/AF/Vvrk23vl6s3+IaohkBo
	 jBFS8mruD7hW4wHyDF8EMMlSOsRTyNUTVPI9yXFESA//4lNt2WvGR+5k554c7u7kJ9
	 GvETf1a2Pou/A==
Date: Fri, 29 Nov 2024 11:13:56 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.13
Message-ID: <Z0noRK6mD3tHMBov@sashalap>
References: <20241119161923.29062-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241119161923.29062-1-pabeni@redhat.com>

Hi folks,

After this PR, I started (very rarely) seeing the following warning:

[   12.020686] UBSAN: shift-out-of-bounds in drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c:1333:47
[   12.029663] shift exponent 32 is too large for 32-bit type 'long unsigned int'
[   12.036900] CPU: 2 UID: 0 PID: 167 Comm: modprobe Tainted: G        W          6.12.0 #1
[   12.044988] Tainted: [W]=WARN
[   12.047960] Hardware name: LENOVO Morphius/Morphius, BIOS Google_Morphius.13434.60.0 10/08/2020
[   12.056653] Call Trace:
[   12.059105]  dump_stack_lvl+0x94/0xa4
[   12.062774]  dump_stack+0x12/0x18
[   12.066095]  __ubsan_handle_shift_out_of_bounds+0x156/0x320
[   12.071676]  iwl_dbg_tlv_init_cfg.cold+0x5d/0x67 [iwlwifi]
[   12.077198]  _iwl_dbg_tlv_time_point+0x2be/0x364 [iwlwifi]
[   12.082717]  ? __local_bh_enable_ip+0x6b/0xe8
[   12.087078]  ? _raw_spin_unlock_bh+0x25/0x28
[   12.091355]  iwl_run_unified_mvm_ucode+0xb0/0x380 [iwlmvm]
[   12.096859]  ? 0xf89c9000
[   12.099486]  ? iwl_trans_pcie_start_hw+0xbd/0x344 [iwlwifi]
[   12.105090]  ? 0xf89c9000
[   12.107719]  iwl_run_init_mvm_ucode+0x213/0x428 [iwlmvm]
[   12.113059]  ? mutex_unlock+0xb/0x10
[   12.116637]  ? iwl_trans_pcie_start_hw+0xbd/0x344 [iwlwifi]
[   12.122244]  iwl_mvm_start_get_nvm+0x91/0x204 [iwlmvm]
[   12.127410]  ? iwl_mvm_mei_scan_filter_init+0x65/0x7c [iwlmvm]
[   12.133275]  iwl_op_mode_mvm_start+0x9e0/0xd08 [iwlmvm]
[   12.138532]  ? iwl_mvm_start_get_nvm+0x204/0x204 [iwlmvm]
[   12.143955]  _iwl_op_mode_start.isra.0+0x9a/0xd0 [iwlwifi]
[   12.149477]  iwl_opmode_register+0x5a/0xbc [iwlwifi]
[   12.154474]  ? 0xf87fc000
[   12.157100]  iwl_mvm_init+0x21/0x1000 [iwlmvm]
[   12.161562]  ? 0xf87fc000
[   12.164188]  do_one_initcall+0x63/0x2a8
[   12.168027]  ? __create_object+0x56/0x84
[   12.171960]  do_init_module+0x53/0x1f4
[   12.175716]  load_module+0x746/0x818
[   12.179296]  ? __probestub_module_put+0x4/0x4
[   12.183659]  init_module_from_file+0x80/0xa8
[   12.187936]  idempotent_init_module+0xe4/0x260
[   12.192386]  __ia32_sys_finit_module+0x4f/0xb4
[   12.196834]  ia32_sys_call+0x2bb/0x2e44
[   12.200672]  __do_fast_syscall_32+0x5b/0xd8
[   12.204860]  do_fast_syscall_32+0x2b/0x60
[   12.208873]  do_SYSENTER_32+0x15/0x18
[   12.212538]  entry_SYSENTER_32+0xa6/0x115
[   12.216551] EIP: 0xb7f28579
[   12.219350] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[   12.238098] EAX: ffffffda EBX: 00000000 ECX: 0934ba50 EDX: 00000000
[   12.244364] ESI: 0934ba50 EDI: 0934b8c0 EBP: 0934ba50 ESP: bfb8fd88
[   12.250629] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292

-- 
Thanks,
Sasha

