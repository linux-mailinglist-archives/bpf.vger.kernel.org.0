Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05B73159AC
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 23:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhBIWr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 17:47:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234416AbhBIWZi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 17:25:38 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 119LEBWu003043;
        Tue, 9 Feb 2021 13:19:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5ACI9TBgpNr/c4ymUf0vrzKFNe55vRnCP5Vb22jmTDs=;
 b=nqHEywYWMAp14aaOat3ZmwSKS1oLhxDKkZQMXGKuFX0pT3ifKErzCyZtJgu6/pXJy4LS
 8idDHPejk3dsHbpSsRiqH4j87q+QQx5Gs0iH1yYqSzXSsLtdwHWrlo6UHb3yaflPD6pj
 zPa+YA++qEeYUgXeSoC5PfR6OYvEbhgmEd8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36hqntgqy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 13:19:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 13:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUD/l4FXT8JrfQF+mMV9qv7Z/Xaz3VtRwbcrcKDDUbFjsMPcxgdyPjZ5xUNFTKeCF9F8DHXG8eovxq1HldJaxSyXBx73QUqKfK5He7bYZKX+SZ1nrxAoT1eEROWHedLtK++bA+tXKbbg3fcHHbQVAjTDaC/DVYqaoErZu3/O2kmDUp/TH8ouSAdCsuFOM5VLT7czwqYSNYYadwlmz4tpXtBWK43W5g3Dv+I2qVXP3ZHs56MnBrSipwkRYFw1wVZ/4/gznXi7Vbq+LzgpG6bqaVvrh6wuzPL5luy4EIgcHUm2dRQ3GbHrBzmnEqCS2BbIzX6S3LyuRYQQ5uME9cS33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ACI9TBgpNr/c4ymUf0vrzKFNe55vRnCP5Vb22jmTDs=;
 b=iOoSodJGUVxnRVgrZhWSTVlzColl/25KaOuknnu8M+pehbEiNVIdX/yPc3WpOb1wIOY43Ew1ozhd0axo5yinMJUFSmQKghacdk8b9wWjEAjs6A7IeMw5OQZito+eXkOnWCc6Q+bi5l56EeKIj/QnvCXlJ3Cqy79iGl4pNN8eLVEbyMR5pLdiyXr0KsmXkcpDvX+aQ0tvAUHK3y9ybNjKHJLkrp5+BKd+06mYAxhFlpXWmLxumKFK+LpYziAE9HoYESnhbI6YkyqFSBc3xPvru10J3pONicw9PF2FfkKVB5CSTfcQ5BX3YSHe0oGx1PJzlRLqt401WLl4+lSRJrtyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ACI9TBgpNr/c4ymUf0vrzKFNe55vRnCP5Vb22jmTDs=;
 b=L4+z8BpmGQtg18i8h4xonARkYwAOMv21Sg0DeD2HhVcqR2DezfQAv899MIHSpBct7KeZ9ohB7ruYoaZnzza70FdIxSmH+a+RARkIke36I7KnHInKQeDFhMrs398//q6GCUDCjN9yH2UmFTn6hdB8A9Bo/WP/ekm/uPvnOPLIozs=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 21:19:30 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 21:19:30 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Joe Perches <joe@perches.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v3] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Topic: [PATCH v3] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Index: AQHW/xIkjCL+hhYrfku+4kePe6r7yqpQLT8AgAAMdgCAAAPbAIAAFsyA
Date:   Tue, 9 Feb 2021 21:19:30 +0000
Message-ID: <3DA4D57D-C7A1-484B-B7AE-3F1DB958F4C8@fb.com>
References: <20210209183343.3929160-1-songliubraving@fb.com>
 <2b41e46fcf909bd67a578524107214fe4b1eeede.camel@perches.com>
 <4D649CDF-A738-468E-AD00-8A64DDB11D1D@fb.com>
 <fcf4561a8ab24bc4b22c536c55614fa0f0a924ec.camel@perches.com>
