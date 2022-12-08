Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B78647A0C
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 00:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLHXfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 18:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLHXft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 18:35:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD736ACF1
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 15:35:47 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8NXotd002234;
        Thu, 8 Dec 2022 15:35:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IGMZYXqztGGVwmNif6uNI+j+9WsuoFfTVoxvPMr1+J8=;
 b=UqlwUDOuADEy3Mtwk8OXuyPlukL9vyqnBDp5cv2GxIGULMUcgdvlD7f6oEYuW2EhP+0J
 V8dUdtP/cXjuNlXlOU+LIVYbHy0DKMTJQVyCowcIUH6hB20AqypgJLnpd2CYOnpSc9Ca
 ZT/KOaNn5korKkSNrEkx6qaZyIouchlsdW7BVRjUzel9lCK4PD35H9aPIgKMZBr2ySig
 fOJRgsy9FHYHi31Kz7NboKIDnBGSMew9aWgTMPWyogeEzFKIyPscesn8M0oM/pswhM5y
 k8mZAN4i3IN/t2Zvwqa/htSVdjK+/VlSr53JGUO/yH2Pip8rvE2sm0PfXAu8WtWOIKI5 vw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mbgeyc61p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 15:35:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFuslXBSTcLqiwccXruGxT2UJWiuTODAu2ERZWfhF0VzGKX1xINlLBmIXNFB11bjp2rkkDM2xT2/Vn5B2IZ1UkQVT58Q2ku6inRP1N/sA5olJa5Xw4gUWZiJTo6QpdxphFxUyzm4P4AM6CS3i+01nCtmhpY0wvrUyIJW7yi1dSGOAP7ujYco4xBxcCVFwngFyHuSCMQWsIWkDE4v2QVjPfkcpds4CD+46FA1ojM7nNZuj7NzFJhgb5mnHUknvAf3g0mC+pspBbJb5I9ZnoKqNYSkXfgdP+brepFK5hPEGl5l599wLgKsPg+ZO52z/kFcH6euA94JDGJPx6pLSRmj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGMZYXqztGGVwmNif6uNI+j+9WsuoFfTVoxvPMr1+J8=;
 b=bj0VPbKV+vVriYT3jjMQGEx8MPU1/3vbNH8yIE7f1F8OzcV4yW3B+YZAT+ZgGpN/m/jnDlnOq0/uom8mrua3MLetZVuW+AkVLmT5+M9QLOU6zRQLbqtpPul1qhTeGuUEev8ROJLXxg98oKqXcQDQJ378BH0V2liEEtdA2/2YdZPSNyjwY4e/vWzexNHQtnum61nGEtaPaYL4yBicuUGd1CqDGjZ3FErkZNh6LjO72wPqa1u5t8bfqf6uuuyp7royMhg7uz7mWI64xq8m27BxNusOGWucpnYSc2AzZlCS1hOvG8d62kvkURXDOehlZc9Pl2YRT7jc0XXqmnPyLUlytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 8 Dec
 2022 23:35:27 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 23:35:27 +0000
