Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73BF2C0B75
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgKWNZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 08:25:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55094 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730533AbgKWNY7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 08:24:59 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AND76aI034959;
        Mon, 23 Nov 2020 08:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SF2O5ZXVTST15P2rDMbKpT5pSzhsEEPZsi5upw+5tz8=;
 b=PEMDBFWHjGZ0tz6Xx4aKRQ1C8lU+bjlLYYUUZGRhga9/OYbKePR3B202Aj6PDf5LJALO
 vwcZBF1hbzRajhGss6LZpETscPUwE2MalYXWVv9G1tHS2/8O1xkc5k+TypmtD8Syxl1i
 PgNHXFVrpfh5Dl634ARKM6wtrr1zoTtg0mKexj9EOBvX9727yIGHbiuguUOdtsWU22Sq
 bRFUoX0k2wSXPjXHdZ9H96qhI/V5h4gkJUC38upK9VE/2FdFOOh3pNPiNxXM4uy4YXi6
 gcD6z6pRUi5jBnNe3eS3thsbrnwKgZg/2vGIfiMS/fPHIiIlRfUGBynaezCAlR7zeHEt mg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34xyrvj5eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 08:24:42 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ANDMBlj013395;
        Mon, 23 Nov 2020 13:24:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 34xth8jfuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 13:24:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ANDOcqW8061484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 13:24:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2085CA404D;
        Mon, 23 Nov 2020 13:24:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13057A4055;
        Mon, 23 Nov 2020 13:24:36 +0000 (GMT)
Received: from sig-9-65-241-175.ibm.com (unknown [9.65.241.175])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Nov 2020 13:24:35 +0000 (GMT)
Message-ID: <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for
 bpf_ima_inode_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Date:   Mon, 23 Nov 2020 08:24:35 -0500
In-Reply-To: <20201121005054.3467947-3-kpsingh@chromium.org>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
         <20201121005054.3467947-3-kpsingh@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_09:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=3 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230086
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 2020-11-21 at 00:50 +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> - Update the IMA policy before executing the test binary (this is not an
>   override of the policy, just an append that ensures that hashes are
>   calculated on executions).

Assuming the builtin policy has been replaced with a custom policy and
CONFIG_IMA_WRITE_POLICY is enabled, then yes the rule is appended.   If
a custom policy has not yet been loaded, loading this rule becomes the
defacto custom policy.

Even if a custom policy has been loaded, potentially additional
measurements unrelated to this test would be included the measurement
list.  One way of limiting a rule to a specific test is by loopback
mounting a file system and defining a policy rule based on the loopback
mount unique uuid.
 
Mimi

