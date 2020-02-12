Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBF15ABE6
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgBLPWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 10:22:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32559 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727519AbgBLPWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Feb 2020 10:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581520919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ottWemx9cJxMI4t+4ccutF4ddp/wCYiVYaKL0zTWk6Q=;
        b=eBL814P7GpVV7KJ42CGLYBHnAfkoCbveCW24xp5ADgipwFdT5g0k2Vbm0MKLpkOqBgOHXW
        TXzhBzPaqv0lIa20zaxsyapmLGUr4+Z46Yviwn7KXlt5isBA7mVp+i9AuHyf9f2HWZRB4V
        WBzXklfu9sqmMjZK1GhCqheRas0OUfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-Xg0TlgZVOwGJ6LLdNdhu8g-1; Wed, 12 Feb 2020 10:21:55 -0500
X-MC-Unique: Xg0TlgZVOwGJ6LLdNdhu8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DB7A1005514;
        Wed, 12 Feb 2020 15:21:53 +0000 (UTC)
Received: from krava (ovpn-204-247.brq.redhat.com [10.40.204.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 402A75D9E2;
        Wed, 12 Feb 2020 15:21:51 +0000 (UTC)
Date:   Wed, 12 Feb 2020 16:21:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brendan Gregg <bgregg@netflix.com>,
        Wenbo Zhang <ethercflow@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH bpf-next v14 1/2] bpf: add new helper get_fd_path for
 mapping a file descriptor to a pathname
Message-ID: <20200212152149.GA195172@krava>
References: <8f6b8979fb64bedf5cb406ba29146c5fa2539267.1576575253.git.ethercflow@gmail.com>
 <cover.1576629200.git.ethercflow@gmail.com>
 <7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com>
 <51564b9e-35f0-3c73-1701-8e351f2482d7@iogearbox.net>
 <CABtjQmbh080cFr9e_V_vutb1fErRcCvw-bNNYeJHOcah-adFCA@mail.gmail.com>
 <20200116085943.GA270346@krava>
 <CAJN39ogSo=bEEydp7s34AjtDVwXxw7_hQFrARWE4NXQwRZxSxw@mail.gmail.com>
 <c27d3cc2-f846-8aa9-10fd-c2940e7605d1@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27d3cc2-f846-8aa9-10fd-c2940e7605d1@iogearbox.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 11, 2020 at 01:01:16AM +0100, Daniel Borkmann wrote:
> On 2/10/20 5:43 AM, Brendan Gregg wrote:
> > On Thu, Jan 16, 2020 at 12:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > On Fri, Dec 20, 2019 at 11:35:08AM +0800, Wenbo Zhang wrote:
> > > > > [ Wenbo, please keep also Al (added here) in the loop since he was providing
> > > > >     feedback on prior submissions as well wrt vfs bits. ]
> > > > 
> > > > Get it, thank you!
> > > 
> > > hi,
> > > is this stuck on review? I'd like to see this merged ;-)
> > 
> > Is this still waiting on someone? I'm writing some docs on analyzing
> > file systems via syscall tracing and this will be a big improvement.
> 
> It was waiting on final review/ACK from vfs folks, but given that didn't
> happen so far :/, this series should get rebased for proceeding with merge.
> 

Al Viro, any chance you could check on the latest version?

thanks,
jirka

