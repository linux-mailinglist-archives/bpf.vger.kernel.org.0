Return-Path: <bpf+bounces-33510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BA91E566
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AC31F23A0E
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A016DC2C;
	Mon,  1 Jul 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dUH1oEdY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vL2QKCdn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830324696
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851468; cv=fail; b=by6yDSYzNfv8p8NtQ91jz84QATOfIeh+1ikeZFU9jaK0j39uwA5aqHsdZGr0Ip8egyZbD6lN5x/T4AYrStMmQ7ITRyes5J8E52U7imucKfjYPffPAmBolVw2s3wjaQoM2XMQ9XMW3jfdoqIO51Am72wOPR4zvKNKSRJrwJAJ54o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851468; c=relaxed/simple;
	bh=9yFFvg+m5Niehk+Ds2dfhqYLJOnbp1cXAlwICJrqPtw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h+XGxjOWjUaN4ocE5eSvnWymVowHIlHtnqo2/DbNWuXNqoTzrgQeIvie8CfW7eNQOR4Tm1CqZL/m62al82p9NxLMpYa4cdqSI41K5qwwNxsE0WeGvKy5HZ48qAU/Vmx7Qsx/4GxTQqUP/v7szg9c2kA8LXA+P4Mo7cd1hYr9IGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dUH1oEdY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vL2QKCdn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461FnvGL029773;
	Mon, 1 Jul 2024 16:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Qlk2fAy0NQ3zubUaBo5YshQbwLAbbjcDsiyblMgTA6Y=; b=
	dUH1oEdYLzDuP4wYS8Dm2BgJbkIUWiL0s0yjpXRKK6wBuThKexBY+irLUuSbKA8V
	h5IbYEZkXsUFuPt9nPTU2W6pnchNJXwxj1Wn5OD7mw9u9j7GWrmjP3NaUwOGuteN
	koP+vEnjo+hcBZgSKHCMIDDe0hc/lu9UYdm5bRXOIjPFJpUQZOe4nghixceISA62
	5iasxOMwHYRSSPEiDIRFJz27WIKIFjYEznBCTTUlkHSKEFy/5eLzvtks85oWkj+x
	A8104kuYsxKAZYnRM3gUYopQTCXLLLxtVUVpJqnCokyx4Dle9HbIV9bgRoUnCouo
	nxeGyfC8dKnWR5c17tM7DA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacc351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 16:31:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461FL9Rs023047;
	Mon, 1 Jul 2024 16:31:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q6g9kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 16:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4M8pY32xbZANAM38qWRdUBiDf0veowiknkrE3AhSl1TH+oiMFy6CCIsHV1LQ/bcHs618MHTpe/cucyywCwIDskk3Av3gplMjNZgBCoXwPW4zxlCN4Fq0UQugGEWzGDGMS1MHvCLW5acgC5eR2+MFSkK9OpivSiCfO9l89Y9K9pY2/s06ijdOtpAqxzGiJCi6fu2eHE7+n80v5BzGEB7VpGc7U+7i5E3YPOp8/SjOSfl7jD3b7WEyxx3fy9XgVygFdcaeijw3hM66oa+uEcVpej0KRClQori+lyjqihWHFI0IsIt/kTLpkeEbXvQjE+30s8Uz5IL+ilxZIcWxuhzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qlk2fAy0NQ3zubUaBo5YshQbwLAbbjcDsiyblMgTA6Y=;
 b=B57D3kLmlObw6W4ytPYD90CYYGGV79tqNosaEien7N+CSoSRk+XqsbrSU3/K8PFyENe1XIX4OpemlMEzxzEqxSiRt9fU5nSdZkPOzVvhNcGn+zqZmLD/SxBSGHOH9n7dRJ9nTrkME03iOp3+RcJUIjKD1yIBbOwq1+qEnoFU2bxLdaLNz6lK/YC2PkVrXNNwx8Mwr9Htw2jAQPmXgXUoKqsUVB21s4hvPUGM2d6rxOHioJaGyI0q+fryJkDWAC7OCX2aKUEOGSoFNoUSV6kzuctEu6qZX74rsKb6uciwyrQTU6uJwb3ic5vw1AImcFzuZkkXQmYhrwnzGPXgrbEn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlk2fAy0NQ3zubUaBo5YshQbwLAbbjcDsiyblMgTA6Y=;
 b=vL2QKCdn31e3DPLWN6Z2PkIWJ3R/ezdt2QgKIeBvNTDSr8vdBW8Z1iMQuhVOQp0i/KU3F4tqK3aPA4uW568bfNugxqkV8Nbu+VudYRQNu/ALlcDgeaZt6WDYLh3hqXXT3gi00/9VHKdH5MpofK/dR7sJpnIBHrz7nn5BfOZ/8LQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CYYPR10MB7605.namprd10.prod.outlook.com (2603:10b6:930:c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 16:31:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 16:31:00 +0000
Message-ID: <579d4df3-69e6-4476-981d-c692cd225bcb@oracle.com>
Date: Mon, 1 Jul 2024 17:30:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: A question about BTF naming convention
To: Totoro W <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
References: <CAFrM9zsz-FLK5pJW1rL_k8YRqWPafYV3H0L1PGJxXo5YYttkVQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAFrM9zsz-FLK5pJW1rL_k8YRqWPafYV3H0L1PGJxXo5YYttkVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CYYPR10MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: d393cfc1-0c23-41a9-4970-08dc99eb3124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OHNiaktaV3JwdEhVcnplMU9laXBvL05TSGsrWmRXemNZdmFLK1hqYnQ2Q3A4?=
 =?utf-8?B?cXJsK01XRXk5c2RHU3ZLUWRrQks5UURId29VYnp0WSt2bmZvc2k4cEhwM1o0?=
 =?utf-8?B?NDNRU29WTEIzV1cvQytXN3FpcmxkQnNHMjNDZ1RwQzA4R3llK1BBUVhQNU10?=
 =?utf-8?B?M0UwanVZRzd1RXllMlR1K0w3SzdDOE5aL0JobnVQMmVlczVUR1lBV1JEalZO?=
 =?utf-8?B?UGtKNXdlVnZ6SU4yUkgrN0wrd2hTNFc1M2tTaFpRTnFObUJyYUxaWDM1ZGw1?=
 =?utf-8?B?OS9seloxbFhOemVmVDczeXptQVNoOWc0Yk00M0xuYmZrRDlqYlduRVlPZjVL?=
 =?utf-8?B?U1VqZTFFd2VESUI0MnFDaXpkMk1GdkJxQmc4Ly9xVjYvNHN1YWNNbFZSYkZr?=
 =?utf-8?B?NXN4ejlFS3ZERVpXSTA3bXhCcW1LWW9Ca1htKy96Q1hMYXczOVJWem9XMHM5?=
 =?utf-8?B?citUT1NWWWh1V1pZMFAxSjQ2Y2hxbDlnanRVZ0hwV0RhcTZkL0NRZXBjdnZX?=
 =?utf-8?B?RzlHV2VkYkVYVGw1dmh6djhuNXkzUEFsSkJxVjJWbVhXUFBOUnZXRDN1U1RO?=
 =?utf-8?B?S0VSYWVpMGcxWVUxTkFUS3ZSdjFud0VScWhsK09EUVVGN3RUS2xVWGNyWWZ3?=
 =?utf-8?B?VEg3ZjZsVFMzdDRyYjhNUFVPV2RmaTd3WW1OdS9VYU1oNWtGZ2wvMzcyYUhx?=
 =?utf-8?B?YmZCZm1pZlhpdklaZjVCemNwNGRkdVB1b295ZzVXVnNtTUhTb2FQeFVFdnZL?=
 =?utf-8?B?WVJaa3JqRkxqQVlGR1JmbmliN1p2b2RnVXBQZXJJVDVIY1BheXFYZnVQQnZt?=
 =?utf-8?B?aFYzNjVMQ0g5ZTJJNlhmTW80dlQ4TnJaQjJHeWtkVzZ5dXhJMkpGVGFxQnZZ?=
 =?utf-8?B?a1NQQXZtd0xrMXRDQmt0T0J3TW5KRFVrWiszeXU1OTFzZEhQQXd3V1BqWDdF?=
 =?utf-8?B?VEFYSkx6NHhXUk4xcUN0ejZpcEtJRE80a0VKSVV4NGVVSCtKYitxQ1FQalk4?=
 =?utf-8?B?NHlaRXpMeFZzWkF2VFprTUFUYW1acmZJQXJicE92bTh0dWRjY3lCeDdUcGJB?=
 =?utf-8?B?WG5CaGtFK3pQby9XMUdWdkNVUnk3YzBVSmNhR01VclRkNDQ4dHNaTmxoV1Qv?=
 =?utf-8?B?ems5ODY4YUxUcVN0alFqNlNNZ2tIR0NqbHZta3hROXJrWkpIK2hhVkZScm9l?=
 =?utf-8?B?Tlo5YjBaT0hHQUxqdS9DeWZwV2hZZU5VZS9iTXAwRU85T1ovSkJOdUYxekgw?=
 =?utf-8?B?R3V0R1RsaXZrazFrWUdpR2kvZUlJSi8rWkFpd29RamF4UTlqSHFDSS9EeDZh?=
 =?utf-8?B?NXBQRFFDYjczbkM5SFIxblM1UWhrQlZ3YWdZUW4vOVdHRGZHRWlyMVlNa0VJ?=
 =?utf-8?B?TTVHa0RrQnRHY1FXOVhNWVlMNnJOVzA3VlJqcDhVWGRTSHEzTHg3SThvUmtG?=
 =?utf-8?B?STBzeDFBM005UE9NbXpuZG82UUVrbDRLOVFDOHljM1NOMXcrcEFyZldtNjBt?=
 =?utf-8?B?ZktDVndwR3N3Y2czbjMzdVhlVnFQMktWa1krTEN1bzVCTFduV1ExRU1CbGsx?=
 =?utf-8?B?em1QL3FRK2tmSEtSUXhaaDhRdHpsZHp2SW5nK25kMXFxOURTdlpvNG9oNUhz?=
 =?utf-8?B?UGhrZWZPdzlpMktEMG9BODF6WEFoR2pOUXovTGp3Zjc0SjRabVJaREJXWXpu?=
 =?utf-8?B?azM3WitFcjVIbTFRaWdxeGduWW41em04Z3FUaFNZZUhUZEVWZE5Ec1VpZEgr?=
 =?utf-8?Q?GF7/x3jRZCx+9viK3Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFk5ZFAwU2oreXpVYklBTnZqbGkrUzRXUXNVc1FIWWJibjBZMFVBdTcvMVMw?=
 =?utf-8?B?K2phSlhwcnB6QlZDNmUvVGl6N1FiNnlXZ29zOGw5V0lMdVBnM0pTUFhwMU5l?=
 =?utf-8?B?WXRnTkZHMG5KUW5NelRvcTRyVnJoUTRJM1d0bHppTGdEdjRmdDFmbldraktn?=
 =?utf-8?B?NHAxaWtQTUVwSTFlUXBWMXY0TUphTHNzdVRxMjcxQVJCQ1pUVERLL050ejFl?=
 =?utf-8?B?S3cxNGZTUVN0UUVFZkw3UWdmOUh6RWhJQVpmTDZxTnZXNi9IdEpvZ2Y3TDhV?=
 =?utf-8?B?TFdXWlBXNkNDWWdjWkxEdGcwVllrNk5DU2VxS1RUblNDL0hNRGc1V21QUFJ0?=
 =?utf-8?B?OUtRMUhVMDJHaW5KTC9lY1poWXYzVjJNUHREc0tCaEJrMzF2SUY1VUNGdnho?=
 =?utf-8?B?ZzMyT2VLZUFjSE9acWxPMXNvUGxpWllQM1dGMUREY1FFdk1BUVdqdGNQL2xl?=
 =?utf-8?B?RW9EeVRIaVZuanF6dUVKYlRuM3JIaTJ2M2FSRGlvRlBvaHJTano2WkdYQ284?=
 =?utf-8?B?cm9PZEsrR2xQYVQ5WVlLV2R5WnRCOHcvNjlMNkVpNzhwa2RSM3BkblYwc0Y3?=
 =?utf-8?B?Y1Rva3ZqbHRSczFiek5hZ0hVZFdzeVFlcW9ROTc0bzc4SG0yVE1UcVRXdFg3?=
 =?utf-8?B?M09HMXJlN3AyRXg4U0hrWUpqOUJPekJ6bk5IY2VISGpEQkI0cUUrRjNkdkhY?=
 =?utf-8?B?ZXU5UDAvOW5DRmh4UTU1T0EyVi96U1NOeTdIN1dMWVJBaHYycXRsdnhmSUh0?=
 =?utf-8?B?S2ttVkU4SGs5MmRjeGRoU043S3ZVYWVva0tFL1dPbHY0b0JxZEExRk9PMWdz?=
 =?utf-8?B?SHV4UndRZXVsMGFpclhsckhEc0gwMjU3VjVYN1NlZXZUV3oyK3MxQlFnT2d0?=
 =?utf-8?B?YlVWTjZ4Q3B4Y3h2MHBQclNKUWtWZDVJNGVIS2M2cDlGczhxeERYblJiL0li?=
 =?utf-8?B?WjFwc2tKNHF2L3pOWDhHV2VFZi9LWWxzYW1pQ1lWUVhCUVdrOGxxa0k5MnlX?=
 =?utf-8?B?bXJaQ1diU3RuUlpEMlBOWGtQYW8rQTBpdEV1UEtQZDFoTmdvWEl2YkhyMlJG?=
 =?utf-8?B?ZEgxRUJHRENnbTMxT3dKZ3E3anZQQTZBS3Bhc2JJQmNMSS92ekowSS9lbmJZ?=
 =?utf-8?B?MUxqaHduTS9sT09nQVBESkVqdEtXckRyTjhRK0RWTEhhdEhRUU9WMEZCR0F6?=
 =?utf-8?B?Wm10andqMXhpdjdBT0NYVjZnR3RkT1h2T083RUNqaTZsWW9CMEZGTEY3bkFy?=
 =?utf-8?B?OGt3bDdvSmlTOG9Mc1JxenkzanFkQzlCcktoRkN5d2lUcnE3cFZUN0lVaXho?=
 =?utf-8?B?aE01Z08xcFhMTmRIR0N2b0ZmQkZjV1FmMHJsekQzTStFMThPS2Y2Y3k5NVYr?=
 =?utf-8?B?WUhFNkV0dEJXMUZ4WjRic2ZsMm82b2doNDh2UjZrc2lhYjlwWG5XSXcxS2RK?=
 =?utf-8?B?U3NPN2xaOUdRY0tadk4vTEF0eUQzQjdHbEE0SzNZWXg3aS9XQkc3WTBWS1FT?=
 =?utf-8?B?UVdHY3BHOTNubUc5MnpXWjlKcllWTEsxekZGTThTcHpVNjF2MGsvcDZKK0pH?=
 =?utf-8?B?NEhsVlErVEIvUTFyY21pTFA5cEJrRW91VWg3b1hNeFdCOUdJMGpOUUt3WlI3?=
 =?utf-8?B?UG93SUVWWE1FdnlES3NEaWQvbStFV2Z4WnVPQVBCWjZNMTVqSTMycWNDYk9J?=
 =?utf-8?B?RDYvUWV4RWFLMGkrcFhCVTNpL0NqSW41T256MzFQSlVjZnVtU2ozem14YVN1?=
 =?utf-8?B?T2haUDdKUThid1ZWM0YrRElsYUhjb0xHSUIzMzhPUG4yR25PLzhycHNyWDRr?=
 =?utf-8?B?bDY4Zlg4UTI5RkRxT2VreUladnE4ME5ZQkJWVFdrcjNmdmNNOExRSnpFT25k?=
 =?utf-8?B?Qm1IZVR5QURGZ1BjWHJVMVg3aEFjbG8wdzRZWXphSVNNeWt4Mmc5U0ZnZjF4?=
 =?utf-8?B?dnRtaXljOUpTQURYVEUxK3huQkRnVGVCMDQxN3VHL3EzaXRHZnl5S1ZpUG96?=
 =?utf-8?B?Z1pvK21uQ2xKYm1SeTY3ZENIb3dGay9TT1hCa2NidU1xY2dBem9TMCs0YUJE?=
 =?utf-8?B?bCtrNVFobFA0alhhZjVleVRldlJSRGVRdjdUNU9pYXpkZG1wWTBneGVMZmNW?=
 =?utf-8?B?eitnT2kxMC9DNXBsNHFCcnNwaXMzV0dQYjVqSHk0dkhwd2YvVlF3UmpnSUEw?=
 =?utf-8?Q?tnkpM20KxpqEEeTQCJpdUkM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eFQA9t6x8/3mshZgdgmn7ZNELwhRDaqcpbgyYv1IrpZsC7LvnPeqc4+eoYMoOJ1sU3pupY9oWUFRWI2iCJPs6W2+k5AjmwuRcoE03U3ESVgJKPClKhf/Q4HmvSURawHCHHn32G42K3ifYqOSRQxixsEYYuEaCMTEdGHbJOVNGuMMLL9vKonBuF1AB+owZuXMarHqQ9UQhtAiXQtuS21P6UCm8juv2LjrUjxUknmlQwqI+Vk5xY7OKHQWGxlFNF2PCMkclrthzYTbQzxXFRgz6+5xe5zXoHKe0LEEUsHpD47t5rKhCyncqIg2Z3g32N7Y2cl/0Fl24/f69pYq9mvATbD9rb/W/GB7Q5dlCv4r7v/2zrmD2RARE+xAef4GUQwKBVcMyEW1X0yK0vXOf5UEvrENi4vtDPmc0M4usmq9fVnDE0QMQX1UFx3loMmNh6e54sKYsSLp3bNhBbDsLVWYo6i68AtWJ44Du1e7rNH86Evny3/dFBg67gqFAblt1b5WiSjgCVQSXX7TqE3sKqgLR3GxoxTqvyZeKjSBOhal7njfeb9JFyHJR2+m8XBpM/3DuRiB9o7J4aHp/xlVGSfcarecSfkWKbxp+q7CPclF2ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d393cfc1-0c23-41a9-4970-08dc99eb3124
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:31:00.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62f1Ks9SukXs/0WBs5gKzyKuY4nN1/+Y+AcX4jt6Waw+qb2p3xgcoWeCkhubr2ls7klLU4J4pkWh0euRi6tbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_16,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010124
X-Proofpoint-GUID: XKVdvz4Be0oLTo7PRd5nGBc4XavNRO8N
X-Proofpoint-ORIG-GUID: XKVdvz4Be0oLTo7PRd5nGBc4XavNRO8N

On 01/07/2024 04:50, Totoro W wrote:
> You're right Alan, with the above patch, the type name for the pointer
> is gone, here's generated BTF the same program:
>

that's great (lucky guess on my part). It would be great to get that
fixed in zig itself. That leaves the naming issues; from Eduard's mail:

>> Even though this just work-around the issue, I'm still curious about
>> the current naming sanitation, I want to know some background about
>> it.
>
> Doing some git digging shows that name check was first introduced by
> the following commit:
>
> 2667a2626f4d ("bpf: btf: Add BTF_KIND_FUNC and BTF_KIND_FUNC_PROTO")
>
> And lived like that afterwards.
>
> My guess is that kernel BTF is used to work with kernel functions and
> data structures. All of which follow C naming convention.
>
>> If possible, could we relax this to accept more languages (like Zig)
>> to write BPF programs? Thanks in advance.
>
> Could you please elaborate a bit?
> Citation from [1]:
>
>   Identifiers must start with an alphabetic character or underscore
>   and may be followed by any number of alphanumeric characters or
>   underscores. They must not overlap with any keywords.
>
>   If a name that does not fit these requirements is needed, such as
>   for linking with external libraries, the @"" syntax may be used.
>
> Paragraph 1 matches C naming convention and should be accepted by
> kernel/bpf/btf.c:btf_name_valid_identifier().
> Paragraph 2 is basically any string.
> Which one do you want?
>
> [1] https://ziglang.org/documentation/master/#Identifiers
>

It looks like your workaround patch is dealing with FWDs and structs.
The BTF you provided just seems to have namespaced names like

[7] STRUCT 'map.Map.Def' size=24 vlen=3

These should work - at least since

9724160b3942 ("bpf/btf: Accept function names that contain dots")


...which landed in 6.4.rc4.

If you're dealing with older kernels than that, you might need to work
around the naming limitations, but for newer kernels these names should
just work. Are there other issues you see aside from the presence of a
'.' in a BTF struct/fwd name?

Alan

