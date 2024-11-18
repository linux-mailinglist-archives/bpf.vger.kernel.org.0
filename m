Return-Path: <bpf+bounces-45116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8804D9D1995
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 21:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B91F2129A
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 20:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DE1E6DC9;
	Mon, 18 Nov 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f2jh6ILO"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013051.outbound.protection.outlook.com [52.101.67.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F313E8AE;
	Mon, 18 Nov 2024 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961493; cv=fail; b=jfXILOvmOFIaE1ae7YMkBPY6PiQji0AANeY9TAZ0LdQLKk6SXu3r1qCmmR0mIfrgwCI9Hy1xkfL7KNkw+ggO0dGYNtx7TteX4e8EzHTtZP3vsgMltOdMxk5HqmBrWSVAu9ZvOPEQ02JyUvVSuLXC6UBjfBNCYEZhCNe/yL6hNRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961493; c=relaxed/simple;
	bh=B6Qvgai/0tOcMkxFzyH2I0EpTr4YlSqtbUmvgLx2K7I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YPBkBOLHf61WeHwAggl+knyeDD3mKtsqWKqO04i6gBl2/Eg4/gtFp3vHTsYjrGzRkkgfnP4R1G67ZNvJAyzLg7rTesW5QaLv3sQUUaAasxI5b68WTCZMnOdhK+qAF9rRIQjWc/Zh8Tr0sxJK2i7PeKunVrHNRLrGG3RKMMNcoEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f2jh6ILO; arc=fail smtp.client-ip=52.101.67.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSVFxc5r25+Ic5kL7dBLlEcLZwxzQQonbTNY+j33RsM8uOwlDWJRI+XEM6JI2Kbf+s9o7hcq+wd2GXp80Q4ARF1ptlqt/J3FwpZS5rPKz68Nl2JsuVcggOeniP90Xm/g9y2Z+C4fv7pe0r8+ETDZHzohz6qPZ+U0ELpaeHrgocDKuxB315vkxv2KUC/le9MPPsIsdEdnXQtbVMY9Go5BPsrqzY87nPQ80lsVpqNUsA4SrDLdQh7/91dyhTBhVYvIdAvsUg6ALRQeS8VMyjGSQJ/aD8ceXkcWF4kMmMyUstXL8AP8c4yrlhOxxLH8JJnI1gywtg7Jlw/uNJHlAejp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ctd9rq8+up8tE/cKwovb7rQnGBRkyqQmzuqP/b9Qs4=;
 b=LBFXh2H0EOB/F6LXV7OtqLNLzB//yS2tk59ERG5ymBwGq522C0fF2hcMhi4Z8HCsTPd5P1NKLbZ0BjWnSkl0Ka2VpfJuPtcTpTsXbCi7N8VXcDkGIwjrIrxHKSgyKA2WElrxk8FCnQyZnvFjsRVDHPOjAYVjRhAdH+flxlKyefbb/Kiv8Gb1ccsaQJMVOJwhB5cFIygE6zawe+3fTAdmE0cau3zfmfpKoP3DGX3nlq8OGrnevh38FfZcVmn9Qoi6J4C8SjwrmCs/FyLFBNM3xq39YiLY7D5UtiAOjgTKpv4vTdy/JWj/iM6Btiz0AgBs3eBn21vio6DXaKl2RIWKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ctd9rq8+up8tE/cKwovb7rQnGBRkyqQmzuqP/b9Qs4=;
 b=f2jh6ILOZt1aATYiB09ajOg7z6++xvSmO6u7sNHi8Wrlsfv4PixIQfj/Xd520GyTEFyMUP19jLjVll7QkpBQvpFEWrGCydoF6pogesnJ+GGOlVvbGY8oMnmp1rtd/+rldnOqNK52vRWlQ5YergiL3wx1nHG+35VsBRaE1AMpqy6Kvhvl2ANy3hLnnr7adcxzcj1SNfEQe3osJRY9zzW8mhrMREiTlrXJVwqSwDAxQtwRsnhffpFbD4/f+BPICapxNuwd87FFv6ElBFzVLoG34C8PHJrrVQ7oKeisJYIN0FC+IZc/Tr2CIhzQUTxtOGUBe9OqwIPgl2qA2yQKGAMIDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 20:24:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 20:24:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Mon, 18 Nov 2024 15:24:26 -0500
