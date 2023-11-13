Return-Path: <bpf+bounces-14973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E977E96BD
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 07:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E911F21077
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 06:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9598D11710;
	Mon, 13 Nov 2023 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpglA0zI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD8C8DE;
	Mon, 13 Nov 2023 06:42:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E940D78;
	Sun, 12 Nov 2023 22:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699857738; x=1731393738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6h8Ocqnl0ZWAf1mmE4DzxOAoRGX63eNghkT0wpbXMd4=;
  b=GpglA0zIv1ErAO2yMZfatkkXP1J4EYqhyQwXLeTMnV1j70eLXgL/2mBq
   SAMiccMNkZPgOjU5shDORuyADuZir8ovVtG22RIErb0RdT9HlnRKS+Blv
   1nld5/CQ/2JQO5dO04XPEnHgokJuy+w9IH6EdvCrDgU5Xfakq/hiEB2sF
   0aX/kfAQUai89r5iDSUb/BqipHmd0ZUldSyjqMt0Pc6Z93ADWGrc/N0dS
   0iXJltO7TtrmfmLacVeLHNUyHmeCIqDzgrr53mtq+Cq4LxICbALNQfoSA
   7cUa6G73tDx2+Yc0GdLwNJi2l3HRpyLz8WGE5fiNl7KCjBYerPpQ09ZuK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="3426165"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="3426165"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 22:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="757715194"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="757715194"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 22:42:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 22:42:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 22:42:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 22:42:12 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 22:42:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AECT32CDR6cFDbG9p8eI5pStW5VDexjvW/13seGxtv+aySNnUcQd7U/+RH/h+h1KtSjq7Yvu15fxDsNSnPfrOzoV0ebUeBbZ5txOA4WqEAIkb9C4QLkfeapbC6+23Jg2vaKNyVJ0UGai1KFbCkituyH1IscTIAM1HqMXFS8HKEBiFpFzOgebGDhI+r5WUZOEVjSBqXXNNn4obcGnPswCSFoJPK3UzgvyaPM7FYPHt4TJhVic3VnqJlZgoq/3RTTkFtLupSQciq+7p3cbxNWNqlgsxaIuify5rWKBWOd8TrjSCfXxAkE71iRHPyC+Fak6oGM9/QJ3k0kcahw/NAxfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X73+MY9OVcPbpAchJRE4ERH3/BpNZFWWqv6UGUcd7PY=;
 b=K8GV03lN3izqrjn7ngkTUb4chyt51+Ot3J/p3h7SSVU/NXdjxa1Oyj5WAIkistoKhEClN2Jm19WHFdn55J0vLOiWDak5bwr2Jl8W9m8wh59edU8aLYWK/Ly+iJdEEVZMtdivR0mHR+Gp+Zlog5lZ/OhAl/nMa6r/AzQGZQPl+a/MB04p5fL9bPQEhOO7s51ZlxX8ulfzg2xX0wBE92E8Vg5gg2WpjUKIu6lwznHr/H9R/bKYLi3oUY26UDDCEv1QWNb821+s+30qXNzfGaLgsFrAuk6f7w7UfvkuAOwpeY3eBVG6Ts1H2b0RAg1qbJWSoPDWXpJ3e1X+D57+PAgMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 06:42:10 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::d661:173f:52:bdd]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::d661:173f:52:bdd%6]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 06:42:10 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED
 test.
Thread-Topic: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED
 test.
Thread-Index: AQHaDmO/EmlpdaYxjUWH0jrZywMzP7Bwg4eAgAdVVRA=
Date: Mon, 13 Nov 2023 06:42:09 +0000
Message-ID: <IA1PR11MB65141693FD1808D40560A4FC8FB3A@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20231103142936.393654-1-tushar.vyavahare@intel.com>
 <ZUubk1lZ6WDDV2k+@boxer>
