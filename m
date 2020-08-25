Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72ED251448
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 10:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgHYIcy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 04:32:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgHYIcx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 04:32:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P8CpEu126412;
        Tue, 25 Aug 2020 04:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iIIg6HBcLqlLd2Oo2yDjDLtxk8C6Y2WvUebW/n6zbR4=;
 b=aQKYihV8wQUEFVkcynscZvrWKRrakHwzHvOngeDO2GsRmW/qxI34bibcc0sHx0tXsRj5
 EINpmf9Aw1YkTQm+b3CL+j3Uo8+bU9S5phlUY/5jvuLaijd6mAFV3kejYx8bbIEaixOd
 2JIsO+iEc+CdWjFXmzrbEXZVxttVJLyMguv9oU1Q2OyOb6pufnZCA8htYS6GrXXuQ3xE
 dEmLdPzAvbdXFU2lM8SaNP60ZSOoMJm8h1D6ksegXJb1KuDBbW0dfwd2FNZfUJLVbkq0
 zQIibBGayZKOn9vRMj6Wn+zPBoIC2d7aLZQu9mr39iXRo5rBJ+qUX9xBSGlkak27cIcf bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334xx9gfn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 04:32:51 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P8D9rR126801;
        Tue, 25 Aug 2020 04:32:51 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334xx9gfmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 04:32:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P8R8rU025851;
        Tue, 25 Aug 2020 08:32:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33498u94kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 08:32:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P8WkGw16974266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 08:32:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BA9911C069;
        Tue, 25 Aug 2020 08:32:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8DBA11C05B;
        Tue, 25 Aug 2020 08:32:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 08:32:45 +0000 (GMT)
Subject: Re: [PATCH] perf test: Fix basic bpf filtering test
To:     acme@kernel.org
Cc:     tmricht@linux.ibm.com, hca@linux.ibm.com, svens@linux.ibm.com,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
References: <20200817072754.58344-1-sumanthk@linux.ibm.com>
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
Message-ID: <1954643f-e268-b7bc-7c6e-75205d9f5f92@linux.ibm.com>
Date:   Tue, 25 Aug 2020 10:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817072754.58344-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250057
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kind Ping. Thank you.

On 8/17/20 9:27 AM, Sumanth Korikkar wrote:
> BPF basic filtering test fails on s390x (when vmlinux debuginfo is
> utilized instead of /proc/kallsyms)
>
> Info:
> - bpf_probe_load installs the bpf code at do_epoll_wait.
> - For s390x, do_epoll_wait resolves to 3 functions including inlines.
>    found inline addr: 0x43769e
>    Probe point found: __s390_sys_epoll_wait+6
>    found inline addr: 0x437290
>    Probe point found: do_epoll_wait+0
>    found inline addr: 0x4375d6
>    Probe point found: __se_sys_epoll_wait+6
> - add_bpf_event  creates evsel for every probe in a BPF object. This
>    results in 3 evsels.
>
> Solution:
> - Expected result = 50% of the samples to be collected from epoll_wait *
>    number of entries present in the evlist.
>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/perf/tests/bpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 5d20bf8397f0..cd77e334e577 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -197,7 +197,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
>   		perf_mmap__read_done(&md->core);
>   	}
>   
> -	if (count != expect) {
> +	if (count != expect * evlist->core.nr_entries) {
>   		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect, count);
>   		goto out_delete_evlist;
>   	}

-- 
Sumanth Korikkar

