Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC344596D
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 19:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhKDSQ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 14:16:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11944 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhKDSQ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 14:16:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4GG4qF001759;
        Thu, 4 Nov 2021 11:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=droWPWolwzdOyfH33lG6/GoPdRLJN1O102eHEggqYtI=;
 b=eJk8tT/Z/0eAzdWJU3UOLIq3zlSwF16VO7ak6rx8/RTuz0oxpxcHgPorEMTIKVnVaeBE
 y35jcTI5HoYV4ym+zFYY8kWyzQ+Wt7GPSoWUjmOTofhzJRBAmexpHk3O0euK3SHdK1ET
 TR1Fp3ssMqaK9Gu8waP1J/U2FL/UPvp4j6Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c46b66994-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 11:13:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 11:13:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzZ+KWi+844Xv5pnkM57IeaFcmIp0m2GmCiAEwzsSUy7Iz2Et1oeIAuWCqxDjJn9NlkTVHuYUJ6vsV37vU57i9n8ECZBVXvB3XIa8l7XZwl2llQS4pDrKlkX3pm2EkAe0wd94ZN+d0kDJgSUOctUTsxsvTsXS/upSNjkpr+kp4jhvnXVn4z8NUpF3xauI55UbJslEUQH64Wj8kMi4j4IhzGX2CrySTTLz5oXSxBFlEVh85pvgt4Mut2uIOxKBB71I80GKJQRZIWb4mSeKN13Vdf/FYmqHNLc6YZMU1+YpJQ7lKdA1Fxi2BLPIHd/oFvifQy9jYu0MeO3qotlzyi+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=droWPWolwzdOyfH33lG6/GoPdRLJN1O102eHEggqYtI=;
 b=BQ8PQGen87Q0PWxwZb8eRw/Q4yFfNg0V04Lrpg4tD3YJwzACXZLY2LSk8uZgGWLhm7m4vH2ZZkYpA41zGUuAeJ1gGU8b6wZXkIfUCmaaM/3WkmIgm97Ppj63gzeD9D3LLVsPs65zrcIsuRa9+ccYV4FsjjSDQpl+qpIsUKC3hoirZh4jzo1z+UNn0JVwcoVS6M6qjL479KqD+PxIX0PE8kRJM39BjgoPzWt/IGQH8NUPf/qGDyXoVixLZw887ucYveJOMoZfPTXlszDghmo4gHSlkPaaDVegKzMqFxWt9pvY1wSfYcBkv6I36qIbT6cOOWgoyKi15BPDalm4TZLITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 18:13:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::30d5:5bb:f0af:d953]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::30d5:5bb:f0af:d953%9]) with mapi id 15.20.4669.013; Thu, 4 Nov 2021
 18:13:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge with
 upstream
Thread-Topic: perf build broken looking for bpf/{libbpf,bpf}.h after merge
 with upstream
Thread-Index: AQHX0aK4Hz+aVKUD606joRkorpG+9qvzpV0AgAAB8ACAAAREAIAAAJMA
Date:   Thu, 4 Nov 2021 18:13:46 +0000
Message-ID: <C940FF7A-A27F-4F56-8659-9365FC4A2EF7@fb.com>
References: <YYQadWbtdZ9Ff9N4@kernel.org> <YYQdKijyt20cBQik@kernel.org>
 <CAEf4BzYtq5Fru0_=Stih+Tjya3i29xG+RSF=4oOT7GbUwVRQaQ@mail.gmail.com>
 <YYQiXnUxlOoWMdwZ@kernel.org>
