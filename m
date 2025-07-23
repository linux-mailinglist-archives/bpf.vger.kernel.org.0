Return-Path: <bpf+bounces-64206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8305CB0FA98
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB7F587F8D
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F3204F73;
	Wed, 23 Jul 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="glNOLmia";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pjgU/EUt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF9229B38;
	Wed, 23 Jul 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297264; cv=fail; b=FD1K9jdYbvaoEb6jncNQK/vzD9UuyljKzubQg/wi5Ytcq3teGMe5yFf+YkKd8zk/6cOyFA1Dff8wYdAJUofl489qPC22wp4/Im+EUud2z2rEMA7+oOEfl9zmgTHsBWUZxfxAkQuV3WFN+1yeZnB0tY3pYjulJbr0F55HMxhN/B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297264; c=relaxed/simple;
	bh=9jqTFl43oTEtBSFJFpFSsgwFBfgKxeu+PRiOVclHs/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AeU0eSlwXVb+JACM2F45UND6MxKgsQcdgcRpiCc1E9vROiVPekGKnIwa5sZvnBtoa2f6rIyClN1PvVtVzR3zF2r3Gyr/6HkMRhYqSeTxhpVPaOIZnzwHt9Ut9h6edNwYOu+y8NGbGxW+U0WQs0vDO/LYr8UKU5uupS5FcVPeCYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=glNOLmia; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pjgU/EUt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHts8k009413;
	Wed, 23 Jul 2025 19:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n41CdZjS+k2cl2AYUmmN5v+Ib0cGNBbCo3IeWJv1fDs=; b=
	glNOLmias4bjSVfK3dfb6vjTcR6pXrV0ieqZ1QD3wOxm+7L1cFtYPR/PId4/UHM4
	BHVpIyiYiaalan5IgLtyvRGMGpf1T3EVBn7QxFFo4uNhyhM1wO/G1msYu5HtxXLC
	UHi9mPXMHicSX/t7HgRzjg6GjJ4A2rP3cdH6V1nx+b+1rqLRy6ZnwKizt+0EAeOF
	YWhV0Nga+YBds1H40L7HM2hPY37RiGWVlfnp8viWm3Xc0n4mswiYZk1L/MfM6tE5
	Lkc9vttRubwmOWZPXJjj4tEE9WOfM0amQPuMTs76b4aSrDL+/DU86ZdGUWSqMdsb
	dKA5Qfwy5TrucAxoq8A7Rw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2g6fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 19:00:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NIZIdO011321;
	Wed, 23 Jul 2025 19:00:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801taxcqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 19:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMQ4plNbaWKsls/S/hiHxc1xSxi4mW+XYEqErADSHlpayUDRvAT9R7lltcoQAntWYyXOsNdQ0cER2jTqx7+1st7SCgXVsGh0wb8/jr7zfQCwpYckAG6kSHzSGGeGszpeAXcis+twYTWi8dffv+EMJwxHtDmQcGhvqdTPjLAxXdXNRF0axyie0R9DsLQ0ilNUVv3LyGZKScBMTm0WYj1XDO9z/oPjpSuOGoDo99TwYotTSXv3j/62CpSmLdS35Ew7TsKcIKwiYg+b10C2ychJNj+/2m0hTdiXENrq26GjVRVM/Zp6Sw1rmbNR8LIt8WdVsXC5XaazVX8RB21gXyQQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n41CdZjS+k2cl2AYUmmN5v+Ib0cGNBbCo3IeWJv1fDs=;
 b=KI196ul/z+O6WX4e8gmb0JtPOlPDEr7g03P4ahdqA5CrzgwjfUW52PRx1VfAVM4iiJrStBM7v9KHtZI/WgCjNmRIaaId5A43sXMLVct0h9KpsV09zuGFcdIgLdmyglFli3H2T4xlVNzJ4ncyUDC8qJygNYSgdZh/3jotcjr5TtbLXkIa3TTzUex6trrVkNH9zMroyOoZBa8iThZZrqKWXWkJ7TJzi+6ikBQWRrlaRjYewcZWaYwEcZPaUup5iDOiWxvMbSOpfcGfGPzz6BfOBU2M2cNxJFoQa9rWn7AT1OYDoImvTFU6dSBEE755GQWu4H7Q+4P6v+gFwAdOhgNr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n41CdZjS+k2cl2AYUmmN5v+Ib0cGNBbCo3IeWJv1fDs=;
 b=pjgU/EUtRfiNrJ89XTG7NRi6yZeILL/q7z+5lJLYasAWTe2KXq/TRLLOmalWHKuGnxQVU2hkqyr+LL7Jrgks3fuKuCXmvPRL5JXzIrHnu0YbzLJG8CUdk6AcxPiS1f0iWsowAAfbKpFbVhys8lEtRK4jscJPTh1B2RzzYM0/aXU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 19:00:36 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 19:00:36 +0000
