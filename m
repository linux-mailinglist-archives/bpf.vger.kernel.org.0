Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7A5EE1CB
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiI1QYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiI1QXb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 12:23:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA419E368D
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 09:23:29 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SA8bwS000825
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 09:23:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2JC5hL6oVaYq7VLSJQR0zX7ur8ztNcFPO87e4dpO5Ag=;
 b=jftC3XBYXBU9BxuKstuahlVqK0mNZsiR2ngWHi945xBSKDU+lXX5Iot8LqtvA5uqbaSD
 XkiFBORDx9387eV0OoyTpG4AQLysEdx7kqvXIfPLuYSRYUE1dc+Viune2exijF5RXjlp
 TLvuSvePafoHMsNxmnekSdzwEMwfBm0TpgQ= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jvg973m4y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 09:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dixWMUmX38lNGwyDMBqkjSLTxbdNjkdo8Hl2FKQlGuu0si8nYBI87q5IDb2wQp8VPbHYavmermf5KZuBL+E+G/iz3Sg+qSFPcXmfws5zn7NSm+Ph6WFbY4MLQo9Zltd0dI3Ko95XBkIdajq1fgc1O2IVFxTtFg1M75d3Ig7qVq2z+8L7a7uSe9hJd6VdEvhRpeNw+1QuzaTq6lgCJYyvWX4F2ZjiDFpvQQmKJGtUkjmAguQs9nEwThmFuANJ/ij1NvSdMHPlphbhAM9gR1wJLtWAB5IyCasz5/n8FpdrB2Uq+BiagiSiNln3xgd6rBSNGUIqtCzLcljHk/gvebJbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQqBOyRBeS2kjPUahMwlBP8JfEeE4gJ+72BBD3x7T3A=;
 b=emF3vipcFJECBJx54eTkQ7HcutRmdKbgnAjmsyarfIDHiSMC7nwd/qlfoV3XQKjpXMLW2vZChjYxQltZsXA6cc3qx+VmJj1vZxw02q+ScgIO0iGX7A9nintjmOuXtnOzcDCBwIZrRgM4BSdZs4MMkbbga0arH7nxbtuK60viEIsRF7W9qI3a7ElqdiZIkYbl4PxBvunV927oF6unachIPqXNl5ngM7DkYGs9ivtfntPX1TEwVUykgbdFTGzRU8GFTOBjZPpGtZsDOHSlMA23XMzfQmNUyGaM4WKeVDmRMYYQWywcKK7RJhF+kEuOi7Itolc15XHrXec5fcZ/bqXrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MWHPR15MB1776.namprd15.prod.outlook.com (2603:10b6:301:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 16:23:26 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 16:23:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kernel Team <Kernel-team@fb.com>, Hao Luo <haoluo@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Toke Hoiland Jorgensen <toke@redhat.com>,
        Clark Williams <clark@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 bpf-next 0/2] enforce W^X for trampoline and dispatcher
Thread-Topic: [PATCH v2 bpf-next 0/2] enforce W^X for trampoline and
 dispatcher
Thread-Index: AQHY0diAGSQVkrKIrkirjj5uJg0O8a30mZyAgABv94A=
Date:   Wed, 28 Sep 2022 16:23:26 +0000
Message-ID: <22456B80-AE66-47EC-9C17-4002884ACA1F@fb.com>
References: <20220926184739.3512547-1-song@kernel.org>
 <91bbd6dd-04d4-51a0-8a7d-cf124cefca29@redhat.com>
