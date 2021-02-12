Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6473198EF
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 04:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLDww (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 22:52:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229469AbhBLDww (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Feb 2021 22:52:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11C3i2xc059940;
        Thu, 11 Feb 2021 22:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EKA5okDyOxyrK9WwZGtSDwUnxhDk7rE2UIQBEIBEhic=;
 b=d9Gw0GVYvJXQenQtjV4lQePO4RXJSCmyt4vESPeKcoUbgkFBCs5OV37hPUi+WCoEbr7g
 IJFoxW6ae74NMRJxkOKisxKwLZIUMt1eiqFEIHE4KZkWsH0+rNAQDFfcyUneNFtZfgTD
 qej/zvqB+vFfMp4m0nOfVwrsoLEt9XZG0C6A8iMhMUxWMbxFTfT+DiApoZ+vqErB6i1n
 ZULtbRAhiQkUKVaAdWuVer41yOot+PzJ1g+aTTmxLdyqjP/CQjqCOLpjqIa3cZwInlg1
 qbs/vkrdCJqHeEkHDYVrwvUi3mqWj5apc2yVmfLECCj24InH7HaqRvOPEBXXZpekgIbg 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nj1cg3qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 22:51:58 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11C3k8Go063404;
        Thu, 11 Feb 2021 22:51:58 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nj1cg3qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 22:51:58 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11C3n1RF024894;
        Fri, 12 Feb 2021 03:51:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 36hjr8eb34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 03:51:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11C3ps7838732178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 03:51:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF1B052057;
        Fri, 12 Feb 2021 03:51:54 +0000 (GMT)
Received: from [9.171.67.27] (unknown [9.171.67.27])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6600352052;
        Fri, 12 Feb 2021 03:51:54 +0000 (GMT)
Message-ID: <1056088b4184aae21794918c3db102942bb86546.camel@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Optimize program stats
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Date:   Fri, 12 Feb 2021 04:51:54 +0100
In-Reply-To: <CAADnVQKkc4dYCCNV=X4FNfRteoMXGHno4cMExab54cNGgVJ6AQ@mail.gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
         <20210210033634.62081-2-alexei.starovoitov@gmail.com>
         <1e54f82603c361e7ee1464621a9937c1efb3b254.camel@linux.ibm.com>
         <CAADnVQKkc4dYCCNV=X4FNfRteoMXGHno4cMExab54cNGgVJ6AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=879
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120026
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2021-02-11 at 19:43 -0800, Alexei Starovoitov wrote:
> On Thu, Feb 11, 2021 at 7:26 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > mm/percpu.c:2089
> > #5  0x00000000002ef738 in __bpf_prog_free (fp=0x380001ce000) at
> > kernel/bpf/core.c:262
> > #6  bpf_prog_realloc (fp_old=fp_old@entry=0x380001ce000,
> > size=249856,
> > 
> > So we end up with objcg=NULL, but I'm not sure why this happens.
> > Please let me know if you need more info.
> 
> Argh. Thanks for reporting!
> Pushed the obvious fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=1336c662474edec3966c96c8de026f794d16b804
> Pls pull bpf-next and give it a spin.

Works now, thanks for the very quick fix!

