Return-Path: <bpf+bounces-57081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE15AA5343
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB951BA4C95
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688F27A12F;
	Wed, 30 Apr 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Xc63y4ma";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bDm0rXUm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A3276025;
	Wed, 30 Apr 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036000; cv=fail; b=cm/JntFHu1ixNfkmDj+QsonRqqV3LQVSPJshedp6dsr8nFmrJiCN1GV59dhhKzPQX49YgF/zOMseBmc3PoSHaRvW46rl3bI7tsb2ff+BNOKsPsFzKQBlRBHiThI7fUYHjSc0PJuPzWmtk60me4pa8RL+skn1AT9Nr0uV7PMM2QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036000; c=relaxed/simple;
	bh=6sMu0KXkj7R3FYF1SPX9+c49xE7pQkxWJ/ocTPyPNdY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nI8MD2WRjwObHQnpAbGAhgyyrA+iez16MESG21PMwixdsQ4wxRLLVYjLKwpEcynqPkbGvaTIZVVnajWKKq5kYNS3+sblqbZaLzDaBFzhcPwQ2clxDZW8Q0ERyvPwrioZSxKepHjlGZJ9kF7rYjRAlgsOYGhC/GdTyesiS7WZ0T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Xc63y4ma; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bDm0rXUm; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UC5seh006811;
	Wed, 30 Apr 2025 10:59:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=2WHCZnFBw5UJE
	oJjmlVkgY/BM35GcbVoqD2vorxqRlI=; b=Xc63y4madwXW0G8DWfdaaclsY/NQd
	7J04QcYWDNa/T0KHo38sMmq7QxrN7D5cI2pWzSL1VzIBLI6fkfYIo43iFZO3PCIj
	gIOnAuJOgGabSO6OwB6uzBcuuTKEmBPr27yMSgK1zRj0Oz6m3pxjzuPcTLjAkjbW
	hCbZUlX69Ux0Oua9WHiUTZ560bqO4ifWFl39uyPGC5orHJ+Rt47RVcuOs0MIOSEt
	qo8yE3IBAFg5uFYnTJGFH673f+7BflFoCr0oJMGSX6/Nr/vqySLudmp6d9LTXzrw
	eM2byxscLLFII6ymhtnKk+iIf99uUAnxWp6ieUCD6MzMGjRoe2dOBtqNQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010002.outbound.protection.outlook.com [40.93.13.2])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46b9g623cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 10:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN1IirSbTXOkRjQLQuNQ1lZHajHUHrcCM/EXmHg7G5wZ3KtIuxe3aWvigmtppGOrb5Hf3dNe/CfMWqstQrqlks0XvMAwHlDLgGUTLJ7S5aMxRzCKD7xcOE2EvMXvAL5SPilqQg1X6J1nAwj9NFtHfWdiTEl8jhbA1/bEPMtqKLSFDENhXaGbzQAwtHjLwQ6KNdRWjOTavyVKhySig9ampSFEk/7G0q3M1biAB37B25Er3F2hJxe9QD3Jcn2t7XbpCYWnJAC+vaxnlvKGl9NL8rHQAVA6FNhyhhltGaQUdLT+jKn0GhqdbmL/xVuYmaPxjFMS4M+xUKXD5qlmkDcbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WHCZnFBw5UJEoJjmlVkgY/BM35GcbVoqD2vorxqRlI=;
 b=BztUwwIeDdZF6Qnxr2BUybyXz2/VDXAPfsUixoFzWQIFJoTNcY65U0NSlWbi9NFn8o/djPqqZ3q8/LV3lpft6MCLCfquokX2OY871GkG+Zc7XsUFJkbreviEhtiwQTdyDaIVsD24h7JCEHR9UUiPLkKBRA3eew6Jrg4/j0x6zPAnRiZPDm2sq/vYJfStgLvE/aYjvMlAMQgC8fVqKWjB0Lw//Yxn5/cVJqbM0gxHlBb/KDzlfUiVFcexWQC4K9n4WaGPrCahHKwYkgjQAxyPVz4U33Kl50L9d7eFrB3D6vq1xaxERQPp6n7FKp3g08OKxRARts77TntteDiKPuXs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WHCZnFBw5UJEoJjmlVkgY/BM35GcbVoqD2vorxqRlI=;
 b=bDm0rXUm/sh7m2xIwloyvVPFIWGxajWpvCn7tfuOs32PB8OM9PExAzA9WtiJ6l1irbXVRs+MCa2WtjP06NLZ7KwnJHV3RL024p32UKoDXmBA8CmfYWsxaf/0rsBU0AdDNhS+YVizSTnnv3Izq6BQ3LSxf/ABgGu37dc0swEEvnxd5lOsRPrtVJJ6RJ6kyYLY2ujN8YbMlgBEhO+foDHofcb465vW5LD9Qo0t3aPkBN/5G32nh9EV5bUYF6EOHaFUzx+IaA3qYsj+sBJoBAhO8JR/iPCS7pGrMxPknuYKHiHVM1piP6W7IAAqjdqoZ2wLGW4hO5sNQUUPLkZgTLvykA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH0PR02MB8761.namprd02.prod.outlook.com
 (2603:10b6:510:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 17:59:11 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 17:59:11 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next] xdp: add xdp_skb_reserve_put helper
