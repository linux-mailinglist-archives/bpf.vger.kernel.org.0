Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AD62A069
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKORd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKORd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:33:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813062CE3A
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 09:33:22 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFHBS6m011227;
        Tue, 15 Nov 2022 09:33:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=FYsYQiMrtbB7UmZFU2mescmQGLSPD/0aMWppdUs+Z8c=;
 b=CGRuY/NROjG0VUS/Zn+3NyFZQbUe0PbT39bsJpRYRf/pC4poWtZ2GKnp0IQk2axiZ+FO
 l253Trcd2FbhMAyNvdgllZhUuIK3+Wl4vDsD3WG2NRvDG3ZhWfK80OlguVOWQL1MKEeo
 t6XnlrTxjH+NS+hz+HHaTCYHVUMdOMHoyhlYVzUsgiDXEnP5suCTCYGDHjaWUKILioAA
 izJLwUu3EFpWr0oGa/CtKZ/XkYMxTXuPWlNjCu1TM0bwF1eUw6UsLICqaTZzT4DnyOG3
 o1UFI/xNaS5/9x7Km63vWcaFCWAKEhgwV9v5vHR1WaUL073BhlPiQfyXXAuvNB12Zv3e cg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kva7fu5mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 09:33:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4xycsSNWxFwSXPIXw/GfKJoan0w0AbTO6iC1k3PZucGwjbFlbII6MqSyHP21Q7V92qeaDTpzOtVw8BHdfhdfkMLyv3rkFpEk35r6AUvkacRY4d7LHLma79ptb5Ulqkqj9tMBt9aPk0PIFvhsGgKRN9JlBvY71beQuJq/Bi845KHZQHpH3cMRxLkCIoFQG2ir+mqgIAugx3bu3kyGtkBV5Iyw7nWp3F2cpJm+H4d/fvtJJB9mVRiT2cJdqLYXny3e46hNPiatZNRIzm4RZMJrvCt5ZtaQ0PKVq5UUFbM0Wy+3Cnpon3WZlwZroCGYWjpnQDPFTBnTjHtz34ueVj8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYsYQiMrtbB7UmZFU2mescmQGLSPD/0aMWppdUs+Z8c=;
 b=XoaCaOHqtxt4w42SNMjPyPPky9jRgWra+cBuL+q6Tjsnvj48ih0aB0M0qRi1vcebSWFrho4bhK7gHvAJ6YYolybnAn2nCQUwGPVe3iiBt3gpAnz9Z8RrsHVbbhb2F/Z7qoO8WUIU3IzA8kWtdipH9dhGE9WG/EqCAw5gdSuwnQXBx5Yfc07qn5ilz2Fxs4rhGplMPHDzDa/m8bWAa1SWwrxqLZzN4L+d2FIiwm8EKDAdP2FsPUIbGnhNOZi7A//w54l5TyZt+XynYb4zSL/myhPdNyxxP8WCOBRzN3vvhrG3fvCPV8OCSWlkWow7AI0o6gzAoPCkS9fYd5UqFQu0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB3679.namprd15.prod.outlook.com (2603:10b6:208:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 17:33:03 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 17:33:03 +0000
