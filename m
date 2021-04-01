Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538C6351923
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhDARvl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 13:51:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236751AbhDARrU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 13:47:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131HdjFo032496;
        Thu, 1 Apr 2021 10:47:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kCjxjZl94hUV56ZtJQpCQphv0Vp1LMGUEEzZwXOksQM=;
 b=kr6qcdjN9xQxuswq6yI5/xe1IfH1JwvSYUeykDTN1/flu0/SSz7v3ah2hTkeHFaqmCOT
 InKRLIPGrS40BwI6CW6mxpO45z5Cu9e/Dq4pPcBhtS/sdq4GEJaf8XRpY4J0vhMIeU2a
 gQoVATYXNAQIABMo/ScrvcdxToM7xR8VfpU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37ng351k9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Apr 2021 10:47:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 10:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W78tCF4PpkceWXQWA3xJFVf6r9fBWZXT2Q1IT5AUhHlqpVxZ28LkDH3wI4iiliaQmQL+B/fz+d8UwerxyLQcmjs6Taxlh2PymVXa2ZqpmyqeN++vX03+jifXyZF7ue0VLYTFX5ig4p8x7K2nuShiQkwjuse6tJmi6iYr63NbKlnBy6s3oodArccVuwXHwW6gSAu71rQRYeCLdW/fwFlnqGngy01rIG3Ujxkh/W3PEP9olk7VtabSvVcA4coa6c/sZ5CrnE5ZGIIFID5ZKGDvwDbDAWQx7uvrqgk8la2n3lW6mQNO2mVLjAOBJ0ZlfIp7zKY+oPkoMzB+rctwoslvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCjxjZl94hUV56ZtJQpCQphv0Vp1LMGUEEzZwXOksQM=;
 b=CXgT6NpxxKpIJr7FzrkyOvtT5wvwksCOwiAW7Rdsiclq1hehFfT3kVRwfqkMSlHPJXiTsdMLlr0MLEAqyMmmKNffI7saJK9wpQ4+Vm8QQEDP4vtunj75d6n6HzSNS+7wPS/1J85YfNpzfE6f7N34OGv2inj1NglpAM5vRFUC7IUNo+KBREgkV++QicqZLjr/UffU3HUHLtOnz1o1v01qwGn2o815vfVY8WzrkJeWKMflbDI3NfWnRC1tELNLXM8X1nFEt4s50pmJgRAnttcEvteu5LXuW+wvRuWrfFdGkWuFaShhSUDTiBh6RYVPe7UusWwEIh2ulLAUJ0IkPi9RxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2584.namprd15.prod.outlook.com (2603:10b6:a03:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 1 Apr
 2021 17:47:04 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 1 Apr 2021
 17:47:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] bpf: refcount task stack in bpf_get_task_stack
Thread-Topic: [PATCH bpf] bpf: refcount task stack in bpf_get_task_stack
Thread-Index: AQHXJosgP+JmR44UgEePF4s7EXmXo6qfON2AgAC4FwA=
Date:   Thu, 1 Apr 2021 17:47:04 +0000
Message-ID: <E35C73AA-806C-41F2-9E8B-DC251C45B629@fb.com>
References: <20210401000747.3648767-1-davemarchevsky@fb.com>
 <FF83BF2B-8CA4-4919-B8F3-B21602780F1B@fb.com>
