Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC53AF34EC
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfKGQrS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:47:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22682 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfKGQrS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 11:47:18 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7GiTNG020094;
        Thu, 7 Nov 2019 08:47:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/tsuQw4Vv3VGTg/t2jV3mfJcPenthkebb7Ak1nCRQiw=;
 b=dl/KlLSjAlpQFYfg9/SCLNw7dl7wJrVsKtb1QMXhs5/3GmKbJ337P+RmaaMS++uAA5LO
 JFB2Mre7ZtIisXyuo9LhzX9vxFBUcbKMiSns8tWrK/A/ld4bHKkK/EhSl7oCJV+hKDTC
 gqN+94Z64x6E64vbRgIZESS/YUd3tprXz6Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41u0p3gm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Nov 2019 08:47:05 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 08:47:04 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 08:47:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV9KdRzPkAvbijCzU3hmIOAUyKadpzukHdO6lcj8gl1jpxZApCzsdQE+SVNc0aUSZdWNKCSe2iEj75QDbWWmpaG8+sar9OAKnkAfqCarS4VkdjFnOkAh/XxgnRfSDGHkUk8ielIZjCY24BO35SohMWqtg7gsx88SlUn7QwRLJeY//O6ECx7U84FKTTkckD02Xn8OFp38FTasBqGWJrm1zj8sp/vf6lTKxlehiH1+vaD3uEJT2QRfEIr688U1JraRNrxU+yyD2Ka9RreM2/9vxoKvtajOH+lo+tu84CRmdD2UJcZsqqqOnkUeU60m9oThaGGvydbU9Q4vDYz7RU0ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tsuQw4Vv3VGTg/t2jV3mfJcPenthkebb7Ak1nCRQiw=;
 b=Oh2X5rquF9a0rJN51B9/SODYxBBZFyNV5XpQ1uP232sxBTm4G+5uPIw7eFE0FqH1e/ntHskWBhG3hogVk80meAW52GqxySFhRx7YtBUIZE8LNaVOKXeHAMudcfd9axf4HBue5lcvi7MrrMDGUEn0Hppps7rtK+rR2lYVQqFKUbIDwsOjhbz7YC8rryRgpP5/X2/IAT0B1cqCoMAvLCuP4nnNsmlka6VB9FuGJdXOHa/KIYKBurrxJIAQFWe2C+qOmfYpz3Zfts25qh0Twy32ogCCYD7BixzeLK+1fyQ5Uxs2VaSYhSsxGwa5QR+PrJJK5k8+f17GEziSP4nm9WJ6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tsuQw4Vv3VGTg/t2jV3mfJcPenthkebb7Ak1nCRQiw=;
 b=h3MpPFmAD6XHRb7oLGz5Fdz09RqUq9kxYHjzqdsZuddKcFEORINwPFhlXhJDhxFhhCpVA8M3RWV6ROBY7S/wj6M0aN/90SHxBLwSEKw/JQ7lGpf/02JtFt3QEPnHtquj7q322O/4s8aXPa+BDmA1RRDxQTy89MLZlxVS5vE5ozs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1117.namprd15.prod.outlook.com (10.175.9.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 16:46:59 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 16:46:58 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] [tools/bpf] workaround a verifier failure for
 test_progs
Thread-Topic: [PATCH bpf-next] [tools/bpf] workaround a verifier failure for
 test_progs
