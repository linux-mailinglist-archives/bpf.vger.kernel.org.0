Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3175884E4
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 01:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiHBXv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 19:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBXvZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 19:51:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E5553D06
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 16:51:24 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272Ni5ew025716;
        Tue, 2 Aug 2022 16:51:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PbRIRgm1CpJ0JNiJvhHr0/KJQWbCvelN/URDtbkqnrQ=;
 b=l8Zoq/wD5hHOyonVTp7NHemCdd826nfEDfmyLy4fa/hyKY7+vB5Dyh1V8bwBBN3HM2gd
 I60H96rN6p1XUprQKO+BH5mANps3gS1acei8AMHtIzzf8K5LV6F0uKU0sOsJRRYHasUE
 wPArNErzACPaXxhIvKE7+0oIQevXZVqhcVw= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hpy32e8t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 16:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgC39qr2Kp6QPlDjZW2fL0vr5+W4lR4GhD+nv0gbtSYEwyGW2x0OsjgQOkdcXtgomVhy3wzz/J0K+xqP0CjWt+C6gGY8BKvBIjo6xlgImpK7iuJqK+tmMCFAYSI9xZC7x3nclVNphWGrEKqz///pAYnOtvonyyHlA3jUUtH4geE+wY6fynMj57dIIVwBpBn+4G2w9jgIdxUcsLNUgfXy0KVk66zgxtjj5TXBshLRF1N9Tqcts9reXyblTdQIdFIXqVAwXHjrnimgM5ezWhtVbMbePEBWRWWVQu2rVImeCf7Oer+VygXl3aDQ8SuswMYE6slSb23ltrmJE/uX0Zlh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbRIRgm1CpJ0JNiJvhHr0/KJQWbCvelN/URDtbkqnrQ=;
 b=ek01CG0Ncx8eP9C0klIk5GyXiE9OROCVix6GzSsJrbXF+wCj+X7iIGCMUQBLzotGoxp/9wqSYDDzC4dXfUGrGbQAVUy7prcUA3JCf5ZAyP47QgBUCCr2qwrm60dNGhSLNPZUVtzFUnw0FhNB1CuTHFxKDvppl/WPgjoW9+JtK2auo//HL5Qrsk83oSV/HKTh2VOhhr48EuuWIC/DPNDIhn9WzDXb6EaI91G8b0B0l09yc9tzbrYkpwjqZKW98PQxqladEqjzpEaICDtBaF/yGfrhn0TVLHBmxw6Eak/0S6Z59ZyIhmPGvgEd2hlOKfWGE9iMJNx6OMebdfJA9aLcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB4074.namprd15.prod.outlook.com (2603:10b6:303:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 23:51:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5482.015; Tue, 2 Aug 2022
 23:51:00 +0000
Message-ID: <d99a2505-5b7e-6b5e-0f41-1c4189d32e53@fb.com>
Date:   Tue, 2 Aug 2022 16:50:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2] BPF: Fix potential bad pointer dereference in
 bpf_sys_bpf()
Content-Language: en-US
To:     Jinghao Jia <jinghao@linux.ibm.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, mvle@us.ibm.com,
        jinghao7@illinois.edu
