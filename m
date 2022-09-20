Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA98C5BEA93
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiITPxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiITPxe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 11:53:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC196A4B4
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 08:53:33 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28K8Q3ia030946;
        Tue, 20 Sep 2022 08:53:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Kqry9aB564I2Tx+9pkrImA/u4+lb/X+Dw9xeofM6kjw=;
 b=mAUCH3ZFzeFEfzu6Ot2k7TnZNxnBY/Oq+XGYas0VNQ9l5DPqpqq6gRtnEdDPWzp3hyeL
 O+MxBRgStAXwRS6DaeVMmpRV7tXceukAqmtBz0pkOSOX7YG5y4iGDeQ72LNCAPkTdTpc
 4e3WqkzJgQvqXn6YAVv9LPKHKxAIra3yAtQ= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jqa0favh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apiYHYZ4lVoNvJpBUNmAYjntnXs801GrS6WtkJbgbIxaK5lQ5L1+U3n6RcVokUvEyxxW57TSCDIBn0s0UqxTSPQZeQIQi1dn8kFpXNo07Qy2mOUXSEJ3m65E2UEBVWnxPIM7bjkh6IwQBdI/skGQiff+Gq605coXng8vB6Ppl5hBYLuWPH5qIayqKO2LWXWRXNtrbDx5itZq7f0fzuvpDQZPWh9rO7hm9qSMfylHNV5HT8aVZwnOUEZdb+xdZ3xyIUgQ0GFyxxVOnrwI0RyDgnzh3mPTq+m3/1uGoHtxrZrW1cu4eXz5XODHJQ8xm53m7DsnI6+wHDRNzI+J2WCvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqry9aB564I2Tx+9pkrImA/u4+lb/X+Dw9xeofM6kjw=;
 b=O+uD/nkLamNU0dK17BzUmhiesSDbp4EasDkQqvaHBptTdF8fG9RCG16GPlSI9Ksv6Po4HHdsESYFJRa6iI83J3dqnt8vzVAUDxQj4sSiJfSw80E3gMxJdD6k/ESRlwQ0BPdNGhg5nMkjBN4o664H2Y+uUJRy2086t6HDy72m1myVs7bZcFbFRh8UbQILlP271kbJR+GpvNZB/plw44Qr2ZdnJ4SSgSyp+nsr8hpK/vcEEBni1/na/SDEJDBFfUzU9pYNNdVmO/ZulXo4DKI1hbGWD+EYwOZLt0VaW1aq8rZFzDqGs/c/YUs7r/ggAZh5rbLkhtbpRZZzXu+hCz9RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3321.namprd15.prod.outlook.com (2603:10b6:5:171::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 15:53:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 15:53:13 +0000
Message-ID: <7a882d19-f49e-1255-6a27-b1f3d935bd63@fb.com>
Date:   Tue, 20 Sep 2022 08:53:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: add CSV output mode for
 veristat
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220920040736.342025-1-andrii@kernel.org>
 <20220920040736.342025-2-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220920040736.342025-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: ea64bab2-6a54-40e7-d65a-08da9b20397e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1s2wPq8lMTM9imzldKDmyUJrLMXzLnjZHPH1oG50ue+1EzM9l84fFzV6SlCYufGZDjKtMXYRkXuiis3vHzAY/L2ZSexsmXZrGeQI3ameHN4CuoRWArp1TMRhWzU7YsF6EPBl7SOdhET37oe7fjCIzIwvgLvYeXlAwYxMAh19WRM4iyR/CYUSO5HyX00D9PAu6jPrJ+YykdNbvL4+gxJ5gQVCim0Jbz9tIG+sKFXM5k2mdMM04gwYRzM+NJtlx4IdW+w/ZOAvZ/dtKKdG6/qTmnrWSNr/pziVNrBg6wFodxLSUtCN9vqQtT1neva1C8NixYWMyMI4XrRcwHMdo132mzGBGBmT2HRk68lx+s0hnEi/pnh9bnp4SHp5sNkHi+CnUZxHe8AIPozkRGueCdlLol0zBEVQ2fyuIpavCZ/Zsx3qcbREuLTYEy2BpKGvRsDunpn1RNEwwKptKk+i3oY04V7UTT7opRMFNLsO4digehKgywVRVU5GlSpsuO0Ywe77pGhh3tS3Q+scc+PezCULL160F7MpD3o2bKtS0aE5sKAXQ5iKs1zi0wqblDfqms8bEMH0m75dEVM8/D/kCEz8rtxMRHYTzI8Y/n9claLhed6v4E9j8oWmBeOZ9dGLy7cJN6YQKgSAMEK1Pd4PNe3b3O9z4aSHD3OpLUFDPX0N+gqZfL40mi260zmGPfgvNBuVPgbFhyVHLdyWjlyhRh/tB+om3vEAVxbfoz7EYcvIYQwNB16q1ybIs5gaPYFXLqwOBLER7nkSbY9+iOsZRt+lxhhbg7fxhJwGihfJnIEACE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(8676002)(31686004)(6666004)(36756003)(478600001)(41300700001)(66946007)(66476007)(66556008)(5660300002)(4326008)(8936002)(316002)(2906002)(31696002)(38100700002)(86362001)(2616005)(6486002)(186003)(6512007)(83380400001)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9TMjhYYUsyOG4yRE9UMCsxVHA3cDY5OGdhc3BBVldCdER4ZHlDd2Qwenlh?=
 =?utf-8?B?dFBBZDJBWVRxWEFJUjZjZUZ2SjlORS9oMjdxVkNmMzJuamhlbmRocktCN2hW?=
 =?utf-8?B?OWY4RFZ4U3E1MEtBT093dkVLZ0hwU2FZRjRTR0N6Ni9vSEltRk5CbExiT01W?=
 =?utf-8?B?VjdTeFpKWlVyL2VxalNRM2IyaVU3VVlqSXJ1OXhxWE9WSE96VG55c2QrNEVX?=
 =?utf-8?B?TnA3Zmk3UmtEU0Ewb1owWTZ2eVB2em1HL01hVkhZd01RMlZ1RzcxdE84Yk9z?=
 =?utf-8?B?Q3ozY2h5cXQzc0JoOHRoOEJVR3dMN1YzeHRZYTI2cisvbWJDT0tOU3ZZTWdD?=
 =?utf-8?B?UVhJeG9qYkxYeW1KMFhmUnJBRkpZTkRrdXU5bmdlL0NFVGhDVEp3TGk3UTRY?=
 =?utf-8?B?S1JkQjZMUXlNeUZGNkRHR3g0WnJHQzhRWFI2V3FtWlBhb080TUUrMkVLSlMw?=
 =?utf-8?B?Q2ZDNnpvZGFEYjIyaDFxbG1KL2FNYVI2YWhvdzRvTWZrTFV6VnF6Z0c4SzRN?=
 =?utf-8?B?emZPRDRzM1ZaS2pxcTB5NGtUdE9EbHhhZCtLdUJQSUQ4ajFBdlJUSzNJVWlJ?=
 =?utf-8?B?KzBtVktSQnMvb00zcW53N3paMnBHOGtWVDk5U2VyMDU2QUNxdGFyZ082VkRB?=
 =?utf-8?B?Z1c4b2FNMlNuWXl0Vm9aaWo0REVPbEYvcVY4bjNiTVp2bHB1c3BRZk9PNFAx?=
 =?utf-8?B?ZmU4ZVhBblF5ZGZJOWtlWVJzYURnRXdwdGFrdnRxZGc4cFZpcHFoSGFuWlJ2?=
 =?utf-8?B?QVh1bDJUM1M3Zk9kWDV6ZDBvMXFOUlg1MFFMa3lrQXJqVThXeDlwZnVhR2xy?=
 =?utf-8?B?QTArdjJHdHd6MW10ZWFFZEVMMnJiQjZTSHY0aUQ3WDdKMmYvbm9Va0lTUEN2?=
 =?utf-8?B?SEhaVXQxV21ZTVR1OGFBVG05aEptSVBuZG5nQ0xscVdNWU5uMXB0aHJxZDFk?=
 =?utf-8?B?VGo0L0hKNzVpRm1OaXY3cCtGem5FWXgvSThnOEJwb252b0pUTnpKV3dTdkZL?=
 =?utf-8?B?R2FUYjU4M0FkNEpyeFRIcXNDdmgxRkZkZ3d1ZkU1Qm9KMitGQlJCMUhmSGIv?=
 =?utf-8?B?OC9rdFpPTmJWQzJKNDIrdWpKcU5ONytWcWIxUlhyaUgzdUpIRWd2QmZMWWdI?=
 =?utf-8?B?ekFUYkFwdjI0eTdhM0lqN2ZCNjVOKy9NVDVWa1djdFRUQkZWdEFxRlpBWHJ2?=
 =?utf-8?B?OWFoczhycVo4UkFSUjZYQWdyUXd2WXNkVitWaHdPMk9MaENvZWsxN2xka2Nl?=
 =?utf-8?B?b1lzbHZLKzVZb3R6SWMrbUVyZnV0SDNmbHI0Rm1xY2FCRHVUTGthNWVNVm1i?=
 =?utf-8?B?QUtCUmdHVFRTRGhrZWY1QzZyUzdiL0J2NkdRMnJCcE1VTTd0eGVTSG9VZG9a?=
 =?utf-8?B?NWVvYTVUdlh5MlVqVHFmSkJSdVIrRkZaY20vR1RBcXJ2QW1UTzdvcEFnUzc4?=
 =?utf-8?B?MklpdHZuRU8yVmZJWDU3RFlOWHY4azFUTXliWDNyblRoeWk3UWVSYUErK2Nv?=
 =?utf-8?B?ZlRlSnJ0QnJiUDAwWVVGeEllVndwN21mM3h3RmtueTdrdWVlYkRnb3Vsc0Y0?=
 =?utf-8?B?T1ZVNXRJWVVCeGFBOFJYVEVWRy8vOHFsT1p4dGxTMkxwVUZIVGhSaE1uL0Nj?=
 =?utf-8?B?UGxsMXFpVGJwSkJJOFZTM2R5WmJIck5GVzhGMm9xbHFNQVNqK3NJNFZNajg1?=
 =?utf-8?B?TTdFNW9uMkpEWEU5UnBzdEZ4K0JrZ3hnUVRnM2tnQU9OOGMzaDRvbG5MbXVX?=
 =?utf-8?B?eDdsVUhOOTYvR2V2YXR3UE95Wm96Z3h5bHlYc0dZUHpJd0lJaWM4VkpCVlJh?=
 =?utf-8?B?OERET3hKUVdXQTlrTTU0RlVrMHZkNGZJaW5ORHBxY25pMHhnSGJUa0tRZWdN?=
 =?utf-8?B?aWdkY0NVTnJkREdscG51RytyYkxNSE1jelNORlBTQTE1Sm1La1p1NmlyYXdm?=
 =?utf-8?B?YXpqTDRHcXBSalFqZnp1TThIeG8wdm1OWDdQaUgvMDVvUFBlZ1Z4akhYZWow?=
 =?utf-8?B?ZkRQTTkwMENDZ0JZK1NRRHM0WnpLSlpRL2FibjY1TFAzbEdLZzJDM1lIak5j?=
 =?utf-8?B?OHcrSmVveVptemlxS1Z2Qi9nb25oVWpYUW11UnZOdjFmMEhINTNlWXltdmtt?=
 =?utf-8?Q?XZtV8y6G1aBFp9g2kqWG0fo1R?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea64bab2-6a54-40e7-d65a-08da9b20397e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 15:53:13.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aVPtYFN2+g8gN0937AKu+fyMc/z7wnCVeZLG1jZPJxF5LvaFuX8WDdGD2l1KLqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3321
X-Proofpoint-GUID: B78LGIZHvvqiq1jHms3qC32D0cjEs0TD
X-Proofpoint-ORIG-GUID: B78LGIZHvvqiq1jHms3qC32D0cjEs0TD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/19/22 9:07 PM, Andrii Nakryiko wrote:
> Teach veristat to output results as CSV table for easier programmatic
> processing. Change what was --output/-o argument to now be --emit/-e.
> And then use --output-format/-o <fmt> to specify output format.
> Currently "table" and "csv" is supported, table being default.
> 
> For CSV output mode veristat is using spec identifiers as column names.
> E.g., instead of "Total states" veristat uses "total_states" as a CSV
> header name.
> 
> Internally veristat recognizes three formats, one of them
> (RESFMT_TABLE_CALCLEN) is a special format instructing veristat to
> calculate column widths for table output. This felt a bit cleaner and
> more uniform than either creating separate functions just for this.
> 
> Also fix double-free of bpf_object in process_prog, which didn't feel
> important enough to have a separate patch for.

Without this patch set, I do see the following failure:

[$ ~/work/bpf-next/tools/testing/selftests/bpf] ./veristat -s 
insns,file,prog 
{pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*.linked3.o 

double free or corruption (!prev) 
 

Aborted (core dumped)

This patch set fixed the double free problem.

> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/testing/selftests/bpf/veristat.c | 114 ++++++++++++++++---------
>   1 file changed, 76 insertions(+), 38 deletions(-)
> 
[...]
