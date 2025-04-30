Return-Path: <bpf+bounces-57047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D0AA4EE6
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BE99E0B9A
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1EA219314;
	Wed, 30 Apr 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfGgfY+4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bWjf3RXE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7A2B9A9
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024053; cv=fail; b=CLupLReI4xTfT6BFruUjD+uCJ/3ZatjJqVme8QAz8EAV3Rbqirpc4ouUhs05jMir9dObRh0qj4PAti9cQmU7HjistbZMgK46A3RYJo5n6Fccnou8BUQEQL1+UwHon+uoZiYQcZWIwKprW9bip5wgZpEpqM80vMMe/CwBMEKGWn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024053; c=relaxed/simple;
	bh=nUCYvbJws6KW2xiAcxkGnjlBKuzAQUNXOBPlH3ix37o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oOpqmHhlpnCncDdvz7amC5JXF7IWLCoS2nqn6sOmIIvf79d3pffE8wkWaknbOmtp1m1LZXmVjjNHO9efQ1jot1PQQCQyG83/vpGCHx0vwbZNJrOaqMyZKz8juoJMW5T5W2rdWUJWDLyCFFN19DFJGQ2BedUaVMwyiMn4+lESW3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jfGgfY+4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bWjf3RXE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDaeHR015098;
	Wed, 30 Apr 2025 14:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V1moHd6ofJ6uXjkNEFguvjCOvw5ai3SHj62rqkdoGZw=; b=
	jfGgfY+4czhVHJs41tqufyAwfYB0bTayf7BMof6OpZebaxxDbns+zB/q3pYSuVjk
	cqCKtXyF0GzGavXE/5RGii7uCv/wZKGtpk8mrxHRd/vMYvd1XvOjpoeAw/XRtvXt
	WNBmsuClDIQooRPVZ6LysXa2iz/Tdnfy85Cgws6loZIHebLX991aXIAWnMg9vXyR
	BensiQ/S4PWdfZQEYAoMelpysIQG1HMOIsI4+ofV7y4QieOU6g7HSZOi3K3RS53m
	uFntRDWQmAlxJ/3CanyFy7csMgmV5lh1uvE0xUPPIJn2wMNXSFHsZtsS8gl60Jkr
	lmw94omDvO+Xpczzcd72qg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uchbht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:40:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UENeNI011340;
	Wed, 30 Apr 2025 14:40:19 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbwvj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJGii84e0LW7sDqnViENUXEKiW215njxoeAO6BviAS/qO48FJ2cWpoVA9u3RXeAlrd+GegDOlTe9hv75UNTJfseG5l9aA6r2yn3qY/OzLzkdDQDpIxchcwByvBVnodUiTIGYUXw6MBRTQ1B7kkLInwzAImI5JFqLYHn3ZxnkN55yroNuOVZb9Afg5VxM17PKdrpvqbRqF7cmcSDlXx4GRXimYEw57sev8pe0xDKH24qEn+r5Ou5iix4WlvFKGZGgjrwnj7hLhx4TT1NXzTLAz7OEgJicXkxAbqU2rMZXcnvFcGr8eMM7C/uz/0757Jq6yGS260kmaGLlTHRjZgeW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1moHd6ofJ6uXjkNEFguvjCOvw5ai3SHj62rqkdoGZw=;
 b=BXycTAkrlsfGhQXP24UMbwGtlkMkduM4gGwyE6BXbUDNtMb+bp4bF1+v8mtRgTrgKwmNfGWzGP/666oqb3oVyp9mqN0p/HpBupCuTxaPEq5zE3iiscfKhmaSaL1AmzFUzGyfwVxO4LajKj3U7Wna6Eoyg1uBL1z710eq0F4F6tp/Z/g9vwdWnVgwGVAP0DQ4jh19XBe4IRjvJnxp1OkNWbLB62wQMh6MZXpx5qEerRGN0QX7KUXZDaWZHih2piKKY3J+ueGc/w4PsN4Oms3MV+iuHeBINBSO7IFLhOdmjtHpQOXtkH+2dCFElW0daZu9YHI8pM2aoVZ6HuXvzB90jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1moHd6ofJ6uXjkNEFguvjCOvw5ai3SHj62rqkdoGZw=;
 b=bWjf3RXEOt5FXX/+E3QkrSFUji6XvrdpRhV99GKonu+kabyNR20Ox/LaqbZg6YdmARHNp9toLNLSmiOgSAUbiidYwg7MgApGsDx3U6y6kBS2pRdZHZe8A9kaDzK85ZsA8rUZaHFD6f4mKupEsUd3VzskUKo3rnN9dG8XZiesPPA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Wed, 30 Apr
 2025 14:40:16 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 14:40:16 +0000
