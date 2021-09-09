Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D69405F17
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhIIVyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 17:54:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10654 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhIIVyX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 17:54:23 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189LnfBv012255;
        Thu, 9 Sep 2021 14:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=YryklTTL9aHLt/CpMJ5WOe48PusaQuMnMBT/OTw8zKk=;
 b=Tnno21PtwtCQhIbhjSBL5xWnl9SDFLyxI2jVsJC8/g/xh91lXIrnotZn3opymZ68yb7Q
 ufjZ1UNzsZ/rz4XuPGryg/oYYRXI4r/VmHACza2lEucbbhGMazd/BOWtTnHvKOfXwxB6
 qVyVKGpoTnSRno1YYJWUJPXNDK/54KmHsM8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytff81kp-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Sep 2021 14:53:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 9 Sep 2021 14:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFSTMIODoMh078j51XzmU30siK3egd6PNwCVHtg9o5sozOcp1OVP4dZgxj5I054Gvtq7b/ZKUiZfVofYF3HK/eS3kU8svvJaBHnvz7iP0dQyJRt7IRcPfNh4Ejr8ib2SfFOIFt3H8TdWFQw6qLpP3aR6iSUSoTCaTDTN59wvv5LjNeWcFd2i6RL3t11M9Fa/SNrsofcF8oWFdBIvQiiu99qYAPD7SryMxyWvnUCMufagJyStufeGCJETTPH0+V6JNB7I6i5dNEEiz4Ki2JKC4ahRIIyA/QFxFu6K5p6hv3Qj/CqjSQD+ebqNf3xloSeMjMsT62p4D+/4t76DuEEkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YryklTTL9aHLt/CpMJ5WOe48PusaQuMnMBT/OTw8zKk=;
 b=HwdOivyyeFEOJL9rUaYoSXAfs6U2+0H6AB42Nff49psc1bqaIAbadP3W1UrpEIYgEBSZnyHfkQiS0jr+5d88mgzbIwyUIAWYUG0IvKUqt8hrQxkHlH7W8+2EqIsbBQcRe3ZbIhN12fvnlGCo3oNKJlgo8l2sJqxTumhkt4wovgwuolHLRucHPDWaIeiWlO07TYk5dVXiC1F9O7BGrzwzEuSLs7RVKPilgLDTSRFPHVLP7VAl0qzrAGwzmNAydehOTYN8S79gt1/Uq201nC+OcHwfi01OK+aqlhwHOKwJtY3sWllZZ7LMY5fwGPj6ZiKUKEkr2caSoOCF3SghHVbJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 21:53:09 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 21:53:09 +0000
