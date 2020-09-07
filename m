Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59525FDED
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgIGQCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:02:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729998AbgIGQAN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Sep 2020 12:00:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087FWF4q047733;
        Mon, 7 Sep 2020 12:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=S7T/TXOrEn9Vrt5dzPb/xYrfynM/Jiz4+yngT9IfgsM=;
 b=YQ5kAaBVSeE7XHsZlII8D0tWxmRncFcAT5OjwvaqBPzekJwYR0/Otyvh4t03o7+zyrpp
 oulOihLETxngS0R6TdekyO8axZPa7RubyJRDBw11R4J3o3IdLmAWrp7AXJw28OG1BbEJ
 YI4Dw9cQ/mSXeeENIA7A3DYuL6mdZNEyjPd0GGmEYW7LkdX3ZdBVnc4Jcg4/OWOEQnlo
 VQwM3MBn5L2leNLtr6xNVf64CmOnmBDVCr4XzfQJQB/fg/3dAeIqHVF1RUAwndnBwysT
 5CZTPmrm8pnK9UmJDWJEJ2HlMPNny7gbLCIDT+pPQN4GERUeJ7RndOzXmy9+gU46yodY Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dpm8j7qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 12:00:01 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087FWVVl048563;
        Mon, 7 Sep 2020 12:00:01 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dpm8j7qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 12:00:01 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087Fv89V004917;
        Mon, 7 Sep 2020 15:59:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 33c2a89j9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 15:59:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 087Fxv9636372792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 15:59:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2908511C050;
        Mon,  7 Sep 2020 15:59:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E37FD11C04C;
        Mon,  7 Sep 2020 15:59:56 +0000 (GMT)
Received: from sig-9-145-16-19.uk.ibm.com (unknown [9.145.16.19])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 15:59:56 +0000 (GMT)
Message-ID: <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Date:   Mon, 07 Sep 2020 17:59:56 +0200
In-Reply-To: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_10:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=3
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070149
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2020-09-05 at 21:16 -0700, Tony Ambardar wrote:
> Hello,
> 
> I'm using GCC 8.4.0, binutils 2.34 and pahole 1.17, compiling on an
> Ubuntu/x86_64 host and targeting both little- and big-endian mips
> running on malta/qemu. When cross-compiling Linux 5.4.x LTS and
> testing bpftool/BTF functionality on the target, I encounter errors
> on
> big-endian targets:
> 
> > root@OpenWrt:/# bpftool btf dump file /sys/kernel/btf/vmlinux
> > libbpf: failed to get EHDR from /sys/kernel/btf/vmlinux
> > Error: failed to load BTF from /sys/kernel/btf/vmlinux: No error
> > information
> 
> After investigating, the problem appears to be that "pahole -J"
> running on the x86_64 little-endian host will always generate raw BTF
> of native endianness (based on BTF magic), which causes the error
> above on big-endian targets.
> 
> Is this expected? Is DEBUG_INFO_BTF supported in general when
> cross-compiling? How does one generate BTF encoded for the target
> endianness with pahole?
> 
> Thanks for any feedback or suggestions,
> Tony

We have the same problem on s390, and I'm not aware of any solution at
the moment. It would be great if we could figure out how to resolve 
this.

Best regards,
Ilya

