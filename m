Return-Path: <bpf+bounces-57146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624AAA6428
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B072A3A6C43
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D222578C;
	Thu,  1 May 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QbUqOBl3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC641F8BDD;
	Thu,  1 May 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128390; cv=fail; b=IRXmpgJWw/qaCsm7w2ZjeyWkul/E2SiLfaGs0JCXaysceSK40U5hlKBreMpnxBaoLp9ScrdUfFcUqIMjUeNOXvvA0OkXbhEtelox5cAOCX7fYdPNP35gls5mmOp6iXla72KOtv0NaJfFtD7cH0kBtSv4TIqzy7YoHI7gl9WqDVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128390; c=relaxed/simple;
	bh=PJH78UIPWQ34nsHKBUSdt4HYAQKU/q4VBFE+RlIYaQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iAfSRLeFO18aOUJOPvVDMVINoxzdux7OZDFESX4Yv5Fy9fYwl6fzL3svxHCBO0lYd94KyT+cVY5yZhfyxe4soBw5tw2uGeSDf8QUueSpsU8AyY1NMQNhbutCGvwe2ILSNY6Y/naWdMbsRo0RNtjuVAYtYgas1BJ5iM9rXQWehGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QbUqOBl3; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 541JdgVq000574;
	Thu, 1 May 2025 12:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-type:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2021-q4; bh=dulMVMU
	M+lO3SkkeFz1MzSxuV1TkasyjHx85+d19LIA=; b=QbUqOBl3BBloPvy8i+6VKvc
	BpdiXf2WRCepf/hKurWiFq4eMER0UPqxp7RBDBgFI+ZOivvZI9qGZ0rKP+5Z8CKu
	xkcaeG4X9ht+QGSpOAmc5bWN2XXELI/JRwxAzR0Z6kT8m/iIjQT6LuuU/QXTKSYE
	RNa67FIEUqR/3QUnQLr5V8LdfVDcuPRPiWV4vsoj/SKXCl+p64LnFoBacb/7/sEP
	M/SUHbuJlKS+QpPhxrddu3pGG5s2k0Rp5y+Swzjf9Dikobwo/pJSWT8gWdDTWgda
	R84+GgWtj3A7t8Fd9qjkEb4wqDUkWoy7BKdArX1dFhR5fFfPFgxsXOrH/ihI6jg=
	=
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by m0089730.ppops.net (PPS) with ESMTPS id 46cehcrd8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 12:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B10NsRfZ9JPJzR4Qi5J75ua4648tkegDb8owFn4zhe02M/2+o8ubPq668OeA2Z4ZljoMjSn7jt9SyYjfdv5fmhx6ccvOYMZgoCt07NGFyMpUACkRmyATDqlqBkCuP5Z+s79X9fFTkrtoIgjezf8aB3ccjUOjzE22qOHAP2URuGE7hfjSYEkSVBdvuZW8KTDHDXfGJeHOrs18T7JaTmwuD3JtxWKrVsZJbvltXoA0xfBsUNrd+grFxPIEOvQWvWx5G7yU03wkg8skb94BQIzAo2OIKY/KdL+yR9uBbu+OIQo06PZttWbFruW9WAeNvWWZOTGStiEUfH1m5w0FEyDlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dulMVMUM+lO3SkkeFz1MzSxuV1TkasyjHx85+d19LIA=;
 b=GpWLu28EhAxsX2vtfAhab9rFwfK83NqZKJDqePgQWH+XifyqoKZOekd94c0O1StZK2lCNL19sJMG+GHNaXwqP4ZFSPCRHpTP18dHCxublbeDePqG7eT0WkJAXW0L1pXsyIrFBt7lew3FdGixRRct/bIt4mdWRguul1DMZu6wmS9oqoJMPwqabo+1gyFpYOaWcVX0qOeOHztsU4+9mD13AgaRb/8BKgKuqi/kQCBOL7GD6w1iNsOMRqMbTkh3NZI0YhB4aWczjtTt+D2baOptwDZhQC2HTSkx1tJr3Ju1oMJWZPVP22F2sNXXdbEQ6cCBgQFl1QXttDGJeII1YlJQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com (2603:10b6:a03:4c1::19)
 by PH0PR15MB4480.namprd15.prod.outlook.com (2603:10b6:510:86::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 19:38:32 +0000
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029]) by SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029%7]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 19:38:32 +0000
From: Thierry Treyer <ttreyer@meta.com>
To: Alan Maguire <alan.maguire@oracle.com>
CC: "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org"
	<ast@kernel.org>, Yonghong Song <yhs@meta.com>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
        Song Liu <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Topic: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Index: AQHbrwS3AlS1roAfS0S+1p7h6I+KLrO8aiCAgAHZB4A=
