Return-Path: <bpf+bounces-75153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E27C73925
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C83F32BFDB
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901A31A563;
	Thu, 20 Nov 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="msroy3ci";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TgFPvkST"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2A30507B
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636073; cv=fail; b=kmm2zIdX4SW5507x51w6lOf0YZ1t1GWB7qphz8DKWCxb/J6iYnKRkBxjgx5BfTqbBEP7Tsx4+WQLNdPGqXbKWqhoYXiddVtaNXAG23IQ6qeufBYGdm9RSPcAl5AYHSheECYXyj0dug0aVJJidSG6XW1orqL4XY1z3XAhRryWz/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636073; c=relaxed/simple;
	bh=ygN4O+LbhUsHBJbxgpMYqxWUf7H68iK1/BInRuq8To4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=O8abBX7GmZoCKW3u47IjDATGS9kgHOrJt8q3df9kvW/H+881J1JlqLQUayxtTGXP8DEws1jyPd2aqD2rbkcLgRRWwi35Yoqgn8eUHyogbNHUMSorcAIpravhpjr+Rcus/xHqa/GTi9aAVMRbLBH/OeIEntRomfYwDCtlUIuqOZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=msroy3ci; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TgFPvkST; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK9MCW2024051;
	Thu, 20 Nov 2025 10:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=eukTCR+kPI3gn9Z/
	IrdMydRnFnXMnzUMMMWwqpCWDqk=; b=msroy3ci0RXF6W4GbOf/mifoOLuphS8j
	WscAqCs9QZ104TBy7RCIuk88XRxnKg/Uk506qUHCSWsbhPPgoXNV5oqULEb/58xm
	DlFHIqPyCzFPuFvtxKrrPg6XkiGe+oYOihJWJQDod9OKNOj5QxwfbllhcXxookSy
	Ta5hb0sn0YH5QJLpoMS7b+X6IuZXAK9gmhpJd4Fsu9LaUcpflCbcLdrXL24nihHA
	V0uuZxWs7mm7rXTNN+gJNvO/Ra4P+SxF7p4hagEEyILlxD/zEOpD7iBDB/m2b26U
	c+jt/27RW7A+F07OUHgsuYWRF4lBmud2dhkzVF2x3SOFidU0PK6lFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbc0qsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 10:54:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKAZkc3004290;
	Thu, 20 Nov 2025 10:54:28 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybn6fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 10:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHQyOxzFbbBqMTjGp7N+XlOj4wz2aer6M4K2cp0awmWgPmi2d5JDKzaV5YmGkZEYLjo/ZSyfyux9DQrEX3Laqz3zxewTqGGK7S60vcX9iVE44Xl2D9ZVKHGEvGausLqrRhl5M1j2CQzJJbuthumk0qRcO63n7QB3HIjlIy2Uk9b9HOpsOiA0aZIE0BMdqBT9t1MJk3JTHM/81vBhEPTxGkbtCJ4Sh5o1HkacmntY6aj+KRYZv9wrrvnUKNajdu05ohcRJqHa8T1gQZvXNXjGAYOu4s+QAQh0ayaJfBLCEaGZkCcHB237od0YPld4bxO5VlhrfMGMhEd1a1cUopO/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eukTCR+kPI3gn9Z/IrdMydRnFnXMnzUMMMWwqpCWDqk=;
 b=QLoOEnwzAPAKj6g+o9PvwQ/0SYZTZnNC0A4xZ3NSBXEBHnJGMZsVdCOLmHIrZrBJ5V/yUMVXzi8YwXhD4XXYCei320PdbTMQx1Jl0IaNdbuxK27f2+owlAbvO47C9PIhiuZtLDNTKl7oGxcoQvQMJtCeJVAbZlJpX6BSautiOXuHSL+41KFEBQwgU25bEqKcyCogLOOiAvS6l88e1vaI5nE11v0xj9E4QlWqvx78HLPVmz+4RYis9A13Kl1vgbb1RGN0lCENIVw0D/azCfuoyaKMJ8vSL/RBwNt7SecMYz9GViN/FuqqdUlB0sM7jUHtKiGnZSF4OBIchBrzAw/aAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eukTCR+kPI3gn9Z/IrdMydRnFnXMnzUMMMWwqpCWDqk=;
 b=TgFPvkSTh7R4Lz/F1l6gjNVSyf3caCXzRpkruSmZV2IRpawTEABHGA331KkHkkfyClufUSkqQuuUx47eDjr8NHcWYRPJBx20X9nQGlV21tbMOLdYLXsIS52VVO9nE8NJiTJiDPhQEl5kWQ2XzTRuQ3PtugzjdI4Flen7Y7UzqDQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:54:26 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 10:54:25 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH] bpf: verifier improvement in 32bit shift sign extension pattern
