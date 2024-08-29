Return-Path: <bpf+bounces-38405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5E9648D4
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EB9B2585A
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3371B0135;
	Thu, 29 Aug 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LnWAsNaX"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D21922F1;
	Thu, 29 Aug 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942614; cv=fail; b=irrAIz1zPqQ742kBlOj1wXYvVxI6VryYoYAB74kJRwsz3riSCtQOP6ov1QjqcxIKrIe53X2FwXgyemhlVVTzb0FxH2PPryi2EsPoqsl91hKgRHF/hn82/ySRChH6DQh/9jlVIklGDDMb6xqTZjImdqznletrTYnqJeCsWM2xP+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942614; c=relaxed/simple;
	bh=EzzIS90MJ6LTAnnAgKlnaXk4INwgEGzP+tc1xSQAIs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mb3Jkn5NnYP7TqxgglkcT7ygPfVPxWteb2Ph5gLEdBt9udeKfd4R9HwvSjXbzb5M0swjo8qQRidq+ljjWoaX4VKNyGDf5N8g1OMy6wsVKqkD3RmgIqc+RA/R1mvRiyGzz27+XRzMjHa11LVP4zCr/SN73VsKQH/H7R3YXDLp8bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LnWAsNaX; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA2L1VCaIoWVDg4afX6ZewB+8d00ILuOkhlFzWgMRpB8wqCpU5fs2I4cWJ9y93B/OakwLOlniiHblWb8pmTxQYsNIgtOwjf6bUpK1wnqS3LN0CjqHx445KOJ8K4w+zV4poYn6o1XgyXPT75n8poNo/gC+SoB1pRuV6L1bB7zyc1GO553d1xfToJ/7kIeVXKa9lnroFI/zYM9wSG0iFSSwhDNmAJ/h7lV8Qt5FcjnwIK2GQkF3jwJvq3cv3iZzjLMDPsm9kmeXk5JvHqgqxZHe18QmA0V1dZzrVTeAJp9UDAtz4xyoUtDNcneHqobca1z1bXJ2kYv07PX0wNmdr4E0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw9Tjne0Uk/19mYt8IAr/t4/Ojo9jRowJTZExzG7hyE=;
 b=QaYuSLzgmVYETBcGQ2FDxzq4k4snt/3a7TPg+bZZbYCiiyff1opWTvPsuK1VmIM4b71ArwSyUbuGi//xg7umfUwIjBE35IKBYY27x2GSBSTWxfyOAGyMYk11en4e8xTPrlXM8wdI/gZB+KEgBzH4u3UTbDWONHjfyh/TS7HygrR/oqCyhNgv/khpxOUp19mlanMm8KwalWvJfgIVqS5JFeZ+218RVQfra+8XAb5aOZEfhPuRh9lDYrgj9RC1krTyYBc4f9+Tr2EPITvXr3ZWhj2UTAwWFtPNHYN83xn0gOjJ2mqlZ5QFWrttyIxi4DmUDkxbqVdw7WTD17XqM9o/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw9Tjne0Uk/19mYt8IAr/t4/Ojo9jRowJTZExzG7hyE=;
 b=LnWAsNaX6+w5R5jiIv5dQgyLlsTFgPZnwxVAT0GLplNUJUJJSinmXFAmMfLOznYP9b5Snzz6L5LbjqUnL/bPwviXh7fnd3PdupLGgGUj3D/PV3JyL8UZAJPfV7In1wrk4HkMuDej1Dntslux1xRQ0N4adl0UgEfu77V0ItcaLw9YN20B7shf37InleeR+ecQgGxw3N5ygV684KFQa3Gwl1TP4dnqm8UL1voBKbSN6ndLmaSSqFGq7mknVJ6Y/qd+FukYoXV7LaqdRMHmhKBpGI20cJIZBCN0ivcFSk94+0kSx0Nu9aCVD/bEobIBF0ph2N6oI/m8Ii+ldIxJaDSkeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 14:43:29 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 14:43:29 +0000
