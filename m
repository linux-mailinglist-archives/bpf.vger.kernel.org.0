Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E425156E7B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2020 05:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgBJEno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Feb 2020 23:43:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41990 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJEno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Feb 2020 23:43:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so5287714qke.9
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2020 20:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfoBXSjIiP8bllXnjsNJlexmsGl/T8lS+3Z9r/hB9J4=;
        b=Or5PPChHnJb2WYfuYZQn5LcPcG+4S0oUa6CEBGa8uN7wSJTMgD83h8WvZ08To226Zh
         kmuWp343QTfT6s8FZjIMMAc/ejQoceVg7X/YPRp/Q1OBlL7gzQdPhk0BuX+5vFofG68j
         GDcd9EFzhMIZaY06JaFfNCL0zVKHbMPCK+oCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfoBXSjIiP8bllXnjsNJlexmsGl/T8lS+3Z9r/hB9J4=;
        b=R7qFRTwriDmRanjv4LEnks9BBVHF1/W6+7X86sXi7ob8rHNQ/Ql3DObgnb5H3jH7oR
         HwjBAC+iLZKWrlCwgaj7M7YL8n33l+MF8VfkEkaDfZ81JPokJ31yDrTOWxvGDrJSkhwS
         8sCDfv8fseks0raTbNwXC5ZifbfsYVzHhe26ydkUkBwnbxiSKSZaDPbao+hkp/FgVwlQ
         9bFw2lj5cTY7aQDQ01b63VMhXi/5ol8POAQxQTYN564/BUu+Mp99NgdNSVE52x4A34Dp
         HT7czFhc+MrcrZSFklouZRHfCh5u9yT9YiYP9nGAzK7nV8rz7w1LL4uvoJz7F8SWl+Ko
         t9sQ==
X-Gm-Message-State: APjAAAWp4Eeq7mtTfk2t65biyOd50Sy5+0a4t0qgHSDqUUsL/aF+E4pq
        cVvfsncEQQJOL47P6gNTlzX7l2jyBZixySmpjLY6gg==
X-Google-Smtp-Source: APXvYqw8dPSqQFU+D7xMcBArzOUhkZS2pJSS3gbAxOPmLzQy7t+t3RnKEOu+DRRxgzTC13CoGYNOrgikqc0vxnJJcH4=
X-Received: by 2002:a05:620a:b0f:: with SMTP id t15mr8941217qkg.135.1581309823409;
 Sun, 09 Feb 2020 20:43:43 -0800 (PST)
MIME-Version: 1.0
References: <8f6b8979fb64bedf5cb406ba29146c5fa2539267.1576575253.git.ethercflow@gmail.com>
 <cover.1576629200.git.ethercflow@gmail.com> <7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com>
 <51564b9e-35f0-3c73-1701-8e351f2482d7@iogearbox.net> <CABtjQmbh080cFr9e_V_vutb1fErRcCvw-bNNYeJHOcah-adFCA@mail.gmail.com>
 <20200116085943.GA270346@krava>
In-Reply-To: <20200116085943.GA270346@krava>
From:   Brendan Gregg <bgregg@netflix.com>
Date:   Sun, 9 Feb 2020 20:43:17 -0800
Message-ID: <CAJN39ogSo=bEEydp7s34AjtDVwXxw7_hQFrARWE4NXQwRZxSxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v14 1/2] bpf: add new helper get_fd_path for
 mapping a file descriptor to a pathname
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Wenbo Zhang <ethercflow@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 16, 2020 at 12:59 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Dec 20, 2019 at 11:35:08AM +0800, Wenbo Zhang wrote:
> > > [ Wenbo, please keep also Al (added here) in the loop since he was providing
> > >    feedback on prior submissions as well wrt vfs bits. ]
> >
> > Get it, thank you!
>
> hi,
> is this stuck on review? I'd like to see this merged ;-)

Is this still waiting on someone? I'm writing some docs on analyzing
file systems via syscall tracing and this will be a big improvement.
Thanks,

Brendan

>
> we have bpftrace change using it already.. from that side:
>
> Tested-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>


-- 
Brendan Gregg, Senior Performance Architect, Netflix
