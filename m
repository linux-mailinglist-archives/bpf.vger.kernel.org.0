Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCB2E1982
	for <lists+bpf@lfdr.de>; Wed, 23 Dec 2020 08:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgLWHvl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Dec 2020 02:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgLWHvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Dec 2020 02:51:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25960C0613D3;
        Tue, 22 Dec 2020 23:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DsUx9mdZt707uyB4UvQMhQtnSAx/QVWXa/XPYhsbpHk=; b=JOxqt6e59p0nOH9ElSu4Ow4Hgl
        TiduuNNekNGLdyKvSi9zc3opGxX4X7xqH0pdopvqdHxWxOqeylhmdX8KmirUxZm8TzOAtSoaJxvL4
        QRveder0RjEfY0dsMfLcvOsHJqmobESmc/JUTBoVlzkNU3DF0etyLOAYkqCFUTO8e2ZAUKOMnPsG3
        di09XN+NeLaE/OYI1toNu2olSscAPqyGn2oc1cdSa/CF7GcNa+y7xlzwDDQN4sXcFpMxitkQRolQU
        RebBLDaEQDgqKvu9F590yvKx1G5dj3lqqXAIGoiOrhmAhDqC09yJnoWxgT1D58EHVrzvF9B+gBgnU
        iopambxQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kryv1-0004HW-Ec; Wed, 23 Dec 2020 07:50:47 +0000
Date:   Wed, 23 Dec 2020 07:50:47 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
Message-ID: <20201223075047.GA15781@infradead.org>
References: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
 <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
 <20201222141818.GA17056@infradead.org>
 <CABRcYmKBgQYHezKVaLCVwUvksFaVuU7RHW8VVjM6auOC_GOr+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRcYmKBgQYHezKVaLCVwUvksFaVuU7RHW8VVjM6auOC_GOr+w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 22, 2020 at 09:17:41PM +0100, Florent Revest wrote:
> On Tue, Dec 22, 2020 at 3:18 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > FYI, there is a reason why kallsyms_lookup is not exported any more.
> > I don't think adding that back through a backdoor is a good idea.
> 
> Did you maybe mean kallsyms_lookup_name (the one that looks an address
> up based on a symbol name) ? It used to be exported but isn't anymore
> indeed.
> However, this is not what we're trying to do. As far as I can tell,
> kallsyms_lookup (the one that looks a symbol name up based on an
> address) has never been exported but its close cousins sprint_symbol
> and sprint_symbol_no_offset (which only call kallsyms_lookup and
> pretty print the result) are still exported, they are also used by
> vsprintf. Is this an issue ?

Indeed, I thought of kallsyms_lookup_name.  Let me take another
look at the patch, but kallsyms_lookup still seems like a very
lowlevel function to export to arbitrary eBPF programs.
