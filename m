Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF26129BD7
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 00:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLWXgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 18:36:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45424 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLWXgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Dec 2019 18:36:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so14771668qkl.12
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2019 15:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PIEl0W3YqkayF4aVAyM4Q/zjcC492IxXecKjjkaSIE=;
        b=Wa5kG456+aJSZLqcpbLkhNKicLmriPlJDBwQX/ez18q4fPuPlwLi3/dNlDhF6wvlsp
         WvarmdkDjWgF4jz4zUcZ5Ugd6QIs07an8WOYGL6YXeTpacazgW89tDBgiKM3qPu48x/j
         nffR0Taci5TalarUZyGGTMl/uG6zsNnNJbi4/8oJHaNTI2JMngfcHseyGqjreWN7DjTl
         WXffqzCPGTbx0K5sLNsUbdzuZTsueHc6sJmymBxkVX2H9khwDgdrYQxw2/nFHGDc5El3
         TgJ5MRHTA+tVp2QcoJXhovJKVgKqUo9OkSuh+9+F+dUPhUrc7iGo1rcyLKiq/JQVyr9C
         nKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PIEl0W3YqkayF4aVAyM4Q/zjcC492IxXecKjjkaSIE=;
        b=r+z1VeNB8qtdN9xkyy73KiYzMrB/18rAAyM49srDNnLOiRA4zseINLxeqCk4UMSoBV
         2EaqbgrZPYBGWCw9Egim7cZQFro7Tsl3h35pWf/smkX40ogtX4Eg612+zzNXb3EENn4f
         gYJsL7mMAwfcxwDaKMktCd1RC3ttYsk0uzKGX14/qVLhO0RmMhcU1G0igLs4J5FZ47gn
         GukD0aEAJr1APF0SIoCG4ZWCH4LdI4LMlYOe5C5XRv0e3FM5nB9F+tU39EXaLZonUz8z
         ZmnIrkGtxvQBJ8mcqidDGIYL0Qbp1xHGssG4i+Y1VdA3bSqdB1c/62w+YBum8Df6/lua
         pw2A==
X-Gm-Message-State: APjAAAXPt1TVpNMTEjeFC8UZhBtnRHAfQnI/JK9wWJDgqBQ2NXOX/c8P
        UszddtCh1OevDsYcSWiXpJ+bAW78yc4NPiK7wjo=
X-Google-Smtp-Source: APXvYqz1IaAztsN7jz//8FSFscUfOtHMdJsTCr4f5GI70vw8+rxkQKvNnzOjagctO0pfBXrairTR4y7QKcFn5kMER1k=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr29014059qkj.36.1577144212207;
 Mon, 23 Dec 2019 15:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20191220230301.888477-1-hechaol@fb.com>
In-Reply-To: <20191220230301.888477-1-hechaol@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 15:36:41 -0800
Message-ID: <CAEf4BzZoUrRFd00Q_txVXt0e6=Ew5M9QiyaUnqvSg9JpBJSVMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Print error message for bpftool cgroup show
To:     Hechao Li <hechaol@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrey Ignatov <rdna@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 3:04 PM Hechao Li <hechaol@fb.com> wrote:
>

For next revision, please don't forget to add "PATCH" in patch prefix.
So you'll have: [PATCH v2 bpf-next] <subject here> for you v2.


> Currently, when bpftool cgroup show <path> has an error, no error
> message is printed. This is confusing because the user may think the
> result is empty.
>
> Before the change:
>
> $ bpftool cgroup show /sys/fs/cgroup
> ID       AttachType      AttachFlags     Name
> $ echo $?
> 255
>
> After the change:
> $ ./bpftool cgroup show /sys/fs/cgroup
> Error: can't query bpf programs attached to /sys/fs/cgroup: Operation
> not permitted
>
> Signed-off-by: Hechao Li <hechaol@fb.com>
> ---
>  tools/bpf/bpftool/cgroup.c | 60 ++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 1ef45e55039e..74b57e2d7524 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -117,6 +117,28 @@ static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
>         return prog_cnt;
>  }
>
> +#define QUERY_CGROUP_ERR (-1)
> +#define QUERY_CGROUP_NO_PROG (0)
> +#define QUERY_CGROUP_SUCCESS (1)
> +static int check_query_cgroup_progs(int cgroup_fd)
> +{

How about calling it a bit differently and use typical bool + error
return values. E.g., "cgroup_has_attached_progs" (or something along
those lines), then 1 means "true, it has", 0 means "false, doesn't
have any BPF progs", <0 means error, as usual. No need for special
QUERY* constants.

> +       enum bpf_attach_type type;
> +       bool no_prog = true;
> +
> +       for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> +               int count = count_attached_bpf_progs(cgroup_fd, type);
> +
> +               if (count < 0 && errno != EINVAL)
> +                       return QUERY_CGROUP_ERR;
> +
> +               if (count > 0) {
> +                       no_prog = false;
> +                       break;
> +               }
> +       }
> +
> +       return no_prog ? QUERY_CGROUP_NO_PROG : QUERY_CGROUP_SUCCESS;
> +}
>  static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
>                                    int level)
>  {
> @@ -162,6 +184,7 @@ static int do_show(int argc, char **argv)
>  {
>         enum bpf_attach_type type;
>         const char *path;
> +       int query_check;
>         int cgroup_fd;
>         int ret = -1;
>
> @@ -192,6 +215,16 @@ static int do_show(int argc, char **argv)
>                 goto exit;

you just removed exit label below, this causes compilation error here

>         }
>
> +       query_check = check_query_cgroup_progs(cgroup_fd);
> +       if (query_check == QUERY_CGROUP_ERR) {
> +               p_err("can't query bpf programs attached to %s: %s",
> +                     path, strerror(errno));
> +               goto exit_cgroup;
> +       } else if (query_check == QUERY_CGROUP_NO_PROG) {
> +               ret = 0;
> +               goto exit_cgroup;
> +       }
> +

[...]
