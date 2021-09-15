Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14A740BC77
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhIOAJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:09:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64018 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhIOAJg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 20:09:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18ENS2ac000541;
        Tue, 14 Sep 2021 17:08:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rIzpamlhf3YRrKrTzwPza7BdNGDMJLxH/ahYtX9xuWA=;
 b=LUu+M9lGw3Uv1aUz3/WwvvH56XgFC/l/5aVEXXlGpI98ed9F02atcdtjoZ7EiNrcKizH
 94qTa6U2GrYo0ZvZOmd718/c73PK8m90HgZ6DXeMJlgj1bgBHxmPHlOxPVz1Fk5EOPLO
 Y7Touz6R+uOajWbgHoIzYAUGGRErRlvIC6g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b33y78qdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 17:08:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 17:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWzvVJKmN3HY9oFk8BUhLcl4ojm4Z9hOmsAqaUYI3s56mk9RStrn0bxusUbnSf0Jw+mPkE6aseNK7HdKos8NcFB8cMIaQojzveXFYnbIYMkYvlEZ+AvCl3JTop8xSXyYlGRTgEn3FWTKRRZ7PUbh5M2WaS5E387wmMEbCzs5N24x6jQeyVvGqxfyU+L6u/5kiqSPnasXeDE+GOLHSchUyb/r4ytFzvWMlzBqGyGZMO6/0FPT1fsJLAcR+gOP7B5y2PeXzsLDt9e/sZo7kS+KpbHVMQVpR6gRFI+kQxQFSWlIHYnjDYdVdP5HAgSI5C1fn8n79jnpoS6j4SSO6q6jQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rIzpamlhf3YRrKrTzwPza7BdNGDMJLxH/ahYtX9xuWA=;
 b=OWsLOuwjucDpd+qJ/TyhxbBCDbDlBO+s+DtFFyEqh43tB+/W29wn6bHkl3EJoLydzPRRP9JbWbfcF6trwzg3cHfRq1eO22ZwcPKUbGiTxUSKAV420/Ovw+ZzgnvD6hb+gm1T3v30Ztp162RHAmcRQsBLoWdnzxC5OWARnescT+PW1j7zZ9oGm3wrVXE7bYLZ5fDm8n9HtXiOoTh/zjrxC1v9sdX9LC6g4UoFoFXEYHr6o+DIg4kaNrQ1nqwR6PAejg10xV3yLwwrZHAZzFwkAcyKcvcWRISEP7+xOAIVAh1I5i9/1FmffqzqpqXpTImcHZximudByhjao2o2HhiYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 15 Sep
 2021 00:07:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 00:07:58 +0000
Subject: Re: [PATCH bpf-next v2] bpf: update bpf_get_smp_processor_id()
 documentation
