Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB861FDD6
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 19:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiKGSqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 13:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKGSqX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 13:46:23 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7A51E3D7;
        Mon,  7 Nov 2022 10:46:22 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7Iimdn021894;
        Mon, 7 Nov 2022 10:45:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=C2jXc+OIYT3lEWKBm6fAkbgnh3e9HUTOnyyHuNCZRcc=;
 b=MoWxK12Pl2syF5zbhgJgGoJxzQbj5i+K8Z/Rk7of5IDGMWocbHWN/C3jX4wFr/Ltdpkt
 Tyv4uyozJhq6iE1Udv3FnaNrZGqlOQsC5mwyBxpkPI6HwfoQjA8xyqD/VUABf+m5Qptp
 VE+y0/zRwD/T97EkkJd3L2T3CUDTaWUBlQit8njiwoW9Mh7RvY22pdkxWi7E1sTL0t9f
 nbhWfhDfEIoo8ZRv0YY2XiFFZG8Bte9hPlX/dKArI/WHjqwya4/vxq9S+X632SU0uNxO
 a4i1o5Y9p/YlCCIKU/Lpziql0UUzQzmmea7oJ3eKM4zq3zjao5SjHzSjGETksx0tSCB+ WQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knnhnsapb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 10:45:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5Q7Idjj4IBQ2EP4CEzjwzJKCUQ8dXNEw4alnWl5MLuXQMcukID33mySC5OIciJKY5FdVnzvC6lkoeX23ksNXBNW6m6PVrvAR4+QuUZ8JODlBhXWdEg6DV1CK9c3lo406f90chhwW5OzgkenQXlrC1FsON6eUm4KEp0Alj7AcL812+/bRbKw4II2haef24+sMF/lUTUHuhzLPJuneBUyIl8WvdiicOx/l40TZ7w3Ju8LLdU9GTvUI6loxDuHjXTIUwKZGT7NFg5qAIBiFE/0NzTGckw5zWdLkoE1sTm665IKyEKjQkEKxg7mifUgVJGfeyMkm4GwZgigwoeuKPdYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2jXc+OIYT3lEWKBm6fAkbgnh3e9HUTOnyyHuNCZRcc=;
 b=WX8FN/WlY00wK8q+kxW2XINk1KEuRpVAyP2K6p3ZN9PPPycrr/RC77RrjN/ZQ+uBXwmFBo+moOS5MpJoDx0z7PJIAPMPB2SN4Q3kQUd407xGB/fW0Y4FJaE5LPr7KdaexGnBaFYMwsdMes4NaCyge/PpLnbloy3Or7uWTZAeo/Cy9JckdiibkgkCZ6RB97BY6Kc92546/1jIW72wxnwq8x0WuE5KXCmMfMW7bUnTpuTPqCh/oTEDYH0UtCKQOjV6rLxywCUniP9iRSgq9nyi4R8yeYVgyZdCwO2OffjhWsOlVF6wQ5irirb5K2qY4wFoAxoGOSmjXPgNVM1BrPRnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2814.namprd15.prod.outlook.com (2603:10b6:208:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 18:45:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:45:37 +0000
Message-ID: <40da21f7-19d7-142f-0380-41abd0d47d1d@meta.com>
Date:   Mon, 7 Nov 2022 10:45:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf] bpf: Add explicit cast to 'void *' for
 __BPF_DISPATCHER_UPDATE()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "kernelci.org bot" <bot@kernelci.org>
