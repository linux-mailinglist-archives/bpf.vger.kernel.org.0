Return-Path: <bpf+bounces-56315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D830BA9540C
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5528A7A72C1
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15371E32DD;
	Mon, 21 Apr 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="FIQ9uzxH"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010033.outbound.protection.outlook.com [52.101.51.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346701DF99C;
	Mon, 21 Apr 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253004; cv=fail; b=iXr0YC5o3U/8LdPenVxPfvhaCNDpR4jy6tzMSAH72X2F4FFqSGTLw4biZVBuin3rB8NPEFLIL2+AbiBy5rl1eulxNqte/3gYIj4CggNakdPx/BkqxQPdOVy4QgXfp3XMyz/yycyCoPbVEyTB+nsMGnF0+yt1F37kS5LaGgHGFTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253004; c=relaxed/simple;
	bh=Bpl5S94YpG4z+FI+i9dHosHe/CJGlzhCrOJl05R0MdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgQTjm/f69m7Lbq81/fUpLW6J48HfQqeVfVQUBbkEpOHdhms+AGAHP/COuMXREzIDiq/RVAjkbskL+zWXy5QoVEvEwH4dyQ/fpiVmplVTiH0S3qEQWE/8TfeCcOMeXD1pjSb4+Axz5GWOjiXxdLPDcGFy6/J0uRyWhYr/qQwiJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=FIQ9uzxH; arc=fail smtp.client-ip=52.101.51.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L957q7+X4Oki1oJeIrHLjgJtOmmLpYRVhBdak1YSHybDo2RAg8oL8PRx1IVt8nBn5nZ2m00sNTSH/cpwsonMt9iJTiTUNA8s2dhYt2gnItmpJp0zwwC59Vaz0SGkfbCXzGYkglri1dxER5z9I2L70acqC2TFX+PoEy6/LibAH4fkSs12cqo/pb6tYRESfomWF9heB9lbviVK1P6ljzPnijzucTZBY1p8xkIneugBSAfkq9jYqsOApAqQXtnzaAvNsr0ccH/634Jpc+8r7p3cHtlOZzvKAa9+BdNGYE7EirsxvdZ/UUzNyriMbo7cscLRswL18zQJVL3loht2ziCAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoZCfTOqo4qugIEbhdnR5CVhY68PAOn9pP0tvvnUZmU=;
 b=nG+bFmizTZ89Tb7hMcF7wsOi60TQ4YtKNWXsSML1Oxd1MJba0d+N6TgQYJcRISRy+1oghUQ8AM0gjyMN5+RlphDQCszrK6edAUMZNyMyXTQ785mO1jrUc8HTSB6EX1f8RiB8uuaL0lVuSoSIYlhLmmJj0EpeH7KY7aNdK5CPLvzlpS3A+qP9X0Vx8sunITRXIyT834jj3R1VRcA0T/J8Dc/YEWblS2oIqQjBKI2Iij0xkRWjIXlgy7v/Pev34UE7zkvskwM5y2Ch455qr9ikG3YUKVziaOqJn144VSGaSS0G97FnBumSy7bCF8MwFJzD/tEgS8RNDwfwRLpZO0th1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoZCfTOqo4qugIEbhdnR5CVhY68PAOn9pP0tvvnUZmU=;
 b=FIQ9uzxHoTtQg0SZfOuCOETAAJV3LOHaptNAdgta1Vg3Nji7xt6kEE1cKNqPOTpDPa18fMlBAKpp8aBJBAT/DKYjbWX8B8xGiEuY8fNAujHuAEynngP9owkSkE2HygQEJoabGivD+NfROhGmoiFirxGODNdSvXxwpjiTzXcBnSS8mkUu01ETmdZXjehCVdp2KJBGzDsr+kVGzE81Fl1ZM3N3YXhCH1IHVUtoWfHmMpwe8or+7NTbHjfWRKzvKtRQwVOGNMYWetKF9mUOBHOoY/0zHcDRa8sKm7FcrHlVu4Qj8Nkp1SAjSUkIQlxla+d3joaU8UBjsokg/T0N5WaUcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by DM4PR03MB6109.namprd03.prod.outlook.com (2603:10b6:5:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 16:29:58 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:29:58 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH net-next v4 1/2] net: stmmac: Refactor VLAN implementation
Date: Tue, 22 Apr 2025 00:29:29 +0800
Message-Id: <20250421162930.10237-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250421162930.10237-1-boon.khai.ng@altera.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|DM4PR03MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8f5f9d-6e6e-46e8-6248-08dd80f1c1a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?knhiFLNcg+k5gewsItTc95y/NRllzZg6FjTrGy8OuXj0RJbaNGAlHA7Tu5B4?=
 =?us-ascii?Q?g+sz+A/olJSFvUPzHy19f+YUcz07g8slF51WkrMyHc5+VFH0mbarZsrCH2Az?=
 =?us-ascii?Q?8EOS06oUQ0Am8211DAGG5rppPp8xW0xrhwi1XMS2MrjEqcO11v7ofH9dJw8T?=
 =?us-ascii?Q?0/cST6xREcK9CTLc/x0+iOT6LqW90lQJXrnTwqvsM60OKPTB+ndiyeBgOKAG?=
 =?us-ascii?Q?xWxcGO/vtTKEyNbhpKUF8XIt/KAAnQbgZBQ88s7z/UY3sbxgkMoPqRryl7UN?=
 =?us-ascii?Q?5bCvYvX7SyjPWtJV0uOCAjsQ11mxsdmfluXht8GynghvTpiEBenjCM+IO/NG?=
 =?us-ascii?Q?YRE6OR4DVnVJ8EygHybz/gKunHKLUgkkG20WVIO51AZkkMaNmN+JLPJuOyUs?=
 =?us-ascii?Q?mxbRx1pHd8+I4GHUfycFKX8ZxJ9pLDp2//iIfRdQD6qMTAOaD1KgXPeFUc7t?=
 =?us-ascii?Q?uZeMf37MvWNsLfYNikIH/DscVOcuT7mTUNhEYbfxq533QuhMCwyO2SzXuzTH?=
 =?us-ascii?Q?dpUQCjJrghSN9PqEJWxQXSagwjOcPq5waZY2FJhJ4nSb211HmQxVZ6du5iph?=
 =?us-ascii?Q?XL0wg2CM2khfy7CT8PRqJOyQa86jzQIsLtKeS7ZIa8eOn7YbAxSyp27ICGSt?=
 =?us-ascii?Q?CCgh03vDMsJXHSlZGOUXnIa1SMTYGVrQjKHCltLDt231FvqJpw6DZGNxccQe?=
 =?us-ascii?Q?Z2SwphUX1z91B0sfx5D7HFB+ibUGwgkIJXcIwMnAyyEnfqi+1O7JvPAsarK2?=
 =?us-ascii?Q?0O5g6w352IdyrvzCq3JZ2nGZACuApugA3+6G92freEq69e3D4MxMmd5ZAS98?=
 =?us-ascii?Q?AqyQzYAoO+QzLxn6eBEA+xaIaSvX+pwuxqEBa6bY13MZ3rHM4xk8Y9Occbqy?=
 =?us-ascii?Q?C7mVPfURz+T0J0dZTo0S4VX/VbS1mB713VYPe6LkLCTgSLLP8umUMLN2LgpN?=
 =?us-ascii?Q?YCQOab1eFQiVgZm/s4gel5dJqBQvJmHfnVBexyCF/vMu45j/SgRyozCahOlY?=
 =?us-ascii?Q?SPuwv5SttEMsxaCbGgjrItyZe78nTfHeLiVSu4qthcRRSk7EzHuk09OhRgQ6?=
 =?us-ascii?Q?RFi8ltexJTsnTxSxVjV2GKkVQ/TwLinxV56dqNpsJXDSG884s9QmFBIwO3yj?=
 =?us-ascii?Q?W1w7EX1WF9AUDL7rjYbwOKCfmqYkEdfj/s3+GM0RvlWm3Ul3dqKmUGT1aXdv?=
 =?us-ascii?Q?yfmJFumk/JDE5XMhgVYfJje28OitJq7xdPxQWZLWZW1C2JWLTnPY2Xvjo73X?=
 =?us-ascii?Q?lcbNSGa/TS/MOudxi+fYbavbY0Bu2jEOANOZS32+toOzV1XqtYjhWtI46egA?=
 =?us-ascii?Q?G+ztYRdS1JpvCpu1yjtWuBrF5SeX3R+HrKKSf84XSBPHVPiGW8t0T9sem+/9?=
 =?us-ascii?Q?aIW2Vy5J5GMJ5QgzpxAjUAn2USr+v5PwzAOPuUuplxd71jL5COc7iRwCtAV1?=
 =?us-ascii?Q?anzV572KFY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61pS++GcXORZ0L36kSco5SihSLeKgvL7KksAFTF1+i5PAObp0u/goy/xgaCw?=
 =?us-ascii?Q?jJWz0euEhvIe9SUSYYCLsrCby7jrPKMuibUBnXXh5v4EpY3diOZ91JRD5YxR?=
 =?us-ascii?Q?PoFragdADb36bWI0Xdnw96sThMvXI+cM3zBUceOIdAeetEMhWY0aL54OsxAD?=
 =?us-ascii?Q?QeL+bi9t3KOBhLrpAYgGbQDUf1x6KJ9Y+XPlzJdAOUyo9WJO4XMUZ3rw5jkD?=
 =?us-ascii?Q?jIF0fwtevCC+FflfAGtY/XKcIC+qKJBbwbJBk/yM+rWMg41rFfA4yPiMPQq9?=
 =?us-ascii?Q?LZHHANLprQx58LeGVcrtLbbK8bAkEPF3BlxDL3Zmp+PoarwaIWqm6VEbOhnu?=
 =?us-ascii?Q?JZgN5Bv0e1p8RWusI+ImOUiCT6q4XTtHJcn+sdm5V0KjCyw64h+H1hM5MTR6?=
 =?us-ascii?Q?VHWdmwQ3AfMil5YyVkDI8jPtn49NIp4ctp4G19vAX0Gx3WZIrxKkjA4FDKT6?=
 =?us-ascii?Q?Ux36NsAHyFnPpXhJ+6VYg/mrY/mDBBzbZkWnTjOVA/4l2ZhtCCILRizWLzHX?=
 =?us-ascii?Q?GoYQBvNRhXug7CFV+YkaxF3WSacy5mI4GSxeHAiXGV/LSkBppHwk4JTgGYXZ?=
 =?us-ascii?Q?IIFon/Eyn4NE3SbtTFSBCL/oCGgBDnJwEW8QEKaRUdqueLiyZqTu0nxba8nO?=
 =?us-ascii?Q?7u6Wgv+coBX9HO5rDOHRvuU4pgEGa4iQeNlJGmQ3WVHNA9DNYm51zaY54heQ?=
 =?us-ascii?Q?Dq6brojBYb4PjO3juzxKfjdE5PZw8KtZ+mFewWcq7mvw97IOufI8edQol9eG?=
 =?us-ascii?Q?PpkZS02iKfuuCKh36bhjY8ywvypjK4VHFG/hkZ7Ij6+rM10ysHMdi5J0I3DQ?=
 =?us-ascii?Q?81rGsnN9r15cmVUpxVHMZZBD82sPisGWtUp2hNOJJPMbzWazSow6ZjhN03qJ?=
 =?us-ascii?Q?ycyQt69lD8wd3AWzARX2BYtrGtFo64JJaP04ySPC4x8sVjaCqquosc6DGwSU?=
 =?us-ascii?Q?T+6BuYCXaTr/vn0cd6YnHzsvJQQizsYhTkRluoEEQkbz/KkWCVAmb3H9x4C8?=
 =?us-ascii?Q?JXtvoYj0p1zzv6R6EMV7VJrHxaPsIZKh611RApBV4iQgC9nXZcvfrR3y2ehc?=
 =?us-ascii?Q?lh6fPPQ7Sd99IPqBj5lH6RHYMtvOE20Gs+LzyFQbfx/iHVP4p/+esO8h5wto?=
 =?us-ascii?Q?qWYJvdoBVx2UvRS1PNYMTT8tuFywipxQHXTE3sk7I06DvQLDXz6xGsyJefyn?=
 =?us-ascii?Q?wyoDN5HPpOsB1o4Dw+a1p3SQdt6RubRJYhPq5tZIY3WObb57b0t5n8oCCdOd?=
 =?us-ascii?Q?oonUu7D2TAI7oPlDYKxRyjIGf24y6wsk5tYIC2oKQhf5hPYTgb5MXMOh5N39?=
 =?us-ascii?Q?cErw3rNDH9npUVoDdrE7SWX53bdsWZ2Q+Mgce6Jds7gSh/z2nAOCIkML6vqG?=
 =?us-ascii?Q?Di7P8XSHCezzfR3h0P83TzsfQ+xPtj+WNhtYGV2nJJiWAMti5/1LkMEA+ZKa?=
 =?us-ascii?Q?DyCsfsdbO+R5Wb8BIvv3DDGbk7MZsbnhd/nXSa6ZQKy5Zj0TAoJHHYiyq9gM?=
 =?us-ascii?Q?UIRwxA4DEcZ65lTWE7bOzw68kpVkFClqKJi/umwPtd0UZSw8zJrvFRlF3xlu?=
 =?us-ascii?Q?oGBuKw8H1BJKfGMHJuQ3DdXoPq3Wk6dsR7lvXoH0?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8f5f9d-6e6e-46e8-6248-08dd80f1c1a9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 16:29:58.8021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+ORKsWRN9hlDxxo4raWa5AfoVGfYSzyOa6hVMkHwl/LdSqg00Pd3y2tw6jScT9IsRJSeiirgLaNJuFgTA1+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6109

Refactor VLAN implementation by moving common code for DWMAC4 and
DWXGMAC IPs into a separate VLAN module. VLAN implementation for
DWMAC4 and DWXGMAC differs only for CSR base address, the descriptor
for the VLAN ID and VLAN VALID bit field.

The descriptor format for VLAN is not moved to the common code due
to hardware-specific differences between DWMAC4 and DWXGMAC.

For the DWMAC4 IP, the Receive Normal Descriptor 0 (RDES0) is
formatted as follows:
    31                                                0
      ------------------------ -----------------------
RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
      ------------------------ -----------------------

For the DWXGMAC IP, the RDES0 format varies based on the
Tunneled Frame bit (TNP):

a) For Non-Tunneled Frame (TNP=0)

    31                                                0
      ------------------------ -----------------------
RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
      ------------------------ -----------------------

b) For Tunneled Frame (TNP=1)

     31                   8 7                3 2      0
      --------------------- ------------------ -------
RDES0| VNID/VSID           | Reserved         | OL2L3 |
      --------------------- ------------------ ------

The logic for handling tunneled frames is not yet implemented
in the dwxgmac2_wrback_get_rx_vlan_tci() function. Therefore,
it is prudent to maintain separate functions within their
respective descriptor driver files
(dwxgmac2_descs.c and dwmac4_descs.c).

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  40 ---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 295 +-----------------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  13 -
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  87 ------
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  61 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 294 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  63 ++++
 10 files changed, 401 insertions(+), 463 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 594883fb4164..433b65af0c9d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o stmmac_vlan.o\
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 412b07e77945..ea5da5793362 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -602,6 +602,7 @@ struct mac_device_info {
 	const struct stmmac_tc_ops *tc;
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
+	const struct stmmac_vlan_ops *vlan;
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 5f387ec27c8c..f4694fd576f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -17,11 +17,7 @@
 #define GMAC_EXT_CONFIG			0x00000004
 #define GMAC_PACKET_FILTER		0x00000008
 #define GMAC_HASH_TAB(x)		(0x10 + (x) * 4)
-#define GMAC_VLAN_TAG			0x00000050
-#define GMAC_VLAN_TAG_DATA		0x00000054
-#define GMAC_VLAN_HASH_TABLE		0x00000058
 #define GMAC_RX_FLOW_CTRL		0x00000090
-#define GMAC_VLAN_INCL			0x00000060
 #define GMAC_QX_TX_FLOW_CTRL(x)		(0x70 + x * 4)
 #define GMAC_TXQ_PRTY_MAP0		0x98
 #define GMAC_TXQ_PRTY_MAP1		0x9C
@@ -81,42 +77,6 @@
 
 #define GMAC_MAX_PERFECT_ADDRESSES	128
 
-/* MAC VLAN */
-#define GMAC_VLAN_EDVLP			BIT(26)
-#define GMAC_VLAN_VTHM			BIT(25)
-#define GMAC_VLAN_DOVLTC		BIT(20)
-#define GMAC_VLAN_ESVL			BIT(18)
-#define GMAC_VLAN_ETV			BIT(16)
-#define GMAC_VLAN_VID			GENMASK(15, 0)
-#define GMAC_VLAN_VLTI			BIT(20)
-#define GMAC_VLAN_CSVL			BIT(19)
-#define GMAC_VLAN_VLC			GENMASK(17, 16)
-#define GMAC_VLAN_VLC_SHIFT		16
-#define GMAC_VLAN_VLHT			GENMASK(15, 0)
-
-/* MAC VLAN Tag */
-#define GMAC_VLAN_TAG_VID		GENMASK(15, 0)
-#define GMAC_VLAN_TAG_ETV		BIT(16)
-
-/* MAC VLAN Tag Control */
-#define GMAC_VLAN_TAG_CTRL_OB		BIT(0)
-#define GMAC_VLAN_TAG_CTRL_CT		BIT(1)
-#define GMAC_VLAN_TAG_CTRL_OFS_MASK	GENMASK(6, 2)
-#define GMAC_VLAN_TAG_CTRL_OFS_SHIFT	2
-#define GMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
-#define GMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21
-#define GMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
-
-#define GMAC_VLAN_TAG_STRIP_NONE	(0x0 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_PASS	(0x1 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_FAIL	(0x2 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_ALL		(0x3 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-
-/* MAC VLAN Tag Data/Filter */
-#define GMAC_VLAN_TAG_DATA_VID		GENMASK(15, 0)
-#define GMAC_VLAN_TAG_DATA_VEN		BIT(16)
-#define GMAC_VLAN_TAG_DATA_ETV		BIT(17)
-
 /* MAC RX Queue Enable */
 #define GMAC_RX_QUEUE_CLEAR(queue)	~(GENMASK(1, 0) << ((queue) * 2))
 #define GMAC_RX_AV_QUEUE_ENABLE(queue)	BIT((queue) * 2)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cc4ddf608652..9c2549d4100f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -18,6 +18,7 @@
 #include "stmmac.h"
 #include "stmmac_fpe.h"
 #include "stmmac_pcs.h"
+#include "stmmac_vlan.h"
 #include "dwmac4.h"
 #include "dwmac5.h"
 
@@ -448,165 +449,6 @@ static void dwmac4_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + GMAC4_LPI_TIMER_CTRL);
 }
 
