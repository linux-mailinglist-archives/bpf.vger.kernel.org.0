Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF57136BE3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 07:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFFFvk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 01:51:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbfFFFvk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 01:51:40 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x565i2Np028025;
        Wed, 5 Jun 2019 22:51:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Sw3jWeiB3kfHdaeroBp6byZg2GW/N4D2gLZHU447QNI=;
 b=Epmi02xKNBcETeQoeg/bVcM6vi9FXDE7T8DVu8aYFOzkGcj4K1zo12iW3sXqNByageL3
 CjU6myB5Hm2fp19/nsTpgUanVzpkRyGxkepN1GxO0zhGMEKiYmjhASC9OLXEnmCOfty/
 w0z1iX1GVGyIDNsbwzWXEyMbtnxCVYPVIpk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2sxptns1a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jun 2019 22:51:27 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Jun 2019 22:51:26 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Jun 2019 22:51:25 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Jun 2019 22:51:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw3jWeiB3kfHdaeroBp6byZg2GW/N4D2gLZHU447QNI=;
 b=dol3GJyzu4wL0SVOWqkkwJuo+jlNyVoQ2rK6cJD/1PIXaFA+kWu4af5N9Fvj/lUIs4HKHfxBT+ZaYr71bXOY5OfWVWul4sfbQyZZ5K8jlzKGPNVjz8wjrg8RSPGfjQuYbckr4XesOwqyvDNmr3zrhwEmHzQynI2id4Zf14EY028=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1343.namprd15.prod.outlook.com (10.175.3.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 05:51:24 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 05:51:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hechao Li <hechaol@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/2] bpf: use libbpf_num_possible_cpus in bpftool and
 selftests
Thread-Topic: [PATCH 2/2] bpf: use libbpf_num_possible_cpus in bpftool and
 selftests
Thread-Index: AQHVG/Sr87pEIk3A9Uas4SL2HQpeWaaOH9SA
Date:   Thu, 6 Jun 2019 05:51:24 +0000
Message-ID: <3B2F53E3-2268-4D65-86AC-A35086FDB232@fb.com>
References: <20190605231506.2983988-1-hechaol@fb.com>
 <20190605231506.2983988-3-hechaol@fb.com>
