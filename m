Return-Path: <bpf+bounces-52161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB53A3F123
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0791888E62
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD5204C0D;
	Fri, 21 Feb 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QU3Oobwy"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBAD204694;
	Fri, 21 Feb 2025 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131820; cv=fail; b=FQTKMU7V0uL9WKmlUWhyOAgDKIF7z3dsIWWd15kh19zGGNdZDHi6/nU+zS72qoqmDhjRWcgNpUzwDig7MAWAk2HZ9eB38N5XPFo6OkjBJ0aRMdI38Tm6PFkApNLkthMfx6gSxjlGo2WfpyJrArzGHT9j6v0Y6NYHhXvSeqOYJ38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131820; c=relaxed/simple;
	bh=2QVCqWtvu6MBAKfFWuAx/KENkqyAj7F+o2xX6WaQi1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+Rgms9fTTAEral5SSdpp+kMwJDX+tD2hjROLImW1faSUaifAtbFEutBmjSWN9s32rWeLTs8Pc1WYEuGm6rp4F7ZmCzqh8mqqpgEQg76T4kiklAHpMvbK5z2wtDHaFbsD1Kalk/KEqEXNN8U1nCFBWX5mCmZcClFrG/oMwIXMa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QU3Oobwy; arc=fail smtp.client-ip=40.107.103.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvRbwSqXqSKi7G37KKY+RwWE4qn0ZGw4DnDzhRDM2KTTxyRITK3Dn3FiLyH/7K772Q7EPCBW6cCkDtQkq4wvvCICTjYUC00Ym2sx1W8wOuNOoDo8bD+n9SKwTC8DlK/Mb4esipWixnK5S+BrilE+JqCneB+EMH4dN70vEkpqA9vDGl0BZD7V7Z333CWoCU+1SbZWmutS4nD+5BZqNhEMwJK86yIWarEoUfgghBgeDesaN2hp0aGbLsB2J4OkdoWhVchDYYU8/ls2Y5yqb50WSZC+f/Dq858S0cd2ju9bOfFy6BPeto09FJQQ+DRIWtS8APUc7Ny1UbXZVj1B+L8n3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWoaYZioXOXrcY4QWP9oFpmevY5Au2la9gRcxy/mpxo=;
 b=NlZKCesqIz/Dl5RMLtz7DFG7M6CSCG715ZoGYmYVzp+MRVPAvuRuudYs+ahenFbH9BBiydO9N0Rt1JkveVpP/J8qrGj5+OWHj21Tu8/vegAvcis/3e4OUe8niA8zHfz9sbQn1QHyPnoQdi9OT+dEH9MO1t3o1KTqy3CveqdXBOmi0Mvk+0xm6jXRxHt7PpY4BzfImk5XsgEKEeBZCfT59KQ5euW+mU8xpFqvtaJnaWG3SlwuCSTl8M64Y3fMVg93f32TR1OCs3lh8NhrVF2BsMyTr/YNSFhdikQo8FnjlPSwHkdqvctIeK4VBphVmf7qdQiuURKoLQp2fzHLv35p/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWoaYZioXOXrcY4QWP9oFpmevY5Au2la9gRcxy/mpxo=;
 b=QU3OobwyTrHzCVsKRUMOB+cRUyOUEeq9z081Ze94r1YIuGl4RhUEejFM/gHAromXpwjN3Yfd818YBN6PNvzeuJ9eq3guxWee0/V51FN2j5D36n7jhH14BN2aKtoWAnDu/jNoL6ehkMGZ1L72dbHtbTYRcGsCwk0cymF+bn+okWf4g5svVUwnp0yATHK9MtJaYNrRpARYtnH/Go23t9c/N5PMVuX9ohYN3tKxm7SSJtw/J5S8KA5lsWq68/VxqcqrLmzDB8prRiDBvWGw+nJKDHVNs3/rkpw7lQmlSmuiEk01rGtIIQppFIfy9UYzl718BFLPgS3IP9AfGqrPcwlFwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:56:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:56:55 +0000
Date: Fri, 21 Feb 2025 11:56:51 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac
 verification logic into common library
