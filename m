Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86DF5B0A3C
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIGQhl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiIGQhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 12:37:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F23A2203
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 09:37:38 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 287Fnd0K025105
        for <bpf@vger.kernel.org>; Wed, 7 Sep 2022 09:37:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zeRhnCgfsecfsETwc2CC9GKY7Jpn8/n/RfmD07J2hpI=;
 b=oW3mx6jq8LLynr+CXkpDIP4BemcSybi/vPTzkYFpaR9T9+Kt2WC+Y6YSAtuUws++CoXv
 z9ddd5IrPpNvmtxZNB6AnIUtwm+usiDx6HqA/0se0FC+Odq9S9x/FmNkN5IS07oBAYWy
 Q/6Gk8VB+jpfMKoqSNvMlkehrIUR5s7vyhQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jee6bdfhh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 09:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akkE+afTn+ZE8ojb2aOVamZC8K/whGRIRsVF6t8L0x7UjB4SjQdG9qNjxm1zqHDpQXAm9iN9zzLaYQqPkNGZ93YRxfLclCNVMdGzH0bnaHJCQwQTOfvbTzYXzSXLHI33goZIjh8XiF10Pl1AXrdrDKyhHW+OSkv32hI0R2le3feqVyEM7ErfYvXGVhm55vzFvtDPabauj/xKiu2h2myanXVEGZQP8e2SkThA9Kmz7tqHqwg1GeUCvQj3gjLRVAq8ys7y4TGBNb6tgLwbvIRr7tXBU4BSYIRsUIFQqlw+An5gQBV1wjw9rWkLOhdfU3tjgC2SvyME77K5iAtssO+FCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeRhnCgfsecfsETwc2CC9GKY7Jpn8/n/RfmD07J2hpI=;
 b=SBimUb/c8R1pz4E5mdcw9RNLKT6eCpIEoYLWhE6LZaECFxUGk4g2KkCE4oQN8/F4BqJ1ppwSOHmmTIJEwFltDBVbqXuBiYxdpgHPZB2dFeCCnUO4zO8vT6t4mUTOJywJaDVyo+eupGVBN31YloByCWuuJf+5vZnycLGlHdzuR8//dp7i/bVhIKzKRm5TVwaJ/YJTzhYT3KskznxdJyqASreauLUgtJn4+hM5MokVF4Ah9/CAGsriDiImObzLVShiQuQW69G5VLchHsg4gXwyO0xMmB9S42RkxvhZxcBeaG3Ju15RrvQz8nt6bUUBlWK9R1p5jSz+ngombdbXL/V0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY3PR15MB4868.namprd15.prod.outlook.com (2603:10b6:a03:3c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 16:37:35 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::2374:1d5c:fd6e:a28c]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::2374:1d5c:fd6e:a28c%7]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 16:37:35 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Quentin Monnet <quentin@isovalent.com>
CC:     Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?iso-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Thread-Topic: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Thread-Index: AQHYwfWyySrgrFJYJE+DvUZRwLK9ea3TF08AgADuyoCAACY+AA==
Date:   Wed, 7 Sep 2022 16:37:34 +0000
Message-ID: <CBB0AE41-123D-4992-A8E1-10B2BCAFE9C3@fb.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
 <20220906133613.54928-7-quentin@isovalent.com>
 <CAPhsuW6iH0qFfJFxcWfGAnsD1FqOM_ThZLp5H+MARvkBxq8K7w@mail.gmail.com>
 <8b0de52e-84e8-c098-113d-5b5b9cdfd22e@isovalent.com>
