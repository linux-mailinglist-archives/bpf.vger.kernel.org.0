Return-Path: <bpf+bounces-66812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617CFB39A71
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8210D170453
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301730C616;
	Thu, 28 Aug 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qYg7x9W3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zy4+BvHj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDD30CDBA;
	Thu, 28 Aug 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377683; cv=fail; b=Myo9WLQNuN85IKnhPcaIKLdO7qJJOZUEkO/pWwryrTQXZ4842tkDVAiE3Ol9nWLYf+KIPFM4hCxHHA+MAAToH/R7AOg4ynNXwE6rTIrl7CwgHXP6ukQxH0/0J7MEii7EvVlKRlKxeY747x1Ti3K2RPYvAxxfGf+dlzePIdsPsC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377683; c=relaxed/simple;
	bh=9GqhT0StR8UF8iPVuVwbhtp1eQplakoicvYHQtNy6jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iqEXN4sweZfOKiPJVTG6seJWgVZyBDDCKZWVXbVXP9mN7iU13y19E71x0/p9AG12d8JvDiRhbBfk6gUdKtYK+wDF94T3HaXjBPbH4lqcCZN+sqqoA4LSI0bCveNXSDd6ypJFFZQd6A2q0/4ATFqWm4Axw2VnrqykdoL0Ykc2c5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qYg7x9W3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zy4+BvHj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8u1Tv024324;
	Thu, 28 Aug 2025 10:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ikQxlHkGBkfSLtE+j2
	ESvYCXcfme20kAumWS5SkoCF0=; b=qYg7x9W3lnieviN6/qcRj99RBzm2ZNHLOh
	Hy9os8KoIFBWZtLFK0elkD1zJ8W9a+oQOH8hAbWrnMGzD49doaNwBpseghMzZsMh
	OFbM4bX1zdtUM8nAHAguRZ8DDdm/hCxa6up1YSwJN64w8IjSVHFYlaaFkgnmk1dP
	kP6PTBTS2114x946ZePciC1q7PblTQ0Pb2aNmjVas9yp1hFMmTpZoMSaqmYEzybF
	FQ8Q5uz1lDUzGcytr3UuCiwT9JqFrhlDWwph3nQNTb0OgqMjCKAZCV0y6WaPmf8T
	FvJ9lYujb7Qvti7v7eWl+J/5DdwZj1JkRiNsiDTPnlIt1JkBLYVQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twey6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:40:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8VRqA005107;
	Thu, 28 Aug 2025 10:40:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8bykf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEJBXYqst7LQ7pFIfHu3fToy6MVwj4GErf9DZYGcV1I2tup2Yg1r+gZn8kWn1gVGzzAY3hBh1LYdAbvQWOozEsNsgoizZtFrPIK0gUUnmgJD72At6SH/jKHd2XeaqfU0tY1p4sTUVNMryxSLmiigsDukppWCkXnHZwYSzLHtA9yLwudph+R++EVasf9tiVapO/RJtCWGs9rRzsNa6j4Nrz5pz5h8R9ZQyzMEoerNjIcqvTzuN1tWFI33UdNxuJweWuoJtu7MFGdZCcJBiI+dk4WmFOShjHqN5VyS2Ib8T/to208Aal0Zkk6YnByAAJRJ8SpwoLuZ5g4Wb4eXUhskIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikQxlHkGBkfSLtE+j2ESvYCXcfme20kAumWS5SkoCF0=;
 b=e+RMz2EHexdmESE9ALtLe/2mLS1Ms/QMShzk6Yvw1YuYgL5JTvAwEoyfbAXyN5Aomg9Ib72omKsQu5xTtwbKVaMZ9Ats7g602i/c266Gym2eiCqcQZp7bStRI052zT+CAMmdVqNbbAnvT2zYDVdns+KPrGECTXV4p6BoCceIamMR79b6uw0qer75bkH0k9RLiIAoc2y5uM6g5WP7FS/6a3u7ENW6ZORO2S21slm3ue9NFZAvOqlwNjdYi63Mt/UegeIkEqB9R78euu4Acguqu9IAgdVFCy2N5zYxfRGF/BTaPhTuIqlAfDZrJG3PCDfVSzKcslG477f6CXVnDmptHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikQxlHkGBkfSLtE+j2ESvYCXcfme20kAumWS5SkoCF0=;
 b=zy4+BvHj2wD2j6T3oy3UJAqMsL0D69bL2DoMNP3jQHM2DcSCtT0hBwfzoomB91PGRzkrPrz74uWtIp01jqMoCqq6HtzfudtzjSvX/g1KCIYAMxmbRRfS2skO9ax1D6hMnWAK8+M0lrcuDKxFKrm9u80LL0jzABjd2rc2WkN8WnQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Thu, 28 Aug
 2025 10:40:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:40:20 +0000
