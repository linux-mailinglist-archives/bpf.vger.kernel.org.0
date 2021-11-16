Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48043453738
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhKPQXa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 11:23:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230331AbhKPQXa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Nov 2021 11:23:30 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGCTHjB012203;
        Tue, 16 Nov 2021 08:20:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UYUL9IfXwDJNZhpysNeJC05qCoL9WRLhr1k6rMcHWRU=;
 b=JCQnw/MnWGPO6lkMjwrI9FCwO65K2wF2iaoXU3r3SEqdq6rWq9RYjGjUWFDTz6lQH92r
 DdVFWc8n/m2xBfJLSgO0TfXvxPkWQ3fJrR+Idv52lDrk4eurv6Fjxfq6JkZOES+qFeeU
 Zqq8jCjXAwbBXgp5MJGpPU19t4oZ8rKtsNU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cccpe1qag-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 08:20:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 16 Nov 2021 08:20:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGZj+BROvTTtA2DUcDio2MfUpzrXk0BtEv7/qBcNfZvdL6FT3KUakh2WEdh/BlG6iiYQHShwdpUjOrQahIchf4eCO425Kp9fCHH16UH0T+3ubAnL8FFDNJcbbQrVrJkCmgCF2aV5jCS4zBNQi+2bM/Pa2LlkGLf2+RAS83GBA5QQOcyJGOAKAQy9zvYS/lmNr9hoWP79FE96DAiGDpi6Z04tchpyUr2wBeFeQgtkOzgf0+9NDdOknB9iLz3lk7G2QAqIVHrrkbSeLV+0rnl1vcO9Ms7rcCqS5R60OxYc4TUjsrWkFFNfen3Z1MSBMZCmWflAEWh/l5osfswLWognUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYUL9IfXwDJNZhpysNeJC05qCoL9WRLhr1k6rMcHWRU=;
 b=G2FtqX4NF+TpoXJtt+EWl2KwGZyaPQSeiDkSSsLXw2vRtkAIsWERuvkRb+Zy2h+VCwP+5Hz8r+xXvE0XCuCCaVir5t707Q/OhxTTqQrvAKwGgBYVgxtNSiRkZsVC1Nk329Rgr16B9AsTLCTqstQaZ0MEPCVIog3L29FAoKwTFfB/Iv8KJlOKNg970vf4wI32NDxVlZUx8b6N8853hqGj6xlWjI6+kOkaHrwiiJnXUDlgPLrPPDdJ2ms8jxeOe0wA6FgulwajWalU7zEJ3PQuJJ5scdmIVCmct9jcvHqK483dpMXGz4aBDXAIgzJWE61JXd8MtZUcbqQw8j+uKYMpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5030.namprd15.prod.outlook.com (2603:10b6:806:1d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 16:19:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 16:19:59 +0000
Message-ID: <d3bcbdea-9e45-1a36-c5a2-29ff0bca2264@fb.com>
Date:   Tue, 16 Nov 2021 08:19:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add a dedup selftest with
 equivalent structure types
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <kernel-team@fb.com>
References: <20211115163932.3921753-1-yhs@fb.com>
 <20211115163943.3922547-1-yhs@fb.com>
 <d7ce592f-9dcd-3bde-7f61-12d46e352dca@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <d7ce592f-9dcd-3bde-7f61-12d46e352dca@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::1967] (2620:10d:c090:400::5:c4ed) by MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 16:19:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b050e06-9f08-4531-a0e0-08d9a91cef6b