In-Reply-To: <ZUubk1lZ6WDDV2k+@boxer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|CY8PR11MB7687:EE_
x-ms-office365-filtering-correlation-id: 3f50078c-1e9c-46bc-891b-08dbe413a8fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSPw/Gw9AaSU/jcrGKRJ0fZX/eQuzrYz/Y2O0lZz54Ikb7yqrlu16zEP+LyUttRDDKroRN+Uib3gqE1yFCCkaHjh28LR+nHcE6KJUbkkEnr7ffRmwQgbctTeK0uWzIHm47gqL3KtSlQGkj2+e1yg3rBAQkFslracTQCeYDEOJoXH0njDFI17UTZK1H3Ue7sQzoNm+w6zfdvxL1mrYrB11eQIcrm3pwDWpOliLwFS59uv0BM+2oZs9/urDx2XOYxnNjf7uLio0DutXZLm0UxrxWEsS+W+lPbo4qD1nGB/Ebn901caJ/CALOYOnVfP6QPMOQpGzT9UGh6mKOBc6c7uFcMZoir8Lk+JIwbb8ZZgAA3r1a08YLvl3mCpDNywjavsp323JZw5Mzn9O7S2OqSaBAfAILKc2XppXK2x4tQPV8J3kJsIHZZySZSpCeLaBTSgYNkJ0wWnGXTE0IfD5zewKWLunHFTHhDqzCvdX117DckbGU+4zJFmtzn8TSfUEEVgjhET6ehG3dhCKdDP5ye8pRp0HBa269pyVwujQYYWdk+nYceBgsMrknrinSU8czOIyv36MQ7u8HM/a0mSxu2gmdwrtQneL3xEhr0MfEXVqZ4taenXRPT77vIqqpZtg6BL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(107886003)(38070700009)(2906002)(52536014)(71200400001)(5660300002)(86362001)(41300700001)(33656002)(26005)(82960400001)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(6636002)(9686003)(316002)(55016003)(83380400001)(38100700002)(478600001)(122000001)(7696005)(53546011)(6506007)(8676002)(6862004)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mOkZYgKPIGmVgfkWlsYchkrT1KrPB4DRptMPcuji1+CGBAulIqbz3h38eGpl?=
 =?us-ascii?Q?+C+pQOkTq9KKbE2SxYmye3RrLq/9PwBs/lK5m9JxOmv9LZ9vuj81z2MNYBJM?=
 =?us-ascii?Q?iaKHbn+COzb1hxcceg6D1U1TmgNuwLYVLz+xc5dLizEIOMkpR2DvP1gtDv67?=
 =?us-ascii?Q?QSVdvxSZG3px7SLyrJI20qZbzSLMJwjYbQrcf5dqRZltmtm59+KCw3Yu42D4?=
 =?us-ascii?Q?Oujaa6GHXXki4ggLWYFy7uZ5bryr1KUzGaHWaT7NmodJ3Z3N0aAsHm28P0ok?=
 =?us-ascii?Q?4EipnnXOdtZFHCvvtHm7Rgus6jDal9OIRH6M6h61WjzEff60UtCQvJAXOZvY?=
 =?us-ascii?Q?lBdZarDIB4qaoa5X9xNiiQEpN2y8QM/XVVxPS7r4dV43JLE10J1ItRFdkba4?=
 =?us-ascii?Q?fx78wF776DO1XpHZGEYf7VrKsmhynDdUklCYpjTdTdDq56sHQ9wcmZoiXU5g?=
 =?us-ascii?Q?Id3F/ying6DElDwr/1Ts15XlZ1wuMztHqPKNDoDmmXVBE1oEHad4Yx2++02t?=
 =?us-ascii?Q?qei7DC3oInt6qrcdG16/IoueApsCD5ICEq4u30jQF7TWGVhoECwWKnroxZYK?=
 =?us-ascii?Q?8fbTtgCsnV+F75FrEEnBN4LZZLyPNI4qDLgugSFuyut5rT/T2ffGKIhNvtxq?=
 =?us-ascii?Q?mEI8ucLNqtwvBF36yEbI1PpJVd66uAogAV0RkwqxxyTgij0xLfs1RujqJ4wJ?=
 =?us-ascii?Q?5pa5LCoW42CwYOiZvJnd4njhzPZqAp87Kfxi6dRWu58LXX1NRItSWrUVw+S1?=
 =?us-ascii?Q?pnsgM1MgUn5x02hZwaTtF5BSLn9YaPw0hGpphFi+AkrGvxAgrkqy8g4sTveD?=
 =?us-ascii?Q?Z920tHQBuZ7ZoIFhZw5B/R+0cgvxPoA193EGFikThRWOB+fslocvhjw0VmJt?=
 =?us-ascii?Q?BVhFfRf5IdjpnSPxHAeko75T2BpZ26Qs20rsR2z5SeNGvmSGpJqvmPHd2eXk?=
 =?us-ascii?Q?q02sBxVPAiO0OduvXnX33kNA3chNu2ghHjUkOxKsPBlFrloZOGQD0xY0JmkG?=
 =?us-ascii?Q?zuBgor9IaYDK7jD9CpCFMfaoR9ZVk8yIGi9gAdf4Sx6sbdn1MUS8U+Rgkuxi?=
 =?us-ascii?Q?II/leK/yDgCb1T1AntcT7X8Mv/SKiOjnmrWc6wAly2XqKPfCpKix5WsR88h5?=
 =?us-ascii?Q?KRGzCvoYcnfWCSMzzT/F0k+uNvHMY5YKmQfBv9zoAuzqWU6ITM9r2VszTa2+?=
 =?us-ascii?Q?pswYAZgVtX+v01HI9C6Rsk8QgYjLegBU6uk+a3/YXytvHxTnwOfl5udtnbu/?=
 =?us-ascii?Q?QlUlMsrsVa2I3MDnc/61Q18GpXZZaWwy2LAdbmfIF40GdybHE712JQG0U7RS?=
 =?us-ascii?Q?kNlNZAHW571ebHOET2kfF5vbldyqv0Gh2mvgBDTWL5Xz7FaWVoeCHyABD9cg?=
 =?us-ascii?Q?fuLYtOcTseSxv/9BS/x4UjG/4FAlaPj8jcq+EL66xXbSoEgmbXghSDNykFvW?=
 =?us-ascii?Q?xo4nGuXdIRoz/HvGA5lok6bwmHExOxkTjiBKbSiCrygoKncqUY3eRGi63pb3?=
 =?us-ascii?Q?kg0LIpPBAgA8b2KzjE3aozt3tKhgMWrsxic5GBDJZhG8egYc+FAlayOdOCDF?=
 =?us-ascii?Q?njqsvvkdom7A4CsJUGKnL2pg9N8sCkF8PLHCUovC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f50078c-1e9c-46bc-891b-08dbe413a8fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 06:42:09.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bX8pl0by+KllSi1cUF4SKXZlKV/ifLA8iuVZ28b0Y7GE9qBTTsBdXs5US7njfO71W7YYIxFwlXmabKBnVzzwX3TGp8tp+e2RZIQVxSN22FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Wednesday, November 8, 2023 8:01 PM
