Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B5D1493BC
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2020 07:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAYGDB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 01:03:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47052 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAYGDB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 01:03:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P5sFnr124388;
        Sat, 25 Jan 2020 06:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=EOcwFu66kTrDrBW6PWLJLjzwfW3ca+7Yo6tsUOyd08A=;
 b=mZCmBsZcbtizRKb0yYxH/c2TRuaACugA1xrKvhG0TfLJkljJzmuNQlZctJPm3X2tJKtY
 P7oq7VaRHAKuX0g7UJRkIZ2fEA5w+H5t+fA5C1xjfXG0MI/A1drGoB8+Vt/R3ND1H5Bj
 t4NrLCAHlo2DC3+Obg5e7t4qvnA/VXo9WwE4aQv9WDsi6sNcxGgkzHICnnq0MlHMJQlJ
 TfPA3jNBFGoRfCUh3KJxe4NK5ysq2dFcL1ZAlBzhb3p9m10780iHyJ/isO2OHoGhCS6v
 9ZH7s3EOkYjc4873uBbOkKlLGUx++tt4KfFx0SrC2bridxw/x9e2f6Pyul+tcPq5ITu6 CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xrdmq07bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 06:02:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P5sEnh109243;
        Sat, 25 Jan 2020 06:02:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xratb05sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 06:02:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00P623BY032514;
        Sat, 25 Jan 2020 06:02:03 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 22:02:02 -0800
Date:   Sat, 25 Jan 2020 09:01:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     kernel-janitors@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Alex Dewar <alex.dewar@gmx.co.uk>,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] um: Fix some error handling in uml_vector_user_bpf()
Message-ID: <20200125060152.GN1847@kadam>
References: <20200124101450.jxfzsh6sz7v324hv@kili.mountain>
 <36070c96-8e75-7d06-d945-87a9d366d0b9@cambridgegreys.com>
 <20200124164427.GF1870@kadam>
 <de3bdae8-2dcd-490f-cdf2-67bf92a552e8@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3bdae8-2dcd-490f-cdf2-67bf92a552e8@cambridgegreys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001250050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001250050
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 24, 2020 at 04:48:03PM +0000, Anton Ivanov wrote:
> 
> 
> On 24/01/2020 16:44, Dan Carpenter wrote:
> > On Fri, Jan 24, 2020 at 12:52:18PM +0000, Anton Ivanov wrote:
> > > 
> > > 
> > > On 24/01/2020 10:14, Dan Carpenter wrote:
> > > > 1) The uml_vector_user_bpf() returns pointers so it should return NULL
> > > >      instead of false.
> > > > 2) If the "bpf_prog" allocation failed, it would have eventually lead to
> > > >      a crash.  We can't succeed after the error happens so it should just
> > > >      return.
> > > > 
> > > > Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >    arch/um/drivers/vector_user.c | 10 +++++-----
> > > >    1 file changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> > > > index ddcd917be0af..88483f5b034c 100644
> > > > --- a/arch/um/drivers/vector_user.c
> > > > +++ b/arch/um/drivers/vector_user.c
> > > > @@ -732,13 +732,13 @@ void *uml_vector_user_bpf(char *filename)
> > > >    	if (stat(filename, &statbuf) < 0) {
> > > >    		printk(KERN_ERR "Error %d reading bpf file", -errno);
> > > > -		return false;
> > > > +		return NULL;
> > > 
> > > I will sort this one out, thanks for noticing.
> > > 
> > > >    	}
> > > >    	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
> > > > -	if (bpf_prog != NULL) {
> > > > -		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
> > > > -		bpf_prog->filter = NULL;
> > > > -	}
> > > > +	if (!pfg_prog)
> > > 
> > > ^^^^^ ?
> > 
> > If we don't return here it leads to a NULL dereference.
> 
> It says pfg_prog
> 
> I cannot find this identifier :)
> 

Oh wow...  That's very embarrassing.  My QC scripts do compile these
as part of the process.  But this wasn't a in of my allmodconfig
and when I do "make arch/um/drivers/vector_user.o", it just silently
returns without printing anything.  I didn't notice that it hadn't
built.

Even "make V=2 arch/um/drivers/vector_user.o" doesn't generate output.

I will resend the patch (on Monday though).

regards,
dan carpenter
