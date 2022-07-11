Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FD570CFA
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiGKVsV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGKVsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 17:48:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017365578
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:19 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BLWf02027654
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=kPOZbpQ7pUdiRyIrdhQ4UMiY/IFlfQdXFwCpX9F1RFw=;
 b=IAvl5s1IYVNMMZQZTsYuzoIiUPgUGYiL94HPfcgEcTNHgvsSfLeffjBtZEtfNsyEXACJ
 DjUNKUrlUYSJZI4mLDBm81g8GpsqgH1/75KJm+NTSzZ25Ure/c+0WW0+Vbs7Idqs/Amk
 jHwkHen7piulVcUX5iRKbFmzb5phZsKTFOg= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h76srm60k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrjClCnnueUBfpil2KNJzm+qaQQhnpIGNQs/Wh9HlUd23szm1J3gPg9M7PHgql/txNmLnqhetaz3VHmjfJ2CGwrB9lZELNqJJZ4Zs1yGJvKQFkrFTYMVWsODe0TMjC9CDLc+r3AH39YEoO9bWFhaEjtvI8XbHHfoJaoaToj2rZV1RgU3tIb+rl8INeloPwXR5AaCR+2/E//WlV0JJi3XuBolTgcsvtecUB5ByuOEiieazXcDdnX50awSezGsiCkF/SZYz+9VIReE1BkZKFxefClGF50tc9RGFcG4tTsl+ic+6ici0PxtifDKEeXoJu+NUwZMi4CG70xojAWYigsgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPOZbpQ7pUdiRyIrdhQ4UMiY/IFlfQdXFwCpX9F1RFw=;
 b=idbTzRxZQiPh6zJHe/RuChrACjcfJzTFYR+tY+4Y94Rn6QxdHqTzYnMitO2TPp7yWfGOzGM4kAJSuFVHNHfPGoDKmDuFJjkbb5GEM6uFlLiTtGlkbMFOvusPH91bcu5MWUlAwCFagVXVAlZIRMzWgCcCQrlHZhNLEGIQO1VOtIGC7QvOOO6kEKCn8N0uJnOOtSgHgcCfO9eBA4L3+l+pqwQhxjkLDJg1CeZivHNZYCWNntO0evg/RaykZcJCp9VcXX4fwaQSPAIvVMnRzCHzteHFtg8LBzIouc9OVi4tRhRET+y+TekskGExgA5EetYkFzWgi6U12OYDUDXdW5fDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB3375.namprd15.prod.outlook.com (2603:10b6:208:39::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 21:48:15 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e%9]) with mapi id 15.20.5395.020; Mon, 11 Jul 2022
 21:48:15 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Topic: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Index: AQHYlW/snznW93TcsEKe6oR5OxPAGA==
