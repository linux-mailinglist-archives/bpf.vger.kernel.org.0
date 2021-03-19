Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B14341462
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 05:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhCSEvu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 00:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCSEvg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 00:51:36 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B89C06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 21:51:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b10so4967810ybn.3
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 21:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ts9f0AgFK+wXxAOREkfbOJMBC8eA1EqKSeocw9pgy4Y=;
        b=i6oNoqa5BAriaj5GaARg/t/a4AjMy9SZtxqS61Pqp+6LhXKZ7A/hZQWMwxDWmLl1nx
         CXbRCJr3T672RjaApNyu/ZMbGE7/GOy16RjpoP4l6Rf2TVqmSdxIzj+hkS4Z74AaL+Li
         jpq1RozQOBrSMzI8pLgL78V185oZ+yDGstEVQFonvhmb3WrlBZsYgU/jVRN/4QzEZS9G
         M/PbhXlyS+/4B66Ty8o8L6ipgafcaMrjm2z1w3B3QdcSudxUFiAUGSIe+RHf3xftiWre
         UDwJ58sL60H2hmWiSynF2Fy3D41rKG6GYm4Y1/fIj0HykloSks+eviOVv2JlIPcqq/4R
         OIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ts9f0AgFK+wXxAOREkfbOJMBC8eA1EqKSeocw9pgy4Y=;
        b=prfAlmktVx7Nij9CNj1X0138UvHweRAfU7FAw3nkGQ5EtCOj+4RhyEwS0kTeg+9zc2
         Iml+hlDEReLwDfLqzzOu/U3xTqxqMC4BDmfwWzm+nXW+ag9w5JFhXIFbUunj548w1zP5
         U7SSulK/k5K4PCQTOh+RoasoNTDjoLIhrQVEkDCYHYDdjuEpU5XmDUeSnI0guSY6fMry
         qSZTZWM6Ot7/Q07giRXBzf4fXa2+iq38oEAPnfsW07+rnKCAAL0S21QjTm18IM/wi4ic
         jaYH2S//kYkBBaC3/U/hQMNBbNZx5/Y/hA9ZORzod4l6oCpw4rjyUQCUt9PTQYtvDMDh
         wmlA==
X-Gm-Message-State: AOAM533YAFbqSMnvddSrkOFgmw2/IArr63Oiz7J43Fn5z1H693aoUwzH
        G9oeon0e3RK+j2rvhLtEMfOPWAxEads40KOVTogBLnNPe2RrYQ==
X-Google-Smtp-Source: ABdhPJzjkJpDYiOAtCFqxHqAXDNw4n24csdlN/wMVpTn30tJYAAQjfXF+H/q7QHaiVEmixM2xGycKmtPJ/UZNCj6ogE=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr3755309yba.510.1616129495878;
 Thu, 18 Mar 2021 21:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com>
In-Reply-To: <20210318062520.3838605-1-rafaeldtinoco@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Mar 2021 21:51:25 -0700
Message-ID: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
Subject: Re: [RFC][PATCH] libbpf: support kprobe/kretprobe events in legacy environments
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 17, 2021 at 11:25 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
>  * Request for comments version (still needs polishing).
>  * Based on Andrii Nakryiko's suggestion.
>  * Using bpf_program__set_priv in attach_kprobe() for kprobe cleanup.

no-no-no, set_priv() is going to be deprecated and removed (see [0]),
and is not the right mechanism here. Detachment should happen in
bpf_link__destroy().

  [0] https://docs.google.com/document/d/1UyjTZuPFWiPFyKk1tV5an11_iaRuec6U-ZESZ54nNTY

>
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> ---
>  src/libbpf.c | 100 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 90 insertions(+), 10 deletions(-)
>
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 2f351d3..4dc09d3 100644
> --- a/src/libbpf.c
> +++ b/src/libbpf.c
> @@ -9677,8 +9677,14 @@ static int parse_uint_from_file(const char *file, const char *fmt)
>
>  static int determine_kprobe_perf_type(void)
>  {
> +       int ret = 0;
> +       struct stat s;
>         const char *file = "/sys/bus/event_source/devices/kprobe/type";
>
> +       ret = stat(file, &s);
> +       if (ret < 0)
> +               return -errno;
> +
>         return parse_uint_from_file(file, "%d\n");
>  }
>
> @@ -9703,25 +9709,87 @@ static int determine_uprobe_retprobe_bit(void)
>         return parse_uint_from_file(file, "config:%d\n");
>  }
>
> +static int determine_kprobe_perf_type_legacy(const char *func_name)
> +{
> +       char file[256];

nit: I suspect 256 is much longer than necessary :)


> +       const char *fname = "/sys/kernel/debug/tracing/events/kprobes/%s/id";
> +
> +       snprintf(file, sizeof(file), fname, func_name);
> +
> +       return parse_uint_from_file(file, "%d\n");
> +}
> +
> +static int poke_kprobe_events(bool add, const char *name, bool kretprobe)

