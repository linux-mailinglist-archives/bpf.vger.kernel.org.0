Return-Path: <bpf+bounces-77183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F9CD154E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24AD6301A97B
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54913612ED;
	Fri, 19 Dec 2025 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aji6JMNn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e/GmurBD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CED35FF6E;
	Fri, 19 Dec 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168141; cv=fail; b=CWe+mj5YpSdAvwpzGv68Dvug1/3CnoBvyqRlfOxxkYjEkBbVNCSJjUq04UiojRLkzqQQFWajHoUIJSeiQ2vsO4pbqL6UEuIRMbHBReO20ptq/vpaz6m0EoIzxZpnWZJD+KYXGp+Cp9mimxWxJVp2MCteSw3DVG3MuYBUaOSc7vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168141; c=relaxed/simple;
	bh=Dc6FYnVHTExqNZVjMw9hyyLNSqT2tmuY3emdficX7Ec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VAZMqtnZZUgHfnPcgojsfgTdMLiHXNYi1j3pA27mUmgziUVFBz8vOKB7x8vAKaN1tW8WQC/MYKUZI3bAWqDMG/dTuB+Ajiji9rssQVqrrWAEuYWVg9p7Cq7meCbAmmiRmlqw1Mf87v4rVHz5Jk5Y8I1mHIxkN1eslPQlOF2KUU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aji6JMNn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e/GmurBD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJHvBWj4146851;
	Fri, 19 Dec 2025 18:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e94eOBBur0glUQtob+DruhcQH2NNACpaRrS/P5vGfRk=; b=
	Aji6JMNnYZaxAMn18AVtXih4GfJFCUdVWFKWMA9GeAyJBDZO17s2hqZ7iHE4Gr/Q
	GsylolIoihCkz5g+K/qO2ZkEaXmxjzm+0w6H5WFCjtmdVwXEq7geUarRv86ctxvf
	EjOnsjnOcv6VwvqnXcPX6kI74EJnvmGtKGGMA4wN3LQj/87Dw1hygeLL4N/HXyRb
	eZKbfR7Rpgm2iXjJO3P+LL8iNyAyQXBw7/iHahYLRWtmS3wAe6zDA8nSrkid/Aeo
	nGS7GIC9Qy3V6h0WsVvAFSvbe77gXsCAZVPTWqEBwn6OOy4fD/0VziKKYoOfri4y
	G3SxKu6qIgEux/9Luj4nkw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r291hb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 18:14:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJGX6An036655;
	Fri, 19 Dec 2025 18:14:00 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtmt5bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 18:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nae7NuzP9t/krV9kgg4Ujlc8tpg+IQqvcar0i7k8vqSkEd7aqRjmiqGWzHdTWXx7tK2TfkFH/saY2x3f1xuqWulB+FBtZBDEyA00Ahj97vjlhkb4UPCvrSuxSLzLUmRss6Knygg6K5GpDoJR7uSR9bPkaI1l8sxTVmMQMII+nWZMXeKpmDD1+Fp6pDKtf/sVGIquuV3vuQMyp632Z/mnL6mLfb1sfiJj+zg4Elk9M0bTSi0z0nacChY+qHEiORrhcxjnYdMm5l+BvLMFu/PIBCd69Veaj9dTjPH+a0XvDECCraMb2oP0Z7r4ccmLd8RgBVwsISy1QbP3FSWYQcI4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e94eOBBur0glUQtob+DruhcQH2NNACpaRrS/P5vGfRk=;
 b=AIeR3xqtCiVaOpT+/0ooGTn/mfP9tc3Cq8/0W5bA2gL8ZXOYV/Xb7zA6tlPlA6nY/wnIg3OU7afyz9Hzc/8H/mekMVrTrFIvmBRVyiJKdhvKuOmnfIqtgEoj0rzwdcIMU/VQorW5DRlz4Cs8ZG3J49zyIlI2d9FLNNaitOw6VkRsUXs0FrmJ3WA/hWgEPdbmqFh1xNLsjrv1yJ6x+O/YozShXEczRETtKyi/mt9vgSvWGRWUOIhTWqAEimXUPQtx7vTzwGTdpk5rc2O6mIoQ6SH+TJTmCtzvPDGJn2TKxlRIb9yWXuOb0qWsdiPbspHW0jf+1q+9P0OVuJnSFq5Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e94eOBBur0glUQtob+DruhcQH2NNACpaRrS/P5vGfRk=;
 b=e/GmurBD6r01js5+mhsMY8tgvU12hsHUiMy7lyOJ4mbWTtUCva5W0xxCQj9XCNflBjxeHXyhTffdHxR9eTDMv6WYFrswikizDlsokZN6I4F5sB2L65PZ3+xjfAjgF8jxF4bZSeSTnNDz1UVK0O+umXbet7cEbLurqojVZXXA+6k=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB5885.namprd10.prod.outlook.com (2603:10b6:806:234::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 18:13:57 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 18:13:57 +0000
Message-ID: <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
Date: Fri, 19 Dec 2025 18:13:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, mykyta.yatsenko5@gmail.com
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com>
 <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
 <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::12) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: e3125f67-f45c-4b40-aa62-08de3f2a6046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VER0Z0g4YjdDa09GYjlnVnFZdTdGbXIzZ09KT0FZTCtiV3BIL205Y09mTEZV?=
 =?utf-8?B?UzQ0U2NVV2xOb3lNcXl6NUZoU1JJdW8wVDRwT0sxZFNQaGZKeDlqYzE4YUZD?=
 =?utf-8?B?ZmtHUUZianFXcGIzblFaMjYyUHExeEh3R0hZTlVENmFKY3poMURvd2ppZG1i?=
 =?utf-8?B?bEZkNnZxQUViMThLT0cwVTJOcUhYZWh1QVR6T2g0Sk5WTWtqa3pyeG8wd2RZ?=
 =?utf-8?B?NlJVbkMzWXdnT3l3K1REZ0VLSTNGMnJJUS9sNjZaSGxRUUNlbUEyK3FUNnA4?=
 =?utf-8?B?aEpISHpUUjArZk5ZQmN5bXU4MU1VT0FrNjkvUjRyWFk5UEJtVk1ub2pMcmZ0?=
 =?utf-8?B?YVR5OVp4cEFoaDlKdVBiVkVkYVVQOXJIYllEaHJlV0loQjVtQ1lWbGJJV1RM?=
 =?utf-8?B?akRpbkZpSjlaeWF6SnZDdjh1MzRpcnFVZ1FzaG5iUkZJTERSc1ZBQ2g4STAy?=
 =?utf-8?B?aXd3VzJPOTFNL0xvQnhKSFl2V0QyVlFOaE53UUptc28yMi9oa1A1OHZsZFUr?=
 =?utf-8?B?TFBIdFBkdmNCbWhKQzQyVlJZVlNwSHpKQ1RWOHZQeS9NeXNBNkFTdUlyMkRa?=
 =?utf-8?B?S3RnZlAwTHBjSndJdU1ndXB6L1U3K2tlMW1xd0krVEtGa3ZETm5oSERFS3Ry?=
 =?utf-8?B?eHFzK2Z0QUdjNnh3aDZiMmZ0VXN2dk91azJMclhsZnJiL3hLN3JmZnJUbDFK?=
 =?utf-8?B?ODVEcnQyV1JERG0xUjJmZndLT3JUZHpWLzhjNTlQMm5yek9rUzMzKzFJL2pl?=
 =?utf-8?B?VndlWEdwZFpTSGRTNUY5dFR5VjdoaXZ2WjlBSkhJaGZxazYvcDkrNW8vdlVs?=
 =?utf-8?B?Z2tMMm5pa0E1NGFrQ0ZJWXJaVER0ekI0aGZrVEkxYjcrMmU5eVRqQitrUXhl?=
 =?utf-8?B?bEZtRVoyZWFGazlMYjRSQm85czZyVVQ0TE1pQ2pQZ3NmbC9ZWDZCV1FFMk9X?=
 =?utf-8?B?UDdMRTJqdy9NOEFBN2oyNFdHTDRaZU5ZbUsyWXlCM1k5WXVEU2FiNWNRbnBX?=
 =?utf-8?B?WGgzU3h1ekpwUzlpaFAwQ1NXTEdBSTNRMVdydmNlRUdJS3dxaEkxbTgzMzF5?=
 =?utf-8?B?Ym1uaCtHVDgvcWRwc0xPU1g3Nmt4VDl3YlhZWjUvOUFxSllxZGN6UlpJYy9X?=
 =?utf-8?B?eEROWDFsU0pwMTZEcWdHcVZVcUNPSDNGNlJVQ1FNL3N1VUN4T2FRUTRXUi94?=
 =?utf-8?B?LytCcDIwQnhhbE5FaEJOTE83TWh4cGJlU0FTQUdFRDVLMUhOMW1ZRXp0bFlh?=
 =?utf-8?B?cHl5NXFXakF6NTFFeVpCSzNIZUl2VkhvQVdoN1FDanZueG1WYzNQNzZ5ODJE?=
 =?utf-8?B?cDdmL3BJNkh1elV5RmZMb1o4dEFnbVB5cytKYXpoRy9qUkJETlFhMU5wSjZr?=
 =?utf-8?B?aG9uMDJZcDBPT3gwenhDMnpVWXRPR09tSzRwdVVqbXhnMk1pTEpRWXIwWEdl?=
 =?utf-8?B?ZVVraWNycVN0MTdWYW1sNnVwRHlJNHgra2xUR0hsZWR2OW1sbzB4TWwrTzJ2?=
 =?utf-8?B?eS9iUk9hOXBzQ3pUeXBIVjl0TWNSRVp3dnF2TC9WWkh1YVZvZjhrazVXaDVQ?=
 =?utf-8?B?Y3p0WmtwZS9hODd0OGFCNHplc0V6OEdlQkhDeWJhRUhWdXJ6MjVkbjlvYjkx?=
 =?utf-8?B?UUp0d2dsQU5uQXRMWWFSZ2VJbWtmNFk0Y09EY0xHVnFpTXlOZ3JDVy9rS1R3?=
 =?utf-8?B?SUNTOTVRSUtRWHFKYU9ONkwva3MzZmwyUWNNWHFJNVFod3podVNLcFZOM3RP?=
 =?utf-8?B?NjluT3BjOHpZWUlxZ21WRENFNXIvV0JKUWRIRTNhZVJWR2UyTmdjQnh3NFUx?=
 =?utf-8?B?bHhrYVlFdVBCSEUvc2lSVXFIN2JnOU0xSmxJcVBPQW5hR3hNeVpYaE9jcXJm?=
 =?utf-8?B?bU41enlHUGtpSFpnN3JhNlRLL2hKcTRybXY3TU9mRGMweEI0MiszUVFXdDE5?=
 =?utf-8?B?VmFsNEZ0OVhWeDZTMy9xSE5WN2xvMTV4eHZLNmpSRGloemxkSnMvV0NYbGk0?=
 =?utf-8?B?VDBDZ0VobXF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE45R2tBdU5YbDJCVUs4L01oWHRCMC9oYmFoTTBHQXZiZ1djaXB1TlVhWnNq?=
 =?utf-8?B?QXc1SGlqcWNBMTlqdDRMVFgySzRyVGluMndNUWVNci9ZbXdPM2dnYVB1U2VM?=
 =?utf-8?B?ODFTeUVsVys0SGhvc1p0TEtuYmh4SEExZVFXRlJtTjJvelo3RUk2by8rR3Fl?=
 =?utf-8?B?WDVIYTcyNHZaS241UHFMMEEyWXkrZlpQVGkzREZpK3dKTFdHQkNXZGdRalI1?=
 =?utf-8?B?cStOa0VBU0lVYTlSaVNzbStUQXJBSmwvZG5HVitlZEdTQXRlYWUvOUNZU2s1?=
 =?utf-8?B?bC9vTzduSkdwNlM5aXpCVXRFZ3gvNWZTOVNkOVNQUTIrcGdleGNWeG1vd2hY?=
 =?utf-8?B?VjZUdE1hU0ZuLzY0ZDdiTWhJc29SQnRUY255RDRvUzVaSjc2ckQvTGhTb0R0?=
 =?utf-8?B?NjZ3RDNCNlRLa0VtdzRLT2lPVndteG1COWRnbTJwZWNUd3FiSm5IMWdDMlJj?=
 =?utf-8?B?Y2txVmV3MG9TaXdhQkNFVUp2bGxUdEJHSWxGUDltMkhuaVNSWWUxNmpjN0k5?=
 =?utf-8?B?bkFDem1GbjJuYmZmT3FKOXV1YzYyWlpaOEhHbS9uM002b3RTWHRJWUkxNHZX?=
 =?utf-8?B?RExLU3VESnk4OVdBdThRTXgveTg3Tmt5VGJnWkhjTFpYYnZzVUpaUGdlZFRu?=
 =?utf-8?B?N0FSMG5FSkVwa2EzcjdYOFh0bUVRNjRHREJ5aTRKQzdiOStjcFRwOG1Jb1JN?=
 =?utf-8?B?aFZld1NyQmR1RTRwU016TUVPQnFtQlpHRDNxRm1YbEk3R1A2M013dThXUlNx?=
 =?utf-8?B?UlpVSFNmblRKZllhbWF1aDhFZ0Q3amR6UGZXcGYxMHVMWTBUa2ZGaVNOSHJB?=
 =?utf-8?B?cWJBUjdmdDhvQllrcmJzVUN0ZVY0MHJHa0Q0MXZjYUhRbmVYQ0pPbWpUQWF3?=
 =?utf-8?B?dVBZUU4yTDh0bnhQTUFzelFHK0MrY3B1R3NVdUtKRGRhTEVGbDBzVE8rMDlG?=
 =?utf-8?B?NjFMVFNMNU11M29LcUJBZU1kRXlXUlJLcDJybzhrdUtwTTBuZk5uSWs4bnVV?=
 =?utf-8?B?bFdHTU1GVmpaZnBmOHlNNXliTGlKa0RlbS9HU3YwNjh3bUMrYjZ0TFlhT1V2?=
 =?utf-8?B?T1VUdlRlNmJDQlpFc2pZR01lUk94N1cyVzB6SXdYQkNId3R0NWgxSUh2WXVC?=
 =?utf-8?B?RUFET3JaNVR4TjZWTWxmdlBLR3VIbm5uaEVvOEZ1YWFMQnpTMGdxaG53R0xZ?=
 =?utf-8?B?d2xEV3lnRVVOUGdjVURmZUpHcEpVWE5XekRra3VQZTdXMDM4RkVPNXg4a0s3?=
 =?utf-8?B?bGlYSFNMZnRVcEtsSjVTNysvc1p5NkFkMnhRQUhhUG4vVmJGNHdTeEl3L24z?=
 =?utf-8?B?K2FTT2hKeGVZeDdzVk5EY1B3Vk8wUFY3K3JWRmdQLzFTb01wbUFXOFpuY1NI?=
 =?utf-8?B?MVRkbTNxN1k1SFFXUDd0UXFvRDJ2QWlKU3lPSzdjejdTR3dFQzdvVlBmOHpO?=
 =?utf-8?B?ZEtja1FVcXdZbDQ3cXkzOFdWSWtlMzZhQ0lOUUUwZ2hDOXREMlpLSG43bnVV?=
 =?utf-8?B?bEt3RXlVTXlnTE9MRFFmQXN3SnlqNHVUUmhRLzhTMmFvQ2Y5ZkZKOU94Ym1j?=
 =?utf-8?B?T3JObzRCa29YR3BIWEgvTnN6L3ZrZFY0R2JxRVNNWmtXd3duMkJkN0RZOGpq?=
 =?utf-8?B?QUNHenE5dzZIbGQ3cjUrdGJUVXpIQnhLaFJHc1dkOGxKT1ZQWVJjUEt4QVhu?=
 =?utf-8?B?MktzVGN2d1NhK2thZnZEWS8vSi9Zbm5JZGc2Z3B2WTFZRDlrSitFOHYxSy9m?=
 =?utf-8?B?YUtkcFlJeGh1R2hOMzl4QkFJL0NHU3M0Ukp4RHBSUEdoTG5jaGtuNXNnWGQv?=
 =?utf-8?B?UEdDYnNiRW16K0lIYnVXblM5WnJOK0FxdFdqTERMZzg0Mi9YSHNBK0FqMTRk?=
 =?utf-8?B?M1NtSzdUK2plbUFXQVEzWGdaYnpkUWtlcXJFeGk5eTE3KzcrVVRBL0JNbHRt?=
 =?utf-8?B?aUhHd2FjT0krc3UrMDFMNC80Q21QNWE5am5YQnZ2ZmJNQy9EVjJwSmtIUEsx?=
 =?utf-8?B?VU1Ca1g1YUgvQjdoUlZRc1VOUVhydUkxdnlBUDNORk5SKzIxaXpVdW5tOVhZ?=
 =?utf-8?B?NHp2UWp0TlJhaFByeDFCajRXUTdTME4vVVZtR2V0bVh2Nm5nZXp0N29RM3Z4?=
 =?utf-8?B?bmtqcCtLMG9ZVUYwOVlIRVZvY01xTXpaeEdpZyt5UFZ0MDRDUDFya1ViQmVV?=
 =?utf-8?B?Qm8yemhVcTdVdXFzT0FPM045V1lHUGpoRUdTbWMvZ0NNYnNRZ2FGTkd0RmVG?=
 =?utf-8?B?RjdkV3hSOEZBejl6RW1mV3plRm0zRFZxbzlnTkRQOVlRNTd6NGIwclBuNERn?=
 =?utf-8?B?Z1MySFZMeUFhNEZqc2NlVVQ3ZXNrVUNwZjdFQzhRbjdNL3lFQkx6UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wOfFtKZ3Rn8miHmrDSc1R7owU7Dz3lMuBXe+pWT+daamNsdOCArPvUkTaoT4gnVGRvbk6FeAh+AlUDSpVgh4aYrmhriCj4zq0yq1PqYas/faRd1zHdUx0+4poKWcXoA9GE9IIsqLQBN0Ao/I0I66KjTTegCAnfhQL0gttGE+XfCjb0ykAKjj+Y+MExPhlAqQxGtmpV5BSSxO38LPGvS1vv0P+FBd01eK821QMBpviuxxpPDBmCyn20nbTxnkEm9Mdqq6/j3UTgzwbtaA6p4gHtvYANShrNRsmEgGZr8sOS3ADg2p8REzSKtXFHBPrh9L1R/IKEL/MaJ4l9VRub1+IMF24NoEP6sw2JmDlIG38bCuqXurVgELI0JQ2U9BmsiH0SCVb24J/Pw16A6OlOsbnbOihh6mXjZwRhc0RbFlTeKgfanAySEHFJzi0cYT1bE79revqTOqlpMZMPMyNhtapLrLBCZbYjsl8WKCB3LbY0aGJm0x6DCHLudeRW21iFA+iFMBgePGR6XSszEYxyV7jkR2DeIUAsmBOcxTlIIql5sguscGs2VgRYP47mmYu3+w5FSIKfKjFhYy0Z5h6px4ZM8ILRFAC1yhu0lMII4JC2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3125f67-f45c-4b40-aa62-08de3f2a6046
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:13:57.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9soIVXLGeST2NV2G6AlgoyovLCgpq4giWEBRNmlh6COCv9y/Ek1jGZ5/WCW6So0pV/o9CUT8QkwaoTPxwQxjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_06,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512190153
X-Proofpoint-ORIG-GUID: bgDT8igaBP1nTuWMZmCA_zTl6XBHNedR
X-Proofpoint-GUID: bgDT8igaBP1nTuWMZmCA_zTl6XBHNedR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE1MiBTYWx0ZWRfX0+fSQLnvgfsc
 ggE3sYndEYNScLE84gu7gRArlyfBgE1SEBFMhCrEm9q0XyVki4PPy1ZHQyjPRgGZjBq7B5cfUyD
 LVl9Sj04SUK+1VrjMBRp/pTR5StoHxSUThRbrUYqtZfLjbazry9ghXrV5fQmPqx1ghhrN+kGxT9
 ryzxVYhgVt8J5JFWJlot2+aEyk2fNcEGKaRBYgTM/Tm6wktuFiYCOgScvxVMH0qGbqF28B/4r5z
 WNvoPlO41LDUqtPggnP2tmO+IkytTBq+JknYDTINE3MOajjp6MaU55MHnO2VE8dex1jEeNLcZFP
 4nBrQQWn0axuxs/LuDVDzhhwpLO3pxqHK8+bY1BUoK9drwUofV3eB937HXnaMdnFADhDIpfn2Mb
 OT4GGoNH0EeZf25K+hiGrfWD88crtbp+8u3Q1SKcDIBROF4+R8llr1AKRPM+Orvjm3RxiHn4lJQ
 R6ODndFMBZW3XXQTwcXQfip1pl6yNm1miAskVHsM=
