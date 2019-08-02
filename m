Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25E8003B
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405990AbfHBSfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 14:35:41 -0400
Received: from smtp.emailarray.com ([69.28.212.198]:16904 "EHLO
        smtp2.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405370AbfHBSfl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 14:35:41 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2019 14:35:41 EDT
Received: (qmail 68039 invoked by uid 89); 2 Aug 2019 18:29:00 -0000
Received: from unknown (HELO ?172.20.175.84?) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTk5LjIwMS42NC4z) (POLARISLOCAL)  
  by smtp2.emailarray.com with (AES256-GCM-SHA384 encrypted) SMTP; 2 Aug 2019 18:29:00 -0000
From:   "Jonathan Lemon" <jlemon@flugsvamp.com>
To:     "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, bruce.richardson@intel.com,
        songliubraving@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] xsk: remove AF_XDP socket from map when
 the socket is released
Date:   Fri, 02 Aug 2019 11:28:55 -0700
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <56AED321-244E-4EAA-93C8-B633A7EE14FE@flugsvamp.com>
In-Reply-To: <20190802081154.30962-2-bjorn.topel@gmail.com>
References: <20190802081154.30962-1-bjorn.topel@gmail.com>
 <20190802081154.30962-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2 Aug 2019, at 1:11, Björn Töpel wrote:

> From: Björn Töpel <bjorn.topel@intel.com>
>
> When an AF_XDP socket is released/closed the XSKMAP still holds a
> reference to the socket in a "released" state. The socket will still
> use the netdev queue resource, and block newly created sockets from
> attaching to that queue, but no user application can access the
> fill/complete/rx/tx queues. This results in that all applications need
> to explicitly clear the map entry from the old "zombie state"
> socket. This should be done automatically.
>
> In this patch, the sockets tracks, and have a reference to, which maps
> it resides in. When the socket is released, it will remove itself from
> all maps.
>
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>

Reviewed-by: Jonathan Lemon <jonathan.lemon@gmail.com>
