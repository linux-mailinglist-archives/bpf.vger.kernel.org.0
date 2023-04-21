Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD36EB2F3
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDUUgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjDUUgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 16:36:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C01FD8
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:36:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so15456425a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682109364; x=1684701364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9C4iRAcHxYd3hTzygx6aqYfgA855/t2qm3XPVVp39o8=;
        b=L4hQX8EchWvSHb3lt9++Z5AcKsWCXy9ODc8Rs8hEPPRiZKa+nOLzWWIKd3EDCnCiHR
         ovSHT6mJNtgqMIhyPr8YlyLsyk5hTHkVMiF89Fsd98GVp4FSIqs2M/4vHk5mbI1IXb1D
         TQqGadzpHoN7puFfAdfWJvLHPpg65wxJoI0Ro0F80dZLrR+qzwP7XkFcNu1miGFwDypm
         cztd4IWF+/hW/UDzTpUY0UrIyWC3om+7hg7QkgXYLxRWYKTJXOEWAKvXoMqKah7ZPooy
         /HiIQX/cZlyJuKqP6Pv2tpNE7S9u5vIOwO+fZOFpzfSumEj/oihqHz9uaD0LpSMvbyyz
         mdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682109364; x=1684701364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9C4iRAcHxYd3hTzygx6aqYfgA855/t2qm3XPVVp39o8=;
        b=atNvUx8k4aw0A5oNKcUF3RVvfgWyOopm5ccTys7d1kOV/VnkH9L87shDK9kEE4Zd9S
         fhUdrZOk3HaNpjeHsaPISzs3112gBrb85MP6kyGE9Gy2ialGcYZiuxvAHYc/lzJ5jbVH
         VGVzKz4nlKYKCqDHtnnlZGI27BmoR4+UzX+ZdbQyHnZXnW9DaPXwcq+7MtOqq++nJuMW
         K7iginVCTpt1Nl8OMBGr9PDTVVX+29ZEFUv+g2QAiDDaz5soHktptBr4+7aurNqi1NDp
         fURalS9Hz6Fcq78nYIJWRM+iepc5AVSJZB6eaJy6/ZVozjwku3a+ICvVnewb1QO6rIC6
         5V5A==
X-Gm-Message-State: AAQBX9eF8sL76HSFU42Wimn40ckQ9EEMRCBaMCCooU7RvgmaH9s7sf00
        qFlJli5eoZkBrJ/FpQFeOxybbujy6yicu1QVQgQpqw==
X-Google-Smtp-Source: AKy350YawkIoWe+TmMCDYIhNAzy8JBMRQHBnFpv50X3s6g26p3NePwEt5L63FX1jiY+C+/VlZro1TBonZN/Aqswe6U0=
X-Received: by 2002:a05:6402:11c7:b0:4fc:97d9:18ec with SMTP id
 j7-20020a05640211c700b004fc97d918ecmr9427739edw.21.1682109363800; Fri, 21 Apr
 2023 13:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com> <20230421162718.440230-9-daan.j.demeyer@gmail.com>
