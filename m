Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61E79EB32
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfH0OhN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 27 Aug 2019 10:37:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbfH0OhM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Aug 2019 10:37:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RETH9Q103644
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2019 10:37:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2un5afkw7n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2019 10:37:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 27 Aug 2019 15:37:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 15:37:06 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7REb5JS30146734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 14:37:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6483B4C052;
        Tue, 27 Aug 2019 14:37:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40DF64C04E;
        Tue, 27 Aug 2019 14:37:05 +0000 (GMT)
Received: from dyn-9-152-98-121.boeblingen.de.ibm.com (unknown [9.152.98.121])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 14:37:05 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC PATCH] bpf: s390: add JIT support for multi-function
 programs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <xunyh8628z9w.fsf@redhat.com>
Date:   Tue, 27 Aug 2019 16:37:04 +0200
Cc:     bpf <bpf@vger.kernel.org>, daniel@iogearbox.net, jolsa@redhat.com
Content-Transfer-Encoding: 8BIT
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
 <3F7BF2AC-E27D-4E69-90D6-07B36C7D7598@linux.ibm.com>
 <3DC02E46-160A-420E-B15F-1D68F7639851@linux.ibm.com>
 <xunyh8628z9w.fsf@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19082714-0012-0000-0000-0000034380DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082714-0013-0000-0000-0000217DBA10
Message-Id: <E6931E4D-0F0F-4572-AABD-BC896AEA6DD9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270153
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 27.08.2019 um 16:21 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
> 
> Hi, Ilya!
> 
>>>>>> On Tue, 27 Aug 2019 15:46:43 +0200, Ilya Leoshkevich  wrote:
> 
>>> Am 27.08.2019 um 15:21 schrieb Ilya Leoshkevich <iii@linux.ibm.com>:
>>> 
>>>> Am 26.08.2019 um 20:20 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
>>>> 
>>>> test_verifier (5.3-rc6):
>>>> 
>>>> without patch:
>>>> Summary: 1501 PASSED, 0 SKIPPED, 47 FAILED
>>>> 
>>>> with patch:
>>>> Summary: 1540 PASSED, 0 SKIPPED, 8 FAILED
>>> 
>>> Are you per chance running with a testsuite patch like this one?
>>> 
>>> --- a/tools/testing/selftests/bpf/test_verifier.c
>>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>>> @@ -846,7 +846,7 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>>> tmp, &size_tmp, &retval, NULL);
>>> if (unpriv)
>>> set_admin(false);
>>> -	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
>>> +	if (err && errno != EPERM) {
>>> printf("Unexpected bpf_prog_test_run error ");
>>> return err;
>>> }
>>> 
>>> Without it, all the failures appear to be masked for me.
> 
>> Hmm, I'm sorry, I thought about it a bit more, and the patch I
>> posted above doesn't make any sense, because the failures you
>> fixed are during load, and not run time.
> 
>> Now I think you are using CONFIG_BPF_JIT_ALWAYS_ON for your
>> testing, is that right? If yes, it would be nice to mention
> 
> Right.
> 
>> this in the commit message.
> 
> Sure. Should I post non-RFC v2 or wait for some more comments?

So far I only spotted a minor issue:

+		if (ret < 0)
+			return ret;

Right now bpf_jit_insn returns 0 or -1, but bpf_jit_get_func_addr
returns 0 or -errno. This does not affect anything in the end, but just
to be uniform, maybe return -1 here or -EINVAL in the default: branch?


I don't see any other obvious problems with the patch, but I'd like to
take some time to understand how exactly some parts of it work before
acking it. So I think it's fine to post a non-RFC version.
