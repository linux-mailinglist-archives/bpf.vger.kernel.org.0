Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15B264E8C7
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 10:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLPJpm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 04:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiLPJpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 04:45:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C20CCF9;
        Fri, 16 Dec 2022 01:45:38 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG8pEpb010677;
        Fri, 16 Dec 2022 09:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xnh/Mio6T3AlztPDtQ0cC5ajxb7HQbwes7j4hIqnZpA=;
 b=KSDqmT3QhCc3vkbFTw+kOsYLp6FmFIkC6U5bbZkgEmsE3zR3Vf8mwVAi5cS+jFwXi2nJ
 +Xr5d6yV8ttjaJ6buah0bOY484xoHJFIbTtZC6QWmxy5aZGjXGQUkH2S9GrqzevIGkBC
 kKcve7fOMrviWZ8YnuyZn1DpbamBEKIREINai4POntCobQt/TH+hw41CbV436GqqgCSE
 B1Ii3xvBxk4xGcRYAWSrtjmQPUrHz/t2Tuh2i8ss0jjkrtMnAfDK1uMGCNESUZYfTFm+
 BlY6/+W0cHczc5k5d/kCDcuJMJ3A3bzwty36oTgTaFva6mT9OZm42ky8YiFDC6okY+Tc +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgnh6h73y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:45:06 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BG8qeE2016849;
        Fri, 16 Dec 2022 09:45:05 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgnh6h739-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:45:05 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG2Zq0a010492;
        Fri, 16 Dec 2022 09:45:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mf051b4qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:45:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BG9j0hL47383004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 09:45:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBE3C2004B;
        Fri, 16 Dec 2022 09:45:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FE7020043;
        Fri, 16 Dec 2022 09:45:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 16 Dec 2022 09:45:00 +0000 (GMT)
Date:   Fri, 16 Dec 2022 10:44:55 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/5] tools lib perf: Add dependency test to
 install_headers
Message-ID: <Y5w+F+aqN5L1CuuG@tuxmaker.boeblingen.de.ibm.com>
References: <20221202045743.2639466-1-irogers@google.com>
 <20221202045743.2639466-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202045743.2639466-3-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _9NlRjZZfat8F5Hzl1827du4DGsHkktr
X-Proofpoint-ORIG-GUID: Gdky6HrtAEFj0HJVXGmRobDw4-eDowMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_06,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 01, 2022 at 08:57:40PM -0800, Ian Rogers wrote:

Hi Ian,

> Compute the headers to be installed from their source headers and make
> each have its own build target to install it. Using dependencies
> avoids headers being reinstalled and getting a new timestamp which
> then causes files that depend on the header to be rebuilt.

[...]

This fix causes the below error in linux-next:

install: cannot create regular file '/usr/lib64/pkgconfig/libperf.pc': Permission denied
make: *** [Makefile:210: install_pkgconfig] Error 1                             

I am posting a follow-up fix. To me the end result does not look
nice, as do_install and do_install_mkdir are inconsistent, but
the above error goes away.

Thanks!