> To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlss=
on,
> Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> <tirthendu.sarkar@intel.com>
> Subject: Re: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGN=
ED
> test.
>=20
> On Fri, Nov 03, 2023 at 02:29:36PM +0000, Tushar Vyavahare wrote:
> > Fix test broken by shared umem test and framework enhancement commit.
> >
> > Correct the current implementation of pkt_stream_replace_half() by
> > ensuring that nb_valid_entries are not set to half, as this is not
> > true for all the tests.
>=20
> Please be more specific - so what is the expected value for nb_valid_entr=
ies for
> unaligned mode test then, if not the half?
>=20

The expected value for nb_valid_entries for the SEND_RECEIVE_UNALIGNED
test would be equal to the total number of packets sent.

> >
> > Create a new function called pkt_modify() that allows for packet
> > modification to meet specific requirements while ensuring the accurate
> > maintenance of the valid packet count to prevent inconsistencies in
> > packet tracking.
> >
> > Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem
> > feature")
> > Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 71
> > ++++++++++++++++--------
> >  1 file changed, 47 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c
> > b/tools/testing/selftests/bpf/xskxceiver.c
> > index 591ca9637b23..f7d3a4a9013f 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -634,16 +634,35 @@ static u32 pkt_nb_frags(u32 frame_size, struct
> pkt_stream *pkt_stream, struct pk
> >  	return nb_frags;
> >  }
> >
> > -static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt,
> > int offset, u32 len)
> > +static bool pkt_valid(bool unaligned_mode, int offset, u32 len)
>=20
> kinda confusing to have is_pkt_valid() and pkt_valid() functions...
> maybe name this as set_pkt_valid() ? doesn't help much but anyways.
>=20

will do it.

