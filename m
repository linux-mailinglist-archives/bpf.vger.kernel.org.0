Return-Path: <bpf+bounces-79423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D54D39EE3
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 07:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 268F1303CF49
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71C270552;
	Mon, 19 Jan 2026 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lr8OcrMX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XPUvWeSn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D225F7A9;
	Mon, 19 Jan 2026 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804944; cv=fail; b=rlx8O6dazz07ImOs6V6zO0c7kcLKHf6B9KJ6LU1exNe6nZ+aA2RkV1FmRkKQK1zBOtz6kiHAxpRgmVe1veQLluzZ3o2NpcO4ckMUrW9zv3sHaV6RkVOSzaOy8g38jVCq+fw6es8peX4L6RpKnYGjkiB2i5UuCRx8964CqaOI264=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804944; c=relaxed/simple;
	bh=T1BKEE9KWZIrFarq3D1JgmUohCSEku6nPhgqigyOAtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VUtSk3v5zvYO4mhZqv9otE4A0RBQ0BNA8NieZINysnqolZRbeANWctx6ZHD4u6lGgp0funNJh/bmPeYGgZAP5rilWGyKdshxEWXMW2+z72QNok4E+i3BtZv/F0ZE8oMjhpiZntsHSpTxqSWEo8bVcn5R3AtF+gQj8uxBumVXxiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lr8OcrMX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XPUvWeSn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J1cHr2116105;
	Mon, 19 Jan 2026 06:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qys+lJv7r3+INwG3kL
	ysHL4NNjlai0WEYBKn2KeAYAc=; b=Lr8OcrMXvzOPUDzo9cE2lT6hUQk/EjWNP2
	UHOyk2L9WEx1g91GjM+hH2CZfp0t/TrWmPKY9SjclhT7xgo8EjLkaCWl/GxHE5Al
	pEVAwEdhomF/XYGzSpMZnuQZXQHPvyaiF9nDU4uVrdXTaY0fXh/HQkYDbFsi/XdB
	ZC4miXJK+QqzbmylPjRbpU9AoPgBMedMBtCMLFs9lpIFuBea5O1HXbU8Qy8A3g8o
	MvnY7SysF/jAj99CBpJQq2Na+bmXwf+7+LibeBjyEgFZl+pbRYmsxBCeR+nq/x5d
	PlbO+xhL9Z3X45TQ4RZrvc6YNY38H1+pxC6YFjn4gn7o8q/qeWjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypsq1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 06:41:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J51fto032836;
	Mon, 19 Jan 2026 06:41:56 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vbrmyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 06:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8uhl/U9MawagiGmG9JDhJ0/EE98ges6y9TSXxZIf+5+PfvyhrEUC2b1MHkJVgh5cQOULrhnTcAc3qCDvyMQgdaorsvoGGph5gSuWkAURLqozcH2LWkAyUqzf5OMR4m6XWTwRm/0QFzaNUVrbJwasW7gmUGbwYNiXpmgvfBNiI6h5xTXRNHYgoEibnk2AR+BYKZtS56XrRMf7NIoPoa98QSZVVEPY0wN7ymzccUsAGD2W032ybkMpnGzZw6LXb8QUOlDbCdPS7OiDhbygD/m5b6D1Y9yDisZQMIbt9EB/ijl6kw+XOad+frGiWem1gNmK+zPaXgiwXoTGu7pEuzFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qys+lJv7r3+INwG3kLysHL4NNjlai0WEYBKn2KeAYAc=;
 b=aYlw5mHEysRmj1WzSdMpQULdx0LOfGa2Orw+WoC0Vf34+xVUWvPCpEhou2dgFJsC4E78CICayHxL6y5COtGMlqc8RtC7LHrUqfSa9HRlhtoglljtHbfgquHHrf78oXbRcIDDwIk1lv/n71LUWva68PVg1b5bI4TQ/whR7UHqd7ozdAZHoa+6KanpvdSWfZgS+w6FvdJW5HPnJw+3Ky+N9jDVK/nKcF6V/YEIjOXva1O9LI/39agTX2uTAzcK7Er2ze3fcTcqqZQcwULO5/uY60nCB2qqq7+5wkdwYHq6w/ezdd2zCUOA5QS3RrIFimsBGmSPQDuPk+GeniQ2/Ngm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qys+lJv7r3+INwG3kLysHL4NNjlai0WEYBKn2KeAYAc=;
 b=XPUvWeSnNMC/OganzPfKjFfBiX1SsWTr/9p3XduDD41BS8yRRYFGRNAhaI2BkRyankuNH3tFERpTb0mtnh+VmaAf4GrQuNQ+x7/0pOf/RCkiKzdhgmNsAeT1fhhTCsTJjpG99Jw029iU1u/o60yRvvfVrt3IHXJc58eky1ClqUk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 06:41:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 06:41:50 +0000
