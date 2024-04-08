Return-Path: <bpf+bounces-26216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85D89CCCB
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 22:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771642844D8
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858F81465B0;
	Mon,  8 Apr 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UdHtZGrS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M5zy/NpS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC36146599
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606801; cv=fail; b=VN6LfMhPnvwjSw/kl41q3d7Pycq6X979op3lbIvt2cqU3cL8hpE+MElEUb1F16KyBspPXgNbDVPW/50qhV+BDjlRK5CB6vK0+I17Gq8GDbkC9d5y9aLOnZ3lmZ+qIKchxGQDY93hgNFwixksQpcVbMG1rRcOuyQL0PQ5YinHUrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606801; c=relaxed/simple;
	bh=+LREYtBcxJN6XtbysTWpDwn2Pj55r3jP0+szKgLwpoE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=JehctobTZfgmE5mdW5JMvMXtu3BlZgMnl2bziTulbAe4ILTJxbeNio6C1dbHGmRTdo41FylM7Sb/94gy/yEedwPMQPL75zdTcwljZMx0GFURiownr2s+X4bE1YZ4nPs18stHp4DGPblz+dhXGFES/8ce5IvaBw5WUfJZVod1jao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UdHtZGrS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M5zy/NpS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438ENwTM014631;
	Mon, 8 Apr 2024 20:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=L1OGnkzI301MYYTdCJOar1GmoYC+9N5IiHWa5noAewI=;
 b=UdHtZGrSY0IDsbRIoCk6xvh+mQAaiW+xSgQxwh+4qBhv+8cttNeN+kOTIsNbpE4r92hs
 gcl0Pw7T8fMdIaVWSp0d0yhkDhc9B6nft5GzG7DKsu6AIBgYrYHCX6QIigdr7/7mN8HE
 qVq8om7Hb/eWTpK6/QZ1ZE0FrycblaeJkED4q4YQfwsNlmyMgpM1j/T6pQ3IZSU2vttc
 olloNAVUsHnbLdjg9lb54Bqpdpb9hnYSJo4gh6HBWIPddU/hanQBaDPKwg1dhnJpAR8Z
 nfbtx3pDPp6qWIvr1BTJr723jU2In/+6lfvk66KpjKqwOq1tDb6vs5uh+EtEpWDtiDx/ Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf3m5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 20:06:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438J0D2u010520;
	Mon, 8 Apr 2024 20:06:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu5y4w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 20:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adv5Tw1TOQ8JVt70lWGbJXBlbDqq8z0qjT1ofAyxpv2EJdFLhgJovnbSpFeRoW94oGamg1815RodKmZXJU2Pvfh2doy/tTA/FJH1R2vMKXZxi6qlruZ0a3cHkuU3YleZOCsTrWmnNvQHH5WUJUmG71EiXhI1TkpjJpnHTPu6BdL94FOOjVws++GzYZu563mgP49DCRdAGbm+QkGem55vJcJZBjoSYgcFNM+6qOMjyjgSoIACDzP/zvcB2ZFNTY+Aub6PyrPCgRtKbQUUFBz+MDOWsbYUSZgJ7YGinAukHTbl7ytNaCs1ywcbQjTqm7cTMl2LY/4RtaMpE3KtEo0QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1OGnkzI301MYYTdCJOar1GmoYC+9N5IiHWa5noAewI=;
 b=aEjd8YinQV6joO/9nXo2n8+t9Jy9gN/T92ekD0S8TD7CL72ZGzlEN06Uu2KyTqwVqaJK1ZSt4wI+Zjvg/PFRt1+uATDubpk8huEVGwoDFbJ1wHS7A3MST7/QOqg3bfHHd1kS6sIcxxzkBnPfUTqiIWLIENR1UDKichUVR7KXTlqhI3tu4Cvnz1k5e0Jd7zUkE/YDJ3PrDg+y8RZbqslR9zV9+/rX5tD3XXQe6eA5n3slP+eKQcbDpLdj4K6/jaDNR/EIF18LEWeVX1lyBGP/XyqWpjemuTU5CjB9RViNAsROWbeIxkWYmeABdcwqQTCI0zn7ugoeQapYbZXYGm8t5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1OGnkzI301MYYTdCJOar1GmoYC+9N5IiHWa5noAewI=;
 b=M5zy/NpSMVSVFKenkkS+JkQ2Yxd/qahB3XraZ5gL1IVRq7B+AJrHeIlr5ZwHmxA5swZRyWQ/pNm/1l2DcjTHfEdtziHiFtEbpqpvSSQU2WMGP7iifxTSbvvZoSqV9PxC4VgGeinH/p3jFiGmbD2qTd9uevjWdm3mD7ACtHSjICE=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH3PR10MB7161.namprd10.prod.outlook.com (2603:10b6:610:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 20:06:26 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f%7]) with mapi id 15.20.7409.046; Mon, 8 Apr 2024
 20:06:26 +0000