To:     Matteo Croce <mcroce@linux.microsoft.com>, <bpf@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210914235400.59427-1-mcroce@linux.microsoft.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <94b5dd50-ac04-de03-996b-899f7c19a6da@fb.com>
Date:   Tue, 14 Sep 2021 17:07:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210914235400.59427-1-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:1c4d) by BY5PR17CA0042.namprd17.prod.outlook.com (2603:10b6:a03:167::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 00:07:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19fd109e-b8fc-4e50-f045-08d977dcdfb0
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4433FADE8CF38ADC434C1050D3DB9@SA1PR15MB4433.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mjV0bfnnt+WTX9A0GklwMw23xUrN4cllFUYiyTRlhzbXrTu0QOpQoHqHYJV0xEVCFtV7SK6y58IFlx1hR/fwSVbHi1s3Xob/RiTF0FVnI5+5FuffcaJe9c2N1ZodEAbGeUqXwU7P0lrIuWmnaZCcUkodKn7T2vbur4fA6h3e9eIg6kaGOTVgZjs+vM3Sn9KswftFoL2Y+cPwCIuex+q2S63g6Fk7jXdiftt5ISzqkrsv0wbE593zPtJoNfZDJv5RMDbkgR9Q4DkVT4wRwgdVsJeGwMaGmhWdcym2+8xjAabBrBa/s+pmuymUP0T0qoDE7BYtwuyLz4ISp+cQ8aUBDZXJG69lSAliZwGgnmEboB0eu6sGntwIhHhQpdph1CTuOZAue0RJvKwTokJpthK/AbUR/N/+oGQp4DRE+iEVNcFLrUdmTi6P1Q2HMcKNhwS4yx4gW00sO+73z90MM0s7jGQZ8mDrsNuirahEl86fhb13gC5m/QoLtRrsNjW/jmIAZ+TXKpVYmM49dx+h5fbNXheqEaNVLdiC/N9f5VEY2lohYyoh6d4FT21ivljcswk+29OlptbdVGGwtuJODfHnHphV4m6ZcYwCyHeW0XTUz1aFo6Swzn1s2rAOYCAYNW0thVG+l1BQWS/bfSG9AFFXtqwWQM0+30o4AIkUknuAaFEiUQyQ6aRxk2kCTLFD4i/MCivbGXeY/uiJuywchGXhq2XUHwIfDRoJdqLdQfilWdio126dr4e269x2GFqY3vu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(5660300002)(54906003)(86362001)(83380400001)(6486002)(186003)(45080400002)(316002)(38100700002)(31696002)(2616005)(4326008)(31686004)(66476007)(52116002)(53546011)(8936002)(2906002)(478600001)(15650500001)(8676002)(66946007)(4744005)(66556008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0lPL09hOTRuR2tYV1psUXl6YUdaZ2R4TlRaY1BBZ0RUd2ZpeURWYkJWTjlt?=
 =?utf-8?B?amRiYVdPNnlJYWhQVjBUWWpnRXNlZVBQVjZEcWFjMm9lMlJodW9iYXRURWp5?=
 =?utf-8?B?dXlVdlExOThhNTh0cU9aemRzK3crRVNzZzB2djVjaDFna1YrdEFieDZwQi8z?=
 =?utf-8?B?STZ4TTFHalB5NitNZmZQVEZBTU55RGE4SG5zenFhM3pxUTg0Yy9qWUlrL20w?=
 =?utf-8?B?NlVUbnl4RUhjT3RjZDBWWkhLckY1YTgzV2k0c3hZbHdwemYvYjZlcnhmSkJ4?=
 =?utf-8?B?bUh0RmU3czhLdWsyazRnbmlOTFBmakpJdjZ6RjEvNHNqcHdiTk9jazk2MVVj?=
 =?utf-8?B?SDV3SkpTYzEzUlpmcERLVWNrMkV1ZDRaY2Zacy9tanMzdWJFWXVna2lRaEhr?=
 =?utf-8?B?TmJqcXJ0aE5QeUlmRzQxdWJ5Y1NPY0lPaUFFS1R3WnFJOCtWblNLSjZFWHEz?=
 =?utf-8?B?N0ZsdTJIdVloS2ZkWmpheVFBaG5xNHd3Zml1NzZhOVgvaGdEY0daL28xb3N0?=
 =?utf-8?B?SHlabkRaaXM3Sit6RXNoQ24vNk9DbDYvdEM4ekJmQnl1WWtxcm1ia1Nocldi?=
 =?utf-8?B?eGk4NzdHUzRDeU93MFluYS9JcXpqRjJZRUJha0dsTE0vajhOYW4yNHAvZDFa?=
 =?utf-8?B?M1UyellaQW1uS3JyYzBKL2tCS3R4N3hJT0xDZzJyKzdEZENCTGc4MHdFZE1z?=
 =?utf-8?B?TzZyYS9icHozaUNUVG0wUnFPdVZTYTVnRjVZVzJCMmg1L21ZRmIrRWRMS1Nq?=
 =?utf-8?B?TTYrdzc2dkk2SUFUVlVUNDUrR1ZLTVpzaUlYWVpsT0IwKzJpd25ZT3NHZHM3?=
 =?utf-8?B?MDhJZ0ZiU2U3d0Vwc1NLdzhMT1pvMzZiaDN0V3ZjaXJjUDNXSWVjMDExWGQv?=
 =?utf-8?B?SXQ0SGlqa2xyN3Z2NTd6eXhqMDk1ZGJ4NERVTEV0REJEaDRHSm1sMi9EWXZn?=
 =?utf-8?B?dGRwSnFsRWZSWlFWQVVIUGJmQVcxay9vNjZlTlY0Wmo5WnhXV1VwOTJLbm9B?=
 =?utf-8?B?UUJCSGtzUG1TYitHUnJuSTVjR3NlcGdwQnpHdmtqZ0NORFZEcFBtWHJoZWY1?=
 =?utf-8?B?THZVUy9kNWdFdENlNE5RMGdhQ2lUMFA2c2J4S0ZST0dXZFYxZ1VwNjhHdWNR?=
 =?utf-8?B?a3dha3F2cWlBbS9ieDgxYnZ1OXBTSW1Hd2hTSVR6aDE1aTdaQmR3L0dXTVpy?=
 =?utf-8?B?ekIwRHhuYk5UVTJGTWRPeWQrV2VYRFVOKzRnQlNjTlJ1NjY2Q3NSb2pRNng0?=
 =?utf-8?B?MG15RzlvZ2w4a1VYcEtyMjg0L0w2TjhSRXJJYmpkd01odllQZ3VXNW96NTgz?=
 =?utf-8?B?S0ZQMXJYNEk0bjlUeXN2SE1sN3ROQjlJUERoeEhMc1RvWHNSN3F2WE9mOWVR?=
 =?utf-8?B?Nm9FdFI1NzNXZzNHWVNRaHd4ZGVzOTluV1ZjMVl4Z0J3MGVlYWpCWldqU1ox?=
 =?utf-8?B?czFFSS9rVkJiZHVCVkRaQ2hxS2tXaGQrZzk4K05nbk9LZ2ZyUmVqWWIxOHMz?=
 =?utf-8?B?SjlhbGx0aEhuZXk5TVBBMFdKWE11THRUd25MY1ZQWkdjSU1pZkFpT1RxVlFy?=
 =?utf-8?B?M3JaN0tIdzN6a0hmKzMraEl2TmliaG94bGZoRDJtajh4NW10eFNQenFQUU1j?=
 =?utf-8?B?TGM0S1VON1lPbXhaUkdWVUdYY2wydGhTMThDUEt6R3hNWkVwMjNCeG5odGVi?=
 =?utf-8?B?S2RleGlVOWVFaU1sQlBXRkl1L09HNFVSYjdrRytYdmtpL3UxTVppbHREQ05v?=
 =?utf-8?B?RXJKRkw0ZUZ6cktBemE3T3pXMDJkL21ObFY2ZmdGTVM5NUltODg5VFRsUUNO?=
 =?utf-8?Q?QVXLQP2nKXzQDa0Bn9UYClEdbT1RJDVpc8YZ4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fd109e-b8fc-4e50-f045-08d977dcdfb0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 00:07:57.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aWKQZ48uAE9SpuPqnmtzSggUjTHZXMqlKxO2YPSXd+24uwWBs0cg9SJ8W45qXI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4433
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: uqvBfmKcmjuJRwhX2xjEnDPEKfJobDe7
X-Proofpoint-ORIG-GUID: uqvBfmKcmjuJRwhX2xjEnDPEKfJobDe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_10,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=553
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/14/21 4:54 PM, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> BPF programs run with migration disabled regardless of preemption, as
> they are protected by migrate_disable().
> Update the documentation accordingly.
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

Acked-by: Yonghong Song <yhs@fb.com>
