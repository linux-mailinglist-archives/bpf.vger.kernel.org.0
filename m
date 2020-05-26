Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F81E30FF
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 23:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbgEZVO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 17:14:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:44858 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390435AbgEZVO6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 17:14:58 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdguW-0007iV-Ej; Tue, 26 May 2020 23:14:56 +0200
Date:   Tue, 26 May 2020 23:14:56 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     ast@kernel.org, andriin@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH] libbpf: Install headers as part of make install
Message-ID: <20200526211456.GA3853@pc-9.home>
References: <20200526174612.5447-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526174612.5447-1-nborisov@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25824/Tue May 26 14:27:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 26, 2020 at 08:46:12PM +0300, Nikolay Borisov wrote:
> Current 'make install' results in only pkg-config and library binaries
> being installed. For consistency also install headers as part of
> "make install"
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Applied, thanks!
