Return-Path: <bpf+bounces-53692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D3EA588BC
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 23:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D955188CCEC
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 22:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B61A5BBD;
	Sun,  9 Mar 2025 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O5uw8rl5"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021080.outbound.protection.outlook.com [40.93.194.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE90C2FA;
	Sun,  9 Mar 2025 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557697; cv=fail; b=Unea210CMSXfFV8T4zk2rMmsI1shxRzboV1bjmWysjWQaBiTAEdZjc/LoPm2UKrfIjj7Mkjz4xcSPa+tDe9b/uxE/mOnQrqb08ZC61bDPZk8j+hqt3FgLIAF5yugll60bDyII6NsHa9o3bFr/XOZ65h0cC+eQgbgIt89+2oXkRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557697; c=relaxed/simple;
	bh=6/NfFkPxTKRVMMt0ks2iN5kesscuS4V0WU18MX5eHC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Asd81c1L5RCVf54IpjZYWEmQMncXrBvESq0T4qoUspxA7qve4WREpZ+5DTSlMRmDXOi70GitK4zoyPltt/f7CJI8PtNRzUcMHVxPQtGeoSI5YbmHTuTrJup0xuZC5DHWFIQdF1QCbn3qWij+mw3bNtY63qZQVGtsrcflPuIz5J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=O5uw8rl5; arc=fail smtp.client-ip=40.93.194.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nzee8Cw9AUnhEUeEtqA4IiCuUoqiYrvpX/mQwuGBczCapa4d4SmJHuq4WqHfDAAixi3bqLmKFMZqsKpfxK1HWtjMO+svWO4OVIn17hCHPeWqwv2D9C6Kb8CspKQrhHDrCz7+1+2kHurrBh1pySaQSHAtC7Lrs0jkys/IjT8mMceKpSrnw4bdYfdi4qMABDYQXjU1eUGRHpWDUFFmFQ0yxtW3+shmsgRAkay3v1bOulPYdj0ZIZGwuwX+BS3w+BugrtFjNbcOwyq6XYUjmbQ5DiGDrrn0m5i83oV/5zQEDzM4r7JeMyGvszEBh7aoKscIVlkO0oRZWRCN6AjMnp0TUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWofr6bSiZlhzkcCyjDFYvf3cFtVdPTSm7VoLZIdS84=;
 b=leUr1mmhV/RWutbuXDa6BgLMLizXEJua74xKbEuIllwcjP4FVoDsBGvJdnQiR3uaGhw4cSibHBlRXc+d00QXbf94mBjm62w5pD8tppbEMOUMymhiHvBcy5SyJ/6TahntgzMpYQfYFR75dGSRFEPbtmzu0SwgUgod04YQ8IGV+wQXwdqjUzUQWKz5Fk2VqLksj7YI4Vbf9C6KKhkeXTOQBO9Mw14+ObLA9o8iTKzgmxIGSXD1ma+XIGmLv9onKiP65LG7H3nWcynqe9sIr/np82yibRTYSw3wCtp91K5va898plIMJTNd9cdsZQm5ChxJ8P7AlQWOsD2+nYibfu20wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWofr6bSiZlhzkcCyjDFYvf3cFtVdPTSm7VoLZIdS84=;
 b=O5uw8rl5CLBnzDEu2xrhvO751fNH/NCmKVyX+ArVtVnUwXkfIGFaGZeGFKgDZHnUSIxl6+vTh3mqvy1DM+f8lshhoCY09piBEXsNp5+GjDDo8dRExYadPdNX3q0+VrAHqpYwoXBb4ldOlyglJGZurDMkuQ9DeT7fH44iNrb1o+M=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL4PR21MB4556.namprd21.prod.outlook.com (2603:10b6:208:586::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.20; Sun, 9 Mar
 2025 22:01:33 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684%5]) with mapi id 15.20.8511.012; Sun, 9 Mar 2025
 22:01:33 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] net: mana: Support holes in device
 list reply msg
