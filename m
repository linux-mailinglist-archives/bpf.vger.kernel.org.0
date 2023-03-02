Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0873E6A8D21
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCBXiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCBXiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:38:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D02D74
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:38:15 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KVMYi021111;
        Thu, 2 Mar 2023 15:38:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fQZN9LQYpi933b+eS/VlbX2mVQouOef8AIRDBwEFWKQ=;
 b=kNlmlW7O89XSxNbUuagDxgx1qRZkIHvNa2S6Er0j/thk8vWIXOZohqyhKpfclmLyC2QL
 I1yCy+7IOnzhZqFFHVLxUtq5Eqy5mBCyYm1ai+eDLtfn0ds63LSaQARnzQFLZ8MflE2D
 vQNNblAtTCSyes5Ga66csFT/6wID02rm8uiSXrJua6u7UFybUxvGEq/iNu4eXtyfzzKS
 OhSIuQkicXqbrPUBAcF5sySTM0CIETKX0KFUEY8Bro22sldtbHrT3yDziZyWrzDYHtf/
 n0pALlo25Cbk4mj8D/sGqWRUBNqwU6YLTi8J0/4WOyPh8JsIJy2NCLyApIbAj4PeEdGu iA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2xg6kkkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 15:38:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgrFydoFPseS48IsYZP3etQPDVXX4zDjbZvr1ymSSQNtO5zM+z80SHSji6JOm4di+usUMkLXaTXMFGREsh5zEQs37f0au+t5yqwKqCrLf7iczQVAqbmzoddBlDx5RGPkTosk87u4FtlYzBYfh99qpnJdQyHoKvAabItz97vaBCiS++fFL3hsXVgv8e2uzP9qm3XNCJm5FR/uhyMWXTTnVGoEs6x8NMsE3zChR1EqPxZYJUpEY5UDHLwiPr1Gy9r1RxdSZyXqtkbRc+gP5O//r0JTW2R0t86llR0DKDvpmG2chAxTD8tzN+0VcAVrEAJ+v+CDqlclC/+6IBjxv244jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQZN9LQYpi933b+eS/VlbX2mVQouOef8AIRDBwEFWKQ=;
 b=g+/Gu7IbUMdY7E/33lHZ4G9t4Xm19Jqzd+7UOW1vZu6LUpz+ot+SpHAQqaCKSf5UY0AwrHEreVM93SgDz/Tza7gzMQ6QFiv987BivXeodPwqR/dStjMIsqwABTJigX7aNIIJlPpznIhe5MqfxMUY9g8VDF0s6SEAv7w9lLntU9fCBTeSRBsMPCT4EQndcdBHrJgs9IwHtK0iC29zZG26sfXETi4EozQRL2JQMWs+3qsIEGRl0gulbwKfm3I0NdCpA2OdVR0tKdXCVxhg+8jantXHJCJqZE3ZrpOex5PT7GNBmuNcuElu4reMu7CQ86TfBZ9+AyHp23BihcMp1S7oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by BLAPR15MB3923.namprd15.prod.outlook.com (2603:10b6:208:276::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 23:37:57 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::1fd5:ff0e:d3d2:eb81]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::1fd5:ff0e:d3d2:eb81%8]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 23:37:57 +0000
Message-ID: <0cd0bbc4-6d0d-4702-1574-e9c6bf0a4800@meta.com>
Date:   Thu, 2 Mar 2023 18:37:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf
 prog flags
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
References: <20230302231924.344383-1-davemarchevsky@fb.com>
 <CAADnVQJV_yQ23EeFuuHC+AvoxgVLVKZvaYkWfzhk=z3kxWHmHA@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAADnVQJV_yQ23EeFuuHC+AvoxgVLVKZvaYkWfzhk=z3kxWHmHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:208:32d::20) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|BLAPR15MB3923:EE_
