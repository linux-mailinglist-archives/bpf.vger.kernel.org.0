Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82C06141EE
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 00:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJaXor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 19:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaXoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 19:44:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0DE41
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 16:44:45 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VMPJ0s010553
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 16:44:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=s6Ag8qpEnxkM2OsSOpqDeZNS3G/vpk6FcW08XvQScpk=;
 b=hNu4ANIurH1OxMD7YohuC6a64VwTRhU4DwGI/RQy4J3cmXgJOHIaLk/1wxvoFylJhg2n
 Ob5uMArgJAHMK43jChciBEI1/0a+wYSAXxcF3I8+Wgd9Wu44kj0feLkOtychnp57d54W
 DEp14ekD/qkqastPnLbiC2xzcbtGhgshb13y1NvOhpbB6W6ygTgivhY/V3h8kMrCqA/C
 zfqOif7rWzNpzAxJtft3TWcmKXdSQspTS2WFUxf9Wb4HP1hsBcGYkDXpnS0lyekvB7ku
 FINiufE6+ZrN+FiJYPwgUQyT1364LI46HO+ZqMI8ty5BRM6V5UcQmXwCFAmcsl6ukL7e QQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kh20w43st-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 16:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BECiW0AV35Ma7Yix3Vrw2Ajap/9oOUrFOc02fcoAL6L+GM0sAjec3MvKP2hndBkKq08WpXPReyLh90e822xQnlBVE9rkeIqnDhkI8Lsl+p5rhhxFFtvXFIRHNGsXNyCgiByfoJdg2J0PgXQ5TNH9UMRY1kVXAy0AnXgytKcOa+FO9zn/QiFBUuG/BICNLJm0E5Qh7k1u2KASvFpOHnqtbPzmO8mI4KazmVs18X8nyT+kcp2gSjBgoY+mO/AV32tpuhPeUwdEY7aL/l2noCYtivjGmV2P5BTpcWg5ugfLhWZ+h9Cd6x8sWCpuuwek1fm+vawXynvzAxdMzFIeVOXbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6Ag8qpEnxkM2OsSOpqDeZNS3G/vpk6FcW08XvQScpk=;
 b=g3OnS/RjZG+bcnfWSw8LV8jbexHk/Z7+2GsrTTdhfi/WGQFH8bh66NvxZr4XivdHOSjsDYMaUGlOvKske3nqkoBsFpp0XaM2SZHM/UAOjBUF2IzZi+imHE77+GlRO+WjN+Gu9/A1qkfkPdLlZoIyoDuNqp/Vt/ney/VFmo7OYMqdeqk+jTWNm6nAQMIZjVFMSkyfc/HudhS6RLrrrSJyNeKZ1Z59CBS9ZOm7uErIHNNhzey6slKXFx7gh3hKdGk7v64IMhwB5nkvtqLBdMdUZvwgXZ+Byi4P/6pw0XZIFwutmocKAXBhSf19CRsLqYiSInV8K6nqT4MD3x/3vixPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BN8PR15MB3204.namprd15.prod.outlook.com (2603:10b6:408:76::30)
 by BYAPR15MB3461.namprd15.prod.outlook.com (2603:10b6:a03:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 23:44:40 +0000
Received: from BN8PR15MB3204.namprd15.prod.outlook.com
 ([fe80::4cd7:af56:c507:d297]) by BN8PR15MB3204.namprd15.prod.outlook.com
 ([fe80::4cd7:af56:c507:d297%7]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 23:44:40 +0000
From:   Mykola Lysenko <mykolal@meta.com>
To:     John Fastabend <john.fastabend@gmail.com>
CC:     Mykola Lysenko <mykolal@meta.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@meta.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests: fix test group SKIPPED result
Thread-Topic: [PATCH bpf-next] selftests: fix test group SKIPPED result
Thread-Index: AQHY6vaGM1jKXWJApUmeK34cLDMAa64kcuqAgAS8pIA=
Date:   Mon, 31 Oct 2022 23:44:40 +0000
Message-ID: <DC4AB44C-734B-46BC-A9E2-9A24C56F7F9A@fb.com>
References: <20221028175530.1413351-1-cerasuolodomenico@gmail.com>
 <635c64abe004c_b1ba20850@john.notmuch>
In-Reply-To: <635c64abe004c_b1ba20850@john.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB3204:EE_|BYAPR15MB3461:EE_
x-ms-office365-filtering-correlation-id: 614e7a59-d021-4e58-257c-08dabb99e0c3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9veiBWkrxnGNpiT/f8w88maIo4fRx5+dJhUS0+FmwM0OX6N7S+D1DQuQMx/q3xhjVHI0Da6fJdKCj4+7OpcPEInV5TqARwBz1Y50ETAE4jqrn4+5/JXroIgTwdtrt5OwKwhNlgsBPIBDJqBBhmD8+OPqCkqIQ59G0YXtGeU2l33LGXKK0PvQMzb5hHRtq7p9W2UeEClAtSWQwzWjrMtUmfS5xVT0kPZncLnBiOpC8YLhbyF/gIT5UpLrO+a351lPqSUn5ZJMo6lQ1kAReFA6FZKa56/2sOuJEjGXLay7U2vrI/LnNZhR2U6P1Bo0xsiAobPvl72zROPXyOhBWGRpWvlCIzrsozjLfvvPA9P1Q9litw1wXup3YrH0nyssQWkmH9EvBvpwXsuBr/1waMzrlEebfFrDM9lXgQzFmfzq5kX5GNNcv5yf7m+tEVDYpmX1ngVTlDI/k2RfvZq59kXKI/82EAJ74xfOADxnoXus5VhhTvux2giZiH/ctKoJIvQxWQBkxhJxNB9sTgqvjstpe+4iNliSNVQugitmmcRqyDbXHYCL0G68WCmC0mcOYboWps6RJ4kZmH9f5MMF+xJcj5gzMExigoAn26BYcdgu7qYcIfPOuOou66KHpLcMWrfHe00n93WfbC9NwkjbqFk2y07LQbJwyhZOLhtdHgjNC5EN90TsvTyOMUjeOO1RHZu+WvQAlE/CCNBCGXojUxOluNbfKikarw+kBRQ1SUC4NOORzLa6RgIsNVCaI+Ud7nFTOTFB//Leex4rYBIU4cBOIgualvyENaCwGIqc4OGC/zM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3204.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(66446008)(64756008)(66476007)(316002)(6916009)(8676002)(91956017)(4326008)(66946007)(54906003)(66556008)(76116006)(38070700005)(83380400001)(8936002)(2906002)(41300700001)(33656002)(36756003)(478600001)(71200400001)(5660300002)(6486002)(186003)(53546011)(38100700002)(6506007)(86362001)(6512007)(9686003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?osYkgVOa9oW6/oA6lt/ZLuBFATdnJspRqRjovY0iWI7LIllIRWQFX9IIjVY5?=
 =?us-ascii?Q?kd6e8KAD8pvi8zkm7+O3e+SpLzvIeBrmMfIBz6VIPUFlnpiuP4MbW9hI5anf?=
 =?us-ascii?Q?N9dkeETgXfmSS65NbMA4cWzGU5xXnf10gv2qyPilrH4owpgOyF1OmS5q+PLp?=
 =?us-ascii?Q?XseePeMpmRKEkUuKYU25BQPJqwmy+OlT1jmcEGCAwD1/BocbVH2zmcTi/DdP?=
 =?us-ascii?Q?ezgGWF2VW1clCZjmGUUxRiKFCl9z7Z3emrS1cxA9gHaULRpB13FXpWMOLQv0?=
 =?us-ascii?Q?FRJpO9Ik5JNDFJmahpOz7hEYL7JyuZwwQlethPjk0hFYmb8/RM9ifG05i/qS?=
 =?us-ascii?Q?BldgoxTj1BmggINukTo5XvvE0x72grZ9yaWKki00iEJk7B2MkijMBMkhcHtU?=
 =?us-ascii?Q?xtLVCpiJ8D75/aH69otS2NxdPvLVM6VCOZKbyiRLg1OpeH11T+v4dlQRu0je?=
 =?us-ascii?Q?wssGwO8uYZLk8MMydjOwM2EZv9kJza7GGCQW0HWtjTujIiHYxPqf2Kv2pJhF?=
 =?us-ascii?Q?fZ1/Da1luIhzlTo/kaBN9f77a516Q6I1QAdB7uRZ61xAC/BeKHnjde6ANT3n?=
 =?us-ascii?Q?y7Dx9vYPDrf3u1vEZ0xp9k3nE6Mi1I+w2VfGilKOVGHLyke5yPE+kJhyVjms?=
 =?us-ascii?Q?3tmPJbuw9jiW32fDr/ffiiB26Uswk8X+EnhVLfzAmtS73GbC8d6D6cjf8Osf?=
 =?us-ascii?Q?BbYulod0wh++4mEZe6ZX6osX5UyuaZi98M9mrylXWKliJ0NDuD16JbRdvZX9?=
 =?us-ascii?Q?VF//vDj07S8UQdGKsJszX9FtQT2Fum40opyUx65+83LWtrXB1Mvg6PBvRaO/?=
 =?us-ascii?Q?EloaV6LLYRfQxvn7Kbkor2OdGvQs1MNIxv5da7XIvqsQza61RNz8pSVV9SIS?=
 =?us-ascii?Q?rnSYTYl2BJAR/RX1JkffQ3g8hilW1TbM0NSYXDisu9ItBUwavIYU7Shus90F?=
 =?us-ascii?Q?qGd/QjSTgeTEmiDFymPicndOn6B3FxK5xpAidXhOWVEbHGYg8cmrfBKR8c4I?=
 =?us-ascii?Q?cUPvig1H8RkJVWgczxYbmeNN6kanB5K4S9VH3bC0HH5oAjSXi6cv0+AYIWr2?=
 =?us-ascii?Q?lyy0wQbLGX9tzzH6jMYsJib2uFVQExXu6DXm3Q14yPa5g5eHAIwQeb9yI3oI?=
 =?us-ascii?Q?GzVilLNzwjXEMZn/UTPw1L5tg0JQtiSHr8WdFNQ1wAvqVCqFOGUZNWNUdyDT?=
 =?us-ascii?Q?OzV/yL4dyntLhhsUjLbDzM+pMJVbcDnmzzSU+3aoyEre0Ic1BUl+ELtmetsN?=
 =?us-ascii?Q?0deKj1tj467npeCU8JldZM/A3InT7WZ1njlVSYUdpDUC8vJ2uDmYtZFGu6c6?=
 =?us-ascii?Q?b3VqxojZEILXAhmqHJKkLvj2QmUGNedgHNDovJ3OzzSRoyjqiond76oZq0a9?=
 =?us-ascii?Q?+EE95xx6Oi0IgrX/g1/q0SD75ePNz5/D9mdg1qy34A49uywpD7Zv00RF4vCJ?=
 =?us-ascii?Q?67eTMPioY4AhOtqjVSpDQCUqmZyrEjY0uy3ssKhWKO/3mM+Z68x6S4xTzXRu?=
 =?us-ascii?Q?t9PQEGIrPCHSHeu6faEQYiHy0+HiIWa8cL2tF+QbSg6ythFQIYz9LLLsqxYC?=
 =?us-ascii?Q?/XqKB0e+bsoL6ZNVdwhs+aDPHd5iLYUm4/D8bFIC9Ck6fX+uEtlAd818Qloo?=
 =?us-ascii?Q?YdksVgguYqGWOYLeJV1B2/VAx4c+6VwrPgh5JNkvFQDB?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D49CEA7E7F5474D97A17E052BCDDD0C@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3204.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614e7a59-d021-4e58-257c-08dabb99e0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 23:44:40.1153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2+TScXjpa8KIr7teSKSBP9tcduPB/nMn7/SgcaxJbMD4dzRwXE03KayYW11mBqhpi5Awdqv/Y5j9uAsMHbNUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3461
X-Proofpoint-GUID: vyXSZBsoDoNBfWwTWC7BnFzODKLY558-
X-Proofpoint-ORIG-GUID: vyXSZBsoDoNBfWwTWC7BnFzODKLY558-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi John,

Test FAILs when there is an unexpected condition during test/subtest execution, developer does not control it. Hence we propagate FAIL subtest result to be the test result, test_progs result and consequently CI result.
On the other hand, SKIP state is fully controlled by us. E.g. we decide when particular subtest/test should be skipped. We do not propagate SKIP state to the test_progs result. test_progs result can either be OK or FAIL. Also, SKIPPED subtest is not an indication of a problem in a test. Hence, I do not think one SKIPPED subtest should mark the whole test as SKIPPED.

For example, core_reloc_btfgen has 77 subtests (https://github.com/kernel-patches/bpf/actions/runs/3349035937/jobs/5548924891#step:6:4895). Some of them are skipped right now. However, most of them are passing. It is a normal state. For me, marking core_reloc_btfgen as SKIP would mean that something is not right with the whole test. Also, I do not think we are reviewing SKIP tests / subtests right now. Maybe we should. But this would be orthogonal discussion to this patch.


> On Oct 28, 2022, at 4:24 PM, John Fastabend <john.fastabend@gmail.com> wrote:
> 
> Domenico Cerasuolo wrote:
>> From: Domenico Cerasuolo <dceras@meta.com>
>> 
>> When showing the result of a test group, if one
>> of the subtests was skipped, while still having
>> passing subtets, the group result was marked as
>> SKIPPED.
>> 
>> #223/1   usdt/basic:SKIP
>> #223/2   usdt/multispec:OK
>> #223     usdt:SKIP
>> 
>> With this change only if all of the subtests
>> were skipped the group test is marked as SKIPPED.
>> 
>> #223/1   usdt/basic:SKIP
>> #223/2   usdt/multispec:OK
>> #223     usdt:OK
> 
> I'm not sure don't you want to know that some of the tests
> were skipped? With this change its not knowable from output
> if everything passed or one passed.
> 
> I would prefer the behavior: If anything fails return
> FAIL, else if anything is skipped SKIP and if _everything_
> passes mark it OK.
> 
> My preference is to drop this change.
> 
>> 
>> Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
>> ---
>> tools/testing/selftests/bpf/test_progs.c | 11 +++++++++--
>> 1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>> index 0e9a47f97890..14b70393018b 100644
>> --- a/tools/testing/selftests/bpf/test_progs.c
>> +++ b/tools/testing/selftests/bpf/test_progs.c
>> @@ -222,6 +222,11 @@ static char *test_result(bool failed, bool skipped)
>> 	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
>> }
>> 
>> +static char *test_group_result(int tests_count, bool failed, int skipped)
>> +{
>> +	return failed ? "FAIL" : (skipped == tests_count ? "SKIP" : "OK");
>> +}
>> +
>> static void print_test_log(char *log_buf, size_t log_cnt)
>> {
>> 	log_buf[log_cnt] = '\0';
>> @@ -308,7 +313,8 @@ static void dump_test_log(const struct prog_test_def *test,
>> 	}
>> 
>> 	print_test_name(test->test_num, test->test_name,
>> -			test_result(test_failed, test_state->skip_cnt));
>> +			test_group_result(test_state->subtest_num,
>> +				test_failed, test_state->skip_cnt));
>> }
>> 
>> static void stdio_restore(void);
>> @@ -1071,7 +1077,8 @@ static void run_one_test(int test_num)
>> 
>> 	if (verbose() && env.worker_id == -1)
>> 		print_test_name(test_num + 1, test->test_name,
>> -				test_result(state->error_cnt, state->skip_cnt));
>> +				test_group_result(state->subtest_num,
>> +					state->error_cnt, state->skip_cnt));
>> 
>> 	reset_affinity();
>> 	restore_netns();
>> -- 
>> 2.30.2
>> 
> 
> 

