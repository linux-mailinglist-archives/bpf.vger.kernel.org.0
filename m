Return-Path: <bpf+bounces-38178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8F9612FD
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 17:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED911C226D5
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BED1C6F4A;
	Tue, 27 Aug 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jmlb71MN"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537CF18039;
	Tue, 27 Aug 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773088; cv=fail; b=RyCaZLb7DYSk2lSE1ed0jmCY3qBGniT5Thn00fsOKolVi4F7TqP8+8xJHh1Hwd/VKmsm8B/NS0U0UxDt+7eksmI5Lq7p1NbiuGShsLiNmzCfAOOEa7McG67ody8ghcF+8nQEU9LLk8XXTuQFBR4YgFA4o0LByCVFLK12xMEx/+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773088; c=relaxed/simple;
	bh=yukq/ielp/jTYyxE2brzTBp/P5PO+9r2ugcczZrnig4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czj0Csi3lUxss/VQ6JV62SFTBaLpxIgVdgOetIXW0H+Ljl48+2anArNIhGkL7ZcspRbpYJ/dgW0rVuK50RMveZaEWQY50fj4Q83Am2IzRtPxmjgBADBOrFWCxRWBqpTzlJJkfrfdSTOFz+c4dmVD/L6dmyeLWT51cMlZef+mfvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jmlb71MN; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blBwjZUp1kzZy8wTrpXdsvuCNXMKS9YqRA9Hlw57byzek/g67tRG/dcCVZqi5jE0VfEsIGFfARGqRLyaJQDiufvDh6r6qGXpik9h7YJg5TMJd8kFeqHR3n6NEukuO+GsjjVuuzBACKPDsEk6QX1cBAxe9SlMM6sNE/xcpJ+4beCwIisQIg3cuyKveWsTRQVN7Ihr3BgZ2sxRrusbVXHL+S8YhB94auUWmCbjo396akj2Cu5s8YGn/Q529zI4cu4KK37efz1ZMHbw+9U0lElNBotC9E0edqS14gCRkEn49xkM3Ul9MozWLmgUVBjxZTnqw2/Z27S59RcnGFT3/EZwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbhfR37wVuq25BcC868fKZPMrsczqyITzm3cYfNLl80=;
 b=XMjRoYo8xS6LFLf0T/w2oKQfSsva7lJbLEhejkNZzkBeRcwdzX5I5OGLUp4+ewUEfHzmwHiX7DcuCJSHYssQ2CbRS0maKDOsSJRfU57Ybr/puqUpILeLco0t3Ftw9K+siYTyZglv5F8sLG97/paTbyq+3wB8XYgncSlSOAJFB7j+Ke/THP571Sx+itHNEtZZ1l9d3Y1X2E2m/uuGLqsZLkzTecD7bBaQlCIfXijK9jN9rQWLS8LLRWw3CnAU92lpLB469OJfd9VC8W9+ZbwPPWFiWWf5O/DrTfed7gjYn01qzlkuetJ8iK6eqVegOV+c2ISjqJzyII/MDLsSRoAFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbhfR37wVuq25BcC868fKZPMrsczqyITzm3cYfNLl80=;
 b=Jmlb71MN7rj4eOOlMtw/k1+ZmaQ6RDt1d5Csgl+JJlxyqdLyJtEQ+Dp3LGZae+5SpXF0nTrTpoaz9LV4o6CNWeprx87m/yCtgqhVB5DuZTzwDZhGHjm/Wf1DdJakvHHnQ2FllAwSAOV9m/u6jF5NY0VELcktQyF7jNFsiEqrFCXmIrsSnuK/wjBXRpJbKQCq6gUxADXahR0JyKlkseKg1ckF8WMvaZnfJdlajB7s0Wnn4obXrK8XyzsF3cbUadDzku9alRMfzHdbBy2fkoWJm8Qc6x7+HAriVIRFdvs3cmlYiM2tE+v2+C9Bhtn6WEVEZmf5HFDVMhs/dOUxmjN9qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:38:00 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:38:00 +0000
Date: Tue, 27 Aug 2024 18:37:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] ipv4: Unmask upper DSCP bits when
 building flow key
