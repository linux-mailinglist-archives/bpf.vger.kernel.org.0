Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE66904F1
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 11:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBIKdX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 05:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjBIKbs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 05:31:48 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF0176B3
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 02:30:59 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3198hjus023733;
        Thu, 9 Feb 2023 10:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9QaVKVW1wssnb7QCUS/py7PJk8YsMDttA7iNBvbOiFg=;
 b=InmJUrC3HgZP8lcYz6JK3YcGJxQH8D3W7SuuLchVG772RD9GPKPQGpOD40dNUOiHnHvS
 pj18jyAOBSsqsO/q/h4X/Y9XdvSo56qD3L3bt4awXADFnw/0jJKhLO6/7ZLxq+iD09ag
 9LuAp0ck/rO/l2dozqv4RvploHyGa5b5vNasWYkwf6WPySu1xnYOapYTz5nzmbVwX7Si
 NRPgDAVoq5fy4bEh8FR+1P4vUJi44X0A8GGqtqpC8Zbu6xY0SB9QNRviiL/5+Gquauac
 AYgRPYXCpLzYXZbTl4c4HuyQrLIkQRZyN71xlkC1wI4rWjcK+G/pJxWEJkb36/sqBC8m wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmwjqjhh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:30:43 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319AUOVA025733;
        Thu, 9 Feb 2023 10:30:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmwjqjhgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:30:42 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318JAGCd020984;
        Thu, 9 Feb 2023 10:30:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfp2dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:30:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319AUbT124117586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 10:30:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EE732004F;
        Thu,  9 Feb 2023 10:30:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5A8620040;
        Thu,  9 Feb 2023 10:30:36 +0000 (GMT)
Received: from [9.171.66.233] (unknown [9.171.66.233])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 10:30:36 +0000 (GMT)
Message-ID: <7c815a4c0b65bb723e6afbf828fb478ceb5576eb.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Add MSan annotations
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date:   Thu, 09 Feb 2023 11:30:36 +0100
In-Reply-To: <CAEf4BzYMa5SXLu8Ajy7DjyJ3-qvK=AN5w+9YNwxrrQyjsNPk+g@mail.gmail.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
         <20230208205642.270567-10-iii@linux.ibm.com>
         <CAEf4BzYMa5SXLu8Ajy7DjyJ3-qvK=AN5w+9YNwxrrQyjsNPk+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bdZiVx2s7wh7afk3zh4Bw0K68TK_vY2C
X-Proofpoint-ORIG-GUID: suMC3_7o_3_ohz6VDHz9XX_QS3VcPb35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_07,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-02-08 at 17:34 -0800, Andrii Nakryiko wrote:
> On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > eBPF selftests produce a few false positives with MSan. These can
> > be
> > divided in two classes:
> >=20
> > - Sending uninitalized data via a socket.
> > - bpf_obj_get_info_by_fd() calls.
> >=20
> > The first class is trivial; the second should ideally be handled by
> > libbpf, but it doesn't look possible at the moment, since we don't
> > know the type of the eBPF object referred to by fd, and therefore
> > the
> > structure of the output data.
>=20
> yeah, bpf_obj_get_info_by_fd() is quite bad from usability
> standpoint.
> I think we should add bpf_get_{map,prog,link,btf}_info_by_fd()
> wrappers and try to use them. That will allow to specify correct
> expected struct types, we'll be able to mark initialized memory
> properly. We already have bpf_{map,prog,btf,link}_get_fd_by_id()
> family, so having similar for getting info seems fitting (even if
> underlying bpf() command is generic).
>=20
> Thoughts?

Sounds good to me, I will give it a try.

> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0tools/testing/selftests/bpf/cap_helpers.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > =C2=A0tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c=C2=A0=C2=A0 |=
 10
> > ++++++++++
> > =C2=A0tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c=C2=A0=C2=A0 |=
=C2=A0 3 +++
> > =C2=A0tools/testing/selftests/bpf/prog_tests/btf.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11
> > +++++++++++
> > =C2=A0tools/testing/selftests/bpf/prog_tests/send_signal.c=C2=A0 |=C2=
=A0 2 ++
> > =C2=A0.../selftests/bpf/prog_tests/tp_attach_query.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> > =C2=A0tools/testing/selftests/bpf/prog_tests/xdp_bonding.c=C2=A0 |=C2=
=A0 3 +++
> > =C2=A0tools/testing/selftests/bpf/xdp_synproxy.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A08 files changed, 40 insertions(+)
> >=20
>=20
> [...]

