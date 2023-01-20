Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6E36760D9
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 23:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjATW6u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 17:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjATW6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 17:58:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5E21A20
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 14:58:22 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMuoI1025535;
        Fri, 20 Jan 2023 14:57:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=cAlLUmyYyOMFlpmVpRzyfjxLfYPrHu6W75uGLaL/Gfo=;
 b=jt4tDjNrWz7oL8V0mq5O5YqGu3nT8V4tUqDq2IIwUDie0sU9pw7foDEr3CguRuJW74SZ
 x9RiBLAVP2VPeaPXUaJYvnTIV4RzAcsXX2TknK+LNIbEC9x9JGwJTWUDkMlf6yyg37f5
 clWL0W9h9fMkHfQu+AelsMjV5V7D3Xqjv6M5rj/aTuJRRW8IyydAI9J9BW8t9eb5i+OO
 60t8HGVacqxzNLZwk4d2uBrTpdR7ws2du0A9q84UpdCOYSSUEswxPoVES+pRheNxQ2ic
 YYA6EA4odfcZUNQLXgJMceC3mdfonT5aCYW6PZ2XBZv/AI484KcdmD3UIeXbZoQ1AFvp 7w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7ycmhx3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:57:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXJYenHF8NiR3T7oX69sBbNFCTi/PZRDZiZRe+MfvZsZlYbUmQgMrfc/vKHKuYWIcP+ljTnhfcKI4zI+EFaQ7skX0ayytqrUU7LIi+LgS8t9uBqyseMypwT+Fd7Xpr08xzTvCf0mmklgLKEdOrOvGvjg89JYEoTzMnhNjkZL5Ua88XJoS3gdsSXhp1qGjH/J6biPGk2CPokr+O5nL6TPIbVGzA/mJFXERbpd3gRXpJToD/L6ncgLlG2oAW+15ZZ649YypVbxz+4We2HWuWuMj1gNkQ9FAgeNx4uCYOjtYEDH1LDPcRkEwDO6rM+cyTx1iY1sFOjM+Bt7rY3VpigZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAlLUmyYyOMFlpmVpRzyfjxLfYPrHu6W75uGLaL/Gfo=;
 b=k2GnQebwwoNRl6MovP3aAm4MsMosQNZfAN1X9zUyATp8T7RVCZueCeWJcKZM8ex05KdjIY3TvtgtgKL1l7qBk/f+q4cXuDMKeC+Ct+qDUgkqb4oE9TOm9/NeS08if1MLorIe+y03WDVM91sKVpXo9xeOc+3s9uQSaN1tn1tzKO4FAvI39ZnJo7dd5y8fO11oq/I/DGfg0UhaiaBgKm+bffRZJA+pZKsdZipDIp3Q1EpNiNxM5/EVvN/hZTXCeiXiK0Ki8CSiTIH9mqAOiVN04Dcp41iH6c9ZyEdDmVb5T00Y/lBaiDxAg+tbm/GIzh53MYfuaZFGlPUZmEkwcO6yJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6220.namprd15.prod.outlook.com (2603:10b6:208:477::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Fri, 20 Jan
 2023 22:57:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 22:57:57 +0000
Message-ID: <3a095035-84c2-cc60-83c3-d6998bd30361@meta.com>
Date:   Fri, 20 Jan 2023 14:57:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] dwarf_loader: Sync with LINUX_ELFNOTE_LTO_INFO macro from
 kernel
