Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74BA3F2017
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhHSSqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 14:46:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21204 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231745AbhHSSp7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Aug 2021 14:45:59 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JIeqr7002459;
        Thu, 19 Aug 2021 11:45:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EaFkwt7AlDK8PgGM8+Ixh0jBUxIFBLo3q2dlW0VO2Cc=;
 b=TUiA9v7QXcN+M8oi6jf+//j62MS1D2ellyB0CFJ4FoLxfJ6j+cxJVlbV58et+YHCir81
 KlkcpD/f6xqbm/WihGNStVY3kuX7zYP5lzuB0RUWE+CsAu97KaL17zPHeXXUbif5ZFNL
 guGchGhSooIMOXNv5oKJghCx3WjFC80CXYc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ahrtb1ufb-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 Aug 2021 11:45:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 11:45:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9j55Wxp/ccp8jpq6IapC4vNermQY/7Mrqz+hfs4E6yVK17bTpXb9S2wZ2ypGjW17Dcv52hMDeXi1lCYiGg3sgyUEpwVVNctBVEVnAun5pM0PRMVZ8Mcv6sp03AWimAWb1/Tim4FRiTRqdqIsCIpdTF044tFzWF9bPOREdTdHwXVItiGB82LR+oEJewOwYb557IZir02sF1nE8u+ZcqYdcRQfcyu/DjOOIphvQg/rf3OAWEJp7UPOxT2Zi8Bju/OL+5fbShaecl/dTDEX50lgOUBI7E9kj0FSJsrzp1Fw2O6KzTzYep1b4yUj7a8PyD5BogKxZ4pQ07jRWOLhJIbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaFkwt7AlDK8PgGM8+Ixh0jBUxIFBLo3q2dlW0VO2Cc=;
 b=EclKOAHfd4iCmOO0HSM0wlZAlyLKXhCLRmYvKa9LLOqxcPKvqFZ15NMmSbDiWkSHsWCDnMyeTZKcgjDF8LBF7W/Z0QPRZjITZ+HI406DsrDOztw7W9fYj+w1jh1CeD9Ff5Gmzd6+0XSZsY1tKcPkmAsnAE1rJU6IxcmQp1h0a2g9J9jb9m//IzN3X6M0acMqgyn++0AJQwwu0l+ApNn+S+SqsIg7heinNSjSl0hsFOH39P5EikrW/BZWl0Kftq1RNP9u6t2JeXf9j9ziezCAEU8gRTcSTb6ygEh2bWcDt253z+nwb3xiocWYRmmVThajZeXQuHKoaO/VWLhaQ6n+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5061.namprd15.prod.outlook.com (2603:10b6:806:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 18:45:11 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 18:45:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Like Xu" <like.xu@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Thread-Topic: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Thread-Index: AQHXk9CX6/TyfH2Y/US67JUy/V0E76t4+50AgAB99ACAAUGPAIAAULcAgAAWb4CAAARTAIAAAXWAgAAE/QA=
Date:   Thu, 19 Aug 2021 18:45:11 +0000
Message-ID: <2DB56175-ECFD-492B-A577-866D39A445E5@fb.com>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
 <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
 <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
 <AB509D87-67C6-4B7F-AEFB-2324845C310C@fb.com>
 <YR6dreGQSe4oQFBr@hirez.programming.kicks-ass.net>
 <A5F7CF90-27F9-476C-B87C-CAD2A6BE5DA4@fb.com>
 <YR6ih+pKSm5TVVBc@hirez.programming.kicks-ass.net>
