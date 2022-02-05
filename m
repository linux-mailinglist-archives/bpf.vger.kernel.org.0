Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D315C4AA742
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 08:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352510AbiBEHF1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Feb 2022 02:05:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbiBEHF1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 5 Feb 2022 02:05:27 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21535Dg7021555;
        Sat, 5 Feb 2022 07:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=08H3uuz44Cn4uZaAU8yi2nrFD3Dr3649QYENwci6BKk=;
 b=l5NGJBzyy/1MI87pbfpj+sMlQSH+5wPOKB4nWT3a7w1XZnNZ4m5NzdkfOqxDHH2DrbFN
 ukVYsuKTyH1LLuG/OfG+e8vThqT9tiq1YZKDkCmB49cGfE81JJ0FEnV56HnRS163quhp
 ElHTd/joUx5qP4t3gHC5e8dRg9Fd7KY1E/itRMX8GrsCTl/3VzXvzldPh8T17XZIxIZF
 wdNI9tYCOwe7vVRmXVDUVVph54wCbQXaGpSkwtkw6lW0wdtoMGeVED3PYsdKj9xUgQS5
 iyV5DCyx5Kzr7FcOb2cWmZexxjtKIdVElPNSwhWwykb8Of+RC9oYRbSFb3dsegqZg89a 9A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1h16jrrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 07:05:24 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21573Wtu005320;
        Sat, 5 Feb 2022 07:05:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3e1gv9grhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 07:05:22 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21575JGt39518544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 07:05:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8D6E11C05C;
        Sat,  5 Feb 2022 07:05:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AA3D11C04A;
        Sat,  5 Feb 2022 07:05:18 +0000 (GMT)
Received: from localhost (unknown [9.43.52.121])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 07:05:18 +0000 (GMT)
Date:   Sat, 05 Feb 2022 07:05:17 +0000
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH bpf-next v3 08/11] libbpf: Fix accessing syscall arguments
 on powerpc
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     bpf@vger.kernel.org
References: <20220204145018.1983773-1-iii@linux.ibm.com>
        <20220204145018.1983773-9-iii@linux.ibm.com>
In-Reply-To: <20220204145018.1983773-9-iii@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1644044691.5wcfkpdq8k.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XcfsE7F2YvYx_KmC5dayXXIhe17dHwjg
X-Proofpoint-ORIG-GUID: XcfsE7F2YvYx_KmC5dayXXIhe17dHwjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050046
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> powerpc's syscall handlers get "unpacked" arguments instead of a
> struct pt_regs pointer. Indicate this to libbpf using
> PT_REGS_SYSCALL_REGS macro.
>=20
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

>=20
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 317bee0fd8e4..f9d22ea0af97 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -181,6 +181,7 @@
>  #define __PT_RC_REG gpr[3]
>  #define __PT_SP_REG sp
>  #define __PT_IP_REG nip
> +#define PT_REGS_SYSCALL_REGS(ctx) ctx
>=20
>  #elif defined(bpf_target_sparc)
>=20
> --=20
> 2.34.1
>=20
>=20
