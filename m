Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0622A5A20
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgKCWcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 17:32:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10476 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729342AbgKCWcp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 17:32:45 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3MTg16032489;
        Tue, 3 Nov 2020 14:32:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xN/j3kE1habmbGzknw/wiX12j+9vV0kegFWIcmRga8k=;
 b=OyI3AZs3gM0O4dSP9uHYTD08/CR1c1cidEiDtO4/Cv1R/12JWTHN2qp9jl95Q+amZ3eZ
 ZAxDXRx1vlvmfkYcPlHJmBLF5cJWAOzN9oNUjydSm+EY/DUsseMsD5hQmg4vhvgHiF8V
 HFGdlWjmSm/qMl07tEJMRb9xPr2/XPs6rGg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34kbn79t61-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 14:32:26 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 14:32:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ModlqfI6cDy124LGcz73AXGAPNR+I7CdmQ4pk9rGl7yUrryuKsWcorebeUrfpklrQeT0t/9Qu2kgiO2ejQsPfijK6jnKCpYX8fFoZHIauSeyQPc+h3wbJz4dnSYFFaf2FEnUoF7eoVU+IUCyN0b7beL5PKA+KDUnRST40lEjexHLQeW3ot9QvZw8diw0lKlzLVTd2MKXdd658d8VPUGvoIWw+OBnXEd2D1j2AyfCkqIimNzQQzdoue1bG/5IXiF1Rf1WPyunplw0JviP12Rj7eRRNnkMdkNrxGpwI9tH43hVzPL9LJwAWOO9RtO70rLl2RzAuXbN7MYJz5xP0/pftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN/j3kE1habmbGzknw/wiX12j+9vV0kegFWIcmRga8k=;
 b=Qc+xpL0nM15Hyp2Xt75bM06713fbT7TDyIaBpxjf0XE+bAyF4+oXeCaTqfB7/1/r2wx6L2xMEgxP9l8gry960tNl1KHDhn1yGO6eMhL6lU9w97QqR/iz+j8MD3MZZimeqWyINirZHBSS2i73odC0Cs1z1eu8MnbnnPEmhNbFdzMugl75VoFGbnQ0738YG6rRPlX5euHBfhLlx4LIO8f5zNMXn7l+V7DFTL2nVV5LjyoY2Gbd0KWYZVzszze0X87xL8y58Jk0sX9FxTLFGN/gb8QjxGtwh/1H/uwxgvYR+HsnpwOPRPWelmW/XNQdblkxU3BZYtbX4b7He5eyZG2D9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN/j3kE1habmbGzknw/wiX12j+9vV0kegFWIcmRga8k=;
 b=RqnGwGf5ohT364cO5R3Y75oqE2NPVUmVdTz2dcCU7C38a0c1jK4lrAr7jo1ihFS5unzBcwQMSEdwkOrAz4iJYE+LbH5fwrOCikBdREfBAwLbvEI490/y/skexBUjoPYH1yAubpkEtsQZfQ5fOZCR+i1rRiqUEgx4GtQFMMMsm2A=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4201.namprd15.prod.outlook.com (2603:10b6:a03:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 22:32:22 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 22:32:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 8/8] bpf: Exercise syscall operations for
 inode and sk storage
Thread-Topic: [PATCH bpf-next v2 8/8] bpf: Exercise syscall operations for
 inode and sk storage