-static void dwmac4_write_single_vlan(struct net_device *dev, u16 vid)
-{
-	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
-	u32 val;
-
-	val = readl(ioaddr + GMAC_VLAN_TAG);
-	val &= ~GMAC_VLAN_TAG_VID;
-	val |= GMAC_VLAN_TAG_ETV | vid;
-
-	writel(val, ioaddr + GMAC_VLAN_TAG);
-}
-
-static int dwmac4_write_vlan_filter(struct net_device *dev,
-				    struct mac_device_info *hw,
-				    u8 index, u32 data)
-{
-	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
-	int ret;
-	u32 val;
-
-	if (index >= hw->num_vlan)
-		return -EINVAL;
-
-	writel(data, ioaddr + GMAC_VLAN_TAG_DATA);
-
-	val = readl(ioaddr + GMAC_VLAN_TAG);
-	val &= ~(GMAC_VLAN_TAG_CTRL_OFS_MASK |
-		GMAC_VLAN_TAG_CTRL_CT |
-		GMAC_VLAN_TAG_CTRL_OB);
-	val |= (index << GMAC_VLAN_TAG_CTRL_OFS_SHIFT) | GMAC_VLAN_TAG_CTRL_OB;
-
-	writel(val, ioaddr + GMAC_VLAN_TAG);
-
-	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
-				 !(val & GMAC_VLAN_TAG_CTRL_OB),
-				 1000, 500000);
-	if (ret) {
-		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
-static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
-				      struct mac_device_info *hw,
-				      __be16 proto, u16 vid)
-{
-	int index = -1;
-	u32 val = 0;
-	int i, ret;
-
-	if (vid > 4095)
-		return -EINVAL;
-
-	/* Single Rx VLAN Filter */
-	if (hw->num_vlan == 1) {
-		/* For single VLAN filter, VID 0 means VLAN promiscuous */
-		if (vid == 0) {
-			netdev_warn(dev, "Adding VLAN ID 0 is not supported\n");
-			return -EPERM;
-		}
-
-		if (hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) {
-			netdev_err(dev, "Only single VLAN ID supported\n");
-			return -EPERM;
-		}
-
-		hw->vlan_filter[0] = vid;
-		dwmac4_write_single_vlan(dev, vid);
-
-		return 0;
-	}
-
-	/* Extended Rx VLAN Filter Enable */
-	val |= GMAC_VLAN_TAG_DATA_ETV | GMAC_VLAN_TAG_DATA_VEN | vid;
-
-	for (i = 0; i < hw->num_vlan; i++) {
-		if (hw->vlan_filter[i] == val)
-			return 0;
-		else if (!(hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN))
-			index = i;
-	}
-
-	if (index == -1) {
-		netdev_err(dev, "MAC_VLAN_Tag_Filter full (size: %0u)\n",
-			   hw->num_vlan);
-		return -EPERM;
-	}
-
-	ret = dwmac4_write_vlan_filter(dev, hw, index, val);
-
-	if (!ret)
-		hw->vlan_filter[index] = val;
-
-	return ret;
-}
-
-static int dwmac4_del_hw_vlan_rx_fltr(struct net_device *dev,
-				      struct mac_device_info *hw,
-				      __be16 proto, u16 vid)
-{
-	int i, ret = 0;
-
-	/* Single Rx VLAN Filter */
-	if (hw->num_vlan == 1) {
-		if ((hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) == vid) {
-			hw->vlan_filter[0] = 0;
-			dwmac4_write_single_vlan(dev, 0);
-		}
-		return 0;
-	}
-
-	/* Extended Rx VLAN Filter Enable */
-	for (i = 0; i < hw->num_vlan; i++) {
-		if ((hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VID) == vid) {
-			ret = dwmac4_write_vlan_filter(dev, hw, i, 0);
-
-			if (!ret)
-				hw->vlan_filter[i] = 0;
-			else
-				return ret;
-		}
-	}
-
-	return ret;
-}
-
-static void dwmac4_restore_hw_vlan_rx_fltr(struct net_device *dev,
-					   struct mac_device_info *hw)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-	u32 hash;
-	u32 val;
-	int i;
-
-	/* Single Rx VLAN Filter */
-	if (hw->num_vlan == 1) {
-		dwmac4_write_single_vlan(dev, hw->vlan_filter[0]);
-		return;
-	}
-
-	/* Extended Rx VLAN Filter Enable */
-	for (i = 0; i < hw->num_vlan; i++) {
-		if (hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN) {
-			val = hw->vlan_filter[i];
-			dwmac4_write_vlan_filter(dev, hw, i, val);
-		}
-	}
-
-	hash = readl(ioaddr + GMAC_VLAN_HASH_TABLE);
-	if (hash & GMAC_VLAN_VLHT) {
-		value = readl(ioaddr + GMAC_VLAN_TAG);
-		value |= GMAC_VLAN_VTHM;
-		writel(value, ioaddr + GMAC_VLAN_TAG);
-	}
-}
-
 static void dwmac4_set_filter(struct mac_device_info *hw,
 			      struct net_device *dev)
 {
@@ -965,45 +807,6 @@ static void dwmac4_set_mac_loopback(void __iomem *ioaddr, bool enable)
 	writel(value, ioaddr + GMAC_CONFIG);
 }
 
