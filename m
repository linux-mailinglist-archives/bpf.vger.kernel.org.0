Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79BF6925FA
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjBJTCP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 14:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjBJTCN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 14:02:13 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B265688
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 11:02:11 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AIRB0n030846;
        Fri, 10 Feb 2023 11:01:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZEl0Iunf0VZYBCx+BC/tJfPeH5tIGR468pee9501OuE=;
 b=YyoQ1YCVyZ3Apekj3+sTTBtN5ruUEPy6ZiRm4Iy0Bgk1Ux7FyUowDP/YnEpb33y+Y9c+
 YvkLWes7brcGJIs6yikMvVgia6RUJfiLUKWHHu5g9xibxKfNF5q9oNMu3QfcbdRF/w7+
 3fQOJd3M2Wgj+YvHw2BLKGhJvUOSZ1LgLjcrbakdDQ+BsD3gTzHaL3buqFJzAwoNE9Lz
 RuxRYqUxYWTHKHLrK/jepTrakajMbFQ157Yb3rKVRGur27H/PYnfSn5HfZmULnIiPP4F
 Om4NILKtfyXJ6ubG/u0Ru6jz1PhbtuusBCeI29zlxV1I/kYNutpSfHCU/KuVDZmr1cjf Og== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nn1bxu6g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 11:01:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN9qxO2IYC33UKFICUVVNKRojkcbdc4xay5S85hUICL5pJfeI7vN80y2S8c/CgdgWMIw/DkIoRMnGlBVCDXyV+2l9GA9pf0sZr0kmjZHLzIWi69MhvUX7JKPp9OUMqkEl/5nIZeH+HatXHVsZ0mlTPrJ42H+PklclUeKzg4AFPrpu0kCuEtAIslmLN37skey/wZg271iWOSV12Sxl2+kWyNQUOGyQv80U8E7cJrY+uGJ3+33kasN5KjWpmLXiP/OqD8kOjYsWv4mog8FwBotoG4goW7MxFmupnbifHqKljPDWIx2gTEelVwYJNL6D6Du/oW46T+UeZ3y1cabjAZfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEl0Iunf0VZYBCx+BC/tJfPeH5tIGR468pee9501OuE=;
 b=irlmszag0RbcE5e2MFdm3w0rcQ5nVzkNdtL/Yd6JdbLKiFrq56yepRawlbr4lnBykLP4VJSKWuEH5yLcrrnTIqqZtSM9ZzPcbMLo+dYCoo+WbCx6oHByoJOnC3DzCQwX/Q2fE5W7Na5K93LMoZUsEMsvv4ScfqFe3r+DUguocvHxiphT8FkLLwvKR5lTI1W9i90MyP+EiV1k7zh7LUEEFid/KG3NoVre/r1HlwdOGulKNF15s/KabeQZ5dRBbscZ2YG/5npAZztf5YXrJ5aLvonY6gPeE0qbott+FRxSJZdqhUQDic8w/t0d79zkA9YDJWgQeAUm2rTKa9BKTd+Y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by MW4PR15MB4635.namprd15.prod.outlook.com (2603:10b6:303:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 19:01:53 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd%5]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 19:01:53 +0000