Date: Wed, 30 Apr 2025 11:29:20 -0700
Message-ID: <20250430182921.1704021-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|PH0PR02MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b378f4-ceab-4b57-f6f3-08dd8810b5ce
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KO7e5zerSy/D/cVeNVfvcbrE151e9Ql1Lm948TUBhXZ0eRckEYVHoZlNSSFj?=
 =?us-ascii?Q?1jStw8h79ZwnVHIszxNrKZYzWB5t6olv+CATw8UlWOCVOyWEJs7FfCcsQIOP?=
 =?us-ascii?Q?in8JjUJBjxy3mTtE6+CvcbWIsBII4zOOvvEUuyYKH0hAZwLLGKEk8GwY4S6F?=
 =?us-ascii?Q?vOqXzkdd/OyShk36fZ+YergHGdPArdXbqy31O0xSnDV8rv+MYUe0EEoDyr/o?=
 =?us-ascii?Q?LKomsPuoUVJRdlxN1cID+uI9Dy5Yocvau8xqrhYR+v1LvFSO3udw1N4Kb6nq?=
 =?us-ascii?Q?3N3pqnak7hobukeuB5DY06pox3pVao20AWhbF6m25DJjCyXbG5Fgl0SdmcLq?=
 =?us-ascii?Q?jqbqzOXeLnxpoSn9uY/INqYf5Zg9hTCUSRIRoHutfTz3FC9lZQzYLXMXGMzF?=
 =?us-ascii?Q?pqJTwH2+Uu1uGVQusZnzd2+nuEUabO8enoJhP7M2T6PF/2PMkKgqbVrNgetE?=
 =?us-ascii?Q?yY7FU9tz+9c9m78qR/ihC1pdVMLimP6O4K27P5UZ8NdHrIammXF4tiaowNdu?=
 =?us-ascii?Q?lRhL4yjHNx8mc+yv0Dc/cktUpyqzD/yWN7c4/Kzcu55cAjSykNUnU+M5wmle?=
 =?us-ascii?Q?aBex7Iyw6rqTAU988fb6QtQh1dvTNAu4dTXbGvGPHtcdgdOIddCGg3jrx4B5?=
 =?us-ascii?Q?UFfFjHS+nHnpFnrrYhqWciuSvrLawUHjKLC1oLxEvroI+axcOAI8t/1PtPf6?=
 =?us-ascii?Q?Wj+qpKHSxqgLQrnW7qyDAQ9LRgNej4Gqi6zUIsUtd669Y+YLGLZ+mii2Bz0y?=
 =?us-ascii?Q?SYS6y+v9ENLPeLiAQNtvSoPwg3dW+CXbbU09EcBOWdoc+/B8DvgAXnLpoy3d?=
 =?us-ascii?Q?U2JX0bsWWEQ/ZtFHurEfaYex2rS+mvkdgpkjLjvZVb+vljTCPSyE4DDrWmT6?=
 =?us-ascii?Q?QQVMzkJIVowiIarXeMC+ef5eJY6ProhW5V6k83yBN3XiEzc1a541nl87snxN?=
 =?us-ascii?Q?jrZy7meB9nWAcUyVgw1JE3t4/iz2E6mwAedEr7kWUwgfgcDFUJdYYPrfeXhO?=
 =?us-ascii?Q?twOKG6TdVL9LSjBJzOuxY51Bg+RkZcCEBGcrACQ/uPQHwvg9/dIAoUbzGVfT?=
 =?us-ascii?Q?KinHpTCvZ+TUaoSbOQcpJgeA9Np1mBNcRicq3ISn6SCRLkaTWmLF+DNZzr1w?=
 =?us-ascii?Q?85Jjw6cMwIzIEe8isRTeGTNegUUzdsM60VFzV76IjT38DeGa95sA/FRztl+Y?=
 =?us-ascii?Q?oWyoA1UO1ZFI2MsRblXdNrczos3TwPVMsiZD/0JUv9QbeoO9uqWPCCU9o0WN?=
 =?us-ascii?Q?TcqbWOWhGZOxbvj3AiI0tLZzv9DFDzEpWgJHV8nDAMnGR3MHHtMw1KM0hqFd?=
 =?us-ascii?Q?29xQC341oYNbKZOBRAjtfwoNdMQygg1IqX3ObZdeT260OffJw7bPlMcTv3Ju?=
 =?us-ascii?Q?m8l1H1zxD7Cdyv5HQSXK2edh5+LUuU6piS/tSnws9kGUHPgAQFAazfO1uswv?=
 =?us-ascii?Q?1Z/u2Q5Mwv+TuCg/53rOYHPAhuY6CA06hU+glF2va9E63hE30vLQ0IquIwLn?=
 =?us-ascii?Q?w+iTAjmZHqS2n0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2I3SgyV/w6RvVEUjv2KTYcRSbzTHXoix5i8Wgq6oJE1BBnVaEAHOdM5cmG9z?=
 =?us-ascii?Q?vZCMGQAch2p2KzZDa9JSGr6E8n8TouYBcMI8Xvt/UDIDfJtFNGg2y4YNXQuA?=
 =?us-ascii?Q?rmUexotp1NejebB4dqw4y8dGCr94Q2QF7QkCYHF7JlalHi+oZRIJ2Qt6j7mH?=
 =?us-ascii?Q?n3ceKWqJvTW5mFWaHyso1BpYAS7qrUqCEQJML7T2/LALNQU7DAKT5JKVL6FN?=
 =?us-ascii?Q?u5abwYusk7BtM07GyA/rVx1XRO74NGO2YoV6/BFY8wsznXc9u68ryWz4rGBD?=
 =?us-ascii?Q?29tiGaPJm8Ts0IBLbn5NSaq3/u0ycwg2ug9qFZBj6rZCmn/lu53Y5cqQETMA?=
 =?us-ascii?Q?A+1AHGZIa1aXoqpaMRA0TCF1GjlWcvQ4Efe4aZC8AzcxpYXeUG1G7W4HYsPN?=
 =?us-ascii?Q?1wqQYZcraOM/zrZbqUXsiCvpLYlmRFfyV1fFRYoZKjX6kMkzfWv3aBHhsuFH?=
 =?us-ascii?Q?+ohhDU3A6e8K0DcbSt850FunfU0ah2O8qOZDK+XXOPABH/KWVYsbBxzR7CdV?=
 =?us-ascii?Q?iafjQ4zhUz5adryrlOcnmQKrmh7HDSiKCHC+59CNbJ3VdoNnmJa8hK3ns/e5?=
 =?us-ascii?Q?NXCpX/UnKptAgkJqxU2dFNWbEQQznIxnzZIfhmDOSCWeJzglQu8GpACnFtHx?=
 =?us-ascii?Q?vA57gzCTE4eeazMRqNwPYgjCd+vmxx/u1mvngWtqE0YKzttH+sqTCDkdAV4L?=
 =?us-ascii?Q?ZOUsYu0kRYOL/1GYk2x0idXjAG9xiFy8nKOHzINZL18+r0UWPdh+VdQfCPYg?=
 =?us-ascii?Q?pcfEvno/Dc9RJlK13M5BgkX4UP+QZ60/9HxFf2rqUao6SSeXKpoGAQ07rkDq?=
 =?us-ascii?Q?Z5QoYmX8F5pLi4emgujYLJQ0zpxGFCQyJy9i3SeNwa5b9YjC7MtJ3a93gBj6?=
 =?us-ascii?Q?6QiJxlSkCI5PcgV4jW5sZBviJR4V96vfPfTCKVFzcaVy+xHJjY0ns23xJaTK?=
 =?us-ascii?Q?TksBxgAM+LpdM4MdANcvyFP1tQ4/rtLAk3fqUZMJQPIIDTdyE//imyCUTRR5?=
 =?us-ascii?Q?OaH3aQzFoocJrOiuKn3knerrjCP9Y7IjrRXTWKZOIX6F8V3cXVrpenScU54C?=
 =?us-ascii?Q?MEFaYSas+D300UpQR67cBy+JzC/wKMyEA0F540n2JJfpFuBZOgJaHb2Plz56?=
 =?us-ascii?Q?DRpkF4vQe6sp0cn+eINhZgBbr+3FgXSH5oX8EvpyyePciANff5N/LrWhgR5M?=
 =?us-ascii?Q?FkRg7F+muHZZiUZE2WPLnrti7AdR1g99zkDIbfZIwhB8GAnttCXtIFkV+kqO?=
 =?us-ascii?Q?LPOPVfCxgY8HaaDw2OIkWFM4spxoCwhxvHzdlgH55Iod2OwcjYutHOZqN1mp?=
 =?us-ascii?Q?Vois7CVMrCF6tGBYaW0UyGroDwQeb0JCnt/lHVZs8UQvtekhC45E/9kRkKf5?=
 =?us-ascii?Q?asoB3icx2V8jKvYKZtVE2/oIzzLKFdzUgr56dYx60a6NpTPrASiNvpKY+OI4?=
 =?us-ascii?Q?sK6txwblWrmja34TLLSJ6tuxVso3pZqSVikXyhpdaqQGzdZdpnajymrhWEz+?=
 =?us-ascii?Q?dxI664/7greatHYqYgSOTNdvR7GtZfZGpmzL7fleB+vZtExHBPK9QBQm0OT/?=
 =?us-ascii?Q?o80nzSN5+R0seUeEd8Kdz/EIH7JVHrc4X7Y6lvgs4SQOI5ugkKs5N2Bo+V+4?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b378f4-ceab-4b57-f6f3-08dd8810b5ce
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 17:59:10.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pBbpHo9JiWEBTbuUZQHJsJ4Fr+vQEatDSiT9c41p4DwzZqX9oPvvLoEGpbC7RyN5y/mvSJS9HZ+9/0+MtwmMcMVSTTfeqJVFpctJ1Az3XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8761
X-Authority-Analysis: v=2.4 cv=GolC+l1C c=1 sm=1 tr=0 ts=681264f5 cx=c_pps a=rknZK0v7KRh+kGA6vhtu4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=uhLky4AAz20MDxUL2KsA:9
X-Proofpoint-GUID: F-07X2CkJKEvBZ-L3so64Ah6PRI6y4O_
X-Proofpoint-ORIG-GUID: F-07X2CkJKEvBZ-L3so64Ah6PRI6y4O_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEzMCBTYWx0ZWRfX0qCazWYNvv9m MFPwzXcNXd9N8vTZAYRbFS3Ac51o6T5FuIB3rxQGGQ2KnNxXQUWc1GrxsX/tn1NgWLgl3XITIBF 2Fsoo0iFxIUAP28JHXJEmef6F4MY6/ZxUoSmabnlPCJv+WhvA4sFm8hmhFWWV+E3ceaip5zO6k/
 M2IR9wKMp4mh2jGUTr09eNwlFOZzk16ygKjBT8EpeDMZC5P/GquFVRNAgzAuqkmVUK4iBo3Cf1G +NwvPw42b9qHh+paMgUHSQYjQWNLjVhzfGrv5yBeVxIXRDIeqUeCkotaGyya2zZQoaSVwhvgICo zj/46NOILizMre/qOPyCMjnFklBBkVyay7u/dzzYYVyRl4S31SX82FUkBZ87vvzV61qzbgz9w4D
 BWqrlFpRTznvrWTvvrWUg54dD/QRJnNHKToYwXaOl7E1czGJmhx8Fx59i1xMuRSFvc9Ijx3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Add helper for calling skb_{put|reserve} to reduce repetitive pattern