-static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				    u16 perfect_match, bool is_double)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	writel(hash, ioaddr + GMAC_VLAN_HASH_TABLE);
-
-	value = readl(ioaddr + GMAC_VLAN_TAG);
-
-	if (hash) {
-		value |= GMAC_VLAN_VTHM | GMAC_VLAN_ETV;
-		if (is_double) {
-			value |= GMAC_VLAN_EDVLP;
-			value |= GMAC_VLAN_ESVL;
-			value |= GMAC_VLAN_DOVLTC;
-		}
-
-		writel(value, ioaddr + GMAC_VLAN_TAG);
-	} else if (perfect_match) {
-		u32 value = GMAC_VLAN_ETV;
-
-		if (is_double) {
-			value |= GMAC_VLAN_EDVLP;
-			value |= GMAC_VLAN_ESVL;
-			value |= GMAC_VLAN_DOVLTC;
-		}
-
-		writel(value | perfect_match, ioaddr + GMAC_VLAN_TAG);
-	} else {
-		value &= ~(GMAC_VLAN_VTHM | GMAC_VLAN_ETV);
-		value &= ~(GMAC_VLAN_EDVLP | GMAC_VLAN_ESVL);
-		value &= ~GMAC_VLAN_DOVLTC;
-		value &= ~GMAC_VLAN_VID;
-
-		writel(value, ioaddr + GMAC_VLAN_TAG);
-	}
-}
-
 static void dwmac4_sarc_configure(void __iomem *ioaddr, int val)
 {
 	u32 value = readl(ioaddr + GMAC_CONFIG);
@@ -1014,19 +817,6 @@ static void dwmac4_sarc_configure(void __iomem *ioaddr, int val)
 	writel(value, ioaddr + GMAC_CONFIG);
 }
 
