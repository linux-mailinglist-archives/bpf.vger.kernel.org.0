Return-Path: <bpf+bounces-9623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D379A63F
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 10:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D31C20490
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F9BE5B;
	Mon, 11 Sep 2023 08:50:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8F320A;
	Mon, 11 Sep 2023 08:50:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8970B1A1;
	Mon, 11 Sep 2023 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694422209; x=1725958209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xb8e6aplYfUzLKF54bPsvir4+EpLDq+wHt2dnYNVCh4=;
  b=L/a7/FHrH0vyYTUv8iqwgDhi0BapVTSvdFTA25HVbPGx1mxLGghp7JWO
   LRCSBC8+0l6pgtdd9WsAG5Qq2tlIvXVnPZ7DBkr09n2xkrNtOSl6hYG/U
   C74+ihsRfPcJPyqV2lyPRb2W5Tcgj2dm7yUK5/Ke+3gBNjQ0EVl/sup2x
   vH2A5mh+iEizeaUKTnRsuq8GFjZ5C1TZhPb0EZHoTtMBmndL6QjYnJymD
   BnukI10/K+8JpRGzQQ+RuDOlANJodgr04FdDFYU6+8rvAAQ9ZMA0JrBSx
   I2c1tiZZp1QV6LN9JE+/FOM7OlLawemkn9gsV73LMk5IJHLUf0faoWTy6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444446144"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="444446144"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="746336174"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="746336174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 01:50:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 01:50:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 01:50:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 01:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGRYhrDIu9NxDiIl7sUnMiXloHD07JvjERcyzol3k8JxnpwpV/6B+XESyEY4fP8W5s/gMPXr802fdzadzlx5qXi0wzcGg3ViQHm8I+NDknPadPp3M3s8HLQZ1fOHFua2sjRgaHzOYCW8GM/j54V16nshDqGnY5kV8/k40fghom4bF1VLYGiIKA2Teo3qeqvLVIXeTnSzxFoWU7XhjgRD5ScTUhI/eLua89VOSltGXWUhkNc+MxqpqE8DLGy+lX80Xs4/MqQA/JLMTkkaUr5rELTJ/5ydTQbTHGOsOraJ1XFaHfYe0hx28cAJrdzn7KL0FweHjndVNXjQIm8BGvH+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRomfoIlJPp4fVsbJu4011XAdMn5OadFVrXYp55Xr1s=;
 b=BeMHeflESHoLQrjH6ckzzdYbDQ7yGhLUUBo1Zah4QVRTKBygknlmFEHZn6hgJ03HNGafLYwCOGVvtbYuOIFNvar/0zBJXIMUv663Zm7DvMhtLMKAc99nQmqAVbg2gPenB3Zu4SOV6rj5Vc+2C9897f/faciH17BreGzR7TROetL55U6wJn5R8xkcrUS2q1B/clFzt+r0rVtQhKgMVoznx1GoDZE81M+yXSFEsbBm6K4Y4d8l27nYl2z1k6DfTCsTIzNRQzN8vVmzn3oy3yXiv4ceq9q1HgjPJZg+JH/GXxtS5ivey5txav62LkVRQN4ZkqQfAJYQ+eCbANB/vqQKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Mon, 11 Sep
 2023 08:50:06 +0000
Received: from SN7PR11MB6655.namprd11.prod.outlook.com
 ([fe80::24c2:5b45:e4d6:456a]) by SN7PR11MB6655.namprd11.prod.outlook.com
 ([fe80::24c2:5b45:e4d6:456a%4]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 08:50:06 +0000
From: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next] xsk: add multi-buffer support for sockets
 sharing umem
Thread-Topic: [PATCH bpf-next] xsk: add multi-buffer support for sockets
 sharing umem
Thread-Index: AQHZ4UEOiyfJJbPgdUmSYdofxTJABbAPeQYAgAXdoJA=
Date: Mon, 11 Sep 2023 08:50:06 +0000
Message-ID: <SN7PR11MB6655C2BF5B7E0A15C8004F1690F2A@SN7PR11MB6655.namprd11.prod.outlook.com>
References: <20230907035032.2627879-1-tirthendu.sarkar@intel.com>
 <20230907151250.GH434333@kernel.org>