Date: Mon, 19 Jan 2026 15:41:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial
 list
Message-ID: <aW3SJBR1BcDor-ya@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
X-ClientProxiedBy: SL2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f6581b-48e9-4c8c-2dad-08de5725d327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aCGvQgb6EpmbsvoDD63Chf4WIc22XHGH6Wcl5IG55lA1YpZf0q3MJ4Hz1Kp2?=
 =?us-ascii?Q?FbzHpvzTGW0P2DIVUmRj94wTPdSWxaUmDEJMokTtQbBmeD182oUlBwVaNeVX?=
 =?us-ascii?Q?KXwdK5nO6/D8oLnMqLXiRk+6n2QYgO0/KafzSptIqL+Cs9YZI9YCCy3RAtsx?=
 =?us-ascii?Q?L8i9tQE5LyFIP7IRZ3ox8CgSmGDrtcXjMx4zp7yNiNI79LjU6oZXLKWPksbf?=
 =?us-ascii?Q?jyP+myvsi+M1GFrnkBuET34lGr5C23b5FvNR8TohSMWMV5e08Fe7gAfL1zEI?=
 =?us-ascii?Q?lPco+XmPuA6sNxlSNQXPoeMS2kxApHxqxhviLsMLO0PeI7vxdGxPRbrhH7Ul?=
 =?us-ascii?Q?yNyer8CiCJSNrnD8cRTlD913qtYgdw9cmzjM8AKczbm+/ANQ/0LAMgLnD7vj?=
 =?us-ascii?Q?c71NpLZXoTRweuAcvk4ZR2JgZhwhVAL8X1F3bJKIdBzPOefLZ0gCq/vu829n?=
 =?us-ascii?Q?NI5ps4tEvhpJ4c2ksYt5b71FxXf1ML3ozXRnBvQKVoY2/WGL0PhFMTJX6fyE?=
 =?us-ascii?Q?3lURkwx41/Hyio52T7bKNxgbFX3+eTeAfQ7pJGFsAMJKYkKI4METC62aw77n?=
 =?us-ascii?Q?A77taBtEc8J2mo0AyEq0ddaoIzVt4028N/yf6GEVPe1aL9ZPOnNAUN5lDeC6?=
 =?us-ascii?Q?PKZBY2UK0WSgS5aRVA3ub2X9AiH33JXaasnIwcG5ngj6lE03xX0dBXcosz1m?=
 =?us-ascii?Q?rgFUytxR4X6eA7i31hv2DgvZl/D153BojEaR/yuXiSAxn/AueYS74AvwJVii?=
 =?us-ascii?Q?lX9JYlcmGMYmJcL/1OmDz5FfjZjTlMAbrW6L9EoE4j5FThj37z7UdP5GiWRp?=
 =?us-ascii?Q?t7aGOpwxMg/KvG1DrmLovK3ooq7Rt36RQIds8OEoM9cn6hiJzXM7lgNNWwqL?=
 =?us-ascii?Q?8/bOgkwcuoKRA+Tn90orzNx0pEWbZz7LoyHqUZ0HwG4J56VrcA1EmNgmYq6H?=
 =?us-ascii?Q?KBnfdIKs44cIDNTYaCcpI1x2ndxN3gZtaUGGG3yQx3ZROLyq2TDSRp2T2XPL?=
 =?us-ascii?Q?T2sU4qX4UvqGrR0Wm5NEEiaLifkemG41WwxuzVHyERJqwqvl+jcKDG7GpAEK?=
 =?us-ascii?Q?KH/QQ0/QmUFsRjBTNwWXPLeniLDdXeOL0qCfzJvHSTFogvnrgGz+KpUvj0IO?=
 =?us-ascii?Q?OiRiirh9rx12YH0pM3OQYlgFWfV0VJn8lGPRTWOjdgD6WmCkjxncexG3Rpid?=
 =?us-ascii?Q?rxYgFzpv8oJUaQmHVzWuGshrLatGaZQgYuX/qAvoRVUGgdYv69QN/rx++2ud?=
 =?us-ascii?Q?//xMXmZ0DJBbonzMchtWBuE0MoqOHpIzyO/g7Xe7SyZtQSS2LvOxnhg3BZiN?=
 =?us-ascii?Q?ELV/YTvSLvyO1DTuRDQ3P4AnDRxScSIBaAPQUhEzseHouBwTQiJtETmTKJZf?=
 =?us-ascii?Q?IgBh038WzrAvUzjizxCk3Y6LXy+rqjEWUJI0OnVPQx0Lzq72Z8Oq98xTh4PU?=
 =?us-ascii?Q?Qpq9magpFVtVfv0j4YwOfTLxSJzzfKlDAkk6ShDPDgQAdFjC4Sw+CbK/vStp?=
 =?us-ascii?Q?f/LVTabpfMcR9CX7u/Ye9mjWvjhxB0fPV79HJm0OTk9EP/JSKJl06pTb1SU3?=
 =?us-ascii?Q?uNxwoh2w0f7kFw0YyN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m6UCOBNRkq7/8Tt3pXD51+qzpEOm8lXc4N8eZw497nTjJfJaU1jgUDWWS3We?=
 =?us-ascii?Q?4LoquWMna44il4U1mzOAHuGD2aP1zmqzR9bs2639/4Oa1BIndRsA0eHV4gyp?=
 =?us-ascii?Q?VZohrXJG5g5RtAWogW1dNgXohXJ8cQpfeHoNwLyl8CzN/2X4SK37lGziXWVW?=
 =?us-ascii?Q?Kc0QNMX4xpm1KurZDOe31BnH10Q0nUuE0AzlGHOVej2gXbOouDijbOOgMyn+?=
 =?us-ascii?Q?Yt3KbMlKpScaqgev1+/QAK6aXm6vxphOcs5genydXRFPy7siyVZQvvcyIsIa?=
 =?us-ascii?Q?Wc7rmmC8gcFF2mKNc1kSY0BoMfVK9i/QOJN2z4+6PGkan/7QIOuUdm9AxZVi?=
 =?us-ascii?Q?KPM75ggaobmVJZ8ulAe31C00qIJc0X3lYnTWVZhewAFeJ1P3Mmo3liHhhvLv?=
 =?us-ascii?Q?38mN11PJk6F/FL0y+EXfQLMDlgq9w7Pzb6rt4bE917H1CLYknZWgMl7nM1qG?=
 =?us-ascii?Q?TV3ptvsoK9U2k1kS6W/hKV4IFmAyPiegQIbaAlBqjHATl5tA9CHs+vPxejiB?=
 =?us-ascii?Q?VvO/6u7nezbwe5gq73uYQcpmbTxneTB6K8c/AeSuQWveP/FPz2eQRfcPRgH7?=
 =?us-ascii?Q?zkFn+2KkQQpLSLw1OR2ZB8Rv6msQsP/lKV9WQy1aYho/wVcrYKPGTxYhFZ5a?=
 =?us-ascii?Q?460pLbHxLGVfViW/gfu/QiZ6dDPWC3nvkjj716FC2Cc5L4CQ6wCxop7TckLn?=
 =?us-ascii?Q?X/iaQpMFdGxSUjiX1m7Hd5swjBopQcvWgE8MhoH5iHQO690MCJK59yM6mzBD?=
 =?us-ascii?Q?+RLSgDqxk4G/p4B6xPmR+EwhzaquSha4SFDgLOw4vVmxFRTCBPGtDyyTihnF?=
 =?us-ascii?Q?vf72CoLZ0fIVB7d6XQ1dOvymTitD4Y5Ycu6H8LmVcc93B7SXpg8eWjO0degD?=
 =?us-ascii?Q?MH9nIGrDGlf93Xj+qwtcsl/LTPhs0cDPJAd9IgTJ6/zlRwM9jreosI7Y1fvq?=
 =?us-ascii?Q?wysqeV84tcXu5DcFoFVRhfu/lY9I+izXDQvXDU0KIYcpdYRyA6OvjJ9r2xbB?=
 =?us-ascii?Q?wiwHg4k688Cp9ENIE9ywPz8WNXfpNFGFnip/HPBKyAnwRGnABxfnr+lVJ0AT?=
 =?us-ascii?Q?d+2S3NnT0uPXicfvEqZ90AaX86icPWS+jG/53iLnhLiiGRcQC/W90Z/HGWsT?=
 =?us-ascii?Q?5t7XKSiErnzkMNp2EIlK5ukI5yJ/N21YQhlLZt2exMvqW3zQsNG+CArlSRYq?=
 =?us-ascii?Q?92hA/5zzWBZocolXqJyNO2E2+99tpxZKClSlvnNJlSxUrPM9vxNEqVn1h1uV?=
 =?us-ascii?Q?TWMu5Bp/FgVXEmKNiynp5iBEaempln+4TPPuX9MKiNph6BTlGGf6Bbsp3Xzk?=
 =?us-ascii?Q?sEBXBw3mhsb4CTe7hV4uKY/aRvMXrCcecX/LBu6EffztgD+MNmV4fvxWwfr8?=
 =?us-ascii?Q?ZiSNkYbTtRwb6NKTw7qy39bNXjW9FBYw7tJRW+aaR1mqrUKHfTobPD6/v3bJ?=
 =?us-ascii?Q?U9Fw2hL/yII1QNqrdAZwsA3VT89SsLJWiHXENiNMrxbMqhJSbsjzdCcAqWT8?=
 =?us-ascii?Q?76k/vj9CqixKBVvcySxBk8BaHBfIqfyblacM6zUvHP9PoxljbapWIy9KEXy8?=
 =?us-ascii?Q?TWb/WoxX35EJf3CVGx2UZFB2/KQLsjDM66RD9fWYehsaL2t3vHKDafbdAekx?=
 =?us-ascii?Q?zHmYNDvQ5e9pjIhfekO9AVgRbBllXq2PWx6LRmnXCmjL/cIVXRefPxlzobdc?=
 =?us-ascii?Q?G8jIkLPWE2zooUGdOzNOcUckzCIhWMvBQnTb43+eKSVDEYTuMbKWpGVr7OFb?=
 =?us-ascii?Q?mVd/307lzQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V2oKc6UW0ucQBaNkVSQT1o7JZlXCnzaypa8z+xgVL0cweP1UJBRirCA2rtkppaS9k9dF5Dz9EHsqC9/oVVf3oLYnqZHAHCEkR20g+y86eH/Icqz3TG8HVzo6IMlU5jA4Z35KOEK7/IRlSNqAtmj00vHGFlIHWOFL5RXpe8BuCoVr1UsasSQkSbMmllQI8DOKrud8CM3eF+afpgpGGKboflc9RQXt4nJKC8iA6CK5UZypR/luj0gpBLZd9uayaC2XUqfG3VrldArzDNMcyzuxKFH1WT1I+Ju0lbtKYh2i6/Oja0OMV1UaEgmWnysvuj5bERY67/bUdTGej/Ifsb4PlxbI+m9hoVeDEX5KQWuyYTZ6pHMrxV8rFHE7mYl+VEwq2IDmDptR6Y99pQC4nyTHOXPKiuEWeGIXxCLoCtVNJq6QfL34opJpNfZhLiM3YGhRozjKJ8ClR4L30fAuqNx79HlJ6EOTPiLN89MjKITtmgH94aa8hL5fc3dhAOycA5Essd+od+qpqLQ2KNPQsZFU6fsEx+8eQWMPyP7bn67cAj80bGRLHlAr0I7Zb59sa8lVEAUX5XgO5L/F0aO2LylVNI1QW42GklfvWtEVjo+fCZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f6581b-48e9-4c8c-2dad-08de5725d327
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 06:41:50.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EO7d+9Gbfy5CJ3E1e2JTOT1NQuLyphLywjcudPPXuJwnnPx+Kd7x5JxnHhhwY8s2ON44d0qutSJLPZ/O79jGPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190053
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1NCBTYWx0ZWRfXxBB8U81HQHRK
 tu8jP6y1MoVygYcD6mujwsybAacV9d+n59x7yny0SsCDFnMDC/XZmNq+fLcKRC1rdgZ4u44aXRn
 bytN3f/vghIQiKP3/Nq20jp85KurFMrTC3t5m0mHgoWkycSzNB5MzUPYigpGn6c/hybBqRzJPrY
 adIh+PDpzlOw8pagjAGBWnpt01G1w4mwUb+GP1AS7l4z2rkoCpVqyHUBR0UrXUX8DSdUP/6AEhp
 vIdVAnyWwuawP3HV1vMMYp+GWLMgNIH3E4Pmx8uoaVwUuSt73qhq5gZJINR+YpY8zFKawVYOnqV
 DumPYUvo4gNcmbvQlSoRvm+vUOCXjFDfpJhIDx5TxQZ39rA4bEt128L4R1tX0fGsxDjGdHbP4cu
 QoH+S0NleqqtuZTDSvmBPVqhjM5yMccK4ZYIRqxBUBO4GtngmfUs/uRKQ5njc4n9+FscFQAoSEJ
 GJjGsSpjFdufMgFRYCNgnGORLOplphg4XQ+VTCS8=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696dd235 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rNssqR8MEun7ibg-cOIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: ioUXTpB2R86zeJ_kpBU3H3-7bp6yiiM3
