Return-Path: <bpf+bounces-31212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C528D869C
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C360F1C216CA
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF2137774;
	Mon,  3 Jun 2024 15:53:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90119132126
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430022; cv=fail; b=ZLir3BFkoQAALMynGxYwekoEu0Cg3qMU0TqDudTnMOBhCSRJMNBgUljO4C3miRDgGZ5M6p9euAvoGkW6/3xFBUcigJuaeOTHhREIoJa1B4h6zxvLRc5qaNecqWJkN6icHY/M77TzkvitGmwxx9hGK57AiGHa4FMDG78CdZadvP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430022; c=relaxed/simple;
	bh=J/AhYAmNNLE+e7zFWp35oIA33i5FYYKpbfIunKqOFDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WlhfxNYGQSl6GlGMwfzTTW8XUMjmNjBs+GURiKKw8T3ZZ/Sa0RKusl0gbdY5F9TCS+4XHy4xKqJJ+frI8el9TPWljPzMKQoD4bjtL+Y89S6G7LFM/MZeYMaFVtRVtA2PsnXtp/vg/PIcW9rhpSu77Zdn603W0OgUaqq7JHb9CaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CJNWx022449;
	Mon, 3 Jun 2024 15:53:37 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Du+/6sGGbnPlHO2kWKtUXzIhOD9FTJgq9M+SagEbDDLo=3D;_b?=
 =?UTF-8?Q?=3DZfRgxtHZm9ZKakKyxZn4RMIopVwB241jR1jBOw0/SJi4S1pHXzvDxteoKS5Y?=
 =?UTF-8?Q?3pESrpgO_gjNY/CQumQ6s492sSNjp8jCg8WBN5AFapefn+OpVyIS1uwlYAMpESx?=
 =?UTF-8?Q?wQPqPeR91CYE2A_qLpTGsCphNZGoUIZC0MWQwsQ4TUq4g8I3q82IauNrLj6X8ki?=
 =?UTF-8?Q?ouGJvSLbdrEPlr6YJGKi_cgQVqb/6KQ6PIDh2uzu9vASb6xEN9Xpi8pkp2hMJgf?=
 =?UTF-8?Q?t2Z/Z689DPhOIk1haHL3dH+TNA_kyljdHVFDMKLwkjnaLnKEk7td5198z+gx7AZ?=
 =?UTF-8?Q?gSMcNjn5CXLMIuq/AXZgHxlMZ/Se6/zX_EA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58b5q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 15:53:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453FGVMS020722;
	Mon, 3 Jun 2024 15:53:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj0pre4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 15:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj4/2OBK4LWZmKXwN+RYF3KUqqx7JVLKZdNv35mCoGT4yBtJ5TSCN+y/El/XFmHFQ9Fziim1BerG/XLb2nMuTswx11qiaVNdGnt2HEXhj5q2WJU/jZjd8ok4rZzrIE1Rq0+XFoCTW2piBu1vG+40KPjmkAYdAEH9fARqflY/zy2qN8uir7JxQuKYhvMAal34aZ+gz/I6ar9ajb88kY8BgZBBd7SpaDeXnVBbQnnVVj9AqAfbGUoXRkUv/1TSu0ukLBSIFWXh1uByCtm8cr/XiLbA+PiGBU2McdVdkVa3wUkrhOUWukoHV06IJfOGpab+/PqkKt4yBDoh94CvqJmvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+/6sGGbnPlHO2kWKtUXzIhOD9FTJgq9M+SagEbDDLo=;
 b=TUh2qG/WnpIkhiaIqC2iyfW6sUG+KM5ORj9m7AVRDD6okCR3EaFl3YHxS1m1oQt7e18vcvvLgzaeJnjZ7ZQoSCEDktyk1KMUh6SBK6CQJZCrN/J9P7701J2m1e/Q8Ni2lxFKSYfzVunufkHG5iD8QTt11ZpasCLXE47JQ5JvWllPKGkOoWsGJJNdG3MlxQigvq2fgOdco9IDb3hcvW+bMPef7Q2WaophmUKDs1KICVC8I6e9If1ryUE8clANW0rg8AhIQ0J0SiJbkA1CJndI5iWhpSWHrNinu2iW1g8c15g4JJUvnY/SKInCBdV5ggHEeoBK0gjkTGLvGdo3WoXJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+/6sGGbnPlHO2kWKtUXzIhOD9FTJgq9M+SagEbDDLo=;
 b=c5OdBVH4WvJPF8/73bwTJzmju8ZWXrnZv2egGWZgahHJ4NvOWoyOY04zpAFoPeesP2pE3BRbGTQDrbMbUOs8uiDDDr6BEQMpAn6vXgvrgHHs41G69XrNkbxUL6tOYcUz1jwI2NFgcAs0vAC+VeJF1Kf8v26bVt7prtrXyNI8PTk=
