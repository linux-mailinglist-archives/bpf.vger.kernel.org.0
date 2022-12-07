Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92F645B17
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 14:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLGNiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 08:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGNit (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 08:38:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6676F29815;
        Wed,  7 Dec 2022 05:38:48 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7BV4Sg032568;
        Wed, 7 Dec 2022 13:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=4F0SbZf1IRkYOIjLvgirouqti0DBDGijhKnoxF2Q/HU=;
 b=CQwbpwzv2aFxJZxJFg6wKLqwuiD26kCxxZsoG/003qVE7PP2g8S2pEk4LTb+CQzBqJhb
 0qQO+BP6NeAFLJ+PhswXeUHAIl5Ginj/rbz4AnVPAq6Zam38JHqkGBnL2nlVm0dJpmtH
 01WLtZQOG2o05wgqOvOi3XT6P/rFMKZXAboLT8oGr3WJVHwKViV+AM1Th34wY+lwTycI
 ck5KchWKgl13F+/Z2Dg6R1pOWjfN/tQvBF6EaLVivvgBUOAI9y+k9J5O6E/z8NLKtWSq
 0Un3Ze2rAaME14SJYr7oIeDhbCfJt/OjDDPWnDd4uChBKPwrBWNMRrPrsen24dIcGRzE rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mat1c321p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 13:38:38 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B7C0FQm025682;
        Wed, 7 Dec 2022 13:38:38 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mat1c320t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 13:38:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7BdeGc011493;
        Wed, 7 Dec 2022 13:38:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3m9kvbb0nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 13:38:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B7DcWU838994284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2022 13:38:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEBEB2004B;
        Wed,  7 Dec 2022 13:38:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 787D120043;
        Wed,  7 Dec 2022 13:38:30 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.115.155])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Dec 2022 13:38:30 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y498YP2N3gvFSr/X@kernel.org>
Date:   Wed, 7 Dec 2022 19:08:28 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
References: <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org> <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org> <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org> <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wXDXbTtxQ1co3Hv-nxOFZBgQHXBFm4-Q
X-Proofpoint-GUID: hYY7d7a85NSmjvvggR6LVbHt9VNAJBCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 06-Dec-2022, at 11:01 PM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> Em Tue, Dec 06, 2022 at 02:13:48PM -0300, Arnaldo Carvalho de Melo =
escreveu:
>> Em Tue, Dec 06, 2022 at 02:07:32PM -0300, Arnaldo Carvalho de Melo =
escreveu:
>>> Em Tue, Dec 06, 2022 at 02:01:43PM -0300, Arnaldo Carvalho de Melo =
escreveu:
>>>> Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo =
escreveu:
>>>>> Now to look at the BUILD_BPF_SKEL=3D1 kaboom:
>>>>>=20
>>>>> [acme@quaco perf]$ alias m
>>>>> alias m=3D'rm -rf ~/libexec/perf-core/ ; make -k =
NO_LIBTRACEEVENT=3D1 BUILD_BPF_SKEL=3D1 O=3D/tmp/build/perf -C =
tools/perf install-bin && perf test python'
>>>>> [acme@quaco perf]$ m
>>>>> make: Entering directory '/home/acme/git/perf/tools/perf'
>>>>>  BUILD:   Doing 'make -j8' parallel build
>>>>>  <SNIP>
>>>>> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
>>>>> /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined =
reference to `perf_kwork_add_work'
>>>>> /usr/bin/ld: /tmp/build/perf/perf-in.o: in function =
`lock_contention_read':
>>>=20
>>> For that bpf_kwork.c see below. Now to see why the python binding is =
not
>>> building, I guess is unrelated and you have some other outstanding
>>> patch?
>>=20
>> Its related:
>>=20
>> [acme@quaco perf]$ perf test -v python
>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating =
BPF maps, etc
>> 14: 'import perf' in python                                         :
>> --- start ---
>> test child forked, pid 1669872
>> python usage test: "echo "import sys ; =
sys.path.append('/tmp/build/perf/python'); import perf" | =
'/usr/bin/python3' "
>> Traceback (most recent call last):
>>  File "<stdin>", line 1, in <module>
>> ImportError: =
/tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined =
symbol: tep_unload_plugins
>> test child finished with -1
>> ---- end ----
>> 'import perf' in python: FAILED!
>> [acme@quaco perf]$
>>=20
>> Now checking why NO_LIBTRACEEVENT=3D1 fails with this...
>>=20
>> [acme@quaco perf]$ find tools/perf/ -name "*.c" | xargs grep =
tep_unload_plugins
>> tools/perf/util/trace-event.c:	=
tep_unload_plugins(t->plugin_list, t->pevent);
>> [acme@quaco perf]$
>>=20
>> [acme@quaco perf]$ grep trace-event =
tools/perf/util/python-ext-sources
>> util/trace-event.c
>> [acme@quaco perf]$
>>=20
>> Trying to fix...
>=20
> I'm missing some detail, this isn't working, util/trace-event.c is =
still
> being built and linked.

Hi,

Observed similar issue with =E2=80=9Cbuiltin-trace.c=E2=80=9D

In system without libtraceevent-devel, I could still see builtin-trace =
trying to get
compiled and hitting error. In my understanding, CONFIG_TRACE will be
disabled when libtraceevent is not present and hence builtin-trace =
should be disabled
which I am not seeing.

# rpm -qa|grep libtraceevent
libtraceevent-1.2.1-1.el8.ppc64le

# grep -i traceevent FEATURE-DUMP=20
feature-libtraceevent=3D0

Snippet from make logs:

builtin-trace.c:266:50: error: dereferencing pointer to incomplete type =
'struct tep_format_field'
  return __tp_field__init_uint(field, format_field->size, =
format_field->offset, needs_swap);
                                                  ^~
builtin-trace.c: In function 'evsel__syscall_arg_fmt':
builtin-trace.c:361:25: error: 'struct evsel' has no member named =
'tp_format'
   et->fmt =3D calloc(evsel->tp_format->format.nr_fields, sizeof(struct =
syscall_arg_fmt));


Thanks
Athira

>=20
> The python binding should be usable without tracepoints, in fact its
> first usage was just to have access to the perf metaevents, see=20
> tools/perf/python/twatch.py.
>=20
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f0e4daeef8120853..5bd67d54d036f281 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -348,6 +348,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r =
$(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
>=20
> PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-sources)
> +ifneq ($(CONFIG_TRACEEVENT),y)
> +  PYTHON_EXT_SRCS :=3D $(call =
filter-out,$(PYTHON_EXT_SRCS),util/trace-event.c)
> +endif
> +
> PYTHON_EXT_DEPS :=3D util/python-ext-sources util/setup.py $(LIBAPI)
>=20
> SCRIPTS =3D $(patsubst %.sh,%,$(SCRIPT_SH))
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 728fe2f51759eb0d..72088aec2857b316 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1330,6 +1330,9 @@ static struct {
> static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
> 				  PyObject *args, PyObject *kwargs)
> {
> +#ifndef HAVE_LIBTRACEEVENT
> +	return NULL;
> +#else
> 	struct tep_event *tp_format;
> 	static char *kwlist[] =3D { "sys", "name", NULL };
> 	char *sys  =3D NULL;
> @@ -1344,6 +1347,7 @@ static PyObject *pyrf__tracepoint(struct =
pyrf_evsel *pevsel,
> 		return _PyLong_FromLong(-1);
>=20
> 	return _PyLong_FromLong(tp_format->id);
> +#endif // HAVE_LIBTRACEEVENT
> }
>=20
> static PyMethodDef perf__methods[] =3D {

