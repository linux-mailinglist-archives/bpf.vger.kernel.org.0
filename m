Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6666B4076
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCJNbA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 08:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCJNa4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 08:30:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150B102846;
        Fri, 10 Mar 2023 05:30:55 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACd6Ld030835;
        Fri, 10 Mar 2023 13:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GTR48I5yJ/RNnamwL4P7QvGoOw+EjQHp0wyMDzEWV7I=;
 b=Z935lRbVlAdYxnYjNLWL8UuvOA/XavjOsbR07DebrXG/q9OXFgnI+Y/l8LBtzJFHfuPY
 N4RcsM7LwRjoT2ErakvJqNoqDWcrbTdZEqjsm+WRvAvtyO2KPFjpy1qOTpNSTzBJuXzD
 S00bfUPz0DPRRnfLVwMUcsA/QQ2u2r6B9Hwd+kb/0JOyNCbenopBx86relSxhWVwSNbS
 jax4GHV7/U/ocWovSIkDUlzFxLMBbYYZEO5JmKzbTvRW4bjCpMhRYdSwabgHQUwHN88B
 K4vFqzcMkLxsyYZRuLuVZu5WLRjFpxNkGpD17ctxsq6F5mPKaYlyyuDuvYf+klQRZO0o pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p80wdpxrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:26 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32ACdDYW031102;
        Fri, 10 Mar 2023 13:30:26 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p80wdpxqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:25 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32ABqB1g023581;
        Fri, 10 Mar 2023 13:30:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3p6fnwtwy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADUNXS62980426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:30:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C67E58059;
        Fri, 10 Mar 2023 13:30:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2127A58043;
        Fri, 10 Mar 2023 13:30:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.71.208])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:30:22 +0000 (GMT)
Message-ID: <e482fa5c364bfc58aebc938a4c07e61f0fe71c88.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/3] Revert "integrity: double check iint_cache was
 initialized"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Mar 2023 08:30:21 -0500
In-Reply-To: <20230310085401.1964889-3-roberto.sassu@huaweicloud.com>
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
         <20230310085401.1964889-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PdVwvpzve-PNiPkNtDZ6yRCCgJhZaGA7
X-Proofpoint-GUID: 6F8gLLcXN7c__E-JuZqefJmsbpi_1MpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=780 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303100104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-10 at 09:54 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> With the recent introduction of LSM_ORDER_LAST, the 'integrity' LSM is
> always initialized (if selected in the kernel configuration) and the
> iint_cache is always created (the kernel panics on error). Thus, the
> additional check of iint_cache in integrity_inode_get() is no longer
> necessary. If the 'integrity' LSM is not selected in the kernel
> configuration, integrity_inode_get() just returns NULL.
> 
> This reverts commit 92063f3ca73aab794bd5408d3361fd5b5ea33079.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

