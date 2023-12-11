Return-Path: <bpf+bounces-17426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1580D4EC
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B6028189E
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B324F215;
	Mon, 11 Dec 2023 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/UAY18P"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5376A93
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702317912; x=1733853912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h+thrIzg4iPE0dDqRw7lNUYBFUaKAaFNfK8OClOLdUs=;
  b=b/UAY18PYcDtXETmJCW12E+7BzEcizyKT9wMnLwsQMKmV+U8EdDXnd8P
   nV798i7uMfCYG1rrLVxtIfBrspp3YZc0LrM4J1MVRQrzoyJvOfC+o4IXZ
   58umxRoQs/HnR6heuLFUB0MLNcv7hP+cXpUNB/WQdI/KBnuyuIxCkLL6q
   x+jkGXFjnV921bpGJHnvukCovG80AXLtRPwg9TNiVql6+2e2cfIW9WMHu
   OUIgIbgTk/f12StyS7VIdBNP/Yauy3rRapzcXopIOa2kqGbY5FUWhax0/
   /MLX9ppmAayPUDbaWdbP396Dltj9VIxTM6T1/vLVYjie1kxH8W4CY1OvK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="398537915"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="398537915"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1020335679"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1020335679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 10:05:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:05:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 10:05:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 10:05:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeYxdo+vWVXvcsj4FNDPbuKemY2uXyh8EkwcmitX4w8N1h3dmUHNcBlF2iaXxcVhg4oLikZqNESVdfD2aSaVkHMLLkKMf3kwjlnmw919/CmhJHXKBYW4SZlmuKDK5uJ4D5S4jxAROeCcHWe2rJ1U2R1CuFZhQ56f3QeRnfDQkGnhV7JNk6rWlDlix9IzVCeS8os8cSOyEXd5jx/GR0uf50A1FoKRvSicCRPloojm/8ty7CadH98TNBekIFUtazB0cf3xhC3f2swhtuM6P+Vs13xISoeRhTUlLeswWYjo63vAdpqRJ3rIfro7Oi3aSnNTzZ51bfsyHJlnZwzfj0b3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8k73YgWjnpQsCZmoAVTPHbbvLCe/N/cUxPeyiAzRsk=;
 b=fkdMqDmQkKXJ2s+gxZ4wL9Bw/LYj1JqIfBFaNHLEMhrgoE/LJ4ifUghxYGBO1YZy+/FQf4awQzQcbxmpJnDjtzOWAYCSI1/M+9acrw6ucdcIULn3c6pj03Y09efK85eyrYGAgp382Z5DYMB7DllHfcGPalGoHWAe2A3W0R2jQYJqev7MlYFZ+8njFeLSSiCNUW2b7fczxTmKA5xT0XL8ciB1Y9KlMwnJ7jqph01puezALqO8QCTlTWqtw7fR2Zgim9LfvpQbAcO9uqGcvaC+guTaVxTywy64H2krQnMNM37BArqPb7sB1xBNjzALY8Tg4pah7lmQvEIAzP7aD+1QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 18:05:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 18:05:06 +0000
Date: Mon, 11 Dec 2023 19:05:01 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <jakub@cloudflare.com>, <iii@linux.ibm.com>,
	<hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 4/4] selftests/bpf: Add testcases for
 tailcall hierarchy fixing
