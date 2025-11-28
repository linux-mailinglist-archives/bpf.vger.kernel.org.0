Return-Path: <bpf+bounces-75687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F362C9127A
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 09:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF44C3AC0E9
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1D2E6CC4;
	Fri, 28 Nov 2025 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HMXdBEWU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xAHX3Do/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B92E7179
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318724; cv=fail; b=fIoGRj8z8sB/wt0PUGzw62COPeQmunOgfF8woV7e3HFNncjcKGnz9fZL8AqnoKOy+sJ3FwOkzLqrrk8szykksWPoPIJGUhAtbydCBLfY7tPl68vLCUMzLUfqEeUYw1RUtvP0RwEl5XLjsfbSWieog4/jwx/C0NuhD2v6v0YTROQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318724; c=relaxed/simple;
	bh=bVT3VFVmN6hSNe2dwKdlQSjsDw8RjJ67yac8gxwSUMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K3bCTB+Ydiz2PYPxXQEypIGhwriKxMtpUcijqtSN9f9Flfe6tJwa2QdJHDzwqSPfvlZQi2SALKjIyjJS4zE7fU6R6tP4Ra12/jn2IVF7kpv8M931UgFhe6g/9JtcvRaL/UGxo83aZJlbBhzix2yV1QCnNoxSr0sk8uNIzZUMmXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HMXdBEWU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xAHX3Do/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS7tve52905719;
	Fri, 28 Nov 2025 08:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bVT3VFVmN6hSNe2dwKdlQSjsDw8RjJ67yac8gxwSUMU=; b=
	HMXdBEWUWwdaeDauq7iqXGSPHDZFHflmdXhz+tskeKBEXl4+8tYhakhbw3wbJKv1
	4V2bavkWHpQYD2kqVtG3iYHQlNdRhyLELxmV1XAzsZ0occc69duQMMvjxuOeuU5G
	7qU6VVU0xIf0kAn42+j90pHDIzPvDS1bWzdQxsjKyUPbaJINHmMwts6o7ZjGjPHo
	w1l2Tcu1GvX5dWARGoehQYOceR7imqfXgquwa/lwC1OTnfxK1BdXmsFGT/ExW2zL
	J/h9wpbqVw4M6WyoK4Dal2z9CHvoJSuJmx1AtVy/IR/sM/gp0fvXNles/M1O9kYn
	oRfYF+PEBWnaI9yGVhRWug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aq3j8g98w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:31:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS7Q9fN019729;
	Fri, 28 Nov 2025 08:31:09 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3md179b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVXMx/aFqSj/duopIPREIg36YNDMZfsXJ06tUxDaTBP+hr04rEMTHLytWIDiVBXF+iIl8tN8xPtp47jjnEbVcILhDUN1IVxV+1pxxGaasisguzYUIMaMAoc4QY85qLFgmnzh2Cvb3dhqAOXNOxNO4Rv57sP5Fh3D8uBgFY2LHWTiteyq/w5qxkamPJI5omPDixBuawwQuYf7YtsBMdgIGO9lqfHtGXwlpnromQKhR/LSyrTvQZjgWJ1IJ1QhkFHR7tk4I+9Hdtfobw2qWQ7IeJcO4c9G04aGXGbXHieOWF1zwMwY4vMkNmUaAYx9jyDcHHIRN1L/5t2ybomZjXpDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVT3VFVmN6hSNe2dwKdlQSjsDw8RjJ67yac8gxwSUMU=;
 b=VJRHFtkrWCpB7m4HkZ4/T7fcWiA5EannBPoMgT04ORBx3HeJZoLv+8KOztZ2p55QmjmnuYyw96Y8aZsNfL8yHzkmrFtuj4QATZzahEGSZYjLlTrs8UB+cGCZi9iAOBcs8hYJXhwCgWmcoJ1IJNb6dU+RmkKeXhAUn6LcrjGBc8TeYzzQNldf/BxAyg+m49N1ZIUihq8/ctmFviKXoN6gwnYlDytp+Do1KanxqyR8VJ4QYcqSIZ3Wkp1y2nhcO1wsUtS6ijOmGrNLtDbg8MoKZ60N4ncRejaD+OL1gWoL287kAAVAMJcAVal48bcVYBAB9R9QIAi6cyLq4HwabG6s/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVT3VFVmN6hSNe2dwKdlQSjsDw8RjJ67yac8gxwSUMU=;
 b=xAHX3Do/cAwcbciofLBoMqFtNjBpeh2Q59TpJOUi4Xi1dQzAykLRt1LGJhyIolO2xDl/Dw86ulwTaPMAaXKh9o4csa16ugl8iyAZZ2ZmPE7jGbnezUTCn7Nlbf3mfFiZIQ32mjPfdFSIzn5J1bIw1HhBoEBBENIF7dwsUNwkJKw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 08:31:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 08:31:03 +0000
