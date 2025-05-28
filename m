Return-Path: <bpf+bounces-59182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EADAC6E41
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE3416AD9B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154E28DB7E;
	Wed, 28 May 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ILNCHytE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="je66BRu5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A471F19A;
	Wed, 28 May 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450723; cv=fail; b=VJaGezbzYg6wVV/bBx4HCFFTP4eHIsBJFFgRGr31TH7LH7ilKMKlbl8F1Amio0Ha7F06qxuSX6TagKClbpGT2bISBmha+cdwXz9KUNnLZuDxX/VwZml90B1DEnTowQzt8qyatgFT2MjMwHjaFqrnJA/SqYCsA/aBTbBHCD3lSTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450723; c=relaxed/simple;
	bh=erxDVwLCmpNn9hYR9r9ZI0sTzjUurhGXdQhJ/VwPY0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZJTdiWGCxo7MH5H+UmOr62FFQHuF84lO7KRQ1F2czwXSpXzez1Js4gkITqTALzzb83IQsUScfL3DiNj5Mrc0hyYRjJDFvtYbSCzCwqn3K1AlHNZ+sme6ZHRpZMKnvZ899rrgk1zXTyNXqz1J+zbAGkgourwHic1gKJBUhMOyAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ILNCHytE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=je66BRu5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq8ol031331;
	Wed, 28 May 2025 16:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oCQCizNFkrGZbC7WSQcew1UgxDSGd5ePVLihBgEBDkM=; b=
	ILNCHytE6FOAYMxwmMCukXsO4X5d8HIDVePgW0A4Pi4Bh0F/9iIBwst408l85WIf
	v1t0MXdcS1Pth5mpvlfccyU+IpB9D3qHuOPH3CxctNWdI7rrUrNjmr7Gc6I29+fD
	EUu4Dd6aPgZlfoqAkA6KIhRktE+GNNHkERJUUakjMsM6VbLC9iVRC6sCA51AJ2O1
	cQzjAGWG10g06uVwYwGrkqsEdRJ7QdnqXejJo5IcpEuaGLkNuiKxXTb3xm5xx3tb
	pY52jupTyPvDrrDarwv6Tp+vfre8PpqpF0b/t3QE+MW8Sz/3WbL4lLHVhd45QuSp
	E8ZFJLmauHrQzElmGVKWGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pex71u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 16:44:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54SGBY9s021122;
	Wed, 28 May 2025 16:44:39 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jh53gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 16:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul2u5t5K3WGfA04/Fqs06rqtfottyQBT85YOFfzzoQBVKVXyD1FtfReyue8gtSXo+nmoM8/t5cTZgDYxyeKZJ4w4h00OI3iFOkazxMYf1X3DXBsJIA0PP0/5js2S1r09AVWn2H7ZjvDtkFStpEtZ8yzOlpDngBAwhziTUXk/pLJK4YZ+A2Ih2vRrYGSOL+9uHcDS9Sz1S3odPbAGsEineUPj1ZwMlKzqy2YtAZVBhWHfWztuWloxHf5/uMkpvyjZOPGVRWbSTZOjnWSS1+BhnLsZnA1Ohf1vkgltl+CUsxrqU1+/WEd7UVaEBxGV2M5HAs1Lb6GfEFJBp5N546w4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCQCizNFkrGZbC7WSQcew1UgxDSGd5ePVLihBgEBDkM=;
 b=ri9s6/WTMwwIG1Ho3UVC7IjZLo6KD0Wux3/baKMy7yrYL8RL38zqqamrryDzD7dawTL2WgDrix68OOE8lFLgYcEoNouhdh14AkRWOb736b3TLXYjXHt6VwQ/qtzUTMHtiIQfux91zm/6BQfWDn6Hfqw9nBNw2iaFeukWSutIo1Ymvj+mK1oRbgYOeGP2iKP7CY+IyIqtAIp6ioir5az1tE6sN71iKd3WSWC+TdFRVeLHbIZFGkApx25qOri165BkeW9dCKtEgk+87Tby+HCRGJaB7x+AP48slNlUDaZmH8wgSFgM3UfX7vrlKFX50WWaueKK5ccNJCZEGWJVbCjMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCQCizNFkrGZbC7WSQcew1UgxDSGd5ePVLihBgEBDkM=;
 b=je66BRu5sHHnkkrmWyvxuRggr6IKCo31XCPHTaR90H4ssos0h81Ltg+3qqDc9DXOybZUgzuzg8Am+ivd7CdayxymFZEYsXQn6hvLmHQYQRXx4eE4cJj2uyFTiPKOCx7720h6JsWmQgr6TBFUD2xRkkjNxxrzFlG22Stk5oNKAl8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM3PPF34F57F25D.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 28 May
 2025 16:44:35 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.035; Wed, 28 May 2025
 16:44:35 +0000