From:   Song Liu <songliubraving@fb.com>
To:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Peter Ziljstra" <peterz@infradead.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Thread-Topic: [PATCH v6 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Thread-Index: AQHXpCbirPiXWtbxT0SKMqbyy1st0quZBdMAgAM8BQA=
Date:   Thu, 9 Sep 2021 21:53:09 +0000
Message-ID: <30C533EB-171C-4A7F-BDC6-12C191219EE9@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <F638720E-F0A7-468F-8862-907CFB19E4A2@fb.com>
In-Reply-To: <F638720E-F0A7-468F-8862-907CFB19E4A2@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9311ee6-52a8-4772-9aac-08d973dc368e
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB51120545FE40E799C60F0DD3B3D59@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2n30XN9WvZWeWp9JUu6NM/piPRH0w6pZllJijsWOOOqgjVGTieeVqEPUeT0UH+aIanNa1WReaBH33BzJM1QURC57tBdpLiY7QCBpfceIV4kpu9tqfZsCjuy9J667gVhW+wH6coKI2o9yrQnIkEy9NI2irfOPXWTRBHUZbFletIVXqQOcotWz1jqERscaHgDC6Lt17qadra85Sa7HMdA4i3PN1bMrLATW/9btL9ZI2s4xr6U+KfimM3jRmO8xLTcgoyo8LpOx/6FzrsxZozdPJ3JuJvnjnus/fzxtFSqIQlKb8AmY7KrTgXIzPdkE2pFORtYi9viRxiQlIqNUzP3wALrs7zT33zHkjOMgKEN4S2Sd+ERDC0qj/d1/e+EoDxIIvQAMIvSzsor2/d0poOaqjo9eo2SH/07HOl84ZC1c6j0hQIAp14mNI1gdERnslb3lVMc+sSgFaMtSDoYTrpnFHIiomf6q6IowfeFpJbBSVBvWC8r6d67xLRRrfEFj50+MwLrudXgRneVQbUP2IIW3R9IVEvYwYUHnmB3x89JgQuw12toZ3o/gnaZoQms74uOMEndrLH5N3WxxfX03WsQp/kpgA/uiNF6Vh4eCm0TJUtgJ5PDvOAD+A1ih+i2nu/n9udhQQc4AKYNB3Lt33tRoxy+p8Ngxd0LeukHHF2RKm0plc8+dSNSM70hmzxtNOAax8L7zU1VhC1zHrHcVzoU0RUguUSspOemqw5IVP6qsGt6a+d5IvA1Ne+2rSCSUXtFrtFA/eoUEXaQzkmZ5oFpM5+ImFCENCek80FsQPGsIOv/0KfMO3hOHapXhGl9QjLy4jVsUVqallku/ujBOb0hThg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(83380400001)(4326008)(2906002)(5660300002)(38100700002)(122000001)(6486002)(54906003)(86362001)(110136005)(6506007)(316002)(66946007)(53546011)(2616005)(8936002)(186003)(33656002)(71200400001)(508600001)(66556008)(66476007)(64756008)(36756003)(66446008)(966005)(76116006)(91956017)(38070700005)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b0RU8zmZRgsj6kuBZDt6Bu12qChr6JPel1/6h5JLXxHQ/8Rv8W6d+JEB4sdi?=
 =?us-ascii?Q?z5CWd7nKiOk8RXbOgShRnMOQ8EnoAgRYtVnt5iI8UAjljZd7S1bJYzgsIc5q?=
 =?us-ascii?Q?2JNDoDLl2lq/5PkGxjPGH9nBlB6x8Tdp/Mup3acEJT/4A9HchbvVKNs2LxMB?=
 =?us-ascii?Q?zD/JIhZRt2/GotD3Y70SrnYRJlwbZXPlUHnQanNwjkDHbz9tpCOc0xwGRj5J?=
 =?us-ascii?Q?7AyW6ZjlWcHNU4VEXvyDfypmRM8RwSM6EU4Nsu+doxE2vHqVRxt+b08At6Y4?=
 =?us-ascii?Q?V2+EN8n4qU7BaxMtMpAEtPJ0xF6a+8/kKVc7g8kTyXzvoctWZcif+kIH6XFU?=
 =?us-ascii?Q?puEdN6T5vYZM4n691cUlepMPM7L2T6aoAhMjrSB4r95nolK1RnfctvP4J8AL?=
 =?us-ascii?Q?I9gJULdPTG2z+gFc669I8W+8nSzydRFmpu2+RZOH0aN8RP0/TQypJ38xpu5P?=
 =?us-ascii?Q?+x6k3o8At+mZaUTV5C9O+ohg9QwARfpRd7utXNo6t3YPrwY6iZo8GHC3loeU?=
 =?us-ascii?Q?NDDcGYgqYQWfHOclexOMT42vsZ+IOD7Rxajb6LwZ8TSip9O4x7BLMG6hFzow?=
 =?us-ascii?Q?dz2ZAlEvzfgI0n52G2kgweMDmjBIANGGCsUIiRSf58g+pWZmSly4ZfkuK2NP?=
 =?us-ascii?Q?Catw9Th2lfaX0rmZHGNhxjLNc0IzJhnY8+gJaD5mgTqFrtjypn89JPCpqaxZ?=
 =?us-ascii?Q?G411+yqwkRvfFPrC0cei5M7z7AUe1hpKevp6NVQsi+LQVVGa1pHc684gDuQd?=
 =?us-ascii?Q?ZVhFCZhq+ntMwfXJqUFF4LN7Mleu31mXnzPfTI61/4HY3f93PeOgECIBqrZB?=
 =?us-ascii?Q?n1Kid6AqetrS2o50+8/NCnrZ2aeUw4z4EyLL1pA1pJo/qpE7IKkc56Im1dnj?=
 =?us-ascii?Q?V/wKJf/dnMHQCFjtYOELhmN/UjSRU2hcv1du7Ug81HuDC4zTx5Ce4dusJoOf?=
 =?us-ascii?Q?6oarjLGKHnrjI4+R1QOohAsppr2+bd8BmRSeuyIGBQWW1VfK2L2XuvEVWbzO?=
 =?us-ascii?Q?rwV8pQFNCfCfAjOIyK4uPrtDrIL1jnAqpALKXiRTdAfxENwABLyAabBC/PfU?=
 =?us-ascii?Q?1RWjiTLUmMfvqIAXhlEVU/L/wHSCjkZY4rqLny2ov9g3Ql9TchUbDZd+f7cv?=
 =?us-ascii?Q?7XMRR3XrmfvYSP5jar39Z3v0mVuyHhdyywTwIkhwiU0EouW71hi12PxeCPaZ?=
 =?us-ascii?Q?zGnfthlX8ShmgYYkQ/qr3y+yG+IRhvQ5JPb95pTiFJDJGAiuvumVIXwRgM02?=
 =?us-ascii?Q?v34oA+F/cykOLzOAkWzXrY5pdV/YlE+z4PIrA7H3tgDy+aB8LsNkFzXMflpQ?=
 =?us-ascii?Q?ilQTs37wk0H1hzZC5bP/2+iKxayg8UCYnoPetMo5SWYpXbB25cOGP9NAv32p?=
 =?us-ascii?Q?sBPAWWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39038576B508774DA02F3DF36EFCDD4E@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9311ee6-52a8-4772-9aac-08d973dc368e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 21:53:09.3825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/1LQu1i+ctAZKjUMOre3OfSJp+KnKBvD6g9s3YXQPeu0Mti3pXrX9wTAT+0JmhDCFsRAcSMW7B+Yx33GHwAlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Zpzx_nIWe2tucre571PF1jnc1JALh0Zj
