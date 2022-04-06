Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805EC4F6B62
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 22:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiDFU2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiDFU2f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 16:28:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC0357711
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 11:49:08 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 236Cw8aL012213
        for <bpf@vger.kernel.org>; Wed, 6 Apr 2022 11:49:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=saxHCrOKDmmqYyMNgVLvLv9dSe51k4ge4ueAWtYQI74=;
 b=m7sEVR1dFvvvUEXb1uFJ0Xq4KqrY1/IQI0SGlDIETedNRecjvr8nmXZiPbgM4ufSUTxE
 uWkj2owlAqNitUzycdVkLbMx47ul066yMwSABtpcSQ8sMwj4G+gkUkFmcB3I/9XIYOYp
 dWRmfT3eLn23XfaUtJ+l6OFU8xIIA3DLe9o= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by m0001303.ppops.net (PPS) with ESMTPS id 3f9bb3av3k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 11:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUtsRnfCTxRhciW5k2QelozAD53gPMyMcYwvwzy680tYdbj8fEOZHwt82yutTv4F/fYB6cWQz7V9KpjKhjTDvja78WtKUUJVjkOGd6an9L4d1r7S/IzU7egQEZHR/GusDSOTyJ9qeHC4M6ygVzf9KodoF7pk72TkQTaQQauNz2g8fk2bYoSZBXowHyRHZdfGGNSHX6Hb4XZsbfnqme36aXv4WbKmj8Dgu2i0d7Gv609AEMUKWi6FSnQCPYT/G0xy/BHEpGO2TI79av89ebsFnfmj8bcq4TWaU95TgXycjg8zEcui2SAl41q5iGiD4b8nAvrvj/4XvSrte5zQvVdifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saxHCrOKDmmqYyMNgVLvLv9dSe51k4ge4ueAWtYQI74=;
 b=giuTtef4sm3E8bX/vSsVNZb1l7aOeVTy3kWV5m/XYg9PM7D4rzIB+DpIHaFCmNMOO9di9ldP7DFKw/NAYEmE4L0+YS6TpK8YTO7HBneJQqEElF5+yk74U7MfmeE1A8OVQCcQXFnApMpB/XBNeggxEExXexdxCd8+joqeVmMLqJh2mXZArIrAcraVS3Tq1feL1GRB2WFy9zPEzARSfys+O7IPrul8J4oaHRH16cMYIZP//wN8ddRDVyVKYtDFfh5WfHGpNf5CmI6+vgtgRn6KHFy9ocaV+kIDfgGILi4Pu6Pe8MVFksULO6ZJcxUhEHkqx9jjMpnvVJa31aFh0nLVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by PH0PR15MB5055.namprd15.prod.outlook.com (2603:10b6:510:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 18:49:03 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::2921:67ea:8e59:6ad5]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::2921:67ea:8e59:6ad5%4]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 18:49:03 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Improve by-name subtest selection
 logic in prog_tests
Thread-Topic: [PATCH bpf-next] selftests/bpf: Improve by-name subtest
 selection logic in prog_tests
Thread-Index: AQHYSS2mTsG29tlvRU++0aNFzWhtfqzh82OAgAFIOAA=
Date:   Wed, 6 Apr 2022 18:49:03 +0000
Message-ID: <A628E7AC-4586-497E-AD12-B13E1E81B30A@fb.com>
References: <20220405204158.2496618-1-mykolal@fb.com>
 <CAEf4BzYhUp3UqfMfENqM_A7Dz=TkaV44eCoNzoD6x2yRs1NNyA@mail.gmail.com>
