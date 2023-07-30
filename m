Return-Path: <bpf+bounces-6343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360F77683B7
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 06:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3D91C20A2A
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 04:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9C7F9;
	Sun, 30 Jul 2023 04:54:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2064B
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 04:54:45 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4532134
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 21:54:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36U4Y4Ye030943;
	Sun, 30 Jul 2023 04:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : message-id : references : date : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LhJ/ztovlSysDiQiPEjylmPRTsj0glYpjOMO7fUplek=;
 b=c4aAThU0u4QM1PEEasIruqEs/HItoZQZTslUrs6Lc5j62EpEl+0WQoJZ1bzVONu9kkDz
 SwvbgeVZ8YMRLVLxmTwp2CULBxo3SknnCeb8NUeTsKewB8ZgRzGP+xr1w4i0yNopPrF1
 OwTZA5h8iZhO2fxsxXZO7egmKStWfQYphHB9kk8gA5Lfbza8FBgCRcslWJ59sCOefFgp
 RdepiFTcgUEz1EMBqYxii/0fusu0P6AvgM6n8Trf3tRCvbsUhf/0fMwpo9MkvanJtnPS
 Z4e1j4Os6r6n3Odqz4UAOndmtI5gjSe2QVL78euiiKIFPkgieg6JGgEeXXcmapEHWZjP vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc28v3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jul 2023 04:54:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36U1jqqs033492;
	Sun, 30 Jul 2023 04:54:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7347d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jul 2023 04:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLq1kGMgtWZDPHm4mJPeqIMwm/2Rp5TKDnQwND4belTrQSlnS2uNtrAn0KjW03McSveh2eSF2fFKHwKonOeRqH5JX60JWHzKPq6Gkg63mcC/sfElNMLKyKzO40H5sDZfScmXdYBFdmg21Dkv0gwLNgc13Sz/fyqEmvaQOBBvJPt6ei50MpwZrzwN1kc7PJegnG39Tvlwu9ZwjEu9Udrd9exm7s8wYNlPn3A/lc1RkY/3+T9Tq2wyN/Vc0Fm5GlaYu4ZXX+jC/1ywVMXeKfEzYS/xA2nf/BGPgJctNYdxY8TTuLfhT8ovph9Tqt0pTH9iG+bh8N8L0o3qZ8WaU6fPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhJ/ztovlSysDiQiPEjylmPRTsj0glYpjOMO7fUplek=;
 b=f5K8uKFUaeFJaJ9fnmeEeGIGEd4yKs8Iwe32HJy/K9ex78eIuchksArkfUBr9waWzxMiQSh8iZkYNTdswiQwY2D4357Wv1s683dp/xU0Mdu9kBizjwpxujZAManuJmG34sNGH53608mX7TZYWot13BC/ezr2gS8VhpM6FD6RrlqWxlrk+CjP8ywFSRZJ+sZsfZt0EwEkMMIDhlT+cET9RmG2ryH6w4WaHnmL5IqLHMqTD7RPJUSOzsvDka/HDV1KZmFhZVKvrr/UIOO83WqlxRoGNdGzAMQh5bkXO+gSKqMIAWr5QnPovJMdwvkbO5pQ+jILcQ1ot3mTFdLFOmenjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhJ/ztovlSysDiQiPEjylmPRTsj0glYpjOMO7fUplek=;
 b=txwTSXZxg0U+8e4jExPXlyPQbAatj9KyysBHkiqetI0DArf9mT/bP7PBtQxb+2fSQxW4VsBj1mlhe4aLMmruFjaA6nE2b2GL3QPMWglubcPUxb/sHpMtFdoIRZcrQj10JXXAh1ZaIRbTbvZ8M+ANLWQNHwCd9QO/jkq/dMcexs4=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sun, 30 Jul
 2023 04:54:29 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6631.026; Sun, 30 Jul 2023
 04:54:28 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: GCC and binutils support for BPF V4 instructions
