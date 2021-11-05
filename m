Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0B445F1D
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 05:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhKEE1K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 00:27:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhKEE1K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 00:27:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A50RpbJ029841;
        Thu, 4 Nov 2021 21:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SntenbIbxbh71IiR+eGK+zyRxA7978v4rahh0SKtl+w=;
 b=gRJu/fGa39WhiolYMwb96toGY1hqYh13lvvoagABjah4gHE3n0Z1rhi68wXz6amDeTy/
 7jWlLlLdAIoD0HfggXmO/AR0ROer6VqxS0oyB3TLXutMEPTdUB0pChzL7zS4P6Od7Rz8
 VlahPwwXrMg8Hu0vIeQTU960o4kTKQSEsFs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t32159a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 21:24:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 21:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCHZuXP2tVYMJsoyLJGGphWiRKT+FHdIciYl+6XF6UCpt0Ra7pe8oicSLfTuFVPpUUhTUSMG/MZmqjQY/eQwvtSqTSEcDo0lvA8gj0NevtCBtpg6Zf7RINZRgVhbbVjNneVsv8WEccS79MJ1bc45dMrM+VUAiBqtCGU90gUdBMkYROdYjQSr4u45BkUAafKa3aDnlbaAHgbSgb51WlFu1VJpH6LB0KCfZqKEzSPhajSaOCdzY874WrtqzLM4HKDtlHIbcYBaK8tlv2lYw/GhpVsT4swCbkRDyJASyUZrOS8axkytZVHI/xycYsmVJS8z28+aePj0dDGUmzJgnjAROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SntenbIbxbh71IiR+eGK+zyRxA7978v4rahh0SKtl+w=;
 b=YffgMwQWNa/m8GQCYvhBnaDtC2Wyf+gyv/ZxhxXjQ+S6lKlkTZqcF1damWY5d9NjT+44kcc4jAoTyxcoOwXKWoVwrk5LQDVUloVpQ1cusfLHg4LbesEcxWJZqqolb1OEAl4zKk82uXhA0Pqd9mM6wdk9RidMvMSZ2jrLxKvdnC2vSB39Gr54hUphhfUARF32BCLjkKWWpf3wkUtaNZu2a9dPkuq6WQnpMxQVe9sjEeMe2LZkYK1YTb5tqANGspDVog0qEhM0yS2nVhAB2pWpPQOfRJwuhqdBN6BeT9m9KYJ10hd+gxO+5bnyzC1AovSX1Rsij9N0+kOKBYI92Vxb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2479.namprd15.prod.outlook.com (2603:10b6:805:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 04:23:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 04:23:55 +0000
Message-ID: <ef670dc7-e3c9-ad89-dc8b-5cbd1910b38c@fb.com>
Date:   Thu, 4 Nov 2021 21:23:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Content-Language: en-US
To:     Di Zhu <zhudi2@huawei.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211105015730.1605333-1-zhudi2@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211105015730.1605333-1-zhudi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::14ee] (2620:10d:c090:400::5:bd86) by MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 04:23:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b79f6f60-52b8-469b-f61c-08d9a0141443
X-MS-TrafficTypeDiagnostic: SN6PR15MB2479:
X-Microsoft-Antispam-PRVS: <SN6PR15MB247963FBF4DEB8A96BD2F8BBD38E9@SN6PR15MB2479.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chSuu767zDwbnVesDOQqZXX0W5g271n66NXORocknNLgDaOygdRZu64tC8AZHn4SsqsrQ92BXS684CBTm7szZVWCWS9GSv5K4P/ZH8EpcPC7aZ4OrYtGD072OrOITdK+UPWeH2Hq2GyZV2uauWsvtQeo56E5GbCwmoHgk+d8w63o0dXm7EkAffdWcHWGbvh0m5cPalq0gv7orS23VP5C/zmpWKE2GfSrqXex+iz7irr3O5B3LyZC2T07+PIYIH5NIvnWeu717ah5NEtiZmAAEVV6E2rhsag9IizGbtY2VaVAQZQQ2pomJcZkABBz8drw4Ch0G4Pf9pozzpOUZ0QUgsY8TFKcWatqqWVg6HwxYmQiH1j13RQpIbdSxPa6YEEt5se+1EO/sFFCftJPzF9sJNlGUsVunPIr30crJUO4AG8sxcDBnAQG/jzSyOXx2nkKNRyt+3SnDKPoKLP7Yvzs3y/Ge7zEa78jesrN8Z4RihF0Cpkj/Du/UZa59A3hl4HuVuLhqAzuABjYaLfgfEJ3hBnVsH7arSbTUYRoLRaA5K/xNcAU+6PBPivs2rSi92cFpyLQBuYojb9PLd/dcLpKifWiHfQKHNDNdRdh7ZA7msfc8yKRVGzHeZujchMAG1CQS/vjHkfW/8zwrstYrX3M0qsofrb2+RtV7jrAC43IxU5H87wA/53AsQMeIHhfrFcy86rfv6upGEWq+Jx+jYsyim1i/ta69qivuxTPGaQnlonieGLHj2BNO4DG+jhxfGMA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66946007)(66476007)(66556008)(8936002)(2906002)(508600001)(86362001)(6486002)(8676002)(4326008)(52116002)(316002)(186003)(4744005)(5660300002)(7416002)(31696002)(53546011)(921005)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxmRWRBRE8yL2FIUlhSNEdlTzViNjZNQnRSTGlDN1B5aVozV3oyM3VEazht?=
 =?utf-8?B?Z2hyK2pkRXFmVWFJdUN2aFpmbW1ocGxJa1JJZjF1VXVZV1pneVNqUmZoSEFT?=
 =?utf-8?B?OHpaSEZoVUQvdmNPbml3c0Zwa09RSnFtd3VDTzdVb1pUVjkwdHNZcElIaVcr?=
 =?utf-8?B?YTVYWXdyUTJxTUlPbFI4QVB1MjlEYjdKQzQrZTkwVlZ4MnpYZ3BDTHNzZHlB?=
 =?utf-8?B?MnUva2VEdXFHbWJQaVVybEtLVWZTVVYrZ0YydlBkN1Q3aThNNmFUK1Z3MDE2?=
 =?utf-8?B?ak5NQXI3bnRmN1grUm5rZ0R3TjJUM3cvbGtHaEFNTE92N3J1VEh6MUc4a1k1?=
 =?utf-8?B?ZFc2T1lXQUhpbk1GZjhaSHBybXU4aEtTR1VEWmFEMy96WkswNHBKWUZ3dk5J?=
 =?utf-8?B?eEZQRUVPcWt2WCtpTkxpNXZCK2pyUWQ2S3MzWXNKeTVKWm05MVExQ0txZUhn?=
 =?utf-8?B?S1ROZU1JY3dwdklXV01MM2tnZnBWQmNxOTJkVW04MURldER2R1V0WjFDL2xw?=
 =?utf-8?B?UDQ4eE4vQ2xtdDdJYkZqT3FZZHNrcVZ5TkdOREVkeDRTd3ZJNm1meXdqYjc4?=
 =?utf-8?B?anNCaDliaHBPQzdhdjd5WUMwbVk1ZStZTmhrYnpEMS81NEJRQmE5cEFVV3d3?=
 =?utf-8?B?MlpFQXhmWmY3TzVhU1FzR1BTME9MdnYzelhxRC9ZMCtaR2dWUUFWSVhTbUsr?=
 =?utf-8?B?S1F6enEvdUlHSEl1YnpsTHc3ZXlKa1ZJL2ZQN2pmS0xvV2VsbWpLbHFVcWRz?=
 =?utf-8?B?MHBzWXRnRzJkL2grZGZrbjJqWURxd2RCUDJQY0NHZ05rbHN0NXRKaytwMExn?=
 =?utf-8?B?ODR2N3A1VW96Qy9yYWd1NnVXNFBqMlZNWDErWVRTR0lBYWIrN2tMbVptdTJa?=
 =?utf-8?B?MzFGdmhGME91Z21yNU5OUXU1NDhSa0JpblRGYk9Kc3B3OUE0M3ZscWkyNVhQ?=
 =?utf-8?B?UHh0QWRZMi84cHJSeVVOVFdWVzN6ejRSWTRzQXdVbGRXZjRXejREZ0NTaXhY?=
 =?utf-8?B?aHZnaU0wRlByRzlPb2NGa2Q4cE5DZVBVQnJvKzRVVFp0S3I2WThWM0FOdGhj?=
 =?utf-8?B?dStwNFhrN2hBVDl1RUtHZ01PeFg0emR1OTJIS1p4U3N3eXBpTnkwUGpDN3Bv?=
 =?utf-8?B?TnE1b3d1bW1aTEZBODZodVdXdDdPbm9uOXh6ZytJNXhoQ2w1Y1hFRUFLMlV2?=
 =?utf-8?B?Tkp3bzQ5REJBbytRa0xQbDNyZEZHazRLT0Y3RUxveW9LTGRWNkZzVUR2Z0xj?=
 =?utf-8?B?VHNoaTZMNWthSW4wcVBncUR0L2JxZVhuczJvc3NKNWE2UDhLTkpUK1d1THdz?=
 =?utf-8?B?TTIwcjB2QUZyQ1V1VXU0VDVoMFQ2Yk5JWkJjeERteTdUQmxWeHQ2UnlxTFBO?=
 =?utf-8?B?ZDBtSkM0NFVYOXhwNUZmaEliSjlPOGZvRWN5Y012UithUjRkbnpPaGJZdEZw?=
 =?utf-8?B?cXZtQ1MxRXhraGpyd25wbTJ4SFFvQlVCcXArWlB1THZ2TXpiclRPTVZTQWdO?=
 =?utf-8?B?dU9zMG55QTNsN2lRWExUbWZ5a3pFTElLM21pS0dZNlZiSWs0dmZYTnpMNXNx?=
 =?utf-8?B?cDJiSzd0d0F4Z1Q0dUVscTMzQTVCdkpqM0VKRGpnQVhaMmFNSDVJdll6dFRk?=
 =?utf-8?B?UE9Yc0ZhVThvRTkwaG1iSWFnWHdnenlXbjZhNy9EQ3BneGdlam9DTlVXM1Ex?=
 =?utf-8?B?ZTVQcTkzWGFJTEluVEVBelU5VERnWXNpaGxZQ0ZPZjExd1E5OEdWd3NsSU41?=
 =?utf-8?B?VHVCbVdWMTJJVDFUM05kSmh0OXdDTk9zRVBBSGYvNUd5ZFNPT2l0Tm9yanNV?=
 =?utf-8?B?aHV2V2M5YWhxMGlOODdMMmFvRzFrd2hFM3Y2YlJOT3B0ZzArL1AzdFh4KzZU?=
 =?utf-8?B?dzVqaC8rRmZtckN0YzExcTVaaEJtQ2xyeDFCYnB1aTBEZWFITmJWdVVpL1l1?=
 =?utf-8?B?bmhFSDJIakdSWEhaSTF6S2VMRUFkMkNOTlE3ZDNmUEU1MThLdExLQVJQejhs?=
 =?utf-8?B?ajNIWEp6TEx6cGtxNnYzUEpMS210dFYwRi9LaWE1SHBxRDVhek1nRDM2QnNj?=
 =?utf-8?B?bG5lK3N6aEpITnBwL3gwcHF6MnpvcmNKOHVCTlFpT2pYNUpFeDNMeSt1WkJk?=
 =?utf-8?Q?567pjJ0qe5Xc+d+5W11DzK2PS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b79f6f60-52b8-469b-f61c-08d9a0141443
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 04:23:55.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQ4YNCBY/A4rbtY0W38KTv0dBBu82r53G8/LccVz0tvC8eXeB3YE8FvJhCr4ghac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2479
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OHiwdd8jr6NpoS5FYtc1a4Tgsp4FXuXZ
X-Proofpoint-GUID: OHiwdd8jr6NpoS5FYtc1a4Tgsp4FXuXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=873 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111050023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/4/21 6:57 PM, Di Zhu wrote:
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
> 
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
