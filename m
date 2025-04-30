Return-Path: <bpf+bounces-57087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B740EAA5407
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 20:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A03983BA4
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D9265CA5;
	Wed, 30 Apr 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="BpTEjdOU";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="cq3F8q4P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCF1E7C0A;
	Wed, 30 Apr 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038748; cv=fail; b=d70atWIPj5Rn94wbjK6OT/8DBXvJsLBFUDpp3OYrNk6TbXrTuuHnC9FwNF2BP8+ICNjcF2APRL3dRKUdbvXkEIPxnyQCPYYiPcAmhiyHOTXPSyDFBBGShCrDCuijiZiDnbCWODmT58IX544NuKoDbpWPewiuDbruAVvCK3lt7Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038748; c=relaxed/simple;
	bh=i3EJBs8/kvCPX+GBdejebpUtEee3GlUonjlzhyYFqO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E4FsXcnvsxdz182Ef/nMz01M0Bf+VFXh/yBjvRTebObMHeGo0aSjH+OBy7pqmLTIjWWTMtDTi3RzCfFCeUjQCqD5PpaQoh/wI0VvwrFbjYYU1H5JHwPGxGQffwAwSLhVmCmo5aPeEjzzG7XWBRMsuxupzlS6sN9NW0n0M6GBT78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=BpTEjdOU; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=cq3F8q4P; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UAfZVK002654;
	Wed, 30 Apr 2025 11:45:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=i3EJBs8/kvCPX+GBdejebpUtEee3GlUonjlzhyYFq
	O0=; b=BpTEjdOUX6rpmWTnNHz8uPw1UDrAjMegrgAe+1qtu2URlyTduwDBLyFgt
	Dlw1Sci/XjR7EYiavh57wz9EMpdJofM/inkdRx4pJnFCfAwEGBtVRvSWi+HOh0kW
	KeQDxEw4CkSpU6jvAK5zQsEX49fIwURYWQ2B5PnTJ21xkIBa7rgWRhxGWZZEXFX2
	+dJr8RbfNdRosbjaVYY3GIeUwbewVbKsxGSjp8ZggKrhVMjYMHjF+pOF2K78oA9U
	OGBlKaT3Il9k8nBMvNufYwlug4Ny0p11yqHQoc+q2Y0oS7tdbh26LR2ynHZNbPXh
	bZ1J7nYMpaxoRSzzJ5zQ9hPcQdhBw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8hqne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 11:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHRXoVkusK0MWBJ6+7ZbnyEoG53RKzhsY8WvHTdAstgq2sjDW7PuzjAGo7mCoeawdpBBNqArnhf9j3N92QkLQQt+oM47jKgIAsrb7+cZpel78bZy0btSbx8jS2gG+5EYJzDypiKbqcmnIJh7o3/lxKT0nkf7j+LDWRDlAClV8xub3CsKUqt/Ddp5ODpw5frRDAaWUT9/iqs65+SKmTytgsmxl6LBFgFNkqc11q74nzjmVzEuNwIWDPnBsBdEKWEM23UW5+dhZnTXt/228ZjWHHkL3f0lpkJJ0Ijrcb8E6p+ZkqGbZE34PnuoZKQS7wmwG0+ogLV9yjtjoyJoQb2Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3EJBs8/kvCPX+GBdejebpUtEee3GlUonjlzhyYFqO0=;
 b=enix577HEFHOx16Gj9tM3oa1JgoM0Py+X9l4YMu58CNaojb66Upam3YWEML2A7hjo/oa3iVXxVN1YVXfscbZWadn4CJRo14W6i1VmAHLTex9fJwP30lCP6aoSsHxPgkNi2WY2ykPvY0EnDNFgLiXk2/ravetAtS35FRCrln90FYUEW2L9BYVuGkNEZH7QUjc0DYNXz6yqbALgk3p9ajun5+99gzvBFJjEpDe1SQPqWhGFqj0hGVhhm0+h7UPGuNAcr4coqHm+6groDdfi2WYnWwt7t65fyIc3LxBaIzwhcRqOxoumUXuz2kWDAeiyqN89qb8vXV31WamBStATSijew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3EJBs8/kvCPX+GBdejebpUtEee3GlUonjlzhyYFqO0=;
 b=cq3F8q4PuXBf/+cNP3yQA2AoCjl/rNy5WPJbHaHcr1uV56+nhYpaPMRuUfE52a3EJ1pUzIgCWfU107LQvw8/4N2OuiyqZxXPoO+BF+f0n8zDFvQMDZfU2e3Kk2KSfH59wtgZ7Zaj+cICa8Jr8ilCEPWR5PxuPllFmx7Hg+x0oJ1t9GgQAkf3WpYYbRVcCh41FlIlPLK9KLkhn7cTdcxjuoMR8vGh7eNS/1IThspfEnlWJBqY96ACCH116qel+PiFqui0p/93CK+OgNCLRdiq+7n1Imv/KNyKAbEkdKxAx2mSVlRc1AtaAUbDulyyzhdbMGwtDn8dqUbsHDV+euyyBw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ0PR02MB7519.namprd02.prod.outlook.com
 (2603:10b6:a03:32a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.15; Wed, 30 Apr
 2025 18:45:18 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 18:45:18 +0000
From: Jon Kohler <jon@nutanix.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang
	<jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend
	<john.fastabend@gmail.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] xdp: add xdp_skb_reserve_put helper