X-Authority-Analysis: v=2.4 cv=efkwvrEH c=1 sm=1 tr=0 ts=694595e9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=EVocG16cU1r7Rx9qQXIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654

On 19/12/2025 17:53, Andrii Nakryiko wrote:
> On Fri, Dec 19, 2025 at 5:15 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 16/12/2025 19:23, Andrii Nakryiko wrote:
>>> On Mon, Dec 15, 2025 at 1:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> BTF kind layouts provide information to parse BTF kinds. By separating
>>>> parsing BTF from using all the information it provides, we allow BTF
>>>> to encode new features even if they cannot be used by readers. This
>>>> will be helpful in particular for cases where older tools are used
>>>> to parse newer BTF with kinds the older tools do not recognize;
>>>> the BTF can still be parsed in such cases using kind layout.
>>>>
>>>> The intent is to support encoding of kind layouts optionally so that
>>>> tools like pahole can add this information. For each kind, we record
>>>>
>>>> - length of singular element following struct btf_type
>>>> - length of each of the btf_vlen() elements following
>>>>
>>>> The ideas here were discussed at [1], [2]; hence
>>>>
>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>
>>>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
>>>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
>>>> ---
>>>>  include/uapi/linux/btf.h       | 11 +++++++++++
>>>>  tools/include/uapi/linux/btf.h | 11 +++++++++++
>>>>  2 files changed, 22 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>>>> index 266d4ffa6c07..c1854a1c7b38 100644
>>>> --- a/include/uapi/linux/btf.h
>>>> +++ b/include/uapi/linux/btf.h
>>>> @@ -8,6 +8,15 @@
>>>>  #define BTF_MAGIC      0xeB9F
>>>>  #define BTF_VERSION    1
>>>>
>>>> +/*
>>>> + * kind layout section consists of a struct btf_kind_layout for each known
>>>> + * kind at BTF encoding time.
>>>> + */
>>>> +struct btf_kind_layout {
>>>> +       __u8 info_sz;           /* size of singular element after btf_type */
>>>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
>>>
>>> So Eduard pointed out that at some point we discussed having a name of
>>> a kind (i.e., "struct", "typedef", etc). By now I have no recollection
>>> what were the arguments, do you remember? I'm not sure how I feel now
>>> about having extra 4 bytes per kind, but that's not really a lot of
>>> data (20*4 = 80 bytes added), so might as well add it, I suppose?
>>>
>>
>> Yeah we went back and forth on that; I think it's on balance worthwhile
>> to be honest; tools can be a bit more expressive about what's missing.
>>
>>> I think we were also discussing having flags per kind to designate
>>> some extra semantics, where applicable. Again, don't remember
>>> arguments for or against, but one case where I think this would be
>>> very beneficial is when we add something like type_tag, which is
>>> inevitably used from "normal" struct and will be almost inevitable in
>>> normal vmlinux BTF. Think about it, we have some field which will be
>>> CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
>>> totally break (old) bpftool's dump, as it really can be easily ignored
>>> **if we know TYPE_TAG can be ignored and it is just a reference
>>> type**. That reference type means that there is another type pointed
>>> to using struct btf_type::type field (instead of that field being a
>>> size).
>>>
>>> So I think it would be nice to encode this as a flag that says a) kind
>>> can be ignored without compromising type integrity (i.e., memory
>>> layout is preserved) which will be true for all kinds of modifier
>>> kinds (const/volatile/restrict/type_tag, even for typedef that should
>>> be true) and b) kind is reference type, so struct btf_type::type is a
>>> "pointer" to a valid other underlying type.
>>>
>>> Thoughts?
>>>
>>
>> Again we did go back and forth here but to me there's much more value in
>> being both able to parse _and_ sanitize BTF, at least for the simple cases.
>> What we can include are as you say types in the type graph that are optional
>> reference kinds (like type tag), and kinds that are not implicated in the
>> known type graph like the location stuff (it only points _to_ known kinds,
>> no known kinds will point to location data). So any case where known
>> types + optional ref types constitute the type graph we are good.
>> Anything more complex than these would involve having to represent the
>> layout of type references within unknown kinds (kind of like what we do for
>> field iteration) which seems a bit much.
>>
>> Now one thing that we might want to introduce here is a sanitization-friendly
>> kind, either re-using BTF_KIND_UNKN or adding a new vlen-supporting kind
>> which can be used to overwrite kinds we don't want in the sanitized output.
>> We need this to preserve the type ids for the kernel BTF we sanitize.
>> I get that it seems weird to add a new incompatibility to handle incompatibility,
>> but the sooner we do it the better I guess. The reason I suggest it now is we'd
>> potentially need some more complex sanitization for the location stuff for
>> cases like large location sections, and it might be cleaner to have a special
>> "ignore this it's just sanitization info" kind, especially for cases like
>> BTF C dump.
> 
> So you mean you'd like some "dummy" BTF kind with 4-byte-per-vlen so
> we can "overwrite" any possible unknown BTF kind?.. As you said,
> though, this would only work for new kernels, so that's sad... I don't
> know, I don't hate the idea, but curious what others think.
> 
> Alternatively, we can just try to never add kinds where the vlen
> element is not a multiple of 8 or 12. We can then use ENUM
> (8-bytes-per-vlen) or ENUM64 (12-bytes-per-vlen) to paper over unknown
> types. FUNC_PROTO (8-bytes-per-vlen) and DATASEC (12-bytes-per-vlen)
> are other options. We just don't have 4-bytes-per-vlen for the most
> universal "filler", unfortunately.
> 
> The advantage of the latter is full backwards compatibility with old kernels.
>

True. And I guess during sanitization we can just handle intermediate
types in a type graph by adjusting type ids to skip over them, so we
likely have everything we need already. Funnily enough the BTF location
stuff will give us a vlen-specified 4 byte object (specifying the
location parameters associated with an inline), so that will help in
the future for cases where it is recognized but other kinds are not.

Alan

