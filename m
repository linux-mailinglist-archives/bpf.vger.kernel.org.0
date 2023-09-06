Return-Path: <bpf+bounces-9373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F27944C2
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 22:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9389D28130E
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E224311CA7;
	Wed,  6 Sep 2023 20:50:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CB6ADB
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 20:50:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB3E1BC6
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694033453; x=1725569453;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WxuvycVcyNpC7u/TeMCvIb9elG6SYij83yiBGKxx5CE=;
  b=FNJWn7GHivcJ1NbMCYdEIaSB8C0T3Ycjl2CnXeXSAwoXqVpbliYIQbWB
   BbLuBFNynj3x7KcZFNxf2la6WkBcifM7sEAI6SwpA29xx2ui+Yrf+9oq2
   X1Jb5smoVF9+Wp50hPHXjr2LDlo/EjDWJzkB8aVQvcN0xNC7NBVhTfl2L
   Jq0qbSTiVaOG1exCXmMYUZ3C/88KNKwdnfA4QzhS0nc3IWSMe9OOt5Tqk
   GVvonDAIXpntqY78yNMaCya3MFll4vCOf1Ho+ODPsbWi4tO8Bi4w0c43o
   WcJDoyo2N77aT3yho63ZKWlgXcBQLKT0FH6QIT4wOAc4rgWgx9JfzV4ZW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="379889942"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="379889942"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741714483"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="741714483"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 13:49:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 13:49:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 6 Sep 2023 13:49:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 13:49:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EemXWWVu5Qrgz7p2WEcva7sxrJEO+Sg4AgQjHhXeAcIKhqoAY4v9yJPYTzmmgw6TJ/leiL09/GrogrbpMuFyGwzNjLs+GdpLMu2HS/4ZWEu3yHJ0Z8/b81G6mKQYkZxqTgkw6faZSZwEgOow2zGO0HUpfHmls8dSofBl587PLPGFywcJwirjRj4B7dT+BTGYtNuSN8xUGF+Ry278nJLaoF65oKJd250mhseZRJ9GufGvbEKgOtbL20UzhHjK/vufF/t2Zsib9f/pcWS0BZ0qdUYrLlGt7rQUGOW1eOv4FKjYiykmKK96W0BuVP5OWoQI36p7cL6XI1HfCbqmKmNRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnq5XOHxvmC0H3hcQFFe2/mL3jMhaY9t+34PUYXd5+g=;
 b=SKIDA43y4VkcmuerfEFgD/IZ1xT4m4cleAHdNpJdSYJLI1LlSdLrzV4ASTEYpsnWoO1Zh3LPUsfSBJ57G6JOMPHJcvaIuJ9vb8W8tWgBSsIjQzoB7lyKiFQPA1OFF4peaTOElOVctWR1Pu3dNS2w+b7Z1tFkvFFfinqcWIG2MhWfPiXq+AeCBXOLumtiwyonPysqJy0jRaY2n4EMuaob58CxrHVEW97OIcZLlIkAyB+jjI9aRqOXhoqpCVJnhjfxzr1lQ9Xvj6vOmD2xHvmRSZ8oSMlHq67c/7ic44Wx6jqp5EydZ/FY7yCJOS0ckuthqt3lo8ieuqDwEMiPgcVnkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7649.namprd11.prod.outlook.com (2603:10b6:8:146::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Wed, 6 Sep 2023 20:49:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 20:49:50 +0000
Date: Wed, 6 Sep 2023 22:49:42 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <jakub@cloudflare.com>, <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Correct map_fd to data_fd in
 tailcalls
Message-ID: <ZPjl5is9OKK7Anjs@boxer>
References: <20230906154256.95461-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230906154256.95461-1-hffilwlqm@gmail.com>
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: ad57d067-3812-4b27-a151-08dbaf1ad00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yO51gfclB+WF2sOqPHsEb/ZTCbPAMldnbr2T6Dr0d+U1Ht0qxZ+R/Obxmnh5vUJkh0OZ5zOgFuQ2GL8hkLs9qGkZgw4j7NjjvDtZqb4BBiau5FoZ0YxKpsoRuxsVaPTP5hzJVmrHJcRz83RgLjgnCXXLUBxsSFBL5TMTTcTthbKNzWlV6E90ga3DBcg3AKqIJXkCFBaGEgdlpSX3x97JgCEfIFBybsSU2kSIHEBGqO0NhckTn6gtR3EUx7WxL5T7vEdQZDlKZtp+/XYWk3szcbzZcopt43yeudtuVhhreGEmiO/UP7ue8FPFaRoGAxtdfDf4f9y/dUTadn+1IdjlW/sxEA/Rla0Z1jQi2Ww2nNNqWVkbpBZnLOVzg1aAw/5K/Lcokrrx1TYXyk1UH3wwFK9xxRWN7//X98R4BjMJmkXu9/V+mC23BYHguPbYpKEAcVEIrwBpPrMRC8Mxih0jxsgj5Z9RdeW2MFrGn/QF0BSmXaLo1iA5iaiLBfpbIVqhS5TLYEPS/YovjjUkxuBAssZ7bN5nBDnmGdByrNgctlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(33716001)(6486002)(9686003)(478600001)(82960400001)(6512007)(6666004)(316002)(6916009)(66476007)(66556008)(38100700002)(66946007)(966005)(6506007)(2906002)(86362001)(83380400001)(26005)(41300700001)(5660300002)(44832011)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZautXMzXxyveX58QyhtPYqU0Ad02v2RKWgXQiv1tnHLzyi4QFiVolzqnPqXE?=
 =?us-ascii?Q?j0DLRuZSFaNhllb5caE6TxbfWWfQDResXq6tD+2d1mdphlPDazPM77QHDmsi?=
 =?us-ascii?Q?QRnrm6TIHiLu6UytDWPHBqkvmiGHVV3HF4rAmDrrUMN5Y4A5A5hnOVU2Rs6c?=
 =?us-ascii?Q?vvvqmgYDuTuNinlxfUeHQpZla3pFts+idcfiCukX8s6AK1TtA419PMwbrSOS?=
 =?us-ascii?Q?wvhrOppPZb/fCZxGy4xayuIz46z9us0fuaopWZDLellBJILr917tkzkRfbfW?=
 =?us-ascii?Q?j3miLHy7ErYfz9h5PwZiOLGtmnR5h/IpyOkWp37dDOOPuea+ceS3q2gfulEL?=
 =?us-ascii?Q?aBCGY4zkmfHWx564pd7Rx/28AbuuOM4i91OODtlSxa+2C7NvFsvgOsiLTH+g?=
 =?us-ascii?Q?RXeIGMbp7F1ZBVa2iy1Zj9GQxLM6O4OXIeceoEx/3KrWzGRSIQyN149AEm61?=
 =?us-ascii?Q?m5FvNQphvevYVfS4SZco7uDzfRT3uP5S/vSqH5hLZSwIMqPYYcvTSwDlEY6o?=
 =?us-ascii?Q?r5rzmPjtfc84lQKjIIJrZESQTITx4l/uR1m3ChcefNXykDSUhFDcg9FUds6L?=
 =?us-ascii?Q?aE5ekOEwnxhO9Mn9F2qM47ttUEk8L/+qJHcLQjZxTZvqm8O4JZjVDj79K2td?=
 =?us-ascii?Q?Re3SZy1VaYESOUY1a3/vrnfsqCu7ibnTtZ9toN1j6NuW3+dJESwfU2w8mvM7?=
 =?us-ascii?Q?ElzDDs1+xrm0QaQcwP9nnnaIYcpf1QrknWr7aZiWqdEJqWtjT5Ln/YZwUG28?=
 =?us-ascii?Q?TBqUzN+vaW3FsvRfMHNN8EdDnoHTbO3CfQ+wz0fWrvOsF+2nTyKcIkZCX9xg?=
 =?us-ascii?Q?3PARP7yJ1Jp2Wpi0+3Y28rRSY3eZUpntPJmbTmCU907Rw2X57yMn2JpvCMrc?=
 =?us-ascii?Q?fVrwGJdGdaRRlOZOEYBxNfxKVmbbi0JtoAjP5lrP25vNp+lvJVCzltBmeCyT?=
 =?us-ascii?Q?ZJv0/Netvc1AL9nSm8k+I6csxBgXvBspsc8LcNTdJvyT6QNrUw0VpPZ88NET?=
 =?us-ascii?Q?7UptQwmsQUNWNkwMAxXZnN/sS5CSEfr3YEysWpuejRobzXJORqC7ywQn9sdf?=
 =?us-ascii?Q?5FvnNYdyaBhop+G9bFOorblCbutptopH/LutR4R410lDKLH9ch3rxMWkUn8i?=
 =?us-ascii?Q?eIGrtb9/wPcuL1wpiNAOzqEbrPRAL6aEtTgY1p9uQ95VshTuazsUPdu+a1dp?=
 =?us-ascii?Q?ejhySy0DZZPsgakqfpQqVTOgMPGkztYZU0keSGy0rBzHBrSXMkxRNg49ZR+6?=
 =?us-ascii?Q?E+tbTIw0FUSFZTx/fO40UsvDYELkUlU6LZ3bh8V1a13LRe6/bjx5djT/jqZC?=
 =?us-ascii?Q?ROBtkhBv1t0puij3p7TN9QH92pcQL+JfmSJnPYJUbpBSraB0jAhrIS+agxlY?=
 =?us-ascii?Q?UDjbqJ+uDR183Cc/kWjxbQe6yVJyQgwCErHQ018Bqo9jL6liKC578/aILsRX?=
 =?us-ascii?Q?VxSRrKt0DoMzEWbBbsS9oBBqxAUO7IiQnk9QN74wtg9mDFzcUkn34oHaQqGm?=
 =?us-ascii?Q?Q+etr0Uh0stgQAcuOiUjxV1R9FcmApe7+Q2g3mbZ4hinYSXlymnEdpQG75P/?=
 =?us-ascii?Q?8fudXotfJAV090phIHAAA/cWnHMgDrkjy7uGVE1TTKGoJXQzzbxNVRrpOUzS?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad57d067-3812-4b27-a151-08dbaf1ad00c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:49:49.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRaV+7JCjwQkvAvfwj2JTaEIvc6ZDVpdvrmz27GCA8LFM9w5Ovwwo9RP7SM19kMsG4Slvt1KQj2a9vQl9nds0tprupA+p/mZeHrWnkvNQd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7649
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 11:42:56PM +0800, Leon Hwang wrote:
> Get and check data_fd. It should not check map_fd again.
> 
> Meanwhile, correct some 'return' to 'goto out'.
> 
> Thank the suggestion from Maciej in "bpf, x64: Fix tailcall infinite
> loop"[0] discussions.
> 
> [0] https://lore.kernel.org/bpf/e496aef8-1f80-0f8e-dcdd-25a8c300319a@gmail.com/T/#m7d3b601066ba66400d436b7e7579b2df4a101033

in the subject of the patch you should have 'bpf', not 'bpf-next'.

Fix this and send v2 please. You can also include my:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> Fixes: 79d49ba048ec ("bpf, testing: Add various tail call test cases")
> Fixes: 3b0379111197 ("selftests/bpf: Add tailcall_bpf2bpf tests")
> Fixes: 5e0b0a4c52d3 ("selftests/bpf: Test tail call counting with bpf2bpf and data on stack")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/tailcalls.c      | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index 58fe2c586ed76..09c189761926c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -271,11 +271,11 @@ static void test_tailcall_count(const char *which)
>  
>  	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
>  	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
> -		return;
> +		goto out;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> -		return;
> +	if (CHECK_FAIL(data_fd < 0))
> +		goto out;
>  
>  	i = 0;
>  	err = bpf_map_lookup_elem(data_fd, &i, &val);
> @@ -352,11 +352,11 @@ static void test_tailcall_4(void)
>  
>  	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
>  	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
> -		return;
> +		goto out;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> -		return;
> +	if (CHECK_FAIL(data_fd < 0))
> +		goto out;
>  
>  	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
>  		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
> @@ -442,11 +442,11 @@ static void test_tailcall_5(void)
>  
>  	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
>  	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
> -		return;
> +		goto out;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> -		return;
> +	if (CHECK_FAIL(data_fd < 0))
> +		goto out;
>  
>  	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
>  		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
> @@ -631,11 +631,11 @@ static void test_tailcall_bpf2bpf_2(void)
>  
>  	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
>  	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
> -		return;
> +		goto out;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> -		return;
> +	if (CHECK_FAIL(data_fd < 0))
> +		goto out;
>  
>  	i = 0;
>  	err = bpf_map_lookup_elem(data_fd, &i, &val);
> @@ -805,11 +805,11 @@ static void test_tailcall_bpf2bpf_4(bool noise)
>  
>  	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
>  	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
> -		return;
> +		goto out;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> -		return;
> +	if (CHECK_FAIL(data_fd < 0))
> +		goto out;
>  
>  	i = 0;
>  	val.noise = noise;
> @@ -872,7 +872,7 @@ static void test_tailcall_bpf2bpf_6(void)
>  	ASSERT_EQ(topts.retval, 0, "tailcall retval");
>  
>  	data_fd = bpf_map__fd(obj->maps.bss);
> -	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
> +	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
>  		goto out;
>  
>  	i = 0;
> 
> base-commit: 05ae0b55e72dca3e22598c7f231b86b6c3b69d83
> -- 
> 2.41.0
> 

