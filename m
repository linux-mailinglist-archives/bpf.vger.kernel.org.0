Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B14BD0E3
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 20:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbiBTTWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 14:22:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiBTTWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 14:22:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC653A719
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 11:22:10 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21KGF3vN023532;
        Sun, 20 Feb 2022 11:22:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vak8za7iTeQ0nuuH86WcI5qJXfMHiYNvAE4fCKF4k2Y=;
 b=bRs8KoPWyX6ORLXzbRH4y1b5L1qwqqjhICMVwVsi4FkiWEJ/o6mOLYC/TyR/+ZpjtNh/
 McCm/p7G0+w+gJDaLxGONCe06DzgWNa2zOTCStbCupbVPakJFo6Q2c++4XtYbppQmFBI
 jX7c+fGOwNZPe3WPAj86F676jVN+H/GmwKs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eawfrnfx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 20 Feb 2022 11:22:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 20 Feb 2022 11:22:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrUzLcQPJB2cf3kmF8D95H+00AroVT70L/pI27aZqLVAQrd15/dcEGAWmJCc6qrWlzuQntSQqaSPLEDgV1GVRIIF0BXYsLbND3kHWHrswJf28s5mD56+Eu+Q7AV2Pr3bosJybwZvos5A2WZvghSlkc3G2t44QulvmYYZ/te7XcZDkYlATo5I4jwF8Eq2bLbaEgk+h7/2RRwSYShkcn1Lk80Hw7lGGqekU5N3RGC0E3TpdqV2G5nZHriYPl/qWlDJy+LqGxIo5dwzvPz5243hpVxSiHcTyE//aLn1BVA+x+uKWMR9QWpuFAKg0E3IBASw2mtKffJ54mVuArP8q6JKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vak8za7iTeQ0nuuH86WcI5qJXfMHiYNvAE4fCKF4k2Y=;
 b=kfZJlkylLKgKHTx9euYdhFYmXZcmJXFLGpwIoNvaECfmw+fnRU+M6m5LIlqj4coD0HEszaSUNi79KahIPsC2vYOakGPm/NOgGWOgUFSBSAYjQCNFkXMUyLg1n7ZXkllrLRIdXszzNpcpHeqvUtGNA8xWWK/grIDwiqTmMMvGmdv2qmZcWFqUtkLBTxIxB++qWF41PK/m9RLo+tuuJqZ2Xhjx8i4TohBNAOto91cXfvi2PAGwvkfUqIJTuS7KF8tGK0vlOjlcXzRbzAw+DDv/9T2unDIidsWurszd45/4Rv4/tlBKg0mEYC32UtHdER7sUBxgy/khF1I5ruGby0PHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB4866.namprd15.prod.outlook.com (2603:10b6:a03:3c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 19:22:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 19:22:06 +0000
Message-ID: <11b93216-2592-adfa-1a0b-d8d870144f90@fb.com>
Date:   Sun, 20 Feb 2022 11:22:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: BTF type tags not emitted properly when using macros
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>
References: <20220220071333.sltv4jrwniool2qy@apollo.legion>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220220071333.sltv4jrwniool2qy@apollo.legion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:300:13d::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7ecc9ec-e22a-4926-93e3-08d9f4a64845
X-MS-TrafficTypeDiagnostic: BY3PR15MB4866:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB4866B1A1DC2127308DBD5EC8D3399@BY3PR15MB4866.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFvNRW0gGdaQehkEYe7TziywcXlfwk6wHEGq73aRzTpNSK1NppgYop1kwISzRBoH8julHMKwxSvPR8qQBvhY1U2vraCPVz7yARNEsYVdmncle1Z6HfzdTHxCFkpeOfgmjzokQl3mdnE0SNiTAYAT7SArBsI8jitJQ8KBiI6cfx/1tPwfM+zQEU+CWwPPP+anw0y9GzsWIF4snrtb7XEZJSheCQ0DjTzuvVmdh+0mnHk4T7H1xmLeuB/9v7Jm2WbZUeXmkNsVpEDtvoyl64cBznDSwEaw15oWaiekDIo/S9XDjMQlVtQMWxm3GFAPf4kaYHUWqFcbPhXtIkLmRe+4r81wyr9tcv8L7gedlSDVB22zDwIIt9z6ztOxuE25XGaXhH2Zjz9o3knrASLY8oydnn+msqIpXDn9LynwHQl/aWJ8Uv8bg79GTQ50ItZKpaoVvNBdlI5b8hH9c0w3wHYJabpYzHJGXVNA5M9XO70S1fes+fK9v1gwB7qAbr2/1shNM8xG6v2l8smf+YCysjh+z/n9CsvLikRf+sbs+ZN4ENlIWWWj+jPtJlAgUln+FaStNMMoxwc9eSaRQpqQhJmbEn3tvlMjxdx5Bm8zQqp6fDXsrNQzjKQBFhX8lSoVl1JfBHseU7WoIJWt8ynpUbFsdaOnC++o5AeSMtt2REXcM9Yzz824n0i2lfNwG0tdo1fyg5+GoYZz5iKOG7+O04ZrW5KBQYlw0vb8haIExTbA0wj15S5GSWfeiME3ABPtPsRc9dThdQTexIkpS+gZ1e12I/6H0xjG6zdTyGOzLisgAyMRFJd/cd9TbrPSUX1aTz9L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(6512007)(6666004)(6506007)(52116002)(53546011)(31686004)(36756003)(83380400001)(8936002)(2906002)(66556008)(86362001)(38100700002)(31696002)(66946007)(66476007)(8676002)(186003)(6486002)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlEzMm5LSGViTTdPakFMNDZVcXVSMk4wTVF0dnRSUVp0clc0Tnd3eVk0ZWJt?=
 =?utf-8?B?TFV5WEFvcjBxa3JHVmduWUhLd3ZUK2JrTlU3TUVaV09BZVlvUm5TV0w0Nk9F?=
 =?utf-8?B?MWlJeGJKVGlLU1Nid2UyUWpNa2pZUTlSSk55eWZ5Sy9YazRmTnZaSXgxNzBp?=
 =?utf-8?B?anpZS0EvTEpqY1JVN015VnB2L2dqbThZeUhtMVVRa1RTd0h3cFJWc3d0aU1I?=
 =?utf-8?B?Z3JpdjkyTmpUU0F0aXlnTkdLYkFsN0piOGJrcCtxQnhDeDVvZDFSRWQzV1JD?=
 =?utf-8?B?WUR3akp5cnRXNFVpdUpDcmlFTWlFdzRyNENoOHlvSTJHcUVNY1VBbjYvakF4?=
 =?utf-8?B?ckdGQzJ6VEJEVEZQMnFQWnVtcG9DbjE0eFJsRmRoY1NmOVBRYWZMaEtaYVl0?=
 =?utf-8?B?OXRrZnVwN0grMjBuOGFPdWNhTExCckVQczgxc3BXMC9tejF1ZFkybTNLT2tG?=
 =?utf-8?B?UzBBZ0hVTGlQVWZFSjV6czN0Sy9TUVpUL1BPNjc4UE1ESDZGNndJVEhIRmNN?=
 =?utf-8?B?QURxQU9CbHdwbHpFUjZEU0lhOFllNkFSOWk3QXhVK1JKVDM3Rjd6cktEL0pz?=
 =?utf-8?B?WG5Pc3luUEFqVUVIa3N6VFZDNHk2SDVJSHR0ZlhmZkx4U1oreSt5YzFOcGtS?=
 =?utf-8?B?RGRNRmpmWW9vRzZZdjFqWHg3VXh6cGhFRHBCT1FIdTJiMmgwdGk1VS9LYkNv?=
 =?utf-8?B?b0trN0FtNkNFdjNldU56eTJqQjZHLzBwZjJnUzFDVWtFZURiU05qVFRKTGF0?=
 =?utf-8?B?R1IySjIyNHZVMGJHSTdQcEhzSUNCUVNlWlNucGNrTW5KUHA3VmtZNjIvaHYz?=
 =?utf-8?B?Qlc2Rm1MTjEyN2t0VWRXSmNpaFNoMWRZeloydnNqMnNPK0s3OXJtMjJJemtR?=
 =?utf-8?B?cUd3S3U0SnpoTC9XUHNMcTI3Slg4MGFZYTRKSThEeU9remcvazhPRWtlb3R6?=
 =?utf-8?B?QW52cGxoOEtQVExNODlCdGdkVUt2Zis1QTdBTnJMcFdvcDcwSnh3ZHppRGxp?=
 =?utf-8?B?Z0VrbkRKZnRqNWlmV042d0R0Mk1ON0JnbEpuK3FMeFQzcTdRVjk0dGlTMi9M?=
 =?utf-8?B?UFdTZzVnRGtWbDBnVnhOT1VWV2NoSVdtOWU4N1c3ckplakxzTzM2aUoxWmlJ?=
 =?utf-8?B?bDJQejBSRktKQ25sUHQ4SmdHV3BKWW1IVWRZdnVUMG1wUGdUelhMOVhrWVgz?=
 =?utf-8?B?ZWFSb2J5Ym95Qmw5aU5ReVlPU2hhWm1WeTl0OHo3ZnNtKy9KZlk4RGo4QWo5?=
 =?utf-8?B?bUcyUnF0MGVON3o3NDhhSHJXQ0s2QUYwK0hTT3cwWDh3S2hHRlVDUFluMVpG?=
 =?utf-8?B?YkZrc2VjN0pRK1VoQ1dkQnVCajAwZmgxUFg5MVB6eXI3WEEweEZiRUxRTUhX?=
 =?utf-8?B?aUhHaUR1TjBiMC9WZXlTQ0w2OGhEWmhtLzZBOGFZcWd3K01Fb0JFS05VMExQ?=
 =?utf-8?B?TXlTaUVxa1B2U0hSL1NJQXpCZkUzcGM0NWt3T01jUjQvUVAxSzlWVCtwdEM3?=
 =?utf-8?B?aGZ6eEhTcHFsVG9PT2lDRmJTeURGR0xDV3dyeTc5YytUMmI3eWNDckJraXhX?=
 =?utf-8?B?djlwdGdhTVliTlNnL2NhUkNodnFOY1NtaGRpTkN6K3BscTl1bm9FSEhZbkt1?=
 =?utf-8?B?K05kWGhSU2pjZnowbENKV0xldStsQ0huZFNWM1hucHhHT1hlZFJrYmpVR0Ev?=
 =?utf-8?B?dWJRZk13aSswRVFXQ1NoRUdRVDVHWUJaOEFFTHZtUWFmenR0aGtuMzIwSUU4?=
 =?utf-8?B?bTJwUDBGSmthaUl6d3d6akNvSTBUQkVqYmMvK01Cc0tGdkRYK3cwUUQ3RUJr?=
 =?utf-8?B?Mm1WdTJyUVJsOGpLQ3Erbkd1c0ovaGRmYm5mT1VtaENSemJaQVEzaVIwMlVm?=
 =?utf-8?B?R3VBbjQvUWNiL1c0RjBFR0R1bUplUmlBLzZvekoyZjdxQWQwWGM4RFE3ZGJk?=
 =?utf-8?B?K3d1dHdOWXBwOUhUY0QwVVoyRVczYThRR1ZTSGl0bkQrWlZwZVlTdk5pa3R6?=
 =?utf-8?B?KzB0L3ZBandyRWgxZWlaS0NJVUlrcTQwU0h2Qms5b1FjY1Vsb3hTK0VvQkpY?=
 =?utf-8?B?Yzc5ZVJNVGpNQVc2T0IwMnFybkRYbmJyT3lTaHlia1ZEcnI0S3YvRDlIV3l5?=
 =?utf-8?Q?uvy3hFr1ikEmC5P2vHUMMuMlK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ecc9ec-e22a-4926-93e3-08d9f4a64845
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 19:22:06.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hL+M6yh4LUNIlXbjuYxJatVPIxS4hKqyC6KUlmpmEAHj2AETSxVswp+Iy1OG8Hwk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4866
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3iNe-5MyxFJJ_wuSl-cPdn1qmNzOuv8M
X-Proofpoint-ORIG-GUID: 3iNe-5MyxFJJ_wuSl-cPdn1qmNzOuv8M
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-20_08,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202200126
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/22 11:13 PM, Kumar Kartikeya Dwivedi wrote:
> Hi list,
> 
> I noticed another problem in LLVM HEAD wrt BTF type tags.
> 
> When I have a file like bad.c:
> 
>   ; cat bad.c
> #define __kptr __attribute__((btf_type_tag("btf_id")))
> #define __kptr_ref __kptr __attribute__((btf_type_tag("ref")))
> #define __kptr_percpu __kptr __attribute__((btf_type_tag("percpu")))
> #define __kptr_user __kptr __attribute__((btf_type_tag("user")))
> 
> struct map_value {
>          int __kptr *a;
>          int __kptr_ref *b;
>          int __kptr_percpu *c;
>          int __kptr_user *d;
> };
> 
> struct map_value *func(void);
> 
> int main(void)
> {
>          struct map_value *p = func();
>          return *p->a + *p->b + *p->c + *p->d;
> }
> 
> All tags are not emitted to BTF (neither are they there in llvm-dwarfdump output):
> 
>   ; ./src/linux/kptr-map/tools/bpf/bpftool/bpftool btf dump file bad.o format raw
> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] FUNC 'main' type_id=1 linkage=global
> [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=0
> [5] PTR '(anon)' type_id=6
> [6] STRUCT 'map_value' size=32 vlen=4
>          'a' type_id=8 bits_offset=0
>          'b' type_id=11 bits_offset=64
>          'c' type_id=11 bits_offset=128
>          'd' type_id=11 bits_offset=192
> [7] TYPE_TAG 'btf_id' type_id=2
> [8] PTR '(anon)' type_id=7
> [9] TYPE_TAG 'btf_id' type_id=2
> [10] TYPE_TAG 'ref' type_id=9
> [11] PTR '(anon)' type_id=10
> [12] FUNC 'func' type_id=4 linkage=extern
> 
> Notice that only btf_id (__kptr) and btf_id + ref (__kptr_ref) are emitted
> properly, and then rest of members use type_id=11, instead of emitting more type
> tags.

Thanks for reporting. I think clang frontend may have bugs in handling 
nested macros. Will debug this.

> 
> When I use a mix of macro and direct attributes, or just attributes, it does work:
> 
> ; cat good.c
> #define __kptr __attribute__((btf_type_tag("btf_id")))
> 
> struct map_value {
>          int __kptr *a;
>          int __kptr __attribute__((btf_type_tag("ref"))) *b;
>          int __kptr __attribute__((btf_type_tag("percpu"))) *c;
>          int __kptr __attribute__((btf_type_tag("user"))) *d;
> };
> 
> struct map_value *func(void);
> 
> int main(void)
> {
>          struct map_value *p = func();
>          return *p->a + *p->b + *p->c + *p->d;
> }
> 
> Now all tags are there in BTF:
> 
>   ; ./src/linux/kptr-map/tools/bpf/bpftool/bpftool btf dump file good.o format raw
> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] FUNC 'main' type_id=1 linkage=global
> [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=0
> [5] PTR '(anon)' type_id=6
> [6] STRUCT 'map_value' size=32 vlen=4
>          'a' type_id=8 bits_offset=0
>          'b' type_id=11 bits_offset=64
>          'c' type_id=14 bits_offset=128
>          'd' type_id=17 bits_offset=192
> [7] TYPE_TAG 'btf_id' type_id=2
> [8] PTR '(anon)' type_id=7
> [9] TYPE_TAG 'btf_id' type_id=2
> [10] TYPE_TAG 'ref' type_id=9
> [11] PTR '(anon)' type_id=10
> [12] TYPE_TAG 'btf_id' type_id=2
> [13] TYPE_TAG 'percpu' type_id=12
> [14] PTR '(anon)' type_id=13
> [15] TYPE_TAG 'btf_id' type_id=2
> [16] TYPE_TAG 'user' type_id=15
> [17] PTR '(anon)' type_id=16
> [18] FUNC 'func' type_id=4 linkage=extern
> 
> In both cases, the preprocessed source (using -E) looks to be the same:
> 
>   ; /home/kkd/src/llvm-project/llvm/build/bin/clang --target=bpf -g -O2 -c bad.c -E
> # 1 "bad.c"
> # 1 "<built-in>" 1
> # 1 "<built-in>" 3
> # 323 "<built-in>" 3
> # 1 "<command line>" 1
> # 1 "<built-in>" 2
> # 1 "bad.c" 2
> 
> struct map_value {
>   int __attribute__((btf_type_tag("btf_id"))) *a;
>   int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("ref"))) *b;
>   int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("percpu"))) *c;
>   int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("user"))) *d;
> };
> 
> struct map_value *func(void);
> 
> int main(void)
> {
>   struct map_value *p = func();
>   return *p->a + *p->b + *p->c + *p->d;
> }
> 
>   ; /home/kkd/src/llvm-project/llvm/build/bin/clang --target=bpf -g -O2 -c good.c -E
> # 1 "good.c"
> # 1 "<built-in>" 1
> # 1 "<built-in>" 3
> # 323 "<built-in>" 3
> # 1 "<command line>" 1
> # 1 "<built-in>" 2
> # 1 "good.c" 2
> 
> struct map_value {
>   int __attribute__((btf_type_tag("btf_id"))) *a;
>   int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("ref"))) *b;
>   int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("percpu"))) *c;
>   int __attribute__((btf_type_tag("btf_id"))) __attribute__((btf_type_tag("user"))) *d;
> };
> 
> struct map_value *func(void);
> 
> int main(void)
> {
>   struct map_value *p = func();
>   return *p->a + *p->b + *p->c + *p->d;
> }
> 
> --
> 
> Please let me know if I made some dumb mistake.
> 
>   ; /home/kkd/src/llvm-project/llvm/build/bin/clang --version
> clang version 15.0.0 (https://github.com/llvm/llvm-project.git 290e482342826ee4c65bd6d2aece25736d3f0c7b)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/kkd/src/llvm-project/llvm/build/bin
> 
> A side note, but it seems it could avoid emitting the same type tag multiple
> times to save on space. I.e. in the case of other members, their ref, percpu,
> user tag could point to the same btf_id type tag that the first member's
> BTF_KIND_PTR points to.

Right, we might have some type duplication here. I am aware of this 
since this ONLY happens when types in ptr -> [other modifier types] -> 
base_type where [other modifier types] might be duplicated due to
particular llvm BPF backend implementation. In general, this should
not take much space. Since you are mentioning this, I will try to
improve it.

> 
> Thanks.
> --
> Kartikeya
