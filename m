Return-Path: <bpf+bounces-36663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65EF94B501
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95CE1C21AD0
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A8C8D1;
	Thu,  8 Aug 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GryDEJ3N"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE49BE5D;
	Thu,  8 Aug 2024 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083588; cv=fail; b=igtYDVoZZnohf46UWI3K7822fXzQ7xPexewtvqWYicMqckcPYzXB/8RJMbOl5wUIsiGMdsO9W5C+MYZQxKu/VbpaZeCcuS06EjRjhQfSvMOaThSyItOZQd960/TbSyBKRPMNnBC33Va0y5KfwCCPMErM79qnIIZLnE4Xbcdx63Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083588; c=relaxed/simple;
	bh=Cjk8Cntl8n6keESjEHP0C3xWu9BMdlNZsyQ3mxN005w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f0/IwKpSShItsTE83xJQQdl/HHXNFpI5Yrr6V8nGBVV3WKsFuF4tv2pfJfQYBHQxkxZFGqcTFTpVCwvhbAabvSJM0pkBp8rL46xV+CO36rLxgsbwOC0zfnTL9qFXooyBXeaPibQN5MzolDSrMTeBg5+ZnP+T8T/wXH2073Yc97Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GryDEJ3N; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723083586; x=1754619586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cjk8Cntl8n6keESjEHP0C3xWu9BMdlNZsyQ3mxN005w=;
  b=GryDEJ3NTOMHDCJOY5f1+TrrOqLSjbPTVqMeYCfxgFbXLoc7coLxnTk7
   Rgz+G4zsqv/KGof0YSXza76/qr05XuraKi4XNJM9Bhl8YfFXKb2eItKX3
   72KGvlC2uA5Js4zf/s5qxPYH84z5532jRc8T8z7nhNTemSuOGE9P9084d
   AyJGL+hMKg1GXiTEasvS4d3vd+2r2yOmkM2JBW7z/Fz0r3hkgLN66tbKV
   FQBLhJvkd/wwD8fpIn7dVVXuBPlJ2w31GP5eFSoClcK0J3fjvAg/1lK5z
   3yN276W3v3NcBbOGo1kIL/4qUEPsq1fg5Wsy8VF1xvthCXSSJSp0ovETG
   w==;
X-CSE-ConnectionGUID: KZf9poYHSX2nN5ScCiUZhg==
X-CSE-MsgGUID: rmmYYdOZS/GSEo/vlAEnBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21337428"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="21337428"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 19:19:45 -0700
X-CSE-ConnectionGUID: qHL1iDnQQA6OQrFQdYXEJg==
X-CSE-MsgGUID: RLJwUj4NTb+5XrI1xbqJYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57137886"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 19:19:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 19:19:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 19:19:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 19:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI+wFA/cL+JotB8XiEvoKLfyXHU69yLJ5Hbljfu+lR8TQ1oqhLWuhsgRAasYhe82z50XUPqMgRVRtsJAFjrM+NnmewrThZrulFide1P955D/23nl/sBGtFIaBdoJvyeaKp/NYCypo+KA8pMMwi2g/jM4H3V/Do7x18OlrIfT3f1AGcF7HqZq023xoeyU5VCC7+hWYn4EIU1w3eTAjz0MEwnJILjO97wPnaunEZq3eNrqwbBfhFKBEKzzZhFlduoAV0XJPubvwTFbv8xJT8Bgt+NVj4BKq2CEI4YD0FMxy2B+kPJw7A9FYOi/znvR2uC+HTdczeGykFvDCkiDCQUbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiJl8j/jAefWHCxB0fjOUQDlXnp+fgj7HBUTl+6Vgnc=;
 b=K1fkW7X+4oC0+woAfZUC1CRz6sfbdaccJvlin0Jqz0O3XF+vHI7t61HKF46ur2piZIIW5wPipRwM2wPzeLOQ+/p3fZnjXqa5w/u2OTFKYoB/LkBE78QzG30P+UXDNGLlpW2nuHWWB/Km3zhyst/LqCe6pLyfa8ayB/4RHo8bATwB3bSvzfdv4OmOpmQq2aPqz9E7VDhEAvxgWQprl7yxGHiYquy/DgUCtmAR3ZNYK2ze21nNPHOlWp2hr5W7TghR3MroP8hbIR6gVHDrBJ0w/1LEaVm2lCs2XYeK9L55xiSFz1RI4GI6JwRhvTT2H4EW7jbaK0m2cTwp6Oql/YMfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 02:19:36 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 02:19:36 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Kubiak,
 Michal" <michal.kubiak@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Nambiar, Amritha" <amritha.nambiar@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/6] ice: move
 netif_queue_set_napi to rtnl-protected sections
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/6] ice: move
 netif_queue_set_napi to rtnl-protected sections
