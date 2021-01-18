Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13372FA7FF
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407088AbhARRhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 12:37:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436605AbhARRhX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Jan 2021 12:37:23 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10IHYup4005887;
        Mon, 18 Jan 2021 09:36:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CjtVkCPiWjULQ5dYgeBSF7lTZHH8LxjK4w5/53+9qh0=;
 b=WLi5x1bRh6tGA/O+89Cz1LwKABLU02H8QmZzWH7ltOHzQ9m+gdBA+mIoArkeD5huyZaD
 xQASW1OXA90I5ta/WhLtzzwoTSQ6/gnWSzR54juUwKHsz5g8oF0ZdgkwgRGQs+5Fyf8K
 dtLqT17EiZgVlU4dDE6/MwbwWSGkbVd9Muo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 363vh583r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 Jan 2021 09:36:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 18 Jan 2021 09:36:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYdnRcNR5JczfTpQBX6gieHAGGKlvr0eX6Qx5OlYDtv1tdAi8V8lBVn/a6KBSnopC6gpvf34VdEZRnjV8XUIVRMGETXY02GWDxl2Eu03jZX/YEZ+ADkSxvcjgDvJCw5sdrWblViXTtQXW0HxsWRmGECYqtr16v/uGKbuQEwGK1UTxoCJYrwsoZhMBCzAnsUh8yutz6t+9+L8hZjacj+CP69tBx1xKZzoJte8CKn0J6IcDOgGNk4NLNXgCwfE5IQTRePVPw+7XC9qXzq7Kip5mSNkpdK5+eACdJgQmyZqAYAdATQi+ZSUNCDc/hnAcBp+pa7zEd4ymqJFREQCphq7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjtVkCPiWjULQ5dYgeBSF7lTZHH8LxjK4w5/53+9qh0=;
 b=IuDMyj5aqGVVB2t/Nybjsk1hYVXQ396gupE1v/UfvibtO2EkOjVjo8V/ZTTy6Wpk9FxjZr9nv3GTOT1AbtdqJ8NE8HX5C/1oKMICrD3c8E1f45GFeGM5pjM2Agz5Y/V482CO2SF1T0JND/NdkePlhrhYqWeWjND+CcCB0GRbsKxwnDnW0niwepPYAhl/wGlePPMkyFgYaI4GaIV1qVAXnyDIpLhLnfU56ecT60Wnj4MnFzpxHc30D7JlIPV524qUbPT0WDmuH1uZPkfpWbRsfXl4ttlhUp4VF+k6Ni3qI1ZJT841dVxW7F77QJBRs0T8tI0umyGoPTOIf2qU7R/CjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjtVkCPiWjULQ5dYgeBSF7lTZHH8LxjK4w5/53+9qh0=;
 b=eXEYWsDQtfSZgTc1xmq0D+PB1rcsKbSUHCdXD+kMVMt/zUSaxzHwCqVaL3vxCxQ4QePqm6kZ1WvaWF+ZWoyfRLaSQmWgprwPmvaf1WjIjeUCLXGyiVvNSBxRuFRd3kSaW5y3rUnFJr76mU15xUgWEHl7EfzSuxeixjRufTjWW2E=