Message-ID: <Zs3yzYVCqyo8gP3w@shredder.mtl.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-7-idosch@nvidia.com>
 <Zs3oBWRQtDjl4JxV@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3oBWRQtDjl4JxV@debian>
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 098930f7-a597-40ba-499f-08dcc6ae3b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/pyuQYzL6ILMIKilPaDv0A3Br+O8Heuz26zLJJoMUdmnIK/cQy0QbzXWvhcK?=
 =?us-ascii?Q?r67aDOS+tUYxxxX4BuhcZasXra3ARvXhRnRVjnjdLMEw054IZbW68uRu20gG?=
 =?us-ascii?Q?S9ES11QIILvOUHgxf42P032cIJ/bSztbtg4dalu81Mw23grWM8fB7vT3CCFM?=
 =?us-ascii?Q?RZPNCn/8RbiZUVucX12dQ608zsIHRubVWYcoLW1X5RxhR7h+KcmU9Cd6jTSM?=
 =?us-ascii?Q?EU9t0YP9pb7qi5AvVNY+wzNmZqiRwhrsAYc9qmc1F704eN2/F8VSdyvAB1N3?=
 =?us-ascii?Q?QJxY6ln0ii6aL+zbVQz/DWStxzqqI7Sod+jMRkTWFPYbZfDBjR68NA5aDDqa?=
 =?us-ascii?Q?QCNUhtK8hlBARJE+457F2jxxEzttqJD0ebNmYHWEdUrA/qo9sL9/P9TSvnen?=
 =?us-ascii?Q?OV7k8l3cb77LriV2aL25qdcka1VLHfbuQeOOdA4EvZpARVi/i8DT6eRItCzg?=
 =?us-ascii?Q?NjT1/cpniyeqKCbElYUVh7xDKcfJFn5ZMwEovbgmtzoPxFgGQB3v6Urdlg9S?=
 =?us-ascii?Q?KahVVmsfCQh2tt+ySMunYIOxa9cnw5gQituYgayk+MekHB0EtmPnImWJs1CJ?=
 =?us-ascii?Q?Stt1MTsLcvCG1HMhvKVMfzNrCU+BYe8MHdO/yQVp9UGqTf1ueeaxQUEwQGSf?=
 =?us-ascii?Q?VAy3IacAi1vv5YsOGlSoDFMceYC1K75v+xRSfefMgMVROM+t+FLE1YRv1EhQ?=
 =?us-ascii?Q?d1AGoz5qgWggS/V32pE5xy114UVLTMDkSjDwJSUlW3myB/b6Wid8/ne2AKm6?=
 =?us-ascii?Q?c5c+Ct6hbdsAmpd9Te/6oKNzEhZQgWgBzEFsb/pGmju4AXmtjYrNnvJbeNob?=
 =?us-ascii?Q?TcGMZieR3yS69K5Uj+TuhyBOimrZK40PQUJfug9UprhT7pSI8+3430jx7eWb?=
 =?us-ascii?Q?nWy29KfTgZopPPufm86oHRSOQJZU5odmIrOqlg52nCo7yoQ/IRdclKXaSy6I?=
 =?us-ascii?Q?+R29Suo41zarkHHpgK6EyDKb+8iizVDEn/wOLWy7lmBAUm2UMkDqRnKiYY9f?=
 =?us-ascii?Q?pClPFbD5CIxUt7cAgWcd2gps3sU5S5FqYPTaccu1GpjDmkpx1xH3uAEOcoTG?=
 =?us-ascii?Q?rSrZR1OdWhtSRrWWngSC4gbeNAh79OmYvFtsARY2oRMEnTJsFsGWjDjnIsjb?=
 =?us-ascii?Q?LOr020huab8jWlLdKUDqmUDmVis32/HOfxFGpjXPX9dVYrIIxK/pw3Ix+qb1?=
 =?us-ascii?Q?u5u/GMrb+KrSyh5MlERK6aOmd6g2Aci41c6y5RkUFqtcdtX5jxQmHXjpJs6l?=
 =?us-ascii?Q?xBKgRDTd7POyPn1JFQgd/o3kCMbHtAD5uINZ4WAD96z7TfsiLjk+3S/Q7H+1?=
 =?us-ascii?Q?07sb5GcuhOdE3wkXHJEpH2u0js1wIWBNbJFs7AFrIw3wpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oB0baXEk7JLAhL1KQ1b09nAzB13Gj/91WO5jdhMQoqZR3SXvBjQIbdaWh1q3?=
 =?us-ascii?Q?+kbREmXb5WZflK6zcFzI09w9gxoU8QdMUIehg1EnlB1EzyfSczfyzCpeV/Wn?=
 =?us-ascii?Q?VlgBzKfT0Z8bn93akTk0i0iVaa379mhDCqbwYrBcIwTr1LK7S2ayzuQEp3DR?=
 =?us-ascii?Q?oZ2Wem7QQ1E9F1SXFTJ7qew1m+eD4PLstwWV+0tqrIkBQCrbyJuS5VBx1+9+?=
 =?us-ascii?Q?3SfxkOaZQHydGOc0raSVCwKOKb/Uul1nh8MvdwIp5bxujlGxoCE0A6npvlcq?=
 =?us-ascii?Q?zN+oiYkB/xZCkSO/pqkA1VzuCnJRk/t0u5gsk6rw8/fDOD/WPaT9O6/exICo?=
 =?us-ascii?Q?wofmIFtnHJdAkh756/9w7UyLiT75fs6TI3uN7BwoZoTRl3LfPBy11Vt4U5TS?=
 =?us-ascii?Q?/MRj6e7r6BOMgHyy/WpHVCPnMHkUwvTBwBYwvpuUJxw14JB+Reyr19+4sfIN?=
 =?us-ascii?Q?haVSfrCuSXGtA4JXUkSxdRQo5bt0sng1IUhqP3XzNw99f5SS8N3RoMQea0HP?=
 =?us-ascii?Q?ZGt/EEMMs/2NTayICvIE8ry2ExaGrPkbBFKhGWemyABvEGdd/4we1cQGVJjA?=
 =?us-ascii?Q?RoU0VzrmDSA2NdaLbKG50dBioBb+8o1NudWfD/IbZZmBbBtl5Wt6s49O0x+X?=
 =?us-ascii?Q?AvLzFcpHdcob8XPDgmsMqUCsKcJMuTYv9TGVptRrI3mAoTu8a253S8O96lFv?=
 =?us-ascii?Q?QRC3XwNp//dXbX1SwhcGxtcEMTNk7u8vmRmgAMIPUhSRV44xPDeeEXIx7wRV?=
 =?us-ascii?Q?a/Jel2uKEisP/MmQrkN7hBp8flXSKeVKyDmwsyzUbwqGgY7qlVMflB96q7S4?=
 =?us-ascii?Q?N5aH2wCoronDMVI2qnsT6Hx0m4o3Z4L+xa/sZkbzlCuk9EaASwMnUJrEjwJJ?=
 =?us-ascii?Q?KJ2cKJOeaD6XF+1r3Nxww2CMKRH1wbXM2tDK/zf+bCdyULk3KGCDV49jWUtL?=
 =?us-ascii?Q?WTT3UwVGmpp41Ys+6PgPvoxt/zGs7X+hcYDGaz6VkBu+pdiyHX/K0sxNfCcA?=
 =?us-ascii?Q?zbyF6IwT07nwo56rvvMqOKjB+Nlm1qwMa33XldhBhfHhQ5x4ut2PJwsjyefc?=
 =?us-ascii?Q?4bDY9Awav1l62gblQ2TtiBpxt2hNH0LPHU0HeGXQ6WxeRAt4PukaxmCjVLjm?=
 =?us-ascii?Q?INF7l60bdBijlkKN/ZHoOqy4/hfGTGLtFW1lcYJWFOgZqc6OMxnsC/N6Unyz?=
 =?us-ascii?Q?L4D6HkM7xVfr/VLP/PAZB9xojZAlsjy0gJ0xeMKic2j+prhHDyDCXlGMzjHN?=
 =?us-ascii?Q?7t3hjPN4LYL0FGaR7VbGlSUkNyez9Rtk7hLdHR+NklYTH4hBi9sqiEY3+DS1?=
 =?us-ascii?Q?OXPLpUaBnFVCxq/xTepscPNGbw8QCL+Y6W2nCIlKzixIklajZVjIutEAr9wm?=
 =?us-ascii?Q?O8zY8Pc1aDg/BSbYG7mT7DnFaNrZQEfPpCr8A397SduQmGR7xgglG0WtOk+k?=
 =?us-ascii?Q?6QZGB4ltxuo/z5eAqGLqzPf7kQSi0jK7au11geL3PgCADWIXCEQBG+cuT2wN?=
 =?us-ascii?Q?MjCNZpTtuSif1u9eaG5BnDv2CbOF/nnA2EcJ4+SEkiSOlRt6f788tivQWOQE?=
 =?us-ascii?Q?1OkozzzKCkvmUuw/rpuqgef7q/NtbnSCi+ifADUa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098930f7-a597-40ba-499f-08dcc6ae3b59
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:38:00.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIzmaNzXzOeD9Ey15aDex4tEFnewOvjcN5TtHEHU670LbwoE+zzS6TJpBH4jNDmFQtD2iNGqCZGeGGJXcZn/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

