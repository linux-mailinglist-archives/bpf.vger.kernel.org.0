Return-Path: <bpf+bounces-72718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE8C19FFB
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 12:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733EA1C65566
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075463321DF;
	Wed, 29 Oct 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oO3TYptv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pXWJ33SC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416E3321B6
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737016; cv=fail; b=pL1OENIU6mIrHYU0uiEARibkHM+cwsMA41WY7DQYeZEdJMqH1MTQpioPBavd+8Qm/zoblblJlVG967obDfGyq9xnh/1y8U06ysFBgHxSqE7LrNJw0l4dMIKmCrfzOa5IompJdrZLu3PBouGrii1bRqkJlH1mYBvsW5PK4Bcd4kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737016; c=relaxed/simple;
	bh=nEG1PXOiJvW+AEB9sUfy//g2th7QiLzq+Fqfh5Jg3Ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EI4FzUfl13Pdac0m0IetLvJoymv6c86nNqziV/o+CeARHSmkvvaPvidyiSxuNih7D3PU9EOa6Sc7B0LcnlHcIdFppxzin8ZBTV5uLCQtkZaVYQlYjTRT/vN3bpoIWhu0ANwqNIVWFDOaYZguM3wa4Bpxm6Vi5Arh9nGkoVVc6Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oO3TYptv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pXWJ33SC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gH6u009946;
	Wed, 29 Oct 2025 11:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gKnqGLttIYVfJHo9rfokAV1b8haZDrHn06rlgOHuY4U=; b=
	oO3TYptv0SVUJkRB9HBnODldMiojj250TJgaclbLA8WLWIk/HIgLy9v8GeUvJSkg
	r2Wjhac98d106WQYNEUdR/VVga1uK8QJijUDdRRGNxFq2BwPQA+IIrAiLtrdb0am
	3K4w25vgf35zsq5id1ZVbf321wNb3+Crp3laIsaWq3Xz2syKOIpAg/FIxVstopO2
	0ptlvCmFaL+RmIlkV8gnZBRyk2U7CRMrmM3gtsn6YSTEzb4Oo11raIsffML38RWR
	BdWPJVfFColmGdrtLZgDGCCzMS5HsMaSCYVerbCPKu/h4Qszc3ELirjltjXcRNaX
	+ums/sBESSAjuzk0ooRwXw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3b4w0rqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 11:23:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBGuG8012349;
	Wed, 29 Oct 2025 11:23:00 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vx3c2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 11:23:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU+9QyeEUoZIqIyeM64Z7dgC/Rq1fqUX+uYuQ0KXnf4nVBP+OMhgUMpm8rDrm8vINuEAdAoYIAZwW8sU9/sWpC6IULy7/UeiQz+Byi122p1ZxkY4cfpEBSRqaDObBzu9M1mpCuhl14+pkE4ZR8vZIq4f0lumQdhXOzkpihOd2hqa2/wKWQkXqP9sFVuaTwkYb6t2tVhENyQK1DP+EiHf146t/i5U9sUJ344Hc6EuOs/f/01JCJwmo9MskNmJKg+/LINje2ORx5B1qhlrFoCxwbieQ3C57Kp0tVVw1mCNOudj53YWvG4tnrdAcQUrz5eo1/LMrcIOUURlL5BrHN4yRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKnqGLttIYVfJHo9rfokAV1b8haZDrHn06rlgOHuY4U=;
 b=bcvY4l3qMBYbYyaW/uxpKmh1MG/9oqfHubeu5t8WJAsYeUNSLmfhCKGOMExmeH78kzylVJUjP4uGyp6flQ1IO8YBwJCzw3mtT7s3HMImiKOVonUtFnhU9KdHYpb3vhQl79MzWODSnebNCct++6znKgVS1/8MzdsGrkwtJLxQ0yqT8lLa6vRm7ne2EqMzEfzoWWVXeEMZ3DxpJI3LIMoABu9FeemebkjdNesMn0PVLwkqLU964QVR8NThZDZ40uZgZO1Qhdg4PD1InljvtcbeA+/+O7VH2MSLqUvqm2/DAwlDwXkNygPOb91tXlTWgJR4Wvj5LE15bIfTHc0AZ33Gqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKnqGLttIYVfJHo9rfokAV1b8haZDrHn06rlgOHuY4U=;
 b=pXWJ33SCl5a6PCR85+AyxCw+Jpac+SV0uiLs5V9Ht0/RHNGbUuDg3m1nmFNGch4qS5kA8QtG3nIAP3/5q2Go+hVtIAtMBIsm6G4Xh46rbZhYssTC5ErdXFpwdaeYAhFWeVyFZJAEAM0Xnm/Lj3oaK6RvEOxuBU0Ad6PppbVXivM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH3PR10MB7162.namprd10.prod.outlook.com (2603:10b6:610:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 11:22:57 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 11:22:57 +0000
Message-ID: <4ad07c65-1d4e-40ad-97e1-a7594a4d0d2c@oracle.com>
Date: Wed, 29 Oct 2025 11:22:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 2/2] bpftool: Use libcrypto feature test to
 optionally support signing
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, terrelln@fb.com,
        dsterba@suse.com, acme@redhat.com, irogers@google.com, leo.yan@arm.com,
        namhyung@kernel.org, tglozar@redhat.com, blakejones@google.com,
        yuzhuo@google.com, charlie@rivosinc.com, ebiggers@kernel.org,
        bpf@vger.kernel.org
