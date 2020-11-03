Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA912A5AD1
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 00:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKCX6A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 18:58:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47696 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbgKCX57 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 18:57:59 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Npig0005549;
        Tue, 3 Nov 2020 15:57:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BdMA6VNHeiQrD4NqRezgELMsZkMaK3XLGU/kDW6BCiE=;
 b=ESJSDPF9qS/cOL/KWEoxN4GgbHbWYb3aJu449U6+ZLzPr0O3z44wGQ1T0p2KUI6U9mPi
 wNBuW8y53DtIp2IvSeD5nR58xLeut6QnfnbD3OQW1S0ciXqaXqOnA2LQrTJML1DyvgJ/
 x3ZfIPjFoO6kmnhWzMteHfDbQzLFl3pN7JA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34jy1c5x95-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 15:57:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 15:57:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5RurDbNJ5s6F+k4MlbBJMBG8R2tTbbNxFaFyKHMXFiIH+RPB6/kniz14lE5+MtOeKW9MA3Yy917Z0goVYrf1yJFiwdLlUFKFD4hHVUi7UNokMzJm4MRaIkjWQog3nm7m4SKczePzy4vDghKTOjp41tKWrdhjzZfk+ZqB2VIvdM+JBlbCjKS1cD3UUtMCSycY6ZQDpPtOYbZTPZnANEPv1rKqqK7Ukgbg4py3RH2XOPJRx0WckYch92evn3RTvuwnUMOmNThlCl7WWExL9vpcghLTarvtayQePJUQGQ7obC+w3wfYYlMrmCwcIL+NqBKzPmKxa9dEdLPKMeyMjtTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdMA6VNHeiQrD4NqRezgELMsZkMaK3XLGU/kDW6BCiE=;
 b=QkE6uRWatEnLbH01Lza7UR0d0JqZqeyOWiZsSP7rWoWBMFZcZ4bSA7V/FRa/Y7wfTEf/1FbHNKfEpc1ghxk962gX5ojR/0OJ9IXXW4BXWH0J+/smbsK1a/8txC3WjjNs4UG6WZJvcSQL0p9Z4oGCxhQ0++Su9kEPfzQHZRrtWKHy5LH57XhvDPiLGLE0EtGu6CQMIkeeMmll6ve5yYeEjpDxpOolWpXwIItUYDNxDMGtitHmtHDz6sT/V9pnm/fPdAzjJiekwIv8dG5TiT755u6pM4XsOMaVrxUpvLfR5tBhohQ2gchvmhBrZILqDvXC4YH/5kKihOzQYdF13MoIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdMA6VNHeiQrD4NqRezgELMsZkMaK3XLGU/kDW6BCiE=;
 b=ivNQ4VOsdS6QCvz0LOsjsNcDyAF8+PUV3d+1ufXqdqfuQazZsbDLwrGTCQpg6lbhcrbpGqyzBs/tLzo+9KbXbTRp4hv0xxhszM7cauUueZCuQ22SAWIXmb35ger5ULZC3zywm3dzB+s1AKpxsF3wb6Og2v5yIkMsejzSqQ8FhJU=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2645.namprd15.prod.outlook.com (2603:10b6:a03:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 23:57:38 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 23:57:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 4/8] bpf: Implement get_current_task_btf and
 RET_PTR_TO_BTF_ID
Thread-Topic: [PATCH bpf-next v2 4/8] bpf: Implement get_current_task_btf and
 RET_PTR_TO_BTF_ID