Date: Thu, 28 Aug 2025 11:40:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc
 bpf_mm_get_mem_cgroup()
Message-ID: <46cecd34-9102-48fe-8a98-091aff6cc88a@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-3-laoar.shao@gmail.com>
 <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
 <3m6jhfndkoshnoj76wyjjgmqa55p4ij4desc45yz6g7gbpxnrd@xumacckayj4t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3m6jhfndkoshnoj76wyjjgmqa55p4ij4desc45yz6g7gbpxnrd@xumacckayj4t>
X-ClientProxiedBy: GVYP280CA0028.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd7c3a8-aa8a-4fd1-787a-08dde61f4944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jP6KQS0+IWSX/0aWhmbO+sm/6/nWSDnEYNLD+c0l8dO6OdHD+goh2EcEMPLU?=
 =?us-ascii?Q?B/OM9dXJcFs5r56jfnBa0j8YtNUtnm32I1W+NNEH7IPsg16aGTd7nkMePSFl?=
 =?us-ascii?Q?ZM7hvdmibqsiUdqdROfZ+eORZUlRSS0hXuZB2LVBqszBD8/8clPoCi9Nne/T?=
 =?us-ascii?Q?1o4P73xynm22SBcmr6alZ0YiEYXD2BibS6WqJmorDgTlkfSOcm2GXVUWxxxW?=
 =?us-ascii?Q?lUP1ATYcTX49WGzGEnFoFVESk0uf0J1CVL4DbnwXJYgMQ7JOAg5ZJCza4Oul?=
 =?us-ascii?Q?lFnidZJ64lior5hSpMIr5ykkq5VA9nZR4ZoiO/wfmB4tO+nyZw0JKJl8mdsz?=
 =?us-ascii?Q?Uc8egZLNvetcR6Mn9g9m0YjlvAnDdIE3IMhLoQR1WBoPfAYP06/Ks5kw1oWB?=
 =?us-ascii?Q?vwf38g3AxU7X9X6giDJ+KhGZ/zZ/BQ8TM/IzeA8XHDjo8EjIU9aIOVSlvCLs?=
 =?us-ascii?Q?paGEUMBJWOGut9/FcuNFtwmKccSR+Y893puom/F14w7zuE/nDNhdvAIMXyWg?=
 =?us-ascii?Q?bekGKBFGfD6X/c0ve8J3YKnHiL+6zD6lF7HTvFFztLFzvBAYCU8OE4G2+MB6?=
 =?us-ascii?Q?iZIsB68VSAn7uwjDfdZ2Rktd2BcM3XqdprRI69MW5cTaiDVYvm3SNeNacc+0?=
 =?us-ascii?Q?fkUQVCR6q6u+WkxZpig0cxyneFNM4aQoxZoEyYK3gU2Lt1fof6mKqPEEFCxe?=
 =?us-ascii?Q?VhoG0s2Lz2pQsSom6k9XTMEIrof03SLdVUQvf5p5xD7jgphZC6AcLdVc9Bqw?=
 =?us-ascii?Q?sA6/iAUZATo86FYpDxdSdVINDvJC/lvpdSDSzYB8aDCMJgt8pNbl1TQYNg/n?=
 =?us-ascii?Q?ElEWleeM95199wlDXGvsL/aGMx9wTsG7TFSyDAYrDY8ljakk7afrCuZkDmzJ?=
 =?us-ascii?Q?gmEgwBldhZ02gW7hf2SF8pMA4ZK6rQ+lR7aOq2bi+t9BWyC1TOSokaRiZbSB?=
 =?us-ascii?Q?fX6V+6b6rbM0sjc8+upe28HkmhR6TFr1OBneCmf7/obIy9ERmHXEIirv9Awh?=
 =?us-ascii?Q?pm6OK2Peu6o0T0x4ulWBTHPyMZI4H+ER8ItFM5Y1u4r9qNEDgnMLi1ckxfcC?=
 =?us-ascii?Q?BCF8u/SiTdGtWtwXdzJsXEvIJJNk7pUVcPippEbxyBrXHxOo+7yAjZ4xHl3b?=
 =?us-ascii?Q?Rz/bwj+OXAdiNdJ/EX029Zu7Dk3ugPSFsCQyU8faUBdx3u1IDqi+Bza/F4Tf?=
 =?us-ascii?Q?2si1ePFoLeErYsm/3GEeBuoQnjBFTLJq78DOo5zahmyPPOBDcvT4TP3ty+Ls?=
 =?us-ascii?Q?72vSwK2Mw3Yf1QgvwgS5qX1vZa31dr4jc/B78ObmxOPU/X33nsEWhqFQMaAd?=
 =?us-ascii?Q?HaI1acivi+AK2azgWvCLgMRhBDlH4MCL2WqvHC+AOkZROheps+Bua6Y/OQTW?=
 =?us-ascii?Q?E+CKyCgT441PfX61cuwJ5lSDU5WViOY8zdXE8FNocRtCidXVEku+fMKJDtm5?=
 =?us-ascii?Q?APt0NAgar4k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?daqhAmLJ9CE2vvr0JYlip/n71eEMezIxGbSVQ+hfzrayUY0PdvOMGdhCt5L/?=
 =?us-ascii?Q?yXvCX0aiO29jnXMX45E9t+FNnu4X0gR8LSHrDkJXfqaYYeZqtJBtkf3E8tCt?=
 =?us-ascii?Q?02XHydzppbDE67liws/oM3P+qT6l64tLB+lhwzO7jMxecFcEfHDbOV/B7lE1?=
 =?us-ascii?Q?1DO/dRpcyW1+1NUx4GvsIBG/Em4RHs2moCNOD6QD4edbxHmy6hRfPyg5URu4?=
 =?us-ascii?Q?j9NJlxiQoGTMt15GcGvG4UZOMBplnpK58ZUCGsNbV0byMjSKpI3HfdQt77hJ?=
 =?us-ascii?Q?wRJMZqMwPGaFFb72jqBbM7ZRnY1FMasTRJ91t5boYsakrMdGJ8hFxWeVg94s?=
 =?us-ascii?Q?PFxdYan8j5CKBd9Vn3PJye/4F7ec7CVsUI4GTuRGUyV6agwB+BptRK373nrQ?=
 =?us-ascii?Q?gjwnN9XWs4P+otKmmkNI6jNylFHXUD4z5P63JhdFb0dBybHwLlCAJXnENrPZ?=
 =?us-ascii?Q?SD+Ng3gm7j2c2vZf+B0CQNjon6cbWIHHdVzpaIgFh4ahDZ19Dkn5ALEaXE0h?=
 =?us-ascii?Q?P6VWPENexSxwr2GRrmeMCHrCRtyJYo3Jz7gJ/l9tM5NCFqt9qPBKAv1S+KCY?=
 =?us-ascii?Q?w0/QzvnIYsT6K1eR9US0rov1Y1If5AcQEdjAjqSmotP+hHYUkItjvWz48p6V?=
 =?us-ascii?Q?VxN/CS2wSQHyi0iIcAS35rdfuoZNJu8dcYG95ur0KaYbD2fcn5WBBZIbaxxY?=
 =?us-ascii?Q?mgLTORt36SOwMMYeHiZwMr6madM1N2XoGl3YFLMGQOjieM7iYxiXOQwPGw6g?=
 =?us-ascii?Q?EjhwipizqIj+h3FJ9xpa5baJVHheqMzrWexzPVL0+CRq+GOyKlUDBDfSyCwi?=
 =?us-ascii?Q?167G1U4hd1+wLzlh7/xrj6q4VnFgYmZNFW1k/ILuv1KBtASlc/nIaS3CLMQD?=
 =?us-ascii?Q?cXTqBb/vcbec941rbEj3UvqzSwVPmvngjkb41Lt3k5bPll3k1WIXKnHQua6R?=
 =?us-ascii?Q?gEDFcO/mKPj3N8H16vwWnfQi5FMV1qUqeCtrKB9cEjdrvfQkKYI0d8EzydMo?=
 =?us-ascii?Q?pTVLcfmfCf1F99XVQ8+3OEk7Uo4vuCuJl2I9rTY05rpdT02/PJtoEquzjWVn?=
 =?us-ascii?Q?1JaUYRGwSCyGr0GvjNs3sI9VZXpEipZA8FtUgzb7ld3efOUz0HFKIzoDqD6Y?=
 =?us-ascii?Q?YYgcnhw08Hft7iSd6WgRb3jcPvyRkNJ5jnXKVTJjbEyLJI0OoLXkO0RV0YhI?=
 =?us-ascii?Q?ZEekPU/1xw4llQqiuXEMvoBrYYwEh3rJFyv68ELyuZweay7A6VTguN7RuTeL?=
 =?us-ascii?Q?oG3f28IDOSMJQmfw8Pn/4/Bfq2GwkusaFcvuMpTX5x5xPMjXDd8AbrGgNBpG?=
 =?us-ascii?Q?laT0RcIo1xVUFd5DzYvb+VUcX3QC2X5Sk2X1Pq2BqOIjpijYuvnsI1LVeZcZ?=
 =?us-ascii?Q?2mozVz+69jEKhhOb5HH1iB9mo9EQ7wvFJbb98swhped7qbkiY5Wc2kD0v6Xh?=
 =?us-ascii?Q?96RPf14aMdMmPqS8g2oABWmY76RydpocE5NKnaN9rp5MsSO/DbvfN1b8DB4b?=
 =?us-ascii?Q?lfYTPvEXLDiMVVfLGEiVDuxjPCgQg6tbnvitYIevbyYNm8yS761yrgDpdCFd?=
 =?us-ascii?Q?y3j4m5CrzOOhj/m2zp1+sGZRR3sUODoBsXu6efjfIJy6Tn8iOdKeXleKXmel?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zVIvZBMjbWeZ6rfMIq7L9xmtOF2I17OL7A4MXe2wqzQ6NkC31IeSiuvQa8E1wJO/qD7CdVwfAN0LOkZEBGn9zdOzGbgXgNh3gLMjqBz6UowKviBY0DnYqjF6brOfei9mWFJ+oa8SOlZS0Avt40ddpNF9MB5nW79u2p3AP+TBxOWk1+LcWFtLULJaJ6EzIo9qxI1i/mAstLFtyAQZM/oyFYBfcQ756VIGjz2wKrx9Q9NVrsJ8LH4nn/b8kGR3Jn6Ujcziln+jBYvTgiTA6C6NdSYCzXYwm6Z0XBrjyhEzzgOEG/19UMVOJjZAz0utl5ey72hGRp//5fd+SQVBV0hOeQ4dpo9+/GQrjsCuz5bNXmjKTj4R1of4brN4XR19D1XfWsUNy1Vady6or8koUltuRxqOre9UvoIWoet5T57yBaXaxZ+QJKC+LuhYsTw6oI7LIxXeAiG9LX5Y0JdfM+iHXXAZrSbIX8+dBghAdMgXliatpiCvqFhfLmPUo9EU1fRSCqxSLYkCPGgcoOC97WXNQmAA9LEkmxZAdpvPnCvbwi+KIsuN6T3I7dsrQc3S643+YZZNCS26UTiO2Xgh04eOs7hTcoCeagycIWjXqrL9Js4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd7c3a8-aa8a-4fd1-787a-08dde61f4944
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:40:20.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXcWYtsXBoXq6MAFicgsRVz+UAoXNgOB5KoHW2+zzfK49I5PZGSVx6c2rADlbvrSdzrpmtRMwPvg0jgRjNdYzSfLtjbh60As127S77p1gH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280089
X-Proofpoint-ORIG-GUID: hR1Py55bp47Hsr29Z6tQ7DDHyRFI768z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX1i6o0rvXfkCg
 ENVbrMbOmrKBNlUkwd1MsxlHsm0YoMA8RbUmMvVO2SRiZCeRM8SWxsFT94dSQFkbdpJNtJGC5x0
 kQlUwSGyk80W/URXTrtRnQMPA9wN5urFFEunQmhK6M96dqTywvqCPRiXtcpOdqWRMEMZ0BQTmhC
 3FcxGQDx/mwf3E+v//a75Y5XVtdFoHFD96UKg0CsniJRTGegVkGdLpqSma9IcnrxA2gRiw9X6V0
 C659OdT8aAnAaH1MyFKmu/3Zq4/Gz16FkZ6vXmhJ4R6U9D1j8ITWUIphwzaX4zT/9viOuEH0Y6B
 mZBkEBeBAhGw2OvtQ6qzvtNrOwyJYVB+aSYRlf4WiQnPsJ80o8UhQf3hevzMkoPQG1YNHqOMMQg
 0LN4JZdaNIDWJclabJfSCXgQxv/6GQ==