Date:   Mon, 11 Jul 2022 21:48:15 +0000
Message-ID: <cover.1657576063.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e69568c-59ea-4722-1744-08da63870f1a
x-ms-traffictypediagnostic: MN2PR15MB3375:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kz2HTrekfibfPP2Lufr6DSaxU3zdNYgWExkn5NtPlB4dr01RehUqnZKy4pCUK1el3lxrHreYq8e0rNBb/wIPDHnWE0M8vFkcEdLIb3hvLWITsdPRuxXvdyS239frSe1h8w+PyADWmVMJur/wi4Z7T6LSLkB8VyVQOj4MyeG89uOkhzAbPzvc1M7mFkqe9X/3NnDfZ/ANRU6jQW4Vf2qHbWybyrpQU8NM5A44Ai9GKNhdbMWrKSpsEzic6Tnwz0iDYX0QKEa3ht6yn9y7fllaWrwsGcPSfMbKrp2lZp1tN667cOfA8SUw0mXhayflQmnZ/bhbT7GOQHLc9fwVzgmkxjfjLSSztF0ZLcNYKtU5ZesGgYSQFxpLrvcMNxnjVKiBjh6+DoXEBmwEBpvkMk2RThS99SfIruOfiv327y957Dc5NGnNgXH8xupM1cum3CKjd7oRgL2rWbhYFdWWVYwIrbJJwZV8BWw1p/ST8P/QNAHokGm4RPkNhF0PBwjNcaEzn7KLvUlAZ2k/d/Cm3RJ+D4HZp4YkYBHvacvGlKo44RZ9XQHvwxZm2aUGMuhdSj3J5CFMXRgTi4IZN5XaaN2VG9oxRuCAqjvkHbBg7WxFJOrR3YYnPZ/t0P+KCUuLJJ8uZOMwh4EGwXbSoPtAa7cWL5x1c9PpmTYJYjyJvIc5SHrlgy51I3AJYqVH1/KtKod33w+G0Q8uI+kf5gHT4v9ws+BwXAa+hukO/b6RROM8md60sHgC0RrlxxdKzkdZAadhSd9fk0Qpd5+YFVv6EacEoRUGOg0NTnBLc+0OX3ZxruYv4J0IE//6+Y8Dv/yBvZeL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(38100700002)(2616005)(38070700005)(122000001)(186003)(66476007)(83380400001)(8676002)(66446008)(76116006)(5660300002)(8936002)(66556008)(66946007)(64756008)(2906002)(41300700001)(6512007)(71200400001)(478600001)(110136005)(91956017)(316002)(6506007)(6486002)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PB7q4wBsnOpk6N0rT2d0esvQV09zkc41J7D5vf4GgTVFew+jxGRQTPhMui?=
 =?iso-8859-1?Q?y2tbViqItKAdvUyimYLomNYapaqrGg1N7m1XZNjM1EabGh9Q949cUpxGix?=
 =?iso-8859-1?Q?LuG3G45aFL1VmlGCZTV7qvDedKib/J66Tf/hK5VIcjgw8mSJQtFK3/g9t5?=
 =?iso-8859-1?Q?2MOGkUF0wvABRzdMif5tqMlkoAKn0582AssP8jvJ2XnqXsLVN7kI5ispPU?=
 =?iso-8859-1?Q?Q+EdFZAj3RFLC/I7P+KjYN/j5jgTEkjtS83Gn0UvSyht2Tmu3/FBfB9agq?=
 =?iso-8859-1?Q?K7PsRop+hwidseDwH/4/oW+1Rq9o3yj7DzGEs0Fl1dEenrixM2qbXFhMri?=
 =?iso-8859-1?Q?bZeFT5kDHRmCBwVos5N4T67zyYDUKMdKWTmqXb6VfByTpHJFN9Uds2UAvA?=
 =?iso-8859-1?Q?v4srLWM1t6JvVDHuTuy/wOFbuACE7Ya2KQKHQC2zrhDIpOpJRb92dnQGbF?=
 =?iso-8859-1?Q?5A4YDckI0xFC4FwEa4QE1Ku6MdW9Ap7LCfXyG1sNfjPvwYgt4dFGtRxC1C?=
 =?iso-8859-1?Q?KNj+X4fcn/eGbFk/oOe2Ywd7NV0M3ICxW/AQLBvuLyv3iR76yDq4mgOwh+?=
 =?iso-8859-1?Q?rO8qwK2BeUwM5lPy4w7OGAe+A1slOpA0DCWmQUfcAOV334AP58CjcF5aDh?=
 =?iso-8859-1?Q?o6ssz4dWsVn4wk5mrdSZuuGquQp+XWUzwCwMzSzbDnNEnOw3ygWw2V7Rpt?=
 =?iso-8859-1?Q?cfjSqXzffdMDI8XAQfTT2677iJyCSn67auutZLp24QSd91lag9qzdB8a5u?=
 =?iso-8859-1?Q?1APZpKfaYL1VYoJUNkiT/UpkdopoOhHtZ3oUxttWRjvzFEbeKWR1YxsMoa?=
 =?iso-8859-1?Q?AUXtfE4/CTKURroUu/kE/2gasXuhqWn2A0mH3/GVU11OcczCd65/v9Nj+s?=
 =?iso-8859-1?Q?VYNppQWRRi/iC2JbgEJ7++YLpL3eWYdebrj4Ia0rubd22AJKlzQaithudG?=
 =?iso-8859-1?Q?o+fv+agOnYWmk0k8XEIq8ceACIcTVawqCTRL/gPbBQ+X4E4ZmdENmLTUbh?=
 =?iso-8859-1?Q?HQBMWpTddBGuLBe3V01rx2yTVWemXcFFzFLSQ3Uz6ZvRB0fB9vDDAZDtUj?=
 =?iso-8859-1?Q?FeArYdMVS8zo45XgjDYgI8g6bzneuI8szoC1QLFCyPY4TO8WQPga4REhZx?=
 =?iso-8859-1?Q?DtKaaqc9KfEwGR2xvum1mhokAqabp1/yD+RMlCagOBHYygpk+Xe04sf5uv?=
 =?iso-8859-1?Q?XAqvB4nYGbAdE8W9zSUNAr/Pilx1TctE0/KQ7gTcQROuKm0tv2rOKcVhqB?=
 =?iso-8859-1?Q?+mYD8/yTYhuupASvLPCW5wACsVO0k3i0QnpXOpq6+m/oFdqiNLelAmbZP4?=
 =?iso-8859-1?Q?zokWCY9ZLEuSKCUDKYij+qh0ddYtzIdpHzWq3mfjTejeavb7rJ9/2JZnG5?=
 =?iso-8859-1?Q?KBx9RjhG5H8hkfwDG+IAwbRpHUEvRC60MeHJ32dhUNzjg/N7VJDM7LWMcW?=
 =?iso-8859-1?Q?c83Axeipxx0e7Daa339JEHwhPxRFzuxw3omriCB6IC0RnYwn2ZWjCQVUkx?=
 =?iso-8859-1?Q?AEOMebfsgr3lI7OtngGs4KJJ32FpzSa0sGbaLDoigZeZhjfLhUwRvEYlSK?=
 =?iso-8859-1?Q?C8gz5npqo60TQyNXy1qZrBytIjAL45B2EAY8APjT0wlIITf85UDWpepKQR?=
 =?iso-8859-1?Q?vugyCPOnrKBUbqdHckFlj+NoMl+gf4XTF5tABYA11vKQC0EesAOFiCCA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e69568c-59ea-4722-1744-08da63870f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 21:48:15.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzqQm+yOSCWcep8aT5IoSY/Z0wYvxkvxEQZaG6Zznwj87/7wwg1dB2lemcoJiymN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3375
