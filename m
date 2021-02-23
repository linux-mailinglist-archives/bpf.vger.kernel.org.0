Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0663231F0
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 21:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhBWUPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 15:15:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233376AbhBWUPO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 15:15:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NK5Mvk079837;
        Tue, 23 Feb 2021 15:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=n38tzIWqff3O4caV+3RFmawaHXVxLA3sbAJhbzF1sfc=;
 b=cVzsSUym8Cr62Fi1QTtuRC5EICoI4+UXaIQgRKxuhdL04rFJ4ZIMBIVddwd/8qxKu9fS
 +CM/SdmEJrrT1r5Jqa9UFNpXGvILliwaorGM1v8FO/r9hD4gz0rCiTHs0t9Z/HWXCPd+
 rDRhmeyHHauZFP8zD07vntkS0dwRmj+rku95XdByUfe/v9pTP9ff5iTsk/OQn1JUwGYJ
 tXFF+a2wNJbj4CERSWZ1crKm3y3ywVXNB9lqBCoJeFC6zIVRd3V9eoU/aL1RvULWEi/p
 ZZ+YaxAFrelXns8BmyyLcC2+T7jm6pSbG0MXBeh2+eCNGGITGa3J9PuK7L5TdKrdoKkr vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfm0u90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 15:14:22 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11NK5qUh081860;
        Tue, 23 Feb 2021 15:14:21 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfm0u83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 15:14:21 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NKE4vY013242;
        Tue, 23 Feb 2021 20:14:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 36tt28shhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:14:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NKE3ci34013498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 20:14:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7599842041;
        Tue, 23 Feb 2021 20:14:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAD5D4203F;
        Tue, 23 Feb 2021 20:14:15 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Feb 2021 20:14:15 +0000 (GMT)
Message-ID: <72463e86ed993f8bf68db676e2c3f7fcd30a717c.camel@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next 2/7] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 23 Feb 2021 21:14:15 +0100
In-Reply-To: <CAEf4Bzav=QQwOfjQsosYWYt6YLXUV19Zswy2pddRDYgZEXCgbg@mail.gmail.com>
References: <20210222214917.83629-1-iii@linux.ibm.com>
         <20210222214917.83629-3-iii@linux.ibm.com>
         <CAEf4Bzav=QQwOfjQsosYWYt6YLXUV19Zswy2pddRDYgZEXCgbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102230169
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-02-22 at 23:03 -0800, Andrii Nakryiko wrote:
> On Mon, Feb 22, 2021 at 1:50 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > The logic follows that of BTF_KIND_INT most of the time. Sanitization
> > replaces BTF_KIND_FLOATs with BTF_KIND_CONSTs pointing to
> > equally-sized BTF_KIND_ARRAYs on older kernels, for example, the
> > following:
> > 
> >     [4] FLOAT 'float' size=4
> > 
> > becomes the following:
> > 
> >     [4] CONST '(anon)' type_id=10
> >     ...
> >     [8] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32
> > encoding=(none)
> >     [9] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8
> > encoding=(none)
> >     [10] ARRAY '(anon)' type_id=9 index_type_id=8 nr_elems=4
> > 
> 
> I liked Yonghong's initial suggestion to replace it with PTR to VOID.
> The only concern was that if this type was used from VAR, then
> sizeof(void *) != sizeof(float) on 64-bit architectures, which might
> theoretically mess up DATASEC layout. But is this a real concern? BPF
> programs don't really support floats, so there is no point in
> declaring float variables. I'd rather stick to a simple FLOAT -> PTR
> substitution than extend generated BTF.
> 
> Alternatively, was FLOAT -> anonymous empty STRUCT with desired size
> considered? Any problems with that?

An empty STRUCT is a really nice idea - it's future-proof and has much
smaller implementation than char[]. I'll go for it.

[...]