Message-ID: <45e80d2e-af16-8584-12ec-c4c301d9a69d@meta.com>
Date:   Fri, 10 Feb 2023 14:01:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
 <20230210135541.xtwn6wzng7mspgrm@apollo>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230210135541.xtwn6wzng7mspgrm@apollo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E00.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1a) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|MW4PR15MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: f254ee34-085a-4616-9e43-08db0b994577
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8Q1Ry3IsyaZQKRpW2OV5hBQG1VgNX+EWrrCiI/fTkfGoANi7rc3uDPWWyXP+P0+63o6ppxJzrqHC1AHOkgGmskL+dAlCLULoNA76KA8AoK1fs8/2dxjEaPa8ggw4wIJMexA6gM6WEvzhnYq4uSkwn7H58zcMP4jCpz4GTR2ilva41qNmeXrGLIJn6uziX47M3sAD7aYYgEWLcFqSiogUeeQ8lJKqHnsnkO6yhGnEX0lQdTZ8BYnAz+ijPU+op0sBAg1Ln+IA2eyPe9T+zPi2V50zfn5FsbYiLyoCTwcV/sFmTY1Em4PY4hPiznQGVjMq36htYandpwHn1FFkucB3+/4XNMMTpdbuxgoIDrehfpyOSj++SgKIYtqSGm7oPHAM1CuA6Q0NyQKuqyZhdarhsFhB8BAxuJDezxqBrFFMYoVtSCCa3LiZvRx/bNdUwZ7c0fiLJwPI6sxbYCH45jombTkxKZEErZEvPOrVbfGTIk8T5ZWPDLIUpRB7S1j0ceRasWVEq5KR0GHUsVjVWVkkoO6dQmRhFAzjpy48dSDaXswJw/+kqihM03XTXXFh8OmB5VmFCMdFKBonXUzORpNp38l3D28Ytbm1w/KUU9BXwvoQ54MnRhoegyTnSkUcBE9O5/r/0AgsDnS0CBHu6b8jZFpe6LtNE4ckc9fHp6nqhOIfXOiL7LL5rIOvTUC1qcKQ1H6uPpwAlgy1IEHaD2OWgssfpTkBV0v+gOqumwy2E0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199018)(86362001)(2906002)(38100700002)(31686004)(6486002)(2616005)(31696002)(6506007)(110136005)(53546011)(6512007)(186003)(36756003)(316002)(66556008)(54906003)(66946007)(83380400001)(8676002)(41300700001)(66476007)(478600001)(4326008)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytzdjVySTVnZHl1cjd5aElQUlJJb2JURFhSWTBySXFYUC9KNVU3UDdUSGpl?=
 =?utf-8?B?SGdubUdPVVZwMVh6TGppSkxjdDFQaXlTQjk4L0w0TlJOUTBlK0IrUFpDQlRR?=
 =?utf-8?B?Q2tveWN5dTlJMVJJaUlHT0M4SVIydEJ3K3hEWVVPa09Za2t0Q2hCZ1A5NHFU?=
 =?utf-8?B?U2dnd0NIWjBlSlNrM0VROVA5UCsvRmlJUmhWU1ZDRWdhc0NnWDVtNGNaSWIv?=
 =?utf-8?B?OExDRllTUzhrMVJIUElicmdZQXdjRThuRGNXYVRZVjU0MGp4Qmhna3MxcnZ6?=
 =?utf-8?B?aEs1UXQrU2RhZ3NPUDBrOEsxUVJOZkEvd2xLdFNXaFR5c3RzeWZZSXllSzNl?=
 =?utf-8?B?eTMrclJzY1ZqZUZkUDdRclUwV2pmUnFKakZxQ09wYXdkVXhRWXBmV1RhMVlW?=
 =?utf-8?B?V1UxbTczWExNQlVjejJ1cGNZU2JycTJzRVdHdEppM3pZdklOVElkcFU5NDVx?=
 =?utf-8?B?bTJqRllhN3BueUk5UlliSGw5WkJ1ZHFpQ3NBT0NxMnhWeG9pck9TbjYzNjNT?=
 =?utf-8?B?aW5XZUhtK0VpdytmMnRSMUdYY2JkTjNZa3BuVzlodjhGb0p0ME1ERjR6Wmt5?=
 =?utf-8?B?U2hyN2JFaWZZc3JwN01PWm9oMkZPc3V5b2NycFM1dDU0MzlzSkFNYkFRZEFM?=
 =?utf-8?B?QmFtbiswaDRmdlBDeWZhVmo5NlFvbmhjMFVUcWZHNmFkQlJGcjBrYUVPZnlE?=
 =?utf-8?B?dU1ITm55SWx5MnNpaFpQZ2UveFI1K1lPdnJlbXNtSzBGdnBCQ2NwN3lqNjZN?=
 =?utf-8?B?S2dXRkhaOERwQWUraEUySmxUaVllNHZVNXd5dlRNRnZEQk1qNVJQUzNFSUFP?=
 =?utf-8?B?enVlYVpmZ0FHN044NHd3dUxuTDNXTHRBZ2prUTU1eVhJV0s3U2Y2SmxNNWFw?=
 =?utf-8?B?Q2NHS3JqRUJVWW5wSUdxOTRrSmRQeitkV1BxTTlMcTVkc3RNSGlzV0lvaDN2?=
 =?utf-8?B?NGRuWU1qRXUyTXhLcWxHejB3YWJ6UE1uZ1d1bmQxWGJMRTdDRE13M3NUOG50?=
 =?utf-8?B?cC9LOTlwN3dSUGxFSkRsakt2VENZWkczUnVmR01yZUtBN3FVNUlOUW5TMUV4?=
 =?utf-8?B?cVdub3MxMVVMSWdTanVzTWs4WkhDRnlCUWkxNHNFbCtLKy9SajZGTy9JR2pQ?=
 =?utf-8?B?bWpQdnFBMWpYNTRNckRLeHFhc1NocUh3a2ZGcUhrYzgvNE16cTVnVW1HbnNJ?=
 =?utf-8?B?UW54WDJRcHFMazRYTmg0ajJOUXVXMWZEUkRUQ1MwVThBYUhNZWY3aktGSHBI?=
 =?utf-8?B?VXhDb1FPVFNwQ25DVDI1bTZhNXBkSlArajdYdjVBK1NWYkxBN21GT1VSalpW?=
 =?utf-8?B?bWRZMXQ5d1JRNUd6dklTRFpweUExUjIyRFRBREs2MkxpR1R1eFpud3hnYmtD?=
 =?utf-8?B?YjZUbVM1UkU3OFlJN2JDUWVyVEwzSFR1Wk9KTXVCSG85M0t1SVl2eGlPYnl5?=
 =?utf-8?B?REl4UGQ3NGFrUUNUM2hiUEVHL3NXMWFiQThMR0YrMkpnRFBwNEtza25GRURJ?=
 =?utf-8?B?MEx6c2N2bU5UVnhYV1NFUWFqV0dDQ3p6dHF0cEQ0MUt3dTN1Ti9ZaWlpQjNu?=
 =?utf-8?B?U3VIRnk4YmwxYkhram1Qc0p3RFJjOUtLMENNY2FPbkFBV21FL2RCR3dML0Y2?=
 =?utf-8?B?RWgwSHdMcldHSlNBY2ZMMlFPOGVRTGdPRnIzOFNGcWhCN3ZXSDhYRzF5dzNo?=
 =?utf-8?B?V0ZmRnMvWmo5a0REeUQ5b040SGRXMkVWSG5oc3B0MklldGVsaG4yU3Ezazg0?=
 =?utf-8?B?R1ovVG1Nd2VOd215aVJ2Vm9jSmo1ZVZGaUV2UE15OHdqTzdHZ1pyWEJyV2hx?=
 =?utf-8?B?OG1SblE1ZWZFbDBObGlHY1IxcTJRNk11S0hHcWZ5NVkrbkZMVXhpeGZIckND?=
 =?utf-8?B?Rm85aEcwaFhMRVErRXNvRmdIbjhocXhENTlwWWRTVFNkOHpCNWYwNWVjS0Ns?=
 =?utf-8?B?NUE2NkxDNnVnWjBJcFZZS1VKVWRET3c0M0dmSEN3S25iUnRLQ0E0S3ROdElr?=
 =?utf-8?B?d0dZb0x4N1FvZjM1Umszbk51K3RtQ04xRnZPMkhwdENXdnVGdzZ6K2haaHFP?=
 =?utf-8?B?SjlJNW9RNkNFdlNwMmNNU1p2M2VOdW9LQVZOcWR2d3hqamdPQkRnYVpma3E4?=
 =?utf-8?B?eVNPY0lLUUVHampSeGwvU3dTWmc0UTVETmhOb3ZXVDhqSlJoL1dWcDdBS0Yx?=
 =?utf-8?Q?GtN73L4W5pEZDo7KGecgrt0=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f254ee34-085a-4616-9e43-08db0b994577
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 19:01:52.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0BOTOO0E5KA0J1rPPLWhspo2AK+bcfzyM62g7HtDi184NPWx/nJ4y1WBohkQfj5O99EJs/itaYoxM9Kk1Nstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4635
X-Proofpoint-ORIG-GUID: EQ3MXCjNkdhtr_cPXWnZ1B_fPlm2b_Kg
X-Proofpoint-GUID: EQ3MXCjNkdhtr_cPXWnZ1B_fPlm2b_Kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/10/23 8:55 AM, Kumar Kartikeya Dwivedi wrote:
> On Thu, Feb 09, 2023 at 06:41:41PM CET, Dave Marchevsky wrote:
>> Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
>> that require handling in the verifier:
>>
>>   * both bpf_rbtree_remove and bpf_rbtree_first return the type containing
>>     the bpf_rb_node field, with the offset set to that field's offset,
>>     instead of a struct bpf_rb_node *
>>     * mark_reg_graph_node helper added in previous patch generalizes
>>       this logic, use it
>>
>>   * bpf_rbtree_remove's node input is a node that's been inserted
>>     in the tree - a non-owning reference.
>>
>>   * bpf_rbtree_remove must invalidate non-owning references in order to
>>     avoid aliasing issue. Use previously-added
>>     invalidate_non_owning_refs helper to mark this function as a
>>     non-owning ref invalidation point.
>>
>>   * Unlike other functions, which convert one of their input arg regs to
>>     non-owning reference, bpf_rbtree_first takes no arguments and just
>>     returns a non-owning reference (possibly null)
>>     * For now verifier logic for this is special-cased instead of
>>       adding new kfunc flag.
>>
>> This patch, along with the previous one, complete special verifier
>> handling for all rbtree API functions added in this series.
>>

