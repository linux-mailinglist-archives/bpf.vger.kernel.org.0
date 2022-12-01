Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50B63E84A
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 04:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLADVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 22:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLADVm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 22:21:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96B17E41C
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 19:21:41 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUJWZjB005699;
        Wed, 30 Nov 2022 19:21:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=YOq4eIpKeCIIMMUMf437PpkkKlv5xFyajJJnlhkbx6s=;
 b=R0vRGGF48Dt6DgaNKLC5ffm/Mwncu/9P2eAV4NOa6bU7czaf5I1Fl3w3YdciWNoOXc4/
 ps/E5Cl6+ZokaSsfxcb+zzipmJakL4quXTKzw42aMBqBcsU98A0l6FHUwXB1C7GSq5TW
 5pDwIbLQDzTYu82LRR1Kf6FAOqtUI5Ljk1H6i8ObdRzL5qwPlLf7Mg+nG/I7pJYrXG5P
 JXBlkKkCVCM0vb7d56QZfsxFF+l/VrtIOeC5LN99gdkI9HsYijVahVO+ptP9DSTITPIt
 USLP3Q36FVK+xEv/KCUQ4gRfu864rF6b9pVEFssm9ZgOc6KkBGzurKIWkFsN9Ue1nLGb Mw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m5mqj97e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 19:21:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3afCHCW7LS/bL1POdE8Wk9/hksg4uv5nvw6irL/+HT8fIXDu0uq9ZNB8DV4N052Fv+6yWyGOeijrF+zE0oXaPRtczJg4PugsciTJ/JykPNeyavXaycRD7P/ntXsVHXcBqYDHBuf41Vr1tqPgvc8Yii1pqmRUsLb11L+AO+isA3DUDT/rJjHKNjb7deErRvw8rUtEVoPtuEP/YXbBFEFljqKxTGGsZPSC6EzazdaLHRe1STXbuGX2fBzfT5X7o/QwJOEfMw++1XND3vT3XC+OYSb79uIjhaLp8NRxkHMHnaJX/x4vWtcZ1nahAQGkIdqSAT1UvzSKrFB2UFDduc3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOq4eIpKeCIIMMUMf437PpkkKlv5xFyajJJnlhkbx6s=;
 b=dDcHTuZuNnTTyacsk/rlceLB9tCguW2zt6Ge9dc9zAlw5S3kQmZh7UBYySwAhEjMfMSL0nJt4HBplkR2WMkDrIa1Jb9XoYNhVClExkePEWynwsB01QG9CsFF7xUFS9XYtEvxq1eaVu1vNjS+zjggogWhZQgqKzn4SH3/SAwvY4Yw7WcopDvuZHX7LE68rGB0vINJ8gjGYoc5gIXz31fNFUYn9nTn+IaY7F2JGomXzwobncIT4YcpKPywvGuZVwryAMdHyhb0pDZC9A/dLziZdR709KRjzViLKelgssNmMKTxclFj+VSiM0OPKDQdh7jgC5tSiH+UZ0rXXZCs5PoD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1821.namprd15.prod.outlook.com (2603:10b6:301:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 1 Dec
 2022 03:21:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 03:21:23 +0000
Message-ID: <b5d46fd5-2693-cd46-9515-700fef1a110b@meta.com>
Date:   Wed, 30 Nov 2022 19:21:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix release_on_unlock release logic for
 multiple refs
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20221130192505.914566-1-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221130192505.914566-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MWHPR15MB1821:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ef10cc-86e4-4944-3cc0-08dad34b1fa0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUvCDDv4cwL8RIF1Q3Uz11y3V9U+ii5tk4jb9zN5+bdvjd0sdx9UgdClZrsThL+y8BJB1Y5vuJdiJbVaOAWBaR8uvaypMdxQB4jUidjQtNwgwVs0UpN8ur28ilEVDD/rhSbcS4mw39ISBRdzeKnJgS8/8WEnr+ywumZaOBl2sPcfwluLu/DXe5dssmN72i2QHkyhHC4ygzqKvcypu1b2qannk6vTvUwzCW+Nz4AiNiNQeC3x/2zDPDQZ2WSNmchsD4g5EaFksUx7ZQTFHvUFcJilEQMvAhVWuU1D2Vz10OQxVneOQFQdO/mneafWHNeTun1I75rTjtCODpymEXSQ42cKUvXae5sAbi9Xr6Wfxum9ZNUsAfQg9bS1UR6qTrOSvl1XaUDFcYsyEgoja7jC1hQ8lTJb9vxMDX4U+l59UZ5F+sxI7o73muuotwwNfkZ9NXL/fn2/AwLgI8mlxAPNzu2hl7IibHBsz7T9rXvwxiG3/wOdOm+zGDQVLo08rhHdHuBx4Q4nckzR7ddQy2WL9cAcP2ZedWdw34bA+82gE4zJYiAgnKqxrVg78WS5BFNkZCzsSi09HvQfVWP/70vAaTjdDcMx0BMd7Wy0PdveGeGTeP0QnFt/QCfu2xtaCrDNkWZK4hHg63faqZ+D/+bXPt/p251xKmZkJWzxisw1skKKZpLzR170y5Tp7YTgO3XKo+68S++HDSqT4fMzdESO/rfnD2N/amW24IdfY8CmcXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(5660300002)(8936002)(66476007)(41300700001)(8676002)(66556008)(4326008)(66946007)(2906002)(38100700002)(31686004)(54906003)(6486002)(478600001)(316002)(36756003)(6512007)(53546011)(6506007)(2616005)(186003)(83380400001)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JiSEhUUFVNWHdBbC9RdGJqVmhzZzhXUWIvU1F2eTljRUlyZjltOUpZVlRj?=
 =?utf-8?B?dTBkcC9rVjZNWUw5VjZJbDFKZ1RaZ0I0NmFVR2ZXQWdDcTVoY1Axb3YzcGRJ?=
 =?utf-8?B?ajRVVXR0bXJOdmNicVdScWJRWlNremVYMENXNnZMQUR5TkNUU251UTRNOEs2?=
 =?utf-8?B?bFA4amtDR2FpSS9pbVQvNUNSZFNLdUxHZllXdXFhZU5CNVRHTHRNS1lvNGxw?=
 =?utf-8?B?eGJHT3VRYXE5Z0lhZFhJTW9vb1lKOHQvVVN5NGNLTkQ4Qnc4cGJ1YWF1em9U?=
 =?utf-8?B?RDVjMzZtUGxUT3EyZ1dta3AzRW5uNVY5cXpXWjdrMkl4ZkRqTUN4M0x2V0NL?=
 =?utf-8?B?ejJDYzdYSlpNMXN4U3pQQWFubWtBbkZ2M2daZktNSXhiV1gvLzBZVVlmdEJB?=
 =?utf-8?B?bE9pMmI2VVgwdUdaaXNKL1lhbEsxeWZjTGFKRFJlaUV5RVI5TDBGOXhsYmt3?=
 =?utf-8?B?dnBWdUhXNjRvc3hFb0lRV0paYzArMWIvZHpmak5lUTdtd2dtWGZ1dStpb29I?=
 =?utf-8?B?aVJHNTBHYjU2UmVlbkw2d253dTdON2tjc3pFSlpQcHluTEVRbGhCVjQxNyts?=
 =?utf-8?B?ZVoyZVpQaWpuRnNrMzZiNGMwaUV3MWNwbjlhTjVFMnRxUjgzREdsYkhUdlRl?=
 =?utf-8?B?NEhSa3hWVmtXQ2hsb0pIc1ZYYXdzZmdOR09lbTcrWm5vWHJBNHg1czQrZk5w?=
 =?utf-8?B?NmpKTDJBNGFUQTFJbC9nTTdEMklwUkQ4b0duUFhLWHMvc1BlYmVuYVc3VUlK?=
 =?utf-8?B?NmoyeUtrSFVxU0xySkZsZkM2Wksza0ZwZ2VuSmxJeDd1YkR3ZUZTZnhFdXZP?=
 =?utf-8?B?TmJLUFE1VTBvdVZYWGl5akZwSnR3M0p0bTVzWmhOMUdPUVJoamt0OXRyckxx?=
 =?utf-8?B?YTFuMElBL3QvVnJoS1dtd25sZGN0YnI2UTkxNmFxcHZGWDlORjliU09zNUlj?=
 =?utf-8?B?Z3c5cFdRTmtCN1NzdGp6dUo0UkJpZGkyb05oYzZ1YklsY0plaE9rZHFSYnRn?=
 =?utf-8?B?MnRYcG9yZzgxb1VEeDl6aGZDd3dQK2Frd1l2Nld6K0traWxvTEdBQ2laNHI2?=
 =?utf-8?B?NWtwMFhBYzFNOC9Ba3hMUkdDdVppcisvM2RrellSVXV2UzRtVElPQmlKaHhW?=
 =?utf-8?B?eU0zK3FuRmdZKzAxQ3NkRHplQUVaS0dsS0RsUDlFbThKODk5MmR4Z3ZYZHJV?=
 =?utf-8?B?UXI2T3l4ZWhFOUxxN29VZ1Urc1lkb1Q1ZlVYU2JWaDBid3ozL05LL2pZU1hq?=
 =?utf-8?B?b0JCMGMwdWVJdEdXaUFVckw5clBnVUI4QW1EeXZaVjR5OUtjdTh0YUNXRGRQ?=
 =?utf-8?B?dDZqaG8wMWg3WUZDZ0Y0TkJnZEI1N0lYRkNQTGh0MUlTUW9JRWFXclhlMnBU?=
 =?utf-8?B?WGVESE84OHA4QS9JLzQ5Z3BmblVxNVNrRDlMc0szTGxwZS9CR0g1LzRTUUJU?=
 =?utf-8?B?N1AxYUM0aVQ1Y3NZUlMxRmI2SmFZYXRjSlh1czlPWFFjTmNLVGNZN3dtTlZj?=
 =?utf-8?B?TmhmK0ltQS9peHNLazRFaXRVK3V2TzFsVkV0eWdUUzVNcUIwSzFFTFhzMm5r?=
 =?utf-8?B?aXRyN2lxdTZOcVJwbjRBdHpBWEtYZmR0ZkUxL0ZTQys3MEZaRlFPamVmUGV5?=
 =?utf-8?B?SjBqRDhjcUJGdXJ3SU9kcVhHSFNZNkZmNGVoUFZ5aDNWUTFKUEp1MWpDV0dz?=
 =?utf-8?B?aWFkTFVROXVvdW9DVk1hdmRML2ZQSW1XZkVRL0lJdHNEbE1WMkJhNGJXTHht?=
 =?utf-8?B?ZUYxOTZPb2U4UVh4c0EzOVdkNTZHUTVrRFZNMGI3emJvKzlmQ2lLVWhRa0Y1?=
 =?utf-8?B?dVJPcXRIeUhZbFNFK3FzK0dNdHM4SG1yajIvRlNCREN0K2JPYUR4NHJJaS92?=
 =?utf-8?B?bENmRmNXemUzMkxsMXNIUDBIOGkwN0RwZ242MmRVZEtneVl6c2trS0dwQlE1?=
 =?utf-8?B?SmV5WDNJZ3U3N3B1V25iNXMwMmxnMUhhcWJuYXRaRHRpYkNrSHc4cGRuak56?=
 =?utf-8?B?YjM0YXNlM0NqTmtqRk02STRBdHhtc2M4RXcrdHlsQTVSUWpMVGxnZTdsd0s2?=
 =?utf-8?B?aWJ4c3p0bmp2Y0t4ZGxGazhUYmdrRDI3Sllhdk9PMTUvUHNsM3Z2MHNXK0RL?=
 =?utf-8?B?REJ1WU5HTVNZS1Vjc2RPZGlObExTZmRreVV1WVBNa1RtT0FRM2Raend2OEgw?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ef10cc-86e4-4944-3cc0-08dad34b1fa0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 03:21:23.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usJiHnqHNm1ahoohTDnOBSqP2m2PUniXhuCIPvQIQYoCuROmW9/W5rDHdK4/IHRB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1821
X-Proofpoint-GUID: 1B1W0bHiFfJqMzdTNylCPBLtqph0JvZA
X-Proofpoint-ORIG-GUID: 1B1W0bHiFfJqMzdTNylCPBLtqph0JvZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/30/22 11:25 AM, Dave Marchevsky wrote:
> Consider a verifier state with three acquired references, all with
> release_on_unlock = true:
> 
>              idx  0 1 2
>    state->refs = [2 4 6]
> 
> (with 2, 4, and 6 being the ref ids).
> 
> When bpf_spin_unlock is called, process_spin_lock will loop through all
> acquired_refs and, for each ref, if it's release_on_unlock, calls
> release_reference on it. That function in turn calls
> release_reference_state, which removes the reference from state->refs by
> swapping the reference state with the last reference state in
> refs array and decrements acquired_refs count.
> 
> process_spin_lock's loop logic, which is essentially:
> 
>    for (i = 0; i < state->acquired_refs; i++) {
>      if (!state->refs[i].release_on_unlock)
>        continue;
>      release_reference(state->refs[i].id);
>    }
> 
> will fail to release release_on_unlock references which are swapped from
> the end. Running this logic on our example demonstrates:
> 
>    state->refs = [2 4 6] (start of idx=0 iter)
>      release state->refs[0] by swapping w/ state->refs[2]
> 
>    state->refs = [6 4]   (start of idx=1)
>      release state->refs[1], no need to swap as it's the last idx
> 
>    state->refs = [6]     (start of idx=2, loop terminates)
> 
> ref_id 6 should have been removed but was skipped.
> 
> Fix this by looping from back-to-front, which results in refs that are
> candidates for removal being swapped with refs which have already been
> examined and kept. If we modify our initial example such that ref 6 is
> not release_on_unlock and loop from the back, we'd see:
> 
>    state->refs = [2 4 6] (start of idx=2)
> 
>    state->refs = [2 4 6] (start of idx=1)
> 
>    state->refs = [2 6]   (start of idx=0)
> 
>    state->refs = [6]     (after idx=0, loop terminates)

I am not sure whether the above is correct or not. Should it be:

     state->refs = [2 4 6] (idx=2)
       => release state->refs[2] (id 6)
     state->refs = [2 4] (idx=1)
       => release state->refs[1] (id 4)
     state->refs = [2] (idx = 0)
       => release state->refs[0] (id 2)
?

> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: 534e86bc6c66 ("bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}")
> ---
> 
> I noticed this while testing ng_ds version of rbtree. Submitting
> separately so that this fix can be applied before the rest of rbtree
> work, as the latter will likely need a few respins.
> 
> An alternative to this fix would be to modify or add new helper
> functions which enable safe release_reference in a loop. The additional
> complexity of this alternative seems unnecessary to me for now as this
> is currently the only place in verifier where release_reference in a
> loop is used.
> 
>   kernel/bpf/verifier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

The code change itself looks good to me, so

Acked-by: Yonghong Song <yhs@fb.com>

> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4e7f1d085e53..ac3e1219a7a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5726,7 +5726,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>   		cur->active_lock.ptr = NULL;
>   		cur->active_lock.id = 0;
>   
> -		for (i = 0; i < fstate->acquired_refs; i++) {
> +		for (i = fstate->acquired_refs - 1; i >= 0; i--) {
>   			int err;
>   
>   			/* Complain on error because this reference state cannot
