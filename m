Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11011D574
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 19:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfLLS0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 13:26:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730164AbfLLS0u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 13:26:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCIJdoL027688;
        Thu, 12 Dec 2019 10:26:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xdNOh7F4JsFat+TNxw3ETb7BbxovM9FD+C54g1wOFy8=;
 b=kjYMzh1YJkmNO+NafQZtFzGJScwWfx77FFwkSqG6Fc7rWFkxpLk5WajBmeo3ozOkuOAW
 OZCS7sFJ1j4S+IZeC74/O6loUsIWFzXt31Bcdm3se1np69a64BVyrQE4wi6jW0/WB4v0
 mcEv7xArM0/zbZ0dIYI+kJNiZKU9nLi35iA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wuskg0dxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 10:26:36 -0800
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 10:26:35 -0800
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 10:26:35 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 10:26:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAa9J586ZJrcr/4YSJbdRNi0l+wnVyZ8pDWmxp2t4dhvBYTZ0tm1YRYf/K185GmyUR6s2+TN2gjhuvHJiFiKUgeCcpYuo9pumc7EaCktYfR79+BOo0j83P5vrX91adIYJ1vDFJMOMPbhQF4fWqEHUyezarZV7MTsn8pcyDbuyqZRz2NHkJBtPXD+MUGcbKICKEDzHb2zrb4O0fPz0K+SUJF9icyRhfI3KuNFrBZZ6sLYORe/c4w2TBl3NzPj5nHsbnZ2GVDZwZU39x0m1ISxRopSH/HDZYYQBGFlp7iGWTZWEJnyRQWajsGbRygCj+e9CyN7dIaWb7QgXfCPE8Ztow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdNOh7F4JsFat+TNxw3ETb7BbxovM9FD+C54g1wOFy8=;
 b=eNJVwWMgnKhUxK/yXWxFSMfoac9xGrxldBTH+jDuwFF6OF/Z/Gn24voySOFcpLZNbxdkYG2dH3dI3+iyFZID+bZpeR9jPPk+Q/GEnl8vt81aLMF+p+xuW4SoJS12joaht99w0nfHku5Xp0bD5KLR63Yu0unRTgegNfrI10LS+dk9bD2hAtMZVh2uLCm143g/oVBKRPvokuDcWgZakn1YyPQbsIT/tCTpL8q7xubJMbr7Sf001EawZ9Evd/FUgM4GJvWLuIHhwDOVJHFr0o7QG1cp+dOf1QzGYYXimxh1IAfqCtFwgmWJA1PxdfqHwRjg7ABaEHUhls/2+GPr51slMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdNOh7F4JsFat+TNxw3ETb7BbxovM9FD+C54g1wOFy8=;
 b=GjSMsvYQVgyY68l+6qBvCUkLAMA7BFw9ac0gEEW5PbZGI6Xf5kXHbChgBL6LsgutZ7f00iLrlgX2OFUhtGnipuPW9F29ZTcVBMEhBQMErmvfSkPSD1kD5BD786EJSDVkiu9UjabjnXrihSuowMV6h0TDkBua0LVzu9CpzW0WvXs=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB3597.namprd15.prod.outlook.com (52.132.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 18:26:21 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 18:26:21 +0000
From:   Martin Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Topic: [PATCH bpf-next 5/5] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Index: AQHVr8uJHjjYCKu8w0m86brHGtC6Xqe207AA
Date:   Thu, 12 Dec 2019 18:26:20 +0000
Message-ID: <20191212182616.le7deuzfis2r2sah@kafai-mbp>
References: <cover.1576031228.git.rdna@fb.com>
 <829ef294f0395649f459334b48d4d9a6103a4fc1.1576031228.git.rdna@fb.com>
In-Reply-To: <829ef294f0395649f459334b48d4d9a6103a4fc1.1576031228.git.rdna@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:301:1::32) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::97ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65aa84b3-1d31-4469-9267-08d77f30c92c
x-ms-traffictypediagnostic: MN2PR15MB3597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB359711B993878A3BC7CADDCCD5550@MN2PR15MB3597.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(81156014)(54906003)(81166006)(66556008)(6506007)(64756008)(4326008)(66946007)(66446008)(316002)(66476007)(6636002)(478600001)(8676002)(71200400001)(186003)(6862004)(1076003)(6486002)(6512007)(9686003)(86362001)(5660300002)(2906002)(8936002)(52116002)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB3597;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GUjqCDfxpP9oJ+7DDXLSET0wGOlBdKjhPmC4L8EGv8ma4XFTVvYz9Y5rfoYaiq+qxtkhEE15W/CdrMjz82ZB9cBW92Mg1pCI/7z7WgHu5QDpvy/w4gb9Y1BdApmPomGoZ9ybb4KPpgEHuEx4SCyDaU7JgHDeoPw47ztaa0lXlpd0CakTYt9jFv1K6u5M0v4nNq+yjdYdFvAqJhsv53BIy/nK2rOkVr7iJzx949c+QFOdXeRWmTZZBrWlY1nLM8J91Zzh6BVhVtruD8hcn/T4W27of8Py/SAxMUKp7QWs1lWLEMNNrLVoef358Cf5+DrAiBqgoWPHJXCppq98MvgMLO/4KTXtpqdqt449dmRC7mau2DLAuhV8UFoE12qIjnb9pdX/MXnfHjzh/06V32+FAhsdc3WwiIBu8q92CHhQASmriNCFENHJ+L+yk6RLi/Xw
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB9E58D3C8C836469755BB305187F20F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aa84b3-1d31-4469-9267-08d77f30c92c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 18:26:20.8602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NuKSVRnsqPgRv1koFFcUFTcfMk7f0kPHrzxWiFW2upSYMBHjMvTqoaOG5lR+PbI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3597
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=764
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120141
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 10, 2019 at 06:33:31PM -0800, Andrey Ignatov wrote:
> Test replacement of a cgroup-bpf program attached with BPF_F_ALLOW_MULTI
> and possible failure modes: invalid combination of flags, invalid
> replace_bpf_fd, replacing a non-attachd to specified cgroup program.
>=20
> Example of program replacing:
>=20
>   # gdb -q ./test_cgroup_attach
>   Reading symbols from /data/users/rdna/bin/test_cgroup_attach...done.
>   ...
>   Breakpoint 1, test_multiprog () at test_cgroup_attach.c:442
>   442     test_cgroup_attach.c: No such file or directory.
>   (gdb)
>   [2]+  Stopped                 gdb -q ./test_cgroup_attach
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   35       egress          multi
>   36       egress          multi
>   # fg gdb -q ./test_cgroup_attach
>   c
>   Continuing.
>   Detaching after fork from child process 361.
>=20
>   Breakpoint 2, test_multiprog () at test_cgroup_attach.c:453
>   453     in test_cgroup_attach.c
>   (gdb)
>   [2]+  Stopped                 gdb -q ./test_cgroup_attach
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   41       egress          multi
>   36       egress          multi
>=20
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  .../selftests/bpf/test_cgroup_attach.c        | 61 +++++++++++++++++--
>  1 file changed, 56 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/test_cgroup_attach.c b/tools/tes=
ting/selftests/bpf/test_cgroup_attach.c
> index 7671909ee1cb..b9148d752207 100644
> --- a/tools/testing/selftests/bpf/test_cgroup_attach.c
> +++ b/tools/testing/selftests/bpf/test_cgroup_attach.c
> @@ -250,7 +250,7 @@ static int prog_load_cnt(int verdict, int val)
>  		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
>  		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
>  		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
> -		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 =3D 1 */
> +		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 =3D val */
>  		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0),=
 /* xadd r0 +=3D r1 */