Received: from CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22)
 by SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 15:53:33 +0000
Received: from CH2PR10MB4373.namprd10.prod.outlook.com
 ([fe80::ce3e:31a5:f731:d5ae]) by CH2PR10MB4373.namprd10.prod.outlook.com
 ([fe80::ce3e:31a5:f731:d5ae%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:28 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Support checks against a regular expression.
Date: Mon,  3 Jun 2024 16:53:07 +0100
Message-Id: <20240603155308.199254-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603155308.199254-1-cupertino.miranda@oracle.com>
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::27) To CH2PR10MB4373.namprd10.prod.outlook.com
 (2603:10b6:610:a9::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4373:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4ac21f-e580-47df-99e2-08dc83e54f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?swo0gqzRvhH1sYZHrmCyUOp9bXdnHm92rYHuUEpQetHIxd6F0W9LERqcqQVi?=
 =?us-ascii?Q?BrKNyLA+usys7pOh/J/nWMZVc6/Ooi6hy35Z9zTwRzgT4w0vO9t3ujanqdw+?=
 =?us-ascii?Q?UVQNEKH1e5n/IJtOiTTz2YXIUceUhPXQCAUuXkI2W/WEByUM9EYy1p+pD/oo?=
 =?us-ascii?Q?aUt0EHGWMzASlkeeHqTImVTaa19ZtG0IyZqOYLVDyZJKo2vF0Kur7u7KRuIw?=
 =?us-ascii?Q?LnS/I4A4SAtzVT9h9CBhS0TNE7yFXhLrxjWS6JFgDiYuE6Iz8eRNOOuhKVbv?=
 =?us-ascii?Q?jNBDmR3/5I9SUjmf8wyR46g5oiqiUL9V1ht2NqKS+Dci4ts3CP+KvXr6lfaR?=
 =?us-ascii?Q?wXhSeFcW7/GhRFiu2w8MHEBAAO+gNgR1iLeCk44UH4u6R9OVDvmruBei4/QR?=
 =?us-ascii?Q?PM7I0Ql+cAWWZ1yBcsUUQ0L1z5/SFIeCSGw0oymLtNcMZ6WN53FA+B1phWwq?=
 =?us-ascii?Q?xiKJKGyeP9M5Rj9pzwOO5R7h5fOHYQiprj8Edeb00LbVVSDmJ8OEVpS6damO?=
 =?us-ascii?Q?JqOozZ3mnfEEPNymdEv6ist06djl8mbZGKi8GispohTE0JcZyIz2XQPzGhdK?=
 =?us-ascii?Q?iwVzAlTC9onH4Z1gjo8YEGzXstvU1sQAKZ+8nfHj1vjhNHRvejBXRC1qnYO6?=
 =?us-ascii?Q?Gs4xhtFNUf2nUlUkqBWIjMymgRkkOELjCqTH75s+mvgLfWywNYXfXLVCJLzf?=
 =?us-ascii?Q?cUfv9A9wHX7cWe+iuF/11v8Go0XwQgdQziFPitZTPYgIwzm8a5MY7wFymC+t?=
 =?us-ascii?Q?CP0dCyWFkCA4WYrvR6RF2238LdKBs7OUsTU2f+ai5ay+U60VvprFKA1uQFr0?=
 =?us-ascii?Q?Cf0z8OaH54Zw4+hk1MG6bU41Flc84yuvLyJWp7+S1uUhXqPXgcBZi0dTxPm8?=
 =?us-ascii?Q?pyktUytFQ+MIa8Pd7w5wc1rXoWXOer8KNUnlGi6h3gTXp0keoqO4m8eEOIb6?=
 =?us-ascii?Q?lTPWz46LReAs0FxFdTituXL8bVkgOybWnXUHKtFUASzTA/rXWZSgNEJ1s+8X?=
 =?us-ascii?Q?H5HCD33x5pGzM/KQruy54Nqcc/5QXhZmF1DejZc6B51TkkTbLFRVUFmxmqwC?=
 =?us-ascii?Q?eZMFvtWHfj7Gx/9UL+RPd8ZphIkSPyEYFC8ScH8cis0ZtiUnyuGZw82bmYng?=
 =?us-ascii?Q?It/DHeWIkPdI9iQ2NBqYXjylX8tpfZKPutsbu7+ZcpoZGkFQ7pwueBVqFz8V?=
 =?us-ascii?Q?I3cIvVUqB/rdSBmebLI0m0Ev3NhY1E6+sQyi+RXYjkYcLe33NJ0As6RH1qIN?=
 =?us-ascii?Q?NNX12d+h70Uwj6rmtY75f7ZxzI0aiG9VUag2jKTCLA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4373.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WuG7sh5J9nv+5n4el+xapA+Ho+6oVYdSph8wau4rVtucKJ9eHxz/nT75A5jn?=
 =?us-ascii?Q?BcxFNqN6rx0oQM6Sl2CSh46L/BxKGzR1bzQvlP1g+fBvTLZ95tKjQ62SQycN?=
 =?us-ascii?Q?tQPUipjiKXGbKVleKtLv/VaSkQ38W+ew2Lj3q3yVWwv1codeokA5BmqZx0AF?=
 =?us-ascii?Q?CVqgVyL958SxcFC92mITclQrju58DsfQm+bFEp4HHzBpuBMFlx/Dc+gsv3xE?=
 =?us-ascii?Q?aSqoPdD0hYha/pqd5ERg0pG/D1F1ouIAf6AUsObbJFbXF+36fj8M3gNUfXbs?=
 =?us-ascii?Q?QIXWs9m6N5kgBewM1uGZvq/9cEzLrBvc0jBz9T9zv8TZmL0opVdEX2aENrW7?=
 =?us-ascii?Q?qNAMHrcI9knBgBz5iHuhZglgdL4A89CHTFqNznrHPLxSRuBW/jqCrRjt7DWq?=
 =?us-ascii?Q?Rmd71aIOyLrtWHM9Uq2I54rMAPBdUONTPDau1LA7pDlocrRODXdPO7oIVpWm?=
 =?us-ascii?Q?9Pu1q1Jq6Fh04qo2L7XVgKzeV0+yLjiZ4hrH7cTFWdAV0AYyPKDfqrVtzof0?=
 =?us-ascii?Q?MdJ6hH1nV3ecNFrZhVSlDiAAjNwlhk3jUiZN7epjsi7pkSYJG60GJ/Q76XgY?=
 =?us-ascii?Q?FVsit0AvmtTb3xwaBbsuigNcMXLgScC6SFojgAWggMCm3rboIl67LmPgMdp5?=
 =?us-ascii?Q?BwkNd6Lq49cchY8JwtIorSTM8DW5gIUojXnNSHRuWEqM4cYPO7PbUS6fu5jT?=
 =?us-ascii?Q?zcNjGMGrX9zj3PxJp9AakOb9yyfJXlPczn+0Zmpu3e+BRg1ZXjRgnpJbCvx9?=
 =?us-ascii?Q?jOQ53kyK8zO9oQfUWYWtcCy7ls9pH1crliP/OpNg+8R4W2tItnI/t/2EJTdk?=
 =?us-ascii?Q?QUX9pzdSdbihT5Dk4VkVccIvarlfZwTotaQlSuHDbDSwZkyjynJTfDPQ7dyY?=
 =?us-ascii?Q?5ZIx/C4Dck9BZynCk/O9MCsaJxLSDn9NHjj2fEIfSxfPOD2Ptc/bWYKdTEo7?=
 =?us-ascii?Q?ECP6w+i0tCMtaHHPov3mqcI0r+XsGkG9CusWF8ZaBzZKyNsb/XB6s54pznE2?=
 =?us-ascii?Q?00GFSR1fL7hIeoHS+T4atufVz/HUnLVq8o+rvVzltwUx7V9M8LWQII0sHkAv?=
 =?us-ascii?Q?1Q7GTvnccguAZbh0/pcWJrgL8/QeNM5+YGhhQgwtyzQUvNvmda/vMnCz82bI?=
 =?us-ascii?Q?k/lf3EzRGFWAO+kppI93Bpgl1E0ZYe/bV+Ktci7JSeXC8/Jh6bRxJzP1rQ4W?=
 =?us-ascii?Q?9fJOc9iC7lNEPMzUd/xwaEzT+tog5FYx3zKrVqnxbff2AO2kor6cV+8IMHIS?=
 =?us-ascii?Q?5nVyc8Dg6qS6hWnzEewBjdw+CAk+rGQl0tWnbvxpT4ewSl1aBMyOoqywf1uO?=
 =?us-ascii?Q?DPPplxr5J8igud+TpcU7/xPNe2kTkGz6aj+lQ34nJfA6d/keuNELj9P8pGes?=
 =?us-ascii?Q?uQBoTx8YnvegoCBXWB3SgKI9w0UT47iyZmuhVMOIon61w6R+3JMH53HR6Lx5?=
 =?us-ascii?Q?8zYgCzwQ7EIcNkjNvaMFJxjfwQ0/Rrvnr67F6SU3d4qQR/Pn5XDYwloHYpYK?=
 =?us-ascii?Q?PpVwUCQeLYlFoHmjP9B87eay6JzDdbk7odY4Vr4NBlApICccq2TKy6bXGotq?=
 =?us-ascii?Q?Ha8PnXAnJCkuwGvpZ3nmSpHu8J9erdPAMyyMUGdMRCFTHxvxi8uSwQYZzXAh?=
 =?us-ascii?Q?LI+3Hk7HRA5oxQiTVsJNv2U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T/H8u13lp06UJUhWCbF90kgWhIlvbQnDo9V0daB2k9KMihTOo4ydgBDkSJfbvBg68g2z2u2ELybW6dwFeOza2GRFSwWyTrNl6ZW3QhV9F0zGb9Lv1DvF5Bb9VFj/qc68njY5houwgajf+9k1bhCyDJLeazP2kN6hVMhyoJvgb1b8rGMbl0LGetA0swJKWCWpxN7NNVqqw6MbVjHv1T2+/rn3KzpfEnvKSilNAidiXjN2bTYBT0l1QqwhqJtCZInku//88CTd7odBbCkApu73FlIu26Q5upOzI0qbCH5phRFHIGXdBoW8v+XzlMFyMonbI9Gafn5ux5zGf/TlPlcgTOVHhFeEX7/kNn4cITYghCWoPFWmEaGzlRbaDSEHr0AiBIvLkOaQquiA5dEMsDoLuiLm54EiMrUxnqgH5tSPTaWbRg9FpYEbcbfaBLhAJGoEcNzTY5mK13VqjhYdcxaoIJl8VV64Ta+FvYzh/cR+cA8HeZ8RpisNJEboko1az8YJ8rGyfcq85gRLZrrAP5chIV7nj+vnc+jqlDmGf8++mxy06Z4HERn6dG2kYxjWJraqwP8boaHVn2gO1IEmOZ8SLAe2ze5k2LQsjxO6xMKVv/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4ac21f-e580-47df-99e2-08dc83e54f38
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4373.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:28.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw2eCRaxCiD2lVOTNuf4QRMKJ4wLMYlUFIO+ttBDJV0txFZhLvUHKfCHuLtdXQ012Nv9mTOpvkMJ8ZYvOYvrYKQG+FJihOBGClF8+MBjGQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030132
X-Proofpoint-ORIG-GUID: rcoGYCBsH47CsdkFDKJy0cB0ZmZFLjw8
X-Proofpoint-GUID: rcoGYCBsH47CsdkFDKJy0cB0ZmZFLjw8

Add support for __regex and __regex_unpriv macros to check the test
execution output against a regular expression. This is similar to __msg
and __msg_unpriv, however those only allow to do full text matching.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
 tools/testing/selftests/bpf/test_loader.c    | 126 ++++++++++++++-----
 2 files changed, 105 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..c0280bd2f340 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -7,9 +7,9 @@
  *
  * The test_loader sequentially loads each program in a skeleton.
  * Programs could be loaded in privileged and unprivileged modes.
- * - __success, __failure, __msg imply privileged mode;
- * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
- *   unprivileged mode.
+ * - __success, __failure, __msg, __regex imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
+ *   imply unprivileged mode.
  * If combination of privileged and unprivileged attributes is present
  * both modes are used. If none are present privileged mode is implied.
  *
@@ -24,6 +24,9 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __regex           Same as __msg, but using a regular expression.
+ * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -59,10 +62,12 @@
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 524c38e9cde4..c73fa04bca1b 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
+#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -17,9 +18,11 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -46,10 +49,15 @@ enum mode {
 	UNPRIV = 2
 };
 
+struct expect_msg {
+	const char *msg;
+	regex_t *regex;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
+	struct expect_msg *expect;
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
@@ -91,27 +99,57 @@ static void free_test_spec(struct test_spec *spec)
 {
 	free(spec->priv.name);
 	free(spec->unpriv.name);
-	free(spec->priv.expect_msgs);
-	free(spec->unpriv.expect_msgs);
+	free(spec->priv.expect);
+	free(spec->unpriv.expect);
 
 	spec->priv.name = NULL;
 	spec->unpriv.name = NULL;
-	spec->priv.expect_msgs = NULL;
-	spec->unpriv.expect_msgs = NULL;
+	spec->priv.expect = NULL;
+	spec->unpriv.expect = NULL;
 }
 
 static int push_msg(const char *msg, struct test_subspec *subspec)
 {
 	void *tmp;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(subspec->expect,
+		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
-	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
 
+	subspec->expect = tmp;
+	subspec->expect[subspec->expect_msg_cnt].msg = msg;
+	subspec->expect[subspec->expect_msg_cnt].regex = NULL;
+	subspec->expect_msg_cnt += 1;
+	return 0;
+}
+
+static int push_regex(const char *regex_str, struct test_subspec *subspec)
+{
+	void *tmp;
+	int regcomp_res;
+
+	tmp = realloc(subspec->expect,
+		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
+	if (!tmp) {
+		ASSERT_FAIL("failed to realloc memory for messages\n");
+		return -ENOMEM;
+	}
+	subspec->expect = tmp;
+
+	subspec->expect[subspec->expect_msg_cnt].regex = (regex_t *) malloc(sizeof(regex_t));
+	regcomp_res = regcomp (subspec->expect[subspec->expect_msg_cnt].regex,
+			       regex_str, REG_EXTENDED|REG_NEWLINE);
+	if (regcomp_res != 0) {
+		fprintf(stderr, "Regexp: '%s'\n", regex_str);
+		ASSERT_FAIL("failed to compile regex\n");
+		return -EINVAL;
+	}
+
+	subspec->expect[subspec->expect_msg_cnt].msg = regex_str;
+	subspec->expect_msg_cnt += 1;
 	return 0;
 }
 
@@ -243,6 +281,18 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
+			err = push_regex(msg, &spec->priv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
+			err = push_regex(msg, &spec->unpriv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
 			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
 			err = parse_retval(val, &spec->priv.retval, "__retval");
@@ -336,16 +386,16 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->unpriv.execute = spec->priv.execute;
 		}
 
-		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+		if (!spec->unpriv.expect) {
+			size_t sz = spec->priv.expect_msg_cnt * sizeof(struct expect_msg);
 
-			spec->unpriv.expect_msgs = malloc(sz);
-			if (!spec->unpriv.expect_msgs) {
-				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
+			spec->unpriv.expect = malloc(sz);
+			if (!spec->unpriv.expect) {
+				PRINT_FAIL("failed to allocate memory for unpriv.expect\n");
 				err = -ENOMEM;
 				goto cleanup;
 			}
-			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
+			memcpy(spec->unpriv.expect, spec->priv.expect, sz);
 			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
 		}
 	}
@@ -403,26 +453,44 @@ static void validate_case(struct test_loader *tester,
 			  int load_err)
 {
 	int i, j;
+	const char *match;
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		char *match;
 		const char *expect_msg;
+		regex_t *regex;
+		regmatch_t reg_match[1];
+
+		expect_msg = subspec->expect[i].msg;
+		regex = subspec->expect[i].regex;
+
+		if (regex == NULL) {
+			match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
+			if (!ASSERT_OK_PTR (match, "expect_msg")) {
+				/* if we are in verbose mode, we've already emitted log */
+				if (env.verbosity == VERBOSE_NONE)
+					emit_verifier_log(tester->log_buf, true /*force*/);
+				for (j = 0; j < i; j++)
+					fprintf(stderr,
+						"MATCHED  MSG: '%s'\n", subspec->expect[j].msg);
+				fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+				return;
+			}
+			tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
+		} else {
+			int match_size = regexec (regex, tester->log_buf + tester->next_match_pos, 1, reg_match, 0);
+			if (match_size != 1) {
+				/* if we are in verbose mode, we've already emitted log */
+				if (env.verbosity == VERBOSE_NONE)
+					emit_verifier_log(tester->log_buf, true /*force*/);
+				for (j = 0; j < i; j++)
+					fprintf(stderr,
+						"MATCHED  REGEX: '%s'\n", subspec->expect[j].msg);
+				fprintf(stderr, "EXPECTED REGEX: '%s'\n", expect_msg);
+				return;
+			}
 
-		expect_msg = subspec->expect_msgs[i];
-
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
-		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
-			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
-			return;
+			tester->next_match_pos += reg_match[0].rm_eo;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
-- 
2.39.2


