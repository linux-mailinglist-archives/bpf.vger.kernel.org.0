Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD337967A
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhEJRxI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:53:08 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:12273 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhEJRxI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:53:08 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 13:53:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2435; q=dns/txt; s=iport;
  t=1620669123; x=1621878723;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dwQj7+cnc4Lz0kQ8nLkxmzH61D+dGlN20mPYFOyL2uE=;
  b=lI4Ulg89fizo7tJfLmN0nhvascapywSzp+SdpARewH77ER2nc4mKGOaI
   lDuk9L5+7EUxcanGzaA8gjX+JGiJBxM6X6x8vkse0lCFHALNd9lLASzaN
   1rTMC7qsBjOPtqkRYi9mR9vgumDbc0W+gX1BnOa7vxTvgAwfnFjHIeN8X
   k=;
X-IPAS-Result: =?us-ascii?q?A0CsAgAScJlgmIgNJK1agQmBV4FTUX5aNjEDCIgEA4U5i?=
 =?us-ascii?q?HaKN48jgS4UgREDVAsBAQENAQEyCAIEAQGBFgGDOQKCAwIlNQgOAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQUBAQUBAQECAQYEFAEBAQEBAQEBaIVQAQyHBQYBATgRAT4xERQSA?=
 =?us-ascii?q?QQTCIJpAYJVAy8BAwuebwKKH3iBNIEBggYBAQYEBIE0ARFDgyIYghMDBoE6g?=
 =?us-ascii?q?nqGb4QfHIFJQoFYhTsrgUQBEgEjg0uCK4FpWwYBMYEJIDQ9MwgIXQm6f1sKg?=
 =?us-ascii?q?xSJfpNSEINWixGWRS2VBIIWiWyUSIMiAgICAgQFAg4BAQaBVQE2a3BwFTuCa?=
 =?us-ascii?q?RM9FwIOjigQCYNOhRSFSXMCAQE0AgYKAQEDCXyLAwGBDwEB?=
IronPort-PHdr: A9a23:jrbWfRa65zCAvATTL/LrXpf/LTDHhN3EVzX9orI5hL9UNKeu5ZLvO
 ArY//o+xFPKXICO7fVChqKWtq37QmUP7N6Ht2xKa51DURIJyKB01wwtCcKIEwv3efjtaSFpA
 stPThlm8mu9PEwTH9zxNBXep3So5msUHRPyfQN+OuXyHNvUiMK6n+C/8pHeeUNGnj24NLhzN
 x6x6w7Ws5p+vA==
IronPort-HdrOrdr: A9a23:y1u8r617CYTMR/weVFUmYAqjBZByeYIsimQD101hICG9Lfb4qy
 n+ppomPEHP5wr5AEtQ4+xoS5PwPE80kqQFrbX5XI3SETUO3VHJEGgM1/qb/9SNIVyaygc/79
 YuT0EdMqyKMbESt6+Ti2PUf6dCsbu6GcuT9IDjJgJWPHhXgtZbnmFE42igYylLbTgDIaB8OI
 uX58JBqTblU28QdN6HCn4MWPWGj8HXlbr9CCR2SSIP2U2rt3eF+bT6Gx+X0lM1SDVU24ov9m
 DDjkjQ+rijifem0RXRvlWjrqi+2eGRiuerNvb8yPT9GQ+czzpAo74RH4FqiQpF491HLmxa1+
 Uk7S1QefiboEmhAl1d6SGdpDUIlgxeskMLDTSj8CDeSQuTfkNjNyMJv/MmTjLJr0Unp91yy6
 RNwiaQsIdWFwrJmGDn68HPTAwCrDv9nZMOq59ks5Vka/pWVFaRl/1rwKpfKuZKIMs70vFRLA
 BKNrCX2B97SyLoU5nphBga/DX3ZAVCIv6veDlxhiW66UkmoExE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,287,1613433600"; 
   d="scan'208";a="735755543"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 10 May 2021 17:44:54 +0000
