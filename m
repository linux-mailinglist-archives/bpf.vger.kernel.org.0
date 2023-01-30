Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35846680803
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 09:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjA3I7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 03:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjA3I7B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 03:59:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7554827991;
        Mon, 30 Jan 2023 00:59:00 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U8dNVp003841;
        Mon, 30 Jan 2023 08:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JKrTBhIka4PJq34qWzVGBeakgXLIvGGhUIdQ2PtP3Wo=;
 b=SgoI9+ylsM5DZmsM+QsWoOiyXjm6hWRmi2a64xadLvOFKCpJFN21eWs+Q+idRrDEAU/4
 rJZBa0L2iVkgzE1Dn3Tcvs0YlHho+yts+rFfHzY4PvCRnYYmqG1R9NpsrWGt05T8rv5X
 lEc1RsNym/VVo/FeDW+QTK/1gyA3wCyp8rDtAfbaNTTNEmp3L7bL3ii03vM2MjRbXhs5
 wPsIeye1L/WlVnswc1sNVH0UMygvirfypCYjePIo7IALoDf6ABJNUh9j+EmqWmb1zKMv
 kXxqTl1+QvDwFUoyvBMSvvapvLkXo/7ZVNpLdZI9mISSmeZDDVqJuWOtX3Wrc0SKZX5b dg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddgsjuqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:58:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U4vO8S026916;
        Mon, 30 Jan 2023 08:58:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7hyt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:58:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30U8wruI43254210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 08:58:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 501BA20040;
        Mon, 30 Jan 2023 08:58:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F194820043;
        Mon, 30 Jan 2023 08:58:50 +0000 (GMT)
Received: from [9.43.101.243] (unknown [9.43.101.243])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 08:58:50 +0000 (GMT)
Message-ID: <70b60459-2e7a-1944-77dc-54fef2e00975@linux.ibm.com>
Date:   Mon, 30 Jan 2023 14:28:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf test: Switch basic bpf filtering test to use syscall
 tracepoint
Content-Language: en-US
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Disha Goel <disgoel@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20230123083224.276404-1-naveen.n.rao@linux.vnet.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20230123083224.276404-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7dSqWuNS5E9S8z7_SrItYqzDQSXr_pHv
X-Proofpoint-GUID: 7dSqWuNS5E9S8z7_SrItYqzDQSXr_pHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/23/23 14:02, Naveen N. Rao wrote:
> BPF filtering tests can sometime fail. Running the test in verbose mode
> shows the following:
>   $ sudo perf test 42
>   42: BPF filter                                                      :
>   42.1: Basic BPF filtering                                           : FAILED!
>   42.2: BPF pinning                                                   : Skip
>   42.3: BPF prologue generation                                       : Skip
>   $ perf --version
>   perf version 4.18.0-425.3.1.el8.ppc64le
>   $ sudo perf test -v 42
>   42: BPF filter                                                      :
>   42.1: Basic BPF filtering                                           :
>   --- start ---
>   test child forked, pid 711060
>   ...
>   bpf: config 'func=do_epoll_wait' is ok
>   Looking at the vmlinux_path (8 entries long)
>   Using /usr/lib/debug/lib/modules/4.18.0-425.3.1.el8.ppc64le/vmlinux for symbols
>   Open Debuginfo file: /usr/lib/debug/.build-id/81/56f5a07f92ccb62c5600ba0e4aacfb5f3a7534.debug
>   Try to find probe point from debuginfo.
>   Matched function: do_epoll_wait [4ef8cb0]
>   found inline addr: 0xc00000000061dbe4
>   Probe point found: __se_compat_sys_epoll_pwait+196
>   found inline addr: 0xc00000000061d9f4
>   Probe point found: __se_sys_epoll_pwait+196
>   found inline addr: 0xc00000000061d824
>   Probe point found: __se_sys_epoll_wait+36
>   Found 3 probe_trace_events.
>   Opening /sys/kernel/tracing//kprobe_events write=1
>   ...
>   BPF filter result incorrect, expected 56, got 56 samples
>   test child finished with -1
>   ---- end ----
>   BPF filter subtest 1: FAILED!

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> The statement above about the result being incorrect looks weird, and it
> is due to that particular perf build missing commit 3e11300cdfd5f1
> ("perf test: Fix bpf test sample mismatch reporting"). In reality, due
> to commit 4b04e0decd2518 ("perf test: Fix basic bpf filtering test"),
> perf expects there to be 56*3 samples.
> 
> However, the number of samples we receive is going to be dependent on
> where the probes are installed, which is dependent on where
> do_epoll_wait gets inlined. On s390x, it looks like probes at all the
> inlined locations are hit. But, that is not the case on ppc64le.
> 
> Fix this by switching the test to instead use the syscall tracepoint.
> This ensures that we will only ever install a single event enabling us
> to reliably determine the sample count.
> 
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/bpf-script-example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
> index 7981c69ed1b456..b638cc99d5ae56 100644
> --- a/tools/perf/tests/bpf-script-example.c
> +++ b/tools/perf/tests/bpf-script-example.c
> @@ -43,7 +43,7 @@ struct {
>  	__type(value, int);
>  } flip_table SEC(".maps");
>  
> -SEC("func=do_epoll_wait")
> +SEC("syscalls:sys_enter_epoll_pwait")
>  int bpf_func__SyS_epoll_pwait(void *ctx)
>  {
>  	int ind =0;
> 
> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
