Return-Path: <bpf+bounces-3470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3384F73E5F1
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F6C280E53
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAF911CB0;
	Mon, 26 Jun 2023 17:02:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF829448
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 17:02:48 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93580E75
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 10:02:47 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35QAXk0Y026685;
	Mon, 26 Jun 2023 10:02:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2tmnUgiGPHYyDtLwV7nO4SfjXkP4TeVs1X1+RVMjgw0=;
 b=C8LEoMGPeKAHD6S556WpwBuGxxTegY7VyX3MOeoAeWuk+gS+S/FETH6G/onMEH214WbD
 vw6NTVFDc+cxfhiwGldLbDO2/SKcaGlFl8JzqeIF6wx7vsE1CGrEDdbndvtZDFRdTVrg
 +ej4M4f1igX9U+FDQzQjdCtdHBW1VRPs5pYjyci3jN1V0lIQLOkMOjsbApnHjTuw6EiW
 3mmtQvKofFRcPe+HCXcFbZJR+HCCnf6ITPOIpw8aDLsds2jZIu7p+dQlKOJWtVQHEjmB
 ghNrjPtk2O8e3IptEdyx8p3oCk5exXuknuFM/IvFHLP2ducN0NQMgeMnz/csgZjZQeYY ZA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
	by m0001303.ppops.net (PPS) with ESMTPS id 3rf0dppp3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jun 2023 10:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9kGMGO1TOZLS+8IPQmeilEuK+emk3beid/jnOLApVjrxABMmOwXxjsO2pzzGtXAs4/BZbxtWkrGnVtLKEfs0AvC+uE49g+qzk0ejrBAsR7+GKr33098rzq6d4AtdMIuPb3ZtUZMajixavUAZi6fjKIDGqRwQuuT5+1wBY9BiTYsoAAVjGDLqEtKxtYRQAArXeci8Pqd9+0OE9KteDX6czHoMmNeiUsn3k1G7+UDvwcKNRBhD1Egfv5Bc59ncy4Kl3xIWKQc153yjujdx4jSGlCIhFpuUUMhVBhMxqD/a5PMGZxMWxogsypjr7f8qm4knUfQT2JYN7LTNDxQqmfu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tmnUgiGPHYyDtLwV7nO4SfjXkP4TeVs1X1+RVMjgw0=;
 b=TTFVZR09TnEv1a6M0ud3obS2blyjhX/hDU0LzoMg239yshvDdmZw58pbFKh/6e48bOnTnctf0rSG62vZv/JzAIwgmlQkDUZxZNgb/2M0M3EQl2gKrOo+KZoD3UgIORfVfbq9pmP7ffprTa5sh6lNjLS5J98j/SuzjGlSIt4xqBv8yR8XLY6MbXZQVK5aOkmAoI/rQ7XHW8ZJ1zGUeyLnes6FgiFhD2uailMQ8QYM9+Z6EBwBz7m+Z9XuFN5I1CYjbgFQYpqYqX83O1fUC6rHV/XRJlQkBMl7bRrip3ZD4kvDrbhS53xqdHGk3ycP4Myu0IAb/sMWT/2IN/uGpst+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5165.namprd15.prod.outlook.com (2603:10b6:510:14a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 17:02:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 17:02:43 +0000
Message-ID: <9a949539-8eb8-35b3-3d3f-f84e2f11da81@meta.com>
Date: Mon, 26 Jun 2023 10:02:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] libbpf: provide num present cpus
To: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>,
        bpf@vger.kernel.org
