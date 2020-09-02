Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9825B53C
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIBUUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 16:20:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38254 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUUH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 16:20:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082KF4nY005672;
        Wed, 2 Sep 2020 20:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=CcXGJDhbqrqQreD1wdsFgymKQNH0vY1IS1y30FBVOE0=;
 b=TYr8bQq+hhhR5b0L0bsQQBnAvrp6ms342OAUXGjTANKw0xdLHRckP3dMNnumag2KCtHo
 TEEd4IHK/0Dl7Gdd0wt1txCBGEBeBQX7QbqKZsSEG2qLxqP1xWKpvjMRWFVAfgAFhZIR
 MzQVn52jiObAQUGq+RmL9bx02I3vPktXyU35ZwVW3ENhL9yCUgutE450UYwvaR6ysDEF
 FfG/SnsGY3BTvC5EwXuOo7d7Sgv4ZmgIHRfn8YjcnY7f3QXYla9zDqAXaLAZUIHljBdZ
 VWKXrK7pxZpxfKSJJzyRfDjXFxbCdvOXA6xmdeFOzwRdzM8ju0R4TqAsCOx7jCK5mQVg Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eer52t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 20:20:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082KEgF6069394;
        Wed, 2 Sep 2020 20:20:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3380x7qamc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 20:20:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082KK2SP028364;
        Wed, 2 Sep 2020 20:20:02 GMT
Received: from termi.oracle.com (/10.175.48.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 13:20:01 -0700
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: EF_BPF_GNU_XBPF
References: <87mu282gay.fsf@oracle.com>
        <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
Date:   Wed, 02 Sep 2020 22:19:58 +0200
In-Reply-To: <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 2 Sep 2020 12:31:53 -0700")
Message-ID: <87y2ls0w41.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020189
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> Hello BPF people!
>>
>> In order to ease the testing of the GCC bpf port we are adding a number
>> of extensions to the BPF ISA.
>>
>> We would like to use one bit in the e_flags field of the ELF header in
>> order to flag that the code in the ELF file is not plain eBPF:
>>
>> For EM_BPF:
>>
>> #define EF_BPF_GNU_XBPF 0x00000001
>>
>> Any objection?
>
> I've looked at your lpc slides and the extensions don't look like BPF
> extensions.
> At least I didn't see any attempt to make them verifiable.

It is an extension in the sense it is a superset of BPF.  Call it a
variant if you want.

As such, the property of being verifiable is irrelevant.  If we wanted
the extensions to be verifiable we would probably ask for them to be
added to BPF proper.  That's not the case, and that's precisely the
reason why we need to use that bit.

> In that sense it's not BPF and it's not correct to use EM_BPF for it.
> I suggest to define your own EM for your ISA.

Sorry, but that's not how ELF machine numbers work :)

It is perfectly normal, and also common practice, to use the same
machine code for several variants of the same base architecture, and I
see no reason for EM_BPF to be handled differently.  It would be silly,
and very inconvenient, to allocate a new machine number.

I don't think you people are using that bit in e_flags (or any bit, for
that matter).  So we just need to agree in reserving that bit for
EF_BPF_GNU_XBPF.

Shouldn't be a big matter surely?  There are 31 bits left ;)
