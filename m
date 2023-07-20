Return-Path: <bpf+bounces-5526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A075B725
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31151C21511
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A695B19BC0;
	Thu, 20 Jul 2023 18:50:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB02FA2E;
	Thu, 20 Jul 2023 18:50:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2133.outbound.protection.outlook.com [40.107.243.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4529BE4C;
	Thu, 20 Jul 2023 11:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AotugDfmJVLtJhpgg2KbRWnoRcblNqpO8XdE77o4io4K3tkn+UV075mjYYifSuf2bQbLOtRA47VHSpBEBcEucBn3Ipc4D2VCizBdJGNTwiF++V5EJxh5Fv/mwrqzV+hjOCDBVsNCCsn2bVXVf9OsC3cDRHgMFNw3bJTZQ0MgP5amVirH43y4Td5QakspB2tWkSp90an52c3wlKKBjnIHTPjL3ufVf8azr3N97q6u35h4c/vzFMdCGpGUi5ND4CCH10Xz1ZxiiqqOqCx+AdHyICiBWqF3lXjQM2IR0aNLEkTcdNEQ/0hRub7I00QD2XfpnGRZ3kzONx6MUE1N/2jIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Yzgw8pd2HF3Ois9fNVF8okfwH677bWKV6OxoLgXM8o=;
 b=KvAJKB/m0ou1f726GZEVptIVDXRzF0HtUngYJ/E+JAVgm2OGgFpCzt0V+IW+OGGby/yt9kZOVQKS9phDv+uk0DhCa/M4mRY/bzmIJjNMsZTL4Eh0CCECmN3VgJ5shYoV0f1e0hRe1O/v2n+LhH1ElsDbdORoWyXujCFDSn62LRDVkK0id1Utij7WW7VOpdnHs5WK8gfI1xxPkDBwg2LwU8Ev27tqZCiMLkHkTZd9xHZeU4gscK4j6BmECM+iOG0g6BSPUePtQcULXxIPCmpchkEYmXJ7pdX7bkHF7OhrtuqD4/JVF0newmCOQOkFaF9cGX8osDlj9/yOOk276xVLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Yzgw8pd2HF3Ois9fNVF8okfwH677bWKV6OxoLgXM8o=;
 b=YGi8XVgc0y5LYWwHXYb77SXJLYsTW2PpuKnT1wfgOWyI21VUmURrx7iayFwjVBsaj1bRXItU0Uiz+1GnhY2Q+XkX5D/avzAl8tX71HIx9FM4Hkau1DVUGXGK9bX7R2REookDthPhov0Snd4q8yr804N6yQ5AJgrHvk4sSL7j1SU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6370.namprd13.prod.outlook.com (2603:10b6:806:382::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 18:50:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 18:50:37 +0000
Date: Thu, 20 Jul 2023 19:50:27 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 10/21] ice: Implement VLAN tag hint
Message-ID: <ZLmB88LX7lb7J+zC@corigine.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-11-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719183734.21681-11-larysa.zaremba@intel.com>
X-ClientProxiedBy: LO2P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: f03d1c70-830b-4867-9873-08db895234de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QcJ75xeQKBgUJqdniDkcTjyPkd/hiVSHIRXlRfxN4U5Qcog0a9VYx20TV4TsFafZ4tx1eao6m4ddNe7gBSsR/08ObMfE13hbw9i3Nnf9ekvJd37bDLQtNA+Hi4RvE9q1XCSNOzD8tMVGhy+z8lgJb2lnc23NP/iL7g3eV/0m+elzV9lN4mT/NuoMOFBhNEkl42tybhOIsmT+lDCvc5mVDaoAQw8WRZF7raJo3xZ4YFovkQ0pYdMZpeik9c+aUYsUFAzeXX+siFsAXigUaai6FzkVV1vhC7tQ8ta+kDUWKGZI0xNrw8GRv42ro4uDNnZox7WYxXSiyZCt2LagT6gsZcCV/zKYGkxdN5JYacxp6+iZHAb/f3rij1c6Z8WjkCCrhDg29n99nE4B7JF1fcI10HNcaUEaUdc1swVWhEbeSlrb4Uh1GC3trvFalRF0tNA98huyfc5pjMO7ixSoMlQsI+ddDZuP0E3nrj0HAQpW7UbRJTndPKsLo0eXTc9oKYS8CpmD096yjT05anp7Vqu2lZtocmIHfM+CFI6YPWsIkMhhJmaSm4PQVtNoSWkzJjas3hGBAAc/Vq3RHVdssZdRe9XDnQ0uN48WLlfjV1C4d0K/vAyEHL+finPIUprYI4UCMMHEv2DZlnrqABmdnH7LGKzFlt8MFkL1+/9U9t/GT34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39840400004)(451199021)(38100700002)(86362001)(36756003)(6512007)(6486002)(6666004)(478600001)(26005)(2906002)(186003)(6506007)(55236004)(8676002)(316002)(8936002)(44832011)(41300700001)(54906003)(7416002)(66946007)(6916009)(66476007)(5660300002)(66556008)(4326008)(2616005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QoFwbbRzpp8uGiTUDhUhWlLFH2+E+nd0fVHLLZ8Q42JCilgzdWzmdDaX9yci?=
 =?us-ascii?Q?5h8qmtOTb8F4t0GyhsB8klhpH+27qN73D6AWnHmzeyNwchDIkalgLoXuoGmX?=
 =?us-ascii?Q?mlyAzFWttmnBfWhBYGtFBk0uu3JFzwg7UAObVczWbtXqqJZtQxu6PBC2S299?=
 =?us-ascii?Q?Tau61dsHrpki5MTsdsB3C1ax/XiyXKNs+/1xzdCkXVAcbXePuA5I5k22dGu+?=
 =?us-ascii?Q?1cv3B/tJqReRM6UaBbztJc+1tdzLxQ/ErTMx6Es2w45wEU6H61mUGBie69i3?=
 =?us-ascii?Q?1qSPbnv+Am88WoKSJ3d5VVmOGHbBRvq3gDfU1J9tScH7P8GHzjgC2OzScKwZ?=
 =?us-ascii?Q?85i3zNx55Eil0OYBbkMrtQFGeFRVl5sb/qd9RlvSGnckh6zIL+nkqtsCIeID?=
 =?us-ascii?Q?OvInBL0Z3Y2Nb3lyGeg+yZQxLr1bI7FqF495r5QNQscXmB1GZ/L/NessZIdN?=
 =?us-ascii?Q?FJ/xetQ56g68AnFzVWAbecY2nVo9wwzRNtSWP5KZpQbUprmbS22/0Bqzx5AY?=
 =?us-ascii?Q?vAuD7ZD/xE7SEtCqsiXyV3U+I6pi6TuFAfnL/MbPvc8s4caIqlRn16Y/eEcs?=
 =?us-ascii?Q?OZYUI483CW3I+rFygG2xKxe8qvYEtZL0TIL0bG1muWK0V0EOtLaSz4MpMSDa?=
 =?us-ascii?Q?rrNXjsqf+Llv5OZtUUgFQHoKiNI0PC0UihzTkWlFM3PFv7VvLmDCTzDLToje?=
 =?us-ascii?Q?3VLEupSK8JGv0yNVaAOIT7XLyy//aAJAqtGW9nbt+92SEFq+zxQ7WKNodWjQ?=
 =?us-ascii?Q?fbrA/xXbrv/angVZnyFffMpoa9LnMAFwX2zUide0ym2YEfBUmZxl1auVcHfC?=
 =?us-ascii?Q?zuwNDb/wRbpi5Fuc0B+w13P+MO9fBrs6nZMVwTZBesdAOwYb6s7q4JLIE+XP?=
 =?us-ascii?Q?KYk2QUk0uxmckjU/tPmGQN3y0kEeB5TNcqGiP0PqWmnBqlvCV3IZDqeJuBy1?=
 =?us-ascii?Q?JWmV4EyTrt9yWCGe/nT9lj9OyBjBUAY/iH90w7o38Y3MOhTcmMRrDEz8t5+e?=
 =?us-ascii?Q?xVc4XZ+73NUgi2mhy73HwEGM36gwjjFCVulVvKh0xTNg4hqgLK9hORnwYOoD?=
 =?us-ascii?Q?R43Nu3v1jFQr5ZsuqWIZ7c19u4f4DNwRXr1BYznvPTIIN8axgCx+LOxPkxbg?=
 =?us-ascii?Q?VXwjF03Ps/+sibYwlgYbZa+tJQEBQnh1CC6M0d4mD8+M2AEcYZQpf6Zyq+dl?=
 =?us-ascii?Q?fEvPbC+TmT/2fQfiubpyh33l3rtsqbyt0agXp7YEOT2nAwVS6Om30s+bxmAZ?=
 =?us-ascii?Q?fJdFxC4FQw4mcExUYDG6iPVoB/vIpxzIwx7Y8wXaXRuak4pRitFflTaIG1zz?=
 =?us-ascii?Q?N1m7nrXxZcS0znLIs6Pp5wCewTQALfuco7qzVcIAvyc0WQ1dmr0/oJo4k8dM?=
 =?us-ascii?Q?ezH1AgEias9UIv4YEOPGaP4N6oaf0AXzezDUUjkbsTBWyfJxlYflqTCifTGc?=
 =?us-ascii?Q?7gonZ8k5e9hFHw2YGMm0vgfy9APHHsdBR5k6rLwHNyy9VhNjgaN+27p3uema?=
 =?us-ascii?Q?iU5ba30ozZycLH2ib32b7O+dKnZJhjcguYClJe9CZoXPvyDiHQZzr3mUgBJc?=
 =?us-ascii?Q?2OjtLp+x9xhkTjRDEo4bB3aRBRVEedmsaQQefDn8m5KxYd8dYCo0LmTkpogH?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d1c70-830b-4867-9873-08db895234de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:50:37.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n78DWHeuxmrcAl9eV3R4I0uAlezEpjp5+e6bYUDryM5HBHwh84vcehw3I2ByiETvcTvge0YzgXW4uSUkOM7PNRzwi5QpHOmKQyDj9j2OvXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6370
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 08:37:23PM +0200, Larysa Zaremba wrote:

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index b11cfaedb81c..4ad6db83674e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -639,7 +639,33 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  	return 0;
>  }
>  
> +/**
> + * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
> + * @ctx: XDP buff pointer
> + * @vlan_tci: destination address for VLAN tag
> + * @vlan_proto: destination address for VLAN protocol
> + *
> + * Copy VLAN tag (if was stripped) and corresponding protocol
> + * to the destination address.
> + */
> +static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
> +			       __be16 *vlan_proto)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +
> +	*vlan_proto = xdp_ext->pkt_ctx.vlan_proto;
> +	if (!*vlan_proto)
> +		return -ENODATA;
> +
> +	*vlan_tci = ice_get_vlan_tci(xdp_ext->pkt_ctx.eop_desc);
> +	if (!*vlan_tag)

Hi Larysa,

Should this be vlan_tci rather than vlan_tag?

> +		return -ENODATA;
> +
> +	return 0;
> +}
> +

...

