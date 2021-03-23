Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0C345FCB
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhCWNhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 09:37:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231630AbhCWNhK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 09:37:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NDXpMb103740;
        Tue, 23 Mar 2021 09:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2nCsYZl6MwFH575/1enaeYLLx6w+XoCcdYARCfc7zXE=;
 b=c/owor4YoboOSDpCIO3xWXCepEXQtT/zb2Q3iIigTdu+GZQ0xwtLTFjdRvIKikUZkDmC
 gX3Qvwzp4ZyqehHDO3ocTmLm/Za+aG8c/UaA3CLHqB89gak8OJTuIbuWk1AoESwh6jmq
 uU71dUhAxornMBY1U2nI7JHCh5RrodZZBtRV0Szlh5Qzc0GkNP1q5eDL4RBXc6o/u964
 duxIt/WEbMKp0bhwKtAmKalr8GOErs63A5v3n6wkbjBWrLJDTfq6vUKgZkR5mvqMj4m/
 F9P+Qjs7lMS0V1KPnshkvtGiI7U5KF3INdxTaV33YdcoigE7PiYWBC6w6rRHj0MeDqgP Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dx4b249w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 09:36:54 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NDXquX103751;
        Tue, 23 Mar 2021 09:36:54 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dx4b248j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 09:36:54 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NDWpF5010711;
        Tue, 23 Mar 2021 13:36:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 37d9a6hred-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 13:36:51 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NDaVG034865648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 13:36:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C66D95205A;
        Tue, 23 Mar 2021 13:36:48 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 54F5D52059;
        Tue, 23 Mar 2021 13:36:48 +0000 (GMT)
Message-ID: <41d244ba53881fa99dda3d0a65c4a8cfb557a755.camel@linux.ibm.com>
Subject: Re: [PATCH PING dwarves] btf: Add --btf_gen_all flag
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Tue, 23 Mar 2021 14:36:48 +0100
In-Reply-To: <YEtvIvODFEQHgt8m@kernel.org>
References: <20210312000808.175262-1-iii@linux.ibm.com>
         <YEtvIvODFEQHgt8m@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230100
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2021-03-12 at 10:39 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 12, 2021 at 01:08:08AM +0100, Ilya Leoshkevich escreveu:
> > By default, pahole makes use only of BTF features introduced with
> > kernel v5.2. Features that are added later need to be turned on with
> > explicit feature flags, such as --btf_gen_floats. According to [1],
> > this will hinder the people who generate BTF for kernels externally
> > (e.g. for old kernels to support BPF CO-RE).
> > 
> > Introduce --btf_gen_all that allows using all BTF features supported
> > by pahole.
> > 
> > [1] 
> > https://lore.kernel.org/dwarves/CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com/
> 
> Applied locally, testing ongoing.
> 
> Also added this:
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> 
> - Arnaldo

[...]

Hi Arnaldo,

I'd like to ping this patch (and
https://lore.kernel.org/dwarves/20210310201550.170599-1-iii@linux.ibm.com/
too).

Best regards,
Ilya
> 

