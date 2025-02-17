Return-Path: <bpf+bounces-51726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE47A37EAF
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 10:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D4316457F
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DC52153DE;
	Mon, 17 Feb 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eX+Ko4E/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902019F115;
	Mon, 17 Feb 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784914; cv=fail; b=SHOrvKzWjKy77Rfq707G6tFUSCGHLLc+QQHIV3CQbd+IS41ZocNd3ZsWZU2utrU35IMVQ0EN6XxDYM0ynlbH+qPKhn4QE7IS6/qkJq1nNQpqwpmUnnCpau6LGVitv1cy5cJ8eB7dJ4GBoSjPzKbzdM3YjWs9+ZkHy+w73sHrPIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784914; c=relaxed/simple;
	bh=zF8rdYevqiMd01kpmXO7bmvWLj50nV0HYobzhYsb1j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SK7+AdxqpOks1ZL8gDsGaoOqHffkFS81mqFqPBhS8L1onXSpCoRuEGWX2HtHO6/1LTfBVUQ3I5ul2jV+myaVw0qQ5gywLgAJ9geTTFDXzOPgwyUsdmMS5kFwsOtWOtkQLgyqV7EUZBKljU94ljfZCkYTIo/VnffXKl76I3oO4qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eX+Ko4E/; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeRkuD+8uQ/R4DoBWrwtfzsw4zmKTy3sH5jWTKG1gWZhVix3suHpcgu0kSYyTATIreD58qiWRkqxvrRVFpjt1MM3CQX7EGAptCubKowR71CI6rkXuAGFmW7f37t9/OK/KbYbVvg0HJahplLvuaxvzlU5hlCuejpkEJ+fo2GB9OFlFNM2I/WBBHn2EI2TlcBkg3bW3vhH8ThH3IGHRRdurOTULO3Wq304hDXixXL/XDwJe1poRSzYHeOa4+x3oiECx7JF+PSNDV+vc/MQhE9DmCJHSxfhQN5OFWoptKBvH4XSLhRyfjaEEQRDYHqz2aFrEkaulGIkK9dEAcYMgjhLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg6albj183lB6RYoxba7CXwQqe7IAZRqp/NPFw1ItI0=;
 b=ZeevhoxPe7ElT08qZUmoWkjAepSCU4oX5P76a71MQXFIM1b4Fxl+WuIrQKSX6vy+/winVu3UAbspV9Ukoh6GtMq9qRQC3voRDVlEMQOT3fIDg6VXaKuuKQphtNMuv7C7K3TOmUNUQx6NrKZpyqCsW0ykxxkUxf8KTQbqpdSVp0IN9HG6D+yUuCFqx+KIN2g5QiTQFERet1S0zaK/pt+gbszxBYUy3oLwzAWUQBvyEXxZKg+vOqlHSBbfpHZFEebebLg8ZpXo45m6LxKWGeG9ts/gf7tpvu6SMSP0Y+1WzDpm1HmTf8jxV1TPt+h65z+lT4J3GUCg493CWGP+BMFNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg6albj183lB6RYoxba7CXwQqe7IAZRqp/NPFw1ItI0=;
 b=eX+Ko4E/7L6rPwVf2DR7x1QKr/830wWxUvrFd344/7aeT0CLe3lmSpZu5xg4uvtKFewzjqvQJ6sCyjaGkFqUiHbYSaguQo0+oZzN7kY+ZiLYqzWe3llAZ/PNuSL+X2YQzlN7wFmf+h/+ShElAtHGRq1X0i8YjSoW7klDepW9kWUBox07cXJGOungY2diyuZLg+JIOqgsCsOhZZgH1zvERGPngam2O194F7f1Zg1xc2tUXrSo/cKS7kdiG2RgXEiFFr/wm+wDB2cgRgtaGopwiVjVbgNYZCNVezifZr/SvvCYOHbe8iGZcLtpJFfVRDW5A/DW82NB2jklc0jJCbHwEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 09:35:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 09:35:10 +0000
