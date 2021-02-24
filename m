Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3D3247A8
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhBXXwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:52:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231810AbhBXXwR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:52:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ONY1Ki169932;
        Wed, 24 Feb 2021 18:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=U6p775zCx8iWOyzDksTh8fXHI7A6WvG3waAJWeLJ2do=;
 b=Kce2faMVtDSiqchsn+EFMFCW8AnRijxnNfZ3fLjRTxYwXT59sjmGxdlPqe+Ljtc2P/1M
 zUZhxjLGJgtL0RVjMFUhaC6Wk6RE01wCx88r6/yg4cqFgEc9+hU6yLvOhYFqoy5+IWXZ
 N4T6zMp0chdqWC5EeXqVbs+G7YIc0hNDkA/cHQFtilNIg5OUM7C0mZWk8kV0K8WmJ/Vu
 mMhfE9Lb3SAI+2XMR26SARKIu6qbkUPTdPCdlpApqPm3v85fDBtHkHsejolpIequoliK
 +33tdGOniDYyh153B5MVtSszuM1zwCPA3AWwKulIkPGk3j7ItFdNfPNZPgFSgy/1AsnC TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wwntnfsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:51:23 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ONeFmA195575;
        Wed, 24 Feb 2021 18:51:23 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wwntnfrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:51:22 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ONmOpm003451;
        Wed, 24 Feb 2021 23:51:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 36tt28a327-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:51:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONp5FH26935794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:51:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43A8942056;
        Wed, 24 Feb 2021 23:51:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFF134204B;
        Wed, 24 Feb 2021 23:51:17 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:51:17 +0000 (GMT)
