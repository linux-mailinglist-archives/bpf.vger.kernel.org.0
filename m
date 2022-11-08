Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0965621ABE
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiKHRdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiKHRdO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 12:33:14 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBB657B77
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 09:33:14 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8BDBNt007339;
        Tue, 8 Nov 2022 09:32:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CuKCAWd87oamnnDwKZbMaBc/9G5Nc7w22hfkyghvz6w=;
 b=Z7NxpdJCo1bzZDCsNIUCFAIC7cm/+4Oty15IWgkmXmTcu4u7BD2Y9rSrIR32MRzwhO3N
 GLcFbp8Szzr5MNbJZrGgNu/fyP4j0HOCNLqNit3+z2Z0DsshPu1EHou6Arw7vn5KaU7/
 0i/55CbhmnbkqEozGzOCAIRNg8eDMAysravvSoZBUDEaWJFpqSS01Ira4R2ZsaIF1Uet
 zcKvWYIjhN15neO6M4YESt7PywxRJ5bdlmAMujQjIuUVxYjUQAN2pV0KkEpbrI3iv2p2
 ibZD8Hf0yXDHxoUBUlnHVl4QYXbgLkvI6WqXt8ItaPBpXoO738760N4KvevP9reFdDS3 Mg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kqp1mk6yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 09:32:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZtkTNXkf4pr0+Kn5edDS1ad/mF3nZ+GvHkf3JYn10M8ybjgXr6wVnrNuZRLKdR+TKFo9znOYQ+DeCHP+uTxrXoMAaEjfNowz8bslD2nzKvJ2etNEQNWHTZpIbL8tsC0GI+xPUebbE1iiBXFls3BBDdZi+Sj5l6ZJIRz34XBFVGtFQ18/GxhTy7vA14qBfLd+HUJW6cyAt9z78GMcEBwz+mG1jprGeIf5i1U1DlkZj8G9JVE+0cj3Fly+dHNJtOHV419LkCclcxp3ACcPt2tEXbRp9H1nlS2GPhAX3PELTCeXskNkaSVnrWt0CO9SjAMQmKvJqOiwtCehnQC3NlS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuKCAWd87oamnnDwKZbMaBc/9G5Nc7w22hfkyghvz6w=;
 b=C3WknN1Uso1lOu1iTZHTr1vnPOc+y/W5sMx7IPkqzGKYug9vfOYApaaau+AFpeMBAJEdNsq3p3z0W/3IG7syH1LVxsBu/z43sXhYsfNWj+MSCPfX1ZP8WEA3nMEjrHtEAVgCILCFTdePcpQkhU9DKX9ahPe9Z0UvrJcA3Cbq5DbKCrWuCuuHaptTmNNIoZ8tj1iJhzZRTyH4ohCaxV2DblY6Zy/6E8A/dbQggSpRKoff+D8Y9835GhLc8IxipuB4z7f3nX+qYl03ArXoBpno0HmByRkR6GthlvRR7X6YLaSLAra7HXN8yassVxykkcf3/rCOPx6isiZvlYrdJaVPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3438.namprd15.prod.outlook.com (2603:10b6:208:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 17:32:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 17:32:50 +0000
Message-ID: <90d81114-1d54-9b10-b057-46de167c0b1f@meta.com>
Date:   Tue, 8 Nov 2022 09:32:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/4] bpftool: replace return value PTR_ERR(NULL) with 0
Content-Language: en-US
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
References: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
 <20221108142515.126199-3-sahid.ferdjaoui@industrialdiscipline.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108142515.126199-3-sahid.ferdjaoui@industrialdiscipline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3438:EE_
