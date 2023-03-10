Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B06B4097
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 14:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCJNjH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCJNjH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 08:39:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67F10A13F;
        Fri, 10 Mar 2023 05:39:02 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACCCBE015250;
        Fri, 10 Mar 2023 13:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CPsFbZYndVlyFYB19JflEEI+kjqoJVDliu8k0oxQOSU=;
 b=h8Lyc7XU0upk7G9ZEuCGeD/LB7YL2WbsR1cHMXAy9fUePpRlaXzJm0dMhT3ZTyQQhXRd
 AsSmxRt/B+qAktUfGBKvDQA2DECwfYrWhXoCI4jiSMNAH23oZtIj0WdTW25hgfQlpkxN
 xauiFmPoQGFjUY00mA+WFIJeC1Q24ibY4BXSKIT5O1rzHDvBrVKgnLTXIBN2QTDBoLQw
 t6QITb/8br6Fm+VK8F5BZRNqjkY0bzaxQE3o3W8tJt4GcPu6O+Nj6JrLxjAElCZA8pU3
 ndckA+e/C+g8AJ0hbUNmtXipUAxk/vB5HuJ9PiscMc6GiN/rx2ci9hCiHekT06mKJHQW Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p84be21rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:38:41 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32ADcQxw030762;
        Fri, 10 Mar 2023 13:38:41 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p84be21r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:38:41 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACEOJr022813;
        Fri, 10 Mar 2023 13:38:40 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p6fky2w7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:38:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADccWu50463030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:38:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3D6D58066;
        Fri, 10 Mar 2023 13:38:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 359675805D;
        Fri, 10 Mar 2023 13:38:37 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.71.208])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:38:37 +0000 (GMT)
Message-ID: <3c2ad86758d13939afa9dceaab87fee2ded8201f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it
 for the integrity LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Mar 2023 08:38:36 -0500
In-Reply-To: <CAHC9VhTt7xZqkfZQsWVLRHzza_9idzxkY7bXxzBMq=Xxfc6+Cg@mail.gmail.com>
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
         <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
         <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
         <CAHC9VhTt7xZqkfZQsWVLRHzza_9idzxkY7bXxzBMq=Xxfc6+Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iryH_5qnHU-5Ujt9fx_k9Up4rmBSetUC
X-Proofpoint-ORIG-GUID: shjOtSWiP1adOUJiu-6Rsxphj375H_UX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-09 at 17:04 -0500, Paul Moore wrote:
> On Thu, Mar 9, 2023 at 8:21 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to be
> > > last, e.g. the 'integrity' LSM, without changing the kernel command line or
> > > configuration.
> > >
> > > Also, set this order for the 'integrity' LSM. While not enforced, this is
> > > the only LSM expected to use it.
> > >
> > > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> > > and put at the end of the LSM list.
> > >
> > > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> > > LSM is found, regardless of its order. In this way, the kernel would not
> > > wrongly report that the LSM is not built-in in the kernel if its order is
> > > LSM_ORDER_LAST.
> > >
> > > Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Warning: procedural nitpicking ahead ...
> 
> The 'Signed-off-by' tag is in reference to the DCO, which makes sense
> to add if you are a patch author or are merging a patch into a tree,
> but it doesn't make much sense as a ACK/thumbs-up; this is why we have
> the 'Acked-by' and 'Reviewed-by' tags.  I generally read the
> 'Acked-by' tag as "I'm the one responsible for a chunk of code
> affected by this patch and I'm okay with this change" and the
> 'Reviewed-by' tag as "I looked at this patch and it looks like a good
> change to me".  Perhaps surprisingly to some, while an 'Acked-by' is a
> requirement for merging in a lot of cases, I appreciate 'Reviewed-by'
> tags much more as it indicates the patch is getting some third-part
> eyeballs on it ... so all you lurkers on this list, if you're
> reviewing patches as they hit your inbox, don't be shy about posting
> your 'Reviewed-by' tag if your comfortable doing so, we all welcome
> the help :)
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

In this case, it was a bit unclear who actually was going to upstream
this patch set.  It's better that you upstream it,  but since this
affects subsequent IMA and EVM patches, please create a topic branch.

-- 
thanks,

Mimi

