Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D394B26637A
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgIKQRl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 12:17:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgIKQR1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Sep 2020 12:17:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BGG0Rl015326;
        Fri, 11 Sep 2020 09:17:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8E3jBmMp5Ia/MnVJsNSWAMJfY3r2fJN3Hcm2PUk4Kgs=;
 b=lYQFghPbwHF5OwOh7HH+s7bNQgoHHnyNoX0jS/AyVPEvQ2R7ZWpqht9ePPETTXLPfUrE
 xlotMnZdq5+aOpWjpyVSTrjybAkOpsLt3+y66xxXkqmCQVQAiP+bqm6668KwBuUY4kJF
 raubBWASVub5+nDtYtoYYaoMIAmr1rhDGtA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33f8bfjaea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Sep 2020 09:17:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 11 Sep 2020 09:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D60AoU761FxqVWHD0kAzsEXv5Bp0lFH7fy47p1aeL6aCrn070U/3Ck/dsbBRcvhVZNuOiIKjrnRN7oOF5+gyFQMCnwoToEXxq3/MIKewOU5hwVmW55DTCMdo2vl//nwn1rp2hQ3tQKepLeTzhHmozjY9VdhxGA7v46u1znNknnyAJCEJA3gvSr8xvSV4VuAKLXEpwXYLm5tuK9zVsp34cRg4Uol6Mz8Blt29uY6cWkogqLq8f4IdqK3JYuhmbQpKKjQ1jwil6CFnC4nic+hRtkS75w9MF/Rr0U5mpnUOtumdzwG6Oc0Tnsd4UoroQFsv+ntO+W372r3t1s3+hlYd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E3jBmMp5Ia/MnVJsNSWAMJfY3r2fJN3Hcm2PUk4Kgs=;
 b=BW8p9TMPgYPFXVB9ZAJNho4HlxjzxsrPimT5jF9j3mQNrBiUP40zdCgU4xotciA5l+jdleBVec113LqVXekStuKHoEbbsPP9o3FB/gda76xjIRVZkpsSihrvXhLyWLdDo5+lkX/DCW0WBZOp1U8Lj/E0J/x6CyCLxcxpWw8JDlqENjqKsm8MqtUkS4XblWloZPr+5vgNm0VN/AuerQCZd22K4P2qJd1cZ+YmqjJHhcU2FkE90THb/2oW7B7475rwBxrw7mEIS0u7QH7k2QveemI0ui96xTpS5LUU8W4LSj2fr1oSz8nF1BZcwsUqLSNknnzVUR53UUlpb6ddMgBvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E3jBmMp5Ia/MnVJsNSWAMJfY3r2fJN3Hcm2PUk4Kgs=;
 b=YvlEZ29Sy0EwTzOnpNDvCl5P/fpAxLnAuVsYPL3i20/oa4ScQ3KsKSZouBRMVPyyRO2DOMC/WUsuWwj0UzhluAqJIzfsHM+lQcIYkqXvmjjraB1ToCHCKUH1DHL+pviFLjxoyxiud1wkbF/7R6+qQMtdM1I9+avlMeBGMNE03GA=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2261.namprd15.prod.outlook.com (2603:10b6:a02:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:17:01 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 16:17:01 +0000
Subject: Re: [PATCH bpf-next] bpf: selftests: remove shared header from
 sockmap iter test
To:     Lorenz Bauer <lmb@cloudflare.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
References: <20200911091411.37645-1-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2c57d577-5859-4f6b-bfd2-8d2b6e935669@fb.com>
Date:   Fri, 11 Sep 2020 09:16:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200911091411.37645-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0065.namprd14.prod.outlook.com
 (2603:10b6:300:81::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1249] (2620:10d:c090:400::5:da00) by MWHPR14CA0065.namprd14.prod.outlook.com (2603:10b6:300:81::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 16:17:00 +0000
X-Originating-IP: [2620:10d:c090:400::5:da00]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee7f4e83-c117-43e1-688c-08d8566e1d56
X-MS-TrafficTypeDiagnostic: BYAPR15MB2261:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2261A6A976B01546DA75FDADD3240@BYAPR15MB2261.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3g6oMjjS3lDrTf0kTTsiEsD6RViUm8MeCgZYkKvRN8rCVPMOF/J692yp9q9PE2ctFKhRpJsqP4thJfTnlXrO2Xep4PeHjPOZqdHd1VsyBSOKXZg46FWZ3YXRVTbCaAzrHwRTN3Zmb6Uo5qHtwG7ceoYfjVglX0gsrqYcfUwiFQgZw2QxcqamIEilsgtws5YnKAjqUiDgbMbJ0PuG27jA73ZAfnb+IwFPo3tfsLEb7VKKe5hvbhtmChIE+NpbwVPigigq/HTPAxmSGHLZNfAtR8W0WsbWmGRkfRPmPMKwUe3G65/sfJC+lbhLyYA6F6C3qStGZh6r95qGPlPO3TOy7Lz+3hk4lpppOUdSH4nqWDOu3lAQCkQoSOTZy40vdHW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(376002)(346002)(66476007)(66946007)(66556008)(2616005)(186003)(16526019)(478600001)(83380400001)(316002)(6486002)(8676002)(31696002)(2906002)(31686004)(5660300002)(8936002)(52116002)(36756003)(53546011)(4326008)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2+gvz7ImiwuiEF6LzuwU/T9c5udFr9T83A3g4Nuk7ahwe2u3PyWN7kXjUeN9uAhis68cTFi+CoyCfaevsyOgnfozrl7PGWr1MPmXvyqCPu9OOrAFL32J9qpE6gMfJYhDVq7h4mIULZGCC5kD7rD4UoH0nNrwgoNXAcPxA9lLPCh1rId6YthRb5Pr737ZF4Gp8Uf4PK7pdBE4YbDVxHbcyiJYjhgApdT+tvATK5zdhFRPeAK9Ky9ZI/4NzBtRtubmaaR7Qm1HP+IrRJ4fnxi0LgEyKzoRJDYxmF+AIhztNHO9j2vjL+xoXV87ccwmeBGw7XWgioKXlqVShr0FkXDiF/TfhdY+hi+MQhjtdlysYPIM29SUwoHfur+tmsQRTKoHOFmGAazRg+fIHH3Ulhnzin6JAvxP0MAT18/CeqBIdbhankbGeYe77ZharTLfv4v/Tb0xtEYm3E2STgsaMRni+vV4hXi8N6v9OlbZ035IqZhMCAMqj5KEoyp+D80WgZRHYNfw8knd1+MAkViG4OaI6S/uP5jjxDIB6bleclyRdTDhzMmTUrtUVBUu0nHLDe97ZXjyzG8GkMkXyEXsuPVRwTUS2GOwjYswd+FdxhaqnSPtHyUl6DuR34oUphqCfNLMq3zPa+n2uTESnJiBjgFN0WospyPhOnP+u4W4mYQwvsU=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7f4e83-c117-43e1-688c-08d8566e1d56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:17:01.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA2f9IA3X1G2VnjkqkagvS6QIgqIDBVf5sPwzmT3EMUZzTswUXqyCrnddbca2JkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2261
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_08:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009110133
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/11/20 2:14 AM, Lorenz Bauer wrote:
> The shared header to define SOCKMAP_MAX_ENTRIES is a bit overkill.
> Dynamically allocate the sock_fd array based on bpf_map__max_entries
> instead.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Ack with some nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 39 ++++++++++---------
>   .../selftests/bpf/progs/bpf_iter_sockmap.c    |  5 +--
>   .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 --
>   3 files changed, 23 insertions(+), 24 deletions(-)
>   delete mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 4b7a527e7e82..2672a91cd78f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -8,8 +8,6 @@
>   #include "test_sockmap_invalid_update.skel.h"
>   #include "bpf_iter_sockmap.skel.h"
>   
> -#include "progs/bpf_iter_sockmap.h"
> -
>   #define TCP_REPAIR		19	/* TCP sock is under repair right now */
>   
>   #define TCP_REPAIR_ON		1
> @@ -179,9 +177,9 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
>   	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>   	int err, len, src_fd, iter_fd, duration = 0;
>   	union bpf_iter_link_info linfo = {0};
> -	__s64 sock_fd[SOCKMAP_MAX_ENTRIES];
> -	__u32 i, num_sockets, max_elems;
> +	__u32 i, num_sockets, num_elems;
>   	struct bpf_iter_sockmap *skel;
> +	__s64 *sock_fd = NULL;
>   	struct bpf_link *link;
>   	struct bpf_map *src;
>   	char buf[64];
> @@ -190,22 +188,26 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
>   	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
>   		return;
>   
> -	for (i = 0; i < ARRAY_SIZE(sock_fd); i++)
> -		sock_fd[i] = -1;
> -
> -	/* Make sure we have at least one "empty" entry to test iteration of
> -	 * an empty slot.
> -	 */
> -	num_sockets = ARRAY_SIZE(sock_fd) - 1;
> -
>   	if (map_type == BPF_MAP_TYPE_SOCKMAP) {
>   		src = skel->maps.sockmap;
> -		max_elems = bpf_map__max_entries(src);
> +		num_elems = bpf_map__max_entries(src);
>   	} else {
>   		src = skel->maps.sockhash;
> -		max_elems = num_sockets;
> +		num_elems = bpf_map__max_entries(src) - 1;
>   	}
>   
> +	/* Make sure we have at least one "empty" entry to test iteration of
> +	 * an empty slot.
> +	 */
> +	num_sockets = bpf_map__max_entries(src) - 1;

I found the logic above a little bit confusing in the sense you want
num_elems and num_sockets the same for sockhash but from code they are
assigned both from bpf_map__max_entries(src) - 1. Maybe the following 
more clear?

	/* Make sure we have at least one "empty" entry to test
	 * iteration of an empty slot.
	 */
	if (map_type == BPF_MAP_TYPE_SOCKMAP) {
		src = skel->maps.sockmap;
		num_elems = bpf_map__max_entries(src);
		num_sockets = num_elems - 1;
	} else {
		src = skel->maps.sockhash;
		num_sockets = bpf_map__max_entries(src) - 1;
		num_elems = num_sockets;
	}

> +
> +	sock_fd = calloc(num_sockets, sizeof(*sock_fd));
> +	if (CHECK(!sock_fd, "calloc(sock_fd)", "failed to allocate\n"))
> +		goto out;

calloc will initialize the value to 0, but it is overwritten below
with -1. malloc is sufficient here.

> +
> +	for (i = 0; i < num_sockets; i++)
> +		sock_fd[i] = -1;
> +
>   	src_fd = bpf_map__fd(src);
>   
>   	for (i = 0; i < num_sockets; i++) {
[...]
