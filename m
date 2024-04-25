Return-Path: <bpf+bounces-27827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02A8B26D4
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576912847F7
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECF814D42C;
	Thu, 25 Apr 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqNa+ng0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nHVQvBor"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D714D2AC
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063777; cv=fail; b=EVEwGVZeGJwMQg0GiSRNu9FqDUB8SkOPcZIc446IJcTuWVvHxWkWqTtkI6qUL4wppqEspxfLpTOG5zztwAZrV/LPc/5ORZo22YsytJFYSDlIVquZywKgsYrjuL1PYEhPFHufZTikaNtnlj7zDsCDmncMU1ari5/SG3sveB8fgYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063777; c=relaxed/simple;
	bh=Pf5gtqXwstRXEaWvd5qeEMWGyQWXBMF0dyTnrFjejJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fr4l2pcyQcUqgIC3gz42ESyaK0FN5Ftkm1JHlbImHsEKOmBLd4CFFRIW6cb6dLbB2HaQmZn87DeOYCDQcAuqKtYXSQ0p+K/zwvePeymK53EmXE0hMygUHggB46CpH0IvDfiOj7XZSddiPz9VZgB4y3mTaVzcG6Oqvng6dbsDIjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqNa+ng0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nHVQvBor; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PGMhV2010301
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-11-20; bh=sY9cjcTPc0fOWHUSn/f/26V/iBRAcavQ5ySu0+hmOA4=;
 b=kqNa+ng0rXptQSFxUke5s9B7brpB7voOPGcILozzWBoAydF639O30ovsIRVmLVOSXELE
 shOhK8rDzWh+XL9LxiTnr3x129ZHCZTPXaKbm+N7yMcZXplNz5qEBxBWwPOs+JGNJg/8
 9o6x7cEgSbRa3IGdszKG9xT6uELy45PdMh68dnFVbj6YJT5uBUSK+w9Q21y3qQ/r5bwL
 b+FeDQOuMRxilrZmNw3EzoGmW3vNos7YpNmAYxuE7Y8Fe8E462IrQ15A5s/lsG4ohzxn
 KE34QY40MXDBjU7l4d0LA8GawJ8q3sMclCAQfl9ihP1CpETQOMD932WTES78q8YS3pIW VA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2mf7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:49:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PGA887019262
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:49:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf6nk4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNVpAo1c0ANYGjXgIEh/P0gLLYi0fonP8cx+eM9lz3m9M61oZk2b0OSV+Trud2URIjhMgUPu+KycfFNC6czoUVjg6A9XEERbN4LHfy3haNXmddCdi5AeH1Lf99e+F8M5jObwfIdnNj2WvLzbgRcBD3NTHBENi/Hwu6RAAd8igW+OImeGmQUszRE1SFzGC1e4CE0jGlRu+k6T2XpWA0VU5stnLroH13HbgUKeXjRBGI2l/+M54drllYKtX2joIMZ/ymZ/26R1gDhg0gQCERr2PvsBvhyEDM6UmRP6as5T1Lg5cofm6xiQCEK0LsRO03jLAGhb+bKvJVwMw1nWg8E2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY9cjcTPc0fOWHUSn/f/26V/iBRAcavQ5ySu0+hmOA4=;
 b=EA015iVDbv6kzDC77DuAm5WuLPJlUae607skFefog+RIoD3eHWwaL6iviJKu5TX0OqY78dA76pKanIdIfBbQEq3R1MqAPRE/yDmzjr9pc0ueoNaKtLm07i3a2Z33t30E53d/2SNR9FL+1RTG1EDw2fPJAJZvJ/B3Hyk/tbPl/+LpGrAjnwlpG8riZgwK62Oprm8C+cjeJjxVUZNW2V9EWmePEHYQF10Uk9HcB5MkMsLuzlgWoWlFJUPFGiN+SdDDVC/wTgDGVjli5qZVuTAY7krIPQQt+mI7b5rijwH7Kb4XTqG7rBOFSl/u9rps6pV2Josinz4ZKbwEIwkTJwH3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY9cjcTPc0fOWHUSn/f/26V/iBRAcavQ5ySu0+hmOA4=;
 b=nHVQvBorTiDb38mt/rERCX9+OksABbzhToRZDO7XgTKaDEJRqSCXGm3I7akairM0ytxZpehxp3gi2CFbouaa9q7c58pxuFEaGrPxesukPfI4wY7w+G3Y2o7cj6CnMsatkQZFL3VgEBxSBSl5fm9BINrum4bM/LgcU6udBXw0IoM=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 16:49:13 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 16:49:12 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: BPF_PROG, BPF_KPROBE, BPF_KSYSCALL and enum conversions
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 25 Apr 2024 18:49:08 +0200
Message-ID: <87edat1j7f.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0146.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::7) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH3PR10MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbfa4e7-9ffd-4dc3-9ff1-08dc6547a2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YHAnWXEjpaqg7iWUZHUhIolf7CRhnr/LuP9rN9g20MvJvpNV0UIbEgw6Fd08?=
 =?us-ascii?Q?jhGkehG5yyvlhGpvGSWbFl3bj9eNOdtsbfk2ocg2W1dmFxSYc9Qig0aLEru/?=
 =?us-ascii?Q?muWfNRnAXUx54kIWbTBgQ+ooQLl5oOLL1xTrc2s6+gWJ9oDeoT3r09LFixEq?=
 =?us-ascii?Q?cDLGPKD3iKMA8o2srgIodoJJ+wXkPSMed7c3pqzyInpucSEue4XXhKqobXrT?=
 =?us-ascii?Q?cL3C72U4JTnzY7GN1vhSKdpkP7VCQJIiqkx0++hgAxyxEv2ZHPkX4mcp17YR?=
 =?us-ascii?Q?QI2kf2PXUIfOx/6mp3tgfxSAtX3/t8bR7I3PIMPuv9F/xzcvQoE1FhMgEkrF?=
 =?us-ascii?Q?7xsZ2ahUJVTWxP00QMvjioVB+8aIZpZF0kxGAamfQKDzNn2Odz3QJixRKdln?=
 =?us-ascii?Q?pS/dE+jkUbT6mAgC61a57qpIllov0OFI2+pzqh1nLAw8EEmaddwThhtMH2vl?=
 =?us-ascii?Q?mpIhUKbTfCNRnnLw6SFK2XamErBX3DXnvqYxiPy9KLspnwtsCWooLw5oNKsh?=
 =?us-ascii?Q?Yu5P3b5gNzW8AwmUiY4ReMof4zZJn9oI/Qfian0mldP3SxcBS3ZaSqSluw8M?=
 =?us-ascii?Q?LPUkt819v45bBt3fuuEERCd2MAmY/EjaueED7ah3dqxFUOfN8EJ9fTTae2zv?=
 =?us-ascii?Q?vyhwZSvZjMEEdOYDIozwjyWjNyGz62oTr4ekWeAYlkxyI3stEcHuS9dyCzJh?=
 =?us-ascii?Q?EuCEUrngO7Hw1c5LMM66wRdFoT3nGHQVNDZwWrpDfCme1D+nxqeDkbO1Fs5U?=
 =?us-ascii?Q?wvVzNnm6EAu+gU8tXrmuD3Xdm0HzmVdh6+F5n2eF9vQrhslNjIwgh+ACaw2N?=
 =?us-ascii?Q?/c+j2xqpiG5e8JUIkgLvWODzyc9bpFZkhoWkPC/h3BcRfvqWeXihUVMO9KDd?=
 =?us-ascii?Q?CWRXdT33q/lNeIU3B7lXSVLjhekp8RpSi9+Ekxy3W90raxSqG01F42OWHl7f?=
 =?us-ascii?Q?o4CcqeXLZ6DspVQsvZsQsev0Kt8U44lzS4WiKCUOGIylPYvAfvP9A9uvd5Hc?=
 =?us-ascii?Q?oxt84hfq5lGZ4laa+qDUXMNNSoBWQUJAROx5WmgRdGzjgiRCIzpcMginiDHL?=
 =?us-ascii?Q?zVtdfrxXKpx+Kq/g45/6tacuJF9U7kBQlHLXTeCQRIkGY/h0kuUn2iyav/BD?=
 =?us-ascii?Q?vxvmOOKCme9Y7Xfhgr1N+yVXfIIyVtsEAGWt/FtpkVQlD3eegPz58QR+EO2C?=
 =?us-ascii?Q?hQ5ALxeXkCzGMBNbERn7KSOJU/USvgKPsFJufDZPcKAinpKOGxVlQIJzawbp?=
 =?us-ascii?Q?wXg9+3UDVn7imMbbJ+dfFUv8etcC9v6VCZ88g93aQA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FQiC5V0cAHu1nmPEHmc5LOZ08DqO6CIosQhJfH4xKSAhyUXdVjS/l4HDw/ys?=
 =?us-ascii?Q?XrxrxwgLs+YgusPLGFWuEJ8yBSbiIK7xkt2QdTbrcqXFpXQk3uA1RVzEpu69?=
 =?us-ascii?Q?FEMWPmH3xri8K2tbHWkweMro1jxn0VzI67yqkvJ3AJFTqPJP1Jtvn+Wt49zL?=
 =?us-ascii?Q?aqCbn30/CKNSo+s6llb4/QcbQCRW1yFgwX86ZqL7WbZeJMRnLZ/YUci79FUb?=
 =?us-ascii?Q?sjbGlo1QcLkkahzipWIAzLigvaPOxIsUYLeT6sA1zpzTUW3tjwxe3MuB1D98?=
 =?us-ascii?Q?DF3veIlq3ncXsDJgXZByM+LlG//ZI6Mvx9328/j3Y0eHA9P0XPWuchw25G/f?=
 =?us-ascii?Q?Vtn6KqXREIs7JjojQUw3xhylfUWiJwT2gLholl4vOaxfCwGWHsDrBEJuyoOW?=
 =?us-ascii?Q?ng7E/CG7epzIAIvU8uo0eM/3qK/IvIEJQum9/TOl1F7ZcQHO8Oez2Dy+XHM2?=
 =?us-ascii?Q?j/BC0U+2X53AVy9rGTRj8Mu67UxPZV4EksyCJFDHEgXfry0fA1XdbA2UxDIR?=
 =?us-ascii?Q?GQuV7jLXKGX7WqT0qdNeQFuR/PM8kF/EOWlEwJqf2g93ZkSIzwt5vggaA1oq?=
 =?us-ascii?Q?zhFoGOfZ5rEWp4n0lYcfvkWBT36KkhsUpf7ikxC/ShGTLbzOB7UClptvcZX2?=
 =?us-ascii?Q?0T9b7GXtJWiyTJ3gC5tLtd2F1qNgUPyYvlN/wk/S7QZR/6RBcp2HAupIvslR?=
 =?us-ascii?Q?0MfNFKBiIIkcWbW8D/aUxCsiQf6YP7/hqo/6rOqEGloXez5IH6nj4KMBgtSn?=
 =?us-ascii?Q?y+PfSF3wCoVQ64iFgRG1ncymjVbanz9sBOvfIY/VCngB/kXgL8xbimJIv5Et?=
 =?us-ascii?Q?EZ4MELlNUD6JcIJtgl9WbiAmGJ/EXRVsdMRsjn9KAfDaon1UrGZ8fZbfZzWJ?=
 =?us-ascii?Q?Ooc7pK975a/be6qU8AoxvfMjb0msuZcCDWAd+nmXIr8/YKs4igFGGFwWFrGP?=
 =?us-ascii?Q?G1o7SMX8mT5APHlMAXPlICBf2oTQw5aN6XZpM7FqobJ1excdTHqapA+qUPiA?=
 =?us-ascii?Q?eLJeXQnJvb6dLbdKsW0p/Mgy1dQZ9kc1tuWjNMT7ScFsw9lTR+67Wcu8MEa3?=
 =?us-ascii?Q?fG6a3BI7y6fLrbFVtlZtIAXESys+Py0KOg1e81S/2CcNiC8k19gQsymfaX1R?=
 =?us-ascii?Q?IUphfO2vqiZCmnpqq0UQc3eVpt/0H7xg6Ye5irwZ5n3m6bcRuz1indeplxV1?=
 =?us-ascii?Q?KXul9xsp/MFrR1/WfWhYSQxrgTXkmnYgHnPGh8zkIQl4/mJwzJG1ok0mPzwZ?=
 =?us-ascii?Q?rUknehqX5K1wSP5hlOE3CH9OmKK4A4jZ4rYnMsyvS1vM05wlsAxm3wAuSx0o?=
 =?us-ascii?Q?/J2rjiXyTyYon2bYUn4ENG8HEriVrjiI9hCIsdvkTbxxJEJyJDu5xQ9U+jvT?=
 =?us-ascii?Q?vAtYuDt3hpDKdkBSzfzd2b44K49egQgy/lTT6ncnWB70OiNSYkiU5MDRGn8d?=
 =?us-ascii?Q?Dky4b9k+XuzzHvVr8KO19hrrbX5feKNtE0duCQBrS7h39AL3PwIDqhFbAqLn?=
 =?us-ascii?Q?bsiU48I59F+uuLyLiHvwjhOt0xtlZCE/VYm0NfYOCD764iNfK6uiD0PtiZ6A?=
 =?us-ascii?Q?voTDBw+X/EoNME4CaTEaR9zn3ANoV0FT6tilaxGhFAb8eR4AUG890X1XGtSn?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VTccVFx7/OxxN4U8RqK8KwAA41HlPA+PgavFLY/RxO2UaDHMsViJZuPJOXO6ucTh8khcs7wdgblLrQHkJL9IxNeLPmnRpqx+hJWa4qk7LlE7NwHvptiK5q6/WDj7jGXFKpQPSORA9yGLwhF5cUF4hPBoBRan5jsVIUND6YV9oYAHgBAhgpmrDprvL3/NBAYAKvDlOC4Q/pESriuava/xgAuwODzCU2cS1yGQco+GCMbPgZX4/AyBsa8xUsO29bOK7QifnEfggDn5McqgwNCGLRvA+wjlu4kxWrYpaz8zWCkWhMms4aRz2EMwc2hbBIUfQpzLzcULivhctd4JvsXHfkHJ+RHSlV2BAdYIbcQmBQijk5jeO15NxokiFG6r6LYZn5Q5nUHGMVV4H6AWEDt+E57JRdNKhMPxapGMvG8LlAiidsKr/HpmxtwGT2gx7KHFWcjh9m5Mpeu60BzCdDzumYcljdffk2A+h9Q29IfdeM12LlbKwD7xE3g9Fjjaln/+RW/wK+E9ICEs2byu4vYyNz+WS7pJ3MJ1SQM2eB+QpJvWmVYNHQ8uxJPR4hKLJ4yHcTaRbyxRQD+gOj15XXZPLtruYBB9yE9KPMxyJwNCPD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbfa4e7-9ffd-4dc3-9ff1-08dc6547a2b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 16:49:12.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+b/u+yoYnBpLAO3eU9AREmCWYcy5Movg707EpRWXI79Cj4Tuc/rFPUvzCIqCixGGx1jGu0yxTwwRwjHWEOMmv5lSUAoyjAH9waY51Tk77w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_16,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=567
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250123
X-Proofpoint-GUID: oDMngaCu-GoPyxHDSXogfNrvQSZ7K9yT
X-Proofpoint-ORIG-GUID: oDMngaCu-GoPyxHDSXogfNrvQSZ7K9yT


