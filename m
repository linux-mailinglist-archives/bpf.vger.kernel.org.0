Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDF6DD409
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 09:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDKHXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDKHXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 03:23:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFC1728;
        Tue, 11 Apr 2023 00:23:32 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5oLMK019046;
        Tue, 11 Apr 2023 07:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jx6ec3n4+Q018kA05bpZ4S4XVg3SaIZoPHl0RO8efsY=;
 b=sy3/HVgtWc3RKyyBGjbNS48nYmcwrL4porSdU93DJ01UJpiC9K+chQhNejUA8+3QE2Nv
 WDfF+KxwVg6ES6YRDtaoUd5PddrB4hdFxPPtg5pZFtGi/7P4uiJNmvDtnBDxfJwEPFS3
 6KCgvOZ3aT4QNKHpyym1cjN7HWOY45FAVq836Z9tWpT2JLCyoF2aDUCa45VeQWhKrNmc
 AIlnU9Nm9sg22iDtzVbjikIkIVbyO0MerDJZFQV2ngU8CvGSXJyEmR/sRpX0asc8B9iu
 to31TYtVWujOGyZ/M6OQu2s22dMqXbxV39lRGfhRcrZWBg3DluJ0zVeOnOyoiwfpd3NW dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj2usk5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:23:02 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33B6fElf024954;
        Tue, 11 Apr 2023 07:23:02 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj2usk52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:23:02 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B47f9W020781;
        Tue, 11 Apr 2023 07:23:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pu0jgy4nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 07:23:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33B7Mx1w13959918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 07:22:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2884758067;
        Tue, 11 Apr 2023 07:22:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A0EE58052;
        Tue, 11 Apr 2023 07:22:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.109.203])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Apr 2023 07:22:54 +0000 (GMT)
Message-ID: <1496aa1d378c3d7dc1b112b0d81fa7459aaee143.camel@linux.ibm.com>
Subject: Re: [PATCH v10 4/4] evm: Support multiple LSMs providing an xattr
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
Date:   Tue, 11 Apr 2023 03:22:52 -0400
In-Reply-To: <20230331123221.3273328-5-roberto.sassu@huaweicloud.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
         <20230331123221.3273328-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xnLuj3iiRxW414W3ggGW-iv_bI3t9Pr4
X-Proofpoint-ORIG-GUID: EMwnd3qD--UhdWadvezBYKMYJDSWph4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110065
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-31 at 14:32 +0200, Roberto Sassu wrote:
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

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

