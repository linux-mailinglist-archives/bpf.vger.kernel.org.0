Return-Path: <bpf+bounces-44133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E169BF2D0
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472211C269DB
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6320605D;
	Wed,  6 Nov 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="fkPvdCYb"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9420513F;
	Wed,  6 Nov 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909289; cv=pass; b=CzU27zmVOqsXhTgqG8JGoJ4eMMuAc3cA3iVePjyZtTArTfqrSq29VhviUVOXsIRNYuUg8fVKZflfbHOzKDZYUFZmcntZ6kg+r5CBDN7GMBqQ1jfrX9WOEPeXS1+KWAtqnDvErkQfgb0kJdqzcafZc8tQgu3aQny4MquHcy2bnQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909289; c=relaxed/simple;
	bh=e8ncEEuW7cFbLsRNpBTLTILlUQ0m+ULp/aJ3ntDFyTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPfSFclVxURAVr604G7LJAyme0y4tW/opYpV2PAeirWj+B3tVsreNIl6T4uU28wAgQjioHyE6jZpF6X50MD7JgbYj6aqNfJfUtXzVcq8beFw0DaHMax41+CYa3ZdFRWsYMGw5jo1pO2hnvHwIGHst25i60qUlA7h0ZinRZJLn+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=fkPvdCYb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730909280; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EYaNphjKrf1ONSpkisQ1saF8xG7z3ivaqKEAKMptWBeUcRtlQ9mT1sK9JRT3ssrjlSkzhtfVuSprQ/gGY0VzoZ8udlpIqUPnu9lo6SL64EqVRyTWM1Cio3cZp86t8Ub/rtL8AzCalELmLpnOIJnaP4ky2veMcoa5luMx269AL8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730909280; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ej7PlNROi5y6rJY01LVfYSZ2mQDOu9Gm4uuZ4iC9/7k=; 
	b=PX9JtJNoFt5/Eol3PKh1/rQ6j5dwhOM/HusW2krj8VUWDxnC0AJ1C6mBZ9GEewrF5MWTtCVojriHCcslUC1K/hPO9HijxxxX+H2VSv+4IjlF54dOF7Zk6Txj5SUqMmWnaiMnzNLbF/1Zc2ETXsF0TW8+ej2qua3tYvJo0Rmk/UE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730909280;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ej7PlNROi5y6rJY01LVfYSZ2mQDOu9Gm4uuZ4iC9/7k=;
	b=fkPvdCYbLBXCOuPAgBTdLokBGQLdjpPaqRWnAJjGlDi5ymo4UKDWfkyO+VpNGLdm
	bB4P8Lm8i51f38GHTB4pPd1cE3+Pc0uSTJOVvwNsmO33uugS3Zei+5EI/kXq//Gl+aT
	gw58eG9n7uewHWoF7tmMy0pedislf4Hik5RmfK9c=
Received: by mx.zohomail.com with SMTPS id 1730909259613680.21413674386;
	Wed, 6 Nov 2024 08:07:39 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [REGRESSION] module BTF validation failure (Error -22) on next
Date: Wed,  6 Nov 2024 17:08:20 +0100
Message-Id: <20241106160820.259829-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello,

KernelCI has detected a module loading regression affecting all AMD and 
Intel Chromebooks in the Collabora LAVA lab, occurring between 
next-20241024 and next-20241025.

The logs indicate a failure in BTF module validation, preventing all 
modules from loading correctly (with CONFIG_MODULE_ALLOW_BTF_MISMATCH 
unset). The example below is from an AMD Chromebook (HP 14b na0052xx), 
with similar errors observed on other AMD and Intel devices:

[    5.284373] failed to validate module [cros_kbd_led_backlight] BTF: -22
[    5.291392] failed to validate module [i2c_hid] BTF: -22
[    5.293958] failed to validate module [chromeos_pstore] BTF: -22
[    5.302832] failed to validate module [coreboot_table] BTF: -22
[    5.309175] failed to validate module [raydium_i2c_ts] BTF: -22
[    5.309264] failed to validate module [i2c_cros_ec_tunnel] BTF: -22
[    5.322158] failed to validate module [typec] BTF: -22
[    5.327554] failed to validate module [snd_timer] BTF: -22
[    5.327573] failed to validate module [cros_usbpd_notify] BTF: -22
[    5.339272] failed to validate module [elan_i2c] BTF: -22
[    5.345821] failed to validate module [industrialio] BTF: -22
[    5.423113] failed to validate module [cfg80211] BTF: -22
[    5.443074] failed to validate module [cros_ec_dev] BTF: -22
[    5.448857] failed to validate module [snd_pci_acp3x] BTF: -22
[    5.454736] failed to validate module [cros_kbd_led_backlight] BTF: -22
[    5.461458] failed to validate module [regmap_i2c] BTF: -22
[    5.470228] failed to validate module [i2c_piix4] BTF: -22
[    5.491123] failed to validate module [i2c_hid] BTF: -22
[    5.491226] failed to validate module [chromeos_pstore] BTF: -22
[    5.496519] failed to validate module [coreboot_table] BTF: -22
[    5.502632] failed to validate module [snd_timer] BTF: -22
[    5.538916] failed to validate module [gsmi] BTF: -22
[    5.604971] failed to validate module [mii] BTF: -22
[    5.604971] failed to validate module [videobuf2_common] BTF: -22
[    5.604972] failed to validate module [sp5100_tco] BTF: -22
[    5.616068] failed to validate module [snd_soc_acpi] BTF: -22
[    5.680553] failed to validate module [bluetooth] BTF: -22
[    5.749320] failed to validate module [chromeos_pstore] BTF: -22
[    5.755440] failed to validate module [mii] BTF: -22
[    5.760522] failed to validate module [snd_timer] BTF: -22
[    5.783549] failed to validate module [bluetooth] BTF: -22
[    5.841561] failed to validate module [mii] BTF: -22
[    5.846699] failed to validate module [snd_timer] BTF: -22
[    5.892444] failed to validate module [mii] BTF: -22
[    5.897708] failed to validate module [snd_timer] BTF: -22
[    5.945507] failed to validate module [snd_timer] BTF: -22

The full kernel log is available on [1]. The config used is available on
[2] and the kernel/modules have been built using gcc-12.

The issue is still present on next-20241105.

I'm sending this report to track the regression while a fix is
identified. The culprit commit hasn't been pinpointed yet, I'll report
back once it's identified.

Any feedback or suggestion for additional debugging steps would be greatly 
appreciated.

Best,

Laura

[1] https://pastebin.com/raw/dtvzBkxh
[2] https://pastebin.com/raw/a1MGi3wH

#regzbot introduced: next-20241024..next-20241025


