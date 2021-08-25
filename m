Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAFB3F7832
	for <lists+bpf@lfdr.de>; Wed, 25 Aug 2021 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhHYPXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Aug 2021 11:23:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237885AbhHYPXv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Aug 2021 11:23:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17PFK2KK024965;
        Wed, 25 Aug 2021 08:22:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=e1HwnGPx3k6AsPdaPvPoAS8/NvU96aEsEkITEVqEfYY=;
 b=JKVnmwL3AcM5Ch9f10t1T+hNQNHzBXHhHSpVTAiooOKlEqC4jFdh6ihqP/H0569wTosB
 /SCT7cBnF4H2bIRVUNJIxYRkXhU1oo+038rQ99ncaX7jeww3A8YzJPOZXKxrRaUMiRm6
 pVQUX8n38bQyKL7a3viWy3Z13QxeCYKQWIw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3an506y0qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Aug 2021 08:22:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 08:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCe4YOWqmGjvl2vuuYQHv2FLdboCb8BL+v/KDpRrpgJWJKCb0ukKCe6x2g3AwtHTgMHrnEZd+KxfZb48Wt/Y9W6/N5TEIHDgCCJbKyO7nqFkW04TSgqINZ38t/7bHPidHanWdqxKpDOMX8miiJ4YpnNEGO8AjAzE21SAHnqSCv+eNM/i+ZZz2TDwDHvhOn7HT/0CdpMGQwvk30zZ7rPiylgVX8eJRZ7Q5Uhm5XfzjlJF5AaJidq100vtEPKEmbccTnQ4oNNidQCNawC1eWu38XmSrYZ//XGPpROG/fskRQW6b44bAXNUPr2v3TJ+GsY/x1DFaItl2fy5kpVQxmpmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1HwnGPx3k6AsPdaPvPoAS8/NvU96aEsEkITEVqEfYY=;
 b=lp5r948LPtIrj48lHutV57eyR3Vq4i1lD9xLSzw4buvABUC4/8Z2qA6xn2a2F+g9bW21DPRPAGDhE1ukXG1SzdGuSfSVQUwJzu2QPHLZ9XddpBny3BL/g/73zS1Nu8i59kO+pgW+OpCCUf+Mo3FrHqfYX9S8Sl//YyJLhXz0VvXCoF3JyzS08LdF3+cTDr9JinZRw/yq0it24rx+KgkAe03ufWmwk/yEIz2Vpq5RdBaMJZMFM7Sc8TAhE9IuRNChwxoGSKpCUnK9xt6e1DWlFBfRRuqoQn48MRfs5lwMY01N0subWTGQA0w+lxqXJnOvjnI1nNUS2nhbBZpztNp8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 15:22:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 15:22:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXmK2W/diq42SVLkGzxG3mM7ps1KuEIrmAgAA2DoA=
Date:   Wed, 25 Aug 2021 15:22:51 +0000
Message-ID: <19CA9F65-E45B-4AE5-9742-3D89ECF0CEF4@fb.com>
References: <20210824060157.3889139-1-songliubraving@fb.com>
 <20210824060157.3889139-2-songliubraving@fb.com>
 <YSYy87ta1GpXCCzk@hirez.programming.kicks-ass.net>
