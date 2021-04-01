Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76A2350F54
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhDAGsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 02:48:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbhDAGsY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 02:48:24 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1316jMM9007055;
        Wed, 31 Mar 2021 23:48:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dVWEM06S8NxAUo1FXIEJQwWJ5VOJCGQqMHTRDvbZEkQ=;
 b=rLYpZKrm7MZo5SfF27VaLOpi7GIXCZLXS2X7SUziiIUJLzg2ejBIfwm2J9hzXU+K+VQG
 0Kb/XC0gnJP0bH5UmehqDVFO3GkH8Gw7AqD96LH4OTrh5QkSyOBOUz3QUj/V3sg19IV3
 FWHjE2JR4GHWhMiJ4TrXUB2Njmk5+Uafc68= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37n28y1snf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Mar 2021 23:48:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 23:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQAqxjcOex+HwuwG3EKO1pFBqB4Pu/M13pr5GTVWpDiSbdeL3CdUe5iGsf6uMMNv44+lKM9RjYnEr8PvhGfXzQcFlRAk/7BH0OtUhBFzEIIwY8/d9HIY9bSfmi/LGLVMdYdUf663VkjqaT1D0bva/0dqTZBOkfTPLpdDE6wiJ4AyXThqy5WrQw00N3AttcForTdQK6NEj8NQx5z/NrlygFOuf+swN68n70rNdkugw8+2ZEmNjJZqz97dW7ttqoZ/5sXq/Kw/Nq2pzb5RYR3h13LPG6uhUquy9AkQAF99vMbpPl4ThuExEeuiqzUqWEqniFuYDoDYjAkVRkskcwb3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVWEM06S8NxAUo1FXIEJQwWJ5VOJCGQqMHTRDvbZEkQ=;
 b=iy8eIJVONLvJ1zvcVFuT+l6Zbe2POAxSIa4MbV2AxdmPYfSyalGmJyggfT36JShoafIzsdiK8XAc3rnDIXXLf3FUePc7OG5aUPRfcpRvzGB2HNS/vbJRTlKGLcwPu41pKGgJTsXGKKHLD/IxNH2MM8elwBOR9Y+tnfL6WdaDUJcn2NWhHJyElCmXBdOHSqiwrcA7MjJsZB2Qo5Ro8vC8NzMdfkIKyVDYbmB9baO0MEb249D86fCzhO6QJM67WAibC1d3YtPwMJ5ym0E0B3QQLIVZ+497T8ZXetfLbDQwsxGBEmSiZMyibuWuIe7+juA3l2dBDAlA/xFsmj4Ha+z8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3189.namprd15.prod.outlook.com (2603:10b6:a03:103::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 06:48:09 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 1 Apr 2021
 06:48:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] bpf: refcount task stack in bpf_get_task_stack