Date: Wed, 30 Apr 2025 10:40:12 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Message-ID: <rp3izx7uzdwzn2n4z37yaeqff7xkmz2xbshlqmgy2d5ucuzpeo@wfel6273tlg6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: QB1P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::20) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5ab76d-1427-43dc-8d05-08dd87f4ec04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1dydFZjbWdlSm1qSkZ3b0JmalM2cTlhRUk2clV1Z3NHZWF3M3QrSFhwSnkr?=
 =?utf-8?B?a0VJNkhjYlgrSWdZdWhqMmFRMzY0dVpxcjVsbDArSHVvdXJPQkxTM1BxKzZL?=
 =?utf-8?B?SGJLTzlSMVY1N21zN2wrTisvOHg3VDVhN25SM0JWWjZnVW9MSFFLNlB3eGJB?=
 =?utf-8?B?MnAzVjhmWkNVVXJobjFBbitzVFpNWm0wS0tURW0va005YWJ5UDZ6ekY0d2R3?=
 =?utf-8?B?RDJZL1FQSWk3Z3lmajdxbnkwTU1UZ2xkbm9HTFYvbjg5QTBHQmVzeVBkSFlG?=
 =?utf-8?B?SWNyN2o0R3B0NW44Vks1WVRjUXdZWjN3WS8xNTRRR3ZSMG1mcjdTQW82VEhV?=
 =?utf-8?B?QTZMSmVoajV5M05nQU5NRlJyRDUrQjdzSDEwMVZ2UEpKZjFDVHdXZCt5TzFT?=
 =?utf-8?B?c3NzRDZoWm1tb0pYR1hheUtnYnVvYnhQTUMwME9Xa0hSK1A5RjM2R2VZQXVV?=
 =?utf-8?B?MllpU2t3V3BrUU5hUWdwZEExalZjSmVtay9JWXRRVlE2OVlodWlFZUxBQlZZ?=
 =?utf-8?B?QkowM25wOEFJTGNPUVA2cXFvci9GZE04ZllPVGRSVVg0MDFMTk5DUURYSFlE?=
 =?utf-8?B?cFh5eURrZnViTEFxQUZoWHQ1VTVzdG9yell0WWFieEg0bEhQMUtyN1cvWStF?=
 =?utf-8?B?Zm0rTkt6aktWRnAyYzhMb1Q1a2NrUnFMWmVndkpVczdxOENZbEFHOFNMZjN3?=
 =?utf-8?B?RmREQWQ1bmd3SjlaQXVTZVpZVVRhRlQrL3NJeEFFR3ltbFEwTjdZR0lzd2tE?=
 =?utf-8?B?dGxVVlRRbVVDVUF2dWNUNG80Zmp0K2lneitrUHJTOVkvbjF6cXhZRXJtTmEv?=
 =?utf-8?B?MEgrNExQMFFETUhNUGVwbDN0VGJoTm51Z3Y4Qk83YzdVdjFHKzMxMEkyRXlI?=
 =?utf-8?B?TEJSUWlqUFkvVll4bXQrOXNNRGU3QzlEeUVYQlZPR2RqaEF6MWx2WHRGNmpZ?=
 =?utf-8?B?TjZTWURRVUZJYXNMSGJqR0tIbGhRRGZEWW5JRGphMHVpNU10UHFybXJFY2JF?=
 =?utf-8?B?WTRJUVpsRTFuUkI4b2t1KzlmMG1NRE50RzRHQURSckNUbXNRQ2x0TXRYeWU1?=
 =?utf-8?B?ZVZubW50SzZQY0JoL0JvaVk5M3cwcmdXUXhJaEZ0aVU3U1JqcUt2V2NkWlE4?=
 =?utf-8?B?OVNTc3FzUkZTcjNCYldINWIrdjNPcE5PTXhVS0kzWXpGWlY4OENCZ0trby95?=
 =?utf-8?B?Rm1EOXVlblI3cU5pb1ZJSndVUURFb0IrQ3VsYWFvU2ZLRFByNEtnSXFVdEMy?=
 =?utf-8?B?b3RFbloydU1icEVJZjB3YnVML0haUHZBNDIvcVo2ZmMzTWI5YThyTEk0VTdC?=
 =?utf-8?B?NU05SkJPU1BubEhvMC9vNVJNa2FIa1ZlelJFL0l4YjRlVTJlVzh3ekVrWVpB?=
 =?utf-8?B?dmpJZ2dLMms0QXRXeTc0SnRHamoySGxHam01bFJWTjJ6ZnhMNjBEWDJWaVB1?=
 =?utf-8?B?K0xEc1Q0OHN2MHNLeDQrUkJpZ2dUUzU3NHFNT0dyY0hoN3Z0aUZoNXBvR1Zn?=
 =?utf-8?B?QVVrS3hVTHRkbHBTS1lCTFZFN3pZYnRTdVoxdFExS3hUNDhBd25pL0VXNXlw?=
 =?utf-8?B?RG5YWTBHN1hXa2ttbTRldHFwUzVxb1p1Snl2cDB3S2w5UXVUSzFpdE9DcGZN?=
 =?utf-8?B?QndwR3NiSlRxd1hIcWpZYkptRzVkN3RGaE9sNlVEQWNPYXVTQTRpVENkd2Z4?=
 =?utf-8?B?WjZQd2gzenJQN1ZLWGlCTk1rODAzeUJzSUJkZng0ZXVkNmNpb3ZSMHFKQnBN?=
 =?utf-8?B?alNVb3VqTkVnNFoxNEQ5NU1jdUZRWXpjMVg1NzEvdTVSZXFMaWhraHBxb2xh?=
 =?utf-8?B?clN1ZnVodTJCTzhnMVdoSEptWHJFQ0xEbWs3OU9MY2JaSUpxcGYrZGs1bkN3?=
 =?utf-8?Q?vtny6y8yddVE4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlJLZnFlMlZDQVFqVHROdU5mN0g0RHNQd2I1LzZ4QlRsRTUzRWRrTkp0THVT?=
 =?utf-8?B?QWJocHNCZTU1N2x6S1dvOXdlWU11Q3BBNlBLQ1pvNDdkOUd6ckRiMnJ1UzFs?=
 =?utf-8?B?OGJ4ZktpTDFZSXltakxKK2MwWm5vR0FBQ0JnNlNPT1pPSUNOMjQ3Qld5QUpu?=
 =?utf-8?B?QkJPUnJMb3c1aUlmWnE1Y3M4alFOempaWVBReXFuM1dRVFpwcWw5RHdBdlVo?=
 =?utf-8?B?NU1zcmd6UEZPbFE5SlZ0aFdEZ0dTVmlXV0w0WlVRR0xhQ3NySG1OUWhXOFBv?=
 =?utf-8?B?ZDVubExoVWpRNTlzY1hBb3ZjNEFvNTdwWFJmN0RzcnNFQ2psQ2NOaURhVEpY?=
 =?utf-8?B?TDFDMXFKT0FLYnFtcGVNUnJwT29FcnFuc3RFUzNYcy83SG92SlBCK3gwTDFT?=
 =?utf-8?B?WkVDWVh5UHZ6YmFJZWN3eXpHUDIxaC9QSWpwVDlGdmlsc3c4dklBWmxqK1Jk?=
 =?utf-8?B?VkVEcExDcVdUamk2YWNrczJwUTJjNy9hTlR1bkpqNSsrb3ZycHhJYkRBQk84?=
 =?utf-8?B?b2M0bktIcU5xM2dQUGZTaStJVUdvS1BIb211UGlYNDUybEwwTWtTY0oyNXJD?=
 =?utf-8?B?dHlieWNpWmFIdUViNTdPWjNaT3hUOUZtb3djeGl6amVVQlAvNEFmaVh3aFdk?=
 =?utf-8?B?NExyT3pxYVlNcUwvUWJWcmJHZUhKR0FOVncyR1ZlemovZFVpUzJzdTFzVnJs?=
 =?utf-8?B?VStCNjdkVEI3R20vcnFpNVlsamUvYjBjc285STFuSGpMWHN2Nm01Z0ZpN3ZO?=
 =?utf-8?B?VXVHSU0yQ3pnNU5iRGczSGJ5OUx3RHd4aGEyWFJTYmhlbGxvUmFkbXFaUWo5?=
 =?utf-8?B?Z1lsaDkwT0hWOGZZbWtwb05jei9odysrU0VmVFpOdFlHTVdrVHkvaU9qMWhS?=
 =?utf-8?B?N1BXZXJ6ZmVsbElnWUhYMEVKakFibVR6dy9LNmJLd1RPcHFLVWtsSzI1c2xz?=
 =?utf-8?B?MngrcVk4YzN5SDdJZHY4NEVRRVZDS1VUa0dER29VN05kdFh6TnF0K3ltb0NJ?=
 =?utf-8?B?ZkRydkVHSHRpRGl5MGNSTHlLVHovMnRSamlVMkVtVHNOdXlNMjdwcUNYZ1Zk?=
 =?utf-8?B?dEZvK054ZjUyUGkrb09hWDh0OE5NOXB0NGlyQno5RWh3TGtxcFlUMXVWWTJC?=
 =?utf-8?B?eWJLWmtad1ZxdGhHR3lWSmg5ZXEydnBMV0RYdmQzVVhyUHBLcGd3cXBKYS9M?=
 =?utf-8?B?SjM3UjY3dTVTa3pzaEIvT0dRQXNsODVLS2NMOXNRR2c2RjdDcnYxYlVESzZ5?=
 =?utf-8?B?aHBRVTg4RUhHVUNvWk9mL2M5MEE2eDdrSExnV3hidHpBYUJTOVZSL0pzRlIy?=
 =?utf-8?B?ZnkwbWVEeWlGYzRoQVV1SEZ1OTFaTWsvdTk5U0xJSmE4YnBvZXlLUWZNZ0NJ?=
 =?utf-8?B?VHN0QVJWK3lMVW9EM1drRUlsT0ZBTWVoM1FMVW1XKzNPYSs1R20zaks4bkp1?=
 =?utf-8?B?R2RPSlJpaGhnK3N4bHVtNndWd283eXpNNE9pcGlyMmRpa2pXZng5c1ZvZ0Ur?=
 =?utf-8?B?RndZU3FIdXlMSGtqSWZXN2lxWUNmeW1BdlpjQUh0dnhRbm9hcFVQVFB4cmtF?=
 =?utf-8?B?VnlHY0c4MHV5cEt5R0N2U3YrcWE4YWluN1RuOTcreDI2d20xb3RFdFZFYWdo?=
 =?utf-8?B?UWNneW5hdDhVR09UU0xJRnBsSzNQK3VQdlBHRTJZSUhGYkVtUU5mdWxOSTIw?=
 =?utf-8?B?RTNmbmg3OTJreENEV3lhYkRPUUZQNFBSNU5CK2RHNkxlM0FHZ2tmWVM2b2xv?=
 =?utf-8?B?ZFFQdFp2R3FleSszd1ZzRHU2eDhyQS96ZlRMVEFvUjlYMlB6dkkvY1RjZUhI?=
 =?utf-8?B?WlJYVENjbjh1aDlpZnJWRlRVeExxcmtYdnlFa3UzZjZsQVNxSjJReTcveXVx?=
 =?utf-8?B?QWZybDUwenphK0pvb3B5eXg5Tjd5cUQwdWRlTGpWSFJYaFVIYWhuZDV5Rzdw?=
 =?utf-8?B?MGZoMVdXaTVWaHFxSXE2cmRmOGV0djlsSnJtUEEwOC8wTzNpRkNOS0g0Y1pY?=
 =?utf-8?B?aFdtTGZwRmtWcUxiQXl1SXR4RjhRdzRMOGIzVXFMUUlOcFFBZ0pscXJ6NFBM?=
 =?utf-8?B?YmFpaWJmQmErVnB4aitsZ2pKRUNTbG1kVWVKd3RCNHdxLzFGQ1FWQWhLejhJ?=
 =?utf-8?Q?B9+bn+DAjjyNTIJ2qyJVXxLt5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ET+GKrITPxV1cn3PTJfIkUdDn+qUPSbpnknGTNxkhkQHCtMlMGBQPXjLE3iKREvueVlPgTgwsVrWshfgPArKKpv1v3H5REd1pVyVtsd0XuHLxVgdFdIQ/nlTdNQt12hs3JrSfNrrfNqCLtqPZCDsuYmvpDfqmda8ANwV92Q+iIZfsHc5GMm0iL8/04ZIGPNM8IC3YDGpioOOa8Uck5z1n1gib0dgJaQvMso5pcn9xuXfS4QIVIIGByvqGbBuhmCf4XQXuqyY17BL6IiU+Yq0cs5xk7zHC/z3UI8fIHXtWL+Q9ylxQNKtv/TsASXD19v3kIjrl7A/6u2oN1enFI3Uz3h2AwEhrvuIKjVX4WPoxftmBOzsNGpYImKUC4vTsfEi7BezuvhjgLAnRNbWqvEBGqlGtiXFM9Ss/StNpaD1/9Q04Phlf62HXfyb9WCgTDfOP13Un3YcK94+TIX6R6hNjXEuFkmZWQdEx0fEZfh9pMcG3S9CQ12DmxndnPl+3BxOK01KM24dY+NXmBYJjSMsJz0IJhsZh320xNBLBupVAsgEcHTPGn+7Xdlv0/QyJr7Vws3QnKQgpjf68cB1+/68MJhOaBIDfkfNOgMhT96O5TE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5ab76d-1427-43dc-8d05-08dd87f4ec04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 14:40:15.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8K6n43Yfqp3XKI5AG2Mwr1eyZlzV3Pss7j+n4kYgnwacXl9FZoSfLOeGcXKcc4GCnoPTAjVP3oawX+PYi82k2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300104
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68123654 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=h9cJggwTAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=PDs2Jr-0MM81pTW8qpYA:9 a=QEXdDO2ut3YA:10 a=6PuXB5fa8CYA:10 a=EXRrQ4ozpKHqEvxYJTTh:22
X-Proofpoint-ORIG-GUID: iAjriTzprZI0_wzWuFLOhDnrCIKmxWJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwNCBTYWx0ZWRfXw7JOgKMoeRbp CB7WSYDBL4c6X80i9HW44ekbydE10x5fxCeYHoUU7gOsy2su66eMM/2jbI9gcLyU7iEurz8MdpM tmepUYlF1fFsyOlJreHgi1lcWp4maUTWTR5VBr/hw45l47Rrwzohb78iz0ETJrtWaLd+OGqrsYA
 IKmFi2g+fzplqxWmIrttgVtH85aaKjAoVb64CEImjKx1QmhonIRbWzknvDchSUzJNHTBQtUbbl1 EMCbvZVJh8nNggCKz3ly8B56Kl3lYIrib7YHGA+TpM9gOPZc4LGHW94hcFXDa48XvvoRneY9a1E 27Z8p1pFDcjaZH9KHIVv+t4IhyYiZzNysoUxqC0wIbafBnmgnIorwMVvUJxRpLZscoSFlObYvgH
 vZxv+Kl/RhG/8/mA3lTDWtxPMPwyDg8gIpJOUH7S0lvTrQ6LGvm6hCjLp9YWoUTr851/8qAp
