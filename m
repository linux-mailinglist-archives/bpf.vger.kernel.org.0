Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7887E3AC054
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 02:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFRA4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 20:56:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233025AbhFRA4V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 20:56:21 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I0oOgo000392;
        Thu, 17 Jun 2021 17:53:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=54kYl98HkEZBWAxkukOeSQkx97iz92+E4tKyogBiCVA=;
 b=NMggbzujYizQBQxqN4RwLvLDXhtthn4BqhRsC/ueqLKfPnOjl7wgzJYegIKWdO9n7Jpv
 i5mQ1kEPvep8Oo3YsPbb+9lEfT4ibUz4DH3FF5N6Hz/8WLYeuHcE2gwJoEFioOZlc3CQ
 XeQZfh0CzAZDwvi+pTjuQDR5G3lUT2uVFZc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 397tkffuft-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 17:53:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ5fHSon6mWhorzUiGrVMWzUgc5jlww1lqsZRupfKzsSzvg0vI0WD1lL4C9LtCGj0Ycp0kNjFTRL1ecAcmjdWNF3r70TABiULwbw9XXfQM65gv2afDwMkhIAD1LteWzxfRWp0/xZ2igrpiqCBOhI91WmzOe9hm8sSUgGQH3Jh0DBuBKJYZONIApcFJZiDb3Id2aKosKQKO3vVFpphFbw+PDqQdsg1O0Epg5a2/NyDRp+G1EzModVxRz2qwiq2u0Dfk+AYvTrkHUzxlDn2YwieYy2ZUIzMq0jIFnvefGYyDnYqPTFlWeL7YCY63Uyxbx+jAOgYmx2qMXBJuVn+VokjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54kYl98HkEZBWAxkukOeSQkx97iz92+E4tKyogBiCVA=;
 b=oSG3IkbJ/pK6W+BNdVcobOT0NaahBYHfDKWyoBviDcwJPG3wNjaXsebqHY37RM8FTQNc4pQnOujQfZLmh0l9FGuIZzxJ+6RiWPy5LN4XS4nMpWPI64IfJIjT1jR1MfEkSe1yw0XHrVZrJSFwV3yVVOl4kccPJuJvhsZT2me4Z7mo3kPqhVhcu8815elT0WkzlNtKvQd8upjHokcRWL8BBiDLesxHv2coO9s6FPGFX+60d0KUbYe/OhmxlKm9JUjyXYqHYc8+nsKMmMR1INF9EGggmhd07D5xbT5JYyZ3NjvgW8qa32FcQz7WVUGDtH2xIeMVnGioCbeuwTkYEJN6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4176.namprd15.prod.outlook.com (2603:10b6:806:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 00:53:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 00:53:51 +0000
Subject: Re: [PATCH bpf-next v6 1/4] bpf: add function for XDP meta data
 length check
To:     Zvi Effron <zeffron@riotgames.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210617232904.1899-1-zeffron@riotgames.com>
 <20210617232904.1899-2-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <74da299a-d5a9-feec-98e3-ded116b015f8@fb.com>
Date:   Thu, 17 Jun 2021 17:53:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210617232904.1899-2-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c984]
X-ClientProxiedBy: SJ0PR05CA0164.namprd05.prod.outlook.com
 (2603:10b6:a03:339::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1349] (2620:10d:c090:400::5:c984) by SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Fri, 18 Jun 2021 00:53:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06fb5dd5-5141-47bc-5d6c-08d931f38a2f
