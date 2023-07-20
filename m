Return-Path: <bpf+bounces-5560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A4675BAAC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84651C215B4
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6166168C9;
	Thu, 20 Jul 2023 22:35:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231714011
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 22:35:00 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C01719;
	Thu, 20 Jul 2023 15:34:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMe0H012856;
	Thu, 20 Jul 2023 22:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=d8iBccTZsE2x1vqnXrh2K1Jfv9YhMpylpPCPtMDtGqM=;
 b=x3xe1OeQGtvy7+IQ0Kiv27I53j0R29sfU7jC3KFV4enyUo6BcoyuElpn4NcFbF7C5iks
 JkLzRsEFbnm4ndTOzh611Kndtqh4ZvxtOqexBB1CK9+on596WGSv1hKRF7KJY5CeUUJV
 6uo4ajMVUALYiMJ8rEkSPVzTmZ+gzB57zrcqW4zUQgiWeVl72cXoxGA9JemAfZH3Fg98
 dWNvKY1Wj+4r1q+JtNIulk3KCfs0w0NfEOCxeyaInoQ50BM0DSp1j7xwUYENxuInV8s5
 XXTtgUM3scjWPSDuEiGl5KX74RKPkP5wxZpZf3ini6YQHkqyYeeoD2/DtGuIAlMfeoSJ qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a2x64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 22:34:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KMAutL000851;
	Thu, 20 Jul 2023 22:34:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw99u1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 22:34:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjMelayvPEx2JXIGHddHX7IIihr5DCz/IraN6qKC3bYsZKQ1Her376O5aQfRpgNDkemAVLgO2Tfj7MitZZ8gQkGqetQmIWXkzbazTXJnRPf/MRjJmXBQAZWnIrtLoOJBwUecoSi6Q3ddyFk4mIfRCZxfbd8SJktQnlDbPPqTJZOrc9TpQgmZ5K24QQaLbe4I9kIq7csbvUycvb/1YZzUNJb5GqL8fk6CeMhlkVIFuSzQCaOVzd4UV7Q9U04eZLt2hfYLpZXpp9mUuHaydaxrQmdsMBayr5Bqj9pH9KPyQNBHKSDaIPnfVUzSYF85aTO9GSOqYfSkK9LCXvBQwzpjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8iBccTZsE2x1vqnXrh2K1Jfv9YhMpylpPCPtMDtGqM=;
 b=GTRWs1HmlZ7aeI2yUz76tzaJUKSdLibnwwtM3P1f2JbxZ1gAhDa/syuG5BIhWwnME3PF1R87cYw2SyXf5XW0DukfxfCm7MZSIOdGwSw/R4q8Om2772dimq9mx+yeGbFU5rj+Y6xYc9wWt2dp94dM6IOl11mzb9Sd4I+2p46jVaxlJhauVM6nO7JXSpn65OlQARZz7VkwI+5qnmnqV+gM21FD5K+GCHkrVkXOVWflyN2dRI5NwnglEyjuzgQiyrDjAuy/wI+3WFBNGWVCXPWxIoFNOhT+LN/yi2fGGnF074RbQZ0RSEyp9WahjR3O0X0KHKDHUmHGebp2qsnaejo5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8iBccTZsE2x1vqnXrh2K1Jfv9YhMpylpPCPtMDtGqM=;
 b=Kdb4Y9RzNBbM8ZxpAt/IJyzw1ePansnYQV79RgfWZFGvlEITgetduaL7SacBfB6yIVj21sN49Wkk3jrWSj/bZDIGiFMqZ56Vde4nZqbjaxYz3lasjShZFOE5/LE+tdFbvH9XZ1fbyEdmbhUucW6HU47plcPmzpzgcjxSBqW8R7M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB7516.namprd10.prod.outlook.com (2603:10b6:208:44f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 22:34:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 22:34:48 +0000
Message-ID: <dbb5500e-f623-77fb-2606-c3073371e979@oracle.com>
Date: Thu, 20 Jul 2023 23:34:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960742712.34107.9849785489776347376.stgit@devnote2>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <168960742712.34107.9849785489776347376.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ac174d-069f-4ec9-0937-08db8971862c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oVi/X56bzIOUoHNxv0nRiNhu69qYt9sBw35q1Ouhr/QfI+nssegkUhAZuiZiqAvk2reTzAphP+01/UBAE0UAUq8UpiEByurlkpMVyZeligGc4EHws09kT9yf6dhRau+aJJwJw9pmaecmAe69HyU8S9DW+gaaWKhfsjzHfc5oU6ckQ/GFXM3W5lhZ7h04jSAwD7DiYLqGnqSGqB3NAPoEizuclZvxy2/xJnIaujPCuBMACILTH2/Og6sY+SbJNMDnm30OvRvfAIGGxUHwq7lJGh6lb6ewdUJpOtTJtiDZO9ZmftoX2ja6W5O5WWm7z9P1elNnsIIHbEaScjXCuT9QE5AntAnSbFDRGiB9DkfWaFFnuLqAmIhX1YMN3Ap9ezoVTONt45h4pxhtSQCZAZDnxSa7cnxDmYdXQZgJ7yBEytpLnp6p7RI2aFiKCh+yHZhJlWSpFqm2fojIPb6Tibi//+YoOKBCtgAco3OBpgGaboSwCP3KRDfWpeKFmftwwNYQ8sPmhdYjkEm5/pjqtSgp3Scs16b4IaVD1U8wvYKQRFdcfNcGXOUD1yYcN8mK3fS9Kt0c8C99P4Meb/tUh+ozqHLgs44I11LK1ePgeABHX9FtYf1/3HgbZ5wCCLqz47/XF2BaWcC1DtaAQeagdOn/hQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(5660300002)(44832011)(66946007)(66556008)(4326008)(66476007)(41300700001)(8936002)(316002)(8676002)(86362001)(36756003)(2906002)(31696002)(6666004)(6486002)(478600001)(186003)(31686004)(53546011)(6506007)(54906003)(6512007)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cm5PcUZ5SG9OY0htZFBnTENzakpBY0xwV3RySDVnRm5ZK1JkcEx1b2tkSFNu?=
 =?utf-8?B?VnNtYitpYk1zMy9kenVDMVdGQTJibUFTNUJjTHFZUkxTV0dISHdqbDJNM0ky?=
 =?utf-8?B?NjBQemlmbVBObHJXbkNlYW1GLzhhVWIrcllQcE9PR3BnbmdRNjVTQUFKUXZj?=
 =?utf-8?B?YmVqUVgwNDcvU2hDZTZqbkhLbHFCTDhEcm9oMWh3a0MwSEF2NjlzL1pOa0lr?=
 =?utf-8?B?OU4yMEVqdXVORmJwQ2w2NEYwWmdyTGU2N3REVHlVYUJaN25Pdi9BdlpQTm1w?=
 =?utf-8?B?OEpGQThGaDRPUnpVRkFLRlg2bHY4TmozUFRGMWluSjNwR3NsYW9DVnZPTExu?=
 =?utf-8?B?eUNTdUNldVlPclFWazYyaDJVcFJnMXR6d2RBVmt3TU02dGdTWXgxZm9LajBs?=
 =?utf-8?B?Sy9kZStXSUNIQW5TM3FQcnlmb0lyK2lGektLL2ViMnJoMUUzWGpPT0RlWG4v?=
 =?utf-8?B?NlBacWFkaHlsNFJoRFlJaFJLUXM3RFR2RHMvVG9aKzIrMW5RSGJySzVaOThT?=
 =?utf-8?B?NFNCMkdyZ1lhaDdkc2VETUo5VUNVMDkrR1M1ZkJ2bTBML3ZwK2wrYW5xRERK?=
 =?utf-8?B?QngwdE9maUhKUUVGK1NHUm1QQUliamJPRkR4Umx2by8wTGlDMWkwZklOeGl3?=
 =?utf-8?B?ajViV0Y0L0hiN1YyK3lmQUQ0N29KTFNzUUFEZ1Q5TFdGV2tqSHRqckZENGNJ?=
 =?utf-8?B?bjI0NTNBWjVQcXcxT0U0QVZBeHRQUTFycmg2dWk3cWpjN0ErMVZBQVVFeExG?=
 =?utf-8?B?RWUxVjQ2T0FtRE9oMS9tek1QTlAyeTFXS1pEVWZKZC80NnUxZjEwNWIvR3pY?=
 =?utf-8?B?Um5YQTVqZnlCeTQyZEdQa1ZXVlNjMDFXc1lqS09Hcjhaa0lKNllJN0lpMkMr?=
 =?utf-8?B?bHNkQjNFcWpDTURGanpnY3lsSWZKMkZhWTBWTWNjODdWUFZ2WFZwWlJ1TCtK?=
 =?utf-8?B?bUYrTURaMHNzVWw3UDVObExFRXIxODlBRERxL21nanFSVzBmMk93aG5NNEhZ?=
 =?utf-8?B?NWx6dXFyTDB1dDg2L3NqR2Z0SkY0QU5nRjE2dDNWVUZCMjdRQzMxdGRBc1Vy?=
 =?utf-8?B?cG5xRzU5QjU0V3EzWG5sVEV4QVQ1Q0hGT0FDdkNmS2tvMTUrQ1I3R2ZFcVZY?=
 =?utf-8?B?MnVqT0dTWXhkcjlScnhOaWtqbDBUR00wVGdIWTFMYnVadmFkYjVKU1Q4N1Fa?=
 =?utf-8?B?TjViY1d2UmZJdC9mazFSbTBqbk9BTmhYWE9yUVd5N3BzSlROUkpYb2RIb2hJ?=
 =?utf-8?B?bWY3RkpmL3RhMW1jRUFKYlRTdGxmV2FVQnFrdFJISjFyNjFzS0Q2Sy9mZVZX?=
 =?utf-8?B?VzdaWC9QWTFBRkRFVU5kS3h1UW5mTGlRWFJRMXp2SE5sY1NNbnJWMmZMeHI0?=
 =?utf-8?B?WXBxcUNiSVZaWU1jQmlvUitaNEVhWjlvSGtQbHJFSGdjdjZVT2ZCMURoSEg5?=
 =?utf-8?B?cGhrT1hMQmlBeUJzRVJIZkE4WEE2Yzd1VVhxMlJWL0t3dFdNL0l5SFN3T0tG?=
 =?utf-8?B?T3BBY3RIWHVRY3BYdGJpb3EvVCtjSTJxS21xN0NpRkYwNG5zaHo0cUd3S3g0?=
 =?utf-8?B?QkJuTVk4NHVGbzlQeGUxL0o4enZ5Qnp4dUtMaVA5WkhLY3hncmFEVW55b3pk?=
 =?utf-8?B?RXAyWjBuNHZvenZkZFlNRWZHSlI3bEdKY0ZXb3Y3MnRoNWxzWjZKNDVMc3pE?=
 =?utf-8?B?eDh3UzRibWQ3SDA0SzFKT3Nua2ZHWGR6dHhHd1RTNTg5WU5MNmJsM3E2ZitI?=
 =?utf-8?B?WU1oOEZQY1JQNUEwZnNlYTZvOEd0eFVQQjJMK2JjSHd5MmlnMjlMbzI3eVVT?=
 =?utf-8?B?dmlxVXRCNm1RTlJOMElIRDBlWC9rTTdYVnhoS2ZDZVBvWUxHR0pWdlhQbjlC?=
 =?utf-8?B?aVdmYWN6SmVjcmx0VzVjY1VBcXF4Q2NabER6UWluT2dTNVZocmtDZHNmQ0R6?=
 =?utf-8?B?c3N5dlFuZS9DY09TS2xWdFFZcU5FZGU3YVVKT25MKys3a0JZdUI0bVBDdVhM?=
 =?utf-8?B?bklkaGduZkVRNzV2YU12L04xNkE4alBmak01ZjZ1VDI1SGh3L1dqVkU2di9s?=
 =?utf-8?B?dk4wcXk4NmVCMjdEcVg5NkZNUVdxTkFyL1FQL3Z2K2pieVNVVjZpVUkvUHVq?=
 =?utf-8?B?Tjkrd2VjalEvN0R6MXJkODFTbXhGRzZCa2RwOGFjdnNrUmE1OVpRME1wK3RS?=
 =?utf-8?Q?XTI6Zm+EDmnT9TQt7rB59y8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o5NF9xJrkA1+pfH00jFgEuEM2xhUgwNJZTqYgTImxHkqEukx8IvDrcpqCOrwHvm3YNBwzMJG7l28T+qlnadvRKHtGN3cJyM+yUek0G91cieVVpxbfegItpYeRAUpt5L5K3w/1zm1SKvYSDBi2iU7fh0LHvW/G7Oi8nkPhoeYn8shs/cVtLPPIsBFkWZ917epQNlCQkZ5YjvENrJu5rh059gCTg8oIOdt8+ysOScsJWrC7j4r/3yghcc7q9B2Jv/VEonP/nNK4cPcMAfFBTX8VHjqE+O0toOZnCoG5T6bP71G107QzehDqLUtf23GmiDTCHYCmP764U/7ghYkgor6Ga0o7hiWSlrIQhNnbdlQd7AG0AwxkA4IEZqXSwikRualrlgq+F2uwFY59froFleV94+GQmHGFWIB8Cm6Q/b4z2MJKOhATmTSzoP7dOwK8Tb+pdLtZQIMfeUwbqLA1aOUxZO1S+dm/BUS7BljOw08spkOFjlzyft/qHo0QEyvTt+fRlCSiqd9EkK6ehJeWMI4lejbfIpo43zsyC43p2eQNOF2BfcFWP9Dz5tHPNUF/kOYR3hw5nzfKhrdRmoFVqMHXfsT10jQnP7yxAdMg7bk32MbF8cF5/Z2xJAPZBTXT2HF8n+sT1XkiIPKVEunNyMIgO6CK+3S9Dx2ORt+mrE9U71gX0BW7NF0F800REY9Dqt2ELNVGxml/diTJSN5UlhImZ1l7MFxYz7VVhcVDnVDhx2RixHqfIs90iWR2f3xEzsHQKg+B1kscX+KmOlJ/v/AXxEjXXIPdk4aD8abKwL9CkRXU0BMQhxd7uZ3rHMZxT+vEq1hc1Z3jD84HWIpuc/DdBzjSO8w3pZTTXh0fW5UOffc2ojqbO8dJqWs4wN+YnDRb+ov8xJ/9vsjsjjlK+KYQQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ac174d-069f-4ec9-0937-08db8971862c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 22:34:48.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaIN/oGoSNsGLgvIm237It2dQlXmG0DJ5UoFpz7WPb4XPR68r7X+WaYbPukdMkp512vyOMXaUpWheKm481cpmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200192
X-Proofpoint-ORIG-GUID: qBZBmsdLrbRaUO-x9YUllAUeCJrnnXbD
X-Proofpoint-GUID: qBZBmsdLrbRaUO-x9YUllAUeCJrnnXbD
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
> Add btf_find_struct_member() API to search a member of a given data structure
> or union from the member's name.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

A few small things below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  include/linux/btf.h |    3 +++
>  kernel/bpf/btf.c    |   38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 98fbbcdd72ec..097fe9b51562 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -225,6 +225,9 @@ const struct btf_type *btf_find_func_proto(struct btf *btf,
>  					   const char *func_name);
>  const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
>  					   s32 *nr);
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +						const struct btf_type *type,
> +						const char *member_name);
>  
>  #define for_each_member(i, struct_type, member)			\
>  	for (i = 0, member = btf_type_member(struct_type);	\
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e015b52956cb..452ffb0393d6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1992,6 +1992,44 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
>  		return NULL;
>  }
>  
> +/*
> + * Find a member of data structure/union by name and return it.
> + * Return NULL if not found, or -EINVAL if parameter is invalid.
> + */
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +						const struct btf_type *type,
> +						const char *member_name)
> +{
> +	const struct btf_member *members, *ret;
> +	const char *name;
> +	int i, vlen;
> +
> +	if (!btf || !member_name || !btf_type_is_struct(type))
> +		return ERR_PTR(-EINVAL);
> +
> +	vlen = btf_type_vlen(type);
> +	members = (const struct btf_member *)(type + 1);
> +
> +	for (i = 0; i < vlen; i++) {

could use for_each_member() here I think, or perhaps use
btf_type_member(type) when getting member pointer above.

> +		if (!members[i].name_off) {
> +			/* unnamed union: dig deeper */
> +			type = btf_type_by_id(btf, members[i].type);
> +			if (!IS_ERR_OR_NULL(type)) {
> +				ret = btf_find_struct_member(btf, type,
> +							     member_name);

You'll need to skip modifiers before calling btf_find_struct_member()
here I think; it's possible to have a const anonymous union for example,
so to get to the union you'd need to skip the modifiers first. Otherwise
you could fail the btf_type_is_struct() test on re-entry.


> +				if (!IS_ERR_OR_NULL(ret))
> +					return ret;
> +			}
> +		} else {
> +			name = btf_name_by_offset(btf, members[i].name_off);
> +			if (name && !strcmp(member_name, name))
> +				return &members[i];
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>  static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
>  {
>  	while (type_id < btf->start_id)
> 
> 

