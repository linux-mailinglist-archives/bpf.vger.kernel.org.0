Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA350D907
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 07:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiDYF75 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 01:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiDYF7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 01:59:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389513915A
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 22:56:51 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P4vro8001429
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 22:56:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=sr44JpE49GOpDrxueMQITKsKYTbLk5fdTIkUJouGNG8=;
 b=HjuY9Tyh7ucadG5+RJ2M9azDxNSzQHtJ+St3xM6tb4o5gCsrUJi/pp9Fa8K72O0+V8uj
 DvcfABRl6Vuy4bWr775szFY6Up3rPaIDkZMM7qkXlyK20Un+kjjjZu7tdJcRF684kim4
 XCmQYAlG2khXp8YyycbSRr9lpYUsdW/ct1M= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmf5eyw96-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 22:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMH9RA+IpBv01kfDSCFsC38VaHLfwpv7xjcgrgnXhV/cyKTSTB9ff+RP3v7JINkggk1tIogTpulHUm/1jx/3XM4ckbIv/6bS2X9oCODNWRtAinsd3bkIAFSZ5GznmCbo31MdW+sgfG8B3CNZWtuCTpiIsK73+EAsJ0ZUTBxKFeYplEYR+pXs0utsR+B2BUnLt7m+H0kSihUIkzeg6ppDLWX4mxNgiWKNnLpC5oiQC4Zm+hF5mBan2QnvCbcFnTNkBLDNCTTj0eoeAc3mnUpTFrVxdaiac0Z1n2JkklJF8cGo1Sig9cYNltiGsjvVSS82gED1G5/7Ij6UWZ79P3y8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr44JpE49GOpDrxueMQITKsKYTbLk5fdTIkUJouGNG8=;
 b=XDnUC2Ga0RfWnqdyRDU5oNMfxE15aqWbFkAjswkrgETVSiS51OFPVGCnoviuUTs9TBX94CizVbASK9m0xDHNscHpTDO4PpQ0CZpHFjsuWzX5OFm2JBs9uWuFkDiuqUHRDu1czXB7TryJlTsLH7KrGRs81E48lmps1AUQX8MYvsjm+kc19nw70XqmKg/wQ3akXM2RqP1e/Q9AbUp6r9hfodm6LaPqqUig6n3lxXhtFZs3c/PB5AhgzfltQXKyi/SmCH/EQhj1v6fTLFV3qDkhzwAeK7o+I8CbpGxeMTUE0ifW7/NTTTefQIPFU0QW9pZSMIcWkLyr8tMQwHXjH+ak7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by BN8PR15MB3475.namprd15.prod.outlook.com (2603:10b6:408:a0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 05:56:45 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::c4de:9c08:cddc:8c76]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::c4de:9c08:cddc:8c76%3]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 05:56:45 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Mykola Lysenko <mykolal@fb.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: add granular subtest output for
 prog_test
Thread-Topic: [PATCH bpf-next] bpf/selftests: add granular subtest output for
 prog_test
