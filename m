Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C252F6B5141
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 20:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCJT7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 14:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCJT7l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 14:59:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F0123CDB;
        Fri, 10 Mar 2023 11:59:39 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AH3p6t027756;
        Fri, 10 Mar 2023 19:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=VSVqmCryi08IhnKuyDD1hUxsXZuYTuB5guadql6qFKw=;
 b=Y11vPUeRZ/OPWLuV9G1bHd9SHJneQ4Iw0HTpY8kCZXwveUHXE5qFj6WgqBMdaEWCK5PU
 oFFhfUrtT/D+zhDA8fNnW564sui9cIbl7Whqeo0arIyb2NWQMoK9UVB6UEP7YhJWbob2
 S6vtp+bkdTiJVEWUl40lvfRWz20PLD/DJyJD5e4PbrxVNUEA/MTQ/gahUXEhZ5/oBFzX
 jatQIJCTFW1VUtXEIXfJ1FS4wlNDfkzgcbedjyNTiUFhs4LxUW5g2IIqE4F++z4TwejJ
 u2g0+/jNi2gPeYfgIdS8AGEOqp59RpfLfGSZVqfhUkkElWWVH7AG2bgUtVVvHrZng4Sj NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p86m1fa4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 19:59:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32AJuDXm022840;
        Fri, 10 Mar 2023 19:59:22 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p86m1fa45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 19:59:22 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32AHj1Z3023609;
        Fri, 10 Mar 2023 19:59:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3p6fnwvx64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 19:59:21 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32AJxJ7V49807760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:59:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A78A858053;
        Fri, 10 Mar 2023 19:59:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7452C58043;
        Fri, 10 Mar 2023 19:59:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.71.208])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 19:59:18 +0000 (GMT)
Message-ID: <dd449eb3ab697b630edd2df8d0912061859d5160.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it
 for the integrity LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Mar 2023 14:59:17 -0500
In-Reply-To: <66e9fefe918463e8fbe2e8d8ca46a76f4428a944.camel@huaweicloud.com>
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
         <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
         <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
         <CAHC9VhTt7xZqkfZQsWVLRHzza_9idzxkY7bXxzBMq=Xxfc6+Cg@mail.gmail.com>
         <3c2ad86758d13939afa9dceaab87fee2ded8201f.camel@linux.ibm.com>
         <CAHC9VhQ80t8z79iYaY8xpoiQ5fTURoesaau+5r0bCXZrsO5GUQ@mail.gmail.com>
         <66e9fefe918463e8fbe2e8d8ca46a76f4428a944.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1v5bzE5HxGeMZPw-HG61ODP0bKB7x3Rw
X-Proofpoint-GUID: HXrRBX18kUockpNF6zmmZ3A2lORHr2Gm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-10 at 17:33 +0100, Roberto Sassu wrote:
> On Fri, 2023-03-10 at 11:22 -0500, Paul Moore wrote:
> > On Fri, Mar 10, 2023 at 8:39 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Thu, 2023-03-09 at 17:04 -0500, Paul Moore wrote:
> > > > On Thu, Mar 9, 2023 at 8:21 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > 
> > > > > > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to be
> > > > > > last, e.g. the 'integrity' LSM, without changing the kernel command line or
> > > > > > configuration.
> > > > > > 
> > > > > > Also, set this order for the 'integrity' LSM. While not enforced, this is
> > > > > > the only LSM expected to use it.
> > > > > > 
> > > > > > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> > > > > > and put at the end of the LSM list.
> > > > > > 
> > > > > > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> > > > > > LSM is found, regardless of its order. In this way, the kernel would not
> > > > > > wrongly report that the LSM is not built-in in the kernel if its order is
> > > > > > LSM_ORDER_LAST.
> > > > > > 
> > > > > > Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > 
> > > > Warning: procedural nitpicking ahead ...
> > > > 
> > > > The 'Signed-off-by' tag is in reference to the DCO, which makes sense
> > > > to add if you are a patch author or are merging a patch into a tree,
> > > > but it doesn't make much sense as a ACK/thumbs-up; this is why we have
> > > > the 'Acked-by' and 'Reviewed-by' tags.  I generally read the
> > > > 'Acked-by' tag as "I'm the one responsible for a chunk of code
> > > > affected by this patch and I'm okay with this change" and the
> > > > 'Reviewed-by' tag as "I looked at this patch and it looks like a good
> > > > change to me".  Perhaps surprisingly to some, while an 'Acked-by' is a
> > > > requirement for merging in a lot of cases, I appreciate 'Reviewed-by'
> > > > tags much more as it indicates the patch is getting some third-part
> > > > eyeballs on it ... so all you lurkers on this list, if you're
> > > > reviewing patches as they hit your inbox, don't be shy about posting
> > > > your 'Reviewed-by' tag if your comfortable doing so, we all welcome
> > > > the help :)
> > > > 
> > > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> > > 
> > > In this case, it was a bit unclear who actually was going to upstream
> > > this patch set.
> > 
> > FWIW, I wasn't expecting to see your sign-off without a note that you
> > had merged it.  Normally I would have expected either an acked-by or a
> > note that you had merged it, a sign-off without a merge notice seemed
> > a little odd to me so I thought I would mention the above :)  No harm
> > either way, I just figured a little discussion on process might not be
> > a terrible idea to make sure we are all on the same page.
> > 
> > > It's better that you upstream it,  but since this
> > > affects subsequent IMA and EVM patches, please create a topic branch.
> > 
> > I generally don't do topic branches for work that has been merged into
> > a -next or -stable branch. I prefer to limit topic branches to
> > special-cases where there is some value in keeping a central branch
> > for multiple people to coordinate while the patchset is still in
> > development; once a patchset has progressed far enough to be merged
> > into a -stable or -next branch I stop maintaining the topic branch.

I'm definitely not the expert in this, but topic branches normally need
to remain around until they make it into a release or an -rc, not
-next.

> > 
> > In this particular case the changes to the IMA/EVM code looked very
> > minor, so I doubt there would be a significant merge conflict with the
> > IMA/EVM tree during this development cycle, but if you would prefer to
> > take this patchset via the IMA/EVM tree that is okay with me; just let
> > me know so I can ACK the two LSM-related patches (I'm going to review
> > the latest posting today).
> 
> Probably it would be beneficial if you carry this patch set, so that
> the next 'evm: Do HMAC of multiple per LSM xattrs for new inodes', and
> 'security: Move IMA and EVM to the LSM infrastructure' could be applied
> on top (assuming that we are able to finish within this cycle).

That's fine.

> 
> > As a bit of an aside, while this doesn't cover topic branches (once
> > again, I consider those special cases), when managing the LSM tree I
> > follow the process that is documented here:
> > 
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> > 
> > [NOTE: the above GH repo is a read-only mirror of the canonical LSM
> > kernel.org repo, it just happens that GH does a better job rendering
> > txt]
> > 
> > The main LSM repo process "docs" / pointers can be found in the main
> > README or "about" page:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/about
> > 
> > If people have suggestions for a different approach to managing the
> > LSM tree I'm always open to discussion.

Thank you for the pointer.  Nicely written.

-- 
thanks,

Mimi

