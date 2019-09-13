Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309C9B22C4
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfIMPAq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 11:00:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388211AbfIMPAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 11:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/rrOO5cRfnuT0HPH0sG11kpD8hb/EFmQkUJiAynpSfI=; b=rhcGyriUGdM0uLIxwPsUds2QT
        t+M0Zs7sOBv6zqYYMm7GBfHI8C5o8Wn19/FCGzhLLfkakZqlASZkCnoNm1ElzdSTNHs5DJzfwQ0S/
        sAs15ESalJ9S2r2ftIZc8Y1T0YZ7pzRl8jxQVlMibUStwIfn91AVf+5NKl5l7qv72VxeDZGsgOok7
        UXm4bOQOokOzPjF9h+WMsBoTJUBRU+L78K5hAPL1I7FPhBnPzhNxbdWzQR5XXLAUcuCyAJOHLffEI
        p9Ovn+qpuOdt1PbCis4hoqBgSJre4ax2VCiIp/Ev1VjI9J3m/zLiVwnWY9LsF49wzYWf4M6kKbVmv
        oNAcnnchg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8n3z-0006Au-6N; Fri, 13 Sep 2019 15:00:43 +0000
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
Date:   Fri, 13 Sep 2019 08:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913114849.GP20699@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/13/19 4:48 AM, Dan Carpenter wrote:

>> So I'm expecting to take this kind of stuff into Documentation/.  My own
>> personal hope is that it can maybe serve to shame some of these "local
>> quirks" out of existence.  The evidence from this brief discussion suggests
>> that this might indeed happen.
> 
> I don't think it's shaming, I think it's validating.  Everyone just
> insists that since it's written in the Book of Rules then it's our fault
> for not reading it.  It's like those EULA things where there is more
> text than anyone can physically read in a life time.

Yes, agreed.

> And the documentation doesn't help.  For example, I knew people's rules
> about capitalizing the subject but I'd just forget.  I say that if you
> can't be bothered to add it to checkpatch then it means you don't really
> care that strongly.

If a subsystem requires a certain spelling/capitalization in patch email
subjects, it should be added to MAINTAINERS IMO.  E.g.,
E:	NuBus

-- 
~Randy