Message-ID: <20250221095651.npjpkoy2y6nehusy@skbuf>
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
 <20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
 <20250221174249.000000cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221174249.000000cc@gmail.com>
X-ClientProxiedBy: VI1P195CA0074.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::27) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af42d0f-dc04-4714-3bec-08dd525e12c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jeFcrZKXuc3+feDn8YZ1ZHelYrz5vj6ud2IMuBJsH6NTdUUY7ZtRDXijMeXr?=
 =?us-ascii?Q?uuOlR+SIFX+2/Yba+OXFW/ETPj0b58yBZ5ivrlCm5DL6J9iocIwqlSUn0UUI?=
 =?us-ascii?Q?CBPfQ6LyBd384BBn2lXmr4Vmc0zCLlDGg7aqWXxis0aYnkEnmNG47UqVk+6k?=
 =?us-ascii?Q?o3Roy7C3cryBzwe0EGSnEKl73+qmxEV6vWdIBhuxvXvltAzphMFMQbEGockw?=
 =?us-ascii?Q?3oeli43v8WXbk7Oa2TX96U+oQ48OKwVmCouXvs2T6NJ+mqErifs8H57cC4WG?=
 =?us-ascii?Q?T69l21TXAdTirCqzPrwSCvqfkwZ6lv14L0m3gU8Mvtiex099d9qPhjSx9ndQ?=
 =?us-ascii?Q?5Apn8UpIMjak/5XHwJIWLTtz77FpNjmWAA1ypJIyFXveNj+AHDsK1hUxBCsf?=
 =?us-ascii?Q?jsv1rwGFmekhZt5ymlRLgfOkZ/bS6iPdDd9rADLKptwLKURbgu4LaXZYz7aa?=
 =?us-ascii?Q?oYMidnjjS6N0JknspfvhKkdOCprj5vEXS0sGBQBGnXnQjLMZqvzvi2lEXJnZ?=
 =?us-ascii?Q?Q38QGBam2eDQ+lZf94yhNGA5YEnCt/cs96XssPoz//vlgyCV6Lke9T7WZcDW?=
 =?us-ascii?Q?08hxqvcMNSsii+wGzKQ38uxZO+OJfAlLq+DbHEglQHhEMAptmW3VWZfuTpuR?=
 =?us-ascii?Q?6WdYddQdOGqzUyBS0Msv/RqEAlDwoHtSlsyRNxVAxVk0jM+FhB543PMD9rYU?=
 =?us-ascii?Q?Mi7tqA9TdIMelpXqGLIvF2hMr2opjXuuttsQq/Ml/MZXFKKoo3DPa+BArkPD?=
 =?us-ascii?Q?NwtFQFldZuF+0rU5kw55WOfb7ek9hrYFglUsnngScaa8SJAjQwuwfYLflIjA?=
 =?us-ascii?Q?XCe3XCIr8p20LpiL9IEJquQ1eRliE5qlDNgGLGa58SYkcVPRikvlpbtIsdB7?=
 =?us-ascii?Q?9URxCMewCPnQJmpa5nuKsiYlC3LCX61Ju+ENXKTAKU5bBIsgk1c7UAdzbE5H?=
 =?us-ascii?Q?yy8GrfPhMn78oYl/1ua/Y+EvXbj4KNg3F6vSdEs6MCX/t1QtaV4F7OCDenRi?=
 =?us-ascii?Q?Aic/f8udowk+gHHLWWd8SnmO9oYA5J0zbF2Q3SY8QO0UF66hvbxtPfGl6qVh?=
 =?us-ascii?Q?ASQZxfyogA5EUBi3Y950J6F+LqjkHNAYpDmKSf+zdenwYULIs6cFbNRi+B5T?=
 =?us-ascii?Q?B54AHE90+2vwJdNsw+ndaySSqGp6ktIfD3MHabZvKtOu5AgRLGlmcgI374/6?=
 =?us-ascii?Q?BpusoeYl6Up9i8XsITbuI1F6iQeOeTHVK9yLGwtqeEGB6x2u/kyqE6/EEjMW?=
 =?us-ascii?Q?vd8hDy8EmkqbGzCJvuq/jXlidWkiazApfNnn2X3enSaLYFRba6eakFVfx6No?=
 =?us-ascii?Q?92PerzPTDm2Zo4YuWbZ7Tv8faie0xeG/zzs0MOCeSnloCnZ2IFpMzgs0bNIh?=
 =?us-ascii?Q?DHcBvWblYpArcref8x9tdDtmE4+s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xR/oaMyX+PCvHydi5wiCKu3ZdrfikcBuBGf4x9m3+zoyFAMD4JH4XWfVgTXK?=
 =?us-ascii?Q?RBZERHXdswthRQhCFvY+rEUJ/UlCms+HERhDaC20Hb3lhXN6QYDHincom817?=
 =?us-ascii?Q?D5N+5kSuyDI3yqNVtUVh/8Oajh99LVzDQ4PF4OQCqojP2c+np9Uf3cVfpK2s?=
 =?us-ascii?Q?T5Kju1ucLFJgXUlxLz+Gk/LJhH6jNXt1bYPoEyiGWdFrS/o3z7mTupCKrdr6?=
 =?us-ascii?Q?jpfFH9bUtrOphV4wVUDWKMHea8N/gUYz++cDwIeQfFiRDXWKZJgvD58Z6x9V?=
 =?us-ascii?Q?F7cA4RT+wuFO8/wuIa9pQF2xGHDVqplfkVQ+fwyb/Y2y+vKPIbym/nHQ49lq?=
 =?us-ascii?Q?Ce5ELnqqRSlctvzIEgPI0MIyEV+yMyBtAoC11MZLC0CtBX8HsGaulsz7ymye?=
 =?us-ascii?Q?QJqhEPodGPDjk/G/Qbz6cHjyRrqO7S6Y06pfelozUZ/2PylXHcMFex+ygq/j?=
 =?us-ascii?Q?8v5Sg/pl1T2tB2zRDglOrH55ywAut3O/5oOGUQiboK3W8nDkqlPlczUf2DDI?=
 =?us-ascii?Q?BU6zJY83su+VBcAYRpoHG6iMZTPYldHVTfi/MG3X+YiRjRKJa8I26caWr52e?=
 =?us-ascii?Q?u7+79RNHJshSPWGnhMEHWKLPOLSsuZRJreIVAwSHMLE7pUmea+qoDtitjIX0?=
 =?us-ascii?Q?uGvmafUj+Gd9uR9RjxrtUnLIWbN7zX59Xq668dc8bzwC3W/73T++X9GNEfdW?=
 =?us-ascii?Q?2WbW1LZ/WAtLBT4quDmQSUIivjUaBZg2dqFj3gj+E1bkoW6CKEDTa7a+taqN?=
 =?us-ascii?Q?di+jzK2GpNL08d/tMcqrKUhkaxCHJ/pu7Q8vvPWGukUi0vzDIgEbSWcAB0Vd?=
 =?us-ascii?Q?te2EcfKMwW/3k/IFyB7iDeaVcWt3LGfrrfOncpUil4K9XmI9s8djuujZbjMi?=
 =?us-ascii?Q?scPvIU/q2m72cZPRUKfPbDbxqlSoeQkP6qoVcQ/pUHeUSIewpY1Fg0wQMzDX?=
 =?us-ascii?Q?np8wQVqXwbUobGjCa0SkLPU5hEPd7gisSpVNFQmVTFmpq2VWwUJ69MwMAK9L?=
 =?us-ascii?Q?PFXJOf8Xieyx1J7h6C1d1GZwB5io/4KyewRs/1TNWEDSMo9j8rtvHZCvpNzQ?=
 =?us-ascii?Q?e51PY7Dfo5wt7UvgQ7XML9xR80PFcRJ7MEpgUCnjk79ELWv6Qb0jqKQIoBtU?=
 =?us-ascii?Q?qMqwFjR/eRc5vQKrZ9bFlpdLjUi20cjDK118ElVt+YofRkZfTn3KS/rp/6AA?=
 =?us-ascii?Q?OaGR7UBnkIgdQUlem3C1YkSUXhG3TwmZDw0SBvQjHTcAFCIlKa2yllZj+x6z?=
 =?us-ascii?Q?wgkDdfLRrmr9m9fxVuyVTWlFJLVQ8tz05aYz8w6Gpv8Fdu92IHjgGkHkGRc7?=
 =?us-ascii?Q?CgUh566GiDv41ik+M3+bHFkpUZRsmURWcT1nRc73xuwG4ojgob4cgY/76JWA?=
 =?us-ascii?Q?GkTcdiem2pHsOY2CybYjKXCePsq4rbDY/aqLEAS9ytrb/2qSZn+OfXWo8N3B?=
 =?us-ascii?Q?cmgwZuhuHgfoUOPygnftOM2vNZ2xTIL3IGv+Viaze07ifziyuhaj7pktgukX?=
 =?us-ascii?Q?OuKxemO0ExLNIDoOWP0Gj8uAW2ENZGa7fusVVhKp9sF5ifJe1JZPWO6zlQTq?=
 =?us-ascii?Q?6KAumSmnYfZaJXfuaLOtatBPwsTJ2ymK+h8Sc1uL9a2tsy8+eCwrypqBtzlT?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af42d0f-dc04-4714-3bec-08dd525e12c4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:56:55.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWzyImesAG3oY+54AMS43JHrCI3vIuoLy0GL4u4+RnvJo2NYtUD4e/Fa4tLhQrPBy6wIu/uZWUHp+SNCBVVg8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

