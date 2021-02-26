Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D995E326A68
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 00:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZXdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 18:33:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhBZXdX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 18:33:23 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QNUChR016134;
        Fri, 26 Feb 2021 15:32:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uhqG9fagoIGiID4rnNVNa3uOK1aTb376UQs6YEZzao8=;
 b=VWLVBJPerxTooxo4DfATtN5l5aq0cLPaiwW3RWX6A41oiPs9AtI8ST2VNutwkN60FNoQ
 o/g2UJbBxRxvlRsg/D2rXMB6kZ1PtgTM8lwEWUPMScDPzz9XwcEHuUGigt7CWZhHha0I
 4ZMQ6Lb2+LgyUaoT/LdDg18XYC4nnFjlnnw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36xd17ssgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 15:32:23 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 15:32:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+o9tiuz3AgKbWf8Jtiyre+ejN/J/gKKAd5AWkBZZ0aWiFoyMMLFff4x0plbaekZwNJIXio9rVdmBXvFnuJSPcUlScFJQTJg0UbamFU17RjAJrM4po82CrTlqzSu8FkUFMu7Zrvg9cnvWqsSIn7jmpERseOWYiOrvIt/75bP/tRHn/m4X74AAwPaxUz0Uq94K7rErXMJ2ro0biuboQQsudJV6fa5EDQhf6qLDlOOtJdTWjyn85yYvi7uxNO0gROvNLnrhR+cfggRd0tUrgc4SdcOi/3k1x9YbX7nYfM5Ndur1BM/N0bytPeK2lttyVmOpnYm81KPepJUlp/Q4IVlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhqG9fagoIGiID4rnNVNa3uOK1aTb376UQs6YEZzao8=;
 b=h4WxyyiIfVy3uqL4dX0tcqv4YqxVxg76WlhQuZc8NDYmrbeJn17+GbnQx5xYSANI+7+OUJ2bJe2JwqI8rg9CxYGPLsiP0QrYnvjMDR+SsNj2SeSbASB6MlO6YdcoRITnluXiPJn4b/DhOrOHplc1iWP7r3olt4px3KCY9dNk5RJ5dxWUw/O2sxHHPhdYHz7/JMXMMcmQTJkPWb28R0AkOA3V8S5wo8LbkXEoA5oWlYv2nknCahliC/foW5SJ3q86M8aqSBwM9EIfpR8jFQJOoCE9pgYh+AwwuE4WG3s2d0TB/T0l/nXm+YoNtJ5ZyO2FK14np8gKDMcuh4YOdBk7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4706.namprd15.prod.outlook.com (2603:10b6:806:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 23:32:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 23:32:21 +0000
Subject: Re: [PATCH v7 bpf-next 02/10] libbpf: Fix whitespace in
 btf_add_composite() comment
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210226202256.116518-1-iii@linux.ibm.com>
 <20210226202256.116518-3-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <71aa5b4b-e77a-39cf-f785-5eab99b85d71@fb.com>
Date:   Fri, 26 Feb 2021 15:32:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210226202256.116518-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e536]
X-ClientProxiedBy: MW4PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:303:8e::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::193f] (2620:10d:c090:400::5:e536) by MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23 via Frontend Transport; Fri, 26 Feb 2021 23:32:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 626136a4-1a6f-41ca-67c7-08d8daaec354
X-MS-TrafficTypeDiagnostic: SA1PR15MB4706:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4706A134A863CE3963E0FCE5D39D9@SA1PR15MB4706.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opYgb8LsLQ6LuyyVltDTHHeAc+wCBGfaEn5itF9WfJMEsPP0+NletvC0Bb/zyv32vmmjZnrLbd32MQdAie/VdfEnku8QKYOBnQC3+RC0CGdliPlH03OTAf4uDrufUW0kxFa+9LIPNc6M0uH+mI6O1hFxRIeRKvMl7Yuv5BKbMxt8bK6zsuAMNm+cDzYUHlUwEDdl+t5wj4VGI9eOwXknk5y1RAN+5+KV7c3TNSOfE3Yx7TZ/oqYyWIw0+pXveua4tpO2jW5xztjNTK4jVoNLocy0D4Cblwe12TB6rRmFRFKJ3c6q8B1tIZtxovNMypnq5MkWGcAUCEwr21/poBUMwfI2wq5myhxplc90zi79zpIakHUFmKly1q61xZ52Qw3K5QPx6p4E9VXvSnmjTG3hFlh9vuP2eAIextUWsDbpz0WaUqKF/DJlNOamUcVx4KOjUK0okb2luZbCaOHp33QW+OKvopyR1p1miMtJ/9Qi72mPCY/kB55caxewgZK0TnvSI5E+X3sJmE2Hc+GrhcbF33tMm3cLy/MEfXdu70+tmy01lf+sXCix3p1m2AstrnyxtzouWPPvp8bW3aqI5z3ovamJ+2QYSmU0pEIKsFSWgGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39860400002)(376002)(54906003)(558084003)(8936002)(8676002)(4326008)(478600001)(52116002)(110136005)(31686004)(66476007)(2616005)(53546011)(186003)(316002)(31696002)(86362001)(66556008)(2906002)(36756003)(6486002)(66946007)(5660300002)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VEtCaFluZThQaisvU09wbnlLUmhYK3Jkbm5kYUQwTTlxRFE2M3lCajNoMWhN?=
 =?utf-8?B?V2IrMlVuNzlSMWIwUDFaL2s3NWl3c3dId2RHTzFyWVpUTmVDNjNoY2I2M1ls?=
 =?utf-8?B?OEoycGRSUEVXZ0RGNjJvOFpWNHRmekQ0Zm9jN0hsWE8wRXNzSzJ2SnJHTDA4?=
 =?utf-8?B?YUJkNDZ5RFJTV2VKUmc4ZHE3TjVXb3gwQXZRWXNzRVBXL2cwTWl6MllFaTRl?=
 =?utf-8?B?Qm5FdE95aE52QXJrc1lhYnJ3RWJSQzRKMGc5TTVndndwREJNMkJQTGJESXo1?=
 =?utf-8?B?dkhxOU5IY2FZUmRkU3pZbWZsdjFXaHdhL1J0UVN0Tm92Q3JpRXN3WjBOMWdw?=
 =?utf-8?B?MC94aDBXNFZzbmIxY09oN2U5aWRZZkZ0TEZ3My9LRVlUdE9TK08zeUF4S25E?=
 =?utf-8?B?MGlTREtNa054bHYwallvTGZ1S1E5TnpUK1JGRHdWajk2bXVpVFpuR1Q0OE56?=
 =?utf-8?B?a2FuUG1pMGRidWsvN0habEl4ZG1Bc21JeDkvaHRLSXFDVWQvSWs4czZwSEJO?=
 =?utf-8?B?cno5NXFGaEVlQ2pjdDMxN21oZzc1eWZCMmNmM3VqajNtNmlLV2FlMWFWQzlM?=
 =?utf-8?B?dXVkT2dtVTExUjM4YnVhV25pdEZUR2UyNVFteEdzSVJhRWwyM0JIelYxQlQ5?=
 =?utf-8?B?Y1RLY1lXdWtHQ1piK2puLzlPQ1IyQUkrYWxodnBXM1J2U1R6aVFXSUZqeXV5?=
 =?utf-8?B?Ly9EYWI3UGdNdXB0ODRpZUNZQmRkTDQxTDdWZ1p4OWI5Y2FOSzJGVVNhcUU4?=
 =?utf-8?B?TEZYRkRoR3lDcnJTa3VqbGZXbXpmT204UWNDOHk5ZlRCd0p3aXp3S2htL2Q3?=
 =?utf-8?B?UlVCRVlYRzdvMlUzQVIyMWoyRWtsRjJGZkozekZZdzh2T1grY0JEbTZvL1N3?=
 =?utf-8?B?NjF0SnlONWFtZ1p2ZVFLei9TbEFvaDNlUUYzUmZvdEJJQkVZN1pZVStRTWI4?=
 =?utf-8?B?MVIyUytyMTFLdjRDeDRWaTJhMEUwN0xsSC8za3JPWFYrem5lS3B5c0MremVF?=
 =?utf-8?B?S05uUEM2ZnQzaHdhVDlsOWh1RDdyYkNrVExTZDFqUmkwaG1RS2l4SmxVQ0k4?=
 =?utf-8?B?WGgwTDJpSlQ0Z0VQT2tCc05zdHc4alBTOC9wOFl6SldqZ1hIL1JPQlNsUTNU?=
 =?utf-8?B?N0g2Z2RUM2hPTS9iNGdYZFdoQlJQWVFJcU1obk9YVm1xVnBZVTdRMkQrenVN?=
 =?utf-8?B?Q2p3U3Y2empuQ1ZBbjlaek5xaEJTSGVnUi9rQ0hzTVpGaFFOSDJHWmRKTkVa?=
 =?utf-8?B?Ty9VandBRXFLMFNDQU8xazRyYy9BakFFNnlNSE1uRnFacHRQOFF4Q1U2VjF6?=
 =?utf-8?B?bWx4UEdoQzVzdU4vYUZpUjBoaEZzVldSNkFERVJncmJmNUVGWmEwVHhnTm12?=
 =?utf-8?B?MC9yTlRsQVNaKzlBRFRiZ1RaU2RnU1ZCdU5KNWx3ZVNCSVc2ZXFBM1JiYWJk?=
 =?utf-8?B?SjhGUHNVN1BJZHBJbFR0VVVEUDVzQjYxUXhJZE1QT2NwMzRTSzJKOTNCblRI?=
 =?utf-8?B?Y0wzWkdjclk5c3NuL2FnRGVvb1FrUjEvN1pKR2J5MHNoOTZhVXE0dzZYNHh3?=
 =?utf-8?B?Qmc1MC9yWDF4YTZyZ0JIUWYxc2ZBYkFyTEJydEo1dEJBWHM1Y3BYd0hKZnp6?=
 =?utf-8?B?eDd4N2VkK0l2Mmw2QjZEamVRSnhtb0JldTJZTGJ6SmROZFdjNEg1RGxqZ00r?=
 =?utf-8?B?dGEyeHJEQjZvUHdIMmYwU3RmTVpUNkROWTVWODN3VEZBcmdDOGhxMThuclcw?=
 =?utf-8?B?VmNsV1pjbGxKd2x1VVh6MGY2akJYOEhWRXRiNW9VV0lOcjc4S1FwaHFhRFNN?=
 =?utf-8?Q?cKNTwOj+84YClRmR7CMsnhzRFrFK/OXVs+ods=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 626136a4-1a6f-41ca-67c7-08d8daaec354
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 23:32:21.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tIy36SlZH63te7rOmEoSKs/e8kp8/gADpg6h+uNpvj8HK6UANqmdowbXFs6RQeZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4706
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_12:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=944 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260176
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 12:22 PM, Ilya Leoshkevich wrote:
> Remove trailing space.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