Thread-Index: AQHWsfZ0AWfn5qTOiE+YXq7wcYjogKm2/nUA
Date:   Tue, 3 Nov 2020 22:32:22 +0000
Message-ID: <87AD7DC4-63DD-4DE2-B035-A3FA2D708601@fb.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-9-kpsingh@chromium.org>
In-Reply-To: <20201103153132.2717326-9-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11e13445-7b34-4dab-5ea9-08d8804854ea
x-ms-traffictypediagnostic: SJ0PR15MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB4201D59A0A2CD11705268486B3110@SJ0PR15MB4201.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:277;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBV6UJM2WDzXbY1IkZ+eDK9PDwknoWBEX7qPqGabWtko8wIneqepxoL/eVihPIdk4Tz3tuDwDS6tKTr5GV4uQfKHAc+bNL7IOQTPjwN12LxTbCnitJO59wWU0lFkYsGsm9rcTXMr5RdTn1Ar6Key7eSC1km4doe/4dAGB76ofrVL56ib4NuW6cN5ab81EkNJcSt0hCkBZicLM7kWK1+6s/zcM9VVGfOvr1ApQPXReo9MCiw2k7LMnrCbnznNvz5V2+II6AMbovAkC5GBS9VIl6/t54bWNsjVb00V6FI0DvsT22sZW3WTD+I7E6lhbAKB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(6512007)(33656002)(316002)(4326008)(83380400001)(2906002)(54906003)(66476007)(64756008)(66446008)(71200400001)(36756003)(2616005)(91956017)(6916009)(8676002)(66946007)(66556008)(186003)(86362001)(8936002)(6506007)(53546011)(5660300002)(478600001)(6486002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6/5ZPp11YXJ0Icy6x8OVNzDcscqukbgGdvmZT6AmgZWGs7O1dq/JmsHHTqP5vP3vM27c51tYxsscIzTd9Gi+aUweELhY/LWIikYwHh8SFE1l59n/3XxdC/kRaSBbUthVaxmw/eazV4JYVaCTIDWoPoD6ya9M6/PINR1s8veMa67pKmjzRs6NT9BwAZT/mVptDrU5ISZZzxxURIVnfWopaXC04w7xV8yFo+jMeicpJuUlaTYroXYRob8zo/4PjDbTDloEzgJeBKq+5DOS95WmEbu1jMwTKna5hwXDpRvTUViccNre6BMOZTLpnGVhRKgrGkLa/q7tNyNJ3R40vWAIp/RaROnLUeF2W7VQu4lB1jpVDJnQtZSv3LF64I1TuXvy0R24ulx0OYozmFadnXOHkxVDEICDKdS2g0iWd7rZ863CfB6Oo8Ryq6IAkZ/d9Nnkm+4IFXFbH36FVAwQJFkrefYIrFxqCPRhMWyvHDL3KqqVxWSecOHe4MYR6tmPcL6L3JZfHuOW3XliU4zW47I7sR8a2ZXBaev3LIGzRh6R3dwhZgH5r58kNN2W/YE00o+lvjph1oQJ7b3+/DpS3c7qHf/Ylc/XZKT463U73fo0VDeikWTBFsO6G/6RgyWjjPL1QxYrPAfAgZJXivEfdeFfD1Jtv84mlB4k8T14pnuBQ+/O+UC6jqPA0ccUK7oGUvbh
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88717C2F7F722C418D28B9EECFC59359@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e13445-7b34-4dab-5ea9-08d8804854ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 22:32:22.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+6sSnoomRI73KqluSXSbiXAxDOQE9IqjP/ZOkdmEawlSOWiiyEBltrrhFGZg+M2Z14Kh7I/DKNeSd9649PAQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4201
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_16:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1011 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011030147
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> From: KP Singh <kpsingh@google.com>

A short commit log would be great...

>=20
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
> .../bpf/prog_tests/test_local_storage.c          | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> index feba23f8848b..2e64baabb50d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> @@ -145,7 +145,7 @@ bool check_syscall_operations(int map_fd, int obj_fd)
> void test_test_local_storage(void)
> {
> 	char tmp_exec_path[PATH_MAX] =3D "/tmp/copy_of_rmXXXXXX";
> -	int err, serv_sk =3D -1, task_fd =3D -1;
> +	int err, serv_sk =3D -1, task_fd =3D -1, rm_fd =3D -1;
> 	struct local_storage *skel =3D NULL;
>=20
> 	skel =3D local_storage__open_and_load();
> @@ -169,6 +169,15 @@ void test_test_local_storage(void)
> 	if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
> 		goto close_prog;
>=20
> +	rm_fd =3D open(tmp_exec_path, O_RDONLY);
> +	if (CHECK(rm_fd < 0, "open", "failed to open %s err:%d, errno:%d",
> +		  tmp_exec_path, rm_fd, errno))
> +		goto close_prog;
> +
> +	if (!check_syscall_operations(bpf_map__fd(skel->maps.inode_storage_map)=
,
> +				      rm_fd))
> +		goto close_prog;
> +
> 	/* Sets skel->bss->monitored_pid to the pid of the forked child
> 	 * forks a child process that executes tmp_exec_path and tries to
> 	 * unlink its executable. This operation should be denied by the loaded
> @@ -197,9 +206,14 @@ void test_test_local_storage(void)
> 	CHECK(skel->data->sk_storage_result !=3D 0, "sk_storage_result",
> 	      "sk_local_storage not set\n");
>=20
> +	if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_map),
> +				      serv_sk))
> +		goto close_prog;

We shouldn't need this goto, otherwise we may leak serv_sk.=20

> +
> 	close(serv_sk);
>=20
> close_prog:
> +	close(rm_fd);
> 	close(task_fd);
> 	local_storage__destroy(skel);
> }
> --=20
> 2.29.1.341.ge80a0c044ae-goog
>=20

