Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944EFB1C85
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfIMLte (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 07:49:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfIMLte (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 07:49:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DBnPpN011179;
        Fri, 13 Sep 2019 11:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=RuG4XRa8Ih2CITWnXLqdpBQAq1yXah+Xb9pxGK9n/fA=;
 b=bmVh2TBBl/5wnrx9pWWERaOohnKADAnNiiwm0SLH8J2i3n9ZqdULeCeJT2i0Dm14DBqf
 j0WmtyH+8AtOZ00T7xf17ddP6QyWBmAtrCh5n6XV8fZNKVcHsncMBFT3jnZfHQqx1xB8
 ZYpj0eBKtEMkXXp1S4cbxC3rLnRYTqO20o8/jKLsZj+LkhJCT74vk7SrD1YLR81fPPWq
 c4oSLU4FPrRsJC1a16EQ7O6UNWtnKvJPy3zmlc8rh5Eew1ES2ojZvtebvuubvjeNy02n
 8Hps+3eil9MHhbrqXhypwuZEK4+NZf11CTlYE8ylK4FgQPEVItKSZUJjy8xK0FIL01hf Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uytd347h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 11:49:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DBn8nA002132;
        Fri, 13 Sep 2019 11:49:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uytdq3t5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 11:49:24 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DBn0pj002926;
        Fri, 13 Sep 2019 11:49:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 04:48:59 -0700
Date:   Fri, 13 Sep 2019 14:48:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190913114849.GP20699@kadam>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913010937.7fc20d93@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130115
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 01:09:37AM -0600, Jonathan Corbet wrote:
> On Wed, 11 Sep 2019 16:11:29 -0600
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 9/11/19 12:43 PM, Dan Carpenter wrote:
> > > 
> > > I kind of hate all this extra documentation because now everyone thinks
> > > they can invent new hoops to jump through.
> > 
> > FWIW, I completely agree with Dan (Carpenter) here. I absolutely
> > dislike having these kinds of files, and with subsystems imposing weird
> > restrictions on style (like the quoted example, yuck).
> > 
> > Additionally, it would seem saner to standardize rules around when
> > code is expected to hit the maintainers hands for kernel releases. Both
> > yours and Martins deals with that, there really shouldn't be the need
> > to have this specified in detail per sub-system.
> 
> This sort of objection came up at the maintainers summit yesterday; the
> consensus was that, while we might not like subsystem-specific rules, they
> do currently exist and we're just documenting reality.  To paraphrase
> Phillip K. Dick, reality is that which, when you refuse to document it,
> doesn't go away.

There aren't that many subsystem rules.  The big exception is
networking, with the comment style and reverse Chrismas tree
declarations.  Also you have to label which git tree the patch applies
to like [net] or [net-next].

It used to be that infiniband used "sizeof foo" instead of sizeof(foo)
but now there is a new maintainer.

There is one subsystem which where the maintainer will capitalize your
patch prefix and complain.  There are others where they will silently
change it to lower case.  (Maybe that has changed in recent years).

There is one subsystem where the maintainer is super strict rules that
you can't use "I" or "we" in the commit message.  So you can't say "I
noticed a bug while reviewing", you have to say "The code has a bug".

Some maintainers have rules about what you can put in the declaration
block.  No kmalloc() in the declarations is a common rule.
"struct foo *p = kmalloc();".

Some people (I do) have strict rules for error handling, but most won't
complain unless the error handling has bugs.

The bpf people want you to put [bpf] or [bpf-next] in the subject.
Everyone just guesses, and uneducated guesses are worse than leaving it
blank, but that's just my opinion.

> So I'm expecting to take this kind of stuff into Documentation/.  My own
> personal hope is that it can maybe serve to shame some of these "local
> quirks" out of existence.  The evidence from this brief discussion suggests
> that this might indeed happen.

I don't think it's shaming, I think it's validating.  Everyone just
insists that since it's written in the Book of Rules then it's our fault
for not reading it.  It's like those EULA things where there is more
text than anyone can physically read in a life time.

And the documentation doesn't help.  For example, I knew people's rules
about capitalizing the subject but I'd just forget.  I say that if you
can't be bothered to add it to checkpatch then it means you don't really
care that strongly.

regards,
dan carpenter
