Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655C7560F3B
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 04:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiF3Cda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 22:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF3Cd1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 22:33:27 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F615A22;
        Wed, 29 Jun 2022 19:33:24 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U0LboZ021222;
        Wed, 29 Jun 2022 19:33:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NLy6PYKGFCYroWjYQIl0t5kWCd+6WZb89bbc9FhvQIw=;
 b=cu9ABxqdq7grR+e1hzLA/NzSZ6xdoNzkFgVgGKrIaTofMfpbTV1ABT2iJhtWCmtKESkq
 NbdgQ66mlH4X0e3UC9P0EMo78O4+wPiSsRT2DXGSpoyU76VuXjCrqXE7CLIFqtquU+kO
 IGuD3sQsm5bHAgCe9FM6qf5BMz49/agOFt8= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0dgqqka3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 19:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF2lLA8N0QW6R7tPGdt7DeRkh6ZQtX96ExgfIo5s4fLP+4nqleWetZYHiJHTKmAY61MZqh7uLvVYvMyndHmqbvNOJAtqAGIcaho1z5LXqkTcRNW/RuVlQlIyQ08spSXwxwJ73zvmgiLE6ihV7/OS3RY3gaJKk+8PB/1I7pZwVJe+o5CWjgLUHf3S5cjRQiEHIDl+BoDncgeyhtCihIyrW197tIrF+it4KayVRAAxwwTgVRAVDHHahCXVJVURoUessOaxS7KjCpiHRjGhIyH1Y89WNQ9r8CUeHqtLSSp3sjJ3kHb6mOYQd+edeEqVxBu3+hEWSs043052H/G681CSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLy6PYKGFCYroWjYQIl0t5kWCd+6WZb89bbc9FhvQIw=;
 b=Hq/HqR/kuLKpm9eUuTBzafFUYHkm2ogTSdNTsTxXRhHw08rOhYplB/Lc9vVetspFZBhufZjS1CDLt6gSkVjuQ41iJRiDdHmZHXjvP2QgiBu/gljlCyTJhn1ZppFlmHw8GdOXtyIZtf5imx+PbCcsoilmA4X1tgZb+pu4nqPCxRCci02UddDQmFlyHMmoEpp64ft037Nx37KAHtDLHt1iThAFvoJLS9yC/TEaIX3oDCYXbFYm93ADzxkDlyfIvA1XLeTtOc6lBG+eZkxLfU7apsN4hzlwJ5TqinBdx0rQopLq1fyNdztOrtv5HFr9NVyqXOnD6B4v9lsGTSKDC1rSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1105.namprd15.prod.outlook.com (2603:10b6:404:ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 02:33:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 02:33:06 +0000
Message-ID: <5772af33-b78b-a8cc-500d-e602485ee9c9@fb.com>
Date:   Wed, 29 Jun 2022 19:33:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH dwarves v3 0/2] btf: support BTF_KIND_ENUM64
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220629071213.3178592-1-yhs@fb.com>
 <YrzH1ABPYmKSEogS@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YrzH1ABPYmKSEogS@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3979d762-50f6-4b45-1072-08da5a40dd35