Date: Mon, 17 Feb 2025 11:35:01 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Network Development <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf <bpf@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Message-ID: <Z7MCxTDyVWGpRtOv@shredder>
References: <cover.1738665783.git.petrm@nvidia.com>
 <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
 <BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
 <CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
 <BL1PR12MB5922564282DA2C2C5CA671C1CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
 <20250205090958.278ffaff@kernel.org>
 <20250215140252.GP1615191@kernel.org>
 <20250215081043.063e995a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215081043.063e995a@kernel.org>
X-ClientProxiedBy: LO4P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d42da7-bafe-4b74-c2a1-08dd4f365f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EaCz7/VEQtNyNHnMVwiQoAOxvSvBR/R2j3ovO1MzqLBKq8lyBBmAyL3Lv/it?=
 =?us-ascii?Q?8JJjYA6g1aXleWfc51CC4ZXiMTH5lsWcbWmdyk/lI00CWLAbUtf1u6zWRp6c?=
 =?us-ascii?Q?60BL8DcLmRiwgb0xibKx4oLzcWP2HC1zRH4P5sUX61ulj+kfd36uL94N+SZy?=
 =?us-ascii?Q?FmOXQnBiqGVAFWMjbpun4tWA5j7pKaZLxUljmebJ5jzbRWujz3Fog+gtqBej?=
 =?us-ascii?Q?XYk97GhBHsOFLL7Elyre9uu79ygHiCnPUSaIIJOEAfXMd0mDBfsGo8lYZseM?=
 =?us-ascii?Q?OmOuHSeGsDE0pRS7FMVPy6LcbQx8WzA4yr7JowD2nu1R19URs+uRY66tLdXh?=
 =?us-ascii?Q?lRdJGQOqo5XnKEbSsSH7F/NhM6i6ySEQEFQWY3v0sPFLWF/qW2p9Tri+4/TX?=
 =?us-ascii?Q?eXEaWT/ju7E4XdFBbByEGpFre3bTzwCF8rK/77eb8w8SFJBwNEpLOXwQ5k/f?=
 =?us-ascii?Q?sMVe80Bkv/COKhDA1CdlV87EbYxhhrFNVIFfRvaPvAI+PSlzmmliiRfUHLTk?=
 =?us-ascii?Q?pEqEAe34eiKog1Oh8ZsWejQ55EcMsPl0rFFTHcKj6ux5oYRn8Mz7N5JQ1Nfc?=
 =?us-ascii?Q?/gOh4Oxx2l6oQ/A4BTCvW0gm5WKdNcnGGtXl0/h7vMynFP4hefiCsvWQoAJB?=
 =?us-ascii?Q?AdnwDcmN91NnKbHtT4SG7IRTmnXYJan+PHdId9xLkkLD3pna9ndOYwygexR+?=
 =?us-ascii?Q?24sBLTVUHMH9BXdhsycFPLqeEh1gnjQeLo40BdI9IKPjnWf0/1VfkQ2YAQfW?=
 =?us-ascii?Q?AFCNIHVl15IWLQHhvKbvzWXWfcz82XFkg/PJk2tAmTMLhq8kzb2jltN29MoF?=
 =?us-ascii?Q?rHC7/IIleDTNWNGkPdALm3LyUJEMyK3ZVRDbHcl305xoMk2axpM3qkXVOKOT?=
 =?us-ascii?Q?3Ccc/CPtJrvmNMrTZRbgq+gDkhA0/L+zC3yD6ng3JirlgQnNfGZFr7SHmvst?=
 =?us-ascii?Q?xsVvHszxUqd81Xb1PmYhnpoBpH6IpEq0mIj4YhaWj7XPwW6FGKJTOU9WUdy0?=
 =?us-ascii?Q?k9AH/Zz+PxVu2WD1l63G5/SSoPaU3PFqfXLyieS5iRl7fDeMTsdZU3FuBkxb?=
 =?us-ascii?Q?8f4d9LSFJfNNbJtKpNrFqvydUC/X62vzPMemv+KQHZcRLD95u9qypCuMgL22?=
 =?us-ascii?Q?oEhdB//7JjZdBQykw3hWU4Uhx3hxGya12Xg4MLSGwU0w1yotGXBdl/0Q2wgN?=
 =?us-ascii?Q?VY+os2GW02CR9GG7jMH3cx87FmjlXk9UXbFAWJ8EoU+y++GLbXz2+f9bkPHr?=
 =?us-ascii?Q?h+h1dcHNUVfL5y8FbrchOKfwwqe3sUvKDnx825gxBimvbgG6D1JoGXxBjasS?=
 =?us-ascii?Q?cDXMtOV/Zll7xD/TMP/QWgeDpAeUIIWPKfV576SQVb3pmWk0yEkn0AGk+//u?=
 =?us-ascii?Q?82Cct2kiYtj8hHeQ9yUTgMrS+JVF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ci7O1yIGd77XFObmqwBH2OQxxZtn+6jA6HafZ1C2DFzI2T96dD6/Oh6/UeKT?=
 =?us-ascii?Q?VKPKqoZUe73GdeIi4HiH6Dgk6CYajcdmoLLZp39q3++vtjFJrLIATMDIMQZr?=
 =?us-ascii?Q?PE6ut5j8vBdLmD3TL1ZzqdoBxwiDKM3soG7qupRKmv5tFRnSxO9pJVa0KeOq?=
 =?us-ascii?Q?d3TChM3u7ne3boEcq93d4tDIiXwObx4nfduGjxpAOOE26b9AlS8g4r1ubd94?=
 =?us-ascii?Q?QxkLiJxOvrCttrzNmssNl5l5e7iSVGsFMX1IFKYgikrmQI77Smg45XDEJrA8?=
 =?us-ascii?Q?2o+49vt3X4b/Nop2FRa+8uTGR5FKgfipj/H7EgIHfvjCz/E1AfU2MHswvc6P?=
 =?us-ascii?Q?Cbkuz/bQQ8Ngs/suBOS9iUdvio7JzWQDJQpbIzJ6e952gsNqMnltXM3PP9Uq?=
 =?us-ascii?Q?pBe6BMsJQMVhGBYs4m9FmokG5Gm+4kCp9EHwQ4Urqb0skqAkKowWifZ8S4oh?=
 =?us-ascii?Q?byvJtWkoEEqCvIu4HprSNsuDezjYQuO9Tn4NlV+JCbbmk/QmQ0SgmaCeDabO?=
 =?us-ascii?Q?hue1Ali6iX3HPGK8YnL0QUFEEJcwgDsPkkUUB/tTWLMTL7LEOjCtRhrCA03/?=
 =?us-ascii?Q?Se5bPFlAWnDcwy38s/ZW9jcH/HjOtbH6tZOglR6U5oHPKYYJ522jXIHBc3Oj?=
 =?us-ascii?Q?TCZDu1YDozXSnLUcNDpNfN28Kbts3tGIF47oyAKXomXl+AlU9aydaFvmGES9?=
 =?us-ascii?Q?23y1WI8MkO+m62DvLbje5ELaenOPzgZsTvFeNVr/KGzGCN4kRmUjS1u0CY2j?=
 =?us-ascii?Q?fetiZR2x1Y19rM5GelGvVyo/p0G+Lo4JLmw4L9NFRVlFsqJdCYXQHZjoBgkN?=
 =?us-ascii?Q?dk25+8rZaNC6QUzFPee3EwkOSclGfrTvd4wVKEMvfwsQmWqu2jMbl4mgxpEK?=
 =?us-ascii?Q?gw8/WumveXgon4htv6lNPqVqvMXpOhuJjRwE+vYP6/owB2zhXeEhm6r1fwjs?=
 =?us-ascii?Q?XIl+/xRCmKjCaO386HqD6BC+uK9R4sgZE+MwADLJDtpl5rnsoxhRUVuVWHdi?=
 =?us-ascii?Q?JW6xS1Fnp1brBu5DKf057M5cFobijW7y6j9ORKuJrTPGJT0f46uWfSko0HLo?=
 =?us-ascii?Q?dxRjKDQfS42CBgKmkd6sulcIRr9/nYiR0F01zH72Ltx/f9rxDhKtYIe95SVl?=
 =?us-ascii?Q?i5wOqJh5usuWCUIZTCD7dLYwOxWu8MRSUxk6uVECEs+rgBJDUQ+KfF1TZx5U?=
 =?us-ascii?Q?GEnC9w4eA2in53XYojTHl2JKnZkK7RzRog/RkSsm5egvgMM6DaCwL+aIMwAD?=
 =?us-ascii?Q?RYzEx9hSK3Ano+GmTbrrSnT+CqRbLO5tljcx69GjsM84/ug5n0oBeaQ4++hu?=
 =?us-ascii?Q?kBjA4/JoIArP7K6fdx+dZatKLokHYbUNmc83PA8pbiSdRg5SJJvebjeQa6Qo?=
 =?us-ascii?Q?IpLk9DdDNPd6019crrvQ/mHwH3xH7+8Va35SYxighNBSpAdrZSjU4/GsJMmw?=
 =?us-ascii?Q?q8EkFkprkoVIiSwbgkwhowO7H4qujXhKXymbuc5qmeF0W+Dbz109PbX/WcIz?=
 =?us-ascii?Q?EwedrRZ3MxS5jeT1Lin8vlgUdUG+LV0sgSawaywtgk+nGBdlda3HC0AB6Hg1?=
 =?us-ascii?Q?/AAc6tsMFp1D9yx7Z4TyyD1nYV5BM9k26VrNLYLf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d42da7-bafe-4b74-c2a1-08dd4f365f42
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:35:10.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKNFvjqLaFWN9jogFFM495q0l7SP11qZPRPtUprqJ/CG4rhsFrNjlbSPqR18PHcyJ8PuxImNyjFVKsnTlgSxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