References: <20220729201713.88688-1-jinghao@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220729201713.88688-1-jinghao@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 587ae6a7-f0f0-42a6-6218-08da74e1da10
X-MS-TrafficTypeDiagnostic: MW3PR15MB4074:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9YRlouR9wF+RqhqtwPGjAn40BOPidtDlIbwDgzHxIpw3/OpHgZ4mgtN4SvCY20jCE4vcN3n3CKiQgpThJmaEcrZrI9WwZ/TperYr13f9KkgmLmV5KQE9SVXA4BKcNO8o25ZIjMgBty7vNRr9zQ6S2j6/ag/aKN22JlE6is8D3UVAU4Cfxe2ozFEvkuUvdr1Sc4dYa7W7luRxVo4NFYvIMzi7+Eflz7OuA+vuTUkoY0O3itcIOXtqoOY5FfBR2Phe1LCxjMuoYDGpwewS4zJtIljOqv+zCDBdV0qkDLr8OjG8y4FsmZ1R7ndEOPZIJSN/R+SUFRYm78S3a/IwfkNcwkEa4hFwh9BzKGf5ldqGLyrd96qoS3qTGfKq5+JUs5tyhmDoAFOWfsaIjDUy98jSY78+QVWQr3SWg8diPfcFNY//23YG2I/omsJmcRJv9qjaVAZj9IC83a5qnNiQGEuHf/3cf7StTM/ndFQGdbeEEdXoyqcaT8MHU7mE6kv1IqmI0JlKj6bLQBgV+ylu6W/9jEQH9m/KGf9hiT/UtEwi1J/j7l/l0rxBKoh4F50/fd31fsoLywYdody5rrJOqM03bbCMxJFiC/c3JI2kzBZOuukbw3bmkJ/sxaDItQrwaXPtc1vuQJlnlHXs3P0tNjkwC2cpNPmr4bX5YnBb6qDCYylnsRQUwZhg3/yPyt96ZrRrfI63GvfSs1p6t5hLWms5O8yEvc9Ps3c3QArZTFflJTtQ0JK++Buy6VUFNh5+OL2eyNlm71rapkAuIsEjMbdaJtdpdsZNKiWNUCr8av64Ltoo7C0RISt6qlY0dIGdY6SEnU/lTOzJzrNfflAtFzI0QNL36h94TO1s30VLrBPEw7pzXS6AigUXP26FBxS1lLM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(83380400001)(186003)(4326008)(8676002)(66556008)(66946007)(6512007)(2906002)(6666004)(41300700001)(6506007)(53546011)(31696002)(86362001)(2616005)(478600001)(6486002)(966005)(66476007)(7416002)(8936002)(316002)(31686004)(36756003)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkFhUGFrTERscm5yNmhiVWxieDltbWQ1U1NoOGJjeGVMOUMrMFF1VzdvZW1s?=
 =?utf-8?B?QUgyL0ZpUXZoMXpPR1pXNEZ4M293VC9uYXQ0VGtpUVRMVlUySHZBZ0xyOFJr?=
 =?utf-8?B?SWx5MlFja3FrVDAyRzJQdDltaSt3RUFWSSttYng4eEJEd3RJVUpxbkhFcHl0?=
 =?utf-8?B?Z3pQYUlRUm1zR1R5aUxGaWRkUFo3a0ZpZDgyMEpvL2JBNjdvV25ENGFvYlEz?=
 =?utf-8?B?Snc2bGk0RTFVTmJxWitOZDY1akdONUpLNU9LZGdaaE9IZ3BIUGZnUGdjVVJN?=
 =?utf-8?B?a2dJQlMwQk5NTEEvdktENHZGZi9QM3RLSWRacGUyT0IxeHhLZFUyL0liK24x?=
 =?utf-8?B?RGhSSDdvSHFjSXFzTkswVnhjZUxJNGdIY3F0V29rMk9iSE9jajdvQzNMSUha?=
 =?utf-8?B?em40dGdZS25MYy9LR3BadU9TdU8yMzVrSGRDcG5UZ2dyZHF4YW1xZWtjSWJU?=
 =?utf-8?B?QVg3VTkxMVRXQ2tUbG05ZWZlK2VackJpNVhpb2x3Z1ZYUXJSSFh4Y3pwQ0RS?=
 =?utf-8?B?SnpBRWc4eWo2bk9KMnYrS0E5REtlZzZVTmpQdW9FOW9manFBaGtuZFE0YXQ4?=
 =?utf-8?B?N0pVZVpqMmhET0kwTUNCSzJxYWJiR25LbTllZnRpWllFYkoraEFIbytNc2U2?=
 =?utf-8?B?SGg2Nllham5ZeWZlWEhaNjdXcjI3ZnY3NC84dDE1S3EvSlp1WGhjY2dFOVMr?=
 =?utf-8?B?b1lSa3MzRE1Pakw3TWl1SzRJZDlmVjRSWTBEbFRSYWFCL29CNzUzQ1F4ek83?=
 =?utf-8?B?UG91ZGRVaW1ReTdjaDlTdjVxdkdRWHJTVU9IckxpclFodTVGQUwxemZLSnd6?=
 =?utf-8?B?SWx4RjF4WElQQk16R3FjWFNqa0kvZDdIZHlPSVRMTnk2ZlNhTnc0RzVZa2k4?=
 =?utf-8?B?Q3VZNHQvRnZxUEVtL0NPdml0NTJCY1FRYUJQSS94TFFML1REWTc1bTlqTHlq?=
 =?utf-8?B?dkFLdFgwOUlDdVZXZEcvazJMTFhtQ3BFeSs1Mmw5YzkzRWI3QXZjaWRBUVBu?=
 =?utf-8?B?SUIwVE1UNWlaWGJ1Vm1sb29xM2FHVkVVZVpxMkFNMlE2elV0STJ5SXhUcVZu?=
 =?utf-8?B?V3kza2gxZXpyMkFicVd5Zk04NFV6UEV2WnBSeVQzbFhDdWJPMUVJZ3JxMVBG?=
 =?utf-8?B?Z0hkb2pjVTU2T0w1cHN5Znl2aFZoaCtlZ2xITG9uWG5GL0RKaHZRcVFUZm10?=
 =?utf-8?B?Yk1qZTlFUFB4OFhEeDhQM3VQWlN4TUVVemU4NzEvTmRPaWlWRStENGEybVpM?=
 =?utf-8?B?a1BaY2NLZjliQU1sM0JsdjJuUFo5bkdEOFhXc0pJVnRwQWY1NWxnOG04TjFs?=
 =?utf-8?B?cFhjYkFLaDVObVVMemVRVElSQ3BtVCttV1RaMnVmK0ZZc2c5M3B5WVJCQ2FJ?=
 =?utf-8?B?b2JKZkdqdTVVWDM5OG5YSzF6UWFDTTVMK2I1SThXemY1cVdWbWJ0TnhUM0Fz?=
 =?utf-8?B?RlY5VFlDc0VaeTF2Vkh0Qk1yTWtWTm4vdjlNbU9nTlgvbkhLMjBBazBIOUZx?=
 =?utf-8?B?M0JhOWE4VVB2N3U4TmxtMldZdy9semJHelYwSTZDZWRXRXVRY3ZDbEhqY0tN?=
 =?utf-8?B?cmYrdjk3Uy85a2dDYWNCNWtTdmJ5czhyV2RvcnNTU3Fub1lwRWdTNksvRUJL?=
 =?utf-8?B?RWkwdmpIT1VaemgxTVFFczdoam5paEZrQlBHQUV2aXgyVkdMQ29tdnpoWnBB?=
 =?utf-8?B?WEhvYkgrcGdyRmJvRTNnVFk4VEVFQmE5TXd5SGk4bW5XUm1wSUdqczNoRDNE?=
 =?utf-8?B?WEFwZFJpdjlwVXhsVGtVTUNXU0Jtc2RQQUwwTHZzMy9mR21CZG9SRDVsUnl3?=
 =?utf-8?B?VmVWU1c2RHRIb0s1RGlnOWI0dHhTSkNaL0Y5QXVzUWkwOTFlRzlrQzhveTdN?=
 =?utf-8?B?YlRkZlJjOHVNYnNvQThtOS9xQWdXLzllMnB6WnNQV0VxeHpaWVJDVTJXdWs3?=
 =?utf-8?B?UWVCMEtIbGxvdXdOZFFBUERXTXFzYlo1NEpaTEIvZ0JjTlhTWUtEWWtGU1M0?=
 =?utf-8?B?ZkhGTG8zcDlLaWtCWDN2c3F5ODlKZXJVdnRsZU8waTM0YjVzSGplalpSSm1x?=
 =?utf-8?B?NUE0TnFBYVR2cGhyWHlHTm5hWFRqdnRRWVRYUzBNaGVqaW5ROE0wVkZ5K3g0?=
 =?utf-8?B?MkJ5VU82aTdXeDJWTHJvZjQ3ay9Ca3M2VkNhb2k3ZmlUVFYvd3FRZ0thQXdI?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587ae6a7-f0f0-42a6-6218-08da74e1da10
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 23:51:00.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2I6qB78qFej3DIOsWh1AtqP2oh4OM/DKtWesKdZ5v7zQOWl6n7W4wlVPkoklwe7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4074
X-Proofpoint-ORIG-GUID: alFHM3i9o_zpRrhTKy-HxHU7E3WhJYZ3
X-Proofpoint-GUID: alFHM3i9o_zpRrhTKy-HxHU7E3WhJYZ3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/22 1:17 PM, Jinghao Jia wrote:
> The bpf_sys_bpf() helper function allows an eBPF program to load another
> eBPF program from within the kernel. In this case the argument union
> bpf_attr pointer (as well as the insns and license pointers inside) is a
> kernel address instead of a userspace address (which is the case of a
> usual bpf() syscall). To make the memory copying process in the syscall
> work in both cases, bpfptr_t was introduced to wrap around the pointer
> and distinguish its origin. Specifically, when copying memory contents
> from a bpfptr_t, a copy_from_user() is performed in case of a userspace
> address and a memcpy() is performed for a kernel address.
> 
> This can lead to problems because the in-kernel pointer is never checked
> for validity. The problem happens when an eBPF syscall program tries to
> call bpf_sys_bpf() to load a program but provides a bad insns pointer --
> say 0xdeadbeef -- in the bpf_attr union. The helper calls __sys_bpf()
> which would then call bpf_prog_load() to load the program.
> bpf_prog_load() is responsible for copying the eBPF instructions to the
> newly allocated memory for the program; it creates a kernel bpfptr_t for
> insns and invokes copy_from_bpfptr(). Internally, all bpfptr_t
> operations are backed by the corresponding sockptr_t operations, which
> performs direct memcpy() on kernel pointers for copy_from/strncpy_from
> operations. Therefore, the code is always happy to dereference the bad
> pointer to trigger a un-handle-able page fault and in turn an oops.
> However, this is not supposed to happen because at that point the eBPF
> program is already verified and should not cause a memory error.
> 
> Sample KASAN trace:
> 
> [   25.685056][  T228] ==================================================================
> [   25.685680][  T228] BUG: KASAN: user-memory-access in copy_from_bpfptr+0x21/0x30
> [   25.686210][  T228] Read of size 80 at addr 00000000deadbeef by task poc/228
> [   25.686732][  T228]
> [   25.686893][  T228] CPU: 3 PID: 228 Comm: poc Not tainted 5.19.0-rc7 #7
> [   25.687375][  T228] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS d55cb5a 04/01/2014
> [   25.687991][  T228] Call Trace:
> [   25.688223][  T228]  <TASK>
> [   25.688429][  T228]  dump_stack_lvl+0x73/0x9e
> [   25.688747][  T228]  print_report+0xea/0x200
> [   25.689061][  T228]  ? copy_from_bpfptr+0x21/0x30
> [   25.689401][  T228]  ? _printk+0x54/0x6e
> [   25.689693][  T228]  ? _raw_spin_lock_irqsave+0x70/0xd0
> [   25.690071][  T228]  ? copy_from_bpfptr+0x21/0x30
> [   25.690412][  T228]  kasan_report+0xb5/0xe0
> [   25.690716][  T228]  ? copy_from_bpfptr+0x21/0x30
> [   25.691059][  T228]  kasan_check_range+0x2bd/0x2e0
> [   25.691405][  T228]  ? copy_from_bpfptr+0x21/0x30
> [   25.691734][  T228]  memcpy+0x25/0x60
> [   25.692000][  T228]  copy_from_bpfptr+0x21/0x30
> [   25.692328][  T228]  bpf_prog_load+0x604/0x9e0
> [   25.692653][  T228]  ? cap_capable+0xb4/0xe0
> [   25.692956][  T228]  ? security_capable+0x4f/0x70
> [   25.693324][  T228]  __sys_bpf+0x3af/0x580
> [   25.693635][  T228]  bpf_sys_bpf+0x45/0x240
> [   25.693937][  T228]  bpf_prog_f0ec79a5a3caca46_bpf_func1+0xa2/0xbd
> [   25.694394][  T228]  bpf_prog_run_pin_on_cpu+0x2f/0xb0
> [   25.694756][  T228]  bpf_prog_test_run_syscall+0x146/0x1c0
> [   25.695144][  T228]  bpf_prog_test_run+0x172/0x190
> [   25.695487][  T228]  __sys_bpf+0x2c5/0x580
> [   25.695776][  T228]  __x64_sys_bpf+0x3a/0x50
> [   25.696084][  T228]  do_syscall_64+0x60/0x90
> [   25.696393][  T228]  ? fpregs_assert_state_consistent+0x50/0x60
> [   25.696815][  T228]  ? exit_to_user_mode_prepare+0x36/0xa0
> [   25.697202][  T228]  ? syscall_exit_to_user_mode+0x20/0x40
> [   25.697586][  T228]  ? do_syscall_64+0x6e/0x90
> [   25.697899][  T228]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   25.698312][  T228] RIP: 0033:0x7f6d543fb759
> [   25.698624][  T228] Code: 08 5b 89 e8 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 a6 0e 00 f7 d8 64 89 01 48
> [   25.699946][  T228] RSP: 002b:00007ffc3df78468 EFLAGS: 00000287 ORIG_RAX: 0000000000000141
> [   25.700526][  T228] RAX: ffffffffffffffda RBX: 00007ffc3df78628 RCX: 00007f6d543fb759
> [   25.701071][  T228] RDX: 0000000000000090 RSI: 00007ffc3df78478 RDI: 000000000000000a
> [   25.701636][  T228] RBP: 00007ffc3df78510 R08: 0000000000000000 R09: 0000000000300000
> [   25.702191][  T228] R10: 0000000000000005 R11: 0000000000000287 R12: 0000000000000000
> [   25.702736][  T228] R13: 00007ffc3df78638 R14: 000055a1584aca68 R15: 00007f6d5456a000
> [   25.703282][  T228]  </TASK>
> [   25.703490][  T228] ==================================================================
> [   25.704050][  T228] Disabling lock debugging due to kernel taint
> 
> Update copy_from_bpfptr() and strncpy_from_bpfptr() so that:
>   - for a kernel pointer, it uses the safe copy_from_kernel_nofault() and
>     strncpy_from_kernel_nofault() functions.
>   - for a userspace pointer, it performs copy_from_user() and
>     strncpy_from_user().
> 
> Fixes: af2ac3e13e45 ("bpf: Prepare bpf syscall to be used from kernel and user space.")
> Link: https://lore.kernel.org/bpf/20220727132905.45166-1-jinghao@linux.ibm.com/
> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
