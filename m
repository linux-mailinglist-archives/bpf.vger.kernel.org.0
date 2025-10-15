Return-Path: <bpf+bounces-70964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BDBDC171
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 04:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 135504EDEC9
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 02:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4225D546;
	Wed, 15 Oct 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MGiERl3Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HkUVXN78"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E625A2A4
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493611; cv=fail; b=nyw5rVYTD8t/o3Zpf+j1gjisKPJbZ1gGvoU+Rm0RgMtPm9PbO2lPPRcW/hfMO7Qbgp13N7/iJYX7Bdt5Ad0mI7oNctS7qDYhdlA/2pAetVFlLTASyWOehF4Hsud3OlD+U7nMJlQBFUaW7hcowd1b7d/MTqvJFV9r4XE1E7LftLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493611; c=relaxed/simple;
	bh=ry9JE56xADhBBZG2emufB59SK055OsYDhRGPRTg7Wmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=unjfZmGtPG2AMYwuvURn4FUcbFDjXO5U4eE2xGSXyl44dWTmpG1IZWhI/H+EgB+isKZs0zlDrF04InLXj+fK0usiXPycKqIoqUU6zWTqXSLpfrkZkCmMZdwj1euoJX8dPm4UoYdKrR2CxRqIhIvTJBXRAgqa3cIVxxD81t9v324=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MGiERl3Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HkUVXN78; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F1uVWr000535;
	Wed, 15 Oct 2025 01:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9ZMFI5krc7FK44WQyI
	j2StW+xMcP0ptXzsfMFRXu6Po=; b=MGiERl3QrJEgpIALSPTfEVjr2oSzwYvKLb
	lb0ajI8pKl6urwXm1dp0MXIVNRAQOhchHyJW9X+mN4kQEcH36nIEaD569XsbP2ZP
	OwLHUk1G3WZNxKKQ6K3EM7tiYYtgWVyL1N9hR+u7xJ6Ak+AIie+/eeCM/1QIMNfz
	RNCrqageNi4muqPM4CxprbknlyXLUDxgTUU38yCVysUg9grF9YqqrQBOg46Lt4wM
	eASXmL896kNfKykYrZf087cHR3JFqMnegnm5MfC+cTY0ABy4GX6MrUw4canlL/x9
	2r7/yeuFFpxihVogD2Vtb9RNzjKQxSneWyBBiNmjJ8/nHQgvy+Tw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47ngre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 01:59:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F1T2xh017696;
	Wed, 15 Oct 2025 01:59:39 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp9pd6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 01:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t29T6qYtQWKoDGVoqv7gsgZru/zEnrh1lAukAx8F8ldJbtd2MQFJzIIL/RBDqDkHuJbHlb047b2zFPuuQEwDvxOdSsJM1bZci6kG5UBuj85m/MMSvxXyXeeV/7/Bl3RqPrcwwGn/dwjCsQ7HMGDvH4m+OBHcbBUq81P61wZ0Y8I55En7yaAbvVzxHxuOXdQuSKW6ZF4C/031v5gvPRl3MEqD/+C3z/cTTph4gqYEQDzJQ0DFIwjsF0DCp4It31Xcd6FrVk3zd+lRPJ+GETwaeFY5JCZeQAa9xCDtv7zc9D4yLzlH2HzBPhBhgbGpudvToKTwV8t5ff1mCqN+fTWnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZMFI5krc7FK44WQyIj2StW+xMcP0ptXzsfMFRXu6Po=;
 b=FvF1ei0TIBsi4mA5V18xZcW2Ok9OjhmgLQN/Oo3lZPXeHQCaBC4TkFadyl71OHMzO5BHh4fqhBQUON7GT3ovkYs4pxr5KiBROWmXug2QqwRLJNE4z9yp9hkS9WsFfngjUeim4eLHo7TxHerWRbbyHBQ0xiUWzyDrW9yhTRRkipVDlblWvp3+c9Xakx0Mg+xGaNdZkFCAzHmbFWcEGaAzq/+CLB1mD2e3Lwj3dom8jQF//R93n95TH8EHt+YgRnTx0wkVBKcqNhJ6wpqoUDQ36XwhCw06Pu10XOxTFHlNgxqGUWFi7RpMcrfdA80CfqqsNNLCUAyxooD9IYOtH4XgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZMFI5krc7FK44WQyIj2StW+xMcP0ptXzsfMFRXu6Po=;
 b=HkUVXN78gB7z4MPUSLNBJlW6l9HcvCKCNZeVXhD/48769oLhiz1ap5C1+VOuYlDxUiCh5KyyXPlkgByXj6OQz+RkC+s5wAlN19fiR5Avga3z+rVGJhFgddwMmhNGSAWIPEBHidnLB7YAm+DnQBBeM1Hghn7wcVg7uE1vgUKmOuA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 01:59:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 01:59:36 +0000
