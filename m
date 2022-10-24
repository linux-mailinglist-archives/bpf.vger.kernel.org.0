Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B460BB89
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJXVDE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiJXVCr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 17:02:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7806C2C4C83
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 12:08:07 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OIxGuj022719;
        Mon, 24 Oct 2022 12:05:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kkdSDR1UpC2OOZus4CrXToLt+Xl4biPLOE5Opq0r8u4=;
 b=ewn8yAmWh57UW0jHvEpN0Di54Mf/WblevmGyPDAA/SAeat6sJRo0bRXyJAlhlTTwC+Hw
 IxhZp0tfwOA7jyx2p7zngR+6G7dajl7vOa+BVCxlCQgWguGNL6ubtQyU68r1iHEBIgI5
 A1WFeVjQ+8NevUWRvwW2scKtgSy4/zm6XakcKJz6RtgwC32yh/8DhI5AKE2AEBnX3SW5
 BtKLDCZHeaFwRPwPorPL9m2mXGIPCpYli2s2MM0yJpcqo7th8doC/kOnPxQkkLWixY5T
 eTz0f7kGZaqVckTJQ9PwulRDf0civhF9N38xzMRUChCgtElGuxf7PIul8oa5Ba89nPnU 9A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kcfu5wdb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IROMEU0IlgUMde8y4II3oq8oqaKaeCkLMCCpKEYjG1vGYTPA+IrttK8v3MNqG53xjNZDRHUtN9L2iuMUyqH5Po8aq3b9oGIaTShG9cia/LG+O4IOH9ZGb8rdjQ4A8czcx8kC6U05s52Z9DKCmKXQp48a3KUX6bQmfx6ABXgwVyL5BmNkqnObopz6NCJIosnMnkJbiRwNhxJxOGpQH/uyveQMrD3H05NaemCudFbj+k/NtDuBI2NZujkwRmQ7cgGyTTbW2ZhOuSw31xonbNy63mDgldGkad2RSemivHtLVA97/qGaYfzVlJfXZ2Kf/CHlmojxv8SfCr9vgmHRkHbWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkdSDR1UpC2OOZus4CrXToLt+Xl4biPLOE5Opq0r8u4=;
 b=JXUIgKnM+mzBMrIIGPnkmpjHZu4ZrWw1xIAoRiVPDX1HLb9DvpcBq5RMrfOk2XYWW6vhgRPkMgu/ZJBI4ezRa6OzXRTgHF7lzQZGIRRXvCVdPe/qp6TD4UX2N5gIaDCeTszxL9F6tQ8odoUG00/kTV78BmVWmn6gzTGJvLBEQ1Bgcao6+bft+xYWUJCGb02ldiB46wojH4Y55NfctXgHjudIcSimckBCo/C3RUWQQ/XISvDi6irDghHwAYSLwKU3JGF/VykKvB6DdB/VD60zkUqQ0gGdbiaBolSAPwAv3ohoZXEu3OlhE9aLZMwU7SIoMaxllv2RBN85WIr9bUsdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2249.namprd15.prod.outlook.com (2603:10b6:5:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 24 Oct
 2022 19:05:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 19:05:14 +0000
Message-ID: <cb28416b-1609-f2db-2f9d-4524c5a4a786@meta.com>
Date:   Mon, 24 Oct 2022 12:05:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v4 7/7] docs/bpf: Add documentation for new
 cgroup local storage
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180552.2864330-1-yhs@fb.com>
 <Y1WjiCg9dZmPs+J2@maniforge.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1WjiCg9dZmPs+J2@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2249:EE_
