Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79764E8DF
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 10:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiLPJvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 04:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLPJvS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 04:51:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1182447336;
        Fri, 16 Dec 2022 01:51:18 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG8rnPf012446;
        Fri, 16 Dec 2022 09:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ClQz4cdT35ymhgSJDcGj7sEHp4kxME25Ta9yzYQcFk0=;
 b=opb42xbxcnlkmpdOIJXo5RdNaE64QEOvKKOgNGGBu2FWkjLofSIh6MhiUUtllYS6zZ2z
 KfxLubBNtZxnhB8ysY1MS+b9saAMDZDJMrPDy1sa9sVxsxLyE4e9a9aN4LdBpefWorZu
 Ogg9ytiJQ5vit56f8rW5LBn4Yqfft7g/Q+9afiYopw2cNaKdG+TpR4usymTvqM2uZn4G
 zfG5BobPzOzXFOD39Uc/YAvbtNfz1PyuNH33bmHT4lLGoWMkb1fhNG4n/0TqGfg29Xjz
 GbE5qKZdRhmkIEz6ydPo8TVOG16yCcysEYS5A4RftpuPaMBOuZoKhNR6VNM5rLf8i0EE tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgnjmhadv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:50:53 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BG9X81H013628;
        Fri, 16 Dec 2022 09:50:52 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgnjmhacr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:50:52 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG2Z4F3006580;
        Fri, 16 Dec 2022 09:50:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mf03834u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:50:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BG9oi2R46334220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 09:50:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C105520049;
        Fri, 16 Dec 2022 09:50:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26B6920043;
        Fri, 16 Dec 2022 09:50:43 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.83.18])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 16 Dec 2022 09:50:43 +0000 (GMT)
Date:   Fri, 16 Dec 2022 10:50:41 +0100
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
Subject: [PATCH] tools lib perf: fix install_pkgconfig target
Message-ID: <Y5w/cWKyb8vpNMfA@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221202045743.2639466-1-irogers@google.com>
 <20221202045743.2639466-3-irogers@google.com>
 <Y5w+F+aqN5L1CuuG@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5w+F+aqN5L1CuuG@tuxmaker.boeblingen.de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6I6E0drTEhUlL_a5eS5FztDa2r0zA3L7
X-Proofpoint-GUID: rCHrUKt9wrqz0BpD_LWmPjNfS0fDuVfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_06,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 47e02b94a4c9 ("tools lib perf: Add dependency test
to install_headers") misses the notion of $(DESTDIR_SQ)
for install_pkgconfig target, which leads to error:

install: cannot create regular file '/usr/lib64/pkgconfig/libperf.pc': Permission denied
make: *** [Makefile:210: install_pkgconfig] Error 1

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/lib/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 30b7f91e7147..d8cad124e4c5 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -208,7 +208,7 @@ install_headers: $(INSTALL_HDRS) $(INSTALL_INTERNAL_HDRS)
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
+		$(call do_install,$(LIBPERF_PC),$(DESTDIR_SQ)$(libdir_SQ)/pkgconfig,644)
 
 install_doc:
 	$(Q)$(MAKE) -C Documentation install-man install-html install-examples
-- 
2.34.1

