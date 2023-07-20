Return-Path: <bpf+bounces-5437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D875ABAE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B190F281D81
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0FA174FD;
	Thu, 20 Jul 2023 10:11:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098119A04;
	Thu, 20 Jul 2023 10:11:01 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F199B4;
	Thu, 20 Jul 2023 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689847859; x=1721383859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UjbHndf2be+Lp8HFw3G8GFhjB0pbqkgj3VvlgqaeDac=;
  b=Dd1GKVIueHGCpTh1Cwy/N+yp+MFEL/MuYoMurntnQ3CKYqq9Izpr4hJO
   Sj0kk4qNf7kvTGOS2DrJYelwZhUmPPFOkw8wuXts7Sodmx1Be8sRZDaIr
   DOz/1QESrjFoDhooDJJGZm5tiq7WibrW+JJXolqBNbd75X9Wt7RRxhGGG
   l1HfNULHfPlaTz/cSEx9Fg1rPHkBbxNOowXe57gREPISk5xPYhvmhXb7J
   BSsa93ZYlf53oRMi4SgUqqGajAmtQBBZlVkbYCTxjP2YKBxmbUSF3lI+E
   xzoswpbWaEXZKWn5+qRBqfLjZZnJJn1CqdwkAkK8gb2txhue60rpw2pj/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="364149819"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="364149819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="754018809"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="754018809"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2023 03:10:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 03:10:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 03:10:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 03:10:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 03:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8WKHXinFyTcpBoCQxqT9igfkSJn3jCs0TGboLPoeNVpv4umwBre38JQxfM7WxFjUCy0VJqj47mis7yRcufW1131frHLWOoE9SO2qMhA4aQekS6lW6CX8+ty06HgMsR1Yj5V4SH23qNzZ6tZxBPoXbX+W85vaPlbuie2xHdCLznHWTk/EX+815XbQ6v95H1FuLVY00qXExA8qZtFGy6jxSf2/FMfhTougU4xIYvKh8vUcaKK7p8aHjzJpfcYPA/c5po7jA1sxrY6LFtZy6C4eOib+x8ZHoVEasnVj6KvZJQtePHPKjm0wpXm7AL2zrpBuj7BF4+Q+SNDQNLefw6f8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/mYT7706kVq8HhrJk0SaXg/o4W76I0ofnyDOsrEAbc=;
 b=ZdIer6h5nMidEsK4hPk+xMpobXgEeqd0hDR6bQSo4DqPkLmk6IIxctRWPHIT9Eja/I6N7JrNl6sXEsMiqbR2ffsCS0KBcvf8HOzygBDuZ+qRWdu9nv7utHvy6VJQei6MsOqPJ9wpBXDRHciZZftbp9DnqoTeJ2+Zr5ut7xBRDq2ZXN8kh/JgMxWt0+QwxTq9auZW+MfYQ9ZJjMhS8Na5vis2W+QDkQOFh4XYusxFKGE2c7V9GMBLwb6ksXQEkf3ogVz5QsJMFRfAgl1Cwj1WXTWF19eYnsRpQhdYYev/pCE3KBlYV83Ed5vPO0avNeu3Iaz/VrX/ZPaBQuQqKhO3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH3PR11MB7299.namprd11.prod.outlook.com (2603:10b6:610:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 10:10:42 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 10:10:42 +0000
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
Thread-Index: Adm68nEG6zsu2jz3CEGGt7ORzNtKQw==
Date: Thu, 20 Jul 2023 10:10:42 +0000
Message-ID: <ZLkHK6Zbqwkxc8WM@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-13-larysa.zaremba@intel.com>
 <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
 <ZLkD/XWi+eQU9AQC@lincoln>
In-Reply-To: <ZLkD/XWi+eQU9AQC@lincoln>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|CH3PR11MB7299:EE_
x-ms-office365-filtering-correlation-id: 3c998952-49cd-485b-d654-08db89099383
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgpBL+MGxU7YQYiW6jEIkK3MhGAatHvMycot2GlIvQjdPtnDCcN2PpiMIAp6MwYNyLwumN6Aia8nbgTGsZoWU0+OOdOyaQ765y0uHfHl5rZrU81qj9ZDzzCSS0Wz0i4iIoRQfrSCYEPCQ4sapVuAgE1t9wZw2nwmOC8Fj5rQ5lCDw38n1rPysJxJBZFYPn2OckfXIk3fPc/M4r2grcF3GCPvb3wpPVdBY1rbGg0VFFuS+nAiAy/VCll8ljpMABdrtjQlTJRrvbYN7W/eI1NtkYWTz2hXRc2YC1VQP5wZDmwbF+bECQ5ahRClkvvfvdST8290wUequAYefBUidU8xQ0QCLsiLsX4FJuCxe9FGs/Yekmife6x7HIFoXAngMbW7QJujImEhxt7IKu/78/fBcHNv5umgFS6SDazolFg6SRgm18TNhBvxYgA25jsMdeQG5xBXyfnEOtuqLtgiOODJgy1ee388J4yBPaj1By0eC4a8OBctykGYmUkKdEX7glleM7Pn62AGULev0Tz87Ed87KTJfJuXA6zF6Oq701Clwx3ov1+zrCCuU9IrLY7lZoYi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(6506007)(26005)(186003)(2906002)(6512007)(9686003)(71200400001)(6486002)(54906003)(7416002)(38100700002)(83380400001)(122000001)(41300700001)(64756008)(66946007)(8936002)(5660300002)(8676002)(33716001)(316002)(66476007)(66446008)(6916009)(4326008)(66556008)(86362001)(478600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+piq9QfhiF7Gy2tjxU/naN49xkZmQ24dnepCY+FqfJSj9JoVxg+qygaraOCN?=
 =?us-ascii?Q?yYyu+N8OaVhLO4l8XrI265gMtzmshzJhZgcpaR8+qel022kpJZHi6N3mvVWW?=
 =?us-ascii?Q?ToWI1ZXkdJtd+pTAkyYi5qSKgWxTm8wHRu33W5rvZzZxXC66wiNmf8os9Crw?=
 =?us-ascii?Q?aKHG/BAS1vsudjBP/P5S/cU5Ll4JL/gLLpahJX0hDOYpc+CRWTwR6vx1gMOw?=
 =?us-ascii?Q?aj4asaRs1BGa/IAsajy5QA7NbQxxxP6Lo05a+rQ4GsL3HnSSuJl83ylpN6yP?=
 =?us-ascii?Q?StViYo8tkSWmARczThqrH7GUF/5ymfVhShJWpTtSMk+lrPEeC5adAft3T5Vu?=
 =?us-ascii?Q?NeRr8zW5EcPGwwUrRMYa7PHU5iUFnKiSNXQ/As8jZqxmVuk6jt84XgQp2Bbn?=
 =?us-ascii?Q?5MRZ1qvCs1xqbxrpORwuLGw5itfyIOgANxUTiBoxF185cNoKEWTSxEHdVaVN?=
 =?us-ascii?Q?1LA4DTfBPdX11xjaghdcjBvRzhqVvYZj5VBy4dsP9pdVJKjB1DIqUlX8n+wP?=
 =?us-ascii?Q?Qq22AjwndJTewuJNzr5aWunhD5YjeoWQ2woNnaw3b+PvqDhFbuq6LASk0EMA?=
 =?us-ascii?Q?WlW4vqDW5TL6+Dcyu7bTB4qVYOlyS3raIHoigi1OB64dOT+/OqOPZq1gizjI?=
 =?us-ascii?Q?49I6WcXrlBddxWW54aqvGfQBjszBq7jyyd2+n70xrla8QUw1fdrkbjgnSjwt?=
 =?us-ascii?Q?b7O1JPoBd/VbjpXe1E8Pdcz3QaAanB8tddvcLfCfmW6Wbitud2J6/IpZ/wMi?=
 =?us-ascii?Q?bbeQOePkHBDTsPRsAp0MlY3i6xaPc/jBzMghqtBIdDvXwuWixEBOGVdc2XIC?=
 =?us-ascii?Q?S8xER9Ui4uK0G9gniZoGOceNOTKjrPeKZiH5QHx8xYrjGo2+66MwA/tt1Y/4?=
 =?us-ascii?Q?wfNgT0rYehYwC3SIYTrbAUHhOHH0Ly8I/22hwdCCzCdCLAPJuDHDTeKBdGGC?=
 =?us-ascii?Q?q/0VpdXW4LacXUpc9ltvWvYiEomzUQ5jhWviBdkolsszqAkLeyw8f1iDiGrL?=
 =?us-ascii?Q?x7P82SLaTF01ZQHyThN34iLVPx3vJqGz81Bz7ioHRBx0xayAHphuMcIL8fpI?=
 =?us-ascii?Q?x2RIaqKzJhUOt8MXHFarvR6gQQXqH46PTtwwEzbIIjUTuVhQezlOE5RqfeA9?=
 =?us-ascii?Q?kVi9pOK+i+LH9uAJL6yRmDprEVCoJI0h7WZ1F2ra5nj8jV5z28dzYK43T2JD?=
 =?us-ascii?Q?1ms9ecwXgAZiioY06R8m0U2xBel0K6P0fTfTawzvlK7bHmmJOwU+9c8DlgC1?=
 =?us-ascii?Q?x0hQ3XGlqEHdEeevyljk+jArh4YOKaDxnHGH1g5ov4sxnLd0rtZi7ypx0qhu?=
 =?us-ascii?Q?AU/TSynQfLehnop6pALJFf8xG27XCTDyzyBobaPp86ncm2GUtVL93MTy9S/N?=
 =?us-ascii?Q?RPxodiskCvrQ5YTNKEy6zD6V2mvyjTZCJdNkaIGpjvR88m1jESW4U7QdmghG?=
 =?us-ascii?Q?gaibqoSpZ5kJEaJgEOBUvNeXXyCjSLx7pIZWJ27fn2Odo1lGXxqRZ7CIX/YP?=
 =?us-ascii?Q?p0j5gvTa7Tk8e9nEJQEKDSRKGwR8Qc1v/iVNb6jXVo7Z4pQHAjLRU8Ntb6Jo?=
 =?us-ascii?Q?Tc7zMJqPK3cPa/jCanQjEFkaWlO445MgObByjgqvgq4IicqCx0BLJh/WnzAd?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42F7FA90CE638243B85D4A76BBD334FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c998952-49cd-485b-d654-08db89099383
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 10:10:42.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YK/Onf1mucFe77sRywU54Y0BRO9w9lFCREOEmt+dSp9Kdgco1udc1trgMU6VIZixEjfvgt5NU8P7RBJWF9FFJCPXWKCRabWpzypsXn68dnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 09:57:05AM +0000, Zaremba, Larysa wrote:
> On Wed, Jul 19, 2023 at 05:42:04PM -0400, Willem de Bruijn wrote:
> > Larysa Zaremba wrote:
> > > Implement functionality that enables drivers to expose to XDP code ch=
ecksum
> > > information that consists of:
> > >=20
> > > - Checksum status - bitfield that consists of
> > >   - number of consecutive validated checksums. This is almost the sam=
e as
> > >     csum_level in skb, but starts with 1. Enum names for those bits s=
till
> > >     use checksum level concept, so it is less confusing for driver
> > >     developers.
> > >   - Is checksum partial? This bit cannot coexist with any other
> > >   - Is there a complete checksum available?
> > > - Additional checksum data, a union of:
> > >   - checksum start and offset, if checksum is partial
> > >   - complete checksum, if available
> > >=20
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  Documentation/networking/xdp-rx-metadata.rst |  3 ++
> > >  include/linux/netdevice.h                    |  3 ++
> > >  include/net/xdp.h                            | 46 ++++++++++++++++++=
++
> > >  kernel/bpf/offload.c                         |  2 +
> > >  net/core/xdp.c                               | 23 ++++++++++
> > >  5 files changed, 77 insertions(+)
> > >=20
> > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documenta=
tion/networking/xdp-rx-metadata.rst
> > > index ea6dd79a21d3..7f056a44f682 100644
> > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > >  .. kernel-doc:: net/core/xdp.c
> > >     :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > =20
> > > +.. kernel-doc:: net/core/xdp.c
> > > +   :identifiers: bpf_xdp_metadata_rx_csum
> > > +
> > >  An XDP program can use these kfuncs to read the metadata into stack
> > >  variables for its own consumption. Or, to pass the metadata on to ot=
her
> > >  consumers, an XDP program can store it into the metadata area carrie=
d
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 1749f4f75c64..4f6da36ac123 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
> > >  			       enum xdp_rss_hash_type *rss_type);
> > >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> > >  				   __be16 *vlan_proto);
> > > +	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
> > > +			       enum xdp_csum_status *csum_status,
> > > +			       union xdp_csum_info *csum_info);
> > >  };
> > > =20
> > >  /**
> > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > index 89c58f56ffc6..2b7a7d678ff4 100644
> > > --- a/include/net/xdp.h
> > > +++ b/include/net/xdp.h
> > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_i=
nfo *info,
> > >  			   bpf_xdp_metadata_rx_hash) \
> > >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > >  			   bpf_xdp_metadata_rx_vlan_tag) \
> > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
> > > +			   bpf_xdp_metadata_rx_csum) \
> > > =20
> > >  enum {
> > >  #define XDP_METADATA_KFUNC(name, _) name,
> > > @@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
> > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RS=
S_L3_DYNHDR,
> > >  };
> > > =20
> > > +union xdp_csum_info {
> > > +	/* Checksum referred to by ``csum_start + csum_offset`` is consider=
ed
> > > +	 * valid, but was never calculated, TX device has to do this,
> > > +	 * starting from csum_start packet byte.
> > > +	 * Any preceding checksums are also considered valid.
> > > +	 * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``.
> > > +	 */
> > > +	struct {
> > > +		u16 csum_start;
> > > +		u16 csum_offset;
> > > +	};
> > > +
> > > +	/* Checksum, calculated over the whole packet.
> > > +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > +	 */
> > > +	u32 checksum;
> > > +};
> > > +
> > > +enum xdp_csum_status {
> > > +	/* HW had parsed several transport headers and validated their
> > > +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > > +	 * 3 least significat bytes contain number of consecutive checksum,
> >=20
> > typo: significant
> >=20
> > (I did not scan for typos, just came across this when trying to underst=
and
> > the skb->csum_level + 1 trick. Probably good to run a spell check).
> >

Oh, and about skb->csum_level + 1, maybe this way it would be more=20
understandable: XDP_CHECKSUM_VALID_LVL0 + skb->csum_level?

Using number of valid checksums (starts with 1) instead of checksum level=20
(starts with 0) is a debatable decision, but I have decided to go with it u=
nder=20
2 assumptions:

- the only reason checksum level in skb starts with 0 is to use less bits
- checksum number would be more intuitive for XDP/AF_XDP application develo=
pers

I encourage everyone to share their opinion on that.
=20
>=20
> Thanks! Will fix.
>=20
> > > +	 * starting with the outermost, reported by hardware as valid.
> > > +	 * ``sk_buff`` checksum level (``csum_level``) notation is provided
> > > +	 * for driver developers.
> > > +	 */
> > > +	XDP_CHECKSUM_VALID_LVL0		=3D 1,	/* 1 outermost checksum */
> > > +	XDP_CHECKSUM_VALID_LVL1		=3D 2,	/* 2 outermost checksums */
> > > +	XDP_CHECKSUM_VALID_LVL2		=3D 3,	/* 3 outermost checksums */
> > > +	XDP_CHECKSUM_VALID_LVL3		=3D 4,	/* 4 outermost checksums */
> > > +	XDP_CHECKSUM_VALID_NUM_MASK	=3D GENMASK(2, 0),
> > > +	XDP_CHECKSUM_VALID		=3D XDP_CHECKSUM_VALID_NUM_MASK,
> > > +
> > > +	/* Occurs if packet is sent virtually (between Linux VMs / containe=
rs)
> > > +	 * This status cannot coexist with any other.
> > > +	 * Refer to ``csum_start`` and ``csum_offset`` in ``xdp_csum_info``
> > > +	 * for more information.
> > > +	 */
> > > +	XDP_CHECKSUM_PARTIAL	=3D BIT(3),
> > > +
> > > +	/* Checksum, calculated over the entire packet is provided */
> > > +	XDP_CHECKSUM_COMPLETE	=3D BIT(4),
> > > +};
> > > +
> > >  #ifdef CONFIG_NET
> > >  u32 bpf_xdp_metadata_kfunc_id(int id);
> > >  bool bpf_dev_bound_kfunc_id(u32 btf_id);
> > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > index 986e7becfd42..f60a6add5273 100644
> > > --- a/kernel/bpf/offload.c
> > > +++ b/kernel/bpf/offload.c
> > > @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog=
 *prog, u32 func_id)
