Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37AD98CB4
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfHVHyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Aug 2019 03:54:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31242 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfHVHyk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Aug 2019 03:54:40 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7M7rDAQ014066;
        Thu, 22 Aug 2019 00:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=asebsleGK7BS9fcN0sbFoB+K9iif492vBVE8Xdi5FeQ=;
 b=CzG0Wk2hiwnX3ZvlUP5KvMLq5bXCo6EddrcdAkcv6GcXLsXzceJcbd4xM0tgAIElrXIX
 pKjGfBkgcb3Z/3qUyAvbY1qFMbMASM412bl/R6Ft3kQqSfMtLFelI/AmjknnL/+H9hIX
 8M8SHADGHbvNjLehwLL1Vqx/pGmewOIby0k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uhegj9kqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Aug 2019 00:54:20 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Aug 2019 00:54:19 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 22 Aug 2019 00:54:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwvSH3MaJAuQUZblhwSCxYPIOsGxw5zKRCiXXab5RFl5o6yc3EuWW+MnayHvb7ApgynF14VXRMUSfBKAX5TCPauIy4xn6qajJXrBf5UIv/tneTOo3n0GuY3H6LMLZ0H6aiN3FXoLfqg9lpoUbbKbkXnCRky7UVCrXz8LQJ4kAXU74I6nd0wudHaIRxROUSLl7/n4CmQGxHis4207Q/ZwaetW9kdmtPUni4m9LBNfGQoJYK430qxFLXLZ2/ityOAHGG0VvaXVqJJqabwE8o33iaGREt/VLRkAHcpb7H1BMVelpbBWToRsnPtcYmOfeZxsMXrqhjZlOB+xEbOboCRxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asebsleGK7BS9fcN0sbFoB+K9iif492vBVE8Xdi5FeQ=;
 b=D59uEi+FlyOfrW2/6hTkq5wfQpI7xI8gdbOZutnlhnxGo3u2E40KDzOROKdQdss//gA1MKdF0kHbRPURelJdDkzOfufLdDLu70oC9JJXPB2I9PVAlxmxt3O+DW0miXhi1pNoID2+GErs1UxRvONuBD51Jdsr+eIaw292bHTpEPlk1sGyerzZvzvSv/rkQ0mbJIs8ydqxBSe8qrN7RJxje78Fx7xTaTu1BBXR2Y/0dgcZaimQwTf5Msx4jyJzmeqo9T/6GO8GdHbJLidzmnOZi/+m9RhXArupQUdfsBidUNlIsBYmn++gm2Jr2QFR29hbrfwTnLsC67ZLAkmganIeyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asebsleGK7BS9fcN0sbFoB+K9iif492vBVE8Xdi5FeQ=;
 b=HDTkOQrxqeR49ENyDjKyi8HRe+R8pECuFtJ+qUbtVQQO5zRsGBgGg1ddJKnKuNkUxz74NX3AHDWOE9PZ96QNigfqw5pDYzK+tZEKeT0kacoLY95aV6jfpovl5fZKkPYcgyygK+D9Xbz5suu6/9HyR53ETP70lt+fhluyUt58DtI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1885.namprd15.prod.outlook.com (10.174.254.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 07:54:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 07:54:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Yonghong Song <yhs@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Thread-Topic: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Thread-Index: AQHVVIJ7G4XJ12jTyke2vfGd3/MIdKcEIq6AgAA2IICAAR/TAIAAYKGAgAAbI4CAAANTgIAA2v6AgAAB3AA=
Date:   Thu, 22 Aug 2019 07:54:16 +0000
Message-ID: <E9CB8C05-8972-4454-9D19-FA2D0D94F32D@fb.com>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
 <20190821183155.GE2349@hirez.programming.kicks-ass.net>
 <5ecdcd72-255d-26d1-baf3-dc64498753c2@fb.com>
 <20190822074737.GG2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190822074737.GG2349@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::e026]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cdcba2f-0c3e-4bff-3f28-08d726d5eea4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1885;
x-ms-traffictypediagnostic: MWHPR15MB1885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1885B41075E3CB544065DDACB3A50@MWHPR15MB1885.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(81166006)(6436002)(486006)(8936002)(50226002)(305945005)(53546011)(7736002)(8676002)(76176011)(6512007)(33656002)(36756003)(4744005)(446003)(186003)(46003)(11346002)(7416002)(2616005)(81156014)(102836004)(6506007)(229853002)(476003)(316002)(54906003)(256004)(6486002)(4326008)(86362001)(99286004)(57306001)(6246003)(2906002)(14454004)(25786009)(6916009)(5660300002)(71200400001)(71190400001)(6116002)(53936002)(64756008)(478600001)(66946007)(66556008)(76116006)(66446008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1885;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xxpOIh9lLSmcwDEpAlmVuonsMMF05icV2Qmc89Pept6ASvRENv4SKafzXmaMLrR7np2+FH1EEGvdDp9E4PDc41ym0MSLw57xl55Cr5TruPv81TOh52k3kh5Jbq5T3GkLU92TlQTiDDeq2JlMhqdrrbgc5ExeFYukrbOa2M36c82TDzJfZaHRRHchRgoLwZCFydJ07LWE1KLv9uOf3UtPF7mqQljaFwq66wzi2sJg5uyYIj7NdpqJ0IsoRfrtEVRuybDVnAVmHwgLl8Xo+bKjHrm4e7MjQ6iav+3z8VWgLgCcwLmcLFPfR9vR0Af/V2GjlSKSTyQJjQ9TL4pfIUMLNCStxu2aFFT6ZbdWYif+98SglzxGqZpJh1FzMxlBXiOKCgjtBGPK10uaQg68wDPoaYGm8nMUGi+bDinnn66/m44=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B02A8AEC4F72A14E9779D9B3EE834119@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdcba2f-0c3e-4bff-3f28-08d726d5eea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 07:54:16.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UulFcHtRBE8xLEXBvAHmU95EusYg9Kq0w5rgZNlAMXe6Z+gRrhKtL1rPcAT3nkecMLYrA5cuwueKanBZvD87w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1885
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220086
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,=20

> On Aug 22, 2019, at 12:47 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Wed, Aug 21, 2019 at 06:43:49PM +0000, Yonghong Song wrote:
>> On 8/21/19 11:31 AM, Peter Zijlstra wrote:
>=20
>>> So extending PERF_RECORD_LOST doesn't work. But PERF_FORMAT_LOST might
>>> still work fine; but you get to implement it for all software events.
>>=20
>> Could you give more specifics about PERF_FORMAT_LOST? Googling=20
>> "PERF_FORMAT_LOST" only yields two emails which we are discussing here :=
-(
>=20
> Look at what the other PERF_FORMAT_ flags do? Basically it is adding a
> field to the read(2) output.

Do we need to implement PERF_FORMAT_LOST for all software events? If user
space asks for PERF_FORMAT_LOST for events that do not support it, can we
just fail sys_perf_event_open()?

Thanks,
Song

