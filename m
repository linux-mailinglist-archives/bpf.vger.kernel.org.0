Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7746B2524
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 14:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCINVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCINVJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 08:21:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A2AE6FFE;
        Thu,  9 Mar 2023 05:21:06 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329D4eCA029648;
        Thu, 9 Mar 2023 13:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pNHCbqRQafX/ACjbDKS29OWZUQTgc8vIxhSBvT7xme0=;
 b=O8GRs4Es2Mmgk28NSbkjteFHV5l4cwoUOZselt2XH4yHzePswClyXxp3ncTvedAd6Nak
 0+HSYUmdGPzqBYUrouOE7ASckr6rQliLQDObM7uyd2fiwf3M1UVPlbM7Noa9YZPdKTHS
 Ivtf1mBSI5O+db7EU08zvZAE3Z3+eagkFASETr6m/MnNmfG6X6ZZYiYjYQFDsm1ixVIf
 SnuCZjDWbQj9E1/BW3Hb1YnHj3naHSA2IM6U/HcKHzXR3ME6gdLZq95g1sh0p2WHM9uV
 5mMHEPKhNsstpkkbGrpcN6W2m+bJUlMkAPL+qBKL3FZd/sJ6xUVJTJS+Re0MOXZKClk9 hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6t3bsxyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 13:20:38 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329D5bNm012989;
        Thu, 9 Mar 2023 13:20:38 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6t3bsxy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 13:20:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329CU4u4023573;
        Thu, 9 Mar 2023 13:20:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3p6fnwkpg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 13:20:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329DKZGS19268266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 13:20:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B82CF58061;
        Thu,  9 Mar 2023 13:20:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB4DA5805D;
        Thu,  9 Mar 2023 13:20:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.90.179])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 13:20:34 +0000 (GMT)
Message-ID: <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it
 for the integrity LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 09 Mar 2023 08:20:34 -0500
In-Reply-To: <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
         <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: klGFtrN_aONy7MWhWwYH4GEQF-YdaOII
X-Proofpoint-ORIG-GUID: Tf2q3-RDKlL0JJXY9cIGOIypQYWVQ3r8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=767 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to be
> last, e.g. the 'integrity' LSM, without changing the kernel command line or
> configuration.
> 
> Also, set this order for the 'integrity' LSM. While not enforced, this is
> the only LSM expected to use it.
> 
> Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> and put at the end of the LSM list.
> 
> Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> LSM is found, regardless of its order. In this way, the kernel would not
> wrongly report that the LSM is not built-in in the kernel if its order is
> LSM_ORDER_LAST.
> 
> Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

