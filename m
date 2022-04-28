Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B78513A70
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiD1Q5S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiD1Q5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:57:17 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C80E9D04F
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:02 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SG7bkb026710
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Vx4vCE9G9LUXSsOEPJ+vUf8wI7Br3YHBkJlX/jhl+Gs=;
 b=oY4bqV+aVGxGZ7me8MerINHAnmZnSjq6UmHwZZOEa/D5kpn/sPykYFmIwuhVAn9KjWNe
 vvfAUz9S2gqxRNUaARWarN1NPD6UIdZHDvPz69cdAWVs1FJD9BjnPkY2WjAmSZcmr70/
 pLNOcHEV77mF+lJKbjjTuhQONmDO0kG2Q/0= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqm5r40r4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxwpGQmJpQw6kggQhJtWv9X1L4pwQQ+OSpkhrZ8cop6I5rF2/+amvLZszT/K/orZgynLykYneQLKugnzxJ/b/5MtVCcEtE76UxdD6yFQ068SG4SPatzyN4bRHE8ktdhB54YV8Sryz8ZdTtVupExXoS9WuCB8fvVq4qserq+dA7mA9wjiLv1mObAr/C+uiLtqFOkuo+3PYncGbaTtdmHB2IYfQNMaAU9v9dzqCaM/OOmJddTakkBDLqsJ5b3lq02Pna7fdAybj+ZQX/fJkZMdQ4EcjbnmU/mKGFKSSY4FD1mfTSIH0iid4gRzQuEhFzaXySuIgSsbUsIXLujKCfKEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RkwFv0fbxMW6LngV9kd6QsMd/vjX2vpDdgqt5yPCss=;
 b=f6sipNaH54FHG7KZDkEby4QpApCw1uy4naopr3Apzxuhc/nXvaKkTs+IASDETRLmeSyVogvQXNQG0j8pjXGoeqAO2tWp5DhMa/RjoOiL5nOUCR+7QC48C9StfRLvaBFZIdbvPVuwoS5WgnBXfAM+zj4GP9CfIeaCAO3R/99QNhdgCYmjBFHOn68NJyXeHOUiRNa3XgMIMKFKb9nIzLAqkJyifULkXOS51hb7DLb0gvMpGSjn0Zvo7XecAUSAdBBzZIteiw3sEjzza80pEeJucDF4L/WbUUOPAJnqP1lFRymllEMqH/d+YkrqsEHlW8Ygyqosnk1oqHEgJNF3Pt3TOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 16:53:57 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 16:53:57 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>
