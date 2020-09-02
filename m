Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62925B3A1
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBSUh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 14:20:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 14:20:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082I9lux094988
        for <bpf@vger.kernel.org>; Wed, 2 Sep 2020 18:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=t2HauPsAi2LB5guAGdn+B6acP0GyQJnkFBmZJ+knHuI=;
 b=y3UxkmlXDfexbLtuMW2YEKtWmXVEaofajQ8W2Vy4Q3iAB0M2x0LpSrlr3VMYtc6WGvIk
 15beY3HbX18raJliCs8LOOD3881cm1QsQRANy0fGX9piP1BYiffjxnDPlRQRAg6DCjWA
 Jm6d37N50C/YQFWoQkVNpTuRvI4sjXYKMTKTOAEoK3E/lPmwN2Jg+QUGEV/NPVomdfeo
 3sxCz+ToM+v5f1wF1UD00WO0p+yQm2/ngsfs+yoLrgLUTZD0vVIT3iIjFGmO9rPdsW5E
 Eve18ri4pACEa6ZTGo0SJp9JrYxMO6r9xNw/rxnR0roglsNN4Rar4DVfc2llF5H7rMPY 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmn2v52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 18:20:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082I9koa040325
        for <bpf@vger.kernel.org>; Wed, 2 Sep 2020 18:18:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3380y066b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 18:18:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082IIXWS006570
        for <bpf@vger.kernel.org>; Wed, 2 Sep 2020 18:18:33 GMT
Received: from termi.oracle.com (/10.175.48.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 11:18:32 -0700
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf@vger.kernel.org
Subject: EF_BPF_GNU_XBPF
Date:   Wed, 02 Sep 2020 20:18:29 +0200
Message-ID: <87mu282gay.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=829 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=831 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020171
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hello BPF people!

In order to ease the testing of the GCC bpf port we are adding a number
of extensions to the BPF ISA.

We would like to use one bit in the e_flags field of the ELF header in
order to flag that the code in the ELF file is not plain eBPF:

For EM_BPF:

#define EF_BPF_GNU_XBPF 0x00000001

Any objection?
Salud!