> > >  		p =3D ops->xmo_rx_hash;
> > >  	else if (func_id =3D=3D bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUN=
C_RX_VLAN_TAG))
> > >  		p =3D ops->xmo_rx_vlan_tag;
> > > +	else if (func_id =3D=3D bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUN=
C_RX_CSUM))
> > > +		p =3D ops->xmo_rx_csum;
> > >  out:
> > >  	up_read(&bpf_devs_lock);
> > > =20
> > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > index 8b55419d332e..d4ea54046afc 100644
> > > --- a/net/core/xdp.c
> > > +++ b/net/core/xdp.c
> > > @@ -772,6 +772,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(con=
st struct xdp_md *ctx,
> > >  	return -EOPNOTSUPP;
> > >  }
> > > =20
> > > +/**
> > > + * bpf_xdp_metadata_rx_csum - Get checksum status with additional in=
fo.
> > > + * @ctx: XDP context pointer.
> > > + * @csum_status: Destination for checksum status.
> > > + * @csum_info: Destination for complete checksum or partial checksum=
 offset.
> > > + *
> > > + * Status (@csum_status) is a bitfield that informs, what checksum
> > > + * processing was performed. Additional results of such processing,
> > > + * such as complete checksum or partial checksum offsets,
> > > + * are passed as info (@csum_info).
> > > + *
> > > + * Return:
> > > + * * Returns 0 on success or ``-errno`` on error.
> > > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > > + * * ``-ENODATA``    : Checksum status is unknown
> > > + */
> > > +__bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
> > > +					 enum xdp_csum_status *csum_status,
> > > +					 union xdp_csum_info *csum_info)
> > > +{
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > >  __diag_pop();
> > > =20
> > >  BTF_SET8_START(xdp_metadata_kfunc_ids)
> > > --=20
> > > 2.41.0
> > >=20
> >=20
> >=20
>=20

