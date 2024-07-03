Return-Path: <bpf+bounces-33739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D9925727
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818FA289C9D
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A11411F9;
	Wed,  3 Jul 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="M6B99bEd"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445A14039E;
	Wed,  3 Jul 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999851; cv=fail; b=XTa2hGNs7sGPFsO5ZVEta3fZqQCm8izYyFD2180/oMbaaWmMev3dFXJBTDnIRJqqBxZHZDd67bMRQDasdfbmKp1W/vYaW8EMoFXVPSZPjlsemXhzdz4aRF7EiyCLzSS/MDCh/yFjIJr4gbzyJpEFcawGQx1e1JR3TVxjbUl85M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999851; c=relaxed/simple;
	bh=pZbQAGD7wLer/zup2ecwVmpTxKFUawE/GbKCLXBtoHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=qvEHhNAKP/qCOKLhOSCS4HqVd13lI1BGCQXrPGsjEEKQRBjsNKX/xgL8hr3j2rk9JBoF5tc0BpP76t2Xl4u0HsXJ9lxX5dkglibSxdgYPipd77v6V3MKhE1KwD6kkqqhTvFOxc3uawrrusa7HrqvAJDeEBJO+6GPdbgE6aVEsQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=M6B99bEd; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAmKuVD1kFlDT0H/MpMhQ116z7XxIAV9wrSmQLpioNvuteWcjuJzObuXDPuhjhAgyUzPIW00a6agzjxw2Ax2XNrQguf1BzW/FANT/Kpq5sxq+QK/as7zM0N1Ngbb9T+ljVAcGph1lAVlLcCId3/kbL0mzg8tWLQHXRXO9Gwsl0aFnQLwoOOFdD5JL+LvkIbIOUTcJtTMH0hA6lJVRBm6D/nroHGo4Ww+ce2eVx5TUZ5LX6WaHGJf0ItUPtA316lE+bXovSRw+WdXplH7CMf9BN9A+M16uwGWlMdLTRvtbUcGOdgYZ65q/VX6TUwV2BeByOGVjwaVphhNlAuWEFQNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGVU/UXPWVK7b1+WjkvLFWuGaV3CizgHE1IU3SWRsvk=;
 b=m8FUjqhU2GoJdcRh8BB+AxpBsbDvvgFoScaH3F/0lyeEG6gf+kXhQkkThO2KAsGVxsnQbMWxSbs5xsECH+S1JFWn0dia25iNIn3bJpH/tVerhDfkK0Qfg4Tbfv+Or85hkToQBAkSk+v8EjwzWR59H0qqZU+6FLHu/OifvwfANt0a3nniBihquiy6c2pqgGVKDpbEXzyhsmNGYl6zi6k02ClEIf37mtBBXyJziesvgc9xlv3lGEdZocXVwQ3gTrBbiDdqQit7VTObgVv9SNht84Xxiz/UfThXKSL3kmWcEyZzKT+8p8xJV+NR3o7ho8RkTa5rGGPv9Fd5awlTJv9uqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGVU/UXPWVK7b1+WjkvLFWuGaV3CizgHE1IU3SWRsvk=;
 b=M6B99bEdDYjssWxAF2rSFVCXfF7zrHfFGWGdM05CHWYozuR2jgJhPLwfLHFn5rz1fzOFrr2XZu4cs90sgrGVaH6uQwIrJ4tbouQQLMQj3LW9ldzgAqYXvxIbHQz8SEVURI7M2Q1oUPq04JJ9ir6qAYaiGUTXFYMGdfKWa6B4S7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB6075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 09:44:01 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 09:44:01 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
 andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
 renauld@google.com, revest@chromium.org, song@kernel.org, Kui-Feng Lee
 <sinquersw@gmail.com>, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v13 2/5] security: Count the LSMs enabled at compile time
References: <20240629084331.3807368-1-kpsingh@kernel.org>
	<20240629084331.3807368-3-kpsingh@kernel.org>
Date: Wed, 03 Jul 2024 11:44:00 +0200
In-Reply-To: <20240629084331.3807368-3-kpsingh@kernel.org> (KP Singh's message
	of "Sat, 29 Jun 2024 10:43:28 +0200")