In-Reply-To: <YYQiXnUxlOoWMdwZ@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3258041-3eed-408a-5b92-08d99fbed824
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-microsoft-antispam-prvs: <SA1PR15MB51124C77B332693D53DCF2D6B38D9@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: deTxb1FJ4zpAfxxSzTkRlXdr4/lez7hgGg116mkt5WBaVk7ZhrU5TorxaBs+KF5EAAFLzHo3BK1901zKgr0+NdAyUAK/qkSN04SYQCQ+JpBM2jcR0XjQ6qmC/Gd25Zu+GfVvHRPe6RqkgADsLwdF//N7mm8pO5NSTzOScHt9dGop6bQlTaooztx++2NkKi83nx/WbEMIKe5SagtjIKRKZ1e3nmaMYkFsDcGUh+BMwgbt79vBmKy8laf3YaJT+uTZ/pBmzOJQHUGPGGde7GeorHOPaggGbDbknw/I1yl2UWr2tzk46Prk+oCu2PwYqU4/JeUhitOnyosFYImiCH69oxFGJ8cQqC30vduZARGvh14iTEssGv61C9ogzyYPYNGlZCEK8u7RiJsrH9GBcZyfEf9CQXVPnGuzWbjRgSFlkGQcn24JKTmqBSx+YoC0O2s/XDr90xNsEIMSjKg20+aJNuJjkYf8v3KsQUJPF+cKg582Oqos91maDrN2DqC0NYtJ/P516q2nBWR1v7wArrDllYulS1pZ/gm0EF6NSde4CIujkg/nLw4UsxRr1Q+Vpj8QwUOWOFuheijjEFO8SKOc3NB5rSJWMc+CfU608i4uYOZ+t2e6Go/y8IcmCDDr0oW0YaUvBV9dliKZy2o7xsDXNxvQOROWpifUpaa06qG5ZaKhxY8svzNzc7zIUKI0n8zl+ZmeNU0BH09VWrLsiEDGj3NqWYP3bKVBUrrT/SJvD2fnKaN5Ve4gQ94aVsIM9Tiw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(316002)(86362001)(71200400001)(38100700002)(122000001)(33656002)(38070700005)(36756003)(6506007)(53546011)(4326008)(186003)(54906003)(6916009)(66946007)(83380400001)(508600001)(2906002)(91956017)(2616005)(76116006)(66556008)(64756008)(66446008)(6486002)(66476007)(6512007)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?erSMuM2+RagDtyah2N/4TcXUY32UppNK+och1DjadqMqesLTXgJO2zGO1d/H?=
 =?us-ascii?Q?CPKUkJj/8gmhxFjE8V/LrDSkkplXocqD5RdpUEOr1VY+BFo+g/vFi+qitytV?=
 =?us-ascii?Q?1VXiC9PofvFNpLzz2aF8+zlyCqrLr1M/w3wEf3BAqkrQno53mrD09iCJIw8T?=
 =?us-ascii?Q?enf6VL+JaNjuGCLh08mHbUZ+oGj5YGjKSybUH7cjsikeYyBwf9uQA5GEeoGH?=
 =?us-ascii?Q?+hPtWo3u3TNmUJQMFsGKbrduo/Ge5RZ9Xm4Lbtrc4bm/P9pa0eO61D7PaLzo?=
 =?us-ascii?Q?EmPbKjPHWGR4lYvWwuTr3wfbvwjqWlNK2Kk3tv9R7+bFAX/KR5fRTqm6ALRY?=
 =?us-ascii?Q?tpZoR6WZtylUMbcX0kQsFveMGFyJGBVcpVupHYRYuTzUHxPOrqwFZyX7p4Gv?=
 =?us-ascii?Q?PVj0Qiixvvpx7L8otiT8rPfg+Czm1/sRc6Tl8jlsqc9qbFMx7YRR9dIF6wGm?=
 =?us-ascii?Q?jzE9O6g2N5EzWi9jX7Tb5dFwhKMMGgyiAqR/kcN3pw9etvN4nJVxRrUbc3jf?=
 =?us-ascii?Q?+s7bVzENpUFTLP02a+vqKzqlWluZgwzR2i7u9T0di3No4eXoeOt4HlSbuSNQ?=
 =?us-ascii?Q?yDXkM8oFjwTZ+R3vQWutdq7I8hxRzu54ybBd8KxYG2NZ0flyZ9DU8m89zsKg?=
 =?us-ascii?Q?NjWytTbq5Emy+evxJc8lZosU6i1IjpFAv4ZwOsF916PxfCdldeyX9N6y3WfQ?=
 =?us-ascii?Q?D8+ZNCx9FbDXUSOryEwEgmQa8n4fFJ368R0xK799FGvv8NQ0/s+fZhmAeSXD?=
 =?us-ascii?Q?HSgbe2cxGYaIdYxGB6GMueqNi2e01ozhBlSVEBX0+u46JdD1ZPhakHioM11j?=
 =?us-ascii?Q?MCvk6colHKdNn5JZkLQoceQnKaG66sRE6At6SDZUZ2ehRsd2atz03U9UMSU+?=
 =?us-ascii?Q?VKYPDkK0kL1NigwZ2PrRfZabt5+GbEK9Vx+IYqfuBPEkwktXPswoROk1OxfG?=
 =?us-ascii?Q?spPozkkiNqalawz7W3V8ep9Q5UpGv7TO03S/Sa0q1VVs0iQCNiwXLrY83+eh?=
 =?us-ascii?Q?D9gI6EIP12kMLqkkZVLXSI7sv0SuiVpc/q/THreayZxyqtCgTvmjFWoH/nbz?=
 =?us-ascii?Q?frc3dkGWBI8KAU3q/XSdqIXHSmStzS6R0FSU8zer1drLnOQjDSiwWVa0ZGby?=
 =?us-ascii?Q?sE3gL8FFFSXPK3Ky+49IvqqEq1fgWamnDEh5XEhwMoZqokbXpf61H1nq1z1r?=
 =?us-ascii?Q?SD1DjGoM16UZrpmLdV0lgPHuahDb5GNXrImDAC3To/ZKp52zDwbVziCoTP0m?=
 =?us-ascii?Q?v24M8b6guz39ZOWX6pQFRnfhBcm3nEmhko2qRcrN+XamDU6PQwO6h6sCeYdG?=
 =?us-ascii?Q?BN4Kq5hBMaXthLYAeo3VRU9+qB/1AW1ylREY5raRU9grPz8xEarSEqcwge0V?=
 =?us-ascii?Q?3I2ncNyZCOZnk0D6agNCqPAiDMtvT1CcOxekDHTTkF/7/oq4qlyChi3pOWaF?=
 =?us-ascii?Q?wC5oD8cUpPMD1BUaJ1eXEDqvao4/BTuQGlDUi0flVZLQYOyPvEx668KwyRlH?=
 =?us-ascii?Q?2bkHBL1P/a7CWkko7V1+8u0i2mSNkF5PnUicX7Y0OHHCZaA4zeoW+Fnliz74?=
 =?us-ascii?Q?yCgdWsa6JA3DO8+Rmjjoz/RGBQcCFw1jySFN8a4uvk9ACN9lvysfxVoy7WGY?=
 =?us-ascii?Q?BZVHHrzja8cSWqmGKUDb0FZ6KP10Phv0pb+Z39kb8si+KBmSAWF6OUCdua3T?=
 =?us-ascii?Q?N9GhLQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41F682D37324674D9F12D332DD964586@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3258041-3eed-408a-5b92-08d99fbed824
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 18:13:46.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2p2n0Mjvc692vLccFIYYRutCZ3pPa9ahH00ICJ4IJCYDydhzJMc4unjfEVtrHdY+qpDb+Hmh6jkZhr1TYd8+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: UzsD-p_WDbUjM8aLoq9FXmdPBiw54LRP
X-Proofpoint-GUID: UzsD-p_WDbUjM8aLoq9FXmdPBiw54LRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=982
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040071
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 4, 2021, at 11:11 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Em Thu, Nov 04, 2021 at 10:56:26AM -0700, Andrii Nakryiko escreveu:
>> On Thu, Nov 4, 2021 at 10:49 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> 
>>> Em Thu, Nov 04, 2021 at 02:37:57PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> 
>>>> Hi Song,
>>>> 
>>>>      I just did a merge with upstream and I'm getting this:
>>>> 
>>>>  LINK    /tmp/build/perf/plugins/plugin_scsi.so
>>>>  INSTALL trace_plugins
>>> 
>>> To clarify, the command line to build perf that results in this problem
>>> is:
>>> 
>>>  make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin
>> 
>> Oh, I dropped CORESIGN and left BUILD_BPF_SKEL=1 and yeah, I see the
>> build failure. I do think now that it's related to the recent Makefile
>> revamp effort. Quentin, PTAL.
>> 
>> On the side note, why BUILD_BPF_SKEL=1 is not a default, we might have
>> caught this sooner. Is there any reason not to flip the default?
> 
> I asked Song in the past about this, and asked again on another reply to
> this thread, I think it should be the default.
> 
> Song, Namhyung? You're the skel guys (so far) :-)

Yeah, let's make it default. 

Song

