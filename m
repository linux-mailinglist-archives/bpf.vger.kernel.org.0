Return-Path: <bpf+bounces-27031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAF8A7F84
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 11:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A91AB22151
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E792612EBDB;
	Wed, 17 Apr 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RngPEZMd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ne2Ce5cd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB393F516
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345696; cv=fail; b=gUMqaoaOzxyfGtAY0uxVfJbrSoAt1bNhshlZO8+SR+ElHzyH+X3hhuX/dD2Kk41Zend8/xWlhLo9197x7PSFUr6Xvf5ZQXqXv8M2zj5t/No6xSlKTerF2bW9agg5+AfIHRgQ9I1Pk+gqPs3nxKF/EcAHl7us8ZlK6EYW2Wcfhe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345696; c=relaxed/simple;
	bh=pzawfqCbqeaJMxDqLwTq0ZAM9Yyn/Rj/l4MzFEyVyx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nk+EKDPVrOxIhqBc8buSD4oxYviYZ2sgR/uHEe35Z50CXRwYvtVmUKWtkhQ9FKyWntK/7K1cHVDGpLsYM710L8U/kMlyBJvvc+yLCOqIBONYSQMkEn5sNvXbFfo3Qx55+lE9UQfCQ2TefjGtCWpc7WZ1CkGQY9iginpLu3LqYLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RngPEZMd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ne2Ce5cd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xOYO021925;
	Wed, 17 Apr 2024 09:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=p4oZTIamYPpqw0OAVcuiZpwv107jfqF3nGyTGTzY4Gw=;
 b=RngPEZMdXgcmxukR6FnHRiKcB59MViuNYwdkYdO9CdY5L+D3emaUZJqaz52CNWz5ebzr
 /coagAvK/O3ar9PcyaLlc1QRNLML5J1D1C3pF1VGU/jyw8N0o2/PaMQCoN9I7S9uMEcC
 ITaTEaeQgUcFcCjog/iyTxdkLgRyFz0ogPubajYCLi1v+56H90mFI/oJ1cActDcYUdRZ
 sRw7n/BIOtXKSqZS/JkdUA+Dl9swfjT3RGkSieO+L+ZU8ykoOAbBGicr9Lzmmgvkn8AY
 gam1uLkqaH6O/KAm+tJ2j3joPEaY4JmHYbegmeMdGFENEFDEbdwQMp5xy5Mr0zll/Qy8 eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv7a1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 09:20:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43H965QN012555;
	Wed, 17 Apr 2024 09:20:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwghhs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 09:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AotNJE4V+DI4pmGx8N1p4YzfcDU7xaZMTa1tNlRlrcU1SMIKTdZiRlt8q20ZqldrQkhg2OlzZuRRK9JBC9KC/KHi7y2RMArV4arrDlpZxfK4c0P1L/g28603ZmcH8uDMbV9OqQGMXQQznAx0+fSN+kNFmSzQzuwr7H27rVZGJy7k7QkfJI7zpqdHsGYrF9qEMHD/Jzpvx+xwE+ny1Zw1pCsDdv+znsgeLFs9cJYDoLJoOABKXMSREvFQDnKlqTA+ePVZr+6M9Fo6XWRBDT3p1BENCVTrr44GSIihsHP3Zxq5SeSZPxJo7+HAuQDf3Rage6IpPiOjN/1QKk42whYIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4oZTIamYPpqw0OAVcuiZpwv107jfqF3nGyTGTzY4Gw=;
 b=CQnEXPuYPkZ/a6ZhGQONbg8RP8WlayVIKYFeXoleIcns14CR6PzEbA/6FdaCDYEm57TltI/nZ1r27ORf0GMIQdQjXaS4D5zTnorS4Ik2BMg/6S0T1oHu1jLKJkqp7ATI/fltaPygEKJDs3lc6RrwUwnvTKkf7vVH68sk+7hStHn6VZ9g5fWV4ruIoug0m7Fyl0rmV+FrubBdCFJ+YEif9KIuczqD1Em7sRQCZtm3KPLC7jUNjaUO8jSvxHqh6oJURJfdkfCeCwBMFOvFXKP2jo4xA+f3pnisDyUGIvDs30cyMIIxwtl3EmhrbceR0VlxDe4XzeTt7pip91LaBzs6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4oZTIamYPpqw0OAVcuiZpwv107jfqF3nGyTGTzY4Gw=;
 b=Ne2Ce5cdCX3vM0hFThz+MZDG+uAep9y8/aGlpGrWwvNFlCV5g2i5ibiYq0BvM+x4kqBXUpMf8ZappGhJVrsmNoVOYoMJ4RzkmmJixzuNHmOUdFJrwoJzyQ2CF+dZoQRJkKtnay+P29ZxakJRddBpP6q4mobZyYY7LLo794GhXkc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 17 Apr
 2024 09:20:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 09:20:45 +0000
