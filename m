Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D84CE6B0
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 21:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiCEUHv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 15:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiCEUHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 15:07:50 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56EDE79
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 12:07:00 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 225BUODN004990;
        Sat, 5 Mar 2022 12:06:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tLK4hoqUPT98fM+Gn1a9UOqBN8FWvYD1hooQ+iIvS7c=;
 b=VXp5tJg4bBuaKMF3yxrcODeSbWYdb0EUL/VIXhPKQ0tbm7atzkt9M9jWOF5SQwzwDizz
 ZNMDn7GhxvfTr5ysAjbv3yDVdFGe3YaK7GaRzJdBSVSDHigFGWxTxLExAQUmoveJ9d8h
 ZGjZG/pHAgfK3XkssutOCe9PteC2GiIi76I= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3em6es1shc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Mar 2022 12:06:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrujQUJNvFxpKqFH7nBuz7f6TvBf06kdZwPOkVD0DfLFjAbB4Bd7cxPEgAV3ZtNCX/9qvfh6xUr29Nh6A2jLDqOo30imXEKguQFFZHE0RP62nvkg4m0yilXTdg59t67Ny/XBsyJSbra4Flv3Jfrc/BADAMPKDjr1K3o206Agoeb0K5jyqEJqPQhpp2tqIm0QJNlk2H68pNE/7TifENbiHR+D19mrmEd01p5WPwfD8H/s/KvhgRsAXHJMNxOP2XUepKZKRfFbpGw8neLnOt5VQyvK5aiMWLP5bAtcM8RE5jYkMXIYIsG4Fu6ieTB00HdZweQHqJJgE5dMKUT0EIpxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLK4hoqUPT98fM+Gn1a9UOqBN8FWvYD1hooQ+iIvS7c=;
 b=br/BV+ZE//Em6cBJ51PG9FtfmMKnFuYa/69ImjnuCxu2Fjw9EgpG53omMllvSmeWn+NDrt2tFOgEqA9OSPBMo/So1vPXygWl0+aYgHMiXRznVa6eaoFZSbxjLwXSuhQbN2VnlhUK1vtRzxyiUCimExQ0NjLlvvA4Mvz9zCF0uBEelxxh2Smd3zfCA4P67yNp8fBHxPHoHn1NyQHPNcdLiR90nCjYYw9cdKyPmp/7oPXQPn7Yzrw6O9I/ZmmTR9HeOgQNZqcQc8w0kzBN77qQQRz+u/WZQZTChyePQIOkzkArqXUEC3dDNGm8f85qVx6uOSIClgra9vvLMo4F+CHkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4361.namprd15.prod.outlook.com (2603:10b6:303:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 20:06:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Sat, 5 Mar 2022
 20:06:42 +0000
Message-ID: <b1d5ef55-dec1-12cd-6899-19d4acaf356c@fb.com>
Date:   Sat, 5 Mar 2022 12:06:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 2/4] compiler_types: define __percpu as
 __attribute__((btf_type_tag("percpu")))
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20220304191657.981240-1-haoluo@google.com>
 <20220304191657.981240-3-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220304191657.981240-3-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:300:93::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9319f320-69c3-495b-6e46-08d9fee3aaa9