> > +{
> > +	if (len > MAX_ETH_JUMBO_SIZE || (!unaligned_mode && offset < 0))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static void pkt_set(struct pkt_stream *pkt_stream, struct xsk_umem_inf=
o
> *umem, struct pkt *pkt,
> > +		    int offset, u32 len)
>=20
> How about adding a bool unaligned to pkt_stream instead of passing whole
> xsk_umem_info to pkt_set - wouldn't this make the diff smaller?
>=20

We can also do it this way, but in this case, the difference will be
larger. Wherever we are using "struct pkt_stream *pkt_stream," we must set
this bool flag again. For example, in places like=20
__pkt_stream_replace_half(), __pkt_stream_generate_custom() , and a few
more. I believe we should stick with the current approach.

> >  {
> >  	pkt->offset =3D offset;
> >  	pkt->len =3D len;
> > -	if (len > MAX_ETH_JUMBO_SIZE) {
> > -		pkt->valid =3D false;
> > -	} else {
> > -		pkt->valid =3D true;
> > +
> > +	pkt->valid =3D pkt_valid(umem->unaligned_mode, offset, len);
> > +	if (pkt->valid)
> >  		pkt_stream->nb_valid_entries++;
> > -	}
> > +}
> > +
> > +static void pkt_modify(struct pkt_stream *pkt_stream, struct
> xsk_umem_info *umem, struct pkt *pkt,
> > +		       int offset, u32 len)
> > +{
> > +	bool mod_valid;
> > +
> > +	pkt->offset =3D offset;
> > +	pkt->len =3D len;
> > +	mod_valid  =3D pkt_valid(umem->unaligned_mode, offset, len);
>=20
> double space
>=20

will do it.

> > +	pkt_stream->nb_valid_entries +=3D mod_valid - pkt->valid;
> > +	pkt->valid =3D mod_valid;
> >  }
> >
> >  static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len) @@
> > -651,7 +670,8 @@ static u32 pkt_get_buffer_len(struct xsk_umem_info
> *umem, u32 len)
> >  	return ceil_u32(len, umem->frame_size) * umem->frame_size;  }
> >
> > -static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32
> > pkt_len, u32 nb_start, u32 nb_off)
> > +static struct pkt_stream *__pkt_stream_generate(struct xsk_umem_info
> *umem, u32 nb_pkts,
> > +						u32 pkt_len, u32 nb_start,
> u32 nb_off)
> >  {
> >  	struct pkt_stream *pkt_stream;
> >  	u32 i;
> > @@ -665,30 +685,31 @@ static struct pkt_stream
> *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
> >  	for (i =3D 0; i < nb_pkts; i++) {
> >  		struct pkt *pkt =3D &pkt_stream->pkts[i];
> >
> > -		pkt_set(pkt_stream, pkt, 0, pkt_len);
> > +		pkt_set(pkt_stream, umem, pkt, 0, pkt_len);
> >  		pkt->pkt_nb =3D nb_start + i * nb_off;
> >  	}
> >
> >  	return pkt_stream;
> >  }
> >
> > -static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32
> > pkt_len)
> > +static struct pkt_stream *pkt_stream_generate(struct xsk_umem_info
> > +*umem, u32 nb_pkts, u32 pkt_len)
> >  {
> > -	return __pkt_stream_generate(nb_pkts, pkt_len, 0, 1);
> > +	return __pkt_stream_generate(umem, nb_pkts, pkt_len, 0, 1);
> >  }
> >
> > -static struct pkt_stream *pkt_stream_clone(struct pkt_stream
> > *pkt_stream)
> > +static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stre=
am,
> > +					   struct xsk_umem_info *umem)
> >  {
> > -	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream-
> >pkts[0].len);
> > +	return pkt_stream_generate(umem, pkt_stream->nb_pkts,
> > +pkt_stream->pkts[0].len);
> >  }
> >
> >  static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts,
> > u32 pkt_len)  {
> >  	struct pkt_stream *pkt_stream;
> >
> > -	pkt_stream =3D pkt_stream_generate(nb_pkts, pkt_len);
> > +	pkt_stream =3D pkt_stream_generate(test->ifobj_rx->umem, nb_pkts,
> > +pkt_len);
> >  	test->ifobj_tx->xsk->pkt_stream =3D pkt_stream;
> > -	pkt_stream =3D pkt_stream_generate(nb_pkts, pkt_len);
> > +	pkt_stream =3D pkt_stream_generate(test->ifobj_tx->umem, nb_pkts,
> > +pkt_len);
> >  	test->ifobj_rx->xsk->pkt_stream =3D pkt_stream;  }
> >
> > @@ -698,12 +719,11 @@ static void __pkt_stream_replace_half(struct
> ifobject *ifobj, u32 pkt_len,
> >  	struct pkt_stream *pkt_stream;
> >  	u32 i;
> >
> > -	pkt_stream =3D pkt_stream_clone(ifobj->xsk->pkt_stream);
> > +	pkt_stream =3D pkt_stream_clone(ifobj->xsk->pkt_stream, ifobj-
> >umem);
> >  	for (i =3D 1; i < ifobj->xsk->pkt_stream->nb_pkts; i +=3D 2)
> > -		pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
> > +		pkt_modify(pkt_stream, ifobj->umem, &pkt_stream->pkts[i],
> offset,
> > +pkt_len);
> >
> >  	ifobj->xsk->pkt_stream =3D pkt_stream;
> > -	pkt_stream->nb_valid_entries /=3D 2;
> >  }
> >
> >  static void pkt_stream_replace_half(struct test_spec *test, u32
> > pkt_len, int offset) @@ -715,9 +735,10 @@ static void
> > pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int off
> > static void pkt_stream_receive_half(struct test_spec *test)  {
> >  	struct pkt_stream *pkt_stream =3D test->ifobj_tx->xsk->pkt_stream;
> > +	struct xsk_umem_info *umem =3D test->ifobj_rx->umem;
> >  	u32 i;
> >
> > -	test->ifobj_rx->xsk->pkt_stream =3D pkt_stream_generate(pkt_stream-
> >nb_pkts,
> > +	test->ifobj_rx->xsk->pkt_stream =3D pkt_stream_generate(umem,
> > +pkt_stream->nb_pkts,
> >  							      pkt_stream-
> >pkts[0].len);
> >  	pkt_stream =3D test->ifobj_rx->xsk->pkt_stream;
> >  	for (i =3D 1; i < pkt_stream->nb_pkts; i +=3D 2) @@ -733,12 +754,12 @=
@
> > static void pkt_stream_even_odd_sequence(struct test_spec *test)
> >
> >  	for (i =3D 0; i < test->nb_sockets; i++) {
> >  		pkt_stream =3D test->ifobj_tx->xsk_arr[i].pkt_stream;
> > -		pkt_stream =3D __pkt_stream_generate(pkt_stream->nb_pkts /
> 2,
> > +		pkt_stream =3D __pkt_stream_generate(test->ifobj_tx->umem,
> > +pkt_stream->nb_pkts / 2,
> >  						   pkt_stream->pkts[0].len, i,
> 2);
> >  		test->ifobj_tx->xsk_arr[i].pkt_stream =3D pkt_stream;
> >
> >  		pkt_stream =3D test->ifobj_rx->xsk_arr[i].pkt_stream;
> > -		pkt_stream =3D __pkt_stream_generate(pkt_stream->nb_pkts /
> 2,
> > +		pkt_stream =3D __pkt_stream_generate(test->ifobj_rx->umem,
> > +pkt_stream->nb_pkts / 2,
> >  						   pkt_stream->pkts[0].len, i,
> 2);
> >  		test->ifobj_rx->xsk_arr[i].pkt_stream =3D pkt_stream;
> >  	}
> > @@ -1961,7 +1982,8 @@ static int testapp_stats_tx_invalid_descs(struct
> > test_spec *test)  static int testapp_stats_rx_full(struct test_spec
> > *test)  {
> >  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS +
> DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> > -	test->ifobj_rx->xsk->pkt_stream =3D
> pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> > +	test->ifobj_rx->xsk->pkt_stream =3D pkt_stream_generate(test-
> >ifobj_rx->umem,
> > +
> DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> >
> >  	test->ifobj_rx->xsk->rxqsize =3D DEFAULT_UMEM_BUFFERS;
> >  	test->ifobj_rx->release_rx =3D false;
> > @@ -1972,7 +1994,8 @@ static int testapp_stats_rx_full(struct
> > test_spec *test)  static int testapp_stats_fill_empty(struct test_spec
> > *test)  {
> >  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS +
> DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> > -	test->ifobj_rx->xsk->pkt_stream =3D
> pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> > +	test->ifobj_rx->xsk->pkt_stream =3D pkt_stream_generate(test-
> >ifobj_rx->umem,
> > +
> DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> >
> >  	test->ifobj_rx->use_fill_ring =3D false;
> >  	test->ifobj_rx->validation_func =3D validate_fill_empty; @@ -2526,8
> > +2549,8 @@ int main(int argc, char **argv)
> >  	init_iface(ifobj_tx, worker_testapp_validate_tx);
> >
> >  	test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
> > -	tx_pkt_stream_default =3D pkt_stream_generate(DEFAULT_PKT_CNT,
> MIN_PKT_SIZE);
> > -	rx_pkt_stream_default =3D pkt_stream_generate(DEFAULT_PKT_CNT,
> MIN_PKT_SIZE);
> > +	tx_pkt_stream_default =3D pkt_stream_generate(ifobj_tx->umem,
> DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> > +	rx_pkt_stream_default =3D pkt_stream_generate(ifobj_rx->umem,
> > +DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> >  	if (!tx_pkt_stream_default || !rx_pkt_stream_default)
> >  		exit_with_error(ENOMEM);
> >  	test.tx_pkt_stream_default =3D tx_pkt_stream_default;
> > --
> > 2.34.1
> >

