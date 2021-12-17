Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11D47811E
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhLQAKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:10:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31994 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhLQAKV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 19:10:21 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGI4dtf004866;
        Thu, 16 Dec 2021 16:10:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8QUSNPo/jWkU2ZKX9a5ursbNtc9CDFGAmbI8fqzaG40=;
 b=JhLqhe2XPMZDDvD+C6T70XkCX0E7CN5HYSZfSd/BSevJKy1hR32FKpxvVwZh248nA72q
 do3hXqtD15RAyeLfxn0GqdN2GUx8XvmdiwvIcg7fa/A8v3UHfXuLVhBInafTa2BQxLGE
 akW7nEcxVY6NrMjrJfer4CbBgXoApSg5hIQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d02jge4ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 16:10:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 16:10:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKTr4kRuGb78O/ORF8Dj7Bzl1E90VG0Z0cJZNdgeUGD+06adt06ATgFNS0yN670zBVqG5ArJWSfRq3uB0laEK9qkCCAlSdh1XcN7gvFj6xqC9ymHfqjh0fCaPii6NX4d/FAooTUCsR3gjCt8kp0XT6tCqHmZg24tGXIpbvF95shc0vkFwtxglbr0v2LkUwCh3GBvGpnFbRzHmOqBp43psFvVpmCCK3Rqmsg/ZKtS58XY/CBJmcUrB59DgdvStvtKUlcrlat27in1Mvflha2DB/HsbF+JrRPHC4eMM3Os9uAkTmSVDdkbKVzTp2Kz5Qlwdu1kOWkbiolLjten6pt4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QUSNPo/jWkU2ZKX9a5ursbNtc9CDFGAmbI8fqzaG40=;
 b=Xw8EQbYW0iVhUUsdOmtlO96jUxj0u0wTEY8Nzjr+cEnv9knkpb+3zSuaoz5ba2SULM83k1PeLeXu9n5mx3sHpML2QlqP0s4vNdKUK7YuaxT4rTgdVo/99eF9iIOo5AzJEZMf1/K8DXrTMuXI7PRtFtJPNrUEgonpburrKY08Yykc4c0938rrG8RDNmUzZcwAq1nUOjiWCYaSnE53+V7XxKg8A5XO+id9EWBYUv9EB7QVzd5amGAJYav05/LszhmrfR3tBNOjNpVwQR6gaLzJM8nMzIZM5UfSdy36X+wp+amW7CPtvb3N4JecXwTNXhRE4ZKl4RDTFvviUFT8okk2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1260.namprd15.prod.outlook.com (2603:10b6:3:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 00:10:05 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%7]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 00:10:05 +0000
Message-ID: <587861ab-e072-c448-c649-ddc6e51353d6@fb.com>
Date:   Thu, 16 Dec 2021 19:10:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH bpf-next 1/3] libbpf: rework feature-probing APIs
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Julia Kartseva <hex@fb.com>
References: <20211216070442.1492204-1-andrii@kernel.org>
 <20211216070442.1492204-2-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211216070442.1492204-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::24) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 657bc9fa-8493-48bd-9a8b-08d9c0f193ca
