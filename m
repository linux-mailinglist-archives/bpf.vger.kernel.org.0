Return-Path: <bpf+bounces-67830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D628B49EF2
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 04:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC72F3B8E00
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 02:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4661C241686;
	Tue,  9 Sep 2025 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RV78uEon";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rpE7lIOp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB92222B7
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383600; cv=fail; b=sPP+WTFT2+dWbpK59Fneby2tHDzhlIlHHg+X0sc0Jc0BndbpIEiBhXfp9g48pq8END2kZFYztvXghqeXTsFxYwA9cl3Aljceyrmm6K5pXdL7ovrCMHhmbQ8dOhBU3NluAMoaPTPKYzSseFTPP7p2T50sau4JT9q0/9cgfATuthk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383600; c=relaxed/simple;
	bh=R8gpbgRCEtFf8N9NnkM7X58zP2I9J3FFE58x0mbcWaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XMgrP+msZsn9s9G/olwfqPGZYRvyHsADPl8pJX8elGWPgPclkeO6VDLjBNFP5GUgHXywpba9jP8Rw8iPFaTzyjUysfgPshe2mPlqM42brUJsXnj1fjpKbRJAV0ortafOxtIYW644oaOyxbVL6IJkyoNFxrJgcn6bZWKaVaJ/pJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RV78uEon; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rpE7lIOp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588LBvmi026688;
	Tue, 9 Sep 2025 02:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6WhAJqNi8MSQUDK7dmhnPr7FGZHmDdQ6Ql07GKGH5kk=; b=
	RV78uEon79+CINJCupHIdg3YadVPKduwiNlVDkc1Nub9tqVQQ6CFT1vbNOjYPhwL
	09HtAI7oSsGbglRs2dnp334KZLtmaTI8ah/CDPe6LAbHk3iBmOANmI5HTnjDT7ME
	JKjA5oPwKBFAgRg/vXBCbhnovZKms0WWogIHR3mWMt03d6zLTpokQT7GPA2PiVIL
	TmHbCuT7TIZZriRk0lKClPFFek6N8r33S/iK+8L4CZjwQJhCls6k/XoZ4CDgibJb
	kARGuUjrpWpjFw+mb/X2D1Y2pFFNcma+gaOduEpxwB8wD8clblSpqQVGOkdYwXdE
	wckvmhQ6v7bbc1EKmTRzrA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shrrjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 02:05:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5890J1Hb013674;
	Tue, 9 Sep 2025 02:05:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd965fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 02:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN5R85uCqgQ+Cp4W6El1tsHWx3Dt6rPjxhlkVecxWMNhszsaK5eemd6l+f8+Mw3Qhb7eTswDI3fPBenALFoESBKVNF9OvSoqiVgUoi9w6r4f/t2HVOv648hGl/9S0LP4hDwf1dLpjJYzT0rfOB4R5KZj3bj3Fla6/9e5lGRd/FYnOpr9e/pBRMYi6pwBFkLMClwFsGyA8PeQo83u8k8AUoCCkOPytpzYOyAoHYk10Xv6lzfx2if34es7HIvpR8WBSswe4E4I1WbLk0XuGP7OClsPp+6deZm9yri/UNCBq7txCRYjfz8sjNfcv4HKyZGmyBobLe0HEZCSQzI3zopsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WhAJqNi8MSQUDK7dmhnPr7FGZHmDdQ6Ql07GKGH5kk=;
 b=sbcVUbkx3nRv3Vjq1AqwzMeF9jZ0N8oM9eD4e2kq1pQ2iFn9wpXtKKlTVbY56jcOjbo91iQ5QvJemXz1ByZG5f1cTMdiXVZvx0JHFq6D3nefL2/Q7q3Rd2vaIu0pkYTlJWPTI3ELu/kO80U7/Oq3JWUSNzgc+irLj5C+GDrEuuCEfmNmlYPmIIfj8S/E1UCyZz6EfpYX6AM9TF1sL9s1VNqsP5/qENh21z2/MscTjhiYhZrgRdUHaTFDAEC5ezbFOtX1KI5lA6cuuMQg3QdWmWJsD1veHPRM2hC4ps+mEmutiWmnJHUGklHfH/fJD3+TQoXeQLujWXLoUGBbvI4vLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WhAJqNi8MSQUDK7dmhnPr7FGZHmDdQ6Ql07GKGH5kk=;
 b=rpE7lIOp75njelD+6z8vHOksXMTWcZ4xO7BI/vxvtKhJUnCwXibbmq6EfSAexB81DKn/Lqwv2EKr2MjK7I9dfMCcQgEFQVBTe55rzoDvVsqQtZE3HGhEH4rR+i6G9OxV28p+4fzGlYu6OfzICZxJSQ1C6C5q/f2tJXFL7fqXiVU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7930.namprd10.prod.outlook.com (2603:10b6:610:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 02:05:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 02:05:29 +0000
Date: Tue, 9 Sep 2025 11:05:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aL-LX7JI6KLcB-dp@hyeyoo>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
 <20250718021646.73353-7-alexei.starovoitov@gmail.com>
 <aH-ztTONTcgjU7xl@hyeyoo>
 <CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com>
 <aJtZrgcylnWgfR9r@hyeyoo>
 <aJt1FHnavjRv5CzI@hyeyoo>
 <CAADnVQ+aLojadnDgnOwJCTAE319can=rW7ELh2Xy5M-d2TWcHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+aLojadnDgnOwJCTAE319can=rW7ELh2Xy5M-d2TWcHQ@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0066.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb47d10-999c-4321-ee7f-08ddef45597c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU1palhyZ0VUU21GUGFtQ2NtUjU5S29VSFNxU0pMcysrTHZhSlJnM3BvcFVG?=
 =?utf-8?B?MGVrcDJ4V01Xc3VEMDRTRTdYRG9CYWNET1J5M3dzZHcvU1V1Z3huS0lQZEFO?=
 =?utf-8?B?MWJWWWNKOWcvbXkycFViSEZ3MGM1NnFzaEs3MHEwTldZQkxyamNsRlNPWjRw?=
 =?utf-8?B?RU0wZ2MvcnZ6dEgyRVlIRmxoQXhUeG5Cb2NKZ2lRR0dOVkRZNDBVV3hSSThO?=
 =?utf-8?B?MlV5Y0xaS1p6MW9QWldBNzl3TVpEN3lCVnB0eUY0KzUyamNKVFBuV2ZpR0tz?=
 =?utf-8?B?TElJTHdMdWhvM0pST1pYWEJkblJSdzFMbHlqdVlRVDBYUGNhT0ZYK1RiaERt?=
 =?utf-8?B?QSsvRnl2SzdCZUdWbGFzY3RFV0xkTWxDa0U1Q1JOem1IVlNUK2FSSkZkVmRy?=
 =?utf-8?B?RVViU1dmTEo2VTRnQkZ2UHFMZDE4SFk3T3BVc2wxNVl3dXhPbnpTQVVXdm8w?=
 =?utf-8?B?aHFWU0VMQzlTRkRIN2R4TmVaaWpBbWViOWp2T3JMMFl4amJlZk9JcmkwdDM4?=
 =?utf-8?B?c3NCcE1OWnA0V2NpakNzK1JkcWhsWnltSk5OeU9EWksyTUpEdnNnNXJjUHRH?=
 =?utf-8?B?cEhMYjFGSzhwdWRiZGNFVkpadDZBaDcxSFBxcnBHSFgvRDFwbnpiejUvdTg3?=
 =?utf-8?B?V01lazZOL0RhZ2g3bVdpaUVmdHpZcHBYRGVkdU10cHd4THBBdDhOWlh3R0Qw?=
 =?utf-8?B?OVRFVUxubzFhQll1UUFQOGtORmR0YzUwVlBoNDhYb1hnSUltb2U5TmsxSDdV?=
 =?utf-8?B?NmVjY2Q1UEh3SnVGYjRDNGFIWHVnQnpPdzJBMjlvVkV5N2drMEl5SThyWDkv?=
 =?utf-8?B?VEhNNHFvZUZmSUhBMmYxNE5JcU50S0JtRFFNbC82OGxHeEpwc1lvcnRYOGU3?=
 =?utf-8?B?U2JBUjNPUEtnSS82dEtYSVNsRmJGUUFnSW5VOXJIZ2ZDSm9Wci9uQzdzUTdt?=
 =?utf-8?B?SEdLMXZtdS92VjJSZGpvcGRSMHBDTzAwNU1XOWEwOW5zSUsvMktxNHM4L25o?=
 =?utf-8?B?NVd3aGVuTm5GdytUOEtIRlM0VFJxa2RJZ2t4RDlRR3B4OVRRVjVjRzV5MmZQ?=
 =?utf-8?B?ZW1sWnFKa0h5T3FDK2tGNFk3YjF0TU1EOW0yczhTTnZrR01TUlBxT2tML3pm?=
 =?utf-8?B?MW14emRMV3d1UTJHcDdaaEwzV3dRNFZnTXljZjMrZENTZWFiYzg1Mnhoays2?=
 =?utf-8?B?WnlKWWRxQ2lYN1pYOVlUa3ZzMFlENU95dzF2R2lJa042SVRCLzZWdlBRcThs?=
 =?utf-8?B?bTRCQXdVZHBBdE95NURNQnprV1RoTEhaMUU5amNyTTVmQXdFNk1xa2lDcWVx?=
 =?utf-8?B?ZFZBS2I1QUxYb1JzVnZiVEYvUWJTMDBUeEdyai9jSHFCdVR5aTdFajZ4UzlD?=
 =?utf-8?B?cnJDSTRDWTBxRnFGdWk0ZElQekpkVDdnZ2tkbVNqZ0NWSTFFUkxmczk5NXlp?=
 =?utf-8?B?czhqeWIrMHptZSt6QkhWMENOOE15TStjMVVQWW9yQlNmNVlkeE8yWnhxbUNE?=
 =?utf-8?B?dWxUOW40d0NFeXRFc0lNYU9OeHFPZXk2ZHlieGUrbVIvSnRCUkdvZStPckJk?=
 =?utf-8?B?dlpUNEd5NUhxOGJyME9DTlhVRldBUzBVZ0pJQm9MSDNaNC9rWGdYZlZTL3hx?=
 =?utf-8?B?VGhPZzRuUDlpeWdMT0FsTUF5QVZtSTBtRjY0d1FoLzUxbTZSUG56b3JlaEhq?=
 =?utf-8?B?V2pUUVBReW5uRm5IZDJlK3I5US92OXdpUE1qOGh5a1ArMXBiNVA0TWYyRFpS?=
 =?utf-8?B?Mm4zc0VvbitzQUJoUHRDRDFJbWhiK1NTWHpBS29VUXVlaUtMeWJpZ1gwdm4x?=
 =?utf-8?B?THY4TFU0ZEllWWQ1YmdQangxNGJpc284TlRqU2ttdkRmUjQ1SW43SVh0Ny9u?=
 =?utf-8?B?QVVMamdLUnJ3cnFlMlRCblNvS0p4NS9iTlI2QnNWY2hsakpIRzlYT0ZHNHN6?=
 =?utf-8?Q?75dYF3XrJ18=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME40RUtTcTFHQ2VPUlZORzFGZFRjcVNGNHJ3dlNKNVBSMlZCUDg3OS9pQzZC?=
 =?utf-8?B?eDRJbWZSbjRoMlRuaGVGeEIzMlNUbFlpd2N3bHg0bFY3eTBlOTc3ZTd3RXhZ?=
 =?utf-8?B?MU5Hc0RNQTBDRXAyRnJoZzR5WEFNRXg3LzBRcDdaOGUvZ0FVMlJoK0UyVE9Y?=
 =?utf-8?B?c0xSUllLN25SZzhWMnVYY3NGSERiV0EyQlZpTFdoV0hyb2NJNWRlOHBmRUZK?=
 =?utf-8?B?ZnFzSENnakpaMmdpbXB2cFJvRDJLbldzZ0lWMGRNVGFKN043MTM5N1FHN2Vz?=
 =?utf-8?B?d1M5bWNoUUJUbXdOWERnOVVMQ3ljU3lVV0RsaDNLeW1wM1RzcUMzV09wT2dZ?=
 =?utf-8?B?c0RsL1NsOEZyY2thVmJvcW1OTVJnVlYzMnFueEtHUjB3M0Nsc3lrZFp1cUR0?=
 =?utf-8?B?MVN5TTJuTlF2N1JNMjBYNjgzN0d0Si9iMHZWZVFoUHIybTF0ekdpcGdFMmho?=
 =?utf-8?B?cEhia1FWSFQyNW0reXRiMGxsQk04WklnT05NN1hIeCtVVEhQNWMyTTNPdVpv?=
 =?utf-8?B?amZGNmNJejNScmxxQjJyaUk2KzhBZCtDUzd1QWUwbnhkeW9yMEpWSVQwRkJm?=
 =?utf-8?B?N2x5aTZEOWpCZXh1VVZZRU1EU3l3dlI0Slh1aExzbGhYaTVYQVhvTXAyZ241?=
 =?utf-8?B?cDdrTjJnL2tpOFl0T1FwOFhVYzZZL3lnc3FzeU1SSWp2REd3Z0xzMFQ0NUMz?=
 =?utf-8?B?OWovVGJFbmtyL0wvWUFCL3BMNzB1UkpTQzk2U2FqNlVORTRaYVRuNDVsQXh0?=
 =?utf-8?B?WTdROW0xNXJadW9kenRIQUJ6TmtQUk5idVRTK0NXbjU3MFRZdDJ0dGNGRngv?=
 =?utf-8?B?bFBibUJDbytQQ3pSeTB4K1BRcnFUdnN5K2VOajlzUGNZdlJxdUgxa2M5VTdJ?=
 =?utf-8?B?alo1WVVBT3o5M21EVmo5TnZ3TkJPNEFWOW5DMjYyRFI5UW1tUE50QWc0cUVy?=
 =?utf-8?B?NEtWVTd3QzcybUNxWHVsZ0UwY003Rys5NkdvTEMwcGo0TGFYSlRQNTNBanJZ?=
 =?utf-8?B?ZHBHRXFON094Q05oTVFrMC84Z25LRlBDQ2FVcG1lcjZVZ04wR0l4S0YxOXZx?=
 =?utf-8?B?N2s4Q3NvMVB0VkJoc3RhUGtpeE5YS0lEMGNCSU9hNTVoRU9OTVNZTHg0T3Rv?=
 =?utf-8?B?cHdYUlhuWWFxQmExM252MWxoM21tMmJ5OUpFUXRWN1ZieU14b0FNU2tBbEpX?=
 =?utf-8?B?QU9QV3U5bGMyL1E1U0lXMnVFYWpNcmYyVE1aVXRNN2FhTllmMGQzYldvcnVi?=
 =?utf-8?B?bnRsays5aUVRcTNkV08zSXM5azNJdlU3ajBDZmsycDdlS2g3dG1aUEM1dURi?=
 =?utf-8?B?NE01aGswa3A5NGRUK0xuK25oYmtRLzNLREpNa3ozSFZuSVAzUGFUZWluWSt3?=
 =?utf-8?B?UEZEbk9SWGw2WmF1Q1UwNlIxVlUxNTJlTFJWUXo2VHd1Z2JaU096V1JuWnoy?=
 =?utf-8?B?enc4SzMrd3dwcTRLZUdjMjZFVHBOdWhVaXNYdkhkbnlhR1Fhem9qQlBxT0Vv?=
 =?utf-8?B?am92VW5SR2lFTkxFcU5CQWNUWVMvZHNMVWwrY3kreWxmallzUE9PMTE1UEJl?=
 =?utf-8?B?Q1NWUi9KRklLQzdiUVExdUtvRDJVV3gwZUZGVU1OclM2UXJqNHJwUjVwMHFu?=
 =?utf-8?B?SDhhM0dPZXVmRkcxSEtCNU1JM0JVY1I0VGZnVEJIMWpYeEREeVlsSGJtTE5r?=
 =?utf-8?B?Y3JZVTkxOTNsb1RmNElWUG9ieWV5NTFOa1NzcVdlRTdiWWp3dlNhdTZOVjQ1?=
 =?utf-8?B?bkNOUzVXd29oa1ZmUWZEVVVIT2Q1enIxQjF2LzZWWHZLQ3pUVExtUFROZUx0?=
 =?utf-8?B?bDFXakhNajVNUjBvM0NVRnlCMzYzcFVwOGRvb3RjZUZLN2hiTHYwdFBxZ1hv?=
 =?utf-8?B?SVVwZnYzUFg4Uk01Rkw4SVltS0tkaUJ6NFFSdFF5MGtOZW01SktYSHdvOUc4?=
 =?utf-8?B?b2dHcFI0VGU4SUFHaUMyVkZxTlZhNUszdTFUdTdpdXRNcmUvWnJCaEtLd1p0?=
 =?utf-8?B?bGpYNnJGSUk3L1FoWjRXQU5mbUpkamhTcGVOa1dGT2hLS2JQTHlYYXpncCtt?=
 =?utf-8?B?M2tiY1ZMWm5EeXFTays4bVdkLzFRczRCSXJVM3hyV3NwZkQyUXcra3RIZ2JU?=
 =?utf-8?Q?HoBiFpghmXkcA6FpYANW/zPoV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3iSrtlk1IFbciU3qpI58EcHJ6dUEYSf0cJVtxPY3NJi3ke596xe6reAEYex1jhY37AQahfjBsa5PgqQ4btdTa73eRAHaxHpSuxS0cxHPM+X6Kbta/2G2aTpzpNblf5z0EdldZcOqpfR5Ij7T8OQ/qyofRNMqd3ZeSLtnK3h57Tg9YZLniDkgCsaEgogA3Uxn8X0kPxM8F+0EXnHf69b6GjlQVGV4l2BqaCkDaDO8RJzQODPwBWmDOEvpakDL8hBaw1UP/nF9BsCQDuTM5P5qnBk3/B6slR0yko3rDLu3Dpafc/uWcwbqQ1e/SHNnDoI+EHDvEphy/JAHPfnqkj66gmmtgN3+5Ly1vtxdiiLYrEQMz8u0kHfZpB4WFOFo8VheByHmoq79fe37uOYn+2UKlnNkYgduT50JF+ytuk9rUDidniLijK1E3fbZeU0VyFJQfclR15GOgXjsP/DrzX8JlxqlonSuXudZsnSr3JkQot2TPO0U6bM8nwmOJJeJ8V2Gk7+pwY27O+TGbqxQAr9Xk7nbJaoWbZDyPo7OjVSiGsBh++jXc2mH3N+HyKYmlfJ/gHx3s8Ymf/hSHJkUgUjYY5pAhCGQwor0ApxSuD7tQ1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb47d10-999c-4321-ee7f-08ddef45597c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:05:29.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5WDDedCpr7FUT0LGgLdvdRWGEnZQzlBtSqyKgmZQFx18Rwh0wkTbj3FyppKhYpcqaqEXvE6WZCjUPILj0Qtqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090019
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68bf8b6d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GuGNfuqjukStBVvXjAoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX9dl5j4JQ6n5+
 s1a41M9oeEqcOFNDQxtzW5wN3z3ER8Bmg8T3WC8uGyiuIMdltrt4AiW0Bc0TA0IntWkr9isrEzb
 /L1M7uhII1Ld9A1YzRC4ToHZrTuvWc9yDNmCyz/+tIUYPbA4baSodq28bL3LMvDPTOPtpuXOYCl
 GQ7ReAdXir35PCCnO1dIxOgpluHZYgskOEj5sf8fggTxjqsSGW3vfUJOYFXQ3Va2nC1CVjFfvAL
 +R9L/PyhDEHKX9ruIh0Q/ASE8X4ygWW30FrtEY64AvAnt+lw6KR1HT0JNKIa88trgFG+vVCj719
 dyWGrS+VpaZEwV5kxuSMnfVOoI1ZRUDn7r2OlIE+FrChCdrsBMAAe0chnDtyYd3plBgGixrntSf
 r3UN68pp
X-Proofpoint-GUID: jmYMDz_SsQ93pwjWYXEMr7N43ovUyRMc
X-Proofpoint-ORIG-GUID: jmYMDz_SsQ93pwjWYXEMr7N43ovUyRMc

On Mon, Sep 08, 2025 at 05:08:43PM -0700, Alexei Starovoitov wrote:
> On Tue, Aug 12, 2025 at 10:08 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> 
> Sorry for the delay. I addressed all other comments
> and will respin soon.

No worries! Welcome back.

> Only below question remains..
> 
> > > > > >  {
> > > > > > @@ -3732,9 +3808,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > > > > >       if (unlikely(!node_match(slab, node))) {
> > > > > >               /*
> > > > > >                * same as above but node_match() being false already
> > > > > > -              * implies node != NUMA_NO_NODE
> > > > > > +              * implies node != NUMA_NO_NODE.
> > > > > > +              * Reentrant slub cannot take locks necessary to
> > > > > > +              * deactivate_slab, hence ignore node preference.
> > > > >
> > > > > Now that we have defer_deactivate_slab(), we need to either update the
> > > > > code or comment?
> > > > >
> > > > > 1. Deactivate slabs when node / pfmemalloc mismatches
> > > > > or 2. Update comments to explain why it's still undesirable
> > > >
> > > > Well, defer_deactivate_slab() is a heavy hammer.
> > > > In !SLUB_TINY it pretty much never happens.
> > > >
> > > > This bit:
> > > >
> > > > retry_load_slab:
> > > >
> > > >         local_lock_cpu_slab(s, flags);
> > > >         if (unlikely(c->slab)) {
> > > >
> > > > is very rare. I couldn't trigger it at all in my stress test.
> > > >
> > > > But in this hunk the node mismatch is not rare, so ignoring node preference
> > > > for kmalloc_nolock() is a much better trade off.
> >
> > But users would have requested that specific node instead of
> > NUMA_NO_NODE because (at least) they think it's worth it.
> > (e.g., allocating kernel data structures tied to specified node)
> >
> > I don't understand why kmalloc()/kmem_cache_alloc() try harder
> > (by deactivating cpu slab) to respect the node parameter,
> > but kmalloc_nolock() does not.
> 
> Because kmalloc_nolock() tries to be as least intrusive as possible
> to kmalloc slabs that the rest of the kernel is using.
>
> There won't be kmem_cache_alloc _nolock() version, because
> the algorithm retries from a different bucket when the primary one
> is locked. So it's only kmalloc_nolock() flavor and it takes
> from generic kmalloc slab buckets with or without memcg.
>
> My understanding that c->slab is effectively a cache and in the long
> run all c->slab-s should be stable.

You're right and that's what makes it inefficient when users call
kmalloc_node() or kmem_cache_alloc_node() every time with different
node id because c->slab will be deactivated too often.

> A given cpu should be kmalloc-ing the memory suitable for this local cpu.
> In that sense deactivate_slab is a heavy hammer. kmalloc_nolock()
> is for users who cannot control their running context. imo such
> users shouldn't affect the cache property of c->slab hence ignoring
> node preference for !allow_spin is not great, but imo it's a better
> trade off than defer_deactivate_slab.

The assumption here is that calling kmalloc_node() with a specific
node other than the local node is a pretty niche case. And thus
kmalloc_nolock() does not want to affect existing kmalloc() users.

But given that assumption and your reasoning, even normal kmalloc_node()
(perhaps even kmem_cache_alloc_node()) users shouldn't fill c->slab with
a slab from a remote node then? Since most of users should be allocating
memory from the local node anyway.

> defer_deactivate_slab() is there for a rare race in retry_load_slab.
> It can be done for !node_match(c->slab, node) too,
> but it feels like a worse-r evil. Especially since kmalloc_nolock()
> doesn't support __GFP_THISNODE.

...maybe it is fair to ignore node preference for kmalloc_node()
in a sense that it isn't great to trylock n->list_lock and fail, then
allocate new slabs (even when there are partial slabs available for the
node).

-- 
Cheers,
Harry / Hyeonggon