X-Proofpoint-GUID: iAjriTzprZI0_wzWuFLOhDnrCIKmxWJ7

* Yafang Shao <laoar.shao@gmail.com> [250429 22:34]:
> On Tue, Apr 29, 2025 at 11:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >
> > Hi Yafang,
> >
> > We recently added a new THP entry in MAINTAINERS file[1], do you mind c=
cing
> > people there in your next version? (I added them here)
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/MA=
INTAINERS?h=3Dmm-everything#n15589
>=20
> Thanks for your reminder.
> I will add the maintainers and reviewers in the next version.
>=20
> >
> > On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> > > In our container environment, we aim to enable THP selectively=E2=80=
=94allowing
> > > specific services to use it while restricting others. This approach i=
s
> > > driven by the following considerations:
> > >
> > > 1. Memory Fragmentation
> > >    THP can lead to increased memory fragmentation, so we want to limi=
t its
> > >    use across services.
> > > 2. Performance Impact
> > >    Some services see no benefit from THP, making its usage unnecessar=
y.
> > > 3. Performance Gains
> > >    Certain workloads, such as machine learning services, experience
> > >    significant performance improvements with THP, so we enable it for=
 them
> > >    specifically.
> > >
> > > Since multiple services run on a single host in a containerized envir=
onment,
> > > enabling THP globally is not ideal. Previously, we set THP to madvise=
,
> > > allowing selected services to opt in via MADV_HUGEPAGE. However, this
> > > approach had limitation:
> > >
> > > - Some services inadvertently used madvise(MADV_HUGEPAGE) through
> > >   third-party libraries, bypassing our restrictions.
> >
> > Basically, you want more precise control of THP enablement and the
> > ability of overriding madvise() from userspace.
> >
> > In terms of overriding madvise(), do you have any concrete example of
> > these third-party libraries? madvise() users are supposed to know what
> > they are doing, so I wonder why they are causing trouble in your
> > environment.
>=20
> To my knowledge, jemalloc [0] supports THP.
> Applications using jemalloc typically rely on its default
> configurations rather than explicitly enabling or disabling THP. If
> the system is configured with THP=3Dmadvise, these applications may
> automatically leverage THP where appropriate

Isn't jemalloc THP aware and can be configured to always, never, or
"default to the system setting" use THP for both metadata and
allocations? It seems like this is an example of a thrid party library
that knows what it is doing in regards to THP. [1]

If jemalloc is not following its own settings then it is an issue in
jemalloc and not a reason for a kernel change.

If you are relying on the default configuration of jemalloc and it
doesn't work as you expect, then maybe try the thp settings?

>=20
> [0]. https://github.com/jemalloc/jemalloc

...

Thanks,
Liam

[1]. https://jemalloc.net/jemalloc.3.html

