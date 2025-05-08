Return-Path: <bpf+bounces-57724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B3AAF163
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 05:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E325988401
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4CC1E32BE;
	Thu,  8 May 2025 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vdladxbT";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VvJz7jpl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC64B1E5E;
	Thu,  8 May 2025 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673391; cv=fail; b=tov26kWLMnj6x5iWz0EVeqWcWtAKbuASCa4LS3vlBpVdXTatH5zsiTmt1zINif4VDWwAkSiL1P5ANi2rb/T/+RPbT+9mw6NjsWpWcWKWK9kPTP86IL4dgbSpx1hLZv+fIHS2gxAqfUVhDXoCmkV1qjE93XyUpik7iTV1MegxZYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673391; c=relaxed/simple;
	bh=8ypWeJF6pA8AyevdkgrAGaBGcGVUkenyJwaKJlGDf7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WXU3JZ59TU5YmpoQxEU+w++EQhS0vfTVyg1IuGD/xCk46oajSRs0aGrijbvjDOr783Kr3Jf0lPcFtyPQCz0Ld87dTnFfaqOnti/SqSXZ/2uxuPk5SEW6uf60nizwZ02tnqq38Igu/LgQn5fsy8e8771/o09l2R4znxTN8WYYpz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vdladxbT; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=VvJz7jpl; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547LLPSC025796;
	Wed, 7 May 2025 20:02:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=8ypWeJF6pA8AyevdkgrAGaBGcGVUkenyJwaKJlGDf
	7o=; b=vdladxbT01CxFtEp2ptn10GLlDCwBIxU7N62TPUFMpaSjTphnYrJe9mdH
	x6DfMQmO2kVkbTgLU1tQy2HA+qW9TlsXZub7wnU5xtPNmm1bHzGafD2DM5PFXm7v
	wLrR3MIiy8tvMo9YeM6NCGjAFOqitPS5vTGjrnds/ioHQi3vCGC1bZkkpT96kwOd
	xX1D5C7Ho1pXvApBpXZl0DLKvnlxVFUil0At7rTi9fnJpT+DNwCLM8vzz6AKIiMX
	LSxcy+y45+qIxFAzz80cVOHNYsrjGIX0gFZ3S5FJOLGysB7KdT7a9dpA3+hbbYMa
	6W7o35JQbX1CWnRDZW0kkbsfXOalA==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dffutdv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 20:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIKI2b5snqqKWC3j18NXxu5f1lzFJ6Lev6rkq2ycQCHYBFoOJH03Wuicyq0g9Q/vYDBlx9IVX/5TXXxrbJjff+pYRhhmT15wMDOHuYQn4uUxsMnu2nKIi3cznd7yxRtwis6PEaqP41Qvn8OF7m2xeMCKfBhTOivqmQYRdec1UbzZsqLo1JMs8vNmXABZIv51NwMuk5mYVMxG2vxkxFsSEaP16WwusGOx28OOcKw/W/FSTsxlhMT/j83rUXr8+eQOT+OzIkdJm/M9Lhysr2nKYOkrNifRbjcst7wp6bMrHqOviRljkvzcrAFjaS3CCezRGvLzrwGmN2AgnquVw8K+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ypWeJF6pA8AyevdkgrAGaBGcGVUkenyJwaKJlGDf7o=;
 b=ZzhREyqUAdvRzGSq74lxXfOyxk63IMNICTqwZZaVPtLaW/Zg2gLnelPeZJIM8EK926xTzvOLFlr9F8dz/FcXb/Lls9mQYXs89k4NI7jCpNrRn/f1OlIuXZetBRyTKZXHRc8aSiTChpmCuWJPdy/I32wSXd/PTdx6r7o/YB3O+QZ/6hxJiD5spG7njQDDdE6cEQRXSXAzDkWvbohAHbnR3es9kkBhOLtCaXCG5tf4huKOchQK5arIPVRPBw42jcX0CNMqJAUuXJ4UF3u2zZy6zB4Kc4gTPEmYwGkrymotgSqq5PavFPmuLJiOGuEfXOa/Y4nRJrtdHBGUWEtA5Pu08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ypWeJF6pA8AyevdkgrAGaBGcGVUkenyJwaKJlGDf7o=;
 b=VvJz7jplNwWdGL5ACAV7kCKyByCFe5F6ialNab32QLx3w4dKa2yYjd8hzFlxnAH/BmxIk+yJ/Cg+PHF+xf9XcbSxLBCrfJc9aHjDc569Cr91JheQ3CdP3HgvCOcTA6OAKuV84IN0nodlSjBf49QNuGo0zdMCF+D2D6b6uBO3Q2GLkVFEntLIzJHCvO7GR2pH8sMAguO9cYneijVnvi2FTup9q6NUCV77Yiqa3P01+S16TyQ6JfVeuOhHkljonhFCZS+o/Rbo3MwixcwCdrXlQwl2bE864fjn4pxYLO5uDldrGLpCbBOoCd0tcjJHJUWjzsHurDnW2Mr7otVCEioxbw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by DM6PR02MB6777.namprd02.prod.outlook.com
 (2603:10b6:5:210::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 03:02:38 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 03:02:38 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] tun: optimize skb allocation in tun_xdp_one
