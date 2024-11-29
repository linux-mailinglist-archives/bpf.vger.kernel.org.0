Return-Path: <bpf+bounces-45882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD389DEB17
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C73282CB1
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2221AA1C1;
	Fri, 29 Nov 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9WeyDcm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0D19E99A
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898001; cv=none; b=gBecAAOx0cr6/6fxdHPcaYRusxmfeCcyqW8aH7JMPlOlMe5EklPf0V2HOEvlcxXMG5C0Bz6eQmIR/lRg8XidgncjGXSjtcgFA+ladKUvGaxTXQmCWxsqxQlhZ10awUrVgOmfMoWrnmjC44tqDeOgF9a9gi+3Gli0hai7xRxclEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898001; c=relaxed/simple;
	bh=ixANE1TM97/kk79pq9p1BaXxgETyrKZhPIYqkiTuoEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhFmHu4JD9np43yO9EOmhRomV0BUE5UyrfC+pB+WnkZcH2Y+MHgnKUe/cDPf9WrIZ2SX0mT2cGgI46JHOspQhY71pnucH2BHeYqsPnYV+7OSRRdfiTiMfveMVaU2qVddSVTF67WQYpeTzL20KAkl1b0OhEhFLeUnAfN9I2pE4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9WeyDcm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732897997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unp1zDx/rkB05CPtFabdiDNdSsNq+4B70Mcxqw/MVBA=;
	b=X9WeyDcmIvUvencb2L+7Yzqeo9rsYWDSlDa4vxUZs42s7Y8yrfg5zThaLy+nrWJAGzPjme
	SDmjHbwno+1aA47Sb7d0e6EKj8T2H9V7BVFVLG06ae2Zj84rcrmYSnAPVGk09Y0cXW6+M6
	icuap/Ab1RsYNTQ/6v9eGJ14BVlCCCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548--KZjXBkpNaOa1bOWwmWLXw-1; Fri, 29 Nov 2024 11:33:16 -0500
X-MC-Unique: -KZjXBkpNaOa1bOWwmWLXw-1
X-Mimecast-MFC-AGG-ID: -KZjXBkpNaOa1bOWwmWLXw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a72b08d9so14072345e9.2
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 08:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897995; x=1733502795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unp1zDx/rkB05CPtFabdiDNdSsNq+4B70Mcxqw/MVBA=;
        b=oGXRo2tH7S+A6ouekFYZ/TEym8nmSKSSlTxdNOaEgONhKjf0VyQacLberT3k0PBRR6
         sYgaCEdchwgJyA9xO3yi76iIq9g0AGE2peMeLQU1OuCYvE14G6SD0WmljBqJ9x0PtJFQ
         jqgWvs6Wj5+IjkSaRWIXMp5fkciMILNMD+NazP5PxznJQkBrXdaQD1F4ppQ2eu5qeV1l
         ufEy91cB7+gsWsvU5IO7Vs4UlM6sNSUJ04ZKSx/JNkjKINhPrlVZjAi2eb7mQphjWqMw
         OnFzHx/wAMxP6Q7qDG3yEEoYzmwHuYeS2APN0ZAmOMjyqVnrs+gKntRiDAsTSWQB2NDU
         ELjg==
X-Forwarded-Encrypted: i=1; AJvYcCXlNyFX6wnjNapgjwupLGDeVB3fEPfUhEwPYD4hGuySxZMYJOzYbl+apmjCSgNIsA39uj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFz6YRxUG4RC/XK34zfJH0r43Bi792CxzE6liuTIRtTNAQVYuL
	xSLno6xuP3os18TBVcLiD3j/hAN6BrajZ6WepS9jkR0mcXtcHJ6Qbrbd446hQRNUzQ8Dr+5jR8o
	H/lY1FQzV161syYLSfoIO958zeICsb0b/vT6Itf0/verIfDHW8g==
X-Gm-Gg: ASbGncuwyJHWklq8p7kulnYAIc3qYo2t922JWMAJhjJ6cGx/RrxVnnqOmWQgzQHqzJr
	xF/6/m8a9igLx8oa98/TGUlTENwuPrr9hxfpHXoXSMAwMUBIgU1wRHL8bKcz/momjzt59zHhNVp
	lS/v3FJUGjnxDIEqNW2qYVIxfjl2lT/0Pobt/o3EP4lS9XIMYMqSx5VIeoqlVA+JUkAokEAmXuI
	2IPXIB9zjTOdjFwIvfntKCYxxGuitLXJPXAJSVdPchrGM5/PmUYI/rbZmadS/xI6yVS0r22vRAH
X-Received: by 2002:a05:600c:3111:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-434a9dc01b2mr106932185e9.11.1732897995171;
        Fri, 29 Nov 2024 08:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES3pURBMYVzVdTXMFsHaKlxSDicnl0pEAYalfnPPgL84tyOEF+MnjfWFXfpaYWzyRjs7qEWA==
X-Received: by 2002:a05:600c:3111:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-434a9dc01b2mr106931865e9.11.1732897994801;
        Fri, 29 Nov 2024 08:33:14 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e19104a0sm400133f8f.32.2024.11.29.08.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 08:33:14 -0800 (PST)
