Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5D525953
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359853AbiEMBWn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbiEMBWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:22:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD4C5468A
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:38 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMQNQ013161
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=n2uK7VhnCxac/R4h7kWi9yMJ1T/ShTRy8O8b+/pe7KY=;
 b=NY1EL0+QGh1oNCapxkMZVw1v+mK/96D9HBIHb0Bk08Trb6Sr5CwRwz0jEI1S36lIbgsB
 WrroRj7dS5IQidJ5nKyjM1TtLY6kEvQi+H7+CvN4ZSQA557To9Nfv/vrUI6VCMwhu4SH
 wcGn4ywxnRTVf/l9P6QITA4CD1GX8QeIqo0= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g055hyj3c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7HGevZAfHJbEMK3HxZ92HUFS5DUs7X++hA3WWdbHWX+zkmsN9Q+//e9TLh8Hd9ZPSGyLtTsyM2C3FQg1mbzkcBEodFb+Xft+No2b0pE8zTG9SH5+8lDUapeZavH3OWRpi6jMciLrQzK5q/Eg+apzQ/VPAsaybuWTu92g7OI1Cja/1rwca6NDFXUcIy1TosZkhc8WIijPk+hv0d0fbICkhzc9/8cCzDZpKd6VIZZykQPRcB17chFx/49ev31zGEuGMYERHlU0RZecxMP4qrWvXT0L/BapDFqKl9+k42RdOWGEyHXwhItUbrlHOZjxLNBTfeRsCWvjWL98A0oQmxCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67itb1rdMDCdNqSkzBwwlLcBALv+KUiv+4WTy24qPBM=;
 b=X5I7a4kgi65WOclhXdUkZhxB7z97FXSjJ49YjI2arZ1t/ZbExVgjGM3crMcZSN77nj4AM7vcdYX032tDrk1/JXR6/ckUqd00oOU6lv2bPFBeEk3bGOAIkEUCtEGjcow8uiv8t+m/Ws5CU/SFsZ9lx2HiaddVRuJlpEtNnqkaJj4+bpE/+GxcDbTI0IrPyVLw/KU0KaPCP7IJFXWvkQZtFuyesUUcxL7OlsOqUNV4uh/HlEkofqt/U7C+yN2vdZj+P2gKM7cWUCkJUtkvVp3fo4nZbTyBW3zMrVbkSbrpGoka7ofhG3l8N5KIpWLM7B+nndFQs60rZ+I7KJZiv37O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by PH0PR15MB4575.namprd15.prod.outlook.com (2603:10b6:510:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:22:36 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 01:22:36 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 0/5] sleepable uprobe support
