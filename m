Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5F402FC1
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbhIGUap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 16:30:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30508 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346504AbhIGUao (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 16:30:44 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187KOfxp009302;
        Tue, 7 Sep 2021 13:29:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=WIyhPxa3F2m5x+zzCJ7iDKqjMui8xmkLXc/MDHgyXYg=;
 b=IUfvI9yD13ALwqFba3oTfdg7fFk0cov1KTyfxHoWGUlwX48N/MCGYu/HbqzKMEFeXdvC
 ZCVL/yP5zx2O0V7qn3gbeeUMZLD9MHxh2m/kv374MRHxeliuAUEd5CND/M4WYJs7/qPB
 ct9X4lXXCgmc2IZ1a/l9NFKqzHFnTkxOHaU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpgh6x0-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 13:29:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 13:29:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPmny/6cIVNPH4yBcZMuTkWtzo7WLDSc4BCpShmggGoCe6ZD7cMy/KaxLASlv5vHyW+XzAntuz3lb7Z4wKYetDmThu2DY1NBg+ZOj/5LhjEuJhCzyVO6SdxBqcDV8ktd53/r9EOaUDDgP/hy85BZQ1/DDHnQtcEnrP/NUODwFjzn+NouaDgfrE+Aa5QxtUFvMobjkI/DfCxjoQMButT6ECLC1AYn7O2ySaNwInKsI7eFfioQhPsEipbwQn7HzpWSUFg3xGDKayCpkk2AY2JUrM0XN5SPns57d1LTu8NYblg94MPC9bZdSMrbHWg3nBYZXFNLfTrKateCvP6mWoOOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WIyhPxa3F2m5x+zzCJ7iDKqjMui8xmkLXc/MDHgyXYg=;
 b=FDknJOZzSDRz3UAGo0RaANuUpX8Bj36tJCVwOHlUdTP6qORklo4LtNYtbVoxiXwHUfiFK3P9Dy1fLfYUX35Wz7+AaYqNQXXNLKZtiTC2loKquONXxmElGp2gNQBenSko3S324uKXZYnySstNsEgbHI4TLFC5C4J7TRxgbSz711xN89fTXg+BhH/yk8eCaKnIdr69Mzl3QOMWEqSXxVJKFFqXC4xrCj2Y5gk/yKkF9PhyMb4brUsqZTPAK7v3L72FcJFmVSSVW73/dn22pxc1y8TbYMjnPqyO+HndeQLSx+900Pgox6wZ344ZrYk6i79daeVDL7ZFkwbmzEF+svKAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by PH0PR15MB5086.namprd15.prod.outlook.com (2603:10b6:510:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 20:29:32 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2918:43fd:5d67:cbcd]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2918:43fd:5d67:cbcd%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 20:29:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     bpf <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Thread-Topic: [PATCH v6 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Thread-Index: AQHXpCbirPiXWtbxT0SKMqbyy1st0quZBdMA
Date:   Tue, 7 Sep 2021 20:29:32 +0000
Message-ID: <F638720E-F0A7-468F-8862-907CFB19E4A2@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
In-Reply-To: <20210907202802.3675104-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5ae6f84-16a7-4408-dae0-08d9723e3362
x-ms-traffictypediagnostic: PH0PR15MB5086:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR15MB5086E82CCE3FF8C95B210F9AB3D39@PH0PR15MB5086.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8eUT6NbVIxK47za3qOtWQJzfRVR1Pvzq3LVh5CAQRLQyx+t6MVU0n2NWJ4ezf317l0s6yL3y6ynmcZMmHjkF+DjzMGu2kHcClueeFtINsB9VNYxFB3ysEi86KhuCtubzx17CXkHFjjCE+4sjkJr6J0CiZ6JhLzk5ON5HxvueF7QahdBgiavLKCHv7UB1DcawfJLtYX1tDFd6uIhyB1EYuqvyCh4Z2mvGPFgh0GGeWB2qgOQChafYBomA4h34Ojuo1q15jUStkZSLe6c7gAELdvIk01i6YEc0KAAXPCn7wCLoJjPAWvUUho1aSEVPEA9u+Kh7Kufyrq/GEThLJOl7ERcXE+QBRQlZn+O/0xsbBwMRDxEWleKRf6cMsDV/sKOVHedaQLr5xlFQ9zBxzCrdhkWQur7bZ+EyH9wsOyZ7Yrn4+ZIfJSNXiXukjO8PynnbHy9H5ukrMRgdpGH5LtUBk1SSP3AC0BR7XB4VSX1sWFTwtmBqijJCQcPc2N2iD8RB2HXHHtZ+cHWGNRvr9sfbHms/E9Te8O2yLp39u2jiXtHqDiUGWUpl8bEqA/e39UwPZl0w5n5BNL8iiLur4XQEoq//s2Ub9kYHxvBHoAjNMC4H+ML9BbbkOcE/6qlJzOWReWJv6W+59a36O+UoAIdL/srcNxWxmR5MDzzmLSLIU0sx2Lf0lmbmLUwj/kvsttvbX4+TClzvD4X4cPTR0pJfVjDhWX5sYwxunP2YQwiBD/5i77HfWk/WgO/r1P3r0mk1pKrdldCgvAUYnP8oYO6bmjbezTewQM8HZWLzpjsE9bwVWUMnInqkpBI2KZv5p8iT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(2906002)(66446008)(4326008)(64756008)(66476007)(33656002)(2616005)(966005)(38070700005)(8676002)(110136005)(66946007)(66556008)(54906003)(83380400001)(71200400001)(6506007)(316002)(5660300002)(8936002)(186003)(36756003)(76116006)(478600001)(86362001)(53546011)(38100700002)(122000001)(6512007)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aeHqtadrbWR6jpqiQgj2PC6e1u4V5IDnFy/2TeNCI399auxkVZhGB31iUPl/?=
 =?us-ascii?Q?I78Y9LUCctZhXhPEJdEjHAvlizQidMzRw/WL5mktAerR8gU2Fhb4WKYUDl1D?=
 =?us-ascii?Q?lMuVorCxBDW/rfIXWppOKIosczzDlnHfY3Y0yMEOb8w5jly3gYiJ2dH2n/U9?=
 =?us-ascii?Q?+/giXXdmLWwBQmvB9LyGykyGHSQCyews+IgHxDD6ZQak653LlidEzQb2x54A?=
 =?us-ascii?Q?dqcD8Mso2w8Hd0TcvWB1sTTzlKAXV+wPKtZ1q//M87gcCcij/iIhyzoB/LPi?=
 =?us-ascii?Q?z5tNNuM5xmgw8lO7xz/Mkj+8xpWCZXubVqU0v0N3o8GX0/GjKLd2Hyb/vJXj?=
 =?us-ascii?Q?B3h0thb37nsKZJ1VQJGw3JeSvJiwrBxb/lTzk91IFM4Zl3lvd3XEbliPLYe9?=
 =?us-ascii?Q?XoKZKMUOCeYxpNuGu6hn8TSsWJ9OAPwZap+S+JmTAOKJT/AyUtswwR/ikpnv?=
 =?us-ascii?Q?4nHL60EKrqiZuQnxIvSeN47zDXDliChC6dtc+yVqMu93HlpETaOxGIz94ssJ?=
 =?us-ascii?Q?1hEBH6+uqiwJ2hDhQk3cC9g5u5Ae9wmsqHgr0dFXsIkfK14qXabn4pUZyUHC?=
 =?us-ascii?Q?quPhwyIOLP6F3NoZeVGcjyn8v8hqQlw7rkwUnU6yGP/g1zrgoMTVNiKvAGxi?=
 =?us-ascii?Q?x0hBhFXiroUCQhon/7NqdnPX7rh2LUjUcvRw7UzVxaBzwb5FjJ4ozaZvQpij?=
 =?us-ascii?Q?57OoMclVqjx0nkyYQ8vdAgvaAT27iubqUulrdcnh3xBhn3UsSXNX9lG7yRI/?=
 =?us-ascii?Q?LnYzD3DacygsI/KrMo7drM00TTqzjt5VrI/+INUwaSg0s4za4pcTo3/A++2Q?=
 =?us-ascii?Q?Cmao2esd9/oyUFFGlI7MQt85H3i4A1iIXFrs33ObyxmQMkTE/CO9zRkkOb4e?=
 =?us-ascii?Q?+98cgvxXWiOIBv+csdayFX4MCiULM00QnNckV3sIlBBxItkD9sGQJVmod2sc?=
 =?us-ascii?Q?NwIoirPZDQqwCWsGVClsCPXqLlcSd3f4Lnrln/zizCkQUoja2zspCxeya//8?=
 =?us-ascii?Q?TQjuGNgeNH4EqnJzk2ZGXhCq87Cm40TA50CoEI822N6vcGPDw3teKiEeDO6m?=
 =?us-ascii?Q?Jj/nzbiNCVTiiKzyQ4V8XgGhlWz7kje481g/B/rNOhHwcJxjCEGnE4gQjosa?=
 =?us-ascii?Q?52VvGbQ4I77UpXy3ir46VwsRXHuLEc899zJhASQdUEoT6xokYXoa+uWgnaix?=
 =?us-ascii?Q?HIXCgNoIlFirIL50am62AZMPNmuol13jXO0+xq8QrHsiWGB+URpESZB656Tf?=
 =?us-ascii?Q?F7VN0EKsYyO1oMJfPVpagh1dc6L2VYycPeUivSbEOUdWOF8rzGnSgqiZuL8n?=
 =?us-ascii?Q?YidbtXRLe2mUSLBOJCPL8nGV5F32JPS0/yH6EAjunLq5V9o6kMFT2HltxyUg?=
 =?us-ascii?Q?Dn+2TTY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D0196A38733804DB2E1C923C1585D7B@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ae6f84-16a7-4408-dae0-08d9723e3362
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 20:29:32.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+Rz9tNT+je4F3fwAT9WD3WdtH+AlYhnC/KW9t3fV9GWO6ar10o8OSyBEWo9whveZnYVWzdqaPVrPFtjifDO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5086
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -0Tfm_vjICorVG6P3jNk_ijK2Cl2m1BI
X-Proofpoint-GUID: -0Tfm_vjICorVG6P3jNk_ijK2Cl2m1BI
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_07:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 7, 2021, at 1:27 PM, Song Liu <songliubraving@fb.com> wrote:

Forgot to add changes:

Changes v5 => v6
1. Add local_irq_save/restore to intel_pmu_snapshot_branch_stack. 
   (Peter)
2. Remove buf and size check in bpf_get_branch_snapshot, move flags 
   check to later fo the function. (Peter, Andrii)
3. Revise comments for bpf_get_branch_snapshot in bpf.h (Andrii)

> 
> Changes v4 => v5
> 1. Modify perf_snapshot_branch_stack_t to save some memcpy. (Andrii)
> 2. Minor fixes in selftests. (Andrii)
> 
> Changes v3 => v4:
> 1. Do not reshuffle intel_pmu_disable_all(). Use some inline to save LBR
>   entries. (Peter)
> 2. Move static_call(perf_snapshot_branch_stack) to the helper. (Alexei)
> 3. Add argument flags to bpf_get_branch_snapshot. (Andrii)
> 4. Make MAX_BRANCH_SNAPSHOT an enum (Andrii). And rename it as
>   PERF_MAX_BRANCH_SNAPSHOT
> 5. Make bpf_get_branch_snapshot similar to bpf_read_branch_records.
>   (Andrii)
> 6. Move the test target function to bpf_testmod. Updated kallsyms_find_next
>   to work properly with modules. (Andrii)
> 
> Changes v2 => v3:
> 1. Fix the use of static_call. (Peter)
> 2. Limit the use to perfmon version >= 2. (Peter)
> 3. Modify intel_pmu_snapshot_branch_stack() to use intel_pmu_disable_all
>   and intel_pmu_enable_all().
> 
> Changes v1 => v2:
> 1. Rename the helper as bpf_get_branch_snapshot;
> 2. Fix/simplify the use of static_call;
> 3. Instead of percpu variables, let intel_pmu_snapshot_branch_stack output
>   branch records to an output argument of type perf_branch_snapshot.
> 
> Branch stack can be very useful in understanding software events. For
> example, when a long function, e.g. sys_perf_event_open, returns an errno,
> it is not obvious why the function failed. Branch stack could provide very
> helpful information in this type of scenarios.
> 
> This set adds support to read branch stack with a new BPF helper
> bpf_get_branch_trace(). Currently, this is only supported in Intel systems.
> It is also possible to support the same feaure for PowerPC.
> 
> The hardware that records the branch stace is not stopped automatically on
> software events. Therefore, it is necessary to stop it in software soon.
> Otherwise, the hardware buffers/registers will be flushed. One of the key
> design consideration in this set is to minimize the number of branch record
> entries between the event triggers and the hardware recorder is stopped.
> Based on this goal, current design is different from the discussions in
> original RFC [1]:
> 1) Static call is used when supported, to save function pointer
>    dereference;
> 2) intel_pmu_lbr_disable_all is used instead of perf_pmu_disable(),
>    because the latter uses about 10 entries before stopping LBR.
> 
> With current code, on Intel CPU, LBR is stopped after 10 branch entries
> after fexit triggers:
> 
> ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
> ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
> ID: 2 from intel_pmu_snapshot_branch_stack+102 to intel_pmu_lbr_disable_all+0
> ID: 3 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
> ID: 4 from bpf_get_branch_snapshot+18 to bpf_get_branch_snapshot+0
> ID: 5 from __brk_limit+474918983 to bpf_get_branch_snapshot+0
> ID: 6 from __bpf_prog_enter+34 to __brk_limit+474918971
> ID: 7 from migrate_disable+60 to __bpf_prog_enter+9
> ID: 8 from __bpf_prog_enter+4 to migrate_disable+0
> ID: 9 from bpf_testmod_loop_test+20 to __bpf_prog_enter+0
> ID: 10 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ID: 11 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ID: 12 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ID: 13 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ...
> 
> [1] https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.com/
> 
> Song Liu (3):
>  perf: enable branch record for software events
>  bpf: introduce helper bpf_get_branch_snapshot
>  selftests/bpf: add test for bpf_get_branch_snapshot
> 
> arch/x86/events/intel/core.c                  |  29 ++++-
> arch/x86/events/intel/ds.c                    |   8 --
> arch/x86/events/perf_event.h                  |  10 +-
> include/linux/perf_event.h                    |  23 ++++
> include/uapi/linux/bpf.h                      |  22 ++++
> kernel/bpf/trampoline.c                       |   3 +-
> kernel/events/core.c                          |   2 +
> kernel/trace/bpf_trace.c                      |  30 ++++++
> tools/include/uapi/linux/bpf.h                |  22 ++++
> .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 +++-
> .../selftests/bpf/prog_tests/core_reloc.c     |  14 +--
> .../bpf/prog_tests/get_branch_snapshot.c      | 100 ++++++++++++++++++
> .../selftests/bpf/prog_tests/module_attach.c  |  39 -------
> .../selftests/bpf/progs/get_branch_snapshot.c |  40 +++++++
> tools/testing/selftests/bpf/test_progs.c      |  39 +++++++
> tools/testing/selftests/bpf/test_progs.h      |   2 +
> tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
> tools/testing/selftests/bpf/trace_helpers.h   |   5 +
> 18 files changed, 378 insertions(+), 66 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
> 
> --
> 2.30.2

