Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B403346A7E
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 21:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhCWUyw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 16:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232529AbhCWUyX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 16:54:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NKXIju142178;
        Tue, 23 Mar 2021 16:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SOEqAZp+3fcJccg3kJnCN/LP4wqUy7k5JxCDZZU/hnQ=;
 b=KdKVxxOAF3qjH81L2Qo6rn+u3PGIB7IE7762jsWQtPI1rnAADuTGeU4nr8/PcffEXf5o
 E0brW4sl0WJ4OA6JaWnZzuTem/xhYw8+hfvm65KnffmWxhGwOMrZWesmsSoS3wQT9hEv
 bAzN+9in6YqKBIz3yu0WNysOk9x2/WdQ0q1BuUrL2/epYWkE6BroplPBUUvnIJlhH1T6
 mmrs7WfMSHsWoVU8oKh2o4AcieeFbQcs2FaBmz5rtk0OTZFM5VNIQZxHji1ES+zSrk1j
 DUMipVe80JCQLQNUntDLl1ufOM8Zx5oblaqJ8L5J5Gx1fywXXcgUR7pHarpAaIHv7EUE sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fpumsc2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 16:54:08 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NKYRFj151477;
        Tue, 23 Mar 2021 16:54:08 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fpumsc1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 16:54:08 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NKs6Ga006400;
        Tue, 23 Mar 2021 20:54:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37d9bmkpt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 20:54:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NKrjWk36962710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 20:53:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BB1DAE051;
        Tue, 23 Mar 2021 20:54:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E475AE045;
        Tue, 23 Mar 2021 20:54:03 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 20:54:03 +0000 (GMT)
Message-ID: <ff65b4733191b836e9738256178434b89a526767.camel@linux.ibm.com>
Subject: Re: [PATCH PING dwarves] btf: Add --btf_gen_all flag
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 23 Mar 2021 21:54:02 +0100
In-Reply-To: <YFox4XQ611jHo7Wj@kernel.org>
References: <20210312000808.175262-1-iii@linux.ibm.com>
         <YEtvIvODFEQHgt8m@kernel.org>
         <41d244ba53881fa99dda3d0a65c4a8cfb557a755.camel@linux.ibm.com>
         <YFouW2D2Y1XpcjKA@kernel.org> <YFox4XQ611jHo7Wj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_09:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230152
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-03-23 at 15:22 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 23, 2021 at 03:07:23PM -0300, Arnaldo Carvalho de Melo
> escreveu:
> > Em Tue, Mar 23, 2021 at 02:36:48PM +0100, Ilya Leoshkevich
> > escreveu:
> > > On Fri, 2021-03-12 at 10:39 -0300, Arnaldo Carvalho de Melo
> > > wrote:
> > > > Em Fri, Mar 12, 2021 at 01:08:08AM +0100, Ilya Leoshkevich
> > > > escreveu:
> > > > > By default, pahole makes use only of BTF features introduced
> > > > > with
> > > > > kernel v5.2. Features that are added later need to be turned
> > > > > on with
> > > > > explicit feature flags, such as --btf_gen_floats. According
> > > > > to [1],
> > > > > this will hinder the people who generate BTF for kernels
> > > > > externally
> > > > > (e.g. for old kernels to support BPF CO-RE).
> > > > > 
> > > > > Introduce --btf_gen_all that allows using all BTF features
> > > > > supported
> > > > > by pahole.
> > > > > 
> > > > > [1] 
> > > > > https://lore.kernel.org/dwarves/CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com/
> > > > 
> > > > Applied locally, testing ongoing.
> > > > 
> > > > Also added this:
> > > > 
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > 
> > > > - Arnaldo
> > > 
> > > [...]
> > > 
> > > Hi Arnaldo,
> > > 
> > > I'd like to ping this patch (and
> > > https://lore.kernel.org/dwarves/20210310201550.170599-1-iii@linux.ibm.com/
> > > too).
> > 
> > So I finally finished testing, pushing out now.
> 
> Please check what is in
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/, I'm having
> some
> problems with 2FA on github, will fix soon.
> 
> - Arnaldo

That looks good, thanks!

s390 seems to run fine again with the latest bpf-next / llvm / pahole.
Now I can finally give adding s390 to the libbpf CI another try :-)

