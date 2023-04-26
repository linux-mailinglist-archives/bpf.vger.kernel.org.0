Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A119E6EF882
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjDZQd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDZQd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 12:33:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F557D81
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 09:33:53 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QDBFlk004355;
        Wed, 26 Apr 2023 09:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NmSajco/kWYCyLAQoWWsZZIl0f0g0H3y5VgBTMms68s=;
 b=RaXFHLqec05ubITaZPHPfXRIQV1K613D6ZSAnnw35+zRbr3sikEuM8e2RvwN8jzoBqUR
 hMl3byjYs9NZdnmbagLRlyUlkxON01i+uAmtHOjXa145YnXYLcfw/Fc5NBwPnLvVvdhx
 reOjWcIjNwuHu/dVEFufot6nqA5R78YkwOuYYXebXKkCuOwd+OUbEmdI8xqn3KbbEmjC
 PaH2HxkIIfhuvBn01XXYktPsdpnsOiqGv3t+eScz9UM/5JMkWyw+UmiSiZlhLV3L1iC7
 iBdhYIro1ip8aThJH3fXUvSB7B3top7Tx1K/kgij+uyj8dIKZVn7vs5ptjkjPtxOFAj2 zw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q74m7hfy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 09:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOmPAbCOkKiZfjVVAF2roq3uDnfT4UzBt/HagVhqKo1Ct2UHKY6C4lPcb60l6GNoJdmL5Cdrt651e0w/cXRQ8pm3ZEWvPFLaIakoZkUsdr3FFKCGX8Gf0IDShDEGYVQR7ALvsOU0b8f5u737RgxGXgoyu78kZ8NUuGwS5gkV1U9T4jhBWuh4ZDiBz61lXVK2N/wJ4owF89rc7zHk15cO8FiNIJLNQKwIqlWdG5qTFjBmFU6mFLlIRkKFBBsfmygc2RNMwYkWuTO19uNDfmh7tE5qwEhtEnU4hIAoBD2agm2/wxjMSYUjiko2RyCrQDnecmkTQJ5S6dL6YOpcr9fPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmSajco/kWYCyLAQoWWsZZIl0f0g0H3y5VgBTMms68s=;
 b=Z46gCs0gGBkVuUenWQjPiLoOLw/O3UVZtiiP+nPNaHgf0MIt5wLAlXbG3Y6rriJMa0XDrImn7truF53/1cjOI/qFtRR7331wpvzjLx1sOFrR7VcAhTqh464hNWQqQr4reYWxOjAwYRvq0orvwvMIjuHYBDT9B3XZPbrlVwlhdrOFMsmlGqAb/vTY36531jI3CbntxgL0Yt3J5eMnsndbNkpy0WFWa2ZmNMvmPa1wU9wY9hoYEJ7n91H9gzaG7Wp0xG4aqYW1ycPlGJbasWaYimWnEjMM/FWsgY3vx5PHUz/yuz8to6Div7nPpe8TdgoM//yFlUfnckY/AsmZslPb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4453.namprd15.prod.outlook.com (2603:10b6:a03:372::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 16:33:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 16:33:30 +0000
