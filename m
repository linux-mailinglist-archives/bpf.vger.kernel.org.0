Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B94921D97
	for <lists+bpf@lfdr.de>; Fri, 17 May 2019 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfEQSls (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 May 2019 14:41:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726740AbfEQSlr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 May 2019 14:41:47 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HIb26A026534;
        Fri, 17 May 2019 11:41:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KpYezGRm9TmJbwz+7n/txBpJ0av3KHo3+3rYPI5dntI=;
 b=MTpyrHC9K6wPUSQ+Dllda9mvE68+rQvgimxXi7SzKtoSfsL/NFjActsmRFvCQ3Opvd4w
 2ncmhAjeEkpGo6TDi9ZOPx4xvU7B4fo7TveTySt45s1f5zXTCeqHJZEdc5sodxsde2ER
 vlGGZ/lXmCZjU8hF5CJyxbbmgy4tbjPIF+M= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2sht779p9c-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 11:41:05 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 11:40:58 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 11:40:58 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 11:40:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpYezGRm9TmJbwz+7n/txBpJ0av3KHo3+3rYPI5dntI=;
 b=HBz0F+zZpcLFfbG7Oe6SIif4F9h6AUQ1lQ7ygnE4pi4Cagvfau7YCNHEJ8WE8D8sQUtmSZtScP0cdp0Qd5Y/dJhTJnydgIMaEYK/kmobUWsSDK6OraLnYTf3mmCqkZewSDMGjLR1xUn92XfHzT2CdlmimwmigDYDcZCYbsthMaE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1200.namprd15.prod.outlook.com (10.175.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 18:40:42 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 18:40:42 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Kairui Song <kasong@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel() 
Thread-Topic: Getting empty callchain from perf_callchain_kernel() 
Thread-Index: AQHVDEJXbyjc1nknl06FlgTGlvLrzKZu8J8AgAAG+ICAAAFQgIAAD2QAgACfPoA=
Date:   Fri, 17 May 2019 18:40:42 +0000
Message-ID: <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
In-Reply-To: <20190517091044.GM2606@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [199.201.64.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b52c2ec6-0347-4019-7348-08d6daf72a99
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1200;
x-ms-traffictypediagnostic: MWHPR15MB1200:
x-microsoft-antispam-prvs: <MWHPR15MB12000DDB3F3AA848ACE2D60DB30B0@MWHPR15MB1200.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(57306001)(11346002)(8676002)(73956011)(81156014)(81166006)(4743002)(6116002)(3846002)(71190400001)(446003)(6486002)(7736002)(305945005)(2616005)(54906003)(33656002)(71200400001)(229853002)(50226002)(66946007)(64756008)(66556008)(66476007)(68736007)(83716004)(6436002)(76116006)(476003)(486006)(99286004)(8936002)(66446008)(316002)(2906002)(66066001)(6512007)(25786009)(76176011)(6506007)(53546011)(82746002)(36756003)(256004)(5660300002)(102836004)(186003)(6246003)(478600001)(53936002)(14454004)(6916009)(86362001)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1200;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rjo6BXCJbc9izJmCfL6cI4kU6aw+osASiICRfjR+EtGRMHdaC7mPslzp5iRAVZg5r8cUagdki9FdLRhaNT5AA0lIkPGudUin+Y6Lzj9Oq/+Ld0wtgK7dOx3E/1wKfNcS7VGVsVvEGr3oIPQJYAw8Buev3oxXL2znNzm3M0vPMYee5BI1kDa9qoIVFvthehks/TSMvigOyO/4Q0unxFHKowjIb/R95ba6XMH3lBNHbfUO9wy/09a/N5MDFddddtJaT3qGmlY97qNyvUypc/cWpHU2onN/llNE+aBtmAGUOSa5bJXWdvAvbkAhVp2L9DCMAcg4hvEDUUCseb6iqAo7KNLj3zCrv0f416JKwOjk03LyANNx0Ij1T33T200N5BigzfGwltCxdAuPuTa9bHNoKTbO68JeNePWrtsCZT0Fs/o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FF86B1DAF91D44899A0007FE0561F37@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b52c2ec6-0347-4019-7348-08d6daf72a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 18:40:42.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+Alexei, Daniel, and bpf

> On May 17, 2019, at 2:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
>> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
>> some other bfp functions) is now broken, or, strating an unwind
>> directly inside a bpf program will end up strangely. It have following
>> kernel message:
>=20
> Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
> follow.

I guess we need something like the following? (we should be able to=20
optimize the PER_CPU stuff).=20

Thanks,
Song


diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
index f92d6ad5e080..c525149028a7 100644
--- i/kernel/trace/bpf_trace.c
+++ w/kernel/trace/bpf_trace.c
@@ -696,11 +696,13 @@ static const struct bpf_func_proto bpf_perf_event_out=
put_proto_tp =3D {
        .arg5_type      =3D ARG_CONST_SIZE_OR_ZERO,
 };

+static DEFINE_PER_CPU(struct pt_regs, bpf_stackid_tp_regs);
 BPF_CALL_3(bpf_get_stackid_tp, void *, tp_buff, struct bpf_map *, map,
           u64, flags)
 {
-       struct pt_regs *regs =3D *(struct pt_regs **)tp_buff;
+       struct pt_regs *regs =3D this_cpu_ptr(&bpf_stackid_tp_regs);

+       perf_fetch_caller_regs(regs);
        /*
         * Same comment as in bpf_perf_event_output_tp(), only that this ti=
me
         * the other helper's function body cannot be inlined due to being
@@ -719,10 +721,13 @@ static const struct bpf_func_proto bpf_get_stackid_pr=
oto_tp =3D {
        .arg3_type      =3D ARG_ANYTHING,
 };

+static DEFINE_PER_CPU(struct pt_regs, bpf_stack_tp_regs);
 BPF_CALL_4(bpf_get_stack_tp, void *, tp_buff, void *, buf, u32, size,
           u64, flags)
 {
-       struct pt_regs *regs =3D *(struct pt_regs **)tp_buff;
+       struct pt_regs *regs =3D this_cpu_ptr(&bpf_stack_tp_regs);
+
+       perf_fetch_caller_regs(regs);

        return bpf_get_stack((unsigned long) regs, (unsigned long) buf,
                             (unsigned long) size, flags, 0);=