X-Proofpoint-GUID: ioUXTpB2R86zeJ_kpBU3H3-7bp6yiiM3

On Fri, Jan 16, 2026 at 03:40:29PM +0100, Vlastimil Babka wrote:
> At this point we have sheaves enabled for all caches, but their refill
> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> slabs - now a redundant caching layer that we are about to remove.
> 
> The refill will thus be done from slabs on the node partial list.
> Introduce new functions that can do that in an optimized way as it's
> easier than modifying the __kmem_cache_alloc_bulk() call chain.
> 
> Extend struct partial_context so it can return a list of slabs from the
> partial list with the sum of free objects in them within the requested
> min and max.
> 
> Introduce get_partial_node_bulk() that removes the slabs from freelist
> and returns them in the list.
> 
> Introduce get_freelist_nofreeze() which grabs the freelist without
> freezing the slab.
> 
> Introduce alloc_from_new_slab() which can allocate multiple objects from
> a newly allocated slab where we don't need to synchronize with freeing.
> In some aspects it's similar to alloc_single_from_new_slab() but assumes
> the cache is a non-debug one so it can avoid some actions.
> 
> Introduce __refill_objects() that uses the functions above to fill an
> array of objects. It has to handle the possibility that the slabs will
> contain more objects that were requested, due to concurrent freeing of
> objects to those slabs. When no more slabs on partial lists are
> available, it will allocate new slabs. It is intended to be only used
> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> 
> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> only refilled from contexts that allow spinning, or even blocking.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 264 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 9bea8a65e510..dce80463f92c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3522,6 +3525,63 @@ static inline void put_cpu_partial(struct kmem_cache *s, struct slab *slab,
>  #endif
>  static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
>  
> +static bool get_partial_node_bulk(struct kmem_cache *s,
> +				  struct kmem_cache_node *n,
> +				  struct partial_context *pc)
> +{
> +	struct slab *slab, *slab2;
> +	unsigned int total_free = 0;
> +	unsigned long flags;
> +
> +	/* Racy check to avoid taking the lock unnecessarily. */
> +	if (!n || data_race(!n->nr_partial))
> +		return false;
> +
> +	INIT_LIST_HEAD(&pc->slabs);
> +
> +	spin_lock_irqsave(&n->list_lock, flags);
> +
> +	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> +		struct freelist_counters flc;
> +		unsigned int slab_free;
> +
> +		if (!pfmemalloc_match(slab, pc->flags))
> +			continue;
> +		/*
> +		 * determine the number of free objects in the slab racily
> +		 *
> +		 * due to atomic updates done by a racing free we should not
> +		 * read an inconsistent value here, but do a sanity check anyway
> +		 *
> +		 * slab_free is a lower bound due to subsequent concurrent
> +		 * freeing, the caller might get more objects than requested and
> +		 * must deal with it
> +		 */
> +		flc.counters = data_race(READ_ONCE(slab->counters));
> +		slab_free = flc.objects - flc.inuse;
> +
> +		if (unlikely(slab_free > oo_objects(s->oo)))
> +			continue;

When is this condition supposed to be true?

I guess it's when __update_freelist_slow() doesn't update
slab->counters atomically?

> +
> +		/* we have already min and this would get us over the max */
> +		if (total_free >= pc->min_objects
> +		    && total_free + slab_free > pc->max_objects)
> +			break;
> +
> +		remove_partial(n, slab);
> +
> +		list_add(&slab->slab_list, &pc->slabs);
> +
> +		total_free += slab_free;
> +		if (total_free >= pc->max_objects)
> +			break;
> +	}
> +
> +	spin_unlock_irqrestore(&n->list_lock, flags);
> +	return total_free > 0;
> +}
> +
>  /*
>   * Try to allocate a partial slab from a specific node.
>   */
> +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
> +		void **p, unsigned int count, bool allow_spin)
> +{
> +	unsigned int allocated = 0;
> +	struct kmem_cache_node *n;
> +	unsigned long flags;
> +	void *object;
> +
> +	if (!allow_spin && (slab->objects - slab->inuse) > count) {
> +
> +		n = get_node(s, slab_nid(slab));
> +
> +		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
> +			/* Unlucky, discard newly allocated slab */
> +			defer_deactivate_slab(slab, NULL);
> +			return 0;
> +		}
> +	}
> +
> +	object = slab->freelist;
> +	while (object && allocated < count) {
> +		p[allocated] = object;
> +		object = get_freepointer(s, object);
> +		maybe_wipe_obj_freeptr(s, p[allocated]);
> +
> +		slab->inuse++;
> +		allocated++;
> +	}
> +	slab->freelist = object;
> +
> +	if (slab->freelist) {
> +
> +		if (allow_spin) {
> +			n = get_node(s, slab_nid(slab));
> +			spin_lock_irqsave(&n->list_lock, flags);
> +		}
> +		add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +	}
> +
> +	inc_slabs_node(s, slab_nid(slab), slab->objects);

