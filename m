Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1C2D829B
	for <lists+bpf@lfdr.de>; Sat, 12 Dec 2020 00:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437060AbgLKXJL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 18:09:11 -0500
Received: from smtp5.emailarray.com ([65.39.216.39]:15841 "EHLO
        smtp5.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436997AbgLKXI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 18:08:59 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2020 18:08:59 EST
Received: (qmail 13970 invoked by uid 89); 11 Dec 2020 23:01:37 -0000
Received: from unknown (HELO localhost) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuNw==) (POLARISLOCAL)  
  by smtp5.emailarray.com with SMTP; 11 Dec 2020 23:01:37 -0000
Date:   Fri, 11 Dec 2020 15:01:34 -0800
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 1/1 v3 bpf-next] bpf: increment and use correct thread
 iterator
Message-ID: <20201211230134.qswet7pfrda23ooa@bsd-mbp.dhcp.thefacebook.com>
References: <20201211171138.63819-1-jonathan.lemon@gmail.com>
 <20201211171138.63819-2-jonathan.lemon@gmail.com>
 <CAEf4BzYswHcuQNdqyOymB5MTFDKJy0xkG4+Yo_CpUGH4BVqjzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYswHcuQNdqyOymB5MTFDKJy0xkG4+Yo_CpUGH4BVqjzg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 11, 2020 at 12:23:34PM -0800, Andrii Nakryiko wrote:
> > @@ -164,7 +164,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
> >                 curr_files = get_files_struct(curr_task);
> >                 if (!curr_files) {
> >                         put_task_struct(curr_task);
> > -                       curr_tid = ++(info->tid);
> > +                       curr_tid = curr_tid + 1;
> 
> Yonghong might know definitively, but it seems like we need to update
> info->tid here as well:
> 
> info->tid = curr_tid;
> 
> If the search eventually yields no task, then info->tid will stay at
> some potentially much smaller value, and we'll keep re-searching tasks
> from the same TID on each subsequent read (if user keeps reading the
> file). So corner case, but good to have covered.

That applies earlier as well:

                curr_task = task_seq_get_next(ns, &curr_tid, true);
                if (!curr_task) {
                        info->task = NULL;
                        info->files = NULL;
                        return NULL;
                }

The logic seems to be "if task == NULL, then return NULL and stop". 
Is the seq_iterator allowed to continue/restart if seq_next returns NULL?
--
Jonathan
