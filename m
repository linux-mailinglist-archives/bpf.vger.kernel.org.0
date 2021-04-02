Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95EA352E99
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbhDBRmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 13:42:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4122 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234717AbhDBRmi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Apr 2021 13:42:38 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 132HUBi1024289;
        Fri, 2 Apr 2021 10:42:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=y2qGuysV7dp91hlc1Gkxlavre/6V2H1wi2+iUopMAdU=;
 b=Ef4vNx1Ji2cGrZNJ3d1PAykxGx06jefkwjiaEcujutLozufm50aGLuNSymi5PGkp2i6R
 jxrt2c8EEZLDYuTAkio1nc+eRdcwC2ezPemcIGP8Xw7fOLA54o62zUi1RnfCqZ4WJRfk
 W8/VBvTMOoIP7PpCph4MZ3aQZ7P9wLZobwA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37p026ay3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Apr 2021 10:42:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 10:42:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isC3KTBvZ6bSYKcNI1j5bkj5TSc5k4kXrQ+bZMlgXKCGSknyzQV93DhF2m44YNvuwfTq6/LQH0aHeZtYmf/wQTeP4mGtSOMRvJE4viOuxvQVlC0MBw/rFptgcnsIlzC25Tgc84+iLyw4qWtxv2DLEeM2oajkB4Ww16K8sIXGOWY4z8FUFwUmmVYKwoIOvDAo3b5CuZQ456IYNlaXWEQoJ5D5SzDhHRZfWUpM61JePXiQqUBlVMQmnMeP2NBP0fi5gbi2xtPCiztQjqdURCGNbapo422re6od6TOiCMBBoczMQBn9MSrTT6f94ZxcFXWVBiwRAYdhyB3OzDHOaywtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2qGuysV7dp91hlc1Gkxlavre/6V2H1wi2+iUopMAdU=;
 b=nOddr2dqoHEzSSougJK+Zp/P11aIiBVV4AbBhKN+qVHetGwoB3aW4+AWHuHLQd+SM2dFJP3Kmlcb4z++N0IMsLALlwWNcOpcCkpMtTmARaSWHXMyUrcME477ZyLEYuTWM0zReEXwLgtEd3wF59TAjqSZ/3Vt4QRd2k3ITLdfNneAKQwM1K1lxAwBQdHrzUnhFViERpH4Po8GxryDs+xSgzJhCigI3F7e4ZQs+ajmUy00Ti8U09yQKsa7HC7/TR1EHaB8eMUsMTzBUTHarm9deEkzI3qI1WXGqTiPW2VLxLwX7fOD81+JhA7VSw9Jea6voFHZhcHH78kUUUNEcbcF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4707.namprd15.prod.outlook.com (2603:10b6:806:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 17:42:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.027; Fri, 2 Apr 2021
 17:42:25 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     David Blaikie <dblaikie@gmail.com>, <dwarves@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20210401213620.3056084-1-yhs@fb.com>
 <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org> <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
Message-ID: <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
Date:   Fri, 2 Apr 2021 10:42:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:810b]
X-ClientProxiedBy: MW4PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:303:8e::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:810b) by MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:42:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 174cd8cd-c42c-4626-c346-08d8f5fead23
X-MS-TrafficTypeDiagnostic: SA1PR15MB4707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4707998BF6EE68E3756EDB8AD37A9@SA1PR15MB4707.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQXvdrnBr3+rl3wUWqNyEmmcfbhfuirGVrPweQ/JkUgOcCxvkdPUI6ieUezuaFekFM4Q5aYpYA8pfG9GWwiF4sWXsqkVhYKhkYhEaEs4VYNROR+6MO8JtqnW+ohSMlTpzm5bbf4kHIfAa8/La3oN1A47qvqOQBBGIp0MnPa8fYNkFQH2HIN8LFxSqSgxQ4RV3f7NRUGXM9cx3VFtISz/XoedfWjT7+ljZK3bW5NdHeVHqjKLQnp4lIecVBMSKY8UBwgx5I8umZX8p2Sp5LPa/Vx4RGD5Xpb0EqeTBYZQuWAefyMqb8u6yvc8RvgKxGuri1soPKKRMItog8ZAPpv3nvGqD3uwej+no0FfaZ//Rvq3h013dxtb5vr+h4aJtGfxoLX5T6tpJD7HK5VJXtkML8YPQRwrwcX3WHOBqwwig66q5krrtIBibdWnZk595JtVugqgUT+bN0/2M1kD6lylA61UnamKRi1wFsDZlL9EwDAfhStPo8FZbPMMY6EABEAM+eu8GTgIAv8VttmCNx6Px2DQG4T8jNTuaVJQEnKCKBXSUiSKJd1ddTMImJF/b0abu1XnoGfbC8F6kvnrGAbh1klswPB49MmJcrsetIl5ELVrZPjCmd5FK+moxHcPZxVJCztzMSXZwTecFSN1feV2ZI6cTme1roVjjvkVqIa1t1jHmaL1wzLVrDw8AgujK/HOBaZdcEDBDABY6l8VD78jojbFbnIvBigwqRWkuaSEWapn7SVA0aPBk+dRbJk1IYcwuLo9wnh2MV00VE7pIiqWSi5yB9ZJm8epdDVsdfHShJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(83380400001)(2906002)(2616005)(86362001)(31696002)(31686004)(8936002)(8676002)(6916009)(66556008)(53546011)(478600001)(966005)(52116002)(66476007)(66946007)(36756003)(54906003)(316002)(38100700001)(16526019)(4326008)(6486002)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c056d1ZHayt5Y0ZmWHZFSGVFbU9UblZBZXBETk5nRFlaNUF6M3hodVFwbDJk?=
 =?utf-8?B?dnJNNkJrMnVjaHcwclF0N1J0eHZpUGlsM1lhK1RYdUpFWXh2YzlRUU5jOHQx?=
 =?utf-8?B?Z2JqZ2VsVGtnRHlvL3ZuWllXUHJ5UFkzT0ZMT01RQmg5UjZGZnhsdWFIOCtX?=
 =?utf-8?B?RDd6NmZtSk12b3laT3M3b0dDVmRSK3FSd1BieFZlUDVWQUhhSFFoWk4rODhH?=
 =?utf-8?B?SWRlN1AyM3o1bTRuZmtGMFFwQndSbk50VmhuTjBRdHlOd3B5NUN2VW96eFJF?=
 =?utf-8?B?dHUzd2ZNT1VsOEdpZjVKTTY4VzBvczVSLzJncTJJTkIzTTlUckNUWmVHMm4w?=
 =?utf-8?B?UmFKdllpQVRQeVphakRiRDJLZVpvNTdGcU85aUVIM0YrSTVjVm1LSnJHMUVI?=
 =?utf-8?B?QWdjbW5rdGZBSFh0cStUbVRrSzA1bE4vOCtaQ0J0SndYclZscG5Ma3hqWUFT?=
 =?utf-8?B?Qi8xWmViQ3NaU2tCbEQ1MXNHb3BQMUszV0JObmlvSmJQUUJndm1mMHR5dG5G?=
 =?utf-8?B?RVNHQjRDd0RXZGVUV3hmeDJ2Q01qdjJpcnB2QXJDQnVTSXk0S1JtbFR3N2hv?=
 =?utf-8?B?OVRCMy9ZSmROM080eEZXNzJaSTRYaHYyaExRVFZ3MllLRnB0MFlDanQ4clB4?=
 =?utf-8?B?VWt4dCsxSVZGYkpEWDhZLzczV1lFMFI1YTV2N0VkTFNDTHpHYm5wQWRkaDYx?=
 =?utf-8?B?czB0QlJMdVN0Rk1KNHdJMjVYeGJNaUNzV0FpUklRNzhNaWpFaUNNMzJsTFlz?=
 =?utf-8?B?NW1iZEN2UEpiRzY4ZUk0SHB5WFloNzFxZ0Y3cnc1alRNNC9wOFI5bEIrcHd6?=
 =?utf-8?B?dU9mZTBNT2c4S0VVbEFJa1h1QUJzbVJVTDg3d1pPUElLY2RPNVE2ZUR0SHJa?=
 =?utf-8?B?cTArMjJINnF3SHlxd1VUSXBtOGVYTmhEYllhVDlPUlV6L0tqRE9yNytOQlBa?=
 =?utf-8?B?Um9Qa2FFQTlKWXc3Y3BuY3U1SFVBZmRnSkFKQktTK3U3ekpwUHBzUUFVdERo?=
 =?utf-8?B?QStHb1lFaWVJQjJqRTVOMFJXOUF6ajJ0TTVpS2lMU3VGWjZEOHl6RUFyc0tQ?=
 =?utf-8?B?V0pVdENZbllGdEovYldoNUo0VFlaM1d5ZW5DSDZjWklsenY4UjJqN0NPQng3?=
 =?utf-8?B?Z1Q5STFVWG9hcFRibnpuSDFwNUhzdnJrK2cwbVdmWHFLNVlOcnZ4czFSSFQy?=
 =?utf-8?B?ckZxMFlUMmQxVDY2bm5yZXQvc1Fwek5RMGhpaS9QbWE5MXVjMXBKbklFWEpz?=
 =?utf-8?B?cHNiMHY4ZHFINWJ3a2swZC9DRnVWYTJsdGwwWHRwSzd3VktWVXl0MWZNaGpy?=
 =?utf-8?B?U1NjUTZVeVlQT28zNDB5SmVUZ3Q5VE9lU1VrN3hTNk9tekdHTmp0Vmx0ZjNp?=
 =?utf-8?B?a1lCamlGZEJISHZCRGpqc2dicXkvaTNLeWJNR3Fyc05Nc2Q0SCtBNnA5bFBL?=
 =?utf-8?B?dXpsQTVwNnp5U0FDU1NUb2hLZTFSblhKVjhyQi9INXhGN1ZBM1FpSVU3YWdh?=
 =?utf-8?B?WFBEK3hmTmVUak8xNEJPTjFyNDgrRnhNLy9vS1prbktXc3pNdHQvSlBvQXpr?=
 =?utf-8?B?eTgrMjA3bU96eWRER0FMTVhMcVRJUUczbnI2c0NRMlJyUEFlcnVnNVU2VDEw?=
 =?utf-8?B?d1BWd0RnRUFvQVQ5TDVDYmRsZ0MwaWNvVEd5TmNzWXNIcTNDRFR0ZFF0c0Rz?=
 =?utf-8?B?LzIrSnBKSUl4bGdhQ2RTc01mOHY5cmJsSHVOOFdxZlVIRFBtd3V6Sm1yVDd1?=
 =?utf-8?B?bEh1djlkMEVtUG9TaC9BUURJeEdYVGpEaEdmK0swOEVRYjRVZXIxaURweCtD?=
 =?utf-8?Q?0oqN/LzKzv8Mdwne4INN470uQFZ//V3V6IN3A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 174cd8cd-c42c-4626-c346-08d8f5fead23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:42:24.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvK0wWsr04o28fXV1/yqff/GGkmchKSpe9YKNeHUO6DQC0+vkPM/Plw4yTN/CV4y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4707
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: KYMh4PfXCzCRsTHaVt6n60IPoc3ZlbDs
X-Proofpoint-ORIG-GUID: KYMh4PfXCzCRsTHaVt6n60IPoc3ZlbDs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_12:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/21 10:23 AM, Yonghong Song wrote:
> 
> 
> On 4/2/21 7:57 AM, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Apr 02, 2021 at 11:04:18AM -0300, Arnaldo Carvalho de Melo 
>> escreveu:
>>> Em Thu, Apr 01, 2021 at 05:00:46PM -0700, David Blaikie escreveu:
>>>> On Thu, Apr 1, 2021 at 4:41 PM Yonghong Song <yhs@fb.com> wrote:
>>>>> On 4/1/21 3:27 PM, David Blaikie wrote:
>>>>>> Though people may come up with novel uses of DWARF features. What 
>>>>>> would
>>>>>> happen if this constraint were violated/what's your motivation for
>>>>>> asking (I don't quite understand the connection between test_progs
>>>>>> failure description, and this question)
>>
>>>>> I have some codes to check the tag associated with abstract_origin
>>>>> for a subprogram must be a subprogram. Through experiment, I didn't
>>>>> see a violation, so I wonder that I can get confirmation from you
>>>>> and then I may delete that code.
>>
>>>>> The test_progs failure exposed the bug, that is all.
>>
>>>>> pahole cannot handle all weird usages of dwarf, so I think pahole
>>>>> is fine only to support well-formed dwarf.
>>
>>>> Sounds good. Thanks for the context!
>>
>>> David, since you took the time to go thru the changes and to agree that
>>> Yonghong's fix is good, can I add a:
>>
>>> Acked-by: David Blaikie <dblaikie@gmail.com>
>>
>>> to this patch?
>>
>>> Maybe even a:
>>
>>> Reviewed-by: David Blaikie <dblaikie@gmail.com>
>>
>> What I have is at tmp.master, please take a look and check that
>> everything is ok, the only think I wished to fix but I think can be left
>> for later is in the tmp.master branch at:
>>
>>   git://git.kernel.org/pub/scm/devel/pahole/pahole.git tmp.master
> 
> Thanks. I checked out the branch and did some testing with latest clang 
> trunk (just pulled in).
> 
> With kernel LTO note support, I tested gcc non-lto, and llvm-lto mode, 
> it works fine.
> 
> Without kernel LTO note support, I tested
>    gcc non-lto  <=== ok
>    llvm non-lto  <=== not ok
>    llvm lto     <=== ok
> 
> Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start" issue.
> Some previous version of clang does not have this issue.
> I double checked the dwarfdump and it is indeed has the same reason
> for lto vmlinux. I checked abbrev section and there is no cross-cu
> references.
> 
> That means we need to adapt this patch
>    dwarf_loader: Handle subprogram ret type with abstract_origin properly
> for non merging case as well.
> The previous patch fixed lto subprogram abstract_origin issue,
> I will submit a followup patch for this.

