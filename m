Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71066E6E8
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 20:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjAQTXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 14:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjAQTQO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 14:16:14 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF74521C0;
        Tue, 17 Jan 2023 10:29:52 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HG5bpv015831;
        Tue, 17 Jan 2023 10:29:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=C/hT7Tv4fi98Fxv7MB4HU6aQsP03NiHUf0OuTPG5Ytw=;
 b=aUucQG3CxIGYP+i100tLHYXWwqML5SECy1SZClwwZoOvM8eNZGDkDgMiKvqv9yq8oRBQ
 khoZqrYJWmgWc1vg9pmBVA/pkzNL9UU5hIQ/AAqMOVCU9hpI0PPPwrhp1KbiSZgnFaDg
 /NuftH6tixmlYtH+vwuKzlmsZsmC95nAXqC7n6QI+5PGEl/EoYsetF6MUvASnQ1YHur3
 u0OrtrevwpAAEPiwRv4qOr3TEmnxkY7iM0UlpeddmLL3RILmPdrvTilDRVgI9TyXoUFs
 WPlC/asFhq+zg0itSCk56qlNWQY6LOYUV/34nuDF0d6t6OgFO08dPTXBPPX0ZStk8cKt Tg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n3u16e3sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 10:29:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDHi5dTl3h2ZN52JixLsg5GKkki70c0+z/1lYfC40P/E7nrsExFtWbfPiQ0MvLDwnefjl3PYioQMsl5SLkuOa1cpBVUqVDIaJdJ9cbYRZVPnuehgw/UrmtysUQIMgBbs2nokckhIyGOAJA0MQcdjPE8wmotd9/cLSuIJbVvXw2W84WlxlpZlIcrysJFTahKuSPfFW3muUT30ZIMwBD8uwe5Czd+pcsMKsnzwMEzLjhs7wIiSmag5sBUuDwu0RCTDx49JZSMlOnA/uD3ojkXQfb2RbDkcicYchRO/iAzs+hgstU/W0oivLONJ4rFrmSAcrVE0Ms7EN7eHpU0UTbe63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/hT7Tv4fi98Fxv7MB4HU6aQsP03NiHUf0OuTPG5Ytw=;
 b=e83FvJ9XfYh9IqzXqV7Rz8QS37nJQvbI9lJTiy1n5E6KG4/gPdfgDENH0Ez+hHeFP/Fqdqj6Hx2Mo7zYFCWYAyRsAPLT2k6FhRZhaxp7PRcCZfXUaKFfCYADbI/UxY2ev15/zrIWC0WcDCApRst3SV2xGGyXEnqgpaQoqFipxMn0V9Zq++jmFvZ1rREeFFPngSgsJ/kKGpEJF90YJ0xdD2OnRY618zhtDeVAUUtazWTN6dfqx69YChQUn4yQ+aKfbv9pvBn9P3C/GIkZ+J1KNDTqiKYWbSKpCSbUTBHRE95OjDqnmQQ8c4jugMPVKBQSiLG6teaPN5YbAmDfBQOS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5741.namprd15.prod.outlook.com (2603:10b6:a03:4d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 18:29:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 18:29:23 +0000
Message-ID: <f8b5ef05-4dd1-eb3e-c6e0-af47169d7b8e@meta.com>
Date:   Tue, 17 Jan 2023 10:29:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix undeclared identifier build
 errors of test_bpf_nf.c
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alan Maguire <alan.maguire@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1673844908-11533-1-git-send-email-yangtiezhu@loongson.cn>
 <14e0f634f084d0f07e447638c490da60943507d6.camel@gmail.com>
 <556dc633-e7fb-da8a-1fa9-757684edd3a4@oracle.com>
 <dffe5523-4ff7-8b27-46fa-079a9556166f@meta.com>
 <d299be28-42f5-b387-5b54-74694ff5f340@loongson.cn>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <d299be28-42f5-b387-5b54-74694ff5f340@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fc298b-e8f2-4a45-9a5d-08daf8b8c1cc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qEcHxSvrwHBV5qP0mGBmToNXKTdI8ggMC/xU5CFGJ2VsnN/EtZysOwpEWFpBI19JEDrYs9MDfu90c7YdGYF4XiPYPmC3ypiiY+PkfDTYp6LGqkFj8+nq5lzvDmF565ScCNq2nGsDpD2m3g1FW7+ZGolFx/f7OXEiMQ8ZHqOJU6/Z1ATtuismEBMdBN0seq4Lb546bmFfwLugzE0q3Yq+gaUxlzdNzNQDa64+GJV5rJJ9QIFSHZgEgZwMvO55erUNvjEXyaK+7lnwBuAr4nxglWZYaxYTwgX5WlZFQrSPrR0E2HbUT/tOWgmAT5QIySFBbPq9IT1aYJlrquA8Nwl7sJrn7UkFu7aKyjNe66zgyIa3M42RiMgfeOAoKc1A84swv/+SzovqcLIIkMgDkoaYpR63ztozf4a8HZw5F9Frpeffqhv/m6vgdd5M/qpSy8nZ0oWaZKUf43upN2Cf4xf0hHQwTQcOs+LGn8sijx3Ox6Y9tO0gj4xpBWIX2YTTFmsZyPl7OZTag+nBU+1ylFpk0l3R5sgR4PHHYa2HkVgPkExcUMWoUfeGau2rYwQp6RAUskMWDIqhqBzXmjrakjBNNFSAEfWxk8Pdot9Y9jbnpH8DSLf/GyUKLLsWcq4gfh5wJdjpxXMe80XlAJwsTiDBB32EBauQe2CIwwRYqZYGL5VJIsF4DYMigkQErqD6kbYyz7bHZc8xNRuLaBXJub4m5Qx5N/RHgp7XXIPwpT5s1bl0JbnEst1I7QDYvI4tXtf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(31696002)(86362001)(36756003)(6512007)(8676002)(4326008)(186003)(53546011)(66556008)(66946007)(66476007)(41300700001)(2616005)(6506007)(316002)(478600001)(110136005)(38100700002)(921005)(6486002)(30864003)(2906002)(7416002)(5660300002)(83380400001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRVc0QyN2hKM2I3RUV4bis1WnZ1YysrUkROMFl4bkNaaGpJZitZb1ZXS3Ni?=
 =?utf-8?B?Wi80aEErVlFMOFM0UDB1U3Z6TnVVTWRQK0h2NU81Y1JlZFNmbit5YlRFekxI?=
 =?utf-8?B?MVZLUzFRUmFObFdMZ3FXZ0w3a2NqRk1xYmY0WGo0Mmw4UkFFVFVaenZjSDFi?=
 =?utf-8?B?RkdJaEs3TGFZci9aMytrNzNvUFNaU09rRC90WXdGY2RrcnhlNDlRVmVaWjZK?=
 =?utf-8?B?YjZJc0tWaUFiaHE3WG1TcmNqWE8vM3ZBdlJ3YXBsQWFoTjJBYWtUT29KOG1o?=
 =?utf-8?B?YjlBZ0dwczYraDVwVU1nU0phejVoaWlXaFAyckU0UGUrU3RSNTFwR0NjWDZN?=
 =?utf-8?B?ME5KMUJmVFVQQWp5ZnczV21EM1BnL3MzZThSaURxdVR4Qm1lSEdyMmM3d3d5?=
 =?utf-8?B?QXYrUWlGQ2duamZzT0h2Wmt4UTFaV0Jkc3pwNVNGSlN4MXdFc0RGNmtwNFRN?=
 =?utf-8?B?RmVYOHVpWFNPYkI1MWZTQ2VYWWpncHF5bzBmY1VDN3FyYzkxaTY2YW9qaVNZ?=
 =?utf-8?B?SHRKQ0FNb01aY2d4YUE4L0VpUFNkVG8xZ2h6SktZVnBQemQycWt2enpseWoy?=
 =?utf-8?B?U2RLdlpUai9mMmEwQUcrSGRvZ0tMNlg1b2ZDcUxhSEY5dDNoUExkbEI3ejRD?=
 =?utf-8?B?RG56Z2lEOWpDRERUcnBxdUZMZHZ4eE9hOW16Rndtb0xCLzhPbWVOUTZVdzZr?=
 =?utf-8?B?WFFvRWVwMXhFdFVDQktSVC9SdU05d2g2ektxdWFEbWpYNktjTDVpMVpRTk5t?=
 =?utf-8?B?SzNtaVZiTTE5SHhXMHVjZzJOOFM0NkdZYitrbTRMNTNuZ1RPOXhsMXNjeHZs?=
 =?utf-8?B?RHZ6aDIvUTN2bjhFRXBPTDJGMWhtWk9leHRTVGExUVpwU2thdHNUbnNKMFdi?=
 =?utf-8?B?NXc4MVRYNWlrenNieHlpMnl6SktMSzU1R0UveHgwYUlZYUsxUDFlYVZBZ3NL?=
 =?utf-8?B?ckdIRzVnR1ZoZjl4OFVQZHJHZVVydXpVOEV4eStJVVlEaWI0aE96TEZMSGZS?=
 =?utf-8?B?VUpZMFVhY2VhVFJINUErQjA1dEhOOFE4bVpDNUlpRWhWMUgzeWFHQkx4aXBU?=
 =?utf-8?B?eUFzaWdyVE01czhsSXM1QVN5ei9XbmFLcjJkVjFlWFRBSTNjZnJtSVFXUTNR?=
 =?utf-8?B?ZkhCekM3N092SmxnSmsyWlRYVVdmaWVwV3VsL3h3ZkJxTWpCRWpVNzVmTnAz?=
 =?utf-8?B?Um5QdktCMXR2bmg5QnZQb09EQjlMY3dtcDlISyt0ZUtmR2VVcGczYkxpV2dr?=
 =?utf-8?B?WDBla2ZuclB6Mm9tMnkraTg2MlBQRExlYzR4Mk44M1B5LzlBTUtPZjJFdnRh?=
 =?utf-8?B?MStUZUZtSTlwZ01XcGpFa1h0Mm5nUXVmR01vMWlHTWlUaW5UeERmK1pFQWEx?=
 =?utf-8?B?WmRhUGZLZWQycFIxTjVoY09ZR20vOEg4eFFUdjNZZE54WEcvbkd0c295czlw?=
 =?utf-8?B?M0crT0h2U2lkaUVWKzJXV25MYllKc0JYTlBsbGZ4bjI4UmlDOGxxdjJreGFx?=
 =?utf-8?B?bkpZdURUTkp4V0xvdmc2UmJodndsSDhqWWR2K2xFNFpKUHgxU1VCcXEvWDdR?=
 =?utf-8?B?TEZxenNiRHFueUplNllDaUpPK2d1S2VDR0taeUZmMUp1ODl0Y3VzcE9YaTg5?=
 =?utf-8?B?d1djcXFEWmF4bUxCa1RnQTcwdlk4UTFxYng5RFZmUGJyNUdJL0ZsYlY3RWJ0?=
 =?utf-8?B?WGZmQm94RVNCVmJUMmVYT1V0eXFta3IxT1htZ0ZvS1hDY0VFU0pHNmwwWTkr?=
 =?utf-8?B?bnEzcGduYjJ6MFBubWNVeTg0T1pkelQyODh3MDlCbStZOFlFZSt2ajE4N2NV?=
 =?utf-8?B?VEZxM1gwQ0ZoZENsOW9mL1RXMCt4Q01UVXJPdU5tSEcrKzhnZTJ4VDZGcjU3?=
 =?utf-8?B?a1pmOU9JYngwWVNiR21DWXFhK05hQVRFRmRnMmp4QmVDN2t2TGF2YzBISUZU?=
 =?utf-8?B?ekdKZGRzMzNZYUY4Tjd3YXR2dFBRZzJIeXE4NVVjN3IvRG1GWjI1d0hUczhy?=
 =?utf-8?B?Q09SNFk4TlZzS2U2d296M09VTmQzYy9OblliNHRwcXM4QU1zRlE2VXZFcjhD?=
 =?utf-8?B?OUhBWHB5dnl4anJ0ZkE1Rnp3VUlYNXIzYU9uZGNNRWx4UmppSm9pSVcxZHdt?=
 =?utf-8?B?clo4bUM1VE0xeGdNUG9ISDcyT0llNE40MW4raUtxdGZrelJ1WWFJUEEzTWdL?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fc298b-e8f2-4a45-9a5d-08daf8b8c1cc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 18:29:23.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L60120/lm6VbCxgDf7zXuCofCTTLXntgExWMkbWCjX8tw7KK8LpQ/9NY/M+y9SUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5741
X-Proofpoint-ORIG-GUID: B4JeUvGQrgZqBV2NwSltd805PU3QK6xJ
X-Proofpoint-GUID: B4JeUvGQrgZqBV2NwSltd805PU3QK6xJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_09,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/17/23 1:52 AM, Tiezhu Yang wrote:
> 
> 
> On 01/17/2023 02:48 PM, Yonghong Song wrote:
>>
>>
>> On 1/16/23 5:54 AM, Alan Maguire wrote:
>>> On 16/01/2023 12:30, Eduard Zingerman wrote:
>>>> On Mon, 2023-01-16 at 12:55 +0800, Tiezhu Yang wrote:
>>>>> $ make -C tools/testing/selftests/bpf/
>>>>>
>>>>>    CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>>>>> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier
>>>>> 'NF_NAT_MANIP_SRC'
>>>>>                  bpf_ct_set_nat_info(ct, &saddr, sport,
>>>>> NF_NAT_MANIP_SRC);
>>>>>                                                         ^
>>>>> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier
>>>>> 'NF_NAT_MANIP_DST'
>>>>>                  bpf_ct_set_nat_info(ct, &daddr, dport,
>>>>> NF_NAT_MANIP_DST);
>>>>>                                                         ^
>>>>> 2 errors generated.
>>>>>
>>>>> Copy the definitions in include/net/netfilter/nf_nat.h to 
>>>>> test_bpf_nf.c
>>>>> to fix the above build errors.
>>>>>
>>>>> Fixes: b06b45e82b59 ("selftests/bpf: add tests for
>>>>> bpf_ct_set_nat_info kfunc")
>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>> ---
>>>>>   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>> b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>> index 227e85e..114f961 100644
>>>>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>> @@ -34,6 +34,11 @@ __be16 dport = 0;
>>>>>   int test_exist_lookup = -ENOENT;
>>>>>   u32 test_exist_lookup_mark = 0;
>>>>>   +enum nf_nat_manip_type {
>>>>> +    NF_NAT_MANIP_SRC,
>>>>> +    NF_NAT_MANIP_DST
>>>>> +};
>>>>> +
>>>>
>>>> This is confusing, when I build the kernel/tests I get the declaration
>>>> the "enum nf_nat_manip_type" from the vmlinux.h (which is included
>>>> from test_bpf_nf.c).
>>>> Which means that this patch results in compilation error with my
>>>> configuration.
>>>> Is there a chance that your kernel is configured without some
>>>> necessary netfilter
>>>> configuration options? Have you tried this patch with BPF CI?
>>>>
>>>
>>> Yep; I suspect if CONFIG_NF_NAT=m , the required definitions won't
>>> make it
>>> into vmlinux.h. The reference tools/testing/seftests/bpf/config has
>>> CONFIG_NF_NAT=y so it is at least documented in the referenced config.
>>>
>>> I'd suggest going the route of
>>>
>>> commit aa67961f3243dfff26c47769f87b4d94b07ec71f
>>> Author: Martin KaFai Lau <martin.lau@kernel.org>
>>> Date:   Tue Dec 6 11:35:54 2022 -0800
>>>
>>>      selftests/bpf: Allow building bpf tests with
>>> CONFIG_XFRM_INTERFACE=[m|n]
>>>      ...and adding/using local definitons like:
>>>
>>> enum nf_nat_manip_type_local {
>>>     NF_NAT_MANIP_SRC_LOCAL,
>>>     NF_NAT_MANIP_DST_LOCAL
>>> };
>>
>> The above won't support core, and since preserve_access_index attribute
>> does not support enum for now. We need to use bpf_core_enum_value to
>> retrieve the proper value through CORE.
>>
>> could you try the following?
>>
>> enum nf_nat_manip_type___local {
>>     NF_NAT_MANIP_SRC___LOCAL,
>>     NF_NAT_MANIP_DST___LOCAL,
>> };
> 
> This is OK, it is similar with commit 1058b6a78db2 ("selftests/bpf: Do 
> not fail build if CONFIG_NF_CONNTRACK=m/n").
> 
>>
>> ...
>> bpf_ct_set_nat_info(ct, &saddr, sport, bpf_core_enum_value(enum
>> nf_nat_manip_type___local,  NF_NAT_MANIP_SRC___LOCAL));
>> ...
>>
>> bpf_ct_set_nat_info(ct, &daddr, dport, bpf_core_enum_value(enum
>> nf_nat_manip_type___local,  NF_NAT_MANIP_DST___LOCAL));
>>
>> whether it works or not? Could you also try if the
>> enumerator sequence in enum nf_nat_manip_type___local changed?
>>
>>>
>>> ...to avoid the name clash.
>>>
>>>
>>> Alan
> 
> I tested this on x86_64 fedora 36, using config-5.17.5-300.fc36.x86_64
> to generate .config, CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=m, there are
> no definitions of NF_NAT_MANIP_SRC and NF_NAT_MANIP_DST in vmlinux.h,
> build test_bpf_nf.c failed.

Thanks for trying. Yes, I tried in my environment and it failed because
I didn't change the enum nf_nat_manip_type type for kfunc:
int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
                         int port, enum nf_nat_manip_type) __ksym;

But when I changed 'enum nf_nat_manip_type' to
'enum nf_nat_manip_type___local', kernel complains kfunc argument
mismatch. The reason most likely is 'enum nf_nat_manip_type___local'
is not converted to 'enum nf_nat_manip_type' by libbpf.

This might be expected as preserve_access_index attribute only
supports record (struct/union) type and libbpf might just do that.
Could you double check whether this is the case or not?

Maybe it is time to implement preserve_access_index support
for enum type in clang now.

But we need to resolve the issue, even temporarily for now.
See below.

> 
> $ grep -w CONFIG_NF_CONNTRACK /boot/config-5.17.5-300.fc36.x86_64
> CONFIG_NF_CONNTRACK=m
> $ grep -w CONFIG_NF_NAT /boot/config-5.17.5-300.fc36.x86_64
> CONFIG_NF_NAT=m
> 
> I tested with various configs, the definitions of NF_NAT_MANIP_SRC and
> NF_NAT_MANIP_DST in vmlinux.h only depend on CONFIG_NF_CONNTRACK=y.
> 
> (1) CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=m, no definitions
> $ grep -w CONFIG_NF_CONNTRACK .config
> CONFIG_NF_CONNTRACK=m
> $ grep -w CONFIG_NF_NAT .config
> CONFIG_NF_NAT=m
> $ grep NF_NAT_MANIP_SRC tools/testing/selftests/bpf/tools/include/vmlinux.h
> $ grep NF_NAT_MANIP_DST tools/testing/selftests/bpf/tools/include/vmlinux.h
> $
> 
> (2) CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=y, no definitions
> This case is unable, because CONFIG_NF_NAT depends on CONFIG_NF_CONNTRACK.
> 
> (3) CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=n, no definitions
> $ grep -w CONFIG_NF_CONNTRACK .config
> CONFIG_NF_CONNTRACK=m
> $ grep -w CONFIG_NF_NAT .config
> # CONFIG_NF_NAT is not set
> $ grep NF_NAT_MANIP_SRC tools/testing/selftests/bpf/tools/include/vmlinux.h
> $ grep NF_NAT_MANIP_DST tools/testing/selftests/bpf/tools/include/vmlinux.h
> $
> 
> (4) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=m, have definitions
> $ grep -w CONFIG_NF_CONNTRACK .config
> CONFIG_NF_CONNTRACK=y
> $ grep -w CONFIG_NF_NAT .config
> CONFIG_NF_NAT=m
> $ grep NF_NAT_MANIP_SRC tools/testing/selftests/bpf/tools/include/vmlinux.h
>      NF_NAT_MANIP_SRC = 0,
> $ grep NF_NAT_MANIP_DST tools/testing/selftests/bpf/tools/include/vmlinux.h
>      NF_NAT_MANIP_DST = 1,
> 
> (5) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=y, have definitions
> $ grep -w CONFIG_NF_CONNTRACK .config
> CONFIG_NF_CONNTRACK=y
> $ grep -w CONFIG_NF_NAT .config
> CONFIG_NF_NAT=y
> $ grep NF_NAT_MANIP_SRC tools/testing/selftests/bpf/tools/include/vmlinux.h
>      NF_NAT_MANIP_SRC = 0,
> $ grep NF_NAT_MANIP_DST tools/testing/selftests/bpf/tools/include/vmlinux.h
>      NF_NAT_MANIP_DST = 1,
> 
> (6) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=n, have definitions
> $ grep -w CONFIG_NF_CONNTRACK .config
> CONFIG_NF_CONNTRACK=y
> $ grep -w CONFIG_NF_NAT .config
> # CONFIG_NF_NAT is not set
> $ grep NF_NAT_MANIP_SRC tools/testing/selftests/bpf/tools/include/vmlinux.h
>      NF_NAT_MANIP_SRC = 0,
> $ grep NF_NAT_MANIP_DST tools/testing/selftests/bpf/tools/include/vmlinux.h
>      NF_NAT_MANIP_DST = 1,
> 
> (7) CONFIG_NF_CONNTRACK=n, CONFIG_NF_NAT=n, no definitions
> $ grep -w CONFIG_NF_CONNTRACK .config
> # CONFIG_NF_CONNTRACK is not set
> $ grep -w CONFIG_NF_NAT .config
> $ grep NF_NAT_MANIP_SRC tools/testing/selftests/bpf/tools/include/vmlinux.h
> $ grep NF_NAT_MANIP_DST tools/testing/selftests/bpf/tools/include/vmlinux.h
> $
> 
> (8) CONFIG_NF_CONNTRACK=n, CONFIG_NF_NAT=y, no definitions
> This case is unable, because CONFIG_NF_NAT depends on CONFIG_NF_CONNTRACK.
> 
> Here is an alternative change to check whether CONFIG_NF_CONNTRACK
> is m, enum nf_nat_manip_type___local is simple, which one is better?
> 
> $ git diff tools/testing/selftests/bpf/
> diff --git a/tools/testing/selftests/bpf/Makefile 
> b/tools/testing/selftests/bpf/Makefile
> index 22533a18705e..f3cf02046c20 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -325,7 +325,7 @@ endif
> 
>   CLANG_SYS_INCLUDES = $(call 
> get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
>   BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)          \
> -            -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
> +            -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR) -I$(TOOLSINCDIR)  \
>               -I$(abspath $(OUTPUT)/../usr/include)
> 
>   CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c 
> b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 227e85e85dda..f2101807072f 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -2,6 +2,7 @@
>   #include <vmlinux.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
> +#include <linux/kconfig.h>
> 
>   #define EAFNOSUPPORT 97
>   #define EPROTO 71
> @@ -34,6 +35,13 @@ __be16 dport = 0;
>   int test_exist_lookup = -ENOENT;
>   u32 test_exist_lookup_mark = 0;
> 
> +#if IS_MODULE(CONFIG_NF_CONNTRACK)
> +enum nf_nat_manip_type {
> +       NF_NAT_MANIP_SRC,
> +       NF_NAT_MANIP_DST
> +};
> +#endif
> +

The above change does not work for me. The complication failed with

   CLNG-BPF [test_maps] 
btf__core_reloc_nesting___err_missing_container.bpf.o
   CLNG-BPF [test_maps] test_sysctl_loop2.bpf.o
progs/test_bpf_nf.c:168:42: error: use of undeclared identifier 
'NF_NAT_MANIP_SRC'
                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
                                                        ^
progs/test_bpf_nf.c:171:42: error: use of undeclared identifier 
'NF_NAT_MANIP_DST'
                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
                                                        ^
2 errors generated.


Apparently, IS_MODULE(...) is recognized but it returns 0.
I do have CONFIG_NF_CONNTRACK=m in my config.
Note that I build the kernel with KBUILD_OUTPUT=<another dir>
(make -j LLVM=1) so vmlinux is in a different place.
While I build selftest
with 'make -C tools/testing/selftests/bpf -j LLVM=1' which
is in-tree.

>   struct nf_conn;
> 
>   struct bpf_ct_opts___local {
> 
> Note that when unset CONFIG_NF_CONNTRACK, there are much more
> build errors, I do not know whether it is necessary to fix it
> and how to fix it properly. Here, I only consider the failed
> case CONFIG_NF_CONNTRACK=m.
> 
> Thanks,
> Tiezhu
> 
