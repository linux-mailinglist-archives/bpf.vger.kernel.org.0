Return-Path: <bpf+bounces-59560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E111ACCF69
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 23:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DB61892F15
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758624BBEB;
	Tue,  3 Jun 2025 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND3LD6LL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639C1C3BEB
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987666; cv=none; b=DZMZ6Anwt4aDpXGTlqcrhEz6UiyhwDgCjg+f6QfWxzRsilr9FKxUdq33dS4iB2I+jS6T5CTltHP5Wm09GP9fEok5ev+aN/3WiFz9leLvo04UQRxpWBesTqfCDSRzzdqMsi78V3CiaGkG4n/4CmVvS1l2u8WMNcjz0mWwLxFWmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987666; c=relaxed/simple;
	bh=j+NPPj/zYUd2jGflrtzmB66BxPpzAgQrCVRoHgp/Jtk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCzLMjsckG7q6BkogFhgRHYHkbG8g4161BAbNZYGt9/jFt7Mh+ZooIT1atO2BBw6iNjsx6IOzJ58546wrBUdc+z8d35SDURE/9ctZ+7OXxUg55Y4hEQ0cznDFtC4vz628UVNUPZVMWKfiOCbJS8R3Zp4wqOq0AluA7MkfeGz2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND3LD6LL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d6ade159so27796005e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748987663; x=1749592463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kr3SWpM9FO4Ih7rvoKS4sHqzhmjF+Frc/mnTHAyZadI=;
        b=ND3LD6LLn7SFRLbQzhkbX2xbwNDhYcuZ8vXgOcO/rwGszFUAKQhwiMB6Uqf1ITWcue
         LinpP19Fvj3DYtEnBeukIsZhBJa3KSGmcYbPIxLA0ieBxXRlm1iI9mS7yLy8DnldPIG+
         z0vmBH9GGfpUFJSkEN9Q4VQeV5LE/iYal0+RKKoeMEBQo5jcCObWlUh1q46SjrxMx8O4
         osrpYt2aCCaaANtwZcHyBoutE615108yya0UOPBt9LXCDGWdB9EFfYN/tbaRfl3Rv302
         SM0PDkCrgOKgwM+oJuiNtAqDjP5ABXGdw1aRA1EF9+yoEXPEH6SU+NJmhP+I8FmWqdUH
         +Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748987663; x=1749592463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr3SWpM9FO4Ih7rvoKS4sHqzhmjF+Frc/mnTHAyZadI=;
        b=vYF7+Vp205cQJT/qYQFn8BvGakw/2rarLSX//pVDDgyWiQoDZZb4MyCPB2WrsMHfxj
         X7EGWYiitUGMXW2V2W9M+gms16sSk6SxI+UNyCb20+q0eTT4CYvgYLLmi3Cs7UlhDKbP
         CbCSd3PZqtZU4b9cDsxPgGCDHJD7ur7Wift3Dl1f+tl3Ewi6FBhL4RxMs13tVYxJ7WrR
         Je07YG+e8RRk8Q3c1x88y40JvwlTKC7jEjzJ8hdPpZBSDU/E1gDCBQPfxWL4aQXI+kpA
         j01dmBW+lWNWOtN1ZTwSZ/Mb16DtKFvmnZD1lBbhFAZNxaNWTN/O26nqBCcE2w1bTvsY
         3YsA==
X-Gm-Message-State: AOJu0Yygqs0G9d0vkLEcargIclaRvxY54ogy9zkYQ+QzeXOBVYjQ8Ji+
	r091Zas8Z8TFl1WuIPOegkMtq/39DCl8hMS8JXDjEU4F+sD2Bapj2e4X7LHdtOpMbn0=
X-Gm-Gg: ASbGnctdEnpFH1cMIXSaLvksyZy4eV5/VrnMsA4ovMf862/hI7uiOMigh05IaqoB6Di
	/LmHVIMd3/bDiiDFFe/otd8BLAN4oMptrIGvrOrFkCmhh2HtHr8OA5CFzy+iGsQD+ABwFBfa47F
	laqeel1sCyC3szWpcvkApT+xeD1vR2nDY0NH7+ue2pcF9CJRc+JI5BdeIMAK6Xt7fFneYI4a/MT
	hK5dylLfqinf1YM4PlxxVMYpqlo+3sc8SpU2+qmV23ty9JHfpUEvg7rUCDlMiTFQuNiEatWMSoD
	Aid8AggmCkgpwbYuQOappw+8ljn+dFGvLJMlC3FdNRZh8eoVEg==
X-Google-Smtp-Source: AGHT+IGo+mG+OG7N+42Q/nVRQqaSvmBDof9dkrbgnO6vOrFUyH/B5k3Ra9/zROR43brolJBgVcvpVA==
X-Received: by 2002:a05:600c:34c2:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-451f0b09f62mr1765985e9.20.1748987662659;
        Tue, 03 Jun 2025 14:54:22 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edc0sm173602525e9.5.2025.06.03.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 14:54:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Jun 2025 23:54:21 +0200
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, joe.kimpel@crowdstrike.com,
	Mark Fontana <mark.fontana@crowdstrike.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: Bad vmalloc address during BPF hooks unload
Message-ID: <aD9vDX0boYLzvibc@krava>
References: <6947880c-a749-438f-bfcb-91afe7238d7e@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6947880c-a749-438f-bfcb-91afe7238d7e@crowdstrike.com>

On Tue, Jun 03, 2025 at 04:13:18PM -0400, Andrey Grodzovsky wrote:
> Hi, we observe bellow random warning occasionally during BPF hooks unload,
> we only see it on rhel8 kernels ranging from 8.6-8.10 so it might be
> something RHEL specific and not upstream issues, i still was hoping to get
> some advise or clues from BPF experts here.

hi,
unless you reproduce on upstream or some stable kernel I'm afraid there's not
much that can be done in here

jirka


> 
> Thanks,Andrey
> 
> [ 5714.071613] WARNING: CPU: 0 PID: 20653 at mm/vmalloc.c:330
> vmalloc_to_page+0x21e/0x230
> [ 5714.079668] Modules linked in: nft_chain_nat ipt_MASQUERADE nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 veth nft_counter ipt_REJECT
> nf_reject_ipv4 nft_compat falcon_lsm_pinned_7413(E) binfmt_misc tcp_diag
> udp_diag inet_diag nf_tables nfnetlink overlay intel_rapl_msr
> intel_rapl_common amd_energy pcspkr i2c_piix4 xfs libcrc32c nvme_tcp(X)
> nvme_fabrics sd_mod sg crct10dif_pclmul crc32_pclmul crc32c_intel virtio_net
> ghash_clmulni_intel net_failover virtio_scsi failover serio_raw nvme
> nvme_core t10_pi dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded:
> falcon_nf_netcontain]
> [ 5714.131372] Red Hat flags: eBPF/event eBPF/rawtrace
> [ 5714.136351] CPU: 0 PID: 20653 Comm: falcon-sensor-b Kdump: loaded
> Tainted: G            E  X --------- -  - 4.18.0-477.10.1.el8_8.x86_64 #1
> [ 5714.148964] Hardware name: Google Google Compute Engine/Google Compute
> Engine, BIOS Google 05/07/2025
> [ 5714.158283] RIP: 0010:vmalloc_to_page+0x21e/0x230
> [ 5714.163086] Code: 28 f1 b0 00 48 81 e7 00 00 00 c0 e9 19 ff ff ff 48 8b
> 3d 55 5b 0d 01 48 81 e7 00 f0 ff ff 48 89 fa eb 8c 0f 0b e9 10 fe ff ff <0f>
> 0b 31 c0 e9 f9 f0 b0 00 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> [ 5714.181949] RSP: 0018:ffffad99017b3d10 EFLAGS: 00010293
> [ 5714.187271] RAX: 0000000000000063 RBX: ffffdead05829d80 RCX:
> 0000000000000000
> [ 5714.194500] RDX: 0000000000000000 RSI: ffffffffc2200049 RDI:
> 0000000000000000
> [ 5714.201749] RBP: ffffffffc21ff049 R08: 0000000000000000 R09:
> 0000000000000001
> [ 5714.208977] R10: ffff8b901bb403c0 R11: 0000000000000001 R12:
> 0000000000000001
> [ 5714.216206] R13: ffffad99017b3d5f R14: ffffffffc2200049 R15:
> ffff8b900a0bdd80
> [ 5714.223438] FS:  00007ff766da4c00(0000) GS:ffff8b9137c00000(0000)
> knlGS:0000000000000000
> [ 5714.231623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5714.237466] CR2: 0000603000261000 CR3: 00000001b3438004 CR4:
> 0000000000370ef0
> [ 5714.244699] Call Trace:
> [ 5714.247245]  __text_poke+0x207/0x260
> [ 5714.250926]  text_poke_bp_batch+0x85/0x270
> [ 5714.255122]  ? bpf_trampoline_6442489046_0+0x49/0x1000
> [ 5714.260361]  text_poke_bp+0x44/0x70
> [ 5714.263954]  __bpf_arch_text_poke+0x1a2/0x1b0
> [ 5714.268412]  bpf_tramp_image_put+0x2b/0x60
> [ 5714.272608]  bpf_trampoline_update+0x205/0x440
> [ 5714.277151]  bpf_trampoline_unlink_prog+0x7a/0xc0
> [ 5714.281954]  bpf_tracing_link_release+0x16/0x40
> [ 5714.286585]  bpf_link_free+0x2b/0x50
> [ 5714.290263]  bpf_link_release+0x11/0x20
> [ 5714.294195]  __fput+0xbe/0x250
> [ 5714.297348]  task_work_run+0x8a/0xb0
> [ 5714.301021]  exit_to_usermode_loop+0xef/0x100
> [ 5714.305477]  do_syscall_64+0x19c/0x1b0
> [ 5714.309324]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> [ 5714.314475] RIP: 0033:0x7ff766779b47
> [ 5714.318164] Code: 12 b8 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3b c3 66
> 90 53 89 fb 48 83 ec 10 e8 e4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48>
> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 26 fc ff ff 8b 44 24
> [ 5714.337029] RSP: 002b:00007fff9058f3d0 EFLAGS: 00000293 ORIG_RAX:
> 0000000000000003
> [ 5714.344695] RAX: 0000000000000000 RBX: 0000000000000275 RCX:
> 00007ff766779b47
> [ 5714.351926] RDX: 0000000000000000 RSI: 00007ff766d870e0 RDI:
> 0000000000000275
> [ 5714.359156] RBP: 00007fff9058f400 R08: 0000000000000020 R09:
> 0000000000001a8c
> [ 5714.366387] R10: 00007fff9058ec48 R11: 0000000000000293 R12:
> 00007ff765fc4758
> [ 5714.373618] R13: 0000000000000029 R14: 00007ff765fc9528 R15:
> 0000619000000a80
> [ 5714.380851] ---[ end trace e6e6066ea7e090fa ]---
> 

