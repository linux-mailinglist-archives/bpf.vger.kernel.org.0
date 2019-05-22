Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C2267CB
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfEVQNo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 12:13:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36694 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728466AbfEVQNo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 May 2019 12:13:44 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MGCZdm026547;
        Wed, 22 May 2019 09:13:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zWvMdWugovYXTPSCGMtXv4L7vDmLWCqrjg70YsLPczA=;
 b=OecEqyhAq/WJLRkUnBIRcKm8CSc5ri+KN9GnRFNKx3eQZdLyLtooz17wTbnorQTYPA2d
 3DUNMRMFVuk3+4QfI3DbAQMvOakT9JFC/fn1+8fdWqR296WaONYr/BXR1i3jLtrzwDPp
 VLK3EauaYhjy5+S56wqtm6xj9Mr9182zpoE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sn9bgr3w7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 May 2019 09:13:08 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 May 2019 09:13:05 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 22 May 2019 09:13:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWvMdWugovYXTPSCGMtXv4L7vDmLWCqrjg70YsLPczA=;
 b=b2ZjG7IbMqYTAXtbGOkuPH5AC/KtlyUyjJkJxuL31+je8Hj1EPuRtPO12RG446gdma1XbVanQrOurDrq58d2fnne/fCz9SQze82QvMsF/rxzJKuxEj3/BXih5XfHBBMPVkQ36XlZLv1Fx2AhbLj/XbrK8FVoJn3iCizTQ1WvWK8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1567.namprd15.prod.outlook.com (10.173.235.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 22 May 2019 16:12:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 16:12:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86: always include regs->ip in callchain
Thread-Topic: [PATCH] perf/x86: always include regs->ip in callchain
Thread-Index: AQHVEBaM9rNs0KV060agNJ6HaueIX6Z3LMkAgAAlbgA=
Date:   Wed, 22 May 2019 16:12:49 +0000
Message-ID: <305A8E31-13BC-4891-A9F2-30A25264771C@fb.com>
References: <20190521204813.1167784-1-songliubraving@fb.com>
 <20190522135850.GB16275@worktop.programming.kicks-ass.net>
In-Reply-To: <20190522135850.GB16275@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::3:a64d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0f35c3c-2cd3-4a72-da17-08d6ded055f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1567;
x-ms-traffictypediagnostic: MWHPR15MB1567:
x-microsoft-antispam-prvs: <MWHPR15MB15672A61DFD594A1D1DA2EEBB3000@MWHPR15MB1567.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(83716004)(14454004)(478600001)(99286004)(54906003)(71190400001)(66476007)(64756008)(6486002)(6916009)(71200400001)(66556008)(33656002)(68736007)(76116006)(66946007)(256004)(6436002)(66446008)(229853002)(73956011)(2906002)(102836004)(316002)(86362001)(50226002)(8676002)(305945005)(81156014)(8936002)(25786009)(6506007)(53546011)(7736002)(81166006)(46003)(486006)(11346002)(57306001)(4326008)(5660300002)(446003)(476003)(2616005)(76176011)(6512007)(82746002)(6116002)(6246003)(36756003)(53936002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1567;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pMhRQFBSJUzJcw+WHWyU+ThRuLF0I0IASahVZkP+o9x9cviPOnGdjjeUcleCi2I3xmRIO+o/40Fnj6Vrppy9700g12DA0m0ZIB/FHmGyY9dcu1RtxehW4Lchu7VWdAVbl5NPsbZyue3i7LX6aneB335KnPxmuNGlXbrSSwCaLa3ybGHDgNoOk5bx48KVfxAtxUfZrQ5h/gKtfP8GBhQMhQ/OFBT6Vlzzc/zeVxs1m4IMsQ5JY/9sJTm3B003FWixvoiIG/1D52iqcOVQuUXZT8sqVXqcFH5ALVYKjjb32iU3v+hLXXtBbMz7up0/YAU/h+cONjOlLa06V4UYyJcWBcFWSZcx8IMRW4JdToU+AcSSklTqn+WlKUhq8eMmlQTS4couaZeUEjqhEDbbePMreANs7o1TMlASrWkAnVhHGm8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <012F3268734D894692438B583C7DFDFD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f35c3c-2cd3-4a72-da17-08d6ded055f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 16:12:49.5324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1567
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220114
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 22, 2019, at 6:58 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, May 21, 2019 at 01:48:13PM -0700, Song Liu wrote:
>> Commit d15d356887e7 removes regs->ip for !perf_hw_regs(regs) case. This
>> breaks tests like test_stacktrace_map from selftests/bpf/tests_prog.
>=20
> That test is broken by something else; just the one entry is wrong too.
>=20
> That said, yes the patch below is actually correct, but the above
> description is misleading at best.

How about we change it to:=20

Commit d15d356887e7 removes regs->ip for !perf_hw_regs(regs) case. This
patch adds regs->ip back.


Shall I send v2 with the change?=20

Thanks,
Song

>=20
>> This patch adds regs->ip back.
>>=20
>> Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG=
_FRAME_POINTER")
>> Cc: Kairui Song <kasong@redhat.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> arch/x86/events/core.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index f315425d8468..7b8a9eb4d5fd 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2402,9 +2402,9 @@ perf_callchain_kernel(struct perf_callchain_entry_=
ctx *entry, struct pt_regs *re
>> 		return;
>> 	}
>>=20
>> +	if (perf_callchain_store(entry, regs->ip))
>> +		return;
>> 	if (perf_hw_regs(regs)) {
>> -		if (perf_callchain_store(entry, regs->ip))
>> -			return;
>> 		unwind_start(&state, current, regs, NULL);
>> 	} else {
>> 		unwind_start(&state, current, NULL, (void *)regs->sp);
>> --=20
>> 2.17.1
>>=20

