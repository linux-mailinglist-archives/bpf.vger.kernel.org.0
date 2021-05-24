Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF038E355
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhEXJ3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 05:29:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232426AbhEXJ3J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 05:29:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14O94Gkb185686;
        Mon, 24 May 2021 05:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=/2eWibBSN0HVY3hGtUv/h4+T845xdYDo1OpxNXYB9jE=;
 b=IiHkvO4WNWyLedq1KTdl8/OUhYdKiOwd1WGWxNCiiPmERE4EHDR6fWRLABE4dn9NjOuq
 kB7XbSM6fM6VnmBqT9AbCg7W6LgfqGfy4pvOWVYTif1sd7uk+UmY+IKtoEMThY2OXKH/
 8/tdCOyGZrFi2z6y3Ts67AeFbPhchwZOax1yUdzCcQUyPe+KezwA4jvCL3t8dF5iND3J
 hWetlJmY9F5vdky8Rl+KeqmF6KHuLsPDzj6+qmwn//oJ1xDbhc2QhRjfVerJ+zLvOTfS
 igSHglxIqJTdkkQPS7VqX4cdh7HbzD6sV35//6/BdM80zZ3ZiQOQisxBEVqaCTh7ntYl OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38r8rm96au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 05:26:58 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14O9Q59o079191;
        Mon, 24 May 2021 05:26:58 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38r8rm969w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 05:26:57 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14O9QtlP017120;
        Mon, 24 May 2021 09:26:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 38ps7h8cug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 09:26:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14O9QrR017629654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 09:26:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E94DAE053;
        Mon, 24 May 2021 09:26:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C6E7AE045;
        Mon, 24 May 2021 09:26:52 +0000 (GMT)
Received: from localhost (unknown [9.85.75.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 May 2021 09:26:52 +0000 (GMT)
Date:   Mon, 24 May 2021 14:56:50 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v2 02/10] kprobes: treewide: Replace
 arch_deref_entry_point() with dereference_function_descriptor()
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     ast@kernel.org, bpf@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, kernel-team@fb.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, X86 ML <x86@kernel.org>, yhs@fb.com
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
        <161553132545.1038734.15042495470069054830.stgit@devnote2>
In-Reply-To: <161553132545.1038734.15042495470069054830.stgit@devnote2>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1621848345.yvip3z0wyn.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -atXjk7rEXZqyrfpvPGc-QzgnH2q2iig
X-Proofpoint-ORIG-GUID: uXngcU3uWZYd7DQrFBISvBNV6OWz1axa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_05:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=863 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240069
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Masami Hiramatsu wrote:
> Replace arch_deref_entry_point() with dereference_function_descriptor()
> because those are doing same thing.

It's not quite the same -- you need dereference_symbol_descriptor().


- Naveen

