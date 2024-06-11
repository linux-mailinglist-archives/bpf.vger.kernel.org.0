Return-Path: <bpf+bounces-31861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E73390429E
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DD91C2476B
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A75674A;
	Tue, 11 Jun 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Eufse+u3"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88872482ED;
	Tue, 11 Jun 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127822; cv=fail; b=OPdmhqmefntS4edV4mZ9lTTWBpYhCj0R14saGHPkT7w5RRa0PJdBc9aRK5SR5UqWfpFE+KELdveFfj2cYlph959AfzU78qL0zz4l/e+fANCLMmW8A5SL2Hmwax03Kg/FG47Muj5UM+Xa/dnjxzK3immhRNfQU3VZSLmiCWTicOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127822; c=relaxed/simple;
	bh=r99RV1WrgbyVEonbHG2lK0JebGoTicvyFeYUQaHkD5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J265ms1nAz58su3HoQ1FFRcTS3gbHLFPUUe3QWk58dI5t9xIwOlELOiog0kzSCIimlX5UEs6o5Y6GnSOoWbgBVDSpXDo6BlrTzdW2VE8DeW6pXJ1SU4NytpA4343sqezMl6i8/Ru2Jq5R5NHrcVSYMjHli7Tv3u9cZpopzvvjHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Eufse+u3; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaPspAN5AunXzGNH6wqOnXSfRXutUehBH3o9+zussvL21nJ9xYKh3xwKBFwgx+L7EmhsOvpHX75eURMuxtGW9I7UOaXPw+1cTPbgPAnQXrOBA2LZ+LGON2BLgqSBpN7HI04Awn32K1aUbUgZ6odqu3siNj7KL5DkWrZ/or3VHAiUUuXr0xsnir/Tdsj1DRjb1QoLOYmbMGtIMBldzGsP4SYZAXpdsHRQizJaY4PvU0J/OKZAdVIpCjQnnI9KWYDtvBA9rlsLnrjzOpSEYaJ63NC/14s2riWVVej2HEFSt4qbptEP/2+fMiNsY9Cjs38PvIRWbGV4CM4Dlk0lGsmbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r99RV1WrgbyVEonbHG2lK0JebGoTicvyFeYUQaHkD5o=;
 b=fXtXvUmOnFy/Z4rKKT/mHTHvBfuo914/rwerJTusorUhaXrf5qpsgM8j/uPJUxQW8ADBMMufLcbXIt//EmPjYYEjWwCBL6hNhiFtkEY+TNxJeaBGIrjiUKT/MUxMajjohUebfsWogE59A4cY+5sYkpdCkOFQFXWezjn/bRwnkCdiinKCaey3hjjiiFIxjBlj2xlEidNfUlHOXLMrLrrdmfIjAuDMLdtPCRkd+zytYY4fwj94xmQk2xwhQrSJLXyRRZ4g4WiKP1fWXUfNz5U8T6l1INT40PVx699KOm6HTW5u5zNPuRM9AKjMl/CFocd/WX1AE5GT2gVE0u7OKaqKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r99RV1WrgbyVEonbHG2lK0JebGoTicvyFeYUQaHkD5o=;
 b=Eufse+u3TPKasvwnvETfVbtPjUhA+o/OipNGUlyY65Hv3Pg2tQeIG94acLs+6BMBgyTmx/2ov9TONJvSNW5J54oze8zKNx6YaDzDNYwZilkO1Z9SuposKwoYYdVZWnb6N19sby0pKPsFtWFhzsYW3lottYmn0B9oBGxdW/QOHVY=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 MN0PR21MB3677.namprd21.prod.outlook.com (2603:10b6:208:3d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.5; Tue, 11 Jun
 2024 17:43:32 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7%5]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 17:43:32 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Topic: [PATCH net-next] net: mana: Add support for variable page sizes
 of ARM64
