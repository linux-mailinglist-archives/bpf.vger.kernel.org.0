Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE70B40FDDB
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhIQQ2V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 12:28:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24042 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229925AbhIQQ2U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 12:28:20 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HDlRk2017643;
        Fri, 17 Sep 2021 09:26:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o2uoq+9C5pFMFbj2iMwSmoSLKc7DxDh6UkEkeWr1hBA=;
 b=dgt25x/jwhfSZ4iGnkI3zUNT0AD8BopxXcdjV+bKNBJPyefviNUdogS7DUoD0d3IIdXk
 ynGsJ+yu3sE0AcZ+QgqKFRR2M/83lBijgkqZjZO5qvW2bKaa0Y50tc0XmygZVJwCDyFp
 Y38g/7z6AZE/KKUywu+plVTOfmnJE7kuex0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4v76h3h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Sep 2021 09:26:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 09:26:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkbR5J6b2IxL2itHcMx7j9RwQ9b7w8BB4q8yVsatHC1tpGQRwoErYGGHNIPa794hcNqnMERGDTnENF5ks0aisxkYZiwly3JCFtr4yXQiJWhj5UUBmWjVFZanWFa6v7UWgfhm3czjKbdN9TnrLaz7v9C3R/8lXcsdk3sPegRHFuQZsVHz6WUp2CHiq+eNnzNIuOsKUkiTXH6YDz0DCZa3XgeRWsmdXt/xQhAgyi1KKXTPU+kD+32K4uR3jIEq7gWsGQL1Xy0ZpPVV7A+rlG6uv2bzhpwsvdoF2/IsoXJPBfqtS2yLu4PzSMCQdJJ6ti0nJmy4tm5+7bOxA+h73jA9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=o2uoq+9C5pFMFbj2iMwSmoSLKc7DxDh6UkEkeWr1hBA=;
 b=jerBWtkd5BKAYZwVO+xwrfpTEQsaX2PZhWjR2Js//TQBUqC6/RVC/wZii68RSPSkI1lRYNfva+Lw+1/WwQDPzZCXP+IEAoKi7PLf9YWZ/DKT0OwczGJakxHG5EoFvMJZcL4yT2XNyhHgstZpO+njFHfAi0EA1F9AFZNBm1PeUAYU2mpr7va5N1T5D5xGp1Tbx8ZE9+RY3knQJ8iPiC2Wg5QyVE27S26y4KW9GabYVtbxKf8x+wB8Y7Aq9jQy0nx8MPOFiNKaLuLhgaAiMlAPJfyweAIy9Cn0BFAwsfqUv3ZudN39bixu5xB1aYAfSIuzGyqW/FQRnfHxLTJR7bg90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2254.namprd15.prod.outlook.com (2603:10b6:805:22::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 17 Sep
 2021 16:26:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 16:26:52 +0000
