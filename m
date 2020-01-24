Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E289E148C74
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbgAXQp0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 11:45:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46834 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390424AbgAXQpZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 11:45:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OGhdOe163796;
        Fri, 24 Jan 2020 16:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ax2b7VbroDAFXGhWoaT8oid295EG/aT8E5ybilKIp/8=;
 b=CN94oT93dmhc59Evrew/6dj3KVkcSKW1kn1ZvYwtt43WNbD+VI5MjX6T4CZT7ftmrbvh
 Q4fxTieCq3Og6dbIv8Wg9RbW+aOdYg+8GljZKz8G3rFHJLktSHPCvk45bWzrFVZJlUVc
 phZikyy4/F7ZtjOGfcYiOnjr+EImiYPLDZUSupjSsWaHqCt/LIIo7IfonjQAbDS1Axs9
 fbWaaRRdKqkHCxwerYXHFBMx/wUVzbIAENpu4UhWK83/4Q8SlouEXgMeG98PF/9Lh3Ic
 9XKNG2dH/jr7nadHTuDvckoTx+tPqm6SEHyvlwVU0pBofGnvzu5ixATxUyQe8ipHV+kx qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyqt3hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 16:44:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OGi8rW142590;
        Fri, 24 Jan 2020 16:44:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xqmufc49n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 16:44:43 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00OGif1t004136;
        Fri, 24 Jan 2020 16:44:41 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 08:44:40 -0800
Date:   Fri, 24 Jan 2020 19:44:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-janitors@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
        Alex Dewar <alex.dewar@gmx.co.uk>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] um: Fix some error handling in uml_vector_user_bpf()
Message-ID: <20200124164427.GF1870@kadam>
References: <20200124101450.jxfzsh6sz7v324hv@kili.mountain>
 <36070c96-8e75-7d06-d945-87a9d366d0b9@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36070c96-8e75-7d06-d945-87a9d366d0b9@cambridgegreys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240137
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 24, 2020 at 12:52:18PM +0000, Anton Ivanov wrote:
> 
> 
> On 24/01/2020 10:14, Dan Carpenter wrote:
> > 1) The uml_vector_user_bpf() returns pointers so it should return NULL
> >     instead of false.
> > 2) If the "bpf_prog" allocation failed, it would have eventually lead to
> >     a crash.  We can't succeed after the error happens so it should just
> >     return.
> > 
> > Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   arch/um/drivers/vector_user.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> > index ddcd917be0af..88483f5b034c 100644
> > --- a/arch/um/drivers/vector_user.c
> > +++ b/arch/um/drivers/vector_user.c
> > @@ -732,13 +732,13 @@ void *uml_vector_user_bpf(char *filename)
> >   	if (stat(filename, &statbuf) < 0) {
> >   		printk(KERN_ERR "Error %d reading bpf file", -errno);
> > -		return false;
> > +		return NULL;
> 
> I will sort this one out, thanks for noticing.
> 
> >   	}
> >   	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
> > -	if (bpf_prog != NULL) {
> > -		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
> > -		bpf_prog->filter = NULL;
> > -	}
> > +	if (!pfg_prog)
> 
> ^^^^^ ?

If we don't return here it leads to a NULL dereference.

regards,
dan carpenter

