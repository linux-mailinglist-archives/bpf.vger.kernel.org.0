Return-Path: <bpf+bounces-68141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F62B5365C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABD5581B3B
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFD3431E2;
	Thu, 11 Sep 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZpqhGdlf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iSvS59up"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A68340DAB;
	Thu, 11 Sep 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602358; cv=fail; b=SfA3hXm7RdTKYPwxR/lj+6IlVtAUrU/ov0kPmI3uKFlpCaQpAQsySlPZvotUX6SDmQXkQGQBg4pvmoHXKLlsMZwt+wvh7ePUiwWHRyDALsLsusHPrXTU1bi6HJX50eQ62vDLzd1cQAdY2NOyOa8qXw+2R15E1IHBcDD4XSzKcWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602358; c=relaxed/simple;
	bh=GoU2g9/P/BqIp8O/k27gVqRhvIULa0k6Ra2VrIH+O08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PFmYp5+hBaD/G4eKmcQfpjyLYEe4klF8vZ5vesZdjz3U5xfU2bnH0VWoMUgrjp88mj5BZzDeRdqgW1H7OTSzCiVJqcnFyuoE4HHteH5L37enYSjZ7ZLT9II4n34335lTzTPFkO60GHHxV/3NbSOFfE6px15cCzX3nfeuUtGQctk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZpqhGdlf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iSvS59up; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtndG011959;
	Thu, 11 Sep 2025 14:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yzNj+oIIa/qe9TWefM
	zm7KpDDpzVc3qHYrhnILAvd1Y=; b=ZpqhGdlf72z94jrDSlGMo2Ro37GZgqXduH
	EJ5jedDz88pcs1+6gmI3J+XvhYc3WnMUYhOl0kFUz0SRbzOiIwm3u414JUWOxAXZ
	nB2545FnQm63oOomQqDmaYGaUCirVQ/5qXvpL4c0qS2o0gdT+YLU3qQaTXLzyd2h
	qqkYfzu8/uZtZtQeCDWlbL301SfzbnCqi8dXG7amE6cvKzt2CzxV5ZWXg/Z49m9C
	ih+iyhpVvhjgoejesM7ZFZFf1azMWsjhmFRqWeUe+CGMeujA5U+ZhDnhtAkmVJJ3
	iPclyS0e/+KZNzzvu3WOISxBJFuRA0vEsW8mCL0HijK6rng3gGtA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sxf61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:51:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDRH3P002850;
	Thu, 11 Sep 2025 14:51:46 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdk32mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ti8EF6gZ/CzvADpN0EZRH97qxDyIgnTe7IiiT9NKTG5dUXww1PbZYcAoyaI1BQRA5vefy7WHX2PZspkQ45X5TZqRm992DL/jSk7LQigSepzCBmyPczp7xYiX4QrF4zoPBTiopZOrlV3AsJmcOZLJZGKeNzjjegDWtkaisXvVJfbly+0EuAtNpATS6xgzhjsSOo62oQP3rfShl4SerKdzZSFrvPydll+gnrqN7TvOYGeNs+iC9TGzEG4O5cRwCHjYPgFuxK1Engct92oSOjHmUBJ+zS7otDEz5TJ+TqyLTdL/JkVMYf/WDHaErEYpPDbux1zORvjPDj4zEWU1hIacdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzNj+oIIa/qe9TWefMzm7KpDDpzVc3qHYrhnILAvd1Y=;
 b=TlwMod6Ze5B7WUqOe8eF2l3xtOqor50zVCHH+2nn+dGi/AYX8dj9IQsqCe5186gn6a1yfX/a1T05+2QkXNSAw+O7nF9pn2GLIrlGjyxGUPTUnwOWfBQN7hroGc7c5oQJGAgfBgMY+q+3ZxJXnk7H1DwjaquxN33I20Uhzo+D/R6e0r6LIw64FbjGhU9PJRqQ7pEpcZ2nERGTdP7aE35+6eEQ3f1nY9rN6GF0LrrI1m/B70P1fNE6NKAznC8/mt5PU65UJffogtLRea2XV3bnPYNorGQ1zDULAzW+gc1kFHB/Nvt5cYRXTmt2qiQqpFQ0TLrUpzIGAfhcs6mdszEoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzNj+oIIa/qe9TWefMzm7KpDDpzVc3qHYrhnILAvd1Y=;
 b=iSvS59upaPaSOS0PkxyXXxthIC+nvMzdrEILRyQhDHqsS7D9I2WfNtBQ4zWd3ro0TYJMPgPYWN0zCBViNqict69uEftizJK6UJmu86v1dgKwKsOa8E1OC2lM+Lfumnj4x8btl0wOjr/DY7vSbfna8dhDsEryjEsmRjWXY4Kq0q0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB7313.namprd10.prod.outlook.com (2603:10b6:930:7d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:51:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:51:42 +0000
Date: Thu, 11 Sep 2025 15:51:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <c7cc3203-502e-4cdb-ade0-25fb9381d0f4@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910024447.64788-3-laoar.shao@gmail.com>
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: d3687835-a46b-4ea9-e848-08ddf142b883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?do2G2Np4+vRpgHoPA/VYEVbwzXHYVHQdkFSWgUMqaI/V5laSc3Gw0OAJ5jmp?=
 =?us-ascii?Q?ErYBOQePrzgh0UmW/fRn3LNBTdnJOKtNL98Q9ca5rCtFQDIaTGjyHaxskjeT?=
 =?us-ascii?Q?xOltwDXNiJI69QzylUrBgkaWvcfCD/w7/NnuMUxluLn7O5uzMPa42Sx5vvwx?=
 =?us-ascii?Q?d/b4A4rxFJCx3QYMecZOyfeqOk68u8slg8TClTILJ0sDA7ETs0gSJY9FU8UD?=
 =?us-ascii?Q?exPSKaw6hPYxeAiy0d/HmQDmwOev438lYXft3EUdzhQhstttcSdu/IGp8rEm?=
 =?us-ascii?Q?MmkkpxYYCtrakW+NNOOCA80Wys7XRpoXOovO6sQ+9WRC+GdChgNnipGuU2dD?=
 =?us-ascii?Q?rB+AKPves5y9denfv8RGNgW9QeI2FXFeBh7OWLqH1rmJd8+ok+aGoOj7ait+?=
 =?us-ascii?Q?HsN8t/EWex8B3zuPQUKhPQpVmR/iUn5OoYMEEMMoVFUaBNie/9V30TeZqrCQ?=
 =?us-ascii?Q?JyUE4l1opR2jB6ZAMzyKaW2utlfodxli1y+IkNxHBnCEAUBhhlc5M7dFvfOr?=
 =?us-ascii?Q?l4ulaBxBkiD3jITVrFI6p1tmsbNP/Qc63W17TuyUqCMEp1gUX+DfF4JaoMxf?=
 =?us-ascii?Q?vbZ0PocBDgjL8nSGAB2D9Zyua3UvG9IYoF6pBqgEPODqVu2acs8q/WZctEHv?=
 =?us-ascii?Q?rVJImluZDGJF3wXUugWYSUvMVqlRqtWa5p7LWmKTGTwvkbpElU7Vk8Mk55v1?=
 =?us-ascii?Q?QkfW1/LZEuTViPeHd6w+Jxulkz+whshJ1GnlX/Xk5O1n9mRQ2lZta5TbUUNT?=
 =?us-ascii?Q?q+xtfkYiyRFdNgin7lnZ6CFY0yKj1ljVUSJvknHh81Pqwu0koiC3RDjR8c6z?=
 =?us-ascii?Q?KBkU5JfZqL+VJIEoHdLnvRGleeNX54ttQ+zVlX79wgIf4n8J6WQa6FkfeNVs?=
 =?us-ascii?Q?+VOog7BmfiHGYB05WHo67ifX1gFORAhoPwF65lAOrdGs+eb3Ald2ku3nTt0S?=
 =?us-ascii?Q?/0VWD7J8vJEtKDi+QOvRipvvMwd72GbAZzgNQGnZaMiqSUmMnc9BJjFic5RS?=
 =?us-ascii?Q?8iVqRAkQr2XUfYqjG3JCV/yNuC29li7rE2zl1/t6UpLC8fnMpVbJMtH5dBXG?=
 =?us-ascii?Q?iIPqPrHw2ZYdeVd6VVkwe1qtWzBkRWk6SC+neS7+52EJlXSUXlOcrvJaNDZZ?=
 =?us-ascii?Q?hUElCCYm+Ky7UKOuDqHA6uv0afqVbMY6X9u2aPIW/ccyzItAel7qKrsDz3pl?=
 =?us-ascii?Q?88yWVnSMY0QjPk4dGpfloyhQvl4LLMdCu6tiElXanpCaRYNLhLwGyshg8xGC?=
 =?us-ascii?Q?bvgPLHR0XASQnzouogKjasKzcnJRzc7Kjw++dtmNdxZpmc5Rht+GlfZTIBdl?=
 =?us-ascii?Q?9qc+Gn/6ILAR68BzppeQTnp41MxbrwCWZFj46hwIlDldWPfefDZcX66waxh9?=
 =?us-ascii?Q?pgzviq6PUUngmIRw2ynh5IclrQNnqJxZPbvMSLYz3oAe6xq8hS+T0O58lZOU?=
 =?us-ascii?Q?ufCGOcB/8zM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIlu/kokO/QQIw28PdZJomnNxFzx1UhCV3PGQamgcoVP6QqH6oDzKPYoTi8s?=
 =?us-ascii?Q?in5s6jn0waUsR7E6U3q+YU1K7aVyUWQOCbcXpr0/2VxkB4qldGhTnDY2tSlB?=
 =?us-ascii?Q?r3o6shH2D2qbSM9fRDbcZmF3INaWot9n5rsd2A1Yt6xnY3vab6iQj5GudQfQ?=
 =?us-ascii?Q?mJzpQYEMIXsl9HnSOmmYFwMSqeVBUf7BIhjMcAvhvSy9SdSJBbpCi6ow7N3y?=
 =?us-ascii?Q?n6alAG/KQ4F0ZneOLn7RQv1DaJ1rRVVNUZqZHZcaINSodAKD4TnZA7AH8ZD/?=
 =?us-ascii?Q?H4rQnb/TyA4ZKUS2YYbLgaD/LF4yOrUyRZaL2r0gaR0BjdMhvVn/5voFX1z0?=
 =?us-ascii?Q?bbN35VKSrMU3DiLpc69HuzEPJbtg+59/Gk3BdLCwK8Z8O1ONScCEhqZaSjRT?=
 =?us-ascii?Q?Z0Ni0cuUuODTpdRvvHiiI2NhTMfp3XiDX+ZnrwMVfVpkIPbJ1uAnT6zppaWn?=
 =?us-ascii?Q?LB/UUBdnkBysaONN6MB+6rMtyA5qQzEK+tZP3RxrZF4w2tyubIN3/C+hZkLB?=
 =?us-ascii?Q?s0XhhlkaqxU8YfcvUKwi0+2gMJD6MmxVnH5aXcfcnJGU11dzlRAX70Eovy//?=
 =?us-ascii?Q?r6xT/DP+fT95GmOlb7PCBGUtJgTr2mqXb/RhvvPPJ9PgztAWXCeC/w0HzjDN?=
 =?us-ascii?Q?puQlhFFbqlSRVeMjL1ZjacVL/+qYaSG/6Fv2WPI20eLSiTIgTk3ojJzDFNnS?=
 =?us-ascii?Q?rQe8bi3CkGTBpEG4vJlByr9cqSLpio6C7kuGZCMo9pzkDCJel2te56P4JLCl?=
 =?us-ascii?Q?iGgwADMaORxbbx5CbXVXOlT9E1axEy9G+t4P2ZNO/bl04aW6t0WEOfqKl7ix?=
 =?us-ascii?Q?THVhvr7CFKGrVawf70GsDVT7mcAXV81w1kDTAZq+RPgPRSftSZPnlgmFKMCk?=
 =?us-ascii?Q?ktsbzA4w5EBdOdG2THG5N+mLaKweqc99LGY3czq/N59/uokLQJfkkd6Rf0eA?=
 =?us-ascii?Q?saDP+W2Tn8ERhz15E9735P60u5FpLHO5geb6ASEu9lMIs8G8rCpzLfbgu/1H?=
 =?us-ascii?Q?V6U23q3/JFxUmtKANwhqBjHnNoDhgnbXGi2uNE7aI9iIxOC1ZM8HxxRTTJid?=
 =?us-ascii?Q?j9bHs400irErT9JwmbjhO8piT8ZsyzJ7tFTeCkSBb+Ke1EFZcHgG9zzsMbAW?=
 =?us-ascii?Q?PsVHQTn2oRPL1bhZFxvq9ipvhZvICn0iVcPuqzp7kSanLjarTN5mk0MpRoEw?=
 =?us-ascii?Q?+sse/H5F5T+hCn+/kHWRJ7yTVSCR/v+hFmN/K9EO0QG5TAYLYeMuw5mBctij?=
 =?us-ascii?Q?wsHuMozdIOdyrDWfb6jxDMrSywu1bsjorU6TM9kHYvRGaWIHUhvOwWSOdnBc?=
 =?us-ascii?Q?VK4jw1YtOv8QEO2s4O/DxcSLRbeVvsOCIl4cbKoAY9LV2APS2R/76SUai7Fk?=
 =?us-ascii?Q?FNJK7ZBbqMeL9qCDjb2DZt1ZBvcQlqYN9NU/ivO5PLE89FZx5sSt7w6Awu+l?=
 =?us-ascii?Q?vjBBGEGWoburpTJA39MOPgygJhiBp0HqSal1r+C5tkrH1qaN9r8WcUU8Gcx9?=
 =?us-ascii?Q?j3RgOQWM2xeNNMGOJmEOYRFTTqKKWCOuyDKZKhZxJMazUC+uF5gGWN+ZJokz?=
 =?us-ascii?Q?ay64Be89za2hmeiZP+G9h563nR/6B/QXovgqgR9cM3/VIobQWOqJrFpbctzK?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/+MqRKxJlEEMbcbEzEApJl1SDjk29BFXHYUJig2sOU40HBKwg+dXs7kujldHtdanF5xPWFC2dTsRD1gbYhfiYxQtaDdrs+a8uuVx/73oAaVa8LzW3/W/ibBcZVe9WViA4GEFElFJ7VSclZPwTUo+wkRtP1WDLnQlQm+Uai3k+m74FQ7uxRtQsbbahEMssmTSFNBxsrwdFGC8Zh9kkqx0Epax7t9qmcxUXk1+pKnCbNoC3+YAt6OCHgxxcGQLThwNxN04GXB8cSWgg0HcokkM+lRs1mDW3L/Rt5jAs0RtC1s4pGnSScQO0XmIlYx5JiImFbUyYQLlnQAaVIZDDEcoa8pIVOV/8Qsopu1AJHMfw78UsdGIpRZdMfLVPEvv/wN2xnY9o39nRTUEhWWInJccNAl1tCFSTOdLY0sJ6w7ZC8/A8r6GENBcw+7PGZZOOHmiMKr9OqizFNekc6qERulYBFk37w4/75/mD22m7rsme7OBocXkc1msERKWS2+82Tm+e5z/e0S+wXM0D61IqjxwHHuvt4Lr4rc9r8KUPDj8vwA9HFSmWIEdyCLdVEPfTJZkwmjk0T/ZaM2e4jK//fCO+YHODELfccJjczZwzUL3hxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3687835-a46b-4ea9-e848-08ddf142b883
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:51:42.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Bwa5M45+OsMlzIjt+uSTe7jkCnOuJf6y48n8DMxxDfEgIHruTaLeIzDU8HRG8/mfJ++RG2cnHmRWDUGJlLrrwlo1YNAuMOqCN+bs2MCiAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110131
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c2e202 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=fnb1yV-MEwc91Eas6qgA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: GuS9Lf5E2tMfKKQmTVp3a4OEEstwEnKK
X-Proofpoint-GUID: GuS9Lf5E2tMfKKQmTVp3a4OEEstwEnKK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX/rApiCLA9WeL
 YeYoTJRxFd1k+GKqZwUTl7s+78rP1OrnbFtj863v0jNoUcQ4tUVJlYshmyHPrhnRJRYQP3Aqy+6
 37jF58/FIKOARkJhGE0LGUCi5RmcBJaOszK/AAfqNxFpV0s7mvg1SFWHQwaRxEQSr4V6RLjTAHk
 t6rtD5EQ9t4ZurfsScA0Qy7DO22sLgp76vCzeRO2V6FAdnSrN0iAixEbZmxBx9UqcYGD/xKoRqN
 ngt1P9QBw+VOKMU9IsvvY8QqvzemHOtUi1N/QWxDG/6ovMmveRhjUEX0cgNsG6lkGdC9qrpgD4Z
 ZmaouFmx6MmrJ5W9CoVm2qjjLYctSPBh4OfIf8GbiND9rv+xZvHSLraOggzSksEgWVL22sJyfTE
 TWAkaUaYlhf8AXXL7W1t3OTvbTrcYQ==

On Wed, Sep 10, 2025 at 10:44:39AM +0800, Yafang Shao wrote:
> diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> new file mode 100644
> index 000000000000..525ee22ab598
> --- /dev/null
> +++ b/mm/huge_memory_bpf.c

[snip]

> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> +				      vm_flags_t vma_flags,
> +				      enum tva_type tva_type,
> +				      unsigned long orders)
> +{
> +	thp_order_fn_t *bpf_hook_thp_get_order;
> +	unsigned long thp_orders = orders;
> +	enum bpf_thp_vma_type vma_type;
> +	int thp_order;
> +
> +	/* No BPF program is attached */
> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +		      &transparent_hugepage_flags))
> +		return orders;
> +
> +	if (vma_flags & VM_HUGEPAGE)
> +		vma_type = BPF_THP_VM_HUGEPAGE;
> +	else if (vma_flags & VM_NOHUGEPAGE)
> +		vma_type = BPF_THP_VM_NOHUGEPAGE;
> +	else
> +		vma_type = BPF_THP_VM_NONE;
> +
> +	rcu_read_lock();
> +	bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
> +	if (!bpf_hook_thp_get_order)
> +		goto out;
> +
> +	thp_order = bpf_hook_thp_get_order(vma, vma_type, tva_type, orders);
> +	if (thp_order < 0)
> +		goto out;
> +	/*
> +	 * The maximum requested order is determined by the callsite. E.g.:
> +	 * - PMD-mapped THP uses PMD_ORDER
> +	 * - mTHP uses (PMD_ORDER - 1)
> +	 *
> +	 * We must respect this upper bound to avoid undefined behavior. So the
> +	 * highest suggested order can't exceed the highest requested order.
> +	 */
> +	if (thp_order <= highest_order(orders))
> +		thp_orders = BIT(thp_order);

OK so looking at Lance's reply re: setting 0 and what we're doing here in
general - this seems a bit weird to me.

Shouldn't orders be specifying a _mask_ as to which orders are _available_,
rather than allowing a user to specify an arbitrary order?

So if you're a position where the only possible order is PMD sized, now this
would let you arbitrarily select an mTHP right? That does no seem correct.

And as per Lance, if we cannot satisfy the requested order, we shouldn't fall
back to available orders, we should take that as a signal that we cannot have
THP at all.

So shouldn't this just be:

	thp_orders = orders & BIT(thp_order);

? Or am I missing something here?

> +
> +out:
> +	rcu_read_unlock();
> +	return thp_orders;
> +}

Cheers, Lorenzo

