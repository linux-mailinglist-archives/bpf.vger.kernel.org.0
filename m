Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A47447A400
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 04:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbhLTDwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Dec 2021 22:52:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237307AbhLTDwO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 19 Dec 2021 22:52:14 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BJHk1Lj018992;
        Sun, 19 Dec 2021 19:51:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3NcbXm7mB8Q69lUj6E3ehQ5TBKUUIKH4VzEFZTWNp/E=;
 b=Krb5U0QQfsJvJYgQcBLS2jCOS342k3EZqWyOD9VxvzcPSzlcq0SWvMHn2euqhxp/V0SW
 ZzAuYXT8cjvMv/KMdiFcBP62t9Cq+aJJp5VJ0H2Z98ATcd2TaKwEPTc33vN4R6EnIMNj
 SgBG+CQa4bz/pyGhD41MBMLoUDiRbC/XuJg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d29e0t46q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 19 Dec 2021 19:51:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 19 Dec 2021 19:51:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVebqxuWn4DuK6xndJPvBy9nyHS05YmUxUkmhejx7gGN/dslX0ISo77RVoUBTUV0ghKnPe9mHyfXkdX4Ihgx3sP9QIILsbKUIcEoPizGCMJjGjW4aKrmj6t5l0CmTeJCtpVkHD/gLK8eDI9Qx3I/ncxf3incUjXyamJlGZ8DnIq+c8oODs3bKzAdHmqDFdenPT92cbniAgNH1QQEtkFPP+s6MHQ6BEFP/6gJa5SNI2CfZFEYOEhBQDHt43U9BjJ4DgrCYoItazfphPcyHmeLdZH13UziTH/zaPLWg6JiWgCs86Zzns2tiQDFORnLxwmRs0hMwpxqvqWe6sIneQQJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NcbXm7mB8Q69lUj6E3ehQ5TBKUUIKH4VzEFZTWNp/E=;
 b=Ejb4H8Tz+GMRg+Tgge3GlbXjkGU7P5V7nnWSIrmgTzSgf+hZTDDIXF8TJAeTWNY22bidR44ijrv/UVtXBZFHOCDkFBy2IjxlllhB+si3XgZTXaum5CtXcl7zQf2JcJ5GOIdXIzVxFkMO6IRaSPtLh9Z35QupCvyiw57Au3mLdCfeDCMdyQLCQ4f7bTSzHMjOxibwACPRkITwn/R7l9dOonc30F8xsv4hqWDPiWjzE/wccwDU+YkHC9D/pPeUf4xc7x5btwHeX2V5ZZ1e4p+m1ywse8mFuWSJ8g6PNksIsRwJgZqh912D6zTBwPhJC4RcLYHRMlpEWQswJ2SxgbePqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3966.namprd15.prod.outlook.com (2603:10b6:806:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Mon, 20 Dec
 2021 03:51:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 03:51:56 +0000
Message-ID: <fb5fffd0-0cd8-893b-67cd-f419f591736c@fb.com>
Date:   Sun, 19 Dec 2021 19:51:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: add a selftest with __user
 tag
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
References: <20211209173537.1525283-1-yhs@fb.com>
 <20211209173559.1529291-1-yhs@fb.com>
 <20211220015110.3rqxk5qwub3pa2gh@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211220015110.3rqxk5qwub3pa2gh@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93718144-be03-4f7c-bc51-08d9c36c1128
X-MS-TrafficTypeDiagnostic: SA0PR15MB3966:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB39668E038A68E84B4244BFB1D37B9@SA0PR15MB3966.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipFxL/On/iA5xrSBYclFwsNa1GhkyiddHzZ/C4X2VZrxv3KUh1kAHrJI+TTLu6A69fBrpkIyO5z+OYhNQvciSDuYB98IwWNN0RBcxrhnmicS4wfPZG4fTXwlixOuf9nY3EUhxHp7k0Bjdeu/UVd6XL3oyNlkJJQRKTlSjd6JWEajHFJeAzwOPrvgX1dIJK1oe97f1UAihd/jyCtVzj8a+8f9TuKHedvbI7SCNviETkfJupnSPao7ML/uf5LgipG6vhjy1VHNRIrWyYw0u/Y2tGoYXhCbGlP5MisnkdiyU0lOa3AtGmLeCWMLQXya3Ru2F1v2dFoqLWvc6mIMHrrXaDsxSuoi1CouKcM/Pi65j9ESiGcqurdWxehAPt6kjRMuMVtwXiuzaRcnIw5LovBb2SISyEnAI6bBFG+sifEB8Vgfx2FLgvfCqZ68p0IuXnB1EhOIT6yEiPq5hGNxMa9FgQau43tbUZ6QUASBzJGKYDPVynP7WsINV5w41rTKOPcyrzXNQE5KXg967dBvM7kgFtJgc56CuapgCNNEV/YMEVTJ/VzWv8iO4AWgamJgKnZwafsHQMhzB0sTQu+3XQYvDY1GwH+L1hHpSHOclVT8vOoT4E7ttdaNrjXNZFrf3Wenu3t89GxW8X+q5MTkAcHVlKhbwxu9LTN0NowreDWNAeaWFmxdv6cF12ASg4XcYauOeHbRCkMebqpVXG65W/wVWdOlRLBfTjdqHH5UVTlZmxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(31686004)(86362001)(6666004)(6486002)(8676002)(54906003)(508600001)(8936002)(316002)(5660300002)(53546011)(6506007)(2616005)(186003)(36756003)(83380400001)(52116002)(6512007)(4326008)(6916009)(66556008)(66946007)(66476007)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3phT2l2NTZaajlOYXE2Ty95aTNMSEozYUZwb1RQRW5uU29SN0wxRUcxWDE3?=
 =?utf-8?B?Y3YwUzVpcjFRbHkwY1ozUTFZVkJWZHdSdm9hSjdXc0F6R0Ivd292KzczZlp6?=
 =?utf-8?B?V2x0dW5MK1l4WHgzdk1YRU5JSitTT2NXM0ZLeXZEMjZGWGkrcldxU0E4Qk42?=
 =?utf-8?B?cHVtT3crNXlOMGkwWmRaYWFiS2tZTVBOeGJkK3RLYmlwdHJUOU4zNzNCcTJF?=
 =?utf-8?B?dURmMVhiMTRNcllqSnl2UHVHVVNNMkNxTUppVitMelpOUU1hbkh4UTB5Q3JS?=
 =?utf-8?B?OWRUN0VWdWZlYUNtby8rWDdpczFBZFpzWVBzaUVJaXR1UmhlaXRFQ0JQUy93?=
 =?utf-8?B?Tk9wdlByUDhIcmdwNzExY1lVSmFaVTE4OEUvSkU5UTNkUGVOWkNVeWxtaStH?=
 =?utf-8?B?VVNuZS91WWhhYU1mTndzVTNLSkhHOUZyS3d3bkNsQmpQVTU5ZVhYdXRUeDZm?=
 =?utf-8?B?TWxvTXZEV1Z1RW5jeEx0OUNYZFB3NHdld1NiTTd4cnd4a0tPVTJMbzRRbVFM?=
 =?utf-8?B?TTFXeUJlbnF3dGtCTWF0WnJHNkx1ZmtoOXd2V2NRdkxGLzhBcDUwK29lZjdD?=
 =?utf-8?B?Qzg2K1U1ZURWQ2pURXRaMmFXbVNXMHF6Ky9YRDRuZWExWGVGVW1FQ0JFcGRQ?=
 =?utf-8?B?UjVaWHhmclhGa1lCcXlnNzQ3VmR2NDkxak1LUGFnZ2dzV1A1RDdUNjJDdGY4?=
 =?utf-8?B?aUtqOVoxUFJwNW9LU2tMeUhGUGxnZ2M4SmUxZjFrY3hoSTdZdGMrM0Z0Nkpi?=
 =?utf-8?B?R0R6eS8vcFhlTXo1SmlLNEdDdUkzaSttV0xCM3lTdXlvaDBCQ2pwZ0ROMU9G?=
 =?utf-8?B?Q0ZqUU5FRktjaGlsb0ZzcUxxZlYrcDVDY3BtTGtyMlllaVY1NnA4a1doa0Ir?=
 =?utf-8?B?MFZ5djhqVVl3VlNVZ2FzcDUxUDZpZzBpd2FSSmpqNjRaTWpWK0JoS3RSZWhn?=
 =?utf-8?B?SU12dk12dDMwamR0RWdhcnRoZ0g4MkMzNGFaTGU4N0tWdC9mVmNPV2M5TDZL?=
 =?utf-8?B?ZzFYeHpSd3ozeTlNR2VmTk4wMldSOStFdzhkeUFHM2xIeDQrWFptazJ6S1VS?=
 =?utf-8?B?cVJ3bmNpZzkyRjZPOHc1NnNNOXd2TmswYXVSeDZ4NWRiSlZ6R0FGM3VkRXZ6?=
 =?utf-8?B?bDZ6M0dtVWkzUlBIU1BCL2FoK1dPODc0dnlENnk2TmYwNkhoRGtNV0VKWDRj?=
 =?utf-8?B?OUxMd2lRd28xOVpjVXNMWjI3WStlNVNjV09ycUV6VEpHdjE1SjBaRVJsVE8x?=
 =?utf-8?B?QnBKYjJ4UGFlTlJFMEtIa3o4QW5UUW1qQkZwMmlFLzZ5TXNjRU9wbnNSZmNz?=
 =?utf-8?B?dmYrQXBwUGVrUlA5SHlXL0kyQUViWVBWWHV5dzFKTVFVY3FBSm4xZTl1WE1w?=
 =?utf-8?B?QlQwb3lnOWxpdkVveUs3cmdzTGxuQ0UrWVlaSTFqV2FGVWs4K3I5YWVxN1M1?=
 =?utf-8?B?WlNUUTdKNFRxNlVNb3JmMHpKTU1tT0EyQVhZbVk3Wnd4VFloaEVDUXpFbGxH?=
 =?utf-8?B?bTJSdE5kektDNEV4YmcyTDBRY2l1TjBUMFViWWh3RU4zR2dUOUpxWjBCYjZw?=
 =?utf-8?B?aUg5SlFyQ0s3OTU4WEk0ZytxWUFLVFd4SVVNY0VOMkVxR3AwWHdQWXpQYVlW?=
 =?utf-8?B?RHhRQTZxZFZQa3F2TVI0OVVZRG5EQkxQTkdlTmRYNFB5VGxadlRTeDlwdGtm?=
 =?utf-8?B?bU11WGwxK0Yvc2RRR21OdzlhdXN5VjRZdUJsR0FsSW15VTYyUFUwWVIwQ0lL?=
 =?utf-8?B?QS91c0J3MExiZDM5ejlZeldsQ0FBT2czYytpTU91eC8yNnpYQ2I3NVVQYU1k?=
 =?utf-8?B?MUw4VlJPbVRZbjRQdE9naWRGSmJNMnhMLy9sS2xOcU9aSloyZ2s5SWxQRFRR?=
 =?utf-8?B?bE1DUTJvc0NsUzRZQ3ErK2RNNk9ZeFBOYm1NWERpdXI5MVlzS3owMHVoYVNT?=
 =?utf-8?B?MFgyKzgxdEtTMG5ncFBjYWhGNXVnZGFjdXVHQ1UrWk9tZUk4UkFmMENRNFdG?=
 =?utf-8?B?eHc4eVd1dW5WRWt6RHFhbFhnNGx0bURsM09HV3NKNE5yRXVoLzhJbTJkK2VM?=
 =?utf-8?B?d0JsOGFtSmp6cDIvcE1sVFNoWkZ3RHlWcjZ2ZDIrczBic0ZReTB1ZVFtZk5W?=
 =?utf-8?Q?oPB9LFg27mx+/PzU83gEYkMMz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93718144-be03-4f7c-bc51-08d9c36c1128
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 03:51:56.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLJ8NJRM5G86NLvnJu7PahpO08KgQL0Ns1gJkqo01M2AMl1nWOelnv4nGRZwVFuA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3966
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: KlT873DbzeVUy21aZUKgCRdNqF1zhKyu
X-Proofpoint-ORIG-GUID: KlT873DbzeVUy21aZUKgCRdNqF1zhKyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_01,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/19/21 5:51 PM, Alexei Starovoitov wrote:
> On Thu, Dec 09, 2021 at 09:35:59AM -0800, Yonghong Song wrote:
>> Added a selftest with two __user usages: a __user pointer-type argument
>> and a __user pointer-type struct member. In both cases,
>> directly accessing the user memory will result verification failure.
> ...
>> diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_user.c b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
>> new file mode 100644
>> index 000000000000..e149854f42dd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2021 Facebook */
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +struct bpf_testmod_btf_type_tag_1 {
>> +	int a;
>> +};
>> +
>> +struct bpf_testmod_btf_type_tag_2 {
>> +	struct bpf_testmod_btf_type_tag_1 *p;
>> +};
>> +
>> +int g;
>> +
>> +SEC("fentry/bpf_testmod_test_btf_type_tag_user_1")
>> +int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
>> +{
>> +	g = arg->a;
>> +	return 0;
>> +}
>> +
>> +SEC("fentry/bpf_testmod_test_btf_type_tag_user_2")
>> +int BPF_PROG(test_user2, struct bpf_testmod_btf_type_tag_2 *arg)
>> +{
>> +	g = arg->p->a;
>> +	return 0;
>> +}
> 
> This is a targeted synthetic test. Great, but can you add one
> that probes real kernel function like:
> getsockname(int fd, struct sockaddr __user *usockaddr
> or
> getpeername(int fd, struct sockaddr __user *usockaddr > and the bpf prog tries to deref usockaddr ?

Ack. Will do.
