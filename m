Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07240443CF0
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 07:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhKCGK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 02:10:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44484 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhKCGK1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 02:10:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LbRHe004797;
        Tue, 2 Nov 2021 23:07:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=D3oHIt34mn2YCq9s/jxBsK8LjqAzyUxGwG6Sr1k48Vk=;
 b=oKXEE5qCGMNKsy4RX6Zue7/gQ9eh5TeMr+tqDB+Y0qh7d6sv4PPZRqlTN1HtC39yqzie
 aeKeLhXGOotirOKXtYun1Xb1l8gIr9UTx26I1OgtiyPukYJ/1u2MY6RvfCad4Du7NfVE
 JpJcFpG7xOfmxR8iYQ8X21duUExwjBgN4UA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddfjh6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 23:07:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 23:07:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUVc11ZwUV2C0KUUW0YC3yMMV5ITTqR1l26YXhibZWkmthcjmyzdwFToJgZFusLG3Ehc/Nc2YFcdmn49yoXjTuCf/9nSto5cPuf/HbB4H11VfsEMzV4NHEPCKdAb/hvgH8HexLib7hOAtY6Lkz7dXLjYXPJ5SmHSUA0f4g7ndtqmNl1CzZPFZ6R2PhgGBAgNjeG13ZPaXkiymyDvTyFxEu+MpqEXUiIPZXmdKKCcfis8YuXi4ggdOS8oOuvdHYTwtW6hsbGLY0lwd1tRqEeoErol/FX4TCH6JYiWrlyl9PYqWByY3VZ5oNV7w7DBsWVA35XbQqBGbykdu1qaDwPiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3oHIt34mn2YCq9s/jxBsK8LjqAzyUxGwG6Sr1k48Vk=;
 b=Qwuf9iKdO1uud7gGxWvP6AdKl2rDluhjkzUZRprygJj84OpHEzdBLgxuygzEuEzXhr5gTIN7ZvZ5MpI8N4Wn9XCi4PP5PnwORnVes+b+C4Vu0EBbSKlwzNzPDN6vb8eBrQ5U/BWwLDfoM0H41KYGUO+Ql06H6Byo9OJjlOnEOfHbZOftVfsAI2yyGtQnUvdVNr7BBbQOD74NxooyC9892fgu7/HjlA/kHc6OXybDzDS5O2M8AtmeUqVyUHILLH2QZcBhcXWqhN5iYUKutg5RylnRrhFB7OaYhES5CXWi6TA4R0Ox4pwfrugNtNVsB21XUaskwN0220LHnt3B/AdZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 06:07:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 06:07:37 +0000
Message-ID: <f17561ca-7348-720e-7009-aea2ef757a6d@fb.com>
Date:   Tue, 2 Nov 2021 23:07:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 4/5] libbpf: fix section counting logic
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211103001003.398812-1-andrii@kernel.org>
 <20211103001003.398812-5-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211103001003.398812-5-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1066] (2620:10d:c090:400::5:b3c5) by MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 3 Nov 2021 06:07:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb1a7242-33e7-478a-2a26-08d99e903c65
