Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80F1521FB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2020 22:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgBDVfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 16:35:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727389AbgBDVfI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Feb 2020 16:35:08 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014LUnY6029265;
        Tue, 4 Feb 2020 13:35:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WbrlJHrNAdx5s5d533/c52s/Z5RlbojyEEA4yeo4C9w=;
 b=WoSW77gmE7ObjHvMxYjxFk3Q6VVS2WO81S/1prIT39ra0gUoGUHbguoyTgw1g6IqZlHj
 /7syHqQbh3sHdTzziiyUUKUpJJlTMMxqsdKrc9YwxZTpC3zts5/HOhvYdO3M7I1XE9Iy
 Rb25VzBP1+wogjLZVoxnnNYoOLaRU3t+56g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xy6ywb1ce-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Feb 2020 13:35:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Feb 2020 13:35:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCKp+shpO6E2saE51xQp4Rx/1BTaEUWuLwBwgRPbGwjIy2HF9oF6YPbJFmS/ZW78g6zQC6ibfzZq4AXTSJcOc9+YGBQfUcKn99vsN8HqvoO2iv1of5WESRnio6KB69QqXyKwa5gbVkarOoVZxlln9ATfEyZGmFPBrgHcY2eMArL8d41dEkf00SH1ZyaG+PeFfV/c5uazBvxHinCDEAotuOK2mZ2DGR9X4TNbVrdKJYCV28ExMae6hR8Jr65GMfx8tpGdgNU8BfFX83o7WU4tZF1ZRPyiUEzxObRuxafVd1D/hTF34Up/1uqNcms0Ck4Zbz15GKLCGQ0j1qmEraM3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbrlJHrNAdx5s5d533/c52s/Z5RlbojyEEA4yeo4C9w=;
 b=ngtgHOiRlLbi3cmvbsazUsrI0A3eiavDEo+3BktlTRdOJFge7BegL8JbI+N9xWhAD5guSBZhKjmkleXWqcKJChekHHp3ALu1ekA4Vhzl+Kxg8hidjIhNX0fxc0bfmcFdKtZ8/Hdhe37xuTS+SeFUP6Op2JJmXE2SnU4QG+185/zhKM+XcdfX5mDCK0Xoms4jmS5mBJI6w8parmA7vtAhgwxYhmZUeN1ZJqQvcpcEQV3oioa8vIEiIIDfZfgUsDNlr83rwrCoK/pLJFPY2fXX8iKhe+2ivytr6QT+X51GjQShCZodjiimqGTm14eUAOOqLUICCbUmVHnrpfyWA0vRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbrlJHrNAdx5s5d533/c52s/Z5RlbojyEEA4yeo4C9w=;
 b=XFWaK2C9Msq/TpCWXck2cNOnr1RwvwdJRSSyIS1o7Q2XBBW5op4EGQrb9oJSnptQgaNTQf1WPSeOZ75q9M9yDI/yWZmpIa919/apR06twi05NsVSM9nBbfoCC4VNkqbTsfC/H1k4RiN9qnsRji+lcFY3McP9xt5gE80c56siLSs=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2613.namprd15.prod.outlook.com (20.179.155.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Tue, 4 Feb 2020 21:35:01 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 21:35:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH] tools/bpf/runqslower: Rebuild libbpf.a on libbpf source
 change
Thread-Topic: [PATCH] tools/bpf/runqslower: Rebuild libbpf.a on libbpf source
 change
Thread-Index: AQHV24P7S/8cRMVEvUCPjDEMoe9Zw6gLXtmAgAAwBgA=
Date:   Tue, 4 Feb 2020 21:35:01 +0000
Message-ID: <8BE57865-79D3-42B2-978A-116CD0142FFB@fb.com>
References: <20200204175303.1423782-1-songliubraving@fb.com>
 <CAEf4BzabT41Ls3CLmv9Vb-X_5NLwbMiQLLiNoK34svjKt4BxfA@mail.gmail.com>