In-Reply-To: <91bbd6dd-04d4-51a0-8a7d-cf124cefca29@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MWHPR15MB1776:EE_
x-ms-office365-filtering-correlation-id: d320974c-62f9-48e9-a16b-08daa16dc5ad
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cw8z6YKLCGr8Y9t8DDCZ2d9kjRFKH2qRGWFQIDSUST+DCON2Z+Y8AN335ryWkV1zEABcOzpXlHpl5NppNTTCF1PWNydMil+9xBDmvn4i5CfFDJco44xhmEMzknQ8Vf8ypPML9qc12YTMXsGvB5wML3NWeLwqGCjDw+RGHqRQlrUmegj44KBwNGg+UZfrKC1MFCfcntus3D2vPP/RIXyGwN92XVKeCEnJR8eDHz9GtarV3TsTUPCV+/yqKwg7/U1wH84H4mHPevHKe1KIOCMBZhzEw963/iupeSF8zhaFnMERN6BsivCwFdNsIHbdwk+QiVyUWmkdkTnlJ1NR6V60uHhr04MyyICXvQ+B+5VbjwbzLNtRILGXDXjfO19z0c8ao1nmXS0vMBnID1ko8X3XmU+4iX9iro0F8NGLJQBHappkL5HdQce0HnzlNG4MJO8wcENvyytEv/ymjRBaWIYudMoNbBPp8FkWZSSly5Le0V5A9oo/bfUPAVC14fjqKgg/GQWujxRElNRRifr9yeKeWGaPwSToBhpRRevNiu8uRjChXCfMiv9XdjHnbsdUoDJXvRL5WPJUN+LOYjcF5Jny7PM7f2Zq7K3ftgZR0psp/mDu21cmILNrrsLRLpbJ0KH5IIXZrard5W4lVgr33Sdep8VtbiVetSEaYN7bo0kOOmVNfeyiFD7Zgupiodtwi3QSJuWZwULwuC6lMcopJeurv79vteW1/dxyE/TmQyqATNW7NQlJoisxZvTD3U9LqRzC9RylOxFCQCzFzzHJ7wPxgZRmzqUkxyqIlEADhyQkZGJxvBAfzcmC/VNAnSCaSsfW5TYLlF7/vrnqF2JAmrVZpzeJrhqe+fekjNDAYRDLjl4EWjymW5+FOyDyS077sADVVkyDFjbCf9pPrDCgGD47nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(186003)(83380400001)(54906003)(38070700005)(316002)(8936002)(86362001)(66476007)(66446008)(66556008)(64756008)(8676002)(91956017)(4326008)(6512007)(478600001)(122000001)(2616005)(36756003)(41300700001)(2906002)(966005)(6486002)(71200400001)(6506007)(38100700002)(6916009)(66946007)(33656002)(76116006)(7416002)(53546011)(5660300002)(81973001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rfiEB/JE6y7dM5kBwVt+7r4OcZv8fa3kyYS2hsIGnq5AKqGygFa2CoaIrX?=
 =?iso-8859-1?Q?cxyOmLQvSfljU9QHjGEu2DYh5y15Fk+xCzq85GHiNdClZvKV+jhA3TXPnJ?=
 =?iso-8859-1?Q?Us5Kj9ytHIWpNsqcwBXxm9PdLvDlwRWWUiD95JdnPw+rObuqri3PozpiDe?=
 =?iso-8859-1?Q?ORyLoXicUZHJgoy3XdErdt9xPLDkdhAyfnxsSEs/UXl1UTC1V+qzMv1qfE?=
 =?iso-8859-1?Q?iqlpue727cLfWGWnJ+zssPXHY0SCiX6vIe2Q449xxeasW8fFzuMSzNoyEA?=
 =?iso-8859-1?Q?xjNhbEfXW/a/3Kr30jogAVUlrRiFu7Jugu9bJPVNsEiNSy6P4SVYYXGFOV?=
 =?iso-8859-1?Q?yAZ+u1rAH8g0/1acmDfiobmhTMVXPTVjn3NlIPG8r3RwQCBRVmUeeN+eUj?=
 =?iso-8859-1?Q?J9Ox+EHWH1mrkyezlnywuWOfG0aWHGXAwmO0JPzuMAl0xxReInnPMgA7Sz?=
 =?iso-8859-1?Q?H0dmye9sV1jTODGqXtV4z4/zv7RYHjmg2upcT5BTx8xAudPj1d95qf+6Fa?=
 =?iso-8859-1?Q?9RNcDUJIEeAtn5AMeeJkcIIDKupD52ijSp9R1XVYnZvHYUBhVg8VphQkly?=
 =?iso-8859-1?Q?5Z+yQ/heEEsUZqhEjoUG+Mbmqpuhif1+sUYoLJQzmnCyu9SSVLCwtweHFv?=
 =?iso-8859-1?Q?G/Gxcra4/UCFnzVu/WW9OC3uMc9xzb9x8zJQ9U+4YSMw4jQSO6o39tc/HP?=
 =?iso-8859-1?Q?UV6/QSGN4VoWtLPFMC1bcsYNpSoQbxKe1PNdjORsgYrVvKNKOSqrm3PC+i?=
 =?iso-8859-1?Q?CylVPxrDNoqUeT7APgGSxEON5dcnw9XzsOGwsuj5t9QymXQY0ah2lH7kiM?=
 =?iso-8859-1?Q?THWYFeMWkZK2GW/TpRbM4fszYAXVlMgw5FE+lyC1Y0h/tAS2dh1baNNyOb?=
 =?iso-8859-1?Q?r2O6b0ExOwbtBkkJxDXwdwtFq+poZ2tL22sI3MpcceZLgLRwHsBOQXe2SP?=
 =?iso-8859-1?Q?ASX9iB1wo2BgoHe67hf9j61A42QCl5kLeZSwOS8V7/Fmmd1/1xG1QoZUKo?=
 =?iso-8859-1?Q?tut6vXbbh0o7sxBRWrgvDoO2M58jnjG2MFQ0FqPlujuokcICAX2C5/wt1K?=
 =?iso-8859-1?Q?+rv7FsYjXQXZi0Hgur3jRaYDK11euAv2Pf0nPzDZy6CzhNlhbEEJ+mzwPQ?=
 =?iso-8859-1?Q?sFE1H4u/36rHOH+gwC1IjdSZzvV5jrG5mD/NuvpC5hyOxuZ1KSYkwrc5g4?=
 =?iso-8859-1?Q?rZ5SEqdJGE5thimcRYrmaNnKNCdWNe359+43pqxQsdhJGd/KLpzXyXaeJD?=
 =?iso-8859-1?Q?6WJQz9XpRjaKIXDl5UMC3nW9jiFflf4Q69d8iEWwYiu51OyRNqNp3seuoi?=
 =?iso-8859-1?Q?UGZo9Z0R2hB8+61g9LrJk7X105IrfTYwoz5rY4uzx9+xDIVJmeyOkg+kXR?=
 =?iso-8859-1?Q?RY1fMUpinU3BM+4hKIhf9R8MzPm89AGKcWziT6fVGvbWRaoq6KE+Nk1nwQ?=
 =?iso-8859-1?Q?gPw1GRCevN5dNGHU/zfwm6gR06mo4fOsKsbj94nWU5nuBFzFTllMhiGkxx?=
 =?iso-8859-1?Q?DHd73Cdq64pPk+Oc3BQsq3aaRGfiV6UT+tlpdBJLsSyAPZz/tm0RjVje75?=
 =?iso-8859-1?Q?lIY1JNW9ouRycB9L9vEh5bOBCmEBSPY3lGQiGBEhQ35zw0db59x3P/CWBx?=
 =?iso-8859-1?Q?B2+FN7CeUlJ235lleiCsRLUQ+Jt7k6+b95Soi6ollKmcmZl/6eIegKf486?=
 =?iso-8859-1?Q?sVh4vvf/yMONCh66x8w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0D39BA864933AA439134A372E999CC61@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d320974c-62f9-48e9-a16b-08daa16dc5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 16:23:26.6031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwy1fId8m3JcAw4q/yxpN4KTeOBMBJtDt+ExdqESsOK3/6Tttp2oBPPxOASmdGGH+0tVLiX7cjAadBxqNEYJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1776
X-Proofpoint-GUID: Y8UU69fXuhQBsk869IvihLJWfJkaiXri
X-Proofpoint-ORIG-GUID: Y8UU69fXuhQBsk869IvihLJWfJkaiXri
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 28, 2022, at 2:42 AM, Jesper Dangaard Brouer <jbrouer@redhat.com> =
wrote:
>=20
>=20
> On 26/09/2022 20.47, Song Liu wrote:
>> Changes v1 =3D> v2:
>> 1. Update arch_prepare_bpf_dispatcher to use a RO image and a RW buffer.
>>    (Alexei) Note: I haven't found an existing test to cover this part, so
>>    this part was tested manually (comparing the generated dispatcher is
>>    the same).
>> Jeff Layton reported CPA W^X warning linux-next [1]. It turns out to be
>> W^X issue with bpf trampoline and bpf dispatcher. Fix these by:
>> 1. Use bpf_prog_pack for bpf_dispatcher;
>> 2. Set memory permission properly with bpf trampoline.
>=20
> Indirectly related to your patchset[0].
> - TL;DR calling set_memory_x() have side-effects
>=20
> We are getting reports that loading BPF-progs (jit stage) cause issues fo=
r RT in the form of triggering work on isolated CPUs.  It looks like BTF JI=
T stage cause a TLB flush on all CPUs, including isolated CPUs.
>=20
> The triggering function is set_memory_x() (see call-stack[2]).
>=20
> We have noticed (and appreciate) you have previously improved the situati=
on in this patchset[3]:
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D80123f0ac4a6
>=20
> Is this patchset also part of improving the situation, or does it introdu=
ce more calls to set_memory_x() ?

This set doesn't change numbers of set_memory_x() calls for trampolines.=20
We plan to move trampolines to use bpf_prog_pack (or the new vmalloc_exec,=
=20
if I am lucky) in 6.2. We will see fewer set_memory_x() calls after that.

Thanks,
Song

>=20
>=20
>> [1] https://lore.kernel.org/lkml/c84cc27c1a5031a003039748c3c099732a718ae=
c.camel@kernel.org/
>=20
>=20
> [2] Call stack triggering issue:
>=20
>        smp_call_function_many_cond+0x1
>        smp_call_function+0x39
>        on_each_cpu+0x2a
>        cpa_flush+0x11a
>        change_page_attr_set_clr+0x129
>        set_memory_x+0x37
>        bpf_int_jit_compile+0x36f
>        bpf_prog_select_runtime+0xc6
>        bpf_prepare_filter+0x523
>        sk_attach_filter+0x13
>        sock_setsockopt+0x920
>        __sys_setsockopt+0x16a
>        __x64_sys_setsockopt+0x20
>        do_syscall_64+0x87
>        entry_SYSCALL_64_after_hwframe+0x65
>=20
>=20
> [0] https://lore.kernel.org/all/20220926184739.3512547-1-song@kernel.org/=
#r
>=20
> --Jesper
>=20

