Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E92C0E7F
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 16:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbgKWPKy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 10:10:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52884 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732025AbgKWPKv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 10:10:51 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANF2IL1069677;
        Mon, 23 Nov 2020 10:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UIFhmGdF1pfMFaT9mYBNCV4Q59iOT78U5d23p3L9Aps=;
 b=AswzMkIZ8sf9pvFyoFUCfNh8oEMJ6X0EaoEk/kWKUtl7YeTcgUTriD8zfi0ha+7/amXc
 /jZNlBJn2ErOkFcXi3G1chcJgSE9sJwYcMgm80fse4wov2Id9aB5xKwmSqMrTGmPDUHn
 ed7P6fDc/IX23E9Zn80d16U6gscub4Om/p7MSMSIlPHm1Y+7JYK9SP+PpW7Ss1zUKFx5
 ZniPymzSGmltghLKG6z/EduZcxQophcjf7Sb9sYCk9DzNnLmjvsFoWDOvi7aqUIuFbqb
 PCcpTKxL4X5u6byn4alF6BEgDhOVHAjKu28lWOhYEF/IG9bZiDju2EG4tOCc6bU3IKwW tQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34yw5wjjrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 10:10:34 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ANF96va016786;
        Mon, 23 Nov 2020 15:10:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34xt5hangx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 15:10:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ANFAUKN55771624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 15:10:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08E74A4055;
        Mon, 23 Nov 2020 15:10:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F76CA405D;
        Mon, 23 Nov 2020 15:10:27 +0000 (GMT)
Received: from sig-9-65-241-175.ibm.com (unknown [9.65.241.175])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Nov 2020 15:10:27 +0000 (GMT)
Message-ID: <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for
 bpf_ima_inode_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 23 Nov 2020 10:10:26 -0500
In-Reply-To: <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
         <20201121005054.3467947-3-kpsingh@chromium.org>
         <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
         <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_11:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230100
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[Cc'ing Petr Vorel]

On Mon, 2020-11-23 at 15:06 +0100, KP Singh wrote:
> On Mon, Nov 23, 2020 at 2:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Sat, 2020-11-21 at 00:50 +0000, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > - Update the IMA policy before executing the test binary (this is not an
> > >   override of the policy, just an append that ensures that hashes are
> > >   calculated on executions).
> >
> > Assuming the builtin policy has been replaced with a custom policy and
> > CONFIG_IMA_WRITE_POLICY is enabled, then yes the rule is appended.   If
> > a custom policy has not yet been loaded, loading this rule becomes the
> > defacto custom policy.
> >
> > Even if a custom policy has been loaded, potentially additional
> > measurements unrelated to this test would be included the measurement
> > list.  One way of limiting a rule to a specific test is by loopback
> > mounting a file system and defining a policy rule based on the loopback
> > mount unique uuid.
> 
> Thanks Mimi!
> 
> I wonder if we simply limit this to policy to /tmp and run an executable
> from /tmp (like test_local_storage.c does).
> 
> The only side effect would be of extra hashes being calculated on
> binaries run from /tmp which is not too bad I guess?

The builtin measurement policy (ima_policy=tcb") explicitly defines a
rule to not measure /tmp files.  Measuring /tmp results in a lot of
measurements.

{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},

> 
> We could do the loop mount too, but I am guessing the most clean way
> would be to shell out to mount from the test? Are there some other examples
> of IMA we could look at?

LTP loopback mounts a filesystem, since /tmp is not being measured with
the builtin "tcb" policy.  Defining new policy rules should be limited
to the loopback mount.  This would pave the way for defining IMA-
appraisal signature verification policy rules, without impacting the
running system.

Mimi

