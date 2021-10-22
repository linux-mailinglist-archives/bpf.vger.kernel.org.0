Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528FE437565
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhJVK0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 06:26:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232483AbhJVK0s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 06:26:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19M9Zvqh004491;
        Fri, 22 Oct 2021 06:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yVT4dh5crNcz7J5emRyqwKpgXKwzArVjBWkSrO3kxxY=;
 b=Pjg155T1q5QFwAMarjY7x/IrQd1dPgHREcp7rrDQbpli3XFA+tRpfDnV2VFs+EOBjKQr
 sffM66pB/7ntzPxRidrEHnNFZ60iEyOC8f7mk6AmnN69htocdv2htTZ8TJT1MSVa6a7v
 hQaQoRm/S+3r9dZjkB0q7OZkGyVbFs1AfIKastqhmahunjavtpPoDwnzxNZPwdRZO3Jt
 /SSimnciBemMaVDPGmabSk4ojH5GaEeFkGvRPazTOuYxh4fPqM9bIGHaIEApMYOeUaB9
 AcUenchMmR8NRipnZ0IWVSJI8hYRDyXTJwjZxZeby7K0K35vRhMedNJiPyFSnmKWyJqA Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bufj0mq39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 06:24:17 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19M9wBP6013306;
        Fri, 22 Oct 2021 06:24:16 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bufj0mq2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 06:24:16 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19MABl9L032400;
        Fri, 22 Oct 2021 10:24:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3bqpcabu8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:24:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19MAOBqO2622010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:24:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0EB5A4054;
        Fri, 22 Oct 2021 10:24:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EA50A405F;
        Fri, 22 Oct 2021 10:24:11 +0000 (GMT)
Received: from sig-9-145-12-156.uk.ibm.com (unknown [9.145.12.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Oct 2021 10:24:11 +0000 (GMT)
Message-ID: <8e1c57c29be8812cbd6407112b00939c7ea780ab.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: Fix relocating big-endian bitfields
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 22 Oct 2021 12:24:11 +0200
In-Reply-To: <20211021234653.643302-3-iii@linux.ibm.com>
References: <20211021234653.643302-1-iii@linux.ibm.com>
         <20211021234653.643302-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -yAvdDPjH9yL9FxRv0LWBwPfB_80x4Sf
X-Proofpoint-GUID: BhvdvPjrbdvX81HTMXAHqyE5HfLA7LSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_02,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220056
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2021-10-22 at 01:46 +0200, Ilya Leoshkevich wrote:
> This is the same as commit c9e982b87946 ("libbpf: Fix dumping
> big-endian bitfields"), but for CO-RE. Make the code structure as
> similar as possible to that of btf_dump_get_bitfield_value().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/relo_core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index b5b8956a1be8..fd814b985e1e 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -661,13 +661,18 @@ static int bpf_core_calc_field_relo(const char
> *prog_name,
>                 if (validate)
>                         *validate = true; /* signedness is never
> ambiguous */
>                 break;
> -       case BPF_FIELD_LSHIFT_U64:
> +       case BPF_FIELD_LSHIFT_U64: {
> +               __u32 bits_offset = bit_off - byte_off * 8;
> +               __u8 nr_copy_bits;
> +
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> -               *val = 64 - (bit_off + bit_sz - byte_off  * 8);
> +               nr_copy_bits = bit_sz + bits_offset;
>  #else
> -               *val = (8 - byte_sz) * 8 + (bit_off - byte_off * 8);
> +               nr_copy_bits = byte_sz * 8 - bits_offset;
>  #endif
> +               *val = 64 - nr_copy_bits;
>                 break;
> +       }
>         case BPF_FIELD_RSHIFT_U64:
>                 *val = 64 - bit_sz;
>                 if (validate)

At a closer look this patch is not necessary: the new and the old
expressions yield the same result. Please disregard it.

Best regards,
Ilya

