Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA163621CB4
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiKHTJI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 14:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKHTJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 14:09:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050C68C7F
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 11:08:49 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8IDEvW014431;
        Tue, 8 Nov 2022 11:08:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6VXLPNPuPwseEUQF+bnlg+oXEWszVqFg2zPe25G6iLA=;
 b=QWzl4xUHZt5EAva8wPACOViy5xIBlTEmKbPX96hci0VyyRLAGcUS0LQ9JI7lBsvATEI7
 Tz7e8tz/+sepVyCH0kTHEwqPBkNG+tNjR1S9rn7B/lJITzu7ZSXH8WBPAok8NZTnVx97
 e0hLf1uTZ0HF5j9aWIPyd+RUI/whbpGOqfgFW+q8QdtsREV8wr0oYl/VPORZjPC2USiX
 I5RLyPn/CSE0bUD9kWLe0u9bBLTZrp2o00LwNoKHwAAi/7ds76dzCWaQfWrz+uWmj6TX
 wIZ+XrjWGrE1i7f0HNTjFiGsek+dsN8Jgn+vVqnTYc/32LMlBR+j3LQD9LqWm+C54k2t Dw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqh9wdrhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 11:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+dvc24JbXCnLaAKavUYNlj+TNqAgDyZ4XmGX+IwLuKUrUe99JkJBbyzKQpeU9eY99ZeyKds3+qoqjRBd76Qm4WqB6vs9HVE/othwQWCWFDzm6IGgmCOL++2Tj0VSE0VIUT7c6qMxQjn/tV0poDG94hZcmRVGVmMZIMyiZwpTpso8dDS174pMB2D4AyKIc7qnrqSyYOSmhkGJv+GfwgaulHCZBSpjPNPnSlYyJYOlXJ4J5boLs31nkNYbaR5fOTtCuFgPcC88fGApX1zzxqpYLZieu/FwNY86JmdropqM+bVYYiYp8LBX2hs4W+bDDoZyEsh5fqO66qr0n9XsTr4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VXLPNPuPwseEUQF+bnlg+oXEWszVqFg2zPe25G6iLA=;
 b=a7CWpgWksrBMG0qSJeQq5XyBspZd8Q9ZsDuTFbwjOtAKvTibclC5SdDNIZvCm5MNKkWNVvHoKYL/xuwTZBzpM2bm6kNAhwS8GHsmJUGmnIdqva951+R/xjr5QMHJ0BdoLfbMlT4q3TC8rtShzsfMohERJaCnBvhPaR6sV2+9W1m5rlxNg37UTtlDcV4opObcldSkBqTpSVvT/RXat9HhzWI0v9xXG3AZMqk/BO1aBO7rm7884LHGO4NshpxqdsMys4oK55mFF3ndYjRCVvqhbNjLN07pKMAJuByV5xoDufXQPeLSXsY+09D1wJ5uNKVz0stCnPG0yq7HpG2VTLmcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2159.namprd15.prod.outlook.com (2603:10b6:805:d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 19:08:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 19:08:09 +0000
Message-ID: <57ca8fbe-974a-8a8a-4ca2-c745849fe623@meta.com>
Date:   Tue, 8 Nov 2022 11:08:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2 4/8] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074109.263773-1-yhs@fb.com> <20221108170931.b75qdoy2ysjp4xwo@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108170931.b75qdoy2ysjp4xwo@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR1501MB2159:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a25f265-4364-4f6e-db47-08dac1bc92bd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHRwjb2drhieuvPgH/NyYfp3loRcReL0BF6RvsJdCVy4H8K2FDCW9hPsjZP4IlHkQqCFIQW1BhDIlppfj/5kaNwMX5iKGbruhGfXJEPfe3zBuY+MGDepBphVzP+yF1YUJ5/4taG1o+xJmY0tvifmYEiE7K/VD7jXRBuzr7Klu6f4UHLeczJZEo7AgsCJvMpPKqQrHd3zlvFr1jQCDpUCXZhJDq/bRgLIU2rVxDhxVXHs5W/RWaTkFXiDGWQ3t5n9Xa20IfFZeYHSPGvCwJMWH1otTEiz5WaMEYs511bgw8AnOIaJJ0LO3qGb09f+RzwDuuppeH9ZrDngjUjmilx8yKOfSZSo2pfsrUHmBRfCDmHigBl8pkGDv6W91ma8IuQ3NyFc6UfdhoIjwhbB6g0/UUMyrjTGmrget2LuIlZ3LkpY/4uq50XiOmZ82yLngcxCXPOIn7/KHQL8fiZs9tel4th4q4HT+Gn9xg1kjfqv86fP6awWgNIVq5u+S33UKh9VGKPTUQyuyEsxosUznzpbd0WgJf7Az2qOJsk9bbvWytszp2tJ9LyN+VCoMQoMVSRure6I+S9HEB7WUY4kjERw+bgdqaUyu46bn2mpmKQ93Uduo1EaUggmSQZzZtYkwzjCfpgql1lBvhtKfFagIriyXbTRsUQX9MyIFWikfdW/ysFSdGgrFGgcRkYy0LqQuZ8EhlxUsgwIzfocOEaGA/ZOTGu5OsAHfnX6GiqGCJ45kYpJquYsIV1QMBe/J7kKzLFXFOD2LKwkcjLERb49Cq15V8jMQkAvWg+5d8xfdBALnNJxVjQxpWtD8xWes1kfyEGuUMjJdKeoDtqXMj7DHUv0rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(66946007)(54906003)(83380400001)(6666004)(110136005)(316002)(31696002)(8676002)(86362001)(2616005)(66476007)(5660300002)(66556008)(186003)(41300700001)(6512007)(36756003)(53546011)(6506007)(8936002)(4326008)(31686004)(38100700002)(2906002)(6486002)(966005)(66899015)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjY5Qm1sVnl3UWwxa05UWndTV2hhL2taMld1Tng4ck1FcExjSEZLV1lLVmtK?=
 =?utf-8?B?TTQvU0hMRUdhajVvTjluQnErclRrdFpqUzBzQjFOYnZ3VXFwczM4MFpwaml5?=
 =?utf-8?B?dmgyVml4bXI2RFBtMjZCV091d0FSM01sdnJFaDlpUVRWK0NtVjgvS0xhV0lR?=
 =?utf-8?B?bTdXS2ZhaktLY1NjN2FCcmx5RGdHMjJHNzlWRGMzK1k4L04vVmYvbUx3dXI2?=
 =?utf-8?B?QkgzUVBKdXVZTW9EOVZGRlVRUHNhbm0zNVpBVDdNSDc1V1ZqSmR3NWhXK0VT?=
 =?utf-8?B?bmdiREZPWnVPanNTVG1pRnFXaGNhb1ovR2RoVkgxMm1IUC92ZjNUQUFnR2tF?=
 =?utf-8?B?bGdpZ0k4eTU5d25BK3NOODlsaGFXenhjb0JoZU1DTi8rc0d3blV2OTdoT1M3?=
 =?utf-8?B?STZFTmVzb0ZHNEhqTm01QmlZeXE1d0k2clZyUHNIUHdFZHZhSW1IUFN6V2ph?=
 =?utf-8?B?RDJHVDBFUlNzYUExV3I0RVQxK1JVcWUrd1l1THdnbm1ZSGhDU1VlVmhuMHZs?=
 =?utf-8?B?VmRMaWZ0S3h6ZkUzc0s5N3EwaU9qYUQ2RDVSZEMyQkUvMVdqODlzcWZkNHNY?=
 =?utf-8?B?NXFhMzVEM2VieDVwcjNBeU1NQmZwd0lNS1E1R0U2WXVTbkI2SmczaGE3aE1j?=
 =?utf-8?B?RzNHNnJieWh4ZEtySm1zVGE4SEU1aTB3RGtiS1V0UXVIT1BHeW0vNDdTR2ZK?=
 =?utf-8?B?bG1aMUwzMzR3OHU4TUQrL01oczBoZ1g2SkkyYThOQW0zTWVkY204ZkpvOFEz?=
 =?utf-8?B?dVNEZEllcDN1SzQvdXM4bW9jRTNoMkdBb3JVYlhJNVNkZ2h4b3hmREdaRzBp?=
 =?utf-8?B?di93N0RXS1lOTGN0bUVNRm5scmJHV2w0MXkzMWV5aUw0WHVVUE9IWi9xb0dB?=
 =?utf-8?B?VEhxcGt4QVQ1WW8xSVhHbXkwWE1pVi9CZy9RYmNKeVJDWHhYWlNQS3c2OXpR?=
 =?utf-8?B?NFpjdlFQdHo3aXdIOWltTGo2SStBWFlJb1k3WEh6N3NTdGdUdnFnMTJVaUE0?=
 =?utf-8?B?YmJlNGMvMTZHbHpGY1pKa2svSWZxYWZiS2ZPdnpURWw2VjRFdDZwK3I0a3Fu?=
 =?utf-8?B?VXhHUzI3OCtKd1J2N2UzUXZUbDVtZUo3MmNjUytpTGF2OUw5dnhmTUFrbmRE?=
 =?utf-8?B?ek5ndmNUL3dQcEhoMm50dUFTWlNVYXdGYXVnalpKN05FcGFuY21TVjBoNnht?=
 =?utf-8?B?eC9TUXlPUVdRMXpjSm8rOUpkaFRRbTFvUWZCdzBId3djNUxiWUxoT25CWE53?=
 =?utf-8?B?Wmowd0VsVXVVYUpyY3VmRUk0NzlEcDE5RlRIYVRZL1ZhUGJacjU4ZmlMVUtE?=
 =?utf-8?B?OGk4Z3RRS0FxSm42ZUw1QlluNlhHcTdIYUJhdmdmRHg4Zkh6OWJvMHBIWFZU?=
 =?utf-8?B?d1kwaGxVRjVMdXpLQ3FyUUhka084UWJkUEF4dWhHSUNGaEZqT3N1OXVFWFJy?=
 =?utf-8?B?WVZoeUZhOGJQb2poaE02VzV6cEo3YnZ6Y0tkcGx6V2l2Y3Y4azNvOEtlYWFu?=
 =?utf-8?B?RXMzUlFtSExrazdqRS8vMmxKSGoxY21JeEk1ckJrNk43Vmw4L0x4ZGNrTm0x?=
 =?utf-8?B?Rk0vLzRZUE1wNmZmUnhoQUQzMEcyaW9UekMxNlgveHRrcGRMOVR2NDJZd2R4?=
 =?utf-8?B?VHMxbVNycEdqN05XV1pIMHo3aVY0MGtmMndXc3NabURHcTNURWM5YTg5K1Zt?=
 =?utf-8?B?M0JRZTBOK0RjNXJudjk2K21HeVZ1TnNNQk1NazV2aU92NkZsVFZBVVVVYWtU?=
 =?utf-8?B?MS9ZU1RIYXN0b1BwQWhZOXNqSzN5d25IM3JudXBTalVGUGhVVmJtQTMxN0s1?=
 =?utf-8?B?N1UwSDZWSklXSHg3a2pPUDNjVUw5RkJYMGhPd1JRWmxWTW1UdmJ3SGZsSlBq?=
 =?utf-8?B?eW9JdDZrOWtWUW5XUk41d2huY0prc3JnVVlVbkluUWRKSVlFT25zYjJTb1BN?=
 =?utf-8?B?aTRmTXo0eUd6Z2ZERmI4b3N5ZjAxdWtZNEhzOERHNGNCQms4ZGhMZG1BSWtz?=
 =?utf-8?B?R2ZuU0FYd2N0SktOWnViK3RQTitOUmFJdWx1dG9HY2QyT1dXSHNLSE9JOTMw?=
 =?utf-8?B?WkpUQlc0QTk5MnJJYzMzOFZRVklNVDNLT0cwaDIxajhBSElmdVNObWZ2azR3?=
 =?utf-8?B?WEhPSy81TmRXRW5zMmJZU0U1QTE3RTVCM2tLS1hYQXdoZ2ZqdXQvY2lmNVFP?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a25f265-4364-4f6e-db47-08dac1bc92bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 19:08:08.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn4x6VZ73CIubnJhIOZFF/6eTjHjiqYF7KvBmYt/Cg2UuQAsw8Kvj6oFeLi8lCaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2159
