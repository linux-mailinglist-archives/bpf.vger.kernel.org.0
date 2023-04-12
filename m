Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB876DEB82
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 08:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDLGEb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 02:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLGEa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 02:04:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359DEF7;
        Tue, 11 Apr 2023 23:04:29 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C5tMQ5023544;
        Wed, 12 Apr 2023 06:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=nhscJsslmlKYVcGYTBp8JzDV6+njDKE79AOyU0p7Zss=;
 b=SjgxhJQPVGK5mF/6MZXVn7slvk2mnbpJaVeBdlUZ0SuLPbhUa6WQ8RmNnKc5BwUraFiP
 HXSOs9x5CfUTTReVUNv4tA4qzOjd9IO+o0S2NEsXaiT2inWW0p8t2tuLILphzsnRBHY7
 Q1jVZTuMYsx1PbAbluR8NOva9PRAviqTI1GoFH3lNpPe7Rf/W7Ae14WwEqf+jVyXSDUr
 dnsMxbLnQP86jDRsDArNMEvoaklq5zcTQUES8lu9VHe1k1paNY++bCmXe4xhTky4iLML
 eMfZtO20qbYIuPOpp/YFYBq087jGnOMPc947Ms/OMzVxib6Zb4N5QYLLe49XP1D7EOuO ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwpwqr9wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 06:04:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C5wS0C031385;
        Wed, 12 Apr 2023 06:04:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwpwqr9t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 06:04:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C4Coib012368;
        Wed, 12 Apr 2023 06:04:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pu0hq1tkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 06:04:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C645iH16974374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 06:04:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8108020043;
        Wed, 12 Apr 2023 06:04:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29E2520040;
        Wed, 12 Apr 2023 06:04:05 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 06:04:05 +0000 (GMT)
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
Date:   Wed, 12 Apr 2023 08:04:04 +0200
In-Reply-To: <20230405132120.59886-4-quentin@isovalent.com> (Quentin Monnet's
        message of "Wed, 5 Apr 2023 14:21:16 +0100")
Message-ID: <yt9d8rexy6uj.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uxpDhElEdIp8Tp4uP4bAiiZjnrtXpw3B
X-Proofpoint-GUID: 1_OgglVB3CC42JzZqwqVZC-rujYoy46N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Quentin Monnet <quentin@isovalent.com> writes:

> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
> index e7f6ec3a8f35..583aa843df92 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -821,3 +821,37 @@ void btf_dump_linfo_json(const struct btf *btf,
>  					BPF_LINE_INFO_LINE_COL(linfo->line_col));
>  	}
>  }
> +
> +static void dotlabel_puts(const char *s)
> +{
> +	for (; *s; ++s) {
> +		switch (*s) {
> +		case '\\':
> +		case '"':
> +		case '{':
> +		case '}':
> +		case '<':
> +		case '>':
> +		case '|':
> +		case ' ':
> +			putchar('\\');
> +			__fallthrough;

Is __fallthrough correct? I see the following compile error on s390 in
linux-next (20230412):

  CC      btf_dumper.o
btf_dumper.c: In function =E2=80=98dotlabel_puts=E2=80=99:
btf_dumper.c:838:25: error: =E2=80=98__fallthrough=E2=80=99 undeclared (fir=
st use in this function); did you mean =E2=80=98fallthrough=E2=80=99?
  838 |                         __fallthrough;
      |                         ^~~~~~~~~~~~~

removing the two underscores fixes this.

> +		default:
> +			putchar(*s);
> +		}
> +	}
> +}

Thanks,
Sven