Thread-Topic: [PATCH bpf-next v3 0/5] sleepable uprobe support
Thread-Index: AQHYZmftCOch9V6TDkqAH2qimI+tRw==
Date:   Fri, 13 May 2022 01:22:35 +0000
Message-ID: <cover.1652404870.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ea02448-885a-4d25-ea39-08da347f0ff9
x-ms-traffictypediagnostic: PH0PR15MB4575:EE_
x-microsoft-antispam-prvs: <PH0PR15MB4575F1C81E51F6D8A1E365E5C1CA9@PH0PR15MB4575.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9HsyHpmo2pRmBaH+Q2QINDxs/nY/oQPQ4qfFlFP0Qc0nGvY7zps84dLDBaQCapsTsKZuu5mCuF8e0emHgGhW0NqtEVOaRhGl++DETQ8VTRfg8YIFCCdLTK2Lf1dP0dvWzuFQMAJnD3NBfi6Qq//Y1r5EU5naOaXrklU/RPvfDiLjHm658wyQw01wObQIn7ArEDNwDMUZtK0i8nGJT8OI/kK7C+vrWBpW4kfTj/Yq/fIWm8WvF91De42XgYpntlTzvJBtzWKoglaXHgXRKxcuViVHrw0XWm7kUX72kIc5wekH53csuZrL8mgpmc4TFqtqT28dTmM1/x2YfTq4tSTv3aT/cuJnEAmWhDzKTdcMtFfgytkLru2YcoNdSrEqzaSXp+QRQu9EzUDABIwce+Iji3uXLjLWrThGEq3CFFr6WXrCFzxKYKNi+WbRBHhZ+kOEod7GhDUwAAp6Ly1tSyquhMxKGf6hKGUtajynp5UnAggsZ+3//H0G7iKTXQECoYm3nL9Q3bZoVnd1nokjsdAitKX68J94ANWazExEQmJ0+HNAJ5KWf3Tjx7zBX87dIuxb6F1v0UbPjoJZI3DSFpZDnbD50ezfmfIKkaeNE51/v0gVJ4yMYXybjzEeLVTiU3QoIU7mRaA8D+DcqRqAK4I7zYa2erhkirbiPTzZunrgr7WhzOKVy27SHW8Q6/Fgy17rbdL4QHMMUxkgH/FB9OKDQgJpQS03rL1QydbbqROuwygdIENSUUM4hAvHpcnOFirMX3KNQ9WmijpFWJdZpA99JcWLw2jNV5LlITG3WGMqIE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(122000001)(186003)(66446008)(2906002)(36756003)(110136005)(316002)(38070700005)(76116006)(66946007)(91956017)(38100700002)(66556008)(83380400001)(8936002)(64756008)(8676002)(966005)(6486002)(5660300002)(508600001)(71200400001)(6512007)(6506007)(86362001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cHx9suifG5ADWSyCzAJrSLz7mSj1LejVgrqYUyhmscz/o3nEBvWObIxPzs?=
 =?iso-8859-1?Q?sRKCtii3JxTfDNx8oiqUOKZjoJivaSLKOrTLtYRtzr3pOALLLapvWxeDgw?=
 =?iso-8859-1?Q?cgOiIubOsL0dGyMotMef0wDGA+xD6qL3ANMGfiuNbk/W8xV37B/8Pkt6eC?=
 =?iso-8859-1?Q?8L4Ts1ujH1r+c62hvTiVR0c+NqjVSaXsdtpydLzinJ87wUEfGdovTJcfS2?=
 =?iso-8859-1?Q?0qOejfq9ryJYrXxGAbkZMjkFm5b6yn1U1RiBoMNI6XNA/VMRu0C82JZdy/?=
 =?iso-8859-1?Q?fu3xnLginLbw0EpPr1HIQd46MuwLdNvCV/IgAiYTfYrKiROHp58AjqzosE?=
 =?iso-8859-1?Q?TQy6KFJ7kEjSs9kt4zlKXvk9FTbTyjZXF6ELCmMs7/3erJIcBGESY9j6yz?=
 =?iso-8859-1?Q?iMQzXpdSJ/o6H3dhz3Oer6kT7DKzhXYwXH0Pi5esRfO6zjCTz8mcYwgEGP?=
 =?iso-8859-1?Q?IjTbFvstp2nh8sX39uH8Pzv+7bpiGmeqdsASYum6EVszfSUsRY+oiLZJvP?=
 =?iso-8859-1?Q?wZXBIkSyVG1FCkxfBXbABPWBiNf58+JCUMB7o1ZUGhtE3fq7+SK1QYym6G?=
 =?iso-8859-1?Q?p75eb+9j+00GHsE0DTljDoNiqRZq8xLc7UMcBM6+PExDrnhOK08jWFvvc9?=
 =?iso-8859-1?Q?/R3yTyEFxDaNv2zVJacNTYHOr2df/Satb4JWbTTcMcQ5brlwMSBcw3nATI?=
 =?iso-8859-1?Q?CouSECBJOda9HW9cYKNRxEFEEgJjRBt4Do6dhSF90h3bLMnfiMO84Ahutb?=
 =?iso-8859-1?Q?zVsHgQXBWE5bBVXwGOIG5iuOkFeGuOJu/T3ugadbi4AP0LkbHslMtoTmwp?=
 =?iso-8859-1?Q?el8BBbeqUPyQN8wXQLEAgQgwYNR/f6RyXlNL/h6mKdbhwA7agrNBYQ5FU4?=
 =?iso-8859-1?Q?TDimvXnw6B6quwkpdkAkyd+WTSMke3T7qoH6FV8hv1nw4GWqkoutg8w59s?=
 =?iso-8859-1?Q?8ELKxNGzVnbvV662c7CTLlsueBTMdr+BvaAh7WWKqV9mqg5w0cnOSkXFA3?=
 =?iso-8859-1?Q?6J5Lwgqu2Ov2xrbbEyHNE2y8VenZcUMLPLQKzgzPycVu/XIFEV3yjy+Bm8?=
 =?iso-8859-1?Q?4VBrIMWwW4zQlHP3V7IRFrEdn2V3RwUn9h9bwvkd9HHvZuFmQjONLqTCuP?=
 =?iso-8859-1?Q?yAL3d4P2vTcGX0edxrXqc0uu035Itg4/hP2EZGZCeaGHZau/mcxEQUdnFJ?=
 =?iso-8859-1?Q?JuvFhVZBFsvJv3Gcp3yvdku9d2bPzkTXkBbiJZ4raiTMO3dy1Ti91n6Xks?=
 =?iso-8859-1?Q?4S91w4ogSa6mg5zkHDs9xTH5FFSPEqKBrtmMgbopNGi1c/TdAZqbjkp5sW?=
 =?iso-8859-1?Q?SMV6HkiNoCFH21oWxNx+OAsa9MSI8YE8iM7cPKMo2RLC7peV6DnRZPZdkW?=
 =?iso-8859-1?Q?7N+2zr/mktM3GsF/87GwpamsHYR4Wcl+AynLtV4OCAtNWA69ho+pLhu9wo?=
 =?iso-8859-1?Q?wrAODSQebBRn1103987oCxKrlVmJWAVkqrQBi7mnQmIsvydiuOCJuBsLLD?=
 =?iso-8859-1?Q?9cJ+BQKCjUx+6ZsdUG/SXU4CVFoCe2Gr1kj46KCJNt0KPbq+HyE6gUV7aX?=
 =?iso-8859-1?Q?WbPYWECvAZMQ4FRXZ70Yz5tKN6OM7NEvU4ZTSWue44SJtm2KaIhV6IdnmA?=
 =?iso-8859-1?Q?StI1yPHbZmDoYUN0reBWlttsBnsW7HauvQTDbFQrfTrrFJjYBt+8MnwhEE?=
 =?iso-8859-1?Q?RQCuzwUVfvJYj2Qe1mAiL4uIbQ+CHnrTgSZI+gKo5UplUSG/yE5l9AZkgS?=
 =?iso-8859-1?Q?YKVDAUUgEQkjZj532Kn7ojuGO5AGNRq5LkXA/PWZO3bXthHWoC+9TZMpRA?=
 =?iso-8859-1?Q?rbaf9mGeyJ/T5sT9lfKh4Xhu0KTrChfTmUNVpWE1PbPzLhczRbfe?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea02448-885a-4d25-ea39-08da347f0ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:22:35.9249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRwDvZ/M1n646cj2ElUY/qG6ntHlXDp9wMvBxLziVzMLy/xoLJgZ4zwl17AQuesc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4575
X-Proofpoint-ORIG-GUID: Ej4h3LwP9VBLdEZPpKJRY96DqDH9kWGn
X-Proofpoint-GUID: Ej4h3LwP9VBLdEZPpKJRY96DqDH9kWGn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
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

 include/linux/bpf.h                           | 89 +++++++++++++++++++
 include/linux/filter.h                        | 34 -------
 kernel/bpf/core.c                             | 15 ++++
 kernel/bpf/verifier.c                         |  4 +-
 kernel/events/core.c                          | 16 ++--
 kernel/trace/bpf_trace.c                      |  4 +-
 kernel/trace/trace_uprobe.c                   |  5 +-
 tools/lib/bpf/libbpf.c                        |  5 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 49 +++++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 60 +++++++++++++
 10 files changed, 232 insertions(+), 49 deletions(-)

--
2.35.3=