As I was writing this response I noticed that Alexei started a subthread
which makes similar points.

> 
> I think there are two issues with the current approach. The fundamental
> assumption with non-owning references is that it is part of the collection. So
> bpf_rbtree_{add,first}, bpf_list_push_{front,back} will create them, as no node
> is being removed from collection. Marking bpf_rbtree_remove (and in the future
> bpf_list_del) as invalidation points is also right, since once a node has been
> removed it is going to be unclear whether existing non-owning references have
> the same value, and thus the property of 'part of the collection' will be
> broken.
> 
> The first issue relates to usability. If I have non-owning references to nodes
> inserted into both a list and an rbtree, bpf_rbtree_remove should only
> invalidate the ones that are part of the particular rbtree. It should have no
> effect on others. Likewise for the bpf_list_del operation in the future.
> Therefore, we need to track the collection identity associated with each
> non-owning reference, then only invalidate non-owning references associated with
> the same collection.
> 
> The case of bpf_spin_unlock is different, which should invalidate all non-owning
> references.
> 

I agree that if we had "data structure" or "collection" identity we would be
able to make this optimization. I also agree that such an optimization is likely
necessary for good usability in nontrivial scenarios. Alexei convinced me to
punt on it for now (over VC, I think, so can't link a thread), with the goal
of keeping complexity of this series under control.

Since "invalidate all non-owning references" is a superset of "invalidate
non-owning references associated with a particular collection", I think it's
fine to proceed with this for now if it means we can avoid adding collection
identity until followup. But I do plan on adding it and was thinking along
similar lines to your struct bpf_collection_id below. Which brings us to
second issue...

> The second issue is more serious. By not tracking the collection identity, we
> will currently allow a non-owning reference for an object inserted into a list
> to be passed to bpf_rbtree_remove, because the verifier cannot discern between
> 'inserted into rbtree' vs 'inserted into list'. For it, both are currently
> equivalent in the verifier state. An object is allowed to have both
> bpf_list_node and bpf_rb_node, but it can only be part of one collection at a
> time (because of no shared ownership).
> 
> 	struct obj {
> 		bpf_list_node ln;
> 		bpf_rb_node rn;
> 	};
> 
> 	bpf_list_push_front(head, &obj->ln); // node is non-own-ref
> 	bpf_rbtree_remove(&obj->rn); // should not work, but does
> 
> So some notion of a collection identity needs to be constructed, the amount of
> data which needs to be remembered in each non-owning reference's register state
> depends on our requirements.
> 
> The first sanity check is that bpf_rbtree_remove only removes something in an
> rbtree, so probably an enum member indicating whether collection is a list or
> rbtree. To ensure proper scoped invalidation, we will unfortunately need more
> than just the reg->id of the reg holding the graph root, since map values of
> different maps may have same id (0). Hence, we need id and ptr similar to the
> active lock case for proper matching. Even this won't be enough, as there can be
> multiple list or rbtree roots in a particular memory region, therefore the
> offset also needs to be part of the collection identity.
> 

I agree with your logic here: the logic in this series will consider your
example code a valid program when it should fail verification.

Since there's no support for "shared ownership" added in this series, we must
prevent an object from being part of both list and rbtree in your above example.
Adding "collection identity" as you propose seems like it would be sufficient,
but would increase complexity of this series. Alternatively, we could add a
small patch which causes btf_parse_fields to fail if a struct has both
bpf_list_node and bpf_rb_node. Then a "collection identity"-focused followup
could remove that kludge in favor of proper logic.

This was an oversight on my part, I wasn't separating "node can be part of both
list and rbtree" from "node can be part of either, but not both". So I see why
you mention this second issue being orthogonal from shared ownership in the
other subthread. But, at least for our current internal usecases, we always want
shared ownership, not "part of either, but not both". If it's possible to
turn both off for now and do "collection identity" and "shared ownership"
followups, I'd rather do that and ship complexity as gradually as possible.

> So it seems it will amount to:
> 
> 	struct bpf_collection_id {
> 		enum bpf_collection_type type;
> 		void *ptr;
> 		int id;
> 		int off;
> 	};
> 
> There might be ways to optimize the memory footprint of this struct, but I'm
> just trying to state why we'll need to include all four, so we don't miss out on
> a corner case again.
> 
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>> [...]