X-Proofpoint-ORIG-GUID: d8Zd9soMCXZLWgLHUHoVDMY8P2U7OyWW
X-Proofpoint-GUID: d8Zd9soMCXZLWgLHUHoVDMY8P2U7OyWW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 9:09 AM, Kumar Kartikeya Dwivedi wrote:
> On Tue, Nov 08, 2022 at 01:11:09PM IST, Yonghong Song wrote:
>> Add two kfunc's bpf_rcu_read_lock() and bpf_rcu_read_unlock(). These two kfunc's
>> can be used for all program types. A new kfunc hook type BTF_KFUNC_HOOK_GENERIC
>> is added which corresponds to prog type BPF_PROG_TYPE_UNSPEC, indicating the
>> kfunc intends to be used for all prog types.
>>
>> The kfunc bpf_rcu_read_lock() is tagged with new flag KF_RCU_LOCK and
>> bpf_rcu_read_unlock() with new flag KF_RCU_UNLOCK. These two new flags
>> are used by the verifier to identify these two helpers.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h  |  3 +++
>>   include/linux/btf.h  |  2 ++
>>   kernel/bpf/btf.c     |  8 ++++++++
>>   kernel/bpf/helpers.c | 25 ++++++++++++++++++++++++-
>>   4 files changed, 37 insertions(+), 1 deletion(-)
>>
>> For new kfuncs, I added KF_RCU_LOCK and KF_RCU_UNLOCK flags to
>> indicate a helper could be bpf_rcu_read_lock/unlock(). This could
>> be a waste for kfunc flag space as the flag is used to identify
>> one helper. Alternatively, we might identify kfunc based on
>> btf_id. Any suggestions are welcome.
>>
> 
> It can be done similar to this change:
> https://lore.kernel.org/bpf/20221107230950.7117-17-memxor@gmail.com
> So compare meta.func_id to special_kfunc_list[KF_bpf_rcu_read_lock].

Thanks! This should be much better.