Message-ID: <d855c95e-06db-4c68-af01-8997ce9b9257@oracle.com>
Date: Wed, 28 May 2025 22:14:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi
 buffer XDP in mergeable
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-2-minhquangbui99@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250527161904.75259-2-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM3PPF34F57F25D:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a8fb1e-4484-4206-1ae3-08dd9e06ed9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THFpMFpWZC9hNkFjUGNSdmpQN3ZwWlV5RXNRV3lGUE5DSFpGVEM5U2dnUms1?=
 =?utf-8?B?NHlIVTJZbjg3aDhEQ2V1bXVXMlJQcit0bzRzaEswVEtRaGh6YVNiQWJVanZj?=
 =?utf-8?B?aU1QdFJldkdHRE9Bdm15a0ZteEVKa1pKWCtaSm5Ya2w2aGptM3RqaGpjazlS?=
 =?utf-8?B?eHVWSUV5eFpyVUczS0ZUdFNHLyt5eGl0c0xIVVdkYjVlSU5ORWJ3ODBid1dS?=
 =?utf-8?B?MFoyZjZQNGZFcnRoNUdoNDdMY1I1TlM3RnVrSXZZbXFGc0hVTUNSeWxOVmUw?=
 =?utf-8?B?UlY2aGMyOStaL1FuS2Mwd1JDZHFCRXozRDMwTUdlam85L0Z3NHFKTHk1Yk96?=
 =?utf-8?B?YlVEUkUzR2xsSlErUkRKRGJoYXQrckYwMzR1SnM3aU9EWGg3REVMdzZiSCs4?=
 =?utf-8?B?c1ZnOHBaZEF3T3BDQ0ppS0JMVU1BTWxiZnJyb0Q5dXBtZE5qMSs2Tkx4c3VR?=
 =?utf-8?B?cWJ1Wkw0N1ppYzhVVVZrOFNXSUVpZEpuSVdTdUNGRmxRVEpEblpMOU5Jb0I2?=
 =?utf-8?B?RTlVclM3SStuMkRJMkZRRmtXTFRzK3BrZEVrSzgyQ3V0bEhEdmxPejhRWGhS?=
 =?utf-8?B?S3JiV0JtTGpjRUhNVTNHaTU0VE5jc1NjazQycHEvcE80SVJTeGQ3ZHpUd3pG?=
 =?utf-8?B?bGQydE5GN2dTSSttRm1QUEd5ZGhUbHpwWUY4N1lEcTdFVE1tTmlKRVdXNVNC?=
 =?utf-8?B?ZHBLb3lEd1p1NzdQTWZPaEcyaTdTRTJkU1Myem9wNE9ZbDRDUW83aFFiL3Qv?=
 =?utf-8?B?ek5lVit6Z3ZQYnoxZlNDZVFLK3JXN2M0OTVoaEZoZGY2bHd2WktDNFByeFpz?=
 =?utf-8?B?dDZFUXB4OVNXRURkd3dHaDcvMTA4ZlExTDVSR3hXYndFWFlVYUxSbVlIbkp1?=
 =?utf-8?B?czVSR3hNZGVQQnFKUEd0NlRDMmExL21Dd1ZMOWptT0tPcUt6eXV4RjREOHVk?=
 =?utf-8?B?ZnphTndjWXYvUkVHTjZ5alU4YTNVbWh5VVhCS2FpS3dSVXM5d2pYSnNMc09O?=
 =?utf-8?B?RTQzMktSbWpzdG50aXBmR1QxNlFlbFNPRjhhQ2R2aFp3VkwrNG9Sc0RISXNP?=
 =?utf-8?B?MDlnTURyNjRBQmFCSERuWUQ1UFJ3WE9CZTMvZHUwNzNQSFN1Z2VkbCtRN3BF?=
 =?utf-8?B?MFNaWTZlWmNqejRtQUczWFFtWUMxMW5DS29zRmI1WE45OXhDQUwxOElIb3pz?=
 =?utf-8?B?cG9aMisrNHRkMVJnQVBoWW16NW1yWUwwTTNNb3hndVZhNmFNdjlWdmcrYktL?=
 =?utf-8?B?U3ZPVVZ4Nmhhc2F2T1NyTWZaak5zT2c0cXFiM2JEVlBkaFBSNGROemlFYVd2?=
 =?utf-8?B?bTdPVHpZbmxhenl1aFBUZnNiWjFhTTlyd3hsYmZSdXNXL0R0d2NFZE5TWDdk?=
 =?utf-8?B?aGNWT1FreVc1UjFULzVURDFjNEdhZ2trVGhIY0ZaTTRtbG5ia2NtWVllTlgv?=
 =?utf-8?B?RmRwZElBUGtmcDMrZUVaUDhNbjZ4R0tOUkErOWFCUXliRGJkU0djNWYwZGw3?=
 =?utf-8?B?VWVQRGg3VHAycDZpYTFwRU9kckwxV0FCejR2aEd1T1ZSTlI4dUY2MmNYNm9i?=
 =?utf-8?B?ZlpudW02dC9LWUVoRXVtNE1pa1JTdWZiNG5PWUJTekpLYTF5VjdmQkpVUDk0?=
 =?utf-8?B?L1hYdmR4SFNFSEo4cEIyWGdJOWs1RU9kMzJVd3N2QVFMOVlhY3JqbXpOUHRC?=
 =?utf-8?B?MUNIbE11eVUyVituWnMxOUs5dXNCN0hiVmVDUmNmbDc4VHo0a2Zub2lGOXpK?=
 =?utf-8?B?RGMvalJ1SmEzL1VuTGxWazB1YUhiOW9ScE9yS3dVbjVmSHhwL3RROGZ3ak9L?=
 =?utf-8?B?cWpVMnZwN1ZSc05yL044ZzRMSWVodzQ0Y3lMbXVJMHVyczgwa2UxSjBBNEgr?=
 =?utf-8?B?Z1BwbklXdlZGYkpQTEZseDhQbHM5TnZaOUpESngzUGY0dVg1Ni9ESFdmN0JM?=
 =?utf-8?Q?ZaKjWykHcVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjhsYUlITnhIYTN4OGtKQWJ1N2N6Qzl3aGNGQzdxc015NEljZ3kzNkQyeDkz?=
 =?utf-8?B?Y3NmZ1JNWkNJaWg3UWhyRVcvRlJCQ1pUN0tEN3E0L2dOUy8wNmpYSEpzRFpo?=
 =?utf-8?B?QW9QVFM2QmtWZlZMbzRXYkNvTElMb2pLTDBWNktzYktmRWIvSzZUNDZBWUIw?=
 =?utf-8?B?K3YzT25qVXlEaytEQThhcGllVnJSaCtYa3VYaVBPMDlxekdXbG9vVDRJZ2N4?=
 =?utf-8?B?TWJ4UWtLb1ZCVjREM3dRZ0hZRkk3NTQwSlk3aldhL2o1UTVHNU1VNTcxQTdX?=
 =?utf-8?B?czFnZUUzcmpTRGlBdUVaR2lKOTRtcnUvU0ZMd1dJY0VWNmRCcEhaT0NGTjNX?=
 =?utf-8?B?VGZJRnh5Tm5mUGt0aW50NEptUERObXE4ajE2cXJ3U1gzMUVLbzUzVjRuclJK?=
 =?utf-8?B?ODRxWmJjYlg0cmd5aXRrSGd3alpXODlrZHVMdWZNTHhQcFdKV1Nlc1UxNjZv?=
 =?utf-8?B?S0JFTnlRTU1UV29Bc3hpdjFubldSUTlQOFZKYk1mcS9EU3hwclJ2NStsbkxw?=
 =?utf-8?B?Yk5YNG5pWE9pcEtSRlBhR1RZT3V5RDdmc3RFcENlYVFlanoxcDQ2N3FGRitY?=
 =?utf-8?B?cUFrRlZkWGl3OVRud3owYkEydXBRV2M5Yk8yS1ozQXd6aVBMWDBLaTJLYVhM?=
 =?utf-8?B?bUZhL3p4d3lGRzgrYzIzeGF1SEJ3SEJuWXUzMStaTElmMFF1c0psSnNOTDVj?=
 =?utf-8?B?VmY1TmFEbmFaRVpBc01NL25vQTJYdzVoTU9yTTkrWXFmaHZTMnR3SnRMVmJX?=
 =?utf-8?B?SUh4V0NUenpLSEFHZWR0aDdqYzhScDZtdUhtVGNRMXNqUXVKV2xySDQyQW9R?=
 =?utf-8?B?WDlSV2R6QlRNTThrZEpvZm1UQnRTTnVCVXpCR29rYlZ0aGNaN2JiNkM5UjlQ?=
 =?utf-8?B?Y3JHTTlNZkZZSXBwb1FtRzN4L3Y4UjFSS2NyV1g0cXQzSmVrQll2VzJYKzZs?=
 =?utf-8?B?cXV2K3hyK0E0ZXhmcXdyL3FoS25SZ0RHTXJ3N29qTUloTjdSd1gwYUh6UCtR?=
 =?utf-8?B?YUFQdU5sNHh4OEZMYWtkMG5vVzJhT3dHSCtSbE91NW44bnBJYTNZRldQSTg2?=
 =?utf-8?B?M2ZUY0tFNHNxYWt1T1NUcUM4Y3BadkNveTE4QXdwL1hwa2FvczJJMjNjamdG?=
 =?utf-8?B?eXp2Y1FSZmFHRUNHOTJGeTBRNlVpTzA2ak81MFp0elY4cWlrd21lSkFiWmJW?=
 =?utf-8?B?TnBBL09JSHgzcThJd2hsVzlrbkxCYUc4NXo5b2tyMG9XNm9QeHFqRzJtZVZL?=
 =?utf-8?B?L1FPVkNmNVp2OG9Tb24zcnkvRnlLV2tEWmgvTXN2alBnWjJRYlFqeEVCbURk?=
 =?utf-8?B?M1RkQmlGYWlDZnJTWjUvRGE5NDZVVFVJQ2JzdW03WVdtckVPMXJ1Q3lWM3VU?=
 =?utf-8?B?eXRONVNZZEZDZHNncTlIZWNPNG9YaktES0lBWlNKL0lRVk1QVWpuM1FEdzh2?=
 =?utf-8?B?TXM5Tk0zenBuYmZWOHVWdGg3TTdScllYSkJaN2N4alpxc1hMNHQzVEgvaVpC?=
 =?utf-8?B?aE5YVkxkZ0FQblE4L05sZWlMeXhXM2FiaFZXU2hZcFYwVHgvMitaVG01R0c5?=
 =?utf-8?B?Q0F4eExIU0ZuM090OVJZQ0R3aW1ibTVaL2dPTXZIQkhkeTIyelF1NVpKNkpN?=
 =?utf-8?B?dVlKa1paVDVkeGFmODhCMlJSZm9YeUgzUW9LSkJVZnFma0gyZGtIUWRwQTdD?=
 =?utf-8?B?R2sxTnlicG9uVWhWRDUwYjBIMjZXd0t1NmxlWmlhT0FsdTUzbFJkRGgwUjJF?=
 =?utf-8?B?V1UvVFJnM0dVZlNIaEpiQ1ZtYVBEbHpyRE9tb2YvQ2h0elUxa2VxM2JINDdK?=
 =?utf-8?B?ZHFsM1RCU3VOMmpBRXpoWjZ6dkJJUVN1Tkp6aGNISElFQk0wcGxrSGFTNnVX?=
 =?utf-8?B?YTFqN1BQaDZMSGJWbHZ0d09WZ3R3RllKTnhyS1lDbXdyN2RFUzlhK1FQU1NO?=
 =?utf-8?B?RmFhSmJIN3BDV1RVR2hpNGhjeVNMR0hZNVBiSGJFelJKaGh5V3JuaStoQ0NF?=
 =?utf-8?B?ZFUvNXJtckZyYU1DYUgvTERVM2g3ZzN6cXZBUmI4bnAvcHI3WnR6WkVYM3Ni?=
 =?utf-8?B?ZDczVUlhb3BjN0tHZzhobHpBRDNSNWs3VGJMaTROR0xYR2UvRTZnV0twcGxU?=
 =?utf-8?Q?JUHCO8tmfZWidwlQcijVHZKBn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3CKjJBNCcNlo6lph1YieCcAW6mLjAvf/9pKF0vnUoND+Xakfr8+Ps0Aw5zv+iu6dUdAlti45Qgo88h1v6gLh9pnzTnKxkLBd2IpyoiYosWPyqTYw0HPxzv5kc9pvG6+sUb8qLB/COFcUvQlr7cafPr44yLfGmfX0sUvRfy5pDLqRAy9DeLePNQTAqWO89HEVmHhMjwq42cgKw7zHwJ9HJ5p8y5H2FQXhInYRMZ1AO2xKSUYVcLNC9pQSQuJHsmVgTlROAp5JBxzePBvUhWhMvQ7+pdDwhIvzZ7zFY6GkfJYeouAIY+WSgFN608midiOxOM5ojH9dqm7cMK9EsMCbJI1JjFXOVCRSUY/hMHjsp06KqcfEmXsghfnZuhhj7cHn1EPdqJw56oWez5mImo2QVhoUAuDup28b6lrSA8KNaKY9iRUGWwb7cxyPBLBnIhvKhMWXC/aquca3diA8CJE0d0fB6NG3k2v5kNTG8OEZTIYDnBLnMvNCEWHKjZTNPq80IZT8cAnRUtbu7tusSgYqlGmBNtX5Ym/nVzqxG7wmX5AWdzK5mrdpqTccWbaunNl0Nopj3Qk0s0kTt3Sf3XtllHyAa4faGEgQwlYHl2R7s6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a8fb1e-4484-4206-1ae3-08dd9e06ed9a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:44:35.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNCgeiFrVCjL8JFwUjWeCp4q1QCpMsyAeGpdDpbmXZdagPCFNyjGmBxXySXmYmZp0aqq1NZO2ngJYehjVZM8cZg/wNjvXoA/8FQoTSgAZ0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF34F57F25D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-ORIG-GUID: EqwVNIWm5f5Y3QPp6O5p86eeWOb2DAth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfXzx9y2TZzHG8c ScWFB6eEzUstnKsWZi6RuWTApIQqIqvBz0NNgpvjuvHOcZZwix7dPnu0BwIJllt+rZoPAMYDqz0 V9ii02zkmOdUJTdOfqJMPpVZZo6wp1KKg20Na4vK0Llk8y7kxpxnca0RmMLe3JEZgKsO2KzQQ1N
 r/XnZi7HIVZhjVs9b7SLYci33K6F16a+A4TN7UXwr69LekiUIUP9eThCsH9vTewxu0v3AaaqJz8 hecv3Jl5n41tS4icSqgmmSoa2M2N2m9rt+qssH7p7qDZQpx+vVsNXZq0yndQygOCzvRZkgL+xah ml7j0vi5uppDyz3zNMST7yBqg3soXC9DmnLq8/6mWdjtjPUaG+0+a/oa3z3IlZJ+Y1pxpLWlaZH
 hQcvbrL0/1hBkswFEG2YQgJoHCLY7nxhTSLW8/CSL3ik+wTdUcc1sLrnv0AX0vu1MsNjVeJ/
