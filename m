Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC41F13C4
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFHHqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 03:46:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgFHHqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 03:46:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0587gKLL115387;
        Mon, 8 Jun 2020 07:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8rrtKpLZ9/CR8naOspdvNYopCWuxb6yq6XYdbSHeJDI=;
 b=erxhDPNnvfts6Zmhdvp6x0aoHgIPbDppoam3P4iL2BQeIPXm68bc7K9TI654WaXKKiLQ
 usNY9LWxA1tgnrcAwSsusgtE9TIhqCTtSULJvgUA5P68fKWBiNY4DudT8ulH6FiuobcF
 CZohSHr1GL+4CZ3jmhwfhkTpOZq8ZF7i8TNLWyA5bANwG6JST3f7Ngb4jgAYmwusM40Q
 KLbubhfVZFDtKqcg8SPm0iZAxk8ixZyG7OEPeF+LzeU7gUw+aq8oh8UIxcEbqyptNbfF
 Pp5xTpkQyTUYAfBNHSvXsDJ7MznkP00BcuX4ICuCnNsjVlldB/sVwhBdWYS/LvvLyhSI NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smn8ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 07:46:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0587baH2126029;
        Mon, 8 Jun 2020 07:45:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31gn2uuu53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 07:45:59 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0587jvuL012057;
        Mon, 8 Jun 2020 07:45:57 GMT
Received: from [10.175.49.179] (/10.175.49.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 00:45:57 -0700
Subject: Re: WARNING: CPU: 1 PID: 52 at mm/page_alloc.c:4826
 __alloc_pages_nodemask (Re: [PATCH 5/5] sysctl: pass kernel pointers to
 ->proc_handler)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        bpf@vger.kernel.org, Andrey Ignatov <rdna@fb.com>
References: <20200424064338.538313-1-hch@lst.de>
 <20200424064338.538313-6-hch@lst.de>
 <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com>
 <20200608065120.GA17859@lst.de>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <c0f216d1-edc1-68e6-7f3e-c00e33452707@oracle.com>
Date:   Mon, 8 Jun 2020 09:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200608065120.GA17859@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080058
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020-06-08 08:51, Christoph Hellwig wrote:
> On Thu, Jun 04, 2020 at 10:22:21PM +0200, Vegard Nossum wrote:
>> It's easy to reproduce by just doing
>>
>>      read(open("/proc/sys/vm/swappiness", O_RDONLY), 0, 512UL * 1024 * 1024
>> * 1024);
>>
>> or so. Reverting the commit fixes the issue for me.
> 
> Yes, doing giant allocations will fail and trace.  We have to options
> here that both seems sensible:
> 
>   - trunate sysctrl calls to some sensible length
>   - (optionally) use vmalloc
> 
> Is this a real application or just a test case trying to do the
> stupidmost possible thing?
> 

Just a test case.

Allowing the kernel to allocate an unbounded amount of memory on behalf
of userspace is an easy DOS.

All the length checks were already in there, e.g.

  static int cmm_timeout_handler(struct ctl_table *ctl, int write,
                               void __user *buffer, size_t *lenp, loff_t 
*ppos)
  {
         char buf[64], *p;
[...]
                 len = min(*lenp, sizeof(buf));
                 if (copy_from_user(buf, buffer, len))
                         return -EFAULT;


Vegard
