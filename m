Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700985B5CC4
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiILOzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiILOze (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 10:55:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB46C14027;
        Mon, 12 Sep 2022 07:55:31 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28C74aVG005128;
        Mon, 12 Sep 2022 07:55:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KNppCKdUeZXtNUhfD3usOUWPepBn9xUX1CLJ4rmX6So=;
 b=c5PgMJwZGjUFacuhMHVlNIAGfXyDAHw4v55jDDK2nAemajl0EXIyP+k/HCGMxbla2UQS
 xmXrZ7gMU/CvG/v3cfJ8Ow2T8pRT7A4WydOdZ/an2bPvBc0jf8WI1NQ7bjzNRKCLEHU3
 h1I9YuvCczviEFy1oXEQBjlUmU7zcOwdecA= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jgp8xtjmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 07:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEW4U1xe8HAW/VZ9jhukvNcrmQ9gQuemls6sBThTCQh+OCP5Vyi+L3s3ErW7141I9YsKJ4l5xhviZy7imhsn2ELiGWMjqIdZmViiyfpw/uvBFiKW7/FV7geUNTHkmptIHBefqF59rlCvVrBqgUNi3r+ud9IU2hYaPZkjWsPwj4pZ/vY/AFWTJ13F9BSR/AY+RyhDwYDbSoV2nLY5W8xZz9YPjxHAqXZB/2TCy5HbaAfR/UDnZtciYBtSZPxprCNR4pTmSV9YMDrzSjvvlwy/I/Uwj+M/qMGYoHaaDO/4Lu5VdJe6JmXy0m+PJZpXQN3VmakialE6pTgcLL7+KTp/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNppCKdUeZXtNUhfD3usOUWPepBn9xUX1CLJ4rmX6So=;
 b=Ra3yfWFO9ZbRBp/PX0O7qjloJj6zdbjT4vb4iMxNSZkMJ71OCWSU4JKiPdJDb5UTSotUTif9TqO6KdF0ZXVKCBq+LPN730vn0OMD47hgWVT1lCkkRjuMCE++Z6oB6oCX8KdUMK5Z4wDuLlRAaGTTjFJCZFF0GOShf94V/49B1FwfgvsCpETdcYJhWxuQxqRln433a0NZBC/yOgVPjfh8ojCRSjHHivXlusqCGRu6KGhUf86+lJ3QsCiRMaPPf1fm6jB/XSMzpzsaI19WX1qod6ph0O6AUKKDl37fGdvIsaZW5giqS5fkwWdauybp/RmBtTTd0vSqveVNN1m6XWm/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1577.namprd15.prod.outlook.com (2603:10b6:3:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 14:55:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:55:11 +0000
Message-ID: <243f7ca6-41e1-7522-a6fc-6a35d8104bb5@fb.com>
Date:   Mon, 12 Sep 2022 15:55:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/1] bpf: Ensure correct locking around vulnerable
 function find_vpid()
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
References: <20220912133855.1218900-1-lee@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220912133855.1218900-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1577:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4bcc00-21d8-4377-ae2c-08da94cecb04
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkvRmqehmhxDpTcNSE5jcY7Hvc5pnOZIYhPKRps7M68+Wa5qt+ZIsblT+t2NF1xGqufokmb2rTDSG56BxMJuevnHyZIiLAwR1tmI3E8y3R1AvNUoX4VbKKB3ThL+l5wpnaZWoynndOlDWgqVJZFAlzlqNsBqxPw6JKzIwi1AblvRO8MwdNmVBxlmGezvUdk4mZW4Uddq4CSrKuS8lce1fyyKlpfRM3C8isxms+kDMyixVKklNxqCvLloQwtb+tMk1OdipyrgsAqA9jcT5lc4U3hfdMAIWh7ZvxZRa5b0IlUjKXZQYm5ejIMjuvpKIdVFq51Un5pO1NmfMjbcZIfrViQXawa4a1WTRGgS3c7h1URaTjgIV5V0Rg6JG4/rFBOUQvQKhVcK2hbMk2CgL5iJbXmcfpsUwXVuhkrx1z6FBvaVLxgOz/v/5yZwESiFpNs6CyA7CrvQ+mAKP6dA6xVR57n9BN4jaFMZlfkQFDXZpcxtgny1ajdkGkX/gmzpT5yclcNS0s4shpUlSvpI5c/GiCUcQDuRQChPokw1XAR5vqp33iOuHAzj92qYRdhLVZsQnN0l/WpjVtHbUQKSoSMb1Xd+MbZAGbnH4HlZhe6wp5qM7heV133TlTNqfwa6QvlVZLJqA5HHWkbNc9F2URNT3a/30mcb8WxjSVAPjOjP/WMmPd6IlNn3McPvMS/iDEfqx/pOrSTLxRjltlhvYWl+cFxdbI0EyDbGvLIwfAvUuFicIqHcHiOzRtIJLvk93fJx+xkHszolzuNVnstVSUa0h5eJdP5jBreXQxps0DgEjXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(31696002)(38100700002)(4326008)(41300700001)(66946007)(8936002)(6666004)(5660300002)(66556008)(66476007)(8676002)(478600001)(316002)(7416002)(6916009)(54906003)(186003)(2616005)(6486002)(83380400001)(2906002)(6506007)(6512007)(36756003)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjBJMXBmZXhHRGlkaTBTTjVCa1FCWjJGQkpiOGJlSkxZMTF3eGJ4TW8rZnpz?=
 =?utf-8?B?RGV5QTlzVi91bjdPanM5eGxseDR2cHQzVlFtMnFLSVJHaEtsN08vR0tGVkZF?=
 =?utf-8?B?STZkZSsvSUY3Qk1sWTJsRDkvd0NlU2poTVFpLzVxWkx4c3U3bXgzL3NiTWlu?=
 =?utf-8?B?RmRiZDF1dDRXRlIzUkE3NDlNK2xUN0dpam5wMXhHOUdKb1YycGpCMmVWbWdw?=
 =?utf-8?B?TnI1NFA3VVpNUFJwa0NuZHEzdG94UWtlc3gyQlFGUnpLL1dIakxBRThWYVRE?=
 =?utf-8?B?MkFSRUNrVFdjQ2RQNDcwMVRGb1ZNUHBWWEJyMVJhZlJ5ejJnT1NGRGJjdXVO?=
 =?utf-8?B?c0JMQmR4ZTZXN3c0Q1lpMVFEeG9aVENod24va0NoNjl2L0RxSkhDTUc0QThq?=
 =?utf-8?B?MXNuaWpHOENHOWZLNzJWQkJhMEF6M1VMbjdaVnJnOVEwTEp3QS9tVDBwYmZD?=
 =?utf-8?B?SDg2R00ySDV6ank1ekY3TDU2aU84eXlhS2dyMWNnbWNDK2pVaGg3Njd5dWZC?=
 =?utf-8?B?M1NiU2pNRU14T1hSbUNXT1I2c1AwTVNURXdRQlNLZXM1eDZwbGIxNExNWERa?=
 =?utf-8?B?bkR3bXhmK2t1dkZ6UEc0NVE4NDRxUFp4ejdnOUJOZ2JLVnZ0dStYM2ZyU3Uw?=
 =?utf-8?B?bXY3U1diTkFmY2dLNGRheERQKzY4a0JaYm5vM2N4T2ttTVB3ODJMQ0Ixd0hI?=
 =?utf-8?B?WlZVdmhxUEIrK2pKTVo1Rnh2Y0ErZnZuTktabnFzM3dsV1hDeVZ4dFkzYTY1?=
 =?utf-8?B?aWFuZ0d2MDNFS3k3Yldac0E0Z1ZidGZvTXhtRVUyNElVWmhOT09VS3RPOU4r?=
 =?utf-8?B?ZWFKcFdMc0swMUVLM2NlWXIwR0Evbi9XOU5qVW1jN2hFbEFpSFY0SzJOV01Q?=
 =?utf-8?B?ZjgxR1gzcy8vbXcreHpBcUlNQzhVQTNCdGZYemZOSm9YTDNGanN3N1pIZTJU?=
 =?utf-8?B?czYrSFVPVlJkbWhWZExFSllrWnlNTTJFWDJCdGw3MHkyVHgxZFJHVHJjUU5H?=
 =?utf-8?B?WlZzSm15c2MzL0UvaUZ3WXdzL2JneFFyS2NwM0RCRWtOUjdzOFZQOGJxY0xm?=
 =?utf-8?B?djQyS1IzczBOd1grYW5NZzBNZHdsSXIwZG5hd29LVG12OGd4YnE4T2g4TkVP?=
 =?utf-8?B?ZUU5QWJUZnQ5ZmxzbXQ5cXZBZ3h0WXdIbURrR1QvMVJubW1XeERlL1E5MzNw?=
 =?utf-8?B?cUk2eGtMaUNCTmtYbkVleG1PQktIUTQwcDRmVWhWeG14b21kczIvSHhkbGJX?=
 =?utf-8?B?QzBPOEZkMVdMSW02UzdrM2E5dHVrKytBK1dEQ21sU0dBLzZzKzB4N0xKaFpq?=
 =?utf-8?B?b1UvVlMzNjhjT2trR3hyYWlYb0NGRjN1VldaT0xtSmt1QytwSmd0TWU5cTYy?=
 =?utf-8?B?bEtoTEY2V0RGYTdwME1hdW1CT2t4OHFhQVl2OXgycmRabkZyMnlaZ3M2NTZl?=
 =?utf-8?B?V0hLdEdSdng2ZEExNFN0MmpiY0lBVkFHb0VKNWo2bWpuLzIrQjJ0Wktnc2VE?=
 =?utf-8?B?N2pGclgwcnFhNm5wbGFOWHdzbEtqRmFnR01JcUZ4NzQ1OFhHTUJkb2RkbnhH?=
 =?utf-8?B?S3BLaDQ1a0M4RkFIVXRVV0pKczlCV1QxQVYrVFFVQkFwNUo5UWxRL21UR1NQ?=
 =?utf-8?B?a200dUJXMUNORGdZZUg1dkdEVHdZcjN5bHdwRFVqNnBGZ1BVNk9CZVg0aVNv?=
 =?utf-8?B?NTZaenZWRGFiazF6MldxK2dCb21tQW1BK0hkRElVd01UUVF1K2FrNU45Q05N?=
 =?utf-8?B?U3NwMHJIaU51OUJ3RzJzbkZaVnE1Q1o2SHk2cExYS1VlMEprbTE2RCtuV0FX?=
 =?utf-8?B?MnlaZXRGY3pIWHVxL0c1Rko3clRKVldWcXZndzE0bktPZC9zMThuKytzaFBw?=
 =?utf-8?B?NTlKczNETDlJMXN1amxQUzRENlQzWGRvU2dSNjU4OWZRSi9vVW9uT0VYR0xP?=
 =?utf-8?B?SVMwM1hmZnpkbFVkWkxWMlhSQVhlbjBLK2FyaVpnbGNPYndIMWVWdG51c093?=
 =?utf-8?B?QUdYVWRFN21Vek10VzRCNlNEODZiRXJCU1RvNjA0UGxVa0VyNkhqNUJQcjJB?=
 =?utf-8?B?Ty9ZQS95RFhTT3FHVzdDMjNsUWlMd2x0MWFxOHl2cHJMVmEzcHRXV0pYakZF?=
 =?utf-8?Q?+thxo4taO7ygEtDe/bAhsJML+?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bcc00-21d8-4377-ae2c-08da94cecb04
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:55:11.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aK1k0eLo3QIkWTbZaf7zoxC8UbKJRev5hNGUhsZAe7SASjZR9LnlSYA50NK5caKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1577
X-Proofpoint-GUID: 5qOGGOGLkYOHqGVP7tFKkjmOAFq3GyNA
X-Proofpoint-ORIG-GUID: 5qOGGOGLkYOHqGVP7tFKkjmOAFq3GyNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_02,2022-06-22_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/12/22 2:38 PM, Lee Jones wrote:
> The documentation for find_vpid() clearly states:
>

No need for the above extra line.

>    "Must be called with the tasklist_lock or rcu_read_lock() held."
> 
> Presently we do neither.

Presently we do neither for find_vpid() instance in bpf_task_fd_query().
Add proper rcu_read_lock/unlock() to fix the issue.

> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: bpf@vger.kernel.org
> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Signed-off-by: Lee Jones <lee@kernel.org>

Ack with above a few suggestions for the commit message.

Acked-by: Yonghong Song <yhs@fb.com>
