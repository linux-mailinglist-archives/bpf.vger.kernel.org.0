Return-Path: <bpf+bounces-9376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31384794504
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F75D1C20A16
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998DB11CB9;
	Wed,  6 Sep 2023 21:18:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78F2FB3
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 21:18:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB12E6F
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694035119; x=1725571119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wN0CEA+/ZIMXTw7Uj6IYwkuAjEL2aqdNN2S2SDVIEAw=;
  b=X6E30uUlMK1hq70zXwaIuAglZdkzPfBmXiFTxAUq6iPg4FwsHwy0D09p
   saNblJJSlQifWd5i4maSG0zo5oJi7OhnlGQowhJGZw782KQ/mKG2y26MD
   7tYQJj9IOH6QL9nGbEajo4cYcpedv0wEj+lgs0h8ufFj5Jjp49gQsJWZs
   6GmCWaABNxl28pcRzDJADNSe73hmf7MfvtvGMkaF5iyhIsv+5AN2XV2ed
   UpmNRAPGXlh6SB+OCmDgI5mvD8IFqNsCV0AksFqOFGVrlGDIPei5ch4rm
   df9c3Z01DlwuMgjVausCNr/4myl49oH/LyXQ6RqLDvsiE0zQ/mV5bQdjC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="374580818"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="374580818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 14:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="865315619"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="865315619"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 14:18:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 14:18:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 14:18:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 14:18:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxwl70OSA0Bk9/i8Q0gHeofODgHRaAmXbKEfbl7g2chaxPkoMum2uLcdLJJfiUP5SmxkLscC+MFqwVGiNkbOSphmUtG6vnbcDY6ttoezCCtfux3NUwFsrnbrrQWXtB7dn42NhHjWgzJ3cs6pCs0plocx9gJ0kZdYnMYG1V0Er2dR8I3GRBlRqRvLG8rmJ9RjM9zvUgMxcVU0wWyyQGS2ln/fzvbCctXv7CVpPFZf/caUwjLXyGe0+4QWCyb0GcLgcdnybDYWLsBlQRrWWvh0VP4OZHzzT9qJcFxLwpkNPXNQk+NDRkvyXPR5YFESZSyqxlfU7/a8FLXK6Ajsg0+eYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge5ZKx0lSFPzkABhLXfker2BesDwI1oh/DCirolMPxk=;
 b=k/nTxqUc3jVM+J4Mx2euysg8cjaCc21meZNpQN0MbIJ/K0/0gZbCv34Nr1ufliWBHobuYDDVFL8Qb1WPaN7UG6VkVWAb2Sf06jS8whxWTFT049cC/KQg7gQDubRIOCi8a9M4YIohl/3N5y6WMQkDHOM271EFvUKq75NHv9VYxCaTCC2XOVcMYDHnUl+KzCMpVGoYcqvRLpmZE2EU/oLk4v50CxMhSATR+5t++UtJZ46HQ1SgDdE0gSaGxb0PO3J5Ai6rFTS67dyqks0g4mRE9AGu82G7JUWDNeGnAaxzanz825UAJdIA4wktlHQEFbCDA/MYbVAj6wiWi6FVn/Vs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN6PR11MB8243.namprd11.prod.outlook.com (2603:10b6:208:46e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 21:18:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:18:34 +0000
Date: Wed, 6 Sep 2023 23:18:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<song@kernel.org>, <iii@linux.ibm.com>, <jakub@cloudflare.com>,
	<bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next v4 4/4] selftests/bpf: Add testcases for
 tailcall infinite loop fixing
