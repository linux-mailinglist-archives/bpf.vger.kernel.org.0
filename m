Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1E2E6A6E
	for <lists+bpf@lfdr.de>; Mon, 28 Dec 2020 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgL1TZe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 14:25:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729210AbgL1TZe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 14:25:34 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BSJ3HAl020536;
        Mon, 28 Dec 2020 14:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7V4YeQXdsmcZPKQv7IFaraIHdpd8Fb4NJFtVcaQWcN8=;
 b=GVpZ0hxDg4U6b11XoIfbm5jEwd4MQvSzVqDJIn9tdapxn5IjecfknA5P07b+RveiTN+l
 7GBmH5d8kOfrAK7t55QDTZnLzC/iaJM9sobrVpXRF/H1iR6L5z9aFCdvNk3JMHjYTEjE
 9muaQDEgsXBFUwgxFhA96ar/jN3ie5ChaSiGg6vrPMAqXlY8rxvo6Biur+Kf+T7qLKG5
 gR7HmQAzgApd+Sbu7saohSDSYB4rfjirvJm1M88wtFOTERguNn7fubt84L4WE5q29ANM
 S/Zh2EZrAIl9CR8SNs8zyEwLMrVdRkE5Y+IfUY5b3Wb9o5s3ie/m7VjQDg4DnqJhiXUE EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35qn0h8m7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 14:24:44 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BSJ3SPD021989;
        Mon, 28 Dec 2020 14:24:43 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35qn0h8m6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 14:24:43 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BSJHgUK017631;
        Mon, 28 Dec 2020 19:24:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 35nvt7s5b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 19:24:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BSJOcu329032788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Dec 2020 19:24:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5023AE04D;
        Mon, 28 Dec 2020 19:24:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBB5EAE045;
        Mon, 28 Dec 2020 19:24:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.172])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Dec 2020 19:24:35 +0000 (GMT)
Message-ID: <b0e154a0db21fcb42303c7549fd44135e571ab00.camel@linux.ibm.com>
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
Date:   Mon, 28 Dec 2020 14:24:34 -0500
In-Reply-To: <20201120201507.11993-3-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
         <20201120201507.11993-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_17:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012280115
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Casey,

On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
> diff --git a/security/security.c b/security/security.c
> index 5da8b3643680..d01363cb0082 100644
> --- a/security/security.c
> +++ b/security/security.c
> 
> @@ -2510,7 +2526,24 @@ int security_key_getsecurity(struct key *key, char **_buffer)
> 
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
>  {
> -       return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +       struct security_hook_list *hp;
> +       bool one_is_good = false;
> +       int rc = 0;
> +       int trc;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +                       continue;
> +               trc = hp->hook.audit_rule_init(field, op, rulestr,
> +                                              &lsmrule[hp->lsmid->slot]);
> +               if (trc == 0)
> +                       one_is_good = true;
> +               else
> +                       rc = trc;
> +       }
> +       if (one_is_good)
> +               return 0;
> +       return rc;
>  }

So the same string may be defined by multiple LSMs.
> 
>  int security_audit_rule_known(struct audit_krule *krule)
> @@ -2518,14 +2551,31 @@ int security_audit_rule_known(struct audit_krule *krule)
>         return call_int_hook(audit_rule_known, 0, krule);
>  }
> 
> -void security_audit_rule_free(void *lsmrule)
> +void security_audit_rule_free(void **lsmrule)
>  {
> -       call_void_hook(audit_rule_free, lsmrule);
> +       struct security_hook_list *hp;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +                       continue;
> +               hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
> +       }
>  }
> 

If one LSM frees the string, then the string is deleted from all LSMs. 
I don't understand how this safe.

> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
>  {
> -       return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +       struct security_hook_list *hp;
> +       int rc;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +                       continue;
> +               rc = hp->hook.audit_rule_match(secid, field, op,
> +                                              &lsmrule[hp->lsmid->slot]);
> +               if (rc)
> +                       return rc;

Suppose that there is an IMA dont_measure or dont_appraise rule, if one
LSM matches, then this returns true, causing any measurement or
integrity verification to be skipped.  

Sample policy rules:
dont_measure obj_type=foo_log
dont_appraise obj_type=foo_log

Are there any plans to prevent label collisions or at least notify of a
label collision?

Mimi

> +       }
> +       return 0;
>  }
>  #endif /* CONFIG_AUDIT */

