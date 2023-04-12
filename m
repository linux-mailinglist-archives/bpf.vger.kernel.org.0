Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094A6DF52B
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDLM1I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDLM0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 08:26:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A442C4EE1;
        Wed, 12 Apr 2023 05:26:39 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CBtItM016818;
        Wed, 12 Apr 2023 12:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=dOfTLFzrTJ1Qm4LEGFkjQd21S2U6iA/MtHizDOAtLGk=;
 b=jL0ZJ+lr2Zh1rjTTUTAQfDkrgERc+g3a6byhwZskYOvbKYGW1M7Bebgv0Z5lKeoUvfyN
 BqoRm6CqG0koDNUCaFhEW4TXAgh6a5dmOlGpQnYSNHwdkHaf7g/JDSYobIg3qzJGMmPJ
 +nJakcyFfCiNHamB6wTxiJUMcV4JPG/EeqVEIowerjh+pA4dmRSfhEBx/uGL5tG8A6Oj
 bTij10DxWDdeqqkhlTL0g6TdLJWkdt9cvlr/WyIcickI3lHAfik9qPkV88Y/OGvPANCV
 DEReh3wBr+4Z81yqs/06b1sdpUn1qjws/2iJUf9r211MZ/tOs/SE4ExXhKt1+zcBi2u7 Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwu9pvahh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 12:26:19 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33CBbENK032629;
        Wed, 12 Apr 2023 12:26:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwu9pvafd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 12:26:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33BMjnHa029480;
        Wed, 12 Apr 2023 12:26:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m22bx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 12:26:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CCQEI549021690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 12:26:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2A0E20043;
        Wed, 12 Apr 2023 12:26:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 714F320040;
        Wed, 12 Apr 2023 12:26:13 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 12:26:13 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/7] bpftool: Support inline annotations
 when dumping the CFG of a program
References: <20230405132120.59886-1-quentin@isovalent.com>
        <20230405132120.59886-4-quentin@isovalent.com>
        <yt9d8rexy6uj.fsf@linux.ibm.com>
        <15cd553a-a6c1-19c7-bab1-0212a856056f@isovalent.com>
Date:   Wed, 12 Apr 2023 14:26:12 +0200
In-Reply-To: <15cd553a-a6c1-19c7-bab1-0212a856056f@isovalent.com> (Quentin
        Monnet's message of "Wed, 12 Apr 2023 13:05:01 +0100")
Message-ID: <yt9dttxlwal7.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w0LJmfRZhofP5WByniBxWNJujEFdvFo6
X-Proofpoint-ORIG-GUID: dkL_rJMMem2-DhEPrzTbIWd1Ntx2mkZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_03,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Quentin Monnet <quentin@isovalent.com> writes:

> 2023-04-12 08:04 UTC+0200 ~ Sven Schnelle <svens@linux.ibm.com>
>> Quentin Monnet <quentin@isovalent.com> writes:
>>=20
>>> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dum=
per.c
>>> index e7f6ec3a8f35..583aa843df92 100644
>>> --- a/tools/bpf/bpftool/btf_dumper.c
>>> +++ b/tools/bpf/bpftool/btf_dumper.c
>>> @@ -821,3 +821,37 @@ void btf_dump_linfo_json(const struct btf *btf,
>>>  					BPF_LINE_INFO_LINE_COL(linfo->line_col));
>>>  	}
>>>  }
>>> +
>>> +static void dotlabel_puts(const char *s)
>>> +{
>>> +	for (; *s; ++s) {
>>> +		switch (*s) {
>>> +		case '\\':
>>> +		case '"':
>>> +		case '{':
>>> +		case '}':
>>> +		case '<':
>>> +		case '>':
>>> +		case '|':
>>> +		case ' ':
>>> +			putchar('\\');
>>> +			__fallthrough;
>>=20
>> Is __fallthrough correct? I see the following compile error on s390 in
>> linux-next (20230412):
>>=20
>>   CC      btf_dumper.o
>> btf_dumper.c: In function =E2=80=98dotlabel_puts=E2=80=99:
>> btf_dumper.c:838:25: error: =E2=80=98__fallthrough=E2=80=99 undeclared (=
first use in this function); did you mean =E2=80=98fallthrough=E2=80=99?
>>   838 |                         __fallthrough;
>>       |                         ^~~~~~~~~~~~~
>>=20
>> removing the two underscores fixes this.
>
> I thought so? Perf seems to use the double underscores as well. Just
> "fallthrough" does not seem to be the right fix anyway, it gives me an
> error similar to yours on x86_64 with "fallthrough" undeclared.
>
> The definition should be pulled from tools/include/linux/compiler.h (and
> .../compiler-gcc.h). I thought this file would be at least included from
> bpftool's main.h, in turn included in btf_dumper.c. Looking at the chain
> of inclusions, on my system I get the following path:
>
>     $ CFLAGS=3D-H make btf_dumper.o
>     [...]
>     . /root/dev/linux/tools/include/linux/bitops.h
>     [...]
>     .. /root/dev/linux/tools/include/linux/bits.h
>     [...]
>     ... /root/dev/linux/tools/include/linux/build_bug.h
>     .... /root/dev/linux/tools/include/linux/compiler.h
>     ..... /root/dev/linux/tools/include/linux/compiler_types.h
>     ...... /root/dev/linux/tools/include/linux/compiler-gcc.h
>     [...]
>
> What do you get on your side?
>
> If you add "#include <linux/compiler.h>" to btf_dumper.c directly, does
> it fix the issue?

This seems to clash with:

commit f7a858bffcddaaf70c71b6b656e7cc21b6107cec
Author: Liam Howlett <liam.howlett@oracle.com>
Date:   Fri Nov 25 15:50:16 2022 +0000

    tools: Rename __fallthrough to fallthrough

    Rename the fallthrough attribute to better align with the kernel
    version.  Copy the definition from include/linux/compiler_attributes.h
    including the #else clause.  Adding the #else clause allows the tools
    compiler.h header to drop the check for a definition entirely and keeps
    both definitions together.

    Change any __fallthrough statements to fallthrough anywhere it was used
    within perf.

    This allows other tools to use the same key word as the kernel.

Which was also merged in linux-next.
