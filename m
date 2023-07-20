Return-Path: <bpf+bounces-5436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2774B75AB8C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D361C21353
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA141174F1;
	Thu, 20 Jul 2023 09:57:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86E199E7;
	Thu, 20 Jul 2023 09:57:25 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC38EE;
	Thu, 20 Jul 2023 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689847043; x=1721383043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3gAcwFIQG9tXgagd4FVU+5si+cf/pKkqb1MueLFTelw=;
  b=oHsm6GvhS03crRSuJCEXhf1mkgg7Zn2pw7x11HDsIYpXw6U75Eiifv0t
   K9a+XjlaZfQTAXQAtCWBOPrgveKFXrbA/Aix0a7P7kmIiaVDqbyk0VtHA
   uvS+FmnkgdSWqefl2wKwXqNaN1mmCcH2DOaSCKBEvKgqoL5LGZdmHRMf1
   76xM9o0OzEfBGp77h3PHRrh0E1X4oLiV1b2LcNLVLVH4gnn+/C40B9l5d
   3btAqPsdDynTh5dR4dnqEKoIMgUs8mNpWAz1k0M5qGgUwLsV5IO4vu57V
   YoTgttbivzQYZxkLlDgKZ0ph0yi97kzLOANwsId/hUo+ZFfHo6a7OHCLf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397563500"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="397563500"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="718335687"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="718335687"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2023 02:57:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 02:57:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 02:57:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 02:57:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 02:57:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2MVSgQPB9wKVTkIlt/X75Bxz4vuMgnMyxxohjeiQHZrwoSxlD9PfOs4EJrrI3ROdyCQmLeouIcSkNe6Rax6X+jHu4wsbGZaH2ElfpbLFfwhAgYfcZcKXrYyi2frPo65ZYPxxeq23JsHC0jXknVAtYclSELVq15w1dz3xk46yVjIrcF7WqjOOqOWAw6pdu0GykRkdm07JN29fm1r77P2nu/EBSlIox3P82gtBNO4ijCBEVYTR6eL39icny1e+FcrM8+5qO91iNCpvZQFAgEQ2FrLhWtaTkkXrEug6vT31iv4ajIJ9aM9uPUx639zPlJuQCbK9jmKg2Js/Ti+jZTWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx8hKl9HPijqgrmRYuOUnpoLm8iFoMZAREoNVwwgv/M=;
 b=Gq5VrjGG5hkpfDOnZ4+DWLIYN2aCfl9flATS/GQmMgiubwbcrgCCT/ae8JudlBNVZMJJRSHZ+1MVX9PdxNKyC10H5/WQkhydcbV/N83zdi/leTCZxYF1ZHwPERTwIvcVp4oM5a6PGY9c4eyRFOBNsjiXw5mmGLoRPXQYxqsH5c72Ysunq2kjKE+UA8VyzNpvw7ZYcrDLiOdAgcsFvnBzoqhtXIfeRfcCcODDKE/sC+BQuRI4HbePiOT3n2qoQ72AKgj1+9d2yj5/tsUtmvvuoGjpYX6PuflGuxCcKCUL7l82HAiByDeC8PnZYBQbsAh2xdsMqPFfL3dQCUMTTUwM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 09:57:06 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 09:57:05 +0000
From: "Zaremba, Larysa" <larysa.zaremba@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com"
	<yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Brouer, Jesper"
	<brouer@redhat.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, "Tahhan, Maryam" <mtahhan@redhat.com>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 12/21] xdp: Add checksum hint
Thread-Topic: [PATCH bpf-next v3 12/21] xdp: Add checksum hint
Thread-Index: Adm68IonNm1oHvfLEEaU6XJEkWtdHQ==
Date: Thu, 20 Jul 2023 09:57:05 +0000
Message-ID: <ZLkD/XWi+eQU9AQC@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-13-larysa.zaremba@intel.com>
 <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
