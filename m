Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46BBB03C9
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfIKSnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Sep 2019 14:43:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfIKSnq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 14:43:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BIhVqx057041;
        Wed, 11 Sep 2019 18:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=PpbjP/K7FS/mhoPoFUIAdpkmq3dsAewLE9s1QyDDJa0=;
 b=HCaGG62/OUogK5kDUJX8eKcIBNc4qkq3JHV4gsLrMxOSiF7DUUB1GD2yojxzvJSfgdUg
 IQYJJrnn7v/KN1sxGkSUaFj166y2WV1bnFPxNoHoPNPtTvY72YOdyOUs6D6Tbe3PUnID
 56xXRSPU2lbOT4UyD0y7EEFzUX4M06yq9XROHZbGJIOHDd7NZLSPvq8PLba/DGHnpBlT
 +UAk/glklN7aPmijNmla+bbMPeBYI6Ux/Awt8ZVLTyjqM3vzdA8glvG9eSlMZcih8q5l
 PDQrddNfimBTaovRvWH/Xk+vm+SnXUFSuTCUzRSHc37abpQsn2qIPA2L05rNs8Jb0Jqp ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uw1m943vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 18:43:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BIhXnt024817;
        Wed, 11 Sep 2019 18:43:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2uxj893hsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 18:43:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BIhdlD029626;
        Wed, 11 Sep 2019 18:43:40 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 11:43:39 -0700
Date:   Wed, 11 Sep 2019 21:43:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190911184332.GL20699@kadam>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110171
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
> +Coding Style Addendum
> +---------------------
> +libnvdimm expects multi-line statements to be double indented. I.e.
> +
> +        if (x...
> +                        && ...y) {

That looks horrible and it causes a checkpatch warning.  :(  Why not
do it the same way that everyone else does it.

	if (blah_blah_x && <-- && has to be on the first line for checkpatch
	    blah_blah_y) { <-- [tab][space][space][space][space]blah

Now all the conditions are aligned visually which makes it readable.
They aren't aligned with the indent block so it's easy to tell the
inside from the if condition.

I kind of hate all this extra documentation because now everyone thinks
they can invent new hoops to jump through.

Speaking of hoops, the BPF documentation says that you have to figure
out which tree a patch applies to instead of just working against
linux-next.  Is there an automated way to do that?  I looked through my
inbox and there are a bunch of patches marked as going through the
bpf-next tree but about half were marked incorrectly so it looks like
everyone who tries to tag their patches is going to do it badly anyway.

regards,
dan carpenter