X-MS-Office365-Filtering-Correlation-Id: f51f2e26-cbfa-45ca-f29a-08dab5f2ae74
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6mbrZUgfj0Q+UfOKtK3BkuLNtacUHsGdQtko4L39WQQlPEAxNzpAGbrc15D+Xk5YsHyYBI2nBK5xXUpwLfzvEPcioF1wqOzGj7u27FcWunVHyE9R2uaEprVmxg/ziCDY7KEKCnabqeWKxkqcytIzj8xAVGKEhdgpnuqj6UCh3Jbw38kLqAGxQtxh66BuBgMOlz+37aGIW1NGJA0ggXD/OiSWDpsanTPDXgHWXttz+qRVtBUpdnwgZJlF6pl+oHoTbFxesAX9U/80YmFZ4efb42l23JUKgycQCUnNbGewebQP2JIhGnE7r91njSrrCD83tQAxPlABmSaTiCEuLJphBtOJKtfhCEJ9CcX2vRTauo8z6YiyLEhSNXTC5CLR4KqOc8dn5cN4ImkKFJ4/ss6iKd6ZkWuV/yKB7Gky/bz2PXlYSxL4RLExWcntOJ0k4T1gjoRW/oH0DCl1CSJDolUpQiCWfJrmtSXs54V7dwUp/0NZPNNVMvVTT4VdNn3/qLx6o7ZWOf5L/aUTbSvIPtWb/H6L+pg6ixaPFJ59DzIwayBfAPJhkviq6Z+l2yKMR/UBF6mQBeiBRld0zMlpLR2I4+OiT1eUwBX9/HoTghLpYcAVdwVA6X2maAWO2ExmxWrQhLFr98hd+uRZ8ycm1zvOs8/jrZlHM48esiyzdJddaxQYqb65X7AlsrH8CCoMdknBQyx/ZLcB0dgeA2AUxyipNF4AdIfGqYiAj+QPpA77+YrBCpAV+islXpyN9pn1gWE97A3OeFpS5Lr5o2JQYDOSfor70219n1Fp9GI0e8rOZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(41300700001)(86362001)(31696002)(36756003)(6506007)(6512007)(4326008)(8676002)(53546011)(2616005)(66476007)(8936002)(6486002)(478600001)(5660300002)(6666004)(66946007)(316002)(110136005)(38100700002)(66556008)(54906003)(186003)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekQ1UXhnRzl2dWZWK3JIRTFQMC9aa09jcGNzZW96ejFqbzVSVENFNlZ6M05w?=
 =?utf-8?B?bkhDMldWN0FoMGZQSUJyRzViOWFFWGlIbkdpQUUvV1k5dlhqZzBPWGxHNGxH?=
 =?utf-8?B?czIyOW1xeklJOEQ4bzVuQkFFRlo0NFdCWXEyb2dFZ0ZySDJERTE0RVdFaW04?=
 =?utf-8?B?eC9jTms1TVpPQWRGRStqV2xHeGswNGE3M00zMmRvS2RuSFpRdTF0dGdBS1RH?=
 =?utf-8?B?Tk42dmFyRHBsZzIxNkpWNHFSb2FJeldXSlkyajNmVWZzaXBlalRSWXQxWnpr?=
 =?utf-8?B?VFViYklkU2NBRkJHTXp2OFdjQUdRRjNtZk9IRmxoL1F5TUJidFIyVHZOcWR3?=
 =?utf-8?B?UFFLaUczZFlTMitic2lPejEvQUxVeURrZjYvOGV5dmJkaWRIY1c1U0pLVlBL?=
 =?utf-8?B?aWVteTM3VzJBNkVZZFo2WkZsRk9mVW9DamFub2VnbGhGSmtPT0xCb0lVZ09m?=
 =?utf-8?B?ejBXdFIxLzlicDg1NGVXdGtpUmdFMHloNElvK0I2Q0N2MXRJK3BCQlg4WE8r?=
 =?utf-8?B?RkxrdUJzTS9lYVNldEpZajhZYW9BVFo1RktwcjlMNkgxektNK3pFM0Fzek9l?=
 =?utf-8?B?WE1Jcm00SHUxZmM5TVRsQVh5aytLNE1RaFZucTZTT3lCcmRiSmcyaEROM1g2?=
 =?utf-8?B?L3RCakZDWlgzOTlIZ1NOS21JTUhkeWNUN0pHSHZjZFBvY2VRemxHcUVyb3hD?=
 =?utf-8?B?VW5lTUM3Y09UYlI4TGFyZnF5blZvSnkxYkxEaUJFSlJBKzl2a3ZrZnNDRGhU?=
 =?utf-8?B?eFdtM25iYS9nVjZKeVBxeXQ3ak1aSDVFRVQxZmx2d2VlWmFZUmNLSHB0Nld3?=
 =?utf-8?B?d1grMGxmZHgwM2NQYnc0dTJ2VXNLaEtFK3BGakY1SHNkRDdHUTJTOXpLYVIw?=
 =?utf-8?B?Z3pXZWxyVXJJeThBQmh6NGxpcFRBSDVtME54bGpmNDFkbDRjbmFUN0MvaEZa?=
 =?utf-8?B?RXI2a2phVnJZTDBDcHYySDRpYWRYbWVNd0ZlOFIycDk1L0pQb2FxQTdKSUFo?=
 =?utf-8?B?V1RBb21JcXhJeGdRelBuUy9yR01LRkx5VDNMRXlMeXptK08vUHh2MUpKODRB?=
 =?utf-8?B?cDlwcWNuc1NIaHVwRmxRNXI1UkJIQ3RSRWhydVpDMkNQRGNCVVBCRW10RW5L?=
 =?utf-8?B?clhZd3dHVjZtZnNtTE1xcWFWbVoyL2xjMGEzWVJGOXJ3aXVFNmdud3orTEZZ?=
 =?utf-8?B?eEoxYTI2RGZnWW8zamx5a0I3cWIzUWllRjB3REw2RzYrMjlvWTM5MW5jK3h4?=
 =?utf-8?B?ZXptMXpoMWVjdmhvSCtQY0NZY2VGOGsxWHRpMGJrbFI5MS9kYkwxeENScVdV?=
 =?utf-8?B?Z0laWG5hck5abTFCRTlzVEJRdVNBZURUakwvMk9qMjlvdjFXSVdYVStrNHFT?=
 =?utf-8?B?SERWZjlUVWYzTGpuajVWdmpNUDJIZW5SMThVK1ZEMm9tRzFzSFhEbzJRaWxI?=
 =?utf-8?B?d28wcFRXSmFiNmtQTkkwTXVhRXhVLzhFSXV3LzJzQWlJcUhTYXJySGhEOVhV?=
 =?utf-8?B?aCsxTDl3eUZhV2tGNkVOc1V3bHNpZmU3aXZ1S0tQYnp4NFJaOXN6SkEwUU1o?=
 =?utf-8?B?QTFiV3loMUo3UXpnejBSc2taY25WaFpKbmdURDBqM095YUhpMkl1NTBIQktx?=
 =?utf-8?B?Q2lhVFdSMWJJUTkyNlhYV2dvTVNJUlVFS0h3am5tS2lxUHVBd2dGVmxXN01I?=
 =?utf-8?B?TWFSdGVFb3JJMUZiak94OUhhRVN6eHZuaGtXZDVNYzZWWTRJQXM4bE55Y2dO?=
 =?utf-8?B?RmRaZW1RYlB4WXRWK08xdmZaTUMvNHozZEtjYVFiMGhoMVNxU0RjMklweTZJ?=
 =?utf-8?B?RzdBMG1nNWM5NlJhenpPTWJ6dWo5blFtSzRJMjNpR0RJYVdXQzNwak5VaWV3?=
 =?utf-8?B?TWoxU0VqM05yQzFOTGhmR01iNHFiV21OUUZweU0weFpGWTBqZjZjaVFEc2cv?=
 =?utf-8?B?VWxUS1dzRzJiZEFmVnJ4TTgvSnp3cSt3VTBXdHh4UThwUXJxbDBvQVhHeGZZ?=
 =?utf-8?B?U3lJQnZXZDJjL2oxbWZkTElldEhUNTZDWENyejdCaE5tdnI2Uk5KYWlseU0v?=
 =?utf-8?B?UjFVQ2NQS1hQV25IZWhiSlNJZWdHZ1I1aS9GZGc2Uld3U0R0TFI1K1l1TXgy?=
 =?utf-8?B?dFdjcG92STFkbmlMZmloWFJ4dC83MkhjK2o1NUsyZXN6dCtKdS9ka1NpU2Mz?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51f2e26-cbfa-45ca-f29a-08dab5f2ae74
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:05:14.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuOcEZO+Pl1Pg3HdTAsXHE0RxtgSnHqUOzby14ktPJ41RJl2VOkom+PhGTSWZb+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2249
X-Proofpoint-GUID: eS3-qnIrJ6-BbwOSYbroPBYAaw4gGaCU
X-Proofpoint-ORIG-GUID: eS3-qnIrJ6-BbwOSYbroPBYAaw4gGaCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/23/22 1:26 PM, David Vernet wrote:
> On Sun, Oct 23, 2022 at 11:05:52AM -0700, Yonghong Song wrote:
>> Add some descriptions and examples for BPF_MAP_TYPE_CGRP_STROAGE.
> 
> s/STROAGE/STORAGE here and elsewhere