X-MS-TrafficTypeDiagnostic: DM5PR15MB1260:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB1260B40A9F27DFBB9E5BBDC3A0789@DM5PR15MB1260.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/5/HVz7RJq6Y5SGBGCxlKCtkC66by+SNVvpbd2fnYlUW0EV296esRJRFIPDyJ1xQ7+Fbxy6hWe+Nh8fs7cqACWAa8Nwd/HyoUdXExy/NZO82DKZKI8cFKPV7LlH5/leDDB3C/vDhqtv3sXj4J8S+Vr1fPfp94rn91o+hUqVWE/oCbC6rTjJh+93S43N7uSOPL5UpnLRsQIC632PglJIitAorTAdYXXCan4SbSSrEz8HW0FedhE+WMkO8J9BBD5R5Zb3aZtFBZmdCNnktKTTRobtRabFVQ86m9OsTY3KRRy+Sysfj9jxFKnLfI4NJm/XhT6T/7/rfRX9CDiGCsxXwv4PXQX+CefrPzlBTxB0jOG//nz4nTYtidAGvpC7uB3BG5ycM13KFvd4nwflJVAn00UO4nOsc412aVlV+0ij2OJpIq22jTFh/pWmGfTUiXydox04vSNjqab8b+UlwfFb0+jEgdGw2IOyoFY4dQBJ/PgwgHVHvoOCKTrD9qwdGXRGN0NBDWzC6rYZYVis5pD2ef3P5eYpr1U4fA5YDqQnESQAXFahSZeRCr2i8XwsFFW3JpxLnZSPeOyW0JLBFktCrCD4b5ovnnEwEH1w6X2GqvSAU9X+pVNnp78JWIG7rsrJZQOrnZVqs5s/HMvT71qWRz2Xx+CDVPsYkVzyKeoRJdendhgS+ZS78ek95B5fShtV+sBSrtYndLaHAanJrEK+BBydOTWmx2mDRJ7saa2UbEyTVEs9ggAZSWFbHM6H1mnx6KzNrwhC0n0HIPdR1sEkg0ZqDwt0lTaOMIxHX7z0L/UdzEn1NYrNDQZG1RjipEbo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(86362001)(6506007)(38100700002)(66476007)(66556008)(31686004)(36756003)(4326008)(2906002)(316002)(31696002)(83380400001)(508600001)(6486002)(53546011)(2616005)(966005)(186003)(6512007)(8676002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDF1NzVyNWRncGliQkZ6VDE4U0NqWmhhMWY4SnIySHNNbnBsL2kwTU1SRFo5?=
 =?utf-8?B?K3RBWHhkMWhnc2xMYmxyTFpLYUhJWm9KU3NSQmFsR242UEQwREpBelZzWjhJ?=
 =?utf-8?B?S2tleFpJM2JVdWhYZ1R0ZkhmaUtLd3FYaHFqMVUxK01TdC9PZHZ3NTZvZnpC?=
 =?utf-8?B?L043dXprVyt0alVCNjJHMFJoeDUzNVJwTjJUa2FjQ25kK3Fhc00vUytaY0Ns?=
 =?utf-8?B?RmNiVDRYbnRwVkc2dzJhbmRRbUFWN3Q3dzB5bEZtUFdXbC9Fb2M3bkx3c0lr?=
 =?utf-8?B?R1pCV2FManhkZ0hoQkhjcXROV2wzRld5ZDBLVTVEU2dESTRRS1dUcjh0cDN0?=
 =?utf-8?B?cC9LWWE3TXlOMXFwc21FcFdrVVN3TUVtSnRkc0tZOEllRnY0eThERUh6SXdr?=
 =?utf-8?B?TjdXUkg1cWJzNEVrbXJsUUZudnd4UmhramF6RVZKMThHdjNvU2hjU2VENVBi?=
 =?utf-8?B?Y3VveWZaTmhia3pDeWF5TkZtODIzVkhtSXZ5VkdnTXFmL0FFaFJ2Rk85OEgx?=
 =?utf-8?B?T2J6R0NUa2FDMGFaU24rQ0ZXNXE3OXlCZkppMVRTZW5IOGZpL3JSZjRSV2NU?=
 =?utf-8?B?Umd4bjRacHc4MWt0cVV3NFB4SmwybEtDNHV6ODNQcmZWYko3RDFVTFVvNkRm?=
 =?utf-8?B?QVBnT3pHd2ZtR0ZzZGt0N3k1QjlPazg4NGo5eTR0SFRTYW5xRVRGZnZTZm5Q?=
 =?utf-8?B?OWt0b2QrTGsxYXlybHlsS0xXZTM5RWhFMWNUNkI5QndmeGc4b0dGajNxeS80?=
 =?utf-8?B?c0Rob0hFWWtIUjI0dkpyUlc5TVozWmpXTG5UZkRsK3NNVW5QZUlONVg5czds?=
 =?utf-8?B?ZTF4ZXdQb2RBRlRFMmNhYmszWDJtRHpWaDV0aHpDaEl1WUhMVWhTUU1CK3Rt?=
 =?utf-8?B?eVJzbExXRDExQWpaUDZ3OXRVTWM5OHJ3N3g3aVdFb0VnQ2l2TWNzc1Y2RHhv?=
 =?utf-8?B?eUFQek1ZNGpIbWUxYXNCU3VGQVllSi9vRHF4WGl6bW0yK3RVRVJjRnM5VWxR?=
 =?utf-8?B?bGVScU9XYWU5aEJuVWc2anBSRW94MTJLT0xjTGt4RUkvM2RvaW1DclBlcVBT?=
 =?utf-8?B?NWNYM2NMWGFOUThaYjBnOFN5bTJ6bzd0Q2VkYzg0RkVUVEs2R0gwY1BpUHVp?=
 =?utf-8?B?L1g3QmN4SUxWYU5rQlRqR3BMY2dzMWN3Nmlud1J5WGJ0QXA3MVZGZ1VqajRv?=
 =?utf-8?B?RmtxdXZ2Yzh4ejVLejBGRTRSMVdOUks0aEJoQVhlSENEUXpPZk83SERPSWJv?=
 =?utf-8?B?VXFReHRYRzhtcUVNQVE0NTROWDZZQkQxcDNCY0ltWWhkQXBQSjluNWZxM1U1?=
 =?utf-8?B?QlBaMXRLRGNHWVl2SGJuenF4ZjgwbkgzelJDNTBIQStjdkpVaFBFNjR4Rkpw?=
 =?utf-8?B?VytaOU1BS3N0enlwNGlMVXZ3N0ZRSGpEUG1NWHdOMFVFWnNZbWpmWTdXcjlx?=
 =?utf-8?B?L2R3ajN1bzFxTEJqN0diZlVpVmVKOWtBY0Z4enhVZHlEaGdsZ1ZzZEUxd3RY?=
 =?utf-8?B?NnNkWmQxRVIvby8vNGVtUk9qb1VXQU13akRSaGZlZGZTOUo0YWhNc21sUEtq?=
 =?utf-8?B?cmpxSnM0V1JlUkdBUXVyMW5tYnpTQzBmMUxzcG5mNVJVUExTNWIyNWw1eVlN?=
 =?utf-8?B?amJkMHZrS0lVejlxR2lGUUsyTERkQ0w1a0tWWFRFempaMisrQm9JaEpQNmxn?=
 =?utf-8?B?RmF5Vkp4VHNuUE10bFk3OHZLVElUdFVoOE5lTnRUV25LRGxKSDljWkM0OVJi?=
 =?utf-8?B?S0NHWitMRkIrOW96RkhxSWhEM1o3ZnQ5K0JDdjg1Ull0dXpoTHlyZ2IxT29P?=
 =?utf-8?B?azVGb3ZNVEk5aVQ0a2I1WERPaEZrNmE1ZGFQRUdWYlh6bW1lV1NvVk1FSUQ5?=
 =?utf-8?B?ampidEJudEF1Qy9INDcxRzR4b1h5UG8xcENvRXRiSGFpRU4vTWpNTVZjTGxa?=
 =?utf-8?B?VWc1MTNsMndkL3dCK00zY2RsSWsweDQzSTF0L1FQRVBqK3c0a3RmNEU2RDNB?=
 =?utf-8?B?TkpvMXBGNTl4azh6VXNsdHJCNEoxazBUQlAwVEs3TVAxVGhjUG0xcGpDaGZN?=
 =?utf-8?B?MHR3SU1XYXZnRHp1VTNuZmJHQmcxeEI2WGRxRk5QK05zMUJyRGs1OWJ1TFBI?=
 =?utf-8?B?cU1QVVlDcmIyTVJEN3ZReEJ2SStyQ2VJRi9pQTVGaXRpKzd4NWFhMzVSV3Zn?=
 =?utf-8?Q?fycHNgEoIXA7whIhYEB29CgQ2WgOvgIjcyPf9VVdumum?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 657bc9fa-8493-48bd-9a8b-08d9c0f193ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 00:10:05.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6zhWx+0Pe84hGpyb7/DWNbVw1mfd/46wtTU924mEF1eUUYevNaP+NcLwFJhqFfubPNOnlSs7Lj30USL6cOiVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1260
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: SrpxjRGnwNu-QGtJ39TZ4XssjZKJIh1F
X-Proofpoint-ORIG-GUID: SrpxjRGnwNu-QGtJ39TZ4XssjZKJIh1F
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_09,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/21 2:04 AM, Andrii Nakryiko wrote:   
> Create three extensible alternatives to inconsistently named
> feature-probing APIs:
>   - libbpf_probe_bpf_prog_type() instead of bpf_probe_prog_type();
>   - libbpf_probe_bpf_map_type() instead of bpf_probe_map_type();
>   - libbpf_probe_bpf_helper() instead of bpf_probe_helper().
> 
> Set up return values such that libbpf can report errors (e.g., if some
> combination of input arguments isn't possible to validate, etc), in
> addition to whether the feature is supported (return value 1) or not
> supported (return value 0).
> 
> Also schedule deprecation of those three APIs. Also schedule deprecation
> of bpf_probe_large_insn_limit().
> 
> Also fix all the existing detection logic for various program and map
> types that never worked:
>   - BPF_PROG_TYPE_LIRC_MODE2;
>   - BPF_PROG_TYPE_TRACING;
>   - BPF_PROG_TYPE_LSM;
>   - BPF_PROG_TYPE_EXT;
>   - BPF_PROG_TYPE_SYSCALL;
>   - BPF_PROG_TYPE_STRUCT_OPS;
>   - BPF_MAP_TYPE_STRUCT_OPS;
>   - BPF_MAP_TYPE_BLOOM_FILTER.
> 
> Above prog/map types needed special setups and detection logic to work.
> Subsequent patch adds selftests that will make sure that all the
> detection logic keeps working for all current and future program and map
> types, avoiding otherwise inevitable bit rot.
> 
>   [0] Closes: https://github.com/libbpf/libbpf/issues/312
> 
> Cc: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Julia Kartseva <hex@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

[...]

> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 4bdec69523a7..65232bcaa84c 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c

[...]

> @@ -84,6 +92,38 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
>  	case BPF_PROG_TYPE_KPROBE:
>  		opts.kern_version = get_kernel_version();
>  		break;
> +	case BPF_PROG_TYPE_LIRC_MODE2:
> +		opts.expected_attach_type = BPF_LIRC_MODE2;
> +		break;
> +	case BPF_PROG_TYPE_TRACING:
> +	case BPF_PROG_TYPE_LSM:
> +		opts.log_buf = buf;
> +		opts.log_size = sizeof(buf);
> +		opts.log_level = 1;
> +		if (prog_type == BPF_PROG_TYPE_TRACING)
> +			opts.expected_attach_type = BPF_TRACE_FENTRY;
> +		else
> +			opts.expected_attach_type = BPF_MODIFY_RETURN;
> +		opts.attach_btf_id = 1;
> +
> +		exp_err = -EINVAL;
> +		exp_msg = "attach_btf_id 1 is not a function";
> +		break;
> +	case BPF_PROG_TYPE_EXT:
> +		opts.log_buf = buf;
> +		opts.log_size = sizeof(buf);
> +		opts.log_level = 1;
> +		opts.attach_btf_id = 1;
> +
> +		exp_err = -EINVAL;
> +		exp_msg = "Cannot replace kernel functions";
> +		break;
> +	case BPF_PROG_TYPE_SYSCALL:
> +		opts.prog_flags = BPF_F_SLEEPABLE;
> +		break;
> +	case BPF_PROG_TYPE_STRUCT_OPS:
> +		exp_err = -524; /* -EOPNOTSUPP */

Why not use the ENOTSUPP macro here, and elsewhere in this patch?
Also, maybe the comment in this particular instance is incorrect?
(EOPNOTSUPP -> ENOTSUPP)

> +		break;
>  	case BPF_PROG_TYPE_UNSPEC:
>  	case BPF_PROG_TYPE_SOCKET_FILTER:
>  	case BPF_PROG_TYPE_SCHED_CLS:

[...]

> +int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
> +			    const void *opts)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_EMIT_CALL((__u32)helper_id),
> +		BPF_EXIT_INSN(),
> +	};
> +	const size_t insn_cnt = ARRAY_SIZE(insns);
> +	char buf[4096];
> +	int ret;
> +
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +
> +	/* we can't successfully load all prog types to check for BPF helper
> +	 * support, so bail out with -EOPNOTSUPP error
> +	 */
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_TRACING:
> +	case BPF_PROG_TYPE_EXT:
> +	case BPF_PROG_TYPE_LSM:
> +	case BPF_PROG_TYPE_STRUCT_OPS:
> +		return -EOPNOTSUPP;
> +	default:
> +		break;
> +	}
> +
> +	buf[0] = '\0';
> +	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf), 0);
> +	if (ret < 0)
> +		return libbpf_err(ret);
> +
> +	/* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
> +	 * at all, it will emit something like "invalid func unknown#181".
> +	 * If BPF verifier recognizes BPF helper but it's not supported for
> +	 * given BPF program type, it will emit "unknown func bpf_sys_bpf#166".
> +	 * In both cases, provided combination of BPF program type and BPF
> +	 * helper is not supported by the kernel.
> +	 * In all other cases, probe_prog_load() above will either succeed (e.g.,
> +	 * because BPF helper happens to accept no input arguments or it
> +	 * accepts one input argument and initial PTR_TO_CTX is fine for
> +	 * that), or we'll get some more specific BPF verifier error about
> +	 * some unsatisfied conditions.
> +	 */
> +	if (ret == 0 && (strstr(buf, "invalid func ") || strstr(buf, "unknown func ")))
> +		return 0;

Maybe worth adding a comment where these are logged in verifier.c, so that if
format is changed or a less brittle way of conveying this info is added, this
fn can be updated.

> +	return 1; /* assume supported */
>  }
>  

[...]