Authentication-Results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4236.namprd15.prod.outlook.com (2603:10b6:a03:2cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 17:36:20 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 17:36:20 +0000
Subject: Re: [PATCH bpf-next v2 2/2] docs: bpf: Clarify -mcpu=v3 requirement
 for atomic ops
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20210118155735.532663-1-jackmanb@google.com>
 <20210118155735.532663-3-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4cbd024b-b57e-e7ae-276a-a285c898bb30@fb.com>
Date:   Mon, 18 Jan 2021 09:36:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210118155735.532663-3-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4199]
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::10cf] (2620:10d:c090:400::5:4199) by MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 17:36:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f210539c-bdce-43e6-24be-08d8bbd79134
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4236:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4236B99D40E3C39EABAA29E0D3A40@SJ0PR15MB4236.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/jIm0B6x2i/HUBgiXb5JvLewRjjD/2Ei5QRIvn3BnzjJcIwkYGESyLuz2ZUaajpEIHVtSP6D+A+DW+lk0Jl0TI8VbVN3Z8SL0i18ulOJjfC3tW9f1qd6OWk3OFqzeBJB3b3ehC8Z6jp8QOlv4G9/gFZvrSrOus2TPL58eXX2RQ2pnvHucLoUearQkQGSL6RQ0Gz8EUFEyadUS4evnTsPPHuz/JcK0RCffQFJV6veD7pDJe6F22aNXIl53dnU9zVDKGsG6VkRvJE75cH1VPY6DKqxZREHxXIgo56t9MYHpWBXaW7sud06h4ej35hTgGciAljZiIRX4SAfUugIWWM4LjjtJLCpF9iLc7aXxxWhMdQP6iLlncGFetngaZZysthytU4QcoXVh8bbfiebJJ0Bh/yIJQLuIIp+PjqOOs6VUb1RA34abCfk9mV7lFgsxS/fdRBq6aIUhHvceNuuV+PBpXPL7n48fjRwv2UTdSNdLI9oyhW1J4XQg7e1m/GMLA9x+0On5Td5WMmaMEtM+aXTxUFkygDLvutIA3hFFB8Y0oA2aU+21LHp2oIS8g6NgYw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(4326008)(2616005)(478600001)(66476007)(66556008)(2906002)(66946007)(4744005)(186003)(31696002)(16526019)(5660300002)(36756003)(7416002)(6486002)(316002)(53546011)(54906003)(86362001)(8676002)(52116002)(966005)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ODdWRW9rRXFtZ3VOOG9HdG5PT1RMMXA3Z3BJaUR5RUN1VVA4NjhFemZxMzNG?=
 =?utf-8?B?cytPK1dKdFliNlVOcDEwV3pEVXExWWYvemxZOGNFZmJMVVN1UFdaZFBNQ2dq?=
 =?utf-8?B?Z0pZZnZrOU5DUnB0aXhXR0VWdkwxN3pEOGxNTFhoZXJKQmEyV0Jia2NjajNl?=
 =?utf-8?B?RFFNekJVY1JoT3RReHpmcFZpM3ZoSFB1ck5vekY2UlE0ZlRXbnBSNmNDNU41?=
 =?utf-8?B?bDBpdVgyenZ4cGNwS1ZBc2xuY1NrcUZ2T2wzQXlUcStTVE9LQzVuaktGZXU2?=
 =?utf-8?B?VmtFa3R5ZFE5YzlDYXZTUW9Memw4eHdUZGdlSVRsVzIvQm1ENXY5VjlvYVIx?=
 =?utf-8?B?bjBXN2ttV3pMNXBtbm0zaG9nM2Q1OGRjOVdUSlFZYVUydk5YVGsvVmUxTFRm?=
 =?utf-8?B?dWJwU3FYZ1V6UFNRaHF5Rlc1ZUdQQnRrUWpqV2lBZGo5eTdMR2k3aEFudmZw?=
 =?utf-8?B?b1B6Wk5RR3BSYldib2FKaklPK0prNWw0di9uQUhWcks2MDY3TGVjUW9aVUFL?=
 =?utf-8?B?bHBaL0ZhYk1KM24xVnZ4THpMRkpkYkFSMnYzUGMwNFNLbmZXL1Z1RG5qRmV2?=
 =?utf-8?B?cklqMG00ZkROTHJucUIxME9FVFRwOTd2Z3RGSnpHK2JGVzJLZHQ0T0N1NSta?=
 =?utf-8?B?dEY0bFNUcnZBcmlGT0ZXYUZOMDhyZW8yeFl4MExtVy9DSmRLcVAvRTd0QXZx?=
 =?utf-8?B?VHJsMlIwTDJ0dVo3T3dSeTdwNDBqS1daNWgrWVdYdy9YaTlnd3NPWURTWkN5?=
 =?utf-8?B?cDFpL1MxYjFNdVBNTXNVTHpERG81a1hldFhrYzJmRGlvVHQ2bWR2NTZjZ1pm?=
 =?utf-8?B?M2pWNTZObHJ4dlRrN1gwTUlBU25GS0VnbTM4L0NzR0ZiUXk5eWdOck1TUmZ3?=
 =?utf-8?B?aXpCZVFzTEhIRE8zVHNUcEhNam1Cb1VHQXBuRmxrMVRaZ0I0Vy9RTTVjZmdS?=
 =?utf-8?B?MlFpMTlCVng1Mjh3U3ZQdk9YV2NjN3ovMkFTZkVFNmVpV294QkM1V3psRkt0?=
 =?utf-8?B?RW8rajhpQmlIMjIzTkViaGE1dFVJSzZrQ0lzNGZUTTh0eTYvM29RTkVJZWxh?=
 =?utf-8?B?b2QrUGtReTdyN3lBY2lKNVMrSWJ3TUNsa3dFZjVCYXdvREFxMmthbERUNC9y?=
 =?utf-8?B?T0xwdEFWUHdzczI5cFlZK0Nscnp6M0kzU2J4KzBubktkWnhiT3pYYmJ2eFJ1?=
 =?utf-8?B?WXBmVmdFeC84T1E5UDNkdnJNcmFrUmFleTh2MXRzMzcyaDJud3A4ZWMrcVhV?=
 =?utf-8?B?UVU5OFdETlY3b3FBOGJwaFhPN2hOc2ZaaFFPMFhVdUV6a1dsMlJSbGY5YTZE?=
 =?utf-8?B?R1FpU1YxMzhQeFU5OHRMaUE4V1BvdHFiUFFqbXMrcWI4NlU0TUJ4V2pRZ2k2?=
 =?utf-8?B?UUJJRWNtbldtRGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f210539c-bdce-43e6-24be-08d8bbd79134
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 17:36:20.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl7LLcASS2eAnt0qE3eAAciVBZsouExexUK66S86M6cJcduWnlyj7cz7alYJIelr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4236
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_13:2021-01-18,2021-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=927
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101180106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/18/21 7:57 AM, Brendan Jackman wrote:
> Alexei pointed out [1] that this wording is pretty confusing. Here's
> an attempt to be more explicit and clear.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQJVvwoZsE1K+6qRxzF7+6CvZNzygnoBW9tZNWJELk5c=Q@mail.gmail.com/T/#m07264fc18fdc43af02fc1320968afefcc73d96f4
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Thanks for better description!

Acked-by: Yonghong Song <yhs@fb.com>