In-Reply-To: <FF83BF2B-8CA4-4919-B8F3-B21602780F1B@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
x-originating-ip: [2620:10d:c090:400::5:c1d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04855ad6-965e-469e-ff4b-08d8f536293e
x-ms-traffictypediagnostic: BYAPR15MB2584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2584995DC161C04F8912D8B7B37B9@BYAPR15MB2584.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /V1Bc/xe5nybQ5Pm0UerNJv8wKh/JAdZR6IISRFt642zxk2kYSmlCguvaAXCJHGNKS9fFITeEUwmJwo07irD/Tilo0wE08RT4RWOB94FiUUvgvfUOvyJ3XWcvp0Cc9IfXgigNBnau2DdYyfaDBI117aQkcKy+MToa/lXh2ZUexrB3t8EoNG1sSHvgZ3cAEGBddrUCe06NqkuMhRSP8ebOqSBRO2TAyiKbKKonUFZPWw/mtq5BQC0bYF2o88PHia6wxQBs94qMW3os5es5wBhkGpyGOPWpWi37tdX707ovxCajCqfxHCLXlBoaQVKjrUjlM0c1Tvxzp9hI/fBGzkEw2bVC57A39rJGGdutJWvr9gBMiMP334oCSmgxzheJEzaU0GoEhJZbCvEn7E6OOQtX+gFzZPhVE9km+zPAC+GOtaDtKy1p0gIYQUKDFlMNdybLg/xayG9PkuXq+/Y1LaWM1E9nP75AJtgUDoL6dAz4FB2ESXcFE6YmxN2fIkKIeVNV8P3nwOCBRREElLFZ29W4SBRl/5ggrQbCJtpbc70fbSRUzJvbQ/9WUstpQTxk3yZOk85qrtkr3IZ0uWvq97n80fXFl65zsxeqR/Q/cu4ruaC+PdTP2mzVmXo+A8ShxKhfM3tf5k/05spW6Su9pX+O5qhMTsWVDKNbtskDsYiQtziyefjIIOg3vqxIRNVCTxm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(76116006)(66946007)(91956017)(71200400001)(316002)(66556008)(83380400001)(8676002)(5660300002)(2616005)(8936002)(66476007)(64756008)(66446008)(6862004)(38100700001)(478600001)(6512007)(4326008)(6486002)(186003)(36756003)(54906003)(6506007)(86362001)(2906002)(33656002)(6636002)(53546011)(37006003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MmouRnQB6lAY6M4VSyrDlhjrYuiQ+TP8EXCGhEHJByCQVJi1DAz17Qo+TAH8?=
 =?us-ascii?Q?qZY0SuniLvneLY93t1SgRTmgD3gDfooE5BjnQiXXXpBloouklsV6/JUxGEJh?=
 =?us-ascii?Q?uKE+FuZ9JMZUdqWKjmcT9QyriVqZsf+1/I14TYLYC6E1VOtgVCSCemTe7Rth?=
 =?us-ascii?Q?+GEYbsxD2TESAbQ+QZGkD9d4a7gBv/iZ+5+Jb2e6k466roBkqFdiCzC3euaH?=
 =?us-ascii?Q?jqTda4CaSZV/HJcxro6s734V9cWSPK6e/P1Lg+oxYZrIZxv/eELuctSgaOKw?=
 =?us-ascii?Q?ybw1R6vRujDBtYOUbKfIqceJPc7ctrf94FzUddn82Sfy/EVFO7SEhz2l9aoi?=
 =?us-ascii?Q?C7oAgQRhgZnQ04pAT2ZEpIsnLmX69+DViwv9qHe0ecncT7Kpfz5cOvNnZ4oA?=
 =?us-ascii?Q?Vv5F+TA/BNOI9OgjKNMnJDW9j7KNHMD7PTuwV5bvzbNyiJjp5u7/R6gbMbF6?=
 =?us-ascii?Q?b5EON05T9YooN7rWUWTO42tSADSVxmkbAsyz7D7QrMH5ottolJKw7P5OUnbK?=
 =?us-ascii?Q?zKYPa4DaG0hywHqgNUJbLDTIF2Q/LMEh3BK6kEoHqW/uW/RV+QPYf7Rm9C69?=
 =?us-ascii?Q?W4dUPt2sitJi/82BXYz9nEQvPkmKTVchbwBpubP7DVuW3pZ0XKZ0qgTjQEdL?=
 =?us-ascii?Q?/zKec/BGXL5ch4bceTJ/x1ba1nHqaLMa72CMadCMYNFHf1bGWIGxTjv4sO0b?=
 =?us-ascii?Q?Z2lkrhAXGNFrC5Mflo8ap1pcE4BOjsedzBZmDn3i2COdo3pIVNYN7rnJmwRu?=
 =?us-ascii?Q?EkkhuUOpZ2p0MGZeuL6vdUaX3yGMxcnApzhRPhMpBpL+vjdi83rZ7A+yyP8h?=
 =?us-ascii?Q?9tS1357uBEhLgYdpqzDZ/M0QxsUouRz16jt89Autf2fpS68ws8JBFZpWiUQL?=
 =?us-ascii?Q?4hHJVHlbeJgIBw0JzsX0j0oprP9b/D2G9Nndnng2wrRio1lMs07ikw7AnA3y?=
 =?us-ascii?Q?NXBCTdawwhaWdo2i6tCabrQJXeF7qzSmH9OvA1q3XS/LlnKra/XbuVXkxzU8?=
 =?us-ascii?Q?D+AcLTxzFU0CUr54wJw9o4ceyKbnlzOd75/yMVWgpg9Vpn3ON2C3vaMkKSHd?=
 =?us-ascii?Q?G4XFOiX4ylySji9rQNeW7o0qFEvKSTSPyLGTYiRMZHuROViFZl27e/xFNl6J?=
 =?us-ascii?Q?qeOtwG4xYepfgURYsg0JVwO1xD5z4D/eps5/bhAFXE7lQ7DJbyF7dIkVfI9W?=
 =?us-ascii?Q?MYFdw77HK9YTg90/3202SM8IcCUqlpdOgX0f7Kf9nBJVB0u7d0C8cV86zBmb?=
 =?us-ascii?Q?uGCPA79bOZy/ZcUYUPValEF4WBt5JCCAnbe/pGSpIAx2nF8hmTF1fnvC2dSF?=
 =?us-ascii?Q?6SxKHtZuGgJuYmLOPHAmRZvBWEa8HPAfS/iuJX/jUIU/VfucCaKYJMOWOfdF?=
 =?us-ascii?Q?sDae6ZY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC1E1ABB04708B428D697A2CD83CE644@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04855ad6-965e-469e-ff4b-08d8f536293e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 17:47:04.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmXzd0tsRFYTjBN474gOBY6EZ0LbVt6kgB1lqz4hIznNrtjNkdlD8+q+rh98ob+23Uz6f2Nzd5UWa48R+8OUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2584
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6n8XbuWWM9-UUleRiwCVg5v2Z0fborJH
X-Proofpoint-ORIG-GUID: 6n8XbuWWM9-UUleRiwCVg5v2Z0fborJH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_09:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104010115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 31, 2021, at 11:48 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Mar 31, 2021, at 5:07 PM, Dave Marchevsky <davemarchevsky@fb.com> wro=
te:
>>=20
>> On x86 the struct pt_regs * grabbed by task_pt_regs() points to an
>> offset of task->stack. The pt_regs are later dereferenced in
>> __bpf_get_stack (e.g. by user_mode() check). This can cause a fault if
>> the task in question exits while bpf_get_task_stack is executing, as
>> warned by task_stack_page's comment:
>>=20
>> * When accessing the stack of a non-current task that might exit, use
>> * try_get_task_stack() instead.  task_stack_page will return a pointer
>> * that could get freed out from under you.
>>=20
>> Taking the comment's advice and using try_get_task_stack() and
>> put_task_stack() to hold task->stack refcount, or bail early if it's
>> already 0. Incrementing stack_refcount will ensure the task's stack
>> sticks around while we're using its data.
>>=20
>> I noticed this bug while testing a bpf task iter similar to
>> bpf_iter_task_stack in selftests, except mine grabbed user stack, and
>> getting intermittent crashes, which resulted in dumps like:
>>=20
>> BUG: unable to handle page fault for address: 0000000000003fe0
>> \#PF: supervisor read access in kernel mode
>> \#PF: error_code(0x0000) - not-present page
>> RIP: 0010:__bpf_get_stack+0xd0/0x230
>> <snip...>
>> Call Trace:
>> bpf_prog_0a2be35c092cb190_get_task_stacks+0x5d/0x3ec
>> bpf_iter_run_prog+0x24/0x81
>> __task_seq_show+0x58/0x80
>> bpf_seq_read+0xf7/0x3d0
>> vfs_read+0x91/0x140
>> ksys_read+0x59/0xd0
>> do_syscall_64+0x48/0x120
>> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>=20
>> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>=20
> Thanks for the fix!
>=20
> Acked-by: Song Liu <songliubraving@fb.com>
>=20
> Could you please extend bpf_iter_task_stack to also grab user stack?=20

I think we can extend bpf_iter_task_stack in a follow up patch. It is
not necessary to bundle these two patches in the same set.=20

Thanks,
Song=
