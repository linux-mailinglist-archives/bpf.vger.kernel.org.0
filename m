Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B1429745A
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465779AbgJWQgQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 12:36:16 -0400
Received: from mx.der-flo.net ([193.160.39.236]:42272 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463974AbgJWQgP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 12:36:15 -0400
Received: by mx.der-flo.net (Postfix, from userid 110)
        id 2580644287; Fri, 23 Oct 2020 18:35:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.der-flo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2a02:1203:ecb0:3930:1751:4157:4d75:a5e2])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id B70C9441E6;
        Fri, 23 Oct 2020 18:35:18 +0200 (CEST)
Date:   Fri, 23 Oct 2020 18:35:18 +0200
From:   Florian Lehner <dev@der-flo.net>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Lift hashtab key_size limit
Message-ID: <20201023163518.GA4777@der-flo.net>
References: <20200922190234.224161-1-dev@der-flo.net>
 <20201013144515.298647-1-dev@der-flo.net>
 <5f87ce648edd5_b7602085a@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f87ce648edd5_b7602085a@john-XPS-13-9370.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 14, 2020 at 09:21:56PM -0700, John Fastabend wrote:
> 
> OK the check appears unnecessary. It seems a bit excessive to have
> such large keys though.
> 
> Daniel, Alexei I couldn't find this patch in patchworks, not sure
> where it went.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Is there something left I have missed to address?
Or should I rebase the patch and send it in again?

Thanks,
 Florian