Content-Language: en-US
To:     Sedat Dilek <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
References: <20230120201203.10785-1-sedat.dilek@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230120201203.10785-1-sedat.dilek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 5043f653-9bbc-4e50-bc0e-08dafb39c544
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHO26VtlXsaOzQnZ+EYuZhF5fmEuySXZU96/aCXJ9FZ2SI8cvM9PsQivaKKHsu1hFKLXc/p10ckf+Wlg4kK4ldLtEC5//YPLZQpaOTQMF+dFfznbMkB5pAyBI7OXYmZnKOJecJXBGnprAivedCVQohEzeTRbV0a0fP047idEXKXEkAGQnnFKqOH1l9isCl7D8lpvhcjch7WR7I6kUwmBjAaFrgKFP8/4XeAats760Jvys/aoENd/Cm95xM33hsZHbwsL2NaQIOX+PkLaT25to851Ow/6FlKsVdWQ9dLkj+oRxkJEqtCIVgYDeMUYhZnEJsc2ai9i4CO9QszCp3XM/BVaDBowzUP8jgvONMAd/8NvqG1bn9p3IZlsmhh15tRW+/gidAAzxWCeDBAlYDRSCwHB0TPUl55W0tj9IFI6gEagJTUTPoFY6J40K55R+ULD9ufhtpucGf6BzzdSWCnMMeNCn7PXpX7cIFoYAU1YzKDyqhBohcn4oxEtCxmht983yrefj+pPll1rKVipMPOLCoeK9diEmQRKdK3n9iqVD+leYe3n/ht/E4QDyWyjXVq+Opqlzm25hgXt0jdc8Bn6ahuDWTpk7rkuLmlVjC5z6G1HWCYCzTRWvQtBeiSpHkNRWq5s9qVL5gGS/nQlvFSTaCnRbVE7Blm/6u0FlPVnTaV1pQurC0p+dizxyV+tIdzJfpw6bIkSgRzPKbuG1KY/9Mt6zRpYSHdCKgTgX5grzHByKS6lhpw3RkpJ4MtHqHB4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(6486002)(316002)(31686004)(6666004)(53546011)(186003)(478600001)(6506007)(6512007)(110136005)(66556008)(66946007)(8676002)(5660300002)(41300700001)(66476007)(83380400001)(36756003)(8936002)(2616005)(2906002)(86362001)(4744005)(7416002)(31696002)(921005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG5jREJsWUtVYWttOThEMUY4cEZQb2JXY0NEQlBUcktlbXBEWXJaUmkxWTVN?=
 =?utf-8?B?UVhyOFlLeWJjSzMzRU1kd1M0d2ZveStXdzJscUhlN05BcVhGdFQ5dVJRcVdw?=
 =?utf-8?B?clJpTXpFVTZXTTI2eFRYelJneXhuYTFyVldYekRVdWx5b0MxcnE3UVQ4a3JY?=
 =?utf-8?B?RmdIR0MybTdhY0lXSzIva1YzK0JQQ1JLN2RKeWFudXNYUkdSRGZ4Q1V6Ti9r?=
 =?utf-8?B?TmJoZ3BFdGZaTDA1NlQ5NVNtMnBNczhONXJ6cE56dXBaK1MvbTVPVS8yalRs?=
 =?utf-8?B?RjBqR2E3dTRaUUh3VUI2dG4zcTRiMXd6UFp4eU52QUhHN2NwNndORVI0T3FP?=
 =?utf-8?B?TU00cWxNMDc1aHFIV24xWHlUcW5BV0FkdHJwQmlacFZEeU94VGRTSFF6RDc1?=
 =?utf-8?B?RTVERzJWbW1CaUpQUFpJOHdBVWpFVWYyU2ZwaHJvMzd5bmNoOTIrR1Z5YWRi?=
 =?utf-8?B?SnY2Y0Q2Wlk5YXVVSVNZM3lTcDRIdVVCdDVDazRObzZGc29UMnpIeHlEUFJH?=
 =?utf-8?B?Q0tIUjV0eW1tV2IwOUpuM1QxSHVwdHo4VVFIRHRrM0l5K1R4Mi81NW9XRkJm?=
 =?utf-8?B?VmJGZ05aQnIxY1RDcll1Y1lSRlpEOVcyZXVvdmpHQXNLbjNoaDN2bmp1bFZi?=
 =?utf-8?B?c1NUbnZQbWpwLy90SFR3MEFSajY0T2l5SDFyTEd5aWVLUHZqaWlvU2hSYm00?=
 =?utf-8?B?cTdmR1BtWUFvOWNUUlo1M0xpeS9Xd0daeVp4RDJWKzdmQnhadjA5bFd0Mi9q?=
 =?utf-8?B?RmhPam1zK1dkMFZEVzMvYkN6eGdMTTV3TlU5bEFhL3cwLzdDQm4rQ1ZGQk5K?=
 =?utf-8?B?cE5yeUVaRXRRb01udk9Ia2xHYXJCQ0hJWWRxM00vdU85NXJnVkwzNm5FcTZs?=
 =?utf-8?B?VzFHL04ySGkwZUFkeTVRVWwxYW9OSFQraElLb05vRnd1VjUyZFFHKzhWR3RL?=
 =?utf-8?B?UDQza0xxQjlobFRSSEdvSlNXak9taVRPdXlHS005UEJLOHFDdTlxcWhKa0pM?=
 =?utf-8?B?NEp2aEdLc045b1pobmJUMnpJVzVrS3h2bVE4L1dvTEJsVEg5MXUyVXkyc0Jo?=
 =?utf-8?B?RjA4TXEvQjFRdGZzUGxlaUltY0wxUGtKV3lyZFJpUmN5QlhLRE03WFg1dkpB?=
 =?utf-8?B?RFdMTEVCa01IL09oRUFYVEJtdFJSZGNCWTd3UE1DZ1F5b0NFQ2lydjZmdXV1?=
 =?utf-8?B?cE4yOWltVnpxaUVGVCtPSlZpUTR2L1hYUVVaWUhXTVQ3bVZVZW1WeWFUNkNB?=
 =?utf-8?B?SlNURnlxVVhQWXpJbUdPUWYxYW0waUtpSk1vSkFzNTZCSGFUOTdoUHBUWlRR?=
 =?utf-8?B?Y0R2T0FnbnNCRG5ZYk8wTWdqbGJ3YmpvK0hsYnN4a1RibERMUWxTSnVZTWZM?=
 =?utf-8?B?WVJ2d0FPbyt3SjVJZENqdkNscmw0UmJ2NEdJdFZCdThVWGZUNUNEcG5GeENp?=
 =?utf-8?B?djU3R1BmOWVMMWpCL3VhMDBkS1Z4dVJLS1kwd0haTE5jTVgzRmhUL3prUmZL?=
 =?utf-8?B?RU40MytUSHcyejRvaUgwOTF2NlRrandUMHk5VXpwdm03anJLWHF4cWdQeGZE?=
 =?utf-8?B?RkxnN0VML1pJTEtqZWZXVDBpc2Q4TEN6VlpUeTVhVkY2OUxDK24rbi9rTTlx?=
 =?utf-8?B?emxXWnZaWGtpRFBEN05NZ2VnOEFiWkozbDA1VHBSU1ZyV3dGTkpqa21QTEtR?=
 =?utf-8?B?eW00QkNTTDBVRWp0WFZwaVlQTmFsaHVNWS9zNlk1U1VUdXdaVWJmYSsxMy9K?=
 =?utf-8?B?eEw5cDlnaDNjZ3VXdTJzQ29DUmFxbDNxQ1ErUlBVWTZ3bWtrV0F5R1Y3eWxP?=
 =?utf-8?B?UzFLQ3I4UVF2ZGx2dkFUSi8vaDg3SCt5ZGRBYlk2MDJJK0NYRnljRmRpVnhQ?=
 =?utf-8?B?QVNpYS9zZTMyZUxjS2VKVDNRWjA0WWxMVDVManI3bUlFdWV1T2FsdmJhcCtW?=
 =?utf-8?B?ZDZMTDcxU3dDUWtTRno5alRnVTBkWTNZNDNTVkdKSXVvWFBwdGVYcWpXVGk0?=
 =?utf-8?B?U0xsZFQ0SnRRVjcvbVp5NG00ZGVmelFWb2RLVXBKWVZhaG5qVGpjTFUzVGJM?=
 =?utf-8?B?a0QraWdIUHRHejFCNi90RFR0ZUdodC9IcUlQZ2g3RkwvZnBOKzVFVEl5T2du?=
 =?utf-8?B?ZXplaGhMalZJM2FIWkdRcHA3SkxSRGFLWldXajZ1bnpNSk0zYWIxbUhtdFNi?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5043f653-9bbc-4e50-bc0e-08dafb39c544
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:57:56.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lgWeyVofhPgIZZ5eaD6LkH8eLgVf38MBUSAm2wqQ1rOtkU2MOCWzAN/K04vWe0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6220
X-Proofpoint-GUID: yXpCIc389HwDenDkKWVEhY8AWO1SSiuT
X-Proofpoint-ORIG-GUID: yXpCIc389HwDenDkKWVEhY8AWO1SSiuT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/20/23 12:12 PM, Sedat Dilek wrote:
> As long as I am using CONFIG_DEBUG_INFO_BTF=y with LLVM/Clang
> I have noticed the below macros where defined unconsistently.
> 
> See here pahole latest Git...
> 
> [ pahole:dwarf_loader ]
> 
> /* Match the define in linux:include/linux/elfnote.h */
> #define LINUX_ELFNOTE_BUILD_LTO                0x101
> 
> ...and latest Linus v6.2-rc4+ Git:
> 
> [ linux:include/linux/elfnote-lto.h ]
> 
> #define LINUX_ELFNOTE_LTO_INFO         0x101
> 
> Yonghong Song says:
>> Ya, LINUX_ELFNOTE_BUILD_LTO is initially proposed macro name but later
>> the formal kernel patch used LINUX_ELFNOTE_LTO_INFO. Could you submit
>> a pahole for this so it is consistent with kernel? Thanks!
> 
> Fix this by syncing the pahole macro with the one from linux-kernel.
> 
> Suggested-by: Yonghong Song <yhs@meta.com>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>

Thanks!

Acked-by: Yonghong Song <yhs@fb.com>
