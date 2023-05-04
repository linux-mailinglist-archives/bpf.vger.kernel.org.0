Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B555E6F7042
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEDQxl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDQxk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 12:53:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE74271F
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 09:53:39 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DO0wF013556;
        Thu, 4 May 2023 09:53:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Kk+3hhFFfLCLk7WLnSsU+xOSStF3W6VVVIM9YW4l9Q8=;
 b=JjNhUfevtGRCWfS2BMSEZvu8JHEW56l4nLWRYsnB8EDceIh/FMy9uU9ZKtZJetKoB+1X
 6+D/+DZHsZDsgU5+5rC+nzyfClse7zp3864b+JN7sxsfbZ4sRbLk7OUZcPHxVaF3q7+B
 UrHXR228hDOMcqA/Mgi0tP+8l1YKICQRi4/6mY6TWu9wByOz5PwDTotC86basObH2AyG
 X3JfQMhWqPz/ZunmALDw64sYyU4lx8qLECSJNcYj8HQRhwzPdNb+se2PoMDNvZTqnsfz
 f5KTxdi9GS0Ps2JwRU5nR/V8u6MNmy7gvSJDUuO0iypu0pd5LmoGZzhUdqCr49/8Qhz2 nw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qc2g1dce6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRx/U/wYVHU1RHRHY2pdRqERlagvSiYOx/ivJghVCpmyTlxW1VJDl0mPMUFtLApWbIaUuK185RniFC9ywDKnMWDD7w7ml+aVtCHF5vRxyoNtWBcxQN8cDK3KTENsTN42yTTQrF3q0qxsGF+8LhPFUURyVQklqFVlvZ9YsI74WkaGxfj7iAQlCgDN3bCSBy7LYkGnhi67XHcRFnzxAoz3x9fgQcYyqUjCGu6cuPIfQRxY7NoqUkCyrhT6BThFbB3ESBjmy7oIDpT+RaeIaIZW6KYFpCAiXp3MU+prwLSY3//XlIOPjuacadQx1AYZr+hM5FTJnCK0kPAnaV/iq++4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk+3hhFFfLCLk7WLnSsU+xOSStF3W6VVVIM9YW4l9Q8=;
 b=JN+YF/tnJuKXGpq6Zw3NfpkwiNTxkRB9k7LuuPEnB6vJsPQOTupqQkI+dInl08W1WZ8LwO4uJj20p61QHqLNdczZg88ejVuwfGgbo/+EU8F2mlwpB2BbPKv+GyCskdy8u9KQXrprjqy+KVXLvJhLwz0ebCwjod8KCHRmrjqbaynr1nIWdzqNS+lYI9iUMyTlN49/b92fP6lVBRdLY8sbRoVx0+BfS/IC3SoKSjYUxqpqpsm2Nyl2WARiJTI9X+fMIuR5AmRbhYU7tJbJ/6O7mMIlufyXpCmCc88ayhvrHZJA8ibsZv2uvdapH2dbYHAH4XUM9TzplT2Yg2fKQwgClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4604.namprd15.prod.outlook.com (2603:10b6:303:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 16:53:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 16:53:32 +0000
Message-ID: <d79d6281-845f-c395-79eb-5963389971d3@meta.com>
Date:   Thu, 4 May 2023 09:53:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: bpf: add support to check kernel features in BPF program
Content-Language: en-US
To:     Menglong Dong <menglong8.dong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8577ae-0819-45ef-677c-08db4cc017e3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkFi7ML1ORu7k92033m3qREk2ykyiuVEETO0FBgiITcHq7kKOA62O0WedULRwzUgLlETaSMOqYM9MwezUezuH4VJ4n3LLHIDjiiwVXMx7FUyo9C6P45v2goPo3YmW0wcT7deWLKSqd0YfsX+HbKMyPZl0peY/cJowDCj3HBJfDVFeR5jR2MkWGVVxmPxr2roEIfY9oPGxttIvqvK4Sb7hosGff0MoQrGGak+21yUX59JQeN3M3uox5OwuwZvlrito5LzCSnyQSaUIqZyBml7P5yyNUBZAj1cbccWeNOSG3UrUVw6jYXAo0XDIKhhIib2d2Ev/57C4/magT43vBdWXx7Ej7wdMkGmzP3zZigzuD7SAW+3lcofWir8Owvm4a9mAqH0ygx3MjWXLnQLd5VhmR33mlS6YghtepuTRFm61NM3f5vGG23xz812If690e/W68Ij8Cv48dp3VZtdY/GhOxCWNAcAhH6dQrJr/5XlXU/62eRtTAQnxcI/VuCtvX2WgDiMmCbf26J+Ittyovb7yzKl3pDsaVtouyBswjxAwSVNRaa+TdVi11To89kN7nk2J+mqIp8GqMJYYakUymFWY7FxgWu+DPhFrsZ7qCeJwmXYLVbiYtFZOmEBxNEZ4kTjroLFIbgAa+X5cVzU810YXkBsPnLB00vSGZXDd8ZLSQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(478600001)(38100700002)(8676002)(5660300002)(8936002)(2616005)(110136005)(6666004)(31696002)(86362001)(66476007)(66946007)(66556008)(4326008)(6486002)(83380400001)(6506007)(6512007)(316002)(2906002)(186003)(53546011)(41300700001)(36756003)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhPaGNwcDVhWTRGQzFXNEdXSXgxcUdJWEwydmVsSThydzloOXBtcXhWa2sv?=
 =?utf-8?B?b0xJcTAwTlRJL3l0dVdERG1EVHRQTjU5YllWNFI4akV3amd0bHBVVk8vNkh1?=
 =?utf-8?B?WC9LOTdZQ2lFYS90ekFvalhCODBxVEVOLzRlZzZhemd4V3kyMVhxMk1ETzNn?=
 =?utf-8?B?UWkrUjJQbXpsdDFwYXdSczl1YWRCQ0lVVTNBUC9vcDdNVHdZMFZzOEtuaUVJ?=
 =?utf-8?B?bSt3S2ZZVUQ4MzZwcXgxRjVhaDBrRldYTDlURm9hNWxhSWVuQzFISXVBZG44?=
 =?utf-8?B?UTl0RTllcHlSczNpRlRsbnJOS1RWcTQzWnVGckpobzF4TnRLdVhxaE15YnVp?=
 =?utf-8?B?aWR3K29CRnkrM084b3FLc05NeWtOQ3NKOVRnSW5Id3RGQVZvdlRCQXpocUN3?=
 =?utf-8?B?VXhHSGJHWC9zSVZRajVwaE15NHJlZ0NIZmE1UlpXdEY0dSt4TnhETmJvemhM?=
 =?utf-8?B?dTVGWGlRSHhONVl6MzVrUUNCcDFtMHUwN1RlU3F3Q2RuVU50M1RIdUVCaDdq?=
 =?utf-8?B?VDJvWjNlNkNVZWZYTVl5Wmxvd1FraEs2L3k1MGRXR1pYNkh2Ymdwd1ZrUUlE?=
 =?utf-8?B?RnE3ZnFzeXpYK2VaNnF1aUwxTU9mUnRoNmcvNDg2RG1XRlU5WVBjWFlUckV4?=
 =?utf-8?B?UWVlMTlWMXFVQ0hTeVU4MERnTURTVFQwVStqU2hvQmhrQnRncUtwRmYwQmlX?=
 =?utf-8?B?WEthemJ6T0hwczdhTEpNa2hMbk9qTUdTY0dkWlg3bmRYS3NaQ0RHMi9DRmxw?=
 =?utf-8?B?WGVFbnhqYmtmb3pWZFdtOExxVkRSMzRQSS94SjhINW5qekUzQ0hzSlBIS1A5?=
 =?utf-8?B?N2x1a3ZFcTRzSG9yUGNHWHRYK3VyZ0hpSnc3VXpJTzc4UC9oNzZOeURkUFVF?=
 =?utf-8?B?Vnlrd3JJc1JSa0dZc2VicDRIUUhHdy9YN2ZaTmR0NlMyNDkvRWNTSVlOTXlZ?=
 =?utf-8?B?bUx2WEFCY01lQVcxdENxbEQ1QU8ydWtUT2R4SWgvTEU3TVRST1U4bG9WdjFC?=
 =?utf-8?B?SG5QdytpNlhLTlUyVy80NTlFbW9ZV2JEQ1NSa1RTY1hiWGVjcFgxSFhWeUdo?=
 =?utf-8?B?N0JSUGFjUnJOcVNsbUZzUzJyS1BHS3B4c2RoUHhDcElRUkZVSEhjajhCNG1m?=
 =?utf-8?B?cXkyVkJaZk52c2dpMkMvb1JCbWpPT2kvYjk4Rzc2WElvUDBzeC9IdzJWdFha?=
 =?utf-8?B?NDNQUUdUQ1VVeklFNWxWemdCMzZLa3FveXRBdHF2WElqdFA3TXl6VGljNHVJ?=
 =?utf-8?B?Y3BDTExhQWh3MndkdXJUNGZ5WTE4N1M4ZXdQOXdDSkNtVXd2WkxVWXVWbWVs?=
 =?utf-8?B?ZCtNbVg4c3p0a2VEOElNQTBtNmU4YVVLZ2VJM3Y3N1VnSnRHQW5sVUo5SWJ3?=
 =?utf-8?B?bUJYN0hyUHM1aXNNZ2xuWWVEcXBkTkdIb3RZL2hYWEpNdGJPendlc04yMFp5?=
 =?utf-8?B?ZURjSy9vQm16bkNDRDNrSUpxU3QySWtMMFFmYVNHOFZZcXMwS0pRZnc5TEFD?=
 =?utf-8?B?NTQxN3hvd0dncHF0a3U1RFhqWlpSaU1mSUQxaVh4ZXU4Qi9Qa2VaVWxLM3BG?=
 =?utf-8?B?WVpERTNHeVZBR1d4UnVmZ0RPbzV2SFR0SEJsM3dwanUvaUhVWDA4eE9TY05x?=
 =?utf-8?B?YmNEQ3BRZUEzZFRDKy9oaVpiVFBvRDE3VXFnRGEyTjhUd0Rod0F2OGEybDBP?=
 =?utf-8?B?NjNEZ3RlaWUyNGovb3dtckNYUkFlRmU3Snp2RXYzQ1BBUlliTWhRUWhaUFh0?=
 =?utf-8?B?d2VpcFlLVklGT2xtci9saFFDOEQyMmdLMmZXdjdRazJweWttNUpMZlIxK3Uv?=
 =?utf-8?B?MExra3VCU1BRUVRGZnNOTDJOUm14d3VKdkJmWHFlQnFnRXZqMXl3NFdvQlZj?=
 =?utf-8?B?L081WnBaRlg4eW1PcFUwTnUvZk4ya2laWDJudTVDaDVDNGt2TnhXZlNDcFBl?=
 =?utf-8?B?S2ZxNlNHK3UvYTJxemF1V3FEbzlXTG5VaXFkTTNWd1UxQ1RrUEFFeHRUWkti?=
 =?utf-8?B?a0xZMExCSytCUC9udnBtVG9VTU8xQTNUVjdCZ2ZEVzFEQnlla09JVHM0dmN0?=
 =?utf-8?B?cU5UM1QxU2Exc1hWV2YzbU1TNzZhakNYT0pEMC9VM2RWS0E4U3RBS0t2OG1a?=
 =?utf-8?B?SG9RaEFHSCtyN205K0YwenlBRHFSM2x1RVBCTEVJcjV2eXZvNitMemt4U3RC?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8577ae-0819-45ef-677c-08db4cc017e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 16:53:32.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lndh7zdHRIBR6kpedkYMoE2tMjniHYbx3qv7fEdPeGMtaocDF2e97FDNnYJjdtK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4604
X-Proofpoint-ORIG-GUID: VC5d6itEjUCJOluk3qZw04rcLKIksnTv
X-Proofpoint-GUID: VC5d6itEjUCJOluk3qZw04rcLKIksnTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/4/23 4:09 AM, Menglong Dong wrote:
> Hello,
> 
> I find that it's not supported yet to check if the bpf features are
> supported by the target kernel in the BPF program, which makes
> it hard to keep the BPF program compatible with different kernel
> versions.
> 
> For example, I want to use the helper bpf_jiffies64(), but I am not
> sure if it is supported by the target, as my program can run in
> kernel 5.4 or kernel 5.10. Therefore, I have to compile two versions
> BPF elf and load one of them according to the current kernel version.
> The part of BPF program can be this:
> 
> #ifdef BPF_FEATS_JIFFIES64
>    jiffies = bpf_jiffies64();
> #else
>    jiffies = 0;
> #endif
> 
> And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.h
> with -DBPF_FEATS_JIFFIES64 or not.
> 
> This method is too silly, as I have to compile 8(2*2*2) versions of
> the BPF program if I am not sure if 3 bpf helpers are supported by the
> target kernel.
> 
> Therefore, I think it may be helpful if we can check if the helpers
> are support like this:
> 
> if (bpf_core_helper_exist(bpf_jiffies64))
>    jiffies = bpf_jiffies64();
> else
>    jiffies = 0;
> 
> And bpf_core_helper_exist() can be defined like this:
> 
> #define bpf_core_helper_exist(helper)                        \
>      __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)
> 
> Besides, in order to prevent the verifier from checking the helper
> that is not supported, we need to remove the dead code in libbpf.
> As the kernel already has the ability to remove dead and nop insn,
> we can just make the dead insn to nop.
> 
> Another option is to make the BPF program support "const value".
> Such const values can be rewrite before load, the dead code can
> be removed. For example:
> 
> #define bpf_const_value __attribute__((preserve_const_value))
> 
> bpf_const_value bool is_bpf_jiffies64_supported = 0;
> 
> if (is_bpf_jiffies64_supported)
>    jiffies = bpf_jiffies64();
> else
>    jiffies = 0;
> 
> The 'is_bpf_jiffies64_supported' will be compiled to an imm, and
> can be rewrite and relocated through libbpf by the user. Then, we
> can make the dead insn 'nop'.

A variant of the second approach should already work.
You can do,

volatile const is_bpf_jiffies64_supported;

...

if (is_bpf_jiffies64_supported)
     jiffies = bpf_jiffies64();
else
     jiffies = 0;


After skeleton is openned but before prog load, you can do
a probe into the kernel to find whether the helper is supported
or not, and set is_bpf_jiffies64_supported accordingly.

After loading the program, is_bpf_jiffies64_supported will be
changed to 0/1, verifier will do dead code elimination properly.

> 
> What do you think? I'm not sure if these methods work and want
> to get some advice before coding.
> 
> Thanks!
> Menglong Dong
