Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB664605E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLGRhr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 12:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLGRhn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 12:37:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A1810FF4
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 09:37:40 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7EoEt6015891;
        Wed, 7 Dec 2022 09:37:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XYyocCjvz2B+RHi3LeUJcXS+/oVyzRFTDPDZreASsdk=;
 b=SV5letoBwqo3Z4dP8CdBRwcat6oNkNj6c9Ore/5zrBvgllxdnoblMdmEppFo77rtpOcA
 KSG523zAhZydpH3BKoXyD6+IsYURJpG1clfAvZ/Kx1ptlU/jsdH31o05128p02xBlrrc
 HgIMcFJlIoCqf+Qh3S8XslsrgQRqOsI0WKzhH0Rb0ixC9W6P1z6NXh/MEdc7ESccwefH
 t5cBn5226e2jYIYOgwH1DcEXyxzTeCk6Dlg4IBUWqmdqe5zXAgZ/RQHzm4RVkSUn6Prk
 j6VejKDgFh2tvkqjmeaccdrx+q18qL20fPHh2cag0G6G7RCPszzHAQKyrWBorfWhm4Vg fQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9x7fcqrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 09:37:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC2huINaNYqMcdzrFuAbmuYVHudRZPBKN5f/U1vdc43jJbMhybuqaESuTW1c1p45uYI9JBQ2f4XHoJEvbi64Vlp9uzG76jS8gYK6fKUCIADKsqbl2uvFU15x1+RQMksligOm1nkxmY51BRNz6bJEDtQpLwYVsxJuxuSJ2gvnlbReEZCcSbtYXSq5L9+h+gSykrTIvAjH7n5Xv2aLjzj2cYJiNCc0KL1K4SuAz+9+lec6V+gPsYomYnjGagc/e0l9gYLkDGTxw+P6VQO5QfkB4uusqRJlsVFJot4O0X00Mpz6e/NvyCQ9KS2deMEaRIjIdvGF1kb6DQTFIsnjFCCQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYyocCjvz2B+RHi3LeUJcXS+/oVyzRFTDPDZreASsdk=;
 b=GtlUjsjgZveH0n5g1O7/QBEzX+iKKWcVXFa9OYzWowoODqFh1ckYOQqzbh4NDl0rkkVwUrEOQAZspB0062cseGXQj2Z57SJP0Tk4eFtW9gQVJTwaVcRZ0PWxMiacQme/yBunRlR9AZBgxFcBKkpJr0AzW6aypN+/SR0GFlT1yKH4/tODEdG2HPGcaJp4C8t7XPGGgLBZDMzIA6cAqRIJTvaBrkp5KmJi4ulCT2WFHbHXcEUdB7vrVq6jfyHKhRweZiRsMg7/EUhTvRDfzYbAbdnZKy7bGqMKoY4xKfSFGzlXvn2OLjipG5TcPILfsSqp+MXQ786bbgDU22NWqL1NGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4492.namprd15.prod.outlook.com (2603:10b6:303:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 17:37:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:37:33 +0000
Message-ID: <4b784da3-2f2d-9041-e7a4-14b05e3cf974@meta.com>
Date:   Wed, 7 Dec 2022 09:37:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] bpf: Add BPF_CGROUP_UNIX_CONNECT attach type
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc:     martin.lau@linux.dev, kernel-team@meta.com
References: <20221206163213.2891348-1-daan.j.demeyer@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221206163213.2891348-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: da48e3df-50d8-4fce-ef93-08dad879b909
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ia9f50rNmCZt56BbS9YviFgVdXcAa0dd3IAjH63zZoU7dVN5B68fK3k+JXujnRSnqWhDIHn3kaoPuRoKXMUn5dCEtxoQV2kFaPBUDXj2kFD9kAxcNKlMnG4sjOAzDqxXVpB67fOIbNdkllwtqvH6ZYsD5/rpi+dtZqRQwH2drZaS97R93ek3Be3bMO5MfEHzTXHnxpu4aUolkizRVmGldvk/FMA/+emggO8Wnk+PbwT+IJHlPkhjceEPU1PQUlg0tDAW4xp7wOM9/oRbHfY/M4hjZNE0p8LTTTChP8gM0F9DvUY28Vr6NfoWaepwCpqTZMktJFZBmvv6aMufFesvjyt6LhqHR+7OTAgMLoaw5X40bOwy12pWtErHZhvQKrVDFDjKbwgZ1pIf4WvGivhJqhR0JUQdXIV7LGIgzFH46zNQeRkcM6FwK06U9CRgRShDMzABT+sOQsoHOYqqyuc9fUHYPeEPXZOYH5zIOx9BaujlS+Jv5zWQeRsB7gah46RXWV7j8JPHfcAOppIiskQT6OCfuyNoabfuxC5dNujuDzGJq+SR0yVh6CD7l3s6ifQ8DJCBxlUIiabE7nIOKXYQWgjrNvYMPFhIls4/m/wn5Xmt4aJioxN/lFvl/9c4X/9ubZxzlP375L1+YOlnNQxjh2MAjgbUXkP9wOqlRcwidMC+jB3jWhHOzMDghfQaexi5BLLhBVpG/wfjcgHm2nVxJrpcLX0goY6Bv7pmPMabzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(36756003)(31696002)(86362001)(6506007)(478600001)(53546011)(6486002)(8676002)(8936002)(5660300002)(41300700001)(4326008)(66476007)(316002)(6512007)(2906002)(66946007)(66556008)(38100700002)(2616005)(107886003)(83380400001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5HSTNlYWRuUXdQTzJqV2JaNUJJMHU1L3V2R2RtQVcxeDJPQnJKTGc0MVZa?=
 =?utf-8?B?clRHbmV4d2lXRjRNWFVqdHNqQTFQMGlRRDg2Uys2bjUzUytVZWNnN1VMTjMy?=
 =?utf-8?B?bFlnRldlTVRucHBkc1hvRzE5eXlkeGZNQU10WGUwcHp1b0Y0VFJBUUl0dml3?=
 =?utf-8?B?a0tZeFJYQytQY0hZWCt6N0c5SUNsRlhKREJyVjljTVZBeVJ5RUtTaTdxQTRQ?=
 =?utf-8?B?TjZRa1BXcFIxZ0RSYkZDKzVwM3VvMzQzdGUvcTYxeGo3MkRFZlp5MkZ5WStQ?=
 =?utf-8?B?SFJNbHR5dVF5ciszOGlTWHV3UHZPOS9OMEVHOUFhc0xBMXBISkJxVGxpVGhV?=
 =?utf-8?B?Z2FSSE9QdjZ2eFV1eVhqUUFNaU1qSjFwTElEQlFCaDZKblpKZE1uekRTRkx3?=
 =?utf-8?B?Q29ZdFF0eDMvelNNd2tCcWhYSmhheC94WnlnV1JvVEtHdDEzaVE4ajQyWG44?=
 =?utf-8?B?RE5oaFB3bXU4SlFwR09TdjFZb3lVZGtQZzdVMGJVa1NIVXBNNExoTDR3ckJr?=
 =?utf-8?B?WTRSWk9reHdHWnFHWTVkaUxTQXRoSk9Gdm5zWXAvUkpTVTByOHV2NVdBZUJO?=
 =?utf-8?B?QjR2ZjNvbU8rREZsOVRzVWNKT3Q0T0NsdTFKeE1hbU4zMjlseG9zaEVZc05Y?=
 =?utf-8?B?QzZmSXhya01HZHJsZmpUTTdGRHNRVDg5ZWM0cVlEc3dnU2NyVFZRcDFyUEln?=
 =?utf-8?B?RnlEUzBLdUxJYXdoYy9HRksxZEVrK1dVcWdsT0JEREsxRnlOWUlpWHE4WE1v?=
 =?utf-8?B?Yy92NFRNbVB2WXZpamZDU0Z3aFUyZkx6bkUwL2FXNDdDc3FCdHJZbFhRSFVr?=
 =?utf-8?B?ZklPbEpDWVcydEczdFkvRjhvT2xFenBScVhacTBOZ3hneTJrR00xemJ1N0lH?=
 =?utf-8?B?MFNsUW1uVnNSVHJYS2w5a0cvRWlDekFUcWI5RS8zZFlaclBGSllOL1Rza2pq?=
 =?utf-8?B?enFYZXVqNjBqWTRwb0x5V2xYRUs5Zngzck9wTUErU3ZUK0hITGIvR1NRTGRQ?=
 =?utf-8?B?SFloYy9iS1RxKzJaSHNWd2thc2lRL3M1UjErM0RLc0hLbkR6R0RIWEtSb1JZ?=
 =?utf-8?B?dElVYkNDYXJ5ZmxWbkN2NXV5N2R6bFhuK2FkSzNXNEo0OEk3aldJNXdlYkQv?=
 =?utf-8?B?NytnUWF0U1RrNUowK3NMb0REUEdFVkJ4NHQxTEFDQWE0TUh2Y01VakkxN2Jn?=
 =?utf-8?B?UTc4cjIwR0RENDEzRDhsUlo0ZTBoaFZQSjVpQU51Tm1HeHV6akw3TVNBY1dR?=
 =?utf-8?B?YzNHVDRUTUdIMVNCMGdnZGxMQTd6bzA1UGFUNlQ2aFJIb0tNVncyd3Y3U0tJ?=
 =?utf-8?B?WUdjcDllNWhkTU5Pem90VTBzd29sbFRvNnNRTnRqMHlOTDltMDRMMHVpVG84?=
 =?utf-8?B?bzFuU1J1U3dEeU5WWG5YWFF2ZFNGcXdjaUtNQjViUnZPakhKWmpQMGpWNWZS?=
 =?utf-8?B?ZTV2eWhwV1V6VzZmVDlFTjE2MThMeE55TUpoY0p3d2UvajFnRDdITWpmdHRI?=
 =?utf-8?B?dUQ5RzZ3WkFaanZrTlZhdHZRRGc4ZmtjbGdMVXdSWm5POUUyT1NPSmRXVGxx?=
 =?utf-8?B?Z0I5U3drVFIwbnJCWERrdG5IMit1Tkd2VWQzRjIvMTA0elM4L1hyNEdwN1FJ?=
 =?utf-8?B?L3I4bEhYc2JHOWdxUlZqZWxQYlJkQzBHeDMxUzg1cWlQVm9MOGVTTzdWbFFv?=
 =?utf-8?B?Ni83bi90UFVoRUprRXh6bGRQc2NDbWpsWVZjbnJTTWcyNFg2V1V2VzVlWXh3?=
 =?utf-8?B?dmRrL3EzeEY3OTgvYk9uNkJlYmJidU9RcXhMY1ZTOFRrdTBQR2hCRFY4cjhY?=
 =?utf-8?B?enNnbS92YldHajNFS0RIUCticVhoWFdaWTFmSzJmUk9qTktwcWJpOWFxYlBz?=
 =?utf-8?B?QjBrbEhOTU5mZXljNDhOQkZDdTFONnZqNWQzOUxNNU5VYkh0YitmYnNkY3p0?=
 =?utf-8?B?eFQzQ1ZWTXVndEt2RnVrNVp0ZU1DL2krMjlKTWxtbGZNOXBBMHVqR0pBSDMw?=
 =?utf-8?B?Nzh4a2RSV0FmZTNYV0dMbmRlVmRMSitaZGNtT3p2eGk1aGlIbjBRSmZNSEFn?=
 =?utf-8?B?RzdiK1diYWZtUE9oOFJFR01NZDNqVE9keGV0VDVKZDh5MDI2d0tvYmJ4R3Zy?=
 =?utf-8?B?V3VEZjA5MDQ4Ty9KbGo0dVJuZ25FdE1MODFMWUxmelBjd1E1eXArcVY3Mm1Q?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da48e3df-50d8-4fce-ef93-08dad879b909
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:37:33.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUtivrtXb6a990ErxhnfAT8GTDlq5guqjetCdsUI+q1f9+qIw/wwGtVZIBD//44g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4492
X-Proofpoint-ORIG-GUID: ZVIQnVL8RVfoI6UII6KXckAawmOo0Co9
X-Proofpoint-GUID: ZVIQnVL8RVfoI6UII6KXckAawmOo0Co9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/6/22 8:32 AM, Daan De Meyer wrote:
> This hook allows intercepting connect() calls on unix sockets. After
> running the hook, we recalculate the sockaddr length as it the hook

as the hook

> might have replaced the sun_path with a longer/shorter one. This is
> safe because all kernelspace sockaddrs are stored in instances of
> sockaddr_storage which is guaranteed to larger than sockaddr_un.
> 
> This hook can be used when users want to multiplex connect()
> calls to a single unix socket to multiple different processes
> behind the scenes by redirecting the connect() calls to process
> specific sockets.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   Documentation/bpf/libbpf/program_types.rst    |  2 +
>   include/linux/bpf-cgroup-defs.h               |  1 +
>   include/linux/bpf-cgroup.h                    | 12 ++-
>   include/uapi/linux/bpf.h                      | 10 ++-
>   kernel/bpf/cgroup.c                           |  5 +-
>   kernel/bpf/syscall.c                          |  3 +
>   net/core/filter.c                             | 28 +++++++
>   net/unix/af_unix.c                            | 37 +++++++++
>   tools/bpf/bpftool/common.c                    |  1 +
>   tools/include/uapi/linux/bpf.h                | 10 ++-
>   tools/lib/bpf/libbpf.c                        |  2 +
>   .../selftests/bpf/prog_tests/section_names.c  |  5 ++
>   .../selftests/bpf/progs/connectun_prog.c      | 27 ++++++
>   tools/testing/selftests/bpf/test_sock_addr.c  | 83 +++++++++++++++++--
>   14 files changed, 206 insertions(+), 20 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c

Please break this into multiple patches for easier review:
patch 1: core change
 >   include/linux/bpf-cgroup-defs.h               |  1 +
 >   include/linux/bpf-cgroup.h                    | 12 ++-
 >   include/uapi/linux/bpf.h                      | 10 ++-
 >   kernel/bpf/cgroup.c                           |  5 +-
 >   kernel/bpf/syscall.c                          |  3 +
 >   net/core/filter.c                             | 28 +++++++
 >   net/unix/af_unix.c
 >   tools/include/uapi/linux/bpf.h                | 10 ++-
patch 2: libbpf change
 >   tools/lib/bpf/libbpf.c                        |  2 +
patch 3: bpftool change
 >   tools/bpf/bpftool/common.c                    |  1 +
patch 4: selftest change:
 >   .../selftests/bpf/prog_tests/section_names.c  |  5 ++
 >   .../selftests/bpf/progs/connectun_prog.c      | 27 ++++++
 >   tools/testing/selftests/bpf/test_sock_addr.c  | 83 +++++++++++++++++--
patch 5: doc change:
 >   Documentation/bpf/libbpf/program_types.rst    |  2 +

> 
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
> index ad4d4d5eecb0..7d0bcd883561 100644
> --- a/Documentation/bpf/libbpf/program_types.rst
> +++ b/Documentation/bpf/libbpf/program_types.rst
> @@ -56,6 +56,8 @@ described in more detail in the footnotes.
>   |                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
>   +                                           +----------------------------------------+----------------------------------+-----------+
>   |                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
> +|                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UNIX_CONNECT``            | ``cgroup/connectun``             |           |
>   +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
>   | ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
>   +                                           +----------------------------------------+----------------------------------+-----------+
[...]
> @@ -6353,6 +6354,7 @@ struct bpf_sock_addr {
>   	__u32 user_ip6[4];	/* Allows 1,2,4,8-byte read and 4,8-byte write.
>   				 * Stored in network byte order.
>   				 */
> +	char user_path[108];    /* Allows 1 byte read and write. */
>   	__u32 user_port;	/* Allows 1,2,4-byte read and 4-byte write.
>   				 * Stored in network byte order
>   				 */

Please put the new field at the end of struct. Otherwise, we have
uapi compatibility issue.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index bf2fdb33fb31..f1d20f69b260 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1454,7 +1454,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>    * @flags: Pointer to u32 which contains higher bits of BPF program
>    *         return value (OR'ed together).
>    *
> - * socket is expected to be of type INET or INET6.
> + * socket is expected to be of type INET, INET6 or UNIX.
>    *
>    * This function will return %-EPERM if an attached program is found and
>    * returned value != 1 during execution. In all other cases, 0 is returned.
> @@ -1476,7 +1476,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   	/* Check socket family since not all sockets represent network
>   	 * endpoint (e.g. AF_UNIX).
>   	 */
> -	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
> +	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
> +		sk->sk_family != AF_UNIX)
>   		return 0;
>   
>   	if (!ctx.uaddr) {
[...]
> diff --git a/tools/testing/selftests/bpf/progs/connectun_prog.c b/tools/testing/selftests/bpf/progs/connectun_prog.c
> new file mode 100644
> index 000000000000..91097bd8df3c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/connectun_prog.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Facebook

/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */

> +
> +#include <string.h>
> +
> +#include <linux/stddef.h>
> +#include <linux/bpf.h>
> +#include <linux/if.h>
> +#include <errno.h>
> +
> +#include <bpf/bpf_helpers.h>
> +
> +#define DST_REWRITE_PATH	"/tmp/bpf_cgroup_unix_test_rewrite"
> +
> +SEC("cgroup/connectun")
> +int connect_un_prog(struct bpf_sock_addr *ctx)
> +{
> +	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
> +		return 0;
> +
> +	/* Rewrite destination. */
> +	memcpy(ctx->user_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH));
> +
> +	return 1;
> +}
> +
[...]
