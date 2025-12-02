Return-Path: <bpf+bounces-75908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D4C9C8AB
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF93A3AE7A0
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A82288C34;
	Tue,  2 Dec 2025 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EMTHYcYE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LgF8EdLo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660E23EA85
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698566; cv=fail; b=Tx1uvzs4FDa7wfV4DZxkRRTXmD4q2fcvzW9N9nO5W0jKIcocK+9wCRn60Kf1n1cV7bbMIWXtvKYC6DdPNMc67XmoEf44EC6R6spYBiIP+X6roUYO4SSBCfyeJJsrOyJeZ3hiTHZVJVaQlFO7IR0dAoRScR52ZdjBdMNMjMbC1ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698566; c=relaxed/simple;
	bh=1wxQLhPel5Qv59Bpe/G2EqE/I9rmbtOerb/wcKZB7Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMNckWawgKJ1hbx4eyuvqortgrzJl59Wyjm99e2F3ae++y1kPGObWz8SbbtqLftMX5d5B2i3dH97lpSuOIK+E8U4o5nEQpLnv6VVZG0d8ba9V/3/WM94yVWPKrhxpJlSomjLHjeioGPgyY/CIcnFR5uepjoy3K3u9iTVDdtkh78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EMTHYcYE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LgF8EdLo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2Hu1Za780443;
	Tue, 2 Dec 2025 18:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eRg6jjoFwl4UtbFdZ5oGH6oApklBLdKIkNIPuZ7ItiU=; b=
	EMTHYcYEzSE1stJ2KW2uTxzbb/JU7KHtwrcRrqO68zDik4XzSEXPgZEYUJc8RLNP
	zZKOENrD9q1+hKW78CiLrTyZGhSrmk+SPJlptDHQttxzgk9GJWzLa+BxWXjR9Yi0
	uE9/Go7ku15931MZZpkvrc/XtlwZdxk4FMZMll26ZX+DcWxQ6881tJZzilVFOMmq
	IjcOr0AEZVG4nxZUL4E+2tFf8SJEXPOcq9YSSq0I4gj/Hgc0R84UPdTyYF9PBE3o
	hUKm/3L8qkpDJIb5C7m6o97BdpA4BHehz7kGi5tFL9P/ULNua9P77r8ag/1ar6t9
	40p7F7fZxMeHNjfUynAhIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7f23k27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 18:02:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2GtB4F015366;
	Tue, 2 Dec 2025 18:02:41 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq99pf1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 18:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3GOm21WjOGRC9thk5YVYBK+2wBnAqsoBrCaGMUwcal6Mw4zZuKZgnpj0b4NQEaHw3bpv5BpiJQzcKnAJ9SsfDDpC+5Id5UAUirL1VjWeHF+5glhzoAuKOK8ua+1p4fY7JBB6RuA6P/7dXltXKp7XrPwIR/pzd4918tTe7QfyDL4eX9ylkVnmTN4V3v6PwmRpY6sQyz4PjxY3/qRbAKYKFRIR2n5b4svnCd89+85MXD3DT83ZtrEkDkq1kxzyHiHx1nxaGEJBuahQykvR93Z0lzHFmnumTym8wYGRydxwFFnu0qazzNp1R8dCCLsQ5tE7kbbZFOoZGG7Gxf1jT9Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRg6jjoFwl4UtbFdZ5oGH6oApklBLdKIkNIPuZ7ItiU=;
 b=FgFtUUHxMbW5gr3VJ8GmDe9uhS9Y4ZvPbltWBIXjpUM1c8YA/OrIiYOS2H1lnb9cE151ChokigqB1V5WZ9rUH6o4XpUfvsUUZgIzipfpH+HqDf4JQ647WTuvd0sNHBI25tYx9ehH64wI0i7Umnbn4Ro5ruw6UUKYczdeVX5q9ukXWMId8GIk1ApuvCabl5oZIpua8mq4Y8rJqMbIsBtbkxho2jlTZPu3aerEW7oGjkVzkm86zuuaBzE4MqjQZXmK1oCoJes4HjZbcg60iwzIFFTNVExolkKvf13hl3we1Mu271GBJ0WNWcV7XWoXmI4osIwCs3FVH/XUfuEtqXW0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRg6jjoFwl4UtbFdZ5oGH6oApklBLdKIkNIPuZ7ItiU=;
 b=LgF8EdLoXDzO9rFr9ZcngaINCZkcQ7voFwkvaQGXCzMsGzsfcLUGB6X2hO4ImjDcmQvePT9cZsZ3zI9gcYIpNk6ieWkSPyI1cI6oSPr/pJ8MYIx/Sp+KvmjIWEmEC3+fBTpv2nQrmzcP1ocOhep3fFv3QKdCLnSyf2pjqftgBo0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 18:02:36 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:02:36 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH v3 1/2] bpf: verifier improvement in 32bit shift sign extension pattern
