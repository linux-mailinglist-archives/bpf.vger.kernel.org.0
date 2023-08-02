Return-Path: <bpf+bounces-6714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C244576CF6E
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78344281DF1
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AFF79F5;
	Wed,  2 Aug 2023 14:06:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDFF7488
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 14:06:12 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94A26A8
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 07:06:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372CxVb2020660;
	Wed, 2 Aug 2023 14:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ut+zC/QXAhsoxRLgJWTEafNrAOQ6d3HDG50m+Ga7uZ4=;
 b=CmmeAD+Kki2iFkA0WJAWfC9i4WMf8ly4/iaNWtPBQxQ7mlFDOftMd6hO4SOkx+4dL/9B
 WGp6fq1GSoDW6b/JqUoBa+DR9MEwnlwP9Mdr7o8dkeng6ChsW1MkeJO1ScPbNwJCtBHr
 euW+GtawiJ3cqf3vmzOCL5Gr/609vOS4XryPLXB5+iDK40vDse/UkE8MdlOy6Jh8tMCX
 3G/OpfSeyo5mHeFdQ24OCJc9EyWAEBJFJz7pzkqID+MFEJxH7ZUG1uwQ0LwDiXGJaXnV
 IggU9+vpnVVF8T7pmH0wkD/vLCpK007Q3sjhxZqsmUble0uS50EatMqPxp9WA2B1WoJ3 hA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tctya78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 14:05:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372DdHCe020605;
	Wed, 2 Aug 2023 14:05:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s787j1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 14:05:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0cdW8642b46cX3ap2c50jHuv8Yut8lWIUKGvJG4s4pcRsSNsdlK2wfzAd9uKkrL+Jiy8flPrr/WDJVBUsmupnR1SN7uDWzw0OPZJTij+6JO14RYA4ZjTmXVFeu2GM1AxEDhclfsDrPG0rJntw2C23DGxxSeV7gODS8gnp0zezHbVeHEMS0ga74lJzRPkkdLcITdgjBBIeOJYmokuY/5ol4/f+ULqLJmkKDceT92TuAr9X5olgjyG0kJRdJQWxKiTX0CX0sGt4jKTamrStQvaoTpf0aV3I6vrYHHb/Yq0I2UwD9p81xri6nfJhqheYm0xg1HXhgLnLgyUJZiVERTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut+zC/QXAhsoxRLgJWTEafNrAOQ6d3HDG50m+Ga7uZ4=;
 b=ang4Z4VG5T7H138bv8mJnaHXMY7Z+8ximfhmokSqsxFFmWAN/jyekJhWXFCpiX6dLTeidto7y4G5RbbL+eFxGw4F/CTCoC6oDrwW2cqx+BzqEndPAZnOWmvOQP8JAuOHaG6QESFvC8DIJYN31ncZcxHioa3PBgTTIO23kzXtng/Ee+PSN7d2gJ6WdAC73uUi0IvNMCWSUidJpWwnpdrunDUZbUdflMxqxzEocVvKFgB+Go+M8V7ggwjibipgcZcnquER7Cu82NfYxJfT6K5rvMIElbE3vtND32Jzpk1uoxWXQtqW4s3osFA8z9Tafhji0Z4sxK8AjuVyVNoObcBxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut+zC/QXAhsoxRLgJWTEafNrAOQ6d3HDG50m+Ga7uZ4=;
 b=BRYVrZKHVtbqxoTxm2hAiQSc4TzUmfq/Gl36/q5PlxUF8i5OqYRJACN6CN5gmvq57mKV8eW1p8oire0El7lQAATyT207DnPJftrh1jKI6iCWs0ckrfKftY+ue/iGvYP8c0IEVlAFfrO+FRVPCtJxDwa8ICbUX4zZ+KWd71xpSnw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4775.namprd10.prod.outlook.com (2603:10b6:510:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:05:55 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 14:05:55 +0000
Message-ID: <d32f2c30-bfce-2da4-c1a0-e8568375a02d@oracle.com>
Date: Wed, 2 Aug 2023 15:05:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: The performance of reading BPF_MAP_TYPE_ARRAY map in user space
 is bad
Content-Language: en-GB
To: =?UTF-8?B?5YiY55WF?= <chang-liu22@mails.tsinghua.edu.cn>,
        bpf@vger.kernel.org
References: <d323010.38a19.189b6852245.Coremail.chang-liu22@mails.tsinghua.edu.cn>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d323010.38a19.189b6852245.Coremail.chang-liu22@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: 6372d1ef-bf0f-47c3-ff00-08db9361967e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IkQ5ztJNmwtok91pa0kkB+MfDlWx/Ssaynk2z2PWsppQP6H3+jd/0d8z3VzP3prkBIiJBPflvTcGADfjsVtHcn/KC2QrXE2nsuJzkCtGiQ3Dd/k7n08GR0tyv+OmVmrwVwW2OLXLl7Sg2JDM3wsNURvwsd+j8MDv9ODk5ygr73OaPEs/hCqE5doZ/BldK4+/jPAXOOAirzpqzJzOFy8YiF8QzbLXgRYrdJ0C4IjcE06T/iaiugeIAYi6MDQYL3dRXnIUM3VMOKafre3o/pNDV8M8pQzm34z/TPy6yjW6d0lB7iYQC1Dmx2CZ0tK/KKfJVI6mWxEvILxNe1P1uYaOjhPmlevltSkOvz99QvTpfPituMnYF+mXX7ENsGnLC+kfWCZZJeQGhBwYaoIgHw2xmS08/ml1k/TNyOLkOASasQ5S8CfihsRbZ1/+i7klX5PUD0XLQzMhRvoeyXCyYIvamvFXFdjz2Ku4OHfhOLMJSEBdHxn9QNjrG6VK8te1YQN8mNBUEmDUT7gnC1FS8+5GhLDYdmalQY/cuQ6ofGHI2WLKptdbgJoPmPcM9EiVdZilJNRC+abagCbHoG8pSCjkWvAZVnAyfMHeKAIBXEteJzn6BmzA7gR7Y+vx/ejPRzddQ1X1NdtEYxFh6FTcV0j8VQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(41300700001)(2906002)(316002)(31686004)(8676002)(8936002)(44832011)(5660300002)(66556008)(2616005)(66476007)(31696002)(66946007)(86362001)(38100700002)(478600001)(186003)(53546011)(6506007)(6486002)(6666004)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vm9aQUtBclFkRjFXK0tEZU4rTUxUUi9RVzJhZlJvL2FtT0JmcVhTanFpanBF?=
 =?utf-8?B?K3B3bU5QdmZDTFhNTy8rVzRVckFwRytLaU0rQ3Z5bEJaTmh6U3hWSlNLZXBk?=
 =?utf-8?B?QWV3S0xzdU9ueGk5TmRGbExsT3N0eGJaVFMrR25vaGRSalljUDJtMGJBZDZy?=
 =?utf-8?B?NnVzZzd5NkhSbG9uaDI1WW83V3loSWlRcUkrUXQ5c3VaZzE5L2VwNFhhNWY0?=
 =?utf-8?B?NEd3QzcvY2EydXlpZmNpNkdtcWtDZmFiNTViUzkrMGVFbG1yWmtZYlN3YnFt?=
 =?utf-8?B?MzA0eUFlN2FHdVl6Q2RqbGN3MFl1RWVyTGxhVWU5d2VpSnhmakZnS3VBbHJq?=
 =?utf-8?B?SlhPejk5VGRxdlU2RzYrbHhueTRmVktWaktFSFI0b3dSNEkzYU91WXd6NjZp?=
 =?utf-8?B?Tjl3K1RaYTVSVDI4YUZ0dXlsVk9NbldqdEdUajlXYWYwZGdQaEl1eWRyMGUz?=
 =?utf-8?B?YzJSTjZwYk03eU8reTQyZmVGSXF3bUdob0dSNExQbGZZdGpDaWdldTgvV3Bw?=
 =?utf-8?B?SGlXSXhMR1dZSDhBOC9jdTQrRCtyQkZBdkp6VG9UUE1wT1dEcU9LZGVmYURk?=
 =?utf-8?B?V3RCeHFNaUdVNnFNQVVvMXovOGdHT1UwSnFGSVVYbngyL2MyQ1M0QU1GT29M?=
 =?utf-8?B?ZytmNm1DSitXdk9ob3djN3oyYjVDS2puZnlBNE9Rd2pKc00vMmdta1FyZWZC?=
 =?utf-8?B?WkxUNEtOM3pFL2R6dWsxUWw3cVBGd0lnSXNCcWJTTzVzNkFKdFQxQVBobWNu?=
 =?utf-8?B?aWorR3A0MG5QTXhGemsvQ0cwYStYdG1nUTBUd1hKSDJqYVBuTHRiNSticnJT?=
 =?utf-8?B?VHd4U2YxcFJabDJ4SWFQZEErSkFmUVFyZXNmQ3pBMVN6VzRJMmtIUmJ5WWY5?=
 =?utf-8?B?NEFNQVFNNEdSaHl1dHp6VlVTYXVYeEg2YzNOdTBNL1hIV0FiMm56NVc0alNE?=
 =?utf-8?B?WFl4ZEpscDJBNjVscXhyLzFUZlB5WmlvMWs4N21wVXd3ZTg4N25sT2JUNnNi?=
 =?utf-8?B?bDc3bk1kVFpJc2t0QXl5YUxVR2llVkRpV0FzZm9kTmFUQVhRUDBkVnBNcU1U?=
 =?utf-8?B?MDl4b0UxZWpsZU1sQU9BMXdzMzUrY0VFNjRIZ1BRZVQ0d3puNGhaUG5tS3FC?=
 =?utf-8?B?cEE0c2pNSmYzZmFocERxUWVaQXY1MlpQL0IxYWVmNjg5WVBJVk05dFlFOU03?=
 =?utf-8?B?VWlBZW9heWpIRWRUTXN4dVBNMTFIdjZnMXBDbGI1ZGMxbHB3K3FFS2Q0SExu?=
 =?utf-8?B?WWpUajYrZ3hkSU9jVGoyQ2xKeGNudVQ1Q0FmU243VFJUdWU3QnFreit5Q21m?=
 =?utf-8?B?dUQ3YTdXVnZ2QkpTeWFQdk5vTXVrMGsyNWd0L2NRdkxGb3BYMndpRGZWREJs?=
 =?utf-8?B?dEx6c2lEZTNibjF5d000MnBMVkc5WEdrUHlDWnRyZGZDb25mWlhvSSt1dWh3?=
 =?utf-8?B?WEtmMXlYN3dkc0h6V2MrMWhNOElQUkJNYllWYmtzUUpQR2J3bk1jRk15bjYx?=
 =?utf-8?B?cHNYcEduMndFWDV1ZURobDlKTllWY1Fncm5GT2JNa09PTkcyQlJMNXJTVGZ2?=
 =?utf-8?B?anhJNlRTNWtXV3UvVjBwNXdJQlhWSzdOT2poU29jREZsc1dydGhZU3gxLzFa?=
 =?utf-8?B?TEN3YkdFeHI0aVkzLzdRNFVyZW1KVUYwRmMwNWRSQXhKeWJ3a1djL1l0aEFm?=
 =?utf-8?B?a1N2dWEvazFlRkN2R3dBQUltRGhlajlpbXpXaEhoT2pId1JnQkxtYUJUSDZQ?=
 =?utf-8?B?eWRkVGwzRkRqMXVKZDdVWGJqRmt2Um5helc5ekNxUS9sWTNiajJOT1QxcXF1?=
 =?utf-8?B?OXp4ZFFlMjUvRlpTMmVQaENKanlZRUppWFFyZk5WVlUwMlM5Y0JaR0VJeUNN?=
 =?utf-8?B?RzlaRDcyc2hiVFhrRERNK1FUdk1QTWdWSUtzcGJTaFdJY0xNR3ZMcWp5Y0px?=
 =?utf-8?B?aVhuaWhoKy9yanhKdVRGVzc4TjlVWTlFQjEwaTk4d1NwWmxiSys4cXFEd2dL?=
 =?utf-8?B?M056b1ZKQmpOM0JnS3A5eXhGV3VVUlA3YXpjVDdMRC9MNzZSU1o2ckJWK08y?=
 =?utf-8?B?K25rZWQ5b0h1b1RoWlh3TEZtVjFJbVJELzhKbzJTK0VGZEtWazhZOGVDWWcv?=
 =?utf-8?B?c3BsYlFXYkQ5NUJ1d2lycHY5bE9Yd1o5dTFtMnY3eEJzUlRtdlBlakE0N3E0?=
 =?utf-8?Q?SDf4FDEG1Ny9HHzfwUckXuc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5SyUD9wWDefa5GKRRe3/DRFGaPkbgu6aWA8xWtGRCJoK8d3S/8lKSPO4KHG1j5hndAfFIPlasgd/XNTLNjTaQmu+GWeT+ECPJb0C1RwobUl3UlE6ST5eSEi0J/wBCx52jnj5kRvKR1/g4Ge3A2/SDfLUAJa9jW6TV80BpG8aKHrVnK6LK+DzfaevRnoaaoHbZwf54aWa3j83fzk0/bQly2yLBrF5k3VMJeMRH8DAAbbwvHA74C6YuKzFVnhzkylwa+bo250CpN0lUveaNLeQL2eKhVfmZcQMtQJxtKA92X0xaY9XKoDpWrBE5iXD7B+pZjfXeZYt7zMsl/a8gNGJ+wMlbik+kb5quKfuDeVBX+Vly8SB+VHyt2sP5bCinXuumC6vcap3a5ADeKh79tyJrMqVcNZESe8xAqiREC30XiKjUfPaziXqyR8vcFilTn8kXxsSrKi+3SxbiPxLT9TfXBdEIN9KAm0I9n6P+uBJyA+6BwlwLE10QnvPZEAU8K9iiFyv0+5VUkHEv1hyjqgm2yw1JqZY+jMVvYBwE5QCHGX+GKztlaBfuNIpLLTewqVA/bW9RLot7Zpwf9ZETnsXuvGXvcRGm29YYqWNROHJRyUyA2bL5CK3r5KkSLZy9UdNPe/xroC1Fq2nnHX3ld2RoQr9rCQ9SrDbFoPTNOvraleuotOWQ8kVQGfNAOQVZO7iOdPlyPu9EtK5eSJtdV6cHwfhyID7k9TPJHUWDdJ8xCnMjTbQN4dKfwCqBbZ274Phk8ohgOgjMCFufYWglcyx5Z37/6nF/n9kwLVhd335JE+VW69KsPThA6spG65KJfQq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6372d1ef-bf0f-47c3-ff00-08db9361967e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:05:55.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS5e6r93injuOG+WAKn5SvAo/yPbMz+e0M4aMo2UdbqYe3npu/HDgW6rUpVYn4ZOX1aZrTgLqyHeKXIN1oGJ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020125
X-Proofpoint-GUID: hNxN8bjYVJmW8-eIZer9O8KFnSBJ9-y3
X-Proofpoint-ORIG-GUID: hNxN8bjYVJmW8-eIZer9O8KFnSBJ9-y3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/08/2023 14:52, 刘畅 wrote:
> Hi all,
> 
> I need to send trace data from in-kernel eBPF programs to user space. I have two choices, the first is storing traces in a BPF_MAP_TYPE_ARRAY map, and the user space consumer pulls traces from it. The second is storing traces in a BPF_MAP_TYPE_PROG_ARRAY map using bpf_perf_event_output(), and the user space consumer reads traces in the callback function invoked by perf_buffer__poll(). I did simple performance tests and found the two methods have significant performance difference.
> 
> For the first method (pulling from a BPF_MAP_TYPE_ARRAY map), I set up an array map of 65536 entries and 40 bytes value size, then pull entries in user spcae for 10M times, and it costs 3.7s in average.
> 
> For the second method, I allocate 2MB memory for the perf buffer of each CPU. The user space consumer calls perf_buffer__poll() in an infinite loop. To generate enough traces, I attach an ebpf program at the sys_enter_read tracepoint which will generate 100 traces in an execution, and run a user space program to call the read() system call in an infinite loop to trigger the ebpf program. The result is, it takes 10+ seconds to get 10M traces using perf_buffer__poll(), which is much slower than polling the array.
> 
> This blog (https://nakryiko.com/posts/bpf-ringbuf/) says that bpf perf buffer has the ability to efficiently read data from user-space through memory-mapped region without extra memory copying and/or syscalls into the kernel, so I though it would be faster than reading the array map, which needs to invoke the bpf() system call. But my test gives the opposite result. I run this test on a server with 48 CPU cores and 188GB memory. The OS is Ubuntu 20.04 with kernel version 5.4.0. I wonder is this result as expected, or did I overlook something?
>

If you look in detail at the post you've referenced, it talks about the
BPF ring buffer, which is different from BPF perf buffer. There's a
guide there to converting BPF perf buffer API usage to BPF ring buffer
usage - I'd suggest retrying using BPF ring buffer if your kernel is
newer than 5.8.

Alan

> Thank you for your help!
> 
> Chang Liu
> Tsinghua University, China

