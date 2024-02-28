Return-Path: <bpf+bounces-22837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1A86A727
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 04:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E86284C4E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 03:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB561E864;
	Wed, 28 Feb 2024 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="awlaztJw"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BD1DDF6;
	Wed, 28 Feb 2024 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090523; cv=fail; b=hCK/tzQxuEMRbIAHDbh46NI01Y/S6HX/tE+2oemWL6tnbcTzmrwpKLdCjAA8dGPMpNi/pM53K8zXR13mWo4HtHCSjDZ3hAyceU131KntB7HKgA16Ca/PjHeL5S9cwG6xdJfdI0egRg0B0Yj0Oa1wHw7yOMd+5dTrMzAFPLU/bn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090523; c=relaxed/simple;
	bh=hKj4q2l2PGGIvSud1glPqlswPjvKMvatHvDNE7vRE5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=goUH1/hiAMPhp5GUDsvRtLEQOCiWsaWUnpW1JjZEl4iuvaEHbse5habKMmLwoKIlTeB3SovT8NuXguiq9g1CZapuXIBYozh0j1sPyU+lwB3aOumv1Lso7QXq8eo48eDfgXP/CvLE5DBWes2C+6CigHtRSC4YfkMa7PZV1GtNva8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=awlaztJw; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUrSrUCGfewfTs1P7XLQnixchJkbXCHvVQuZqmGdeCJRNeBv/mvmp334V3IT9yCmJLpIknaRXnpRYCVpHQpC66S3wGQa5Ikfukf6F3AyFabk2+jEZGue2FBH4RqGy/23gpnP7dzWcGu2fT6gPJHoTWCklLr4h9z4oDdGztXdXZYaKWTYCbT8sdrqivYwloU0l6RT/k8dM9u7+8RUxCvYkC+VO6j/7l44m6ycsW5TQa6Y7dfDqhvwdlXFuigx16CmC00GKeHzQYqCZG8RSXerc4Vmjcv86xS1G4ZTFFI4Q7hHycsFf0DjQAWAknT74wcf59tF/7ok/IvHplG1+ysiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bezVDwze1jNdYdh4gVQ8p+M2LuMHe9XNn7yr3MTQVV4=;
 b=eWNgLTTKWlwgD0SW+dDPzyRKsNS4C0xKJSw8OyDD6mnPAFtUQAf5LFAI2B8iNCc9dOrTNHGrdytz9QB5wMC4ChP2KKUYr4USy/J5bem4Pa1mFX0hVbrkBQEi189hHi9lJ6mf2wymoOPw2TUmMWy3pSs3FrBfraWecsdyxZzoD4sfZYUtiMEx5IsbLEeXqPNB02KTeI1PiLrt7jcxEi+0i8clZ0IJBWqr7Z6BIy6ZY8zmOqXwTaTchBMmkuWJS35AAyHWdl/4zncZw1LrcdyiVJhDqfoAqFet+EjlUtaFpDcvMXC81A+sS7+hZEHYIej2Bl0vB+87KUKAEMY1Svp4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bezVDwze1jNdYdh4gVQ8p+M2LuMHe9XNn7yr3MTQVV4=;
 b=awlaztJwi3veePDPnUX0iiPq+86sn9klNFFSMPnxHNtv5KlQ6dFmBd5Ov8xXv2nS+l3gBT+3teMrMQjT7butwLaBIJwfz16SZZgw8icWiY0tPMKfLuATB/IZJ2gkAbjeFz0/VeAnBI5Xd6+pOQv0Nce6ofw0YpzwuXJq2090xwvi4mGk6kz02ncOzvnghB2/DqVKL/BojaMk3xMt5V862aAgdUMuD6h9Mh3bWNBeoRNrvQXVtABKSVWr2Kxyd3hJYDAl3J3IwdWLz+CnX8g99wKjlZ/imidsjp5zy680Rs5+sYJxMI08mhdXOI2uAN9HWsaKDlFKe801XPedxIuJsw==
