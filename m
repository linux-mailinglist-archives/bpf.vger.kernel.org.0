Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3157651C
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGOQJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiGOQJf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 12:09:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF9286C2
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657901372; x=1689437372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PAFX7GWTDXwHWu4tgo+969n7A/PsEf6vh/w+ZG5c/5k=;
  b=YwVKP1QA51pNv4TYQR+9uW5XKlM5cUHLqI7r1qtqb2Y2XQ04NMyesqTH
   BUeugfk1Q7Iswn0YQLQr4x4c8/+kdTeDYbp0YEm7QuEWvKIrm02NMZ0/9
   mxsc3/GdFmQvmJj6F7mvbKlWSoxvYWn2mSDDanb0/RnLncsra7KGYRjaa
   T5WhTU83oa15aNnZn1eRJ9EkyFbolyLwD+gvrsZr4ggaEgEcRDQWWfKST
   U2+MnT7W3AjGS/DP2wrrfYGhiwcq7xg6ASIXDWzs/xE4eke3nBV6CgUvA
   iE325NXVlrXXhzAo/keW48LkEBx9QVypIT536c0abNy10zwzKz4h0IQ1l
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286968684"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="286968684"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 09:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="723126772"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2022 09:08:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 09:08:39 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 09:08:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Jul 2022 09:08:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Jul 2022 09:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8vqz7Qh+qcRSrqk28q+cqaWNjTTE40Qc9uWcLm5YF5uMJu9P7QGHzUpUrX1hTZmDSjPQNIvUUN1PHk/xnslyU3CiT00S2RPFAaNl53dGmw4bFLMW4IM5DudRph/Jh5g+5RlTu7oyEcxWt/yg1a39WyMRLofH0r54qDZ+A7s+lfH/ZsHoxu4/AyX1NfWaRevgXcNLcH6UJqdGb+ODRyRxe4Eas0Mv6FnhrV7oPAAfjis8nTV6l42+fCnFsvNI7RKk2JcYn9Flz+6whofW/6LwpArIYQn8U0vkgnRNbBjXVI52OHAJGXny7BnPJVLtNHA2i7l3fLVkz2XYlagQFQpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6EThFrdjaiCz8mE2tyXYMbsUPrMQvsFgOzgfYzn0V8=;
 b=fHiIE43/Rd5Z4xJsi26de87RNappf91yJS4iaUv/RQpoDnUN2SlBpjhMQbVChF6tFil+a+cqyZkxOz2O5LtaE/cyxPjp+wpmL0D7JwNa6XJO3IIr6b7wMlkEJ+7vyALJrohu3sq4QKoWKiFS9eSjCjVASx4DLHX+GBs1sLjmvUfwlhQKhM7+4/YUHH/th5eoGxOQvoliLZgzUOtAT5JdCREZP75Aqu8yegvvy+YdaEJt1o8FK9/TD6CzeQlHOSgN/t/FYp0FKQhFGzYbZYKc6jvUIGmS6MmHXd9u622pYZLZjcpGiyCvlk4EwChd3JMzj1jvndN6QRLqzkwU+vpFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR11MB1633.namprd11.prod.outlook.com (2603:10b6:405:e::22)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 16:08:37 +0000
