Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0512CE724
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 05:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLDEwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 23:52:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38934 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgLDEwA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 23:52:00 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B44hvku029742;
        Thu, 3 Dec 2020 20:51:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BqnKxW0u6hCheQvDJ/Cppv/yeyBy49uaCsEl1gM87vs=;
 b=hcxY5Wqy2VNyQDrQ1TVHYEMioGZ8fY2hex6vRFG726TH6cLX65dMg18S5pa6R+FuvbDR
 4iewsD+bfku86mcZzPNtKVBMXanM2TtO8DAzbYtEnereHU+TXtiIO2RmaFh89Il5xGVT
 lL/wKmwLE0Q3MKO/JbhwVXWDu5mfJIYroAE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 356ajcprh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 20:51:05 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 20:51:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxk2xIpsK9ZG2a8BRUvKpYscFs9QZaZHx8fbfqgGRGvNiumFTREZkaJqUBq8Huy2/+zgytFP9+bY6DQ1aMA2RpfnQ8okO9dMCyR6tiMZmBf8Z/ETwandlHZOZUB/sdQx1NGh5MTtfDIak8w7R0hocOWy542ecruPyJWspO2A9tKn/RLQ28h+jHX4SKVICMjLkBhd132TyokE7FRKZVxjx1Gc7jRTqhYIdEK9TT1KIp0jqxuwIBthvlPT6TW7z7AUfP285v3emgCFrID0Hg46Qc0L8uUOsr55ABuQms0qsOOVMKxP/IbvofV+MI1HlkHluNvdURXtvHNdVUvvFqKKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqnKxW0u6hCheQvDJ/Cppv/yeyBy49uaCsEl1gM87vs=;
 b=KoXdXmKvThl8Ng9OR1N3Zgxk7mfTNVIc8oBUfOC/zUZArd24ZqZa+h4bskUQu3LY/XDMUcfkslzzoOlhTcyKoufHFmzQCQBtvAuPx/yfl9+jumCV/vUAjalCJL7sbl8/AAGBriIkh3RxCN7HdOIRKdu1IrUBGJCHpnT3qzS+Iwv38LdDsaQ/DesynP+O9hIpapn8Y/BEZVf1B+EyMXLEJYcV01SV/Eiv0AgRz2BixA2jlZm2jH+T3n7sA/rDk19fdr7xgN5InjUy17QKK8sJQlKP6LWFxx8CC/s8nFyKxw6VTzyMvOciqzFm5hlmvMIequHSnzt+rnEPIYIVrQ5y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqnKxW0u6hCheQvDJ/Cppv/yeyBy49uaCsEl1gM87vs=;
 b=PRqrXUSruWcvJF45uLkB3DoSDHp4JyaCVREqiSS7V3ZiaKLH8zIC79CXKXXt3I1KD6z4RHnn55+0SWtx/fQqBMuJSz8bLIfGNr7MhJxP5M2iVZ2UeP5SM2BXGN3fq2ZQP3/IfhO/bbB347zp2oC5yH/kO/Dy8c5rBQkbsJR1RBY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4117.namprd15.prod.outlook.com (2603:10b6:a02:c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 04:51:03 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 04:51:03 +0000
Subject: Re: [PATCH bpf-next v3 06/14] bpf: Move BPF_STX reserved field check
 into BPF_STX verifier code
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-7-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b262bbb3-b453-1308-4478-c41d37814be0@fb.com>
Date:   Thu, 3 Dec 2020 20:51:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-7-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:86b1]
X-ClientProxiedBy: CO2PR04CA0139.namprd04.prod.outlook.com (2603:10b6:104::17)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:86b1) by CO2PR04CA0139.namprd04.prod.outlook.com (2603:10b6:104::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 04:51:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345c7bf3-d127-4ae7-37d1-08d898103415
X-MS-TrafficTypeDiagnostic: BYAPR15MB4117:
X-Microsoft-Antispam-PRVS: <BYAPR15MB41172792CA14844F4CE309EBD3F10@BYAPR15MB4117.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqfc3iEkk4HMPT0i0lsOrFJg5TUrpkjMzXPuZ5xeJi0nNb/BD8tcT9N0njwWtX4yItL0p22bqTKbuvcJ4HtRLd2lq+7tu0APuViL6O1aw7lsImFc8n9KAm5ZjU45DqPhKFfaZHlvmWjOMlNQ6iTQBcTs+HBEuUS8r8wgjlWtKYLGOu2qI9VMbyCu46inigL4DwUn1S4z8jdkWh8mPQZFRAzhKW6JN/0DcIV/vROg/Pp5zFwGWDMyuPuso0xv/63/j4Bo1yYrctV6z1SFh56Ovd865BuyNR9h0fPBl7fVdkCTKKc19NXsjVipy6inngRBRC/wSDTZZ3ILneQraxLdkDvP5wJxSIBM3JipTy241vGOlf8xpma35OI3VQl6fElSutgksROzCDSuINQCoIDYPh22rjTnL1lt7J8rHGAIKFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(31686004)(478600001)(66556008)(66476007)(52116002)(16526019)(186003)(4326008)(8676002)(53546011)(2906002)(36756003)(8936002)(31696002)(54906003)(86362001)(66946007)(5660300002)(2616005)(316002)(4744005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEE0dUNVVkVCSXNjLyt3alNNd2YwNGI4ekRoK3VzNS81Tm9hU3A3eHdmUjZZ?=
 =?utf-8?B?WUlkNnFwems1OG5YeVlhRWtvZ2FDZ1ByZlJyWEtNekVjTEgwTWhsblU3ZE12?=
 =?utf-8?B?Ri9MNXZaTUtNY3BPNjFvOWRiTUZLemwyN1h4blUwTjNLNDk2Qk85OUNkNGhT?=
 =?utf-8?B?Q29NazY3RFhxZzhrMWx3TnozOUtjaktpZlFUV3ZsSmQ2eVhDZ1o0eHp3R21O?=
 =?utf-8?B?SUxvUUxGU29oRmJFdld5eW9zVVFWckdSY0RxSUYzK1VKOEF5TjRjTHBhRm5E?=
 =?utf-8?B?YzgyNTdTOGk2Q1RmOTBWTVNnd0Irc1ROWHFSZUNWQXBzQ2E4aVZXZ1U3a2lk?=
 =?utf-8?B?ZGh3OVZ3VjFmYWhjM09FQ2d5VGs5WElVOW56RW1tUTE1R21nZWord1V0K014?=
 =?utf-8?B?NVBCRW9zSERkSCsvdFpkZE1NSjFmNlRJbUhFaXh2NksrWlNHM0M2ek84TjhX?=
 =?utf-8?B?YlJPcXoxQk9FNTJkK1lJOVlYczA5ZEpNVGMrNVNING1oWXJ5R0RlYzR6T2c4?=
 =?utf-8?B?R1gzUTZJcWVTUHZ5ZDVXV21xeDNvcmJUUk9BRHRWcU1XMjRQR2o4SldObHpp?=
 =?utf-8?B?ZWpCYUdMMmYvYmJUTUN6L25IRzZIWWxUbmlDRmlFV1h1cmQ0ZFVpOFZJenFL?=
 =?utf-8?B?NmZyWjhjK0RIWE5XSDlzOFFhR2cxdVpQbTF2Nm1reUgvQU9mVGNCZnNrVit6?=
 =?utf-8?B?T0VFNXBrN3p1REN6b1htOEtWWkVVUlZPOTZoNFZaWmFuM1Nyd1JzOEJLYyty?=
 =?utf-8?B?U1lGOUNBNmJ2YUZUQmdCclZIaEI0Rk9WMnJzTkMwL3l3N3N5QVhodDBxN00w?=
 =?utf-8?B?Q0R1UG0zSWZySU04RGUwUlhJSURXTW5WeFk1NHB5R0ZSWmNpU1IvemZ2UkdO?=
 =?utf-8?B?WFlTMDFaOEgxUDJpMTBFNzFnZ1ZBMzRaTEZGd2pMdnRnZ2dTc2NyYTlhSDky?=
 =?utf-8?B?RjdhQUR1QVlDczlUT1F1aTM1ZlZRUnpNazBIMVZmV3hiZGYrWjQ3bEhQd0t5?=
 =?utf-8?B?amNoNnR3VTNsNy9heVBqbTdrdnZmanRMWW03WXZVTU43RVJiSDNHTUw1eHVL?=
 =?utf-8?B?UDh6dHNiQzJDZ1JxNU5rTFpJTm03SFBlR0lTQ1FtMXkycHpJUVdFOWxhenJq?=
 =?utf-8?B?eTlON29mOWY1d2g2c3Exa09JOGJvYVd4ZnVBRlo3dGUzeU5hNzhPZ01kWGU5?=
 =?utf-8?B?NnMwYm5GaUNiR01UZ3V4K2JEWGJRRUNRUHQyWGxEdXo1MVBOMHR6aUZObzFx?=
 =?utf-8?B?MzFDUnIzS0FOcFppblFzd1pJYm94RTNLcmdLUG95MmovM1A1TThnSWZnYXFI?=
 =?utf-8?B?alduczlxdkhKT0VoakNicURsUE04UkorVDVTTEJVOEkxTlR6cjhRSFNLR3Nt?=
 =?utf-8?B?RFFTQXkvSUw3aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 345c7bf3-d127-4ae7-37d1-08d898103415
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 04:51:03.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fzbPLuBMLxIUbgApSj1J/zA5Snt9E7DKj2oCOGkaS6NTwpW7zteZP/9Y3NXRzHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4117
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> I can't find a reason why this code is in resolve_pseudo_ldimm64;
> since I'll be modifying it in a subsequent commit, tidy it up.
> 
> Change-Id: I3410469270f4889a3af67612bd6c2e7979ab4da1
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
