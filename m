Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F2B616244
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKBL4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKBL4O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:56:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD55209BB;
        Wed,  2 Nov 2022 04:56:13 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2BiuSP008864;
        Wed, 2 Nov 2022 11:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6wA4ORMLiohH2s/IWcjz13uh/wcATUDu4AptGbMKXBY=;
 b=FQvoU6ykUP1sKxu0R2cLQUgriPABt04zgaF31W3XmISKQrZgn0I6+uZotpfQCuVRkHOL
 Uw1xWU+T8Zt3MH0sRY0qYFEOk8db8qDrFk5TKi90DtKlKyGbKcPMVh9ldCs/GLtRPOoy
 RRyuqoicSfniYyxzmUZi+4BBWk64vbuanupVyfL5J0Qk47kNMaK1DDnVweYIyh4CLFcf
 X1+v08dtCoeBWhKP8n4TGr2v81AV/elx6bvhZZpTaW/JbJL8Cx681W7IEFsIGZ2jlvGt
 TidytV7sxrngW6S+a2Y7s8FIGNAym6Iew9lBztOTDzm3VX10g3ZaQFl4MpSdIfW7zxcj 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqxwg8gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 11:56:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2BjwtR011979;
        Wed, 2 Nov 2022 11:56:02 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqxwg8g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 11:56:02 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2Bol6M016860;
        Wed, 2 Nov 2022 11:56:02 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3kguta8yxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 11:56:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2Bu0Uw23003986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 11:56:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 614115805A;
        Wed,  2 Nov 2022 11:56:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6643858054;
        Wed,  2 Nov 2022 11:55:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.11.177])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 11:55:59 +0000 (GMT)
Message-ID: <135f442b44af0ac2bcd239c1f11c18c740f6e641.camel@linux.ibm.com>
Subject: Re: Possible bug or unintended behaviour using bpf_ima_file_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Isaac Matthews <isaac.jmatt@gmail.com>,
        linux-integrity@vger.kernel.org, bpf@vger.kernel.org
Cc:     isaac.matthews@hpe.com
Date:   Wed, 02 Nov 2022 07:55:58 -0400
In-Reply-To: <e45a4736e9fa77acbe48e947f40c023d3cd71922.camel@huaweicloud.com>
References: <CAFrssUQKyfZXXXQQA2vPMLR957RZtt7MN9rEG_VbLW_D0wBZ0w@mail.gmail.com>
         <e45a4736e9fa77acbe48e947f40c023d3cd71922.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: adbfpaV3dyrHxpnOXEiUn8tR5vkDKDdW
X-Proofpoint-GUID: x_JvrlWtPIjZPoU5djURo9_ceJkS5lEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_08,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-11-02 at 09:08 +0100, Roberto Sassu wrote:
> On Mon, 2022-10-31 at 16:25 +0000, Isaac Matthews wrote:
> > Using bpf_ima_file_hash() from kernel 6.0.
> > 
> > When using bpf_ima_file_hash() with the lsm.s/file_open hook, a hash
> > of the file is only sometimes returned.  This is because the
> > FMODE_CAN_READ flag is set after security_file_open() is already
> > called, and ima_calc_file_hash() only checks for FMODE_READ not
> > FMODE_CAN_READ in order to decide if a new instance needs to be
> > opened. Because of this, if a file passes the FMODE_READ check  it
> > will fail to be hashed as FMODE_CAN_READ has not yet been set.
> > 
> > To demonstrate: if the file is opened for write for example, when
> > ima_calc_file_hash() is called and the file->f_mode is checked
> > against
> > FMODE_READ, a new file instance is opened with the correct flags and
> > a
> > hash is returned. If the file is opened for read, a new file instance
> > is not returned in ima_calc_file_hash() as (!(file->f_mode &
> > FMODE_READ)) is now false. When __kernel_read() is called as part of
> > ima_calc_file_hash_tfm() it will fail on if (!(file->f_mode &
> > FMODE_CAN_READ)) and so no hash will be returned by
> > bpf_ima_file_hash().
> > 
> > If possible could someone please advise me as to whether this is
> > intended behaviour, and is it possible to either modify the flags
> > with
> > eBPF or to open a new instance with the correct flags set as IMA does
> > currently?
> 
> Hi Isaac
> 
> I think this is the intended behavior, as IMA is supposed to be called
> when the file descriptor is ready to use.
> 
> If we need to call ima_file_hash() from lsm.s/file_open, I think it
> should not be a problem to create a new fd just for eBPF, in
> __ima_inode_hash().
> 
> Mimi, what do you think?

Who/what is checking that this is a regular file and we have permission
to open the file?  Are we relying on eBPF to do this?  Will opening a
file circumvent all of the LSM checks?

> 
> > Alternatively, would a better solution be adding a check for
> > FMODE_CAN_READ to ima_calc_file_hash()? I noticed in the comment
> > above
> > the conditional in ima_calc_file_hash() that the conditional should
> > be
> > checking whether the file can be read, but only checks the FMODE_READ
> > flag which is not the only requirement for __kernel_read() to be able
> > to read a file.
> > 
> > Thanks for your help.
> > Isaac
> 