Date: Thu, 1 May 2025 19:38:32 +0000
Message-ID: <7995874C-FE08-46CC-9CBF-AF337E7FB560@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <ab9d66e1-bf54-4aa9-9f11-a3a1835acd8a@oracle.com>
In-Reply-To: <ab9d66e1-bf54-4aa9-9f11-a3a1835acd8a@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5671:EE_|PH0PR15MB4480:EE_
x-ms-office365-filtering-correlation-id: d53529c0-b1a6-4d80-9157-08dd88e7c1a6
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yDR3BBTQR7w/RvQ65ycP2nc56OmRoQOH9q101ofy8k7hdlSPZ5j3G6A9E/vj?=
 =?us-ascii?Q?w2+HtZ/kNWuROuSUVdzf2g7JcHDBilieD3++moa52wEjkZiBGwEhUD3oU3Re?=
 =?us-ascii?Q?f8p2aqy3jckWfWVF/Bu0Vk7TALckuIwwsDzsddHTwj8QDwoQqrs5cYEvEOje?=
 =?us-ascii?Q?2Sn7DBMH8iTlh88VCIy4NtzHPw41jozaBVA9pwIAhWH3bERR4WO3yKa/dEMC?=
 =?us-ascii?Q?j2eP70Kjk19sCUnUdiszYKFGkCsqAUJrq0M4uR9k7MMp/zdWSg+rgsQcjV96?=
 =?us-ascii?Q?FRUoLfD6jyBaxseeGxIRlckMyiY9uhkMkRF2z9oANHKh1DxWIy08vVKMUp4b?=
 =?us-ascii?Q?veYbnf/lkGlRBKu0/A19nc8HBOjE0rhG2mYmxuhVlqbAXWqQK2UstscZ1LHm?=
 =?us-ascii?Q?lmRa23gTTN9QjO+VVxmfbDGU2ff1++A2+cDRrDn/zuoRWRkqUfd9mlAkurcV?=
 =?us-ascii?Q?8B28o3jIKX8I14dAXKabA/ulTyqFvCEJfB4eiLXTwHL3LfR6DhwFqZptQXGL?=
 =?us-ascii?Q?UCbG0oqd8dXiYdE+rCFnHWd3Yz8zNWO/m7tUUOk/WQUWHzgN89OcpNNP5zK6?=
 =?us-ascii?Q?LYq/5pNgGh3/ga6P8WHRBK1joIhyoMca9epOjD7KJL/+ITFbpFYyNAZpXamH?=
 =?us-ascii?Q?agEedbioD0D0pqgDjHROVUs35P+riUw7c1majTuC94Zm5J78HnGhFZk6mO+S?=
 =?us-ascii?Q?Ze1rq+2z9bwwOb2Jn7eSRe3pPGeDY5J5jcbRFuWTxrxqwt98zI3skjEUP8Q0?=
 =?us-ascii?Q?ZZVkFp6xDyJ8sBunvDPjTb92kHZFtw+Jsj4lq8auMuVQm/wOOjqZF6/7x/Rt?=
 =?us-ascii?Q?T7RVf5x72cicHEzpuXlzZHgSAuj+TPKncz/vd54/JVGuZoUahhGjzrIbYW/g?=
 =?us-ascii?Q?gGOW9MxEbn3Q7aO7k0v9kiSjnIh4LA798QwW8+9XsSAI7HOHkh9kl9bKh0FZ?=
 =?us-ascii?Q?iv6aatFFf58+d3glG5lNTFwDh3P4UF1qetTY+oKURemvl1FudSqXmwUJC6Vg?=
 =?us-ascii?Q?x6Nfmd9taUbxv/VFEt4QL8Fz6JAN5Bfxne5kMG/BHUNLzZmbrixtI+SqKsD+?=
 =?us-ascii?Q?zMCmT7i7ms7y6DeLzzKlRbBXO829gPn9STMX3b+PceP0Clu3fjbyDfEh9xjx?=
 =?us-ascii?Q?480LGrpzydHOYNNa17AeQhNdn8FiCueD82T4rGAWRbTMiPB0EyxvFSUjhunt?=
 =?us-ascii?Q?U+AqYx2/nSeJZYWCXrvPL4RQQbg5DHAaQPCwPMIzvwqtuN1J3mlid7mntsWh?=
 =?us-ascii?Q?Lw/I+AxqI9vOAKk52C276pDfmnRWbXq+mw/HrhbTaMrp2yTgEcoYoUFyEYzN?=
 =?us-ascii?Q?cxm8fmCYJp8KJvxEoB3ZSuDFDuBcHoVxClBOQDmPwFOAhVBi3U3QUiP9Iwtf?=
 =?us-ascii?Q?m5ZeCnA1LKnaV0bJ/jmTS04P02Vjs6oVdQHWPHYroC8fbFBkzwESmjxtGcMF?=
 =?us-ascii?Q?7d1+AFlObqC5WPuEK6T9z5EsnkGkhpvrCI/Y+CVVjo+B0JqwQquiiB4jz+gq?=
 =?us-ascii?Q?yu02jamWhYa0HHM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5671.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/ZWKvfyp8VUm9+HTIu6uuocSlw05iCmkoxeIFkoVJ1ZMEiLFSytR98AAhidh?=
 =?us-ascii?Q?vlF9WdZFzjaZYv8/QM8v0QSfb1kGdgjk6DUJBXtJcPGTfbUmL0s5AWpAeBln?=
 =?us-ascii?Q?jDLdHYVq94W02gA7NAHaxkeyND4UGa2plTtnrg12J7AbHIwStygYigGIXlZV?=
 =?us-ascii?Q?4Evp2kdWzamLIYEiQNUWRFQNGrMapmBiT3EV0izPJvm2vm6OFgC0jf0fazXb?=
 =?us-ascii?Q?UVoQOHzPXcBXWAnauccnK08qTMuKTKbLBZaUcpE2tgYi57R4ifrJ1Yq/v0J4?=
 =?us-ascii?Q?punbrXWUiZUkgN8cRqEdztV84LQhOHLJsPNtGmjyOtuSlf965pB/iW88oX8Z?=
 =?us-ascii?Q?Tus6nNGuIlGZYcYP+E3AJ3tXmXVkBViGLduHOLPkhnw8sWSq9OuxnVnj2HNm?=
 =?us-ascii?Q?vuz3fr+JJnxIr0Pcnf0WCFJ0Lyf85Wqv1ngCgJUhT95/D3Stvo5FSmbHHWno?=
 =?us-ascii?Q?Mh9HTNHJ39egviibq9bStWxZiSRauC7W0fx7FEZhDJeLuxEoWlmQdt9eLz9w?=
 =?us-ascii?Q?FTffoxmxpxdFk0/vY2RkS3Mss6WNiPPcNd6JitV0or73hBoxNJHaDtLdojeX?=
 =?us-ascii?Q?sk6/qB+NQOjUeN6xq4az9ibr3rlWim3kAPOra8qdrUYEB3dHypTzTJuUKigI?=
 =?us-ascii?Q?+QV1RrABVDIjyCSRLDp+oSEOaFCdkQ1e5uXBZlbxPS+I37DuYhjf29UTjUu9?=
 =?us-ascii?Q?peJbZDrinuB6XXMKY1EQErpPqqpIpaE8UXNxH+ThM385JEUckD93m/9b5/gQ?=
 =?us-ascii?Q?V47ysnJn1x0pC+YrIA4QA6mGUKTZDVPhfpO5Iz0x48G7MzPXr6Sy9pBGgZmz?=
 =?us-ascii?Q?7LMqP5J0QH++tTxJ0Nq4pc3uey6X368lhbzGnQ4i0W2BfVzxmnDV2TyoYoIJ?=
 =?us-ascii?Q?+t7u2nWdz0hf4EDe5iANfTcekR2sEBbM6ySVn6q2QXPU+FoNTykCTyv59enW?=
 =?us-ascii?Q?uer/ltjxTHsoI3CDk3w7oP26dzTQfqX1etCIPQugJQhi+HSrf0MHsBYMCTfk?=
 =?us-ascii?Q?MOpfWxWM0R7XCXvhjU/KHSr97GWLg7uZNrVF5xDzFmrkxOAD2XGfJD51rKON?=
 =?us-ascii?Q?cDPrsxSi5fWhwKjDEPRnjD0oiT7RGhQppxa6paZ1ayjlZ5pPerEJbgvCg2bH?=
 =?us-ascii?Q?2PbA+s01JeUm/S3Vugdum7ewawGaqrOjVFXkChYAPRaEskeJaRPAvMOMOE4b?=
 =?us-ascii?Q?9vWvIfaCoIFbuBdEjKuYml+7PhtAlengs+ZC/dBPHx3W8i20Ngw+KJN+OsPL?=
 =?us-ascii?Q?IMXJv0oE7Bkltr2grEDBECtjVJPzO4mMeDf8Mr8hr2qVFg32qzV0OhiBCxqh?=
 =?us-ascii?Q?C1OiezdKYFnxLtjXt1XNeWz81g9iT3onIWLEVBicxJzKSrRozPEL4CTTjXks?=
 =?us-ascii?Q?JHgaL6Ire13ZZIBwaHz8Ok9qo3MYQcOhvibxyT0JMKKVRqlbjReo5POfSeBG?=
 =?us-ascii?Q?/wb50nJG9kXnqlEWMrT8UmOs4IO7yO4gfxi5z3SUTzNDFjBKFyn4sLelszCq?=
 =?us-ascii?Q?0vC+iD7DcOy/wgMHWXtTGcv9ew1vUS+v3cPYIPJcmSRBa8OD2HnprJAohEyk?=
 =?us-ascii?Q?kLdmulmwFUj5TAFdRRAsd4QIQL6Oc2DUKLaTf6twRi8c1RMsG/etw77KJRgV?=
 =?us-ascii?Q?mAMudvb3I4yc7xkVjPHjhJE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BDA30FC6A5629488A7410EF75CFEADE@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5671.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53529c0-b1a6-4d80-9157-08dd88e7c1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 19:38:32.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/fDjycWoJCTBXp62quELmT1grgiJWogxXHrl0wHnl6oSQ6blT4Hdhqfxga6owPTX6j903d2BsYXHWDQ1TnkMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4480
