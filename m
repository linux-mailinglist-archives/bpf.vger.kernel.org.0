Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168E5571BB2
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiGLNuO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiGLNuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 09:50:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832A9B1A5
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657633812; x=1689169812;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1dvnhY+yCCbjYjxxmiuGVy/gTrNzRlnQ04lbkUMBjus=;
  b=avPxXn7he35LoDjPkg3jV1usuzkDpushs/w0xJUO6Qzo8yacHDtB1p+k
   FXydkKRSzYFyq+k0Or+TXDKVeubL0OaZzab9aMaqitaqR7fQGJHkrV5zH
   M8c1DKkaEy55o3oaMXOutCU6O4n10nC3Ze6i07ViF3PbGXgSTW+/pHdAq
   ucLydFWHq82RQN5XEsZkhJ/KLRbeNFxdaoXBwxgki9g8Q7jJyrtxKS8HM
   wVWqIgdppqKL4wBr++42MvQMUe9EVmOlBm5M4fxvcxMTXffIxWJJLv7JO
   U41WvqFnQziWRi/wEiQqgkNRiDQLZFE7tY1GR4GRvCoPapbqqdvnPKtWr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310555926"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="310555926"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 06:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="652919822"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2022 06:50:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 06:50:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 06:50:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Jul 2022 06:50:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Jul 2022 06:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjxpaPd+Xz3CIqJW4tvhTgzdy9EQs85D0QjN/jZ4LnQwuUzIgBSVa+3/TTdnO2bO38Qv/91DB8/bu+1FGgng2qhXukvdTs7lIPD32NyigM/qJGTteDdRV7+1vAaypFkqYSu4VZARM47En7bpgcAnz7TdXlt1H5o9q4xlnBt1UX02OiStQIoeAbGc75oa++vlUhOEHusMVggWelvWmQrsZGxZQk7RNTjkGMpyHmNhIHDrT2Ok8zhIl5gxLB/6Uz6x/Erd5PZ1pxPjl//BQQ5zVuWz9IS4KmW1ixWT3I+8CNP0x6QCVpF/qooGaHpeMs5M3ecX6c5MQ+z7A9wSYXS8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/FR9KECm/8h7GTcRxhEb1bCRkAOssIjeg5r+TNR9KQ=;
 b=SuZioqIy03BPiilPE0P+Ov52ybLVpXuP6F5b3NoIPKtMtY9v5DSJa9RRXPMO/u4TXU/fNJSxJVNyxKdpcN0gN5oOHnwL5tchjFv96o9f+FZ/8V9NWeJpRK0uGfM8XCceUzEH29WwdsoZrR4vyugxGpP61F0U6U+Qg7lRNsw2AsnxDoDal7cjCYG/sKHwXynvsLi/W0Uz+cJmECh6xqmudBzBK60M4o3KyQ9zrFq/inAUahaMfh6oDH9dyRpyS8MQf0qush7XbVXNYo6g/6pRoRvMqWoeKGUg95PBuOc/KzD4iDL4jXVC9+Afl7ZaGxBQC4zUZlpSvAcnLaFFeZTTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR11MB1633.namprd11.prod.outlook.com (2603:10b6:405:e::22)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 13:50:05 +0000
