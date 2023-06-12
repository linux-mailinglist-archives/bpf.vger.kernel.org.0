Return-Path: <bpf+bounces-2419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D672C9DD
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35C1280F7C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525C1D2DE;
	Mon, 12 Jun 2023 15:23:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A151C757
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:23:34 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D4171A;
	Mon, 12 Jun 2023 08:23:18 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6mf9t025422;
	Mon, 12 Jun 2023 08:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=oInS63rIpGJltHUUgF3/mGD76ln1buXvB7mCwnbvGKU=;
 b=GL4tZIbgiiTa3oetlo/zZWloM/lTi508G33IWEQ/Ek5Yur77zamFQ1Zg6vkFwTZxLLBO
 +bQdVgnS2rcyyrWZihwpgwxxWKYpUEU+MNujj+XoFdEEMrbseCUUb43Y812M6Nlwf671
 ZNr6sMT0BkfVGs02EvDz8lZ6U9PMJefZdCmTXmn99WDy2qriYD6iVlFGtK+oMMi8VxbF
 c3lZqSq63twOp1rkDLxUfDosFxXsMuG4qj3vyeS8NPgsGDOfNKFileG39JJZdwt/MTj6
 +aCYuIahE1kU5dTUH54of9/mAL3jLHtfvbvt+MJv0i1Bc4WiRfkJgDV33bClymASPLqj ZA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5xdwjnw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 08:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcIfBCFw5KzOt9RBRuW46IsX5Nf48lh4hCoT6rjnph6GH0yyo/YSQLvqz2du3SYOtzOIqK6NURcP/15Ekk+GQxfTL3kP3POZ2h4/t73w4SIp22T0YQ6qBXYDGSorq/cQuAP/V9FOk3jdvTsOKbNjkEOxmp3o19j06Fk2AMcMpotBM2L2+ReJ/O61nsZ0Km0zNQZQgJuBxRyZwlGMJOL3nvJ9g2YDZUpm2Bcx4CUykOkOanqEshfIU5gPV2bHyPW7OnvOQ665+kdiaYbbDWU0CCJpcrBS54x9jV8huGpXLHjyLWVirt9X8wsUz5vLZrZXBxMY1Qa/wD+G/M8bYp+k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oInS63rIpGJltHUUgF3/mGD76ln1buXvB7mCwnbvGKU=;
 b=AHRwhziJncKg96xKQyvvERyk0gYxJ+7vERRDyntv6CLnC5qldZ1EWJFtX+B4zJyoWn3JzNGLcL/N4iXQeDICiQNxnhteZ1P0nasTjRrJvCGVhcB0+bFYGN6tFCRUhUMfwh0p890baQKjArxYITzt1DEGd/cGnqMKYDjlPUHerAes0rTFbGQFkDFF9yx8iQBq7a//8R7p3II2/pqeH1fyTgyGGL7jKyV0fAjDa9ki8tV/QpR/0ADxAvTqXjm6+ZlAQ+DbxHJxWDKK1IyghO60ikOnT8m85lqQnmc4WS6KFMoaGU1ZcDgZvKgflTobGX4T59EK1SRonKAtn2+RKK4uUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6067.namprd15.prod.outlook.com (2603:10b6:8:125::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 15:22:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 15:22:54 +0000
Message-ID: <2839608b-4176-2d28-f110-8923d309d9e4@meta.com>
Date: Mon, 12 Jun 2023 08:22:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Update bpf_cpumask_any* tests
 to use bpf_cpumask_any_distribute*