X-MS-TrafficTypeDiagnostic: SA1PR15MB5030:
X-Microsoft-Antispam-PRVS: <SA1PR15MB503000A7C6EC650B772042B1D3999@SA1PR15MB5030.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NN7ufaY7QtQiavQoVTwbVoNB93BvCPJeZWgZ8agQOkjAHx03VhevPeA5h1sGyk2mzXctWecb4ZIdO0n6ZBmR7xgCs/ghLzJB6bunpWzQVSI6dy+hzX2poJrVGF58+eP+RFFlt3oQsyfuwgA+Ov6jSYINaNK45lAO0NnoGSwYXLMjEMxtECrsZBKM/YzWSmnQKUFIMZYjYj33aZ1E/a7ZoHcezrE877a3N0LAwUfK1daEu8FyVvptRI4ZpjDGtBZm54gj47uIK5ebqgq9YyDsds0uQ9jN28B6+9aGQOYHrC55cAMBRSWP49J3dqygvhpjME/SAGIkVyXm302w86WejCpS1hV6sC+fh9zfIlmgeM5eWyrsFBPS5sT9Tsok7KNF14+VBgCK440rAIcilfONQR33IoI1sp49mylYm28qGwCRLkCWYVi9X0onH9i8k7GjkZFGrbA/0ZEbKPh5mz546Ow0YLAat96J8goir6+fAJRAHq1Kcw3tkwFPg+VhAwgZVRoOE2wtHf4SM7jMVNYP3defKZK9+rSkO+WBihb/zLOPQrPVlesPdoRL6zG5QP6qFKFLuoz9a9XUYic2ueRwDpwcBgo4kIIRIc62sj+Muu8DNHFEzldiVAy/A9hDlkzpV/o3Z7GmKbp0iopvYDHQriaMziQZlAhEKVpzZSBL8y3NLiJ4A171FoC5MJHCQg7e1Up82+fSL0zW/Dfw2JsnyHOPzlNy4l2MeHX1RPBGVt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(4326008)(66476007)(66556008)(66946007)(8676002)(38100700002)(508600001)(5660300002)(86362001)(31686004)(186003)(54906003)(52116002)(31696002)(2616005)(2906002)(4744005)(316002)(6486002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1JrQ2drY2lvWEo4Q3dlSk8wT3RXQ0tIY1h1OEQ2TlRLeEtXLzRPdmwxbTN4?=
 =?utf-8?B?L1drbkFhQ211NFJsYVA2YTZmMFkrMHo1cUg5QUp2bWZkSVNGc28yWGlpaVJx?=
 =?utf-8?B?MlJmd0RtakhQVEw2aE5RMzRwSWVTWG5sYmo3cllVdUxwcjc3RmhMd3Mzc252?=
 =?utf-8?B?K3diZGpaVi83c2N2eUxWbW5ad2dGYUx4RlpuVFFZdG15b1FQMmdOM2ZxK0Rx?=
 =?utf-8?B?RVpSVGlVUzBnUHhLbTc4ZVg4TEZvelAwaGlneUpyeEs5UEE5VU1XTGpYTE1q?=
 =?utf-8?B?ZXZyN3ZWS3I4aUNNQWNUWmlZRjZQcFhWaDVNcWpPbDB4WWlsWGxKdEtWTFJq?=
 =?utf-8?B?MjFMWVRCSTEyZnpyVXQ0T2JFd0RrdS9EME50a0dDcVlpamhJVlBBNmR1UTkr?=
 =?utf-8?B?Z2EvNHBLallDQ0czSmNjeUNrMmprY2lhUyt6QWZPYnZsKzFrNWNmK2pIYnQw?=
 =?utf-8?B?c1cyWTAxRmptaU1JcUdZZHlxYTJCU0VkL3Q4MTBCV0NFS2wyelBMMGJsT25n?=
 =?utf-8?B?TVErbGZQbklRWkVXNzA2ZEwzOEMxUnZsQnNpTXY4bG40b01KUW0wM2g4SEF4?=
 =?utf-8?B?MG84Qm9DV3YrUG5DTng4STRLV0NuRkh2U2R4RlZJOE5STGlxQW1hSStMcStX?=
 =?utf-8?B?dytzVjJyTE1iMmtxMTR2NWZOV1VmUDNhZlBCM1V1REdKaExQU0wvNW90Z1ZW?=
 =?utf-8?B?eHNON1MvL2NkQXFDWXFlTXUrdzRVWXhrOXF1WEV4c3Jyc3ZraENWK0lBOXBH?=
 =?utf-8?B?NlBidEJ3RTd1RE1aekpZN0QvbjFvZlFDMU84RFdMSmNrRHU2ZlptZGk2OG1L?=
 =?utf-8?B?YVZrNVhiRkR4UjdFZ1FFUGdmZ0EvNG80OFk5RVJvMGJHRVhJYVVONE9sQkZx?=
 =?utf-8?B?OUxXVHJDYitUWG1EWVhscDY4SXFmL0tnNlpIYVE5WUFxc0hBRzA3SjBvNDJR?=
 =?utf-8?B?SmwwUDI3VWtmbzQ0Vk5ZYmJnYnpxaXdsb3Q0SHJabzdxZWdQaWcxc0hncXIx?=
 =?utf-8?B?Z1FxY1orMjZ6blhLWVhWTHlXQUdXSDRFdTc2WHpnN0gvcWVhSDdjeVFZLzVW?=
 =?utf-8?B?YVEwdUQ0cHlTR3lGNk5hQVpCQmk5bGVWUmZ2YUdVcmttZkpzYkQ1YmRuSS9I?=
 =?utf-8?B?NGZ2Q1ZlMXJaTDhUL0NSVlU3T2lOQStid01YdlZzUGd1b09qVnlvYlZ4NVIy?=
 =?utf-8?B?T1Q3aGdHVkQxZTNFaWpsR2hIZHdHVVNwWWhNZi8wWURId2lIa3ltNnhXSkhN?=
 =?utf-8?B?bzFPdk1vTnZHS0RRcUlsNFBrR3dOQTVmUkR2KzNPRUIyb25UZEtVY2pZTk1N?=
 =?utf-8?B?ZHVRdE9TbjZDZUpZR0x1OFlUd0FhRTVsU3pFNWNoMG5rMmpJTVVEZjlnbW1F?=
 =?utf-8?B?ZldkNnJ0YXQzM25UdndnWmVwb2NzcWZjalAzaXYvRCtETnVkdWdYT0h4NUJ3?=
 =?utf-8?B?dVl6MXF5RVNvdE9qeExONTFNd1BXN015eXFHb0xRQnJnMytBQWZXMFVtYU02?=
 =?utf-8?B?dUZmTmo5Qk9VYlcwNFhvM1F5bGJtWC9iWWNNeDEycVhlYnRGOXlKOXpHQUh6?=
 =?utf-8?B?bEIrMFJGQkdiM3RkT2kvVVBjcVRsRHBpK2FtWXAxS1JpVVMzWWgyZlZlT0Qz?=
 =?utf-8?B?MSs1N1RBTnlaRkl3Y0FvN01jdndvV3cvNG5YQk9PaDd6OG12dHpFa0VJZUoz?=
 =?utf-8?B?bFo0RjI4d2lKbWxONEpWSEVTVGNmMithUlB4UWQrZW13eEdmTVZPWGxHM0pi?=
 =?utf-8?B?c21qeGFJbkVCWmVKWUJLdHhFbWlKTG1oS21ZQ0FvUDdGQXZVcnBHM1VRQVVr?=
 =?utf-8?B?MlNzbHh1TTZXbEd1MEpNK1huODBLT0lOS3hHVUVBU3d4RXZnc1R1ZE9YUEZD?=
 =?utf-8?B?bWVjVUdFNVBOelh0Q2xITUFwNnNXck1iTi9XSFhlSFZEdERSeGR6UWVoaGw2?=
 =?utf-8?B?Z1QyK3JwWW5CUkhwNkcyWFdwbmtuU01XazYyQmhKc2lDdnRXREZja1QzOWVI?=
 =?utf-8?B?NnY4dW9Yb2gwQVNWbmF1R21sa2VCcFpyN214UUVtZHFIa0JCS2JiRWxVc3NH?=
 =?utf-8?B?N25Bbmk2T0M1NGVDUlJIR3daUnJOUW9oZmZxTGpzT3RUZUxVc3lYL1RGcysz?=
 =?utf-8?Q?E99E1UmQw1kp1h6YTueg8Ghs5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b050e06-9f08-4531-a0e0-08d9a91cef6b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 16:19:59.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8Z9QJsKuBg0CMMQFBFcmfUzMk/iZ/Aw/q/jaTOXiiR7JQo+2CuZchGU6qgvPFvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5030
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ylQL_AnbyMkWcwbKwY99GGOYWTWAkzx6
X-Proofpoint-GUID: ylQL_AnbyMkWcwbKwY99GGOYWTWAkzx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160080
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/16/21 4:27 AM, Daniel Borkmann wrote:
> On 11/15/21 5:39 PM, Yonghong Song wrote:
>> Without previous libbpf patch, the following error will occur:
>>    $ ./test_progs -t btf
>>    ...
>>    do_test_dedup:FAIL:check btf_dedup failed errno:-22#13/205 
>> btf/dedup: btf_type_tag #5, struct:FAIL
>>
>> And the previfous libbpf patch fixed the issue.
> 
> Fixed up the typo above while applying and also formatted the 1/2 a bit 
> better.
> checkpatch usually has a lot of noise in its output, but it would catch 
> things
> like typos when quickly running before submission, fwiw. Anyway, thanks!

Thanks for the fixup! I need to remember to run checkpatch even for
small patches!