X-Authority-Analysis: v=2.4 cv=e+0GSbp/ c=1 sm=1 tr=0 ts=6813ce00 cx=c_pps a=dbfzVNK0jQbpEhEqKt7tuQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=Hl6vOayGVvLNzFSCvBUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6GiccPS_t3HtTvoUBVaUWu9KaxEn0rGl
X-Proofpoint-GUID: 6GiccPS_t3HtTvoUBVaUWu9KaxEn0rGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDE1MCBTYWx0ZWRfX8sO+BzqnPbHd 0jI4Gc/MmW2VY0uEH8+3f0OGBRUO5m1EUZspRotFeZWa4pGBjW/S7N6IqsmcwntHbhOOLv/k5AJ dLMMy+nuzMW3soyllrgOFzO6G1F+mNN16mbby1LGOo8cevsXnFz3+rVvC3wgkQcNH9FbYx0LOhL
 JuRKWCZzwIUAUoNePpjjxE56VTX5IS2lwNZ8oJ4g+81dM4eL7MsmXB1DI7+sK3jVwzqxiufEPVa 095A/9vrR56govAn7Z5NGkQKAn1XBxehN3aMHcNnp+c3op3XeM78pRzxIqWHKM4EXRB7uGaxHUm pujEPhKDUoKwcEzMrMPQMLN9LSXnStkqy0KjbaYNJn3k+yYIr2vFcagGpCcsSbUJKUC/uFy9KaK
 w7ijubso3/aGY4+xBRr3/SEPKZWiHNQMicGPkFNYN5abUMwQMtgZ+dISzceESn+TGCXE6yZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01