On Fri, Feb 21, 2025 at 05:42:49PM +0800, Furong Xu wrote:
> > +void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
> > +{
> > +	unsigned long flags;
> > +
> > +	ethtool_mmsv_stop(mmsv);
> > +
> > +	spin_lock_irqsave(&mmsv->lock, flags);
> > +
> > +	if (up && mmsv->pmac_enabled) {
> > +		/* VERIFY process requires pMAC enabled when NIC comes up */
> > +		ethtool_mmsv_configure_pmac(mmsv, true);
> > +
> > +		/* New link => maybe new partner => new verification process */
> > +		ethtool_mmsv_apply(mmsv);
> > +	} else {
> > +		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
> 
> Tested this patch on my side, everything works well, but the verify-status
> is a little weird:
> 
> # kernel booted, check initial states:
> ethtool --include-statistics --json --show-mm eth1
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": false,
>         "tx-enabled": false,
>         "tx-active": false,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": false,
>         "verify-time": 128,
>         "max-verify-time": 128,
>         "verify-status": "INITIAL",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> # Enable pMAC by: ethtool --set-mm eth1 pmac-enabled on
> ethtool --include-statistics --json --show-mm eth1
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": false,
>         "tx-active": false,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": false,
>         "verify-time": 128,
>         "max-verify-time": 128,
>         "verify-status": "DISABLED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> # Disable pMAC by: ethtool --set-mm eth1 pmac-enabled off
> ethtool --include-statistics --json --show-mm eth1
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": false,
>         "tx-active": false,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": false,
>         "verify-time": 128,
>         "max-verify-time": 128,
>         "verify-status": "DISABLED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> verify-status always normal on other cases.

Thanks for testing and for reporting this inconsistency.

> @Vladimir, maybe we shouldn't update mmsv->status in ethtool_mmsv_link_state_handle()?
> Or, update mmsv->status like below:
> mmsv->status = mmsv->pmac_enabled ?
> 		ETHTOOL_MM_VERIFY_STATUS_INITIAL :
> 		ETHTOOL_MM_VERIFY_STATUS_DISABLED;

You mean mmsv->status = mmsv->verify_enabled ? ETHTOOL_MM_VERIFY_STATUS_INITIAL :
                        ~~~~~~~~~~~~~~~~~~~~   ETHTOOL_MM_VERIFY_STATUS_DISABLED?

> Anyway, this is too minor, so:
> 
> Tested-by: Furong Xu <0x1207@gmail.com>
> 
> 
> > +		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
> > +
> > +		/* No link or pMAC not enabled */
> > +		ethtool_mmsv_configure_pmac(mmsv, false);
> > +		ethtool_mmsv_configure_tx(mmsv, false);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&mmsv->lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(ethtool_mmsv_link_state_handle);

