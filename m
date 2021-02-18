Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB231EC8A
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBRQtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 11:49:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232577AbhBRN7C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 08:59:02 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IDiA9v003503;
        Thu, 18 Feb 2021 08:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0/4ToliqPPrSj7GVXh/1rpZkYwdYk2aE7Yzf5OsaAmg=;
 b=USa5hZ1SATAGONklDoMiIQoUDvqUn/O6jzbppmw/lySpvj3ZFfBpX3w1M4BUaqBVJIdj
 qjandOZR7uzR+A3D2mo0NeFa25zg/QjA9HTkcWFm7y+Pg5T+iE5VnE9P8LscQWnzLDWQ
 lOY0O3FCXDgkYzgr0rmfJqK0rMZ/+GynGa7Oi6tB71J/LtWf796qVNx08dfA0SCjRKKf
 dkKpQ3DLdFRIiZGf0K5VPFSSqw0dlbdKNA61mYEDqnOCTa9VT0rLsKbbwvDBe+6EWDPc
 HixcvNt35OfHujNkw9esdDUaCK2bpmXM4nYtL7GgWfAJxjn3h63ZVymIrobAqa5CRkd5 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36sschgee6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 08:57:58 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11IDiHIn003745;
        Thu, 18 Feb 2021 08:57:58 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36sschgecp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 08:57:57 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11IDvb0h022533;
        Thu, 18 Feb 2021 13:57:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36rw3u98vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 13:57:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IDvrEp32637326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 13:57:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF43A4060;
        Thu, 18 Feb 2021 13:57:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44412A4054;
        Thu, 18 Feb 2021 13:57:53 +0000 (GMT)
Received: from [9.171.64.123] (unknown [9.171.64.123])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 13:57:53 +0000 (GMT)
Message-ID: <91f2dfab7e124c5edef515b18af30aed111d2a0a.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 18 Feb 2021 14:57:52 +0100
In-Reply-To: <602dc2574df18_182c3208c0@john-XPS-13-9370.notmuch>
References: <20210216011216.3168-1-iii@linux.ibm.com>
         <20210216011216.3168-3-iii@linux.ibm.com>
         <602d83616c9f1_ddd2208dd@john-XPS-13-9370.notmuch>
         <602d86a63e754_fc54208eb@john-XPS-13-9370.notmuch>
         <fe6133e6e997b9eca7d9b3e0802642498812b3b5.camel@linux.ibm.com>
         <602dc2574df18_182c3208c0@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180115
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-17 at 17:26 -0800, John Fastabend wrote:
> Ilya Leoshkevich wrote:
> > On Wed, 2021-02-17 at 13:12 -0800, John Fastabend wrote:
> > > John Fastabend wrote:
> > > > Ilya Leoshkevich wrote:
> > > > > The logic follows that of BTF_KIND_INT most of the time.
> > > > > Sanitization
> > > > > replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on
> > > > > older
> > > >                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > Does this match the code though?
> > > > 
> > > > > kernels.
> > > > > 
> > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > ---
> > > > 
> > > > [...]
> > > > 
> > > > 
> > > > > @@ -2445,6 +2450,9 @@ static void
> > > > > bpf_object__sanitize_btf(struct
> > > > > bpf_object *obj, struct btf *btf)
> > > > >                 } else if (!has_func_global &&
> > > > > btf_is_func(t)) {
> > > > >                         /* replace BTF_FUNC_GLOBAL with
> > > > > BTF_FUNC_STATIC */
> > > > >                         t->info = BTF_INFO_ENC(BTF_KIND_FUNC,
> > > > > 0,
> > > > > 0);
> > > > > +               } else if (!has_float && btf_is_float(t)) {
> > > > > +                       /* replace FLOAT with INT */
> > > > > +                       t->info =
> > > > > BTF_INFO_ENC(BTF_KIND_FLOAT, 0,
> > > > > 0);
> > > > 
> > > > Do we also need to encode the vlen here?
> > > 
> > > Sorry typo on my side, 't->size = ?' is what I was trying to
> > > point
> > > out.
> > > Looks like its set in the other case where we replace VAR with
> > > INT.
> > 
> > The idea is to have the size of the INT equal to the size of the
> > FLOAT
> > that it replaces. I guess we can't do the same for VARs, because
> > they
> > don't have the size field, and if we don't have DATASECs, then we
> > can't
> > find the size of a VAR at all.
> > 
> 
> Right, but KINT_INT has some extra constraints that don't appear to
> be in
> place for KIND_FLOAT. For example meta_check includes max size check.
> We
> should check these when libbpf does conversion as well? Otherwise
> kernel
> is going to give us an error that will be a bit hard to understand.

Yeah, apparently floats can have non-power-of-2 sizes, which kills the
idea with such a replacement. Maybe we should do exactly the same thing
as we do for VARs after all.

> Also what I am I missing here. I use the writers to build a float,
> 
>  btf__add_float(btf, "new_float", 8);
> 
> This will create the btf_type struct approximately like this,
> 
>  btf_type t {
>    .name = name_off; // points at my name
>    .info = btf_type_info(BTF_KIND_FLOAT, 0, 0);
>    .size = 8
>  };
> 
> But if I create an int_type with btf__add_int(btf, "net_int", 8); I
> will
> get a btf_type + __u32. When we do the conversion how do we skip the 
> extra u32 setup?
> 
>  *(__u32 *)(t + 1) = (encoding << 24) | (byte_sz * 8);
> 
> Should we set this up on the conversion as well? Otherwise later
> steps
> might try to read the __u32 piece to find some arbitrary memory?

Ah, you are absolutely right. I was hoping that e.g. btf_get_raw_data()
would clean that up, but turns out it doesn't do that. Seems like I'll
have to implement this myself.

