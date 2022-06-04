Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0953D4F1
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 04:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiFDCv6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 22:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiFDCv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 22:51:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C281C5FDE
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 19:51:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GmRVD021926;
        Fri, 3 Jun 2022 19:51:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nxzuTp4BvA1JnmIAql7+imuIQqg7We4XyUoFwMWE54g=;
 b=hsPL/VENi2EOkOtaL1j0fMBdo/Wp7ta2cb1Rj77pXwFI0t40nKbAFuRHPn2dUqKDIM3b
 5v008X0PDGgFvOvj2S/0M5JvVNsUuFyUS3vg16LilKKZNb96UIsMlngTkIdxSxjpAMmJ
 06HfQ+x2IVY8ZUSAdhHnBTv0aZhL+CygcWk= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gewq9b8qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 19:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJdqgb/GLSK0VzdzlNAWZwV1LjM+N3SYnTPkRE2Xy2IeWgaAgdwxobfYULS88tUey9woexejJD8+xRkted/4S442TqZeqNpD+ClATKMCxuTJV235YjBCSq4U4u5w33brOCNAdkr1QlNwulVtfCw0AkAWKfg1jPQ8pWpg6tPMZuRwYgj8ONgl7ku3P3z8stkSWQWJlJs4AeTsXCovFHzYUphEgfLq7G4tCIwzon4utdUe9gbf8tusf5ob0ZP4FimEe0EKkH7gipFhHkCntUD4g04GcTMFa630+N1hNrPOWLljjtTgQvyUpOzKSXfaYMc0az5Dx0abPq9zbXMTkCRNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxzuTp4BvA1JnmIAql7+imuIQqg7We4XyUoFwMWE54g=;
 b=QTQvEiwVL545yFcyilVDFLnbUXf5bCDpa/hqlLerA74UnFWprG28PejensMrqwSss92v+vxi2I2Krf4nvXDx1WcAl2H/abkDqZCT1uPQ4x7NBmnarAbgJgnkp8fAdo5CF4P7q9mtmpf9uohbg/5vhC/By3zt/zRvjyOKtmzOmP3fai11A8bD2/ZJcYnKegv8RpyRTbZkO8FvpT693yFP/GUOra0+iC+sPVPtksm/KolZ30BA580jKKM1pIfxS3XKVp8H2kK31++/dBIJiaLKGfL0517FY4NlB774ysLXEa4iZvzlFLJ7IcBB2/SDgdAU8l53EJ0eV0o1nOvNuwVmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4598.namprd15.prod.outlook.com (2603:10b6:a03:37b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Sat, 4 Jun
 2022 02:51:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5314.015; Sat, 4 Jun 2022
 02:51:39 +0000
Message-ID: <dfbe2c95-b6d7-1e26-4c3d-9ae7513235d0@fb.com>
Date:   Fri, 3 Jun 2022 19:51:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH bpf-next v4 16/18] selftests/bpf: Add a test for enum64
 value relocations
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220603015855.1187538-1-yhs@fb.com>
 <20220603020019.1193442-1-yhs@fb.com>
 <CAADnVQJgH6X66Rg0Z5v8pTsnfZBsHeaEko6rYv=ON6RQ+2FVPA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQJgH6X66Rg0Z5v8pTsnfZBsHeaEko6rYv=ON6RQ+2FVPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 962605dd-f137-4b42-9529-08da45d52633
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4598:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB459897B013382ED87880E680D3A09@SJ0PR15MB4598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmRL5yz51zfYM3NfK7hMYedRN8f2CqviOH0/fTdJT0I21gVmZsj6AiZhvhGv1P2BESNj0Wo1yRsJbHqNiewbrEF/5+GOrwz03G86gtrPPZ/7l43Kod5kfkQMpXxoucoU/9uY51KPzkYeHhucavfCRS8q9W7dEWsH5Pd9X0+5Qb0D4UWCLOvFqnkbrYl06kBZTC7luntDpcVE+B0Se1VeR9GBZK+VZzS+Qe/enl78lViufyOoUcgQ8zV1Ag3Dq7CHzzFzrB0L5wPI32ZJsQkDsQ1i/8pGsxj2n2BT5Mbu93CnFHe7YoIq7x06d2XJXDEq6+BQLbCJJGtYWT20du6VKVKYKDkFAMIqODOhjtv9cqt6doxn6D+10K7POBWtnfI8twEa9MmbNZAe65pUqPBWX4yJKi/b+pYPV/Vfw6qE/C8H695szF2iakuV9fsC1uonuz3V5H1I0Fu53VltxQ6jDCnI/l3xj+NsHz8MmsogxDV6VzYV+YwGqXwBA9PXoFppnyP7t1CLs79QLbZTAclJWiqmKMgVL8kovbxatDC1i2ClPD4kYmbD1YzSpzejkVKgVuke5O79PLReHdYmSfFIPoabXj3WfhAZ0e4AgLGDiLykTCdToOtSmRp+x15D48wLMb420v2J34OzaprnE3v0c6ajdyFTiS6mlXpS6ksSd2wpXqIZ7hAPf4TDNjyBdO2zWa+ry36mx3+sp2cdXv6fqL9+sGBiId4eNnyBTwxewBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(31696002)(4326008)(86362001)(66476007)(2906002)(66556008)(8676002)(66946007)(38100700002)(83380400001)(6512007)(53546011)(52116002)(508600001)(186003)(6666004)(31686004)(6916009)(36756003)(6506007)(6486002)(54906003)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFVUDVOQk9INng4YytJWEo2a1JlSURuUFNpeXd1MG9mNVV2Tk52azlvamJa?=
 =?utf-8?B?RjV6UkhDOU5ObnN6OGJyRzBENUVLcUdzUHg0VUFsQkxmVm4xdVBnWmZkS0hu?=
 =?utf-8?B?WFVGMGZ3NDluazQ1Z1AzU3gyWm5KTVNsUjBXcHZtWlY2cjJyU3RxaXlGSE9P?=
 =?utf-8?B?eEJnZEdiR0k1NzFwN05rdDNVZnNLK0poZ255V1d2WFJWeEdaQlpFZ1R2NXVM?=
 =?utf-8?B?T1pWclFGSXBPWERPV2dSVURnTkRlb3BuMWJCdEtKcENGOVg5L0d0VFdCUExM?=
 =?utf-8?B?WjhyTlVKMGZsME5JQ21MV0E0YzdBV3RJMHRwVWRqOGgxUU9ybGd6Tmt5NVQy?=
 =?utf-8?B?RjdDS1VXd2lVNy9McUQvd3NBOEVWTjhPbGZtZ2d1M2FubVY0RXpPcEJMZWlw?=
 =?utf-8?B?Yy9JallNVWtNU1dLem5ZVlZySVJMUFNla3ZQMmwrWTBrN1ZMUDY2VGtUako2?=
 =?utf-8?B?WXRCdUQxTW5GS2EreFB0QmpVTGlvWlgyOWR3QThwZURNV3NaV3gvVHhmRHlz?=
 =?utf-8?B?Wll3WGdGUjY5dm84SUxVZ2trSUdNN2owcGw2bUNzR29XQlRBZmRCWnhYYzBF?=
 =?utf-8?B?VUVHeWNRWEw2L3NQZ01DTzFBTm1BWm5yTXlpTjdtYURvdHhFV0c5SEt1VGxr?=
 =?utf-8?B?RkxCcUFSeDArTFZXOWZkL0RVbkp3K0phdWd4L1A0ZDlZSlpoVWhlYldMZWps?=
 =?utf-8?B?Z1BtOEdNaGtSWWo2azBkN1ZlSzFSejRMemovcWNuaUNqZWNaa0FDMDloelRp?=
 =?utf-8?B?K3M3ZjJBNmw1M0lrNWVzNHA1OVRqNzZXNHRUK0d2UnlhMzRjb2dDRFFCMDVl?=
 =?utf-8?B?NVFQdU1YclNlcFM2VWNIS0hORjBYcFVaa0V6ZTNGamU2akRGZU5YdUV6bnYw?=
 =?utf-8?B?dFA4aXBpNFJQTU00cWszbDJ0enFCNXNLczlrT292RjRnN09sMFI2OXpheHNx?=
 =?utf-8?B?Umlsb2h0Rm43TmU1OXpvNzM4eDgvN0JWN1VkWEs0R3JkZVBCRnJmZ204OW1k?=
 =?utf-8?B?M28weGp0L1UwQVVaTm5LdkxHQmhBaTloaGxRU3VxY2RXa0lnbDJOeU5QK1U5?=
 =?utf-8?B?NTY0SVJpUmJmSC9HVFB4MTViaHRmMzBiUGNNYUwwT21yMllabmtmUmc2RXpC?=
 =?utf-8?B?eDVmZ1pBY3dRZ01wTTRwWmd2eVM0dEpmK0JTcjVxaG9KS0NLZ1RleFBOSktZ?=
 =?utf-8?B?TnJHeGpuVXJQQmJFQ2FBN0N2K1VCNWZuVTdXcW14NU5XclZTY1Nxa2h4MnZ4?=
 =?utf-8?B?ZlJnQ0lsaUdSY2N0UlM0TDNFQkoxdjlmNmlwbGdONTNPTS82NDJ3L0hHaUhP?=
 =?utf-8?B?d0MzOTY1VGNrT0hSREE4eG82cEo4UFZxMnh4ZGI1Q1VGeVhsMUxZOEk0U2pu?=
 =?utf-8?B?M1V4MnMzTHA3b1pEU3REOEpVeGVhL2l0QjFzZHhBeUI2eW1EUVpibDBaY3Rk?=
 =?utf-8?B?ZnI3OUxRN2t0Z1ZCLzZBTmM3TWJXR0xqVHdWWU1DOFdzVEJwaEltNnVQZmp2?=
 =?utf-8?B?b09QalhtTlRra3hKMnB2L3hieWVYRGc0RlFaZEhvaGV4ZVFzWjFsWi9rMmxQ?=
 =?utf-8?B?Zk9waVRQZ24vekoxSnFUczNobzNKSkhrL0RkOUxXZ2I1dzhNUjlwRm1VMUs1?=
 =?utf-8?B?cWFMT1FlVmN1M0RnOHQ3Tnc4cDc5RU16UGJMYXBLS2piTWpWcE1wcEJDQVVJ?=
 =?utf-8?B?VVU2d2JOYzNteG85eG9MSUNMbHdDRHFmMW9oZjNnaitRNVJuOVJHOUh4cnVM?=
 =?utf-8?B?WWZhQzNoQlVodDFBNkZyZUVKTmxOZWx1RXBqSFAzaFViQWJpMzVhN0VoOGRG?=
 =?utf-8?B?aWxaWmZCWndCU0p3czcvTTFNd21KZ3ZrbU5GMEVOakQ5WG04bUtrdXFhU2pE?=
 =?utf-8?B?YVlOclo1azNQR2Uwb3A4M2psYnkvektqVUtDT2ZneHEwNU53QXI1YW4rRHAw?=
 =?utf-8?B?ZUFwUzN1NzlRSmxFTlowMmxYRVdZd1JMSEJYVHg2SUNSZmZ4ZGN4YXc3TzQw?=
 =?utf-8?B?RGxtUWhvZEYvRjltNjhhY0RoT0ZEUHhVeFlyQmNsZHp0alZ2aXRzclJQSGZ6?=
 =?utf-8?B?MFdzcTFsTFltVm1wWXdIb3RCbWFLV3BZWlZaNmxNSWJVMGNjcHE0ZkFtZHRJ?=
 =?utf-8?B?ZjRaYkYvdlJ5UGJhWDNZbTNKV05CeDUrYzRSVEZ4blFoL2VlQUVLRkNINCtW?=
 =?utf-8?B?bzVqZlByRERxZmNpcnovaTFNZ0Nzd3paekFUTVJvb04yUmNKRUNSMDJ6Ymk3?=
 =?utf-8?B?SS9Vc3JqeTQ3WUJuNGo2aStXcXAxYjRqQ2NlKzZXc1RGeC9rR1pFdE9EejBi?=
 =?utf-8?B?R2ZzV1BXOWRacHVROFo0VTJ1alZwWXVPUUgzcVB3bzVBaHF2Q1lCYnd0MXRr?=
 =?utf-8?Q?uLgLGJUTrJw9d5+o=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962605dd-f137-4b42-9529-08da45d52633
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 02:51:39.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21uhy1fMEivtHsdEcL0ZrFub4ARAgyqNTagwtzG6TwjBqLNy3XaFhLU/iNlwRgVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4598
X-Proofpoint-ORIG-GUID: NF1cJvaW4LJg7tGm6jEzCmUHrCrbG-KT
X-Proofpoint-GUID: NF1cJvaW4LJg7tGm6jEzCmUHrCrbG-KT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_08,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/3/22 8:14 AM, Alexei Starovoitov wrote:
> On Fri, Jun 3, 2022 at 4:00 AM Yonghong Song <yhs@fb.com> wrote:
>> +
>> +SEC("raw_tracepoint/sys_enter")
>> +int test_core_enum64val(void *ctx)
>> +{
>> +#if __has_builtin(__builtin_preserve_enum_value)
>> +       struct core_reloc_enum64val_output *out = (void *)&data.out;
>> +       enum named_unsigned_enum64 named_unsigned = 0;
>> +       enum named_signed_enum64 named_signed = 0;
> 
> libbpf: prog 'test_core_enum64val': relo #0: unexpected insn #0
> (LDIMM64) value: got 8589934591, exp 18446744073709551615 ->
> 18446744073709551615
> libbpf: prog 'test_core_enum64val': relo #0: failed to patch insn #0: -22
> libbpf: failed to perform CO-RE relocations: -22
> libbpf: failed to load object 'test_core_reloc_enum64val.o'
> 
> Is it failing in CI because clang is too old?

Yes, the failure is due to that the llvm patch to support enum64
is not merged. The llvm patch is not merged because otherwise
people using latest compiler (with llvm patch) may fail to
latest libbpf.

> CI will pick up newer clang sooner or later,
> but the users will be confused.
> The patch 17/18 that updates README certainly helps,
> but I was wondering whether we can do a similar trick
> to what Andrii did in libbpf and make the error more human readable?

I think the above information is what current libbpf did for
relocation errors.

Unless I missed something, Andrii's commit 9fdc4273b8da ("libbpf: Fix up 
verifier log for unguarded failed CO-RE relos") is to improve kernel 
verifier log w.r.t. relocation failures.
