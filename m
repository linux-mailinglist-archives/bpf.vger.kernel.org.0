Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998201710F7
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 07:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgB0G2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 01:28:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41557 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgB0G2K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 01:28:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id b5so2091394qkh.8
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2020 22:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdY47TSluzc9LB1jFsLcgAx9Tu5FoybhF9FLp8u5Qp4=;
        b=VixjTcKUFyUdbAMYAfOH0ZtyfPvVg52S5ak5FhDhUM8Bq5XZH+vkLuqtSekfjtfljk
         QXJ8ccSDLxAYZGvPh8liWsoVnAul09C8OWeoN+IkKIhhzSSSTCX7eMfxkgQQ4G7MiaSc
         mv84+mAMpnboL9m6Qt2neiY6cGQUTMq6GOfK1uuPQ221j+yZ/hphMR9x9WYhb3zR6oqV
         VYSMRIIhIkNgv74RCAyYtcCe1AjF86eP4K1S/je9hi3sdFIL44cgLQsrIemUvd7k+gD1
         Bg3R6wrPdBOUi+vrIin8fgUTBRJFq69CvQQHM2Bidk4uoQBaib/K+JusLvtwaHJ6oLoR
         SNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdY47TSluzc9LB1jFsLcgAx9Tu5FoybhF9FLp8u5Qp4=;
        b=X9fzZVoch9nHoXqSP0vZx1fwcY75Ueo2rAZ5kK8JwGQoqwTqeIq/g+XtukA5TCK8lL
         nscu5hV08TOrMXNOTE54ZB2ZEMzeNiDa64K5Oto3f+LdSpoGWC3v8SS5H2Jnn5macGrV
         BNFvMSJHyWsh2gfoPG7alzwvZ7spbpCtHW+0ZQpSjIA05do9FepfhzfmffyUz9ANXlY1
         nJZbhH3d6uewrpQJH9VK+dsMHo5y7R0kpJVr8lSLEUcdgrCCnhwQ+aQevatLTOiCdI64
         U3j+UiR3GA7RA+FNMwJw1fngpdD1QpOrtYi8r8gc9HzfhqwL4ItC0a5CW6nxcGnb1Alu
         kdpA==
X-Gm-Message-State: APjAAAWJK6IXKuXT/90G9zp8ofJWwnI9lJDZlSB0Oj5edyOw+OuJO3TE
        KTuYpZ6pFONnJT2Lhn3+Eopl0R/3Tlw8bGzPI9QDovD+
X-Google-Smtp-Source: APXvYqxgRdCeX3eHnicPcJhgz6hUWl9g9IPOYZ1XwruARMN5jt8LKATKcNNXweZT3vb6OL7jSH60C5dCtzEUpKnc5Js=
X-Received: by 2002:a37:9104:: with SMTP id t4mr3884312qkd.449.1582784889840;
 Wed, 26 Feb 2020 22:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20200227023253.3445221-1-rdna@fb.com>
In-Reply-To: <20200227023253.3445221-1-rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Feb 2020 22:27:58 -0800
Message-ID: <CAEf4BzZo7rmZejxJCT-s3OSiYqMxzP71Q9Xg+x=WFN00Yca0Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, osandov@fb.com,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 26, 2020 at 6:33 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> drgn is a debugger that reads kernel memory and uses DWARF to get types
> and symbols. See [1], [2] and [3] for more details on drgn.
>
> Since drgn operates on kernel memory it has access to kernel internals
> that user space doesn't. It allows to get extended info about various
> kernel data structures.
>
> Introduce bpf.py drgn script to list BPF programs and maps and their
> properties unavailable to user space via kernel API.
>
> The main use-case bpf.py covers is to show BPF programs attached to
> other BPF programs via freplace/fentry/fexit mechanisms introduced
> recently. There is no user-space API to get this info and e.g. bpftool
> can only show all BPF programs but can't show if program A replaces a
> function in program B.
>
> Example:
>
>   % sudo tools/bpf/bpf.py p | grep test_pkt_access
>      650: BPF_PROG_TYPE_SCHED_CLS          test_pkt_access
>      654: BPF_PROG_TYPE_TRACING            test_main                        linked:[650->25: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access()]
>      655: BPF_PROG_TYPE_TRACING            test_subprog1                    linked:[650->29: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog1()]
>      656: BPF_PROG_TYPE_TRACING            test_subprog2                    linked:[650->31: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog2()]
>      657: BPF_PROG_TYPE_TRACING            test_subprog3                    linked:[650->21: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog3()]
>      658: BPF_PROG_TYPE_EXT                new_get_skb_len                  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]
>      659: BPF_PROG_TYPE_EXT                new_get_skb_ifindex              linked:[650->23: BPF_TRAMP_REPLACE test_pkt_access->get_skb_ifindex()]
>      660: BPF_PROG_TYPE_EXT                new_get_constant                 linked:[650->19: BPF_TRAMP_REPLACE test_pkt_access->get_constant()]
>
> It can be seen that there is a program test_pkt_access, id 650 and there
> are multiple other tracing and ext programs attached to functions in
> test_pkt_access.
>
> For example the line:
>
>      658: BPF_PROG_TYPE_EXT                new_get_skb_len                  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]
>
> means that BPF program new_get_skb_len, id 658, type BPF_PROG_TYPE_EXT
> replaces (BPF_TRAMP_REPLACE) function get_skb_len() that has BTF id 16
> in BPF program test_pkt_access, prog id 650.
>
> Just very simple output is supported now but it can be extended in the
> future if needed.
>
> The script is extendable and currently implements two subcommands:
> * prog (alias: p) to list all BPF programs;
> * map (alias: m) to list all BPF maps;
>
> Developer can simply tweak the script to print interesting pieces of programs
> or maps.
>
> The name bpf.py is not super authentic. I'm open to better options.

Just to throw another name into consideration: bpf_inspect.py?

>
> The script can be sent to drgn repo where it's easier to maintain its
> "drgn-ness", but in kernel tree it should be easier to maintain BPF
> functionality itself what can be more important in this case.

Unless it's regularly exercised as part of selftests, it will still break, IMO.


>
> The script depends on drgn revision [4] where BPF helpers were added.
>
> More examples of output:
>
>   % sudo tools/bpf/bpf.py p | shuf -n 3
>       81: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
>       94: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
>       43: BPF_PROG_TYPE_KPROBE             kprobe__tcp_reno_cong_avoid
>
>   % sudo tools/bpf/bpf.py m | shuf -n 3
>      213: BPF_MAP_TYPE_HASH                errors
>       30: BPF_MAP_TYPE_ARRAY               sslwall_setting
>       41: BPF_MAP_TYPE_LRU_HASH            flow_to_snd
>
> Help:
>
>   % sudo tools/bpf/bpf.py
>   usage: bpf.py [-h] {prog,p,map,m} ...
>
>   drgn script to list BPF programs or maps and their properties
>   unavailable via kernel API.
>
>   See https://github.com/osandov/drgn/ for more details on drgn.
>
>   optional arguments:
>     -h, --help      show this help message and exit
>
>   subcommands:
>     {prog,p,map,m}
>       prog (p)      list BPF programs
>       map (m)       list BPF maps
>
> [1] https://github.com/osandov/drgn/
> [2] https://drgn.readthedocs.io/en/latest/index.html
> [3] https://lwn.net/Articles/789641/
> [4] https://github.com/osandov/drgn/commit/c8ef841768032e36581d45648e42fc2a5489d8f2
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  tools/bpf/bpf.py | 149 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100755 tools/bpf/bpf.py
>

[...]
