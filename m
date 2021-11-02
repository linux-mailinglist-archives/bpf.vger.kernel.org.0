Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9182844322C
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 16:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhKBQCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 12:02:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhKBQCS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 12:02:18 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2FHm9q028118;
        Tue, 2 Nov 2021 08:59:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5cYf3wHO6s51sCpkE30GcyAhjyof6SF8ca18PJ01ZaU=;
 b=dks5zPmFCIIoVt/KldMR7ix98fHpoCD1FKuzAXJh0gvZtj5B1uj4kjwtdDb5M5bRLE4D
 HUi8rBcnZHt321/EHN4UkzCwyU+l9vDBA1UDd5u5P9AhxOZOHRpSxxZHnNBpdTNG8euT
 v9KAvqOweVHBdCbFssyp8abMeWlWfwNAlOY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2ysv3mgg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 08:59:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 08:59:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws0sLGEsdtYNOpfZ6dWbNPa5SZKEN/GZ+XsbRkmm+fPH+7tzrJupJlFVxjESoKb5TOsLF9yiJVFVtCCGalUlXrdUm9/ppYF5mCLiXIBXeJTtyH+6jrzGL3hD+cWPkxDarDO9nTuwiAG4Qrvy7/IfEeVGX6SK0F2FMdkqLsIeq8caqNwXJK0Kdb457dz0j/ona9eSG6qyNhO4TPahVxK12TFePYPsNpuS7e8guBNcIvk9+8Rd9brwN+AP7JWLcvzhFgwMnrV+qKmgx6zW/CutzdQKW59D4k/vPkHpKvDlpvVsMFQkjeg64jRKYsWxqN1MQc6xk/003Bbc3zBk70ltSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cYf3wHO6s51sCpkE30GcyAhjyof6SF8ca18PJ01ZaU=;
 b=bfjI2iYBaASMi8Yfm0on/cmd69kfFhKmEgrcr0dwzRevlR3BewxVF4bcirIwFwhkEd/e/91kJO+IsUz7P5ylryI9I2GfuqY0YFAzkJRXwdOe9dCiVyMb8AenSOyJ1kTxTXVGLEWNs6mQcW7SLsvFBWjpatmruqr+vIsArrjxtGzxUGME3wOjr4fBgLPHnTk4uPzSdV6hBpprtsyTs2CRnKskMh03aazK6WTV9TcgUBNlou5a7wgkR593wCofjTtt3EbA+1KamUbkg1PSDWNaSL4TQkCaTBs/i1JbIsOcyl48wRsXImF8s8ski9jb49lCPW+6HajFUBm4NPeX5SdmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4657.namprd15.prod.outlook.com (2603:10b6:806:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 15:59:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 15:59:13 +0000
Message-ID: <1fe8fbed-497b-1874-abc5-3f104a4d8b44@fb.com>
Date:   Tue, 2 Nov 2021 08:59:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not reject when the stack read size
 is different from the tracked scalar size
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Yonghong Song <yhs@gmail.com>
References: <20211102064528.315637-1-kafai@fb.com>
 <20211102064535.316018-1-kafai@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211102064535.316018-1-kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR1401CA0001.namprd14.prod.outlook.com
 (2603:10b6:301:4b::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:2e35) by MWHPR1401CA0001.namprd14.prod.outlook.com (2603:10b6:301:4b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 2 Nov 2021 15:59:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3be5c982-cdbe-4178-065c-08d99e19b74f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4657:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4657511AD8474E6DB1538394D38B9@SA1PR15MB4657.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGW+owyeAz8L5VD3e3Zow8EVPIqpdBjykadHwcBv77GWqXBbOoWIa9MJ6FytG+n6pWEqi8h7IF9wU6fiaQ3DBEDVPWCYnLEsiQDALldAJ991mzefPgzVy5bdAWefBzO6kH/6ykfaW3muZdjeKY9VchgwQqRh5nRBq6OyIPnYuvRTQucmpGcPM2fFOUSFG7cabDZJfFU5fyHU2E35SGNJRFgwf1UrBsaHC6EuoLhAp4aV+eWYxNbVUlb8cEoGj2vUG5DAWzB+gEH/gs6uLM6gpww2T+lPD8jBMUGIsMP4PtRGl1bsqy4QguWUiTq7i2uBGdPykfA8sXyEkOfeXkpJNyRIw5UQMQQ5Pq87Z5Zc1Oclp0SA354FudcGMWXDkUyvqCoWQf3CP/U1FcWmkl1ZxB5zHipw+y3AQbiku3In81/pz4vWt29VNCDwX82uclueFNA966Fk7JEtXK9v1ZRNqyA8YHl0Xhgc1iWPwO6OSVPMCkg9tdltKgo/fYXlroehT2EA2ye0ghTYX9zTlJpg3ilISkp+q01P9aV4KROxrGzxlE4Wfxdyj+5FcN1ReVQ4jX+dv3EC0oryut9Xl9X64XjM0oUmcuQrrrjWTVVrcsn+d3irHtDmC/4U0yd+ek0ALrbN6cUQXKWvDYthIJPD0zP8Y1Qo05sMuZDm3tiMyW0SRwQdTjVA0LUtUuN25zpXfFfUEJUaCO6UOAyGeCHOkjc//MGcW+jcgxjs60TxrZBY4lmkX/h6ZcthhixH8ljbKnZSiIwmPfToQ99odAd4PS7pRFzOF6MeTrJdUn/Di+AXIIx2ILF1DgAmmFVe7Hvq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(31686004)(186003)(2906002)(66556008)(38100700002)(66946007)(8936002)(5660300002)(2616005)(36756003)(316002)(966005)(6486002)(53546011)(86362001)(8676002)(54906003)(52116002)(31696002)(4326008)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NSTk1sTlNZRHoyV3dVcDIvV3pwa3BVa1FnVTNaNStZaWJYbEw1Y3BEUDdP?=
 =?utf-8?B?emtNODJ1T0ZhMW40WWY0R2dLS2YzeWhHTGIyUVdSb0J3SkxRMGw3aUxiZ3Iy?=
 =?utf-8?B?SDI0WXlYaUdYRWRxYXBEbFc3WmV0a1FnejQxZlNWaDZER0hLajFDTFZTTVRJ?=
 =?utf-8?B?NDNjM3U3VnR2SVUrcU0reWxPWnl2YVliUERGR1Q3OHJrQW1EMklNMFgzMWdw?=
 =?utf-8?B?ZE0zQ013YjhZMW50RnFtcXFQK2NaSnNXUUFGTHpybWRLN2htU0hRdHlHcGp3?=
 =?utf-8?B?dmFJaGRLNTBVY0I1ZVpPT0l0c1RBcXhVRmVXT1NwSWNTV2FyWEpZZzBnRXQz?=
 =?utf-8?B?VkI4VTlDNkFHaGJ2RE9KcUE1dFVJZU9YamN3c2FENG1pRTd1eVVJbzVhQWho?=
 =?utf-8?B?NVF5blBRL05hUzlPZUxaakpTVXdteFl0bDFTWlJVMjBmaExmNm94UE5GemFQ?=
 =?utf-8?B?RjFRQnhuYit0Q1NSR2VPb093amFxZWh4WGhrQVBmUi9FMWY2Tmp3V1VhWlBY?=
 =?utf-8?B?Tk1qM2FVOHMzTkhiQzNPWFNxYjdnenBldS94bnZOZ1U0VHFNQjRQUG9iSDU5?=
 =?utf-8?B?YUpEL1d2NXBmQmVONW53Q3ZUeVVrSGU2OTdRbzJIaVNTZGplbm9jZzlWMWVa?=
 =?utf-8?B?Qms5dVBiejBwWG11OXg4V2FqcWxzeldLa3YwQjVSVXVoVnEvU0pLem1WS3BT?=
 =?utf-8?B?NXdKaUxhb01ZaUJ1T0c3by9NdVQyUzVUMG1QY1NlM3FITVlpZEtRVHpBY0Jr?=
 =?utf-8?B?ekxpRXRMdVA2WFhHWnorTTZrbnQ5RTJDMGVBVGl4ZDhXRnprNHFyalFyUGtm?=
 =?utf-8?B?a0FiRThubVQ0cHFSQWdLMzBqUk85M1dzQXhoRVdJUU9yS3EwY3d3ZzlyUjBn?=
 =?utf-8?B?QllPMUp1N2hIdDNmcUF4WVFFYlNVajFxa2RtOGVUcldZZTA4NTh3SzZiWVVF?=
 =?utf-8?B?MDhQSEtNenJxdStIYkI3aGN4UGp5ZkdaQmwwNHcwT1MvZ1FrQ3dwN1FjdUkx?=
 =?utf-8?B?Rld3MXNsTmRLQXp4MER2Tmt5K1ZNMVMvZGZ3ZyswTTNpczd4V25zd3pSR1dj?=
 =?utf-8?B?V2xadHA4bFVQZzlsK0paUyt0N29VaXRJd2U5MklNYkZCTDJSTGt5UXMzWEl2?=
 =?utf-8?B?Y21EQlo1Wk9icUdubVl2TXRKS2p3UkVCV0poVGRJRHVkSVBiWGpIdzRLZUdP?=
 =?utf-8?B?cGRIRCtiVCtYZzRGVzUxVzRMZzdiMmJSNUVBRHBxUXFFUnFBL1hxUGpnZ2RF?=
 =?utf-8?B?dzVadlVSYWJLeTZtczM0WTJua3REZVhCY3dZUm91WkFNS2tjV2RhVFdsc0dL?=
 =?utf-8?B?TmJ2N2k5STM0MlREQTRGallyUkZGSlRFSjVRY3V4NjV4N2RRVFVKcWk1M0lM?=
 =?utf-8?B?Z3A2ak9WN29GMXAzZlBkOWt3TnQ0Nkp5aG1sM2RnRWpMZ3FTUEtQQURmMmh0?=
 =?utf-8?B?RkVINU01bDRaQyt1Vm5oYVV3Y0NJOU1CUGVyK2VVVS82bnV3NDJZVk5kUXJt?=
 =?utf-8?B?Umk5SjFXL3ZQK2RTSm00QmRWeDVQRTJPZWlNaWFYWFdhYWZMRmlmYUhTdWdE?=
 =?utf-8?B?V3hVTnZPZmNtcHF0MEVWVzR4Mk96bGloRjBXSkxhZHNvT01mQkZxclRKUmVM?=
 =?utf-8?B?d2w1WCtXUnlZR2Z5OVVmM2dkb1dXL3RHc0YxcFNIVk5NUDQ2VmdDaDZiekdB?=
 =?utf-8?B?UW1iTjh3dkI0THJVTzFYT0hyY2V3NWdWRkJuODByMmJMSnFpelBDYVF2Q0RL?=
 =?utf-8?B?Q252eVZBQ3dCRVVxejI4cmEyR2o0UjRwUUpVSEZtYnJ0YzRaMnRpaGhTdThW?=
 =?utf-8?B?bHI1R3JzamcxQTNlQ21yRW1hKzFzbmlSaXAzNzNSSU8yRmNzN2ZDd1AvQTVn?=
 =?utf-8?B?cUgraDk5L2RLRDFlWWl3djRZR3hUOXMzdzA5NWt5aW91RjhoOU5GM2hiaDdN?=
 =?utf-8?B?TVZJZHBPNW5HN09KdWdsTXRVMlh3bXZvWXdUcSs0V3hyZ1Z0d21hOVNUMmx5?=
 =?utf-8?B?VFovb1hyY1M3OHpCUkZIUlNXazZHOHJSTFlYdjY4WGd0TmM5SnFtR0VrRU9B?=
 =?utf-8?B?eTZZaDc2Q2tLOWJzWFMwaHY0Z2dpeGRwaVFaV0lSNFB2RWxLZEtodnUyUEZF?=
 =?utf-8?Q?sW1p+IakWhch2EikVsWBorc+8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be5c982-cdbe-4178-065c-08d99e19b74f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 15:59:13.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/NvjaWmLfR1zevjPq97Y9WU2Xi6Z7LuXhCzJbYZG3V7otGy9otOpYd4d6M1J6pP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4657
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: tm99cFPMVw60MhxTL-_SCkvXkUVQEiHh
X-Proofpoint-ORIG-GUID: tm99cFPMVw60MhxTL-_SCkvXkUVQEiHh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=763
 priorityscore=1501 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/1/21 11:45 PM, Martin KaFai Lau wrote:
> Below is a simplified case from a report in bcc [0]:
> r4 = 20
> *(u32 *)(r10 -4) = r4
> *(u32 *)(r10 -8) = r4  /* r4 state is tracked */
> r4 = *(u64 *)(r10 -8)  /* Read more than the tracked 32bit scalar.
> 			* verifier rejects as 'corrupted spill memory'.
> 			*/
> 
> After commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill"),
> the 8-byte aligned 32bit spill is also tracked by the verifier
> and the reg state is stored.
> 
> However, if 8 bytes are read from the stack instead of the tracked
> 4 byte scalar, the verifier currently rejects as "corrupted spill memory".
> 
> This patch fixes this case by allowing it to read but marks the reg as
> unknown.
> 
> Also note that, if the prog is trying to corrupt/leak an
> earlier spilled pointer by spilling another <8 bytes register on top,
> this has already been rejected in the check_stack_write_fixed_off().
> 
> [0]: https://github.com/iovisor/bcc/pull/3683
> 
> Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
> Reported-by: Yonghong Song <yhs@gmail.com>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
