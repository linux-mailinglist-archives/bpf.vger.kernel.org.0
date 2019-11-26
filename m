Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB0109DC6
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2019 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfKZMUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Nov 2019 07:20:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48134 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfKZMUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Nov 2019 07:20:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQCK6C2105629;
        Tue, 26 Nov 2019 12:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=+gyQe7HUxkbsL59FzaYQ2JeYf6Xz0dTrb40Fk4tfD64=;
 b=g+MgcLObSJe+SiKUkjEsPgypSb4muLeoUxIP/b2avFWV9YPCBz9YHDsGP2ywjfjAVqV4
 22NpeoHuZ72ZOmnq8SE9OMvRqqENP08ygjuYWU03zlusTGgivXn1a27RVvI2xdTJgXMv
 yNQ+aS82iLhWvP6c7MmG3vKOkv7vTbNjGJtNRSY6pdsrx9AIlWIv0JkWyUNV3jwm2snj
 geHfWRHP+MRAr0p0Nazk1w63TSmZHXO1FsMCGl7rHdLroU7HJ4OBFDCIfNZzKqTTr475
 2mmhJUK9ssjixymYaoieAy7I8qQsg5Jh/zjkj+nsBJwllpgOr9u/heI6MzvUvo1ccN0o 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wewdr6b6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:20:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQC8VIn017098;
        Tue, 26 Nov 2019 12:20:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wh0rbe77n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 12:20:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQCK4t2021338;
        Tue, 26 Nov 2019 12:20:04 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 04:20:03 -0800
Date:   Tue, 26 Nov 2019 15:19:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Introduce BPF trampoline
Message-ID: <20191126121957.6gda4xqy3pacuny3@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=460
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=522 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260110
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Alexei Starovoitov,

The patch fec56f5890d9: "bpf: Introduce BPF trampoline" from Nov 14,
2019, leads to the following static checker warning:

	kernel/bpf/btf.c:4023 btf_distill_func_proto()
	error: potentially dereferencing uninitialized 't'.

kernel/bpf/btf.c
  4012          nargs = btf_type_vlen(func);
  4013          if (nargs >= MAX_BPF_FUNC_ARGS) {
  4014                  bpf_log(log,
  4015                          "The function %s has %d arguments. Too many.\n",
  4016                          tname, nargs);
  4017                  return -EINVAL;
  4018          }
  4019          ret = __get_type_size(btf, func->type, &t);
                                                       ^^
t isn't initialized for the first -EINVAL return

  4020          if (ret < 0) {
  4021                  bpf_log(log,
  4022                          "The function %s return type %s is unsupported.\n",
  4023                          tname, btf_kind_str[BTF_INFO_KIND(t->info)]);
                                                                  ^^^^^^^
  4024                  return -EINVAL;
  4025          }
  4026          m->ret_size = ret;

See also:
kernel/bpf/btf.c:4033 btf_distill_func_proto() error: potentially dereferencing uninitialized 't'.

regards,
dan carpenter
