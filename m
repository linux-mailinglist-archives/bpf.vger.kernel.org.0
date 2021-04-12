Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DD35D2CB
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbhDLV7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 17:59:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238235AbhDLV7j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 17:59:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CLYOts161429;
        Mon, 12 Apr 2021 17:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YPGUevjsic8Eh9jMoQq2Fkwvsv5C7+SCKyUTvrAYGWQ=;
 b=pudO2s/0wGwJkEQfZygneBOJ28nIY4gYFteIzliI/65xXROjpdhfhPjL0GF185Jw5ZO2
 5L1FCVp0402FAH2zv0JY3w2786WfWFTdrn9HEpXVg7s1mIcuAftO9pgqMgGtpzc1/eUt
 v93iN5Cq/PKQvyMPN5r38tpjMnCmSuZe8LkQuDvA11zNiei9ccVNi4m5zY2OPBvVQ/26
 V497Ffp79iWMphzlJWzxZc1XmOfjrEWigV2vbbS5HPvcVL8Ar6tipBEi+4ZVqNsBU+9C
 Y5GxosQa/p7fFVnvtZ+DUyj2QPn7urFLLXguj2JwVN1odE2zy3ZODkX96/ukUPSa/byD 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vkdkadw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 17:59:09 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13CLZPeC163681;
        Mon, 12 Apr 2021 17:59:08 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vkdkadvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 17:59:08 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CLs4ou004023;
        Mon, 12 Apr 2021 21:59:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 37u3n894r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 21:59:06 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CLwfn135455418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 21:58:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E2B142041;
        Mon, 12 Apr 2021 21:59:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE3BE42042;
        Mon, 12 Apr 2021 21:59:02 +0000 (GMT)
Received: from sig-9-145-157-105.de.ibm.com (unknown [9.145.157.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 21:59:02 +0000 (GMT)
Message-ID: <0b7071d67866aa20c4e60945102461d40c4abafe.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2] bpf: Generate BTF_KIND_FLOAT when linking
 vmlinux
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Mon, 12 Apr 2021 23:59:02 +0200
In-Reply-To: <20210412215629.17865-1-iii@linux.ibm.com>
References: <20210412215629.17865-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AKbqxdRl-5czlbt0DknbiriLQ96RN1HQ
X-Proofpoint-GUID: onv10Td0F6FSSfmCf2r5Xz2ymVdMNkDY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120139
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-04-12 at 23:56 +0200, Ilya Leoshkevich wrote:
> pahole v1.21 supports the --btf_gen_floats flag, which makes it
> generate the information about the floating-point types [1].
> 
> Adjust link-vmlinux.sh to pass this flag to pahole in case it's
> supported, which is determined using a simple version check.
> 
> [1] https://lore.kernel.org/dwarves/YHRiXNX1JUF2Az0A@kernel.org/
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/link-vmlinux.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 3b261b0f74f0..392c7fb94d3e 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -227,8 +227,13 @@ gen_btf()
>  
>         vmlinux_link ${1}
>  
> +       local extra_paholeopt=
> +       if [ "${pahole_ver}" -ge "121" ]; then
> +               extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
> +       fi
> +
>         info "BTF" ${2}
> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> +       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J${extra_paholeopt} ${1}
>  
>         # Create ${2} which contains just .BTF section but no symbols.
> Add
>         # SHF_ALLOC because .BTF will be part of the vmlinux image. --
> strip-all

Sorry, I realized I forgot to add a changelog (it's trivial, but
still). Posting it here:

v1:
https://lore.kernel.org/bpf/20210331014356.256212-1-iii@linux.ibm.com/
v1 -> v2: Use a version check instead of probing.

