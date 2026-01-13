Return-Path: <bpf+bounces-78636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C8D16421
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F11AD3015D3A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB72DFA2D;
	Tue, 13 Jan 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KU9yB8N2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="thUqbrG1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F223C4FA;
	Tue, 13 Jan 2026 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768270152; cv=fail; b=D2pz/T4/frRDJMDTeiRpzDEHUuqk2qR/OL+EYOaczhtTx4EyYxxx0DdolsJzeWItKob1K1EgrP82QJBVGg1pgZaeDvWNNGelYI5U1vVO4scdiHj36Z6cU/gh4Fy17ZEs6nrUKOkTekhkYIJIR0BCy+FHt7Gf2awGx6N4LW7nylQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768270152; c=relaxed/simple;
	bh=dK+wUe7T+ndzX5dRWYpzZeGTcLV/uLGN2tY7DhIr6RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=prvkUPhnCfbypoArvyle6HChFKJWKjhdTz1iHhGAlQZug2rRi5YxC8IIgNxyAwOf2LuP8hZU4YMXMf24fjJtSpwv5yELLKRkzgK8nPKhL+FbeOPp/tyUmqnkf5IvT7nQeTnHHtQQwbQlKNAcPPiPSvVDzChsSZ3K2xlhvcgu33M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KU9yB8N2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=thUqbrG1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1iFE42685997;
	Tue, 13 Jan 2026 02:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1/hftVT+vVnWQvhYgl
	lBtzQan5o7gn1Yv+tsNyif6sM=; b=KU9yB8N2mqe5GQmQ3cfsYTxU6vXdGJuDVj
	0kMg/CDFfR32QrHImZSDJmZ1qAZTNOwsuDT0Impl86z/eMD40o//zUwSbxeYIh7P
	qEN1lda1dAePwUAa63AwmwkFbxpMF5Y6ndTAVQ1Bjii7K9bf5UMG/r8As8hMIds7
	l094O7D+MNGuadBtCys8zgL6yQXLnlffmGPWGcp0m+keRplZ7X/Jk73/BBV/vs1o
	8SLiYKN1Y75pTaHWIWxkxyyw+Mz37gQL84iDGC74O3Gcwlp/FyQ3IlfM90o8ORx0
	GbYuTYcrc25z6t/ioj9sJ5Cnnq8PAv+Kk9KmBH4vfQi2vu7+Cwbw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb2rqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 02:08:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D1XM9C003921;
	Tue, 13 Jan 2026 02:08:33 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd784269-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 02:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMK1bcCMsYU0itkdoHoWnr01DXgDrGxU3em7QSV75OXmJB1Nolsy9n1slM1C8xNbUod4PlP2s2I3efpYuHl+5i73GsdzxvmSdHJlKo+zS8lQ8elMPdDMAItvLsrF3UGykiiXcnbq2aSBL2tujCMa/zrjr9wxlw9WjtCjVtaU4I5Se9GRXYBcVKg4vAFBi6U2B8HlpOShRHfbUiEH3z+7DRI1x9b1pHRrBF1F8okp1HS1wu2dus/lgxLUK5e5bfhYf4Eu36gnzQ51orFtlW5vLp/uxssG6L0EFAvvsqNgvaJyMgomrz9bPkczCdk53Etd/Qt8ePPQvZtqJYYpL5g9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/hftVT+vVnWQvhYgllBtzQan5o7gn1Yv+tsNyif6sM=;
 b=eB6CkQ6/WZi22JHCNSpbrnWH7kKbsiPDnEIikPID8RLwUrs7SPGqmvKqZ/xFtlw+atafowwKIzEYksS+5Fle9RmviCcmAM6b5MIrX3PpkwIKUwkujb66kTQZvg7NP3whuKFlZl7EQHGknyvJ0JJjFM3shTX/0N7tQRg0RTIzuIO69/aFfzCePxSTF2Kp2JbD0RpkddU0uhLPSVYg+Ma+/O5/K2YFHjJTrMCJ6L6fAIctPnNglnsHiOYxk5htWJlxKd/9sRamTdEwuMFLe/42SAq4h6gUVDJp/f5ri8edb0OXxoDCYcbMOTYGCNo4RKt+g2rAqbDYhZfcuUE0CE71WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/hftVT+vVnWQvhYgllBtzQan5o7gn1Yv+tsNyif6sM=;
 b=thUqbrG1yv1e4iW8yWVTwokVs1yAwQshnHB3j44r+3yy6RqNnVJ3Hb15GhbFFnvBFOWTjqno8TRs6q2XHykYIRWm/qrf8XQZqQ9QCTeIqLz04jniIJsJIsWmb2gx5bOkQUj3eGBY6pT9pyha//VS6w7lKJf7vK7gLOxseBMw+Bw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 02:08:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 02:08:29 +0000
