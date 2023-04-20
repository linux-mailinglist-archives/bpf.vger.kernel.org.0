Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C56E90AF
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjDTKqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjDTKpi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 06:45:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B525FE9;
        Thu, 20 Apr 2023 03:44:52 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K9OBMs020332;
        Thu, 20 Apr 2023 10:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JiP4gaodXYE5HqdkzObSDp1lyfjXWhoq3PMYmdlsmkI=;
 b=UBmdFr4z5vi+OCGrGzJRjVwynCNjsEGshJFbizog0JX6dFd5v2HW268zR2hdJBQPzpvp
 ufTkv58EVnf+uOpHegmGYYQAzjMsGBkagych/iPTha7NP0hhb74J7KA0qGxfesXj5QkJ
 4TRMC0gfKBJHThcQ9Tx010WFKYjiaHeoBG4ObjtTDh+iPEDJ6Jw/ft1L7rtE37UoXnQc
 bAdTfvZ0ys4BPwWfpevCR+Qv2n5/AKgyVg9651yvrobAyWQzOr3eu+TPpVFeLVCau3xZ
 3jC5J/CXudsZ6QttEToqLklqNaf7/kMVX+V/rg6Aa7LWC54aCx8RpSXaSSOscsWZZfGu 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q32qvtpwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:44:07 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33KAW1vP031769;
        Thu, 20 Apr 2023 10:44:06 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q32qvtpve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:44:06 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33K97YPM010080;
        Thu, 20 Apr 2023 10:44:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3pykj7krdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:44:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33KAi3SO12452206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 10:44:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25B0158045;
        Thu, 20 Apr 2023 10:44:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC4F958052;
        Thu, 20 Apr 2023 10:44:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.16.65])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Apr 2023 10:44:00 +0000 (GMT)
Message-ID: <97849695ef53ab3186e59d8a2c6b74812f13ee19.camel@linux.ibm.com>
Subject: Re: [PATCH] Smack modifications for: security: Allow all LSMs to
 provide xattrs for inode_init_security hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mengchi Cheng <mengcc@amazon.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, kamatam@amazon.com,
        yoonjaeh@amazon.com
Date:   Thu, 20 Apr 2023 06:44:00 -0400
In-Reply-To: <a98ddf946c474a3500bdcd72766c6cb0043278ff.camel@huaweicloud.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
         <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
         <2dc6486f-ce9b-f171-14fe-48a90386e1b7@schaufler-ca.com>
         <8e7705972a0f306922d8bc4893cf940e319abb19.camel@huaweicloud.com>
         <72b46d0f-75c7-ac18-4984-2bf1d6dad352@schaufler-ca.com>
         <82ee6ddf66bb34470aa7b591df4d70783fdb2422.camel@huaweicloud.com>
         <91f05dc4-a4b7-b40a-ba1a-0ccc489c84b2@schaufler-ca.com>
         <5c50d98f1e5745c88270ae4ad3de6d9a803db4c6.camel@huaweicloud.com>
         <48c6073f-59b0-f5d1-532e-fe4b912b939d@schaufler-ca.com>
         <0fccab67e496f10f4ee7bf2220e70a655013935f.camel@huaweicloud.com>
         <c16dd895-f488-241d-0be8-e56e5f0c1adb@schaufler-ca.com>
         <a98ddf946c474a3500bdcd72766c6cb0043278ff.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YMT3HG0ZS9vIkqH-n2uqmA3l0ZvnTJcF
X-Proofpoint-ORIG-GUID: HmNKNdJGFNLBRcpC25uuB5H0hmVx9xdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=860
 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-04-20 at 10:50 +0200, Roberto Sassu wrote:
> > 
> > It's possible. It's been a long time since I've looked at this.
> > I'm tempted to take a change to make overlayfs work upstream and
> > then worry about the ima changes. There seems to be a lot more
> > going on with the ima changes than is obvious from what's in the
> > Smack code.

It doesn't sound like the patch set introduces the overlayfs bug.

The security_inode_init_security() change to initialize multiple LSMs
and IMA xattrs and include them in the EVM hmac calculation is straight
forward.

In addition, the patch set creates the infrastructure for allowing
multiple per LSM xattrs, as requested, to be initialized in
security_inode_init_security() and included in the EVM hmac.

Mimi

> We could also set only SMACK64 in smack_inode_init_security(), and move
> SMACKTRANSMUTE64 later, when we figure out how to fix the case of
> overlayfs.
> 
> IMA and EVM would work in both cases.