In-Reply-To: <8b0de52e-84e8-c098-113d-5b5b9cdfd22e@isovalent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY3PR15MB4868:EE_
x-ms-office365-filtering-correlation-id: 74043c17-2703-419e-d9ff-08da90ef44bc
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BrF+FQTtfiIyYrzBmG7SMWU/2eTI7h9E3IDDduALtlcSgbddb8JLw/IB/x/GTSX0qlKO9+H/9Uaax5EWrFgrsmqmzIOPd1McvJGBLWBkpw8eg9QLcqjWq7pLedVRFi0Lnwm4julPb7pdNtOJ6UhbrUHta3v0gxcsc8lihrO5rLuprH7YHpoTTCJ1zP/sj8WT2G8Rd9SDW1VpuslRApfyXN6IKIi9XADMkM25AX0HGEVuMONihuZDGqrKSqmzTb1yLaJAbPUSTz9b+HLFWqCzdw9MLb3HuMMmXh8tVEeysh02EbVmglQQ9qra7y+VNbr6plXOPGOlLelmKDR33V2u6IG/F/NVZ0RbJfMoESmk/NkEixW3W9WuW5NlZwDj1BeZYA7QjVvquym4YWmDxIKW8qwEkPt4fiiip74s8VBaDLxVEpxtlHXFR/0GYeZAf4hM7HpgH6PQtL6k9w4pIC0BzeeOIy6OVc6od2oh727ELYd84xs3lEr+n5jJlNeFj6ab0rxtfWyRoVQaTPfX8qtq+GtzCzzt7P6PjopfkJM19D9YvFurt9pbFDXaPClX0CJgwX0mukSxoQG8jCWCDM7ghproJDNuRbdLdQir/2aTlHaupVVqpYtc9jUYPfLm55Cy8vAUsdx4nB8gxCAUlJYWYK2PCKfHd1Yj/mqjGsskuhSBVnEm59fdicBzfnIFoZa66PWYdd6ixIQx5V9uBAJhA5ZrKV91sW6gIyf8LnX3bzzxc69YCJ8B+u7ezkLLf4QxxDxWR4BP+X7GqGN0iG85rl3y4Oj3upqp9pheiRdRbI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(6486002)(71200400001)(41300700001)(478600001)(186003)(6506007)(83380400001)(8936002)(2616005)(2906002)(5660300002)(7416002)(53546011)(6916009)(54906003)(6512007)(316002)(64756008)(66556008)(4326008)(8676002)(66446008)(66476007)(66946007)(76116006)(122000001)(91956017)(86362001)(33656002)(38100700002)(36756003)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1mpHOOq4Ih0ToBUcLT8VSiX9fMh/DoBZUyFCmOaTidp7RQcj+mccTSz6aK?=
 =?iso-8859-1?Q?iF1jkj/VXNIvdSoe3nhDhGHjvHaPH3EiW/SBJ4TClG0071+HMwjEsGnX+S?=
 =?iso-8859-1?Q?AWRDKNpr5/m80soQAuBglkttd/Ybf/owGnKUfJvyB63EfFxCp1KduXHpN0?=
 =?iso-8859-1?Q?8gmX7SxMRlMDwSkPKEeTUfI6Uj1v+q4rks585PhLqD5m73aa9kCgi8e8J8?=
 =?iso-8859-1?Q?XViMIiFIVrWjqJC/M6feLpSQwuLFBUafBNEEWh9XnMJOhnWHfdjnpj07i8?=
 =?iso-8859-1?Q?LSqp/Z+r9DlE7lObI8/QJRq2S2ItSZpibkTVdiXtUAPQ7IxHA804hTuCMK?=
 =?iso-8859-1?Q?6UVeDhS2jUkO+S3RFkWFVv73uNoRh6SbDgo+pCUem8a0KADbCgxeyuDDIR?=
 =?iso-8859-1?Q?zghT250S1nhgORs7e4NIc5k71VrLLJzau9O8MtUaXaw0ptyLz+K1FCw0b1?=
 =?iso-8859-1?Q?2w0rmbSKV73TbOtd1ep+Ty7ica8Qr67XNoj8/1A7oVKnIa+4HNPKBJkWMn?=
 =?iso-8859-1?Q?FfvFitSB3DOOP2c7rmRRgPajZi9UgCurpZLq2/oiQx1EJjvrWqHBhyMkK9?=
 =?iso-8859-1?Q?Ak6DC7o0fGEXrgmE6045MEYe8gPKpbvIoF2H2mEEXJHnoZD5erGl+Ni7pn?=
 =?iso-8859-1?Q?4b1o2gkffhGto/hNVbZZG9Pm9YJfm/TUmL0bZy38FoVeyD7TooYtrD+zbm?=
 =?iso-8859-1?Q?QwimYmaxvB3R48ylv8s/INz0ttbTcH5TsBC1DYJdCpj10Yy/bvVAryb4YK?=
 =?iso-8859-1?Q?GU/gnpHhwqSCB2y7LaUg2BiQqYjg3M8wFS0q0PgMEqkT0kqp9rgT4c+i5j?=
 =?iso-8859-1?Q?lXfXq9dEXPhQNOdc5V73KsMqfWcLj+LsWbQFjkq0QgPGeiImZso3/tM2K5?=
 =?iso-8859-1?Q?ci8AES8GEhIi0O2t0+NddeihkwzjP2BfYl2jHabaw685iRUh+9bFVDfcGl?=
 =?iso-8859-1?Q?UzoujQ5GvEFzfAsssW+aORAT2y7FVyvPljAmxF76xtlqs6/X/1ITTtnPqc?=
 =?iso-8859-1?Q?jrY8Ql/EMJHpnRj787mXxEq1hFfTYSaxqnb2gAhFvLpnMErt1+gmbYklcA?=
 =?iso-8859-1?Q?C9co3q15g4ttWMbY4snIzqYgPx3f/gMyRzzBtr+IhWJtH1s0wrgWysxQ1B?=
 =?iso-8859-1?Q?6k6TdYxmsCOc7Q//GZgueokWcisUQZOfJoBotk5qKzwj/hfr9lurg3RV17?=
 =?iso-8859-1?Q?V0Lo8zKBm2lieWZOdOTQfNc3o5xSZil5dSv1GTOCfESPXIYxLnKmJ+Czha?=
 =?iso-8859-1?Q?r2AjSVVzK5YZioEZhMMQ0745aPhHaETBxcwO2BCNU5gx0uqQB11awAiEdZ?=
 =?iso-8859-1?Q?IEffX8gtN7kHub19HuNOXRbxDQSLS4q6B4fLxeTgeWArRIqa2lnHKrtXPj?=
 =?iso-8859-1?Q?kb/oYhZRocfg1rZj6Xkr/wQvMYAt7Cgx43Pji4EQ28D1VxzMfNn7rkA4vy?=
 =?iso-8859-1?Q?+dT3C4bAMUD+wmJvuorzWJ+iGSEnN5RMwWtuVj58XnfuuDXwxf1v5KMu/c?=
 =?iso-8859-1?Q?piKTp0q3zoibIbYU2wEOEIrZkiixx3fBjOM+YxDykrow9nKC8JwKsQYyPR?=
 =?iso-8859-1?Q?1slj2T6uIe9lE27jCm6xX0nQddaDV+2OfapXrq0YT0N09FrKfciEdOgSoF?=
 =?iso-8859-1?Q?WvCchYQKSy1zAoHxMDnOuzPzqWH/mxUwQL5boapRxHsh/HRUqDX2b1E48O?=
 =?iso-8859-1?Q?cNbzM0nh/Tw/omJfLjI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <652FF5390AAA2144AE678A2A15F86C02@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74043c17-2703-419e-d9ff-08da90ef44bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 16:37:35.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OWDbvPktGTUTyWzGZnSI9UNgWjjimj+R0a5Vwgpf285ibSSvm7JpQLUeDgAyl+dt0jTkTZGL58bxn9ENIqIkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4868
