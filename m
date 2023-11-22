Return-Path: <bpf+bounces-15630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DAB7F4007
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 09:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68CCB20EAD
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9BB208C9;
	Wed, 22 Nov 2023 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zv8r5A03"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33AA10E;
	Wed, 22 Nov 2023 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700641395; x=1732177395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BY69KRJyVnfr650kIJoZMO0IwdZ8tdBk9ZG9Q7+w90Y=;
  b=Zv8r5A03cRJ4fZbdmnBa44FZmWE8Zqn3f+WRWBYAba6D32NVIUnkDH7N
   AJr019gpNstCxcKIjliDxXB6EKLb1nsOS+cQeP29gx98sOwY6X0gFa/24
   xgwbKGMmD/MzY9vsJ++JGqnETskPbojlKgKK61iKT6qkEmWVi2cJQKPQO
   DXch5qMMPqf8NVmPoVdQvQZfAo6oqD8OdORIbVy6rhNsVXMUBKUSVwped
   UJlxHWtsiQQpuP58XwfEgsU2t+52L+FgE2gG5dra+G5Yu/76LrOREsQlL
   giiOiU+ik4/PJg7LygLxQhzL0FCh5xseKrp6qEuw9Dgqe6Ooe43u7Q+PO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="390870124"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="390870124"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 00:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="8366873"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 00:23:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 00:23:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 00:23:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 00:23:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 00:23:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvprLBlijTqrqAaoXswcOdJddMvp7aUCB8OZsvj3MluUQ67GTFxLMTfQMhPZcqQ28Z0YoBnVaZ3kBnCf/fmasXih+63wy2XxJwp60TmZQiaxsgW9LeUidOGIrt+f91xNH7VVSypunES6xLABZM+4ujA4WOgFxcPs13IZ+SPg6EaTs8nxaInMxuFX7pWkwlu7znvdxRfzpmxCVbK29T2gIbidv+QTMCe+2HQkNQm4tFHYQYLoGbsGx5wmATUxnMII+KlDR8rTuK4PamxIp5nE+xFZ0GQTLdzo3q+Fz8WMpGe+yY2EpnIsLogy0svDufJqNnMWJjWQogoM+9Goy2U/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9MbO9RYIyEEJhn1zYZBXGb1lGbJ+uh+hX+x+bGC8SM=;
 b=HIv0bPhznS5GCsnbxDNWWP/1btvnU7zqsFATd0K9t7xTs36YaToU8F2KVdpVRpey0Z0A0C8+NaJmX9rSZCby4PMHivpFcAvDJUWiXW/M/sFoP6I9TI9ceWweJamkutC4+jzCFDQPZDOmlX5X7H1fMeL/7iuEi/Tb05y9EGUS25yf8gYX6mNaUPLqtJiqBf57zUoxz0YiQe2s2I12yLF1Tfvbbf4fveyce8z+BWQduXorVvPDeVukhTufEmK9eBORnwxJmCUfaRf1sEq7aKmgV6nnxqaT8F3b8r1Xo+VXAtt8SyY7Bdm9gIClcxaneIdEw/CQEcS6zj9AsQ+OlffJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 08:23:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 08:23:02 +0000
Date: Wed, 22 Nov 2023 16:22:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>, Nicolas Schier <n.schier@avm.de>,
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "Martin
 Rodriguez Reboredo" <yakoyoku@gmail.com>, <linux-kbuild@vger.kernel.org>,
	<bpf@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [kbuild]  72d091846d:
 kernel-selftests.net.udpgro_bench.sh.fail