Received: from mail.cisco.com (xbe-rcd-004.cisco.com [173.37.102.19])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 14AHisQY006236
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 17:44:54 GMT
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by xbe-rcd-004.cisco.com
 (173.37.102.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Mon, 10 May 2021
 12:44:54 -0500
Received: from xfe-aln-002.cisco.com (173.37.135.122) by xhs-rtp-001.cisco.com
 (64.101.210.228) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 10 May
 2021 13:44:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-002.cisco.com (173.37.135.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Mon, 10 May 2021 12:44:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAdm3is78BmwNkpl3VXHmWY0Vljza4boi++uSg9x66VVMxTzkGteMEDDpzeA65REMkB+rwpeF1NffIXkuVR9IWoh7TX7f2+n7ZnGP8fQvCK/CFMQMTkbuhQH1+Gg5xNKXX6AFMx97w8cH802W5t5FCnnjuUdPD0djxloIPl8fsRI6Qqiysq8gp74YbDqYQ1bId+v8EajXzIUEn9354WFUBGEtepKmDzUNWkOejeASPaLt8EInJOqBw1yYnRsWawtWTuK2bxwPcFlBjESn397ygmzxskhQpIWQw9jryI3uZuRBMIZTVHgow3hRgxKYGCo/4YLelu/B51S8A8su1bpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwQj7+cnc4Lz0kQ8nLkxmzH61D+dGlN20mPYFOyL2uE=;
 b=D7+anxpnhDZfsMgkCIkY59hDSc0+nuaNki1GFDAM2FPppWS1gly/U9Wk6y2/YTJm1M15XQUoEXbXmElKc5zjmVEQeA0MLvuWjq5caOHOV2XVtvaWa1NamGfjkh69GqIbJ8L41YTNizm3hS5FYeuG/uD8PRXELHUtKS4GyGD4tgE4yRuOdTFj/FFxWXj/99W2F+9F/SEbi5OHdGMOFZzk8gBqOvzxwXEA2KXOrpJo7gQ8Kv+UCHaIhlroOl1eSTVIJE91DZfEUa5BTbGHzdt5pZYX3aQtUqFC7sxA6od6cOsIxa1mytWhiPHOZmLhUQpIi4Zzvkx5YGs+dfMW/+JSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwQj7+cnc4Lz0kQ8nLkxmzH61D+dGlN20mPYFOyL2uE=;
 b=MoubioV9hYTGz5nmSyJNpVGTW+xmjNdec5Ps/7AqpVKRFdTDBjvKTGaC5vC1mmBesCig4qdYD31Kj/9cekCkcH9Ma9QBDqoWG9lW/NV1aRxG4hPOd9XC9LB9v/rNW79quQJShO/DjnLvufu4MWy7njB6JVyJhIvaqDrJqBfg1Zg=
Received: from BYAPR11MB3653.namprd11.prod.outlook.com (2603:10b6:a03:f7::14)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30; Mon, 10 May
 2021 17:44:51 +0000
Received: from BYAPR11MB3653.namprd11.prod.outlook.com
 ([fe80::f104:9282:458f:f1f5]) by BYAPR11MB3653.namprd11.prod.outlook.com
 ([fe80::f104:9282:458f:f1f5%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 17:44:51 +0000
From:   "Benoit Ganne (bganne)" <bganne@cisco.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: AF_XDP poll() / sendmsg() race + headroom changes
Thread-Topic: AF_XDP poll() / sendmsg() race + headroom changes
Thread-Index: AddFwES13atLgLM6TVaQYoFqwOtaTA==
Date:   Mon, 10 May 2021 17:44:51 +0000
Message-ID: <BYAPR11MB365382C5DB1E5FCC53242609C1549@BYAPR11MB3653.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [92.154.90.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33e679e9-c587-4932-1475-08d913db505c
x-ms-traffictypediagnostic: SJ0PR11MB4941:
x-microsoft-antispam-prvs: <SJ0PR11MB4941511B22F9D20B0A3D420DC1549@SJ0PR11MB4941.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctuawKzdPFUqP3KUwA8RiDLmGouT/ZJxmXFl3uOqMZyvx2fXgi8p5fwS+kbFDDw7c/hb0zpb5M6Q8ZB4YKGiPEMCU/9d5FwKQ8dedd1wcs9MyhecCprfyX0kxxUiwQl+GAUhpqM8fQsoUYYBJOiP22sZ5sl1DxMOdC03tpjjh1W+oUsZcBHRG6v/QXNz/dmmOkd+RUc/lfpzfeo2W5YZTOywxYtLYyctDVjT725BFtTkEWf4sTeLp+ESf6IRgeyCM52VSZBCZ1cSK7ekygriWROEl3CnQ7OydPkggycQfJkcJKvXkYeIJYpdSzHaxnbWIY5x8xLCkCMi8zHbp0ihg9XJL9lKDQt1gSRSxZQ691vIMKWM4m38TLfXN8B0RN0i3D6JXSCjwu5eD51wfX/gQgGdfdGvNsuzQBtXV2hBMzmVShYN6O6YES5v7vjvH5A9CrVr2kqmYLtv3zcsAzFkxIFRs7mKzTNAT8a+isZ49AwFbI3//Y/2bx5f5EnGRIClefzua7V1w/sSdEXmSqtc4JlbYxCNNhQ53WHp7j50LHamaiRRHtsYKbnVRGf+Q22EtTGZqAfhL0W6wyKyd/RAtcajqKnSw+mFawoIu4vFuWepEkVk2xdRFNeLKytZ70YWO+xa1yqASnDV3Fex8SZWElPM+tw2NeoCzOciNgs4w0l7QRDwVw0JOwfIAPo3Zx5J8FvcTf5FfZDX9DiX2HLfXWI7QCjK9fOnlRtdz1wouEc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3653.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(5660300002)(38100700002)(52536014)(966005)(8676002)(122000001)(6506007)(478600001)(316002)(2906002)(86362001)(6916009)(7696005)(76116006)(83380400001)(26005)(186003)(8936002)(33656002)(55016002)(71200400001)(66556008)(64756008)(66476007)(66446008)(66946007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CVXYFv68ntTxZS+gTb7aWFXK+zc4pQh+V8O4E6k6CRYFO155A13XS1HifF6d?=
 =?us-ascii?Q?9eNIPaPZg6DPlGtbNOZ3YC2LFSzUi98fVSkAU2pIthjG02Wg1bHOj0x4hkYb?=
 =?us-ascii?Q?Xd4mpqAM3OwrQBrBLjd4dySHRD+yLCTB5RwGxFT6Y4PAxPs/6R1KiSvhCYO7?=
 =?us-ascii?Q?3PbcTQ5hi4CC6zVIBvmifD5NN3yfs7fYtkFkGSZx2pYa0a/uwnOuz+7mI/fr?=
 =?us-ascii?Q?NKmQlEfw973nOOC9Mm684G65D+3ZCT3eZDUywQZZG9JjSTv+V2dkzXHsNI/9?=
 =?us-ascii?Q?3OUSSSAXlr14kOmNZ6rxpQn68rtCrxOV1oN9sVQaktpfoxipU61ajoxDJpEI?=
 =?us-ascii?Q?PQCoOisdaj6MHvFQxlLPpsVu1doLvKbJpzY1Ay5vnoXm5FiZlkffX1Wpp8kk?=
 =?us-ascii?Q?M8m/NLaxD7Eq0lMqBj/7H8NO3QgBgY37RV5KlZlqlXgCHneyEYCz/0gXrhnt?=
 =?us-ascii?Q?zA35B8D4w+gagpz4KQv9tLs+oXfJFgExTNRlYUQ7NnNsHvz6JlZMe89qHgtW?=
 =?us-ascii?Q?Wb5COgAedFuOn0tXau+4pexicEDXc1JOGA2f2oWCaBj6XkIrYvHQFsc1LAoF?=
 =?us-ascii?Q?lqga5CIuGsoobqb5+NPqKw4g8HHfB2ykPpqci8gwiok7ddQbJad2JdG/QZWD?=
 =?us-ascii?Q?RfG1o1jk6fUr66YTALLe2dPICAJvWe3sMfpwhgLne/wysKOWgtOOV/+gSQEx?=
 =?us-ascii?Q?ors0nnw9MvtilHGzk0m7h55MndSqBjdhKjX2ZZXqNcq8tv9xaTsvflnuirFW?=
 =?us-ascii?Q?cpjJIcc4ihAF5B7xv8BTspoCV2sGnIthWb7Trkccvd1oGJFzPUqpm1FFf/z9?=
 =?us-ascii?Q?6Q5RpBj6ZP+b6Qd2phvGWGM01t71iBbeXYvffW7BlJL/VdVuzOHTaZ1aKzzz?=
 =?us-ascii?Q?CPe6D6ssphFgjoyZQ7qgMzqAcFbe0oQFW+uuDVvImjpzIJwQwjSeTXs+WzBc?=
 =?us-ascii?Q?aUBsxdKLvp9cOfLcNnVWsD1G7275qBFYIe5tF1Z+fJ2cyMOv/NT89n4z58Ud?=
 =?us-ascii?Q?NoC6vmxEt17M5qTZiBI90CrZhDn4VZn8PCvsYrbyAGfexH3a8zhfTapuLY10?=
 =?us-ascii?Q?43etyJD9OaCJnnggKfuk1M6nmb6y00I+onHg1mGdv2r6pywYVHURALL6u2NB?=
 =?us-ascii?Q?B5lWqpoq6dikWYaQItqgvAdUUrkTby00yQPlo6E0OuV7P5BfN4z13pmobwV3?=
 =?us-ascii?Q?yKDM2B2VWYP5pfRUkk/nywslfNJjnl/U0lyana0sPYo1eVMSzlPOT/2Ebw8D?=
 =?us-ascii?Q?hqz81iqG74FgDu3OaXzvHlArTYpcHHYKvDR95sh5a7jlKpituPZCf2qJxX1o?=
 =?us-ascii?Q?UFYTGvzr2S57xa3srCwHMjls?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e679e9-c587-4932-1475-08d913db505c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 17:44:51.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfErsn4pwFrMrg7RDMo5G6bGsod2hyf+MD0mXCJQ7/4c35YW3QA8viAdS621i46mcqcLXzNLWSnaEvyA8AHPVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.19, xbe-rcd-004.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

Please CC me as I am not subscribed to the list.
I am the maintainer of the AF_XDP driver for VPP, an open-source userspace =
networking stack, and I ran into an issue recently with kernels < 5.6 (incl=
uding LTS kernel 5.4 which is shipped in eg. Ubuntu 20.04 LTS): it seems li=
ke one cannot call poll() and sendmsg() concurrently on the same AF_XDP soc=
ket. Is this a supported usecase? I know the rings are single producer/sing=
le consumer and I use them like this, but can I have one thread doing RX (a=
nd poll) while another thread is doing TX (and sendmsg)?
A typical usecase is when using more processing threads than AF_XDP queues =
for an interface, eg. because I use several interfaces: each thread can pol=
l its own set of RX queues from different NICs, but depending of the packet=
 processing decisions, I must be able to send through any other interface -=
 hence TX queues can be shared. In this case they are protected with a lock=
, but rx and tx can still happen in parallel.
The problem has been fixed with commit 11cc2d21499cabe7e7964389634ed1de3ee9=
1d33 "xsk: Simplify detection of empty and full rings" [1] but it looks lik=
e pure luck.
From what I can see the issue stems that prior to this patch, poll() will u=
pdate the cached txq prod_tail while sendmsg() is running and doing the sam=
e and because of that the txq cons_head can moved back, causing AF_XDP to p=
rocess the same descriptor twice.

I hit a 2nd issue with kernel >=3D 5.9, where the headroom on rx for copy m=
ode has grown from 0 to XDP_PACKET_HEADROOM (256-bytes). This change of beh=
avior was introduced by commit 2b43470add8c8ff1e1ee28dffc5c5df97e955d09 "xs=
k: Introduce AF_XDP buffer allocation API" [2].
Previously, the headroom in copy mode was set to "configured headroom + 0" =
whereas the headroom in 0-copy mode was set to "configured headroom + XDP_P=
ACKET_HEADROOM". This patch changed copy mode headroom to "configured headr=
oom + XDP_PACKET_HEADROOM", identical to 0-copy.
I agree the previous behavior was a bit weird, but is there a way to detect=
 old vs new behavior? Otherwise it is difficult to run the same code before=
/after this patch.

Thanks in advance for your help,
ben

[1] https://lore.kernel.org/bpf/1576759171-28550-3-git-send-email-magnus.ka=
rlsson@intel.com/
[2] https://lore.kernel.org/bpf/20200520192103.355233-6-bjorn.topel@gmail.c=
om
