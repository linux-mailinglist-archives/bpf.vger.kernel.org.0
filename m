Return-Path: <bpf+bounces-28932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97888BEBD1
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082C21C22FDD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B716F83E;
	Tue,  7 May 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjRlmyDi"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A74C8A;
	Tue,  7 May 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107630; cv=fail; b=SIyt6fbqHtn4BLPAAtTb16E3VTmH7EqEuUVRyHRyXw5ewoeyDhErHwurWBzT4Xr/udfQ/0ikFr/0TcSwOZuH9uRvz5x02cG1OqN7GcDdNGJoidwWRdRTY/3wBGbwb3zsvK/rp1UvuRbqxCi1TrUECVy6I/83/ue4U6nrjtWmqTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107630; c=relaxed/simple;
	bh=yIrgxNwnmNXUu+Xre51WI5K2xwHWcW1tzJ/Z0ZY1NwA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bhlu09bgiwq2uuf/CbrT7KNAWbqbimnvi+9DewxnSIVGQvS1VTsh2+tJQ+poD2Io0jhhVq9AICq40+vrZ/3EQnChzcU2b35lfst9fag7KHuKZWUQUD9nUK2CLujB5t1M8rOu8TV90CSlgEjUxvnM/NyF02anyPlMBQC805GxsQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HjRlmyDi; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ8U1BefEGpUcX5CyF4c9aSZsIIyBv2UQRH3otAPHwW9I2EnhnV2NxjLZcuu17Mfm6x6nwBe+YON2Tx+yvbe6hvejMneJgRLqtS09UMrficfrYv8fCmcbPSduzt+jpCyTRWA1ucAnuMdrt0bYMzjIWm+XizeoXj99avesqkLSYi9OfX+B/ju/YdXuxoNDOmXWde/q75sLTzP6mw8JmDpVCMDoUsH3R31PUrn7A4JjLe0J8RxGV75pjsbDXDLcHxRp1A6hnjbbAo7FHnwnXR8aCk45FkGmOjOLNqOllAFKQ3xia6IjVzdIHpd0RZG/ubqarHT+CTneWgdzvvU/urAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY5T/oWna/5HjL2EqSYd7JGvKX/go1wp1bRk/SJgUGg=;
 b=JtfZTlk2UYyouGrhs3HIVd2hEosJcABnsIMocSgEa8I1oRWL4qbMUKEWpSmyvk0xnYTRH0MaQpzaRd+xZHb1G7FgLYCtxTJ0MCNQg7JDggN22idVOyU4fenBV7dUQ58Ffn7b+FNRTJooHm5/r7Td2xvaeRcpSoQ6Zt1rFqf+20goEL9Vw3U7E1mxbDhvjzCFbYcZiefvkG9sSI/YQwLb+T+yQzuCTRPmLXtIhGD8J+TDdpU1hwY+s7YdEQEoCtM0JLTb4OvSWyQOYq8F41ICxnO4DJ/IMHKN7nYNbCOdiPnfCg9Ck/msLcYmSeKCkIzmwou7/03uBKCRYpHPfkkgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY5T/oWna/5HjL2EqSYd7JGvKX/go1wp1bRk/SJgUGg=;
 b=HjRlmyDi/IybXyF8p+z/Mq939YA0IbWS0jWSxGam931AO83Hrub2YgKl+NL2LSzaGYUdQjUptjDS1X25f5IP8OjGTC5tGx2OZxGHF0nfjSvEp0jb4zNclUGA5e6dphMW/M8Mbm6H7Dn2cXEVK3orgtWmN5LWJnN7xA9L9+4fT6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:47:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:47:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:46 -0400
