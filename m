Return-Path: <bpf+bounces-3148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0691573A34C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 16:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63BF2819F3
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D41EA9B;
	Thu, 22 Jun 2023 14:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D803AA98;
	Thu, 22 Jun 2023 14:41:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557281BDF;
	Thu, 22 Jun 2023 07:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuC0OL9yeYJNZDEZnN4i7cpzzXp/VPjYMx3XHOr3PZx6e0hmxuFQEE/5RpCd+sCeq22h9v+hDFwn9akpTtOubxhQrZU2W3ADbU848exdQvGz1NthvUddEHrVSaMnPgvl23ZuyDjjGlERrPXNuTuykoBkN2ncJPT87jA1XRB8yFRPnEE410lYPBtNOVUBSvMhMckSNWMBpzYFJCvLD6bc9YWD7CcFEHE9lUj7ky6pX/dt3T8l6shwWusGQrohsHblEwphvBo2z98ICk19oZCnJ2XlvYKyTRBPdBN18zjrBL9vjc6eanvF5gk7jh8fNRMWFg1HlImWeWBlmuFzj+w9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4Bvi8BXYpGMfDKmCFKr2rlt7A6VZRRgZ1yIxTDz22s=;
 b=fi6M+6Ef+kt6GnQuwP3Ga/fY4l6Cdafg3LaYSN1Ro9pOlYK+FEFhybYZwiBhBKoB56tASxZFDgVKzlzcrfER+ePY3Rvk3YTmQKL17vIrpWqil3bhMCwIMQz6GkDYEAwemsAvr7CIBe7mKoYoval3e8zynfbl6d/rG+da9xjmEmhUcZYeswB07evYScUoi69IIIDmCLEyIQDGu30Rt46axTmaY4VCYBMspxdfZTVroZC+LuHbXT7U2rIIFsb5WiRJ8B1jBRidvNTxYculXMpE08MTsqWuKsakmKJVqmKXcg2b+RN4EM16x76NFSir03ID414OHldj3NA9KqrccjnDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4Bvi8BXYpGMfDKmCFKr2rlt7A6VZRRgZ1yIxTDz22s=;
 b=QGcDVC5fLDTRJVXafqIZyoypsFCZiItNOvpfMofeZ2evg5eWjJEvIU1GI5rjNAmZTVZ0EXMOIfVk0lHXDGQPt4wk7VwaCFvrI8/jV2vRwEh3SHdCUyGIP+pV8yNFCu1rIQwp8PD16xFEfh+i2rDRW81Qtlo5tmgxntfgbJMRipI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4821.namprd13.prod.outlook.com (2603:10b6:303:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:41:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 14:41:37 +0000
Date: Thu, 22 Jun 2023 16:41:26 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan@web.codeaurora.org, Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next 1/6] platform/x86: intel_pmc_core: Add IPC
 mailbox accessor function and add SoC register access
Message-ID: <ZJRdllrXB4bi7oOQ@corigine.com>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
 <20230622041905.629430-2-yong.liang.choong@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622041905.629430-2-yong.liang.choong@linux.intel.com>
