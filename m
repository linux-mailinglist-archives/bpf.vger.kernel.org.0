Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01C636BD0
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFFFor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 01:44:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47356 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbfFFFor (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 01:44:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x565hs0d017237;
        Wed, 5 Jun 2019 22:44:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KGL3Meifio5ExMMzdnupyym0z9YoUJSIgL8MODlLM44=;
 b=jcXk4O79IzPe0rQx/PUP7WWMskSUUa8kEQhPEdhWf8C9UWJkIvaI8px81KEOg93Pgrxl
 IyVUPtJQxr0iOlJlfssSvIXH8lQdD+W5Cj/LOfC+Tch2doiQybqfEqwEX1b6vHTWL2hR
 JYhS/9OOYyJzfyQrBAYvnGAbwzWUnZdO6dM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sxuce08u8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 22:44:26 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 5 Jun 2019 22:44:24 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 5 Jun 2019 22:44:24 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Jun 2019 22:44:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGL3Meifio5ExMMzdnupyym0z9YoUJSIgL8MODlLM44=;
 b=YYvuxJrYDnjuNQlCknVP9ejQceSy7njhJlN4YBG24vDJXUPVnX8bsTn/ziqFbO8S8nNI5+KPcKcfLOwULvM6hx5KUBREoB50hohZU5w9Y11j1icVOYW2Zu15XL7GNT7pj2vFQhlJtH8r3lI4L77Va/q7rrJldQH6Em5nIYcDdI4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1727.namprd15.prod.outlook.com (10.174.96.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 05:44:09 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 05:44:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hechao Li <hechaol@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/2] bpf: add a new API libbpf_num_possible_cpus()
Thread-Topic: [PATCH 1/2] bpf: add a new API libbpf_num_possible_cpus()
Thread-Index: AQHVG/Sjx5LYvVUEN0GE11rCGjvrAaaOHc4A
Date:   Thu, 6 Jun 2019 05:44:09 +0000
Message-ID: <7A5FA7F0-AD1C-401B-A1F6-EB46BF9E93B7@fb.com>
References: <20190605231506.2983988-1-hechaol@fb.com>
 <20190605231506.2983988-2-hechaol@fb.com>
In-Reply-To: <20190605231506.2983988-2-hechaol@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:efa5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe918246-380f-49c4-9e07-08d6ea41ff4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1727;
x-ms-traffictypediagnostic: MWHPR15MB1727:
x-microsoft-antispam-prvs: <MWHPR15MB1727F53E0A690CE003654601B3170@MWHPR15MB1727.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(366004)(376002)(346002)(199004)(189003)(50226002)(36756003)(6436002)(66446008)(66476007)(186003)(25786009)(6506007)(64756008)(53546011)(66946007)(57306001)(66556008)(6512007)(76116006)(99286004)(82746002)(76176011)(102836004)(5660300002)(229853002)(53936002)(86362001)(73956011)(37006003)(81166006)(6116002)(14444005)(6486002)(256004)(7736002)(71200400001)(8936002)(316002)(71190400001)(305945005)(6246003)(83716004)(6862004)(8676002)(486006)(54906003)(46003)(14454004)(6636002)(446003)(476003)(2616005)(478600001)(68736007)(11346002)(4326008)(81156014)(33656002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1727;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: exnSLfCot2C2YM02TIyaieoWLT47C3fvSxguNe8vgZOcM8Y6Ki0kbwkw3PK0M3tuyCsj12yCWAgSU4/gVvLe3vT2xxBgpQfsaBkimbvZPNpVyaOYG4fA/w+5cTujkzeG9dFybRlMCIKJwOxbIXOQjxoYSq6QXyENmUQGCQZG8814nSf9x81TkEYvM4dN6Wh7Xq4dougdWaX8TAZcl2h0zenY/WbZ0VXGQqpgUpS5k0fqBGE1LylLVr2fn4wuXGPwULWP6AdxCCk/RhpgykMX1KvOl+zTJyVGASnMWPSeKrKgPT1AwTcy1Crgqyjlo3bzfFJmqWWSAMI8C6Gq8v6ZPJIf8+2a8TMKT2HscI5klEIAmQvUUns8jX33sp42kPOIUsFMKsoAliyLybcA9b4f9RZAojg/WTl0EkqAHbt/ToQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E13D97AAFF309249A83B201184AA7E41@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe918246-380f-49c4-9e07-08d6ea41ff4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 05:44:09.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1727
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
> Adding a new API libbpf_num_possible_cpus() that helps user with
> per-CPU map operations.
>=20
> Signed-off-by: Hechao Li <hechaol@fb.com>
> ---
> tools/lib/bpf/libbpf.c   | 49 ++++++++++++++++++++++++++++++++++++++++
> tools/lib/bpf/libbpf.h   | 16 +++++++++++++
> tools/lib/bpf/libbpf.map |  1 +
> 3 files changed, 66 insertions(+)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ba89d9727137..580b14307237 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3827,3 +3827,52 @@ void bpf_program__bpil_offs_to_addr(struct bpf_pro=
g_info_linear *info_linear)
> 					     desc->array_offset, addr);
> 	}
> }
> +
> +int libbpf_num_possible_cpus(void)
> +{
> +	static const char *fcpu =3D "/sys/devices/system/cpu/possible";
> +	static int cpus;
> +	char buf[128];
> +	int len =3D 0, n =3D 0, il =3D 0, ir =3D 0;
> +	int fd =3D -1;
> +	unsigned int start =3D 0, end =3D 0;
> +
> +	if (cpus > 0)
> +		return cpus;
> +
> +	fd =3D open(fcpu, O_RDONLY);
> +	if (fd < 0) {
> +		pr_warning("Failed to open file %s\n", fcpu);
> +		return -errno;
> +	}
> +	len =3D read(fd, buf, sizeof(buf));
> +	close(fd);
> +	if (len <=3D 0) {
> +		pr_warning("Failed to read number of possible cpus from %s\n",
> +			   fcpu);
> +		return -errno;
> +	}
> +	if (len =3D=3D sizeof(buf)) {
> +		pr_warning("File: %s size overflow\n", fcpu);
> +		return -EOVERFLOW;
> +	}
> +	buf[len] =3D '\0';
> +
> +	for (ir =3D 0, cpus =3D 0; ir <=3D len; ir++) {
> +		/* Each sub string separated by ',' has format \d+-\d+ or \d+ */
> +		if (buf[ir] =3D=3D ',' || buf[ir] =3D=3D '\0') {
> +			buf[ir] =3D '\0';
> +			n =3D sscanf(&buf[il], "%u-%u", &start, &end);
> +			if (n <=3D 0) {
> +				pr_warning("Failed to get # CPUs from %s\n",
> +					   &buf[il]);
> +				return -EINVAL;
> +			} else if (n =3D=3D 1) {
> +				end =3D start;
> +			}
> +			cpus +=3D end - start + 1;
> +			il =3D ir + 1;
> +		}
> +	}
> +	return cpus;
> +}
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 1af0d48178c8..f5e82eb2e5d4 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -454,6 +454,22 @@ bpf_program__bpil_addr_to_offs(struct bpf_prog_info_=
linear *info_linear);
> LIBBPF_API void
> bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
>=20
> +/*
> + * A helper function to get the number of possible CPUs before looking u=
p
> + * per-CPU maps. Negative errno is returned on failure.
> + *
> + * Example usage:
> + *
> + *     int ncpus =3D libbpf_num_possible_cpus();
> + *     if (ncpus <=3D 0) {
> + *          // error handling
> + *     }
> + *     long values[ncpus];
> + *     bpf_map_lookup_elem(per_cpu_map_fd, key, values);
> + *
> + */
> +LIBBPF_API int libbpf_num_possible_cpus(void);
> +
> #ifdef __cplusplus
> } /* extern "C" */
> #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 46dcda89df21..7f76d19cb02b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -172,4 +172,5 @@ LIBBPF_0.0.4 {
> 		btf_dump__new;
> 		btf__parse_elf;
> 		bpf_object__load_xattr;
> +    libbpf_num_possible_cpus;

Please indent with tab instead of space.=20

Thanks,
Song

> } LIBBPF_0.0.3;
> --=20
> 2.17.1
>=20

