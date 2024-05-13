Return-Path: <bpf+bounces-29665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F68C483C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 22:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0811C20309
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283A7F7EB;
	Mon, 13 May 2024 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LT3bgxAa"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11023014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DE7E0F3;
	Mon, 13 May 2024 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632201; cv=fail; b=Cof8VGA1qDEOlSlwvPTw7tulqUyiGmAEXJEhGyebdDxdqyQI7oU9mnOJ5euCJMDbRP4v1iWBTrWVu+xvEDrssTd4V1BWKlKsJ5DHssodDGhDoezsiBX7tx8+ECpPbUa2ms2Sdvshe6rEYi8p6vm714oHcmvacFHTRdFHN4UUjG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632201; c=relaxed/simple;
	bh=bfDGBzzy37GvHS0G1jqZqnQzlYCpToMIaVZKMLzHsrU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jbFuCFwd9zJf/8u9ioXmgg25gQrBTbVsUvvMh5SQxUxQIjBuQw8y0+IWMGJfoMXBNT1x9GLg101eOYwmAx5YIUnQdGOT9LKPOzogf4WQM4Z0Wx6YuzIeMJauzR0wbVlq5eQ0RfHdufQSv5v+wQxdVQBxwOoob2jvJ7d+T1PUdyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LT3bgxAa; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxohMsfwcSEDi35N4alGBUkN3L19XaovayRyV/ytf42vEAYYyqDVZdm5yhf9znfZ7KcAzkGwiymMvRcTBEix7rmnMP0HFUODvr8KoKgbRlsYAhinuktw3LwmorkmEQlSR53Y/eqLIxTQKMxRJrN/ulVK2u9nH2ttFoAwtALvsJ+IP/q0FNRV+ZQnKstPP3K85GRS0kPVbb9X44KbNkCJpYw8GgaIvGemK8FUXNYVFRU/bmP2wiNAMwHm02NzDN/oHtiZVix6o9njHMomY6tNmQXP+/hc7xXganSJA+yTAo61Qpc2EqujM+0oCg4OLb3J7AOsQ/e8diiUo23m5rO6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJzEgEct5/+y0znKEOdlztwYOsxqe2RKNr5Am1iA3i4=;
 b=Nhpwi1KasRkwpraCA+Hnh05AoHJeKabXnKjNfSM+q+BqpwT6aDF1fyQiJ2ucT9FnHId88SQr8puHhk1ReMIuX1mA4zf2veYk8JvXv+O9e4adCWlPXGKGSfV/OX4mQHx3QBAllNATGGRypqzBqNTA1TE0WVuJAlGtSvnN0p1Skh4bdMeGb7SAgE46M4+PJ39AlcR0ENfZVHQ6P4k/J8LVxttjh2AMzuicueCTW2vMCcHunxD8RDACYBomELnS4Nm1jUeC+xyVdsE3elHmGKu9MkbR40Ij6St13vcoDYMDR16vK8QHZbzwPVMvJAXeLptoJxVXbsLSeh0YAKP4/RXlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJzEgEct5/+y0znKEOdlztwYOsxqe2RKNr5Am1iA3i4=;
 b=LT3bgxAaQCya/INqO16bnPOBVe6BqqrSuQBXdzxNv26zRNcl+z5qw76l33JnHz7pJr0U/Dhe8fHtB0OtxWGtc3rc4vsKFNIsOTngYaJEEX31Ve0Es/vh3w0yDWi4mNfFYl5w4Lmjp2ocU88JHKLP5BdO1TOJdR/cKrTq3nJ/FMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SA1PR21MB2066.namprd21.prod.outlook.com (2603:10b6:806:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.2; Mon, 13 May
 2024 20:29:56 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%4]) with mapi id 15.20.7611.002; Mon, 13 May 2024
 20:29:56 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: Enable MANA driver on ARM64 with 4K page size
