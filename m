Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9049513EFD
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 01:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353251AbiD1XZA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 19:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiD1XY7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 19:24:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD90BC86F
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 16:21:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SLRt3w016585
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 16:21:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=qpGWBy2Z02vhq2ZPmIb9ajEnQY8IgW1rZdAhhXHwiXs=;
 b=aQvq2Orpk/ZbQ7FaoGXZKsYkSUNwW7K8pyZ7wMOHQJfVGJFeXx5BBIEZv1cxY84NmlTY
 dASm/1hLVDFkfKsRcVJRZ31YoyEfMGSL4JckYPpLyU7gZiLXbjeFv0GAR1rFL0pzIOB8
 kZ0GxCRq9YksZj44MDA+4ZYae2HGzvI8OFY= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqvxxuu26-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 16:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLyYVC+qXb71xbTKjxyRnQTBNwp3TwQ7EizUGCjicHwHCeosojsLBq0/39JayGMWcsh8TDfgyUot7DgwbUUghA9JOtwn2xpuqxwIeYtsUVDVyahOtbmpwipo0b0hXBf0yLB461u19ejj+k6UORcuTcikQWMpKufqHWVd55it/jSUUBKIF5W5Na/Ck9Ij0G1x3JqNrMyZ5No6fxBd1h11dFLySb4/iIgc/iZ255x6oDsNzOVs3wMYTaJbwvSKWvLsEp5dKUKHS1XpEg7QrwCjxLfkrdVyox9wR38FR29yEVVxlftjhbMyw+QsLUwd6JuG2hRi4afc7N7rN+6masGETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpGWBy2Z02vhq2ZPmIb9ajEnQY8IgW1rZdAhhXHwiXs=;
 b=aA5rzLOuRVxUc4uGayTYYNnp7zZ14uNoRtq38SDLrjBAsn1mM23TGe2br43rHB7dzy6jxfnUTRayeYMRr9PT+KcxsOHQaVQ1x2LoMPPIYPBNYmuEfveuingNykpxyivT5OX4E8lMxOjFnLebgTVd7Uk2GE+hd/NZ0zNbV2eaaVGmvCKA6+ucio56ZS9sZgupXoAq6fkqpZ1pSD4gU0ZUe3jR9OEgD44B/IFVxMe2iMYPJV4VL9kL0f99n+I9t2P3gqmcmzvoomMhbUxz3eKEzIcs4FsHSDahAuvjaN3aH2SpwyDFt5OWCfVS1rO4p80b+w/TgvOgMjrkXKCYxJYd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by MN2PR15MB3167.namprd15.prod.outlook.com (2603:10b6:208:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 23:21:39 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::c4de:9c08:cddc:8c76]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::c4de:9c08:cddc:8c76%3]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 23:21:39 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next] bpf/selftests: add granular subtest output
 for prog_test
Thread-Topic: [PATCH v2 bpf-next] bpf/selftests: add granular subtest output
 for prog_test
Thread-Index: AQHYWe1BAAh0Oyhwc0OfO0U/BoQ8hK0EWxiAgAGeeAA=
Date:   Thu, 28 Apr 2022 23:21:39 +0000
Message-ID: <96278584-A04B-463F-88A7-6E740A02A9CB@fb.com>
References: <20220427041353.246007-1-mykolal@fb.com>
 <CAEf4Bzb0P259ReSRSTxUab=9NBsVJEpbxi+gzNgzMLe48ay9Cg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0P259ReSRSTxUab=9NBsVJEpbxi+gzNgzMLe48ay9Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e0bfbeb-d425-468f-7a38-08da296dd8ba
