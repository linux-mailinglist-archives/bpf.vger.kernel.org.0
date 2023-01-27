Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CDE67E566
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 13:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjA0MhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 07:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjA0MhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 07:37:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2B485A4
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 04:37:00 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RC72Tr008629;
        Fri, 27 Jan 2023 12:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=irliqGTvAaIRW5EbUnh+KA81Eyn3vAuly9kVUXuAjJM=;
 b=S7oOqTFB4P/165pqicRpmBsltfBN9AttnHIZjmUBlFOlNcGZWhLn6wiz6MUzB/tj/gdR
 9Mc9xO5gxCzHe+qk4RwV8PQQI/8im3/Cd1SIpeuM39tMN3dZrahikossHfoWeLbCOUUE
 e5my7QiKWDxyVP6M1I9tjWMS4dOr0UzGhqJ0UlZ6U/1f0B+lvuKURF6exh/g1l9S+fCQ
 cgolXCkbcTKDGu6SEe2xMk6wXbF/TPBnPyVE5X/y7Hjrxyum6ftFI5lgo8jsLk8898sL
 dsjPaURcXdNcat3ohpZLKBf0ePqUamAEzX7yDp/jiEIfoNtwMtwZbPVDUoQlRVfzG/Rw 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nceb80q66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:36:44 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RC7eu6014598;
        Fri, 27 Jan 2023 12:36:43 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nceb80q5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:36:43 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QEe0SZ016228;
        Fri, 27 Jan 2023 12:36:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dcr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:36:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCacA024314400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:36:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28F722004F;
        Fri, 27 Jan 2023 12:36:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99AEF20040;
        Fri, 27 Jan 2023 12:36:37 +0000 (GMT)
Received: from [9.179.11.57] (unknown [9.179.11.57])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:36:37 +0000 (GMT)
Message-ID: <924757c3fcda1f17ed68623234a3982e660e2717.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 08/24] selftests/bpf: Fix verify_pkcs7_sig on
 s390x
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 27 Jan 2023 13:36:37 +0100
In-Reply-To: <CAEf4BzaaC4gn-BjpYWP++0GoHbJ2xaOOZ32ZNwq+_vxHVMKpuA@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <20230125213817.1424447-9-iii@linux.ibm.com>
         <CAEf4BzaaC4gn-BjpYWP++0GoHbJ2xaOOZ32ZNwq+_vxHVMKpuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 244icwmMP4464WGVdfXVKigFojsI9nQH
X-Proofpoint-ORIG-GUID: 6Z0oXDf90Qcw2snEwPnxM9U-GKeNkVwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-01-25 at 17:06 -0800, Andrii Nakryiko wrote:
> On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > Use bpf_probe_read_kernel() instead of bpf_probe_read(), which is
> > not
> > defined on all architectures.
> >=20
> > While at it, improve the error handling: do not hide the verifier
> > log,
> > and check the return values of bpf_probe_read_kernel() and
> > bpf_copy_from_user().
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0.../selftests/bpf/prog_tests/verify_pkcs7_sig.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 9
> > +++++++++
> > =C2=A0.../selftests/bpf/progs/test_verify_pkcs7_sig.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12
> > ++++++++----
> > =C2=A02 files changed, 17 insertions(+), 4 deletions(-)
> >=20
> > diff --git
> > a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > index 579d6ee83ce0..75c256f79f85 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> > @@ -56,11 +56,17 @@ struct data {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 sig_len;
> > =C2=A0};
> >=20
> > +static char libbpf_log[8192];
> > =C2=A0static bool kfunc_not_supported;
> >=20
> > =C2=A0static int libbpf_print_cb(enum libbpf_print_level level, const
> > char *fmt,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 va_list args)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t log_len =3D strlen(libbpf_=
log);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vsnprintf(libbpf_log + log_len, s=
izeof(libbpf_log) -
> > log_len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 fmt, args);
>=20
> it seems like test is written to assume that load might fail and
> we'll
> get error messages, so not sure it's that useful to print out these
> errors. But at the very least we should filter out DEBUG and INFO
> level messages, and pass through WARN only.
>=20
> Also, there is no point in having a separate log buffer, just printf
> directly. test_progs will take care to collect overall log and ignore
> it if test succeeds, or emit it if test fails

Thanks, I completely overlooked the fact that the test framework
already hides the output in case of success. With that in mind I can do
just this:

--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -61,6 +61,9 @@ static bool kfunc_not_supported;
 static int libbpf_print_cb(enum libbpf_print_level level, const char
*fmt,
                           va_list args)
 {
+       if (level =3D=3D LIBBPF_WARN)
+               vprintf(fmt, args);
+
        if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in
kernel or module BTFs\n"))
                return 0;
=20
If the load fails due to missing kfuncs, we'll skip the test - I think
in this case the output won't be printed either, so we should be fine.

> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(fmt, "libbpf: ext=
ern (func ksym) '%s': not found
> > in kernel or module BTFs\n"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> >=20
> > @@ -277,6 +283,7 @@ void test_verify_pkcs7_sig(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ASSERT_OK_PTR(skel, "te=
st_verify_pkcs7_sig__open"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto close_prog;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libbpf_log[0] =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_print_cb =3D libbpf_set_=
print(libbpf_print_cb);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D test_verify_pkcs7_si=
g__load(skel);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libbpf_set_print(old_print_c=
b);
> > @@ -289,6 +296,8 @@ void test_verify_pkcs7_sig(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto close_prog;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s", libbpf_log);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ASSERT_OK(ret, "test_ve=
rify_pkcs7_sig__load"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto close_prog;
> >=20
> > diff --git
> > a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > index ce419304ff1f..7748cc23de8a 100644
> > --- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> > @@ -59,10 +59,14 @@ int BPF_PROG(bpf, int cmd, union bpf_attr
> > *attr, unsigned int size)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!data_val)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_probe_read(&value, sizeof(val=
ue), &attr->value);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_copy_from_user(data_val, size=
of(struct data),
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (void *)(unsigned long)value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_probe_read_kernel(&va=
lue, sizeof(value), &attr-
> > >value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bpf_copy_from_user(data_v=
al, sizeof(struct data),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)(unsigned long)value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
>=20
> this part looks good, we shouldn't use bpf_probe_read.
>=20
> You'll have to update progs/profiler.inc.h as well, btw, which still
> uses bpf_probe_read() and bpf_probe_read_str.

I remember trying this, but there were still failures due to, as I
thought back then, usage of BPF_CORE_READ() and the lack of
BPF_CORE_READ_KERNEL(). But this seems to be a generic issue. Let me
try again and post my findings as a reply to 0/24.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data_val->data_len > siz=
eof(data_val->data))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > --
> > 2.39.1
> >=20