> 1. multiple functions with the same name and different function
> signatures. Since we have no mechanism currently to associate function
> and site we simply refuse to encode them in BTF today
> 2. functions with inconsistent representations. If a function does not
> use the expected registers for its function signature due to
> optimizations we leave it out of BTF representation; and of course
> 3. inline functions are not currently represented at all.
> 
> I think we can do a better job with 1 and 2 while solving 3 as well.
> Here's my suggestion.

I see how your approach covers all these problems!
I would also add the following issue, which is a variant of 2 and 3:

4. Partially inlined functions: functions having a symbol, but is also
        inlined at some call sites. Currently not represented either.

> First, we separate functions which have complicated relationships with
> their parameters (cases 1, 2 and 3) into a separate .BTF.func_aux
> section or similar. That can be delivered in vmlinux or via a
> special-purpose module; for modules it would be just a separate ELF
> section as it would likely be small. We can control access to ensure
> unprivileged users cannot get address information, hence the separation
> from vmlinux BTF. But it is just (split) BTF, so no new format required.
> 
> The advantage of this is that tracers today can do the straightforward
> tracing of functions from /sys/kernel/btf/vmlinux, and if a function is
> not there and the tracer supports handling more complex cases, it can
> know to look in /sys/kernel/btf/vmlinux.func_aux.