Thread-Index: AQHa3erP2SdHIyZiR0mqGO6ND+NK7rIctr2w
Date: Thu, 8 Aug 2024 02:19:36 +0000
Message-ID: <CH3PR11MB8313D0B3B84FC613F0CD2B7FEAB92@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-2-larysa.zaremba@intel.com>
In-Reply-To: <20240724164840.2536605-2-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|SA0PR11MB4621:EE_
x-ms-office365-filtering-correlation-id: fbd05e7e-3ad5-4a0b-5c17-08dcb7508cc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OS7OIQQp8cAmEALx0hSCJY5TsvnEz8piJtg05xbEaDTjmOp03HUGzVlHI6Q+?=
 =?us-ascii?Q?oU1s/xM5qlHYDfyn+19T85ZP/VuKfys0sOAfpIfOPOB7sUBoliEPEuNkWxtO?=
 =?us-ascii?Q?G5vdUey3204UfHPg3rhiBmGWPMwqlZpGJFSJdzUKGegj6LSz/FYgKliV+9ak?=
 =?us-ascii?Q?HgrDqKDS7Pn94BLIrtVm0fEpACVs+t9VBIp75tl92ekj4uI5IqRnUP094PHO?=
 =?us-ascii?Q?DX03WAuYdVNolKO3o5DeSXTCvdeZ/tqBdJcrcv/nxqXYTSCKSg9eD80fnhEu?=
 =?us-ascii?Q?k9t/bYugEZCp75ueVo+m4Q7X1qNOBRzhZQEN/pSmE1Hm1KQJMTdzwGOT+X06?=
 =?us-ascii?Q?cU4SPCvYKw000B/vC56KvXGezn49XJ4u7SCe5HS7xefC7aKnfJhRhuw5ueRf?=
 =?us-ascii?Q?4ZMX44rmZeGIgg/qy8gzuPJP5gNJ45/YDF6+MRXY11K/bmLs3I+WzgyIhsCw?=
 =?us-ascii?Q?4HE1OV1uAR6mcMjRhhKkVR3UmwBcSZhGkKmWYERDk3SLjD3UL2JDDiloSSO+?=
 =?us-ascii?Q?Aigf9/WzZVnWhsDQAh7/JqXIgQoIqzUnzFGCoFSO3Z/6zcMFClOGcXRgFwSM?=
 =?us-ascii?Q?T5g9S+81t3HU0P9jsDExHdxS8CNeMLE9R44cH66RfYYs+itgyogSec/rXgVX?=
 =?us-ascii?Q?o6mGYXmtofrbBzEyNrw0ml4urDXtoFO8eyJ2SOLjney1Dex67kizUDjCvmlb?=
 =?us-ascii?Q?WuejHYb4rKypuRSF+qbzH8ZFansNwxAI+hs+QoCOSV36g/nNSm8fZEhVkCzt?=
 =?us-ascii?Q?S4gMAf9bkfKFkpaT7qxB19qsbMi/Wamm2pcCoeXCHI8z87OyEmjJ0TRJv1d7?=
 =?us-ascii?Q?OTQCCVx0FtVehymBlJVwmGIug4pJv4GleuCUOkJZXcFZgN9tqdQ4KyhpqJAl?=
 =?us-ascii?Q?CeCpq5C+5X7LV6W9RovPgpQBz+COZqD9NmqxX6WG+B5V6+hLqPC4s5PsnIxV?=
 =?us-ascii?Q?9VWbKlO+5O0erna8Odf/2aLZfrrcseQE1o1S9lvD0C+W4ze/nuorGCxjhhqq?=
 =?us-ascii?Q?MzSJzAuNVNvadcLOXVs3ZqvpvH8czzQ4AXYnqNky05NepXoNksuaYeXVu36k?=
 =?us-ascii?Q?dYhRNyeYSSk/0xYCgfrzMK8p0S/zWYPK4mC8lO639vBmEJw6atyTir6eFZ4s?=
 =?us-ascii?Q?5je7p/2PQpjcK5jkZm+jd/rKfwYTfha/UyAWYt9hOZX7LErXyWjO1DmKnGXR?=
 =?us-ascii?Q?s/PBTxdmpi7Cz4fyP8Kwxqb1woMHX3+9rHsp0fEunXa4iXl+V5QKri27eVAx?=
 =?us-ascii?Q?/cVQ6GMnXNOn1m4TYSW7zuhVJJm1a3Ho1NSo9aCprlPWS6Ud7oPTOqiV2Dug?=
 =?us-ascii?Q?X4X2VxtVzsmF32iY+gvsdBCHpAV1GQ98zfQCIHAy0PY39Ti4mlNErHscPbEY?=
 =?us-ascii?Q?yHKqfcK/MdUOdH7tsjZHSpoeniE/enBoYFrZedtxM23iZWl4tA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zsu94YESs6wgMds0EZHdc4sv9wLuQjMD2ElbGRndowUehorjQZMJagTv8A0X?=
 =?us-ascii?Q?C47npnD4l1/Qf1UG5xQZlysbx1L901rwyDWZMyEMO8VRZ5jxWAXhafkenvWf?=
 =?us-ascii?Q?IoDE2qLG+PVg/9Hi4neRrHd2PS/nNs55FNF/KYBnhNxG78Tqh4wYjEa9tzxx?=
 =?us-ascii?Q?BCrb5ZfuOQD/IdBKOSxOhNNitf8/kJvKzx8y5/HyFsB6USsY1AC8l9U57PFh?=
 =?us-ascii?Q?iqwImzvP587fgo21PL6imeq4xKNueOHuNgvX3qf5z06UuhkX3lYJPkXaW3WN?=
 =?us-ascii?Q?exNAPc4DSqpLy5lql59VjwtlpuZaat3cZ2DNogCby9zmZEz8zTNK3gIYuG/S?=
 =?us-ascii?Q?/I4wL2g/rfmJ3ZmWgFNWxlQV4QfuRSEFacTXgNopu3FTddM4636Fof18qjKd?=
 =?us-ascii?Q?2yjUIV8Zgyk0IZG6vmt5DkcFNosvbS9WrN7VhU4jl62mEzYW6418WMgKKFTQ?=
 =?us-ascii?Q?KO9kyXMEGtvqha7HrSK+tIS/GWsRD5xvD7F5qqV0F33+ZYvqYH1RZ6TRp6ow?=
 =?us-ascii?Q?iSuqiLthYBidX+vfM0yr+FKyEZmyPvhsZAilcC3gGPBmSej86sbTBS4NsmuM?=
 =?us-ascii?Q?sL3jDfUxsS9WRdyo05lm81v8FedJXFhNv76BswqIGSZaEZSc0EkLFIETYxTP?=
 =?us-ascii?Q?Kf02P7UIO5mO6YrsPjs6iAVug7Zb7EtRprnhL9/QIk8IUA62Zh+1XnThFy13?=
 =?us-ascii?Q?qih1XEYbWcHkKAeJif713GF8+0cAh58S3h0tC3E/PzY5ol2qAfeVOQcbU2Nc?=
 =?us-ascii?Q?NN95xeP9RnZOois3fgOLNuqCO4oCb+m98IsSuJ6IsMs6TPvB6TnqVFuEq3Yk?=
 =?us-ascii?Q?j5j6RG78+CKL19mthaxC0pULoWy7AA0UOteXNkFppdLmuTCN4IC82JN3OGzq?=
 =?us-ascii?Q?sfStdfkESJr4QpNQNwmZ9LmAVuu+GVmjcPoaa/wUBRL5wDbNSwdl8QeAF0DB?=
 =?us-ascii?Q?809OGDQnloHXX8FFfgwWR1aMhgz9bzDZnBx5A4cGIfXuEOQG3fnyCh/Q5uYl?=
 =?us-ascii?Q?HHQ+nj9Zy/a9lQFbi8IC1CvNBgRA2959atyFzXMwNyVsyfEmVR6SoBiH5Y5T?=
 =?us-ascii?Q?N4O4l/VejL1JcVvSNFz9ZvQptjSjI9yIcQXzNOCF4CQW4MdUTSch43TQEYzi?=
 =?us-ascii?Q?RBltv0PoO+M2opi7vvg55Z+KTv6h1YnHND0mnlXNcimuxqU1lWmnvQdCyylX?=
 =?us-ascii?Q?zFesm7NcnNOBbwIAA8zwFV4axzg8/vosdclu6GeYlfH5U+VB1UlmBvnV/m4e?=
 =?us-ascii?Q?2OJVWwX3O9CTHbnPQ3fLM83pQaEDfqwA8y455VC2sUbOzYW81weE6kxzufMj?=
 =?us-ascii?Q?MQMEFHiRrn4/8O/64mLI9xctYZujfATwOwydv78sQrRZzCZq42rT7+4cDHrW?=
 =?us-ascii?Q?8cske2+orwUVVIdsuzObRdTyXEo7on62B3ZIAxnJlFifmdmbCdoU0a0YelHu?=
 =?us-ascii?Q?coMVgQb6rKXbmz47qYK4tOXq/CXrivMz6orlg2/rEohCO9QMffQFE7C34k/J?=
 =?us-ascii?Q?OFvIvRUYZW17GhkrLfMbVq6qCsyPh5TcTJSnU6+VwEynfb9T5Gldh6AcR3gL?=
 =?us-ascii?Q?FUONFSBjXy88YwUQFy3dxTN+cXTunl3SGzIaDDus?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd05e7e-3ad5-4a0b-5c17-08dcb7508cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:19:36.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2/Gov8eiZqRecMh4asmygRVUt0RsVvrkNaFaaeFEqOia6n+QdXj1cFpYsfqeSxLFOQVrCXoenVd9SIhKeVmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Zaremba, Larysa