In-Reply-To: <20190605231506.2983988-3-hechaol@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:efa5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a378720-1fe3-47a8-ebaa-08d6ea430255
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1343;
x-ms-traffictypediagnostic: MWHPR15MB1343:
x-microsoft-antispam-prvs: <MWHPR15MB1343C89B951F7C8FFF8406CAB3170@MWHPR15MB1343.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(346002)(136003)(189003)(199004)(57306001)(37006003)(36756003)(6246003)(446003)(102836004)(478600001)(8676002)(53936002)(99286004)(8936002)(476003)(11346002)(2616005)(54906003)(81156014)(33656002)(46003)(486006)(81166006)(4326008)(6862004)(14454004)(71200400001)(83716004)(25786009)(229853002)(66946007)(53546011)(256004)(6506007)(6436002)(73956011)(71190400001)(64756008)(50226002)(6116002)(76116006)(5660300002)(66556008)(7736002)(6636002)(66476007)(6512007)(68736007)(186003)(66446008)(316002)(76176011)(86362001)(82746002)(2906002)(305945005)(6486002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1343;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qkmTFhGSQCK7tb1aklbxMgTaNtGMvDtvhNyQIxNskFDdn2gZPBD/SNnS0waqazFZCBeobvaUTdN6vEkD+4Yl5WupCTVdl/t8r8nJDHkFSci9j2xUsNZN6kgrq6GhVV1bJOmqf1qeausF2ByvQeT0l/0NuCU6vdylD+GzGarWzXq5Qtx+mfIo6nuIrk4tBKkHby5ea5+f8zslvP2d8KGSQtyxeK65ZOGKYjHRgdkY1o2kA04zFL6jxWo6YA/aX+UTY9Ni/t5byxUJvIEbzBWSDNjxUHVNErdDF9/UaLL6W4Isqzsi2LK+7h2ySRd6+ntzD29WnWfQvca3Ev+Rxj/PpZPI4mVF1sBXiu8A9MLV0wI39OJJ7CmzqkGzEBlJWuR8ZsTg1iajcUmHoaB8dQ9nUR+/4tBYruxaSZN+mvUyLyo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5FE88F92F727E048841366584BE25C84@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a378720-1fe3-47a8-ebaa-08d6ea430255
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 05:51:24.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1343
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060043
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jun 5, 2019, at 4:15 PM, Hechao Li <hechaol@fb.com> wrote:
>=20
> Use the newly added bpf_num_possible_cpus() in bpftool and selftests
> and remove duplicate implementations.
>=20
> Signed-off-by: Hechao Li <hechaol@fb.com>
> ---
> tools/bpf/bpftool/common.c             | 53 +++-----------------------
> tools/testing/selftests/bpf/bpf_util.h | 37 +++---------------
> 2 files changed, 10 insertions(+), 80 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index f7261fad45c1..0b1c56758cd9 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -21,6 +21,7 @@
> #include <sys/vfs.h>
>=20
> #include <bpf.h>
> +#include <libbpf.h> /* libbpf_num_possible_cpus */
>=20
> #include "main.h"
>=20
> @@ -439,57 +440,13 @@ unsigned int get_page_size(void)
>=20
> unsigned int get_possible_cpus(void)
> {
> -	static unsigned int result;
> -	char buf[128];
> -	long int n;
> -	char *ptr;
> -	int fd;
> -
> -	if (result)
> -		return result;
> -
> -	fd =3D open("/sys/devices/system/cpu/possible", O_RDONLY);
> -	if (fd < 0) {
> -		p_err("can't open sysfs possible cpus");
> -		exit(-1);
> -	}
> -
> -	n =3D read(fd, buf, sizeof(buf));
> -	if (n < 2) {
> -		p_err("can't read sysfs possible cpus");
> -		exit(-1);
> -	}
> -	close(fd);
> +	int cpus =3D libbpf_num_possible_cpus();
>=20
> -	if (n =3D=3D sizeof(buf)) {
> -		p_err("read sysfs possible cpus overflow");
> +	if (cpus <=3D 0) {
> +		p_err("can't get # of possible cpus");
> 		exit(-1);
> 	}
> -
> -	ptr =3D buf;
> -	n =3D 0;
> -	while (*ptr && *ptr !=3D '\n') {
> -		unsigned int a, b;
> -
> -		if (sscanf(ptr, "%u-%u", &a, &b) =3D=3D 2) {
> -			n +=3D b - a + 1;
> -
> -			ptr =3D strchr(ptr, '-') + 1;
> -		} else if (sscanf(ptr, "%u", &a) =3D=3D 1) {
> -			n++;
> -		} else {
> -			assert(0);
> -		}
> -
> -		while (isdigit(*ptr))
> -			ptr++;
> -		if (*ptr =3D=3D ',')
> -			ptr++;
> -	}
> -
> -	result =3D n;
> -
> -	return result;
> +	return cpus;
> }
>=20
> static char *
> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selft=
ests/bpf/bpf_util.h
> index a29206ebbd13..9ad9c7595f93 100644
> --- a/tools/testing/selftests/bpf/bpf_util.h
> +++ b/tools/testing/selftests/bpf/bpf_util.h
> @@ -6,44 +6,17 @@
> #include <stdlib.h>
> #include <string.h>
> #include <errno.h>
> +#include <libbpf.h>
>=20
> static inline unsigned int bpf_num_possible_cpus(void)
> {
> -	static const char *fcpu =3D "/sys/devices/system/cpu/possible";
> -	unsigned int start, end, possible_cpus =3D 0;
> -	char buff[128];
> -	FILE *fp;
> -	int len, n, i, j =3D 0;
> +	int possible_cpus =3D libbpf_num_possible_cpus();
>=20
> -	fp =3D fopen(fcpu, "r");
> -	if (!fp) {
> -		printf("Failed to open %s: '%s'!\n", fcpu, strerror(errno));
> +	if (possible_cpus <=3D 0) {
> +		printf("Failed to get # of possible cpus: '%s'!\n",
> +		       strerror(-possible_cpus));

This is not correct. The -possible_cpus is not errno, so we cannot=20
use it with strerror().=20

I guess we can just go with

	printf("Failed to get # of possible cpus!\n");

Thanks,
Song

> 		exit(1);
> 	}
> -
> -	if (!fgets(buff, sizeof(buff), fp)) {
> -		printf("Failed to read %s!\n", fcpu);
> -		exit(1);
> -	}
> -
> -	len =3D strlen(buff);
> -	for (i =3D 0; i <=3D len; i++) {
> -		if (buff[i] =3D=3D ',' || buff[i] =3D=3D '\0') {
> -			buff[i] =3D '\0';
> -			n =3D sscanf(&buff[j], "%u-%u", &start, &end);
> -			if (n <=3D 0) {
> -				printf("Failed to retrieve # possible CPUs!\n");
> -				exit(1);
> -			} else if (n =3D=3D 1) {
> -				end =3D start;
> -			}
> -			possible_cpus +=3D end - start + 1;
> -			j =3D i + 1;
> -		}
> -	}
> -
> -	fclose(fp);
> -
> 	return possible_cpus;
> }
>=20
> --=20
> 2.17.1
>=20

