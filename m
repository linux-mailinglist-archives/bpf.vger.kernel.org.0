Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE6EDC5A
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2019 11:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKDKVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Nov 2019 05:21:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59470 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDKVo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Nov 2019 05:21:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4A89KP154426;
        Mon, 4 Nov 2019 10:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=HhlZPJXEwbAOsmaU0YyhVSI5tsiYMX2rE1wf8OBs0dY=;
 b=eHI83e+rnN2SV9Fi/7MjhGz1LV2L6fVfhrYGWMDPGNUjYqut1fgFe7v9GwbB2CHl19MO
 rE1UPRoU34dMxMLFrj4OSQL9jrnOuPltUKy7/hbYhmrPILw9zkGdQ4lepoOddNqJHfUs
 hBtimhtBbtqvWqzgaBzouQVSu5Rs/c03NMzBNxh9/TvnMiWlyRJ7X8Pufya437UIlCGo
 QpD/xwt5fGTGSWlV+5Pu4FWbhfQU20tYUu3ocwot3PonAPnEZrPfEcJPVSaa+uV0iio8
 KF0SJCmVeWAv/epDqzsVq5//gh1o3R0BikpQB+CKW/cPgTK0G8bdCKWObVcv4qnJeNlW JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w12eqx4r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:21:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4A7StD128539;
        Mon, 4 Nov 2019 10:21:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w1kaadftc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:21:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4ALePI010595;
        Mon, 4 Nov 2019 10:21:40 GMT
Received: from termi.oracle.com (/10.175.62.217)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 02:21:39 -0800
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Yonghong Song <yhs@fb.com>
Cc:     "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: initiated discussion to support attribute address_space in clang
References: <87lfutgvsu.fsf@oracle.com>
        <79a43f7f-b463-5f40-7830-f488d178b0a4@fb.com>
Date:   Mon, 04 Nov 2019 11:21:34 +0100
In-Reply-To: <79a43f7f-b463-5f40-7830-f488d178b0a4@fb.com> (Yonghong Song's
        message of "Thu, 24 Oct 2019 16:56:06 +0000")
Message-ID: <87tv7kyma9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040101
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Yonghong.
    
    I just initiated a discussion (RFC patch 
    https://reviews.llvm.org/D69393) for llvm/clang to support user 
    address_space attribute.
    
    I am not able to add your name in subscriber list as you probably
    not registered with llvm mailing list or phabricator.
    
    Just let you know so we can have an eventual proposal which
    will be also good for gcc. Please participate in discussion.

Thanks for reaching out, and sorry for the delay in replying: I needed
some time to process my backlog after a couple of weeks off.

I just created an account in phabricator (jemarch).  Will follow up
there.

Salud!
