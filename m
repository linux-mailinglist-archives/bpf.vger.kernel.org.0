Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EFB3276B1
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 05:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhCAEdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 23:33:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45186 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhCAEdK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Feb 2021 23:33:10 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1214UHP4026872;
        Sun, 28 Feb 2021 20:30:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Vzxxv84QHtdwgEnWpeKihm0w/4EhATVjx4CbTfy9INc=;
 b=al6ijzGlhIszdBAmqzY8CFBxpaAGKvsW3GBbTPnFQI0n6Va8/zGqdDc6wNuWdfni5j99
 Qxwid1yRqakpuKQ/DPA6840aeLFEdmC0RRmPRiv41PDStqJi2SjW0QG+/6Da+OGENGwb
 3WP6OEY19wbdJ3Uf5Nx77imV9a06DNbss/4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36ymfwwtg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 20:30:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 20:30:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elHOxucb6kOIINMJdp9pcyL5bbkUAqBR8/SZJ1QSnz3d9sADmJa+fP2B8MKBxLCktv+zLAAjRSAjVmZJTRmujejaNXAEHM9ESm5ngCgT3At6GL8LKwnS0to8ZlsBItgI/eL3n5MURIcPu9b3AQbu4D2KHj234aZpruNwlvNJbbwdvKsHzHZcu9Si3uanYkaOgxMUI7IozrBNSNzw/CeFvYFRkSBaEea4SWfm/1otuJHpTQKRvA96apH3fKHw2AiRS9IavWw/luLWjaIMJ479WbTOTl/GxWrCnK9KsQywLxe3xMbKOxSnAmAAvzSXB2ISEkVp4dEuAusgTka6KQRyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzxxv84QHtdwgEnWpeKihm0w/4EhATVjx4CbTfy9INc=;
 b=OfcJpQoqRKQSifgffcQhB/U1MoU/cZ3qItdwNPlSpvrTVORNWnjvljBCbbkvfKp0FLkTMAWwwdp+Fbbe9l03nRQfzJvRFZEwmHM34PJmxjWaku+VPFJF9lx6wBS33YY0ut690/TBJs+GkAIw7i0AfjcdO4PXEtFqpf10AnrW8zCAXqvTZeiDGlHPDz9cehYXPj/qbKJQGR2nOG1+LNqDKgt3klO99pEvZkexvdCZuabS1SV/00c6xLE8jwfiVmTEpgeLbpgSEljFZ9DsDQotrzrLr6hF4iM5jTnqfL9+IoOSSsFwcVS9K5A9ZUyCfaxdlLymjR58Y+kBH+RymJ7klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3933.namprd15.prod.outlook.com (2603:10b6:806:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 04:30:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 04:30:42 +0000
Subject: Re: [PATCH v4 bpf-next] selftests/bpf: Use the last page in
 test_snprintf_btf on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
CC:     <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>
References: <20210227051726.121256-1-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <405c1624-955c-ecee-7557-be7a0d2488fd@fb.com>
Date:   Sun, 28 Feb 2021 20:30:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210227051726.121256-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:34a0]
X-ClientProxiedBy: MWHPR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:300:95::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1008] (2620:10d:c090:400::5:34a0) by MWHPR13CA0036.namprd13.prod.outlook.com (2603:10b6:300:95::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 04:30:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5f2124-56ce-4137-6ba5-08d8dc6ac62a
X-MS-TrafficTypeDiagnostic: SA0PR15MB3933:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3933687716543BC96517608DD39A9@SA0PR15MB3933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrCAzy0jTQgUt0g/sE8hEQLLZFu2lsjjp4kPXqsHj86vvew8WdHo6sHLhhl1Zi3XLYKax4hfLOhFFn50uu+fTCdaYyCzQgQKdU4xuaZW9FzvSmNch9WZNLgbSXtF/kuXQxSEh1ARDaC8UisIAIGfBr+L59firlOUhqgaJTUltsOBgRDJgzmktEOF9MrrX94L0uSB3I+XBnKetySfsBtoVWWqteHBAJt24AzNum/DB3791JU7VcmXBMbP8sK2mfk1sMIPiEgyJ9T44DYYVBv7WPTSp1m9eEx+9lHY/MF8YUXV11lQeW+ZB19yGjSBNJQEJDjBuUhDf4xeJNRLThi0Taux7mJwIepReOlrn20Sfz8ODYXT67HmBBb2hmxhk7MJZ03Zq0bvEgSEP3i50fqY9+lngjEgt60X+ZWq21QZRwtCCkdV2uZ6QpcJ6OPXXgVruOsRYJoXFLXSOJrBX88hiw1kkaXGxR3Hqb4m65AulbYiX2ZSfJxzJbmgmJkOKLnAvN929GCKkZ/F/p4j0/EyNN/tuhVjCSvUWZHkY54rejk4omutDaBXLff1XHRS2sob8o+QPO5yKqvEcvnwJcbgAbhAL8o/woLq2YIWwIqCzQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39860400002)(16526019)(2616005)(86362001)(53546011)(186003)(478600001)(4744005)(6486002)(31696002)(31686004)(36756003)(83380400001)(5660300002)(4326008)(8936002)(2906002)(8676002)(316002)(66476007)(66556008)(110136005)(52116002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ek5PY1hvMzdubXBkVmtOc3laaEZoSFhkbjBXa2JYQ1VybHNtS1k3WXpjMjN6?=
 =?utf-8?B?Ynl2eWdwbFR0V3gzQTJJTm80NmVSYlpKZ2pTR0VZWUE5UUFMVEhBeUJQOHBq?=
 =?utf-8?B?aVIyL0RVUkgxZnpZdTVzNnhmSXJYV2hFalR0RWZjRHBWNExzcWdrVEo5NVJE?=
 =?utf-8?B?dTBGMTlmSmQ5MDlHTmtwUUF0VjhkNlVBM04vS0VJMWcrRzdyY3NpREtKSnp2?=
 =?utf-8?B?UzVGSUk3NkRyOXc5UE10OHVhR3lrT3JCditRTXVQdU0wWHRGRGk5dkxuQW5q?=
 =?utf-8?B?NzJ2SnVDanRzUkVoYURPWUVscWhrN2FxUXl1US9UZVZpMEVONEtnTGpac29E?=
 =?utf-8?B?REFrU25ROG5BQjZBWDZBOHY1amNicStoZUpQQS84WnZmK2JaU3pBS2plT2FQ?=
 =?utf-8?B?ZnFobkRDZFRFWnZSS1pRandxeWJyZy90Q1hKSmVyek5LTDhwZENmakU2NjYy?=
 =?utf-8?B?OGRhVkFuSU9BWHVyN0FOUGhZcFU5ME1JS010Ulc4ZkM4K1R0ek5ISi8xbjR6?=
 =?utf-8?B?NzA1MjY2UXVPekluclpxaXpFRDVaQnROKy9ya01ybjdNSkpUYklJdjh6alJn?=
 =?utf-8?B?a2RNRE8wUjErTXJxY1RXcDA5cjZPQUY5VmxxKzUzcEU1WFdka2Z0VW8relY5?=
 =?utf-8?B?SldIRjdXbDBUVm9pcG9XckRlMXRUWnZRdkxNYTRzSzlWeHpkVThNclJ6eWE0?=
 =?utf-8?B?alYvQkllMGdoaExjeXZ0Tjg4aFEyYlFZVDdUNUtObUtVVG5mblpyWEQzTGl2?=
 =?utf-8?B?TTdGeENFaEtpV25CalA4VEl6enoxelNrcnYxNVVzK2M3c2lBU0NveWh4dEdi?=
 =?utf-8?B?cno3Tzd2aFlzNjB1Z05tem9STzFBTzAzL0MxSDBneDVVaE1IUHZ6NktGTFNS?=
 =?utf-8?B?TnJGbzI3U3hVbTZtbC9uTXJ1d1MyallvVjZjU2xDbTlTbGNtQXg5eUlNM0ps?=
 =?utf-8?B?dGRpalRUNmF3SEd3c2dNaFNjNVBFYTk0NU8wZ3NIcHExWU8xWUpZOUNFMkJl?=
 =?utf-8?B?RFRwQWFqTmgyL1hrVzBIaDdnV21LK1RidHlCMDdFMzIxS3JGMDNwdG1aZ3FY?=
 =?utf-8?B?TlJyTHNseWhUWFJUSHJ0cXBoSElCc3c2SmpvSlc5M0pIanljRHJ0b0ZHQUlG?=
 =?utf-8?B?OERoVHhPZVdyQVYyOG9haHovaklMaXlWcE5Ocm5YbHRXbWFBeXJzekVveGR3?=
 =?utf-8?B?RUdSRzBRcUZRUGhUd3ZqVmxueXVZWm5UdE9hWjB3SjlSNkVTd3U1U0YxdFRQ?=
 =?utf-8?B?blBaY3JWSHlWaVAvdkhKZ0NsNWFnMU1RcXA3Yi9QTkpmVnk1WXZTSm9pSVJC?=
 =?utf-8?B?c3ZZcDZsaHFqOXNNbUdPSXBmc2FWQjY0aWJUdVBlQjl4TlpUMytjRkNjYjB0?=
 =?utf-8?B?UFhNYVdpTHE3YXpFQ3RiTE9qMUtpSDArK0N2anVsaU5ocnZGT09uY0lleU54?=
 =?utf-8?B?dXBYTFlScElwNDZqL2FiUVdzSlNqOExvbkpUelZMUXdVQTIvRDlwWEpYSFBp?=
 =?utf-8?B?NnArQVh6M2NJMElLdDNJakR2elU4b05GaW92LzNCbklUWEZha1RMS2Y5a295?=
 =?utf-8?B?dDdoajNwbW1ZVkRWVjVpeWw1anV4c0xzRFY5U3hLU2xRRTdWcEc4Y1BaLyty?=
 =?utf-8?B?ell6VEJTZVFRN0lHLzV6c05Fd0YyZXlGczR4OXNTb21pRnBxVEZPSVpGM2pk?=
 =?utf-8?B?WHJ2eEw4Rzloa2pwczluKy9ocHpvS1VxNi8rZmlGTFk0bi9mWEpzZXZKeGx4?=
 =?utf-8?B?WWxmT2thQzYyZDRoa00waVpFYThaY3lURmJqdlpRR0lvaDZTTTdmUjl1aElF?=
 =?utf-8?Q?wugnGz6cMeQzieFRMFArAUtRSQJkNTGtkAFxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5f2124-56ce-4137-6ba5-08d8dc6ac62a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 04:30:42.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ohX0l4JCxNHMlQ31SKO/4ofs8su9EmHrTGBgbkDwx9NvmIKv836pdCCdK5ZAANk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3933
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_01:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 9:17 PM, Ilya Leoshkevich wrote:
> test_snprintf_btf fails on s390, because NULL points to a readable
> struct lowcore there. Fix by using the last page instead.
> 
> Error message example:
> 
>      printing fffffffffffff000 should generate error, got (361)
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