Sounds good to me!
Laying out the format of this new .BTF.func_aux section:

+---------------------+
| BTF.func_aux header |
+---------------------+
~  type info section  ~
+---------------------+
~   string section    ~
+---------------------+
~  location section   ~
+---------------------+

> In that section we have a split BTF representation in which function
> signatures for cases 1, 2, and 3 are represented in the usual way (FUNC
> pointing at FUNC_PROTO). However since we know that the relationship
> between function and its site(s) is complex, we need some extra info.

We have the same base as the BTF section, so we can encode FUNC and
FUNC_PROTO in the 'type info section'. The strings for the new functions'
names get deduplicated and stored in the 'string section'.

The 'location section' lists location expressions to locate the arguments.
As discussed with Alexei, _one_ LOC_* operation will describe the location
of _one_ argument; there is no series of operations to carry out in order
to retrieve the argument's value. This also makes re-using location
expressions across multiple arguments/functions through de-duplication.

> I'd propose we add a DATASEC containing functions and their addresses. A
> FUNC datasec it could be laid out as follows
> 
> struct btf_func_secinfo {
> __u32 type;
> __u32 offset;
> __u32 loc;
> };

We'd have a new BTF_KIND_FUNCSEC type followed by 'vlen' btf_func_secinfo.
I see how 'type' and 'offset' can be used to disambiguate between functions
sharing the same name, but I'm confused by 'loc'. Functions with multiple
arguments will need a location expression for each of them.
How about having another 'vlen', followed by the offsets into the location
section?

