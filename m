Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89864E673
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 04:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLPDob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 22:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLPDoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 22:44:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C054876C
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 19:44:23 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG2LKBd002735;
        Thu, 15 Dec 2022 19:43:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=VcUYbBBPM4R8xhAs6klT2kezs0wBQe1WkB6Q5j89+ck=;
 b=cs0oKOHujxhfVgj7rBHk73uvBq4NwXWZe5e+j1cyYZy7PYiIJNiehxQMqPtFFEWVxTqD
 9QHp+sbn3/x+jnfnNo8J17OEqmvBt5+6x79mhWtxKSGtrQoUCjJQHaHjC+2CKHls9kXp
 5P9rV/bBIa+UJlEzwAt6jM5SZ/PWcExyyYF6P0lKvrbWdQG+clD82ytt+q5tSYZ15C5e
 eoxeIgS3+do1UvZtDXIgF+7pIcaBGIX+vxFviJEpjr0edUxQsmDH4uRYDwpMRbSgMOgX
 SGh0thL/rPT80t7gf8UOVupoXjnOGaixqyC7zYalcyKZggFa28+1wB86OJbRIr8BFIo3 PA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mfvcj0keu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 19:43:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SynlTH8yaHwHIpJNiwyxMuXjlTgriQuDa2L6u+fQynzzhFEVVW7Cpp3w5Dv+2q3C8x9wrjD/BU67ulfrvx9wK9FyRVjeQ3XMF/SMIg3Oa/NZYA7t5pxUI30mXEwlQViqQmRyhVPmMnEHNsr1U1hlYnpRnFF3jgLyAjaSNQ0qc/8pNipMhNI1CdMCznXB+vn1YHQkvM2mru/FmgLce1gqggdPMSWmSL+rEXZSoUpVUKRVE2urx3b0xFO7T3WZjFEPvt3xym1a1IQmO7FgK6D38z+bTpcPN9NvNE9FiQG7YKyL0GeWINrXhKOQtJg2po8yokjkyXYvvQFObygDQJJKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcUYbBBPM4R8xhAs6klT2kezs0wBQe1WkB6Q5j89+ck=;
 b=YGll3t/y7DxxodyghCJ8zN8TQeVwU2grZkHlyKi+qrBEsZRa+T0B+IjDyQkxunHpXroNuIJ3wLNfyocAdvX9oS/eujsCmOBrY79ckSBsQAYSWM31pLiJFL8onm5n62jA2jmPWBmed5InUBWtIKIsa//3noGVSCBTe2K/BoEa8ChwIQKkWdFXBH9VQdO5CL5KD/MP02UEjVTGf1Y+jDVUVugzBuO0Un3rUCdeGfDBizJ0qbgqAtNmimmtZC7LP47km63dKkWG0zT05420GKQ9Iw7QdFbKullaWl1R8/kqPJt8YSbsxjH/pmnSGJcNoKG1Z7mzW1TXLj/WE0apuOjTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5294.namprd15.prod.outlook.com (2603:10b6:510:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 03:43:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 03:43:55 +0000
Message-ID: <3889d437-7016-5955-fc43-614934ff5a15@meta.com>
Date:   Thu, 15 Dec 2022 19:43:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [bpf-next 1/2] bpf: hash map, avoid deadlock with suitable hash
 mask
