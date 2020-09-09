Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA93262B3C
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 11:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIIJCd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 05:02:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbgIIJCb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 05:02:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08991YFD054148;
        Wed, 9 Sep 2020 05:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=c9jKA4JzNJW8bmQwDF/rotdqpPJZsk5gVY2Dv7bE9ok=;
 b=rPN1C6hoGUxzsOaSxZ/mGH1sdHhx8vP8N3H7JTrRHBpzp1CX2aMMBwW5J8WYTyCFqR5p
 Notaon9fwJNzb05P8mwEu7QtkbUG2k+bKAB1Ug25WXUE4yDAPsZ5hMf2X7hEuMm8t9TN
 A+3IoxhXd7+Uq4ytgNV4PQ6Q4dQu1UDM2hwwJBUHe391qCQMmOZC4mHjRjdNnON6GxyK
 2QGhLdka+IJN4iYwgiZXbaEUsZl/ATKj8I7GIyMmpdQ2GdN526/pYryiD4mMqLb9Domu
 Nmqd007ot+6GQI8KV4GsOWAcw2Y0iLanGDNFSReVrXike8FxV809tBmzS1dbw0/tYQi0 +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33etvyj6nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 05:02:30 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08991XBI053978;
        Wed, 9 Sep 2020 05:02:29 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33etvyj6mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 05:02:29 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0898q7Xs012384;
        Wed, 9 Sep 2020 09:02:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 33cm5hj5cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 09:02:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08992Pct37749212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 09:02:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA7C1AE051;
        Wed,  9 Sep 2020 09:02:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F705AE05A;
        Wed,  9 Sep 2020 09:02:24 +0000 (GMT)
Received: from sig-9-145-16-19.uk.ibm.com (unknown [9.145.16.19])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 09:02:24 +0000 (GMT)
Message-ID: <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Tony Ambardar <tony.ambardar@gmail.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org
Date:   Wed, 09 Sep 2020 11:02:24 +0200
In-Reply-To: <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
         <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
         <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090076
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-09-08 at 13:18 -0700, Andrii Nakryiko wrote:
> On Mon, Sep 7, 2020 at 9:02 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > On Sat, 2020-09-05 at 21:16 -0700, Tony Ambardar wrote:
> > > Hello,
> > > 
> > > I'm using GCC 8.4.0, binutils 2.34 and pahole 1.17, compiling on
> > > an
> > > Ubuntu/x86_64 host and targeting both little- and big-endian mips
> > > running on malta/qemu. When cross-compiling Linux 5.4.x LTS and
> > > testing bpftool/BTF functionality on the target, I encounter
> > > errors
> > > on
> > > big-endian targets:
> > > 
> > > > root@OpenWrt:/# bpftool btf dump file /sys/kernel/btf/vmlinux
> > > > libbpf: failed to get EHDR from /sys/kernel/btf/vmlinux
> > > > Error: failed to load BTF from /sys/kernel/btf/vmlinux: No
> > > > error
> > > > information
> > > 
> > > After investigating, the problem appears to be that "pahole -J"
> > > running on the x86_64 little-endian host will always generate raw
> > > BTF
> > > of native endianness (based on BTF magic), which causes the error
> > > above on big-endian targets.
> > > 
> > > Is this expected? Is DEBUG_INFO_BTF supported in general when
> > > cross-compiling? How does one generate BTF encoded for the target
> > > endianness with pahole?
> 
> Yes, it's expected, unfortunately. Right now cross-compiling to a
> different endianness isn't supported. You can cross-compile only if
> target endianness matches host endianness.
> 
> > > Thanks for any feedback or suggestions,
> > > Tony
> > 
> > We have the same problem on s390, and I'm not aware of any solution
> > at
> > the moment. It would be great if we could figure out how to resolve
> > this.
> 
> I'm working on extending BTF APIs in libbpf at the moment. Switching
> endianness would be rather easy once all that is done. With these new
> APIs it will be possible to switch pahole to use libbpf APIs to
> produce BTF output and support arbitrary endianness as well. Right
> now, I'd rather avoid implementing this in pahole, libbpf is a much
> better place for this (and will require ongoing updates if/when we
> introduce new types and fields to BTF).
> 
> Hope this plan works for you guys.

That sounds really good to me, thanks!

