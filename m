Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527324847BB
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 19:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiADSY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 13:24:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21302 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232106AbiADSY3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 13:24:29 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 204GG0wV009560;
        Tue, 4 Jan 2022 10:24:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eXiSnaaaFaOmv1wDdOVKB4s95OUWtg9xLPbM9Cq0c3A=;
 b=Txh+PTCKmhyzUEAZYfHMkHkfpOCUTfLp9Wrn4INMchMpKGRRka7iYVW8MJwHhfI3BBzu
 eOhI+CD3Q2yUVfRC9tL2iwJhbD+QY9kYOG8vaFQcB0irX+DCXBiEEKKDwLIPZZ9RLtZo
 DtKvHeaPrwN1uSgS5TCeWjHwitBw0q8DQGQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dc8mxwhre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Jan 2022 10:24:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 10:24:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLDQ90b8sr9VTeCzsA/vF0uRocT5QIqs697Wi0sr2nuxAg1zbB6A26T629YoC46VFRJ3z6Ff3Rzbj+H9Ox10jmBrWjcnh15HrUNKAqxOWi6agQqDkX4WP4afNT263IRu7Wn7E63S0nDQpvDUaoeakh5nKtWzyQOlLFphf/Z1gDXX7H6ok3eUUh6/b1Kp3PAylF3VZnhbsQUkdgMkslMPvuc+VPNqlTMt5mFL4vhj/EWmIuesocaZcRPYxzH0aST7a+Jl9DhnTUVerafkX8inkId3q1CuudWO9ltB3NI0q2w2HNstIeG1Rym9seDeFloOLAdJnUvzjM4wpH/HBB4iBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTIufMxIdWvIOA9+GQWxCNgzhDdfeQJBk8kLsVA9pPA=;
 b=MLGORF8+XxLmK/SwRc3pOsq7fsHqYnOQiGrrDiByj49IR0IqSYlUVYuKY5cTV6EZ9ylmAKs6SaMSdf6b2znmbLVsuxaU7RGKqx9tVDVY6+wLvrjit7Qs/kTnYF4u2XT7pLLuZ9NNoa1luP0yPTmUNK9CPlvTG/Ey3bU+1Zzuga3btzJ5PpO+LtxhllJE403OaY/5tqasVXvv3W3lcTezGyPXFTawhoqA8Vx6dcffeY/Z8pQcpXWaW3oSffXRe/k38qb9Wa+lR1uQov0F1kD31dtUwbD4lodbXpKdjEe8LEHLhf6W0Xd/k1j8k3k9KT+P802SNlirBguI9RNLkaktkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4872.namprd15.prod.outlook.com (2603:10b6:806:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 4 Jan
 2022 18:24:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4823.023; Tue, 4 Jan 2022
 18:24:25 +0000
Message-ID: <5fa06774-2480-ee73-a7a6-f0e6eb760545@fb.com>
Date:   Tue, 4 Jan 2022 10:24:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: Verification error on bpf_map_lookup_elem with BPF_CORE_READ
Content-Language: en-US
To:     Tal Lossos <tallossos@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAO15rPnCtpSgH_Nucb=Zkp04iMS1w8uYiFGgbP4LG1rujmd9HA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAO15rPnCtpSgH_Nucb=Zkp04iMS1w8uYiFGgbP4LG1rujmd9HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:300:d4::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9f8a410-bf3a-442c-6b60-08d9cfaf7016
X-MS-TrafficTypeDiagnostic: SA1PR15MB4872:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB48725E700FC4F8C580E7C87AD34A9@SA1PR15MB4872.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9b2yC+9YnuXf4DOWJk3abi2dGZAHB5E52TakTHzzENdy6Ia7F+8/yB5cVJY2K58S0LtOR6Gof/67sEArodqabmjNYg+/KIkgqdYWWMueLA+XpFev8hUI+Wq61S1sun/XOJV7d9ml4PHO1Cu4BBFh5yVSVJFRqID8t8uj4PP0JcTMRKtrV4W5nTqULiP9yxtnP5Kr5Fbub+esfcm/HvsNpdjQKjaw3zqJnfNC+507FpogTCxwVWlByD3eGkALhelTAZvmLOy2DY+FxXYsJDPxgeyuDVKchPZFf25uSaLCB651BCFaX6JQfU1vGRBgbCmfmSMJ1ojFY/u1/0yE/asXK43C4rzQZwOUVjOy3seORRPeWFIr/lZ8dzqZqhH49FV04iJcSRsEKnD+nAstx6gKbmZZSPCio9kW66zqXWT5CE7R5kcX+LIPptYGGtehsATjsC7ZsOL0/ATz9uKp9docez7oHY7fnEChgtqqXy4faXAoHuop7eHc/SIIpva5+vJf50G6HVMb472dU10QI3U6wcdqwnAsgDpR8pdHVQ9eWn/3BMOKshciww8hbFrenRdgL4cp+LiAcYBxV+HSLT3cD34oglO/1tYLOUcMhrCDqVz5vnXmNzg2RtijHj4NCGOrNR0lncHcKKcDBXADvIYZgmQSZTA1pA60ZdK4yrQR8iMjwGdXwTetDfpEKu7S+YX3DLfxu+70ArSKxpc7NTQpdrXVkFFuKr5cjHolxrB6PWRG4Q9cYsgOUIN/aeMxn27d5k3p1/BS3JNSuyuMV8/Yz+wwFs24iQMEmgC5CNUXftl2JKENyISpcE6XHL7L307W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38100700002)(2616005)(86362001)(2906002)(6666004)(53546011)(6506007)(316002)(36756003)(508600001)(5660300002)(83380400001)(31686004)(66556008)(110136005)(66476007)(6512007)(66946007)(6486002)(52116002)(8676002)(8936002)(966005)(15650500001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MCt5MVNJSEFRNHI1M1NUU0FzeHhjcTkyc3NsUDhCZ1M3bzV2NE9jN0g0cnVJ?=
 =?utf-8?B?Mlp4Z2hGbVp5SEJrQVA3WWc0TkUza0pvMnJIazhSNWVIL3MzSlpzdFh1Y2Rk?=
 =?utf-8?B?UWJyeDZGeWhRN1lzaW9CTVFOODNDQTdCcGtjenpwV1BncVhpZUxWemcwbmYx?=
 =?utf-8?B?QWpBUEZlbmQ2bGNxcUI5VUgwdkFhdm5HZkJsMUIvT0p1VWJibmFYTjZLV0hL?=
 =?utf-8?B?cFgyNFpYWm5rRWxsU1ZJaWk5ZTFncGZockN6VktWT0ZjU0FEYWdJVzFVZXZF?=
 =?utf-8?B?WjlMeDd5TXl0TFA2NFE0L2hlMGFZN2F5YkFVU1RObGVnT1JrcnJZSTBIZDVJ?=
 =?utf-8?B?S004VXpOS1Y1T3JZQjdpUlRDNHRWRG9OUFVuVEMzSC9EbWhockxleUNhUE0r?=
 =?utf-8?B?Rkt2Q0VpTi9WUUYyVEh1RFNSYy80MHRJQytLUHVyOVF3SHRoWG1NMWcrUlhz?=
 =?utf-8?B?MDUxYXdDMVphUkUrbFQrMHg5MWVxTmRBZ3k5M3B1ZjJhWms2bXJYb3VRSVJH?=
 =?utf-8?B?em1uRmJTOGliMm1MYzVhTDQ0M2lVbGc0V1ZId1NUOFhReTFUdld4WUovSkNh?=
 =?utf-8?B?SUdpT3BWYVZLbTVHUWdleFArbHp6RUF4V2ZGSmtKQ2NGQmUyZkZqbmxFVVcv?=
 =?utf-8?B?RUdidHdOMDA5S0pyN1lvWmEvWFpaYjhzeHByS250Rk1YQ3ppYlF6UGR6WnNZ?=
 =?utf-8?B?S2VwSklkRFJWNThFQkhURnNnZmY1YjMvYmNzY2VMZTJIWjBMUm5vejMwQ0Rk?=
 =?utf-8?B?cmJJL0tkdGhjRTRrMEdsVUZOTjl1WkFxYzFuN0dRWnNLVnJ6L0JVdWcwTGtL?=
 =?utf-8?B?R2EzdUJUazlQc3VNaGlDZ0gwWjkwUkN0UWp6R3o3OFJDd3prTFhNK2NNZkc1?=
 =?utf-8?B?VEErYXNKblBJNUMxVEh5UFh1dGFyTHU3a1JldDQ3N3VnRVl0VGZIeEx6VEJM?=
 =?utf-8?B?aC9ZakFBV29NYjk4L1FoaEhlY3RsaVJBQ2VXZHNrUG1BYjFLRU12TVFhOFVy?=
 =?utf-8?B?KzkzdWxJS1ZnZ3VSTjczcDkzOE5lR2x0dWcyK3ZjREIwWW95ak1VUGxFaGt2?=
 =?utf-8?B?d1VZQjdRY3poQktsZmVPM01aWlRHUWRTVFByaU9sTFFZWlBkdGVqb0JETjQz?=
 =?utf-8?B?Ly9weTJ3dTJVWWgyRG9kWEZMUVJFL2N0Y2d3YjYybXhlNVphVkNySEk3aU5q?=
 =?utf-8?B?eEx3ZjdvM3ZQMElrRUZ3c2Y5N2lkeW93NXQ2SCt1Q1FDVThQOHg0N0xCejUy?=
 =?utf-8?B?bjVialBoUFlaNnRSVG1xeEg3SS82OVlSR05hMlFPbnlOWlJRR3NtL25SdG1L?=
 =?utf-8?B?Nm1JUnl6WVh6Mm5SZ0svYlM3dE15b2J1dUVYNzQ0eVdzQ1hqZkZpMWw3ZGRY?=
 =?utf-8?B?L0JFMWp5Z04rcks4Qnd5L0dNdkM1S1FMWFM2cjF6SlBZNEZSVkVJZlVKYWQ3?=
 =?utf-8?B?OEVld255b2ZhTUJMem1GVEZKamxHbUN4d0tQdGpxMndsSTRaclBwWkptQS9G?=
 =?utf-8?B?Skkwb1pSY0dpTXMzL0VweFl5M0hreWV2NFFsWElHTXVKWjNsSXdKbUZuM2dN?=
 =?utf-8?B?UEdhUEIreS8yWDNvc0pqaUhibXl0QkhkeXFxNzZHK0FrTWtHYisyVWdPcnRj?=
 =?utf-8?B?dEM5YXFuWVR6eU5RUTQ0eW41bm8wYUYxMVhoYzFJaFdlcWlBQzVmZVF3OWxp?=
 =?utf-8?B?ZjFYMys4ckhGZVpxNTlabFY3TGpwSG9Va0lrY1Q2ekFFOGVPeFV1UHRHRHVL?=
 =?utf-8?B?SkxmTFBXQVVlV3BOdjhjb1JLRjlKZUZicnA0bkVEdmFsMkxRNklKQmpPbnFJ?=
 =?utf-8?B?UGg5TnZyQWUwT1dWSzZpQkhDblRSWVRSNWRHeFd6OWtKQXhrZit0aUpuMVdx?=
 =?utf-8?B?TWUrTVc4Q0ZKYnJlQlZVMnFWT001VmNDb29tNk9qR0VCTkVDVlJISG9QOXd5?=
 =?utf-8?B?bWlRbmxCT041eVkrV0M2MFQ4UlE0Z2RROTdnd3hIS3dvd1p5Y0hBZEo0aXdP?=
 =?utf-8?B?dlgwOHoxT3FyS1dHeFhkZHA4cFZLWmkvZFpKUCs4OU5ueG1ucFNBVForbjNq?=
 =?utf-8?B?NlJyWDhUSGR0bi9ENnI0T05UM2hjeEdQcDRJNEFzWDIvZE4xSHB4SjlqUmJ4?=
 =?utf-8?Q?4JrpCpUhiT9a/3X72okhIBopN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f8a410-bf3a-442c-6b60-08d9cfaf7016
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 18:24:25.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdSH1FEEQMwQ14/tegzx7Q1bvRgj6GmGFV02C0ZSx58dyyb9d9VeJbCHPKFQMrn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4872
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: MYrUMYoS7oZcTcgy5B1CCDsymnhUrf8B
X-Proofpoint-GUID: MYrUMYoS7oZcTcgy5B1CCDsymnhUrf8B
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_09,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=907 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/4/22 3:35 AM, Tal Lossos wrote:
> Hello!
> I’ve encountered a weird behaviour of verification error regarding
> using bpf_map_lookup_elem (specifically bpf_inode_storage_get in my
> use case) and BPF_CORE_READ as a key.
> For example, if I’m using an inode_storage map, and let’s say that I’m
> using a hook that has a dentry named “dentry” in the context, If I
> will try to use bpf_inode_storage_get, the only way I could do it is
> by passing dentry->d_inode as the key arg, and if I will try to do it
> in the CO-RE way by using BPF_CORE_READ(dentry, d_inode) as the key I
> will fail (because the key is a “inv” (scalar) and not “ptr_” -
> https://elixir.bootlin.com/linux/v5.11/source/kernel/bpf/bpf_inode_storage.c#L266 ):
> struct
> {
>      __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
>      __uint(map_flags, BPF_F_NO_PREALLOC);
>      __type(key, int);
>      __type(value, value_t);
> } inode_storage_map SEC(".maps");
> 
> SEC("lsm/inode_rename")
> int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
>       struct inode *new_dir, struct dentry *new_dentry,
>       unsigned int flags)
> {
> struct value_t *storage;
> 
> storage = bpf_inode_storage_get(&inode_storage_map,
> old_dentry->d_inode, 0, 0); // this will work
>    storage = bpf_inode_storage_get(&inode_storage_map,
> BPF_CORE_READ(old_dentry, d_inode), 0, 0); // this won't work
>      ...
> }
>  From a quick glimpse into the verifier sources I can assume that the
> BPF_CORE_READ macro (which calls bpf_core_read), returns a “scalar”
> (is it because ebpf helpers counts as “global functions”?) thus
> failing the verification.
> This behaviour is kind of weird because I would expect to be allowed
> to call bpf_inode_storage_get with the BPF_CORE_READ (’s output) as
> the key arg.
> May I have some clarification on this please?

The reason is BPF_CORE_READ macro eventually used
   bpf_probe_read_kernel()
to read the the old_dentry->d_inode (adjusted after relocation).
The BTF_ID type information with read-result of bpf_probe_read_kernel()
is lost in verifier and that is why you hit the above verification 
failure. CORE predates fentry/fexit so bpf_probe_read_kernel() is
used to relocatable kernel memory accesses.

But now we have direct memory access.
To resolve the above issue, I think we might need libbpf to
directly modify the offset in the instruction based on
relocation records. For example, the original old_dentry->dinode
code looks like
     r1 = *(u64 *)(r2 + 32)
there will be a relocation against offset "32".
libbpf could directly adjust "32" based on relocation information.

> 
> Thanks.