Content-Language: en-US
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
References: <20230610035053.117605-1-void@manifault.com>
 <20230610035053.117605-4-void@manifault.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230610035053.117605-4-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eee9106-5bb9-4ec0-2070-08db6b58e4e4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R5FD5mM1gepWGpoNLyd2cSjZMumHL41UaQrurd+GE9BZ2ffQA0DtuOYMNA+Sy1zvnXpz5vc6e0a0Bj8jSfNojTmWjysSZwHBEvVadEQTyiYmg5T0rd4Jfv2PleZFLzwR8XhOhVwBixCibITnotSt9IOE9eMbVMqM+0sKHx2W0VYTZaLXRacQvCH/7/FT6ejewNuK1ojEcwPUPbBnoLoB84wgL8q0zgMGjg10UxTzJBu2UHW4GjytnrDOG4WsmDvjn9q30RmPEMKVDZyMbZc+bMSOGboLECp8IHnJP/PzxSMS6Zw3u/abxNm2V5ZI8U6o0q5AUfE4luQod/BF6idjyxIdGbG4jGDf5fmPthU4Hu9QHLcEdNuwXlFKJZfHiplQFV8Yg4vkg+SI9lle9zAExAEy4b6Kms6qmVi+Ut1V+AYmEhoH03c7DAvrjcsVxcCTjHwc3O+NL2t2JSoBWjBP/guTUeHE8FEMO7OTf1snxI8PwWrwYdYKkYUO4AGLuhFQ01f6epjsgemFhGfzGZwkPjlKAzB60QhAXqmcNi6CiChlFq2kY0DCoIfe81Oo8fHT6ad+lTGGY/PSYWGkbXz1tYEsfZqZiQWu9Le+9tXw6O62Wndn+miJmUzDHnhlfBSnm+H1aKm39LVQcpxcmfmZIQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(8676002)(8936002)(186003)(83380400001)(2906002)(316002)(15650500001)(4744005)(31696002)(7416002)(86362001)(5660300002)(53546011)(4326008)(6512007)(6506007)(36756003)(66476007)(66556008)(38100700002)(66946007)(41300700001)(6486002)(478600001)(6666004)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXQ5c0srb3hpck4vcDFwU0VWeGxxM2Y1OHhNTFM0Wkx0dkVib3d1eHI4TXhy?=
 =?utf-8?B?SmJQNVVNaGxVTE50TmRFaTdhcERiM2NHTmhkU2JqMkZkdTlrdlN1YjhDOG5C?=
 =?utf-8?B?YUZPTG5EbVJlS1dIL3lzalpmVkdTWUNiNmFrYUdqWmFGSnpRN3l2TXdkaUZH?=
 =?utf-8?B?dlF3dDdSYUtkTlVSMnlRY3E1N3EzcnBsUXFPemlwYnZET0lLQmc1YkVPS0FT?=
 =?utf-8?B?bytGdGNKMUc0VWdFY2txSHBBcXNodWNWMTRVYWp6QWM3cnZRYkFwZElHMXlS?=
 =?utf-8?B?T2JCczVMTW5hWkdYbUJ5MElNSklJdHFGa2FrUEN0cGcxb3hnTUZIZGZxU2ZR?=
 =?utf-8?B?cU1Bbko1am9Ya1J2QUlaY0NnYXQvdEpxKzNWMVRMOFFtWHhCTWxuR1VYa3VI?=
 =?utf-8?B?NEVLbWpkK0x5WElrYWYyKzFuWVZaaUhxSkVGdlF4c0t5ZzFUd1UvNys0aC9y?=
 =?utf-8?B?VUJoZitHUW01cG40bEZneitBNkFDWkRNeGxPVUVGNWloRHZMTnJlWExRVzNV?=
 =?utf-8?B?VVVjYldIamFKZEF2WnE5dnVGU2VSb2Qxb0Rldkl2SnQ1UDRvZFp1bmFnWHFn?=
 =?utf-8?B?VW9EYWJQaFdsYVl0T0g1RVJ4WjNBMERJTStYQnhadTlwemM4ay9IOU9QK0lJ?=
 =?utf-8?B?TUNWT3hPQW0reG1oRlRRM0lwd3VmRCtkUkdTUnNLK2hZdEEvU05FMkg5alFC?=
 =?utf-8?B?TEQ5YTkyVnlvczQ3em9XeTNFSW9PZ2NqSEpTd2hVQ3c3aTNmdkY2RzBLNWIy?=
 =?utf-8?B?TXRhVlAwNzg3WjFDL0p6YVNIMElKNGRET3YxdVFJemViZGQ4bmRGbzFoZElV?=
 =?utf-8?B?VmcxZ05JMmZyQTdqT0YwZzZoYjJuMW1hVSs2dFczOVE0NlczOVlkb0tPVU94?=
 =?utf-8?B?blhFWEhrRWd1QWpja2M5MENhbVNhQ00yYzFSZkoyUkNyVWdwWTdIK0diK3RX?=
 =?utf-8?B?cVdqZkpCYTRncXFqNFFHWjd0dE9JTm9mRlVXNldXbkV3YjBSSDl2TXVaZml0?=
 =?utf-8?B?cXZYNHpjUjVndHl6N2pVOEtKWEpJbllmSTc0NEJmWmpKdGNac25HeXRKd3NP?=
 =?utf-8?B?YkJBUTFsMCs4YW95cHpndVJFQ09tM2VhbFZUR3hCWjhhZFl4Z3JrSXJCTG9z?=
 =?utf-8?B?blFZcTR3ci9YUXBGTC9TZ25UTG9YalNRYWlNSDJ0TGlQZngyWGlFLzh6amdP?=
 =?utf-8?B?akwySXJUUnNUN2Q3R2kwQ2FGNmd2NngwN3Nyakl1YXlmbUVXaGJpMC9VSVFY?=
 =?utf-8?B?UVZzUVpMQkRxdkFhZ3Z0Qm81MGNSNkFMNWpmUmZvSHJIQldRRlJFcit1WVA4?=
 =?utf-8?B?WnpzcGdCTlg0cWRSQitOT3dWSkZ1OHNhOGxqR3JNN2U4ZUdyY0JQRVdLNVZP?=
 =?utf-8?B?aml4N3hjUThRanhXYzFMZTNYTENNYU1pYm9pUm5sVGNCanFsWk4xSmlqYWlS?=
 =?utf-8?B?YXdXbEJuanFxcWNydFUxWE9sVXBYd0ZBQUMvcU9HK2l0V2RFYXV1QS9sZ0l1?=
 =?utf-8?B?Tk5UWTJWbGZsMmkrUzcvckl5Nmc1OG9QS2RYWEZKSko1Qms4emtoVWJuenJL?=
 =?utf-8?B?NmtiUkd5SFhkUmFPZEc5dkdlZVRkSWNMQm9Dclg2WkRCOVFhR2pUd05kU1M4?=
 =?utf-8?B?WjMzUVVFRStwZGZWSTNna0tWajNCV05Lc2xvNWRQUUpaN0lTNlg4OUExUHRz?=
 =?utf-8?B?UE1rZ1JUSm9CcFYvWTBmbktKTndRaFhmQk0xN0dOZlNCZDRPL1YycTZCRzMy?=
 =?utf-8?B?VEU3ZUJQVXc0UHBaSzlVYW1SR08rbzlEVUdPbWMzU3JQdTJaQndHT1lxK2N2?=
 =?utf-8?B?WmtBQWdMNmtKd2todzNGeVBkUzBmSTJGSk1TZ2k4ak81Z0tUYTRSMXlvMTVQ?=
 =?utf-8?B?cWRpdGRDZ0txUEpYL0xyTzkvYStSTlllY1crako2amVGa2JYOGg3VFN1TEkx?=
 =?utf-8?B?VVRIellmbndOM1dTeHE4Vkp3b3VHbjJHSnhLYy82Z2hLZXQ5c2hNVFhWaUNL?=
 =?utf-8?B?TnVHTEdheE96cy9tVXNhVVBiWUJiRjE2anVyZ1FmU2RJbkh4SFBxK0hraTlD?=
 =?utf-8?B?NHRIUWpUbC9pbUtDRUJkMkFaRmJzQ2RiTnF1OFM2OWRxcW9YWDNHais4N3oy?=
 =?utf-8?B?NEhQazFEUVpxbkFiSSt2a2gxQ1Bxd3M3SUJhR0JoVmg4bFVXaVQzdExlWTBv?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eee9106-5bb9-4ec0-2070-08db6b58e4e4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 15:22:54.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yMswsxLuV92BjRsz7GswBSf01ZrSl9rrmV1zlGuQ5MBmxxkHxlz5VMMlMEq3lyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6067
X-Proofpoint-ORIG-GUID: aIB5eelkwUSO18osd3OdqShUdt1WqRw7
X-Proofpoint-GUID: aIB5eelkwUSO18osd3OdqShUdt1WqRw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 8:50 PM, David Vernet wrote:
> In a prior patch, we removed the bpf_cpumask_any() and
> bpf_cpumask_any_and() kfuncs, and replaced them with
> bpf_cpumask_any_distribute() and bpf_cpumask_any_distribute_and().
> The advertised semantics between the two kfuncs were identical, with the
> former always returning the first CPU, and the latter actually returning
> any CPU.
> 
> This patch updates the selftests for these kfuncs to use the new names.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yhs@fb.com>