Date: Fri, 28 Nov 2025 08:31:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Liam Howlett <Liam.Howlett@oracle.com>,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com,
        Matthew Wilcox <willy@infradead.org>, Amery Hung <ameryhung@gmail.com>,
        David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Barry Song <21cnbao@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
        Tejun Heo <tj@kernel.org>, lance.yang@linux.dev,
        Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>,
        bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
Message-ID: <f60522c2-e10f-45b1-9501-9b1e4223d8ce@lucifer.local>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
 <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
 <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
 <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org>
 <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
 <48878c07-6e8c-47eb-bc8e-13366c06762a@lucifer.local>
 <CALOAHbBKxHDuGoND5xwxsScKY6aW8eiqE5QuHppd25RpYHf_pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBKxHDuGoND5xwxsScKY6aW8eiqE5QuHppd25RpYHf_pQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 105464ac-d093-4df9-1925-08de2e5877a4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QW5BUkgvSUhha3dIV1FXaWRORzl2MEJTYXgwSkRyZHlhYkFOMFIzcTJUblNL?=
 =?utf-8?B?Z0MxR0hOajA3MjVWY2hjQWZYSk1rUGtJTVNmVjdCQkc2eVNQZWx6b2hIMkpU?=
 =?utf-8?B?U0cvY1JUc25FTEFzaFkvL0NQTEdsNEhsV3ZYYzN1SlYxTHcxYzJkbFV6SjlV?=
 =?utf-8?B?THpYNjFFU1dFVmIzWlBnTHNBL3NLOVVKUmE2VEM0U016VitEaVk0YUlIRGJC?=
 =?utf-8?B?RXBGdW5rUXhDYytoSHF1U1NzRWhQaGFKSzBVQ3ZnRHQyVUJVQjR4ejhDbngz?=
 =?utf-8?B?c21rL1I3d01EbVdkdW82b3hTTmlBRjRqRWVYOTV6dnFFMlVpMm8remhyd0p1?=
 =?utf-8?B?Z1VQT3l3QitUSFBNTDBLbDUrYm1CZXZhTTRqY1Z1Q0JPZVRvZ09iL2JDVzBu?=
 =?utf-8?B?L1hLTG5MOTgxZDRqdW83Wlk4MWx5cEVVYXRzZlpQbWZQVVVGL0swbUVsK2Yy?=
 =?utf-8?B?NmZsbml6N3BlWWlZcmRILzJsRVhNUUhMWndUZnlpL3ZkM1ZHVkdoaUFydWUr?=
 =?utf-8?B?UmtjRE1PTjNsRk9ROU1VcFNxQ2ZNakV5Tk53Tkt1ZDhNaWdYUW56U2t4dGM1?=
 =?utf-8?B?ZDg4VW40Rmgrci8yNW94aEh5T3c4ZUxLNHpIZUpIOG5FNU44dE9EbXAvbXdn?=
 =?utf-8?B?ais2ejdHVUFvWFdwL3RlQVpnczdvVkhmZkF4bGZMbjhhdnoySDdDd04xWDU5?=
 =?utf-8?B?bWQwQUhUdDNRMXpNbFhRV0lmL3VYaTdOSk9QWUJHaGcveGNlVjJXN1BQVFF5?=
 =?utf-8?B?d0JDaks1cFhmak5lMHRiTFpoOU1nZFZCdzlhUlNCa2RUcVEzUEF4ZjYvc3ZH?=
 =?utf-8?B?UzdLa0JXY0ZueVV6c2NrdGFidytnNW1rV3haRFg1OUhCVGRqOFdYbllKaXdk?=
 =?utf-8?B?blYxcmlGbzVJWVV3cUxNZzZIenQrVDU3SDNsNGUxeHFPeW9NZ1Z1M2JSTWgx?=
 =?utf-8?B?YUhiTHJBR0QzN1p6aldQY01zUkJnaFBEd0I3M3p5ZnNzOWcwNTFlTnlYUUd5?=
 =?utf-8?B?TkRUOFpVUmVObDY4UGJGaGhHNTRCd3NFSkxsS0Y4bmRUMW1TZlkvT3BLWGVy?=
 =?utf-8?B?YXVua1hEbDZhT2xOakZuZTFJYzg2ZU1wd3pEa1hndnYvdnFKUGNmWU5Id0hx?=
 =?utf-8?B?U3hFYyt1MGZObU01RlUwdmdidnA2eHd1bXRXM0Fwb0JIR085b01YcDNjclM4?=
 =?utf-8?B?TC9IV0FmRVNRMjY5ZWM5dWtwRGRBd1BkNGdZTXBlTWFkT0xlNmJUMGdvZnBp?=
 =?utf-8?B?NHh4NDlLamhtK05CeHFCdnUyYUJuS1NqQktXTXEyT3NTTm16N1BRTjNEZVRH?=
 =?utf-8?B?TEd6UHA3Yy91dUhibmc3N3RSaXRNaGx4UmFoUUFNQVl0OWJyRjduMktEUTdI?=
 =?utf-8?B?NXV2dm1uNTM0dVZSSDVoZGZ2MCtxaWZjNyt3eWVCcUE3QktYMG1PM2hTOCtL?=
 =?utf-8?B?SzFud01NcjNtd3Vyc0F1TFFuSk1XOWZFdDhmQ3NXVnNoeExFMldlTEdDa0d5?=
 =?utf-8?B?ZktYT1FqNE5VWmt6U3owcmNmdyt0M1o4Q2FoVjZwOUpzTlZKUW5yZVB5cCtV?=
 =?utf-8?B?YmRBd2JsRHJYNGdOVGlUeCtEaThCai92ZVB5NXNYLzMwV1k4KzFPUTVwdm9u?=
 =?utf-8?B?MVVLYW9jM3dPZlV4SU1VcDJXWE80WndIaWhXL0U0VHgveTNESERIRkY2T0Z3?=
 =?utf-8?B?WWxETDl4a1JPS0xlbTlrS2N3L3EzV1ZWR0ZxZE5YWk5ucWpCSXl1Z2dkbFgw?=
 =?utf-8?B?ZEtlQ1BqOGxkdENqWEtpc0tnS0MweXEwWFJ4eFlyc2NYM0lDdUh4bXBORjc0?=
 =?utf-8?B?djlsakNTaW1mU3VuWnVRK3ZVQ3hCcFppRStRZEFlbXZmcmV4VWFqUVNSNVZS?=
 =?utf-8?B?VVpVREZOMjNwT3BsZW5McEk1WU81dGxRMGQ2TFM0aUhYeDQ5UlMrYlRVWGNn?=
 =?utf-8?Q?dUL2zaem4EkJRkfgI3Ts854QUzFU5tLY?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c0RXK1hqL0RyQ2I0TndDSURuSDAydXZ5Q0lYNDVvSnFsQk81WXJjd0FnUDBX?=
 =?utf-8?B?S1JDeWFqVGE5dk9IM3VoVE04L2JPMmIxenpzeXFMOUFsZWNNRzA1L0lFaFVS?=
 =?utf-8?B?M0JkTWNMSDhEcVkzMURKSWxIY2c5THNUM2hlb2tPbHQ0SGIzVnFWQS8rZmN5?=
 =?utf-8?B?RU8yVHB3REE1Q2lwbFVwWGxzZ2M2R3hsbzdlbHpYTkFqd0ZYaDN3UXoxZXdR?=
 =?utf-8?B?NzlDVzg2MXE3V2dZMEcwKytDQ2lLUXI4bzY2NkxhUWduR1R6bnVFaWJWL3BD?=
 =?utf-8?B?ZVNWUHZWWWxNWWxnTnRQekpqN3RkelVONVBVdWo1YmR6WHR5UjFaMUFSS3dI?=
 =?utf-8?B?bW5tZnd1bkZFbUxPdDFlWmw2d1B5TkRTN3B6d21VQ3RlNWVqMlU5WTJkNzJo?=
 =?utf-8?B?UjJLTTFhNHVidFplVEdybDIzT2ozUDVIcEY1RzJQVWtuM2twNXhwVXZKNjJC?=
 =?utf-8?B?TVNLdWpacXA4TUxBbDcreDZJdFp5QmdPZ1J3RjRkdXZJazEzcHhEdWR2clIw?=
 =?utf-8?B?dUU1R003ZlNxejkwSVJNRXl0dWViN3g4R0hCbG5pVGU4YnZwTmh1bzZwK3VD?=
 =?utf-8?B?MjNnU2pjV0xSK2dPcG54WTFGRXdTMjdINWk1Z1g3ZlJBSmNkbG85LzZzMnRZ?=
 =?utf-8?B?ODFQSmRRTnY5TnNBaTVKdXJ4WVB3aXQ4MUFFOVNvSkM3NCsvbE0yamQyWHNs?=
 =?utf-8?B?NUZEanQ1aTFtMG9adEk4bjNFMitMM1BOTUx3dVJuWjIzRW5YNGFuUHVLK0Yz?=
 =?utf-8?B?UDlYNTljUDhSS1ZuQlJ3bzJ5YUhMTWFUSkpoOGdkbDNRZVlRQm9jaThiWEYw?=
 =?utf-8?B?akhmUXErVFo5NElzY3djTjZlM1BvZDFzWXVQRkplbGRXRTYxTEovN0NFSXZM?=
 =?utf-8?B?c1VEa0pqUzYyZWI4Y3hkSFRyV3hGNzgrQWhJT2p1eHVaY0N0UnhEUC8yVFVF?=
 =?utf-8?B?Nllldzd1QmdoeFB6SnB3YkUxNG1JOG9OMTV5c1oza2sxYzgrT0FRMS9zYmFp?=
 =?utf-8?B?a2VvRlNJUk5CVitNMFNZTitTNithbkhGbFc2N3J2TFFpdElkbWpaaTVGSXJz?=
 =?utf-8?B?NHpZcjVyRjBRRVg4Y0E2SytEbnh1UkZGNEZ4RE04RWlIbXV5VEQ3aGphcDUz?=
 =?utf-8?B?TkVzdzdKcUxTQzQ3NDB5aERJYUZ2eXE0OHFOYjdQbG43dm9VWEJPOE9yTVVC?=
 =?utf-8?B?NFVkOHRGOEM1Sk9paDNHc3NKZ3dmZjR4MndnS3Njd09XZXpKdkZVczB1RzY5?=
 =?utf-8?B?ejIyNnJteUo1bHlGWmFTK2lLckR3Vmhndzd5ck1OUUNaTS9VMlZpaEVYaGVl?=
 =?utf-8?B?Z3VramdFQkxndXVsaW54VmVtQjludHowWXRXeWszVjVMeDRJU01sUnRtSVV4?=
 =?utf-8?B?SG9vS0k1RGdzVnpKU09HSnR4RjVzT2dPTk8vWXVXdTkyd01XeFlya3ZHS2tn?=
 =?utf-8?B?aTVmUVFrS2NHRGNGRGdLN2U4QTBpOHBGejc3eWRIVURzeU9kZDRtdVBySE5i?=
 =?utf-8?B?elZ6bzhrNzV0cmhhYllaUVJWcVZ1YnlQZWxvaURFS3I0aU5NQ1VMRXB0ZXFL?=
 =?utf-8?B?MnNiQnlKOUhKakw4K3F4WkJDTDdtV2Q0dUI2OU4rYkJvaXdzcHJYWHNYVnpY?=
 =?utf-8?B?dnRZNktlMW5kZkdZYkhES01tRElPenJtTnlOTlU1dFpOS2h6dDVobm4yYlJl?=
 =?utf-8?B?UnRvZjdDaWQ1RHdaQ3RvUHN1V1ZDV1NmUThybzI2ZHdJL3owWndpR0ZPbGNh?=
 =?utf-8?B?RFJuTnN0ZkNzVVNSdWQ3VEFzeFFJV1Z1R0JEMWkxYjk3blo1KzJHQ3NES21l?=
 =?utf-8?B?RU9IRXZId0xRUG9veDM0YU1NU0VMSE0yV3B5WThXOU5YNndiVmRQU3JydlBB?=
 =?utf-8?B?S2ZDNmZ2VlJXdGtBRGYxODFzaDRtUFpBc3o2b0cwV0lQZjZQOWdMUlV6Umgx?=
 =?utf-8?B?emZvNWdwMXBPa2JiUUc5Um9PMUIyZk9pRUs2aVJPeDcxWHFJM3l1dndYVUZa?=
 =?utf-8?B?VnlkN2VXWXJmNDlZWGJIMENteHhYdzJ0bVJtTDhORWNzNjZLR2RFY3BnMSt5?=
 =?utf-8?B?QU1vdVJzYUY4ZCtSaHNmV0V6SFEzSXYvbHNNWkYvOVZTU0oxZDNjTkJZNHhq?=
 =?utf-8?B?a0cxUHh5QXVLaVFQNCtaUzh5Z0xXMUhxNDgycnBWNFhQZVdLTGdqU0VDWWJN?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Zcvla4vyfFG2r5Cjszb3vp3Hnv7ZXCuKINwdN4uKLjdw9cdg12IK28C/LnpTUos+SQ3DBiL87aHOSCePYhqtwpKxpsYDl0UZsJapuY5ShP3eT4UP7iEyYXTeriFvUTBDjLeG9ScYdZjHX4B7Jm4zPBWdkH6UDO7U0CoyhJuNk+e5hs7hUz/Ty00+seMYeiPUO7H4knMfWk5nHVWzbePoiYczNcPDaYOIo35053tYXnUjh8TzSW7x8RryxNL2cp3t6K1JYj8mhQ1T1+LFURCyubfBjtM+NOJ1R7U3CAbBGLDo6WQr/PCS4CiybGYxXYSkDjvQwKIcX94rdoMptWrrkjeVEPeUsFwLNdITDD+EvoVCTnPSqcz4loqwkQvK9k9xhIOocs0cd3TgSq2RFRR3rmGatsH7PGpZC+usJnMPFMVg4Qg2bxJCCkidh9eDITnXnXGQ5m41Mvl6xacrcOR14SutXnXze6m1flJMpdp0tIb3LU7+wPnN/9XaG6xXUIG87yNx5LW4d3puoCr9vYJYACZE0He1l8SM4dCibF9m7c95c9aZgt7/NXyDaJbvZSq5YaRPzTY7YPhJmsDemAv7duvJUbg+lkDYbELleD4NQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105464ac-d093-4df9-1925-08de2e5877a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 08:31:03.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIOGSR+wF1SaYyZnNf5jOe/he5AYjikfvadWbSwn2gw5e/E4VJtcIPcY399zKGbHPItyfzSekLWmh0lhylEmZZgQGBkjvz5oFhtvO025xHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511280061