-static void dwmac4_enable_vlan(struct mac_device_info *hw, u32 type)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	value = readl(ioaddr + GMAC_VLAN_INCL);
-	value |= GMAC_VLAN_VLTI;
-	value |= GMAC_VLAN_CSVL; /* Only use SVLAN */
-	value &= ~GMAC_VLAN_VLC;
-	value |= (type << GMAC_VLAN_VLC_SHIFT) & GMAC_VLAN_VLC;
-	writel(value, ioaddr + GMAC_VLAN_INCL);
-}
-
 static void dwmac4_set_arp_offload(struct mac_device_info *hw, bool en,
 				   u32 addr)
 {
@@ -1143,35 +933,6 @@ static int dwmac4_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 	return 0;
 }
 
-static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
-			      struct dma_desc *rx_desc, struct sk_buff *skb)
-{
-	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
-		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
-
-		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
-	}
-}
-
-static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value = readl(ioaddr + GMAC_VLAN_TAG);
-
-	value &= ~GMAC_VLAN_TAG_CTRL_EVLS_MASK;
-
-	if (hw->hw_vlan_en)
-		/* Always strip VLAN on Receive */
-		value |= GMAC_VLAN_TAG_STRIP_ALL;
-	else
-		/* Do not strip VLAN on Receive */
-		value |= GMAC_VLAN_TAG_STRIP_NONE;
-
-	/* Enable outer VLAN Tag in Rx DMA descriptor */
-	value |= GMAC_VLAN_TAG_CTRL_EVLRXS;
-	writel(value, ioaddr + GMAC_VLAN_TAG);
-}
-
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
@@ -1201,17 +962,10 @@ const struct stmmac_ops dwmac4_ops = {
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
-	.update_vlan_hash = dwmac4_update_vlan_hash,
 	.sarc_configure = dwmac4_sarc_configure,
-	.enable_vlan = dwmac4_enable_vlan,
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
 const struct stmmac_ops dwmac410_ops = {
@@ -1244,18 +998,11 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_filter = dwmac4_set_filter,
 	.flex_pps_config = dwmac5_flex_pps_config,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
-	.update_vlan_hash = dwmac4_update_vlan_hash,
 	.sarc_configure = dwmac4_sarc_configure,
-	.enable_vlan = dwmac4_enable_vlan,
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
 const struct stmmac_ops dwmac510_ops = {
@@ -1292,51 +1039,13 @@ const struct stmmac_ops dwmac510_ops = {
 	.rxp_config = dwmac5_rxp_config,
 	.flex_pps_config = dwmac5_flex_pps_config,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
-	.update_vlan_hash = dwmac4_update_vlan_hash,
 	.sarc_configure = dwmac4_sarc_configure,
-	.enable_vlan = dwmac4_enable_vlan,
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
-static u32 dwmac4_get_num_vlan(void __iomem *ioaddr)
-{
-	u32 val, num_vlan;
-
-	val = readl(ioaddr + GMAC_HW_FEATURE3);
-	switch (val & GMAC_HW_FEAT_NRVF) {
-	case 0:
-		num_vlan = 1;
-		break;
-	case 1:
-		num_vlan = 4;
-		break;
-	case 2:
-		num_vlan = 8;
-		break;
-	case 3:
-		num_vlan = 16;
-		break;
-	case 4:
-		num_vlan = 24;
-		break;
-	case 5:
-		num_vlan = 32;
-		break;
-	default:
-		num_vlan = 1;
-	}
-
-	return num_vlan;
-}
-
 int dwmac4_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
@@ -1368,7 +1077,7 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.reg_mask = GENMASK(20, 16);
 	mac->mii.clk_csr_shift = 8;
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
-	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
+	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index a03f5d771566..5e369a9a2595 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -57,19 +57,6 @@
 #define XGMAC_FILTER_PR			BIT(0)
 #define XGMAC_HASH_TABLE(x)		(0x00000010 + (x) * 4)
 #define XGMAC_MAX_HASH_TABLE		8
-#define XGMAC_VLAN_TAG			0x00000050
-#define XGMAC_VLAN_EDVLP		BIT(26)
-#define XGMAC_VLAN_VTHM			BIT(25)
-#define XGMAC_VLAN_DOVLTC		BIT(20)
-#define XGMAC_VLAN_ESVL			BIT(18)
-#define XGMAC_VLAN_ETV			BIT(16)
-#define XGMAC_VLAN_VID			GENMASK(15, 0)
-#define XGMAC_VLAN_HASH_TABLE		0x00000058
-#define XGMAC_VLAN_INCL			0x00000060
-#define XGMAC_VLAN_VLTI			BIT(20)
-#define XGMAC_VLAN_CSVL			BIT(19)
-#define XGMAC_VLAN_VLC			GENMASK(17, 16)
-#define XGMAC_VLAN_VLC_SHIFT		16
 #define XGMAC_RXQ_CTRL0			0x000000a0
 #define XGMAC_RXQEN(x)			GENMASK((x) * 2 + 1, (x) * 2)
 #define XGMAC_RXQEN_SHIFT(x)		((x) * 2)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a6d395c6bacd..d9f41c047e5e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -614,76 +614,6 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
 	return 0;
 }
 
-static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      u16 perfect_match, bool is_double)
-{
-	void __iomem *ioaddr = hw->pcsr;
-
-	writel(hash, ioaddr + XGMAC_VLAN_HASH_TABLE);
-
-	if (hash) {
-		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-
-		value |= XGMAC_FILTER_VTFE;
-
-		writel(value, ioaddr + XGMAC_PACKET_FILTER);
-
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
-
-		value |= XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV;
-		if (is_double) {
-			value |= XGMAC_VLAN_EDVLP;
-			value |= XGMAC_VLAN_ESVL;
-			value |= XGMAC_VLAN_DOVLTC;
-		} else {
-			value &= ~XGMAC_VLAN_EDVLP;
-			value &= ~XGMAC_VLAN_ESVL;
-			value &= ~XGMAC_VLAN_DOVLTC;
-		}
-
-		value &= ~XGMAC_VLAN_VID;
-		writel(value, ioaddr + XGMAC_VLAN_TAG);
-	} else if (perfect_match) {
-		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-
-		value |= XGMAC_FILTER_VTFE;
-
-		writel(value, ioaddr + XGMAC_PACKET_FILTER);
-
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
-
-		value &= ~XGMAC_VLAN_VTHM;
-		value |= XGMAC_VLAN_ETV;
-		if (is_double) {
-			value |= XGMAC_VLAN_EDVLP;
-			value |= XGMAC_VLAN_ESVL;
-			value |= XGMAC_VLAN_DOVLTC;
-		} else {
-			value &= ~XGMAC_VLAN_EDVLP;
-			value &= ~XGMAC_VLAN_ESVL;
-			value &= ~XGMAC_VLAN_DOVLTC;
-		}
-
-		value &= ~XGMAC_VLAN_VID;
-		writel(value | perfect_match, ioaddr + XGMAC_VLAN_TAG);
-	} else {
-		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-
-		value &= ~XGMAC_FILTER_VTFE;
-
-		writel(value, ioaddr + XGMAC_PACKET_FILTER);
-
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
-
-		value &= ~(XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV);
-		value &= ~(XGMAC_VLAN_EDVLP | XGMAC_VLAN_ESVL);
-		value &= ~XGMAC_VLAN_DOVLTC;
-		value &= ~XGMAC_VLAN_VID;
-
-		writel(value, ioaddr + XGMAC_VLAN_TAG);
-	}
-}
-
 struct dwxgmac3_error_desc {
 	bool valid;
 	const char *desc;
@@ -1300,19 +1230,6 @@ static void dwxgmac2_sarc_configure(void __iomem *ioaddr, int val)
 	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
-static void dwxgmac2_enable_vlan(struct mac_device_info *hw, u32 type)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_VLAN_INCL);
-	value |= XGMAC_VLAN_VLTI;
-	value |= XGMAC_VLAN_CSVL; /* Only use SVLAN */
-	value &= ~XGMAC_VLAN_VLC;
-	value |= (type << XGMAC_VLAN_VLC_SHIFT) & XGMAC_VLAN_VLC;
-	writel(value, ioaddr + XGMAC_VLAN_INCL);
-}
-
 static int dwxgmac2_filter_wait(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -1534,12 +1451,10 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.safety_feat_dump = dwxgmac3_safety_feat_dump,
 	.set_mac_loopback = dwxgmac2_set_mac_loopback,
 	.rss_configure = dwxgmac2_rss_configure,
-	.update_vlan_hash = dwxgmac2_update_vlan_hash,
 	.rxp_config = dwxgmac3_rxp_config,
 	.get_mac_tx_timestamp = dwxgmac2_get_mac_tx_timestamp,
 	.flex_pps_config = dwxgmac2_flex_pps_config,
 	.sarc_configure = dwxgmac2_sarc_configure,
-	.enable_vlan = dwxgmac2_enable_vlan,
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
@@ -1590,12 +1505,10 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.safety_feat_dump = dwxgmac3_safety_feat_dump,
 	.set_mac_loopback = dwxgmac2_set_mac_loopback,
 	.rss_configure = dwxgmac2_rss_configure,
-	.update_vlan_hash = dwxgmac2_update_vlan_hash,
 	.rxp_config = dwxgmac3_rxp_config,
 	.get_mac_tx_timestamp = dwxgmac2_get_mac_tx_timestamp,
 	.flex_pps_config = dwxgmac2_flex_pps_config,
 	.sarc_configure = dwxgmac2_sarc_configure,
-	.enable_vlan = dwxgmac2_enable_vlan,
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 31bdbab9a46c..0a57c5e7497d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -9,6 +9,7 @@
 #include "stmmac_fpe.h"
 #include "stmmac_ptp.h"
 #include "stmmac_est.h"
+#include "stmmac_vlan.h"
 #include "dwmac4_descs.h"
 #include "dwxgmac2.h"
 
@@ -120,6 +121,7 @@ static const struct stmmac_hwif_entry {
 	const void *tc;
 	const void *mmc;
 	const void *est;
+	const void *vlan;
 	int (*setup)(struct stmmac_priv *priv);
 	int (*quirks)(struct stmmac_priv *priv);
 } stmmac_hw[] = {
@@ -197,6 +199,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac410_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -219,6 +222,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac410_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -241,6 +245,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac510_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -264,6 +269,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxgmac210_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
@@ -292,6 +298,7 @@ static const struct stmmac_hwif_entry {
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
+		.vlan = &dwxlgmac2_vlan_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxlgmac2_setup,
 		.quirks = stmmac_dwxlgmac_quirks,
@@ -368,6 +375,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->tc = mac->tc ? : entry->tc;
 		mac->mmc = mac->mmc ? : entry->mmc;
 		mac->est = mac->est ? : entry->est;
+		mac->vlan = mac->vlan ? : entry->vlan;
 
 		priv->hw = mac;
 		priv->fpe_cfg.reg = entry->regs.fpe_reg;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 27c63a9fc163..06fb4fa5b202 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -398,21 +398,6 @@ struct stmmac_ops {
 	/* RSS */
 	int (*rss_configure)(struct mac_device_info *hw,
 			     struct stmmac_rss *cfg, u32 num_rxq);
-	/* VLAN */
-	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 u16 perfect_match, bool is_double);
-	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
-	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
-			   struct sk_buff *skb);
-	void (*set_hw_vlan_mode)(struct mac_device_info *hw);
-	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
-				   struct mac_device_info *hw,
-				   __be16 proto, u16 vid);
-	int (*del_hw_vlan_rx_fltr)(struct net_device *dev,
-				   struct mac_device_info *hw,
-				   __be16 proto, u16 vid);
-	void (*restore_hw_vlan_rx_fltr)(struct net_device *dev,
-					struct mac_device_info *hw);
 	/* TX Timestamp */
 	int (*get_mac_tx_timestamp)(struct mac_device_info *hw, u64 *ts);
 	/* Source Address Insertion / Replacement */
@@ -498,20 +483,6 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, set_mac_loopback, __args)
 #define stmmac_rss_configure(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, rss_configure, __args)
-#define stmmac_update_vlan_hash(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, update_vlan_hash, __args)
-#define stmmac_enable_vlan(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, enable_vlan, __args)
-#define stmmac_rx_hw_vlan(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, rx_hw_vlan, __args)
-#define stmmac_set_hw_vlan_mode(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, set_hw_vlan_mode, __args)
-#define stmmac_add_hw_vlan_rx_fltr(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, add_hw_vlan_rx_fltr, __args)
-#define stmmac_del_hw_vlan_rx_fltr(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, del_hw_vlan_rx_fltr, __args)
-#define stmmac_restore_hw_vlan_rx_fltr(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, restore_hw_vlan_rx_fltr, __args)
 #define stmmac_get_mac_tx_timestamp(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, get_mac_tx_timestamp, __args)
 #define stmmac_sarc_configure(__priv, __args...) \
@@ -659,6 +630,38 @@ struct stmmac_est_ops {
 #define stmmac_est_irq_status(__priv, __args...) \
 	stmmac_do_void_callback(__priv, est, irq_status, __args)
 
+struct stmmac_vlan_ops {
+	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
+				 u16 perfect_match, bool is_double);
+	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
+	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
+			   struct sk_buff *skb);
+	void (*set_hw_vlan_mode)(struct mac_device_info *hw);
+	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
+				   struct mac_device_info *hw,
+				   __be16 proto, u16 vid);
+	int (*del_hw_vlan_rx_fltr)(struct net_device *dev,
+				   struct mac_device_info *hw,
+				   __be16 proto, u16 vid);
+	void (*restore_hw_vlan_rx_fltr)(struct net_device *dev,
+					struct mac_device_info *hw);
+};
+
+#define stmmac_update_vlan_hash(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, update_vlan_hash, __args)
+#define stmmac_enable_vlan(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, enable_vlan, __args)
+#define stmmac_rx_hw_vlan(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, rx_hw_vlan, __args)
+#define stmmac_set_hw_vlan_mode(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, set_hw_vlan_mode, __args)
+#define stmmac_add_hw_vlan_rx_fltr(__priv, __args...) \
+	stmmac_do_callback(__priv, vlan, add_hw_vlan_rx_fltr, __args)
+#define stmmac_del_hw_vlan_rx_fltr(__priv, __args...) \
+	stmmac_do_callback(__priv, vlan, del_hw_vlan_rx_fltr, __args)
+#define stmmac_restore_hw_vlan_rx_fltr(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, restore_hw_vlan_rx_fltr, __args)
+
 struct stmmac_regs_off {
 	const struct stmmac_fpe_reg *fpe_reg;
 	u32 ptp_off;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
new file mode 100644
index 000000000000..45a0553c1953
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ * stmmac VLAN (802.1Q) handling
+ */
+
+#include "stmmac.h"
+#include "stmmac_vlan.h"
+
+static void vlan_write_single(struct net_device *dev, u16 vid)
+{
+	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
+	u32 val;
+
+	val = readl(ioaddr + VLAN_TAG);
+	val &= ~VLAN_TAG_VID;
+	val |= VLAN_TAG_ETV | vid;
+
+	writel(val, ioaddr + VLAN_TAG);
+}
+
+static int vlan_write_filter(struct net_device *dev,
+			     struct mac_device_info *hw,
+			     u8 index, u32 data)
+{
+	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
+	int i, timeout = 10;
+	u32 val;
+
+	if (index >= hw->num_vlan)
+		return -EINVAL;
+
+	writel(data, ioaddr + VLAN_TAG_DATA);
+
+	val = readl(ioaddr + VLAN_TAG);
+	val &= ~(VLAN_TAG_CTRL_OFS_MASK |
+		VLAN_TAG_CTRL_CT |
+		VLAN_TAG_CTRL_OB);
+	val |= (index << VLAN_TAG_CTRL_OFS_SHIFT) | VLAN_TAG_CTRL_OB;
+
+	writel(val, ioaddr + VLAN_TAG);
+
+	for (i = 0; i < timeout; i++) {
+		val = readl(ioaddr + VLAN_TAG);
+		if (!(val & VLAN_TAG_CTRL_OB))
+			return 0;
+		udelay(1);
+	}
+
+	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
+
+	return -EBUSY;
+}
+
+static int vlan_add_hw_rx_fltr(struct net_device *dev,
+			       struct mac_device_info *hw,
+			       __be16 proto, u16 vid)
+{
+	int index = -1;
+	u32 val = 0;
+	int i, ret;
+
+	if (vid > 4095)
+		return -EINVAL;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		/* For single VLAN filter, VID 0 means VLAN promiscuous */
+		if (vid == 0) {
+			netdev_warn(dev, "Adding VLAN ID 0 is not supported\n");
+			return -EPERM;
+		}
+
+		if (hw->vlan_filter[0] & VLAN_TAG_VID) {
+			netdev_err(dev, "Only single VLAN ID supported\n");
+			return -EPERM;
+		}
+
+		hw->vlan_filter[0] = vid;
+		vlan_write_single(dev, vid);
+
+		return 0;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	val |= VLAN_TAG_DATA_ETV | VLAN_TAG_DATA_VEN | vid;
+
+	for (i = 0; i < hw->num_vlan; i++) {
+		if (hw->vlan_filter[i] == val)
+			return 0;
+		else if (!(hw->vlan_filter[i] & VLAN_TAG_DATA_VEN))
+			index = i;
+	}
+
+	if (index == -1) {
+		netdev_err(dev, "MAC_VLAN_Tag_Filter full (size: %0u)\n",
+			   hw->num_vlan);
+		return -EPERM;
+	}
+
+	ret = vlan_write_filter(dev, hw, index, val);
+
+	if (!ret)
+		hw->vlan_filter[index] = val;
+
+	return ret;
+}
+
+static int vlan_del_hw_rx_fltr(struct net_device *dev,
+			       struct mac_device_info *hw,
+			       __be16 proto, u16 vid)
+{
+	int i, ret = 0;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		if ((hw->vlan_filter[0] & VLAN_TAG_VID) == vid) {
+			hw->vlan_filter[0] = 0;
+			vlan_write_single(dev, 0);
+		}
+		return 0;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	for (i = 0; i < hw->num_vlan; i++) {
+		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid) {
+			ret = vlan_write_filter(dev, hw, i, 0);
+			if (!ret)
+				hw->vlan_filter[i] = 0;
+			else
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static void vlan_restore_hw_rx_fltr(struct net_device *dev,
+				    struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+	u32 hash;
+	u32 val;
+	int i;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		vlan_write_single(dev, hw->vlan_filter[0]);
+		return;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	for (i = 0; i < hw->num_vlan; i++) {
+		if (hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) {
+			val = hw->vlan_filter[i];
+			vlan_write_filter(dev, hw, i, val);
+		}
+	}
+
+	hash = readl(ioaddr + VLAN_HASH_TABLE);
+	if (hash & VLAN_VLHT) {
+		value = readl(ioaddr + VLAN_TAG);
+		value |= VLAN_VTHM;
+		writel(value, ioaddr + VLAN_TAG);
+	}
+}
+
+static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
+			     u16 perfect_match, bool is_double)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	writel(hash, ioaddr + VLAN_HASH_TABLE);
+
+	value = readl(ioaddr + VLAN_TAG);
+
+	if (hash) {
+		value |= VLAN_VTHM | VLAN_ETV;
+		if (is_double) {
+			value |= VLAN_EDVLP;
+			value |= VLAN_ESVL;
+			value |= VLAN_DOVLTC;
+		}
+
+		writel(value, ioaddr + VLAN_TAG);
+	} else if (perfect_match) {
+		u32 value = VLAN_ETV;
+
+		if (is_double) {
+			value |= VLAN_EDVLP;
+			value |= VLAN_ESVL;
+			value |= VLAN_DOVLTC;
+		}
+
+		writel(value | perfect_match, ioaddr + VLAN_TAG);
+	} else {
+		value &= ~(VLAN_VTHM | VLAN_ETV);
+		value &= ~(VLAN_EDVLP | VLAN_ESVL);
+		value &= ~VLAN_DOVLTC;
+		value &= ~VLAN_VID;
+
+		writel(value, ioaddr + VLAN_TAG);
+	}
+}
+
+static void vlan_enable(struct mac_device_info *hw, u32 type)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	value = readl(ioaddr + VLAN_INCL);
+	value |= VLAN_VLTI;
+	value |= VLAN_CSVL; /* Only use SVLAN */
+	value &= ~VLAN_VLC;
+	value |= (type << VLAN_VLC_SHIFT) & VLAN_VLC;
+	writel(value, ioaddr + VLAN_INCL);
+}
+
+static void vlan_rx_hw(struct mac_device_info *hw,
+		       struct dma_desc *rx_desc, struct sk_buff *skb)
+{
+	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
+		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+}
+
+static void vlan_set_hw_mode(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value = readl(ioaddr + VLAN_TAG);
+
+	value &= ~VLAN_TAG_CTRL_EVLS_MASK;
+
+	if (hw->hw_vlan_en)
+		/* Always strip VLAN on Receive */
+		value |= VLAN_TAG_STRIP_ALL;
+	else
+		/* Do not strip VLAN on Receive */
+		value |= VLAN_TAG_STRIP_NONE;
+
+	/* Enable outer VLAN Tag in Rx DMA descriptor */
+	value |= VLAN_TAG_CTRL_EVLRXS;
+	writel(value, ioaddr + VLAN_TAG);
+}
+
+const struct stmmac_vlan_ops dwmac_vlan_ops = {
+	.update_vlan_hash = vlan_update_hash,
+	.enable_vlan = vlan_enable,
+	.add_hw_vlan_rx_fltr = vlan_add_hw_rx_fltr,
+	.del_hw_vlan_rx_fltr = vlan_del_hw_rx_fltr,
+	.restore_hw_vlan_rx_fltr = vlan_restore_hw_rx_fltr,
+	.rx_hw_vlan = vlan_rx_hw,
+	.set_hw_vlan_mode = vlan_set_hw_mode,
+};
+
+const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
+	.update_vlan_hash = vlan_update_hash,
+	.enable_vlan = vlan_enable,
+};
+
+u32 stmmac_get_num_vlan(void __iomem *ioaddr)
+{
+	u32 val, num_vlan;
+
+	val = readl(ioaddr + HW_FEATURE3);
+	switch (val & VLAN_HW_FEAT_NRVF) {
+	case 0:
+		num_vlan = 1;
+		break;
+	case 1:
+		num_vlan = 4;
+		break;
+	case 2:
+		num_vlan = 8;
+		break;
+	case 3:
+		num_vlan = 16;
+		break;
+	case 4:
+		num_vlan = 24;
+		break;
+	case 5:
+		num_vlan = 32;
+		break;
+	default:
+		num_vlan = 1;
+	}
+
+	return num_vlan;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
new file mode 100644
index 000000000000..29e7be83161e
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025, Altera Corporation
+ * stmmac VLAN(802.1Q) handling
+ */
+
+#ifndef __STMMAC_VLAN_H__
+#define __STMMAC_VLAN_H__
+
+#include <linux/bitfield.h>
+
+#define VLAN_TAG			0x00000050
+#define VLAN_TAG_DATA			0x00000054
+#define VLAN_HASH_TABLE			0x00000058
+#define VLAN_INCL			0x00000060
+
+#define HW_FEATURE3			0x00000128
+
+/* MAC VLAN */
+#define VLAN_EDVLP			BIT(26)
+#define VLAN_VTHM			BIT(25)
+#define VLAN_DOVLTC			BIT(20)
+#define VLAN_ESVL			BIT(18)
+#define VLAN_ETV			BIT(16)
+#define VLAN_VID			GENMASK(15, 0)
+#define VLAN_VLTI			BIT(20)
+#define VLAN_CSVL			BIT(19)
+#define VLAN_VLC			GENMASK(17, 16)
+#define VLAN_VLC_SHIFT			16
+#define VLAN_VLHT			GENMASK(15, 0)
+
+/* MAC VLAN Tag */
+#define VLAN_TAG_VID			GENMASK(15, 0)
+#define VLAN_TAG_ETV			BIT(16)
+
+/* MAC VLAN Tag Control */
+#define VLAN_TAG_CTRL_OB		BIT(0)
+#define VLAN_TAG_CTRL_CT		BIT(1)
+#define VLAN_TAG_CTRL_OFS_MASK		GENMASK(6, 2)
+#define VLAN_TAG_CTRL_OFS_SHIFT		2
+#define VLAN_TAG_CTRL_EVLS_MASK		GENMASK(22, 21)
+#define VLAN_TAG_CTRL_EVLS_SHIFT	21
+#define VLAN_TAG_CTRL_EVLRXS		BIT(24)
+
+#define VLAN_TAG_STRIP_NONE		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x0)
+#define VLAN_TAG_STRIP_PASS		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x1)
+#define VLAN_TAG_STRIP_FAIL		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x2)
+#define VLAN_TAG_STRIP_ALL		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x3)
+
+/* MAC VLAN Tag Data/Filter */
+#define VLAN_TAG_DATA_VID		GENMASK(15, 0)
+#define VLAN_TAG_DATA_VEN		BIT(16)
+#define VLAN_TAG_DATA_ETV		BIT(17)
+
+/* MAC VLAN HW FEAT */
+#define VLAN_HW_FEAT_NRVF		GENMASK(2, 0)
+
+extern const struct stmmac_vlan_ops dwmac_vlan_ops;
+extern const struct stmmac_vlan_ops dwxlgmac2_vlan_ops;
+
+u32 stmmac_get_num_vlan(void __iomem *ioaddr);
+
+#endif /* __STMMAC_VLAN_H__ */
-- 
2.25.1


