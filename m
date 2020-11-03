Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282762A5AAE
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 00:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKCXr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 18:47:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34854 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgKCXr1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 18:47:27 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3NiNBo031018;
        Tue, 3 Nov 2020 15:47:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ysewCAZlmKV1J6KMfcKg11ClNQEQpxs5rk5jU7NFps4=;
 b=C8O1iwA4qGqw7DbLOg4Q0e5arGDEkasDEnB4XWPoIKsB87NI1StLeq4hmn6Ih3YhCmgU
 EesQ4mBCchfiBBondc5Osiz4Ld4iwvxC07lBEY3aKmyT5s8d8F1BvLX5UOCwMTlfQhG3
 Y7VNmZV9cHCGSXzf/CfUtrvFiozMgDwyzWw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34hr6p6sck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 15:47:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 15:47:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V83Mck+EhmNjtLKim/74gq0RIb8OGZLqO9e5qjILkdZjn44bRY1EPR/MHkwOjr6jBmUI35UuaLOfChszgOk9+l8h1dkADnipZWXDbBcbBqa8k5nOUZrv9zZ9MJNbAVSwoQ0qSVB8JIBjQdXUHPMsfHpOeDQjSnViAgIQi7Bw0xBfnWmrD5Wf86X9dRSNfHElmVR2ZESwaKauguv77Ed3sSHubTTu4aPliZecN1LYUEm8COIPogNQRDWwIAYvITtsslR33FuscJuO7TzmrgaiLYEyUZPfV5dkMtHiUCLO9hl3Jzr7CUFMX4haEo6DhWxwQNOy+MqJZbFH1/xtUW5k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysewCAZlmKV1J6KMfcKg11ClNQEQpxs5rk5jU7NFps4=;
 b=IsUT+ft1X7cYe9w1S5Z/dV/JC1BUVchQgQEyO+MtUf7a82fnq5rhxFCV3Vw/YAITUs3m4dqpFOmvxuywKuAgj2buIhXd4e+TmR5iOmxA6TyU9WTceND/YngjBiBW+pmByds+HRRI6yfnKW1V7G6HpLbQbGXRuXUD2V7x86+zX5RuFLv4wn39VTZqsm6zrAtIjgTjvSvPfAo01+16Go5X+G3+OWSt/ktflMYCuY1KeraLqUZM4TFmem9/vRZ9klcJ9UKHWW9YvAWrUohxiNjjDESj9uKnnAVsDiT/EyUzb4p5CMwOMxTvB2P6zb/SlXSy5w2kBJj/pMnGdzNklU90sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysewCAZlmKV1J6KMfcKg11ClNQEQpxs5rk5jU7NFps4=;
 b=VVKsSLg/8pIGwyuohR9VQi7l1YBub4coGU9b1Ez3sttSsj+y5d2cLBN3v5k7Hcc1IKfsbX+pbY+yZd5t5+eZULgSQ+PuMPUgyBBKFvAalyyEsOBwCzbKDhcuQehmB+Fzgv1MKzLNtmcY7DkETljkbnPoGW24QKuSzCILvOF+JjA=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Tue, 3 Nov
 2020 23:47:05 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 23:47:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 1/8] bpf: Implement task local storage