Date: Tue, 13 Jan 2026 11:08:19 +0900
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
        bpf@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH RFC v2 01/20] mm/slab: add rcu_barrier() to
 kvfree_rcu_barrier_on_cache()
Message-ID: <aWWpE-7R1eBF458i@hyeyoo>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-1-98225cfb50cf@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-sheaves-for-all-v2-1-98225cfb50cf@suse.cz>
X-ClientProxiedBy: SE2P216CA0134.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fcefe8-93ea-4b12-114f-08de5248a4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ahwxvERckPWqi3Sz+3FW+tPMVarfCs1axq7omVP6yycmoWmsosqJypM+Df4c?=
 =?us-ascii?Q?yw6FSwyOR/0hBh4HygjfZWBT8sRHylVwlNJhL0J5ItO5K5ito9sEKUNegdc3?=
 =?us-ascii?Q?G+Wz6OxNYMWWJcQ8tYtISZextePH4F72o03RxtNCrxvfoMMqshJd85nE5yiS?=
 =?us-ascii?Q?a4Qy6KAsINmQVKVQo6b5NndnHbMqPiWEQ7tAjNq6yNfK0B/3YttfML2TW2VO?=
 =?us-ascii?Q?0FXNrLcnHEHaGOUuE6OnXzDNLElYPfUzKSx8r7sAF828qIJpcnUfgeemaPKB?=
 =?us-ascii?Q?GuexM2rVi1vNEXe5RXDj27ba6yvGdK+QDUaARXvM3PtCdtB8P+H9hyJ+iVDV?=
 =?us-ascii?Q?C/naOTG/Y60hYvijAy1FxyBYGX+p7qadBAa/MK9i9bQ3GE6vKtVTPhSwXcP/?=
 =?us-ascii?Q?PolkD2Rf6k62i0+L95LZDUtgjSnoh0rC/cNs7JC1SiVfA2fLXG1ep2278yPO?=
 =?us-ascii?Q?75ySb2v0fYdyqHZnc2J3tbhPvZkaeJMo3G+kHxgnB73JjHY2XzkTgX7+qXVW?=
 =?us-ascii?Q?7YSTKEo/8kCiGDuIJSJPugrBcuXcrrZwWIEfmg3eqc141Ox+Dwd8N1L8pgVG?=
 =?us-ascii?Q?wMJbRVa+n1Z6gHiTKY/tXWWt6WgeQU6RPFkGQ1aMrvQRYPDqhn5BPW4ERQxB?=
 =?us-ascii?Q?OLSSvlnYy/L3YXWClobN290A3Cct+WTitKr9wadyb14UdENWYOsmtrwwlPJe?=
 =?us-ascii?Q?5QcKNK9W6zD+h3RCQrvSaQYGZYTdwTf6DTRZ40Bq8j/ROZig10ULDRooxmiQ?=
 =?us-ascii?Q?KZqjYAbT8ulHM4z5sZ8b1nnnAfzFpWj33pN2J0T8Z/PiwdG9/+MXiZdrJIiC?=
 =?us-ascii?Q?ky/XRTBaDoRPMRADlvKHFg+H9ErFnTfdZsFPv8ICD2cHgXGE3UCQwMjNoUTz?=
 =?us-ascii?Q?nienOgThvsT0YCWShIVojgf9sMQK/6LZozLI8Ndxj6lZMSO13viiRu+tz2Uf?=
 =?us-ascii?Q?dVflIx1VnhQwKYU4iwGlznOl26cs4EBqooQY7iKzP6KFA/HZkeWGe1zUAPzj?=
 =?us-ascii?Q?Tl/wSyYh5FJpqG9vMkhnycyBAOVe8xIopRohVZN2t1oCPLZqMnspGeswiLuO?=
 =?us-ascii?Q?Zh3Q+23oMk3qj+xIfo5JBXZWMfrGamN/cSpFVB5LVsrGQ4RC90QjXnaUcSiY?=
 =?us-ascii?Q?K2m9JfDHtDWVIsHxV0UESIWQNaRia970Ofzn8x7Tt5kb/OsphdZkHfLHr/T+?=
 =?us-ascii?Q?zlJnl4o0YJclEC7HVlNVr+UucuJ69bbOPFP87WMNlf1MhLaTwVrqjGnuQdOe?=
 =?us-ascii?Q?DepPFqXloR+7Y2J7192oTGvUkpDqCshSMByZ45ril3szdpK3Y27n84kuucG6?=
 =?us-ascii?Q?o6935H4TqrhAnbVtQZxchGIgliMnrH9XhtfUHlkRB7VkVq67IC42hgdYy/7j?=
 =?us-ascii?Q?XOxLEa0MHC9zScxDXOudnYnQE3QTrNuX0c5O1YaMEZ2P8lM88s2TfV3dx8Nb?=
 =?us-ascii?Q?3DNver7Qr4W1D5n6S8cGw3UeHpFJamaDyvdqujZIpYsNujVtb5lHQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwprTqC9qYw1rBQji5FEMqBPwNbIEM6xYfkBwwybmQbU94sUPyhb8lOIAIRk?=
 =?us-ascii?Q?6K9oWWJQ7u+ct0DGcCNgqpQhGR+ks7uSi4d/b8sxX0aVoklUs6YIve8VZAzy?=
 =?us-ascii?Q?ynCVQd8GWRRkVUCGo3jDS9E5bRFqO9mIuWNynYet2MG7xdoAYc3h6aaArXEc?=
 =?us-ascii?Q?ucaEmQ7vcv9oxSEbT1a/xTxHL4ZDyCEKsmr+Fh+Ra+C/ay58hcZMFLZSy3PP?=
 =?us-ascii?Q?glZvKz2WcWjbTRGuKmEyFOMVn7nY92W/cnCJgk8Re4VP/C4UCXzRzkQ4Z2g0?=
 =?us-ascii?Q?1fVTZXmzXqDW4QLKAaECwtHY7TlMX0LIMiiWSeIaWbyDNC78bHQc0406s/VU?=
 =?us-ascii?Q?G+qPdEaBvGbptrTvuJYHvxhP2MYUEsm+0Xr/7ijE6IZudelP0ENxvwrrHQYE?=
 =?us-ascii?Q?+hdDpxiBnKYK91QeRbbJk11qCYZQArC7iF5rEgWYMxIxUZVi2YEIk9xY9BNp?=
 =?us-ascii?Q?TTgczs42cBpmHA4GzS8y3PQHfkSlrNnFDDKV5CAv17scXQ6bz1FTU6xYISoY?=
 =?us-ascii?Q?y0uQZ/kj1oBA44LcOk2N1AP5+PZPh8lDROGDr/u07Umy0vt58OjoF77Mco37?=
 =?us-ascii?Q?n+g69FmRKiiu7NEbYcSjxTUAMbdCGEuPdVsy59ujeAtkvnMgkkNMHDs7xLu+?=
 =?us-ascii?Q?uHM6GTCDZCuGMLlzxbQ4IrwEb3jHBj6pyeZnpL5ymWR7EGp/h0aWnR+G8XSu?=
 =?us-ascii?Q?T4flumJp6UolwGIq9L/jdiE/dpQJOftSTgv0E84uExsmi3ebNulE6MwGjwnM?=
 =?us-ascii?Q?y+i97WqWZBldjGw+2muZOtzhG0w5JanqYrdfKQY+zvgZVmmxlwgHts7T3rDS?=
 =?us-ascii?Q?5Ixxj7dNJCb7312YcNrIlKTrvMF9E/63nggQMswloVdYMNJyDOft6g362WYg?=
 =?us-ascii?Q?vtbjY9U/9n4nJb8mbDOrj6I6k9M7+UoC/Fkd1xGtSH7N/uzKAFFeXRkUA0HR?=
 =?us-ascii?Q?ZPDDRfjLV7r3gxBcuJURIcZEbKoiSnmDQNLtl2aFkd3FqPvMbcDCWInQNVMO?=
 =?us-ascii?Q?z3h4vvVgmfW5Qfv/69yYzqX7N/I1O0EuAaP781nRJyahyD873nZRXdp0FxT4?=
 =?us-ascii?Q?1QTxa//32Q5iSbQHr2+thLXML7dDOvnG/IOo8RKnRsLdZbdKZXbijdop6YmM?=
 =?us-ascii?Q?Mf0e+OtBn5uzc6lD6mBJvucF7+yKoE61ic0Qg6jF5s7ifPpMu0wv3UuLHND8?=
 =?us-ascii?Q?ib4xAxDnp9jQ1cjSeH6olIQC8E+5/QnwIexsVwgLWWHYDmy6w2IpP1AlAH4y?=
 =?us-ascii?Q?zDM1zbB6W3YIo9ZNa7GeyTTJGtJqwG5dQkasUciV5T0GzkhTqJy7st4BdQj7?=
 =?us-ascii?Q?PXE8STfpkWnTLUq672SoWs03QraBHW0nRTVUnLp719h6dvKIeQe/BB5NR0Lu?=
 =?us-ascii?Q?CHbQjdWLr9oS8BkKxcipi+IruGjdtnOb3B2ySJQBe3cJhlWNtH+pf35UYi2b?=
 =?us-ascii?Q?KTAsD+SMN7vHxaSejWaqjnWuH3e7YjlFsVCU53GCbeUmE4G9B569vczaHvu8?=
 =?us-ascii?Q?DXwrVkfUGV41CH2G/3YDhu0YnsqExymHjCedi29cDJz8zJLIDR6E0XkK8QyT?=
 =?us-ascii?Q?G3RFbjJ84+QGQDPF9HeDSpHan45GjqBrtdalQFwYx+79Yloh6Nl5mQgspA9W?=
 =?us-ascii?Q?2fN0y9V2cpwnjgC2++UXBGSBYPixRR0HsegO3oAJrgibO2/vDODW3gonSW9Y?=
 =?us-ascii?Q?cqA030klzo1tSQ1kcFeOP0soeZPXWmZj3x6dqght4fGblQ8pcbhtsj9rbAww?=
 =?us-ascii?Q?v16Rr148kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qJlrKI2HEzt1Y/Hbkvao1QUoBnBI8BfRQs6NOggeiM96pHHLOkvWzWWI64LgQJIQPuvatQjce+EynG2tlZJtL+3P1Ss3/5m6UDx6BhP2baU4987hi3aHfwHpEXlbWQYIYZYpnYqrWIotCZshuiSZC9JNkNn/N366HBeWYrLu3V7z306RBMyLtY10dOpGbEQbx5+YQ2/cDA9JjH29PchP11/ZxOJ278FX51Fn8tBI2XjnTqffomxDpC6kKjcVVTdSlqWggMVxZhoHJuaE5luLPEJh3ON9aUuR3lZpxsJPzEj3cWMEVBbFVKi1HJxB5+ecBmf0V7EeaAg0f3L7QlYWdf5QYxjGroFoGpakXGFYbMzAb2d+NnaYUkD+dbYjDSTuzw9+LTkr76197r+pTnWk80uU+rNgkG+3T/cspICK+WXs1YEp1jPohJSDvPF3xRh3L7mZPHMJ/gCftQ/sHrt9THmgYVg5QcSaa6wwIJXmuEMrK6uSNxcV/mipdPAm+T07UjHaNUPUr7IrrD7H5nqweepOWZboy6Cb/L6XzQqxEvYqntI+20DhgEOWg3+TnTuJQopVfZ/+MBLySrLhy8aXgHcaXh43dnGfYcytPogiYNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fcefe8-93ea-4b12-114f-08de5248a4a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 02:08:28.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RXT7NmSZsO4hQXq1Dz6LvcUTDubYZY6RBXO0lig8z9aqzHg/wrngksqbZn49rb9S8BMp92XqyZXilFLqmHSpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130016