Subject: [PATCH bpf-next 0/5] sleepable uprobe support
Thread-Topic: [PATCH bpf-next 0/5] sleepable uprobe support
Thread-Index: AQHYWyCNy6c7tXLQw0aGq68PYMt97A==
Date:   Thu, 28 Apr 2022 16:53:57 +0000
Message-ID: <cover.1651103126.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e17daecb-8883-4f82-0a61-08da2937afe1
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB461558F0A08E6AA5B61F6689C1FD9@SJ0PR15MB4615.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMC4VhztBuLJDMET53oahn00LwywArHwrZtcCLQXnyl8VEC6qk1KrPCYt17wVb33RAsD+iMW3QBttAPxComMH7aQAonSZKw3tE7AFqe8yAyuHnKDtGap0AD2qiVf+WuBo9LNX+rsEtyuUZ/2LHH3ee6i1qI8Lh2JsNKmXaazDjukgu2KxV1reVMrgTauwSf0+Ogrnd/G92u6G0yr8xYp4qi2NTrOMKcJkaT2kuVbw5cAVv+eGPRNlt4ZA/UvJTkByAzVwOBN/rX1ZpNrXORwhjwy8OdVODtA7sgdX5gbV8WvJv4I5boP3j29vRiCnufTu2g9Eyj5GgWJKtPmPQ1NgWMEziso9FT9zih+kM2BVysr675DYAXyfRQuk0b1vrRDGWp5k1+s0JmzzsGUKWqUHTmfwx9gJ46ZgdWpUowVa6O9Gt+FgRWE1i1+xgaXrzv3DEpkDa6NWFnfC2rEB0g8xFIhRDEPMoDU1Si721Fihv0aSpB7WJUtJVhBUUNsZRF+iJCNfUDvw79V1alIi/9zsDDHCG6uP5S1VI62kR5n5EzUVdqGa+OZNBdhliMwMoJJEMp4CDY2unberGiNmJQq0DMWf4pbo3u2Onv0/PhdANCWZ3amyM9fELmAODO7srFcEcOf3QS1yLCWnwiKLHKcOvqCV/jteVQ9bHxMEEOtbm3xwxXPzegAhNfJ0akycl15vLCtfQCWKrbsgBgiRtGXeFGwnYmtnJdP6PRjcedjBFWZoUN3+swxSBj/jNiscs83zH1GigXWDj6Bfp36zSt8rkXJ6fU5fL9WQJv2lj274Yk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(36756003)(38070700005)(86362001)(316002)(122000001)(5660300002)(66946007)(4326008)(8936002)(6506007)(66556008)(76116006)(8676002)(64756008)(66446008)(83380400001)(66476007)(6486002)(966005)(71200400001)(186003)(26005)(6512007)(110136005)(2616005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YwCnKffK+/YQDeqmd4OKCHXAbR7ZM4G64cFKqJnRgQduZ/7Xw2WlCvZEr0?=
 =?iso-8859-1?Q?BFsgmPg7/b3o8+Hrv77aGrQChAdly8bZhyEdZ6TJqpg1G67a8Q+Jd8cAv8?=
 =?iso-8859-1?Q?NM/SfCNfWf/2snUSy0qEq1nyqTPpmr9P8cjQcHe6skCb5vc6WsJ8mfYmhE?=
 =?iso-8859-1?Q?MdKSe44Wic+7XTP+bhdOYtHM0dyxFfGvhAKYkOsk751hYSvu2RNdNeARDq?=
 =?iso-8859-1?Q?inBdyy8ozDMxMpG4UrIu1hqDd4brdur/uI80KF4KvY2QMa9Ks6nrY/10ky?=
 =?iso-8859-1?Q?3BNTLi3014jzaixaarDfU+o4wW88/hrpMbZR1DeLORLQr+niSJLvYBN3HN?=
 =?iso-8859-1?Q?IL3XIx3ISPO4wGvCSfL6ApKAOq6Qq4yka11H7qPGDfkHtpaGHDkJakv1z4?=
 =?iso-8859-1?Q?OOXslpeTLZhCXm0sammUHSpOMf3ccCq28OBCudE4MKhtJUiPsl5yq8fQd2?=
 =?iso-8859-1?Q?6C5n5dom73ppcgDqLcP4hBf6BKV6ROMxP0PZj1vwRUhCsAq2AxsS77SEnu?=
 =?iso-8859-1?Q?EK0SETQvcA7JvwuhV/y7paq58IRbpSdrjUaul4P7FvXSSzlOTbojwXl/Ns?=
 =?iso-8859-1?Q?NtEw3ZI6Jptnp5ydrLad+Fiw9ZLx6MHBeMCMel6/R9mH+RO4+Ml7OxUl0p?=
 =?iso-8859-1?Q?EQ3wPIeOL/QzsX+2Tqs+VQjDl8PUyTiuvJTNcGjxHQEpWqzolhdBLFW7tk?=
 =?iso-8859-1?Q?pe4kFHdq1NpPsCGG6Z70qbIl0fX1Mj7LcEoc74KZVc04Pn7NhqkOeCGAnM?=
 =?iso-8859-1?Q?iNl9b8E6bcm2w/ex3YsAlI7sKnWcmcI/ZFHXWcMvbpU54ZCc1IYkOT0Lip?=
 =?iso-8859-1?Q?6EiBcXXWzI79eFBvHO/VqNfHLw266Y9BtsIHB2s9MGxTGkvjBZmvuy32T8?=
 =?iso-8859-1?Q?3TVcqzWhyGZ5JU960zx0m7xnh32D+apYNAfMgqUPIUiHyylcRwEPQTvoZY?=
 =?iso-8859-1?Q?q9xzofl9pbVocndiJrhqQx2eNS5h/Fs82iGiMQMwU2DPn7+vhB09IvYb6q?=
 =?iso-8859-1?Q?w7Vp4o9MusjEhNNbcHn/S62ALirNTgUna/PU6BFYhT+8+50Odo5fRR2ZUR?=
 =?iso-8859-1?Q?v/LGMX1/4GViYA6YRu+j4tJUL9Qb9+AZ2HQPFT2cmfeENAAnRCwDvOPcnM?=
 =?iso-8859-1?Q?xGTHlfu20aJzFktUVbooI8mpXHWejpcRtCuL+MasHD0ZiWsDpDPk+pCV2b?=
 =?iso-8859-1?Q?Wkcm8L9Q1i/Gs8F6JwgSoYEyylDvJL20Mm1rsj8ynLKL5XRNDOMCcozsoO?=
 =?iso-8859-1?Q?w3+mY2IudD7ZdeWo7JTP9dtJfakpgjT5WvldRvl0xnpxOdHvT3KebAgu8t?=
 =?iso-8859-1?Q?GoxSwHya0EbqZQc1evDflqm5QCCc/U/AB0O1D7Sw+TiTjXYiIoE5ovfcw5?=
 =?iso-8859-1?Q?xujMP/Jv8JAcAW9K8AFOj5MY88O03uIss0dxtYIVJBUezTcTjbsdNIJbwx?=
 =?iso-8859-1?Q?52XA+x0iFPbDq4ocWYb5IdGAUnAYW5KB1rC/a556Wq3yObq99NVYE1dxDH?=
 =?iso-8859-1?Q?5AF6xZKygthOtiLoNYKmDJG8DbfFp5WF25ctubSDY2IIEnPvSIm0xV+AXx?=
 =?iso-8859-1?Q?y7ww6fxNQCH5qHKVZ1eFCTVWYXPtvHMu11R/ekua+qF9NTP0Px2sqWo31o?=
 =?iso-8859-1?Q?qxTGRgzLNKMNxDbp/nDhdRg7hM5yQtChNQ9knaMmULEG5hBb8s8c+qonj4?=
 =?iso-8859-1?Q?zycsN5PHIHBTpY+ouDyc4uN6vHvc8PkhYTWvM3lOsCUCHbw6DL01F2mDQA?=
 =?iso-8859-1?Q?YRTYK1vC31cF15r1VdNUA+a0vCAtxpqJl9IhLfJTSS90jcxH/8UtVWamXO?=
 =?iso-8859-1?Q?UNAG44ruCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17daecb-8883-4f82-0a61-08da2937afe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 16:53:57.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fttVBtruYT8iFZSH4yw05mlNihOU2XfSxAJgkc5FodvZS0AYCco1pEluZJsWjrtn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4615
X-Proofpoint-GUID: pGZRwKyyU_S4rBJ9fTR3G5wbTEvvlEPV
X-Proofpoint-ORIG-GUID: pGZRwKyyU_S4rBJ9fTR3G5wbTEvvlEPV
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
This introduces latency on non-sleepable users but that's deemed acceptable=
, given
recent benchmarks by Andrii [1]. We're a couple of orders of magnitude under
the rate of bpf_prog_array churn that would raise flags (~1MM/s per Paul).

  [1]: https://lore.kernel.org/bpf/CAEf4BzbpjN6ca7D9KOTiFPOoBYkciYvTz0UJNp5=
c-_3ptm=3DMrg@mail.gmail.com/

Delyan Kratunov (5):
  bpf: move bpf_prog to bpf.h
  bpf: implement sleepable uprobes by chaining tasks and normal rcu
  bpf: allow sleepable uprobe programs to attach
  libbpf: add support for sleepable kprobe and uprobe programs
  selftests/bpf: add tests for sleepable kprobes and uprobes

 include/linux/bpf.h                           | 96 +++++++++++++++++++
 include/linux/filter.h                        | 34 -------
 include/linux/trace_events.h                  |  1 +
 kernel/bpf/core.c                             | 10 +-
 kernel/bpf/syscall.c                          |  8 ++
 kernel/bpf/verifier.c                         |  4 +-
 kernel/trace/bpf_trace.c                      | 23 +++++
 kernel/trace/trace_uprobe.c                   |  4 +-
 tools/lib/bpf/libbpf.c                        | 10 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++
 .../selftests/bpf/progs/test_attach_probe.c   | 44 +++++++++
 11 files changed, 228 insertions(+), 41 deletions(-)

--
2.35.1=