X-MS-TrafficTypeDiagnostic: BN6PR15MB1105:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMzp9MHYeAdq3xJMMxTvtoW/fS5NWQeuxcCl6gFEEF/fBMNzt3bLGeo/eNFc2jWO4UIXJVbtXladV0n3fkLxOA99T0uRJZwipNbBSI0iU3y+bKeEdkTRnYJJgOuPCCLYFP+stNWBzhPYm1mRNZTXkpGUMXy9SV5q1e4eVii2/a7O1ur52Ye0VKmIJxvVraZYdXyzCkx6TEbEbUMs4ewASx0mPRtztKnuIMR4S1KhNJqiEJk/1fD30RDCPvzrAjw5Ca0Yhq1/DhsCyc+MjusyCtvT6N/10+EBa/Zd4JNmNnS45teX6gZoiowKMKvhPSbYxHOSMfHgG/Rgij9pHXjwJv4HmjEm+hRq9+H2VuD478kXzvvGKlXBIvR2V8ogybGtDZEg16eRuU2G8qMZ/8mXY70B+zYXYBrJpn15RnG8JooVKQcFdtbhq+qFs2HdSVdlmy9QvYA215Va6W1z1vhWkF9MKMiuV4spd9nSJGrznhcX9lcU/qix12aOND708n4InRbKPd6aHqqsNplrPdW9Qt3q5MJI0k3rdrG4+g43BdQ0Iop7ga1dN/g2qvFLUWSWcEky9BJldshKtvo+brjnx3Mq22nXz1EvlfHdetlsThqnDh5MZ0ipGkAudG5x07npRxbamtKWhCNgRhHpI+9SfObr4ThcPydsysmoGVFQrxmGtjnA5t6v8tseBnGi8HuPYpu7kPBDQqdBVt/+MdRZJqW+L+9Byamxe9RTy5SUQ270+s/XgrlYBPPjno3gqiC6+rp7hW4xRegf805gTcDFXwQ1Q2/pBkRNWisBwCuDptO3v+cIwNU7uRGSsRq3v/CftUxjmBRce3AXw4JBXebnXr4Q25Y+1dLCFnsfYsmxNGTnoaDk4ddiyc/RWzsUwBk4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(66946007)(66556008)(66476007)(4326008)(8676002)(2616005)(5660300002)(966005)(6486002)(31696002)(86362001)(8936002)(478600001)(83380400001)(186003)(2906002)(41300700001)(6506007)(53546011)(316002)(38100700002)(6512007)(31686004)(6916009)(54906003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWYxd3dKN0s2Q21RbTFqZFFzRG9OREJ0N1Z0VjM0TmlRclhHemJ2QkN1cEha?=
 =?utf-8?B?RWprT25HWEZ3UU8vUWF6N0VheVpncWM4ZUxlc0o0RC81OVZsRXp5a1hDUU1P?=
 =?utf-8?B?c0FjZlJPL0ExT0E4UkxSY3hmZjRib0Q0L0hTTWdlMm1FcnBMTHZKY21HNTc3?=
 =?utf-8?B?M3RKVmhXbzdWenJVOGJMZlhaM2RMd1k0dlp2MGZRTjc2QlJmR1ZYLy9vTXpo?=
 =?utf-8?B?UWdtNkJscUFuQkxucWRUNjQzcmh0S1g1NVdCdGNmVEpSRkZUTlYxQkFQSk83?=
 =?utf-8?B?eG1xaGxrSDgvZTFCTTl3U1NaYnNUaCsxalFVaFdNeGwxNTNtU2VlVWRFcUQ2?=
 =?utf-8?B?ZmZ1VmJFL080NnVsaFhSWDFQL2pvWFdhRllJTU8vaUFOVkZOSW1QZVlmWDZD?=
 =?utf-8?B?M2xCb1UzWWY3bnBUWVJzQWFDdkRRVmNkdlBLNkIxNnlmSmE0bVh6eGxEa0c4?=
 =?utf-8?B?YzgwZTJHZ1FUMW56clZzVG9TaFlDdzJHak9FOUhwUE5kdXJhOEFVZExDYjNk?=
 =?utf-8?B?cEMyOFpTT0V0NFdEY0VhUGJ3SCtIbGgzV3h1czRaWU1PeDVSVEFzeDZ5ZCtx?=
 =?utf-8?B?NWRWdFRuY1dyN3BkSDloT1YyemV5TlBjNERuZXZUanhuTGc3RW9KUjBQVU9E?=
 =?utf-8?B?K2t2dGJIdktLaFNLQzJLUGdhaUh6bzlhOWRuQ0tid0VrVWUxR2hkMTE3cG1S?=
 =?utf-8?B?Vm1kbFBCYTlnckF1S0hMcUJmM2k3Rk5vSXJZRnZ6SnBKQUhJYVBkbTdRbTVH?=
 =?utf-8?B?VHNVUmZvSUR3YXFITkJyd3diZkc4K1JwRDkrTE9STXFOdnNNMkJUS0RjUnNT?=
 =?utf-8?B?TmxWbDJod0F2Qm5wRi9RcWNlejR3eW5Yc0VqNWNzaEFjaGtYUWxiZ0FTOHlo?=
 =?utf-8?B?cENaZW5sTEZkQWpiWmliM21jSHA1enJMbmJlWHl1QWVCVUo2MjhDd3RYSXBP?=
 =?utf-8?B?WElYa0UwOCtKVG5LZlFORTY2ZWZ0aWpxb29lK3lWaUc5WDVXTzFlVm5CMW1i?=
 =?utf-8?B?R0wrZDJTcEY4c1luRWUzV3I2QkpwQXpRRkNGbWt0NytaQUJGemZCVW81TVZ4?=
 =?utf-8?B?eHErdE40T2JXS2d1akVkckhmY3JRWE92MDB5KzE1bExRZ3RjQjVuTC85QXpm?=
 =?utf-8?B?UHJMbklrN2Q4WmVONER2Z0VZYXBqZTYwK3JxUWc4citxM016eUg3YTBKN1RO?=
 =?utf-8?B?clFQVEhUZmNOdlMvWUVKZ2VzSE5GWEU3T1BxbWpwYlNoeDNXcC9GRnJQb2dX?=
 =?utf-8?B?VVBQNkdSeUEzZzh3REVvMTZ6NktVeCt5c0xmUUpWVncwTWEvRVJxbEM0aUk2?=
 =?utf-8?B?cVgxbzlaWVFzc2ErTlJNVEtadHF2dEMvTDAvTWNtVGFKTXJTTUp4NGFTQXpD?=
 =?utf-8?B?cVc1d2tweXZjanRZaFAraUtPNldUd2UxM0xUSnZEQ2lLQ1lJWm5EVzJIcVJ5?=
 =?utf-8?B?UnAwcnc5aTdROHlmbU5CeXhVRWFOc3ZQcXo5akFCSUYvS3BFa0JQRFN2WTB1?=
 =?utf-8?B?SG8wL3FpYlVzelphUG9STHRVZElQNENvMEJNRHBPSHR6RWVDMkRocG5WaFRz?=
 =?utf-8?B?ZUY1WnloTFkzZngvUkV1KzRvYXBQWUM5N3FtR1VCWkxzelAzZUdvbFZVVlRn?=
 =?utf-8?B?VjAwRHFMUzNZQlZ0ZjRsV25VN1FFekhmNTdtdU1mNERRQTlxUCs2MGkvRitQ?=
 =?utf-8?B?SnQ2Z1B2dlc1TGZhOG9DRzBmNmcwQlpBVk5PRGhZRjlFU3ZUdERpUkNkTUly?=
 =?utf-8?B?NklYMldncW5kb3ZaelNyeCtHTExrQ2NNQ1lrYmxJcHFPU2hWVHV5ODJ6OWtk?=
 =?utf-8?B?OE9zQ3hhMy94djFXcWkwdmpMdGpyeTlobjd2TFFiZksrRFcxNHpXM3RIU2Jt?=
 =?utf-8?B?Vmo1bUlmVmdvUlJiTXhvZlFxaTEyeDNZVGtwbkMzOFJxWUN4VFFJdnl5S3pR?=
 =?utf-8?B?MFRsd20reFBXb1hXV2pwTFloRmp3RjAya21NZHhXcmtPVmVQMjVFa05qYjR3?=
 =?utf-8?B?SkxsTzVNTjZBYUFKc1RwOHYxNDFwcnhYOTFvZE1BNmJUZUNnVjRNdlI2VzYy?=
 =?utf-8?B?WDcwZGczU1ZnamFzQTBtQXBQWjJxTVVJb3FYVk16ckZmcytQRzJMS2dsVnZk?=
 =?utf-8?Q?P5GjC+kicfKE2Q4J0jocKfdV/?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979d762-50f6-4b45-1072-08da5a40dd35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 02:33:06.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8AjEcVYNrF+0ip43SW1FEJnPEghFiK46bk7FUCHWlh77UTfANb6W40al4Vl0fGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1105
X-Proofpoint-ORIG-GUID: GJeZMmbwA502I0MFXpHsNtXwY-mQgPFF
X-Proofpoint-GUID: GJeZMmbwA502I0MFXpHsNtXwY-mQgPFF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_24,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/29/22 2:44 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 29, 2022 at 12:12:13AM -0700, Yonghong Song escreveu:
>> Add support for enum64. For 64-bit enumerator value,
>> previously, the value is truncated into 32bit, e.g.,
>> for the following enum in linux uapi bpf.h,
>>    enum {
>>          BPF_F_INDEX_MASK                = 0xffffffffULL,
>>          BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>>    /* BPF_FUNC_perf_event_output for sk_buff input context. */
>>          BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>>    };
> 
> Applied, added the entry for skip generating enums to the man page,
> added support to the pahole BTF loader, used the new pahole to build
> bpf-next/master, all seems ok, pushing to next on git.kernel.org so that
> the libbpf github CI can give it a go.
> 
> To build with torvalds/master one has to add --skip_encoding_btf_enum64,
> I think, haven't tested with it, without it isn't working, libbpf
> complains at that btfids tool.

The patch to support enum64 in btf_laoder looks good to me too.
Thanks for checking and additional testing!

> 
> Please check/test what is in there now:
> 
>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git next
>    https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
> 
> Unless someone screams I plan pushing out a new release, update fedora
> packages, etc early next week its overdue by now.
> 
> - Arnaldo
>   
>> BPF_F_CTXLEN_MASK will be encoded with 0 with BTF_KIND_ENUM
>> after pahole dwarf-to-btf conversion.
>> With this patch, the BPF_F_CTXLEN_MASK will be encoded properly
>> with BTF_KIND_ENUM64.
>>
>> This patch is on top of tmp.master since tmp.master has not
>> been sync'ed with master branch yet.
>>
>> Changelogs:
>>    v2 -> v3:
>>      - pass struct type/conf_load pointers to btf_encoder__add_enum[_value]
>>        to make code easier to understand.
>>    v1 -> v2:
>>      - Add flag --skip_encoding_btf_enum64 to disable newly-added functionality.
>>
>> Yonghong Song (2):
>>    libbpf: Sync with latest libbpf repo
>>    btf: Support BTF_KIND_ENUM64
>>
>>   btf_encoder.c     | 67 +++++++++++++++++++++++++++++++++++------------
>>   btf_encoder.h     |  2 +-
>>   dwarf_loader.c    | 12 +++++++++
>>   dwarves.h         |  4 ++-
>>   dwarves_fprintf.c |  6 ++++-
>>   lib/bpf           |  2 +-
>>   pahole.c          | 10 ++++++-
>>   7 files changed, 81 insertions(+), 22 deletions(-)
>>
>> -- 
>> 2.30.2
> 