Date: Thu, 20 Nov 2025 10:54:01 +0000
Message-Id: <20251120105401.39183-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA1PR10MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d86d36-e51b-454e-f9cb-08de28232b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lfwqpw3IQCzReS4ld0Xkfx+tW2L8TYZEuOcR0hUX2iJobLThaqBLT5RO9dpK?=
 =?us-ascii?Q?A3yPHLYli7rvyxvZePLk88RvjIJqSFFdEYATACMxM9t/1p+lPhxXof7JQLEP?=
 =?us-ascii?Q?TuzrVL41iLzr/q6U9WcLlVof5kD6bqq7zuFSrCJ7XsX99ElZmfQ3cZMJxgWG?=
 =?us-ascii?Q?QMk/5NxtiDhXOPn0L9MIGIy2PCHgqRZry/CZYqV0UpNmBFRT4TXYuDWzW+9m?=
 =?us-ascii?Q?b9xdPtBSQgHfdQwr+hzKwE1PLd692WXPUwsylvPssOkIAn+lZ//iXg90d/MI?=
 =?us-ascii?Q?byWk02Nvq50xCm9Mzdm18EPaky9QGKgd1S9jXti9mQVsvJqhCKF02EhgH3hZ?=
 =?us-ascii?Q?qPKLUsgOAaXgTJPns7/7jFKDDXMYUxixvoQTFYjEQE3nBC2e+5n0+0yMGCOB?=
 =?us-ascii?Q?btfOBlMvaD2Ns+MAGae/bdiWbAdB/VDIP0j8rUZsedYPEM6/Q4go+Vnuyr5C?=
 =?us-ascii?Q?aaCJmufNzUIkMr6bMbi41C3oQRgvPzwis+9TP02XJe4DPTbiFlKz7aGe20ID?=
 =?us-ascii?Q?ZSKe/qLLt+i/k5cet0LveOD9lvJkYgBVY/1v+lGv30huhlwy4CPMzsDua62T?=
 =?us-ascii?Q?luunhC+Qmue3JXME7J6LLVcWXprGOeqW5YHLaixCyyj0YtwJ+NEz4FfoyaiS?=
 =?us-ascii?Q?/mFtKFaIk6/X0LbNRwkfk2cRkhIGt95bWcfMkfTrxbBIK+263iQopZYoVxOb?=
 =?us-ascii?Q?mrlrw7PG/NiS3x5HupetJq9QbC3V6tqixYdJ+/hKtwVrruo3nbbylk/Qbhbg?=
 =?us-ascii?Q?ug4NX7jVopK/UecsXZHRLr0oObbMQqimOnAJgflOMYe596zcqzFNv41gEP6U?=
 =?us-ascii?Q?ek9nfUSkirQ8ylwDAieAtpmAeyAetg22b+KrrQbWMRdm91qk6q/XCTU00dez?=
 =?us-ascii?Q?jRK48oR5rrWloWUgAU4XuoDGmC9wMIqIiS2A1BNHdOO7DU8vsCD2lBuuFQ0F?=
 =?us-ascii?Q?ibWV8bndUGXhab3WSSToPmhGYVOe35MRqQL+k2GSzUIXJ/Vu5hLGU0Je+xd1?=
 =?us-ascii?Q?MGr228iFr6sonEgwWV+91GP+J5fhhO7Df9/5rnY34EFqzsI9kT78vBSUr715?=
 =?us-ascii?Q?RvcVpq2xshkB4+E/lwrBPk0Il1OjilbcE5DZg94zLFqNBCy9VbtjHzA6nmLo?=
 =?us-ascii?Q?3d8cLahSh8+j6VbXiMmaX5Qs2HZtfKR6lYWSSzObRXvDYtpRfZu69oU65zrR?=
 =?us-ascii?Q?3QgnwJP/I1FrItgRdVmobtUqCgJBvSMtnymG//HGjaxnIVGjLgulTWvIVrID?=
 =?us-ascii?Q?hJuCUGtydo1Ioibb20G7Lt9dHmM+hWceDTS6IpYMjDqhomSPib66+VPwnis3?=
 =?us-ascii?Q?DjeL/T4x1Tfiq2HTFmaXx4Ci35oB7G6+asf2Tk/Bgmc2RAc5O53L3nDXjghV?=
 =?us-ascii?Q?jB7XwxedtDWNm/KKCNIui8ES1HYlyxx1IWIXadnDEhHfCI2ImKfnmQUGAKRO?=
 =?us-ascii?Q?M3fox8OaSO5Quqoi1Abhs5kRVlSRoRMEide1pwJ+9s1yrJD/h11tIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+gL/10dqSafIWvU1e4S7UkI6PysSHu6t4XeuSBbFn0xe6qWUuYHhTxZebW7?=
 =?us-ascii?Q?Fx656aOGYdl0EtIuoNNyrgpBtOpEzwl8NiVfyyhrirtczC6hTOzciXaBdJYt?=
 =?us-ascii?Q?ew8++E7LGpPpl5+Wwm6y3gHctplYfBUgMkO4xBkJHXGzHRkIzBjRQQbC4Rn4?=
 =?us-ascii?Q?Ogi7ZXrj6Jy6DZbQ5KgxOubQFHRFWTiDpGNSEsl5O01t1wUQBx8VBTRR0LZY?=
 =?us-ascii?Q?MzUiaY5zAWPEWlO1opIOxYnUK1zwwPMqqU7o1i8Yr048ofrnL4m+aE7H9veO?=
 =?us-ascii?Q?m7FejQsRBlUuK570EjMl0kfqM9/K4y8N4lws7e3PgJXVomYot9lU5Z1o6yvF?=
 =?us-ascii?Q?A9f6cJ8Q2KkAGWZkZs1Q3d6fZZekp2iPCkOxUpYAp5x9Kz/IXCMCLuAgS1b6?=
 =?us-ascii?Q?7U3Xyq+m0M2i4ebNxl37c+258L0kmHR5Q2wAHKVV8eMdhdWCR/ZAZm+9eb3H?=
 =?us-ascii?Q?9J9PTHgL8AJgHJE1m550GLBkGN8x+IjGgwZfUJgoOu/uXD/i8pr/kQKMS0X9?=
 =?us-ascii?Q?IxTU0+DbIV1AXpsftrF/51G/Kg8OFXI4dmc2PQ34hF5PZUbSVYbsVz0WW93Y?=
 =?us-ascii?Q?JPkIgrI+03Q9JHIgt9aozzK4qxTdQCKZSKh0QwcjnHAPB6wA6liowmCK7HYr?=
 =?us-ascii?Q?x9xkZFsR5EDVMSawunQwVhDUBQvS20ntqBW+3az3FMa4Er7I+iqlBUYJyW4x?=
 =?us-ascii?Q?vIvBdZMZ6uvQsOI2oLCkk3QoymDk0f0o8g+MLMGsGMZjfyknUpOPj//1XchD?=
 =?us-ascii?Q?6ujUMGJHwtONSqrLKUa3TtANRkUgLFkINshHtXt3XdkF/HQhn0UNsX5hI9KK?=
 =?us-ascii?Q?i1Y6AMGhP9cIVJZa/9wq7Lw8vN1CmYg7ytHqJnrkQVIKhIx0G4iLn4IelxMh?=
 =?us-ascii?Q?G1V15Uw9Se/0GQKjfEFZW5woHWesgpvV7SpdVSc3jIW6kP3CXPBU5W6EiUEr?=
 =?us-ascii?Q?fLDDhzbG7s58QaUBL6QvMmYVnxTponpRUW+94U+3t6k4ccuFFQoylqkeZvdJ?=
 =?us-ascii?Q?SmDCPEhUGb96Lk+zccxsgqaVqj8vYWQxN+3LvUQm9NRfC3cElENyzTra+DP5?=
 =?us-ascii?Q?wJdei89J456ELSSPReM9fCuReNZK2oyfiWa1Drwb75Vgo9trho/Q8zFlT5Rd?=
 =?us-ascii?Q?2/66Yh2ZX7/V/bAh0HE1pxLJFEhNCyfJ6WK5dHbnpt8qkBgoTY5qxj4Ic9xx?=
 =?us-ascii?Q?S6JHPql+aEV1SmLjK4+EAuBHpB8CT5vBZUG+9aZnpM59/5wpJd6fMBOUBzKR?=
 =?us-ascii?Q?89ioJSk/e4CEcjtk2XhqJX+kHoxahq8uuQmU0veSkLGkCvdpz55RPV5AZnB+?=
 =?us-ascii?Q?lv/y8D0RoyHHGAqNr1wNm6llDAmm0KTyOrIn3qzPcLsGHVvSzArNfUD7riMq?=
 =?us-ascii?Q?UUnUDI1EDVKjJp03HwbH/wo4BMTieaa8suDWZahkt7W7CPzxvIOwn0hz9UIl?=
 =?us-ascii?Q?lT7kYidCJrriZZhlBunxIMOEYZz+uKBeXzsRHvSTPEQM+a2Ko+InJEbLYyxz?=
 =?us-ascii?Q?Tk/JZaYwc9Mi5/0LOHQml/bI8wUd8uiBdPAiNpbBy8W3q3pDtWiLoQgnguSn?=
 =?us-ascii?Q?GaVJHqhJ0FTITsLB0MSbAMWg0dCXLNU3Cv3i3RQfAdLF+ExU3vCKZMTH5+bB?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JD1FYbHmBLfQFILXRbQa9s2BMClGM+wZGJ84sr36MBQ91aWRnpIeiQd+GdjQ8/26KuyzxTXDLZS5rAdDJBHAvXmyka/EstTyNMn5CFuSf0ztckQ5kIEaEvrSfdWgkbn4PNV7Tx7Ki9+xvPTXJrJ6TzoxV+1kxuxRcHhEvS4LwOri/OxRXRIrXo4BNA4uZa5xSLzuouxJ7RkFIcn4pulvNTp1G+JbxYOYrMXuZxk5psZHUcV0YCN7KgAaH66eFSxDIEwV9c4Cd4btsUQ6khMwDtA0DhsP4RplBvVG25LUHMuXZr40pURm4XNjM1izSes1WvTehEddIxatR3G/J/cKLqA6g4wcfaDMagdcDkssGscduMBrAOJ9nORxDdSQQAm5k6yLh/YiSB3yl44TsNH5x5FHfTEOsxFdAJE9A61ynG+yVZn7SH4L/NfJCofTeXgTfc3d/8baCEN9ya3b21ifXmMYdA4vIgTrs6JZntUf7uZTgoc9xmtxQxChdMHfILIggsVESFZykM/d7nH6enxyDV7Felxy/ZUtp29ORW3AnHBVue/B4px1OmhznKbpSnhTAHXeesJPPMQpDCnkqTWcRo17srPr2V2BXT+k3H4n08o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d86d36-e51b-454e-f9cb-08de28232b75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:54:25.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWRsg3khpWp8/L5FCozWOi+fBFW5cyQe1txOdQu+1f+s4MKeybiMITKY847/AqKYGZA/94cTawbbK7eSFIQq8bOP3WEZaiXncFVYDSw1BtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_04,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200067