Thread-Topic: [EXTERNAL] Re: [PATCH net] net: mana: Support holes in device
 list reply msg
Thread-Index: AQHbjhgyS8cLhRPnh0m8BhGByKtsWbNonkeAgALCjVA=
Date: Sun, 9 Mar 2025 22:01:33 +0000
Message-ID:
 <MN0PR21MB3437F80F3AD98C82870A9173CAD72@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
 <20250307195029.1dc74f8e@kernel.org>
In-Reply-To: <20250307195029.1dc74f8e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=59979798-71db-4022-bf10-2e14231d7f06;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-09T21:59:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL4PR21MB4556:EE_
x-ms-office365-filtering-correlation-id: c4d3b294-fcc3-4870-6cd3-08dd5f55f466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WlNg9SIW6iFXpeLgLOultMaq2W7qa/bObmVooRm0yO0ShdSdPIPud6BXIk6h?=
 =?us-ascii?Q?O7U5rjVvdmt0EltYm/xmdU6YP9qXLThZFT9J0Rp7I0/zlEWBfHpN5qwntR79?=
 =?us-ascii?Q?xoIZB2cIZlZ6Sg2hXlxf2Cq0SQ5d/WWAVIANLaTNW1ZfJmSh7mWYqUVC85bp?=
 =?us-ascii?Q?On9QajLcGneMKJ5StpZV056heakQWEnVhwhqze4v9WcYM9QCI9OzODeKIZ9K?=
 =?us-ascii?Q?lOf/c4NlLbmhhynUOiDvXIRthXd7/K5bXZvtBv+fBaacdSWYvczNeBCz/97q?=
 =?us-ascii?Q?iTZI0MDSLtDhPToHtPoWe6h+Mnd2l1p7gl2o4kitEQfEDO4FPBU3/o1Rcwu6?=
 =?us-ascii?Q?JP5GVBiKmaG0SXZ4yPItcLuoWKHQ4RJjLEnFIsCdx72FSvYhEaLKqQFyYoDk?=
 =?us-ascii?Q?t9HcB1QA+FDIO3GQz7yBnPdhCZB1dxnYeL3JK1lYBc26+X1FeoY//4TzZXD/?=
 =?us-ascii?Q?7ZS+19Gna0BzQbKH1mSfrc9LP2/e3XhHfV0o769wHyKWKWsfW11Ht0NlPR2R?=
 =?us-ascii?Q?RQPWg2+Ew1LUDXnWA0sQjASCgAxTZLnhKokT5O0CRKeJY5PtrjnEAdbxFxY5?=
 =?us-ascii?Q?TBZq+WrdVAINLwtqrhIW9K1KZv4IIFK45vFlpgNoaXoJOzlWN4oqDUxtkXhE?=
 =?us-ascii?Q?2HehOOx9sYuS049zHUBKizxv4BrabTDJn9jTBrRXArVqx9gA6+OdbM/O0XSR?=
 =?us-ascii?Q?Eb2QqcCiKTERuPwsSvMy4FSiFyO6vYfjople0vNgBciOCwaK77a7AkZCsDve?=
 =?us-ascii?Q?raam1JZ5Hjds0nZh6IB1rGQTnEDl7QMkNpOoZ8sxFHsjKUQ8+kqTRVww3nvZ?=
 =?us-ascii?Q?w7sKKmyafgyR7s2m/gElV+2lILJag1MUAH0cdmyBNSxWW2iNvQWzNBtyA/Li?=
 =?us-ascii?Q?byrnLrf1l7ZqbMTNvyh0kdvn/HzfeHQdQ8kpjBc2jq5HxCOwzijuwlFDS9sD?=
 =?us-ascii?Q?zmZJ1IY0xy6zYEBt2YyrQCxRxLMfy0iLs50mucOCVFc3dH7jZS85DiQigw5D?=
 =?us-ascii?Q?88buABFYeITaBs5zCjKeBsWNUD8pQ6Ocl3VFvlF1M81YLI44EEVMu/+h2o1+?=
 =?us-ascii?Q?2Qovsr4xCq4SgxS4psIqUAwAGcwPMCZKkfDFZj90JAy1y/fReeh6TJuTqIZt?=
 =?us-ascii?Q?3o+XJ4sSGfAs8ljKsNnHGqhAnYbBfiC5grddU6IIvzqVVpQerLTSSLdsJVYA?=
 =?us-ascii?Q?wijsa08p2QR8l8OjoyRRmI6Zs20ZT0nAsPebwtU5zrijBAXJUOVr2tvIbyFI?=
 =?us-ascii?Q?w8RFcTg3c4ohdR6ciX3yaQjYyB5PATvMywmGUVQM7HI/+SDAEP1ys6+sNl7T?=
 =?us-ascii?Q?17jGH4zZ5axerIEZGZ2/H+CDMfYlPovv+QkK1HbGXzuHwfNAcWwV/X8h8l75?=
 =?us-ascii?Q?zCG9XzDqIuKX+DDkFYU+imPqb6kJwYyV2QS6Lzga7xRAZgBVv8AvNLGEQHgy?=
 =?us-ascii?Q?hkOrEsOMhfO+ntBRoEbzNaz9mUadtUhu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wqy3Z7dKA/2YFQYom5hejk8NEdbUUWEEU1wcvSDWDbTx/gIaqW8q6nOdd05f?=
 =?us-ascii?Q?k0tDvxgPur1qdu5qlZBdCH2Xw8fB6HWq2bjCPpjNGrvINyw1Ia+dpu9a8QuD?=
 =?us-ascii?Q?lsXNHaUasTfv6B3Xluj2wsG6f13uXkr3a29ow3cWn+u3gGQtk5A0OMGnT2Sa?=
 =?us-ascii?Q?V5GkbySJ6xFggeWqnuCyXJT9toipr+B9xXtT/1A6JiRuIMltvGGx90tB4j/o?=
 =?us-ascii?Q?Pl1kv3sdVzWjYb3QVOs1TOCbMIBzITh01+yi8WloeqrztQ6e/GPZvvuX3bxm?=
 =?us-ascii?Q?isZVasrxJAxHCHEgaSCQAoODOVmwfkfwEZ+Bpzf2Ldm4sA3ktIwx4a5rLcxQ?=
 =?us-ascii?Q?M//T9QXUU3NzvZe4hgzYArFdLoCwj5nZN4mrYLk6R6GdJ2Toa/rrunTiIHI2?=
 =?us-ascii?Q?AO/T78sZePPKlOzRgdyg+Busk6oXnLzA0VsoLLgMHVBDSb84jowYA1gUfJjn?=
 =?us-ascii?Q?PL8B3QP1kIeoTb2aajqRod6K7YB4o4EjxK4n/Ccum+//aQgmnN7mNjLzTwH3?=
 =?us-ascii?Q?Cb+yNHDfGOqICtMMuoAsSGlb2j+5iT3jYhMNJoCHJzyp/GGafQ3P00G8VnJN?=
 =?us-ascii?Q?ykSjpCy0bKlDm3ilUcm8x1Of3lGd/2BBWiX6hLOQzU3Fr4t95nJeO1BX1uf9?=
 =?us-ascii?Q?qhS0pn7PeTrDS4p3iZMXwmiUnuQwHvwQBLPGio82e3wyyfM7oF/wGRN8xDIq?=
 =?us-ascii?Q?iqZSgdDx96gWi+LzcBie/KlynXE3JPx/b/kEAL1jbwvYmP2jMukEbvpeUWeb?=
 =?us-ascii?Q?fXEYHzji5v3ZLlO8NbIKf4f0PZTy/7slLeBdJEYUWvdOveIqnzDrU+88rU5c?=
 =?us-ascii?Q?z3+9E8oJ+8ttdk49of8X2N0NyQV+vfmQHjx1DDlCX88CR04sOlaYkdbstA3u?=
 =?us-ascii?Q?dpg9t941NLoXGAlOh9Vvd62M78W8TGVHccH5MVLBimtG3Wf4NQJG5AXRz74M?=
 =?us-ascii?Q?TQNQbwMJfnurUhUbzSFp6rliSfoyFLR2YqhkobxmftxVg9MLTTD1yVAwqX5V?=
 =?us-ascii?Q?GAOdElACkcMyW6OShQYrunnRjwX0mtCphwU8EX52cH5W7Lj+3iX0LdB6wczT?=
 =?us-ascii?Q?EpWIICLq1Z/j//QtdwQ1w7jCjIYQyx86/rVKuJvYwf5fK/KJHo9fu7/UaGUF?=
 =?us-ascii?Q?8fKbOqJqMrvg3HoU0jKGyVM8fZuQXw4kCP1OLXPpZWsTeMh+2QCTrorUeCOC?=
 =?us-ascii?Q?EXXffoi8+ad9Q7masMVstmTB+8dpTJNndYFrlfazs5PCTLR6GFH5AB5T+QZA?=
 =?us-ascii?Q?J0A375eAhnQyR4HIMpQgT/31wb7SnbTJJPZ8jp2TTOaFxfQ8xQ+nZ8ylmKh2?=
 =?us-ascii?Q?jgzEi4C3ysQpeg76moc8EZi71/cnJ3z4rChIGl1jPxi0tCsB3f/rAsWFCTz3?=
 =?us-ascii?Q?KmYOMWrIUiIizd1s35PixLYPdoW1puxOKMQApBmqoUt4/3ddQ7fjJSKarJdE?=
 =?us-ascii?Q?NVxScM2VHQTiUjlHW0jznXqGYZDE+3GBw5WoVMMnvPGIaT0YLU7uoqI/KGSc?=
 =?us-ascii?Q?+p/Pe93q7A4AZ9whe5upTBY/qNAXn4LoTZqwTItChR2VXeMM175yIyeBqerX?=
 =?us-ascii?Q?K9n6Kmb9XWNn+FdQ0pZ+ivdcw6zX2onbEmSqYNbF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d3b294-fcc3-4870-6cd3-08dd5f55f466
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 22:01:33.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4bFZSXHQF403ZHcSqJxDxabvWA9sD8gs022FhM3VPHbfQZ6vk/BB2oHTWZPzGYyBEA4UJgiIE/3q6/OzFsSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR21MB4556



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, March 7, 2025 10:50 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; pabeni@redhat.com;
> leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net] net: mana: Support holes in device
> list reply msg
>=20
> On Wed,  5 Mar 2025 13:46:21 -0800 Haiyang Zhang wrote:
> > -	for (i =3D 0; i < max_num_devs; i++) {
> > +	for (i =3D 0; i < GDMA_DEV_LIST_SIZE &&
> > +		found_dev < resp.num_of_devs; i++) {
>=20
> unfortunate mis-indent here, it blend with the code.
> checkpatch is right that it should be aligned with opening bracket
Will fix it.

>=20
> >  		dev =3D resp.devs[i];
> >  		dev_type =3D dev.type;
> >
> > +		/* Skip empty devices */
> > +		if (dev.as_uint32 =3D=3D 0)
> > +			continue;
> > +
> > +		found_dev++;
> > +		dev_info(gc->dev, "Got devidx:%u, type:%u, instance:%u\n", i,
> > +			 dev.type, dev.instance);
>=20
> Are you sure you want to print this info message for each device,
> each time it's probed? Seems pretty noisy. We generally recommend
> printing about _unusual_ things.
Ok. I can remove it.

Thanks,
- Haiyang

