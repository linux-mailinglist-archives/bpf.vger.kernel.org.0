Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEF24FFA7
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXOPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 10:15:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXOPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 10:15:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OEDl9p087031;
        Mon, 24 Aug 2020 14:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=WlTllf3+qsSUWkFs3FMJP9D3QwySGo9UCDcc6PMhg1Y=;
 b=s4wPFdjF34XdDFuPMlNaY1X7D555Lr31mTjvpA770omnqkQEAn1gupYmm3zpEP1M1VnJ
 GWp2QFG+BJPEoYM1fKp6dRZpDGnz2vGVeQfur9Wq1DdCODJPi+hRSM7sMAQTvJs7Idis
 ryX1X8+fKMffOVwAUKzTnP2tnhNIQmaPz8AymNsiTNBw6LkLCn6h7AFFBpFHKNnDig9M
 vHNYjtezKIyfZOb+pB76b/qvvk+aVXRCnuWzRTMgK88MSLW5zoW1S70/BJ4YQ99bloBp
 7fWU0sd0pIJiAqC+l6hC126kVOoRfkZ/ejWCkHZU74tgDCybyfJacBOQMUSvpGuDiwuP aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 333dbrmsy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 14:15:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OE4Xqw005702;
        Mon, 24 Aug 2020 14:15:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 333rtwjxtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 14:15:27 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OEFOiS021390;
        Mon, 24 Aug 2020 14:15:26 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 07:15:24 -0700
Date:   Mon, 24 Aug 2020 17:15:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason@zx2c4.com
Cc:     bpf@vger.kernel.org
Subject: [bug report] net: WireGuard secure network tunnel
Message-ID: <20200824141519.GA223008@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=10
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240114
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Jason A. Donenfeld,

The patch e7096c131e51: "net: WireGuard secure network tunnel" from
Dec 9, 2019, leads to the following static checker warning:

	net/core/dev.c:10103 netdev_run_todo()
	warn: 'dev->_tx' double freed

net/core/dev.c
 10071          /* Wait for rcu callbacks to finish before next phase */
 10072          if (!list_empty(&list))
 10073                  rcu_barrier();
 10074  
 10075          while (!list_empty(&list)) {
 10076                  struct net_device *dev
 10077                          = list_first_entry(&list, struct net_device, todo_list);
 10078                  list_del(&dev->todo_list);
 10079  
 10080                  if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
 10081                          pr_err("network todo '%s' but state %d\n",
 10082                                 dev->name, dev->reg_state);
 10083                          dump_stack();
 10084                          continue;
 10085                  }
 10086  
 10087                  dev->reg_state = NETREG_UNREGISTERED;
 10088  
 10089                  netdev_wait_allrefs(dev);
 10090  
 10091                  /* paranoia */
 10092                  BUG_ON(netdev_refcnt_read(dev));
 10093                  BUG_ON(!list_empty(&dev->ptype_all));
 10094                  BUG_ON(!list_empty(&dev->ptype_specific));
 10095                  WARN_ON(rcu_access_pointer(dev->ip_ptr));
 10096                  WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 10097  #if IS_ENABLED(CONFIG_DECNET)
 10098                  WARN_ON(dev->dn_ptr);
 10099  #endif
 10100                  if (dev->priv_destructor)
 10101                          dev->priv_destructor(dev);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^
The wg_destruct() functions frees "dev".

 10102                  if (dev->needs_free_netdev)
                            ^^^^^
Use after free.

 10103                          free_netdev(dev);
 10104  
 10105                  /* Report a network device has been unregistered */
 10106                  rtnl_lock();
 10107                  dev_net(dev)->dev_unreg_count--;
 10108                  __rtnl_unlock();
 10109                  wake_up(&netdev_unregistering_wq);
 10110  
 10111                  /* Free network device */
 10112                  kobject_put(&dev->dev.kobj);
 10113          }
 10114  }

regards,
dan carpenter