X-Proofpoint-GUID: Zpzx_nIWe2tucre571PF1jnc1JALh0Zj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_08:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter, 

Do you have further comments/concerns on v6? If not, could you please 
reply with your Reviewed-by or Acked-by?

Thanks,
Song

> On Sep 7, 2021, at 1:29 PM, Song Liu <songliubraving@fb.com> wrote:
> 
> 
> 
>> On Sep 7, 2021, at 1:27 PM, Song Liu <songliubraving@fb.com> wrote:
> 
> Forgot to add changes:
> 
> Changes v5 => v6
> 1. Add local_irq_save/restore to intel_pmu_snapshot_branch_stack. 
>   (Peter)
> 2. Remove buf and size check in bpf_get_branch_snapshot, move flags 
>   check to later fo the function. (Peter, Andrii)
> 3. Revise comments for bpf_get_branch_snapshot in bpf.h (Andrii)
> 
>> 
>> Changes v4 => v5
>> 1. Modify perf_snapshot_branch_stack_t to save some memcpy. (Andrii)
>> 2. Minor fixes in selftests. (Andrii)
>> 
>> Changes v3 => v4:
>> 1. Do not reshuffle intel_pmu_disable_all(). Use some inline to save LBR
>>  entries. (Peter)
>> 2. Move static_call(perf_snapshot_branch_stack) to the helper. (Alexei)
>> 3. Add argument flags to bpf_get_branch_snapshot. (Andrii)
>> 4. Make MAX_BRANCH_SNAPSHOT an enum (Andrii). And rename it as
>>  PERF_MAX_BRANCH_SNAPSHOT
>> 5. Make bpf_get_branch_snapshot similar to bpf_read_branch_records.
>>  (Andrii)
>> 6. Move the test target function to bpf_testmod. Updated kallsyms_find_next
>>  to work properly with modules. (Andrii)
>> 
>> Changes v2 => v3:
>> 1. Fix the use of static_call. (Peter)
>> 2. Limit the use to perfmon version >= 2. (Peter)
>> 3. Modify intel_pmu_snapshot_branch_stack() to use intel_pmu_disable_all
>>  and intel_pmu_enable_all().
>> 
>> Changes v1 => v2:
>> 1. Rename the helper as bpf_get_branch_snapshot;
>> 2. Fix/simplify the use of static_call;
>> 3. Instead of percpu variables, let intel_pmu_snapshot_branch_stack output
>>  branch records to an output argument of type perf_branch_snapshot.
>> 
>> Branch stack can be very useful in understanding software events. For
>> example, when a long function, e.g. sys_perf_event_open, returns an errno,
>> it is not obvious why the function failed. Branch stack could provide very
>> helpful information in this type of scenarios.
>> 
>> This set adds support to read branch stack with a new BPF helper
>> bpf_get_branch_trace(). Currently, this is only supported in Intel systems.
>> It is also possible to support the same feaure for PowerPC.
>> 
>> The hardware that records the branch stace is not stopped automatically on
>> software events. Therefore, it is necessary to stop it in software soon.
>> Otherwise, the hardware buffers/registers will be flushed. One of the key
>> design consideration in this set is to minimize the number of branch record
>> entries between the event triggers and the hardware recorder is stopped.
>> Based on this goal, current design is different from the discussions in
>> original RFC [1]:
>> 1) Static call is used when supported, to save function pointer
>>   dereference;
>> 2) intel_pmu_lbr_disable_all is used instead of perf_pmu_disable(),
>>   because the latter uses about 10 entries before stopping LBR.
>> 
>> With current code, on Intel CPU, LBR is stopped after 10 branch entries
>> after fexit triggers:
>> 
>> ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
>> ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
>> ID: 2 from intel_pmu_snapshot_branch_stack+102 to intel_pmu_lbr_disable_all+0
>> ID: 3 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
>> ID: 4 from bpf_get_branch_snapshot+18 to bpf_get_branch_snapshot+0
>> ID: 5 from __brk_limit+474918983 to bpf_get_branch_snapshot+0
>> ID: 6 from __bpf_prog_enter+34 to __brk_limit+474918971
>> ID: 7 from migrate_disable+60 to __bpf_prog_enter+9
>> ID: 8 from __bpf_prog_enter+4 to migrate_disable+0
>> ID: 9 from bpf_testmod_loop_test+20 to __bpf_prog_enter+0
>> ID: 10 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
>> ID: 11 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
>> ID: 12 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
>> ID: 13 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
>> ...
>> 
>> [1] https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.com/
>> 
>> Song Liu (3):
>> perf: enable branch record for software events
>> bpf: introduce helper bpf_get_branch_snapshot
>> selftests/bpf: add test for bpf_get_branch_snapshot
>> 
>> arch/x86/events/intel/core.c                  |  29 ++++-
>> arch/x86/events/intel/ds.c                    |   8 --
>> arch/x86/events/perf_event.h                  |  10 +-
>> include/linux/perf_event.h                    |  23 ++++
>> include/uapi/linux/bpf.h                      |  22 ++++
>> kernel/bpf/trampoline.c                       |   3 +-
>> kernel/events/core.c                          |   2 +
>> kernel/trace/bpf_trace.c                      |  30 ++++++
>> tools/include/uapi/linux/bpf.h                |  22 ++++
>> .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 +++-
>> .../selftests/bpf/prog_tests/core_reloc.c     |  14 +--
>> .../bpf/prog_tests/get_branch_snapshot.c      | 100 ++++++++++++++++++
>> .../selftests/bpf/prog_tests/module_attach.c  |  39 -------
>> .../selftests/bpf/progs/get_branch_snapshot.c |  40 +++++++
>> tools/testing/selftests/bpf/test_progs.c      |  39 +++++++
>> tools/testing/selftests/bpf/test_progs.h      |   2 +
>> tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
>> tools/testing/selftests/bpf/trace_helpers.h   |   5 +
>> 18 files changed, 378 insertions(+), 66 deletions(-)
>> create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
>> create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
>> 
>> --
>> 2.30.2
> 

