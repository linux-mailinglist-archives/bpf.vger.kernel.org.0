Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F62327181
	for <lists+bpf@lfdr.de>; Sun, 28 Feb 2021 09:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhB1IDh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 03:03:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230061AbhB1IDf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Feb 2021 03:03:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11S7WqsL097964;
        Sun, 28 Feb 2021 03:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=b+ofGeaIBClioWcqrqu1dAPB3Uo2dw7VSbprurAfjzY=;
 b=HHaR/6gKXZiPzvMm6u4vHSpd06AeotkTKE8lcktqj/t2L96hp8+5uIEwCh2WkFeexM6U
 zefQ6SMnR/LWLesz7GJnrXAgOOGTJLvhcYkU2eTRbk4PNDV4Os83U8OOVlEQTL0E8E3e
 yszB/7OkugMy5J9IYIPs4lRo6DoWSd85v5T+5s5h59wUlThk53mrO49QjY1oPE886h2C
 DTsZcKbz6e/wzJW3tDaCMJZj1LOahmf1n8NXXOS4dgwVSBCilY7x2nx5jKjoSoA5qB4K
 50Pmhk4PGii4OBBtYd75WVtYh1ZZd64eOiM8o5zTcapvA9e22bX/tgMtDEXWaB+PsCc9 4A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37041fukmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 03:02:39 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11S7xBLl019065;
        Sun, 28 Feb 2021 08:02:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 36ydbgrtxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 08:02:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11S82YhI27197726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Feb 2021 08:02:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5B74A404D;
        Sun, 28 Feb 2021 08:02:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B2C0A4053;
        Sun, 28 Feb 2021 08:02:34 +0000 (GMT)
Received: from osiris (unknown [9.171.48.61])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 28 Feb 2021 08:02:34 +0000 (GMT)
Date:   Sun, 28 Feb 2021 09:02:32 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Use the last page in
 test_snprintf_btf on s390
Message-ID: <YDtOGOktRc/QZIDF@osiris>
References: <20210226190908.115706-1-iii@linux.ibm.com>
 <21c13c15-0dbc-8430-9e04-0932f6f913f0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c13c15-0dbc-8430-9e04-0932f6f913f0@fb.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_03:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=776 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102280061
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 07:47:02PM -0800, Yonghong Song wrote:
> > test_snprintf_btf fails on s390, because NULL points to a readable
> > struct lowcore there. Fix by using the last page instead.
> > 
> > Error message example:
> > 
> >      printing 0000000000000000 should generate error, got (361)
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > v2 -> v3: Heiko mentioned that using _REGION1_SIZE is not future-proof.
> >            We had a private discussion and came to the conclusion that
> >            the the last page is good enough.
> 
> Heiko, could you ack the patch if it is okay? Thanks!

Yes, sure.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
