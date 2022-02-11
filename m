Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18D54B1A6D
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 01:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbiBKAbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 19:31:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiBKAbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 19:31:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F23559A
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 16:31:07 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANremn007789;
        Thu, 10 Feb 2022 16:31:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LP/KnmbsKRxekMGU20AtB2H2EpLsm4aoVJ1joQwDKVI=;
 b=BYA8NxNw6p4ueNqch99pSbMy7L4KMTJgUwJyiGF3gzIz43obX1wpwEvOiz3oE7oO5zW4
 MhH9ANPxVVWsyZeJgsRxHXksSrTeAEn3zSdP2hFgLB2ky/VBYh/BvrcIvIajoH4AOcn3
 8tWefpie3B0Ub98HvVO7PZ34Jb0NXIr/Wt8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5853ad6c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 16:31:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 16:31:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evyXNJfiou6Ww6emWF3+Fnymtm+vprkS0X4Tg97BxU1wq+6DgRuwYv4kiLYAxeP+eTwYjx8MqaTbAJYCEEaE2cyrki3pezmeBdsfpzxMPpSDhlB7k2NdTFmQW8AfeYd92lYA+PeBdhQy6tPe7LEW2L2WWykKJe0ENHDlJzz6JdYKlysWRlcLc0WMNJW3B55ND0YdOnP4b2VW/2F+dvgqLwyqiCdvuDufHVCT5H2EJnhiYaL/50XzFFXHHFxee2HXeQ4nSnaVfmPLh4vz2DPATkCAacK3aTeY/fE0sREsAi5sm8Pzhva0UqVXnvkv1x8MvhvIvIl/sUf62EbyTgQT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP/KnmbsKRxekMGU20AtB2H2EpLsm4aoVJ1joQwDKVI=;
 b=noGtyn+J2PZA7hLSyCmbNjqhz0ZwE/zq15hQKpmdL3BvL6fh5BmsChDTIYwX8eg44fD/W5dVRn/OT3GUPzauiTcm7ahKLJjg22prL6ofh9xGtzlj43aqCCfzqeYAHSfcQ+UyM7xHlJVYBHquqWQyrQVut4H8RSN+poGqK0KhkB2Hq9b1fI0HqYTpxd7F6XnxiyEBxXchYU0GKLmGlX00ak7EWU2Nv3gMGvCoqClT/bkbpSS/OmayZNQihi29ux6QLEkWlWHqRBnmOQVThkwO6VXp5XHF0L/HPoRY2j81Lxj0eHESSsVDbtisA71G8kBw6s3adqSJN/Z/KwUj6FSJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4348.namprd15.prod.outlook.com (2603:10b6:303:bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Fri, 11 Feb
 2022 00:31:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 00:31:05 +0000
Message-ID: <bf1d4051-ae3b-c61e-131d-d6df9002529d@fb.com>
Date:   Thu, 10 Feb 2022 16:31:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: BTF type tag not emitted to BTF in some cases
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>
References: <20220210232411.pmhzj7v5uptqby7r@apollo.legion>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220210232411.pmhzj7v5uptqby7r@apollo.legion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c64f3e11-ebc6-471d-41dd-08d9ecf5c9ea
X-MS-TrafficTypeDiagnostic: MW4PR15MB4348:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB434813DBB623D1D0B664DC29D3309@MW4PR15MB4348.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0Y/Xhbel2LTjEmRQor4RzznEdgBTvQuJJvJIh+xg4/ShIBnYyHvXGXVcST2tMB4na1n9H2yAwAkqypUWH2aU7ZrJDGMhIqjY9y3zAZSz0pQ8D/2WeZ/Vs3Xw0CKbQt6IpLP0YghvFmnMbW9Je6G0A0T+Ln2baKkqiSV+i6oXCgM5FZbDQElujmfeaPfmzEKxC55WoQZ58p8OHj/rWWR2eWOZQzk2ohVhpPKuFJ62AuTxrC2yYRAVAX2JZF5MbMB46gMRl5NEM0p2HdOdv1Q8GVmfqAU90rNXbfujELqur776S+TpHMuK6/MlNwq0USFFrMYP66s9WmnqKDK2ESe+BfSZ7tODUKVRetu3gqO6s48BeNWucYf0wnU7ST+XY3U7S/FEXLLFXvkejXJo8srr5ObklLmwBFtIy5xPX1hK/hl+C6VJeFPQevOjUMyx0ara4NXxYR+Yj7kI8dV9c7ipgqKleV0XF7ZbxJq+gXPtXhi1HGIgwbXSI8cWYHYDW+Z7N9rlumti9n10vI1FK0RTvJvMxc9gN6JGci8TBCFH3Abhsvd/+0eKxvc5K2dTW81jXhJBM6x0Rm4DJSLFmQHK9J0axm2XA0CThRqGJ2qG1ceOR3txhZws9hOfAg6cG97ABvyLbqJksfqUIDMTdun7E8f5akh4Aj5N98FVIKcHS9j2J4Chw4/xku6B0QI7RS9vIgk28yQTnsB43TLvn58NkGdfckvJwGvIOSccZxtOBSbPY7PNrAbfI0WFbhoHBjPn9FWBhhm8d6ftYUVBVFc+gT2G2nUfvzSltpqfIS5yVD/eFZ3fV38hoVXvQgevGWW5Hk3PyUydR4mCeXxsH03TlIPr/8tXpQO6jXR1FcmRQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(6506007)(6666004)(6512007)(83380400001)(38100700002)(53546011)(86362001)(8676002)(8936002)(52116002)(316002)(31696002)(5660300002)(66476007)(31686004)(66946007)(186003)(2906002)(36756003)(2616005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdGdDZvYVBjUWQzQzJzN2M4aVVESldrVjFtb251bm1jS1dpWWlSanZKakxm?=
 =?utf-8?B?c1BVdVVJTXo2NlI1TTVKV25IMzg0TUVKVjJwZTBMeS8rNnBEeTBPdHdNMkdP?=
 =?utf-8?B?NDkwMVFTcmpqaDY0OVNBMVNBREdOY0Y5eThWNFZtRFRjSnF2N1ovbm5PRHpV?=
 =?utf-8?B?MnFPSUJqL3hYUThJWm5ES1dTSmVyMVFtMDNwT09nK2lrOU1NU1ozMVRmVndD?=
 =?utf-8?B?bDgyNDZyVTdtWWRuY1RUTzM5YXBDYjlmY2pGVEtJemxKeVhyTG1YN055a2pS?=
 =?utf-8?B?cFpBTGw4QU1QRnNENGNXM01Kb21XVVg5YUFlbThTaGVDQmtpcStyaTJTanlP?=
 =?utf-8?B?K1kzRWN1TkE3UklQN2d2WXZGdWlFT09DWGpuUUZiQVgxNmgxMFdBb3N4S0ta?=
 =?utf-8?B?ZjlzODQ3NW0ydjE2OGxqalJ2RW9ldDFzL0NMdmN3U2xjaTlHMVA4dG1OOWNS?=
 =?utf-8?B?WVNHYXhTc25zbGQzbmlXMWJWaG1QdnRxL3FEcmdPWTRmUmQzbDZXL1RtcEcv?=
 =?utf-8?B?b1l3NjJ1dE0rUTVBNmtWRmd3VXN1blN0cDVtb1Z6dkRqU0ZWdDVqQnZLanI0?=
 =?utf-8?B?c1ViY2hrY21mNW1RRGoxK0ZSbDZiZUZsdm9iaCtRMURKbklJS3c3QnZzZEpB?=
 =?utf-8?B?RFpLSW1KUDVUZFV0aThvYjdwbXEzbXhmbWovZDN0OFNLRzZJSlpyUVVzZGcy?=
 =?utf-8?B?NTY5ZStEWlZRVkFBVUFMZHozNjZYRUhiaVl2T2MxNnhrZGNDVDNMU2JNNFR3?=
 =?utf-8?B?cStLVGdsZ1BuT3VEQ1FaUVEvcWZpWnNTdHd6ODNkSlFXTE1mTFJSSEZocS9w?=
 =?utf-8?B?YlBQWTdISDdadkN1c1lkd1M3MFV1d0w3VnNTYlJOdThkNlZ6b2VDTkRoR0M1?=
 =?utf-8?B?cW1GMFVtK0FLUzV5a3d5U0ViN3lNaWtxT1BCTzhWZTM2YUJ5OTZwdEdCR2FE?=
 =?utf-8?B?ZFVhK2xrZ1pPeWtMMUtOblFQM1k5YjZEUzdMbDBLVjZwdnNDdUtxblVOaXJJ?=
 =?utf-8?B?N1pNTURMOXhaRm1RNHJERHg4aUtYWTRXMy9iekR4dEpRL2RIS0hxckR0N1Fa?=
 =?utf-8?B?TU9RZk1VdHlhRG51WnVpV1RYcyt5dGZpYWxiNG83N25QaW1YZzFaN1FFOENs?=
 =?utf-8?B?bDdmbWZZdERzUml4Sm93ck55cVBIckcraGZvbTRKMmZZaFNiVHdXNFdDK1hT?=
 =?utf-8?B?YllDcG4ybU9YU2ZPaHJDZEhHUGt2blVCb3Y2bGpGQ0pkUXIrbVFPV2NYZlgw?=
 =?utf-8?B?L00zVkR1RGJYRFFGVlFaZkRvRzFIZU9id2xCd0QxNGNYaElhc0x0czRsWGNX?=
 =?utf-8?B?bzV4akUvZnI0d0NZY25obFRjSlV2N2hQb0NEeDJ5ell3S05nMU9PcElablFu?=
 =?utf-8?B?UlJuNC90N09kcWdCZnNpSm1SVEx1eDgrZUNicUN5MXdRc25UUnhwK2J1eEhL?=
 =?utf-8?B?b3cxV1IzdEh5YytHZHM4UE1GTDNnSHR3NzJhUWl3K05CdzhXZ0M4TXo0U3U2?=
 =?utf-8?B?U3luSDlOSWQ1dkZvUU53Nk50SDVBZFFSaGloVzUwbFBOQXJESXM0K2diNzRP?=
 =?utf-8?B?TmJtaGxDWEhzTUI2RHBpUjc3dnVXNUFDS0w3Z2trN1lJK082U1pzeGJCVmYx?=
 =?utf-8?B?eUtQV3MwdGRSY0lnMHBabHBnaDFGb1VPV3ltcWg1NVNRQ1V1ZXZwOFpORE14?=
 =?utf-8?B?Z3I2Q0dCa21xOTFyTkI0eGRNcXduYWdCL1RmT1dSUFRndHd2QlpJMlRJb3hJ?=
 =?utf-8?B?NE1JMlN2Qit3QW42K3NwV0Ewazc2eHRBNE5CWEhKeHNZVUVyejhlcC9wZkIz?=
 =?utf-8?B?aTFzMTczaWZjOEYrYWdwbitDMmxLbWhjSkRWWkZSSXVua0hpc3BwMUsvQTF6?=
 =?utf-8?B?ZjdoZURpbWJST3BPZnVBZm4ybjMyc1lpYkFiY3hhUVJFTWN2R0N2Tm04cmEr?=
 =?utf-8?B?ZE5ZajliVyt6eDM3MklHbGxhb2Y5UzA0TkhZcmMyNFpHUDFYUmcwSVVSRW40?=
 =?utf-8?B?NXF3RTM4R3VhQ0oyb3ozZEhuRThiTEs0U2NVYlVwN3liRFEvcU5wWU9YajA2?=
 =?utf-8?B?VWJRYit1NTVJSytHZmkxYThQNlovcjFxeCtWOTNHZmZaR2MyaHZ6SmtsUHc0?=
 =?utf-8?B?RUl2YU5LL1I1MVBrbnNuRVFzUzVIcTFBckFheEI2anhYWGxjNytlVzBNUlFv?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c64f3e11-ebc6-471d-41dd-08d9ecf5c9ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 00:31:04.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ixmo5Sc9n50RG4R51vPQOgZaA9c5QTHw8W3QaxImMx2bnKE06C8BqSKwgnyzOAAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4348
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: NrQJWWwDMFWal4Bj0dfBwhwb-3rYuuH4
X-Proofpoint-ORIG-GUID: NrQJWWwDMFWal4Bj0dfBwhwb-3rYuuH4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxlogscore=936 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110000
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/10/22 3:24 PM, Kumar Kartikeya Dwivedi wrote:
> Hello,
> 
> I was trying to use BTF type tags, but I noticed that when I apply it to a
> non-builtin type, it isn't emitted in the 'PTR' -> 'TYPE_TAG' -> <TYPE> chain.
> 
> Consider the following two cases:
> 
>   ; cat tag_good.c
> #define __btf_id __attribute__((btf_type_tag("btf_id")))
> #define __ref    __attribute__((btf_type_tag("ref")))
> 
> struct map_value {
>          long __btf_id __ref *ptr;
> };
> 
> void func(struct map_value *, long *);
> 
> int main(void)
> {
>          struct map_value v = {};
> 
>          func(&v, v.ptr);
> }
> 
> ; cat tag_bad.c
> #define __btf_id __attribute__((btf_type_tag("btf_id")))
> #define __ref    __attribute__((btf_type_tag("ref")))
> 
> struct foo {
>          int i;
> };
> 
> struct map_value {
>          struct foo __btf_id __ref *ptr;
> };
> 
> void func(struct map_value *, struct foo *);
> 
> int main(void)
> {
>          struct map_value v = {};
> 
>          func(&v, v.ptr);
> }
> 
> --
> 
> In the first case, it is applied to a long, in the second, it is applied to
> struct foo.
> 
> For the first case, we see:
> 
> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] FUNC 'main' type_id=1 linkage=global
> [4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>          '(anon)' type_id=5
>          '(anon)' type_id=11
> [5] PTR '(anon)' type_id=6
> [6] STRUCT 'map_value' size=8 vlen=1
>          'ptr' type_id=9 bits_offset=0
> [7] TYPE_TAG 'btf_id' type_id=10
> [8] TYPE_TAG 'ref' type_id=7
> [9] PTR '(anon)' type_id=8
> [10] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> [11] PTR '(anon)' type_id=10
> [12] FUNC 'func' type_id=4 linkage=extern
> 
> For the second, there is no TYPE_TAG:
> 
>   ; ../linux/tools/bpf/bpftool/bpftool btf dump file tag_bad.o
> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] FUNC 'main' type_id=1 linkage=global
> [4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>          '(anon)' type_id=5
>          '(anon)' type_id=8
> [5] PTR '(anon)' type_id=6
> [6] STRUCT 'map_value' size=8 vlen=1
>          'ptr' type_id=7 bits_offset=0
> [7] PTR '(anon)' type_id=9
> [8] PTR '(anon)' type_id=9
> [9] STRUCT 'foo' size=4 vlen=1
>          'i' type_id=2 bits_offset=0
> [10] FUNC 'func' type_id=4 linkage=extern
> 
> --
> 
> Is there anything I am missing here? When I do llvm-dwarfdump for both, I see
> that the tag annotation is present for both:

Thanks for trying and reporting! This should be a llvm bpf backend bug.
Will fix it soon.

> 
> For the good case:
> 
> 0x00000067:   DW_TAG_pointer_type
>                  DW_AT_type      (0x00000073 "long")
> 
> 0x0000006c:     DW_TAG_unknown_6000
>                    DW_AT_name    ("btf_type_tag")
>                    DW_AT_const_value     ("btf_id")

BTW, if you use the same llvm-dwarfdump from 15.0.0,
$ llvm-dwarfdump --version
LLVM (http://llvm.org/):
   LLVM version 15.0.0git
   Optimized build with assertions.
   Default target: x86_64-unknown-linux-gnu
   Host CPU: skylake-avx512

You should see
0x0000006c:     DW_TAG_LLVM_annotation
                   DW_AT_name    ("btf_type_tag")
                   DW_AT_const_value     ("btf_id")

instead of
		DW_TAG_unknown_6000

> 
> 0x0000006f:     DW_TAG_unknown_6000
>                    DW_AT_name    ("btf_type_tag")
>                    DW_AT_const_value     ("ref")
> 
> For the bad case:
> 
> 0x00000067:   DW_TAG_pointer_type
>                  DW_AT_type      (0x00000073 "foo")
> 
> 0x0000006c:     DW_TAG_unknown_6000
>                    DW_AT_name    ("btf_type_tag")
>                    DW_AT_const_value     ("btf_id")
> 
> 0x0000006f:     DW_TAG_unknown_6000
>                    DW_AT_name    ("btf_type_tag")
>                    DW_AT_const_value     ("ref")
> 
> My clang version is a very recent compile:
> clang version 15.0.0 (https://github.com/llvm/llvm-project.git 9e08e9298059651e4f42eb608c3de9d4ad8004b2)
> 
> Thanks
> --
> Kartikeya