References: <20240405220817.100451-1-cupertino.miranda@oracle.com>
 <CAADnVQ+7hMVTu=yQ3XSRkxACaW68wgwLYPQBQH9StDvBsNXN1g@mail.gmail.com>
 <87wmp71v2t.fsf@oracle.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>, elena.zannoni@oracle.com
Subject: Re: [RFC PATCH bpf-next] verifier: fix computation of range for XOR
In-reply-to: <87wmp71v2t.fsf@oracle.com>
Date: Mon, 08 Apr 2024 21:06:22 +0100
Message-ID: <87ttkb1uwx.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::13) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH3PR10MB7161:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	isDKaA5yBrN92YQIPiRTgQfcZpIfWiRDuYW18/rH1qL7sbH5iF31hukLo7qq6FTUSyLukmQ0fr7MLm4IF850/2EV5Kt2fPiN6p7kZ/zfrc+Zh4797IdBJm3o5Wtp86BcyM9Jxpsi8GTgBul7QxYsCGTG+9HDXqC5OHfSHxg34Vdz3SYjOBEdE+eSnDPyXF9GUhnac9LoaK7E+XKvOrX6BerNVc8W2QkqHxgPPFknj/cZTR4wYDG4mTEMZdaYdKPN9UtyYSCH7SVoCbVFlBHjOol1NYGXxCKvNtDZFOUg3eRbL9//XrFobLsuAA4EG0cERwvfjnMsYBod/+J1WYBYAPejHDpEYJ7+rGdSmv868gO4HmJq0CTZMjsEOwFjXPg4DHVdRZ+CPh4x3dsR4NB65cu0+ntUHr1uOZL3ul+PlQy/YigVpiL2gdOFHHj2Gn23p95kfsxLUpY1lBWDBZ2poWQRAnsrBLlq4CTb4BRa4iaC+7UmGouWYrlaHblmQalILOKKjz5/Tuxc/WFQ4yWOQtG+BtkK8azlvT30PvO15/bKKkx9qkpYOIaAtDHeiTv6QuMNSrSEa1mabIyHEMbmi+ftBg8B6bmK5qOzYa0wfuHr6ncc8FH7bL9Q4VBjoILI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2lUdm91Rmx6NDFGdGV2cnlTcGM3NGNDdnNqcnNpQi93bktPZTIrN2JwRUhX?=
 =?utf-8?B?UDRmaGRlaXVLQXA0ckZUS3dTbmFCSUh0RnNPK0l5TEVkeklIalk3b25NTE5t?=
 =?utf-8?B?TmxDWTlJYWxzSUgvVk5ybThOdlhRWEI2Zkk3Wkk3cURSQkVrSjB3VHRtOG5P?=
 =?utf-8?B?blN4djBFbFVwc2V4SXI4SVJkSU9rNy9wdnFLSFNrNWw3UWJpZlJqQUtydVd4?=
 =?utf-8?B?Qzd5cWkyT3JEd3RnUG5WK0FYNmtuZnFjN29LS280VHl2ZDFZQU0yVTJPNWsv?=
 =?utf-8?B?bXBzRmRZN1RucFBQRlBkZjR4NmFSdTdaeCt0WitSMmZQbXZDWVdOYlluRlBi?=
 =?utf-8?B?NitqeGIrbHV3UlNqb1N5cTdhbnYxclk3SXkxaXJ0UGhaMnluaEhTZGNUTnY4?=
 =?utf-8?B?WVc1YW1kN25XYitSaFNyVWZsOFJQb2JhektGaXQ2SmptVWZnS2V5OUZIaTNC?=
 =?utf-8?B?byt0VzBBanM0ZXkwZFR0SFhwUGFVZVh3aHVPbi9pRzZOR2hBTnlwRGxydktN?=
 =?utf-8?B?Nm9IOVVLWHkyclZpcVgwdzkrQ3RJRWNFTVRYMUQxWnlkeFhob0RrSDJZVFM3?=
 =?utf-8?B?ZEUyWkxhenRXeGcyNnNaVCtsako3YVZKSDBEbmVZMzIvSWdWZUhFcXYvaWZH?=
 =?utf-8?B?eGx4Wk4vd3g5SitrdmppTlgwT2p2K0dpNmV2dDlhWDhkaklLRWtCMVF6blR2?=
 =?utf-8?B?TXlxdzZvVVdpWWl3TVFWZG5razh0MHlzYjUyWEEyQWRHbXJhMGxFUDREMHFq?=
 =?utf-8?B?OHNGN2Njei9RbzZVV0tMU3V3bnQvNkN4VFZLRGlnMzZRUUZ5Rk1ZOGRsU2Vt?=
 =?utf-8?B?MjlRRjNDNzNXZ3Z2cWJrK2VCNDBUdFVuUG9yWWtHYmpXdUIyNWxtS1B0aXh1?=
 =?utf-8?B?L3ozbXlKT1Y2M2RaMnpkUnRaYUtiWWluVmYzVGljWW5UWm9IWElWMjI0bGx1?=
 =?utf-8?B?aW5xT0R4OC9EaGwrendEdGRTbkZjOUhLdktZR2oxVDBTb3pvYWxXZG9WN0xq?=
 =?utf-8?B?MVIwSW15SkJTQXR4M0NTbEtwamoxTXFEK3A2Zk03Q1U5M1JodFMzRmNMcHJn?=
 =?utf-8?B?N0NSRFRYQndaNnYrZk5HcFFJTmNHVjh4K1VjazV5VUtsMmthbWxUc0cxZy9O?=
 =?utf-8?B?aEVyWjNxdjQ5YkoyY0IwZnBPYWczVkF4cTloNWZKZi9kVEZmYVFEYUVCWjJ5?=
 =?utf-8?B?Vkgxa1Vlb0pmcXl3ZWNaQVZhSkZ4aTFpY3lTZktXQndKTU9LaWREWU56TzV4?=
 =?utf-8?B?WkNvZDdLOUt5aytrRTUzekgxSWtUc2NFd2ZZTVlZYUUvellyeGZVZE40elJM?=
 =?utf-8?B?MXR4RlVOYWp6WGhvU1BmaS9YRjZINHZKR2dNWWtSVGhWaVBGRGRFMkxYWWIz?=
 =?utf-8?B?bzRteGluekZDUDNJMmoycVlMM0dadnNoYWZCWUtJcnc5WTBJcGdrK0FGMHBV?=
 =?utf-8?B?eVFMQ2JTYlpRakpKbEtza2R4NEFrRElldlYwSGFSbzRHanE0bmZWU2ppMWNS?=
 =?utf-8?B?RnZTNVFPY2s2bThjTCtUNDVscWJCVTYveHROYlZMa2Y5N0ZaV3dXSHp4bis3?=
 =?utf-8?B?bHdGZFZLeDltenVmdFBSQVY4aTdBL2srTDdUbGtqRHBSVDJRZjVTbElqcmlh?=
 =?utf-8?B?VllycjA2OU13Rzk5OUwrQllrTnFzZ25OQURYemliOHF6QjBHOTltMVFZUUts?=
 =?utf-8?B?NDUvZVNQeG95ZWdnNVB3YWJNSVJoSzltYlV5eCtUanE5WC9tajNhUU9keUM2?=
 =?utf-8?B?b213U3Fja2t2czBoSlhoaWovQ3VrVTdlRWJlMGRidVRHcjlkZitNUkRnTmwr?=
 =?utf-8?B?bzY3emE2RzdRRmMvNkg3Tklxcnk2Qm82b1Y0Yk81dVMrTUdTcDJES1Jma1ln?=
 =?utf-8?B?YmFCYmJWWEJPNzhlUE11OWJ2RG1aYmQ1L3ZtcjQ4QWx4azhDOURBSjhrb0NK?=
 =?utf-8?B?YUNQUWxNOGRTeGp4aU9xb1BzQ2tKYWx5bmduclM4a0NTbXJ6R2ZSM2dYRDE1?=
 =?utf-8?B?VHFlNGxKcU1mUDNSNXNoQTRRdUw1a1hNV0VtaGVrRURHVnJMK2RSUHVUSWlw?=
 =?utf-8?B?Nlcxb1Zmdm0wbmFLUHNZQzlSNDdieEpBb1BwekQ0dkpuaFB0WXpvejR1cU5R?=
 =?utf-8?B?Ri9WbkdYaXovT0J0MXpJdGU1Y1czSU9QbFBFZllHNkRERHpaZkdaMkxDOXMr?=
 =?utf-8?Q?kXXLK9ST415YtmwIrZbHE/s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rWAQpEkGad9a73CUAEisTulnFr+S8HW+wa5+396nyEhWK/M4RE7O4d0hiw0g1TpLKCxiBCCU4lKUgaGCm2nVGJ3kADt08M8ukz04OFOlW6UNz3mpbBMOvspBGnVBC2hdApG3FM0ARRAc8pqJ+lmswe9tEiyRBv9VOeRW/IiHEAAJazNiEsXN3x0Kh79thKoWBa80oQm9ILRi9bB90mhngyA8tFSp3tYq8L5vHDJHarKzxC5TlWEVSJbpYpQ+txKIZV3bW0j/PWHo+f9zBi+9SJ6w1hXpclBbrk+/aTUFaTfFV8FrPxljo2jdv1dHzgMtnOcZ8/eA/FJaRya1yOVxv7D49obCUrc/nyS82J7PL59/cJH04zvl0sT1zDcG6xVU8te23CSfFRbnD/VaJOYy32tEOvHjNrivvl847uro06eG5ygVTpKlKIFuXkmy2foONxzkdYnoX2G0BHc9ujVnsz+h+BZgTp0brxJk0LMyng2Qg8uLCCJ+J5smgrWe5SyJrUO/u0s6RtKrEvBcwam83WOyp/BCZm2ZLTe7XJSgUTOYXDMtEGwdfle3t4vj2A6wbdBCmSoRXDb7ZfwdiqPN0zeaJgS2Kx8/zmz0sdIS9Q4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f64949-67a4-4524-100f-08dc58075f55
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:06:26.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s14eE6TUNUI5OIp48t5DWQiExxSrjTM5aGSRD50QzV1ua2czh51jOqKv7J69VRlJ0s1eGzFcsouGVNT6BqkGrPSY0gB8meAazbcO3n9QPlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080155
X-Proofpoint-GUID: mrOqA3ALDXCd2Y6uW6i2vG38MHW2s95r
X-Proofpoint-ORIG-GUID: mrOqA3ALDXCd2Y6uW6i2vG38MHW2s95r