Thread-Topic: [PATCH net-next 2/4] tun: optimize skb allocation in tun_xdp_one
Thread-Index: AQHbvpKvkdMEO7J8GkyVfXRl22UC0rPHpiaAgABn9oA=
Date: Thu, 8 May 2025 03:02:37 +0000
Message-ID: <3BE7CD63-D019-415D-B711-E508663671FD@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-3-jon@nutanix.com>
 <681bc78dc5005_20dc6429460@willemb.c.googlers.com.notmuch>
In-Reply-To: <681bc78dc5005_20dc6429460@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|DM6PR02MB6777:EE_
x-ms-office365-filtering-correlation-id: 95d41ec7-50b8-4f73-45f5-08dd8ddcca1e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUFUbEEwZFgvRWpLRGhtcmRwNVF6TmN4ckMvWklNOWk2S3FhRUdVQ0V3QjR5?=
 =?utf-8?B?SVkyYlhCRVY1ZjJud3o0WWJZZE9qckFTYWptSUIxSy96bzEvSklBM0VDbm9O?=
 =?utf-8?B?THJKOTNxVUpqVWNSMFlkVFJ3VTBuVnpFU2F3TkNYQzJkcmUxVEYrYjI0ZllK?=
 =?utf-8?B?c1lROVhHR2VBOHNJVEVqeUhQT1Z2Zk5BTmJWQjBla0JNbWxPQnVKVW50UVRl?=
 =?utf-8?B?cVhXMG8rRUxhd1VtMDdMRGJkbUZ1S1BYNm5tZytDUXdILzBmc2hmTHN6aE1m?=
 =?utf-8?B?NE0zZlR5ZnNiMVJ4NHlGb1A0K2h5d1VGeXhBR3hFYXdzVSs5TjAwRTFkQzF1?=
 =?utf-8?B?U0xpanlVdFRpT3lOdTl5VVlKMWliN1o3ZzJqdkdqNndPT1FVd1g0dlNWRHRX?=
 =?utf-8?B?R1lnU2Ixa2RjNVJITitzNWhGNmdiM1dkN0I5TW43YnVYdE1CSWh5TUE4UUVa?=
 =?utf-8?B?WEowMFJjUnNTOENtNHUyVnQzdXI2dTRoM3ZqTkZ6MDZNbmErRlB6RjJuK2ti?=
 =?utf-8?B?U0E2K0M2cXRFVFBZUEtobWx2R05TVFpuQmI3dmV2akZpZmNBcFlDTGMyZG02?=
 =?utf-8?B?eC9LWTUwSkc5ZnRDZFh1YTdTWjRwSGQ5UnNFeldZYXJwL0JqUmNmaW5JUjhy?=
 =?utf-8?B?enF1dVArak9wVkZzMnp5Z3pPY1dCcEd5T3hXL2ZmNS93WHFIVWdiRXNzMVpa?=
 =?utf-8?B?SmRwbGFvOVZ1emQxKys2Vm1PY0FqVWZUM0NTVndJN3JzWCtNd21qVTlpY2RJ?=
 =?utf-8?B?Y09MMkhNaENRcjlFZDZGZDk5N295ekhlOVgwMDJGckk0L1BXbUorVExuUHh1?=
 =?utf-8?B?Ukxxc2xnTERDOGZ5d2gxQ2ZJOEVRRlhacFpDT0E0UWlSa0hqZHQ4VlFQUkdt?=
 =?utf-8?B?LzhjckdrNnB6eTlwdVVVdUtBSXNhR2FMcEJkdTJzVnk1Y3VUN09ENVg3T1Nu?=
 =?utf-8?B?ekRxYWt5RVBLREpSR2Fid1h5clcwWHJ1dngvSElGWnVKR1dCSmhMbktyWDZB?=
 =?utf-8?B?ZzA1bmFxdjVHRWFXMFZ0YjBNUWVpOVNFalhCMTlqVGRoclUwTCtVYXBrYzJW?=
 =?utf-8?B?T1M0OVdienZoV2I3UVdmbTJaTGxPQVNBN1owQnFVb0QrQmJYMkJ4VHB4RjA2?=
 =?utf-8?B?NmJVL2plUUNQK0ZuMWJmNldUUy9oMGhJUlpUU1crcWNucFJJSXNWTTZrdDE5?=
 =?utf-8?B?VDdwWE40V0l2L3VkdzAvS1hzMG9mdFRGQkV2cXY5bDBpQzU4blFnZ2hTMHU0?=
 =?utf-8?B?SDJKUTRTWVZpVXloZ0RWVTJBV21SSkpxU1VVRXJaMEtQbkpJOEZvblQwemZ3?=
 =?utf-8?B?NUpzSzBtSUppbzNOeFZiTWRGMForaUZ5Nm9NOTJVZFJ2M2huVmZ4Ym1SMFZE?=
 =?utf-8?B?alVoWUI0cFZOcy9tb0hoY0NJbkkvTzlscHpjMzhvdi91b2tNNlYzeVpmdDhj?=
 =?utf-8?B?VzgvWURQNlRZcHZibndmaXRTK3JrcFBwWFNORlcrMjNiUDlmTDY3R3R1cm1B?=
 =?utf-8?B?M2NDYVNCc0NxU0kybzRNTjJOOElBV3JUT2dodkdza3lLNVlzUVplZXdoYzFO?=
 =?utf-8?B?aHI0aG9oOEwyQUhjckdEUEV3a1h1amdyQ0lieDM0Uk5JcGpub0kxY2hUWExR?=
 =?utf-8?B?Wld6MHJnWFF3VFNTR3hjc2tLdGNEQ2hxYlp2ZGpPS3VSbFBSaXkvbkN4a2pD?=
 =?utf-8?B?OENUR212SXVNd1VRQ0dsam04enR1VFB6SFQ5SS9uWEYvaDM5bXpDQ1M2Sysv?=
 =?utf-8?B?b2VpNkt3UGw3T2k1SVRlNG1JaXJoWUZzRUxwWmZGWEFXb0F6NzVBYVVmR1hq?=
 =?utf-8?B?VGRHZlp4eWJ5QU1QeUFmTEhYTjExVnFSam1ZSytVQnJHZ3hhaVdMbGUvWk0r?=
 =?utf-8?B?NEJ5ZWNPdEdUWHprc2JPR0hEN0s3UFJQc0JJSEl5cDVQQVh5RzhScU1RalA2?=
 =?utf-8?B?bU1LZ3ZUdUUxeHVKbVhqVW5Zc2VaLzBNOHpVOWNWYVUwY24rK1I1VVdGbndE?=
 =?utf-8?B?dUluL0hnRm13PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDdmL0l6bExaWUU4ODBxUDArWHJrdDYwdjVuUURCMzBKN25JUnJ2dzJ6ZEtz?=
 =?utf-8?B?MHg3L2w4a1FkREUyL0JvNjZYZkVqYnpxbW9yb3NTbC8yWEo2NEdSZFhxL0Jm?=
 =?utf-8?B?UUhUUGcvK1lnQmZXamtiL2lsaU5sQXdUUGg4a0l1WjhPYmpxSjh3ajhEVDBs?=
 =?utf-8?B?SGZIeEFnTzgvZ1dtcXF5Z0I3QnROTTlvaUdvbXNSbnVjd1ViRTdYUi9kM0RF?=
 =?utf-8?B?cTUzRWVHK1F1TVVJTHZUb005NnlpZnJmVzRZSkVDMmNEb1pubUk4eCtrREF4?=
 =?utf-8?B?dmRJcjBQMGZBTnR3RG9GdVU2emlOTVhIK2RVaVFEdFpIQm1VU21EdFhlWlN1?=
 =?utf-8?B?N1liQklFK2Z4YnFLVHVYTGM4ZnZQeE1JZVFyYW04SE9RMHhQVlJGT3VJTCsz?=
 =?utf-8?B?aEtkYWVRRVZMV1VlOWlTRkRnUDh0aURwWDRNNVpvY3VmaStKNk96NnBKRmRR?=
 =?utf-8?B?WjQ0UXdYQ01oY1N6Q3BjZGxrMS8rcTNIZ2NqQ1dLblM0VjN4TjRRL0YzVmZq?=
 =?utf-8?B?TG9pMzg5OGJIemx0MEtJeEVZWEhaNlVEUkI5MXovcHVEK2Y1QnNkUHN5WWtM?=
 =?utf-8?B?ZDB0R2cwRGJtcVV2YTlBMU53Z2dOMFhwU25YOWYxV2VGb1FnaE9jbFZiVGY3?=
 =?utf-8?B?aFZoR004YVhmL1dISGw4eG5ydHlzT3Y4dzNCZzV5UXRmbjJmQVpEa0IzbWtz?=
 =?utf-8?B?ei9yZzkrMHBUL294elduZGlKZHJyaVRLeEhnV25IdWZBb3g3VUNiSG5OT0l5?=
 =?utf-8?B?eXlhK25taHl3MTlRVERhNHpaNUVvUWZ1VVd4NzFMVUw5cVNJU3VBV1lSS2cz?=
 =?utf-8?B?QlpVZUs3VlQ2NVFOWDhBeTEybU80b0l3aHlTUEFjUm9OWjB6V2hkZ1pGeHRy?=
 =?utf-8?B?Ly9kS28reGF3OS9MNEZsQTFmY09heDBZbjFOUmR6dmJRSGZWRnBHSjA1QWFo?=
 =?utf-8?B?Yi9BZG5rdlJaT3h3eXVFYlc5eWZJV1crMXE4WnRXd3N0OXhOb2lVREFzQnBj?=
 =?utf-8?B?b1dONVZ4L3JnWmttc1dWOUU0a2F3K0dlUEExZFcybUw1WUgydHgvRGhXc0dq?=
 =?utf-8?B?REdvcmd0VkY0RFNWVCtlNXJGRjhvNGdBeDZvNjQ2amJZWjJkV0E3R1pqRE0y?=
 =?utf-8?B?ZEZaalg2RmlaM0N2SDFZeUJ1aHBBM2hRbzNRdmRoL1FYMk5RTjhQa3l3NWpm?=
 =?utf-8?B?MlRHL25jaHpQb05COGp2QjJmQ1pYNytXUnlCdThLUDRxZzYxQkRoYTgvZjJE?=
 =?utf-8?B?M2grNk5NK2VmTEVGSG1Fdkp3MEpjVE1Ud2ozMGNSblJuYWVuUTU4dWFaRXlC?=
 =?utf-8?B?YzdkNjN6U0hDMVd3NXpPRnpIMnNPcmtUTGNLWkgvRFpEaS9vS1BwT1hQSERR?=
 =?utf-8?B?MmpNcnY0VEpTSGZra0g1UFdteWNweTBuQUFmcHBEY2dlVHVFMmxWcThxVnRa?=
 =?utf-8?B?Nk9qV3FjU0ltejlvdmZlMjRsWUNBaWNDRnpPMGhpaHd1YlBsQkxwM1k1dEsw?=
 =?utf-8?B?MGNyaTdVZEZ3TXkvcjF5aXo4b0tqdFVNYUlCNURPcFdRRm1YU2xSaXFKWlFt?=
 =?utf-8?B?TGJnVUdwUUllNUVkamJFL2txR28yZi9TdlpVZzEyT1Y5OTdzQ0NCSXN6NzRU?=
 =?utf-8?B?UWNkZUdzVTJuaGVhUUxnUmdhWWNaSDdnaDJpazN6V3Z6aURBZndmMXdnUTdp?=
 =?utf-8?B?Z1NQeXIrMWZ4b1JwK3V6WFZVWU9TeXM0Vmlxa3lqNVp1dHdDcVFqLzFFSlpx?=
 =?utf-8?B?SHNHcUxKaTBGTWZ3ZER0M2Z3a3d4RlR5MkYzVkcrai9xdmMxdXA2cGZRMC9L?=
 =?utf-8?B?TXdZVkszYk1TRDlic3VDY01RUy9lTXk4VTdtNVQ1cC9KOUg0WERVcnJXM1VE?=
 =?utf-8?B?bERVYkxtNnBwcFBwK0xDbEdxeGpxbWVLb2piRnhXNlZ6ZmJSeWNINmY1Znlz?=
 =?utf-8?B?WE9ER0laNU5aVkovRlNhRFc4OWlUZkdIbC9iOWdMVURUT0NqcFh0SGlpcy9j?=
 =?utf-8?B?Y1VaZnhnN0hTRzc2N3dOajJ4VmhwSlYrTEg5d0F6VEd1L0FPanlVRTdOWk94?=
 =?utf-8?B?NDRLc1ZtYlNyN1NZS0d2dkErck54Mnh1TjNZQ2xKU2ZFT2lleWhjcTBqQVAx?=
 =?utf-8?B?L1hsWFhkWHE3ME96dExteVgyQ1RYT3hSVmdyaENGbHlTWDRJRi9ZSERLbWZG?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8745D2E94EE14446A695009900F46347@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d41ec7-50b8-4f73-45f5-08dd8ddcca1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:02:37.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUwZJQNFu0IILz0y7S2hVC4hMqEoVGzFbgH7Ny4brVuEE+aZ957+jj01k73Ew5TJyTB7JuGM15fh26uirFiFDr5n9ooahSo30ksS6F3/VAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6777
