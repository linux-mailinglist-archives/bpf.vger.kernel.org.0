Return-Path: <bpf+bounces-3168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B85D73A712
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE3E1C2115B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C3200C4;
	Thu, 22 Jun 2023 17:18:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66619200A8
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:18:18 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4373F173F;
	Thu, 22 Jun 2023 10:18:17 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MBC8ID016937;
	Thu, 22 Jun 2023 10:17:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Jb5wBFQmJraBK/93LnMywhE/RiIU6Sd1fM1H1JtFRjc=;
 b=CbmZZsQD1qxRN3u4TZElUwSFztxiwEsjrz/hAFF9z73xVjCwOFC5QmYMX68hu2+eCOu2
 5VeUgYm2YApAkfOPluYCcvyJhwYB+nTEwXjEashx5HOAnBI55Xa27sYFDODDM5XrI+91
 jl2jmPGxIld62QSLc9fYfymNiuyTi9DiDaEqFi+rOsN1+48/Lf4MapSuvsRkBr+2TxyU
 Y/tzT+vgrDOWNypT5Lx7BdY+n3BkKspwSPEbcFMaQd1emIoyWOnrQL+klIkJ+Y/CPOnI
 ZOuDy/ZIOf1RNVJQA+X81y2PUvy9lmbI3ecviV4nM8zqNIMOeSiTFG6fEop9E62BpIBb zw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbwvnw9um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 10:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKHLtF1UkUJQu12H34yPrQbsvTtGIa47U55mqyyeKR2M0xF2HhqD+QVymxovvq0pqlnyyBK/ChyJh8ltp7p8SzVTZSh4tVPd40/mH+Quxv97geBiXtTsuHbEORN7cYfu6iPmxsvIG15khJ2LlOIaXrCw+8Yvs9gukWtMcn12tdFL4NMywKiLNwOW6nKojV0ZVayzjc1Cc/b6+jvkdshm6m0Pd2qC3SxgetfecfpbI0B/H6zxHweirqSHJiyvaDOinx8y5TveQLf2Kf0jbBShdCHlMJF39omec2Fd66IqHHeBf0KVhdp71S0/gLuFwbg3bfrIWJ6ISm7KFcRVg4abFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb5wBFQmJraBK/93LnMywhE/RiIU6Sd1fM1H1JtFRjc=;
 b=JyZcduD+u6tTTrsn9xViG7qT0Svlct4aKgQKjOV1oK/r3lw/4bAO+T4WdLzI7XinhKXTMWfUfqOICnyweuGHhuHKEWxB15IMq1tNhIBK+gk+WludDnHGN5DC2fH8XPFK+m4F+2gU9NRhRAzrSCAKBVZ7/L7V0NeUJmPT0UMriFfgE9M3sNsUKmatjnLrMfqd//MypIaxm9G5SQQgMdDo90Xh1wEZxC7+MckQjSzPE1GrDT8eAcz4W+79NhivcCSZfvYzlJ3KOiXRFtzd7PSsIYbXXG8/QEf+bGLRYS+cOPVbN0M7LK/8z0G4/LZJ09JtCMJC6vUlmKU9ah+S3BZT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6051.namprd15.prod.outlook.com (2603:10b6:208:476::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 17:17:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 17:17:54 +0000
