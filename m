Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9D4D237F
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 22:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiCHVoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 16:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbiCHVoR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 16:44:17 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF53A714
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 13:43:19 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e6so283641pgn.2
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 13:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bWm+9xeQlKd5ZwBEJ8bGYj09cH49DNugs5Y5jCvW9MI=;
        b=PbizxvcSHAvDujxOb9yokiKlFXSI5lCM/pejaRAM0mRigvYuAcKLFXe7R3Cc5e/tWd
         3/tp6+mnJb2VdJYPQJjj75hxKr6PzIB275nREZ4YKDvAdHH07GfDx4nWbSE60BhCDnuN
         2SuMuTZnVjog1LLk52dEd87A6f4292cF+fY69uw8s9bb059aoPkZVI5pBzZqicZOjGuS
         sRBYTs0NvBqcRTcBd/IxJDz4GlaoBlKr8EfxHgHPMKRXcyp5JsvpK+N+Hr8hoIfVxnKF
         YJyyTz83ByKRZ/NeoLzWYoMyZutKd2pmhyoKnsmmD11QOMBhe5BBf8nDTV8w3BGgLuOw
         B2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bWm+9xeQlKd5ZwBEJ8bGYj09cH49DNugs5Y5jCvW9MI=;
        b=zHTL+7ASgk7g40kHZKqMcERy1MgZTdFEwqu/OEEx4MqYNSckdedODpNc2MVz2E0avG
         pSNZe/fBEpldPAg/2r3zjHEhrKNNJvr4P8Gl3JPVWHvWp9+aIdNEZ/2RZjAX0mn2K+IQ
         yBAh76fv5ixy9O+kfP0N9vh749MCqv3YDKA3vShz3qCvLYsCaHSSzGqK0HlPeGhv+UN7
         Jxsvql1pwNGsvcxf17zbUlrtGWKCHU43S1pQruA1viT5YBcMTJddUKeD+YHDYXazev0f
         AYUd7PAZzc1l4R//U71B6qQhccFe/4sGAZcB8sH4CeSj2WZRrEja9/20plHUZ0IQ2diJ
         MoXw==
X-Gm-Message-State: AOAM530YvU+cZWdQzKqjsHlB3kfezqoJsNQUtSPNkcLKSpvq2dajdoi/
        ospALJZ4VUEDx3waCxfKMxa3SoPzzrStfqtiUU9ND+wLho8DUOb/
X-Google-Smtp-Source: ABdhPJyznjWDzdF3NJ2/+TYnqFCB6haaKc2umxV2sO0qr0iERM3w1fFtAP9v/v08PxtFzf7AhHZA2Quml7idctkplU8=
X-Received: by 2002:a63:2a95:0:b0:37c:46b0:2088 with SMTP id
 q143-20020a632a95000000b0037c46b02088mr15971107pgq.150.1646775798582; Tue, 08
 Mar 2022 13:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20220308113056.3779069-1-niklas.soderlund@corigine.com>
 <25f003df-97cb-549b-e117-2eb1fa2f3cc2@isovalent.com> <Yidskyc26yC9F1c9@bismarck.dyn.berto.se>
In-Reply-To: <Yidskyc26yC9F1c9@bismarck.dyn.berto.se>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 8 Mar 2022 21:43:07 +0000
Message-ID: <CACdoK4LYPAjPc-aeqS_G+gp6Nw+KoDjyL3P8ujvvy67DFMKfgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Restore support for BPF offload-enabled
 feature probing
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@corigine.com>,
        oss-drivers@corigine.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 8 Mar 2022 at 14:47, Niklas S=C3=B6derlund
<niklas.soderlund@corigine.com> wrote:
>
> Hi Quentin,
>
> On 2022-03-08 14:23:30 +0000, Quentin Monnet wrote:
> > 2022-03-08 12:30 UTC+0100 ~ Niklas S=C3=B6derlund <niklas.soderlund@cor=
igine.com>
> > > Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enable=
d
> > > feature probing") removed the support to probe for BPF offload featur=
es.
> > > This is still something that is useful for NFP NIC that can support
> > > offloading of BPF programs.
> > >
> > > The reason for the dropped support was that libbpf starting with v1.0
> > > would drop support for passing the ifindex to the BPF prog/map/helper
> > > feature probing APIs. In order to keep this useful feature for NFP
> > > restore the functionality by moving it directly into bpftool.
> > >
> > > The code restored is a simplified version of the code that existed in
> > > libbpf which supposed passing the ifindex. The simplification is that=
 it
