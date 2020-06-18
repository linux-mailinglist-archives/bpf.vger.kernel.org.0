Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA91C1FF4B1
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFRO32 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 10:29:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35156 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFRO31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 10:29:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IELZHo133582;
        Thu, 18 Jun 2020 14:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=LhaF5/Sqsn5WLlV15mIAc0+YEA2vD96TuLei0ftzEx8=;
 b=ObWqQkstrYCYAMSpe9+rjgFId0JHN6wm+y8VG788XEju+eLlp+OeE776hNG8HFN/L899
 Jyw4Z7fnpNn8H4Uug+IhWmAvvlAzEl0vrhuInvNfti4+OV8VETcACmqfY7lqQwSz3UnL
 Z9QL/wkRMuQCc3QFTamGFIkATwZvxPB9RyLhj/WhsBHAWu+z5qOOyWFaaCaYN2lkEz6q
 SHXQLjbnOLoEpgIHvZ2GRfbHMfbwwWt353UbTCpzaPOcPNG8GC+748HZGMe4TfoeG+dI
 UsRCRYaNWKX4aSHJvQoq7nrzTyLvWosKKSjFXOVckVr1iXF5ejSnGdjr7JFy/NaG7uUX 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31qg357ge8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 14:29:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IEHHrT090666;
        Thu, 18 Jun 2020 14:27:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31q66sc823-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 14:27:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05IERJtb018821;
        Thu, 18 Jun 2020 14:27:21 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 07:27:19 -0700
Date:   Thu, 18 Jun 2020 17:27:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     sargun@sargun.me
Cc:     bpf@vger.kernel.org, Kees Cook <keescook@google.com>
Subject: [bug report] seccomp: Add find_notification helper
Message-ID: <20200618142714.GA202183@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=791
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=796 spamscore=0
 suspectscore=3 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180110
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Kees, why am I getting tons and tons of these warnings?  Are we not
  going to initialize things manually any more? ]

Hello Sargun Dhillon,

The patch 186f03857c48: "seccomp: Add find_notification helper" from
Jun 1, 2020, leads to the following static checker warning:

	kernel/seccomp.c:1124 seccomp_notify_recv()
	error: uninitialized symbol 'knotif'.

kernel/seccomp.c
  1091  static long seccomp_notify_recv(struct seccomp_filter *filter,
  1092                                  void __user *buf)
  1093  {
  1094          struct seccomp_knotif *knotif, *cur;
                                       ^^^^^^
This used to be initialized to NULL here.

  1095          struct seccomp_notif unotif;
  1096          ssize_t ret;
  1097  
  1098          /* Verify that we're not given garbage to keep struct extensible. */
  1099          ret = check_zeroed_user(buf, sizeof(unotif));
  1100          if (ret < 0)
  1101                  return ret;
  1102          if (!ret)
  1103                  return -EINVAL;
  1104  
  1105          memset(&unotif, 0, sizeof(unotif));
  1106  
  1107          ret = down_interruptible(&filter->notif->request);
  1108          if (ret < 0)
  1109                  return ret;
  1110  
  1111          mutex_lock(&filter->notify_lock);
  1112          list_for_each_entry(cur, &filter->notif->notifications, list) {
  1113                  if (cur->state == SECCOMP_NOTIFY_INIT) {
  1114                          knotif = cur;
                                ^^^^^^^^^^^^

  1115                          break;
  1116                  }
  1117          }
  1118  
  1119          /*
  1120           * If we didn't find a notification, it could be that the task was
  1121           * interrupted by a fatal signal between the time we were woken and
  1122           * when we were able to acquire the rw lock.
  1123           */
  1124          if (!knotif) {
                     ^^^^^^
But now it's uninitialized.

  1125                  ret = -ENOENT;
  1126                  goto out;
  1127          }
  1128  
  1129          unotif.id = knotif->id;

regards,
dan carpenter