Message-ID: <3e726a4f-5e26-47c7-ddfe-0cd73778f4b5@meta.com>
Date:   Tue, 15 Nov 2022 12:33:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v7 12/26] bpf: Allow locking bpf_spin_lock global
 variables
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-13-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221114191547.1694267-13-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:208:e8::30) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|MN2PR15MB3679:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc8ce4d-614b-47c1-2d5b-08dac72f732c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwnyDaj46M4qqk5A6z2z0QwqB17Wdvsjn/6L1Ou+WalefqgTrcYIzM0tm3RdCbj7NRvWWyLLknFPAL5raAIqrwxbXHGxXYPxlt/iCUq7f/dYHgv6yCIZBA3GpggxDdx1CG7+YvVKeAj+4Q2jjiEnvkSwvZS1lonAUR1NxF0LXepMLcIBnYe/EeCDCXCP+pfB+zRhOrdUxW1Y4lIn6z4PAngABqskUH/85sbFUNoMiFXHXh5FMSZu+aN3RU9J/4Hod18rpNgwYAv13Hol2qAyGQX3dW/LTQHuNTakzct8LtHofmxqSTAFbYRsIjcX/MUkdBrOtJ68vv0Xjnt7xEO4ajfZGo3G1m7R14ZiDxZZYS22vEyftyVkB/5WzUXbWbwT7KpJZyDDZrl4cqGUFCaIsPgskwGwvy3qKujtU+dao/w6PUlRVd3azziTlR3lYlu7CRwR6CFHFdiUbV1bJ9BM8xEHpUUEy0JjvIS8QoULQO3ueih+lmeDQGZ6a6Ss3tx2pxImBsuCpRQPykmO/OKCNhsstwnqVIG4U0MU86BGThCpAUur2WnzmWvqgracOD09+mKBwNokrz3Gdne4748DVm6cYuZT/gmKSu5SRluoq3UnREOLBJBedqzA1qZ24SmLJ+wE9lduJjIXcFQRh6CHYv4dpLvnINP/klHRpA1nqsvaulyH/rW0ldoe5rfAp0HP9nYO+OSOl47iXMTumDdUyyrxrKLD7pZNDfgbSrledOcI/p1+27IRZ8JCHKRq43zItgze5E4Eqk7fI4sE2vDQ9mvOic3mEOrwe8WeQYlxovA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(54906003)(66946007)(2616005)(4326008)(31696002)(66556008)(36756003)(86362001)(186003)(41300700001)(6512007)(66476007)(5660300002)(8676002)(316002)(53546011)(83380400001)(2906002)(8936002)(31686004)(6506007)(6486002)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEsyVjdoSUJSdE1DUDVBZXdHdGptbWhLRmtUY1J4akQ3bml3MEVoMytqWldR?=
 =?utf-8?B?QnJGT1M1QWhGQmpHRlhuTk5XU2xJN0QrdThPNGVPK1V4dUxyc0pwQ0xPNjNl?=
 =?utf-8?B?ZUpXK2pxYkYydzlZblU1bk1FYUl0aXFDMVRCYmVIWStBd1BIVzVIaXdRUmtr?=
 =?utf-8?B?c3pKUndJRzlHMG5VTVlsUXpaNmJQdUdtcmx5Q0FnejkrdGRVMkxzbFRhSkNj?=
 =?utf-8?B?V1M4K3pDdm9TZDVzMUtabTFBN0FoTVZQbkowMWlKTTZJR2FOT3A0eERiWS9X?=
 =?utf-8?B?aUxSRTEvbTJxbUxCMi9pdjgyWi9FeUNXS1ZPaTVuZ0Z5bDJKbGM3UE9wcmpa?=
 =?utf-8?B?dTE1NGdHa1hhSUlHSU5nSFV6Z3NTUE1HVEFPQXc1MGZIL2NESXJ2ZnhFLzd0?=
 =?utf-8?B?Y2dUTlVHTHhhZy9lZ0FiS1FGU2NHZUt1QWUwZHFEdGx0SndiYXBkNVNrekc3?=
 =?utf-8?B?SXlocEIxL2NVS3NYZStveC9sVjBGQTE3aDlEeTNJNVlEd1dsdVhqVDF6aFhK?=
 =?utf-8?B?empXbmpsYlNkU3V1TXRRNTlLbEdkbGNTZUNPbnV5bWw2ZnJLeXhKaFcvU00w?=
 =?utf-8?B?UXZCT0F1Wkdjb2Q2VjViOG13ZzRpMUFYWVplaVd5MFdsVUNRRWNwS1N4N2pK?=
 =?utf-8?B?aE14ZEo2RzQwVzdVSTV0bm8ySkNHNk9oSnF1Y1ZSOHA2NEJ0Yk9qa0NWakZu?=
 =?utf-8?B?TXpmK2RTVElYOVhEU3FpcktxbTh2eGY3dlR0VHJtNkZHWTgzbGdPbXVBWER1?=
 =?utf-8?B?ZWVQbVpQeG95MStrajc3RzE1dllvSkVSaDhZM1N5VnNGeHVVOEhGRmd0L0E4?=
 =?utf-8?B?a01ocEFKT3pYS1AzdHMzTDlHSGdFbThyaDFYOVdCYlBXOVBOMmhIWDBaSDl3?=
 =?utf-8?B?dGZkQ2g0WmgrQ0R0cE9kbDJjY3hhNVFNWGpyTitVdkJ5N21ZTW9SbGJZNnRo?=
 =?utf-8?B?UHM1b3c3Sk5ITlp6WVd5azc1cW1raDU2citUS1dWQU9wNEk2Njc1OVgxNWY1?=
 =?utf-8?B?UlNqV0d4aDFXU3liMjBBZWd2OUJvYUVJZUg3RjFZZTFwSENna1d2VFBIdUZL?=
 =?utf-8?B?MXd1dWJjR2Ira21IanpCVFhYZmRLVDRLY2RUQ1J4ck02bjA5WFZGTmVtYkM4?=
 =?utf-8?B?MGdnWVFVTXVYMXg1WXhjYk1OczRIRldjQnBFSkt0Sy93STdEcmFPQTdTa3Vm?=
 =?utf-8?B?MnJRNFFGYitkbFlVUDNyamp1a2xUMzBXN1lhdGdUTGRORzRudFkxT3FSNC9W?=
 =?utf-8?B?ZEY5WER0VjVQTnVCY0lsWXh2MUovRWlYZld6endpbjh2U0N0R3hTTVlZVW8z?=
 =?utf-8?B?dzVqS0lhak1ZdUhici9iL0p0RnMwS1Zxa2hlYTNUTFo4MGNtdk1nWmVjUzk4?=
 =?utf-8?B?eWZoaVZGTnhackN4b0ovWFc3L2cvQXFKaFVkMjMvOXREQ2pOWCtvMWpMSXFx?=
 =?utf-8?B?R0xSVWYyUk1tczQvZnc4Q05uNEVObld6SVZ2ZndTS0FLcmF3SFBsUjZRSVNz?=
 =?utf-8?B?L2NSbitIcjMyeEMvOXRnR1ZZb1k1UUZIN240QURONDZnczJyM0xnZzdhSlZM?=
 =?utf-8?B?UW9hQ1hhK2h1aUVIQWRGM3BSRkY5bjFzVmlwckRoZGxYVnJZQ01KdEp4bjhq?=
 =?utf-8?B?MkZQNmZwRHI2aG1wdmo2VEpHZzBnNWJ4RTBRWWowQ29lM21jNUtSajg2Rkpo?=
 =?utf-8?B?enNCbFl0bi9qWnJLU0VNOVZlTXp1MHdhRVRaVWVnd3FVeHpCVzQ3cXNZdGZX?=
 =?utf-8?B?SlBEbDFVa0I1NVFOKysvcGhxYWttY20rNkVGcytPcUtRQVFCMHpmNFM4cU12?=
 =?utf-8?B?Umc5OEYvVklYQ1lyTWdqcFZQWk9YWVA1L3pGQ2VGVDJkMmo3RnVHeHNsaVBp?=
 =?utf-8?B?cDdZT0xvMlBrU3BFb2U2cUROSllpZmdYbHhCNlBhaUpFRU8vTE41bnF0c09l?=
 =?utf-8?B?VzhyZStzWXJNRENCbGhHdmhFZncvWE9hdndxaEpRK3hsakovbGx3VTFvZ1FV?=
 =?utf-8?B?d1dCV2tyc3YwOE8reUVnN0c1aEZ4ZVpzNWxLUklPM2ZVb25ialprTDJxQ0FR?=
 =?utf-8?B?cXVvUm1uVU03L2tyTHBZYmRUVkRCaFlhRTB0OWFvYU4vV0hjeWtSRnBPTUEv?=
 =?utf-8?B?S095OTBpaVlMakxHcEFSakRQMVFZNlhseFg1anpnYkk1cnZPWXdTWXU5QU8v?=
 =?utf-8?Q?xfVXXkLQqPItfJNtXs3N/0s=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc8ce4d-614b-47c1-2d5b-08dac72f732c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 17:33:03.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viv1iq9PR1fQ2AUS+u+mHLqVvQpUIfDG0up25zV4lVDnVZuakjxVtYtnzUnvR65l70O0geku1ESxL7mqPnZf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3679