References: <20221107170711.42409-1-nathan@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107170711.42409-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB2814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d88578c-bff9-4d85-1d9a-08dac0f042c7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +obB+yljg/VKNPxG4mMxTFKmcVzFw5kvnhz6ldQt2d3P5cSi3Dh7zYCWyrgUxSKnwkMjSeamVIrSzew9Q0hJtTkRfNaMHWdseA2zWxXcY15b9KOVSp8BGLdMd8POqXUbaY4bAY43FlkKS5eQ0JswoYz0ypfoVglk8A1UQiU9qKR6yd8FQfocjv/zOf6G5jHCXpVcSljtrUqUvNMI11mm43xdIUNJQM84rWkOZSuAvkAEGIKaY0OZvCMo/mC0zYw/yuKS+hKB9Ov026idMpSbopisxv+9xRsUzeTIhCyOTVj6vp7QKCRc+B/HIIzvSR4IlXOt54RgqawlQZLUOds6waXl706p6kcPyqfYhrWIC4+GbYFM68WXmZriv9SNVQD5+hbsYhXW5+HQ1YYVgm22xRc+Yye8n1+v/VggleRqcNM033Gc4o3Qzi9gDgPlpSApVUuj/tPPxjivnNxlIMAljYwYgiQdfcSwIBzqE0PLU3sLG6t4kgBwbhxXxQ9RGP330TZ3+A3IX1eWmp1xKiSD1oYF1lwM5oi53Qklu80Ozw+Yt4h5akaKljdQ2xt65dZk/naTPqXL3b/np0ZmzvKeyQTxbAlal/RLfk0/sCjSe2iULTjJS4JKlGrp1n1hUgH/D5qzRpR9eOuTGQq8QOdBbvXwhpM3p0EIc+ymRy6JydHqDw1nv8eGxj9eBQuWw3SCTk9NgG2DvgyxuePbJOj+mO+H/sCVVjD/o15cbmF3Y7SUK0EIjjHRjoF5R0PJcGY/SRkiYAyrzUxvXjvD/44g48NR/Uq5kkRIWUeEuk14aJDgTQwtAHapWTawK8gbHq3yO3mA0jGwT8l5GnURuCRImg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(316002)(110136005)(8676002)(54906003)(966005)(4326008)(2906002)(6486002)(31696002)(478600001)(36756003)(66946007)(66476007)(66556008)(86362001)(83380400001)(38100700002)(6506007)(6666004)(6512007)(2616005)(53546011)(186003)(7416002)(8936002)(5660300002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkI0Z2JmUzdvcUpRN2ZXSTd4dm9jV3E3cTZnZUFlOS96bzFzRUwrMXIxazJI?=
 =?utf-8?B?Umw3K3lXUnQ4VU5CbEZocEtNOXV5Q0FXc1JyUENEUWRQYXluZmk2eGdyU0Qw?=
 =?utf-8?B?U1FhQ0lBc0l3VDFRc2JFNHRMblo1amRreE5INWJYbHhhRHRaQWd1QUpuQWdI?=
 =?utf-8?B?STNjVHNqSzJYMTY2dytZTDZKajU4d1huNW1TMlpBZkRWbU9xVk1XcjdSTmM3?=
 =?utf-8?B?NlJLOUdTMWZSMUlEK1NZaFNxbDEvT3Y3MVg1dzkybU5XQkdVUUpTemJuMGhR?=
 =?utf-8?B?enJiZEtVRXZtazNLVXJDZHRVOVAxUkJTY210ZE5UeDVnemFlWjlSZEdneXpm?=
 =?utf-8?B?YlhJclllaVZIZXNpQWxFQkxFRTZtR2N5ZzNINmtRZE5MbE5TUzg3NmRrUWFk?=
 =?utf-8?B?T2xjNXhiOVFwL1ovUjdmNkttU2xhamt3YUNmU0t5ekg4a0RBK1EyZE9kL2M1?=
 =?utf-8?B?cHltcnpUNHE3eGRuRVhUOWQ1aVZhNDFXTDhScW9wVDVoZWpCdG1BUVV0bnVG?=
 =?utf-8?B?MXBtamNPMmpYNjRDdGx6bG0xdSszeWNKdGM1YzQxeFN1dHZxUXVTYVJnMlo3?=
 =?utf-8?B?ZytmdU5qdUdPY1FheWIvMENTT0J6R3Yxb2NKVFFrOUZjOVRjanJETzFjTWFS?=
 =?utf-8?B?SStFKzhKUE81UEJTM0lkWHdaMmFMN0NvNmNDS01ieEpNNmFKZ2xOUlExTUF6?=
 =?utf-8?B?SEd4VUtkNzhHWWVrd255YmNNc1lzSjMvYkZPcFd5SlBBbWhEQm5BM2E5Zm1I?=
 =?utf-8?B?OGdRSFV2U00xTTN5U1gzQmpoa3lteENhQXlFSzU4MkdSVC9OUlp2V1IwVkp1?=
 =?utf-8?B?R0xUZTE0aUV6TVh1ZkpQa2RPd0Jac2NPanFkUW9NcGtLejRxVURQcjkybXRM?=
 =?utf-8?B?dUFKMHR2Yzd0VVhHcEFtVU5QOEVJL3J5WjdBR1l2Y2p5RE1kb2VwOWZ5YVdu?=
 =?utf-8?B?YUNXNUM1NnRMZG4yZnRhK1hPcmxRMVJWdHA3STJTaXZTWkYxNnZrUTN5Zng2?=
 =?utf-8?B?RnNDRUkvQU9PUzZqY1YzL2o5eVYwK0VkSWlrSFZlUE10WThEdXdoYXZhY2U5?=
 =?utf-8?B?NmRxa2dxSCs3TmNYNjBxTmJCVG4zd1BtMWJiT0l6eEd5V2RVZTNyeVBETXVL?=
 =?utf-8?B?NFJBVUdtOVI0RlhZMGVlcDd5TGJLZnVJajkwb3Jld3VDVjZZNFp4VHlXSGFm?=
 =?utf-8?B?UjdidWhDM2g2WlZ2SWJvcjVCOGxYWkU4MWtvUmVDcWRqOWZBZDBOUHl6Y2g5?=
 =?utf-8?B?V3lydWFENDQ0TmhleGlQeWthbktlcDg5SjhSVDRZMWYyZnQ0VGpWWkZLWjJt?=
 =?utf-8?B?T2ZwY3pyaVgveEJoWEtsNS9VTStGL0t2RDF6S050WUY5VFBhK3hDMzVvaTN3?=
 =?utf-8?B?Sk5kVGN3VC9ITXovQlNSWmJyNENFV3M2S01MYi9uTU03ZHNsS20ydm5QUGgv?=
 =?utf-8?B?SDV4TmVPeGR4UGJOU1BPclBpcEZmL1o4WGdjUjBsdkhEVFZXK0NoYmlzSERC?=
 =?utf-8?B?UksrcTNnYS96WGU0NTc0ZnYwZnoyZDlScWMzNXV3UHM3K081VDFrb2NweGZG?=
 =?utf-8?B?Ukg2SjBOQ1QwcnVaY3hrdXZJdVdFdEU3VEJMejZjUHh4RWJCZTg3T1M2SnNu?=
 =?utf-8?B?djFqVVBSc2hlOHRPWVg0K3FwOUcrelQrOGlncG9rK3o2bm1RMUQxM1cxc0pH?=
 =?utf-8?B?a2Q0SUhWTlNPU3VVS0ZSZllPVnRpYU9tVElZUmtIdFBJNHZSQW5ocHBqeG41?=
 =?utf-8?B?U1B2V0ZwU2RLMElLaFVCVStxd0d2N2szamg4WWhwWHNvUnE5Qzh5K2x3S0c2?=
 =?utf-8?B?NTZPYzJJQXdPaVF3Y054SDVaNW11TlY0dHV5OWlyUFY4MnJxTW1ORlBWRzRh?=
 =?utf-8?B?eDFSRG5wYXQvYk8rZURzMzhUTFBJc0NMcXJheTNoN2s1MEthS0kwUVk3R3c1?=
 =?utf-8?B?VFZGMFZmZytUczZlMGNnZFZOSG5VNTYraUhvb0o5a1N2TVJvZkxrUXc1ZEhX?=
 =?utf-8?B?SXQ0R0t5cDBGUVNJM2YvUVJKL0w2d3d6aTBGUWRwaFhDM2xvUUcrN1ZmeXZv?=
 =?utf-8?B?OEROZ1l1cVhGenpiSVl2QjJsdDE2RzZZY3JILzVaTU53c0tYeUtaSnB6QWth?=
 =?utf-8?B?Mkp1M1FVY1lPOHV3OUNJMG9HalplWlZTU0IvM3pIMFVUYk9pdXdERng5MnBS?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d88578c-bff9-4d85-1d9a-08dac0f042c7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:45:37.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b1OQ+9xCGjxJ8MqNMR3k9lTFdUsR9N0HI8vn/8VSXI2CUB26UACT7OWbRP9mfvn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2814
X-Proofpoint-GUID: BDCL2ezEdYabYccZt2iAF10mlhRH8Dsf
X-Proofpoint-ORIG-GUID: BDCL2ezEdYabYccZt2iAF10mlhRH8Dsf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 9:07 AM, Nathan Chancellor wrote:
> When building with clang:
> 
>    kernel/bpf/dispatcher.c:126:33: error: pointer type mismatch ('void *' and 'unsigned int (*)(const void *, const struct bpf_insn *, bpf_func_t)' (aka 'unsigned int (*)(const void *, const struct bpf_insn *, unsigned int (*)(const void *, const struct bpf_insn *))')) [-Werror,-Wpointer-type-mismatch]
>            __BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
>                                       ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
>    ./include/linux/bpf.h:1045:54: note: expanded from macro '__BPF_DISPATCHER_UPDATE'
>            __static_call_update((_d)->sc_key, (_d)->sc_tramp, (_new))
>                                                                ^~~~
>    1 error generated.
> 
> The warning is pointing out that the type of new ('void *') and
> &bpf_dispatcher_nop_func are not compatible, which could have side
> effects coming out of a conditional operator due to promotion rules.
> 
> Add the explicit cast to 'void *' to make it clear that this is
> expected, as __BPF_DISPATCHER_UPDATE() expands to a call to
> __static_call_update(), which expects a 'void *' as its final argument.
> 
> Fixes: c86df29d11df ("bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1755
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