Thread-Topic: [PATCH bpf-next v2 1/8] bpf: Implement task local storage
Thread-Index: AQHWsfZy11My4qB0sUqP8aoNnCOHA6m3E1YA
Date:   Tue, 3 Nov 2020 23:47:04 +0000
Message-ID: <B5563E63-BA82-4D15-8480-354FA733ED43@fb.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-2-kpsingh@chromium.org>
In-Reply-To: <20201103153132.2717326-2-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a68b312-5c87-4446-12b7-08d88052c4d6
x-ms-traffictypediagnostic: BYAPR15MB2455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB24557F5032238B0928C96A5BB3110@BYAPR15MB2455.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TmznDiHoZVs4YZ18dW9/yVJAntniRXgGNGkg9XEuRuQ31KPBf9aKlWJDFVKZEAlTwt6AhzkDo4SeYrttdvyDH3Q0Uo1PVloLhN0Y8JJwGdw9yLwBAfTKlDkYdTrxBaDQPFkJw5akdzddZ88U1bKHYRapXdODcqchJ8Qq8wvphdf4+2vJSGxVvOiswfj1688zSeS/01tYRy6OX9w+xIyeiHbRLBJf3Niju+Nzfa6WaGfT3MqWGnIfuv5QXA6axLVYk27FQeeXz2Ksb6TRUyaqvyg85kxS8IVElikTlp61aYdbmyWPIrjYn4FyJRQQG8KHba2n2SPJc+WxJfMBCu8ohw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(2616005)(71200400001)(64756008)(66946007)(66476007)(76116006)(5660300002)(53546011)(6512007)(66556008)(66446008)(91956017)(6506007)(83380400001)(186003)(33656002)(8676002)(478600001)(36756003)(54906003)(86362001)(8936002)(2906002)(4326008)(316002)(6916009)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: f+RiwVG/SWKOytlaKzwz1YgOdHyRAzpcSnXFAwY1VbaJEmXtJqCuleekm59KftcLnsYdHwaHuH53G//tKyx1k7IywBnLQ3rLOwZu+vTH1mINWfTvIinvh83Hg26pyVX0javoKIPqp6zy9Ss9ackDzkIuwGwqI5eim/ZiWUGAAloe8GDyEA4HkrRp7TUTEFG3DhxuWy3hASxzQ6zlRkgkxQKcnfxTzekH92gbBt7Z+lLAtBbojXmdjutWhoxYIRRbxDV14li/PeOFH5VL5Ar7TnvolcgbDOcE9BjyK9klhahyMoyh/XJNKlYk/nPlqp/SOczQ2QmKKsHXQSnZK9ljmdzgdK8rZF9d28b61BfLGlE4BOHi+D68niwJQv2XAcFb5Xc+G+ZeN5Fy/D0Ra/wR5gIM/e7/4ewPpTPCtqEc+hpr1TngmfBVSWiE7F/zdYrJCgkd/7ZhpEvHDYSx77yrV0rH7Hcr9B9VPfhC8ABkO7QZQ+zDr+bjROb2drekBjO5uVHgYQkRPS3yGNFnVAQHpTKRMWrI8mFpV81+dxQkHKlfRrcqFHEBXFK+7VL9IIrr94VXNDPUepemVNS4ZxiATrVGEaJUhAZuA6iuLqEAIICTjeoIt3h83Ui0bZerIUFgquOD7xDWpRs5KTtmWsYgHmq3du9DcJH56l4neUUBexMfimK1NizN9VP4sVQ3gynD
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EFB5B04F62C13498AAE9037BA0EEED3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a68b312-5c87-4446-12b7-08d88052c4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 23:47:05.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwrVjSMohLzODSeDXcVxgdZpCEZ6BotsN7Ua8ZizpLb7fNIjWe5ywnQfSjQ/vpixE3eVjYwHc7uAmU0ibNTEDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_17:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030157
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> From: KP Singh <kpsingh@google.com>
>=20
> Similar to bpf_local_storage for sockets and inodes add local storage
> for task_struct.
>=20
> The life-cycle of storage is managed with the life-cycle of the
> task_struct.  i.e. the storage is destroyed along with the owning task
> with a callback to the bpf_task_storage_free from the task_free LSM
> hook.
>=20
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> the security blob which are now stackable and can co-exist with other
> LSMs.
>=20
> The userspace map operations can be done by using a pid fd as a key
> passed to the lookup, update and delete operations.
>=20
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

with a few nits:

> ---
> include/linux/bpf_lsm.h        |  23 +++
> include/linux/bpf_types.h      |   1 +
> include/uapi/linux/bpf.h       |  39 ++++
> kernel/bpf/Makefile            |   1 +
> kernel/bpf/bpf_lsm.c           |   4 +
> kernel/bpf/bpf_task_storage.c  | 313 +++++++++++++++++++++++++++++++++
> kernel/bpf/syscall.c           |   3 +-
> kernel/bpf/verifier.c          |  10 ++
> security/bpf/hooks.c           |   2 +
> tools/include/uapi/linux/bpf.h |  39 ++++
> 10 files changed, 434 insertions(+), 1 deletion(-)
> create mode 100644 kernel/bpf/bpf_task_storage.c
>=20
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index aaacb6aafc87..326cb68a3632 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -7,6 +7,7 @@
> #ifndef _LINUX_BPF_LSM_H
> #define _LINUX_BPF_LSM_H
>=20
> +#include "linux/sched.h"

vscode?

> #include <linux/bpf.h>
> #include <linux/lsm_hooks.h>
>=20
> @@ -35,9 +36,21 @@ static inline struct bpf_storage_blob *bpf_inode(
> 	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> }

[...]

> index 000000000000..f5ed5eedc532
> --- /dev/null
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Facebook

nit: I guess we shouldn't say 2019 Facebook=20

> + * Copyright 2020 Google LLC.
> + */
> +
> +#include "linux/pid.h"
> +#include "linux/sched.h"
> +#include <linux/rculist.h>
> +#include <linux/list.h>
> +#include <linux/hash.h>
> +#include <linux/types.h>

[...]

> +}
> +
> +BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_s=
truct *,
> +	   task)
> +{
> +	/* This helper must only called from where the task is guaranteed
> +	 * to have a refcount and cannot be freed.
> +	 */
> +	return task_storage_delete(task, map);
> +}
> +
> +static int notsupp_get_next_key(struct bpf_map *map, void *key, void *ne=
xt_key)
> +{
> +	return -ENOTSUPP;
> +}

This is the third copy of notsupp_get_next_key(). We can probably move it t=
o bpf.h.=20

[...]