Message-ID: <ZPjsnjoS/nh7aMcF@boxer>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <20230903151448.61696-5-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230903151448.61696-5-hffilwlqm@gmail.com>
X-ClientProxiedBy: FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN6PR11MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 6693abba-2e89-448b-634c-08dbaf1ed3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGmiKUOjrJ7FYoh9pb/zQvCeHY6PxBEL1HPLDeOpyqaMqg0yOd17dSsgBnp5hEty+JYhkQBgD/ww8Er5dJTNpACmsGC5j5cc0Ihyl0QFWOqodwjLP9LCG3DHsfG6UZljCZHNxC0/sE3V/7BD96+jJuzH766J9WxSQ2Tx4NBqigg/tKUEswNGn9cmpFEaerbZo4vjdlhQ6urGWv1aS5uY8EmXS0yfFQnQX9PwGh5+kZOOcOipm0a9zrlqEQOQ8HQ/0leFBpgSSsfk6gk84vUOxG8m5QnwlbRDTvnE++0DLe2nXlldH19HMlG6x+kVs6r2s7yN8qxLnVRHwWwRBnYKV4B3P29CJokSv1i6em6s0MYeCPSQugmbx+ZqKW/si1ccm7jEXTp9FBIT7TyBqNsHc0VbKR+Zu0/zKogSiopRJ1pgzRp2ZUMr214nffcTo7pSmCLroO15aOXywzitULShgizblfayIn4LhrdytCJTJbdcphf4/EeQU/jFQ7b9uUM42Gan1OF+SXGzES7uBuMySqlOoW7bl0fnno+PWvNHemwOGDSEC3TXgyCu2GrIiArJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(396003)(346002)(39860400002)(1800799009)(451199024)(186009)(6486002)(6506007)(6512007)(478600001)(9686003)(41300700001)(66476007)(66946007)(66556008)(6916009)(6666004)(316002)(44832011)(26005)(5660300002)(33716001)(8936002)(8676002)(4326008)(86362001)(83380400001)(30864003)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Sr8wlTCP9WrkaYfHe4Z57dGBC1CrHcr9iMEZRW6Vb7GA5bS+XvrklQ+m/+c?=
 =?us-ascii?Q?fi3iwJLZJsN71Ga69rb9zBxEBfMFM9oCouRE7OtRDqYDvStHxMnjH1aqsPWc?=
 =?us-ascii?Q?NBfnnSoEwB/So2+ZVUVuThQjnhaXIwvdRK1p8k1eLDHzEmg3momjHwBBJrB/?=
 =?us-ascii?Q?M90aniqm7LcSsoTeEQk9XHoMzVCwL+r9xKK0rKjKwR9YRuYBBEfGPrSrGCvD?=
 =?us-ascii?Q?2O2FCIGGafPT6aT1bh7Z35OYmJREPNH9R1a0+uLojU1ZB85PzeBsO+oAZ5VI?=
 =?us-ascii?Q?XyP5isXUqQSScMnuJgYwaiTU4/gXMpXBSlqyC55NfGXzxjjvkMUJSvTZ4EWg?=
 =?us-ascii?Q?gLhMtYqGarBZAqKgBMYKaFOLGAzLt4GeXVxymNDSOd3aBOC+C3MlzIs0CRQP?=
 =?us-ascii?Q?gaKnnuerW3QApcmfNuDucaVDQ/CQb/9EvsaCQG87yg1JWluEa4aEIWsjakAh?=
 =?us-ascii?Q?EPgaVdSuXxAtuqFZwycHG1+8x+MzlOnRw8re4iQWepivpdBsMMy3N0bo+L9R?=
 =?us-ascii?Q?TLT02+L73XF9D6tDdHwlMWAb3wloNxnsFEqMw7fV8Og89NWrykf/+SJMteoS?=
 =?us-ascii?Q?zZM6kN83x8N5wQqBmwj7S9ecyVnsPGNBPuqroccQVABnEy3ItsTEHBiO4Bxd?=
 =?us-ascii?Q?cxjOx+B6Zj/C5x1G4m/U1L3mc8N8420b8kpdXGNagDhb9Ae50pI/uUOK9igG?=
 =?us-ascii?Q?X6cbICpcsKeLBzncma4PhHqh+/CWYHC238W079LhaQwkENsQg4WhsBvq/k49?=
 =?us-ascii?Q?czXcF13xFldJzigaH9JjO4EahY9L2HY1ax42qS+XQe6aji5fmLAoHE9+tvGb?=
 =?us-ascii?Q?A+oxl3foO8JHbH/tff6WjRldgJgwz9jEKL0BoTdMKQEMRS3UWjw7K/QM0vJt?=
 =?us-ascii?Q?66THoIfkYOgBnb/RrNqs4b71W/lPy2W2tuZH2d53/nzXfsq5Bsv6P+QKezY7?=
 =?us-ascii?Q?ahT78PD3R9/K3HU/612rbUaFRpMf2n5FnOxNbFRvUP2Lpp+i6OWYk0wSSn82?=
 =?us-ascii?Q?ak3Dp1sqd7scuY11XAd5NFeka1yrrNYc234820fRfJdwFptnaLu8bMgwlBIr?=
 =?us-ascii?Q?jVMvtjXDHJJAWWyb98oGK9yKcz0gzpaa5AbP1tkb2UcEs+IRGWR7xNLjfbTJ?=
 =?us-ascii?Q?BE1i3wNSs9VDY80+AMpnPvU9pzCAbwfdaCztRrnfAbu5w4SQx7PcqD6XV4os?=
 =?us-ascii?Q?OsHkLteFgJerOe/7M8SexrjhHzXMFAASXKXSzWYzWNGn0UHXfisZL4iqH0Sr?=
 =?us-ascii?Q?3CZjhMUAge72HO0naIDrpglGgw4ccjJMUPio/Ip0hkjyUojcTIoc1staHMvi?=
 =?us-ascii?Q?Ktn7RwZ08q9qMAUQdtFwv2qQMJ7Gcf1g7updg+qERjzyUjbb9vIwe76Z+xA8?=
 =?us-ascii?Q?T5lUKzXCnrSX5U6WvypjmERVl57K3S92aypZuQJVTL/8jUEQNF3q6TJRWDQN?=
 =?us-ascii?Q?qpmPM6OSbD1VkDKdsC87As9XxrDWgz3CysOu7jpFhRIIJRW/ycaOMlbgaUmK?=
 =?us-ascii?Q?C4xEe1BKxqScQIHsI1IRR2FkG/zA+rHIoeOg+MAh7gwkf+0hrSqInq3hf5Uv?=
 =?us-ascii?Q?6vRjGxuwDh5KRWLOBkwCVmCOzKXQlqUFnnAK2oC3YckmNZUs0Na6HMlMVH2i?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6693abba-2e89-448b-634c-08dbaf1ed3ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:18:34.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMYsKlXEMsw7UUrN9LaSZnC40p+WT9wCWYoKyboZFU8NMtxt+T9m8rA1G5CVZG1rmID3+JO9nDiCplXBkkGdWJHjpwndlJPn9s7kDT7/PXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 03, 2023 at 11:14:48PM +0800, Leon Hwang wrote:
> Add 4 test cases to confirm the tailcall infinite loop bug has been fixed.
> 
> Like tailcall_bpf2bpf cases, do fentry/fexit on the bpf2bpf, and then
> check the final count result.
> 
> tools/testing/selftests/bpf/test_progs -t tailcalls
> 226/13  tailcalls/tailcall_bpf2bpf_fentry:OK
> 226/14  tailcalls/tailcall_bpf2bpf_fexit:OK
> 226/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
> 226/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
> 226     tailcalls:OK
> Summary: 1/16 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/tailcalls.c      | 299 ++++++++++++++++++
>  .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
>  .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
>  3 files changed, 335 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index b20d7f77a5bce..331b4e455ad06 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -884,6 +884,297 @@ static void test_tailcall_bpf2bpf_6(void)
>  	tailcall_bpf2bpf6__destroy(obj);
>  }
>  
> +static void tailcall_bpf2bpf_fentry_fexit(bool test_fentry, bool test_fexit)
> +{
> +	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL, *fexit_obj = NULL;
> +	struct bpf_link *fentry_link = NULL, *fexit_link = NULL;
> +	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
> +	struct bpf_map *prog_array, *data_map;
> +	struct bpf_program *prog;
> +	char buff[128] = {};
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in = buff,
> +		.data_size_in = sizeof(buff),
> +		.repeat = 1,
> +	);
> +
> +	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o",
> +				 BPF_PROG_TYPE_SCHED_CLS,
> +				 &tgt_obj, &prog_fd);
> +	if (!ASSERT_OK(err, "load tgt_obj"))
> +		return;
> +
> +	prog = bpf_object__find_program_by_name(tgt_obj, "entry");
> +	if (!ASSERT_OK_PTR(prog, "find entry prog"))
> +		goto out;
> +
> +	main_fd = bpf_program__fd(prog);
> +	if (!ASSERT_FALSE(main_fd < 0, "find entry prog fd"))
> +		goto out;
> +
> +	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
> +	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
> +		goto out;
> +
> +	map_fd = bpf_map__fd(prog_array);
> +	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
> +		goto out;
> +
> +	prog = bpf_object__find_program_by_name(tgt_obj, "classifier_0");
> +	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(prog);
> +	if (!ASSERT_FALSE(prog_fd < 0, "find classifier_0 prog fd"))
> +		goto out;
> +
> +	i = 0;
> +	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
> +	if (!ASSERT_OK(err, "update jmp_table"))
> +		goto out;
> +
> +	if (test_fentry) {
> +		fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_fentry.bpf.o",
> +						   NULL);
> +		if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
> +			goto out;
> +
> +		prog = bpf_object__find_program_by_name(fentry_obj, "fentry");
> +		if (!ASSERT_OK_PTR(prog, "find fentry prog"))
> +			goto out;
> +
> +		err = bpf_program__set_attach_target(prog, prog_fd,
> +						     "subprog_tail");
> +		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
> +			goto out;
> +
> +		err = bpf_object__load(fentry_obj);
> +		if (!ASSERT_OK(err, "load fentry_obj"))
> +			goto out;
> +
> +		fentry_link = bpf_program__attach_trace(prog);
> +		if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
> +			goto out;
> +	}
> +
> +	if (test_fexit) {
> +		fexit_obj = bpf_object__open_file("tailcall_bpf2bpf_fexit.bpf.o",
> +						  NULL);
> +		if (!ASSERT_OK_PTR(fexit_obj, "open fexit_obj file"))
> +			goto out;
> +
> +		prog = bpf_object__find_program_by_name(fexit_obj, "fexit");
> +		if (!ASSERT_OK_PTR(prog, "find fexit prog"))
> +			goto out;
> +
> +		err = bpf_program__set_attach_target(prog, prog_fd,
> +						     "subprog_tail");
> +		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
> +			goto out;
> +
> +		err = bpf_object__load(fexit_obj);
> +		if (!ASSERT_OK(err, "load fexit_obj"))
> +			goto out;
> +
> +		fexit_link = bpf_program__attach_trace(prog);
> +		if (!ASSERT_OK_PTR(fexit_link, "attach_trace"))
> +			goto out;
> +	}
> +
> +	err = bpf_prog_test_run_opts(main_fd, &topts);
> +	ASSERT_OK(err, "tailcall");
> +	ASSERT_EQ(topts.retval, 1, "tailcall retval");
> +
> +	data_map = bpf_object__find_map_by_name(tgt_obj, "tailcall.bss");
> +	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
> +			  "find tailcall.bss map"))
> +		goto out;
> +
> +	data_fd = bpf_map__fd(data_map);
> +	if (!ASSERT_FALSE(data_fd < 0, "find tailcall.bss map fd"))
> +		goto out;
> +
> +	i = 0;
> +	err = bpf_map_lookup_elem(data_fd, &i, &val);
> +	ASSERT_OK(err, "tailcall count");
> +	ASSERT_EQ(val, 33, "tailcall count");
> +
> +	if (test_fentry) {
> +		data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
> +		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
> +				  "find tailcall_bpf2bpf_fentry.bss map"))
> +			goto out;
> +
> +		data_fd = bpf_map__fd(data_map);
> +		if (!ASSERT_FALSE(data_fd < 0,
> +				  "find tailcall_bpf2bpf_fentry.bss map fd"))
> +			goto out;
> +
> +		i = 0;
> +		err = bpf_map_lookup_elem(data_fd, &i, &val);
> +		ASSERT_OK(err, "fentry count");
> +		ASSERT_EQ(val, 33, "fentry count");
> +	}
> +
> +	if (test_fexit) {
> +		data_map = bpf_object__find_map_by_name(fexit_obj, ".bss");
> +		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
> +				  "find tailcall_bpf2bpf_fexit.bss map"))
> +			goto out;
> +
> +		data_fd = bpf_map__fd(data_map);
> +		if (!ASSERT_FALSE(data_fd < 0,
> +				  "find tailcall_bpf2bpf_fexit.bss map fd"))
> +			goto out;
> +
> +		i = 0;
> +		err = bpf_map_lookup_elem(data_fd, &i, &val);
> +		ASSERT_OK(err, "fexit count");
> +		ASSERT_EQ(val, 33, "fexit count");
> +	}
> +
> +out:
> +	bpf_link__destroy(fentry_link);
> +	bpf_link__destroy(fexit_link);
> +	bpf_object__close(fentry_obj);
> +	bpf_object__close(fexit_obj);
> +	bpf_object__close(tgt_obj);
> +}
> +
> +/* test_tailcall_bpf2bpf_fentry checks that the count value of the tail call
> + * limit enforcement matches with expectations when tailcall is preceded with
> + * bpf2bpf call, and the bpf2bpf call is traced by fentry.
> + */
> +static void test_tailcall_bpf2bpf_fentry(void)
> +{
> +	tailcall_bpf2bpf_fentry_fexit(true, false);
> +}
> +
> +/* test_tailcall_bpf2bpf_fexit checks that the count value of the tail call
> + * limit enforcement matches with expectations when tailcall is preceded with
> + * bpf2bpf call, and the bpf2bpf call is traced by fexit.
> + */
> +static void test_tailcall_bpf2bpf_fexit(void)
> +{
> +	tailcall_bpf2bpf_fentry_fexit(false, true);
> +}
> +
> +/* test_tailcall_bpf2bpf_fentry_fexit checks that the count value of the tail
> + * call limit enforcement matches with expectations when tailcall is preceded
> + * with bpf2bpf call, and the bpf2bpf call is traced by both fentry and fexit.
> + */
> +static void test_tailcall_bpf2bpf_fentry_fexit(void)
> +{
> +	tailcall_bpf2bpf_fentry_fexit(true, true);

Would it be possible to modify existing test_tailcall_count() to have
fentry/fexit testing within? __tailcall_bpf2bpf_fentry_fexit() basically
repeats the logic of test_tailcall_count(), right?

How about something like:

static void test_tailcall_bpf2bpf_fentry(void)
{
	test_tailcall_count("tailcall_bpf2bpf2.bpf.o", true, false);
}

// rest of your test cases

and existing tailcall count tests:

static void test_tailcall_3(void)
{
	test_tailcall_count("tailcall3.bpf.o", false, false);
}

static void test_tailcall_6(void)
{
	test_tailcall_count("tailcall6.bpf.o", false, false);
}

> +}
> +
> +/* test_tailcall_bpf2bpf_fentry_entry checks that the count value of the tail
> + * call limit enforcement matches with expectations when tailcall is preceded
> + * with bpf2bpf call, and the bpf2bpf caller is traced by fentry.
> + */
> +static void test_tailcall_bpf2bpf_fentry_entry(void)
> +{
> +	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL;
> +	int err, map_fd, prog_fd, data_fd, i, val;
> +	struct bpf_map *prog_array, *data_map;
> +	struct bpf_link *fentry_link = NULL;
> +	struct bpf_program *prog;
> +	char buff[128] = {};
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in = buff,
> +		.data_size_in = sizeof(buff),
> +		.repeat = 1,
> +	);
> +
> +	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o",
> +				 BPF_PROG_TYPE_SCHED_CLS,
> +				 &tgt_obj, &prog_fd);
> +	if (!ASSERT_OK(err, "load tgt_obj"))
> +		return;
> +
> +	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
> +	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
> +		goto out;
> +
> +	map_fd = bpf_map__fd(prog_array);
> +	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
> +		goto out;
> +
> +	prog = bpf_object__find_program_by_name(tgt_obj, "classifier_0");
> +	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(prog);
> +	if (!ASSERT_FALSE(prog_fd < 0, "find classifier_0 prog fd"))
> +		goto out;
> +
> +	i = 0;
> +	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
> +	if (!ASSERT_OK(err, "update jmp_table"))
> +		goto out;
> +
> +	fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_fentry.bpf.o",
> +					   NULL);
> +	if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
> +		goto out;
> +
> +	prog = bpf_object__find_program_by_name(fentry_obj, "fentry");
> +	if (!ASSERT_OK_PTR(prog, "find fentry prog"))
> +		goto out;
> +
> +	err = bpf_program__set_attach_target(prog, prog_fd, "classifier_0");
> +	if (!ASSERT_OK(err, "set_attach_target classifier_0"))
> +		goto out;
> +
> +	err = bpf_object__load(fentry_obj);
> +	if (!ASSERT_OK(err, "load fentry_obj"))
> +		goto out;
> +
> +	fentry_link = bpf_program__attach_trace(prog);
> +	if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
> +		goto out;
> +
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "tailcall");
> +	ASSERT_EQ(topts.retval, 1, "tailcall retval");
> +
> +	data_map = bpf_object__find_map_by_name(tgt_obj, "tailcall.bss");
> +	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
> +			  "find tailcall.bss map"))
> +		goto out;
> +
> +	data_fd = bpf_map__fd(data_map);
> +	if (!ASSERT_FALSE(data_fd < 0, "find tailcall.bss map fd"))
> +		goto out;
> +
> +	i = 0;
> +	err = bpf_map_lookup_elem(data_fd, &i, &val);
> +	ASSERT_OK(err, "tailcall count");
> +	ASSERT_EQ(val, 34, "tailcall count");
> +
> +	data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
> +	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
> +			  "find tailcall_bpf2bpf_fentry.bss map"))
> +		goto out;
> +
> +	data_fd = bpf_map__fd(data_map);
> +	if (!ASSERT_FALSE(data_fd < 0,
> +			  "find tailcall_bpf2bpf_fentry.bss map fd"))
> +		goto out;
> +
> +	i = 0;
> +	err = bpf_map_lookup_elem(data_fd, &i, &val);
> +	ASSERT_OK(err, "fentry count");
> +	ASSERT_EQ(val, 1, "fentry count");
> +
> +out:
> +	bpf_link__destroy(fentry_link);
> +	bpf_object__close(fentry_obj);
> +	bpf_object__close(tgt_obj);
> +}
> +
>  void test_tailcalls(void)
>  {
>  	if (test__start_subtest("tailcall_1"))
> @@ -910,4 +1201,12 @@ void test_tailcalls(void)
>  		test_tailcall_bpf2bpf_4(true);
>  	if (test__start_subtest("tailcall_bpf2bpf_6"))
>  		test_tailcall_bpf2bpf_6();
> +	if (test__start_subtest("tailcall_bpf2bpf_fentry"))
> +		test_tailcall_bpf2bpf_fentry();
> +	if (test__start_subtest("tailcall_bpf2bpf_fexit"))
> +		test_tailcall_bpf2bpf_fexit();
> +	if (test__start_subtest("tailcall_bpf2bpf_fentry_fexit"))
> +		test_tailcall_bpf2bpf_fentry_fexit();
> +	if (test__start_subtest("tailcall_bpf2bpf_fentry_entry"))
> +		test_tailcall_bpf2bpf_fentry_entry();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
> new file mode 100644
> index 0000000000000..8436c6729167c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright Leon Hwang */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +int count = 0;
> +
> +SEC("fentry/subprog_tail")
> +int BPF_PROG(fentry, struct sk_buff *skb)
> +{
> +	count++;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
> new file mode 100644
> index 0000000000000..fe16412c6e6e9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright Leon Hwang */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +int count = 0;
> +
> +SEC("fexit/subprog_tail")
> +int BPF_PROG(fexit, struct sk_buff *skb)
> +{
> +	count++;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.41.0
> 