Date: Thu, 29 Aug 2024 17:43:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <ZtCJBR_XIn6H9EBU@shredder.mtl.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
 <ZtBb8sl1JnMHZ5az@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBb8sl1JnMHZ5az@debian>
X-ClientProxiedBy: LO4P123CA0668.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::14) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 78626e9a-7135-4443-ad40-08dcc838f27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnqiwkNcaAvzPcDlgAxv4lSOVoagzE3EurIH0HOyZUDCGoQSVPt9BdFakJyO?=
 =?us-ascii?Q?GIa2q/C+7ieHu8PXQ2cJGeEOo6KMMN0ekpRMvnllZB+buOByadWMXlEqfp4L?=
 =?us-ascii?Q?KUkJ+YuZ1WwjXOk3V7BnHAw2RIoXn57zLFU4kAcPW60HmW+cTIGVoVzIbIiV?=
 =?us-ascii?Q?LlSQJeAl1FZn/XD94NkMr4k4S2y+WlCLaGY9WQHL9M822SnMaGIYp7nI77Qb?=
 =?us-ascii?Q?waFRVxop9xRp0ByHKObBavqzhq5qbnAXuRKCqErxNuU0+Ba6rOIqIJcCYOL6?=
 =?us-ascii?Q?LBeFCD9haLN/7YlcgX2f/lLz75JEPCwyvJmttUbtTb+3/TJHfiPLeefFezb0?=
 =?us-ascii?Q?C9DcluLv/UREacF7nx56jzWqjsb0jq2/je+u9XL9+K/B/xm2wo56ttZy43EY?=
 =?us-ascii?Q?skT4tdjQsGDAqtYrKDBZW7pT95ExbHjT6fCbpTd10RjqG8rhi92yzyNHezX1?=
 =?us-ascii?Q?0cK9qW5eQ0ni7DXQ31QVz2upywJ0KiUUqwGLEwbVQ9gUOrayQ6zhlj6BkZ08?=
 =?us-ascii?Q?9uMzp4aBNORh23qzTlwHGL8WNvOROGOpILepOd923uw2hjyzNtdgowMNdEYy?=
 =?us-ascii?Q?hra5agF8UK4outpjKj2fFNIvSdDG14qwtvdquOr70eVnG16tb6MPhvPxZNPU?=
 =?us-ascii?Q?ZdefQ6mF2iIqKVaWtx6t6ssD3UBh1ZCIdVL+BToLF3RD3+IsYmvbkY+N8f/G?=
 =?us-ascii?Q?PaA9fPqDkx2Kmq9yfEn5SGl3VBloDDZdsc4GszIiymcoop0k8WnWEzEYVzQt?=
 =?us-ascii?Q?8ym3vRxpvlvDbrKt1NgpEVuYPK3D6PXKHbBz5TBMPnnCKjHxpDVGzAuWojSD?=
 =?us-ascii?Q?NOyy0lsiFPtNUwFDjQDmeyjj5TCPCAT/nU4tlcK2abK6KzSDS5Eh4ZxF+5HG?=
 =?us-ascii?Q?0KFEiV9LF90mRX1TCp5nJCyb9CvvbMCr4cVk6SXqHZbSW0xXblI+MEDVEJGA?=
 =?us-ascii?Q?h0CIATzXPXHlp+KyEny9va9g3NR79rM+ablpYFWdGSTGeRqzWGw2yd42y4A8?=
 =?us-ascii?Q?w/65vS8NUfyHgLDqc5PcvB5u260yviGTAUZFimHo0Ozpoz0UeWLTIWChaAps?=
 =?us-ascii?Q?MiiGNKPjrpDUSBVh6BD/FpcRI88kiBmRRCoqoTYJwSCDUM3ce6HkWI3kBnAW?=
 =?us-ascii?Q?44k9ryh8FkWgoXaaT0UEyVJ8A2eiRn1GdhEj3fu3YgfmjFknTKSqoXW1NHIv?=
 =?us-ascii?Q?OgMWOajo5sSIHPlVvtX5QqhsSXjEfyfxkaM6q0U0dTTRXFlfS/fVjMRL0pra?=
 =?us-ascii?Q?QLmw72dmecnUHoI8g/NH5Sz8oPFdIRn1RM/2DkzlsGTMfjoQm8SNP3o3LLeO?=
 =?us-ascii?Q?203y1vaMmnnc7e2l/jrGH35IRCelhj1cNrR/6RJ+PwXNN/jLWZPx24GjnoxL?=
 =?us-ascii?Q?DdvOru0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYEv8lxxW2DAuqcUHCZl/ozknba+tFb1Qg2Xc20KmyPRB5MZxsNLu0b/QMTR?=
 =?us-ascii?Q?FfvExXSkEfuN15eU/YUxxocDHdbNAKK/XOpm9L+ira12/zAhjQ98ucyotbgv?=
 =?us-ascii?Q?2/fOFc2/cKSz2R65lubHshJJU+azIa4AwzGunS5rD6CXJd3tOUl/QJ/Fxbpv?=
 =?us-ascii?Q?/SdOGfzw7zqL/77Bz5gFrw5JVUN6/bT9nlpbpDZc9GdrxCVpwEx7aovMtAx9?=
 =?us-ascii?Q?qf22ds68UtUh9e3VnisaW5EIh2X0GqeknkkX33VYWsm0H0NlSES372XdGd0z?=
 =?us-ascii?Q?XosHK4L8IRZrUYgschLQRB7HWciHmGruZlUB/OjgbQbiKlJ9nWCplXraTIe0?=
 =?us-ascii?Q?4+cL4fxmGHcAh1U5DGHvJZT8qkcAnHVrsY0g2CA3prXdi5pJypXlPsVIoemV?=
 =?us-ascii?Q?yoh29Ol6RCaL44P+wLw06l52x9ckZ5HhO1DcpPMCMyPKhvIi6ENKJ+//uUez?=
 =?us-ascii?Q?yUvxoK/zQRLc114Y+Kgr3qhN3O3I5KdZSz3XGZjPlx0zyyQhqVhmC0J22LG+?=
 =?us-ascii?Q?dl1vLITGn8mbGh3mUmYGu6aSbQN2Bng2AIjfDWIEFXzqwvTurzWkRuSt/e5g?=
 =?us-ascii?Q?1880EjH4F2T8v22gP6XlRXFkMvYrMboyUqu5i5gUNBQWxRmiELVEyJ0AO+7m?=
 =?us-ascii?Q?gcvF1nqNGra80e/U0WE+v4ZtFnLz2Ao515FWMp9vY2LQn6hLudPaFJE4HWs4?=
 =?us-ascii?Q?7WSc/rjaVftRKjZL+mSp9LK7siFE5pvq/HbD79N/bUBA6zyZ3oQQ/vzT+Hp3?=
 =?us-ascii?Q?92puTCKpFcmlq5LqCiN/L6033iJDjktfwArg7r8hCSf7esSg0tv159YyvB4A?=
 =?us-ascii?Q?RWnO1W3lW4D3zixDhDdDliOXl8Lini69LBcz4xzOp0iwvHZvlcGamdLQ4XId?=
 =?us-ascii?Q?5RS7QsGW1U9YhQHXV8zXnlzVYUnzppMToXdtgyGz7a+p1X1A9fNj7jnE8BXd?=
 =?us-ascii?Q?2uvFL3EotiQdtuhupJSdLOiwksIvq/iXOZSD0J58lOyjww9LRLb7BWsYFPbh?=
 =?us-ascii?Q?AczfqjKbfbxctrT6CWh+9cGL1kteZCOFMROUgFcqjoH1SYdci3OVYOOX5to9?=
 =?us-ascii?Q?f2F/8ra8ut1V487N5d49CW8iJPYySqbaEaohenUWOkdJ/Iy/etfVSdySl7Tn?=
 =?us-ascii?Q?s0yHtYdlE0A+1EPAeAiK+WrStnvTabjNfw64K1VpibFolq4ZuaQwGBWbeaLh?=
 =?us-ascii?Q?0v7plDl/II8LDe0iDlREEdv8V3ncE6qI4SiYQBxoEWeYg99xmxo2Vkz9kpJP?=
 =?us-ascii?Q?EFSwpMPuI2YPBD4Ejhiiv0xywjuzaKJZCXB9NnJvXygBO+UcMVFmb+46oQw6?=
 =?us-ascii?Q?dXYHNiydqgImBfqC4Krd45Hv/dE1M4KJJW4qV9G4bkDH+qHYxH8NITjHdPys?=
 =?us-ascii?Q?NbvvwiG3jBS6n+U9IWIL5lk1inFPbnt6EN2kPHEivkgsy6uXAnOgJ2r8JNic?=
 =?us-ascii?Q?ZpX74one3ZdN10jrqCMI4ZYuY/TXLT+L/mdYTHB7Do3yUqcauv8af0qS0KX/?=
 =?us-ascii?Q?sF1am20V26xgilhm+gU5DbacjvSjgy0GoWpIP6BGp6+sZwSoyigmxBnYHmb3?=
 =?us-ascii?Q?HSS2DoYKS/hMovW10LtlpzvXAGDzoOf+8mLugELo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78626e9a-7135-4443-ad40-08dcc838f27c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:43:29.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9niHPnwNkOnsFlT9gRjY5Be6VXr2G7srcwkYgT6txWxCVMH0pKPDWZIChZOu4pP2nLoxzss1T0XIUOSmH2jJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169

