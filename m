Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23E96E1EBB
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDNIsG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDNIsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 04:48:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201B9ED6;
        Fri, 14 Apr 2023 01:47:40 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E8We6E014985;
        Fri, 14 Apr 2023 08:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=cTmVOZmf4q1FLOzKJa5jCCziw6lo6FHkbgKjpBf6SqM=;
 b=fp9WVVMH/8PhblQXfF+YkIQEq8V4nhVRzxBMoIOCt3Odf4Xggk8A4Jvc2KxsnG7i9in6
 0ucDGFGgFdMU32eqZ2V7ozxFusIFbYvo6E8qZbv4ajmCkkZWotCkPIjFwoQX1+xwHOYB
 +cxHkeiZ16c33co1sgkEP9B/5O/gMQaqPAE/WoNKmo+eYwyEpwo/S1+1ILOG62fbwIie
 PtSrgHqM68B+1J36R/N0N/W9PHzABnLdtTrVNnMzsoF2+PzQxmfSURD4Tc4VowZDcK0m
 Bh2Bsm/sYnqLn0qRJeoxBfhrxaTqFa1xre7GTWMWhykwr0u5VRXxpmUcIWLyhdFnZ3z6 RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxvgbdrb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:47:10 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33E8WoIl017192;
        Fri, 14 Apr 2023 08:47:09 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxvgbdran-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:47:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33E30HcO007090;
        Fri, 14 Apr 2023 08:47:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pu0fvtyw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:47:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33E8l4eu28639754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 08:47:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99AA12004B;
        Fri, 14 Apr 2023 08:47:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05B0E20043;
        Fri, 14 Apr 2023 08:47:04 +0000 (GMT)
Received: from osiris (unknown [9.171.19.226])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Apr 2023 08:47:03 +0000 (GMT)
Date:   Fri, 14 Apr 2023 10:47:02 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Howlett <liam.howlett@oracle.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>, bpf@vger.kernel.org,
        linux-next@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH] bpftool: fix broken compile on s390 for linux-next
 repository
Message-ID: <ZDkTBjBSWTHhvB3B@osiris>
References: <20230412123636.2358949-1-tmricht@linux.ibm.com>
 <3f952aed-0926-eb26-6472-2d0443c1a0ff@isovalent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f952aed-0926-eb26-6472-2d0443c1a0ff@isovalent.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VFnqzdOEzOg3QQ0d1sDcDRqsGtwlEBAK
X-Proofpoint-ORIG-GUID: 6MaaBKYs6rhzlKJ-FP8xQYQ38si0M7Qy
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_03,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Full quote below for reference.

Mark or Stephen could you please add the patch below to linux-next?

This solves a merge conflict between perf tree commit f7a858bffcdd ("tools:
Rename __fallthrough to fallthrough") and bpf-next tree commit 9fd496848b1c
("bpftool: Support inline annotations when dumping the CFG of a program").

FWIW, the perf tree commit also seems to have missed an additional
occurence of __fallthrough in samples/bpf/hbm.c.

Thanks!

On Wed, Apr 12, 2023 at 02:27:23PM +0100, Quentin Monnet wrote:
> 2023-04-12 14:36 UTC+0200 ~ Thomas Richter <tmricht@linux.ibm.com>
> > Commit 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
> > breaks the build of the perf tool on s390 in the linux-next repository.
> > Here is the make output:
> > 
> > make -C tools/perf
> > ....
> > btf_dumper.c: In function 'dotlabel_puts':
> > DEBUG: btf_dumper.c:838:25: error: '__fallthrough' undeclared \
> > 		(first use in this function); did you mean 'fallthrough'?
> > DEBUG:   838 |                         __fallthrough;
> > DEBUG:       |                         ^~~~~~~~~~~~~
> > DEBUG:       |                         fallthrough
> > DEBUG: btf_dumper.c:838:25: note: each undeclared identifier is reported \
> > 		only once for each function it appears in
> > DEBUG: btf_dumper.c:837:25: warning: this statement may fall through \
> >                 [-Wimplicit-fallthrough=]
> > DEBUG:   837 |                         putchar('\\');
> > DEBUG:       |                         ^~~~~~~~~~~~~
> > DEBUG: btf_dumper.c:839:17: note: here
> > DEBUG:   839 |                 default:
> > DEBUG:       |                 ^~~~~~~
> > DEBUG: make[3]: *** [Makefile:247: /builddir/build/BUILD/kernel-6.2.fc37/\
> > 		        linux-6.2/tools/perf/util/bpf_skel/ \
> > 		        .tmp/bootstrap/btf_dumper.o] Error 1
> > 
> > The compile fails because symbol __fallthrough unknown, but symbol
> > fallthrough is known and works fine.
> > 
> > Fix this and replace __fallthrough by fallthrough.
> > 
> > With this change, the compile works.
> > 
> > Output after:
> > 
> >  # make -C tools/perf
> >  ....
> >  CC      util/bpf-filter.o
> >  CC      util/bpf-filter-flex.o
> >  LD      util/perf-in.o
> >  LD      perf-in.o
> >  LINK    perf
> >  make: Leaving directory '/root/mirror-linux-next/tools/perf'
> >  #
> > 
> > Fixes: 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >  tools/bpf/bpftool/btf_dumper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> > index 6c5e0e82da22..1b7f69714604 100644
> > --- a/tools/bpf/bpftool/btf_dumper.c
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -835,7 +835,7 @@ static void dotlabel_puts(const char *s)
> >  		case '|':
> >  		case ' ':
> >  			putchar('\\');
> > -			__fallthrough;
> > +			fallthrough;
> >  		default:
> >  			putchar(*s);
> >  		}
> 
> Also reported by Sven Schnelle, and discussed at
> https://lore.kernel.org/all/yt9dttxlwal7.fsf@linux.ibm.com/.
> 
> This is for linux-next, it cannot go through bpf-next given that commit
> f7a858bffcdd ("tools: Rename __fallthrough to fallthrough") is not in
> there yet.
> 
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> 
> Thanks!
> Quentin