X-Proofpoint-GUID: -zV7qQXzrJ-6DCIQn4hRT2cCKDqOtk-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA2MSBTYWx0ZWRfXyBwfXf1e7iRx
 QfBuwtCH8xmIeLSq/woowf2NQ3KG5jdSuwPzpzhfVhbmVlePr2xzPxtpgYXaqjlmnFBeVo9DeOH
 TZJSFOrbmpAk5A4HWTj1dVX8hUUEZUPP0rYnPvjhR5as3HO1qWRJyXEwy8nmM0j9ZrOOcBU8I+i
 jyu4tJcosRlE3wZZPb5FP1k162cfKyEL17z6BhHscdB4htT959G/C8UMBglfEJ1J2Yjdtxzrcv/
 uLaIvdxbxMZDfdBWs43s0P1xoa22z805X62cfzZHDkaybh/pGytMAXZVpWEXfGY4Oy/vYcua1hs
 Nf/0oHUKYKIv0WZUlBhZKQL4TWlEFIY7zP3dokk5V+EtW8wYJtJY7hwvXFGGu4YQy3uOIoL4M6W
 CJuTquXoSJ8LIQ2+ynPLjveays53eQ==
X-Authority-Analysis: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=69295dce cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=zZ_9duETlrxAL72B5cMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -zV7qQXzrJ-6DCIQn4hRT2cCKDqOtk-X