Message-ID: <92260366-5a4f-42bb-8306-2d8e25aba4e8@oracle.com>
Date: Wed, 23 Jul 2025 20:00:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pahole: Don't fail when encoding BTF on an object
 with no DWARF info
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <aH-eo6xY98cxBT1-@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aH-eo6xY98cxBT1-@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO1PR10MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: 530e4728-cd6d-4350-3a43-08ddca1b3508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnpzeHlydXJnUkV3Q21LQzA4MjN1a2pNZlZXTlpTLzF2U2tKdnZ3ZzRCTUg4?=
 =?utf-8?B?Z2NyTjNCekZKdGkyRzQyUU8yMGIydGZUalZBVEx4UzhBY0FqYytIKzM3dGVD?=
 =?utf-8?B?OVRKOVhhRXJtRjJXdk4yVE5YMlZnZjBUbGZuYkpWZzJ5YjN2bzVGa0VKd2xE?=
 =?utf-8?B?RmhOMHZQQ3A5RjAwQnhucXllRDZpemY0OXFWS0crWGx0Z01IeW1hSGRjOVVM?=
 =?utf-8?B?NzQzT2lGSU9nNHJlbUVMaEtGNzJYcjIwVDJ2RmdKUmd0SGhIQVBjSkNpY2wv?=
 =?utf-8?B?Y3dRWVMwRVBKSVl4UWp6WHY1VElwa2g5cTdPazNuN3BHR0tkakplOS81S0FD?=
 =?utf-8?B?VFZWZFBIT1ZDQ2ZNTjZMZ2ZveFhRU3R3ejZMSjlrSXhQSWdjdVM3RDliWUQ2?=
 =?utf-8?B?OXlFNE5WWDJOdkZPTHQva2M1dUR2VDRYRm1zVG1Fb2JiNEVlNmMvK0J2aUZW?=
 =?utf-8?B?eS83MGVlZ3JlK1lKU2xQVytHdzQ0TURSTDNZVFFpWXRwaVNNMThoRFNBR1Bz?=
 =?utf-8?B?K1YvcnIxdGhlNll0U2tJSHBsRi9QZ09BWDdQUjhsNmhEM2xreGk2YlR0cUtH?=
 =?utf-8?B?MVNzbHNtMkJDVU11YkhaLzlWbjljWG1KblFIMFJhdk1vQTJIOXo2NkVabUNu?=
 =?utf-8?B?L2NqaGhZSzBIaWlJMG03RDc5MkpZazRRR3EzcGlZL2FqYWVVdzYyajlxL1p0?=
 =?utf-8?B?VXdycGJNRFYxQVZ0VDZjSXMzVWpHcjhRUVYyczE5dXkyU1BVYnF6NVJ5cFVZ?=
 =?utf-8?B?cUNuRlR5ODJaQ1IrTE1icGZtbEdCVC9aRHpyKzdnMXRPM1NoQ3AyMTRGVmNk?=
 =?utf-8?B?ejZVY0ZUOTRxWi81dDlMbk9HRXQ3TmNrNC9EMkNMOXlXY1ZmUWx4UjRvZ3FL?=
 =?utf-8?B?OEJ3cGY2Smx4amNSV04ya0ZEQXhGdTBkR2hSdjJra0d1ZS9VV2NHY2JiTTdT?=
 =?utf-8?B?MHJ5TW5FN1VEYUovMDZ4N0dEUXdBQmdjNytLQjgrNjVCZmUxeUdOTFE0eXJv?=
 =?utf-8?B?OHRqN3JkRjdjNWlEWTdBV0l2cDFzMmhNVHdpL0Q5U1oyMzE1YWJrS3pFZUFQ?=
 =?utf-8?B?VzBGVHZHR3IyYXpyWXBlVTBrbWo3cG5VYW53ZEdHeXpiK0IrWTBNdXlNYUZv?=
 =?utf-8?B?dEYxcGxZMTA3Zm5aNVN2eC80WGhlOVBZK3U3aDdkTldUcllVbkM0L2IvMG5l?=
 =?utf-8?B?MXcvMDdnMC9Sajlvd3JRTlVGY1d0blkrUWtBRnI2TG9qR1VnZXBYY2VmRWk0?=
 =?utf-8?B?VlVuQkZzOHBmczZIMTZ1TFBVaE4rMStIcGtKNmdlV1ZZb0J0dlhCTjRURC94?=
 =?utf-8?B?S1VSVU1iR0M4ZFdRZUlQZVFXb1BXR3BPWXY0Q1dzdGF1TXZhd1c1RW5WM1NW?=
 =?utf-8?B?eHgwNTNacUp1ekU5aGxkR0V6ZEkwL1VpVXY1dHN4VUZLQ1VPenFWdzFLMmpP?=
 =?utf-8?B?T2s4MzBwWkNlQmEzdE8yUmtJYzdNTXh3elNFSzRjd0IzZ1dUWUNqN21UbmRm?=
 =?utf-8?B?NU5HSVN4UWF5QVdZTWgxQVQ4ODJpbFRRTUFoTlFDR2Y2NEdBdW5wV09pZ29X?=
 =?utf-8?B?TGhOejVPcVZyeUVKMDR4a2dzT09OMk4zTUhaVkV0Y3ZRSUJBRUVOcTFJaDM5?=
 =?utf-8?B?THpnTTl4d1pzblIyT1hvaW9Kc3dtN1MwVXRiVktuRVNMNVR4WmpxMTkxNTJD?=
 =?utf-8?B?SFR5YXBZM3V4MmRTbnhWd0g4RDVlZWhUczhtU3crVnVPeXZoS1VubGxHb0xQ?=
 =?utf-8?B?Yi9RNHFYM2NYWmlxd1A3NVE2WFVyNS9Kc0pvUzJPMlZURmZXQ0VScW1sQ0Z6?=
 =?utf-8?B?NzlQV05GME5KNHUveHd1Q1VwM1dVY1VRckZ5R3BnV0wvb3VueUtid0w0VFFk?=
 =?utf-8?B?N3FpdzBmbkNIaEJTb2huS2lCdWhyam4vWTBpRTJxcFNTeHVtbDQ4cVdxa2hy?=
 =?utf-8?Q?CLT5wDVJbG8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkhzbHBXMGZidXBmQVJhR0s4UDA0ekZOeFA5Y01sWEJqQXZlRkFyc2VJK3RS?=
 =?utf-8?B?T2ZEUDhxRlRuaXZmN05iTmllaFpaNG8rckxjQjJxY2xObWpyTllYQi9vaXdt?=
 =?utf-8?B?ZFkvQm5iV1I3cEhkbTlMSDlST3oybVdNSlk0aVlaaDRKOHNveCtlQnJsWWZN?=
 =?utf-8?B?VkVQUnN0UjIyMDBLclN0azRJREo3QWlhWitxYzBVdDZYUEZCQ1Z3bllnOVFE?=
 =?utf-8?B?bUJPMlpRbElNclJnZElYV1FodDhObUJxWXJubzQ1Z1RwQXA1dlRaV1FMcTcr?=
 =?utf-8?B?dzZFUGl0SXZvWS9ROUVRd05Ya1ByRXhXcEJUQWI2cWNodjlUcCtZMU1ENEhX?=
 =?utf-8?B?UGFtL2oxNFhSOVJUcXFPTi9KVjNkWTJoM1o5SVRFdXlzNXIvdEdDRWg1YTJT?=
 =?utf-8?B?VHEyUVFTMUovaWZKK2NrYStjL3E3czFIcU83UHdRWEJlSWovWTdNbjVKMFR0?=
 =?utf-8?B?cVJOb0VhVU1BWVREOFlhS1FjRk8wRldSSlBacUlvMXFFRmp2bklZR3RBL0Fx?=
 =?utf-8?B?TUVHbFU4bHl2cUJiaWNNV05zbFBqMzYzYjh3Qk1mVU1pZU9pZE5wL3A4SDQ0?=
 =?utf-8?B?NDlrdmk5Q3ppYmNFU1hOYmZwbWxXZXlLdHZZWXQ0L3dBMGM2TGtBNXp1U0d0?=
 =?utf-8?B?S0I3aGtQZkJMbnpJN2FzZjcyc2Y0SytDZmk3YVZ6ejFBNFh1dHJmV28xZ3RQ?=
 =?utf-8?B?a2tpMGdrS0w2UEM3RWZjOURvclZsZWM4RmJRdGtOUCs5T2R3YVhWcktmcTVy?=
 =?utf-8?B?UlpFaUJxZk5xRklIWjdTTjlQa3l0Q0VzZldTbk9LQkNlVTkveUtoVFZjWEJT?=
 =?utf-8?B?SzFnWDRoS21MVlZJTWU2bDJhYzdWUnlQOTU3djVvWXgrRG44YWkxVnVzckxP?=
 =?utf-8?B?UnBJL084OUhwNzJjTHpoN1g4NmpVUjdPZ29VSFV6a2hhK0l2ZEpsL0NmWkF1?=
 =?utf-8?B?UDlnWjE1a25US0t2K2xWT1dUZ2VBOTJEWVhJTlpTQ2xRTFVuRXpKZlpuWlVX?=
 =?utf-8?B?YzEybWRVcGlKdUNYSW81Q3AzeCt5ZStLYStnMkx4T3V3SGw4MVhwb3FWeVJi?=
 =?utf-8?B?TUhlTWRKWnE2N1pDTi9mSVUyVmYwb2tyVzJjNXQ1SW5QTEQ5QVBBQml0ZzNl?=
 =?utf-8?B?RWVQeE5Cbk9NZWxFSmtTWE1qZnJRb1IyazZCSU9GUEpEVXlWT25Oc00xVWJW?=
 =?utf-8?B?TWRLeHM2MTN1NVVqb3FqSi9RTnZ3Ynl3K2VCb3dYY2MydStJNWUraHY5dE5L?=
 =?utf-8?B?RzBjeXNtOEdNaTlZTXRSakZNd1g4V29wdXk1ZW5rdkdPUFpIQndVdmR2cDhN?=
 =?utf-8?B?QlFEaVhXcDUzVWtVeHdZVUdhaTR4dm9LWlRUTWkwdkNHaFR4dGZYeDlrM2lB?=
 =?utf-8?B?ai9xRElCNy9YNVMxaFQrU2JmaGRqMUcxUmRsU1FIZ2I2cG9LbDJZbGJFOFFs?=
 =?utf-8?B?cHFsbkN4TVMweWJmVm9oVDhrY0h2UDZVUzlPUmJ5SktwL2t4MVpEQXRQWFpE?=
 =?utf-8?B?WE5hYkxxTVVWNUErTXlZOXNjTVJSTW5OZEJmeDdQR3ZzUEp1Y25jd3ppWXRk?=
 =?utf-8?B?ZjNOdXdrNDBQTnU1YzloRzVocVlUK1gvdi9TWWFRNjBXT1UyY2pLcGZBeDh1?=
 =?utf-8?B?TkdTNk1yYXQvNi9US2VvSlBvTy9jbzY4RGRqeWRHUWwzUG5TMzdzZktwU2pS?=
 =?utf-8?B?SXBPM3ZobUJxMlZIb1psL1RYS3BscXhDMGFrbHhHbzRSRXNwZCtubldUSnFP?=
 =?utf-8?B?S1cwMUtLYWh5dWViNzNaM3dNUHFFMkt2Rk1FYlc5K01od3hrZDl4NGgrMGFa?=
 =?utf-8?B?czFzOEMzQUtrNHNZOFQvUzYySUtvazZiRDB6ZmRPcTdKWTJaSGlxVVp2c1Z6?=
 =?utf-8?B?U2EvbjhzanhKS1lGN0JCUXRTcUFhNWpwMjFySytJNGRJVHpiSklMYStIbmRp?=
 =?utf-8?B?ZkJZS29XUDRYbTlpSUtyUVVhUUVXejBKcmlUZ0lzYVRwd2x6WngrM2EwYUhK?=
 =?utf-8?B?SzRoTWNoRTU5OEY1VU1jemJqNnFEeHk4WWRyT0h4WDFZNHZFVTNqNEZEcjdJ?=
 =?utf-8?B?UlJsbUhxQ3hnMCtwOVJ1dUtiMVhiVk1SaHRKQzhWZTJpelQxTHUxMXNZWVRY?=
 =?utf-8?B?TTRyWnQzeUtUYmZoQUFSd1FXU3dGT2xkWUNyTFdUU1FjL1NDVXZRSHdDOS8z?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ym+ZpvhvCy/3UtpvNak+FSWmNRIbbpQ2WOwN2mCENQmoAF74eVKYHziWg57qeS8LEYp5+K6Ed+s6JT/Wsi+ikUOeJK4iTtepeSxLngIROg2eJJagx7wzIMNuAEbIJqqfKaesBnqVmkE+jkeWRqjfAjwXV5ZlAXZD4tPydUow9FOoobwhfdoWbsFoD6jdtUc4413RlTwYU4jSLLme4ftFuqCPBySrB7iINH+5M9Cp2ohpdaMEVqPadRp+iWyQ+LzPyAu7BiPIjPEREwFu0J16Hztv3XFDzSay6Rtdlglaco4Sr8DxsaEmCvXl7d8acx4mkOFzQ872ZfM4bz25wxPIFlEqOjiXyhlAb2qo2VoFmK4zG1vjZFZ21mq39gWgABTR9mjBPW+UG1hYaUGkzgWMLct6fxq1YuP8SRCukOaDQcLWFMvJxTtDYMzKubAKAnb4qcQGwNYshGa75ENPD3xR5HaIV3DzcWdtFniRcvnYx3YJw/ezgCFjYXEA+zmElvPlNjLieKzjmETfYWh+/z0IDanXAgH+mZ0ZbfNog+B4U3A6VbUabQM+tgh6o3uneRYmXAIE8JdSNZ56HnHo+2IWWgZHPh2Sq3HDyszsbHW+k/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530e4728-cd6d-4350-3a43-08ddca1b3508
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 19:00:36.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4jnR3iGqgOy9Fdr3pLrRev/LO1XSoh1pFd5TgfEEpUXDOvydShCNseZg/Sx2fYSuTnTF+CLO+sutFLL1UyBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230161
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=6881315a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=MkEcOnKYNKi893rJUBMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BZx7sGLHMuH6EzTdnabEd7lSC9Dsz8Cz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MSBTYWx0ZWRfXxVXtnD2I4k7Y
 B+2pNxKs50pjW//ws3TVJ5RJ51wen5ulV6MarckbRLFXnXilfOZb9NeTqxSj3Fe9xkJepkW2d3y
 5cPxVZcq6WbFeU0s49aqA7BHS9TscexLZAMIXo18uf9RDkfm680lBKY2kCOO9orhmbiU6dtQ6CE
 sc15WrgVccOhSbVQKar3OPc+/Bv6lP8LQl/CHCF2YMhO//s8Gy05PwOKe4TMvQvYfLCie/QEXF/
 za8FX7uCAhSNHoF2lryeGyCWs8zm8CVDTp9XgZ7V7Fy4UWvgWP7/9zk/zbTImXYNVGEf14Ah/ip
 pSk25rnqNqvSusR2OOYc/wIB2Zc1Zip/ei4OfVUW3J7GpsyFtVXp5uWt+fJ/wJFRwzriEcxLFTJ
 m+wPU3Bqbtx2M29/Jn5Zgzhh3yokixIkDIaqURTfpHLbQy+IuN6xFpKZudbW0+pqllDWk9PT