Content-Language: en-US
To:     xiangxia.m.yue@gmail.com, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:a03:80::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d54045-ab1e-48d7-bb10-08dadf17c173
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvlJdj1389jMrOqQqkilHxIOV03ROHYcz8Rfykb2uiHijwirjm/B5+z0XUkXrn/tsI6c9FecCn1b+mFkS+F0ycWVB+Enxbwq1Quz+yM9OnMFuZlPPlHhydA2Zpg4LsfGpC3LdTDiaegEoqSFHUCxJ5k6Wt8iCVrb3rYRzZqvNt4d+YdXn25eTHiN2ZcHqwoz8FXS75/zOiGBQQ43OK138jnt7JY38zdP2s7sJ0Mh11Zu89xX5m3jkwL2P+RN6pyIztM0sYSf6zqR40r/+8LCCT+TVuOByBMo0YnGGI1Cs0rAXtj/ZaTHllIf8ipKVWlMDpPAuL+owfTBDyJuSjDte9IGpXr6bSPl2KVCgJ2Yul25KhEK4ELCk9YShsA3gIqBVHcqCT/HQCdE1bKInr1/VIueX9Zti7IKiHN2Hg6/IWPnce99r3e8U6/ln3H4yeK8PgSe1X3W2Qu8zo17bc+ulzyUaucm5zqNRKNTh1Y6NVCPxmBNPDi0CpGw+6T35p53916Eut+7JOJLqj90uYwTopcAzXEjZvK+WNP5bNBjj2h1EdBoN9hMXjEE3+mS0y5mAdaUsTwLRDysMLI3/YczCsR2SMQbgBUfEf/CBGTSIHZ2zhxJm2q9gNCRSD3WZH9cNniFqkQHGpjyT4oZj0lNp1xuXMn9ZLe/t154OkXLDp9JYHNvJbc7Zz0o/OMlEYxzCi18bqPO+d33tdfYsPymsxrUJ8UZuWXW7v1XtVP+6QA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(36756003)(66556008)(5660300002)(66946007)(66476007)(8936002)(41300700001)(83380400001)(316002)(54906003)(4326008)(8676002)(38100700002)(86362001)(478600001)(6486002)(186003)(2616005)(6666004)(6506007)(6512007)(53546011)(31696002)(31686004)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlRaXVROXdpT09uMm5UZVh5WnZDUzJha01uZjkwVksvaGZTRW5JajZCbndN?=
 =?utf-8?B?bm1wRG9ydFpDWG9IeFJaV0pzV1NOT01kV2VrQTNGdDByUlFNdnpOeEtuS0Rk?=
 =?utf-8?B?MDdIc0Z3WnlML3NUZ2ZwdFRzUWVEU3RFNnJqRXBWbi9lajVpYlBNYVdTZ2lh?=
 =?utf-8?B?WEhvVGZYQ0FIaVNlck5MQkFyaXZMMzd0eTNkYTBuT1dqUFZscHlRbG5VQ00y?=
 =?utf-8?B?TDdNMXpKNHVUOXZobmwyelpuQnBpa2NERUloYThYaU9JODhEMWhyb1NNem1X?=
 =?utf-8?B?Z2pNNmhMYStlZWJaZ1JpRFBEOHpPdFVkdVZSQUhOZEhLTUlJWXZVS0JXYnRC?=
 =?utf-8?B?NGlUamluZk5FVFFiVlpGdlYveEFJRG94bWgycHRYaTVYamVVTVdxSTNML0R1?=
 =?utf-8?B?bVBocGZOVHZCSFpSY0ZnQTNzeDd3WjVnOSt5WVRuVEZIWXUveE5WVVNWL3Zq?=
 =?utf-8?B?SUh0cS9XUlpqM2VZM0dSbzdmdGVJdWIxclcwNFNSWkVqU3R2WDAxQmtWbm9S?=
 =?utf-8?B?SW5GVC9qUnBvUkhSWDZnMUFzS0EvV3FwOVFQaEhLVFB0bk9jU3dOQVVSN1VK?=
 =?utf-8?B?alpvNVhzUTQ2L3g3d011MSt0dGQxejdNanI0c0tSQUlXK2ZxMnFnNmZ0MG52?=
 =?utf-8?B?dnNYZ3lPb0ZEUUl6UmRnN21HUjZoM3JOWUJHTFZnZnE0UmZSM0ErZjd1ZWY5?=
 =?utf-8?B?ZytCaFI1MGhjOXFkZHFZd25jNXpKVXpvQzNwM2k0UkFQY2RHejlRT2RpT0t5?=
 =?utf-8?B?QnVuS2UxNlFPSDJOWlpBeHl0cG1DUTJRU2NVZXNuOTNwaVptcWFmQTlLVTg2?=
 =?utf-8?B?VEI4SHVuTWV6NCs1djB5TU4zdFk1YlN6L01jeFBPWjRzbXozLzJvRExuUy9N?=
 =?utf-8?B?YVNVUWVGSU1JUXlQMWQyNkx0UmI1a29pVk5DN0VTck43d05DdXhoY1Z0aGVD?=
 =?utf-8?B?SUZVYUhybHI2QjlHMWJrVG9HWWtWUW9BT2thb28vUjN3T0FrdDZjbVA0VDF3?=
 =?utf-8?B?SE5RNG9GUDlldW5XdytOY3ZUOTliT2N1bkhwS0xpNEk2OXNHODVmcDlheEtj?=
 =?utf-8?B?Tmx2bktGZzBvZU9wU1pPWjBVZ3Y5OFpJNUcwZnoyYVRodWFKZDcrWmxHbWtM?=
 =?utf-8?B?YzdaeWlaTkQvaUFuMFA3OEtwOVdzeU4xMXNEa0I4Zkl4TGJYQ2xBbkVaU0cx?=
 =?utf-8?B?TkJEcVc0dUJFYkJMSURubU5IR1VwS2w5R00ybmlSc3NLL0RIc3E4cHJLcFBn?=
 =?utf-8?B?N20ySU9EaVF3M0ZyZnNZbDBRRHNXYkhSblYwTDlHMytsUzJPS25LZlYwdjh1?=
 =?utf-8?B?bXZGRWUxSVgycmFIL3BXWlUwUWVPc0M4Y29uY0xnVzRmNngzUTg0U3UzYmVC?=
 =?utf-8?B?S0N5VnlzWS9SY1d1dWZYYkkrVjVZZlVJMWlINk5LQjZLQlBXeFJQLzFaeHkw?=
 =?utf-8?B?WkVkN0dPS0w0c2Z3T3pMcUh6ZFRFeWRyZmFNQ1A2M0pSKzF4aXRmZmhjakZK?=
 =?utf-8?B?SFJoK21yem1lZmxzWjJPVWwrNzhoV21reUtrUnNMRWNjT3BxRVpvVCs1SVlS?=
 =?utf-8?B?TldRRlBWYk9hWW9BdUIvd01YeWxDMWpYSVV3Y216cnVMWTJrb01VZUtGdXhw?=
 =?utf-8?B?MWpod3dxalNVcUVrMUhHZGdQMGZRVldCSTBTOFQ1M0RIYVg0czJnc2c3cnkv?=
 =?utf-8?B?cG1SOTRVc0c3Sm1rK2FyRzZOd05aWWpTOWhvOWxaeEZjVTJmOC9BNlZBRVdj?=
 =?utf-8?B?bXVvTEMzc3dFWVNmL1lpdTRDWEhURUZYOFl3RnN2OGIxb1FxZzRsbXpTdXc1?=
 =?utf-8?B?SmZUWEtMWDgwR1R0ZTh5aU9Ua1FFK1pUUFBVNnB6Smt6SThZZUw0NjJLYjFs?=
 =?utf-8?B?UGprbG9Rd1hPVC9mZUZ5eWE0VmVHZWQ3WWU0UHRZRHlodTllb1JWWFFFd3ds?=
 =?utf-8?B?Wml4WSsxbC9uSG1DSGc5NkZPUXhhL2UwUlZ1dlk1UmJUdXJUMjFPVXcwTUow?=
 =?utf-8?B?V1hDbExxVDM3eEFXbE4vWjVyK2NNbUNyeGFJZlBocVNTaTVlNkxjUXRwU3BB?=
 =?utf-8?B?enJEZnFaZWNxbmhoWktxbzFnd1pBT3BjMmJzOUIvcnhuQTRtLzZKRVlsY1d0?=
 =?utf-8?B?Z0dYRzladEZFb1FiZm5xSGpjWGpHOXJUVkUzSDJiSGdwM3Z0enJCb2lnNk1O?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d54045-ab1e-48d7-bb10-08dadf17c173
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 03:43:55.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMuql+RhtMZH/QHF86EfsC8GTXE1f8W5TEjTMLzq4lGpZr14Usq5MsFwwcr30AxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5294
X-Proofpoint-ORIG-GUID: 7AZUBCXUvFWtqUCe_hXYl6RP6AvngC6Z
X-Proofpoint-GUID: 7AZUBCXUvFWtqUCe_hXYl6RP6AvngC6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/14/22 2:38 AM, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> The deadlock still may occur while accessed in NMI and non-NMI
> context. Because in NMI, we still may access the same bucket but with
> different map_locked index.
> 
> For example, on the same CPU, .max_entries = 2, we update the hash map,
> with key = 4, while running bpf prog in NMI nmi_handle(), to update
> hash map with key = 20, so it will have the same bucket index but have
> different map_locked index.
> 
> To fix this issue, using min mask to hash again.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
