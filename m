Return-Path: <bpf+bounces-48522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E7BA088B3
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 08:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E163A7FB2
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 07:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34C2066F6;
	Fri, 10 Jan 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnAbgUsL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A742A99;
	Fri, 10 Jan 2025 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736492749; cv=none; b=ptLPFOAfzYUYveIpbk01HO9akmG+CnsLYWT670k0rt9VHwBE6iVQGq7gK0HJmmSNM1YXtl+n2xS0oQ2lkVyddy41mBjgl5p6F2vQCDtBuHV8kDXRE1x/AuS5PaYZNRcHKXbWFsFthbOJNz/HBAzLRWpPtol38/wjn6uKj1qorHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736492749; c=relaxed/simple;
	bh=t7OYVwRzeyvgItw5U5zv9oC0mjA+jZVUjTlsLW7ILnc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oNj0POc7kUCkb7590roD3d/uW5aMGXKPHpaNmOhGD7sjHVlgo9BHgNpdgflN4eCImoPhmSqUfee1trBlWmKbtOC5wX8P5DNdkrfl+QQc5lnF92F1KUMmbhKNU3mF9CPucMAGOjP1D5tK0nX109KQz45yg8DdjBtX8jSQMc49F+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnAbgUsL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509Nx3WS001536;
	Fri, 10 Jan 2025 07:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ga2v7r
	9meIaBz31U84eL3jzMovm9W2gKUR+quKpB1qA=; b=QnAbgUsLn+3Vws1cBuxTgI
	q8qT2Sxy0KdXA7TFwPigM8cyZ3GDwHKLSpVpJpb2PwHBGDr1SDvvg7UA0Rt9zpBt
	vZAL2svAjglyIlH+TCw821igklZH+0BMbx0V7vZYwB/NqQqP8OPj/uXKtcgubVYC
	WD8yzvXJIln8d1U4DhuZqI+u8nKz8ajOc41MPouCwMpIo7qXkNcy3wRGBKcTeTo+
	LwvR3qLCv0TkgMQTE3VJU/14iYnAdIInln+AZzQF5Klv3er80Bo/xRJmF0wfSQwc
	qARk+SpbTp8aW7/7mbnOiu1NWkPtpXp6O06MtO5vUg6r3QCKcN6dWYSG7UNyuyMw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhs8x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:05:17 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50A744c8012820;
	Fri, 10 Jan 2025 07:05:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhs8wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:05:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50A5RVYL013571;
	Fri, 10 Jan 2025 07:05:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap916j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 07:05:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50A75Do329229632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 07:05:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E42B420040;
	Fri, 10 Jan 2025 07:05:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A95B2004B;
	Fri, 10 Jan 2025 07:05:00 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.17])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jan 2025 07:04:59 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Z4A8NU02WVBDGrYZ@ghost>
Date: Fri, 10 Jan 2025 12:34:46 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org,
        bpf@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8639C367-2669-4924-83D8-15EAFAC42699@linux.vnet.ibm.com>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1> <Z4AoFA974kauIJ9T@ghost> <Z4A2Y269Ffo0ERkS@x1>
 <Z4A8NU02WVBDGrYZ@ghost>
To: Charlie Jenkins <charlie@rivosinc.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Hari Bathini <hbathini@linux.ibm.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CR4E83pg86k8Cx0Y_9xNEtR5rkcWclRc
X-Proofpoint-GUID: l3UdX7YMbwWwHX9jihu9fy-EzLhsFC2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100056



> On 10 Jan 2025, at 2:44=E2=80=AFAM, Charlie Jenkins =
<charlie@rivosinc.com> wrote:
>=20
> On Thu, Jan 09, 2025 at 05:49:39PM -0300, Arnaldo Carvalho de Melo =
wrote:
>> On Thu, Jan 09, 2025 at 11:48:36AM -0800, Charlie Jenkins wrote:
>>> On Thu, Jan 09, 2025 at 12:59:43PM -0300, Arnaldo Carvalho de Melo =
wrote:
>>>> =E2=AC=A2 [acme@toolbox perf-tools-next]$ git log --oneline -1 ; =
time make -C tools/perf build-test
>>>> d06826160a982494 (HEAD -> perf-tools-next) perf tools: Remove =
dependency on libaudit
>>>> make: Entering directory =
'/home/acme/git/perf-tools-next/tools/perf'
>>>> - tarpkg: ./tests/perf-targz-src-pkg .
>>>>                 make_static: cd . && make LDFLAGS=3D-static =
NO_PERF_READ_VDSO32=3D1 NO_PERF_READ_VDSOX32=3D1 NO_JVMTI=3D1 =
NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1 -j28  DESTDIR=3D/tmp/tmp.JJT3tvN7bV
>>>>              make_with_gtk2: cd . && make GTK2=3D1 -j28  =
DESTDIR=3D/tmp/tmp.BF53V2qpl3
>>>> - =
/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . =
&& make =
FEATURE_DUMP_COPY=3D/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_F=
EATURE_DUMP  feature-dump
>>>> cd . && make =
FEATURE_DUMP_COPY=3D/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_F=
EATURE_DUMP feature-dump
>>>>         make_no_libbionic_O: cd . && make NO_LIBBIONIC=3D1 =
FEATURES_DUMP=3D/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATU=
RE_DUMP -j28 O=3D/tmp/tmp.KZuQ0q2Vs6 DESTDIR=3D/tmp/tmp.0sxMyH91gS
>>>>           make_util_map_o_O: cd . && make util/map.o =
FEATURES_DUMP=3D/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATU=
RE_DUMP -j28 O=3D/tmp/tmp.Y0Mx3KLREI DESTDIR=3D/tmp/tmp.wg9HCVVLHE
>>>>              make_install_O: cd . && make install =
FEATURES_DUMP=3D/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATU=
RE_DUMP -j28 O=3D/tmp/tmp.P0LEBAkW1X DESTDIR=3D/tmp/tmp.agTavZndFN
>>>>  failed to find: etc/bash_completion.d/perf
>>>=20
>>> Is this something introduced by this patch?
>>=20
>> I don't think so.
>>=20
>> BTW this series is already pushed out to perf-tools-next:
>>=20
>> =
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/l=
og/?h=3Dperf-tools-next
>>=20
>> Thanks!
>>=20
>> - Arnaldo
>=20
> Thank you!
>=20
> - Charlie