Maybe add a comment explaining why inc_slabs_node() doesn't need to be
called under n->list_lock?

> +	return allocated;
> +}
> +
>  /*
>   * Slow path. The lockless freelist is empty or we need to perform
>   * debugging duties.
> @@ -5388,6 +5519,9 @@ static int __prefill_sheaf_pfmemalloc(struct kmem_cache *s,
>  	return ret;
>  }
>  
> +static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> +				   size_t size, void **p);
> +
>  /*
>   * returns a sheaf that has at least the requested size
>   * when prefilling is needed, do so with given gfp flags
> @@ -7463,6 +7597,116 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  }
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
>  
> +static unsigned int
> +__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> +		 unsigned int max)
> +{
> +	struct slab *slab, *slab2;
> +	struct partial_context pc;
> +	unsigned int refilled = 0;
> +	unsigned long flags;
> +	void *object;
> +	int node;
> +
> +	pc.flags = gfp;
> +	pc.min_objects = min;
> +	pc.max_objects = max;
> +
> +	node = numa_mem_id();
> +
> +	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> +		return 0;
> +
> +	/* TODO: consider also other nodes? */
> +	if (!get_partial_node_bulk(s, get_node(s, node), &pc))
> +		goto new_slab;
> +
> +	list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> +
> +		list_del(&slab->slab_list);