X-Authority-Analysis: v=2.4 cv=WfYMa1hX c=1 sm=1 tr=0 ts=681c1ed4 cx=c_pps a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8 a=iHgftp5bGqDLWn63dj4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hYXdSZ4qGA-xbBMROfpnJf7KYteVqmid
X-Proofpoint-ORIG-GUID: hYXdSZ4qGA-xbBMROfpnJf7KYteVqmid
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyNiBTYWx0ZWRfXzSK8TusAUdBU tOJvWQyzKCKyCyzX6LQr7IuXvMBc00X4SnUzP3Em3BjIzDyp0yVuLrPVKkw5kTI99gKFaiPOhtY t7MynDQOO1Fg5jMneX2YJ6jVu3wDQx4zPsY1Lz0WrWJvXilQIbNKcBkV7JhMs5SI7gneS20hN/x
 yvtL15tQfW5Wab8BCsR7WjgtO5+PPZ64Jzn4IoANYOtS62Q+yYNcQDVJslVYNZf/A+Xh5DmDiEZ SS43i/6GEtjv6iVMQRJQq1HFopy4kjYjPRFPeqqdioz7r5SbUh4kuUG6CNLy6s1UroCavowM18/ OKlP7+qBHbJdxtb9PtdCVaJAPHGcY+NlEZiQBYg/0uN22ofpqh54WvQtJq/X07pA6HbCI431LI6
 3LHEDlMFEB0eYHwnO9jgPO0w36gwKaYAAAaZStmDSdQpYRDj3wA10mJluCGHrc4k8apDLzT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDQ6NTDigK9QTSwgV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEpv
biBLb2hsZXIgd3JvdGU6DQo+PiBFbmhhbmNlIFRVTl9NU0dfUFRSIGJhdGNoIHByb2Nlc3Npbmcg
YnkgbGV2ZXJhZ2luZyBidWxrIGFsbG9jYXRpb24gZnJvbQ0KPj4gdGhlIHBlci1DUFUgTkFQSSBj
YWNoZSB2aWEgbmFwaV9za2JfY2FjaGVfZ2V0X2J1bGsuIFRoaXMgaW1wcm92ZXMNCj4+IGVmZmlj
aWVuY3kgYnkgcmVkdWNpbmcgYWxsb2NhdGlvbiBvdmVyaGVhZCBhbmQgaXMgZXNwZWNpYWxseSB1
c2VmdWwNCj4+IHdoZW4gdXNpbmcgSUZGX05BUEkgYW5kIEdSTyBpcyBhYmxlIHRvIGZlZWQgdGhl
IGNhY2hlIGVudHJpZXMgYmFjay4NCj4+IA0KPj4gSGFuZGxlIHNjZW5hcmlvcyB3aGVyZSBmdWxs
IHByZWFsbG9jYXRpb24gb2YgU0tCcyBpcyBub3QgcG9zc2libGUgYnkNCj4+IGdyYWNlZnVsbHkg
ZHJvcHBpbmcgb25seSB0aGUgdW5jb3ZlcmVkIHBvcnRpb24gb2YgdGhlIGJhdGNoIHBheWxvYWQu
DQo+PiANCj4+IENjOiBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRlci5sb2Jha2luQGludGVs
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4NCj4+
IC0tLQ0KPj4gZHJpdmVycy9uZXQvdHVuLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3R1bi5jIGIvZHJp
dmVycy9uZXQvdHVuLmMNCj4+IGluZGV4IDg3ZmM1MTkxNmZjZS4uZjdmNzQ5MGU3OGRjIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvdHVuLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3R1bi5j
DQo+PiBAQCAtMjM1NCwxMiArMjM1NCwxMiBAQCBzdGF0aWMgaW50IHR1bl94ZHBfb25lKHN0cnVj
dCB0dW5fc3RydWN0ICp0dW4sDQo+PiAgICAgICBzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLA0KPj4g
ICAgICAgc3RydWN0IHhkcF9idWZmICp4ZHAsIGludCAqZmx1c2gsDQo+PiAgICAgICBzdHJ1Y3Qg
dHVuX3BhZ2UgKnRwYWdlLA0KPj4gLSAgICAgICBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nKQ0K
Pj4gKyAgICAgICBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLA0KPj4gKyAgICAgICBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiKQ0KPj4gew0KPj4gdW5zaWduZWQgaW50IGRhdGFzaXplID0geGRwLT5kYXRh
X2VuZCAtIHhkcC0+ZGF0YTsNCj4+IHN0cnVjdCB0dW5feGRwX2hkciAqaGRyID0geGRwLT5kYXRh
X2hhcmRfc3RhcnQ7DQo+PiBzdHJ1Y3QgdmlydGlvX25ldF9oZHIgKmdzbyA9ICZoZHItPmdzbzsN
Cj4+IC0gc3RydWN0IHNrX2J1ZmYgKnNrYiA9IE5VTEw7DQo+PiBzdHJ1Y3Qgc2tfYnVmZl9oZWFk
ICpxdWV1ZTsNCj4+IHUzMiByeGhhc2ggPSAwLCBhY3Q7DQo+PiBpbnQgYnVmbGVuID0gaGRyLT5i
dWZsZW47DQo+PiBAQCAtMjM4MSwxNiArMjM4MSwxNSBAQCBzdGF0aWMgaW50IHR1bl94ZHBfb25l
KHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sDQo+PiANCj4+IGFjdCA9IGJwZl9wcm9nX3J1bl94ZHAo
eGRwX3Byb2csIHhkcCk7DQo+PiByZXQgPSB0dW5feGRwX2FjdCh0dW4sIHhkcF9wcm9nLCB4ZHAs
IGFjdCk7DQo+PiAtIGlmIChyZXQgPCAwKSB7DQo+PiAtIHB1dF9wYWdlKHZpcnRfdG9faGVhZF9w
YWdlKHhkcC0+ZGF0YSkpOw0KPj4gKyBpZiAocmV0IDwgMCkNCj4+IHJldHVybiByZXQ7DQo+PiAt
IH0NCj4+IA0KPj4gc3dpdGNoIChyZXQpIHsNCj4+IGNhc2UgWERQX1JFRElSRUNUOg0KPj4gKmZs
dXNoID0gdHJ1ZTsNCj4+IGZhbGx0aHJvdWdoOw0KPj4gY2FzZSBYRFBfVFg6DQo+PiArIG5hcGlf
Y29uc3VtZV9za2Ioc2tiLCAxKTsNCj4+IHJldHVybiAwOw0KPj4gY2FzZSBYRFBfUEFTUzoNCj4+
IGJyZWFrOw0KPj4gQEAgLTI0MDMsMTMgKzI0MDIsMTQgQEAgc3RhdGljIGludCB0dW5feGRwX29u
ZShzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLA0KPj4gdHBhZ2UtPnBhZ2UgPSBwYWdlOw0KPj4gdHBh
Z2UtPmNvdW50ID0gMTsNCj4+IH0NCj4+ICsgbmFwaV9jb25zdW1lX3NrYihza2IsIDEpOw0KPj4g
cmV0dXJuIDA7DQo+PiB9DQo+PiB9DQo+PiANCj4+IGJ1aWxkOg0KPj4gLSBza2IgPSBidWlsZF9z
a2IoeGRwLT5kYXRhX2hhcmRfc3RhcnQsIGJ1Zmxlbik7DQo+PiAtIGlmICghc2tiKSB7DQo+PiAr
IHNrYiA9IGJ1aWxkX3NrYl9hcm91bmQoc2tiLCB4ZHAtPmRhdGFfaGFyZF9zdGFydCwgYnVmbGVu
KTsNCj4+ICsgaWYgKHVubGlrZWx5KCFza2IpKSB7DQo+PiByZXQgPSAtRU5PTUVNOw0KPj4gZ290
byBvdXQ7DQo+PiB9DQo+PiBAQCAtMjQyNyw3ICsyNDI3LDYgQEAgc3RhdGljIGludCB0dW5feGRw
X29uZShzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLA0KPj4gDQo+PiBpZiAodHVuX3ZuZXRfaGRyX3Rv
X3NrYih0dW4tPmZsYWdzLCBza2IsIGdzbykpIHsNCj4+IGF0b21pY19sb25nX2luYygmdHVuLT5y
eF9mcmFtZV9lcnJvcnMpOw0KPj4gLSBrZnJlZV9za2Ioc2tiKTsNCj4+IHJldCA9IC1FSU5WQUw7
DQo+PiBnb3RvIG91dDsNCj4+IH0NCj4+IEBAIC0yNDU1LDcgKzI0NTQsNiBAQCBzdGF0aWMgaW50
IHR1bl94ZHBfb25lKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sDQo+PiANCj4+IGlmICh1bmxpa2Vs
eSh0ZmlsZS0+ZGV0YWNoZWQpKSB7DQo+PiBzcGluX3VubG9jaygmcXVldWUtPmxvY2spOw0KPj4g
LSBrZnJlZV9za2Ioc2tiKTsNCj4+IHJldHVybiAtRUJVU1k7DQo+PiB9DQo+PiANCj4+IEBAIC0y
NDk2LDcgKzI0OTQsOSBAQCBzdGF0aWMgaW50IHR1bl9zZW5kbXNnKHN0cnVjdCBzb2NrZXQgKnNv
Y2ssIHN0cnVjdCBtc2doZHIgKm0sIHNpemVfdCB0b3RhbF9sZW4pDQo+PiBzdHJ1Y3QgYnBmX3By
b2cgKnhkcF9wcm9nOw0KPj4gc3RydWN0IHR1bl9wYWdlIHRwYWdlOw0KPj4gaW50IG4gPSBjdGwt
Pm51bTsNCj4+IC0gaW50IGZsdXNoID0gMCwgcXVldWVkID0gMDsNCj4+ICsgaW50IGZsdXNoID0g
MCwgcXVldWVkID0gMCwgbnVtX3NrYnMgPSAwOw0KPj4gKyAvKiBNYXggc2l6ZSBvZiBWSE9TVF9O
RVRfQkFUQ0ggKi8NCj4+ICsgdm9pZCAqc2tic1s2NF07DQo+PiANCj4+IG1lbXNldCgmdHBhZ2Us
IDAsIHNpemVvZih0cGFnZSkpOw0KPj4gDQo+PiBAQCAtMjUwNSwxMiArMjUwNSwyNyBAQCBzdGF0
aWMgaW50IHR1bl9zZW5kbXNnKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBtc2doZHIgKm0s
IHNpemVfdCB0b3RhbF9sZW4pDQo+PiBicGZfbmV0X2N0eCA9IGJwZl9uZXRfY3R4X3NldCgmX19i
cGZfbmV0X2N0eCk7DQo+PiB4ZHBfcHJvZyA9IHJjdV9kZXJlZmVyZW5jZSh0dW4tPnhkcF9wcm9n
KTsNCj4+IA0KPj4gLSBmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKSB7DQo+PiArIG51bV9za2JzID0g
bmFwaV9za2JfY2FjaGVfZ2V0X2J1bGsoc2ticywgbik7DQo+PiArDQo+PiArIGZvciAoaSA9IDA7
IGkgPCBudW1fc2ticzsgaSsrKSB7DQo+PiArIHN0cnVjdCBza19idWZmICpza2IgPSBza2JzW2ld
Ow0KPj4geGRwID0gJigoc3RydWN0IHhkcF9idWZmICopY3RsLT5wdHIpW2ldOw0KPj4gcmV0ID0g
dHVuX3hkcF9vbmUodHVuLCB0ZmlsZSwgeGRwLCAmZmx1c2gsICZ0cGFnZSwNCj4+IC0gIHhkcF9w
cm9nKTsNCj4+ICsgIHhkcF9wcm9nLCBza2IpOw0KPj4gaWYgKHJldCA+IDApDQo+PiBxdWV1ZWQg
Kz0gcmV0Ow0KPj4gKyBlbHNlIGlmIChyZXQgPCAwKSB7DQo+PiArIGRldl9jb3JlX3N0YXRzX3J4
X2Ryb3BwZWRfaW5jKHR1bi0+ZGV2KTsNCj4+ICsgbmFwaV9jb25zdW1lX3NrYihza2IsIDEpOw0K
Pj4gKyBwdXRfcGFnZSh2aXJ0X3RvX2hlYWRfcGFnZSh4ZHAtPmRhdGEpKTsNCj4+ICsgfQ0KPj4g
KyB9DQo+PiArDQo+PiArIC8qIEhhbmRsZSByZW1haW5pbmcgeGRwX2J1ZmYgZW50cmllcyBpZiBu
dW1fc2ticyA8IGN0bC0+bnVtICovDQo+PiArIGZvciAoaSA9IG51bV9za2JzOyBpIDwgY3RsLT5u
dW07IGkrKykgew0KPj4gKyB4ZHAgPSAmKChzdHJ1Y3QgeGRwX2J1ZmYgKiljdGwtPnB0cilbaV07
DQo+PiArIGRldl9jb3JlX3N0YXRzX3J4X2Ryb3BwZWRfaW5jKHR1bi0+ZGV2KTsNCj4+ICsgcHV0
X3BhZ2UodmlydF90b19oZWFkX3BhZ2UoeGRwLT5kYXRhKSk7DQo+IA0KPiBUaGUgY29kZSBzaG91
bGQgYXR0ZW1wdCB0byBzZW5kIG91dCBwYWNrZXRzIHJhdGhlciB0aGFuIGRyb3AgdGhlbS4NCj4g
DQoNCkkgdG9vayBhIGhpbnQgZnJvbSB0aGUgb3RoZXIgdHdvIHBsYWNlcyB0aGF0IGN1cnJlbnRs
eSBkbyBidWxrIFNLQg0KYWxsb2NhdGlvbiBkcm9wIGF0IGxlYXN0IHNvbWUgb2YgdGhlaXIgcGF5
bG9hZHMgb24gYWxsb2NhdGlvbiBmYWlsdXJlLg0KU2VlIHRoZSBvdGhlciBjYWxsIHNpdGVzIGZv
ciBuYXBpX3NrYl9jYWNoZV9nZXRfYnVsayBmb3IgcmVmZXJlbmNlLg0KDQpBbHNvLCB0aGlzIGlz
IHNpbWlsYXIgdG8gd2hhdCB0aGUgY29kZSBhbHJlYWR5IGRvZXMgdG9kYXksIGJlY2F1c2UNCmlm
IGJ1aWxkX3NrYiBmYWlscyB0b2RheSwgdHVuX3hkcF9vbmUganVzdCBFTk9NRU3igJlzIGFuZCBk
b2VzbuKAmXQgZ28NCmFueSBmdXJ0aGVyLg0KDQpUaGlzIGNvZGUgaXMgYXQgbGVhc3Qgc29tZXdo
YXQgYmV0dGVyIHRoYW4gdG9kYXksIGJlY2F1c2UgdGhpcyBjb2RlDQp3aWxsIGluY3JlbWVudCB0
aGUgZHJvcCBjb3VudGVycywgdnMgc2lsZW50bHkgZHJvcHBlZCB0b2RheS4NCg0KSGFwcHkgdG8g
dGFrZSBhIHBvaW50ZXIgaWYgdGhlcmUgaXMgYSBzdWdnZXN0ZWQgcmV0cnkgbWVjaGFuaXNtIG9m
DQpzb3J0cz8=

