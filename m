Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED264696F
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 07:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLHGvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 01:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHGvz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 01:51:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483F537ED;
        Wed,  7 Dec 2022 22:51:53 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B85kc0d032758;
        Thu, 8 Dec 2022 06:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zBniRm/JnGiiCCWjzu/sY7ceVwobeiPnbEGkZ0r2klc=;
 b=UooGpKuYZ/1uuG85PmyyXj2VRnyUMdNF/T9ebGtPXbD+UQuHLkN1DJuSh4w/RhVT4C80
 I6BQRnFvHSt2Irm9D5mOk7wZrhy47uxjYuuDiuhZDmSNuq2t15D/8eMHtyfUoxIX6qgD
 6X+n3Od6dd8tHJAOzfDAwk9HXjf6ddbiP+XTJkO9/1G3PEyHfYQPtVqum/yAA5JdHZ8Y
 Obuag0VxT87vfc4wybayhSuGb/1J32pFdNMU8KClfhrjTFmDcTpWdUwVsS5zpX3pIDT3
 dxt6+CK+hpwUyUDqUHkA4y9GyRx6sTcD5JIV+DlJ75X8beGp7gIGzh3NXQfkEb7K+lQQ XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mba2xs6de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 06:51:43 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B86jvxK020432;
        Thu, 8 Dec 2022 06:51:43 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mba2xs6cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 06:51:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7HHex3016426;
        Thu, 8 Dec 2022 06:51:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3m9m5y3y3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 06:51:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B86pclp19661076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Dec 2022 06:51:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49FD620043;
        Thu,  8 Dec 2022 06:51:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB9B220040;
        Thu,  8 Dec 2022 06:51:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.66.146])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Dec 2022 06:51:35 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y5DNBZNC5rBBqlJW@kernel.org>