On Fri, Nov 28, 2025 at 04:18:10PM +0800, Yafang Shao wrote:
> On Fri, Nov 28, 2025 at 3:57 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > TL;DR - NAK this series as-is.
> >
> > On Fri, Nov 28, 2025 at 10:53:53AM +0800, Yafang Shao wrote:
> > > Thank you for sharing this.
> > > However, BPF-THP is already deployed across our server fleet and both
> > > our users and my boss are satisfied with it. As such, we are not
> > > considering a switch. The current solution also offers us a valuable
> > > opportunity to experiment with additional policies in production.
> >
> > Sorry Yafang, this isn't how upstream works.
> >
> > I've not been paying attention to this series as I have been waiting for
> > you and Alexei to reach some kind of resolution before diving back in.
> >
> > But your response here is _very_ concerning to me.
> >
> > Of course you're welcome to deploy unmerged arbitrary patches to your
> > kernel (as long as you abide by the GPL naturally).
> >
> > But we've made it _very_ clear that this is an - experimental - feature,
> > that might go away at any time, while we iterate and determine how useful
> > it might be to users in general.
> >
> > Now it seems that exactly the thing I feared has already happened - people
> > ignoring the fact we are hiding this behind an, in effect,
> > CONFIG_EXPERIMENTAL_PLEASE_DO_NOT_RELY_ON_THIS flag.
>
> Thank you for your concern. We have a dedicated kernel team that
> maintains our runtime. Our standard practice for new kernel features
> is to first validate them in our production environment. This ensures
> that any feature we propose to upstream has been proven in a
> real-world, large-scale use case.