X-MS-Office365-Filtering-Correlation-Id: a052a710-8ce4-4520-1d7e-08db1b7726a3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvX1LR3sseVKUR1LIaD/2njq9/i/7Y8VW+oVRZVwUCOBbkfmc1Ab0dq8PuX5WqFAq6XTXqDDbvieeoODmpvgEGwCHAjcgEl7kW07SAjoreuy2Wbv3cwUsuSiHAmDDY5R2AC42QkQpK96XRcvB2Nr0R9C4AIkAVMJrgWso5gIy/6w2fZq7jewWpQaam2JLSdylv/sno2PfDSKjwlnJe1z2jdJierhRSIacAMx9qC9KoAlR4eADM847+t8wpj2ZkvkYGCMamjU4RKui8U59zyIeJubqNR51d3K54CGoN5aRiNHveYiw20tJQZziHRIYQowpSzQw+RbEMc/2yLm3RML52LMgDP9r27o6NGoRx9/4aFfJGFXk2LOOR7wPVg3Q9ReJXwXpUwOL0ynJkVBKmX2Qqwbvc+HQh/akqsw49McVlHT0aewVDnzneCy3qr3xRvSGz2FBVQbzTye6hqrCPGfnngQ6Tn4GiIQ9uALq5iot+IPGHoRtVID6M9seT7D6vCWDxpXSq+abq+isKgksMQ1BN7J80KaEowuP/QEP8wiRIOhcSkvRtlo9xKiCrOoPx1ZshGt5tqcZzie/atCINBWW/CxPsfoZZd3+tiFGnAMeNhlxHIlUXtjdxXfkwlscpO0/JmGN15qBv3Pw/ufZkZ2umMB8YMdiKuZxSwfq5A06Lvk8emnKMdhD/nAFgGBAKZSJoPV1Gd5EHo8OZ0xM6KgiAFXzkCEnWq2kTuXZ02iVzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199018)(86362001)(31696002)(53546011)(36756003)(2616005)(66476007)(66556008)(186003)(4326008)(8676002)(66946007)(8936002)(41300700001)(54906003)(6512007)(6486002)(110136005)(5660300002)(6666004)(316002)(6506007)(478600001)(38100700002)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZqb1gvWmJkZWxaeTJIOU40eXhYSkhQMkZ4Rk9WSHBBZXVFcDRCU3RHaHQ5?=
 =?utf-8?B?NkhTOWtteHViNnBKc1ZqdXRWcE1Ed2JtazNEZUg3RWNuNVhmb056bjJFK1dE?=
 =?utf-8?B?MTF4cHFpd2F2dzNMMDd5OXFMWWxIWkt6OVF3cXZKUkZWSHRtdmhWUDI1eWdV?=
 =?utf-8?B?Q1VCM2h4WXRTdzJaR0xMQ1RKTGRLczZCVVNyTFZxME5LSFhBM3J2WFBsanlp?=
 =?utf-8?B?UWRTbzhxRDhaNkpxTVdqMDVSVVAyWDZ4Yk9uWU94UnRvVUYvOEZmVFF3Tkpy?=
 =?utf-8?B?cGZBTjZyOHR3YkJsd1RHdDd6YWNaNU40ajdJWXFSNnVBOVE4aTNqS2RCeTgz?=
 =?utf-8?B?UTE4OVkwOGVOTzZnRWMzcFV2L2JCRElLdm5yVzJiVmlLVzhTQng3YTVIcDlN?=
 =?utf-8?B?b1Fxa3lueFZkMDcrOHFSbEtnTVJpSHJZYk52QklsNjhBT21ZTWJBQzVHbUxu?=
 =?utf-8?B?VjlBdzJDYWNFQUJlSE1qQzBIMUROd0c1dG5wSU12akNFcHl5UyswRGl2YkxW?=
 =?utf-8?B?WHBOaThIbC9sMFZKTmkvVWtFTnBpKy9WUEQyVDhJVGNROW1qeXZLc1NuSHc3?=
 =?utf-8?B?SmErOCtpY3JKNTRpYnBpVksyZ0k4elU1SWRYWndrcjRNRnFPNS9LVHB0KzQ1?=
 =?utf-8?B?QWxIOG9Qak5MRGZRNzNuYUNrS3I0NE5reG1FTDd0YjJCNVlpeFVEQlNhclNE?=
 =?utf-8?B?N3B1MEJlNGpaZDRFbWtLQmsrTUh1OVY3YlNCVk9tUFc0dmdFU3duRHlXQjVN?=
 =?utf-8?B?S3FZNGpwSitZNVJ2N0dPbHQzcUtWUmUvdjBIUDI0bFkrM0pXRGxuTWhFUzBi?=
 =?utf-8?B?dVVuT2huYmNTbURnRTZTTTFVRndsYk0vLzZ5azc0c3lWZm1SS2dLOGIrbVM3?=
 =?utf-8?B?TzlsbHRnQ1hoYnkxd0R4UUlXVmNnTkx4ZlBDSmJEYTRpcXVXYUJQOVFPRGlG?=
 =?utf-8?B?aWpPMllyZGxNZnYzeFpiVHgxYXdEUW9MOE03TG9HRFVVRVFUWW9iQngwakU0?=
 =?utf-8?B?ZjkzMmhSb3V0ZTUwV2NpSWRGNkZQdjVWZGkvRU1UQkQxeDlMdFpiSEVXRHAx?=
 =?utf-8?B?K1pINlVHdDROTEhpZ1BCL1FWUlhoLzUwMFl6RDJtdTJ4RXNFVzIvL2wrU0RX?=
 =?utf-8?B?Z3FoZWhJTldkUWJQc29BdE5iTTh4a1NMS1pBakVyd3VIeTVlb01wR0hKYUhm?=
 =?utf-8?B?YVhTY3FPSmVnS1NuOHBhb3BHcmk3M09JY0xhREw3R1Y0elNQTkNvMjE4c09U?=
 =?utf-8?B?c0pCRDFDOGlIK0pjS2hvUi8yelRpZ3I1TVFmRzVKWVlINDJlN0U5T3hTeWR2?=
 =?utf-8?B?U0VzM0ozVU9ya1ZlS1RCNXFlSW9NU3VzSmdkb1d5OGZZTEU3amNYanIwc3h5?=
 =?utf-8?B?S2ZueHNsTDlOamZIREwvN0svN0NFcWZTdExad3dWRUxCeTUrQVRWc1QyK1ZW?=
 =?utf-8?B?Y1hYTjVqbTZnMDRpT2pTN21oTy9nOS9FMWVoVUNONC9oeWZJenhCNVBidDJ3?=
 =?utf-8?B?b1VMSjFrblRDODFwZHpLaW9jSXRrZUtyY2sweDg4a2dEblgrYlIvVVR1UjE1?=
 =?utf-8?B?L1ZnTFN3NjdhbHA5R2FQSUdaUnRpcnJ4MUUvcngrcncyblIzSTFScWVtV0Rz?=
 =?utf-8?B?b3dVVkNHcVNPTGhDdjdVMzl4bDMzUjZWTk11TUxuRUo4alNabTRVb0djeVZE?=
 =?utf-8?B?bHBxT0pwRnhheUREM0xZUFdPMkgvWnZqRE0xRFRUWldlUERIb3dzUXZyRG95?=
 =?utf-8?B?SERwaE84ZGNxZ3h4TTkxcVd0TWtRV1p0S3BWOTdjSTdGMXBuckYwYld5aDBm?=
 =?utf-8?B?bXo4U2hkOVMreU9TdUdvOXBzOWg4OHpFalVrQ1N1SnlmYzVCREovZXpkRUp5?=
 =?utf-8?B?MDRLK2orR3JVK3E3OHFaeURvL0YvRHpSczE5WHJuQTVBTk9RUndIcUEyMW9v?=
 =?utf-8?B?RktGZ1BOckNBdzUxcWZ4b3J4YUZZamhkaHZrcit6RVFkUHIza3B3ZWI1Wk4y?=
 =?utf-8?B?eEEyTzlMWXNycGY1c3lhUXgwckR2QTB0S0ZlSDNsNGFEa2t4RGdvSVRLUllU?=
 =?utf-8?B?RWUwMng4QVhWNjhSdnQ0OWVOY2ZtOTJLQitHWFhqZEc2ZGtrclVjLy8wNCsy?=
 =?utf-8?B?RlZIUmpnOGljM1JhbmZTRXZ6ZUZHM2JONmpQeW5NWVNLUjdhNVRBaTM2dy9G?=
 =?utf-8?Q?mF5uLDMxvgTkq2iSDNbZ1S4=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a052a710-8ce4-4520-1d7e-08db1b7726a3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 23:37:56.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e52L1Penc6FhKcgIjnLVzqKt66uLej9BW+KLjooB0Oka+eFMXlDLFdAv+0MRblcn9tVDceVy1ACwZBpNHDFPIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3923
