Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26F5224E9
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiEJTkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiEJTkj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 15:40:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3FE21E332
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 12:40:38 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24AHDTd2030832;
        Tue, 10 May 2022 12:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9EB4XkpeGSUkrpD4GsFE40JCV85yG85GfS1G7M9WJFU=;
 b=NiwnkybjKqKW0irjS1lj1zFO/pcH5YPOrWaowDxQMfP+qdke+3p/WpFBQyEu2xBT8MKJ
 Uk/xXAnondMAnCO0fO8QH9Fiavhst/ielF0f07ulKdo4eugcjz3LAPxxyQvbfquiFlTg
 GC/GJzEZShEPvzwXFBb8iR1y6D3Ct5dNO+4= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fyv8ns9bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 12:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC6052gQOCJaEKNEI2fPoCIfOmHlcUKcMepfp42PvNKwSd4Z4kNYnTv5EIqfc5qNmaJ85D2pNEOzDTW63ojT7nq0THkadfPpM+ESRkLT9CbvmGqVmW4CWEhCk5MB1N6y6g/wkOvYfh6vMO85P6VGNxIwY+PoQx1putFaip6zvLvREvgSVh8H/4t9Tf9V7MbEIhNJd040rVOR9Z0TaFRrBNXY8tViSHbQLczCY/nbenlacLMtBtU67gAJkyyU4/GrNzB7rqqSYBj1Z047SN4EbPYzGlfYRJttPfJEBDiSg0yxlhw7eGcTa5fK32PTG4elG27ZPyYze8pcdcSnxqgQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EB4XkpeGSUkrpD4GsFE40JCV85yG85GfS1G7M9WJFU=;
 b=HVut4pujehIQAUDjIG8+PInUOJBKijYkoG1MDrA32WBJd4HkdQd4O5pKJaYQeyiWpMKDH4b7CaRgkj4cIRXGhgO1jfW/MYnzcJ9hLm4gBV66tbqEemjkXDOKK+74pRRhKQyNDrzmOpCoNc6lPAOB8h2s05eSVDwb49zx/mVckaVwtOPXjyi+eP8YNBSTm+6htjF3JfYY4edVdnGe8DuT01zJ7sB29FrJmYGS97YD0C8OuL7wLhhww6RPhlPfmlTOHelgABsXhArcgC703xksMpbtv2cGTxRDqCr79+Z2zLLgHlvO3Gbuy9LYbmWHiGgtq3s0Zduv6xHhpfx7C6KSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3120.namprd15.prod.outlook.com (2603:10b6:208:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 19:40:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 19:40:21 +0000
Message-ID: <d99b2ba7-e29f-dc19-b052-a147dbdb336b@fb.com>
Date:   Tue, 10 May 2022 12:40:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 06/12] selftests/bpf: Fix selftests failure
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190033.2579182-1-yhs@fb.com>
 <d99ef512-5c1a-0763-c780-d7f37087c23c@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <d99ef512-5c1a-0763-c780-d7f37087c23c@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd70ca7c-7182-4abb-dfb2-08da32bceb60
