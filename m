Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675D0517A7A
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 01:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiEBXNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 19:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEBXNM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 19:13:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852412ED63
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 16:09:41 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 242LsRMd014107
        for <bpf@vger.kernel.org>; Mon, 2 May 2022 16:09:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=TNf+IQ09Gjz6rb8bSK4JtbJ13TmCtXagw8Lhl09KJY0=;
 b=rVUVVOs3CVEVBf0TVGHmAxMC9NHP/a/qVRqg1k81hxtT7ajI0sHvZAC06Kk0i+gmCXZf
 ad/cTUya+2a51BOmnDrwgtHbKsYz9/xVS/EGvjLtk7BIOyaFQozU4rkbU+XEv1k13vOG
 hMZeVWeKYjD7qcYx+OvKBEReIhfCPCLUyy8= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fs0sucuq2-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 16:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKtd9wkg5PdAwe5cP8E8sVaaBe1/4FF5thBH8r1sTWEOBwAvswV35tcF1RROGj+czYzoYU2BXVLxQy5cust8p5Bc86MO2AK6L6gcn6yeVbUj6pBrYNsTZj+aNoq2ZzTTmKSUO57NSepvACtTqGpGQBUCFnVZ4QrAi/e0O5gWNHVEQv6Cs+Ywne9a++HlhbiNVYjgsnKY0nsWgifX+lNkml3lXRsjgGO/oJEe0TXr8sWzLbJuS49SXpmgdoLppwFemnEJuTETQPd7UAIcV3badKGNVHPQT3FiVu6FTWnWbHiwpl5fZXZ2rpZ3z7InKbtcAih9ObUU3al642qcZ6Tg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNf+IQ09Gjz6rb8bSK4JtbJ13TmCtXagw8Lhl09KJY0=;
 b=HTb9SDmynUNAe+tt3QVLGFR82YyZ64KP9QGznUeOlqGCk339lp3NQVuQop1NGTs75/qKgjl0enXD1lcHR0qXUZnoLJLr2hraHKhIEJLU14tnKBvI6zRWP/Ktqi2N2IkGl61fS8zBtOCnzf81DhgtDPOcnjLzBEIUAqVoYUFY/sSv8P3YYKAdHrCPJbEaDO+8RocDTJJSOJgmTPHtBZI5l8JN6AKfQZaf/JqvyTRLu1tJWA9dLF0QRQ2sOvweAQ8lWzx97GKlQ9FZ0M33A584mHpiwFIbw1eUBN0QYsiYekM78i/VsPJBeMp8SpcXOu+oq0rERg62OgdEgGNWRUPfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MWHPR15MB1903.namprd15.prod.outlook.com (2603:10b6:301:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 2 May
 2022 23:09:37 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 23:09:37 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 0/5] sleepable uprobe support