X-ClientProxiedBy: AS4P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4821:EE_
X-MS-Office365-Filtering-Correlation-Id: de07cb30-429c-43b9-eee9-08db732ec830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tCGbrqR0k0hQw0xdtkMu2cQIYC9fVcipDt1sxP/oTMqUkx8a7SmjHiAcfybg8Y8o+a5gnsFIrxONVaapRwaY3ahWeNIrvFICWxFZltsnFjUt3xYZu44uTOtJcZFPFVjB+AXkGyDixQSHsihhl+TklVg9wwFj5aRWJlao4FWBSxsK3YpFozYscoVMwOYoeenItV7XP4wVNHcG0gmGVw57vmWLr+1L7fXJHCHGwtUsoGCqmqsMSqUnFqa91KetlXnfhU+esCpZNQ0iEeR29UBCorusfPDlocFE1Iz7WwPhDvmz9vHrVhEl1CPd9gsTo3X4BYW6r55NyiHqlarlKTglonGFhax5VuqdQld2yuAKmQW9x1aTcowg8kkUPK8iPkmlp35Z1uLCuAcxLyuwSL5o4xfyNgMtpjwV4EGoWpBKpdMeEdyjtywIVMbw+1ritkMxIPdNqAxr12yRoRQ/n3NMQwi07rWVC9BVQBx9MvmW7Hn7iZbvZZzR8JdIGNC+M5XxODqtQgPZp1l/xqDEAJEgt3roZr9N4K70q6jBu1W2Zl0F4/tey1UAJOyWsRj5sLkSdKZTfuLkBmeVDPlJmynYN2ht3sWRH3WDdf63I+qZmmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39840400004)(376002)(396003)(451199021)(54906003)(2616005)(86362001)(478600001)(6486002)(186003)(6666004)(41300700001)(66556008)(66946007)(66476007)(316002)(83380400001)(4326008)(6512007)(6506007)(6916009)(8936002)(5660300002)(8676002)(36756003)(44832011)(7416002)(7406005)(15650500001)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C9fcgBRjNoNIiDNCNf9RCi8BIC5O2obbGiSVgKRL2DB+mE6K1Gc39yUiSaSf?=
 =?us-ascii?Q?bah1TVG97y1tHm48P2EMVFUGa6urV9W77i9xdKE27KDkjY0vnFM4ADe+iJTi?=
 =?us-ascii?Q?OkEKSwup0oCYuSA0uL38mteF88+UDvRfACLKHGL/V7ZbVbePQP48GY6znCkC?=
 =?us-ascii?Q?lXJbAyBxC/SEBWDMIZMXwM5DUoYAWL/VG6ZtDxLP2PJSOkCmoQeeAzqQEOwr?=
 =?us-ascii?Q?71MLf3SfpkdBsTEsnr/FOEtAhyRrU/Tnx+sOytNGDuUy1Y3RLbsZqJOsu+XQ?=
 =?us-ascii?Q?8SNJZ9afS6ffNnHKolxoa/ehpUW+lBWnED5WA7mVZIvPyxbOdfWst5Hps+MQ?=
 =?us-ascii?Q?ZQqqnwx6gCK3E7MMmaVmhc+oiYgp24goQ6sNDouafbVr/7jbLCFvT5UAyVgd?=
 =?us-ascii?Q?QhYAuMMchCt/PtKgRWzqLIAOnh/9RPM1lXL1CAK22QI0D7VOhqxPwB6zgyn/?=
 =?us-ascii?Q?m1l/3C7IvOTCDC9VYnnnz3/BYQlvkMtR17WeFFaLpzkAAFgF521dYBtRB3of?=
 =?us-ascii?Q?MudaWEhyj/DNIoZqmDa/YOOagGJL71A68e9Hq93wKJGu1MXOtJ94FWrAgbbU?=
 =?us-ascii?Q?GiUCVcTIuXJ40DH/twZ3e8B1qGgQUz6A6puoAWoswZGv7xIllUd/fBQrhrOo?=
 =?us-ascii?Q?uWrR7hCUo++XfbgDisPBFHDh8dDYJimAmw6cTjU/OyGiDY9/Ks13IcWigjuM?=
 =?us-ascii?Q?5DG9+feGMuIQGoOmsW31gSAAVqtFyOJGS+WBSj+ii+4NPQRboocJvbwWSDnX?=
 =?us-ascii?Q?UkSvhDzQxFnA3GQK0KejyMpnzSxIUPYkTk8YWtXhWq/J3/aBY4JOCjpnmsIT?=
 =?us-ascii?Q?wAiMhbPs4Ef0Zo72o6KtRLQ3WQ4X92eJTUInkiqjz7tug9V8+bBPxH8wTy3g?=
 =?us-ascii?Q?dg5B2zwzNiA2nldArFLUssS1xaLVYz0Hi4WJ8ioVlxAToHKI+GkS8jHzxaa9?=
 =?us-ascii?Q?4jPDA4hCHyYD1c4GriX21VM2Qz90w6J7RGrkAnuk0AA2QoCK3Bpx0yiD7jFP?=
 =?us-ascii?Q?9bXIIXNZ78fiUNJJkEOycf6HaGrHkfCdkUh9rta/9v8FFaZ7HdPHQkthi+4N?=
 =?us-ascii?Q?KSRMv07HBiI5RRBdnMvwYU3b8EMJhpyN1fCLNZY9jhSFI7ekL4Pyw9+2oSO2?=
 =?us-ascii?Q?vt2P21i8g0DVKfXFv7pVHfL8iVlr47mhpRw4nICcfRCXN3r8KjEXMky9pWf5?=
 =?us-ascii?Q?vPIMxu0u15K47UJK9iSwwRlg8BuJLA513pImO3SrgYxjtsXmEUt8xLEJoper?=
 =?us-ascii?Q?LM8qbc/IeSgQfDGTn6OV9efgcXQWxQGl8YdqP7cpmm4Y31q6m8KK407Rpq+a?=
 =?us-ascii?Q?MVQoMNuPXhsTo9h6LfZajXXtYfg+AOK4Ar5kqsRCxqKrfr3R1SRwz5Eez2GO?=
 =?us-ascii?Q?IW7BwKvTvQZsgg+MwgFQCvTbL9gyx+wCkC6Xuh0H/rohx7hqmmi1y8rwcGVE?=
 =?us-ascii?Q?/r47s1bvPAY3+ZGQ8LaQR97ev585NNdbL5SWNqkhZ2yZaJCWVnCM2Mhhv00q?=
 =?us-ascii?Q?X1meNEa0rTVvZ6ko1oBA44l6gZIyovcA96yfkssCWaKky3hqEEA4/9z9NPDv?=
 =?us-ascii?Q?j8zxg925/dSpEUXjmFm057idtfOPsDLsQRONCfAO512+A30VB82/mKz4oiPH?=
 =?us-ascii?Q?rc5kOolMPTiOCfEGJPOs+nM9ZKZxeWZ1VjW/k3Lfh/fbcAuyvijTB7wPHV6b?=
 =?us-ascii?Q?zopmGw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de07cb30-429c-43b9-eee9-08db732ec830
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:41:36.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpaeZV4nqQgCq8J4Ro0YBwtXhLCx4l+LctIt6gA2W+XzrAr/2iT8vjbEuJfyWXKWS8rTanVkzqAf5FN9bG2hy8rJTINPGDZKVUU0K/ETD8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4821
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 12:19:00PM +0800, Choong Yong Liang wrote:
> From: "David E. Box" <david.e.box@linux.intel.com>
> 
> - Exports intel_pmc_core_ipc() for host access to the PMC IPC mailbox
> - Add support to use IPC command allows host to access SoC registers
> through PMC firmware that are otherwise inaccessible to the host due to
> security policies.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Chao Qin <chao.qin@intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