Date: Wed, 15 Oct 2025 10:59:28 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, shakeel.butt@linux.dev, vbabka@suse.cz,
        yepeilin@google.com, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf] bpf: Replace bpf_map_kmalloc_node() with
 kmalloc_nolock() to allocate bpf_async_cb structures.
Message-ID: <aO8AAD4sJA9ORlO5@hyeyoo>
References: <20251015000700.28988-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015000700.28988-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SL2P216CA0109.KORP216.PROD.OUTLOOK.COM (2603:1096:101::6)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM6PR10MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: ca11fc2f-6037-4ce5-30d0-08de0b8e7e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jkoAUyU8V38/Obd5i5+V5ioCr7xKtnC4IeEh5WQnGZY4Dd1GkeYMNcBg8SoK?=
 =?us-ascii?Q?0BMbf4ERcJrsutasiwCsF2vh8aI+BD+cZSE/dxmTTyHod6VGfChjbXdh62KE?=
 =?us-ascii?Q?ci38svIBiXcbiMMJy3ZBhiBdWjB6yB+To0xFgFctZrHeoXx6mlzqjzhFfk1O?=
 =?us-ascii?Q?yZu2zJ2pMjjzAJC2PBfeTM89ubN3S1ah84nMiSitnX0rSxycOl5SQu3qCcKR?=
 =?us-ascii?Q?FWpdCwE7VaV9vCrsELY4XRm5fNy/QE23vAQbYdi/6+yD7LdlC+ui7/yAmt33?=
 =?us-ascii?Q?xW+IgUe/TBgBUh+GbBnTUDcFhNwEwvLgnC4rJqKp+948Wzj5KEFKvdIr6Spt?=
 =?us-ascii?Q?+3BSumdZMECve7Shcgf+iyyORhWuVbpkMR4+P1Ei5CiAjbbtZl0f/KV+L8Ny?=
 =?us-ascii?Q?i4HSPLcB+ItgtIyw5wtW1q5rCpL1v8QYHnk6TX69UftXeNJX2AdR9WbwN1kQ?=
 =?us-ascii?Q?iwsUQ29KZH94O6+I4XU7I7YyHcGGFDyV6y318VImR+ICnpq+iL6rYoeDwWSz?=
 =?us-ascii?Q?cDbWj4uD0qIXGbrn+yGaveHaItFhE0d3xFpzrnVWN4Z0TaK2luFXtV1uOIwO?=
 =?us-ascii?Q?Tt6IkVJ5zuHsm5i1hjGWDChyFZBp/Y/jojeZfC5Zf5MS5fL0xcXK7BKMTJhK?=
 =?us-ascii?Q?XIq78jvsLYG7Q1IcoXODsVdreJJ7mYn3X12lyUdQonITKvBNfq09kwYw5b83?=
 =?us-ascii?Q?aIa7j/qEpwGkSTktLf4tNuJrFN8KW48+oHXGKS8TdJ9wNUcsA0TmJ46QmjTE?=
 =?us-ascii?Q?amqqNY7CzECIWWMLX154DyDzW8LXz3i6spIsuslKA7BXtAa4NJLfPPLr1isH?=
 =?us-ascii?Q?TZrEjpbicQRlGpBVx74cSS0Q6IDPoWZymsD/TkkBqaDIUFHeYvlwUY8fsBAI?=
 =?us-ascii?Q?yAP089V4AtXwHx7S84s5Qc9avlKceguTX6mAujOsopoBuGeazHMnmyFOAOX7?=
 =?us-ascii?Q?CyxtsZxgRSEOUOQveX+165DrG4PF5DoR0uFKf5+tu82fvIOUsC56fbrHwXy1?=
 =?us-ascii?Q?ycCkNNUtNBfY3VXOlpELbl7MoUUGt86hywdM0gzVHmOzi2oY0XLcx974Vu4a?=
 =?us-ascii?Q?euSsbflZRHilQsgnDXXeQrCuQCpwBES5Nm1Mp6ohD0jFJeOggXWSptjjhKE5?=
 =?us-ascii?Q?MAS98W991kX9KL4znGQhNte7t8Kf1XFnoLgxqb74fe8CnxOFTLgIcx2pni4L?=
 =?us-ascii?Q?n+MpOhoOnxdoj+JIZJIb3vTWt0sTKlL4KrfYdmpa9pzVjrLir53QwxFev/cz?=
 =?us-ascii?Q?y6GcKeknTm5OpcgVCHG59mQTlBP6ZGE3wBJPuB9F9h6GrjZxOURP/qUkdg/J?=
 =?us-ascii?Q?vkM8XjsUAa76W1R//LtwTdlyHPfsfLAjtncSOCvEgWYKIpD/MGjy04mGUl+f?=
 =?us-ascii?Q?5lZvfm6F5w2O63zEFqOnrAz5AVBRzjrhPwO/ekyg82tJqGxrStwSBylvTWzg?=
 =?us-ascii?Q?8bPnPRqhJOma79KmNCWMlerRyz1zxnDG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YT5kMDkliI4v3gUX8E+0TRtAxrnuoc4Zaf4+zFe3Q/675od0yQvQlsTaq4iR?=
 =?us-ascii?Q?ctxCNsuxWzQNYgUpEqROT+7UMDAmwCe9fBVlJZzQj7eK5vDOEdbjWDWF92lz?=
 =?us-ascii?Q?yCVyfldTtCiPExFs8jGcR4CrFOxg6NcTDZ/4CVbXO3enZPnv8lMHbXMei+w3?=
 =?us-ascii?Q?tc0dsKL8rESfMZE870AnQMZJxnarmiAcmnTJFKZKdo3UTTj3iZNluNaWrF6Z?=
 =?us-ascii?Q?sdU9I/gKGOxd71/i9BmxKb0uhsfoswPMsefSKEZtfergwj8OPG64cSBGblEz?=
 =?us-ascii?Q?xfa1raxyEITn7k0ZODDSbqvDgbOrVMdns9WGZxsakOsedPRi2fypkIz0K6VI?=
 =?us-ascii?Q?qaAf4MIPdMtrzk6ak8cV2OK0s0pUVKA9DF29jlsAAWEss+ErTuqI5M4luaWl?=
 =?us-ascii?Q?r/U25yC+wc55CDHIofS1R2s9xGB8aTqPWTK4a8AjG4rT7gqO0e7J/GG6bNJp?=
 =?us-ascii?Q?32mecZOj7Y3tz1UrEThvLlSaX29VrtlHh2QDi0ZF46a+rJtIs1fTGKNh7Q/0?=
 =?us-ascii?Q?rZsPMphP9HWv2NdtJbCKC3gMymCJuSep11lrv9m5qpnbSNQDweNE2ieEwK5q?=
 =?us-ascii?Q?UbDXIpm7IbTlACZI3dcs1lFLVcl9DKvbOnakATno6zK2eY2TaJ14W5a2aCIS?=
 =?us-ascii?Q?CAhxGDgKS/NKAnkcWkCHTHjQ/WxNCG7bzbUqEy+f8FesvmaHtaopZblj5pAu?=
 =?us-ascii?Q?Q8FKbnXLC14N4YKbcS5AeeJEupUk2liU68iksQYrSym8tpG7nL5xekuRjY4O?=
 =?us-ascii?Q?M5hEqBFKEo9mDXjSLLN+v1ZMKgrw0AmSkRA/3EXsxBZbRbfhfE9PSdN+f0Za?=
 =?us-ascii?Q?MvVcrGTNXgzbWHQsp3yihahSToEqzwou0d6wpIO7aNc39q668uE5qQF9gWPS?=
 =?us-ascii?Q?xwimIG0qxDOQMtPwu7L6nxeydlJ1BPSgrekG0VQbf0H8gULR/Q7Tmdbkbw+y?=
 =?us-ascii?Q?IVeMLgmkTh6RiOBL/HHMUTim203szKz61+sXK9ParSuF7jdfFp3c3OjJx/NT?=
 =?us-ascii?Q?POxRxfbyg52JgXmJcVzl/UVhxI9MFmhJPVEUg0dF41c3IGfn4/1Jv0RApG+w?=
 =?us-ascii?Q?svthZlbziJKFG3nDbqYRASAaaZ4jZ3U80248tK2/ym+DmioemrAJt3gyWwRQ?=
 =?us-ascii?Q?zuDeY2lRO4lkUwrEGfgI/uiBnDJTSJuGweWH1A2N4CnpQK+ir0Hlahw1Sr+K?=
 =?us-ascii?Q?DdbJzgUWnZOppjFnvSl4LDistaRwAVt4/FEWVyjJ7Yb27wmjW9FBbKORRk62?=
 =?us-ascii?Q?sGbzkG133DD20y2jYfd65VQmqBaGnHf5cohN7otiLAjcNeNM320Ylazx0mGx?=
 =?us-ascii?Q?Xk+K2LipO6Hh3CZRCNQpo1JgENRpgLE8+8R+/VcTUFT+YC6wVrS56zdrIM2u?=
 =?us-ascii?Q?u93CARt6nrAH0PXd+kMVLZEtuFum+PS/7p31X4kJUQQgOucTO+/5RnZosYPp?=
 =?us-ascii?Q?JoyDy22NlpzXKDLIXOPd6P75gDmwybv7LmF0H/L2J/0ijcoOwtqdkDTYgkNL?=
 =?us-ascii?Q?fQTKRBcAM/Q2QZOwNA0yMZVs99A9zdnZQUZ20KxRtfruKiPWY267K+IR6qAw?=
 =?us-ascii?Q?I4h/QYG7INg8bYRs8j/F47NIio8v70T6K3vS69GQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jbqHZWg8tKWeg8hn9BZO769sSO89iyg0Msqpc3uju34FjdmRgXpxplRz+ED+UlxmI4/oaMq8q88Y+aMoAyVJ6ONYdlbQJjxaHlRB9njs0I0sGhbmiyR+VKwl4/GrsMqIM8CvwoXiEnOfFn+sVe0a7EdlEKfNQetT+L/TEzVMxB+/LcBS/XNleytV30MELHayCq1ziw5oSz568Db/BIo9ZBuaX1ZZvJkmgSibTUqiJO2bUqd7wGFl5gChVP/CMbbJvC0YctjOdv0LdHXKVyroGMjzi7yA8Bl8Nk8ek2w2otvN9o3FlkU01eSYlLGj2em8+kPlKb0bEwZDc1UFv0fwvYcgtCkXpnzAI68OpZuIIPJvwpG52Vwvv7xjcYctEzbiK5jF5Byga6MhnVhDAGBDMjrAdLkPFSKbF9PmTxvVB0Ef2gODOMw+nLj/vQhxy+H+x5on6p3Y2tGAVCX6w9QXcFUdZnmcOBmCE/C+X1d6+qyyJNP5p1fgObLIN7p458RcnGC0IJwfNQNiYtfe8ZQMronuwRSE03Icq/gSWJMtPKNue+x+YxIezlxF5x3sl61cl+Y4p4utt+XK5MLiOWHwzYs+jS/COd1GOE/siC4Tc5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca11fc2f-6037-4ce5-30d0-08de0b8e7e4b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 01:59:36.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnastE0fmxDuOnpbEdeeZfhKbnd8ROTmds5HzAN+kBva5JVDt/6ZpVaM2mf9SppsdopLT/cNm01q+hKKhHzkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150012
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68ef000c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=udAy0s-rzoGLULVMAOQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: IfIif6teXbEfpSdkzNXtftUcU1hEmeu5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX6Pd5Albm431H
 CXaIGvtTdE5d97iSVV7QRFLBVekfZlIBEZ1Jbm+o5p8sXwZzb+vNta5XitXlxEazfpq0xt+efPp
 mtqi1F//dsnN+Id72jD1WzxTEU0bWWePCt7PruOLOrIp0rrBJcTc4ezFI0JUelqtfsICaVBDEPW
 RclgHvyrl55STbLNROwEMDO98aoAVBGpeg6o4PcvZ7z8d0SDW5UXDa2SJr1hYODLZA6hC7aH8bE
 Pd2FUP7edSJuPtQNR7gT3+4GW4XJaN7OG/q85rdSGSCVIuPsxt6yvKBhIxzWxfhqLEpUXajB/yX
 HVsTIMe6DW+qhH0J1yX/xinudbKYUXUH4pvoHjUOji3zF8DkaDXAEu/iVYAFapgnikpNZRSyvAh
 y7djLMEcgFt/Cp97eW4hRy1U7+FfQQ==
