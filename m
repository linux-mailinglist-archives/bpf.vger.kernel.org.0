Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579BE696DA0
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 20:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBNTOd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 14:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBNTOc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 14:14:32 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F53265BD
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 11:14:30 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGtr7Q021169;
        Tue, 14 Feb 2023 11:14:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=4qNrsG4Y0f+sVWLl/zabjyfGJfbE2bXwyoTb7rDo6Xg=;
 b=YGvTK/mFBsBkSWRBtmUS+dGgD6x1TvtwL19pLfOI2gq2/RozMoZi5IoFY/2kiK3Gv0Ik
 uj0lk3TQHRm0lBFd+QCwbDzGY2/sYb/0kDapkafVZKl15zXE2RYMsQuxFMW/RCPWln/4
 y+OKFtnJV5PwqJnWSQqucqZDnTxmcPo4ZWU9cLIEKxGhhG5xj46qckwDA1X6Mb2UarAB
 hDXLogPr+xzjEEQm1nrHPn9P5NGdIHLZfm5mFNTyp6+SkzwlMLglAJCh24zLRdIRL/LE
 uw9b6yG/K9tYeG96V4kPHfwrI6Ro9WGwc4/StK50cimsA4qUsMVhBQ9/6fP2X3fzPQqQ zg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nr5nxvh0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 11:14:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrVzDs/i7FoX7VUEVT6mjGXVzeTpjSYRHO5Z4z+hhfTJdhJXcYj47ELfE2MZj3s7b6zVyy6pAz8/+DaU6IDOmLxdYby//pMXqhPSgfSOrs3jnUpGUrQVMJz/uabMkzddBgbdt4yC5lH1AwQc7wqWVAd25hdT6ls9vAGfyXCDkkw+EsHFqcAEMpZgYlLvJ6eGAiH5fFgFI3XBe8iUeWOCudnUXiBJYIhgFdmTTqeOv6giUwDzm9FAT3AiPuDfBIU2UYlevVaT6pl5zqWj0YIQG+Q1CTESud/ZSIGX1psP14gv1ZRA1MwmEfpiI6EwPmBRLbQZENK+mgHZGkAkPe2Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qNrsG4Y0f+sVWLl/zabjyfGJfbE2bXwyoTb7rDo6Xg=;
 b=fE/fSCs7ph8d/Iq0z5HrrEtwfmQmIFgNYFPibnQa4wVUQ/o8c87vh9ijphHlkJ70nzOUXKMygK+ebBkZ4hM6qG0oFXKoW2+dTBOHxV2Loh4brRkOATGStAhYf6soezqreHqn2RTgIQte2/7eR9EhEFuMfTL9DGAwTdmcQPuY8Kvz/Nbgwn4YLSUndEV9PtVPDKsX/9QzwCiR4MBPMtyTAbTb0/ziByo60hJ23lA3jJwaVujAup6A3Q/ySVrj7NyVL6euHzmlor/6Tk+I09rJoVJjnd71MtfA2IHUer+WgKvKduSGH3X0H2C/uYv2Iqxn9aO8u5C8opwOxEry1I4PSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by PH0PR15MB4671.namprd15.prod.outlook.com (2603:10b6:510:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 19:14:14 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 19:14:13 +0000
Message-ID: <5fd2549e-5ce7-9de4-93a7-13dc06a0053c@meta.com>
Date:   Tue, 14 Feb 2023 14:14:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 bpf-next] bpf: Refactor release_regno searching logic
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20230214190551.2264057-1-davemarchevsky@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230214190551.2264057-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|PH0PR15MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: 85953d66-5bf0-4e0e-c518-08db0ebfa8d0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMPqa2FqorEDP1D6crrRbW68sMxZN2QuRSkYUzYud3rWHuPzPzw4PX9xEoiFvOkWcc6BpR1rY6FvFmFKqAFWKPbkpb7nVLLTV6nR5QAg5uVp/R7kP8ifG9DtjjwU48h2nVDysIr65KO/lxy2IGt8giJpinnIe+TBFYUFQmggQSIyNbN3p+LMfXUNCDKYnfS9XUFG/B0eNBA9agEaBZulVzcNmhxNIcwabAE7qCvPsLgO3shUpNs0kvJZK+Pa8dzFrr6PZe2v3eHs3vx+0aWMmxjBc9kFgBM2fmcFptceItJ1Lz/M/hKs3OqWhl9sisqebAeYYAinL8VMOjt0zC7mlStPbdhrhrZhKUEIkSf8YKvdyGfiRaE6NYlyyO4llI8jjoTJy68YxMrhTwEox6K5Loj3YPKuN1yMh+NA6DjgUbgMdvMLOTWe1ubWe/EcxMVjmH5jtUdXl4H/GHajoCOw41f/GFc+1Ybpnd1jqStfxWBugVdDA6+slMN2QSWT+iNlq8VS6W748enrB7MICDwA2cnfXhLcwPSsZ5/huH95leUyYPLU8rrZI+Y2dIel/89RLdWfunUoXKat80VSaFMdI6g28Q1tFN1fIFNRuCwIylNXFKWjHX/5nH54Rt5lBHNvICh3sa3yOLeDhBV61YnMXgY2rxAIClEz5lyRBF8J6pvg9ZUNh8N/KZRjHtfv5KyRl0I/UZlpuwfGh5ZefHq/lLyLR4UtEHVLFpfIP9hhw1EQ6IatsbkmtP02flXiFTfqYLA9fRwPUEkpUB38zFQPj1mWhVREOENY5JScthTMcF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199018)(478600001)(41300700001)(30864003)(8936002)(5660300002)(6486002)(966005)(54906003)(31696002)(86362001)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(83380400001)(6512007)(186003)(53546011)(6506007)(36756003)(2616005)(2906002)(31686004)(38100700002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNUM0FpS1k2V0p6VWhoU2w5LzZXQUVLRjk5YlFpakRrSmcvQ084eWcwcG5X?=
 =?utf-8?B?ZTJHODJtVjRTM1ErMkNUbjYwZjh6TFBBcjJqUlpQWHlZdDU0SUFSQlZxUmZI?=
 =?utf-8?B?NWlFclZEcmc1RndBLzZkTVZabTBHTG9pM2l2UTJVYThrblgva2h1dzk2TDRr?=
 =?utf-8?B?dUtxbUhSNUJ3YllMQ0lQL1hSY0EvRE5WK1dEU3Vrb1dydVhEdStMTkZDZ0ll?=
 =?utf-8?B?QjIzeTR1YmR5ZGVPQkR2SW13U2lxQjdMbVFDRUV2eDZhRG9KaHNxMFdBY0Va?=
 =?utf-8?B?ckNubG8xWnNHWHRrTENVejJlazFuejNTTFlDMTEzSkFoWlBMbU85K0NoRnA1?=
 =?utf-8?B?d1U5R1pzT0djQytFSE1sdURlNHA1UEdwbHNXb2NzV2I1K1NGVC9LZitZbnZD?=
 =?utf-8?B?aFRRakQyS1pqRmlidVJWNjYxanBFYVcyUmV2K3M5cHc4cXhMSVVwOVE0dEdN?=
 =?utf-8?B?SGQ5RDNPWDE4ZXhjb1ZONElMQ0dhdTByVkd0Z2F4Y2VnTFpNdlNGWXMwb2NB?=
 =?utf-8?B?UG1SNXJNSDJ2eEF4aHkyVFBlTWlRbUkxa3Mzek1tVHFuYjJXdlN0b1FFcm1i?=
 =?utf-8?B?dlY1TEVpMnNjUnRaTjBMTW40VjkrQ0JacFAvcUxFQWpHRDJUY1lKdHZobFNF?=
 =?utf-8?B?STIvYjFYb0ZqSnB4ZTNUaWRZQVp6UmdSSEVSN3RxbU5SaWt0RC9UR2lKYm5j?=
 =?utf-8?B?cEMrczhRZ0VUR0hRRkVxVGdaQ3pubkFDZDR3K015dTQwd05oblRoMUFoZDE3?=
 =?utf-8?B?bEVMWkUrYzZ2NENGcVRXU1dnem1DVlRUYVdqb1VwVFJCUTBrbjVpWWExdXhx?=
 =?utf-8?B?MWhVeHJBTmpyZm1FVXp0djV1aVZSSmM1TzVEQkhITElmUnM0eGdsby9XWG5Z?=
 =?utf-8?B?RkI2OTBjYzNGUWExRElrRVMyZG1VWDQveU04dDFSdk1Vdmx1U3dZSFFWa2FV?=
 =?utf-8?B?MGl2UkNjM2pWQXRsTk56ZWVPanNDdy9DbThKeUQxNjd4bEIrVGZaNjJPQ3FF?=
 =?utf-8?B?S0hTMWJWRENTNERYZ2lZaEVFdDV2TCt4ZVZYL2Y3cFIzZ292NkMrRGFtTjBv?=
 =?utf-8?B?UHJ4V2NiQllXWE85eWRWQW9vSkVZdURnR1FaaDdtNXprWHlTNjBvbVZUUUJD?=
 =?utf-8?B?NWx4VW81RXEzZnMzRkpOK0FJWUE3TklLd1Mwc0dBRW80SUxEWUs3YXYvUUVC?=
 =?utf-8?B?WE9hUzhBdHpvRmZveWFvTkdpNnZrai9qMU5IbEhuZ3RxeUNIOElQM1BnRWxp?=
 =?utf-8?B?Mm9ieUpsR25uZ2ZmNEJES3N2NWNhcHplL0Rlb01ESDZpTmZpZXhQWGdCeG9B?=
 =?utf-8?B?eFdVNXZaTUxlUW5qZC9jRk1yMm85ckhicHpXY0k4Q1FTalQyaGNuODFZTklK?=
 =?utf-8?B?cVlLckRrSVZWYko2VWsxbk1EdVJIM2VsUUxlVUI2VmlXVXFiREJQVjJGOXZT?=
 =?utf-8?B?R1J3Z3VnMU5WWnlZNy92UkhvUHI5ZjF2M2VTaXYyV1ZMSjRLTmVkSWJydE5W?=
 =?utf-8?B?N21ZcjNabE1PWnF1SCsrSkU5d211MElSQ2hBdFRpaUhmT3NzazU5Q0NBVWhr?=
 =?utf-8?B?Q1oxV2VnQkNac2d3UXFSaUZYWWw3UlVJcnVFaXZFdWRyWGRJQzBxSStsK0Rj?=
 =?utf-8?B?WEZVVW5jQkF2bVdhMXZIY1pkSzhRN3RsRzNIcmc5RFVMSGoyUk5NVVlacWIw?=
 =?utf-8?B?QTQ0dlVRd0RibTZKV3FJQkVVRFlFbm0zaVZESmtTdUZ3QzNJc1llSCt3SFh0?=
 =?utf-8?B?cnBrUE96RktoZjlDQXlzbGRsMEduNDQ4QmhlckJuRDltVjJRNUN0dkdlbU9D?=
 =?utf-8?B?QTZWRE85VHUzWkZCR2NSa1VsOFRDZ1B0cEpYSFp3WWVpY3dBaHlVWXg0SGc0?=
 =?utf-8?B?a0hBUG1vNmZOQ3YzNzd0VHJSWU95cngySnlhRjNYeU42Y3VxREcvMHNZQVFZ?=
 =?utf-8?B?WHZuQ2R6Z0M5aFB6SU9oMmxacG1iZ0EzN04zN0pUSmNuSHVOTTQ0QURUQVJh?=
 =?utf-8?B?UXpreEZMeU5rNlBXekhjbXIvNjR1YzNmWEVvMkdjd0h1YVE3N1EvUXAraFBW?=
 =?utf-8?B?VzlsMlJvREdxbjYxOGtBSHlaVG1SNUpLRFBvdkx1K295SWQxUGVUaUgxWkRl?=
 =?utf-8?B?Rkh1Yll4R0lqcXZqZ2FKaW5jRTVqUmt0dHU3VTdic0ZXbUNDbjhNaStvYjQ1?=
 =?utf-8?Q?4kglvo8eYc3X/Ik/iZPyAQQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85953d66-5bf0-4e0e-c518-08db0ebfa8d0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:14:13.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJTANDQ62iDrUAH6DSb0mt7f18EU9DDup+dSq2wsmm9UAYxPfzEXKhXLKa8/rP//DxVAShWQJxhOKMYy2fXUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4671
X-Proofpoint-ORIG-GUID: tOORC8Y-AfEDy3MDUAXoXAE7HaN7iNEJ
X-Proofpoint-GUID: tOORC8Y-AfEDy3MDUAXoXAE7HaN7iNEJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_13,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/14/23 2:05 PM, Dave Marchevsky wrote:
> Currently the ref_obj_id and OBJ_RELEASE searching is done in the code
> that examines each individual arg (check_func_arg for helpers and
> check_kfunc_args inner loop for kfuncs). This patch pulls out this
> searching to occur before individual arg type handling, resulting in a
> cleaner separation of logic and shared logic between kfuncs and helpers.
> 
> The logic for this searching is already very similar between kfuncs and
> helpers:
> 
> Kfuncs:
>   * Function-level KF_RELEASE flag indicates that the kfunc releases
>     some previously-acquired arg
>   * Verifier searches through arg regs to find those with ref_obj_id set
>     * One such arg reg is selected. If multiple arg regs have ref_obj_id
>       set, the last one (by regno) is chosen to be released
> 
> Helpers:
>   * OBJ_RELEASE is used in function proto to tag a particular arg as the
>     one that should be released
>     * There can only be one such tagged arg
>   * Verifier confirms that only one arg reg has ref_obj_id set and that
>     that reg matches expected OBJ_RELEASE arg
>     * If OBJ_RELEASE arg doesn't have a matching ref_obj_id arg reg, or
>       some other arg reg has ref_obj_id, it's an invalid state
> 
> It's a long-term goal to merge as much kfunc and helper logic as
> possible. Merging the similar functionality here is a small step in that
> direction.
> 
> Two new helper functions are added:
>   * args_find_ref_obj_id_regno
>     * For helpers and kfuncs. Searches through arg regs to find
>       ref_obj_id reg and returns its regno.
> 
>   * helper_proto_find_release_arg_regno
>     * For helpers only. Searches through fn proto args to find the
>       OBJ_RELEASE arg and returns the corresponding regno.
> 
> The refactoring strives to keep failure logic and error messages
> unchanged. However, because the release arg searching is now done before
> any arg-specific type checking, verifier states that are invalid due to
> both invalid release arg state _and_ some type- or helper-specific
> checking logic might see the release arg-related error message first,
> when previously verification would fail for the other reason.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> v2 -> v3: 

Whoops, didn't include v2 link.
Here it is: https://lore.kernel.org/bpf/20230131171038.2648165-1-davemarchevsky@fb.com/

>  * Edit patch summary for clarity
>  * Correct err_multi comment in args_find_ref_obj_id_regno doc string
>  * Rebase onto latest bpf-next: 'Revert "bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25"'
> 
> v1 -> v2: https://lore.kernel.org/bpf/20230121002417.1684602-1-davemarchevsky@fb.com/
>  * Fix uninitialized variable complaint (kernel test bot)
>  * Add err_multi param to args_find_ref_obj_id_regno - kfunc arg reg
>    checking wasn't erroring if multiple ref_obj_id arg regs were found,
>    retain this behavior
> 
> v0 -> v1: https://lore.kernel.org/bpf/20221217082506.1570898-2-davemarchevsky@fb.com/
>  * Remove allow_multi from args_find_ref_obj_id_regno, no need to
>    support multiple ref_obj_id arg regs
>  * No need to use temp variable 'i' to count nargs (David)
>  * Proper formatting of function-level comments on newly-added helpers (David)
> 
>  kernel/bpf/verifier.c | 220 +++++++++++++++++++++++++++++-------------
>  1 file changed, 153 insertions(+), 67 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 21e08c111702..c0d01085f44f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6735,48 +6735,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		return err;
>  
>  skip_type_check:
> -	if (arg_type_is_release(arg_type)) {
> -		if (arg_type_is_dynptr(arg_type)) {
> -			struct bpf_func_state *state = func(env, reg);
> -			int spi;
> -
> -			/* Only dynptr created on stack can be released, thus
> -			 * the get_spi and stack state checks for spilled_ptr
> -			 * should only be done before process_dynptr_func for
> -			 * PTR_TO_STACK.
> -			 */
> -			if (reg->type == PTR_TO_STACK) {
> -				spi = dynptr_get_spi(env, reg);
> -				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
> -					verbose(env, "arg %d is an unacquired reference\n", regno);
> -					return -EINVAL;
> -				}
> -			} else {
> -				verbose(env, "cannot release unowned const bpf_dynptr\n");
> -				return -EINVAL;
> -			}
> -		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
> -			verbose(env, "R%d must be referenced when passed to release function\n",
> -				regno);
> -			return -EINVAL;
> -		}
> -		if (meta->release_regno) {
> -			verbose(env, "verifier internal error: more than one release argument\n");
> -			return -EFAULT;
> -		}
> -		meta->release_regno = regno;
> -	}
> -
> -	if (reg->ref_obj_id) {
> -		if (meta->ref_obj_id) {
> -			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> -				regno, reg->ref_obj_id,
> -				meta->ref_obj_id);
> -			return -EFAULT;
> -		}
> -		meta->ref_obj_id = reg->ref_obj_id;
> -	}
> -
>  	switch (base_type(arg_type)) {
>  	case ARG_CONST_MAP_PTR:
>  		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
> @@ -6891,6 +6849,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		err = check_mem_size_reg(env, reg, regno, true, meta);
>  		break;
>  	case ARG_PTR_TO_DYNPTR:
> +		if (meta->release_regno == regno) {
> +			struct bpf_func_state *state = func(env, reg);
> +			int spi;
> +
> +			/* Only dynptr created on stack can be released, thus
> +			 * the get_spi and stack state checks for spilled_ptr
> +			 * should only be done before process_dynptr_func for
> +			 * PTR_TO_STACK.
> +			 */
> +			if (reg->type == PTR_TO_STACK) {
> +				spi = dynptr_get_spi(env, reg);
> +				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
> +					verbose(env, "arg %d is an unacquired reference\n", regno);
> +					return -EINVAL;
> +				}
> +			} else {
> +				verbose(env, "cannot release unowned const bpf_dynptr\n");
> +				return -EINVAL;
> +			}
> +		}
>  		err = process_dynptr_func(env, regno, arg_type, meta);
>  		if (err)
>  			return err;
> @@ -8104,10 +8082,95 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
>  				 state->callback_subprogno == subprogno);
>  }
>  
> +/**
> + * args_find_ref_obj_id_regno() - Find regno that should become meta->ref_obj_id
> + * @env: Verifier env
> + * @regs: Regs to search for ref_obj_id
> + * @nargs: Number of arg regs to search
> + * @err_multi: Should this function error if multiple ref_obj_id args found
> + *
> + * Call arg meta's ref_obj_id is used to either:
> + * * For release funcs, keep track of ref that needs to be released
> + * * For other funcs, keep track of ref that needs to be propagated to retval
> + *
> + * Find the arg regno with nonzero ref_obj_id
> + *
> + * If err_multi is false and multiple ref_obj_id arg regs are seen, regno of the
> + * last one is returned
> + *
> + * Return:
> + * * On success, regno that should become meta->ref_obj_id (regno > 0 since
> + *   BPF_REG_1 is first arg
> + * * 0 if no arg had ref_obj_id set
> + * * -err if some invalid arg reg state
> + */
> +static int args_find_ref_obj_id_regno(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
> +				      u32 nargs, bool err_multi)
> +{
> +	struct bpf_reg_state *reg;
> +	u32 i, regno, found_regno = 0;
> +
> +	for (i = 0; i < nargs; i++) {
> +		regno = i + BPF_REG_1;
> +		reg = &regs[regno];
> +
> +		if (!reg->ref_obj_id)
> +			continue;
> +
> +		if (found_regno && err_multi) {
> +			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> +				regno, reg->ref_obj_id, regs[found_regno].ref_obj_id);
> +			return -EFAULT;
> +		}
> +
> +		found_regno = regno;
> +	}
> +
> +	return found_regno;
> +}
> +
> +/**
> + * helper_proto_find_release_arg_regno() - Find OBJ_RELEASE arg in func proto
> + * @env: Verifier env
> + * @fn: Func proto to search for OBJ_RELEASE
> + * @nargs: Number of arg specs to search
> + *
> + * For helpers, to determine which arg reg should be released, loop through
> + * func proto arg specification to find arg with OBJ_RELEASE
> + *
> + * Return:
> + * * On success, regno of single OBJ_RELEASE arg
> + * * 0 if no arg in the proto was OBJ_RELEASE
> + * * -err if some invalid func proto state
> + */
> +static int helper_proto_find_release_arg_regno(struct bpf_verifier_env *env,
> +					       const struct bpf_func_proto *fn, u32 nargs)
> +{
> +	enum bpf_arg_type arg_type;
> +	int i, release_regno = 0;
> +
> +	for (i = 0; i < nargs; i++) {
> +		arg_type = fn->arg_type[i];
> +
> +		if (!arg_type_is_release(arg_type))
> +			continue;
> +
> +		if (release_regno) {
> +			verbose(env, "verifier internal error: more than one release argument\n");
> +			return -EFAULT;
> +		}
> +
> +		release_regno = i + BPF_REG_1;
> +	}
> +
> +	return release_regno;
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			     int *insn_idx_p)
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> +	int i, err, func_id, nargs, release_regno, ref_regno;
>  	const struct bpf_func_proto *fn = NULL;
>  	enum bpf_return_type ret_type;
>  	enum bpf_type_flag ret_flag;
> @@ -8115,7 +8178,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	struct bpf_call_arg_meta meta;
>  	int insn_idx = *insn_idx_p;
>  	bool changes_data;
> -	int i, err, func_id;
>  
>  	/* find function prototype */
>  	func_id = insn->imm;
> @@ -8179,8 +8241,37 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	}
>  
>  	meta.func_id = func_id;
> +	regs = cur_regs(env);
> +
> +	/* find actual arg count */
> +	for (nargs = 0; nargs < MAX_BPF_FUNC_REG_ARGS; nargs++)
> +		if (fn->arg_type[nargs] == ARG_DONTCARE)
> +			break;
> +
> +	release_regno = helper_proto_find_release_arg_regno(env, fn, nargs);
> +	if (release_regno < 0)
> +		return release_regno;
> +
> +	ref_regno = args_find_ref_obj_id_regno(env, regs, nargs, true);
> +	if (ref_regno < 0)
> +		return ref_regno;
> +	else if (ref_regno > 0)
> +		meta.ref_obj_id = regs[ref_regno].ref_obj_id;
> +
> +	if (release_regno > 0) {
> +		if (!regs[release_regno].ref_obj_id &&
> +		    !register_is_null(&regs[release_regno]) &&
> +		    !arg_type_is_dynptr(fn->arg_type[release_regno - BPF_REG_1])) {
> +			verbose(env, "R%d must be referenced when passed to release function\n",
> +				release_regno);
> +			return -EINVAL;
> +		}
> +
> +		meta.release_regno = release_regno;
> +	}
> +
>  	/* check args */
> -	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +	for (i = 0; i < nargs; i++) {
>  		err = check_func_arg(env, i, &meta, fn);
>  		if (err)
>  			return err;
> @@ -8204,8 +8295,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			return err;
>  	}
>  
> -	regs = cur_regs(env);
> -
>  	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
>  	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
>  	 * is safe to do directly.
> @@ -9442,10 +9531,11 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
>  {
>  	const char *func_name = meta->func_name, *ref_tname;
> +	struct bpf_reg_state *regs = cur_regs(env);
>  	const struct btf *btf = meta->btf;
>  	const struct btf_param *args;
> +	int ret, ref_regno;
>  	u32 i, nargs;
> -	int ret;
>  
>  	args = (const struct btf_param *)(meta->func_proto + 1);
>  	nargs = btf_type_vlen(meta->func_proto);
> @@ -9455,17 +9545,31 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		return -EINVAL;
>  	}
>  
> +	ref_regno = args_find_ref_obj_id_regno(env, cur_regs(env), nargs, false);
> +	if (ref_regno < 0) {
> +		return ref_regno;
> +	} else if (!ref_regno && is_kfunc_release(meta)) {
> +		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> +			func_name);
> +		return -EINVAL;
> +	}
> +
> +	meta->ref_obj_id = regs[ref_regno].ref_obj_id;
> +	if (is_kfunc_release(meta))
> +		meta->release_regno = ref_regno;
> +
>  	/* Check that BTF function arguments match actual types that the
>  	 * verifier sees.
>  	 */
>  	for (i = 0; i < nargs; i++) {
> -		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
>  		const struct btf_type *t, *ref_t, *resolve_ret;
>  		enum bpf_arg_type arg_type = ARG_DONTCARE;
>  		u32 regno = i + 1, ref_id, type_size;
>  		bool is_ret_buf_sz = false;
> +		struct bpf_reg_state *reg;
>  		int kf_arg_type;
>  
> +		reg = &regs[regno];
>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>  
>  		if (is_kfunc_arg_ignore(btf, &args[i]))
> @@ -9528,18 +9632,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			return -EACCES;
>  		}
>  
> -		if (reg->ref_obj_id) {
> -			if (is_kfunc_release(meta) && meta->ref_obj_id) {
> -				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> -					regno, reg->ref_obj_id,
> -					meta->ref_obj_id);
> -				return -EFAULT;
> -			}
> -			meta->ref_obj_id = reg->ref_obj_id;
> -			if (is_kfunc_release(meta))
> -				meta->release_regno = regno;
> -		}
> -
>  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
>  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>  
> @@ -9585,7 +9677,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			return -EFAULT;
>  		}
>  
> -		if (is_kfunc_release(meta) && reg->ref_obj_id)
> +		if (is_kfunc_release(meta) && regno == meta->release_regno)
>  			arg_type |= OBJ_RELEASE;
>  		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
>  		if (ret < 0)
> @@ -9747,12 +9839,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		}
>  	}
>  
> -	if (is_kfunc_release(meta) && !meta->release_regno) {
> -		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> -			func_name);
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>  
