Return-Path: <bpf+bounces-5561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127DC75BAC9
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34E62820A7
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA72171A1;
	Thu, 20 Jul 2023 22:51:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEF14011
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 22:51:35 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E014171A;
	Thu, 20 Jul 2023 15:51:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMjMB007317;
	Thu, 20 Jul 2023 22:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+S2JgrIcagboVWB+kWttscNBcSMU0oqLRbX25iLrNu8=;
 b=Iuyh9ZVU6AW8789wf+wqS4N35bQVwZdUozbaXCRhXAFGw2Tl7faxu1t0/b860/b5MrGb
 DLc6yVPJ3f7ot/xIfkE25Z1Ea7XdJhmwqB/H+UFF26aqaIN1tDY1z0jCYWNJRINiw++Y
 X8n857nV3sJV7lapOm14/8fmiWxQ20yUEsQx+aSduBLoZ0+YSEkmzFsUjcYoGU93Zxdy
 wnnW+XBM9yo59S008pIhCFkEmEsHI+gtp1+UAABneQ5Uci03Bs9St45LKd4KSGzMDGCs
 bTkzro0noxKX2mxoKOmbULnzItUJLoqq+9cG8aar3DpuGMeLC/LE9ZyULpkUatXL3XnL 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78aqam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 22:51:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KM0ai9023870;
	Thu, 20 Jul 2023 22:51:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw9hn37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 22:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBeeFKeZBZax/nNP0U5ie11B0uJdHWVo3v8iLHFTESC7tieAEVwjc4XXs/gPPzZaUQILGsSVugzKXDeleInT6R+HA5zGyWY8vTPD6opPhywUUDf8VAqQnBNm3RrJI6RXjL2uTqlDlGe/O2ifO18zQCEdaHPwfM0p80sTlMTVLJBJlNSDAs6MdmKjjJIEJwtcSLWrKuY68WOw0SD0jD4f7OKwtkJdoMd2Sbh+P2ZN2B+Wo6Nlkdh7Z4xQ55X20o99I5PhLs7arlBmy7DhokIYCAPFegV0HdNPvCOPKeTv2j0v1oo2CcC/GfIp0qnd+T+HKU9+tFCAKbDnJFe9hecQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S2JgrIcagboVWB+kWttscNBcSMU0oqLRbX25iLrNu8=;
 b=Pa+bKdDbZgMH6MSOXnguy06wKDw3I7uAytwgsEp81bZ6KRN/ab5kf3yxSmgukzcGsP+gjaH/YOux2oLWqpGgsZPgpKJGu7Q96I43z1w5IR48AnT0PLUDFgrhTD3nqV3XqbgmkPuZOROx0DbRyhyGUYWS/zC8ZCRNvACq0lGoYI7rXJCMqDncdoAOAVp6eLLFJ568IERaR+0VZm0GGvpw+8JvnxHVPb8xTrPPHJRhavPNG0oalDjGydtMYTNx9xL7MYfQrDZ1gkZa0QHpO21dxOmoWXAAWEMXgDmVqv2alzE0XG0oYhyi6mTSZuODCwhOk2H0vu8M1Kyx22HE5LAWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S2JgrIcagboVWB+kWttscNBcSMU0oqLRbX25iLrNu8=;
 b=ZykW1aU4VB72HW4BAhkbhjh2VzRWQ8pCXmKdqriNykRwt/G3UJ7Msym00zIsnZI7v61cvp/bjCL9ByhmF4QHDqIXbzeF1Zo6xVwOJvWHBY7wY6bEpTP8jmiL8ibmReLd2uiRsDLUiV0dk7++GZlt++QiFov0HWOx3odX3opYT14=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 22:51:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 22:51:22 +0000