In-Reply-To: <fcf4561a8ab24bc4b22c536c55614fa0f0a924ec.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:3a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0f68fcf-36bf-4ef6-f1d4-08d8cd4063b6
x-ms-traffictypediagnostic: BY5PR15MB3668:
x-microsoft-antispam-prvs: <BY5PR15MB3668C9C2E4E435057E83C928B38E9@BY5PR15MB3668.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSsXDsVGhbeFORtO3wDoXXXBKYqOv1AkpwwQpzxQlGFeeck9Av5WdNe2CRTnqQ4n4lOHHMGN6XIY3FK1SprfVIPjJblooBstl/Eohss6hT0xpciTKSHqohzfhvDNo7PVSAc1/GJvX9tVuIgcFu26WETHzMKM3NcfufwauPPPJTTBXVw7UwENNwlsKh07XccHe7cOJT68nKk0EpnCIouEaYk/bxmYtzr68bMRnTd3t7go//JjbmOrZ3aOEBhG59otwDF3PifREuDMmWqdhcb9VD+PdhkG/ut875YK+CiByOiKG4GKhENBBD1wn5APNup+97MYE6D58bAH+3O33+R+mSZ5KjtCmRG1eVzyzJRjJW13WO0Xfvh2y1Wrecr/wtrzFnBPDb70bPca6atbQlTpCc8ZXkMDnoE37Y9I/DpDpWMIB2qmCQwwVS9SRUnyIgCpzNkcrTCbE5jiRBludfPSeDZqhGPSUR33Jepey+mGav5DLx5zmiLX5o82+gcKzwGKU/o3OGckt53KK3UOO0uwT0Rd5UO1d2sZWkJ5vAsZT4xyTa6wI3lNvVVjiKW7Zkm8Snbipppk3VXLfIcss3ZRzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(8676002)(316002)(6486002)(5660300002)(71200400001)(54906003)(186003)(478600001)(6512007)(4326008)(86362001)(33656002)(8936002)(36756003)(66946007)(2616005)(2906002)(66476007)(66556008)(64756008)(66446008)(6916009)(91956017)(76116006)(53546011)(6506007)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wTlF/mAoZhEx2oDAO/FPUpOrZEICQdzjZ8AXBgAFNj9MeDLVcnV4BvUK/PEV?=
 =?us-ascii?Q?/DOgYEx5lMDShhyMNCsdAHiw7T9FnUWMHP9gzsLCfzR78LEX6gBgByGFZUt0?=
 =?us-ascii?Q?qnoCYYbyoUjQXAg7KaWinkwf5np/UlFECpEYGlZzQs+11LhhzVL6ipBOVFSg?=
 =?us-ascii?Q?9AvrLOuhLSFNtr225FzV/XnjxSIhoZrHqBN78ISM7LKLkZrlB1KH3u1tSlXl?=
 =?us-ascii?Q?uXyiTkcAJxfemWvRCHn4SOvRlY1oA+UUV6s9ruC3cYBo8rKu0PYbV1UcjaBc?=
 =?us-ascii?Q?VzjqBgFefhBrNZn4a+xz3jiZML3tqBg0QPoz0r3OjbpmOcUESSIkHaRufsyR?=
 =?us-ascii?Q?MQxGuoV5g6p63o0UXTtCw+bXmJ1fsE0DUZmQTcnhDYS2MRT0W8K+lvNEym7c?=
 =?us-ascii?Q?c53ejPS3oqoGlT5F7VgpJxTEgPLn3RdV3Q7UzF9PbLj+PwhLaFC9ZHtDBtLU?=
 =?us-ascii?Q?bzzPxdVIEC2pitpbzCGwJc3eEhBoLbUCHzV+Cqm1ih7kPBeBWrbfjC6/eXY+?=
 =?us-ascii?Q?iEwXlGz9JLqTYdlMoci/zkqh9MKjIvZbZl1oKub15F5kMkiPJrjeFFbCZz7F?=
 =?us-ascii?Q?MBpb+GH5tw/Vcr3wqMIStA6BSt5VjKJRSVjn2THxlRDg+j9L9QzwBgVPmgEZ?=
 =?us-ascii?Q?u3QyAxANfaK2Ro971eZQm7DuWT3rkArc4ALEDyZBeEJpzBfsuyrHGRf5Ecyp?=
 =?us-ascii?Q?q7jNpHLuXI6fUC2Pkj94wG+iRqjpgwCFh4NZMYkeo/vtDlRDqNDZ8y1Aw7gA?=
 =?us-ascii?Q?TAFdO1vH4iUx7uOqlSk4UgFoal4Me9Qm/0noAqUkwRPFVzwrs6PTtgwivKnM?=
 =?us-ascii?Q?zd0khqq3KIdSAkZruU93teMq9hTEw/lGoYshUYbC8dX5vey1ldxY/ab/uqkj?=
 =?us-ascii?Q?ZtLA+9OPdBL5WKaz0FoaZ9wKxU265V/ZktgqqshkUhzRisULt9NQEmXhMhqy?=
 =?us-ascii?Q?ow9FZPxzPxJnKN2ecvGO+CbGCgzVRH6FUZdO3L05kZ+9qaPDKJcxM1XSc9aB?=
 =?us-ascii?Q?H4v8TLbdmkZzpGIOA5GhIZzKABkKOWGbf1gFaP4H0PxhHAD1YB0csfjmlFav?=
 =?us-ascii?Q?/dnxeTx6dk5a6hi0PGZCD84b/I85qROSdw6/l/ZVzMnzn/qiE4fh0JLDodkm?=
 =?us-ascii?Q?7MxnJwrziTZXOCXEKjnTZfDkTCH0oDluTJzrO8gfhB44RnBiOJNfnN1dbMwS?=
 =?us-ascii?Q?xjdpuPg9Scf2hrAklQp/8B+RXBocoEPkKLNpblNpmcyoO68ENRedulVyfY2a?=
 =?us-ascii?Q?OxvNcZXMkuotKhafJcZpKCJ3eK5+WJUB2Cw86nRhDjtjEFdrnE3JGioUPODF?=
 =?us-ascii?Q?6awBRevGrDVN3Wb9Dd3j/KDJ08Z8YssVsRDZDuEFyHs0RwdcaBeatokh+9E7?=
 =?us-ascii?Q?UmZ9g+8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8140CF68B4F37498FCC247CEED91721@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f68fcf-36bf-4ef6-f1d4-08d8cd4063b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 21:19:30.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPST97gYnmMMAtQkgQx6v2/iDXeaxIg5I1swCypYra0P755KbtGpkmWQ+4JZODQfKAHb5pu1QjP0hNGqFbyqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_07:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 9, 2021, at 11:57 AM, Joe Perches <joe@perches.com> wrote:
>=20
> On Tue, 2021-02-09 at 19:44 +0000, Song Liu wrote:
>>> On Feb 9, 2021, at 10:59 AM, Joe Perches <joe@perches.com> wrote:
>>> On Tue, 2021-02-09 at 10:33 -0800, Song Liu wrote:
>>>> BPF programs explicitly initialise global variables to 0 to make sure
>>>> clang (v10 or older) do not put the variables in the common section.
>>>> Skip "initialise globals to 0" check for BPF programs to elimiate erro=
r
>>>> messages like:
>>>>=20
>>>>     ERROR: do not initialise globals to 0
>>>>     #19: FILE: samples/bpf/tracex1_kern.c:21:
> []
>>>> ---
>>>> Changes v2 =3D> v3:
>>>>   1. Fix regex.
>>>=20
>>> Unfortunately, this has broken regexes...
>>>=20
>>>> Changes v1 =3D> v2:
>>>>   1. Add function exclude_global_initialisers() to keep the code clean=
.
>>>> ---
>>>>  scripts/checkpatch.pl | 12 +++++++++++-
>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> []
>>>> @@ -2428,6 +2428,15 @@ sub get_raw_comment {
>>>>  	return $comment;
>>>>  }
>>>>=20
>>>> +sub exclude_global_initialisers {
>>>> +	my ($realfile) =3D @_;
>>>> +
>>>> +	# Do not check for BPF programs (tools/testing/selftests/bpf/progs/*=
.c, samples/bpf/*_kern.c, *.bpf.c).
>>>> +	return $realfile =3D~ m@/^tools\/testing\/selftests\/bpf\/progs\/.*\=
.c@ ||
>>>=20
>>> You don't need to escape the / when using m@@, and this doesn't work
>>> given the leading / after @, and it should use a trailing $
>>>=20
>>> 	return $realfile =3D~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ ||
>>>=20
>>>> +		$realfile =3D~ m@^samples\/bpf\/.*_kern.c@ ||
>>>=20
>>> This is still missing an escape on the . before c@, and there's no
>>> trailing $ between c and @
>>>=20
>>> 		$realfile =3D~ m@^samples/bpf/.*_kern\.c$@ ||
>>>=20
>>>> +		$realfile =3D~ m@/bpf/.*\.bpf\.c$@;
>>>=20
>>> I believe I showed the correct regexes in my earlier reply.
>>=20
>> Just to be sure I got everything correct, does the follow look right?
>>=20
>>         return $realfile =3D~ m@^tools/testing/selftests/bpf/progs/.*\.c=
$@ ||
>>                 $realfile =3D~ m@^samples/bpf/.*_kern\.c$@ ||
>>                 $realfile =3D~ m@/bpf/.*\.bpf\.c$@;
>>=20
>> Thanks,
>> Song
>=20
> Looks right, you tell me though, this is the current -next file list
> for what is being suggested:
>=20
> $ git ls-files | \
>  perl -n -e 'print $_ if ($_ =3D~ m@^tools/testing/selftests/bpf/progs/.*=
\.c$@ ||
>                $_ =3D~ m@^samples/bpf/.*_kern\.c$@ ||
>                $_ =3D~ m@/bpf/.*\.bpf\.c$@);'

Thanks! This looks great.=20

Song

[...]