Thread-Topic: [PATCH net-next] xdp: add xdp_skb_reserve_put helper
Thread-Index: AQHbufmTrAKec1Ywc0eV+I87nYhU07O8hnmAgAAEWoCAAAE2gA==
Date: Wed, 30 Apr 2025 18:45:18 +0000
Message-ID: <2EB0DFB0-E12D-4FFC-89CF-CF286A9CF8E2@nutanix.com>
References: <20250430182921.1704021-1-jon@nutanix.com>
 <68126b09c77f7_3080df29453@willemb.c.googlers.com.notmuch>
 <a6a8625c-9d20-48eb-b894-7bd6673a16d3@iogearbox.net>
In-Reply-To: <a6a8625c-9d20-48eb-b894-7bd6673a16d3@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ0PR02MB7519:EE_
x-ms-office365-filtering-correlation-id: 2c08c863-d499-42fc-243f-08dd88172772
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTU3L2ljSEFEMXVONURjaUR5YVQwczVtSXBOeUFFdElRNmNQOWYrV2kvNXU5?=
 =?utf-8?B?YnY0MURTd2djR2thUGVYOVdCUFRIbTdpSXlkeWdacEZiYjBuYzczSUNnUjVD?=
 =?utf-8?B?cGVGdUZOMmd6QzFUUXVuNVd4ZDRBeU1ROWl1QzYzQUQ0V2MyME5PcUROUlha?=
 =?utf-8?B?c3AwWXhyS2ZhZ2FuakY1WGVRNWtkbS9SRTAxOTNEQmVWM3NMZWpVKzRWcFht?=
 =?utf-8?B?N3YrMXZnNS81YUJsM3ZpWDVxTDRDTVVianR3M1BmQUppb3J6a2tJVnlqMC9U?=
 =?utf-8?B?SlFQbDJaOGJja2hCSjBHQm1RdVhBWFk3NHJNUGJmZHlvMmxtaTJQeVpEVUg3?=
 =?utf-8?B?U1hhc0hMNWNVN216T2xOMDJuYjVOS1U0UTJ2NkNNTjh5ZmlnMGJKUjd5S1NQ?=
 =?utf-8?B?azV2RUo4WVA0TkZCd2duSU5JbmR0SW9KVGx0VjlKSklhU3JxNWNSRDJ0MDQr?=
 =?utf-8?B?WXhJN1pOTERRMmVwL3pJb2M2QVhyb2VkU3Aydks0d1FsSjVVRkFTMlJ0MzRF?=
 =?utf-8?B?aXMzbXBrSWxHK3hrMk9qTkcreDgwVjZHYnhJbHJ0MGlDRFUwMzJsS3RlcU9t?=
 =?utf-8?B?TGpxYUNZb0FCMlU4RFQ5bkc2Mko3QnRVdUlZUXBPNWdWZ0NVak9VVWlZaGhv?=
 =?utf-8?B?dkdDZmc4dzU3L2VJcEFONVhqcU5xUG96UTVJMmF1UzB0NFBpV1BpVzdvTEpT?=
 =?utf-8?B?M3hXUmU5QnNvNUxzcXVtNVFoc2dWNkRkVW9OV1FYdzdiWS9pVEUyaVlNSUpP?=
 =?utf-8?B?citmZ1RxTGRVM2J3b1ZreDF4VlF4cEVXRTFuNytRaEtIY1hPYzRJZWJjSnhF?=
 =?utf-8?B?Z2ZJMGlWbzRJamJENFZsVVd5V3pZTWhPSWtLeWxrVjc3MzRnbFlDdUoyVUNr?=
 =?utf-8?B?ZTEyOHdadXlYOU50dGgvZUlsNnZMbCtjRUQzMXNkUVdBSFV6QmNoekRlTlBO?=
 =?utf-8?B?M0RJUGZCU096b01rbmNpUlpudkoxVzVoRTQ3R0RQVU9vNE1ZZ1hFZk5CaGlB?=
 =?utf-8?B?TWp4TUNFMzkyOXk4MGhwRGIxR2hSWVUrMzBGdjFVYVJjTDc2a1lwRVlxWE10?=
 =?utf-8?B?bGZnZ1IrVzRKTHJrUGE1MjROL2ZnaWRUVFNiRHNGTmhxTlJ1UzNpd0g2Zm51?=
 =?utf-8?B?N3NGYXF6d1AxOUxUVktQL3FzR1dqZnJENlF3VENkVzk0OGkwNVBwTjZrV3JB?=
 =?utf-8?B?TCtmTUQrTHo0T1FaT3cxUlVHSThKSCtSMUJhN0N6eGVQbUtSRm4reDhIZWRK?=
 =?utf-8?B?QUdCKzdMQmdKcFdaN2VvYml4M2dSeGhxeHVQYTM0YXFHZG5jWWxDM29ndVEy?=
 =?utf-8?B?c2twOWNkTnloZ01mZEo2UmV3UzBucU9qU0VEYlVDNjhqVTdldmhMTkt5aDha?=
 =?utf-8?B?bDM0NXJyRTRTUDZPQWQyYkFzKzJ6cVVocEEvTmU0SWVOQ3lkeGZUTEhZMmhK?=
 =?utf-8?B?MmcwQ01IbmhZeWdBNUF4cjUzc1ZReklhWmczeWM3emtFVVQ2M05xTDBFTFJC?=
 =?utf-8?B?eDFOMkFKbk4yUC90WmxTMmlHWDdBQWsxMjZEVTBxNC9TMkdPT0J4RHJETlFL?=
 =?utf-8?B?VzZnM3RBMmhNVEVQYVZ0NCtMdFdzTWc4aUd6ajNVNWYwRVZhRWYvN3NxSzc4?=
 =?utf-8?B?bEtXb1lhR3hHTDNQckoxZTNQL1JhSjY5MVJ1T2M0Unh0V2xmVDdITEF6VDJB?=
 =?utf-8?B?SGZGUjBOY0FKS2hNSlA2MExnZFo2dGs4S0xKRERFMlUwYnczOEJ6MWZrcXF6?=
 =?utf-8?B?bUhkVXllK3JuTUFvbVlZcmRYZEFiQU9KSFNhelR4bFJUNVVZVUp2TnpyYkJp?=
 =?utf-8?B?M1hhMHR0Vk04S0tkaWZWbHQ0Vkk1aGQ2UExnRGttS29MekZoYUJWOS8wN3dj?=
 =?utf-8?B?VEZIRTFXRVBnbDlCR3VPdlVheklwRUt6c0M0azNEVmZKUUM3L1hYRTJTNSsy?=
 =?utf-8?B?TDEzNThkN0QxMXhneXhhaFJBOUJGSmRDSnRVVjczNnVaL3BEcDhXU1lxTkw4?=
 =?utf-8?B?c0IvK0FZVU5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzk2YU1odGwyVEhLaVg5dy92b00wNzJmSlFvL0owSWJtSGZ1bFpVQWp4VWpB?=
 =?utf-8?B?dmRRMkNBYTl5QTlzZlJiYWpyQitEZ0hTa0hOVmFyVUVFUUxMSW9zT1lvdity?=
 =?utf-8?B?c0hYYWh4alMyQmtQaHZzemlEVUlWU0JNSEJFeU5SSVc3TUNoL0pCdE1SUTUy?=
 =?utf-8?B?SERCWVVKTEdkMGxZZkowaVFRQjk0bmgvcXpOcHBKdFp1L2J3VzF1dDBQSERH?=
 =?utf-8?B?UUtWNitoMmxNY013VXRteXNDQ3lCY3lOMm5ZdmVXblZ5T2xmVm1wUGpLb1o4?=
 =?utf-8?B?S0xxSmc3VFlReXBlQ3RyQjZvRmhpMWF3a0FHOWZFT3lhRmxLQzZ0M0tLbVR6?=
 =?utf-8?B?TExRS3NhbkswbXZNTFMwTUMzeGxpMXBDQ0dRVld3dUtGRC90ZmVybmxRNFN2?=
 =?utf-8?B?RGxsOUJmTTNTL0pNTVN3RGFzeURSRTJkYS9zc25FR2ZhMmtGS0JURlQ3QzVt?=
 =?utf-8?B?ZDNuQkw2N0ZhY2RGTk10REpzOVVaWTVzSmlTT3kxRFdpTTdmV3k4RWxoVWlr?=
 =?utf-8?B?dHQ1aWY0Q1RlbHlTMWk2WVhIMjJwZWl4Rnlzd1NQRXlabmN4YkhQQzBscGo0?=
 =?utf-8?B?T1pvS2VUMklUMDIwY2FXazVMdEtBYlh5T0VNb1ZWT0Zib1Q0WTRSRDNxSGRu?=
 =?utf-8?B?eE55RjdiN0ZrV0xRUUZWa2xRZXd6MlBRWDRxSFh6MVA5TWpoU3BzQU5IRy9Q?=
 =?utf-8?B?WGsrWmR1QzlQRHFvWmxxd1I5RTNkSXRKdzJkM1hlRWJzUWVJa2IzZjBDWlZQ?=
 =?utf-8?B?OU9kUjhMbmhNUGdBR0tod2FRUVY2NVZ6UGs0MmxBZG1yVkdPeGJoZkNWQmNo?=
 =?utf-8?B?a2xObzdmNlVVQVFRSHQyZFdmVGozOE5VTWxIdEJBWGM3bnNacDJpSC9DamY3?=
 =?utf-8?B?VDlyZDFOOVFEdnZKMW4zYytTYzFzQUFHMlZVUmRBLzF3SjF6dTRBK3RRRDlI?=
 =?utf-8?B?Y3VkMnhTT1I0ZjA4elVjQXdjL3JUQktadlloaHdoWTEwbkV3aGtER0tPRysz?=
 =?utf-8?B?empDWEpBQUZSenFZVkh0T3JhZHhUbis3R204NVdwZ2pTNThTd0gxTFdqRlJv?=
 =?utf-8?B?bVYzRjJVRGRTTXYwampldzl1MzNxZUVCV29hVDNjbys1bDdjSENBTzBrbFRF?=
 =?utf-8?B?UEFtaWJRTEE3UVRVMEp1ZDhEWVY4dlhoVTFEYzVNOGRkb0pEUmtmeWl0dWRr?=
 =?utf-8?B?NkdaZUl6SWhvdXFBY3FjQWl0VjRJalgvQmx0RVNRRUhCNVVmNXNSUUQxcDYr?=
 =?utf-8?B?VXlVemdkL2tsSDN5aGJFUHNGVnl2bDY5MkVzR1hSMzdEZnlScDloaWx4amtL?=
 =?utf-8?B?bFN1T1VFeGxRc1IvSFh0bDRKOEtiVDlQRTRBNk94cDlMdUlYUW5ndmE2OUxZ?=
 =?utf-8?B?M3JKM3J3UXdSd2hTZWt1ZFdVQUVoTzBMSHdWVFdiVmlLLzdGOWtZT3RiYlNh?=
 =?utf-8?B?c05PRjNCa084blJNa1grS0ViQkc3U1FQSU9LaVpnMm5ZOStUYnlaaThVRVhY?=
 =?utf-8?B?c0JlNHBXM0Z4NGM4UXhqRFJCY0NGcXk3OFlGRVRWQ08xNk1oT0huQXZ5YzY4?=
 =?utf-8?B?VU00eW1OanZVVUhIcW9uUTlYSnArRURmYU0vYklza3pYSjRySjBybk1mbHhK?=
 =?utf-8?B?dmF6aGVXeEVMSXRLeXljRXBLUjdKOUozbGVvOFFJQWtWK0dSdW56N0ZESnNk?=
 =?utf-8?B?T1lzdytZcUNUWSs4NTMyNktEdWE5OHJyeHI4U3crVUJmTGJEVVhZRnF3V1JX?=
 =?utf-8?B?TkxQQmZKOWtYM25LSEhBdlZ2dGIxUjdveFZIN3ZQRjdoaFZWZ2drTDJYTGNX?=
 =?utf-8?B?eWoyVkZNa05sb2RURnBnU0IyeFAzL0R5cEU2TU1ySVhPTHRwQ1cwMDAyYXZJ?=
 =?utf-8?B?NHdZMVJJY0RWd3ZFSUMwK2xUNnl4WnVRRHRSaGUzZ1RwRW0yVWZ3MFlyaWlu?=
 =?utf-8?B?STd2cVM2QjY5UldydUZpRlNLTitOYUxtTlVLL1NHYjYyK2tkQnAyVmkyYTBm?=
 =?utf-8?B?TVZ1TUUyMzZDRmNQUTRHdFhiZjlrRWlGQzJqVmRrZ1dpZDhuRU8wUU5UeGMx?=
 =?utf-8?B?VnVnVzNXK1V5VkIxdXRrRVdKNURjaDFaMEQwekRmL3Z6aXFZVFhwdEZ0WXJB?=
 =?utf-8?B?cVQ1aEFtWnZBY0JQWFBmZDNsQURiNnMraWU0R3JmWnphSnM1eC9xaldBa1pr?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A49E57F62448B4BB64855A1664EBC14@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c08c863-d499-42fc-243f-08dd88172772
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 18:45:18.3391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaZfVxNoBiEsJnjwsxC0BFTRnEDPoo/3Uhlrf5yWvFBB6JJC5eTuvpCPpe2DLoptePO49ovI7h7zwwDafCNvV0OPtHQWCkKktLB/zUGp0xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7519
X-Proofpoint-GUID: 5rlno2fePd7pqbGfAds563c2CB11uWfd
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=68126fc1 cx=c_pps a=4/dVwHrG2xlZHl48ITU9gw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=hWMQpYRtAAAA:8 a=64Cc0HZtAAAA:8 a=41GrrkFomP-I7gHIjJQA:9 a=QEXdDO2ut3YA:10 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEzNiBTYWx0ZWRfX4QB5MZZxI0T5 p44JgBPgxp7GFVpr1SgC3EvKuQWo0yVtmiwVK8vQzve8K4XTwkaSeSZOq69gi3OilE4g3zjRbO+ 7nx+ldzM3R1p/64WvGRknkqBtIU3noDOBx6xrhw2lnCjtD/YGUhx/9DVlZSxtY8g6Zl/li8KdX2
 sPXV2gGZqRItq4MRh9MZmOEQLqpWe5kjV32/j9wfjpoX4jnJZK1P9I/BE8s7hNDt1kAg/3/m1AT IdUHmnH6HuoVldd07wXvgIiojB8SnlNVeNjDs8GGCbnVGzjDqeY//UDkitLE8UjXBwz4yEta5vq raSZrXvZVwSDpPkhNY8Ljr/pYwKQoeE5fhEAAvyPYOuhM8hLTa1zua9qIZh19kgVG7Sbkjsy3CN
 jk3U08HG3L5bpTknZJ3zcCcxaxOHXdVxfw8BiHBvKlk0xzLfbJlFUzulmN/BuB7JCz/cSWWq
