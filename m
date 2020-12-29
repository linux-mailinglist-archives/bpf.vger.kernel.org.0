Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9902E7132
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 14:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgL2NyZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Dec 2020 08:54:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63414 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbgL2NyZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Dec 2020 08:54:25 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BTD2sbt011846;
        Tue, 29 Dec 2020 08:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qULOwNEQSK0bGvjoEqGQtI9wvdb/CFqIM32TuqdPIKc=;
 b=ERMRLwp6c/renbjtdAKWKfZApDylo+Zhcqyvnly45cssanqGuCZmZ4prXJP5DefRGIeD
 1dj0nF2jvA56RAh8ry60kcbkc9DGBFpp9RaBUDX5tvCbMS5b+yA14IIRBvIMKSMEmQUw
 25wepPYuF4/DO/+T7RMvWYPLKWhpoxo7dLrDKfv6X0smVp2uE43hqd10cZQgCMLDLbcV
 6307wSJ+0dQJq+1mNQ7XH8H1Htn9z7nmRDKYpeESj3BdZWeL+vPbaIF08ZGt3Vv3pIh8
 teiNkBdt4ngOZI005eoyJzDJ+NgXsqLsHX5EXRKFq9fulhrrVGFVdXtFxTdvYhkbt0Jy vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35r5060yqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 08:53:31 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BTDqhDP013464;
        Tue, 29 Dec 2020 08:53:31 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35r5060ypy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 08:53:31 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BTDpobY024917;
        Tue, 29 Dec 2020 13:53:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 35qbk3s7p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 13:53:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BTDrRP237486888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Dec 2020 13:53:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FBC142045;
        Tue, 29 Dec 2020 13:53:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B4D14203F;
        Tue, 29 Dec 2020 13:53:24 +0000 (GMT)
Received: from sig-9-65-200-189.ibm.com (unknown [9.65.200.189])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Dec 2020 13:53:23 +0000 (GMT)
Message-ID: <e2cb6f887a68495163ea2e0c3ffa06177ad2792f.camel@linux.ibm.com>
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
Date:   Tue, 29 Dec 2020 08:53:23 -0500
In-Reply-To: <e260e8c5bbbb488052cbe1f5b528d43461bc4258.camel@linux.ibm.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
         <20201120201507.11993-3-casey@schaufler-ca.com>
         <b0e154a0db21fcb42303c7549fd44135e571ab00.camel@linux.ibm.com>
         <886fcd04-6a08-d78c-dc82-301c991e5ad8@schaufler-ca.com>
         <07784164969d0c31debd9defaedb46d89409ad78.camel@linux.ibm.com>
         <8f11964c-fa7e-21d1-ea60-7d918cfaabe0@schaufler-ca.com>
         <e260e8c5bbbb488052cbe1f5b528d43461bc4258.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_09:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2020-12-28 at 20:53 -0500, Mimi Zohar wrote:
> On Mon, 2020-12-28 at 15:20 -0800, Casey Schaufler wrote:
> > On 12/28/2020 2:14 PM, Mimi Zohar wrote:
> > > On Mon, 2020-12-28 at 12:06 -0800, Casey Schaufler wrote:
> > >> On 12/28/2020 11:24 AM, Mimi Zohar wrote:

> > >>>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> > >>>> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
> > >>>>  {
> > >>>> -       return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> > >>>> +       struct security_hook_list *hp;
> > >>>> +       int rc;
> > >>>> +
> > >>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> > >>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> > >>>> +                       continue;
> > >>>> +               rc = hp->hook.audit_rule_match(secid, field, op,
> > >>>> +                                              &lsmrule[hp->lsmid->slot]);
> > >>>> +               if (rc)
> > >>>> +                       return rc;
> > >>> Suppose that there is an IMA dont_measure or dont_appraise rule, if one
> > >>> LSM matches, then this returns true, causing any measurement or
> > >>> integrity verification to be skipped.
> > >> Yes, that is correct. Like the audit system, you're doing a string based
> > >> lookup, which pretty well has to work this way. I have proposed compound
> > >> label specifications in the past, but even if we accepted something like
> > >> "apparmor=dates,selinux=figs" we'd still have to be compatible with the
> > >> old style inputs.
> > >>
> > >>> Sample policy rules:
> > >>> dont_measure obj_type=foo_log
> > >>> dont_appraise obj_type=foo_log
> > > IMA could extend the existing policy rules like "lsm=[selinux] |
> > > [smack] | [apparmor]", but that assumes that the underlying
> > > infrastructure supports it.
> > 
> > Yes, but you would still need rational behavior in the
> > case where someone has old IMA policy rules.
> 
> From an IMA perspective, allowing multiple LSMs to define the same
> policy label is worse than requiring the label be constrained to a
> particular LSM.

If allowing multiple LSMs to define the same label is only an IMA
issue, then have security_audit_rule_init() return the number of LSMs
which define the label.   IMA is already emitting a warning when an LSM
rule is not defined.   Emitting an additional warning would be the
first step.

In addition, ima_parse_rule() could detect policy rules containing non
LSM specific labels.  Based on policy, IMA would decide how to handle
it.

thanks,

Mimi

