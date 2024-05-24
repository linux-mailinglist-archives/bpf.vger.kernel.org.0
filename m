Return-Path: <bpf+bounces-30474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E28CE1CE
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 09:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94CEB21A3F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5896283CAE;
	Fri, 24 May 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcqIBrSo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710682D7A;
	Fri, 24 May 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537179; cv=none; b=Ji0H3/x7bmVPqOx7ll/OJUth5mFzpVYeGOo5VFcUgP3GDVk57fRhsL0lQMe5zPONwM1ZIcUPjlEdF/B4GiRfkjJJeybZBl27rrBc/3RIunz6oEK/x7R5uPKAGEBVYJpgT1X9KFDMTPYH/hnHg4fd0zt5FRrHRCljbi0Kcz7FYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537179; c=relaxed/simple;
	bh=ch+MbRPZTGBQUr5ZCA23iXr8FmFMlS0SQtrDDjy1Y0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YDB3XaxomhMXT1AOP5L1F0M71YQCnjduiLrAgS975L58HW5uzLnfh//6Q0Zu6vRDWk/Ji4WceEQR7PIxLNeCeiCa7rYERkhqfKD5V5FTrLHs6iNcg/6oZnIW87B74pn9Ra012mfEnTBCQ4eEx3cuOWdSPX+nfci3q4RQyT7cSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcqIBrSo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716537178; x=1748073178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ch+MbRPZTGBQUr5ZCA23iXr8FmFMlS0SQtrDDjy1Y0M=;
  b=YcqIBrSorjaqPGS9xYxFnc+A145D83oPgTTnsy18f5uEUuBysMo3O5Vk
   gCxmmIAmWdgEjFIG2Q6pdObblH6C8/rnScCfw7x998JgyRq8KJzGFKXUR
   pN/yBTua7plcHNC/xLw6Zv6HeP8xRGl/wg3ANI1LLUqmHOUcCrD74qI/X
   mXwahMX9FoTONQAnZT26EqurwnC0jfmwZoz6Z69MZnt3vnjyEf61vM6qs
   JkZp8OXGam4L5OaJMn5fak6a/Lb3xm+kivVFiyyN8KbEIxZDhp0cjhkbB
   o3P3O5PzGXoSt9GJnl/MEsbXtYEnb0sU/VKPdNCHpv9ldlAAmGPt69ur9
   g==;
X-CSE-ConnectionGUID: vaNWmLemQr6LCbm9ogJzBg==
X-CSE-MsgGUID: 8hFIiiosSvOByXHHObk4Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="15845955"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="15845955"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:52:57 -0700
X-CSE-ConnectionGUID: Re7qkzs6RuCEsJ3DEFCn2w==
X-CSE-MsgGUID: 9CFGnEvqQjKWmLYUyFkJjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="33953892"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa006.fm.intel.com with ESMTP; 24 May 2024 00:52:51 -0700
From: Xiao Wang <xiao.w.wang@intel.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	bjorn@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	haicheng.li@intel.com,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH bpf-next v4 0/2] riscv, bpf: Introduce Zba optimization
Date: Fri, 24 May 2024 15:55:41 +0800
Message-Id: <20240524075543.4050464-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The riscv Zba extension provides instructions to accelerate the generation
of addresses that index into arrays of basic data types, bpf JIT generated
insn counts could be reduced by leveraging Zba for address calculation.

The first patch introduces RISCV_ISA_ZBA Kconfig option and uses Zba add.uw
insn to optimize zextw operation.

The second patch uses Zba shift-and-add insns to optimize address
calculation for array of unsigned long data.

Thanks,
Xiao

v4:
* Combine the second patch (previously v1) and the first patch into a series. (Bjorn)
* Rebase the second patch on bpf-next tree.
* Link to v3: https://lore.kernel.org/bpf/20240516090430.493122-1-xiao.w.wang@intel.com/

v3:
* Remove the Kconfig dependencies on TOOLCHAIN_HAS_ZBA and
  RISCV_ALTERNATIVE. (Andrew)
* Link to v2: https://lore.kernel.org/bpf/20240511023436.3282285-1-xiao.w.wang@intel.com/

v2:
* Add Zba description in the Kconfig. (Lehui)
* Reword the Kconfig help message to make it clearer. (Conor)
* Link to v1: https://lore.kernel.org/bpf/20240507104528.435980-1-xiao.w.wang@intel.com/

Xiao Wang (2):
  riscv, bpf: Optimize zextw insn with Zba extension
  riscv, bpf: Introduce shift add helper with Zba optimization

 arch/riscv/Kconfig              | 12 ++++++++
 arch/riscv/net/bpf_jit.h        | 51 +++++++++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp32.c |  3 +-
 arch/riscv/net/bpf_jit_comp64.c |  9 ++----
 4 files changed, 67 insertions(+), 8 deletions(-)


base-commit: 5c1672705a1a2389f5ad78e0fea6f08ed32d6f18
-- 
2.25.1


