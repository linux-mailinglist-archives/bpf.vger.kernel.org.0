Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC436387B6
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKYKmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 05:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYKmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 05:42:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FC4664F;
        Fri, 25 Nov 2022 02:42:07 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APARASg028857;
        Fri, 25 Nov 2022 10:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KdosrhN5XdljozFCn1bQZylSOF7bQ1SODAs6gTMeRWE=;
 b=EVc8j9PvPdNdRALd3lCx9cKJab0la9RUYkg94ZEseXvw2CkcD5RjeRT0cuMNC6G/MGq6
 j7KXYO8VXI07z5CjoKWg/vSxtgO/lsyU8J8qzhxLCDXsQxVi7EeUkcgVDfuDxuINmamy
 cftqr22Xsz8C+AyX9JGckTgAVF0ZtCGfe0qLcni+tJ1ej3mTPmr9XihosBUIsaM11k6J
 wZAuQyN+TmFsjp9nIs6AG89o3ORQ4D+kVQcXANSpzaVWhnajhJiYCZj5JAaR9/Ys2pNh
 CfEDD6sjGZvY1cm2bMfP72xhKe7HCbMGAWu10pzEtzxDwLgRXokhTx1Ac4LthsFhmPZP 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2uye896n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 10:41:45 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2APATqh2006474;
        Fri, 25 Nov 2022 10:41:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2uye895p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 10:41:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2APAZKKr016784;
        Fri, 25 Nov 2022 10:41:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3kxps91dwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 10:41:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2APAZLaQ3474136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 10:35:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62E99AE051;
        Fri, 25 Nov 2022 10:41:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6010AE045;
        Fri, 25 Nov 2022 10:41:38 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.94.96])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Nov 2022 10:41:38 +0000 (GMT)
Date:   Fri, 25 Nov 2022 11:41:37 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf build: Fix LIBTRACEEVENT_DYNAMIC
Message-ID: <Y4Cb4feK/9q+Wzmt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221116224631.207631-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116224631.207631-1-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WpKiEY4QRQZXaJx4X4kt9_r6cj_vRYGz
X-Proofpoint-ORIG-GUID: BsZ2JV9HYOBMmRIcXbMrEUDl7AyMnV7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 02:46:31PM -0800, Ian Rogers wrote:

Hi Ian,

> The tools/lib includes fixes break LIBTRACEVENT_DYNAMIC as the
> makefile erroneously had depdendencies on building libtraceevent even
> when not linking with it. This change fixes the issues with
> LIBTRACEEVENT_DYNAMIC by making the built files optional.

It kernel-next on s390 somehow libtraceevent seems to be bypassed, which leads 
to make -C tools/perf install-bin failure. While it does not hit in every
envoronment, could you please hint what could be a reason for that?

...
make FIXDEP=1 -f Makefile.perf install-bin
Makefile.config:1030: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
$(:)
make -C /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/lib/api/ O=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libapi \
 DESTDIR=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libapi prefix= \
 /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libapi/libapi.a install_headers
make -C /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/lib/perf/ O=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libperf \
 DESTDIR=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libperf prefix= \
 /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libperf/libperf.a install_headers
make -C /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/lib/subcmd/ O=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libsubcmd \
 DESTDIR=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libsubcmd prefix= \
 /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libsubcmd/libsubcmd.a install_headers
make -C /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/lib/symbol/ O=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libsymbol \
 DESTDIR=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libsymbol prefix= \
 /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libsymbol/libsymbol.a install_headers
make -C /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/lib/bpf/ FEATURES_DUMP=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/FEATURE-DUMP \
 O= OUTPUT=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libbpf/ DESTDIR=/builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libbpf prefix= \
 /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/libbpf/libbpf.a install_headers
/bin/sh util/PERF-VERSION-GEN
make -C /builddir/build/BUILD/kernel-6.0.fc36/linux-6.0/tools/perf/tests/shell/coresight
make[2]: *** No rule to make target 'install-traceevent-plugins', needed by 'install-bin'.  Stop.


Thanks!