Received: from CH0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:610:119::9)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 03:21:58 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:610:119:cafe::69) by CH0PR03CA0362.outlook.office365.com
 (2603:10b6:610:119::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Wed, 28 Feb 2024 03:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 03:21:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 19:21:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 27 Feb 2024 19:21:44 -0800
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 19:21:44 -0800
From: John Hubbard <jhubbard@nvidia.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
CC: Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <dwarves@vger.kernel.org>, John Hubbard
	<jhubbard@nvidia.com>
Subject: [PATCH] fix linux kernel BTF builds: increase max percpu variables by 10x
Date: Tue, 27 Feb 2024 19:21:42 -0800
Message-ID: <20240228032142.396719-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbafc3c-f241-4d51-e54e-08dc380c6c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hEyHgzYOvgy87RODtfl0p1tk6ZMhNWBbvnnmJq7gDBgPqegWcL1kAzd3iJHsT+FJZIhsu3Ag02F7A99tkvpIWE10dVl9LIxATpe8S0ptmeou9Oz6EhmSvm7vxpYUP2sH0U6A3xlY54QdgZMn3alq6yEmTWQ4HRamwenlPWHt0IOpIhZ6e145EKzzpxfdu0mXaRy/heHO75P3VJmK31gniKN9YPSZSoXV9TW7H4gzLmlkk7tLDKNKh8aditmzHciTH1jFkADW6dVZ1oeZEb7N4WtzU15/BWA8WEMO6eCCr4FXvMAcGGzgGb8TrY0iJfkCLvuLtsbNK7beD0zyHtUCY2JJrJW22KM3pE1zYXW1OPfxQx+UHUNr3XBfOWUTDnql/x15TTba7J3Dt4C2vO6Jlbrm93zHJe7n7i1Iz+nWFSp+JoOYrziBtYW4h7SQDstA0mEw1rYj0vCPXM5r7Hwap1O4Ct7sSdkA3K9Wdjl6UFnDmtSjKHDCqmHlNqm4PO4jnJQtTI4EvfeN5fPUyBLPrnvFII5dge3uImLNOKU3eNh5CdJJVFk3y97xQcF9jUZPu+stg8oNaJDlTqxQIRDXuH78efGraMyRY1arzotZ1lgGvlFj9EDmX5IPLBRs8ItFnGYYwS6+k20IhQLTkZ0+CO7Dp3phj22F4f+lALkK2tInEiMYF5mjL/HQD30aqlW4Gg+PxOLKC/0G3p+NAw8CH7R4ltMiOIcaQy+pmZS9s5WYG56CPJFl7rfAEBvvYTBK
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 03:21:58.3638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbafc3c-f241-4d51-e54e-08dc380c6c24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

When building the Linux kernel with a distro .config, most or even all
possible kernel modules are built. This adds up to 4500+ modules, and
based on my testing, this causes the pahole utility to run out of space,
which shows up like this (CONFIG_DEBUG_INFO_BTF=y is required in order
to reproduce this):

  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
Reached the limit of per-CPU variables: 4096
...repeated many times...
Reached the limit of per-CPU variables: 4096
  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  BTFIDS  vmlinux
libbpf: failed to find '.BTF' ELF section in vmlinux
FAILED: load BTF from vmlinux: No data available
make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 255
make[2]: *** Deleting file 'vmlinux'
make[1]: *** [/kernel_work/linux-people/Makefile:1162: vmlinux] Error 2
make: *** [Makefile:240: __sub-make] Error 2

Increasing MAX_PERCPU_VAR_CNT by 10x avoids running out of space, and
allows the build to succeed.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..d9f4e80 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -50,7 +50,7 @@ struct elf_function {
 	struct btf_encoder_state state;
 };
 
-#define MAX_PERCPU_VAR_CNT 4096
+#define MAX_PERCPU_VAR_CNT 40960
 
 struct var_info {
 	uint64_t    addr;
-- 
2.44.0


