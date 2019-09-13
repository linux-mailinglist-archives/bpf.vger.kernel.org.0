Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6AB1C7B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfIMLob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 07:44:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34764 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfIMLob (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 07:44:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DBhj87042060;
        Fri, 13 Sep 2019 11:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=UfF6dt1HgP9Bpc/nFmQundq2UCz21TDrt3FWir8mA+U=;
 b=B8uRp2ZGm1GImFo2VxKjLv7yqL7JE/AtqFUrfPrttAXosYkI06QTVYCbWwHW3WgWTfSn
 0ufArqHSvnplA8rOep/i3pPbYi+x8SavIskvhne/AQUpWSLCXtEMEdeG6QidVsJQ7bau
 yfuf2lDzuBbqmJWaniBRwQLmRcU2zjLvBdFfzu80XCp7N1hTby39KsbZpC2k5XegHCaa
 0bMNHgxdEDdbLaisZC9KtLtPMOYIjJa1Gz1DENHeDQRUmGqKa5seOKr905nkZ7o91rvR
 mT9Gn+XGjKKB/Ll5o99Ze+kB4T8wV+w9pirXpFkEstw6iV0XVockZnGo82+ROkhBUQWy bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uytd345up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 11:43:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DBhfXY108058;
        Fri, 13 Sep 2019 11:43:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2uytdwpxbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 11:43:43 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DBh8xr032303;
        Fri, 13 Sep 2019 11:43:09 GMT
Received: from termi.oracle.com (/67.69.50.154)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 04:43:07 -0700
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add bpf-gcc support
References: <20190912160543.66653-1-iii@linux.ibm.com>
Date:   Fri, 13 Sep 2019 13:43:04 +0200
In-Reply-To: <20190912160543.66653-1-iii@linux.ibm.com> (Ilya Leoshkevich's
        message of "Thu, 12 Sep 2019 18:05:43 +0200")
Message-ID: <87ftl0fmlz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130114
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


    Right now with binutils 25a2915e8dba and gcc r275589 only a handful of
    tests work:
    
    	# ./test_progs_bpf_gcc
    	# Summary: 7/39 PASSED, 1 SKIPPED, 98 FAILED
    
    The reason for those failures are as follows:
    
    - Build errors:
      - `error: too many function arguments for eBPF` for __always_inline
        functions read_str_var and read_map_var - must be inlining issue,
        and for process_l3_headers_v6, which relies on optimizing away
        function arguments.
      - `error: indirect call in function, which are not supported by eBPF`
        where there are no obvious indirect calls in the source calls, e.g.
        in __encap_ipip_none.
      - `error: field 'lock' has incomplete type` for fields of `struct
        bpf_spin_lock` type - bpf_spin_lock is re#defined by bpf-helpers.h,
        so its usage is sensitive to order of #includes.
      - `error: eBPF stack limit exceeded` in sysctl_tcp_mem.
    - Load errors:
      - Missing object files due to above build errors.
      - `libbpf: failed to create map (name: 'test_ver.bss')`.
      - `libbpf: object file doesn't contain bpf program`.
      - `libbpf: Program '.text' contains unrecognized relo data pointing to
        section 0`.
      - `libbpf: BTF is required, but is missing or corrupted` - no BTF
        support in gcc yet.

Thanks for the nice report.
That will keep me busy for a little while :)
