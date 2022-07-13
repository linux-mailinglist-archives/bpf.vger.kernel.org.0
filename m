Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35C5572C8A
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 06:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGME3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 00:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiGME2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 00:28:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51F29A
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 21:28:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D3qRPk020881;
        Tue, 12 Jul 2022 21:28:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cG9NuMT/MhN7KUjBw2ty9EQhXg6i1vdfUL9P+U0SiRY=;
 b=FPevDyDd7nXyWvRU2tKe5kOzxP+BlwYXQwFbyPn1vOFfoFepolpB+6udnNKxpAmic00u
 mF2/J8/W2uZ0AJCCGtBWfH1WVpAHzhdCbVMKi21hQoldLVmvv5adpzUWsBI1s0bjS8QL
 FzYSGNv70pqorHNR8E2ZsIDETFSzMx+cp74= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5jhk99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 21:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRUgkDDgmGBfnzvgutrrOM3QcciUUHVY4Jd9bj2LyK76RswkHoyI+wbdVIKSplYnZMVB5tBFZ8f/2fnVwPzz7wUURv451ijuPfy5LGEOLL3aj3rUH6vwyORMYWG7mciwJwNl1UtwpuMVuc2hsXT2Rv5Z3zdcE/KgEfPTuF54ppaa+n8EIfhlvvRBw9dQ4mDNCDvbLdHEe3V5k9sq3594Bt7f6L6X9wmJr28NLPkUYFSEwRO6hqzWjwyBhEv48ASSRca6GeaBIJOwYHcp0jFnxUYmvCZ5uT3TqPQgqpZhZOspZQ4ubyvVT/lWB7NsTvOszvtGpf1kdaSlB1Z9IVMBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG9NuMT/MhN7KUjBw2ty9EQhXg6i1vdfUL9P+U0SiRY=;
 b=hHipjrbT2K37aefU7LSaPUZ6SQpZjMTy8gswRwO0HV0RWdrUAgrnZaGVVyi9KxUxhuJKm8AxDK+Tor4yDUWukiIC95rIzSp5m0x+epNn0lvz9l2NkP4s73lghkcNvzwOXhvmmv/6QWbuF47V6YK8OlB3vksnfsA+VBpwyommywQ4Xbtu/EGwYP7xRXhjpi39O8YUTJbLPM55dY/8xlcPPPYH3s1IfPStSAKDRhbdLt547NkPMUiNFYYXKW00WWQdmN6XqJrPyYE1r+je5FLXrSQa/y1R1GUHEIj9VvEuo60n3Gcv2REoxITww65MC3yjZj8oESeNHKKASqxDh1837Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1559.namprd15.prod.outlook.com (2603:10b6:903:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 04:28:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:28:27 +0000
Message-ID: <2f5ca422-f12a-9db5-3ce2-cdb1d97dadc1@fb.com>
Date:   Tue, 12 Jul 2022 21:28:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
Content-Language: en-US
To:     Indu Bhagat <indu.bhagat@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
 <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
 <6138056c-fb57-69bd-90a0-8b51b870759f@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <6138056c-fb57-69bd-90a0-8b51b870759f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760a01bc-bc8f-4e7a-4de5-08da648821b4
X-MS-TrafficTypeDiagnostic: CY4PR15MB1559:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzvHOdLAAUgziX4FWBwxCjZea5tLebLsyMmSRQecVuqiVjswAl8qYZuiikrXwBDlDds1yFbqfS0kZI/ifARA+QXhE3tCKKFDnbLO9o3WVtfWiwuu0KWsq+4bbc8dBPdZsj0jP/p2wCIjpGph+DUB42WPFA4rrMxJ1jb6RBUczbbND/RIP7EUWqmo69gJ32T/KmQ+UFi7Bfn1aNiqv41UhRCWVTXK1gVMTf78zUndrfm7P/ElWALAZYwqZeekrIaXdRm5jFFkAHDJV6/JQEqPihSnyBtLs/sy4sazbdn8kVm+1ivQMQ5KFwoomySBEt65XY940IBL+3m77E3EFFkSir2iucQcOTavmSztEdu3pS+xQAk/feK0NSEpwvA4PwU+MfxZeu1/cjJgXrqX/bgZUbrWtUbzzhgpwLBDtGDvIEUBriSbbMayPngsxjwztUVRPH8P9xsEe0KNREpLANxVdt6yixBV7WkPvlKSgitoIvpiyQ7NXN3SyUeAMGFgJJge/abQf9enL2YqJnzm0Xdv22xG3qAJPhBKf6hxI/GxmF5yef/wFLOSDNUaUmyGFIO0O0c99tM3t1kZf0whWQ5yQ1Y2P4Z+YzNTwvTyuLbC/HBA92TMobhb4EdJRj/5baO8OkP4V/eqtOzGyDRjxNUWuAZgmoLK8MoEddQLDYnbKZHpNGlgWGVMVhGwk/SY0czwsGhl8bEkQ82dMepdiIQN4t3Y37ZOzz9UOov4v80D2upba6ot5W1sZMm2QbfF1bZM6kbP0w9J6Ogcf0Bnf5CbpXNztKvMob9+3fR1IEFYz5hoiRwpSiVGJJhF5cE3VW1fqqV+cDp3t2IbiD9IvOiuEn9jcnZHE1OvQx6drEol+V//JMvOUaZeoeVCTEOHvBK8JaH2EjzO5Z7TppVxgOVY0PqzPHJxgYGm8sP8w+hSTUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(4326008)(8676002)(478600001)(6486002)(966005)(41300700001)(36756003)(66946007)(110136005)(38100700002)(86362001)(53546011)(6512007)(6506007)(31696002)(31686004)(316002)(66556008)(2616005)(66476007)(186003)(5660300002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNOSEp1ZmRZRzhhYnlNTnhVMGFIWE1ZVTErTVZTRGNRVDd6Mzc2Y0c0U2FF?=
 =?utf-8?B?bWpRU2Z5cDExRkdIRTJhOVVkWFRGcm9WcnRackhUdTdQWEQwOVRyMmZWQ2po?=
 =?utf-8?B?NFNLam1hNDNXL0FLUTJvVWgyaGcvQWJjeHU1aGdPQWhFSW1veG51eEJ1ZlZt?=
 =?utf-8?B?UkdNQ3Z1d29RTUlxZFc0aDJxTGlsQTNsNGlKdngweTZLa3lUbVhlVENldlNU?=
 =?utf-8?B?SHBSWGIvVmpaNzJhdlBSWmlFbmRLMmRiREFDeWVlSW1jZ2Z6ZGgxTlNhSUNt?=
 =?utf-8?B?Rkk1aFNnaEU5TXo1YldiTGZuRGZGMjJiUFVxelhZQ1I2MG10ekRYV3pLaWlL?=
 =?utf-8?B?Z2ZJempuamk5QTlBYnFqalRQM0NVVUwwclBoT0JWT1BsaGFqUmVsamhGeXFU?=
 =?utf-8?B?TWFQZmpmZDMrc1Vxa1cwT05sSDRzanNXejcrRWNmSEthQ2FReFpNNnhYTHZx?=
 =?utf-8?B?WXNlQnZRK0RJM2dob2xhVm50Y1VGUjZpTTVuandVaXJ4b2NIZ0dnd3FWdzBx?=
 =?utf-8?B?bitIaHpkNnZxajJXV2JoaURmaHV5WFB4MVRrWm5Ddk5oNzI5OHRqM3h4UjNH?=
 =?utf-8?B?REtpVVl2cVJwWHBiMnNhR2lhSTF0eW1lWDhIa1lJblN2ZkZRczArNUJWS1Z4?=
 =?utf-8?B?ZzZqYWJiWTkwN0JVYk92UU90YWZoRXpiUnpaSGowdTdzN3R3c1Z3dGprY1NG?=
 =?utf-8?B?WlRFQ3BuR1Y2Zyt2OGYyQm1CbHhsdzV2S3FGOE91VS9pMitmV0U1cSsySGRJ?=
 =?utf-8?B?aHozT2RZQVZaSnJkODlLWjNNRTNlUWppQ0h0VHdaSWE3bHAwWkxvOEpGTEFD?=
 =?utf-8?B?Z0kwMGx6L0F0eWpJQUxWb1FJMFVldStwKzJ5eVRZS3kyU0NnMjNKNE9KNmxx?=
 =?utf-8?B?NFQvL1hlZ0p6Y1NTcTJleHVtQURnaHFpZXAxeDVIZEdQTlQ5VlpKTGcwZVNG?=
 =?utf-8?B?Um5Nd2pGSnJ6RFFCTjNhbEF3MEVzdit6ZTJyNHRnMVcvRVFFT2FhdkdUUkJS?=
 =?utf-8?B?dFM2QUo4SHFxYmZXVE9kWUpNb3dPdzRFa1VxWWdJcCt4SVF4VWUxR2F0NkhR?=
 =?utf-8?B?emtNYW9iNmN3OHhZbEVOMHFjeGtGK0tpcWNzaEhMaElqenpsVU13OHI2YVlj?=
 =?utf-8?B?YU85bk1ETWR1YlZ0UUxrSlZxUm5YSms4VU40NjBkMERQb2tISUdaTFpuZVVk?=
 =?utf-8?B?ekdncitBdGJQcUgxd29ZbDZvUXN6Mzh5emdHQzZack4xdHpqWjVJYjRBRDlm?=
 =?utf-8?B?MjNvemlLNWRUNmFSRktYY2pMbkY4blozbzEwL3FnUWdVTWxpZ0hmQ3Z5UVpQ?=
 =?utf-8?B?L1lrWUEwZzlwQzI5RzBRZDBtMU5nOWIzYVdNTTEyeWJhS3MzT3dTdVVKSDUv?=
 =?utf-8?B?ZDlzaXFhYU01UmJvOUtxaGhQRzljZTRVdVc0OThrbzRPTFFINTZyZkpnWGxZ?=
 =?utf-8?B?SWczVGJySEI4QXB5UVJicVUzV3RPNE1vZUdZQkt6ak1ITVdHUnp4YXBpVnJQ?=
 =?utf-8?B?ZUtvYUtjUURwNU84MFpHWkV6bDhXRnhCMXR2Wk5jNVNJcVNxNkgyZnlueS93?=
 =?utf-8?B?UTNCNk5xcUdvMlNBbWJIaGhUMk1yUWRqSG0xK1VoazVsY3FiR2FxNC8yWTJJ?=
 =?utf-8?B?N2hwSFB1enU1N29oLzhtK1JjbW9QTHd1UVNUWGlFc0ZsaVBFTUQyMUNKVEsz?=
 =?utf-8?B?QzhBdjJ1Yk5YaUhMYmlZN3J1Ly9rK1V4Y2dIUm9pK3A1Vy9aQW9SQXdjSG9M?=
 =?utf-8?B?c2xTSlpKdTN1RmN1Y3Qxc29LTExLVnFrenBJT1MzTHRPUzJwRmp2dm42Mmhz?=
 =?utf-8?B?QmYraVZIZ2FmSXJrT0hobm5rU1g5aUhuN1R1SjR3N3RERjhraFpZQmMvM1Jo?=
 =?utf-8?B?VmRETWVoWi9CUHpsNGRZRFNUcTJTN2pJKytHdlQ5cXNpaGJrTTQ1YlVwSVd4?=
 =?utf-8?B?MzhCeGpuRDhXR2E0MVlBM3hCY0s5c2ZXVEtnNHM5NVZIRlpYaGpBVzZkVE42?=
 =?utf-8?B?bmcrK21iUnB3YjROZ3E3RlJ5ckJnNDJMTlR0dm9GUEp4eE1mbmNVTXFWQlpu?=
 =?utf-8?B?cnRVSVFLNFV3QzBCbXp6R1BYdThOUXQ3S3M2RnhDVnQ2SjVxNTRGTDM2TjBY?=
 =?utf-8?B?eHZMcEpINGlPQjBMN0xkY283MUlYdXlweExEREFNY2VNcUhudHNrUUpFaEhn?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760a01bc-bc8f-4e7a-4de5-08da648821b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:28:27.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07ybBcuvLR+KjlGS5VxHfCrg49+HqquHGaecxd5sKK1jlYuocsLpH+L9VmIDBCGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1559
X-Proofpoint-ORIG-GUID: HlIji5Zu2c0Ga-bBqgqEwoFmhlcfAcBr
X-Proofpoint-GUID: HlIji5Zu2c0Ga-bBqgqEwoFmhlcfAcBr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/11/22 5:34 PM, Indu Bhagat wrote:
> On 7/6/22 10:20 AM, Andrii Nakryiko wrote:
>> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> <james.hilliard1@gmail.com> wrote:
>>>
>>> Note I'm testing with the following patches:
>>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/ 
>>>
>>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/ 
>>>
>>>
>>> It would appear there's some compatibility issues with bpftool gen and
>>> GCC, not sure what side though is wrong here:
>>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>>> libbpf: failed to find BTF info for global/extern symbol 
>>> 'sd_restrictif_i'
>>> Error: failed to link
>>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>>> Unknown error -2 (-2)
>>>
>>> Relevant difference seems to be this:
>>> GCC:
>>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>>> Clang:
>>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>>>
>>
>> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> expects it to be marked as such in BTF.
>>
>> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50 
>>
>>
> 
> How about updating the BTF format documentation in btf.rst to reflect 
> the specification for BTF_KIND_FUNC ?

The below patch sounds good. Could you send a patch for this? Thanks!

> 
> Thanks
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index f49aeef62d0c..b3a9d5ac882c 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
>     * ``name_off``: offset to a valid C identifier
>     * ``info.kind_flag``: 0
>     * ``info.kind``: BTF_KIND_FUNC
> -  * ``info.vlen``: 0
> +  * ``info.vlen``: linkage information (static=0, global=1)
>     * ``type``: a BTF_KIND_FUNC_PROTO type
> 
>   No additional type data follow ``btf_type``.
> 
>>
>>> GCC:
>>>
>>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>>> [3] TYPEDEF '__u8' type_id=2
>>> [4] CONST '(anon)' type_id=3
>>
>> [...]
>>
> 
