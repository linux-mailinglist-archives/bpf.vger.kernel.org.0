Return-Path: <bpf+bounces-4346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B0A74A720
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E881C20EDD
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A581641A;
	Thu,  6 Jul 2023 22:34:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723AC2CF
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:34:28 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77818172B
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:34:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso14039435e9.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688682862; x=1691274862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2dRXkIBgPEFrY7DPuutOQkNnKGiOG5ys+YV70yBp0c=;
        b=JTonvMoYH6PJ/gu5N/z0sZKKnN5/XiGtC3v7eRvetq6HLvVJr0cqIbfnEl7Y5goMi4
         o+57BKgSi5lIOaN6DK+t1d3yz6dXNXAhkq0Igig18aw7haeoxUF6H2wB/bPmka6m6w+G
         4bv8FP0sXYiot0AEEQe3vmQ4wT9H9NhzK2NpmbUBApY6Uymm35Z9+yHSnlFZ6pPc6FvS
         ksRonnmY8v+m6j9vCeUXzddzEov+zMFz0w2aeTCIafI935zvXFsQLr962QRHIOTQ1YVL
         TjRhlUFKQwjiTgEZV4yiuswWkBRTvBgHmaqZwuJHwscXmOe99eWIwShNmukec9Zu8k5P
         E1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682862; x=1691274862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2dRXkIBgPEFrY7DPuutOQkNnKGiOG5ys+YV70yBp0c=;
        b=Z0bzXPZbSJTCjsESZb5kjW/LzsfkoUBtGzDFtj9ezieiE1aDisqcCJFvymnXAizznz
         udTT/a2p1JOUiVzN74WcmvBpX9pCRdf6Qn8de/AAhlJaCqgW8bhC95MjqRSfPK1sZQd4
         wRcSEwzMYvPhlBmSW0/kWqgMRF6QXv91VRZulWw7pNudWAblgcoGX8BppQy2ug1eoRBd
         GE04DMxyzaGUvJNmpZFoRGXXcgwAFxa9FdbwEdB+UxuKrvWird5b8sXxeg+CVaMfciV6
         739o7tc2I4m446EnO17c7Ks9v4xk9GEE88KUCmiDjzwnvkFo4852SsSuuY89sRi5Tifd
         McYQ==
X-Gm-Message-State: ABy/qLZG3+8XixAxPL2iwTynlzgXd5h/jBw/fXKJ6msqn0ofouvXPSVa
	Ptr8cRsY4I/j64ztBKrYLLVmfo3XVbeDLBAOOpiPK4Ec8Xk=
X-Google-Smtp-Source: APBJJlHezrW6hEx0nnifeGBz8bPVTTYGHcq1UEic7YmbpptqycUqCphWjKgqxHKI92QrHZQqkfKgbk6/jxShhKttbxA=
X-Received: by 2002:a1c:6a0c:0:b0:3fb:ab56:a66c with SMTP id
 f12-20020a1c6a0c000000b003fbab56a66cmr2258164wmc.10.1688682861883; Thu, 06
 Jul 2023 15:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-3-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 15:34:10 -0700
Message-ID: <CAEf4BzY68qYuOYEb7w2S+_m9Gmi0fDnhpwnYcvKzc6QRjLMyxQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 02/26] bpf: Add multi uprobe link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
>
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
>
>   struct {
>           __u32           flags;
>           __u32           cnt;
>           __aligned_u64   path;
>           __aligned_u64   offsets;
>           __aligned_u64   ref_ctr_offsets;
>   } uprobe_multi;
>
> Uprobes are defined for single binary specified in path and multiple
> calling sites specified in offsets array with optional reference
> counters specified in ref_ctr_offsets array. All specified arrays
> have length of 'cnt'.
>
> The 'flags' supports single bit for now that marks the uprobe as
> return probe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h   |   6 +
>  include/uapi/linux/bpf.h       |  14 ++
>  kernel/bpf/syscall.c           |  14 +-
>  kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  14 ++
>  5 files changed, 282 insertions(+), 3 deletions(-)
>

overall LGTM, but I think there is path leak, please fix that and add my ac=
k

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 7c4a0b72334e..c71845e9d40a 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -749,6 +749,7 @@ int bpf_get_perf_event_info(const struct perf_event *=
event, u32 *prog_id,
>                             u32 *fd_type, const char **buf,
>                             u64 *probe_offset, u64 *probe_addr);
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog);
> +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog);
>  #else
>  static inline unsigned int trace_call_bpf(struct trace_event_call *call,=
 void *ctx)
>  {
> @@ -795,6 +796,11 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *a=
ttr, struct bpf_prog *prog)
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline int
> +bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog=
 *prog)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
