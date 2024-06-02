Return-Path: <bpf+bounces-31141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB31F8D7449
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD15281355
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520F22F03;
	Sun,  2 Jun 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rgxtPRw8"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C222570;
	Sun,  2 Jun 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717317507; cv=fail; b=XVx0GlBZ6Rt3QwzuXOOFRKvbuqnN9NJstBWnFhb+nJB2ghQkY0acMa5ywaeOrXzH0WBmNICafRIk3lyJR0mFIzRpp7cBD01RB8iX3jER97fw0yb1AeRWB3XTnQ5CHt4/WK/DhT6r/W97P//90oN9h74M5qwL2mty/t6HnDK3vgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717317507; c=relaxed/simple;
	bh=HUF6GfFXU1BfihAU5W8a4yDfFsymj2a7zVs1tVaLTow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=htIOqQ6FefaZoLNiyxqwcQjorX09xNLu4FrHzDqG1scWx91llrvtwN8g/HFROELp+5OWEbx2PMrOVjeOhy/rq5now/oPxiUgSok3WwtP3L/BN+sZCSQie4JXTq9gbo/ozWf3w+rDby//jnHWiGcBBJ3pBSYeybcmfhVm033gSq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rgxtPRw8; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejn8crevTxNci9jzhXVlfCG5/h7WL+9siCeSpuslZXx8pyIz/L9zN1efA1En7jME4RoAidK0XZqL3b51rodHq1VykiiHZ9jCzZzNU6o1NolaSXcOStujZbnYaUNKP4L2dxg1m+pCgARyQc9GqMQJtz9whRJXua7QdLA0R6R8klcFK1wOx5GENxC9Ry9SAT6OFkyj20OiRJ7oQEsWrZgMJFZCW+UyDFmH3EikTGS+cG+dcFu6pBAGclyFNLB8kNYFv6OeKcCIIhnK6yuJTcY5wX1GRmSaqvZ30vu881JAExD1AnEadXdFq29b1AhbbWO8l9hbPF9Eye7aRXNzmCtgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIXb9TPP65IZaEsGd4HElOylnZ2YPyGCjM8oQxeuNXY=;
 b=jgnb5XbUgQ10lKneVf3kRYJ/hMTPEMsk6y+4oRD3VesejOR1/+R1GA3wLcU6SD4AcG0OPfi6kGo15ZGgyTL/Pq3ZvnaorZALZsLZArXpt8l0gP2iCR+f4+fQ6B5iDyrH21TDXOk4bV2YGfa01sAmsNad5ToYj/PcRzw2OZC2bHcD6M4lIzHsfTFLPHp34mr3omtp3M615GjsCQFjg0FHPZOMvTqp0cDxDB7NzyfUgxVbcmB/jC5DAvCS3JC+h+zJguSVX75bzFFU7oyUZfGNai+7QBIO1L48a7nLi6CbhZpgEgLCYJmpbkK2RRMSRv+EAz9bvmPaDu3vzSe45WVpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIXb9TPP65IZaEsGd4HElOylnZ2YPyGCjM8oQxeuNXY=;
 b=rgxtPRw86N68spRkaWGdB1UW058Wg2dHwPmNZcIU04q5bhO5y1cSx25tY6y/1UV89X+YP09QRAQ7/g5vFc+CJ5DOaYyIVztcpzRLr+l/B2PHCjIj03cm7fy4aWAn1LBwND/PCHKjBA5e3Mq6+yP/oOFsmduddXRX+bLxae6lb4qq8TWDFbQxtlsJnUcngYKaB3tENWt2UKi5q/o3+fqpLQlav7gDDRR3xm5i3SIsmA1gkC0DiiTsIaQscWfRgvwRyfBIyphLEoy6v0FlSay3yV43cjAgLFbHw+ICTFrCEKVOh/qocmLBR6H9K0wfSn+Nki+76sIXdA/DIuFid5k1hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Sun, 2 Jun
 2024 08:38:21 +0000
