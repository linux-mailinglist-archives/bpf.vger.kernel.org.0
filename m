Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4EA2E6C40
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 00:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgL1Wzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 17:55:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729325AbgL1To4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 14:44:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BSJWmXV087244;
        Mon, 28 Dec 2020 14:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FFC1pIh9Jx3Vm1rVMfDgprQvk4esrJQ88xEvb228pWQ=;
 b=PKh5KhiUgozAkhHVNi5TelmKS12GtPwEaDTPwKrjGvOgHezPVk2urrt1tw3z0c2Jq1tP
 G0HeIK1bYzBsPaAM4tWTEtpEuyDRKXy963HKP3Xa09WB904J7+QxSudjGfSVKuvzqODk
 6+ilTvqlLdoIHPipsRIxYwNWsjKCQ1/1PGKuCbcJRIrCSHmPHLdjFJPtv3B5sCmfVevY
 5wMHiHwnvBIUVMwVfMRT9GUCVVLCP9V1UaGglnETD42dcjZ3npVUWvR1eXRopxG9KbHQ
 iBKZ1XOlVwD8hKNttAik6gIh/vmu1alIa4I3igY157wxngxG2lfsjhTybLAeaM1bSLd5 Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35qmwts065-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 14:44:04 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BSJWmJj087289;
        Mon, 28 Dec 2020 14:44:03 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35qmwts05k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 14:44:03 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BSJfdFM019890;
        Mon, 28 Dec 2020 19:44:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 35nvt895fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 19:44:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BSJhv9X28639742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Dec 2020 19:43:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA7C7A405C;
        Mon, 28 Dec 2020 19:43:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9390A405F;
        Mon, 28 Dec 2020 19:43:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.172])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Dec 2020 19:43:56 +0000 (GMT)
Message-ID: <564953d7ffb847365236a37639b81cbb7bca2aa6.camel@linux.ibm.com>
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
Date:   Mon, 28 Dec 2020 14:43:55 -0500
In-Reply-To: <c88bc01f-3b65-f320-b42b-5ecde3e29448@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
         <20201120201507.11993-3-casey@schaufler-ca.com>
         <903c37e9036d167958165ab700e646c1622a9c40.camel@linux.ibm.com>
         <c88bc01f-3b65-f320-b42b-5ecde3e29448@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_17:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280115
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2020-12-28 at 11:22 -0800, Casey Schaufler wrote:
> On 12/28/2020 9:54 AM, Mimi Zohar wrote:
> > Hi Casey,
> >
> > On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
> >> When more than one security module is exporting data to
> >> audit and networking sub-systems a single 32 bit integer
> >> is no longer sufficient to represent the data. Add a
> >> structure to be used instead.
> >>
> >> The lsmblob structure is currently an array of
> >> u32 "secids". There is an entry for each of the
> >> security modules built into the system that would
> >> use secids if active. The system assigns the module
> >> a "slot" when it registers hooks. If modules are
> >> compiled in but not registered there will be unused
> >> slots.
> >>
> >> A new lsm_id structure, which contains the name
> >> of the LSM and its slot number, is created. There
> >> is an instance for each LSM, which assigns the name
> >> and passes it to the infrastructure to set the slot.
> >>
> >> The audit rules data is expanded to use an array of
> >> security module data rather than a single instance.
> >> Because IMA uses the audit rule functions it is
> >> affected as well.
> > This patch is quite large, even without the audit rule change.  I would
> > limit this patch to the new lsm_id structure changes.  The audit rule
> > change should be broken out as a separate patch so that the audit
> > changes aren't hidden.
> 
> Breaking up the patch in any meaningful way would require
> scaffolding code that is as extensive and invasive as the
> final change. I can do that if you really need it, but it
> won't be any easier to read.

Hidden in this patch is the new behavior of security_audit_rule_init(),
security_audit_rule_free(), and security_audit_rule_match().  My
concern is with label collision.  Details are in a subsequent post. 
Can an LSM prevent label collision?

> 
> > In addition, here are a few high level nits:
> > - The (patch description) body of the explanation, line wrapped at 75
> > columns, which will be copied to the permanent changelog to describe
> > this patch. (Refer  Documentation/process/submitting-patches.rst.)
> 
> Will fix.
> 
> > - The brief kernel-doc descriptions should not have a trailing period. 
> > Nor should kernel-doc variable definitions have a trailing period. 
> > Example(s) inline below.  (The existing kernel-doc is mostly correct.)
> 
> Will fix.
> 
> > - For some reason existing comments that span multiple lines aren't
> > formatted properly.   In those cases, where there is another change,
> > please fix the comment and function description.
> 
> Can you give an example? There are multiple comment styles
> used in the various components.

Never mind.  All three examples are in tomoyo.

> I don't see any comments on the ima code changes. I really
> don't want to spin a new patch set that does nothing but change
> two periods in comments only to find out two months from now
> that the code changes are completely borked. I really don't
> want to go through the process of breaking up the patch that has
> been widely Acked if there's no reason to expect it would require
> significant work otherwise.

Understood.

