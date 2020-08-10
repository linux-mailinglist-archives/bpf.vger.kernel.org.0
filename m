Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6F3240F62
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgHJTVk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 15:21:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728971AbgHJTNS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Aug 2020 15:13:18 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07AJBA5S023476;
        Mon, 10 Aug 2020 12:13:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=e9kRmWbwS6+E1mXGKU0KScD8qbedp2lxFIX+fCafy08=;
 b=D3J8257rSbZc71Q1CYDM2ROt7eG5Lw+i3ALBqkpmiqrgK5a6uuCsYaTkRkHSA3MMpAAA
 N4wZKlvuAXE/mvTii5gYHzpsDs4q40mIFjaJIizrGj0Qcye4z6gagLzEJuxBj/SawCmJ
 tQGJq/aCWbxd5MKhUfBItecaY9FoqivQHkM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32u81nsdgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Aug 2020 12:13:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 10 Aug 2020 12:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcOVp206Tm+HSOIwBeIS+BJFQ9wsnlCP2QwJ/Wz2QbyEIjoDPkS58KuIsWJWzhAliKThgdAX5jWKyfrYynzxKvxmsZNIAk0TLwKPALLt5vCJ8qe2+9E93yclu5tFwCT7HhTwsfNUCXSM0xZRnE7Fa2PEEBcYWnCyUF5SL9qTXMT/G/e4O4ixoSZpDOJBVJUtV71W9ZtZDqrIkLi9sjWZkqSWBU4UiMXX/QLHvV9gyGGzUAUDFbA95SsSq5AF+essn0WB5fnuDxOdfJxMaL5c+Yc5Z023s8Fn1E0fuu6Hvn+uBZCfJnwjy/RBJwMUQBLL9VqHy8pQgiO5VJUYgwHzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9kRmWbwS6+E1mXGKU0KScD8qbedp2lxFIX+fCafy08=;
 b=EfxOUClpK2/Ibr9dWJXgItZsZFImdUhSYuBkaXjQUxx5gMl2WEDYoKdEtLaL5HqVeeybbtd6JElCZlbNMoamLQeMvjh/n5asuQ1GVlbs5oIzhy6uthOf1Q35r21lk/Zw1/FDwoOkigEj7Rvu+BEQJ88iFAUUOqRJYr0zCC1KMXVGDwU40Vr6kumop8noTzg+61hqseTlNA3ot/d3QigoyUxOD+u41liubpYdBFzmyuQORU4U2bDQnGL11lhcNa0TMrJ6V8tl0uYJ1S5WnWC9G5u/wFCPbQX9FrqwHElonsIfQgxoF5tyYNbtkUdqSBvaLFVO5F2HusBvE9pAEGHUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9kRmWbwS6+E1mXGKU0KScD8qbedp2lxFIX+fCafy08=;
 b=f4g2qz/rW6YBGKEXm3V7eDyUr6yqrEVUBVggBSsABejuzc2g7Hq4AKw8CG70W+YdrMbu2vNFyPg6kFLFiEmHdWty2+gwrTuHKJ7c73R9gSq7UopQUiBE04cfgfa0n0FkgE7yNXP35oqxgn7Ju4w90P97Oo6GBJBWTUa3FzYEa8g=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3253.namprd15.prod.outlook.com (2603:10b6:a03:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Mon, 10 Aug
 2020 19:12:59 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 19:12:59 +0000
Date:   Mon, 10 Aug 2020 12:12:54 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] selftests: bpf: mmap: reorder mmap manipulations of
 adv_mmap tests