References: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa926fc-f694-439e-84d1-08db7667288a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jZ0nP0s4T9KrSYyQIovCPoJE0zC4cL/Rc0n0VPR5rCZLBUMyEIg3X+NHjdAAh9aXmkYqN5dX8x6l28p2PcfhYaWdMXEMj/V1hcqxFGeur4vnz8cE+8PgYKSd5yoVyPNn+vI4j4C9mdeqoGD7sqiUBBDYhVBG0qpllu9rW55cxiS/PeChAAXgiO79qXRTffTdZDOtL9sBxzW9y6SmMeAKgSkzAVQ7RxHEGtA8lMw56f02pNrEBl5kCgGWvj+b+qbT6xm3wKOtI/roxUQoCTJxUI9n+Mrh3SbgsN21eF72e/R7B0UtJAER4aMO9F45V6NBQ5T8l/v9dADru1qiSJHtTb9qGbDP5xLk/8/OYF3laI/0vwyIJwiFGcSbChVXrq6WOBITEbarrcwsCTp0c/NKZU5AlOH7SMTnJMf335CG/qpQPi7H/6WrZoTzUyvfRPpBBdKcWYN6Jb+/JnaM/5vpFgBB1+QGLFzOikPBpKqrlWCeVqTUg2mTB4rY2sRV3n9ENszh1wKyueqiw5ywODAiV6KGk6K+T/Hpr8UMRl469SjiASkMg77VYeehFgaPeU1BQbPC2rbJ8zcl+RT00iG1Ih138fc6pQ/TXUFTVJ4S5K1EBg7CRHo9C4Lk6rAkUvkygeVqwB1z6MypSDQv8ZjIdA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(31686004)(5660300002)(66946007)(66556008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(966005)(31696002)(86362001)(41300700001)(6486002)(186003)(53546011)(6512007)(6506007)(38100700002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGdnOG1ralhKR0RNZzE3WVdrUVZkRGZCTm51Mk1HQys0MUE5TlZGNVl6SmE3?=
 =?utf-8?B?R2laY2Z3SFJaQi9nVW5hNENVWGRxaWFHK3p5WUdnQ2pwUjBVMWNQWERsS0k2?=
 =?utf-8?B?ckZSaVlRY3gvdU5rY21SMGd5LzUxdjBDQU1ReFlYRExKNC9QcTBDMmdoaDBm?=
 =?utf-8?B?aUVINGg2L00rUys5U0crWTJnQUxXSVU3R0poM3Z4YnV5Z296Njl4aEhhYm1Y?=
 =?utf-8?B?Ukd1bVNPZGtGaUJUMFBXZWsvRlZFVXNoaWVONkNWZ3o0Zm11SXBBVmtaMmp4?=
 =?utf-8?B?YURScEoyazRvTjhMYnV0ZW5sS1kwWEwveWhnUkI4djdXT1JHcFNUR3hWYlNC?=
 =?utf-8?B?YlBvZnhBVlJTampLOXJQVVNJZDVKQmw3OUYwU0JmWTByLzlWdGtETS9aK3JO?=
 =?utf-8?B?V0Z5SmYwQ1kwOVhyWVpMcWJYVGJabUcxYk9IRHVLL05IRmI3VkpVanQ4Zy83?=
 =?utf-8?B?R2w4WWF4ZFRtY3BCd2haOCtPMG1Dc1RWeTZ6dkVoN2NFc056d2JPWHRKRWxN?=
 =?utf-8?B?bDFtbDF6VXRtSU1YMGNySVBDQ1Bpb0lmMmlydUlvTkVuOHJHQjJ2ck5nRkl2?=
 =?utf-8?B?TEFzZUhEMW1ZWnJpV1hWd2s0RkNFOSs2L3o1ckl3dlM2bWRCdzBsZWxXNktI?=
 =?utf-8?B?U0wzN0ViRTE2bmJBd1M3cU1wT0JOVTZzZFBEcEwzbS9WclAzcVVBL2U0bU1o?=
 =?utf-8?B?NzNGSTBEcC9mREhOQ0tST0U5NVdISGd2ZTc0cXZTaDdZczUyMFUvK3c2OTFl?=
 =?utf-8?B?WU9lSzJvdVptMHdKSUt2cUMwOVZnVW1zQ1NRb092Y2k0dFFSYndKaGhOQ0hj?=
 =?utf-8?B?R0Fva2FhcUFTQ2VXNkFodk92WndwdGtxbWJScWhKbThaRDBBVnJjRkd3Qkdn?=
 =?utf-8?B?L3R0YW1yWXkxbW9VYi9xd21ncFVZTitkd1o1cElYcVptVnc4azc2SXM3b2No?=
 =?utf-8?B?OFQzRHlHN2hYYW9uRGh5MUpjYzhwWFJ5ZjFPOTJOQmRkejdsbXQ2dXl3dEEw?=
 =?utf-8?B?NWtBSmpVeG5zQ0NjNHF5RzNrOE5IL3JJTVFlL1FOTElXZDVtaTZLNStuRlVV?=
 =?utf-8?B?VGhtSzBkN3YwME80NzFnMFFpVlZSNDhtdm43bUE3Z0VDR0tJcng3cnpIUGhi?=
 =?utf-8?B?OE1UaEhMbGs2Q01ybEwycng0T2ZMMUE4NkVPY3dDempQYittcTdwaThvekMy?=
 =?utf-8?B?eVhqdjYxY05TSzF1OUFiWDVKS1lqaUV3SlAwWWtxMUNMSTFWdlh1RXo5bklu?=
 =?utf-8?B?YUFwVnVSNXh0RTBGeS9hdmgxMUYxMjlaWlFTbzRvd2kxYURvRkg3ZXhma2V2?=
 =?utf-8?B?aHdpQ295aHMzTkhDWEZPS2RXc3hKRXB0Rkg2UCtOUnRHOHAyUlBORkMrbFVM?=
 =?utf-8?B?ang0bVJSQVJWSmZYY1EwYWQ2R0xkcU5DRGZtaXpQL3lYWGF5Szg4RWVzbHhF?=
 =?utf-8?B?OG1nSjIvUjR2c1JTMVNCV0VSbVpCdjZqOGdTU280alpGeFhQdlZwVGpEMVl0?=
 =?utf-8?B?MGx0c2VBdXBXcVVGZVh5STVpUUwwTWxzSWZRcDR2NFZIYURrOG5qSVphVDJl?=
 =?utf-8?B?bVZIQUgrKzNiSFZITHdSNHk4MzFiQ2h4K01yN2oyWk5RL3pGSDFNbDRpdVkr?=
 =?utf-8?B?SWlIMmg1bWsvaEk4TXFtclpEZzg3Ujh4TUtjTzMwSHBZaXRnZ2lidmg5QUhF?=
 =?utf-8?B?c1VkeWh4d3VGZHVYUEFuaG5QS293c2FUL0dVTnNsUDgwMm5OSk5janZ1Y0Fn?=
 =?utf-8?B?bVYvNkI5UFEyamRDYjNzRlN2SEhZaDhsNFNqaEgyZ3ZnQ0ltM0d6K0Z6SFJm?=
 =?utf-8?B?NkszMXZIckV1NUk1SUQrekpSRnBBQk9FdlB3azBLSlRlbm84TDV1dG40RzQx?=
 =?utf-8?B?bEM5WFNjQ25UQ2F0SnIzVHl1OVhNc0IvemVGZkdoUHdTSFppQmx5TEdiLzBV?=
 =?utf-8?B?YWU5Y0Y1RnRaM3pWMElkQlFxNVJRS0hEZjVzVkVmNHp5cU5yVWMxMnlEUlZr?=
 =?utf-8?B?MXhzV2Q4TzIwankxbnNrekpzRGttQXhGcHpkUFhtQmVlNzIwWlJKbTVNc0VU?=
 =?utf-8?B?RWNLNmhwS3A1c3lVcm1RTkRUNlhrbFViaVltQ2lVSWFiY0lSTEU0a1B2Z0VT?=
 =?utf-8?B?WWloeURKQTY5cXdhd0t5MythTVk1THJGUWlaWUVUeDNWMk9HNHZHVmJudng0?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa926fc-f694-439e-84d1-08db7667288a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:02:43.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zzzv/x0U4CqBtLisN+JpOe+vgnfkDymTS+IbfQt+xYfs6ecUplGLPdKmIE781PBh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5165
X-Proofpoint-GUID: u3vB5ltAHha7QDvOjXmTQDLzOn4nxUzJ
X-Proofpoint-ORIG-GUID: u3vB5ltAHha7QDvOjXmTQDLzOn4nxUzJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_14,2023-06-26_03,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/25/23 7:34 PM, Carlos Rodriguez-Fernandez wrote:
> It allows tools to iterate over CPUs present
> in the system that are actually running processes,
> which can be less than the number of possible CPUs.

Please add more context here. There exists a bcc issue
    https://github.com/iovisor/bcc/issues/4651
which shows the context for this patch set.
Basically it is to address bcc/libbpf-tools/cpufreq
failure in case that some cpus are not present.

Carlos, you need to show what can be done
in tool itself to resolve the issue vs.
to use the API from what is proposed here
to resolve the issue. So it would become
clear how the new API might help or not.

> 
> Signed-off-by: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
> ---
>   src/libbpf.c | 32 +++++++++++++++++++++++++++-----
>   src/libbpf.h |  8 +++++---
>   2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 214f828..e42d252 100644
> --- a/src/libbpf.c
> +++ b/src/libbpf.c
> @@ -12615,14 +12615,26 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz)
>   	return parse_cpu_mask_str(buf, mask, mask_sz);
>   }
>   
> -int libbpf_num_possible_cpus(void)
> +typedef enum {POSSIBLE=0, PRESENT, NUM_TYPES } CPU_TOPOLOGY_SYSFS_TYPE;
> +
> +static const char *cpu_topology_sysfs_path_by_type(const CPU_TOPOLOGY_SYSFS_TYPE type) {
> +	const static char *possible_sysfs_path = "/sys/devices/system/cpu/possible";
> +	const static char *present_sysfs_path = "/sys/devices/system/cpu/present";
> +	switch(type) {
> +		case POSSIBLE: return possible_sysfs_path;
> +		case PRESENT: return present_sysfs_path;
> +		default: return possible_sysfs_path;
> +	}
> +}
> +
> +int libbpf_num_cpus_by_topology_sysfs_type(const CPU_TOPOLOGY_SYSFS_TYPE type)
>   {
> -	static const char *fcpu = "/sys/devices/system/cpu/possible";
> -	static int cpus;
> +	const char *fcpu = cpu_topology_sysfs_path_by_type(type);
> +	static int cpus[NUM_TYPES];
>   	int err, n, i, tmp_cpus;
>   	bool *mask;
>   
> -	tmp_cpus = READ_ONCE(cpus);
> +	tmp_cpus = READ_ONCE(cpus[type]);
>   	if (tmp_cpus > 0)
>   		return tmp_cpus;
>   
> @@ -12637,10 +12649,20 @@ int libbpf_num_possible_cpus(void)
>   	}
>   	free(mask);
>   
> -	WRITE_ONCE(cpus, tmp_cpus);
> +	WRITE_ONCE(cpus[type], tmp_cpus);
>   	return tmp_cpus;
>   }
>   
> +int libbpf_num_possible_cpus(void)
> +{
> +	return libbpf_num_cpus_by_topology_sysfs_type(POSSIBLE);
> +}
> +
> +int libbpf_num_present_cpus(void)
> +{
> +	return libbpf_num_cpus_by_topology_sysfs_type(PRESENT);
> +}
> +
>   static int populate_skeleton_maps(const struct bpf_object *obj,
>   				  struct bpf_map_skeleton *maps,
>   				  size_t map_cnt)
> diff --git a/src/libbpf.h b/src/libbpf.h
> index 754da73..a34152c 100644
> --- a/src/libbpf.h
> +++ b/src/libbpf.h
> @@ -1433,9 +1433,10 @@ LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>   				       enum bpf_func_id helper_id, const void *opts);
>   
>   /**
> - * @brief **libbpf_num_possible_cpus()** is a helper function to get the
> - * number of possible CPUs that the host kernel supports and expects.
> - * @return number of possible CPUs; or error code on failure
> + * @brief **libbpf_num_possible_cpus()**, and **libbpf_num_present_cpus()**
> + * are helper functions to get the number of possible, and present CPUs respectivelly.
> + * See for more information: https://www.kernel.org/doc/html/latest/admin-guide/cputopology.html
> + * @return number of CPUs; or error code on failure
>    *
>    * Example usage:
>    *
> @@ -1447,6 +1448,7 @@ LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>    *     bpf_map_lookup_elem(per_cpu_map_fd, key, values);
>    */
>   LIBBPF_API int libbpf_num_possible_cpus(void);
> +LIBBPF_API int libbpf_num_present_cpus(void);
>   
>   struct bpf_map_skeleton {
>   	const char *name;