> > > only targets the cases where ifindex is given and call into libbpf fo=
r
> > > the cases where it's not.
> > >
> > > Before restoring support for probing offload features:
> > >
> > >   # bpftool feature probe dev ens4np0
> > >   Scanning system call availability...
> > >   bpf() syscall is available
> > >
> > >   Scanning eBPF program types...
> > >
> > >   Scanning eBPF map types...
> > >
> > >   Scanning eBPF helper functions...
> > >   eBPF helpers supported for program type sched_cls:
> > >   eBPF helpers supported for program type xdp:
> > >
> > >   Scanning miscellaneous eBPF features...
> > >   Large program size limit is NOT available
> > >   Bounded loop support is NOT available
> > >   ISA extension v2 is NOT available
> > >   ISA extension v3 is NOT available
> > >
> > > With support for probing offload features restored:
> > >
> > >   # bpftool feature probe dev ens4np0
> > >   Scanning system call availability...
> > >   bpf() syscall is available
> > >
> > >   Scanning eBPF program types...
> > >   eBPF program_type sched_cls is available
> > >   eBPF program_type xdp is available
> > >
> > >   Scanning eBPF map types...
> > >   eBPF map_type hash is available
> > >   eBPF map_type array is available
> > >   eBPF map_type prog_array is NOT available
> > >   eBPF map_type perf_event_array is NOT available
> > >   eBPF map_type percpu_hash is NOT available
> > >   eBPF map_type percpu_array is NOT available
> > >   eBPF map_type stack_trace is NOT available
> > >   eBPF map_type cgroup_array is NOT available
> > >   eBPF map_type lru_hash is NOT available
> > >   eBPF map_type lru_percpu_hash is NOT available
> > >   eBPF map_type lpm_trie is NOT available
> > >   eBPF map_type array_of_maps is NOT available
> > >   eBPF map_type hash_of_maps is NOT available
> > >   eBPF map_type devmap is NOT available
> > >   eBPF map_type sockmap is NOT available
> > >   eBPF map_type cpumap is NOT available
> > >   eBPF map_type xskmap is NOT available
> > >   eBPF map_type sockhash is NOT available
> > >   eBPF map_type cgroup_storage is NOT available
> > >   eBPF map_type reuseport_sockarray is NOT available
> > >   eBPF map_type percpu_cgroup_storage is NOT available
> > >   eBPF map_type queue is NOT available
> > >   eBPF map_type stack is NOT available
> > >   eBPF map_type sk_storage is NOT available
> > >   eBPF map_type devmap_hash is NOT available
> > >   eBPF map_type struct_ops is NOT available
> > >   eBPF map_type ringbuf is NOT available
> > >   eBPF map_type inode_storage is NOT available
> > >   eBPF map_type task_storage is NOT available
> > >   eBPF map_type bloom_filter is NOT available
> > >
> > >   Scanning eBPF helper functions...
> > >   eBPF helpers supported for program type sched_cls:
> > >     - bpf_map_lookup_elem
> > >     - bpf_get_prandom_u32
> > >     - bpf_perf_event_output
> > >   eBPF helpers supported for program type xdp:
> > >     - bpf_map_lookup_elem
> > >     - bpf_get_prandom_u32
> > >     - bpf_perf_event_output
> > >     - bpf_xdp_adjust_head
> > >     - bpf_xdp_adjust_tail
> > >
> > >   Scanning miscellaneous eBPF features...
> > >   Large program size limit is NOT available
> > >   Bounded loop support is NOT available
> > >   ISA extension v2 is NOT available
> > >   ISA extension v3 is NOT available
> > >
> > > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
> > > Signed-off-by: Simon Horman <simon.horman@corigine.com>
> > > ---
> > >  tools/bpf/bpftool/feature.c | 185 +++++++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 170 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.=
c
> > > index 9c894b1447de8cf0..4943beb1823111c8 100644
> > > --- a/tools/bpf/bpftool/feature.c
> > > +++ b/tools/bpf/bpftool/feature.c
> > > @@ -3,6 +3,7 @@
> > >
> > >  #include <ctype.h>
> > >  #include <errno.h>
> > > +#include <fcntl.h>
> > >  #include <string.h>
> > >  #include <unistd.h>
> > >  #include <net/if.h>
> > > @@ -45,6 +46,11 @@ static bool run_as_unprivileged;
> > >
> > >  /* Miscellaneous utility functions */
> > >
> > > +static bool grep(const char *buffer, const char *pattern)
> > > +{
> > > +   return !!strstr(buffer, pattern);
> > > +}
> > > +
> > >  static bool check_procfs(void)
> > >  {
> > >     struct statfs st_fs;
> > > @@ -135,6 +141,32 @@ static void print_end_section(void)
> > >
> > >  /* Probing functions */
> > >
> > > +static int get_vendor_id(int ifindex)
> > > +{
> > > +   char ifname[IF_NAMESIZE], path[64], buf[8];
> > > +   ssize_t len;
> > > +   int fd;
> > > +
> > > +   if (!if_indextoname(ifindex, ifname))
> > > +           return -1;
> > > +
> > > +   snprintf(path, sizeof(path), "/sys/class/net/%s/device/vendor", i=
fname);
> > > +
> > > +   fd =3D open(path, O_RDONLY | O_CLOEXEC);
> > > +   if (fd < 0)
> > > +           return -1;
> > > +
> > > +   len =3D read(fd, buf, sizeof(buf));
> > > +   close(fd);
> > > +   if (len < 0)
> > > +           return -1;
> > > +   if (len >=3D (ssize_t)sizeof(buf))
> > > +           return -1;
> > > +   buf[len] =3D '\0';
> > > +
> > > +   return strtol(buf, NULL, 0);
> > > +}
> > > +
> > >  static int read_procfs(const char *path)
> > >  {
> > >     char *endptr, *line =3D NULL;
> > > @@ -478,6 +510,69 @@ static bool probe_bpf_syscall(const char *define=
_prefix)
> > >     return res;
> > >  }
> > >
> > > +static int
> > > +probe_prog_load_ifindex(enum bpf_prog_type prog_type,
> > > +                   const struct bpf_insn *insns, size_t insns_cnt,
> > > +                   char *log_buf, size_t log_buf_sz,
> > > +                   __u32 ifindex)
> > > +{
> > > +   LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > > +               .log_buf =3D log_buf,
> > > +               .log_size =3D log_buf_sz,
> > > +               .log_level =3D log_buf ? 1 : 0,
> > > +               .prog_ifindex =3D ifindex,
> > > +              );
> > > +   const char *exp_msg =3D NULL;
> > > +   int fd, err, exp_err =3D 0;
> > > +   char buf[4096];
> > > +
> > > +   switch (prog_type) {
> > > +   case BPF_PROG_TYPE_SCHED_CLS:
> > > +   case BPF_PROG_TYPE_XDP:
> > > +           break;
> > > +   default:
> > > +           return -EOPNOTSUPP;
> >
> > This will not be caught in probe_prog_type_ifindex(), where you only
> > check for the errno value, will it? You should also check the return
> > code from probe_prog_load_ifindex()? (Same thing in probe_helper_ifinde=
x()).
> >
> > You could also get rid of this switch entirely, because the function is
> > never called with a program type other than TC or XDP (given that you
> > already check in probe_prog_type(), and helper probes are only run
> > against supported program tyeps).
>
> I agree with this comment. I only kept the return code here as that is
> how it was treated in the libbpf version in the code. I will improve on
> this and strip it out.
>
> >
> > > +   }
> > > +
> > > +   fd =3D bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &o=
pts);
> > > +   err =3D -errno;
> > > +   if (fd >=3D 0)
> > > +           close(fd);
> > > +   if (exp_err) {
> >
> > exp_err is always 0, you don't need this part. I think this is a
> > leftover of the previous libbpf probes.
>
> Thanks, not sure how I missed that.
>
> >
> > > +           if (fd >=3D 0 || err !=3D exp_err)
> > > +                   return 0;
> > > +           if (exp_msg && !strstr(buf, exp_msg))
> > > +                   return 0;
> > > +           return 1;
> > > +   }
> > > +   return fd >=3D 0 ? 1 : 0;
> > > +}
> > > +
> > > +static bool probe_prog_type_ifindex(enum bpf_prog_type prog_type, __=
u32 ifindex)
> > > +{
> > > +   struct bpf_insn insns[2] =3D {
> > > +           BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +           BPF_EXIT_INSN()
> > > +   };
> > > +
> > > +   switch (prog_type) {
> > > +   case BPF_PROG_TYPE_SCHED_CLS:
> > > +           /* nfp returns -EINVAL on exit(0) with TC offload */
> > > +           insns[0].imm =3D 2;
> > > +           break;
> > > +   case BPF_PROG_TYPE_XDP:
> > > +           break;
> > > +   default:
> > > +           return false;
> > > +   }
> > > +
> > > +   errno =3D 0;
> > > +   probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns), NULL=
, 0,
> > > +                           ifindex);
> > > +
> > > +   return errno !=3D EINVAL && errno !=3D EOPNOTSUPP;
> > > +}
> > > +
> > >  static void
> > >  probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
> > >             const char *define_prefix, __u32 ifindex)
> > > @@ -488,11 +583,19 @@ probe_prog_type(enum bpf_prog_type prog_type, b=
ool *supported_types,
> > >     bool res;
> > >
> > >     if (ifindex) {
> > > -           p_info("BPF offload feature probing is not supported");
> > > -           return;
> > > +           switch (prog_type) {
> > > +           case BPF_PROG_TYPE_SCHED_CLS:
> > > +           case BPF_PROG_TYPE_XDP:
> > > +                   break;
> > > +           default:
> > > +                   return;
> > > +           }
> >
> > Here we skip the probe entirely (we don't print a result, even negative=
)
> > for types that are not supported by the SmartNICs today. But for map
> > types, the equivalent switch is in probe_map_type_ifindex(), and it
> > skips the actual bpf() syscall but it doesn't skip the part where we
> > print a result.
> >
> > This means that the output for program types shows the result for just
> > TC/XDP, while the output for map types shows the result for all maps
> > known to bpftool, even if we =E2=80=9Cknow=E2=80=9D they are not suppor=
ted for offload.
> > This shows in your commit description. Could we harmonise between maps
> > and programs? I don't mind much either way you choose, printing all or
> > printing few.
>
> This is how the output looked before the support for offload-enabled
> feature probing was dropped. I agree it would make sens to harmonise the
> two but did not want to do that at the same time as restoring the
> feature. But as you agree it's a good idea and I need to do a v2 anyway
> I will do so already.

So I looked a bit more into it. I couldn't remember the reason why
we'd probe all maps but not all prog types, but the commit log has a
hint:

    Among the program types, only the ones that can be offloaded are probed=
.
    All map types are probed, as there is no specific rule telling which on=
e
    could or could not be supported by a device in the future. All helpers
    are probed (but only for offload-able program types).

I think at the time, I was referring, for program types, to this check
in bpf_prog_offload_init() in kernel/bpf/offload.c.

    if (attr->prog_type !=3D BPF_PROG_TYPE_SCHED_CLS &&
        attr->prog_type !=3D BPF_PROG_TYPE_XDP)
        return -EINVAL;

This makes it impossible to have other types offloaded; but there's no
equivalent for maps, so we could theoretically have any map type
supported. So maybe not such a bad thing, filtering out non-relevant
program types but allowing out-of-kernel drivers to probe all map
types. Maybe keep this part unchanged for v2, after all?

Quentin
