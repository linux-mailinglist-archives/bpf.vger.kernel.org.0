Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4023C64FE
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhGLUc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 16:32:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16976 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230058AbhGLUc5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Jul 2021 16:32:57 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CKDrbc017622;
        Mon, 12 Jul 2021 13:29:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WbnTTatR8pK7foG2kaMU335gaDgCHH4Gbe5kRFk7BG8=;
 b=iuQS4iZUYDpze6Evs+RENs1nA35Mn8WMV+tiuch7m1h/hjt8wAwwptit8I78T0OgHsff
 FHNKuQ5pL0H7hQLkTSnFqLbLJxyDFbi+GTGdT4eLX4TmjQhiEUi7wHcva3eGxZinLtgp
 gqHk+n5BA0W19KNoKwQFhua3NxHJ7zTnRg4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39rscn1nxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Jul 2021 13:29:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 13:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXWIqR1k5NcZxVKYbYtVTqV2jUWtgUxhP3TaJu7TvnfCDRt5WpA79e5t15lyQohgPwmX6qk/pBfrUQe+b8+Y0MityGrk+IdE7OulU+++xf6V/aesd+HDhVWUGvqZPzbVfaSrPQUEUesXajAcITsRls5afkvxZBNc0b/PlzYUca16x8TTfEtnbrihbCre1qn16MZTRFpYDG4M9LddeTuFTKh/wDEZMh69mYm4jc55eitQ/1hl8JvfU1wU7J/9MsoypYY/7QBS941mLD0xl3TTo14h4GaAIiI2x2qJinckvzO9Wm9fd5x1E6DK4T8ogUAt1oJ5voBIIjBqQ9s/5r3OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbnTTatR8pK7foG2kaMU335gaDgCHH4Gbe5kRFk7BG8=;
 b=QfR11/XAkK/KKBoEoLuyhoGK9JT73LBfDmJJRdMF88S7RiIyxjkk+4bGFbUmWkjcylOt2XHRKEE4fqwoSWl/PZkkItP3jsdaitprCPsf2qFDoF0gTET6vlr90i9UMl8fVmvKfOi23puCaAdJZL0GaUb5qy84c0ps2JrhW8/efzIP/M/n3aJpud3w2FHlWKSpFQl8RgcT+s1eRJXKu3HS8nY+TiYTSTmoxYbi40zKGw+5UP4tsnwixmyBi5LzJKAkX/97vHPUi6jMpHBEGpzDGudJYsT2pkXwhXISZ6kz7EbWuZB69JuOaz2tNzgoKnY/+AygC4l4pAgBz0ERdhPKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4096.namprd15.prod.outlook.com (2603:10b6:805:53::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 20:29:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4308.027; Mon, 12 Jul 2021
 20:29:51 +0000
Subject: Re: [PATCH bpf-next v3] libbpf: fix compilation errors on ubuntu
 16.04
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20210712192055.2547468-1-yhs@fb.com>
 <de4d44a7-32a9-e558-3c42-ed983f355320@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <05ccc682-8994-6c81-4cad-9e8e27593121@fb.com>
Date:   Mon, 12 Jul 2021 13:29:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <de4d44a7-32a9-e558-3c42-ed983f355320@iogearbox.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1156] (2620:10d:c090:400::5:9a8b) by SJ0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:a03:3a0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 20:29:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc420d1-ef16-4d58-b824-08d94573cd37
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB40969C5C129920134FF336E5D3159@SN6PR1501MB4096.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51wpOIEoeHAgLA7PfzSddsqKPraZzWmbbMEfY+fEfRwFyjsAVmAmVDBCfT/RyO8pi18NgWW7jAHVVXRHWwbKUB1N2jJYRFoQJ+a5VRUliFVs2Q9OmLjDB1OKStqTD6EhaZspH2DbA7DSWD7xx/TJgrCpAXWY5sOuCkwbk9iw2e1b2r3Vszc4e9l9cUpue0ah9eFrqF7sDxPW5B44CtJ6t6CbK9XOzfKa/YjMcXvIcx1mrDqkUzjROuxVycpus/zww3nRRBFMiregXcd18L9tMR/MP1vtS9L+bcoSyw6sDA/toD6M7AGjq5zdiLJxPrsvASZUUoe/bApQUfInWRncPpVwhPDoP6w66gThp9ebCoAD64+Q37XRj+AuZMrRUIOcKmQn7eqxODmjaV+d3fhnOnP/lYDqF1+ZouUgL4//T7B0BXTB5OFPM1KwZFitYmxwNMdxRxU0hgpYQlFhrfq5J3XsfoEMkI3yUw1vhFIYfUKd/+dVg7MEocqFj9zyvU2n9+4vemCvAnk+1GkqvzbBoHqOBubFQTYmKhxmm2vfcw3c1kY9uAi2o8w0sKtNJG1pgj0l/g4gZLvpn2gtLRbcXd4LvYDxMoF024DI2fXQ8Rij4gPVryBffeC6yv9QQmNqkuWxwTFpjBKPV+5k3g7Nk2GA4Bh0g85K5zNLNOoXHx50fad1EQZNoNwMSkz+W1j84+PiiLcz8iOoUiiUfERnO/4lfIFWqX9Q71SM09STf60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(52116002)(8936002)(8676002)(38100700002)(54906003)(66556008)(36756003)(2616005)(66946007)(66476007)(316002)(478600001)(31686004)(6486002)(186003)(86362001)(31696002)(4326008)(53546011)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNPamVoSUJ6TEpaK25JTGVKbVlkMFIwdTNNUTg2dHBrbWNxdTFTLzN4UGhK?=
 =?utf-8?B?ZjBEWFB4T29CYmhTalhrcG0ybjNlelU5U0ZoVWZZTmorWHg3TVJ5M21xU3A2?=
 =?utf-8?B?L3RVYVJaV1R2LzdrWWNsRElSeWtWODhpOFJRZjBEVWVZb2xjUmJNWU4yN0Y2?=
 =?utf-8?B?OU92aHB4YzA4M2huWGEvS3psUklrVjhYaGpxdHJLV3JOM3NScU4xZU5wWEdw?=
 =?utf-8?B?bElMNGVhMGh4Zm5POXh1bmZRSmp1dG11aEc0SHJ5MEJVZzVhZnRNRy9OWVJp?=
 =?utf-8?B?U3k1VzdvVEVTa0k2YnVBVHdNbU96dXlIVUdxalFORWNVcG5tN2NleFN5bkZF?=
 =?utf-8?B?b2ZoNXorczN6MW9GUVZGNitONXhUNlRtSGlTaGU0dlErb00vOUNWdFkzN3Vp?=
 =?utf-8?B?UVVFWkJTVmg2blRJZGVybVdOQUY3VHpUaDFkTkFJWkpKYjRXQ1VyaWlDbUI0?=
 =?utf-8?B?Rk11SUpUU2pHa0RpNlp2WVlkbCtvM0tJNjl1ZzRQUGlCbWZ1dnliNXgxMmFs?=
 =?utf-8?B?a2IySFFsTzk1OStXQWNXbmxIVVhRb2MrVlEwQmJZcnd5dTVyWDJBL3R5akdy?=
 =?utf-8?B?cXduTkI1K2dQdURSRm83ZThwWHJ4OXNyaVgwUkFWb3VmbkZCdm1rVFI4cEc1?=
 =?utf-8?B?MzNsTlM5ZmRJR2VpNFE4K09FYjMwb3lFTmYxZ3huR2NJR0NmM0xOOHNLUmFo?=
 =?utf-8?B?dlE2amhVUEViZ2VnZmVzNU9wd2RTUUdxU2hCUE8wR0pkcitTdW9LL255TEFu?=
 =?utf-8?B?dUxUME5WZnd3eHExdTVtdWNJcUlpVXc5MEJYdUJnY3RNSk5VeGVJNXF0ZCsy?=
 =?utf-8?B?T1JJYkxIb3hIZWNZL2VhMmlyN1VDNWo1bHhhMFFycUN0dUxsaURKK0hZeVRo?=
 =?utf-8?B?RzdpK0pvUTRKSFZIaEhnWHdYNXQ5M01VM21Mb0s3UVhSVEJNRVFtTnliRVA2?=
 =?utf-8?B?aTNOdTY4OUZwTTUzaG16ZGhmOCtHS2MvQnRvbXFQUGtldE1OUm5PZS9WNDlN?=
 =?utf-8?B?N1NPbXk0WTI4ditlK3Vsdm5zeGJaUzJYSWNIaTlOZURXWE1PSzVBaU05S1ZE?=
 =?utf-8?B?UWIvVkhnU24vM2Evbzd4NGF6akhaYWxobW1leks1dlRwWGNweU9PYmhqSVBH?=
 =?utf-8?B?NDloUTk4SmVtd0JHaGNiZUlyNFEvSkdJSWtadDVhTkdjcXU0K1lNUFQ0Y3FK?=
 =?utf-8?B?NXl5eXVvc1NrMzd4V0l5aEVxbWtlenBQZVJWTU9BdjdHMDU1SDFUQmw4SWlJ?=
 =?utf-8?B?NHpGRFhuWWtWL1FuQ0wxVlJ2V09jTEJ4N1dNR0N3cld6Tmc0TTgzWE9yWUY4?=
 =?utf-8?B?L0QvQmVOdjdoM2dPYWpIVTR5L1Q1aGlzT2ozU0tLTTdLdGFDMTRCdk5sNFN0?=
 =?utf-8?B?MjlDeGtGa3VHRkNmQmhVb3dJR2F1NWlzV05vVFlTa25iUmo0bTQ3UnVuWnNT?=
 =?utf-8?B?MFo1WHRoSFhnZlZvU0dlaUM0Y3psYjlxOUk1aFUrZnJ6R1RRMnd6b0s5M1Fp?=
 =?utf-8?B?eVlsUzJmK2VkL1M5UTF4Tlk0MnFQaFFiMzdCOThkeTBDMExnR1AvVFMwTjdn?=
 =?utf-8?B?VlRsNzEydEk1eSt0OUJtU28xT0hSZGhCRWRKOXluMm53SkQyUTVBbDhsNStu?=
 =?utf-8?B?ckM4dXlka3FnK29QTlZta2ZuOWhIeFdTQ2xpQ3grVXFJSVBSTG5TTHlYV09V?=
 =?utf-8?B?bE9scmNvOVVKK1lsbzM4c2cxOU1zK3F4RmJiVGJ4QW9DRDRLTWR1dVlocWJ5?=
 =?utf-8?B?SGl1MC9RSTJnc2xDMkh6b2NubkFlWGxnMGZuOWZsTld1a3dyVnluSDZTU3Vv?=
 =?utf-8?Q?SICh6ttBO/+XPt19aTYeCcngP7T6eoUvSCXLQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc420d1-ef16-4d58-b824-08d94573cd37
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 20:29:51.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGeV9wtnpVH09Swen19qjma4yFkAcX67P+6fTO5xWlS3op3qq/a9T6uWLCbLyNL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4096
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: d1Kl2mp4GrCB_pwzyQBYi85bq9s14wu7
X-Proofpoint-ORIG-GUID: d1Kl2mp4GrCB_pwzyQBYi85bq9s14wu7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_11:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/12/21 12:26 PM, Daniel Borkmann wrote:
> On 7/12/21 9:20 PM, Yonghong Song wrote:
>> libbpf is used as a submodule in bcc.
>> When importing latest libbpf repo in bcc, I observed the
>> following compilation errors when compiling on ubuntu 16.04.
>>    .../netlink.c:416:23: error: ‘TC_H_CLSACT’ undeclared (first use in 
>> this function)
>>       *parent = TC_H_MAKE(TC_H_CLSACT,
>>                           ^
>>    .../netlink.c:418:9: error: ‘TC_H_MIN_INGRESS’ undeclared (first 
>> use in this function)
>>             TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>>             ^
>>    .../netlink.c:418:28: error: ‘TC_H_MIN_EGRESS’ undeclared (first 
>> use in this function)
>>             TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
>>                                ^
>>    .../netlink.c: In function ‘__get_tc_info’:
>>    .../netlink.c:522:11: error: ‘TCA_BPF_ID’ undeclared (first use in 
>> this function)
>>      if (!tbb[TCA_BPF_ID])
>>               ^
>>
>> In ubuntu 16.04, TCA_BPF_* enumerator looks like below
>>    enum {
>>     TCA_BPF_UNSPEC,
>>     TCA_BPF_ACT,
>>     ...
>>     TCA_BPF_NAME,
>>     TCA_BPF_FLAGS,
>>     __TCA_BPF_MAX,
>>    };
>>    #define TCA_BPF_MAX    (__TCA_BPF_MAX - 1)
>> while in latest bpf-next, the enumerator looks like
>>    enum {
>>     TCA_BPF_UNSPEC,
>>     ...
>>     TCA_BPF_FLAGS,
>>     TCA_BPF_FLAGS_GEN,
>>     TCA_BPF_TAG,
>>     TCA_BPF_ID,
>>     __TCA_BPF_MAX,
>>    };
>>
>> In this patch, TCA_BPF_ID is defined as a macro with proper value and 
>> this
>> works regardless of whether TCA_BPF_ID is defined in uapi header or not.
>> TCA_BPF_MAX is also adjusted in a similar way.
>>
>> Fixes: 715c5ce454a6 ("libbpf: Add low level TC-BPF management API")
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/netlink.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> Changelog:
>>    v2 -> v3:
>>      - define/redefine TCA_BPF_MAX based on latest uapi header.
>>        this enables to remove the v2 check "TCA_BPF_MAX < TCA_BPF_ID"
>>        in __get_tc_info() which may cause -EOPNOTSUPP error
>>        if the library is compiled in old system and used in
>>        newer system.
>>    v1 -> v2:
>>      - gcc 8.3 doesn't like macro condition
>>          (__TCA_BPF_MAX - 1) <= 10
>>        where __TCA_BPF_MAX is an enumerator value.
>>        So define TCA_BPF_ID macro without macro condition.
>>
>> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
>> index 39f25e09b51e..37cb6b50f4b3 100644
>> --- a/tools/lib/bpf/netlink.c
>> +++ b/tools/lib/bpf/netlink.c
>> @@ -22,6 +22,29 @@
>>   #define SOL_NETLINK 270
>>   #endif
>> +#ifndef TC_H_CLSACT
>> +#define TC_H_CLSACT TC_H_INGRESS
>> +#endif
>> +
>> +#ifndef TC_H_MIN_INGRESS
>> +#define TC_H_MIN_INGRESS 0xFFF2U
>> +#endif
>> +
>> +#ifndef TC_H_MIN_EGRESS
>> +#define TC_H_MIN_EGRESS 0xFFF3U
>> +#endif
>> +
>> +/* TCA_BPF_ID is an enumerator value in uapi/linux/pkt_cls.h.
>> + * Declare it as a macro here so old system can still work
>> + * without TCA_BPF_ID defined in pkt_cls.h.
>> + */
>> +#define TCA_BPF_ID 11
>> +
>> +#ifdef TCA_BPF_MAX
>> +#undef TCA_BPF_MAX
>> +#endif
>> +#define TCA_BPF_MAX 11
>> +
>>   typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct 
>> nlattr **tb);
>>   typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, 
>> libbpf_dump_nlmsg_t,
>>
> 
> See 49a249c38726 ("tools/bpftool: copy a few net uapi headers to tools 
> directory").
> If this is not included from tools/lib/bpf/ then it would need fixing 
> from Makefile
> side.

Thanks, Daniel. Yes, the pkt_cls.h and pkt_sched.h are in kernel 
tools/include/uapi/linux directory. But these two files are not
in libbpf repo and hence system header files are used.

I will submit a patch to libbpf to fix the issue.

> 
> Thanks,
> Daniel
