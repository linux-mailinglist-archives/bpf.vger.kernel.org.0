Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C64ADE49
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383117AbiBHQXe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 11:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352165AbiBHQXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 11:23:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E93C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 08:23:33 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218E73Jo013643;
        Tue, 8 Feb 2022 08:23:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OP9OATNbhy4DH6B3WNsQZ7db6QkHsXO/AkVlZX9QWAE=;
 b=JBuv27tgbTlZ1bix3/UhqcfoCdewjhAz70KZta7bQpcWn6GIARjoqLLsZU6uSN0QDJAz
 Ywo+g4NzlKcNz1FmH89q0Z5CoLu3RfVzxd97XM8hhvy4hCYthi6TwwNRbHKeETGMaDHr
 fl6fVGhTIx014DMq/M3QujWRpPjDgSfKThE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3puw26ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 08:23:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 08:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlPc9anLmR8g+5byzgUPLsd8sIxJ3JVectkZ4MW6KwSWZbIZl1bFTKtFnjYGHAXdNPcMq39K8Ylz9Ekzpk6sM3bnNlRQI6do95n+4ZgGEdqBvQCcyftsRMLNHJXHNVOCyEnHBnKysE3Jqchl28fgmd7eXFWOUODZrsIZC6/QciouQsJbkJ1wVmeYxkn/LfW78hBSZiEWKi1VWf6ak4n3Bh1dVQJZFzx1FhV0BoUqSV0KlgggApOmEHjwxaRJll4I+bDqrVvQl8SJALhPjrqvKCTF9hu0Lq9ttwc0dfk5FmDGqnI2Q3c9E049TIciwo3y9mVN3Mle3cIrjr1gJVRclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP9OATNbhy4DH6B3WNsQZ7db6QkHsXO/AkVlZX9QWAE=;
 b=PLk4zgqpcuMaSHHaP7KNclpSQqhdBPZ0I+CkW7cgXcJ4vijL1yPSLC44gV9C5yWZp67cfVz3IuA0tNwu5CiQ4zxaV9Br7YBmv1s+bbDILGhfxmm4sOoBgjOZU8lXLo0be//+5eXkriLtS8iBA/bAQC5ERocQIMVWGqQkNGYox6c8mw9trBzPyhcJxkxSfPBrZfdc91JHn8dw9/n/PIYGmf5r5irSrG4UE1qJbYZEsz7leXuxrehJCNVZT/SxuAsVJOHZkjARa7AurSwIxNwrQRUudRT89/hCaxeCNYFZfrp5TnvAIvqsUaftqhGGxFdxLi4TXtovWsiGlfzTCJ+cMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by CH2PR15MB3574.namprd15.prod.outlook.com (2603:10b6:610:5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 16:23:15 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 16:23:15 +0000
