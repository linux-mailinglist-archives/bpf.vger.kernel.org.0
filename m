Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E8315621
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 19:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhBISiZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 13:38:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48820 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233412AbhBIS1F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 13:27:05 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119INQxE022762;
        Tue, 9 Feb 2021 10:24:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JbxOA/2hr/+bb2VFQxkrPfj2i0Z/uiZQZdWv1t6gx+8=;
 b=rcaC2plkRqCVUSHWkHJRO6g2Xlz/7svknJcfoYPMRfcI1F8+Mlt37eopMjlrHe3g31Uh
 yjOQUJ2roJ9HcZLypTdTNfywy7fQF0DB8t5+RZiXCFLtYwSe0gCg+r/QRWVGH25ojwBs
 OjOH/gdUfAuKXOYiEJdceA1R9PTCgGS7ess= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hstpfb36-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 10:24:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 10:24:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr+Ulk3QUwiUcmllk/XDlqQpBeR6P+0q4X21kM+uzfnYqDcoBBTrusBHZ0cfsNOoBCbWsR2NmS+5YmNRolrZ3MXwoN5QomwAh+b2IeGCaQYSwK5Vf8IRJAJxbOJ8331u38eNjOPfbi4mfoJmfV3mM5/YCDsbsGmAP+q+TuEn5k/h+Ct/azyFgAnFJVFhgSwmGL0n6W26kbpEhsHcC62CBghTq0JedqDtlZk2oaN7n45P2SzA4ZBito4uWD4M2RO2WD0ig1KGl+fDsabF3LVnh8GZdK/UWL3D9+n9iiSBe7a7VZgWrjkpmY19fTeJhIbd8dR87v5Mmns5Rlubjbg85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbxOA/2hr/+bb2VFQxkrPfj2i0Z/uiZQZdWv1t6gx+8=;
 b=nBclx0EJ/+DGP70sln/l1V8Rj/9r3AGgNOaymnVBwNNx0zfOc2Df667VJGx1mcCSC1owLZClAxKMIpfGB4FZGyahXZ4ejSGOTm6PGihaQXlMePNYJXWQ2o41fqP7P69ChcCmAaTu2e9rAqEt49SFlc1kWanvGaH8pgU//vwjgF7zDr+cr2duRSIu7sH1tX4UcDDmdm1+OBOswv+JBSsYTUT8w1pm+LUcTGVRLpfwy1CILwZ1j3NmwZGOH9sTm3egy4lFUiguitLIzrHBPCNMpcCv30oRLYpkA31PZziD8Q3LIy9nrg37riaaBgcLOAjDug/H82/rhgeMOq2fxGIF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbxOA/2hr/+bb2VFQxkrPfj2i0Z/uiZQZdWv1t6gx+8=;
 b=acdyQI24GC9UPHYhTpW4TJ7kmJ+zD7TL+O1PSlMAqx6ydY/E7MB5wGOR2lSNA+oUpFxZLFR3ShaBKK6+pu4/IcSLh/MwbEXSO5gIrGU7+1FDxBMHN9wEajteYy/Bq6JWwpvfK1BLPF99N46JT2qCxRWVudWh0GfvCQEaCRb1rDI=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4422.namprd15.prod.outlook.com (2603:10b6:a03:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 9 Feb
 2021 18:24:43 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 18:24:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Joe Perches <joe@perches.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Topic: [PATCH v2] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Index: AQHW/wUWEqKr+kgS3kSy6M0AnYll5apQEr2AgAAQ4oA=
Date:   Tue, 9 Feb 2021 18:24:42 +0000
Message-ID: <9A955431-E33F-4AEB-8D3F-74032E55CA0A@fb.com>
References: <20210209170013.3475063-1-songliubraving@fb.com>
 <f20f16691faba583f8d8970e02827c88dd9fb49e.camel@perches.com>
In-Reply-To: <f20f16691faba583f8d8970e02827c88dd9fb49e.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:3a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d254b54e-a78c-419b-0d78-08d8cd27f895
x-ms-traffictypediagnostic: SJ0PR15MB4422:
x-microsoft-antispam-prvs: <SJ0PR15MB4422BF6CDBDEA5EDB5D5F1EAB38E9@SJ0PR15MB4422.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0ohmzLD0HTWN+3DsGaL1Qksx1tX+zlFBB2mRznU/SWYT8LT5QyQv4py/eQGSMfDFz3KL2Oeq1tKC8Rx/sI7IMBTFtJRmea7Vulzq5xaSJ4aaJg7uv66J08MTDR5qrM7z5hzthroxvO40fLO0fCM8vZOWBuOpqFNZC3FlHcoEyPlOE6/AIm7aEoXkFdJ4LGBgB+PhggWqBz6ty9l+PW5Z5OoXvEaLjb7gagg1osMJ5VrrQQVDWe0LHQXDqJGwa3wRgBBdUS97JpOBkJIiXnTxwc8Az+xbYsXWaqh7qd4tVf5k9AJzMtmwv/UnMoZTIYxzDnjaHd8D0EtKiJasbqYBHlxtb0IAFz/6OQQzhYKhi9WylffTEMSiqu/6HSQ9GcW1m9IY+ZdM11LnmcUy9Pa3MPTDG+GtET4GEpX2WcY5+BON7xvBOzvV3ORtrChDhftdjfClst+SVVmeMRqhPbup/BwREoS5G4TJaM4PdWDuVc5A/wCilhsSwG/bRAmLqsOIDauatz1jXLcelsunFii0bq3AgYbeWNfzeOwHBQu3uzuZZf4Dcb8QSmuIC5hanftgXADetQmoZPujeidElsAUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(346002)(136003)(91956017)(66946007)(76116006)(71200400001)(2906002)(33656002)(66446008)(64756008)(66556008)(66476007)(54906003)(53546011)(8676002)(83380400001)(6486002)(316002)(478600001)(8936002)(6512007)(6506007)(36756003)(86362001)(2616005)(6916009)(4326008)(5660300002)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4LrCRm7CmM4qW+C72MtSlULJ7/2CnKEH/S2k6UmLgeaV0sRkHHzL7meV5StG?=
 =?us-ascii?Q?VkdkzvNovZZXjeBV1YkW+GnfjYah4x70AWnE28lSYTfswzsjKZ5Jhu6SlUue?=
 =?us-ascii?Q?XxVpECDnj4D1Xd9z8EmjQdNzjKLNxWeIjbYJNW/HG3kktNo829C5GZHeavA9?=
 =?us-ascii?Q?3OOr7c9yCuhamxJE+/Dy74GkLu43vqluCj9nZUvUxaYmrkl18AwsHwpxgRTb?=
 =?us-ascii?Q?tdv/yBjpw257uajkRRn6mKdJ/hGixa8nc0Dvo/Uy1tJhOybjlPkcw7Ddn+Yb?=
 =?us-ascii?Q?p7a7OCZJzvDwVQuoQ4Q9LTgV2sLoEIKGZdeBnG5F6ufZc1+CiXZsZu2DK80M?=
 =?us-ascii?Q?q9VwE/NgRuCmdwnLi+3raa15XaUohROzP+0UpcWei0kbZ2pNjbK232voSfpg?=
 =?us-ascii?Q?pRusBHBsqx8Jh2OjjmSSUpLoxwQ+8pDxMVXA7iBiFzYOVmA/w4+hApJGV9ir?=
 =?us-ascii?Q?SepYCTXEbSIrgQvKLwaqTJ9I2+6VgsMSyNOeMIQPL+WPTJ/kYTN1Zek8zqal?=
 =?us-ascii?Q?ixM/H42x4rQ/k5Y9Jr5yMtVrTG7EM1v6KucHW9JlcStcCp09Na6Xq+dwsK5Y?=
 =?us-ascii?Q?bc7vDkjHlfYN0CYfhEQvjlP4C6Lgr1MaZxN27POmHaYBRZ03vcsydUF3fYtY?=
 =?us-ascii?Q?shTrEIycskMNErxCFydddxj83xeWsNFXdV/PMWoCi0Ul/RSSpc6QwtscGBqP?=
 =?us-ascii?Q?JrGhcX1AYinI+zMflj3Pm/Mh4Olo94mrH93Vj7Xf5KSrca9lW34SkyVRHQEP?=
 =?us-ascii?Q?v5qSUk5o33ZwubYfjVH1sjy5XnoZxlJ9LILbsxp5tZj8vEl/t/eTLP9+SdGB?=
 =?us-ascii?Q?tq48hc5WQGvsdunh4FhR6bqk8Dga0FoIBEPXKrwyuOWQnaftP2oUib3RQ+ys?=
 =?us-ascii?Q?4vaRrXUsaPt5D/kzRb8hDG4JWGfTCWgzPSVEc7XDZa5w83VgKCMvzE7dum1n?=
 =?us-ascii?Q?2hnhaIKtmMhZiSK3hXiwy9GJ4CQdFEjHUzapC8QaZSNM/JKBQBBSwxh8oOME?=
 =?us-ascii?Q?P3FBr5lX+TVMeEf7NodOOZoHUb90hGigWHTNld1gMxNAt8xx7+xj5fQj78PH?=
 =?us-ascii?Q?mgTauAHrnuQaEOLhH6ght6p6OuM0m7zyepD8VNHJa6SyhLI5oEIcExfEayO8?=
 =?us-ascii?Q?m/ZQgOL4552VixIv9GXxd1Fcg6uF/9rFG6quSU9Ng7fa2+gW+bPHuqSukau0?=
 =?us-ascii?Q?hBOMWoStIyK4p/al28YNN2eUoA2gLqguFSJNirycX3FdsFoqt0chbw6yrQng?=
 =?us-ascii?Q?CsKvsoDyKiLHeqD6Efr/6kM3RkBGsTKT1TrgmOUbdBdUNuE5ESGEtAHgyjZf?=
 =?us-ascii?Q?/NX8pwb3C8QxNGOApRs4EvCsKPO/n/wYVeobghkd/1tD7vC3o2pkMVVxwtAv?=
 =?us-ascii?Q?e4vcuRA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4077750120C1794FA110D54F37214A7F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d254b54e-a78c-419b-0d78-08d8cd27f895
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 18:24:42.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BC1oJDSRuE1EVj+bRRA1YlwXeMHE83eKp75lzwpuAXCFlt2Z18M8HefDzjU4N2Zr4g6Z4Olvi/VHvQEe90OD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4422
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_06:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102090088
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 9, 2021, at 9:24 AM, Joe Perches <joe@perches.com> wrote:
>=20
> On Tue, 2021-02-09 at 09:00 -0800, Song Liu wrote:
>> BPF programs explicitly initialise global variables to 0 to make sure
>> clang (v10 or older) do not put the variables in the common section.
>> Skip "initialise globals to 0" check for BPF programs to elimiate error
>> messages like:
>>=20
>>     ERROR: do not initialise globals to 0
>>     #19: FILE: samples/bpf/tracex1_kern.c:21:
>>=20
>> Cc: Andy Whitcroft <apw@canonical.com>
>> Cc: Joe Perches <joe@perches.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> ---
>> Changes v1 =3D> v2:
>>   1. Add function exclude_global_initialisers() to keep the code clean.
>=20
> thanks.  trivia and a question:
>=20
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -2428,6 +2428,15 @@ sub get_raw_comment {
>>  	return $comment;
>>  }
>>=20
>> +sub exclude_global_initialisers {
>> +	my ($realfile) =3D @_;
>> +
>> +	# Do not check for BPF programs (tools/testing/selftests/bpf/progs/*.c=
, samples/bpf/*_kern.c, *.bpf.c).
>> +	return $realfile =3D~ /^tools\/testing\/selftests\/bpf\/progs\/.*\.c/ =
||
>> +		$realfile =3D~ /^samples\/bpf\/.*_kern.c/ ||
>=20
> The checkpatch convention commonly used for $realfile comparisons
> to file patterns with directory paths is m@...@
>=20
> 	return $realfile =3D~ m@^tools/testing/selftests/bpf/progs/.*\.c@ ||
> 		$realfile =3D~ m@^samples/bpf/.*_kern\.c@ ||

Will fix.=20

>=20
>> +		$realfile =3D~ /.bpf.c$/;
>=20
> And lastly, is this pattern meant to escape the periods?
> I presume so, but if not, the leading period isn't useful.
>=20
> Maybe:
> 		$realfile =3D~ m@/bpf/.*\.bpf\.c$@;

Exactly! Will fix in v3.=20

Thanks,
Song

>=20
> $ git ls-files | grep "\.bpf\.c$"
> kernel/bpf/preload/iterators/iterators.bpf.c
> tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> tools/bpf/bpftool/skeleton/profiler.bpf.c
> tools/bpf/runqslower/runqslower.bpf.c
>=20
> vs
>=20
> $ git ls-files | grep ".bpf.c$"
> drivers/net/hyperv/netvsc_bpf.c
> drivers/net/netdevsim/bpf.c
> kernel/bpf/preload/iterators/iterators.bpf.c
> lib/test_bpf.c
> net/core/lwt_bpf.c
> net/ipv4/tcp_bpf.c
> net/ipv4/udp_bpf.c
> net/netfilter/xt_bpf.c
> net/sched/act_bpf.c
> net/sched/cls_bpf.c
> samples/bpf/test_lwt_bpf.c
> tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> tools/bpf/bpftool/skeleton/profiler.bpf.c
> tools/bpf/runqslower/runqslower.bpf.c
> tools/build/feature/test-bpf.c
> tools/build/feature/test-libbpf.c
> tools/lib/bpf/bpf.c
> tools/lib/bpf/libbpf.c
> tools/perf/tests/bpf.c
> tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
> tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
> tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
> tools/testing/selftests/net/reuseport_bpf.c
> tools/testing/selftests/seccomp/seccomp_bpf.c
>=20
>=20

