Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7A42BB0A
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhJMJEW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 05:04:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235111AbhJMJET (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 05:04:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D7XaoH021936;
        Wed, 13 Oct 2021 05:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=196uR0aS7kSreuy53Dsv1N2CyGcjBQoIkFYNPzG2RkY=;
 b=DaZzLNwwybHRGDsoLoLc0pmvWIkWp3VWy8hnjfbh3PHY5T9EksZZCrJLboY0qL5z8Jze
 38+x3b8o0TPJJ4Iqn81QaqRDQqFRAf9rYPXush284+snVFQQWvkNY3Kjid8/5wnqcUl+
 jzHKidQOwkSRpXWc+KQrYQfBZ1QQWbe1vWs5BwdV3SQNW/pSE+hf1mQbduIFZv/L9PWd
 q/rj4qDz+xTyQXoB424SPpPfnWtDhJMC/DUygZclEWpRpwyJAhJZkcMGzO5MM82dWpgz
 MgKIIIo8IYBUNTTuadCAvSIM41ufn62TERsAWsFfONojgQkCO5Odul0qukxAbNs/GtsW iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnr79dd13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 05:01:46 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19D8p2oI022986;
        Wed, 13 Oct 2021 05:01:46 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnr79dd00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 05:01:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19D8tP4P005036;
        Wed, 13 Oct 2021 09:01:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9ruqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 09:01:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19D8twhr58655196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:55:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1633442054;
        Wed, 13 Oct 2021 09:01:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8EB14204C;
        Wed, 13 Oct 2021 09:01:35 +0000 (GMT)
Received: from osiris (unknown [9.145.19.118])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Oct 2021 09:01:35 +0000 (GMT)
Date:   Wed, 13 Oct 2021 11:01:34 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCHv2 0/8] x86/ftrace: Add direct batch interface
Message-ID: <YWagbqm4wtYqpBt/@osiris>
References: <20211008091336.33616-1-jolsa@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ImFN_ZMEuzSsL7f6rD1P-6J99W-k1VBN
X-Proofpoint-ORIG-GUID: SpVLCw7Gv2OL__0uqeCNEtLoDm6sO07I
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_03,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=623 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130057
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 08, 2021 at 11:13:28AM +0200, Jiri Olsa wrote:
> hi,
> adding interface to maintain multiple direct functions
> within single calls. It's a base for follow up bpf batch
> attach functionality.
...
> ---
> Jiri Olsa (6):
>       x86/ftrace: Remove extra orig rax move
>       tracing: Add trampoline/graph selftest
>       ftrace: Add ftrace_add_rec_direct function
>       ftrace: Add multi direct register/unregister interface
>       ftrace: Add multi direct modify interface
>       ftrace/samples: Add multi direct interface test module
> 
> Steven Rostedt (VMware) (2):
>       x86/ftrace: Remove fault protection code in prepare_ftrace_return
>       x86/ftrace: Make function graph use ftrace directly
> 
>  arch/x86/include/asm/ftrace.h        |   9 +++-
>  arch/x86/kernel/ftrace.c             |  71 +++++++++++++++---------------
>  arch/x86/kernel/ftrace_64.S          |  30 +------------
>  include/linux/ftrace.h               |  26 +++++++++++
>  kernel/trace/fgraph.c                |   6 ++-
>  kernel/trace/ftrace.c                | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
>  kernel/trace/trace_selftest.c        |  54 ++++++++++++++++++++++-
>  samples/ftrace/Makefile              |   1 +
>  samples/ftrace/ftrace-direct-multi.c |  52 ++++++++++++++++++++++
>  9 files changed, 420 insertions(+), 97 deletions(-)
>  create mode 100644 samples/ftrace/ftrace-direct-multi.c

FWIW, Steven pointed me to this thread since I posted
DYNAMIC_FTRACE_WITH_DIRECT_CALL support for s390 here:
https://lore.kernel.org/all/20211012133802.2460757-1-hca@linux.ibm.com/

Since Jiri asked for it: please feel free to add
Tested-by: Heiko Carstens <hca@linux.ibm.com>
to all non-x86 patches.