X-Proofpoint-GUID: EqwVNIWm5f5Y3QPp6O5p86eeWOb2DAth
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=68373d77 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=r0Xck-ZRBxm570edAgkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207



On 27-05-2025 21:49, Bui Quang Minh wrote:
> Currently, in zerocopy mode with mergeable receive buffer, virtio-net
> does not support multi buffer but a single buffer only. This commit adds
> support for multi mergeable receive buffer in the zerocopy XDP path by
> utilizing XDP buffer with frags.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>   drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
>   1 file changed, 66 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..a9558650f205 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
>   #define VIRTIO_XDP_TX		BIT(0)
>   #define VIRTIO_XDP_REDIR	BIT(1)
>   
> +#define VIRTNET_MAX_ZC_SEGS	8
> +
>   /* RX packet size EWMA. The average packet size is used to determine the packet
>    * buffer size when refilling RX rings. As the entire RX ring may be refilled
>    * at once, the weight is chosen so that the EWMA will be insensitive to short-
> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_device *dev,
>   	}
>   }
>   
> -static int xsk_append_merge_buffer(struct virtnet_info *vi,
> -				   struct receive_queue *rq,
> -				   struct sk_buff *head_skb,
> -				   u32 num_buf,
> -				   struct virtio_net_hdr_mrg_rxbuf *hdr,
> -				   struct virtnet_rq_stats *stats)
> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
> +				      struct receive_queue *rq,
> +				      u32 num_buf,
> +				      struct xdp_buff *xdp,
> +				      struct virtnet_rq_stats *stats)
>   {
> -	struct sk_buff *curr_skb;
> -	struct xdp_buff *xdp;
> -	u32 len, truesize;
> -	struct page *page;
> +	unsigned int len;
>   	void *buf;
>   
> -	curr_skb = head_skb;
> +	if (num_buf < 2)
> +		return 0;
> +
> +	while (num_buf > 1) {
> +		struct xdp_buff *new_xdp;
>   
> -	while (--num_buf) {
>   		buf = virtqueue_get_buf(rq->vq, &len);
> -		if (unlikely(!buf)) {
> -			pr_debug("%s: rx error: %d buffers out of %d missing\n",
> -				 vi->dev->name, num_buf,
> -				 virtio16_to_cpu(vi->vdev,
> -						 hdr->num_buffers));
> +		if (!unlikely(buf)) {

if (unlikely(!buf)) { ?

> +			pr_debug("%s: rx error: %d buffers missing\n",
> +				 vi->dev->name, num_buf);
>   			DEV_STATS_INC(vi->dev, rx_length_errors);

Thanks,
Alok