Thread-Index: AQHYWGDrNk94xJELDkyd+CfCIX6VPa0AIbkA
Date:   Mon, 25 Apr 2022 05:56:45 +0000
Message-ID: <CE3D894D-D2A7-432B-BEB5-5207A997EEBF@fb.com>
References: <20220425045642.3978269-1-mykolal@fb.com>
In-Reply-To: <20220425045642.3978269-1-mykolal@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff4f0fb6-07f0-4dc3-b289-08da268060fc
x-ms-traffictypediagnostic: BN8PR15MB3475:EE_
x-microsoft-antispam-prvs: <BN8PR15MB34754506887C5D7CC9E4651FC0F89@BN8PR15MB3475.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+BGsQ8fh7aDHzvcSbHOisKy8A4tpa1nyZKGP9oeFmcKrMD/eKjkZcUVc30JWmvTz4lbW+DskaxEeJ1LyKrbff3pQvHo9RUXjvq7I93KxHzcaGehxfjv3SbkTQu0e9Hj69ykIm8sEmVO6yOXmXX3JJFGsyyq+0E74DHs3nY4QTJps3uSY+WmMoWkJoVDBZER2azVXJMwGyAZUbiOgie1areZhrvVClI3zRTEPI71liIe3wtqKiZRv7j3o6hN+28uLEMh3YOLvAWuCVfttkQrCmqeljpeAIHw/1a8IJa90NfCD7Vzl3dD+wuFp/AWldh2wW2Y4poVkZiJW1wEZbzdKQAsQr8zE0/B76VKHT+/rdMJR2TzZcsp3LeOyWwwIXmj4X/WBm8UsS3WM3pbZvD8wFlRcvsiUZYuXuy4VuGpcB0SJuUJZjZmhczR+Oht0pa6lvKrthjhDYZrr/8upUuPWzKygP9dsIRtF8yDUysTI+CbRAfCtPThHA8oPFkvfNoR3FYZfaPait4/SpWKQ8mf8cEeT6lcPS94aGllcSR4dzp23mC7E7dyCTb7ZJidbCVQngRSRH18AHydU2KhiY+CCqV01NCavGqP75UtFoVLTMxk090zDIn5/A3jA2jhcHgfEzbebnvQyxY0LIwqH9EIUlxjC7tx7ekMLMNnFprjoy34Y0LzofPcN4LhYlPLdADuCHgHFst4xbpOCfQ8d1fYmWwvOEMGdCQchrj1JB910+rUIMJrjZ5VeWR8B3PEDu0l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(2906002)(36756003)(33656002)(66946007)(122000001)(38100700002)(53546011)(71200400001)(5660300002)(76116006)(91956017)(316002)(54906003)(6486002)(110136005)(508600001)(8676002)(83380400001)(86362001)(6512007)(6506007)(8936002)(30864003)(66556008)(66446008)(4326008)(66476007)(64756008)(186003)(2616005)(45980500001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sS/Zc2xKOsNtKeip6tZZEJImIeyqXb+HfrhwxvldIlVvpFJvqb1xlmByQFav?=
 =?us-ascii?Q?2eIUFcP9WuPo/uguDSSt4pNuX4nFCQEcwAfZe093Ie5O78mOydkKf9ZP0fki?=
 =?us-ascii?Q?b9qSmnbG3ukgmNVgZFX5/g13YaK5zDs+LF8jMJFTiw4Vh8o0OMo0LFF1HZ2o?=
 =?us-ascii?Q?IsmMpQ9no6QivsFUb4CjCIIeTWY0rsLUL3ehEkmCe/SOPvm9U0SU7KcbwRKl?=
 =?us-ascii?Q?JMOwIzFMNJ/xR/uQJfrqWFFUnwT1vS3JD9IcCdAtJi6+vlKDnlar6q6NbzFT?=
 =?us-ascii?Q?dxyu1yyh/vVCN46+ratj4ft/oPu60JcE3cEFpcB6A18u+R3vTwazTNslwgbq?=
 =?us-ascii?Q?wQ441nAxqUjOm3ffxOZ1v30oAZrnSaXdRxVfw5Wxjv0x55mR0GwR/LhI4jsU?=
 =?us-ascii?Q?umTP/ht4SOfs98yM/Q/HRN1DMY1jopG78a8vJW5ZDtFZt3D2MYyRAl9dStsJ?=
 =?us-ascii?Q?GN/uzy9P9WPdIK+Q9lqziUcAMRvvQI2dTtwEiGF0SqJPB8HdKP1jzt7MJYBi?=
 =?us-ascii?Q?F4RupViSjnNq66AFAsjkz0cWLVgdvfBr1DMfX7+xXEBjd3iXGZuyLTiks1VT?=
 =?us-ascii?Q?urq+YF0oRfWzYgWYFBGTVoxM1Fl/8vuax50o6xLB5TvCJZAg7kVLQdBUgsed?=
 =?us-ascii?Q?ZusuNBpExexzstWAhDEmodO3N/kyde6qWIeqo7Ij+SFhakjVbCinw3+dOII4?=
 =?us-ascii?Q?01X1qfbuEzu5p+QngiaBXviAlcV4Ia0BkZ44pmg4euYBVLwRyKqIqPKaB4x1?=
 =?us-ascii?Q?JdFXcnsbeYLf1aZfL8zHf7IottbRqEtMPTV673OyrlJhZlV8OyKDa4+cjhHw?=
 =?us-ascii?Q?jCj6HVvDcZgU+OHDxbaOtJMNXqHa/CvK4tLHMhPBni4coC7vDk/xw/TXsmsD?=
 =?us-ascii?Q?RIDSrKnzawu/i/Qygichi3uxQ/DwEIbNXP+b/aS1CDuiRhWgxAmLOX6a+NKV?=
 =?us-ascii?Q?gawE/GZbJaxbKtlV1k9kLxXK5WdnOFfMboc/A7OShJwC0hPxoW86CPuxSEoz?=
 =?us-ascii?Q?MBdDzEY36beJqTUlFvJPtYOENpOCvD3SyoUR88dRvmRb7bUiI7+ZRtfdfUCx?=
 =?us-ascii?Q?Wtxpw/3bgKzC666lTvkMY/mVG/3e6Fvyn7fbx3CTNA5dHtYVEKG0lBJhpGs7?=
 =?us-ascii?Q?qNBTYU1ofepneTu3tM+qVJPurhhB+LJSsHddkm9qA2k87DLVPuVusR8GZpdy?=
 =?us-ascii?Q?oR2NnQSkW2+L1jvXkTH9gA6h5IrQAHS/vB2Kmj6GqtFwjWRk+y8529vj0HD2?=
 =?us-ascii?Q?znenn6eoOuw8C3wcP1/+8ftLIAvTsBCBBLhlA0P5w0KIu4jIifC9Yny3VITN?=
 =?us-ascii?Q?DOvSPQREeprbXtrn0gPZHPm8BnXL6pMLOvAYnVJQRN0AOgjxwCgaRbEe38d6?=
 =?us-ascii?Q?PAWIwgJ5mlJ290szMxgEUCpwoetdjDBgjBU0Hgg3awyBnGWu4P37TJ3FlZ+O?=
 =?us-ascii?Q?Odh4Rdj6yH1K1J9cFo6hhV4lx6B/PgeeGV/IyQ14puZMPDf6WPb11H4vADsS?=
 =?us-ascii?Q?FMbV3eYVItoZaR6ReYdVTFhuXNVSLj74wHlcWs78aDtIwPR9tSaYmJpSMb7w?=
 =?us-ascii?Q?aBRggu8huDRJ5Wb/y71cu1c0HHkbsVjDJdAzT1pSFzjUE0+N/952HfTKqmmZ?=
 =?us-ascii?Q?Ctg1eesj1ZCNQgL71uC2/F/G1YBGRdPE/MMCS4kCIe7N6XrGdd93Z0TuJ+jF?=
 =?us-ascii?Q?I8pGt/GZWevNnR5/3SOfZVfQJ1kc7fRLyXU5vxvEpqqKBSF6Qmc6xUeiDt3D?=
 =?us-ascii?Q?9YlgrCUwkcMmee4jSOWBIPkRVXg+adFtkYLsOfLpn/auvDFslunw?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCCAEE812A421B4F919AEC765A5B8912@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4f0fb6-07f0-4dc3-b289-08da268060fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 05:56:45.0720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWGZpqKemaeGQQn5uQmkKSxZqi8HbMLZZ1Ck9bOxPvcIWw1YAHrllUK5dKCRdkws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3475
X-Proofpoint-GUID: axAp1DwVFuWn1oARiny5xYUesxc4kXVG
X-Proofpoint-ORIG-GUID: axAp1DwVFuWn1oARiny5xYUesxc4kXVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_01,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Skip for now. Going to debug what is going on with CI running this patch with noalu32 on z15

> On Apr 24, 2022, at 9:56 PM, Mykola Lysenko <mykolal@fb.com> wrote:
> 
> Implement per subtest log collection for both parallel
> and sequential test execution. This allows granular
> per-subtest error output in the 'All error logs' section.
> Add subtest log transfer into the protocol during the
> parallel test execution.
> 
> Move all test log printing logic into dump_test_log
> function. One exception is the output of test names when
> verbose printing is enabled. Move test name/result
> printing into separate functions to avoid repetition.
> 
> Print all successful subtest results in the log. Print
> only failed test logs when test does not have subtests.
> Or only failed subtests' logs when test has subtests.
> 
> Disable 'All error logs' output when verbose mode is
> enabled. This functionality was already broken and is
> causing confusion.
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---
> tools/testing/selftests/bpf/test_progs.c | 639 +++++++++++++++++------
> tools/testing/selftests/bpf/test_progs.h |  35 +-
> 2 files changed, 498 insertions(+), 176 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index c536d1d29d57..375e10576336 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -18,6 +18,90 @@
> #include <sys/socket.h>
> #include <sys/un.h>
> 
> +static bool verbose(void)
> +{
> +	return env.verbosity > VERBOSE_NONE;
> +}
> +
> +static void stdio_hijack_init(char **log_buf, size_t *log_cnt)
> +{
> +#ifdef __GLIBC__
> +	if (verbose() && env.worker_id == -1) {
> +		/* nothing to do, output to stdout by default */
> +		return;
> +	}
> +
> +	fflush(stdout);
> +	fflush(stderr);
> +
> +	stdout = open_memstream(log_buf, log_cnt);
> +	if (!stdout) {
> +		stdout = env.stdout;
> +		perror("open_memstream");
> +		return;
> +	}
> +
> +	if (env.subtest_state)
> +		env.subtest_state->stdout = stdout;
> +	else
> +		env.test_state->stdout = stdout;
> +
> +	stderr = stdout;
> +#endif
> +}
> +
> +static void stdio_hijack(char **log_buf, size_t *log_cnt)
> +{
> +#ifdef __GLIBC__
> +	if (verbose() && env.worker_id == -1) {
> +		/* nothing to do, output to stdout by default */
> +		return;
> +	}
> +
> +	env.stdout = stdout;
> +	env.stderr = stderr;
> +
> +	stdio_hijack_init(log_buf, log_cnt);
> +#endif
> +}
> +
> +static void stdio_restore_cleanup(void)
> +{
> +#ifdef __GLIBC__
> +	if (verbose() && env.worker_id == -1) {
> +		/* nothing to do, output to stdout by default */
> +		return;
> +	}
> +
> +	fflush(stdout);
> +
> +	if (env.subtest_state) {
> +		fclose(env.subtest_state->stdout);
> +		stdout = env.test_state->stdout;
> +	} else {
> +		fclose(env.test_state->stdout);
> +	}
> +#endif
> +}
> +
> +static void stdio_restore(void)
> +{
> +#ifdef __GLIBC__
> +	if (verbose() && env.worker_id == -1) {
> +		/* nothing to do, output to stdout by default */
> +		return;
> +	}
> +
> +	if (stdout == env.stdout)
> +		return;
> +
> +	stdio_restore_cleanup();
> +
> +	stdout = env.stdout;
> +	stderr = env.stderr;
> +#endif
> +}
> +
> /* Adapted from perf/util/string.c */
> static bool glob_match(const char *str, const char *pat)
> {
> @@ -130,30 +214,96 @@ static bool should_run_subtest(struct test_selector *sel,
> 	return subtest_num < subtest_sel->num_set_len && subtest_sel->num_set[subtest_num];
> }
> 
> +static char *test_result(bool failed, bool skipped)
> +{
> +	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
> +}
> +
> +static void print_test_log(char *log_buf, size_t log_cnt)
> +{
> +	log_buf[log_cnt] = '\0';
> +	fprintf(env.stdout, "%s", log_buf);
> +	if (log_buf[log_cnt - 1] != '\n')
> +		fprintf(env.stdout, "\n");
> +}
> +
> +static void print_test_name(int test_num, const char *test_name, char *result)
> +{
> +	fprintf(env.stdout, "#%-9d %s", test_num, test_name);
> +
> +	if (result)
> +		fprintf(env.stdout, ":%s", result);
> +
> +	fprintf(env.stdout, "\n");
> +}
> +
> +static void print_subtest_name(int test_num, int subtest_num,
> +			       const char *test_name, char *subtest_name,
> +			       char *result)
> +{
> +	fprintf(env.stdout, "#%-3d/%-5d %s/%s",
> +		test_num, subtest_num,
> +		test_name, subtest_name);
> +
> +	if (result)
> +		fprintf(env.stdout, ":%s", result);
> +
> +	fprintf(env.stdout, "\n");
> +}
> +
> static void dump_test_log(const struct prog_test_def *test,
> 			  const struct test_state *test_state,
> -			  bool force_failed)
> +			  bool skip_ok_subtests,
> +			  bool par_exec_result)
> {
> -	bool failed = test_state->error_cnt > 0 || force_failed;
> +	bool test_failed = test_state->error_cnt > 0;
> +	bool force_log = test_state->force_log;
> +	bool print_test = verbose() || force_log || test_failed;
> +	int i;
> +	struct subtest_state *subtest_state;
> +	bool subtest_failed;
> +	bool print_subtest;
> 
> -	/* worker always holds log */
> +	/* we do not print anything in the worker thread */
> 	if (env.worker_id != -1)
> 		return;
> 
> -	fflush(stdout); /* exports test_state->log_buf & test_state->log_cnt */
> +	/* there is nothing to print when verbose log is used and execution
> +	 * is not in parallel mode
> +	 */
> +	if (verbose() && !par_exec_result)
> +		return;
> +
> +	if (test_state->subtest_num || print_test)
> +		print_test_name(test->test_num, test->test_name, NULL);
> +
> +	if (test_state->log_cnt && print_test)
> +		print_test_log(test_state->log_buf, test_state->log_cnt);
> 
> -	fprintf(env.stdout, "#%-3d %s:%s\n",
> -		test->test_num, test->test_name,
> -		failed ? "FAIL" : (test_state->skip_cnt ? "SKIP" : "OK"));
> +	for (i = 0; i < test_state->subtest_num; i++) {
> +		subtest_state = &test_state->subtest_states[i];
> +		subtest_failed = subtest_state->error_cnt;
> +		print_subtest = verbose() || force_log || subtest_failed;
> 
> -	if (env.verbosity > VERBOSE_NONE || test_state->force_log || failed) {
> -		if (test_state->log_cnt) {
> -			test_state->log_buf[test_state->log_cnt] = '\0';
> -			fprintf(env.stdout, "%s", test_state->log_buf);
> -			if (test_state->log_buf[test_state->log_cnt - 1] != '\n')
> -				fprintf(env.stdout, "\n");
> +		if (skip_ok_subtests && !subtest_failed)
> +			continue;
> +
> +		if (subtest_state->log_cnt && print_subtest) {
> +			print_subtest_name(test->test_num, i + 1,
> +					   test->test_name, subtest_state->name,
> +					   NULL);
> +			print_test_log(subtest_state->log_buf,
> +				       subtest_state->log_cnt);
> 		}
> +
> +		print_subtest_name(test->test_num, i + 1,
> +				   test->test_name, subtest_state->name,
> +				   test_result(subtest_state->error_cnt,
> +					       subtest_state->skipped));
> 	}
> +
> +	print_test_name(test->test_num, test->test_name,
> +			test_result(test_failed, test_state->skip_cnt));
> }
> 
> static void stdio_restore(void);
> @@ -205,35 +355,50 @@ static void restore_netns(void)
> void test__end_subtest(void)
> {
> 	struct prog_test_def *test = env.test;
> -	struct test_state *state = env.test_state;
> -	int sub_error_cnt = state->error_cnt - state->old_error_cnt;
> -
> -	fprintf(stdout, "#%d/%d %s/%s:%s\n",
> -	       test->test_num, state->subtest_num, test->test_name, state->subtest_name,
> -	       sub_error_cnt ? "FAIL" : (state->subtest_skip_cnt ? "SKIP" : "OK"));
> -
> -	if (sub_error_cnt == 0) {
> -		if (state->subtest_skip_cnt == 0) {
> -			state->sub_succ_cnt++;
> -		} else {
> -			state->subtest_skip_cnt = 0;
> -			state->skip_cnt++;
> -		}
> +	struct test_state *test_state = env.test_state;
> +	struct subtest_state *subtest_state = env.subtest_state;
> +
> +	if (subtest_state->error_cnt) {
> +		test_state->error_cnt++;
> +	} else {
> +		if (!subtest_state->skipped)
> +			test_state->sub_succ_cnt++;
> +		else
> +			test_state->skip_cnt++;
> 	}
> 
> -	free(state->subtest_name);
> -	state->subtest_name = NULL;
> +	if (verbose() && !env.workers)
> +		print_subtest_name(test->test_num, test_state->subtest_num,
> +				   test->test_name, subtest_state->name,
> +				   test_result(subtest_state->error_cnt,
> +					       subtest_state->skipped));
> +
> +	stdio_restore_cleanup();
> +	env.subtest_state = NULL;
> }
> 
> bool test__start_subtest(const char *subtest_name)
> {
> 	struct prog_test_def *test = env.test;
> 	struct test_state *state = env.test_state;
> +	struct subtest_state *subtest_state;
> +	size_t sub_state_size = sizeof(*subtest_state);
> 
> -	if (state->subtest_name)
> +	if (env.subtest_state)
> 		test__end_subtest();
> 
> 	state->subtest_num++;
> +	state->subtest_states =
> +		realloc(state->subtest_states,
> +			state->subtest_num * sub_state_size);
> +	if (!state->subtest_states) {
> +		fprintf(stderr, "Not enough memory to allocate subtest result\n");
> +		return false;
> +	}
> +
> +	subtest_state = &state->subtest_states[state->subtest_num - 1];
> +
> +	memset(subtest_state, 0, sub_state_size);
> 
> 	if (!subtest_name || !subtest_name[0]) {
> 		fprintf(env.stderr,
> @@ -242,21 +407,30 @@ bool test__start_subtest(const char *subtest_name)
> 		return false;
> 	}
> 
> +	subtest_state->name = strdup(subtest_name);
> +	if (!subtest_state->name) {
> +		fprintf(env.stderr,
> +			"Subtest #%d: failed to copy subtest name!\n",
> +			state->subtest_num);
> +		return false;
> +	}
> +
> 	if (!should_run_subtest(&env.test_selector,
> 				&env.subtest_selector,
> 				state->subtest_num,
> 				test->test_name,
> -				subtest_name))
> -		return false;
> -
> -	state->subtest_name = strdup(subtest_name);
> -	if (!state->subtest_name) {
> -		fprintf(env.stderr,
> -			"Subtest #%d: failed to copy subtest name!\n",
> -			state->subtest_num);
> +				subtest_name)) {
> +		subtest_state->skipped = true;
> 		return false;
> 	}
> -	state->old_error_cnt = state->error_cnt;
> +
> +	env.subtest_state = subtest_state;
> +	stdio_hijack_init(&subtest_state->log_buf, &subtest_state->log_cnt);
> +
> +	if (verbose() && !env.workers)
> +		print_subtest_name(test->test_num, state->subtest_num,
> +				   test->test_name, subtest_state->name,
> +				   NULL);
> 
> 	return true;
> }
> @@ -268,15 +442,18 @@ void test__force_log(void)
> 
> void test__skip(void)
> {
> -	if (env.test_state->subtest_name)
> -		env.test_state->subtest_skip_cnt++;
> +	if (env.subtest_state)
> +		env.subtest_state->skipped = true;
> 	else
> 		env.test_state->skip_cnt++;
> }
> 
> void test__fail(void)
> {
> -	env.test_state->error_cnt++;
> +	if (env.subtest_state)
> +		env.subtest_state->error_cnt++;
> +	else
> +		env.test_state->error_cnt++;
> }
> 
> int test__join_cgroup(const char *path)
> @@ -455,14 +632,14 @@ static void unload_bpf_testmod(void)
> 		fprintf(env.stderr, "Failed to trigger kernel-side RCU sync!\n");
> 	if (delete_module("bpf_testmod", 0)) {
> 		if (errno == ENOENT) {
> -			if (env.verbosity > VERBOSE_NONE)
> +			if (verbose())
> 				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> 			return;
> 		}
> 		fprintf(env.stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> 		return;
> 	}
> -	if (env.verbosity > VERBOSE_NONE)
> +	if (verbose())
> 		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> }
> 
> @@ -473,7 +650,7 @@ static int load_bpf_testmod(void)
> 	/* ensure previous instance of the module is unloaded */
> 	unload_bpf_testmod();
> 
> -	if (env.verbosity > VERBOSE_NONE)
> +	if (verbose())
> 		fprintf(stdout, "Loading bpf_testmod.ko...\n");
> 
> 	fd = open("bpf_testmod.ko", O_RDONLY);
> @@ -488,7 +665,7 @@ static int load_bpf_testmod(void)
> 	}
> 	close(fd);
> 
> -	if (env.verbosity > VERBOSE_NONE)
> +	if (verbose())
> 		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
> 	return 0;
> }
> @@ -655,7 +832,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
> 			}
> 		}
> 
> -		if (env->verbosity > VERBOSE_NONE) {
> +		if (verbose()) {
> 			if (setenv("SELFTESTS_VERBOSE", "1", 1) == -1) {
> 				fprintf(stderr,
> 					"Unable to setenv SELFTESTS_VERBOSE=1 (errno=%d)",
> @@ -696,44 +873,6 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
> 	return 0;
> }
> 
> -static void stdio_hijack(char **log_buf, size_t *log_cnt)
> -{
> -#ifdef __GLIBC__
> -	env.stdout = stdout;
> -	env.stderr = stderr;
> -
> -	if (env.verbosity > VERBOSE_NONE && env.worker_id == -1) {
> -		/* nothing to do, output to stdout by default */
> -		return;
> -	}
> -
> -	/* stdout and stderr -> buffer */
> -	fflush(stdout);
> -
> -	stdout = open_memstream(log_buf, log_cnt);
> -	if (!stdout) {
> -		stdout = env.stdout;
> -		perror("open_memstream");
> -		return;
> -	}
> -
> -	stderr = stdout;
> -#endif
> -}
> -
> -static void stdio_restore(void)
> -{
> -#ifdef __GLIBC__
> -	if (stdout == env.stdout)
> -		return;
> -
> -	fclose(stdout);
> -
> -	stdout = env.stdout;
> -	stderr = env.stderr;
> -#endif
> -}
> -
> /*
>  * Determine if test_progs is running as a "flavored" test runner and switch
>  * into corresponding sub-directory to load correct BPF objects.
> @@ -759,7 +898,7 @@ int cd_flavor_subdir(const char *exec_name)
> 	if (!flavor)
> 		return 0;
> 	flavor++;
> -	if (env.verbosity > VERBOSE_NONE)
> +	if (verbose())
> 		fprintf(stdout,	"Switching to flavor '%s' subdirectory...\n", flavor);
> 
> 	return chdir(flavor);
> @@ -812,8 +951,10 @@ void crash_handler(int signum)
> 
> 	sz = backtrace(bt, ARRAY_SIZE(bt));
> 
> -	if (env.test)
> -		dump_test_log(env.test, env.test_state, true);
> +	if (env.test) {
> +		env.test_state->error_cnt++;
> +		dump_test_log(env.test, env.test_state, true, false);
> +	}
> 	if (env.stdout)
> 		stdio_restore();
> 	if (env.worker_id != -1)
> @@ -839,13 +980,18 @@ static inline const char *str_msg(const struct msg *msg, char *buf)
> {
> 	switch (msg->type) {
> 	case MSG_DO_TEST:
> -		sprintf(buf, "MSG_DO_TEST %d", msg->do_test.test_num);
> +		sprintf(buf, "MSG_DO_TEST %d", msg->do_test.num);
> 		break;
> 	case MSG_TEST_DONE:
> 		sprintf(buf, "MSG_TEST_DONE %d (log: %d)",
> -			msg->test_done.test_num,
> +			msg->test_done.num,
> 			msg->test_done.have_log);
> 		break;
> +	case MSG_SUBTEST_DONE:
> +		sprintf(buf, "MSG_SUBTEST_DONE %d (log: %d)",
> +			msg->subtest_done.num,
> +			msg->subtest_done.have_log);
> +		break;
> 	case MSG_TEST_LOG:
> 		sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
> 			strlen(msg->test_log.log_buf),
> @@ -895,18 +1041,23 @@ static void run_one_test(int test_num)
> 
> 	stdio_hijack(&state->log_buf, &state->log_cnt);
> 
> +	if (verbose() && env.worker_id == -1)
> +		print_test_name(test_num + 1, test->test_name, NULL);
> +
> 	if (test->run_test)
> 		test->run_test();
> 	else if (test->run_serial_test)
> 		test->run_serial_test();
> 
> 	/* ensure last sub-test is finalized properly */
> -	if (state->subtest_name)
> +	if (env.subtest_state)
> 		test__end_subtest();
> 
> 	state->tested = true;
> 
> -	dump_test_log(test, state, false);
> +	if (verbose() && env.worker_id == -1)
> +		print_test_name(test_num + 1, test->test_name,
> +				test_result(state->error_cnt, state->skip_cnt));
> 
> 	reset_affinity();
> 	restore_netns();
> @@ -914,6 +1065,8 @@ static void run_one_test(int test_num)
> 		cleanup_cgroup_environment();
> 
> 	stdio_restore();
> +
> +	dump_test_log(test, state, false, false);
> }
> 
> struct dispatch_data {
> @@ -921,6 +1074,73 @@ struct dispatch_data {
> 	int sock_fd;
> };
> 
> +static int read_prog_test_msg(int sock_fd, struct msg *msg, enum msg_type type)
> +{
> +	if (recv_message(sock_fd, msg) < 0)
> +		return 1;
> +
> +	if (msg->type != type) {
> +		printf("%s: unexpected message type %d. expected %d\n", __func__, msg->type, type);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dispatch_thread_read_log(int sock_fd, char **log_buf, size_t *log_cnt)
> +{
> +	FILE *log_fp = NULL;
> +
> +	log_fp = open_memstream(log_buf, log_cnt);
> +	if (!log_fp)
> +		return 1;
> +
> +	while (true) {
> +		struct msg msg;
> +
> +		if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_LOG))
> +			return 1;
> +
> +		fprintf(log_fp, "%s", msg.test_log.log_buf);
> +		if (msg.test_log.is_last)
> +			break;
> +	}
> +	fclose(log_fp);
> +	log_fp = NULL;
> +	return 0;
> +}
> +
> +static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
> +{
> +	struct msg msg;
> +	struct subtest_state *subtest_state;
> +	int subtest_num = state->subtest_num;
> +
> +	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
> +
> +	for (int i = 0; i < subtest_num; i++) {
> +		subtest_state = &state->subtest_states[i];
> +
> +		memset(subtest_state, 0, sizeof(*subtest_state));
> +
> +		if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
> +			return 1;
> +
> +		subtest_state->name = strdup(msg.subtest_done.name);
> +		subtest_state->error_cnt = msg.subtest_done.error_cnt;
> +		subtest_state->skipped = msg.subtest_done.skipped;
> +
> +		/* collect all logs */
> +		if (msg.subtest_done.have_log)
> +			if (dispatch_thread_read_log(sock_fd,
> +						     &subtest_state->log_buf,
> +						     &subtest_state->log_cnt))
> +				return 1;
> +	}
> +
> +	return 0;
> +}
> +
> static void *dispatch_thread(void *ctx)
> {
> 	struct dispatch_data *data = ctx;
> @@ -957,8 +1177,9 @@ static void *dispatch_thread(void *ctx)
> 		{
> 			struct msg msg_do_test;
> 
> +			memset(&msg_do_test, 0, sizeof(msg_do_test));
> 			msg_do_test.type = MSG_DO_TEST;
> -			msg_do_test.do_test.test_num = test_to_run;
> +			msg_do_test.do_test.num = test_to_run;
> 			if (send_message(sock_fd, &msg_do_test) < 0) {
> 				perror("Fail to send command");
> 				goto done;
> @@ -967,49 +1188,39 @@ static void *dispatch_thread(void *ctx)
> 		}
> 
> 		/* wait for test done */
> -		{
> -			int err;
> -			struct msg msg_test_done;
> +		do {
> +			struct msg msg;
> 
> -			err = recv_message(sock_fd, &msg_test_done);
> -			if (err < 0)
> +			if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_DONE))
> 				goto error;
> -			if (msg_test_done.type != MSG_TEST_DONE)
> -				goto error;
> -			if (test_to_run != msg_test_done.test_done.test_num)
> +			if (test_to_run != msg.test_done.num)
> 				goto error;
> 
> 			state = &test_states[test_to_run];
> 			state->tested = true;
> -			state->error_cnt = msg_test_done.test_done.error_cnt;
> -			state->skip_cnt = msg_test_done.test_done.skip_cnt;
> -			state->sub_succ_cnt = msg_test_done.test_done.sub_succ_cnt;
> +			state->error_cnt = msg.test_done.error_cnt;
> +			state->skip_cnt = msg.test_done.skip_cnt;
> +			state->sub_succ_cnt = msg.test_done.sub_succ_cnt;
> +			state->subtest_num = msg.test_done.subtest_num;
> 
> 			/* collect all logs */
> -			if (msg_test_done.test_done.have_log) {
> -				log_fp = open_memstream(&state->log_buf, &state->log_cnt);
> -				if (!log_fp)
> +			if (msg.test_done.have_log) {
> +				if (dispatch_thread_read_log(sock_fd,
> +							     &state->log_buf,
> +							     &state->log_cnt))
> 					goto error;
> +			}
> 
> -				while (true) {
> -					struct msg msg_log;
> -
> -					if (recv_message(sock_fd, &msg_log) < 0)
> -						goto error;
> -					if (msg_log.type != MSG_TEST_LOG)
> -						goto error;
> +			/* collect all subtests and subtest logs */
> +			if (!state->subtest_num)
> +				break;
> 
> -					fprintf(log_fp, "%s", msg_log.test_log.log_buf);
> -					if (msg_log.test_log.is_last)
> -						break;
> -				}
> -				fclose(log_fp);
> -				log_fp = NULL;
> -			}
> -		} /* wait for test done */
> +			if (dispatch_thread_send_subtests(sock_fd, state))
> +				goto error;
> +		} while (false);
> 
> 		pthread_mutex_lock(&stdout_output_lock);
> -		dump_test_log(test, state, false);
> +		dump_test_log(test, state, false, true);
> 		pthread_mutex_unlock(&stdout_output_lock);
> 	} /* while (true) */
> error:
> @@ -1052,18 +1263,24 @@ static void calculate_summary_and_print_errors(struct test_env *env)
> 			succ_cnt++;
> 	}
> 
> -	if (fail_cnt)
> +	/*
> +	 * We only print error logs summary when there are failed tests and
> +	 * verbose mode is not enabled. Otherwise, results may be incosistent.
> +	 *
> +	 */
> +	if (!verbose() && fail_cnt) {
> 		printf("\nAll error logs:\n");
> 
> -	/* print error logs again */
> -	for (i = 0; i < prog_test_cnt; i++) {
> -		struct prog_test_def *test = &prog_test_defs[i];
> -		struct test_state *state = &test_states[i];
> +		/* print error logs again */
> +		for (i = 0; i < prog_test_cnt; i++) {
> +			struct prog_test_def *test = &prog_test_defs[i];
> +			struct test_state *state = &test_states[i];
> 
> -		if (!state->tested || !state->error_cnt)
> -			continue;
> +			if (!state->tested || !state->error_cnt)
> +				continue;
> 
> -		dump_test_log(test, state, true);
> +			dump_test_log(test, state, true, true);
> +		}
> 	}
> 
> 	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> @@ -1154,6 +1371,90 @@ static void server_main(void)
> 	}
> }
> 
> +static void worker_main_send_log(int sock, char *log_buf, size_t log_cnt)
> +{
> +	char *src;
> +	size_t slen;
> +
> +	src = log_buf;
> +	slen = log_cnt;
> +	while (slen) {
> +		struct msg msg_log;
> +		char *dest;
> +		size_t len;
> +
> +		memset(&msg_log, 0, sizeof(msg_log));
> +		msg_log.type = MSG_TEST_LOG;
> +		dest = msg_log.test_log.log_buf;
> +		len = slen >= MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
> +		memcpy(dest, src, len);
> +
> +		src += len;
> +		slen -= len;
> +		if (!slen)
> +			msg_log.test_log.is_last = true;
> +
> +		assert(send_message(sock, &msg_log) >= 0);
> +	}
> +}
> +
> +static void free_subtest_state(struct subtest_state *state)
> +{
> +	if (state->log_buf) {
> +		free(state->log_buf);
> +		state->log_buf = NULL;
> +		state->log_cnt = 0;
> +	}
> +	free(state->name);
> +	state->name = NULL;
> +}
> +
> +static int worker_main_send_subtests(int sock, struct test_state *state)
> +{
> +	int i, result = 0;
> +	struct msg msg;
> +	struct subtest_state *subtest_state;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.type = MSG_SUBTEST_DONE;
> +
> +	for (i = 0; i < state->subtest_num; i++) {
> +		subtest_state = &state->subtest_states[i];
> +
> +		msg.subtest_done.num = i;
> +
> +		strncpy(msg.subtest_done.name, subtest_state->name, MAX_SUBTEST_NAME);
> +
> +		msg.subtest_done.error_cnt = subtest_state->error_cnt;
> +		msg.subtest_done.skipped = subtest_state->skipped;
> +		msg.subtest_done.have_log = false;
> +
> +		if (verbose() || state->force_log || subtest_state->error_cnt) {
> +			if (subtest_state->log_cnt)
> +				msg.subtest_done.have_log = true;
> +		}
> +
> +		if (send_message(sock, &msg) < 0) {
> +			perror("Fail to send message done");
> +			result = 1;
> +			goto out;
> +		}
> +
> +		/* send logs */
> +		if (msg.subtest_done.have_log)
> +			worker_main_send_log(sock, subtest_state->log_buf, subtest_state->log_cnt);
> +
> +		free_subtest_state(subtest_state);
> +		free(subtest_state->name);
> +	}
> +
> +out:
> +	for (; i < state->subtest_num; i++)
> +		free_subtest_state(&state->subtest_states[i]);
> +	free(state->subtest_states);
> +	return result;
> +}
> +
> static int worker_main(int sock)
> {
> 	save_netns();
> @@ -1172,10 +1473,10 @@ static int worker_main(int sock)
> 					env.worker_id);
> 			goto out;
> 		case MSG_DO_TEST: {
> -			int test_to_run = msg.do_test.test_num;
> +			int test_to_run = msg.do_test.num;
> 			struct prog_test_def *test = &prog_test_defs[test_to_run];
> 			struct test_state *state = &test_states[test_to_run];
> -			struct msg msg_done;
> +			struct msg msg;
> 
> 			if (env.debug)
> 				fprintf(stderr, "[%d]: #%d:%s running.\n",
> @@ -1185,54 +1486,38 @@ static int worker_main(int sock)
> 
> 			run_one_test(test_to_run);
> 
> -			memset(&msg_done, 0, sizeof(msg_done));
> -			msg_done.type = MSG_TEST_DONE;
> -			msg_done.test_done.test_num = test_to_run;
> -			msg_done.test_done.error_cnt = state->error_cnt;
> -			msg_done.test_done.skip_cnt = state->skip_cnt;
> -			msg_done.test_done.sub_succ_cnt = state->sub_succ_cnt;
> -			msg_done.test_done.have_log = false;
> +			memset(&msg, 0, sizeof(msg));
> +			msg.type = MSG_TEST_DONE;
> +			msg.test_done.num = test_to_run;
> +			msg.test_done.error_cnt = state->error_cnt;
> +			msg.test_done.skip_cnt = state->skip_cnt;
> +			msg.test_done.sub_succ_cnt = state->sub_succ_cnt;
> +			msg.test_done.subtest_num = state->subtest_num;
> +			msg.test_done.have_log = false;
> 
> -			if (env.verbosity > VERBOSE_NONE || state->force_log || state->error_cnt) {
> +			if (verbose() || state->force_log || state->error_cnt) {
> 				if (state->log_cnt)
> -					msg_done.test_done.have_log = true;
> +					msg.test_done.have_log = true;
> 			}
> -			if (send_message(sock, &msg_done) < 0) {
> +			if (send_message(sock, &msg) < 0) {
> 				perror("Fail to send message done");
> 				goto out;
> 			}
> 
> 			/* send logs */
> -			if (msg_done.test_done.have_log) {
> -				char *src;
> -				size_t slen;
> -
> -				src = state->log_buf;
> -				slen = state->log_cnt;
> -				while (slen) {
> -					struct msg msg_log;
> -					char *dest;
> -					size_t len;
> -
> -					memset(&msg_log, 0, sizeof(msg_log));
> -					msg_log.type = MSG_TEST_LOG;
> -					dest = msg_log.test_log.log_buf;
> -					len = slen >= MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
> -					memcpy(dest, src, len);
> -
> -					src += len;
> -					slen -= len;
> -					if (!slen)
> -						msg_log.test_log.is_last = true;
> -
> -					assert(send_message(sock, &msg_log) >= 0);
> -				}
> -			}
> +			if (msg.test_done.have_log)
> +				worker_main_send_log(sock, state->log_buf, state->log_cnt);
> +
> 			if (state->log_buf) {
> 				free(state->log_buf);
> 				state->log_buf = NULL;
> 				state->log_cnt = 0;
> 			}
> +
> +			if (state->subtest_num)
> +				if (worker_main_send_subtests(sock, state))
> +					goto out;
> +
> 			if (env.debug)
> 				fprintf(stderr, "[%d]: #%d:%s done.\n",
> 					env.worker_id,
> @@ -1250,6 +1535,23 @@ static int worker_main(int sock)
> 	return 0;
> }
> 
> +static void free_test_states(void)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(prog_test_defs); i++) {
> +		struct test_state *test_state = &test_states[i];
> +
> +		for (j = 0; j < test_state->subtest_num; j++)
> +			free_subtest_state(&test_state->subtest_states[j]);
> +
> +		free(test_state->subtest_states);
> +		free(test_state->log_buf);
> +		test_state->subtest_states = NULL;
> +		test_state->log_buf = NULL;
> +	}
> +}
> +
> int main(int argc, char **argv)
> {
> 	static const struct argp argp = {
> @@ -1396,6 +1698,7 @@ int main(int argc, char **argv)
> 		unload_bpf_testmod();
> 
> 	free_test_selector(&env.test_selector);
> +	free_test_states();
> 
> 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
> 		return EXIT_NO_TEST;
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 0a102ce460d6..18262077fdeb 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -64,23 +64,31 @@ struct test_selector {
> 	int num_set_len;
> };
> 
> +struct subtest_state {
> +	char *name;
> +	size_t log_cnt;
> +	char *log_buf;
> +	int error_cnt;
> +	bool skipped;
> +
> +	FILE *stdout;
> +};
> +
> struct test_state {
> 	bool tested;
> 	bool force_log;
> 
> 	int error_cnt;
> 	int skip_cnt;
> -	int subtest_skip_cnt;
> 	int sub_succ_cnt;
> 
> -	char *subtest_name;
> +	struct subtest_state *subtest_states;
> 	int subtest_num;
> 
> -	/* store counts before subtest started */
> -	int old_error_cnt;
> -
> 	size_t log_cnt;
> 	char *log_buf;
> +
> +	FILE *stdout;
> };
> 
> struct test_env {
> @@ -96,7 +104,8 @@ struct test_env {
> 	bool list_test_names;
> 
> 	struct prog_test_def *test; /* current running test */
> -	struct test_state *test_state; /* current running test result */
> +	struct test_state *test_state; /* current running test state */
> +	struct subtest_state *subtest_state; /* current running subtest state */
> 
> 	FILE *stdout;
> 	FILE *stderr;
> @@ -116,29 +125,39 @@ struct test_env {
> };
> 
> #define MAX_LOG_TRUNK_SIZE 8192
> +#define MAX_SUBTEST_NAME 1024
> enum msg_type {
> 	MSG_DO_TEST = 0,
> 	MSG_TEST_DONE = 1,
> 	MSG_TEST_LOG = 2,
> +	MSG_SUBTEST_DONE = 3,
> 	MSG_EXIT = 255,
> };
> struct msg {
> 	enum msg_type type;
> 	union {
> 		struct {
> -			int test_num;
> +			int num;
> 		} do_test;
> 		struct {
> -			int test_num;
> +			int num;
> 			int sub_succ_cnt;
> 			int error_cnt;
> 			int skip_cnt;
> 			bool have_log;
> +			int subtest_num;
> 		} test_done;
> 		struct {
> 			char log_buf[MAX_LOG_TRUNK_SIZE + 1];
> 			bool is_last;
> 		} test_log;
> +		struct {
> +			int num;
> +			char name[MAX_SUBTEST_NAME + 1];
> +			int error_cnt;
> +			bool skipped;
> +			bool have_log;
> +		} subtest_done;
> 	};
> };
> 
> -- 
> 2.30.2
> 