The BPF_PROG macro defined in tools/lib/bpf/bpf_tracing.h uses a clever
hack in order to provide a convenient way to define entry points for BPF
programs, that get their argument as elements in a single "context"
array argument.

It allows to write something like:

  SEC("struct_ops/cwnd_event")
  void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
  {
	bbr_cwnd_event(sk, event);
	dctcp_cwnd_event(sk, event);
	cubictcp_cwnd_event(sk, event);
  }

That expands into a pair of functions:

  void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tcp_ca_event event)
  {
	bbr_cwnd_event(sk, event);
	dctcp_cwnd_event(sk, event);
	cubictcp_cwnd_event(sk, event);
  }

  void cwnd_event (unsigned long long *ctx)
  {
	_Pragma("GCC diagnostic push")
	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
	return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
	_Pragma("GCC diagnostic pop")
  }

Note how the 64-bit unsigned integers in the incoming CTX get casted to
a void pointer, and then implicitly casted to whatever type of the
actual argument in the wrapped function.  In this case:

  Arg1: unsigned long long -> void * -> struct sock *
  Arg2: unsigned long long -> void * -> enum tcp_ca_event

The behavior of GCC and clang when facing such conversions differ:

  pointer -> pointer

    Allowed by the C standard.
    GCC: no warning nor error.
    clang: no warning nor error.

  pointer -> integer type

    [C standard says the result of this conversion is implementation
     defined, and it may lead to unaligned pointer etc.]

    GCC: error: integer from pointer without a cast [-Wint-conversion]
    clang: error: incompatible pointer to integer conversion [-Wint-conversion]

  pointer -> enumerated type

    GCC: error: incompatible types in assigment (*)
    clang: error: incompatible pointer to integer conversion [-Wint-conversion]