References: <20251029094631.1387011-1-alan.maguire@oracle.com>
 <20251029094631.1387011-3-alan.maguire@oracle.com>
 <fb2fd1cd-239d-4783-8b24-66af0e754a47@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <fb2fd1cd-239d-4783-8b24-66af0e754a47@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH3PR10MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: ea34e2c5-604f-45ca-0ce2-08de16dd82e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmFBSXpPbFNLV3BISUxJMndWZGZ4SWxsS1lxU1ZMQ0N0WkRGRHdTOEVPcnJR?=
 =?utf-8?B?VndhL1FKaFpyamRqN2lDSHZTUTRrYWhnUkJlZmNuSElqeWdDc29rZ0lSUW4y?=
 =?utf-8?B?L21PbW05dHhzNExFWTRnYjdUT3VTUGUzNzZYc2wyODZibmlTRnpqSXY1KzY4?=
 =?utf-8?B?bVM2bHl6aWVvODVXdStROHlsY3d0eXQ2SmJwQVVEYmMwbm1vMWowQ3NPSjNT?=
 =?utf-8?B?bGN6NStqY1Z4QnRsUnpuN3l2d3RYdklsMktscU5NdlJlcVNBZ01WbTRDKzBr?=
 =?utf-8?B?UnhVQWxOc3BObmxCbStLSFBJSy9NYmc0T25ua2pvR1o1Vm5jVFhXdjk2byto?=
 =?utf-8?B?cTZYZ3NjRDFhM2dVcXZyZUVqUi9YZC9uUjQxN1VTL3dmeFJYVGc5N1pZdWEv?=
 =?utf-8?B?V1VoWnpweDBua2JKYVJsSHZ1dzdIbFdCeWcvdE1VaUMwWEQrZjVNdXg1V2FI?=
 =?utf-8?B?N3BXZFYzZWNKTHV5MDZQb2FPbWYzM0V0OVd4Q3RhUXVOL05EcUViNEMraENz?=
 =?utf-8?B?K1gyQUNJd3JOU1lhVEVPUS8vWkYyMUtLYXVUZGkrTGk1anVvSFlERVduajNv?=
 =?utf-8?B?NnE2a05nMElCaE81bXJhMUxuUDh2b0NoUFdGV0NROWIxeUpseFQ4VDZlRjlF?=
 =?utf-8?B?NE90MVAwVTlkajkxaG1hWWlQU3VIQWNUVk9STVgzSTRGUWtqZkVrRlJFbW0x?=
 =?utf-8?B?Q2d2ZVloY2p3NEh6Y1hwWVhqOWtSaU5JNVU0OXJuNTAzcmgwcU9yMnA3Z1hx?=
 =?utf-8?B?T211OGdLR0RiRjQyV2NYR1hUQ0ROcDJZM1A5K1VqaGJ0WjlBQTJwM2lXN3JR?=
 =?utf-8?B?b2hRdGRqK2xpRlZiVXdSVk1FWk4yWTdTcHNkbjdIRHd1T0xJUjI5TGgva0Ux?=
 =?utf-8?B?WXBWQU55b3c3K1NxbFE5YmFTSFZmM2ZNNGVRYTBQazFxT2NZQXBObkllaFVK?=
 =?utf-8?B?RVVWM3Z5clh6Zy90V0NrckZJQmY3WjNSazVuMW9TcC9hbXNnS29BcHFvMHRj?=
 =?utf-8?B?Sll6ZUdteDZlelFnMUJXMFB2eWd3UFp2dDlxK0ZIU1ZXN0pYcVZqTzdOM2Jp?=
 =?utf-8?B?ZnNmcDZ0OHUzTkpZVzdTcGxBVnBnSjdqa2p4Z0hkZm05TlU0MHpGQlFZMHdz?=
 =?utf-8?B?U2hOTjJkQlRxZjg0KzI0QkQwYlVXejNCckJaU1JvYTBjSWkvanpiaWxtbldW?=
 =?utf-8?B?cHFROS84TXpkbEJFdmdXRGdnWThBbGl6N2lSdXkzRDhFNXJCeXhla2dzNE5X?=
 =?utf-8?B?UTdkdUE2WFBBTUlDZFRPQXdzMytzVFIwUkhGUEFLQUhmR0hUVEpEblBZeTM2?=
 =?utf-8?B?SVJmMDZ6eWlUNG4xU0lJZnJmeHdCTjI4V3E0eC9iaVUzT0ZjNUZTREZmaGRB?=
 =?utf-8?B?VHcyT09GWHkzUlN0a2M3RnAwdWJpWnRWQ0R2by9YOVJPbWdhbDRjOGl5RUtO?=
 =?utf-8?B?b01nb1ZtT2FqcGc0WU1JMmhTKzdVVENRTmlFeTRYNVRJeVlLS1VaL1d6dUpu?=
 =?utf-8?B?YlBWa1plbW8rUGZ0clYwbDV5ZWk1U1FrdFcxcUx3K1BDTFR0OEVzZTkvM1ZW?=
 =?utf-8?B?RWdDRi9CWVU1V084U21jdk1CZmd0Y1lnb3RSUEFmWWdVQU4yZTJyK2VXZ0VO?=
 =?utf-8?B?anRlbGxzZUJvb044L0ExMitxN1F3SzR0V2JZek55MUo0Z3VjbDVtY1BNYWoz?=
 =?utf-8?B?aWVVUlRqYURlL0ZjUHA1Q3cxRUh2WURsSng0ak0rSXpOb0ZpOU1VTmViVWp6?=
 =?utf-8?B?MGMxbGFDWmFmNUtlak1IUWJQMzZoT0VGSWpTWFBmbXpTejREVzRoQVl5Qmpa?=
 =?utf-8?B?dDFFTHNtUnVNaHJsR0ZNckxMSEJWUFkxaTZ2dUQva25WTndvUXd6aGpOQ01H?=
 =?utf-8?B?Vld4K3ZaV2JISkZwaCttL0RHYmYyejF5aEM2cURla2lvQ1NVMHNkUGx4TVd6?=
 =?utf-8?Q?a7hxkITTcR8t+qh2gIm8UwSSPeNj253Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TElUekpCZzZtSlI2a01EM1loQktVSFIyN3IxWGZUUFMwQTdNYWltUmNOQkd2?=
 =?utf-8?B?ZURPTFA3b2NDWnFmbWQ1V0E0azRpMDlpM20xOXMvWWZsQmkyVkZEUzZsYmRH?=
 =?utf-8?B?elppVEZZVFFBTzZiZXlwVjdqK2ZoYjhVL3RUdEYvN3laNkpZWXh3bFE3MFNG?=
 =?utf-8?B?RTQwK09FMWltYitGZEZDRmpnSE5DNm5GSUF4L3MyMEN0clAwaUh1TU9ocjJD?=
 =?utf-8?B?bDJDWU92RnBNd1RWSkljMjNIbXhBVjVNRDg0NlhqWUNuTmJmd2F4QjhxbmNk?=
 =?utf-8?B?dUJ6RXFYL1RaUm13WkUycjhtK2pLMW5mbmxUaUtYaFloR0RWK0l4Q0Njc0lR?=
 =?utf-8?B?NEFWTFdyV1JRSTBGSXZlZmxkNU9OZXJ5YmQ2enpVanN6dFlIRkRtY05JTWMr?=
 =?utf-8?B?cDR6b09wdWlMQTc3UG02aFB3eWEwQUxpTHdsT1ExK3dtbVhjT0p5WDdDZzBO?=
 =?utf-8?B?c3dHSG9WSndiS1M1T0g4bnU0RVNVQUprYXJQalV5cHNacTNWc1NaKytLNTJF?=
 =?utf-8?B?TlBJRkVCVWZuUkF1WTk2K2FRbUozcHF2SitRYy9ZQkZmMVdsQjZ2N2trdGpZ?=
 =?utf-8?B?N01FZ0RtUjl2YWR1bUt5bG1FZEttUEZtaGJUYUtNajR5YzhmVytqcGRFejRQ?=
 =?utf-8?B?N3hRcEdrRzFtRVR1eTA1aDhINHRERDRtVHJhYnd4U3RuZHNNTjNiUnUzdjhT?=
 =?utf-8?B?dzEzeTYrZTd6eTFWbGVLeW5tSnc0end3S0FNYkF4RHBLWjRlWTd5cHVBSjd2?=
 =?utf-8?B?c3VKZ3ZWUmsrK01zRlZkWlU3ZFhNK3ZtcHg0Sy8xMFVCcElNSGtTSThERkUr?=
 =?utf-8?B?a1BwUDA4cGZzcHNZL2VvMTZkeUwxd2J4UmFMeG9tdnp1S0c4WDJaenQ0T1Z1?=
 =?utf-8?B?bUMxN1hyb3JuMUJLaVU5K3ZMYnlmc1BVWnA3U1ptNmxjTDEvb1BGOXltYjYr?=
 =?utf-8?B?Q2JjT1hqQ1ViaDZNQXRJQlpvTnZKZ3J6amZFMDdtNm41ZmtudENGTWs2YjA3?=
 =?utf-8?B?Uk9NUHlyaExSSklvSFphS0JvUzMzeThZZFd3clhBZGYvWUlUUFFoWWRXbS9T?=
 =?utf-8?B?OG4ySVZmVEREbEd0bE5adlM4dGJQRGwyUEF5SmdOWFovV1VVYTdtUzU4VWZ4?=
 =?utf-8?B?bDBzYnNlN1NNMmpNeE14U0w0WHBKaHVZaUZIL0ZGRnZraEVZZUVOM3BUNmpO?=
 =?utf-8?B?c1BySSt6eVcxL201T2xiZ2lxRjBvMjNldVlLMXFkZUJlZEdDMmJhU3g3YzEv?=
 =?utf-8?B?dkRFMzRlUHNxaXF2RW9TR3dIdWxiOVNnbVpvZnNCSk4xN2JieUhNQ0xaRndq?=
 =?utf-8?B?cmR5SmRydFZKa2FPY0dRZVU2eXdvNEZ1aWw5bUVoQ0Q3R1dhY1FReUdpTDJK?=
 =?utf-8?B?eEFtSzNrYXkrN245RnUwT0VCRVc2TUF3TjJ4V1gyOU9US0F4Y0hNK1hONm9T?=
 =?utf-8?B?am85VGJuM0FzeXNGKzh6NCtjeW5sODFXamgrZWFTay9OYVZlWnZzVDZEdXJZ?=
 =?utf-8?B?dmNYZU1ha0RxZGNGVVh2TkcyWm1yWlNaRE56bk1QcUVCUWc5YUFwNzRQaUpO?=
 =?utf-8?B?VTd5TTgvOXI2SkRBNmNJN0VuTkk5ZmFCbHllMVptVlNieDJrRlpKY2NQWDF1?=
 =?utf-8?B?TXhLSE9jVE5RUzdtQ2xYRHBBWFg0QytiNEFYa3VjSzhTbW1UaFpiNy9KODVm?=
 =?utf-8?B?Mng3RzZvaEh2U2h6bFRpenFEc0w4QkJyWkQvVitTcWpaRTlPR0dUdm8zUzdh?=
 =?utf-8?B?aTArRFRiUCtkYWo1T0ZSd2lJbm01cm8rcFpVOW9nWi9oYVZrWkZPdDFDZ01k?=
 =?utf-8?B?ZVp6OWg5T1VSSGd3cGdCbVZjUldCa0Nwa2hLWW5WSTE2eUpVK1ZmWVNLZ0Ra?=
 =?utf-8?B?NCtrQlJ5ODZqYzBubGNDWXdnVE14NU9LQ2dXZ2gyY2hzbSs4blhxNkNnSVNQ?=
 =?utf-8?B?MnhJYTdlLzZzUU50ZjhFZFVLNXhzODhjRUtpVFNXSWU4MUZQL0xjR0tCRU4z?=
 =?utf-8?B?VFFKeThmeTFwQzhJWFFKalRQQUdYZk9nejBLdEljVUJqaE9CT3dqcjQ0bVZs?=
 =?utf-8?B?eWpwVytoWWw5UllXZ1N0YjVkMHNMMWlUZ0orWk9rQkluK3I1UEhkRTJHRzJq?=
 =?utf-8?B?L2M0YzlkMEM3RWQyQ1RMOTlhYWlIeUgwbHRHYndkVjZacWVlRGpUY2xTa0JO?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KD1/VvWj8NjoK4f7lDMCNGWweTK1PweScPMGdRjc2kbHbnjozQOYJIq/lG9DAOa8tH1HG/jKidXj8XRb5ytgBDIA3ZOBglhmXN8g+kMdKWfwNYD6PwDpXNkE1ggU21wdIyUVn3XnCD23buhmb2FiDI6t8/vsr+hOV6WoDCCNloj76bSQeX2r6y1WS5LgxoFCczFw+j/czQAs8+4WBlHdG6u1x47NOIRRxhbOZWvwppTGI6JDbQUMhJzyPWf+O9FRwWSYqxOL+4UO04E1J7eu/PvoYRO/3X8EEU6AE46/oTHby+UrjrgQcjTYuBHH5fjAzNuxtO2MEAvZ9t23EmRFcA34FLUi0PUuQFcfJl6ZZBEZijnDoKErWsoyVTMKVWyG6y6M7saDAdh8J9Jefi9gOIqZXXBS8u3ElwDN8mdbsFFcc8YEPFikYbslCD+lgP43ecw98NEdiL7QAwwVdoaT+Mgn1AS6pOg6UqLMMTNeAOADWzAjsDhKZ00j66PuF6FJ5JW3z9Gd/SJFON6R6N2jtkFN2k2o6iN+9SPztHHtXNHSryWHddQQZyIYP1kWp9+mpZG19mrtwPRW/+OQ5FMjvLvhkR0tg8R4OSqkyX4ry44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea34e2c5-604f-45ca-0ce2-08de16dd82e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:22:57.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRhYHYrHH+uaHeT/HUqFCebgVnuk2UVnzvapHhJ252Pnt8yDe0q7FBAnqc4oVqSFezK9t7L9fcUeRZ5DNC1svQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_04,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290085
