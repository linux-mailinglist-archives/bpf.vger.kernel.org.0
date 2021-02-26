Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DA326A76
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 00:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBZXnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 18:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhBZXnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 18:43:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19ADC64EF0;
        Fri, 26 Feb 2021 23:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614382955;
        bh=lq8IjeeX+oQjQXusTsE+shS/4EVXhE0b/A13Auf08dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i6W3ugoL6fJKII5hLXfLY3/9MBpeXJ1Bcg5D+aumHSp7ToL2LrjeSfLBkwG/iB4ZO
         jPGxhXanyyOHJbYz1zWzNexn7VhdyilfBUFeqH4Y4DqWYN+waRkkATQRpbVcc7NVQ0
         tnSkIoUy4mpeCzjhmPzBEA9sI+HSMEJCB88vUMZGfVtMPMBJmM8DW0ekHyqwIXdV0t
         OYNbnaTVe8bFh0ynThixUvbKSz2IPf8RclA/p1Z4fc0ztdYvMEVjhzbD+LGB3gk+rK
         NXnqvIwN48perQI8GMqzYir54yIfu57sTlBCao5nuxajR4fT6L/K8G+lE88hmmqLTJ
         3qbnnPYJQwuKA==
Date:   Fri, 26 Feb 2021 15:42:34 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: pull-request: bpf 2021-02-26
Message-ID: <20210226154234.47c78790@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210226193737.57004-1-alexei.starovoitov@gmail.com>
References: <20210226193737.57004-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Feb 2021 11:37:37 -0800 Alexei Starovoitov wrote:
> Hi David, hi Jakub,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 8 non-merge commits during the last 3 day(s) which contain
> a total of 10 files changed, 41 insertions(+), 13 deletions(-).
> 
> The main changes are:
> 
> 1) Fix for bpf atomic insns with src_reg=r0, from Brendan.
> 
> 2) Fix use after free due to bpf_prog_clone, from Cong.
> 
> 3) Drop imprecise verifier log message, from Dmitrii.
> 
> 4) Remove incorrect blank line in bpf helper description, from Hangbin.

Pulled, thanks! (please remember to CC netdev I was searching for the PR
email there since the bot doesn't reply automatically to BPF PRs :S)
