Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487445757D5
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 00:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiGNW7F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 18:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNW7E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 18:59:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D718B38
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 15:59:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EL4D9p022845;
        Thu, 14 Jul 2022 22:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7af4PQ2QnZ2SJ9ct30OHFOBPX7XCe/ETcxrOwEbfpGI=;
 b=D4pDoKQLUtPXTVfUAUREzhvI94XwXRCFZcJ/mIraJ7Acr66G3NrBgHW63bUHF4YzvzoR
 Gr0Hjk6zBVAYLaNMyBNItqaPHF2V8QGJIdeXkR/xw9NUfZInMpaFkl+P/9iMqQy+gzMF
 z1wEsKAVp21130CtAIQPHOutXd1Pju7Dd9lMDaSy/ut+GboQb1hRVTfRT/BbKZ949Gfy
 gc7YKXaW2O5cgGzf6+7e4qE7uSUvD7uwzro5SEAma2OP9GWWgY5svNcZdoTnhhh1yKxb
 yD5sFm0mNkW1St5BemX4ZfA1l881FkYQPUuQUmAUSGozy5UKfAiATFwwvPoGmyw5h41L 0w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sq0yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 22:58:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EMtfYi036681;
        Thu, 14 Jul 2022 22:58:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046w9ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 22:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNvCJYfvo5L67Ye2MbuH9clOc2SxnXvRAT4HoRPZPE3arMZYEU52Auec44SjVa0sz7MfAPn2Ldt4bQrGQf3ofwkm8YNYwo8IjCJmq0iblH0L7w63UXkyq6ArJWlpVNRqrAUjmmGHqNAaKsjydoVAzEp+rfj/Ssy9ThwPiiEN6R1WVCIBWSZb6OogPqLZFicPY2QxfUQZhZKOzGc+zFpLRk+Ex6kBp/wFt91tvDgbGElnv86U4FGSWiCT5BgoSLK+9iwpQA0m2y85A3WQj3ypgdYx+xklothSB8kbq+9MGFYOg4fXqK/QFEzOP9+BP7VJL3todo2vw4vMkDbdXZYyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7af4PQ2QnZ2SJ9ct30OHFOBPX7XCe/ETcxrOwEbfpGI=;
 b=TnvgRpL9JDWxle5Nywb/Vyer/51V4K9TwCuGEJ9jSrYJbbgVDst8u5Ia2bfdJTcO4p+G+Z2XDCspeuy9MU40ithS4bK2l7PPb8BvlBrIzk4je2oWGAyXVkREmnWCjMPVAWHeO9rQWuP+P3mk3HIZMqk47bSUMkbwf1u/JmvHbjoO7Myi2JpyBwBhl9qBcowoBp+vSClRSzsvLJ3fdXvqOjLQM74lv11ruodLSLAE3lDt2MCVE+OKqVLdP+fImXaH5ZCAlEx4dQnxRgOV0maVqbwYDjuA9zypUWVqfm+M8oWV8iSZY2GMmpTsVuySH0e1TcdePqYpsjNA2zXMrhxZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7af4PQ2QnZ2SJ9ct30OHFOBPX7XCe/ETcxrOwEbfpGI=;
 b=LrELKZYnJ47VSJlYLCCSlt+mJ4kaCu8ZEKScEzWZld0fyEY/YMRDVY5YQL760x8j0KCgog96qqWie3rkxQAcD374qBpRC6hkGZeyKE5jg5iT4BqSbeDKP9K2ngK9zsvJDhzi21D11itOI0/Otsyy+8HKp7DyuavNSJYe9OAMzkQ=
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17) by BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 22:58:56 +0000
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b]) by MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b%6]) with mapi id 15.20.5417.025; Thu, 14 Jul 2022
 22:58:56 +0000
Subject: Re: [PATCH bpf-next v2] docs/bpf: Update documentation for
 BTF_KIND_FUNC
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
References: <20220714171220.1108229-1-indu.bhagat@oracle.com>
 <CAEf4BzbP3sDZgMc67XaNgVjm8RSvwQKJsjKoYv2Wsi6fdeao5A@mail.gmail.com>