X-Proofpoint-ORIG-GUID: 5rlno2fePd7pqbGfAds563c2CB11uWfd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDMwLCAyMDI1LCBhdCAyOjQw4oCvUE0sIERhbmllbCBCb3JrbWFubiA8ZGFu
aWVsQGlvZ2VhcmJveC5uZXQ+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+IENBVVRJT046
IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIDQvMzAvMjUgODoy
NSBQTSwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToNCj4+IEpvbiBLb2hsZXIgd3JvdGU6DQo+Pj4g
QWRkIGhlbHBlciBmb3IgY2FsbGluZyBza2Jfe3B1dHxyZXNlcnZlfSB0byByZWR1Y2UgcmVwZXRp
dGl2ZSBwYXR0ZXJuDQo+Pj4gYWNyb3NzIHZhcmlvdXMgZHJpdmVycy4NCj4+PiANCj4+PiBQbHVt
YiBpbnRvIHRhcCBhbmQgdHVuIHRvIHN0YXJ0Lg0KPj4+IA0KPj4+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlIGludGVuZGVkLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvbiBLb2hsZXIgPGpvbkBu
dXRhbml4LmNvbT4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9uZXQvdGFwLmMgfCAzICstLQ0KPj4+
ICBkcml2ZXJzL25ldC90dW4uYyB8IDMgKy0tDQo+Pj4gIGluY2x1ZGUvbmV0L3hkcC5oIHwgOCAr
KysrKysrKw0KPj4+ICBuZXQvY29yZS94ZHAuYyAgICB8IDMgKy0tDQo+Pj4gIDQgZmlsZXMgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+IFN1YmplY3RpdmUsIGJ1
dCBJIHByZWZlciB0aGUgZXhpc3RpbmcgY29kZS4gSSB1bmRlcnN0YW5kIHdoYXQNCj4+IHNrYl9y
ZXNlcnZlIGFuZCBza2JfcHV0IGRvLiBXaGlsZSB4ZHBfc2tiX3Jlc2VydmVfcHV0IGFkZHMgYSBs
YXllciBvZg0KPj4gaW5kaXJlY3Rpb24gdGhhdCBJJ2QgaGF2ZSB0byBmb2xsb3cuDQo+PiBTb21l
dGltZXMgZGVkdXBsaWNhdGlvbiBtYWtlcyBzZW5zZSwgc29tZXRpbWVzIHRoZSBpbmRpcmVjdGlv
biBhZGRzDQo+PiBtb3JlIG1lbnRhbCBsb2FkIHRoYW4gaXQncyB3b3J0aC4gSW4gdGhpcyBjYXNl
IHRoZSBjb2RlIHNhdmluZ3MgYXJlDQo+PiBzbWFsbC4gQXMgc2FpZCwgc3ViamVjdGl2ZS4gSGFw
cHkgdG8gaGVhciBvdGhlciBvcGluaW9ucy4NCj4gDQo+ICsxLCBhZ3JlZSB3aXRoIFdpbGxlbQ0K
DQpUaGF04oCZcyBhIGZhaXIgcG9pbnQuIEkgd2FzIGFsc28gdG95aW5nIHdpdGggdGhlIGlkZWEg
b2Ygc29tZXRoaW5nIGxpa2UNCnRoaXMgaW5zdGVhZDoNCg0KZS5nLg0KeGRwX2hlYWRyb29tKHhk
cCkgPT0geGRwLT5kYXRhIC0geGRwLT5kYXRhX2hhcmRfc3RhcnQNCuKApiBzaW1pbGFyIHRvIHNr
Yl9oZWFkcm9vbQ0KDQp4ZHBfbGVuZ3RoX2Jhc2UoeGRwKSA9PSB4ZHAtPmRhdGFfZW5kIC0geGRw
LT5kYXRhDQrigKYgc2ltaWxhciB0byB4ZHBfZ2V0X2J1ZmZfbGVuLCBidXQgZG9lc27igJl0IGxv
b2sgYXQgZnJhZ3MNCg0KdGhlbiB3ZSBjb3VsZCBkbzoNCnNrYl9yZXNlcnZlKHNrYiwgeGRwX2hl
YWRyb29tKHhkcCkpOw0Kc2tiX3B1dChza2IsIHhkcF9sZW5ndGhfYmFzZSh4ZHApKTsNCg0KTmFt
ZXMgVEJEIG9mIGNvdXJzZSwgYnV0IHRob3VnaHRzPw0KDQpUaGF0IHdheSB3ZSBrZWVwIHNrYl9y
ZXNlcnZlL3B1dCBqdXN0IHRoZSBzYW1lLCBidXQgaGF2ZQ0KYSBuaWNlIGhlbHBlciBsaWtlIHdl
IGRvIGZvciBza2JfaGVhZHJvb20oKSBhbHJlYWR5

