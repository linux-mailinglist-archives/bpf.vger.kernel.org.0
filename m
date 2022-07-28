Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57E584508
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiG1R33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1R33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 13:29:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471E63E76A
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:29:28 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26SGHEog023527;
        Thu, 28 Jul 2022 10:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sWv44OufS6eeS5rLpGbWJ5UM3SDD40i0FRWiTW5y+Aw=;
 b=iO0bYC6X0O3w+XPG552sX61L9FVcBreNYG9BZ9SJNcesF564NbOk+x404DukE+u9PdKm
 k4Np1VGrMdcp3JG/RXd9dfhrfBDTTDD6toZUKcP7Kfbx93O3VShzSz9PKpbtLPUsf1Ju
 clENzRvl59pD7YBOpldy7R9LrAxQHGknRPA= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hkjkmvejj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 10:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SraSJ5TimQQTuuqgZHOo1GhGmXBq5LKC92RdwL/14uG3vuHxJ5sjh8cCg3Jdm9LgkLY1o/nUJm6p/eQF30cYMvKbIr6ZfRO3Qv400B3WMdCe8niPRwKDHppVDYCs0Ji6VO7/Q0qUjVXss/Wemib47mMEvYAUIDqIQQIRiY1+DDRw7eijCNPkX1OviceH2JAysZGXZENHxjxJxhkDo78FCyXEKBaZNtQZ/sztmaimVH1thI3gk4bzYSy/lmnu6xrNIxxuaooD28/C7FELMhDSZRBUm6Nn9q8FnqnGF7zwvmjIT+9Iar+iLJx/WJnqasKAtQt4dHMx6XVa58UTjzzfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWv44OufS6eeS5rLpGbWJ5UM3SDD40i0FRWiTW5y+Aw=;
 b=AOLa2cEfjv22Wcp57EywIi2H6GXMsjX3yft3wjEGYqUw+gazUUyWEQsxUDB3IMIWS4X8fYU8KjdWr9dAkINPFb5bPteeluDs7Pk+EBH+z7GGOXIecvj5IXQcpsutZfEu5zV1JBV37MFmyx1RaSc76CR0k35MT44HY7R2gl2neRbDsQcgDw1/AHIPxq4mHUWlfh4SuXUbfTlz7wXrrxSr6wPohi+8CKTpeRGKDVjItSQZr17vyeyZfefBlhW6q/GXxLgJR7YNJzGNXJtzEQTfdND1ZFkN6ZFI6Voc7Oci0LLcTHHiP6QAUe9LINifwxiU3fHuJHBGxmY0DwwX9FW1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2611.namprd15.prod.outlook.com (2603:10b6:408:d0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Thu, 28 Jul
 2022 17:29:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 17:29:00 +0000
Message-ID: <308b9766-0dfa-5b7b-0825-08c765f4ddcb@fb.com>
Date:   Thu, 28 Jul 2022 10:28:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Bump internal
 send_signal/send_signal_tracepoint timeout
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
References: <20220727182955.4044988-1-deso@posteo.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220727182955.4044988-1-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEXPR01CA0116.ausprd01.prod.outlook.com
 (2603:10c6:200:2c::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8adb7ec8-acc8-4104-20e2-08da70bea86e
X-MS-TrafficTypeDiagnostic: BN8PR15MB2611:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6auddMbhszVG1fW6Sz9+rDtuLqC65zI/Ox0Ik+QlzyQflJamAOOZEgHYD5UM0sPhq4rXJn4F3DuDX2z/s/bExLyPCf5oxTqfpuKy8A2gf/nxt4+4EovYiVREFrTKzwNgieacSSy43Eeni0VYoiQwwbUM/VM0BaoSZRwgX2fWQj1gzQaUwR3G2QslK1SmbXD7xavXXyP+wlKxK6g+61rt5ut68BWIugO1Qlg5R5jmdreznluTVx+b3WemVWM/fLfUWJSYJm+a6Rz7kGsRjCg8/xV5z3Y0XdqzzjcivJzV70n7tpVLhZxJ9eDiZ80tOuebs1neIjkeu1q2hr/MFnrI85ztWdzITp0xbaA7IvSXbZtAHqMdrg0O3HoFAzQTVRfhGxDsjioD6KF2x5HSKT/f+7jR+O0QZqZOXzxwppSKPsEXHXvu5E5ClVc8jt3Op/K2mNbpHjejrIw7fPa14Nmzw04gWq5PCRlCb6LPK93JBdftKe5Q3LpGqguMpTuKzJFY45rapfeGX8aRknHEn5D/3v+HqOqVEisRblwT6apcdb77q1Y74bBVW8NA/6UroeQqjyYMVExfGnwdFEJIVT+bJIkb1KmuJsxxsAquw5K25If73WuRtQwugMmJvx+MQqFctKYjY1iPEhh1/VnPaklg+I+Bgd3Ft621DTUC7l8EBJSbLiNFbi8WG3Hh8flY1ZWuSXPW/d3UfHMhvj5Ai9dIDWBfqkNNpiPtg0o191KxU7c92FCKDnpGyjH+ZgbJdSOg9MtygOL7FklwYm+UAv0GCtZ/NyzgRCJHED7eFGa5Z2d/k3oDW/pdUWHjEnoS2OjCC5UeCx2IXcB+7S9NaibEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(86362001)(83380400001)(5660300002)(2906002)(186003)(38100700002)(31686004)(66574015)(6512007)(36756003)(53546011)(6486002)(6506007)(478600001)(6666004)(41300700001)(6636002)(316002)(8936002)(8676002)(66946007)(66476007)(66556008)(31696002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElNOUFKTnd1bXRJODNTdlVGVVIyaWV0VHMwTDIxVDFzbWhlSGQ3ODByMTV4?=
 =?utf-8?B?ZVVhNWJpQVM2Qlh4bktRQUk1eGFneG9wSk1TUjR4T1ZZQXRkNUVTc0IrRUov?=
 =?utf-8?B?ZWFNVWJJck5Pem56aFhxM1FINk1uN0cxK2hnMlNkNkZiMGhhblI4Y0JKN3Yw?=
 =?utf-8?B?bVhWU2tFanRTWU5QMHVmU01OcVE1OXVTY3J1NjBRdzl5RC9mRmlpaS93dGdX?=
 =?utf-8?B?czNvejdIaVhNN2FIQXF6M0FOL2pqcUpEWlFuZmVibWlYaHlqWnMrK3YrdzQv?=
 =?utf-8?B?T1lwNy92bnRhUUJrZTQvb1FhUThTMDl1MzBnQTFKeWxQb2JSeEdCL2pEOTVi?=
 =?utf-8?B?VW9YM0c5V2taTGVPMjY1cTltYkJ5REVqM3FVVDdXQ0RZRmhadjY2d0dMaHBV?=
 =?utf-8?B?ZDl3R3M3a2NlL3lqV2FVODZFTU1PRnFNL21iVjBETVdGa3ZITzF3Z3F0aktB?=
 =?utf-8?B?VnRBcjN2MWtqVWliSDJicUxqVmkxb0Nad2VianUxd2h6VHV3TG83UTRBb0ZN?=
 =?utf-8?B?amRKVGRnSThVZnVEWlVndGowZ0FsRU9sTFRIblFuV1pQalVROHhwZVlPcmtu?=
 =?utf-8?B?R0lhRllhVm1vbzh6bklmT1R5NTdCNWtmZFlpQjdNelhVeGEzZmhNV1NQL2FZ?=
 =?utf-8?B?aTk4akRLL3J5bE10aklyM1VtNTZwRFBHVWVpV0ZhV0JzM0VscUVvVVFkejFp?=
 =?utf-8?B?UWU4YkhhMHAvUnpad1N6MXk2Umc0QWEzaU9KSTNsQ1ZPcnhTSHZYbkVycjBS?=
 =?utf-8?B?SWI3OU1aUXhLWWR6bXJqdmVHOGFYdC9nZ0hRbzhTVEtVME9Ja04zMTVqOHVX?=
 =?utf-8?B?SWlQaVhDMTNxMjNPalIxS2FsK05LWTlhcThqenFjMVdjRDJOVk1nekY0SlYz?=
 =?utf-8?B?dktVN2NHeTcyZGw4WDFjdEhEM2t3cjBrOTdRUFZEMGExTXJUNURWRm1TRUlF?=
 =?utf-8?B?cmMySWFlNmJ3cXdiQjhjcTNpNGF2cVkxU3k4aCtOa2VpZUFVTjRKTUszZEEv?=
 =?utf-8?B?SndPamVodldZaWpjUTdaVVVEZEI0QTJXUkRMUm4yZFcxYTFEeGNvNlRIMmVj?=
 =?utf-8?B?VklmMGxYZFZGZVo3bFk5MXNoSzRSMnJYdGJrbDcwSTZ5MGR0a3g5WjhYZjMw?=
 =?utf-8?B?Y2Jwc05nYVNHTVBDaVNqVlk2UmhZZWJONGk3c2lYZ3ppd1padSs4OUUyVEdO?=
 =?utf-8?B?V0VWYTBYM3pneFdtM1lHa3Nxa0VrN1BjN2VIbXArWUlhY1pBYkgrWk9wRTln?=
 =?utf-8?B?dlVIaEZRVDhpR0x5aGQvQjYxTFZJazB6T0VhQzNOTW02eHNJRS9IcUFKNG5D?=
 =?utf-8?B?V1RVaVJBdnNQUTZsRGtDRFNlUzRVNkdYTXhJT3MxbitHQmNUUXJtT3RpNXNq?=
 =?utf-8?B?VC9hanRuQlMrVnRIRmtUQ0U2bVFmZDc2OWltUEpObVhERHpScXA3dUpVWlFa?=
 =?utf-8?B?WnRlcjlJUFQwVTduSFpacFk1cU1GVGloZlpuTzJzdjNuQVdaT0R3VzE5cTlv?=
 =?utf-8?B?TEltM0F0bnZtZEdXdVA2OU1HRlI3QWpVOTRHeUdWcVF2VjFlOHdYR1V0aFl5?=
 =?utf-8?B?SGZ2N2MzRjNxZEdiNWVuQWFZN0FoVzZOeXBkSGxFMTJrRGpyTTZjbDZLWDU4?=
 =?utf-8?B?RDZsRFlZNTFmL2Z1ZnZiQ0c2YjdIcDBNWE4vV3Y2ME9IZVBERGNTTUF3clAz?=
 =?utf-8?B?cXoza25hRnFVVnJUalVmSFVPdDloZnd6cU5XbTl2WmxOMTdmbHU3aVBWU0ZK?=
 =?utf-8?B?Ull1eDBoR1pSVEl3WGRqbDVtbDVFTWlHY0RKRTlQRmE1bkNJU05BOGFZeVcw?=
 =?utf-8?B?VVRHNWE2UUR4QXNSWFhvc1NkZ0ZGdlQ5aXlqYW5SajBWUHRGTGlyTTI4amtD?=
 =?utf-8?B?eng5eEVKckREZ2wvZTJLUUxFR2Y1RmpBeExWZ1dsSU0wNUpGMjRuOFhBa0dO?=
 =?utf-8?B?L25BNUtVUFR1YUFiNEFSVzdqbkltZkdRTVphbXVXbjRiMi9lY2J5dm1Lb2gr?=
 =?utf-8?B?bFBvbmZxMk55Vy91QzZPT0I4K2MzUlRGYVFDMWYyekFRb08vUmRaUEhlSW1p?=
 =?utf-8?B?TmMyWEFCbmswSVBtRk1GREVzQnk1N1VEZ1lIU1F1YzBFNit6RTg3MWVwTktY?=
 =?utf-8?B?alpwalJSOStndE9tYTN4Q2FMaWVJWTNRT3dtNFgyY3M4UzVmVXgrNkRrSHNp?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adb7ec8-acc8-4104-20e2-08da70bea86e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:29:00.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKKssXLxQ5tX8IUIeYpv6Iy6W4aUg51UvFL9nR2X2/njYEMVfFemOk4qVeXq21LD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2611
X-Proofpoint-GUID: C1E6soHNZTm_wGMvZoRHhqNvPvD8xeSq
X-Proofpoint-ORIG-GUID: C1E6soHNZTm_wGMvZoRHhqNvPvD8xeSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/27/22 11:29 AM, Daniel Müller wrote:
> The send_signal/send_signal_tracepoint is pretty flaky, with at least
> one failure in every ten runs on a few attempts I've tried it:
>    > test_send_signal_common:PASS:pipe_c2p 0 nsec
>    > test_send_signal_common:PASS:pipe_p2c 0 nsec
>    > test_send_signal_common:PASS:fork 0 nsec
>    > test_send_signal_common:PASS:skel_open_and_load 0 nsec
>    > test_send_signal_common:PASS:skel_attach 0 nsec
>    > test_send_signal_common:PASS:pipe_read 0 nsec
>    > test_send_signal_common:PASS:pipe_write 0 nsec
>    > test_send_signal_common:PASS:reading pipe 0 nsec
>    > test_send_signal_common:PASS:reading pipe error: size 0 0 nsec
>    > test_send_signal_common:FAIL:incorrect result unexpected incorrect result: actual 48 != expected 50
>    > test_send_signal_common:PASS:pipe_write 0 nsec
>    > #139/1   send_signal/send_signal_tracepoint:FAIL
> 
> The reason does not appear to be a correctness issue in the strict
> sense. Rather, we merely do not receive the signal we are waiting for
> within the provided timeout.
> Let's bump the timeout by a factor of ten. With that change I have not
> been able to reproduce the failure in 150+ iterations. I am also sneaking
> in a small simplification to the test_progs test selection logic.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>

Okay, this test has been improved *multiple* times to address its
flakiness. We tried very hard not to increase the runtime for it
so we don't increase overall test_progs run time. But looks like
we have to do it to make it robust. Hopefully such a 10x number
of iterations can finally address the flakiness issue.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
>   tools/testing/selftests/bpf/test_progs.c             | 7 ++-----
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index d71226e..d63a20 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -64,7 +64,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>   		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>   
>   		/* wait a little for signal handler */
> -		for (int i = 0; i < 100000000 && !sigusr1_received; i++)
> +		for (int i = 0; i < 1000000000 && !sigusr1_received; i++)
>   			j /= i + j + 1;
>   
>   		buf[0] = sigusr1_received ? '2' : '0';
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index c639f2e..3561c9 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1604,11 +1604,8 @@ int main(int argc, char **argv)
>   		struct prog_test_def *test = &prog_test_defs[i];
>   
>   		test->test_num = i + 1;
> -		if (should_run(&env.test_selector,
> -				test->test_num, test->test_name))
> -			test->should_run = true;
> -		else
> -			test->should_run = false;
> +		test->should_run = should_run(&env.test_selector,
> +					      test->test_num, test->test_name);
>   
>   		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
>   		    (test->run_test != NULL && test->run_serial_test != NULL)) {