From:   Indu Bhagat <indu.bhagat@oracle.com>
Message-ID: <37cb0587-c551-d69a-284c-914a5f6b3e9c@oracle.com>
Date:   Thu, 14 Jul 2022 15:58:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CAEf4BzbP3sDZgMc67XaNgVjm8RSvwQKJsjKoYv2Wsi6fdeao5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::24) To MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc91c68d-1be3-44b5-d1ff-08da65ec6dd5
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhF3jjXwA5C0qoKrP1+YJippcU7E36+pW+YURjvtnKOtMrOQNATFLmjFqs3gJcbWkqpbmt0NsMiC6dST1nMNoYJkap83wwV82nb3lkcjyB2S4rX3QFpOG1RaEnYy4PoylcYgPHlaOuDtuqeRDGZA6OHpV3x/0cz3aqysFL9qWRUFpasTfc54k0AKGM0wb7YMqynw9u+9ofCnxflbOaUeMEi9IHaPWDd9yDNWAdlM/798v9xzsY9/8vVybvQXETdXJeKlV7bnLJOux5BjyJ0csuHbVfqa0Jujujou6BH89f12zyNAn8quTlaK3tj7eq7lKadyO1o6xzyeGP7yyJIl0nzKpaFg+FIkN73wTuswKhhGrkIHgqWkb4yNsp+HTSggSAv36cnGHUQIT3/rn1oM7pZo5OHSQ1Unn/zFS+psf69qNdtPOQIz72xsc/q6C7d0wmVDgOZhrrvft+0DymiwWrnnwCSn/Di1Pak122pe5sXEcpf/L/XJ8U4djqUaMVjuBGmffTt7i5zPh6XmusF9bCZ17cbk3aYsaFfRzeuHZmKAVJvwAfICHs9xGHXIAZViHZn5crA2x0i4E9xmNnMIGdIw8Wl037mYgyPbllx6k+VLLqzzQCxklGJ2nWsocGE9wD82WpPtDR33VXsy8o6k/PV8byjHWpNZgf+tfGvPamTtMBrpwKAPPKyUB4U6O14ykjvMOgs5GGw9R1bsGHdSFB7aYwZx76bj1QJBui3uGmazDbAKUCkS6hxIXi7ub9LmnEwyu/W5SmWDJeE3XAOY+Xu9cb/yWmpXTaXMlmTt2ekF4ekWmPKI4Gj9kT2Xj/0V/3cZNJ4hpARmqz+3PpZI+kMcB54BN4hmR4S+nk4j0Mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(136003)(396003)(366004)(31696002)(8676002)(6486002)(38100700002)(6916009)(86362001)(478600001)(6666004)(2616005)(36756003)(66556008)(31686004)(54906003)(66946007)(41300700001)(4326008)(316002)(66476007)(2906002)(8936002)(6506007)(4744005)(186003)(5660300002)(44832011)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXY1UlhMQS9Bbk42bkVralpmUWRybk4xby9wcmpzTnlDYWNoWDhkRWZSWmYv?=
 =?utf-8?B?TmhCc2ZJWENYSndNUEJ5WXd3Z3o2LzUrTDFZM3NOM1ZVVzBnaEJ2bk00RHZ2?=
 =?utf-8?B?ZkZ4dnB5NWsvZCtwTDFLc3FNT1pPM051OHZTbmNteW5xOWNGT2JpUW9EZ1BX?=
 =?utf-8?B?VlMxQWkxZmlJYXNjVnJlV1VPUUFQcUxMcFZhTkFYOUE0RTdFTmxDODJQNGNi?=
 =?utf-8?B?SGRRODNSd2xHMGFGR1NzK0JnNllWTCtrUHR3OWMyRlhaWTRoblhUbUdrT0hH?=
 =?utf-8?B?MXk0K2REOGJESktoQXF5aVA0cis4a1J3RzA3UXcxL0tMdnpjcmZPNFRaK3Fq?=
 =?utf-8?B?WXArRzFpWk55REtmblpzVlNzb2ttbFFkdjdpcWpBVGlTS2JGaUdNcmlPKzFN?=
 =?utf-8?B?dnBqQkZuSUFLdERYOEFpOFlkL2pYaFFjTTByMWQ2UGh6aGdvSWZMSFllcFVI?=
 =?utf-8?B?eXVUTENONVh5RU45VFZ6Qk1aZWROR3pDdWtLSENLYk8vZXJMTjZmYkc5Zisz?=
 =?utf-8?B?eHFoNU40a2JjUWE0emJWRjNXUVZ6cmRaRGxKZVFwU3lpSzFjbjJQNElVSmVL?=
 =?utf-8?B?NDdDYzlBTGNTM2VTSWtKQS90YkM1dmxxcUoyYTRsNElrZy9uSVVqVHU3dWhM?=
 =?utf-8?B?cHVUM1hkVWhqaXJkR09NdGJ5blQ1OVlmVVYzSFdLcHNqbDRoQ1FSTjBUOW5V?=
 =?utf-8?B?RzVMN0I3dmUwb3FYbHlJS1hja3Qxc0VSNG5kSDNJUldiTVN2TjVrVmJTRS9m?=
 =?utf-8?B?UW1haC94ejBSSnJkd0JBQ3loMlY5SW9GNjBQeXVDbnVDSlBJL0lVeHEzMmM5?=
 =?utf-8?B?aWlycm5CQzdWQUdlTmRTc2NPVG4vZFc5UlAyMUNjeUdTK1dGNTJzaUt0YVdD?=
 =?utf-8?B?VGtkNGhWVi9pZ0hFdU5LTmVKZWo3dmNkdllCQ1FrTG9PelNnMldpMWw5dnJY?=
 =?utf-8?B?MGc2VFJRNmFkcTdzMjlwNnFMdlE5bVVZUFgySy9MY3kvbXlrMEV2MnM0SG9o?=
 =?utf-8?B?Y3VhOTZyR1JnTUpETERzbEhRVStqSXV0SkZ2Um5qM1ZncUVUQWtSN0ZpMXh1?=
 =?utf-8?B?b0h4cjJRRXgvT0pTRlJpV1labUgycXZlb1Y0T1hTZTJQbWJkMCtzN1U2d0lE?=
 =?utf-8?B?dE5VeThUVk50MnJXcyt6ZndZdjdrc0NDS3ljRTFJQXJvK25mOThPTVkvbmcx?=
 =?utf-8?B?R3VqelVUUlpucnZOL1k5bEliZHVSbzVwTXJmLzlkZHMwVkIrc1Arbm5oblZh?=
 =?utf-8?B?Q3VzVktPdFhHd3dINFZ2aXhCWHluUVVwdXZiRUN0YkZZM0hLMTFOYmd5b09u?=
 =?utf-8?B?VXJWNnpFdVNSbXhOcG1IVlJ4ck5QT0c2R29CZis2YmcvUnYrLzJiSHo1NjQr?=
 =?utf-8?B?TlQ2dGEwcjd0ZldhdExBTk91UWpjeWJkSHAyMGlvKzFta3BnR3dWZFRBYzVw?=
 =?utf-8?B?ckVNTEEzUkNla1RJYWRuWjM2SHR4U0pBWXNqbHBIbEZKcndlYW55cDJ3R2tt?=
 =?utf-8?B?dDhtMU5HekYxOHlKc29XTE04THJhOFdaclQ0UkxWVUhQYjFzVEZxZGlQeTRh?=
 =?utf-8?B?MWplbGkyRVhVekZpM09La0NCZEg4Vk5CRkxjY1UvM0RsNzhHN1ZFMWEvVlFk?=
 =?utf-8?B?ZzRCK09DQ3c3MFBJaHJ6T2x4SlpoZUNyckt6NU1QdFdibS9sTjIyZjcyM1RW?=
 =?utf-8?B?eXpmVi9WKzlTWlRnQkJOUHNQRktzdS80amRySVdUNHRiRlhJYVNKRWxrOTBa?=
 =?utf-8?B?dmVvN1lVV1FOankxcjBkMjFZUEM1dGE3UjRDamFZRXhjZXNQNXNyT01EOFNH?=
 =?utf-8?B?SUlSWTRydGpKNm9QRlVLOUVUK1BjdmQ2T3A2RWRMbG95enpud0ZVVTlqcGFY?=
 =?utf-8?B?aDBhSDdib3pYd2lsbWRWZTRNN2c2ajZZL1I4TlZwUFhpcithc0JscHJqMTJq?=
 =?utf-8?B?a0svVkcwYjFPcEFxK0g3bG1zN0xuRmU5UjJKR2hadXdDcC8xdG9JTi9MR3pL?=
 =?utf-8?B?czgzNjNkZXB4NU9uSXpVQ1YwelJuVVdOMXNUT05YSi8zNDcvUzNoQzZvMW5s?=
 =?utf-8?B?ZDh5Zll6Q2wwWTVRdjlHODBNaVZsY2J2MDBlMU5yTlFEV0kwc1BYN0puQ0JD?=
 =?utf-8?B?bWVPQjJWNjc3WjN2YmJjclh2elNSZVVPRUxzN1dtOEludjlUamxCTTdnbXh6?=
 =?utf-8?Q?LouC19qQH9ljKYaykmPeJ7s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc91c68d-1be3-44b5-d1ff-08da65ec6dd5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 22:58:55.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIoMjYrf38uh+rgQCE/JZoZkcVFervE6Shj1r1gDUK4R/OQsjowtM/vaJuIQigz+6EoUdyn26p2byy4Y3LreGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5030
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_19:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140101
X-Proofpoint-ORIG-GUID: ZALo6_eEJDLFZwH2B4NvBcT1ZBePMHPy
X-Proofpoint-GUID: ZALo6_eEJDLFZwH2B4NvBcT1ZBePMHPy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/14/22 11:11 AM, Andrii Nakryiko wrote:
>> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
>> index f49aeef62d0c..3f9cc9150c89 100644
>> --- a/Documentation/bpf/btf.rst
>> +++ b/Documentation/bpf/btf.rst
>> @@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
>>     * ``name_off``: offset to a valid C identifier
>>     * ``info.kind_flag``: 0
>>     * ``info.kind``: BTF_KIND_FUNC
>> -  * ``info.vlen``: 0
>> +  * ``info.vlen``: linkage information (static=0, global=1, extern=2)
> 0, 1, 2 are not arbitrary integers, those are enum btf_func_linkage,
> which is why I asked to mention that UAPI enum here
> 

Hi Andrii,

I have sent a V3 to take care of your comments.

Thanks
Indu
