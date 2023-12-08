Return-Path: <bpf+bounces-17181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A380A2B0
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 12:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5637B20BCC
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2E1BDE9;
	Fri,  8 Dec 2023 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8uFPSa+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4AEFA;
	Fri,  8 Dec 2023 03:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702036403; x=1733572403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2E1j7ajYdJtZBX7dtnV9AIicglrrbL83ofPBqdbAAr4=;
  b=Q8uFPSa+Jfo1V5ILYpY0mSx0Re0khUZegS4w9ovJ6tjwdNq7YUVV1yBu
   tGkeNH0bFX6WzE4n8ytL499bLqzNgpMBNGddINCp4fkDzstZQPRSMUw1x
   yyQ23J36CENzx8i3irQ4kYJkgRg3dvVpq4MMl1QBFdRCrPwAbDbxZb27O
   o6OAWCDXBwNxSFc3j5bJkhFukFuTY+8IMS8k+r1OXDVor9VeOD4wnLhPq
   txQWesnXyNlM0D2Noutqng9qneWQdWkdqrgnM/qfHXJi2mwoz8Fmzruhr
   A1Q43KfJtwpCOpiBJSInsoeqCtkM4iGJgLZANv/lJ7Xl47p1NgE7ARhUH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1253742"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1253742"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="13466655"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 03:53:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 03:53:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 03:53:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 03:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq4OeYWcn0uQ3c5v/LEVg2BYrr8HrcGOErXFfz7em41ODWYk22IPlccqNgK15KoPGuYeVUlTl4Om7zZnv1YipR3CUPQ+7bhSEkyqbC28jd4peyhRuvD87rvrfChDWhaVWuU9YnOiLdhk4JJHpRECX+0pW+9FXlPHg3r0ws4zCb9GoJ4xfmFRNKKmjQ5TEfmK+AxUsOytbnd+c6cVw2h+FKMTqjrZr2jaAmR189FcIkEUP3Uam2CLJnlgbM180kXufeyHozQvgoHIW6iS5t6xau7+Ibdxw8iEMdT3WtYnlgRBkd2dPkrvgZwpp6vJJmuKpVDRmPG+XuiDVs+KLR8nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EtN/tYqV8haN10Ua53kHo38/kfbI8ioL+5cIucHcRw=;
 b=M2g0LGYhQsXCHl9c+9QRQ/JvfypSqR3A3EFkzyFznZX+Aj1MiJ1F2GQhrBmJ9/eOFiAgjMsu/398IQtNClb0Ig5FqAqyfcBQ86/J4eOxTwd041ZQqgdliHNpVeHL9RYmkr6QQCWUPpQqr01JRRijRyia7f5HEwRCNo8aoDvrY+MvhVRVGgKUa/BE4qmdS6hjgf5jHGdtJo0R1sp1PpfkLQeclb0qyz0388w+evcvFtCtmiiPHBI7MRQL0iYA+hFtDfkWznWL+ZfJghJc8FRjWgkMJ7cLQMSiWrJUZMOi7PRDZuIEkKjoLS532CHeljZ48ySk4myKlMYlZxaaEmsf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 11:53:13 +0000
Received: from PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::8856:800f:b10:e0c9]) by PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::8856:800f:b10:e0c9%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 11:53:13 +0000
From: "Sokolowski, Jan" <jan.sokolowski@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Chaudron, Eelco"
	<echaudro@redhat.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: RE: [PATCH bpf 3/3] ice: work on pre-XDP prog frag count
Thread-Topic: [PATCH bpf 3/3] ice: work on pre-XDP prog frag count
Thread-Index: AQHaKcoUGQSASPsxZE+Hwq6DDZIk17CfRkLg
Date: Fri, 8 Dec 2023 11:53:12 +0000
Message-ID: <PH7PR11MB58196FC83A5134CAFEDC27CE998AA@PH7PR11MB5819.namprd11.prod.outlook.com>
References: <20231208112945.313687-1-maciej.fijalkowski@intel.com>
 <20231208112945.313687-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20231208112945.313687-4-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5819:EE_|PH7PR11MB5766:EE_