In-Reply-To: <20230421162718.440230-9-daan.j.demeyer@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 21 Apr 2023 21:35:52 +0100
Message-ID: <CACdoK4LKy8dtESERkQjCN-+QO6NyPUkKkkz+6veQfk9V=9S1xQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/10] bpftool: Add support for cgroup unix
 socket address hooks
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 21 Apr 2023 at 17:31, Daan De Meyer <daan.j.demeyer@gmail.com> wrote:
>
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
>
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  .../bpftool/Documentation/bpftool-cgroup.rst  | 21 ++++++++++++++-----
>  tools/bpf/bpftool/cgroup.c                    | 17 ++++++++-------
>  tools/bpf/bpftool/common.c                    |  6 ++++++
>  3 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index bd015ec9847b..a2d990fa623b 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> @@ -34,13 +34,16 @@ CGROUP COMMANDS
>  |      *ATTACH_TYPE* := { **cgroup_inet_ingress** | **cgroup_inet_egress** |
>  |              **cgroup_inet_sock_create** | **cgroup_sock_ops** |
>  |              **cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
> -|              **cgroup_inet4_post_bind** | **cgroup_inet6_post_bind** |
> -|              **cgroup_inet4_connect** | **cgroup_inet6_connect** |
> +|              **cgroup_unix_bind** | **cgroup_inet4_post_bind** |
> +|              **cgroup_inet6_post_bind** | **cgroup_inet4_connect** |
> +|              **cgroup_inet6_connect** | **cgroup_unix_connect** |
>  |              **cgroup_inet4_getpeername** | **cgroup_inet6_getpeername** |
> -|              **cgroup_inet4_getsockname** | **cgroup_inet6_getsockname** |
> -|              **cgroup_udp4_sendmsg** | **cgroup_udp6_sendmsg** |
> +|              **cgroup_unix_getpeername** | **cgroup_inet4_getsockname** |
> +|              **cgroup_inet6_getsockname** | **cgroup_udp4_sendmsg** |
> +|              **cgroup_udp6_sendmsg** | **cgroup_unix_sendmsg** |
>  |              **cgroup_udp4_recvmsg** | **cgroup_udp6_recvmsg** |
> -|              **cgroup_sysctl** | **cgroup_getsockopt** | **cgroup_setsockopt** |
> +|              **cgroup_unix_recvmsg** | **cgroup_sysctl** |
> +|              **cgroup_getsockopt** | **cgroup_setsockopt** |
>  |              **cgroup_inet_sock_release** }
>  |      *ATTACH_FLAGS* := { **multi** | **override** }
>
> @@ -98,25 +101,33 @@ DESCRIPTION
>                   **device** device access (since 4.15);
>                   **bind4** call to bind(2) for an inet4 socket (since 4.17);
>                   **bind6** call to bind(2) for an inet6 socket (since 4.17);
> +                 **bindun** call to bind(2) for a unix socket (since 6.3);
>                   **post_bind4** return from bind(2) for an inet4 socket (since 4.17);
>                   **post_bind6** return from bind(2) for an inet6 socket (since 4.17);
>                   **connect4** call to connect(2) for an inet4 socket (since 4.17);
>                   **connect6** call to connect(2) for an inet6 socket (since 4.17);
> +                 **connectun** call to connect(2) for a unix socket (since 6.3);
>                   **sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an
>                   unconnected udp4 socket (since 4.18);
>                   **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
>                   unconnected udp6 socket (since 4.18);
> +                 **sendmsgun** call to sendto(2), sendmsg(2), sendmmsg(2) for
> +                 an unconnected unix socket (since 6.3);
>                   **recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
>                   an unconnected udp4 socket (since 5.2);
>                   **recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
>                   an unconnected udp6 socket (since 5.2);
> +                 **recvmsgun** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
> +                 an unconnected unix socket (since 6.3);
>                   **sysctl** sysctl access (since 5.2);
>                   **getsockopt** call to getsockopt (since 5.3);
>                   **setsockopt** call to setsockopt (since 5.3);
>                   **getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
>                   **getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
> +                 **getpeernameun** call to getpeername(2) for a unix socket (since 6.3);
>                   **getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
>                   **getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
> +                 **getsocknameun** call to getsockname(2) for a unix socket (since 6.3);
>                   **sock_release** closing an userspace inet socket (since 5.9).
>
>         **bpftool cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index ac846b0805b4..a9700e00064c 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -26,13 +26,16 @@
>         "       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
>         "                        cgroup_inet_sock_create | cgroup_sock_ops |\n" \
>         "                        cgroup_device | cgroup_inet4_bind |\n" \
> -       "                        cgroup_inet6_bind | cgroup_inet4_post_bind |\n" \
> -       "                        cgroup_inet6_post_bind | cgroup_inet4_connect |\n" \
> -       "                        cgroup_inet6_connect | cgroup_inet4_getpeername |\n" \
> -       "                        cgroup_inet6_getpeername | cgroup_inet4_getsockname |\n" \
> -       "                        cgroup_inet6_getsockname | cgroup_udp4_sendmsg |\n" \
> -       "                        cgroup_udp6_sendmsg | cgroup_udp4_recvmsg |\n" \
> -       "                        cgroup_udp6_recvmsg | cgroup_sysctl |\n" \
> +       "                        cgroup_inet6_bind | cgroup_unix_bind |\n" \
> +       "                        cgroup_inet4_post_bind | cgroup_inet6_post_bind |\n" \
> +       "                        cgroup_inet4_connect | cgroup_inet6_connect |\n" \
> +       "                        cgroup_unix_connect | cgroup_inet4_getpeername |\n" \
> +       "                        cgroup_inet6_getpeername | cgroup_unix_getpeername |\n" \
> +       "                        cgroup_inet4_getsockname | cgroup_inet6_getsockname |\n" \
> +       "                        cgroup_unix_getsockname | cgroup_udp4_sendmsg |\n" \
> +       "                        cgroup_udp6_sendmsg | cgroup_unix_sendmsg |\n" \
> +       "                        cgroup_udp4_recvmsg | cgroup_udp6_recvmsg |\n" \
> +       "                        cgroup_unix_recvmsg | cgroup_sysctl |\n" \
>         "                        cgroup_getsockopt | cgroup_setsockopt |\n" \
>         "                        cgroup_inet_sock_release }"
>
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 5a73ccf14332..71c219b186aa 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -1067,19 +1067,25 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>         case BPF_CGROUP_DEVICE:                 return "device";
>         case BPF_CGROUP_INET4_BIND:             return "bind4";
>         case BPF_CGROUP_INET6_BIND:             return "bind6";
> +       case BPF_CGROUP_UNIX_BIND:              return "bindun";
>         case BPF_CGROUP_INET4_CONNECT:          return "connect4";
>         case BPF_CGROUP_INET6_CONNECT:          return "connect6";
> +       case BPF_CGROUP_UNIX_CONNECT:           return "connectun";
>         case BPF_CGROUP_INET4_POST_BIND:        return "post_bind4";
>         case BPF_CGROUP_INET6_POST_BIND:        return "post_bind6";
>         case BPF_CGROUP_INET4_GETPEERNAME:      return "getpeername4";
>         case BPF_CGROUP_INET6_GETPEERNAME:      return "getpeername6";
> +       case BPF_CGROUP_UNIX_GETPEERNAME:       return "getpeernameun";
>         case BPF_CGROUP_INET4_GETSOCKNAME:      return "getsockname4";
>         case BPF_CGROUP_INET6_GETSOCKNAME:      return "getsockname6";
> +       case BPF_CGROUP_UNIX_GETSOCKNAME:       return "getsocknameun";
>         case BPF_CGROUP_UDP4_SENDMSG:           return "sendmsg4";
>         case BPF_CGROUP_UDP6_SENDMSG:           return "sendmsg6";
> +       case BPF_CGROUP_UNIX_SENDMSG:           return "sendmsgun";
>         case BPF_CGROUP_SYSCTL:                 return "sysctl";
>         case BPF_CGROUP_UDP4_RECVMSG:           return "recvmsg4";
>         case BPF_CGROUP_UDP6_RECVMSG:           return "recvmsg6";
> +       case BPF_CGROUP_UNIX_RECVMSG:           return "recvmsgun";
>         case BPF_CGROUP_GETSOCKOPT:             return "getsockopt";
>         case BPF_CGROUP_SETSOCKOPT:             return "setsockopt";
>         case BPF_TRACE_RAW_TP:                  return "raw_tp";
> --
> 2.40.0
>

Thanks a lot for this! I have two comments.

First, function bpf_attach_type_input_str() is for legacy attach types
names, those that bpftool used before commit 1ba5ad36e00f ("bpftool:
Use libbpf_bpf_attach_type_str") and that are kept for backwards
compatibility. Now we use type names provided by libbpf, so adding
them to attach_type_name in libbpf as you do in patch 7 should be
enough for bpftool to pick up the relevant names. The
bpftool-cgroup.rst man page still uses the legacy names, which I
didn't realise before your patch, and I'll need to fix. But for this
patch I think we're good without adding alternative names, and by
documenting the "cgroup/bindun" etc. forms in the man page.

Another thing is that you updated the list of types to attach programs
to cgroups, which is good, but ideally we would also need to document
the new program "types" that we can pass on the command line to
bpftool for loading programs, before attaching them (for example, we
have "bpftool prog load <elf.o> </pinned/path> type cgroup/connect4").
This means updating do_help() in prog.c, the list in
Documentation/bpftool-prog.rst, and BPFTOOL_PROG_LOAD_TYPES in
bash-completion/bpftool. Could you please update them too?

Thanks,
Quentin