X-Proofpoint-GUID: hR1Py55bp47Hsr29Z6tQ7DDHyRFI768z
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b0321c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=7afO4S0sTikFj10kJyUA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068

On Wed, Aug 27, 2025 at 01:50:18PM -0700, Shakeel Butt wrote:
> On Wed, Aug 27, 2025 at 04:34:48PM +0100, Lorenzo Stoakes wrote:
> > > +__bpf_kfunc_start_defs();
> > > +
> > > +/**
> > > + * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_struct.
> > > + * @mm: The mm_struct to query
> > > + *
> > > + * The obtained mem_cgroup must be released by calling bpf_put_mem_cgroup().
> > > + *
> > > + * Return: The associated mem_cgroup on success, or NULL on failure. Note that
> > > + * this function depends on CONFIG_MEMCG being enabled - it will always return
> > > + * NULL if CONFIG_MEMCG is not configured.
> >
> > What kind of locking is assumed here?
> >
> > Are we protected against mmdrop() clearing out the mm?
>
> No locking is needed. Just the valid mm object or NULL. Usually the
> underlying function (get_mem_cgroup_from_mm) is called in page fault
> context where the current is holding mm. Here the only requirement is
> that mm is valid either through explicit reference or the context.

I mean this may be down to me being not so familiar with BPF, but my concern is
that we're handing _any_ mm here.

So presumably this could also be a remote mm?

If not then why are we accepting an mm parameter at all, when we could just grab
current->mm?

If it's a remote mm, then we need to be absolutely sure that we won't UAF.

I also feel we should talk about this in the kdoc, unless BPF always somehow
asserts these things to be the case + verifies them smoehow.

>
> >
> > > + */
> > > +__bpf_kfunc struct mem_cgroup *bpf_mm_get_mem_cgroup(struct mm_struct *mm)
> > > +{
> > > +	return get_mem_cgroup_from_mm(mm);
> > > +}
> > > +
> > > +/**
> > > + * bpf_put_mem_cgroup - Release a memory cgroup obtained from bpf_mm_get_mem_cgroup()
> > > + * @memcg: The memory cgroup to release
> > > + */
> > > +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> > > +{
> > > +#ifdef CONFIG_MEMCG
> > > +	if (!memcg)
> > > +		return;
> > > +	css_put(&memcg->css);
> >
> > Feels weird to have an ifdef here but not elsewhere, maybe the whole thing
> > should be ifdef...?
> >
> > Is there not a put equivalent for get_mem_cgroup_from_mm()? That is a bit weird.
> >
> > Also do we now refrence the memcg global? That's pretty gross, could we not
> > actually implement such a helper?
> >
> > Is it valid to do this also? Maybe cgroup people can chime in.
>
> There is mem_cgroup_put() which should handle !CONFIG_MEMCG configs.
>

OK Yafang - let's use this instead then?