x-ms-office365-filtering-correlation-id: 59fcd5cc-979b-4937-40f5-08dbf7e441a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTSzw3pelD8W2tP/lR8SxbKSUd9j/3asnR/F7RB9TBzSoX09/t7wq6v/rkt2dKVlKivmTiQMFR+BGXWno5KSG8xylUjAuFwscG2wR4kDJM8paOPqN9DUFJvFw/96atUAls1jiycwrysrHw2d3c0/AqNG0AkhZwSlOuT947qj860ycN964edZ2rTB+bcMoNEk1geo8ubOPU/SvvO/aUlGklegx6ivG6Y9/pu9xoEmWSBpEf7J9HPRRoBbGRK/6e1QHoOra//IUa1ifR0Ayvr7KG1Sq3UZRMz8PXrBtZKGZ+RcX8giGCqT+vQYtFDb2GjdXiP55zVIq8j6UXG0dfRe3ikSjmf3WcKox561qGN70EvUFwiAR4cXbpkE2IlFsyyJ/Yj4md358jTqjQyd7haJ2KNWqeAFyG3D8vk/5+ZKhKNk6fKS6OdWWHCcRMmOVhjshEmwkcUe323FhRLDUiEvakrO/IGl1Uvh6Ou9K/51JTnPM84tGQD76MDZuqklfJJBRYoqDlDMNP6YqQK8OsCzxuWG5TUlKl754eYV5qwYYtyMgZHWr3j6KYv/l9FzKqw97WCy+xvV/QWaGMzSPVfTwLASwXO/LVBeTnxy9rrJPhwhMPAga6Opzzs+dgJdyZMC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(54906003)(66476007)(64756008)(66556008)(76116006)(66946007)(66446008)(82960400001)(478600001)(55016003)(83380400001)(6506007)(7696005)(316002)(110136005)(9686003)(52536014)(122000001)(86362001)(26005)(71200400001)(4326008)(38100700002)(8676002)(8936002)(2906002)(41300700001)(33656002)(38070700009)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3oTvymQrl2tH1RwrzYE5uzj/Z7XAeBk+7kH7xVP15GvPBvDuGkuOtkm86Tff?=
 =?us-ascii?Q?1MRSFFzgXu4NrY4Wpo9Y2/ofmzUlx970s5YxaRiataIObaMHiopaQsIiXh55?=
 =?us-ascii?Q?6jbFW6xLEokJxsRKYLaAEbeQP65MHsKTVqtC5fOyLk01uAdRkb0l2Sakyx2w?=
 =?us-ascii?Q?XVjVUh2QsPbA7KtrzRFvVGlSQ2qyE5El8EJHfE8t8UP+AfxXZnsdy0wMDWLg?=
 =?us-ascii?Q?BJ58zrH3LoARtY7kYgEKqwiT4oL2pb6pQb3jBdJUnlOgEQucH6qCXEkU+rbP?=
 =?us-ascii?Q?QjMnubhFF2Q8VE1f9EE6+9mgjAFlraBYT8JqgCrfybhM1l7Kx+jW1J5RPddz?=
 =?us-ascii?Q?r+AU/qhGqEfjoD5ksWUZEokNuheyqSZgvyACDNZ03DUFONjtI9aNZ5jSvB2G?=
 =?us-ascii?Q?4AG570ze8LsAzQEWGAnOvkHOhsodqFMcyQMd9xI66n7dkbfv9Etycue2alFx?=
 =?us-ascii?Q?v5VeTHO4UOS/6XMlYfphsbN9rQJ2RYHkdAb/XQqNqaQZpxAumow6Ljl/4A4G?=
 =?us-ascii?Q?ekc1UzPTKMEPg6zJwCz9MMOlODszjKAinHcdouBF42yb29tVtDnx1dLnbHiw?=
 =?us-ascii?Q?RDrqgZ2qAG/mJUP6OiwPO8R5Yfq5nJwtgrgIRS++6vvoVT45TPisfDoSSqFr?=
 =?us-ascii?Q?UF5xgf8r7v2dx2dYVsw3wZPAM7ij78e7Qp5tpTwKhilGL7zz+W+OPyRfGtBV?=
 =?us-ascii?Q?vvy2dXRsXZFSIEuoiGBdArxqZC6ug4IW0SUJfFdiREi0fS/dsJrgNXB5MFnh?=
 =?us-ascii?Q?bl091eqZX66d1z/xdKubJsaF9Xm0enayQ+IvqDV8DCD03ydoK7GuYflxQofJ?=
 =?us-ascii?Q?Lwxbk6ObVLXXTZw7xe6aqkWd3kdKcWdwOSHyMvgH4M1d1CtjOd+zGfGuE5Ka?=
 =?us-ascii?Q?1A6z8Ghx4KF7G9WQ3xdWpt4V8sFxjrf16kpfy8/f4ax05iANMDhKYT8jd2ln?=
 =?us-ascii?Q?CUZ10mkOg7UEkgMan+KVrpLG102sYz6SmY6WzNkADlyx7a4GCtO6quj1bOLu?=
 =?us-ascii?Q?x5JFjp5qEmd6nCzWamo1kYeG8sCIX0VpjnvdXF0IPIZKreJK4m0632rxTV74?=
 =?us-ascii?Q?mBQMlh769f+gpkyqD5LaUtzqmXwbIMqoib0ARd0or4xY6kHDKppiRDoRVxrD?=
 =?us-ascii?Q?hBE1p6zk5fBUxpBluV5t/8UCOBOiDvPe9ZKT9LSgx/C1hGlwwqhAP08XMchm?=
 =?us-ascii?Q?ht86L3QzV3zK2MTlNSZfbFJwlYqZhdFYlLoPTDnYgDUJVHl1DmjQ/UEq84J7?=
 =?us-ascii?Q?AdSTlUz71uK6ZfI9rdmK5dyGDWfrFFqHZ1jDTUSHSJKaf56x3debriX9WnPl?=
 =?us-ascii?Q?1rp0xYzBCdZfl1Uv8zr5KhWWaRufzrr2ctehvRgJR3fQwaGCEdUE5YqBTDDK?=
 =?us-ascii?Q?knodQ4JTkTTNDN2V2rdjFbLMzKH3b9agBKgR/yLMnZqKE6Caz/unatZCuQ0V?=
 =?us-ascii?Q?QZIj1rEDXSgBiU11wUAn8kGQlte3xz4Blie4JwUtaFrki615DkiQc+Dx0nGS?=
 =?us-ascii?Q?qfznOR52K49dJ3qm7nvFA4PEsI1g+0WPMRO8G45mFRDaLCiYbbdeVvoEvasc?=
 =?us-ascii?Q?Pf4TLuQOu921XvD0hsWrcPsHO32qmlRvvBybhv4D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fcd5cc-979b-4937-40f5-08dbf7e441a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 11:53:12.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/eliyEchg1f2gwmnxIiWR1HFlK0Qq0g0g8z+HS3cpR46x9gxkRpAjJAhJwh/J6VMMc41f72DyOQwGw+agG8vi1eFUz//icDJ0y8NCMXZbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-OriginatorOrg: intel.com

