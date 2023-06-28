Return-Path: <bpf+bounces-3613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B774075E
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1F91C20ABD
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3581114;
	Wed, 28 Jun 2023 01:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BFC7E2;
	Wed, 28 Jun 2023 01:00:22 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F117296D;
	Tue, 27 Jun 2023 18:00:20 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RHR5lZ012184;
	Tue, 27 Jun 2023 17:59:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=uzExz+6v6IztWRhCPaeT7PVheYSPMoky+m28xvz5Xv4=;
 b=AY+h3v2BZNXpsljx7I45AwQmNquuvf6XPK6mlJHSY1LrNY2I53ollulwRvN5XRSR5h9s
 VCrPWNF1YHXqDt8fuJzsdIItqSp3GiXGJYN08mNRHVcNkBHxZ6ssqSKRIuL08D/OAmwd
 4ka7Wv/t47QCEMNm2SkJJQGGbbshVdhk8yED9NznFyF3elPlxQYRj7+VzkPCdKNk369B
 1ygLFOIxPeQV3jkKmkNdYtzLUjOsn4fYRbPQswsw20taBDwZRpGDg+V/3CpnI2lKDvXr
 filSoTMVbInquWfKa2sZ9TZo0b+vMcnMSCDK6BClu2BFqT9Bu1TKb1UGICsP7q0phnC7 0w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfvqjq39s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jun 2023 17:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1EM8S5VDqtqRzZkXep2lSv0OsspF4D0TvG2+d6vGn8AVNhqLOQG6grMq5NtBiMuW7lRZOQefxiH+PjEQrvMkAmPMFro1MurjDlb5jLUCPAMsgIIDUQLB2ATkorxXBp17TwRcXExOQ7bg5cHqtqOza+phzWF8aAHKFPyI45pMaxWwaEd37i67XPsgcjLDqp2bX/nj+bhXTfZayOT+qZgl7CnJuDOUxiJyJYTxu+pMIBVnRtGH0fcA1LCScY5I55aEWQYZ38OI04Lz11dlpU3uBXfhw1bI/+S6WyUq6OLe+U8vqpMxJe5+DdXK+U7LezuSC0uRR/8ukJ19fSqlspW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzExz+6v6IztWRhCPaeT7PVheYSPMoky+m28xvz5Xv4=;
 b=Txp2CRGqrvpVgOssWJ+9MF/dHKuwJCOJwBxpG4igFyN4fybmvYNyxWRJX0QEKoq3HjumjOBPkSe+Qd1paIdjHUbOZNxOGOX5DHgwxuU2MuVsS8SlCGiCGqKtSuR8Iw0sItJ4jeSkFp3oXY6hbKbaokNlTD2x/3Qrd5+av6WARwVzLg2UoLMOXVHqGwrA6Kir7jdiHouUT9h9YRRMNlA+vCMs86upF0fBSHdgtmjUx7TPUoDz4jYQ3F9Dk0nDkruqyeepS1V8msztcwMrzOoK99fTXK37uVc3yAE0XoGEMjpqnj1mE/0rRIwRJ7kzjP7wiLAgUlBzzCvkqNIxVSCxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4902.namprd15.prod.outlook.com (2603:10b6:806:1d1::12)
 by SA1PR15MB5800.namprd15.prod.outlook.com (2603:10b6:806:337::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 00:59:57 +0000
Received: from SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6]) by SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 00:59:56 +0000
Message-ID: <2bf11b56-7494-c0a9-09d4-c9e41aaba850@meta.com>
Date: Tue, 27 Jun 2023 17:59:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-10-alexei.starovoitov@gmail.com>
 <9cc35513-5522-9229-469b-7d691c9790e1@huaweicloud.com>
 <CAADnVQJViJh47Cze186XCS0_jeQMb1wu6BfVZiQL6982a_hhfg@mail.gmail.com>
 <417e4d9c-7b69-0b9a-07e3-9af4b3b3299f@huaweicloud.com>
