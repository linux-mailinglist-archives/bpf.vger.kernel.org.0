Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912CA4815C6
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhL2RWe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 12:22:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5680 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241070AbhL2RWd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Dec 2021 12:22:33 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BTHDli4003107;
        Wed, 29 Dec 2021 09:21:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qt4YIKH9Kd4wwHEvqNvdSCjm49L0qmY5ES0ufZO4bjs=;
 b=ImQn5OAmkLxe57u+CnUrNEal1alYvA7UpCs4iGbuUUXWB+Putic/yG6vywMhTdfCI7GK
 gLQ3ccQn22hvGh0i7wCMFf8xPg6FdG6+ySMaWnAgYOSzzcn9Jaao26kMlnbOqaXIQ/E9
 OSWvPVebxCy9ZP97rSsArdqc45Gfd0GW7ZA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d8evtc1ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Dec 2021 09:21:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 09:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD1MVjDJVZ8qyEFWxp9LNeBPa+tb4zR9s5ayHfSXU6D6d0PJ+Qr9D+km6gV5k1fVPgWZhdsgZY/UYUICPuX7ACqKCjkYlaqeWdUcFtZRiHGFIATJE3QA0J4TRReuk6y+4RQu7CP+6dPoF+6Dt1SQHnbfsA1oZOTH0T+3Eli/nSe8Hcm3Ovg25QTLqU9AfJR9uxrFjERRQ/zJbf5F8KIWSlR+kWEakkCfRF1VHBiMnBye+mPjppp/oArnkTgpZGkjojqTPdy3Uiqs6htWurflCqn/VISuwr4Fj1Ne0SvyMMJmhHFPhUOFVtIP3CuAcMtSG2Lep9u+K2GjYKWVgJPqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt4YIKH9Kd4wwHEvqNvdSCjm49L0qmY5ES0ufZO4bjs=;
 b=Cyg/yfnuYKK9glAkAJRd7ywGieD4b5womnbyMZfz8JRB6LVBCDO/Lkzu7SnZTYcn65gr3iLDHs4/qcFAOI9ZJXhDqC3UOdFLqGuIgj6EHqLzYdfNUUI5jChnA3aEppilDbF77mG+iiU/0a3/nHl5QE8qNWE0hy2jvWddLO5tN11vK8iqzFxHFlISTjN2tVm2u3A5xTnWSjbcgsm/tAUlc4mERwcwyA1WeP+55sL6zkLDRYq7xcH6QzesFODWNPkCX21Kzg8j5op4XMVi/XoHIj4L9EAcNWigNCly17Q6kvvTKbP1XBgxxNNF8xMGTUs0veQqtcFtg2HIbQ18DC0k5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB5014.namprd15.prod.outlook.com (2603:10b6:806:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 17:21:49 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%9]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 17:21:49 +0000
Message-ID: <1c8f6a26-658c-8986-2186-7e1868850cc2@fb.com>
Date:   Wed, 29 Dec 2021 09:21:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2] bpf: Add missing map_get_next_key method to bloom
 filter map