Thread-Topic: [PATCH bpf-next v2 0/5] sleepable uprobe support
Thread-Index: AQHYXnmxb4Q1FBwR4kSk/iWJwTXT9A==
Date:   Mon, 2 May 2022 23:09:36 +0000
Message-ID: <cover.1651532419.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3885a146-c121-47f9-5caf-08da2c90d413
x-ms-traffictypediagnostic: MWHPR15MB1903:EE_
x-microsoft-antispam-prvs: <MWHPR15MB19030B50052495572961C027C1C19@MWHPR15MB1903.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAXqMUdASHQN2zfIT+pN1PgReCKUA3i9KtH7I8wrdnshaL81ETXE5DtV7Tn3WKeYj4hm4hAenlxV2sptWrqtdBY6ObcJZxL2hu+gKjZwD4kT1RCP6xfKc5hGj9pPgA4ZeQ6mRn5UVfbnqQgU7IGXFWBuR0mrJBY72cimO4j6g198meOyKTMWNqwOB/yylnoTwKitkHcdXcFnXDhyt2F+G/A4u4BlLWKd0G9sFl6KwyQubdyDYNvA3Mat/kh3JKCoP7FBxC0QK8Pi7NZvZuzb30vFxm0OlNm/894uM3osCc7VzCwUYCKU0ztuR9sivFal3ruHDGWjftixPBsf1OagobkfvZVaCeWnnXKoCNTGovKSJ3fuLzCtuY7YWPXWn2Il6ZN3BtuBkGJIOu2MPhfPR231E94ps7ZTv6OnGhcxR9dTBTY5WdN40X1l/42pwcRXPMtKaj4MlAZdiRIbwD1jUfB0bZfsmbrnIM9i0HrNC4LPF+4moDWSoU1hUzBSKOy/X99zpz+oIoYzp/AygE9xUln2HlFpSBXZ6k/WfQh5vbwuBy7v64n+HW9VkjvagdrCjT6bA9HPE8Sib8FSOg/nZNLpD5vaJKfIn3Hq6eR+/72tkSXPfkX3d6YDamVSiZIMBf/bOkcjixHTvTdjjFuIUE9dn0QypOY7PEs+3QsBsFcE8JKQnZ/U4iO+gzMQYMhaOqiAOFvHc4NBQVWALn3GG+kjWCEqjkWMnCWXD/Mfl6eY5vQdxYTYH5qMf0Gvw2m/k94ht8IiBsX2HqWZHhx5CqIt8ee2syvju3bqSKm3Sjo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(36756003)(6512007)(83380400001)(186003)(2906002)(66446008)(8676002)(76116006)(86362001)(5660300002)(71200400001)(66946007)(6506007)(8936002)(316002)(66476007)(66556008)(64756008)(38070700005)(966005)(6486002)(122000001)(508600001)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XTjj91TcPq7QIrtQQBIYg+dMbZpKpI3nN6f9paq14HLVpq1C28CX5owSc8?=
 =?iso-8859-1?Q?kMWSc2iQcahEifGC+6ngVTLr/lTQ3ASIQkWdO7i2NFPv1Sw6d1g+BKSUio?=
 =?iso-8859-1?Q?KS1DNm4wcYBXqf7/TaxbhRLZlSn5LClDfb8o8aQIRh8Z+BS53kk901R24Q?=
 =?iso-8859-1?Q?8cRLY3reU8zHHe6zCfvQD54rbQJ9WauNP5ahwE5NPYFIOKgEqubv0XcZWZ?=
 =?iso-8859-1?Q?PpTSaCbFOh9yCDJX9xwOiXBqoQlNlajwyq5aQ1Y21I5Lxy7nzOjw5Ok/qB?=
 =?iso-8859-1?Q?Z+xzpx3Pw8gArDfh4E6VSHD8Q2AIDpFsJ9JoC5woXzq04FG5rAU+1csmLf?=
 =?iso-8859-1?Q?yutlLuBrZq950wRNX38WGcGaDvQ9I9dEWHCf9U4tuGOrF28WNIbMJMcxrw?=
 =?iso-8859-1?Q?0JGCw+WNySB67Uj8oF1xZEZPAjj+hfqeDVu68Apo5VEOsaryTXrVvpqzDi?=
 =?iso-8859-1?Q?mjEJuRRvtaYwSdPfC9HDAovlHG4iE79gbzgy7pSSSKuP48tfpkfsAQhW8M?=
 =?iso-8859-1?Q?k3XNX+id3jC30I8AR/qJ0acHxatlAef9gmG+Ag7LoB4+zLAqPUA2sACpkr?=
 =?iso-8859-1?Q?UV1JgLbCq8y9MZdw+Y3KErt0Yvdr20D06SSEgQGNnl82o2S+NXb9q1+jEh?=
 =?iso-8859-1?Q?D8mTT0PO0SMhMWKRNxMwa10WEXjQ6BXlt5AtTMfpRPw66KsOw/1VfFDV/Q?=
 =?iso-8859-1?Q?YQixvvF/Tib4IemHLMGfb4LzcJaR8uKZNlsPDh5SwdGGrReGzIr+3xVySJ?=
 =?iso-8859-1?Q?XYhNBdv/gd+8Od6r7Th5DPu1hD4OWvSlakAddKx68DNemgX1YQGpXOkK7p?=
 =?iso-8859-1?Q?imcxeYIB51wlzkuW3R3cQlw20y4gfIqVWEw75848BSnNJJTT/EEOI6Da3n?=
 =?iso-8859-1?Q?4bkFR5Mnfqtmz/w0j80y+COybo+RQSkkI+bSn/h+t3efewHJl/Ci42w/e8?=
 =?iso-8859-1?Q?8TKSnNc+BI0M3QnkQYtUOD89RPIUQ9nHeXLelIEII6eRN0Z1no+NPfs8AR?=
 =?iso-8859-1?Q?vcAJt505wIqeMaGS/SvORGF2IwkuVTCjPNmk1Y2/vdGFa3fL0cRsyG1Lz7?=
 =?iso-8859-1?Q?9w2qnvr0g0CCUROTMng+2ELEQ7LR09cSUE5HvjCIEVtvE35BAK/W6isNFP?=
 =?iso-8859-1?Q?1O5xFttv3aLL/G1FLioYl9hDlMiLAC1t1vGv/UaWCb4bUg/QMOERx3Xnf2?=
 =?iso-8859-1?Q?zyTSNPqTr0EtcuUcnBc2nuW0g4BFpQTvJGVs9VE1JJq0frt99A6srssBZO?=
 =?iso-8859-1?Q?TveQG/jNNspizSdZwvMKMlTNF+HeJF2Ci0k6xo9h/zFDK3LO5fv3Wl8ci+?=
 =?iso-8859-1?Q?A1hFG+QWIa2F/MF5Ulog/ypaDOa0T0gHItY51ssAhoV/05jgCLAgOGJyAs?=
 =?iso-8859-1?Q?gYkM+yCI0FYMr4TKFPJY9u70RwNmARtMJJEwoba6mPmFYB68GlVv+JpGYw?=
 =?iso-8859-1?Q?zyvBvpoWCQHFK0R6yjtIlXmhgW7HqzcSvy0rXghn8PKa5VrCJWGmBj50tU?=
 =?iso-8859-1?Q?k9C/bSsPoDHGdTS02QjjkjX9LLLrwJjtWfS42v5wHFmtFCoauWJ2TFuE+f?=
 =?iso-8859-1?Q?l/PHY7MhxiRxggogiFvNPewFTA4b31Tnmp1qfwx8sTc+v4ua3HV6Oql78F?=
 =?iso-8859-1?Q?+3g48deNgH22tX0ZXmki6GZoZ4aWJLBCdEfjvodQfpuYbYnjf0uBB6TyxW?=
 =?iso-8859-1?Q?fVzrwmRY0vbVEHTiRHNToNp3wMuggKk69ESFD1im8kWbF1ATnxHkZRCbbn?=
 =?iso-8859-1?Q?2OpPasJbp5x2bk033pWnkfYjbpeb+pv8K8X7UAaf2ZF5ZustxbH603iKs+?=
 =?iso-8859-1?Q?XybGtJQL7YaS7Bk2Zi1Kd7PEEUgIAofqrKsfOLtOOMyLu3sSleo4?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3885a146-c121-47f9-5caf-08da2c90d413
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 23:09:36.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx8t4k+ZBs2JTxjrtr8INwRo6g8eG0qkZyJJ6roPtCUn0AAa48gznBdAB1Lv3bQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1903
X-Proofpoint-GUID: KVNLCSHiLxupRBODOijR_CgExTswzOQL
X-Proofpoint-ORIG-GUID: KVNLCSHiLxupRBODOijR_CgExTswzOQL
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_08,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series implements support for sleepable uprobe programs.
Key work is in patches 2 and 3, the rest is plumbing and tests.

