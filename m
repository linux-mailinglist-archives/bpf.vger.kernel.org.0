Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5467CC34
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbjAZNbS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 08:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbjAZNbQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 08:31:16 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40A6DFDA
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 05:30:57 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCswih032529;
        Thu, 26 Jan 2023 13:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1knRlZq3IBNEKKegu+Qc5cPuOYCOTiLqmTY8z40ibuo=;
 b=A5QvaENjRpWWZ7xJspvX/GU9+XQSfIYrvW8TyUE/jI4+ZqZdsgo1SL3X0Eq2hg4CU7xw
 q9/xy0b3r2/3odFUOvKjrZ/EMeksp7JyapuDvNuNIeJ8ZY0cQp0tTrZmnG5c/E1iulLo
 d7AfWE+1eIZ1HpeVwod6mxFBjNNDOMXKO3m/l/hPru0/HaCPL/BskY7xsNb+nMBEA+G5
 Zue36oz+DMsDFl/r2AAqv5DO9C0P7avvdgF8kZqCCV8JYhfKVSst/KTAq4ZKjvbage05
 BOCgSXISz3HW//21JXODxnhmwLSkTTQArG8LUAN/WZ5j1jOl2NDGKA3d2Hg0nM2ZzzBj xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbn5b7avt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:30:43 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QDF94U020645;
        Thu, 26 Jan 2023 13:30:42 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbn5b7av8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:30:42 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PMixQh004576;
        Thu, 26 Jan 2023 13:30:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afcnr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:30:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDUb4c48759194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:30:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F4CC20040;
        Thu, 26 Jan 2023 13:30:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 043E320043;
        Thu, 26 Jan 2023 13:30:37 +0000 (GMT)
Received: from [9.155.209.149] (unknown [9.155.209.149])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:30:36 +0000 (GMT)
Message-ID: <726a3a7502ade898bfcc98be1c1afc3d21091f7b.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 01/24] selftests/bpf: Fix liburandom_read.so
 linker error
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 26 Jan 2023 14:30:36 +0100
In-Reply-To: <CAEf4Bzbxvg1a-kqvDeRmPcL2LDQf-cnRwoj4yds1u9JwAZ3HPg@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <20230125213817.1424447-2-iii@linux.ibm.com>
         <CAEf4Bzbxvg1a-kqvDeRmPcL2LDQf-cnRwoj4yds1u9JwAZ3HPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bSFTfF74HToxqzIzGskV93zAOxftnsvd
X-Proofpoint-ORIG-GUID: DOCOj6iyNyxYHjctLlaFlFORBww1ryvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-01-25 at 17:07 -0800, Andrii Nakryiko wrote:
> On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > When building with O=3D, the following linker error occurs:
> >=20
> > =C2=A0=C2=A0=C2=A0 clang: error: no such file or directory: 'liburandom=
_read.so'
> >=20
> > Fix by adding $(OUTPUT) to the linker search path.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0tools/testing/selftests/bpf/Makefile | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/Makefile
> > b/tools/testing/selftests/bpf/Makefile
> > index c9b5ed59e1ed..43098eb15d31 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -189,9 +189,9 @@ $(OUTPUT)/liburandom_read.so:
> > urandom_read_lib1.c urandom_read_lib2.c
> > =C2=A0$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c
> > $(OUTPUT)/liburandom_read.so
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call msg,BINARY,,$@)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(Q)$(CLANG) $(filter-out -s=
tatic,$(CFLAGS) $(LDFLAGS))
> > $(filter %.c,$^) \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 liburandom_read.so $(filter-o=
ut -
> > static,$(LDLIBS))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(filter-out -
> > static,$(LDLIBS))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -fuse-ld=3D$(LLD) -Wl,-=
znoseparate-code -Wl,--
> > build-id=3Dsha1 \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Wl,-rpath=3D. -o $@
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Wl,-rpath=3D. -o $@ -lurando=
m_read -L$(OUTPUT)
>=20
> why moving to the end? it's nice in verbose logs when the last thing
> is the resulting file ($@), so if possible, let's move it back?

You're right, I'm just used to having the libraries at the end, but
here we already have $(LDLIBS) in the middle. Will do in v2.

>=20
> >=20
> > =C2=A0$(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call msg,SIGN-FILE,,$@)
> > --
> > 2.39.1
> >=20