In-Reply-To: <CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
	(Alexei Starovoitov's message of "Sat, 29 Jul 2023 10:56:00 -0700")
Message-ID: <87edkqm257.fsf@oracle.com>
References: <878rb0yonc.fsf@oracle.com>
	<13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
	<87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com>
	<CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
	<87jzujnms6.fsf@oracle.com>
	<CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
Date: Sun, 30 Jul 2023 06:54:23 +0200
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd55e48-a8c7-4756-6bf4-08db90b90e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tDXYObI2af7OH5vGveaH6zzdAG3PBKnx0Y0tw5SnzJsrmM+36eLM3lGALdWCC39QKGWSKtxYPrb/rB3aDfupWSe/kpkvHeneNkUP6AzxYEz/tVXoGXZnollMHRMUeYdXmB8Osbyo0GB1fAlD7600qLMi0+T7BpVVPwZmgN2ahyHvcag//GNqTt3guZb3b4Xw1mDWTuoL9mtC2LXqpr4rMNHnbPIgCOJej0T1boW/vj8JKPdmC3zy0O514Aosc8RqmzJv5XZxNncbkbMaE1+buVW6YjnkwpB22KCuYE/k6wa2Y16bUENjJb78/YX9YkU5rBMhnqw759h/0ztfbqKfBUh+6LT5VKfe7qfTgqFznjmC60XMDfSpMU0qyYPEpSw9EVW2Il2LxQwIYjr1ZdolxrAsW569oLPPVGbRjqSLK8KGto1wutGyTfRgVpTeioF7+sAdFyNzqevlvFfm3z8CXyQsgorgzDhwYnZcG730J9SVPqpRCDYMW0DYZWKvgDpu1qcWuXUpdP8697uoNUaLI651LLTlFcBDT/rSLdnxOPj1JvhFNR8TUOtRGB1goYmb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(53546011)(6506007)(26005)(54906003)(478600001)(186003)(6512007)(6486002)(6666004)(66476007)(66556008)(4326008)(6916009)(83380400001)(2616005)(66946007)(38100700002)(5660300002)(41300700001)(2906002)(316002)(8676002)(8936002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MW9OVlRNR0RPKzNwUGpwM3VTTkhxc3dOTmoxdzF0MUlnbytiVk53L2REWW1W?=
 =?utf-8?B?MmlJZ1lHQ2hsL1JBdnVHZys0TVc3YURZcnZBdDZzVTZJMnlzaTlCaHR5aXFv?=
 =?utf-8?B?MSs1M3FwZmEvUEFGbi9GT1N6eFJKN3I0bWlwN0ZSYmcxNmQ0VGdwcndVa1B1?=
 =?utf-8?B?cXNQSEQ3L1I2ZHN5WWM0M2ZVeldySUVESEdqa1RqbEJubGhkRmF6YTQ1WGU0?=
 =?utf-8?B?VTdOUlQ3Q1Q0WTlqSENlT1lPYkp3NTMxR3pSZW9FOHd0dlkvYlNUQU1SUmlH?=
 =?utf-8?B?ZUc4eFQyUS9TdzRQbmR5RFUzVG1xNU5rK1Fxc0prOTFBZFBkOHRnSmtFc0hv?=
 =?utf-8?B?MHdRa1lKbEpPY2pNMGpRdVoxb3lCdHdqcDdCaFFrV09GcXdxSmNwVTQ2VWVq?=
 =?utf-8?B?SS9IU3RMS3BnZnEvQnI4UGtkdFlwdnFQNVUvMFptNDJvazZSL3djdmo5UTFC?=
 =?utf-8?B?WWRWTEhMWWtJQ3M4RFlnWFRZSFEwRkRPZlMxUGEzSU9hSFViQjRGR3FUc1Fh?=
 =?utf-8?B?N2kvM3NZeDd3ZTRwWlhIVVNtT0FLYnloYkUxVkhjU2ZwSFNJc0QvdVpYZ1VJ?=
 =?utf-8?B?SU1OOFd4dkRnOWF2S0VRQzdtL0hIS3NadzNsV3BQN2NsV0tjUTRRcUJQZ1Ba?=
 =?utf-8?B?dXpxbnBYZUdEcEc4bHRSQU9hblhvRVFTdUh0MVNHbGZUQStJNVhwYmtiVU9Y?=
 =?utf-8?B?dkYyZ29rdXoyV0hmM1VkV0syaGtqS1E0OWFVVTFqTy95OXRra3A1UkRJelZD?=
 =?utf-8?B?bnJMR1kwNGRJMG9BS2c0WTR0Yno3cnRBZDNhOCtEK1ZjTXZ2dWFqL01QMW9F?=
 =?utf-8?B?TXZRZG5maGFUSVlIakY3S2RHckZJUDdseVE1bWFiZS9GRGdzTHhNSk1YVUpq?=
 =?utf-8?B?V0hGZk1OeGE3djRMWFBpcGM3UXNhMGh5TlJrZWgxdFNWazRNWEc0c0dQZUhW?=
 =?utf-8?B?Myt4b256YlVmOC9mZzl5b2VvNFRkUlBlUVlraVlTdDQxc0xCbzdGZ1diYlJw?=
 =?utf-8?B?TlhJQjdsc3VPWmthejZtaTh2L2J6TG1XV2VvYm9EdC9qU1VTZVdBaUpCcVB3?=
 =?utf-8?B?cmQwdDl5bWxWZGtOMjlpcjJ3eDQzb3FyTmVuYjVNMURQTWl3azBzREtIUXpn?=
 =?utf-8?B?Nm9YNFM4Mmd0ZnBSWjZ0VlVSY01YMG95a1dnTFFWYVFzTlFaZ3c4aE1yUERF?=
 =?utf-8?B?SnE3SVlUSWVzRzFyRlFzb1dRc1FNaStMY0tXNU9tSWhwNnVjK1RpNFFkR1Ux?=
 =?utf-8?B?aVl6a3lJb0JxQ1VwNmlwQjFLcDlWZ2lLek9aakFiT2pqazVhNlVHVVFDd01H?=
 =?utf-8?B?ZnNCVFBOVXBuK1p3SnBPWXJzaUJkS1FrTEQ0UDVvL0xQb1JTdGttelN3VDl0?=
 =?utf-8?B?bWxXdUhUQUtmWEhZT3hlRndJTUlMWm16Vy9hV0tVSG8zS0E0YzlFN0ZsY1Zv?=
 =?utf-8?B?RTJpRTZyVXY2U1pCRWZjL2xTR3pGVlFpalUrMnJuK2hHQWpmOG1TRExHSUQ4?=
 =?utf-8?B?alBzYzAvZmZVU0JDYnhVNHVrbkhBMVRVRy9LRUJBdzRITjlYc3pXdy9ucDV1?=
 =?utf-8?B?cHc1YnlqbkJYR05vYUZSbHl6Zk1HbkxZcVI2TnJJaXhaNmtNazA0a2tock91?=
 =?utf-8?B?Y0cycDhJaFN3RkV1Y3VxalhFamtoT3ZzS2NrVjh3RXZiU0svcS9RU0FsZDh1?=
 =?utf-8?B?NERjdVFxOVRNZ2JkN2VUUitQMjdrRk1UZ0pwcmxndmZlNWhpNFliV1oxZjV2?=
 =?utf-8?B?bDRXWHZHLzA4bVdVL3BtOGpnU051eWNhaWRjbEFDWU1wNDJsY0hqRExYQW44?=
 =?utf-8?B?cTJCMlFVRUpRb1FSa0ZjMUNET0IwNVE1WlpQZURGanh0N3dKeHhaWWFzcmVK?=
 =?utf-8?B?QzgxSlpQWGlCNk9qUExRY2xqNjdJSEM3RWJ1ejhRRlE3cXhUdTdVano3N1Ex?=
 =?utf-8?B?Y3J5UDhrOHcyMDhQakxPVHZjSEFLemtHYWtmS2wrcjdXcXY1YXBaWkVCUi9w?=
 =?utf-8?B?NjdaaFp5VzhqMzN6YkdQbkxyS1NCUW9abXZ3VnFZamdnOGNLdzdZNXJva1F4?=
 =?utf-8?B?U3k0Mmg2b05zSndFbGU1eCtVdCtZODdMeCtsMHNjS2l5THQ3TFFhckdzOTYv?=
 =?utf-8?B?NVBNRG5yWTJGNm4rb3lObXNqaHZZTGJ5NXp0eFRDb1BNSWxTRU5zTFVUYWpU?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OKMI/ewxblU2XahfsV2bpN3Arq3Q/1uXOeQCY8qXNVyBPmnEzvHuHzx2zsXk1/Igu6Fc+Axhf8GjMjgDcZGbKvbv/5C+PJ8JSezrPHCBD8HFAjSymy2nttqqP93ireRyRy7nt3oPCBRLZhVCoLcpllqO2qXBmcRcDEbp6W+k7u9xJVLwFtlZa5heXo1LQGB40ddFcEn2rZ8efQFJgGYKi5rgyk1wMgKCpIQQUM59c7cXl94q0H7dd5Bn5XXApn8EwIukF6P+yj4q5pzt3Ez6mjiy3kZ31Bwo4F57ihtlim9roI1Suvs4jl+r+TymgVmUTbg29xsPVkpGRjxats1MdyRS6269u3lDegLFyNvuNLs558uso4xsu4RAEi1c6cILt3PtA4hvYm9fIdd5wogfyraAmFn5IWx81Uh/PIl12CD+KWs7dPnmtEQ/Oj+GXUHP1+VfJdS0RCKwpjarb8M4yvjV0RDETY3q/shmt+Aje8IdWfKZG8umAT1N6nO8OY4ANQRuf0AUsCVKvUrgwmN07quTmxo0qI9TxQoRfTkhPg4DSMMGbEKMUFgOKQ0bXrg5orzdWg3/VdYcQ9+jqLlaHKBSdhX7rL1Tgj0z3cu3Qfd7YRx9Wfra9jT5r4vX7SO7g++TEcoIqTRE77PMxPrko4iuYFZ9oevNdRTQpfXnusgHiDwakaZQ3DPFGUNy22oUKu2O9vVOHnPKGi/pSbdTN/hnpbY79AcxcD7Yqi38IyEaS+jj5imuNUk1GFms3sRC4uJSuyguf/GfQyqlKl4R1CtlV2+NczGWj1R1wWNtMa9NCE6b7U6LSteGCO3FxwRF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd55e48-a8c7-4756-6bf4-08db90b90e1a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 04:54:28.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+g++CQYSJGReCymPEMYCb2B9bGRnxRa8h+dc6yY4b6PX9oKqY4vPNr6slFiHjw8BsAToO0yo8pOQrPuKp+IER7DQnvjnmeu8heRbZ3/Ut4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307300045
X-Proofpoint-ORIG-GUID: cEryppNfBV6s38Rl-11Xq33uEEDowEdr
X-Proofpoint-GUID: cEryppNfBV6s38Rl-11Xq33uEEDowEdr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Sat, Jul 29, 2023 at 1:29=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Fri, Jul 28, 2023 at 11:01=E2=80=AFAM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >>
>> >>
>> >> >> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
>> >> >>> Hello.
>> >> >>> Just a heads up regarding the new BPF V4 instructions and their
>> >> >>> support
>> >> >>> in the GNU Toolchain.
>> >> >>> V4 sdiv/smod instructions
>> >> >>>    Binutils has been updated to use the V4 encoding of these
>> >> >>>    instructions, which used to be part of the xbpf testing dialec=
t used
>> >> >>>    in GCC.  GCC generates these instructions for signed division =
when
>> >> >>>    -mcpu=3Dv4 or higher.
>> >> >>> V4 sign-extending register move instructions
>> >> >>> V4 signed load instructions
>> >> >>> V4 byte swap instructions
>> >> >>>    Supported in assembler, disassembler and linker.  GCC generate=
s
>> >> >>> these
>> >> >>>    instructions when -mcpu=3Dv4 or higher.
>> >> >>> V4 32-bit unconditional jump instruction
>> >> >>>    Supported in assembler and disassembler.  GCC doesn't generate
>> >> >>> that
>> >> >>>    instruction.
>> >> >>>    However, the assembler has been expanded in order to perform t=
he
>> >> >>>    following relaxations when the disp16 field of a jump instruct=
ion is
>> >> >>>    known at assembly time, and is overflown, unless -mno-relax is
>> >> >>>    specified:
>> >> >>>      JA disp16  -> JAL disp32
>> >> >>>      Jxx disp16 -> Jxx +1; JA +1; JAL disp32
>> >> >>>    Where Jxx is one of the conditional jump instructions such as
>> >> >>> jeq,
>> >> >>>    jlt, etc.
>> >> >>
>> >> >> Sounds great. The above 'JA/Jxx disp16' transformation matches
>> >> >> what llvm did as well.
>> >> >
>> >> > Not by chance ;)
>> >> >
>> >> > Now what is pending in binutils is to relax these jumps in the link=
er as
>> >> > well.  But it is very low priority, compared to get these kernel
>> >> > selftests building and running.  So it will happen, but probably no=
t
>> >> > anytime soon.
>> >>
>> >> By the way, for doing things like that (further object transformation=
s
>> >> by linkers and the like) we will need to have the ELF files annotated
>> >> with:
>> >>
>> >> - The BPF cpu version the object was compiled for: v1, v2, v3, v4, an=
d
>> >>
>> >> - Individual flags specifying the BPF cpu capabilities (alu32, bswap,
>> >>   jmp32, etc) required/expected by the code in the object.
>> >>
>> >> Note it is interesting to being able to denote both, for flexibility.
>> >>
>> >> There are 32 bits available for machine-specific flags in e_flags, wh=
ich
>> >> are commonly used for this purpose by other arches.  For BPF I would
>> >> suggest something like:
>> >>
>> >> #define EF_BPF_ALU32  0x00000001
>> >> #define EF_BPF_JMP32  0x00000002
>> >> #define EF_BPF_BSWAP  0x00000004
>> >> #define EF_BPF_SDIV   0x00000008
>> >> #define EF_BPF_CPUVER 0x00FF0000
>> >
>> > Interesting idea. I don't mind, but what are we going to do with this =
info?
>> > I cannot think of anything useful libbpf could do with it.
>> > For other archs such flags make sense, since disasm of everything
>> > to discover properties is hard. For BPF we will parse all insns anyway=
,
>> > so additional info in ELF doesn't give any additional insight.
>>
>> I mainly had link-time relaxation in mind.  The linker needs to know
>> what instructions are available (JMP32 or not) in order to decide what
>> to relax, and to what.
>
> But the assembler has little choice when the jump target is >16bits.
> It can use jmp32 or error.

