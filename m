Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F66B1A32
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 04:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCIDyg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 22:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCIDyf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 22:54:35 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0263D23AD
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 19:54:34 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3292jVT7005633;
        Wed, 8 Mar 2023 19:54:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=keNGa6xnoSCfYAjZV4dTII/iYTAOCqiDql++PTAJEfs=;
 b=nVWkS8bPW+44P2/+dwhN9adBL10tWYDWwpG54CJL2uaIAc+rrTyrkmikWf2ieopTuYBR
 QqrmHru/MNRH2UlvtCqYWVP01u5JKnboyIWix+4/hSD3IoEaQPT/YxEBIU9fQcCyGtF7
 h9KfkuMAVIuqvEMD+aLqckoog96Y8y4lCwXJfKtQ2U+UdKb44+T7LjC7W6FKwEWOKPNC
 D4HprCVzolxkwsL7gCuOv5MTD8VXC95WF1203LTgtIHf1eAlcRRFEFLdXUL2abJlEp+W
 Xo5hv3OvsZjM5ook0Pc9EKfXjSJ0x/6uNtbOJPJ/Fjkwn6bL5+4QwhFVtGutr6suHvIX ig== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p746p1agd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 19:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLu7ya31JXwfsjTMdoDoA76U3/ieuYI2D6QKwPWjxx4805oLjcCC6WgeMw2iV8lMplUlOfr8iN3AHuNYLi0RLtDs5edVba3y7sCAd45l/b71HLjQghSCYOu5eQIeZamg38TNCmfzzu1zRwxzz1NGiaFOxe8qrFTqFF13gjoN4LCsP5z0hRI2tniiLfsA3SmPgp7h/3s762+xUSPAqNwAa5g0bE8qjL2oVOSJo+t5BVM5+zghCnJlFe6fgZGFEwpDkYJLC6/GtWbz3mReoigzXbrfzJrMi63FVq5eTl4AP77lcYCs0tT54XbxMItGvpPI4eLEscq+c1TYU2vdn0nykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keNGa6xnoSCfYAjZV4dTII/iYTAOCqiDql++PTAJEfs=;
 b=bwm4ProUN/41kWwkDI2VxHWEF0IM9eI/fxLKF62Lrbz4wKbaaEEXSvzzH8iFH6jBDu+WKoZmACDZmYjzPc/g96tDzmMFJMbBVVxABvQWN29XQWGaAvZqiJMpgxBLY4tLDSu/nnJc2evwcEfkIv7IHhXTZbZC3crHeHRsCql2XqtkMXHWoqcSYXdXlL4vFSv8c9lP6PFBuH5Q5TedoapSqyUcSjXAcaQc+HNamRbbiz0cn9YG5wVP00YaiPYUZmnC9gNvehGQEZKamlDBjEfvkf39etLtKIWMZurHBZRcfCgIdKur61dRFg6/pe3u/FwhGU+9ZCqq2vYCvCKXPRHUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by SA3PR15MB5656.namprd15.prod.outlook.com (2603:10b6:806:311::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 03:54:31 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::d2e4:5822:2021:8832]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::d2e4:5822:2021:8832%8]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 03:54:31 +0000