Thread-Index: AQHau3yCjVULPkZ+NkeRwzD4A2YQ07HCw4UAgAAC/7CAAA858A==
Date: Tue, 11 Jun 2024 17:43:31 +0000
Message-ID:
 <DM6PR21MB1481E3F4E4E26765CCF6114DCAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
 <SN6PR02MB41572E928DCF6B7FDF89899DD4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DM6PR21MB14818F4519381967A9FEE8B8CAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
In-Reply-To:
 <DM6PR21MB14818F4519381967A9FEE8B8CAC72@DM6PR21MB1481.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: paulros@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fb4882b-67e9-4568-8c78-027b60b1813e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-11T16:45:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|MN0PR21MB3677:EE_
x-ms-office365-filtering-correlation-id: be4088b1-2742-4682-c072-08dc8a3e02dd
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|376006|7416006|1800799016|366008|38070700010;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?hxmCHwDmJmHlO2RAWmo8oKnGd2MtHdMAISeOmItjwE6ztY2ZAMU7X0+Adu?=
 =?iso-8859-1?Q?yPWad8Os9EI0xmknZtIuJ7dMLss4WW0vNtT0V8ELHfmP4k3AvorAI+lr4R?=
 =?iso-8859-1?Q?9XCBWQfHrVWvfqcreAsicoKIdB6Id5ukKImtZOQfIKS0AfeTTDZEhLOYWR?=
 =?iso-8859-1?Q?n3yeFOAqq55JNgNxzYpi31/CAittAWRj8ljQbk+BS/4fN50KHEUUwKqq3W?=
 =?iso-8859-1?Q?98od6tnnuHaB32QfHuu7CV24UiyqlnzWDm/Rh61JxhuEl735toVZL87P3/?=
 =?iso-8859-1?Q?tohg2Svnsw8B1VmrS23C4/NW82pDnlS2SOHpfZcsYQZhxjXS16EZDuUyEw?=
 =?iso-8859-1?Q?9+FZPEX13F7laeiN4PHJ2QDPccijjMk7/FkpK04qShhRMka9lOn6UVxTjG?=
 =?iso-8859-1?Q?JVxHx0PuJrG8V9k6JQmkLGmEI+dVHZL61H0BQ1lfwF7h1ZFn7/euzXDMI2?=
 =?iso-8859-1?Q?QaWdGMYoIl74lPScsGF8UAs1VE7AGTlyHf7bAPhjVaFxOLj2Xf987btG6k?=
 =?iso-8859-1?Q?HTzRRWPHCsq4LSObKyZRs8F+PFsVC22t7OCo6UIjL/v76bzkHggPvqhX1k?=
 =?iso-8859-1?Q?ZFr8CAnjBaPQI+MHFrDETUlnDwjAJNPePdzW4Z0QOVpXo5xUeEdfBy1tEQ?=
 =?iso-8859-1?Q?pupTnOWUqbjxtdEyml6YMu/Ne4e+UQsovWYMW22cAqBumeaZ3VDXaZ8r9t?=
 =?iso-8859-1?Q?D7AysWLr4OWuIGXQjmCvEH5FMQOqzlmQEY1ewT2IyDsYwWTAtSvrqGePzy?=
 =?iso-8859-1?Q?H0ZQEzVph+ZnLmZ+1zDC8A1SWwtnbHSftvKZhLNi9fGlkVB1ROwG7LYeZI?=
 =?iso-8859-1?Q?GUpqHFU/L0aIzXlzNAoXyUtRZcpW9uZ9SuXbSvbmsbtrJNxnRz1Om2k4SB?=
 =?iso-8859-1?Q?xv1SHznYg94AFf0YAd680ZnZ11FF67PP+EtRXqSJMYGn8GVR/i2fS/aDiY?=
 =?iso-8859-1?Q?X0Bgq7CbIUMD2U0ZDsH03QabSU7TzOoRi9NztfdHXWk68Lm3di1rCySD0S?=
 =?iso-8859-1?Q?rjF9z8fSaJMxmZKcxOoB9HDgPYMH7ZV9gjhefohsOJDUi49w14TAIM5S52?=
 =?iso-8859-1?Q?wCcV93h6MEA6VjzJk1MH7dLAZbhGyBNoGVRBWgiw4Sj+hSnCXwXVCycX11?=
 =?iso-8859-1?Q?uXleDlGvZvKyE8+fUb0fqu0vQ+CoCORV8uWHSd+KVZ1E3D+7WHC5b7AmCR?=
 =?iso-8859-1?Q?79y31WjVT+v8plViTyIy90jL98UFDzjSDjTpYW2qAnlo8tanm48j1d2dFq?=
 =?iso-8859-1?Q?e1A9M+ozLKe5zyKjBqGXC5IF1EEkGm9sOihZ0Nlxng6hbEe37o/oWzINX5?=
 =?iso-8859-1?Q?LO7Fo7J3FnkNbo4T4yQNYePN8K9DpvVOrZxRZ4J9ots7VuAU7CdQwgDVYA?=
 =?iso-8859-1?Q?+z8gHkKje8osviiSrLnJhAO3htE+sNQpUdwRNflHmRgTDVwVb01ME=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(1800799016)(366008)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Uq0xGNmvRvO8CiZw0+GeFkIiV9TJhLHgr2kGiWlLFGzorZb+7Zo+3tr74z?=
 =?iso-8859-1?Q?UpvpPA86H0uzcFyPC8v37aCdHFoR7W0/r3oyM+4Im9yivdMOfKXDInJMg7?=
 =?iso-8859-1?Q?KKWtUhL8q2PXeOQkel3/5SLRAwg4IIKWtxjqp8s4d60lKcIp4YwPx+EuV/?=
 =?iso-8859-1?Q?Q0OwqMJlyEwj+I+tlOWrZt6gkyj5Cr1yq9gYbdnHWxdVvzW6eeB1lI1BUv?=
 =?iso-8859-1?Q?hKTOvothDkbZMP4MeMn05E5NckkF0NcA/yj0kdX13l/7kAXpK2niKfTUcr?=
 =?iso-8859-1?Q?0ETPI4Msf92+oB/5PXnmvl+wHfBabJ2KR7CVHgTbl2KlS3xgTjZCJr4FvK?=
 =?iso-8859-1?Q?65ThRc+OBULl7Awa6BAl18k/5YRgtgV3DDHJft2nSBeVkuEBAcVJ+3R0WM?=
 =?iso-8859-1?Q?dwNJeXk6m+hcEDb2W508diDUdx6N7ubrDdpRkfR7hr+7ZSVuHkefKd+jbm?=
 =?iso-8859-1?Q?IEGfcM6rtwhvwp1HJUrJpYgT2OE4Wmaz52C6uM1aL3gZcKRkgFDNT840yW?=
 =?iso-8859-1?Q?LXPzV/JIXmaqiujrpKsavO03xuCk49/N39UVHLuhANsY/1vY1J+VnBESgS?=
 =?iso-8859-1?Q?4VuAR25sm81io636H8BoofdAsHCQWhiBFBDhomJ5K4MK5lt17Ug70kQp3G?=
 =?iso-8859-1?Q?F0lrgUa92FkxjNXyTqj0yo9lxWjOtMEfgfuvC9BHeYYUtVflVk//dNKD5+?=
 =?iso-8859-1?Q?icwnqrqRWh7OzOOxAipthUcApHp0a2br/WTD/J9Uw5FK7+3LkrDpa8hsdC?=
 =?iso-8859-1?Q?7QqL9nml7jm6EF3WlB67QVv3hfTm7mCplnJ0zuo680GcT/khDejWWP/ke3?=
 =?iso-8859-1?Q?Ps6vemSHcEQukeTp+PzLVXq32vS6D9dXTVXVFhL04L/Tv5lZqtzja9c4ZZ?=
 =?iso-8859-1?Q?COLrQrUDS2ehsKAyW9563SGK3iU+WB6xv2KR+JRhY47DY20VTfNKazwgyc?=
 =?iso-8859-1?Q?RH6kXSnmw0hSCTLif+O9VVrLPfgUMwUbNLmM2HaxGNfiSM9QP3aCxcemUz?=
 =?iso-8859-1?Q?QQ7tTBnojYFJUUN+EhwotHA7VoLlbErZHyZtViapg0XiEHlG6PnGIuwHFH?=
 =?iso-8859-1?Q?GHkOyI+41JYDe4ZRA71aFhC4u0zqolVytdmoD8ZNJSoxeFs8Z4tb7WoqD6?=
 =?iso-8859-1?Q?69J+OjkGeErh6VeAnX59c2YkscSbxuGw8xM5blWjJMXDE2BoIvOn3/Wvm+?=
 =?iso-8859-1?Q?1D4V1w5mOOnQkOE+DDqKoR7rTnHI7VcLeKf17Oo0ZrhS03OMTLyFN955jw?=
 =?iso-8859-1?Q?ehlP1vXkq3ZRhcigxEErJoi/02cfP33BHYKOcS0zY/SrwOwGBry2oVW2HP?=
 =?iso-8859-1?Q?7EseTcJxXUESBcef27OcFHBMbnBgiLSnqIafdN8XKPtiszc+BagPOocEKp?=
 =?iso-8859-1?Q?zKZ1bFkfu6OIpSNKMpMpL57ij/33BHFZBHwGAXfonFVXJD539A04LhgoO3?=
 =?iso-8859-1?Q?A/XLNuB7Xa8ev8nK4LlsnvOFnmyl5NP7RWB/06ErD/HViYBE58yRsCPseA?=
 =?iso-8859-1?Q?3rzDHakzLvAL3a0el5DLzjqRlhGkkHIx+RhK+HzSynCMiFiyonQSR0wZJ6?=
 =?iso-8859-1?Q?I224Q+ZQHdPpllbA/FhKsFHF6qEKNaeSo6TSEMiov5BtN01nQbyTIy7Oho?=
 =?iso-8859-1?Q?WawwsAY+/jPVkt1DDVF1YMdcVQMyNS9uJL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4088b1-2742-4682-c072-08dc8a3e02dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 17:43:32.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Htho7kb8aY7AKYU+o6tijN7Dn/HhVsBLxOmTgCiYipdNX7c65koOPt80OduruxWmdPSw0aElUD42r7xyb1zahw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3677

