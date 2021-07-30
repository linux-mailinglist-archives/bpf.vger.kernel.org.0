Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC23DC117
	for <lists+bpf@lfdr.de>; Sat, 31 Jul 2021 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhG3Wb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 18:31:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229604AbhG3Wb2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 18:31:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16UMSVmT023669;
        Fri, 30 Jul 2021 15:31:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L5wGd3SDDUTYkPgMeo3jlWE941VmcdZbExXcMsLhWus=;
 b=DMV6qfmF+/g3U7Z7tH+T9MyYfaCIMIPmosd87Nu/7P/rqgepTghvX7QOipxWYKj4y7Tw
 IeU080LVbcUs6J8LeGqsY2Ctw9/UMqznew22Mi5pYuKjQuIKG+ZibzzdPEa/I9mLAG7L
 GpWhmD/mDfHlsFYUzhpGJmODwm2Uvjt4jfI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3a4fprbu13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 15:31:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 15:31:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do0Dd8DYUs80wnWS95klJNJ4p3VbaJoQBHHt6DTSR6J7XeGvRTEMCAsJlwnD7BKZ6xhiKAVtgYgrm8BNy7MIKlUsWdiYIKYUvwmJtpvqrHpsQij7Wifsp0sIH4WxBNsCWsGTZejvx+gGFtQm8ZuEh41ljHD2ivmArLthyna5cDMUMvocZ6R6MiZPWUnubvk1Yo13jAiVIupUxY4lds00zsrOlxLbHxCwOQPNldLRX2o+7jsdlaxcdvA3uzh1WFusw5u3zog6rxafT7aGJBXP9OqqiXE+ljGsotpEHqXmWYUX4LHcZx7KDH/A04ZxvmTotIBXaJg8XttU7stqJZU/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5wGd3SDDUTYkPgMeo3jlWE941VmcdZbExXcMsLhWus=;
 b=FOTvwccBqGhQDjCjhpvHWp1bK/EoKRSQk516JEkndMNpXKzgie8K64fjlYwEuJOXz8SRkE7YWJ+pWqGx0bsNdIVaLmZmLeYcjHgfqrTqtTggGa7XalAX3jaFX+mAi2lS9EgerJEF84OPtbc/2zOka6wz1rtq3n3kD22oIBhEpJSbaa3cQNAkY7joLv/QCFx5lwsIucK+W2rEeUWcPa02GYz3km0fJKYew/C6IvWDb+Wgs8ZAqUiDk2HA8FYgeWo1GTxm/nFSyU3WQc7NhgLAAzs90gVk82M2OIis0xdL8grRpKJ02/jCM2s3aOx4izwli8m/HBoLMlPcPeN5BCqEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4917.namprd15.prod.outlook.com (2603:10b6:806:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Fri, 30 Jul
 2021 22:31:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 22:31:06 +0000
Subject: Re: [PATCH v3 bpf-next 07/14] libbpf: re-build libbpf.so when
 libbpf.map changes
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-8-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <72297cbf-14f1-7555-5f24-9d2adf1f4083@fb.com>
Date:   Fri, 30 Jul 2021 15:31:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210730053413.1090371-8-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:890f) by SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 22:31:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4632616c-76c4-42db-b863-08d953a9b88f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4917B352A882E0DB9677717CD3EC9@SA1PR15MB4917.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slIjJJSyfcaH1v+ykCL8E3wzQNew0ErhkaSKVeLEvPwoDDJUUrOLs8Bi/O5+r3cQVrLbydh1cm5Fwt2WBzj8/Lc5KyQLl8OMChrV+nezNl/g9xvzfIV6dF2QQ7cgNCEu4l22pUYMKW0q92b3hbUsFF60GQU9ZMbpmgr2Aur5TjmuXmc4RKxp/V68n0SIG/++JTTbkfBArwYaTLK5WGK6kEL3WfauEOuGGrpLmDH6+YcjKxxjo+8wG41r8i9x0ENmyjOIc7TtW0rEoC33GFHP6/5aUQ6SBbfVaZU3yqTSeO4dbskAQdIAt8UFQ+s+FwXRw8OrFvPtbl+G0t1Z5V8Yoy8jaTb7o058J3oARH3DGDAybrNZV9w2JZX11WkbVNAfJD7rjvLlHjRZp5TPtgA+h9TEuR31FIPsNdBxXwT8/Ab2iIg5tXseX7cffT4TPuXX2HbAOF+7+GrSxf/J4+9F3UfYjMTwApC6knrUER5S00DJuVpoMiyyezP8l0a2IQJLzAqlUFk9+G0XZYuBOSIjS3jI2KaLBq0dt83Ib3k4vlYAdCvWh03JynG1SFEKjYMaPTxOqxZbiwe41rp9kM0v80RlTkBBddxSav5JYQJM7KPg+FAiT/bB9W44vBy4iH8GnLVB2lDHxq9T+o9XpEnr2sU7RgtAnE1Am+Vfsh71jwBOTDSQK4AVvmAWF77j8nQWpOLjaOOjiBr9b/M7I7cg+Cpb8w4XEVb0G+d5g7Qnfak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(31696002)(4744005)(4326008)(86362001)(2616005)(186003)(6486002)(5660300002)(2906002)(31686004)(478600001)(83380400001)(8676002)(53546011)(36756003)(52116002)(66556008)(316002)(38100700002)(8936002)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFVdEhBRENrbkFtc2E0aENhT0RQTjZpQmpoWkFVRW5pOFBLQ1NBYzRQN3Zu?=
 =?utf-8?B?d1pPWE9LWHp3ck04M1k0aXZOUWV2OHQ1d1YrRjJIc29uZkdtcHNDekp5WUJl?=
 =?utf-8?B?UUZ1VFVLMWd1WGxNbTlNVUlpQmlkbkJXU1VyYWFOY1FBYmZINVFvbEFSVDd3?=
 =?utf-8?B?V3ZGN0phTm9SQWJ3c0IxWGx5ZmsvelF0T0lxOS9Vd2ErcDQ4VjZubEZFTzA5?=
 =?utf-8?B?bXQyVXloZ21UdE12ZTJObHc0empBMTdzU0xnUTFKelRCckZlUkpGNFA1OGxN?=
 =?utf-8?B?dko4dGJhemJ4enRZVEQrNjhjcVh1UmRiMUhlKzZYWEpveDJQTHBGYUtrbHBP?=
 =?utf-8?B?OEppbmlCRVZ0eGlQQWlVUitJbUJEUFhBVkhBKy9hTEdkOU53Y25Ha0VPMndz?=
 =?utf-8?B?SlJmRGI2QWJzUmFHWHYvSnBVakZsMG8wYW5acnhGdkJIeGNVQnIvZmI4ajgx?=
 =?utf-8?B?SHh4TkkyUUJSQmJEVE9JSGlicklJT3FQZlhiK1R1bnh0SlJxKzhNUmR3Wk5h?=
 =?utf-8?B?WFlQTk9iaXRia2s3M2xJZkFWVGNpQ1VSaWg4WXN2eFVSSkY0cmZiOFJ1TXFO?=
 =?utf-8?B?Y3lYSjdkVy9YODdUSWFjNWNmNkFUbForZHdDRkliZUdzNHZBMlhMVUs2dG1F?=
 =?utf-8?B?Zi9iQ2VjYlZWZFlIQUVuQmJVRVVuYXhCajRsZE85ZXZwbmN2MW9NTGU2Sjdk?=
 =?utf-8?B?aW1oMElsZmJTbElZN2w1a3NvZEp1ZXcvNnk5aXdTdWIxVFQ1L0hxWUtPL0RB?=
 =?utf-8?B?dTQ4Y1hYMEFNT0JReG0vejkweGtxUVpKeElzSTZQdmZsZVl3MkZaY0g1OXl6?=
 =?utf-8?B?QURmYWRPNHJ0b0NqMDN5Q3k0MEhoL3hFMTdFL0lGVTllMWpVais4UllqdnM3?=
 =?utf-8?B?QjV6VWZ6dUpXR0lTRmF3cW5nWDJnOGEvNkxSWkJBRjlXWWh0T1Z6RXM2Rk5h?=
 =?utf-8?B?UEFmcXp5WEVsVGVqUmJiaUoybjdRQitKQXlJRzdheHpZekFWUzdYU1liUTNv?=
 =?utf-8?B?S3FNLzJncGlISkNsV0FYeWM1RlBmc1BFSUJ0RUZpcDkxRFVKWU5qTi9SaTZY?=
 =?utf-8?B?Zzcwd1hUMWZBNWVVZE9kVVlscHhTZjVXMUtZKzMvSkZ4ckNUdEpVMitpRzFI?=
 =?utf-8?B?REFJY2l1aDNQbWpTQU8xOTNGS251VXdVSTlYQlJkN2lWa1orVzFqNzhQT2hq?=
 =?utf-8?B?TDhRTC9WRlplTjc2Z252UEZ5MXlodXg5MEtaSVB4TWJXcjM0ZkVHcW44bk9s?=
 =?utf-8?B?TEVNamE5c2x4eHljbjc1eFJXVDlXN1BYdlV6L2VlUXNlck15ZTJRYWRVZGNh?=
 =?utf-8?B?b1YxWXA2bTcrVnRzTWsyZy8vVkNKME9wdmx5N1NTSWZSS0NqeWRQajJNRkwz?=
 =?utf-8?B?Z0hrQWJaelJKT3IwRWp6dTVmUmdCU2dUK05oZnF1S0JNUmxOMG11TDJBeW93?=
 =?utf-8?B?KzJGV2grZkpDcXUwcFhPTCtEQjd4NGt3MUZPb2VZSXZiOXErMXpUcFA0MzRy?=
 =?utf-8?B?RmhQMmFrWDZBOTNxcGVnREdIc0lYWTQ2RHg0bksva3pqZ2dUa0hsei9pZEs1?=
 =?utf-8?B?VHRBU2t0SzdyWGlHWmZXb0VIbVdtSTBnei9ubWpMUU1JMVNzdkpIRS9ZSmJm?=
 =?utf-8?B?QU1zUVg5aVBwZFlSYUJnS3ZENjFtMytWQWtRM3FWeDhodCtvVnNOSGl1VlJw?=
 =?utf-8?B?UTlJTHMydVBzOW5GRmhIL0MxbEE2aXZ1dGRKaGZ3TkNuc1FlZUJNNVRzTFdT?=
 =?utf-8?B?UUZ1K0NPTmcvemMvZmtvQm51bkJuYWxCRnpqbVh2amd5VitpNGp0M2lwZXQy?=
 =?utf-8?Q?YTSE3f6Z6/YOh+NoZX250/9ACHiQd2uN2zEgg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4632616c-76c4-42db-b863-08d953a9b88f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 22:31:06.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhnBANwOQR7h6zZ4JqmtR1Akqxs860QroJ4JvW5Dtq60yn0mAl96PyiUOh+8bxg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4917
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: T-B15iSowaTG0vX4Md7XceaPEm6d3NGn
X-Proofpoint-ORIG-GUID: T-B15iSowaTG0vX4Md7XceaPEm6d3NGn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=813 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 10:34 PM, Andrii Nakryiko wrote:
> Ensure libbpf.so is re-built whenever libbpf.map is modified.  Without this,
> changes to libbpf.map are not detected and versioned symbols mismatch error
> will be reported until `make clean && make` is used, which is a suboptimal
> developer experience.
> 
> Fixes: 306b267cb3c4 ("libbpf: Verify versioned symbols")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
