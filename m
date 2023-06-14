Return-Path: <bpf+bounces-2610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3BB730BD7
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 01:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D016B1C20DB5
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 23:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC09171A0;
	Wed, 14 Jun 2023 23:56:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242D125C5
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 23:56:23 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241071FD4;
	Wed, 14 Jun 2023 16:56:22 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENlh3V026988;
	Wed, 14 Jun 2023 23:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=em1Oy/ZXJogHXMF15eFq+xLsfAk1Tg9tnkKe6mZVrbk=;
 b=KDKzgmlYEHwwvkRA5T771c4ageC8lnPTLK4j/zQ7Uaacd9fu1Q3Vk4OYyUxjx6IyucgG
 YfZAWkCOz/Na90oFKgmJg20XYd+oAPpCugMMfOZ5NWvBiX3PpImHqEN70gjpARaZDDGc
 zqy+SXe7JSrR1p1V3UEVmsAA6GSfbDnfEcM927tYRU6/HLoZKV3ARvtCwfwBA2KFzQa+
 3omZAsIjMd6/VjazBWEP8/lpqnRHvX5CChsXfsZu9AxL4YjUX0D4VSUH29LhXCWxHFvC
 KiMRHNoQdAKJseWFhXTDruihxH12pZTgF2/WqIqf+cdBSL3FxlGIdDqecuFLRpoSQFMp ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7qhf847m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jun 2023 23:55:51 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35ENnFtF030725;
	Wed, 14 Jun 2023 23:55:51 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7qhf847a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jun 2023 23:55:51 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKfiFC002759;
	Wed, 14 Jun 2023 23:55:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
	by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5g4qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jun 2023 23:55:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35ENtmjS56295736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jun 2023 23:55:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB5B958053;
	Wed, 14 Jun 2023 23:55:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E82FA58043;
	Wed, 14 Jun 2023 23:55:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.215])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jun 2023 23:55:46 +0000 (GMT)
Message-ID: <6af688eba06f6a89632fbf4afcd47cbb8c790183.camel@linux.ibm.com>
Subject: Re: [PATCH v12 4/4] evm: Support multiple LSMs providing an xattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 14 Jun 2023 19:55:46 -0400
In-Reply-To: <20230610075738.3273764-5-roberto.sassu@huaweicloud.com>
References: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
	 <20230610075738.3273764-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2rTFnRN5fpu42bPG-G4_Qq-LcYHFpQSx
X-Proofpoint-GUID: 72iNxXHhB3aam4APkdBzXTGgPwL2_OO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140206
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-06-10 at 09:57 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Currently, evm_inode_init_security() processes a single LSM xattr from the
> array passed by security_inode_init_security(), and calculates the HMAC on
> it and other inode metadata.
> 
> As the LSM infrastructure now can pass to EVM an array with multiple
> xattrs, scan them until the terminator (xattr name NULL), and calculate the
> HMAC on all of them.
> 
> Also, double check that the xattrs array terminator is the first non-filled
> slot (obtained with lsm_get_xattr_slot()). Consumers of the xattrs array,
> such as the initxattrs() callbacks, rely on the terminator.
> 
> Finally, change the name of the lsm_xattr parameter of evm_init_hmac() to
> xattrs, to reflect the new type of information passed.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, Roberto!

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