Message-ID: <ac9ae011-636d-4826-84a0-6de059e2bd69@redhat.com>
Date: Fri, 29 Nov 2024 17:33:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.13
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Rotem Saado <rotem.saado@intel.com>
References: <20241119161923.29062-1-pabeni@redhat.com>
 <Z0noRK6mD3tHMBov@sashalap>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z0noRK6mD3tHMBov@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Kalle, Johannes, Miri and Rotem
On 11/29/24 17:13, Sasha Levin wrote:
> Hi folks,
> 
> After this PR, I started (very rarely) seeing the following warning:
> 
> [   12.020686] UBSAN: shift-out-of-bounds in drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c:1333:47
> [   12.029663] shift exponent 32 is too large for 32-bit type 'long unsigned int'
> [   12.036900] CPU: 2 UID: 0 PID: 167 Comm: modprobe Tainted: G        W          6.12.0 #1
> [   12.044988] Tainted: [W]=WARN
> [   12.047960] Hardware name: LENOVO Morphius/Morphius, BIOS Google_Morphius.13434.60.0 10/08/2020
> [   12.056653] Call Trace:
> [   12.059105]  dump_stack_lvl+0x94/0xa4
> [   12.062774]  dump_stack+0x12/0x18
> [   12.066095]  __ubsan_handle_shift_out_of_bounds+0x156/0x320
> [   12.071676]  iwl_dbg_tlv_init_cfg.cold+0x5d/0x67 [iwlwifi]
> [   12.077198]  _iwl_dbg_tlv_time_point+0x2be/0x364 [iwlwifi]
> [   12.082717]  ? __local_bh_enable_ip+0x6b/0xe8
> [   12.087078]  ? _raw_spin_unlock_bh+0x25/0x28
> [   12.091355]  iwl_run_unified_mvm_ucode+0xb0/0x380 [iwlmvm]
> [   12.096859]  ? 0xf89c9000
> [   12.099486]  ? iwl_trans_pcie_start_hw+0xbd/0x344 [iwlwifi]
> [   12.105090]  ? 0xf89c9000
> [   12.107719]  iwl_run_init_mvm_ucode+0x213/0x428 [iwlmvm]
> [   12.113059]  ? mutex_unlock+0xb/0x10
> [   12.116637]  ? iwl_trans_pcie_start_hw+0xbd/0x344 [iwlwifi]
> [   12.122244]  iwl_mvm_start_get_nvm+0x91/0x204 [iwlmvm]
> [   12.127410]  ? iwl_mvm_mei_scan_filter_init+0x65/0x7c [iwlmvm]
> [   12.133275]  iwl_op_mode_mvm_start+0x9e0/0xd08 [iwlmvm]
> [   12.138532]  ? iwl_mvm_start_get_nvm+0x204/0x204 [iwlmvm]
> [   12.143955]  _iwl_op_mode_start.isra.0+0x9a/0xd0 [iwlwifi]
> [   12.149477]  iwl_opmode_register+0x5a/0xbc [iwlwifi]
> [   12.154474]  ? 0xf87fc000
> [   12.157100]  iwl_mvm_init+0x21/0x1000 [iwlmvm]
> [   12.161562]  ? 0xf87fc000
> [   12.164188]  do_one_initcall+0x63/0x2a8
> [   12.168027]  ? __create_object+0x56/0x84
> [   12.171960]  do_init_module+0x53/0x1f4
> [   12.175716]  load_module+0x746/0x818
> [   12.179296]  ? __probestub_module_put+0x4/0x4
> [   12.183659]  init_module_from_file+0x80/0xa8
> [   12.187936]  idempotent_init_module+0xe4/0x260
> [   12.192386]  __ia32_sys_finit_module+0x4f/0xb4
> [   12.196834]  ia32_sys_call+0x2bb/0x2e44
> [   12.200672]  __do_fast_syscall_32+0x5b/0xd8
> [   12.204860]  do_fast_syscall_32+0x2b/0x60
> [   12.208873]  do_SYSENTER_32+0x15/0x18
> [   12.212538]  entry_SYSENTER_32+0xa6/0x115
> [   12.216551] EIP: 0xb7f28579
> [   12.219350] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> [   12.238098] EAX: ffffffda EBX: 00000000 ECX: 0934ba50 EDX: 00000000
> [   12.244364] ESI: 0934ba50 EDI: 0934b8c0 EBP: 0934ba50 ESP: bfb8fd88
> [   12.250629] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
> 

I suspect the issue is due to commit
72c43f7d6562cec138536e7e6d0939692ff74482 and something like the
following should address it:
---
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 08d990ba8a79..3081508d030c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1330,7 +1330,7 @@ void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
                u32 reg_type;

                if (!*active_reg) {
-                       fwrt->trans->dbg.unsupported_region_msk |= BIT(i);
+                       fwrt->trans->dbg.unsupported_region_msk |=
BIT_ULL(i);
                        continue;
                }