From: Alexei Starovoitov <ast@meta.com>
In-Reply-To: <417e4d9c-7b69-0b9a-07e3-9af4b3b3299f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To SA1PR15MB4902.namprd15.prod.outlook.com
 (2603:10b6:806:1d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4902:EE_|SA1PR15MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e737c8-b36e-4e44-a429-08db7772fd8d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Tx7QwJ/VxPyHxRhKlFNCOaEwtxc1gFClivzq2+CYZJLr3XItNXbU4AvgRA+9ZmVEs1Dh6tdjqCs9uDH40bNUejxdPhLilcwQ3ZXbGjFBhDy+a9GCfXHoL31CIzioF+0u97hb0Ppz003vZVJL9pPFBzv5XqemHLz0LgwckqlEsM0cP73/rJrfQC08ugXxTCssAegOi/vB/lYJUTsscMLZTssV3LVmQEav6FmS9k7h6VjUTc/T1SYZcqAOfU40zKrDWpu9dFEH2/TOih0GC2LOgcKe9tvjaDvLPOSZxX1k2NmzUNE6Is2dI0ZyD34J+VoJ/rvCYAL6xCVT3dPVV0en4SqWfIl1LOpRQpNZqVfWXBVUQstPB9GvSuWOj0lIiPb1aVrOihjBxwukpkkmrn/JVlwNnEgCcn3lIkWL/U+vhTSUd3sYvnAFM151+pBV3ceRDS7EG1YrVn0sLQqV2eWABHIZjuIkcrEl4eKYWwKtMoZnqRLlSVyngo681veYRfKcI5kMMB4puv9RCt+lYgKwkQzcpsEVS7njmEr8ji82987hUFYL2YwfEh6nhTlYt3dnH2DMTuPLs5YIvFC6ZBsFUxt6QTWlOMn2xXqj1/2RI6dtUrahNwVQnbuEC40dBQf1547JUvmZi7DjJ/H0pHw1xQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4902.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(2906002)(186003)(6486002)(38100700002)(83380400001)(2616005)(6506007)(6512007)(53546011)(86362001)(110136005)(31696002)(41300700001)(54906003)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(66476007)(7416002)(5660300002)(31686004)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RWRDYVlFaHlpN2QraTdUZjlmMHpieGZ4bDhXWkJ0U2dsRGJFZkhjVGlxSk0r?=
 =?utf-8?B?dk15SG56UERVM2k2ckxpckR2LzFBbS9TbjBwV3k2Z0RYVGN5MjM2TDJabHlY?=
 =?utf-8?B?WURXcThNWjhyTUdqL1lhbEtLNXJYVEg0ZlAvMTY5K0tQcFV2SU1TVjUxSk9n?=
 =?utf-8?B?Qkx5ckprdENFT2tKclhaaHBrZzdpamF4d0tmVGVmV0FxdlF4eExqdFpkZWNv?=
 =?utf-8?B?dVRFSEN2SlJ2MTlaVEJqWDFBMWcwQlowdWs3TDhuZlJTemJEdy96Ujg0a0xm?=
 =?utf-8?B?LzVpQllBcUtNSjlRTVJ3aHV2MWgxSmljOGRzakNjeFo5UTBnNDIrMXBBMHpq?=
 =?utf-8?B?d3ZCaWtZUGdYVkpkWUZkbnQ5NVM3YXBNT29IbW8xZGZwbWJpN1hPVVJyMTYw?=
 =?utf-8?B?UmJxeUNjeWVySDdxeUNEQTZJNlk4RWNxNkxVd0IvYS9jb3lmTUJQY25ZSjJR?=
 =?utf-8?B?b2ZLWEdvbm03OHJ0QWVrMko4dysra2h6b3MrQ3piM3dCdDFRZkh3WFZLVkxG?=
 =?utf-8?B?V1FCUzd0QjVQNlozZWx1U1dPckVoZEFYQ29PN2lTY1E1RTltMy83UGRjQThx?=
 =?utf-8?B?Slk0WGRnaVNCMDFFc0N2ek9hdHF2V0p6K1ByY1VHajFKRkZKY3BpbWNVMXZ2?=
 =?utf-8?B?dkpLdG9oamVYcDVURjZZRHVKTXBLUlVJTm00MlNkc3hlaUpiUy96UXRpdXlW?=
 =?utf-8?B?MnFJRjVqV1VVNCsvS1YxbnhSaVBWV0xjQUNLMU5DckpzVjhSZ3lTNFVwRnk0?=
 =?utf-8?B?M0xtVjBXVVRrQVk0ZzFETUI4SWZnMDFBbllXTHBOeGczL3ZnZ0xNUnZEbnpO?=
 =?utf-8?B?TmpndnRMaU9YMnI4YlZOZDdVdGFWV3NVNkJJSksvZVNZQXR3ZEpNWDBXNWVx?=
 =?utf-8?B?dXFkNk1BRVhpSm4xV1lpeEYxdklxYmJNTFNOa2E5eWpFOGhEczNVcDRaNUx6?=
 =?utf-8?B?R1gxaXpYVVI4aysxVnNlZzRkZm9wanNkMzh0OURiOVZqREszVjE0UXVCY2NY?=
 =?utf-8?B?bUZyUWZoeHJWYXNucUx5dGRIL1hVcXNSazBJTWRURFNMbG5sSExXYlUvN3FF?=
 =?utf-8?B?emJCV0l3QmpLSnlDOUQ0c0NHYmZjZmVmNkl2a0ZGMEVPdThCZzVKSEdxL2h6?=
 =?utf-8?B?RGY2cUxwd1RiQkRWME9XaGtoeVN2eXFGS1dlWEt3UUVsZTJ6QVoxaXJ2dHBl?=
 =?utf-8?B?aFBVTndMR3ExOWduWlRsbSswSXluektvRWpwb0oyMXBiN21uVDBjOGsrdC9q?=
 =?utf-8?B?anh5SmdhWHFqdTJxMkN3WlViN1RVMm9PQnNsam9pUEcwQ08xRU1SMTBieW92?=
 =?utf-8?B?NDJQWTlSc0JIbCtkTlJxMENSU09RTGk3MzdxWFdPVHpudVpidzlQR2w3cWdv?=
 =?utf-8?B?QUR5WHZIYjBkcnhNb1cyNkN6TndPTUVIMXdCS2hmSlFpT2pKNGFQZ2t2UXM2?=
 =?utf-8?B?bmhWM3RIT0RDRVg2c2FOczQrUzNHeGY1WUVQdC85ekJoYi9rd2J2QWxjOTZE?=
 =?utf-8?B?eGtjY3Awb1MrdVVoc3ZqeEhpMEZjc2NhNDN4RzR3aWVkYU9XNjFCMzF3enZn?=
 =?utf-8?B?WU8ycDcrVmNDdlIzZkY3cWJ3WnpWSlVaNFUwbTRKVXBnczFWWFRIRnMwSjBa?=
 =?utf-8?B?M1ZzMDB3aVlUNHFDV1A1Z0RoK1VpNTFBOTNvWFpmVFc4WXJ2b08xR0ZINStj?=
 =?utf-8?B?YlZwNWxKRzM5c1VQcitNZGxqWTdIVGZBRTNXWXB4UUJ4ODVYUzhrYXFaMUox?=
 =?utf-8?B?OElIN0FsRlEyeHZCRlJSdmtzeFlLRlZlMktRSGZMRHhHcERVaVZMRDFITHht?=
 =?utf-8?B?S3VHUGppZFVGcEZmTjN4VmI4UmJISjUxVDk3TkFhWEQzTWR5c1RWNklsV3hJ?=
 =?utf-8?B?QmRLOUVZWFRQa1NCckI5cWkwdWo2WmJDK2N1R2p5U1VwZThmSElVaUxLZW9p?=
 =?utf-8?B?cTl1ZzJUNCsyb3RHb2V4b0RZbXg2aEpKcFJCYjRnVWpNUzFDd0JZUmpkTjd3?=
 =?utf-8?B?Ui9rUVRJa1RZYWhicmd6NzViWmw4QTEzYzhxS1hrU0w1YXR2K3pXeE9PVHly?=
 =?utf-8?B?elpzeTZCQkl3eE1VOUFiNWtCTUFJQkFBS2JMQmxUR3Z5RnBuTVRaR3NZaC8z?=
 =?utf-8?B?OVgrU1BpLzdlcEJyTnVUajRqWWRDSTZVd3N0azMxT1JvNXFpckRTMjhKQStr?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e737c8-b36e-4e44-a429-08db7772fd8d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4902.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 00:59:56.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHpwR61XxMK6Xu9bWgIxQaK9AorV+rvyNCFFdoT7pFC1vhrQk0vJfuhWqYLOtkdz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5800
X-Proofpoint-ORIG-GUID: i5bkYN0uZn7BlpLkEGejzWEhMA3x52aB
X-Proofpoint-GUID: i5bkYN0uZn7BlpLkEGejzWEhMA3x52aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/26/23 12:16 AM, Hou Tao wrote:
> Hi,
> 
> On 6/26/2023 12:42 PM, Alexei Starovoitov wrote:
>> On Sun, Jun 25, 2023 at 8:30 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>
>>>> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
>>>> Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().
>>>>
>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>>> ---
>>>>   kernel/bpf/memalloc.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>>> index 692a9a30c1dc..666917c16e87 100644
>>>> --- a/kernel/bpf/memalloc.c
>>>> +++ b/kernel/bpf/memalloc.c
>>>> @@ -203,6 +203,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>>>>        if (i >= cnt)
>>>>                return;
>>>>
>>>> +     for (; i < cnt; i++) {
>>>> +             obj = llist_del_first(&c->waiting_for_gp_ttrace);
>>> After allowing to reuse elements from waiting_for_gp_ttrace, there may
>>> be concurrent llist_del_first() and llist_del_all() as shown below and
>>> llist_del_first() is not safe because the elements freed from free_rcu()
>>> could be reused immediately and head->first may be added back to
>>> c0->waiting_for_gp_ttrace by other process.
>>>
>>> // c0
>>> alloc_bulk()
>>>      llist_del_first(&c->waiting_for_gp_ttrace)
>>>
>>> // c1->tgt = c0
>>> free_rcu()
>>>      llist_del_all(&c->waiting_for_gp_ttrace)
>> I'm still thinking about how to fix the other issues you've reported,
>> but this one, I believe, is fine.
>> Are you basing 'not safe' on a comment?
>> Why xchg(&head->first, NULL); on one cpu and
>> try_cmpxchg(&head->first, &entry, next);
>> is unsafe?
> No, I didn't reason it only based on the comment in llist.h. The reason
> I though it was not safe because llist_del_first() may have ABA problem
> as pointed by you early, because after __free_rcu(), the elements on
> waiting_for_gp_ttrace would be available immediately and
> waiting_for_gp_ttrace->first may be reused and then added back to
> waiting_for_gp_ttrace->first again as shown below.
> 
> // c0->waiting_for_gp_ttrace
> A -> B -> C -> nil
>   
> P1:
> alloc_bulk(c0)
>      llist_del_first(&c0->waiting_for_gp_ttrace)
>          entry = A
>          next = B
>   
>      P2: __free_rcu
>          // A/B/C is freed back to slab
>          // c0->waiting_for_gp_ttrace->first = NULL
>          free_all(llist_del_all(c0))
>   
>      P3: alloc_bulk(c1)
>          // got A
>          __kmalloc()
>   
>      // free A (from c1), ..., last free X (allocated from c0)
>      P3: unit_free(c1)
>          // the last freed element X is from c0
>          c1->tgt = c0
>          c1->free_llist->first -> X -> Y -> ... -> A
>      P3: free_bulk(c1)
>          enque_to_free(c0)
>              c0->free_by_rcu_ttrace->first -> A -> ... -> Y -> X
>          __llist_add_batch(c0->waiting_for_gp_ttrace)
>              c0->waiting_for_gp_ttrace = A -> ... -> Y -> X

In theory that's possible, but for this to happen one cpu needs
to be thousand times slower than all others and since there is no
preemption in llist_del_first I don't think we need to worry about it.
Also with removal of _tail optimization the above 
llist_add_batch(waiting_for_gp_ttrace)
will become a loop, so reused element will be at the very end
instead of top, so one cpu to million times slower which is not realistic.

> P1:
>      // A is added back as first again
>      // but llist_del_first() didn't know
>      try_cmpxhg(&c0->waiting_for_gp_ttrace->first, A, B)
>      // c0->waiting_for_gp_trrace is corrupted
>      c0->waiting_for_gp_ttrace->first = B
> 