X-Proofpoint-ORIG-GUID: BZx7sGLHMuH6EzTdnabEd7lSC9Dsz8Cz

On 22/07/2025 15:22, Arnaldo Carvalho de Melo wrote:
> If pahole is asked to encode BTF for a file with no DWARF info, don't
> fail, just skip it.
> 
> This is the case, for instance, in this file in a kernel build with
> DWARF info generation enabled:
> 
>   $ pahole ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
>   libbpf: failed to find '.BTF' ELF section in ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
>   pahole: file '../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o' has no supported type information.
>   $
> 
> Before it was failing when encoding BTF for it, now:
> 
>   $ pahole --btf_encode ../build/v6.15.0-rc4+/arch/x86/purgatory/purgatory.o
>   $ echo $?
>   0
>   $
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Only potential issue I can see is that in the usual case of encoding BTF
from DWARF in the kernel we'd probably like to fall over if we can't
encode BTF due to DWARF absence. However current Kconfig dependencies of
CONFIG_DEBUG_INFO_BTF mean this can't happen in practice I think so

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  pahole.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/pahole.c b/pahole.c
> index 333e71ab65924d2c..a001ec86ef1b0908 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3659,6 +3659,13 @@ try_sole_arg_as_class_names:
>  			remaining = argc;
>  			goto try_sole_arg_as_class_names;
>  		}
> +
> +		if (btf_encode || ctf_encode) {
> +			// If encoding is asked for and there is no DEBUG info to encode from,
> +			// there are no errors, continue...
> +			goto out_ok;
> +		}
> +
>  		if (argv[remaining] != NULL) {
>  			cus__fprintf_load_files_err(cus, "pahole", argv + remaining, err, stderr);
>  		} else {