X-Proofpoint-ORIG-GUID: wcj4QEoBsNNWbq3t9d3CODFA25ljSBY4
X-Proofpoint-GUID: wcj4QEoBsNNWbq3t9d3CODFA25ljSBY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_25,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF developers are sometimes faced with surprising limitations of the execu=
tion context
their code runs in. NMI is particularly problematic though userspace data a=
ccess as a whole
has come up as well (e.g. build id not being available).

This series adds bpf_delayed_work_submit which takes a callback function an=
d a context pointer
and is able to execute the callback from (initially) a hardirq context.

This is an RFC to answer a few questions on direction:

1. Naming is intentionally bad and something I'd like to bikeshed a bit.
"bpf_(defer|submit)_work" was my first instinct but that has workqueue conn=
otations in the kernel.

2. The callback arguments need to be in a map. We can currently express hel=
per arguments taking a
pointer to a map value but not a pointer to _within_ a map value. Should we=
 add a new argument
type or should we just pass the map value pointer to the callback?

3. A lot of the map handling code is verbatim from bpf_timer. This feels ic=
ky but I'm not sure if it
justifies a refactor quite yet. Opinions welcome.

4. This functionality is implemented as a single helper call (no matching b=
pf_delayed_work_init). In practice,
this means that we can't implement the map->usercnt check that bpf_timer_st=
art performs to ensure the
map is referenced from userspace. However, given that a) we wait for pendin=
g work before releasing the
bpf_prog, b) the map will be in the bpf_prog's used_maps, and c) the map fr=
ee path does not need to release
any external resources, and d) the bpf_delayed_work items bump the prog ref=
cnt, I think we can keep this mechanism
a single call.

I'd like to get this right from the start, so do let me know if I'm missing=
 potential execution
contexts that we can't really wait to drain from the bpf_prog free path.

5. This mechanism generalizes to other contexts (e.g., sleepable context on=
 the way back to userspace
a-la set_thread_flag(TIF_UPROBE)), by means of adding the bpf_delayed_work =
items to other llist_heads.
E.g., we can keep the llist_heads in task_local_storage or in per-cpu struc=
tures. I can't think of
anything that requires a more complicated approach (or reserved space in th=
e structs) but do let me
know if I'm wrong.

6. Lastly, the llist approach was dictated by the NMI constraints. RCU list=
s are out because they need
to synchronize_rcu when splicing from one head to another.

Thanks,
Delyan

Delyan Kratunov (3):
  bpf: allow maps to hold bpf_delayed_work fields
  bpf: add delayed_work mechanism
  selftests: delayed_work tests

 include/linux/bpf.h                           |  22 ++-
 include/linux/btf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  36 +++++
 kernel/bpf/btf.c                              |  21 +++
 kernel/bpf/core.c                             |   8 ++
 kernel/bpf/helpers.c                          |  92 ++++++++++++
 kernel/bpf/syscall.c                          |  24 +++-
 kernel/bpf/verifier.c                         | 132 +++++++++++++++++-
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |  35 +++++
 .../selftests/bpf/prog_tests/delayed_work.c   |  29 ++++
 .../selftests/bpf/progs/delayed_irqwork.c     |  59 ++++++++
 12 files changed, 457 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/delayed_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/delayed_irqwork.c

--
2.36.1=