Thread-Index: AQHVlTO2Ae0Ajsj980aiA/WHTbd1oKd/64kA
Date:   Thu, 7 Nov 2019 16:46:58 +0000
Message-ID: <0F024920-8525-4366-86FE-CD2CFEA7E30E@fb.com>
References: <20191107062153.512850-1-yhs@fb.com>
In-Reply-To: <20191107062153.512850-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::1:11cf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f9a957f-7f72-4f45-2e04-08d763a21b42
x-ms-traffictypediagnostic: MWHPR15MB1117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB111763CED689D91F9D19DECAB3780@MWHPR15MB1117.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(5660300002)(6636002)(6116002)(37006003)(53546011)(316002)(33656002)(186003)(7736002)(4326008)(99286004)(478600001)(6506007)(14454004)(54906003)(2906002)(76176011)(102836004)(305945005)(256004)(71200400001)(6512007)(71190400001)(229853002)(14444005)(36756003)(6436002)(8936002)(25786009)(8676002)(66446008)(2616005)(486006)(476003)(6246003)(64756008)(66946007)(11346002)(50226002)(6486002)(66556008)(66476007)(81156014)(6862004)(81166006)(446003)(86362001)(46003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1117;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/ypPTlEKgRpYoVr+9jcrcQHgDdjZ2CHTcg9Optp2uAl/wzXGr/4+yGMq6uOGhedxyQXqsDtYxWksNYczl0SDf0egClutdpdNVDihGVlVSxDwSAszeEYK50AWyAsMgDGsOuBBESgvI6HVKZszD40WIjbMlPU50T1WUpJlhQIod/zJNqA4sqRTTyZvGtzkHFOkiSKdFCJEkcqrPa1JFDmMcE+HGzuftjBnrfT5YJV64K/0m6enIt/fM/c5zoqboT7uHEYNrYurXjIpndvV4uNNBGnRv2Du8PZSKnp9K7M2htOnceOcz9J7q2RlogMnBXvPLnWSQO0pWuMQt3fe95EwT7hD0cieLjQzgW4euCC9Q66z1gmV27oZFjuNXWfcErKKr+abCrCW6B5cXazeXCo9uCdC/8eLMpmnSevllHtXDXKnZFqatKTwpQIe2jmKmgj
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF96FD91C6FDD64DA07FE8128A683446@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9a957f-7f72-4f45-2e04-08d763a21b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 16:46:58.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZs0cWEWXrEcwIyM7S8rg2MipeHSvwiwyTqHi7Gah2Vr1KQMUaeJCqbhy7y05heALlZq/DxUcqZZFj5fja78uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1117
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=862
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070157
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 6, 2019, at 10:21 PM, Yonghong Song <yhs@fb.com> wrote:
>=20
> With latest llvm compiler, running test_progs will have
> the following verifier failure for test_sysctl_loop1.o:
>  libbpf: load bpf program failed: Permission denied
>  libbpf: -- BEGIN DUMP LOG ---
>  libbpf:
>  invalid indirect read from stack var_off (0x0; 0xff)+196 size 7
>  ...
>  libbpf: -- END LOG --
>  libbpf: failed to load program 'cgroup/sysctl'
>  libbpf: failed to load object 'test_sysctl_loop1.o'
>=20
> The related bytecodes look below:
>  0000000000000308 LBB0_8:
>      97:       r4 =3D r10
>      98:       r4 +=3D -288
>      99:       r4 +=3D r7
>     100:       w8 &=3D 255
>     101:       r1 =3D r10
>     102:       r1 +=3D -488
>     103:       r1 +=3D r8
>     104:       r2 =3D 7
>     105:       r3 =3D 0
>     106:       call 106
>     107:       w1 =3D w0
>     108:       w1 +=3D -1
>     109:       if w1 > 6 goto -24 <LBB0_5>
>     110:       w0 +=3D w8
>     111:       r7 +=3D 8
>     112:       w8 =3D w0
>     113:       if r7 !=3D 224 goto -17 <LBB0_8>
> and source code:
>     for (i =3D 0; i < ARRAY_SIZE(tcp_mem); ++i) {
>             ret =3D bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
>                               tcp_mem + i);
>             if (ret <=3D 0 || ret > MAX_ULONG_STR_LEN)
>                     return 0;
>             off +=3D ret & MAX_ULONG_STR_LEN;
>     }
> Current verifier is not able to conclude register w8 at
> insn 110 has a range of 1 to 7, which caused later
> verifier complaint.
>=20
> Let us workaound this issue until we found a compiler and/or
> verifier solution. The workaround in this patch is
> to make variable 'ret' volatile, which will force a reload
> and then '&' operation to ensure better value range.
> With this patch, I got:
>  #3/17 test_sysctl_loop1.o:OK
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>

Could you please add the byte code after the patch to the commit
log?=20

Thanks,
Song
