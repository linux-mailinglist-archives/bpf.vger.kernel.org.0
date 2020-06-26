Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669320B584
	for <lists+bpf@lfdr.de>; Fri, 26 Jun 2020 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgFZQAI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 12:00:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgFZQAH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Jun 2020 12:00:07 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QG05Kp020788;
        Fri, 26 Jun 2020 09:00:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=k5eO/UXj0qVdki5U2FRBWzUnO9xPkkTOSvB8v9Iu1A8=;
 b=Sbsi6X4p/cSWi3w++/DeH+nHhMChWwJtEujw46E6yP1+MozeigWpKkZhJzSHQklxxG0P
 L42EQDF/WBVRKtqSCHw5a+ke2L/I4zebNOzT7M/5Y+7wzSWLzY9lhcT3nWYMnAdoEeus
 5kpA5z2rcF78xGteY0a/id4RtWmqO4qKhwg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31vdpthvbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jun 2020 09:00:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Jun 2020 08:59:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en8s5PdRgw9hDyMm71YrEzSeutAUYQlejRcq0he4SGXGZ7/rswe89iRjWfFGHofkaFuR4pDpHIz4aT/IIEuzR7633g+s0OtTuXJQZyQbWRsiLEm1UrLlVuECy+ZI1pE02N3DmfPs3gZPEZJNQLsUFp6S8PaRPq68vqypQ9zaYiuDiRU5pQ4uEPKd4qPGjBndgkZLe8CZilZWh+vL0kkiHKM+wTBqZE2bNaKzyzdwEeagoLVBbOts21h/T3/rXw4tIOUTYdqN357Absym+D4RiwummQktOVifWgmgpnMf27AEox40YmyTFVWk/NZpkgy/y3XEY3ZVOnlZaj5zIfhxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5eO/UXj0qVdki5U2FRBWzUnO9xPkkTOSvB8v9Iu1A8=;
 b=ETlQZPAMKSwMLlmhzK062uMCwnWvN22JFqyJ4dzjCgJrAtQkg4tpONa18rKTgg8XG+wa6fj8U0jcoAQSFbYyEPimdYm6RNK+4iyCxF8Hf+o/6jahKfApSDK1qxQz1dGrqFe7xRaHzQ1MAjXDHLZD5fLDRuuRXdTg7FJEF9FzfQfC2JwpIHGCS1sTF/UALkaAx5wLpOpd52PP85ffGCGMdUeCAlbKM0e5/lsuGNcPOOhIzRtTo3AFCZb6YCXFooK35KgfEC78GtXZeC1LqqI8UrDQoVsyEFNwYfLLKKlzBROXnIvcHPhYElcz9WHT+8OLCxtqG7OCUozibVbKCOo5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5eO/UXj0qVdki5U2FRBWzUnO9xPkkTOSvB8v9Iu1A8=;
 b=Fu4AGuUCmIfWFUo8k+Cqnd97xaQKsiXTUyOupFWsnQmr0lXPWW5dlciTPWSH4LQsWynJ6+72KCF6TTueUTdwn/UeQtP0RX1pLP7BiUMqwq0ty2TG707UoQ47870usLpS+WaRrqEiZhYO0aieRB7f3Utho/7aQzzyMz53jtR+KJw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2648.namprd15.prod.outlook.com (2603:10b6:a03:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 15:59:30 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.033; Fri, 26 Jun 2020
 15:59:30 +0000
Subject: Re: [LINUX-KERNEL] - bpf batch support for queue/stack
To:     Simone Magnani <simonemagnani.96@gmail.com>, <bpf@vger.kernel.org>
References: <CAP5XGZejdCVA0rk9ctj3=i_QPSDVzJem+nbzz6KVwJaGUS_8GA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7e8f76ab-c130-36b7-91e4-e155a0a91aa8@fb.com>
Date:   Fri, 26 Jun 2020 08:59:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <CAP5XGZejdCVA0rk9ctj3=i_QPSDVzJem+nbzz6KVwJaGUS_8GA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:a03:167::30) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::18ce] (2620:10d:c090:400::5:ca25) by BY5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:a03:167::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 15:59:29 +0000
X-Originating-IP: [2620:10d:c090:400::5:ca25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ce5eb3e-29e4-4d4d-67fb-08d819e9e91c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2648:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26485699C3EC8AA4AC8CDE07D3930@BYAPR15MB2648.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjlWR8egZv/B7pZvXvbuiGTkZd6Y9srNHCsufa8+19qEU7qDUOZlrcARgDHhQz2NOoJ7PplBfZ7ukmR4Z5s0JVA4WJbLv6BK3641dMUUgB1Sbcku09nkPBfNU8JDz57d/3j0vCq/N1VP+iTfDYZT0/4afIkTKdOr82oB2RphbILGyrIur/JAN0NhBi6ECtLHrTHnsB/Ppb75nA56hmI33PAw2GQTMqU0FJyRjsMzO4vZrLZo0l4KpbbJbaH0sUdr4HfWmkyIEIWY8yd7TFjGdoTW0pU1UHc6EiqTrH8wpRm3/btslCQRMz9X5QhwNAw/DZyUuo79ehWgWSntH/tFwRS9cQ9Wc/+OO/U8fWxv/LEuyMa8DVfY6bV6tFwRKUVR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(2906002)(478600001)(53546011)(4744005)(52116002)(86362001)(66556008)(66476007)(66946007)(31696002)(31686004)(5660300002)(186003)(16526019)(8676002)(8936002)(36756003)(2616005)(83380400001)(6486002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cNPM37L0WFMss8OInYdgtF/zGGrH3JpMS8Q8GZU7ZPvCWnK9x4QJycFIKQbvmX0zsGw78xrvWiDtHHurv0dgweseA51XIMF5avFu7hQvkkdvvwBUpBweuRUN+x3OexdsVuPgvkabOrseP0/XM1cF0LW6CfHFuPwj5fi7iBXDbNeFYmFk4Gct76VFtA/ETgbWzsO3V1Nri76M4QvP+wewsWUKoSLEyNpWCxPnZ9+bGTFxx588XH4PUpMEyhMTGfRQAD813RG48kXtIp244AfiU07YXldCBS7qrDGBE/kVP51hXqCZ6lWIsIikZHosu9Votr0M+7h9uvCbi+SuS1TJ/1q4waNyT1+h7LbqXjH/aLLD2iQ5iDcBqg+Zuzxz9to/qU4xsHZ7RONr9Ux1mYN1WKBnzqt6CAhZYJpGjRCGSkAB/YpiI5d4p94uzhWA5YAsOPB9DiaYkuFysIP3XisfrOltrw2T8kHpvd3O6UEMNut3Jg0n88NqaJLGpKmfYQ6fOqaXRdCKKBSW5pcjLPdwhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce5eb3e-29e4-4d4d-67fb-08d819e9e91c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 15:59:30.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkEwdw10LIkHKrTfVNIlD886QF3fsnqesJryKoHRbdzRgU8znNwPu9jbdc58MPQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_08:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260111
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/26/20 5:01 AM, Simone Magnani wrote:
> Hi,
> 
> I'm Simone and I'm new to this community.
> Lately, I've been working on in-kernel traffic analysis with eBPF and
> the newest features released in the latest kernel versions
> (queue/stack, batch operations,...).
> For some reason, I couldn't help but notice that Queues and Stacks bpf
> map types don't support batch operations at all, and I was wondering
> why. Is there any reason why this decision has been made or it is just
> temporary and you are planning to implement it later on?

The initial implementation targets to specific use cases for
hash and array maps. Yes, queue and stack batch operations could
be supported. The necessary infrastructure and example implementation
for hash/array maps are in the kernel tree. You or anyone interested
are welcome to take a try.

> 
> Reference file: linux/kernel/bpf/queue_stack_maps.c (and all the
> others belonging to the same directory)
> 
> Thanks in advance,
> 
> Regards,
> Simone
> 
