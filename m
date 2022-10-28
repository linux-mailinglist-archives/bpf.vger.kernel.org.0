Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D27610735
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 03:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiJ1BX4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 21:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1BXy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 21:23:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF96FA98CB
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 18:23:50 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMn41T018808;
        Thu, 27 Oct 2022 18:23:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=mZmQZZQ4YJHc0YYFRcMjdvNs/9ZbmPQJRWZpNl2vUKE=;
 b=etXadwdsulwwh7FQKf4bszgiVWwlDW8m1ZsgABK9r2a/YyKRPTBBblOZRaODMAapVBx7
 CTtMVejhBwb3S+ZWd9+XU0LbE7CGrGAAXJIBsWH9Rlv0UJo73aPfLpBOAiDIMzAIXKse
 74qor2KKxJwuLV+Hj5P6LM1gPbdgvBdekPJ37TWA7cqlamkVVW95bs4upWqiHVoKjRtt
 mmKrMssBuAZvNTO4M+2ZLpI5c/5nfaZtw4LII1BVuQQGbZ13jrPi0zDQtBdxaSydj/Qq
 BzbxOEkyQ8GWuwsqj2Hbm4XBaT2lHUCnHw9RDlCCGfNhe97XX/6+gJqxLin0r5Y3CVCq uA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kg0h1tuqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 18:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZz9g+9KtODhtrID04BpMngQD5vhOMZc/At93HydBubFkjEetGD1y7CQusz0yI3YPiggUnkGsgG3eJ1vE3EREq7z7K1G7NqMO48B059SrcBiTHwCUfdruUareMBOG4in7aEFjiLgP1Q6M7N043rQ5XFhB6U6vjUcrkgfXHVlUQQwjjGe8Aw3Jz9oKgoUgCfaYI+d2g8DGm9vZiTSTZ7jOC3w/i1whUM63qYaDyzriNPtOwaQp2rY7xsxJa6uHMqGNEl/Dw+lxFcvatou3/+hivXxgCo5YqVlNwUgSho/c/rDJLS19WDgDSVhMwQ17Zm1F9MmG1nZfnDOO21VxfsqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZmQZZQ4YJHc0YYFRcMjdvNs/9ZbmPQJRWZpNl2vUKE=;
 b=VCFzKp0KNB6Mx7YAO7d1eR7P/It4wqoPSNAhWndLoRT+gWLTmqRJS6lHOXM09IXb/MJ7imiMN39gcH9I2yzelZ3eI0vSqMwS+cVO6UM804pcTm0GSyE0/s+Sf+/Ai3lRm20TK9en1RDXe4s5yqG54WbBTADLjuTdtFsxryoL42YxfmKKb54Q8OAxl3hI/ATEmofIRLrPBY/oIsmMTIN42v7QdmyW2YyJAwI6JQG3NRpIZaBfU8V7LjlUsuuJueGvlNF6IBIlqrlC4TQXur0dPxGqyXMcyEn0+Z2/u8R1tRiIknFE8a75/rLm+kYmXpe/DsxVlFSJ1kfu1RGH7EGAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2891.namprd15.prod.outlook.com (2603:10b6:5:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 01:23:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 01:23:32 +0000
Message-ID: <6ea1ffec-5dad-cbb2-6a13-cad15a17edef@meta.com>
Date:   Thu, 27 Oct 2022 18:23:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC bpf-next 09/12] kbuild: Header guards for types from
 include/uapi/*.h in kernel BTF
Content-Language: en-US
To:     Mykola Lysenko <mykolal@meta.com>
Cc:     bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <20221025222802.2295103-10-eddyz87@gmail.com>
 <dacaeb37-c55a-a328-61f2-77324efbc822@meta.com>
 <6e57811b-229a-e4f8-ca7e-fe826cde4be4@meta.com>
 <7a3ebc5f-b07f-0336-abb1-627f7a73b2cb@meta.com>
 <237df1d8b2c0bf546ab81abb73ae0b78e2c0cbaa.camel@gmail.com>
 <97B01B2E-0F57-4FB0-BF8E-CB63DEAB9F57@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <97B01B2E-0F57-4FB0-BF8E-CB63DEAB9F57@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2891:EE_
X-MS-Office365-Filtering-Correlation-Id: 84996969-2247-4afc-2e46-08dab88306d2
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifWahhiNfdMgeKvAyddiKSHyfoKhOSPChHpE6DQOxq5JmdM9lLIDMGWtVAmR8Izhhy5DjEl6WdoVR9vkbiLhMRFrcc8rHLNqwu4Pa0/lX4Grm7BqeKtFmG4IaOjvsbAmH8HlCZCdnR2TXSLyKM7nFWOLsJF9s1L5c7aCUI4ZUBY1itWJ9+Jp++I+tw3esYxBk6Xx3il255fenjOFWhQ1ZD0R6DGkVUehXzTg2ABOjHqb9P7MA/NmbkQwI13mPZrFvglUQwvbIWwXzAsOMt2DX6I+oIKbtKDLHJJvjZ7EDiN/2HAmbXLd+Bn6+cSWap3M6+9rxciSfq0D5IH/j2ntOVGNRcI1yuHTCqDEKdT19ml5Vm4DUqVqmowsboVJHEPxKrLJKXYLlykhtxS36lmnn+aMuH0aejTC/A9U18YX6giqnGFu8/UR68b1zAa8TtQC9CtymXW8r2t58VbC+8O8ZkYLnzlJ4WpZG9rvtcnb2p9vvf/rqzah8KE24WEmuteWW7vTnXai7lGx36xZYrrANotrYuAEfebVGH0BfkBqKJhwvNnOzBUTxEeyXE3+5BaO0jiLI9TnbXzcbuThv9QYrnSsSj2JvPxOgdkaCnocyQ7Uu5zWtebKzZaSSDQvwAWhycVAdJ2BCRvD3rXjnqEZbIHXOCtxyFjyj5BxzIFzWRvpEDRz+7GH24ifaJOVjawN8f6ueRO2/AGLSytzIf/tA8OUDq4MMugwWWEbKs0qtBF78Lby2NWbbPJlGl2XIu0zBIPCX60ewG5jcVoZhrdTMYQ2oQUDbljAX6ZGmop5HAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(5660300002)(2906002)(66946007)(4326008)(66476007)(66556008)(316002)(31686004)(8676002)(37006003)(6636002)(54906003)(41300700001)(6862004)(8936002)(6506007)(38100700002)(6512007)(2616005)(186003)(6486002)(6666004)(53546011)(478600001)(4001150100001)(86362001)(31696002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkNITkluQjR5ejFxRUFLdXVIZEswTFFZWW1rZmlsTTlSaEorUExuRmpzamFN?=
 =?utf-8?B?OGlJd0tYTFgyZUZvdXd1NEZpWTBhaUtmV0w5b2syd3FSR0JkRERsVlY3YVBq?=
 =?utf-8?B?MUM5NndkdXY4YzhLK2pUZjhBaXJ4aHYyLzU0ZlQwUHdpeks2UGV4bXN0cWgv?=
 =?utf-8?B?M0JxV2c1MWp6U1lXQ1FNNGRmV2xYYmdzQUlXbWZCaVJ2VWdkTjBSODRJczVz?=
 =?utf-8?B?REIwSmVSQ0tGRFRVcHVtNVNhL2dGanViMm9YY2RhZU5RQTkzMGRmK0ZtZTJL?=
 =?utf-8?B?NTVKejZ2MGZmSHAwQWwzL2J3R0JkaGs0Q0dNd2FONEV5NjBGMjl0SEtvVTkr?=
 =?utf-8?B?Q2lCM0tTMzdJb1FabVl3aEtKcmtTeGs4a2dPU1l6RENmOWNhS1dGM0Rua3FL?=
 =?utf-8?B?MGVHZG5rdXluTC82elI5OWZFVWJiMXZ5amo2MzVYVDRSZlIwb3ZmdithMDd4?=
 =?utf-8?B?d0xxOTBGdzF2YVNiVGNxM1M0eUpWcC9GZWNEby95M0tYRHdpWFp5VlNCY09z?=
 =?utf-8?B?TlNOQTRMTkEvYTFLOGRPK0dVZUo4Y24yMDFZak5zZ0NYdmk4QU9LRi9FR3A0?=
 =?utf-8?B?MDFFd25LVUJOQnlNVGN2dDM2WEMyTmprTlRxS0xlcmJRMUU4ekNCcUE1TnN0?=
 =?utf-8?B?c3VXQ3IyOG51RU1yeS90ZlBuRTRwcjFkU1ZqcXUxRVJlaU5vS3hSRGdkQmtE?=
 =?utf-8?B?ZjZBd01DQVlwbTg4Z3hTa0QrLzBxamlJcXhxNmJ1VmEyRURxMVFxNjBjelFN?=
 =?utf-8?B?Y2cvMmVMSUlhUEdrT3NpQnpBdFAva3diOEJtb0tDOW5mZHBQTFlHb1poMHM0?=
 =?utf-8?B?MEtrWnBpbWlxelNwanRTY1NRaU9KeERwbDMxTUJCRlc4RkdJZXlQR1dOVzNP?=
 =?utf-8?B?UmdNSFRNMXYvUnpmTzVSenp3Z200bXN4UzJ0WEwvMkVzYlRSWG4vTjRNSjBC?=
 =?utf-8?B?UW9pRzhHMXgyMS8ya3dDVDgwdHN5N09GZmk1a2FaaE9lRkY5YXd1RldTRjZk?=
 =?utf-8?B?YVpBR0hUWVUwWGNzbUZtZkd5dTNLakF4ZEtmcjV5UWVIWTdmUFRSZHNzdDMz?=
 =?utf-8?B?VUwvNzNLKzdvZWRLdGN5NWFqaWFUTXJJV2x5R0l4SkNva1FGSkZtUVg2UU5k?=
 =?utf-8?B?OHZLYThqWUZUME8zcThyNi8rdU0yd3IyOTRiRlk4eXh4cVAyYThpdnNTaFVC?=
 =?utf-8?B?cXR4dnhVWnZiWHpwaVdsaHhJRnlxcCtkUGhSRHR2WGRTbGlYeUpqTXFCbVBr?=
 =?utf-8?B?SUEzazZwOFRTWnRPZGNSQzAyWXBMNW1oVFFUcEt4cmszNy94WGYrcFlvNWh4?=
 =?utf-8?B?K2VmZU54RHByMUI0eHoxRDMxNmlydUoxNFRvakUvR2dsenlKSEpQOE02TFNs?=
 =?utf-8?B?Y3Q0MFB1RjltRGFYUHdFbFJuWHQvbFJ0dEIvaGZNUUtBM21MbWY5a2szUjJR?=
 =?utf-8?B?RUR4OG4wRWZzcTlxNmtybkJjdkhOZEwwSFJrdEJubHU0UHpUTjRaK29VSFRB?=
 =?utf-8?B?MkN3Q2hYQ2NaRUFIN3RsQUgwTXpBdkNHMURyZk5QWENqamhmSi9NWEZNQURt?=
 =?utf-8?B?TlFKUW1Ta1VNYUVPRGcxMlA5cmRCempJNk5KUmJEVDlFdmQyWDdYd2taZGt5?=
 =?utf-8?B?ZnF4WjVtUWxUdjZ4cndGdHlWRitOaWFLSXJhYnhaVTExQmlxM0liM3RwYklh?=
 =?utf-8?B?cGRSb3VyLzNla3UyekFJWUdJYnRTZUd0Y01VOUNuYWw5WG9NaWxqcTRid2Ur?=
 =?utf-8?B?dkozVitpY2xJZnhhQWQ2OXVpVG1iU1FIdE51RWtrMXZ0cW1GKzNBRklkRTdG?=
 =?utf-8?B?MEo0bmU3RDdkUEtoTkZFOEJDWWQzNWlLMExVZGVKZVJKNUw3WE9RNlhUMWMx?=
 =?utf-8?B?bkwyV25kWDErWDRGR3hhTWtsaXIyTUR6U1FNTUpCbnUrTFNVcnpibWE5NXRF?=
 =?utf-8?B?ZldFL21ydFJjd3FKU3cwbVMyQUg4bU91U1lzbnRHeTQ4VGRTY3EwYUFtZE5t?=
 =?utf-8?B?bmExamloYkZDcnFNWjZDenNHZWxYYzFlc0YxNzdFZlc3TkIyTDF5TDFOdjlP?=
 =?utf-8?B?ZXpwK3dFZFpldXV1dWlxSDNzQ1crN1dZMklsY0c2ZnhTV2tCZEU4cnVCZUFP?=
 =?utf-8?B?RGxBWFpoakZnOFVXWFFGclM0N2N3RnNiYk85YVp3d0Q3VUp4VjhLdzYwVG5T?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84996969-2247-4afc-2e46-08dab88306d2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 01:23:32.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCLK+PClOZ4VWULR2QddzTGbTUJN8lU6Fb56EIUFLjykl25GCY4aY41a3kAR9W/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2891
X-Proofpoint-GUID: pCGqgPjRuczIuxUWz1iPXlIihRdBEDCn
X-Proofpoint-ORIG-GUID: pCGqgPjRuczIuxUWz1iPXlIihRdBEDCn
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



On 10/27/22 5:14 PM, Mykola Lysenko wrote:
> Yonghong,
> 
> build will be failing without merged pahole changes.

Yes, I do have pahole changes. My failure is due to
building in-tree vmlinux (KBUILD_OUTPUT= ) since
current patch set doesn't support out-of-tree build,
and out-of-tree selftest (KBUILD_OUTPUT=<path>).
Using the same in-tree build fixed the problem.

> 
>> On Oct 27, 2022, at 5:00 PM, Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Thu, 2022-10-27 at 15:44 -0700, Yonghong Song wrote:
>>>
>>> On 10/27/22 11:55 AM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 10/27/22 11:43 AM, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 10/25/22 3:27 PM, Eduard Zingerman wrote:
>>>>>> Use pahole --header_guards_db flag to enable encoding of header guard
>>>>>> information in kernel BTF. The actual correspondence between header
>>>>>> file and guard string is computed by the scripts/infer_header_guards.pl.
>>>>>>
>>>>>> The encoded header guard information could be used to restore the
>>>>>> original guards in the vmlinux.h, e.g.:
>>>>>>
>>>>>>       include/uapi/linux/tcp.h:
>>>>>>
>>>>>>         #ifndef _UAPI_LINUX_TCP_H
>>>>>>         #define _UAPI_LINUX_TCP_H
>>>>>>         ...
>>>>>>         union tcp_word_hdr {
>>>>>>           struct tcphdr hdr;
>>>>>>           __be32        words[5];
>>>>>>         };
>>>>>>         ...
>>>>>>         #endif /* _UAPI_LINUX_TCP_H */
>>>>>>
>>>>>>       vmlinux.h:
>>>>>>
>>>>>>         ...
>>>>>>         #ifndef _UAPI_LINUX_TCP_H
>>>>>>
>>>>>>         union tcp_word_hdr {
>>>>>>           struct tcphdr hdr;
>>>>>>           __be32 words[5];
>>>>>>         };
>>>>>>
>>>>>>         #endif /* _UAPI_LINUX_TCP_H */
>>>>>>         ...
>>>>>>
>>>>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>>>>> ---
>>>>>>    scripts/link-vmlinux.sh | 13 ++++++++++++-
>>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>>>>>> index 918470d768e9..f57f621eda1f 100755
>>>>>> --- a/scripts/link-vmlinux.sh
>>>>>> +++ b/scripts/link-vmlinux.sh
>>>>>> @@ -110,6 +110,7 @@ vmlinux_link()
>>>>>>    gen_btf()
>>>>>>    {
>>>>>>        local pahole_ver
>>>>>> +    local extra_flags
>>>>>>        if ! [ -x "$(command -v ${PAHOLE})" ]; then
>>>>>>            echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
>>>>>> @@ -122,10 +123,20 @@ gen_btf()
>>>>>>            return 1
>>>>>>        fi
>>>>>> +    if [ "${pahole_ver}" -ge "124" ]; then
>>>>>> +        scripts/infer_header_guards.pl \
>>>>>
>>>>> We should have full path like
>>>>>       ${srctree}/scripts/infer_header_guards.pl
>>>>> so it can work if build directory is different from source directory.
>>>>
>>>> handling arguments for infer_header_guards.pl should also take
>>>> care of full file path.
>>>>
>>>> + /home/yhs/work/bpf-next/scripts/infer_header_guards.pl include/uapi
>>>> include/generated/uapi arch/x86/include/uapi
>>>> arch/x86/include/generated/uapi
>>>> + return 1
>>>
>>> Also, please pay attention to bpf selftest result. I see quite a
>>> few selftest failures with this patch set.
>>
>> Hi Yonghong,
>>
>> Could you please copy-paste some of the error reports? I just re-run
>> the selftests locally and have test_maps, test_verifier, test_progs
>> and test_progs-no_alu32 passing.
>>
>> Thanks,
>> Eduard
>>
>>>
>>>>>
>>>>>> +            include/uapi \
>>>>>> +            include/generated/uapi \
>>>>>> +            arch/${SRCARCH}/include/uapi \
>>>>>> +            arch/${SRCARCH}/include/generated/uapi \
>>>>>> +            > .btf.uapi_header_guards || return 1;
>>>>>> +        extra_flags="--header_guards_db .btf.uapi_header_guards"
>>>>>> +    fi
>>>>>> +
>>>>>>        vmlinux_link ${1}
>>>>>>        info "BTF" ${2}
>>>>>> -    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>>>>>> +    LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS}
>>>>>> ${extra_flags} ${1}
>>>>>>        # Create ${2} which contains just .BTF section but no symbols. Add
>>>>>>        # SHF_ALLOC because .BTF will be part of the vmlinux image.
>>>>>> --strip-all
> 
