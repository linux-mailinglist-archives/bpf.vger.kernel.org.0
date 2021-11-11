Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA85844DB6F
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhKKSLE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:11:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229872AbhKKSLD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 13:11:03 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ABI4x6L025921;
        Thu, 11 Nov 2021 10:08:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=agmZgVN4N2nGsiOcQfZN+IOmFbrhQCd1wk8/8+g/oD4=;
 b=JXsVEmaGtInokHgC8HEwFr12JJd8tmZ7mGDlxEVVTpRSaiPR7RhvzYFPpsVQ5xOZXK33
 yzAsFy/Vgpif5Xzz8107716G8MLTkE4YkMGTz7qEL/rDH+Pi0/6yaLshgUvhQYXYBz2p
 6IVnok35Y3zMsQBlEZj08EIqelEI14lPx3g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c90qk3w95-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 10:08:00 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 10:07:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqXuwvSOE1cc99b1pQ2JwHnVJL9e2xnXT+fN061twcqbCUpfuuaJZpwq6ao7lJdItcc4EpG9onGQWJYPv+JxdB0rPyUKGTFo/JIEuyNHtF/7JPDm5kfiymo2B5vF8CbFBaCChDgXZfdqYK9YuYVQnLUkfk6dw9T7OG552UZHkZ9jaAXs0BgYFplZzWmmmuBxPmEpI55TavTWTJgE1ZD90/FwE9mIQqkJ6l9xiNHzT7rNuc+hFeKrqlCC+kRM+NbRmSwNtmKe01qR64ucihg+5v4zyZk65JCMCGHc+B9M1ZIcD4q4izv7qrIpp/MzrOL09niYD744xxxj1XtuKgvmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agmZgVN4N2nGsiOcQfZN+IOmFbrhQCd1wk8/8+g/oD4=;
 b=N9YfpM/QHpSvsT+1PgfSe/ye+JhkUqelScsGVfOn+4LEQPad+N4Lo9S+NU8slPOKkhe5jFGAV+QSGHU+ZzAyvqzw4ZGBhLAgUeZw4rJttJmCKQ5D+7pelpfbaIIk3I5PiQaSbzxCelQGpxsXV4jaBDUgxTmVqWQ6kIoXXBAQqpNJhQbK1yRReIsaIz1/QeeOoXJFh98PfGX5wTXDnngmO0Smk8Lri76/v1lnpATB5YWPHVCuipA+3Psn8/SVzlFSdxSsCoghefsFaFozsqEOa4ZyJLIeW5Mb9bLk+ry9Q0paR4ZFyWelK/roh7szkJrr8y2gEfYDfoNr5o3MUw/GGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4385.namprd15.prod.outlook.com (2603:10b6:806:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Thu, 11 Nov
 2021 18:07:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 18:07:57 +0000
Message-ID: <a4509700-56e1-f61e-5b96-bdc5195eb51a@fb.com>
Date:   Thu, 11 Nov 2021 10:07:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH dwarves v2 0/2] btf: support typedef
 DW_TAG_LLVM_annotation
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20211102233500.1024582-1-yhs@fb.com>
 <CAEf4BzZXVjTgZH-t0kXP6rwyA=dxQqc3VAHdmh-eFHY5OdbGYA@mail.gmail.com>
 <e89bbd11-724a-d186-26d6-ce34435702f1@fb.com> <YY1W5FlMlaN6DGaN@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YY1W5FlMlaN6DGaN@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:300:ee::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::18c7] (2620:10d:c090:400::5:918d) by MWHPR04CA0045.namprd04.prod.outlook.com (2603:10b6:300:ee::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 18:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a4d28d8-f286-4d25-4197-08d9a53e3065
X-MS-TrafficTypeDiagnostic: SA1PR15MB4385:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4385AAAF4A6C33ED5415D33BD3949@SA1PR15MB4385.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fUE3fSA6ZlFBGmaCh41p+eKGtMJuWp0HLcDl1zhLPFwW6yTXjGhcx18uenYhUBq/dnOHwlKgpYM0WG2ZrQlTDj9pt+I2qWg2AbYUaS4oBiToSk5AahHosUtz/jhqh3MbVMW7g5BD1SpzlIhAihSAXFS0MWE76E8456wyLIPA5nv18ifazz15ht45TnH7XGiFPGS9xigL+Q39nYW4lUk/p9MHrdV+VVVk7ecvqHUsmUKvP3t0M7jkpdwUp0JZ34GekkpkK5om95ABK6C2v6h7GMxrKHgfc9pcNpOkySJ2tPSojruxrrRettqNphSa9vxAc3OFIbaBEa9CALo4yRiHwOgHukI7KRIEi8xX8OoAYNDEbONa8mo0JtZ4dCZm7J1szoGc4gf/WZurmf7/aKdPDnUt2zYIZOwKuOJPaC2Rt/M+x483Q2NBHvTHESSdYyiZJh4cZlQz3oVErhKH8tX+wKiksfObzMav4of+qH8tELJ61/LbNZc4yQl7kq6n/OzZq/pqUAX++DwpYPuy29H/hetB+DRvZ0xVZfMS6A+Ipp9gjUQ4DgdUzp37pwya+/+HdnW6nmxW4N5WVUWDFR6kDzTXr2bA8VOLroutpMl8F+Z+EJcaUMAJqsZsCWvpTCUKJ3ZIZNUPgtLXyZ5aw7dQrCs+4MNs+AiU8mJs/Ut474FiBvwPf62fzsp+36vMQQa8h0sngKJwky8IYmDShKQyHQRrCEeOjZmIEhrVpfQPow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(6666004)(52116002)(38100700002)(186003)(8676002)(2906002)(6916009)(53546011)(54906003)(66946007)(66556008)(31696002)(66476007)(6486002)(8936002)(83380400001)(508600001)(316002)(2616005)(36756003)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEk4cnFrb2dBaUptbW1HU1N2Sy92TkZHdXB6bXhnZVQyeFQyaGJLaHFzNnZZ?=
 =?utf-8?B?V2l0cVEzZTF1RmZvbDRuRTVya0lUVDBaR2E4eFFGYjJUNk5RRVlZUTJtUkhr?=
 =?utf-8?B?dkFHRG8xeXBMRTFQVlNlWWVMZW5NUzlYT1c4T0doQmZMcXhLeDJJZExwcDEz?=
 =?utf-8?B?eWJFbnE0M2o2TXdqWnk0eU5aY2pOamdwSUEzMmdGVXhMSHkxdytxMG01WTds?=
 =?utf-8?B?MXJ0NTQ1UXdHNWtEaXUrZDVWZWFERXE4Qnp0MHJicE5iQ29LV0tlc0FPUEJF?=
 =?utf-8?B?TFc3UTQ0b0t0SUFuQUw1bER5QUpRZXFHMk4wOW1XVG84NVE2cWR5UXV3VmVq?=
 =?utf-8?B?ay9mdXVCTUxsellBNW8zQ3JiSUc4Rk95UFJwN1A1TWNxMnlqWGpRKzNsaVhD?=
 =?utf-8?B?ZEV2OXFqOE5BTk9wRDgwMzZXaTZZVTE4WFVPaFRNb2UvaVNweWtVSmhKVSt5?=
 =?utf-8?B?WmpRRW52R2docit1NkhidG81YVVyaSt6NlJKWGFpek5vOEtuSzVuYXFmcGhq?=
 =?utf-8?B?aEZVZzNrYS9lbERid2FvYVR5cGpqRWg4dURXVTNQQmdYbEdlMWlDUHhXSVpN?=
 =?utf-8?B?NjhUQnlVbmNNSE5iRE1ucElsNUpmazd4OXBKaTZxb2VIV0RLa1VjVWNzQlQ2?=
 =?utf-8?B?dWk2bm9hUWZ6Qk03bXBUSm5IekhiY1BLSG5qK2hmT0xWUnpRczA2R0xBdTht?=
 =?utf-8?B?bWxiUVVDb2d3bFMwU1c1VGc1S2dqaDhyaDRjUHRDRlRJV2VkK3UvSUYvb1Fm?=
 =?utf-8?B?UmRpaDY2TitXMEFXM0hKTDd6M3VpcjZVYlVtWU5zaHRPVjVxbFBNVlpFRUVJ?=
 =?utf-8?B?RWtyVDJzNE9ZK3NNYUhoWGJWdmJIUzA0cnV5dWJXbXdsaXp1QmZaOGRPR2tW?=
 =?utf-8?B?TGUrZlMzSDkrV1dxdWRESEExZGdpbkZ2eW9Ja1dBYTlBR1ZXWEVlMWVUVXRo?=
 =?utf-8?B?LzVETW1iZjdySmlSRjk3Z29STVdOM0E0cjI2NFRSTXhTRW1DN1FVV2N5ZXRl?=
 =?utf-8?B?TUplbHlXdEplOUJnYk1YZ00zc2N6RVFYNWozbVl0NmN0Qlh1L3FSWHdlbHVG?=
 =?utf-8?B?dmwxdkwzVU5FYy8wbkxtcStKNktqSFo1TjZBNXg3Z3BjNmZPOCtSY1B6cGdn?=
 =?utf-8?B?MVRYTnp2YWdpcENDczF4UkJ3cFYybUk0VHNGZURpMStueTlzNjdSMWEyT2xN?=
 =?utf-8?B?YktRdEx0VTdzUS9yZGJYN0crSVh1ZjhweGZHQU42R3pkM2pENll5SkNpd1JF?=
 =?utf-8?B?NUpVZk5NaUVwVzlYbVN3cEZFb2duS3MwWmZDNHMwZ1NjanMySnIvdjRoZ1VS?=
 =?utf-8?B?SDZYY2dIOEU5Y1RTRkFXVWwzTjBoRWdLVE16NTcvQmhxRUVlUE1BSWRGeGFV?=
 =?utf-8?B?YTJUSkMvOGJFaG1jTkFVS01hQ2tCZExnL1lLNTd0QTBrTDVLeDVrakp2Ky93?=
 =?utf-8?B?VmVyRmdiR1R3b2VDbjgzYy8rQUFaaTMxZXhZL2JlZnZwQlJHa3pQeUVHdDN6?=
 =?utf-8?B?aUxzeXhOcTZVaFF0a1RGYzFRMGFtZnVtOGpFTFZqRWN1T2RQOURYMmJDaVl4?=
 =?utf-8?B?MnBSOFNnTW9PeGdWQWlweUlFM09iQkEzV0E5NVVTbXZUTmZ0VnNPdEFJa21j?=
 =?utf-8?B?MTBQK3JxbmV4dmY4eTNSRUttVGJnTzBaQlNEWTN4eWRFb1NOQjlDU1d5VkZ2?=
 =?utf-8?B?K3FENDNDdUdtRjNsMElFWWR5RVpERDIyWmI2T2pIZGFNMGRLN0JQTHJQaHNC?=
 =?utf-8?B?NnBrS2FLTzFNQXcyYUEvSGJWamtEQTQ2TGd0clV3emFneVZmVUVRMVdiQ0s3?=
 =?utf-8?B?NmJiK1pLWk1MVzhmMzJGOHJnT0t5Qjg5RW1zM0VFdmNsY2hVd0JwNVd3MTda?=
 =?utf-8?B?OHR1KzZLa1c3blhNRUFaSVpTRnkreFBXTGc3M3luQmwvcVgwVUl1VlBYaHNT?=
 =?utf-8?B?cUdkZTdScElpQk0zRU5IVGpsVnVyTS9RMS8rR3l2ZGswQkR4U3RVYUYyelpE?=
 =?utf-8?B?MENhT2RRenJGOEt2b2M3d1NSQWpxVEQ1L2VuWFFnMlh1dXdWQ3drWjhWYSsv?=
 =?utf-8?B?MnRLbTJUa0pxVGwwS3c5Z1VRaC85NzZUS1R3SDVoN2w1VjIxNjF4ME9VUVlM?=
 =?utf-8?Q?y8WVU5jKJGmFzI8AyqS/3iTPa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4d28d8-f286-4d25-4197-08d9a53e3065
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 18:07:56.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTKcCeCaKT/Pi4YLQ9AkZLJJ/WB4oNsc9CKTOhxAM81gvGmf85Kx7xG6ki0B094+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4385
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2S7a1DbKykNP-EMkcBQJqiX_6p8fJWQu
X-Proofpoint-ORIG-GUID: 2S7a1DbKykNP-EMkcBQJqiX_6p8fJWQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_06,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=957 suspectscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/21 9:46 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 09, 2021 at 09:23:30PM -0800, Yonghong Song escreveu:
>>
>>
>> On 11/2/21 5:11 PM, Andrii Nakryiko wrote:
>>> On Tue, Nov 2, 2021 at 4:35 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> Latest llvm is able to generate DW_TAG_LLVM_annotation for typedef
>>>> declarations. Latest bpf-next supports BTF_KIND_DECL_TAG for
>>>> typedef declarations. This patch implemented dwarf DW_TAG_LLVM_annotation
>>>> to btf BTF_KIND_DECL_TAG conversion. Patch 1 is for dwarf_loader
>>>> to process DW_TAG_LLVM_annotation tags. Patch 2 is for the
>>>> dwarf->btf conversion.
>>>>
>>>> Changelog:
>>>>     v1 -> v2:
>>>>      - change some "if" statements to "switch" statement.
>>>>
>>>
>>> LGTM.
>>>
>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> Arnaldo, did you get chance to look at this patch set?
> 
> Yeah, I've merged and put it in the tmp.master branch so that libbpf's
> CI can have a go on it.
> 
> I'm also updating my clang/llvm build to test it.

Great! Thanks.

> 
> Thanks,
> 
> - Arnaldo
>   
>>>
>>>> Yonghong Song (2):
>>>>     dwarf_loader: support typedef DW_TAG_LLVM_annotation
>>>>     btf_encoder: generate BTF_KIND_DECL_TAGs for typedef btf_decl_tag
>>>>       attributes
>>>>
>>>>    btf_encoder.c  | 17 ++++++++++++++---
>>>>    dwarf_loader.c |  7 ++-----
>>>>    2 files changed, 16 insertions(+), 8 deletions(-)
>>>>
>>>> --
>>>> 2.30.2
>>>>
> 
