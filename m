Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5569E63BEF0
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 12:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiK2L3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 06:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK2L3E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 06:29:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1ECFC;
        Tue, 29 Nov 2022 03:29:03 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATAXLRp019538;
        Tue, 29 Nov 2022 11:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MnZtI3qCPeSsGGVwj0/V6nXajPH3SFgaJQGfW01j3ic=;
 b=rQncSD1VH5hdQRwDMfFA2TfHGiev9ml+8XaKhW5deeAmiGaciRs7IWuJ7MkPacvGG/wn
 IMYFgPo6qLFk+0SkEexNITvFfB04hxh4iYc7bis8LzEiX6enawm3KV1qC7jskpFKSP/Z
 PNkzw5lBhlgozN+6Jml4h1gdMLK3W+ul6pEIrqrxHf8cebP1MvFyFXAY76islpxG8u1G
 q+XrOBaB+z87Wdtvr98arTiVXo1l7kNlNjoVfYkYm2zUUAYLEFaSWpy9Xmimvr+Ab8qi
 ktkUM4UNCPokjsJoof7g/5ZNBO8/QFRzAl/kG2vsEg7O4JGPSGjvh1HV6ifRQUQz11TL gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5cmufbgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:28:14 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ATAFrxm010355;
        Tue, 29 Nov 2022 11:28:14 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5cmufbgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:28:13 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATBJt8M027068;
        Tue, 29 Nov 2022 11:28:13 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3m3ae9h3vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:28:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATBSB5c34341182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 11:28:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D8485805C;
        Tue, 29 Nov 2022 11:28:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 366ED58051;
        Tue, 29 Nov 2022 11:28:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.96.78])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Nov 2022 11:28:10 +0000 (GMT)
Message-ID: <086b6d26895b84ad4086ac9f191ede6f705f9b6b.camel@linux.ibm.com>
Subject: Re: [PATCH v5] evm: Correct inode_init_security hooks behaviors
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     philippe.trebuchet@ssi.gouv.fr, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        bpf@vger.kernel.org, roberto.sassu@huaweicloud.com
Date:   Tue, 29 Nov 2022 06:28:09 -0500
In-Reply-To: <Y4Dl2yjVRkJvBflq@archlinux>
References: <Y4Dl2yjVRkJvBflq@archlinux>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qKe5DMS6fIb7nqAWZgY70vaTK1HEVkyA
X-Proofpoint-GUID: TReY5TCtwN9OpWyPftIKY2s3ESh8OahH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-11-25 at 16:57 +0100, Nicolas Bouchinet wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Fixes a NULL pointer dereference occurring in the
> `evm_protected_xattr_common` function of the EVM LSM. The bug is
> triggered if a `inode_init_security` hook returns 0 without initializing
> the given `struct xattr` fields (which is the case of BPF) and if no
> other LSM overrides thoses fields after. This also leads to memory
> leaks.
> 
> The `call_int_hook_xattr` macro has been inlined into the
> `security_inode_init_security` hook in order to check hooks return
> values and skip ones who doesn't init `xattrs`.
> 
> Modify `evm_init_hmac` function to init the EVM hmac using every
> entry of the given xattr array.
> 
> The `MAX_LSM_EVM_XATTR` value is now based on the security modules
> compiled in, which gives room for SMACK, SELinux, Apparmor, BPF and
> IMA/EVM security attributes.
> 
> Changes the default return value of the `inode_init_security` hook
> definition to `-EOPNOTSUPP`.
> 
> Changes the hook documentation to match the behavior of the LSMs using
> it (only xattr->value is initialised with kmalloc and thus is the only
> one that should be kfreed by the caller).
> 
> Cc: roberto.sassu@huaweicloud.com
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

What  is the relationship between this patch and Roberto's patch set? 
Roberto, if there is an overlap, then at minimum there should be a
Reported-by tag indicating that your patch set addresses a bug reported
by Nicolas.

-- 
thanks,

Mimi

