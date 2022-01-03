Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEBF482E34
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 06:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiACFhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 00:37:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229527AbiACFhh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Jan 2022 00:37:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2035Tjut025490;
        Mon, 3 Jan 2022 05:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eD1yTFf8k2rIOKtFQJVl8Xyy58Rf1sGyUKokioFi59o=;
 b=TX1Ij46BsD5qYpvOr84gAoeKKJJxqklKebIFNYA2iF9/cfH2+PAzV9bR4yA1bhPBpEmB
 7yxjQJAtHlb7r8QPMY28PkmTdsVrnY/yNilTnGwEX0hSIuwf+88ZhxQq9hCndlTnBSd6
 nB59kT9EDgJ+QNMQJknK/z98Zdoki7y6OMsFZCw+f/22feiyYeAXkyWNbU7FIvlQMnTN
 Po617MDwhJ9CpLvPpsvJGpfXfkZCUABpIp5gHGUxBF4N5hIyrQWUNzkbhiDXAvIiAJev
 Zuaf48nPMdjlotPftVKof+cx7ZRBZ1U7OPQPnCz9ceh3RuZu9eafIfOHFzwkVWq6DwdV Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dbnypuy12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 05:37:09 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2035b8kg001556;
        Mon, 3 Jan 2022 05:37:08 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dbnypuy0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 05:37:08 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2035YMv6006991;
        Mon, 3 Jan 2022 05:37:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3daek9qckf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 05:37:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2035b4pv45023704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jan 2022 05:37:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D2FBA4053;
        Mon,  3 Jan 2022 05:37:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 087A0A4055;
        Mon,  3 Jan 2022 05:37:04 +0000 (GMT)
Received: from localhost (unknown [9.43.39.36])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jan 2022 05:37:03 +0000 (GMT)
Date:   Mon, 03 Jan 2022 11:07:02 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [BUG] powerpc: test_progs -t for_each faults kernel
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, haliu@redhat.com,
        Jiri Olsa <jolsa@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Yonghong Song <yhs@fb.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>
References: <YdIiK8/krc5x5BmM@krava>
In-Reply-To: <YdIiK8/krc5x5BmM@krava>
User-Agent: astroid/v0.16-1-g4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1641188093.6jujx0dvg7.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SlaWglj5Y7g30ROlv_ldddmGQNu-QiT4
X-Proofpoint-ORIG-GUID: aCz3mcRHhBVCOxVdo_EXr3bgik-fPbyQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_02,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=590 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201030036
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri,

Jiri Olsa wrote:
> hi,
> when running 'test_progs -t for_each' on powerpc we are getting
> the fault below

This looks to be the same issue reported by Yauheni:
http://lkml.kernel.org/r/xunylf0o872l.fsf@redhat.com

Can you please check if the patch I posted there fixes it for you?


Thanks,
Naveen