Date: Mon, 13 May 2024 13:29:01 -0700
Message-Id: <1715632141-8089-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:303:8f::29) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SA1PR21MB2066:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d50244-a420-45f3-1570-08dc738b736d
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?JO2WTYqf2uquyHNw2SGBdlQVdX3BXGFnc+C0gI1qbLmgBs32GgGIadf8gQht?=
 =?us-ascii?Q?h+DVVQHo4CkXhVRCFSPnB76GxYjkgLklvP6UWhU5/BPVrBT1xb+tQJ2QVjXH?=
 =?us-ascii?Q?lGYURkMJENAcl9FATgEnemwXK1Yu8iuHskl69u7BG81+FND/+UHMKeQIFg9X?=
 =?us-ascii?Q?w01wo1AJGi4TLcOUHACOxuhku9vdW1HbtZJtd8ev1Z5r8ktfLgtexazlJ6jK?=
 =?us-ascii?Q?ls2MYVyH40EB4nPiAUBJRRcs5SY7ZE74ecVXIoIqP/+R0Kw1Az6JRDVz15oF?=
 =?us-ascii?Q?kgEt8lYf6f0tswiJlgJW+s00QvbxLG5GbMfKTHTP6pVlXvOx5637auaP6mMZ?=
 =?us-ascii?Q?8RSyaml0y2rNR7aE7VaOtQFrIvozGuFqbafL3CJPzQZqIZ8VOg498GWoheq1?=
 =?us-ascii?Q?yS9ggJk5hZDvnMiY4qW6qh65uz8MEx+mtDsmw0bB9Kr9e8VSZEYEM80/Pzci?=
 =?us-ascii?Q?BXfel3uo2cqE96DkJEXvqM4EBQIfxc5bwhjTbkh0Ol0vs3ryRtM4T98R3x8d?=
 =?us-ascii?Q?SjU9rEExIu0QCEnj2MVIjLpGzeS2iPx99JNtovG3b7pC7lmCcpNiQ497fqeW?=
 =?us-ascii?Q?MNe0anOC40V7mgDEfAw3rJa2Ve6EUo6b/A+Q5ho4sDGXd/h9UzyL8VQ+Aw67?=
 =?us-ascii?Q?TULErCMJUxc8aRj4yJI/p/l4hjeeaY8QmaLngeHMJMSl/KLJZD3GQ/jQ2Bd7?=
 =?us-ascii?Q?dD3ffqrKEuslJ4pof5YzwmNuGjWPY/GWYrRB6wdUkF+JCsLxM5TMiiHxsI1T?=
 =?us-ascii?Q?/sQ1xIlfqJdWRmG+TN2tIsXSnhscurwFmB6GAmJb+98nTJvxhxKFbvl4CnF1?=
 =?us-ascii?Q?L9sEUlnFkBF8dJ11zmsSDsv/H5+e2teIRQOdzYRqb5wvvVNJIHMa26hEfvOU?=
 =?us-ascii?Q?pE/dcPtHCKigdPSDqhg3AvmhH0CPFcYjKP79+qcTeXC0q15CizTIV7FYzL+x?=
 =?us-ascii?Q?KQTzQQD0rhZaIhQ2ArdnW1EAuDIBaU+PeKCGygnXcjHMstgt/6aRUxk+BKEF?=
 =?us-ascii?Q?bzvli1ekfLaRkBFNyFZzMYOJKYEs5ppE5YL2KrvMFLEuPiC1mhZUnFFardjA?=
 =?us-ascii?Q?zRjywDztp7Ejz19Ew5oyqtD6YyN81euvY2r7Sttmw1fkWEPmHVfraYJ9aMf5?=
 =?us-ascii?Q?D+iAdsNEktBbghAVZlpgpt8XwRsniP1A+OMACSD/j66p0JWKRR+STu6NbM3X?=
 =?us-ascii?Q?UWkRaruJDBXAwp3HA/U+0iZx/S8cC3fzBDok81/4PsM+krFzWGgXInyl9O8M?=
 =?us-ascii?Q?OgqflPRBa35a3wCpMS02IqbpW6sVudeWKn4/hgxIOY/byBmnagWrmvuAD1mc?=
 =?us-ascii?Q?pwK+XbypARlU/k2WxhuOBv8o?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SHEz74YdsIxPsGn7ewaqcfnkZO5pRzMn3s8N5Ihbc7HevSBHc35WyFSR85aU?=
 =?us-ascii?Q?sWG/gX8c8tOGt3kFcscA+uDxphd7puyzLaVVy6H3Svpr29NFOd85R+Vm50j+?=
 =?us-ascii?Q?tRI5uwp8MEj2lwfR8eL1cyey6cCMUZapoRutpyhNawtSzN/NXMSFXlblXsGC?=
 =?us-ascii?Q?PafdJvjm+o0XHJFJaUm/DzoxmUCTo/mULcQ8MGc7nFQbA0idISWbJ+Qprygc?=
 =?us-ascii?Q?Bh8LF+Jq21ZVO2Cslg9aMck2LJUga1ESwKDcFEhyXi/G5ZNSRroAin/TWxr4?=
 =?us-ascii?Q?nU5aU2zuDvMZ6djY1JoobuQ4efuXVYdjbmCt92nJBf5cOwa4STSzBjfvfzry?=
 =?us-ascii?Q?1ieEzgml/Lp5WgkuyYZNITUfE9mCd7smC9shfd5rjGM71iWYmYlpTrXBEWPh?=
 =?us-ascii?Q?h3UGuMwvecpd3POT3iMUL6MgKDs+pg9oiiL2C70nmkGibbRRH4t7p8jFfaOW?=
 =?us-ascii?Q?jbN+trtPxFFVAAG8pCRveGaotkDc1UMNrWWrkTi7CjNC2nnxUpibwgPRmNi8?=
 =?us-ascii?Q?lbKrG50tdH22wPh6CfZtqemCFlHzDQfEj0FWKZ8bMAapDOhJFixqPQy0CSm4?=
 =?us-ascii?Q?51sacbu1nerVLPjd52kFyTDV4uvlH5Eu8uTNNoXE22w65X69rJSKc2j8VEKI?=
 =?us-ascii?Q?uQPfvquE/y2CWEu91N1FYtVTgA7CZZGKDdl1fFy4VK7QipDuJo5LMw9oBjEx?=
 =?us-ascii?Q?ZCBo6mct54AEXVgFhsPD3Sd57jPDzHOwPtppt9Lt5tjYploGSyLvovDAWK93?=
 =?us-ascii?Q?1KEq7XAMGPbpaphpw8TpJphBXxbHgpHXqmSgJ0ftBp19pa1Yx2zQ9n/sS92e?=
 =?us-ascii?Q?aBXMHfLc02y9A7jmBInxET4GEo8UsG3zxvY5xoosuvCalmCtdQeo9G+2/9ar?=
 =?us-ascii?Q?lCQSJlYpvDoIcj3L4yHu3jKq5XY0zEUbttzX23otzmEBcyDI0anJF/s+ovXt?=
 =?us-ascii?Q?ECmc70GEbA7jF5/y46FXG3TH0DSdF7YbzzPjUWAto2xEjZopvNvTnKM8iK49?=
 =?us-ascii?Q?US3qts4dtYNDnVQvqou2ARIhdfgwlVc0JfEYIDmR0YTJQqAGheXSmS9Xf1IB?=
 =?us-ascii?Q?OewRu84XWs9fLc2IZhiKCvI25P9mrVON7hqHTgEPajFII2wnrIyllCZB0s4/?=
 =?us-ascii?Q?yxYnWICqtVjy/kpRXEoMsbDqBRHOqXJ1Qs9b0xCH+eVonJRtYYIbOYYwBO0F?=
 =?us-ascii?Q?2WSpWkfgtDEdVV4+n32//YNBQ32KrBP8JSGuPNQKiVCFJXHlnlSqY3jvmGgA?=
 =?us-ascii?Q?Ic28UXox76UZpW6hM/E2F+RPp5TePS//OTXgqfW/LBTCjreS5l7cUU8+HLG9?=
 =?us-ascii?Q?yTR4zvirzllmo4r9YpW2H83vf8qAEQuP2tTs7EflAM7tYC5P7mje/j2fFltv?=
 =?us-ascii?Q?EKcHnb71gFj5/CLWPIqU6CQbrjdkc6AOIViyUaEl3CL0xVscQWTXv/qqa880?=
 =?us-ascii?Q?cH6A6Aob17Ht7qbFEuysYSDHSpL4fEe/ptyzRGzribjAvjt5o45OfqWpdo21?=
 =?us-ascii?Q?2njpIAkIRekF+9Axp0gP3o97usIw2kbKjWvVKQFwngzAWMYw6RThQq7+y1BG?=
 =?us-ascii?Q?dC01NVTViIMQL2iqixVYebWqr+98KSuwsAz8MEKP?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d50244-a420-45f3-1570-08dc738b736d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:29:55.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex1SbWavx7MtFAiPT0nqai95aTI5h7IZL+MdB4RGMmIKmkKx3WKc7tvEXjwNbf3ridL0cyFnNwyfFP1Ggfhnsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2066

Change the Kconfig dependency, so this driver can be built and run on ARM64
with 4K page size.
16/64K page sizes are not supported yet.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 01eb7445ead9..286f0d5697a1 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -17,7 +17,8 @@ if NET_VENDOR_MICROSOFT
 
 config MICROSOFT_MANA
 	tristate "Microsoft Azure Network Adapter (MANA) support"
-	depends on PCI_MSI && X86_64
+	depends on PCI_MSI
+	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
 	select PAGE_POOL
-- 
2.34.1


