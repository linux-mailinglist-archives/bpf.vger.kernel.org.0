Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF1424C6
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2019 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfFLLv4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jun 2019 07:51:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfFLLv4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 07:51:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CBmPFv092161;
        Wed, 12 Jun 2019 11:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=7/z+ZSfrKRpdILcAAErFy48UKp1nc3SBMbLRRt0nIsM=;
 b=Z7CKhfYeJVpnyE0+yK+yct2QhQpPfxril2vPn1qGMvLGBPcw0GV/xIhV9ovRcNvgGh3U
 4MT+0xaccoX370qyQjc/UD3jeV6PIE797QVXkGSVxgtiOnLFrgjNb/SZIOXwEBbcD1qA
 2pxniO8wgqUJO5e8MiAAZqKK5xcO5pZxtcoxep+s81bTzjs63R0ryg+ybBQrDLsUjW97
 +nRRJvIjzQQOMxtyAi35WAQ572sJbDgNPfPpqKB44ro7+QI85hL8kR2CgdadnxnH/kU1
 QsGO/UngBC92zWMXImqaszyNL6lMuoMxeoa6Tjh8wWpXyeDw5AyKDmMIbmfZkpf4Lzgf Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04ettvw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 11:51:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CBopBq060643;
        Wed, 12 Jun 2019 11:51:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t1jphyr4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 11:51:52 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CBpqvU016576;
        Wed, 12 Jun 2019 11:51:52 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 04:51:51 -0700
Date:   Wed, 12 Jun 2019 14:51:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     andriin@fb.com
Cc:     bpf@vger.kernel.org
Subject: [bug report] libbpf: use negative fd to specify missing BTF
Message-ID: <20190612115145.GA26292@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=665 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120082
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Andrii Nakryiko,

The patch fba01a0689a9: "libbpf: use negative fd to specify missing
BTF" from May 29, 2019, leads to the following static checker warning:

	./tools/lib/bpf/libbpf.c:1757 bpf_object__create_maps()
	warn: always true condition '(create_attr.btf_fd >= 0) => (0-u32max >= 0)'

./tools/lib/bpf/libbpf.c
  1735                  if (obj->caps.name)
  1736                          create_attr.name = map->name;
  1737                  create_attr.map_ifindex = map->map_ifindex;
  1738                  create_attr.map_type = def->type;
  1739                  create_attr.map_flags = def->map_flags;
  1740                  create_attr.key_size = def->key_size;
  1741                  create_attr.value_size = def->value_size;
  1742                  create_attr.max_entries = def->max_entries;
  1743                  create_attr.btf_fd = -1;
                        ^^^^^^^^^^^^^^^^^^^^^^^
.btf_fd is a __u32

  1744                  create_attr.btf_key_type_id = 0;
  1745                  create_attr.btf_value_type_id = 0;
  1746                  if (bpf_map_type__is_map_in_map(def->type) &&
  1747                      map->inner_map_fd >= 0)
  1748                          create_attr.inner_map_fd = map->inner_map_fd;
  1749  
  1750                  if (obj->btf && !bpf_map_find_btf_info(map, obj->btf)) {
  1751                          create_attr.btf_fd = btf__fd(obj->btf);
  1752                          create_attr.btf_key_type_id = map->btf_key_type_id;
  1753                          create_attr.btf_value_type_id = map->btf_value_type_id;
  1754                  }
  1755  
  1756                  *pfd = bpf_create_map_xattr(&create_attr);
  1757                  if (*pfd < 0 && create_attr.btf_fd >= 0) {
                                        ^^^^^^^^^^^^^^^^^^^^^^^
Always true condition.

  1758                          cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
  1759                          pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
  1760                                     map->name, cp, errno);
  1761                          create_attr.btf_fd = -1;
  1762                          create_attr.btf_key_type_id = 0;
  1763                          create_attr.btf_value_type_id = 0;
  1764                          map->btf_key_type_id = 0;
  1765                          map->btf_value_type_id = 0;
  1766                          *pfd = bpf_create_map_xattr(&create_attr);
  1767                  }

regards,
dan carpenter
