Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5A2C60C4
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 09:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgK0IVU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 03:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgK0IVT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 03:21:19 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5CC0613D1;
        Fri, 27 Nov 2020 00:21:18 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id h19so4038312otr.1;
        Fri, 27 Nov 2020 00:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iG4alASmrH3kVxjB7U4YGxSIqSNZ2Yih/tZwGwkdH38=;
        b=dvYQEXW5MCmeXBWMjf+CqdCptKWqLncbbUonTLw6tF01+Znl9cRJ343ntV7f7cdRzT
         d0+NY4TUX0GmGDSTSUSkq0f0yFOEGo3MtvFlIDw/vqD8cazl2Z6Zt8JWoE3ZjxQri2E6
         pjmccRaKIBGs8dROnIetWUcPa7yMU4eebmwlPxM3SC1uKjFsABfcX+vm2o57poyaVR1R
         xFazjyECVUyvy9uttopTZjCiNFM6dGRl2/Q9ESpdkvc31AjQ3/j0PBAsOXHzsMDEwxEK
         a2SzEwcdddnaQyc0nfEXNk939RZHXxtElTOtBtM1KwQ2g24tBhgfo56KyoB/ezgv1yR6
         THXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iG4alASmrH3kVxjB7U4YGxSIqSNZ2Yih/tZwGwkdH38=;
        b=uhIWDFOrJEdDMkDNeprwLBpzvGjiXHPy6P8Rx6PzRJyGzsPcIhqZAeqiYXbvKaIjov
         +Wns+dehOUzbschc2SiNnMaIw6NChBtbvnU0f2P1jhvyLIqWvWONyvF7adj9ph+jMVAx
         HoDpJ33QWNKCXE5jxHpuPmVfZNE8gdwEsmbHEzAR2jZTUO3ldb7xTEYQxsDQvamhbUVT
         tpeRBqp6cNbth4HnVvjTWFjlIeKzAoLmq26jpml+fqXi0NwcCnk0ghkiVNlbKADdSO7h
         6emIlIrZl5Z3Ku1/q6pEaAFe2K3dZQw/o+Vy+L6Ml6nKNxBWjsM0Iu/FYRlZv9cw2CUj
         2BOw==
X-Gm-Message-State: AOAM5331/PxH3oCrK9L8QNJKZmJDhcUTFCYDzPTzZf1PY1JuMIL0mmsi
        vwuPseCeC9lP5ow9MEb+YQNoSx8nTNuf8oPAbgw=
X-Google-Smtp-Source: ABdhPJx1wxnUfmJDJuZ+3b8SDvgLcMCgmIB6eCKz7+6GSbEh0Js+UoDXBWoYfsGpL/8UpqRH/DIdRCt4oNh6vEXKNBs=
X-Received: by 2002:a9d:3e6:: with SMTP id f93mr5074520otf.340.1606465276808;
 Fri, 27 Nov 2020 00:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20201126092248.6192-1-mariuszx.dudek@intel.com>
 <20201126092248.6192-3-mariuszx.dudek@intel.com> <CAJ8uoz02TkAKUWgDTj7JC=u05gorKBj0duPjC8x9a1aHpGPYig@mail.gmail.com>
