Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64C140831
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 11:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgAQKoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 05:44:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgAQKoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 05:44:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HAhrjm009743;
        Fri, 17 Jan 2020 10:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Ulxn1uAtoZmo2eD1oSEZ9gbUUqYF6C/213tnsDyWzSk=;
 b=sXxQk0qJDP3fDmaVaVCMIp5heSrDDtsXWWZcV6/SMkygHuTQzQjgvCXUi5widw8IfNKs
 pMi1V1OCF9t0hBwqdf68s6zyPAROn5T/cBPeMcW7tNNvZVXH9N4YsmKp/XpgV7cUpyXK
 /L5a8tcl3T9hOZQM31pxvExn9qThB2i7WvbHew9HMlD05vdyt7NZPQVV3PrX2D7dch3z
 qZEkpj4D1sjFcLTMk3b1s9OE3Zisoce61xhuv4B1/2TDIZoM2pUZrt9dx4YTdlC04Hgt
 ClNx4V4Zbq/WegoNkFHViWXQnRH+OkZtkRiRZDVMW1Xao4T1Svc/ILPRvkWbLZ5mmQkP yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xf74sqyhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 10:44:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HAhFhv086380;
        Fri, 17 Jan 2020 10:44:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xk231kq7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 10:44:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00HAi7Ii026936;
        Fri, 17 Jan 2020 10:44:07 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 02:44:06 -0800
Date:   Fri, 17 Jan 2020 13:44:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     brianvv@google.com
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Add generic support for update and delete batch ops
Message-ID: <20200117104400.iwfowq7z4epdvoww@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=889
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=935 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170083
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Brian Vazquez,

The patch aa2e93b8e58e: "bpf: Add generic support for update and
delete batch ops" from Jan 15, 2020, leads to the following static
checker warning:

	kernel/bpf/syscall.c:1322 generic_map_update_batch()
	error: 'key' dereferencing possible ERR_PTR()

kernel/bpf/syscall.c
  1296  
  1297          value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
  1298          if (!value)
  1299                  return -ENOMEM;
  1300  
  1301          for (cp = 0; cp < max_count; cp++) {
  1302                  key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
  1303                  if (IS_ERR(key)) {
  1304                          err = PTR_ERR(key);
  1305                          break;
                                ^^^^^
This will Oops.

  1306                  }
  1307                  err = -EFAULT;
  1308                  if (copy_from_user(value, values + cp * value_size, value_size))
  1309                          break;
  1310  
  1311                  err = bpf_map_update_value(map, f, key, value,
  1312                                             attr->batch.elem_flags);
  1313  
  1314                  if (err)
  1315                          break;

But the success path seems to leak.  Anyway, either we free the last
successful key or we are leaking so this doesn't seem workable.  Does
map->key_size change?  Maybe move the allocation from __bpf_copy_key()
to before the start of the loop.

  1316          }
  1317  
  1318          if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
  1319                  err = -EFAULT;
  1320  
  1321          kfree(value);
  1322          kfree(key);
  1323          return err;
  1324  }

regards,
dan carpenter