When the assembler sees a jump instruction:

   goto EXPR

there are several possibilities:

1. EXPR consists on a literal number like 1, -10 or 0xff, or an
   expression that can be resolved during the first assembler pass (like
   8 * 64).  The numerical result is interpreted as number of 64-bit
   words minus one.  In this case, the assembler can immediately decide
   whether the operand is >16 bits, relaxing to the jmp32 jump if cpu >=3D
   v4 and unless -mno-relax is passed in the command line.

2. EXPR is a symbolic expression involving a symbol that can be resolved
   during the second assembler pass.  For example, `foo + 10'.  In this
   case, there are two possibilities:

   2.1. The symbol is an absolute symbol.  In this case the value is
        interpreted as-such and no conversion is done by the assembler.
        So if for example the user invokes the assembler passing
        `--defsym foo=3D10', the assembled instruction is `ja 20'.

   2.2. The symbol is a PC-relative or section-relative symbol.  In this
        case the value is interpreted as a byte offset (the assembler
        takes care to transform offsets relative to the current section
        into PC-relative offsets whenever necessary).  This is the case
        of labels.  For these symbols, the BPF assembler converts the
        value from bytes to number of 64-bit words minus one.  So for
        example for `ja done' where `done' has the value 256 bytes, the
        assembled instruction is `ja 31'.

3. EXPR is a symbolic expression involving a symbol that cannot be
   resolved during the second assembler pass.  In this case, a
   relocation for the 16-bit immediate field in the instruction is
   generated in the assembled object.  There is no R_BPF_64_16
   relocation defined by BPF as of yet, so we are using
   R_BPF_GNU_64_16=3D256, which as we agreed uses a high relocation number
   to avoid collisions.  Since gas is a standalone assembler, it seems
   sensible to emit a relocation rather than erroing out in these
   situations.  ld knows how to handle these relocs when linking BPF
   objects together.

> I guess you're proposing to encode this e_flags in the text of asm ?
> Special asm directive that will force asm to error or use jmp32?

GAS uses command-line options for that.

When GCC is invoked with -mcpu=3Dv3, for example, it passes the
corresponding option to the assembler so it expects a BPF V3 assembly
program. In that scenario, if the user does a jump to an address that is
>16bit in an inline asm, the assembler will error out,
because relaxing to jmp32 is not a possibility in V3.  Ditto for
compiler options like -msdiv or -mjmp32, that both clang and GCC
support.

I don't know how clang configures its integrated assembler... I guess by
calling some function.  But it is the same principle: if you tell clang
to generate v3 bpf and you include a header that uses a v4 instruction
(or overflown jump that would require relaxation) in inline asm, you
want an error.

>> Also as you mention the disassembler can look in the object to determine
>> which instructions shall be recognized and with insructions shall be
>> reported as <unknown>.  Right now it is necessary to pass an explicit
>> option to the assembler, and the default is v4.
>
> Disambiguating between unknown and exact insn kinda makes sense for disas=
m.
> For assembler it's kinda weird. If text says 'sdiv' the asm should emit
> binary code for it regardless of asm directive.

Unless configured to not do so?  See above.

> It seems e_flags can only be emitted by assembler.
> Like if it needs to use jmp32 it will add EF_BPF_JMP32.

Yep.

> Still feels that we can live without these flags, but not a bad
> addition.

The individual flags... I am not sure, other arches have them, but maybe
having them in BPF doesn't make much sense and it is not worth the extra
complication and wasted bits in e_flags.  How realistic is to expect
that some kernel may support a particular version of the BPF ISA, and
also have support for some particular instruction from a later ISA as
the result of a backport or something?  Not for me to judge... I was
already bitten by my utter ignorance on kernel business when I added
that silly useless -mkernel=3DVERSION option to GCC 8-)

What I am pretty sure is that we will need something like EF_BPF_CPUVER
if we are ever gonna support relaxation in any linker external to
libbpf, and also to detect (and error/warn) when several objects with
different BPF versions are linked together.

> As far as flag names, let's use EF_ prefix. I think it's more canonical.
> And single 0xF is probably enough for cpu ver.

Agreed.