X-Proofpoint-ORIG-GUID: IfIif6teXbEfpSdkzNXtftUcU1hEmeu5

On Tue, Oct 14, 2025 at 05:07:00PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The following kmemleak splat:
> [    8.105530] kmemleak: Trying to color unknown object at 0xff11000100e918c0 as Black
> [    8.106521] Call Trace:
> [    8.106521]  <TASK>
> [    8.106521]  dump_stack_lvl+0x4b/0x70
> [    8.106521]  kvfree_call_rcu+0xcb/0x3b0
> [    8.106521]  ? hrtimer_cancel+0x21/0x40
> [    8.106521]  bpf_obj_free_fields+0x193/0x200
> [    8.106521]  htab_map_update_elem+0x29c/0x410
> [    8.106521]  bpf_prog_cfc8cd0f42c04044_overwrite_cb+0x47/0x4b
> [    8.106521]  bpf_prog_8c30cd7c4db2e963_overwrite_timer+0x65/0x86
> [    8.106521]  bpf_prog_test_run_syscall+0xe1/0x2a0
> 
> happens due to the combination of features and fixes, but mainly due to
> commit 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()")
> It's using __GFP_HIGH, which instructs slub/kmemleak internals to skip
> kmemleak_alloc_recursive() on allocation, so subsequent kfree_rcu()->
> kvfree_call_rcu()->kmemleak_ignore() complains with the above splat.
> 
> To fix this imbalance, replace bpf_map_kmalloc_node() with
> kmalloc_nolock() and kfree_rcu() with call_rcu() + kfree_nolock() to
> make sure that the objects allocated with kmalloc_nolock() are freed
> with kfree_nolock() rather than the implicit kfree() that kfree_rcu()
> uses internally.
> 
> Note, the kmalloc_nolock() happens under bpf_spin_lock_irqsave(), so
> it will always fail in PREEMPT_RT. This is not an issue at the moment,
> since bpf_timers are disabled in PREEMPT_RT. In the future
> bpf_spin_lock will be replaced with state machine similar to
> bpf_task_work.
> 
> Fixes: 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()")
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM,
Acked-by: Harry Yoo <harry.yoo@oracle.com>

So we're losing benefit of batch-processing via kfree_rcu() and
instead using call_rcu(), and I guess it's fine since it's not very
performance critical so we don't have to make kfree_rcu() work with
objects that are allocated via kmalloc_nolock()?

-- 
Cheers,
Harry / Hyeonggon