Thread-Index: AQHWsfZwEn29D0BgLEqjnabW/9FX1qm3FkmA
Date:   Tue, 3 Nov 2020 23:57:38 +0000
Message-ID: <A6A30C93-0BA0-4623-A0E9-F6D693F99720@fb.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-5-kpsingh@chromium.org>
In-Reply-To: <20201103153132.2717326-5-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f87ad1a-d4b6-4fb6-2752-08d880543e27
x-ms-traffictypediagnostic: BYAPR15MB2645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2645B3192AA8BDC851A489ACB3110@BYAPR15MB2645.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5PogDAzgSKf/WVQaj9/L0cV2IScEW7fbEbdOxWl4mbNmdl228vXmjrqIR8loKPKoG3TCpB0AjL47yDN3VhXIf9axLzcj08Nod0VXi9O6/sBC46eqVVe5aNex840CEffhxXDNmw+CwPmAD4od4zM9JS/hjjBd3qIoPbb8vy2OTuMiMxk+sT4nqUc9KvGi973NlK3EE0Q1evfW6cNz3GxY8sIHEj9BiRkXe0crwbJVwMkj94hTM4AF9XIQ/ztLraj4obL+RDo5z/hzI52s47eVUVTdrg9pk9896IayDnNQQm89XpGgc/YWcK9NDZb4H4YdYd1FWvjihjXc9sL72KQJyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(6506007)(478600001)(54906003)(2616005)(6486002)(6916009)(2906002)(8676002)(71200400001)(66446008)(316002)(53546011)(36756003)(86362001)(186003)(76116006)(66556008)(6512007)(64756008)(66476007)(66946007)(4326008)(33656002)(91956017)(5660300002)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bZBt3P/l51PQuDklvP+IW9LAQlN+2yfqzdmJGMxF2Fg2HwWUSEWr8OjNkd9MPr3D6jRWJRfxeKQp8iMn8C8/+83jYCN+2BX4Am0hzkbXqGgVNtuhRPFVO62ohuqDCe+B1swQrVWkHobl64e8KXT8UsjW4zxhF7PFUwylHteSxdZ+izJCSqnsq4jN+HnwF/4Nin/KKOUMOz1+pbUk4lbE/Cfn+qduJTz0vfmsCn0nXg/M6HKIvM306CxeD9qjEOF1H8GOUUxX8ABueD220GikQhL+TDlbyZvQKRLqc0QPJrKNkUTswbdcjyeuohAATaTZcmzy6j2nmIrvzzI0HeJZsRBSeEuL3jyt/hoxSXcxrgsK0jUGeoLgjfJNe7YSa37s/RyxtNMh7iAM87Q03YGJZ6dWJ5Vtff6sLTHB90be5VNv6X7yMXkLqoh1zy/42myBEcd4f56RORyie4NGhiUI/0Vt8zLLEK5W8q8qEBNCqVkkeBl/QDnCaQnf8a/k6XVj96Wsnm3OhJEyHmr5VubVzOIIwiTy3+9cReqU70+hmyV/UcbxXF5+NGdeZZIGyXNDNUPxYhWGwv3rHTAAGH4YvKOOpAcmo90bjqIBr+6BiMMctbDL1vmpK7QYhwbucdSDzqg0MzGAshF2nBrFiWm3tFRs4XTzfd214RwWhwcr7v41PLnsW4sKQvcX9tLy0ueZ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9685B12A51E595488805258911E12BC3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f87ad1a-d4b6-4fb6-2752-08d880543e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 23:57:38.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMEQk8F24Yj6tSW4JrD87K+QTVzUCUpAS7ABKNbfYjrD/+lzzBNEzK1XvbUmTO79XU+KpuFkXw8ZmFIiv/+eTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_17:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> From: KP Singh <kpsingh@google.com>
>=20
> The currently available bpf_get_current_task returns an unsigned integer
> which can be used along with BPF_CORE_READ to read data from
> the task_struct but still cannot be used as an input argument to a
> helper that accepts an ARG_PTR_TO_BTF_ID of type task_struct.
>=20
> In order to implement this helper a new return type, RET_PTR_TO_BTF_ID,
> is added. This is similar to RET_PTR_TO_BTF_ID_OR_NULL but does not
> require checking the nullness of returned pointer.
>=20
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> include/linux/bpf.h            |  1 +
> include/uapi/linux/bpf.h       |  9 +++++++++
> kernel/bpf/verifier.c          |  7 +++++--
> kernel/trace/bpf_trace.c       | 16 ++++++++++++++++
> tools/include/uapi/linux/bpf.h |  9 +++++++++
> 5 files changed, 40 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2fffd30e13ac..73d5381a5d5c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -310,6 +310,7 @@ enum bpf_return_type {
> 	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
> 	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory=
 or a btf_id or NULL */
> 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a bt=
f_id */
> +	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
> };
>=20
> /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF =
programs
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f4037b2161a6..9879d6793e90 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3779,6 +3779,14 @@ union bpf_attr {
>  *		0 on success.
>  *
>  *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * struct task_struct *bpf_get_current_task_btf(void)
> + *	Description
> + *		Return a BTF pointer to the "current" task.
> + *		This pointer can also be used in helpers that accept an
> + *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
> + *	Return
> + *		Pointer to the current task.
>  */
> #define __BPF_FUNC_MAPPER(FN)		\
> 	FN(unspec),			\
> @@ -3939,6 +3947,7 @@ union bpf_attr {
> 	FN(redirect_peer),		\
> 	FN(task_storage_get),		\
> 	FN(task_storage_delete),	\
> +	FN(get_current_task_btf),	\
> 	/* */
>=20
> /* integer value in 'imm' field of BPF_CALL instruction selects which hel=
per
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b0790876694f..314018e8fc12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5186,11 +5186,14 @@ static int check_helper_call(struct bpf_verifier_=
env *env, int func_id, int insn
> 				PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
> 			regs[BPF_REG_0].btf_id =3D meta.ret_btf_id;
> 		}
> -	} else if (fn->ret_type =3D=3D RET_PTR_TO_BTF_ID_OR_NULL) {
> +	} else if (fn->ret_type =3D=3D RET_PTR_TO_BTF_ID_OR_NULL ||
> +		   fn->ret_type =3D=3D RET_PTR_TO_BTF_ID) {
> 		int ret_btf_id;
>=20
> 		mark_reg_known_zero(env, regs, BPF_REG_0);
> -		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID_OR_NULL;
> +		regs[BPF_REG_0].type =3D fn->ret_type =3D=3D RET_PTR_TO_BTF_ID ?
> +						     PTR_TO_BTF_ID :
> +						     PTR_TO_BTF_ID_OR_NULL;
> 		ret_btf_id =3D *fn->ret_btf_id;
> 		if (ret_btf_id =3D=3D 0) {
> 			verbose(env, "invalid return type %d of func %s#%d\n",
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4517c8b66518..e4515b0f62a8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1022,6 +1022,20 @@ const struct bpf_func_proto bpf_get_current_task_p=
roto =3D {
> 	.ret_type	=3D RET_INTEGER,
> };
>=20
> +BPF_CALL_0(bpf_get_current_task_btf)
> +{
> +	return (unsigned long) current;
> +}
> +
> +BTF_ID_LIST_SINGLE(bpf_get_current_btf_ids, struct, task_struct)
> +
> +static const struct bpf_func_proto bpf_get_current_task_btf_proto =3D {
> +	.func		=3D bpf_get_current_task_btf,
> +	.gpl_only	=3D true,
> +	.ret_type	=3D RET_PTR_TO_BTF_ID,
> +	.ret_btf_id	=3D &bpf_get_current_btf_ids[0],
> +};
> +
> BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx=
)
> {
> 	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> @@ -1265,6 +1279,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
> 		return &bpf_get_current_pid_tgid_proto;
> 	case BPF_FUNC_get_current_task:
> 		return &bpf_get_current_task_proto;
> +	case BPF_FUNC_get_current_task_btf:
> +		return &bpf_get_current_task_btf_proto;
> 	case BPF_FUNC_get_current_uid_gid:
> 		return &bpf_get_current_uid_gid_proto;
> 	case BPF_FUNC_get_current_comm:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index f4037b2161a6..9879d6793e90 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3779,6 +3779,14 @@ union bpf_attr {
>  *		0 on success.
>  *
>  *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * struct task_struct *bpf_get_current_task_btf(void)
> + *	Description
> + *		Return a BTF pointer to the "current" task.
> + *		This pointer can also be used in helpers that accept an
> + *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
> + *	Return
> + *		Pointer to the current task.
>  */
> #define __BPF_FUNC_MAPPER(FN)		\
> 	FN(unspec),			\
> @@ -3939,6 +3947,7 @@ union bpf_attr {
> 	FN(redirect_peer),		\
> 	FN(task_storage_get),		\
> 	FN(task_storage_delete),	\
> +	FN(get_current_task_btf),	\
> 	/* */
>=20
> /* integer value in 'imm' field of BPF_CALL instruction selects which hel=
per
> --=20
> 2.29.1.341.ge80a0c044ae-goog
>=20

