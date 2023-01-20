Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB8B675DBE
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjATTQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjATTQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:16:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539E48A33
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 11:16:10 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KHUow4015215;
        Fri, 20 Jan 2023 11:15:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=YraGggmt7qSIa1s1NV50S8b4hS3SMvFYG0BCfNlhkF0=;
 b=JJTbcnRgxQlzJQQ+LAnUGDSuFu+GTMC/gTV/W0j1gn1PfmEdqpDbSIjwY3XXRYfUZU9j
 fzPzvEysqmP3MF2Ddq993JSL2145KjMx9Qk0387HHuaQohgLhxAgE7X0qCt7F/fu2KUD
 2IVU6Dg6ANNLd9bG9ekkaOaTX8P0wIJTy743RUh0JPLYtVkbbWqI5jSkXJceUJgR53IL
 fy2nQTy3JS8/x+7dQMI2kSXLpHf2RtN4yd/OvpMNuybnPsDwijOSRTM+aKgVVscHrOk9
 rVj1A3vWR0pg48hNa3Z/oYpUZORHNdDQQ/Tyk8cz9lfrt0yJ7xQDfXviB4pEzBgZ/ivj mw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7g70w8kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:15:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqp8EDsjH98vxiF61IGNDoZ0eZi/qQwx5+VzTjMYLnlbz0SowumxKHSqViCnFYWZY1kdS5+sh1L7nXCmp6x7jSpe2jyOno8cMW2P6HxJs/cmYZL6tNsaIyw1T9/j5ihR50pK+PWv8ObXaY28lRGNd45icZyQ4uDbUyzg+23D4KhjfiI6DGVrfdetck84HChZSto4BLS9qnnjM50NiUc/QBx18FRHfg3+rw13Qo1kOFA7XGqTcfbhz6TnrvKS1YiR4ax6udZ3SBVxBlptdX08iTKUMOQipXePXGObhNQ+8GShIxwbMHu2zu1uM1f1OD30EthW5tHG/rDd56pyy811YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YraGggmt7qSIa1s1NV50S8b4hS3SMvFYG0BCfNlhkF0=;
 b=gFtVAv/iJbbrjtZv2Qc4Io26MuZ19LRshNBt4J3xAeDaDBXdYv+LwpvFJG3FqzTa90LLep3TRjxkXliy2deqz482hNXkgydo9q6P74uLnvm07KQUwQHjntzox2xdBRTyjriVtTuhSGpX49C//Seg+2BY856lGfU4M8kDP3ZBFlrKKOgfRJCWdudkMp499jRq9bsZsPYBmxICcbXwxCq/tnBdappYHi4uISd+X15rvvMN0xhfR39HC9Dm/k2w4gzazaIW8qbABKHpQPABIG2zv4lEhReLLVl5EYS6wny5Xs8n64zuTQ6ZjczRx2NW/8gv5dxBrW6Ku7PGLznyhgMDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3849.namprd15.prod.outlook.com (2603:10b6:303:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Fri, 20 Jan
 2023 19:15:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 19:15:46 +0000