In-Reply-To: <CAEf4BzabT41Ls3CLmv9Vb-X_5NLwbMiQLLiNoK34svjKt4BxfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:180::9337]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 590b6b75-75af-47ab-da4f-08d7a9ba1713
x-ms-traffictypediagnostic: BYAPR15MB2613:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB261319E734F1F3D751BB0779B3030@BYAPR15MB2613.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(6486002)(86362001)(6916009)(36756003)(33656002)(186003)(4326008)(5660300002)(66946007)(66556008)(64756008)(66476007)(91956017)(76116006)(71200400001)(66446008)(2616005)(8676002)(8936002)(81156014)(54906003)(81166006)(53546011)(316002)(2906002)(478600001)(6512007)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2613;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUbRRPCjPIltUL4txYD/kVmDI+/YTsE3P5y0M8EGkMHakh9kiXziBrArOuTP/v3IJxyUCrM+MmRyyJPcPkpWN0MfWYUACvD5YkiUqpDNvHW3Ok0t22r9foqm7Z//OtkNwc0w8czF6RJJK8Ync0OIdrVuStxfA3+yDwUple0xPCeMC+nvprY1zS28QNJbEwQhcR4SdgLPNegqiYgrjHw/3dY4iiYHHSNTYliXUnx2aIQdBfCdUG5WVg6qjix1BCI0Kr3yKAwVsU2xMDtjmDJIX8hCbJQZLiEZpwx4OisBmMgxn0L3ZS11duBpeqdYyrnkar0lTC+4U5YZA9V6CUHKZngYn7VEUWmcETSBILZ4UhdjexNzcRlmSNSo5Q+4kkvwamCdX37psyUhrhh2++B67YXeTSxy5LTSbbLvcw62H1bq3NBaB5riUwAwIriI8VtV
x-ms-exchange-antispam-messagedata: 70SaYjRqX9gbQsAVT9893BMm3EnuBdqjcrKDrlv+NjOTqQVroVM0krmyGcGsui+4HOFlZaC4WD+yRhxAFzv2h8bGqR7CYt87wdLlaXcnzfSJhOkosuLXd6akIz1r9H3wzB+x/CDdSXUv9CBTj3g/m2hYN20DN/I0/l1xlKc9oAg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14FF743E2D9C784390DC422C1C4A0F9F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 590b6b75-75af-47ab-da4f-08d7a9ba1713
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 21:35:01.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfnkGKRavJMWxvdMj+zT4QP/HSUqGpIHoVQcEeTrfOoPUK8/RCbYktBGXHDYeUcPtgqthGIPGmnL41tMDWgIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2613
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_08:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 mlxlogscore=932 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040147
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 4, 2020, at 10:43 AM, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
>=20
> On Tue, Feb 4, 2020 at 9:54 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>> Add missing dependency of $(BPFOBJ) to $(LIBBPF_SRC), so that running ma=
ke
>> in runqslower/ will rebuild libbpf.a when there is change in libbpf/.
>>=20
>> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
>> Cc: Andrii Nakryiko <andriin@fb.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/bpf/runqslower/Makefile | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index 87eae5be9bcd..ea89fcb6d68f 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -75,7 +75,7 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $=
(BPFTOOL)
>>        fi
>>        $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
>>=20
>> -$(BPFOBJ): | $(OUTPUT)
>> +$(BPFOBJ): $(LIBBPF_SRC) | $(OUTPUT)
>=20
> Let's instead update this rule to do what selftests/bpf do (watch *.c,
> *.h and Makefile, and use all + install_headers to build libbpf and
> generate bpf_helper_defs.h?

Do you mean:

diff --git c/tools/bpf/runqslower/Makefile w/tools/bpf/runqslower/Makefile
index 87eae5be9bcd..39edd68afa8e 100644
--- c/tools/bpf/runqslower/Makefile
+++ w/tools/bpf/runqslower/Makefile
@@ -75,7 +75,7 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BP=
FTOOL)
        fi
        $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@

-$(BPFOBJ): | $(OUTPUT)
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUT=
PUT)
        $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)                     =
    \
                    OUTPUT=3D$(abspath $(dir $@))/ $(abspath $@)

>=20
> Please also specify (in subject) which tree (bpf or bpf-next) you are tar=
geting.

Aha, I started with "bpf: runqslower:". Then I some how changed it to=20
tools/bpf/runquslower. Will fix.=20

Thanks,
Song