>Sent: Wednesday, July 24, 2024 10:19 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; Jesper Dangaard Brouer <hawk@kernel.org>;
>Daniel Borkmann <daniel@iogearbox.net>; Zaremba, Larysa
><larysa.zaremba@intel.com>; netdev@vger.kernel.org; John Fastabend
><john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; linux-
>kernel@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Kubiak,
>Michal <michal.kubiak@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Nambiar, Amritha
><amritha.nambiar@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
>Jakub Kicinski <kuba@kernel.org>; bpf@vger.kernel.org; Paolo Abeni
><pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/6] ice: move
>netif_queue_set_napi to rtnl-protected sections
>
>Currently, netif_queue_set_napi() is called from ice_vsi_rebuild() that is=
 not
>rtnl-locked when called from the reset. This creates the need to take the
>rtnl_lock just for a single function and complicates the synchronization w=
ith
>.ndo_bpf. At the same time, there no actual need to fill napi-to-queue
>information at this exact point.
>
>Fill napi-to-queue information when opening the VSI and clear it when the =
VSI is
>being closed. Those routines are already rtnl-locked.
>
>Also, rewrite napi-to-queue assignment in a way that prevents inclusion of=
 XDP
>queues, as this leads to out-of-bounds writes, such as one below.
>
>[  +0.000004] BUG: KASAN: slab-out-of-bounds in
>netif_queue_set_napi+0x1c2/0x1e0 [  +0.000012] Write of size 8 at addr
>ffff889881727c80 by task bash/7047 [  +0.000006] CPU: 24 PID: 7047 Comm:
>bash Not tainted 6.10.0-rc2+ #2 [  +0.000004] Hardware name: Intel
>Corporation S2600WFT/S2600WFT, BIOS
>SE5C620.86B.02.01.0014.082620210524 08/26/2021 [  +0.000003] Call
>Trace:
>[  +0.000003]  <TASK>
>[  +0.000002]  dump_stack_lvl+0x60/0x80
>[  +0.000007]  print_report+0xce/0x630
>[  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>[  +0.000007]  ? __virt_addr_valid+0x1c9/0x2c0 [  +0.000005]  ?
>netif_queue_set_napi+0x1c2/0x1e0 [  +0.000003]  kasan_report+0xe9/0x120
>[  +0.000004]  ? netif_queue_set_napi+0x1c2/0x1e0 [  +0.000004]
>netif_queue_set_napi+0x1c2/0x1e0 [  +0.000005]  ice_vsi_close+0x161/0x670
>[ice] [  +0.000114]  ice_dis_vsi+0x22f/0x270 [ice] [  +0.000095]
>ice_pf_dis_all_vsi.constprop.0+0xae/0x1c0 [ice] [  +0.000086]
>ice_prepare_for_reset+0x299/0x750 [ice] [  +0.000087]
>pci_dev_save_and_disable+0x82/0xd0
>[  +0.000006]  pci_reset_function+0x12d/0x230 [  +0.000004]
>reset_store+0xa0/0x100 [  +0.000006]  ? __pfx_reset_store+0x10/0x10 [
>+0.000002]  ? __pfx_mutex_lock+0x10/0x10 [  +0.000004]  ?
>__check_object_size+0x4c1/0x640 [  +0.000007]
>kernfs_fop_write_iter+0x30b/0x4a0 [  +0.000006]  vfs_write+0x5d6/0xdf0 [
>+0.000005]  ? fd_install+0x180/0x350 [  +0.000005]  ?
>__pfx_vfs_write+0x10/0xA10 [  +0.000004]  ? do_fcntl+0x52c/0xcd0 [
>+0.000004]  ? kasan_save_track+0x13/0x60 [  +0.000003]  ?
>kasan_save_free_info+0x37/0x60 [  +0.000006]  ksys_write+0xfa/0x1d0 [
>+0.000003]  ? __pfx_ksys_write+0x10/0x10 [  +0.000002]  ?
>__x64_sys_fcntl+0x121/0x180 [  +0.000004]  ? _raw_spin_lock+0x87/0xe0 [
>+0.000005]  do_syscall_64+0x80/0x170 [  +0.000007]  ?
>_raw_spin_lock+0x87/0xe0 [  +0.000004]  ? __pfx__raw_spin_lock+0x10/0x10
>[  +0.000003]  ? file_close_fd_locked+0x167/0x230 [  +0.000005]  ?
>syscall_exit_to_user_mode+0x7d/0x220
>[  +0.000005]  ? do_syscall_64+0x8c/0x170 [  +0.000004]  ?
>do_syscall_64+0x8c/0x170 [  +0.000003]  ? do_syscall_64+0x8c/0x170 [
>+0.000003]  ? fput+0x1a/0x2c0 [  +0.000004]  ? filp_close+0x19/0x30 [
>+0.000004]  ? do_dup2+0x25a/0x4c0 [  +0.000004]  ?
>__x64_sys_dup2+0x6e/0x2e0 [  +0.000002]  ?
>syscall_exit_to_user_mode+0x7d/0x220
>[  +0.000004]  ? do_syscall_64+0x8c/0x170 [  +0.000003]  ?
>__count_memcg_events+0x113/0x380 [  +0.000005]  ?
>handle_mm_fault+0x136/0x820 [  +0.000005]  ?
>do_user_addr_fault+0x444/0xa80 [  +0.000004]  ? clear_bhb_loop+0x25/0x80
>[  +0.000004]  ? clear_bhb_loop+0x25/0x80 [  +0.000002]
>entry_SYSCALL_64_after_hwframe+0x76/0x7e
>[  +0.000005] RIP: 0033:0x7f2033593154
>
>Fixes: 080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain
>scenarios")
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_base.c |  11 +-
>drivers/net/ethernet/intel/ice/ice_lib.c  | 129 ++++++----------------
>drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
>drivers/net/ethernet/intel/ice/ice_main.c |  17 ++-
> 4 files changed, 49 insertions(+), 118 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