Message-ID: <fc8de596-aa8c-a92b-a288-d2bba2e08ff7@meta.com>
Date:   Wed, 8 Mar 2023 22:54:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [Question] How can I get floating point registers on arm64
Content-Language: en-US
To:     Grant Seltzer Richman <grantseltzer@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CAO658oXX+_7FnAsv02x27FQRbm_Dw7d=tOmQ_Gfe=fB5Hv+C+g@mail.gmail.com>
 <CAEf4BzZDv8hUD=_KYXNAO+EQMqHjqgEWurOcNF_huwX+CvmHXA@mail.gmail.com>
 <CAO658oVAMKPZT0cbAUmB82nXrj1StyawEJFSLPbWi8ZPtrVY+Q@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAO658oVAMKPZT0cbAUmB82nXrj1StyawEJFSLPbWi8ZPtrVY+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL1PR13CA0282.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::17) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|SA3PR15MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8a7879-96a8-4369-42f0-08db2051fd03
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq2ICUunz4yE+l6qNyJMu5+91xx+wOBgiZU2sOxde2UWr0aZfWiOQyf6Fb3ZlDUIKwo7KdUy6Nz1JAznfehidgT+kNjexATGG9md1kP6B7FQZRWDdX0/Bm9INYW33B19zayO+rDG4akhHx/KcF2ooRiHj0w+wDI1Tjl9ED69RKv7DFNo7y1PGB2BVwhlbDJSrMmrM+qbNfAGGWHS2sFZVcXOJnF1D1gvpoCYK4Wkm+XSTB2JVlcpEbnftCK2w2zGVKKcTOg2RSIjwEWg276QZ4v7vwUY7fpcuQarQy6iZejmG6g6IS2oiAVkLAiy156hN/oqpx9aK6ZlncVum0n7BFAnpti2lXwpilu7F6CzhVsBqKTMwC1bTJL0OQux8XN3MdBALELtjgpt7Nwxa3jY6cQ3Zosy1GTJ8KRehrXBjxehNfgBizxcM8OeTEqNy68N26eNS0ePWvMOg3mzrbglznuBkItJONF2VRJvMW6u4/nCmcLFB1q66c0YdgMhy7hTKBvMb6en+LaXOmGjp9YoUoZeh04CLdugVTdYi9vuCCNp/XaTRem52BwIVsGTJgbOgIInHtFB/6ACgjZlEE/M/OYeP00ZamExRC/WIs5kiMzolyWpgnVM7sCGz9SnQnhR4uCDE3u6owTzoaTt1uDBbsz91ODTanbnxxS4EPKq/NO08pJ329V5mI36VZ7yGkvOIZCIy1tkov29L8PnziMXVDsdf5o6GkxT2YLLDsNkNBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(8936002)(36756003)(5660300002)(53546011)(6512007)(6506007)(38100700002)(83380400001)(186003)(2616005)(86362001)(316002)(110136005)(31696002)(41300700001)(66556008)(66946007)(4326008)(66476007)(966005)(6486002)(478600001)(8676002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk04eDZKYVJLaU0wbGxRcGc5alhOUVFuZWNIWDBtVmZhQTRIT1NMZ2RNNlNE?=
 =?utf-8?B?a1NtUW81Y3hOREVqZTlxQkZDVzY0dGo3ZDFKMDRqdjU0SW9zc0xPWDhzbjVS?=
 =?utf-8?B?VktERlhQS3duM1RDZHljVnUxL1dmMS9RZ3BqRjlSTThNUzdFN0gyQk93Q2ZP?=
 =?utf-8?B?WFJxS3oyL2JXbXFPd1M3SGdNR1g2eDhrKzdSWVZIczdESmdMZ3RuRG5FaXFH?=
 =?utf-8?B?WUdscFllRGt0RkYwTjk0THhzRDhLSDloNS8wUWkrTUhvdVArMTNROFRuZXVj?=
 =?utf-8?B?eWVyeDA1V1hjMTZMT2RDcjVsd0IzcUZ1TjJ5dEVvMEo0WFRSYlBlUGU0RUU2?=
 =?utf-8?B?ck90SFBuMFN2OE5pOVdYamNMMkJzQWpvUHBITHJXWlp4RmUrK1hFa0o3OGky?=
 =?utf-8?B?d1ZhSVh5QisvclA3cTdkT29tU0RFM2hDSzNybDlrdSt2MlFyUCs2ZTg3Mlky?=
 =?utf-8?B?NmVwRk1aOWQyTWU3VDk4UVo1OFJ2RWtPVkZZTjNOaWNkKzhUd0tjSmR0ZXBL?=
 =?utf-8?B?QVF1WnhXMUh2SUtubkNUbW5jeFVWbFdhTGszMkZ5TzVocWtNRGFEazR3ZWJB?=
 =?utf-8?B?a0tmNnhZeFJldkVuNjhCM0ZHT3NMVjRkMVQ5VTM2OHVQSXNrREUzY1kyOWRm?=
 =?utf-8?B?WDlkQ3ErT3I3SW5KRHFucDlTR3hWTGwrWlp2Ry9MYVc5cjlONzhUczIvKzRj?=
 =?utf-8?B?M3RBZEVkQ2h1VER3REpneWFhbVVscXh5YzEvdDVjKzc4eE9zMFFoT2UxZlZy?=
 =?utf-8?B?cWtzTVNhWk53Y29lak1Hb1U1WS9OaUloTE05SkdxMkQvN0F6dytSRjhpdmhx?=
 =?utf-8?B?ZVQzRU0yY2gwbG51UHBjOGNCYTdzMGlQVmZUYWR0dHlzbE5INnV1L2hVMDFP?=
 =?utf-8?B?Zmt5WUM2dzJLR2dZdndTMEh4ejFaTElOeWZ5NE16K29GeDFIS0xWa0dQSEJx?=
 =?utf-8?B?SG9WZTB2ZGF2RHlycUxWSi95VGYwOHo5UDdpY1UyZytyVHdmOXlubUZ1M1J4?=
 =?utf-8?B?aEFteXU5cXdrQlUxajNuV2ZPbCtCcnFrVnYzdWJCR24zWHVrei9CZlA1V1hO?=
 =?utf-8?B?VmcwMXlCUGk0Z28xcWNEOXBhbVVSSHNQU1h5RTFvTzBlV0VKRW40TUs4aXVV?=
 =?utf-8?B?TWpGM2N3bHdhSHB6RVFuUkxXRWlHcEdaTWgrb0VoZk5NcFBlME4wbjBFeTlj?=
 =?utf-8?B?TVJTZnA1VFlzeUtDZXIxWkJHUmpCb2dqYkcwWE0yTVVBSlZRQWVVdy91bW4z?=
 =?utf-8?B?WlNPUlZaTUhqbW9sQzdXdXJYdzVIdWxWOHdoaGtENzNPNzA2Ulg3NndWN1lQ?=
 =?utf-8?B?VkZzd08wOHR3UHNrYU8raklRQzZpL0FDMTgrOEJnazlaVS8zanVPMTBDc3lO?=
 =?utf-8?B?c1h5VEdHQ1Jhb2ZZeTRpWGlRZnVRNUtmVlp0bzF5b1VIdkRoNWV5bkNyM3Nt?=
 =?utf-8?B?SFRubWo5QnFvaVBPY3V2cUt3SnFoOEJSb1BWdjhJL3E4QnF6NVNSOU15ZmlV?=
 =?utf-8?B?elJWQWU0enVxSVUrY2JFYWRmcVR4TUNxWWt1NjFrVG1udSszQXlueVA3cnBB?=
 =?utf-8?B?YlV6VUxtdHRJVzJwR1ZsV0EzL0FLTkxXZHJBR0JjYkE5QUV0YVVXSmluL25y?=
 =?utf-8?B?bldqTXlCMVB5NmV5dUtjaHVUNjhrNVpxb044Q3UyQmVzODREOW9qV0huRWND?=
 =?utf-8?B?NkFWRFRha2hScFBzcG5IUkVzakp6TjA5bnZ2Z0ZqUG1PTWkxUzdKTWF2VUVy?=
 =?utf-8?B?alRBQ1IyNkllUGtTejU5WE4wdFpjaUwwb3ZPanZheFZzUFVMTmNXTnNEeG5Q?=
 =?utf-8?B?MSttZk50N3hRWjh2NnlhQXdsWWVZbk1qMmtZMWJVeUUxNVZkNDhzT0J5SlFE?=
 =?utf-8?B?ZTFpRjBQZ3N0WXdnNWI4ci9OaDl1YXU5c1dFWGZlSWxjUjBiTTAvbnJiTm5z?=
 =?utf-8?B?WjFPd3ZNaWhtVXAzanp5b3YvNEtpK3FRSjAwVEpnK0UwNHo2MXk3clhMSEMy?=
 =?utf-8?B?bjRCalRURHcreC9kZWJ4WDlqajY0VlFwY05sY3ZHMzVmVTNHM1VXeTZsbnlu?=
 =?utf-8?B?QkRFWVVTN21ic1M0VXBFUVZEVU53d1d3aTAxN2F0S2IxN2ZNeldHVkFDM1Ax?=
 =?utf-8?B?S0d5M3BnWTJZNDlDRHBRalM2dUswNGRkd0JoOEtqbDA3Qi9UcDd4MGowYXdk?=
 =?utf-8?Q?XF7lBAI3/ZtgaR8O0JvNmd8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8a7879-96a8-4369-42f0-08db2051fd03
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 03:54:31.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2MSIjYZE3INFZGHqCt0DF5/gexYXoWKJN0XZK7rNV1ZUYaWopXaIoW2pyuUlLhCubXyQjsmvkEnol2BcIZHuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5656
X-Proofpoint-ORIG-GUID: 7maJ6CWcIe4nnY8JXvtMiNEEpveL9wTe
X-Proofpoint-GUID: 7maJ6CWcIe4nnY8JXvtMiNEEpveL9wTe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/8/23 9:20 AM, Grant Seltzer Richman wrote:
> On Tue, Mar 7, 2023 at 7:28 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Mar 2, 2023 at 11:06 AM Grant Seltzer Richman
>> <grantseltzer@gmail.com> wrote:
>>>
>>> Hi everyone,
>>>
>>> I'm writing a uprobe program that I'm attaching to a function in a go
>>> program on arm64. The function takes a float and as such loads the
>>> parameters via 64-bit floating point registers i.e. `D0`.
>>>
>>> However, the struct pt_regs context that uprobe programs have access
>>> to only has a single set of 31 64-bit registers. These appear to be
>>> the regular general purpose integer registers. My question is - how do
>>> I access the second set of registers? If this question doesn't make
>>> sense, am I misunderstanding how arm64 works?
>>>
>>
>> cc'ing Dave, as he was looking at this problem in the past (in the
>> context of accessing xmm registers, but similar problem).
>>
>> The conclusion was that we'd need to add a new helper (kfunc nowadays)
>> that would do it for BPF program. Few things to consider:
>>
>>   - designing generic enough interface to allow reading various
>> families of registers (FPU, XMM, etc) in some generic way
>>   - consider whether do platform-specific or platform-agnostic
>> interface (both possible)
>>   - and most annoyingly, we'd need to handle kernel potentially
>> modifying FPU state without (yet) restoring it. Dave investigated
>> this, and in some recent kernels it seems like kernel code doesn't
>> necessarily restore FPU state right after it's done with it, and
>> rather sets some special flag to restore FPU state as kernel exits to
>> user-space.
> 
> Thanks for this info Andrii! I think your first couple points are
> manageable but I'm not familiar with FPU context switching. Will read
> up on it, and Dave if you're willing to give some guidance I'd happily
> put in the work to get this helper introduced!
> 

Hi Grant,

I attempted to tackle this in a patchset a while back [0]. Had to abandon it to
focus on other things, please feel free to use it as a starting point.

Happy to elaborate on Andrii's 3rd point above, there's definitely some nuance
there that the series may not explain well. But need a day or so to page it back
in :). Will update this thread with details.

  [0]: https://lore.kernel.org/bpf/20220512074321.2090073-1-davemarchevsky@fb.com/

>>
>> Hopefully Dave can correct me and fill in details.
>>
>>
>>> Thanks so much,
>>> Grant