X-MS-TrafficTypeDiagnostic: MN2PR15MB3120:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB312017A1DD9BADE0F73F8275D3C99@MN2PR15MB3120.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiUgCakpP4HxrABh1YdPNUMEcjVHNbaz0+QGJgsqR3NBWXGtBxFfeH7zzbri8Xyn38aNSIK4gSAPfvx9/BbeJb4Urtrztvh49q3tybeZg9MVxNLDyS1CaqgNEmUms8n2wsYjlTIuT4caiEhESyzD+8OfkrhjsttEywseDo6lqxu1QVS6P2ATe2U8fNqhYdXdy8Guk5StiUYdtHw/C7XR/sCAGFnTnFhKjo439EjzQnGCw9cdySg4G3hybGOUujcCivQAHdYYoZtmF3Ca6ucTshAdKdEXoKo9Pr6RoPLLUT3PGPh+Y77k7SwFbvpjhV0WUfl3wAUBE/GHKGPShfR4Tp7CUFC2X4VSaagSxnb4g7AaBpQpBpZPGLlsp4lu0IXzkewscTon3O5tyvTTA61I4uaCggLiopjiFs7/I672wELnNfG2g5DsYtBOfN+rJ0X1oE2VQiPFJWOINSfDqWvqdtqlVo40NW5saSpmNhYyOzdFS6mJgrFYR9brGRq5HOxSL99Q1VyGbJHFOdk904Tvl+79/jF6V51R+j8NCFfGRPPTAexNFCI/4NhWkY1dMUtHaomrLJijAm3/eZNdj0iEhGm3rUjQ7UJDFoqKveVPUp26Ud1+mYXnMaj3CAWwvYiPLgh2AHXtAVb3lxRAOSuI9c7unAxjpYXp6tKCykY0+vP0QVOJHd5D5bZHGZlgv9Hl71KCLZ0+jigSUr5n0L6sdCI8VbPZmxBh0DskeY16LvujmIxw4VtnLvyjNmehda7q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(38100700002)(31696002)(66556008)(8936002)(316002)(54906003)(4326008)(66946007)(86362001)(8676002)(66476007)(31686004)(6512007)(83380400001)(52116002)(53546011)(6506007)(2616005)(186003)(2906002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJIdnJnVCt4dlA5UzEvUExmQ1NOQytCWkZIb2VxdXJlam5VQjYrOG5zeFJ1?=
 =?utf-8?B?MHl1QmZtTXFTZmUySEY5QUlUcnY0R1NDN21CWHBJTGJCWWhlVlpVUmdlNElH?=
 =?utf-8?B?ZWI5QkRjdHoxNHNPbTNFTFBnZEh1TWZIWGhXUDNKR3dJdmJLaGUwTXhFczN5?=
 =?utf-8?B?SzVrRDNhOTVLTmlPUnRTd1UzWEN5ejkveVZoRlh4bzRWeWFCa2ttQnF4SWVG?=
 =?utf-8?B?ZXV6Q00reE1xbFBsZHI0aUR4aXQwS3RGdlExUVA0T2p4a0RMZnFRb0s1MkxL?=
 =?utf-8?B?ZElhcmU0dFRNeFkwcFBBSHdzRkJ5N3dCZUNEMnhDTVN3UVRaSEs1c1QrSTNQ?=
 =?utf-8?B?Z1FnaUNVcDZmaVVON1VLNHE3OGhueklvcWExMjhJbXRDQkRjdWJmSklyWEI4?=
 =?utf-8?B?UzFESzZPZmd5Q1B0SUFmRGhublNGQzhleFRLa1QzUE9VNWpzMG1NQ3AyRkpQ?=
 =?utf-8?B?cTZET0pyRjVjUlU4LzN4Nmdra0RQSG1TWHlwQlF4b2RDQnc3azBaMEowdTZ3?=
 =?utf-8?B?ZGpaVVRaMzByUjFnQU1tTVFpS0tmalBwRm1pVjRSUmh1Rkw0RGJPZ0hoVi92?=
 =?utf-8?B?cVJ2VXFuNCttQi9LUGU3eHJSRStVOFozSUJNSkcxL010eXdWYjZKNGYxa3JO?=
 =?utf-8?B?YXh2eGdGc01lVzlqZm5sY3JlME1uWW9uTGtRM1ZvU0VKVUkxcVFVV1I4TW9q?=
 =?utf-8?B?L2tROThwNE9QK05VWmdlSDZNL1EwY2liQkFNaERUZklieTQvTFZ3TjZScHd1?=
 =?utf-8?B?MjBCajIxWkdRZW9yY1dyeHA1bk9zY0IwZlBvbGRlSUNvQm5iUUd0MDNoZnJQ?=
 =?utf-8?B?KzZKMCt1KzdZWWJuZndFWXpUb0l5M0FwbnhHT0hCdWNBb0dOSWhDamxVUmRi?=
 =?utf-8?B?U3BKbis5amZjRzBJeVdlOWpMZGFTV3hhbHlFUEVGVFhnUWRMd0hrLzBhbWdD?=
 =?utf-8?B?dkpoZkJzYVU1RWRkeHRsWnpyVm5DbUVqS2pqYWU1THZleVI4RTJ1cVVueSsx?=
 =?utf-8?B?YTEvVHNqSG1CdWdzRGt1QWZlVi9mZ3hwOEN4cWsvYUVDUFdrcW5yNEZrSUw3?=
 =?utf-8?B?L3hNajNOUGxMeVlzNXc2eFJRL1hHNnU4ZjdDVXUxYStMTFpLWWdBb2RNVVN0?=
 =?utf-8?B?SHMvRWRTU1NJcENtRjNiVXd5WlRyYUdGcXgzVDJRbGxzeExNeU9nSld2cnpC?=
 =?utf-8?B?Q2xGQVowTjM2L2xMMDFkWGlCbFZNM05QSkZ6dVhNUkI5YkgrWHRDMTY3TTJy?=
 =?utf-8?B?YUE2MXA0d0ZRMzRYT2FKUXNzY21hQVJ3OTE5enNOMmEvUkxhQ0k1OEh2TGRB?=
 =?utf-8?B?bkRqbXFFWERMKzNHTEorelM5Lytzc1A3SjZucDExN0tOQjBOcFFaNDdibmdr?=
 =?utf-8?B?ZUZHb3VwWklNem5kdEloY1k3U0FGckRNTEcxUkcramk5VDJlVlVEVUFhVzhF?=
 =?utf-8?B?dlVNUTRtVVU2cVE0bUdIWmg1N2dpZVcyVkg2SHRRcVdTUkFVK1NIcWZhR1hm?=
 =?utf-8?B?Z3lVVEZwNHBaZmlQaWMrMGIyUkF6anF6RVArZU41Nm9vcEx1Uy9MSGlRUlVn?=
 =?utf-8?B?L1h5dVo5R09iM3cwYlZLVWNLSHZsQ2ZzVlRNNlBGeEFOMzlMMStSemJxQ3dv?=
 =?utf-8?B?dGl6ZFBiUFA4RWY5NjRWSjNxamlOd0xkZWZ5YW5aUXVtek9oVndrSzZJK0xt?=
 =?utf-8?B?dEZVNklSbHV5a1h0eHF2ZVhrU3ZJTWdZQTY5WDZRcldieVl3T2VGUTM4a1Uz?=
 =?utf-8?B?Nm9BMFlwR0NUbTg3OThLaXhjMEdqaDBHanFWUnQyQ2Q5N3dVRkY0RGpnVzZh?=
 =?utf-8?B?bWx1UnBmd29FMjBzdE0xNnZVQVZlUXl0WCtvSzNvNWl1TllMbDJSeUZIaDJ6?=
 =?utf-8?B?d1VlNWYrN0FRNkZrZUdXNmlHMm5wUXBkbi9SVDEwdVN0cnR2dDhmSkt4Y2R5?=
 =?utf-8?B?enlFUVhmemVwc2MrMnZ4eHYzMS9wOE1zMFd0MG5qNlNzbGJHaS9XR1dJVEZn?=
 =?utf-8?B?Zm9WM3RDdmxUK1R3TUVEWFlYNFJEampweFVmcm9PODNJVGJ1UTdyTjlpNlZv?=
 =?utf-8?B?dDRtL0wzRzY1ZTE2bndlRENxMWZzOW5JeStQZW91aUR4VVZMYXIxUjJXNkpm?=
 =?utf-8?B?NEJhUDNpZnV0MTEwZEgxYmFZQnQ3MEx0cG5MWmFidUdEaDl0b3ZjM2NHZ3p4?=
 =?utf-8?B?bE00T1pibGpoZjc2cHFoZ3kvOXdUbFF4NDVPMnlYQ080ZTZlV1F1TGdHVVlG?=
 =?utf-8?B?bUd0RkNDdmdPdGZsMHdxOCtFNldVU3MvZUxjeEdNSVg1UVg2cVlYeW5CNlNk?=
 =?utf-8?B?UjRNWWY5Z0VySDEwVVdmMW4zNlRJQllwbXdhdXdxc28yWDdxUlRtS1pkZzlL?=
 =?utf-8?Q?8gjTU93NmCf2lVa4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd70ca7c-7182-4abb-dfb2-08da32bceb60
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 19:40:21.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5clGCIeBq551w4E3yPGH1axhEWWXHvZUqjEqzfmcRrpKVvST/NVSt7+coHXJavh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3120
X-Proofpoint-GUID: KF2vQgyFF5e22h9eWf0vNu3NA55NQx97
X-Proofpoint-ORIG-GUID: KF2vQgyFF5e22h9eWf0vNu3NA55NQx97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_06,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/8/22 7:21 PM, Dave Marchevsky wrote:
> On 5/1/22 3:00 PM, Yonghong Song wrote:
>> The kflag is supported now for BTF_KIND_ENUM.
>> So remove the test which tests verifier failure
>> due to existence of kflag.
>>
>> With enum64 support in kernel and libbpf,
>> selftest btf_dump/btf_dump failed with
>> no-enum64 support llvm for the following
>> enum definition:
>>   enum e2 {
>>          C = 100,
>>          D = 4294967295,
>>          E = 0,
>>   };
>>
>> With the no-enum64 support llvm, the signedness is
>> 'signed' by default, and D (4294967295 = 0xffffffff)
>> will print as -1. With enum64 support llvm, the signedness
>> is 'unsigned' and the value of D will print as 4294967295.
> 
> To confirm my understanding, this signedness-by-default change is for _printing
> btf in c format only_ and doesn't correspond to any difference in interpretation
> , since all BTF enums before addition of new kflag were assumed to be signed,
> and new kflag's default value is signed as well.

Yes, the signedness is only used for printing in C format. For
values, the signedness is really depending on corresponding declaration
type or the context where the value is used.

In the next revision, I may change the default signedness to be unsigned
to cover common case like
    enum {
       A = 0,
       B, C, D, ...
    }

> 
>> To support both old and new compilers, this patch
>> changed the value to 268435455 = 0xfffffff which works
>> with both enum64 or non-enum64 support llvm.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> Aside from the general question, for changes in this patch:
> 
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
