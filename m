Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19E584611
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiG1S0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG1S0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 14:26:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AFD6D562
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 11:26:47 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIAxUY004508;
        Thu, 28 Jul 2022 11:25:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dKivOh9sc9YtJTOvJ6Z6bcHWl4MvK8jiH2jCNAyELmk=;
 b=K9ZaLhxrR56Gy/MWrPpYl6cZaQoHSqexf6leIbrog2x6+Ak3ivw5+0QSJIa+dhJbpjap
 A2xN9DKVP2RAMh5qN8wmF/6LfstYEq7SqfeVir/4S4HVJw9m69tMrU8uZjJbArcBpY9e
 ztAPfY+Oj/wWp456U0Fc2P8n57wDpiF92Hs= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hjw4fdacx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 11:25:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNlLliIkS5SsJGt+8HnN1l1hE1Eo1vWbEx1LOMgRj6szFcNLEDvdd9mQDD8pLGdfriP/oe1j1CPQfdd4Ci8Hnb5k7031jwADOefVxqGDcFx+zckdnIXcNGn+SYVZhoY0CwWSi5qcN89+JGCwhPqFC3BysPgVZiJvjjVzJgFlrvGurwcpbOoGPcrUGC6E6GRp1ITFE0M19TVf8QWUwqBvXI8wXhmKC2O1wFrS9Yu8/rhkg1C8KdI6iarseDFpIObfY9PiFBNFtEcAOOCLbMSiVRRcz7XWBQm6aPPiaPD+Ys2J2XzviBTWwiG9E8LwVMN9T8u5FzJi9V2dUcFdSBWOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKivOh9sc9YtJTOvJ6Z6bcHWl4MvK8jiH2jCNAyELmk=;
 b=biLAh4aqULPzfT4GT/ERJjNa6FL7txTNcjsj9p5cz+T8MsrfSmuhDUd0GxNC73vW2cwW/cYWzbzKmWBCP+mPBlCrRVKcI3N67Roc6MNg9di6u8LCpkaPhI9qO/PtIh2MLDe28SAOkE6himxltyTxxEaifWeT0Ii8a07gfLY8jnGJAZwrdS5DFoEypq836s6wK3Yyeino4n73OBo76p3GIiFEkNcSsvwWs5rl+E3Hsjy15HLXHyU3kUi4dhYTZ7hgFvwm939Nqqxw3bYIT92WRsjIQFHRRzU42nYHomxdUCpHZyNLr+SZ4P6ppo9UtCPzOT2eHLqnDdSF3cgEVtd4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4158.namprd15.prod.outlook.com (2603:10b6:806:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 18:25:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 18:25:56 +0000
Message-ID: <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
Date:   Thu, 28 Jul 2022 11:25:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next] bpftool: Mark generated skeleton headers as
 system headers
Content-Language: en-US
To:     =?UTF-8?Q?J=c3=b6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>,
        bpf@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220728165644.660530-1-jthinz@mailbox.tu-berlin.de>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220728165644.660530-1-jthinz@mailbox.tu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c73b4043-dc02-42b2-d022-08da70c69d0d
