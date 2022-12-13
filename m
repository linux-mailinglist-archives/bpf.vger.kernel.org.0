Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADB864B2CB
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiLMJxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 04:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiLMJxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 04:53:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CE2BF7;
        Tue, 13 Dec 2022 01:53:43 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD8974J010082;
        Tue, 13 Dec 2022 09:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=XHzjwrobxd+TbunuZRAOYWf7gEEvMa3zA6CrDQ/bD8c=;
 b=rVKkK3dKAZ99KFG+UDmW4L7hT92/4HHZfAkbrbAG6B2bfA3w/Kmq4C3mQ5BvqcMe7d42
 kXtACBOuTjozVNRgnoYgKwEjwngs6PHbNXTJ8K99/mMqtFF/mnJ0OSTHar7GMi+89WWC
 Xl4rOsXy6EUQLoZRClr9d/Z9T1qNW5wJl5JEt93yvoWnwVLPLtLc0cqIO8RNI+JfdSH/
 PEmfYbwWjze9DmIOHmrCtDXr/Domj/l28KNc/8cYpuKrmhakrrjfcc69Hvbd8pX7gewJ
 af8gYZ1ihmP+m5RXs1OIKD+QmIy9jK1kgHOY/Qu408/tz4+lvdjpRIYaSfApgU1Bm81C HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mejrdxf9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:53:29 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BD8IqW9014552;
        Tue, 13 Dec 2022 09:53:28 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mejrdxf99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:53:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD4xhYd007765;
        Tue, 13 Dec 2022 09:53:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mchcf3ymx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:53:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BD9rO2R19399176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 09:53:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11BAF20049;
        Tue, 13 Dec 2022 09:53:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 841EF20043;
        Tue, 13 Dec 2022 09:53:21 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.34.192])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Dec 2022 09:53:21 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y5cxyk3OdgFXlyhS@kernel.org>
Date:   Tue, 13 Dec 2022 15:23:19 +0530
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Message-Id: <BB236C92-3505-4DAB-AE28-A55F74EDE161@linux.vnet.ibm.com>
References: <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
 <Y5JfgyN59dSeKbUP@kernel.org> <Y5Jl8MeW90DXy1wT@kernel.org>
 <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com>
 <Y5cxyk3OdgFXlyhS@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2Bny2CfjGFNq4kOQrw1bvHECQTOc8JDU
X-Proofpoint-ORIG-GUID: iZlkoCnTfH2k37QW6qXy03YuzmNodnsC
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 12-Dec-2022, at 7:21 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> Em Fri, Dec 09, 2022 at 12:04:18PM +0530, Athira Rajeev escreveu:
>>=20
>>=20
>>> On 09-Dec-2022, at 4:02 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>>>=20
>>> Em Thu, Dec 08, 2022 at 07:04:52PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>>>> Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
>>>>>> On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
>>>>>> Can you try again? tmp.perf/core? That "tmp." part means its a force
>>>>>> pushed branch, so I just force pushed with some arch specific fixes,=
 now
>>>>>> I'm down to (removing the successful builds and unrelated failures, =
now
>>>>>> related to libbpf's F_DUPFD_CLOEXEC kaboom):
>>>>=20
>>>>> Ok Arnaldo, Sure, I will check with updated branch
>>>>=20
>>>>>> 5     7.38 fedora:34                     : FAIL gcc version 11.3.1 2=
0220421 (Red Hat 11.3.1-2) (GCC)
>>>>>>  /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=80=98e=
vsel__rawptr=E2=80=99:
>>>>>>  /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =E2=80=
=98TEP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this function); =
did you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
>>>>>>   2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>>>>>>        |                                    ^~~~~~~~~~~~~~~~~~~~~
>>>>>>        |                                    TEP_FIELD_IS_FLAG
>>>>=20
>>>>> I observed same issue as updated here:=20
>>>>> https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@lin=
ux.vnet.ibm.com/
>>>>=20
>>>>> Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of the=
 system installed version.
>>>>> whereas it is there in header file in tools/lib/traceevent
>>>>=20
>>>>> # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
>>>>> # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
>>>>> 	TEP_FIELD_IS_RELATIVE	=3D 256,
>>>>=20
>>>> Right, I had noticed that as well, so as a prep patch I'm adding the
>>>> patch below, before Ian's. Please check and provide an
>>>> Acked-by/Tested-by/Reviewed-by if possible.
>>>=20
>>> I ended up with the one below, _after_ Ian's patch as I had some troubl=
e grafting
>>> it before and had already tested it this way multiple times, I'm pushing
>>> this to tmp/perf.core.
>>>=20
>>> - Arnaldo
>>=20
>>=20
>> Hi Arnaldo, Ian
>>=20
>> Thanks for the fixes.
>>=20
>> Since we changed =E2=80=9CCONFIG_TRACEEVENT=E2=80=9D to =E2=80=9CCONFIG_=
LIBTRACEEVENT=E2=80=9D,=20
>> below change is also needed in =E2=80=9Carch/powerpc/util/Build=E2=80=9D
>>=20
>> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerp=
c/util/Build
>> index 71e57f28abda..9889245c555c 100644
>> --- a/tools/perf/arch/powerpc/util/Build
>> +++ b/tools/perf/arch/powerpc/util/Build
>> @@ -1,5 +1,5 @@
>> perf-y +=3D header.o
>> -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
>> +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
>> perf-y +=3D perf_regs.o
>> perf-y +=3D mem-events.o
>> perf-y +=3D sym-handling.o
>>=20
>> With this change, I could successfully compile in these environment:
>> - Without libtraceevent-devel installed
>> - With libtraceevent-devel installed
>> - With =E2=80=9Cmake NO_LIBTRACEEVENT=3D1=E2=80=9D
>>=20
>> With above change,
>> Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> I did that and the same thing for other architectures, thanks for
> testing!
>=20
> I'll now give a try at implementing it without
> tools/build/feature/test-libtraceevent-tep_field_is_relative.c, using
> just the version of libtraceevent, as Ian suggested.
>=20
> It would be great if you could test it again then,
>=20

Sure Arnaldo, I will test with updated code.

Thanks
Athira

> Thanks,
>=20
> - Arnaldo
>=20
>=20
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/uti=
l/Build
> index 88553c578ed7a1c4..78ef7115be3d91a7 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -3,7 +3,7 @@ perf-y +=3D machine.o
> perf-y +=3D perf_regs.o
> perf-y +=3D tsc.o
> perf-y +=3D pmu.o
> -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
> +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> perf-$(CONFIG_DWARF)     +=3D dwarf-regs.o
> perf-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> perf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc=
/util/Build
> index 71e57f28abdac7e9..9889245c555c4cfb 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -1,5 +1,5 @@
> perf-y +=3D header.o
> -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
> +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> perf-y +=3D perf_regs.o
> perf-y +=3D mem-events.o
> perf-y +=3D sym-handling.o
> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/=
Build
> index aa8a5f05c9cb4706..db68840869979f2c 100644
> --- a/tools/perf/arch/s390/util/Build
> +++ b/tools/perf/arch/s390/util/Build
> @@ -1,5 +1,5 @@
> perf-y +=3D header.o
> -perf-$(CONFIG_TRACEEVENT) +=3D kvm-stat.o
> +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> perf-y +=3D perf_regs.o
>=20
> perf-$(CONFIG_DWARF) +=3D dwarf-regs.o

