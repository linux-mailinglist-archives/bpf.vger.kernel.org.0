Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FCF24945B
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 07:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgHSFTi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 01:19:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgHSFTh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 01:19:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07J5GCOU030041;
        Tue, 18 Aug 2020 22:19:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wigtqG5XvPANkOpFiuokl0BWYij8dbBvBqPNGXuOM5E=;
 b=M5AMpiJJnn0BREmG9XW0GSt1Y1OTajc72AlgzBdpHlOE2pwxXsXN7w7vw94qkFALZtK+
 2bp7A767EPq64BBI7JKr/tPGcn3xGdLd+MYk3UslCHRSzYuTZZWalyqztEPsRUedOz7h
 r8Fz63JyyXugTYKHg+PaCQedPkQ8iE3gXdk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304prptnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Aug 2020 22:19:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 22:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA0Ou8MZvbB6J0TRlPJ/8WG6LanLnd1qe8OGOV1oROKCh4rh1I6hzKJwfTRNsQjiyYg7LJpgdQDB56Uo9fmW5F/LlkAY6WGitVZycm2JBlw+lattIjo8c/Dz8Ftx9fqamb5qYn9YDEKz0CMnhPqrbPc7mBse0H4nWm+m/c+TE0DdzxaElPHA0M3HDYwynAY5JYgxK8iYqU7CZft6ckHsFxZqojOyfLwScEMLp+KmK21CG2X5o6lwQs63Hg+KBqXCiuasj/QBN8mTN5p76T7D7HXXjGo7C0YWJao4+c2HINYAaL+6IwORX3CVukB6HFeVVHPncLjqiJZBQ8zz2swSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wigtqG5XvPANkOpFiuokl0BWYij8dbBvBqPNGXuOM5E=;
 b=IioHX1GeVXW7P3fX4ng7hpg2VPYAyloHf4SrbSUzN499giBGchTCeh8tYqbRN8coFrD5POunLFt7hNs8wTpasukyGcKWgOdsglQNHTAAZmakc1xJsTAixAvPz2McNN5z7vo7w1wzQ+kEw3fJ5dE3K9NCu4KOY6YfxdZYILdZO+NaxQBjUkPwWzmTv7YkvjDLwIwWoTk0kyAlhushWLg1BGcm8Sl4W4pUUboWJMs+ZWszGsCxgPrGljnZVtblQCoq4LVAvGPlc4HG+zX6MjAHA6fvGV/z1JtGRQb5OY/s7ndeR99rVpOCWLSB4mO9yiIuo5YmzcPPUSPJyLFQxecwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wigtqG5XvPANkOpFiuokl0BWYij8dbBvBqPNGXuOM5E=;
 b=IfgJB0CdnylR1ota6l1hvq7AmJHfuTSav7dQOhUDYbU9TLPPhaZrlZnywVLggaXG0qOokPzmE8zVaHb9QNujKUTlPQ5jyPBIMmF6MTl6ntv0mCj9nLXz4ifezMUrvPQ8AlKMqRuiKP6JX6VxOaZSrZqpU4vCEGAjYVR3ckdN6JQ=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3000.namprd15.prod.outlook.com (2603:10b6:a03:b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 05:19:20 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 05:19:20 +0000
Subject: Re: [PATCH] bpf: selftests: global_funcs: check err_str before strstr
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20200819023427.267182-1-yauheni.kaliuta@redhat.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <66d63f42-ce71-446a-7ee2-586ffcea160d@fb.com>
Date:   Tue, 18 Aug 2020 22:19:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200819023427.267182-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11e8::10d3] (2620:10d:c091:480::1:374f) by BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Wed, 19 Aug 2020 05:19:19 +0000
X-Originating-IP: [2620:10d:c091:480::1:374f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 957eef87-a0a0-42bb-cf81-08d843ff6d45
X-MS-TrafficTypeDiagnostic: BYAPR15MB3000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3000B8E7292B19FE4DE48F37D35D0@BYAPR15MB3000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLaeXhD1oPyBa4r5C2gXNP69Gx+gcH7ExgRsT7fXCKoWVCrTxJ1M6Q/HBiddl7A0TvcimA2S8rLDTzRChwgly9Z4w2VhbuerHR+Jz92+2572CL/x/lVpgjD6jV7msMsZSjPJJ/TggD5Qe3q9d+355iiHtASS0rsYpgerMD9qL5zPv1HFp1FWXZUD4xwRyf2/I9D/myZ9w7gwEcn//CfdVkkUaNeL8J39cCNAK1YlPA0A2Z6WsYTSwRpzZ5ZiPeyfRAbp4kc1fMQeY6IRGjDdFkgz7e/pBq1RoWZVDbI3GDeBH1/yaxkRq16medgrkuuZg4xmZcVjECxLjQKZeU0lfEXXXvcbV5tCI5CXan8nKkWaYAZOcHZRPFHB+WHOeM1MaBO6kXH5xCrP/DjKg7iOs2sRx7trxXEFJ2l2UsAYnEWHeCLhgjKyZHuvow5wDINE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(346002)(396003)(366004)(66476007)(83380400001)(478600001)(36756003)(54906003)(31696002)(4326008)(53546011)(2616005)(6486002)(186003)(66946007)(2906002)(8676002)(66556008)(316002)(52116002)(16526019)(86362001)(31686004)(5660300002)(8936002)(6666004)(17423001)(156123004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PquV1y4HXByA0gUSH2LdWM0rhWGcOp4xZIJbn/MiYmZabsjJb/Wm//QchuCHvr6sHCjFh4KKPSm9PxENtZJo2OgGxlo0rz0g+lxIbzucdW/j+g2KfcJ0hC14uz7RcINlN1RsTt0Hxb4QTPQqHno9U1vn7/v2Q6DYCA2tEs051/uzI6o1nKwzLLlO5OVERZ3KMuglLZioBPt/tbpBilpbDtKKBCczSe4OUP2sSv4qdlf9iMCCsImDuZGWUOyXGWXplxnOt4ENvXK/q9W3xEm/n76TlF1rulTmk11Tox/TyhFG4RlQMDviOfy8t5+L7V6NhEJizOzc4HYDw4brgiefJ6GMmlm6rL0ytgsu1ICss9n/6myjIVFG1tBh++84zf0hhNE7X2TvST0sWkajgFVpPKyoyEomjYtDD7V8WrgVWM+lqsb9AtvZ1Ee26+adCzXpP1hyMtjRD3jZ2ctNThnqSeY23CBMnP3Wp+09ICJJjjRfNRthx9qDpiHfIYf1WCzmV1d0QskntRW9WSDDmTRIFsdsRf2clbn2m9bR1XYSbDDhr4lxR9esllwzYSZ2MOZ1zOqaUKrip7BFX6zeF5apJ6c+sNlUawZYX/5ltiW9RMyt+TBeHFxafuQjdl9iELGbXbr8Q7ttLYk0OGh74pjGOdJZ569jITlc7Qn/vaRqczI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 957eef87-a0a0-42bb-cf81-08d843ff6d45
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 05:19:20.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRZujflzkqdiVqMqQCG8oULMxm+BZBxzZVRKe2fXDvTqzD1ktcAesdP5i3jEOjxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3000
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_03:2020-08-18,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190044
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/18/20 7:34 PM, Yauheni Kaliuta wrote:
> The error path in libbpf.c:load_program() has calls to pr_warn()
> which ends up for global_funcs tests to
> test_global_funcs.c:libbpf_debug_print().
> 
> For the tests with no struct test_def::err_str initialized with a
> string, it causes call of strstr() with NULL as the second argument
> and it segfaults.
> 
> Fix it by calling strstr() only for non-NULL err_str.
> 
> The patch does not fix the test itself.

So this happens in older kernel, right? Could you clarify more
in which kernel and what environment? It probably no need to
fix the issue for really old kernel but some clarification
will be good.

> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> index 25b068591e9a..6ad14c5465eb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> @@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
>   	log_buf = va_arg(args, char *);
>   	if (!log_buf)
>   		goto out;
> -	if (strstr(log_buf, err_str) == 0)
> +	if ((err_str != NULL) && (strstr(log_buf, err_str) == 0))

Looks good but the code can be simplified as
	if (err_str && strstr(log_buf, err_str) == 0)
		found = true;

>   		found = true;
>   out:
>   	printf(format, log_buf);
> 
