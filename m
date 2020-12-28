Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9742F2E69E5
	for <lists+bpf@lfdr.de>; Mon, 28 Dec 2020 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgL1R4F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 12:56:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728580AbgL1R4B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 12:56:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BSHVBRr181258;
        Mon, 28 Dec 2020 12:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=575WtQFj0wqQyr0cGY9p3bIWqpxBZ1k/uxC+oK37Iy0=;
 b=L2l2XDVoznzmqLRMDcCy7ZzPiir4Qc+76Tn2I76txrpqZP9bPVh9Kdifvh4Fzkdai673
 rqSOQxuTunKupSuRRvliDMVw2jBJKxa4nQt/iNk89JraLO6B1mPRwohgr4TpuJD+dfsY
 ItKrJpzdoNNIxGpM1h/vQUbY9DXJbH6W6obn90nvxBLMn+2XMIUJCyYL2vJamP3RCuL/
 j4Us1q13QYTDK4aB/0yaqBWxGsFxoe1Lq25lqUtJfef13IQOJYnwGNImXYrerpmEqNhq
 tDBN1d1LE7r+rCN9qt5Cu0hJxct/80vCiqYpeWfj0hQ55034oxtHX5lnRHJ6dxcfgVCQ BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35qkcjgyvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 12:55:08 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BSHYUW6194223;
        Mon, 28 Dec 2020 12:55:07 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35qkcjgyuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 12:55:07 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BSHbhF5020741;
        Mon, 28 Dec 2020 17:55:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 35qfp6g3bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 17:55:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BSHt3sR47055324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Dec 2020 17:55:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4007C4C046;
        Mon, 28 Dec 2020 17:55:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5171D4C040;
        Mon, 28 Dec 2020 17:55:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.172])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Dec 2020 17:55:00 +0000 (GMT)
Message-ID: <903c37e9036d167958165ab700e646c1622a9c40.camel@linux.ibm.com>
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
Date:   Mon, 28 Dec 2020 12:54:59 -0500
In-Reply-To: <20201120201507.11993-3-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
         <20201120201507.11993-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_15:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280107
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Casey,

On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> Because IMA uses the audit rule functions it is
> affected as well.

This patch is quite large, even without the audit rule change.  I would
limit this patch to the new lsm_id structure changes.  The audit rule
change should be broken out as a separate patch so that the audit
changes aren't hidden.

In addition, here are a few high level nits:
- The (patch description) body of the explanation, line wrapped at 75
columns, which will be copied to the permanent changelog to describe
this patch. (Refer  Documentation/process/submitting-patches.rst.)

- The brief kernel-doc descriptions should not have a trailing period. 
Nor should kernel-doc variable definitions have a trailing period. 
Example(s) inline below.  (The existing kernel-doc is mostly correct.)

- For some reason existing comments that span multiple lines aren't
formatted properly.   In those cases, where there is another change,
please fix the comment and function description.

thanks,

Mimi

> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

> Cc: <bpf@vger.kernel.org>
> Cc: linux-audit@redhat.com
> Cc: linux-security-module@vger.kernel.org
> Cc: selinux@vger.kernel.org
> ---

> diff --git a/include/linux/security.h b/include/linux/security.h
> index bc2725491560..fdb6e95c98e8 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -132,6 +132,65 @@ enum lockdown_reason {
> 
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> 
> +/*
> + * Data exported by the security modules
> + *
> + * Any LSM that provides secid or secctx based hooks must be included.
> + */
> +#define LSMBLOB_ENTRIES ( \
> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
> +
> +struct lsmblob {
> +	u32     secid[LSMBLOB_ENTRIES];
> +};
> +
> +#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
> +#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
> +#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> +
> +/**
> + * lsmblob_init - initialize an lsmblob structure.

Only this kernel-doc brief description is suffixed with a period.  
Please remove.

> + * @blob: Pointer to the data to initialize
> + * @secid: The initial secid value
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		blob->secid[i] = secid;
> +}
> +
> +/**
> + * lsmblob_is_set - report if there is an value in the lsmblob
> + * @blob: Pointer to the exported LSM data
> + *
> + * Returns true if there is a secid set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *blob)
> +{
> +	struct lsmblob empty = {};
> +
> +	return !!memcmp(blob, &empty, sizeof(*blob));
> +}
> +
> +/**
> + * lsmblob_equal - report if the two lsmblob's are equal
> + * @bloba: Pointer to one LSM data
> + * @blobb: Pointer to the other LSM data
> + *
> + * Returns true if all entries in the two are equal, false otherwise
> + */
> +static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
> +{
> +	return !memcmp(bloba, blobb, sizeof(*bloba));
> +}
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9b5adeaa47fc..cd393aaa17d5 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
>  	} lsm[MAX_LSM_RULES];
> @@ -88,6 +88,22 @@ struct ima_rule_entry {
>  	struct ima_template_desc *template;
>  };
> 
> +/**
> + * ima_lsm_isset - Is a rule set for any of the active security modules
> + * @rules: The set of IMA rules to check.

Nor do kernel-doc variable definitions have a trailing period.

> + *
> + * If a rule is set for any LSM return true, otherwise return false.
> + */
> +static inline bool ima_lsm_isset(void *rules[])
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (rules[i])
> +			return true;
> +	return false;
> +}
> +
>  /*
>   * Without LSM specific knowledge, the default policy can only be
>   * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner

