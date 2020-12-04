Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C812CE737
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgLDFDx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 00:03:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725300AbgLDFDw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 00:03:52 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B44xv8R029035;
        Thu, 3 Dec 2020 21:02:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=68LZFNQH5U7WeffAMaVX4k8p8kkWTfDqFhuKMP08TQY=;
 b=A3AFPWZXw4cQK2n6T/gViE4esv4eWZ7xip6qkMWiXveRbYK9ARbew9SUOviWvlS9WP6F
 o8BViaJrPWzlZkCSB4+74KaBdJU9XfgO9UCYUpl+PEUHvxbNsWtrOAmIuYHwxgqohYin
 q0YLLZh6W0uC/+IYgTW8ewQVC16sJ+ZgYWY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 357682b908-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 21:02:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 21:02:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmjTz/YfRNoDiH2pry7yNjysh8lNtqbHELgffOsITXZyuzGtCVFV/Q9DQpor0+dNocnZ2FZzjKtW3Oz4bxUAO4pK3wVTp2K2ziUyzOQ08LrWyuN/V+x7MPVAXrCjDi0gwEK9mb1/DW5HYrIoeezE/33Ya/xNhKZKeWz7lNAtTf0Rx320Hko4bJYzi3GJi+dvMnjojBVW6Bm47PIxyd5uipm8bS+gET5xc11GoIBgvttRR0T387MjeM3mLB/urOQ+ubyc8+3MLoaIfPMHNbzPTSgkVfd61gxJfY13ktvN3CqK4gfqD0ol0et0avBlTzAi4xhzTjSolSRWlC6mS3mwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68LZFNQH5U7WeffAMaVX4k8p8kkWTfDqFhuKMP08TQY=;
 b=J/3KC7h5+Nm4yObFrfBuMF4Zo0uiuwa12oDgJgucWdN0ziXH7RDF+dN9JSYPwD/7/R4KNgMVEl3xQLpWAQ0IrVitWUz7gbK9v5xki2F9Zg/fqU+E8ak0OaoOlkGatGUzoFO0BErEaaU9Z+aTXRe+mYt86camFqUX4Wzqmm4i9x6yIEE498u+Am+QG1Wt0I5ibbRWlJwpZEZ8mjXPdBSowZvFjZZKOxIMGqXWE+PFMJZ6PQkOqDkaT+7zDyVR3wH38QF8611Bdaxku5duijTXjEgzgXvLI8mI8D1xRq9q6xdKmR0kryWT+fYBnigze8iyJV60mXtSGpktDifeT15wVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68LZFNQH5U7WeffAMaVX4k8p8kkWTfDqFhuKMP08TQY=;
 b=XST82b+HV1k0IqTA+dieKeoyJPr8CTQ8sJcLn/z/DO+yBRwbRll4mkHpVVlQHzvPzQlpv3mB+PEv2gSYgWKRHmQG/5MMiFL9GXSdYll805XQ9zyyQ4gfScM9fGtoH5BIA55Q4kpeBuKlpmUZhyZDCzNgPb/AqWXhZBpUEF75pi8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3713.namprd15.prod.outlook.com (2603:10b6:a03:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 05:02:50 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 05:02:50 +0000
Subject: Re: [PATCH bpf-next v3 07/14] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-8-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9e19c8e7-7d46-0dbe-619a-1b6547fc7f73@fb.com>
Date:   Thu, 3 Dec 2020 21:02:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-8-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:86b1]
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:86b1) by BYAPR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:74::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Fri, 4 Dec 2020 05:02:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d472dd04-4a27-4e16-2deb-08d89811d9b2
X-MS-TrafficTypeDiagnostic: BY5PR15MB3713:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3713650797F7E0EC6B6727EFD3F10@BY5PR15MB3713.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHcWSsWTnjQKT2umgtgI35FlMqpp8+0rmwwernijB+ZgnbT830/FE3tukCUjFaZYBHYbiXngtLBbAmL8jIS0oolAREcf600In0nKLM6hi43DttvcM4zIK6r9lMGW/yK1a4duDus7VzKI1uLuzICrm9r3AZq9gVItjsZxPA7K8UYzK1XtLMoX7TT13kmo4LjGGHEnwdT+ovSVXBBY+R7wfi8+6vkSAnSlaAx+vej7rGRF0NLDufMZI5ialUjyuWFMJbXKzAbndcLtBNFk0Zee2Ipxg8OVA9Jd1oltAJrOh53ODgvK8+j5r+tp2kpy1RrWl3Zlh+XdDTrEgkhU/18I1pFolZu4/tu7vjt1qOyKuSLlu2Omqhgkla1A9LFbOq1nbQyB1YsHU3s3jdLxzIRJqzq4El2P2f8W6o16K5XRPWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(2616005)(31686004)(83380400001)(16526019)(54906003)(6486002)(4744005)(86362001)(316002)(36756003)(5660300002)(8936002)(8676002)(478600001)(53546011)(66476007)(31696002)(66946007)(186003)(4326008)(66556008)(2906002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TERja0swL05JRjVxTERINy9oOUQya25LK2VpUkdlQTNCM3JaTkdUWWF2c2Rz?=
 =?utf-8?B?cWEwd3pmUlN0aHJRRjNybEh6VjB2Y1gvVjhGSEwwNUErd2FXMmphVFFRMzhp?=
 =?utf-8?B?eFAzRWRQbGd1NVJhdWV6MDVlWXVxTjdlNXBjaVdqZXNqK3pKRFNsMEozaG44?=
 =?utf-8?B?SWhXOXVENlRnQ0pXSzVWd2puR0wydFRXNHZqUEpjSG9OT3hmbUo4dEVqVFdD?=
 =?utf-8?B?RGJNSElnTkcvSnArRzZIcTViTHpSMjRzc1dwemNsajZNM3NLYXNBMHBIRWZH?=
 =?utf-8?B?OXp1dkdobmpLc2JmK0EvSzQwUGVlSW5kNXhDaTFvRVlvVG1yU0Z1RWNWNnNS?=
 =?utf-8?B?N25EeERLb0J6ektucUJMSlNnbVdpQlpMdmVmYXp5Z1ZhVXlCaWl0cWVrSEVh?=
 =?utf-8?B?MHNReXlXTVJFdkJVS3o5ajYzSGpSZkpabWpxVzRkazR1U2xtUXZid1NzTVh1?=
 =?utf-8?B?NjNVU3oxNWVEU0pWUGlZdHpiamRmcEZ3UEJycGtFTlV4eXhIMVV1S0JpbnVU?=
 =?utf-8?B?RkhBSG9JUGFMazFLVDQxVkpzemVxcVFJdVZVNXFCTGFKeTREUEZOY2hERC9C?=
 =?utf-8?B?WjAwSXBndGNXblNBTHZ2VlhJNFgxSnNIV05lNnl5dTdnczFmR25UNzd2Y3RR?=
 =?utf-8?B?TVRsUXZYU0UzWDZyNXRzbi83VmZUYW5GMDllN1ovMEw4WVYxcTcvYithZzU3?=
 =?utf-8?B?bll1Sis0VkthNlNxL0lLaWltUHdmaWNCTTNJT3F1K2RyanV2bFFOa1UyRlJ3?=
 =?utf-8?B?RTQ1RFd1NmNtUnUvWlQwTTI2RUk2ZFJ3elhXUENobEw4VytqS1R3aDdUckVa?=
 =?utf-8?B?cGNlMWZYcUU4YlZZbWNRclE3YmVsak0xcklVc2xrb080OEdLMW94RTNiQjBN?=
 =?utf-8?B?a1hrUUxRUzJDTkZDUFVsbGt5MVV1dHluMktGajJaRCtLYk1GTW1YZm9YSW05?=
 =?utf-8?B?ZVB0eUViTE8zVU1pQXBJQllESVJ6Nk1XVTFUb3ExK0ptMjdyOFpYanhaM2hR?=
 =?utf-8?B?ck5ZNk9ILzI2Mnc4K0VuejRlUEs0anBCV1V1M0w0OTNOdDdJdmpjR2FJU1Rk?=
 =?utf-8?B?T1JUOUxqdjJ5VFdVRzlMZnMyTHpXeVl6ZTVPWnVVYXF3a05Rb3V4cGZubTkr?=
 =?utf-8?B?aUtucjRVWkRjUGttcnhUQ1RyMHhMd2I1WTRad3Vldk4xR1d3TjZXWG5FVUt0?=
 =?utf-8?B?VVhUOTlSTk9PMWQvcDZwbHZ4NkxXUHVudUhQdnFuTGFXNVNnaW4zOUQ5TXFF?=
 =?utf-8?B?NWF1NWxLUzR4anhnczY4bjNZTUx0eG5NUCt4ZUgwdnA4T0VrR1daV2xUeFpj?=
 =?utf-8?B?QVRIenh1cHBEc2xUbEh6NTR1QWdMZ1EvQ2pFTzAyM2o0cWc3bnI1eE1wbUpp?=
 =?utf-8?B?WUYxeHBIUWtrZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d472dd04-4a27-4e16-2deb-08d89811d9b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 05:02:50.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vVvZJgku9WSXIMNB+E0heCQ3Qk2tgwp5SK1Hwp3g3KQEdUz/Kc41T+2vNCON9/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3713
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=754 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> This value can be set in bpf_insn.imm, for BPF_ATOMIC instructions,

it is not clear what "this value" means here.
Maybe more specific using "The BPF_FETCH field"?

> in order to have the previous value of the atomically-modified memory
> location loaded into the src register after an atomic op is carried
> out.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with the above nit.

Acked-by: Yonghong Song <yhs@fb.com>
