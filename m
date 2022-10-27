Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB886105E2
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiJ0Wo2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ0Wo1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:44:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68118B448A
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:44:25 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29RMi5ll013664;
        Thu, 27 Oct 2022 15:44:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=GM1OiKsA8bKrPjmL1KoNEonY8z9giT72lzFgH1FfcZI=;
 b=ZZ+NK32KDtZAdZ7RnkmKqnsLx2rDYquLOk5cnaeCh5brMk2lSfQ1YzINlsp+kOduoarS
 0lNkE6iDmlie3RTrURod/enL+DgNBjUQgASIHt/yxalsQM1J9DSvgVwR+di8J8/dhxMV
 w6/3aLPh3xgujecguGrIlmyRwvlR7RXb3xnEfdi1KlrWTrN+q4YboTLf+DWdnWYhe0RA
 3Gacq304sQFvKBHCA3BklPN9jbvDWhvS53yLOobU/RlP99F6ymg9vIfGb7VDl+YI7tM0
 YmKPUFAxOL0zcph52mqE6UKKuREWwS4ttexF85rACzMF7NASqEVy5/OwfdWk/S/Ovwu2 0g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kfvx1m21r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 15:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeSgiud60c8RUZPnf9Eb+PLH/DFwL+p3uPLxYhAkUm8dmjc+W5lEoHkptl/S7CQOVikL5p87/e05CeInmitQlESV5LgGUM30lQjJ3ptHvwWW0Ew+6tAo/HqN7EAz2yQIxAHM8fAelpUHtHqHxTjM7fWWZjKLVvdlPORzJ0YeeTN7oPVODJtEwWRQg8qrHV5UA0+Iu+sHkgKfDU4KdeJHj3eUgQC52iLxnlQDJFROSGFbIYocxufzqF6Bt6QL9gPP4dAu4PhSOXBm4b3HUgy9XySRc286Ox8cnsDMzn7Uql7ZScfoAlwKlxR7Ij84ISnc5/qiCjXmYQKQUZfW7f68JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM1OiKsA8bKrPjmL1KoNEonY8z9giT72lzFgH1FfcZI=;
 b=kBHTr1O0unbjORsniiFlHPGC1aaknnV4V9E6EpKnwJj8Nic3bUBBQE3vY9x5aNyfIwEThyLL5I48gIjcDJhoULnA1D5gr3jzyukNhhPsE51al3vIJaqX8vnbNJUWwRDHnnqZ4wGQ4igZyqHF/ISdFULfUWwR34UkLgZqJbAM6QqXxWUtb5CBrVHy9md+4GYcFYhMFQ8BqdcOaZ04qRrxDrj1y2dBb0r9uhHhnp2/W+naLBIPGwAjebIUxdv/EJl3k5JvRE86lrq5BJsLtVa6mPwW2g7CkN1rbYGF8lrNSNO4U8NZ/ij3FRV3M2j0R9hadBoBHkEjgvWQIZ8cnEn+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3824.namprd15.prod.outlook.com (2603:10b6:806:91::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 22:44:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 22:44:06 +0000
Message-ID: <7a3ebc5f-b07f-0336-abb1-627f7a73b2cb@meta.com>
Date:   Thu, 27 Oct 2022 15:44:04 -0700
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
 <6e57811b-229a-e4f8-ca7e-fe826cde4be4@meta.com>
In-Reply-To: <6e57811b-229a-e4f8-ca7e-fe826cde4be4@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3824:EE_
X-MS-Office365-Filtering-Correlation-Id: ea333bb9-d6a9-4a69-66e6-08dab86cc12d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lczrma6HIIuLwDY8yYAHQa9JwebK/cHRry1XC0W6igVRrX7ofEhILIcdXlbxIUAOTElPQI9tAEyY1ap2RXBxetEgOAOzySfOXJJSe3rNyFTl70i9jvrhOIYS1go3Lnozw+xUakqeZYhHVvovwSyE7adJGYYc6/2xZwd5v2WxY8SzAp1jnVj+HPdCMCe9LX5VHzL/cH7j/Wf3QbWLlLH1prGx/WgIEbF44IxpU8cKOEiSQ9o5/OwDdeXke9LIxmJjBh1g1Z1ODM35DZeXkV8huS5rmGlrURPNulTz+n3EfYyPRzgMJ1fvLoj0sRZtr1/tcbtudfBETNlFE+kmJNC8WhMPNj57ZlIkHggUpj/eKFvQgg9g4U5yg4A5N/cAJyBmctomdkFbbN8O+kiU6eE5rmszRlgZWlnbMmzyrz7I2CA8E3owpl4Z//ximN2bv6w66C4PKv1dctfzya95/edLWBsbZOc5xcPZgSjDdrPtC/5rww8TU9I+0iAsj/hJff/GY36LOezgu313mfjGVBUqv+ictRYX6/DwmK0zexpxy65neriXcfnY4P6fpsNdgHS/XYwpaBtedPIT42P+rS3JzYc3oVaa/yze5y+SPnVs+DtzZZv7X735kO0bnUaJL4HEDOFcIiWRR7xtY/LzhorgxHU8RbjVXEiF2C7cVdCMlnZcjHCoNqHXXOqJVwHfqLLpJwCziFTD8ZaD/0H0KGM6D3LA9lLxJcmgTbqCRT/Ws5YToUYSL+rtHbPKyo12QCojN/BP7DhdyIalddFZWKpuXi5ZkjI6QrP/7ENjZqVnXw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(6512007)(31686004)(66946007)(36756003)(31696002)(83380400001)(2906002)(38100700002)(2616005)(4326008)(186003)(66556008)(66476007)(6486002)(53546011)(86362001)(316002)(6506007)(478600001)(8936002)(5660300002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVN4T05LbEJ2L2tsSWQrenU3K0pyK0h5V1BCTE44RFZ4ZS9abE1WbktNcmFG?=
 =?utf-8?B?Y2pjUXgrSVdYdjhJdmNoVkZYUmFmYlVrTXpwQkZCLzZLbGhWbmJva1M1Vy9O?=
 =?utf-8?B?N21RVmlzc21nTWJ3WUhVKzFPWGZUY2NCODYyMTlQMzA1YWVDMUFpNmJJdDFJ?=
 =?utf-8?B?L01iRVJkNmVPWC91WXpQSkxZT1VHeWFnZzRtZ0NOd0RaNkkrQWxLOXljRDZ1?=
 =?utf-8?B?SHpraHpEcW04K0g4VGh6UUZKZXZ5TjU4aUFEY1pZT3FKTFlEM2IxQVlIL3FF?=
 =?utf-8?B?MlB2eG9ISzNCRGh0Vld1azNPL2ZaODdBbC9LbFdBb2E4VEovRVFHblAyRERp?=
 =?utf-8?B?czl3ajRwNjE5b2QwTDQycHpzV3Z2bHgwTTZVRmJVYUxIdkhaejZkTFhWVVF6?=
 =?utf-8?B?KzVXaEM5RjFzS0FVdlhRQjgxSkJTc28wRXJscXhzMmtZUGhKOFZXU2ROelRX?=
 =?utf-8?B?K25laDdRaWRtM2hCWnA0QmVLU05xNHdJSklVNmorMzdVQ1cvRGx5cVFJTDJV?=
 =?utf-8?B?UWFTTjhWbENkR2ZUWE53QTcrc0taQno2OEptVm56WDVOdDRpS0JKbngvWkZ3?=
 =?utf-8?B?YTZnSklFZlpJMHQrMTVvdEIwcHNmVnJRVWM1WWhmVEp3ZHhCNithSnVoNW83?=
 =?utf-8?B?dWdnN0FET0dQQ21xczZhLyt4K1VOVGM4VXZZWHdUSit1TTQ2NmVveFlCL09Q?=
 =?utf-8?B?QmFkTGE2K09NZSs2bzhKN0JYUGRVVkExaFpILy9EOXE4Ly9DaXVhcm96d2ov?=
 =?utf-8?B?QWpsK2RFK1RuOG1FbmdVUWNrSTc2OWVDRFhJSU5WOFp4WU1QMXEyMTl3enhI?=
 =?utf-8?B?T25ZY1kyYnYyOC9Sa0Y2STZoV051RGFsUy9FNytTWW1TTzZ5UUxnN0xNVUZZ?=
 =?utf-8?B?SXJzMWhlekg1b24zUHlRZGFsR1JyTEZqV0paSWdFalZ6aTlFM2tkTDVCbzdN?=
 =?utf-8?B?WkU5MTZpcGdXYTA4NlVCdVMvOVNTWnBVZ3RMRStmWDNwOGcydTI3bnhXbDlz?=
 =?utf-8?B?b2s5UXJnK0MxVExkeU5icEtGMFl0OXdFS0lsM05xcEUvWEY1UWUzNTdnaXI1?=
 =?utf-8?B?K0pUZTZPSW81THhIWGF1aDllbVNOSk1kUlhBYWxPZmhyZEJqcEZ1cVBRNTRa?=
 =?utf-8?B?MmNUa2pqbFJsV2NNNldSdWsrbUhuaGJMSm90VmdIeFNQdG9kSUlYdU5IQXJv?=
 =?utf-8?B?RzFML0NCUkYrd055dENGMWs4dnBpQ0Q0VlVTRDF0cHptbjl3RUJsVDlHUi9H?=
 =?utf-8?B?RWp1ZG51NTlDbzlGSDRDc3Q4b0VWcDgxd0Ftd2NpOWVEQlF6SHFxa21YNXZB?=
 =?utf-8?B?Y3crQkVEQllhdVJZRnBZSnkrVGluSktnVFJ4U3lVZHdkY1FBK3YwSUVaalNZ?=
 =?utf-8?B?YnROVlA4OWFTSmRqeXdpLzBzWU1pM0ZMV0M1UVhtTE5vRnpRWkxoVU1Jbytw?=
 =?utf-8?B?ZzNlVFVxODhqc2xkeTBIRDlPeWZyUnFhOEFxdjhIczRJWXVveUl5M0FJRVNh?=
 =?utf-8?B?dk1LSGJURmR4TXl6R0FTUmt3YmsyZTJaMWhsU3lEa3FuUXVXZkZ4S01RSXc2?=
 =?utf-8?B?OWJlTG4yaXpaQTEyRlNEZkJLTDlBeXljNmdLN2l3Y0ZxZjFQQ2tqREpnRE1k?=
 =?utf-8?B?aDhBdjE3RE5WZXNOd1VaMFFWQ3VJR1Mwc2JYamZjRE1ZbGF0bi9lMFphY0p5?=
 =?utf-8?B?M2VSM3J0U0QrMWgxbWVlZ0s5MTU4aGhQNzNaRjg2bW5lNmFqbkYxNElHZ1Ba?=
 =?utf-8?B?NlI1ZHd0dU1FbVRjajU4WjVWVGhJZXY3OTdPK2FKNnNpUWNPdFpYQ2kwNHNX?=
 =?utf-8?B?K1VITFdyV2R5My96aHhXbWgvcDU3MXIyc28vL2hwTjRXaitsdndVZnlZKzFT?=
 =?utf-8?B?TDM4NmQrYmZscm5nOWFFV1FLNkJ5dDFnaFdwRWp6dlF0bHNEWGN5Q0tpQTZK?=
 =?utf-8?B?dTBQY0NLUHIrZExESzNMYXVIUkdLOU8zekZ1NDlKNncxRGNDc1kvY3FrTXg1?=
 =?utf-8?B?bDdLMHlnTDhKVlB1RFZBZXY3WkZTMFdnWnBmNFZjQzI0VUpVWGZjdkUyVFZz?=
 =?utf-8?B?Mmg4ckFyUmhtN20vVHZBeVM5ZG5hUmVwR3dRazBqU2RnR29wZmQ1TDZ5SU84?=
 =?utf-8?B?UzhXMjliTkxSQTR5TEgrZi90T2o1eFRLVXBrWG0vSFJrVno1UGd3dVlwL0Z0?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea333bb9-d6a9-4a69-66e6-08dab86cc12d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 22:44:06.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKkJyugiauxXzMfoJTgKwtwJ3fbEnJEHY0U4obbU2JfEppyIFsfk/B3w97QdljgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3824
X-Proofpoint-GUID: 5WhCKFijTVXjgMIkTTZp89QK9fvpc370
X-Proofpoint-ORIG-GUID: 5WhCKFijTVXjgMIkTTZp89QK9fvpc370
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



On 10/27/22 11:55 AM, Yonghong Song wrote:
> 
> 
> On 10/27/22 11:43 AM, Yonghong Song wrote:
>>
>>
>> On 10/25/22 3:27 PM, Eduard Zingerman wrote:
>>> Use pahole --header_guards_db flag to enable encoding of header guard
>>> information in kernel BTF. The actual correspondence between header
>>> file and guard string is computed by the scripts/infer_header_guards.pl.
>>>
>>> The encoded header guard information could be used to restore the
>>> original guards in the vmlinux.h, e.g.:
>>>
>>>      include/uapi/linux/tcp.h:
>>>
>>>        #ifndef _UAPI_LINUX_TCP_H
>>>        #define _UAPI_LINUX_TCP_H
>>>        ...
>>>        union tcp_word_hdr {
>>>          struct tcphdr hdr;
>>>          __be32        words[5];
>>>        };
>>>        ...
>>>        #endif /* _UAPI_LINUX_TCP_H */
>>>
>>>      vmlinux.h:
>>>
>>>        ...
>>>        #ifndef _UAPI_LINUX_TCP_H
>>>
>>>        union tcp_word_hdr {
>>>          struct tcphdr hdr;
>>>          __be32 words[5];
>>>        };
>>>
>>>        #endif /* _UAPI_LINUX_TCP_H */
>>>        ...
>>>
>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>> ---
>>>   scripts/link-vmlinux.sh | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>>> index 918470d768e9..f57f621eda1f 100755
>>> --- a/scripts/link-vmlinux.sh
>>> +++ b/scripts/link-vmlinux.sh
>>> @@ -110,6 +110,7 @@ vmlinux_link()
>>>   gen_btf()
>>>   {
>>>       local pahole_ver
>>> +    local extra_flags
>>>       if ! [ -x "$(command -v ${PAHOLE})" ]; then
>>>           echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
>>> @@ -122,10 +123,20 @@ gen_btf()
>>>           return 1
>>>       fi
>>> +    if [ "${pahole_ver}" -ge "124" ]; then
>>> +        scripts/infer_header_guards.pl \
>>
>> We should have full path like
>>      ${srctree}/scripts/infer_header_guards.pl
>> so it can work if build directory is different from source directory.
> 
> handling arguments for infer_header_guards.pl should also take
> care of full file path.
> 
> + /home/yhs/work/bpf-next/scripts/infer_header_guards.pl include/uapi 
> include/generated/uapi arch/x86/include/uapi 
> arch/x86/include/generated/uapi
> + return 1

Also, please pay attention to bpf selftest result. I see quite a
few selftest failures with this patch set.

>>
>>> +            include/uapi \
>>> +            include/generated/uapi \
>>> +            arch/${SRCARCH}/include/uapi \
>>> +            arch/${SRCARCH}/include/generated/uapi \
>>> +            > .btf.uapi_header_guards || return 1;
>>> +        extra_flags="--header_guards_db .btf.uapi_header_guards"
>>> +    fi
>>> +
>>>       vmlinux_link ${1}
>>>       info "BTF" ${2}
>>> -    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>>> +    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} 
>>> ${extra_flags} ${1}
>>>       # Create ${2} which contains just .BTF section but no symbols. Add
>>>       # SHF_ALLOC because .BTF will be part of the vmlinux image. 
>>> --strip-all