BPF_PROG works because the pointer to integer conversion leads to the
same value in 64-bit mode, much like when casting a pointer to
uintptr_t.  It also silences compiler errors by mean of the compiler
pragma that installs -Wno-int-conversion temporarily.

However, the GCC error marked with (*) above when assigning a pointer to
an enumerated value is not associated with the -Wint-conversion warning,
and it is not possible to turn it off.

This is preventing building the BPF kernel selftests with GCC.

The magic in the BPF_PROG macro leads down to these macros:

  #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
  #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
  #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
  etc

An option would be to change all the usages of BPF_PROG that use
enumerated arguments in order to use integers instead.  But this is not
very nice for obvious reasons.

Another option would be to omit the casts to (void *) from the
definitions above.  This would lead to conversions from 'unsigned long
long' to typed pointers, integer types and enumerated types.  As far as
I can tell this should imply no difference in the generated code in
64-bit mode (is there any particular reason for this cast?).  Since the
pointer->enum conversion would not happen, errors in both compilers
would be successfully silenced with the -Wno-int-conversion pragma.

This option would lead to:

  #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), ctx[0]
  #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), ctx[1]
  #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), ctx[2]
  #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), ctx[3]
  etc

Then there is BPF_KPROBE, which is very much like BPF_PROG but the
context is an array of pointers to ptregs instead of an array of
unsigned long longs.

The BPF_KPROBE arguments and handled by:

  #define ___bpf_kprobe_args0()           ctx
  #define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (void *)PT_REGS_PARM1(ctx)
  #define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (void *)PT_REGS_PARM2(ctx)
  #define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (void *)PT_REGS_PARM3(ctx)
  etc

There is currently only one BPF_KPROBE usage that uses an enumerated
value (handle__kprobe in progs/test_vmlinux.c) but a similar solution to
the above could be used, by casting the ptregs pointers to unsigned long
long:

  #define ___bpf_kprobe_args0()           ctx
  #define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(),(unsigned long long )PT_REGS_PARM1(ctx)
  #define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args),(unsigned long long)PT_REGS_PARM2(ctx)
  #define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args),(unsigned long long)PT_REGS_PARM3(ctx)
  etc

Similar situation with BPF_KSYSCALL:

  #define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
  #define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
  etc

There is currently no usage of BPF_KSYSCALL with enumerated types, but
the same change would lead to:

  #define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(),(unsigned long long)PT_REGS_PARM1_CORE_SYSCALL(regs)
  #define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args),(unsigned long long )PT_REGS_PARM2_CORE_SYSCALL(regs)
  etc

Opinions?

