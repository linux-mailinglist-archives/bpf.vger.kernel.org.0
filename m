Return-Path: <bpf+bounces-20993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD758465B7
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA41B1C2229B
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672AAD57;
	Fri,  2 Feb 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWh2mPhg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3A8BE1;
	Fri,  2 Feb 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840424; cv=fail; b=SWG+FTBtK8c3G/SkOe6Jg9v+jSa0AUZo9isxgrWhBptLP0fIuq+oz+O8g+CcVK8G/2VwoT18nXxFPNksC3dbnKbwo3yXrIzQBNVdQNXLmV8WEoHPQ2kGnbSB15JQr5zi1S3oxBCdL+Wt890U56q7CfG/YRiErTOgdm7YU5KqjmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840424; c=relaxed/simple;
	bh=X8D3KFacdZhRfRczJQcoUr0U+DSHs8mvMollaZBWlnU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gEUVQ58Cow29qN2VhTM7t/nOQk4MYammpPYIi/3qtO44hRICWgM9UX+iPMsmEso29woC9TAp/GvsxT8fO7jaMR1NV0iHmT7tOSe4kLW8owjxh+y07A0pDeqUew6wTJN4HQrRm8+QsFJUQ24y7seHQCwZ7kyAWG4Bs7LyrJC8SUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWh2mPhg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706840423; x=1738376423;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X8D3KFacdZhRfRczJQcoUr0U+DSHs8mvMollaZBWlnU=;
  b=XWh2mPhg+AK+PB6UvVg+Gvkg9bO3m+0OfP+dBNG9er7i+jxaggTjut01
   Xyyt1xv+58NrT6+2c45B2IY+gEZ2wBKvzOmDizNPxFckTUEaAdgbX65BW
   +drODOU3+jdrNfxEMdJ7VWowLOy5N0TTm+Fk5LXzgyMAbUh6p+cEpgXQD
   yF3inOp7LVkcWxrJtE0aeJ+jUDwdHJn0S8mWiSeyl8DOkDYMzdlsQpK5z
   UmiSEs77b0kkX80gWI5uU0ya2C04zsWks/pJHA4ftJwVIATvHA1uZW471
   SyVgNpxacU8fyxmTY0peAXgOPmIjfVzV0ZugI5iTA3z1NSxI4l5zdwK9W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11158188"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="11158188"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 18:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="276025"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 18:20:21 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 18:20:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 18:20:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 18:20:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmBQEVGpWVrew+F+xAgrpfEu+wtQoOuSqTUZJycDQ7eFdDaTVf2rDvjULh4x+Q61/lnn75gbkc4eAMWVhIS504EvBu+e4SCthouuzxkuWK/R0DX4/ds40hLLoThZe1nAQAxGP0w+U917WpFB8ucCkVyK4m+M/ufftnCqoLrMlTWLWcC1M3wJALT2uGtpO4ydN6ce9QeSxTV4VfN/8WVQtdxNSXVblSMl2LRxqjk1uK8rH6vnfp6KkGdBy6l5OnNlxubdUmolbCJB7log48ZgZVZGb+M3bsZMZ/JOOmX4I7HabkCTRr7mDzi694Uz52OBW1rCiut1EHck++6CQ2rDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVwsG/Hphcmr8Vwg4fwbXWjtFI8dQIKho2VCn1uZu4U=;
 b=K71auuGuskwgh8T5XpkFNE2uhQZHCzxU1cl/GcA4CZAeKAPXpP2fiBtxgkmtizsubSdGT2DmNP07HocJ+1GKCllDS7rj1Mvrx6RRlaCsRIuKuMYqYqZV0T8sI9ltMOh/DnkhsPWARAjmjetUqxCGpVJAHBEL7gEmYbR4b2Fm5sqPiPnVPDedef2zV/Zuww+VCkiwMDxBxOScvdSbo1lwf0bJ3yXTLS8G/HmDdeIJq6FqZ0Tz0AZ2KW8cwZikM1f4BOJCFfoJZtqFE9EEnYByy7ru1Q3ezR17Zv04FIycCwv7mjaCTWod/bNuFclJCDR1hZ2od1Re/+AZfuy6+PEbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 02:20:17 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 02:20:16 +0000
Date: Fri, 2 Feb 2024 10:14:58 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <joannekoong@fb.com>
CC: <andrii@kernel.org>, <heng.su@intel.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <pengfei.xu@intel.com>, <kafai@fb.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is sys_bpf related out_of_memory WARNING
 in v6.8-rc2
