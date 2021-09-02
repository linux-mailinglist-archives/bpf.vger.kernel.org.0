Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB48F3FEFBA
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhIBOzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 10:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhIBOzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 10:55:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9EB6108B;
        Thu,  2 Sep 2021 14:54:19 +0000 (UTC)
Date:   Thu, 2 Sep 2021 10:54:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/8] x86/ftrace: Add direct batch interface
Message-ID: <20210902105158.3816e193@oasis.local.home>
In-Reply-To: <YS/PRZR5xjSXnJ9z@krava>
References: <20210831095017.412311-1-jolsa@kernel.org>
        <CAADnVQK6kLef54iCufsJay0SnsTLk1Ta-RmnhZnGk7TqJCWUJQ@mail.gmail.com>
        <YS/PRZR5xjSXnJ9z@krava>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 1 Sep 2021 21:06:45 +0200 Jiri Olsa <jolsa@redhat.com> wrote:
> On Wed, Sep 01, 2021 at 08:23:38AM -0700, Alexei Starovoitov wrote:

> > Steven,
> > 
> > Could you review and merge this set for this merge window,
> > so we can process related bpf bits for the next cycle?  
> 
> actually I might have sent it out too early, there's still
> bpf part review discussion that might end up in interface
> change

Regardless, it is way too late to apply this to the current merge
window. I don't think Linus would appreciate me pulling in a complex
patch set 4 days into the merge window, review it, and then push it to
him without much faith that this wont cause any major issues in use
cases we did not think about. Not to mention, I would have to drop
everything I am responsible for to do that.

I would never ask another maintainer to do such an irresponsible act.

> 
> review would be great, but please hold on with the merge

I just got back from an 8 day vacation, and my inbox is way out of
hand, and I still need to put together the changes that have been in
linux-next for some time, and get that to Linus.

Hopefully I'll get to looking at this sometime next week.

-- Steve

