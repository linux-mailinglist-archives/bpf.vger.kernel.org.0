Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4740480E01
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 00:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhL1X63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Dec 2021 18:58:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3262 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231940AbhL1X62 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Dec 2021 18:58:28 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BSBAkqD027323;
        Tue, 28 Dec 2021 15:58:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gfftGimDjc1rqwROajMN2S3eRJw3vcgm1Lw4Su5d9fw=;
 b=fBj7lB/uGNA24DLeUJ4se3gY3o1qu4UdsxIXdaB9H7Ie6i4186ZPcCzHx2BAB2jEXP8v
 uWgU+hYcL5tf0WjPawT1xz8TGoV2zM1NulOPvyf1QuEoEh1fruSLRAWoELy131Dzqx3l
 ulrmAPCfO1hszt4oxvpPZQpVb2V97PzmeZw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d7g5tq5tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Dec 2021 15:58:14 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 15:58:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDI1Up3MQdVhsz7lbfWejNoqJz/GE8hakQJkROAv0ftdENCdo2A4gRKVsJjR2NKXjIKVzHK7hvLyPHraV3A9DPcuEYOL/B/aMfnsIqgATpndEkpKzEodGfGdGHfLP4kG7/eAofdIX0MtrEd2wJ5fJgYnsG9f5wz7FyLxGgZTghqUmcuj/7/7EVpk7JlHnRImk/Bq8Bc/vipiUmoRdx7ti/a/zzO1zTJDGNDU/8SYNZEgw8v7VOgIjso+2PtubuPFbC0h2iBuome1XjemOpdqFO9RxFY83DIjm1TVldCNQAnMlI8ZYQlnKZBA2++miKPeukk2eK93ET6UayaV/eyM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfftGimDjc1rqwROajMN2S3eRJw3vcgm1Lw4Su5d9fw=;
 b=N1XV4T5C3N0e9Ww/mGbP+9Qzn8+lM9yIPcJOi7uvUORZvrsTuH+zKh7q3fiLpyQOOt5ZHvqYt0phzcf0No+N9WpSwr92neYTcjim2f/vw4P5Z01Ex3pEk89L3F54EpPSvKz2zQoUJZd70SsDEIaC/AFaPWS274MoURNpqverp2oS3C07WalObI3sEjXVelhNEC8xDTJMIfhCXoka4/v1xnx7x4JGsp2HqUiJzu19qFW7mWCZ6kbB9fRw7rHCgEgY0GazrPmYQhtz1AwTsL//2LP/aBD9fgjW1OqxvGM7nkg4lA1szmrJaDUNGJerrJUL0wPu2nzuPjh1T//2mQq4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3885.namprd15.prod.outlook.com (2603:10b6:806:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Tue, 28 Dec
 2021 23:58:10 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%8]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 23:58:09 +0000
Date:   Tue, 28 Dec 2021 15:58:05 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Allow bpf_local_storage to be used
 by sleepable programs
Message-ID: <20211228235805.tmr6gc3aykbyuvwz@kafai-mbp.dhcp.thefacebook.com>
References: <20211224152916.1550677-1-kpsingh@kernel.org>
 <20211224152916.1550677-2-kpsingh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211224152916.1550677-2-kpsingh@kernel.org>