In-Reply-To: <CAEf4BzYhUp3UqfMfENqM_A7Dz=TkaV44eCoNzoD6x2yRs1NNyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de874905-dde8-452c-9a51-08da17fe1edf
x-ms-traffictypediagnostic: PH0PR15MB5055:EE_
x-microsoft-antispam-prvs: <PH0PR15MB5055AA0764A55C80ACF1C689C0E79@PH0PR15MB5055.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ocH34g6g1MLbC8XUSw7JdNMWf/NABoUsrYwg3b0d4T4u8/VvD52x1d2P0k4pEZb19IM5BFA4tNztHSC+YDeHRR/YPmuqat2c0nMXmjjbJolK/f84ktFfGvlotV5rsqxbt659AIECvltkVaHdH4y2dPTWhRUqoUHWI5mjTBH7hjkWA5EvqUGl2ezBrddIE0hau6g1Vt8G6NJituoApeycX7icCd9/KWon3Jb+UaNP675JDJL8DLNCMB75V8jRJClZwfFK+NHxoMk811JiL4hg/M003723hjiciH/OMkwGOIDdoVjIuFCAnerVs6FaijnwcMpaGa+f9sFOGgVnar1KkKv6QXf6kLLrPR8nImXY5f2Oabd+jeQk366L9n2SxbeeF3acgk9CRQzHUIvGl5NwWs7xsrC3j0XNLUjQBMVaFQUNHZ/UmpJdSbDM1MMCrD0HS0sUs6VDovh+GEzqYWFWPQDZbmsJYt+9KvBZVe3H3V3AeytPxrNyDrKHuOT5kSBQPF7ZSc7APVigphGLb5rVIZYN+ySuFsv7+g95Vyn6W24O/eWtDuc1ZFuJWvK6P86qg87HlRgAfQ6DXfE20yKd4kl0u5oYxEdmDqt2G6n8s5FnXN97dCgDuYGjEZBFZfzK2MKO0YLHhIbPzllmpMjAhhvbc8j0FdLZCHh0ZuM9RBN9KHoPk220a1M8pOUQqaCa9zdZL3LZzNxsQC5IrgijE1Mk5UHmbAwQTGATc82P9WvrqCoQMhIZxjnu3WMgw/7jQi4bsTjOhyAwuwx4uQ1YYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(2616005)(186003)(6512007)(2906002)(36756003)(38100700002)(5660300002)(8936002)(83380400001)(30864003)(33656002)(6506007)(66476007)(86362001)(66446008)(316002)(64756008)(6486002)(6916009)(54906003)(71200400001)(508600001)(53546011)(122000001)(66556008)(4326008)(91956017)(8676002)(76116006)(66946007)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nUB5c6cmgMNu7kyG4K0VmMAIIRQ2VofrTo5lUgSfodcT7DDie1MDwWvU+HUV?=
 =?us-ascii?Q?ArRPsnhi/4PxdMqqHfullYMyYUTBbPFV5ASkroKheG1G+07oBcEqykENgWSB?=
 =?us-ascii?Q?D5JdtHXiO1+iAcyLnu+7KrbSQuFQdHClJejN/24C79dnkijqH2wpq6YE3QxT?=
 =?us-ascii?Q?mTf9H4zxRzuUd4R2G6KJBGzmBx6WluSxCGxRBD4S7PwV8/UcXQ7864f7aCNk?=
 =?us-ascii?Q?8uVzifJr34XJDoj5L4i8fx2m3s9gPSm4CeJPUHWvGZ0T12tOCEYhQ8EuGFVn?=
 =?us-ascii?Q?T1dLjqHIy1s/ZOQ8ZbYzhtDT/QQvCR6pzogFwgTtNx+aA6InnIiGsHqOoNeF?=
 =?us-ascii?Q?pVnNmIfyUvJjIN3boLfnGmlm6Iqj/iATCY9RmZ9zN5xh0+atFzmsA/kV2DkP?=
 =?us-ascii?Q?N8+SG75XplQ9zpLH6Nd3oUSoHqbX+8PruxsIK/zhaX3TLD1CZJZ0Gsm/roEF?=
 =?us-ascii?Q?dJtbl4dcALpsOy1X6f250XU7c+HdQkOa14UNHS+nrPgqSpqRpLZMtcR2E+zH?=
 =?us-ascii?Q?ugFXTtcpEqKJZSLWfLQZyLRbbJUkY2/Ec1Yz1dI7JnCiJUUsGCt07PjeKxmS?=
 =?us-ascii?Q?FVdyVDKahK7/+3JiAJTHUMj/Ax/gmVvR7Yzqok3luP3aIUAWg5SNo7nGnJiN?=
 =?us-ascii?Q?a1hLgqWbKxn55NnAWSm+mBvv5P7y3dkQnxI4RlKrOe0VAdI9RXDdwv2qXr2F?=
 =?us-ascii?Q?ZrNTfVnN7YQQnoMPpBnffLylqA5pW5bzUKHra8R6u9OQbcKLR8A6Tid6ieD1?=
 =?us-ascii?Q?3I41ZwsHbuGK7X2TSLjl5qZ1DHLpfqSdGVqSlI9+cDbH60rppbyyFPPUIMIh?=
 =?us-ascii?Q?XTubAHf03JsBPxA6zMWqubePcCgnT466kZWe5w3OM48izLSdbQ2XRQd2brnW?=
 =?us-ascii?Q?sDwNvZw4AoTBbKVjv5JD6/W6q8YEja3vvEYbCd2edOnnGZ8w7z5FH+J5HPUq?=
 =?us-ascii?Q?hyE0YN7knK/2s6FyM9SRWvUCLldtikGJaZQUDpFQbZeiXP7mx6zkx/D2Wx4K?=
 =?us-ascii?Q?wRRZrKSrdnj61Kr2TSXzX98MXJW89DnXdkraaCNcskzyI9AIL5SkyorZwZhO?=
 =?us-ascii?Q?kAYwQPUiD0Iev/3BMub3kEjWgLlP+BGq/7VKHdH2+LNAx8HLX/exrRptnsMs?=
 =?us-ascii?Q?yB74K3Y2zCLwQ/hAaYE5+Eya2gr9hPxNmNU+DsWyEO8+538G6T+pco743a4m?=
 =?us-ascii?Q?K0LL+sk5t1PYe19fzm/JEiitCE9uyPn9RW6TrwijAJDY9D6Fi2vNM7cyoGul?=
 =?us-ascii?Q?98Tb29P0OwzP2KCR8nJMY/ogR9+psuG7Z8VSwEdS4UNi3KZxLobtu6JsZyOk?=
 =?us-ascii?Q?WX77+3WUojoii/vWRHhgssYsJDoTVogAlLVvemQevGYsXeUwOSPaWTN4mt8n?=
 =?us-ascii?Q?M8683l2AE7pbBqrq5W4N3xI1yvNvyYXlOUw97+MS581z2Pcdenh9tcyxHG6T?=
 =?us-ascii?Q?Nek8kA/CnLeJctO6jJprVuXfOqxbeq89gr7f065xyslguCFRlp/3vYtabypD?=
 =?us-ascii?Q?KizpYBOlrK4Xw5b3BUL00p2GfK5388BjWl1uza6wApT4OW7WTh7+gyJIRzIo?=
 =?us-ascii?Q?ooD1OfeIs6HGKaJSswBO6md4/4X96Aa6FqLWmYmH1l2/DfL5DRminxFeBOyC?=
 =?us-ascii?Q?g2Geaz2kPS8aTOuawGFUa7QC0DxPCmDUft0FDwdmTw8SvvwVlEMWQkk99PLO?=
 =?us-ascii?Q?3bmGPie2jmOlCVrwGjcneIo0nEc89h/ZEGalFI5bdzbAi2GbjgA8q2iiuHbK?=
 =?us-ascii?Q?epsK6dYhZzf1YdP3Ehn0itUy0YM3X/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D00B961B5DB6B64697A2FAC39063ADA2@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de874905-dde8-452c-9a51-08da17fe1edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 18:49:03.2199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLj9jJ4nkM8pG2PS+WMT071vZ5QkA1fO4Yi2UWFkHsuZqo7OWydQxAEdGq8AKN8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5055