Message-ID: <20200810191254.l7dhhtpoq7cdsvzz@kafai-mbp.dhcp.thefacebook.com>
References: <20200810153139.41134-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810153139.41134-1-yauheni.kaliuta@redhat.com>
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:458c) by BYAPR02CA0051.namprd02.prod.outlook.com (2603:10b6:a03:54::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Mon, 10 Aug 2020 19:12:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:458c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0816ff1a-8775-41d9-cf06-08d83d616565
X-MS-TrafficTypeDiagnostic: BYAPR15MB3253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32538FD0E236C2F28F882D6ED5440@BYAPR15MB3253.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTHg0cypgS4vNRHHsE73DUyVG7n3l2TvniioHwho+aeEPrqWp0OPrU6YzvDI1DCG5hCEAI+9wzXwwHKbzS9TtEw7WM9Sxoeqfo3aD19M/Dfr6jZUlXZYQAczcye4VViAA9YPUzNc1mpnv9cMkL598dkDmsDoFuGnOzGBnK0vGCeQ79uCElCYk+tF0Z1P745SvkfwU4l8OAJH3kt90j4CiF3gm7GsnFgP8uxtFu8Um18XKX98MGCtls1x8Xh/toeq2MEsrW6DBUpPcF8DlY8gWxixcDxOEMgoeoM/wme4eFTgUwYNtZthtFR2dCGygY23
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(396003)(39860400002)(346002)(8676002)(8936002)(9686003)(6506007)(6666004)(2906002)(83380400001)(478600001)(55016002)(16526019)(186003)(7696005)(52116002)(66946007)(66476007)(66556008)(5660300002)(86362001)(4326008)(1076003)(54906003)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mdY34T+1ra4RaucgsHJSQjlr/26YaPMtTlqlkQccnSijhsiHTUeX8WU2MXbRSESVLDQ+wJKzZsR0LfT3OOQlp8E1OsS9vAyLO/TVM1PlhZTxtUdwBfzEBXY6PEKLfvryJlkgc5IahoktRSJoWXGXi22DqZIRsghoT1p4SrFEc1O8lHItu6Ve2fONcDhSAwAzyS/FsERd82i8nS1vpSuvQIamfMCrzNWXK/smt4GwBUWQaeqtTbD3VGIXWmuKxPz4NlsK5lo+woWXQuC9Eb3yPMogzVLRRkw6Ydp6O1YQKeUJ/7niuij6arz1YvKNNdDQmmXbw4L2ORCp2DEuIYjT2cTQMB4lXFowTzhnQf8TTLlMdGU0XrvB86y4wXHwBpRIrv+R+S6M0q1gQvA0xZhENah1zpQpO2kzX0OjcnV4Ci1JIN3Zfs23KGGDtUjL9M1/q9J1YfYne6xNO87cheM9M8iByZCv7kZIUhQN/E948m4dm6N5hBL6tCgog962Ar28tr0uvHKRoP/YTrfqb07I6ou6xCgXfrBGs5FMdHIr9x1R4lGaxuQGq6y7mYabkd9C+9AnTvs62yz7RUTM4Z1+/M+jCG5WYO9dhbq9p7AzbMulMpAahFlSa4waNzdYKLDRVUZcSh9NON0iChuOrGWKxm1yLA2eiGEH2jBe/siZNyk4Zdqd+0I4suHXahZUi6pX
X-MS-Exchange-CrossTenant-Network-Message-Id: 0816ff1a-8775-41d9-cf06-08d83d616565
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 19:12:59.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH0Z+2BjCVKmuJmhVraJUGNqWPjmEGVzGyxVfaUK+nft5fboWirBYbtSyxZml6ka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3253
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_16:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 suspectscore=1 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008100130
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 06:31:39PM +0300, Yauheni Kaliuta wrote:
> The idea of adv_mmap tests is to map/unmap pages in arbitrary
> order. It works fine as soon as the kernel allocates first 3 pages
> for from a region with unallocated page after that. If it's not the
> case, the last remapping of 4 pages with MAP_FIXED will remap the
> page to bpf map which will break the code which worked with the data
> located there before.
> 
> Change the test to map first the whole bpf map, 4 pages, and then
> manipulate the mappings.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/mmap.c | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mmap.c b/tools/testing/selftests/bpf/prog_tests/mmap.c
> index 43d0b5578f46..5768af1e16a7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mmap.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mmap.c
> @@ -183,38 +183,45 @@ void test_mmap(void)
>  
>  	/* check some more advanced mmap() manipulations */
>  
> -	/* map all but last page: pages 1-3 mapped */
> -	tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
> +	/* map all 4 pages */
> +	tmp1 = mmap(NULL, 4 * page_size, PROT_READ, MAP_SHARED,
>  			  data_map_fd, 0);
>  	if (CHECK(tmp1 == MAP_FAILED, "adv_mmap1", "errno %d\n", errno))
>  		goto cleanup;
>  
> -	/* unmap second page: pages 1, 3 mapped */
> +	/* unmap second page: pages 1, 3, 4 mapped */
>  	err = munmap(tmp1 + page_size, page_size);
>  	if (CHECK(err, "adv_mmap2", "errno %d\n", errno)) {
>  		munmap(tmp1, map_sz);
>  		goto cleanup;
>  	}
>  
> +	/* unmap forth page: pages 1, 3 mapped */
> +	err = munmap(tmp1 + (3 * page_size), page_size);
> +	if (CHECK(err, "adv_mmap3", "errno %d\n", errno)) {
> +		munmap(tmp1, map_sz);
1, 3, and 4 are mapped here but only one munmap() with "map_sz" is used.

> +		goto cleanup;
> +	}
> +
>  	/* map page 2 back */
>  	tmp2 = mmap(tmp1 + page_size, page_size, PROT_READ,
>  		    MAP_SHARED | MAP_FIXED, data_map_fd, 0);
> -	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap3", "errno %d\n", errno)) {
> +	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap4", "errno %d\n", errno)) {
>  		munmap(tmp1, page_size);
>  		munmap(tmp1 + 2*page_size, page_size);
1 and 3 are mapped here.  However, multiple munmap() are used.

Both will work the same?

>  		goto cleanup;
>  	}
> -	CHECK(tmp1 + page_size != tmp2, "adv_mmap4",
> +	CHECK(tmp1 + page_size != tmp2, "adv_mmap5",
>  	      "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
>  
>  	/* re-map all 4 pages */
>  	tmp2 = mmap(tmp1, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
>  		    data_map_fd, 0);
> -	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap5", "errno %d\n", errno)) {
> +	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap6", "errno %d\n", errno)) {
>  		munmap(tmp1, 3 * page_size); /* unmap page 1 */
>  		goto cleanup;
>  	}
> -	CHECK(tmp1 != tmp2, "adv_mmap6", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
> +	CHECK(tmp1 != tmp2, "adv_mmap7", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
>  
>  	map_data = tmp2;
>  	CHECK_FAIL(bss_data->in_val != 321);
> @@ -231,7 +238,7 @@ void test_mmap(void)
>  	/* map all 4 pages, but with pg_off=1 page, should fail */
>  	tmp1 = mmap(NULL, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
>  		    data_map_fd, page_size /* initial page shift */);
> -	if (CHECK(tmp1 != MAP_FAILED, "adv_mmap7", "unexpected success")) {
> +	if (CHECK(tmp1 != MAP_FAILED, "adv_mmap8", "unexpected success")) {
>  		munmap(tmp1, 4 * page_size);
>  		goto cleanup;
>  	}
> -- 
> 2.26.2
> 