Message-ID: <87zfqyq07z.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e419cc-af12-476b-2c98-08dc9b44ab0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6eV+2Nj9AiYmNT+MTqxA5sJsPFRj86VAvBB0eDbLpi6tJrizE7uRlCLmZgkR?=
 =?us-ascii?Q?f/6xKjepp7GIrr97hbWi6xsAbwaRykLJfEL2Lihisqp8bQvSPEMVc62DtiYI?=
 =?us-ascii?Q?fKVWmiwe7Z15syE4PQDC7e879bNKSSGjjCL8AFEUgTY8AqAVoygZAoWA2XJ8?=
 =?us-ascii?Q?JAGozlwwu5ov6rBrmwDuyJHP9GDknJN8emUSlvP401EcOWa5CH2gFX+akv3o?=
 =?us-ascii?Q?798nVlKfv683/qiMb943ayE48VORYvvtcdb4rxsLhV4PgtBZYpEVtuWjDIlA?=
 =?us-ascii?Q?VXt5TxSdGRV9i6xkZZpiH3tr2CfyX4uV+3fglWw/aWzUqWYPymaH0UbduG5P?=
 =?us-ascii?Q?nyPR8Y1dLkrcAmLavO9w3nQ/TnxFleFa3C5Mzw+/EQK0G2EqgYXOsglCJamX?=
 =?us-ascii?Q?WGJLaIjCkO3j5ojmurvyrvFqG6Fl+WQlU4si23zBZZkv/LFk3j3DG3ituS9m?=
 =?us-ascii?Q?u68R+gOGGdfdroPj9tB8U+PLnAJNtADb1K6HSfp7Si3D6NULIgZj6JdBFUuN?=
 =?us-ascii?Q?Owuj2KG34eJfoOYwHrsJg+Ib9SxUQBZCMTR4PmuWciO0Ci2SdYA47c7n+ryx?=
 =?us-ascii?Q?O4lwJyS+/mQxndQoQ6hkbvQnEBNIRNnHB2MMfuxkRC31i29RkMcUkUCKwK5L?=
 =?us-ascii?Q?rGEu6TPwHy5wZozoafyEUhPsSSD28fO/qGfgSSvSAeuq4OnsbUuvj11/fr0U?=
 =?us-ascii?Q?m9eNzLw9mfNLtn8tsJQlJL0JWTCA2EZDUMM8hgy80PzJqnMv63EUQ01HdNMy?=
 =?us-ascii?Q?3X99z50AVHszNNehy8ErVxjKTDq5pxAgD6E7EeAE5m/UPhjVsXFknSGJTRLL?=
 =?us-ascii?Q?s3IIJ9rGq4aAfxYTmVMrGWfv8s9lqj05IpH3hb7oZotCtpMR/+nBNEHuknAh?=
 =?us-ascii?Q?LdEOXSgbcSeftjJDEN1I2/ZyS3P5jZpOYk/rIA7YUdfXdm7QJKI41aC1pzBg?=
 =?us-ascii?Q?z99S0ll0+1ZsJ+JE+Hz9VmwLrBxjQuMuuBy0gdqo8T+fCw9ZpU5WyRCcUJiG?=
 =?us-ascii?Q?7J253C4l+wd5RutIDuBxQHRTQVbXdDtuNsp/vI/bRi3HT0+8DUBnJPx4LEgF?=
 =?us-ascii?Q?m4nQco1Kro50jqmV64glhET5Id2GY6UMbx2IAjZCuWmEEha1tWoKI3xSM44d?=
 =?us-ascii?Q?7S1AhrylWs9o6etU74oefbMfMmrbl7sztIlIccz67AqZSoCNrUK6beiyO6bU?=
 =?us-ascii?Q?UsQrGnefPkMnJGnbq8iazj3RfQ3Z7smxJsNHWLz7mz5gIA64LJ7GO+OfaPwF?=
 =?us-ascii?Q?cOKUOtd72LBqoxCOAA0kxykY1CuIc/A8bVsesMrX4xHluheXpTekzK+YXa9t?=
 =?us-ascii?Q?gt+9TJMHDB120Mio2yErjdDQoLXWbFJL3HWuITRWXcVeGj0O2+v74xrASm+z?=
 =?us-ascii?Q?edekZrDWeYSAYrEwyC35ID2DJ5C56omK5tsTlUXheyCXDkEVEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQz1C8GPrjJtdJRcuMIQvLbrmqqGJyDn2guct7bcZZAA/Lp/vIkqtxAsowP0?=
 =?us-ascii?Q?IIvcSR1PbH6mZ/dDyKaCyNSCuppvYPWNOWw+UXimxOz3hbQzaiGRUuzorIgZ?=
 =?us-ascii?Q?86Qt4wNkvp2nX62mK5T7wg8emOjpFsBg9gus82kl1LTtPVSYvb/sV1iIt6mb?=
 =?us-ascii?Q?Xuj2V+ntz5bcDcynpF10YYP3a6K7K7edcpqKa6LseWUid8XtxPhEMQEfrHfU?=
 =?us-ascii?Q?Ak9JoNXSuIJnju7EFhrZ+Swc5XZ+rrzxM81inDn28GTus/+YlrP8W0hdw2tx?=
 =?us-ascii?Q?LvbLbAOKZI3RpYFAFP8r0Pw9hE72TraFufTHrow6Io+6nNR5LzDFebJE8iYV?=
 =?us-ascii?Q?22QI215smdlVYe7DtMrd92cp/cnvZ5mijVMW2fv6EQPcVKzRdEPakG+KF/qE?=
 =?us-ascii?Q?S5o5gqEzR1GhBRad/CNYANAGiOK7VC/EKJlUQc+d6etufg3hoCChoJD6DLE5?=
 =?us-ascii?Q?vCVdigXYUBd4ZgpDmn8OxHBQC0guiNtCRfFNt1+e29rlvFxl1TFuCKUE/WvD?=
 =?us-ascii?Q?NkcfH8bysY1vsFwh7UWSm5C0q7BW9FWmbKXOfEnaxSZaxK2QIwquqE8T1qJ5?=
 =?us-ascii?Q?EkQ1owTjHikTTp753JvVqEhDIQ5wZj3BRJROHaEUqdQV6wHK6X8O+KYMM11h?=
 =?us-ascii?Q?84PgUpgOjdXIQYOd8DxeSBDMIVruzgcA+han2HMFTO1u2AzyaVLIeNIfYer+?=
 =?us-ascii?Q?Daeyj/tO98EJUZ423ITdy/KxTWPQc+yZhXSt2WL1/90rvsuXoPhCF8Wua567?=
 =?us-ascii?Q?XapY4KlRIzfRQT1Gx2B+DVbGkD7PRoynA1mrZ7WioQnSSL+oUuZAEMp5ucci?=
 =?us-ascii?Q?h44lrUP9AoQRqqXGu6nopTK2J+vjVYbiIRB3nGtx9VFlC7wMWPhEGGPxUL/1?=
 =?us-ascii?Q?bdCBhZG7ll37G1mw0Zj/ZwLfvM1XiHcxLJjs1c9CVAP8BlptAkX2YzwqlsK7?=
 =?us-ascii?Q?2FKSoyW+TfQaqHR8INfqFpD8coiycrGy0E6/iPziguk1rx6tnjZVleG0CnrT?=
 =?us-ascii?Q?4VZAuKQUpQsYDkSPWcUriJMDP+LTXx7ft24sA5YMlh2F47UuBe2JNC07PJMW?=
 =?us-ascii?Q?RlilNr4/JuUjatPxRjsi0iAM4SepDV/eh3ikrb5ktxw+4OKRTl6LILcN0Pt+?=
 =?us-ascii?Q?lnKC5at8jcqR/HIFXOVAu81V23U9Vp8pt0Kaik7ekQpkS4HFOPlrzGg3Fr2E?=
 =?us-ascii?Q?sHLzZe3r8p3XB3q7hWbvl/MwvHh+b+V2MSaDK6g3x6n8c+TlLtqUcyXyNtAd?=
 =?us-ascii?Q?ptNs8PgbO9HqqqDUy9Z/B1rsZTA5XPSrPvjMjiZ2tP2T0NhpFg3MvaCI0iSP?=
 =?us-ascii?Q?W2geNlmPi/YY+F3XYmMswwlQi3MWhf7Nst961ocWmxHUOfTHL4nK/LELpvSl?=
 =?us-ascii?Q?LBqWfcMfKkaF9BAPqIn/flrgmK4uhwrpVY76FLKW/ujC4XXggqOtNU5NWDU+?=
 =?us-ascii?Q?3CSZtoaRyVLRzVl6hPKbmX1oBT9yniTWhpvaCnn3lTbPU/QV1SEJ6CWrB4xj?=
 =?us-ascii?Q?K2EZ5VoASYPoFbMTVAWToZMy47nvuvWKtvgxyAdfKu7jDHv6ENshPFFJ+Obd?=
 =?us-ascii?Q?ieKUPe4eJEIxz2HkLJvbaU4RYcE5BUCvf+OZbjUAqqIZlazmXyyrjUUhi98y?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e419cc-af12-476b-2c98-08dc9b44ab0f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:44:01.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsyQ26q39V/ZXnZGKcKr3JgGQRQE/AYh+jyFXFgzmieBh+UxsjUCBId1DQUaP/0d3YNqH7We301Yxz0YgdKXaCc56J4CWrETLlm0qBkoHDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6075