Cupertino Miranda writes:

> Alexei Starovoitov writes:
>
>> On Fri, Apr 5, 2024 at 3:08=E2=80=AFPM Cupertino Miranda
>> <cupertino.miranda@oracle.com> wrote:
>>>
>>> Hi everyone,
>>>
>>> This email is a follow up on the problem identified in
>>> https://github.com/systemd/systemd/issues/31888.
>>> This problem first shown as a result of a GCC compilation for BPF that =
ends
>>> converting a condition based decision tree, into a logic based one (mak=
ing use
>>> of XOR), in order to compute expected return value for the function.
>>>
>>> This issue was also reported in
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D114523 and contains both
>>> the original reproducer pattern and some other that also fails within c=
lang.
>>>
>>> I have included a patch that contains a possible fix (I wonder) and a t=
est case
>>> that reproduces the issue in attach.
>>> The execution of the test without the included fix results in:
>>>
>>>   VERIFIER LOG:
>>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>   Global function reg32_0_reg32_xor_reg_01() doesn't return scalar. Onl=
y those are supported.
>>>   0: R1=3Dctx() R10=3Dfp0
>>>   ; asm volatile ("                                       \ @ verifier_=
bounds.c:755
>>>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>>>   1: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=
=3Dscalar(id=3D1)
>>>   2: (b7) r1 =3D 0                        ; R1_w=3D0
>>>   3: (7b) *(u64 *)(r10 -8) =3D r1         ; R1_w=3D0 R10=3Dfp0 fp-8_w=
=3D0
>>>   4: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>>>   5: (07) r2 +=3D -8                      ; R2_w=3Dfp-8
>>>   6: (18) r1 =3D 0xffff8e8ec3b99000       ; R1_w=3Dmap_ptr(map=3Dmap_ha=
sh_8b,ks=3D8,vs=3D8)
>>>   8: (85) call bpf_map_lookup_elem#1    ; R0=3Dmap_value_or_null(id=3D2=
,map=3Dmap_hash_8b,ks=3D8,vs=3D8)
>>>   9: (55) if r0 !=3D 0x0 goto pc+1 11: R0=3Dmap_value(map=3Dmap_hash_8b=
,ks=3D8,vs=3D8) R6=3Dscalar(id=3D1) R10=3Dfp0 fp-8=3Dmmmmmmmm
>>>   11: (b4) w1 =3D 0                       ; R1_w=3D0
>>>   12: (77) r6 >>=3D 63                    ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>>>   13: (ac) w1 ^=3D w6                     ; R1_w=3Dscalar() R6_w=3Dscal=
ar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1)=
)
>>>   14: (16) if w1 =3D=3D 0x0 goto pc+2       ; R1_w=3Dscalar(smin=3D0x80=
00000000000001,umin=3Dumin32=3D1)
>>>   15: (16) if w1 =3D=3D 0x1 goto pc+1       ; R1_w=3Dscalar(smin=3D0x80=
00000000000002,umin=3Dumin32=3D2)
>>>   16: (79) r0 =3D *(u64 *)(r0 +8)
>>>   invalid access to map value, value_size=3D8 off=3D8 size=3D8
>>>   R0 min value is outside of the allowed memory range
>>>   processed 16 insns (limit 1000000) max_states_per_insn 0 total_states=
 1 peak_states 1 mark_read 1