Date: Tue,  2 Dec 2025 18:02:19 +0000
Message-Id: <20251202180220.11128-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251202180220.11128-1-cupertino.miranda@oracle.com>
References: <20251202180220.11128-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 61eb55bc-3181-43d9-a051-08de31ccf917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUFtcZJ2QFxUQV3MXRzVQWfKXCGvniEKhOIe6mY0CficremODd9NU5WlG31d?=
 =?us-ascii?Q?DzoB5CUu/F0+mHdsFHYaybOUnBYQAare8UPQbBIuERWznBxcKxKwnFaLfICB?=
 =?us-ascii?Q?54n9LD63ccQ3ilv3OO8JpWpQX2/qXmIC0sGDmjwz5JA9CN4I2HjlHsBSzjHQ?=
 =?us-ascii?Q?u57cu1K2OmmmQ/rkoosViAzVoHHlYvDy9mmlJtyUnj/88jpleuxT7YJPs8Ya?=
 =?us-ascii?Q?nZaze2WeMM5NTNwSmwK4nI8zAFYHEGinvcfVs4VWakt/UQ//OQ9loxzni1Oe?=
 =?us-ascii?Q?njGBfJUO3qIhFePIwrPdGPSaZd2tUrWHAjLydonUYMhqG12Hx8jaEOFqnJa+?=
 =?us-ascii?Q?cS3xrRUK15YSJH4wbvv9BKCFkYrFSbOjAwO9MWAQuIxfDWzPoq55zFrStuHb?=
 =?us-ascii?Q?xXxPOJj9j10lhL2X5HoeT8j/IeWsuc8j46FRqQJfzeM0SdERkL5uV6L1GDHC?=
 =?us-ascii?Q?mXwRV+UvYRg7Ua5xovz5MahnP5BkBMcQ/zafjjryAdle2Vtr7encO8dzybwB?=
 =?us-ascii?Q?WwiAr9Ci0lQ3EPWCc5l21Bv59Z4yGYNbj6eXz4lXbEJp7mR1Y7OwFBt+48J6?=
 =?us-ascii?Q?ZdUgl7heZMgJeC9eSyGIECFKjtpXlFgwg4gvQhZADSTBW8vQH+ffSXZJbeXf?=
 =?us-ascii?Q?Iz7y9T1UxFUaVbI9C/vnAkPluwfk9zvvrKZzpqSsKyKseMXZH0DNmOTPwScV?=
 =?us-ascii?Q?E7hcPXjxMYa8xKIOqUrUva53EtuEELi2iDWn+M4/83GLvuhrpgnc6D6lD0CN?=
 =?us-ascii?Q?Ot7oDVTdhi30lvrkhVmx7RLUr2vKjoX+WfQ3PFHyzTL1OZ+PvSOb6V3n0hQx?=
 =?us-ascii?Q?/hR0y831L4XzPEpW5cXfvWMbbdMjg1rLotELZyS+YpNp7h1jwyVaoJJfJ5IP?=
 =?us-ascii?Q?hVpziDc/0862hJ8PfJlxJAIDqJikissrrFa72ZOYVR/IKLXOqE/x2KCQXGo6?=
 =?us-ascii?Q?9uMW/8MvvJjznA4CKsfb0PvjxH9r1xeOksO+JeG0sCX9pydvRROsL35NnH1i?=
 =?us-ascii?Q?Ssa+hH9uHtl9kXfZ/YGcBp/VAVM3lXudFh3wTG2bZCjdWI+gRh1Sw4SNUO58?=
 =?us-ascii?Q?MCqHzehrxuLs7gyGDDBWM2ZcxLMmr4YyUaDQtlYNdvR/v2tgA7mYGa66340h?=
 =?us-ascii?Q?1DtO5uld6By/HjVqHpuU+t3nXNODR+jdhvj6Na0pfiWsity4Eqpu5FyW6K1w?=
 =?us-ascii?Q?HNcczZ1fN+spln1RaKQTu8TyuTVJbxqxlfRmPuMzsJMxglnCn493iq7S4ypZ?=
 =?us-ascii?Q?MYp1UZGkDQJfzuviLrqfrQdD93tfGC0oChEHtLe1cQ7fjAar1YfV/VRnyfrc?=
 =?us-ascii?Q?pbpOMHWVYiKz6CQ0kRFOvS202xH9YWewpGWdk93109StlK3EwpnS6rj3Vjvl?=
 =?us-ascii?Q?niXO3Xb5ZzNHyPo5nWXMeZ7yKW29vNemLKbWz0VWE3tAFdH4+jICr20Yo2oe?=
 =?us-ascii?Q?mLnezhPVGwc99KkKZQJQnvMQaHTbtq6P+3MLGyzEjUwS1szl4xyTsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tF0sxzdd+/Io73RrpNAj+zBBe4jILFmLOdP2YIq5PYvCNZzyd84PaU5TwDGC?=
 =?us-ascii?Q?UupSCoPhLt3XNMRQrXRj4+seYTLlQpwTEsIUmE7sDGnxJn4zcwXp5+4VoPzg?=
 =?us-ascii?Q?gQaU6qt4pVoP9FkoKswQz22ZJNjKumtWL8i+LD1CQ2ZeHv27n9KtZVo334nd?=
 =?us-ascii?Q?jcjSumXEONhmrnpZ2/IP6/IS9HIAicbYEZ7/5uDg+EgkHDPUV0UPNmuAQEWl?=
 =?us-ascii?Q?T+qkcGdwoDqRsSDINAIGJyRw8YHQW9uBxeB1SfBP3sghK6hqgHlskWDx2Tde?=
 =?us-ascii?Q?xlkrWLTqayjTtoeDfsNs/sb02MPaYAfpDdmfNrnjES3OKTSpe/jMZIJWLPrj?=
 =?us-ascii?Q?SymjbVUXtR+Q9cIsbumuuGWnkDzIG/q+M3PDqkG8nYXvygCZFz1gXCB8rEp4?=
 =?us-ascii?Q?XxecEyQlJ7zlh/mgCzkAH7PG2yJ4FgMxJwJToT4cxexejg+q35P66C4V8JSk?=
 =?us-ascii?Q?RvBbdCPWAYAmFPrUi5+2lrq4vFvzC/cz/E02tHINEYssqbfoA9dJ8uCCfusE?=
 =?us-ascii?Q?fKCFGVrr2Q1AHJ7vbY2qoSP1Paf6ehAe54ddwBRlAYrLY2MtFCDflvDJ9gKL?=
 =?us-ascii?Q?icK33euVYZpJxM4yzBFjgxhecz6tY2/zwLTx7f6cv34tvIXNf2PnUxBO2jgI?=
 =?us-ascii?Q?C97X+1O1pxXKxrONRGl++8Ma8Cj7djO9JayHyk2U3MiFfIB47TKmlTTxYevn?=
 =?us-ascii?Q?6Q6r/6K0nkrmeO3LP5Dh10yo6/nrAh7RdTVrlzZ4NMpSmduywuXYin0c3PzT?=
 =?us-ascii?Q?PA5EvFaK9wndr1zoIM5mFF/IUSCKBfOBnItLEInhcv5Z3Up7kzyjmF7JIfV/?=
 =?us-ascii?Q?SS+EODis/VOs/BPzxGRc8X0xex/rIjyiABvDTG3v71M/NKSgjRepOPu2QHpq?=
 =?us-ascii?Q?i0/Pqp8ko75aFChEkMiFKtjdA3GuxVDMTG5P6QtRgJZIlp8/cN2bqkvdI5pf?=
 =?us-ascii?Q?d/574+lFWg64/vBv1ZVPXrxsKZ3wlpumiVdlNZVGXbOZ9pu/L//UKnrLeFWv?=
 =?us-ascii?Q?0+GROKfB5V9kPenL/5hh8O0y4KA/AtTZt4ka7NwW74jjOncmsJD6bIKrI8hw?=
 =?us-ascii?Q?6CF844j9pkNFeaDdTll7LQTbaoxwStfM6eQnepJkR9WGPatk1tb5hAb/L6ss?=
 =?us-ascii?Q?U5RAHWuEsvAJS6V5lzOp5QLjF6XNdvhWqlTCwKfwV+aubKE9hCRYH6xtNVEP?=
 =?us-ascii?Q?ga4NpfLBHLlkDDPSUBcCp4aXI4IncODRUqK+pgLzStxgmBGfDVIk2eAKVf2N?=
 =?us-ascii?Q?tZvJoqAhLBP0ooYFpYbA32gHCGaSztbBtu1e4yJA3dG6biZY0Knwp84/q2IA?=
 =?us-ascii?Q?lgxHcLcti3dS9594evTQHZTRfaT/netR93NSAsmhtvKazZAVRWR8jw+O6tec?=
 =?us-ascii?Q?iGKTj0K7IN1rrn5Zbg7Aoacky39e5bPOymgP0Kz3k9JvcVvzCduWLkaM5w4o?=
 =?us-ascii?Q?Q818PpFz0Hu32TWmNR9m0sbqMDZosczprIzaTAW1oKz61yhx1F3N5pW9B2Sr?=
 =?us-ascii?Q?ai5LpFd8njDPfbSpR/5sIz52Zdl7qxpHksec0q/h3F4Y9o5Y6vJZBf84z+Lq?=
 =?us-ascii?Q?EFcFdAOsMrMnJAoMnYDmzme3cshxATsPhyJaxB9DGkBt+AHaCHrVABk8E0aR?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g69TOZIG1CFUxc3MwJbxmQqsiUUAh7U7taUCZtDu5OQ/duIpyQIZebIUtPBWrReXUOW6uDP75HCZlfVyN9qKxqFH0vcRvpu7c8Nbc7LPqxMT4XCuptRLIFPN/vZufT94srS3cBZLZHUfFmCXoG3NrK5z6u1xnBWrldli2qHb7+dCvRG7pKVDa0DgYJitlvU8Q/IenA/VvFazkS1DoqXdZZ9uUG5rhHqTt1o04PSnR5fXS09yc9Ld3BqwX+CWHwcl7RZDiYG+YM9pSwTJPzdNqtTig4NJMHjPjKOdDnslv53wrtW2dt/sJmSbKijT4294Xt9Ejr67gD4Tr+n78jtVsHktzIRVdzfpdSwe0YbJJSrwEuWx41N9Q3LRhlVNlo88FqshybGIVZ8nHhtdyaLzQiqMIF5/8hviqmsPpMDxlc9fdSrHfXQ6GKsdfG4Z6Dg8chewi/hd5xrcI9brwE90Zfg/hLn5aGU8jRMuPP0BqHmPVrJHmKpfsB3xtMLMqz6MXbH/NdZWzs9NuiFrpQNMrfxbHgieAIiv/rJd65jv2nEHaEHa/GpvSSP+rDV3BLWSBgGA91PZuzp1KfQJ0wLwUCJbCTA0bXBazF5EkSIKPM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61eb55bc-3181-43d9-a051-08de31ccf917
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 18:02:36.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1Tv7WkSZgRG5hiTtVnRj571sJ/ELYVfanzJ2Jr9CgsmbTaee1LQGRVzx14JnYvMH7xvpp/ckWg+icZL5uJhGSbAJ7/B5zsGtkzF9eBRVlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020143
X-Authority-Analysis: v=2.4 cv=QMplhwLL c=1 sm=1 tr=0 ts=692f29c2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=yPCof4ZbAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=zLsXoKLw0gD4jKH3iaAA:9
X-Proofpoint-ORIG-GUID: n0lAnJ1fgaR9DfrPvaNsqp7uYfGmvJI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE0MyBTYWx0ZWRfX4VpEWzQcg0Zf
 ZX4yaml9gH8QLiDvxHSs5PuZigQlXRKVqfF3pG5jNNhxUIuAXJ7WcYNsp/FR57zwdyO0tOpCTN2
 lXNKrl+oCEHCxxyNMyxwLFe+qi8GKoZyDSOy2HDSqkQMbIvhsUhR/Zzd4XUQC++Ub+CK44uAX75
 mhR+Rk7XdNEtnsAGnzHt3eMv1LrLm2BEn0zfigZNZKdB7W3vB8Rb7i8yzyE0GWc3kHEsugQV9Wy
 IoAgHTMt+OZY4pGVVbD/fjmwfizD17Ojr7kU6IhRFOywY068zensafVfhugSr33I0mH+Q81DE43
 YDtLsi6tMrfxmtLfOmuwfGnPAzQ1CTNDvklelskcslXGkHeEAeAUEwDQUw0Ys6i2vwiOJ6iY9/7
 ZfyUEgxr23CT/rD0q3fVGoMQ2wEKIQ==
