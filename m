Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B02B3A85
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfIPMnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 08:43:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:20566 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfIPMnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 08:43:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 05:43:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="191060337"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 05:42:57 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS: Maintainer Entry Profile
In-Reply-To: <20190913114849.GP20699@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com> <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com> <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk> <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
Date:   Mon, 16 Sep 2019 15:42:54 +0300
Message-ID: <87pnk0xvht.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 13 Sep 2019, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> And the documentation doesn't help.  For example, I knew people's rules
> about capitalizing the subject but I'd just forget.  I say that if you
> can't be bothered to add it to checkpatch then it means you don't really
> care that strongly.

It would be entirely possible to add the subsystem/driver specific
checkpatch rules to MAINTAINERS entries or directory specific config
files. As checkpatch options directly. For example

--strict --max-line-length=100 --ignore=BIT_MACRO,SPLIT_STRING,LONG_LINE_STRING,BOOL_MEMBER

or whatever.

SMOP. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