The main observation is that the only obstacle in the way of sleepable upro=
be
programs is not the uprobe infrastructure, which already runs in a user con=
text,
but the rcu usage around bpf_prog_array.

Details are in patch 2 but the tl;dr is that we chain trace_tasks and norma=
l rcu
grace periods when releasing to array to accommodate users of either rcu ty=
pe.
This introduces latency for non-sleepable users (kprobe, tp) but that's dee=
med
acceptable, given recent benchmarks by Andrii [1]. We're a couple of orders=
 of
magnitude under the rate of bpf_prog_array churn that would raise flags (~1=
MM/s per Paul).

  [1]: https://lore.kernel.org/bpf/CAEf4BzbpjN6ca7D9KOTiFPOoBYkciYvTz0UJNp5=
c-_3ptm=3DMrg@mail.gmail.com/

v1 -> v2:
 * Fix lockdep annotations in bpf_prog_run_array_sleepable
 * Chain rcu grace periods only for perf_event-attached programs. This limi=
ts
   the additional latency on the free path to use cases where we know it wo=
n't
   be a problem.
 * Add tests calling helpers only available in sleepable programs.
 * Remove kprobe.s support from libbpf.

Delyan Kratunov (5):
  bpf: move bpf_prog to bpf.h
  bpf: implement sleepable uprobes by chaining tasks_trace and normal
    rcu
  bpf: allow sleepable uprobe programs to attach
  libbpf: add support for sleepable kprobe and uprobe programs
  selftests/bpf: add tests for sleepable kprobes and uprobes

 include/linux/bpf.h                           | 93 +++++++++++++++++++
 include/linux/filter.h                        | 34 -------
 include/linux/trace_events.h                  |  1 +
 kernel/bpf/core.c                             | 15 +++
 kernel/bpf/verifier.c                         |  4 +-
 kernel/events/core.c                          | 16 ++--
 kernel/trace/bpf_trace.c                      | 27 +++++-
 kernel/trace/trace_uprobe.c                   |  4 +-
 tools/lib/bpf/libbpf.c                        |  6 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 51 +++++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 58 ++++++++++++
 11 files changed, 260 insertions(+), 49 deletions(-)

--
2.35.1=
