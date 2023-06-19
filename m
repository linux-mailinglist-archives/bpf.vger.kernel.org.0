Return-Path: <bpf+bounces-2876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F69373601C
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 01:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EF11C20757
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD1DF5D;
	Mon, 19 Jun 2023 23:25:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0DC2CC
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 23:25:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736F1980
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 16:25:15 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JKWcwF021087;
	Mon, 19 Jun 2023 16:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=a8/cg9yijXxoo6DW2LYyb1LloJWM6tyfIaeNuC+EIEQ=;
 b=nR9gA8DvYA+9k9L0MTYPPhkqkk1aScaQhhpuldA9t12Q878gt7iKsQcqLkZG/5djiTvL
 CdPWo5VAkjhotijEvIqT+Mva57YCvPZ73QgyN+EI4t/ELZxcDU6wSR+MN7zIUDvDwbzD
 mRU6/ssWyETSiWraAnSpf/MA1m8MMuHmkpJkKatL8bECHPJJ/6EOGbmWeYh5AxycEVKV
 Unh1slT1DVgonWcoFr1xrjUE/S3eRCZx5JhfSR/xwx+c5jq/khRxTw0gC0WIS+yNO6iN
 oQ1JwxBN3z3H0LjiemMFrBIGoA/z1i981uzMCgvyjYdHKl8kmQ+yHCtCoEXwJ3eZhOSq 0Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r99xy7hvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jun 2023 16:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIOWOOSV/Wq0M91RybV9hOlS3rXe17pC+fJJQcQOO0l9GEWysN/92o/HzG7KOrasZuV+hYrb3OIJnIA0X7oZH70UjrBeTlS1tfEifUSuyw2z9KslVZjpdxye/PJ5SGs3XJ2ARN1nB3MeQusTeo+RJG8MzycF86Sx5EF9VbGZPL3K8YGAChe5AkPmVM+mgSHOC5Le0P9VKqfBQ22xeC+EkjKI+Y/atO/wvXmSL+LRGQ7albDJXOoSUPa2V3OaWYqBB5cd9eKF5Zx8jDspvQCo2LRoW15MuNJUckfnEqjFLciV8SYAaJ5Y/l4enyfI4bu6mBBDHaWJ0FWKfs5IFiNnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8/cg9yijXxoo6DW2LYyb1LloJWM6tyfIaeNuC+EIEQ=;
 b=ilCiNZSsU+HXZqULLfeh75gm80V2BgXIzhQWveB2Zh0ZwxmzmUW9wR9jFLb03v/cUtYl31kHBz+16UrWWWBVKU4Bqmb8XL8pRsSbwEXPWB8nLfaO2n7jm2E/lIQtWrT2I2PaiRLpLM0O/VOyVBo4rv/tku92g0WnuzwJMoXR+fXOi2e3oUCdzD47FtKHEUZ5dp/J4/ta/JmVqXjQY1WfwsjJWK5s9P2hssU57VDRZL99wtJAJsifCtB90Q3gDmgjZYTqcX94WRo6Lmtn06LMwKsQOZoWJQVgk02kWSZviSGDDJPDSQdJkHAId2wfBi8z/DEQV/hzCXgAHB/rk/4lTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL3PR15MB5388.namprd15.prod.outlook.com (2603:10b6:208:3b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 23:24:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 23:24:48 +0000
Message-ID: <552caa49-5a88-7842-068c-36d105e8929d@meta.com>
Date: Mon, 19 Jun 2023 16:24:44 -0700
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
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230616171728.530116-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BL3PR15MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: c533c6dd-729d-49dc-e11c-08db711c5fdd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bfyAeXFAuPHq9QIcrax6PI/8zSjsTsyUpZ6CRlbuKNXoSkp+JtBeDi3azwHqaLxwCkNGpZhRDMOBP3+xJxyetkSp1riYGekivfib/2vJ4lCHG5E8ootA0AJPND6AAikPFXuVpWdLSjVzhN5lkECPEvI8AgZdcAfl+zivBO8smGNm2tKdSgTPkif5rw09HAX706JkYQmxp2t6uMXVXNtVNdJJcGYUuWenPiscGOMWewFHl84hTYs4y+jAhXyIQ2Cj8OLAXABmTZGmf8BkPLvHLXqAIoHuwKONtx4pARYgkD0zarR7IvwdXtlGzTP/MuPazYBBF//GWfICrA1s27vP5+78UdMA2C1KFz20baldB8CVSqmn/ti56NQqX5nqLFDYeb3obcVLk2WdKDQ8xeYZAreUUXcXXuQ0DPGgcbLBrVCwb2MwAvthaQYJ9ATqLTaqBAaQo1PsJ0wxpi8xlX1NvH3fZXvJL8cYNiwciO6SGeZzJaqi4HtBeGU/dwVH9Ia86lJWw09k0dZcS5outbfoCEFUs/3Z/SDQNFJtnBoW0q2QeDbVl2H9mpmk+xOoEq1iaZUIFWU0lp4++eYx4FzPn+VCYAr70sTvVdp+JgsddvmT+jHfItFFU9xHJQWDcYlhBS9HHptnyesY9Ao57DWyMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(66476007)(31696002)(86362001)(2616005)(2906002)(83380400001)(36756003)(7416002)(8676002)(8936002)(5660300002)(38100700002)(53546011)(186003)(6512007)(6506007)(41300700001)(6486002)(6666004)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGpRSFUvQ0JNU2RCOFY4Yk5kMGRnb2lWTTVtMlNKVWYxSTRMejZNbjhWOXg4?=
 =?utf-8?B?MzEvOXNTRjYxZkdFTFd6RDZYOVI0WnkrZ0dKOElLMHZ1dmROUkFBYTZvYk1Y?=
 =?utf-8?B?bTBFSlVrTGVVT0RKdWZ5ckRteldzVWpJb1djZzFyMkJ2bmFKMjEyU2hkQ0Nr?=
 =?utf-8?B?VEVxL3NJT0dXNXVFeC81eUdpMEZ1Y3EvRDRlU2R3OXp5U3l6aDE2LzRkV2Z3?=
 =?utf-8?B?ejNGbnFGc1pnR0RWeGhuM0RPWjF5aDRveTk0cnh1TUxKMVVpUWRpTUZhVmRq?=
 =?utf-8?B?MGlpYmprYWhzZFVuak9PWXVXRXJRa2d5Ty9ST2hxUnA2OG5RR2txRzNWeFNj?=
 =?utf-8?B?UTlidnVIREpTT3RyZ1kxbVZ1eTAreXRDcThuRWd5YXJPUzRnYUR2UmNZQlVs?=
 =?utf-8?B?K3g1V0QzN2M0NkpxVnMrSDlNWTdHQmNNQXI3Q21RcXAwbG5wQW82Q1dTVExm?=
 =?utf-8?B?RkNUK2twcnFYTC9EWEFFZzBKRllCc3dYbG50SThOMUs0cVNxQkIrMUJ5SDA2?=
 =?utf-8?B?VHIwWWR1SHdGc1hJNlBEejI1eTNWbWV1cjVaUnlxcitURU5yRjRucEFxWnBk?=
 =?utf-8?B?VjFJN1c0MjZvTG83UDBQTlBsWlg3MmV4cm1zbVVMYkNHdllQNFdoYXVETzhv?=
 =?utf-8?B?bFhQZll0M01SZ0ZJK0I0QmIwdVFsR3hlb0RNOWM0SG4yMXFscGpxMEhoK1E3?=
 =?utf-8?B?b29PdTl2WEhkcVl0T2cvUzlLdEsvb3RMNHNpcEJiNmtNczl2amgzSmo5UXZO?=
 =?utf-8?B?c201eGwrOHRUTnRBVXdsMk5zdkJaMm9nNTNKRmFuRGpUb05TWG5IbFdtMFVt?=
 =?utf-8?B?Q2ZzR1g3SHhEK1VHUnRJTmptaWJ1WWpVdmVkTFJRaTEwcmlDaHNGSjdVeWp6?=
 =?utf-8?B?MmpoYU9HVXhIc3B0cTFwYVdmMTlSSFFQVGk0SjRTY0VSN1JlYlFCaklPVSto?=
 =?utf-8?B?M2IzNzg5eTlNZ0xRQ01Mczh1bUJPWkFRamFkVWdSYkpKYzIzdDlqbTEydzBT?=
 =?utf-8?B?clQ4am12ZXpBcFBNRlkyL28wMnJRODJ4bkVQeEE2cU9ta3Y5QjNtR1RnSkdY?=
 =?utf-8?B?cGw0TTRKVlRwMEo1MGFydjdlbzN4WVJxQk1UWnB3TC81b1lnT2EvZnJPOTEr?=
 =?utf-8?B?bWJjcHVPZmx2aVJGVDdFbWRQT3JFeXJIenljVjdnRVR6WmtwdXR2NGZBcndv?=
 =?utf-8?B?YVIxa0JpYmV4eU44dWlQWEhHenBVOVMxVHd5dVdEQ2wxa1ZzcmlzODZBdVBR?=
 =?utf-8?B?R1dMUnMvRk95Qy9ZV05SUU1wcGlZVUIxRHcrT3laTi9UOUJUdkVlUW8xL3lr?=
 =?utf-8?B?dEg5YmhDWTdhc1psaWVKdkhmM2RvOTQvNWdvaStqQ0RCSHRQK3FWVkg3OXJh?=
 =?utf-8?B?bFJlMmZDV0FyVjQyU1p1aU02cGRCdkRkY0kvdjZEeVhrRWEwaitoYnZNTGNw?=
 =?utf-8?B?bkxYMmVRdlpTNnovZEtQRktobEhYTGdYSW5CSThQVCtNLzlmUFJ0QnFaYU9h?=
 =?utf-8?B?Z2hNeTdRaHVCMjRtOFczQ2txZVh1bWRaQ2VxVXhSVFc3QWRtV0IvTlpDbDFE?=
 =?utf-8?B?L3o0Y1UyeG53TndXZTNzamk4SXRYWWFOLzBoTXMwOVJCbWs4alhDN3RXbStO?=
 =?utf-8?B?cTNRM0R0RWtkSHVsS1h4TkQwTEpWSmZhWWszMkNKb3Jtbmo2cVQ2czlXWDJB?=
 =?utf-8?B?L2o2ZVV4ck9RdUluT1FsbUh6MzRZQi9pN3Ztd3pNbW1FdGpHYnUyWFhmUE5o?=
 =?utf-8?B?ekM0L29BQ2FsOXBHS3pwcGNGZXN0YXg2VndHbWNPdTVzSXpyajVTUCs2UXdp?=
 =?utf-8?B?cDk4U3o4aWozL0hBZWZ6bVFDYmFHUmJFSVJPb2ZMTDdmSVlWVzhUTEtuVytQ?=
 =?utf-8?B?bDJud0pKVCtvamxudjdnQTArMG4rTkNST0ZvT0d2cy9VQnpDTnFBL0QxU1JY?=
 =?utf-8?B?bXlYYU9FeGpPRkR1WU1BYU5RQ1ZzZTBhYWZWUXNoUE83UHdtWnY1ZEtuKzVy?=
 =?utf-8?B?dCtFMWtQUzBBM1F3VkptZXkwS1dJNG9VZjc5MCtDVUhiTTd1SlNwR1N2Qkdi?=
 =?utf-8?B?azFWcTJWWDRyeGQ5Y3pEK2FoR2JMOHlDbllPNjYzUDM4eWFhNkFDTkc2b28z?=
 =?utf-8?B?SEJxSDhjejdGRktLWjdVbS9idDJ1T0IyREs0ZXpjbEpFVnpBenpncHlMaTY5?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c533c6dd-729d-49dc-e11c-08db711c5fdd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 23:24:48.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecv6YK0OZE4jKmGEyx5Zthab1BhqYg1onKS/nvTdIEQpQNVlcTi/yUyfEUA5zrbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5388
X-Proofpoint-GUID: OF0D4yCOBqE5R1sVl2IDA-aLhmtVAZGk
X-Proofpoint-ORIG-GUID: OF0D4yCOBqE5R1sVl2IDA-aLhmtVAZGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_14,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/16/23 10:17 AM, Alan Maguire wrote:
> Support encoding of BTF kind layout data and crcs via
> btf__new_empty_opts().
> 
> Current supported opts are base_btf, add_kind_layout and
> add_crc.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   tools/lib/bpf/btf.c      | 99 ++++++++++++++++++++++++++++++++++++++--
>   tools/lib/bpf/btf.h      | 11 +++++
>   tools/lib/bpf/libbpf.map |  1 +
>   3 files changed, 108 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 457997c2a43c..060a93809f64 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -16,6 +16,7 @@
>   #include <linux/err.h>
>   #include <linux/btf.h>
>   #include <gelf.h>
> +#include <zlib.h>
>   #include "btf.h"
>   #include "bpf.h"
>   #include "libbpf.h"
> @@ -882,8 +883,58 @@ void btf__free(struct btf *btf)
>   	free(btf);
>   }
>   
> -static struct btf *btf_new_empty(struct btf *base_btf)
> +static void btf_add_kind_layout(struct btf *btf, __u8 kind,
> +				__u16 flags, __u8 info_sz, __u8 elem_sz)
>   {
> +	struct btf_kind_layout *k = &btf->kind_layout[kind];
> +
> +	k->flags = flags;
> +	k->info_sz = info_sz;
> +	k->elem_sz = elem_sz;
> +	btf->hdr->kind_layout_len += sizeof(*k);
> +}
> +
> +static int btf_ensure_modifiable(struct btf *btf);
> +
> +static int btf_add_kind_layouts(struct btf *btf, struct btf_new_opts *opts)
> +{
> +	if (btf_ensure_modifiable(btf))
> +		return libbpf_err(-ENOMEM);
> +
> +	btf->kind_layout = calloc(NR_BTF_KINDS, sizeof(struct btf_kind_layout));
> +
> +	if (!btf->kind_layout)
> +		return -ENOMEM;
> +
> +	/* all supported kinds should describe their layout here. */
> +	btf_add_kind_layout(btf, BTF_KIND_UNKN, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_INT, 0, sizeof(__u32), 0);
> +	btf_add_kind_layout(btf, BTF_KIND_PTR, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_ARRAY, 0, sizeof(struct btf_array), 0);
> +	btf_add_kind_layout(btf, BTF_KIND_STRUCT, 0, 0, sizeof(struct btf_member));
> +	btf_add_kind_layout(btf, BTF_KIND_UNION, 0, 0, sizeof(struct btf_member));
> +	btf_add_kind_layout(btf, BTF_KIND_ENUM, 0, 0, sizeof(struct btf_enum));
> +	btf_add_kind_layout(btf, BTF_KIND_FWD, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_TYPEDEF, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_VOLATILE, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_CONST, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_RESTRICT, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_FUNC, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_FUNC_PROTO, 0, 0, sizeof(struct btf_param));
> +	btf_add_kind_layout(btf, BTF_KIND_VAR, 0, sizeof(struct btf_var), 0);
> +	btf_add_kind_layout(btf, BTF_KIND_DATASEC, 0, 0, sizeof(struct btf_var_secinfo));
> +	btf_add_kind_layout(btf, BTF_KIND_FLOAT, 0, 0, 0);
> +	btf_add_kind_layout(btf, BTF_KIND_DECL_TAG, BTF_KIND_LAYOUT_OPTIONAL,
> +							sizeof(struct btf_decl_tag), 0);
> +	btf_add_kind_layout(btf, BTF_KIND_TYPE_TAG, BTF_KIND_LAYOUT_OPTIONAL, 0, 0);

BTF_KIND_TYPE_TAG cannot be optional. For example,
   ptr -> type_tag -> const -> int

if type_tag becomes optional, the whole type chain cannot be parsed
properly.

Also, in Patch 3, we have

+static int btf_type_size(const struct btf *btf, const struct btf_type *t)
  {
  	const int base_size = sizeof(struct btf_type);
  	__u16 vlen = btf_vlen(t);
@@ -363,8 +391,7 @@ static int btf_type_size(const struct btf_type *t)
  	case BTF_KIND_DECL_TAG:
  		return base_size + sizeof(struct btf_decl_tag);
  	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
  	}
  }

Clearly even if we mark decl_tag as optional, it still handled properly
in the above. So decl_tag does not need BTF_KIND_LAYOUT_OPTIONAL, right?

I guess what we really want to test is in the selftest:
   - Add a couple of new kinds for testing purpose, e.g.,
       BTF_KIND_OPTIONAL, BTF_KIND_NOT_OPTIONAL,
     generate two btf's which uses BTF_KIND_OPTIONAL
     and BTF_KIND_NOT_OPTIONAL respectively.
   - test these two btf's with this patch set to see whether it
     works as expected or not.

Does this make sense?

> +	btf_add_kind_layout(btf, BTF_KIND_ENUM64, 0, 0, sizeof(struct btf_enum64));
> +
> +	return 0;
> +}
> +
[...]

