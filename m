Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C24A8196
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 10:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349763AbiBCJkf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 04:40:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349775AbiBCJke (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 04:40:34 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2137cbpm020734;
        Thu, 3 Feb 2022 09:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Dc6m8Gh9sB7+I4zgqj7gTDxtDjjJH3pLbvA5sWbmhTc=;
 b=HI7n2wV2b0yDnpzHimeQDpWTQ7S8Q1XH2e5TFhq7E/FYVEP1uD3SZoKPMaCOMhzOwFh6
 hBR+2oqCdKONV942XvVUnwGZ89QvbcL/h2xCfhrC5fJIKTHWpMd/q0PA6+5C0/oAHBQb
 ht+Swvz5S9ebDXT2rm0Sb66OzhYOIN0MAcqYHHSw6cRFcuPNLFSS9yQLKdMrHxCbFK90
 wauDcaIdWX1a7vnCdyrcxz8EPPZePaVw2KxmT73HmHuIxeAgLaCvzteNIYFgZ98o9rUp
 pBTyVoZu21LvouTsmUy5fu9NYsRpPchpz9z+bh9p8ag4jeEJogYUR5wzfEeWO9KZGztT ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e01qhbeck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 09:40:21 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2139V1M8020856;
        Thu, 3 Feb 2022 09:40:21 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e01qhbec2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 09:40:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2139ZOmY003479;
        Thu, 3 Feb 2022 09:40:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3dvvujjmky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 09:40:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2139eFGk43123142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 09:40:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5664DAE058;
        Thu,  3 Feb 2022 09:40:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB568AE045;
        Thu,  3 Feb 2022 09:40:14 +0000 (GMT)
Received: from osiris (unknown [9.145.47.175])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Feb 2022 09:40:14 +0000 (GMT)
Date:   Thu, 3 Feb 2022 10:40:13 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
Message-ID: <Yfui/cdknJYeiFVg@osiris>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
 <20220201234200.1836443-2-iii@linux.ibm.com>
 <your-ad-here.call-01643811544-ext-7630@work.hours>
 <011a6988-39a6-66ca-fccd-6fa0852ed599@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011a6988-39a6-66ca-fccd-6fa0852ed599@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ncHIsqDUWvBs42gvuk_QnyCe1rpQPva3
X-Proofpoint-GUID: POTOvq_Al2ikh8pWLyi9Wn3f9h99UOyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_02,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=733
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030059
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 02, 2022 at 06:23:46PM +0100, Christian Borntraeger wrote:
> Am 02.02.22 um 15:19 schrieb Vasily Gorbik:
> > > diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
> > > index ad64d673b5e6..b3dec603f507 100644
> > > --- a/arch/s390/include/uapi/asm/ptrace.h
> > > +++ b/arch/s390/include/uapi/asm/ptrace.h
> > > @@ -295,6 +295,7 @@ typedef struct {
> > >   	unsigned long args[1];
> > >   	psw_t psw;
> > >   	unsigned long gprs[NUM_GPRS];
> > > +	unsigned long orig_gpr2;
> > >   } user_pt_regs;
> > 
> > It could be a good opportunity to get rid of that "args[1]" which is not
> > used for syscall parameters handling since commit baa071588c3f ("[S390]
> > cleanup system call parameter setup") [v2.6.37], as well as completely
> > unused now, and shouldn't really be exported to eBPF. And luckily eBPF
> > never used it.
> > 
> > So, how about reusing "args[1]" slot for orig_gpr2 instead?
> 
> Since this is uapi we certainly have to careful. Reusing this could be ok, though.

I agree with Vasily: let's get rid of "args[1]", rename it to orig_gpr2,
and effectively move orig_gpr2 to user_pt_regs, while at the same time
reducing the size of struct pt_regs a bit.

This will also prevent future random usages of the args member; e.g. until
recently it was used to pass the last breaking event address to the
exception handler. However that usage has also been removed already.

Ilya, could you resend with this proposed change, please?
