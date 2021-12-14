Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B61B474649
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhLNPSx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 10:18:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41200 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbhLNPSx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 10:18:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B76CB81A73
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 15:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05937C34601;
        Tue, 14 Dec 2021 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639495131;
        bh=1WUpEUbm/WlcVlDZz510IRyu5p5v/yv1q2OlBSKVZ4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XdtGvxfZKGLC9Lfwdpv7OBQsehiwsitYQNcZrs7BVsxuHwCMLLX8Uqu0rwI8wSdpr
         aE5VXsdywFVx/k3Eflsr/7J0iXvx7sV/6qvMxoYmhCsH++lae5zc5FlvKYOMgaJMA7
         rzvnGI9FOJheq4awaiZYZiAD1kSOuOHkv2foLQweH0HYUfIhp6+lg7CgFj6KmnwY1W
         o5acO36Rs+gWECiFLUYvU01fsPma4Adw0MN5Fvmadbth3B2Y4cZRqT3QRveuES9p3b
         eEwXlUl2yqRGnpqPUpJEb+vb/A62K0xLK1zP6vErXuwKePPi6lFjBxB2+xsb0Q0I2+
         kpwVLTW2woT2g==
Date:   Tue, 14 Dec 2021 07:18:50 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/5] bpf: create a header for struct bpf_link
Message-ID: <20211214071850.175707e5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211214070435.7f07e2ac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211213234223.356977-1-kuba@kernel.org>
        <20211213234223.356977-4-kuba@kernel.org>
        <CAADnVQ+6Qmm9b3Jf_BHCn_PFxs00NK71K235zQYc=_PufkOPAQ@mail.gmail.com>
        <20211214070435.7f07e2ac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 14 Dec 2021 07:04:35 -0800 Jakub Kicinski wrote:
> > My understanding that patch 4 is the key.
> > I think the bpf-link.h bpf-cgroup-types.h and bpf-cgroup-storage.h
> > are too specific. We don't do a header file per type.
> > Maybe combine them all into one bpf-cgroup-types.h ?
> > That will still achieve the separation of cgroup from linux/bpf.h  

The dependency tree is


         bpf-link.h  bpf-cgroup-types.h                                              
              ^       ^
              |      /                                  
 bpf.h     bpf-cgroup.h  
    ^           ^                             
    |           |                          
    |           |                          
  bpf-cgroup-storage.h


I can't merge bpf-cgroup-storage.h with the rest, it'd be a loop.
Should I leave that one be separate? Any other ideas?