Message-ID: <b4182459-3fcb-e3d4-09ba-69039a0bdbca@meta.com>
Date:   Fri, 20 Jan 2023 11:15:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: pahole: New version 1.25 release?
Content-Language: en-US
To:     sedat.dilek@gmail.com, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
References: <CA+icZUVbv2T7SExVULn6Bh1mB=VpmYGbH-4U63PKrHPyi6uULQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CA+icZUVbv2T7SExVULn6Bh1mB=VpmYGbH-4U63PKrHPyi6uULQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3849:EE_
X-MS-Office365-Filtering-Correlation-Id: 513309a2-f3ff-422e-8df1-08dafb1abba9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGQQPGztGPUvMX2tnXxrYBUKYwRqBhs1EQnQsm7JE5nHOfWrj0A2sisnq8nogU5o4d+N0uG7fUk8inxoURgeY/5KEvRhROJf9Fh/gmqtSa/xr9UakRl8cvQWP+UWlHXEtqdEsOvkNhChV4omBslplht6xgOGBDk5LeA6bTnEaVczKGTW/lWyVg0mFYQjjACxbHr5LYLR3kFj3StxOe8vVZiaj9n+AodD+UghdLCH9OoT5yDaeL5M1IbCJAjaLtteYeFvJ0mLcyQUlUJnHfEyJjoP+xjHPZzfxiYdEONJL6Tl6XsuRqgVtlPrhRzwFvWYoSfGknvkDQ+udD39Sm4wpSXWsZX1vM9nPs1DYQdChNlErRZ2hAg+xyJryHWtPdpOLeVWgCytfwR5Tw/PXSk18LoBXTWXVUdxceJylHuIpda47HSfTkZa5g6Jpb2+EYDgzWFCsSJQ6+LC1LNEIapA5b4FuddB50lf+lJRq+ed1PD0ZgJUXToJDC8z+9QDjjAzyp9zsSlQOIQbjDvgOFq0UAzqnuBM5PC0GDD3CIIIfiXyWfov8BuJAotQSeNicSFjYFQhdxGQmSxAVg57M2pJd3yslPGpaVl/zq86Wz80dulsZ5OTXfJH9tOY+hJV+t7+BtDfOW5c41FcKohTvXxbuUXHQ49mICtomlojtzvnKEOsHeoPyLRvTFyog+0z2Yw8lmjBdZsxHazD3jsyIgoHdY/ViMhizpOpr+IHgQaKEWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(38100700002)(36756003)(86362001)(31696002)(6486002)(6916009)(6506007)(66476007)(6512007)(31686004)(66556008)(478600001)(66946007)(54906003)(2616005)(53546011)(4326008)(316002)(6666004)(186003)(7416002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmtiTlpwazl5dUFSV09BL1pPUUZWYmpiTU1vQnQ1V3VTOHpoSzM5ZHV3dnN5?=
 =?utf-8?B?cTY3bHZYbXRJdTlyWUxQUGl2TW5SZ1NVdzdQdTI2THNqekVyeHdBNHJpbGtC?=
 =?utf-8?B?blZDTzR2Rm5aVDIzWm1RekVyejNBdWtiT05wWHFNWWRaeGtmVVhwb2hQMGtw?=
 =?utf-8?B?NUViNlR4N2E1S0RMdzBUeEs5b1c2TlBmSG11YkNMNlpRWkd3SUVkT3RxRlNE?=
 =?utf-8?B?N2YxcUI1dUtoaXpCOGh0ZnZSLzVDVTVDdXJBd1dFcytDSUF4SkwrTDVNV2xV?=
 =?utf-8?B?anU1UUdHcFFoYWpBOGY4UWRRYkJsUUVxT1RUdG1pNG5TSk1TVmZJWUtBZUFo?=
 =?utf-8?B?a3g2RW5Ka21wb09HVXo4YU92YXlIY0dCQm1jVk5qa0dFMVNsOXhTNnZlWWx3?=
 =?utf-8?B?QWttb2krcC9oanNGQkhySThGaVFmUFRiaW5MWFBHdWVxS3hhMGhvQ01mZm9s?=
 =?utf-8?B?dnZ4NmpoWFhhRGVIUVJWT2dLNHc3bWVTNjROMzVTazJpbEJrTnlYUFJDdFZk?=
 =?utf-8?B?UFRZT1l2NHhZVXJWWXpDcGFlcFIrQVkwVU9vanNXYm9WbXAxU0s2dDFGQlhL?=
 =?utf-8?B?SW1lSU50bVZxNEdueWtZNDFKNXNFUmdaV25RbHVKVmExQUo2YldIVDA0VGlN?=
 =?utf-8?B?WXVUclVzZXAwcXJIR3JXU3lUbmtnZXBSODNQRlNDZmo5c2FxUE9adHNwalNO?=
 =?utf-8?B?V0JmanhuQnhzZmpjNW8vNTZkVUVVK0dzdy92UkhSTGRMdSs2SWxyd0tIZTNu?=
 =?utf-8?B?Y3RYQW8vQ3M3TzhzS3FhT2xyQXVkaVVwVG14emF6b21UK2RmZ2N4M05uS3RN?=
 =?utf-8?B?aUhCSHVydGxneUtZekMzaDVNcmJhVWJTT0FVdTh3OTR4c3BtVkIwUm5mYW5P?=
 =?utf-8?B?NElMOUFlVkFicExjWG1yTXJVRFRqL3VoQlZBZTJVazhhdFo0L0dFdGhXdnlS?=
 =?utf-8?B?bVRnRDZTcU02MWRrSzhScmlvT1gySllzTnNBNCs1ZkhJUnhTZW5QNU11cmxj?=
 =?utf-8?B?Yjk4UldVMkxNTEdBNHBScEdwUEZuQVNNNkx0ZG1zVHVqa09aVlJUTHZ2cUc4?=
 =?utf-8?B?aGZYdHpFZjJGSVNVaktrOForY0V2LzZKcVVLc3JpRVZhQXdhM01GQlJZbm9u?=
 =?utf-8?B?aGZySUhsL2hjdU9INGJndUhPZVlLSS9GSUFhUmtsOGFGL21DYVNoQnduZy9o?=
 =?utf-8?B?SzVINm52cTE0eDF4QzlXZDc5WHRCSlRyazk3THJoTDMyY25rcS9kOG5UU3lG?=
 =?utf-8?B?U3kyODdVMWxZckU3WFVvM2daKzVaUTVkZFZXUmNCSVVvOVJnNHdpKzM2RFpD?=
 =?utf-8?B?bzRyd2RqZ2p6dlNKZTh2THFlUkdYTWlzWXVqVXVoN3hLOENLT2lRQUQ5ZGww?=
 =?utf-8?B?RjMwU3JDTXBIdVlWeHZmY2g4KzFoZEkycEd0OGphLzdHcGxkWU9yREZ3ZUFv?=
 =?utf-8?B?ek5jUlhlRFdmQlBjenZGY1UzdkpRRVpxWVdyc0M5eDdUTXowSUZIdFJFaUV1?=
 =?utf-8?B?aTV4ZksvNy9SYVhUbUpXeTBmbGR6WGkwOU9EcnI3bE9wWFFPWEMwMG5DNUFG?=
 =?utf-8?B?OWxFTmg2ZGp1VkNwL25Uak1zaGN3OVZ1NVArSWgzK050VE1vQ1UzOUlqK0h6?=
 =?utf-8?B?dnB6Y3BsWDBHZUNTeDZ2RC9Beks1aG5pZHRZRlBYaDlNRk9mbmlpZGVGSUJ0?=
 =?utf-8?B?SVNxV2oyd0JFY1ovU2FxUkF0QUNPRDBlY0Eyb2lpY2kxcVNYRkdqaTJlTkYx?=
 =?utf-8?B?OFVnaVpaMVpqS0NBNENoYmo2VSsyTjZ3L1VBbzFGdFd5NHVNWit6M2ZMREUv?=
 =?utf-8?B?SzFCYjRQRmRKM3g3cnlDUVRrK2c2Yjd6b0ptT1lPNFZzUnZ3TnNlZTRCVG5B?=
 =?utf-8?B?ZllQNjYySXRzRWhTL2JTU3lmRTRSWTNWZjNWM1c3QVUrK3FEQ3lCckRiUjln?=
 =?utf-8?B?TWZ2cWcrMllReG9qaFBKVHBMSStKYVd4WGJCVVFhSWlsOW5WQ1NDbkx3cGdz?=
 =?utf-8?B?UFRzb0NCYjFYeEpqUjAxMG1IUXc0UUtTZHBRTjA0Ty91dHdYOWZtc2RIc0xI?=
 =?utf-8?B?b2QvVWpMdmxvVy9oZ3ZKSHNrNlZxY1JrK1dRRmtCRy9FblYrbkhjYzY3TmF0?=
 =?utf-8?B?ZDdhWlo0cHNDRzVxU28yeG9lcU9rR1ZoZGJqZEt3cnd3ZXY2NzBIbFIzOHJQ?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513309a2-f3ff-422e-8df1-08dafb1abba9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 19:15:46.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFDghXF6Hv90Eaqd4F8Ul7RY8R52+yIMbhA0wvZVMlJwaSdS1ncnDPJdXuHRGsCH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3849
X-Proofpoint-GUID: kRDxs5sUSx48NQ7yeZLPRrY4wkpQljT0
X-Proofpoint-ORIG-GUID: kRDxs5sUSx48NQ7yeZLPRrY4wkpQljT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/20/23 9:40 AM, Sedat Dilek wrote:
> Hi Arnaldo,
> 
> I use CONFIG_DEBUG_INFO_BTF=y with LLVM-15.
> 
> Darkly, I remember I needed some post-v1.24 fixes.
> 
> Currently, I use:
> 
> $ git describe
> v1.24-26-gb72f5188856d
> 
> commit b72f5188856d
> "dwarves: Zero-initialize struct cu in cu__new() to prevent incorrect BTF types"
> 
> Any plans to release a pahole version 1.25?
> 
> Thanks.
> 
> Best regards,
> -Sedat-
> 
> P.S.: I still carry this diff around (attached as diff as Gmail might
> truncate the following lines):
> 
> $ cd /path/to/pahole.git
> 
> $ git diff dwarf_loader.c
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 5a74035c5708..96ce5db4f5bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2808,8 +2808,8 @@ static int __cus__load_debug_types(struct
> conf_load *conf, Dwfl_Module *mod, Dwa
>         return 0;
> }
> 
> -/* Match the define in linux:include/linux/elfnote.h */
> -#define LINUX_ELFNOTE_BUILD_LTO                0x101
> +/* Match the define in linux:include/linux/elfnote-lto.h */
> +#define LINUX_ELFNOTE_LTO_INFO         0x101
> 
> static bool cus__merging_cu(Dwarf *dw, Elf *elf)
> {
> @@ -2827,7 +2827,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
>                         size_t name_off, desc_off, offset = 0;
>                         GElf_Nhdr hdr;
>                         while ((offset = gelf_getnote(data, offset,
> &hdr, &name_off, &desc_off)) != 0) {
> -                               if (hdr.n_type != LINUX_ELFNOTE_BUILD_LTO)
> +                               if (hdr.n_type != LINUX_ELFNOTE_LTO_INFO)
>                                         continue;
> 
>                                 /* owner is Linux */

Ya, LINUX_ELFNOTE_BUILD_LTO is initially proposed macro name but later
the formal kernel patch used LINUX_ELFNOTE_LTO_INFO. Could you submit
a pahole for this so it is consistent with kernel? Thanks!

> 
> $ cd /path/to/linux.git
> 
> $ git describe
> v6.2-rc4-77-gd368967cb103
> 
> $ git grep LINUX_ELFNOTE_LTO_INFO include/linux/elfnote-lto.h
> include/linux/elfnote-lto.h:#define LINUX_ELFNOTE_LTO_INFO      0x101
> include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
> ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
> include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
> ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
> dileks@iniza:~/src/linux/git$ git describe
> v6.2-rc4-195-gf609936e078d
> 
> -EOT-
