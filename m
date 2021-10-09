Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D74276EB
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 05:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbhJIDaJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 23:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244025AbhJIDaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 23:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58D7060F6B;
        Sat,  9 Oct 2021 03:28:12 +0000 (UTC)
Date:   Fri, 8 Oct 2021 23:28:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jussi Maki <joamaki@gmail.com>, Yucong Sun <fallentree@fb.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Subject: Re: [PATCH bpf-next v6 00/14] selftests/bpf: Add parallelism to
 test_progs
Message-ID: <20211008232810.7cdafbd8@oasis.local.home>
In-Reply-To: <CAEf4BzYCUZBmO6qY0VtUshnepVEGRn3Cfiiw4cbVmYBH7ztAUw@mail.gmail.com>
References: <20211006185619.364369-1-fallentree@fb.com>
        <CAEf4BzaE-vXu0zFi=ePTbRfZ=XMCV12oBAz+3p7QBa-E=CAdWw@mail.gmail.com>
        <CAEf4BzZAiZWfKEtc=1qpu8W+WQAcJ6L6BJOftCjjQbF6mzAeoQ@mail.gmail.com>
        <20211008193717.21d93a47@oasis.local.home>
        <CAEf4BzYCUZBmO6qY0VtUshnepVEGRn3Cfiiw4cbVmYBH7ztAUw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 8 Oct 2021 20:20:38 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > Does /sys/kernel/tracing exist?  
> 
> Yeah, it was there, but was empty.

And would be filled with: mount -t tracefs nodev /sys/kernel/tracing

-- Steve
