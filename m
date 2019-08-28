Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594B79FE03
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfH1JMM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 28 Aug 2019 05:12:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbfH1JML (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Aug 2019 05:12:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7S98DLt040251
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 05:12:09 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unm5kpp1a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 05:12:09 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 28 Aug 2019 10:12:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 10:12:04 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7S9C38u50331818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 09:12:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38E80AE05D;
        Wed, 28 Aug 2019 09:12:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C487AE04D;
        Wed, 28 Aug 2019 09:12:03 +0000 (GMT)
Received: from dyn-9-152-98-121.boeblingen.de.ibm.com (unknown [9.152.98.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 09:12:02 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] bpf: s390: add JIT support for multi-function programs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <D9450184-3B41-4893-8485-4A578FAA0566@linux.ibm.com>
Date:   Wed, 28 Aug 2019 11:11:39 +0200
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, jolsa@redhat.com
Content-Transfer-Encoding: 8BIT
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
 <20190827145307.7984-1-yauheni.kaliuta@redhat.com>
 <D9450184-3B41-4893-8485-4A578FAA0566@linux.ibm.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19082809-0020-0000-0000-00000364D164
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082809-0021-0000-0000-000021BA22E8
Message-Id: <C3339800-0F46-4023-AC22-A985D17AAD6B@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=956 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280098
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 27.08.2019 um 18:39 schrieb Ilya Leoshkevich <iii@linux.ibm.com>:
> 
>> Am 27.08.2019 um 16:53 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
>> 
>> @@ -1316,7 +1327,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>> {
>> 	struct bpf_prog *tmp, *orig_fp = fp;
>> 	struct bpf_binary_header *header;
>> +	struct s390_jit_data *jit_data;
>> 	bool tmp_blinded = false;
>> +	bool extra_pass = false;
>> 	struct bpf_jit jit;
>> 	int pass;
>> 
>> @@ -1335,6 +1348,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>> 		fp = tmp;
>> 	}
>> 
>> +	jit_data = fp->aux->jit_data;
>> +	if (!jit_data) {
>> +		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
>> +		if (!jit_data) {
>> +			fp = orig_fp;
>> +			goto out;
>> +		}
>> +		fp->aux->jit_data = jit_data;
>> +	}
>> +	if (jit_data->ctx.addrs) {
>> +		jit = jit_data->ctx;
>> +		header = jit_data->header;
>> +		extra_pass = true;
>> +		goto skip_init_ctx;
>> +	}
>> +
> 
> I've noticed that I'm getting the following warning, presumably because
> of the added goto skip_init_ctx:
> 
> linux/arch/s390/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
> linux/arch/s390/net/bpf_jit_comp.c:1406:3: warning: 'pass' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   bpf_jit_dump(fp->len, jit.size, pass, jit.prg_buf);
> 
> Maybe set the initial value of pass to 1?

... or save pass in s390_jit_data and do the following?

	pass = jit_data->pass + 1;
	goto skip_init_ctx;

I've also noticed that

	$ git show --format=email | scripts/checkpatch.pl --strict

complains - could you please fix these warnings?


I've finally reviewed the actual logic of the patch, and it looks good
to me.  The integration with the common code is somewhat involved, but
it follows the established architecture.

