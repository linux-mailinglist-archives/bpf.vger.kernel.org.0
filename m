Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCCDD6220
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfJNMNx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Oct 2019 08:13:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfJNMNx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Oct 2019 08:13:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EC9JES116386;
        Mon, 14 Oct 2019 12:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=drowqFol6Rrr0GLm0Fgl3yA2hycpTzI6ZIAW3QCCM6M=;
 b=bhh6abygd5NYA8NmrkxoQvKLHyYhDhrbYPMDYqsyBbN9gqb30Yckjtjt9Rx+Nq0Emsl5
 W6tD+fe6l9ktuRFfMkMqU2aBYUh6U3qZ+ED1A0d9u8JYxhFIT+DJdZqyl36Srgnq7ZiG
 egfQgpB3Yxa29htslJNwfMP7kmieRnw4bdsn8w+GIKDqHDVLvIyJ7rOW3Gf87GwjdHKP
 FKyjBZRgYQYw0z4PnUHfEtECWxCcjnjKycgfwBtZy84XYkG9QLAola6ADgq6jTJ2S4CK
 EYsyDEwzIYSLK3HRXhLu/nNFcaezXWgDx5GYuK7+0rWhpEDRKdnzZT7ovAKAM+K0IyIb lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vk7fr0aah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 12:13:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EC7kbo034741;
        Mon, 14 Oct 2019 12:13:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vkry64b9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 12:13:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9ECDceP009233;
        Mon, 14 Oct 2019 12:13:38 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 12:13:36 +0000
Date:   Mon, 14 Oct 2019 15:13:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     daniel@iogearbox.net
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf, sockmap: convert to generic sk_msg interface
Message-ID: <20191014121330.GA14089@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=611
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=714 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140120
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Daniel Borkmann,

This is a semi-automatic email about new static checker warnings.

The patch 604326b41a6f: "bpf, sockmap: convert to generic sk_msg
interface" from Oct 13, 2018, leads to the following Smatch complaint:

    net/core/skmsg.c:792 sk_psock_write_space()
    error: we previously assumed 'psock' could be null (see line 790)

net/core/skmsg.c
   789		psock = sk_psock(sk);
   790		if (likely(psock && sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)))
                           ^^^^^
Check for NULL

   791			schedule_work(&psock->work);
   792		write_space = psock->saved_write_space;
                              ^^^^^^^^^^^^^^^^^^^^^^^^

   793		rcu_read_unlock();
   794		write_space(sk);
                ^^^^^^^^^^^^^^
The warning is on the wrong line.  The dereference is really here.

regards,
dan carpenter