X-Proofpoint-ORIG-GUID: lauGNsDbjepDaw-TNvWeXL_wU_yjJNTh
X-Proofpoint-GUID: lauGNsDbjepDaw-TNvWeXL_wU_yjJNTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 7, 2022, at 7:20 AM, Quentin Monnet <quentin@isovalent.com> wrote:
>=20
> On 07/09/2022 01:06, Song Liu wrote:
>> On Tue, Sep 6, 2022 at 6:46 AM Quentin Monnet <quentin@isovalent.com> wr=
ote:
>>>=20
>> [...]
>>> +
>>> +static int
>>> +init_context(disasm_ctx_t *ctx, const char *arch,
>>> +            __maybe_unused const char *disassembler_options,
>>> +            __maybe_unused unsigned char *image, __maybe_unused ssize_=
t len)
>>> +{
>>> +       char *triple;
>>> +
>>> +       if (arch) {
>>> +               p_err("Architecture %s not supported", arch);
>>> +               return -1;
>>> +       }
>>=20
>> Does this mean we stop supporting arch by default (prefer llvm
>> over bfd)?
>=20
> We do drop support in practice, because the "arch" is only used for nfp
> (we only use this when the program is not using the host architecture,
> so when it's offloaded - see ifindex_to_bfd_params() in common.c), and
> LLVM has no support for nfp.
>=20
> Although on second thought, it would probably be cleaner to set the arch
> anyway in the snippet above, and to let LLVM return an error if it
> doesn't know about it, so that we don't have to update bpftool in the
> future if a new arch is used for BPF offload. I can update for the next
> iteration.

Sounds good! Thanks for looking into different options.=20

Song