it's probably a good idea to put a link to [0] somewhere here

  [0] https://www.kernel.org/doc/html/latest/trace/kprobetrace.html

> +{
> +       int fd, ret = 0;
> +       char given[256], buf[256];

nit: given -> event_name, to follow official documentation terminology ?

> +       const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> +
> +       if (kretprobe && add)

what if it's kretprobe removal? shouldn't you generate the same name


> +               snprintf(given, sizeof(given), "kprobes/%s_ret", name);
> +       else
> +               snprintf(given, sizeof(given), "kprobes/%s", name);

BCC includes PID in the name of the probe and "bcc", maybe we should
do something similar?

> +       if (add)
> +               snprintf(buf, sizeof(buf),"%c:%s %s\n", kretprobe ? 'r' : 'p', given, name);
> +       else
> +               snprintf(buf, sizeof(buf), "-:%s\n", given);
> +
> +       fd = open(file, O_WRONLY|O_APPEND, 0);
> +       if (!fd)
> +               return -errno;
> +       ret = write(fd, buf, strlen(buf));
> +       if (ret < 0) {
> +               ret = -errno;
> +       }
> +       close(fd);
> +
> +       return ret;
> +}
> +
> +static inline int add_kprobe_event_legacy(const char* func_name, bool kretprobe)
> +{
> +       return poke_kprobe_events(true /*add*/, func_name, kretprobe);
> +}
> +
> +static inline int remove_kprobe_event_legacy(const char* func_name, bool kretprobe)
> +{
> +       return poke_kprobe_events(false /*remove*/, func_name, kretprobe);
> +}
> +
>  static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>                                  uint64_t offset, int pid)
>  {
>         struct perf_event_attr attr = {};
>         char errmsg[STRERR_BUFSIZE];
>         int type, pfd, err;
> +       bool legacy = false;
>
>         type = uprobe ? determine_uprobe_perf_type()
>                       : determine_kprobe_perf_type();
>         if (type < 0) {

I think we should do "feature probing" to decide whether we should go
with legacy or modern kprobes. And just stick to that, reporting any
errors. I'm not a big fan of this generic "let's try X, if it fails
for *whatever* reason, let's try Y", because you 1) can ignore some
serious problem 2) you'll be getting unnecessary warnings in your log

> -               pr_warn("failed to determine %s perf type: %s\n",
> -                       uprobe ? "uprobe" : "kprobe",
> -                       libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
> -               return type;
> +               if (uprobe) {
> +                       pr_warn("failed to determine %s perf type: %s\n",
> +                               uprobe ? "uprobe" : "kprobe",
> +                               libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
> +                       return type;
> +               }
> +               err = add_kprobe_event_legacy(name, retprobe);
> +               if (err < 0) {
> +                       pr_warn("failed to add legacy kprobe events: %s\n",
> +                               libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +                       return err;
> +               }
> +               type = uprobe ? type : determine_kprobe_perf_type_legacy(name);
> +               if (type < 0) {
> +                       remove_kprobe_event_legacy(name, retprobe);
> +                       pr_warn("failed to determine kprobe perf type: %s\n",
> +                               libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
> +               }
> +               legacy = true;
>         }
> -       if (retprobe) {
> +       if (retprobe && !legacy) {
>                 int bit = uprobe ? determine_uprobe_retprobe_bit()
>                                  : determine_kprobe_retprobe_bit();
> -
>                 if (bit < 0) {
>                         pr_warn("failed to determine %s retprobe bit: %s\n",
>                                 uprobe ? "uprobe" : "kprobe",
> @@ -9731,10 +9799,14 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>                 attr.config |= 1 << bit;
>         }
>         attr.size = sizeof(attr);
> -       attr.type = type;
> -       attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
> -       attr.config2 = offset;           /* kprobe_addr or probe_offset */
> -
> +       if (!legacy) {
> +               attr.type = type;
> +               attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
> +               attr.config2 = offset;           /* kprobe_addr or probe_offset */
> +       } else {
> +               attr.config = type;
> +               attr.type = PERF_TYPE_TRACEPOINT;
> +       }
>         /* pid filter is meaningful only for uprobes */
>         pfd = syscall(__NR_perf_event_open, &attr,
>                       pid < 0 ? -1 : pid /* pid */,
> @@ -9750,6 +9822,11 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>         return pfd;
>  }
>
> +void bpf_program__detach_kprobe_legacy(struct bpf_program *prog, void *retprobe)
> +{
> +       remove_kprobe_event_legacy(prog->name, (bool) retprobe);
> +}

as I mentioned, this should be done by bpf_link__destroy()

> +
>  struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
>                                             bool retprobe,
>                                             const char *func_name)
> @@ -9766,6 +9843,9 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
>                         libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
>                 return ERR_PTR(pfd);
>         }
> +
> +       bpf_program__set_priv(prog, (void *) retprobe, bpf_program__detach_kprobe_legacy);
> +
>         link = bpf_program__attach_perf_event(prog, pfd);
>         if (IS_ERR(link)) {
>                 close(pfd);
> --
> 2.27.0
>
