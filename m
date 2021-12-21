Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC92E47B674
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 01:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhLUAbk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 19:31:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30252 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbhLUAbk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Dec 2021 19:31:40 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BKNDeif017735;
        Mon, 20 Dec 2021 16:31:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BO2AEwXSAbX/nGEBXBO9+MXTIgvePlWYZmy5TmoDX1w=;
 b=BCOEDcgzdRVL2GZm0q0zUUgKUx3Yzk6/AHMceGcoL8rqVbSJsokPSMT0VSN3TnCr7KPU
 ioaYs/TgLe6OGpW6h/76JVNnKgBte7cS6xq3fhQRk73ubwzq92bmdML9xYv/pdJc3Qlb
 qAt9RT5HCP6YMmw8lLGSzEOm2BRhwMUqivA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d300e1puq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 16:31:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 16:31:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsgsc71WnmyAD04AWiF+yepaLbQbH4JC5/9Ko9bAbqm7+iTYYymFnEkgOB4UUChClHd9rwoEicgyZ4oPEnlk45ued7+44GpQbe+lJZJFu37RCpdmwGXeZ10pojPAY91eUXUuLKL8WHfoZ+tn+dcGc0+jVK7gri537aDOPG6oBsMAOLxP3Ar7rc1NpBZusTB1lZyB/vrbpavzx6cvkI4zYd5hJxdZVSRPd2Nt2Nop64tr8P9VmW3Os219wnZmXi5kn6w/YAvl6ybHZ2DPTiQ+3fO0/PiEsEeodXPVu50VOTbJc93qI8BF/T78+oR98gCc/xVZAFEaD4wr5orDtvc9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO2AEwXSAbX/nGEBXBO9+MXTIgvePlWYZmy5TmoDX1w=;
 b=nj63leBjpl+8c8qxi7IMSqibotLbpQX9W6EA1+st48RSvHNvheUKp+JVcRf3pONCMX4zPG39AMdXA40smHhVVejUaFzK6CAAmXSVBgRTG7IzUXIpNq9WZCXHLz3x32LZJ3F1VHQSzenvwrWRBu4quwWLDBf/Ef469WGo9I4EOPdxU4V7SgxuouWB/NrO9HF2MhqSnVc7Q14RUYyRwcxv0f9KgNMNhTUJeU5rayWYJjrKdYr7EBWMahS/0J3uep+nlRWgo3cna0bZ/p+ZhRrNZcLgaAudVIa2PSzLfZNB5c/73OPSIPmbpvNxO2L2IApeTP0gvsQLrvMFQlnv486ACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4388.namprd15.prod.outlook.com (2603:10b6:806:193::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 00:31:22 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 00:31:22 +0000
Message-ID: <d04939f7-17b9-1016-2325-131666e143db@fb.com>
Date:   Mon, 20 Dec 2021 16:31:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf v3] bpftool: Enable line buffering for stdout
Content-Language: en-US
To:     Paul Chaignon <paul@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>
References: <20211220214528.GA11706@Mem>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211220214528.GA11706@Mem>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0039.namprd21.prod.outlook.com
 (2603:10b6:300:129::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4645b132-f986-44df-a0c7-08d9c41936ed
X-MS-TrafficTypeDiagnostic: SA1PR15MB4388:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4388BE5379C9C387A26033EAD37C9@SA1PR15MB4388.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lmaMuMxD1f+t0KoyrGVKmi2iPi8K8NOJAqPgk77ILcRTilb8T8E4CIwkgV05mFG+i1vWt0JkTEI3sp/Sl1lBH+dJFnjBLJetdEW3Vx+t2Jb52CUbTP+tRDIvb/CK9jaCPT2VEULbezmHj2oP1BEi2UT6aflQmOHkYW5tEC4ayXK1D3Zwk3k+6eQzP6596oLeo5fDRFPTb17ufz+HK3fz43yvmlpZAKQ0RIuiOh/sbSmgDhzy5shvodjG1m+gSo4irXKpvKN+rCDRkJejSPAFDa11Jq748okuSluzQqrkxFpAGs3FNgXAS4qcdau48l5Ac96Ci0jq9wktdSJ8fYpUu6iZYqcboCJ9fo9Qnt/v5x3VCcsv0Lv3lGCb/cVR3zD6XimrbNX2THd7YxPmrrozgC4R7kXrd/uCaXgkcs0mtKwS7Uj/zFxN+lXkoURRP3DIiytbnkZkWqLf4nDC0O32wlYcpJywfjCrpadCBnLUgpBJd6T82g24Al9iptXzwPQAgFm5iN52SBejF0e4piJKYMU1MA19vdQ53SV/dsIeF514/LfRjetwUPk0MSPq9vmBdcMmC3LNTYWx039EfSvJkcXpIYpcCKeOHNxO/rsLwC/RLqM3fJ/j8fcTvtKSCYr6eTWi/tuFi3v/DXGIbWtnfQFYIei7xAzI5qiM2Dv8t2ogDR7IRi/x5Hk1i6eCZ6+D8ueFoQN+d7OaMMtX9RvfVqgkoZ/eLr5jg32zdeXxdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(36756003)(31686004)(31696002)(66946007)(66476007)(66556008)(52116002)(110136005)(5660300002)(6506007)(53546011)(4744005)(8936002)(8676002)(2906002)(38100700002)(2616005)(186003)(4326008)(6512007)(6666004)(86362001)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25nVXVsTHdtbEp6ajlBczlTa1Bwbm1KRm9Wd3RmYjcxQVgyUHUxRmVPZ1hK?=
 =?utf-8?B?Y0tsQ2NkSzNVUVRnb0EwTVhCZzZvZFpwVThKQnlXL1o2MTdPYVdYWmZvWTVF?=
 =?utf-8?B?ZkkwTmJPVk9YenI3YTlQZjJhbHFRdXZpRHVnamE1ZXlveWRya0pkMkdSZWJP?=
 =?utf-8?B?bWJsTEswb1J5U1ZTYWx5YUNEc0E2WFQwSnBjYXhuaGJYUmdjWXM0cXNLUnVY?=
 =?utf-8?B?bEJDUHR4dWVtWnRTdnZMN3BST2Y5Z2tiQ2NOSXpJMHVNZDNQb21jR3E3cGVx?=
 =?utf-8?B?RUN4R2tyeDk3RERwdlZDeXM2R2ZLTmxYV1ZnU25peEdGZGZIZy85TGVFK1ly?=
 =?utf-8?B?R0lnTmFUWnlPek5YZ0Y3amZub1lSbU1QQlZqMkpvMG1OckxtNndIbmV0WStq?=
 =?utf-8?B?WHJQdy9sdnJ3RlhPTDNvVEhScE1mRm4yVWErWHdZTHlhVVQ3NlhvaFMwdHAr?=
 =?utf-8?B?MTVzcDBpSjBDK3BWN3hxUXFUNjFIUTY4WjhXOWk4NG9MdFU4SERDak5yVjgy?=
 =?utf-8?B?bXl6a0RscjFKSko1RXVpOWxKMXdvQWJwQXM4eERvQlE2MkgzSWxOT3BJMmVl?=
 =?utf-8?B?NWcrYjJLL3ZFRzJxUCsySVJ6cVhoVkZQcTZTNzc3TEE5cllUNHVvUW1melpI?=
 =?utf-8?B?TzB1a1d4S3FGMUExN1JMeCtIUHJOYm1qUkpVa202ODNwK3pxU2R4NmpYZVV6?=
 =?utf-8?B?b1VKRVhLN1J1N0FkcEhHc3c4M0hpMnEyclZmUHNNdUNrSkhkWGNQOWtvNTk3?=
 =?utf-8?B?STc5M3l3aDNpTFBINWhoRzJiR0ZBT3hMaGp2SGFvYlNNSXZ0TWdKaHRJUmpC?=
 =?utf-8?B?aFg1YmIyQ1hmSFRYR256YU9oVWJNMDFrcXowTGxwak5IUG1TNThpVXBVYTNG?=
 =?utf-8?B?QVM2dHZMTzNHb0VmNkhkdWZjQ3dBWjg2cis0bEtSSWp4dXRCSW9RNmdZRy9G?=
 =?utf-8?B?Y2FjUVFadVZpMThuRTV4US9VaEtFcUs4V2hCUWQ2dUZyL3VHakRtZFZPcEQ5?=
 =?utf-8?B?V1pSTVhjdk1WMUNBSkhZVWt0Y0FXM0I1Ym1MS0tvSlkrVHg3UTc0MnB2Witi?=
 =?utf-8?B?cEQ1T0lDMUIxc2NIR0d4aW9nSUc3bDVmTlBIc1ozQjMrazN5dmRjSHBQb1Ru?=
 =?utf-8?B?ZDBVb2ovdHp2YzVzT2d4ejlmY2lGWHhSa3B6dHZmZHZySXZxR2hnYnRjWWNo?=
 =?utf-8?B?Ymt3M2RNWTQ3TlRGQVdZUTdFWHlEa2xSNXVXeDlSa0tDRFRIbHo2UzQzRG9r?=
 =?utf-8?B?Y1EzUFFyRUIyeXZwUVB3NGlyWGxiSW5ScWxpWXIzTS9PZjFrNERNTFNabXVi?=
 =?utf-8?B?L3Vxc2tKYlR6K0JpUlZrVWxERm00ZDZaeVZnbkZRRnNWRXZQK3lsTndyb1V6?=
 =?utf-8?B?SElmbnN5K1o3K2wvT0d5eDV2ZzZsNjlvb3hjUzlrZlFra1l3dkMxbnZaTklK?=
 =?utf-8?B?K2lRVGpwN1BISkoyTzlocVFDY2RDejdpeXQ3K1JzNWwrWWZkVnlmMnFLeUFN?=
 =?utf-8?B?R3dub2Z4djlLSys4MzEwMEg4SG9XUU83M3JRZXdXc2RnUEtkWXFiRWkwWmxy?=
 =?utf-8?B?em9GbnJFZUd0YkV4UkxuTTduWnVyekg4WiswbHZia1I5Sm5EejlsN3pKcEpQ?=
 =?utf-8?B?bURyQndKNUdnNkcyL1R0citCTGZhbVFJWTRhdnYxcS82Z1dNeFQ0MXBja01j?=
 =?utf-8?B?SnZieEZqTElhcW9md1BBalRCSG42YnFGZytGeml6WC84bWJscEx5bVNiN2h4?=
 =?utf-8?B?U2xscHJPbFBRZTdYa0RUTzZNVGlJLy9qOWR4MkU0K3VLaDNNTkNDV3d1ZW91?=
 =?utf-8?B?QlNJajM4cmZtbUZlSnZVVi9BZ3g4bnRudjZKSjhjdGxHdGRWUWRLeDFDaGl4?=
 =?utf-8?B?ZmZub1Mva3BacTlPbjVHR0NnSEY3MmxsU011c0ozYXhDaXRCVE5HSGFyVlRZ?=
 =?utf-8?B?SDdycFFKUE8yUHNqRkFtNDVpZm8xYnFrbVBkNlZvTHpTWVdtejF1WGhrV0dD?=
 =?utf-8?B?M0lKelBYWTF2NzE2V3FUdzAzYmhsb1ZScGVUVFpNSEUzZjBoc1Q0TnA0c3hL?=
 =?utf-8?B?RlhyaEtHZFc0RE9MUmtHa1RlK25xcDZTWVg1YmJVbWlWR2p1TENkRXpzRXp6?=
 =?utf-8?Q?gucAQBya3lX5kaslQgG+SMvTg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4645b132-f986-44df-a0c7-08d9c41936ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 00:31:22.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT9IuAdW7c28i5XSS0XdCnwiFSF3yQYkyE0w2CYAFgUUYE/2nvCFpmHGzOn3dG1Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4388
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ZfN0K8e6ShofS8a2QxBMAs9M8BuLVPqs
X-Proofpoint-GUID: ZfN0K8e6ShofS8a2QxBMAs9M8BuLVPqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_11,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=657
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/20/21 1:45 PM, Paul Chaignon wrote:
> The output of bpftool prog tracelog is currently buffered, which is
> inconvenient when piping the output into other commands. A simple
> tracelog | grep will typically not display anything. This patch fixes it
> by enabling line buffering on stdout for the whole bpftool binary.
> 
> Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Paul Chaignon <paul@isovalent.com>

Acked-by: Yonghong Song <yhs@fb.com>
