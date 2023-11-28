Return-Path: <bpf+bounces-16038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66847FB90C
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AC9282CB1
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1484F1F0;
	Tue, 28 Nov 2023 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="njv99yZF"
X-Original-To: bpf@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2016.outbound.protection.outlook.com [40.92.99.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F4B194;
	Tue, 28 Nov 2023 03:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5sjyh9eVBJXw7lCeSlEB6ixw6n/hAkWTSL5ayuUWOgk3CCw7wbaC76MF0qaHff+stxL/7nrPItxmCD5HDLM1h+SL7c6PzjyAYwD7J1RCFccfdGQ/gLF8+BbAjfDS5N0wb7c7zGR9cO6Nvk2HwwsDiuGBCedvWwBvuNme0ZE4DBGAgdKyCcMdiLsLSdr8Ecd0hyqfnNgoN74vyrh/XLn+DbEdaEWdyUG3ieDLp8KUjkUSXDXW1uKJPIKAfbYoyQzA8G0Qq3iIDaOSKnMwSHXtT5tBlwJZYsvLouuBWxarE8+oYH5yIoQ6zNDeoUlB/aX839I55zUCVWFaLreIwY5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=E6MHV2p2caTBW+k2D/kr+vveiVt6zMqSOXegUKY2Dm9GqtjjcTSbEYlVGhpxqLTwOKVwIAs9kALWMXgV72ac4LNw7A3SMRZTNixmfkK/wB19swbe8PPKXSiWAjtqHRauuMK7wNy9MHQURWHnlb5RtgHGH8LgiOfy/F2qOE2WIHgwFc7CTtByBFdy2gjB+S9v3GjvlYHFFQK62AFqKBte00b/1z36aFs0ep3adPY/niygNkBu9IfRA5RfgxegRXjDbS8G+DfMUxelOfZ2few0zusMaJfk4jfDmq9DgouPcqgFXoTdYs9Da/5PwdmToWsforzIkl9XL3kA/jdWZwHFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=njv99yZFNp1MOXbgnCwSFQRbwfzvLQRYpToZB7MKs4zydRnuiUlqYor0ln0HWxHCSoB6UDGiSgzxe7F37HP90ued6CiXVifjMLTwrtNHgV+YIG4+3aNn3kUoJeke8+UjNT17FjeYZCAwAWoRdg/dWOVMQM/2b5ZhDl4+HGqWdy2kzxZKk81Tw8Elj9BQdmr+oAXQt7w7vYTS2LtZcCYdxjz4aFKcIFFUEMsVJeVzgq4RNmkm9k680nNTyLFqNz/ZmXevlqwvnKQGrnI6Z8LeqHAPrDxhoiqN7EkjP3uvKBElcWuaqOx178qtfVWSqjsBh8Q5MXiPkXpQoICfEvEtjQ==
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::12)
 by TY3P286MB3670.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 11:10:06 +0000
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::353:ccff:c96d:6290]) by OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::353:ccff:c96d:6290%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 11:10:06 +0000
From: Anquan Wu <leiqi96@hotmail.com>
To: leiqi96@hotmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] libbpf: fix the name of a reused map
Date: Tue, 28 Nov 2023 19:09:38 +0800
Message-ID:
 <OSZP286MB1725483D5E233D6A98A9FADAB8BCA@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+r9JhnU3rOU48q+lTjnDA73f3pWbfgJC]
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b9::12)
X-Microsoft-Original-Message-ID:
 <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
 (raw)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1725:EE_|TY3P286MB3670:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab3ce04-ed4d-4c26-acba-08dbf002939b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qYVr0pnIoSQbiqetPZIBdy8F6PUBCBNxAdaaGQLfQ+91AqFEWiy1ciMiFJEULJFt8P8CgFQB53QxPwzSDY7NaBilcBu6bu3Gf1f+9/YHz2a+I6v9zaoDTCrX21kZ4hhutVRYnCzLNDwK6On0VtnTPTXMubDqGoLFe5LoX4uQqmrcthH+m1Z2ofJ6kE5C8HFet/nBJ5KCUcwshfOe1stDT4MvgWrnb+xQqnaizIxj7OsZlQkFrUzijN1LsPp3aj1nQebsaxoqVDPSk8mOW3TT0ABGYHv7qAE5AQ+ZwxnsmT85+4YTRKIzRBvuzicPZTD0k8WTJei8fAVlBbttx/xRziTgl4IILIFk+grIZbB/ptE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkN9o3GvazPJgNeXi7mESfdvLNUFqZRKTO1MXVSE2CkKEB3bZk/CXpG6d7sA?=
 =?us-ascii?Q?cMbadS1oOQAPSNPdvbL5+qAOCBECgfqBY781RQL6NQuHPOxfe5NPIp124T/L?=
 =?us-ascii?Q?t58EXAi2rmj0jHxby/pinDfjciuWbhXnptBIPv1Rweab0uRVBAREypvS8S2L?=
 =?us-ascii?Q?9WotlwvnlcgWT2TMDfyzXS0zUNfPL+fwFHFGzM/gBCMcOe0fQfXVAGKj7Bx2?=
 =?us-ascii?Q?cr+O/zyF2gOnXrHO/Rq8emRgVEdojKRdtPTgkX3JYC8HdreDou9Xv5xw6h2s?=
 =?us-ascii?Q?0Ttg/h98PmLzzHH7zxRoNzoJEahOKW0L0Y8UdlWSAG5HStQSqRIWjbR/3Tgt?=
 =?us-ascii?Q?dpcox2g/53tnpO1vQnT2IQ26ZPO/ZAAP8C5y/2pywC4UwPXQlK+1VEjnmosc?=
 =?us-ascii?Q?kHn1VtdmLpKlJXnIpXSFAzMXDuzVHZvrM0zUJQd2+DwcjHPtsuELvBtiVPbM?=
 =?us-ascii?Q?8dDME/HVH+HuF05Xi2/OldLicvwS6K+ElflFKrqPfVloa4yCrmc0lYsUxyLr?=
 =?us-ascii?Q?kfzZHTLs+BN+M2GFgTBdIfQG/N6wjWkJfYw77eo3V90kX10ttpmQFJVeICzg?=
 =?us-ascii?Q?b/PxzE2yyNm27Fv7q3KLLCSTZx43SuB5kUVCQpUq2QZwORboAW5eLr3wzA/C?=
 =?us-ascii?Q?ZTlD5fQFBbfErBT0OJmukBdjYRspHhvXAhCKb1hUP4lhI6Fy4YXnuEn6BMJr?=
 =?us-ascii?Q?pPUgWytewy2zmdUN821cCrk4ndtG2I69tdOjojumymMLmiJzRS4fJib0aU3d?=
 =?us-ascii?Q?Z7sp+p9EHTRrdS4AiQKvJLIy2L+9QbtVYoiwpplJ/ni4zODoRlGor2hjaW0L?=
 =?us-ascii?Q?j377sr3/2cqbAQHVk2nIIaAIKOOqUYN61gwvgusVej+W6hv2TJ4j5TEJU695?=
 =?us-ascii?Q?oDazeQCTvd4V3O766SSHT8Qvg++LBALkHSUbBlucpldw9rpEL9UGCXZd5khR?=
 =?us-ascii?Q?884hvJF2Os1LU0El3KY1weBE81SMwHusBrDelFQDRIumkd+YInEW/4nPj0Lg?=
 =?us-ascii?Q?KrpaVotxf5uwPdzZqj4APO/urVa1VsaXjMU88oQZ8IUmQdg913GILczG/cH3?=
 =?us-ascii?Q?YBZy2w5FNIIW78SXMTg+IyIryb+9zRg2ZzAfmo1O5kKvuWCkrLVmdi7Cxazs?=
 =?us-ascii?Q?cgcmCmauuUC3n8xCN17VzrEBzLpXkJ/IJBgvDlWu4P1mR8T79ZAntWPppDVk?=
 =?us-ascii?Q?W7vW0zQf8iBs1rD2ih9V2mXyjMC9fGFnYAtRcw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab3ce04-ed4d-4c26-acba-08dbf002939b
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 11:10:06.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3670