When a slab is removed from the list,

> +		object = get_freelist_nofreeze(s, slab);
> +
> +		while (object && refilled < max) {
> +			p[refilled] = object;
> +			object = get_freepointer(s, object);
> +			maybe_wipe_obj_freeptr(s, p[refilled]);
> +
> +			refilled++;
> +		}
> +
> +		/*
> +		 * Freelist had more objects than we can accommodate, we need to
> +		 * free them back. We can treat it like a detached freelist, just
> +		 * need to find the tail object.
> +		 */
> +		if (unlikely(object)) {

And the freelist had more objects than requested,

> +			void *head = object;
> +			void *tail;
> +			int cnt = 0;
> +
> +			do {
> +				tail = object;
> +				cnt++;
> +				object = get_freepointer(s, object);
> +			} while (object);
> +			do_slab_free(s, slab, head, tail, cnt, _RET_IP_);

objects are freed to the slab but the slab may or may not be added back to
n->partial?

> +		}
> +
> +		if (refilled >= max)
> +			break;
> +	}
> +
> +	if (unlikely(!list_empty(&pc.slabs))) {
> +		struct kmem_cache_node *n = get_node(s, node);
> +
> +		spin_lock_irqsave(&n->list_lock, flags);
> +
> +		list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> +
> +			if (unlikely(!slab->inuse && n->nr_partial >= s->min_partial))
> +				continue;
> +
> +			list_del(&slab->slab_list);
> +			add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +		}
> +
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +
> +		/* any slabs left are completely free and for discard */
> +		list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> +
> +			list_del(&slab->slab_list);
> +			discard_slab(s, slab);
> +		}
> +	}
> +
> +
> +	if (likely(refilled >= min))
> +		goto out;
> +
> +new_slab:
> +
> +	slab = new_slab(s, pc.flags, node);
> +	if (!slab)
> +		goto out;
> +
> +	stat(s, ALLOC_SLAB);
> +
> +	/*
> +	 * TODO: possible optimization - if we know we will consume the whole
> +	 * slab we might skip creating the freelist?
> +	 */
> +	refilled += alloc_from_new_slab(s, slab, p + refilled, max - refilled,
> +					/* allow_spin = */ true);
> +
> +	if (refilled < min)
> +		goto new_slab;

It should jump to out: label when alloc_from_new_slab() returns zero
(trylock failed).

...Oh wait, no. I was confused.

Why does alloc_from_new_slab() handle !allow_spin case when it cannot be
called if allow_spin is false?

> +out:
> +
> +	return refilled;
> +}

-- 
Cheers,
Harry / Hyeonggon

