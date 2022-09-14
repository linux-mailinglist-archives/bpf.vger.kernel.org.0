Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64465B8E1A
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiINRV4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiINRVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 13:21:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2743332
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 10:21:53 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EEZJPw031251;
        Wed, 14 Sep 2022 10:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Aj3XjhiHtVXI8B/yMnShFqo5cQ1LyYoX9gHVcwEKqJc=;
 b=exKZOxgXVPbTf+cy6jQzV9UjyeIegwovVAH+7N5RMsJOhbf+Z/lvmWEjaRv1kBSYKpJq
 uy8G/p5bYj/HsGZvuWgXNYBKF9mgedtZgCT/2olKb0/voYnnAQpHOdIwOw4zqwOzGcJX
 t/MKssjtbSkFHz7WcBTnMoTJ6yCLyWEwlpE= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jjy0p79w5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 10:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz5tH2+3RNnymlbC9nj8iEOgjLvkiR4Prv1aR0VxZBPp+EOCU4AY3kJCwNCdHI0+dn01rLl0KQ1SNOhBoYBTRqsjeuzKH31TX/MN351GLazKJWK9R6EJeZbwKJa7aAoGhdk/a/TEOvRKsVnNnN8BJgDguAyPpiIT9JrmJc5H+C1dy9UhLBfTOKPKe3SkIHPDYZaptuNm1OVQsbXzYnNkth2g0K5rTJStkv43ttpC8Y6dS4K5szVqkzXPqWP3k7iJXQjljheNpsAZl5QlmSEDxFWWfxc9yjDt5y2Ork7MXJ/oFinW7akEBoXzyCZLCZup4S6omGcLmnY4vV1EOaCD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj3XjhiHtVXI8B/yMnShFqo5cQ1LyYoX9gHVcwEKqJc=;
 b=J5KR1AyBtIzaPQawAU2d/UbtoqbIETKXDSsr57s4BI1+XykrzWVa8Sj+73hcZA9/uMW+RiPIZUWR4C1yjTikxKPLfJ7RzRB4l4FhFXXSfI9V5KK4JXAeXpo0QxSHZWP+FcrKXDDweJrPJVuf5nFqH1gkMDcZSeifxWqSd8GOihfkX9x2tmfmoVC4z7Oos01UDiSAYLe7kLs++fvsnB5H8tY1ZfBHSIEFeZ8pWARRet+nmO1V+zk7u5NCs2aql5JSiQPgEc/VjaQyMJ1yAkwhRl4bcYrqtSBHZb2T3f85ih/o5O/7imrdnbNAgfttEkxQPVqDq/0JFTnTfJO16/ubWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2679.namprd15.prod.outlook.com (2603:10b6:a03:15b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:21:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:21:32 +0000
Message-ID: <11249f5c-2179-27c2-6595-59afe88a8bf2@fb.com>
Date:   Wed, 14 Sep 2022 18:21:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Allow ringbuf memory to be used as
 map key
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220914123600.927632-1-davemarchevsky@fb.com>
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220914123600.927632-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:a03:333::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2679:EE_
X-MS-Office365-Filtering-Correlation-Id: 1313c46b-42c2-4c20-d5e8-08da967591bd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gW4MjOQS7bXbnHAE9hxqD8S9ukFrSvCbRz0U9bbn9+hX6jvonKMnso9leD49+KA5NpdRGDLiquOoFDQZ8NlVtiJEuOPkKwtbpoZFvXiQ4LAO02GDFxKTJiCvV6siOqmqXMlP1R3+5p6syu5jaBS1sLBKk2IhbAdtuvfPbliQnwiWmIOCYIVzwR2tMlKx3IUTQSjORWkusF5GGk+A+X24xRbS8yBlxkiPydR6NbuKCCyNrExsEYNNcCORz3cFr8JVR4YJdQyai7208PYd/itLw7w1Sf0lKm5+F++7fQRN11auaVSoUPeITTtX8EA8rO8HgChM1eNG4pu/op9hiiXMNJPq3qzR1yeZhtOHifPUj65/24/PZ+YU0OE4/2pcrhnG2n7dfrnhfQZQF1fvNAk0dfPbXdY26QdHni2E/NBTxbzVWKF0hjaeGxup6BuaFq3fro54a3miTdD9qUGI9Ogfrg1xWKD3p2dkHvrSpwhPEW4E1o6fDHls6/Gbwcj5gMnF/oiK6ujUySVWc84Y69LRZ6Fxc8og7wG6bvvd6D6f74xLdgOXKQML3KYrGVfKKYCWEvwC/nNuLxobDPIUKgCeft6Ydo0Ctwj8G3snkm4tCzL2nRBGBFDbSK0QSYkbAFxjPOVZNMIQgxS9o6kUurBLXyuGOe3OZ3KKMyCWW+i5zAZYn59h70B+yy8YnF7sYILQuILiLjb/XFNDFwgkehcv1ckdLPN8wnzzCIy9sfNvKXcarnEC+a84UUNg3kaDklCXsGYk6dY7vABPw2zbAlYVmkkGpaC0K2CYLAKOJZ2yUUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(41300700001)(5660300002)(6666004)(6486002)(316002)(54906003)(8676002)(6506007)(86362001)(31696002)(66476007)(186003)(2616005)(478600001)(38100700002)(66946007)(6512007)(66556008)(36756003)(31686004)(4326008)(4744005)(8936002)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmt6MGR0czdxRTFDekpaa0UyWXpIUlZGaVBaWlJacHUwQjFMc01VdmJzNWpj?=
 =?utf-8?B?Zy8rcG9NRlAzSWFWOUxZWWtaRXlQckNqbUwwNzdwckluTWJHZkFXbjFOeXhE?=
 =?utf-8?B?MGRxTlYzQUkySDJ5dFBtMlVBQzBJT2F3RjBhVnZxeVJvQkVBaFQxbU5rMDNa?=
 =?utf-8?B?d3I1Tmh2TmY2RmFTbGYzSmNqZkpRMmlzUENid2sxQXJWKzNoZUVjYy9DK2VN?=
 =?utf-8?B?clZwOG4rcW1DNFkyNFJEWWtzMUUxd2Nwc202cFVWOFJlQlFKZGdtUzNxVWFB?=
 =?utf-8?B?aFZIQ3VJclNjbnQ3Y09RbkJJdmNwc3VXb2VCNTBMREJzc0ZTRy9yWDVEQWpP?=
 =?utf-8?B?dGtPeFJEZDNWRXhXOVdDUDJ0djFnTTYrdko4YjdyQkQrcytXZS9pZGJETGNh?=
 =?utf-8?B?ODBDQmJoVFRrbDFnSnRySTF4bytDMVZhNGYvY09zZ3FDM0pHVk53andvWmhr?=
 =?utf-8?B?QkkwOFFyVUdiTUlrY2lKYis2ZkliSStkTGdITlN2WVNLdDNEOVQ0YmlucStt?=
 =?utf-8?B?SmpxQmZxYkhTKzV6WGcvcVdITzB3aUNHTng4VUlWNlZkbTQvMDFtcjhPNnYx?=
 =?utf-8?B?anVndEVqVFNuTXhreGFSV1FlRFZmTzIrVkluZ0c2SXNlQzVLUi9Tc1U4K2Zh?=
 =?utf-8?B?Y3p4UU9COHJDUWFsYW9uYWNUY0hvRnNOQXBaRnZOVWpBV010Mzl4ZzlZSnRI?=
 =?utf-8?B?Q0IzeWwxampxUWx6VVBycGs1bC9EdS9VTmkzWER6UWlPOGlhL2FNdXFGaW1j?=
 =?utf-8?B?dHNES2hpSUdvSGNZSG1NcTZBenNvdWdUT3ZKY1JrV1RyNGIwbVpjWHVUS054?=
 =?utf-8?B?a3lBTUVNVTVBVmQxRVRNVk1rQ3drR0hkUmNranQxVS9RU3l1d2d5RmpEdEl3?=
 =?utf-8?B?d1ZVWnhZblY0SDMySU9lQW11N1ljQWtKV2ZUcXdodzUrSk5JaDhLN3diKzZV?=
 =?utf-8?B?emUvTkNvWWJHcW4wckRLaGVOS1k2Y24yQWdadkZYS05UNG5JeFgwb0h4NEY3?=
 =?utf-8?B?NWNmajhRQno5clZKR2ZUMEJlaG1KbkNhUHkxNGpPblpwakwrZ0YxdktNT3ZP?=
 =?utf-8?B?bVdaZUZrNmJKeXgvcG1sSGJjeXJiWVM3aUFHZm55YWxJWDJ4MnBKOHpOQk9p?=
 =?utf-8?B?cTV6bUc0Y1I1QVBHbm5RKzZ5bTdMMW9CWElTVFRRc0hETnBUTnFycFZaanFk?=
 =?utf-8?B?NWxRcHBNcVg2ZnZLdGZIZ01ZWkRqMVh6MU9wbGVyN1cxcDNvZVBwTnNHSFpM?=
 =?utf-8?B?dkRjdS9Tc3VkYmRrbUVJcjFER3RoNFVSMER3UW10cTZ2MHhUQW1IK0ZBTUdh?=
 =?utf-8?B?N2NvUzAvOERlK3UvVFFjbGkwTG0yQXJZSmlYM0I5UGozMDRmOWNtV1FGSXNS?=
 =?utf-8?B?clQxT1BZYnB6VDNxQVVIRnA0bHNUdXNaUTNKdkdWMlh6RHlmNEtaZGZTZlUz?=
 =?utf-8?B?WW5FQkhwNVp6T05HNEp3NW85YVIrUlVqK2J4V05GRFlZejZEbVBaclo2VTN6?=
 =?utf-8?B?c0ljc21XY3VTcjVZZW11TEZjRWlQSmExclB3VmpQM0Y0QjZYZ1J4WWlqMzky?=
 =?utf-8?B?eXQ4MmxHYkFpeWNDSFV2Y2I4Wm1WZlVMcGlSbmV3ZVNoajZJc2I5UjVXUXJr?=
 =?utf-8?B?aUh3ZCtQVWVJS3puMGlURFlSOXFJNC9pYy91RFRsSHozM3hmU3pCNWlkdWlJ?=
 =?utf-8?B?dkhYMzJDWjhGWE9ra0NiczFHS3gyTzZVTnVjbkYzblF2bGlJVFdaRkd6elVr?=
 =?utf-8?B?MHVQTUk0ZE05R0pHVGdobE5XMGNvbTZIQk12L3NPaUpsb0FMNXNleUM4WVRv?=
 =?utf-8?B?V3JzYndWZFlGZlFXVTJMVm9LYVhvTmdQUStYZkR5U3VKUFJiMDIvVGhxbDhR?=
 =?utf-8?B?MUhrKzVRVmF4dlFnZisyd2NGN003MnVHbTFuTEtGTjlMWklBYnlVYUovQ1cz?=
 =?utf-8?B?SHRkTmRLQ3JsdGNFQm45N01HLy9LWk1aZHRONDVrS3ByVXBXeS9hUGRyaW1p?=
 =?utf-8?B?S0c3aFBXTDdHWFZGQ2hTV08yZGxoSWFIbHpxUVR5YUhPamRHeEFnek1QUzlU?=
 =?utf-8?B?aHJNQnlobm5uSGFxMDFHYmc5SWlOc0hrS1h4YlNJVUFkdk1pRFd6L0ZmTGZD?=
 =?utf-8?Q?R8OUrntah1xwhmC1jMUFE/4xQ?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1313c46b-42c2-4c20-d5e8-08da967591bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 17:21:32.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtdMFbtQtXoZ3QFKdIxvMLrQSHi10VadNetsc0VuEQLQ0h41tGbOivYEBFDkvMbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2679
X-Proofpoint-ORIG-GUID: zJau8pfXDGLWXf_lFJf6MqbTTe7Mgig2
X-Proofpoint-GUID: zJau8pfXDGLWXf_lFJf6MqbTTe7Mgig2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/14/22 1:35 PM, Dave Marchevsky wrote:
> This patch adds support for the following pattern:
> 
>    struct some_data *data = bpf_ringbuf_reserve(&ringbuf, sizeof(struct some_data, 0));
>    if (!data)
>      return;
>    bpf_map_lookup_elem(&another_map, &data->some_field);
>    bpf_ringbuf_submit(data);
> 
> Currently the verifier does not consider bpf_ringbuf_reserve's
> PTR_TO_MEM | MEM_ALLOC ret type a valid key input to bpf_map_lookup_elem.
> Since PTR_TO_MEM is by definition a valid region of memory, it is safe
> to use it as a key for lookups.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