Message-ID: <ZbxQIthSnVW4VAG5@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f5be9b-d1bb-4e39-8bf3-08dc23957efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTsUIImgdg3R9rpwi0/jcpV/kuv0cCClihIGpmjwWvDMz9e8KDr26B2dDcCp/CRgdIzCzIigg/QRF6irRypieTEhesPRT9PhnA1M+dOIP9Bm2WUpLLXT+NskHKz/8WjHl97n6M+O3cebCpbqU2ogJFHVV1ntZOnVaSMaZmPTrXFxud3w0Ju1QCPY9OG5MeHHqo8Mmkvzd8FcE8h9YL3ZGgLqw+P+Il+zZoV8l9TtYPPYCXKzAqBWdH7usFIzHKtsmiEh+lqbXYa3ZmJJuinvwzRSGUB52Po37sA4REEC3a7PHVU2k2qeEy6cd2lNevV3k1+6Gf9Lh1Yu781dLBgk7zFKIrO1E6Kg7n1bq62rLMuBc/AsHCNsRBE3tLEk7kprhq5goIXC8av48JGXMh+7pNyh/YBm/GSj36qP7KQolfihTFtFGX8HhyyBxRqvA1E5gE65hpwedj3zSQAK0Ke4UY57CISuoEirFc7EfCTLnkrqbUQkrVFhSoI6/MVhV8/VckvxY0xXZ8GCO6v2IzrE++rM/A2OWJV/gVdrK1EbqYqQZlSxWDXaDgpVOXb2WLERTK0uPQrC2RxJ43f3BjKgn+MaURK3jTLBlt15Rg8hLMCK+DGUQ42su/N6v443SyA7ipVFKBN7bGLT62hg6wG6f2gTRpY7NsGY6nVI5E83eI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(316002)(8936002)(4326008)(44832011)(86362001)(2906002)(5660300002)(66556008)(8676002)(66946007)(6916009)(66476007)(966005)(6486002)(38100700002)(478600001)(83380400001)(6506007)(6666004)(45080400002)(6512007)(82960400001)(26005)(41300700001)(107886003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WT+KsvZmF9CPHawB7tl7qaFprdXz+hc+jLJPci7mx9zNS9gnu8XlvWKyTgCg?=
 =?us-ascii?Q?pSevy1UjdAb3Ya4hXx8LrmuIAbcWej+rBsQwdgjVVcc9QrxPpV8+b2djPgq7?=
 =?us-ascii?Q?YEhMtio2D/EGHOyL/Ryn9MemCNoyo0ACLQ558cMBfhM0PXb61zkB4fk97bYQ?=
 =?us-ascii?Q?+leTzPYlQDuY+tjUuDDCRwviE+cXdjxwn5arM6TaNTbEAK4SbbSD8jO91FXv?=
 =?us-ascii?Q?N8e5yX304CXbXiiDsLlrXHtjOcl26c4B5aFDZDLEA8xcTd9p4A4+mi3uZh0/?=
 =?us-ascii?Q?8lW9qYQUv06UD7rEr3FvhqRiZrytzdj7kOrq/rs9Hqr1QgRSAvYIsa23Ehr8?=
 =?us-ascii?Q?Hn2ESG5gLxIYM2F8YkdKtTVG9/p7N7O2D8hxFC0dSWVQYywVBYRGtjf4eWcU?=
 =?us-ascii?Q?suijUs4SzL6vPFS3LSRfo+bqLk71Nj6rDTz4FhpLQUOUvglGt+nr8nzJ2qSy?=
 =?us-ascii?Q?b3WXOlgjCE4VcCtOpufzQ/74FKefZh1bLcwsX/CeYk6fpbABhLBn5APq24+e?=
 =?us-ascii?Q?zVZYphchbHPgjXoOXNTLs6h7VN4psynniDPrwmYe8aGpXRyHRjSzuFkGMrrt?=
 =?us-ascii?Q?rP8dC+HnY6aZ4zjkPhk2KaPJIDiljPBhHuh4b4hiWz6TKCYL4t7csxe/mG/B?=
 =?us-ascii?Q?7DU7UKBrho6oucH4FyTNJI4T4IkOfdT9Yg8wavvSKtDzq5EisWmFeyLQF9jA?=
 =?us-ascii?Q?Iiz9pXgzxPUUeU6feYlFSdDuTSE19cYUEJ02w2LJCsmdn+Ib38oZ7eJtCF+b?=
 =?us-ascii?Q?zbdx7ly2zZr92kktURNcNhuDx/2NPWxWYjb5sgHrU52Iidfgu3gS2/OxaHG+?=
 =?us-ascii?Q?pERkXB9OoAwGuffjHUWPavjQGvBOTPpdSLvNS3wo9ypDZP5O4whntimqvfK5?=
 =?us-ascii?Q?OcWbPVPg7P315QIaWnA9wDsXx7fAgy/jRqwn+mZA383SMPgaX2+5i7FaYX+S?=
 =?us-ascii?Q?ObDPis3ErfRnEvJ8j+Ki1RTca4r6fcwza4VCMqEx9Wn0jP/pqpF2cDEYRW0i?=
 =?us-ascii?Q?MQXkKGNnabrplZaZM65srC24yT3H4wdJPm2VUOgPdgSRzFOX3/3yg1ySv0az?=
 =?us-ascii?Q?pBCidxQPi/IKgFSbmtGk7WOkiHBXB+sL7dq9HLFTy02i0YukGSKkDoKkEJZH?=
 =?us-ascii?Q?Q1VkJTndm5pHZynJOCaOgqiR8AWnYtVaFbUB72tf9oFGuzXIU/M+cZ/Zhy5J?=
 =?us-ascii?Q?+yOVgRlMRkK4J0kZPB2oxdkLEmKnxp8/axVbo7QrPcd8YcWfdok9uLK0hh1G?=
 =?us-ascii?Q?PZL0Xsq1tjHRVaqJQ/J4YG5U12m9lS2cum+T2gneDx6JB6ALSue6tCFR0zR9?=
 =?us-ascii?Q?08bbGKl37+Bdn8sje+Fyumi+DYUDgmYJ7btmzhjSjFkG4ftADrhl+tJN9xzB?=
 =?us-ascii?Q?gjURCq2wONaKuk3/uvkf3wqrUQfi/5cYW/53cCXHCciZCtgHRr3Orl3NIT2q?=
 =?us-ascii?Q?O3rlxFh9nX1facDKTlMsk5k6x/R49Gwest7jlUwDOPZn9P8hpk2FS3O2WPyg?=
 =?us-ascii?Q?OOqHzD59zAd5rtph/GJWtfqkwMfE9AtEkhXDyqsRgDPBDrOF8Ou2jC+TOcus?=
 =?us-ascii?Q?uILpfW3UACA41iQqykzFxCibtJSBvuPlRnnyfPUx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f5be9b-d1bb-4e39-8bf3-08dc23957efa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 02:20:16.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaMM+DMcImAUcvI/p09vf3IL47SJKpnWz8TM86i4CEcnX070UgtDpeNvqyufgVZb0azohDkr7MarlFvKB3Thmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com

Hi Joanne Koong and bpf experts,

Greeting!

There is sys_bpf related out_of_memory WARNING in v6.8-rc2 in guest:

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240201_154123_out_of_memory_bpf_related_issue
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240201_154123_out_of_memory_bpf_related_issue/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240201_154123_out_of_memory_bpf_related_issue/repro.prog
Kconfig_origin(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240201_154123_out_of_memory_bpf_related_issue/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240201_154123_out_of_memory_bpf_related_issue/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240201_154123_out_of_memory_bpf_related_issue/41bccc98fb7931d63d03f326a746ac4d429c1dd3_dmesg.log
bzImage_v6.8-rc2: https://github.com/xupengfe/syzkaller_logs/raw/main/240201_154123_out_of_memory_bpf_related_issue/bzImage_v6.8-rc2.tar.gz

Bisected and found first bad commit:
"
9330986c0300 bpf: Add bloom filter map implementation
"

Syzkaller repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/240201_154123_out_of_memory_bpf_related_issue/repro.report
"
Out of memory: Killed process 4572 (syz-executor378) total-vm:19292kB, anon-rss:0kB, file-rss:128kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_score_adj:1000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 4585 at arch/x86/mm/pat/memtype.c:1060 untrack_pfn+0x466/0x590 arch/x86/mm/pat/memtype.c:1060
Modules linked in:
CPU: 0 PID: 4585 Comm: syz-executor378 Not tainted 6.8.0-rc2-f31cefc5e516+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:untrack_pfn+0x466/0x590 arch/x86/mm/pat/memtype.c:1060
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 84 e0 fd ff ff e8 d4 6a a1 00 e9 d6 fd ff ff e8 3a f0 40 00 <0f> 0b e9 d2 fd ff ff e8 2e f0 40 00 49 8d bc 24 a0 01 00 00 31 f6
RSP: 0000:ffff8880598df710 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888052477a50 RCX: ffffffff8121265c
RDX: ffff888030efca00 RSI: ffffffff81212966 RDI: 0000000000000005
RBP: ffff8880598df7d0 R08: 0000000000000001 R09: 0000000000000002
R10: 00000000ffffffea R11: 0000000000000001 R12: 00000000ffffffea
R13: 1ffff1100b31bee5 R14: 0000000000000000 R15: ffff8880598df7a8
FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f240f7bc1b0 CR3: 0000000006a7e004 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 unmap_single_vma+0x1d9/0x2d0 mm/memory.c:1692
 unmap_vmas+0x210/0x470 mm/memory.c:1758
 exit_mmap+0x19b/0xac0 mm/mmap.c:3284
 __mmput+0xde/0x3e0 kernel/fork.c:1343
 mmput+0x74/0x90 kernel/fork.c:1365
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0xa59/0x28c0 kernel/exit.c:858
 do_group_exit+0xe5/0x2c0 kernel/exit.c:1020
 get_signal+0x2715/0x27d0 kernel/signal.c:2893
 arch_do_signal_or_restart+0x8e/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x140/0x210 kernel/entry/common.c:212
 do_syscall_64+0x82/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f022b83ee5d
Code: Unable to access opcode bytes at 0x7f022b83ee33.
RSP: 002b:00007f022bab0d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: fffffffffffffff4 RBX: 00000000004051a8 RCX: 00007f022b83ee5d
RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
RBP: 00000000004051a0 R08: 00007f022bab1640 R09: 0000000000000000
R10: 00007f022bab1640 R11: 0000000000000246 R12: 00000000004051ac
R13: 0000000000000011 R14: 00007f022b89f560 R15: 0000000000000000
 </TASK>
irq event stamp: 17161
hardirqs last  enabled at (17169): [<ffffffff81431b45>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (17169): [<ffffffff81431b45>] __console_unlock kernel/printk/printk.c:2706 [inline]
hardirqs last  enabled at (17169): [<ffffffff81431b45>] console_unlock+0x2d5/0x310 kernel/printk/printk.c:3038
hardirqs last disabled at (17200): [<ffffffff81431b2a>] __up_console_sem kernel/printk/printk.c:339 [inline]
hardirqs last disabled at (17200): [<ffffffff81431b2a>] __console_unlock kernel/printk/printk.c:2706 [inline]
hardirqs last disabled at (17200): [<ffffffff81431b2a>] console_unlock+0x2ba/0x310 kernel/printk/printk.c:3038
softirqs last  enabled at (17224): [<ffffffff8126c9b8>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last  enabled at (17224): [<ffffffff8126c9b8>] __irq_exit_rcu+0xa8/0x110 kernel/softirq.c:632
softirqs last disabled at (17235): [<ffffffff8126c9b8>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last disabled at (17235): [<ffffffff8126c9b8>] __irq_exit_rcu+0xa8/0x110 kernel/softirq.c:632
---[ end trace 0000000000000000 ]---
syz-executor378 invoked oom-killer: gfp_mask=0x102cc2(GFP_HIGHUSER|__GFP_NOWARN), order=0, oom_score_adj=1000
CPU: 0 PID: 4635 Comm: syz-executor378 Tainted: G        W          6.8.0-rc2-f31cefc5e516+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe1/0x110 lib/dump_stack.c:106
 dump_stack+0x19/0x20 lib/dump_stack.c:113
 dump_header+0x111/0x8f0 mm/oom_kill.c:461
 oom_kill_process+0x287/0xa70 mm/oom_kill.c:1032
 out_of_memory+0x34e/0x1720 mm/oom_kill.c:1170
 __alloc_pages_may_oom mm/page_alloc.c:3483 [inline]
 __alloc_pages_slowpath.constprop.0+0x182a/0x2140 mm/page_alloc.c:4243
 __alloc_pages+0x45a/0x530 mm/page_alloc.c:4580
 alloc_pages_mpol+0x278/0x580 mm/mempolicy.c:2133
 alloc_pages+0x140/0x160 mm/mempolicy.c:2204
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0xb7c/0x1570 mm/vmalloc.c:3320
 kvmalloc_node+0x1be/0x240 mm/util.c:642
 kvmalloc include/linux/slab.h:728 [inline]
 kvmemdup_bpfptr include/linux/bpfptr.h:70 [inline]
 map_update_elem kernel/bpf/syscall.c:1547 [inline]
 __sys_bpf+0x426e/0x55c0 kernel/bpf/syscall.c:5445
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0x7d/0xc0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x73/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f022b83ee5d
Code: Unable to access opcode bytes at 0x7f022b83ee33.
RSP: 002b:00007f022bab0d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004051a8 RCX: 00007f022b83ee5d
RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
RBP: 00000000004051a0 R08: 00007f022bab1640 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004051ac
R13: 0000000000000011 R14: 00007f022b89f560 R15: 0000000000000000
 </TASK>
"

Hope it's helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