Message-ID: <3e6af95f-1d8b-aaf9-7e65-002b8fff19b6@meta.com>
Date:   Thu, 8 Dec 2022 18:35:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
 <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
 <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
 <20221208035140.skuadnybf5aqb4o5@macbook-pro-6.dhcp.thefacebook.com>
 <4dc1def4-74a1-d1a6-386a-32e84962a55a@meta.com>
 <20221208125729.73qr3glbyd7p6buq@apollo>
 <20221208203654.zwwqxzjhx563d3z3@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221208203654.zwwqxzjhx563d3z3@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:207:3c::16) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|BY5PR15MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4f414c-206f-4d12-b727-08dad974e2fa
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+xYOYXFhtb36gbb0RT7u27C+q5JulTd2O8ZEYWl4qRZRYeLjY+Z2zAYx6Clu6ft5e//4gXBxHHWTKwTVpvv8/IiniSrRm5pllh78vnJxd3qyxrhQ5J0GaKHEYK8+TaPsjcSCJS3mqoHlKPS1AGsf7jcG1b8UjvJcNVPqWNVBOiXglcj+TDp8/GTWjtLfQ2J4Souxdj57CINg0M1/Rf1f4pJhedNlPEgxEvV/xwql8MrHsfCp8+AqZL5bVuS8zdt9JNb7vN8npAOUaaTL1D0fQkkMQ8R1O0VngDeRx/JyEAhtQGpjrF9OU8U20KRHnmrelkuXYvT748NmKIyIzoEHPg6SECT7ooRl0R7+//nTbV7IuXM96mgfKxGsINrLx8ho5PwLYt3XPNHCR4ZRkPYLvZ/RDC4qD+m9TirEZuWNVuEyHdQEtcxvErDsFDGf1kpQUXpDhu5cKQvW9nyIWEyQXs1Qodt7UuWCXJZeLLXza/Sj5zO3rzV6lHGTMlkeKakvHHsHfk/X88pcDb9cMuTV7j9/eNYQcL9dXDEQdQlG4GK1DwwCD4xCqrxMCj8r2HCKVkryOrzpGnGyEk0Cb8kdCcgzdxoBf6U7bsog9A2RzK+ldV5t4d3CZ0EtuMWrV+QoS5JwWT0X5PZbozDXjGw1grwl/qJkFnjsgDy1sxM66M+gEfuvtlZMnW/YLaqqSSZGx2N85MfzwG/pVfLFRYzTGyS+bRCdE/qYi3sEokay2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(53546011)(38100700002)(2616005)(36756003)(186003)(478600001)(86362001)(83380400001)(6486002)(8936002)(316002)(41300700001)(8676002)(66946007)(66476007)(54906003)(110136005)(31696002)(4326008)(30864003)(66556008)(5660300002)(31686004)(2906002)(6666004)(66899015)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpTZ0I0R2VKQk9QRmV0UnZEVXpSMTdiNlRRYndjWk5pRm96d1QvOXYzaTdm?=
 =?utf-8?B?bXp5d2tQZTUyOVRjYmtxM0NHcFBva0RNOENmUCtYb1ZXd3FtZDF4R0xDSlNK?=
 =?utf-8?B?c2NVb1BHVDRaTk1kaHR1UXh1ZndScmh3blhITDhFT3NjSWt1NWxJKy9vQzkr?=
 =?utf-8?B?S09QTlIyVzEzMzBBQ0hpVHhXdFZHK01kSHd4emFPY281VnlaZmJWRlExVTQ5?=
 =?utf-8?B?MlRZMmYwYm5VMlhxT1B5ejZIRWw3OUZwdjFVdUh1b0lpeFdJVmdyUHkreDRm?=
 =?utf-8?B?cU1EbmJCUDJWdHVxWUsvTG9yUXZHeVRwUldpZ21ZbFJzTjg1ZEloSDQ3K2FS?=
 =?utf-8?B?TTZKeXRLbDNFTUdackVXR1NGOTQ1WllhOUJJNmpVNk5zRFVRQW5kRkY0dFlM?=
 =?utf-8?B?Vk1aeWlZb0U1ZlVUUE9FaE5VdjJ4REZLMEtiaHVDczRDNXRyZWQySHlYU1hh?=
 =?utf-8?B?WWVWTlJYcnd4RDhXeFNyeHVOaGFDMVNZTW50OWJNQkdVajVkUGpERTBLN05p?=
 =?utf-8?B?VVAvckJ3eVRMbDViMXNCMkhwcldNeWVuQjRoYkhnTmpucXpkZFhiV05mRTNG?=
 =?utf-8?B?L1FSbGR2RGVyOHg4ZG5pbGVVL2hwQTFLVHRIUXJOaGtPdERRcXQ0RTJJQnp0?=
 =?utf-8?B?emtTN2hQbFMxY2RNRDVaZU5hbS9XYTJHd1RLcXJFaXVyV3E2RXpQdGJMTjZt?=
 =?utf-8?B?ZCtxdnZzL3VFMlM1Qk1zSDBweWpwNUR3V2drd0s1NmpNcVVjeXFiRDV3Mk9y?=
 =?utf-8?B?LzVKQVM2K1dPRG9PQnpTV3huVTBRK1hBN1MxTWlGNzlwUUxERlVZTEtiQ09U?=
 =?utf-8?B?SEFoSmxEMjFick04TWt6aHFrRHZvVVlONE1UUVRUSkFoTkwrTjlza3RjTm02?=
 =?utf-8?B?c0JhNFZvaFB3V0tQQTB3WlgzdS9Ybm1aMWM5cVA4U013UGp3VklCc2FuVklD?=
 =?utf-8?B?VTBWSHl3OUF3ZEdRNWJDbXpKcVFscWhXUXIvUnVhdWhuYVNwYXU0U2xhcDY2?=
 =?utf-8?B?Rlh3RExwMnhXSkRjWm1IRzBzc2MvUFA2NHQrNTQxc2ZrbmVyU0RvWWE2bFR2?=
 =?utf-8?B?UklISFdQdHZQa3pnTEYxVXF6RkprSTZLNVhRTFFtaWduU1kzS0p0bWxBZk5N?=
 =?utf-8?B?d1J5c0ZhWnBHWWJ6eEpINFRJdlRSb1NQempOZEp3UzM0bWdxQlArTEMxenBP?=
 =?utf-8?B?cmo0QUxqaUNET2k5OHRRN0FGa2FUU2crVTJCUXpDVVl2MTFYdi9sM3BmQmtz?=
 =?utf-8?B?YlZQRC9YcUpDbzhZUmVkRWwwRGgrcmNRUWZjY1JZMXV0UWlUOStOMlpFMmdM?=
 =?utf-8?B?b2tOelhqaEhqd2JibTlXOE8xYUFydUxtdzI5dlpvVVJ4UVlrWHN1Qm8zMi92?=
 =?utf-8?B?L3Q0M2NIejlnZ2ZUVk1yVjZ4ek5WaWpDOVdYYUw3NGdrNlZjWTh0QURnN1JY?=
 =?utf-8?B?anBiM1lBMVhwYU5RTkcrdEN6a01Vd3N5a3c3TEU1bGl3OXM0MDVkbnpsbHdq?=
 =?utf-8?B?ZUE5eEU4QWhZZm9YN0owK3NKbHpvSmszaWV2QVhVbVQ0L3U1N2pvamZ2TENL?=
 =?utf-8?B?TmhsUHdiTlFXYjlLcWlsK29FM3F2Z3E5ZWxadnZaRktJbGRsZVlZbVRmVkFM?=
 =?utf-8?B?ZGJ1Si9pUSt3V1Y5eW5mdyt2SHVKaDU3cUo3c1hTenVhYzl0K2NleDNWckpj?=
 =?utf-8?B?QTNFSVZhTlh0Q1pPYmtrUTBmaHJhTEY3VmdkZWRaMms5R0RWMDRSUTdJcWlN?=
 =?utf-8?B?NWdNT3RBeEVWZkJvT2lUYVQxeTdQQWFEeWw3cWVJdVl1MFRJZk9SRVRpZ1la?=
 =?utf-8?B?Y0pub2E3UVlGeC9HNnJHMEhicEljdG5VbjBTRFduZ2FrR0xoVUI3TVJ2TjBO?=
 =?utf-8?B?WTNXM1NkaVd6L2hhZGVzOHBXekI2U3dyRkcwZlNrMCtGR3dPcHhhZEV6cWxS?=
 =?utf-8?B?YlJrWEtDUjNFK2NtQktMNmkxMTF5enAzYXkyMUxwMWJYMU4xTDN3eWwyeFlF?=
 =?utf-8?B?aDA5UkRjSE1JRWtTcGRRY1d1U2FidHVjZjlVVXN0S3EySFV2c3YwdXdIZnVs?=
 =?utf-8?B?Rmk5SzVORW1JY0IzSnNSa0o2ZnNmNVlVNnRyZ2xLZ0R0QTUyZVFIL1lncnlD?=
 =?utf-8?B?Y21JWGlFVkFucUJMZnptajZ3QzM3dmhpbVpjZjNmQ0pHNlRjbElzdkNxVmJw?=
 =?utf-8?Q?sARMofBxAGvPxKMqdeTcXyk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4f414c-206f-4d12-b727-08dad974e2fa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 23:35:27.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHusbxv0dR3ZgMznOm5Q5TS04YIgGT1sQS++3jK4ki4mtsLc/l89cdgxX1UATz+IgevZonuED3n32Ivzoo7J7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-Proofpoint-ORIG-GUID: M4Oy_2I-PWc7WZgBPLQQ3kxC8YW8o3kX
