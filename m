Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E82B57D6E5
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiGUWaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiGUWaU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 18:30:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871C03247A
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 15:30:17 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJknfi005693;
        Thu, 21 Jul 2022 15:29:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nTNDimkwAjvWtt9c7pwzWMl3VreiB4hnlXf3sRs2qGY=;
 b=V/4bg2pWSssVwRwZ8KdufF1m2FgcI1uhC83L3ulamGZo5OU8M3SYkhP2Z7ZPHumAAIZn
 XY2hpkVfwBnsTS3ev1pu4N1Fk1OKRWpI616tk4GYAOS99BzcFuoBkE221kVadRQlnFIP
 4zseI7sz9WXv13cn5T0uunma3UYAlYJ6ohQ= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hehn2tyjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 15:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajdQ+tHwf24AfYrXahEx6VuYf+GEHwdT6vqk51HKbZNtG3z86Gdeuj04QQOc7mrcJpGyXb/fv43yxUOfUk1/3ONQ6s3MvsQ7GIPzb6C7Xl94QDPAsjVOU+2EHYeS7OzuTNCgS/uZhmkghzUoCCbah0lo8mhpeOgX9EJiI5DniyfTRDIDKgJ+HbsEcLGzJXQlyT2Y5ezmzxH6EZwW/yaW6SVLw6QVMgu5RrZJKifD3UFSfCOgqISrOhEUjbljC3JP6BLYCwFPGt7EuPuv8VlzVIN1G3y6OH0d8OFI9oJGAlxHwl3WsN5+zK7tqAu7QQUjrVMRpRWFlzhLK3Ng49UeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTNDimkwAjvWtt9c7pwzWMl3VreiB4hnlXf3sRs2qGY=;
 b=fh2RmxyowVwQ95gFjZoIkexWZUh3gJYdQUV7LyIC1Oxu3kse3WSFS94llFrTBKkzFt1Y9GaDSfaHvkUAiKYbkCLHYDlIur/QFvJ9TX35WoOASmeO6ZRtM++LO1Weub0pjYqr8d1ljIG7DdMCh9sH3JVo9zIGdDMMc9MJy7gJihTwxgZ/vtnJeXaOT8JX+mpXk8FqMenSweTO9jYch3oYhvklxChOzsAe6bo14QosiWMVnugAE6ZUL3VAowkkr2RlbCNfARDYDTmjWutC1Kbo6cDUzevK9JzdhMqaUIlQ8PJwNZJnTXnPaSZEJpmh/+6fVnQef/HVdZR+UkBCZs9NxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3759.namprd15.prod.outlook.com (2603:10b6:806:83::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 22:29:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 22:29:54 +0000
Message-ID: <7b2e6553-5bcc-1c70-2c4b-78e95593755b@fb.com>
Date:   Thu, 21 Jul 2022 15:29:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220718190748.2988882-1-sdf@google.com>
 <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
 <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
 <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com>
 <Ytc8RvDTpEmC0pQD@google.com> <YthDy8uhE2ky0rBr@google.com>
 <20220720205255.4v3y3a4xttesfkn6@kafai-mbp.dhcp.thefacebook.com>
 <CAKH8qBsnXnTYJ7e2v8qLOmWcp5j96LKwTuMLQaTzHsxhDdZ-dQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAKH8qBsnXnTYJ7e2v8qLOmWcp5j96LKwTuMLQaTzHsxhDdZ-dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 640b5d30-fe3f-4589-c716-08da6b6888b4
X-MS-TrafficTypeDiagnostic: SA0PR15MB3759:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f15GAxm8qCbiqt/LsWDUQa0wg4dz/a5bkAjs64sGAzd2MNm0DpKKXp8EDWN3OGcz1bHoeyy/BjrqqkEcBMkyQ7p/e+uplOV8Jn3P2D7+e3WTBNgtSUvKuXGjqiUDaJxyFZygIeR0jBk0WrKh44T6710gI7+gVmIhGPkvlz2RCiQeO6NFnSgmlFHvWmrFfeAU3h9QtemWPNDrMiWhgLHwRJDEMz7LewhBxXk6z0ZINMi3ohVYZwJ1HZPMwQUUQt/DTniT6ydgf2830ejPhjiQmlBDM5hNyGQtqTBwla8H2iwNGeZEs7V1T/qIa30A83NBfTBIu8wH/o9FC3DhtU/Rqyq6cJu+sA+KlHcPabiCewS7gvirBrfefgJM00A9Zverc+BWAs5Hr6i4/46iJTuXFaQmGd+WTLtGJcZTErkGxBiN5B5cWplbHGcal1lhXebhpkkVEy4O69lQ0WooxWKt54ubtNGhVVjhOYSWbNssftJG5cNIRNYB5O3FYACGtnB9E0Qo2aaFKiWrtPP0YV/OvtoV64U5FPCCHPBHmD784w172Q450iPaHwWl50yNxL+x7dFsoYrQTXiMy4duuwKCXsT+jB2X0gX+5b8Twto6JaS1BWG3SOTILNShexLg7AP5jgRAB2fuIV2slrx/VPMvB+Zoif0TYUV0FxERqSlIGuqM7/phMelZLVldugj7kG0OLh2Ner5FSSlff8MeNBA8EgOwwmWCfxsfGFiJgrAEArdJGwQE+eZR/cE/863dlZpFKwnWz/pSXnVo6XJ0Yik5sJ/ugFu6y3WNHsS8aAawWHm3InyKAMSZL0dQwzCAL3yDbGhA4hOFGRc0cJc7rHQERw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(66556008)(66476007)(38100700002)(110136005)(54906003)(316002)(4326008)(66946007)(8676002)(6636002)(36756003)(2616005)(478600001)(8936002)(31696002)(86362001)(6486002)(6512007)(30864003)(41300700001)(2906002)(7416002)(5660300002)(186003)(31686004)(53546011)(83380400001)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajM4MXUra29Mb3JGRmdnK3BBQ0UvbnMvOGI4N3hIYzVkenpsU3NxWDI4ZE1T?=
 =?utf-8?B?bE5wR1h0ejMxd0FXWWNZRVZ2RnpNamtzcFV5R0c3YXNWWldRdVdrVG15VFZv?=
 =?utf-8?B?WkMyaDBWWDRUSkNETSs2Ujl1QkpWRDZmd0xPRDJKMGhENjdESGtSdFRaQmpT?=
 =?utf-8?B?VExKTXBQK1hjVGJGS2NuN2xaaHMyNkVPczliZmRXbkhFZkQvQjFXRjRVUUxH?=
 =?utf-8?B?REFsRHF3K3hwZUdKek41bjJPZTVQSXZ6aEhJNWFxWEZPaVh6d3F5T3NXNVQw?=
 =?utf-8?B?SUxJNFN3TEtrNURkZ0VLLzh1UllTU2l1VXlWVm02WmxMRW1EbStkb3NnZFA4?=
 =?utf-8?B?aDFod0JWLzdQblNlU09zY2NkRUdWakJ6TURjREVzTkw2N1dVKzJqa3hTK0w1?=
 =?utf-8?B?S3hSK0RVcUlNd1lBaHVBNmR3Yy9zZ2dKWFllMGp4Tit5MzRERkZaTk0yMEJq?=
 =?utf-8?B?MGlrTnlYL3h0RHFtcDBjTS9RR1dEQ0toUlRQc3oyOW1QN29IWU5qekVMZmpn?=
 =?utf-8?B?RUpNNGJYV3hwRy9YdHlqS0N2WVI2U09WeWxiNlZ6MVhRSlVBVHB6NnFFUFlH?=
 =?utf-8?B?WUZ0c2kvcUg3MnBVTGJvTVozTDN3dVhCdTNTSG16dW9TVCt5dzYwMjdqamFv?=
 =?utf-8?B?WVB0Mlo0MnVET3RHQllCZ1BNTHczb3hWUWprdDR2OS9SSENPd3dqbWM5eStN?=
 =?utf-8?B?R2lER0tTR1JtZTh3dTlxV3QzTi8vTlZuYzVybnRKSzV3ZzN5Y1pKZHZVdkln?=
 =?utf-8?B?N2FwNG9lY01aYnZSdzY3cTNJZFRIQ20yQk5GdnJzYVhyWmtnUThOT1FMVVJO?=
 =?utf-8?B?OXVERlh1Z2QwV2VPcVc5c2g2U1pKMjFSTk1CZGlwSy9LZlFYekpNRE9DMEk3?=
 =?utf-8?B?U2QrSGluelk5NFZPVlY5ZWdnMGxlVEkxVlBtemtaOFpSRko1Q0N6TjF1dUsr?=
 =?utf-8?B?M1c2YndyYjhRY1Ywb2FtRFpBc0E3d3lrVExmR09XOUt2OGkzc2oxQTl1Z3Ay?=
 =?utf-8?B?WDlMditEWFFtYnBhbnh5Y1hiQjIrUlp2cmROdFBYdG5HOUg2SDJrNW56YWt1?=
 =?utf-8?B?ZUxaQ2ZlTFhuMk9YNGJtcVcxSnUvcXBHNzFEQ0FKNE0wUmxxWVA4SWpFMnlu?=
 =?utf-8?B?TFloeCtYRWJUckhRaWhsODRPeXZ6VTMySlVmY1dQMWVvVlIydm5XckNiSW1H?=
 =?utf-8?B?WnVKNnA0UFVueXNBWTFlNmdYYk53cWtNekZVc1R0Y2VVNTgrZXZDMXRHNytG?=
 =?utf-8?B?YUhIellnMmkxanY3L0RqZDc1dExOMU9mQ1VIUExjNjQwaU1laWI4eEwySTJy?=
 =?utf-8?B?UEJvUU9xQ1BTQlFzbGF1bHh2MXRuVE5oSjY2VmZiVVBYUG5IS0lyN0ltNHFV?=
 =?utf-8?B?b09zODE3aGF4My9WMDJxTHplSXVJVE5sVC85d1lpRDkzMEtIQmY5aTlLaXNx?=
 =?utf-8?B?Vm9hT3VzcDJTVi92Y1RWemVxSmI3U09wcXBWRGwyWGxQN1ZBenhQVWV3NTFD?=
 =?utf-8?B?T3RGNS9oQmw1TG5aVXJGT295MHBtK2NZdU9TM3lITGVKTmNxTmZSc3JmZXBI?=
 =?utf-8?B?SWxlcjJHdnpCc2NlaFVyN0Q0UVhEM0kxbDJ6OEw2NzJMRHAvZDFQRm5MSjY3?=
 =?utf-8?B?dVpFUFBUQ2Nhd0Y3MlJLU3Q0THlPblpObFdKNXAvNzVnd2FIaWhKRFFZbHNK?=
 =?utf-8?B?ZmlZbHg3RllvbkhReEpHTVhucy9PVHY0WFdhTDVsT3VqcUo1bGlRbjU5VlRy?=
 =?utf-8?B?bEp4eDNINnUrTVVwdzBEdTIvUDhnd2xOTHNKRy9NcElXbndlcWdRUlg3cXJ0?=
 =?utf-8?B?NHhweFdiZVdhUDBpbGIzKy9WOEFEdTMrYVliaU9XakViM1c5dTFHZE1teERp?=
 =?utf-8?B?bzQ5ZlU5Vk1FYS9URVVZRXVmWmI4OVF6Ylo4WW94VldPNksyRzduTzdieDlX?=
 =?utf-8?B?ZnFBbHF6MG8wcGR1U2tjRlMwU3BvV01xaHd3V0I5UjlQenMvSUF6Ylk3UUlF?=
 =?utf-8?B?eFdPRnVBMDFYcnc0SVFmZFNpd045OWxsVWoxWDlvZVBpWG96TkNOM2E3WjhX?=
 =?utf-8?B?a1FUUWczS3U2K2FXQnJQcHlVVmRsVXJ0cmtydEYxdnRISHZaZUt1ZFFpdkxS?=
 =?utf-8?Q?Loy4UyFId+ApOufrLrxlSESnn?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640b5d30-fe3f-4589-c716-08da6b6888b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:29:54.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErQOkFcFMj21hLwOwfGv9ejFFSKVYOSPDrSEmjYRiccVa6IB5K2NEZ55AcvNPVr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3759
X-Proofpoint-GUID: aFFcV8Dcor6p4uRsk_NlK7KNeck-DGcq
X-Proofpoint-ORIG-GUID: aFFcV8Dcor6p4uRsk_NlK7KNeck-DGcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/20/22 3:33 PM, Stanislav Fomichev wrote:
> On Wed, Jul 20, 2022 at 1:53 PM Martin KaFai Lau <kafai@fb.com> wrote:
>>
>> On Wed, Jul 20, 2022 at 11:04:59AM -0700, sdf@google.com wrote:
>>> On 07/19, sdf@google.com wrote:
>>>> On 07/19, Alexei Starovoitov wrote:
>>>>> On Tue, Jul 19, 2022 at 2:41 PM Stanislav Fomichev <sdf@google.com>
>>>> wrote:
>>>>>>
>>>>>> On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com>
>>>>> wrote:
>>>>>>>
>>>>>>> On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev
>>>>> <sdf@google.com> wrote:
>>>>>>>>>
>>>>>>>>> Motivation:
>>>>>>>>>
>>>>>>>>> Our bpf programs have a bunch of options which are set at the
>>>>> loading
>>>>>>>>> time. After loading, they don't change. We currently use array
>>>> map
>>>>>>>>> to store them and bpf program does the following:
>>>>>>>>>
>>>>>>>>> val = bpf_map_lookup_elem(&config_map, &key);
>>>>>>>>> if (likely(val && *val)) {
>>>>>>>>>    // do some optional feature
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> Since the configuration is static and we have a lot of those
>>>>> features,
>>>>>>>>> I feel like we're wasting precious cycles doing dynamic lookups
>>>>>>>>> (and stalling on memory loads).
>>>>>>>>>
>>>>>>>>> I was assuming that converting those to some fake kconfig
>>>> options
>>>>>>>>> would solve it, but it still seems like kconfig is stored in the
>>>>>>>>> global map and kconfig entries are resolved dynamically.
>>>>>>>>>
>>>>>>>>> Proposal:
>>>>>>>>>
>>>>>>>>> Resolve kconfig options statically upon loading. Basically
>>>> rewrite
>>>>>>>>> ld+ldx to two nops and 'mov val, x'.
>>>>>>>>>
>>>>>>>>> I'm also trying to rewrite conditional jump when the condition
>>>> is
>>>>>>>>> !imm. This seems to be catching all the cases in my program, but
>>>>>>>>> it's probably too hacky.
>>>>>>>>>
>>>>>>>>> I've attached very raw RFC patch to demonstrate the idea.
>>>> Anything
>>>>>>>>> I'm missing? Any potential problems with this approach?
>>>>>>>>
>>>>>>>> Have you considered using global variables for that?
>>>>>>>> With skeleton the user space has a natural way to set
>>>>>>>> all of these knobs after doing skel_open and before skel_load.
>>>>>>>> Then the verifier sees them as readonly vars and
>>>>>>>> automatically converts LDX into fixed constants and if the code
>>>>>>>> looks like if (my_config_var) then the verifier will remove
>>>>>>>> all the dead code too.
>>>>>>>
>>>>>>> Hm, that's a good alternative, let me try it out. Thanks!
>>>>>>
>>>>>> Turns out we already freeze kconfig map in libbpf:
>>>>>> if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
>>>>>>          err = bpf_map_freeze(map->fd);
>>>>>>
>>>>>> And I've verified that I do hit bpf_map_direct_read in the verifier.
>>>>>>
>>>>>> But the code still stays the same (bpftool dump xlated):
>>>>>>    72: (18) r1 = map[id:24][0]+20
>>>>>>    74: (61) r1 = *(u32 *)(r1 +0)
>>>>>>    75: (bf) r2 = r9
>>>>>>    76: (b7) r0 = 0
>>>>>>    77: (15) if r1 == 0x0 goto pc+9
>>>>>>
>>>>>> I guess there is nothing for sanitize_dead_code to do because my
>>>>>> conditional is "if (likely(some_condition)) { do something }" and the
>>>>>> branch instruction itself is '.seen' by the verifier.
>>>
>>>>> I bet your variable is not 'const'.
>>>>> Please see any of the progs in selftests that do:
>>>>> const volatile int var = 123;
>>>>> to express configs.
>>>
>>>> Yeah, I was testing against the following:
>>>
>>>>      extern int CONFIG_XYZ __kconfig __weak;
>>>
>>>> But ended up writing this small reproducer:
>>>
>>>>      struct __sk_buff;
>>>
>>>>      const volatile int CONFIG_DROP = 1; // volatile so it's not
>>>>                                          // clang-optimized
>>>
>>>>      __attribute__((section("tc"), used))
>>>>      int my_config(struct __sk_buff *skb)
>>>>      {
>>>>              int ret = 0; /*TC_ACT_OK*/
>>>
>>>>              if (CONFIG_DROP)
>>>>                      ret = 2 /*TC_ACT_SHOT*/;
>>>
>>>>              return ret;
>>>>      }
>>>
>>>> $ bpftool map dump name my_confi.rodata
>>>
>>>> [{
>>>>           "value": {
>>>>               ".rodata": [{
>>>>                       "CONFIG_DROP": 1
>>>>                   }
>>>>               ]
>>>>           }
>>>>       }
>>>> ]
>>>
>>>> $ bpftool prog dump xlated name my_config
>>>
>>>> int my_config(struct __sk_buff * skb):
>>>> ; if (CONFIG_DROP)
>>>>      0: (18) r1 = map[id:3][0]+0
>>>>      2: (61) r1 = *(u32 *)(r1 +0)
>>>>      3: (b4) w0 = 1
>>>> ; if (CONFIG_DROP)
>>>>      4: (64) w0 <<= 1
>>>> ; return ret;
>>>>      5: (95) exit
>>>
>>>> The branch is gone, but the map lookup is still there :-(
>>>
>>> Attached another RFC below which is doing the same but from the verifier
>>> side. It seems we should be able to resolve LD+LDX if their dst_reg
>>> is the same? If they are different, we should be able to pre-lookup
>>> LDX value at least. Would something like this work (haven't run full
>>> verifier/test_progs yet)?
>>>
>>> (note, in this case, with kconfig, I still see the branch)
>>>
>>>   test_fold_ro_ldx:PASS:open 0 nsec
>>>   test_fold_ro_ldx:PASS:load 0 nsec
>>>   test_fold_ro_ldx:PASS:bpf_obj_get_info_by_fd 0 nsec
>>>   int fold_ro_ldx(struct __sk_buff * skb):
>>>   ; if (CONFIG_DROP)
>>>      0: (b7) r1 = 1
>>>      1: (b4) w0 = 1
>>>   ; if (CONFIG_DROP)
>>>      2: (16) if w1 == 0x0 goto pc+1
>>>      3: (b4) w0 = 2
>>>   ; return ret;
>>>      4: (95) exit
>>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LD 0 nsec
>>>   test_fold_ro_ldx:PASS:found BPF_LDX 0 nsec
>>>   #66      fold_ro_ldx:OK
>>>
>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>> ---
>>>   kernel/bpf/verifier.c                         | 74 ++++++++++++++++++-
>>>   .../selftests/bpf/prog_tests/fold_ro_ldx.c    | 52 +++++++++++++
>>>   .../testing/selftests/bpf/progs/fold_ro_ldx.c | 20 +++++
>>>   3 files changed, 144 insertions(+), 2 deletions(-)
>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/fold_ro_ldx.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/fold_ro_ldx.c
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index c59c3df0fea6..ffedd8234288 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -12695,6 +12695,69 @@ static bool bpf_map_is_cgroup_storage(struct
>>> bpf_map *map)
>>>                map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
>>>   }
>>>
>>> +/* if the map is read-only, we can try to fully resolve the load */
>>> +static bool fold_ro_pseudo_ldimm64(struct bpf_verifier_env *env,
>>> +                                struct bpf_map *map,
>>> +                                struct bpf_insn *insn)
>>> +{
>>> +     struct bpf_insn *ldx_insn = insn + 2;
>>> +     int dst_reg = ldx_insn->dst_reg;
>>> +     u64 val = 0;
>>> +     int size;
>>> +     int err;
>>> +
>>> +     if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr)
>>> +             return false;
>>> +
>>> +     /* 0: BPF_LD  r=MAP
>>> +      * 1: BPF_LD  r=MAP
>>> +      * 2: BPF_LDX r=MAP->VAL
>>> +      */
>>> +
>>> +     if (BPF_CLASS((insn+0)->code) != BPF_LD ||
>>> +         BPF_CLASS((insn+1)->code) != BPF_LD ||
>>> +         BPF_CLASS((insn+2)->code) != BPF_LDX)
>>> +             return false;
>>> +
>>> +     if (BPF_MODE((insn+0)->code) != BPF_IMM ||
>>> +         BPF_MODE((insn+1)->code) != BPF_IMM ||
>>> +         BPF_MODE((insn+2)->code) != BPF_MEM)
>>> +             return false;
>>> +
>>> +     if (insn->src_reg != BPF_PSEUDO_MAP_VALUE &&
>>> +         insn->src_reg != BPF_PSEUDO_MAP_IDX_VALUE)
>>> +             return false;
>>> +
>>> +     if (insn->dst_reg != ldx_insn->src_reg)
>>> +             return false;
>>> +
>>> +     if (ldx_insn->off != 0)
>>> +             return false;
>>> +
>>> +     size = bpf_size_to_bytes(BPF_SIZE(ldx_insn->code));
>>> +     if (size < 0 || size > 4)
>>> +             return false;
>>> +
>>> +     err = bpf_map_direct_read(map, (insn+1)->imm, size, &val);
>>> +     if (err)
>>> +             return false;
>>> +
>>> +     if (insn->dst_reg == ldx_insn->dst_reg) {
>>> +             /* LDX is using the same destination register as LD.
>>> +              * This means we are not interested in the map
>>> +              * pointer itself and can remove it.
>>> +              */
>>> +             *(insn + 0) = BPF_JMP_A(0);
>>> +             *(insn + 1) = BPF_JMP_A(0);
>>> +             *(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
>> Have you figured out why the branch is not removed
>> with BPF_ALU64_IMM(BPF_MOV) ?
> 
> I do have an idea, yes, but I'm not 100% certain. The rewrite has
> nothing to do with it.
> If I change the default ret from 1 to 0, I get a different bytecode
> where this branch is eventually removed by the verifier.
> 
> I think it comes down to the following snippet:
> r1 = 0 ll
> r1 = *(u32 *)(r1 + 0) <<< rodata, verifier is able to resolve to r1 = 1
> w0 = 1
> if w1 == 0 goto +1
> w0 = 2
> exit
> Here, 'if w1 == 0' is never taken, but it has been 'seen' by the
> verifier. There is no 'dead' code, it just jumps around 'w0 = 2' which
> has seen=true.
> 
> VS this one:
> r1 = 0 ll
> r1 = *(u32 *)(r1 + 0) <<< rodata, verifier is able to resolve to r1 = 1
> w0 = 1
> if w1 != 0 goto +1
> w0 = 0
> w0 <<= 1
> exit
> Here, 'if w1 != 0' is seen, but the next insn has 'seen=false', so
> this whole thing is ripped out.
> 
> So basically, from my quick look, it seems like there should be some
> real dead code to trigger the removal. If you simply have 'if
> condition_that_never_happens goto +1' which doesn't lead to some dead
> code, this single jump-over-some-seen-code is never gonna be removed.
> So, IMO, that's something that should be addressed independently.
> 
>> Can it also support 8 bytes (BPF_DW) ?  Is it because there
>> is not enough space for ld_imm64?  so wonder if this
>> patching can be done in do_misc_fixups() instead.
> 
> Yeah, I've limited it to 4 bytes because of sizeof(imm) for now.
> I think one complication might be that at do_misc_fixups point, the
> immediate args of bpf_ld have been rewritten which might make it
> harder to get the data offset.
> 
> But I guess I'm still at the point where I'm trying to understand
> whether what I'm doing makes sense or not :-) And whether we should do
> it at the verifier level, in libbpf or if at all..

I think the approach above is a little bit fragile.
There is no guarantee that ldx immediately after ld.
Also, after rewrite, some redundant instructions still
left (e.g., map pointer load) although it can be rewritten
as a nop.

In general, 'const volatile int var' should be good enough
although it still have one extra load instruction. How much
did you see performance hit with this extra load?

If we truely want to generate best code (no libbpf/verifier
rewrite with nop's) robustly, we can implement this in llvm as
a CO-RE relocation. In such cases, compiler will be
able to generate
      r = <patchable_value>
      ... using r ...

So in the above code, the CO-RE based approach will generate:
   r1 = <patchable value>  // we can make it always 64bit value
   w0 = 1
   if w1 != 0 goto +1
   w0 = 0
   w0 <<= 1
   exit

This will only work for upto 64bit int types.
The kconfig itself supports array as well for which
CO-RE won't work.

> 
> 
> 
> 
>>> +             return true;
>>> +     }
>>> +
>>> +     *(insn + 2) = BPF_ALU64_IMM(BPF_MOV, dst_reg, val);
>>> +     /* Only LDX can be resolved, we still have to resolve LD address. */
>>> +     return false;
>>> +}