X-ClientProxiedBy: MWHPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:300:117::34) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b44ae4d6-6cc8-49a6-1e84-08d9ca5de67d
X-MS-TrafficTypeDiagnostic: SA0PR15MB3885:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB3885D21815567DC5C680D775D5439@SA0PR15MB3885.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26v/QtWE2EoVX+3m/D40Pmgv8USsrtwm3p2w+UoZHDe822MIE5nRquZvh+B/+Mi+gKURFbIiprFnm36oHhxAImgCxIT8WuVTVF8tNfCVqUaCH9NhQ4jY/Z73EjH6xllZHJvA88lQWL5cBYGJxz/zfGwp6XYtsba9HDbCFaiCBNzfsKZukOi2tgKuD/pLx7VIHALfT1+uAJPO3oS0GKomkzwJxwlMlDHSGwLHCWtiRrNTkNcNM3WJGjZkOA1px2ArrZMyfIMlOmAFU2b26XaUhSQIoudH2M/mBoTh8X8bfswnp4EtreKGgqvz/yWNF5nl01FKRdQ6y16iwm3YLgnTYJbVEZWs5cBwlwDshiSzR51VdmMtwtUk3QkGmrFwFU7zTHh33o2/L+f6g0s4KSMxoDos4sjN1eX2v1dKYUCEtZpHFsfi1e9DOqL5Qb2yO2l7N36XJupXH+tPbm/hdeEIX6VGzQ7GEMjlYEdzTb2uUJfWhDonrNP+y/dFZ/817OIbpF0m1Us5qbu+4jGEPovMjoGyELx+B5YmO4H6XgYGV9cpZr7ycTEbpdvGtl2hwQLIqbzDdjp4j3VAMnGQ8schKu8oqh53gMbFajNsFBvQYLXR/wN3nzdOUjl8dFWFVuTuEUzVSw2vBKuEwQKn7NMDTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(316002)(186003)(86362001)(54906003)(38100700002)(8676002)(508600001)(4326008)(8936002)(6506007)(5660300002)(6916009)(52116002)(2906002)(66946007)(6486002)(6666004)(9686003)(6512007)(66556008)(66476007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gOAP4p+idarEa/XzAQr25p7ymHjn4/kLEOc+nPwMom3GeqKs8DyN9Ak6ohi?=
 =?us-ascii?Q?6RwyZI1Ia6NcBKa5lCiuF2aoHKUPQy6bZ089I5DElqCMAj30KxRFB8+jAnlp?=
 =?us-ascii?Q?MZqY1g5E4EZbdhZGtXxshSlyUgbqLxBU9lcl58YiIdBVLTgCpqK+v/ovxKTq?=
 =?us-ascii?Q?m9FRMQ3p/Pr8vWNyCKXqULFHNTJIMVy/fNtXgqOp35D7Eqpn3qpNMClTdrBw?=
 =?us-ascii?Q?SpLz7plAFPllBMZ4D6sq9oQuGk6w0qVLmJfgJ8er+T8oQ18FuueK4A5TR+kT?=
 =?us-ascii?Q?5yEVqtTJ26sDokY4yopFsgLDKHRELl4FSQnPM3Bi2zMUPOwnhK53hykr1JYM?=
 =?us-ascii?Q?IegSnxaf9/O7blmZ/lcyCrjuttldUzV9ECrr9gWY+JQMQlZ+euUA+FqGloeB?=
 =?us-ascii?Q?09ik/Zf57YVCTu2N/5eVRNCraWuuoO5LpceBNfwF8YsglQ1WYj5EoK/8I5zm?=
 =?us-ascii?Q?h1Zvu6xGJgwKSC81eB63oa25vegUQZ7+9J96xWR83XN2yTX1y2RnZ03IMEVr?=
 =?us-ascii?Q?/Fx4nEP33n7t/zLmQ0UopbiTH4YDtOP7p0pFzTYS4Wg0h8HX4RPN4VBcjflE?=
 =?us-ascii?Q?85isJLEacqkQ3y9oGjn1llfXW7g/oZSBQuS07LhakEJHNcVrxTKZx60swqBj?=
 =?us-ascii?Q?ACGpqSHNt3IwHJHElzS3Myx6MGnVkwrvcmT+MaCCF4HiacBt1eK80dSz43+9?=
 =?us-ascii?Q?DihDUaB5g5W/2FWaRx58wpPWTj6T8yG8SRKcD1ePwGNfgss/djl3kYM7YpVG?=
 =?us-ascii?Q?44Q/ScwrbMfXNifzznJyTCN/IciYd2QABQz2LDEIgyZpqH+Vhzgjkwva41co?=
 =?us-ascii?Q?m6RC3p6c1hbjzJGq7ZNeu61dcdeAp72Z47GPZFTFRngzCzJ5rrA9ytKxWJ31?=
 =?us-ascii?Q?7Gu7Of+oTZ9AUSaA7GfD7gVVGlSWCNpm1xjhLdU9lHuf0BntWX52SqxTlEZp?=
 =?us-ascii?Q?AnqMaeS9aN/q2UxKI9BNgKTcV3ad4NCyrkm0zZ7xxZn3JeAqWJL+4eeRR2x9?=
 =?us-ascii?Q?tJnVZAacrR27z27gSstgCIOJuHBskLh09Hv4Eq4Jv29peOlwWoejcYFAzYVe?=
 =?us-ascii?Q?tJTszrnFCLWbOAubggY8845ssxrbc1oZj7QJPX8PTCsENGFwBPU42VkSXBmu?=
 =?us-ascii?Q?9p2DGxTlomaJKbn7SpJuryIBysHFY5bVC6AeQfVe46BGdVxQ9oDEVRsyRmOx?=
 =?us-ascii?Q?1k+C3lCrN1WBh2ySfFewS7pZzWhdBDClVxuqHhIKr6e1TWocSL3MNE2K5jR9?=
 =?us-ascii?Q?3t1FTX2q9HRKRxfVai7FJChejqOlbSHqZe5lPauqVu+qfvuxRYCmdSwHWPGP?=
 =?us-ascii?Q?2QTqEUtL/UYHziakgEWr049NMVovYlc/Vvi+w2blyw+tNIexekFq7Hztt+fG?=
 =?us-ascii?Q?w/5gdZ1cf3t0VNxFZ8ebK5rryPz9mf/Hq9i5vHOkJ64g6mJWQaL3u4UsS0i8?=
 =?us-ascii?Q?URY854vfIlJcTMZwZdZKnNuM1QV5l5Ndq555xigTHrY0QlJEahfzNjBkeoNT?=
 =?us-ascii?Q?vxxpaDqgXPFPQeVPsiJhCSW+n3RBu9hsUt1HSrWd7QLiFHMyCS66akrblucs?=
 =?us-ascii?Q?tlqE9hN5zAEF7fnWreH+gGzmQ1pFd/HHs2PP7w1W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b44ae4d6-6cc8-49a6-1e84-08d9ca5de67d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 23:58:09.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5bASJwM/xLclNnU1xwfRbmh5cICLkIsmiglAgxZQp8H/7ylWEXaFz0V2vysCq04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3885
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: a_gxFk0sVMAbIox3qIY87auAe8Jo9o-s
X-Proofpoint-ORIG-GUID: a_gxFk0sVMAbIox3qIY87auAe8Jo9o-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_13,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 24, 2021 at 03:29:15PM +0000, KP Singh wrote:
> Other maps like hashmaps are already available to sleepable programs.
> Sleepable BPF programs run under trace RCU. Allow task, sk and inode
> storage to be used from sleepable programs. This allows sleepable and
> non-sleepable programs to provide shareable annotations on kernel
> objects.
> 
> Sleepable programs run in trace RCU where as non-sleepable programs run
> in a normal RCU critical section i.e.  __bpf_prog_enter{_sleepable}
> and __bpf_prog_exit{_sleepable}) (rcu_read_lock or rcu_read_lock_trace).
> 
> In order to make the local storage maps accessible to both sleepable
> and non-sleepable programs, one needs to call both
> call_rcu_tasks_trace and call_rcu to wait for both trace and classical
> RCU grace periods to expire before freeing memory.
> 
> Paul's work on call_rcu_tasks_trace allows us to have per CPU queueing
> for call_rcu_tasks_trace. This behaviour can be achieved by setting
> rcupdate.rcu_task_enqueue_lim=<num_cpus> boot parameter.
> 
> In light of these new performance changes and to keep the local storage
> code simple, avoid adding a new flag for sleepable maps / local storage
> to select the RCU synchronization (trace / classical).
> 
> Also, update the dereferencing of the pointers to use
> rcu_derference_check (with either the trace or normal RCU locks held)
> with a common bpf_rcu_lock_held helper method.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
Thanks for the patches.  One minor comment which is not very related to
this set.

We can land this set first and then use a follow up.

Acked-by: Martin KaFai Lau <kafai@fb.com>

> @@ -306,7 +328,8 @@ int bpf_local_storage_alloc(void *owner,
>  		 * bucket->list, first_selem can be freed immediately
>  		 * (instead of kfree_rcu) because
>  		 * bpf_local_storage_map_free() does a
> -		 * synchronize_rcu() before walking the bucket->list.
> +		 * synchronize_rcu_mult (waiting for both sleepable and
> +		 * normal programs) before walking the bucket->list.
>  		 * Hence, no one is accessing selem from the
>  		 * bucket->list under rcu_read_lock().
>  		 */
This whole comment section is outdated and can be removed because
the bpf_free_used_maps(bpf_prog->aux) is now only called after
call_rcu_tasks_trace() or call_rcu().

Meaning bpf_local_storage_map_free() cannot be running in parallel
with bpf_local_storage_alloc() because the running bpf prog holds a
refcnt of the smap here.
