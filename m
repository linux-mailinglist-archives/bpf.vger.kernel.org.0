Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D593AC05B
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 02:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhFRBBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 21:01:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1594 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233042AbhFRBBN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 21:01:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I0wn4t006404;
        Thu, 17 Jun 2021 17:58:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8qCfiPWaa1zP4N/vGH7VdVa0EQowsqUCSP7/4bLPPks=;
 b=RQ5REfjgK0DsyQdUlQ7lTfiLsqFfk79RVRtUjtUPGmiDbS3rPlV6Mf1tIY5hPf34UYUK
 BqrNgJTaInU9WA8V5TOE3QgkIStCs4TZnpTKMkscZVZTjzri5J3wTxigZBaDdzocuAXM
 YavqStoq1J4DhjRHAZdyTYsrsY7/aJSgTlw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 397hbaut4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 17:58:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBP23A59oDOelCwxv+68uUY2Iwz/juz2XdcAdEAL4p/VOma1VDXLlFKA7lzf89Dd8aabAN7tNxm1hHbNkFnFh5f7cqrQkIhnv/IwgWdfBJgA/1nrL6z0GuXTbgt9WSpBTqsrEJUFBnXoYQJzJuxsMwbqr1Hmz7BRXAzrkJ4L76yRklZ2VGvIrVDymSpn9jvv9vA1T2+4uE3Wbnvukjdv1wIRxRQOo0K0V3WIj5Dzd3NyhH8vAcdu+sEeWMX5ooxeNeOpsOvqNGDKHMJAkqTXTfkGnaEFiWWdtfGoSHWlow9Y1r2HhY9M3e4yyNnPT9CLZQXB/2H/et5DFnHfnBK6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qCfiPWaa1zP4N/vGH7VdVa0EQowsqUCSP7/4bLPPks=;
 b=JYwzOtlByN4l5apuhIIhayQJ0h/vw77HzNN6K6olJi96cwdqkkDG9uSrvtBSP341m0Fe9QXtIV+D+gVvugyG9l4/elvzWvlfPAU9r1Cfu/hcl/IkEcTOqIbuFWcPUpDZXP/AtYYYPoEkIOF5VhIQ9gWV1/o80Bns5g7cuZ7tMtWt4WzJdrSTbcwggERlz24rpvj0JLUKcDlm9I2mdDjommtC0Knu+nJhKFUFtDmdELVKJDw1SKFk01Kv3b70w1gPPQlAh7CmpaYeWOOQ44mE2pUJhaf/pJh1QoHH58UEWLJoE72b1RH/dwCWAesJHvoDYfa9cxXEMhM2ifR6UfZ7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4737.namprd15.prod.outlook.com (2603:10b6:806:19c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 00:58:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 00:58:39 +0000
Subject: Re: [PATCH bpf-next v6 3/4] bpf: support specifying ingress via
 xdp_md context in BPF_PROG_TEST_RUN
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
 <20210617232904.1899-4-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <60422ccd-bbd3-68ca-f5d0-2e20157005ac@fb.com>
Date:   Thu, 17 Jun 2021 17:58:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210617232904.1899-4-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c984]
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1349] (2620:10d:c090:400::5:c984) by SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Fri, 18 Jun 2021 00:58:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832c8b76-5692-4f49-b0bd-08d931f435d1
X-MS-TrafficTypeDiagnostic: SA1PR15MB4737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4737F90F26FAC60DBD565420D30D9@SA1PR15MB4737.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4urr6/MlFYhVKOKk2dum1vwnxjoPMSioz0wAFKX8biQcmTu9FJ9Pl3ZkbaVwT3tiWwZ5msAnkyAXTAEen6kp9WYTjPFp8oAUkN/ONlX87zTyej1CdV6VjPGj0P+GRgt7GYyh9/l8LLDOHlgBB00CSKCZGrYDSshUFTk1tLw2nW1A7+k0Dm9lY8/Kp37Ucyzq7GdHbrmFQOh39mykUgG5hyIsFxorM44iNxZBz0V2nuS9KLwJS7v1fLNs7sd3KWN3F7PkRuQfnOeS5bWe/N1AEb89+t1tV12OhnxxW9ZIUqKVxXiuTdqskgmVAZs5zaa69MDUaTwnyw2zLxu/djQqLpnqBWth9woB6/UzXTjnWacZ+jpjfwfDWb50mwjCATNrWbPmq6KhKLEERLaOHOa8LJOZuaGD43/EAqVgJ1WXxyBhZnvP17/Y75pnVYSOEb7QaBcf03v0sbCw22lRucT++tOxt7IyXlmRk4WvD+sEtQiT8c3ONWPM7l4/v/pe3pKumuMXrYggOda9TxmSENn2pRin5ix+KnRYMZDqRz+sVOmhbN+Hgo11fwobxdLHqx4yQ8EuY+gSgFoqViSt1Kcf3BhdLgx2T5g7qgsoO1PMDCyvsAiH58CsbUW3yo8ifaC+EYwhVakf9Rj6ZRgk4SLhTVnXnRCEoq+BDsLWpAbEWdc+ACsPd8nPHKq6JoKgIGH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(2616005)(36756003)(66476007)(66946007)(38100700002)(478600001)(7416002)(8676002)(66556008)(53546011)(6486002)(31686004)(86362001)(2906002)(186003)(4744005)(5660300002)(52116002)(4326008)(316002)(31696002)(54906003)(16526019)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWY3M2hsdWJHaXpKOVlnNVZKc0xFVXFPOUVpVzMyN210ZXlTZFNqOU5VMVVE?=
 =?utf-8?B?TnkxY1llYXhSQnFzSWhqTVZVdHliMUdCYjhCUWpWR0VCbTJkR2tKSXNsVHZV?=
 =?utf-8?B?dXpmYkdWelp1aTBHcmJQRlk4VEloU1g4NC9jMU1WQVp6eFR2Tk5NT0loWVhB?=
 =?utf-8?B?QTROdG1MUzM5V3ZkbzRCZVdybC9hV00wNEdrRlF5R3RmdUVmWFFqTFluTDV2?=
 =?utf-8?B?VUVZbnp4R0UzQm1VOTZPeE9YMVQzeDVRL05RYi9ITjgwZktHLzVRanVpUHJw?=
 =?utf-8?B?UUtsNS94OWN6WjRvVGluaFJybGtkZkYxNndVRVFSb1lPL0h5S2JTTVFzMElC?=
 =?utf-8?B?VHYzRW1MUjNIb2ExdjZoM0lNQ3crV1RoNnI5MHd0Skk0YWc0MGhqQkIxd0or?=
 =?utf-8?B?aThwU013OVJYZU90aDNrYWZvZmdHUWN2K1pJK0V4d2djUkh5OUQ5eFZoQ1Fz?=
 =?utf-8?B?bnVyN1VGNHJrdzFsa3ZtR0lhTDFuWjdYMEdtQmNHVjQ1NnZBV09PT2trMUxJ?=
 =?utf-8?B?dnc4RXlWbFVxNEsvMUhDTGszbnMxVUN2ME85S3lZYlNUMTJ1Wk5SZU9iMDJl?=
 =?utf-8?B?SGFDcVk0c0h0YlpJc0NFQXF0bmtvb1VvRGp2Y2dpMmV4dk1TZWp1RExqbVVv?=
 =?utf-8?B?K0RtVm9KbThTODRjdDBWTVJicXE5QjdLRThGT1R5SVFRT1l4ZVRPaXV6dmZl?=
 =?utf-8?B?NHNQVytlTXFEQVhVZGNlS1EvZGxYWVZ6aWVTSHRvdTZ4YW1OZXp1N0ZyYU1S?=
 =?utf-8?B?N2JHM1JENkxabi9RenhFeko1c2NwbzRSWGVvdUFBRTZmM29xQWgwSjBKN1pW?=
 =?utf-8?B?MkJRTHBPZFVIU3d5eEF1VnV1UURGQjRhcVNqb0xybk9oNnNVRENkYzRxRWI5?=
 =?utf-8?B?VHFJOWU3M2cwTTBtWkdzdVF1MzRNb1c2QkRiVjFFQzk2aDZJdHBjdXVJWGhn?=
 =?utf-8?B?aEhmQTgzTkYyd0tKNytZRDk2Rk9CdDNzRXNMeXIrT2hGY3Rpci93S2ViL01D?=
 =?utf-8?B?dC9PKy9qVjdZMy9Wdk9wOEk0RU82WGtiRnRDSDlKZ1hXa0JGNFl5ZVpwSzB2?=
 =?utf-8?B?ck1jSzc0NVNIWEFNR21rVlBnNUcwcXFrMkhoRzJ3QzBsZVNFMVU3cXF3em95?=
 =?utf-8?B?bDg3eTJOakozc2tVRysyZ0dxM3ZJRXNHTzYwenE3cnk3VmUveHpFQTJ4Mnl0?=
 =?utf-8?B?SXQzN1NLbDV2cEN5bjF4OUtVZ1Bta2poYXQ2N0RtRFZldld4cGJBUlNjSkVP?=
 =?utf-8?B?ZUtxRlFZaGdQWDFYN29LbjlESEZpQUsxRUpSWUR3Ym5jc3FDSlpBQVlPV21E?=
 =?utf-8?B?NDFuYkZMRWZoVWovQ1dLNVVPOG9xaE9HSC9OQmdzaFRtbE9BZjdWWVBvOHYx?=
 =?utf-8?B?TDVxT0hjWEVtTmlXSnVPNEN6YnRPTG9JMjVZVWtIYzU3WENnNVdONmtYY0ht?=
 =?utf-8?B?QjlkalZ3UzlySkVOclR4czlZNCtQd2JyV2xQeTFNWWpUYmJnRjJocytBQWhx?=
 =?utf-8?B?VzRzazNSZkRFV085c3ROY0FzK05QdDRTTEg4MEIyQzgvazlSaTJXajZOdGpr?=
 =?utf-8?B?SVZRRUdpYUdOV1BWV3pkS2s2WFdKVjdaQitoQ2R4M0pYenAzOU9JV0hJRzNv?=
 =?utf-8?B?QWlYaWRjblJ3ODgrTEN3SUl1WU9CREQrWG9qU2hzZktXcHVmNUNqR2RZQ1Ni?=
 =?utf-8?B?V2hXQ3E4MDVHSnRoMVg0ME80b200Um9JQkRqeUZRcGIrZ3MyekkvQXo5cWE0?=
 =?utf-8?B?dFIzV2srSzVOZExrRVNrTFI1RXNFaWJWVFpLMGZuajEvZ0lMTWFBYUFBeWFF?=
 =?utf-8?Q?cpnWQ4WqBXNeWc64NFSnUNAXRVE0MABXKE1f0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 832c8b76-5692-4f49-b0bd-08d931f435d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 00:58:39.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy/LTPVmLmzElCthtCScygNaRL8NLtLCshtDRtONzK2FLEW6omdsvGeDnnlcXxc5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4737
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: c08Q533utoEY3ZWAp4E5j6-Ff8klgTPh
X-Proofpoint-ORIG-GUID: c08Q533utoEY3ZWAp4E5j6-Ff8klgTPh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_16:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/17/21 4:29 PM, Zvi Effron wrote:
> Support specifying the ingress_ifindex and rx_queue_index of xdp_md
> contexts for BPF_PROG_TEST_RUN.
> 
> The intended use case is to allow testing XDP programs that make decisions
> based on the ingress interface or RX queue.
> 
> If ingress_ifindex is specified, look up the device by the provided index
> in the current namespace and use its xdp_rxq for the xdp_buff. If the
> rx_queue_index is out of range, or is non-zero when the ingress_ifindex is
> 0, return -EINVAL.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>

Acked-by: Yonghong Song <yhs@fb.com>