Message-ID: <da7817be-d2f9-5ac0-3cde-9e4604bcaf14@oracle.com>
Date: Thu, 20 Jul 2023 23:51:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/9] tracing/probes: Support BTF based data structure
 field access
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960743715.34107.15965496586942658628.stgit@devnote2>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <168960743715.34107.15965496586942658628.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b790120-63a3-4c6a-d17e-08db8973d6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5K1+Wm7v+aF9cjMha9DgYOoTJKnbjCO/AjwbdviYAu/14RFwg9gz3MX8OWIV7Z53+a8kOz4WHH45Y7kqOvMpcxKNDQAL4Js3/PeNrhnF3r14JSL/veKX7sM+BUNcruB+CWw94mrGDUhdz00ua0/btZJsolSWdCpj6DaJ2mQ97R4l2UWBBALDHkNSZnKTj2R9tZ1vJ4EueRfLyWpk3o/Sn/56/HhDar+diMsGN2vtCX3mtCdtTZrEubDwRHsgT+SoZIN4pF9oA/exwjiJ/J5Jmc+gEqN/DQSgvcTzDfGdEbauBhvzs8GdJbBBc5ezwfUFg+1330j0dOEJ3JkUG1FhhbdbUe0Yq+1Dl5Gt+zIi3F9zehMuhZ1x0M5hCYssVoLArb3NPaQPruQ35te4Ajcl+4iUUabArw9cUoRi285sRBlStNh3ozvnve48AWZCXdffk1Dmcfautr1jDUi5wZ/XgjF5Oxr2pgK7Cugp+SzSJoUeRxKMLh1xFgCleFqs0prIF//MH5NHgcy6ZCP8R3NfEfuZgsTA/xRKkS+2K02bGqEJTrGM2jql93UuOBGd/i4iZFEjrV+cHUI5WpaJ0mFKdIpsJHVY6xOeq2bcOMhwQJHbkIukDSGZWQvvgpm3MJ+HeyyuJWeozlO9yhPozyCFDg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(31696002)(6506007)(186003)(316002)(53546011)(41300700001)(2616005)(6512007)(83380400001)(31686004)(6486002)(478600001)(54906003)(6666004)(4326008)(66946007)(66476007)(66556008)(38100700002)(44832011)(8676002)(86362001)(30864003)(5660300002)(36756003)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVAreUkrOWlERlp5cVErTVRUZXY2ZSsxTWpKVWdheFIxL0toZUYxZEY1REpO?=
 =?utf-8?B?SGpwT3Z1ZkoyajNmQk9CVEwzQldyekRoL2lTWURKVE0xUTB0Sloxc25YMktS?=
 =?utf-8?B?S0JETFZhc2hvbnhSN2k4c2VXVXIwUXIzN29Id2xqSnlubzUwRVBCdUhJK2xH?=
 =?utf-8?B?S1RSVVRObTZzT3o1Nm9ZVlFMV2w5QURxbHIzWjlVUVhiVWxFTnB6NEVFdDdF?=
 =?utf-8?B?NXNCY1RJK0xjYVpPSDhRcEhIWE1ocVVLMHFFbjNIY2k3OU4rbUd5OUtRU2d3?=
 =?utf-8?B?Umc3aUFUZUYzY04ycndNUXVLY1JEdTNBVEkwdWU4VnBveXpETGhoWUt3dnZi?=
 =?utf-8?B?eXdGVURJU0QwSStnNEJCcGtCdXE5THB3Vkc5cmZGYUdMQ2VqWHJ3eXcrejJF?=
 =?utf-8?B?T1h6MEV2aWh1L09qYmZGSWo1b1VSc2F0b0swOVYvZWZNZ1BVTTNBb2ZyK0dS?=
 =?utf-8?B?ZUpFQzFaSlF0ZFpxSHc4UCtyaDliL0FiaEdvNDNxWjAzQk1iK2ZKdlh6Vk9H?=
 =?utf-8?B?bTZIeVU1UjJHYnNoVHhTcUtRUVhHNHZyTVVNcitIMXZFbld0enlEbWtJK0Jl?=
 =?utf-8?B?WEU5YWdFQTVDMFhBcjI2RXpYYlNQRWR1S1FqNTg3VkUremthU2I5T3lOdWZX?=
 =?utf-8?B?aXp0dDRlVXdOUHgwejNQdFRXWVo4ZmpCZ21KeEdhcTY1QzJMQWtxMVByY04y?=
 =?utf-8?B?K2YvYnhxY0hramMyRi9oUWlycFdOTU1nNFdmSHFqWTZLUWhrYnZ5NjhETnlX?=
 =?utf-8?B?ZjJwSSttZ2xYaHRLVSszUnRqNytaem5uWVIwZStKSVR5VC9NZzBVWUZ2YzZi?=
 =?utf-8?B?UkRZNjlPbVA4T3ZVNVRTWWRwWktWNXVxdE1YdjRhcGdIcU16NXZEbVNuYjZk?=
 =?utf-8?B?ZFBVUHEwYnFyWitnMG5DUnVHWmE2bG0zZThhS3VoMXIrSnY5YzUyTWNZU0dE?=
 =?utf-8?B?eHpFd2dCaWdHSU9rcXBzRUpWb2QyalhUNU1QNHd6MFBLcEcrU0pvL0ZrV3lQ?=
 =?utf-8?B?bXE5aGpkdmR1OUdzYUhyQ0tWeTNuZ3M1L0lmZFJXeGs4VEYvUWpLTzV2QTll?=
 =?utf-8?B?dk9lMHRYU3puVXJHQlh6TUpaQnhwVFhMekJqZlhPU2FlTzV6UWM0R2hWMDFu?=
 =?utf-8?B?L0pnaGFkekZrMTdidGE0dzhVY3gzTHB0SU82cjMzM25QRkZ5RTlhMzZVTFJ5?=
 =?utf-8?B?aDM2OGZtYVlMWlh2cW91a3ZjdzBESnAzcGVackEwQ3hqcnF1MXgrOGFXMWtz?=
 =?utf-8?B?Y2gwUkg5S203MHdHWmdoTEk0c0V1Y2owLzlqQmtkaDZoMzNWSFljNDVKam5R?=
 =?utf-8?B?OEIrSWFpWVArclNyVDZnVm5kRGkxTVo5c2hTYTE2dXd2OEdwei92VkNxcnBF?=
 =?utf-8?B?ZXBuQmhHMjlSSGxMSWowYTRDRDVRaHZwY1NJRDFaUjQvd0lwaERYUzI2WjNL?=
 =?utf-8?B?Nm5CR1ZRaHlTY0FVRVhHeDcyWVVkUkg1TDJUSjZYeWJaNmVMYUxua0JNUTlM?=
 =?utf-8?B?aHpsdVd2UEExSHJ6eHFKcTJnOXVTUDdCNzRneWVseDBJRDl2NGtJemhNQkpv?=
 =?utf-8?B?Tk14UDNxeE1JeStYNVRDNTdlcnViMFBkWjVPekxmbjVDcCthZnkzbUo3U0JR?=
 =?utf-8?B?bjNGSmZvQjhDc0gyVjlycG42RUVja1ZBbnZRWllyR29uRS9RY0JNdmxWQS9Z?=
 =?utf-8?B?MmlmZ1Q1ZWdkT3VsNWtuSGZVYkFjc2lZOTdsS1pqOFJlV04xVFNNWGc4SGRp?=
 =?utf-8?B?eFBqREozcHZzSG9mYmg5endhTE1JQlYrY1h5TEE5LzBpcmF0RVdsbXdqZ1o0?=
 =?utf-8?B?Wm1qbEtacDdqMTNVL2ppRmFDNVI5dmthYTFpVFlPUWR1TTlzWC9RdDZpOEd2?=
 =?utf-8?B?RnljZkNGS0plbXE4Y0QyWWJvWWxZMkNDckhiMFlUc01XQmNSQlVKTjY1bjlR?=
 =?utf-8?B?cysxN2hpRklWKzQ5L3YrMU1BUSt6Tm56OGNVWE5Kd1pKOHpxZFBiLzB6Tzli?=
 =?utf-8?B?MmVqWmlMUEpISlJBVGJzaVFXN0pyK3gxNUFuaFZiT0F3ODJnTTR4dG9TTWp6?=
 =?utf-8?B?UmFnVGNKNC9WUzVJSWlCbHgycUxwd1dUTVZTT2d5Sk1GVE4yc2RSSVpjR2ho?=
 =?utf-8?B?bytOZ04vN2hBOWV4MGpPdW9rWTFYTGxkVE5yMjZyWm15Zm1KajdLYkRnN2U5?=
 =?utf-8?Q?agWiJpoAAGHBNNzW974ljb4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bD0MoHCDzxXWKG9LfX7397/HJL2bg83ltz+g+mC6MbM40G7vRuBFZ54jlvtft6qftVxwPvujCE9pbeoxcw6dJdUG9B1XHapbXvV03qrIjiqKy6QOtqVjnic3PvPyaRlagA0+U+rhtNm+MTSme9M8wb8M64HJ/MVgwY1TPtzK6i68wpYwTguaA0YCJri/WXOw+G5n1EQZLLbPTWZFh1VrJDgh021655yinpO/ZYApPCpREteoxNiR1GHiCbVbZmoQcKfOyKQUAtRStqEvfbrstfp2hR3MqNrd2i/RC6qKuX5UjJZ8BYDQapKJdrC3HFtrJJBI/DL9EDhTtXnXqc8DpWwBvrSGWFHjBBihuQn6YHdgx/oVifMS9VUwOgA1CoaXVwLcdjvg+fR4IqBwCmFbImmUVWyhHAmByYYzXEmayFOyM0vTX5ft2P+DFUNIqt+ExB3WSC67SQBL6666yOBHaQCAx9Wf6nVixMxVNxNWFqpabp2gfCq5sfLt15xjHQDagsid6tsSxcS/NW/dUzBEWn/bOpYSKChlvargSdqDpj61YRm1wrWwf0FYmAg2zqJOml1SG4eGn95w2NRWM7GmLSJo3Gkeaqon4ViurpKGvc0Z9WV2LL+p1ITaQmUkWmguQIG3W65W+WRvx1mefaSx7s9ZtsKcVLNahfNr06HAweX+R4BodtBBjmWpuYXek0qnB2hI9X3zMUyhsKyD36tMA106+2bwY/Rckesd7q0AvfTS9ZbxwcdNTaBpddWyFlNToHW/cfoJaMbWUdpwUhLLlJsHOnosA8SUYV1xEMKxDEgfzQzpp0GrNNFv0qZh2LFFVQzmpG+ZSyLgBA+aexX3tPpt2V/eNlWYNM2m3Wza33+6BXN3C6zV8musgeNaCMKIsR5m6ciifXRYZClrS4ozxw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b790120-63a3-4c6a-d17e-08db8973d6ed
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 22:51:22.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtDqhidu+QySgc/ws1yCUTOZIpDeBH4t+zBeV+TZzVcK2/2O5FgYuTsfD6d0p7CRF+HyNG/ZC0lWkk8nTJPQKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200195
X-Proofpoint-ORIG-GUID: WbXtxA0jAW25Quzd9V2l-R1geBVhFTrW
X-Proofpoint-GUID: WbXtxA0jAW25Quzd9V2l-R1geBVhFTrW
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Using BTF to access the fields of a data structure. You can use this
> for accessing the field with '->' or '.' operation with BTF argument.
> 
>  # echo 't sched_switch next=next->pid vruntime=next->se.vruntime' \
>    > dynamic_events
>  # echo 1 > events/tracepoints/sched_switch/enable
>  # head -n 40 trace | tail
>           <idle>-0       [000] d..3.   272.565382: sched_switch: (__probestub_sched_switch+0x4/0x10) next=26 vruntime=956533179
>       kcompactd0-26      [000] d..3.   272.565406: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0
>           <idle>-0       [000] d..3.   273.069441: sched_switch: (__probestub_sched_switch+0x4/0x10) next=9 vruntime=956533179
>      kworker/0:1-9       [000] d..3.   273.069464: sched_switch: (__probestub_sched_switch+0x4/0x10) next=26 vruntime=956579181
>       kcompactd0-26      [000] d..3.   273.069480: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0
>           <idle>-0       [000] d..3.   273.141434: sched_switch: (__probestub_sched_switch+0x4/0x10) next=22 vruntime=956533179
>     kworker/u2:1-22      [000] d..3.   273.141461: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0
>           <idle>-0       [000] d..3.   273.480872: sched_switch: (__probestub_sched_switch+0x4/0x10) next=22 vruntime=956585857
>     kworker/u2:1-22      [000] d..3.   273.480905: sched_switch: (__probestub_sched_switch+0x4/0x10) next=70 vruntime=959533179
>               sh-70      [000] d..3.   273.481102: sched_switch: (__probestub_sched_switch+0x4/0x10) next=0 vruntime=0
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