X-MS-TrafficTypeDiagnostic: SN7PR15MB4158:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIBnGeuhr0VmafGSNgKP6DFJnd6crzJ3LJ6Mx0Lbxg7a8Ft2+ZxUlimDvsYy3aSvPtRsbaHG4OFF552wq7Cd0K3zIO5UZcLEgcwHHgpgtFwTjuqgsEmYJoBOU0QZuqvVdM3tD/GxDZOb/9ixwko3SGHS0PF8tkdpS8c3N7BMuexAbvVQKnNmUOEQIRxAyvdIKlxDUPY+l+qUTl2KEMzD9MXX0lk5aKjrcSBNSYQbyzMVZ32NaGG+3fRBxb5BnoCyaXUf2w6n/eyQzTlFkGVEMnKu+UZjTetCmCP93lOBELN/2IOrTbG3SV6x2VWIf5DrGoYbij/zdtVz1t0r2CIheQbmzFk4TDyeBh4xScs7OCRg302j0jAYYefoXz9SifXmMEH46hxio4F+4qZVasS2Hae6aUPa74kQwLllJWKame/cR7Npne1XjEwWNE783YpgdpEBqW5yu96OXdVIoP2QTSoMu0v+4miP0JofMRh7hdBt7vL1MwOFiFlKmd4g5iYpEVyJxDpeOshIiWMzUdb352tAfNp/nxjFTy3e/b0Ki5rgbaPD2BSDWFybhw1i1dvusWFBWiRZE/NZB59/8ktqRrdpkYJsQSkEAib9MD8bMY2PPF+sQfNe5/DwA4XyrU9FosHpLlfv3le/D/Tceqx7CKyAC1ZSuqkrxw9gj/PbryLBFEFBY2gr10vhfpoa+OF/v4xkuE7lKL/8zEC/7Tmn52uzISxAndlm1WvOxMU+KhMWCOJIPV9lC4Ocanh/kcyi+Leo7h2kLtwXi5yQbodXtgHZ84ift0MC83poW1fxp2o5/QqJ/qdqoq3cqSo5pGpZ/9ZVAfUy1Z1TJ4gLa1cA9zx1mAdsIJlsrI0CgQiSoeaRPemb2DfxjfIhmiY2OqE+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(31696002)(38100700002)(83380400001)(66556008)(66946007)(8676002)(4326008)(316002)(54906003)(2906002)(66476007)(6506007)(8936002)(7416002)(6512007)(66574015)(6666004)(53546011)(5660300002)(6486002)(2616005)(186003)(41300700001)(478600001)(966005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NtMklDQkhydUo0bG9PK1dibGduZWhtOEVuUlprZFFuQlZ4aS9tRHdQc0lY?=
 =?utf-8?B?M0haTGxqWENkMFd2Z0twTks1aUpFM3FjTndXYjFSVGlHZHpKbmNSTjU3OWZD?=
 =?utf-8?B?dFFoMi9PbWRvSVZiTjRNTU1XNWVVNmZZKzdWazhHOWpkV0cwU0NkREs4MlBW?=
 =?utf-8?B?U2kzWVo0bjdFdy9vRloveDlBQ0xnSTJPMktIK1c0cEhuRmpBSW5BOG9VMUZI?=
 =?utf-8?B?SU5wNEQ0b0s4OWlaYUpXMjR3ejJieHRmWmNkUEUwZ0FIbmRiTkhmRG11TGpT?=
 =?utf-8?B?SVRNK29MZ3VCVGlXbVczU0ZjeG1YNzB1ekcvVlJPYWFRQkdERzJrcTZSVVhn?=
 =?utf-8?B?dUE4Y09JOE5nWGg0QXNOMWp6VTRRaVpYSHZPN2JpQ09vYm9ZeFhwczRCUHZ1?=
 =?utf-8?B?TlNGVmR2WHVPWDF6eXdhc1NLdmU1WThiVmpvcCtlSHVlOWFUR2VPOUJxRnVQ?=
 =?utf-8?B?NE1iV0dRSVlMaW95Z2hVak94WXl3MmhWa3lqM2JNSTNFOUkxbGZNZysyQnBl?=
 =?utf-8?B?aS9FalBzNkk0WVh6YXV1aDlpdUI0STFhd1RSLzlreVR0RE1MV0RyTzJhS2dh?=
 =?utf-8?B?N08wTzJ2WGFyZGtJd1pYdk54Y0ltMEllRkVGSUNvd3AzSm1MSjRFamlyeWFP?=
 =?utf-8?B?OGhBUXk5bHJ5Q3pCUlRsNms2dS9zZFc2NWVVbkhzVDViUjkxSFJVYXZ4SW9r?=
 =?utf-8?B?UDZET3R1TFFxenR5YWxheGFYUUg4eWc3NFNDUGhaY3dYM0pPM2xUb2dSWUhN?=
 =?utf-8?B?ZlpQS2xmaWwzUSs4a3FjOFRoekJLMU5TODFLTnZIZXB1V2xXZENJaUtYQ2lo?=
 =?utf-8?B?VHFaTlBZaG1OOTZ6ODNROUZXQURaNWpOV1J0LytpZnkvaCtqdytZd2h6TmlJ?=
 =?utf-8?B?RTRERXh1Rm9uZ0M2UGNhV3NjSmsveGxuMjU2WlZFZFVLYitoRGFONm55bEc3?=
 =?utf-8?B?YjA2YS9oN1NWWXNNdm9ERGM4ZDFJN1pqbmpHRlFWUmxmdDRyVTUvSDlFM0w1?=
 =?utf-8?B?alFTUE45L0YvelAvRmJSQUZoaTlPQWtJUng1T0thZDdaUWhIYTR6Ym5nL3ds?=
 =?utf-8?B?amEzdnRvYWNXUVlMZjJsS280RGtYZzZOVHFzeENqUDBsLzFBSllkeVFUd0dp?=
 =?utf-8?B?WjNnQzVHakhtV3A0Q05zcVkzdU5TR2hIZlhpdGluV2ovcWRqV3hMWVVxR2hO?=
 =?utf-8?B?NHo5d09uSURlSngwQUV2M05qcHY0VVFBUUlaSDJwbzdWYXZxRitGZ0duNGtD?=
 =?utf-8?B?L0ZiU2JBTThpVzk1SXZuQW14dzZ0OGl0OE9LSTUvNUkzU05CR0xoOG9xcEhr?=
 =?utf-8?B?aGtIRWw2VG9VNXBRMXVQbHNOWDc4YkVhUlJRcEltWDFOMkh4em9DTG9BWE1y?=
 =?utf-8?B?bkJsdEVzaHFxckErZjhmNTVZNjRSYkNaN25aa3VNUVprbW9CbWp5Q0d2cHZO?=
 =?utf-8?B?bElrMVlkYWk3UFhEQ3pSc3dYSjNybDJUZ21HcE9yKzQrT3ZBc1h1TTM1alJZ?=
 =?utf-8?B?Z1Y5VkNRaVVkM1dLeEhURWtGRHVyak9RUS9mOUNXNXNRMm5IT1c4eWZNaEZC?=
 =?utf-8?B?dlhkQzZ0Ym14LzhPYXNqbUE5eW5QNFRLYWJZSmQxNTB5K0Z2STltSDB6QTVD?=
 =?utf-8?B?eDFjY0RCYjhNcmIramJMNm1COW5UNWFhRWVFN2VrMlREYjJPUDVvSmd6QVZ4?=
 =?utf-8?B?ZGttOGtBMGFtSUxjSWU0d0RPUmtYa1c2dm1kQWQyOFlWaXRFeVFpZG1hbE1h?=
 =?utf-8?B?SHY3WEgwODhXTEhTN3l6SnF3Qzh6VWNEVThQSHBMQnVYQmhWMHRHYlR1VGNR?=
 =?utf-8?B?RTA1aFRmWEs3VW1BcVJJWlpVN0FpZlNQbDFtL09RVkpZenBWeklKQ3dvM0lX?=
 =?utf-8?B?WEVLZVJoWVdKV2ptMDlWcFFrV2t2SFlEZ0VCQ09Yc1BnWXZWVVBHenNsYkNh?=
 =?utf-8?B?WmIra0NqSlB0cVYxNXZJVnZYS1NZWU5NS3ZoOTNqc1hwOURNUksweS82K2Fn?=
 =?utf-8?B?d1dvN1V4ZzNFZDJOZWxOeFZtbDVHZ2RWdklySVYzVkVuQmJvSU1PNjh1MGNW?=
 =?utf-8?B?dkI4Y1JVMVNMQy8zVnJpYmk1WExVRFBXMTZoUkNuSEo2ZTJxeHhuSS9oYnNm?=
 =?utf-8?B?TnFaSE9YcWJGbWNkTTdhbWRhSTVPQWgxYWtGdDYzQktwNVYwOEVEMURZZWto?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73b4043-dc02-42b2-d022-08da70c69d0d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 18:25:56.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE6LdFn6bUtpto/7qv+gCbAH82iSmueuDZtTlptjqR3cLYWnkpdIbfYpdJqWxmud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4158
X-Proofpoint-ORIG-GUID: lhDBS4kII8X8V3PxAs4bai0BIFdI22Mh
X-Proofpoint-GUID: lhDBS4kII8X8V3PxAs4bai0BIFdI22Mh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 9:56 AM, Jörn-Thorben Hinz wrote:
> Hi,
> 
> after compiling a skeleton-using program with -pedantic once and
> stumbling across a tiniest incorrectness in skeletons with it[1], I was
> debating whether it makes sense to suppress warnings from skeleton
> headers.
> 
> Happy about comments about this. This change might be too suppressive
> towards warnings and maybe ignoring only -Woverlength-strings directly
> in OBJ_NAME__elf_bytes() be a better idea. Or keep all warnings from
> skeletons available as-is to have them more visible in and around
> bpftool’s development.

This is my 2cents. As you mentioned, skeleton file are per program
and not in system header file directory. I would like not to mark
these header files as system files. Since different program will
generate different skeleton headers, suppressing warnings
will prevent from catching potential issues in certain cases.

Also, since the warning is triggered by extra user flags like -pedantic
when building bpftool, user can also add -Wno-overlength-strings
in the extra user flags.

> 
> [1] https://lore.kernel.org/r/20220726133203.514087-1-jthinz@mailbox.tu-berlin.de/
> 
> Commit message:
> 
> A userspace program including a skeleton generated by bpftool might use
> an arbitrary set of compiler flags, including enabling various warnings.
> 
> For example, with -Woverlength-strings the string constant in
> OBJ_NAME__elf_bytes() causes a warning due to its usually huge length.
> This string length is not an actual problem with GCC and clang, though,
> it’s “just” not required by the C standard to be supported.
> 
> Skeleton headers are likely not placed in a system include path. To
> avoid the above warning and similar noise for the *user* of a skeleton,
> explicitly mark the header as a system header which disables almost all
> warnings for it when included.
> 
> Skeleton headers generated during the build of bpftool are not marked to
> keep potential warnings available to bpftool’s developers.
> 
> Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
> ---
>   tools/bpf/bpftool/Makefile |  2 ++
>   tools/bpf/bpftool/gen.c    | 30 +++++++++++++++++++++++++++---
>   2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 6b5b3a99f79d..5f484d7929db 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -196,6 +196,8 @@ endif
>   
>   CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
>   
> +$(BOOTSTRAP_OUTPUT)%.o: CFLAGS += -DBPFTOOL_BOOTSTRAP
> +
>   $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
>   	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
>   
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 1cf53bb01936..82053aceec78 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1006,7 +1006,15 @@ static int do_skeleton(int argc, char **argv)
>   		/* THIS FILE IS AUTOGENERATED BY BPFTOOL! */		    \n\
>   		#ifndef %2$s						    \n\
>   		#define %2$s						    \n\
> -									    \n\
> +		"
> +#ifndef BPFTOOL_BOOTSTRAP
> +		"\
> +		\n\
> +		_Pragma(\"GCC system_header\")				    \n\
> +		"
> +#endif
> +		"\
> +		\n\
>   		#include <bpf/skel_internal.h>				    \n\
>   									    \n\
>   		struct %1$s {						    \n\
> @@ -1022,7 +1030,15 @@ static int do_skeleton(int argc, char **argv)
>   		/* THIS FILE IS AUTOGENERATED BY BPFTOOL! */		    \n\
>   		#ifndef %2$s						    \n\
>   		#define %2$s						    \n\
> -									    \n\
> +		"
> +#ifndef BPFTOOL_BOOTSTRAP
> +		"\
> +		\n\
> +		_Pragma(\"GCC system_header\")				    \n\
> +		"
> +#endif
> +		"\
> +		\n\
>   		#include <errno.h>					    \n\
>   		#include <stdlib.h>					    \n\
>   		#include <bpf/libbpf.h>					    \n\
> @@ -1415,7 +1431,15 @@ static int do_subskeleton(int argc, char **argv)
>   	/* THIS FILE IS AUTOGENERATED! */				    \n\
>   	#ifndef %2$s							    \n\
>   	#define %2$s							    \n\
> -									    \n\
> +		"
> +#ifndef BPFTOOL_BOOTSTRAP
> +	"\
> +	\n\
> +	_Pragma(\"GCC system_header\")					    \n\
> +	"
> +#endif
> +	"\
> +	\n\
>   	#include <errno.h>						    \n\
>   	#include <stdlib.h>						    \n\
>   	#include <bpf/libbpf.h>						    \n\
