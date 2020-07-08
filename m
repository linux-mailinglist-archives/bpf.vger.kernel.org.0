Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322762189BF
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgGHOCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 10:02:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:37902 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgGHOCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 10:02:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4EA2931A;
        Wed,  8 Jul 2020 14:02:40 +0000 (UTC)
Date:   Wed, 8 Jul 2020 08:02:39 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: XDP (eXpress Data
 Path)
Message-ID: <20200708080239.2ce729f3@lwn.net>
In-Reply-To: <20200708135737.14660-1-grandmaster@al2klimov.de>
References: <20200708135737.14660-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed,  8 Jul 2020 15:57:37 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/arm/ixp4xx.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

That's not XDP; something went awry in there somewhere.

jon
