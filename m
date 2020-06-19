Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567612002D0
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgFSHhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 03:37:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45532 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgFSHhN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 03:37:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05J7VuPA176358;
        Fri, 19 Jun 2020 07:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=m+EHErVvrcxcxKHg2miZcNCKeclnrQxI8bB/G5gYbSg=;
 b=pCz6+4bBtN7Hq4J4tPtqY6RNzsdK6HrofNqiBhmryptCtD2ZzrbLd/xLKCF2PrBKAj8A
 qrIxr/KKkm0VwbUCnKmCR0+0Mfiq3CZ08KhMINXuHhf3MXssBqudypmeskQ0i2J4JTzY
 oaN9CJM3/eJZhIGUgFW2y+PcuHa3BWXTOPPEILd0s0SzZm5AN3EIDRtzvgcPyxrp4XUU
 duhaHtOE/Es8w6NjSUuv1k3MwG8aong4L9GMk18TFliqxZczGXyepW2ymOwwMTF552bC
 152TGR11nVwIB6QH60V+R4zkZjVhsAzt0Q7OqphyYP1Yz84KnoQcjR8PDcQHqz09Y8qD 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31q66057y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 07:37:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05J7WXuo001895;
        Fri, 19 Jun 2020 07:37:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31q66cgfe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 07:37:09 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05J7b8qS020718;
        Fri, 19 Jun 2020 07:37:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jun 2020 00:37:08 -0700
Date:   Fri, 19 Jun 2020 10:37:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>, bpf <bpf@vger.kernel.org>
Subject: Re: [bug report] seccomp: Add find_notification helper
Message-ID: <20200619073702.GT4282@kadam>
References: <20200618142714.GA202183@mwanda>
 <CAGXu5jJVxSQnqxTsguKFv_rX1vW87jSMeU9HDue-97qYYK82qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJVxSQnqxTsguKFv_rX1vW87jSMeU9HDue-97qYYK82qw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190053
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 02:01:06PM -0700, Kees Cook wrote:
> On Thu, Jun 18, 2020 at 7:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > [ Kees, why am I getting tons and tons of these warnings?  Are we not
> >   going to initialize things manually any more? ]
> 
> We are, yes. This is "just" a bug.

GCC has been spotty for some years because of the optimization bug, but
it really feels like something changed recent and I'm getting lots more
warnings now.

regards,
dan carpenter