across various drivers.

Plumb into tap and tun to start.

No functional change intended.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tap.c | 3 +--
 drivers/net/tun.c | 3 +--
 include/net/xdp.h | 8 ++++++++
 net/core/xdp.c    | 3 +--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d4ece538f1b2..54ce492da5e9 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1062,8 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 		goto err;
 	}
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	skb_put(skb, xdp->data_end - xdp->data);
+	xdp_skb_reserve_put(xdp, skb);
 
 	skb_set_network_header(skb, ETH_HLEN);
 	skb_reset_mac_header(skb);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..30701ad5c27d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2415,8 +2415,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		goto out;
 	}
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	skb_put(skb, xdp->data_end - xdp->data);
+	xdp_skb_reserve_put(xdp, skb);
 
 	/* The externally provided xdp_buff may have no metadata support, which
 	 * is marked by xdp->data_meta being xdp->data + 1. This will lead to a
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 48efacbaa35d..0e7414472464 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -345,6 +345,14 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
+static __always_inline
+void xdp_skb_reserve_put(const struct xdp_buff *xdp,
+			 struct sk_buff *skb)
+{
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	__skb_put(skb, xdp->data_end - xdp->data);
+}
+
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 			       struct xdp_buff *xdp)
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a..1fca2aa1d1fe 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -646,8 +646,7 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 	if (unlikely(!skb))
 		return NULL;
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	__skb_put(skb, xdp->data_end - xdp->data);
+	xdp_skb_reserve_put(xdp, skb);
 
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen > 0)
-- 
2.43.0


