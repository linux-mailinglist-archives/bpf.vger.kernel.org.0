Return-Path: <bpf+bounces-49469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169FA190D2
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF74F7A1585
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B2211A38;
	Wed, 22 Jan 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VEOae+TW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uu03Q83c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B7211A33
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546288; cv=fail; b=jL9PoqGWWfoTnJJtN4BmoCGmT1fMyo4YNcBJCoZOYxXDot44HyjzTT9M0IVQ4gz2zSGnWr9YwiGSIZZ5mY3wBE9pFhbwua4+QYDDxsCVNt8ddy8OyJILpzjBuVm30yx/rPViKaZzU3vlcfImTS+Uxjsyk2gpLhNM4Jet5mg34rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546288; c=relaxed/simple;
	bh=v6DcdeXc1lsgkfVuNFosCJVDu/yO5J4cHsmUU8ofQU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=VOlEAg/F8cdA5TuH28ap3tDXmLNE+EuacQot7R8B2GknauY/RPX2Ceh0pUtu6Zc1DVkNF57mGoGVtyPB90pyKqbRvUpNojXQKS+lKLBAVyGkMF5xIcGeR/bcFAHon4URxZIXatRtsiLymhkjpt2Pl2T+ivufe9HAS+TsI2Lq2IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VEOae+TW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uu03Q83c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1NGT4013970;
	Wed, 22 Jan 2025 11:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=K+mrlAYVG/Uux3Ahay
	e7ItdB8prNuypY8x74B/zfmTg=; b=VEOae+TWr/ig6T7ZDmaQcqYOL8cxhQQ5/6
	WJCMaGYxOjzhnahPC9ySbnbXn6ocjMpCzVi8zHSPN2LYRKhLjrbEYgo5JzLpTZaq
	WcW7YCfEWv6WET8gchqJYEIdvo275uN3Ci+sZNzAUgRXZ6PC1Wby20y3lT4ViQLR
	5wn8ZVqq+aGtx7h8HW2zzE2nCNKh/xwcGo0VfRGup6z45CS7Ay8fgL4b+v2LD6s/
	rAV79P/yx/TdPDT0RIJK47kYnBCA4dkhtXO/RLhfvAHQGzVwvjBposT8jS8Hd9hA
	J+7FjjNol5syumg0Jv8A8T37cEmm1NMrDYfOKFfPF9sqr+uaA7yg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsfdq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 11:44:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MBPhBH004838;
	Wed, 22 Jan 2025 11:44:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449195h3cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 11:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRbxM0uAZIpX7OCV+qmVGWTFJeq5b7j69S8LD+8/eGbNG1qGfcY+yNnCaRSd3biGmJ/bB+w5YMxmcT0QCNW5d7BLXONvIW9O3rnlMHUHcsOebBaAzVXB+G/Sf6NT3F29hHJafB5Swb+FhyNOOjrwH21Gz4xG13KhzJROUMtNZo8GAhj7pewMGPPQhedJ0Nr/XR/nOazP0jqNiP3x7pF6rKuOznPKeE0E4hvg3dd0m84T+Z4gLdgdKzqazuBUm5BvwfHu+n1mAEALzcF9YUoXF9buTf1KpQTGMtbj4OOWtANWCJRiPCHmEJc/aUJW3MuP23LLt1yr4Zy/bCLcdpHylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+mrlAYVG/Uux3Ahaye7ItdB8prNuypY8x74B/zfmTg=;
 b=u23s4UsZn3Kam5BjyavjPONWKXKNhL4RmQpv71tjEMsK+urSJrD7yXvASj2gRdct7yNE8cYmMK40ZAldWYWbkqQI4UmarVyg7hqon2+cMRwLO8y47hr71O7luTFzxfJTz01yjby27n2WQh4rZtgWP+bezdNbSqVhXL9/hvZV9y7f41z6ozGgceh1bmZG6YAqpSU9P59VBZ0TU6fIdQ7m58mBjuUGcrCEIh4jGfNA0sqAGUieV3T4SioALwQzV9Lyl73Pr9yUhr6noBtLjn/S2yJqbzuQtgb0OC5HUwirq9+2khelfuwOSazMvNxe6t5kOGyFsoHeOK8hRE7WsNhSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+mrlAYVG/Uux3Ahaye7ItdB8prNuypY8x74B/zfmTg=;
 b=uu03Q83cZMooYwuwUwA1GAoXsktEuJziUxH1+bo88VI9dvOPU+mOB7028GnutOF7foZ0ltWPAGMO91i92/Phr7919aDZBEnIrWsHeB/5RaHwtyCSY3ljo05byM+jFCYU72l/I1LlQuMsTHNZvzEw63vtgatcw+YuVcR1q/uDYo0=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by SN7PR10MB7075.namprd10.prod.outlook.com (2603:10b6:806:34f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 11:44:23 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 11:44:23 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
In-Reply-To: <20250122025308.2717553-1-ihor.solodrai@pm.me> (Ihor Solodrai's
	message of "Wed, 22 Jan 2025 02:53:11 +0000")
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 22 Jan 2025 12:44:20 +0100
Message-ID: <87msfjhy3v.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|SN7PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 71376787-6d37-4f35-072b-08dd3ada1dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8opg0NHqGFd/vywiESKxviO4O5SrUfsuOAUZYZWRH6bW7e51hYb4twkUerc?=
 =?us-ascii?Q?xABzaNsuVjtDAU6A6RLgR9UyGEIT8v2kFLPCERU6mfV+vloMInRWVQHrbTDY?=
 =?us-ascii?Q?AZ2NyQEblf/HVEfbxj/FqPQeOnREQgxLa8vbgPvo6zWoLZRx/PpxRiLBqd85?=
 =?us-ascii?Q?ZDyZB9L+T8wuDf4kC8aArfb4h+lKoVlI9TFNgI5RXoX7zCv2fDYRO+LVrqs7?=
 =?us-ascii?Q?VIcNZUmLT9bfOYyOtUONRCbm/hUMAi/pkzcvqeYlV4F+VRONG4Qvw7h9G/nc?=
 =?us-ascii?Q?NY7khlMloD1cDkJv8xgMAMPaI5N05PTibarD6Ck6Hq7kPxfmCsc3VsI5kCud?=
 =?us-ascii?Q?1sTRJZuktW5QMRfQHCqG02WimC+kIYEhHFqIxR08wglUZ2/TqrfjF68axPEY?=
 =?us-ascii?Q?EOxbcAgHuhtWzKIjgKpsl7pyjhgtb5Wknb8F/+T0SS5tKK+CQIz7xw/Zdk5I?=
 =?us-ascii?Q?xVXG7iP8s6K2LGRXhlze71DJRN6biqeFGcnUmkW/59x/x+BxHpZ4mgkArHcV?=
 =?us-ascii?Q?Na7eti5byAq6vYKvUZAdPHw/0b/bbfnM0fIhSMSXWqc4r+q9ULolJTeKc7Wr?=
 =?us-ascii?Q?tLRpLsym/sCkPJQX7VJxMBygOlYk7wlJT9k1631tCi0SYDchaZ+jUt0qJ0r+?=
 =?us-ascii?Q?Jucy4RWOgrC91EBWE9V+gOPqHSqpr1OrRo9bLATZO0OIR4aXg3KnNpMW9Wv2?=
 =?us-ascii?Q?xV7vwGbi3I1rovjjYqaC9xRWR8unjVVS7jSfGpiR5EOUcVq5aPnGCpHr4OJs?=
 =?us-ascii?Q?a1kWsBkak/qJTg8nIQeMW8Q1McGfwtGh0f2neHh7d4LpgZcNOc30Xu28FNpo?=
 =?us-ascii?Q?BapSd3mlAKRQC0yx8MmSVq1Ihk6dVyKp5QkHmfg/78LyuBjOmgJ2HekIAQLl?=
 =?us-ascii?Q?KyaDygrtky5A6iSthTTjm3jdLmIPIjNAQPcPRGsHy6s9ecrM73E5sZg4nrTy?=
 =?us-ascii?Q?1Teuv+Q+VmKF8min9wJcTS58vTTL5ZA5xNoULaenBv49SxRcWF5tnFOAuGAy?=
 =?us-ascii?Q?0YM3Ag3bseUDGgvQfFPDIAtyWVcCN9GJdbCLygz5HSxXDoNusJToIweOptsY?=
 =?us-ascii?Q?3k9XB1biq1nUM0b0feiBHZA1OYaXVOAiNucxl0CTKZGgfpvmgb8dBzPBlMZQ?=
 =?us-ascii?Q?MQNefJqK4PVU9CeSoXwYqhplFc/+rl4rR7zXHQiD0l4A/vCGOkqIJB+N9eQ0?=
 =?us-ascii?Q?LeRDzd+x0Qvai9yPivH+zhWVZAtbvEOFX+a8yeMmVhNcaHCuFtbSy9sS5+28?=
 =?us-ascii?Q?GSC7ARYcZJCSLj4zlRf91xXF64BBR2+l63mQduLmG/YH1wplHDL1H6Tl2asU?=
 =?us-ascii?Q?eHxlFj+/XX1315gzTK+FayeagF+v8NZQ/qCahxMmBOXCbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0sDOELyo7WfEFlmXntram2s5z7puxVg5iDRgjn3HvRN1HI+irUOHQT46om/3?=
 =?us-ascii?Q?i2Dg03kX7Cky54tByNPvyVOAmdnRs7/mVwfROtTVcqLRVPgE9uIUVfDjVjvh?=
 =?us-ascii?Q?MkrnDJsxou9LTfwlrFBAiEhWdx6oQoduMgN5UVSR8W6irrIjMiILzxoPU1Au?=
 =?us-ascii?Q?XBhuedMn8C0CoQvp8rAvuecyX5tQ0yikzcZFP3nSs8GuPh1LX67m2C8ThzRo?=
 =?us-ascii?Q?ZK/utN3qsBAxnRg+U/tx+oqPmwg9l+ANaXC0QoyZ7D58inrVbj5rkxt5i45i?=
 =?us-ascii?Q?iJeOKxsvZY/rA3g0+GgVHi4i5+ZdKA1lvOzUae9qGaZpQ0/gycAql4zu9X58?=
 =?us-ascii?Q?oDdsh9klBW43ffGN4IVr4jLzc/FV+q+GyUNx2GVBocbUJF8jI9OUNZL38Z1Z?=
 =?us-ascii?Q?gcaBJd00jO/9FaC7hQBoQi6F//nPMYSti6UDC9KYMtS1d1Tp2KQD/D5EM772?=
 =?us-ascii?Q?qJF/oHddCf/CCG/gxP2DgZ0ktXESxuqSXtaEmG7epycZlQR5RoS1RJvy4geX?=
 =?us-ascii?Q?vxolFoN6kEe3CmPrTEKqtLSnrtd7pNpQGAderA5SIVRG9vbKBSeJJgMtGfB1?=
 =?us-ascii?Q?BK7KXlImM8nGfV28M1Iq62lI75vF/iy/t2j4W1gr2c0CV/FuT3RFvp5/Zs87?=
 =?us-ascii?Q?tVdiVKL55vndaPSnQ7FbWnU2wWihz255aJBDIk+IfYrxt6tc29FA7ylZA0Qt?=
 =?us-ascii?Q?dwh/IzQaQpC81C9wsmdQL9MSxvwV+W8F3YLfaFtzc1XNCpbQvo2Rtuv6+bZ6?=
 =?us-ascii?Q?U1A4tU4QylsU+NPlcfuJ6kv+TJ1HhLayHps1u4aqMPeJggG5Jf2Sy28RfaK3?=
 =?us-ascii?Q?NRQO7+5+jTrA2LJXFvMFmFUjJEMqyN2puYNUh1Ob7adBsZAsfIgXGCuSMGcF?=
 =?us-ascii?Q?qr52Af0inDHRF4icPskgpUSRaSSsyXMnvBLWO348ki0OFDKmBaPbiDEDtE5G?=
 =?us-ascii?Q?BKI6Ab2yDK2n2FhzRhMoWRMp/KLx3kr5o7xK35mPdTWUWz6CAZBlCHfbxCbB?=
 =?us-ascii?Q?jUDFVf02H/wYJgnTMLCeQmhV0InwrNNCSHeOTZIABbveqbWiGCTrbSfXSG6z?=
 =?us-ascii?Q?wYFVLsHThn9/WFJlx2l2vx8wA3bJkzYGqScxB4YcGSQs59CLhNH5Yq2cGbfV?=
 =?us-ascii?Q?u7kXpPkB52HiwPWb2GWr38ZyXUmjR9bAjlnh+pwlW3M4PGVuvEkyAf5jfRHt?=
 =?us-ascii?Q?AprepQwOyUl09UTY4g4NUcdCxn2WxVGKFLnEEyCuvS9Y0bqzmrWnzQMQtRbd?=
 =?us-ascii?Q?YqwmxxTw2FwthgoK6F1ZA7W4NM/OtKsqpOoPyM8UWvAxnABt8JOYfmAElgam?=
 =?us-ascii?Q?bFPO0WGkxHkNOf1ULvzPPAR74mvLcFg15BY7NUCdBMG52KstQ3T7Ro2PDpK+?=
 =?us-ascii?Q?SNa/iW2FUBpZJIZFsyzFjXxoKDsr9VH7fOn+zrFCSkZw9iPjk5s14/lAERIX?=
 =?us-ascii?Q?R6kRhq1F+FZI9h+QsxeBRqkoz3OMk9Mge1mrTekTGZjFi9sWOg6esSHSsKP0?=
 =?us-ascii?Q?Qa5aLa1odKjm77M0rPXCh5LYg9HRi0qbdmEdrSoej0kqYwcVcck3mL0ebKVE?=
 =?us-ascii?Q?mXcA42KLoWVzzWggGiM2vzlXIHtbwtoEtTbK3lrGD2x7hpyrApMvixOf69Cj?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MqBEZAHrnSNlrpB/RKOpXMCA5t3ZiLIdPn3yKDGtd8012n+4bluFWMeZpwmtYuC3ouz1ZOGYMszysnNoI509Y6sxMMXiLW5UrP2SrTbYFGXMeaWNBH6rQr4phemScYPVESXTTHUpABX0jRaiSKGyrMMFXIdg8YKS7ydUVbOIQu3yCcNGyKC7RV/rT1G7XItltJ2TEYpHQOvET6F2ohmKSZAyznsAn/i4ywpS3yJeesJ5W0cIsZRWz/PObgSp++b8C1pS4URL89C2ZtUmxN+KlpLXaX9TpUlmBNyuHIz8fMdaKnEXWAE90tMF9YrfYnrHpDkKdX7NrBuOnWcW78CpHp2CSxK1/uEzQAIlMjVdSRCehqxM0TZx2AgWKtfdTxobFA+UuPA/E2TZ9wmjwOINRlJ1d+2+/+B61p0/iT5eawT0Tvh9eVAWuSFWg1OItkqre+i9Sio6ivaqjV3r5iyM9GBt7gbGEeDdULkBDfEWd8mIHrRlWi/q7IQOWMJpUYUb27eTNj7ZaVG+pzQ21sdHm4FvIoNXBweWqvApR4EAbzU3g6bY8zDHzXV/H5p9cD2Fq6DAgoW2GvrOtTYDYIqhXzlvRyzdjmin/t4BG6VVRXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71376787-6d37-4f35-072b-08dd3ada1dc0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:44:23.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZtLAQPKg4T8QoDsZC7ZAEh/YWJ7k+y1CMGMooGsoO9CWpmjT8mMTPbHjUCXIcYswlEt9s698j82ifePgvorFPbV6/DKGZa7gVe8Q9C4DYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=828 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220087
X-Proofpoint-GUID: Ebok_YGCqwetT8VeJv-QnUduh1nL3w2a
X-Proofpoint-ORIG-GUID: Ebok_YGCqwetT8VeJv-QnUduh1nL3w2a


> This patch series extends BPF Type Format (BTF) to support arbitrary
> __attribute__ encoding.
>
> Setting the kind_flag to 1 in BTF type tags and decl tags now changes
> the meaning for the encoded tag, in particular with respect to
> btf_dump in libbpf.
>
> If the kflag is set, then the string encoded by the tag represents the
> full attribute-list of an attribute specifier [1].

Why is extending BTF necessary for this?  Type and declaration tags
contain arbitrary strings, and AFAIK you can have more than one type tag
associated with a single type or declaration.  Why coupling the
interpretation of the contents of the string with the transport format?

Something like "cattribute:always_inline".

> This feature will allow extending tools such as pahole and bpftool to
> capture and use more granular type information, and make it easier to
> manage compatibility between clang and gcc BPF compilers.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html
>
> Ihor Solodrai (5):
>   libbpf: introduce kflag for type_tags and decl_tags in BTF
>   libbpf: check the kflag of type tags in btf_dump
>   selftests/bpf: add a btf_dump test for type_tags
>   bpf: allow kind_flag for BTF type and decl tags
>   selftests/bpf: add a BTF verification test for kflagged type_tag
>
>  Documentation/bpf/btf.rst                     |  27 +++-
>  kernel/bpf/btf.c                              |   7 +-
>  tools/include/uapi/linux/btf.h                |   3 +-
>  tools/lib/bpf/btf.c                           |  87 +++++++---
>  tools/lib/bpf/btf.h                           |   3 +
>  tools/lib/bpf/btf_dump.c                      |   5 +-
>  tools/lib/bpf/libbpf.map                      |   2 +
>  tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
>  .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++-----
>  tools/testing/selftests/bpf/test_btf.h        |   6 +
>  10 files changed, 234 insertions(+), 77 deletions(-)

