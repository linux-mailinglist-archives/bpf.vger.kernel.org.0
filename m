Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7359D54BE2C
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiFNXKy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbiFNXKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:10:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13052E65
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:48 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EMd1rY002772
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=e5hgjKMWM18b5zqxpyY+I7kffWVOC76p6uHNMKcJm/8=;
 b=C2pFDdaBW3G9x9RyxV+S5fKNWwfgSF3eh3qqdMQ1k6JRN4zVlMHZPbuS9Aebw9Mo3Lsj
 cBTiedaXtMd7vS2xW2aoMffonq1Tyrpi4g+32ac9HOJOmgOyOvNPP202Oe2/2T4ljkhn
 OMHo6/ac/zsPHkFLZuIdtcDriu75It6bYY4= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gp8aw1uet-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igZSUTiHotlCASE4C3jidbUNODWDougMMdst41+uZVmy3dRU706sQV15gLep1jV7aViC+5NhSHNaYbzgGu+B4RHN8YnT69JtNEVn1gYM/85EEmz4W2jCA67AgaZlzt04ITZNrzVvUokDwJnmailspA4/cBURxxgPQLWzCs8Ndy5ir7BXo+IgHlkPazskRkL6kS06JLXBnHDh0jizJ4GZKYhsNaTtmT6gJDlTtgXXIPZE3CsP5BG6ZD+opfo3As3CpCJynVj0b/m/mz+qq9oGlhu5bZcQYYV2zDYN58ZPzE9MpYCxzwyDVQcgGOnyYgQXG+Vgx7sZ39a3jTApD+dj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfH8x7mPkjMpqyh2MhosrbdB6oHwfgb/+82/gOfmJSY=;
 b=NqBxaX/CyTDEsIdX4NyVMuJfidKE9szzyngXKZ6pjnPcRQ0umNhfNOfMkxRpO4WZ8fFS0/J8A4DCiUgx/pm76ItFtfs2AZ92AI6bmTJzBBXSoMxVSNn7zzmlB0uhShsAsRlnWkU873IC01z8KZzBD8elu4/Ev8lNvPfDafMFiii2mNrCqo+f6JxmWide08rFi41/qwi2qTmWNwRKzYIvnGQSekQh4gR5sRpGbz6DzLPpWcmsLM2YoCuTNyQH2hCaEzYth1zPDEbuSnZuZ9TINFDlKqe6ptmJEmODznrR8n8NLoS8oEn1CsOHbw+4Oql3ej+HSaiYpim8slEgrnsKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW5PR15MB5220.namprd15.prod.outlook.com (2603:10b6:303:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 23:10:45 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b%9]) with mapi id 15.20.5332.016; Tue, 14 Jun 2022
 23:10:45 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 0/5] sleepable uprobe support