In-Reply-To: <20230907151250.GH434333@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6655:EE_|DS0PR11MB7333:EE_
x-ms-office365-filtering-correlation-id: 9230d611-2cd4-4577-9410-08dbb2a418ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAVBi1L5nppecVkDdZphj07tPDWNHMMUJ/Pv2uEzrPij8e+5dtkI6tM0LiCgOMI4uoEGjVpKqabWanF3Z/0kKj+wLWIGRanmU1lam8+tVBaUmz1BaJsp1oVhotJkSlQuzatBHcfRA/gU+NszSN3dS09esrpD9jeSloQbOrLYDMyk3md1HO64AwJQTVvmZyj8lcmj6HrTxYfVyddmEGHS/T3y3hP4LUz3Q8WXogTrcj5x8VzW4aXtqfsK7ydRT6W4VZVZ8Rn6wNUg1Pf/feNe2fEX1w2ErXlRJxO1CQPdqUlSiVoEMjZPE0l04cs4k4kQSiHFXLNZayUjOj3jVAIr7erneIdfwlrv5CHQvOivu4O4tISUCZfXtDVxuSNNMEl1rVQpHWTJFi6+Vd5Bjrh89wUAR4+jNP0HJHOWnrIxaIXLJbuaSrWsNXXvXb0onagWZklJgQXTGE6wrjJ7kJWa35M5JAErCCKyBe8FoeeX2ViLGTUEKePc8IHK/j8Rnh2SOpPC/fHANH3t9FAIPEgMdOpBeS/CCmMwMWlwVc2iAtuqg6+d3RBA/TrPTfj9Uu41TrsDVhQZQJXyDfXC3FM6TIQbo/4wB7wlWdzRk5d6yqoVkVwQn1cn+j7WBwgqtBYh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(7696005)(6916009)(55016003)(41300700001)(26005)(38070700005)(64756008)(38100700002)(66446008)(33656002)(83380400001)(66556008)(76116006)(66476007)(66946007)(54906003)(82960400001)(316002)(71200400001)(52536014)(8676002)(478600001)(122000001)(86362001)(2906002)(5660300002)(8936002)(7416002)(9686003)(4326008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OAwbWbdBrC3sBc3gSChrx5YoiZu2QWW3sZS+Ap3iYMZNjJX9jE2DnuN/Moif?=
 =?us-ascii?Q?mk8vspX3xxDdaCUcCXlAE7Vgzx2f2vvzL3jR++WMmWgnvh3CPHus6lKLamKH?=
 =?us-ascii?Q?uMVe710hEF3WD+X4rBLryolEHlg6jqZaJFxpexUlheKl0OxRBr8I/AgLblk1?=
 =?us-ascii?Q?as3Td78V6ydmI+gAR1bIbjIG1htmifAyx5d+XVVTmFX0CWrIKbF9l+wPDUP5?=
 =?us-ascii?Q?iwasV+U89Sf0ioUGGXkOeRuVgrdDjkBpJe6LyjZFzk6b2X26EczCgEm2Fkmt?=
 =?us-ascii?Q?8hZGvsCXHO33y5pSAX9eCnHDfMqqeVhhgTp8HkJYWP7pOpobP/TEQDPO3y8N?=
 =?us-ascii?Q?FF67M39+cwKBJREdbTd5e8vCvjUbQrxQq8ahBE3AWn9sYYQkfLEzl51LA9tD?=
 =?us-ascii?Q?7rckXycTCNkglreVhkp3cXipM/WZCTgRbuldOi01A8edPd8kIcOktQXnD/5B?=
 =?us-ascii?Q?XJQHTY3E8N7RCqVRE9ReNalkhkjd8JPgFqOH8ECSFgIzZiqXikGUAsMq+4TN?=
 =?us-ascii?Q?ZZxTMqlNLddX0ImHma6gURSbgqxhl3VTgeywbsNdOQAlPGp4hz24x/89vZA7?=
 =?us-ascii?Q?ei4XSEN5ivOUY/4ZfQLSrrqDh4L3fCiXuRtKBQ+GEtFhYHtujBRAis1Mrw/y?=
 =?us-ascii?Q?xLmHAKu+uwB5BWFHV1fvkKgds1D9uXBQn0QF2aZ6yYIxLgxMAze2czkx8Zvc?=
 =?us-ascii?Q?pUbtafQAsWQD028uwVmmfptkyVef2nRPtlYamXwBk5cCMB/viC6l7CUcMGUu?=
 =?us-ascii?Q?RHy/EhRjNNHPjQ/Ia/SQpM8zmFkQgt+rnChU7j1uz1rCfQCPCbV//VSY1OtF?=
 =?us-ascii?Q?08siup5gQtAYGPHkLGDDDyqMOho6fSfQw23wVCAuFVS9IE428K4nTyGobMVh?=
 =?us-ascii?Q?fz9aSZlU5x/9IbJouFLojQTIrAmrrRCWrT4cCc3zD03r+Lwj/UYt+YtNEnQ4?=
 =?us-ascii?Q?VMi75q95ssvaOvSw3FS38CobqhBT0B8VRZUM1oOHl4+2S/sUkbmExPsf3zdD?=
 =?us-ascii?Q?xhmb6SWkvnBiLDktIvBHXViti1Ij3tokvqIsOZmXjyznk5W4yGyKS7LJshHY?=
 =?us-ascii?Q?D6DcU/bE0NDwyQTfqNq9JqG7P2Z62nRP6zqemv8Z0M001+oc6m7M3gp4aPQM?=
 =?us-ascii?Q?1KenDwD/CWzj6YotLPifFADOdTkMcP1Vmx7H47d4WONMSStRalHMTnYzgYOX?=
 =?us-ascii?Q?jodiDgv+nA54AerDNaMCrizfwG8DaKDk/rf7AzLr/xMv1xGaVEDxv1SouLWi?=
 =?us-ascii?Q?Ld0UGwJDcjHYwRCxVog/H54iBdw4dgTFT7KhGFxSMwRTDKI3dm0hNSYxf41T?=
 =?us-ascii?Q?nVAFv1/dDzFG4RW57g2AiHCQEvFgjHl+5NkGTL5Sd0VPtSui8G5ZdZYCIJ88?=
 =?us-ascii?Q?UpUi9R7+OOPunKbrBiI6lNBvKDaA7czYyrUHza3jNVVwYTs+yOR6Kq8EkN3W?=
 =?us-ascii?Q?LnodIYLkBHFl++EBfHp6LW9dpTRpnr6+Ey82+f8U5tKv9NsV5obqC5P0rhnU?=
 =?us-ascii?Q?V6XqcnRTQo8Hy/5vawCYaVcOyTIDLqFndYLAOCa5kxllNVYy2/g52/A6dW5Q?=
 =?us-ascii?Q?jSubez/O9jumKnLG6T13OXa4xu9xUE4rTq3x+dTm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9230d611-2cd4-4577-9410-08dbb2a418ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 08:50:06.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2VmyxbNdIfR4XGZC9dkqXbMTGR+7agTohtbZMXmeOc58laZlvhks/l7ur5GRv2BzmfeINjUJI4ugmA3timxstp9Ej8NreyIsJEUSdKzLyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Subject: Re: [PATCH bpf-next] xsk: add multi-buffer support for sockets
> sharing umem
>=20
> On Thu, Sep 07, 2023 at 09:20:32AM +0530, Tirthendu Sarkar wrote:
> > Userspace applications indicate their multi-buffer capability to xsk
> > using XSK_USE_SG socket bind flag. For sockets using shared umem the
> > bind flag may contain XSK_USE_SG only for the first socket. For any
> > subsequent socket the only option supported is XDP_SHARED_UMEM.
> >
> > Add option XDP_UMEM_SG_FLAG in umem config flags to store the
> > multi-buffer handling capability when indicated by XSK_USE_SG option in
> > bing flag by the first socket. Use this to derive multi-buffer capabili=
ty
> > for subsequent sockets in xsk core.
> >
> > Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> > Fixes: 81470b5c3c66 ("xsk: introduce XSK_USE_SG bind flag for xsk socke=
t")
> > ---
> >  include/net/xdp_sock.h  | 2 ++
> >  net/xdp/xsk.c           | 2 +-
> >  net/xdp/xsk_buff_pool.c | 3 +++
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 1617af380162..69b472604b86 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -14,6 +14,8 @@
> >  #include <linux/mm.h>
> >  #include <net/sock.h>
> >
> > +#define XDP_UMEM_SG_FLAG (1 << 1)
>=20
> nit: This could be BIT(1)

Thanks. We could have a follow up patch with such changes across xsk core.

