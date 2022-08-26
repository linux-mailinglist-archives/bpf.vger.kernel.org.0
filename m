Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DB5A2CE0
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiHZQwW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344874AbiHZQwF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:52:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6311147E;
        Fri, 26 Aug 2022 09:52:04 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGM2R8013533;
        Fri, 26 Aug 2022 09:51:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+tNUWZaLvV2IrCxGEoPKgH2G4IdjMikvey87LEMbl0c=;
 b=c7YL36JhIQ+5OWejh376GyVD3u3poOTqPtVcVp03evpblF2Jp0UMBb4nF6UAWoMdBcXp
 7XY+nop7NzOYcnqnQ9VKbLOwxzbhyY2Is2R5xZRC2PqtlfxgSAH9AWURgK2i6lQbMum6
 8nX8DR/PlCAasx/gp6fy0Axhr3Ff303cbyo= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6ne2c8vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 09:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGaaRzAMb9T0XAkxrl/99qYjO/T3oyKIxH6dPPppivt88y7oR0eQist6W5lmvCDHZT021eQwHy5AXju1IQao7MYCJWgDdZHiKQ7L6SLhMwpPTqiKpi3qVD2nxdQGHw+VsNW7LmL2kOMvdRZO0qBN2ASiIExgzjO/yO5kfizVIU8uz7JU8iGjCx5JK4UpU4bD6lF4koL9mU1tp2D8IGwVICJcybe9W68Okv7ldWlNznxZJsaei3LOs24KzriyAKirm0zRlkfkZZF4LbPAvXXpU3ZpV3JfSnujK/9x7pfSw0sQuvrgHnNHTayZhiwX6+1zc6z39BXu6RGCkqiNuY0y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tNUWZaLvV2IrCxGEoPKgH2G4IdjMikvey87LEMbl0c=;
 b=Yj+cJsMpKv5aWh3YTb4kgZ2E9H79ZiJPd2JvnFhDvDxkNCq8XtK0AbsRBxOzP3zTYoCBhpo7EH0Ron8pWic/7rpMURsLUxyq6jUYVxd2FYxLVjXKBHlzZvLDbHF6clOdczm9pgag+83WM+kdeRYs6QKVD7JOc5oDZI6tnq0iJ8Jyp0Udn1QfRRMga/XHSawZvGf0R2+V7ybQgRhk7chhj+YE1mP4nZYKR7/zs7QdzQCfcyPoctIKgJ2Lz6hp2tJDJ73l415eODMXBCPdoZ7pdp+OSZ/89jUaNjpWVRUOtV/BBV527viQlzYTkbmLByFV2jPjwxxCPjQSmKLJTs8s/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BLAPR15MB3778.namprd15.prod.outlook.com (2603:10b6:208:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 16:51:57 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 16:51:57 +0000
Message-ID: <800bde36-6cb2-d482-0cdb-b3d6005b41da@fb.com>
Date:   Fri, 26 Aug 2022 09:51:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>, Vitaly Chikunov <vt@altlinux.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org> <YwjQDBovX+cX/JDJ@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YwjQDBovX+cX/JDJ@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:a03:333::32) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f0b4ba8-ac92-4532-5486-08da87834944
X-MS-TrafficTypeDiagnostic: BLAPR15MB3778:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYo6Lj1H3x9OyRX9HNE4hWo8SomjMNOkbDUrFltyqxU8uP+lGsxEd0zU7vLKRqAMEePmYvlniwDIE1JoBgXDxUUAvFn/OPpv8vnXBffXDB2Sh3f+EwBEHBFBTU6vV5fMI2AzBpQorsotjytfzBuAEh0oWnx1KVNrgf8y1IDg8qoaJaaI4LgmXjPE1Sdpww/nQc7S827qGtw29Q3cvwvat+aHtksUmN4rFgvGSHGrZxwNOcPM3GFRzqZnoheaQfb9LX/Rr4Q2O6fN31w41GWcONgPzm4eYZ3E72+k/Z5JeOPBJfmAXH8Muu4kcjBgqc5XqRub2eizhyA17t2/0b1Gs6exo62Nd4+jYtl3YSuLiCFEzmuO2D8THOTX5IG+YVnEJtppQuRScEriKw5fsnMOHhrIVVSTcuN+tsHbcG9HwmfW+j/sTGkYVqSwZ6iBfIjm82xRXpl13qvFslk04qywUXeDlGjknNjsmL4tfQRXSIqPas6qDW9vHQQ3rfGE0OJToj8qfAkXn5D12F8sAWVflCrrnvgCLcbVwY/xp7t/NDSKfL8LJJyDhFZaT1WdZbYPtV4HYFhj5ahraTS8D1JQ59+WuggpIyuutGTIFWc/nrYzKxoIIhkuICsczr0UBmh6N6pt/SpSESGMawVeQriv+p0Vlam7dooVq78sBV3DXWzpEKZ27MUByFf/tTBEIXH9sRQ4gsoKCLKrK0PzhypVSC918J27JOW6ii8oxv1AXBvybhGAAXG9InDoPQeoduwlJQY0br06RbreDbP/H3+xmm01mCyO+sedAzAW8dsFvjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(83380400001)(8936002)(66476007)(5660300002)(2906002)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(53546011)(36756003)(31686004)(186003)(6666004)(2616005)(41300700001)(6486002)(478600001)(316002)(86362001)(31696002)(110136005)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGRrdXF3QlBhTCtsQ1NSaWRad05VcURLRUdycEwvS3RUTEZkczJXM2JiSWp3?=
 =?utf-8?B?VzR5eVpBdi9HSDFDOGFHbUdsQWRzdzZEd2xZREhKMmE1VGZhbVNpOWxXV1Qy?=
 =?utf-8?B?WS93cGl4SmduZ050RXQrdktKVHBpNUVUN214Q00rT3FxMFB0WTZLMmtkSXFY?=
 =?utf-8?B?MXJZWEsvczdsK1lRczNSWUtPLzBYdVhERDhCZWFGWW5xMC9mOVZydVV3Q3pv?=
 =?utf-8?B?Rjd5cHQ2dlZlZkp4RVFLbjNpTTR5QTVWZGZYcEd5RWFIQXdlV1hJMndvMTRi?=
 =?utf-8?B?UGQvQzZ0WFNKcFQ0U0xTWVJVMmQ1d05DR1JqNEkvc0k3ckZ5K2Q3WVNYYUU4?=
 =?utf-8?B?amNLN3lEUWNSUzI1akFLT245S2gxS0RkMmNQc093MGdVY1BCd2NPN3NNdlJN?=
 =?utf-8?B?VGZiMno1QjdheEM3SXY0ZlFGTFM4VEsxa0VDWVdwcHRMSzgxWjhUUWFGN3pU?=
 =?utf-8?B?djVNSUhkMXRVWEhTb3hSQVJRbEdIYjdObmhMaERzNnNKdU45b01zRVJnM0ty?=
 =?utf-8?B?WDNBQjBLalZQdFZWdlJiRTZjMDlYS1hGR0pOd3BPUzJ2VzYyZHRURlArMysz?=
 =?utf-8?B?dmNBTTB3UWJUUDdZN0lQNkdlWWQxa0dZZmZoMElUeWZIMktrejk5QUlxcUZT?=
 =?utf-8?B?Y1oxaHlCbnVFWFFUdnlSWHBWTDZtYkFSU21SMXRrSncvRXZKZGRwaURybVgx?=
 =?utf-8?B?WFFLZ1VkMzlTdEkwUWpMejQzTUpaTnFJRWIxK01ZWG1mK2RnSndRMHBId0JW?=
 =?utf-8?B?eWxzQXdPWjdXN0NRVUV3SXlVR3NiVkdCQ2lFQUpJV25OQ0lQQlQ5eHNxaDBs?=
 =?utf-8?B?UlRuekJobHZJUWM5c3NCT0dPMGkzRTZBVDFqL3dlaXNKWDR3TDB2dmVycEFJ?=
 =?utf-8?B?dVgrMXlhcVhldXE3R3JHalFzWmRoNEZLVFFUeDVqT3BKYWdsMXdLVGZMVWQ4?=
 =?utf-8?B?cFVNTGdkeW54WVM2M2R1MDZmekl0dWtlV0RDMW5qQkYrbFhEWlNxOU9WQTBO?=
 =?utf-8?B?eFo1Y0dsbjJGODF0b1JWNGtKT3pRYlJBVnBhWit6bFNHZWNhdGJtZGU2cnVw?=
 =?utf-8?B?WmxwclRXMmpjOEdsK3l5b245YjdiK2JTcldLMG05VTNzUWp3cU11ZUhsczlJ?=
 =?utf-8?B?VUQvbk11TUVmcVN6Y1hCU2h5Y0Z0RTNzRjUzWGo3czdQM1YrdTA5T2cxamFi?=
 =?utf-8?B?U09lTk0xTzRFN3ZvV3VOTXJJSTBTT1d1RzNZZkFrRWM1TTkvWllhQjhHdVYx?=
 =?utf-8?B?SC8rOUdGdXVZb1krUkJhRzhJWjFFUWRpRWs1QXk4YVZhWFNlNStzQmo3THFN?=
 =?utf-8?B?bE9tMXBvL1ovekxvS2ZYbkszQmJYcGlYU0FLSlY3eWE1RW92eFZNZGFoUGtM?=
 =?utf-8?B?YVltNmtZN0kxMHA2TWpybmc0ajBSTFdSRDh5bjhiZmx5R2N2QWQvcEN6SlVh?=
 =?utf-8?B?SXBvajA4cjZxdnlZdms5ZnQxNWkxakFYdmV3YXF4VlB6cTh5THZhcUwwWmdv?=
 =?utf-8?B?bTV5UjFpYjdEd0YzRk8waUFqVXFVYzZweGpSblhiemY2SFgzdWNOM2tmd0Fk?=
 =?utf-8?B?RDdydDMzNmtiSWVSNFpEMWd6azREa1B5TnJIeE9ldHRYRGl1K1ZzM2l1a3hQ?=
 =?utf-8?B?ayt3ZUR5QXNqaE5vcitDVnR1UC9IbTFvWWVtNVcvQ2t2QmVCTjZJdm1MUlcw?=
 =?utf-8?B?N0h1WDJZSXl5ODM5OXkrUnFIUGtpNjFtRGVBZUxmVk43N3lmYm53M3dKL2o0?=
 =?utf-8?B?LzhNY0N2d3A2dUc0ZzVmK3cxNUE2OXpwdzBZMWpseFpOVVkzYmhBVTNNMGdI?=
 =?utf-8?B?SUN6bGMxYSt3MjAyQXhyMzB6UjY4aTVaeHd6Yy84RFNkSWQvU3pNSFZmWTBR?=
 =?utf-8?B?bnlRS2cwQkdkUHZVRnNVcmV5bVRHUTNSbzB3b21ranM5T3JGOWJGelBZVzZm?=
 =?utf-8?B?eG9hZldkSDh6L3FXdFdvMzdpb0I4YUJhVFdiZjBwbHpRNVFEeDA4dEx6NzAr?=
 =?utf-8?B?ZEJkbjlQU0VSMEpaa2tQOWVzR3RpWGZNWFQ1SU5QajJYc0tUdkN3aFJEdE9n?=
 =?utf-8?B?WERLVWhkcGJzN3ZudkZSY2FDRVFKZ2JMeklXcGg3cUl4cWdQczFkanBtUUQ4?=
 =?utf-8?B?cGJjRlArKzA1UlhqU3E5YXBkQStHL1JJS0RyS2wzUW5qY1FndnREdEhqdFVi?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0b4ba8-ac92-4532-5486-08da87834944
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:51:57.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbD4ZXtiCDvN8qShsJj/DsW2gLMnwhu5ZfEfpEQvrU1Pm1EzQtZNsgJd6DoshtkV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3778
X-Proofpoint-ORIG-GUID: ry0djHqyY8iD9E7YLnuVBViiz04fhFJZ
X-Proofpoint-GUID: ry0djHqyY8iD9E7YLnuVBViiz04fhFJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/26/22 6:52 AM, Jiri Olsa wrote:
> On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
>> On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
>>> Arnaldo,
>>>
>>> On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
>>>> On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>> On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
>>>>>>
>>>>>> I also noticed that after upgrading pahole to v1.24 kernel build (tested on
>>>>>> v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
>>>>>>
>>>>>>      BTFIDS  vmlinux
>>>>>>    + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>>>>>>    FAILED: load BTF from vmlinux: Invalid argument
>>>>>>
>>>>>> Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
>>>>>> v1.23 resolves the issue.
>>>>>>
>>>>>
>>>>> Can you try this, from Martin Reboredo (Archlinux):
>>>>>
>>>>> Can you try a build of the kernel or the by passing the
>>>>> --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
>>>>>
>>>>> Here's a patch for either in tree scripts/pahole-flags.sh or
>>>>> /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
>>>>
>>>> This patch helped and kernel builds successfully after applying it.
>>>> (Didn't notice this suggestion in release discussion thread.)
>>>
>>> Even thought it now compiles with this patch, it does not boot
>>> afterwards (in virtme-like env), witch such console messages:
>>
>> I'm talking here about 5.15.62. Yes, proposed patch does not apply there
>> (since there is no `scripts/pahole-flags.sh`), but I updated
>> `scripts/link-vmlinux.sh` with the similar `if` to append
>> `--skip_encoding_btf_enum64` which lets then compilation pass.
>>
>> Thanks,
>>
>>>
>>>    [    0.767649] Run /init as init process
>>>    [    0.770858] BPF:[593] ENUM perf_event_task_context
>>>    [    0.771262] BPF:size=4 vlen=4
>>>    [    0.771511] BPF:
>>>    [    0.771680] BPF:Invalid btf_info kind_flag
>>>    [    0.772016] BPF:
> 
> I can see the same on 5.15, it looks like the libbpf change that
> pahole is compiled with is setting the type's kflag for values < 0:
> (which is the case for perf_event_task_context enum first value)
> 
>    dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API
> 
> but IIUC kflag should stay zero for normal enum otherwise the btf meta
> verifier screams

This is deliberate so we can have sign bit set properly for 32bit enum.
To avoid this behavior, the correct way is to turn off enum64 support
in pahole with flag --skip_encoding_btf_enum64.

> 
> if I compile pahole with the libbpf change below I can boot 5.15 kernel
> normally
> 
> Yonghong, any idea?
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/src/btf.c b/src/btf.c
> index 2d14f1a52d7a..53d7516e4b89 100644
> --- a/src/btf.c
> +++ b/src/btf.c
> @@ -2151,10 +2151,6 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
>   	t = btf_last_type(btf);
>   	btf_type_inc_vlen(t);
>   
> -	/* if negative value, set signedness to signed */
> -	if (value < 0)
> -		t->info = btf_type_info(btf_kind(t), btf_vlen(t), true);
> -
>   	btf->hdr->type_len += sz;
>   	btf->hdr->str_off += sz;
>   	return 0;
