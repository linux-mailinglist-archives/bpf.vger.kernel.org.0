Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394051F7EB5
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLWFK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:05:10 -0400
Received: from sym2.noone.org ([178.63.92.236]:60562 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLWFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 18:05:10 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49kFC83k7Xzvjc1; Sat, 13 Jun 2020 00:05:07 +0200 (CEST)
Date:   Sat, 13 Jun 2020 00:05:07 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf] tools/bpftool: fix skeleton codegen
Message-ID: <20200612220506.nad3zmcg7j75hnsz@distanz.ch>
References: <20200612201603.680852-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612201603.680852-1-andriin@fb.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-12 at 22:16:03 +0200, Andrii Nakryiko <andriin@fb.com> wrote:
> Remove unnecessary check at the end of codegen() routine which makes codegen()
> to always fail and exit bpftool with error code. Positive value of variable
> n is not an indicator of a failure.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Fixes: 2c4779eff837 ("tools, bpftool: Exit on error in function codegen")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Sorry about this, thanks for fixing it.
