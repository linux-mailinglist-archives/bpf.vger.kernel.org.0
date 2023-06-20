Return-Path: <bpf+bounces-2919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65413736EF2
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A50528108B
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E116425;
	Tue, 20 Jun 2023 14:42:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD65FC15
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 14:42:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7E172E
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 07:42:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KECmgc016499;
	Tue, 20 Jun 2023 07:42:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sDWlVwH/6fMyR5TckCTTI6N9j0ex/9giRzkhm1oD80A=;
 b=ADy8aWCeXz07c+JQsIdkm58m9qXsc1K8Un+OibWSYEBDOh5x0H1rDL/mTvK3x0v1lcsb
 yJbh9wzZKRoW8VPGnImZ87kdMIQiUjOvyDbUKbM84+zJGRowPLD+AlZD/3AUWBJMoYgL
 4p3EOaYdCQrfKCDhrLFX1/4XTKW02J/lURLXSp3HdZlf1yGz+Gjzs2tFhz3lGzYxENzl
 dCyQIFTf8zOfRLI0Z72/lDov8HTDL8H5dmVirN6bqH0TpBkor/TUC9meWJX5fUt5h0H4
 fIkZP4IVA/tVrsS+NXoM3w4Kw7SIa8m9Mnr4nBhC4ArEDfqrWvIJc01wGbKuQwti85vK Ww== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbdp3g72e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jun 2023 07:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSXONMVKmp1MhEmr5QYupnbw4ot7hj7pQk4NgHnTJEP8Y/Y7LsaVz6zvm0fM9IEO5AyeY8ww1VGHe36YcdGrFLEQLHC6/3PtRirn2cHfJGiVPx7YA1S04eXu+I1ACXJcNRbTI6+oRbXnDIroa8B1e89tsSjiDe+VptcEXWiWo2Nr2w0T0rZOKPL1HCqfyffPiC9ahQu1ZEKEf1OtYD6Z98EsfpZdKDa4wbK2FPlKm0K5HsO4oBtNW23MS2IhFA6IhF4tA4tfbzfultN2nOl6xnlvz6TY7gI/B4GwRYS25rG8V9wpkf3qWvXk/6INVBxTdMCRbcv9hh4wTOBgHAc2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDWlVwH/6fMyR5TckCTTI6N9j0ex/9giRzkhm1oD80A=;
 b=CNWFzJ6Q7YF99WDPXa/WvweyLOjqU6iXDmyycDUxdgYtJ5r3t6BSNXvnSckk0RdlONhPwLY/3P7lzTw1X9rGeTxNZM2y+aWxXa97TFogFpFW2NInTPoYm2Wh5zcUx6DYJe9CdM42fXcff6gq/Fn6ZAP4JGd14GiWtjNClEKHgsCX/988CCiqXUG4B9FNF15ARMMTIxFGy+oU7WA2HE98KtMVJPzDnXMIx7Xa3kZocc9Sv7+Dzh4UxK745zo0I7tE4bA9/OMr2sYEe53roglufJVWSnR9ZYewVxLsje6X6VepxUHJ0LhFaUh6EhxEX47e9SC+hQlq0Tw8sQJLxE5ZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5244.namprd15.prod.outlook.com (2603:10b6:303:194::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 14:41:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 14:41:59 +0000
Message-ID: <ab485aeb-be2d-5ce5-2c51-ec9603a8bbd3@meta.com>
Date: Tue, 20 Jun 2023 07:41:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 5/9] libbpf: add kind layout encoding, crc
 support
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, quentin@isovalent.com,
        jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-6-alan.maguire@oracle.com>
 <552caa49-5a88-7842-068c-36d105e8929d@meta.com>
 <92505f63-85dd-3fb3-9db7-9233d8f6e27b@oracle.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <92505f63-85dd-3fb3-9db7-9233d8f6e27b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW5PR15MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 82021a95-c89c-4a27-db3e-08db719c80cb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sc2aPFzt89GcN8UZwwINKGz69Mk+GykhWfzJu0NPWYV7LCyOwt7SmfhnJAvNCuq0tXLw7uGdkreI3ybUEgM5VqfV1FhURkc9SIHgVWKDcgDWnBwynck++cP8LWnlBk3rW6ZcQyX+8HaJBOe6QN9F07zzJ+hmrA1RE0OJjrKlYVU0EbYtVJaHC2v+78aCmOAjYgJDUMS+Si7Y9YYx9WEbbkz6gGjBWEgXqTfPxU6AROxAADv9fQA7wkwSlYBF2A7MAogzxQorY+l3unHD/9SD2LtTNgWD7Ehjh0BHIBLtKH1kmP94nLzkGIIqTYuYKDUT568SnR4JMrwR2lobICBmXdqBZdK4z2+hqq8oFpJ/Eyy/SYMyQ5Wg/7cXX+2Dy3JVVrIMnVcPU0K/JjK7F9kWbFeYLXsaAUCh/LM1GuoWfNfaACdmvsD6WA4wOny+c1GVDQk4nqgbvmYVakWopMljONnIuyewGH0rZJm9eZ1m4rm1dNvaBGYCOxpcCUCE5ooP6xRWz8ZIDauATZ5VclU4cJAo9UKV4p2+IJrjDMx0QW9FzII805ZSMQM/TzsSlEsdO2MIbfxKHCcoCnf3BlQype2cnOLGVkje5r/RHbEIRJYz9va/7FH2fTOeNsz2NWyOug2ZnsiCK9ekgfAvLqKoxQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(2906002)(5660300002)(7416002)(8676002)(8936002)(36756003)(41300700001)(86362001)(31696002)(6666004)(6486002)(478600001)(83380400001)(186003)(6506007)(53546011)(6512007)(2616005)(31686004)(38100700002)(316002)(66556008)(66476007)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHRXMWEyMUM4WWNiL3dNZEgzeDFHRkdmRVpMaTBFRy9wdkVaMUNEWjBpWmZE?=
 =?utf-8?B?MDVYV0VWdnVFYWErbEtSSStGQ0FoTXNtc3c2K1JDTXJNS1NyQU9UempLbFk0?=
 =?utf-8?B?dDdkMTAzMUt1QnJJRHphb1QrMWVMYTFuakhuSlZ5aVM4NHY0WjJsZW9ScjVQ?=
 =?utf-8?B?UytlWVhNcE01MEJhRDhBZTFnb2NOa1dobEZZWmE2dWVybGF4dEpCOU5Odmd4?=
 =?utf-8?B?cTdsSmYxUEFCdUxZc2NlTHQ4MXFQanJFZHhyN25uSUJheHZSLzRtcWpQVTFs?=
 =?utf-8?B?Y255ZElTQngxMHVsaVpTL0NURklia3M4RkVrZzRubzEyVFoxUWZoejdUY1lh?=
 =?utf-8?B?REV0dkFNeDI0UFZUZFJHU3VqWlBpQmtJN0xNTUFLNGEvK2FaK2tqNkxRSTN2?=
 =?utf-8?B?T3JoMFA1UHBMMDIzQ3dreEtzTXFTcmRZMllrM3I2RVl3NzdCTXB3c3RTWjYr?=
 =?utf-8?B?cXh6bW1NOEVPeDRTYmVRVHFKaGxlNWhGS2RwRXIyckExZEw2bjlTU3BXc2xy?=
 =?utf-8?B?VXZPZUNVSHA4VXE3SzhndXVVblBLcXZNUXdHRUUxbC9vUy9oL1FrcUdUb3VW?=
 =?utf-8?B?TGlHWWtqTm1hK3BNSE1UK1Y4cFMybE5ndENlOFdPaS9mdDNkd1ZRSWExaGZr?=
 =?utf-8?B?MnlyQnFCeVpkaWE2Uk9XVzVXbTdNdTkxN0RtSndIV3h5Rk5SeVYzeUJ1a3o1?=
 =?utf-8?B?T05LS3R5cm5DWHhDeFlzWlY4Mm42RkVHWFc4MGxPSWVjK0pEUi9CTXl4QmZR?=
 =?utf-8?B?S09WRk5jdXZlZlBUYWlBY2Vpd3RydEw2VElIZ3FOR0RUNmNqeWtQUkhPb0FG?=
 =?utf-8?B?eU4zQjk5YnUzd0NIZldySkVvMTY4dTVHaUdkMFdDUDUreEVpUDV6c0lxZTRK?=
 =?utf-8?B?c2FPbnR2ZnBsQ1M4ZTFaSkszNFJINDg2U1h0QldMRHlYbDVISXg0dUVsc3Jz?=
 =?utf-8?B?YU9GN0ZMZGthb01Hakg0QTV5WWxPbHBZK054eFFlcVVSSERjSkE3STRlaDhu?=
 =?utf-8?B?WWZHbHNLeC8vYnNuRzEvSFdPcE1XV1ppdXhITWVsQjFqNXhyV1FqeTE4MTZO?=
 =?utf-8?B?SjNFUXVidGszTGY0RTRxTzRFYkZUWHA5bGRiWWc0VHA3Y1NJV3I3b2paaVdZ?=
 =?utf-8?B?UzNmdS9oMGZkWElnZlBJVkFrZERLYmZYL2E0RDBXMDJaQTBScnhmVXJuNTNK?=
 =?utf-8?B?U0p0QnJ5UUNod20ydld3WFIveG5Jc1BhcEh5VHNrR2RLL1Z3ZE1qNmJnM0Zs?=
 =?utf-8?B?TmJWSXdCNHU4eitCbStyR04yc0krYkIyOVNPdFVvY3V4UVphMjlGSG11NVFH?=
 =?utf-8?B?aE0wWEl3WDB3eWFVejZuRDg0NDNxVjNReXF3R2NOYmVSaXNEUENNN3FRdGh2?=
 =?utf-8?B?TzVnWnNaMERhemp5SDlvNzhVbTdCRjNLUlI0YVhuQzQvN3V0Sk8rQXM4UEhC?=
 =?utf-8?B?QTBOakRiYkpHNFFWaXNRTkNJYUw1V3czU2JlajNhc1dWcUlMVjgxK2pPY08r?=
 =?utf-8?B?VE93Q25aSmplZjNmM3dHRlZMbjc5N3BGRnI2eE9LZm1oUjMrSk95Sm8yU0RC?=
 =?utf-8?B?a2c1bHVac0tYd1lyMVFhWTZxZlVKckFoQU5lQkpZU29yQ2NGUE5DUUVjOWhr?=
 =?utf-8?B?S09mNzFScFNLLy9zNmxXM05CbWJ4RTNBUDE0SXd1UnJuUjlxUGRESThFSFp3?=
 =?utf-8?B?Rkt3a1BBZVQvczJLaE5QVGhzMk5xUXlsQk0vdnRBTHRuSE1RQnhSdEk0Umx3?=
 =?utf-8?B?bTlIRUM0aG1odDZlYTBBaVBTNVBMcjJkTjFpdlJzRk1oYmFVdGd6WFA2Vi9o?=
 =?utf-8?B?bXVTMkJNZmpOcEJkVFdreG12M3NKVmxkU3ZTZnNTcjJzYkJyd2ExSzJXUFRT?=
 =?utf-8?B?NFJIMXRjeVpSUC92TXJBOW9yTEtvVlFGL3NnNkxOb0taYndJa2YwLzNpT3gw?=
 =?utf-8?B?R2VNRjhwL2FUVVlXN3ZPVS9kVGJMNjFYZEw4Nnh1ZmdzTUZITzY2em5CMThL?=
 =?utf-8?B?dEJEcTB3UGo4Q2QyaXNPbEJURWNtdGtud0RZTDVLcFEvbFhoZ2Q5K0QwbGRH?=
 =?utf-8?B?UENyQU1ETXVBbWkxUUVGeCtWZ3luWGFDejN4Mno3VE1aeEdGZllDUTM4dUl3?=
 =?utf-8?B?OGcwN1QxdDFta3RMM3RrdERpK0JKYnRPRVZZS3NWWnFOK2FRSkNBMDRGRVNx?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82021a95-c89c-4a27-db3e-08db719c80cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:41:59.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmycmduHWhn2k37RoAOUIzsbO/hvRaGQvKBTA4JWe7oOZkTWtIhj4fiXOUQ8K/D5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5244
