Return-Path: <bpf+bounces-18278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1555A818693
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26912843D2
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71115AEE;
	Tue, 19 Dec 2023 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KzFUpD78"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0518626;
	Tue, 19 Dec 2023 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXcwS5NaS6c31dCpH0Gm/MZSfVR0D1XqGzRRe6ewYubq684JJ97PARYGWZ5yHyGctsxUuzdsn+q+YY+DG+lvRP1fCWMw4sRln6r4iAmvGkiUORyxX+a0Yo7ME+ytkh590JfBn26BUc0JxAwfB/0zTfWiwalGc7Ng9fVdHn+KGB+JvCNnWaeZGclahradHersDwbnM0+0LrQcro49mSxsm429geFeFcvqCbirw4cBoBh9APZlT3u4XBsvNbGo+s85znVvmnCz18/XqQIo6E0uDCGHde7upBFhZ+LkK9KoG2eLH9Oub2k/FcN24K+1Dz8MdWalNB6rzfZli44GYmzrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMQOO80YdDGx5O0zr6sYZU/cGiUndPRkJeiWxA/3zOc=;
 b=jxjdTlsGrWFTo7476QpV/hP/ZQZ2r3oyEH66tKuVbR98a9F9LJLPLXw8I8loXnzQS7Wi4EGpCIVZLBfa8LGTIW6B+EyymDBcookc2v5+qc5yXX8RoJpvmS1uGgSDJ/2FhfWzMAvbC5Orrzplw1qRnLxUtJFXfAKOUJc8lNMD5viwhzJEwtKyNTG2mdBNQA2iJHfNBtfgpK9RuhtsECMYY5E3ex4x9Oho5izEUkpx/uCrOFWou0qh0RcLZPFk+jYhPhrhJ36JSnCx70YQBVBGV7i/w2q7QUj/Nxt8E7LK6JmVfIos4WaxF+xmijcHvFYa+luG60h5Bpa7QfqTbuIlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMQOO80YdDGx5O0zr6sYZU/cGiUndPRkJeiWxA/3zOc=;
 b=KzFUpD78jgVBFpe4rhnvvbiQEUysUMzJwdQdpNTzS5YUnkhWzP+BZXnmvUUmHsYZTP0XX3KWVYBg6bKPGPE2IOVoo2CSWjSL7KRMlnZSlyinxw8/RTJDVL6iikx2oVsZ2xraSu9NeHgcUul01Xzzr0LtX9HcVnazO7w9rV23Xo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:47:06 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 11:47:06 +0000
Date: Tue, 19 Dec 2023 13:47:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next] xsk: make struct xsk_cb_desc available outside
 CONFIG_XDP_SOCKETS