X-MS-Office365-Filtering-Correlation-Id: 125f499d-e228-4616-befb-08dac1af429a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAnEHzAnjVXUHNeA/6PqSYF61GH8Eii7rBCTkpYX9ICnvi+xqg3jz0QYNNT6/EY162VXAH0gFL4c4xI5v9NWPwu0y27mDPnyDG3dhwwLhsObaGI5o4yvYeZanurI3J/8GgDoOEyhgHsLwu3/pSj9HoeEgoIGvE0cHLCY5j2LONUJOvRxk1PIEj+s+yYIOHeAx7Au4rxR4KjxxtNnjPXElCLkzvsCzZLakZZ50xxfTPpzNTm7JDXqUvSpp6OoAfx6Ob8O/bkZft6nzMcZ0GLY+4GACzylw6K3vQUK/Kmdjf327TtZOumaCwCmjlD3Ra0LqSr76Wz1rdyGg4vY+er1UD+aigwT0lk/wg9GQO6iwvewOXnF4DVg3sd7SmQ2rcyboeJoasCEDQvEniiNYVLlJGr2LWDNHRgNett0xfjbo8rY6VJKH7pWXV3dbUn6Jctvyk7gZOQ2nUPI2r3QumBFFWmSIl5l96tLYhgPd6mOR41zmlLCo4ndl8v8M9fJH0OnzA68ejEHrjAkd2DrQNLOD7I1zpth/Oa8t9wzrWZzxX5olT08NR0X2oGfc+amEcORe+YME0Igvaosc+kb+U4hHMWgkuunp2NVbATgfoGFipsC0V3AVxp0TcoL+TNOo5nkceDm6wTJ/gaFvOwiA7NCdnoLFoQC5zHTxZhZR1yav+OeO7jL5pdVa9XvW1PpUErnFG0SS3vYCFGzJoIUWrAX9DV4nO+IB679HTVh6RamKwej9MFOCP+j51AgHg9HX5Eh9dn6tq6Ga5fwDhyTzfCa2B6CCzN8j3F1n249s6mtPE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199015)(31686004)(478600001)(6486002)(38100700002)(316002)(8936002)(53546011)(31696002)(6506007)(36756003)(6512007)(66946007)(41300700001)(66556008)(4326008)(66476007)(8676002)(86362001)(558084003)(186003)(2906002)(5660300002)(7416002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y21XNkJ5aW12UDlyRXlOZDhCTDh5REhWMDFiRS9KMWg0L094bnoyTk1qTS9w?=
 =?utf-8?B?Z2ZGZmhoa2FXZ3A5WTREcWMrTmZGZGh2cmkvbmllMXJKc0twWmRQVzFtSE9V?=
 =?utf-8?B?b3ZFcThSNVNPaTFhcC9PdzB4R1JQTGRqRlVGeTRtK1M4Z1RoSVlCVVRmYUl1?=
 =?utf-8?B?dllHa2IwMGpiNUZSRVFidFNtQ1l1ZmtNTzliN3N5QkFHeTdPUC82ZVJ6UUd4?=
 =?utf-8?B?VlA0bis4NjRnY3c5VTVMamMyamFEM0FVTVN3VW1RaFNuMU5nWEVLOEJyMWdR?=
 =?utf-8?B?WHgzWlJZKzZaOEkyS0JNSUZhUWFUL2MrU0tnalg0R1BqZFpPNEovbTlOQ24y?=
 =?utf-8?B?dmJOWXZGYnU2WTlFZ3FSYlM1RkEvVllDOU4rMy9QZHFVMzZaQVlPeGVGUVZW?=
 =?utf-8?B?V281YU1uaVdNdVFXWjJ4di9nU0tzR1plbEY0QVluU2dscGZqSFNmWFlRdnIw?=
 =?utf-8?B?eFpRL1FEOWJBcVNtclRiaHB3WTQ3T25mMklyZWtveEdoU28vNlJoc3dJY3Ir?=
 =?utf-8?B?aWo1bW1RK0lTbVZLUlphOHowc0xwUm4rMFFVcitma0p1MUI3RngxRHFYcnRZ?=
 =?utf-8?B?VThJRGVDcEcycjJhVHFxNnBjWG5zSHc1aXRDZW5JR0c1TzFMK01nLzNUbk9V?=
 =?utf-8?B?cXR5dEFhNWZpSnJ6NTcrWWgwSTBsZlY2d1ZsY2ZrZk1pTTdCQWZCa1g0V1A0?=
 =?utf-8?B?V2RIZ3RhNEo1dE9OU2JHSWJIU3ZBL1c0TXYwMldQQWhrNW80TmlQcEJpZ3kr?=
 =?utf-8?B?WlIvblc1VjV1RGhoWWVYM2JBTVdpZmJzb2pHU2dPU2k1ZWxPamxsMS9sK0Ja?=
 =?utf-8?B?RVV0cEtwRkx1MktLdUg0UExONkIydGEvam5yT1dsSnA2dHZ5VTYyK3UyMmlM?=
 =?utf-8?B?S28rTHphYlJWM3BmU29oZFNXUkRDWG9DSnFDdUVJRVhZMGUxSEJSV3BGcmwr?=
 =?utf-8?B?ZUo4aDdINEw0VnowMk94a3IxbHZJYjMvWGUveWN2ZFJXWjR3b2xrUWpkSHdv?=
 =?utf-8?B?eGIvY3BsZmhsNWRHYk16R0ZYOGhpR2pDY1Q1RG1kby9lMjN2V09tcDFjaDVa?=
 =?utf-8?B?TUxpaFN5c09rbFArN0I4dUVSSk9qd3NzTW5FSzFqYy9icGdqOHNDMWwvbGNn?=
 =?utf-8?B?eE1meTZQRENOU1VNdjkzQ3AzZUJ1Q3dBVjFZWGd6Z0p2bThmdmduR21ZR0dS?=
 =?utf-8?B?b3k3SnZkWi9NdlhGT1ozRzhkR0NWZ3RhVzJWT1ovZ1JiZGQ3VFMvcFp6YzBW?=
 =?utf-8?B?SmxQWlJ2L3p2ci9sb005TmUvM2p2TVdRellGYUZCc1h5Nk8wNFQwbi96U0Zm?=
 =?utf-8?B?eno4aDJnVUdxUWVJKzN6VnZ6NUM1SUxLenNEQnV1K2IvTTl2cGhmU0QzSWs3?=
 =?utf-8?B?N285R09oT2dMM3Vid2l5WlZTbzdiT2MzQTd4NHNVSHFiYVQ2TllXdXlkYUVE?=
 =?utf-8?B?cUpEK2p4RTlzTVNyNTNxSVIvNEhEUWJnZDl5U3M4TTl0VXVsS0VlclJiaVhr?=
 =?utf-8?B?eW5VSnp3djFLbzJsME5NcExWbERaWWZEN1lNVXRNcE41MDRGSmxQRXJoNU05?=
 =?utf-8?B?cmZlMHY0Q2NhOGY1SnMwTTcvZkxIdDMxTXg0UjFtL2phNk1xMkhFMWhwRFhO?=
 =?utf-8?B?VWlKK00yeUpsUDdyUmdHQmN3WldxeGRKbFlVcTFwc0lWVmtoUmdzM3NFMDlK?=
 =?utf-8?B?MUViRVhYOXhxanV0Y05MazNSRkxpOEpybkg2Y2FZMXd1K1AvQ2pOd2tXaWIw?=
 =?utf-8?B?TDZsYUJodUh2SGNIMkpPRGVPTDdBS1R2cG5vd1V5eW1BaGtJNUI5cGdHMGJ1?=
 =?utf-8?B?Qmd5M3A5SzZZbjVoNk5xZytGSkRjakFOc3NkNnVRaXBwVVJBWmNJbU9pY2xI?=
 =?utf-8?B?QTI1eFVGN2pXRmJCK05SSEptaDcyUG9qT2s4SlJEQTlJaDV6bkljUUMwa3Qz?=
 =?utf-8?B?UHMyNHZBYyticjAxRVZzNDhHYmRkUEZIRklITjAxRXg0UHFHYnZmSkt0Smdl?=
 =?utf-8?B?MCtsekFaOFh3b0txaEN6UjVJWDBsMElqTzVVNHhwQTlGMndOcnVNWGNQTzhR?=
 =?utf-8?B?L1gxVWxKZ3Z4QTg0ZkpHY1M4U2Jjc1laRDhzVEs3bG9rbjZWdGxqMGJMRmRr?=
 =?utf-8?B?eFYrSUl3VmFNUVQzYzlndkpGa01TcG41Q0dldGJ6TWlvdEhDSmlDcGlRcGxL?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125f499d-e228-4616-befb-08dac1af429a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:32:50.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQXOtiQHQ4lMS5yR8173S5uLrkoYpSnDzyyKdTfRQaTBL0QsdGdCSIC5bqXOLUpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3438
X-Proofpoint-GUID: xgVHozEaYl9Ma57ELwGZMAHRaDPyp6Ur
X-Proofpoint-ORIG-GUID: xgVHozEaYl9Ma57ELwGZMAHRaDPyp6Ur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 6:28 AM, Sahid Orentino Ferdjaoui wrote:
> There is no reasons to keep PTR_ERR() when kern_btf=NULL, let's just
> return 0.
> 
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>

Acked-by: Yonghong Song <yhs@fb.com>