>
>  enum {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 60a9d59beeab..a236139f08ce 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1036,6 +1036,7 @@ enum bpf_attach_type {
>         BPF_LSM_CGROUP,
>         BPF_STRUCT_OPS,
>         BPF_NETFILTER,
> +       BPF_TRACE_UPROBE_MULTI,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> @@ -1053,6 +1054,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_KPROBE_MULTI =3D 8,
>         BPF_LINK_TYPE_STRUCT_OPS =3D 9,
>         BPF_LINK_TYPE_NETFILTER =3D 10,
> +       BPF_LINK_TYPE_UPROBE_MULTI =3D 11,
>
>         MAX_BPF_LINK_TYPE,
>  };
> @@ -1170,6 +1172,11 @@ enum bpf_link_type {
>   */
>  #define BPF_F_KPROBE_MULTI_RETURN      (1U << 0)
>
> +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> + */
> +#define BPF_F_UPROBE_MULTI_RETURN      (1U << 0)
> +

any reason why we don't use anonymous ENUMs for all these UAPI
constants? When we need to use these flags from BPF side (e.g., for
BPF LSM), having them as #defines will be a PITA, as they won't be
present in vmlinux.h


>  /* When BPF ldimm64's insn[0].src_reg !=3D 0 then this can have
>   * the following extensions:
>   *
> @@ -1579,6 +1586,13 @@ union bpf_attr {
>                                 __s32           priority;
>                                 __u32           flags;
>                         } netfilter;
> +                       struct {
> +                               __u32           flags;
> +                               __u32           cnt;

total nit, but I'd move it after path/offsets/ref_ctr_offsets, and
make the order cnt (as it applies to previous two
offsets/ref_ctr_offsets) and then flags last. Seems like more logical
order, but totally subjective

> +                               __aligned_u64   path;
> +                               __aligned_u64   offsets;
> +                               __aligned_u64   ref_ctr_offsets;
> +                       } uprobe_multi;
>                 };
>         } link_create;
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9046ad0f9b4e..3b0582a64ce4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2813,10 +2813,12 @@ static void bpf_link_free_id(int id)
>
>  /* Clean up bpf_link and corresponding anon_inode file and FD. After
>   * anon_inode is created, bpf_link can't be just kfree()'d due to deferr=
ed
> - * anon_inode's release() call. This helper marksbpf_link as
> + * anon_inode's release() call. This helper marks bpf_link as
>   * defunct, releases anon_inode file and puts reserved FD. bpf_prog's re=
fcnt
>   * is not decremented, it's the responsibility of a calling code that fa=
iled
>   * to complete bpf_link initialization.
> + * This helper eventually calls link's dealloc callback, but does not ca=
ll
> + * link's release callback.

Thanks for clarifying comments!

>   */
>  void bpf_link_cleanup(struct bpf_link_primer *primer)
>  {
> @@ -3589,8 +3591,12 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>                 if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI &&
>                     attach_type !=3D BPF_TRACE_KPROBE_MULTI)
>                         return -EINVAL;
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MU=
LTI &&
> +                   attach_type !=3D BPF_TRACE_UPROBE_MULTI)
> +                       return -EINVAL;
>                 if (attach_type !=3D BPF_PERF_EVENT &&
> -                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI &&
> +                   attach_type !=3D BPF_TRACE_UPROBE_MULTI)

if this keeps growing, we should think about having a switch in a
switch to not repeat BPF_TRACE_UPROBE_MULTI and BPF_TRACE_KPROBE_MULTI
twice

>                         return -EINVAL;
>                 return 0;
>         case BPF_PROG_TYPE_EXT:

[...]

> +       for (i =3D 0; i < cnt; i++) {
> +               if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], ur=
ef_ctr_offsets + i)) {
> +                       err =3D -EFAULT;
> +                       goto error_free;
> +               }
> +               if (__get_user(uprobes[i].offset, uoffsets + i)) {
> +                       err =3D -EFAULT;
> +                       goto error_free;
> +               }
> +
> +               uprobes[i].link =3D link;
> +
> +               if (flags & BPF_F_UPROBE_MULTI_RETURN)
> +                       uprobes[i].consumer.ret_handler =3D uprobe_multi_=
link_ret_handler;
> +               else
> +                       uprobes[i].consumer.handler =3D uprobe_multi_link=
_handler;
> +       }
> +
> +       link->cnt =3D cnt;
> +       link->uprobes =3D uprobes;
> +       link->path =3D path;
> +
> +       bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> +                     &bpf_uprobe_multi_link_lops, prog);
> +
> +       err =3D bpf_link_prime(&link->link, &link_primer);
> +       if (err)
> +               goto error_free;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               err =3D uprobe_register_refctr(d_real_inode(link->path.de=
ntry),
> +                                            uprobes[i].offset,
> +                                            ref_ctr_offsets ? ref_ctr_of=
fsets[i] : 0,
> +                                            &uprobes[i].consumer);
> +               if (err) {
> +                       bpf_uprobe_unregister(&path, uprobes, i);
> +                       bpf_link_cleanup(&link_primer);
> +                       kvfree(ref_ctr_offsets);

are we missing path_put() in this error handling path? so maybe goto
error_path_put here instead of return?

> +                       return err;
> +               }
> +       }
> +
> +       kvfree(ref_ctr_offsets);
> +       return bpf_link_settle(&link_primer);
> +
> +error_free:
> +       kvfree(ref_ctr_offsets);
> +       kvfree(uprobes);
> +       kfree(link);
> +error_path_put:
> +       path_put(&path);
> +       return err;
> +}

[...]