Thread-Topic: [PATCH bpf] bpf: refcount task stack in bpf_get_task_stack
Thread-Index: AQHXJosgP+JmR44UgEePF4s7EXmXo6qfON2A
Date:   Thu, 1 Apr 2021 06:48:09 +0000
Message-ID: <FF83BF2B-8CA4-4919-B8F3-B21602780F1B@fb.com>
References: <20210401000747.3648767-1-davemarchevsky@fb.com>
In-Reply-To: <20210401000747.3648767-1-davemarchevsky@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
x-originating-ip: [2620:10d:c090:400::5:7a9f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5700149a-cdc1-4ba2-b1b9-08d8f4da1cd2
x-ms-traffictypediagnostic: BYAPR15MB3189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB31893074CF675331790E6E43B37B9@BYAPR15MB3189.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8hiZf1jX7n31KmMAM09/COovIN34m1Y1i/1sq1PyYTnmkSnOX+CbkrgPLC0gOpmUBOwU0U7vb1J22dvM1d4+atR37bu3/Gp19HNOsy/zR4O5s0xgB05MqHO3mWYQa4KioHGk/8scfPZkD7M7MD/A6rl8gePvoV6Gbv5OcfAyua491oDSnSboMscqDl8j6cTpsSpOUBQ49gdmPiioCdKlAMIt6KQWE1o5n0bdxlKEuqrNjQl66npw1wQ5MsKYmX8Lk4YH2fLecAF36C6BQPKRHWr3i0V99dyRg/H9/oFj39CzlAMxodQyaiZm8srXuVeE5CXelvmjrY9rr03K6uZ/2u5QeMNA66VTcMWhP1XiSaCnXq/IyzVi641ZBPx13Wvqy6grc1TmowtIXwJDPzA3vNrFGmctf1dhOjWaPNwflqHDuC2IWRHI1IYjOjP8uffN9Oy8K5opXiYqc/IgzP9QZOcwZm1vrbJ1dcTrgQyvZZg/gq6ZgMSMBo3WnXtd6PJmuxXlK/k7aoCKvEdsE0VVnvS+H0BNVOoXDdIP1eE5UzJQbSo3NpGenfJmL7vvA6e6ioyG5sjqpTRx8LwCVbPooi+rQOAmXkwgPTLmi//RPqyFwDCj/QYrjiSgg3FpCZifPIxVjKXgmMFbXIPHmf9MpoNGaYxjvE/H8UjFtuQeymuoO+CARwnBXKbtUhGQvkR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(396003)(376002)(38100700001)(66476007)(66556008)(66446008)(64756008)(66946007)(76116006)(8676002)(91956017)(6512007)(186003)(86362001)(36756003)(71200400001)(6486002)(6506007)(6862004)(478600001)(83380400001)(53546011)(2616005)(316002)(5660300002)(2906002)(37006003)(4326008)(33656002)(6636002)(8936002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AagZOSzV9r83zbsXJkzJpslbRQIbm7ftpBtAYkjAQh3FhBv/mSP8atmlgPYv?=
 =?us-ascii?Q?gDRRYZbd68EmUtUzLIL3YR+FdVvCiXz4DRsgHLTQQfYFs3LbDij4lKHVovBb?=
 =?us-ascii?Q?rZAZyZlD4o8ros8YcxbfaexdcHKpUA0Gn6olVifoeLw71lzBdrZs7zAohmkz?=
 =?us-ascii?Q?5ztVSYFyGNmSGAyOrr7W0FHMHNeKZ/FCBYQbyNd+K8O3Iq5qxtL/DXaE89qd?=
 =?us-ascii?Q?ng3t3wxiJruIrIA6KNqM255M3dgjryWAYIB9h1DFYc0+k7UKjU/zrZx/2Cox?=
 =?us-ascii?Q?sp7DPDqeq0nOJiqkzPSEO66KEOVaZ518UYzNQUo1adzMuYv5rgA7/f6W4k94?=
 =?us-ascii?Q?keIO6XXL543yu4JSfbPG7xgh43pReP2MoYdvtO2tcLYZT4gVNNU2cd5u23yV?=
 =?us-ascii?Q?eCFtUPzck8pZYDinFwUJkjNzUURRcxIBEEeYMBhndVrmcp+ngbkfO/GJyz6B?=
 =?us-ascii?Q?824K0mdDVzIVL4+MB7HwIdoH7IOV3/kdmyH4QuHigvG6g1WqW8LHEABerjOm?=
 =?us-ascii?Q?cRDqtCxr83P7nbs29En2UZvqWeoyjSbENTVdDS7LfIS/algtQe+2fw6DHbc5?=
 =?us-ascii?Q?d9bXGUsl3hNkH4dG5SOGt+wMVOvOhUN0euekp6X8YAlUMnppehHxtNzM9HOb?=
 =?us-ascii?Q?nO3njzl7t+jF+Du0wk8P8Od+ciEnElKYEayMSavK3y5ytI0h6rrshRJiQRqf?=
 =?us-ascii?Q?UhqPp9sGEerMJwbo37vbt8NiMJrilp43Z+x278HKKq2daoeS85FTk6NnLaRR?=
 =?us-ascii?Q?JE1Pggwk2T4+Ma84rAwp+5xTgBJHkvim+KE/xDW/DDlAk26KaVER61L//6/f?=
 =?us-ascii?Q?W/n7+Y3BXvogBdJjfM0AKyeOvOTJ7OAgCAJ5DLPklG+WwLb4X7BcYphxkbYQ?=
 =?us-ascii?Q?SSP4OFlSznETZNsm319YAMQD4prL5RbqiFAaJKTx9Z53tGP6csKRnBLwOaao?=
 =?us-ascii?Q?BWihtb3yvMfX2+sCseuIHAdbzs7JJ8oYxMJjTpPMPnY51RqS8p8HuAH897vi?=
 =?us-ascii?Q?MgwRZ9Oo7X/+4SSmdb/teHdX9LcN7HdzlbTYOs3gpz8/HvX54dsMBKwS42Zn?=
 =?us-ascii?Q?dZvcucdu3S5408uNNeUXmpG7Vc3M0nkj+yYEYSgaj18egLudWDR9fhdDHhZz?=
 =?us-ascii?Q?O3aVHKArp75zlAkZrWqfJKACJfr+qFFivOXpHKc6g7gWdKY/uKXf9BnBhp4H?=
 =?us-ascii?Q?QqYUKKbGOX3xf+sgsbx3jhu+1nq4FLwRUV5PWnjV1IX6Z/DEJuifL8ixpGm6?=
 =?us-ascii?Q?afn8iEIse1fmZz1SeVLuH0ycyD8/rLLUPB1ANoiLS/dQFGPQDkn5m8Na721L?=
 =?us-ascii?Q?aOcjpAFMF9shQ4PyI6nYaBc42DOZdEoneOAJeQSFkzXFNqEvjZEU70sgQLQS?=
 =?us-ascii?Q?yECMeTk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EADA2B535B60224593818AB0124DEE53@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5700149a-cdc1-4ba2-b1b9-08d8f4da1cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:48:09.5153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8ByZwwMluQ2AW/+AgmsHLGj4GSF3pB18h+xFxt42fnem2AykuGeTdwKv7Cxq5aOrudKOMbS7013DoaIMYIFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3189
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: n1dzGIfiB8IDe3o5TQUC0ZNYc4RPxWWq
X-Proofpoint-ORIG-GUID: n1dzGIfiB8IDe3o5TQUC0ZNYc4RPxWWq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_03:2021-03-31,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 31, 2021, at 5:07 PM, Dave Marchevsky <davemarchevsky@fb.com> wrot=
e:
>=20
> On x86 the struct pt_regs * grabbed by task_pt_regs() points to an
> offset of task->stack. The pt_regs are later dereferenced in
> __bpf_get_stack (e.g. by user_mode() check). This can cause a fault if
> the task in question exits while bpf_get_task_stack is executing, as
> warned by task_stack_page's comment:
>=20
> * When accessing the stack of a non-current task that might exit, use
> * try_get_task_stack() instead.  task_stack_page will return a pointer
> * that could get freed out from under you.
>=20
> Taking the comment's advice and using try_get_task_stack() and
> put_task_stack() to hold task->stack refcount, or bail early if it's
> already 0. Incrementing stack_refcount will ensure the task's stack
> sticks around while we're using its data.
>=20
> I noticed this bug while testing a bpf task iter similar to
> bpf_iter_task_stack in selftests, except mine grabbed user stack, and
> getting intermittent crashes, which resulted in dumps like:
>=20
>  BUG: unable to handle page fault for address: 0000000000003fe0
>  \#PF: supervisor read access in kernel mode
>  \#PF: error_code(0x0000) - not-present page
>  RIP: 0010:__bpf_get_stack+0xd0/0x230
>  <snip...>
>  Call Trace:
>  bpf_prog_0a2be35c092cb190_get_task_stacks+0x5d/0x3ec
>  bpf_iter_run_prog+0x24/0x81
>  __task_seq_show+0x58/0x80
>  bpf_seq_read+0xf7/0x3d0
>  vfs_read+0x91/0x140
>  ksys_read+0x59/0xd0
>  do_syscall_64+0x48/0x120
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Thanks for the fix!

Acked-by: Song Liu <songliubraving@fb.com>

Could you please extend bpf_iter_task_stack to also grab user stack?=20

Thanks,
Song

[...]