KP Singh <kpsingh@kernel.org> writes:

> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
>
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.

[snip]

> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..73c7cc81349b
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2023 Google LLC.
> + */
> +
> +#ifndef __LINUX_LSM_COUNT_H
> +#define __LINUX_LSM_COUNT_H
> +
> +#include <linux/args.h>
> +
> +#ifdef CONFIG_SECURITY
> +
> +/*
> + * Macros to count the number of LSMs enabled in the kernel at compile time.
> + */
> +
> +/*
> + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> + */
> +#if IS_ENABLED(CONFIG_SECURITY)
> +#define CAPABILITIES_ENABLED 1,
> +#else
> +#define CAPABILITIES_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
> +#define SELINUX_ENABLED 1,
> +#else
> +#define SELINUX_ENABLED
> +#endif
> +
[snip]
> +
> +#if IS_ENABLED(CONFIG_EVM)
> +#define EVM_ENABLED 1,
> +#else
> +#define EVM_ENABLED
> +#endif
> +
> +/*
> + *  There is a trailing comma that we need to be accounted for. This is done by
> + *  using a skipped argument in __COUNT_LSMS
> + */
> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)
> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
> +
> +#define MAX_LSM_COUNT			\
> +	COUNT_LSMS(			\
> +		CAPABILITIES_ENABLED	\
> +		SELINUX_ENABLED		\
> +		SMACK_ENABLED		\
> +		APPARMOR_ENABLED	\
> +		TOMOYO_ENABLED		\
> +		YAMA_ENABLED		\
> +		LOADPIN_ENABLED		\
> +		LOCKDOWN_ENABLED	\
> +		SAFESETID_ENABLED	\
> +		BPF_LSM_ENABLED		\
> +		LANDLOCK_ENABLED	\
> +		IMA_ENABLED		\
> +		EVM_ENABLED)
> +
> +#else
> +
> +#define MAX_LSM_COUNT 0
> +
> +#endif /* CONFIG_SECURITY */
> +
> +#endif  /* __LINUX_LSM_COUNT_H */

