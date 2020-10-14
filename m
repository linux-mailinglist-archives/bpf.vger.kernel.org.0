Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272DE28E73D
	for <lists+bpf@lfdr.de>; Wed, 14 Oct 2020 21:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390614AbgJNT0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Oct 2020 15:26:37 -0400
Received: from mx.der-flo.net ([193.160.39.236]:35240 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389668AbgJNT0h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 15:26:37 -0400
Received: by mx.der-flo.net (Postfix, from userid 110)
        id C2BD944097; Wed, 14 Oct 2020 21:26:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.der-flo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from x201s.fritz.box (p200300D39717440196a31F08d439B120.dip0.t-ipconnect.de [IPv6:2003:d3:9717:4401:96a3:1f08:d439:b120])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 6AA1C44097;
        Wed, 14 Oct 2020 21:25:53 +0200 (CEST)
Date:   Wed, 14 Oct 2020 21:25:41 +0200
From:   Florian Lehner <dev@der-flo.net>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        dev@der-flo.net
Subject: Re: [PATCH bpf-next v2] bpf: Lift hashtab key_size limit
Message-ID: <20201014192541.GB9283@x201s.fritz.box>
References: <20200922190234.224161-1-dev@der-flo.net>
 <5f84b24ad1016_24c92208a4@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f84b24ad1016_24c92208a4@john-XPS-13-9370.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend wrote:
> I think this is OK, but just curious is there a real use-case
> that has keys bigger than stack size or is this just an
> in-theory observation.

The use-case for this patch originates to implement allow/disallow
lists for files and file paths. The maximum length of file paths is
defined by PATH_MAX with 4096 chars including nul.
This limit exceeds MAX_BPF_STACK. 

Thanks,
 Florian
