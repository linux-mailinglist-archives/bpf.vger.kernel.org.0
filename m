Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879D39EB6C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfH0Oqy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 27 Aug 2019 10:46:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbfH0Oqy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Aug 2019 10:46:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7REio1d122031
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2019 10:46:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2un6dqgjhj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2019 10:46:52 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 27 Aug 2019 15:46:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 15:46:47 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7REkkNC59965538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 14:46:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B33EB4C05A;
        Tue, 27 Aug 2019 14:46:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F8E94C050;
        Tue, 27 Aug 2019 14:46:46 +0000 (GMT)
Received: from dyn-9-152-98-121.boeblingen.de.ibm.com (unknown [9.152.98.121])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 14:46:46 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC PATCH] bpf: s390: add JIT support for multi-function
 programs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <xunyd0gq8z39.fsf@redhat.com>
Date:   Tue, 27 Aug 2019 16:46:46 +0200
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, jolsa@redhat.com
Content-Transfer-Encoding: 8BIT
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
 <3F7BF2AC-E27D-4E69-90D6-07B36C7D7598@linux.ibm.com>
 <xunyd0gq8z39.fsf@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19082714-0008-0000-0000-0000030DE004
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082714-0009-0000-0000-00004A2C1CCF
Message-Id: <898C056B-D7F1-4CE9-AB86-D1C43E7A98E8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 27.08.2019 um 16:25 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
> 
> Hi, Ilya!
> 
>>>>>> On Tue, 27 Aug 2019 15:21:30 +0200, Ilya Leoshkevich  wrote:
> 
>>> Am 26.08.2019 um 20:20 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
>>> 
>>> test_verifier (5.3-rc6):
>>> 
>>> without patch:
>>> Summary: 1501 PASSED, 0 SKIPPED, 47 FAILED
>>> 
>>> with patch:
>>> Summary: 1540 PASSED, 0 SKIPPED, 8 FAILED
> 
>> Are you per chance running with a testsuite patch like this one?
> 
>> --- a/tools/testing/selftests/bpf/test_verifier.c
>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>> @@ -846,7 +846,7 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>> 				tmp, &size_tmp, &retval, NULL);
>> 	if (unpriv)
>> 		set_admin(false);
>> -	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
>> +	if (err && errno != EPERM) {
>> 		printf("Unexpected bpf_prog_test_run error ");
>> 		return err;
>> 	}
> 
>> Without it, all the failures appear to be masked for me.
> 
> BTW, I have several failures because of low BPF_SIZE_MAX. If I
> increase it, some tests pass (#585/p ld_abs: vlan + abs, test 1),
> but some crash (#587/p ld_abs: jump around ld_abs, haven't
> found the reason yet).
> 
> Have you observed anything like that?

Yes, this is because right now JIT generates clrj and friends,
which can jump only by +-32k. Improving this is actually my next task
(after fixing more or less "obvious" test suite problems).