Thanks. Will make corresponding changes for this and other suggestions
below.

> 
>> Also illustate the major difference between BPF_MAP_TYPE_CGRP_STROAGE
>> and BPF_MAP_TYPE_CGROUP_STORAGE and recommend to use
>> BPF_MAP_TYPE_CGRP_STROAGE instead of BPF_MAP_TYPE_CGROUP_STORAGE
>> in the end.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   Documentation/bpf/map_cgrp_storage.rst | 109 +++++++++++++++++++++++++
>>   1 file changed, 109 insertions(+)
>>   create mode 100644 Documentation/bpf/map_cgrp_storage.rst
>>
>> diff --git a/Documentation/bpf/map_cgrp_storage.rst b/Documentation/bpf/map_cgrp_storage.rst
>> new file mode 100644
>> index 000000000000..4dfc7770da7e
>> --- /dev/null
>> +++ b/Documentation/bpf/map_cgrp_storage.rst
>> @@ -0,0 +1,109 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +.. Copyright (C) 2022 Meta Platforms, Inc. and affiliates.
>> +
>> +===========================
>> +BPF_MAP_TYPE_CGRP_STORAGE
>> +===========================
> 
> Small nit, can you trim the == border so it matches the width of
> BPF_MAP_TYPE_CGRP_STORAGE?
> 
>> +
>> +The ``BPF_MAP_TYPE_CGRP_STORAGE`` map type represents a local fix-sized
>> +storage for cgroups. It is only available with ``CONFIG_CGROUP_BPF``.
> 
> This is no longer accurate and should say, "It is only available with
> ``CONFIG_CGROUPS``."
> 
[...]
