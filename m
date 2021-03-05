Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4632F54E
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 22:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCEVbX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 16:31:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46536 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhCEVbM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 16:31:12 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125LPZdD021671;
        Fri, 5 Mar 2021 13:30:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9qITOsGv3PwWkM336HvxPqL4SHDc4CYeMqLPhDh97Do=;
 b=f413u2XfrNlX59WFNaK10E6FbvhL4vLDk8AoOOGfgfoJ5Jjo0t74RhH+HnxYAtx4TYd1
 XOu4GK9qlIZlhE9X1jqWFDbOITdVv12tCLYlrONcxtjhfWNs5tG+yCU+zd52eyASOf22
 fgnt8XqsM5LNO5hNZazMwexLn2imlrYkizc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 373ha4utv3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 13:30:54 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 13:30:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVANdV3CXIo9QVRxvBu+LuqRjwh1moAI7SF45S7+lN1OjcZnZImQS7+ho15sk8bP7rKD+LoD7xgCa2Uq4i8DMUHLYuz9oiV/z9o4HFcga9vlleHIj7cBkIDaIFViT5J2WZbR3DdsRw3Zzf4rcnNM1DYP4H2eB+tGUWtzN77S8VTveYYU+W1Znwg0I1ApjL9LKIiqxDP7bPDcabGnvO0q22yPCYfyGlE4K7WARne3hxfwafkEpB4QyBfNTvmJhokPR5g1WCiO59ZXUUT5Ho3x6KT+dGJn//T1ghigs/7ldVPLapukB+KiTmnKE7hEfiP4A2/n51RBSS/Ihy+ExbZxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qITOsGv3PwWkM336HvxPqL4SHDc4CYeMqLPhDh97Do=;
 b=Q0Tt2pNlldZwOM/2ZLg8XgVlyA1eCAlYv/H6QyMgPg/VEZV3pB5wyGDY8KxZE59pxjidaVdTVroLZ1GNroeZ7WSSm0CfRsi/0g6kCmxlu3v1Ov3HQSZksxT3ayXXfP7QQ1a7FrkFazIXxAnQULl7CgLcSgRiQv4CN+rvm2ZMXMpm9QxYjUrBlEX9vAxrX9ts5ynqVRW4BterhvofBWN5F49LAvK4BF7RXl6uN476CPhYEIG4IQSlesbq0uGv1NVtgTSx5DI89f7KMmPce0+rB5alrs4RPPWOXBRJ80xUEWNcTiBqXD9mACYBQXvfn80/VEUDmfeUCG59wPqrLndGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2477.namprd15.prod.outlook.com (2603:10b6:805:28::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 5 Mar
 2021 21:30:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.034; Fri, 5 Mar 2021
 21:30:51 +0000
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add BTF_KIND_FLOAT to
 test_core_reloc_size
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20210305170844.151594-1-iii@linux.ibm.com>
 <20210305170844.151594-2-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f21cb62e-ca1d-223f-00b4-b13a165b943e@fb.com>
Date:   Fri, 5 Mar 2021 13:30:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210305170844.151594-2-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:81bc]
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1105] (2620:10d:c090:400::5:81bc) by MW4PR04CA0073.namprd04.prod.outlook.com (2603:10b6:303:6b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 21:30:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d9e1f4-1240-453f-50b9-08d8e01df310
X-MS-TrafficTypeDiagnostic: SN6PR15MB2477:
X-Microsoft-Antispam-PRVS: <SN6PR15MB247764664DE06D819A3BDD62D3969@SN6PR15MB2477.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Rsquutd8sRIHtmnR1CKmj3mURW3KliTKs0h/trbmzKVBi/gxp1voeIsWQdyjISedN2f+U/B6+NvupmgLxvQY9o03+Gr4qU4fEjCp5rkxBJOYR2NbA9oRnvP++PtulRlkk7Q3SF7zRm7Wh7TP3FpSU16RXt5w8Z4OeQXuEpOepDlr8f/D5dw9XWhtHpySmnEteOJiRF+7KUiNc8XGqOTE6JYZshLgOZDgBNdb+C9FwAVxRd+YdYJDzTZOpf0Biye9KRXFNQHr3nai2M32uOu+6xabwUudcTy/jSnVqt5/lgUrg8y2yk/9VCTJf0NCEIX4ApL0AcAJYCnEL8RsMUf/vHyvJ89shnbeH9jUBONq8kntj3X8QaExwl/o2Uyue61O8w1dfDkJJ457Ts7x1e2eP9t3j8dbtPiy2UEiFIdrwkvdTjfBQyM+wi6N0xKPbshMO+34phu/u5G3r2nNXIr8PRJbWAu/ylXDX4YieDmrJr8hdTkSx4EkLmdx6A08fEF8S0Rsb5M66yqG9E+/XdjY/zzDEgYntqGRJIjw/rQDwedipdc1wU/jR8Not1UOZ0ew5uvJM8XeV3p/x5CHS1WOtepdAnpZub8Q4KdLmwOBHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(376002)(346002)(36756003)(31696002)(52116002)(478600001)(6666004)(6486002)(83380400001)(86362001)(66476007)(66946007)(66556008)(54906003)(5660300002)(8676002)(316002)(186003)(8936002)(4744005)(2616005)(31686004)(110136005)(53546011)(2906002)(4326008)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QU92M2hOOW12Mkw4QklSSVRVUHhtajlWd3M1ODhPSGlKa09BOWFDVmNKalhp?=
 =?utf-8?B?aTUvZEVHRlRsRDR2cmdWa3gxUjEzeURGMGNHcGlEM1grSjJxallXOTZ5T0hj?=
 =?utf-8?B?TktqTkl2aE1KdWR4aXpXakF6Q3hMM0R3bTVURWc4aUxyaUpJSktFK0Y1Rk1E?=
 =?utf-8?B?cU9EMnVMYWV1U25BQzVmaHZHS0I2dmdYNlpDandSN3pCN3huMDVkajZURFBK?=
 =?utf-8?B?S2JiOXdRd1pubkVGU09ZYUc1eFpCTnhTbnY3MDVxQ1pQQ3k5VUNRSEtzSzkx?=
 =?utf-8?B?VVNYdUtuRlJPWmMyTDJOZTY2ZElUY2VzRyt1cFhKNHo3VFlsaGJHNzQxd2pK?=
 =?utf-8?B?R1crV2lKNVJQRE1iQUl6NHVydDlqM1RkdEFWcDJLUGFsOGJrTDgxbEFWVVI5?=
 =?utf-8?B?NHpkSHVKRUJ1WlJzUGh5WmROZXNGOU9VeEt0ZDFvVVRhUUF2YkdJVldrcTRu?=
 =?utf-8?B?ZWRIaEVycUNpQzZlMUVaSlczTlRnM1JrQkYyaHdIdnV6TThQM2RibEpqWjJk?=
 =?utf-8?B?VnBWa3lVQW1Zb0xVNEhFQk1maU9RT1pqaVV5RmNFZmo5a1BvanJ3MHVrcWJr?=
 =?utf-8?B?c0lTcUl6OFJzR2cvM2xZcDBPcmlkei9xcU42VnBvaXJGZHQ4NE1KOUtBd0xF?=
 =?utf-8?B?NjQvU2pqd3doVTFndkZ4U2ZiRzNHR2Z0LzJ3MDVMandTcW9aVzBtQmxmTjAr?=
 =?utf-8?B?TUhDQkJCTDZiaHFhRHBIeGNhY0Q2anZtdWY4M1JoTTlKMEUzRUV1V0k2K0JS?=
 =?utf-8?B?V3c2Q2dSZW0zR2NrSlExRDY4OFBxUlpMUlVyQUhMTHRzaGdCUndXYTFVTXda?=
 =?utf-8?B?QkpKYXN0ckZjNW9CNGg0QmRUSWlpU2U1Z29hWHBQWWlycXVHL0poTkQvOHl0?=
 =?utf-8?B?MzJ4anREYi9HTXpPRUw1Q3E5NThKTncxUTRyZVRybnJVbEZ4amp1NFBHWG1k?=
 =?utf-8?B?enZ3U3ZrSkMzRFhuOWJJbzZ4OHdnN1RUeWh3L1pSaWlkSzhxZVlreDhpZ3py?=
 =?utf-8?B?MnFSbWR0SUlYZ1V2TmdVeEc0alVXNzdnZ2hKTno5OEVVY0x2bExRMGJsRmx5?=
 =?utf-8?B?UHNQcm1LaWkxQlZROGU4b0JqYVFVK050UUZLazV1b0NXZHg0eU12RFY0Z2RH?=
 =?utf-8?B?Vm41a1IxNExtTzFmdE5EM1lHbHVpVGJBc3JxOEJrdmFMNGZwUUNIUDA3MVdU?=
 =?utf-8?B?WHdkTCs4ckwxMHg0ZXBBVEh2aURyeGI0WDMvR3gwSnUyZjJEOHdrOXQ2clNY?=
 =?utf-8?B?bHpOdXpvRW5ubDRYR1FXb3pWRUFkNExrWDFwSzhvVTRhY09RZ3JGam5ZMjEr?=
 =?utf-8?B?Y1VSeFhjRER6Yk84WmIydEJsbThyNE9SMnJ2cFlDYVA0MmNlZlVkT1MwVnZl?=
 =?utf-8?B?Qy8xODZIUDJObUpROUM3eXlSa040YkphOEY3Rm9Ga2JRVVRzLzVzbDRmcUlC?=
 =?utf-8?B?S3VqYStWbVNLQXNsRko3WEl0dmxNZjhJQW1XamszRzZSM0FnSWh1Qkx5MFlW?=
 =?utf-8?B?L3VhcExlaDllVlFXaGU2Sk5jZkpYWlQzYy9CbU1iQ2JzVWFDcnpraG9WZENr?=
 =?utf-8?B?aE15bnhxVllaN2wreFNJVndXaDgyWXh2Q09mNUl2Qjg3cU5NczIzbjZUdzRm?=
 =?utf-8?B?aDNhYk9VN3p3cWwvQVltaDFqNk0vbEhoVXZLUkU5MUNlRllyRTFaQkNLenBa?=
 =?utf-8?B?RkxvSVo4RTVpZmJRUzMvQjBDV2hQWVZnMWNjVWFqK1JrKytJcE9IVjd6TGg5?=
 =?utf-8?B?Ull6NlZrUm5WUzdubmFSQU4rWkNHNmJuQ1VMSFdnZmwxY0FwdVhVQWlQWTRR?=
 =?utf-8?B?MEQxMDFiRmhRM0svRDFBQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d9e1f4-1240-453f-50b9-08d8e01df310
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 21:30:51.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zq189oD8WO7w6KyIXXQyZQysXQoCp2EI3bi99jmPCaJl5O8+3Y7toP3oTr2V33D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2477
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_14:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/5/21 9:08 AM, Ilya Leoshkevich wrote:
> Verify that bpf_core_field_size() is working correctly with floats.
> Also document the required clang version.
> 
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