Received: from IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded]) by IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded%5]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 08:38:21 +0000
Date: Sun, 2 Jun 2024 11:37:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	David Bauer <mail@david-bauer.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
Message-ID: <ZlwvYesTLZVR5ezQ@shredder>
References: <20240531154137.26797-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531154137.26797-1-daniel@iogearbox.net>
X-ClientProxiedBy: LO2P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::28) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6163:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dfcd82-f4a4-4023-240c-08dc82df5592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?By6R/NDcht0ESWIhCl0JTPBiC3KolV30MopsX76jGwjKQ3dk2tSRek9w3dQh?=
 =?us-ascii?Q?NSy/WbD8C4hBqUYxpYyGJCdlXZtyMUvXRd4W1afUL0E6K0v/nJtNmKFn1vEu?=
 =?us-ascii?Q?vCaj5FwshsR2JbnmlC1xylMWxdeA0SvfTmXPFAIKt2ozxQGCjS59wmkxripU?=
 =?us-ascii?Q?ZlRQwOEIMsexuYCIwanBcgQzOhCCb6usiBEuMwD4P7I5goUnZqmxxbNT/JE/?=
 =?us-ascii?Q?TeOH2JN1bo+a5ep1DtZsAw2X4DReTDAls4lJt83z2+raIjk9C3UMLlCHs1bC?=
 =?us-ascii?Q?9BwexgzUjzctajgwlnX1uyLsm488v9VImeXx0Rh9Gamp0SX8hHo6ubj4NZvy?=
 =?us-ascii?Q?vpcNIF6Oa5X9qkqWcsGsL6N9J6RpM2MSqdUMClmg7TPRv5kkenWdPSSClsMS?=
 =?us-ascii?Q?DowCb6JicJuq/OSdIF21zIRITzNzKvMUDPMKxHz8UdRmzfr9uOIIn3ZIX5kA?=
 =?us-ascii?Q?p4j1vcxuy7h+UlSeaP1BB+wG+nAiFWkKCTw+51A2IgC5n5vQ6BTyXm3LLe0e?=
 =?us-ascii?Q?ew1PDMIZhMBF7bDaHKPrhTU89zuUWxBE983uAyrOWmjIWueQYIblktkXboij?=
 =?us-ascii?Q?4WGFBcmtPtQpbOD0rtXeeRxM4I9zgkeUGZMPZP/hlaWk5CxQNE9SjE7uFf5w?=
 =?us-ascii?Q?wbpR43yPFbfJqmbj7x1kFWf6YvOLLWU6S1CrECyTZa6G8dGkyoSOeS5sJWrK?=
 =?us-ascii?Q?MwLZkZBkckESzxWgYLazTXQ18NJYCRsV3IPiY6Ym53mYnKpci84dENAfG0ys?=
 =?us-ascii?Q?vbnQTPAxUDHsQPl3UNLzI78svCcTHaVxOEG3lf8UsXZo6Zw9y7+sGzX0KpRd?=
 =?us-ascii?Q?jOBgWleHmppXIvxMWzCPw2Rr/lH0PQRJ+h/skyPbxi75GzxC/puN++ls2jOC?=
 =?us-ascii?Q?sbmPppMk+iOF+cMYlJvGsoqgJA/sDVy4q8ZI8IxKxOk3XReSWIURXcbVnzv0?=
 =?us-ascii?Q?YtrRV9yG8t46JDULJ+bjgDpuNINGBV95yPGyo0rFtlZ3GEq14QmiNVipb+ic?=
 =?us-ascii?Q?OPTYIompvsZsYNc0FHmTKEra/Np0nTD3WjBt2IFLp9Zo+QNByBMg/Su4F1CP?=
 =?us-ascii?Q?sMZthULEOxnsxEskxiYpPAFzA8xNJcz0FlA1de7MJUOXxd+wpdulspGlvOzM?=
 =?us-ascii?Q?nA1S/iicf9WyF4EDgYP2ZtE9DPCs7z/86Bmgu5BIgJ4grDf58wc1qX7FPa+n?=
 =?us-ascii?Q?LBxT7HmV1DGZn+kvZCdt/BzbLQY6DAkbiwxYz1dT5H+zdZc+mlzDX0Rwvo84?=
 =?us-ascii?Q?GhFDOw1Hlz9BumgrJgAPVovRVPLbMvh1sjmtj25hwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lBhOI4g+o3Aaj75iv+v6QC4csnyHCIgc4wJFz0uOhkUo3v3DWqwdq/tf1qfG?=
 =?us-ascii?Q?aKRrG9t+uZlzYlh1PSHgNAZPs3DlAbb9QBxtJspVbUJGskSvo3msZrQhzJFX?=
 =?us-ascii?Q?inHLHcTCZS5lsOIh7INy4IxxYDT0O/aTmQCK+8mx12Z3H1uxLKxkW0E8DmYb?=
 =?us-ascii?Q?O++PRJsfxbeTD7F4jlFCLwGSdrmDZw6+agH0+k5uP1utFP7Eg8iJ6scasnKK?=
 =?us-ascii?Q?lZdZCj5uOksDFsUrqZ6G5/Aw1Nw3c9FEcCe5///VprsIQLqNKZjD+hp4K/TW?=
 =?us-ascii?Q?Z6ZQpJ8M8tOcWfhPYglNv6NSk7qcFukqejoaX+bJzJv4JUp4KpkzEl58+uD7?=
 =?us-ascii?Q?pUAdICWShPAmHLlYVMB4EVsJS7Qg7c3TGLXn8utVjnDhvfpk1zpkUfBwusE1?=
 =?us-ascii?Q?mBf4yoUCemjhCYpoFAB4emy0l1kEJcFhKCrucuhfzTKv5G7o9EL5rKLp231S?=
 =?us-ascii?Q?ssuGzppE4vWjhpjEHQVV9Kh43NjJThaZwi7rT+2x/W72Wcvnn8Q0IIA/hvJP?=
 =?us-ascii?Q?tTDagaAKkiVeH7SnDCCHXox41ctDBFRATngfD6LHBhkMkP+aTtNt8yCyV2bO?=
 =?us-ascii?Q?UQglfrC1F2FbrPGwrO4jeUF5w9YG9kWLI4H33Oi9KNds8xF4E/oTc/yBC2k2?=
 =?us-ascii?Q?qzvRmp8VWW76M83GF9xCqfgp1JUZ+I/xhn7QjP7ww8y9E66qBuuW0PMuomLu?=
 =?us-ascii?Q?2x+CApe5GlMmGi6knICFMY+GG+95iZUj/SJNQQSuD0bj4DGvC7VU771stnY9?=
 =?us-ascii?Q?9/6sd33cs38jCpdgwziUYl3wxRhV6OyINkLOlqsHvzXjkW3cV1qAD+FjldQv?=
 =?us-ascii?Q?Vo4aL3q3E5sIgBYuu7sO+IqAGz44HydyzdCOW/3Guo3mLpnhHMRvKhG0QK0z?=
 =?us-ascii?Q?DMhWHzy29dxUVTK0pLUyQu9fL0jUJJDGHUdLzN4wSJya0TWpBonCHLsLULUa?=
 =?us-ascii?Q?U9O0U05fWsLHm7f1fVSP0nn0zGWu6pQRx3PQvSDVn8YRh50e1rlYDcZsK+/+?=
 =?us-ascii?Q?dCs38e8/f+ASUAy3OInsLtTZy9hwGVGwLj9DjRRYXcv0vck+vPnVcFMVUGxB?=
 =?us-ascii?Q?zFoA+CG37r0Wh20dRFg5ZzySFuN5N89AafxeVEbny+/9YxkOOCp+i/kXAf7c?=
 =?us-ascii?Q?l3RwQRi93EklB16fAIQaCIJkptS61DJ5O61xr07KlAzdXEht+08M30t/FxM8?=
 =?us-ascii?Q?d38Ij+te9d4oK9IewSHxxAzvGT7w2762B71jsqVy3ksc/hjUaxyfTyVPY5Yp?=
 =?us-ascii?Q?LGp61o4aoPZ3bEZZdezrW0d/5F4jKWEQHDl0/5ZROk9mMVEjX0ahVIRVAvmc?=
 =?us-ascii?Q?/fHG/lDov3P8Yswh45zDGoY4LnRf1kawzLowlLJF6PROqEJ00wqYFVEZAV92?=
 =?us-ascii?Q?8vGUy1Vsw/+d/AFkFxVhWoW7xTtukLXnTS8CuQfTqxXrxJHcsemOFSJf75NB?=
 =?us-ascii?Q?wNyf9It1ZIX8y1ja8Oahs3oDsKq1VAEHReBh6SomGpwdfixQD+9F1JfdH05T?=
 =?us-ascii?Q?UC22uaO7InDtr1kPPums6hl0cfsM3njaSZuX18avsDs2au2qsrDnPCtQnip4?=
 =?us-ascii?Q?s8cq8aSt7AAHXYPwm/OKlyGyNMPsZCyQ+jr4WQko?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dfcd82-f4a4-4023-240c-08dc82df5592
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 08:38:21.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: At64WSgWJOK136O/3c1+LadlE9mwqA2ILZbWuqLOU92nA/tc/1nSWvmcwyUA9211yxx4S81go4we4e78ckyHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