One issue below that I'm not totally clear on, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  Changes in v2:
>   - Use new BTF API for finding the member.
> ---
>  kernel/trace/trace_probe.c |  229 +++++++++++++++++++++++++++++++++++++++-----
>  kernel/trace/trace_probe.h |   11 ++
>  2 files changed, 213 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index cd89fc1ebb42..dd646d35637d 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -319,16 +319,14 @@ static u32 btf_type_int(const struct btf_type *t)
>  	return *(u32 *)(t + 1);
>  }
>  
> -static const char *type_from_btf_id(struct btf *btf, s32 id)
> +static const char *fetch_type_from_btf_type(struct btf *btf,
> +					const struct btf_type *type,
> +					struct traceprobe_parse_context *ctx)
>  {
> -	const struct btf_type *t;
>  	u32 intdata;
> -	s32 tid;
>  
>  	/* TODO: const char * could be converted as a string */
> -	t = btf_type_skip_modifiers(btf, id, &tid);
> -
> -	switch (BTF_INFO_KIND(t->info)) {
> +	switch (BTF_INFO_KIND(type->info)) {
>  	case BTF_KIND_ENUM:
>  		/* enum is "int", so convert to "s32" */
>  		return "s32";
> @@ -341,7 +339,7 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
>  		else
>  			return "x32";
>  	case BTF_KIND_INT:
> -		intdata = btf_type_int(t);
> +		intdata = btf_type_int(type);
>  		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
>  			switch (BTF_INT_BITS(intdata)) {
>  			case 8:
> @@ -364,6 +362,10 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
>  			case 64:
>  				return "u64";
>  			}
> +			/* bitfield, size is encoded in the type */
> +			ctx->last_bitsize = BTF_INT_BITS(intdata);
> +			ctx->last_bitoffs += BTF_INT_OFFSET(intdata);
> +			return "u64";
>  		}
>  	}
>  	/* TODO: support other types */
> @@ -401,12 +403,120 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
>  		return NULL;
>  }
>  
> -static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> +/* Return 1 if the field separater is arrow operator ('->') */
> +static int split_next_field(char *varname, char **next_field,
> +			    struct traceprobe_parse_context *ctx)
> +{
> +	char *field;
> +	int ret = 0;
> +
> +	field = strpbrk(varname, ".-");
> +	if (field) {
> +		if (field[0] == '-' && field[1] == '>') {
> +			field[0] = '\0';
> +			field += 2;
> +			ret = 1;
> +		} else if (field[0] == '.') {
> +			field[0] = '\0';
> +			field += 1;
> +		} else {
> +			trace_probe_log_err(ctx->offset + field - varname, BAD_HYPHEN);
> +			return -EINVAL;
> +		}
> +		*next_field = field;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Parse the field of data structure. The @type must be a pointer type
> + * pointing the target data structure type.
> + */
> +static int parse_btf_field(char *fieldname, const struct btf_type *type,
> +			   struct fetch_insn **pcode, struct fetch_insn *end,
> +			   struct traceprobe_parse_context *ctx)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	struct fetch_insn *code = *pcode;
> +	const struct btf_member *field;
> +	u32 bitoffs;
> +	char *next;
> +	int is_ptr;
> +	s32 tid;
> +
> +	do {
> +		/* Outer loop for solving arrow operator ('->') */
> +		if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
> +			trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
> +			return -EINVAL;
> +		}
> +		/* Convert a struct pointer type to a struct type */
> +		type = btf_type_skip_modifiers(btf, type->type, &tid);
> +		if (!type) {
> +			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> +			return -EINVAL;
> +		}
> +
> +		bitoffs = 0;
> +		do {
> +			/* Inner loop for solving dot operator ('.') */

one thing that's not totally clear to me is what combinations of '->'
and '.' are supported. It looks like parse_btf_arg() handles the outer
'->', but the comment seems to suggest that we expect only '.'
so foo->bar.baz, not foo->bar->baz.

> +			next = NULL;
> +			is_ptr = split_next_field(fieldname, &next, ctx);
> +			if (is_ptr < 0)
> +				return is_ptr;
> +

So if the above is right and we want to reject multiple pointer fields
like foo->bar->baz, shouldn't we error out if is_ptr == 1 here?

> +			field = btf_find_struct_member(btf, type, fieldname);
> +			if (!field) {
> +				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
> +				return -ENOENT;one
> +			}
> +
> +			/* Accumulate the bit-offsets of the dot-connected fields */
> +			if (btf_type_kflag(type)) {
> +				bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
> +				ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
> +			} else {
> +				bitoffs += field->offset;
> +				ctx->last_bitsize = 0;
> +			}
> +
> +			type = btf_type_skip_modifiers(btf, field->type, &tid);
> +			if (!type) {
> +				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> +				return -EINVAL;
> +			}
> +
> +			ctx->offset += next - fieldname;
> +			fieldname = next;
> +		} while (!is_ptr && fieldname);
> +
> +		if (++code == end) {
> +			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
> +			return -EINVAL;
> +		}
> +		code->op = FETCH_OP_DEREF;	/* TODO: user deref support */
> +		code->offset = bitoffs / 8;
> +		*pcode = code;
> +
> +		ctx->last_bitoffs = bitoffs % 8;
> +		ctx->last_type = type;
> +	} while (fieldname);
> +
> +	return 0;
> +}
> +
> +static int parse_btf_arg(char *varname,
> +			 struct fetch_insn **pcode, struct fetch_insn *end,
>  			 struct traceprobe_parse_context *ctx)
>  {
>  	struct btf *btf = traceprobe_get_btf();
> +	struct fetch_insn *code = *pcode;
>  	const struct btf_param *params;
> -	int i;
> +	const struct btf_type *type;
> +	char *field = NULL;
> +	int i, is_ptr;
> +	u32 tid;
>  
>  	if (!btf) {
>  		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> @@ -416,6 +526,16 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
>  	if (WARN_ON_ONCE(!ctx->funcname))
>  		return -EINVAL;
>  
> +	is_ptr = split_next_field(varname, &field, ctx);
> +	if (is_ptr < 0)
> +		return is_ptr;
> +	if (!is_ptr && field) {
> +		/* dot-connected field on an argument is not supported. */
> +		trace_probe_log_err(ctx->offset + field - varname,
> +				    NOSUP_DAT_ARG);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (!ctx->params) {
>  		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
>  					     ctx->flags & TPARG_FL_TPOINT);
> @@ -436,24 +556,39 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
>  				code->param = i + 1;
>  			else
>  				code->param = i;
> -			return 0;
> +
> +			tid = params[i].type;
> +			goto found;
>  		}
>  	}
>  	trace_probe_log_err(ctx->offset, NO_BTFARG);
>  	return -ENOENT;
> +
> +found:
> +	type = btf_type_skip_modifiers(btf, tid, &tid);
> +	if (!type) {
> +		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> +		return -EINVAL;
> +	}
> +	/* Initialize the last type information */
> +	ctx->last_type = type;
> +	ctx->last_bitoffs = 0;
> +	ctx->last_bitsize = 0;
> +	if (field) {
> +		ctx->offset += field - varname;
> +		return parse_btf_field(field, type, pcode, end, ctx);
> +	}
> +	return 0;
>  }
>  
> -static const struct fetch_type *parse_btf_arg_type(int arg_idx,
> +static const struct fetch_type *parse_btf_arg_type(
>  					struct traceprobe_parse_context *ctx)
>  {
>  	struct btf *btf = traceprobe_get_btf();
>  	const char *typestr = NULL;
>  
> -	if (btf && ctx->params) {
> -		if (ctx->flags & TPARG_FL_TPOINT)
> -			arg_idx--;
> -		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
> -	}
> +	if (btf && ctx->last_type)
> +		typestr = fetch_type_from_btf_type(btf, ctx->last_type, ctx);
>  
>  	return find_fetch_type(typestr, ctx->flags);
>  }
> @@ -463,17 +598,43 @@ static const struct fetch_type *parse_btf_retval_type(
>  {
>  	struct btf *btf = traceprobe_get_btf();
>  	const char *typestr = NULL;
> -	const struct btf_type *t;
> +	const struct btf_type *type;
> +	s32 tid;
>  
>  	if (btf && ctx->funcname) {
> -		t = btf_find_func_proto(btf, ctx->funcname);
> -		if (!IS_ERR_OR_NULL(t))
> -			typestr = type_from_btf_id(btf, t->type);
> +		type = btf_find_func_proto(btf, ctx->funcname);
> +		if (!IS_ERR_OR_NULL(type)) {
> +			type = btf_type_skip_modifiers(btf, type->type, &tid);
> +			if (!IS_ERR_OR_NULL(type))
> +				typestr = fetch_type_from_btf_type(btf, type, ctx);
> +		}
>  	}
>  
>  	return find_fetch_type(typestr, ctx->flags);
>  }
>  
> +static int parse_btf_bitfield(struct fetch_insn **pcode,
> +			      struct traceprobe_parse_context *ctx)
> +{
> +	struct fetch_insn *code = *pcode;
> +
> +	if ((ctx->last_bitsize % 8 == 0) && ctx->last_bitoffs == 0)
> +		return 0;
> +
> +	code++;
> +	if (code->op != FETCH_OP_NOP) {
> +		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
> +		return -EINVAL;
> +	}
> +	*pcode = code;
> +
> +	code->op = FETCH_OP_MOD_BF;
> +	code->lshift = 64 - (ctx->last_bitsize + ctx->last_bitoffs);
> +	code->rshift = 64 - ctx->last_bitsize;
> +	code->basesize = 64 / 8;
> +	return 0;
> +}
> +
>  static bool is_btf_retval_void(const char *funcname)
>  {
>  	struct btf *btf = traceprobe_get_btf();
> @@ -500,14 +661,22 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> -static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> +static int parse_btf_arg(char *varname,
> +			 struct fetch_insn **pcode, struct fetch_insn *end,
>  			 struct traceprobe_parse_context *ctx)
>  {
>  	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
>  	return -EOPNOTSUPP;
>  }
>  
> -#define parse_btf_arg_type(idx, ctx)		\
> +static int parse_btf_bitfield(struct fetch_insn **pcode,
> +			      struct traceprobe_parse_context *ctx)
> +{
> +	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +	return -EOPNOTSUPP;
> +}
> +
> +#define parse_btf_arg_type(ctx)		\
>  	find_fetch_type(NULL, ctx->flags)
>  
>  #define parse_btf_retval_type(ctx)		\
> @@ -775,6 +944,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  
>  			code->op = deref;
>  			code->offset = offset;
> +			/* Reset the last type if used */
> +			ctx->last_type = NULL;
>  		}
>  		break;
>  	case '\\':	/* Immediate value */
> @@ -798,7 +969,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
>  				return -EINVAL;
>  			}
> -			ret = parse_btf_arg(arg, code, ctx);
> +			ret = parse_btf_arg(arg, pcode, end, ctx);
>  			break;
>  		}
>  	}
> @@ -944,6 +1115,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  		goto out;
>  	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
>  
> +	ctx->last_type = NULL;
>  	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
>  			      ctx);
>  	if (ret)
> @@ -951,9 +1123,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  
>  	/* Update storing type if BTF is available */
>  	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
> -		if (code->op == FETCH_OP_ARG)
> -			parg->type = parse_btf_arg_type(code->param, ctx);
> -		else if (code->op == FETCH_OP_RETVAL)
> +		if (ctx->last_type)
> +			parg->type = parse_btf_arg_type(ctx);
> +		else if (ctx->flags & TPARG_FL_RETURN)
>  			parg->type = parse_btf_retval_type(ctx);
>  	}
>  
> @@ -1028,6 +1200,11 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  			trace_probe_log_err(ctx->offset + t - arg, BAD_BITFIELD);
>  			goto fail;
>  		}
> +	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
> +		   ctx->last_type) {
> +		ret = parse_btf_bitfield(&code, ctx);
> +		if (ret)
> +			goto fail;
>  	}
>  	ret = -EINVAL;
>  	/* Loop(Array) operation */
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 01ea148723de..050909aaaa1b 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -384,6 +384,9 @@ static inline bool tparg_is_function_entry(unsigned int flags)
>  struct traceprobe_parse_context {
>  	struct trace_event_call *event;
>  	const struct btf_param *params;
> +	const struct btf_type *last_type;
> +	u32 last_bitoffs;
> +	u32 last_bitsize;
>  	s32 nr_params;
>  	const char *funcname;
>  	unsigned int flags;
> @@ -495,7 +498,13 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),\
>  	C(NOFENTRY_ARGS,	"$arg* can be used only on function entry"),	\
>  	C(DOUBLE_ARGS,		"$arg* can be used only once in the parameters"),	\
> -	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),
> +	C(ARGS_2LONG,		"$arg* failed because the argument list is too long"),	\
> +	C(ARGIDX_2BIG,		"$argN index is too big"),		\
> +	C(NO_PTR_STRCT,		"This is not a pointer to union/structure."),	\
> +	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
> +	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
> +	C(NO_BTF_FIELD,		"This field is not found."),	\
> +	C(BAD_BTF_TID,		"Failed to get BTF type info."),
>  
>  #undef C
>  #define C(a, b)		TP_ERR_##a
> 
> 