Message-ID: <76869286-5593-470e-b04a-e38f1613c361@oracle.com>
Date: Wed, 17 Apr 2024 10:20:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v6 1/3] gobuffer: Add gobuffer__sort() helper
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org,
        quentin@isovalent.com, eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <cover.1711389163.git.dxu@dxuuu.xyz>
 <ba9ff49e099583ab854d3d3c8c215c3ca1b6f930.1711389163.git.dxu@dxuuu.xyz>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ba9ff49e099583ab854d3d3c8c215c3ca1b6f930.1711389163.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: a8017306-a8f0-4053-8a80-08dc5ebfa92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e3WS7J3I4wTWZEP9PeRfyIMCC+LRWrt3tWtzrcbMu1v66Vj4FaJpqX7TRApD41Jgu6h+QgPYD70vCfOYCkUh36dhO3V4vScfl+vfmjqWS42KtxQXjYx6sBjkzEv3CPWkc1444zJU93g+E4lrKz6cr7ub31VG5Z1JJMwSZOwmH4RyrJiy6jqUJmkZ3JGKePSDJjnIYVoCxFv378y5t2TV/zdGaDh/jBUxaS+Yk4JuUxYr5AYhwnZ4m2nWEfi6b1YNJdXCOcVf1kwcQ2L4RAGhYKw/7W/ZhOdXzKTLEzGhGisPxx3IHIFnTp+jji5ASi6JgOTek2GWgCeAcSFhGGccAMulxYBZPs56KVTrYdECOmYQX8Ln0K0tPRIziQ8yMjYxYde8b8eP1/FvDFmYiDH6lw6m6B4+litJR5l6ylAeceXlO0yRc50uk/jdBgA8/JQcT9YWJ8xfHDg+N0TYIKw9OIH+qTUOE/n5lwHFJNY0tQte3iK+oPVsEDTyymjeZV5VLKRGmt5d1e9O3c70UKYdG6PVZpUp3ApcMIqwL7oS1TPU9qWDn84yMApT1svkRWzSW/SmMAcrDMMXjQhTTw/CyzwCzI9cMwYUJTerFL+Y4WJm+CiycauqcDHPA8+6m4HCokuBMOZW/uoSyLh1AR63E3W++fmg+zFNqlF89aKmSIY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjI3Q0tBQlpYYzVCdGgwYURuN0tpYkkvMnBtN1VseVZlZUo3c0NjYmJoVVVp?=
 =?utf-8?B?dUtKRFlsSERjNWZiY2VGVU8rZ3lDK1VCQlJ6c0VXL3lqY1dYSnQ5dGFvTkFk?=
 =?utf-8?B?b1BkT2lSdFV1Mk9sSGNWZkp0S0lyKzNyZWx4YytPRk5sZ0s4YzVpcGlaUC9Y?=
 =?utf-8?B?NjlaTTIrc2hjUjBvTUkwTjhDaGUwWmZoWGgzUWp3dEE4UUpUdDhuWnpVbUdJ?=
 =?utf-8?B?RHBjNHoveUYzWVF2WTY5VCtYQ29sTzR3QjRMSlhvQXZlaFRxTTJZellFL3dS?=
 =?utf-8?B?R2ZiLzFXcFpva1ZPMjlZSlhVQ2tEWDlDNU9rYkd6SWltYkE0TXJTbGFLT29o?=
 =?utf-8?B?c09Vc2pITy9UcFlTdlhESzl6enYwa3F0NHp3RFVnVUV4dW5nelJ4M0R0ZUp5?=
 =?utf-8?B?QkozbkJramYrUWZaM0IwNEo5Uk9INWFFN2RwM096d0FVRkQ5Z0ZGSTErU2xX?=
 =?utf-8?B?NmRXeXZ6cjNzRi9YUVhJLzEvNjRWWVhnNEdTK2RxTmxpM1JKY3h2b2x0VFhC?=
 =?utf-8?B?a0VzWUV4S1hQaW1OMEhBZVhRbGpaTyswZkV4cDZER3ptK3FKTTBrTGN5STcw?=
 =?utf-8?B?NVFzK21RL2JxWnExSUZLWUNJWm1ETnFCK0NCQitSZGtvcGlGcy8vVzV6ZnN4?=
 =?utf-8?B?djdUWEVvRFQ4bmhhSnJ0TVRrdTE0eVB6M2N0YUxQN3B6U3ZqbkI4NENPamVq?=
 =?utf-8?B?bEk0bXZsN2lGNFBIOVVOY1RTRHdmRDNyZFFTMHVoWUNSd2djTThxR3RGa0Qx?=
 =?utf-8?B?NGNYbUNEOGx2RGh2Q2U3aGYrNjhOMjN6WWh1L21YQVBlKzVoQndNMDNrOC8x?=
 =?utf-8?B?Zi95Y05TT1hOdFZiS3ZIbzBjVlY3WUxUU2Q0NHA1dVN2bzZpeGVrZU1wbURx?=
 =?utf-8?B?dEFlMUF1aU50aStrbkROc1d1RWtJOFdsczJRZjRNdHVFKzBNVjQ4T2xUanFp?=
 =?utf-8?B?U2FET0tTZHBBTUswTDBRL3FwblpnT1RydmFXT2M4N1B1aDNZQUxrWjNJdXpR?=
 =?utf-8?B?SEJYZW50UjB0TGt6Sk5rZXZZTENnNDRjWlByTXdhZVJGU01IQk1SSXFKNnNV?=
 =?utf-8?B?TzVOMVV3OHQrQXFLT1pEMnFFRUtsS2NPMXZCcVRxYjh0aHRYTEdBUm1DRERQ?=
 =?utf-8?B?bXV1d2EwQkVlODJkejZXMnJWNHllbzJnbVRGR2dyMld2cDhoanVnZjZFdTNw?=
 =?utf-8?B?V0FjQXJLS0hkYUJ0TEZqblVBQWYxSjZyc3FCSk1uZ3RycjkySHlvNXFNVnlU?=
 =?utf-8?B?eTNiSkNTVm1wQk9vZEFjNlVNU1JkY1U1dkNLNGt3Yk4yaGdFVVg0VmV1ODJz?=
 =?utf-8?B?Z3RyVTZ1UmN5YUw5ZTJpcWhOaVpCTTVDU2J2WjV3Y2xkYnl0dEdHb2FYZndw?=
 =?utf-8?B?a2s4M1B0TjFIbnZqOGgwMHBZV1Rkc01EZTl5TUpldmRHUFFDZjJlR0hsSFY0?=
 =?utf-8?B?eWREUWZVcFUyeHE4OVFLUHVtVGQvYjkzQ2tCbmRRakZYejZwRXRUajJvVzNV?=
 =?utf-8?B?WTRma1hCa0tEZWxjYURJUFExbzhHbE1RWHd4b1AvQmdPYWdmU2F3NTQyMXhx?=
 =?utf-8?B?R3pRWEdWZnRpRFc4M2NFanNCbzc1dGZyK2taTjFLNWxRWEdmU085UXFHS25n?=
 =?utf-8?B?dElzaWErcGYzT3dlNGxyTUZYaGwzTlNwdnYvVFlzNi8rYmJYcWw4YStybnlz?=
 =?utf-8?B?c3dPUkd6cDgxY1d6c1FaeU5EbE9TcnF1L2U0d25ZT0c5VzhpLzBmN3FyeGNF?=
 =?utf-8?B?Z2djSXpnMnNTeUh0TmNWSi9XNlI4Rm1BZ3cvOFJtYmxvVG5FNFBFdC9xcHlw?=
 =?utf-8?B?Y3dCUVR6V1I5NE43b2RWeUF1RlVCNEZJbzZ2MWM4WmRUSzdXc3p5UWF0ZGxG?=
 =?utf-8?B?QlhtU0FqWHR4SjZzYzBDb3BvZDkrTkdpbENZdVU5NWtSd0wwQ0UxODZFekZ2?=
 =?utf-8?B?KytpVm80Z2FOODNMWGY5aE9DRTFKZ1grOHl2REsxWDc1MkpXT1JIMGxNa0ZK?=
 =?utf-8?B?OENYRkxkODBpWVY0aHF6aEJTSklMREN1UVpwUjdvaHNLeCtLSmN5akZudTRr?=
 =?utf-8?B?bHZaME04WGZSNjIxMThlTUE0TUlLQ01zR3psS1A0MThLTCtCcFhuTEtpeUpD?=
 =?utf-8?B?THNwYURRYlJwSWdMMVFyYXM4Um5LV01XeWpYNlBlc1RRWit4MUhtWnE2OGdo?=
 =?utf-8?Q?pt7pGa7J7WqrBfMWn4yrJlc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lnY/Fb6CrEnBrh7+6+Rlu+GYyvHFdAX2CHEpqT/NSbAzNMfa2jJ7t3WBNVAtRTqiZch14bNrwXl1qOyZQH0vSF68V2YP6WCW90UOmkLWz7f0xzClawWNrSgfCOmtL5WNwMU5Jq5thU/YswNDpi13cBmeJD23Bwv+LUXwdwvc36X86CRRxID6Wrg+w2nvO9U9TSMI3o7Ori8gyj6R6xZrkglNgZeYxVKBW+uP+EkiwInZzKOcxkTciA9qE1JQ98Ja2Hjy5HpDrM2usM4y4jA9fpkBbIxtUU198SZnJzhaASpWU9YMgejymCenvwAAWHUi7Wnhb6r/zvTE3k3aCclCsssZT9k1PQiwYRzdewlTVSIBvT+QXnCG3Nf86VEVoYq/4DjonrJu9sqR5yEPMdC0/tUJcL6bpztcPZnPcfE9EHkqN15Zd8CqtYkR/VD7lRzO1WYOgpbnM2kZgOFGMteASpTb7YvZoUD0dHsjfDc+eGJd00eiW0xTOHsDwmpfw2PPzT/9hsiw9Xg3WlEAjxqGdWAc6TfnL20u+AJKPOrv1mFbdS0rg7uY+37zklFwF0fB6UcKKa2ba6vh8Y9T2kTDGWtWdx3rviZ5NmeFi6Kg3NM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8017306-a8f0-4053-8a80-08dc5ebfa92c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:20:45.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE60xLJe+NKdDOaPPMiM26Cj9aXzWnwQebFmSfJONPPENMaNC/huW3lBI3IgIDzSDoCutgheJW2PwSyr2JEniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170064
