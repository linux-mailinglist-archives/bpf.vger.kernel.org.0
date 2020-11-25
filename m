Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBD2C3707
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 04:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKYDB0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 22:01:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbgKYDBZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 22:01:25 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP2W3R4120618;
        Tue, 24 Nov 2020 22:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6amDYJMbvv+cZ/V0BO4yE2KEA8QwnKwYTTvHtJ1k4+I=;
 b=qQYY1QyCt5B2pvfPm8Jh94ucil9O0Ku15PCOy3KvENc92p9rYA9H5dvJWvnEDK7ffVIU
 D5HzfYpEtDKf7AgjDXF+evO3SWwEDbY4meC68/LFb2Gq+u8XrU8//NIakAatTHA4vwde
 wQWOd1VggxUJ4uWP89Q8UCWbehiZAQJbaFc3S6YSoyC18dC9DYOQEpiOO21v3BXfjJEW
 bRMuFLFQ8GV466G4EY79rs1Cg18H9K0S/ivtjLVrYiZmhjCK3IRL71Ua8GRyiZ+QA2Ow
 gT9IaYgFqKo0dKfn5wjnJBjxRf12ISBzsF8gOoZHWgUOTI0iRRBooxuXT6muY+BsZF3s Dw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 350rna222x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 22:01:11 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AP2w1xL031115;
        Wed, 25 Nov 2020 03:01:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3518j8g8q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 03:01:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AP317EO6881928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 03:01:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69E31AE0EC;
        Wed, 25 Nov 2020 03:01:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9C8AE0CB;
        Wed, 25 Nov 2020 03:01:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.82.212])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Nov 2020 03:01:04 +0000 (GMT)
Message-ID: <8f91820c6a79592105d4ce85ccfaeeda2aa645c3.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for
 bpf_ima_inode_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Date:   Tue, 24 Nov 2020 22:01:04 -0500
In-Reply-To: <CACYkzJ5ZJ_yu=dXM5-jXEO5p5WzpXDT5EdT0agL1pgdNRqGamw@mail.gmail.com>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
         <20201124151210.1081188-4-kpsingh@chromium.org>
         <adaa989215f4b748eb817d15bd3c2e8db2cbee3c.camel@linux.ibm.com>
         <CACYkzJ5ZJ_yu=dXM5-jXEO5p5WzpXDT5EdT0agL1pgdNRqGamw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250011
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2020-11-25 at 03:55 +0100, KP Singh wrote:
> On Wed, Nov 25, 2020 at 3:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2020-11-24 at 15:12 +0000, KP Singh wrote:
> > > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > > new file mode 100644
> > > index 000000000000..15490ccc5e55
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > > @@ -0,0 +1,80 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +set -e
> > > +set -u
> > > +
> > > +IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> > > +TEST_BINARY="/bin/true"
> > > +
> > > +usage()
> > > +{
> > > +        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> > > +        exit 1
> > > +}
> > > +
> > > +setup()
> > > +{
> > > +        local tmp_dir="$1"
> > > +        local mount_img="${tmp_dir}/test.img"
> > > +        local mount_dir="${tmp_dir}/mnt"
> > > +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> > > +        mkdir -p ${mount_dir}
> > > +
> > > +        dd if=/dev/zero of="${mount_img}" bs=1M count=10
> > > +
> > > +        local loop_device="$(losetup --find --show ${mount_img})"
> > > +
> > > +        mkfs.ext4 "${loop_device}"
> > > +        mount "${loop_device}" "${mount_dir}"
> > > +
> > > +        cp "${TEST_BINARY}" "${mount_dir}"
> > > +        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> > > +        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
> >
> > Anyone using IMA, normally define policy rules requiring the policy
> > itself to be signed.   Instead of writing the policy rules, write the
> 
> The goal of this self test is to not fully test the IMA functionality but check
> if the BPF helper works and returns a hash with the minimal possible IMA
> config dependencies. And it seems like we can accomplish this by simply
> writing the policy to securityfs directly.
> 
> From what I noticed, IMA_APPRAISE_REQUIRE_POLICY_SIGS
> requires configuring a lot of other kernel options
> (IMA_APPRAISE, ASYMMETRIC_KEYS etc.) that seem
> like too much for bpf self tests to depend on.
> 
> I guess we can independently add selftests for IMA  which represent
> a more real IMA configuration.  Hope this sounds reasonable?

Sure.  My point was that writing the policy rule might fail.

Mimi
> 
> > signed policy file pathname.  Refer to dracut commit 479b5cd9
> > ("98integrity: support validating the IMA policy file signature").
> >
> > Both enabling IMA_APPRAISE_REQUIRE_POLICY_SIGS and the builtin
> > "appraise_tcb" policy require loading a signed policy.
> 
> Thanks for the pointers.



