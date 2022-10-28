Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725AC61072E
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 03:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiJ1BVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 21:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ1BVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 21:21:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD1A8CC2
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 18:21:34 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMnAAf030788;
        Thu, 27 Oct 2022 18:21:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KGSPsuZ4flz5pZP6h8OlP3QjI/mGMHuAYYYBX7OsiCE=;
 b=JFs+lSwQkmuJPGy/qNxsb0MZBoC9PwGL0Kp7+RRxw/NK9dEUh6FLq5icsCkHcdLWxT75
 tThfBE+Pe5sO0nGTOh0aMhVkWQePc4aNwdRs9nXL91kG3vRzS66wjFNZ553metCVjgS9
 jgjNavPuYJlye0LiUvTkhpOqWZt5sh6wp3YIt0LRJZlnwj47BuLM/YVuQcnNI1eo2yzL
 hlk+pc/TZlCIRIe3TtWeFug5rZNQtKd9AD854LtQLJJhpsYqqMLBsvvUJ0GxnqkTj43n
 dH++zu2WU0yFiKznNxgnTHHFMrQqZfNHB1Z+iOtLb5iB475prr2JgDPcSeNaXaCGbE2P 1A== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kfahk7gv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 18:21:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDILsvNShUHfSDGCKsYsM0xoRWDaJ3HN3Hei2ZcMfv2DN8exxskpca1uuuJzyOoX6/9ijsJC4KXETS80Q2qWvUSWJiPg1FjvrvvdNv/g2gApRb6Z4gLxt3sdAvSKSFAK4PiHsGQlbGfxickeHyLCtIbmFROlDFltH8qx6oQz3jJok8PwZsPnWJivG6u7B1cAHHutzPuV++V0a1CZS+PM2O+CxERbeA3eBwGAd+sHTBmbrMnCVWVDeDssxAGuZcDDt2w5Mm4WlxFHcoZfXvAJFWzfb9IZIuCsZfQooRoGw4Xvyd73IBlfJWSY3saNlxWCnCFQ0gMW0Kvm2kLFr+efcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGSPsuZ4flz5pZP6h8OlP3QjI/mGMHuAYYYBX7OsiCE=;
 b=eN154FCehGGif5YBV7WE7syPfzdJUJaxbWY31973TEq73aFDKd4+5xPNw1itROxKYU1QsvaOs+SUndFPt4fmFqoSswiPx6R9tfHt/8MCzNG0wWtpES+YvTrzQHV3iq0bBPqpzwlX4x78WAk3Ch6xfKbBy2yqQ1Bm99VtnseRikBTvKa7IlC/4oysrKJygNpC2otSUJeX4FAdaGIl0EzpoGnYxbhCEhkNFoJjX/qjhj8oQ4+HZGCUnqP+2mtvlMa08iUYS2l6hg4jDbBcQ4Ams56igmiJ7MSBkHlKlnoGN16K5vhHWvV0ntCK9tzHeCr3fhfZBz2xhXYSXexE2iBrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2891.namprd15.prod.outlook.com (2603:10b6:5:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 01:21:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 01:21:15 +0000
Message-ID: <82c1d653-53d6-7757-893e-8614925f5efb@meta.com>
Date:   Thu, 27 Oct 2022 18:21:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC bpf-next 09/12] kbuild: Header guards for types from
 include/uapi/*.h in kernel BTF
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <20221025222802.2295103-10-eddyz87@gmail.com>
 <dacaeb37-c55a-a328-61f2-77324efbc822@meta.com>
 <6e57811b-229a-e4f8-ca7e-fe826cde4be4@meta.com>
 <7a3ebc5f-b07f-0336-abb1-627f7a73b2cb@meta.com>
 <237df1d8b2c0bf546ab81abb73ae0b78e2c0cbaa.camel@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <237df1d8b2c0bf546ab81abb73ae0b78e2c0cbaa.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2891:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4649e7-9d98-47ac-26f9-08dab882b570
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iW8C2xpp45hhwkJbJkNEAOV8z/y0CF8os8ISuLacyJjqkQKzBfnYWA3ccE7O/M0z0oD7+ThK6jLrl5I6dcw6C2LqJ0Q3Nr19PiuBFzwSfDT3V2dv25MOG+M+yNH+OHzhvVb3NXjdIw9zB3H2NoC9Aq+ngR9bFZG6YBJC+v8PSYBPJU0fkkXoJ/EFQ1svntqGVfVbIUCqZ62VxgmTnG0Bhz7RiIrEg9PdyuPf32UeKvtk/INuJELfNudbpmKdND9SQgmW2s9Wgz4Ud6UJjuA/c8K/nJ+gz1Y+DeCG5WRlmUxXEJnf2HTOZkbllzAHlm/E/QpIKRO8cyuwR302zba3bS9LulzBLG2QpzlSRHn/LMt+8FY3h6cRnbLY65gxLZ14/AJR4VHsTMUqEVaZ+ISltlzTC9YTB/dDJKGR4ZeciBnwDwmxXCDeB/6J+mPXz3FfhFf8ymdKXKMSz3+IXbawhU0eNA/Di3fXeDTRb8e9q1cDw6uiyBvO7rxpP/7vrETF3ZCdSobyU/EFWG4gtRiOokC3y8Co4IkG0AwoULyJA31VbGxYVAoTdhd7WFu5VjV1zXG1FTc68CG/0b1kbm3WFT/9On3atY5xlDnsK6vcXQIqBO5hNo/4X8etcTEgLv9g8xvvEQecYO3isF3aGviYw7c7JwgiV98e9Es1XTWk1fbO3Y2tRYvYs5NPvNI3SBREDswszXiakev5fHj4iJnlxLlwPH+BRVI9RChAtET43RD3wUwvhEqV3zzov6bim8MiXpxeJmiGR5I0zffA7EpMEJ/9hvF3Z/O8L6cmSqwN7Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(5660300002)(2906002)(66946007)(4326008)(66476007)(66556008)(316002)(31686004)(8676002)(41300700001)(8936002)(6506007)(38100700002)(6512007)(2616005)(186003)(6486002)(6666004)(53546011)(478600001)(4001150100001)(86362001)(31696002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZOa0szNjlQV2U5ZW8yRmw5Y2hSVEtpeUxuTEdaMVRweXVCaXhvbDA4OWxJ?=
 =?utf-8?B?Nkk5bzZmNGVIc1h1VW83aW5zTWhEbFRmUEZQSlFubG5GZmV4WWtycUJWS3cx?=
 =?utf-8?B?YzdsSksxU0lValVLTnVnWWZ4RTA4TGU1bU5kdmRSQXBiNTEvY2lUYmJEMjFL?=
 =?utf-8?B?ZVUyd2xnZHp3c2R2RHdnOFpzSVpESjlJT1l0RDJ4NmFiKzFUMGQ4QXJYTDlI?=
 =?utf-8?B?ME0zc3F0SHBzR2d2cUlpTUpnM2c2ZVRPOWtnZWhNVVViSmgvQVErL2E2SnR3?=
 =?utf-8?B?N3pLdVhlWTBUQnBENE1pMXZiWUt1SVFERGxla000OHhma0xEcXR3anEzTmJX?=
 =?utf-8?B?clFCSGRud2dHclVkY1hDaUZQTlhsbkFQd0F3VXBNQS84SkdJUVd0aGFZUlZn?=
 =?utf-8?B?NnBicktXc0ZlVUYvYlNMRmpYWURoa3JPSlVuYzNFbkREVFBrUFdSc00yNGk1?=
 =?utf-8?B?QlhwTUtkK0psQzJpNTVoQjVXZ3JpRXRhenlKdnJqdTA4WGVpQktXR25TQkE2?=
 =?utf-8?B?RjQ1SUN2eFpGRi9HNlp6eXdhNHU5YkxWaGN2V2htd2h0YUVuaWREcjkrbFRv?=
 =?utf-8?B?bS9URzkwaGtjNUxwSE9MejBDYXZEUk1mcmhCMW5ydUVKN2JVdE5XK29XWTBM?=
 =?utf-8?B?eEdvY3RUWWhkazBLRG5xcHhhSkQ2OTg2S2E5a1hLTXQzRkhMVTBSOWRsS1RO?=
 =?utf-8?B?WGNBanEyaUFZK283Zm56cnBrNjJBaUVCZlZqR0dIWThPT3E3eDRVSDhzTVpX?=
 =?utf-8?B?VG1SNVZqNVVQVnBPbHJxVG1zbWcyVFYxRDVhdGFvYzhpejRrTU5xcXdMQ0Qz?=
 =?utf-8?B?MFlpNWlYSWp4elQ3YlRiRTk3VVZFSCtxNHZnaU9vay9TN1NOejR6VGpmTUVo?=
 =?utf-8?B?VjRvSGNFS0N4UXJhMjhUTm4xU0FWMXpwejVodmd2dHBDUC8wS2dKZTUxZnhu?=
 =?utf-8?B?ZERvaHpPbVkvWUszZ1I5N0RLYUVpSlhXbEpTNXh3V3NBaEh6akN2cVV4OFRO?=
 =?utf-8?B?UUc1YmpQOWZ2M3d4ZFdmRnhUOTR5bEpiZStTWXRRYUZmUVFXSjFtMU9FTWlj?=
 =?utf-8?B?bHNRQ3EyS0dLVzhrTHVrU1F6a1BPbVZSUXpHZmw3aWZHdGk1T3lvZUdhNlBz?=
 =?utf-8?B?cytPWU1tZ2tBdHZIWVFiVmdoOU9EVldwMWc2M28zblJNaVdCbDZqcGNrY0Mw?=
 =?utf-8?B?VEdpbnd3bUJZTytwVWNCQTl6dWtiMktQMzRmK2xRbm1ZVjNUc3dzZy9rZlVs?=
 =?utf-8?B?SDRURG83TmtHNFBWZmQrbVFKTFBQTjRROHRteURoT2tzRUJwa2xhSWhoeE0w?=
 =?utf-8?B?WGpuSjUrU1RrMkJBTXVZL2NUZy9maTRZZEZ1clpsa0FUcEUvcEtzUW93dWdW?=
 =?utf-8?B?RVAwdUtQczJ3bU82WC9OeUlIYXBYUGl2d2xsb2FsRWtWdmJXY2dpbyt0Tm1X?=
 =?utf-8?B?bXh4YVRSTVNwdm55dXArY09zR2hBR25Gdm85OFFLTXN2T3Q2US9SQjZ6N3J5?=
 =?utf-8?B?RTZ2K0NtcGNzSkZmcUQyc24wN0xtem9iZEx3Qlo2dCs3NHltNmN3ODN2NWpo?=
 =?utf-8?B?KzBIelJXMUpNaVIvL0xsOGsxU3I4MFJJQU5HcHBVb2Y4bHJ3VVZuTDJxbVBp?=
 =?utf-8?B?T3pYR09IY1JCeWtRWDM1cTNyUkFyTnFvQlBTUVI4UlUrUCsyU3VZNWJ0T2pQ?=
 =?utf-8?B?UWFUaWhPeWR4L3h6RkFKYjhFTngzdld4R0JlNWNEOTFqQy9TSlp1bHIzN21F?=
 =?utf-8?B?SFpCOXE3L0V4bFpyaitXM212STJzaUJOZDlic1A3ZzFFemJDR3ZXOURUSU51?=
 =?utf-8?B?dGxYWFpWOU5uYVFaQnd2SENsTXhhKzRYOEJrVFN0MjBOSnBOOVhMdXBXZkkw?=
 =?utf-8?B?azBlZk5UamZyL01LZDZ3QjJNZy9ZMFVyem5XTUFmck1oNGhGUmpSTCtEd2h2?=
 =?utf-8?B?UGJDaFd1em5YaUVtSFcwWDNZUVdwYUk5Skxyd1RmVmxaZVN6NWVRaG0yd015?=
 =?utf-8?B?RmJjd0VlRXdyMXFrUlhGalhsQ0xXMEFUSWdNa2JzNEsxTFo5LzdXN2hlMTNt?=
 =?utf-8?B?bVZhMDkyTzYzNVh0ako4WWhqbGVIYlhyRGhQZXdVK0ZFalRkb1R4dm5ZNGtu?=
 =?utf-8?B?V3NXRythd1hNVSsxQUg0Z1A1ZGQzRzdzQUtXeWdtTnJsbmM1cmd1Rm1VT0hI?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4649e7-9d98-47ac-26f9-08dab882b570
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 01:21:15.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1EEiN63ZYWJMUv+S2maPYR6VDAFM9p+Ix7AzI3/x1v9RRoOsl4lMMZ7tt3yuY9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2891
X-Proofpoint-ORIG-GUID: H2s113BQ4Wyx5H-AFC_CtVhGCQdppT3x
X-Proofpoint-GUID: H2s113BQ4Wyx5H-AFC_CtVhGCQdppT3x
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



On 10/27/22 5:00 PM, Eduard Zingerman wrote:
> On Thu, 2022-10-27 at 15:44 -0700, Yonghong Song wrote:
>>
>> On 10/27/22 11:55 AM, Yonghong Song wrote:
>>>
>>>
>>> On 10/27/22 11:43 AM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 10/25/22 3:27 PM, Eduard Zingerman wrote:
>>>>> Use pahole --header_guards_db flag to enable encoding of header guard
>>>>> information in kernel BTF. The actual correspondence between header
>>>>> file and guard string is computed by the scripts/infer_header_guards.pl.
>>>>>
>>>>> The encoded header guard information could be used to restore the
>>>>> original guards in the vmlinux.h, e.g.:
>>>>>
>>>>>       include/uapi/linux/tcp.h:
>>>>>
>>>>>         #ifndef _UAPI_LINUX_TCP_H
>>>>>         #define _UAPI_LINUX_TCP_H
>>>>>         ...
>>>>>         union tcp_word_hdr {
>>>>>           struct tcphdr hdr;
>>>>>           __be32        words[5];
>>>>>         };
>>>>>         ...
>>>>>         #endif /* _UAPI_LINUX_TCP_H */
>>>>>
>>>>>       vmlinux.h:
>>>>>
>>>>>         ...
>>>>>         #ifndef _UAPI_LINUX_TCP_H
>>>>>
>>>>>         union tcp_word_hdr {
>>>>>           struct tcphdr hdr;
>>>>>           __be32 words[5];
>>>>>         };
>>>>>
>>>>>         #endif /* _UAPI_LINUX_TCP_H */
>>>>>         ...
>>>>>
>>>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>>>> ---
>>>>>    scripts/link-vmlinux.sh | 13 ++++++++++++-
>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>>>>> index 918470d768e9..f57f621eda1f 100755
>>>>> --- a/scripts/link-vmlinux.sh
>>>>> +++ b/scripts/link-vmlinux.sh
>>>>> @@ -110,6 +110,7 @@ vmlinux_link()
>>>>>    gen_btf()
>>>>>    {
>>>>>        local pahole_ver
>>>>> +    local extra_flags
>>>>>        if ! [ -x "$(command -v ${PAHOLE})" ]; then
>>>>>            echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
>>>>> @@ -122,10 +123,20 @@ gen_btf()
>>>>>            return 1
>>>>>        fi
>>>>> +    if [ "${pahole_ver}" -ge "124" ]; then
>>>>> +        scripts/infer_header_guards.pl \
>>>>
>>>> We should have full path like
>>>>       ${srctree}/scripts/infer_header_guards.pl
>>>> so it can work if build directory is different from source directory.
>>>
>>> handling arguments for infer_header_guards.pl should also take
>>> care of full file path.
>>>
>>> + /home/yhs/work/bpf-next/scripts/infer_header_guards.pl include/uapi
>>> include/generated/uapi arch/x86/include/uapi
>>> arch/x86/include/generated/uapi
>>> + return 1
>>
>> Also, please pay attention to bpf selftest result. I see quite a
>> few selftest failures with this patch set.
> 
> Hi Yonghong,
> 
> Could you please copy-paste some of the error reports? I just re-run
> the selftests locally and have test_maps, test_verifier, test_progs
> and test_progs-no_alu32 passing.

Sorry about the noise. It is my fault. My default build is out of
source tree with KBUILD_OUTPUT=<path>. Since the current patch set
won't work with it, so I build a in-tree one for vmlinux but forgot
to adjust selftest build which still has KBUILD_OUTPUT=<path> and
it caused some selftest failures. Consistently doing in-tree build
for vmlinux and selftest results in the same Success/Failure rate
with and without this patch set.

> 
> Thanks,
> Eduard
> 
>>
>>>>
>>>>> +            include/uapi \
>>>>> +            include/generated/uapi \
>>>>> +            arch/${SRCARCH}/include/uapi \
>>>>> +            arch/${SRCARCH}/include/generated/uapi \
>>>>> +            > .btf.uapi_header_guards || return 1;
>>>>> +        extra_flags="--header_guards_db .btf.uapi_header_guards"
>>>>> +    fi
>>>>> +
>>>>>        vmlinux_link ${1}
>>>>>        info "BTF" ${2}
>>>>> -    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>>>>> +    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS}
>>>>> ${extra_flags} ${1}
>>>>>        # Create ${2} which contains just .BTF section but no symbols. Add
>>>>>        # SHF_ALLOC because .BTF will be part of the vmlinux image.
>>>>> --strip-all
> 