>>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> The test collects a random number and shifts it right by 63 bits to red=
uce its
>>> range to (0,1), which will then xor to compute the value of w1, checkin=
g
>>> if the value is either 0 or 1 after.
>>> By analysing the code and the ranges computations, one can easily deduc=
e
>>> that the result of the XOR is also within the range (0,1), however:
>>>
>>>   11: (b4) w1 =3D 0                       ; R1_w=3D0
>>>   12: (77) r6 >>=3D 63                    ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>>>   13: (ac) w1 ^=3D w6                     ; R1_w=3Dscalar() R6_w=3Dscal=
ar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1)=
)
>>>                                             ^
>>>                                             |___ No range is computed f=
or R1
>>>
>>
>> I'm missing why gcc generates insn 11 and 13 ?
>> The later checks can compare r6 directly, right?
>> The bugzilla links are too long to read.
>
> The code above is just some inline assembly in my patch that reproduces
> the specific GCC issue in the verifier.
> If you want to see the code GCC produces you can check in the systemd
> github issue.
>
> Thanks,
> Cupertino
>
Here is the log of the verifier from the code that GCC emitted.

M=C3=A4r 26 23:57:12 H systemd[1]: 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
M=C3=A4r 26 23:57:12 H systemd[1]: 0: (61) r0 =3D *(u32 *)(r1 +40)         =
; R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xfffffff=
f)) R1=3Dctx(off=3D0,imm=3D0)
M=C3=A4r 26 23:57:12 H systemd[1]: 1: (bf) r2 =3D r10                      =
; R2_w=3Dfp0 R10=3Dfp0
M=C3=A4r 26 23:57:12 H systemd[1]: 2: (18) r1 =3D 0xffff8ef68fd28400       =
; R1_w=3Dmap_ptr(off=3D0,ks=3D4,vs=3D1,imm=3D0)
M=C3=A4r 26 23:57:12 H systemd[1]: 4: (07) r2 +=3D -4                      =
; R2_w=3Dfp-4
M=C3=A4r 26 23:57:12 H systemd[1]: 5: (63) *(u32 *)(r10 -4) =3D r0         =
; R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D4294967295,var_off=3D(0x0; 0xfffffff=
f)) R10=3Dfp0 fp-8=3Dmmmm????
M=C3=A4r 26 23:57:12 H systemd[1]: 6: (85) call bpf_map_lookup_elem#1    ; =
R0_w=3Dmap_value_or_null(id=3D1,off=3D0,ks=3D4,vs=3D1,imm=3D0)
M=C3=A4r 26 23:57:12 H systemd[1]: 7: (18) r1 =3D 0xffffb290805b6000       =
; R1_w=3Dmap_value(off=3D0,ks=3D4,vs=3D1,imm=3D0)
M=C3=A4r 26 23:57:12 H systemd[1]: 9: (71) r3 =3D *(u8 *)(r1 +0)           =
; R1_w=3Dmap_value(off=3D0,ks=3D4,vs=3D1,imm=3D0) R3_w=3D1
M=C3=A4r 26 23:57:12 H systemd[1]: 10: (bf) r2 =3D r0                      =
; R0_w=3Dmap_value_or_null(id=3D1,off=3D0,ks=3D4,vs=3D1,imm=3D0) R2_w=3Dmap=
_value_or_null(id=3D1,off=3D0,ks=3D4,vs=3D1,imm=3D0)
M=C3=A4r 26 23:57:12 H systemd[1]: 11: (57) r3 &=3D 255                    =
; R3_w=3D1
M=C3=A4r 26 23:57:12 H systemd[1]: 12: (b7) r0 =3D 1                       =
; R0_w=3D1
M=C3=A4r 26 23:57:12 H systemd[1]: 13: (15) if r2 =3D=3D 0x0 goto pc+1     =
  ; R2_w=3Dmap_value(off=3D0,ks=3D4,vs=3D1,imm=3D0)