X-Proofpoint-ORIG-GUID: pOezB1Y5C6aicz6vtISLGGeD0pDo8p6M
X-Proofpoint-GUID: pOezB1Y5C6aicz6vtISLGGeD0pDo8p6M

On 25/03/2024 17:53, Daniel Xu wrote:
> Add a helper to sort the gobuffer. Trivial wrapper around qsort().
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  gobuffer.c | 5 +++++
>  gobuffer.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/gobuffer.c b/gobuffer.c
> index 02b2084..4655339 100644
> --- a/gobuffer.c
> +++ b/gobuffer.c
> @@ -102,6 +102,11 @@ void gobuffer__copy(const struct gobuffer *gb, void *dest)
>  	}
>  }
>  
> +void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *))
> +{
> +	qsort((void *)gb->entries, gb->nr_entries, size, compar);

nit shouldn't need to cast char * gb->entries to void * ; not worth
respinning the series for though unless there are other issues

> +}
> +
>  const void *gobuffer__compress(struct gobuffer *gb, unsigned int *size)
>  {
>  	z_stream z = {
> diff --git a/gobuffer.h b/gobuffer.h
> index a12c5c8..cd218b6 100644
> --- a/gobuffer.h
> +++ b/gobuffer.h
> @@ -21,6 +21,8 @@ void __gobuffer__delete(struct gobuffer *gb);
>  
>  void gobuffer__copy(const struct gobuffer *gb, void *dest);
>  
> +void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *));
> +
>  int gobuffer__add(struct gobuffer *gb, const void *s, unsigned int len);
>  int gobuffer__allocate(struct gobuffer *gb, unsigned int len);
>  