Message-ID: <3273861b-5475-eac5-c827-c128a72c8b04@fb.com>
Date:   Tue, 8 Feb 2022 08:23:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Felix Maurer <fmaurer@redhat.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
References: <05989b20a8793d1ee1fa70a8a7a4328a768263d0.1644314545.git.fmaurer@redhat.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <05989b20a8793d1ee1fa70a8a7a4328a768263d0.1644314545.git.fmaurer@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:303:b6::35) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e467f854-69ce-45de-bc4e-08d9eb1f4f11
X-MS-TrafficTypeDiagnostic: CH2PR15MB3574:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB3574B80F616727F87A3F576DD32D9@CH2PR15MB3574.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6Ykf70EDIzIXItv8Nl84s9R2cawizX/i4NAuQXTS/fsSfWcM5yU7ytDOhyZpu1ZAmaMI+ncpfd9OnVGzPLVcUhpwonIATV0zLvzhlM+d26kEiT+tefvRStNJVgndSwiZy4SeKjK6m8Il7Pu41Ewv4GS3cuVypyjD52n2GskwdtbqvIS3NzgY5B3XYTnf8MV++HrBFahIn4wiffW0rzirYRm2vfy/yLZAJGCWnIRjFG/LyhiTbPY03+FMJc2VsSBviueit1kIor1aLaS03iRCSyjYgM9rUasfRm+k3NOjO18TnbrhBNHaV4RpeKQut6Yvy6sAzRUr/Y00CQI/TS/UlFqXJuwDViv/lRcIAPCHpf7Ul7xgRRP8YeAJ6DnqblQ8QdjSJRJpy/KK5e8ebUrimSaZPjJ1mACPbsIfo3jOQqWGXZXusuKJYx2LrBKN/hmFXl5c41pt2r9iVGbb7+yYmMKJpWL4IGZaD2BB2oeBQS0W+C1S9vcUn1ViAIKv01pMKfH7jI/rMR7p9QXtultLCv/E6SL1yqYRhyYbkszYXVmHXXP7yq1HolYbTIvGobq6gy0ubU1YQ/kKJxLUm1QGtd6XoSq3Zg0aC2SRZ1E66daaJAJ9BxnMnNC7ZRVql0mWiw18hD9yv86eyZ8bvOneNjVBE5o/+ZvxZqaBdrK1/S+OK83KeTczoN9mXv0KuJdRU/x9HjlCt33cEk/JJ5pczYU4X0yNyjq8R6W3FFHALIhvgl71if3cirVrzQqT198
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(6512007)(2906002)(4744005)(5660300002)(31686004)(36756003)(66556008)(66946007)(6666004)(6506007)(508600001)(66476007)(52116002)(53546011)(6486002)(86362001)(4326008)(31696002)(8936002)(2616005)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25KODhkeDZkZ2JqZmhXckFWNjNlYUYrMkVYRFNVL0taQ00rQWdDQ25wbFdr?=
 =?utf-8?B?SDd1ejdRcFcxdEtSdHJKcVdsVFh0REJmSW5mMTNuV1lGSllEZzE1aUtCRzV0?=
 =?utf-8?B?V3UwOEJib0dVQmhMeWJIOEF4NnlCazNvdU14Z29jYTdlUXdPeWttaEVlU2hG?=
 =?utf-8?B?aVpBdGpBQW9mVksxUU5IQkZKbzNQek96b2lHdWhwZk5nejl1UTZjckhveEsy?=
 =?utf-8?B?TFNkYmhCM3NOK1Bxd1FXNmlNanZvZlh1eisrd1RxeXJjSHhZL1hoaHNYakdS?=
 =?utf-8?B?UDVQNnBDcFVsUlhsK2FyS1M4eW50UHJITjhaTzlGQjE4ZXoxdE1qaVdUc21j?=
 =?utf-8?B?Z3dBOVdKWC9Pa2JmZFBpdVlGK2xHaHZnVjEvNFpwemczN3YzbWxIbmxSMzNl?=
 =?utf-8?B?cEk0L2JCMGd3eDh5ZVZESHRncG4wZUhEWmgxVGNWcjlybFZMdXZXN01OYXVr?=
 =?utf-8?B?M04xVFNCQ210QnVWWjBkaktLc0FFV2VKS3lLWlhreDhCcU1sUTExWTNGa0FM?=
 =?utf-8?B?SmJZcWdRY0p2TlhjS1pNdkxtQTZTL2R4cXBWdndnSkdydW5wdzZlZUprV0ww?=
 =?utf-8?B?ZnJYQmZhY3lVeWYwVDVYekp3eUQ0ZENXcFhQdzNqQ0VGallPVjNicVQzdzV6?=
 =?utf-8?B?M0RjRkN4bk5SOHdMMFFuVld6WUNyV2tCeW5qWC9HRStybENCcjVvSW1vQnQ0?=
 =?utf-8?B?d1NNLzgwU3RWZVZzRlhZYm1iOVJoZGYyRTJwRjZRbHEzeDRmRFRieENZYkQx?=
 =?utf-8?B?d3FmcFRoWVpTcUsyc0JJL0dVa1FNR051eWhobjN3Wk82RXluNXFZN1NPdFZD?=
 =?utf-8?B?TmJEb0pmQlpxYTlVYkpzZ0VvdU9tdC9iRm03TisrbjRjRXJVb0xmUTRiaFNJ?=
 =?utf-8?B?Z2RHR0F0TkIwMmFWcnovZnVqYXVkZFpBZGR3eWJDd1RMOVlqTEVFMFpEQU5w?=
 =?utf-8?B?czFlODJKWFdyaDUrYVR5a2tCTE5HMmtrL3B6Y0FDdGp1NzRXVHMzVlF1R3Fw?=
 =?utf-8?B?dGNqa2Y1aHZ6MUZ1RzZlQ2RKZzZhcEp5Q00rRXNUOTlrcHJEamI4OWc3TzMx?=
 =?utf-8?B?UlNYQ005MTZoOUMrbWpQSXY0MGczTHN5dkkvWXZCMlVKdisrUUFtcFQ4U0Yx?=
 =?utf-8?B?MHYzdnpLSUVOOHJyWGxOQjNZRkNRNThnU1FVVjVBY0xJSS9sdXdKNFNWem0r?=
 =?utf-8?B?R0pHVlVqUUp4dUg1dklkZmNHM2RnQUFadGY1ZDk3VFBIVFpDUXZXbkFKanNo?=
 =?utf-8?B?eHJUSlhPVHlXUlIvMVgwWFVsSlN0dDVsanM2OGxHc0Nndlo4QisrUTlCcjBN?=
 =?utf-8?B?N204Ty9WTjNFbkRPVU5Dck9zeG1mdmNoc3RoenJVK0NCZXVxakdaZ1R4UzRo?=
 =?utf-8?B?RWJSTlE1T1RydTVzaFZaZzc4dVpINGhFV0xNV0FEMXRvV29WbVhxQjF0bWdW?=
 =?utf-8?B?bWc4QlNlRi9VQk1PMExSb3RhSmpoWFd6elFUbUhVTXZBK3VDdUV1QWhQTDla?=
 =?utf-8?B?OVovVDJJdkF3U3JpQmc3VDBHMXhkZk1wYXJOUy9WamRkWHFKUisrSGxLU0lS?=
 =?utf-8?B?aFJRMTlmZXBsWldRNEFhUWQ2ZTRVamc5dnRJRmc0NnV1TXZHQ0pmRXVwWWJK?=
 =?utf-8?B?amhVVXVBWEhQRzQ1L0V4MHZMeTdEZm5jcUpFWERvSDduT1NIQ2tCZzZ0OEVB?=
 =?utf-8?B?TnhCOEF6T1RURzRleTRlMWZSS2NiTnZjV2Q2dTlTdVBoQnZxNURUQ1kzbEhT?=
 =?utf-8?B?WEcrMkd1VlkwTkMwOE54allSb1g1QTNlK09rUW93MVlPTXU5QkJEMDEza3dD?=
 =?utf-8?B?MHd0L1piWkh5NG4rMGdtV3ltejVvMm9OcHhsYVZ4Z3hGeC9IeDBmZXM3ZW00?=
 =?utf-8?B?QTFoRGRJQ2MySjB3a2JtRjZyU1VIYU1ra3c1RlE3b2dRTFFFajdDbjlRVWl3?=
 =?utf-8?B?VkhCRkhxcXdGUUZ5d2tnM2loR1F4QnRSTEZOZTI3bTZFVVRqUXNnN0huS1ZP?=
 =?utf-8?B?b1Y3Y2dWK1RBalVDQ3c1SlpHYnFSOCt4cG05K0twSEI3ZzUvcGozQ2plVnRu?=
 =?utf-8?B?emRUZ0hGYWNwV3Vod01yY3ZZVVVIcVlXWndLc0Y2dUs1bHFvVDZ2c0dnWm5O?=
 =?utf-8?B?dk0yN25VWGZEaHEwY05hbnFTZXNLUEp0RE13S1lERE83MWlKNFlkODZJblFU?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e467f854-69ce-45de-bc4e-08d9eb1f4f11
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:23:15.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOtqBeflEVLpvpCOvWYQojieB4hFycSSI3BiIPiJcDbGrjAILs/1DUy7raS33zMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3574
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -qtuBkEbFnkb-Loa1fzE6Z8BSNgpgJlr
X-Proofpoint-ORIG-GUID: -qtuBkEbFnkb-Loa1fzE6Z8BSNgpgJlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080100
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 2:45 AM, Felix Maurer wrote:
> If bpf_msg_push_data is called with len 0 (as it happens during
> selftests/bpf/test_sockmap), we do not need to do anything and can
> return early.
> 
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>   net/core/filter.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4603b7cd3cd1..9eb785842258 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2710,6 +2710,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>   	if (unlikely(flags))
>   		return -EINVAL;
>   
> +	if (unlikely(len == 0))
> +		return 0;

If len == 0 is really unlikely in production environment, we
probably can keep it as is. There are some helpers like this
with a 'len' parameter, e.g.,  bpf_probe_read_kernel, 
bpf_probe_read_user, etc. which don't have 'size == 0' check.

John, could you also take a look?

> +
>   	/* First find the starting scatterlist element */
>   	i = msg->sg.start;
>   	do {
