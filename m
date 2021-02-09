Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5424431569F
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 20:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhBITQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 14:16:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233605AbhBITHl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 14:07:41 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 119J3gmb001417;
        Tue, 9 Feb 2021 11:06:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=23A7twDEn7Q+uJAuHDe7fmUJJsC1hxSE9qQDeQNxmUE=;
 b=XFAw5otoIY4GAOnxP/HLl9sagTKkByPgryFGEFzpdknLCq/TkQj0//tl2giZJdT4zNbD
 kw1adyzT+zMnbMZ1hWW6hHcnWuCONAt30rClN/I/69bzUhj9EUyLLukH0jbUySw0Vq5o
 b9TPPNyZgBgNTaZ6eQdWZXAMqEj77w9QugM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36hqntfy5w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 11:06:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 11:06:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzHGGxAFFgDTFWtVgi2XLscQ9w6U8oIqBFRMaS/Y6AGRzbAkC5pnKWxuZMkgzS9o63Vu99HHA2k0dKN+NoE5CxQE+u60XIN0rY76MZFTsDW3AeYdg1B6tUajfrkSHb2w7PMkoGdxABIbkIRliWAFg8GICyPiUbVrZDczYum5DkyvVjH1QZ/Y+qqGP4MNSLyUyeP2Qr4o2Et7pv3nm+Azmk03e5XDvwrSSOz+Vh8seZRS3wnCc7DvjecYcYzmH+jojjEC2tJfhpq8KDPRtblvEHEnQlQlKCKL+ZPAdWLKqlOnB2z9xgm0a0Z4m2fH5kU3MPlZjRfuQ59yzLhHERF8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23A7twDEn7Q+uJAuHDe7fmUJJsC1hxSE9qQDeQNxmUE=;
 b=I4GVkj8MyZLSTNA11RS6geltaMOhPDyIxuKMFAg+xO5HnMklkH7uNu5C6jv4XlQ2U6ty4u6NRo7vC3bKXzj1JknBPR8qKFV1sg9RfMiYboClk/fEzYLalP34gjP91AllshAaqiznNtRE0vVb6JLCeWvs/h/T4k1p9hQ6JJ2YT/T5s0tATd48yLD7lQuyQeKFV25FJi/DCKoLv4Y6KA0dNpp2U/T+5nzuYjC7/yFUkQa54LMFAq7zOWCB91HVyJNH1armMWCZCI7FkXtdNWzbkSvrEqcRH8FUfuyPUqWBmMD6MxKkX2Myghc6jYCVN2iylQ+4nVJBk79PhiUu6+6YqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23A7twDEn7Q+uJAuHDe7fmUJJsC1hxSE9qQDeQNxmUE=;
 b=ez6T7jmqVDsPj3q14C+7qqv+ffJ8hFtSnc8Lhq77c3/SHUDilUr/5Jmje2hgdf5nRRyZ84xMSkmFiAbRC3OogH7FyfOuvEg266Rdu5LMG65WIUgjS9OotK87cq33/CAzE808EF1plDiCwntk8wxlUB8YDkULlEz1NbcL8fn6Ehw=
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN8PR15MB3153.namprd15.prod.outlook.com (2603:10b6:408:a8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 9 Feb
 2021 19:06:15 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Tue, 9 Feb 2021
 19:06:15 +0000
Subject: Re: [PATCH v2 bpf-next 3/7] bpf: Add per-program recursion prevention
 mechanism
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
 <20210206170344.78399-4-alexei.starovoitov@gmail.com>
 <CAEf4Bzb1D9AzOU2Zn2DkZrP+VYOPuJ-7xFcEF1unTr6SutMSWg@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <6757a479-cb35-ac3d-9978-71f1c4daf4a9@fb.com>
Date:   Tue, 9 Feb 2021 11:06:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CAEf4Bzb1D9AzOU2Zn2DkZrP+VYOPuJ-7xFcEF1unTr6SutMSWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c01f]
X-ClientProxiedBy: MW4PR04CA0400.namprd04.prod.outlook.com
 (2603:10b6:303:80::15) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:c01f) by MW4PR04CA0400.namprd04.prod.outlook.com (2603:10b6:303:80::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Tue, 9 Feb 2021 19:06:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6608cd36-444e-440e-800f-08d8cd2dc5cb
X-MS-TrafficTypeDiagnostic: BN8PR15MB3153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR15MB31530CFAD5B75EBE038D2BA2D78E9@BN8PR15MB3153.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esS1qOLQu0g5APOX0teJzTsitcftI2al4lTR2hYNiOGRT+D1WCE7Hjoub66UjrhpmeC0t6YHFM/1c5cJ7gw5I0jt7PeqSXzDtwNE6DXxOVY53pATg6IKEtab4+9zazh6LyLY/d52GH9I8H99aDEvVVFsqSy6ijIiiMG8HzF2GDQUFgGuxZCQgRLZGUv37czyZVYCaIk20T1m0CMcZPC9uq5TmNn1GbbXVxoEuE1hmak1JrfBJ+8yXzLZunxvZTtz8gm1OUca3kZSyLQAWGi1X1f5ULDzyHr6GzEbNoL4FaUI5aYFlwIRmbHh3mJ21syaMK8sUrZWBsrsqD8MMkbTmTnWCgCEyyPyyl6cTvKf2kkXsV/Rgm4U78BzZ1ooF+xRkBKR6ujXRBh4rzUAlwBikqGrhlj66GpwkjlvtltGp7ElY6FMGf5Bu4Klhby76oi++wlY+xwzPS0VH8bfKS5+CrgWPe9mHH7/szUBUFZwLjdcTxvM5spCDmhvVaa7lI+yfeRa29NQbSKsihWYMIgDTW7PU+CDNObAbDbGhvPvNagi4so5Sl1/aiKbgUda+bDOJp0ZTrXDdZye72f9cmAzIUpw7VRVBbuGiGWRg89NrzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39860400002)(366004)(52116002)(53546011)(4326008)(478600001)(86362001)(4744005)(5660300002)(66476007)(16526019)(31696002)(316002)(36756003)(66556008)(83380400001)(2616005)(8936002)(8676002)(6486002)(54906003)(31686004)(66946007)(186003)(2906002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UWN3TTdQTnhsSHQzbUNpanBvWXBQVU14TjJ4RHBXQWUxQ0xvcWdLeEhOZnVw?=
 =?utf-8?B?VElVWDlkdTFLSlZQODFlTitPWC85OVgxMHJIZ0dQVWgvTGpxY0NhYW44cjRo?=
 =?utf-8?B?dXVqeUhBeE1CV0FEN3NsL2dsSWJKSEtFVVc3bG9GZXFJbmFIZVVOQXo1bDJp?=
 =?utf-8?B?QkMwNGJHYVJnZnBkSHJmUnJvaVE1TW1ZM1o0QzZJRDJkUW4rb0xVVXFUc0hj?=
 =?utf-8?B?NlNxSXZsSmwvcG1HSTFnTjZRalV1cWR5TXVFNmNtNU1aVmNyRVpQMVdmamVr?=
 =?utf-8?B?b29rVkMrcnpod0UxU2xXMTRhNDBpT0hGaUJxazlLaE1oazVOb3BRdUxWTWhD?=
 =?utf-8?B?ZFBVTkw3am4xOTh6ZFdEM2Rud21rY3dqdkowZEdzYlN0UDFsM2RWaUlEMTAr?=
 =?utf-8?B?WnlSSlQ3Z3hndEZNaFRUdXZrNi9QSVdOWDA2eWxRQytwSGZyZlNxR0J3ZlhR?=
 =?utf-8?B?RWhNZzJqZmp4MW9hb2Z6djBybUNPajlhS3FNeHdxTWNHTXZ4TG5Rc0pLaHhU?=
 =?utf-8?B?aE0rMGhFQkw0QURLUmc3L3QybjNNem1tMHZDU3FGa3V4OHpKeDRaQnNCRGp0?=
 =?utf-8?B?WDBmUk12SEJ5RGpYNXRtVFF3bjBmZXAzcyt6RmcrMXpHM2tTaEhVLys1Wm9w?=
 =?utf-8?B?bHhZOEZhRUczajJNTnJVS1hqeGdxWXZjTUd2WDZMT1NNeDh1ZWtkWTg1YWJR?=
 =?utf-8?B?VWd0Z29kSnI5aHd4UnUvMUF0VXlsMFFPT1l5bk9tbExlQ0ttUjdBSUQ0V0tw?=
 =?utf-8?B?Q1lieHJ1L0dwdHBpbG0zcnpFNmRzNmtOVDdkQ3FJKzVNVkFCbmlOUHdRZmRO?=
 =?utf-8?B?UjhDeEt2Y1BtRmxYS1RWRUFhNThkeE9KRGxrTlkySjVobWhZOTFESDZyR1Na?=
 =?utf-8?B?UmlvazIwSHZZeWI0ZjljUVZwUG51NFI0VjlHNXVqU1JaVVFyazgyeVRiRWQx?=
 =?utf-8?B?czY3eVNuU3ZiQkx1amt4K2JKN1Q3bUt4NVFleDVBMkpka1ptVXlXUm9Hd0ZP?=
 =?utf-8?B?MUFmSkNrRTBkK1JzZUJ1WGJoQzBaYnVmalQzRUhlczZzMDRDVG1EN1JVcXVF?=
 =?utf-8?B?THppYVBtcVpKYzN6ODNIVXBmeW4ySnNWdnRYTEdTVDVxUzlYTGo5WTNPTTFP?=
 =?utf-8?B?Z2doaTI4dHhzOERRY3pNWnlHZWp0QXZmYTlTNUE2a0FIcllNWUdFelh3QmVK?=
 =?utf-8?B?eWp5eWovamREVjhQb0FoYXNCZ3RvMllSbGI5UDVpWjBzRHRpWUtXUkErdDlk?=
 =?utf-8?B?alp2SmdtUmtTUUMwd3FCSzE0ZFQrQjFjY1Z6RllZZzBOQWVDZEwwb2FIOWli?=
 =?utf-8?B?SCtTMitmc2k1QlBESkhvaUs1bEJEUWhpNmszLzRmaWIzYW1zMHorNys4MUFC?=
 =?utf-8?B?UEZWY2lQVHp0R1VBOU9mTDhmSWdlMjFUVzdWbmVvcFRwZVZpSTQ1RGZ0cDVV?=
 =?utf-8?B?VkczNkJFdkZ3ZVIxSDl1bzZPWll2UHRDZ0pYazRNSC9IblVoM2xtck5RbUUy?=
 =?utf-8?B?R25CMzZYQURCZ294dnh4bGZMYkJCSXdqNEZqTnZRTXVZV1JmQlpoai8vdlo4?=
 =?utf-8?B?ZWk4YTNRazZ4QWUvaHpBUVlMVXprRzNyb2VHWHdNS3dVeXYxM3Zsa1ZybWc0?=
 =?utf-8?B?ZEl2aU81RkwvZHFWVkhUdHpvV3ZPbGxzbDZBZEFsNHVmMzVJZEcyNG5jZUxi?=
 =?utf-8?B?Y2w1dlJzZGhYdSt4NVNubkpZaWtTcFBhdWNTNC9EdzJjdVVnaHZlNk45cnRz?=
 =?utf-8?B?VGZSa3RlRGEzaW1DNkExZ1RXdlNaZUV0bVA1eWdSZmNxK2YrUDhLaStTRWFZ?=
 =?utf-8?B?cDlKcW83SGZzSVQwM3JOUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6608cd36-444e-440e-800f-08d8cd2dc5cb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 19:06:15.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F07Xnm8TJ3ImZl5PjQtYAj9DyLFZLcGeNEzmCv5PjvB3Mx+XlaXXppin4V7EuPvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3153
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_06:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/8/21 12:51 PM, Andrii Nakryiko wrote:
>>                  start = sched_clock();
>> +               if (unlikely(!start))
>> +                       start = NO_START_TIME;
>> +       }
>>          return start;
> 
> 
> Oh, and actually, given you have `start > NO_START_TIME` condition in
> exit function, you don't need this `if (unlikely(!start))` bit at all,
> because you are going to ignore both 0 and 1. So maybe no need for a
> new function, but no need for extra if as well.

This unlikely(!start) is needed for very unlikely case when
sched_clock() returns 0. In such case the prog should still be executed.