Hi Charlie, Arnaldo

While testing the series, I hit compilation issue in powerpc

Snippet of logs:


  CC      util/syscalltbl.o
In file included from =
/home/athira/perf-tools-next/tools/perf/arch/powerpc/include/syscall_table=
.h:5,
                 from util/syscalltbl.c:16:
arch/powerpc/include/generated/asm/syscalls_64.h:16:16: error: =
initialized field overwritten [-Werror=3Doverride-init]
   16 |         [13] =3D "time",
      |                ^~~~~~
arch/powerpc/include/generated/asm/syscalls_64.h:16:16: note: (near =
initialization for =E2=80=98syscalltbl[13]=E2=80=99)
arch/powerpc/include/generated/asm/syscalls_64.h:22:16: error: =
initialized field overwritten [-Werror=3Doverride-init]
   22 |         [18] =3D "oldstat",
      |                ^~~~~~~~~
arch/powerpc/include/generated/asm/syscalls_64.h:22:16: note: (near =
initialization for =E2=80=98syscalltbl[18]=E2=80=99)
arch/powerpc/include/generated/asm/syscalls_64.h:27:16: error: =
initialized field overwritten [-Werror=3Doverride-init]
   27 |         [22] =3D "umount",
      |                ^~~~~~~~


And similar errors is there for few more entries. The reason is that, =
the generated syscalls file has two entries for each of these failing =
cases.

=46rom arch/powerpc/include/generated/asm/syscalls_64.h created by =
scrips/syscalltbl.sh=20


  1 static const char *const syscalltbl[] =3D {
  2         [0] =3D "restart_syscall",
  3         [1] =3D "exit",
  4         [2] =3D "fork",
  5         [3] =3D "read",
  6         [4] =3D "write",
  7         [5] =3D "open",
  8         [6] =3D "close",
  9         [7] =3D "waitpid",
 10         [8] =3D "creat",
 11         [9] =3D "link",
 12         [10] =3D "unlink",
 13         [11] =3D "execve",
 14         [12] =3D "chdir",
 15         [13] =3D "time=E2=80=9D,                          =20
 16         [13] =3D "time=E2=80=9D,                   =20
 17         [14] =3D "mknod",
 18         [15] =3D "chmod",
 19         [16] =3D "lchown",
 20         [17] =3D "break",
 21         [18] =3D "oldstat",
 22         [18] =3D "oldstat=E2=80=9D,

Line number 15 an 16 shows two entries for time. Similarly last two =
lines for oldstat. This is picked form =
https://github.com/torvalds/linux/blob/master/tools/perf/arch/powerpc/entr=
y/syscalls/syscall.tbl

13      32      time                            sys_time32
13      64      time                            sys_time

18      32      oldstat                         sys_stat                 =
       sys_ni_syscall
18      64      oldstat                         sys_ni_syscall

For same nr, two entries are there. In the arch specific version of the =
script that makes the syscall table, this was handled : =
https://github.com/torvalds/linux/blob/master/tools/perf/arch/powerpc/entr=
y/syscalls/mksyscalltbl#L28

So we will need change in generic script also. Proposing below change :=20=


diff --git a/tools/perf/scripts/syscalltbl.sh =
b/tools/perf/scripts/syscalltbl.sh
index 1ce0d5aa8b50..d66cec10cc2d 100755
--- a/tools/perf/scripts/syscalltbl.sh
+++ b/tools/perf/scripts/syscalltbl.sh
@@ -75,8 +75,10 @@ max_nr=3D0
 # the params are: nr abi name entry compat
 # use _ for intentionally unused variables according to SC2034
 while read nr _ name _ _; do
-    emit "$nr" "$name" >> $outfile
-    max_nr=3D$nr
+ if [ "$max_nr" -lt "$nr" ]; then
+ emit "$nr" "$name" >> $outfile
+ max_nr=3D$nr
+ fi
 done < $sorted_table
   rm -f $sorted_table

Arnaldo,
I see we have this patch series in perf-tools-next. If we need above =
change as a separate patch, please let me know.

Thanks
Athira

>=20
>=20


