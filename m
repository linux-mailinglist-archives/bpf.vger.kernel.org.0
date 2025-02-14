Return-Path: <bpf+bounces-51560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F30A35CB3
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 12:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D023ADA2C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F54263C6D;
	Fri, 14 Feb 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dnHc174N"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664D262D11;
	Fri, 14 Feb 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533104; cv=fail; b=FOUeQCItLzPzufauNRXeHRqiyxWZYhHxJw7Bi1cjoefFf1N/QuPF9g8Wjfq8mF+M1qKHFucbSAGddu6aqooK/35MhXinAzZ3yU18m+aRTXZcEwXbmvOGGcMCqSSp0lwbHGPbuI3f/xSGLAQWG49oP5MGHbeeJeBdF5NCAgfmyQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533104; c=relaxed/simple;
	bh=yLbPMuLVk8Qk8Paa0RTfoiuPc/0vN19NH0kDJjR8Ggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fmx5i/TLA84hhsvzadaoQ8ON+AOoD3jFX4+VTtEJZvzMslsGmtBNCAB0Slbm3GNSCTFVTOrNFHJptafyP0sC3HFylml5gLj2wTPn7nP3tGqBFIfKbg/QvtZGsJ3cw3S2NKPa0ifz8n45lPFhGJniORGjGnStW8z+XDuNkWYgF/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dnHc174N; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZQZ8B5rGiaPtnUtBd/ISpDbABvaSIKXpHsDARgLfSKfZmhtHoEfS+InVp4NQ4f8JE+YL2dFGmXGNg3pKfl4vDtPp6jN4QXo/a3RF6lrg5ySKbaMg+vTNdT7gNmU9m6Wnhk8olZUUbrZAhPxF4aIjoq30XItxqIgUwrLKWXX5o379jxEH/L/eH8hHC9EK6kixHOHMUUf/LsSABcKFRpm+Kw0BCkLyYUNNxDWXg+E0kvZTDwb1icqvdYE1DdMeUtY1PppMJHBJhB/8+/qlSVm+fFYva8Bx7kgU7SAXVpbf70nRPW/UCq36G/2VBZXTZzLmmYgwbSeItwUPybIycEfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLbPMuLVk8Qk8Paa0RTfoiuPc/0vN19NH0kDJjR8Ggw=;
 b=O+f/KyrPw0BmFNFD8OTpuIN9ysf6qO32yzRlP3hPy2bDLPV+jzDk5yqRz2vvc/neblxvPDbn+tH2j9auq1wHGkMKznjTEJUxTU2r7l6G1pJzcZXFdgeB0kwq0PE71fHdpfsXlpD7JRvwRenZUDFYc2EJ0NsTqvLt1QEveywq0aZQlK398E78I2vGmLH9lqLjIB4vMqggqs9aZWRXhncjYm16I5nutNvosKOQ0JQaESoEX17+ap/DXo+VgZeQb5KiE/eEnWJNCE7qIHwzDDPqIMic/iqdZqkmJKtvdDg1G57rBnBuZqSvGhCqrKa6oL6XYPos3zd3Y8ykJ1SpGl3JWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLbPMuLVk8Qk8Paa0RTfoiuPc/0vN19NH0kDJjR8Ggw=;
 b=dnHc174NcxvTcxv4gMMBhhc/zIOD8GBqAs48g27sU1XTQrGVcjlHoJG9hHKsd8eqdELC0wzfNBXy60PyQEC2zyh/19uI8FkJHctYoIo1eeiVa5jNpSkF4QbN37yYqulA4ZfsHGThzj7PpXrs7KAP8UdFb2gcuMbcpNHi+Uizd0L3vkl5tr1yOuxkqvcrOGGWC2e4dMbzLAlVuqJiLXpfOfbYmXBSOlzLhSLwBqpmvJ3lmVcxxTAmCGzTzLraqKJyIPrM/muYhg98E2fkjvi8DDUKQ6T8+kNhLuO01clp8XV0Z+gIBsMmhYGS43Slc3i/b0W6XmbFfMqhJ5nQC7YPpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10733.eurprd04.prod.outlook.com (2603:10a6:800:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 11:38:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 11:38:19 +0000
Date: Fri, 14 Feb 2025 13:38:15 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
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
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
Message-ID: <20250214113815.37ttoor3isrt34dg@skbuf>
References: <20250213130003.nxt2ev47a6ppqzrq@skbuf>
 <1c981aa1-e796-4c53-9853-3eae517f2f6d@linux.intel.com>
 <877c5undbg.fsf@kurt.kurt.home>
 <20250213184613.cqc2zhj2wkaf5hn7@skbuf>
 <87v7td3bi1.fsf@kurt.kurt.home>
 <b7740709-6b4a-4f44-b4d7-e265bb823aca@linux.intel.com>
 <874j0wrjk2.fsf@kurt.kurt.home>
 <641ab972-e110-4af2-ad9b-6688cee56562@linux.intel.com>
 <20250214102206.25dqgut5tbak2rkz@skbuf>
 <afa50e3a-914b-46b6-8401-0589b6099f68@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afa50e3a-914b-46b6-8401-0589b6099f68@linux.intel.com>
X-ClientProxiedBy: VI1PR09CA0123.eurprd09.prod.outlook.com
 (2603:10a6:803:78::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed60cca-c3ba-45db-5c8a-08dd4cec147a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVHZnNTbDMzUWErTm9icEJWSStCL25aTjRURUtldU0yeWNvbjA4MTNVUTNw?=
 =?utf-8?B?c1BXT3IvZ2t2b09TcDdIRjVvczJ6cldsY3JQYWlBSk9sS1RLNllEbkpVN1Z0?=
 =?utf-8?B?ejF4eTY2ZGhZS3JtYnRNQWgrbzJ6MmJSN3JXKzg5TGluS2ZkckdBdGNkbzFr?=
 =?utf-8?B?Zm9ZQXlhMUo1emRYYUFWRDh2RWc2Wk5QM210REw2czdYZW44THo2Szg2QzZa?=
 =?utf-8?B?Nkh4dmY4aEhTaURBM0YxOGpmRWgra05JVmVXWEdtZjBVMTFaRFdKbTBNTjlS?=
 =?utf-8?B?clQxZmhnbDd2clBtOEZDYk1WbUV0aUt0YjF3RzBoUG5sUiswU0xKNlJMbWxP?=
 =?utf-8?B?cnBTNGxlYkpwUGFHV2lWTHg0MG9EWUdVY2NXSG1WeGhGYnB3RnFmemwxQlpw?=
 =?utf-8?B?dTdqSHBkUGhDVlF5Z3ZhSnVDRkhBOC9nYUNzUXNiVExsT3VjNGpZc1haOEZ5?=
 =?utf-8?B?a1lwM2tETHFRV1hBQzY5Ulk3bVdOK1VwY2lUb2ZzK2ZweCtROTh2QlM5aW5X?=
 =?utf-8?B?MlpLUjFPQitRQ2REM0Z5amlaWk1uek4rWDl1ZEFrLzVTSGpNK2ZEMHFMMk13?=
 =?utf-8?B?WDlsMEVVSDlESHlGQmxLdDhRc2F2ZC9XUnpheTNlVHJPbE9CTCtCVEtMbFg1?=
 =?utf-8?B?dlhaWW5IdGhBaGhuWGJJSjFEUE1mTVY1bmwwazBBVjh4NjRvU2dTYjN5b2t4?=
 =?utf-8?B?R1JwSE5TdmY3UmxqbXJHanFsUjJJZ1ptMEZiemZWOVYzWlZTZmJkWldlR3hO?=
 =?utf-8?B?Wi9hSU1HRmRJMFh1eGZROElUQ0YreHl0SytMMUIybW9KMXVQVEJGREFiaGRk?=
 =?utf-8?B?QlZnZVh4S0owOUxmVFJpY0JQTlVqaEVrWDMvem5KUGNRYWxDVkY0Ly9yS1hP?=
 =?utf-8?B?eVNSaW5Fei8waVQzU2RQbmNMSUcxNi9hUXdoTkljZ01JOGYwQ2RmSFo3VFZV?=
 =?utf-8?B?TUpDTmsxOXBRS1ExbkJXbWlhdER5d2EwSTN3S1IxNGtpc1RSRlE5NWYyWk5o?=
 =?utf-8?B?UWVQMEt3ME9id2ZsWnpicDBmaWYzeGhIWmNCMkpXTEZ0WnhXZUxJNGR5c25M?=
 =?utf-8?B?NkdTckJWd1FNcWV3c2xlZ0huQ3pCSE9FSUVXbXUvQ0FSeVR6bDV0ZmNGK3RQ?=
 =?utf-8?B?VEYySHB3eGtPSXZUTHZrelI1VWg0TkhscU83Vk1laVl0SENSVENSUllrcExL?=
 =?utf-8?B?SzlyRFNCNEsySVR0cHVRQ0hpZDZacHNIVkxyRDJ3V2YxY211Z25JdThGUGh0?=
 =?utf-8?B?YkhBbkl6SXNONkNRSFFPNDIrVEd5dGVTZnEvdHZPWVlJdGRxUW1qSXcwK1Rs?=
 =?utf-8?B?Vm4rZDRYeXpiNWRBYzNkc1RjcXhiS1dBeHFaTUZrOEJNblREakFCLzczeXBa?=
 =?utf-8?B?OEVWRmU2YzgzVFl0cnozeGxqVDF3cXpLNVRqRHRkT0cvQUdhdkp3b2h0MU4w?=
 =?utf-8?B?WjU2VFg5VWFVL3g5WHdKNlJZSE9qdEEwdEdJbVkzYm9XNWFVa0lHRkUwSEtR?=
 =?utf-8?B?dG9uMFVBUjF0TUlWZHg2OEhxVk1pN1NrNmJhMUEwT0xkSy82alhINTNVMXA3?=
 =?utf-8?B?SEZLTm9nSHBaRCtmT1lBZnRReWloZTkxY1pGc3JxalBPTDhpaldMUXFZekY2?=
 =?utf-8?B?R3lQWitMNmpBbGhWOVNoQ2dpUTA2Y1hSRmtCOXo3YVBxNzFJbDA4SmpjUm9T?=
 =?utf-8?B?TTExb0lrMkZacUs5ZnNzaEZVSGhzMFVNSGN5ZEdtc202a21Na2lEcjZTUzlT?=
 =?utf-8?B?SUc4QTMxNmxQbFNSanNCbnFlVU1vSnY0MnNuZ3JYQVBwdDR5VXNETWhTNVM2?=
 =?utf-8?B?WG5yODlmdERZMDF1M1ZLYzJWcWh1N2VZdGZqamJscnlUL094Wk5KSzdIZ2l3?=
 =?utf-8?Q?WG9JPPzNiXs+S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0MxUDFiNVVQVUZOVllUY3NYelcyWTJETHlEVUNaUWNuOGVxLzhINjhlYkkw?=
 =?utf-8?B?SWtMNkdkbm5MWGNQL0tydmFHazE0Z3NDeUFhalRnNUYwRzBHQzRjdTc0REk3?=
 =?utf-8?B?Y3R3QWt4UTUrNDJpaXNOaWE5eFZyNGtkd2h1MTJvdXNNL0lhS0hYdjlKbVhh?=
 =?utf-8?B?SHd6dUxCRXk4aHdSemx1S2RhRWFhZ2d6UWsycDY0Y3hKVnZMT2hkbk9MOVFS?=
 =?utf-8?B?TVBFcjN2eERUd09ocEdKaFo0RnZPLzhlYVEydUIyTm1BdXFmMnJOdy9NVkpr?=
 =?utf-8?B?Tk1nUjM4TGZqam9RZHlIVW1PZSsrTlByU0ljdk9pZ3JIS2R0R2IxRzFlNUJj?=
 =?utf-8?B?NTBnc05OZnNGMC9wTEV3MWU2K2wxZnVIY3RnWHlqU1RvM0U0eXhvU08yNkd6?=
 =?utf-8?B?VlQxQVFEdDRLV0Y4S1BRa01rcmwraVhFY1puWXBTck9zdzY2NW9QZVBJMDlE?=
 =?utf-8?B?OFVPVWF1aXF5Q0ZFNWJTTHZoNTFnS1B1R3hTYlJiSGc2aGtOODV1d2JpR2VU?=
 =?utf-8?B?Wk9TaW9CNm8yLy9Ha0NzMFByK2l4RFhzZ3RzVStxR3g3NlJrcUU0VWNuVUdy?=
 =?utf-8?B?Qjg3T3pta1psaTkwQWg5M3U4Tk5pQ2JVclFwQ0g4UkswVlhUYmZEZE8vcTZB?=
 =?utf-8?B?OFhXRjVVY3F4VnE0aFZYTnhLRXBaWWM3OVBMcjZ5dUdTZlFtTTdLcm44c1NM?=
 =?utf-8?B?QzRqS0FVOGR1L2JtM3FWdjhZcnhYRkVYVE5odVpHdnhLZDEyL3U1Q2ZnSHBw?=
 =?utf-8?B?bGFjU2RwUy9TeFU0OUh1WkVaaGhOaC9zVGRUeGR0Z2hVUHB3WWpSeTY1VFBZ?=
 =?utf-8?B?MmJBZmpyTkh1a0pjaklBeTIvZEJPTnlNSDZnZkZsc24zdjcvK1NDK0djZzQy?=
 =?utf-8?B?ZmlYWWc4eXZBbWE1VlZTYkcxZjRINncxaExpQm1yeEpwendkNnlHcU54UnRa?=
 =?utf-8?B?ZmpJMk82d2VUU1pENmIxNVUvTS8ySjhwbCt6N0VrUWlURkVFczFtdkdlenhZ?=
 =?utf-8?B?Y3BEa29UMWpwSitibzIra2p6WXNha2U4UWE3Y1ZwRmxnMjJSU3hlVXhXOVBF?=
 =?utf-8?B?eXZHSURBd20xejZqMThDbmF0SjlxVW1ZVWRjNHhEZTB0MXdGai9XY0VDKzlj?=
 =?utf-8?B?OXJwdUFUOUk4cC9KSGpmZk4xMStOLy9kZDAvVldhY0cvdDdnb1IxMnpVN25i?=
 =?utf-8?B?K2JCTUFMUnhDRzI2Sy9sd3pGWndnUTJqL2YxbTNVK3h2cXBza2tWYitxSzVM?=
 =?utf-8?B?MTFWeVkxQjYrNTV1U01SK0J3dUxjV0lZSFVvZ3o3VTE2cTdDTWV6dFdUZWhp?=
 =?utf-8?B?WHByNWhUMzhvaWQ4M3pST0hYVzlCQXAwNTZkRGtTRlBYSzNkUHBKRnQ0VXJv?=
 =?utf-8?B?akZUbDRjM3NVWU1tWWtzcnpLUkRMMlVoeUZBSmFXdUlUWDk2c0ZDZmdnMVdm?=
 =?utf-8?B?OWJtdk82bkxtVDNJRjQwelBVSENBUit0OTBhbFcyTklON2dWYk1HODdtdFo1?=
 =?utf-8?B?RmFaL2NYajdzNXd5MzVsdkVPcE9ZdlBnRUxhQmJ5ajZXUGk0a3N0b0J2ZWRD?=
 =?utf-8?B?alZRMGJyWHp2ZlpmL25DTEZXUkFlS05VaVVEUHdabEQvSnV6YlpraEpiejJy?=
 =?utf-8?B?bzcvYkVjbXp3anFWWDQvYnh4RlZlQkdvbVNETjVuc0tsYVBMeDBxakZiQWMz?=
 =?utf-8?B?N0JPYTRrT1JZdWpaREFIN3Q2cnduY3lkYlViTms4aGk2T0lWdWZLL1hUQnI0?=
 =?utf-8?B?d3hiM2dIazBNTFlkMkhsTlFXZktMNUVDNzVUTkpFNlpCUFpTcVR6RzJmcCs4?=
 =?utf-8?B?RThQdVBrN1JjdVpsQ2Ywd3ZmZGxhYm8rc2V6V3dYclgyTE5WTFhTMStCZUJq?=
 =?utf-8?B?enNVL1JUN2o4NzRvMGFnZmpDM2J4aFBDQ0FYUDZ6K0EvYW1rREVjTjV3RjUv?=
 =?utf-8?B?aXRhYndvLytHMDFDZk9jZ1lid2NtRjM1cDRkUS9qMUV2TjhVMUcvS0xRR0VX?=
 =?utf-8?B?dXQvSjRrSEFvZHVqaVF2Wmk4SnFqZ3JHSEx2ZUhuU3VBODFxVVhBVk5VM09Y?=
 =?utf-8?B?M1dxNUMyRmdxcTBiVmIyQW9PUEtDKzRyeU00cEhTVDdjOGhmRkwyYVk0TFl5?=
 =?utf-8?B?SlBVNnJVdHI4allsMThhZDRHc0tQa2xwOVUyWUFhb0lJTkZSajZNMnFhbllY?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed60cca-c3ba-45db-5c8a-08dd4cec147a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:38:19.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5RjD17W91CMeuV2tLmWdGNRyhdFOjqzHadgbGOo764WW3EdRbNfDhQvQ+Tp0dyiNNFfZQ41Hhrn9fvx1vcChw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10733

On Fri, Feb 14, 2025 at 07:20:08PM +0800, Abdul Rahim, Faizal wrote:
> Okay. I can look into this in a separate patch submission, but just an
> FYI—this adds another dependency to the second part of the igc fpe
> submission (preemptible tc on taprio + mqprio). This new patch
> (driver-specific priv flag to control 2 different priority scheme) would
> need to be accepted first before the second part of igc fpe can be
> submitted.

So perhaps now you're starting to understand why I had initially
suggested you'd better draw the line now at just the MAC Merge layer
and focus on harmonizing taprio and mqprio TX scheduling in a separate
patch set.

I would expect that for uniform behavior, you would force the users a
little bit to adopt the new TX scheduling mode in taprio, otherwise any
configuration with preemptible traffic classes would be rejected by the
driver. So, if preemption is used, then the scheduling model is the same
between mqprio and taprio, and you don't have to handle preemptible
traffic classes over the old scheduling model.

I would also expect that you replace the current patch which handles
preemptible traffic classes in taprio with another one which explicitly
returns -EOPNOTSUPP if preemptible traffic classes exist - just like
mqprio. When Kurt added that condition in mqprio, it wasn't strictly
necessary, because mqprio_parse_tc_entries() already checks
ethtool_dev_mm_supported() in the core and rejects the configuration.
But after your MAC Merge series is accepted, you still won't be able to
handle preemptible traffic classes even though the core will let you, so
you will have to impose the restriction yourself, just like Kurt did.
I'm not trying to be negative, but it's imaginable that there's a chance
you won't succeed to bring the whole feature set to completion right
away, and if you do abandon things in the middle (MAC Merge layer
supported but preemptible traffic classes unsupported), it would be good
if the driver at least rejected a configuration it doesn't support,
instead of accepting it and not acting on it. Because if a significant
amount of time passes in such an inconsistent state, it would be very
difficult for anybody else to pick up from that position and not change
the behavior in incompatible ways that are user-visible.

