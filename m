Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD776100C7
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiJ0Sza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 14:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiJ0Sz2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 14:55:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029364317D
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 11:55:25 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIKEhO031845;
        Thu, 27 Oct 2022 11:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Ow1Me87FGYJgXnJ9t8jvaW9GwffCDNA2IjWe2q0N9Xo=;
 b=YjxUgF2vkLZUzgRrIHmAfrtRgtl+BT+zadUkRrX3dlifan2j5UHnhEY4ka9xXWjRdquD
 x+R3cbQtFylhRnQ65uTefQA2hI/6kiHVUyvw2wcRvANsqxJCpBxY1q5Zu1ftVuE/s/Xf
 xeNafRwgOqvOuyEygC7xksHcujdldgIaWi/oqpgPrOTlRSqmSikg7XxvyyDyDc3Xxn5q
 4dbtQqwOztAGxIkl1v/tAlSrWtFu2D+ADXxp28xAZvUsKPdhRUcEPuqyiNiM5Ds8O6X0
 QSpQArexpngHaqz84fnFOy9aw1Qqn6QaQhQuOccMa1C9m2jdeqiJ+E+YvzW1OkP1gww9 Dw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kfahwvad6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 11:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3NK3awhi++geGsqIe1pec6DQhlvxE8RmkwNBcybnceZ2Fl3O3ksxhgHjRh79CrCX8jPedlCmEEguP6wQVCZUV4o2xGBU2YtYYRxFkZK5GJZCTknhshBMu9d2hlbbj8m4rm607vSliC/n9mxFPeq0kd2oAJD2xkjNbOi+0TY2t7ra+6xO5jhloEvq8+qaAM3cQpuNt5LL8Xj5WSZCOkL9WOt6+4neTXeawf0XlFnXd70G3Loy5e0ObWaOMbPn+buwhfH7+FI+XsNlZeRkhqk4w1PxD323Xc/AotxWBW5hfS1sE4wh/kQNy6jyjqWD9pXKhrAtkukGQq2b+tx1sex0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow1Me87FGYJgXnJ9t8jvaW9GwffCDNA2IjWe2q0N9Xo=;
 b=g70NhmQv/2+h9OhvW8e1SbKPlhwJxjqkeWOvIgoN9mzBa0wg7E97r5UcgzgdG+J6hcTgY+MY7YqSMj4k83H3CHoED3KaftN9Z9NrS+i5odNPj/StSnybYc3Jj68tY90il2G8NOaz9tGqJD/f9n3PHoOBlXj/UXw7q5Q1g3xUSQJdrdcAAjZQpVoYN7XS7rclSG5ooAEtCiZmWRlh5bCrUtneqIdFfIrM4OmQqmoZA37JBGQVhMgQof6SeFluJH5305UHDvMCCegiLdYmVn5avVyluEH68EddZEhQpPLojZ25NdrrZzzV4w73DEsx2yhIixFeqDzFrClGx2XPVSYYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5181.namprd15.prod.outlook.com (2603:10b6:303:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 18:55:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 18:55:05 +0000
Message-ID: <6e57811b-229a-e4f8-ca7e-fe826cde4be4@meta.com>
Date:   Thu, 27 Oct 2022 11:55:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC bpf-next 09/12] kbuild: Header guards for types from
 include/uapi/*.h in kernel BTF
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <20221025222802.2295103-10-eddyz87@gmail.com>
 <dacaeb37-c55a-a328-61f2-77324efbc822@meta.com>
In-Reply-To: <dacaeb37-c55a-a328-61f2-77324efbc822@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 956f0202-50b0-467a-b041-08dab84cc2f7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zo6ZeiCWF8HjzP/wSl10HMhfICSJYO8l+znO1/e2T/WDo4lt8ywAlNvZeyGd6689wTFYzzJFkS4DdcOYVst/OZRThJ6JLH2xVv3hUcRL1KxiQs+Q5Z0cGNqc8l/qrrOHUaVrFiU01IgxR2s+RcippAIVHYYO3Y/JMQdz0DqpZBFV8/sd/AThr4aXIpZ+1qVWTvQLeH/u6OchX43tLZ1My4wVH0zu+8moYjrAyadI0CSEiWPKeRrFJgpo/EaHcHsJUPMVX70RHpQDvIfSUqJ1AP1YlQs+wlsXeS72KYjSD7Jkl0Mj/ySdJECVIeCzflLWPLx3ylV7qYQNIsNxJMQ5AZP05K5mZV6nlsHm3/C88gM6hVh337vAqyDpgjQk2IRV3CKyoT+iVkqTH15yM5lNUgByMUZgR4sx108EJbfVNrGC6imSVQq5Z1+mutbagHNhUVOhXaY0nYcbbvPiLjKX5HvLrBLuBxDeaz6CTJE0Q3BGiRagtkn5kGCDwQrBYYN0bHKx1spaFNm4Je1TFHDyof6V/3mZwGD3s8OZQ9Ytx1Q4fOAeEkT8lg71uT1xeKnTbNAB0sQ0tYmEy8xODG18ajbgLeJzdBwzTXnjl/QLms5ZzEH4/u4ujSVhM2MXruIj2EF7YWYP/HHTcsfz5fznvAt7IjI/1RFnSIYFFaJnRu9rkHWkxST/DCxN4TEMI6Gfs8+mJIP1pJsgPk+egg6QrJXCLL2Pu64XDOI6CUOyQ6EZyul1JNBby8+HK70svLZpqQCXNF4qtZyDSsQxqzcx2vju4Z0hhHl8tuFqTUEMkcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(31686004)(41300700001)(4326008)(2616005)(316002)(66556008)(5660300002)(186003)(66946007)(2906002)(66476007)(8676002)(6506007)(86362001)(478600001)(53546011)(6486002)(8936002)(31696002)(36756003)(6512007)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWN4Lzc3bW5oZlFCbjdyUXN1Q3pjSFd2K3NIdzU5bU92TGVURDcwakdna251?=
 =?utf-8?B?RXdQdjV4SU5ZbHM4U1JsQWpIeDh2WnR6TjdoYWhxdmNXd3lEd3A5bE9lUno4?=
 =?utf-8?B?cGYwcHlVZ2FEM1hwQ3JodmtLck9XWEZackhQbVZPcno5K1JsaXpGYU5UMGVo?=
 =?utf-8?B?eVE4Q3o5NUZWM01pRmgxdjJybGhWb1VhcFJMT0FTOHdBR2kwQy8xU0sycXV0?=
 =?utf-8?B?TDI2NVQvT3pSWGdNc1lBc0JlVGhreHN0cUw2SGpqSnptT1dJRkxlRjRpdmZI?=
 =?utf-8?B?WnVxY21Vem9FMDVYZUtXblRyOGw1RG1MZ2ZWNStkVGNkblF0RTRxRUFMVnBz?=
 =?utf-8?B?WVJvNGVnZlp4bThtQTAyRGZ0N0ZZOGdVTzY4eDR1Uk5DNzJqNDhMZ0NLOGxJ?=
 =?utf-8?B?MzBPME1JK1ZRVng0M2FkN2pMdkVpdVUrNTVaUGtSZ1pvSWxDOUZUcWJMTy95?=
 =?utf-8?B?Q0NwejZ4Q2FyR0FoODNHa09tL3p1R0NjbXV1ZGxBdUh1WlFUamdVbzM4eUdS?=
 =?utf-8?B?SGpXSFJqZ0lQRzR2eG81UWJiRDM0TmJ1dkJyZ0ZTOEFGM1JCWERhcGR6c1Ir?=
 =?utf-8?B?aVhzS1gxbFVVMWhGOWp6ZVkzQWkxZmIrVDRJRXZZQndIUmROK2JWQWdIS3dB?=
 =?utf-8?B?d0dWZnpTcERaMk1YQTIyL3hRZWRKY0ZZMWpjTDNRQjE4WFVidndBeC8rUFVa?=
 =?utf-8?B?NENSbjN2eDdlSllLOFpCd3QwVXA2N3RFWmg5NVV0MGxMRkhGaTVFWGpnclE2?=
 =?utf-8?B?aC9FbTVybC9BZDBTK0tHc3ptajI5Q1NtWXFMbU93WHhTSGJ4SjV4TzdUQXRx?=
 =?utf-8?B?TGNyYytEVmFBUDhNOStMRGFxMTZiSmVpMEJUcEZwd2pFaGdZRXBvbE5vaXJM?=
 =?utf-8?B?TkluNVZ5YXk5b1ArWDJYSjBFSHM3L21OWkRabVF6em1JUklHYUR1N3dUNDBE?=
 =?utf-8?B?RUI5Wi94a3loUmh0dFF5eHhvdVl6aEUxREtQQ3lCZGFJWTlZbmFCdlV2T0Vi?=
 =?utf-8?B?dC9Wa21VeXNyOWxJZjlyU3F6OVVweVh6cHZkaTNoS0NkRWJaTjA1VnUzKzBt?=
 =?utf-8?B?MEt0K3JqREw2K2pHcytEZUpkYVNGcDIvY1RUNkNxL3ZXQWlmcjFiYjIrL2dF?=
 =?utf-8?B?SXBiazhKaTh4TjJLNk9PQ1ZIS0Y5NnZha3grQVhnQjJGRXpOcVhnYjZYcS9V?=
 =?utf-8?B?aWZEbk5vUDVIdElqcmdKUlRxM2Q3VWpYdkYxbnhzRU9wT1pDS3ZpYUFJU2Ro?=
 =?utf-8?B?QzZJZ2M3bFFLUDArTnQ3UDhrZHlpWjczM3B6Ynp1Z1d5TEt1eTFyTFpwL2Jx?=
 =?utf-8?B?YnJBNVh3NzdBeTNZa2FIY0dPaUFlVmVMQkF4VENrUzB5M1gwZTFzclFKZXha?=
 =?utf-8?B?TFRpc0RkZEFhYjFad0JraitCWHgvZk5SMHlXTFJuRk0vclRNR3h0QkJzdEE2?=
 =?utf-8?B?NGNGQmNLNTlRbGZ1b3hHUFNaNFpLamoxeURZZ05XbmY4dEEzS3JUOEJ4bHBW?=
 =?utf-8?B?bjlrSUtNRmZOdEd4MThnNzRsQzUzTkk3MDVwcS95WWVwZWNLRnVlSEk4QVRC?=
 =?utf-8?B?VFN5Nys4VGIwWmNwOERwL1ZaVnQwb291QmxXUGpEZk85YUszV0VEKzdCOVo0?=
 =?utf-8?B?ajZxc3dsSk9GdEVoZjlRZGhjTEw4a2ZnSFdRZktXRVFTZExIT29RSDhCSWhR?=
 =?utf-8?B?K3pYZDB1WW0rcUVDMy9nRXZMQll3MzdsUlE3QktTZkZmWnNNTWt5WEkrRUtZ?=
 =?utf-8?B?MzRYbFVTM3lnU2dPcWFsSEJNS0hRLzBweFMrVGFyOEJDUGRrNzc4a3ZCbDdn?=
 =?utf-8?B?c1J3OWU4L0pKdkRYM3R1STA0dGdGWHFNVXR4bE1Ndm9YNVFLOWJ0Smk0NWVU?=
 =?utf-8?B?VC9PeWgvdGhwakQzemhrSGxQcWFLeEVOWkJNYUN1UFQ5MGdTTTJRNy9IQi9r?=
 =?utf-8?B?NUh0amNRc0tnZ2ROTkRFL0JJRXI1RWhLMmlCVk5NN1NuTU14UUpnVlJPbUpY?=
 =?utf-8?B?MUQxODZMMUdFK251ZVowQTh4WW5CQkhadEtLM3JkTTN4Y2QrZElNdDhSdWV6?=
 =?utf-8?B?aEIxSjM2TmI5V0FFNFplNktLSmt4ODJsRjg2RmNWT1F4OEFmTEFDWFFWc1pi?=
 =?utf-8?B?KzdtSjNFaENrRWd5eUlaMlZwRGtYTCtxUHNSSitxS0RiSjlGQkwxZGRnZzN3?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956f0202-50b0-467a-b041-08dab84cc2f7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:55:05.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCl7Wd58I9a1Jmvg7JiPlnp4X+Pl4qLr8ai8TavKcaKb6SkxAcneFy8OR8qyLnBg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5181
X-Proofpoint-GUID: Oe4rt992QbJCk2YYKwAzmeYci_d1rVvv
X-Proofpoint-ORIG-GUID: Oe4rt992QbJCk2YYKwAzmeYci_d1rVvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/27/22 11:43 AM, Yonghong Song wrote:
> 
> 
> On 10/25/22 3:27 PM, Eduard Zingerman wrote:
>> Use pahole --header_guards_db flag to enable encoding of header guard
>> information in kernel BTF. The actual correspondence between header
>> file and guard string is computed by the scripts/infer_header_guards.pl.
>>
>> The encoded header guard information could be used to restore the
>> original guards in the vmlinux.h, e.g.:
>>
>>      include/uapi/linux/tcp.h:
>>
>>        #ifndef _UAPI_LINUX_TCP_H
>>        #define _UAPI_LINUX_TCP_H
>>        ...
>>        union tcp_word_hdr {
>>          struct tcphdr hdr;
>>          __be32        words[5];
>>        };
>>        ...
>>        #endif /* _UAPI_LINUX_TCP_H */
>>
>>      vmlinux.h:
>>
>>        ...
>>        #ifndef _UAPI_LINUX_TCP_H
>>
>>        union tcp_word_hdr {
>>          struct tcphdr hdr;
>>          __be32 words[5];
>>        };
>>
>>        #endif /* _UAPI_LINUX_TCP_H */
>>        ...
>>
>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   scripts/link-vmlinux.sh | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> index 918470d768e9..f57f621eda1f 100755
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -110,6 +110,7 @@ vmlinux_link()
>>   gen_btf()
>>   {
>>       local pahole_ver
>> +    local extra_flags
>>       if ! [ -x "$(command -v ${PAHOLE})" ]; then
>>           echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
>> @@ -122,10 +123,20 @@ gen_btf()
>>           return 1
>>       fi
>> +    if [ "${pahole_ver}" -ge "124" ]; then
>> +        scripts/infer_header_guards.pl \
> 
> We should have full path like
>      ${srctree}/scripts/infer_header_guards.pl
> so it can work if build directory is different from source directory.

handling arguments for infer_header_guards.pl should also take
care of full file path.

+ /home/yhs/work/bpf-next/scripts/infer_header_guards.pl include/uapi 
include/generated/uapi arch/x86/include/uapi arch/x86/include/generated/uapi
+ return 1

> 
>> +            include/uapi \
>> +            include/generated/uapi \
>> +            arch/${SRCARCH}/include/uapi \
>> +            arch/${SRCARCH}/include/generated/uapi \
>> +            > .btf.uapi_header_guards || return 1;
>> +        extra_flags="--header_guards_db .btf.uapi_header_guards"
>> +    fi
>> +
>>       vmlinux_link ${1}
>>       info "BTF" ${2}
>> -    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>> +    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} 
>> ${extra_flags} ${1}
>>       # Create ${2} which contains just .BTF section but no symbols. Add
>>       # SHF_ALLOC because .BTF will be part of the vmlinux image. 
>> --strip-all