This strictly contradicts the intent of the config flag. I seem to recall
asking to put 'experimental' in the flag name also to avoid people assuming
this is permanent or at least permanently implemented as-is. But this
iteration of the series doesn't...

I no longer believe this flag achieves the stated goal, which is to give us
latitude to make changes in the future based on internal changes to THP
(which so sorely needs them).

I fear we will end up with users depending on it should we ship any form of
BPF hook that we aren't 100% certain is 'future proof', so it raises the
bar for this work very substantially.

So I am really of a mind that we shouldn't be taking any such series at
this point in time.

>
> >
> > This means that I am no longer confident this approach is going to work,
> > which inclines me to reject this proposal outright.
> >
> > The bar is now a lot higher in my view, and now we're going to need
> > extensive and overwhelming evidence that whatever BPF hook we provide is
> > both future proof as to how we intend THP to develop and of use to more
> > than one user.
> >
> > Again as David mentioned, you seem to be able to achieve what you want to
> > achieve via the extensions we added to PR_SET_THP_DISABLE.
>
> We see no compelling reason to switch to PR_SET_THP_DISABLE. BPF-THP
> has proven to be perfectly stable across our production fleet, and we
> have the full capability to maintain it.

Again, this is entirely your prerogative, but it doesn't imply that other
users will need this feature themselves.

