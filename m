Return-Path: <bpf+bounces-29945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B08C85EA
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 13:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B7F1F22F5D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A783FBAF;
	Fri, 17 May 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eRrcvnzn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XYv4RQmC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C43FBA3
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947034; cv=fail; b=higuia7FjPmpobhXoN8ou2PaIw8mWsx/MStjk6dkYrOXajWjmvk5umgn6HpcfH02W/TDXa164/gSruVodUsU+vp7nL1c/KSAXxvmemzSxnem+O9ebM/VPhKPbBooFzOajrd1pfzDGq/xgYVR9veI96PXXB8ccP3ORLbqWfP54sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947034; c=relaxed/simple;
	bh=VRFtYOUDtQcVfDElT++6ElaazKMhiB4NQ3AyYTYHXmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+yX2ijeRVFuOSVTw+/GUl0AuAUUYohuLxbcZ8W3IfFeitMQsK+7Trq3CCRk5wG1Ug3RTYA6NazhnBtnSr9fzeFqAYr5t8VAPKGK4YY9FnPBDB7LeZoVoVI/KlhwstsJ7FlSoL638va1CEvvj/wu69bEL1YMU99EqZja9zuqpJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eRrcvnzn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XYv4RQmC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H8IRuu030157;
	Fri, 17 May 2024 11:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h+eIOqWtRxbqXm5jZYEEFNKGr1/hP10Y/HyEoxNdRtY=;
 b=eRrcvnzn0yLf7lcmJqN0FPuiD0EbGo9jyXya7ydL8nB7Azz55OB7jxeQcfHIeaAK9k02
 nW3VZ+qHlEw+Bcou65V3otErlA6fxH2wpsvN/Izu317e5ox5r+B1JmJve+Tq11GbR5HQ
 7r1Jbaj4/UUkveLCsfeCinOU0bOS7ccCRsFIkUTIRx9Kk8PJqkJvpjXtLTQGXmRNVlk8
 5m81gv9nmxtUUCSaRoreGW5kL1LPeN1zIzfg6mnzyevwPp7Vs0IDc2BK+0lukXfQWjS7
 eTg4h7CId9DqkVOeVZco0eRakb2OZuKZJKtZKh0oTLiJzQqldLn3CvaD7Az4dhkn7Iyy Gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx39e2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 11:56:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HBf060038340;
	Fri, 17 May 2024 11:56:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24q18s3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 11:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkL5FWPY0JO66b7QbZXqadf5M/c2Mc6dgpzT0QyW5KGC1kWCQ85JeG6449rIxEPQAgGbhCBpqytWmIcl3Z1fEnk8UZXGAxHUc8eRVEroX/BXcg2ANbPs8VY26wqPPJ3yCbDOBmFQhGqCFAftTK0KpxLnT9bP0hD4UjVP6Fq+XipLteHBHuj70MONjdEcK6f0+Utik2D1QLHodzVFaZ/W5ENtv+4enLW6Z1MYycJ7cJBjGvYObyoZ2BgwMzntEghmYfebIgQhqCvMD9W/H3tjesgbLLW9ewAFSi5Q7zX33aJ0LKs9//SKWGcfryCZ6ZqeWGOkkDzkkIn2wKAdp1Wa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+eIOqWtRxbqXm5jZYEEFNKGr1/hP10Y/HyEoxNdRtY=;
 b=iiKzD25yYlxpzzRAsHvl0pP/Tcmy+UsfhsEbJUQpO0CDHQS+UAYxnnJhGsDv3S8TnQEdnEjap/dIgGHAxaLyRVLA4eYaYqn8Rr8Sh5OcFveoXHlLjTmjb0ms1q2gIVc0+OuxrL8dowChSOnaIIflnvflnCF3uDppimjcew1lgELmIuU/I7ynebhYTOj3Clj6t4KszFCStlX3/+xPkWLiBZotSPikbfkJCyrKgiA+a/doeS9ngYLea647+F3slC548fNHR15eNkI/42jjWkeZALTUlnc6W2kPE1UjL9nUx71pcKrI39Jy8AjdYJ4cegk8wE5GUOGv8KxaJinXDCxYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+eIOqWtRxbqXm5jZYEEFNKGr1/hP10Y/HyEoxNdRtY=;
 b=XYv4RQmC2xgcCLL2WcpZcCvSqX+mdenGkdIBQ4btwWCzWq9GuFd1UavoaYHkPBqHaiqg63vrzr33QMCWBZbXjmQEjyeIgh3M/8f0lSaDaR7KWHPZwHL+VlcENLzaQpJprvCAmQbY6L7VCdo9+YpXnbWeoBPkiOMA6rPl9QXWrw4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 11:56:43 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 11:56:43 +0000