Subject: [PATCH v4 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-8-e8c80d874057@nxp.com>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=7874;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yIrgxNwnmNXUu+Xre51WI5K2xwHWcW1tzJ/Z0ZY1NwA=;
 b=gEDVVe7ncxBPhBycpIKpSQb9a0bq1Vgfh5CoJiS3J91K6frQlbIQ6Cty4KOj4STrOJOPjwDR0
 oENOuE/5rDmBn2LHdI1G6NoQ7W5Y5RN+7qWj0lWHsAwzsgc7Ioy8l96
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 499d5d02-1ad8-4dbc-fc78-08dc6ec6172b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3Q5YjJUSFAwTWpmV3RVdW5BYUlhd3lmWGtwcXNHTFR3Y0s4VzlmTDlZYlBh?=
 =?utf-8?B?QlpYeXJxMVRFdnYxZGc0WVFWakhlb2ZtTXgyREVkdEJjZXVBVkdDMEtYVWx2?=
 =?utf-8?B?dnhwWkNNMHUxZXFwalJtWkFNNExkZVlSR3o5c2Y1MUJRSW5sZHZjdVpRcDZy?=
 =?utf-8?B?aytzLytLMDRYNUpTMHFtYWRVL3d1T1E4Qm16OFpBcnlPZks0dC9Zb1hzYU1x?=
 =?utf-8?B?R09pWTUrVjhIbWpPenMzR2VXNEJlZEozOEJIbmJJTlJNTGdoWm81OU5MMldO?=
 =?utf-8?B?cWFnaktkSVlnblFWQ1RlcWFZMEtSZUN2Ti8vRUltNHNqZ1MxdVJzTC9TMmdl?=
 =?utf-8?B?dVB2dHZZYmVJeFBJOFAwaC9OQjBnTlB1WVAwSTVrL1U0UUF4VzBuRHZiWjdU?=
 =?utf-8?B?ekhoRjVwMGtDZVkzdnpaT3RRVUwxa3ZpREM2TG1zemY5Y1ZMM1k3RnI4cDlB?=
 =?utf-8?B?OFM3Q1F0bWJia2syQ1JkMGF6NDMwcE55WDJFZHpDYmxwZWYzcUhHQXMzcWZO?=
 =?utf-8?B?RkdROE1TV0thN3h6c1dFTmdUTTAwdUNPd3VuNlBienczQUdEWFA5cHUvbkUv?=
 =?utf-8?B?SjVzcGN0MmNLSm9kS2kxQ0J5MG96Vjg1cEQ1VjNCd1NNMno3eFU3YUlOVGxO?=
 =?utf-8?B?b0h4OHN6K0F5NG15ZlJqKzdaSmpldHNtaUYwVU1tcDVBajJTZTV6OE8rNzNq?=
 =?utf-8?B?MW1UWm9SN3gxRkxRclNsblluWEw1MEhBZTBMQXJYRWhISlpIeWhqRWZhVzJF?=
 =?utf-8?B?ajlIRkR6RkU4ZCtMU3pDamFqMDN5OTB5Z2NYdW11OGFTTWQvNWhoRzF6SXVl?=
 =?utf-8?B?dkw1cXZrSzJQWThzUnRXODNaTkV5RzFhS28yb2RFdExDdlRYcithUFVRQ0Z3?=
 =?utf-8?B?dWEzTTNtWU1GVkkraUkzakhPL1hzNk9rNi93cTBleTJmWFFMaXFGZjRYblFj?=
 =?utf-8?B?TTJSb3VISWFER0NtNXJjTjk5NHVQTXdqNm5XcEpSMkg3VkkxYjVyeVY2eFdC?=
 =?utf-8?B?bW5qckRwbjJ4VUhnZHFmQXl4V3ExQThOT1pHbnI1WEFpbEFDS0NxVjcxOVh0?=
 =?utf-8?B?L0YvZktuUFBLQlFpSjlFRGlXQnh1cS9IOTNRdjZDSW0zNVRQUTJhN0ZDRG1T?=
 =?utf-8?B?QXFSSjI1VWtsb0p6MTVLdGRQenpUK0hXQjE2QUVGNGNBU0ZWa0NkMkdEd1hs?=
 =?utf-8?B?Zjl1VHpWRVRnTHNJdkVQdGxwU1QybGtzNExCUXB3WHdLSUNJUTFEVW1hV1A1?=
 =?utf-8?B?MjA5SzRYd0lqeThEdS9lVHlEYk82aFMxYnU1ckhYWWwwaEN4clNtcmlBcVM5?=
 =?utf-8?B?NjczeGNtY0lTbzQwNENHdENEUlVTeG9DQ2s4V1gyVEgwdVFxWjM2MmVlY21J?=
 =?utf-8?B?RzcwbkpCZVRhVHRZakNYYlFRK05QZCsvM0lTYnVKMkxpUmtGeGcvM0lua0o3?=
 =?utf-8?B?Q2g0UG5RNGcvb09DaUFjbU91WEliY3RlaVNObG5Qczd6RnFKRUJwM09JcHJC?=
 =?utf-8?B?amRoYW9iMFNyL3RTSGJ3T1B1elFQUHBsditwT054VkxEU2tqNU0vK0ZXNUpn?=
 =?utf-8?B?bVZ5NHdPQWxmbWNBMm5EYm1hNFVKRUhRZzNweUFaOU9Od01lb2JkZG5XQnVo?=
 =?utf-8?B?NlBRSFpUYnBHLzRtT3hXSU12bkVPZHZhNWZOdlRGNU9UQndKV0hwamFtMVhq?=
 =?utf-8?B?ckpkUk4zMGtpZk1FaUh5SkpkS3Q0SStQVzVKSE03MHArT3JJYzNKZDVqV25N?=
 =?utf-8?B?OXlyRGhXSWtYQXlKV0xlVVZvOTErUTMrdEloV0VkWnEvWFBZUk03SVMrbDRL?=
 =?utf-8?Q?ihOsZ7u1mP9ve52FJGyPO/UkSoAG/Ep5t1R+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVMvSFZIeGpKL204Q0lRWTN6MlhzUE11aDdGZHdPalBNOFZlVy9ra3Vna09s?=
 =?utf-8?B?ZlNjd0RQbFVWc3pLYmRFN0s5WVdEY0dYbWVSQnhaVTRORWpqVVJWYXFqWXgz?=
 =?utf-8?B?TWI5K1ROdFd3RmhmbjlCdEdDWnZkdG5UZ253Y0Y2QVdvTnF0SWVoY3E1SjE2?=
 =?utf-8?B?bTlKWHcyOHRnS2xYRDlQcllZbWFOd05RVzlLcEJtSXVBemthdFZvb0JVdU96?=
 =?utf-8?B?enNrKzBCRVNTZTRORjJkWnhaT2R3YTc4elFTa1RQdmRpZ0JKeUZWNFFJNGtI?=
 =?utf-8?B?K3FNRWRNRHhOcmRtdnN3V0hRUDZ0ZkNqSjdhcTBFVUxoRHVESk5TdHNpQllE?=
 =?utf-8?B?VEgxVGRlNkl4TTVvZWhDWld2eHlacU5VVUgvb2hLNG0zaUFObUcwa2c2c1ds?=
 =?utf-8?B?QnIzeU1tSFgzazBkd09SeGhRYTJrdDhxYS90ZjZwWTBHSzJ2MEFMZVR3WkJV?=
 =?utf-8?B?Q0YyaXRwdTlVNDE4YzkvcENTczYzUEJob3Mxd3BISDk4bW9aTE9KQnZTdWFG?=
 =?utf-8?B?bWhlMzUxQ05BdmE0eVZ0dUNPeXVWNys4aUtEMGVTb2NvdnZ5S01IaWFQTDRM?=
 =?utf-8?B?L0s3bnJ3Qk91RVlNWUp0dEJVK2V2dWJvSWtNeFpjN014MUVmOERTeEZ6RzRw?=
 =?utf-8?B?dHZDNWpaRXhZemdDd0txVXgzeDhJUGFvWHJLSlF2cHdZVjRRNW44anFrZGl1?=
 =?utf-8?B?VEE5empJR3VueVRtRjZsNENSTGpoeldyQy9leEpsalY0U1l1MWFHWUtJTEZi?=
 =?utf-8?B?c0daVGdRWTA1MFpENG9odTVRQlFucmZ6eXNHTE03NDl6RjFvdWd1WmIxUW9q?=
 =?utf-8?B?M1M5MWsvZC9CM1h2OFRJWnJZUmpzczMxTi9UbU96Z2tZWVNvWDRvWjRNc0lG?=
 =?utf-8?B?eUg0Q2svSlFnaUpUVnQ2c3UxU25aRVV1aWZZYU1EVmJRakREUlFyZzc1WEl0?=
 =?utf-8?B?a2g4WHJpVVVMRnZCTys1NExod0FpOW1YNEdNQW1Rc3lGT3VqNXQ5T0M0SWRv?=
 =?utf-8?B?OGZuOEhyOGIxQTJTWGhtRnIzcEZxZ0V4cG0ra2xDcWRscDVaRzd1NlpTZHQ0?=
 =?utf-8?B?OTV0bHpJc3lQanZTaWNlSjRpQUN5SGNyVlFVa1dRNkN4Y0QrQmFDZFlKWDZF?=
 =?utf-8?B?RjFYbFRKUUNwczZ2bWF1bHNrZ1RBUzQ1MTZ3dzBxblBxZCtObkpRUkNDVjJH?=
 =?utf-8?B?SkkyY0M4ZTFhaGRNQlNGUFlFMFUyR1dkNHh1WHhPNVY1Q2RISTJJbC9sMVI3?=
 =?utf-8?B?WmZNa0MxZDdHTFBLUXNRYmdxWVA4c1liTy9xRnZEdTU2OU16SG05SHMrMmd6?=
 =?utf-8?B?bUwvckNGalcrZEhnQVhvYXdMWFk3NkpOMVdTSUpzelRoNDBjK1VjUzBQNEY5?=
 =?utf-8?B?VS96WGdzd0ZSbW5zdEFmTGNnRXlDK2hxd0JoMHlDYzlobHZyWUd4d0RoaW16?=
 =?utf-8?B?dGtKUTk1WEF0WnBPQkdTb1NCNHFMYlBmZUo3Si9Pem1KZDNNTktRNyt5UXNX?=
 =?utf-8?B?UWFrVGtJT01SMzVYenV3UHk1eXZXaDJVZlUvay9JdFpBSjZ2ZmZxYis1enoy?=
 =?utf-8?B?MW9RNTZQRldmMkJpak9McW9Ka3NkT1hBWVlWVzVPQlFDaFZEZGljR1JNZmFi?=
 =?utf-8?B?Uk9DTG9CZkdrekttcG5LQ0JyU2pNT2YrZndkWXByYWdUNUlsRnpHVCt2VC9S?=
 =?utf-8?B?K1BNc1dSc1VvRXVhdlZlVDlYd3cxRkN6cmwwZmZNU3NUVi9NOEFHRGVsamV5?=
 =?utf-8?B?eEtSaXEraGFZV1pDeHlHcTM1eHNNczc1bTJnSHI2dnpSN0QwZTVZcEtyNUZT?=
 =?utf-8?B?RStXK0lKSnh0QXBmYURkcFlrdUdvN01OUm9RQjRkWDMrWVljVTNNQlZjbEUr?=
 =?utf-8?B?M3VLU2hTWUgxbWhMWTVNUERXMXNpQjF2dlZZRFQ4ZFk4RVIyblBIdVBzSmdt?=
 =?utf-8?B?ZWlNSmh1Y2I0M1l3b1pXZXp5UVNKQjJzWnlUekxRL3lRUGNtc1NWVjVyRVZw?=
 =?utf-8?B?d2tsVDJEblBoaTkzczdac3FWU1NQd2lXaVMzZDZuSllkTGNvaC9Mang0UEpn?=
 =?utf-8?B?amRkdjZPZUU1QmNiYzB1R0MrMm1PNkh0MW5IOGFFZmZFbm1Dekp4OXNyMEc0?=
 =?utf-8?Q?sA+AABH/QsnRENB3pbSTKaABo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499d5d02-1ad8-4dbc-fc78-08dc6ec6172b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:47:05.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBKcmKWX2uVYzHemRLGFKWz7C15GajKSPTm0nnKbdIGGtlhRIuq82uGDvJ6i//MXOp1Sq9wLOdE1jM9JW7vyHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
upon the appearance of a new PCI device and when the bus is an iMX6 PCI
controller. This function configures the correct LUT based on Device Tree
Settings (DTS).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 175 +++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b33d8790a93af..66573ef7a002b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -55,6 +55,22 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
+#define IMX95_PE0_LUT_ACSCTRL			0x1008
+#define IMX95_PEO_LUT_RWA			BIT(16)
+#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
+
+#define IMX95_PE0_LUT_DATA1			0x100c
+#define IMX95_PE0_LUT_VLD			BIT(31)
+#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
+#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
+
+#define IMX95_PE0_LUT_DATA2			0x1010
+#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
+#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
+
+#define IMX95_SID_MASK				GENMASK(5, 0)
+#define IMX95_MAX_LUT				32
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -80,6 +96,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_MONITOR_DEV		BIT(8)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -134,6 +151,8 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -217,6 +236,66 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
+static int imx_pcie_config_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+	int i;
+
+	if (sid >= 64) {
+		dev_err(dev, "Invalid SID for index %d\n", sid);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		if (data1 & IMX95_PE0_LUT_VLD)
+			continue;
+
+		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+		data1 |= IMX95_PE0_LUT_VLD;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+		data2 = 0xffff;
+		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+		return 0;
+	}
+
+	dev_err(dev, "All lut already used\n");
+	return -EINVAL;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
+{
+	u32 data2 = 0;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+		}
+	}
+}
+
 static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 {
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
@@ -1227,6 +1306,85 @@ static int imx_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static bool imx_pcie_match_device(struct pci_bus *bus);
+
+static int imx_pcie_add_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
+{
+	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
+	struct device *dev = imx_pcie->pci->dev;
+	int err;
+
+	err = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", NULL, &sid_i);
+	if (err)
+		return err;
+
+	err = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", NULL, &sid_m);
+	if (err)
+		return err;
+
+	if (sid_i != rid && sid_m != rid)
+		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
+			return -EINVAL;
+		}
+
+	/* if iommu-map is not existed then use msi-map's stream id*/
+	if (sid_i == rid)
+		sid_i = sid_m;
+
+	sid_i &= IMX95_SID_MASK;
+
+	if (sid_i != rid)
+		return imx_pcie_config_lut(imx_pcie, rid, sid_i);
+
+	/* Use dwc built-in MSI controller */
+	return 0;
+}
+
+static void imx_pcie_del_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
+{
+	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
+}
+
+
+static int imx_pcie_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct pci_host_bridge *host;
+	struct imx_pcie *imx_pcie;
+	struct pci_dev *pdev;
+	int err;
+
+	pdev = to_pci_dev(data);
+	host = pci_find_host_bridge(pdev->bus);
+
+	if (!imx_pcie_match_device(host->bus))
+		return NOTIFY_OK;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(host->sysdata));
+
+	if (!imx_check_flag(imx_pcie, IMX_PCIE_FLAG_MONITOR_DEV))
+		return NOTIFY_OK;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		err = imx_pcie_add_device(imx_pcie, pdev);
+		if (err)
+			return notifier_from_errno(err);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		imx_pcie_del_device(imx_pcie, pdev);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block imx_pcie_nb = {
+	.notifier_call = imx_pcie_bus_notifier,
+};
+
 static const struct dev_pm_ops imx_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_pcie_suspend_noirq,
 				  imx_pcie_resume_noirq)
@@ -1259,6 +1417,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1557,7 +1717,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_MONITOR_DEV,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
@@ -1693,6 +1854,8 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
 
 static int __init imx_pcie_init(void)
 {
+	int ret;
+
 #ifdef CONFIG_ARM
 	struct device_node *np;
 
@@ -1711,7 +1874,17 @@ static int __init imx_pcie_init(void)
 	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
 #endif
+	ret = bus_register_notifier(&pci_bus_type, &imx_pcie_nb);
+	if (ret)
+		return ret;
 
 	return platform_driver_register(&imx_pcie_driver);
 }
+
+static void __exit imx_pcie_exit(void)
+{
+	bus_unregister_notifier(&pci_bus_type, &imx_pcie_nb);
+}
+
 device_initcall(imx_pcie_init);
+__exitcall(imx_pcie_exit);

-- 
2.34.1


