Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED33547A
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFDXlP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 19:41:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfFDXlP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jun 2019 19:41:15 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54NTfiW010846;
        Tue, 4 Jun 2019 16:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9C0O/3TkpE31t8a0y7iadKVGvG8tJM5jjyC0cyaSXho=;
 b=DCuSXDUjw8cJ5+VCgJSZitPSW/mflw7ea+ebzGt3PgKZ/Y1PAU9JgnMdAePlAMWWdQH4
 ZyMhYHMOna06ZTt1cgwLMxl9yYSM6QQxikIcmAO4mBWSVCK/g76rFa2YzxiVrBVlTsKQ
 dhcWqCdj9EHwskRLql83zJoJoSh/AeJpUX4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2swx190yf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 04 Jun 2019 16:40:53 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 4 Jun 2019 16:40:52 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 4 Jun 2019 16:40:52 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 4 Jun 2019 16:40:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C0O/3TkpE31t8a0y7iadKVGvG8tJM5jjyC0cyaSXho=;
 b=hUpPLNlYKDdixEKpr/N5KjGm48JRCPOddC6B3WwTfBtoxN0/6zFAwtqL3qBCnKqZD6GsoFMri8WTyEguy6QyfUVUtLKgIDD220EcPsp7CtBU5zAqvHdCRV/0AO2pP0TCixOlKXsWb0uKWHmubv8xGOjRSVk8hIgvkk6fK/bkctE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1486.namprd15.prod.outlook.com (10.173.228.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 23:40:51 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1965.011; Tue, 4 Jun 2019
 23:40:51 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hechao Li <hechaol@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Topic: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
Thread-Index: AQHVGyZgjmo/GFnnykecG1bG7fuNzqaMJ5QA
Date:   Tue, 4 Jun 2019 23:40:51 +0000
Message-ID: <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
References: <20190604223815.2487730-1-hechaol@fb.com>
In-Reply-To: <20190604223815.2487730-1-hechaol@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:e5b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e46de19a-5973-4c19-7cec-08d6e94613fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1486;
x-ms-traffictypediagnostic: MWHPR15MB1486:
x-microsoft-antispam-prvs: <MWHPR15MB1486E35226811107BE246921B3150@MWHPR15MB1486.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(346002)(366004)(199004)(189003)(229853002)(476003)(5660300002)(446003)(64756008)(73956011)(76116006)(2616005)(6116002)(186003)(102836004)(2906002)(50226002)(57306001)(81156014)(14454004)(66476007)(68736007)(6486002)(66946007)(66556008)(478600001)(66446008)(11346002)(6436002)(6512007)(53936002)(54906003)(8936002)(305945005)(8676002)(46003)(7736002)(83716004)(81166006)(33656002)(256004)(71190400001)(71200400001)(36756003)(25786009)(486006)(37006003)(6636002)(6246003)(82746002)(316002)(6862004)(99286004)(6506007)(76176011)(53546011)(4326008)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1486;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EYFYwYiia7Vm7CrhcIS/AKVIxr1v1m82U1keGumEUD5H9R/GgHoIrTKQm89AFeceGe/Y3aZhYF6zXjHQ62sc8Gyd1E/PCX33jZFXE2CTjmtZRuY/TGSiJxHeyIoBohue6rZvSTHhhdmKfFp+8xMZz68uEEkry0IWNSRhBHieyS9/bzPQeKPOUCdBOLJysLo7wh4aHgpm2lmBXWWFsZ+UBwO6qRo49PwF6J28QXXRVW9C7q3jlEbWnSI7qKIRErG4VexD0/JpKiZs/H9LUwNII6xxP7ex0CkG2RBjqfkCmowMe+wGqcjhUn6KW4jKllSg4hBN+fSYamwwF5HfGNX3hVprF3luCsddhOdQB4Bltf3ERA6rCJ1V5FhAde259box0ZPXl88jdhPsnzy2Dwp59ggML0a7u+i1FluYVdMfneM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23C05D72491AA340823BEE2A0DC2B62B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e46de19a-5973-4c19-7cec-08d6e94613fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 23:40:51.0619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1486
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040149
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Jun 4, 2019, at 3:38 PM, Hechao Li <hechaol@fb.com> wrote:
>=20
> Getting number of possible CPUs is commonly used for per-CPU BPF maps=20
> and perf_event_maps. Putting it into a common place can avoid duplicate=20
> implementations.
>=20
> Hechao Li (2):
>  Add bpf_num_possible_cpus to libbpf_util
>  Use bpf_num_possible_cpus in bpftool and selftests
>=20
> tools/bpf/bpftool/common.c                    | 53 ++--------------
> tools/lib/bpf/Build                           |  2 +-
> tools/lib/bpf/libbpf_util.c                   | 61 +++++++++++++++++++
> tools/lib/bpf/libbpf_util.h                   |  7 +++
> tools/testing/selftests/bpf/bpf_util.h        | 42 +++----------
> .../selftests/bpf/prog_tests/l4lb_all.c       |  2 +-
> .../selftests/bpf/prog_tests/xdp_noinline.c   |  2 +-
> tools/testing/selftests/bpf/test_btf.c        |  2 +-
> tools/testing/selftests/bpf/test_lru_map.c    |  2 +-
> tools/testing/selftests/bpf/test_maps.c       |  6 +-
> 10 files changed, 88 insertions(+), 91 deletions(-)
> create mode 100644 tools/lib/bpf/libbpf_util.c
>=20
> --=20
> 2.17.1
>=20

The change is mostly straightforward. However, I am not sure whether
they should be added to libbpf_util.h. Maybe libbpf.h is a better=20
place?

Daniel and Alexei, what's your recommendation here?=20

Thanks,
Song