On Tue, Aug 27, 2024 at 04:51:49PM +0200, Guillaume Nault wrote:
> On Tue, Aug 27, 2024 at 02:18:07PM +0300, Ido Schimmel wrote:
> > build_sk_flow_key() and __build_flow_key() are used to build an IPv4
> > flow key before calling one of the FIB lookup APIs.
> > 
> > Unmask the upper DSCP bits so that in the future the lookup could be
> > performed according to the full DSCP value.
> > 
> > Remove IPTOS_RT_MASK since it is no longer used.
> > 
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  include/net/route.h | 2 --
> >  net/ipv4/route.c    | 4 ++--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/route.h b/include/net/route.h
> > index b896f086ec8e..1789f1e6640b 100644
> > --- a/include/net/route.h
> > +++ b/include/net/route.h
> > @@ -266,8 +266,6 @@ static inline void ip_rt_put(struct rtable *rt)
> >  	dst_release(&rt->dst);
> >  }
> >  
> > -#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & ~3)
> > -
> 
> IPTOS_RT_MASK is still used by xfrm_get_tos() (net/xfrm/xfrm_policy.c).
> To preserve bisectablility, this chunk should be moved to the next
> patch. Or just swap patch 6 and 7, whatever you prefer :).

Oops. The order was initially different and I forgot to rebuild each
patch after reordering the patches. Will move this chunk to the next
patch in v2.

Thanks!