>Fix an OOM panic in XDP_DRV mode when a XDP program shrinks a
>multi-buffer packet by 4k bytes and then redirects it to an AF_XDP
>socket.
>
>Since support for handling multi-buffer frames was added to XDP, usage
>of bpf_xdp_adjust_tail() helper within XDP program can free the page
>that given fragment occupies and in turn decrease the fragment count
>within skb_shared_info that is embedded in xdp_buff struct. In current
>ice driver codebase, it can become problematic when page recycling logic
>decides not to reuse the page. In such case, __page_frag_cache_drain()
>is used with ice_rx_buf::pagecnt_bias that was not adjusted after
>refcount of page was changed by XDP prog which in turn does not drain
>the refcount to 0 and page is never freed.
>
>To address this, let us store the count of frags before the XDP program
>was executed on Rx ring struct. This will be used to compare with
>current frag count from skb_shared_info embedded in xdp_buff. A smaller
>value in the latter indicates that XDP prog freed frag(s). Then, for
>given delta decrement pagecnt_bias for XDP_DROP verdict.
>
>While at it, let us also handle the EOP frag within
>ice_set_rx_bufs_act() to make our life easier, so all of the adjustments
>needed to be applied against freed frags are performed in the single
>place.
>
>Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++++---
> drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++++++++------
> 3 files changed, 32 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ether=
net/intel/ice/ice_txrx.c
>index 9e97ea863068..6878448ba112 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
>@@ -600,9 +600,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_bu=
ff *xdp,
> 		ret =3D ICE_XDP_CONSUMED;
> 	}
> exit:
>-	rx_buf->act =3D ret;
>-	if (unlikely(xdp_buff_has_frags(xdp)))
>-		ice_set_rx_bufs_act(xdp, rx_ring, ret);
>+	ice_set_rx_bufs_act(xdp, rx_ring, ret);
> }
>=20
> /**
>@@ -890,14 +888,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct=
 xdp_buff *xdp,
> 	}
>=20
> 	if (unlikely(sinfo->nr_frags =3D=3D MAX_SKB_FRAGS)) {
>-		if (unlikely(xdp_buff_has_frags(xdp)))
>-			ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
>+		ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
> 		return -ENOMEM;
> 	}
>=20
> 	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
> 				   rx_buf->page_offset, size);
> 	sinfo->xdp_frags_size +=3D size;
>+	/* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
>+	 * can pop off frags but driver has to handle it on its own
>+	 */
>+	rx_ring->nr_frags =3D sinfo->nr_frags;
>=20
> 	if (page_is_pfmemalloc(rx_buf->page))
> 		xdp_buff_set_frag_pfmemalloc(xdp);
>@@ -1249,6 +1250,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, in=
t budget)
>=20
> 		xdp->data =3D NULL;
> 		rx_ring->first_desc =3D ntc;
>+		rx_ring->nr_frags =3D 0;
> 		continue;
> construct_skb:
> 		if (likely(ice_ring_uses_build_skb(rx_ring)))
>@@ -1264,10 +1266,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, =
int budget)
> 						    ICE_XDP_CONSUMED);
> 			xdp->data =3D NULL;
> 			rx_ring->first_desc =3D ntc;
>+			rx_ring->nr_frags =3D 0;
> 			break;
> 		}
> 		xdp->data =3D NULL;
> 		rx_ring->first_desc =3D ntc;
>+		rx_ring->nr_frags =3D 0;
>=20
> 		stat_err_bits =3D BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> 		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ether=
net/intel/ice/ice_txrx.h
>index daf7b9dbb143..b28b9826bbcd 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
>@@ -333,6 +333,7 @@ struct ice_rx_ring {
> 	struct ice_channel *ch;
> 	struct ice_tx_ring *xdp_ring;
> 	struct xsk_buff_pool *xsk_pool;
>+	u32 nr_frags;
> 	dma_addr_t dma;			/* physical address of ring */
> 	u64 cached_phctime;
> 	u16 rx_buf_len;
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/e=
thernet/intel/ice/ice_txrx_lib.h
>index 115969ecdf7b..b0e56675f98b 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
>@@ -12,26 +12,39 @@
>  * act: action to store onto Rx buffers related to XDP buffer parts
>  *
>  * Set action that should be taken before putting Rx buffer from first fr=
ag
>- * to one before last. Last one is handled by caller of this function as =
it
>- * is the EOP frag that is currently being processed. This function is
>- * supposed to be called only when XDP buffer contains frags.
>+ * to the last.
>  */
> static inline void
> ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ri=
ng,
> 		    const unsigned int act)
> {
>-	const struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xd=
p);
>-	u32 first =3D rx_ring->first_desc;
>-	u32 nr_frags =3D sinfo->nr_frags;
>+	u32 sinfo_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frags;
>+	u32 nr_frags =3D rx_ring->nr_frags + 1;
>+	u32 idx =3D rx_ring->first_desc;
> 	u32 cnt =3D rx_ring->count;
> 	struct ice_rx_buf *buf;
>=20
> 	for (int i =3D 0; i < nr_frags; i++) {
>-		buf =3D &rx_ring->rx_buf[first];
>+		buf =3D &rx_ring->rx_buf[idx];
> 		buf->act =3D act;
>=20
>-		if (++first =3D=3D cnt)
>-			first =3D 0;
>+		if (++idx =3D=3D cnt)
>+			idx =3D 0;
>+	}
>+
>+	/* adjust pagecnt_bias on frags freed by XDP prog */
>+	if (sinfo_frags < rx_ring->nr_frags && act =3D=3D ICE_XDP_CONSUMED) {
>+		u32 delta =3D rx_ring->nr_frags - sinfo_frags;
>+
>+		while (delta) {
>+			if (idx =3D=3D 0)
>+				idx =3D cnt - 1;
>+			else
>+				idx--;
>+			buf =3D &rx_ring->rx_buf[idx];
>+			buf->pagecnt_bias--;
>+			delta--;
>+		}
> 	}
> }
>=20
>--=20
>2.34.1
>

Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>

