Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84330C933C
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJBVFh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 17:05:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfJBVFh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Oct 2019 17:05:37 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x92L2Sc4028035;
        Wed, 2 Oct 2019 14:05:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eXZZ7Vg881yjFxKTilijm0tADyJnaW3/HUWUej/XNHA=;
 b=lPQ2Mwj+CGFm4bHSAmaDtw7kR6DkBBdvct1cAZQxUv3NmcTG4imhU8EhwHZeH+jUQXdN
 Bs4p/OVJ90QNUUoaYY/EcUCjELIwFw4rNT11h2swIDqxRD+E2xF/wOxC0YuU2lZEyECZ
 XRV7QuAOkzKOStoq+U1MLfUS2mPfxGodZKo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2vcde3nqh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 14:05:17 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 2 Oct 2019 14:05:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Oct 2019 14:05:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLYett1h2rOWf10Lh7Sh3KWt8dJvzjz5mQOzeDzs/7kO79X0RwO7lsoc+tCgGtp0lCjcK1hgiC/RjduRamC/rdRMplf5sQMrBrwtmzB2aTP+V25L1Rql/+uK0Env0mmfTDhw64hOQ7psdvMoyaZuov/A4Qa91IcLs/jLh2CiYExMESXhGXpoIT21EyjAiE3EB3oEBPuJVceaTKCmymsAKgMfnVZZaSU2Xd8qFg14rop6iJzYCUKlzPAEliyaveoU0aR4u7ZWQoerwPzRejO6M+TvGpj1othTSQXHZYpQdT8lCoDX3zKjuGXFldpwpE4xFTjhwDuq0ib7cHG2tVH17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXZZ7Vg881yjFxKTilijm0tADyJnaW3/HUWUej/XNHA=;
 b=lKSZVUFaiqh6jHghaCJVeeOqdUZI3x9kMKEU5e/TyN5Oi0JgJICF51n7nTji5Om05pTW891b9GX9u6JvqcPZlkllFuGG9cgqkOG+2kLkxp5L6ee3OTcKqx31/o/DSJ4+4nSyYTMDtoMaWPK27i1nhOGgo3PeZVJjAEdnx5ChwqOhJ4s01RSTRRGa5QTOOAVeHtfF8Y4dufStVxxrtu0O6r14xgY4oZvXmTYLeKdq7cHSedb1dwXtKUdgz5eI7F5duXQPZZQUOpeq9vvp0COcPckruy5y+SuytaTttT7PHXnOIdvB6NclrNPBVLQmZIOEstp+4h2NvPzX7Uw9kYOexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXZZ7Vg881yjFxKTilijm0tADyJnaW3/HUWUej/XNHA=;
 b=fHVYr8LbEa4uurE5Mqux9isryJoAhFmAHWZJMHTfyzZlzbhsj4nLRYKAIO/MrERMP1Hd3LiZFpCN13cK2lOS6BV3GPG4fPtJACB1rC1bssYdUk92/9mkVKiS3nciuVzqUoUuhBH4fKGdxSAHjJND0+OOE2AtHyW165An0Trsrg8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1439.namprd15.prod.outlook.com (10.173.235.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 2 Oct 2019 21:05:13 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 21:05:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Florent Revest <revest@google.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Martin Lau" <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Subject: Re: [PATCH v2] samples/bpf: Add a workaround for asm_inline
Thread-Topic: [PATCH v2] samples/bpf: Add a workaround for asm_inline
Thread-Index: AQHVeVYPm4ek1mIQkUa9FchMXHWC2KdHy3QAgAAMB4A=
Date:   Wed, 2 Oct 2019 21:05:12 +0000
Message-ID: <E7A6B893-9E4B-4C22-A0CC-833AF45AF460@fb.com>
References: <20191002191652.11432-1-kpsingh@chromium.org>
 <CAEf4BzY4tXd=sHbkN=Bbhj5=7=W_PBs_BB=wjGJ4-bHenKz6sw@mail.gmail.com>
In-Reply-To: <CAEf4BzY4tXd=sHbkN=Bbhj5=7=W_PBs_BB=wjGJ4-bHenKz6sw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::2338]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13301966-69bc-47be-38dd-08d7477c3785
x-ms-traffictypediagnostic: MWHPR15MB1439:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1439EB98AA16A7DFE4FAD715B39C0@MWHPR15MB1439.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(33656002)(6486002)(66556008)(66476007)(486006)(6246003)(966005)(478600001)(305945005)(2906002)(4326008)(7736002)(53546011)(102836004)(186003)(76116006)(6506007)(46003)(54906003)(6916009)(76176011)(316002)(6116002)(99286004)(6512007)(6306002)(66946007)(64756008)(66446008)(6436002)(36756003)(2616005)(8676002)(446003)(11346002)(476003)(14454004)(229853002)(86362001)(81156014)(81166006)(7416002)(14444005)(8936002)(256004)(50226002)(25786009)(5660300002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1439;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YtKRYh7djeNoXNHVvU5a2v8Ly8+8jGMGzVP3gdSFUu1G3WVjQ5IaSexe9Tk+b8Jb//X1J1c9j79JMzy6fZ9WxDM1t66YNoe8LDnQ1rmWMETfejjuVTViOfpXnqTDtriPw/VuUDB99UP2iN4SA1iplpoee9vjepgBoAsNhGYxrRCLWlLB+9ybbhCvB+ws4gPWEZ7cK1cUyvBpgk63vYdn7zTp5z6fMqjq4Ozb4iKHROhD1nYoGT6Ki/odV7aUgFufEg7bwFFdfiNbpGwqUxvimz97L7+0716ZMumadVwrPueVtLQhKgCFSR2idVfUob21vhIHE6jRHhd/WMHnfJ4gGlXixZug6mWM+QVCRMmb+LgFsS6XVzwHB2Bj1inUXt3/gEFO1sTaJIXAR0QpAFnZRrA16+fytndNkslqeQnnzEqZQrABwuFRUC/zN7e6HG60IjSkHHhJvlTlxh1MVDep9A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5E625D639B103418E57E8FF623382ED@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 13301966-69bc-47be-38dd-08d7477c3785
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 21:05:12.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clXD+VN4zRhC2rk5QMoeSZxgPpH1zarj+Xb5+9sQnxvk/bfVLZJ6gW7WAfRhxm0s6oz+rLIohzwVxmrv3YRirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_08:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020166
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Oct 2, 2019, at 1:22 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>=20
> On Wed, Oct 2, 2019 at 12:17 PM KP Singh <kpsingh@chromium.org> wrote:
>>=20
>> From: KP Singh <kpsingh@google.com>
>>=20
>> This was added in:
>>=20
>>  commit eb111869301e ("compiler-types.h: add asm_inline definition")
>>=20
>> and breaks samples/bpf as clang does not support asm __inline.
>>=20
>> Co-developed-by: Florent Revest <revest@google.com>
>> Signed-off-by: Florent Revest <revest@google.com>
>> Signed-off-by: KP Singh <kpsingh@google.com>
>> ---
>>=20
>> Changes since v1:
>>=20
>> - Dropped the rename from asm_workaround.h to asm_goto_workaround.h
>> - Dropped the fix for task_fd_query_user.c as it is updated in
>>  https://lore.kernel.org/bpf/20191001112249.27341-1-bjorn.topel@gmail.co=
m/
>>=20
>> samples/bpf/asm_goto_workaround.h | 13 ++++++++++++-
>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_goto_wo=
rkaround.h
>> index 7409722727ca..7048bb3594d6 100644
>> --- a/samples/bpf/asm_goto_workaround.h
>> +++ b/samples/bpf/asm_goto_workaround.h
>> @@ -3,7 +3,8 @@
>> #ifndef __ASM_GOTO_WORKAROUND_H
>> #define __ASM_GOTO_WORKAROUND_H
>>=20
>> -/* this will bring in asm_volatile_goto macro definition
>> +/*
>> + * This will bring in asm_volatile_goto and asm_inline macro definition=
s
>>  * if enabled by compiler and config options.
>>  */
>> #include <linux/types.h>
>> @@ -13,5 +14,15 @@
>> #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatil=
e_goto")
>> #endif
>>=20
>> +/*
>> + * asm_inline is defined as asm __inline in "include/linux/compiler_typ=
es.h"
>> + * if supported by the kernel's CC (i.e CONFIG_CC_HAS_ASM_INLINE) which=
 is not
>> + * supported by CLANG.
>> + */
>> +#ifdef asm_inline
>> +#undef asm_inline
>> +#define asm_inline asm
>> +#endif
>=20
> Would it be better to just #undef CONFIG_CC_HAS_ASM_INLINE for BPF progra=
ms?

I guess that is still useful when gcc fully support BPF?

Thanks,
Song

