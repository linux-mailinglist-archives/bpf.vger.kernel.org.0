Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147801B206D
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgDUHzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 03:55:38 -0400
Received: from verein.lst.de ([213.95.11.211]:45190 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgDUHzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 03:55:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 58CB668C4E; Tue, 21 Apr 2020 09:55:34 +0200 (CEST)
Date:   Tue, 21 Apr 2020 09:55:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrey Ignatov <rdna@fb.com>, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 6/6] sysctl: pass kernel pointers to ->proc_handler
Message-ID: <20200421075534.GC15772@lst.de>
References: <20200417064146.1086644-1-hch@lst.de> <20200417064146.1086644-7-hch@lst.de> <20200417193910.GA7011@rdna-mbp> <20200417195015.GO5820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417195015.GO5820@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 17, 2020 at 12:50:15PM -0700, Matthew Wilcox wrote:
> > cur_val is allocated separately below to read current value of sysctl
> > and not interfere with user-passed buffer. 

Ok, I'll fix this up.
