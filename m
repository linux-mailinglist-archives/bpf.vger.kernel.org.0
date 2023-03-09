Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1116B2527
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 14:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCINVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 08:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCINVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 08:21:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85238E774C;
        Thu,  9 Mar 2023 05:21:09 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329BccuI012218;
        Thu, 9 Mar 2023 13:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WEz7BO8+ajxS9eCq+lqQ7DIMzSCHr5auoNdc23ad+K8=;
 b=LlWTFawZrtJtuEuavvdauxTr4ZhfjlOHYsUVCZSLT+ZjSV+6YeP5Uc96fqVw3q+Pjf6c
 96HKMpCBB2KVCB92T1iOsvLfDZdC+PoVhf+MULXatruLo+j9I20prWYZVzRE27v1QiU8
 GjPtWpbaPWir3OWH9XKMIpFiaOdqqX99OJj0mLy0iAZIlCtAjoAPoNLxe0fKWGOfhHhW
 k8J5TLtoYpvDOOpNGbyUYlYQuPYjTSx7Kg6tds7BrZrV4ra/C5ALXsNAJ/OM1Gkos7Vm
 m8AF4HqeoGQdPu+/mBt+IjvbU5wtx8qOS50JtO+gxHe91tRpooHU7zozTMJxL/Cg/a+j 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6ry4bv9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 13:20:47 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329CLqej010251;
        Thu, 9 Mar 2023 13:20:47 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6ry4bv97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 13:20:46 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329AmYQC014453;
        Thu, 9 Mar 2023 13:20:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3p6fhhsc6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 13:20:45 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329DKiPP64815552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 13:20:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A462D58055;
        Thu,  9 Mar 2023 13:20:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0AFB58043;
        Thu,  9 Mar 2023 13:20:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.90.179])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 13:20:43 +0000 (GMT)
Message-ID: <9ff8cb053e5152694d890a7158131a60c652bdfc.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] Revert "integrity: double check iint_cache was
 initialized"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 09 Mar 2023 08:20:43 -0500
In-Reply-To: <20230309085433.1810314-3-roberto.sassu@huaweicloud.com>
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
         <20230309085433.1810314-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fqyfopSoXQBUr94ANipqiuCIRD7HwXKc
X-Proofpoint-ORIG-GUID: QdSAyH-uX1myabKYCRMMhzc1fnbhGBFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=798 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> With the recent introduction of LSM_ORDER_LAST, the 'integrity' LSM is
> always initialized and the iint_cache is always created (the kernel panics
> on error). Thus, the additional check of iint_cache in
> integrity_inode_get() is no longer necessary.
> 
> This reverts commit 92063f3ca73aab794bd5408d3361fd5b5ea33079.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

