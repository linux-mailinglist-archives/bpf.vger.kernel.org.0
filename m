Return-Path: <bpf+bounces-2420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B272C9E1
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3303C280CB1
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A91DDC4;
	Mon, 12 Jun 2023 15:24:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAAA1C757
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:24:21 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAE5E57;
	Mon, 12 Jun 2023 08:24:04 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6mh2V004197;
	Mon, 12 Jun 2023 08:23:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=UZBtrvEHCRzblTSS5cmRuWsNiFEQU6AKiZTAec00ARE=;
 b=ZBxNX22FmdbigtZMaD1e/AA4OCjnN2IMjK1HcgKVNpBULGbcF2EyZc0av8vdQVptRY7G
 EaAc0J9S/JJ+sJ3rb+w43QlmcDfAJ/zBETAdwid4KcN3fhnx1YY2hfd9ZmEo5I+7dvQ1
 ZDBlMjcIMr7fn/lUtmjNMeBsulPgceqxeWdUq/bO6JfldoD2v8X6yxe81fSNpTiUZsko
 73KFiqN9n7lJesVP7h8TCjd/5+dxCDkCLJrNwcq2pt4OCRIFhXg4yqEFFT1gbKFoCgwu
 sImqku9YgsLi9kkC75eDwn8kXlMBEiZeYzHmKmmZ4CaVrIlkcL8MO6ibqg+7OROG0wyk sQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5xdttqab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 08:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W25A9wF7wnJgRU2XBXTSNye+wYpzuKT+WwQCnUC/+V5FW+iCk7tyT6qMEkak/GYoy5IoWdQbc++0PDwhCmI3nXj3flh+pYjPXxJU7w1+99r+SNVrEah9GURW6rRf6MmMGWdfY8x4uVi8DBvEUERMSGQAdjhUndKnled2I1p1mLIdSRLCzqI+2wiUG73rWgF9eRA4ew4Xhk4CuzBMI5awF5IzRoq6S6BQ4ILUO+4h4KO/SKR+wwaPNj2wYrxYoK8H4qaVymAeyaD/Wv3XHXvtTCzwd998ccMoDz5EvHh+nfQy4r1UkDJCnQV1U8tHkmrPlPv9JbmKKVO5CyCuhgVoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZBtrvEHCRzblTSS5cmRuWsNiFEQU6AKiZTAec00ARE=;
 b=d/Mlr1YzX7YHc5hv+gs++npjydC7R2XHZxR/TEZgv58ZXPE4pAq8dPdCoS28tBh64BjasFoBqgpHSjztwTY9JQ0bRk22wAwatEFePllN4gjweksGliupv4UBaGj1cVC8zyW8civIfXV+S7jKvtcR4ZkNCpEi/IdFiaiWjBBvdtMhuPrB1FLb5dqZ6jPTEFrCIs1P5soJb4QQ54GgA8e0237vWHBsHzPBCD2rMCUfNnLIxfXV39Z5w34m+7jn+IFWachW2ThoZiykqvLf2Jb6811fUGswPoAUlmwemDcCJS0XqCaC+GYlYFY5weJuTj6bZhhSJLIq6X/EGDNB/uHcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4775.namprd15.prod.outlook.com (2603:10b6:a03:37d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 15:23:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 15:23:44 +0000
Message-ID: <52a6b88f-32bd-ae71-24b0-3a3796b46ec0@meta.com>
Date: Mon, 12 Jun 2023 08:23:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next 5/5] bpf/docs: Update documentation for new
 cpumask kfuncs