Content-Language: en-US
To:     <tcs.kernel@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <bpf@vger.kernel.org>
CC:     Haimin Zhang <tcs_kernel@tencent.com>
References: <1640776802-22421-1-git-send-email-tcs.kernel@gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <1640776802-22421-1-git-send-email-tcs.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25595c84-82aa-4876-81f9-08d9caefb2c5
X-MS-TrafficTypeDiagnostic: SA1PR15MB5014:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB5014DCA3B695FEA8296BA6D8D2449@SA1PR15MB5014.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inHL0h1uO7m3nbm24WqUvW+1+QmPwhdUSgg5OabhBAsKoFd97kQCzaICrl/kHujVO7nHfbjaHtH5GMjXaYAi1zuocaV/J5ootvr3dcldzPF420znP68iDZxhl1G6H3SwHju094+rc8bsaRFWSwnOwfu8gyL6W6m2z1tPLcinpm5jJszj9q295IdOA+fnjk6N9+kVjt8ip3sCho5PMCAOxq09MupKSE7pnOOuwVDMvukADtYNq7aj0VZLGpmax/YD05L8qCg0OUoIi3jdVP3Xpf3OBeyP+B7ObWLaRqv3sQcVcWxBTbYVJbuOgfZFNNCTt0evnKV9XA9EkfCK5tqV5Fzc+4I8zhcgDuoCMoHdq3kZrRKjrHcrFfbn41OuDCcLdpIxApfmCtQKhkN0wsgB9zEloVrSR82j9rC8CyBoGDo4S1Ljim+cuCwA1K8YSnPCbR/ziT0ifXj7l0pzb3gvnCpIZJsyaHdw/M21DDfaA7bDOwyYHYFzvkPT3Qx8JHjMObksTSm6uNed/8Na9VLCvK5qD1mAUFDtSj0GcBuhYYn+XUxQ1Ea6iKML4mv5WDUmrVtqdVM4meNcoZ7VMxsu2+qViXBV2IeqAGmMon+eN/tMEkRS8sLNi8/U2qiVvgVY6BNT+yV0NfRzhmgJlvwvkC4z+gyZBsgIkCt9NoeCAcfdO+4EwAbic/kqjIm/ev+4aWhkWRtatWdvX/05kymvHBXSQBKJfNBKvytH88CV3liCeYeUSEPrF2kXUy+7E9EM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6512007)(66476007)(2616005)(53546011)(6506007)(66946007)(8676002)(8936002)(83380400001)(38100700002)(36756003)(4326008)(5660300002)(31696002)(921005)(6486002)(86362001)(316002)(31686004)(6666004)(2906002)(66556008)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RXZzExdEg5a241N3hjUlZzcU9YT1pEc2tFdzJKbUxETXkzVFVLMkh3bXVG?=
 =?utf-8?B?QTZoR29DTUV1L3BTckN5SU11RWxsejRWcm9XdDEyQUJmaDM4RUdBQStiakdh?=
 =?utf-8?B?T3RObDdkY0pWYldoWEczVkdIMHhqdjRoMEJJeVpjMi9CTFF6WE9vU0FFaGxG?=
 =?utf-8?B?cjVoVDRUSUpSVG1tamlLMWxsN0d6MU5vbGJST1NGMTZ4bHJ4d29RV3NzUXJC?=
 =?utf-8?B?OUNwR3d6N24rYUo4M1U5UTV6QlFjTXorNWlHLzR5S0wrSjNQb3d3dmlEVFdn?=
 =?utf-8?B?RkJYb0ZFdlhIanRBQ2JXQ3oycGJwSXhaRXBGV29PRndNeURESXVYQmtISWVl?=
 =?utf-8?B?L0lHRXRsdE1UY0thSWxIT3VJa0hjN24rUGgyY01rK1RuanN5elY2YngrS0M4?=
 =?utf-8?B?TjkwR3FXOC9qL1I3Y0prWWhyUDdPbzc2NGN5Z2hHNTM4M2pGMjUzbVB2L1Va?=
 =?utf-8?B?ME1RNElTRGc0MWdjZUc2dng4L0o0Qks5Nk1DS1JweHh5aTdESHQwdkxLSG9u?=
 =?utf-8?B?ajEyT0ZJNkpzTmVPMGRFZWVVbGd1ZU1yWW50dk5oWURER1Fka3pnbHhrOFpj?=
 =?utf-8?B?azhGQ29MMUQwSWQwM0pMQW5DZEk1eXE0YlQ5TEJyR1AzQTEyandpQ3hIMzcr?=
 =?utf-8?B?UmtETG9zdE45V3I1alRZZGRJalo4cmNLVlJFS3VXKzh2YzMydHlEUzd6NWFv?=
 =?utf-8?B?YmlKaTV6OWhFREF5QmN5U1JsRDZYem1SUE1rRTlFdmtBazE0ZjBQTUgycFll?=
 =?utf-8?B?dEFzWkt3UVZjTnh3WFJpODNJN0tKeFhrZ1BLNnRzZlpLTXNra0EyMTdxTnp2?=
 =?utf-8?B?cjNwc0pZUXZscnlhK0FSTGszZ1gvRnZTR2loY3dVTVdkQjA0QzNtRmR5MFFn?=
 =?utf-8?B?NW02cjJwSE8rVTEyS3hJY24xZk1NN3M4YWtKUDZ2Q3hDeUFiU2oxMkNGU1F0?=
 =?utf-8?B?Nnhjckk4cnJnZ2YrazFpUU1ZeWkxbTJxVlBrNjhuamZPSTlOQUlxVlJPTVJF?=
 =?utf-8?B?L05jMjRqUE9yQzdqWUh4eElBLzlrKytmaGpRbEtHQTkxU0F3V2ZBdjNzaitk?=
 =?utf-8?B?Q2l1ZUdYVCtoNzdiTHl5djY0c1RyKzc3NU4xVFdZdGp3TlZxL0ZDOHZKUzhY?=
 =?utf-8?B?bGorbDBSeXRsTzA5NTVOekxaMDVpUmhCSHR1a2l3eDNwNllaRUdhTnFaWkZB?=
 =?utf-8?B?c0pHRlRNbFp3c3VBVHBVK01seFNNelpDdzhhc3I5NHV2amFubXFJTWdEbnhF?=
 =?utf-8?B?RVF5NzlLTmNDamxKb1pzb0NyZmt0QU9TRzB3WUV5ZmViVXBuSXZmTDJpek0r?=
 =?utf-8?B?UnVyREcyK0lXbnB6MUg2K2NlM0J6czF5dGhmRVoyTW9zYzJkU0h1OWxvU1kw?=
 =?utf-8?B?QTNROXpLRnQ3S1ZLMkN1T0U1c2R6bW1kdHExR1NMMmowcERRT1B1em83eCtI?=
 =?utf-8?B?eE1RVXR5M3RlMldGTWFZZlM4VmdLcHhNUmVaUVVoemNqQXJ6c0VCa09wKzFa?=
 =?utf-8?B?MHFmaU1oSFBKRURWSnBiMzBRbWgzeVl3cFhIM2NDN3hXSVl3NDRHWmpSaDF1?=
 =?utf-8?B?RXBmMGxtbHdHSk5jV1RpWEdOYU9uMEVGRGM5OEFjallueU5hbW5kVDZUNXIv?=
 =?utf-8?B?dDV0TEQ4NnFGVGJjaGxzTTcvK3dPWktBMGRqYmIzT2FKOFBZYldmY0EyMlJE?=
 =?utf-8?B?Wm1HdG9hRm93bUZvRlQ4MTJYclIxS1BZSGRnOGw3UzJOc2Y5NUpiS05iQ2xz?=
 =?utf-8?B?OWg1WStZTVdpUjVrblpacDJEQnAwVG1Rc0ZNSk1MWXhrTWl2b2JpVjg3Zkp4?=
 =?utf-8?B?aHkwb2oxbUpxcU4vSWNqVUhrREtqN1hwMjBEeWtyM0lzV1ZEZnIrT0s1N25q?=
 =?utf-8?B?MTd2M25nMnllUjMrUW5EV3FFWUU4NUNjM1I2dCtLeDZmSnJHZWZlaXB0bnVB?=
 =?utf-8?B?bGkweWVJQlY2RmxRZmhtNVNFcDhkTXQyaVRNQThWUEN2MEsyQ201eU0yS2dE?=
 =?utf-8?B?enZCcUdYTmljbWVTa2lZVWNtM1lzaDdiTS9Qdm1DU0RDQ1JMWHdpTkhZdVJo?=
 =?utf-8?B?YVdSbFZsY0V0VnpmZ1l4aXE2RzFkU1lzS25MdW4rTVA3TWlVQTBrUyszU05k?=
 =?utf-8?B?YWYyajU5U05CcTBiNWlFSEJUSUFudzJRQmk5Y2FNMEVKWStjWHE4QlF5RFZ3?=
 =?utf-8?Q?5J7hZEjtzkXOMjuyr9LxKe4jTrqJEFoF9ky/slahjpYH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25595c84-82aa-4876-81f9-08d9caefb2c5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 17:21:49.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IudYaiASVE/Rjb0Lfk7kpOc1+29n5fjMZkfvUIeyfeBD6jXroGuDlpTXyaoZ6yn/1Af9dro9tr5STCODIgnGEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5014
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: H9OUwdjmnTk0yzF5R89vYnL1pZruAHTP
X-Proofpoint-ORIG-GUID: H9OUwdjmnTk0yzF5R89vYnL1pZruAHTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-29_06,2021-12-29_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112290093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/29/21 3:20 AM, tcs.kernel@gmail.com wrote:

> From: Haimin Zhang <tcs_kernel@tencent.com>
>
> Without it, kernel crashes in map_get_next_key().
>
> Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")
>
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Thanks for fixing this. I'll take a look at the other bpf_map_ops and see if
there are other missing ones.

Acked-by: Joanne Koong <joannekoong@fb.com>
>   kernel/bpf/bloom_filter.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> index 277a05e9c984..fa34dc871995 100644
> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -82,6 +82,11 @@ static int bloom_map_delete_elem(struct bpf_map *map, void *value)
>   	return -EOPNOTSUPP;
>   }
>   
> +static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
>   {
>   	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
> @@ -192,6 +197,7 @@ const struct bpf_map_ops bloom_filter_map_ops = {
>   	.map_meta_equal = bpf_map_meta_equal,
>   	.map_alloc = bloom_map_alloc,
>   	.map_free = bloom_map_free,
> +	.map_get_next_key = bloom_map_get_next_key,
>   	.map_push_elem = bloom_map_push_elem,
>   	.map_peek_elem = bloom_map_peek_elem,
>   	.map_pop_elem = bloom_map_pop_elem,