X-Proofpoint-GUID: n0lAnJ1fgaR9DfrPvaNsqp7uYfGmvJI5

This patch improves the verifier to correctly compute bounds for
sign extension compiler pattern composed of left shift by 32bits
followed by a sign right shift by 32bits.  Pattern in the verifier was
limitted to positive value bounds and would reset bound computation for
negative values.  New code allows both positive and negative values for
sign extension without compromising bound computation and verifier to
pass.

This change is required by GCC which generate such pattern, and was
detected in the context of systemd, as described in the following GCC
bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119731

Three new tests were added in verifier_subreg.c.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..a1be9d92adca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15272,21 +15272,17 @@ static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
 				   u64 umin_val, u64 umax_val)
 {
 	/* Special case <<32 because it is a common compiler pattern to sign
-	 * extend subreg by doing <<32 s>>32. In this case if 32bit bounds are
-	 * positive we know this shift will also be positive so we can track
-	 * bounds correctly. Otherwise we lose all sign bit information except
-	 * what we can pick up from var_off. Perhaps we can generalize this
-	 * later to shifts of any length.
+	 * extend subreg by doing <<32 s>>32. smin/smax assignments are correct
+	 * because s32 bounds don't flip sign when shifting to the left by
+	 * 32bits.
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
-- 
2.39.5