X-MS-TrafficTypeDiagnostic: MW4PR15MB4361:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB4361924A3191E50E19D7CC78D3069@MW4PR15MB4361.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vek2CIdR6p8p35GH71X1LM4lukxUR1xtADiHCJdVtHMhkmVbGvTqy23L4rIGDFj2o0gX5d04+KDGS3po5SsztQw+FvIm9KjlT56A+/FwPnzTgDYZVN1IF0EpxIif6MBYIGsVWybOqvX+J8bDdwHRToYPDhcx7k5XtaKxl4a03GX4SIN8KYJ6ezeyecIrUukm1k5LxiSC9+2sxWvwMVPXsCUfqvSjZeWW7964urEABkQHkLiFEO2uBOaE6C7KH+nAoZTEnrx1dIOSfRIwr4le2vtE+CaN3UKfqu1ClZAMyAyhWDb2lcXBtp80Hp8R17Doy0puJL6+lC7UkFEtBr8hacsJV7khYtBuKVm0CY6qbhQgtRMdAjE0j5s/10IaVLhRYxi/K+XxC+GU2ZHQPKGVMbQSgTejgNO6YzAXKkZsQnhImxlS9wLadUF650L7/7FFtyYtcmmPUeX/y/DxmNGn5EffAODeV4tFuIf8Ghc0ce2Sq/WZHR4eEC/CbvG3Du+dvULnEBICVgCvoXCsObbXlO97gg7jVZ6aNtN/zA1VbLfaZJR8ezOgUa/gDpTDIK5CI8RkKEqgkNICSaeMqDG8g+9R/EfDu4Notixrpr+Dkxs5ZmM5BGjmDKC65hSMNqspigcCDZSsnQsblXRilDoaMj0baXJ2vBipqKK5ZlCaP/j4oS8H2V73G/la292hmX8yMuVeAtHtWDrwrLbpEA5B3ivq4jyRGOGzB9T6qytSoYJiAEqe4drT1e55LHmjKLSt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(86362001)(6666004)(316002)(83380400001)(508600001)(31696002)(6512007)(110136005)(8676002)(66946007)(66556008)(66476007)(6506007)(52116002)(53546011)(4326008)(8936002)(36756003)(2906002)(2616005)(186003)(5660300002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azQram5qUWtQRFByWDdaR1pRMHlFRk0zdFVLbHJkeURDS2hldTlNalZmcTZR?=
 =?utf-8?B?dXJkK3FNTWZDU01LcVpNUUFXNHU4VFpNYWtmSzIwdkxCWTJUS2xOcXJTWnhm?=
 =?utf-8?B?bE9XWjRzdEhVdEgrRHBhWEtvbmtwcUR0aklnODBHY2RvK2YweXhZRHU1WVZY?=
 =?utf-8?B?Ylo1TlZBSFpaSUc5RDAyc1hvTHRURnFxUVpLeTlPSmtEaGpXcUhFUlNPM21G?=
 =?utf-8?B?UWdydkJDOHBya3JCYUNIY3NPTlFQTm9xS25vMXBWcU9NK2hBRWwweW5tMnlr?=
 =?utf-8?B?MEUxaXRReEpVaTF6Sk9rWWlsVHhKV1F5TnVGZllPNkU1dnFsWDE5VXNFTnZW?=
 =?utf-8?B?N0oxTW9NRVRHSk80aFpaWDJwcW1zT2g0cWpUdldBMURhdVdGKytkTjZ3ZHY2?=
 =?utf-8?B?RkR6R2p4eTFJTm1ETHcrRCtIQXNGbHFxalJzUXVMdkhnNC83YkNiYkE3NGg2?=
 =?utf-8?B?bWwvL0tMd2M1YXhxMWdNbVVpTkJYR2VId0loSnlqRktUT3hoNVFXcFRhcmNI?=
 =?utf-8?B?Zk9HY3ZjU1dCYWpvZEZZdGU3VmF6aWxuRTZLTDBZaVdTUkU4OEs5VUdFQjRZ?=
 =?utf-8?B?dHNqdGU4S2NxK2I5N0hOWUl6aXk2MFN1c3dqaXdQdnhtT3JyQ002N0dRUms3?=
 =?utf-8?B?NjFrd2lGeEhzYklpd25aNkZ3RHZ0SFNwUGdXNWRHVEZ0NlZ6VDFrdlJ1Vjdy?=
 =?utf-8?B?R2pYSGo5UUhXNVBCMjJickNLNmhhejk1cjkrM0FNcDl0L3pxbE9icWJvRHNK?=
 =?utf-8?B?aVY4TmhUZGd4SngrQURSQjd4a2RiMVl3Y01aM2pJSVcwU2F6djRZYVJOVFlF?=
 =?utf-8?B?WXdPR2RUbU1PNTNKZ283VXAvRjd2ZkVXSFJ5M3NzZGVlb1pMWmxSZndkajRH?=
 =?utf-8?B?THBnWFFFTDR2clJ4OFBJMVN5OVRMZXM2UWVkdmtXcWY5SGxDcDNrbTNIalFq?=
 =?utf-8?B?NkVpRTgyc2YwU1ZSSTh3QXZwcWdua1ZkY2hYN0VSWTNNU1ZmUjdxUXBvUjlK?=
 =?utf-8?B?WjZtaGdtMUt4NC9Ud3dZaVBlY0gyYTcxa08xYmRJZzlreXVzZ3lDZlY3NXFE?=
 =?utf-8?B?REN1TUo5VFdWVFhwcXNNTXdWYjRLMlFaM2I1YnZxaWpybnhTN0ppR2xxYTlN?=
 =?utf-8?B?TGU0QlpMSWpscjMxSmxoRVhVdEZRZjFhWjN0TlNKeFB4N0dDaU9xZkMxYlZU?=
 =?utf-8?B?MHVxOXdNTnpMejFVdWhraVZsK2p5NjU4alB3UkxFYWIvN1pvNDZ5Ym13eWFj?=
 =?utf-8?B?N29kc1paVVpQQjJjek1TL2xvNWx6aG9WT21aL2xreFNKZDZQQlF0ck5lNTY5?=
 =?utf-8?B?ZXBmYVdIcVBRR2p5a0U5UGV5MHdVaks5dmovWGN0MjVtTlI4K2JFc3Y1VFlF?=
 =?utf-8?B?Y05aci9Nd0ZPWENiMTRPaWdiNWpKTHBLZ29CN1N3T3dvSDVjSkdXblpGM3Ew?=
 =?utf-8?B?MlJXMVBoWkFqTk1XeldwbFVZeVF5TTQrTFN4bGl0SituZmxGZFE1MW5CYW8r?=
 =?utf-8?B?QVdMUzN1cmdSYmpEV2hVWjYxYnZ4K3dtRTRScklDR2hBZ1E5WEZESE92Rnhk?=
 =?utf-8?B?TG5OZVkzUjA4ZlpkNTA2UmY1WWZwMy8zd01PbGo3NjZaNTFWT3BUbFBKL2RU?=
 =?utf-8?B?aStWY2tvN0N6WEpRWmNNVnN0cDJsUGM4bEVpWHVMcURweUY5VytSNkZ2ZEhi?=
 =?utf-8?B?Q1lYU2I1cUpneGcxL3h5c0FKSlRlZURTUXNLVFVmeUxhREpCTm8ydHh4M1gv?=
 =?utf-8?B?WmlHNkJGRDRzNkVCSkRMS0hDaURYbUlta2dXYVNlVWhZaTd5WEFpVE4rQmhT?=
 =?utf-8?B?NEw4cmRxOUNDcjd3eVlyTklNaVA5cDVJeExLVXczRHZZZVdNREZ4WVZ6eHdz?=
 =?utf-8?B?STlHZnB1enBKczZUajRDTW9ERStSZXNGLzlRWHUybmFzOEJuY2pselk2SWFt?=
 =?utf-8?B?N2ZncmJtQUNZNXIwZkV3SzRZRjdWZnNvSk0vTkx5Y3JBcTM2VnNkU08xR3Vu?=
 =?utf-8?B?ZTRNOGNrVTNvYXcyRTFMNHZXOVZqV2tjMnBMNVAxemlRUVhDMC9xaGJzbUJu?=
 =?utf-8?B?YUIwRGRoZ21sWUY4S2gwUk9GSjZLczlMK3ArdDlKQm8wNlR0V0VtU21WWGo4?=
 =?utf-8?B?UmpKMi9VdkI4QlVmM1czUlRqSzd2RkptTkdNUGlqTUhiTmFHeFl3d0ZINHQ4?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9319f320-69c3-495b-6e46-08d9fee3aaa9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 20:06:42.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bso9Sw40bCbkNTmw6F2dtZd49SIZ6zzAf+j4sQuKoZdnQk5KUUQaDPTmCnyat6Rx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4361
X-Proofpoint-ORIG-GUID: eGTjQYAYlHexyuD-Mos0D-oW4GYi4jMD
X-Proofpoint-GUID: eGTjQYAYlHexyuD-Mos0D-oW4GYi4jMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-05_08,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/22 11:16 AM, Hao Luo wrote:
> This is similar to commit 7472d5a642c9 ("compiler_types: define __user as
> __attribute__((btf_type_tag("user")))"), where a type tag "user" was
> introduced to identify the pointers that point to user memory. With that
> change, the newest compile toolchain can encode __user information into
> vmlinux BTF, which can be used by the BPF verifier to enforce safe
> program behaviors.
> 
> Similarly, we have __percpu attribute, which is mainly used to indicate
> memory is allocated in percpu region. The __percpu pointers in kernel
> are supposed to be used together with functions like per_cpu_ptr() and
> this_cpu_ptr(), which perform necessary calculation on the pointer's
> base address. Without the btf_type_tag introduced in this patch,
> __percpu pointers will be treated as regular memory pointers in vmlinux
> BTF and BPF programs are allowed to directly dereference them, generating
> incorrect behaviors. Now with "percpu" btf_type_tag, the BPF verifier is
> able to differentiate __percpu pointers from regular pointers and forbids
> unexpected behaviors like direct load.
> 
> The following is an example similar to the one given in commit
> 7472d5a642c9:
> 
>    [$ ~] cat test.c
>    #define __percpu __attribute__((btf_type_tag("percpu")))
>    int foo(int __percpu *arg) {
>    	return *arg;
>    }
>    [$ ~] clang -O2 -g -c test.c
>    [$ ~] pahole -JV test.o
>    ...
>    File test.o:
>    [1] INT int size=4 nr_bits=32 encoding=SIGNED
>    [2] TYPE_TAG percpu type_id=1
>    [3] PTR (anon) type_id=2
>    [4] FUNC_PROTO (anon) return=1 args=(3 arg)
>    [5] FUNC foo type_id=4
>    [$ ~]
> 
> for the function argument "int __percpu *arg", its type is described as
> 	PTR -> TYPE_TAG(percpu) -> INT
> The kernel can use this information for bpf verification or other
> use cases.
> 
> Like commit 7472d5a642c9, this feature requires clang (>= clang14) and
> pahole (>= 1.23).
> 
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hao Luo <haoluo@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