X-Proofpoint-GUID: pq4OU9_drUKVkKAOp1LzzN3Rjdsl8IZ2
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691ef365 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=yPCof4ZbAAAA:8
 a=EUspDBNiAAAA:8 a=onGyy7HPf4Ad7fBgSrsA:9
X-Proofpoint-ORIG-GUID: pq4OU9_drUKVkKAOp1LzzN3Rjdsl8IZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4wjFhuJ3ng61
 MhoIWc4sPkbbNtqJfLIv5Tioe7LotOrTf42onNOjBnoRESOFk2ip3K5vwbugsvEjeMjYwJpODED
 a7m4vGv7FQYWcz2tdjUCaFMOT6yaa0BpZu/KUMZ+lLUgtnIWKlUTTRD7RhAM4QKNjlWOfn1/wYh
 KE7XCXPtioFFcVGKGKPAApfbbQlAgLy217KlRyaa6xZ+KhOqmIGOA0AD2Q+6buCZu/uULu/o+7w
 ZNOripKMlH1Lxhii1DEQj2R5JxM+vtud0B0Cr9oM2S6Os05S+yUkhMxRpJ23+Vl1feAXv3bzOYC
 F1W5kJnOIF9ZBHA/oQn6p2J1TaZ8EUg/ICdWhh/p7KgzFWBVUytBG3kHeg2XGKrAhEMQmQJlafO
 G52zl+hqHZEDDUY37rSgCPNA3g9KTQ==

