Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EE82E0B98
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 15:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgLVOTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 09:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgLVOTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 09:19:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F9C0613D3;
        Tue, 22 Dec 2020 06:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Czhr0lZ6q7lggbyK5BscVjMM51bWnt+mp2M9jPtWApM=; b=OYm3LQIX07Nw82C/3BFSqrMbww
        w8YueS8jraJ7fHEdX4kWtlkFiQ5UU6juC18/mY8mLT7tTJQtWc9iIzLFwdEirmXZyyxnXUtEgCphb
        CbrwGhniNr/l0GMrPftPvhCAqMJUljn+wED/f79le8Aa+DlqcrUXDcEu8kZAdwIyGMHSRG6MsLG4z
        D49Maf+QHKenhKjXA4FJl5eitKhVThAdppdwprBdi8ty3q7vID4rVk7CMUTxSYFXpnr/wc04qgvLZ
        EiuUcvImrPFeTFVn+FVzhjvG3wXo/0ewNw3ACLsN+16qneZP2PpA9zdmw2NbD9FdL+nBnAcULahl0
        SGI2wVdQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kriUU-0004aY-3u; Tue, 22 Dec 2020 14:18:18 +0000
Date:   Tue, 22 Dec 2020 14:18:18 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Florent Revest <revest@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
Message-ID: <20201222141818.GA17056@infradead.org>
References: <20201126165748.1748417-1-revest@google.com>
 <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
 <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

FYI, there is a reason why kallsyms_lookup is not exported any more.
I don't think adding that back through a backdoor is a good idea.