X-MS-TrafficTypeDiagnostic: SA0PR15MB4016:
X-Microsoft-Antispam-PRVS: <SA0PR15MB40161C6E7507E6092F025ECDD38C9@SA0PR15MB4016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daYnM7HCSCnwzo9j3GXsDFSKtLkwPz2KmeaE9HWu5nyZ54G0ukNOZTGdbRdPus+jy3NMMeNrJcOkT0gZCVEeleBWEX5gez01TUn912Tle1cqASNKZm/L0hszcCWN5EFaxJ8nryrST7go2r3Cno29nYpqvXaPMi1CCfY1lS6Kzm1G7u8HhgkZWlYbwzyM6MHy5szK2EDMwcPjOb9UEt1b8+v3GUzDTdeM1zVCmBnbsSwMgBdpQnLlDXbyxxGK2y2tmVj9Z9mgfK967lfFXha9IEu/946OjrOaB7zVfY2rHk+YcqW94SS+OGrEkMPluTbxz0tCpr6nKffuD0wZ9uuBu6hBJq2aOnxXEk0+ELfG8auPjdFGztHtDPDl6JROWCb6x4stIFY0pzAF7ZP5M69Z1nMETNnkj2/0GPAGGHhNs09h0wvzlrLuwsDX6U7yHm5fOPEwmGwwJ8P3uy4YIUIRV7VJ2K7ziMfR7rOZtEdRYJ+K7wqamx4UyqnDVViOZRQKsSWRERUwg/gr6O+zFG1pZMtRknoEw9rAvg2niAToy/CXqpMc62weSQ9yKlYBYeezWWo7X6tm+x1XxkpshXSY8BJf9DJIcMAcpVIhQrajMoP7qlW/ANhmQpkF1k19G59fAYwYzVGFguuiIP47EMWb7InN5x37o1AgrwOYQSSqXaUOEBpSJNH2+iIWhTay905CAJrrVFLM6s0/P5SAgFUAPXz6QGITe/AAESpDUSqo2qE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(31696002)(4326008)(86362001)(2906002)(186003)(31686004)(5660300002)(66946007)(2616005)(66476007)(66556008)(6486002)(4744005)(83380400001)(36756003)(8936002)(508600001)(53546011)(8676002)(52116002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG8xKzQvYzdrWCs0eEZ3YU5LS1hOVDhsYVFJT3hyaXhKQ3JnNWJJeXZUZm9h?=
 =?utf-8?B?YVI5bWthbXRqNUNlMU5MT1pjazNZNGVac24xSW9kcFFjQ3ZNRmdpZVI4TFFq?=
 =?utf-8?B?YnJxdHMwc3RFNmlUVWozZkdxVlZ1UHZVQ1BENVJQVFpEb1FHdXdzQ0xoL0FM?=
 =?utf-8?B?K3pJdGw1ZnZKVjFsQXlXb1NrcW1obkNqNEZRV216NUZNVHU2c2NZaDd5S3BN?=
 =?utf-8?B?M1dnb3JSam5vYUFaMTdkdUkyVU05REtYOW5odEJHYkpWdFU0VnlmT3V4SEFl?=
 =?utf-8?B?USswSG1NNFArU0I4OEpuTWNMWnl5SW1LQ0MwS1pjclp0RUhVbk5jTVMyTEFL?=
 =?utf-8?B?a2V6TkRoNThhYmRkWXFZUHZJQzhxOCtkMVAxdUM0eG9vN3lmdTE1T1VHeGxq?=
 =?utf-8?B?WXE5M3ZxcDNzdkhlRG1lSUw1QWZ2dldiOC9DSDdBOVVJeTI3Ym5SNmJLb0s3?=
 =?utf-8?B?VmVtME1zbGJUSkNPekowM0wzdnpqZFE1R2ZxVU5JZ3dHc3JaazhzdmczWm04?=
 =?utf-8?B?cDRCZWcvOWNTcFFTMy9iYUNXZ0hOKzE0VmtjSU82cU9FSU1ESVdjZStHa2JY?=
 =?utf-8?B?Rm1LYkRsNHNSaVNFNE1vR1RMWDB3VVdGTnJlVmd3cHlBZkF0cENKelhkL2xL?=
 =?utf-8?B?L2hYVkswNmtpMmFJb3hBREYvR1Q3bGJBOUxyaUh0aXl5d3BpbkNNYU9IVFRj?=
 =?utf-8?B?bkE4SDJGdFNSV1V0cnNlemU4aDBSOVJNbmRTbTgxYlA3ejl0bVJFRU1Od3dk?=
 =?utf-8?B?N3Q5YWVBMC8rbkZiUWUybHB1SFpVMUI2cDBqK0FmQmdCUGNTWVhSWmp1eXQr?=
 =?utf-8?B?M3RQOEowTEhpZk8wc1p4NDZaYzRnVldyL0RWeXd5OTFvb0dNb3QycVJCYWJ3?=
 =?utf-8?B?M09RM3NtMitVdVkrcVJHSlg4Y2RtcERGR2YxMVFWeE1pRE5zOHArSVg3V21m?=
 =?utf-8?B?S1lrdC9UTGg4cE5ZaUJDVWpXdFErOVFTN01YUVNlVms4emZGS25seU1Bb3BG?=
 =?utf-8?B?WGtCQ0xtRTd0NENRa09zWXBEL0FQMXIrR2wyRE1FQzJqVEtCajdnVjhGVUlG?=
 =?utf-8?B?Sk4xOG9oS1htdDltTzBFeVh2K1ZzdW5sRFdDL3BmWTE0WnJqWmo4T1RGS2gx?=
 =?utf-8?B?ajlLMm9reWg1Snd2K0RVMlNJK0pES0x6VEVvZzJoa3Y2d3lLbUIweWVkRTNt?=
 =?utf-8?B?QnFWL1V2cDdYZ1VJOGswS1dSL0I0Qy9YVEN5Nm9LUWJkSU1mVlBYb0xESWNW?=
 =?utf-8?B?aXNjRWpRUmxJbFhldlJVN0Juc21CclVzQ3ZSelNCcEVCVHlvYjUzenBrMDA1?=
 =?utf-8?B?Vm9XNFprZDk2SVM5cHlaeHhPcXNpci9HUmpKZUp6bC9CdTlWNndGWlNvY3Rw?=
 =?utf-8?B?dSs3Y0lsaTVGM0Z4VEdTalZlcU5sSW5yR0NGNVdxM0lEWCtnaWtvaFlkb3U5?=
 =?utf-8?B?MU1VTGFacFV1QiswS2VDbjNDRC83d2tTdFJnWEVaaDZtWkJYY3RBcWpqQ3dC?=
 =?utf-8?B?N2VvdGlzZ1d3R2E1cU54d3ZEY1RXQWZoSUJXRExEMmVLcTc0OXROZkcrVzRj?=
 =?utf-8?B?amZGRHpaTlVmb2JDcTVDNXROekZtVjVpdHg4MzZoSHlBdDhoekhkNXp5dUlq?=
 =?utf-8?B?UjY2Y3JwNnIrSUJuaGNNQ2hCb0FEcHRSTUNuM3Y0TFZmdmlkeHZaOUQ1WGE3?=
 =?utf-8?B?NzVTWW93L1dsaUVLbE5SYXB2dk1WT0tVYlBjalMvR0wxdFVnSDVTcUVBT3lr?=
 =?utf-8?B?UzAxMW5aS2lYZDkzUzA2aStILzFtanZCemtRNUFiOGFBS0RKUXdFbEkyNzBh?=
 =?utf-8?B?YTVmYzN2WWhsenduSFBmN01US2NTdzZrU1g1QitsRUc4VUZJQlpvcmQvZUgy?=
 =?utf-8?B?ZDBnMUxpQmdZK3g5U3RCS29Gai9rVVFVSzFKaGJqZVo0bzRFMEU2VFB2dE1Z?=
 =?utf-8?B?bUFTUEcyM3podkZ5a01LSTVGNnJnR3dKYlRuZEJza2doVTQydllYRUY2Smxv?=
 =?utf-8?B?dWFvcjBuelE5cGpTR29xU3kyejN1MENOcXBlKzdVcWlTTmQyTjAwVDNML29T?=
 =?utf-8?B?bE5kQ2k4KzRaRHZoSldVQ013dDZnT200aFBTTzBua2FoblhselpSL3hZUy9x?=
 =?utf-8?Q?r52HI02LzlY13ft3DBQUhW3s8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1a7242-33e7-478a-2a26-08d99e903c65
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 06:07:37.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3FR16I2jXT5r8PMkzHgBKdy79r5c9emXHRy9Rdu1I550sg2+ym7b0Rn2kA9AJFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: vex3V_n_KNlBUsDdRFfOPTg8tiKg98LU
X-Proofpoint-GUID: vex3V_n_KNlBUsDdRFfOPTg8tiKg98LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=890 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 5:10 PM, Andrii Nakryiko wrote:
> e_shnum does include section #0 and as such is exactly the number of ELF
> sections that we need to allocate memory for to use section indices as
> array indices. Fix the off-by-one error.
> 
> This is purely accounting fix, previously we were overallocating one
> too many array items. But no correctness errors otherwise.
> 
> Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