Message-Id: <20241118-imx95_lut-v6-0-a2951ba13347@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHuiO2cC/23PTWrDMBAF4KsErasyGv1ZWfUeJQRJlhJBYxs7M
 Q7Bd+8ki1aGLGbxBn1v0INNaSxpYvvdg41pLlPpOwrmY8fi2XenxEtLmSGgAoeGl8vi9PHnduU
 imgYREzilGL0fxpTL8ur6PlA+l+naj/dX9Sye23cts+DAW4gGobFt8OGrW4bP2F/Ys2PGykmoH
 ZKTwShjg9fS+a2Tf07Q1E6SsxpcdIGuNWbr1L8TIGqnyEFus/OYk9Vq63TtNvc0uZyCs5hlFrL
 637quv8IXGSuAAQAA
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Frank.li@nxp.com, 
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, 
 joro@8bytes.org, l.stach@pengutronix.de, lgirdwood@gmail.com, 
 maz@kernel.org, p.zabel@pengutronix.de, robin.murphy@arm.com, 
 will@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731961482; l=4360;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=B6Qvgai/0tOcMkxFzyH2I0EpTr4YlSqtbUmvgLx2K7I=;
 b=b8mNdwCrFzqpA3a/97X2FaTJL4EtWmYSaGCNZC3IT3asp13XODoWHbg+IaIdfH64iHXiTTrcC
 N4MHQi6M3Q9ACF+Db/T6mP48ckB7TwJvLOmPhSHvbcoynNgV/kmNjyJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: daa7deb1-20c6-4ca2-5d0e-08dd080f0c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWRFNVpBMDdLL0hhSUVRZXBKWU1ZTlZmNWlDS3lXK1p0WDUxY1NudjRWM3hQ?=
 =?utf-8?B?VTJpT0dlWldPKzVTQlJsS09iQUE4YlZyWjgyOHJ1TGFSa0VuNzU2SE1IUzdL?=
 =?utf-8?B?UzN5aTVpL1FmVklKR2hWMGE5WGhjcEh6S2RSdVJueXRLczJpMk93QVJXbkxw?=
 =?utf-8?B?RlJCbktha2tGSytUT0F1cUNuM2JMb0tvcTcxUC9jSS9idVRKZXF2Wkdld054?=
 =?utf-8?B?dzFUSDRoVC9rcldJTHlHV3ZYMFJ2bExOcEg1U25qSmo4NmFvdnlwOTFxTDVr?=
 =?utf-8?B?WGU3RU9yL0xybGtLdjJ2QmZGZEhYYXp3a2k0OC9VeUJzMVNpaThMaGNhc0Fm?=
 =?utf-8?B?eE52WnBLazdIQnh5QTlNa29uelgzTUxjeitOSXlrRXorM0JjVXZLdkZtRHZ0?=
 =?utf-8?B?aTk1d0QzWUlGZHg4V283YnhoV0MvWnVEM1pPN2ZFa1Q1NzZ0dGpPS2tJRldH?=
 =?utf-8?B?WThRMDBrV1RjWnhOZ29vbHNOOWhZVGNmRGxlcTVjNDkvSlFReG5NelJnTkNs?=
 =?utf-8?B?TUY5QTc1Y2x2cklidDlaY0dnSXRITldkYy9ZMU9FVVVWZ1hwS3Q3cmRRSUt5?=
 =?utf-8?B?TGdFU1VkSFJlR2VrZEVMQzkrVDNvTUN0cGlDc3dpelZnQ1BGVVl1czRzSDNw?=
 =?utf-8?B?NHcyaUFaU01yVVZYT3dvTFpBa3dUNWJKcW9MRXg4SUcxUWdlaDV2QTJyOWtB?=
 =?utf-8?B?QjdJcm5BTk9RbytGYm1rWDNDMThqakhLWG9Jd0FnN1ZsUEl1blZxNDFDTXd4?=
 =?utf-8?B?L0FYRE10Q1FYdFRBTUdxanNUcHFvR1hQaTRkN1duanQ4MHlCSEpkaDNvdFNz?=
 =?utf-8?B?WjEzZkFCYS8xNUdWZS9zbHFUMnlsSVRMVTdFL3c1d0F5MjlaeDRiS014Um9G?=
 =?utf-8?B?ZGgvcHF2S1M5dm52ZnpiQ3dpNXhsUFlmUFBjTDJQNEtrUXJ6aVZtOHAzcGRH?=
 =?utf-8?B?VzlLZ2NLMU5CTkd6Sm1uZDRPdlBxYUtHV2FSK2lsVGdsYVVCQURZdnh3TE1T?=
 =?utf-8?B?c250eWRnWjJKVzljMUFlN0xZM2xKR2JNcGN4Ri9OSldaN3BBUTU5OWdRc3pJ?=
 =?utf-8?B?OHF6VDQ5VFBkbmZqcDg0WmszeEZ6Yk1CSW5BUlM4TWtORTVvaE5reVYzMFpp?=
 =?utf-8?B?UlBRcHZMeW5TbVZlZUxJTnNlc2MvTERDNWxIWTBHT3RsQjVpa3hDYVROVGFP?=
 =?utf-8?B?WW5DYS9EUC9GSmNhdThhK1orbFpqb0QxUk8wNUNicEdtWTduWndFdVNLd200?=
 =?utf-8?B?d3Excks4bzk0aWJsa0JMY2tHcC9RMWFXam1pKzIwRGJrcHpFOFZZWmN2a212?=
 =?utf-8?B?ajN1d0hodWhhcXVSTVpTblFxOEFhVnQ0YWdCaFlaTkVVVklucFR5dzZMd1c4?=
 =?utf-8?B?Y2JEYTEzZ0I5bzlJd0pNak9wZmVrTzFNMGtYakx1QkUwYXh1b1lkRGdJMTU4?=
 =?utf-8?B?eExnMzhBMzZzMkFTQlcwZzN0bFRsT0VPYWdIUExEOEUzY2RWN3ZJbHE4OVkv?=
 =?utf-8?B?ZnN4dnhjbTV1WU1ia3lOcjFSZm40R2NyTmZnUll4NElERG5lYStaYitSZUth?=
 =?utf-8?B?ci93RnRQeW9aeGR1bG9MN3VCSjhCMTlOSk01THN2c1pCRURkeVQ3NTJVM0dr?=
 =?utf-8?B?cllpeHFCSkV6bmVjcGNrUm82Y2RhSFVwZ0p2M1RsZ1FwWVlKNEVCSnRpWjJD?=
 =?utf-8?B?S3dHcUE0RjllNy8yenNFZFUzM3dkNWZOaGpyeGRTeU9xVWZ1N29kSk10RHg1?=
 =?utf-8?B?OFg4bXBudGdHb2J0NTQzSnJOM1FGRG1uZFd2RFJVSzBlbVQwdklSeWFoanlT?=
 =?utf-8?B?TnEyTjJJU2ZnNVVObjFkRUx1a25GakNXMDFPTmdnZGIycktxS1VMNmM0QjQ2?=
 =?utf-8?B?MzdBWDJhRUZFMER5bVhMLzdRd0N1V2lMRlN6YkF3MFJxNEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzJBNVE5MkJBRzdmTjQyLzAzRU96UGgzQWZ4ckJSOHM1OFRySGZNLzJNUlVq?=
 =?utf-8?B?U1pLU21JNi9xQnUrWmxEUWhtS0dxLzI2dDIwRisrWTZQK0IvVFdEUEtQeGc4?=
 =?utf-8?B?dW5hc2RhSHhkZE0vaG44RlAxcExMZThBUU9JaHFYSHltTlk0c1U4WXBBMk04?=
 =?utf-8?B?QUFjZDVqU0krSkVVZE4wbVhtUFpRaFJNV21KZjBmcmlrcUdtMGRuQXFOempk?=
 =?utf-8?B?cm1IcXZOWlUrL3kzNS9SdHhKY0ViU3orVXBwdVRRNVVqaG8yWjBuOFJHSVox?=
 =?utf-8?B?N2JHMjAzeCtHa2tXWlh3bVlZWGxJUUVQZ3M4STd1Vlcyc3dQM2xPUEVLd3dj?=
 =?utf-8?B?VmFPOURMd0dJSEVvdFdqWFJEempTaVVHaWRiaFQ0YnFJenN4UlFmNUIvN1Vm?=
 =?utf-8?B?dTFGRjM5Z25tcVREbDdjL1E4SGpnRW5vYmpYY2t6WlNrRkoxWFJBVnYzMC9q?=
 =?utf-8?B?Zk4yS3ZWRUtLa3BHeTNrT3dPNS9teXRWRm0yZDRGeFZRUVF0VGMzVW00UHYw?=
 =?utf-8?B?YTA2ZnhoRHBXb3FBeFhwNEVxd2sxQUZKbEhWR1hFOEwvZTA1SjB1VE92L1VL?=
 =?utf-8?B?NzJBUEdDMEI2MUhUb0hGY1pVSkl1ZjlkTjFGbGRhOVFTd3BHbFoveGVYTkxR?=
 =?utf-8?B?WjN5V0VKV3FxWGpmb2JLcjhRSzhoOFJIYjZ1ZC9SKzFGcnA5ek9TTXR1TEFs?=
 =?utf-8?B?TjhWY00xanBQc1Z2TTJ2NzdaSGQ2d2JIa0JuZ08wdDVaSnZ2dzB5VU5mNmNF?=
 =?utf-8?B?Qmx4czhOY3hERDNXU0E0QklZcVZzVGxaTHkyN3RDTTRmM25HSHltN0ZpTW04?=
 =?utf-8?B?UkhPdlZxVXM1QXQrd3pDUEI3TE5jekMzVmtkeG1tQ3VwQXgvMTZmZXFSejlU?=
 =?utf-8?B?WTRMK09XZlhQMUZVSXpIVTJHLzM0RXdXN3p6dkpUVHQxY0tzQS9GUnZmV29u?=
 =?utf-8?B?d2RpYnhZSWJsR0tvaGJsc1B6NzkvUUNFV0MveDVaVk5JM2xaTlA0QnByOXU1?=
 =?utf-8?B?bWpIdGgzeG9Tajh3M1hXNkg0MDRJRE0zYU15UUlqWVJreldmS0U3Qm9xUXAr?=
 =?utf-8?B?eVZvajB6eDJGWXJNSlR5MEUyUlgveW40dy9tNks0UUFZWWpGbkU0ZXIveXF2?=
 =?utf-8?B?b0NGMUdjTjVtUkJQbms2N3diVyttUTB0YklzRUZwdUhqaE9YUm51WTJsWWpY?=
 =?utf-8?B?STh2cDE5OHhoRXVWSzMrRHBOZ0tZckNqZ1c1R2JaYXpub0llNUdtRmNPOXN3?=
 =?utf-8?B?VkxkZ1pmYVhlczJ3K1ROMFJiaUtDdXd2S0tCM29WUWN6M09xZmtFWmdvSlVY?=
 =?utf-8?B?ZkNiaFVyNTZJQzQ5TVprTFFyd2thZDEyVHhlUDZJOUpoQUljbSt2dlg3dTJW?=
 =?utf-8?B?aWFNZ1pucUFGL2RIYW1BajRlYzBMNmNvV1BLb1ZVY2gyZnkyYitQekhmTjA2?=
 =?utf-8?B?WFNieW4rTkNPaTRUZUlHQ2czcW5iVm1uTkQrUGRZa1VQYjF1bFcrV01JZDgr?=
 =?utf-8?B?RXZvZ1J6ZE1qaU1kbEF1TFRGVnBRcVNzWjB6K1hQNkZ3c1MvaUVTRll3dEw2?=
 =?utf-8?B?VkRwdGJ2UFV6U0kvMCtrUXl4R0ZRWk1oNDRwQno2MW92TVFhdWc4QkpVYWcx?=
 =?utf-8?B?bUdmT0VKcDlkQlV5ZXZFN2xwTTlOKytuYVFwWXVuWmk2cUw5bVBwdE0yMnhu?=
 =?utf-8?B?c2trM2JSYm56R2VDYUNhMnE4RHVMbU5DN0JiRDNhVEVXbE1LeVhKQW9mTnVo?=
 =?utf-8?B?UVZSTEVreStWWGFNaXJmbDVaVEtnd1Bvd2xBTkZlQWZSeEZmOEdYcXVYVnIv?=
 =?utf-8?B?NFI2NGJPM3JJcS9DWHVQUzBjRms2QURuVlFFajBheWdkNHZVMVNFbE1EWHRP?=
 =?utf-8?B?cEN6b3cyclRVNnUwSDl3ZGV1YXFjT0FkbGtaTStXKzNWdk9PYnh2MEUzOTl3?=
 =?utf-8?B?Vk1Pbk9aQWJnNHUyTyt5R0ZMcWJkZ0V4cmd0N2RFeEtuYVF3NWdVTDgzc2wr?=
 =?utf-8?B?blpuejNBMHlIZVRkOTVZR0YweEJyWGgxWkUwTXlnQ0NPc1FpOWo0UXJzQXI1?=
 =?utf-8?B?RTV4Y0JqRXRrUWFEM3pjdlBOcXlhR0o0L0VjSjJJbFNRV2FDaVBpRTA1QkVq?=
 =?utf-8?Q?lIes=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa7deb1-20c6-4ca2-5d0e-08dd080f0c57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:24:48.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZpuAqTdziX1xf6Vf/Gk80CCZbpGB/ejh+XEdJHCMBjxH5Zhh5Pca8bKtyrHgq1bwhAjlgbU5elf7qam4leZmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