Message-ID: <20231219114701.5r5qoqkekfbvqtcy@skbuf>
References: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
 <ZYF9+lhYT1i7dvDT@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYF9+lhYT1i7dvDT@lzaremba-mobl.ger.corp.intel.com>
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 948ffa16-0e28-41da-73e0-08dc0088395f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/wQtR2FxXlGuPE5L/P/1PNcqnuTu/E6HM9X89EThVkYIpFJWpKRP+65aT3MO/L4WxjsWsfgAl+aopacNLWGgBpg7ZRhchi4ftFMfBs51OmKVoOqnPJrw5japhsRIxpy2cYDN8pJtjE8bx32P8yFYSKEZLlToOXurOvdMmr7LCWgEnHEaqrdeVIr9x6/LX85MZ593Bk9cyih6xWYOn4RO3FGM4xlfj+IbDN/F6sYH1JAwv+BgDf9ALkhqtYWBFJniBtJUwht20ymjDMRQJKrMMGs24vGzdwzlkR1qEEE0e54ceCzjFivMDd2QcMFzDHLEkgivP6gavUi92jrHOvTlLS+g+RyOv9+/6hvNX9XYlKcJGB5CNTJ2blYK5DiXHx6O2GbiMx/OdvcPLWSCqPiwrG8brC8qsx8Ipdz26/T/d4nG+WAm2eAUM5KkTT4FZ8BDLjyFn4A4xRjNeAYN1/rcd5YoAPxK4Bz1kgxxX0A6LAqzYYX1uHG1/cvInXXQXYhq3MB8xCDd7zxRl4tbHiT0JE12aGSCD/0nTrI7C5+CWP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4326008)(5660300002)(8936002)(41300700001)(8676002)(86362001)(6506007)(44832011)(66476007)(66556008)(54906003)(6916009)(66946007)(316002)(38100700002)(2906002)(7416002)(1076003)(83380400001)(66899024)(26005)(33716001)(6512007)(9686003)(478600001)(966005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+dlFd4/bQsKfjyznTbyhvmtXohsv6lPwwGPfee/IVlD89VMvktFXxPJDTuQE?=
 =?us-ascii?Q?sMZZStEi/j9xKuxeH1adI1dpuj7eJ7FUoVzNT894uIIIzUDkDrfooV2pDfnY?=
 =?us-ascii?Q?dASHD8wNX9ufr9p5iZX9Tx/lPwpidPSdl+mfw4NR4Wb2n6gkL/0WrfAMPyMn?=
 =?us-ascii?Q?XDVBRV8/VSCskobr/7XH4hpuPJ3Ew0BgN6hDmhxCwFULihEOdKnl+is4G9oA?=
 =?us-ascii?Q?j48vR+Zs7gkzRLedtGrdxvcZL1/EEO0hkd7d8SFZ1/F+xxIeaMRM2KTZ1jws?=
 =?us-ascii?Q?oHO0+jvZ6ymbHO6RdAWGJMlKYaL7k5G/wZTSqddkU7j4TXJIKWoZ8GkTJUuc?=
 =?us-ascii?Q?PLPyVXNb+VRuuGoxARbLsQiZpNVLVBqb7pbiLZFPULZLTkAB6T1E5hIOADue?=
 =?us-ascii?Q?fGFdrqqdqXlYV5wd8M0P6s5KjphczATXApk1ZmZFYxZ6Bowehyq9b7vbCkj5?=
 =?us-ascii?Q?HFEoVb2k0xBiH9DDhgRBpxRAs7Fuw2YTgPet2jqCMmYe+qBccmMRCmOdKmYl?=
 =?us-ascii?Q?ceJAt6rDiwzPLBiTSzX21gfmiHyfqohgREH32rfZTbOTxkfXJU8f8Gkosto+?=
 =?us-ascii?Q?whH/XyhjA8pNL8EFCKLYO60PHXdarw2AL1TehYSjpEySR33K5c65KnweBlxw?=
 =?us-ascii?Q?cAcZy0gWmNHKppnbcPboo4c0CiDntb2aCzvscUfwSBMJ7/rklufANNUWklaI?=
 =?us-ascii?Q?kiY0ZeCAksTPaQy7RwI7mcqRKiRk8Y5klYq3rxx2Hvjhu+D0hBGk8qQ8KniY?=
 =?us-ascii?Q?9q9TUDV+9J/g4J7bkL+gp/SmjzzsBgJADRCCHYHBlRSoYE7On/4ZXKAczyuU?=
 =?us-ascii?Q?whNB7Uq2H3e6Gx8ClDLBR5CGwZkWmWb1wx0FN8zxAyWmHyDKbg+vhT3uWiOh?=
 =?us-ascii?Q?DBUQgNmFJNYoe1Hj9EYYw0x99SNFBxOT69vhNG5jlpEcfviylEWyQ5sLQjTu?=
 =?us-ascii?Q?pCiz6h8OEvxelZnLFj1rp3spNVW4FOVpmKzOuHIkjHGI5Hnx949A6Q5pxc+O?=
 =?us-ascii?Q?kjFOrPP3MlNjhAIlVRo8Dtyaxi6qbLApSyGNXBj4WehfKEZcr26zrNOjM72q?=
 =?us-ascii?Q?WNkTDJYbtcJ1rM+qyf3iTtZY8pBCn7UfZa8+BRfIGoxsqz09cw9+jN1snGk6?=
 =?us-ascii?Q?ChlmBNd0LYEjEfHOoEQ3WvP5zn0Cn8VwNihODaojAE5T+xmonqZxTXbHE+ZR?=
 =?us-ascii?Q?q26cLxni0NWdOCpJbqW8yyJT+ArXh35DV/6+YE4vz440H2HEK+xd01943eYy?=
 =?us-ascii?Q?jz8/fzaK5B5kDJDUA2rcBo5R0WjCdEjVFezLi1YLDI5lxnxTuMeZMWsF8bvs?=
 =?us-ascii?Q?vcXQjOEikX9G2teGY7U+secAm5yNm6Uk4mHaYoPPgmv1hll0iQe3mmXQtKFs?=
 =?us-ascii?Q?KbJoxE0j3UzUyVwpItDGaWXvMHrHduW2Pc8GVjtUzC2j0DbWE3RVEj4aR+kC?=
 =?us-ascii?Q?jr4GHagwFjZ636WsR1lOsaGeRNeRBohYZv0xerizuVqHhO5+pUTxVi7Zd5DJ?=
 =?us-ascii?Q?eqCVIvc+tTfALlJ11UdAP34MFZrRqQIRgGTx3zT3t+jpJVc/tslj4q49xm3O?=
 =?us-ascii?Q?e4o+vFBRkNJgTQ0zyG/Gd20vOhV+qwtChyz9f4TImCopk7IJ0PYCYQGYT5AK?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948ffa16-0e28-41da-73e0-08dc0088395f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:47:05.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9XmYR4dVJzD6qMM1yAxmGPDoTdIT+kCjvJ/8Vaj1PDaobROhwXAvxyCVqjI9K9ChZvE2O4Xh+sthwpJGy7CUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

On Tue, Dec 19, 2023 at 12:26:50PM +0100, Larysa Zaremba wrote:
> On Tue, Dec 19, 2023 at 01:02:05PM +0200, Vladimir Oltean wrote:
> > The ice driver fails to build when CONFIG_XDP_SOCKETS is disabled.
> > 
> > drivers/net/ethernet/intel/ice/ice_base.c:533:21: error:
> > variable has incomplete type 'struct xsk_cb_desc'
> >         struct xsk_cb_desc desc = {};
> >                            ^
> > include/net/xsk_buff_pool.h:15:8: note:
> > forward declaration of 'struct xsk_cb_desc'
> > struct xsk_cb_desc;
> >        ^
> > 
> > Fixes: d68d707dcbbf ("ice: Support XDP hints in AF_XDP ZC mode")
> > Closes: https://lore.kernel.org/netdev/8b76dad3-8847-475b-aa17-613c9c978f7a@infradead.org/
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This probably should go through bpf-next. Other than that, fix looks fine:
> 
> Acked-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> > ---
> > Posting to net-next since this tree is broken at this stage, not only
> > bpf-next.

It was a conscious decision. Build fixes are more time critical than
most other patches, and net-next is more likely to suffer from a failure
with CONFIG_XDP_SOCKETS disabled than bpf-next is. But, sure, it's up to
maintainers to figure out how to deal with it.

