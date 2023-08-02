Return-Path: <bpf+bounces-6696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB276CBCD
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 13:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE14B1C21263
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4C6FC6;
	Wed,  2 Aug 2023 11:31:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335263AA
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 11:31:38 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90B2689
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 04:31:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372AkvpA002500;
	Wed, 2 Aug 2023 11:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xTkZrgxtWCUhF42DaU3SL4FOTmLCXo9V2D7v9Gjh/Ps=;
 b=VVLDjLFkhGr4djCmcPSp9fTTWopTrrrZismp52E2Mrx/zc17jIXp552o6WtuAFkempTv
 UgqAUOaDERILdtzcUcJkXwOhPM8FUJmXaWD5OF/0XNB+m+lWAE57JrVIOjxThe/Kn7D5
 8vAVjMOIu16kWxs2OfgCWAqi1/5PGzDjv7UIvxUXq8dDi8BEM4rGLlXLKqsJs14a/4JY
 Cec4p6LBTNRAEsb+vL9knQONLBF0xJnO6xZmBsvtRs2i/S6gtGTF2QWDHjBUKZlmWmwD
 IqmLse+pzypcTG0AQ7HotnIwoRjhypycZk8uECevG3er7JZjYJqQg5A1mTHwWhG1E32+ 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbs2f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 11:30:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3729g9Z1020522;
	Wed, 2 Aug 2023 11:30:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7821dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 11:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktWL94AlMUTfJwL+Z9KEkv8qvvEZwJJ+92/qzTFmVpMW/KJecGRep6y4mGOBAbmVbBY5mHAiKB/JkJ8Co0zArGEJE50X1pIB2yyZdRoxPiNLUlpNZD14Cm3c0Y9FEKV0CWCskuUtNq/Ii7Wt3Frex3YIzvgHYnXe9I/L6AkpwTrKvPLlDZEgFNSjCLkcN9CwC+fAAV1rzGI7EzxOaMbcz5mFu4bH49X8vq1BKWaWJxn48GIh8WeUksP/zxrwrRf2cNfNG0BZmLb0DBwMB0pVIjlPwUZ1ggrpnZ3lsmd/37AMmnJUfyFmhwV5M39FJuM/LWQuqDuDGOVa8QUSQ6++TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTkZrgxtWCUhF42DaU3SL4FOTmLCXo9V2D7v9Gjh/Ps=;
 b=FnS2+isTC+9xAto/X/Fl3M6WPEVSOdhhk0tWVnfDIDplh51go4DaiJqskgLaaVa7grvqBrDLM+5and4vUbPG6JbHoiwqVvihCNKpRjlqKyuuBF1iJw8hPaFp80CxVCasI1tXb5/ty88rFuUJlEOLRrd3avBQ/c0vWKqq6YOQQKOEubBFZTrdKao0xO6VmgB0hoqOqzCAnPivB00wfB/LLy5JKiMbgtjutuYZLIsCZuqUN9wGqeJzeiR2efUK9kzVXFyptLVuSB8FlinojTC99VkZkSjyxB3UD7xhm6NJiT7D0YNoZQKYa5KFHYDk0CDD0pCO2K4xTwCbF3IorL5k4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTkZrgxtWCUhF42DaU3SL4FOTmLCXo9V2D7v9Gjh/Ps=;
 b=Vng0k/YSIax9c5MumTMGnfOL+KOEhQ278fvv6tBypTChZE1zpEmNQVYy8zFvX8q8szbWMx6DSaMwiNIKXXeVsjmfFVcOCWAIkHt4dm2u1nLDRAKN6w6/Osp+HKUKsOcQScJTsGS5BpIzOy+xLMjd9vKTdwXURdikoJbAkPGuD24=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4158.namprd10.prod.outlook.com (2603:10b6:208:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:30:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 11:30:42 +0000
Message-ID: <ca1c1fcf-4cc5-da44-d0ed-1bf7b6c66892@oracle.com>
Date: Wed, 2 Aug 2023 12:30:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add bpf_get_func_ip test for
 uprobe inside function
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230801073002.1006443-1-jolsa@kernel.org>
 <20230801073002.1006443-4-jolsa@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230801073002.1006443-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4df3f4-e387-4582-2d6f-08db934be772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/UZ/hIfYoYXrTy3tMJ2QccABt02Qp9iNLgaKaMyF5NcpHD9YdH/HFDlpT4tBZvb9fMEiMF2jnQWFbEros7ruZa3JZtbGrKHKZw5KANdYdtu3kBNT7kLrOyt1DIR3L4gaiP3+ItwOt/ePefOkiUuoy0fAxy4kSYcI7iFeDeQRwLRSHe4sQ2pUhBoOs6UE4zN9n/F+V1+WXFpZhF1cs1aslts7JEY1pkeSPWL//zCMsx4KDx4KE7vglSC7x+q9WcT9FgZj9qVxDIhWbVL52exCAe54oMT8zvQpjUYGZPbKnootV9zB2LDHfY9B0jZ65WP3BwCRE7/StPMz2g/OYzwQbiN5A2oX0MAGyCmktVOf1QAzUmW8jNZ08Xoo4Uzj3ueExXJgTsq+46O+Kg6v90sR4zWMI5I9CxAbHNKSTswGXor4C/VjLjLYFLWLhQ95FGRSrbkxeQx6sxq43PNFMnj8FlCrz9NiBwdfgs6rI7jo2VOzYiUdVV9KHcfZ9ouSgDm6XB6rDHMybiS114wdPJVGgOTfRucJxbtx5OiLW3WzUEHgzqVI090m5ZRU67Htob7wihP/+rLWZZGeyAordNn4MqTSyQ01sWRpcY1cVuMenqBLgY+WvEUZnTqESUNAdT8+B/rF3vlo+iMhlIauAm+XCg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(41300700001)(2906002)(83380400001)(31686004)(44832011)(7416002)(36756003)(2616005)(478600001)(54906003)(110136005)(38100700002)(316002)(86362001)(6506007)(53546011)(6486002)(66946007)(66556008)(66476007)(6666004)(31696002)(4326008)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dk9kWjJmNXlXUlpybEt5QjJWK3A5bFUzOVZyZ2drS1IrK3owWEtxZTYwNEZo?=
 =?utf-8?B?WHNjWWsvajZrL0hOUEJhL214S0RzYnM0SWdYVlU2Q3VHdnBQR29RWUtHQWdk?=
 =?utf-8?B?MDhCaEd2MWdzdnAwMXhickdFYy9qSUFRcXp5VmJ6S2w2MEQ2MHFjMHVuWms3?=
 =?utf-8?B?SU50MkpxeFJZQlhza2NCbkxWSzVxVlZXc0pwMlFwaU5mbW80aTN2SUpySXNH?=
 =?utf-8?B?SUtobzBYUkRDTmlyd0lsaFpKcTVHVHFnNm9zdEhOREV1c0ovWmxyM0VseHd0?=
 =?utf-8?B?VkRkQ0g0ejZSYnRKeWhvYjFQWExmUTYvY1JRbElCbzhlMzNReG1vVUxnT3U3?=
 =?utf-8?B?VFJVeUFLRG9vYjhWQVR4N0FlcHduS0VPT2VCa09oZmEzRkFXT2hFa0dpelcy?=
 =?utf-8?B?Yld4R2N3MHBTS1ZWYWVWTWxQQzEzWi9TclVWeWhpZXpoRW1hVmVjY2h2OGJs?=
 =?utf-8?B?cWZhdkt6ZVl2dkpVTDZLSUZmM2ZHK2dhTlM5cEc3OWZRb3MxSCtCc0VHaTc5?=
 =?utf-8?B?bFMwclN0Z0R1RzNuRnhJY1YyN3d0MlVjSkJBcDFtOUhLQU10anV4THZIYXlH?=
 =?utf-8?B?YVhicmcvcVNmTzRRYnMraXZRL29DcjA3dW5aMFMxZjFWTTRTWUtNOElEK2Y2?=
 =?utf-8?B?aXFJc1FjdUN0ek9SVW9LbU9tWWY0UkdHYWhUQXprNFlVL2ZScHJwK1Zpa2tv?=
 =?utf-8?B?b1RTNHpjYUwvYjJES2dBbjN3dFRwbldhSkdIS1I3UmgrOEtHNWF1ditlZVFJ?=
 =?utf-8?B?RlBaWXNERHlGSVVGVWdBVVR2QjZqTEtYYVlSNmtDbjhmcFc4OVQrYzJpUklO?=
 =?utf-8?B?eTNLM2E5SUROK2VKdEFwd2F2SXZDd25uUTRRb1FlSndTN1UwMXlsZ2pwL2pw?=
 =?utf-8?B?WUhNN3ZkY0l2WDdkNnAvMWo2M240UHNjVG5vRFBGQ0psUHMvSHA0Wjl5Zkhl?=
 =?utf-8?B?bUVaZjFscVpqU0JRaWxOSjN2d3J0R0RNTjl2ZFZtRG9JUHlXTVBkdU13d0VK?=
 =?utf-8?B?QUlhYUxiWHo2RWJBWU41MytvL08zNVRvdXNkMGYwc0FCUnY2eUNjb1FhMEFG?=
 =?utf-8?B?bU0ybnhwTTBHOEtuYU5nL2M1NldwUjBRYTE1ajdMdVdUY3p1bUdXS20zWlFn?=
 =?utf-8?B?VXJpSHNKT0sxeS9lVTFJU25reHlBZ0FGU1RlckNxSHdCdUd5OFRwdGdTaDVN?=
 =?utf-8?B?ZTVPRHRPMzR3Qk0xMk1YZEppNFRXLzhMS2w1cWIvaWRzOUphaVErNXVESHlN?=
 =?utf-8?B?bmh3YmVxYXIxU2ZQc0ZNd2tkbTJOK2xHZE1KUXQ4SmlKRVgzM0VKa2kxOWJR?=
 =?utf-8?B?SlUvMG5UdWVmWE9URDZOY2xsWnhMeHdveWlhQlIvRUhzMUhKaGt5Q1RMcEpK?=
 =?utf-8?B?QURmNmtxMys5RjVKbmVtbVdpWHBmVnppSDM5dWhBRTV0ZmVzK2NtYzYwaUww?=
 =?utf-8?B?Wkc5RVNBbnhYb1gwZi9MMHBFeWZuK05qdWhkZUI5NnVKWVVWZHF5cjExeHd2?=
 =?utf-8?B?dE9UMGs4Mkt3Y2tLQjQzVFQ1cmFQUmJ3R1dkOC9GT0M0djZQVWVXaDBBZ2lu?=
 =?utf-8?B?RUVPNWUwVE1xN3llSEx2d2t1djlpR2JvWWxmak0zVUErVWhOeklseW53aTk1?=
 =?utf-8?B?aTQ1cGV3S1E3RWhYV1ZENFd0bjdtck44cE1GSU12TEp5QTFpQWxacUttVFQw?=
 =?utf-8?B?VlVmeEJuUW9Nck51YVN4T1ZCOFJQVEQ2NXRGb1hhY0tMWFNhZTI4eTl3WHhs?=
 =?utf-8?B?ZzNjdm5oa3lXcGZkNGxGaHdrS2hTK1Q3WFp1Z0ZUNlFQYWIvUG9hQ2pRSGRk?=
 =?utf-8?B?cE54SkRKQWZuYXo2UCtBSWlMM1FwUmR3TTRsbVNMQUE2MUJzaVk3OXFRTWsx?=
 =?utf-8?B?TksxSGhML09VbS8xazFscGVtVG8wYk1OanVxZkYzVVkwRjFMamptWVJVb1Z4?=
 =?utf-8?B?MDRTa3VzOVpwdXNNZWFUd0hlZVJ4V1l6L3RsR2tFNUNtSGUxaUtWb2ZKclFC?=
 =?utf-8?B?SlRIU2JoUWJleU9BZTV4VU1zc1V3UDJRN3h2dk5JdlovK3BSU1BpTUlMQXlM?=
 =?utf-8?B?c0RvamR3Rmt6em1OYmZmQ3IvUSs3ME9jNDdsaGVtcGR2OGlya1JjbnV6NlZ5?=
 =?utf-8?B?bXYxbHN5RnVtMG1oNXl3YTZ4QTZDKytocEE2R3NMY1pnaDF5ZXJvVEVaM1BW?=
 =?utf-8?Q?ooXqhKM/xRNNVXwnxyH/t7U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?L3Z5UzJPcWRLZlhqZkNiSFQyblNSbVltcDk1N1pVK05UZklWakIrbXFNT0p5?=
 =?utf-8?B?S2JTZW8yRjhuRUNrdkZ5dFN6Zm1pZFFDd0NOLzZzVTYyemhIRWZqSXNWQmY5?=
 =?utf-8?B?LzRzTjRmUlNHaXRhZ1lVZGlZeVZjbFhBYlN6Yks3dWQ3UHlNNXpUbjNwbkV0?=
 =?utf-8?B?bVZZUVhrMkxlc3JuOFlSS0hCd1l5ZWNzcnUyY2t1Zi9vUDNFMnM4d2kzWXQ4?=
 =?utf-8?B?VGVRZjV1V1IvSFhZcnF4Qk5uWk1HRUNFWWx0QWpUdElDWFkvNTVxZCsvUGRx?=
 =?utf-8?B?QTdzNTlOMElXWS9Wc1ZFTjFONElxRjJQdktibjRVSithOUt5VUw5djB5aDRi?=
 =?utf-8?B?MUFRZHdiQ2hhWlJwakNnM2JkMCtHTUF2N2wreEVDb3VpcEloc1p4YXkrcXdt?=
 =?utf-8?B?d1VjcVpkVlVVUlhva3ljdlN0M1dNQWN6dW9WWEtyQXY2K3pDdWR6NWJtNXZh?=
 =?utf-8?B?OTNURnFOUXZRUjRYdjJsNG9CcGpkZFhQaldBRjJSNUFrdjY1UExIOVFNWnpM?=
 =?utf-8?B?UVM5ZGphTzJidWRzeVUvU2tEZGgrNklzeDc3eGxGVUw1OXBLWmlUeG5GMy9X?=
 =?utf-8?B?eEN4c1hTaFhNQ0szd3FENGYzUkNyR0hDQ0ZuR1VLbWFtTlpkSEdsWVBRTWEy?=
 =?utf-8?B?SStYelBNa0lpR2RuQTBQS1BsbmdWVVZzb0ord2lEL1pMbEFNditFWjRWY3ZO?=
 =?utf-8?B?Qm85ODE1TVZLeXhGaVFUckxRUzAwVExjTzl3M0NFcHFnWGx0SG95Sk5OUExO?=
 =?utf-8?B?MVIreDdIYldhcWFxM0pQb0hkcEUyazg5d1F0bnJhc3czV0RGN2lCVmQzM08x?=
 =?utf-8?B?WlBXMFFoUFBVWEJtNDBCaXZES1V6T2szMzl0YS9lRFc2VXgyaW50Q3VPNkxk?=
 =?utf-8?B?dXVnMncyU2ZQZUFUOUpDSGRnSXlqT1pjSC9LRzBsR3hWK2pueGF4V1NyVERI?=
 =?utf-8?B?ay9nSjZOamVYV0NUM2pTa1E3NUVlNDVNV3BzbXRFYU5qM001UTFwb1NQdVpv?=
 =?utf-8?B?aml4Z0UzQWh2aEtRQWRESFpFUk1qNmd2YnR5Z1RJcDFzR1ZvZTIyMXRoeS8r?=
 =?utf-8?B?elhxWHlMR0lpMkdibVMwVDBaSkQvbVFxZzZmUUFRYUNSZm4zbzNhd2N1TXpU?=
 =?utf-8?B?M0NLRGZNSk9MalhMcWszMW95a3p0R2R0UVQ4K1l1NHVLVjNIN0lTTUFXTUpJ?=
 =?utf-8?B?b25zY2htSENYY1U5MmRCUEJ1TWYrZkovZWdJVndkanE1S1JnRXZtYjhwc3Nx?=
 =?utf-8?B?c0lkQWZ5NE9vZVBGS1locENNcjZPWDVLNGNIM3FWUDNJVWdoQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4df3f4-e387-4582-2d6f-08db934be772
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:30:41.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waB7DriGQX3OVLMK4XuLr3Lo7qTLohX72u8KqfFi4Nd33YTwm8WorQXenoqmw+57rnraD1u+Ol/yUcL25JjlkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020102
X-Proofpoint-GUID: prYuyJcWOaQ5xGQ3Dn0-8Sk2UZRgMImr
X-Proofpoint-ORIG-GUID: prYuyJcWOaQ5xGQ3Dn0-8Sk2UZRgMImr
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 08:30, Jiri Olsa wrote:
> Adding get_func_ip test for uprobe inside function that validates
> the get_func_ip helper returns correct probe address value.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/get_func_ip_test.c         | 40 ++++++++++++++++++-
>  .../bpf/progs/get_func_ip_uprobe_test.c       | 18 +++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> index 114cdbc04caf..f199220ad6de 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> @@ -55,7 +55,16 @@ static void test_function_entry(void)
>   * offset, disabling it for all other archs

nit: comment here

/* test6 is x86_64 specific because of the instruction
 * offset, disabling it for all other archs

...should probably be updated now multiple tests are gated by the
#ifdef __x86_64__.

BTW I tested if these tests would pass on aarch64 with a few tweaks
to instruction offsets, and they do. Something like the following
gets all of the tests running and passing on aarch64:

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index f199220ad6de..61ac13508c58 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -51,10 +51,10 @@ static void test_function_entry(void)
        get_func_ip_test__destroy(skel);
 }

-/* test6 is x86_64 specific because of the instruction
- * offset, disabling it for all other archs
+/* tests below are x86_64/aarch64 specific because of the instruction
+ * offsets, disabling them for all other archs
  */
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
 extern void uprobe_trigger_body(void);
 asm(
 ".globl uprobe_trigger_body\n"
@@ -82,7 +82,11 @@ static void test_function_body_kprobe(void)
        if (!ASSERT_OK(err, "get_func_ip_test__load"))
                goto cleanup;

+#if defined(__x86_64__)
        kopts.offset = skel->kconfig->CONFIG_X86_KERNEL_IBT ? 9 : 5;
+#elif defined(__aarch64__)
+       kopts.offset = 8;
+#endif

        link6 = bpf_program__attach_kprobe_opts(skel->progs.test6,
"bpf_fentry_test6", &kopts);
        if (!ASSERT_OK_PTR(link6, "link6"))
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
index 052f8a4345a8..56af4a8447b9 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
@@ -8,11 +8,17 @@ char _license[] SEC("license") = "GPL";
 unsigned long uprobe_trigger_body;

 __u64 test1_result = 0;
+#if defined(__TARGET_ARCH_x86)
+#define OFFSET 1
 SEC("uprobe//proc/self/exe:uprobe_trigger_body+1")
+#elif defined(__TARGET_ARCH_arm64)
+#define OFFSET 4
+SEC("uprobe//proc/self/exe:uprobe_trigger_body+4")
+#endif
 int BPF_UPROBE(test1)
 {
        __u64 addr = bpf_get_func_ip(ctx);

-       test1_result = (const void *) addr == (const void *)
uprobe_trigger_body + 1;
+       test1_result = (const void *) addr == (const void *)
uprobe_trigger_body + OFFSET;
        return 0;
 }


Anyway if you're doing a later version and want to roll something like
the above in feel free, otherwise I can send a followup patch later on.
Regardless, for the series on aarch64:

Tested-by: Alan Maguire <alan.maguire@oracle.com>

>   */
>  #ifdef __x86_64__
> -static void test_function_body(void)
> +extern void uprobe_trigger_body(void);
> +asm(
> +".globl uprobe_trigger_body\n"
> +".type uprobe_trigger_body, @function\n"
> +"uprobe_trigger_body:\n"
> +"	nop\n"
> +"	ret\n"
> +);
> +
> +static void test_function_body_kprobe(void)
>  {
>  	struct get_func_ip_test *skel = NULL;
>  	LIBBPF_OPTS(bpf_test_run_opts, topts);
> @@ -90,6 +99,35 @@ static void test_function_body(void)
>  	bpf_link__destroy(link6);
>  	get_func_ip_test__destroy(skel);
>  }
> +
> +static void test_function_body_uprobe(void)
> +{
> +	struct get_func_ip_uprobe_test *skel = NULL;
> +	int err;
> +
> +	skel = get_func_ip_uprobe_test__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "get_func_ip_uprobe_test__open_and_load"))
> +		return;
> +
> +	err = get_func_ip_uprobe_test__attach(skel);
> +	if (!ASSERT_OK(err, "get_func_ip_test__attach"))
> +		goto cleanup;
> +
> +	skel->bss->uprobe_trigger_body = (unsigned long) uprobe_trigger_body;
> +
> +	uprobe_trigger_body();
> +
> +	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
> +
> +cleanup:
> +	get_func_ip_uprobe_test__destroy(skel);
> +}
> +
> +static void test_function_body(void)
> +{
> +	test_function_body_kprobe();
> +	test_function_body_uprobe();
> +}
>  #else
>  #define test_function_body()
>  #endif
> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> new file mode 100644
> index 000000000000..052f8a4345a8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +unsigned long uprobe_trigger_body;
> +
> +__u64 test1_result = 0;
> +SEC("uprobe//proc/self/exe:uprobe_trigger_body+1")
> +int BPF_UPROBE(test1)
> +{
> +	__u64 addr = bpf_get_func_ip(ctx);
> +
> +	test1_result = (const void *) addr == (const void *) uprobe_trigger_body + 1;
> +	return 0;
> +}