(resending in plain text)

> -----Original Message-----
> From: Michael Kelley <mailto:mhklinux@outlook.com>
> Sent: Tuesday, June 11, 2024 12:35 PM
> To: Haiyang Zhang <mailto:haiyangz@microsoft.com>; mailto:linux-hyperv@vg=
er.kernel.org;
> mailto:netdev@vger.kernel.org
> Cc: Dexuan Cui <mailto:decui@microsoft.com>; mailto:stephen@networkplumbe=
r.org; KY
> Srinivasan <mailto:kys@microsoft.com>; Paul Rosswurm <mailto:paulros@micr=
osoft.com>;
> mailto:olaf@aepfle.de; vkuznets <mailto:vkuznets@redhat.com>; mailto:dave=
m@davemloft.net;
> mailto:wei.liu@kernel.org; mailto:edumazet@google.com; mailto:kuba@kernel=
.org;
> mailto:pabeni@redhat.com; mailto:leon@kernel.org; Long Li <mailto:longli@=
microsoft.com>;
> mailto:ssengar@linux.microsoft.com; mailto:linux-rdma@vger.kernel.org;
> mailto:daniel@iogearbox.net; mailto:john.fastabend@gmail.com; mailto:bpf@=
vger.kernel.org;
> mailto:ast@kernel.org; mailto:hawk@kernel.org; mailto:tglx@linutronix.de;
> mailto:shradhagupta@linux.microsoft.com; mailto:linux-kernel@vger.kernel.=
org
> Subject: RE: [PATCH net-next] net: mana: Add support for variable page
> sizes of ARM64
>=20
> From: LKML haiyangz <mailto:lkmlhyz@microsoft.com> On Behalf Of Haiyang Z=
hang
> Sent: Monday, June 10, 2024 2:23 PM
> >
> > As defined by the MANA Hardware spec, the queue size for DMA is 4KB
> > minimal, and power of 2.
>=20
> You say the hardware requires 4K "minimal". But the definitions in this
> patch hardcode to 4K, as if that's the only choice. Is the hardcoding to
> 4K a design decision made to simplify the MANA driver?

