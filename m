Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5A52AE29
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 00:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiEQW3p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 18:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiEQW3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 18:29:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFBA52E6D
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652826580; x=1684362580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mB8u9BdNMn38h5Y/S5WTMdFLR6KitGB+9hRnZzD/pu0=;
  b=E8CEMEdhoqtfdXWmo+n8F3LpmKD2McRn+2PJ7Xt8aP5UTJ0kCfRHmc6b
   7IV+KMSP/OQRXanIGRyFTej9HcT+4aa/T5LpsnIGrcmYdS2Hi75a7y/+v
   OnGhEXFFEqSaOUEhGYYt4UOeS7aZKdtGV0nLzanLqMBw3dISlT39qAPmk
   ADhpev+PcEeSCMpwS+fRXfzeziekkBnyP6FtTr04WG8AEPNhVvFtq3uPA
   tGcGuIS5lNvgDT8uQtcbdLfMYG/aGnjrQ91Qgk8pF3Pqj5N9g4cW+iR5s
   DVvaimfiDJZRMWGSY4loc1NEzvcFIQUupG0KLiV5wuq8tKpzLTA+PCfJr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251873727"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251873727"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="700276948"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 15:29:40 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 15:29:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 15:29:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 15:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT6hGEpKipl3p7d/0ON+CSWwYrKVphAzIctKx35Kw+lz3HavagOy0woWbV3X8y4ToduIsoAfHuN6ql820ucy/cOG283Ev+HphLPi2gmIOqjlsoucY4haNsexuQqupcvrGq/v7wma3An96Cw9jL0SEzVLOiure6rpqBjKdmfi4G1pckI5fO0goSFnX1tR0wRWxfuftB6BrFMnpcsSWovKQCntFREHgJyuqK6BrGc6u9BjCMhjlx/2nXlWan1pnS6NtTDNHk9EuH/PLpyaR0d60TSTPfyfl2sfOFEBCJUp/vpF3kdqdaBXN8xhTR8F0IEvWJ636qV89aZie19u7bjceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8TOJVkUyWJruJeg1/Unkd+Win/oBkugvveqhWNBPDY=;
 b=g1I6M5ML83SMOPHTdw9qc7n8x9OWutyDTi5QKeOY5ZrIEtlWEijXt2a7r1JffoDdyWku8QBdUvDFAaZ6jKcJWDyXGEpmv/CQQ2n58v5wA2+83NtlLGmh6Nlm458NH4fiBZ+1zsuiSOfuGFYMWd/1dmPWGVfh/19cpuBslz/rzPgZ7mIYeaKaS9QVj4lwI0ssC/CAZ9+GQzqW/mecE7hbhu2XCnsF47mEnPZ5fGvIQThH6SQuW3N2szQQGO9AgH5AJxULo4oadKSvH7koqQAgfqU1v41K6sGlY0llg39VPUFYs/0dpaf/my7s12A1MDHU9wbQ4/fM6EVTHvOFuD8P6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3303.namprd11.prod.outlook.com (2603:10b6:a03:18::15)
 by BYAPR11MB3222.namprd11.prod.outlook.com (2603:10b6:a03:79::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Tue, 17 May
 2022 22:29:37 +0000
Received: from BYAPR11MB3303.namprd11.prod.outlook.com
 ([fe80::2120:5aa6:7488:9d7b]) by BYAPR11MB3303.namprd11.prod.outlook.com
 ([fe80::2120:5aa6:7488:9d7b%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 22:29:37 +0000
From:   "Harris, James R" <james.r.harris@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Dave Thaler <dthaler@microsoft.com>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Joe Stringer <joe@cilium.io>
Subject: Re: LSF/MM session: eBPF standardization
Thread-Topic: LSF/MM session: eBPF standardization
Thread-Index: AQHYZEaH8TYxqzqw10i49Lslj3fFiK0ainoAgAhIy4CAAN9cgA==
Date:   Tue, 17 May 2022 22:29:37 +0000
Message-ID: <8DA9E260-AE56-4B21-90BF-CF0049CFD04D@intel.com>
References: <20220503140449.GA22470@lst.de> <20220510081657.GA12910@lst.de>
 <CAADnVQKBbh6T0-cs0WB2bsapg0wbb9Zu1az==CHD19sxeD5o_g@mail.gmail.com>
 <20220517091011.GA18723@lst.de>
In-Reply-To: <20220517091011.GA18723@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d868606d-2ddb-4bf6-004c-08da3854ba27
x-ms-traffictypediagnostic: BYAPR11MB3222:EE_
x-microsoft-antispam-prvs: <BYAPR11MB322236F17172A458D0EF8C6FDECE9@BYAPR11MB3222.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C2NE1cXcu/J44azA4lFT5xj1udddhj2cJTvsbEqGLY+ecTY7cZa6aWFOIQsxHbx1KiHl/cIJ00MsKjsSRj+QJgUo/4DNMMBW7QvKw4GqDPT6rE6pSc21AAURBT0yLfg9/idPdid2fk3POQpvXKAkc+rfyfIDMQQnhfgefETQf6tclQ9J8P4a3YmvWlD8PthTromE52hiZUdooPbICBI5eEXkBQvDjZGYkOkUQp4dYrnoHobnXI5NYjQMpfhfLqmZC5sJY+yGH3UQKw0YWvxmfwjICiEbIxqjEpE3JuLPGVJKifMMfGJCQYd1XExN/+CfQNoMTjV9GJovVJRiaR6xxWxkUFcU1UkRHaLG+xwmfL+k53bSTwtHU3cIi8PwECZBNNvaxCpxIr6UmYphhbPE6/2Dr2FoBSk2DnTE46qqmAI1YLl/J50hZ2jpZzmM4WeGE/cPh0ZiWINX+RH50tJYrseXswUjukGfhpTTOJ3xEYETrr+nDa33UvEgeIsE3KjZRFXMGFUhg4ZYifZaC/MHCpdl4qXXxWAn5JmVNXQJp1A8tKVtSlqyaGy85iA9h+MFUrpjim1LkGzQHbRFV6J4engPR/CaMk4gPKL36h4t7VURmFsXqeABGZLlPmEJuwkYOhxwRRsp+IyEweFGoqh+HQbHmNOfMUcyL8rdmm8KedF10V+S7H4sAmV1lwqyTU9HmOJl+nl7KUe36taH44J3ZNm+DOEprSuLSSwDt5y7zZKL5fFm/Nibx7xQJ0Ok/jr/I2ErZItol7Y/bHT/0rPxbt+UTAq4U1TcNvbw5smacAup3LgyyI4V5MblmVd3ZHwbbNCCzAC4Qa3atXuZKoFDh9W+2USjiU6th77D6CycGes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3303.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(26005)(8676002)(966005)(6506007)(66946007)(53546011)(66476007)(66556008)(64756008)(66446008)(6512007)(36756003)(76116006)(54906003)(83380400001)(82960400001)(2906002)(6916009)(186003)(122000001)(38070700005)(86362001)(45080400002)(8936002)(33656002)(7416002)(30864003)(71200400001)(5660300002)(316002)(508600001)(38100700002)(2616005)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+rS32sEl6inM9QY7DhO14oUApmkK9uxc0x7btoO0iGcfvAyxUHNDa1KKSmP6?=
 =?us-ascii?Q?fW5JfbhXaqYOX067BDA0KvbqilCK5OXPuASyTgioDycmNjo8fSDpz5arbHJe?=
 =?us-ascii?Q?8SvhAOLWu6PGTD3FPDG3QZEecd5Zp13TWUQNRHh4tRBCUZck7oS6lYM/awSW?=
 =?us-ascii?Q?vbGTaGn/vGFSuUMbiaQ49+7R9aDzuP9D2IJ5D9IsnySJTBapWI6D5yl9eTlj?=
 =?us-ascii?Q?ddRokDJcm73ZIzFternxPe4p+RFGShBjx6y0is0IresjEyrK/1zswvYeM5dv?=
 =?us-ascii?Q?UrVZR4TqzwN4HWs51yKX7HkJuLYiCPvNZPgt4oEnQGIAUrlYrWfkIZaJIrsk?=
 =?us-ascii?Q?b+T7QQ1wHRGMjzJm+jul16lYqmVdfFoz+ziDbRqVAArEnKhF6MKXIvV+VEKG?=
 =?us-ascii?Q?n+D8DudNy1sqcXOtn4bfmHM4AocJQVYALXeEwBfNITlUHNYQLNbwUrACaiu7?=
 =?us-ascii?Q?NzCDFiBiRBqcsHd7BS7DMwaWuzP7N170mFsmrsnt8QqHYuHJVOSaA4lF76Lm?=
 =?us-ascii?Q?m4odjArmCvAnXwpUM3LLa7GPuuiwVsWee8kiFMJrVO7k5KCFuRs2FvFMrjN6?=
 =?us-ascii?Q?aWANITiHhPh/vXuiHpU3aeKWWy7m7ZHGu1a+Re+CRh0j6VWSFbD9iXNJEDOX?=
 =?us-ascii?Q?Hs897MsU/d8OAKu733m0M5gQc4rL2XRt8QhYXXrm02R1IwqnzKcEnvU7bn7A?=
 =?us-ascii?Q?sePYn9sCryIMbTxaeWAfFYY9p3dqSzxmrqLJlZLjMA20wONdhu0URqD4e3ol?=
 =?us-ascii?Q?unW5KJpnnAKELCzqTNKWC+wn6BYy5VqzPmudmCkfq/9Fk365YvrA/DJ8hu6+?=
 =?us-ascii?Q?xn/jIQr1Im4BdZInR6vpJOutvAeqnQ6LVEEvW8a/ycrgwax0ZxHqFkYG1X1g?=
 =?us-ascii?Q?quRKVzjQaUMcuiblF26n+amYq7zeS7IsElOYvxuFxYul3gGDT++ltNIp6UKz?=
 =?us-ascii?Q?iQx1jnq9zXQ6o6UkDAeAzgnQVqTqJsAIaM92godWuyvU4ShZHOcgbNfMh4lH?=
 =?us-ascii?Q?L0Kh6tVw+D9swyencTO0mBN66Nc1BIGyHsSAcGnRuvRYJJ/myZSBhQKJ+Wa3?=
 =?us-ascii?Q?vYI7cN6Wfbr0q5oDhvDqxUHRzOW2obK4+a1dqQgx66n7zWRmCs49Gz5xZZU6?=
 =?us-ascii?Q?tkqRmW7cO/HVYot0quwcUGXoA9m8rCykbwvnfDPzNBVBLZGe5LXZuJIrc9cV?=
 =?us-ascii?Q?Oxqk03iVS7WP98YaQUI2nsN/iHespCpxo+iuM0PleWeXYJ8/t/+4NI3L8d/6?=
 =?us-ascii?Q?XHdYLr0T2gqZFaVj5Pt+DbupVb/dsHOp9QAqVF2FZAjA7LWXKqSoRiZPt7uk?=
 =?us-ascii?Q?kIQbrfb7VHCTNfTk6FruqX55TOVnCHdwMPJEUyrh+xuTXuDrBfxSEDJm0pKs?=
 =?us-ascii?Q?/zghDS+7efDHBNmdm7VO4FXn16+ulduRl/Iyk90F2k1KjSdEOUXWK7d5cNnJ?=
 =?us-ascii?Q?E20+h2anxuWH9SumBX2L32yo9vdGTrmIyiSNazyi+ZToQPdD/dpeOZjPYQ8Q?=
 =?us-ascii?Q?BVW8V02NOhx6MLr8X6UXae9rP/91RBc51XlhFWZjsHgw8ycb9BzlRq/zTO8G?=
 =?us-ascii?Q?slvR3Q85u+mjebJuslBROaYaWNNsPUsi/+LudDS3sc6rD4XomKA+FGNr2JqT?=
 =?us-ascii?Q?ph3ku8VvYHGMjBFpqawlu/EfA9QaOdK8K4wP4COkdbCDQcsqqpZXiin63pVG?=
 =?us-ascii?Q?qM237Ph9OUYYfSfAAXsmPoYszGO3n01UZ6tgoH3PbJC1gbQY5ebNyVNieQCT?=
 =?us-ascii?Q?ViOfGZqsFSDunFY5A3JE3YN1k6jAWXQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38BDF35C07CB454FB58F8E1668257322@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3303.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d868606d-2ddb-4bf6-004c-08da3854ba27
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 22:29:37.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t57IkCFTpDWYayfrbOMULyv6YPFPLNzY14Mo/QuxFjM0U9B/tQ8jjUkfZ8V540GJyZdIOMS1VfsYgYqpwqescJFLVa0U50pbZ33cTQYVMYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 17, 2022, at 2:10 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Wed, May 11, 2022 at 07:39:34PM -0700, Alexei Starovoitov wrote:
>> Turns out that clang -mcpu=3Dv1,v2,v3 are not exactly correct.
>> We've extended ISA more than three times.
>> For example when we added more atomics insns in
>> https://lore.kernel.org/bpf/20210114181751.768687-1-jackmanb@google.com/
>>=20
>> The corresponding llvm diff didn't add a new -mcpu flavor.
>> There was no need to do it.
>=20
> .. because all uses of these new instructions are through builtins
> that wouldn't other be available, yes.
>=20
>> Also llvm flags can turn a subset of insns on and off.
>> Like llvm can turn on alu32, but without <,<=3D insns.
>> -mcpu=3Dv3 includes both. -mcpu=3Dv2 are only <,<=3D.
>>=20
>> So we need a plan B.
>=20
> Yes.
>=20
>> How about using the commit sha where support was added to the verifier
>> as a 'version' of the ISA ?
>>=20
>> We can try to use a kernel version, but backports
>> will ruin that picture.
>> Looks like upstream 'commit sha' is the only stable number.
>=20
> Using kernel release hashes is a pretty horrible interface, especially
> for non-kernel users.  I also think the compilers and other tools
> would really like some vaguely meaninfuly identifiers.
>=20
>> Another approach would be to declare the current ISA as
>> 1.0 (or bpf-isa-may-2022) and
>> in the future bump it with every new insn.
>=20
> I think that is a much more reasonable starting position.  However, are
> we sure the ISA actually evolves linearly?  As far as I can tell support
> for full atomics only exists for a few JITs so far.
>=20
> So maybe starting with a basedline, and then just have name for
> each meaningful extension (e.g. the full atomics as a start) might be
> even better.  For the Linux kernel case we can then also have a user
> interface where userspace programs can query which extensions are
> supported before loading eBPF programs that rely on them instead of
> doing a roundtrip through the verifier.
>=20
>>> - we need to decide to do about the legacy BPF packet access
>>>   instrutions.  Alexei mentioned that the modern JIT doesn't
>>>   even use those internally any more.
>>=20
>> I think we need to document them as supported in the linux kernel,
>> but deprecated in general.
>> The standard might say "implementation defined" meaning that
>> different run-times don't have to support them.
>=20
> Yeah.  If we do the extensions proposal above we could make these
> a specific extension as well.
>=20
>> [...]
>> I don't think it's worth documenting all that.
>> I would group all undefined/underflow/overflow as implementation
>> defined and document only things that matter.
>=20
> Makese sense.
>=20
>>> Discussion on where to host a definitive version of the document:
>>>=20
>>> - I think the rough consensus is to just host regular (hopefully
>>>   low cadence) documents and maybe the latest gratest at a eBPF
>>>   foundation website.  Whom do we need to work with at the fundation
>>>   to make this happen?
>>=20
>> foundation folks cc-ed.
>=20
> I'd be rally glad if we could kick off this ASAP.  Feel free to contact
> me privately if we want to keep it off the list.
>=20
>>> - as idea it was brought up to write a doument with the minimal
>>>   verification requirements required for any eBPF implementation
>>>   independent of the program type.  Again I can volunteer to
>>>   draft a documentation, but I need input on what such a consensus
>>>   would be.  In this case input from the non-Linux verifier
>>>   implementors (I only know the Microsoft research one) would
>>>   be very helpful as well.
>>=20
>> The verifier is a moving target.
>=20
> Absolutely.
>=20
>> I'd say minimal verification is the one that checks that:
>> - instructions are formed correctly
>> - opcode is valid
>> - no reserved bits are used
>> - registers are within range (r11+ are not used)
>> - combination of opcode+regs+off+imm is valid
>> - simple things like that
>=20
> Sounds good.  One useful thing for this would be an opcode table
> with all the optional field usage in machine readable format.
>=20
> Jim who is on CC has already built a nice table off all opcodes based
> on existing material that might be a good starting point.

Table is inline below.  I used the tables in the iovisor project
documentation as a starting point for this table.

https://github.com/iovisor/bpf-docs/blob/master/eBPF.md.

Feedback welcome.  The atomic sections at the bottom could especially use s=
ome
careful review for correctness.

BPF_ALU64 (opc & 0x07 =3D=3D 0x07)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
0x07		BPF_ALU64 | BPF_K | BPF_ADD	bpf_add dst, imm	dst +=3D imm
0x0f		BPF_ALU64 | BPF_X | BPF_ADD	bpf_add dst, src	dst +=3D src
0x17		BPF_ALU64 | BPF_K | BPF_SUB	bpf_sub dst, imm	dst -=3D imm
0x1f		BPF_ALU64 | BPF_X | BPF_SUB	bpf_sub dst, src	dst -=3D src
0x27		BPF_ALU64 | BPF_K | BPF_MUL	bpf_mul dst, imm	dst *=3D imm
0x2f		BPF_ALU64 | BPF_X | BPF_MUL	bpf_mul dst, src	dst *=3D src
0x37		BPF_ALU64 | BPF_K | BPF_DIV	bpf_div dst, imm	dst /=3D imm
0x3f		BPF_ALU64 | BPF_X | BPF_DIV	bpf_div dst, src	dst /=3D src
0x47		BPF_ALU64 | BPF_K | BPF_OR	bpf_or dst, imm		dst |=3D imm
0x4f		BPF_ALU64 | BPF_X | BPF_OR	bpf_or dst, src		dst |=3D src
0x57		BPF_ALU64 | BPF_K | BPF_AND	bpf_and dst, imm	dst &=3D imm
0x5f		BPF_ALU64 | BPF_X | BPF_AND	bpf_and dst, src	dst &=3D src
0x67		BPF_ALU64 | BPF_K | BPF_LSH	bpf_lsh dst, imm	dst <<=3D imm
0x6f		BPF_ALU64 | BPF_X | BPF_LSH	bpf_lsh dst, src	dst <<=3D src
0x77		BPF_ALU64 | BPF_K | BPF_RSH	bpf_lsh dst, imm	dst >>=3D imm (logical)
0x7f		BPF_ALU64 | BPF_X | BPF_RSH	bpf_lsh dst, src	dst >>=3D src (logical)
0x87		BPF_ALU64 | BPF_K | BPF_NEG	bpf_neg dst		dst =3D ~dst
0x97		BPF_ALU64 | BPF_K | BPF_MOD	bpf_mod dst, imm	dst %=3D imm
0x9f		BPF_ALU64 | BPF_X | BPF_MOD	bpf_mod dst, src	dst %=3D src
0xa7		BPF_ALU64 | BPF_K | BPF_XOR	bpf_xor dst, imm	dst ^=3D imm
0xaf		BPF_ALU64 | BPF_X | BPF_XOR	bpf_xor dst, src	dst ^=3D src
0xb7		BPF_ALU64 | BPF_K | BPF_MOV	bpf_mov dst, imm	dst =3D imm
0xbf		BPF_ALU64 | BPF_X | BPF_MOV	bpf_mov dst, src	dst =3D src
0xc7		BPF_ALU64 | BPF_K | BPF_ARSH	bpf_arsh dst, imm	dst >>=3D imm (arithme=
tic)
0xcf		BPF_ALU64 | BPF_X | BPF_ARSH	bpf_arsh dst, src	dst >>=3D src (arithme=
tic)

BPF_ALU (opc & 0x07 =3D=3D 0x04)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
0x04		BPF_ALU | BPF_K | BPF_ADD	bpf_add32 dst, imm	dst32 +=3D imm
0x0c		BPF_ALU | BPF_X | BPF_ADD	bpf_add32 dst, src	dst32 +=3D src32
0x14		BPF_ALU | BPF_K | BPF_SUB	bpf_sub32 dst, imm	dst32 -=3D imm
0x1c		BPF_ALU | BPF_X | BPF_SUB	bpf_sub32 dst, src	dst32 -=3D src32
0x24		BPF_ALU | BPF_K | BPF_MUL	bpf_mul32 dst, imm	dst32 *=3D imm
0x2c		BPF_ALU | BPF_X | BPF_MUL	bpf_mul32 dst, src	dst32 *=3D src32
0x34		BPF_ALU | BPF_K | BPF_DIV	bpf_div32 dst, imm	dst32 /=3D imm
0x3c		BPF_ALU | BPF_X | BPF_DIV	bpf_div32 dst, src	dst32 /=3D src32
0x44		BPF_ALU | BPF_K | BPF_OR	bpf_or32 dst, imm	dst32 |=3D imm
0x4c		BPF_ALU | BPF_X | BPF_OR	bpf_or32 dst, src	dst32 |=3D src32
0x54		BPF_ALU | BPF_K | BPF_AND	bpf_and32 dst, imm	dst32 &=3D imm
0x5c		BPF_ALU | BPF_X | BPF_AND	bpf_and32 dst, src	dst32 &=3D src32
0x64		BPF_ALU | BPF_K | BPF_LSH	bpf_lsh32 dst, imm	dst32 <<=3D imm
0x6c		BPF_ALU | BPF_X | BPF_LSH	bpf_lsh32 dst, src	dst32 <<=3D src32
0x74		BPF_ALU | BPF_K | BPF_RSH	bpf_lsh32 dst, imm	dst32 >>=3D imm (logical=
)
0x7c		BPF_ALU | BPF_X | BPF_RSH	bpf_lsh32 dst, src	dst32 >>=3D src32 (logic=
al)
0x84		BPF_ALU | BPF_K | BPF_NEG	bpf_neg32 dst		dst32 =3D ~dst32
0x94		BPF_ALU | BPF_K | BPF_MOD	bpf_mod32 dst, imm	dst32 %=3D imm
0x9c		BPF_ALU | BPF_X | BPF_MOD	bpf_mod32 dst, src	dst32 %=3D src32
0xa4		BPF_ALU | BPF_K | BPF_XOR	bpf_xor32 dst, imm	dst32 ^=3D imm
0xac		BPF_ALU | BPF_X | BPF_XOR	bpf_xor32 dst, src	dst32 ^=3D src32
0xb4		BPF_ALU | BPF_K | BPF_MOV	bpf_mov32 dst, imm	dst32 =3D imm
0xbc		BPF_ALU | BPF_X | BPF_MOV	bpf_mov32 dst, src	dst32 =3D src32
0xc4		BPF_ALU | BPF_K | BPF_ARSH	bpf_arsh32 dst, imm	dst32 >>=3D imm (arith=
metic)
0xcc		BPF_ALU | BPF_X | BPF_ARSH	bpf_arsh32 dst, src	dst32 >>=3D src32 (ari=
thmetic)

For BPF_END instructions, BPF_K =3D=3D htole conversion, BPF_X =3D=3D htobe=
 conversion
Operation size (16, 32, 64 bit) determined by 'imm' value of instruction (u=
pper 32 bits)

0xd4 (.imm =3D 16)	BPF_ALU | BPF_K | BPF_END	bpf_le16 dst	dst16 =3D htole16=
(dst16)
0xd4 (.imm =3D 32)	BPF_ALU | BPF_K | BPF_END	bpf_le32 dst	dst32 =3D htole32=
(dst32)
0xd4 (.imm =3D 64)	BPF_ALU | BPF_K | BPF_END	bpf_le64 dst	dst =3D htole64(d=
st)
0xdc (.imm =3D 16)	BPF_ALU | BPF_X | BPF_END	bpf_be16 dst	dst16 =3D htobe16=
(dst16)
0xdc (.imm =3D 32)	BPF_ALU | BPF_X | BPF_END	bpf_be32 dst	dst32 =3D htobe32=
(dst32)
0xdc (.imm =3D 64)	BPF_ALU | BPF_X | BPF_END	bpf_be64 dst	dst =3D htobe64(d=
st)

BPF_JMP (opc & 0x07 =3D=3D 0x05)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
0x05		BPF_JMP | BPF_K | BPF_JA	bpf_ja +off			PC +=3D off
0x15		BPF_JMP | BPF_K | BPF_JEQ	bpf_jeq dst, imm, +off		PC +=3D off if dst =
=3D=3D imm
0x1d		BPF_JMP | BPF_X | BPF_JEQ	bpf_jeq dst, src, +off		PC +=3D off if dst =
=3D=3D src
0x25		BPF_JMP | BPF_K | BPF_JGT	bpf_jgt dst, imm, +off		PC +=3D off if dst =
> imm
0x2d		BPF_JMP | BPF_X | BPF_JGT	bpf_jgt dst, src, +off		PC +=3D off if dst =
> src
0x35		BPF_JMP | BPF_K | BPF_JGE	bpf_jge dst, imm, +off		PC +=3D off if dst =
>=3D imm
0x3d		BPF_JMP | BPF_X | BPF_JGE	bpf_jge dst, src, +off		PC +=3D off if dst =
>=3D src
0x45		BPF_JMP | BPF_K | BPF_JSET	bpf_jset dst, imm, +off		PC +=3D off if ds=
t & imm
0x4d		BPF_JMP | BPF_X | BPF_JSET	bpf_jset dst, src, +off		PC +=3D off if ds=
t & src
0x55		BPF_JMP | BPF_K | BPF_JNE	bpf_jne dst, imm, +off		PC +=3D off if dst =
!=3D imm
0x5d		BPF_JMP | BPF_X | BPF_JNE	bpf_jne dst, src, +off		PC +=3D off if dst =
!=3D src
0x65		BPF_JMP | BPF_K | BPF_JSGT	bpf_jsgt dst, imm, +off		PC +=3D off if ds=
t > imm (signed)
0x6d		BPF_JMP | BPF_X | BPF_JSGT	bpf_jsgt dst, src, +off		PC +=3D off if ds=
t > src (signed)
0x75		BPF_JMP | BPF_K | BPF_JSGE	bpf_jsge dst, imm, +off		PC +=3D off if ds=
t >=3D imm (signed)
0x7d		BPF_JMP | BPF_X | BPF_JSGE	bpf_jsge dst, src, +off		PC +=3D off if ds=
t >=3D src (signed)
0x85		BPF_JMP | BPF_K | BPF_CALL	bpf_call imm			Function call
0x95		BPF_JMP | BPF_K | BPF_EXIT	bpf_exit			return r0
0xa5		BPF_JMP | BPF_K | BPF_JLT	bpf_jlt dst, imm, +off		PC +=3D off if dst =
< imm
0xad		BPF_JMP | BPF_X | BPF_JLT	bpf_jlt dst, src, +off		PC +=3D off if dst =
< src
0xb5		BPF_JMP | BPF_K | BPF_JLE	bpf_jle dst, imm, +off		PC +=3D off if dst =
<=3D imm
0xbd		BPF_JMP | BPF_X | BPF_JLE	bpf_jle dst, src, +off		PC +=3D off if dst =
<=3D src
0xc5		BPF_JMP | BPF_K | BPF_JSLT	bpf_jslt dst, imm, +off		PC +=3D off if ds=
t < imm (signed)
0xcd		BPF_JMP | BPF_X | BPF_JSLT	bpf_jslt dst, src, +off		PC +=3D off if ds=
t < src (signed)
0xd5		BPF_JMP | BPF_K | BPF_JSLE	bpf_jsle dst, imm, +off		PC +=3D off if ds=
t <=3D imm (signed)
0xdd		BPF_JMP | BPF_X | BPF_JSLE	bpf_jsle dst, src, +off		PC +=3D off if ds=
t <=3D src (signed)

BPF_JMP32 (opc & 0x07 =3D=3D 0x06)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
0x16		BPF_JMP32 | BPF_K | BPF_JEQ	bpf_jeq32 dst, imm, +off	PC +=3D off if d=
st32 =3D=3D imm
0x1e		BPF_JMP32 | BPF_X | BPF_JEQ	bpf_jeq32 dst, src, +off	PC +=3D off if d=
st32 =3D=3D src32
0x26		BPF_JMP32 | BPF_K | BPF_JGT	bpf_jgt32 dst, imm, +off	PC +=3D off if d=
st32 > imm
0x2e		BPF_JMP32 | BPF_X | BPF_JGT	bpf_jgt32 dst, src, +off	PC +=3D off if d=
st32 > src32
0x36		BPF_JMP32 | BPF_K | BPF_JGE	bpf_jge32 dst, imm, +off	PC +=3D off if d=
st32 >=3D imm
0x3e		BPF_JMP32 | BPF_X | BPF_JGE	bpf_jge32 dst, src, +off	PC +=3D off if d=
st32 >=3D src32
0x46		BPF_JMP32 | BPF_K | BPF_JSET	bpf_jset32 dst, imm, +off	PC +=3D off if=
 dst32 & imm
0x4e		BPF_JMP32 | BPF_X | BPF_JSET	bpf_jset32 dst, src, +off	PC +=3D off if=
 dst32 & src32
0x56		BPF_JMP32 | BPF_K | BPF_JNE	bpf_jne32 dst, imm, +off	PC +=3D off if d=
st32 !=3D imm
0x5e		BPF_JMP32 | BPF_X | BPF_JNE	bpf_jne32 dst, src, +off	PC +=3D off if d=
st32 !=3D src32
0x66		BPF_JMP32 | BPF_K | BPF_JSGT	bpf_jsgt32 dst, imm, +off	PC +=3D off if=
 dst32 > imm (signed)
0x6e		BPF_JMP32 | BPF_X | BPF_JSGT	bpf_jsgt32 dst, src, +off	PC +=3D off if=
 dst32 > src32 (signed)
0x76		BPF_JMP32 | BPF_K | BPF_JSGE	bpf_jsge32 dst, imm, +off	PC +=3D off if=
 dst32 >=3D imm (signed)
0x7e		BPF_JMP32 | BPF_X | BPF_JSGE	bpf_jsge32 dst, src, +off	PC +=3D off if=
 dst32 >=3D src32 (signed)
0xa6		BPF_JMP32 | BPF_K | BPF_JLT	bpf_jlt32 dst, imm, +off	PC +=3D off if d=
st32 < imm
0xae		BPF_JMP32 | BPF_X | BPF_JLT	bpf_jlt32 dst, src, +off	PC +=3D off if d=
st32 < src32
0xb6		BPF_JMP32 | BPF_K | BPF_JLE	bpf_jle32 dst, imm, +off	PC +=3D off if d=
st32 <=3D imm
0xbe		BPF_JMP32 | BPF_X | BPF_JLE	bpf_jle32 dst, src, +off	PC +=3D off if d=
st32 <=3D src32
0xc6		BPF_JMP32 | BPF_K | BPF_JSLT	bpf_jslt32 dst, imm, +off	PC +=3D off if=
 dst32 < imm (signed)
0xce		BPF_JMP32 | BPF_X | BPF_JSLT	bpf_jslt32 dst, src, +off	PC +=3D off if=
 dst32 < src32 (signed)
0xd6		BPF_JMP32 | BPF_K | BPF_JSLE	bpf_jsle32 dst, imm, +off	PC +=3D off if=
 dst32 <=3D imm (signed)
0xde		BPF_JMP32 | BPF_X | BPF_JSLE	bpf_jsle32 dst, src, +off	PC +=3D off if=
 dst32 <=3D src32 (signed)

BPF_LD (opc & 0x07 =3D=3D 0x00)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
0x18		BPF_LD | BPF_DW | BPF_IMM	bpf_lddw dst, imm64		dst =3D imm64
Note: imm64 expressed in 8 bytes following instruction

BPF_LDX (opc & 0x07 =3D=3D 0x01)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
0x61		BPF_LDX | BPF_W | BPF_MEM	bpf_ldxw dst, [src + off]	dst32 =3D *(u32 *=
)(src + off)
0x69		BPF_LDX | BPF_H | BPF_MEM	bpf_ldxh dst, [src + off]	dst16 =3D *(u16 *=
)(src + off)
0x71		BPF_LDX | BPF_B | BPF_MEM	bpf_ldxb dst, [src + off]	dst8 =3D *(u8 *)(=
src + off)
0x79		BPF_LDX | BPF_DW | BPF_MEM	bpf_ldxdw dst, [src + off]	dst =3D *(u64 *=
)(src + off)

BPF_ST (opc & 0x07 =3D=3D 0x02)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
0x62		BPF_ST | BPF_W | BPF_IMM	bpf_stw [dst + off], imm	*(u32 *)(dst + off)=
 =3D imm
0x6a		BPF_ST | BPF_H | BPF_IMM	bpf_sth [dst + off], imm	*(u16 *)(dst + off)=
 =3D imm
0x72		BPF_ST | BPF_B | BPF_IMM	bpf_stb [dst + off], imm	*(u8 *)(dst + off) =
=3D imm
0x7a		BPF_ST | BPF_DW | BPF_IMM	bpf_stdw [dst + off], imm	*(u64 *)(dst + of=
f) =3D imm

BPF_STX (opc & 0x07 =3D=3D 0x03)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
0x63		BPF_STX | BPF_W | BPF_MEM	bpf_stxw [dst + off], src	*(u32 *)(dst + of=
f) =3D src32
0x6b		BPF_STX | BPF_H | BPF_MEM	bpf_stxh [dst + off], src	*(u16 *)(dst + of=
f) =3D src16
0x73		BPF_STX | BPF_B | BPF_MEM	bpf_stxb [dst + off], src	*(u8 *)(dst + off=
) =3D src8
0x7b		BPF_STX | BPF_DW | BPF_MEM	bpf_stxdw [dst + off], src	*(u64 *)(dst + =
off) =3D src
0xdb		BPF_STX | BPF_DW | BPF_ATOMIC	64-bit atomic instructions (see below)
0xc3		BPF_STX | BPF_W | BPF_ATOMIC	32-bit atomic instructions (see below)

Note: mnemonic for atomic instructions?  for example, eBPF originally had o=
nly XADD atomic instruction which could be
represented as bpf_xadd.  But with addition of atomic operations for AND, O=
R, XOR - that same pattern no longer works.
So for now, just show pseudocode for each atomic operation.

64-bit atomic instructions (opc =3D=3D 0xdb)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The following table applies to opc 0xdb (BPF_STX | BPF_DW | BPF_ATOMIC) whi=
ch are 64-bit atomic operations.
The imm (immediate) value in column 1 specifies the type of atomic operatio=
n.

0x00	BPF_ADD			lock *(u64 *)(dst + off) +=3D src
0x01	BPF_ADD | BPF_FETCH	src =3D atomic_fetch_add((u64 *)(dst + off), src)
0x40	BPF_OR			lock *(u64 *)(dst + off) |=3D src
0x41	BPF_OR | BPF_FETCH	src =3D atomic_fetch_or((u64 *)(dst + off), src)
0x50	BPF_AND			lock *(u64 *)(dst + off) &=3D src
0x51	BPF_AND | BPF_FETCH	src =3D atomic_fetch_and((u64 *)(dst + off), src)
0xa0	BPF_XOR			lock *(u64 *)(dst + off) ^=3D src
0xa1	BPF_XOR | BPF_FETCH	src =3D atomic_fetch_xor((u64 *)(dst + off), src)
0xe1	BPF_XCHG | BPF_FETCH	src =3D xchg((u64 *)(dst + off), src)
0xf1	BPF_CMPXCHG | BPF_FETCH	r0 =3D cmpxchg((u64 *)(dst + off), r0, src)

32-bit atomic instructions (opc =3D=3D 0xc3)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The following table applies to opc 0xc3 (BPF_STX | BPF_W | BPF_ATOMIC) whic=
h are 32-bit atomic operations.
The imm (immediate) value in column 1 specifies the type of atomic operatio=
n.

0x00	BPF_ADD			lock *(u32 *)(dst + off) +=3D src32
0x01	BPF_ADD | BPF_FETCH	src32 =3D atomic_fetch_add((u32 *)(dst + off), src=
32)
0x40	BPF_OR			lock *(u32 *)(dst + off) |=3D src32
0x41	BPF_OR | BPF_FETCH	src32 =3D atomic_fetch_or((u32 *)(dst + off), src32=
)
0x50	BPF_AND			lock *(u32 *)(dst + off) &=3D src32
0x51	BPF_AND | BPF_FETCH	src32 =3D atomic_fetch_and((u32 *)(dst + off), src=
32)
0xa0	BPF_XOR			lock *(u32 *)(dst + off) ^=3D src32
0xa1	BPF_XOR | BPF_FETCH	src32 =3D atomic_fetch_xor((u32 *)(dst + off), src=
32)
0xe1	BPF_XCHG | BPF_FETCH	src32 =3D xchg((u32 *)(dst + off), src32)
0xf1	BPF_CMPXCHG | BPF_FETCH	r0 =3D cmpxchg((u32 *)(dst + off), r0, src32)