Message-ID: <3fc71c22-cf9d-410a-bcc0-6de0d21b7cda@oracle.com>
Date: Fri, 17 May 2024 12:56:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo de Melo <acme@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>, Eddy Z <eddyz87@gmail.com>,
        mykolal@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        yonghong.song@linux.dev, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, houtao1@huawei.com,
        bpf <bpf@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        "Luis R. Rodriguez"
 <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <CA+JHD93=ZcVN4GxepbRF6SLorWJjw0gCgJZUYxQG5hxFehdHUw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CA+JHD93=ZcVN4GxepbRF6SLorWJjw0gCgJZUYxQG5hxFehdHUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ed5e56-6960-4582-a211-08dc76686b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RWxSSVh3SkI2WkdMVzg4NjZaK3FOcWRpRmhscGwxS1NESGxsTzdjeVhrUnRK?=
 =?utf-8?B?K1VWdkpwTlA4ZFF2Q0YyQTRGaTgvTE13NXF0eXAwZlFZVlJHY2dVYmNaOGQ2?=
 =?utf-8?B?ZVE4WncrYkdSc3NLQVMwZThjVTVUMFRQd2FTL0lFMXZxbTRTcDh4L1lSQStY?=
 =?utf-8?B?U1N4TElpeVF5TFZBOWdmR1NmUE1nZ0V4QUJpNWhROElDTDlWai9pU0ZsWE1G?=
 =?utf-8?B?RmJWS0RRRnlTeGtMMUlEelhTcHc0SjNDTldTalVQcjlQYTlQQ1RKWmljMUVm?=
 =?utf-8?B?T0lEVDB1b0NEbTMvWlZIUWprOEpHZUpoaktLMnNpbkVGYWFOWmxoQWtGSlhU?=
 =?utf-8?B?dVozOEtrSmNwcnJZNmRna3Noc2U5RXR5R3IxSnZUejQ1NmFmZDhtcExValBB?=
 =?utf-8?B?UUM2b0JBWVlpRDZhSDRvWHE3UkFMVXpESVdoL0pVS3JKUmJlSXdNWkFLcGlt?=
 =?utf-8?B?c1lRbXJubTJOVjk1MzE5THI5VFNmZFRMSk1EZGp0OGgrNFBuaEU3WXlBY3Bt?=
 =?utf-8?B?NHFIT0tmM3hiL1o5VXpKbnNUVVZ5OXVVdW95RTU3MnBuNmxpWi9HdkxpQ1Bu?=
 =?utf-8?B?TEsxNzkxeEM3cWFuaC8yNDhTbFNXTXF4QjVHWGxLcm1zc0grNGN2S2pVbDVK?=
 =?utf-8?B?d0x5dTZ3TE9wa1RNQU5wL0oxdmE4RGNqd2FlbU1LdjYrK0N0KzF3TDl1bHdr?=
 =?utf-8?B?YmhWYkZWanNsVnVFV3RZbE0wUTNQQm1aeGwyc2w2VDQwNVJCb3l6dVhlQ3dV?=
 =?utf-8?B?TVVuOFZUeUlZTUZIWUsrYzhaYjNrYWZxYmdKRnhQOGZYYWo0VGVjZXdmai9u?=
 =?utf-8?B?clZ0TDhKaHNDNUI0SDJ4Ykd3dXFGNHRHalozMkh2NzJIaHJDKzd0SUcvRkdy?=
 =?utf-8?B?cmdONkhrUFl3YmFUUHJHNklESUFKMW5WenBDVHU4R2lwVFRYMVcrTkR0eW5T?=
 =?utf-8?B?eXB2M2tFbFJwY3Zmdjh5NmFsalM0Q09vaS9CcCsvdU5aQVA5bll3WEJ1cVpv?=
 =?utf-8?B?K09rWXRKSmdOZDNod1NXVytJUksxK2NwVXBqcjlJR1d1SlBoMEh4cW9IbTdN?=
 =?utf-8?B?WVhHdXN1cTNXdzJsNVEwTWJSeXByZ0NRa1dtWUpCQWg0L2h2K0dWWlVMeVdE?=
 =?utf-8?B?NVJ3RjRNUVNkaGZMU3BjNGpnaWpaN09DcHBUT3FrVzhTRUhGaEVsWkhHbnRI?=
 =?utf-8?B?MUR6TWR2VVlrcHF1aWliSGtDSjcybGlZV3lzUWtkSzkyRlpVZnloY2k0T2ZB?=
 =?utf-8?B?ZHExWU5EY1ArVmdmUTk3Tm9PZEhFTTcxcW9VeTIxWHhDWjF0VHNtVXZ4ekRE?=
 =?utf-8?B?dUhpMU5QaVB3N1R5SWo0cFZZbkZZaldDZmdQVU1Memh5UzZTM1F0SWYyMjdC?=
 =?utf-8?B?ZjJGWjFkRlc3RWd5RWFaYU9ucWRBQVFlWFJPSExISnp3ODkxemZtYXhKV0NT?=
 =?utf-8?B?TWU3M2wwNnlvQjRwZjVjdExYakxtS2c0UEwzbUliY01QZjZlS1REY09uN2sz?=
 =?utf-8?B?OS9ncW9JczRZRUNreXQvdFQ2T3M4SlZPTjJzK3I4L3pxVG5NQUNqekIyWXo2?=
 =?utf-8?B?QXhHSGlrUjRLK2ltbWtDdFA4bGFIb3NVUWZrbGVDTzQrWng1M0VIUyt0RXlX?=
 =?utf-8?Q?K/AD1zX+Nyi8Gx/IwVGgBigAaq4+0Sh+7k1xcmiGhaf4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHcyWm9LTWlGWGpOM3pjNGpnZTh0dlBkUXozS3NzdFl4RFFLenN2N09hMzlW?=
 =?utf-8?B?SFdNSlVNS1ZiWGhQNGJ0bkNvSDFCM0RXcWllbmhKeHc0Nm5PdVNXeG5uRE83?=
 =?utf-8?B?TTF4eVUvN1FMbUhBNDQvaEltUkRFYmt4UVVhM3hVNXZwUWtOTENsV1U4K2s3?=
 =?utf-8?B?cE1GeUo4K3lqdjJTTEpQWThMZDg0TXVZYThzR2x4NWlSRnlvYUFVQVRybnJi?=
 =?utf-8?B?dUNTTjJFemdScDR6K2U4WTNFUjBjUlFyYkFZbS9DSE5HVDhhb1YrWFJmK3lm?=
 =?utf-8?B?NWFQM1V5djlac1JleFUvS3g0cXFNUGwvbWdpaFVUaEZzQmRxSVIxVWlIdGhm?=
 =?utf-8?B?Mk1sTWdQbFZyaVA2Sy8vdTBRaUNVMG1xd0hyRjdGWHQ5a0xab25qRkNRNzdI?=
 =?utf-8?B?VmIwaXFPYUtZRlZ2THM1azJGaUlJRlZNT1UxTmtUVmVRWHVGNkVOeUdNNGQz?=
 =?utf-8?B?eHVRZ0ZZbVM0QnVnb1hYMDN1NUxwd29nS2tkNE9IT0Z4OHJkSmhzTURSSVZJ?=
 =?utf-8?B?bzlEbWM3SEdIUEkzTHFtTDVvZy9XY2RubldYemFLUGVNOVBjTXJ2MnJOaXF2?=
 =?utf-8?B?ZWFISExwdnR0VU5ONEF3MHVYbG95dHltenZmZTZTVVNYRHE5bHNKR0tsVjdD?=
 =?utf-8?B?TjU4c3BTSVRteFdaZEg4bkxsU3dOSDl6OFVLRURiL1Z3VEtheHZpOUUwbVg1?=
 =?utf-8?B?OWhucDFxWnUrMVJiSEhidGxydDNjeHRwUVNlQ1puUEFiRlNTTWdSbHBlYkpI?=
 =?utf-8?B?aU5qdUJPb1VEWXVLRndLYlFjMHV1dnhRNkRhdldRMEJxTW56VUtlaFJpVTF4?=
 =?utf-8?B?M2J0WEtZbGZsYVFGbVRmdElDQzNER3RsV2p4QTF1d1NwRkw3VndpS21COUlj?=
 =?utf-8?B?V1VackJGT0R4aktzK3FrVmZPUnFhUUl6SDZvaG1QVFdDcnV2a09rNVlreHVr?=
 =?utf-8?B?Y1pNQ2RqUW1mNmJWU3g0T2x2T1d1YitXYkNkZldPb3U2d3NZS0VNeTlMcFJ1?=
 =?utf-8?B?a3RFTVllTEZJVHZyWmh4Zk5YVjBlaUsrT2M2QmxNT09OR1RBOFpKa1JxK2lk?=
 =?utf-8?B?K2YvbHBUcEdOVklmRCtlcjdSNjdRdHZuRVpaNm1JdTcxQ2NWaS9WWWtxTWNz?=
 =?utf-8?B?MUlXNnlzWnhoT1dxMkpoMHhicFlyK1ltSHJHSml3R3Yxb2MxWUFjYm0rSERy?=
 =?utf-8?B?M3pFRjN2SXRKSzFJNDlFSnNLMGFiSGNSb1BJVmVCa3RtM0tEYXlPOGMrMmNh?=
 =?utf-8?B?SGJZRzFsSGVPNHlaWlVnSEZ3Y0xteE5pQWkvWVptZDcyMmw2ZWsxaGFHOFow?=
 =?utf-8?B?ZFM2OWl2U0UwQUtLUDg0UUMvMmdaNk9aQ0laZU9hSU84WEI5UFFiYWVIL2V1?=
 =?utf-8?B?M0UvenZJWkhON3NrMmxUendtZGZsOUhKVG92SUNQbzZkZHAxQVNST0MwRFY0?=
 =?utf-8?B?OURkQSsySW5BY1JWZlVzTndGRUFWbFFQREhGeGZVcTRNTjdtT0J1YnNHeVhT?=
 =?utf-8?B?T1hiMVprUzdGcVN4UzFRZnovSVc5cHcyaXNIS0pIcHVUUmJRKzhnSUhsUzBN?=
 =?utf-8?B?Rk5udzR6TllLYTJudE8rYnQyUmoyVCtEbUZKWUdGMVppdkwrMW54UCtMdzVS?=
 =?utf-8?B?VFFXNWk2N3JEbk9CNDBLdm90RGFUU2RUS3JzaTV4SVBPNTI4dG5JWnFyYS9P?=
 =?utf-8?B?Rmk5WXh3TmdXcjJSbk5oYlE3cGJTSDA4WVE0UU04VGFFNUorNm1lUW5JeXJM?=
 =?utf-8?B?ZTRGMHlQTHp6TnVMRXVnSXpXRE1TeE5kWm4rend6Qm5pT3dId0lEbDFpWTk4?=
 =?utf-8?B?T3lWejM4NVBHZTRMN2JDaGpZYlJCWWx5MkJ0dHZSTEtKWjk2ME45UnUveE9h?=
 =?utf-8?B?cFdZQjA1cEV6RTBDNUJLOUlwMkFMaXJ2ckFHbjRPTndUTU44TG8zSjBIelg2?=
 =?utf-8?B?NVBaQlJnSTlsbkcxQzhNRjZKZ2FVMEEzVnd3WERndGdxMElpUldSVk96YUlG?=
 =?utf-8?B?V1ZxbHcrVG50aCt3NTd3WmFZOG43Z0IwZ05CbXB6K2hOblNUSlhOeGpWVU9r?=
 =?utf-8?B?blFJOU0zbXoxYXZ0K3NPNmVIMjdWWjJocFg0cmMwRXUvSEEwVzMzYTlSd2NN?=
 =?utf-8?B?ZWRkNmtKZFZMYXUxK3R0a2oxNjRCRVdHT05MeUE5V1c5eWpQeHplQ0FGZlQ1?=
 =?utf-8?Q?b3o46MOrlUesHwF4OXXPp90=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L9sMlPgyeIOqKRTGWMxXrhTVaXTfLGBf36Jay7Qr/DquFFVXsHqquQuP9DwTJwh2tZfpIttNrmKIjoZeZCOURtV9ETrMTzds0dVC22SvIcPSnB9RyBWIIM5MRzdMnWB1fXvA/Qy6Qq49fYcZWlIax4IWGvU8O+5PZYvNYx0G6nF2+GexckWa3eiGr+n1fBmRiP7u3Tnxen1Os2Vj/2YSfr1p9oTuybtIiX0UahnptjROXMXqm6QR5ACGaQlpxx2LuUyBQo5SdZWiLIXB+EUVwG6nfgDn5dRlK4SKxR2E7SHUPhax/RAYuLjkfmXFh4khKMl3csUwOcchdho8fjAFhnhUamnKqThoWvFXN9w8ubiJ1MFjyWbjkR2WCo8QoP1mW7DH80Zaeh7jbWwEzXOg5JKQcCjAKgtx0N09AAT9o8gKyo8Af4pgDuAwfwURDlj1Q1KJESQllBnIUo7XNSlofKqN8Hzyo9gmuvHzsUE7qxnNt9ieFIzxIEI4Cez9jfAWd9BYNpAn8wAhk6fcU8vPuqY9wfHGLgpk1ItKnlPS5edUk+gOlq7JRTF86IXucH7MoyALSmWkrmvgfQas+PHL5fuCQ3Qzp9ErYsIQQUWv+i4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ed5e56-6960-4582-a211-08dc76686b78
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 11:56:43.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPGncVsob0+K/g2vPeE5SUfZIcCdNiwElCwo4U9jAGVtR3p4zULs7hSoEHA5vVhUWldTdV1c26yoClRiqT9lOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405170095
X-Proofpoint-GUID: ezui8GkfhU2NotHRb7At6nKS14ff6lHk
X-Proofpoint-ORIG-GUID: ezui8GkfhU2NotHRb7At6nKS14ff6lHk

