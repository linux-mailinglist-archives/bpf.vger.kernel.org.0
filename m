Return-Path: <bpf+bounces-79550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C70BD3BE56
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 05:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2C7A3530D4
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 04:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D254335568;
	Tue, 20 Jan 2026 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TIP/Nq46";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xC2cPj6s"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0023A99F;
	Tue, 20 Jan 2026 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768882900; cv=fail; b=VHDkc2Q/KSh60u1n5VAroTuUw2vdGlYuBQTn9t61uAMuNvGJwf02vheKPR7bQIKQzgc+fXtb4HUG8LmNuP51Fh48TeEBbHylC3spMt12eT6hKjtT1x4eg0oJQpjovOEqBWTA9ouYIggXxWoFh03Zsg89PYcP6cyo7OWpepC+Cho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768882900; c=relaxed/simple;
	bh=+BZ/5KdjI4sh7VtBHzVCPei2LZBPVfKXNhc7+EERWAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EhpXAyNCJDp0PyngnXlroSBjukFNEUQAtXSVGeZTGa4j1Z7FNEr3Hk7a9CXxv1D5IMsxAwH+Rfp2InIo4xMnKHX0kMvp4v1ZCexoqM5qsuz0yuBmFSj5s800hEUuhoRQu137yxtx0nTRw3vAZuwVtabepQBvE8n3wZgZY7/O0xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TIP/Nq46; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xC2cPj6s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K3MSaK2827185;
	Tue, 20 Jan 2026 04:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=N8tMZAloZ9+mfKpOTU
	e2HlrkPsg9gCbuEXriIbA7cEY=; b=TIP/Nq46w/pU2LepLLS/GCJkVWebXDD+Hg
	XeuN/YOS4irEOF8wUpbMU/qg/kOURb5moSuwjtM6p8N2E1x9GbPQBJV13XwY5+Nm
	MtOCq2I9j26HDxhLtEkugme6Iq/4UvaJwar3wocQU7/VJ7N5V0e0GzicoDFLx3gt
	wJIoYCy996EE2Q3ivfWEhLOxnV4l5+sq6hB8as2neChAXzlkEIoo/gnvABk9Igc+
	6FwnVDuiPG8jQ7FwZKI0aA0D/GjDd4sR8XxRYMyd1PdCntf62lFb1922IKDaU1cF
	q9A+JsUYIzdNCtCgmGLrwNeBWEHnSemLzmdi4ZzsDDS+dL0A77Nw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8b21s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 04:21:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K4Esa7019067;
	Tue, 20 Jan 2026 04:21:01 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrpvkx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 04:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+14/EnkyjC0kKazoRlNdkeC03ItRFtGpZAHiLFGCXw4uh4XOaA6Nv4TK49aWZ10rBI3P8PuuSx+vtdgGgMXsRkBrnw6eJuf8oGfo76zCULwCW7Kw64wcj4MuLA2O1RzMc8HYwtp8emdULLqtD6r+Ttci6mmEuA9AzBa+JueiAmvibtThBiZQuYVYmgH+l6X+f7ee4J3fEKx3FQW3+TMtOlLFALyXPorVR8mw6SDLHNks8w4zimuTz3GJFI6NcjO+1Fgn/7OzS9W1dGi2Yun0w3G0TpafmbJcLKmHyQfv2eQls7AQHPMcUUBIYbFw1s5sjKkW7OLz0kdgxs3UbR0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8tMZAloZ9+mfKpOTUe2HlrkPsg9gCbuEXriIbA7cEY=;
 b=G7QZhLpOCUcubFC/rCxK5G7kXAmC1QAbuFPuKKiddVPcu93KfpVTQr/65MJH2nWbBhaoi4uBQtJZWlFogzpXHVPnmmywQ2mi9q8Q3hGiYn3xNDOg0/YXyIM2dpGGM/SkGlbEuFEktCPONLcF4+7CUR1sypMiAJdfDvWGIfiHFuSk0HpyGlECfuNbnzG01epy169NEjYghD9VgDckSkz90TRqai6M9XnyTPqhOHZBuCQSUNE+VuVkyvhGTSLnGgA2IWLSY+wnry37hyM/7aR6gavWrazJe6mPlWujBL4n+yJLCYs6tMwJDeBB84L0JHpCv+p9O/SjYfbTm+HTTV+Akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8tMZAloZ9+mfKpOTUe2HlrkPsg9gCbuEXriIbA7cEY=;
 b=xC2cPj6sDxniSll3epZ6LGuMe3Rta3tWmdQjppG6Z+CxnbZkTk7sGQdUJ05y/IKbzOrolznudeKiWmp+GEf1U+XN3N/nig0FU7JedN2uKRwPxObcq9MEWRmBy0ydNMtY7MS4tXrXgrSMstQ1sxTWI3dEkwGm5pFUjhbxamHArPA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV0PR10MB997590.namprd10.prod.outlook.com (2603:10b6:408:344::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 04:20:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 04:20:58 +0000
Date: Tue, 20 Jan 2026 13:20:49 +0900
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
Subject: Re: [PATCH v3 10/21] slab: remove cpu (partial) slabs usage from
 allocation paths
Message-ID: <aW8CoUkioJFywI4A@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-10-5595cb000772@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-10-5595cb000772@suse.cz>
X-ClientProxiedBy: SE2P216CA0005.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV0PR10MB997590:EE_
X-MS-Office365-Filtering-Correlation-Id: 61377084-22e3-43a9-f388-08de57db4fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26Ef92fCz3lV24hZGcpDp+/m0YRwoaUL3iGdj/q1yMgAtafMzQ2mLsKDx7wR?=
 =?us-ascii?Q?7OfBbsJiVCGTJGPhud2v87pivty5gpicnF6fOKJoXu6vC8fHoKGnj8Ua8pIZ?=
 =?us-ascii?Q?tmE7Y7aiojwKvVjiyqrX5OIjQkWOFlPy7jCew8leu34sAHtNYqdvgzWBzQB/?=
 =?us-ascii?Q?sMxDCBHGtYsn/6EoGgpsimGqOwAa3G4oVfBmRqXZi20jkNYgBJba4SucOHgO?=
 =?us-ascii?Q?44n0LGZd2546dnJgDN48WyAVP1N0PO0YfI3lzyqk5Ua3Ld4VXeAeRjT3jaQK?=
 =?us-ascii?Q?JWz89ZvQ7R1my8EhQy6ERp52ZQW1AowFYeyVqmdNJiFf490rH2LuU8nk5YbL?=
 =?us-ascii?Q?JZW/FhBQySdTJQejq2CB/KQECkxmUOT1IgDemvGlPSYNPFdLdO9tBqX50tN1?=
 =?us-ascii?Q?glReOhm66+nrIX7NO6UTzIeFMhBXKrSHgY7D7VRYfQOKwmbar9YPP4TmObxB?=
 =?us-ascii?Q?iZSl5lQysp23qq1av3dk1dc5Q5fE4/VrUftP9VTmW2FZkEF2EqwudNa2x7OO?=
 =?us-ascii?Q?mG9Rvi0MnBAu6HWtrIwPsZSulyI2RNO+aE9sdSLiOih4w/ZGT0fWp58wwMh+?=
 =?us-ascii?Q?UfRv8doidLAMy1vMrsxgy+B7E44bfW+nrrP2aCpAYSVGP/5jjqb+HkLDaeoQ?=
 =?us-ascii?Q?dulKMBlTqQZnlIiNhyKIJdzTYgA29fD3K5mDvQvd1bHaimbZJeDmiJXASF6M?=
 =?us-ascii?Q?19ze2MsQ0xbpUHG/LjyWwzgk0+v2MuHTz8Sgo2If5fX+GDCfoXnQ/6ECjO9S?=
 =?us-ascii?Q?lNxGumGkdLFNOPik6Ia67vIbAtOYC8Duzj/jtO8b7z23biYCvx/UhrmacRRM?=
 =?us-ascii?Q?34zbkf9ZyRK0K/pD33HISrT5pWuOFIDgP7x1QRCScFmHqFK9D7+oF6Gz+AHK?=
 =?us-ascii?Q?8Jpl7Bi1I/HoE+jqaVsAXe4bAMurh5V0fgr7k4EvF18nbd4aj0k8cdFaSD/f?=
 =?us-ascii?Q?KUA08lwTe3jbwR75aaEVAkN5+WiFRymF/A4f7x6I6xlS60l+fEWUnAuISySO?=
 =?us-ascii?Q?tV2EEPkGAApD8D0ZNLAm8nHzCyBoJWCZy0yJB8un6I5XAYXbHx2VloLVioon?=
 =?us-ascii?Q?A4Gg0jZ4M25gxghQaeOej6aqM+H6f5t3BCARqOM5iMVTV5AlAmy81GrmA72p?=
 =?us-ascii?Q?bvVVNjp6lYY4mE0+tzbSFjs93yXLDEyNKBWnt8OlCOewdz1m032VWgcW69E8?=
 =?us-ascii?Q?vXs66g8xSSZ+I2UfMEWUIsZ4y+B3yGGd+unioC11JbVjimYFdwqnvCSyI05M?=
 =?us-ascii?Q?gkNcZuHBzSPvPsB9hO7/HdcIIFLvDa37o1RYVQnDeSu5SEGyVxA+lnSbCtfM?=
 =?us-ascii?Q?swOJhVcibQfO1+Dkg/znutaTR3YHjM1V0H7KCA92HS1sQtz1LeSI0Nlas8Tr?=
 =?us-ascii?Q?LVlXQYSVsW9wQYYWwMRcPHQ5OQst0QHwOHqFbOv/KzqgxyGm8qKATNXCVM+u?=
 =?us-ascii?Q?D97u/qLVa/2ykD/sN6mNXB9fdMQBgfPnDtnzCiHl8iZHZmGnSgbEp6sbjBwv?=
 =?us-ascii?Q?wlfp39SMt70bJJafO8NSoKIRsWfwGa+HmjaGK6b44cKV3ZMp6zPAwBVbtL0Z?=
 =?us-ascii?Q?CdgJ2VeUhmn5KfmYlTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2vwHjnlj6VQ8MWt3lRmPJYCfNC+ieZokc/m0eSwziTlIx/TL6aJU5kPVUUB?=
 =?us-ascii?Q?VpL1HDyHBbaX0Z+aI/yBt3d+HKYF1TISTbFrz6js8WRxixHre+zNiLDHySre?=
 =?us-ascii?Q?dk+78NPuU5Nz4/qxcKTYijTXumLxnz0XcDMe8yCIDP/K3hdbP2yX9E4Zbq1f?=
 =?us-ascii?Q?QtzEhoqsFORH7uMqSm1x+jc9Yp2DRvTIrZY+Y98Y8wsmxj9JZgHwmx2BVgSj?=
 =?us-ascii?Q?gvuASrLyNOgLk+WhI3pLxxPVVaj//05mNUeXSRz6vOJ3QDdrK4fA2b5zPMxt?=
 =?us-ascii?Q?jnzcQ00YDQll4E7KBKFH2QX5wDZcCiJdRAIt+YBY8ZNCaFlLjpLdajzMLRGm?=
 =?us-ascii?Q?Vb3o2yOJKV+lpdep+uyt3eEYoFqCFipjmOas1y78eF6xJMVA3bCnsr88toz0?=
 =?us-ascii?Q?W8bmw+R+c7TozoshhSHeB6GvFI3bw8HefbJEOgy0l9TcHaUIMx96aoYMRFdn?=
 =?us-ascii?Q?UZ9uwxbSduVJoaw0NYpWzQiLQvDYuqWIriuK+Ke4H1KI4DWmhreHpjUraPg9?=
 =?us-ascii?Q?qVAeqboBr1FkvRaHKnvTwWhUGH5lcD1oj20LTbF543mtxaUAQENOWXii1wWX?=
 =?us-ascii?Q?+7sKy3Plew+k4yYPd2QSlVsppox2kt03jXP5js8s39bTW/WMkZVlhuBeZx57?=
 =?us-ascii?Q?zeBG+QMP7m/Q6Yt4FmFRCB25lnMmxegYqidujLCEt50poae6uiGobhHF556x?=
 =?us-ascii?Q?kuvTr61onJFdsJINWuEOFIGxz+QpTAm4hGtkhi9wKJJIS2CEfkkZap6bsvsD?=
 =?us-ascii?Q?wlFpoVx2aX+Lg/aozrd9Cb2KHY98JLgPRpEwwECiemk1R7eBoLms9otqFmp2?=
 =?us-ascii?Q?4zuxb+sa/aSe8eWve5jjMGtOyXx9QrnipftIEoWOFDFY0N3MVRLezY8uQins?=
 =?us-ascii?Q?FE5F2GTVvPNsTpC/oIUceO/E+J1dnigtFEenoYqP2wVWubijx+nSPZp+arfO?=
 =?us-ascii?Q?4kFy3kZNc5GbmA5XOc3g5qDZjCwTUbB8tWq2XkaJv0UmPHQZvUJSAu+bJXj3?=
 =?us-ascii?Q?v1gc6JXeEuKW3tExZmDUmdRda0Jvwyr01tEGQPGRFSY2dK5TX/3rOZ+hbHpE?=
 =?us-ascii?Q?Rbzu1BSanORk9PiIE7e0FWhsY5ga8BKeM9xumFU8EE1Ep2lzTASQKY+8h+N9?=
 =?us-ascii?Q?TIZeTFZUZTBT92oVEGtdxPjn/CsvuKb0vM7IzQ5i5WQE0wN3KzxJ3FLS3DLs?=
 =?us-ascii?Q?6Y6GCcl4xEpyKMsK3GtP/bkW+TTqR9Q2bQwKbuE9af7xIvNUMEenABi8H4Fq?=
 =?us-ascii?Q?jsQkirxwcyP0AUyqlP7tXYyhxXeuj0qvx1Aw6g4lgxyAHwUXGF5y4sCotmxJ?=
 =?us-ascii?Q?YMb7W6V5cxjeJel4W3au/nJM3l3Cl4ZsWUNPsFx44Z4RBfPQRldBo+fggaSq?=
 =?us-ascii?Q?RGhQHZN5Z3X+5Ss/cUde+yFTppFgdRJreDRZlL2PEmD5P1XktTx69I0+LIsn?=
 =?us-ascii?Q?pFQpNz+YfRXpCdrw+SJI266OKQoPpz9G5iSVeI5JdmZ6PftQiPoGK3oH2et+?=
 =?us-ascii?Q?7YrGOIQB/YJi8LMxkT7cS/66zheKXs6yCi/trdpJ4aXFNNNPj358VcBd3TtQ?=
 =?us-ascii?Q?ehWRDEJtfYEOv89QjLIB7ZehK3K4aGV4qOxiAq6o8ZsGMkG1SpE22K7KE2AZ?=
 =?us-ascii?Q?kfykSvX8hUYIjKs4lx6Ivd5kqwX6Lvm+BAtEncfJPUYCMXwJZnK8LWTSuCOe?=
 =?us-ascii?Q?nPF5CVBN1CwMXfgkkB0wtGiJc34v9HQMpDUGVpuYzFMPJh+i2X+C5ZM+LRFD?=
 =?us-ascii?Q?QWAj9/bsWg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Lwbip1+qrUepmhsxULVOu3nnp0fH6FgCOc8gCaXT9vBlR2Z5zgfGFmv+M3og6gZ4W0GpWSaccW1vZzdFzz/nmNZrQRmHIDS/lXnA7Q7UALBnORiDq9ad9vtI01oYNn5RDEpUsOSvZqkp2+MFdGd6E7FZzdgDKXVsM0UwmoyU9msUW4REPk4WOLK3EnOe5LzndgmkQAj+fUQvxUNswDS+hQHfZAK/Ay0HXsQYvTcIxiQvW2g7au6AunpUaTbvxQQii1k8O/mGRHYhapwqczsHBrvCDqtdo10Tpz2+wUj+pyWvygw6V2thuE/Vpd5kCvvOMNRHvZOZhTcE93Jq2TSVI5XcGCgBi/ARaEpxvc+N9KuqUQDu59zZRCdzlioRNisNOk8u5McGixYEFO01seIIrvM7wEwO3D2cmeH/cGcY86JHceJDinmlGsPtew4dQAKurE7ptILbLgO+d9kS7aOetOi3mMvULQ0ZcAH1calAe5RovQvvIlM9xhYIzIEOCYnkA5DXomsnkHqLp7lDPYFin6HAnJ7+113GF3015p0cyvT0h7f4HLtbnEAwgHU2qG1fT8Iogr1aO0DGB1onv/EFWBiL9YEAw8oZs/0mL7hbUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61377084-22e3-43a9-f388-08de57db4fd9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 04:20:58.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WaISYmpcM7zSqh5s6jOmOo2DAkDNb/Uv/OBSGVzgXygTyPt0lJ/TBw40NsINwnwqfika0iLzKN0zuAXaQEWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601200032
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696f02ae b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=NWL3kqaZZgNujDXQq-UA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAzMyBTYWx0ZWRfX+WNyDNLu5u3p
 jxDbaPhVQ9EP5JYO/SLIWt4LvtCZzkuJpUEMWlEp2bM/ykh32yl1yCJRNe2LrFgt4FFLsRufNfj
 gKUGLz5lT/mdSOnzzcUtpIVGy6GSIrrZ95o/JoO9BVK72dLWjnH2fGV6/9LT+rx4lmMcLBDxs97
 C+LiC8k6orj6Db4YejA4RUxAKrhccEfWHQwGd1IF8bhIjmN2cD1HRbiujIpX54Lt5dvZ5Vzjly+
 KjoYhBa6VqFNVOQh2MhvVP0JpEn2GtuIPDBaBSxgb9fiRF8HjnwflqvDYHGIj4s44lSLunNNrZG
 piXl4xpoN4IPTj5hRChS1QxQfJa2LEPWhl1Rs35LbdlRm6m+ZPGpL8oxGslk5BbZydu83B1ltYE
 QptOhdJc4fPXHunQ/A/jtBnrJ3+DZ36UlBTiAIr4o3CfOkzacq4CMxhaVNFs3jdCAnUEGcNCPwo
 yABgHN4gr2s+0VZkmAz8Mjh01BCsqe3AqyGGflco=
X-Proofpoint-ORIG-GUID: TDqPnFSAYZVqy1Wk70z8VAernFICv_AK
X-Proofpoint-GUID: TDqPnFSAYZVqy1Wk70z8VAernFICv_AK

On Fri, Jan 16, 2026 at 03:40:30PM +0100, Vlastimil Babka wrote:
> We now rely on sheaves as the percpu caching layer and can refill them
> directly from partial or newly allocated slabs. Start removing the cpu
> (partial) slabs code, first from allocation paths.
> 
> This means that any allocation not satisfied from percpu sheaves will
> end up in ___slab_alloc(), where we remove the usage of cpu (partial)
> slabs, so it will only perform get_partial() or new_slab(). In the
> latter case we reuse alloc_from_new_slab() (when we don't use
> the debug/tiny alloc_single_from_new_slab() variant).
> 
> In get_partial_node() we used to return a slab for freezing as the cpu
> slab and to refill the partial slab. Now we only want to return a single
> object and leave the slab on the list (unless it became full). We can't
> simply reuse alloc_single_from_partial() as that assumes freeing uses
> free_to_partial_list(). Instead we need to use __slab_update_freelist()
> to work properly against a racing __slab_free().
> 
> The rest of the changes is removing functions that no longer have any
> callers.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 612 ++++++++------------------------------------------------------
>  1 file changed, 79 insertions(+), 533 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index dce80463f92c..698c0d940f06 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3607,54 +3564,55 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  	else if (!spin_trylock_irqsave(&n->list_lock, flags))
>  		return NULL;
>  	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> +
> +		struct freelist_counters old, new;
> +
>  		if (!pfmemalloc_match(slab, pc->flags))
>  			continue;
>  
>  		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> -			void *object = alloc_single_from_partial(s, n, slab,
> +			object = alloc_single_from_partial(s, n, slab,
>  							pc->orig_size);
> -			if (object) {
> -				partial = slab;
> -				pc->object = object;
> +			if (object)
>  				break;
> -			}
>  			continue;
>  		}
>  
> -		remove_partial(n, slab);
> +		/*
> +		 * get a single object from the slab. This might race against
> +		 * __slab_free(), which however has to take the list_lock if
> +		 * it's about to make the slab fully free.
> +		 */
> +		do {
> +			old.freelist = slab->freelist;
> +			old.counters = slab->counters;
>  
> -		if (!partial) {
> -			partial = slab;
> -			stat(s, ALLOC_FROM_PARTIAL);
> +			new.freelist = get_freepointer(s, old.freelist);
> +			new.counters = old.counters;
> +			new.inuse++;
>  
> -			if ((slub_get_cpu_partial(s) == 0)) {
> -				break;
> -			}
> -		} else {
> -			put_cpu_partial(s, slab, 0);
> -			stat(s, CPU_PARTIAL_NODE);
> +		} while (!__slab_update_freelist(s, slab, &old, &new, "get_partial_node"));

Hmm I was wondering if it would introduce an ABBA problem,
but it looks fine as allocations are serialized by n->list_lock.

> -			if (++partial_slabs > slub_get_cpu_partial(s) / 2) {
> -				break;
> -			}
> -		}
> +		object = old.freelist;
> +		if (!new.freelist)
> +			remove_partial(n, slab);
> +
> +		break;
>  	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
> -	return partial;
> +	return object;
>  }
> @@ -4849,68 +4574,29 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,

[...]

> +	if (allow_spin)
> +		goto new_objects;
>  
> -		stat(s, CPUSLAB_FLUSH);
> +	/* This could cause an endless loop. Fail instead. */
> +	return NULL;
>  
> -		goto retry_load_slab;
> -	}
> -	c->slab = slab;
> +success:
> +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> +		set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);

Oh, it was gfpflags & ~(__GFP_DIRECT_RECLAIM) but clearing
__GFP_DIRECT_RECLAIM was removed because preemption isn't disabled
anymore.

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

>  
> -	goto load_freelist;
> +	return freelist;
>  }
> +
>  /*
>   * We disallow kprobes in ___slab_alloc() to prevent reentrance
>   *

-- 
Cheers,
Harry / Hyeonggon

