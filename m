Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3C6D4246
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjDCKjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCKjR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 06:39:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09918113FD;
        Mon,  3 Apr 2023 03:38:41 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33390Miu029440;
        Mon, 3 Apr 2023 10:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6Znlgc7WgH1YZnYgmuzPeUYORB1yzDqcHa2rVABuxc4=;
 b=IUYkLbtVR7usaQuKXuG914mA0g/1veQghrL12MU8R3zQaCrcNzfisFbQlAuWLfDsp277
 G50YhmEr4jviXpf3hHMoPzTFGWXEu2u7rjSFTaJ0NA5U3F8amhqLSdwaaN1k+nQqRW/J
 V9RSL9OAsCX3SVYu+k56mVQzJi1cfUlmcdLZfA81+x54ZnbnazUJ0Q9fxyh9tXXCgHbw
 O49BSpBBeaD8YulWRdokV46Dq2+BxsG3CpHgaz42v7tgWqjPlQgmZcyQIXsRlw+lvQfG
 TtvMGGt3nlWDEngOR2NQP+Xv9OgdnED7glvQfMv1eXuuhN+VxqpCxiigrZZzZvvMdfxS 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ppxfpmdve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:36:42 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3339xDUV039018;
        Mon, 3 Apr 2023 10:36:42 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ppxfpmduv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:36:42 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3339ESW0024232;
        Mon, 3 Apr 2023 10:36:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3ppc882t8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:36:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 333Aae4t6816460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Apr 2023 10:36:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64C1658084;
        Mon,  3 Apr 2023 10:36:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CA1D58073;
        Mon,  3 Apr 2023 10:36:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.66.117])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Apr 2023 10:36:34 +0000 (GMT)
Message-ID: <3b6c773045d73ba1dcdb80dd9c6b7afcbd62cc42.camel@linux.ibm.com>
Subject: Re: [PATCH v10 0/4] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 03 Apr 2023 06:36:33 -0400
In-Reply-To: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sxJ74yMfVWLH41Y5N-hjWHNpZVqNXdwZ
X-Proofpoint-GUID: IA7nyyfi-xTkiObYp5aOGV0h4F5zZvU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_06,2023-04-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=587 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030080
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:

> Changelog
> 
> v9:
> - Ensure in reiserfs_security_write() that the full xattr name is not
>   larger than XATTR_NAME_MAX
> - Rename num_filled_xattrs to xattr_count everywhere (suggested by Paul)
> - Rename lsm_find_xattr_slot() to lsm_get_xattr_slot() and add a proper
>   documentation (suggested by Paul)
> - Return zero instead of -EOPNOTSUPP in evm_inode_init_security()
>   (suggested by Paul)
> - Remove additional checks of new_xattrs array in
>   security_inode_init_security() (suggested by Paul)
> - Handle the !initxattrs case similarly to the initxattrs case, except for
>   not allocating the new_xattrs array in the former (suggested by Paul)
> - Remove local variable xattr in security_inode_init_security(), and use
>   xattr_count instead for loop termination (suggested by Paul)
> 
> v8:
> - Add a new reiserfs patch to write the full xattr name
> - Add num_filled_xattrs parameter to inode_init_security hook (suggested by
>   Paul) and evm_inode_init_security()
> - Change default return value of inode_init_security hook to -EOPNOTSUPP
> - Rename lbs_xattr field of lsm_blob_sizes to lbs_xattr_count
> - Introduce lsm_find_xattr_slot() helper
> - Rename lsm_xattr parameter of evm_init_hmac() to xattrs
> - Retrieve the EVM xattr slot with lsm_find_xattr_slot() and double check
>   with the xattr array terminator
> - Remove security_check_compact_filled_xattrs() (suggested by Paul)

Much better without security_check_compact_filled_xattrs().  Thank you!

> - Update security_inode_init_security() documentation
> - Ensure that inode_init_security hook incremented the number of filled
>   slots if it returned zero
> - Ensure that xattr name and value are non-NULL in the filled slots
> - Add the xattr name assignment after the xattr value one (suggested by
>   Paul)
> - Drop patches 1 - 3 (already in lsm/next)
> 

-- 
thanks,

Mimi