> =20
>  		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
> @@ -290,11 +290,12 @@ static int test_multiprog(void)
>  {
>  	__u32 prog_ids[4], prog_cnt =3D 0, attach_flags, saved_prog_id;
>  	int cg1 =3D 0, cg2 =3D 0, cg3 =3D 0, cg4 =3D 0, cg5 =3D 0, key =3D 0;
> -	int drop_prog, allow_prog[6] =3D {}, rc =3D 0;
> +	int drop_prog, allow_prog[7] =3D {}, rc =3D 0;
> +	struct bpf_prog_attach_attr attach_attr;
>  	unsigned long long value;
>  	int i =3D 0;
> =20
> -	for (i =3D 0; i < 6; i++) {
> +	for (i =3D 0; i < ARRAY_SIZE(allow_prog); i++) {
>  		allow_prog[i] =3D prog_load_cnt(1, 1 << i);
>  		if (!allow_prog[i])
>  			goto err;
> @@ -400,6 +401,56 @@ static int test_multiprog(void)
>  	assert(bpf_map_lookup_elem(map_fd, &key, &value) =3D=3D 0);
>  	assert(value =3D=3D 1 + 2 + 8 + 16);
> =20
> +	/* invalid input */
> +
> +	memset(&attach_attr, 0, sizeof(attach_attr));
> +	attach_attr.target_fd		=3D cg1;
> +	attach_attr.prog_fd		=3D allow_prog[6];
> +	attach_attr.replace_prog_fd	=3D allow_prog[0];
> +	attach_attr.type		=3D BPF_CGROUP_INET_EGRESS;
> +	attach_attr.flags		=3D BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
> +
> +	if (!bpf_prog_attach_xattr(&attach_attr)) {
> +		log_err("Unexpected success with OVERRIDE | REPLACE");
> +		goto err;
> +	}
> +	assert(errno =3D=3D EINVAL);
> +
> +	attach_attr.flags =3D BPF_F_REPLACE;
> +	if (!bpf_prog_attach_xattr(&attach_attr)) {
> +		log_err("Unexpected success with REPLACE alone");
> +		goto err;
> +	}
> +	assert(errno =3D=3D EINVAL);
> +	attach_attr.flags =3D BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
> +
> +	attach_attr.replace_prog_fd =3D -1;
> +	if (!bpf_prog_attach_xattr(&attach_attr)) {
The whole set LGTM.  I expect this attach bit will change based on
the discussion in patch 4.


> +		log_err("Unexpected success with bad replace fd");
> +		goto err;
> +	}