X-Proofpoint-GUID: CsRovq49wLf78zMUI6uNNwQ4kno0Utxq
X-Proofpoint-ORIG-GUID: CsRovq49wLf78zMUI6uNNwQ4kno0Utxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/14/22 2:15 PM, Kumar Kartikeya Dwivedi wrote:
> Global variables reside in maps accessible using direct_value_addr
> callbacks, so giving each load instruction's rewrite a unique reg->id
> disallows us from holding locks which are global.
> 
> The reason for preserving reg->id as a unique value for registers that
> may point to spin lock is that two separate lookups are treated as two
> separate memory regions, and any possible aliasing is ignored for the
> purposes of spin lock correctness.
> 
> This is not great especially for the global variable case, which are
> served from maps that have max_entries == 1, i.e. they always lead to
> map values pointing into the same map value.
> 
> So refactor the active_spin_lock into a 'active_lock' structure which
> represents the lock identity, and instead of the reg->id, remember two
> fields, a pointer and the reg->id. The pointer will store reg->map_ptr
> or reg->btf. It's only necessary to distinguish for the id == 0 case of
> global variables, but always setting the pointer to a non-NULL value and
> using the pointer to check whether the lock is held simplifies code in
> the verifier.
> 
> This is generic enough to allow it for global variables, map lookups,
> and allocated objects at the same time.
> 
> Note that while whether a lock is held can be answered by just comparing
> active_lock.ptr to NULL, to determine whether the register is pointing
> to the same held lock requires comparing _both_ ptr and id.
> 
> Finally, as a result of this refactoring, pseudo load instructions are
> not given a unique reg->id, as they are doing lookup for the same map
> value (max_entries is never greater than 1).
> 
> Essentially, we consider that the tuple of (ptr, id) will always be
> unique for any kind of argument to bpf_spin_{lock,unlock}.
> 
> Note that this can be extended in the future to also remember offset
> used for locking, so that we can introduce multiple bpf_spin_lock fields
> in the same allocation.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 10 ++++++++-
>  kernel/bpf/verifier.c        | 41 ++++++++++++++++++++++++------------
>  2 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1a32baa78ce2..fa738abea267 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -323,7 +323,15 @@ struct bpf_verifier_state {
>  	u32 branches;
>  	u32 insn_idx;
>  	u32 curframe;
> -	u32 active_spin_lock;
> +	struct {
> +		/* This can either be reg->map_ptr or reg->btf, but it is only
> +		 * used to check whether the lock is held or not by comparing to
> +		 * NULL.
> +		 */
> +		void *ptr;
> +		/* This will be reg->id */
> +		u32 id;
> +	} active_lock;

I didn't get back to you re: naming here, but I think these names are clear,
especially with comments elaborating on the details. The first comment can
be clarified a bit, though. Sounds like "is only used to check whether lock is
held or not by comparing to NULL" is saying that active_lock.ptr is only
compared to NULL in this patch, but changes to process_spin_lock check
which results in verbose(env, "bpf_spin_unlock of different lock\n") are
comparing it to another ptr. 

Maybe you're trying to say "if active_lock.ptr
is NULL, there's no active lock and other fields in this struct don't hold
anything valid. If non-NULL, there is an active lock held"?

Separately, the line in patch summary with "we consider that the tuple of 
(ptr, id) will always be unique" would help with clarity if it was in the
comments here.

>  	bool speculative;
>  
>  	/* first and last insn idx of this verifier state */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 070d003a99f0..99b5edb56978 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1215,7 +1215,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>  	}
>  	dst_state->speculative = src->speculative;
>  	dst_state->curframe = src->curframe;
> -	dst_state->active_spin_lock = src->active_spin_lock;
> +	dst_state->active_lock.ptr = src->active_lock.ptr;
> +	dst_state->active_lock.id = src->active_lock.id;
>  	dst_state->branches = src->branches;
>  	dst_state->parent = src->parent;
>  	dst_state->first_insn_idx = src->first_insn_idx;
> @@ -5587,7 +5588,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>   * Since only one bpf_spin_lock is allowed the checks are simpler than
>   * reg_is_refcounted() logic. The verifier needs to remember only
>   * one spin_lock instead of array of acquired_refs.
> - * cur_state->active_spin_lock remembers which map value element got locked
> + * cur_state->active_lock remembers which map value element got locked

