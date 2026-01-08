Return-Path: <bpf+bounces-78243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A18E7D05722
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D9C93035A80
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715ED30FC32;
	Thu,  8 Jan 2026 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NA5UXynL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d5XwgHA3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85B30F921;
	Thu,  8 Jan 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896335; cv=fail; b=IWBeVTyNOn1B4pu/mMzwA8fSSaswE5ruXkf4tZmsIJ85u2dqarPA82sHIhE2rszwqJIeYdAtn+jRn3qK5Y4Uv/thFjQdfuFJKNXqhB6fayU+OJTQWXoTZdo2rNpzl/FCYanYmfN3aaNlsqJUVNViapeJVl4S4HFmTxd6IpLPrSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896335; c=relaxed/simple;
	bh=i2fhqxCgZX2aA/6Wz+QjjikZpClCpeBpt9jmfJyXdIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LB7EMxs9ZV5iZBgHmVXVnHWbTb7F1H41ESw/CKYtKGbMf+a1OWpasAVaTU4uI9BjsjLblwE+HwdesmVZLiLQQvL3kRTRbwiWlwjJvTaGqubZ4ZWb4FZrbIyjKkezkjy+QTDU8OOeX9E4T66fTwmwUQhaahcN6eZmbjsACnV4Vpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NA5UXynL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d5XwgHA3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608FnHa8424970;
	Thu, 8 Jan 2026 18:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ub3RKgI8h4dhqLgX8sLc0Ugv1rVt6SW+ERNa+o5pYfg=; b=
	NA5UXynLTkfM/nsgbmRNsSzBXIv3nBdEhcx7oS0ffIND8F3k7ogLpFQt9jlg8Wgi
	DGfR1qoRvXOq1eLj/wml7qmPS2uaLxQI5MZ+t3Vis7dEyy02wvoW5cVj+2Ki2LLZ
	xqJ/oWhRbJtZU+6EPOYGQxWIQe/n/m7RlXKZBTPZIXvPS02ax02gqDgwzYUJsxS+
	ik1PJGF7MgppybV7K/KMQILaZ1P6MLyejc8rRYKe+KuV3lKiPgcpfJgN65MICKVg
	cpgy8lwLW3EkGSEnqFRdjdP6C2Mzp3KEVQZbEm5jP+4FL4vKim2F4rjVbA1oUwVz
	90WmBPLYC9IoIF3md3Evjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjfjd87t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 18:18:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608HNZxf030767;
	Thu, 8 Jan 2026 18:18:27 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjfegce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 18:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+8GJYGM95Yp/mEtZQLFJ04tRER6wPT5u8bn7QPfgeIqpXrH8ltgp88IRWDpW6gM78FDX6KmnkY9uOy2lDEfpI2ib4+4wf3jUiUDGQVm0eGwdSpTaSuM1xIg4pLFcf/moBK4+BMSo+BLwBeIvOaXbMnUkztGJ0S7QoZsrYR2G/9dLO/lx08YVlzTPkOv3Y5O3CWo0uyNCE2oj2Ww9LbzdZfg6NW3b30swIMuDP8e1ZNYTTyrXY2xpvKE7ZfPgZomJBut/LCBw3vmcWiO8HF7Q8Lwcs6+HM6qG1VK3h0OyIquLzBIoP0jZnp/9oxwN92LbY7q2NOIsa85L/87ECTR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub3RKgI8h4dhqLgX8sLc0Ugv1rVt6SW+ERNa+o5pYfg=;
 b=fXt/vVu1auJaU2VapIOmYLxmoprNYBPC4DWE+R5qN/uyhGpoz+10YXrDf1N2i2gTxLCU505sIUkyB+zwHSA1bQaBoB/Ja/JgMMhR2WxBTpLg0SfzaCmxRqOIUv4N25Pz0omXLN5hMQqU5B5F7Ej/QP6QVcSlFW170XwYM6SnCHSFBGLNdWhxinNx0CnZO6kTxHJVL+eJlHbdtbfPiWdy29eAMkc4LpKgPzP4zx/NB5+fCJSFSEBQONLJ090quXV+xBBol0rvXBTiaqRk4C/GHIAKzeO+4YiKQNyj7jaAqGSUBmkA8Bi7LFWfrJkFGdl5vDON/WZjzW8+Ae3uoYMUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub3RKgI8h4dhqLgX8sLc0Ugv1rVt6SW+ERNa+o5pYfg=;
 b=d5XwgHA3pj5acSR44rv8LZvlZWR1HnzuAgS8YRXGlPMPPdGMdQgS+7mybaZu3kbcVKYSp5U4EhMPGM8J0zwRHemPpq7jibc7crIU/5L+gbPgAWYMtH/tKhxRBrD/KTqMPhSRA2XBXfAWZF4wZ2Y5+0RHLO2ZA9QX54c1uW6o+kk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB5696.namprd10.prod.outlook.com (2603:10b6:a03:3ef::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 18:18:20 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 18:18:19 +0000
Message-ID: <a25bddfb-4b43-47ab-a23c-03db99279435@oracle.com>
Date: Thu, 8 Jan 2026 18:18:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: prefer strong function definitions
 for BTF generation
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com> <aVuk1e73g7ZTHqMY@google.com>
 <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>
 <aVwihhKEszvcyNKo@google.com>
 <ace92738-a52a-4248-b7d8-bcfce6f9af22@oracle.com>
 <aV6sNbs3vwCoGk49@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aV6sNbs3vwCoGk49@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: dabbae42-d3cb-43f2-23c1-08de4ee24d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUFGbjdIb3NiMDkwNHFVbDVjeGVXY2hTVlZlWm1DU0lvNTdFaXlBSHovKzRE?=
 =?utf-8?B?ZW84a09QOTNYaG9JaEpLZmwxRVorZmhhVFdPZkpwL3ZwOWIwSWV5WmxrN0hW?=
 =?utf-8?B?UXJIK0s4V2NSRWxSRWhocEJGS05zeVgvSGJNK285ZFJyS1IyOHdlU1J3dlpj?=
 =?utf-8?B?dXIyOUF4MkRLNFFxR05ZVUVqKzRDSU5NRnZwbDZCNHhiRnVzWVU3bkwwbDJq?=
 =?utf-8?B?OWJMdVh3dk5WODNTS3IvalhyOFJqQW41ejA0bTZEeGhKdEdYTjVKTmZLMVVh?=
 =?utf-8?B?VzNTeVR6YVE2dSt5a3k2OHUxYUx2SThkT29OL3pKeFBxd1c0N3QrZCs3NHZU?=
 =?utf-8?B?NDZHWm1YR1U3VS83ZGJOYWdYdVBDMHJzV2dzWEt5Y1BFY2xjeENMR0RrVjZS?=
 =?utf-8?B?NWZDM3BWcjQxa3cyQ01mSW1Cajc4dmk5RlRaK25XZkduNHdmVm5YZnZIR0w3?=
 =?utf-8?B?MXRQMG9aNHB1SE5FZUc1MnlQZmUrck1Qc0Y3anNXZm4rTmMzRmpGejlFVjgz?=
 =?utf-8?B?Ni9lcFJUeTVIQit0cDJ5ZjVFZFlWOVRDOEdmbENiNkc1RDNnZ2JsMS9udDln?=
 =?utf-8?B?dCtnS0l1dGpUZW80c0p1a0R2VHhXTzVzZjlHejh4cStpK20ycFRGci82TnNX?=
 =?utf-8?B?VWhMNkg0QUZ4MkVoenkzOWRMNFlSdkFBMUxBdEpSc2xVcjJXZEp1aWNOckhj?=
 =?utf-8?B?VG43S2FYSzIxN3VQanVIN200SUhxeFBTeFdNa3V3Y2JxYmdSUk8xejlmKy9v?=
 =?utf-8?B?NlpNWjZsWktoMHEyWTdPcWx4T1o4elZoYSs2bzNSVGsvQnFKSHFyTFVWQ2dE?=
 =?utf-8?B?dTBqNEhISkFqRXpDOENxQ1ZseFNCYlJ4SWxrdGdOay9LVVNramlwRDVVdS9a?=
 =?utf-8?B?bjJ6RGNKamp0UVptWGxrTFBYd1BSZFZjWVZmUXJYMVJ6ckgxOEl1TXZqVzdC?=
 =?utf-8?B?cWFXbmRSdU1QZERyWUpFdXNxbkxMVHZtd2hTSzB3UFFYYVgxMDF1My9oTWhE?=
 =?utf-8?B?SHE1K3FjcDVPQkJLSU9wV0RaaXRjU0d3SzlJWmhuTUxOMXNSNzJlTHdac0g0?=
 =?utf-8?B?K3MrczhQS2lOcVdRdDNHV29EdzdMaHJ3R3V5OCtBdkcxdy9VaFVBaFVDanRX?=
 =?utf-8?B?Y3lqbGZGSFRrU1dEQThRKzJYT04wL01FZFUwSUE0TmpCckxRM2xWOUpUc1BK?=
 =?utf-8?B?YU9nVktWdzV3MUNLY2VKcVJFWG5jWS9mYnBYRjBRS3hwWGtnRW52SXFYTlpr?=
 =?utf-8?B?NzBHM1EzZjlUY0FtS0NuUjFwcldVclAxYlJ5aWhyNkpEN1FGZnN2TVZ3YW4r?=
 =?utf-8?B?NnN4VUp1ckZkVXU4NjlIZHAzZDBrNFhNUGRKRjFDR3M2ZFNyb0pSU0I4RzBZ?=
 =?utf-8?B?UzhmNGVOaEhkcGY4VHdmK0JlNFl2dGdtNHp1bU1ldmxIcThaSW1NRTVwM3VR?=
 =?utf-8?B?blVXRXlmNlo2eHRJUHVWQW1HWC9KVTJkMExTY1JsYzJFc0VxOWlqUHRuN3Ni?=
 =?utf-8?B?cUo3QjZIZ2Q1SlM0WTE2TE9oV2dmS2kxMGtoL294Q3VsbHhPY1hNUmFyTmVh?=
 =?utf-8?B?WWdFZ085NlZMQ0ZvTllLNkdlV1VTY1RRS0JGTlQyOHJIZVJCQmQ0ZTdTSHRv?=
 =?utf-8?B?RlJJRVp2M1FaaUpoL2JTc1pPc1lGM0RJMHlSeVNNdSs2blJZWk9qd1ZLc0dF?=
 =?utf-8?B?V3ZDQ0hpODkweUU4R1J4L2hXMXBWdHlWU1BoaXZ2NnA1cnI1a3J6aU85c2Zk?=
 =?utf-8?B?aXpwd2xaaWl1OG8ybXZQNGFFYi9lcU5oV0pMQk11NGZYSFJiVk9aYlRUV2pl?=
 =?utf-8?B?bUM3b2ZmMXBvMmF6c3czRzJQRmdIdWpRYjdXZlUwWi9acm0vUmkyU2JDVWJr?=
 =?utf-8?B?ZU1CRW1ZZ3pBZklGRkxzUUFJMVZRT0lxR0pOeXFzN1krUzF1a0FESGZaQ200?=
 =?utf-8?B?OFBCOHB5ZVFJRXpmcDFJVUR1ZEtIaVJEMVQ4WFVkNDZzNnZLY1RuR3dlVVlw?=
 =?utf-8?B?ajViM1BEM3p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUFFUTVESWFpWGpEOTJmMHNMUkliaTcrblZMZzh0Z0s5K0JEYWNpRjlLd1cz?=
 =?utf-8?B?dTY1dEMxcGdYLzdnNDZXTUJ5WVZuY1BHUFluUjhHdk51OHpvNGlmYVNrdE1C?=
 =?utf-8?B?ZGFnaC9JT1k2aUUzMEl5RnBiN3k4clhKU1dUaW01VFY4ZER2STJvMDdWWjYx?=
 =?utf-8?B?STJwV0RKRnErN0xiSHhBVEhwNWYzYThyNklBNkVZL2dqKzRueVdwRm1Dc3or?=
 =?utf-8?B?TEdjbUUwSUJhUSsyb0RYNVl4SExRZ0ZCVXdBeHVYVG1uNlpwd2syT3FUTlF3?=
 =?utf-8?B?cTlGN3F1UXlYK1FDZXJIc1BKS1BIM0xrOEVLM2Vxa2o3QTJiZFJmS3VIQ2Z2?=
 =?utf-8?B?bkVncDJOVnlua01SME5GUFVodjc4d0F1VUVZK2l5UHZtUmQwZk8rM3RMbTRW?=
 =?utf-8?B?cU5TV1V5aGxsajBxSjVIT21GNjcxNm1ucFRwZkxoQ0wyNm4zTUxxOGNKUXpZ?=
 =?utf-8?B?Y0ppcjU3ZHZQajdYNlE5TEhNR0REMjlrM0Nsd2hHaExuWEN5MzZvaVY4aGFl?=
 =?utf-8?B?YkdDNUQrZUVXYlUvTWZDOGplYW5EanBjLzlPVm5ETElTcXBOMi9qeXkza2x0?=
 =?utf-8?B?UDlYbUZjU0pDZ3VMUmxkSGRoZml0UDJUY0xjSVNucWppWHFRSFV0dWJwWGpD?=
 =?utf-8?B?NUdIcFJlUFA5TGFGSE02VkF1VTZXZEtKSmxUZmVqMFoxUnNvS2EyZ1ZHQko5?=
 =?utf-8?B?OHBZQXVGOUxTdGVOTFhxeGw3QW1PRUJqa0E1NUQzSTMzWS83bStGQ2dlQkZ2?=
 =?utf-8?B?MEZ4NEhTVkE5Tnl3K1dWU1J0YzA5cnFGTWl3eG00SkJ3TktQWUpMNkY2L2Qx?=
 =?utf-8?B?RnhlUy9ON1p2VDVaY1JTcnZLWUN4L2ZnS2dRZWNES3BaTFFPdTRvK1lDTy9P?=
 =?utf-8?B?NjRzVkJNN0Q3MmRlSGNoVXYzVGdVbjhRRkZFVm5YQ09pczlkNjM0NTRPM3Q2?=
 =?utf-8?B?VzRBREdGeDVnNHBIWmFGcVg4NEdWZXhsaFFpNUpIRTgrem9qM3ZXUmdLUS9D?=
 =?utf-8?B?MVNxcFRBa1JWNkNRQTMyZmoyK2VqUk8wVS9HUTh1YTFyUE9wSnA5NVhSQTFo?=
 =?utf-8?B?VG45NkhTbU9mQmRZbzB1YktTbkdpRU9Pd2xhUGpGOXR4bDZCemoxWG5ENkx6?=
 =?utf-8?B?Y3ZvMzdLRnlKcjU2ZitSeFBYS1pZQnkrSVYrbzIrazhqeExJRlBBVTc5SVZM?=
 =?utf-8?B?TkkwenNrWjFWL01QYnhUYkUyMmtsbEY2SGl5eVhjS3UwVURWZjM2Ui9MTGJl?=
 =?utf-8?B?NzlSdFJHTU5OVHZNY0Y3eUJLN1ZqbmxNeDdVRm1Ia0lrMkV2Y2kwZnpZUEJF?=
 =?utf-8?B?bzhKZk5TeThJOGlxNmkrakF0YUJMcnRiU1pKd0djS1ZUeU1YOTN2Nk9ERUVo?=
 =?utf-8?B?TC9PTTVuNGZUYTJuMjN5bVhUdk50WVBTK1hadVo1b2EySFFkMXZFNzhCN2Vx?=
 =?utf-8?B?bG5XWlZrMlJObUNkcnVyaEU0d0hlemloSVhQc0JnT1NMZGVFVy9tRVE3REVk?=
 =?utf-8?B?M0VGZWk1S1QwNS8zcUJTTjByKzJUMWlyTktGVUpiMmZPbXZ6SGNjYUZYWnpz?=
 =?utf-8?B?d2F3NDJicEExRTQwbjUxWkx5YzZLU0ZBKytZd3pPRTN1Skc3T3c1enlCaEJW?=
 =?utf-8?B?dWFubzJUQ1V5VzJZbTl4NlpGd2dFVDJPRE10RzIxTmhsK2FuY2RsOWpOajB4?=
 =?utf-8?B?cFVFUEV1bHJCVHF5dGRPYlNuZHovNGNpOFVObXZzMjcyemVOVTBzcEtidGlz?=
 =?utf-8?B?UlZRMnd2THlRZnhVeTNuUWFqQ25tN0EvL0dLTFRPaUFpSFBQNlNtMnJyL2Vh?=
 =?utf-8?B?NFIvQXBocEtLQm9IMHRSU2Y0NDJrcWUraUpQOG42ZWVTTmdybjRRYWU5L1Nl?=
 =?utf-8?B?OG9IRmtROUlZcnNUWjk5b2NRTHVqd3Q2czJ6N21QWi8zYUN2eHJvZ1pwOTJI?=
 =?utf-8?B?eHgrUStjL1FxWHFKdXUzRFUxd3dIajNhQUFLRUxUb25RclRaNHplTEl4U1VT?=
 =?utf-8?B?SnhrSWFMTGVMR0dYOWd6bEhCTjF6eUQ2alNmanUxTzU5UDk1TEtXZ3ZjT1lx?=
 =?utf-8?B?aU9BbGZKUnh6Y2VwODdVRTBHYlgydXRBV3BLVWFHV040dVpKYVo0Ulc5NkEr?=
 =?utf-8?B?b2ZBOEtQR2xMMmpkaEdpOXE5OE9nSGxTajlJK3NIZkwzU1ovTWFIY09kd1lI?=
 =?utf-8?B?ZW9OQWFVc21lY2NVN1BtbTdYcjZiVStKMDVNaG9JeGo5WGo0Vk5qQUticG5X?=
 =?utf-8?B?ck13SS9Cd0h2WTEzTnRMMFc0YkoyZW55UWNhbHFnVGVkQlRMY0RWd01IODl1?=
 =?utf-8?B?WFBQTlBuenR5L0c5TUlVa3BnbktrRjJZbkQvdWs4RlRPUW92ajVsUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cKNkywVpoN4SxYyiKCZhSYGayhErUMqQybYyKTrcNTPkAO5OQ3RnwsUQJ+RtyaiWKBTyYAbwexckjJzbvd0aBAYvA4NgVKqjxpfT0WEb+bS6lEU8Z1WIg0Cwv3q7M/qKg/OldIlIhrgrXqFzCZQp8VqzJJnF6YWNWgGXFCnA6EyyrOOc92pRyfsryGRe4U0vmNeqhqzY6j5wG6cBhuV2tw0vUangEnU1wAQw9p8DHnP3LmW+d/bLkjU5fXnOKTMEInVhjIjzngaHKVzMG6BYxg6aQzEzntx4R8LXhytWCO/QAIx8isqxUZgLtlacQIn7bmLHxzo/m/6JI/f0gTjWLCch8GJ80Yw74Giiploam0Qz63576uE55vXFcci4vuP4MB9UfE0MUK84adWP0+mOYzgyRSIW6pGOX5CQjrjAXtaBHdPQA01Y24EIhll8fVLfDoGabIAgV1skq5wXJBWXwykABG3gx1wq1XP0u43mvvBAJPX/u5jOUdpj5McS/aQVV1IqaMdzmdBUgUXxx9T/VxEXGxPl43iPpMES852Cwaf0YpTZOAPQuW79kr+XKxd14YmHfB4MW8+IsZvZr00oeMvXM143AyayYV1GXOid2uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabbae42-d3cb-43f2-23c1-08de4ee24d1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 18:18:19.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVQAluM/4FcbnzU4Pqs3BqtleQBajJwByrH5D6BrssCrhi5T7dT0rHnoBpQHtJjWEYN6vv2GvXMEmcxepTL3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080136
X-Proofpoint-ORIG-GUID: 8QRg-tNX2EGlWASqL4c0aPtSoJHz1665
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDEzNSBTYWx0ZWRfXxmbgxNBbAt4M
 7eHsgyQboJ0fY1BUB672V8nErfl3NwnvhS1YqVes0Z1618hxcdZFBBeq2r7S15EvV9oLd1AQmBI
 GczQcpGnllkb1vIB5eeHuAK/dZQk62hYZALM/hCIUg+0gpqZL3sfmHCOGWw/cWHtbyvIjeMQ5Fw
 VJy81dDEAU7w6b0IG/zrLdEl1Lv1KM2ClLcjYzfm1AGqn84ZyOmbEk51jc9lS2FiG1fibXC70vb
 seOL6PD7RXbVICG0tvwuuvSmx9ly7pJbJm41MQx4Fdwi15DdtyZyCzLk71Hv9RAutnsDEMk9agt
 uuKzBtML72aIV+w8ZPfxPhyASTIIukAryzRwNV4hV8iHxCcDHJEkGBSZyv512TTtdYMiMvN4W4H
 6VLso/vyS1+3pfTMalwcC8XXTQp3CmcciEeLmpdCATevpZHptUXY8/JzraVXIPpUC/N7NlQwBw0
 i4dS57jbA76Jq58ckpPU9jEitDCBqF0Jq3ZxJt7I=
X-Authority-Analysis: v=2.4 cv=MOJtWcZl c=1 sm=1 tr=0 ts=695ff4f4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8 a=Mp1grWxiFYy-YdmhCNAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-GUID: 8QRg-tNX2EGlWASqL4c0aPtSoJHz1665

On 07/01/2026 18:55, Matt Bobrowski wrote:
> On Wed, Jan 07, 2026 at 03:50:40PM +0000, Alan Maguire wrote:
>> On 05/01/2026 20:43, Matt Bobrowski wrote:
>>> On Mon, Jan 05, 2026 at 08:23:29AM -0800, Yonghong Song wrote:
>>>>
>>>>
>>>> On 1/5/26 3:47 AM, Matt Bobrowski wrote:
>>>>> On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
>>>>>> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
>>>>>>>
>>>>>>> On 12/31/25 12:53 AM, Matt Bobrowski wrote:
>>>>>>>> Currently, when a function has both a weak and a strong definition
>>>>>>>> across different compilation units (CUs), the BTF encoder arbitrarily
>>>>>>>> selects one to generate the BTF entry. This selection fundamentally is
>>>>>>>> dependent on the order in which pahole processes the CUs.
>>>>>>>>
>>>>>>>> This indifference often leads to a mismatch where the generated BTF
>>>>>>>> reflects the weak definition's prototype, even though the linker
>>>>>>>> selected the strong definition for the final vmlinux binary.
>>>>>>>>
>>>>>>>> A notable example described in [0] involving function
>>>>>>>> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
>>>>>>>> distinguished only by parameter names (e.g., file vs
>>>>>>>> file__nullable). While the strong definition is linked into the
>>>>>>>> vmlinux object, the generated BTF contained the prototype for the weak
>>>>>>>> definition. This causes issues for BPF verifier (e.g., __nullable
>>>>>>>> annotation semantics), or tools relying on accurate type information.
>>>>>>>>
>>>>>>>> To fix this, ensure the BTF encoder selects the function definition
>>>>>>>> corresponding to the actual code linked into the binary. This is
>>>>>>>> achieved by comparing the DWARF function address (DW_AT_low_pc) with
>>>>>>>> the ELF symbol address (st_value). Only the DWARF entry for the strong
>>>>>>>> definition will match the final resolved ELF symbol address.
>>>>>>>>
>>>>>>>> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>>>>>>>>
>>>>>>>> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>>>>>>>> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
>>>>>>> LGTM with some nits below.
>>>>>> Thanks for the review.
>>>>>>
>>>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>>>>
>>>>>>>> ---
>>>>>>>>    btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>>>    1 file changed, 36 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>>>>>> index b37ee7f..0462094 100644
>>>>>>>> --- a/btf_encoder.c
>>>>>>>> +++ b/btf_encoder.c
>>>>>>>> @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
>>>>>>>>    /* state used to do later encoding of saved functions */
>>>>>>>>    struct btf_encoder_func_state {
>>>>>>>> +	uint64_t addr;
>>>>>>>>    	struct elf_function *elf;
>>>>>>>>    	uint32_t type_id_off;
>>>>>>>>    	uint16_t nr_parms;
>>>>>>>> @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>>>>>>>    	if (!state)
>>>>>>>>    		return -ENOMEM;
>>>>>>>> +	state->addr = function__addr(fn);
>>>>>>>>    	state->elf = func;
>>>>>>>>    	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>>>>>>>>    	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>>>>>>>> @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
>>>>>>>>    	encoder->func_states.cap = 0;
>>>>>>>>    }
>>>>>>>> +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
>>>>>>>> +									  int combined_cnt)
>>>>>>>> +{
>>>>>>>> +	int i, j;
>>>>>>>> +
>>>>>>>> +	/*
>>>>>>>> +	 * The same elf_function is shared amongst combined functions,
>>>>>>>> +	 * as per saved_functions_combine().
>>>>>>>> +	 */
>>>>>>>> +	struct elf_function *elf = combined_states[0].elf;
>>>>>>> The logic is okay. But can we limit elf->sym_cnt to be 1 here?
>>>>>>> This will match the case where two functions (weak and strong)
>>>>>>> co-exist in compiler and eventually only strong/global function
>>>>>>> will survive.
>>>>>> In fact, checking again I believe that the loop is redundant because
>>>>>> elf_function__has_ambiguous_address() ensures that if we reach this
>>>>>> point, all symbols for the function share the same address. Therefore,
>>>>>> checking the first symbol (elf->syms[0]) should be sufficient and
>>>>>> equivalent to checking all of them.
>>>>>>
>>>>>> Will send through a v2 with this amendment.
>>>>> Hm, actually, no. I don't think the addresses stored within
>>>>> elf->syms[#].addr should all be assumed to be the same at the point
>>>>> which the new btf_encoder__select_canonical_state() function is called
>>>>> (due to things like skip_encoding_inconsistent_proto possibly taking
>>>>> effect). Therefore, I think it's best that we leave things as is and
>>>>> exhaustively iterate through all elf->syms? I don't believe there's
>>>>> any adverse effects in doing it this way anyway?
>>>>
>>>> No. Your code is correct. For elf->sym_cnt, it covers both sym_cnt
>>>> is 1 or more than 1. My previous suggestion is to single out the
>>>> sym_cnt = 1 case since it is what you try to fix.
>>>>
>>>> I am okay with the current implementation since it is correct.
>>>> Maybe Alan and Arnaldo have additional comments about the code.
>>>
>>> Sure, sounds good. I think leaving it as is probably our best bet at
>>> this point.
>>>
>>
>> hi Matt, I ran the change through github CI and there is some differences in
>> the set of generated functions from vmlinux (see the "Compare functions generated"
>> step):
>>
>> https://github.com/alan-maguire/dwarves/actions/runs/20786255742/job/59698755550
>>
>> Specifically we see changes in some function signatures like this:
>>
>> < int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int type, int flags);
>> ---
>>> int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags, int type);
>>
>> Note the reordering of the last two parameters. The "<" line matches the source code, and the
>> ">" line is what we get from pahole with your change. We've seen this before and the reason is 
>> that we're not paying close enough attention to cases where the actual function omits parameters
>> due to optimization; that last "type" parameter doesn't have a DW_AT_location and that indicates 
>> it's been optimized out. We should really get in this case is:
>>
>> int neightbl_fill_info.constprop.0(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags);
>>
>> So it's not that your change causes this exactly; it's that paradoxically because
>> your change does a better job of selecting the real function signature in the CU
>> (and then we go on to misrepresent it) the problem is more glaringly exposed.
>>
>> The good news is I think I have a workable fix for this problem; what I'd propose is - 
>> presuming it works - we land it prior to your change. Once I've tested that out a bit
>> I'll follow up. Thanks!
> 
> Ha, interesting! Curious, should the .constprop.0 based functions also
> not be emitted within the generated BTF given that they too
> technically would exist in the .text section and can be called?