Some system's IOMMU stream(master) ID bits(such as 6bits) less than
pci_device_id (16bit). It needs add hardware configuration to enable
pci_device_id to stream ID convert.

https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
This ways use pcie bus notifier (like apple pci controller), when new PCIe
device added, bus notifier will call register specific callback to handle
look up table (LUT) configuration.

https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
table (qcom use this way). This way is rejected by DT maintainer Rob.

Above ways can resolve LUT take or stream id out of usage the problem. If
there are not enough stream id resource, not error return, EP hardware
still issue DMA to do transfer, which may transfer to wrong possition.

Add enable(disable)_device() hook for bridge can return error when not
enough resource, and PCI device can't enabled.

Basicallly this version can match Bjorn's requirement:
1: simple, because it is rare that there are no LUT resource.
2: EP driver probe failure when no LUT, but lspci can see such device.

[    2.164415] nvme nvme0: pci function 0000:01:00.0
[    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
[    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12

> lspci
0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)

To: Bjorn Helgaas <bhelgaas@google.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: Frank.li@nxp.com \
Cc: alyssa@rosenzweig.io \
Cc: bpf@vger.kernel.org \
Cc: broonie@kernel.org \
Cc: jgg@ziepe.ca \
Cc: joro@8bytes.org \
Cc: l.stach@pengutronix.de \
Cc: lgirdwood@gmail.com \
Cc: maz@kernel.org \
Cc: p.zabel@pengutronix.de \
Cc: robin.murphy@arm.com \
Cc: will@kernel.org \
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- Bjorn give review tags at v4, but v5 have big change, drop Bjorn's review
tag.
- Add back Marc Zyngier't review and test tags
- Add mani's ack at first patch
- Mini change for patch 2 according to mani's feedback
- Link to v5: https://lore.kernel.org/r/20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com

Changes in v5:
- Add help function of pci_bridge_enable(disable)_device
- Because big change, removed Bjorn's review tags and have not
added
Marc Zyngier't review and test tags
- Fix pci-imx6.c according to Mani's feedback
- Link to v4: https://lore.kernel.org/r/20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com

Changes in v4:
- Add Bjorn Helgaas review tag for patch1
- check 'target' value for patch2
- detail see each patches
- Link to v3: https://lore.kernel.org/r/20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com

Changes in v3:
- disable_device when error happen
- use target for of_map_id
- Check if rid already in lut table when enable deviced
- Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com

---
Frank Li (2):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

 drivers/pci/controller/dwc/pci-imx6.c | 178 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  36 ++++++-
 include/linux/pci.h                   |   2 +
 3 files changed, 214 insertions(+), 2 deletions(-)
---
base-commit: 06fb071a1aefbe4c6cc8fd41aacd0b9422361721
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