Maybe remove "map value" here? Since previous patch adds support for allocated
object. "remembers which element got locked" or "remembers which map value
or allocated object" better reflect current state of spin_lock support after
these patches.

>   * and clears it after bpf_spin_unlock.
>   */
>  static int process_spin_lock(struct bpf_verifier_env *env, int regno,
> @@ -5636,22 +5637,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>  		return -EINVAL;
>  	}
>  	if (is_lock) {
> -		if (cur->active_spin_lock) {
> +		if (cur->active_lock.ptr) {
>  			verbose(env,
>  				"Locking two bpf_spin_locks are not allowed\n");
>  			return -EINVAL;
>  		}
> -		cur->active_spin_lock = reg->id;
> +		if (map)
> +			cur->active_lock.ptr = map;
> +		else
> +			cur->active_lock.ptr = btf;
> +		cur->active_lock.id = reg->id;
>  	} else {
> -		if (!cur->active_spin_lock) {
> +		void *ptr;
> +
> +		if (map)
> +			ptr = map;
> +		else
> +			ptr = btf;
> +
> +		if (!cur->active_lock.ptr) {
>  			verbose(env, "bpf_spin_unlock without taking a lock\n");
>  			return -EINVAL;
>  		}
> -		if (cur->active_spin_lock != reg->id) {
> +		if (cur->active_lock.ptr != ptr ||
> +		    cur->active_lock.id != reg->id) {
>  			verbose(env, "bpf_spin_unlock of different lock\n");
>  			return -EINVAL;
>  		}
> -		cur->active_spin_lock = 0;
> +		cur->active_lock.ptr = NULL;
> +		cur->active_lock.id = 0;
>  	}
>  	return 0;
>  }
> @@ -10582,8 +10596,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
>  		dst_reg->type = PTR_TO_MAP_VALUE;
>  		dst_reg->off = aux->map_off;
> -		if (btf_record_has_field(map->record, BPF_SPIN_LOCK))
> -			dst_reg->id = ++env->id_gen;
> +		WARN_ON_ONCE(map->max_entries != 1);
> +		/* We want reg->id to be same (0) as map_value is not distinct */
>  	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
>  		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
>  		dst_reg->type = CONST_PTR_TO_MAP;
> @@ -10661,7 +10675,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  		return err;
>  	}
>  
> -	if (env->cur_state->active_spin_lock) {
> +	if (env->cur_state->active_lock.ptr) {
>  		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
>  		return -EINVAL;
>  	}
> @@ -11927,7 +11941,8 @@ static bool states_equal(struct bpf_verifier_env *env,
>  	if (old->speculative && !cur->speculative)
>  		return false;
>  
> -	if (old->active_spin_lock != cur->active_spin_lock)
> +	if (old->active_lock.ptr != cur->active_lock.ptr ||
> +	    old->active_lock.id != cur->active_lock.id)
>  		return false;
>  
>  	/* for states to be equal callsites have to be the same
> @@ -12572,7 +12587,7 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_spin_lock &&
> +				if (env->cur_state->active_lock.ptr &&
>  				    (insn->src_reg == BPF_PSEUDO_CALL ||
>  				     insn->imm != BPF_FUNC_spin_unlock)) {
>  					verbose(env, "function calls are not allowed while holding a lock\n");
> @@ -12609,7 +12624,7 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_spin_lock) {
> +				if (env->cur_state->active_lock.ptr) {
>  					verbose(env, "bpf_spin_unlock is missing\n");
>  					return -EINVAL;
>  				}