Message-ID: <6faacb23167b6b4612c7f9f7cd3b96fb4fdc1b72.camel@linux.ibm.com>
Subject: Re: [PATCH v6 bpf-next 7/9] selftest/bpf: Add BTF_KIND_FLOAT tests
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 25 Feb 2021 00:51:17 +0100
In-Reply-To: <20210224234535.106970-8-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
         <20210224234535.106970-8-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240184
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2021-02-25 at 00:45 +0100, Ilya Leoshkevich wrote:
> Test the good variants as well as the potential malformed ones.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/btf_helpers.c    |   4 +
>  tools/testing/selftests/bpf/prog_tests/btf.c | 131 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |   3 +
>  3 files changed, 138 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/btf_helpers.c
> b/tools/testing/selftests/bpf/btf_helpers.c
> index 48f90490f922..b692e6ead9b5 100644
> --- a/tools/testing/selftests/bpf/btf_helpers.c
> +++ b/tools/testing/selftests/bpf/btf_helpers.c
> @@ -23,6 +23,7 @@ static const char * const btf_kind_str_mapping[] = {
>         [BTF_KIND_FUNC_PROTO]   = "FUNC_PROTO",
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
> +       [BTF_KIND_FLOAT]        = "FLOAT",
>  };
>  
>  static const char *btf_kind_str(__u16 kind)
> @@ -173,6 +174,9 @@ int fprintf_btf_type_raw(FILE *out, const struct
> btf *btf, __u32 id)
>                 }
>                 break;
>         }
> +       case BTF_KIND_FLOAT:
> +               fprintf(out, " size=%u", t->size);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c
> b/tools/testing/selftests/bpf/prog_tests/btf.c
> index c29406736138..11d98d3cf949 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -3531,6 +3531,136 @@ static struct btf_raw_test raw_tests[] = {
>         .max_entries = 1,
>  },
>  
> +{
> +       .descr = "float test #1, well-formed",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),
> +                                                               /* [1]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                /* [2]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 4),                /* [3]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 8),                /* [4]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 12),               /* [5]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 16),               /* [6]
> */
> +               BTF_STRUCT_ENC(NAME_TBD, 5, 48),                /* [7]
> */
> +               BTF_MEMBER_ENC(NAME_TBD, 2, 0),
> +               BTF_MEMBER_ENC(NAME_TBD, 3, 32),
> +               BTF_MEMBER_ENC(NAME_TBD, 4, 64),
> +               BTF_MEMBER_ENC(NAME_TBD, 5, 128),
> +               BTF_MEMBER_ENC(NAME_TBD, 6, 256),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0int\0_Float16\0float\0double\0_Float80\0long_dou
> ble"
> +                   "\0floats\0a\0b\0c\0d\0e"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "float_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 48,
> +       .key_type_id = 1,
> +       .value_type_id = 7,
> +       .max_entries = 1,
> +},
> +{
> +       .descr = "float test #2, invalid vlen",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),
> +                                                               /* [1]
> */
> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_FLOAT, 0,
> 1), 4),
> +                                                               /* [2]
> */
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0int\0float"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "float_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 2,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "vlen != 0",
> +},
> +{
> +       .descr = "float test #3, invalid kind_flag",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),
> +                                                               /* [1]
> */
> +               BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_FLOAT, 1,
> 0), 4),
> +                                                               /* [2]
> */
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0int\0float"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "float_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 2,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Invalid btf_info kind_flag",
> +},
> +{
> +       .descr = "float test #4, member does not fit",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),
> +                                                               /* [1]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 4),                /* [2]
> */
> +               BTF_STRUCT_ENC(NAME_TBD, 1, 2),                 /* [3]
> */
> +               BTF_MEMBER_ENC(NAME_TBD, 2, 0),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0int\0float\0floats\0x"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "float_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 3,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Member exceeds struct_size",
> +},
> +{
> +       .descr = "float test #5, member is not properly aligned",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),
> +                                                               /* [1]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 4),                /* [2]
> */
> +               BTF_STRUCT_ENC(NAME_TBD, 1, 8),                 /* [3]
> */
> +               BTF_MEMBER_ENC(NAME_TBD, 2, 8),
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0int\0float\0floats\0x"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "float_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 4,
> +       .key_type_id = 1,
> +       .value_type_id = 3,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Member is not properly aligned",
> +},
> +{
> +       .descr = "float test #6, invalid size",
> +       .raw_types = {
> +               BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),
> +                                                               /* [1]
> */
> +               BTF_TYPE_FLOAT_ENC(NAME_TBD, 6),                /* [2]
> */
> +               BTF_END_RAW,
> +       },
> +       BTF_STR_SEC("\0int\0float"),
> +       .map_type = BPF_MAP_TYPE_ARRAY,
> +       .map_name = "float_type_check_btf",
> +       .key_size = sizeof(int),
> +       .value_size = 6,
> +       .key_type_id = 1,
> +       .value_type_id = 2,
> +       .max_entries = 1,
> +       .btf_load_err = true,
> +       .err_str = "Invalid type_size",
> +},
> +
>  }; /* struct btf_raw_test raw_tests[] */
>  
>  static const char *get_next_str(const char *start, const char *end)
> @@ -6630,6 +6760,7 @@ static int btf_type_size(const struct btf_type
> *t)
>         case BTF_KIND_PTR:
>         case BTF_KIND_TYPEDEF:
>         case BTF_KIND_FUNC:
> +       case BTF_KIND_FLOAT:
>                 return base_size;
>         case BTF_KIND_INT:
>                 return base_size + sizeof(__u32);
> diff --git a/tools/testing/selftests/bpf/test_btf.h
> b/tools/testing/selftests/bpf/test_btf.h
> index 2023725f1962..e2394eea4b7f 100644
> --- a/tools/testing/selftests/bpf/test_btf.h
> +++ b/tools/testing/selftests/bpf/test_btf.h
> @@ -66,4 +66,7 @@
>  #define BTF_FUNC_ENC(name, func_proto) \
>         BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0),
> func_proto)
>  
> +#define BTF_TYPE_FLOAT_ENC(name, sz) \
> +       BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
> +
>  #endif /* _TEST_BTF_H */

Sorry, I forgot to add:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

to the commit description here [1].

[1]
https://lore.kernel.org/bpf/CAEf4BzZXvokRMWqDrOg2JWFPr+caNjG=yeCM-W_9cDhkVraRPg@mail.gmail.com/