In-Reply-To: <YSYy87ta1GpXCCzk@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae0131e4-cbd7-41bf-9ea7-08d967dc347f
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5112B1194F6CAC72305A80A5B3C69@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XIeV/06HnFZivOPe6fICB8g8ohsyXFgGqfVNRDWdsYAAYwmAMOuV1ZTiT/Bndbfmi2wOQPKb4wpWzULKFh2V37kG3F9Zf3ge5+9z0cCmme7RHClpRozYucDFM5Dbd1mw96DWGAGJuamoHW6pP8I1VGB5zau+tF48eQX8p/G9N+Jxa8N0EvKVHPqVf7KlmXjaDTYNtONCt35Lq9O6asdb77c+0CtPT3iB6PhRvBSF9MLE16pdR0PHwi20q+iFH32b+S6/p3nPk6hFu5e2A0Hsc6NT7iACnAadsHHrFFsWvQHKTzH4Ndg3qywgw2Wa+vFJQc4Irvsi6iGQk9DNKRHCkDtkmBBVBS4NmnkZ/XZGRbKEe85Fy1+fRWeM/fp/Qry4/wB7x8q7QeC8pRCTtHOIzwSCFamlB7gTzSGsVayPH5C2yXud9BBiuS1DhdjP7R+QdqmEo4VrsmYXvUDIGX48/48uUTrlfdPvdXgHWnqI7y7oy8q5QUot686O3LHFuFcbgNjlubo8RFGbUgTMIDhoeggwJap0THnhIQrAtvQX4DVBU7fKvgPelOdJbhD3onxN5kayvIQG4K5AnAEzmq5NmKUDusyvIgrGA2GBax80OliSNZe2EtcklqJnn6ZctOzj+x1pcsTHJYYfQ7AajwW66f7SWq+35gjOs8Z4KsgkpjwsnU/cxIU3sIqDKN6HjLWM7yIe8ZBOjY5Se+iCs610ITzOjqaaMJa3S0hlX8yFSTE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(53546011)(122000001)(6506007)(508600001)(186003)(8676002)(36756003)(8936002)(38070700005)(83380400001)(4326008)(2616005)(6486002)(316002)(6512007)(5660300002)(54906003)(76116006)(33656002)(71200400001)(6916009)(66946007)(2906002)(64756008)(66476007)(66446008)(66556008)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E/UHLKW+2qqly/oYGEpIQMn3q1AN7IjNwr2+BQNff/Vhg4KW3nixxMhtnpvr?=
 =?us-ascii?Q?fxgwe8Z+79AYj5I43c2mSSzteRqF9diCu9Mu6FVdofE8TM9K267KVsjqGrPK?=
 =?us-ascii?Q?ywwIeRf6hRNvaaTcPPPdKUf8/5T+YN0zsFDgg+w1+mKzamTAePeM0Q5kJV7n?=
 =?us-ascii?Q?KrIzbfhocEd5nJs4uTl1QMti8sMuspXUw2iSCEW4QzFNfii67rFwVixwRs37?=
 =?us-ascii?Q?7zuG7MFbPDOhbItS9VK5B2dRYxZUQJf7K8UAuY4g+anPRJ//yEQTY7ogJp+u?=
 =?us-ascii?Q?HpakOB8AnMzeiM1qfYbRF6S1OkXCOfv81fK0851D+CAw7cIIFt44/QtC5ZAj?=
 =?us-ascii?Q?2Mvjg35sCe+i92iLXWcihhdf4q8gBz2Tk8b3dnvYHqPHIrXzIDgmwI5X9qbq?=
 =?us-ascii?Q?p6mvKq99E5Ysu6jP/XZ3q6oBrEXC5mNbzli1J2GTgMxNIZpH8FlhCBHxgZYK?=
 =?us-ascii?Q?IUKWWIBGg+kq9fea2slS4SZlOJ61crGdtOFfhKmOqFCS02rwkU7DzsMqWlzD?=
 =?us-ascii?Q?vYtG7Y9bBwa5+GSs0fvy079vweZDNM7iVPPrlWQQ21DD61TqQ4AyQtCIUzhj?=
 =?us-ascii?Q?rlKhR0cLD1bESo8Z53lqsa+wD4UDlGJjzZ7gasPKBSZdWc4P+u54BkJ73jha?=
 =?us-ascii?Q?6QASKb1TsWH+1+CV07otRbmkuo1dDfQkYRE7lIV/9WW5v0qcLzfAb3AR1cCP?=
 =?us-ascii?Q?+s5vP1cvHWTzT2BsvZtcilT8tiiqHMo+N1zW8Hw8t9YVyS7RfeBMr+UAsv40?=
 =?us-ascii?Q?5JcFEhwjenaPPwI56dDQTIwk+U5VUoA4nD1nvE3vu6Uq8lPn8f0F1nVEFTgp?=
 =?us-ascii?Q?CFmllXVLcXWtXIqZ4b20pMtiZhAqApCpWqsSXyFnFirltAddrz1xyJGzLwiv?=
 =?us-ascii?Q?32L33r5EQ7CsXGdqXKdJGFIXeENnxDiVDA3BbOnRGRX0GcJVpxlCgvVMnRbX?=
 =?us-ascii?Q?MYwKbzTZijiIggKsVsUZxmhvoVuYMbhd63FmE8dnS653YzE5ncJ+qMaw+ltV?=
 =?us-ascii?Q?QoqOh9jy9qmVul7xsZOdyhM0Y02DzLbjRumjTB0dmrG/PV3W8HBBiODgcXZw?=
 =?us-ascii?Q?ZQ8nEXOilQonb6n09cAGjT+0XCZrQi9Ca/oSL6hq0b6Um6ssR6JOy1lwqdqo?=
 =?us-ascii?Q?fBPqgt4VH3Lmw2ysCoialYvpuVw8az5o0sy99CYMlJlSa6doYny739F2HH/6?=
 =?us-ascii?Q?jP63G6KSspzhUmzAqm7UPN+EIDQCI5zKzd9CrXispFkO9yRGi3dQgPaNuxgM?=
 =?us-ascii?Q?YOPUxgxeGK/k75ZCR63Q6M9xtBz8psUxOXrifKsyzfRwf0QGMw1rFXiiOr0G?=
 =?us-ascii?Q?e6jhV6Wb5RRF3ICy3EeAovimlUkS7dMWTaYBzBufbUOx1+Brw5kHz+ic//K8?=
 =?us-ascii?Q?y9sQpgc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <248424F376E9934DB624447075BFFCAD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0131e4-cbd7-41bf-9ea7-08d967dc347f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 15:22:51.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yap5pzdeieAMW01r+wmbcidXRiTK6T5bBLaHRPeAtgVUckVvsTJb9II7KLE9SvcKuf555KDnh5o6/50HbIe73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FjoaC2zYVN2d--4mp8KfhX6NpfrbbX9T