Thread-Topic: [PATCH bpf-next v4 0/5] sleepable uprobe support
Thread-Index: AQHYgEP6HIJ8fqTs3kql16+mzmQJ+Q==
Date:   Tue, 14 Jun 2022 23:10:45 +0000
Message-ID: <cover.1655248075.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 141285f8-98c6-4ea9-8a22-08da4e5b1cbe
x-ms-traffictypediagnostic: MW5PR15MB5220:EE_
x-microsoft-antispam-prvs: <MW5PR15MB5220871C4A57B9F5CEB1496FC1AA9@MW5PR15MB5220.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqL3VicfhSVP52aFnE3a6/RX16uKG57TwBPgaY5RzLfL60V+76a5uaOMOTsEOxhZIHG/9qnBDtsqyLsOaTh6qEjXc6ujR+pdflbHlTvDklIazD3nIw3YWZy4o3pQBootopOjrmBV5dlY1TetHnNqQ5ES1pAbYsqiltznjBi3h7FbZDi+7irlpwN1oUAhsGHpnZU20+SgMcJV06/jS4xy0gE2whQDp38kKPVk/nFGG18k0vPhwtCK5yHcVatIHhLJj/KmLfUNnv6geyakAVBMa9IpBJa1NHU5A0hVWp1eVWxPWjungIPgWLgMTFWWfFKNBXg/KpQnmZBpMYQqtUnxGUfCxy9wcLk+ro9yL48VjMwyGwes6Gmtq8f+lgBYPGi5aDHowAr8dRNQI0fKkkyxcmcyMkftimfwAx80jpzuxypCnw5MLC/Rnvh6SvP/fDSVQRCnubzfDRpm/YSc1NYVKtNc/pvjDwtgU6F6xEvg3HkN10nkM3IgKJwn9vXs0OpU6BdzFCP3YnnTFme9pSEIcK/AHqg08znkGo3AD3gtUte1+Fi8SLEtAXCbwDgb2Q7uf6EFmC1jtUmlFOLcpxxlVRjU7Ny7gYtVzNuxyRvhsMcMvyhB8Fro0aXC8gr93YSw4qFQPd3J6rHEseQ/edMds7LgUI5TZ/kYc3Dq7/cLl11YMfVGPRw/yBgwFxucXGARLTa3+UhvZ0zGQWcqTsbHZhG9fVhNgqZTjW6Sj6dBF6v/+J7efF8EtQkgxnJzxrC6bvMDDX3CnWYoTXofAiQuCc+iasUn+4ej+UovwcTdMvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(8936002)(5660300002)(122000001)(38100700002)(83380400001)(6506007)(6486002)(36756003)(966005)(508600001)(38070700005)(6512007)(71200400001)(66946007)(316002)(66476007)(2616005)(2906002)(64756008)(66446008)(76116006)(8676002)(91956017)(66556008)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PkYO+kHt0y7hLIDhtSeLT40uKGolA7QrlrKRiLcROxMdMxbFhtDMAuXaHG?=
 =?iso-8859-1?Q?0Jzeh6FP8YvhBXpgS/1d/I/G1dQcA9PwHe4SUK8fsmr1d9NyDdG2abWOLO?=
 =?iso-8859-1?Q?fIzRKa4R0X9zlB80uAep/qh0j2fkokKsq1s83MiXH23Jshzu+8IHd2KoKx?=
 =?iso-8859-1?Q?U0czDminupsYcsfZeJXci+YrYy8UsJdzRb1SDSVduvbrl03amr6BcNsPKi?=
 =?iso-8859-1?Q?uZ+CaDjADSeF97m8/Dq2SbMHJO4JcHUyt2YtDrZMl3/oIm/WRn+TTyD6Rq?=
 =?iso-8859-1?Q?Vwjd08dHLe7rHGdN6Ld1ERTxvlvCA88gc4o5ee2BrqjelQdsLNM8YQ3/cL?=
 =?iso-8859-1?Q?k/51B4ikFTMr/nz2LV23CKPbR9yG1RvEgf7xKSfFtG38LWz+vgmk6wmGRe?=
 =?iso-8859-1?Q?FejuQojJIbX1I+rtys3ZG4cYcISDke2aO/HisLqOASpWSrJpDsehcgilIV?=
 =?iso-8859-1?Q?NYtGtWJ/LJoVGhXyctRFRGBw9ZucMb5fKXtoltFrmlu8OgjPV3I0vZIQfu?=
 =?iso-8859-1?Q?fYU+pPtgX5oVx8St6SD4o48JGftVNT5grdnTX7561DO2KSr3wTYBnju2r7?=
 =?iso-8859-1?Q?BRR4k4RSvZoQa+/oLYp52RUV3UPEsQO6kp62tAa6qLh27/0GPTvv19v/Ke?=
 =?iso-8859-1?Q?QYwPg57xw4/kevmCNByVC/LEu/VleuZlRK2D9x7SpkE1ip9s7cA292Lwc2?=
 =?iso-8859-1?Q?23KWJrYKYlt7brjM8fhkSOXGeuWIKviBslO27tVfDCr9cKtYqC9ivH8SXw?=
 =?iso-8859-1?Q?iePD2Oe4Sd6CnONpChBoTQc2TgRYPmWhVSsiOlVZiAnQ8kzqLeWy9rpfe5?=
 =?iso-8859-1?Q?SzbVEfiFMYFrJLjflNyribK+mA03s1zcihL8YNSKUf+gx5f9sET48WFYAA?=
 =?iso-8859-1?Q?JyUUh+/BmDi9/dbn6WPa1150o+yzuAn4+MeHhifaD1qJQa15YjezdHlx4v?=
 =?iso-8859-1?Q?APDiCaiIrGy2n9UhGu46OASwiqRmiNZ3X82klfL0/QDsLwOtK0CgFateCV?=
 =?iso-8859-1?Q?9cgj7KTOLzp4OvJXqD9vsbtMZ0hvNw13lhXpsaE8ppg3hQr11g+H1804CL?=
 =?iso-8859-1?Q?z64vviwc/+3UcYFIi8F1T7K9EMgXSxCnP4e2Ala8vdW0XFsw3tACl/LDxn?=
 =?iso-8859-1?Q?5H8abtv5LKXQSp0L8IujWFnw5oJWsMG2ME3jXrWCPG+ZnZRXRNYcAY/7UA?=
 =?iso-8859-1?Q?M2+VBiVWUYuJuktrDGD40mT0fDpQmtbOF9DRletyw13j8tYzzMVCqvkp2E?=
 =?iso-8859-1?Q?ds8nJQIyK+A9LUEXvPZ310oEAdRG3Sr5TDzhqugJ0o9jLZC+IJBiU9b1qB?=
 =?iso-8859-1?Q?vI8ryNTcV9XSFQTTamByOv640lgYOOzyVOxUiryaDPJlaVQ1sYDbdGYAL/?=
 =?iso-8859-1?Q?Sllh3OoZWJ0oI1bnSiEJYJTFNL9wxEyjoP43kV/BW3bxgP4dR6A/G1DHkW?=
 =?iso-8859-1?Q?Rc2KV4McdFcY5C+VuYJYeWiIWik6jrzNUlZDn64enzmGtmQqHTSrwwWrnw?=
 =?iso-8859-1?Q?Fg7dsveryhnsehPiUkcOYW2M0JLOKkTr1FxZ85BRA4sSuNuOppnEdVgLvO?=
 =?iso-8859-1?Q?Sai7ME5cwKcoNm+9d8Ob1/0Os/GvJGNVPxofQk1y3JEtrKoTizFlu35rco?=
 =?iso-8859-1?Q?m7SgfVHIFJyomsTEcd1s2Dm+kvZZ40dDSqSDs4rN+Hq8qDifiaaCNTkTvs?=
 =?iso-8859-1?Q?k9hdsNx4CVCv7LOr9F94Y4/FNERvM9YqAqzzVJYVVznTD7UtgNNKKmRTDf?=
 =?iso-8859-1?Q?uuyvfPjprVN0ZWgD97nIs77JBauPqZR8VHnUKFSvqA5QHgbq5EPGuT2Tbj?=
 =?iso-8859-1?Q?bCyo0LCpt8cxUTnDJnAKRJj8F1UMd6vDaG4AtMosFN94dedpS7iX?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141285f8-98c6-4ea9-8a22-08da4e5b1cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:10:45.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISuSiVam0R8IB4sgxyuUH3k+9YP0dwyxaMy4rAf5hfb6ts4x3z3cwySOqbw3qWtx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5220