X-Authority-Analysis: v=2.4 cv=R9YO2NRX c=1 sm=1 tr=0 ts=6901f915 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=rbBErVpSFlKNrs3AgUMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyNiBTYWx0ZWRfXyTvxKXYNmfK9
 ZnV0JvJMTswtax6xgQ5Rv6Qw4FAJGYaqnJWQWwMcrHhRZamS+UD7xxNzAPvryFmZzfa7f/5+CRW
 3v1JY7rWH3m+x02f5yiXhvh6OX67ayvs7o4j7gCCpPO2dvPRrJiB2DsbiZDO1/6HAvLoImpoBxN
 wdfblWtQuEeMJXvEKBNnaEdsN7UI5PuCmWlJwKmL/Um5J8n7zAOSksIPzVNqc1jeNzL1EoiH83d
 +Js0ND+GhL4ONUXwtLCR1tuRYiphEf19dZP+39Hzuc4hAHxVtLCluZVVW14Wj0PYcP5aoKOczzW
 7q/7SLXHJeeoGwxaebPGsmkNYb5mlmwPcHPE+ivQ0yv4Wi4HktafnBYagnG20zs7YhDO7iqYiRs
 uQL9zFma1nnCrgeTrIdun3rvphfvsw==
X-Proofpoint-ORIG-GUID: yL5YrsMWQ9yzmDCLgCsegd4ogGlv2IfE
X-Proofpoint-GUID: yL5YrsMWQ9yzmDCLgCsegd4ogGlv2IfE