Message-ID: <202311221453.9e6d5ac0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e354ab-9c3b-40d4-f279-08dbeb343ea8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1M/dhBS07cgVDAx/l6d4paU5F8MgPfhoUDPywk0FBlUTMdu0E4SzBOqBjWlgy9OCSiry0dMHtREisbZzvn0/LJsyqHrRUTF1O2Hd4UMqRQwaIYBA8RW3ZIW9y4lmo6rQG1QHeT0J+I9cDSIO738MF3nziHi7yokrL0KhznCdLrN2oDId/jGMSC7sKfF2Z3DlA16YJ0V2700OruzCmFkBQloTk5x+oqG89RxZAqqQT1J1qoWZyvJVGJ8hd7kPmcnTLmyKQfn6Q+QgbOtB6X/bV6+D79f4M0+HDYRaa+PEmKBIwWkJ+tRQxlPE/UvQXU+AGBrzg4NzKzqYzddAkBXy7qt4z5iNs2NOdR7yzGYDZL5UbMdLSWpRq3WHYbQIj+Wn1IIeESNnpuGHeFYz8kZbm747hTMdFRI2hP0qTBQ6EkbPMIrNp4AmiQp5nTl52A7VyC4ysv4b12SPqbrJYkjj4+rtxvEe1tPei0WanCahOQE7cqsRRJHVgBzwh7GhjGId9hARsyI4FZuETINIMdLNKDmtqIQgyMxnSNAHvv1Z5cVD3x1PNAjcfhhwcg48Mo3N8L6izrzd70C6k3+gNz62SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(86362001)(82960400001)(38100700002)(36756003)(107886003)(6916009)(316002)(54906003)(66556008)(66476007)(966005)(2616005)(1076003)(66946007)(26005)(478600001)(7416002)(6512007)(6666004)(6506007)(5660300002)(2906002)(6486002)(4326008)(8936002)(41300700001)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hJAF7GTU+IAdybWAZ5lwnzmPtv+JMASdcCQgLk+/Spz/y9Wp8qy9YFjLiG9?=
 =?us-ascii?Q?+g2kuSf3y31tyvBqq47bYefAWsnvSGjadM2juTM2Q8jicaRnYkOhsBzwEkEM?=
 =?us-ascii?Q?pqGv0abZdt4BfnW4ryT5/iMvMEivBycLYx+QyEbGmlKjCo9aWcjxSq+lNGLW?=
 =?us-ascii?Q?E59wAWAM89mcKX+MfXxLzJOQ00/mE2NBfaJ2d+Y2MTbUkH4ExAieARel0uEv?=
 =?us-ascii?Q?LK4URYu21f4J3xaGzSNP3kIfZR2qMdBs4rJnufUG96VOkbGE0dqzlJVRyiiS?=
 =?us-ascii?Q?Y9/W7z59TjjClOwnBDwJChFP0nmWSLr2WCuKkEUN5EOJuOX0Xg/gRIVlmNlW?=
 =?us-ascii?Q?KOkDugE1kAPk33n0j8pPVuxV0Cyy+TC+Djs0H8Ievd6L/VSPeDNeZPtrO8rW?=
 =?us-ascii?Q?dmyB033xJRNv5nplCOltkmHEhAXzYEnN7AG3bVp+qTIZ+Cu6A9F28d0w8zcv?=
 =?us-ascii?Q?KuWbBcsYK0SThViY8QHL7dXIe4o5qJhH/BACR+FQsFn1mE/vOSTJBvIVhHSs?=
 =?us-ascii?Q?kAHeydDs6+QqFAnflpd80NaIJUFwnF3gCheyAu2+wx4exavVOExNluw85Wuk?=
 =?us-ascii?Q?Pf06wdAfKJYgieMvYCN03hQHVzd0FkDpGutDOnFo+Rbs5MfWgnzMPBCuJev/?=
 =?us-ascii?Q?ljdHYSNBlSyoGAy/OXgJT3nP/fH7+GzLW8y3NIUc0jEOKMJ8tjOsCYRgq5D3?=
 =?us-ascii?Q?zNppV257FAxyQ0PJrmWZKv80Mv0t4Dxu2ZyQGlTHZKSmV2HLHdEzo40gF+Ko?=
 =?us-ascii?Q?8Hgo3R5wmZF0bQDzk7iW2nQgPjmY4wnf6MIlIAA9gS2iyXUlMB/7//sN5sHm?=
 =?us-ascii?Q?4Xu96ktgL9L+4Y1WEojkIoage9lsGJLdfwXgVPnEGvHHFHLz5I97L6WH4D6W?=
 =?us-ascii?Q?LuWHv7DYDM3ufYwZ0AGB3l1yIl2v+V1U7mJXLJj0PSL06pdd5i0RPjLPw69v?=
 =?us-ascii?Q?vHjtu4SI4FI+6OwHEIcxW7M7DdeBOCrMWL8FGh6NGlqfYpTmuwYr6Y5NZ/NG?=
 =?us-ascii?Q?B+/gnjMH49iAUku8oJeosTAwHVEe/ksI8Y4Tp+vZxNHj7xiK/xI0YXB3H/Ps?=
 =?us-ascii?Q?W8nZclQwPI0Y+fN2VoBEEJPWOmtrLpIklhDmzZOQmchF2zZXHBqino0fVqO0?=
 =?us-ascii?Q?MG03kst9iGcN9sBJMSR3hrwWJH3p6R8bvB4RtdDSVdsbZno8lcq8bBqDPkY2?=
 =?us-ascii?Q?GlHDMw94bv7raAk17UqhpF1yRjcNZL7IirVYeqHCBqPnMqC5yQW8q2t7sU40?=
 =?us-ascii?Q?xaUmbeT7XIJr2IvYt80h5SA7NMWwjJm48QI17ais5OBqb05ndXYOxUG+EO8g?=
 =?us-ascii?Q?nlQDU55eToHM7uhTL9pzmE6HIUjWhqATeEXrSV3GxxCopRKJtmnHjf/qdiUu?=
 =?us-ascii?Q?xBD0L0hAcQwViFcn/tmtKAVR4jY3fDyFvteILNV+tbha7kdztS+sIXlzfLBm?=
 =?us-ascii?Q?p1+Qh/ZFrK/zM0E022+V8+GAUqAFzgsQYXRRiLJNEmGsCqwnmyhzP1SJ3FFw?=
 =?us-ascii?Q?7pkVntb+Y/1XnkpCtAZPkILH5gCd2nJThAQJUMOrZXjdDVpwM48CMgdgaucL?=
 =?us-ascii?Q?wlv8eW7c+35Kl2qEKjAVD8T6whdZybOOgaDm9wf9JS1U2WwIZOD4eyzRd8ND?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e354ab-9c3b-40d4-f279-08dbeb343ea8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:23:02.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qd7vOl+XO0rOCzYiaJPR+RqULINr03aZw32ksP6RVQ7tV9aK69RmGS/7xvWCeLq+N7rO3TOlRfoLx04fuj/vHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.net.udpgro_bench.sh.fail" on:

commit: 72d091846de935e0942a8a0f1fe24ff739d85d76 ("kbuild: avoid too many execution of scripts/pahole-flags.sh")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 7475e51b87969e01a6812eac713a1c8310372e8a]
[test failed on linux-next/master eff99d8edbed7918317331ebd1e365d8e955d65e]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311221453.9e6d5ac0-oliver.sang@intel.com


besides kernel-selftests.net.udpgro_bench.sh, we also observed below tests
failed upon this commit but can pass on parent.

7f6d8f7e43fb516f 72d091846de935e0942a8a0f1fe
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20         100%          20:20    kernel-selftests.net.udpgro.sh.fail
           :20         100%          20:20    kernel-selftests.net.udpgro_bench.sh.fail
           :20         100%          20:20    kernel-selftests.net.udpgro_frglist.sh.fail
           :20         100%          20:20    kernel-selftests.net.veth.sh.fail



....

# timeout set to 1500
# selftests: net: udpgro_bench.sh
# Missing ../bpf/xdp_dummy.bpf.o. Build bpf selftest first
not ok 25 selftests: net: udpgro_bench.sh # exit=255
# timeout set to 1500
# selftests: net: udpgro.sh
# Missing ../bpf/xdp_dummy.bpf.o. Build bpf selftest first
not ok 26 selftests: net: udpgro.sh # exit=255

....

# timeout set to 1500
# selftests: net: udpgro_frglist.sh
# Missing ../bpf/xdp_dummy.bpf.o. Build bpf selftest first
not ok 53 selftests: net: udpgro_frglist.sh # exit=255
# timeout set to 1500
# selftests: net: veth.sh
# Missing ../bpf/xdp_dummy.bpf.o. Build bpf selftest first
not ok 54 selftests: net: veth.sh # exit=1

....



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231122/202311221453.9e6d5ac0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