Message-ID: <afb2c82c-0276-9b3f-e5c9-326631fa233b@meta.com>
Date: Thu, 22 Jun 2023 10:17:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next] bpf, docs: document existing macros instead of
 deprecated
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230622095424.1024244-1-aspsk@isovalent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230622095424.1024244-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 1859e98b-b72c-4489-848c-08db73449dba
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EL0fLslmQQVoHlq1FfMv3lDMZ821NROLvHiqqHsytTq7UNRM3x5GpTfYjABWFIC5BWYhSA3ok97MvqrKigsFBFHmw3Hub5pEyslZwaPQ9FaJLjYinunkHpcRi3GgST1bWftx/rlCckmQMqOhy1/C6QGyJ+nO4hurKq2tONgpI/5DCKSwJqzQDdOBFv80IT0nm1zmAQ+59vL/53I87+iBDXihVemHLOqfeAc1CdMqRJFRkkb/RbjixqkQxFTlqM3H799S0BHII4q1AE2b75N7j0u2482S6jbq7Mmb6LsGNz1d+7AGE7IN+06s6YDxIAkoThvmzW8yIplRSbdC8Woh1B37DPpoO5GhFzwF6Sp+tf+GgZAskJ5gIGzDavP7URqzPIz+9hq370lABrN38DE1HvkukTAMQvxCt7oJJZN9HUGma3bfEXgo3kRcYHf3jgabFqyT3DnahKEErHRGGzdDsU98xEonfuoCdGLWktvtSo1zpGKQUrR/bhceqdRtwFg1O8GP3/CnpDL0iZYhGk2G3Wr8vHiU8ypxXz6vNy+CC6mtppiw3ruZkgMi7lp66sfeb6UHLHL3Lk1HqNOV3GnBqA+XMqMS+sVpEyN6RmFeQD8sIkgk0KLCRovRZ0Ev1F+C0EFKxULdaDD4ZrCuRU4PH0FpwA2W7s1JnEe9SKj9kDs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(38100700002)(921005)(31696002)(86362001)(316002)(2616005)(66556008)(66476007)(8676002)(41300700001)(8936002)(66946007)(31686004)(4744005)(7416002)(5660300002)(6506007)(53546011)(6486002)(478600001)(6666004)(110136005)(6512007)(186003)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHBZQytqdDc5bzBnZGdySnpZTm9mTHVTK2Y1MDRNTzk5R3diMHVEenM5YmIr?=
 =?utf-8?B?WGp3YlhQRTdqZTF5Ry94SjlzTHhjdEFQUkZWL3h1aWlCRDlWQTBRRWRHcTgr?=
 =?utf-8?B?ejJoRXJrcG02VE5KNzhjamxXT05SdkNURkpIZDVVWXMzc3FHbTlUbEdNMDIy?=
 =?utf-8?B?cFFzRWpubWVDck5iZWI4UUw3V1dRcHVLZmVraWVCRVh2ZXNWNnVSKzJ3ZUww?=
 =?utf-8?B?UGsvQ1ZiZGM3TGViblNBT1ppOGFlOW14SHF5ZUdESnpBQjZGbjJ2RlI5UE5E?=
 =?utf-8?B?dC9yRkVHTEdoY2VEQkpHRDNVOTltVmJ4UXhpUnhrbWZ5ZkR1cTlncU1oRVAv?=
 =?utf-8?B?emRrOVNhcEJnYnYzYmtUR2pMVGJwWVFnc2E0UDhJd05yaExsYmNQcFBvVXFs?=
 =?utf-8?B?NTVMQS9WSUM0enJVR3doaFo3a2o1bEc1N1dRTkU0T2dKM3lyblZZaGhTcE9z?=
 =?utf-8?B?aURYQWMvY3FEQVdHWmM3d0VtT2Y5ayt3di9uQkpjWmtnRjEvNWlOWVR2c3o3?=
 =?utf-8?B?bHRpdVViWjE0TzlMcTc1bVVVV1NPb3JWUEMrVWdXTEJwRURycWovVzZ4cW4z?=
 =?utf-8?B?TXk4R0hadjV3dzlXQmwrS0FPSlRZb1VEYVNxZWQvRmJjZzVpeGd6clpVZkps?=
 =?utf-8?B?bW85YmowSzhDeHJ0UUltdFFOblF2eUNCMHVJckpKclZ5dXNKMDU4bnI3Q0hI?=
 =?utf-8?B?WEZPdUFxaDlMQUlXVmJva2pMTHo2aEpiMElEc0pDMlNraVZQN1JaS0JRSHJR?=
 =?utf-8?B?cDBLYzhCRTdBNUUydkR2OWlCNkJLajJ2MlRnVk5hNGw5TWh2MFBYWHI5dFR1?=
 =?utf-8?B?ZEZSRzVaTzhOQmJIZ1JuMXJJYjFRdUtoTU1Yb1R3MlQ4WDFaYWdFb01RSUox?=
 =?utf-8?B?ZWNvNVhmcUdIblEray8zWFROa1FHNmpkanpsTUcydGZtZVZiRjUwWUZTcG1t?=
 =?utf-8?B?SzRVMkZrcE4xQS91R28waXMzUGlzalcvdlFzNGkvVjF1c3RpQk1EWHozREhJ?=
 =?utf-8?B?a1lXUUxlTFp2NzJQc3c1aXdTVUNRWWVRdzFwb1dXQTd4dnZxMTZJVnkyUlpj?=
 =?utf-8?B?Q0dQZ0k2bWF4N2tkVlM2YmhHMVhBRmRXSGthZnoxdTVrc3BnZDMyRGFqYUJC?=
 =?utf-8?B?NWFzSHgzdHVGU0pPajRIRWVRc3hIUW1DT3l6U1RnTmtMemRtek1oSFp5Ymdo?=
 =?utf-8?B?cWZ5Y3J3UFFvMjVzdDh5MnU1eWNyVjRYd3E1N2txYXhWTytKMVJrZVZjNXhr?=
 =?utf-8?B?M21hanlBK1dRRHJzYmdrYVdwUlAxb1I2Rm45RnhCZ0VyelpjR0JkMUZseFpL?=
 =?utf-8?B?emVNNTJXMjJqWnNseEV2VENxVEcyYUlSNURTYlVCVGJ0aHZ0WnVaTEZtWHVX?=
 =?utf-8?B?dVRlMkU3NFZHbThXZkk1K2RJdkIzczJ1a0luNkZqbEgzWDk1RERnOWJpaHli?=
 =?utf-8?B?MzlhcjY3d2pwZWhsOXJnbTZOaC84bDlXSXQ0eXZrRE9xaHF5NDJwZDVxZTIx?=
 =?utf-8?B?ak5lQ005elhFUVBxYVg4OUdNb2YySDZsWjluZkZpQ3UxMVNwL2s1dGZlN05h?=
 =?utf-8?B?LzlZS0cyRllsT2MxNlc2NTlULzZuVFlHUWJpRzYwc1pSVEtTOGUrT1l5YUF4?=
 =?utf-8?B?WnRlelh0MFRsQldmRmFDTW9Wb0VUSldqNW0ycFdIQUhlVXNMNW96cEx0dUM4?=
 =?utf-8?B?clQvQUU4WG9UWk9PbTlhdWFYbTNESHhMWWNwU2F2ekY4QkhUMFdqVzRpK0k1?=
 =?utf-8?B?NngzSU16cnA1TklLby9GZWdBK1IxY2lrMEdEYkRZQ2hGTHhHZXZNVm4xVkp5?=
 =?utf-8?B?YzRXeXRSck1YamN0SXJhVWljS3pVbzhocWcyYjhuV2lvaHFDUHNxam1hc3Aw?=
 =?utf-8?B?blNYV2VkWjIvL0dQbE9ZS0kyeW9EUEh0ekk0a25NdzgzeEpRWE1vNWszNHJF?=
 =?utf-8?B?MXR2Q2dTNmttcTVIOVdLeitiajRKaUlsZ3c5YXl6V05CTmFFcGtDK1huc0Qv?=
 =?utf-8?B?TVZuWEtCMldhWWNNUGRQdWZ3b2l2OUxhTzB3VWw2SlB4KzFiNnA1a2dJbW9J?=
 =?utf-8?B?MHhEQzVhcVZiSHo2eG4yNm1VdFhsbk5xZkJyN1pkdVVaMjRHRDZDTHZGS0M5?=
 =?utf-8?B?bVB3b3dTYUtYYlVCMmxKejRvSnljZzZBcVYxVmpBc3l5N1dMMjYxalFKZXNW?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1859e98b-b72c-4489-848c-08db73449dba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 17:17:54.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWaAHylpgyZ9HYvV5GJu/zb7NgqY8m+OqgPev+QFQobQPw6XO1dfZe2SoIc6VDRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6051
X-Proofpoint-GUID: ObphSsmz4ffB-E__3YM2PGqP8vkqxqX8
X-Proofpoint-ORIG-GUID: ObphSsmz4ffB-E__3YM2PGqP8vkqxqX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_12,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/22/23 2:54 AM, Anton Protopopov wrote:
> The BTF_TYPE_SAFE_NESTED macro was replaced by the BTF_TYPE_SAFE_TRUSTED,
> BTF_TYPE_SAFE_RCU, and BTF_TYPE_SAFE_RCU_OR_NULL macros. Fix the docs
> correspondingly.
> 
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Acked-by: Yonghong Song <yhs@fb.com>