Yep, but the original policy - that we are changing - was to avoid encoding
anything that violated source-level expectations. So if a .constprop
function omitted a parameter it was left out of BTF encoding. But annoyingly
we often weren't detecting that correctly, so we would up with function signatures
that had out-of-order parameters which should have been recognized as having
missng parameters (and thus omitted). We're moving towards the concept of "true" 
function signatures where we emit a possibly changed function with its "." suffix
name; see Yonghong's presentation at Linux Plumbers for more details.

I've put together a series that weaves together better detection of
misordered/missing parameters, optional support for emitting true function 
signatures for optimized functions and finally your patch. With the prerequisite
patches in place, your patch (which needed some merging but is essentially the
same) no longer emits signatures with different ordered parameters; we better
detect such cases. See [1]; changes are in branch in [2].

Most of the detected function signature changes are syscalls which have
the pt_regs "regs" name rather than "__unused"; but in this case:

< int pcibios_enable_device(struct pci_dev * dev, int bars);
< void pcibios_fixup_bus(struct pci_bus * bus);
---
> int pcibios_enable_device(struct pci_dev * dev, int mask);
> void pcibios_fixup_bus(struct pci_bus * b);

the signatures match the strong rather than weak declarations:

strong: 

 int pcibios_enable_device(struct pci_dev *dev, int mask);
 void pcibios_fixup_bus(struct pci_bus *b);

weak:

  int __weak pcibios_enable_device(struct pci_dev *dev, int bars);
  void __weak pcibios_fixup_bus(struct pci_bus *bus);


so that's what we want.

I need to do a bit more testing but it seems like this gets the behaviour
you want without the side-effects due to existing brokenness in pahole.
Let me know what you think. Thanks!

Alan


[1] https://github.com/alan-maguire/dwarves/actions/runs/20813525302/job/59783355126
[2] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:refs/heads/pahole-next-true-sig-gcc


> Apologies if I'm not understanding something correctly here, but my
> current understanding is that non-.constprop.0 and .constprop.0
> variants share differing addresses.
> 
> Anyway, please keep me updated on how you're progressing with the fix
> that you're intending to work on.