Message-ID: <aad14430-39d2-eced-f857-5eeaf64e37d0@meta.com>
Date:   Wed, 26 Apr 2023 09:33:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpf: Make bpf_helper_defs.h c++ friendly
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, Peng Wei <pengweiprc@google.com>
References: <20230426155357.4158846-1-sdf@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230426155357.4158846-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b38499e-3a8b-49cd-c8b2-08db4673f863
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXKBbMiwnxrCzpYF1p1vfEi9MpchltVL7xyB6clunh24rIsV3L+0Lv6bp19OiiDUtE9kynkYdOK60DDKTJtqW8izi/1rux77y/lI9UCY85laK4s+D8X56PIObS2AIaC7SFzjqjjKxitY879UJFV8X5wpEgXAgv+y1Faf3D60ddbBwRA48sTvdhcLqiIA2UUCutqyW6T6wZhJXRSWX8NZkDSUc8U5ri+2UzJN1jJzRiSEGlNUjMOGlVTXnL1nXI2AjJSAS3+ROQA7VAEcWd+lJxCVailo6vksYPtFzCH4Cr63Qo9cckMyfH+eyQ1sA4eHsviXNVqotSqBFEbZyQ3ScufxMh/a5AOq436TVbhmJ8k+hiqTgcEpEDDTC5maAslY4HNKWak1cwVD2ezl2Wvg4IOfL/kKPfQO7UcwLwG7IeVp6m5XFpbHSuB0ecJPEgS7CVHv/p3K1hbs9uHxs9tbBeAdprkeQxZk29chOKoxvwWzkv1v0vDpCXMCe4ytcDbtoQAyIZnv1SXGBXUiwwDJRI/x1Vb9Xe8G7S5osRjL1vkUcVHch5Dn4/KpbEyu0hCHUtHZE5lpmwVMCLKgF7NWw3Or0QBSVrq9Vtk8aDPItJNMOiDFzPrs/WhuUjhC8dSxDeFO/tpTsyZ3680iZS0XWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(66946007)(478600001)(66476007)(4326008)(316002)(66556008)(8676002)(8936002)(7416002)(38100700002)(41300700001)(5660300002)(53546011)(186003)(6486002)(6666004)(6506007)(6512007)(2616005)(31696002)(86362001)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHl1Rlc3T1crMjRLSFk3TmJDZHJOWGpKTzBlTW45VnBMbkozb0V4V20zKzNT?=
 =?utf-8?B?ZUQ4OUt4dERHdnZwVUNmRUZFdFZ5TlpHS1FuemlZOWdNWWxOTXJVcGZqN0Zw?=
 =?utf-8?B?akVPWkk1Unp0eUpXbkxnUXlwbGJnVEZOR0gyZ1Nqajc3RWlOQ1NKeUUrYXVz?=
 =?utf-8?B?QmJEY1NmOVB5UnlqQUJSSzVNT1VNQ3FKeVJyOTRnTS9rRHNtZmVSRXdvY1N3?=
 =?utf-8?B?YTBoMFRDdmhyanAzVnpIY3F4UUthaEpiNjdFNmsvMWpJOVdaTDlMYU9GVENG?=
 =?utf-8?B?d3pvUUJ0R2VIdkhPQk9kdndBcGhOZElUWC9hVlU3MFpibVNHenpCM3pSM2s0?=
 =?utf-8?B?YzlFKzR2c09tRG45M2M4a2c2RTd5L003S0YrV1pKSFRraW1DRkE3YzhLMEVC?=
 =?utf-8?B?NkNaZXY5R0tzbHkrQlRZMWd1U0VoeUZVVHNlcDN1UXJnVGU0SWNqTWZqYVVE?=
 =?utf-8?B?cGl0b3NGUWRiMGlLbzdpUWtHRTVUVmZoeFJuenJ2eWZFS0tXb0ExejlsMk1o?=
 =?utf-8?B?dCs3Nllqcnhsc1lCa2cvNEhaeVRnRE15VFNVRC9WS0dsVUdtNEtpU0xLNnhL?=
 =?utf-8?B?Vm1WRHFkdkUyRDJtaWw2eUxIVTlNOXcwOWV0WjZaZ1lZNFZLVlZhK3I2VTJT?=
 =?utf-8?B?bUZLaGowbTlUMEhTcnZaaDNZN0pYVmJ0SnJvY0ZkVnNmTFpKTHp6YzBpZVBx?=
 =?utf-8?B?L2FoYUpUblpoZVQ0QlNMcHRYZXNndk9jTHJCSTh6ZHVnUVM5Y2tuaVorOTJv?=
 =?utf-8?B?WmJtYjJGNWcyZHdkdHhNS2lJN2dsMzZNcDJ5SnE4UnpzZnVvSlF6NGhLb25z?=
 =?utf-8?B?ZWZqTjI3bjJLaDZLRys4RzdOaEZCc0tPdE5EYWVhbEpIK0xmSkJ5aTNHaW1n?=
 =?utf-8?B?UVh3UDh1YzRlOUNqMjRuNzNraVd6QXhLVXhTNjRKSzFOQjUxT1U5RzQ4NFNw?=
 =?utf-8?B?b1dybDNQNTAxeGNnbXhFWDhXUDg5RFM1NDdiRDlMdTVRWFZSVFljdHMwSTI1?=
 =?utf-8?B?S3lMc2l0SENBN1Y1cStQVUs3ZnlDZVBYUVR2WGVsSGZZMVN0bHcva1FTMUJL?=
 =?utf-8?B?cXkyTkpjdDFRemMwOVFNem4vQjhoeDFEZkdiR0hjNGpKMlJtTGZEZk53Q0V4?=
 =?utf-8?B?R3JQV24rUmNlZ0Z6UmFlWiswMytzZkphTjFsUTlWQ0UvZXZDYWJWSVdMcXpq?=
 =?utf-8?B?MU9qbXZiR0hUaS9Fa29ZSWM2NUQyQktWcDdKbGdoWWdaT2dXQlJvVGZiTTVq?=
 =?utf-8?B?ZEpJYkhiK291K2Ura0F6M1FTN1F5Z3FGOXJyZzRUQzlrTCtJbjRsRGgwRVdY?=
 =?utf-8?B?Tkp3Q1dQSkRNdjVxMmhVR1piNGFQOWZsNlJud2hRL0dDelJieDIvNlFObHZR?=
 =?utf-8?B?RnE5eDJVUS9wZTUwMEdVT0J3VTZYa01lQVNCU1kvSGlVTXdBNTNHV0oxdmJo?=
 =?utf-8?B?TkIzZnBmTVY4MjBhZHNOdndrY25NdzJuNjVFRFFCbTVvU29vWHBhc0F6eG5l?=
 =?utf-8?B?WElaUHhmVzRDdlVveWFiY3c4aTVEMVNHTTdLU05LNUlMd0NMRmZTRkQzZUNR?=
 =?utf-8?B?OXNRdnp3a0hqNXQ5SDJ5WDFJVVMrNEhPb0pUcEY2bXpvVjlpWU0rbHpkZnVU?=
 =?utf-8?B?VlNTU1lWNW9yN3A3bFBuZGpDMHB6TFZlRlNxU0ROUW5oT0ZMUUZkOEMxQWJm?=
 =?utf-8?B?b3hOdStadjgvbGtxY2NVMENqaFlPd2FmZk52NEhhTmF0YXlTYlF4djdCZWlV?=
 =?utf-8?B?UVhiZ0pkWGY1ZHNySkRib2h0c1I1emk0WVpXdFRZUGNtNllhTVJ5Sk9KM3pN?=
 =?utf-8?B?YnppbjU2eGJnN3VYV0RsL005SHRIWU80R3I0Wi9icW9Dc05ER2s3ZmMwTkd0?=
 =?utf-8?B?c3c5Zm9CZ2RRNWdmeERQazBIWnU4K1J0bVZNUnJSOGI4dGk2aUFGYk5GN2RC?=
 =?utf-8?B?ZFRVdmdGUUI0cGwxcmIwL3IxZnZUdWFPTDdldHBkc0w4eG9BQkZpUk12NVJQ?=
 =?utf-8?B?MHliWWRVSHVXVGJ5Zm5WcXlLSTVBMThiYzVmaW8yTk9RaWRjNjY0NFNXUXp1?=
 =?utf-8?B?MlY4RUpIR3p5Nnl2RE9EbFpHbnQ3Z3JMbXRIazExRnVKOFkwRG5tdjBCUHRs?=
 =?utf-8?B?ckQzRi9KME1mUDBYK3prR2xWc1I0MFE5VDBySWxxVW9uU3M0OWNSTE1qSHFH?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b38499e-3a8b-49cd-c8b2-08db4673f863
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:33:30.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AahtFE8tBt5nMDX5b+sWPiPKq0wV5dG++zp5y+Icx4cnf4L2Dj/DzXW955jrztMq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4453
X-Proofpoint-GUID: FdA27bjZIxcJ49Y3JNG4DVbFvAh_Bqhv
X-Proofpoint-ORIG-GUID: FdA27bjZIxcJ49Y3JNG4DVbFvAh_Bqhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/26/23 8:53 AM, Stanislav Fomichev wrote:
> From: Peng Wei <pengweiprc@google.com>
> 
> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
> possible due to stricter C++ type conversions. C++ complains
> about (void *) type conversions:
> 
> $ clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
> 
> bpf_helper_defs.h:57:67: error: invalid conversion from ‘void*’ to ‘void* (*)(void*, const void*)’ [-fpermissive]
>     57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>        |                                                                   ^~~~~~~~~~
>        |                                                                   |
>        |                                                                   void*
> 
> Extend bpf_doc.py to use proper function type instead of void.
> 
> Before:
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> 
> After:
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *(*)(void *map, const void *key)) 1;
> 
> v2:
> - add clang++ invocation example (Yonghong)
> 
> Cc: Yonghong Song <yhs@meta.com>
> Signed-off-by: Peng Wei <pengweiprc@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
