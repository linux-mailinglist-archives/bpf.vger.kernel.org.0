Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C115112D8F
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2019 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfLDOiY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Dec 2019 09:38:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38761 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDOiY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Dec 2019 09:38:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so6331169lfm.5
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaJ3UPjj7Nz7m7Ne5I2c6eF0XwrYN5YcMxlYR5F12d0=;
        b=CkYEclAERJluqNRiWk/6SQLBRh08HruSEI11CNizs6wKIjdUEU3WfhdM33mH9iKiYi
         bD5yMl5BKrWPtNVtZTR+AuraXLQbmREHhnjVmEUORk0YBwaLb/3edS1Y4kLLe3cmN6bb
         rchDPAfHzqbv9xRUQ7YQ6bbtq7zibN2fo248c4NBbRjO3S/xwm5337Jr9ZJ4we3f0zmO
         M8sMUvVTxZ8DEwBHsy7Of99ZP6jXt2Re1A+oTfHluc8REuQo+LQYbnGkpMPdtDx6JzPu
         3a52DYvDB2m3vE0dMivlFC3CZP5opBHTtaxxHqmCk9WRuVn4Tq5lxU28LQeTD+emJO6R
         E66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaJ3UPjj7Nz7m7Ne5I2c6eF0XwrYN5YcMxlYR5F12d0=;
        b=m84lCPR0nZt0qdr0IYEyekmowmaOmBI16U2tN9MuhsXUdn3GD03fZTY7A7DyOoZqtL
         enl9sRE7K4M6yOdPNMNKM35GQBlCrJnJcDuWP2LQPs6Tj71qeiJaCeCWxv86K0G85hgU
         eV2+a/7Im9j0FCDUL+oW+gOF0kgZPBNr6j+M4uMq3yZH9NK8TKZ5kYKn4xW8RMGmnwl0
         BhbHQCECtX6HSwVM2Gmyv4sy/0Ma7XKDcDxuhcVcVDmgMuSkvO13w6kJprekG6g35gmw
         DIK8gNB5tgR8O1Sa4lYd8snKPLn3zz49BW3mJMMklc3o/TQ8b0gh5DdQHVmMsjd2w+77
         jN4w==
X-Gm-Message-State: APjAAAXE3MruMStpjowsQEwm2y2+0ZkwZnDtQJBYs+EKB4pLbTJlFjII
        GWMwCvW73vq7fyYuQbcJTHHu6KreA3Sz+I9hGuUN
X-Google-Smtp-Source: APXvYqw1BPiBASWC3NkdSGy61VyInQU9ytLgtR07luIoLsu3uzuX/jup0unpcNDRA+o4gAWrHaP+XNIyt6Ph544HwD0=
X-Received: by 2002:ac2:424d:: with SMTP id m13mr2261508lfl.13.1575470301379;
 Wed, 04 Dec 2019 06:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20191128091633.29275-1-jolsa@kernel.org> <CAHC9VhQ7zkXdz1V5hQ8PN68-NnCn56TjKA0wCL6ZjHy9Up8fuQ@mail.gmail.com>
 <20191203093837.GC17468@krava> <CAHC9VhRhMhsRPj1D2TY3O=Nc6Rx9=o1-Z5ZMjrCepfFY6VtdbQ@mail.gmail.com>
 <20191204140827.GB12431@krava>
In-Reply-To: <20191204140827.GB12431@krava>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Dec 2019 09:38:10 -0500
Message-ID: <CAHC9VhTrUQYp8Ubhu_B_fv-HSdwmgYRy+r1p9uKz7WcRfDQBKA@mail.gmail.com>
Subject: Re: [RFC] bpf: Emit audit messages upon successful prog load and unload
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-audit@redhat.com,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Steve Grubb <sgrubb@redhat.com>,
        David Miller <davem@redhat.com>,
        Eric Paris <eparis@redhat.com>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 4, 2019 at 9:08 AM Jiri Olsa <jolsa@redhat.com> wrote:
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index c89c6495983d..32a5db900f47 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -116,6 +116,7 @@
>  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
>  #define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
>  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> +#define AUDIT_BPF              1334    /* BPF subsystem */
>
>  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e3461ec59570..81f1a6308aa8 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -23,6 +23,7 @@
>  #include <linux/timekeeping.h>
>  #include <linux/ctype.h>
>  #include <linux/nospec.h>
> +#include <linux/audit.h>
>  #include <uapi/linux/btf.h>
>
>  #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
> @@ -1306,6 +1307,33 @@ static int find_prog_type(enum bpf_prog_type type, struct bpf_prog *prog)
>         return 0;
>  }
>
> +enum bpf_audit {
> +       BPF_AUDIT_LOAD,
> +       BPF_AUDIT_UNLOAD,
> +};
> +
> +static const char * const bpf_audit_str[] = {
> +       [BPF_AUDIT_LOAD]   = "LOAD",
> +       [BPF_AUDIT_UNLOAD] = "UNLOAD",
> +};
> +
> +static void bpf_audit_prog(const struct bpf_prog *prog, enum bpf_audit op)
> +{
> +       struct audit_context *ctx = NULL;
> +       struct audit_buffer *ab;
> +
> +       if (audit_enabled == AUDIT_OFF)
> +               return;
> +       if (op == BPF_AUDIT_LOAD)
> +               ctx = audit_context();
> +       ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
> +       if (unlikely(!ab))
> +               return;
> +       audit_log_format(ab, "prog-id=%u op=%s",
> +                        prog->aux->id, bpf_audit_str[op]);
> +       audit_log_end(ab);
> +}

As mentioned previously, I still think it might be a good idea to
ensure "op" is within the bounds of bpf_audit_str, but the audit bits
look reasonable to me.

>  int __bpf_prog_charge(struct user_struct *user, u32 pages)
>  {
>         unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> @@ -1421,6 +1449,7 @@ static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
>  {
>         if (atomic64_dec_and_test(&prog->aux->refcnt)) {
>                 perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
> +               bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
>                 /* bpf_prog_free_id() must be called first */
>                 bpf_prog_free_id(prog, do_idr_lock);
>                 __bpf_prog_put_noref(prog, true);
> @@ -1830,6 +1859,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
>          */
>         bpf_prog_kallsyms_add(prog);
>         perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
> +       bpf_audit_prog(prog, BPF_AUDIT_LOAD);
>
>         err = bpf_prog_new_fd(prog);
>         if (err < 0)
> --
> 2.23.0

-- 
paul moore
www.paul-moore.com