...

> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index da6e7206d38b..0d60763c5144 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/io.h>
> +#include <linux/intel_pmc_core.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -26,7 +27,9 @@
>  #include <asm/msr.h>
>  #include <asm/tsc.h>
>  
> -#include "core.h"
> +#define PMC_IPCS_PARAM_COUNT           7
> +
> +static const struct x86_cpu_id *pmc_cpu_id;
>  
>  /* Maximum number of modes supported by platfoms that has low power mode capability */
>  const char *pmc_lpm_modes[] = {

Hi Choong Yong Liang,

It looks like pmc_lpm_mode is used in this file and, as of this patch,
has no declaration. Should it be static?

...

> diff --git a/drivers/platform/x86/intel/pmc/core.h b/include/linux/intel_pmc_core.h
> similarity index 95%
> rename from drivers/platform/x86/intel/pmc/core.h
> rename to include/linux/intel_pmc_core.h
> index 9ca9b9746719..82810e8b92a2 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/include/linux/intel_pmc_core.h
> @@ -250,7 +250,16 @@ enum ppfear_regs {
>  #define MTL_LPM_STATUS_OFFSET			0x1700
>  #define MTL_LPM_LIVE_STATUS_OFFSET		0x175C
>  
> -extern const char *pmc_lpm_modes[];
> +#define IPC_SOC_REGISTER_ACCESS			0xAA
> +#define IPC_SOC_SUB_CMD_READ			0x00
> +#define IPC_SOC_SUB_CMD_WRITE			0x01
> +
> +struct pmc_ipc_cmd {
> +	u32 cmd;
> +	u32 sub_cmd;
> +	u32 size;
> +	u32 wbuf[4];
> +};
>  
>  struct pmc_bit_map {
>  	const char *name;

...