On Thu, Aug 29, 2024 at 01:30:58PM +0200, Guillaume Nault wrote:
> On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> > On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > > 
> > > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > > lookup to match against the TOS selector in FIB rules and routes.
> > > > 
> > > > It is currently impossible for user space to configure FIB rules that
> > > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > > various call sites that initialize the IPv4 flow key or along the path
> > > > to the FIB core.
> > > > 
> > > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > > 
> > > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > > don't need to keep any compatibility with the legacy TOS interpretation,
> > > as it has never been defined nor used in IPv6.
> > 
> > Yes. I want to add the DSCP selector for both families so that user
> > space would not need to use different selectors for different families.
> > It's implemented in the patches I previously shared:
> 
> Hum, I guess that was a misunderstanding on my side. I read
> "adding a DSCP selector to [IPv4 and] IPv6 FIB rules" as "adding the
> possibility to match only the 3-bits TOS in fib6_rules". But your
> fib6_rule.c patch doesn't modify fib6_rule_match(), so I believe that
> what you really meant was just to add the new FRA_DSCP netlink
> attribute to IPv6. Am I getting it right?

Yes. To be clear, you will be able to use the new 'dscp' keyword exactly
the same way with both IPv4 and IPv6:

# ip -4 rule add dscp 63 table 100
# ip -6 rule add dscp 63 table 100

Mixing 'dscp' and 'tos' will not work:

# ip -4 rule add dscp 7 tos 0x1c table 100
Error: Cannot specify both TOS and DSCP.
# ip -6 rule add dscp 7 tos 0x1c table 100
Error: Cannot specify both TOS and DSCP.

> 
> > https://github.com/idosch/linux/commit/a3289a6838a0d0e6e0a30a61132bdce3d2f71a3c.patch
> > https://github.com/idosch/linux/commit/ff5dd634fb278431b58437654d7f65b57fd4ae4b.patch
> > https://github.com/idosch/linux/commit/3060ecb534475eadabfa1d419dd64804f0bd0148.patch
> > https://github.com/idosch/linux/commit/12ddbce4f519b42477ea1e130b6d2bab1cca137c.patch
> 
> 
> > > > need to make sure the entire DSCP value is present in the IPv4 flow key.
> > > > This patchset continues to unmask the upper DSCP bits, but this time in
> > > > the output route path.
> > > 
> > 
> 