Received: from BN6PR11MB1633.namprd11.prod.outlook.com
 ([fe80::d04:1ded:6b5d:9257]) by BN6PR11MB1633.namprd11.prod.outlook.com
 ([fe80::d04:1ded:6b5d:9257%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 16:08:36 +0000
From:   "Zeng, Oak" <oak.zeng@intel.com>
To:     Jiri Olsa <olsajiri@gmail.com>
CC:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: Build error of samples/bpf
Thread-Topic: Build error of samples/bpf
Thread-Index: AdiV9eTYhI73n+WtTH2WQRFEfo/oRgAAE/pgADvGywAARURlgAAKif0AAA5JJ0A=
Date:   Fri, 15 Jul 2022 16:08:36 +0000
Message-ID: <BN6PR11MB16331C4FFDCDF903060EC910928B9@BN6PR11MB1633.namprd11.prod.outlook.com>
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <CAP01T77ZDk8kHGhAy4V1tht0JHqefkmKLdKtKPHj1mJ_shDMhQ@mail.gmail.com>
 <BN6PR11MB163373657888237AB489C996928B9@BN6PR11MB1633.namprd11.prod.outlook.com>
 <YtEkosDJ2O0CXlL/@krava>
In-Reply-To: <YtEkosDJ2O0CXlL/@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c567de91-565b-409a-5eaf-08da667c4657
x-ms-traffictypediagnostic: CO1PR11MB4849:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zm6NJ7UKniUGa3oscraDZh+z1rDypJPSNIFb77Zc1ajyg0+S/V0EqF9X0o9D4YHtTopio7DHNrZTozzE3iRW8eWP6AXoqYE8AZWaREjyljYFmg1yx7IhCtNeLUXBY9TZ0U/hIrlQNbnfJdya21zyCHYOc+cwlTbW4LXOyqIYq6yeMKrN+IQSG5RvEMscerETNiOw7rwhyzaYF8I8nmXT9/yoHjhOHijStfFxAKRjI4hpuBfB0d6mEyqDa4YC4Ys4GBMLLfByPx7ALa9NYmOG8ApyvavAQ6A/q6YxhKcp6IYiHXc/k2ZT+Tl4DYv8y8w+v0cxcPszA0DZ+jCjPPR06nMQPnML0f8qk2VMxCS63uKBIzkSPJJ524JEg/ML+NUTbE+fZjJYk7fkqFS+V4sVSUK8ag3oq7TxR82mA6wY+h8A18JpXKdu4VkMobUhMv5eCTaT00Cs2ZgTHpATkCxii9uBnpfc3Y4cwVXr/gSMz5jf/0WJQI8eCErDl2c95iA7jm6LaFIGGIF/RCJ8pVASMELTZt46M6Y5zggh7XHAp8ZlmMguXO/JX0z0nHTnX8SrZWv8TMpdl/UtDkXvCF9WdYQbsDZf2aQ+N8xbvyH/o3jZqmc+gzHQQlQnGWuAngye51ZOQ0ScN2aoZO2a/uD6TeKfYhhMhdrgDpkbl7mPbu3nsO+vgj2KNmr/Z8xv5lDTwY3Rv44LlDS8BnX8ZNe+vssGKLfQhnpSAwo2moH3JzJNuJ7ZwbV7lHE7BwEmhngqogPIa9AL4joX0m0VOgrBGwHcB3liVlFHKfQD0fuB8RNsM1vPndFxyBP5jl66Si3rmmKF9Nxw9FbWl4/V/Byuini0tx7RwWBcDeiHpaeq9u8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1633.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(39860400002)(366004)(396003)(6916009)(6506007)(54906003)(9686003)(64756008)(478600001)(122000001)(966005)(86362001)(76116006)(66556008)(66446008)(66476007)(53546011)(5660300002)(41300700001)(38100700002)(52536014)(26005)(66946007)(7696005)(316002)(71200400001)(38070700005)(83380400001)(8676002)(2906002)(8936002)(4326008)(186003)(82960400001)(33656002)(66574015)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q73ZXNcd9UHBDScxn/p/6z4olr8NE8bo7FN5URUJT52bXAf1TbhDs4tOiciq?=
 =?us-ascii?Q?7SqRwfI5Xy4qt+N87s6issqgAtKo1tiaMBE3JMRZ/OAtNcIUcgFJ3Iuc2wK6?=
 =?us-ascii?Q?ANiFsmjuf4rkkkSsF+D5grnkyfMaQLWaI9cujo1/+gSlX3412B9ZlIhP/F5c?=
 =?us-ascii?Q?5+akDe61xq4i6VdLoxKpoGvLagyMbiVsg5VzoVPsW6gGjIiHaDBuLdgLBem0?=
 =?us-ascii?Q?5j8Bbq08954fMaClfpL8BKYdkPQGDeVG5AhYzgPC8pvbn4BeXT0tDFC3D7BM?=
 =?us-ascii?Q?jk/1EfXbU7hgVx+6T2jm6UNsKfrMnGaxl2zc5O5Ja0Wq+cW3DZZ3+HmxPTo9?=
 =?us-ascii?Q?sLYMNNvDJwFY8OJK2QzH43cgKyrQEM5sjyFHz/qTwZnF8l2q1ORyIZ8pkniy?=
 =?us-ascii?Q?D3i2wNvg/22TGNp0FNvjpZBdLPAQ1y9YhCJ2+vXf/ibFmJXzVf6Qvf9Fktx7?=
 =?us-ascii?Q?1TJwGxZcF//fG5NJv+EkNHPMIIC1DkESWHnuEwZdAHMuGLE+eO5IIgCqyNUl?=
 =?us-ascii?Q?5W257GE2XVz8cCQE1PNeakExcSeaph0iwErIrPF51p42YVkCgoyAvmG5RLi9?=
 =?us-ascii?Q?rElZLfo/5t+gUcfU41CDFxU9tFTs2+aaa36k2aofGyqLAkTVt8lG3LN7ACFc?=
 =?us-ascii?Q?bD6iQ4iQ1P7ZFPVQPpXYOEuJiu/K8Np4j1YWZsAKJ4M3qjYS8f42p9/247m+?=
 =?us-ascii?Q?C1t1+XgKu/eWEfYEJaLffEE3r1PfHMIVWUllLoSUscBiZbnUr3otbw7U60Tw?=
 =?us-ascii?Q?Y9QMzr2A9c4B6VkUdCF6V+44g0+Kd7nE3NvFtL7pG20WE0fjOexfxorl2686?=
 =?us-ascii?Q?rzh4fhDuunXJR8bDYaCTME5CmEf8ORA3Wozk4THumdMgQ6yuG9yCImniG4TF?=
 =?us-ascii?Q?/DysQiiHHCi41nuQzjKvrdPpT3artI4jDod5OA/ixBvCtXiR3chxuEajmvJZ?=
 =?us-ascii?Q?7JWIZDHAW3j7iWor3fqv3He6bM/AndYVs2P1vtsA9FGf2F1JuAmAeKfy+XZf?=
 =?us-ascii?Q?0zlYHOExSOtUnpj1SVQYFKzjasxdA4ftDB13D7QpQk1y+wWNEShC0L3jzE4h?=
 =?us-ascii?Q?vrD1G5HgRF+rkddwh9k7QmciIqTkplDLj5mWMGAT83lULqBwTB0PVhFPBfTl?=
 =?us-ascii?Q?PXtprNmHtl7IT8DN3p0RnCZFTNZuMAeiWW9iGJcS5pgDWp9xcZpTjpQSgOXQ?=
 =?us-ascii?Q?fnWc3P6rG48tGVxT6t9L7vG+vqyFIVnrL/a3rMEhLPXOglGVpnYcTbEMaQkP?=
 =?us-ascii?Q?jlyulUyv0BzIzXikNNYVv6N5dk4eQI/XfjjMf0rLG0yZpGpd+mIK919Rzn+C?=
 =?us-ascii?Q?Oikb/l6yhkgI7+PNufCLvyupbBFaTLHl1b8h05ILm/Wv9JOMm096LXnqFFvh?=
 =?us-ascii?Q?XfBeONklyAnU2OPMf2/qy5j0NUY92Wxxxv6N7nNYwM1PA2MiPzByMpDCRFiv?=
 =?us-ascii?Q?fhoDYNKYaKs/Gn1HlVGksU2l2SdEoQaFf3360FrrJh9Rlufi4uE6h0De0foM?=
 =?us-ascii?Q?PQLuP5ibwN0GLhQe/8WSp39pUANDE+h1rz0tuR+lviXq9iNyZ+5KagrAYG1X?=
 =?us-ascii?Q?7Xjn3Hj2//J4UbPOXi4aFKIIGETo5szrUMlQ8rYY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1633.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c567de91-565b-409a-5eaf-08da667c4657
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 16:08:36.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMzkKxOYpuW6qFK4deD9xmC5KUQytw1i7bs9MjwC3pvuiI3eJ2DzWyim7z/7kYBRMk4Y9Sxvb0yssyKmLHGz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Thanks,
Oak

> -----Original Message-----
> From: Jiri Olsa <olsajiri@gmail.com>
> Sent: July 15, 2022 4:26 AM
> To: Zeng, Oak <oak.zeng@intel.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>; bpf@vger.kernel.org
> Subject: Re: Build error of samples/bpf
>=20
> On Fri, Jul 15, 2022 at 03:54:42AM +0000, Zeng, Oak wrote:
>=20
> SNIP
>=20
> > > >   CC  samples/bpf/xdp_router_ipv4_user.o
> > > >   CC  samples/bpf/xdp_rxq_info_user.o
> > > >   CC  samples/bpf/xdp_sample_pkts_user.o
> > > >   CC  samples/bpf/xdp_tx_iptunnel_user.o
> > > >   CC  samples/bpf/xdpsock_ctrl_proc.o
> > > >   CC  samples/bpf/xsk_fwd.o
> > > >   CLANG-BPF  samples/bpf/xdp_sample.bpf.o
> > > >   CLANG-BPF  samples/bpf/xdp_redirect_map_multi.bpf.o
> > > >   CLANG-BPF  samples/bpf/xdp_redirect_cpu.bpf.o
> > > >   CLANG-BPF  samples/bpf/xdp_redirect_map.bpf.o
> > > >   CLANG-BPF  samples/bpf/xdp_monitor.bpf.o
> > > >   CLANG-BPF  samples/bpf/xdp_redirect.bpf.o
> > > >   BPF GEN-OBJ  samples/bpf/xdp_monitor
> > > >   BPF GEN-SKEL samples/bpf/xdp_monitor
> > > > libbpf: map 'rx_cnt': unexpected def kind var.
> > >
> > > IIRC, this error is due to older clang. Can you try with a newer clan=
g
> > > (11 and above)?
> >
> > Thank you Kumar.
> >
> > I updated to llvm/clang to version 12, the issue persists.
> >
> > I also have another problem... To build those xdp samples, I need to en=
able
> CONFIG_DEBUG_INFO_BTF. But once this is enabled, I failed to build linux
> kernel with below errors. I was able to build on a 4.15 ubuntu machine bu=
t on
> a 5.11  ubuntu machine, I had below error to build the same kernel. Any o=
ne
> can give me some hint? I searched google but didn't figure out. I noticed
> somethings is killed during build of .bpf.vmlinux.bin.o, so I guess some =
of my
> tools is not updated?
> >
> >
> >
> > szeng@szeng-develop:~/dii-tools/linux$ make -j$(nproc)
> >   DESCEND objtool
> >   DESCEND bpf/resolve_btfids
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   UPD     include/generated/compile.h
> >   CC      init/version.o
> >   AR      init/built-in.a
> >   CHK     kernel/kheaders_data.tar.xz
> >   GEN     .version
> >   CHK     include/generated/compile.h
> >   UPD     include/generated/compile.h
> >   CC      init/version.o
> >   AR      init/built-in.a
> >   LD      vmlinux.o
> >   MODPOST vmlinux.symvers
> >   MODINFO modules.builtin.modinfo
> >   GEN     modules.builtin
> >   LD      .tmp_vmlinux.btf
> >   BTF     .btf.vmlinux.bin.o
> > Killed
>=20
> looks like something happened during BTF generation and that's
> probably the reason why 'BTFIDS' is failing below
>=20
> I'd double check with V=3D1 and if it's pahole that's killed,
> I'd check that you can run it properly.. maybe some library
> mismatch? or try to build and install the latest pahole

Hi Jiri,

Thanks for your reply. Yes the problem was a old version of pahole (v 1.21)=
. After installed pahole 1.23 above issue disappeared.

But when I build xdp samples, below error still persist even I updated llvm=
 to version 12 or 14. Anyone had the same issue?

  CLANG-BPF  samples/bpf/xdp_redirect.bpf.o
  BPF GEN-OBJ  samples/bpf/xdp_monitor
  BPF GEN-SKEL samples/bpf/xdp_monitor
libbpf: map 'rx_cnt': unexpected def kind var.
Error: failed to open BPF object file: Invalid argument
make[1]: *** [samples/bpf/Makefile:439: samples/bpf/xdp_monitor.skel.h] Err=
or 255
make[1]: *** Deleting file 'samples/bpf/xdp_monitor.skel.h'
make: *** [Makefile:1868: samples/bpf] Error 2

>=20
> there was similar issue recently:
>   https://lore.kernel.org/bpf/CAJQ9wQ-
> 0UUAqzyB5P9Xy_0=3Dhpxg9m+2OEzAmk2nWnoX9es9Gnw@mail.gmail.com/T
> /#t
>=20
> jira
>=20
>=20
> >   LD      .tmp_vmlinux.kallsyms1
> >   KSYMS   .tmp_vmlinux.kallsyms1.S
> >   AS      .tmp_vmlinux.kallsyms1.S
> >   LD      .tmp_vmlinux.kallsyms2
> >   KSYMS   .tmp_vmlinux.kallsyms2.S
> >   AS      .tmp_vmlinux.kallsyms2.S
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > FAILED: load BTF from vmlinux: No such file or directory
> > make: *** [Makefile:1183: vmlinux] Error 255
> > make: *** Deleting file 'vmlinux'
> >
> >
> > Thanks,
> > Oak
> >
> > >
> > > > Error: failed to open BPF object file: Invalid argument
> > > > samples/bpf/Makefile:430: recipe for target
> > > 'samples/bpf/xdp_monitor.skel.h' failed
> > > > make[1]: *** [samples/bpf/xdp_monitor.skel.h] Error 255
> > > > make[1]: *** Deleting file 'samples/bpf/xdp_monitor.skel.h'
> > > > Makefile:1868: recipe for target 'samples/bpf' failed
> > > > make: *** [samples/bpf] Error 2
> > > >
> > > >
> > > > Thanks,
> > > > Oak
> > > >