M=C3=A4r 26 23:57:12 H systemd[1]: 14: (b7) r0 =3D 0                       =
; R0=3D0
M=C3=A4r 26 23:57:12 H systemd[1]: 15: (87) r3 =3D -r3                     =
; R3_w=3Dscalar()
M=C3=A4r 26 23:57:12 H systemd[1]: 16: (77) r3 >>=3D 63                    =
; R3_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=
=3D(0x0; 0x1))
M=C3=A4r 26 23:57:12 H systemd[1]: 17: (ac) w0 ^=3D w3                     =
; R0_w=3Dscalar() R3_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dum=
ax32=3D1,var_off=3D(0x0; 0x1))
M=C3=A4r 26 23:57:12 H systemd[1]: 18: (57) r0 &=3D 255                    =
; R0_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_o=
ff=3D(0x0; 0xff))
M=C3=A4r 26 23:57:12 H systemd[1]: 19: (95) exit
M=C3=A4r 26 23:57:12 H systemd[1]: At program exit the register R0 has valu=
e (0x0; 0xff) should have been in (0x0; 0x3)
M=C3=A4r 26 23:57:12 H systemd[1]: processed 18 insns (limit 1000000) max_s=
tates_per_insn 0 total_states 1 peak_states 1 mark_read 1
M=C3=A4r 26 23:57:12 H systemd[1]: -- END PROG LOAD LOG --



>
>>
>>> Is this really a requirement for XOR (and OR) ?
>>
>> As Yonghong said, no one had the use case to make the verifier smarter,
>> so pls send an official patch.