X-MS-TrafficTypeDiagnostic: SN7PR15MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB41765FE192390736941A61ACD30D9@SN7PR15MB4176.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjEdpMslfNjPw8yTDnVUPiLutsjJiKYJagqawRrBumI0Xk0AbzvNuCG4pmZ7HR8uQCZeITix5XOSn58ZcEsOsufN5Ql3yaAQnz6NZktjA02zakwSI1iHnyPRgc0yTF//9+dfIM3wBnJFEhX8VKmNLliw4JXIf9HVhnwICJHiseuywa3wTV0GiR8xBUkVszbV7wSLwpJRTZZE57YP7eYrN3vyt7FTKR+KRZciA3muA+kD891mrxEI4axpwFWqVwZV0ZLsPkLDbOxOWHolqcXfE3RatF8SfQ9OsOB7xeDYT9pqjaDfkRND+5p4WNwDxok9UNPtvWEE8vHzcGr34Y1y4aqVprGS9TbaDcUVfrbjGXTo2HrxiqziqQO4QRXw9bG05pmlVauHzZqKdhm46V/aZZvM92CmYnsejXOXxtLyyjEGe0G5H8CDIGOdZE3eYWOiJDWhvH/ejs4rt7I3KzYh5ks+cjLlF7KnrHeLd9IEzaO2rVt8QGnYTVp4oBybfzc6LQoiTq0RLnVeRF11bvjn9QUuDIqClaVmo/nQP/LeC2+rjzw7lk3nT4bLQrH0u5Atm2JakTv1pYxXFvuEJ8Z2o0NOgU4ZtT8q9m61fg0md8j2VL4KGKYnOgNSgUjQKjIILanBesxjtG35Tg9RKT/d35HpTC5cybghui4yRsBwPeFgcHzpVA6pymwbNzpLYME6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(66476007)(66556008)(36756003)(7416002)(53546011)(66946007)(5660300002)(2906002)(16526019)(86362001)(31696002)(38100700002)(186003)(6486002)(4744005)(4326008)(478600001)(316002)(54906003)(31686004)(8676002)(2616005)(52116002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1h2eHFPTGE5V2piQmR0RloxNG5jeXZEZFVkSkkxU1VycllZcWtvWTNnSTFQ?=
 =?utf-8?B?OGtUSmxVR2ZyTkNVOW1LL2JtTXhNc2ZKOCtBV1E3QUMydDZiQlpocXI5S0ow?=
 =?utf-8?B?OUhqd1JaQURRMjVnSmFvWGtkZC9DWkVyTjZ1S2YzcWxjNEF1cGpIK2dwLzBJ?=
 =?utf-8?B?QXJDdkVzeEw5VitJK0hjUUk3Ly81T0Y4RXdxMVF6aUh2ZVVNYnc4cHhKOVlp?=
 =?utf-8?B?TXBPZEJmTjQ5L2QzMC8yL0pkRGZPVGQrNmxhV09sYXlONG11TEg5QU1SMXZp?=
 =?utf-8?B?SjNTaFJ4ZDUwbjdkUUpVR3ZGbzYvUVU3TlMxVVZYbEtnbG5TR21PZy93SVRD?=
 =?utf-8?B?YXhLb3dsbnYvY2xBSTh0SkVvZTA3ZDg1Z1gzWm1PcVlrQnBEaUlzOHFaUzVK?=
 =?utf-8?B?LzcrRXVoc25FY1RPNU9vYkZOK0EzTGxFcjJENElSaGF6STkvdkRqYVJLaFFw?=
 =?utf-8?B?T0MzYVFmSGtYR1R3UzIzbnd3K3B3MjhZVnNUU3IvaDRobWpBa081eXlZUVow?=
 =?utf-8?B?Tkh2eTBCNEJDQ1BUYXlNYy9zK1kzeHVEOGZ3NVovcUtaSjhNWXZLa2FmYzJM?=
 =?utf-8?B?aUNlck1lVTdwQnVDVW52eVpTbU5WQTRKUGNHVXBhNDRUYmNEZzdoYzZadkxu?=
 =?utf-8?B?RWFNL0F3NktSSlpmb3c4THMyZjY4YWtDNUdPcXdlRHprd3BUT1BPUXNMcnM1?=
 =?utf-8?B?eUsySnpRZURnTURqa1hDOERhR3FkY05EYndib0ZwT1FRUFNpazhlNURsYlI3?=
 =?utf-8?B?WkxMQ2gxZGVCYk9CWkhuQjdFRVZJVmhGZkhDcStUYXphZ0lEcGRuWkhBTnpz?=
 =?utf-8?B?WC83SnYwVGdYbzUrZDdNZytPcmhGdVBabElhV1QrbE9sZEZSSUo1ZG0xQVU1?=
 =?utf-8?B?cGZhRm9UQStvMmt6M2wzbm5iMGJvK2s0T1V0N2l0dy9NSHlFRTBOQURta2pY?=
 =?utf-8?B?dmNuNEhPSTFaMnpMMWNaUzZ5TXpVYXdCOHp2NnU1QUw4OXB4NGV4RUxIVUF2?=
 =?utf-8?B?NzlvZGNSdGFzRS9PWlJvM255OGFTbE1xaHg1RmxSQ0lPMVMwbDdITGQybjg1?=
 =?utf-8?B?QUN1aVlJNVFzdHNJUFBMUlpOM0Y5QlNkdVI4bXczelVxNE51MW9oQ1pYbkkz?=
 =?utf-8?B?Mk9IanU1azhFRGx4UVFvdVBEbk9qTWdhSjZHdVlMdGJSaXBDd2ZQL2NxVzI5?=
 =?utf-8?B?SkdlOGRVZnBVZkFObFpxU3cveTRTUFMxSk9QSHUwNEhlYVg1SXV2aUh3bWxO?=
 =?utf-8?B?ZzQrMzhWOTU3ZUlzVm0yQVdXMWhqWThld1AvRlAxbmJrc1EvL0dMZG9KWTVS?=
 =?utf-8?B?Y1JkWXYvelFDMVBQYldTalBBZGhiTWpJNVU3QmNadFN4dXJnd3d2MWhNRjVt?=
 =?utf-8?B?SE0xK0hTUXdkYlNITzZKWTg2VEhsdWl1andBdmE5UjRqTUpUWGE2Szc5d2RC?=
 =?utf-8?B?cnJyMGIyWS9LaFRtMnlWbTZsY1VkNTlIZFNIaEpNUDdudkliSUpFMFhLcmEz?=
 =?utf-8?B?RjAyY2wveGRjeTdJN0tXYlFnam1HRC9lNTg0NVhIOUtTS2ZCYzhjRmFLSnNM?=
 =?utf-8?B?emZWdmY5MWc4NEl2ZUkyMmVGT1ZaMnRTcmtVNjBxTmNoTldWNzZ3ODViVE56?=
 =?utf-8?B?V0VCUWJwaVNhSStyL1BjMG4wZzJ1SmxPWHFNZjljYzR3KzdpejBFSTduVTZx?=
 =?utf-8?B?dDZuSlNkd0draUp6eXp6bHJudkFEVmN3djNvTkNIYStnSlF5YW9EcFI5Sms3?=
 =?utf-8?B?SFhwelNQVWxCSXdIZEt6OGRycWtlOUpESjlmR3JnaWdaekV2azVYOVlGMWMv?=
 =?utf-8?Q?BrdzUpyLJ1ckSOzzWxsQ5tKN4rmWxvw8Fws/M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fb5dd5-5141-47bc-5d6c-08d931f38a2f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 00:53:51.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVvgvzDMGi08/QFtAXameiUw0+Y4UrKqqtNldqo+gUH42X5ARTK09QBof0U9PzEt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4176
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: OgAFW9_v1UumH6vqD_-dSW7OCunWRI0h
X-Proofpoint-ORIG-GUID: OgAFW9_v1UumH6vqD_-dSW7OCunWRI0h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_16:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/17/21 4:29 PM, Zvi Effron wrote:
> This commit prepares to use the XDP meta data length check in multiple
> places by making it into a static inline function instead of a literal.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>

Acked-by: Yonghong Song <yhs@fb.com>