Received: from BN6PR11MB1633.namprd11.prod.outlook.com
 ([fe80::d04:1ded:6b5d:9257]) by BN6PR11MB1633.namprd11.prod.outlook.com
 ([fe80::d04:1ded:6b5d:9257%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:50:05 +0000
From:   "Zeng, Oak" <oak.zeng@intel.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Build error of samples/bpf
Thread-Topic: Build error of samples/bpf
Thread-Index: AdiV9eTYhI73n+WtTH2WQRFEfo/oRgAAE/pg
Date:   Tue, 12 Jul 2022 13:50:05 +0000
Message-ID: <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 3ce95c3c-c72b-4114-270f-08da640d6d4d
x-ms-traffictypediagnostic: SA2PR11MB5035:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Pd1wGI1ekGMyMQo40Mi/F3exshKuyeEBCtEvBzzyyBQS7l7cpMY1XrTUn3PDyOl7ibfZtYh9IcjfGC6IJGclMGVwibI+r+02dgyh0LQI5Zfx0/Dfo6T6HBgFZvcXPf71kqnpv4xwfFJwFUR3CKG+qwMI7i9V8bQhKuNaKwXCM9Z4kbhzeQJSGrNX6YO8RH6gJz1MfsGRwRDbzn/zxnk2VIikv1xNsPUjKAOmURlKQFzslbj5TUWNSbaxpMfvst2j1xLBrntZJuhxurdzLESBlqVVt4J5nOQ2jpkspIONQVSIxbhMe65N4jyuuUfQCn2le/u/YY4YCk6TZNssHePHHGwVgKYbhNtTns2L2iHaEq6qDBdRgwm4H26kg//QsAlKmL50/fmBXE6KZjYDARGGwwFQZZtjPDgWS2DWmsNHgOJZJuAk21tIG7rdAJvxA23xpsdW3v+EfY5gb6z7laYIAu2B3TfiPGocbw50GncLWWS6QgP5lFyxa8KSE5Bi3fRzJlCOaSEocXQlgJAOSjwYIog63syVVRCO/ISpyLPsCB2sN5fPjUV+fZfOhBICkwpOWNVTLq7FKSYZpXGanz6MMS1V8hJnW+VVQZd5mUKI2mVYj1D5sN2XvSbwDa2SMxVhDwEXFKBkoVRzaEv4UeqC/DgH+x97c1Gc9B/IYbYBUtDEHUDIKvRUOqeWLjXULxtiE9ixz5Oe1PgXobaaivTXUdqN0RFVbMexmi9z1zfwHV87VRXXU7+/MJaRkVCUpG22GcdzPX/OxDAg1O4DDLMZIKst6/trvpJ8WAwjqOO/yivWL8I5tXzOQOsTDUuT4V1BQNoVE0mHkpHHYjjrCDAdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1633.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(366004)(346002)(39860400002)(82960400001)(86362001)(122000001)(26005)(52536014)(38070700005)(33656002)(7696005)(186003)(9686003)(2940100002)(66574015)(55016003)(38100700002)(66556008)(478600001)(966005)(6916009)(66476007)(71200400001)(8676002)(41300700001)(66946007)(66446008)(64756008)(5660300002)(8936002)(76116006)(83380400001)(316002)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/s2Lw5/iNjXKpAb8eBlg29AziOpG6xXf06T/3FKevsdpknuf2wpLrFqMYdeg?=
 =?us-ascii?Q?fDv/Ih6DQcL+yyb9lFOmMeHXsvsCcORZuvLXl4+ekq8ayAOON6jJ97pQDBPj?=
 =?us-ascii?Q?n6IZMldFaTnk7/MXZt5UFa58mp+SOI0iFbQT4UEYw9CJCNcSX5L8HGuLzXB/?=
 =?us-ascii?Q?d9br4cKJZumoh5B7obG/o1xmnKHmDXnIYfrw3GDQyh7ALw1A0uulO9tyWJ4g?=
 =?us-ascii?Q?rfVm1Wj3fzwE9ZCBMZC2EQLlSJEgJxCq67KtD/ytUxRWXxsO/HPQIDTUYJ0M?=
 =?us-ascii?Q?+EG2Mv0XTLEbXQagdka0ntA4HqNT8JtX5vpXIxprnMVsJc2tKqOfy6KNUVkA?=
 =?us-ascii?Q?nkC8qSPezH2xk7sZ3DHM0+TQ+wrbtaigapI8nF+NiwIYEgsrQpn1y5eAV+H6?=
 =?us-ascii?Q?1pTEU8y7td6d5VNz7r/JjDMgEsHgpTpCQ0yLr8FiHBKeeBPOgjkN2C6JlqVp?=
 =?us-ascii?Q?trQ0or6IiVywt/CwT1K+FQdWHKTGGHxbd9Gj30ZtAg8sKzCjO7imGYgFImuP?=
 =?us-ascii?Q?LLnM0GLc+tCHz/ZnOtki+LkWqwB7PWrDUtDyQnL5XzlNPcK0neJxqKyrX7A4?=
 =?us-ascii?Q?Mv9kx6im/GFi7lpWtBcrYbQyAzQaJdvBYlTXlpgp5FFl4u+ouPSk28jinNxA?=
 =?us-ascii?Q?Fsi7BKGtwvsCW0E5KJJp4hTMNMdVAgRLeb6Deya4dFj77b2E9woSlk9NXD++?=
 =?us-ascii?Q?Cgt98pbGBAo1C6Tw7hjCx87O9M0v/nfYgwOF/fbgikxXky4h6oLS25eD+Cl1?=
 =?us-ascii?Q?fR3uzT0ZVa6XnwHqEzJDRsXrqXYV2XKTxMd+aVIwL5r5QG++mdEoBonvBgQy?=
 =?us-ascii?Q?1sx6ynQOPv8wCbfPKG28LqjMvrB61qtlb8WcGWfMQtkP4/hxV3mnTTGDFlOd?=
 =?us-ascii?Q?delvtkxWJ5naDOHpYW8+yeLzr4+mRKZ3Zmzb5MzANozyq3Xpthb3JGguxv0U?=
 =?us-ascii?Q?Awd7+H8EtmhlsDwaH/Zf0wJPkVhJEl8MZRkEDzJqglOIfK8X+46bRnSaBrk9?=
 =?us-ascii?Q?sjR8r2KJdNuzDkZPT1A4r+DGN/M1bNY4elbQEmvoluXhMA3FAngr7CjGv70C?=
 =?us-ascii?Q?EssZyHomeCw4xkQzjTXULyuBtcLOcosE7UJu0TykkkYwHZZHxVanUm4ixo94?=
 =?us-ascii?Q?wHy2gcVcBqARdKH6Ru4NZJTMtAktSjxZt4JaVjMsZ1k4jqxMAhzwTJdpnAiR?=
 =?us-ascii?Q?sB76pteq6UNxDgRJ13GiCyGS+0afIqMIisMv6bPT5pujjXuTg+AGhOse0cpl?=
 =?us-ascii?Q?7NoQOpzq1nvpOPIHqjJggsMBBiXeq0pfhwzL74di63aWYpl8R98eptwuYr2E?=
 =?us-ascii?Q?V1RJp5Jf124P72eXbQeSR5qQLMtaUICDaXpb3izfv5sOhFbJ4L/xwhU9NaRY?=
 =?us-ascii?Q?pfJsVy8dBNa91P6pLAoP4scLY0Av87lD75uSXaclknMrFbxRq9jQGZLu5Y/j?=
 =?us-ascii?Q?GI5Sce44nKd2tpV1uq3t0ff/uoo3eJ6PCOVA3woGMSzcuyPFfrTiL9pIuJSB?=
 =?us-ascii?Q?7Xd4YcDhERGMhgp0UGQeEzb6aRmJmHVOGhFg5CoYOqQSQMy/1oLnL0Aov0aU?=
 =?us-ascii?Q?FZIFUGHG9SxVCLTdhD7ftGBwYjJ2+rRLhRlNMmC/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1633.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce95c3c-c72b-4114-270f-08da640d6d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 13:50:05.7159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXirlKJ1Vbpp9WEA5j4IxCvfbRcziZNQhq7AXa+ReZwo9IlWI5354ZvqTEnhhgtC75ge4meP8fWRmajIqq4iNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello all,

I tried to build the latest samples/bpf following instructions in the READM=
E.rst in samples/bpf folder. I ran into various issue such as:

samples/bpf/Makefile:375: *** Cannot find a vmlinux for VMLINUX_BTF at any =
of "  /home/szeng/dii-tools/linux/vmlinux", build the kernel or set VMLINUX=
_BTF or VMLINUX_H variable

I was able to fix above issue by enable CONFIG_DEBUG_INFO_BTF in kernel .co=
nfig file.=20

But I eventually ran into other errors.  I had to fix those errors by insta=
ll dwarves, updating my clang/llvm to version 10.=20

I was able to build it if I comment out all the xdp programs from Makefile.=
 It seems those xdp programs require advanced features such as data structu=
re layout in vmlinux.h (dumped from vmlinux using bpftool) and this require=
 special kernel config support.

So I thought instead of fixing those errors one by one, I should ask those =
who are working in this area, is there any instructions on how to build sam=
ples/bpf? The README.rst seems out-of-date, for example, it doesn't mention=
 CONFIG_DEBUG_INFO_BTF. The required llvm/clang version in README.rst is al=
so out-of-date.

More specifically, to build samples/bpf, is there an example kernel .config=
 to use? I tried those config here https://github.com/torvalds/linux/blob/m=
aster/tools/testing/selftests/bpf/config but build errors persist.

Or is there any other tools I need to install/update on my system?

My whole build log is as below:

szeng@linux:~/dii-tools/linux$ make M=3Dsamples/bpf
readelf: Error: Missing knowledge of 32-bit reloc types used in DWARF secti=
ons of machine number 247
readelf: Warning: unable to apply unsupported reloc type 10 to section .deb=
ug_info
readelf: Warning: unable to apply unsupported reloc type 1 to section .debu=
g_info
readelf: Warning: unable to apply unsupported reloc type 10 to section .deb=
ug_info make -C /home/szeng/dii-tools/linux/samples/bpf/../../tools/lib/bpf=
 RM=3D'rm -rf' EXTRA_CFLAGS=3D"-Wall -O2 -Wmissing-prototypes -Wstrict-prot=
otypes -I./usr/include -I./tools/testing/selftests/bpf/ -I/home/szeng/dii-t=
ools/linux/samples/bpf/libbpf/include -I./tools/include -I./tools/perf -DHA=
VE_ATTR_TEST=3D0" \
        LDFLAGS=3D srctree=3D/home/szeng/dii-tools/linux/samples/bpf/../../=
 \
        O=3D OUTPUT=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf/ DESTD=
IR=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf prefix=3D \
        /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a install_hea=
ders
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlattr.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_=
errno.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_err=
or.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netlink=
.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf_pro=
g_linfo.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_=
probes.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashmap=
.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_dum=
p.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringbuf=
.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strset.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linker.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_loa=
der.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_co=
re.o
  LD      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf-=
in.o
  LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
  INSTALL headers
  CC  samples/bpf/test_lru_dist
  CC  samples/bpf/sock_example
  CC  samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.o
  CC  samples/bpf/../../tools/testing/selftests/bpf/trace_helpers.o
  CC  samples/bpf/cookie_uid_helper_example.o
  CC  samples/bpf/cpustat_user.o
  CC  samples/bpf/fds_example.o
  CC  samples/bpf/hbm.o
  CC  samples/bpf/i915_latency_hist_user.o
  CC  samples/bpf/i915_stat_user.o
  CC  samples/bpf/ibumad_user.o
  CC  samples/bpf/lathist_user.o
  CC  samples/bpf/lwt_len_hist_user.o
  CC  samples/bpf/map_perf_test_user.o
  CC  samples/bpf/offwaketime_user.o
  CC  samples/bpf/sampleip_user.o
  CC  samples/bpf/sockex1_user.o
  CC  samples/bpf/sockex2_user.o
  CC  samples/bpf/sockex3_user.o
  CC  samples/bpf/spintest_user.o
  CC  samples/bpf/syscall_tp_user.o
  CC  samples/bpf/task_fd_query_user.o
  CC  samples/bpf/tc_l2_redirect_user.o
  CC  samples/bpf/test_cgrp2_array_pin.o
  CC  samples/bpf/test_cgrp2_attach.o
  CC  samples/bpf/test_cgrp2_sock.o
  CC  samples/bpf/test_cgrp2_sock2.o
  CC  samples/bpf/test_current_task_under_cgroup_user.o
  CC  samples/bpf/test_map_in_map_user.o
  CC  samples/bpf/test_overhead_user.o
  CC  samples/bpf/test_probe_write_user_user.o
  CC  samples/bpf/trace_event_user.o
  CC  samples/bpf/trace_output_user.o
  CC  samples/bpf/tracex1_user.o
  CC  samples/bpf/tracex2_user.o
  CC  samples/bpf/tracex3_user.o
  CC  samples/bpf/tracex4_user.o
  CC  samples/bpf/tracex5_user.o
  CC  samples/bpf/tracex6_user.o
  CC  samples/bpf/tracex7_user.o
  CC  samples/bpf/xdp1_user.o
  CC  samples/bpf/xdp_adjust_tail_user.o
  CC  samples/bpf/xdp_fwd_user.o
make -C /home/szeng/dii-tools/linux/samples/bpf/../../tools/bpf/bpftool src=
tree=3D/home/szeng/dii-tools/linux/samples/bpf/../../ \
        OUTPUT=3D/home/szeng/dii-tools/linux/samples/bpf/bpftool/ \
        LIBBPF_OUTPUT=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf/ \
        LIBBPF_DESTDIR=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf/

Auto-detecting system features:
...                        libbfd: [ OFF ]
...        disassembler-four-args: [ OFF ]
...                          zlib: [ on  ]
...                        libcap: [ OFF ]
...               clang-bpf-co-re: [ on  ]


  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlattr.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_=
errno.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_err=
or.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netlink=
.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf_pro=
g_linfo.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_=
probes.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashmap=
.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_dum=
p.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringbuf=
.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strset.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linker.=
o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_loa=
der.o
  CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_co=
re.o
  LD      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf-=
in.o
  LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
  CLANG   /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.bpf.o
  GEN     /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.skel.h
  CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/prog.o
  CLANG   /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.bpf.o
  GEN     /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.skel.h
  CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/pids.o
  LINK    /home/szeng/dii-tools/linux/samples/bpf/bpftool/bpftool
  CC  samples/bpf/xdp_router_ipv4_user.o
  CC  samples/bpf/xdp_rxq_info_user.o
  CC  samples/bpf/xdp_sample_pkts_user.o
  CC  samples/bpf/xdp_tx_iptunnel_user.o
  CC  samples/bpf/xdpsock_ctrl_proc.o
  CC  samples/bpf/xsk_fwd.o
  CLANG-BPF  samples/bpf/xdp_sample.bpf.o
  CLANG-BPF  samples/bpf/xdp_redirect_map_multi.bpf.o
  CLANG-BPF  samples/bpf/xdp_redirect_cpu.bpf.o
  CLANG-BPF  samples/bpf/xdp_redirect_map.bpf.o
  CLANG-BPF  samples/bpf/xdp_monitor.bpf.o
  CLANG-BPF  samples/bpf/xdp_redirect.bpf.o
  BPF GEN-OBJ  samples/bpf/xdp_monitor
  BPF GEN-SKEL samples/bpf/xdp_monitor
libbpf: map 'rx_cnt': unexpected def kind var.
Error: failed to open BPF object file: Invalid argument
samples/bpf/Makefile:430: recipe for target 'samples/bpf/xdp_monitor.skel.h=
' failed
make[1]: *** [samples/bpf/xdp_monitor.skel.h] Error 255
make[1]: *** Deleting file 'samples/bpf/xdp_monitor.skel.h'
Makefile:1868: recipe for target 'samples/bpf' failed
make: *** [samples/bpf] Error 2


Thanks,
Oak