Subject: Re: [PATCH bpf-next] libbpf: Add doc comments in libb.h
To:     grantseltzer <grantseltzer@gmail.com>, <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>
References: <20210917152300.13978-1-grantseltzer@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a496743a-fb65-0a29-bc2c-49cba05a023b@fb.com>
Date:   Fri, 17 Sep 2021 09:26:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210917152300.13978-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e8::1426] (2620:10d:c090:400::5:ad12) by SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend Transport; Fri, 17 Sep 2021 16:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d03234-cd67-4cfb-3dcf-08d979f7f4e2
X-MS-TrafficTypeDiagnostic: SN6PR15MB2254:
X-Microsoft-Antispam-PRVS: <SN6PR15MB22547EF0CF4E63CBCB83AD8FD3DD9@SN6PR15MB2254.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMNeidaCXInnrbJu/b6H0QBR1PGM8vv/F57A/SNvTTrZKDc75mtaP7pnnseaYk90BnC4iHxXKUlLZM6irlnS7sCvxTr4IzfHoU9/PNgulLQB+gnTmj4s/Qr3cfwaZC/MmSg3Hb8AIS3sscDqL8i3Y4qFwK7cijuAUlAR+XaparLr/zOloq877pgoEj86jl20J8KZZz3Q2tH49YVFPbqO+KoMzesP0TwVl1H/z0mcgSXMcuXStNmanb1I89e4GR/ThUpPr+sMJ1Vc+DgFMcbmbVqpQN6a0kub6JZPz3Mq7fuoAV0ME2yggHMDNVJxvhYioSxLRxQTRM3pdYAdmESyy3z08bhrFu8noLNurV+4EePXNQwLUAK1vd72Fg518iKCxKSF97MLZAQFIOW0H895A1apo/cpYidTnUABGoPfaFSWjOBqlBrzhIfEa0/aMzKyJbo9/W4LOmd9ygNwXZEpPpiVZxhKQOPTY8x9dVGxKUSkjwZ9yKZtprzzZ+O+xGyWXrvXeHzpHAO0gH60FHd99CsmgHIEXrPhmPogcTMxr17Kn9rPGAuIbz8+WiAamyVjURYDCms4ga5qaWpDHhVDGpq6KXJvYb0sl+67QPbnI4SeC7dUibxORBSZ6UE9bxLj/aaF5sgsKH2vqx8925Mf1fZFLpCGNHwKaddCjQKqIV6KylopkTVpPz9cwvFWu7z6ivbZQkfWpg1qKrggA4owoRE1/gew0s/fGZ2zTYs0TDi4309JXsEoJx7mCcCecuey
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(6486002)(31686004)(2616005)(36756003)(38100700002)(31696002)(508600001)(8936002)(86362001)(52116002)(316002)(8676002)(186003)(66476007)(4744005)(53546011)(2906002)(4326008)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWduVitIRy9zamVMMG5COHJab2twYXBWT3oxTFFBL2FqVkVBdk1qd0xDSjBC?=
 =?utf-8?B?RVJabDBIRkhKeVBOTEpVbFVSb0tsOC8vaklhYmphUkJ6aDlRVmxUaFVROUov?=
 =?utf-8?B?Q0U1bkI5WFBlb012UzlhSHRnMDRsZ2REMWpES21JT1MyRVVESFhISDNPUlBu?=
 =?utf-8?B?SnFzWC9Ld3ZvOXowQUNlMFhsenNBVXdJR0s2aU9JZXZlazhxdWhHcUZFMHZT?=
 =?utf-8?B?THp6bUJMVmNVQlR3YmdOT0R3a0hlRnhDRUF5ODdhZk1wWEZiV0Ywc1JrVzdX?=
 =?utf-8?B?VkJFWU9hN2xxdEYwUkJ4K1JTRG5Tb2JXbkppTG1WRVE3ek5ZaUw5M1Z1ZXlI?=
 =?utf-8?B?MDdNa2xUTU9MTm0xaDBtNW01cjFiQWhSSXVWdzM0ODQ4eTFDdVMrMFBacHNW?=
 =?utf-8?B?Qks5REErNUlzSUFsMkFXNXZLYnVWbHZyS0RVelpVT29qOWxrcGtKaVBGNHdW?=
 =?utf-8?B?VHNSTUNiSzYrR0xITmNGQkNYZ3dsVGZKYnJBaE1FMFVqNFh2NGlkUXVJalRJ?=
 =?utf-8?B?NldaOGNuNmgrK0MvOWhyWGxJeEwvaVhzQjlObmNScFYxUjNFQUNYZ0pKVXNT?=
 =?utf-8?B?aS9WOE5FU1NjNkxwZldsdWNIZGlTeGwvc3RWVjUvdG1xUHVhQ0laL2VyNEtr?=
 =?utf-8?B?ODcrZmdvTHNjUkFLcHlWdEdURUZWUitvM28yNWVZOGpjaTE3RE1UY2hpRU5m?=
 =?utf-8?B?OWlYYjF3czFpOFNlVW5oL2Vvb0p2WFlCTS9FWmx2MlFzalg0NjVIdzNySkxW?=
 =?utf-8?B?WG40NGg2UTNpVGwxU2FDcFBLUDYrUk9xMkVVdWx1SVRZMy9MTDkwbklMVVRM?=
 =?utf-8?B?djVyK1RlU3VsVjZ1aFNhamY4RjVpK0tmc0U0TGI0d3JneGNwWWJ4YTV2MDZv?=
 =?utf-8?B?MjhZa2NHcG9ITTd3alhVZWx5aEQ1M1VQVk5UK216Qm8rbXdOdkRmemovUjkr?=
 =?utf-8?B?bFRKd2FERi81djBwSXN2ZXM3VHdiWk9YNWdmT28wVkR1ZFU3cDlQTUFjRFU1?=
 =?utf-8?B?UGpLMUZnMDA2OGo1Z0lNRjdDZlFIS1lsaXUrWktuaHhDVTJOWFVDZHRBdldR?=
 =?utf-8?B?NmorbUZQVzd5eDNUYkRPQ1RJWDdoR1BsQTFmY0NmOFJhTkkxM0xmdlNGTE9n?=
 =?utf-8?B?TEVrRUhydEc0TmxwQmNkTk5CYkpoZHlNTkxWaFFYR1c3bXlXNXFEak5uR3dY?=
 =?utf-8?B?WE1rM2Izb1c4aFdXeHFQdTNJbEZIRXF6L3diQTJaeTF4Tm5CSUM5clNSdUND?=
 =?utf-8?B?aENzcStHZkJCUHlNTkNpV0M5K3JLaGE2SnhlR2xpcERuaERVU1llNVpDa2hm?=
 =?utf-8?B?Q1dZblJWR242TExIMENGTUxvZVNvMmw4RkJLQWJvNmNaYnlsTEpDR0lHVGVu?=
 =?utf-8?B?M0hjU1E5T3ZRSVEyV2svdlBiRXNMMHMvWUxES3RDU01raFVZNld4TjFXdG1r?=
 =?utf-8?B?b2lFUDNsUTVtdkJxQWVzeStCWnUyR2hLdFJTTWgrY2pvcHFmdHdNM3dIKzhM?=
 =?utf-8?B?U3RIQUR6aTVhdHV0S3JhVzVsd1JCaW1jbFNtdzFwNWJ0aVBKY2l1Mkx4WFB2?=
 =?utf-8?B?dUJDTHFBWlRFYlQyTDVpRnhnNkg0eFBIM29haDUzN1lDZ29CNjgrdWdJcXNl?=
 =?utf-8?B?b1Z5b20vMGdXQVN0cGR1NVI3SDhXMHhhUzFwajRqaFBsVjROV25iNk4xTExX?=
 =?utf-8?B?SnljVE0vN2E1Wkd5ZWcyOWo4Vzk4bENEaklCS1dhTFJ5SkR6UWxzbE05UjBZ?=
 =?utf-8?B?QTdoUms2SVlNMFp2cENHMWdzbkdxajU0VU5vUVZwdnk1Z3J3bEc3MHU2L0RL?=
 =?utf-8?Q?JHvok8ZteA66SVovVea+ieTlhCEu8lwZneqT8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d03234-cd67-4cfb-3dcf-08d979f7f4e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 16:26:52.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9cCJcCy5prh3QSMkZClGC/rTCOkCKyyzEOKvWC07ASc+M82RYUDoWuPTza1JGnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2254
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: kJ3C3mcLi_WttPZeT4n5y5LQWY29MB3T
X-Proofpoint-GUID: kJ3C3mcLi_WttPZeT4n5y5LQWY29MB3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxlogscore=895 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/17/21 8:23 AM, grantseltzer wrote:
> From: Grant Seltzer <grantseltzer@gmail.com>
> 
> This adds comments above functions in libbpf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org

A typo: subject line "libb.h" => "libbpf.h".

> 
> These doc comments are for:
> - bpf_object__find_map_by_name()
> - bpf_map__fd()
> - bpf_map__is_internal()
> - libbpf_get_error()
> - libbpf_num_possible_cpus()
> 
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>   tools/lib/bpf/libbpf.h | 58 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 50 insertions(+), 8 deletions(-)
> 
[...]