X-Proofpoint-GUID: M4Oy_2I-PWc7WZgBPLQQ3kxC8YW8o3kX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/8/22 3:36 PM, Alexei Starovoitov wrote:
> On Thu, Dec 08, 2022 at 06:27:29PM +0530, Kumar Kartikeya Dwivedi wrote:
>>
>> I don't mind using active_lock.id for invalidation, but using reg->id to
>> associate it with reg is a bad idea IMO, it's already preserved and set when the
>> object has bpf_spin_lock in it, and it's going to allow doing bpf_spin_unlock
>> with that non-owing ref if it has a spin lock, essentially unlocking different
>> spin lock if the reg->btf of already locked spin lock reg is same due to same
>> active_lock.id.
> 
> Right. Overwriting reg->id was a bad idea.
> 
>> Even if you prevent it somehow it's more confusing to overload reg->id again for
>> this purpose.
>>
>> It makes more sense to introduce a new nonref_obj_id instead dedicated for this
>> purpose, to associate it back to the reg->id of the collection it is coming from.
> 
> nonref_obj_id name sounds too generic and I'm not sure that it shouldn't be
> connected to reg->id the way we do it for ref_obj_id.
> 
>> Also, there are two cases of invalidation, one is on remove from rbtree, which
>> should only invalidate non-owning references into the rbtree, and one is on
>> unlock, which should invalidate all non-owning references.
> 
> Two cases only if we're going to do invalidation on rbtree_remove.
> 
>> bpf_rbtree_remove shouldn't invalidate non-owning into list protected by same
>> lock, but unlocking should do it for both rbtree and list non-owning refs it is
>> protecting.
>>
>> So it seems you will have to maintain two IDs for non-owning referneces, one for
>> the collection it comes from, and one for the lock region it is obtained in.
> 
> Right. Like this ?
> collection_id = rbroot->reg->id; // to track the collection it came from
> active_lock_id = cur_state->active_lock.id // to track the lock region
> 
> but before we proceed let me demonstrate an example where
> cleanup on rbtree_remove is not user friendly:
> 
> bpf_spin_lock
> x = bpf_list_first(); if (!x) ..
> y = bpf_list_last(); if (!y) ..
> 
> n = bpf_list_remove(x); if (!n) ..
> 
> bpf_list_add_after(n, y); // we should allow this
> bpf_spin_unlock
> 
> We don't have such apis right now.
> The point here that cleanup after bpf_list_remove/bpf_rbtree_remove will destroy
> all regs that point somewhere in the collection.
> This way we save run-time check in bpf_rbtree_remove, but sacrificing usability.
> 
> x and y could be pointing to the same thing.
> In such case bpf_list_add_after() should fail in runtime after discovering
> that 'y' is unlinked.
> 
> Similarly with bpf_rbtree_add().
> Currently it cannot fail. It takes owning ref and will release it.
> We can mark it as KF_RELEASE and no extra verifier changes necessary.
> 
> But in the future we might have failing add/insert operations on lists and rbtree.
> If they're failing we'd need to struggle with 'conditional release' verifier additions,
> the bpf prog would need to check return value, etc.
> 
> I think we better deal with it in run-time.
> The verifier could supply bpf_list_add_after() with two hidden args:
> - container_of offset (delta between rb_node and begining of prog's struct)
> - struct btf_struct_meta *meta
> Then inside bpf_list_add_after or any failing KF_RELEASE kfunc
> it can call bpf_obj_drop_impl() that element.
> Then from the verifier pov the KF_RELEASE function did the release
> and 'owning ref' became 'non-owning ref'.
> 
>>>>> And you're also adding 'untrusted' here, mainly as a result of
>>>>> bpf_rbtree_add(tree, node) - 'node' becoming untrusted after it's added,
>>>>> instead of becoming a non-owning ref. 'untrusted' would have state like:
>>>>>
>>>>> PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
>>>>> PTR_UNTRUSTED
>>>>> ref_obj_id == 0?
>>>>
>>>> I'm not sure whether we really need full untrusted after going through bpf_rbtree_add()
>>>> or doing 'non-owning' is enough.
>>>> If it's full untrusted it will be:
>>>> PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0
>>>>
>>>
>>> Yeah, I don't see what this "full untrusted" is giving us either. Let's have
>>> "cleanup non-owning refs on spin_unlock" just invalidate the regs for now,
>>> instead of converting to "full untrusted"?
>>>
>>
>> +1, I prefer invalidating completely on unlock.
> 
> fine by me.
> 
>>
>> I think it's better to clean by invalidating. We have better tools to form
>> untrusted pointers (like bpf_rdonly_cast) now if the BPF program writer needs
>> such an escape hatch for some reason. It's also easier to review where an
>> untrusted pointer is being used in a program, and has zero cost at runtime.
> 
> ok. Since it's more strict we can relax to untrusted later if necessary.
> 
>> So far I'm leaning towards:
>>
>> bpf_rbtree_add(node) : node becomes non-owned ref
>> bpf_spin_unlock(lock) : node is invalidated
> 
> ok
> 
>>>> Currently I'm leaning towards PTR_UNTRUSTED for cleanup after bpf_spin_unlock
>>>> and non-owning after bpf_rbtree_add.
>>>>
>>>> Walking the example from previous email:
>>>>
>>>> struct bpf_rbtree_iter it;
>>>> struct bpf_rb_node * node;
>>>> struct bpf_rb_node *n, *m;
>>>>
>>>> bpf_rbtree_iter_init(&it, rb_root); // locks the rbtree works as bpf_spin_lock
>>>> while ((node = bpf_rbtree_iter_next(&it)) {
>>>>   // node -> PTR_TO_BTF_ID | MEM_ALLOC | MAYBE_NULL && ref_obj_id == 0
>>>>   if (node && node->field == condition) {
>>>>
>>>>     n = bpf_rbtree_remove(rb_root, node);
>>>>     if (!n) ...;
>>>>     // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == X
>>>>     m = bpf_rbtree_remove(rb_root, node); // ok, but fails in run-time
>>>>     if (!m) ...;
>>>>     // m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y
>>>>
>>
>> This second remove I would simply disallow as Dave is suggesting during
>> verification, by invalidating non-owning refs for rb_root.
> 
> Looks like cleanup from non-owning to untrusted|unknown on bpf_rbtree_remove is our
> only remaining disagreement.
> I feel run-time checks will be fast enough and will improve usabililty.
> 
> Also it feels that not doing cleanup on rbtree_remove is simpler to
> implement and reason about.
> 
> Here is the proposal with one new field 'active_lock_id':
> 
> first = bpf_rbtree_first(root) KF_RET_NULL
>   check_reg_allocation_locked() checks that root->reg->id == cur->active_lock.id
>   R0 = PTR_TO_BTF_ID|MEM_ALLOC|PTR_MAYBE_NULL ref_obj_id = 0;
>   R0->active_lock_id = root->reg->id
>   R0->id = ++env->id_gen; which will be cleared after !NULL check inside prog.
> 
> same way we can add rb_find, rb_find_first,
> but not rb_next, rb_prev, since they don't have 'root' argument.
> 
> bpf_rbtree_add(root, node, cb); KF_RELEASE.
>   needs to see PTR_TO_BTF_ID|MEM_ALLOC node->ref_obj_id > 0
>   check_reg_allocation_locked() checks that root->reg->id == cur->active_lock.id
>   calls release_reference(node->ref_obj_id)
>   converts 'node' to PTR_TO_BTF_ID|MEM_ALLOC ref_obj_id = 0;
>   node->active_lock_id = root->reg->id
> 
> 'node' is equivalent to 'first'. They both point to some element
> inside rbtree and valid inside spin_locked region.
> It's ok to read|write to both under lock.
> 
> removed_node = bpf_rbtree_remove(root, node); KF_ACQUIRE|KF_RET_NULL
>   need to see PTR_TO_BTF_ID|MEM_ALLOC node->ref_obj_id = 0; and 
>   usual check_reg_allocation_locked(root)
>   R0 = PTR_TO_BTF_ID|MEM_ALLOC|MAYBE_NULL
>   R0->ref_obj_id = R0->id = acquire_reference_state();
>   R0->active_lock_id should stay 0
>   mark_reg_unknown(node)
> 
> bpf_spin_unlock(lock);
>   checks lock->id == cur->active_lock.id
>   for all regs in state 
>     if (reg->active_lock_id == lock->id)
>        mark_reg_unknown(reg)

OK, so sounds like a few more points of agreement, regardless of whether
we go the runtime checking route or the other one:

  * We're tossing 'full untrusted' for now. non-owning references will not be
    allowed to escape critical section. They'll be clobbered w/
    mark_reg_unknown.
    * No pressing need to make bpf_obj_drop callable from critical section.
      As a result no owning or non-owning ref access can page fault.

  * When spin_lock is unlocked, verifier needs to know about all non-owning
    references so that it can clobber them. Current implementation -
    ref_obj_id + release_on_unlock - is bad for a number of reasons, should
    be replaced with something that doesn't use ref_obj_id or reg->id.
    * Specific better approach was proposed above: new field + keep track
      of lock and datastructure identity.


Differences in proposed approaches:

"Type System checks + invalidation on 'destructive' rbtree ops"

  * This approach tries to prevent aliasing problems by invalidating
    non-owning refs after 'destructive' rbtree ops - like rbtree_remove -
    in addition to invalidation on spin_unlock

  * Type system guarantees invariants:
    * "if it's an owning ref, the node is guaranteed to not be in an rbtree"
    * "if it's a non-owning ref, the node is guaranteed to be in an rbtree"

  * Downside: mass non-owning ref invalidation on rbtree_remove will make some
    programs that logically don't have aliasing problem will be rejected by
    verifier. Will affect usability depending on how bad this is.


"Runtime checks + spin_unlock invalidation only"

  * This approach allows for the possibility of aliasing problem. As a result
    the invariants guaranteed in point 2 above don't necessarily hold.
    * Helpers that add or remove need to account for possibility that the node
      they're operating on has already been added / removed. Need to check this
      at runtime and nop if so.

  * non-owning refs are only invalidated on spin_unlock.
    * As a result, usability issues of previous approach don't happen here.

  * Downside: Need to do runtime checks, some additional verifier complexity
    to deal with "runtime check failed" case due to prev approach's invariant
    not holding

Conversion of non-owning refs to 'untrusted' at a invalidation point (unlock
or remove) can be added to either approach (maybe - at least it was specifically
discussed for "runtime checks"). Such untrusted refs, by virtue of being
PTR_UNTRUSTED, can fault, and aren't accepted by rbtree_{add, remove} as input.
For the "type system" approach this might ameliorate some of the usability
issues. For the "runtime checks" approach it would only be useful to let
such refs escape spin_unlock.

But we're not going to do non-owning -> 'untrusted' for now, just listing for
completeness.


The distance between what I have now and "type system" approach is smaller
than "runtime checks" approach. And to get from "type system" to "runtime
checks" I'd need to:

  * Remove 'destructive op' invalidation points
  * Add runtime checks to rbtree_{add,remove}
  * Add verifier handling of runtime check failure possibility

Of which only the first point is getting rid of something added for the
"type system" approach, and won't be much work relative to all the refactoring
and other improvements that are common between the two approaches.

So for V2 I will do the "type system + invalidation on 'destructive' ops"
approach as it'll take less time. This'll get eyes on common improvements
faster. Then can do a "runtime checks" v3 and we can compare usability of both
on same base.