On 17/05/2024 12:11, Arnaldo Carvalho de Melo wrote:
> On Fri, May 17, 2024, 7:23 AM Alan Maguire <alan.maguire@oracle.com
> <mailto:alan.maguire@oracle.com>> wrote:
> 
>     Split BPF Type Format (BTF) provides huge advantages in that kernel
>     modules only have to provide type information for types that they do not
>     share with the core kernel; for core kernel types, split BTF refers to
>     core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
>     uses that structure (or a pointer to it) simply needs to refer to the
>     core kernel type id, saving the need to define the structure and its
>     many
>     dependents.  This cuts down on duplication and makes BTF as compact
>     as possible.
> 
>     However, there is a downside.  This scheme requires the references from
>     split BTF to base BTF to be valid not just at encoding time, but at use
>     time (when the module is loaded).  Even a small change in kernel types
>     can perturb the type ids in core kernel BTF, and due to pahole's
>     parallel processing of compilation units, even an unchanged kernel can
>     have different type ids if BTF is re-generated.
> 
> 
> 
> I think it would be informative to mention the recently added
> "reproducible_build" feature, i.e. rephrase to "... if the
> reproducible_build isn't selected via --btf_features..." in the relevant
> documentation.
>

Yeah, sorry this part should have been updated after the
reproducible_build feature landed.