OK, so I can tell from the other patches that this isn't just about
getting MAX_LSM_COUNT to be a compile-time constant, it really has to be
a single preprocessor token representing the right decimal value. That
information could have been in some comment or the commit log. So

#define MAX_LSM_COUNT (IS_ENABLED(CONFIG_SECURITY) + IS_ENABLED(CONFIG_SECURITY_SELINUX) + ...)

doesn't work immediately. But this does provide not just a compile-time
constant, but a preprocessor constant, so:

Instead of all this trickery with defining temporary, never used again,
macros expanding to something with trailing comma or not, what about
this simpler (at least in terms of LOC, but IMO also readability)
approach:

/*
 * The sum of the IS_ENABLED() values provides the right value, but we
 * need MAX_LSM_COUNT to be a single preprocessor token representing
 * that value, because it will be passed to the UNROLL macro which
 * does token concatenation.
 */

#define __MAX_LSM_COUNT (\
  IS_ENABLED(CONFIG_SECURITY) /* capabilities */ + \
  IS_ENABLED(CONFIG_SECURITY_SELINUX) + \
  ... \
  IS_ENABLED(CONFIG_EVM) \
  )
#if   __MAX_LSM_COUNT == 0
#define MAX_LSM_COUNT 0
#elif __MAX_LSM_COUNT == 1
#define MAX_LSM_COUNT 1
#elif
...
#elif __MAX_LSM_COUNT == 15
#define MAX_LSM_COUNT 15
#else
#error "Too many LSMs, add an #elif case"
#endif

Rasmus