X-Proofpoint-GUID: Xr67118Ooycheau8cM1L-nHMbj94UglO
X-Proofpoint-ORIG-GUID: Xr67118Ooycheau8cM1L-nHMbj94UglO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAxNSBTYWx0ZWRfX31xaBlolCzXb
 54lL4WASL1Dru/og1WTw5nOiz1BIS6Ms8YLuQ/zF8fwco4sRi9zUelXHt978fMnOH5aCDE1OtzW
 cKD0cqsDYhG3dIPRp+sakaW9TlZkeZJAV2VKVst3tiVVQmrpM1fgSmah5uj30WtXSZATr1FMTTr
 wKvspXnt2xAq7+tkDOmU2PQLSo801rrbVm5ZDpOKiuSAvhVHAd0mkEQcEhmBwVoU0yhOc5sizkO
 fnWkj0mLwYgSMC/v7Nxm4vaKAcuUMeY+qNsB0LSDLJkJSAolrXEzDa2jT/md+6QZOVQdnfJR3fI
 dJOE1FWEpPwMLxZysU5NEF4Ts7fO4WZ71cWBCLtauDGLc/c6R7deesk/FNTjJjaJyrrSUtN6JT4
 aHZRo/bBkXaHL96r01NE/iCN09TBELRemPlxk/nG3u33YXiXUWeUunycQ7m0LzltMBM4J00G9I4
 O9kS/iYJNC1bxF6jDxw==
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=6965a922 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=5GxzKOEUuOeV4qbXql0A:9 a=CjuIK1q_8ugA:10

On Mon, Jan 12, 2026 at 04:16:55PM +0100, Vlastimil Babka wrote:
> After we submit the rcu_free sheaves to call_rcu() we need to make sure
> the rcu callbacks complete. kvfree_rcu_barrier() does that via
> flush_all_rcu_sheaves() but kvfree_rcu_barrier_on_cache() doesn't. Fix
> that.

Oops, my bad.

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202601121442.c530bed3-lkp@intel.com
> Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

The fix looks good to me, but I wonder why
`if (s->sheaf_capacity) rcu_barrier();` in __kmem_cache_shutdown()
didn't prevent the bug from happening?

>  mm/slab_common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index eed7ea556cb1..ee994ec7f251 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2133,8 +2133,11 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>   */
>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>  {
> -	if (s->cpu_sheaves)
> +	if (s->cpu_sheaves) {
>  		flush_rcu_sheaves_on_cache(s);
> +		rcu_barrier();
> +	}
> +
>  	/*
>  	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
>  	 * on a specific slab cache.
> 
> -- 
> 2.52.0
> 

-- 
Cheers,
Harry / Hyeonggon