X-Proofpoint-GUID: -oHrytPzfZ1sKgiqZQCr7MpsiNAg734r
X-Proofpoint-ORIG-GUID: -oHrytPzfZ1sKgiqZQCr7MpsiNAg734r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/2/23 6:23 PM, Alexei Starovoitov wrote:
> On Thu, Mar 2, 2023 at 3:19 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> @@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx)
>>
>>         bpf_spin_lock(&glock);
>>         res = bpf_rbtree_first(&groot);
>> -       if (res)
>> -               n = container_of(res, struct node_data, node);
>> +       if (!res)
>> +               return -1;
> 
> The verifier cannot be ok with this return... I hope...
> 

FWIW it's because the test expects verification failure
and the branch taken by verifier produces the expected message
before evaluating other branch and complaining about retval:

0: R1=ctx(off=0,imm=0) R10=fp0
; bpf_spin_lock(&glock);
0: (18) r1 = 0xffff888103c70320       ; R1_w=map_value(off=16,ks=4,vs=40,imm=0)
2: (85) call bpf_spin_lock#93         ;
; res = bpf_rbtree_first(&groot);
3: (18) r1 = 0xffff888103c70310       ; R1_w=map_value(off=0,ks=4,vs=40,imm=0)
5: (85) call bpf_rbtree_first#121960
6: (bf) r6 = r0                       ; R0_w=ptr_or_null_node_data(id=1,non_own_ref,off=16,imm=0) R6_w=ptr_or_null_node_data(id=1,non_own_ref,off=16,imm=0)
7: (b7) r0 = -1                       ; R0_w=-1
; if (!res)
8: (15) if r6 == 0x0 goto pc+14       ; R6_w=ptr_node_data(non_own_ref,off=16,imm=0)
; bpf_spin_unlock(&glock);
9: (18) r1 = 0xffff888103c70320       ; R1_w=map_value(off=16,ks=4,vs=40,imm=0)
11: (85) call bpf_spin_unlock#94      ;
; bpf_spin_lock(&glock);
12: (18) r1 = 0xffff888103c70320      ; R1_w=map_value(off=16,ks=4,vs=40,imm=0)
14: (85) call bpf_spin_lock#93        ;
; bpf_rbtree_remove(&groot, &n->node);
15: (18) r1 = 0xffff888103c70310      ; R1_w=map_value(off=0,ks=4,vs=40,imm=0)
17: (bf) r2 = r6                      ; R2_w=scalar(id=2) R6=scalar(id=2)
18: (85) call bpf_rbtree_remove#121964
rbtree_remove node input must be non-owning ref

Regardless, fixed in v2

>> +       n = container_of(res, struct node_data, node);
>>         bpf_spin_unlock(&glock);
