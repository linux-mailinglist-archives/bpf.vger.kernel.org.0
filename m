Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D12611A8E
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJ1S5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJ1S5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 14:57:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941FB1D2B53
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 11:57:18 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIGFJ1011834;
        Fri, 28 Oct 2022 11:57:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6ClN/zGWzneIk2xG6qTQfMrAhMy3/G32IUZUAa1o4Yk=;
 b=cFCx/3NKcfrqOVWu/PcUYs2Yr87vpJGgLxL4qWI+GsQ3s/U+dCG2hRh3KRT4+u2+Dxqs
 sJoiYZopiy0y18kXx5boZo4xGrbDOYYbTf6iHWyr3DthVdvYvFWAOG4DjKHu9FUh54DX
 H1vmqJcXEFbt053EQKQm569/dJj1ZCBEdydc8gDCFF16zCFF59AqecjG6YD/df2h7/si
 W/8YTVtH+8u39xDuhKC1MpxYLEv+3++zdENpim+5SWTCKL+ROSFSDsl9ITFYtZa8OJ/v
 kPk1Fo+sl4UKtda2kDKmsOFJ1ANfzv4A8Bed29eR8z+5dISyVOPD5SpEmDVOnYPX5qlV bw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kgct7n5nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 11:57:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/RG0/cfgDKZSBexkybnNRrfl3TyIoLOoNF8XMubn0H3nKOiuX7UBvORVkwVqV+BBhwGXQdnEARdkktSU3k+eGuRn7f9oczuqzElwjBZ6EcYm8FlwBxRzLlhEUhQXjHCA9METmyN17zMD3p06Yx6auELbBd6VHMfF6vrnghQtLfNVzwYoxWDEOYOFf/VvlH2lEdi7n2HDKHhhb72NOtZghmjB6HGDNqZO3BjpnXEIwA8du4asQfh0k2j2rHZNJY3VKVjF0LTrBruueZ/zFiF8NVPeIP5+rKNfrkenDjOShewL5XKWono1E2pPOhwg53fHp3g/tPisVwHGZ/z6U5zYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ClN/zGWzneIk2xG6qTQfMrAhMy3/G32IUZUAa1o4Yk=;
 b=b+nMcInok7LHkJTNwwK1qXE+VplGBATNrLbR0gXeP6WFa+EH462pggqPBgEyFEcveKNCdKzA6zWYamsrMd/TGDMICcceKs/5FaqofzEGCOiaXXRLd8cy1rmFcTAQ6PdycqHfush5YjmhF6letCOLjrqgENa3kYrYDMKAkUs4MPH8lfmKN7qHZfy46Ebff9yK2uysvZdzuevJX8MNytpSbJyk4bMb/98I4Ab7S/lhJZQk7v1LmRUSKZvnQipMjUxvU4k5l9szEnRZ+cWpvsH3S3oG7QddUuQoclUPNApkI3aSMdzFdrTqfR7NittPsaO+iQBc+286K6SVNRqTmzb4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2494.namprd15.prod.outlook.com (2603:10b6:805:28::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 18:57:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 18:57:00 +0000
Message-ID: <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
Date:   Fri, 28 Oct 2022 11:56:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
 <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
 <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:208:a8::36) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR15MB2494:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f4deaa-cbc2-4155-8918-08dab9163189
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Y44WzuRya26fgQkMXR+GHzYnfE+JRL19iYxC3xA8SO9Muamiznhtqij3VY++PPUYX4PiuwgcNOztNuM48Hm+oK65+JvEHu1dStzLfZPZsTg4AdEi1k+oOLb303vYCsLYJx55K+Xt8kApkgXvytyCWx1WZbgBo6EIknyx55T4RABMqq+bLgXbRtSG+9ues9ErfETejx50KjAVk56lKla3WY7+s6/eWMTBTv4FCk/6NrgAMX+xTJ9l7YuD+YJhYYs/cXVovUWks4h4aL4hr2AlQygXh2d3Uw1Hop3bySMjJDD24FZwoceVFK91u+nlP0aLd6q42ejybgvN9SrGeBPzc3drLOQBgm/8mDslERL5DMuqvRqlDIxp2Nayn30yoMqY7UvRirp1eB1WT26Bto41JyCxWb8dDKyd8527NSsVhqEURrK+TXPYIjlATFP4jk3yU9nPsPvtl8jQPgKIGohvCfhwye2usuijUjCbmZAN91U6mVwlp1FVL96WyGpeRAzA1nlNOhWgPaGNUNjo4fD0wUwMb2PmrGZBG7VaFZ+UqBbWO/sRmvF8n0BRNBXhyjpgUmoDh5VcFVIxHK1Yt9yZ7rXnHyC9BmcCuqQOw3ISfTFWALrxlwJeI8+IVt9TAQezWRXivL4fXO1UuXVUXYwl6Q1o2iUzA9O2rdocusfLXfZAtAhwgN5XxC7tTAQOY6bkqZ6BQYZ/d77dR+RI/6ozWKxxnpMhIZV8weaI0OMQpzBbUCH1FtHGDe7CAELWPTI/jM+gET/+nG5bD5DuACWPUezMoIzN3h0+EjiRq0ZZWU4BCkq5/OPXRfujWe1KUP5T+70oRJ1GZUBtHP21UinZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(38100700002)(31696002)(86362001)(36756003)(83380400001)(66476007)(4326008)(66556008)(316002)(6916009)(8676002)(66946007)(2906002)(41300700001)(5660300002)(8936002)(186003)(966005)(6666004)(478600001)(6512007)(6506007)(2616005)(6486002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXh4NHRBbzNuQStYczN6WWY5dHdySW01WkpPODdNVUZxMENJWG9QVHhtaHly?=
 =?utf-8?B?ZHZDK3lmY2VEK2UvNjB1anh3MHU2dlp0bWIvTU5qeEZKREkwRkxpeThNWHI3?=
 =?utf-8?B?d293Z2xoMlJSSFdOaHNqdmlaVEVaY3RpYlh5YkV1ZzFENk9ub0VqY3poKzZ0?=
 =?utf-8?B?RkNhTHNwMlZGRGdHNXRVSFY0b0VSOENpb2hwVERiVDFtQkcxRDNFZDY0YWRW?=
 =?utf-8?B?cFQ0c3dEZmpEbVdLYUFrczFUejBLRHlzRHExdTgyWjdqOHdKWWpIS3drTFVJ?=
 =?utf-8?B?Mmo4N1krUU9hMk0wK1AvZDdNK21PMzc1cGF6cEdkRytFeUZWQkFZRXRuQ2Rk?=
 =?utf-8?B?WmsyTUVSVzlkb1p3Z0FDNGZSRk1hOVdoTTdvUjFoNmViV2hmUEo4aVdZZmY3?=
 =?utf-8?B?MEc5YVNxWmdESW1zd21tOHpaL2VoUzJ1WUhYUFl0aDh0dlplV3J3b2Y4VTNt?=
 =?utf-8?B?V2xsSEFiOUxyRGN0eGRXWk55NTF4OU9VTUlUQWE1YS9ySnc4ejlKYW91RzZ2?=
 =?utf-8?B?ZGFjclhTLzZsWXE0VjlnVEFhZDQyRDBJZ2N2SEpiTy9GMk1NL2REVlNvalJU?=
 =?utf-8?B?cW5wenRETGxKUi9TUE4xRkdvYlZaNy9TcnFEb1FCQXFEUXU1eVBqMUxPVlYr?=
 =?utf-8?B?RHU1MzA5RVU4Vm5lbEJLMjNXRUJGSlc4MEIxVTgxUEhSNzl2ZWlwaVRYQkF3?=
 =?utf-8?B?bk5iTEdBUGEzeXhBd2psVS82T1NodHhBYjQ3NWtTRlRnQllDV1hRNlg5b0JT?=
 =?utf-8?B?S3ZaZWRrT0V4UGd1UzlFc1gxRlFDYjRFSmFVdHRWSnJpbEs2RGNBb0F5a2FX?=
 =?utf-8?B?TUVlMEpyZ2xDSHc2Y0x2K0xYalZMb05qQXVFdjN4V29yT3lEdWNUKys2OFds?=
 =?utf-8?B?R2Rhakhqdy94bk0yd0xYU0lianVkNTd1M3o3RERidG1ZUFo0SGk3UGpQWjdn?=
 =?utf-8?B?WWZwQVhMaXFkUlZPZG84cVVYQzZ4aG9wSmZyKzJqZUpGMkhEQTNibWlkc2VW?=
 =?utf-8?B?ZjNpYkpjeEQ3dG92RFcra09Za2t0bEJKeDcwRDlzeThybWlsNE5iaUFVbURR?=
 =?utf-8?B?cWZqTEJGTlVzclVUY3lQVkFqNFluSTVvQitTT3o3L0gxc3QxbUJISWFFbnVC?=
 =?utf-8?B?bjVjblFMNjVuMjMxeFRIeDBkM2pZQjE1R2RHSytYdDlxSy93dFp0WXd0cGVV?=
 =?utf-8?B?Q0J4b0N1YnYwY0pubUVIYk9hSDhoUjNqbVh3SjlyM0tUc29lWUxXNThvdW5h?=
 =?utf-8?B?UjM5VGtZa3JBMmdnVU5LYklwVGpSMFV3VzZicGprdmVMcDVxNSs5M21MQ1dh?=
 =?utf-8?B?ZGtBOEZheFIvRUlaaDFJNEU5QjJ3MjVqaERLT0s3TkFvc1h4MnhoWkZ1N0tk?=
 =?utf-8?B?NXdIcEh6WlpVTnFvOS81R2tUdmh2NUd6K1BEaFptK3M0cCtMaFo2RmtMV0JS?=
 =?utf-8?B?MG04SUtaV1JWaTdWa1o4RXRvMWdEK1RNUTZuK3ZkdFVwT2p5OVZJUldFUFZx?=
 =?utf-8?B?dklGdzhTcnBNYXoxb21QUmNTZ2NQWUdybGRab2NlN3hnemh5KzYrRWRTMXBK?=
 =?utf-8?B?cFJjQ0hReGZVc3Fpbk05S21ON1M4YWZOZUwySWl3MjJSTG8rV2traURNdGFY?=
 =?utf-8?B?MUF6SmxZTm80bGdvUXF0RnI5ZmZkR2gxMVBjSjkreS9ray9yR0grbUIyMUZw?=
 =?utf-8?B?enQwMk15OUt4L0tIb3JjVGxqMkFkNk1PckZEWE9JS2YvMmo3Zk5mRFE1MmFz?=
 =?utf-8?B?eTJHVFFmb3o4UGs4YVNqcm5SbW9rYUlMRXhPbDU5ODQ5eFJodW5HeG9PUWh5?=
 =?utf-8?B?NkQrc2ZDdmZOVURGUkp0Nm9lUGdhQ1NjRCtHekkycm1SNS8rSSs0VllzMk9l?=
 =?utf-8?B?bFRWcnZuT05kTW5hamVWVXM3bnl5RHhLb0ZmOWhFYlRsYyt0dkpRT1BwUmdo?=
 =?utf-8?B?TWdQMGs2RHhGTHoxQnJIQ2Y1Vmx5dlpOaEtkdzR5ZENKVHNXNHNRRVlsMkI3?=
 =?utf-8?B?dlFHeWhFRWNWYWxEcU1iRXptRWdvMlZpVENIUUYrMmZ2WXVoWDNSUitXU0xH?=
 =?utf-8?B?ZnBDVHRjZ3U3bUJxbDZGTTI3c1dqQXdsb1hvNTBLVlFlSXN0dCtuNEZmSEtL?=
 =?utf-8?Q?Lx6Xozy+1mKakTVyX6ALIqBBz?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f4deaa-cbc2-4155-8918-08dab9163189
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 18:56:59.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK8hZOxq/yaFQeYhFm+VgSNIrrd9IWqlj7XB23C3uvd86epamnhNnzWqYIRmbwWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2494
X-Proofpoint-GUID: 8lubgj4R-Ef9FH6vgykxKLVi7R22MrbX
X-Proofpoint-ORIG-GUID: 8lubgj4R-Ef9FH6vgykxKLVi7R22MrbX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/28/22 10:13 AM, Andrii Nakryiko wrote:
> On Thu, Oct 27, 2022 at 6:33 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 10/27/22 4:14 PM, Andrii Nakryiko wrote:
>>> On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>
>>>> Hi BPF community,
>>>>
>>>> AFAIK there is a long standing feature request to use kernel headers
>>>> alongside `vmlinux.h` generated by `bpftool`. For example significant
>>>> effort was put to add an attribute `bpf_dominating_decl` (see [1]) to
>>>> clang, unfortunately this effort was stuck due to concerns regarding C
>>>> language semantics.
>>>>
>>>
>>> Maybe we should make another attempt to implement bpf_dominating_decl?
>>> That seems like a more elegant solution than any other implemented or
>>> discussed alternative. Yonghong, WDYT?
>>
>> I would say it would be very difficult for upstream to agree with
>> bpf_dominating_decl. We already have lots of discussions and we
>> likely won't be able to satisfy Aaron who wants us to emit
>> adequate diagnostics which will involve lots of other work
>> and he also thinks this is too far away from C standard and he
>> wants us to implement in a llvm/clang tool which is not what
>> we want.
> 
> Ok, could we change the problem to detecting if some type is defined.
> Would it be possible to have something like
> 
> #if !__is_type_defined(struct abc)
> struct abc {
> };
> #endif
> 
> I think we talked about this and there were problems with this
> approach, but I don't remember details and how insurmountable the
> problem is. Having a way to check whether some type is defined would
> be very useful even outside of -target bpf parlance, though, so maybe
> it's the problem worth attacking?

Yes, we discussed this before. This will need to add additional work
in preprocessor. I just made a discussion topic in llvm discourse

https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-type/66268

Let us see whether we can get some upstream agreement or not.

> 
>>
>>>
>>> BTW, I suggest splitting libbpf btf_dedup and btf_dump changes into a
>>> separate series and sending them as non-RFC sooner. Those improvements
>>> are independent of all the header guards stuff, let's get them landed
>>> sooner.
>>>
>>>> After some discussion with Alexei and Yonghong I'd like to request
>>>> your comments regarding a somewhat brittle and partial solution to
>>>> this issue that relies on adding `#ifndef FOO_H ... #endif` guards in
>>>> the generated `vmlinux.h`.
>>>>
>>>
>>> [...]
>>>
>>>> Eduard Zingerman (12):
>>>>     libbpf: Deduplicate unambigous standalone forward declarations
>>>>     selftests/bpf: Tests for standalone forward BTF declarations
>>>>       deduplication
>>>>     libbpf: Support for BTF_DECL_TAG dump in C format
>>>>     selftests/bpf: Tests for BTF_DECL_TAG dump in C format
>>>>     libbpf: Header guards for selected data structures in vmlinux.h
>>>>     selftests/bpf: Tests for header guards printing in BTF dump
>>>>     bpftool: Enable header guards generation
>>>>     kbuild: Script to infer header guard values for uapi headers
>>>>     kbuild: Header guards for types from include/uapi/*.h in kernel BTF
>>>>     selftests/bpf: Script to verify uapi headers usage with vmlinux.h
>>>>     selftests/bpf: Known good uapi headers for test_uapi_headers.py
>>>>     selftests/bpf: script for infer_header_guards.pl testing
>>>>
>>>>    scripts/infer_header_guards.pl                | 191 +++++
>>>>    scripts/link-vmlinux.sh                       |  13 +-
>>>>    tools/bpf/bpftool/btf.c                       |   4 +-
>>>>    tools/lib/bpf/btf.c                           | 178 ++++-
>>>>    tools/lib/bpf/btf.h                           |   7 +-
>>>>    tools/lib/bpf/btf_dump.c                      | 232 +++++-
>>>>    .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++++++++++
>>>>    tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
>>>>    .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
>>>>    .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
>>>>    .../progs/btf_dump_test_case_header_guards.c  |  94 +++
>>>>    .../bpf/test_uapi_header_guards_infer.sh      |  33 +
>>>>    .../selftests/bpf/test_uapi_headers.py        | 197 +++++
>>>>    13 files changed, 1816 insertions(+), 12 deletions(-)
>>>>    create mode 100755 scripts/infer_header_guards.pl
>>>>    create mode 100644 tools/testing/selftests/bpf/good_uapi_headers.txt
>>>>    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>>>>    create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
>>>>    create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
>>>>    create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py
>>>>
>>>> --
>>>> 2.34.1
>>>>
