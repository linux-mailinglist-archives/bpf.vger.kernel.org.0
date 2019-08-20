Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216B8962BD
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 16:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfHTOpM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 10:45:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfHTOpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 10:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0LAxwykHVedtmUFtDwghFW/Ngjwy5rPPhRHs6eC63ZQ=; b=hw2gR7kcRWphlWRW867OYSLqo
        0GSrE1i3Gmj+zOQSYXr8yQ8M79IwA8CMDsnMqJnw1OWdg0DBGpOXagmJcrrAujOtLWMFR5DoUuhWH
        vJso2SPIztvRDDtHmkoQRvs+uACV9nZBw5emewERLAwVU5eqSsxJcOEBYp45ciVSo86Cjwe7smbIL
        NiJSRK3dfK/TYqhjKkXBDDJgXbikR5R3H3P6RgITe9TzChvygFPahU8S0fm+LvgHiGwjSP6ZRp95W
        tGCkhseQOABPjHfDh2HQ176C/cHlYoIPieqpnI46REj/xvTXSOQLe3TG4FBrLwWXw7KZMJmc3BXhg
        2i1tiF+1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i05Ni-0006sp-Sb; Tue, 20 Aug 2019 14:45:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAAB330768C;
        Tue, 20 Aug 2019 16:44:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F185F20A999E4; Tue, 20 Aug 2019 16:45:03 +0200 (CEST)
Date:   Tue, 20 Aug 2019 16:45:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, mingo@redhat.com, acme@kernel.org, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Message-ID: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
References: <20190816223149.5714-1-dxu@dxuuu.xyz>
 <20190816223149.5714-2-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816223149.5714-2-dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 16, 2019 at 03:31:46PM -0700, Daniel Xu wrote:
> It's useful to know [uk]probe's nmissed and nhit stats. For example with
> tracing tools, it's important to know when events may have been lost.
> debugfs currently exposes a control file to get this information, but
> it is not compatible with probes registered with the perf API.

What is this nmissed and nhit stuff?
