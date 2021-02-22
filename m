Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92F9320FE5
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 04:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBVD5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Feb 2021 22:57:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53572 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhBVD5W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Feb 2021 22:57:22 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M3s9JW012321;
        Sun, 21 Feb 2021 19:55:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FTcZi3jl1A5QaqyOKEp9oPNIux3a41vReEHNjU88zsc=;
 b=R6qQLpgRVzNPVibMISzSiw6F7CNvfm6IRfkZAMKrhyWU6EbdRvgAY9cpE6TdezAcxYQi
 vytnMG8xJOW6oRQVMx+5NMUCy1EwhdnF8TXew0Cm9dvpOhbwyzE8u/vChfnWJfiEMM45
 AHMzSVNdj8jMw7WYKOj45fXsDAFFjx/RRkg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36uk0mty2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Feb 2021 19:55:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Feb 2021 19:55:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkx9rfCQfr8PF66rnqothGLSrQQZX9cWHEry5JI8YkitmjY+RTRtUXbFIOVOVg/eBMgITCO35xwp/uEtjV7tfIxK57Of4e/CWmdp6wAGMFfkc78QqGEpZAmUXOR2Lh54X7hi62fZb4L7MKQ765kx++DV4P8YayHrk05ngGQSP+XfWXPGzj2LKETxBMq2NMt0N8wVvJpngZB1jHchIO5bo5nZo/R7+Kn4heoMPyIAtX4vUKDUwpRDqzdsPNH4dKIbJjdnIxABjbzOQOixOEooLxWkDQCEQKWEiwoobYSzlEuxq2AmTWlxPr5hvrEJ2doTYWzXcJd+CNPTkuGJDkuIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTcZi3jl1A5QaqyOKEp9oPNIux3a41vReEHNjU88zsc=;
 b=lVMFNZscZ2rgeWC5mEvVZHbGVB0QxX1lzEfVcixXxlJ88pPY52u9/VKJjdpuu4yRtKPrK+RT13cTSW9Lx7ndlPisE81RsajW0KPK8qvc8ro2t45biGm1ewSsTcj2cGjTc/T54FmBdSVuGwpqmrZESSZCSmN3JqvcLxPOtcGZ73lQLv/Iw2Dg7q9L/C7pDWmln4mdY0pgKidrNtjBav8JzBOORvr6npGUd1yE+2VwSEgzlq1nka2LLYTiD5YVnwqcTkvil1JBOgoF+2xPYKAOn7Lj1TX5Q8KwRBsB7auFOFIu3HTlS7xwWUDfnqdgIaOW5dMzrUlNR0xm5BCyGc4nZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1577.namprd15.prod.outlook.com (2603:10b6:3:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 03:55:21 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3%3]) with mapi id 15.20.3846.042; Mon, 22 Feb 2021
 03:55:21 +0000
Subject: Re: [PATCH v3 bpf-next 6/6] bpf: Document BTF_KIND_FLOAT in btf.rst
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210220034959.27006-1-iii@linux.ibm.com>
 <20210220034959.27006-7-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <995c9b8e-2194-61cd-54b0-95c4f8ae0041@fb.com>