Content-Language: en-US
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
References: <20230610035053.117605-1-void@manifault.com>
 <20230610035053.117605-5-void@manifault.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230610035053.117605-5-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: 8848f1fd-cd8a-475a-8154-08db6b590269
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ET7rUHSEbMPZ6CoDp2ITkyhW3E5xd2J2L47SIendE1w4aKYk6/bjcycP0/L51myuTpWZkgGqoMgk6y9s/xt73ng3KoF9bcvjO/XM7wZcrG5YjT7QIjo+VmvFKoyDh0cbSvxv5VG2NWgZRFJjM3UYgVpYEuGoMiYxUAkw1GwzC4mn8GYcfdWSMbVo6jPBRKaSKvFierRNta7uhwAJz6lFusGPL6reFSVBcNBC8vF1uswn/KOsThLotWbhnGeJlfZ3G/EwyEmKySWQUK8SUct+x0xsQ48knfzkXTZNo+3NP6rqWHq2Az18OHY6Db8xDRdOUKgi9iJwBSEd3gacJOcMeqN3F0biBn9nQl2MfFkqvDB2Szqr58iudgG4+OtU6BA25HJ+2J4Uer8tpt4yPYU7+HGafzVir63iOezGb2vP1lVTrRtYwBXrj21Hd7LQjRnS1k8V3rgC0nyzXynpaMfM0wsrnfv0RshqUbgsn3JaKDJjMCkWmYdzfFqEO8AQBnDGcZncmL/qKWv1kF/MySRRwOsKDsFgyCNlPMLkVt+0wjrWaTkcXXvbkkWxe7947qtd1iDoU3jMOhClh4A7ngDLN5rZpxyQXYHXtQRB8mWF5Nrt49o9jMEgHCXCK8vUlgTce9wt6446sQFRFOV6QRH4+5WM8fjxljDW9rWm5kaSCU11ot2gxgyb1bFT8DmHTXm+Ydmob4WLQfncpOL/1DRmrg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(31686004)(2906002)(4744005)(8936002)(5660300002)(8676002)(41300700001)(7416002)(4326008)(316002)(66946007)(66556008)(66476007)(15650500001)(6666004)(6486002)(478600001)(53546011)(6512007)(6506007)(2616005)(31696002)(86362001)(83380400001)(36756003)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTA0Y09XdkIxV0R0azBjNjN5aXlkNFJGSGFzMjdUQVNoVys0MnpXL0RETjNM?=
 =?utf-8?B?RGxtd244OXo4bTBHVVJwcE05RWRGWHhJMUtPZnR1dUtrQ3Z6TkVXOXI5YWRS?=
 =?utf-8?B?RVdiNWpEc3psU09Qc0JJcExlM0xhcEJ5SUFESUZ0ZmlNVzltT216a1N1Z2lC?=
 =?utf-8?B?YzJYeDREcnQ5aDVoSnFTa2EyaTdxT0s4ZmR1bVBrUDA2Tndsc2ExSXhTcDFO?=
 =?utf-8?B?WUw1dWtZZXJ0RFZycTJpSHMxbEdCbkErKzFmbG5sTERmcVUwTTV3czM0OUYx?=
 =?utf-8?B?R3FHR2VrZ2pzNW1rb0xYZm5wTlhKSEZMTVFjNHFCckZVUEVUd21iQ1dxV3VG?=
 =?utf-8?B?SWZoa0hIeWFGSERZeUJWTFBGTU1XMndtNVc0aUkxRmZ1eHZlMEY5SWxyQ0FV?=
 =?utf-8?B?SDYvRGxZbFB6Q1IwMDc5cnVyaWVENjNwL3VsNFhjallWNEpVTjhHSzU0OHky?=
 =?utf-8?B?MWIrdmFLVXBWdkp4MEh0VHE3dXFYUzJJUlRyTnJWK3Foc2hqT0NtY1YrTnND?=
 =?utf-8?B?M1pXcmlsaU5pb0ZPRHFidjh6SHczTXAvRVR1c2gxbUFSMlhibkhqdkwxU2ZF?=
 =?utf-8?B?Ti9uY3Y1YzVVdG9BeGQ0Nmt3dnVNc1lhUCtQU0NpdDhkVE11QkZJV2lHWXhO?=
 =?utf-8?B?MWk3cXd5VmxRcmVNU1FhenptTjNUQm9ib2s1S3hndVA4R2w3Z2pPZ0swOXZ3?=
 =?utf-8?B?Y3ZRbzVGWkUvUVF2QVZHOFJLV2plMUR3VlVxOFpDWVhLNVZoakt6N2FWTmFC?=
 =?utf-8?B?ZjV5MFk1bDNVVVhsM1F6c3NlTm1hWEZ2TnVjeVZHaDQxVi9pOHIvTzRXc3Uz?=
 =?utf-8?B?S3pHd1B1U3p3M3FSZjFNWWgrQm5WeEErZ1ZkR2Vid0UxZDZoMnl4ZGk4TjQ3?=
 =?utf-8?B?VTdrdWVkQy9hSkpJc0pORDkyY3ZBKzFuMmNSWjB1TDhBNjFHSTB1akdpZ2pn?=
 =?utf-8?B?U1dYcjBaNmV6N01aS1NSNkovSkxMVk1EWk9wZEs5Z211YXZ1QzhocVBDMHpD?=
 =?utf-8?B?aFAvUUhlN3p6TklncytiZi90bU9IWkovd01TdXBtaXBWNEVDK3RveHpuNGtH?=
 =?utf-8?B?MmRjWTVMZVU0NXdqMkt6eUxYOEsyeFJ0a3Juay9xN25DNXp0S3RkS2NGNFll?=
 =?utf-8?B?TUdzczJHS25lUHhBVHNSZ1JZM1NXc0dyTVZLMCtINk1sMmtqdDgxbEQ1Z1lJ?=
 =?utf-8?B?bmk0WmcvczVvVlpjSmZiY3RTUURzT2NuL0wwK3Z1SVBaTmphckdGeElJZ1cz?=
 =?utf-8?B?TmZIUCs1U0RNWElkSFo0a1IyR1NKRjU4MkN1NzErMDZ1SWRwci9xemdMazJG?=
 =?utf-8?B?akg1eDcyaGVHcE9WK2liSUp5WVpDU21lT0cwWE53UmNQU1h0cEx1REJLcElK?=
 =?utf-8?B?dXZnNmdRcjNYY2ozemVTT0ZqNFh4dTNwRWdaUTBBZFNodk1vT2tCWXM3RE5n?=
 =?utf-8?B?SmNLbFhaUndZODBaRkV3Tk9zbVB4Q0FtSzhHUmVadWNwYmtueWxBenhDZURO?=
 =?utf-8?B?MmdPYkJtSUY5dDlyRDVLeklMb3JLUmJZdEpwNzhibGNJUlNSVGdudTRUSnlm?=
 =?utf-8?B?SThmTmc2dlhxeUVyWGtwR3d2M3B1YXMxeGMwUmtMc01lc3BSTnRmS3hqOHdt?=
 =?utf-8?B?Vm5pa3plRlJrelRxRS9SdEVWa1IyeUpFQnVJSzN4M2pLeS9HWGpsem5QMU02?=
 =?utf-8?B?Wk1qVW1MVHRDV1dJN2FKUytxWHovbFlNTTlVT2J3bkN1S2lCTTBGN3dxeWY2?=
 =?utf-8?B?cXdkSm9OZ1hUY0k3dXUwN1NFakFsZWxDZzQ3dERxSUxXU0t0cFZ0OFR0K0xy?=
 =?utf-8?B?amk0VTBLdFNManJHTDZhamdsZXRTYnhZdkEyYmQrZ1ZMendVWXUrNVZURkdH?=
 =?utf-8?B?cFp2ai9pSjNnREpjNlpiQzdqck8ySVI3aWVPQkVvaUNNQUtFNWIzRENsQ2tt?=
 =?utf-8?B?aVRkcmF0RmhJcEdRcW1pWU5ra05MNlRnRWJ6bXRMZWpoRmlubHRnb1VCRVFq?=
 =?utf-8?B?NndKRklHM0pobG84ME03dE5JcmpvVVlXZ3NyTjJMN05OTFlwZnBHVVN2Yk9L?=
 =?utf-8?B?Y1ZNcEd0OEVGN1o0dUFjWDBrbXphT1pHcUh2Nnp5M3FBdjAxbWcxdktIUnp4?=
 =?utf-8?B?R05ueDVZOU40di9XTU01M0pUZEloVUJvVHdta1BQWmZFS2lnS1JzczJSZTBk?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8848f1fd-cd8a-475a-8154-08db6b590269
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 15:23:44.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsikxuKKJ879PiUJqof5Hxz6j/aukaL1+rq8LprxgENkM/FTCNsKa6C5ZlIqb36g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4775
X-Proofpoint-GUID: uz-5rG5pliELoBIqkZScndgUtnLT7aW3
X-Proofpoint-ORIG-GUID: uz-5rG5pliELoBIqkZScndgUtnLT7aW3
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
> We recently added the bpf_cpumask_first_and() kfunc, and changed
> bpf_cpumask_any() / bpf_cpumask_any_and() to
> bpf_cpumask_any_distribute() and bpf_cpumask_any_distribute_and()
> respectively. This patch adds an entry for the bpf_cpumask_first_and()
> kfunc, and updates the documentation for the *any* kfuncs to the new
> names.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yhs@fb.com>