x-ms-traffictypediagnostic: MN2PR15MB3167:EE_
x-microsoft-antispam-prvs: <MN2PR15MB31678426BE80A8A3FD08E09CC0FD9@MN2PR15MB3167.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6mNSR/abSsgihyfpu1EuiKOHGYav+yg4RL3S/Sc9aN07v0wBeGsA8wX6IxejCfsaDvVpEpyMuy58p3oBJxi1ZQy4k4MbjzK/Vah1hi3JzAdbqwlz0PIZIksdJxuADvEEW3BX5LijERfUnPOuOoG2CMXQ9PzoIfCax8h+tcIlPXf3n294sPlZPTMYnYPJ0B3/Ca6F5+3zFsxeyXPvkE/FH7R7sFvxRRvs9VAZVt8h+MJI3hNWlKbc/m54ECDDLa8RsE47V2ghr/PgYm23/2nW6wXJAUdcrSpw9P1bxK6z7IQc2BmICGv0M+bC/7KO9hVGPXfXdOf0XoOEzwPf1L0IAcwtJ4qSfVgGOSIzMRuv2sdiQ09gteYNXp1KY9X1CKPqCNb4txlus6PF4e8gjv7Ue0WfQsjb8AI5sd6Lypvrun9zUow+BtMJsSeBr1+/OSDnL4lUyuloiDbIi7m9C4lQOEWstnD8u9umMfJLW1O/s9u8MqebavNsZ2Qk6++adaT3+eLr+Z0xofnXebG09jx/uwZ0Y7gXPvvooKbfQ1ehmXj+STFvPMj7GJ3cxwHfdF78K+dKavYKisfFW0q7IjZ7yft1jSUbnWQZPuVtyEsSKGSLf7wzu1JOp/OTrc5oWtKYzT09UKNx2s8hlJYEmrc+YlxQ3/soLG1JZNEJ5t6D2011WJ5zDL0Snx9LALzJoRcGmDbp0zVuLWQdsUu7LthvN5VGTtBJDnLz51h8+59fK2poZMKfSj0tWB8Slux8GTk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6512007)(38100700002)(6486002)(5660300002)(54906003)(36756003)(8936002)(2616005)(33656002)(38070700005)(6506007)(316002)(8676002)(4326008)(6916009)(53546011)(66556008)(64756008)(66476007)(66446008)(186003)(508600001)(71200400001)(76116006)(83380400001)(86362001)(2906002)(91956017)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9nm7iUjo+eozZ0oawwAlhYlQnJuZRrhPu2XWuolZhbVktyPiCkchK1lxaEs7?=
 =?us-ascii?Q?HxUKnl7x5rtgrjEAtICbXxRRK2YrZAc124nbryGzhEQsU3l3W4zOzQDhuZx3?=
 =?us-ascii?Q?rsYXB6CXFTh5yKa7G8ZLgxDI6MpRCYryhhOq6h9He/0/MZ+mZ4vGamfmwsZs?=
 =?us-ascii?Q?sI/N2QPQi5ZPqqH+VWdE+6Og8ARGpk6yJ6a7aa2vZj6PE7bIZBz7Xl01Oetc?=
 =?us-ascii?Q?bAhXYiOXUZjwf/KrE6ZehGIujetqdVArJKd2SaQNDD+dYEqdKdSuuxoRIvKT?=
 =?us-ascii?Q?pNJoIjuJTVvU91F8//KlPGp2UAc2LbeAJHUGvkuS3QgDtD8dMgBFGp822+F8?=
 =?us-ascii?Q?JBwriQPH4PqJ9InPt3LrbXC3iZFc/NW+y0DNygP/9sb7s9csNB6niOXJ8HD6?=
 =?us-ascii?Q?connQaVMQhgGKSljguWMs754ShUZqQFCGez7oWGjwe5ZiGNbFvybqGlsszx0?=
 =?us-ascii?Q?5ZrGnGR3kdFbDyq0Td48IkT27w8RToFVDyEEq6IpilSAFz5J6VD5Ie3OoYLB?=
 =?us-ascii?Q?6HK1gX7uviA7tfS6sHO1jlWBmldHaXN24tp70uyTb0jzvND10j23D+NEOAfU?=
 =?us-ascii?Q?iD9+u4kxZ+0+/kBl8cw+FABCHkAkgCF8HgqyPNgGP9dTtrFZ0IRCw+1pMsrx?=
 =?us-ascii?Q?HQjYKGVJK6ppI4zaD8J2kinjVNk8Ugxxf2CnzJSZLPQ3Z/xk+NDnFgHH5z7D?=
 =?us-ascii?Q?iXqNg0dWAb5vlZ7J0sfiGDw70rPzkljKRwJofmEX15px+OuvqrB3alRREZul?=
 =?us-ascii?Q?LdjXq1CYzt4Ca1o2CZ07h/YeHJUo3eHMmt2vnypIH5nupt+NeFw1fqU7PfTr?=
 =?us-ascii?Q?tCuCWMaHmhRM/ysT1K77BA97IfchXBQLGUbRFrwg5y788+2rUDa0ed2RXU+B?=
 =?us-ascii?Q?I/e3hc0wH0c2cL/K3DsPFnVmQ6bR49czvnXfwZq6pLU3javxHucZlJJgSg+u?=
 =?us-ascii?Q?3nsz4XsRgiVFA0N/kva4iDP1w4TFeLY2CnnATt9i5XM8zvcZuktVqVRU3STr?=
 =?us-ascii?Q?JH5w3WbLoKjWcYWzJJd67HKliUMOF66X6KP95wTQlrGjAGfSzG55EutUQIOj?=
 =?us-ascii?Q?Pr4vXK08tzuA4p/gNhr8IYvn9r3ESz5dQyuf1YYPK7dMZfTHaLoRNu6rEOyY?=
 =?us-ascii?Q?FnQFRdpe7PFVQFisdQZVa5YW8lD+tlPW8eL/5cwsxubcMDqDgIGqVQhJiNPr?=
 =?us-ascii?Q?oj/vXWVWfyKP3q1rA2EPvlAY85ONh175XZLNZzE2RsqZrf3Lqo91zv5wVLBb?=
 =?us-ascii?Q?HyfR2pbdDZObWciOAwf46jijhW5v5CWqjQGWOGWjLp1rHAb/FciatUIej3Wz?=
 =?us-ascii?Q?OoVDcSF2RoOVOaMxEUf/7THmDwZ5Vdd3cEX7h5byxmqcdzEOa6UOr1fWgw+M?=
 =?us-ascii?Q?dBl3LMp51dU3BGlB0gV1kSLgBXyba7wqA7HrJdRK9q5XQdxGoTJRN4ZjLUbr?=
 =?us-ascii?Q?cT+1UP1/0Gx7tsgYA2QV6hcWFK4e3LsX5K/+oQg20kU6em0GzSbLEVSf/BFc?=
 =?us-ascii?Q?CL4npBEmv6FOl9lHWQ3yJxhC5JU5e4Zf1vYUtFSDcW6wO7fBpZ/femJITxQr?=
 =?us-ascii?Q?Vzx+Yvbbo381kXMzUpIjaW07dJCJwYwSrcbLiVduUfoVRyXErmaXxAEmfJjV?=
 =?us-ascii?Q?lUZlu9ds9PZZQoZ0jRxhi9rzuonBBNRQlrMntjgmNaPNvOU5gSv+QyepZ/m7?=
 =?us-ascii?Q?2sNApFKjow+nBSbk7nZinEJ2v21V6yqbEJk34B/+OJSVc1S8FazDwRZX6yw5?=
 =?us-ascii?Q?DR65W6udo4MEJ0DI0J5LYSdjF7WBRfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7B5AC9851B97243BDEFF5D7A64FE7C5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0bfbeb-d425-468f-7a38-08da296dd8ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 23:21:39.0151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQmBapl0tnXqJ1pqRK8aMiLDbaWzmorX3p32Me9GeUKLnj7AdA8/wH/xi2DWODx8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3167