In-Reply-To: <CAJ8uoz02TkAKUWgDTj7JC=u05gorKBj0duPjC8x9a1aHpGPYig@mail.gmail.com>
From:   Mariusz Dudek <mariusz.dudek@gmail.com>
Date:   Fri, 27 Nov 2020 09:21:05 +0100
Message-ID: <CADm5B_MhtPOZ4wZBHhW4aHyLBogEEBOkb1=H-kWZ4qrYzV0Bug@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] samples/bpf: sample application for eBPF
 load and socket creation split
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Mariusz Dudek <mariuszx.dudek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 8:38 AM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Thu, Nov 26, 2020 at 12:10 PM <mariusz.dudek@gmail.com> wrote:
> >
> > From: Mariusz Dudek <mariuszx.dudek@intel.com>
> >
> > Introduce a sample program to demonstrate the control and data
> > plane split. For the control plane part a new program called
> > xdpsock_ctrl_proc is introduced. For the data plane part, some code
> > was added to xdpsock_user.c to act as the data plane entity.
> >
> > Application xdpsock_ctrl_proc works as control entity with sudo
> > privileges (CAP_SYS_ADMIN and CAP_NET_ADMIN are sufficient) and the
> > extended xdpsock as data plane entity with CAP_NET_RAW capability
> > only.
> >
> > Usage example:
> >
> > sudo ./samples/bpf/xdpsock_ctrl_proc -i <interface>
> >
> > sudo ./samples/bpf/xdpsock -i <interface> -q <queue_id>
> >         -n <interval> -N -l -R
> >
> > Signed-off-by: Mariusz Dudek <mariuszx.dudek@intel.com>
> > ---
> >  samples/bpf/Makefile            |   4 +-
> >  samples/bpf/xdpsock.h           |   8 ++
> >  samples/bpf/xdpsock_ctrl_proc.c | 187 ++++++++++++++++++++++++++++++++
> >  samples/bpf/xdpsock_user.c      | 146 +++++++++++++++++++++++--
> >  4 files changed, 335 insertions(+), 10 deletions(-)
> >  create mode 100644 samples/bpf/xdpsock_ctrl_proc.c
>
> Thank you for this patch set Mariusz. Really appreciated!
>
> Everything looks good, but you are in a bit of a bad luck. This patch
> does not apply anymore to the Makefile, so please rebase it on latest
> and resend. I will then ack it.
>
> Thank you for all your efforts.
I will fix that
>
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index aeebf5d12f32..8fb8be1c0144 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -48,6 +48,7 @@ tprogs-y += syscall_tp
> >  tprogs-y += cpustat
> >  tprogs-y += xdp_adjust_tail
> >  tprogs-y += xdpsock
> > +tprogs-y += xdpsock_ctrl_proc
> >  tprogs-y += xsk_fwd
> >  tprogs-y += xdp_fwd
> >  tprogs-y += task_fd_query
> > @@ -105,6 +106,7 @@ syscall_tp-objs := syscall_tp_user.o
> >  cpustat-objs := cpustat_user.o
> >  xdp_adjust_tail-objs := xdp_adjust_tail_user.o
> >  xdpsock-objs := xdpsock_user.o
> > +xdpsock_ctrl_proc-objs := xdpsock_ctrl_proc.o
> >  xsk_fwd-objs := xsk_fwd.o
> >  xdp_fwd-objs := xdp_fwd_user.o
> >  task_fd_query-objs := bpf_load.o task_fd_query_user.o $(TRACE_HELPERS)
> > @@ -204,7 +206,7 @@ TPROGLDLIBS_tracex4         += -lrt
> >  TPROGLDLIBS_trace_output       += -lrt
> >  TPROGLDLIBS_map_perf_test      += -lrt
> >  TPROGLDLIBS_test_overhead      += -lrt
> > -TPROGLDLIBS_xdpsock            += -pthread
> > +TPROGLDLIBS_xdpsock            += -pthread -lcap
> >  TPROGLDLIBS_xsk_fwd            += -pthread
> >
> >  # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
> > diff --git a/samples/bpf/xdpsock.h b/samples/bpf/xdpsock.h
> > index b7eca15c78cc..fd70cce60712 100644
> > --- a/samples/bpf/xdpsock.h
> > +++ b/samples/bpf/xdpsock.h
> > @@ -8,4 +8,12 @@
> >
> >  #define MAX_SOCKS 4
> >
> > +#define SOCKET_NAME "sock_cal_bpf_fd"
> > +#define MAX_NUM_OF_CLIENTS 10
> > +
> > +#define CLOSE_CONN  1
> > +
> > +typedef __u64 u64;
> > +typedef __u32 u32;
> > +
> >  #endif /* XDPSOCK_H */
> > diff --git a/samples/bpf/xdpsock_ctrl_proc.c b/samples/bpf/xdpsock_ctrl_proc.c
> > new file mode 100644
> > index 000000000000..384e62e3c6d6
> > --- /dev/null
> > +++ b/samples/bpf/xdpsock_ctrl_proc.c
> > @@ -0,0 +1,187 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2017 - 2018 Intel Corporation. */
> > +
> > +#include <errno.h>
> > +#include <getopt.h>
> > +#include <libgen.h>
> > +#include <net/if.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/socket.h>
> > +#include <sys/un.h>
> > +#include <unistd.h>
> > +
> > +#include <bpf/bpf.h>
> > +#include <bpf/xsk.h>
> > +#include "xdpsock.h"
> > +
> > +static const char *opt_if = "";
> > +
> > +static struct option long_options[] = {
> > +       {"interface", required_argument, 0, 'i'},
> > +       {0, 0, 0, 0}
> > +};
> > +
> > +static void usage(const char *prog)
> > +{
> > +       const char *str =
> > +               "  Usage: %s [OPTIONS]\n"
> > +               "  Options:\n"
> > +               "  -i, --interface=n    Run on interface n\n"
> > +               "\n";
> > +       fprintf(stderr, "%s\n", str);
> > +
> > +       exit(0);
> > +}
> > +
> > +static void parse_command_line(int argc, char **argv)
> > +{
> > +       int option_index, c;
> > +
> > +       opterr = 0;
> > +
> > +       for (;;) {
> > +               c = getopt_long(argc, argv, "i:",
> > +                               long_options, &option_index);
> > +               if (c == -1)
> > +                       break;
> > +
> > +               switch (c) {
> > +               case 'i':
> > +                       opt_if = optarg;
> > +                       break;
> > +               default:
> > +                       usage(basename(argv[0]));
> > +               }
> > +       }
> > +}
> > +
> > +static int send_xsks_map_fd(int sock, int fd)
> > +{
> > +       char cmsgbuf[CMSG_SPACE(sizeof(int))];
> > +       struct msghdr msg;
> > +       struct iovec iov;
> > +       int value = 0;
> > +
> > +       if (fd == -1) {
> > +               fprintf(stderr, "Incorrect fd = %d\n", fd);
> > +               return -1;
> > +       }
> > +       iov.iov_base = &value;
> > +       iov.iov_len = sizeof(int);
> > +
> > +       msg.msg_name = NULL;
> > +       msg.msg_namelen = 0;
> > +       msg.msg_iov = &iov;
> > +       msg.msg_iovlen = 1;
> > +       msg.msg_flags = 0;
> > +       msg.msg_control = cmsgbuf;
> > +       msg.msg_controllen = CMSG_LEN(sizeof(int));
> > +
> > +       struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
> > +
> > +       cmsg->cmsg_level = SOL_SOCKET;
> > +       cmsg->cmsg_type = SCM_RIGHTS;
> > +       cmsg->cmsg_len = CMSG_LEN(sizeof(int));
> > +
> > +       *(int *)CMSG_DATA(cmsg) = fd;
> > +       int ret = sendmsg(sock, &msg, 0);
> > +
> > +       if (ret == -1) {
> > +               fprintf(stderr, "Sendmsg failed with %s", strerror(errno));
> > +               return -errno;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +int
> > +main(int argc, char **argv)
> > +{
> > +       struct sockaddr_un server;
> > +       int listening = 1;
> > +       int rval, msgsock;
> > +       int ifindex = 0;
> > +       int flag = 1;
> > +       int cmd = 0;
> > +       int sock;
> > +       int err;
> > +       int xsks_map_fd;
> > +
> > +       parse_command_line(argc, argv);
> > +
> > +       ifindex = if_nametoindex(opt_if);
> > +       if (ifindex == 0) {
> > +               fprintf(stderr, "Unable to get ifindex for Interface %s. Reason:%s",
> > +                       opt_if, strerror(errno));
> > +               return -errno;
> > +       }
> > +
> > +       sock = socket(AF_UNIX, SOCK_STREAM, 0);
> > +       if (sock < 0) {
> > +               fprintf(stderr, "Opening socket stream failed: %s", strerror(errno));
> > +               return -errno;
> > +       }
> > +
> > +       server.sun_family = AF_UNIX;
> > +       strcpy(server.sun_path, SOCKET_NAME);
> > +
> > +       setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(int));
> > +
> > +       if (bind(sock, (struct sockaddr *)&server, sizeof(struct sockaddr_un))) {
> > +               fprintf(stderr, "Binding to socket stream failed: %s", strerror(errno));
> > +               return -errno;
> > +       }
> > +
> > +       listen(sock, MAX_NUM_OF_CLIENTS);
> > +
> > +       err = xsk_setup_xdp_prog(ifindex, &xsks_map_fd);
> > +       if (err) {
> > +               fprintf(stderr, "Setup of xdp program failed\n");
> > +               goto close_sock;
> > +       }
> > +
> > +       while (listening) {
> > +               msgsock = accept(sock, 0, 0);
> > +               if (msgsock == -1) {
> > +                       fprintf(stderr, "Error accepting connection: %s", strerror(errno));
> > +                       err = -errno;
> > +                       goto close_sock;
> > +               }
> > +               err = send_xsks_map_fd(msgsock, xsks_map_fd);
> > +               if (err <= 0) {
> > +                       fprintf(stderr, "Error %d sending xsks_map_fd\n", err);
> > +                       goto cleanup;
> > +               }
> > +               do {
> > +                       rval = read(msgsock, &cmd, sizeof(int));
> > +                       if (rval < 0) {
> > +                               fprintf(stderr, "Error reading stream message");
> > +                       } else {
> > +                               if (cmd != CLOSE_CONN)
> > +                                       fprintf(stderr, "Recv unknown cmd = %d\n", cmd);
> > +                               listening = 0;
> > +                               break;
> > +                       }
> > +               } while (rval > 0);
> > +       }
> > +       close(msgsock);
> > +       close(sock);
> > +       unlink(SOCKET_NAME);
> > +
> > +       /* Unset fd for given ifindex */
> > +       err = bpf_set_link_xdp_fd(ifindex, -1, 0);
> > +       if (err) {
> > +               fprintf(stderr, "Error when unsetting bpf prog_fd for ifindex(%d)\n", ifindex);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +
> > +cleanup:
> > +       close(msgsock);
> > +close_sock:
> > +       close(sock);
> > +       unlink(SOCKET_NAME);
> > +       return err;
> > +}
> > diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
> > index 2567f0db5aca..589344fd1eb5 100644
> > --- a/samples/bpf/xdpsock_user.c
> > +++ b/samples/bpf/xdpsock_user.c
> > @@ -24,10 +24,12 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > +#include <sys/capability.h>
> >  #include <sys/mman.h>
> >  #include <sys/resource.h>
> >  #include <sys/socket.h>
> >  #include <sys/types.h>
> > +#include <sys/un.h>
> >  #include <time.h>
> >  #include <unistd.h>
> >
> > @@ -95,6 +97,7 @@ static int opt_timeout = 1000;
> >  static bool opt_need_wakeup = true;
> >  static u32 opt_num_xsks = 1;
> >  static u32 prog_id;
> > +static bool opt_reduced_cap;
> >
> >  struct xsk_ring_stats {
> >         unsigned long rx_npkts;
> > @@ -153,6 +156,7 @@ struct xsk_socket_info {
> >
> >  static int num_socks;
> >  struct xsk_socket_info *xsks[MAX_SOCKS];
> > +int sock;
> >
> >  static unsigned long get_nsecs(void)
> >  {
> > @@ -460,6 +464,7 @@ static void *poller(void *arg)
> >  static void remove_xdp_program(void)
> >  {
> >         u32 curr_prog_id = 0;
> > +       int cmd = CLOSE_CONN;
> >
> >         if (bpf_get_link_xdp_id(opt_ifindex, &curr_prog_id, opt_xdp_flags)) {
> >                 printf("bpf_get_link_xdp_id failed\n");
> > @@ -471,6 +476,13 @@ static void remove_xdp_program(void)
> >                 printf("couldn't find a prog id on a given interface\n");
> >         else
> >                 printf("program on interface changed, not removing\n");
> > +
> > +       if (opt_reduced_cap) {
> > +               if (write(sock, &cmd, sizeof(int)) < 0) {
> > +                       fprintf(stderr, "Error writing into stream socket: %s", strerror(errno));
> > +                       exit(EXIT_FAILURE);
> > +               }
> > +       }
> >  }
> >
> >  static void int_exit(int sig)
> > @@ -853,7 +865,7 @@ static struct xsk_socket_info *xsk_configure_socket(struct xsk_umem_info *umem,
> >         xsk->umem = umem;
> >         cfg.rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS;
> >         cfg.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
> > -       if (opt_num_xsks > 1)
> > +       if (opt_num_xsks > 1 || opt_reduced_cap)
> >                 cfg.libbpf_flags = XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD;
> >         else
> >                 cfg.libbpf_flags = 0;
> > @@ -911,6 +923,7 @@ static struct option long_options[] = {
> >         {"quiet", no_argument, 0, 'Q'},
> >         {"app-stats", no_argument, 0, 'a'},
> >         {"irq-string", no_argument, 0, 'I'},
> > +       {"reduce-cap", no_argument, 0, 'R'},
> >         {0, 0, 0, 0}
> >  };
> >
> > @@ -933,7 +946,7 @@ static void usage(const char *prog)
> >                 "  -m, --no-need-wakeup Turn off use of driver need wakeup flag.\n"
> >                 "  -f, --frame-size=n   Set the frame size (must be a power of two in aligned mode, default is %d).\n"
> >                 "  -u, --unaligned      Enable unaligned chunk placement\n"
> > -               "  -M, --shared-umem    Enable XDP_SHARED_UMEM\n"
> > +               "  -M, --shared-umem    Enable XDP_SHARED_UMEM (cannot be used with -R)\n"
> >                 "  -F, --force          Force loading the XDP prog\n"
> >                 "  -d, --duration=n     Duration in secs to run command.\n"
> >                 "                       Default: forever.\n"
> > @@ -949,6 +962,7 @@ static void usage(const char *prog)
> >                 "  -Q, --quiet          Do not display any stats.\n"
> >                 "  -a, --app-stats      Display application (syscall) statistics.\n"
> >                 "  -I, --irq-string     Display driver interrupt statistics for interface associated with irq-string.\n"
> > +               "  -R, --reduce-cap     Use reduced capabilities (cannot be used with -M)\n"
> >                 "\n";
> >         fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE,
> >                 opt_batch_size, MIN_PKT_SIZE, MIN_PKT_SIZE,
> > @@ -964,7 +978,7 @@ static void parse_command_line(int argc, char **argv)
> >         opterr = 0;
> >
> >         for (;;) {
> > -               c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:xQaI:",
> > +               c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:xQaI:R",
> >                                 long_options, &option_index);
> >                 if (c == -1)
> >                         break;
> > @@ -1063,6 +1077,9 @@ static void parse_command_line(int argc, char **argv)
> >                                 usage(basename(argv[0]));
> >                         }
> >
> > +                       break;
> > +               case 'R':
> > +                       opt_reduced_cap = true;
> >                         break;
> >                 default:
> >                         usage(basename(argv[0]));
> > @@ -1085,6 +1102,11 @@ static void parse_command_line(int argc, char **argv)
> >                         opt_xsk_frame_size);
> >                 usage(basename(argv[0]));
> >         }
> > +
> > +       if (opt_reduced_cap && opt_num_xsks > 1) {
> > +               fprintf(stderr, "ERROR: -M and -R cannot be used together\n");
> > +               usage(basename(argv[0]));
> > +       }
> >  }
> >
> >  static void kick_tx(struct xsk_socket_info *xsk)
> > @@ -1461,26 +1483,117 @@ static void enter_xsks_into_map(struct bpf_object *obj)
> >         }
> >  }
> >
> > +static int recv_xsks_map_fd_from_ctrl_node(int sock, int *_fd)
> > +{
> > +       char cms[CMSG_SPACE(sizeof(int))];
> > +       struct cmsghdr *cmsg;
> > +       struct msghdr msg;
> > +       struct iovec iov;
> > +       int value;
> > +       int len;
> > +
> > +       iov.iov_base = &value;
> > +       iov.iov_len = sizeof(int);
> > +
> > +       msg.msg_name = 0;
> > +       msg.msg_namelen = 0;
> > +       msg.msg_iov = &iov;
> > +       msg.msg_iovlen = 1;
> > +       msg.msg_flags = 0;
> > +       msg.msg_control = (caddr_t)cms;
> > +       msg.msg_controllen = sizeof(cms);
> > +
> > +       len = recvmsg(sock, &msg, 0);
> > +
> > +       if (len < 0) {
> > +               fprintf(stderr, "Recvmsg failed length incorrect.\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (len == 0) {
> > +               fprintf(stderr, "Recvmsg failed no data\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       cmsg = CMSG_FIRSTHDR(&msg);
> > +       *_fd = *(int *)CMSG_DATA(cmsg);
> > +
> > +       return 0;
> > +}
> > +
> > +static int
> > +recv_xsks_map_fd(int *xsks_map_fd)
> > +{
> > +       struct sockaddr_un server;
> > +       int err;
> > +
> > +       sock = socket(AF_UNIX, SOCK_STREAM, 0);
> > +       if (sock < 0) {
> > +               fprintf(stderr, "Error opening socket stream: %s", strerror(errno));
> > +               return errno;
> > +       }
> > +
> > +       server.sun_family = AF_UNIX;
> > +       strcpy(server.sun_path, SOCKET_NAME);
> > +
> > +       if (connect(sock, (struct sockaddr *)&server, sizeof(struct sockaddr_un)) < 0) {
> > +               close(sock);
> > +               fprintf(stderr, "Error connecting stream socket: %s", strerror(errno));
> > +               return errno;
> > +       }
> > +
> > +       err = recv_xsks_map_fd_from_ctrl_node(sock, xsks_map_fd);
> > +       if (err) {
> > +               fprintf(stderr, "Error %d recieving fd\n", err);
> > +               return err;
> > +       }
> > +       return 0;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> > +       struct __user_cap_header_struct hdr = { _LINUX_CAPABILITY_VERSION_3, 0 };
> > +       struct __user_cap_data_struct data[2] = { { 0 } };
> >         struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
> >         bool rx = false, tx = false;
> >         struct xsk_umem_info *umem;
> >         struct bpf_object *obj;
> > +       int xsks_map_fd = 0;
> >         pthread_t pt;
> >         int i, ret;
> >         void *bufs;
> >
> >         parse_command_line(argc, argv);
> >
> > -       if (setrlimit(RLIMIT_MEMLOCK, &r)) {
> > -               fprintf(stderr, "ERROR: setrlimit(RLIMIT_MEMLOCK) \"%s\"\n",
> > -                       strerror(errno));
> > -               exit(EXIT_FAILURE);
> > +       if (opt_reduced_cap) {
> > +               if (capget(&hdr, data)  < 0)
> > +                       fprintf(stderr, "Error getting capabilities\n");
> > +
> > +               data->effective &= CAP_TO_MASK(CAP_NET_RAW);
> > +               data->permitted &= CAP_TO_MASK(CAP_NET_RAW);
> > +
> > +               if (capset(&hdr, data) < 0)
> > +                       fprintf(stderr, "Setting capabilities failed\n");
> > +
> > +               if (capget(&hdr, data)  < 0) {
> > +                       fprintf(stderr, "Error getting capabilities\n");
> > +               } else {
> > +                       fprintf(stderr, "Capabilities EFF %x Caps INH %x Caps Per %x\n",
> > +                               data[0].effective, data[0].inheritable, data[0].permitted);
> > +                       fprintf(stderr, "Capabilities EFF %x Caps INH %x Caps Per %x\n",
> > +                               data[1].effective, data[1].inheritable, data[1].permitted);
> > +               }
> > +       } else {
> > +               if (setrlimit(RLIMIT_MEMLOCK, &r)) {
> > +                       fprintf(stderr, "ERROR: setrlimit(RLIMIT_MEMLOCK) \"%s\"\n",
> > +                               strerror(errno));
> > +                       exit(EXIT_FAILURE);
> > +               }
> > +
> > +               if (opt_num_xsks > 1)
> > +                       load_xdp_program(argv, &obj);
> >         }
> >
> > -       if (opt_num_xsks > 1)
> > -               load_xdp_program(argv, &obj);
> >
> >         /* Reserve memory for the umem. Use hugepages if unaligned chunk mode */
> >         bufs = mmap(NULL, NUM_FRAMES * opt_xsk_frame_size,
> > @@ -1512,6 +1625,21 @@ int main(int argc, char **argv)
> >         if (opt_num_xsks > 1 && opt_bench != BENCH_TXONLY)
> >                 enter_xsks_into_map(obj);
> >
> > +       if (opt_reduced_cap) {
> > +               ret = recv_xsks_map_fd(&xsks_map_fd);
> > +               if (ret) {
> > +                       fprintf(stderr, "Error %d receiving xsks_map_fd\n", ret);
> > +                       exit_with_error(ret);
> > +               }
> > +               if (xsks[0]->xsk) {
> > +                       ret = xsk_socket__update_xskmap(xsks[0]->xsk, xsks_map_fd);
> > +                       if (ret) {
> > +                               fprintf(stderr, "Update of BPF map failed(%d)\n", ret);
> > +                               exit_with_error(ret);
> > +                       }
> > +               }
> > +       }
> > +
> >         signal(SIGINT, int_exit);
> >         signal(SIGTERM, int_exit);
> >         signal(SIGABRT, int_exit);
> > --
> > 2.20.1
> >