> - Arnaldo
> 
> Sent from smartphone, still on my way back home from LSF/MM+BPF
> 
>       So we have a robustness
>     problem for split BTF for cases where a module is not always compiled at
>     the same time as the kernel.  This problem is particularly acute for
>     distros which generally want module builders to be able to compile a
>     module for the lifetime of a Linux stable-based release, and have it
>     continue to be valid over the lifetime of that release, even as changes
>     in data structures (and hence BTF types) accrue.  Today it's not
>     possible to generate BTF for modules that works beyond the initial
>     kernel it is compiled against - kernel bugfixes etc invalidate the split
>     BTF references to vmlinux BTF, and BTF is no longer usable for the
>     module.
> 
>     The goal of this series is to provide options to provide additional
>     context for cases like this.  That context comes in the form of
>     distilled base BTF; it stands in for the base BTF, and contains
>     information about the types referenced from split BTF, but not their
>     full descriptions.  The modified split BTF will refer to type ids in
>     this .BTF.base section, and when the kernel loads such modules it
>     will use that .BTF.base to map references from split BTF to the
>     equivalent current vmlinux base BTF types.  Once this relocation
>     process has succeeded, the module BTF available in /sys/kernel/btf
>     will look exactly as if it was built with the current vmlinux;
>     references to base types will be fixed up etc.
> 
>     A module builder - using this series along with the pahole changes -
>     can then build a module with distilled base BTF via an out-of-tree
>     module build, i.e.
> 
>     make -C . M=path/2/module
> 
>     The module will have a .BTF section (the split BTF) and a
>     .BTF.base section.  The latter is small in size - distilled base
>     BTF does not need full struct/union/enum information for named
>     types for example.  For 2667 modules built with distilled base BTF,
>     the average size observed was 1556 bytes (stddev 1563).  The overall
>     size added to this 2667 modules was 5.3Mb.
> 
>     Note that for the in-tree modules, this approach is not needed as
>     split and base BTF in the case of in-tree modules are always built
>     and re-built together.
> 
>     The series first focuses on generating split BTF with distilled base
>     BTF, and provides btf__parse_opts() which allows specification
>     of the section name from which to read BTF data, since we now have
>     both .BTF and .BTF.base sections that can contain such data.
> 
>     Then we add support to resolve_btfids for generating the .BTF.ids
>     section with reference to the .BTF.base section - this ensures the
>     .BTF.ids match those used in the split/base BTF.
> 
>     Finally the series provides the mechanism for relocating split BTF with
>     a new base; the distilled base BTF is used to map the references to base
>     BTF in the split BTF to the new base.  For the kernel, this relocation
>     process happens at module load time, and we relocate split BTF
>     references to point at types in the current vmlinux BTF.  As part of
>     this, .BTF.ids references need to be mapped also.
> 
>     So concretely, what happens is
> 
>     - we generate split BTF in the .BTF section of a module that refers to
>       types in the .BTF.base section as base types; the latter are not full
>       type descriptions but provide information about the base type.  So
>       a STRUCT sk_buff would be represented as a FWD struct sk_buff in
>       distilled base BTF for example.
>     - when the module is loaded, the split BTF is relocated with vmlinux
>       BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk_buff
>       in vmlinux BTF and map all split BTF references to the distilled base
>       FWD sk_buff, replacing them with references to the vmlinux BTF
>       STRUCT sk_buff.
> 
>     Support is also added to bpftool to be able to display split BTF
>     relative to its .BTF.base section, and also to display the relocated
>     form via the "-R path_to_base_btf".
> 
>     A previous approach to this problem [1] utilized standalone BTF for such
>     cases - where the BTF is not defined relative to base BTF so there is no
>     relocation required.  The problem with that approach is that from
>     the verifier perspective, some types are special, and having a custom
>     representation of a core kernel type that did not necessarily match the
>     current representation is not tenable.  So the approach taken here was
>     to preserve the split BTF model while minimizing the representation of
>     the context needed to relocate split and current vmlinux BTF.
> 
>     To generate distilled .BTF.base sections the associated dwarves
>     patch (to be applied on the "next" branch there) is needed.
>     Without it, things will still work but modules will not be built
>     with a .BTF.base section.
> 
>     Changes since v3[3]:
> 
>     - distill now checks for duplicate-named struct/unions and records
>       them as a sized struct/union to help identify which of the
>       multiple base BTF structs/unions it refers to (Eduard, patch 1)
>     - added test support for multiple name handling (Eduard, patch 2)
>     - simplified the string mapping when updating split BTF to use
>       base BTF instead of distilled base.  Since the only string
>       references split BTF can make to base BTF are the names of
>       the base types, create a string map from distilled string
>       offset -> base BTF string offset and update string offsets
>       by visiting all strings in split BTF; this saves having to
>       do costly searches of base BTF (Eduard, patch 7,10)
>     - fixed bpftool manpage and indentation issues (Quentin, patch 11)
> 
>     Also explored Eduard's suggestion of doing an implicit fallback
>     to checking for .BTF.base section in btf__parse() when it is
>     called to get base BTF.  However while it is doable, it turned
>     out to be difficult operationally.  Since fallback is implicit
>     we do not know the source of the BTF - was it from .BTF or
>     .BTF.base? In bpftool, we want to try first standalone BTF,
>     then split, then split with distilled base.  Having a way
>     to explicitly request .BTF.base via btf__parse_opts() fits
>     that model better.
> 
>     Changes since v2[4]:
> 
>     - submitted patch to use --btf_features in Makefile.btf for pahole
>       v1.26 and later separately (Andrii).  That has landed in bpf-next
>       now.
>     - distilled base now encodes ENUM64 as fwd ENUM (size 8), eliminating
>       the need for support for ENUM64 in btf__add_fwd (patch 1, Andrii)
>     - moved to distilling only named types, augmenting split BTF with
>       associated reference types; this simplifies greatly the distilled
>       base BTF and the mapping operation between distilled and base
>       BTF when relocating (most of the series changes, Andrii)
>     - relocation now iterates over base BTF, looking for matches based
>       on name in distilled BTF.  Distilled BTF is pre-sorted by name
>       (Andrii, patch 8)
>     - removed most redundant compabitiliby checks aside from struct
>       size for base types/embedded structs and kind compatibility
>       (since we only match on name) (Andrii, patch 8)
>     - btf__parse_opts() now replaces btf_parse() internally in libbpf
>       (Eduard, patch 3)
> 
>     Changes since RFC [5]:
> 
>     - updated terminology; we replace clunky "base reference" BTF with
>       distilling base BTF into a .BTF.base section. Similarly BTF
>       reconcilation becomes BTF relocation (Andrii, most patches)
>     - add distilled base BTF by default for out-of-tree modules
>       (Alexei, patch 8)
>     - distill algorithm updated to record size of embedded struct/union
>       by recording it as a 0-vlen STRUCT/UNION with size preserved
>       (Andrii, patch 2)
>     - verify size match on relocation for such STRUCT/UNIONs (Andrii,
>       patch 9)
>     - with embedded STRUCT/UNION recording size, we can have bpftool
>       dump a header representation using .BTF.base + .BTF sections
>       rather than special-casing and refusing to use "format c" for
>       that case (patch 5)
>     - match enum with enum64 and vice versa (Andrii, patch 9)
>     - ensure that resolve_btfids works with BTF without .BTF.base
>       section (patch 7)
>     - update tests to cover embedded types, arrays and function
>       prototypes (patches 3, 12)
> 
>     [1]
>     https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire@oracle.com/ <https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire@oracle.com/>
>     [2]
>     https://lore.kernel.org/bpf/20240501175035.2476830-1-alan.maguire@oracle.com/ <https://lore.kernel.org/bpf/20240501175035.2476830-1-alan.maguire@oracle.com/>
>     [3]
>     https://lore.kernel.org/bpf/20240510103052.850012-1-alan.maguire@oracle.com/ <https://lore.kernel.org/bpf/20240510103052.850012-1-alan.maguire@oracle.com/>
>     [4]
>     https://lore.kernel.org/bpf/20240424154806.3417662-1-alan.maguire@oracle.com/ <https://lore.kernel.org/bpf/20240424154806.3417662-1-alan.maguire@oracle.com/>
>     [5]
>     https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@oracle.com/ <https://lore.kernel.org/bpf/20240322102455.98558-1-alan.maguire@oracle.com/>
> 
>     Alan Maguire (11):
>       libbpf: add btf__distill_base() creating split BTF with distilled base
>         BTF
>       selftests/bpf: test distilled base, split BTF generation
>       libbpf: add btf__parse_opts() API for flexible BTF parsing
>       bpftool: support displaying raw split BTF using base BTF section as
>         base
>       resolve_btfids: use .BTF.base ELF section as base BTF if -B option is
>         used
>       kbuild, bpf: add module-specific pahole/resolve_btfids flags for
>         distilled base BTF
>       libbpf: split BTF relocation
>       selftests/bpf: extend distilled BTF tests to cover BTF relocation
>       module, bpf: store BTF base pointer in struct module
>       libbpf,bpf: share BTF relocate-related code with kernel
>       bpftool: support displaying relocated-with-base split BTF
> 
>      include/linux/btf.h                           |  45 ++
>      include/linux/module.h                        |   2 +
>      kernel/bpf/Makefile                           |   8 +
>      kernel/bpf/btf.c                              | 166 +++--
>      kernel/module/main.c                          |   5 +-
>      scripts/Makefile.btf                          |   7 +
>      scripts/Makefile.modfinal                     |   4 +-
>      .../bpf/bpftool/Documentation/bpftool-btf.rst |  15 +-
>      tools/bpf/bpftool/bash-completion/bpftool     |   7 +-
>      tools/bpf/bpftool/btf.c                       |  19 +-
>      tools/bpf/bpftool/main.c                      |  14 +-
>      tools/bpf/bpftool/main.h                      |   2 +
>      tools/bpf/resolve_btfids/main.c               |  28 +-
>      tools/lib/bpf/Build                           |   2 +-
>      tools/lib/bpf/btf.c                           | 605 +++++++++++++-----
>      tools/lib/bpf/btf.h                           |  59 ++
>      tools/lib/bpf/btf_common.c                    | 143 +++++
>      tools/lib/bpf/btf_relocate.c                  | 341 ++++++++++
>      tools/lib/bpf/libbpf.map                      |   3 +
>      tools/lib/bpf/libbpf_internal.h               |   3 +
>      .../selftests/bpf/prog_tests/btf_distill.c    | 346 ++++++++++
>      21 files changed, 1612 insertions(+), 212 deletions(-)
>      create mode 100644 tools/lib/bpf/btf_common.c
>      create mode 100644 tools/lib/bpf/btf_relocate.c
>      create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c
> 
>     -- 
>     2.31.1
> 
> 