X-Proofpoint-GUID: IfVNzrl4Vq5HpKw0ouAiyrlht-VZdpI4
X-Proofpoint-ORIG-GUID: IfVNzrl4Vq5HpKw0ouAiyrlht-VZdpI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_05,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 27, 2022, at 3:38 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Tue, Apr 26, 2022 at 9:14 PM Mykola Lysenko <mykolal@fb.com> wrote:
>> 
>> Implement per subtest log collection for both parallel
>> and sequential test execution. This allows granular
>> per-subtest error output in the 'All error logs' section.
>> Add subtest log transfer into the protocol during the
>> parallel test execution.
>> 
>> Move all test log printing logic into dump_test_log
>> function. One exception is the output of test names when
>> verbose printing is enabled. Move test name/result
>> printing into separate functions to avoid repetition.
>> 
>> Print all successful subtest results in the log. Print
>> only failed test logs when test does not have subtests.
>> Or only failed subtests' logs when test has subtests.
>> 
>> Disable 'All error logs' output when verbose mode is
>> enabled. This functionality was already broken and is
>> causing confusion.
>> 
>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>> ---
> 
> Works great! I've dropped the before test/subtest duplicated output of
> test/subtest name, as it seems unnecessary in practice. I dropped few
> lines of code that do that locally, as you suggested.
> 
> I also noticed a small memory leak, see comment below, please send a follow up.

Thanks a lot Andrii for the review!

I have sent a follow-up patch

> 
>> tools/testing/selftests/bpf/test_progs.c | 640 +++++++++++++++++------
>> tools/testing/selftests/bpf/test_progs.h | 35 +-
>> 2 files changed, 499 insertions(+), 176 deletions(-)
>> 
> 
> [...]
> 
>> +
>> +static int dispatch_thread_read_log(int sock_fd, char **log_buf, size_t *log_cnt)
>> +{
>> + FILE *log_fp = NULL;
>> +
>> + log_fp = open_memstream(log_buf, log_cnt);
>> + if (!log_fp)
>> + return 1;
>> +
>> + while (true) {
>> + struct msg msg;
>> +
>> + if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_LOG))
> 
> leaking log_fp here?
> 
>> + return 1;
>> +
>> + fprintf(log_fp, "%s", msg.test_log.log_buf);
>> + if (msg.test_log.is_last)
>> + break;
>> + }
>> + fclose(log_fp);
>> + log_fp = NULL;
>> + return 0;
>> +}
>> +
> 
> [...]