Date:   Sun, 21 Feb 2021 19:55:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220034959.27006-7-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4afa]
X-ClientProxiedBy: CO2PR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:104:2::11) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:4afa) by CO2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:104:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 03:55:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343205d3-ae0b-4a4f-c97e-08d8d6e5ad63
X-MS-TrafficTypeDiagnostic: DM5PR15MB1577:
X-Microsoft-Antispam-PRVS: <DM5PR15MB157794FC99C9C8AC56B7B722D3819@DM5PR15MB1577.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cewUD9GKFa73ZXQjdFTlS8mOUllCeagUllxYCzOgSE/l9DmBA5kyKLzz3SOslJtC03oKHkx1zsbKq5VKAyOrGFQnVoxOu8FBFxHw0YCy5Uh92OtY68VuwjkQn0pkdk601WHegoeMrrZ23GYdyqM81/hDvjpHX9gvE/FiLkcLJFXGfku/LtzxWk77Jrjrh+ZZXWggxRNApHXCdhIGDy4K0FZUNJaSeEgy3ze1WcHrK5H5qCy8xM7auohngFNtm9keAKvuP756LCF5tlTwEjmf3v8VYCTueOAYa7ChYuipXNM55eZGXzsbbtw0RlA7wdHx+waHAGLEQivy/FmiT9R1QjlzSdwLm9mn1ayYH32NRfMRwUH94BdbHuXY413F9SuT6AYwHGvlyVzqWJOtUC5Rs9Vd7I6oGyN3Wt+qPIe+Ii43kfv0d2PaPr04G6Kielvi4JOZaj0ZHKzg9q9xOMViFVTXYGFO3mb2UnL72h6sN5f8spMD/PUhZujWjdKem/ZpBZxcVuHV0dDwpagl+ozjYindDyl8x1w2EsUoBiSwxV+CFnp22doBERa5R7e4hG6s/RTC8+bscueAzIZlF7zV2uIM0VjX5sc6AsD63zFF0qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(316002)(36756003)(110136005)(558084003)(478600001)(5660300002)(66476007)(66556008)(66946007)(53546011)(6486002)(2616005)(31686004)(8676002)(8936002)(16526019)(52116002)(54906003)(6666004)(4326008)(186003)(2906002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnpqVlRxRnJBWmxTcHQ0NE5XVDA0ZEszZjRNYXo5ZHBqcnI4WGlPZXROUkM1?=
 =?utf-8?B?U0lHMUdWSHRUeTRxcnBUOVN6Y3N3dVlTaTZWT0xEVjVNSUROMlV6TlRaeTBT?=
 =?utf-8?B?NWNScjRmOS9XTmF6M0UzZkVacngydG9EejY5MVdDakhaUkhGMkk3dXRDOFFP?=
 =?utf-8?B?cnIvYXhrczBGZGthNi9LT0swUmsvZEZCcS9OTWF3aUVHaVFEeCtIb1Yyd0gw?=
 =?utf-8?B?SUZpSDgyZ1FHbTRQd0pQc09lSTZnRXVtc2tPTUhNUmxDYjhhdExPeFo3bnRv?=
 =?utf-8?B?dzlGT1o3aUdLVVJySENIVDZWUE5FWWhNajNtT2xYYkRnZ2QwQVlxelV0Umww?=
 =?utf-8?B?UExXQk1rNnFvTDBja2tMV3ZSaXc4dVZsaGlxM3FLZWFzeExCNHlkbmE4UjFp?=
 =?utf-8?B?K2pqVklvcnNCYmM3MG9QVys4Z1RkKzV3Y0pqSE96VVRWQWVOTzZpOURMc0Fr?=
 =?utf-8?B?dWRLa0J6cmliZDdPdHd1Z2wrTVNLNWlubHV4RUsraUMvbVpTcWtvYXY0Q21l?=
 =?utf-8?B?TkdQYzM2ZFZJK2tQRDg4NWZOeWsyOW0vWU9FMmoxWlo1TEt4MWZ5Sk5YajRV?=
 =?utf-8?B?cERjdXJjajNqcjFSbWdJUEVDTGVoMnp0SnAzeUVJL01zQ0R0aVFIQ2plOGNi?=
 =?utf-8?B?Tkg5OFBidUIwbUZpa2Njc3BTUnpvN0FyVmE2alFEN1NGQ0cvUFh3OEFjUUdF?=
 =?utf-8?B?dlZoRmI5WDVhNDh3bjAyRnNGZWsvcC9uVWZodGhBYzUwdXVKU0U4d3VSdjE4?=
 =?utf-8?B?QytyUGlMV2ZEdCs1N2lxYXM5RzZhTmNSUUljN0tVVm9GbEZ5eFh6TVRkWm8y?=
 =?utf-8?B?UTRnSWpTZUZFcW11MysrY2RIeEhldFFiK0dVa3dzUHZKalZQK3N2RiswSC9W?=
 =?utf-8?B?U0xxRTgwb3JkUWhRZkNMcVkybUduT0pRbmFpSSt1UFg2M29CQzFjcnQzZzdj?=
 =?utf-8?B?TnVkM2Y2TlJkU1JvcU1JUnVqUDlCVnNjN3pPT2Y0a1JJYkdKOVdhdnJtTzNw?=
 =?utf-8?B?aW9VQ1ZoOThxMWpjQ29SY3JXMkc2VjJub2hkMm5tWGhlbVNKQXA3K0czd3RX?=
 =?utf-8?B?UU03MXJqVDVUMDMxVkdFd0R6UDgxV1hrU1ZIcStnNTNsR0xma1ptd2gwZk1z?=
 =?utf-8?B?MVBMYU40VWlPdllkck16NkR0aThhQlBGcTNITG5MUkJEMjZQRG5rcE9UcWxl?=
 =?utf-8?B?SlIyeWg1cnF6aGpnTUh6UkZ5bDdPTmN1QjR6TkNHalM2M1pKRExlcGpKU0Vy?=
 =?utf-8?B?RWNRaUZsRmFOalU2YTJRSHg5NE1qblJtdWFFZTdUaEQ4bHVHdGxpUUcrYkFP?=
 =?utf-8?B?VWU3cXN6NFQ1VEVYOHBpaWhOUEZWZnV6RDdWN0ZTaUhkczZtN1lXTXVaUEwx?=
 =?utf-8?B?RXBrUHBFZXV6SUh0bTVsNy9KejUrRjdaZzZxZUJ1NXZPMUE5SlpNSXJpK0dq?=
 =?utf-8?B?TDUxelJTOEkzZTNTTk9RQit5WHVMamhPQVBZWlRNcU9yS1lUREJkUUlSbDc3?=
 =?utf-8?B?dnR4NnlRUGtrREVzQ2JxbS9lV2NibjNzODdqOTNFTEczd1RzOUVvSkRZNVMx?=
 =?utf-8?B?TW0rT0FvRWN0RnJxRTJGWXN3VEZBOW1rMkNUVFVXbXR4RHJMTVFzT2xFczV0?=
 =?utf-8?B?VUlZbU1VeUR0QjMydmgwZ1RmQk04cE44MVduaE8zaDlETUtRcnFhNzlvQXVB?=
 =?utf-8?B?aGRuSzdnVG1Ld0phcHo3RkpQK1E2ZkhMcytoeDYxMkZncEtVR21sN0ZpOHNO?=
 =?utf-8?B?dWJDUmhETnFaNERIWG9adVp0cDZQdnFIa0huUUd0QjdQRTJ2RW52dGV1VkY1?=
 =?utf-8?Q?803r3JUNJ82OnL6tfiYfLVSETpQvpEX7oUuKs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 343205d3-ae0b-4a4f-c97e-08d8d6e5ad63
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 03:55:21.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wjcq2R0Ibdos59IrV57XhgYWh4vo29wLLehQvscB+/EDx1PVzkr5Ja6MeglHK3/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1577
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_14:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=994 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/21 7:49 PM, Ilya Leoshkevich wrote:
> Also document the expansion of the kind bitfield.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