X-Proofpoint-ORIG-GUID: EHnkzTWb72EaG0t8-ud-fdMtYhLTiLjN
X-Proofpoint-GUID: EHnkzTWb72EaG0t8-ud-fdMtYhLTiLjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_10,2022-04-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for the super quick review Andrii!

> On Apr 5, 2022, at 4:14 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Tue, Apr 5, 2022 at 1:45 PM Mykola Lysenko <mykolal@fb.com> wrote:
>> 
>> Improve subtest selection logic when using -t/-a/-d parameters.
>> In particular, more than one subtest can be specified or a
>> combination of tests / subtests.
>> 
>> -a send_signal -d send_signal/send_signal_nmi* - runs send_signal
>> test without nmi tests
>> 
>> -a send_signal/send_signal_nmi*,find_vma - runs two send_signal
>> subtests and find_vma test
>> 
> 
> Only somewhat related, but while we are at this topic. Can you please
> check whether equivalent approach works:
> 
> -a send_signal/send_signal_nmi* -a find_vma
> 
> i.e., multi -a/-d/-t/-b are concatenating their selectors.

Yes, these options can be combined. I will add a test for the sequence of parse_test_list calls in v2. 

> 
>> This will allow us to have granular control over which subtests
>> to disable in the CI system instead of disabling whole tests.
>> 
>> Also, add new selftest to avoid possible regression when
>> changing prog_test test name selection logic.
>> 
>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>> ---
>> .../selftests/bpf/prog_tests/arg_parsing.c | 88 ++++++++++
>> tools/testing/selftests/bpf/test_progs.c | 157 +++++++++---------
>> tools/testing/selftests/bpf/test_progs.h | 16 +-
>> tools/testing/selftests/bpf/testing_helpers.c | 87 ++++++++++
>> tools/testing/selftests/bpf/testing_helpers.h | 6 +
>> 5 files changed, 266 insertions(+), 88 deletions(-)
>> create mode 100644 tools/testing/selftests/bpf/prog_tests/arg_parsing.c
>> 
> 
> [...]
> 
>> +static void test_parse_test_list(void)
>> +{
>> + struct test_set test_set;
>> +
>> + init_test_set(&test_set);
>> +
>> + parse_test_list("arg_parsing", &test_set, true);
> 
> ASSER_OK() return value?

Will fix

> 
>> + if (CHECK(test_set.cnt != 1, "parse_test_list subtest argument", "Unexpected number of tests in num table %d\n", test_set.cnt))
> 
> please don't use CHECK()s in new tests, we only add ASSERT_xxx() now.
> Also line length should be under 100 characters (except for the case
> when we have a long string literal, we don't break string literals, no
> matter how long).

Will fix

> 
>> + goto error;
>> + if (!ASSERT_OK_PTR(test_set.tests, "tests__initialized"))
>> + goto error;
>> + if (CHECK(!test_set.tests[0].whole_test, "parse_test_list subtest argument", "Expected test 0 to be initialized"))
>> + goto error;
>> + if (CHECK(strcmp("arg_parsing", test_set.tests[0].name), "parse_test_list subtest argument", "Expected test 0 to be initialized"))
>> + goto error;
>> + free_test_set(&test_set);
>> +
>> + parse_test_list("arg_parsing,bpf_cookie", &test_set, true);
>> + if (CHECK(test_set.cnt != 2, "parse_test_list subtest argument", "Unexpected number of tests in num table %d\n", test_set.cnt))
>> + goto error;
>> + if (!ASSERT_OK_PTR(test_set.tests, "tests__initialized"))
>> + goto error;
>> + if (CHECK(!test_set.tests[0].whole_test, "parse_test_list subtest argument", "Expected test 0 to be fully runnable"))
>> + goto error;
>> + if (CHECK(!test_set.tests[1].whole_test, "parse_test_list subtest argument", "Expected test 1 to be fully runnable"))
>> + goto error;
> 
> nit: I think there is no need to goto error after each check. We need
> goto error if subsequent checks can crash due to some invalid state.
> In this case, validating the value of few independent values is ok to
> always check without goto error jumps. Makes tests shorter and
> simpler.

Will fix

> 
> 
>> + if (CHECK(strcmp("arg_parsing", test_set.tests[0].name), "parse_test_list subtest argument", "Expected test 0 to be arg_parsing"))
>> + goto error;
>> + if (CHECK(strcmp("bpf_cookie", test_set.tests[1].name), "parse_test_list subtest argument", "Expected test 1 to be bpf_cookie"))
>> + goto error;
>> + free_test_set(&test_set);
>> +
>> + parse_test_list("arg_parsing/test_parse_test_list,bpf_cookie", &test_set, true);
>> + if (CHECK(test_set.cnt != 2, "parse_test_list subtest argument", "Unexpected number of tests in num table %d\n", test_set.cnt))
>> + goto error;
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>> index 0a4b45d7b515..671e37cada4b 100644
>> --- a/tools/testing/selftests/bpf/test_progs.c
>> +++ b/tools/testing/selftests/bpf/test_progs.c
>> @@ -3,6 +3,7 @@
>> */
>> #define _GNU_SOURCE
>> #include "test_progs.h"
>> +#include "testing_helpers.h"
>> #include "cgroup_helpers.h"
>> #include <argp.h>
>> #include <pthread.h>
>> @@ -82,14 +83,14 @@ int usleep(useconds_t usec)
>> static bool should_run(struct test_selector *sel, int num, const char *name)
>> {
>> int i;
>> -
> 
> keep empty line between variable declaration block and first statement

Will fix, curious though why it is not caught by the script. Probably because this line is not modified

> 
>> for (i = 0; i < sel->blacklist.cnt; i++) {
>> - if (glob_match(name, sel->blacklist.strs[i]))
>> + if (glob_match(name, sel->blacklist.tests[i].name) &&
>> + sel->blacklist.tests[i].whole_test)
>> return false;
>> }
>> 
>> for (i = 0; i < sel->whitelist.cnt; i++) {
>> - if (glob_match(name, sel->whitelist.strs[i]))
>> + if (glob_match(name, sel->whitelist.tests[i].name))
>> return true;
>> }
>> 
> 
> [...]
> 
>> -bool test__start_subtest(const char *name)
>> +bool test__start_subtest(const char *subtest_name)
>> {
>> struct prog_test_def *test = env.test;
>> 
>> @@ -205,17 +246,21 @@ bool test__start_subtest(const char *name)
>> 
>> test->subtest_num++;
>> 
>> - if (!name || !name[0]) {
>> + if (!subtest_name || !subtest_name[0]) {
>> fprintf(env.stderr,
>> "Subtest #%d didn't provide sub-test name!\n",
>> test->subtest_num);
>> return false;
>> }
>> 
>> - if (!should_run(&env.subtest_selector, test->subtest_num, name))
>> + if (!should_run_subtest(&env.test_selector,
>> + &env.subtest_selector,
> 
> we don't have subtest_selector anymore, do we?

Unfortunately, we do use subtest selector for -n option. I do have a change for -n option, but I want to review it separately. Otherwise it makes the change way to big

> 
> also, do you think that maybe combining should_run and
> should_rub_subtest would be a good idea? You can distinguish by having
> subtest_name NULL when you need to check only test?

Similar to above, because of -n option, combining two makes logic too convoluted. Happy to address it as a separate change once we figure out -n option behavior

> 
>> + test->subtest_num,
>> + test->test_name,
>> + subtest_name))
>> return false;
>> 
>> - test->subtest_name = strdup(name);
>> + test->subtest_name = strdup(subtest_name);
>> if (!test->subtest_name) {
>> fprintf(env.stderr,
>> "Subtest #%d: failed to copy subtest name!\n",
>> @@ -527,63 +572,29 @@ static int libbpf_print_fn(enum libbpf_print_level level,
>> return 0;
>> }
>> 
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
>> index eec4c7385b14..6a465a98341e 100644
>> --- a/tools/testing/selftests/bpf/test_progs.h
>> +++ b/tools/testing/selftests/bpf/test_progs.h
>> @@ -37,7 +37,6 @@ typedef __u16 __sum16;
>> #include <bpf/bpf_endian.h>
>> #include "trace_helpers.h"
>> #include "testing_helpers.h"
>> -#include "flow_dissector_load.h"
>> 
>> enum verbosity {
>> VERBOSE_NONE,
>> @@ -46,14 +45,21 @@ enum verbosity {
>> VERBOSE_SUPER,
>> };
>> 
>> -struct str_set {
>> - const char **strs;
>> +struct prog_test {
>> + char *name;
>> + char **subtests;
>> + int subtest_cnt;
>> + bool whole_test;
>> +};
>> +
>> +struct test_set {
>> + struct prog_test *tests;
> 
> prog_test is a bad name, IMO. it's a "test filter", right? Let's call it that?
> 
> test_set isn't most accurate as well, maybe test_filter_set or test_set_filter?

Will change

> 
>> int cnt;
>> };
>> 
>> struct test_selector {
>> - struct str_set whitelist;
>> - struct str_set blacklist;
>> + struct test_set whitelist;
>> + struct test_set blacklist;
>> bool *num_set;
>> int num_set_len;
>> };
>> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
>> index 795b6798ccee..d2160d2a1303 100644
>> --- a/tools/testing/selftests/bpf/testing_helpers.c
>> +++ b/tools/testing/selftests/bpf/testing_helpers.c
>> @@ -6,6 +6,7 @@
>> #include <errno.h>
>> #include <bpf/bpf.h>
>> #include <bpf/libbpf.h>
>> +#include "test_progs.h"
>> #include "testing_helpers.h"
>> 
>> int parse_num_list(const char *s, bool **num_set, int *num_set_len)
>> @@ -69,6 +70,92 @@ int parse_num_list(const char *s, bool **num_set, int *num_set_len)
>> return 0;
>> }
>> 
>> +int parse_test_list(const char *s,
>> + struct test_set *test_set,
>> + bool is_glob_pattern)
>> +{
>> + char *input, *state = NULL, *next;
>> + struct prog_test *tmp, *tests = NULL;
>> + int i, j, cnt = 0;
>> +
>> + input = strdup(s);
>> + if (!input)
>> + return -ENOMEM;
>> +
>> + while ((next = strtok_r(state ? NULL : input, ",", &state))) {
>> + char *subtest_str = strchr(next, '/');
>> + char *pattern = NULL;
>> +
>> + tmp = realloc(tests, sizeof(*tests) * (cnt + 1));
>> + if (!tmp)
>> + goto err;
>> + tests = tmp;
>> +
>> + tests[cnt].subtest_cnt = 0;
>> + tests[cnt].subtests = NULL;
>> + tests[cnt].whole_test = false;
>> +
>> + if (subtest_str) {
>> + char **tmp_subtests = NULL;
> 
> need an empty line between variable declarations and statements

Will fix

> 
>> + *subtest_str = '\0';
>> + int subtest_cnt = tests[cnt].subtest_cnt;
>> +
>> + tmp_subtests = realloc(tests[cnt].subtests,
>> + sizeof(*tmp_subtests) *
>> + (subtest_cnt + 1));
>> + if (!tmp_subtests)
>> + goto err;
>> + tests[cnt].subtests = tmp_subtests;
>> +
>> + tests[cnt].subtests[subtest_cnt] = strdup(subtest_str + 1);
>> + if (!tests[cnt].subtests[subtest_cnt])
>> + goto err;
>> +
>> + tests[cnt].subtest_cnt++;
>> + } else {
>> + tests[cnt].whole_test = true;
> 
> isn't whole_test equivalent to subtest_cnt > 0? Why keeping extra bool
> of state then?

Will fix. Overthought it here a bit

> 
>> + }
>> +
>> + if (is_glob_pattern) {
>> + pattern = "%s";
>> + tests[cnt].name = malloc(strlen(next) + 1);
>> + } else {
>> + pattern = "*%s*";
>> + tests[cnt].name = malloc(strlen(next) + 2 + 1);
>> + }
>> +
>> + if (!tests[cnt].name)
>> + goto err;
>> +
>> + sprintf(tests[cnt].name, pattern, next);
>> +
>> + cnt++;
>> + }
>> +
>> + tmp = realloc(test_set->tests, sizeof(*tests) * (cnt + test_set->cnt));
>> + if (!tmp)
>> + goto err;
>> +
>> + memcpy(tmp + test_set->cnt, tests, sizeof(*tests) * cnt);
>> + test_set->tests = tmp;
>> + test_set->cnt += cnt;
>> +
>> + free(tests);
>> + free(input);
>> + return 0;
>> +
>> +err:
>> + for (i = 0; i < cnt; i++) {
>> + for (j = 0; j < tests[i].subtest_cnt; j++)
>> + free(tests[i].subtests[j]);
>> +
>> + free(tests[i].name);
>> + }
>> + free(tests);
>> + free(input);
>> + return -ENOMEM;
>> +}
>> +
>> __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info)
>> {
>> __u32 info_len = sizeof(*info);
>> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
>> index f46ebc476ee8..d2f502184cd1 100644
>> --- a/tools/testing/selftests/bpf/testing_helpers.h
>> +++ b/tools/testing/selftests/bpf/testing_helpers.h
>> @@ -12,3 +12,9 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
>> size_t insns_cnt, const char *license,
>> __u32 kern_version, char *log_buf,
>> size_t log_buf_sz);
>> +
>> +/*
>> + * below function is exported for testing in prog_test test
>> + */
>> +struct test_set;
>> +int parse_test_list(const char *s, struct test_set *test_set, bool is_glob_pattern);
>> --
>> 2.30.2

