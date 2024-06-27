Return-Path: <bpf+bounces-33259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5925891AA38
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7E8287AED
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC8197A72;
	Thu, 27 Jun 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKREFCXf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HsjUaXaS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149813A245
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500575; cv=fail; b=E+c9ZHK0M3yXZCUp8tvap3NrL72zNwcI75Ip1qh30FDLGBulUEiQFZSAvnVuAuiEbgMPac6FlpLA8kXsq0Gsp/X0XlZ7sdG7bNTyEGuSmlmMtdcZTYcf+ShlrD2T/zcDUlebaiCrqPHaX2QM3+oAD2+K6Pxkx7yfk8ZLgpS+Zm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500575; c=relaxed/simple;
	bh=7FKI8bvYNXWM4s/5QVcZkwWzXXWMAKQmSz0WhWWKv04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vEMm+JY+/Nn1WADwN9oqUzzJV6W0sy38O74/KgRWDRZid/I3pLUL0gDvT30OB6Bjk7IsIpzASWRK2sEhQUyinHC6kCocpC6RHtXTQqA6MuLHgt3O5QX8Bw7YkC/fQBQKRX6ia6IWN9J01lmiDDHNgEJFZI2GBVBXEfGWopzxGSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKREFCXf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HsjUaXaS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45REMWe2013756;
	Thu, 27 Jun 2024 15:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=i5a57KLGJr4/VnHXRegLwnoq6TnfNvPngLD0x9pTI0A=; b=
	hKREFCXf8tplmrOPUmSV1Lf9VhmHgf4kd5mXMMh/jIpjqkmnUVFNnDW2Ugezon7N
	qItXGssU0HYMJPu15iSSdjmdeE6tzdy6wiFwQdYeoAx56KyI8Uyaz3zyutAcgeSd
	eeA/ENwPIKX0lSt3UaKscIq9rQvtTvvDXeG6MxS3AwsSx/QArVdhHn+cjNX8dqUD
	cWECoikdJsZhCcx4h5HS7xIH3xFRivViC01VTimwUT87fh2Lb+W2SO0Sf3m0CWUf
	BsNjg5zeli/pvr5JybpfLx36i4pGfxc8EsEoTbHeYB8yimu1gBKwLLi1qB1glbdU
	AvAeFMMka50UFk/hSRcklw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d617s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 15:02:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RE5pV3017795;
	Thu, 27 Jun 2024 15:02:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2af8x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 15:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nupfUiDly/SHepnS0sKeuPZmjmKGtyge0T2ACt1EQ2Plf2H6Z1ILvAi66coQBIl18xrbXZH5EPJRvrm17vM4D/59yu/xtlE19jXIcJjBVmF+YRdgL+0nKQn3+EczKRLIZn/yUrMKSqAeymhG6no3Mi4bN/81s5VncPxk9035UMUI3NGm3mDQHqspxIh7xXzH/SujqHELh7z0n88Mc9jgGmXBy1tNvO2yog/6Gqb2TMhkS90PxBoqQwF24N+uQ9iHoe+z7Rtha4Iq+nj0i+NI3Nnp4F3X3f3VVyHCFmh1euqRpvBF2omnwGRZ6yn5AEpcjUk+JpyKizWWUEd5tzfbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5a57KLGJr4/VnHXRegLwnoq6TnfNvPngLD0x9pTI0A=;
 b=dhlvSqd41OMO5PWE0x58fyTP8v1qhD5MkMcWAjcyt3iHvULXsx1hz+OYkyKwKkWbued7nSRZYP/0K2C2gGb63nEnb01PlVg4JXov2aofCkFQ2RlZqIggD2W6qoqeW7PPWpckSo3GXG099O/EIAoWGlg8VACF3MoEKHaZDaLbvYupM0GK1OjpIuAgL3mpLHQLmGvp02C956HJtU6BNDyoDN0wDrzfEHUWS+OJbMDFFwYmoUg9vMS6cyPoum/SNTGddoTz4uOssLEk5JO3C/GhUp2WomQsq5fxBzXKCxv1zYx/av5EkPyn8aNxKk10aS9suzYseIL41bDvSnhVE0aLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5a57KLGJr4/VnHXRegLwnoq6TnfNvPngLD0x9pTI0A=;
 b=HsjUaXaSuJj6DT2FEn8jZ+dDM2upmHGiuDWtUJNkrzJbZz9py+2Shp3QbppWEvmslgZDSisubr/DmqxyFiwg2CeICWutCTZIL05mugazJ2ISahhp6iWfwjkUexahSFJWQpJGwYSDQMuYWQi1w5p+U9GexA2m+tjrPBnMwKvscmg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7271.namprd10.prod.outlook.com (2603:10b6:8:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 15:02:21 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 15:02:20 +0000
Message-ID: <3337d49c-8322-4246-81f9-6878387232a0@oracle.com>
Date: Thu, 27 Jun 2024 16:02:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: Make btf_name_info.needs_size unsigned
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20240627090942.20127-1-iii@linux.ibm.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240627090942.20127-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb13e64-fda1-4e16-ee24-08dc96ba24d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M2Fxdmh6Y1BlVzRWT0JDd3dtMEpHOXZTQndHOGEvaXVGN0s5Q1A2SnNTSEUv?=
 =?utf-8?B?NExrYzByd3VRUXYxbUc3WSs4RUdXcXFua2NFOHN3eG54cFF4ZUlRR0xWUTVV?=
 =?utf-8?B?S3RjWXBnQ2g2N1NHaE1icWQyNXUxYVZUb0lrR2Y1SDZQOTMrMXFZalJhbVBQ?=
 =?utf-8?B?NG1vL1dJcCsxUnJIWDI4UWxjbXlJNUFUL1VkU1FCYVhZVTNDNlY1dGlhMHpH?=
 =?utf-8?B?MDZpUEh0WElJcVIreTNSREhHWUZac01DcEh4VnNXVmlVQUhlTW16NWdidndQ?=
 =?utf-8?B?NWdIZkRXWkJGMmxMcThVRDYwYld4aWhtRXdxR29oby94K1lKOWJCS1h3dmhH?=
 =?utf-8?B?UzhwUyt2QnJ1OVAzM0Q5V0hJQ1cvNHB5cVNENzBRamZsbWlEWFVWRFhwUHZI?=
 =?utf-8?B?MjNvcXd3R25DZG1zMjhHNlRzMlNWWWRjVzIzU3BSQTY0VTRLRHdPK3FBNVRR?=
 =?utf-8?B?UEY3NUlQRlBOK1NPek9oRkdVWTEzR0RncjNHQ3BITFdyOXJ3dDQ3T1dHN0py?=
 =?utf-8?B?dk1oNlVrVFp0R2pzTVVRL1JUUUlSUzVpV2VjN095RVVucE0wbndtOGFPdTho?=
 =?utf-8?B?Y3pDTExFbTlUaTN6RTZscnJYUmF4OWpOUzNucTJkQTQ5cUVHS2tlQ2ZBUnRu?=
 =?utf-8?B?Y1NETDNzOFJPaTlkeW1LRUw5cTg2WFFuOGFScTg1VzFVTWY5T2xBOFNMa1ZM?=
 =?utf-8?B?RWtCakkzczNtdEgwUC8rcU96RC9XNmxVNVVaK2V0d3UxL2s1OWdMemR1c29j?=
 =?utf-8?B?NUsxeTY5MTZBM3g3RXVzZ2VBby9PUmN5cWdjYmxzZ3hEcnJaVjQyU093RElT?=
 =?utf-8?B?c0ZCZUFnaURSODI0Q2NBNW5MNGVMQkZqQk0zOGJCVEwzSGIzV2tlTm5hUG5k?=
 =?utf-8?B?QlZmeGt0WlYzWXFtQWVmZ0lxdmhUS0dxZHlocStyNkpKdTBESzZYeTFkV0o3?=
 =?utf-8?B?ZWRCdi9wOGN6SkJ0RS9ielI1TCtwUmhQSHRQcERUeTNhZGJnUlAxbEpCeGVL?=
 =?utf-8?B?WWl0K2crWThTYkQrL2RHVStPTjJXcE9ubEQ4NkRZRjkxbE81Q3RPL1B2OFJa?=
 =?utf-8?B?cGpob1k2aUthT1piYnB5dWpZMWFnYzlxWGdjMDVkZHZXWFFTNFpZWTQzYlR5?=
 =?utf-8?B?V2RCWHE5Rm1ub0hBMDI3Q0gzWGU1U2huQ3IyL2pXWk1zdE9DcGFyR1ArU2VW?=
 =?utf-8?B?dXNxdDkzYlZ1VzZ5T1o2QnlIbXMxSmNLREl4ZU1RaDZzUmFMNXVKa1Z6ZC9X?=
 =?utf-8?B?cm1oLzVhWTIwYmRwdUlsOU4xc1lMVlFQUDNaSzgweTR2d3dWV0RhL0lESkNu?=
 =?utf-8?B?KzRlUzJVc1FYUm16OGgzaDlvRWNvaEpNdHBEUEViNDE0RnJhckMyZlZwYjA0?=
 =?utf-8?B?dXg2Zy9ocUdXYndWUzZsRDhDdDdKTmFUTHVKb0pHVFc5MzZTVVRmUm1Sdkxl?=
 =?utf-8?B?VnUzdG1uR2RMY1VhLzh0R0w4cHljcjk3NHFXN3UwWXFuOUFEY0dTTVFrWnR3?=
 =?utf-8?B?ODd2cEdTQmJTdU85dTJrbms5VUNZT2VqZ2lYT21JVjFaaHJPMXhhcW1qSmtG?=
 =?utf-8?B?R2RmVzVOYk5qWkJLZW9KdjN6MkVwYUl4UjNWTEFBMXRvU3N1aWx1TmhieGNk?=
 =?utf-8?B?VjRpRUs4S2VyWUxmRHdrNmxNN1NYZ0QzeVJRekl1TnBOMENyMkpqek5TbGJi?=
 =?utf-8?B?VDA0VjlHTzJrN0RoL3dqS0Q5MkxHUmVVN0srZlVBcU1oVHVSUHdiTyt0RjZK?=
 =?utf-8?B?UFdNR25rV1lLbW8rMlkvT3pPTVhKMHlNWE1tZE1uaDBnVE9CUTdhSEVwaFF2?=
 =?utf-8?B?Vm9SNHhjdmEwYkV0eHR0QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWh6Mi9aS2RCVERCQTdnR3JueWdVNFVGTEVYRWVaeXRVZ1ltV2J6QmV1OGtQ?=
 =?utf-8?B?WFZPNlZpQ3dXci9sSnVMcWE0NFZ0Sy9HVHAvbW9lTytsNFZ1Wm5PSlF3d1hQ?=
 =?utf-8?B?ZjV5azllRTdqbW5BSHNnakFJWTZTZnc4ODlCWlhmRitZYmcwemZjRkJSUmtD?=
 =?utf-8?B?OXh3eWF4WTIvaTNBM0VLbHhnUFlJbktJSzBtTGs2enJBUEp2ZUVocVNxbE9l?=
 =?utf-8?B?TkRQUmlMcE9pcHZJTm5wY0hyWnkxS21UbThCQzZocXUyZWo2bSszYW96T2tU?=
 =?utf-8?B?Yi8vZDlTTDV1SGppMlE1OWFpYVVraXBDZlR5NWFIa1N3dWRGQTZuQkdTVHRv?=
 =?utf-8?B?amxhZWFjMEREZU13dlNoSmVDMkVxbVg0TExQK3grNlZEV1pscys3TlEvUHIz?=
 =?utf-8?B?di9OL2FobllUMUdHUTNnRU1Zc2lONHFlNi9zUDZZMEh4dEVIRjJOQ0t0bVZE?=
 =?utf-8?B?S3ZZQlVIeXFMQTYxTTRLVnZNMUFia0tpcS8wRmcvUDZJcG9MUi9zN25aN1JN?=
 =?utf-8?B?OFpoejJ5QmdKM016UzgzempIeVVPeFg2NnVoRFQzbk1zd2xmNmhEb2xzMGdD?=
 =?utf-8?B?N2hpQ2ZWa21ORXFDMkJrcVo2UHRLbmd0QVFEN3o2dThkMFFabk1odFJQbUhX?=
 =?utf-8?B?aDNnMlBoMVp3WWNlWUN4ZUNaY1Q1NVA4M2lIeGxSUEwreGw1TTY1QmNNRXVM?=
 =?utf-8?B?M1NJdzZzSG5NZkV4SC9FUTBFc3hDZmF4eGZQQUVtM0dzSHBBbjBtZCtDYUpw?=
 =?utf-8?B?UnNPTlVTSWY3R2l6RSswSmNmaHZBbk5WbXl3bVZlWUxKSnhDRHp6T0RJZmJw?=
 =?utf-8?B?YVpGMTlmcEgzLzYwRVk0cXhKL3N5WXJvRUxyQjEwWGlWbDZsaHZJZ1F3cDRn?=
 =?utf-8?B?UW4vOFZQTDJ3RTFLdVpJZHU3NmdQb1BFYW5PYnRQTHJHcG11NURLQ3p3aFg3?=
 =?utf-8?B?MHY3NklURmM0UUkxV3REM0pZL2tmMGRpeUpGRktRUWlpTzR5U1NwaHR2QTRW?=
 =?utf-8?B?RE13eFIxeEx6a3haS3N1bU1nZGJjYTVGT1ZDZE4vU1kyY1czZGFPS3NPVVBW?=
 =?utf-8?B?dm1LMU11UFNzUW5Pa1NXU1VORmFqdDdzdkRIdzBsNkFzb0NHQjNBdnF5S05J?=
 =?utf-8?B?MENiRVFhZW9Rc2ZkZGZHaHluUUhuczFOdUxvLzd2a2h1aUpaQVNhdkdCUkow?=
 =?utf-8?B?OVFzUVBaUzRiRVc4ZkNvS1ZZVTlLdHRMeWo3NDd3T05vb28zZkZONTc2TDQ2?=
 =?utf-8?B?SkhaN1ZpRjAxZS8rbGcxVGFic0I0eWUrdTB6Vy9DSTdOM2NwQ2Z3T0lrM3Ey?=
 =?utf-8?B?alB0c0lpZWZnbysvRjB2MHBRNGdkdXMxWmN5SE00ZWszWHJnR0RnVmJ5UnB0?=
 =?utf-8?B?eTMrOExmQUZlZm91Y0lyVklEcWRSZmRITmdRdUZrS2orRmdEcVhHSmRmM0ky?=
 =?utf-8?B?Rk0wU00xQi9pQ2U1eVRLUTNGZTB0Q2Z1a1JDQ2lEbG42K25YcnFwQ1pXcHZa?=
 =?utf-8?B?Uk8yaGFCL2NzQzZ0L3ZOaTlWd0tYbkl6V1JKbVZMRG1HcVoraGlkM0piY21n?=
 =?utf-8?B?TjFmZnRNaC82aEthU1A3UjVJamFKUGtMcVB3UHFYd0M0RVROcVJRNGFJeUFX?=
 =?utf-8?B?Nm9xZE1rNG9pN3VqZDUreGl6L3UzMlVtRFRaZmRXbHNMUzlGZnMxWnl4L2Ix?=
 =?utf-8?B?djBXc3RWeDFUMWs0Q21HUjh2TVhFNm0xRnBuMVcvNU9TSEkxQ1kvRjNmOFdj?=
 =?utf-8?B?emVXcGJZM1E1aXZmSDdiQWhScjRiSzdZVFFaKzB1M2lhdDhXelRJcVkxaEdZ?=
 =?utf-8?B?aHIrRVJLWE5odkVwVXJmQUdDL2FWaDlTcmtHbnlIWlFNNkpWcE5Zc2IyemJR?=
 =?utf-8?B?a0VOYm9XT29NWjNxcFNZT1Evc0JUbkhua242ZFZZMjhIMmtPb3M4YWtZQ01R?=
 =?utf-8?B?dm1lT2JHTnNNQzd0anlNOWF6NUx6UXExVHhuQUtMbzZjaEFRT2NveFhMTW4r?=
 =?utf-8?B?ZGRTMks4ZVhYL0dDNEFYZjJkYUlEZHltOGxRcTVHdTBpVTZiWlZSb3dXRTVS?=
 =?utf-8?B?SVUxeWh5ZlNVRktEeEFxSkhuYmEvZlFKTjRPUWxoN0RYNmtOc1BqMWY2QWpU?=
 =?utf-8?B?N3p1Wk5TekV0NHFWZFAwcWkzeEpkcjBROGpHZ1M1ZHBQSU0yK2Fab2xxRmUz?=
 =?utf-8?Q?o2JK7h0kS2EEs5pqYL1e+7Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SWl9Xa5b+/KHyprE6qeW4UIt7ISS8nBm8Ep8TSrxtD5Xhf1sEDIYq8RK0zwlJGLb+HJ1TEDb1hHV3O9HmlSjmQbcAHjn3Z21cwX8PYdYfwTYJw1/E0jrKjYEYtixgdAs1RzsFPUgHjphqPww9QQ+27E/n0X1GNYHnSZaTt3/O/scPlmBZtEBkxgsO3xbEs3nPhhERI+2LHbh5onQ2ijnRMvzoZzaTwVB+MlryAAlCZtiYHC9SouPa/kQUquKple6CtQOHeVpZhN56tfrKHn1DLtcWauofCOnAiMZsr2zDuHGvSwKjk8y0eo1DTMzthUgGLGopPTNfoyWIT/AiQoItR+E3s1cy5GzHtbRSDxrnqfgg3qa+PNXhBoDS7T/2gKtzO8A3OKi3QEj6ofn+1UMeby0DSSA0CMx45a+o3j1G7uttQcfUk2kIpXjndWewyvnJMgFMPj8SmsHfg1NuvhXCBwFSocV8UsitEGgFdArnNbO/4aqVS66vPMWDPasY0lY/wE61ElBHTH7RAYxubQhXnlr16W+wFVSSmaVjhvd5btMd3R9dxufgNyuKGYHiAVyBBZdesLONFEUGcVGDoH6gqkz2phvJU4hVsSJSN07jJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb13e64-fda1-4e16-ee24-08dc96ba24d6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:02:20.8397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXEBIxB9pBNonuFAjnAXSxPF1TKTzmGnxGxQ7ifQjGnfTSOuWx3WYqAfOtaB8xRhl2yqL2RHg4BfSgNAnhbejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270114
X-Proofpoint-GUID: 7F3U0Tba1IbrGqKuxVH4YnY1kjZrEVx3
X-Proofpoint-ORIG-GUID: 7F3U0Tba1IbrGqKuxVH4YnY1kjZrEVx3

On 27/06/2024 10:09, Ilya Leoshkevich wrote:
> Clang build of libbpf fails with:
> 
> tools/lib/bpf/btf_relocate.c:206:23: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>   206 |                 info[id].needs_size = true;
>       |                                     ^ ~~~~
> 
> Resolve the issue by making needs_size unsigned.
> 
> Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks for the fix! This one should already be resolved in bpf-next via

0f31c2c61f69 ("libbpf: Fix clang compilation error in btf_relocate.c")

> ---
>  tools/lib/bpf/btf_relocate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index 2281dbbafa11..d2551d7f33c8 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -58,7 +58,7 @@ struct btf_relocate {
>  struct btf_name_info {
>  	const char *name;
>  	/* set when search requires a size match */
> -	int needs_size:1,
> +	unsigned needs_size:1,
>  	    size:31;
>  	__u32 id;
>  };

