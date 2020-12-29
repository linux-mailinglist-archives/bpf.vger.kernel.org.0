Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07E72E7331
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 20:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgL2TRn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Dec 2020 14:17:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgL2TRm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Dec 2020 14:17:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BTJ1Ycm102817;
        Tue, 29 Dec 2020 14:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+0QSpONsD5OqXpAfAQwJxgPBmRsNRSVo2PjX+5Gc8KI=;
 b=JLwIq1e/8RtxbBLlD0MP2GWDqyLwGjcCzQP+lLjNHF4ElGTbdSMdTse0tCzN7V6vftWW
 Qq/6sH9PokpwvAHegZ4sbmZJckdp5A0KTEn0pLLkyY0EmGn06EPLJbYpu+DMaPKm5Pbn
 gNtREhq7eWML6nvJZigONVhvvVjLixTw8dCahmOO/VctUr3L0y0RNqctYXJ+9QaMaCni
 rCJ76BxxEZ7K5LRLJ6CEHjhJo9TlfZb1w2L3oJaRp1pizLa9wLx5oR0kKx2ImqoL8z8f
 qNYhByMccjfXID1EjIcEjJc/E0VTPgzaydrDuLvTOEah4VdG7JaRY+/gEL0GERprT3Iq Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35r9h613bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 14:16:50 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BTJDWgA152743;
        Tue, 29 Dec 2020 14:16:50 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35r9h613b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 14:16:49 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BTJDfRL011467;
        Tue, 29 Dec 2020 19:16:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 35nvt89ns7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 19:16:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BTJGhJr29295046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Dec 2020 19:16:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A1884C040;
        Tue, 29 Dec 2020 19:16:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D21C04C046;
        Tue, 29 Dec 2020 19:16:42 +0000 (GMT)
Received: from sig-9-65-200-189.ibm.com (unknown [9.65.200.189])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Dec 2020 19:16:42 +0000 (GMT)
Message-ID: <ed9e0dbb48b712a371d3ca4ea5dfa5121d2f98df.camel@linux.ibm.com>
Subject: Re: [PATCH v23 02/23] LSM: Create and manage the lsmblob data
 structure.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date:   Tue, 29 Dec 2020 14:16:41 -0500
In-Reply-To: <10442dd5-f16e-3ca4-c233-7394a11cbbad@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
         <20201120201507.11993-3-casey@schaufler-ca.com>
         <b0e154a0db21fcb42303c7549fd44135e571ab00.camel@linux.ibm.com>
         <886fcd04-6a08-d78c-dc82-301c991e5ad8@schaufler-ca.com>
         <07784164969d0c31debd9defaedb46d89409ad78.camel@linux.ibm.com>
         <8f11964c-fa7e-21d1-ea60-7d918cfaabe0@schaufler-ca.com>
         <e260e8c5bbbb488052cbe1f5b528d43461bc4258.camel@linux.ibm.com>
         <10442dd5-f16e-3ca4-c233-7394a11cbbad@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-12-29 at 10:46 -0800, Casey Schaufler wrote:
> >>>>>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> >>>>>> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
> >>>>>>  {
> >>>>>> -       return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> >>>>>> +       struct security_hook_list *hp;
> >>>>>> +       int rc;
> >>>>>> +
> >>>>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> >>>>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> >>>>>> +                       continue;
> >>>>>> +               rc = hp->hook.audit_rule_match(secid, field, op,
> >>>>>> +                                              &lsmrule[hp->lsmid->slot]);
> >>>>>> +               if (rc)
> >>>>>> +                       return rc;
> >>>>> Suppose that there is an IMA dont_measure or dont_appraise rule, if one
> >>>>> LSM matches, then this returns true, causing any measurement or
> >>>>> integrity verification to be skipped.
> >>>> Yes, that is correct. Like the audit system, you're doing a string based
> >>>> lookup, which pretty well has to work this way. I have proposed compound
> >>>> label specifications in the past, but even if we accepted something like
> >>>> "apparmor=dates,selinux=figs" we'd still have to be compatible with the
> >>>> old style inputs.
> >>>>
> >>>>> Sample policy rules:
> >>>>> dont_measure obj_type=foo_log
> >>>>> dont_appraise obj_type=foo_log
> >>> IMA could extend the existing policy rules like "lsm=[selinux] |
> >>> [smack] | [apparmor]", but that assumes that the underlying
> >>> infrastructure supports it.
> >> Yes, but you would still need rational behavior in the
> >> case where someone has old IMA policy rules.
> > From an IMA perspective, allowing multiple LSMs to define the same
> > policy label is worse than requiring the label be constrained to a
> > particular LSM.
> 
> Just to be sure we're talking about the same thing,
> the case I'm referring to is something like a file with
> two extended attributes:
> 
> 	security.apparmor MacAndCheese
> 	security.SMACK64 MacAndCheese
> 
> and an IMA rule that says
> 
> 	dont_measure obj_type=MacAndCheese
> 
> In this case the dont_measure will be applied to both.
> On the other hand,
> 
> 	security.apparmor MacAndCheese
> 	security.SMACK64 FranksAndBeans
> 
> would also apply the rule to both, which is not
> what you want. Unfortunately, there is no way to
> differentiate which LSM hit the rule.
> 
> So now I'm a little confused. The case where both LSMs
> use the same label looks like it works right, where the
> case where they're different doesn't.

I'm more concerned about multiple LSMs using the same label.  The
label's meaning is LSM specific.

> 
> I'm beginning to think that identifying which LSMs matched
> a rule (it may be none, either or both) is the right solution.
> I don't think that audit is as sensitive to this.

If the label's meaning is LSM specific, then the rule needs to be LSM
specific.