On Fri, May 31, 2024 at 05:41:37PM +0200, Daniel Borkmann wrote:
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index f78dd0438843..7353f27b02dc 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1605,6 +1605,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  			  struct vxlan_sock *vs,
>  			  struct sk_buff *skb, __be32 vni)
>  {
> +	bool learning = vxlan->cfg.flags & VXLAN_F_LEARN;
>  	union vxlan_addr saddr;
>  	u32 ifindex = skb->dev->ifindex;
>  
> @@ -1616,8 +1617,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
>  		return false;
>  
> -	/* Ignore packets from invalid src-address */
> -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> +	/* Ignore packets from invalid src-address when in learning mode,
> +	 * otherwise let them through e.g. when originating from NOARP
> +	 * devices with all-zero mac, etc.
> +	 */
> +	if (learning && !is_valid_ether_addr(eth_hdr(skb)->h_source))
>  		return false;
>  
>  	/* Get address from the outer IP header */
> @@ -1631,7 +1635,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  #endif
>  	}
>  
> -	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
> +	if (learning &&
>  	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
>  		return false;

Daniel, I think we can simply move this check out of the main path to
vxlan_snoop() which is only called when learning is enabled:

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 7496c14e8329..89f3945b448f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1446,6 +1446,10 @@ static bool vxlan_snoop(struct net_device *dev,
        struct vxlan_fdb *f;
        u32 ifindex = 0;
 
+       /* Ignore packets from invalid src-address */
+       if (!is_valid_ether_addr(src_mac))
+               return true;
+
 #if IS_ENABLED(CONFIG_IPV6)
        if (src_ip->sa.sa_family == AF_INET6 &&
            (ipv6_addr_type(&src_ip->sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL))
@@ -1616,10 +1620,6 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
        if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
                return false;
 
-       /* Ignore packets from invalid src-address */
-       if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
-               return false;
-
        /* Get address from the outer IP header */
        if (vxlan_get_sk_family(vs) == AF_INET) {
                saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;

WDYT?