Date:   Thu, 8 Dec 2022 12:21:20 +0530
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
Message-Id: <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
References: <Y49rvLO2RnJBBNL/@kernel.org> <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org> <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org> <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org> <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sBreQXTM-LoHOT5jCmKQSKPDDskpaNh3
X-Proofpoint-ORIG-GUID: E1RQ4_TltSKrxL0X_0l3BrdHqMw-8XyP
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_04,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212080054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Wed, Dec 07, 2022 at 07:08:28PM +0530, Athira Rajeev escreveu:
>>=20
>>=20
>>> On 06-Dec-2022, at 11:01 PM, Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
>>>=20
>>> Em Tue, Dec 06, 2022 at 02:13:48PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>>>> Em Tue, Dec 06, 2022 at 02:07:32PM -0300, Arnaldo Carvalho de Melo esc=
reveu:
>>>>> Em Tue, Dec 06, 2022 at 02:01:43PM -0300, Arnaldo Carvalho de Melo es=
creveu:
>>>>>> Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo e=
screveu:
>>>>>>> Now to look at the BUILD_BPF_SKEL=3D1 kaboom:
>>>>>>>=20
>>>>>>> [acme@quaco perf]$ alias m
>>>>>>> alias m=3D'rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=
=3D1 BUILD_BPF_SKEL=3D1 O=3D/tmp/build/perf -C tools/perf install-bin && pe=
rf test python'
>>>>>>> [acme@quaco perf]$ m
>>>>>>> make: Entering directory '/home/acme/git/perf/tools/perf'
>>>>>>> BUILD:   Doing 'make -j8' parallel build
>>>>>>> <SNIP>
>>>>>>> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
>>>>>>> /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined refe=
rence to `perf_kwork_add_work'
>>>>>>> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contentio=
n_read':
>>>>>=20
>>>>> For that bpf_kwork.c see below. Now to see why the python binding is =
not
>>>>> building, I guess is unrelated and you have some other outstanding
>>>>> patch?
>>>>=20
>>>> Its related:
>>>>=20
>>>> [acme@quaco perf]$ perf test -v python
>>>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating B=
PF maps, etc
>>>> 14: 'import perf' in python                                         :
>>>> --- start ---
>>>> test child forked, pid 1669872
>>>> python usage test: "echo "import sys ; sys.path.append('/tmp/build/per=
f/python'); import perf" | '/usr/bin/python3' "
>>>> Traceback (most recent call last):
>>>> File "<stdin>", line 1, in <module>
>>>> ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.=
so: undefined symbol: tep_unload_plugins
>>>> test child finished with -1
>>>> ---- end ----
>>>> 'import perf' in python: FAILED!
>>>> [acme@quaco perf]$
>>>>=20
>>>> Now checking why NO_LIBTRACEEVENT=3D1 fails with this...
>>>>=20
>>>> [acme@quaco perf]$ find tools/perf/ -name "*.c" | xargs grep tep_unloa=
d_plugins
>>>> tools/perf/util/trace-event.c:	tep_unload_plugins(t->plugin_list, t->p=
event);
>>>> [acme@quaco perf]$
>>>>=20
>>>> [acme@quaco perf]$ grep trace-event tools/perf/util/python-ext-sources
>>>> util/trace-event.c
>>>> [acme@quaco perf]$
>>>>=20
>>>> Trying to fix...
>>>=20
>>> I'm missing some detail, this isn't working, util/trace-event.c is still
>>> being built and linked.
>>=20
>> Hi,
>>=20
>> Observed similar issue with =E2=80=9Cbuiltin-trace.c=E2=80=9D
>>=20
>> In system without libtraceevent-devel, I could still see builtin-trace t=
rying to get
>> compiled and hitting error. In my understanding, CONFIG_TRACE will be
>> disabled when libtraceevent is not present and hence builtin-trace shoul=
d be disabled
>> which I am not seeing.
>>=20
>> # rpm -qa|grep libtraceevent
>> libtraceevent-1.2.1-1.el8.ppc64le
>>=20
>> # grep -i traceevent FEATURE-DUMP=20
>> feature-libtraceevent=3D0
>>=20
>> Snippet from make logs:
>>=20
>> builtin-trace.c:266:50: error: dereferencing pointer to incomplete type =
'struct tep_format_field'
>>  return __tp_field__init_uint(field, format_field->size, format_field->o=
ffset, needs_swap);
>>                                                  ^~
>> builtin-trace.c: In function 'evsel__syscall_arg_fmt':
>> builtin-trace.c:361:25: error: 'struct evsel' has no member named 'tp_fo=
rmat'
>>   et->fmt =3D calloc(evsel->tp_format->format.nr_fields, sizeof(struct s=
yscall_arg_fmt));
>>=20
>=20
> Can you try again? tmp.perf/core? That "tmp." part means its a force
> pushed branch, so I just force pushed with some arch specific fixes, now
> I'm down to (removing the successful builds and unrelated failures, now
> related to libbpf's F_DUPFD_CLOEXEC kaboom):

Ok Arnaldo, Sure, I will check with updated branch


>=20
>   5     7.38 fedora:34                     : FAIL gcc version 11.3.1 2022=
0421 (Red Hat 11.3.1-2) (GCC)
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=80=98evse=
l__rawptr=E2=80=99:
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =E2=80=98T=
EP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this function); did =
you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
>     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~
>          |                                    TEP_FIELD_IS_FLAG

I observed same issue as updated here:=20
https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@linux.vne=
t.ibm.com/

Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of the syste=
m installed version.
whereas it is there in header file in tools/lib/traceevent

# grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
# grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
	TEP_FIELD_IS_RELATIVE	=3D 256,


Thanks
Athira
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: note: each undecl=
ared identifier is reported only once for each function it appears in
>    error: command '/usr/bin/gcc' failed with exit code 1
>=20
>  7     7.18 fedora:35                     : FAIL gcc version 11.3.1 20220=
421 (Red Hat 11.3.1-2) (GCC)
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=80=98evse=
l__rawptr=E2=80=99:
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =E2=80=98T=
EP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this function); did =
you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
>     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~
>          |                                    TEP_FIELD_IS_FLAG
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: note: each undecl=
ared identifier is reported only once for each function it appears in
>    error: command '/usr/bin/gcc' failed with exit code 1
>=20
>  14     8.49 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubun=
tu 7.5.0-3ubuntu1~18.04)
>    tests/parse-events.c:1893:12: error: 'test__checkevent_tracepoint' und=
eclared here (not in a function); did you mean 'test__checkevent_breakpoint=
'?
>       .check =3D test__checkevent_tracepoint,
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>                test__checkevent_breakpoint
>    /git/perf-6.1.0-rc6/tools/build/Makefile.build:139: recipe for target =
'tests' failed
>    make[3]: *** [tests] Error 2
>  16     6.38 ubuntu:22.04                  : FAIL gcc version 11.3.0 (Ubu=
ntu 11.3.0-1ubuntu1~22.04)
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function =E2=80=98evse=
l__rawptr=E2=80=99:
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: =E2=80=98T=
EP_FIELD_IS_RELATIVE=E2=80=99 undeclared (first use in this function); did =
you mean =E2=80=98TEP_FIELD_IS_FLAG=E2=80=99?
>     2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~
>          |                                    TEP_FIELD_IS_FLAG
>    /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: note: each undecl=
ared identifier is reported only once for each function it appears in
>    error: command '/usr/bin/gcc' failed with exit code 1
>=20
>=20
>=20
>> Thanks
>> Athira
>>=20
>>>=20
>>> The python binding should be usable without tracepoints, in fact its
>>> first usage was just to have access to the perf metaevents, see=20
>>> tools/perf/python/twatch.py.
>>>=20
>>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>>> index f0e4daeef8120853..5bd67d54d036f281 100644
>>> --- a/tools/perf/Makefile.perf
>>> +++ b/tools/perf/Makefile.perf
>>> @@ -348,6 +348,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>>> python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUIL=
D) $(OUTPUT)python/perf*.so
>>>=20
>>> PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-sources)
>>> +ifneq ($(CONFIG_TRACEEVENT),y)
>>> +  PYTHON_EXT_SRCS :=3D $(call filter-out,$(PYTHON_EXT_SRCS),util/trace=
-event.c)
>>> +endif
>>> +
>>> PYTHON_EXT_DEPS :=3D util/python-ext-sources util/setup.py $(LIBAPI)
>>>=20
>>> SCRIPTS =3D $(patsubst %.sh,%,$(SCRIPT_SH))
>>> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
>>> index 728fe2f51759eb0d..72088aec2857b316 100644
>>> --- a/tools/perf/util/python.c
>>> +++ b/tools/perf/util/python.c
>>> @@ -1330,6 +1330,9 @@ static struct {
>>> static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
>>> 				  PyObject *args, PyObject *kwargs)
>>> {
>>> +#ifndef HAVE_LIBTRACEEVENT
>>> +	return NULL;
>>> +#else
>>> 	struct tep_event *tp_format;
>>> 	static char *kwlist[] =3D { "sys", "name", NULL };
>>> 	char *sys  =3D NULL;
>>> @@ -1344,6 +1347,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evs=
el *pevsel,
>>> 		return _PyLong_FromLong(-1);
>>>=20
>>> 	return _PyLong_FromLong(tp_format->id);
>>> +#endif // HAVE_LIBTRACEEVENT
>>> }
>>>=20
>>> static PyMethodDef perf__methods[] =3D {
>=20
> --=20
>=20
> - Arnaldo