On Sat, Feb 15, 2025 at 08:10:43AM -0800, Jakub Kicinski wrote:
> On Sat, 15 Feb 2025 14:02:52 +0000 Simon Horman wrote:
> > > TBH I also feel a little ambivalent about adding advanced software
> > > features to mlxsw. You have a dummy device off which you hang the NAPIs,
> > > the page pools, and now the RXQ objects. That already works poorly with
> > > our APIs. How are you going to handle the XDP side? Program per port, 
> > > I hope? But the basic fact remains that only fallback traffic goes thru
> > > the XDP program which is not the normal Linux model, routing is after
> > > XDP.
> > > 
> > > On one hand it'd be great if upstream switch drivers could benefit from
> > > the advanced features. On the other the HW is clearly not capable of
> > > delivering in line with how NICs work, so we're signing up for a stream
> > > of corner cases, bugs and incompatibility. Dunno.  
> > 
> > FWIIW, I do think that as this driver is actively maintained by the vendor,
> > and this is a grey zone, it is reasonable to allow the vendor to decide if
> > they want the burden of this complexity to gain some performance.
> 
> Yes, I left this series in PW for an extra couple of days expecting
> a discussion but I suppose my email was taken as a final judgment.

Yes.

> The object separation can be faked more accurately, and analyzed
> (in the cover letter) to give us more confidence that the divergence
> won't create problems.

Unlike regular NICs, this device has more ports than Rx queues, so we
cannot associate a Rx queue with a net device. Like you said, this is
why NAPI instances and RXQ objects are associated with a dummy net
device. However, there are already drivers such as mtk that have the
same problem and do the same thing. The only API change that we made in
this regard is adding a net device argument to xdp_build_skb_from_buff()
instead of having it use rxq->dev.

Regarding the invocation of XDP programs, they are of course invoked on
a per-port basis. It's just that the driver first needs to look up the
XDP program in an internal array based on the Rx port in the completion
info.

Regarding motivation, one use case we thought about is telemetry. For
example, today you can configure a tc filter with a sample action that
will mirror one out of N packets to the CPU. The driver identifies such
packets according to the trap ID in the completion info and then passes
them to the psample module with various metadata that it extracted from
the completion info (e.g., latency, egress queue occupancy, if sampled
on egress). Some users don't want to process these packets locally, but
instead have them sent together with the metadata to a server for
processing. If XDP programs had access to this metadata we could do this
on the CPU with relatively low overhead. However, this is not supported
with tc-bpf, so you might tell me that it shouldn't be supported with
XDP either.