Actually, the change is pretty simple,

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5dea837..82d7131 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die 
*die, struct cu *cu)
         int ret = die__process(die, cu);
         if (ret != 0)
                 return ret;
-       return cu__recode_dwarf_types(cu);
+       ret = cu__recode_dwarf_types(cu);
+       if (ret != 0)
+               return ret;
+
+       return cu__resolve_func_ret_types(cu);
  }

Arnaldo, do you just want to fold into previous patches, or
you want me to submit a new one?

> 
>>
>> I did some testing for this ret type fix:
>>
>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master 
>>
>>
>> And for the LTO ELF notes:
>>
>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=7a79d2d7a573a863aa36fd06f540fe9fa824db4e 
>>
>>
>> The only remaining thing, which I think can be left for 1.22 is:
>>
>> [acme@five pahole]$ btfdiff vmlinux.clang.thin.LTO
>> vmlinux.clang.thin.LTO           vmlinux.clang.thin.LTO+ELF_note
>> [acme@five pahole]$ btfdiff vmlinux.clang.thin.LTO+ELF_note
>> --- /tmp/btfdiff.dwarf.CtLJpQ    2021-04-02 11:55:09.658433186 -0300
>> +++ /tmp/btfdiff.btf.d3L3vy    2021-04-02 11:55:09.925439277 -0300
>> @@ -67255,7 +67255,7 @@ struct cpu_rmap {
>>       struct {
>>           u16                index;                /*    16     2 */
>>           u16                dist;                 /*    18     2 */
>> -    } near[0]; /*    16     0 */
>> +    } near[]; /*    16     0 */
>>
>>       /* size: 16, cachelines: 1, members: 5 */
>>       /* last cacheline: 16 bytes */
>> @@ -101181,7 +101181,7 @@ struct linux_efi_memreserve {
>>       struct {
>>           phys_addr_t        base;                 /*    16     8 */
>>           phys_addr_t        size;                 /*    24     8 */
>> -    } entry[0]; /*    16     0 */
>> +    } entry[]; /*    16     0 */
>>
>>       /* size: 16, cachelines: 1, members: 4 */
>>       /* last cacheline: 16 bytes */
>> @@ -113516,7 +113516,7 @@ struct netlink_policy_dump_state {
>>       struct {
>>           const struct nla_policy  * policy;       /*    16     8 */
>>           unsigned int       maxtype;              /*    24     4 */
>> -    } policies[0]; /*    16     0 */
>> +    } policies[]; /*    16     0 */
>>
>>       /* size: 16, cachelines: 1, members: 4 */
>>       /* sum members: 12, holes: 1, sum holes: 4 */
>> [acme@five pahole]$
>>
>> - Arnaldo
>>
