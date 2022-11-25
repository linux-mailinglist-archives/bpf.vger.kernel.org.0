Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F74638B31
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 14:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKYNcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 08:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKYNcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 08:32:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A123EBB;
        Fri, 25 Nov 2022 05:32:03 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APDRBR8010963;
        Fri, 25 Nov 2022 13:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=T/xoSpaZUHd5WbuUEJCGTZWzRJBSpCBI9e82i4i3SJY=;
 b=WRyKlxZ0UzhMW5wkJUSf9aimbB3vDvlpXHV8jvdNoQHBKmyR1diC3/qQfrJHPSFqpQMz
 16kAvWZV+1bztgUNPTgQUWidPG/kHRqtjkiY88fJtgBb2Iz6ws4/yc//aOgcMIqBKN5p
 ew6gKDNCtLAls5Kk5CGSVNp6dBaxfSHW7Qtn20rr56r5XFIDhaVR3O01MhDwNz0H4i+T
 WMTY0xiZH9AcQlYpNcAz+HYSgcCyFdR/ErkTurHll4pcZw4viCOeCfMO2F6OYvubjiWL
 ftgd/mKkjf59LzMUpOYTeRi6qd6ZApau7yyZapEiPaRMlyl+MryLEiUYuF0xabMfknHk VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2xktr36y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 13:31:39 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2APDRa63012064;
        Fri, 25 Nov 2022 13:31:39 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2xktr35b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 13:31:38 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2APDNgPE032084;
        Fri, 25 Nov 2022 13:31:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3kxps8xxvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 13:31:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2APDVXtY43450784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 13:31:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87FB95204F;
        Fri, 25 Nov 2022 13:31:33 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.94.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 613A15204E;
        Fri, 25 Nov 2022 13:31:32 +0000 (GMT)
Date:   Fri, 25 Nov 2022 14:31:30 +0100
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
Message-ID: <Y4DDsmXU/tkmDfK7@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221116224631.207631-1-irogers@google.com>
 <Y4Cb4feK/9q+Wzmt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Cb4feK/9q+Wzmt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ag-fLur9YcMaeLCI30ocp-8VoUqvO0aO
X-Proofpoint-ORIG-GUID: -f0QA15OxV9k6fDRxtd0pYQA0AHqawyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_05,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=918
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 25, 2022 at 11:41:40AM +0100, Alexander Gordeev wrote:
> > The tools/lib includes fixes break LIBTRACEVENT_DYNAMIC as the
> > makefile erroneously had depdendencies on building libtraceevent even
> > when not linking with it. This change fixes the issues with
> > LIBTRACEEVENT_DYNAMIC by making the built files optional.
> 
> It kernel-next on s390 somehow libtraceevent seems to be bypassed, which leads 
> to make -C tools/perf install-bin failure. While it does not hit in every
> envoronment, could you please hint what could be a reason for that?

And unless I am missing something install-traceevent-plugins target
is only awailable when LIBTRACEEVENT_DYNAMIC is undefined..