X-Proofpoint-GUID: PxmMMt-pqRDWOr25EaY4y6Fvn2F38ylb
X-Proofpoint-ORIG-GUID: PxmMMt-pqRDWOr25EaY4y6Fvn2F38ylb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_10,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
programs is not the uprobe infrastructure, which already runs in a user-like
context, but the rcu usage around bpf_prog_array.

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

v3 -> v4:
 * Fix kdoc and inline issues
 * Rebase

v2 -> v3:
 * Inline uprobe_call_bpf into trace_uprobe.c, it's just a bpf_prog_run_arr=
ay_sleepable call now.
 * Do not disable preemption for uprobe non-sleepable programs.
 * Add acks.

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
  bpf: implement sleepable uprobes by chaining gps
  bpf: allow sleepable uprobe programs to attach
  libbpf: add support for sleepable uprobe programs
  selftests/bpf: add tests for sleepable (uk)probes

 include/linux/bpf.h                           | 88 +++++++++++++++++++
 include/linux/filter.h                        | 34 -------
 kernel/bpf/core.c                             | 15 ++++
 kernel/bpf/verifier.c                         |  4 +-
 kernel/events/core.c                          | 16 ++--
 kernel/trace/bpf_trace.c                      |  4 +-
 kernel/trace/trace_uprobe.c                   |  5 +-
 tools/lib/bpf/libbpf.c                        |  5 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 49 ++++++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 60 +++++++++++++
 10 files changed, 231 insertions(+), 49 deletions(-)

--
2.36.1=