struct btf_func_secinfo {
__u32 type;
__u32 offset;
__u32 vlen;
// Followed by: __u32 locs[vlen];
}

Or did you have something else in mind?

> In the case of 1 (multiple signatures for a function name) the DATASEC
> will have entries for each site which tie it to its associated FUNC.
> This allows us to clarify which function is associated with which
> address. So the type is the BTF_KIND_FUNC, the offset the address and
> the loc is 0 since we don't need it for this case since the functions
> have parameters in expected locations.
> 
> In the case of 2 (functions with inconsistent representations) we use
> the type to point at the FUNC, the offset the address of the function
> and the loc to represent location info for that site. By leaving out
> caller/callee info from location data we could potentially exploit the
> fact that a lot of locations have similar layouts in terms of where
> parameters are available, making dedup of location info possible.
> Caller/callee relationship can still be inferred via the site address.
> 
> Finally in case 3 we have inlines which would be represented similarly
> to case 2; i.e. we marry a representation of the function (the type) to
> the associated inline site via location data in the loc field.

Here's how it could look like:

[1] FUNC_PROTO ...
      ...args
[2] FUNC 'foo' type_id=1   # 1. name collision with [4]
[3] FUNC_PROTO ...
      ...args
[4] FUNC 'foo' type_id=3   # 1. name collision with [2]
[5] FUNC_PROTO ...
      ...args
[6] FUNC 'bar' type_id=5   # 2. non-standard arguments location
[7] FUNC_PROTO ...
      ...args
[8] FUNC 'baz' type_id=7   # 3-4. partially/fully inlined function
[9] FUNCSEC '.text', vlen=5
  - type_id=2, offset=0x1000, loc=0 # 1. share the same name, but
  - type_id=4, offset=0x2000, loc=0 #    differentiate with the offset
  - type_id=6, offset=0x3000, loc=??? # 2. non-standard args location
    * offset of arg0 locexpr: 0x1234  #    each arg gets a loc offset
    * offset of arg1 locexpr: 0x5678  #    or some other encoding?
  - type_id=8, offset=0x4000, loc=0   # 4. non-inlined instance
  - type_id=8, offset=0x1050, loc=??? # 3. inlined instance
    * # ...args loc offsets

> If so, the question becomes what are we missing today? As far as I can
> see we need
> 
> - support for new kinds BTF_KIND_FUNC_DATASEC, or simply use the kind
> flag for existing BTF datasec to indicate function info
> - support for new location kind
> - pahole support to generate address-based datasec and location separately
> - for modules, we would eventually need multi-split BTF that would allow
> the func aux section to be split BTF on top of existing module BTF, i.e.
> a 3-level split BTF

Do you think locations should be part of the 'type info section'?
Or should they have their own 'location section'?

For modules, I'm less familiar with them.
Would you have some guidance about their requirements?

> As I think some of the challenges you ran into implementing this
> indicate, the current approach of matching ELF and DWARF info via name
> only is creaking at the seams, and needs to be reworked (in fact it is
> the source of a bug Alexei ran into around missing kfuncs). So I'm
> hoping to get a patch out this week that uses address info to aid the
> matching between ELF/DWARF, and from there it's a short jump to using it
> in DATASEC representations.
> 
> Anyway let me know what you think. If it sounds workable we could
> perhaps try prototyping the pieces and see if we can get them working
> with location info.

I'll look into emitting functions that are currently not represented,
because they fall in the pitfalls 1-4. That will give us the base for
the new .BTF.func_aux section.
I'm looking forward to use your patch to simplify the linking between
DWARF and BTF.

Thanks for your time and have a great day,
Thierry

