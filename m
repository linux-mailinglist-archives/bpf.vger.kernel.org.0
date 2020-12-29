Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A32E6D24
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 02:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgL2By2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 20:54:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgL2By1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 20:54:27 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BT1dBO2108237;
        Mon, 28 Dec 2020 20:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=p0mK2//Fc1O0SZfnnFo/fcfAnruCU/L9ITv18tKA2so=;
 b=kkKdbPUf/v3YgzvBqq0G7qkcpO3ux7yJe3aMMC4AcTvZ53qCtnzDuL9/QC9lBSi9hbLG
 cXzWrDOHh1MHYs8IGCqkd4YsxOBXNrq4UQwz6eFwzgBODmzvzkptb08uGm8uPsn8MKX+
 3R72L9e7lQMGiBVZSEgwUk5WFeXmkDIjRIHm1exZva8N2M6JOOd6AGuBam0aUPZlnlXy
 K0sYfuA+PuDAu9r6jh9QTOtHk1ReAiZ8VQacgmx42YAEbNRrjnBG3oTUr1Gbtg1hJW88
 UiXMUgRyTGfk3w5seqQEIpS1X1oSEZeQ8qPOCjRy3FRtE6JsjGdvGgkyrvDU4Nqb0DUV iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35qts68f83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 20:53:35 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BT1f90L115092;
        Mon, 28 Dec 2020 20:53:35 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35qts68f7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 20:53:34 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BT1fmM9020405;
        Tue, 29 Dec 2020 01:53:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 35nvt89920-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 01:53:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BT1rUuk46530944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Dec 2020 01:53:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 455F242045;
        Tue, 29 Dec 2020 01:53:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F69642041;
        Tue, 29 Dec 2020 01:53:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.172])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Dec 2020 01:53:27 +0000 (GMT)
