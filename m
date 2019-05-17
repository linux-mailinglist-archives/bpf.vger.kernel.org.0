Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA67B21FE2
	for <lists+bpf@lfdr.de>; Fri, 17 May 2019 23:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfEQVvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 May 2019 17:51:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:60676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726876AbfEQVvE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 May 2019 17:51:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 086D9AFA1;
        Fri, 17 May 2019 21:51:03 +0000 (UTC)
Date:   Fri, 17 May 2019 21:50:58 +0000
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Michal Rostecki <mrostecki@opensuse.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xdp <xdp-newbies@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] Move bpf_printk to bpf_helpers.h
Message-ID: <20190517215058.GA10873@wotan.suse.de>
References: <20190516112105.12887-1-mrostecki@opensuse.org>
 <CAADnVQLFrZyjbFb6o0YezLyqGBKcsiT=jVGfwDaupGLvgLp31A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLFrZyjbFb6o0YezLyqGBKcsiT=jVGfwDaupGLvgLp31A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 16, 2019 at 11:43:03AM -0700, Alexei Starovoitov wrote:
> On Thu, May 16, 2019 at 4:21 AM Michal Rostecki <mrostecki@opensuse.org> wrote:
> >
> > This series of patches move the commonly used bpf_printk macro to
> > bpf_helpers.h which is already included in all BPF programs which
> > defined that macro on their own.
> 
> makes sense, but it needs to wait until bpf-next reopens.

Sorry for that! Please apply the v2 patch when bpf-next repoens.
