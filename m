Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041D522712
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiEJWpj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbiEJWpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:45:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7175D20D27B
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:45:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AMF3eE021758;
        Tue, 10 May 2022 15:45:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HQwVQdaOKg+R3VB3KepbiSR2qO92rAUI5kvLjYQc/uc=;
 b=NHRFeUTqMpUS+aklxr0gTq6VCUtHGyH2SSP8iLn0WVmr/AKQU9z8o6jto15ZDY2ynqNv
 fb8gnE0hiWJ7OEpaSZcDqCL9+TqpUi2Els91I4x+7VgI1vDDEKRJH4eLZBS3v8g/UvAZ
 UqqxHF95N9e+UkKCNvAbNqnI1baJBtgg83o= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fykexp6u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEGDUCxmV7XgLFZyshShRlDBS8sI4h4k/1N1yp3MSi7Mh19mn3831rGsrHwiRvJxERTv5+aWRFrh8XKvb+eoZbHmyZIDTMTG8AQytwM+6PXCs/c2cjDo8PWjJmD66gLGvW9jRHZrWNg+cKI3F4syEfKbwyciErdrYqj2LT5lEgq+6wIyOpznTrf5z+SJqUCE6UTRRqItlNc0tgAxBgV+nomTOAFCvCLk5GC6IcbUS/B2KkQjZsobZ15rgN+skbA8JkYhTf/bXsi22xhihKJu+4/yR9rgZ82AvTEQRCpTVmVzvLU6jJY+GadWPuQ7YD/ooPZEdOmFclBLHB+2QORRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQwVQdaOKg+R3VB3KepbiSR2qO92rAUI5kvLjYQc/uc=;
 b=NiAvcw5HJfW4T4yI30tWn9gUDZN+LtSnyHBydmQ8J2shFm0+8FLCo0lzXd976TcZV/1fwg91OOMmCqGYFalkINtUsO16nQ2xVUWq0E+9oki6rMqo7duVt25hoNAqVr3U7xQP9lp3PMPoRUuZ9kTEZqFyiMlUhCPY/WDpb64WRQsiUZTcPeDMVi1FP6CL6trCxe2koE9rTwDxWqzNmhOpGsFMjLDae6N6srCf5GH1vEuAJ4CZn3w45oPMIfGQqLzr0Ru2JYO8gwTHYDwqfFhDWHKE6eWO9CA3SupYQPK0F4pjANTtK0HwuZdhNAejNFWsCJf/LNqi+2rwOX2FH6FN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2336.namprd15.prod.outlook.com (2603:10b6:805:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:45:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:45:12 +0000
Message-ID: <89911c0b-d562-725a-f7f7-e1def1539b22@fb.com>
Date:   Tue, 10 May 2022 15:45:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: add a test for enum64 value
 relocation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190054.2580458-1-yhs@fb.com>
 <CAEf4BzbiuoCOh0MFvh5CSPV1W+tVM6u0og6twNZ4wqpvSdWL7Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzbiuoCOh0MFvh5CSPV1W+tVM6u0og6twNZ4wqpvSdWL7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b2acc84-231d-403c-9efa-08da32d6be63
X-MS-TrafficTypeDiagnostic: SN6PR15MB2336:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB233664017AB7133A68C80A47D3C99@SN6PR15MB2336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IR7sKpfbA/m1QUH2mBlkkEngxdXUG2Ha4e1bAylnh7yyHhdbn6iPJ+pC6S+QbLzNm+YabzruK/HSVB8jICNSbNxhEfH6xxyb3GVBtOOhJ8w84K7e+lGZVfvWApb5krHPs38n9KyMNe99ekUp0uB4aUV4VDH8OvMTeXx/agRBXGhiNwvdvDfvrYHcdtNqCxWbV5HnsG4fkYjXxM5xHqsYRILjlCJrNRLTntUeu+PTQNimDRylhBFnFW/fixDu1N5TElHdvTlGFa3AWG2zCEHqVO40vrtM9Wbz7EpqjRnpxu6sBC9ncRTjnWuPYyvHSAkwfbuVHzhUenUJsI3JleoEH3Id9/OqO1L+k1GeV+A5n0RRjJfeWIeWm6UB/oMXNhPfJrfvBTNkqfQkrg4X6p2z8HeK1qhCMBKNDloe9idTtd6d+AJydBvDpq4CNQn4Is29y8QFIdESQrug01IV708mB4TDYVUf3KBaeCKrP8SQhHSHpa228dW/1eHEO7Jbuc6Qr9qWZapNTP4kGXdT62DSX+IyeRHcU45yHb+vI94z3i7cpL/6LBJ5nIc6l0q1fP8fKAR+SgalZF8bsdw4kyAfUvD195eIbzvteMS6RBvTAKpAOfkzb70ckjrd6tgJCMp2fRZQQLc0/JvW9HoX+uYS47DWBA7/Y1mcz5lSDDSaGZPdKyOxJ7KuZMOCHUWVVtA2hsLkcsKaQl+VCT4g72QNbVOO9Y5rnWa/gHSIPl6NXpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(66946007)(66556008)(31696002)(8936002)(66476007)(6916009)(54906003)(2616005)(38100700002)(8676002)(4326008)(6486002)(53546011)(6512007)(6506007)(52116002)(508600001)(2906002)(36756003)(31686004)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWFHbUNIRHdqVGlQZVkyTm5FOXpPSEEzZkt5Y0xJQUh4c09jREpmMFg5cDlV?=
 =?utf-8?B?QTlMSFdHSVRCeHhSYk0yUk13cXRUWXZQdGNhK3lwSWNJT0NzL2o2NlpxKzRC?=
 =?utf-8?B?djcxaGtYL0FqOU5GeWVPTVhQb2N6d0VxZk1kNEh3QnVUekcyUjNIR05nemFn?=
 =?utf-8?B?UHhhMnAwLzBZdnRnMTgxT2tjQVFMb3lFcUxQRHNhclNqOHVlRHdjamNKYU53?=
 =?utf-8?B?NlFLMXF2dkpEZVU5aHova2ZhdWtmNzlWaGFqV0czWTFxYjYxTjBtTXpuYTYv?=
 =?utf-8?B?dzlIM1JiOFo5WDhLSWowSWh1ZFNEQWhYQUF3ZThkMWdWajdsdk5RTkZNYmh3?=
 =?utf-8?B?c3ViMkFJMmZmZEcyM1VRS0xvdEJsVmlxUGlOa2luSGdaK2NpdHdidCtoUEgw?=
 =?utf-8?B?dS9hczFtZWhqelByWXc3OXRKZ3FIMGg4cEVFdXNyT1VjT3dtY1JoVCtlNnlP?=
 =?utf-8?B?ZGtkVVltYXdyNmVEeUtZRklWSE91V0pCR2hzd3NPdmhyRklVMGsvZHVicjU3?=
 =?utf-8?B?cmFBWHBxaW4xbUtuWXdEV1pwcXRZSlpUQWROSnJLa21DN1VCZFNOMzZZNkdI?=
 =?utf-8?B?eU5ubEZsQXp2NkdHdStPZHU4eEtJeGMwc0RJdWJSN1hkZm0zYkRlNUJHWFM4?=
 =?utf-8?B?azhwMHRqc0o2enprU25JekZYQy9jK3lWWmhKa1RYdGVKc0J5akowREFyRnlM?=
 =?utf-8?B?NGlqT1M2NUNTMlRmN2NPSVJYME8yS3dPeVorZGR6VFF2bXZuejIxYVhEczN6?=
 =?utf-8?B?NzNrNGtqMDJVZEtzY0FSSVlGOFZrWHhjSkI2K3lSYkdWa016K1Q0ZzhjaDBw?=
 =?utf-8?B?ZlBkdUhIcjlMbm1EVjFGQzVoVmVPVUxiNkR2dVFoWjBMMWRJYnFqS3k5MTJr?=
 =?utf-8?B?cFU5VHdXMk9kLzIyOVBXMHdzejJtTUNhNHRibmJyRlVzakxyMHp6NmdLdjll?=
 =?utf-8?B?TjRzM0FBOFZDYUlNZmcydGJkZ2doR0RrbStJWkJmNWt5SjdaQ29DalAwb1dJ?=
 =?utf-8?B?N25ITTlmRGovOGV0aURBUUpYcjg1cEw4TWdaSFBTT3R1d0V0cHlPdGUzVFdW?=
 =?utf-8?B?V3BtUksvTUNpcU5nRlloSE5IWGp2elNrc1dDOVhGcjNWTzEyaERGMmdaQ2Jp?=
 =?utf-8?B?a2FReCtZNVc0NlM4MXlhUjJ2dHByOTYrbUloODFKVXN6VS9JdUpmZjZKcWRK?=
 =?utf-8?B?bzBIeDRQT3pqOVByMGlobUkrUkpiazFvUnUzMkcyVDBCY2hpc3BxcjZQeUFr?=
 =?utf-8?B?NXkrUThaZXhONmsvMVpWNXl5NXNFRTNvSmEwLzZJcEFCRmREZSt0Nlh6VEp0?=
 =?utf-8?B?YzhxWFRDZUVOTUhNTWNpeHpIWTlDaFE2OE5EMit2NnZ4aEF6NVN6RkEzS1B0?=
 =?utf-8?B?VE1ZUGZyeGJjN1k2cFlGSHV0Z1Jjc28zT1lOR25QRDY1WTRJdTYyOWpzU3F6?=
 =?utf-8?B?djN4QjhkTjBYSVFTZHNVVHJ0bzNNc0RqbmxRWXVBUzY5RnFtZHBkMGcxYVlp?=
 =?utf-8?B?YjdpV1lvVitVWEN3Ym5rVGg2RlNEOFlTaDBCcldyc2tmNFdLTnVsdXJzZGhK?=
 =?utf-8?B?OHVYU2U5TGF4NTRRY0wwUzZHMnQzTEN0Q3hROFo4eEt2dHZScEVOVk5scFZT?=
 =?utf-8?B?ckhjc1J1ME91aXo2WG5OdzR4RkNQZnlYK0VONVcva0NBeVBFV1ptOFBIQ2gx?=
 =?utf-8?B?dnVkR013bHExSnBEc3JEK1UzTmREdXpFU0pyY291dXpSY05RYXBNWTM0VDhi?=
 =?utf-8?B?SGpLWDBzeVNwd2pjMlVPdU83a242OVlCUENSTzJPbzNDa1ZWekp6eDJOanZz?=
 =?utf-8?B?NjZKRjNyRnNLd3RlZHI0TDFqKzBRNU9CNlZiM0FQRTFMN0xRMmsxRkYvV1Az?=
 =?utf-8?B?aXRRRXVUUFZpOFJObmIyNlV0NjI4MVRERWtkT3JMYVpHNkpGZ1gvV0QvSVF6?=
 =?utf-8?B?ZHR5NEFmSnRQcVphUDVYRnlFMFNIdDVkaElLNWUvOWNVTWJZSERnT0tnOHJp?=
 =?utf-8?B?Q1ExSnlnaWQ3RXAySzVxTy9VdnE0Z1U0ZUdMN1FmRDRnSU13L05KUldtUmox?=
 =?utf-8?B?WHl5SUMwa0xVSFlJSWF1UWVJcFpsbFU5UUtKSzhzNVIrY0c4YVpLYmhaSHhs?=
 =?utf-8?B?UmRwbEhLRXBmTEFudGdVZFVoblcxT0kzZzhSRVUxamNGZzJGdVBmQ3JRT2N5?=
 =?utf-8?B?QTIxckNvNWJOWkNXVlhCTVU3VVdRNHNaY0VBUXI4RTJZa2tTd3REejdEVHJt?=
 =?utf-8?B?VXVoNVlGZzZsZ0I4WS9EeVRzUUphTTQzUWUxSTJDeHBtcUhkSUNzMmEvSzJj?=
 =?utf-8?B?OEhLYktvTDAvWHhNNEZ6TGErZDh0RkRzbGFHREh1dzhoVTNrVmwvMjU2bkhW?=
 =?utf-8?Q?624slpdotWCPMzOo=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2acc84-231d-403c-9efa-08da32d6be63
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:45:12.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMQPOti7CsoMx5m58l+hx84sTI9u71cb2HmdNFJtCzBzlbrDbTxiYYVMRGpspnD4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2336
X-Proofpoint-GUID: RKyKZlPgj3EFuHGfxegrVXi-e7_tymxU
X-Proofpoint-ORIG-GUID: RKyKZlPgj3EFuHGfxegrVXi-e7_tymxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/9/22 4:38 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:01 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add a test for enum64 value relocations.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> Looks good, but can you also add some signed enums for testing?

okay.

> 
>>   .../selftests/bpf/prog_tests/core_reloc.c     | 43 +++++++++++++++
>>   .../bpf/progs/btf__core_reloc_enum64val.c     |  3 ++
>>   .../progs/btf__core_reloc_enum64val___diff.c  |  3 ++
>>   .../btf__core_reloc_enum64val___err_missing.c |  3 ++
>>   ...btf__core_reloc_enum64val___val3_missing.c |  3 ++
>>   .../selftests/bpf/progs/core_reloc_types.h    | 47 ++++++++++++++++
>>   .../bpf/progs/test_core_reloc_enum64val.c     | 53 +++++++++++++++++++
>>   7 files changed, 155 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___diff.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___err_missing.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___val3_missing.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.c
>>
> 
> [...]