Message-ID: <ZXdPTeij9XtxOJVe@boxer>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-5-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231011152725.95895-5-hffilwlqm@gmail.com>
X-ClientProxiedBy: DU2PR04CA0345.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0734b730-2770-4d4e-500e-08dbfa73b4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1txnTK2Gkm7xuIdK3+m8Mby5DmVg68o3jn6TNjEVibo6m/5mB0sie5cUlFbeJVawjdE+c7uJxTXN+Oxv4MDXn/43eoNtN3UpL4gCmHguKV5atRr8DzUHeCdc+3BG0nGzmpjmQkQNcvZoqI3tzW2OIraUPG+ZAl9CIhOLRYRVJBuUg6iUAbRWEttnjsu2R9oiO6aGH2toJdAA5eXpdMI8YTi21FyE6crEfiS6bGdUxobO9ZNMDcvIe5VG4kpuikC5hwTQpWDXUF9YOEShMcfiKN30boPNW/DlzHoirASKesy91kmSAM99Z3apwQ5oas9IJQSEkp/tnCrWFsbQB3Dw+XGmi4P6L02dzsMPfyufvCReDLrWy8IaH+9NOZh5vNlE1IH2U5DGWEWGw2yEsGhr5xC+cEggTa0wjBONv1D6D7oUDI4MsGOnZCt7SF2n5l6F1cbhDM3E4YPUtolsiUhSiKXj61h5ki6xFEQGBOteJED/o4CfZRCtVj5Nf7Teo5S2btIOqzbbjLnU5p06ielrWDsvdCkMxg1h+AVmlt0POvsRHX1fQECFB4QKyC0uznq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6506007)(6512007)(9686003)(6666004)(83380400001)(5660300002)(44832011)(33716001)(4326008)(2906002)(41300700001)(478600001)(8676002)(8936002)(66946007)(316002)(66556008)(6486002)(66476007)(6916009)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOuXoDTRyPLmsepMHLlpEAIHmQnEmw6Jafnk1tuBA9eOQ06G8F0WefCrgHXC?=
 =?us-ascii?Q?z9kQYz2SsfwmNCzO2H53ToZfhXKmjKdmmmwjhZTIbTo1aP0JZ/1cZKEkny3c?=
 =?us-ascii?Q?R3KRW9E8+iADLojMzbVY/MVwvSlW2ERbI9maYopduNZU/W/zdeSnOQjeSmcb?=
 =?us-ascii?Q?1A3CkGJYmhjc9c38pVgcOBDDqzHifOkbuZvH74ddGmjilok6HiTw6liEDcRn?=
 =?us-ascii?Q?hNgsF8NFs9ozWQi6uxU+rHMDJoqXxZwAss0NWrDY680tUm6FWBKEgOa7Rk5L?=
 =?us-ascii?Q?ffe0psUxTKa5AMCSv7JheWQ3Gathr4/cwTfkMtmTpgK5tPcvdKiC6NfmUgcN?=
 =?us-ascii?Q?I2bbCpGnvD9Bf3YiJ8/D0hGVDYHtW0wRQ1LuYri+9xteTOgYL40Iw4vbpvl5?=
 =?us-ascii?Q?o30ZI6sHQZHrx1wVGlfxoPSylMR2Ek6NPdUqL/4jG3zSqPfH0ysiNzDFMTUK?=
 =?us-ascii?Q?Bmryn/0uokR4vttdxzymNwD2DTLmWcstGwF9HpJw4mUvpRQPV7w8lxBBC6N3?=
 =?us-ascii?Q?CGgU6Z3AJtQik+cCxNf89JP6fsQkLSb10TRPmzR8i2K1YZPag+x5kPkSWXlM?=
 =?us-ascii?Q?rMHdjufjmtrHhpNHAb8oMff+J8/d5W89T7/hklxCV97yHVSru1+cMKhutk4V?=
 =?us-ascii?Q?d8QUm7nm/btq72nxK4JaeJm7I7SV/jl13FRerXIFAP6c4KMjKerMKxCGwJXQ?=
 =?us-ascii?Q?QYHiBrih27Hi+fZjXSt3MrmRsSSiL3X5VTzCQejGeIXklLgdSf4Rm3ebZp28?=
 =?us-ascii?Q?E/O0iQfgCNMdIOVcE6ZqTIGfW914XNTYxpuICdiEDbbiGjfQqO2LsSS3Pna5?=
 =?us-ascii?Q?Jl8A8MB5lTMG0BF2tkQFnUJ7ldST8JA/BdGgG4q9f3frQF0/dUskGBtmWQpK?=
 =?us-ascii?Q?XN5KyQGNnTtixZYx6NkUhgsMusG9rugV0E61vvJn29HFZBl4l/Vg/X4zhxBY?=
 =?us-ascii?Q?7d6GC2MWXGVTB/gLfPDit0vLFXacMPUQlFwNg9STsAANrlacSEikUF17g68H?=
 =?us-ascii?Q?897jOQEPDgjsQwwsJMbi+lXDa6+g4+c2NG5sFENI4bS6ZfUM9vST/eHoeleG?=
 =?us-ascii?Q?n9801lFZUjPENJaMAyH/iorlWvqG7gVUeY1vtTMu3f6HmUEm/rBu2m+m147R?=
 =?us-ascii?Q?yJRmWokfxtAbYCXFXY7w39zzdlw2Y8QwQURDBNW1jD76LvjKlp9110GLoM2E?=
 =?us-ascii?Q?zN8EP7F46Uu4UEUn93/WTb1KkYhFZGuqOjJbt5YDlyl+ZnWpYXAFC5ZHMkxi?=
 =?us-ascii?Q?0VnGNXn5dpahkJJIMixazjDuydUP0i0QaETtEaKiHOP9+VJH0sK51e5jm+wY?=
 =?us-ascii?Q?ltZOjO8MM6dqGPjdoJicD2YblQ1t6tzP5M2fxnFF6nX5WhPkxBjSfRWnt0Qy?=
 =?us-ascii?Q?JczukiDhP64xEJfhCgQwqMdAXFS/yugunLBkQ8iqwwhVKGn+dqbIZzCJc+8E?=
 =?us-ascii?Q?z/vWwCiKVnFvfAb6PHDbDreLdrlf15yPP9ZquHddr0PINd8gcJRpL1iOgs9W?=
 =?us-ascii?Q?wRDX+CyO1RUr3Y7S4NDtg26Zmtpmo+QlFkf5TL6n4CzjNGm0Vy1AyGkwYaMq?=
 =?us-ascii?Q?NCO0gdxsI7UQrWXuU/52blmEIvOCnXmKDxq8u+Nw7ykq6sVskUEWpwp92H9Z?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0734b730-2770-4d4e-500e-08dbfa73b4aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:05:06.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldY8X6v2Qd2IFG0Zj0EjdsHp9Ol1m2HBcodcQybfn5b/O1Q7aaF8ydTJp6RUh3NDKAHdUQTjMOwa3oiGDURgzUalgOm5f5r9bVLtiDYptnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
X-OriginatorOrg: intel.com

On Wed, Oct 11, 2023 at 11:27:25PM +0800, Leon Hwang wrote:
> Add some test cases to confirm the tailcall hierarchy issue has been fixed.
> 
> tools/testing/selftests/bpf/test_progs -t tailcalls
> 235/17  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> 235/18  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
> 235/19  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
> 235/20  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
> 235/21  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> 235/22  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> 235     tailcalls:OK
> Summary: 1/22 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++

Generally it feels like a lot of duplicated code from your previous
fentry/fexit fixes, but I didn't look closely if it would be possible to
pull out something in common.

>  .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
>  .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
>  .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
>  4 files changed, 553 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
> 