The HWC q size has to be exactly 4k, which is by HW design.=20
Other "regular" queues can be 2^n >=3D 4k.

>=20
> > To support variable page sizes (4KB, 16KB, 64KB) of ARM64, define
>=20
> A minor nit, but "variable" page size doesn't seem like quite the right
> description -- both here and in the Subject line.=A0 On ARM64, the page
> size
> is a choice among a few fixed options.=A0 Perhaps call it support for "pa=
ge
> sizes
> other than 4K"?

"page sizes other than 4K" sounds good.

>=20
> > the minimal queue size as a macro separate from the PAGE_SIZE, which
> > we always assumed it to be 4KB before supporting ARM64.
> > Also, update the relevant code related to size alignment, DMA region
> > calculations, etc.
> >
> > Signed-off-by: Haiyang Zhang <mailto:haiyangz@microsoft.com>
> > ---
> >=A0 drivers/net/ethernet/microsoft/Kconfig=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +=
-
> >=A0 .../net/ethernet/microsoft/mana/gdma_main.c=A0=A0 |=A0 8 +++----
> >=A0 .../net/ethernet/microsoft/mana/hw_channel.c=A0 | 22 +++++++++------=
----
> >=A0 drivers/net/ethernet/microsoft/mana/mana_en.c |=A0 8 +++----
> >=A0 .../net/ethernet/microsoft/mana/shm_channel.c |=A0 9 ++++----
> >=A0 include/net/mana/gdma.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 7 +++++-
> >=A0 include/net/mana/mana.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 3 ++-
> >=A0 7 files changed, 33 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/Kconfig
> > b/drivers/net/ethernet/microsoft/Kconfig
> > index 286f0d5697a1..901fbffbf718 100644
> > --- a/drivers/net/ethernet/microsoft/Kconfig
> > +++ b/drivers/net/ethernet/microsoft/Kconfig
> > @@ -18,7 +18,7 @@ if NET_VENDOR_MICROSOFT
> >=A0 config MICROSOFT_MANA
> >=A0 tristate "Microsoft Azure Network Adapter (MANA) support"
> >=A0 depends on PCI_MSI
> > - depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
> > + depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
> >=A0 depends on PCI_HYPERV
> >=A0 select AUXILIARY_BUS
> >=A0 select PAGE_POOL
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 1332db9a08eb..c9df942d0d02 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc,
> > unsigned int length,
> >=A0 dma_addr_t dma_handle;
> >=A0 void *buf;
> >
> > - if (length < PAGE_SIZE || !is_power_of_2(length))
> > + if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
> >=A0 =A0=A0=A0=A0=A0=A0 return -EINVAL;
> >
> >=A0 gmi->dev =3D gc->dev;
> > @@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region,
> > NET_MANA);
> >=A0 static int mana_gd_create_dma_region(struct gdma_dev *gd,
> >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0struct gdma_mem_info *gmi)
> >=A0 {
> > - unsigned int num_page =3D gmi->length / PAGE_SIZE;
> > + unsigned int num_page =3D gmi->length / MANA_MIN_QSIZE;
>=20
> This calculation seems a bit weird when using MANA_MIN_QSIZE. The
> number of pages, and the construction of the page_addr_list array
> a few lines later, seem unrelated to the concept of a minimum queue
> size. Is the right concept really a "mapping chunk", and num_page
> would conceptually be "num_chunks", or something like that?=A0 Then
> a queue must be at least one chunk in size, but that's derived from the
> chunk size, and is not the core concept.

I think calling it "num_chunks" is fine.=20
May I use "num_chunks" in next version?

>
> Another approach might be to just call it "MANA_PAGE_SIZE", like
> has been done with HV_HYP_PAGE_SIZE.=A0 HV_HYP_PAGE_SIZE exists to
> handle exactly the same issue of the guest PAGE_SIZE potentially
> being different from the fixed 4K size that must be used in host-guest
> communication on Hyper-V.=A0 Same thing here with MANA.

I actually called it "MANA_PAGE_SIZE" in my previous internal patch.
But Paul from Hostnet team opposed using that name, because
4kB is the min q size. MANA doesn't have "page" at HW level.


> >=A0 struct gdma_create_dma_region_req *req =3D NULL;
> >=A0 struct gdma_create_dma_region_resp resp =3D {};
> >=A0 struct gdma_context *gc =3D gd->gdma_context;
> > @@ -727,7 +727,7 @@ static int mana_gd_create_dma_region(struct
> gdma_dev *gd,
> >=A0 int err;
> >=A0 int i;
> >
> > - if (length < PAGE_SIZE || !is_power_of_2(length))
> > + if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
> >=A0 =A0=A0=A0=A0=A0=A0 return -EINVAL;
> >
> >=A0 if (offset_in_page(gmi->virt_addr) !=3D 0)
> > @@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct
> gdma_dev *gd,
> >=A0 req->page_addr_list_len =3D num_page;
> >
> >=A0 for (i =3D 0; i < num_page; i++)
> > -=A0=A0=A0=A0=A0=A0 req->page_addr_list[i] =3D gmi->dma_handle +=A0 i *=
 PAGE_SIZE;
> > +=A0=A0=A0=A0=A0=A0 req->page_addr_list[i] =3D gmi->dma_handle +=A0 i *
> MANA_MIN_QSIZE;
> >
> >=A0 err =3D mana_gd_send_request(gc, req_msg_size, req, sizeof(resp),
> &resp);
> >=A0 if (err)
> > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > index bbc4f9e16c98..038dc31e09cd 100644
> > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > @@ -362,12 +362,12 @@ static int mana_hwc_create_cq(struct
> hw_channel_context
> > *hwc, u16 q_depth,
> >=A0 int err;
> >
> >=A0 eq_size =3D roundup_pow_of_two(GDMA_EQE_SIZE * q_depth);
> > - if (eq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> > -=A0=A0=A0=A0=A0=A0 eq_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> > + if (eq_size < MANA_MIN_QSIZE)
> > +=A0=A0=A0=A0=A0=A0 eq_size =3D MANA_MIN_QSIZE;
> >
> >=A0 cq_size =3D roundup_pow_of_two(GDMA_CQE_SIZE * q_depth);
> > - if (cq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> > -=A0=A0=A0=A0=A0=A0 cq_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> > + if (cq_size < MANA_MIN_QSIZE)
> > +=A0=A0=A0=A0=A0=A0 cq_size =3D MANA_MIN_QSIZE;
> >
> >=A0 hwc_cq =3D kzalloc(sizeof(*hwc_cq), GFP_KERNEL);
> >=A0 if (!hwc_cq)
> > @@ -429,7 +429,7 @@ static int mana_hwc_alloc_dma_buf(struct
> > hw_channel_context *hwc, u16 q_depth,
> >
> >=A0 dma_buf->num_reqs =3D q_depth;
> >
> > - buf_size =3D PAGE_ALIGN(q_depth * max_msg_size);
> > + buf_size =3D MANA_MIN_QALIGN(q_depth * max_msg_size);
> >
> >=A0 gmi =3D &dma_buf->mem_info;
> >=A0 err =3D mana_gd_alloc_memory(gc, buf_size, gmi);
> > @@ -497,8 +497,8 @@ static int mana_hwc_create_wq(struct
> hw_channel_context
> > *hwc,
> >=A0 else
> >=A0 =A0=A0=A0=A0=A0=A0 queue_size =3D roundup_pow_of_two(GDMA_MAX_SQE_SI=
ZE *
> > q_depth);
> >
> > - if (queue_size < MINIMUM_SUPPORTED_PAGE_SIZE)
> > -=A0=A0=A0=A0=A0=A0 queue_size =3D MINIMUM_SUPPORTED_PAGE_SIZE;
> > + if (queue_size < MANA_MIN_QSIZE)
> > +=A0=A0=A0=A0=A0=A0 queue_size =3D MANA_MIN_QSIZE;
> >
> >=A0 hwc_wq =3D kzalloc(sizeof(*hwc_wq), GFP_KERNEL);
> >=A0 if (!hwc_wq)
> > @@ -628,10 +628,10 @@ static int mana_hwc_establish_channel(struct
> > gdma_context *gc, u16 *q_depth,
> >=A0 init_completion(&hwc->hwc_init_eqe_comp);
> >
> >=A0 err =3D mana_smc_setup_hwc(&gc->shm_channel, false,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 eq->mem_info.dm=
a_handle,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cq->mem_info.dm=
a_handle,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rq->mem_info.dm=
a_handle,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sq->mem_info.dm=
a_handle,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(eq=
->mem_info.virt_addr),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(cq=
->mem_info.virt_addr),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(rq=
->mem_info.virt_addr),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virt_to_phys(sq=
->mem_info.virt_addr),
>=20
> This change seems unrelated to handling guest PAGE_SIZE values
> other than 4K.=A0 Does it belong in a separate patch?=A0 Or maybe it just
> needs an explanation in the commit message of this patch?

I know dma_handle is usually just the phys adr. But this is not always=20
True if IOMMU is used...=20
I have no problem to put it to a separate patch if desired.

>=20
> >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0eq->eq.msi=
x_index);
> >=A0 if (err)
> >=A0 =A0=A0=A0=A0=A0=A0 return err;
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index d087cf954f75..6a891dbce686 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -1889,10 +1889,10 @@ static int mana_create_txq(struct
> mana_port_context
> > *apc,
> >=A0 =A0*=A0 to prevent overflow.
> >=A0 =A0*/
> >=A0 txq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * 32;
> > - BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
> > + BUILD_BUG_ON(!MANA_MIN_QALIGNED(txq_size));
> >
> >=A0 cq_size =3D MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
> > - cq_size =3D PAGE_ALIGN(cq_size);
> > + cq_size =3D MANA_MIN_QALIGN(cq_size);
> >
> >=A0 gc =3D gd->gdma_context;
> >
> > @@ -2189,8 +2189,8 @@ static struct mana_rxq *mana_create_rxq(struct
> > mana_port_context *apc,
> >=A0 if (err)
> >=A0 =A0=A0=A0=A0=A0=A0 goto out;
> >
> > - rq_size =3D PAGE_ALIGN(rq_size);
> > - cq_size =3D PAGE_ALIGN(cq_size);
> > + rq_size =3D MANA_MIN_QALIGN(rq_size);
> > + cq_size =3D MANA_MIN_QALIGN(cq_size);
> >
> >=A0 /* Create RQ */
> >=A0 memset(&spec, 0, sizeof(spec));
> > diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > b/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > index 5553af9c8085..9a54a163d8d1 100644
> > --- a/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/shm_channel.c
> > @@ -6,6 +6,7 @@
> >=A0 #include <linux/io.h>
> >=A0 #include <linux/mm.h>
> >
> > +#include <net/mana/gdma.h>
> >=A0 #include <net/mana/shm_channel.h>
> >
> >=A0 #define PAGE_FRAME_L48_WIDTH_BYTES 6
> > @@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> > reset_vf, u64 eq_addr,
> >
> >=A0 /* EQ addr: low 48 bits of frame address */
> >=A0 shmem =3D (u64 *)ptr;
> > - frame_addr =3D PHYS_PFN(eq_addr);
> > + frame_addr =3D MANA_PFN(eq_addr);
> >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
>=20
> In mana_smc_setup_hwc() a few lines above this change, code using
> PAGE_ALIGNED() is unchanged.=A0 Is it correct that the eq/cq/rq/sq
> addresses
> must be aligned to 64K if PAGE_SIZE is 64K?

Since we still using PHYS_PFN on them, if not aligned to PAGE_SIZE,=20
the lower bits may be lost. (You said the same below.)

>=20
> Related, I wonder about how MANA_PFN() is defined. If PAGE_SIZE is 64K,
> MANA_PFN() will first right-shift 16, then left shift 4. The net is
> right-shift 12,
> corresponding to the 4K chunks that MANA expects. But that approach
> guarantees
> that the rightmost 4 bits of the MANA PFN will always be zero. That's
> consistent
> with requiring the addresses to be PAGE_ALIGNED() to 64K, but I'm unclear
> whether
> that is really the requirement. You might compare with the definition of
> HVPFN_DOWN(), which has a similar goal for Linux guests communicating
> with
> Hyper-V.

@Paul Rosswurm You said MANA HW has "no page concept". So the "frame_addr"
In the mana_smc_setup_hwc() is NOT related to physical page number, correct=
?
Can we just use phys_adr >> 12 like below?

#define MANA_MIN_QSHIFT 12
#define MANA_PFN(a) ((a) >> MANA_MIN_QSHIFT)

=A0=A0=A0=A0=A0 /* EQ addr: low 48 bits of frame address */
=A0=A0=A0=A0 shmem =3D (u64 *)ptr;
-=A0=A0=A0=A0 frame_addr =3D PHYS_PFN(eq_addr);
+=A0=A0=A0=A0 frame_addr =3D MANA_PFN(eq_addr);

>=20
> > @@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> > reset_vf, u64 eq_addr,
> >
> >=A0 /* CQ addr: low 48 bits of frame address */
> >=A0 shmem =3D (u64 *)ptr;
> > - frame_addr =3D PHYS_PFN(cq_addr);
> > + frame_addr =3D MANA_PFN(cq_addr);
> >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> > @@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> > reset_vf, u64 eq_addr,
> >
> >=A0 /* RQ addr: low 48 bits of frame address */
> >=A0 shmem =3D (u64 *)ptr;
> > - frame_addr =3D PHYS_PFN(rq_addr);
> > + frame_addr =3D MANA_PFN(rq_addr);
> >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> > @@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool
> > reset_vf, u64 eq_addr,
> >
> >=A0 /* SQ addr: low 48 bits of frame address */
> >=A0 shmem =3D (u64 *)ptr;
> > - frame_addr =3D PHYS_PFN(sq_addr);
> > + frame_addr =3D MANA_PFN(sq_addr);
> >=A0 *shmem =3D frame_addr & PAGE_FRAME_L48_MASK;
> >=A0 all_addr_h4bits |=3D (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
> >=A0 =A0=A0=A0=A0=A0=A0 (frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
> > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> > index 27684135bb4d..b392559c33e9 100644
> > --- a/include/net/mana/gdma.h
> > +++ b/include/net/mana/gdma.h
> > @@ -224,7 +224,12 @@ struct gdma_dev {
> >=A0 struct auxiliary_device *adev;
> >=A0 };
> >
> > -#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
> > +/* These are defined by HW */
> > +#define MANA_MIN_QSHIFT 12
> > +#define MANA_MIN_QSIZE (1 << MANA_MIN_QSHIFT)
> > +#define MANA_MIN_QALIGN(x) ALIGN((x), MANA_MIN_QSIZE)
> > +#define MANA_MIN_QALIGNED(addr) IS_ALIGNED((unsigned long)(addr),
> MANA_MIN_QSIZE)
> > +#define MANA_PFN(a) (PHYS_PFN(a) << (PAGE_SHIFT - MANA_MIN_QSHIFT))
>=20
> See comments above about how this is defined.

Replied above.
Thank you for all the detailed comments!

- Haiyang