>
> >
> > That then reduces the number of users of this feature to 0 and again
> > inclines me to reject this approach entirely.
>
> I understand your concern. Our intention is simply to contribute a
> feature that we have found valuable in production, in the hope that it
> may benefit others as well. We of course respect the upstream process
> and are fully prepared for the possibility that it may not be
> accepted.

Right.

>
> >
> > So for now it's a NAK.
> >
> > >
> > > In summary, I am fine with either the per-MM or per-MEMCG method.
> > > Furthermore, I don't believe this is an either-or decision; both can
> > > be implemented to work together.
> >
> > No, it is - the global approach is broken and we won't be having that.
>
> Let me rephrase for clarity: I see the per-MM and per-MEMCG approaches
> as compatible. They can be implemented together, potentially as a
> hybrid approach.

OK sorry I think I misread this/misinterpreted you here - the objection was
to the global approach.

Yes sure perhaps we could.

I mean we end up back in the silly 'THPs are not a resource' argument the
cgroup people put forward when it comes to memcg + THP (I don't
agree...). But let's not open that can of worms again :)

>
> --
> Regards
> Yafang
>

Sorry to push back so harshly on this, but I do it out of concern for our
future ability to tame THP into something more sensible than the - frankly
- mess we have now.

I feel like we must defend against painting ourselves into any kind of
corner worse than we already have :)

Thanks, Lorenzo