In-Reply-To: <YR6ih+pKSm5TVVBc@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be9acd25-1738-4617-9940-08d963417979
x-ms-traffictypediagnostic: SA1PR15MB5061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5061AA20EA2703BF1AD4FF8FB3C09@SA1PR15MB5061.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPMG3qAeSAFAwkhkDiKlQE7ilH8KThwVPDSZCxEsMDV5IMGzymjvpDeJbIuyr/87Pfta+4xkCEcS4ioYJK4YBrektHYVTxhx+pq8XpuuCexXA80ebGK45UVw0Zdy4wNrDAnByYs/PWTt9zGerKUyFZ4Tjm5kZw9tZ2DvxuZhmXth52y7du0oCkVNBNJXGeAqRLhAGLWbWkpCYcntjgsybwlhT2nFnkCOAtwO8Muru+dzEP3+BNmKgUqRM5Egk7PetXyJ8bC1H0bo4jIkM6+S4JzZRPfRotA4r1NR5/3NbR63r6+Uvwl6ul0BGgR+1AgKyfr/lt6MmFkYzJ1U060DpqAOtCaIY9QGn7mwCz2r3c4IlXvBBMt/iu9W5s+Pf2d4tUd3zBJomSF860iGj2NI/onwJwNGqOxfwWEKpcOFA7E9HyCN8KTXM8bCA+Cdeha+hhAkL6H73NnjGmzoVfy9S9TxCrBtU1o05741znQ9tm0aDNfDGDwblJRIxt5cRAug1ioAkuqdH+PRENZg9poxosGjrCGvZ/7NyFbyVPNnqCkDovm4W4OwGK8+MZwWGdvKbJ4auX2St3eChXz06CIRQPJxT6F6/802yMI6ooaPg3338X0rJDHx5iPjerI9wH5S/cyC2rLgcPZGHK1Iw2lYXFq9paChvV8+H42BPj/Q7H7wkmRi/a3dhvFdbcE3xbFSIHVJISFt3RO3ty55xYWCbtcy9L3vk66xmTm7YSvf5LQI4A98n3WXYEaOisvCwKXp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(2906002)(71200400001)(4326008)(4744005)(54906003)(86362001)(316002)(2616005)(122000001)(5660300002)(33656002)(38100700002)(53546011)(8936002)(6506007)(36756003)(478600001)(38070700005)(66476007)(66556008)(64756008)(66446008)(66946007)(6512007)(8676002)(6916009)(76116006)(6486002)(91956017)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ycM7tY+yw9hN5b1bwm6zc9vLITWhJSeD71uJfzRkbxsjSmiepUje2HdCPYRu?=
 =?us-ascii?Q?WFbd8a92NbO0+YwGz8sZ2cirkmYbnX665H7H0/Drh0Djm/xGbv9NwskvvkSx?=
 =?us-ascii?Q?YUoC+LMsrj1yVJACYrftwYvaTJQfVo1CR/RK3pH7ksqTHCnee/6vAv13Qyl1?=
 =?us-ascii?Q?Gfn3umfqglhWBeXz37cX6jE02YDy0gYm2PTg2PFGNKNulsCyKurSrsv9+TDn?=
 =?us-ascii?Q?gFhorCwwMWs6gAoOjQBIKhO5S28NIzL/oFVD0FkdL0HKlpkf465g+rhVcvJF?=
 =?us-ascii?Q?7+krI7yosO3C+cqpBGLsskMevZbWUfOSJxMDpkuvg8mTkSnjXISwv4T3BhSM?=
 =?us-ascii?Q?hrHMe8T7z5TpwsYHpXk+LDEteGR5h+tyAyMZDjo5IiD/X/PQwIRMHmiMS9QR?=
 =?us-ascii?Q?gGuMGjcP2nKIITcFRZ0ApnSgdxaZcpQKvCGsCWJX5bUho2IxXsbxICNVZn4r?=
 =?us-ascii?Q?ZvIm7BxN1sRx9/Q8V0JAA1VyfdPxUxQszSrBs4OrD8jkkCDQrY4aLxxrZErq?=
 =?us-ascii?Q?d208wvp2zorNlLoR/6SEdKHafHCKJkXeK/CYNEzi6zRJXWIyc1QflDL4OiA9?=
 =?us-ascii?Q?zjasOcjtq3Ym5SDh1sR8PSWMAYdEUsDIFhhPcph17IfcmmmdCwiGqIf1P+Xp?=
 =?us-ascii?Q?4q0EFgVBZttys1/A+D5Rskuz7GTOPXI4dhZla2UUAGUAnPNAXISZ3xkzMO9f?=
 =?us-ascii?Q?QlvRO71yIoZ50K7zoiJuIxhT3dvxnz2UHT58rgqQ+gLgjDzRikyYhQkBDNQD?=
 =?us-ascii?Q?MP9NFtv+7MgsIh2yzCSAO1b9D32tPL7YDv4TsdN3p5G9MmfdWHTidxCH2cqj?=
 =?us-ascii?Q?jgiQphzz4ck0BjZ6bR07kY/f2hzqFbZmPJmrvDoDIPIhmfCPHFIuOWgc2Nrs?=
 =?us-ascii?Q?J/FdeMwgALZa3W++JmN+TNJ4smn2NTXl55Nf1PT5adi6yHl1lE7w7dM7SIwO?=
 =?us-ascii?Q?QN3scr53lBZ6BIAnyLh8Grv6ID7C6p0UlXK7O9euEVCzh4ax6rZI7enOt+Y2?=
 =?us-ascii?Q?or2jiEzAjWfyOtVL/UDG/QvH9T0H2/CjoAbQklBzxohsMlRhKeUNj8SRvJRI?=
 =?us-ascii?Q?5QzfpERcXxFBZQPGflKJHeu3sByXX+mk3cJ0q3KFwooVZDYHTAh2eTB8rtbr?=
 =?us-ascii?Q?A4v9VZCW5F9z6Ns6jhmwp3kE5+GiB0sDWmwyu78Ei5CNilNtgbnpY0mXHDvi?=
 =?us-ascii?Q?uijsUp1I6ehOA1XPhItiSTWXT1KM3k0lPn3T4qONg4Yai3H4hyY3v5/r2S4M?=
 =?us-ascii?Q?pd3P74qc3sSfOsxxos9dW/9a/XvBqxBEuCXij+nnRhWFjlhd/BR1r4w9u0vs?=
 =?us-ascii?Q?YD5Nx829u8iBbZy3EoGgnQKFdVnBl2U/WsZGrlfJQ+185bbHfVux9PS82Kb8?=
 =?us-ascii?Q?gnmRgEA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E08016F55F6E034E966FD5E1E64C59A0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9acd25-1738-4617-9940-08d963417979
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 18:45:11.0815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mim6utmp/lBh7SwR7Kz5ievn1YuvNSmGHrAhohokrAObxa2BIKGqoeFvAJhWsgtPaZkgqaxbYGGXoWDM5BOTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5061
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: h5nvOR7XNrQmZTXq68mPHl-ZyO17P9ym
X-Proofpoint-GUID: h5nvOR7XNrQmZTXq68mPHl-ZyO17P9ym
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_06:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=579 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108190109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,

> On Aug 19, 2021, at 11:27 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Thu, Aug 19, 2021 at 06:22:07PM +0000, Song Liu wrote:
>=20
>>> And if we're going to be adding new pmu::methods then I figure one that
>>> does the whole sample state might be more useful.
>>=20
>> What do you mean by "whole sample state"? To integrate with exiting
>> perf_sample_data, like perf_output_sample()?
>=20
> Yeah, the PMI can/does set more than data->br_stack, but I'm now
> thinking that without an actual PMI, much of that will not be possible.
> br_stack is special here.
>=20
> Oh well, carry on I suppose.

Thanks again for these information and suggestions. I will try to put them
together in the code and send the patches.=20

Song
