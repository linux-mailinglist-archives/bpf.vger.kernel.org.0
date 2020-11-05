Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599822A861F
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKESab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 13:30:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKESab (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 13:30:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5IU4Kn027446;
        Thu, 5 Nov 2020 10:30:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=oY0ToNE0y+u3G5NPrllVdo9GsLJigMN/dFeiQTA3hk8=;
 b=qtYZ8GnyTqsftzti5gRKybgaho/GGp8RPThg+3wP10HFf+4C+4DOZqtaxEZGijMGSdVp
 xSBJu5DhtJD1JUIgtOPXj7rHojNsnTSt1hz/lJVoe+uZE4IyXP9dF8W23bzphWgmR5/K
 2xcm1xO4pxwz4te+9HP2hTil/7QdDQhi0ns= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34m81m4c55-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 10:30:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 10:30:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T44fN7eLq4cO1p9/gy/MuaZphUsN8eGZx5fqB1n8TA1AHit2PaMxAnMY9bqmQF7BnjML469xYztZySRkxKv4EMXqBr6wi040irqdLLewiwtNw38k2u+1kikO/fMCIx8k/rG8Hi6Wlr2O9p0iPulB0QE+5ubK796gYASVE/zudy3SDUqkgHCrZwutMZLvu+oSKGmacEQoPG4d/2J/qYcBNQMY/OVk+H1HSudHnNNVelYKMOgdVRDKpZmQu5nt4KSiMycNSzJZ/Nr5rCEvFZnU3PObkQUFofL47O9UMV8rgYBJ8IXj22rMb7Idg9CffeIhK2zqUkHqWkOvwII1tdxz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY0ToNE0y+u3G5NPrllVdo9GsLJigMN/dFeiQTA3hk8=;
 b=WEpi2dV2vvE/wDz5FULRXe+W11RgwmNplGAsYGYRalQHSc8MIGVT3e4xizzTF0hQL1wh0X/KsvUVR5jvE+TZa/z1EKP6i/bDayIV2iAGpzn1CHNAhVE0vn4DNzHv79zNv+73VBc36BybPNZOiJk7HWBY22fecmfV4VSwFP8zpEatsVwC61kHKl37XupoYGWd0e1zbjbrUqBt6LjNHe8upPu+PpPGBCsFrV6AqwAof96sUe/4XuLzprjzoYonNltW3Wmrt6a2AFHZoB0czdQrwKHfXtdfdEyhZQCilh9oI7rGM79cPTdLgrCXE9j8Px5R520t3IizZvI2Vc6VSvPULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY0ToNE0y+u3G5NPrllVdo9GsLJigMN/dFeiQTA3hk8=;
 b=KAqj8dSSXYm+R+coRQeVegseMtXRCLEqnf7h1pM9vaf8AAXieX626UC3FfKIaorYiPuZTRAsg7WbscehkSMTY33NfgGCKHD2ovnOlvMlLS3AKUJ1PGs8qCDn08rZcWWIPL2LIq1DFH151sR8dchv28mFmiTh0bgbjj3F/ANqkWw=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2646.namprd15.prod.outlook.com (2603:10b6:a03:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 18:30:08 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Thu, 5 Nov 2020
 18:30:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
Thread-Topic: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
Thread-Index: AQHWsxsKExRyW1CBMkWOL7EY14SiVKm53SiA
Date:   Thu, 5 Nov 2020 18:30:08 +0000
Message-ID: <B9A62DF7-8C1B-448C-8672-0AF6FC1773BE@fb.com>
References: <cover.1604542786.git.dxu@dxuuu.xyz>
 <4e3e8b9b525c8bed39c0ee2aa68f2dff701f56a4.1604542786.git.dxu@dxuuu.xyz>
In-Reply-To: <4e3e8b9b525c8bed39c0ee2aa68f2dff701f56a4.1604542786.git.dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: dxuuu.xyz; dkim=none (message not signed)
 header.d=none;dxuuu.xyz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e47254ed-1771-43ea-24ba-08d881b8d311
x-ms-traffictypediagnostic: BYAPR15MB2646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2646636F91D7CEB7C22FB8FBB3EE0@BYAPR15MB2646.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: REbl8JQ8qxZmEP55lQ2jZL6gxF6w0nIiICDjFNkRPw7+9D/kqSrkNRqiDeNns0RSUfh0YGJ7RVIR2vDW1hlZxs7PVzq4AAvkvrYl7fGb9VmyC2vX9XvDFdmY6/9wEHRRtYAT0QD1PZgBtD4uVVwyo6PJp57SkgzdoVuvQkyizC914SzCF1I80158cOuDkH3c361rNbv+6h6vsQsqgm7DYx2Gm+1bOxq38ZJ6qquJvu1v8q4pCLbMlHHB5ThUg6AyKyK0xGVJDl0l6LaZqKaiR1bT5pvDw+rp5bFpGr+ZXjInzr+0sCKNSmL3jKdhQeSwAl7yh/ViGalEah9V9iLMHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(6512007)(6506007)(2616005)(53546011)(36756003)(186003)(71200400001)(4326008)(8676002)(8936002)(76116006)(91956017)(66476007)(316002)(83380400001)(33656002)(6486002)(478600001)(86362001)(54906003)(66946007)(5660300002)(2906002)(6916009)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KJM8MVDRwcv2NIzgprHdEENiriLUePW6VhHo/LJ8MOZd4tdTEA/G1p+uujMJ+koY4ZftlD5rf4HjT1StxoRu06QlvBv1az+WBm2KnJfUf4h0Wx1suCy9W5nL8fJLmQGsQT1EdQsoHUtQ8T/Mg9rUphHyiM7alRlg7w+pJ73CGjoxsjmBtHiyJLObLs1fuHbkzAY/I8ZLRLajPOYYpFrq62MwBDJb5QPLy297yvGiEM6qGx+ibbzqE1A+aGzqOUr2xm43JXTTqj+Tfc0olxCng+aOY27CIGQM1xeXzV5iQY/tWDFdMQwvtBTwaTpPFdJx7QiCuE7rmxaOJTajxu8l1hx+PiG6Ml/ESflBOhV5G1+DhTJJXcBbWPeW/gEAuZt73uHPcYcXcWs+2nKZoDPP9EP5HFss8XmFqXHz38s7yt9VgwtwSqIv6ZtITCCgr2G3B2JWibTMMU9hKWfpwgbbO/wfCMTblA/SPxYWot0wmK1ucWmqK5p2HAzDq5STMlXzqdb4SATpglUmV/rj5+IvTLCoGUehJMboNKoEKMnsl116kQxhlLU9yJbwoTRC0pHKL+EeSbPur7UsqUcDnSfo1dgmBioO0IEa1YdXVRd7RiCKlMrkHA0T+8RwU7AKRzWI9L3ODdhHYpOM9lO4ySxutctJ8cXEmhaclSYXIUqW+lYEwx36HZaXemMs0+mTxY1A
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7980FD980A33A48A137B5D06A39C0CB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47254ed-1771-43ea-24ba-08d881b8d311
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 18:30:08.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buF8G2BIjncz9SNmPZRnFdL1aPs8r08s4shrxds04P/+FSCESrhBq8CxCqlXqdN7rDK4q/ba+k8Ak9G2sslY8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_11:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 4, 2020, at 6:25 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>=20
> Previously, bpf_probe_read_user_str() could potentially overcopy the
> trailing bytes after the NUL due to how do_strncpy_from_user() does the
> copy in long-sized strides. The issue has been fixed in the previous
> commit.
>=20
> This commit adds a selftest that ensures we don't regress
> bpf_probe_read_user_str() again.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> .../bpf/prog_tests/probe_read_user_str.c      | 60 +++++++++++++++++++
> .../bpf/progs/test_probe_read_user_str.c      | 34 +++++++++++
> 2 files changed, 94 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user=
_str.c
> create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user=
_str.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c=
 b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> new file mode 100644
> index 000000000000..597a166e6c8d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "test_probe_read_user_str.skel.h"
> +
> +static const char str[] =3D "mestring";
> +
> +void test_probe_read_user_str(void)
> +{
> +	struct test_probe_read_user_str *skel;
> +	int fd, err, duration =3D 0;
> +	char buf[256];
> +	ssize_t n;
> +
> +	skel =3D test_probe_read_user_str__open_and_load();
> +	if (CHECK(!skel, "test_probe_read_user_str__open_and_load",
> +		  "skeleton open and load failed\n"))
> +		goto out;

nit: we can just return here.=20

> +
> +	err =3D test_probe_read_user_str__attach(skel);
> +	if (CHECK(err, "test_probe_read_user_str__attach",
> +		  "skeleton attach failed: %d\n", err))
> +		goto out;
> +
> +	fd =3D open("/dev/null", O_WRONLY);
> +	if (CHECK(fd < 0, "open", "open /dev/null failed: %d\n", fd))
> +		goto out;
> +
> +	/* Give pid to bpf prog so it doesn't read from anyone else */
> +	skel->bss->pid =3D getpid();

It is better to set pid before attaching skel.=20

> +
> +	/* Ensure bytes after string are ones */
> +	memset(buf, 1, sizeof(buf));
> +	memcpy(buf, str, sizeof(str));
> +
> +	/* Trigger tracepoint */
> +	n =3D write(fd, buf, sizeof(buf));
> +	if (CHECK(n !=3D sizeof(buf), "write", "write failed: %ld\n", n))
> +		goto fd_out;
> +
> +	/* Did helper fail? */
> +	if (CHECK(skel->bss->ret < 0, "prog ret", "prog returned: %d\n",

In most cases, we use underscore instead of spaces in the second argument=20
of CHECK(). IOW, please use "prog_ret" instead of "prog ret".=20

> +		  skel->bss->ret))
> +		goto fd_out;
> +
> +	/* Check that string was copied correctly */
> +	err =3D memcmp(skel->bss->buf, str, sizeof(str));
> +	if (CHECK(err, "memcmp", "prog copied wrong string"))
> +		goto fd_out;
> +
> +	/* Now check that no extra trailing bytes were copied */
> +	memset(buf, 0, sizeof(buf));
> +	err =3D memcmp(skel->bss->buf + sizeof(str), buf, sizeof(buf) - sizeof(=
str));
> +	if (CHECK(err, "memcmp", "trailing bytes were not stripped"))
> +		goto fd_out;
> +
> +fd_out:
> +	close(fd);
> +out:
> +	test_probe_read_user_str__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c=
 b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> new file mode 100644
> index 000000000000..41c3e296566e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#include <sys/types.h>
> +
> +struct sys_enter_write_args {
> +	unsigned long long pad;
> +	int syscall_nr;
> +	int pad1; /* 4 byte hole */
> +	unsigned int fd;
> +	int pad2; /* 4 byte hole */
> +	const char *buf;
> +	size_t count;
> +};
> +
> +pid_t pid =3D 0;
> +int ret =3D 0;
> +char buf[256] =3D {};
> +
> +SEC("tracepoint/syscalls/sys_enter_write")
> +int on_write(struct sys_enter_write_args *ctx)
> +{
> +	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	ret =3D bpf_probe_read_user_str(buf, sizeof(buf), ctx->buf);

bpf_probe_read_user_str() returns "long". Let's use "long ret;"

> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --=20
> 2.28.0
>=20