On 29/10/2025 10:40, Quentin Monnet wrote:
> 2025-10-29 09:46 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
>> New libcrypto test verifies presence of openssl3 needed for BPF
>> signing; use that feature to conditionally compile signing-related
>> code so bpftool build will not break in the absence of libcrypto v3.
> 
> 
> Hi Alan, thanks for this work!
> 
> 
>>
>> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>> Suggested-by: Quentin Monnet <qmo@kernel.org>
> 
> 
> This is not exactly what I suggested, I mentioned adding such a feature
> check and printing a more user-friendly error message at build time if
> the dependency is missing, not leaving out the program signing feature.
> 
> I've got reservations about the current approach: my concern is that
> people packaging bpftool may prefer to compile and ship it without
> program signing, if their build environment does not include the OpenSSL
> dependency. But it seems to me that it will be an important feature
> going forward, and that bpftool should ship with it.
> 
> Regarding the OpenSSL v3 vs. older version concern (from the build
> failure report thread):
> 
>> One issue here is that some distros package openssl v3 such that the
>> #include files are in /usr/include/openssl3 and libraries in
>> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
>> figure out a feature test that handles that too?
> 
> In that case, we should have a feature probe that gives us the right
> build parameters to ensure that v3, and not some older version, is
> picked when building bpftool? (We could imagine falling back to an older
> version, but I see v3.0 is now the oldest OpenSSL supported version so
> it's probably not worth it?)
>

Actually there may be a simpler solution here; compilation at least
succeeds for openssl < 3 with the following change

diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index b34f74d210e9..f9b742f4bb10 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -28,6 +28,12 @@

 #define OPEN_SSL_ERR_BUF_LEN 256

+/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
+#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
+#define ERR_get_error_all(file, line, func, data, flags) \
+       ERR_get_error_line_data(file, line, data, flags)
+#endif
+
 static void display_openssl_errors(int l)
 {
        char buf[OPEN_SSL_ERR_BUF_LEN];


Given that openssl is already a build requirement for the kernel, that
may well be enough to resolve this issue without feature tests etc.
However I can't speak to whether there are other issues with using
openssl v1 aside from compile-time problem this solves.

Thanks!

Alan