In-Reply-To: <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|IA0PR11MB7378:EE_
x-ms-office365-filtering-correlation-id: 7eddb8c8-7e9c-41e9-2fe6-08db8907aca6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVOr/NZPjpfQ8Fdf2P3PGsNkNeJGSnp+dX/lvBqRxBobELov2xIlzlkOfrrfTvPhnov4SFSqNTTOj19V/yz+iB7lA+asKrpAeVGG1m1gHfAf1PaI1g5otlV4aHnFjPFyIaYhlfo7hG8iMAVtmGGchNIWDfX/lTQCyL5tSvoH6Z2bvsYisvnZFd50aw6Mcm5LYaztbLqyLznPN88MYNhva7PbVG5MFJ4yykDiAgiBQVKPE77yaeLGHJ3wxXww3irKeU01EDjelBroU4V5fsCj0Bph+DZ/ZoXuAxeVRDIA1N1yz14H7d/eRK2Vy4oQeHFww0ltdktTKG+Dqw1EDjXpAm1d8zDPcvTEj3//UfX7c4769KUIv3QhnsJenraFlx2kWD3EJur+lJoNOFeBSrl5a9Z+JvKKZTyUPW3LsYLXb3NMOhjtRlqBresoJU+xe3Ofamdm7TkAqh4TDIF+JmJta+Josm/UM/lBgK6WgMv/QHcWtsYvPGV0P8LN5gVdUQuJKCeGqVQurWQK79JPOeReH9Fnvbp7Ahgtt4jRrU3cDqmvRSpVlN/XJ2AjQHzWLDIi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(33716001)(478600001)(2906002)(54906003)(71200400001)(6486002)(8676002)(7416002)(4326008)(64756008)(6916009)(316002)(8936002)(66946007)(66556008)(66476007)(82960400001)(66446008)(41300700001)(9686003)(83380400001)(38100700002)(122000001)(6512007)(186003)(6506007)(86362001)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdDzTm07W1lkwgt8UbitlCCf/adgK9zoWHsSGiusIhyqbZE6tbehLgGrZPfr?=
 =?us-ascii?Q?1uhfpAFh1onXjt812ep3FtMTZnFTLHI3xeSno2vnTLywJtLc/098bbrsy80O?=
 =?us-ascii?Q?spqlS5iHpmJZj66I4QZuGmmknfO9sHjIftJvlt0yvaId+UORY6WMr6cfDsXm?=
 =?us-ascii?Q?hpwJCx7pjv7l4w66lqlV4ZwP3iJOlR0jzrcso8sLEwpfSRGad/eauZTD0dnY?=
 =?us-ascii?Q?fqvqeTeNW1olDXmnsqJfRKMVqv5TIzLnd2KzKtS7pvLWkZt0joUWtWjDLTue?=
 =?us-ascii?Q?3uukweeynmWRTU1HzmmvVbYkPB+iE/TJ4ZblAKpXOFCTybI3VGdVdrU4CAvD?=
 =?us-ascii?Q?xMDe+vz7Ojp2vIPAk4P65A3B4FjgOR5HNku4KFjjnpRA5lsCAKuvtCfpYIfp?=
 =?us-ascii?Q?rBwVthPOAZSch/D5mx7K9DJXpyW8065IUm8CFDlDPTVWAEVnbNLTRsmC1JU/?=
 =?us-ascii?Q?svgMUjS7FNuln96ii2dg9L+kZyqbRfkYfVmr1ed4v3uFlwiuLVH1Ta7oEh1t?=
 =?us-ascii?Q?tQ4AGNHz6RBem09mzb6X1Dx/RXOXUaRy00T5Bx5rKfpbSp6O4AwJyVQDfG4J?=
 =?us-ascii?Q?IJtP1TCTmQSeGsUpv/5J6smhBfKiFFlD5/miHt2WC4L4O/RtKCAPHMYq4LD2?=
 =?us-ascii?Q?ZnWiRwQ1zFS5nm8q5kxH4YT4Psi3vxdohM5AicDfuGjIE9aPSCmMQ7XAE+tg?=
 =?us-ascii?Q?2gqRvIzVamyxAcGFUTeImA7nFF9xIK6UbEY6JhaHSA3vO9LRhsM47WCbTOfP?=
 =?us-ascii?Q?gSzsElJoY4eeMsu8dcrccpWaVFvVDiRQN+neU51t3NQv45TFWrfKs5oCPJX2?=
 =?us-ascii?Q?ciuwaGNBBQQ7Qs/AZ+e05nzA8pznpCz2ud55ZTsIhtAr3K/bNeVq29XldQmm?=
 =?us-ascii?Q?neu0S+MLmAQ9jS2bJpVfNx5GK+b6timCYbVCJvoKDgjK7NZpuCvDaNEjMXWm?=
 =?us-ascii?Q?fsY2B70+qxQ6zQud4f0uHe4MjS3URlb2gG/30ZMMct1s6TAnyYJ6GYZbA1VA?=
 =?us-ascii?Q?2J9CmX479H6IJkusOI8E4+PsoZoTAaFIWLvY62GEQ0r9e19lsIag0L+cwLhT?=
 =?us-ascii?Q?gDFwrs2ZBFu5atKb0ejZziQAb695hbyNtpEvvywkV4yJ/vIwFuCZDc6qYDQ+?=
 =?us-ascii?Q?tQBxVHIKAOa+HRiejlxTEy1OIhfKCO7dV7pF7gKSugU7QVFdWBd3PfPa0HQ1?=
 =?us-ascii?Q?0zYKP3OyX2NhVB+b0+Z26C2lxVQC8XKSu/DOjrgzTgPOYEOLPUPSNoIKdI0+?=
 =?us-ascii?Q?8qAh5a9JLS7dcjUAWNdoFfp2LLjn3d0BFsnFf31BV7epPDFfzanX4ISGr+4/?=
 =?us-ascii?Q?KihZ6mb7i/Ko0Mt7BWiwaqQfrN2C12LMi1cxX6nlTi+ax1vLbsShBXjKHdFf?=
 =?us-ascii?Q?Tl1zySxPThJjdJa7+FDYFBr0sCdfNPd5jqILQIGCegKUbXdEmtzC1YTQ9f+q?=
 =?us-ascii?Q?IZvStNKg0+bCuT58jwDZD0yXxpdmrBppY8LRGBx9v9UZmCDsvXK2Pm/D7n8j?=
 =?us-ascii?Q?oaXUtCmbWx9kz0G9K18OyIVY1bO91ektv6i1U4LRKsjtO7kTcEEQ+UGqVNDn?=
 =?us-ascii?Q?zfFfL7Y5qfH354Lo7MVFtKepd73UsqblsQaSdl7OE/vJnrIL5SxLdS6H4Q6y?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A510FFC6E3256D44BC1F76681B79122D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eddb8c8-7e9c-41e9-2fe6-08db8907aca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 09:57:05.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyzunOflgoihILgknEoiPtIDSqLnpUSoyK6D177/Do6XeyoC8pOl2v21E24W2waklxQkSNbcG3AZ1LSXgEFkf6z0+vgFiEBKOP6z3/J0opA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:42:04PM -0400, Willem de Bruijn wrote:
> Larysa Zaremba wrote:
> > Implement functionality that enables drivers to expose to XDP code chec=
ksum
> > information that consists of:
> >=20
> > - Checksum status - bitfield that consists of
> >   - number of consecutive validated checksums. This is almost the same =
as
> >     csum_level in skb, but starts with 1. Enum names for those bits sti=
ll
> >     use checksum level concept, so it is less confusing for driver
> >     developers.
> >   - Is checksum partial? This bit cannot coexist with any other
> >   - Is there a complete checksum available?
> > - Additional checksum data, a union of:
> >   - checksum start and offset, if checksum is partial
> >   - complete checksum, if available
> >=20
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  Documentation/networking/xdp-rx-metadata.rst |  3 ++
> >  include/linux/netdevice.h                    |  3 ++
> >  include/net/xdp.h                            | 46 ++++++++++++++++++++
> >  kernel/bpf/offload.c                         |  2 +
> >  net/core/xdp.c                               | 23 ++++++++++
> >  5 files changed, 77 insertions(+)
> >=20
> > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentati=
on/networking/xdp-rx-metadata.rst
> > index ea6dd79a21d3..7f056a44f682 100644
> > --- a/Documentation/networking/xdp-rx-metadata.rst
> > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> >  .. kernel-doc:: net/core/xdp.c
> >     :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > =20
> > +.. kernel-doc:: net/core/xdp.c
> > +   :identifiers: bpf_xdp_metadata_rx_csum
> > +
> >  An XDP program can use these kfuncs to read the metadata into stack
> >  variables for its own consumption. Or, to pass the metadata on to othe=
r
> >  consumers, an XDP program can store it into the metadata area carried
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 1749f4f75c64..4f6da36ac123 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
> >  			       enum xdp_rss_hash_type *rss_type);
> >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> >  				   __be16 *vlan_proto);
> > +	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
> > +			       enum xdp_csum_status *csum_status,
> > +			       union xdp_csum_info *csum_info);
> >  };
> > =20
> >  /**
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 89c58f56ffc6..2b7a7d678ff4 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_inf=
o *info,
> >  			   bpf_xdp_metadata_rx_hash) \
> >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> >  			   bpf_xdp_metadata_rx_vlan_tag) \
> > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
> > +			   bpf_xdp_metadata_rx_csum) \
> > =20
> >  enum {
> >  #define XDP_METADATA_KFUNC(name, _) name,
> > @@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
> >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_=
L3_DYNHDR,
> >  };
> > =20
> > +union xdp_csum_info {
> > +	/* Checksum referred to by ``csum_start + csum_offset`` is considered
> > +	 * valid, but was never calculated, TX device has to do this,
> > +	 * starting from csum_start packet byte.
> > +	 * Any preceding checksums are also considered valid.
> > +	 * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``.
> > +	 */
> > +	struct {
> > +		u16 csum_start;
> > +		u16 csum_offset;
> > +	};
> > +
> > +	/* Checksum, calculated over the whole packet.
> > +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > +	 */
> > +	u32 checksum;
> > +};
> > +
> > +enum xdp_csum_status {
> > +	/* HW had parsed several transport headers and validated their
> > +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > +	 * 3 least significat bytes contain number of consecutive checksum,
>=20
> typo: significant
>=20
> (I did not scan for typos, just came across this when trying to understan=
d
> the skb->csum_level + 1 trick. Probably good to run a spell check).
>=20

Thanks! Will fix.

> > +	 * starting with the outermost, reported by hardware as valid.
> > +	 * ``sk_buff`` checksum level (``csum_level``) notation is provided
> > +	 * for driver developers.
> > +	 */
> > +	XDP_CHECKSUM_VALID_LVL0		=3D 1,	/* 1 outermost checksum */
> > +	XDP_CHECKSUM_VALID_LVL1		=3D 2,	/* 2 outermost checksums */
> > +	XDP_CHECKSUM_VALID_LVL2		=3D 3,	/* 3 outermost checksums */
> > +	XDP_CHECKSUM_VALID_LVL3		=3D 4,	/* 4 outermost checksums */
> > +	XDP_CHECKSUM_VALID_NUM_MASK	=3D GENMASK(2, 0),
> > +	XDP_CHECKSUM_VALID		=3D XDP_CHECKSUM_VALID_NUM_MASK,
> > +
> > +	/* Occurs if packet is sent virtually (between Linux VMs / containers=
)
> > +	 * This status cannot coexist with any other.
> > +	 * Refer to ``csum_start`` and ``csum_offset`` in ``xdp_csum_info``
> > +	 * for more information.
> > +	 */
> > +	XDP_CHECKSUM_PARTIAL	=3D BIT(3),
> > +
> > +	/* Checksum, calculated over the entire packet is provided */
> > +	XDP_CHECKSUM_COMPLETE	=3D BIT(4),
> > +};
> > +
> >  #ifdef CONFIG_NET
> >  u32 bpf_xdp_metadata_kfunc_id(int id);
> >  bool bpf_dev_bound_kfunc_id(u32 btf_id);
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 986e7becfd42..f60a6add5273 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *=
prog, u32 func_id)
> >  		p =3D ops->xmo_rx_hash;
> >  	else if (func_id =3D=3D bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_=
RX_VLAN_TAG))
> >  		p =3D ops->xmo_rx_vlan_tag;
> > +	else if (func_id =3D=3D bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_=
RX_CSUM))
> > +		p =3D ops->xmo_rx_csum;
> >  out:
> >  	up_read(&bpf_devs_lock);
> > =20
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 8b55419d332e..d4ea54046afc 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -772,6 +772,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const=
 struct xdp_md *ctx,
> >  	return -EOPNOTSUPP;
> >  }
> > =20
> > +/**
> > + * bpf_xdp_metadata_rx_csum - Get checksum status with additional info=
.
> > + * @ctx: XDP context pointer.
> > + * @csum_status: Destination for checksum status.
> > + * @csum_info: Destination for complete checksum or partial checksum o=
ffset.
> > + *
> > + * Status (@csum_status) is a bitfield that informs, what checksum
> > + * processing was performed. Additional results of such processing,
> > + * such as complete checksum or partial checksum offsets,
> > + * are passed as info (@csum_info).
> > + *
> > + * Return:
> > + * * Returns 0 on success or ``-errno`` on error.
> > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > + * * ``-ENODATA``    : Checksum status is unknown
> > + */
> > +__bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
> > +					 enum xdp_csum_status *csum_status,
> > +					 union xdp_csum_info *csum_info)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  __diag_pop();
> > =20
> >  BTF_SET8_START(xdp_metadata_kfunc_ids)
> > --=20
> > 2.41.0
> >=20
>=20
>=20