X-Proofpoint-ORIG-GUID: MZ-qF6xNE1skuOQAqlvksHIr7Hh5U7jW
X-Proofpoint-GUID: MZ-qF6xNE1skuOQAqlvksHIr7Hh5U7jW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/20/23 2:09 AM, Alan Maguire wrote:
> On 20/06/2023 00:24, Yonghong Song wrote:
>>
>>
>> On 6/16/23 10:17 AM, Alan Maguire wrote:
>>> Support encoding of BTF kind layout data and crcs via
>>> btf__new_empty_opts().
>>>
>>> Current supported opts are base_btf, add_kind_layout and
>>> add_crc.
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>    tools/lib/bpf/btf.c      | 99 ++++++++++++++++++++++++++++++++++++++--
>>>    tools/lib/bpf/btf.h      | 11 +++++
>>>    tools/lib/bpf/libbpf.map |  1 +
>>>    3 files changed, 108 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index 457997c2a43c..060a93809f64 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>>> @@ -16,6 +16,7 @@
>>>    #include <linux/err.h>
>>>    #include <linux/btf.h>
>>>    #include <gelf.h>
>>> +#include <zlib.h>
>>>    #include "btf.h"
>>>    #include "bpf.h"
>>>    #include "libbpf.h"
>>> @@ -882,8 +883,58 @@ void btf__free(struct btf *btf)
>>>        free(btf);
>>>    }
>>>    -static struct btf *btf_new_empty(struct btf *base_btf)
>>> +static void btf_add_kind_layout(struct btf *btf, __u8 kind,
>>> +                __u16 flags, __u8 info_sz, __u8 elem_sz)
>>>    {
>>> +    struct btf_kind_layout *k = &btf->kind_layout[kind];
>>> +
>>> +    k->flags = flags;
>>> +    k->info_sz = info_sz;
>>> +    k->elem_sz = elem_sz;
>>> +    btf->hdr->kind_layout_len += sizeof(*k);
>>> +}
>>> +
>>> +static int btf_ensure_modifiable(struct btf *btf);
>>> +
>>> +static int btf_add_kind_layouts(struct btf *btf, struct btf_new_opts
>>> *opts)
>>> +{
>>> +    if (btf_ensure_modifiable(btf))
>>> +        return libbpf_err(-ENOMEM);
>>> +
>>> +    btf->kind_layout = calloc(NR_BTF_KINDS, sizeof(struct
>>> btf_kind_layout));
>>> +
>>> +    if (!btf->kind_layout)
>>> +        return -ENOMEM;
>>> +
>>> +    /* all supported kinds should describe their layout here. */
>>> +    btf_add_kind_layout(btf, BTF_KIND_UNKN, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_INT, 0, sizeof(__u32), 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_PTR, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_ARRAY, 0, sizeof(struct
>>> btf_array), 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_STRUCT, 0, 0, sizeof(struct
>>> btf_member));
>>> +    btf_add_kind_layout(btf, BTF_KIND_UNION, 0, 0, sizeof(struct
>>> btf_member));
>>> +    btf_add_kind_layout(btf, BTF_KIND_ENUM, 0, 0, sizeof(struct
>>> btf_enum));
>>> +    btf_add_kind_layout(btf, BTF_KIND_FWD, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_TYPEDEF, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_VOLATILE, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_CONST, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_RESTRICT, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_FUNC, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_FUNC_PROTO, 0, 0, sizeof(struct
>>> btf_param));
>>> +    btf_add_kind_layout(btf, BTF_KIND_VAR, 0, sizeof(struct btf_var),
>>> 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_DATASEC, 0, 0, sizeof(struct
>>> btf_var_secinfo));
>>> +    btf_add_kind_layout(btf, BTF_KIND_FLOAT, 0, 0, 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_DECL_TAG,
>>> BTF_KIND_LAYOUT_OPTIONAL,
>>> +                            sizeof(struct btf_decl_tag), 0);
>>> +    btf_add_kind_layout(btf, BTF_KIND_TYPE_TAG,
>>> BTF_KIND_LAYOUT_OPTIONAL, 0, 0);
>>
>> BTF_KIND_TYPE_TAG cannot be optional. For example,
>>    ptr -> type_tag -> const -> int
>>
>> if type_tag becomes optional, the whole type chain cannot be parsed
>> properly.
>>
> 
> Ah, I missed that, thanks! You're absolutely right.
> 
> There are two separate concerns I think:
> 
> 1. if an unknown kind (unknown to libbpf/kernel but present in the kind
>     layout) is ever pointed at by another kind, regardless of optional
>     status, the BTF must be rejected on the grounds that we don't really
>     have a way to understand what the BTF means. That catches the case
>     above.
> 2. however if an unknown kind exists in BTF and _is_ optional _and_
>     is not pointed at by any known kinds, that is fine.
> 
> In other words it's logically possible for us to want to either
> accept or reject BTF when we encounter unknown kinds that fall outside
> of the existing type graph relations; the optional flag tells us which
> to do.
> 
> I think for meta checking, the right way to handle 1 is to
> reject BTF in the kind-specific meta checking for any known
> kinds that can refer to other kinds; if the kind referred to
> is > KIND_MAX, we reject the BTF.

I agree with your above analysis.

> 
>> Also, in Patch 3, we have
>>
>> +static int btf_type_size(const struct btf *btf, const struct btf_type *t)
>>   {
>>       const int base_size = sizeof(struct btf_type);
>>       __u16 vlen = btf_vlen(t);
>> @@ -363,8 +391,7 @@ static int btf_type_size(const struct btf_type *t)
>>       case BTF_KIND_DECL_TAG:
>>           return base_size + sizeof(struct btf_decl_tag);
>>       default:
>> -        pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
>> -        return -EINVAL;
>> +        return btf_type_size_unknown(btf, t);
>>       }
>>   }
>>
>> Clearly even if we mark decl_tag as optional, it still handled properly
>> in the above. So decl_tag does not need BTF_KIND_LAYOUT_OPTIONAL, right?
>>
> But in btf_type_size_unknown() we have:
> 
>         if (!(k->flags & BTF_KIND_LAYOUT_OPTIONAL)) {
>                  /* a required kind, and we do not know about it.. */
>                  pr_debug("unknown but required kind: %u\n", kind);
>                  return -EINVAL;
>          }
> 
> The problem however I think is that we need to spot reference
> types that refer to unknown kinds regardless of optional status
> as described above.

What I mean is there is no need to tag decl_tag with
BTF_KIND_LAYOUT_OPTIONAL since for any btf with kind_layout,
decl_tag is already there. But BTF_KIND_LAYOUT_OPTIONAL is
still necessary for future kinds.

> 
>> I guess what we really want to test is in the selftest:
>>    - Add a couple of new kinds for testing purpose, e.g.,
>>        BTF_KIND_OPTIONAL, BTF_KIND_NOT_OPTIONAL,
>>      generate two btf's which uses BTF_KIND_OPTIONAL
>>      and BTF_KIND_NOT_OPTIONAL respectively.
>>    - test these two btf's with this patch set to see whether it
>>      works as expected or not.
>>
>> Does this make sense?
>>
> 
> There's a test that does this currently for libbpf only (since we
> need a struct btf to load into the kernel), but nothing to cover the
> case where a reference type points at a kind we don't know about.
> I'll update the tests to use reference types too.

Sounds good. thanks for adding additional tests.

> 
> Thanks!
> 
> Alan
> 
>>> +    btf_add_kind_layout(btf, BTF_KIND_ENUM64, 0, 0, sizeof(struct
>>> btf_enum64));
>>> +
>>> +    return 0;
>>> +}
>>> +
>> [...]