This patch improves the verifier to correctly compute bounds for sign
extension compiler pattern composed of left shift by 32bits followed by
a sign right shift by 32bits.
Pattern in the verifier was limitted to positive value bounds and would
reset bound computation for negative values.
New code allows both positive and negative values for sign extension
without compromising bound computation and verifier to pass.

This change is required by GCC which generate such pattern, and was
detected in the context of systemd, as described in the following GCC
bugzilla:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119731

Three new tests were added in verifier_subreg.c.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c                         | 20 +++---
 .../selftests/bpf/progs/verifier_subreg.c     | 68 +++++++++++++++++++
 2 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..f92ef36fbe62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15272,21 +15272,19 @@ static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
 				   u64 umin_val, u64 umax_val)
 {
 	/* Special case <<32 because it is a common compiler pattern to sign
-	 * extend subreg by doing <<32 s>>32. In this case if 32bit bounds are
-	 * positive we know this shift will also be positive so we can track
-	 * bounds correctly. Otherwise we lose all sign bit information except
-	 * what we can pick up from var_off. Perhaps we can generalize this
-	 * later to shifts of any length.
+	 * extend subreg by doing <<32 s>>32. When the shift is below the
+	 * sign extension (32 bits in this case), which is always true when we
+	 * cast the s32 to s64, the result will always be a valid number
+	 * representative of the respective shift and its bounds can be
+	 * predicted.
 	 */
-	if (umin_val == 32 && umax_val == 32 && dst_reg->s32_max_value >= 0)
+	if (umin_val == 32 && umax_val == 32) {
 		dst_reg->smax_value = (s64)dst_reg->s32_max_value << 32;
-	else
-		dst_reg->smax_value = S64_MAX;
-
-	if (umin_val == 32 && umax_val == 32 && dst_reg->s32_min_value >= 0)
 		dst_reg->smin_value = (s64)dst_reg->s32_min_value << 32;
-	else
+	} else {
+		dst_reg->smax_value = S64_MAX;
 		dst_reg->smin_value = S64_MIN;
+	}
 
 	/* If we might shift our top bit out, then we know nothing */
 	if (dst_reg->umax_value > 1ULL << (63 - umax_val)) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index 8613ea160dcd..62da0b8cf591 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -531,6 +531,74 @@ __naked void arsh32_imm_zero_extend_check(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("arsh32 imm sign positive extend check")
+__success __success_unpriv __retval(0)
+__naked void arsh32_imm_sign_extend_positive_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 0xfff;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	if w6 s>= 0 goto l0_%=;			\
+	r0 /= 0;					\
+l0_%=:  if w6 s<= 4096 goto l1_%=;				\
+	r0 /= 0;					\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 imm sign negative extend check")
+__success __success_unpriv __retval(0)
+__naked void arsh32_imm_sign_extend_negative_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 0xfff;					\
+	r6 -= 0xfff;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	if w6 s>= -4095 goto l0_%=;			\
+	r0 /= 0;					\
+l0_%=:  if w6 s<= 0 goto l1_%=;				\
+	r0 /= 0;					\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 imm sign extend check")
+__success __success_unpriv __retval(0)
+__naked void arsh32_imm_sign_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 0xfff;					\
+	r6 -= 0x7ff;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	if w6 s>= -2049 goto l0_%=;			\
+	r0 /= 0;					\
+l0_%=:  if w6 s<= 2048 goto l1_%=;				\
+	r0 /= 0;					\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("end16 (to_le) reg zero extend check")
 __success __success_unpriv __retval(0)
-- 
2.39.5


