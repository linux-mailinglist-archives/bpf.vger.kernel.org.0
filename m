Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6721DB924
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgETQQd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 12:16:33 -0400
Received: from verein.lst.de ([213.95.11.211]:50579 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETQQd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 12:16:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44A7568BEB; Wed, 20 May 2020 18:16:30 +0200 (CEST)
Date:   Wed, 20 May 2020 18:16:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/20] maccess: return -ERANGE when
 copy_from_kernel_nofault_allowed fails
Message-ID: <20200520161630.GA4432@lst.de>
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-21-hch@lst.de> <20200520200255.3db6d27304f0b4c29c52ebcc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520200255.3db6d27304f0b4c29c52ebcc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 08:02:55PM +0900, Masami Hiramatsu wrote:
> Can you also update the kerneldoc comment too?

Sure, done.
