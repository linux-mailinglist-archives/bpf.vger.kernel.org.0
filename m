Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B2825B5C4
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgIBVRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 17:17:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBVRQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 17:17:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082LDcYB038068;
        Wed, 2 Sep 2020 21:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=BV1HZq00dKXMzfyo3bfxru+4RrdF6fbWJfEcdUF7Um8=;
 b=bVhggRBmZFdJsFk0xvWMKx8m4pAN5dTX6+JSUtWA69CbFyphTUiwtKs7ygha9k/CVO2U
 pUpDh5SOILtRH0aKuQeyAMl7LBO4/Hvw8J1w/aEF/DzRvGOtKZ97GiwXuC09AG4Mvjz+
 AjiCxxQPmtIfdP0gu/mWr0UQvezFrio9htg4X0QE5Jtl1cr754mZWcXvTuNxUuaeKbKY
 9JhfO2RoBNXVXEphGswmz7zq3QJnNh1X+Rhf/WWYxl9z8vtnzBuioO6nZoh3Bw38M05Q
 sdfUJfFehUBOiMWQaiTh2KrqehzPjczry/UO6PT9bqEJlf1LCyNfA/Wiag/ECE32Jeve Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 339dmn3qtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 21:17:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082LFNW7110656;
        Wed, 2 Sep 2020 21:17:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3380kqp812-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 21:17:11 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082LHAkZ025417;
        Wed, 2 Sep 2020 21:17:10 GMT
Received: from termi.oracle.com (/10.175.48.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 14:17:09 -0700
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: EF_BPF_GNU_XBPF
References: <87mu282gay.fsf@oracle.com>
        <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
        <87y2ls0w41.fsf@oracle.com>
        <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
Date:   Wed, 02 Sep 2020 23:17:05 +0200
In-Reply-To: <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Wed, 2 Sep 2020 13:32:06 -0700")
Message-ID: <87o8mn281a.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=873 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020199
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=863 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020199
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> As such, the property of being verifiable is irrelevant.
>
> No. It's a fundamental property of BPF.
> If it's not verifiable it's not BPF.

Sure.

> It's not xBPF either.

Heh, beg to differ :)

> Please call it something else and don't confuse people that your ISA
> has any overlap with BPF. It doesn't. It's not verifiable.

Nonsense.  xBPF has as much overlap with BPF as it can have: around 99%.

The purpose of having the e_flag is to avoid confusion, not to increase
it.  xBPF objects are mainly used to test the GCC BPF backend (and other
purposes we have in mind, like ease the debugging of BPF programs) but
we want to eliminate the chance of these objects to be confused with
legit BPF files, and used as such.