Message-ID: <e260e8c5bbbb488052cbe1f5b528d43461bc4258.camel@linux.ibm.com>
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
Date:   Mon, 28 Dec 2020 20:53:26 -0500
In-Reply-To: <8f11964c-fa7e-21d1-ea60-7d918cfaabe0@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
         <20201120201507.11993-3-casey@schaufler-ca.com>
         <b0e154a0db21fcb42303c7549fd44135e571ab00.camel@linux.ibm.com>
         <886fcd04-6a08-d78c-dc82-301c991e5ad8@schaufler-ca.com>
         <07784164969d0c31debd9defaedb46d89409ad78.camel@linux.ibm.com>
         <8f11964c-fa7e-21d1-ea60-7d918cfaabe0@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_20:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290002
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2020-12-28 at 15:20 -0800, Casey Schaufler wrote:
> On 12/28/2020 2:14 PM, Mimi Zohar wrote:
> > On Mon, 2020-12-28 at 12:06 -0800, Casey Schaufler wrote:
> >> On 12/28/2020 11:24 AM, Mimi Zohar wrote:
> >>> Hi Casey,
> >>>
> >>> On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
> >>>> diff --git a/security/security.c b/security/security.c
> >>>> index 5da8b3643680..d01363cb0082 100644
> >>>> --- a/security/security.c
> >>>> +++ b/security/security.c
> >>>>
> >>>> @@ -2510,7 +2526,24 @@ int security_key_getsecurity(struct key *key, char **_buffer)
> >>>>
> >>>>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
> >>>>  {
> >>>> -       return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> >>>> +       struct security_hook_list *hp;
> >>>> +       bool one_is_good = false;
> >>>> +       int rc = 0;
> >>>> +       int trc;
> >>>> +
> >>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
> >>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> >>>> +                       continue;
> >>>> +               trc = hp->hook.audit_rule_init(field, op, rulestr,
> >>>> +                                              &lsmrule[hp->lsmid->slot]);
> >>>> +               if (trc == 0)
> >>>> +                       one_is_good = true;
> >>>> +               else
> >>>> +                       rc = trc;
> >>>> +       }
> >>>> +       if (one_is_good)
> >>>> +               return 0;
> >>>> +       return rc;
> >>>>  }
> >>> So the same string may be defined by multiple LSMs.
> >> Yes. Any legal AppArmor label would also be a legal Smack label.
> >>
> >>>>  int security_audit_rule_known(struct audit_krule *krule)
> >>>> @@ -2518,14 +2551,31 @@ int security_audit_rule_known(struct audit_krule *krule)
> >>>>         return call_int_hook(audit_rule_known, 0, krule);
> >>>>  }
> >>>>
> >>>> -void security_audit_rule_free(void *lsmrule)
> >>>> +void security_audit_rule_free(void **lsmrule)
> >>>>  {
> >>>> -       call_void_hook(audit_rule_free, lsmrule);
> >>>> +       struct security_hook_list *hp;
> >>>> +
> >>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
> >>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> >>>> +                       continue;
> >>>> +               hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
> >>>> +       }
> >>>>  }
> >>>>
> >>> If one LSM frees the string, then the string is deleted from all LSMs. 
> >>> I don't understand how this safe.
> >> The audit system doesn't have a way to specify which LSM
> >> a watched label is associated with. Even if we added one,
> >> we'd still have to address the current behavior. Assigning
> >> the watch to all modules means that seeing the string
> >> in any module is sufficient to generate the event.
> > I originally thought loading a new LSM policy could not delete existing
> > LSM labels, but that isn't true.  If LSM labels can come and go based
> > on policy, with this code, could loading a new policy for one LSM
> > result in deleting labels of another LSM?
> 
> No. I could imagine a situation where changing policy on
> a system where audit rules have been set could result in
> confusion, but that would be true in the single LSM case.
> It would require that secids used in the old policy be
> used for different labels in the new policy. That would
> not be sane behavior. I know it's impossible for Smack.
> 
> This is one of the reasons I'm switching from a single secid
> to a collection of secids. You don't want unnatural behavior
> of one LSM to impact the behavior of another.
> 
> 
> >
> >>>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> >>>> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
> >>>>  {
> >>>> -       return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> >>>> +       struct security_hook_list *hp;
> >>>> +       int rc;
> >>>> +
> >>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> >>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> >>>> +                       continue;
> >>>> +               rc = hp->hook.audit_rule_match(secid, field, op,
> >>>> +                                              &lsmrule[hp->lsmid->slot]);
> >>>> +               if (rc)
> >>>> +                       return rc;
> >>> Suppose that there is an IMA dont_measure or dont_appraise rule, if one
> >>> LSM matches, then this returns true, causing any measurement or
> >>> integrity verification to be skipped.
> >> Yes, that is correct. Like the audit system, you're doing a string based
> >> lookup, which pretty well has to work this way. I have proposed compound
> >> label specifications in the past, but even if we accepted something like
> >> "apparmor=dates,selinux=figs" we'd still have to be compatible with the
> >> old style inputs.
> >>
> >>> Sample policy rules:
> >>> dont_measure obj_type=foo_log
> >>> dont_appraise obj_type=foo_log
> > IMA could extend the existing policy rules like "lsm=[selinux] |
> > [smack] | [apparmor]", but that assumes that the underlying
> > infrastructure supports it.
> 
> Yes, but you would still need rational behavior in the
> case where someone has old IMA policy rules.

From an IMA perspective, allowing multiple LSMs to define the same
policy label is worse than requiring the label be constrained to a
particular LSM.

> 
> >
> >>> Are there any plans to prevent label collisions or at least notify of a
> >>> label collision?
> >> What would that look like? You can't say that Smack isn't allowed
> >> to use valid AppArmor labels. How would Smack know? If the label is
> >> valid to both, how would you decide which LSM gets to use it?

Unfortunately, unless audit supports per LSM labels, the infrastructure
needs to detect and prevent the label collision.

> > As this is a runtime issue, when loading a new policy at least flag the
> > collision.  When removing the label, when it is defined by multiple
> > LSMs, at least flag the removal.
> 
> To what end would the collision be flagged? What would you do with
> the information?

LSM label collision is probably an example of kernel integrity critical
data (yet to be upstreamed).

> 
> >
> >>>> +       }
> >>>> +       return 0;
> >>>>  }
> >>>>  #endif /* CONFIG_AUDIT */
> 