X-Proofpoint-ORIG-GUID: FjoaC2zYVN2d--4mp8KfhX6NpfrbbX9T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_06:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108250093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 25, 2021, at 5:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Mon, Aug 23, 2021 at 11:01:55PM -0700, Song Liu wrote:
>=20
>> arch/x86/events/intel/core.c |  5 ++++-
>> arch/x86/events/intel/lbr.c  | 12 ++++++++++++
>> arch/x86/events/perf_event.h |  2 ++
>> include/linux/perf_event.h   | 33 +++++++++++++++++++++++++++++++++
>> kernel/events/core.c         | 28 ++++++++++++++++++++++++++++
>> 5 files changed, 79 insertions(+), 1 deletion(-)
>=20
> No PowerPC support :/

I don't have PowerPC system for testing at the moment. I guess we can decid=
e
the overall framework now, and ask PowerPC folks' help on PowerPC support
later?=20

>=20
>> +void intel_pmu_snapshot_branch_stack(void)
>> +{
>> +	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>> +
>> +	intel_pmu_lbr_disable_all();
>> +	intel_pmu_lbr_read();
>> +	memcpy(this_cpu_ptr(&perf_branch_snapshot_entries), cpuc->lbr_entries,
>> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
>> +	*this_cpu_ptr(&perf_branch_snapshot_size) =3D x86_pmu.lbr_nr;
>> +	intel_pmu_lbr_enable_all(false);
>> +}
>=20
> Still has the layering violation and issues vs PMI.

Yes, this is the biggest change after I test with this more. I tested with=
=20
perf_[disable|enable]_pmu(), and function pointer in "struct pmu". However,
all these logic consumes LBR entries. In one of the version, 22 out of the
32 LBR entries are branches after the fexit event. Most of them are from
perf_disable_pmu(). And each function pointer consumes 1 or 2 entries.=20
This would be worse for systems with fewer LBR entries.=20

On the other hand, I think current version was not too bad. It may corrupt
some samples when there is collision between this and PMI. But it should no=
t
cause serious issues. Did I miss anything more serious?=20

>=20
>> +#ifdef CONFIG_HAVE_STATIC_CALL
>> +DECLARE_STATIC_CALL(perf_snapshot_branch_stack,
>> +		    perf_default_snapshot_branch_stack);
>> +#else
>> +extern void (*perf_snapshot_branch_stack)(void);
>> +#endif
>=20
> That's weird, static call should work unconditionally, and fall back to
> a regular function pointer exactly like you do here. Search for:
> "Generic Implementation" in include/linux/static_call.h

Thanks for the pointer. Let me look into it.=20
>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 011cc5069b7ba..b42cc20451709 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>=20
>> +#ifdef CONFIG_HAVE_STATIC_CALL
>> +DEFINE_STATIC_CALL(perf_snapshot_branch_stack,
>> +		   perf_default_snapshot_branch_stack);
>> +#else
>> +void (*perf_snapshot_branch_stack)(void) =3D perf_default_snapshot_bran=
ch_stack;
>> +#endif
>=20
> Idem.
>=20
> Something like:
>=20
> DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack, void (*)(void));
>=20
> with usage like: static_call_cond(perf_snapshot_branch_stack)();
>=20
> Should unconditionally work.
>=20
>> +int perf_read_branch_snapshot(void *buf, size_t len)
>> +{
>> +	int cnt;
>> +
>> +	memcpy(buf, *this_cpu_ptr(&perf_branch_snapshot_entries),
>> +	       min_t(u32, (u32)len,
>> +		     sizeof(struct perf_branch_entry) * MAX_BRANCH_SNAPSHOT));
>> +	cnt =3D  *this_cpu_ptr(&perf_branch_snapshot_size);
>> +
>> +	return (cnt > 0) ? cnt : -EOPNOTSUPP;
>> +}
>=20
> Doesn't seem used at all..

At the moment, we only use this from BPF side (see 2/3). We sure can use it
from perf side, but that would require discussions on the user interface.=20
How about we have that discussion later?=20

Thanks,
Song=
