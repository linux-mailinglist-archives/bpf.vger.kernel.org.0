Return-Path: <bpf+bounces-6394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7850768A49
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 05:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BE21C209C9
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 03:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192364D;
	Mon, 31 Jul 2023 03:28:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D862D
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 03:28:19 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D1189
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 20:28:14 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63cf96c37beso17808926d6.0
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690774093; x=1691378893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRL2JXhG8+ZM4rPmthBFaohyHEHPB29bPek1o24IV58=;
        b=LpztV5ZD9+nsfevdDUMZywTKs2ejcipjL1HtiX/PiFLJdqlPX2N+5T5KhdTHWAX5QQ
         trPFqxZ3C2ULg+dDNFtv5g/qRkwt0JhsVFMBncH9iOvmjUoM/cBe8D7MzbH7boVhTmKG
         5ICbZ31QCyKzK2YrlskZ2U8vBdtzQM0hOvKFKu8k8XLj18qck2ZbxfxwYFVRmkLJN4Ts
         Qy9QOCAj4sWR04Whg66TZWr/mikAS+JqVMrfFtj7DKVLVyvDIFYMwMR2UgQoe4oPs60W
         7vG8IhwajRR0DUKh+DsEchGjj0/QwMFZsE2rLnyJuvfnrw1+/F2Gt9d6RwZD8UdeEbom
         Jemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690774093; x=1691378893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRL2JXhG8+ZM4rPmthBFaohyHEHPB29bPek1o24IV58=;
        b=OSExQtjaHTcNoa1Kd8HMJrWEYjhIKEsUnudZ+33FbkyotM/TcnamFj6/Twuot1SU4s
         s9mWkisN3Dd8EWNsOBPTRyjDnM5xBYOZc0IqFm+x569jES+MNYSy1i5vFjL4OGEHNCPL
         G8TNSs8gLZhtJBYC24XXHFGsFjJV+7PLn/OWUN1QuNrAXH3eBF6lLNnibGe/38bBQqn9
         O3AsWzKDTujhxt4H3cMxnPv+OVVY0aDp+wtvX+RWukFexDQIXttq1Fc8Ry3dNqCbATEK
         rYQ4t/Ma+YUxWQl+XfUrqqL6x5Tg3PHM3+s8TypZPV976vfOdZq5V/u1deOTcezGYP/n
         sncQ==
X-Gm-Message-State: ABy/qLYb7o8t9LlYTCYmFIrFOYfUrR/x6CwnXecNIhyMKyB4pGHQ+3mr
	QMkT8ufTEG9KD1AA11jH0qLVwJpXiQ13Gbpc2Sc=
X-Google-Smtp-Source: APBJJlFiSlzKhCWJJXhFcyabcpBmemURT4E+jOCtSKW+TJPHNlK8R/cHcm43XhEyUsIGXh/FpWkO7zIEKhYPHVOKhhE=
X-Received: by 2002:a0c:8e41:0:b0:639:d1f8:3e15 with SMTP id
 w1-20020a0c8e41000000b00639d1f83e15mr11664132qvb.23.1690774093591; Sun, 30
 Jul 2023 20:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730134223.94496-1-jolsa@kernel.org> <20230730134223.94496-4-jolsa@kernel.org>
In-Reply-To: <20230730134223.94496-4-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 31 Jul 2023 11:27:37 +0800
Message-ID: <CALOAHbDg7XiJ9vQooDBvOyzTGWtKOCM_k78c0XZjw+3quJ+VdA@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 03/28] bpf: Add multi uprobe link
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

On Sun, Jul 30, 2023 at 9:43=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
>
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
>
>   struct {
>     __aligned_u64   path;
>     __aligned_u64   offsets;
>     __aligned_u64   ref_ctr_offsets;
>     __u32           cnt;
>     __u32           flags;
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
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

LGTM!
Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/linux/trace_events.h   |   6 +
>  include/uapi/linux/bpf.h       |  16 +++
>  kernel/bpf/syscall.c           |  14 +-
>  kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  16 +++
>  5 files changed, 286 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index e66d04dbe56a..5b85cf18c350 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -752,6 +752,7 @@ int bpf_get_perf_event_info(const struct perf_event *=
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
> @@ -798,6 +799,11 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *a=
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
> index 7abb382dc6c1..f112a0b948f3 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1039,6 +1039,7 @@ enum bpf_attach_type {
>         BPF_NETFILTER,
>         BPF_TCX_INGRESS,
>         BPF_TCX_EGRESS,
> +       BPF_TRACE_UPROBE_MULTI,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> @@ -1057,6 +1058,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_STRUCT_OPS =3D 9,
>         BPF_LINK_TYPE_NETFILTER =3D 10,
>         BPF_LINK_TYPE_TCX =3D 11,
> +       BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
>         MAX_BPF_LINK_TYPE,
>  };
>
> @@ -1190,6 +1192,13 @@ enum {
>         BPF_F_KPROBE_MULTI_RETURN =3D (1U << 0)
>  };
>
> +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> + */
> +enum {
> +       BPF_F_UPROBE_MULTI_RETURN =3D (1U << 0)
> +};
> +
>  /* link_create.netfilter.flags used in LINK_CREATE command for
>   * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
>   */
> @@ -1626,6 +1635,13 @@ union bpf_attr {
>                                 };
>                                 __u64           expected_revision;
>                         } tcx;
> +                       struct {
> +                               __aligned_u64   path;
> +                               __aligned_u64   offsets;
> +                               __aligned_u64   ref_ctr_offsets;
> +                               __u32           cnt;
> +                               __u32           flags;
> +                       } uprobe_multi;
>                 };
>         } link_create;
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7c01186d4078..75c83300339e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2815,10 +2815,12 @@ static void bpf_link_free_id(int id)
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
>   */
>  void bpf_link_cleanup(struct bpf_link_primer *primer)
>  {
> @@ -3757,8 +3759,12 @@ static int bpf_prog_attach_check_attach_type(const=
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
>                         return -EINVAL;
>                 return 0;
>         case BPF_PROG_TYPE_SCHED_CLS:
> @@ -4954,8 +4960,10 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>         case BPF_PROG_TYPE_KPROBE:
>                 if (attr->link_create.attach_type =3D=3D BPF_PERF_EVENT)
>                         ret =3D bpf_perf_link_attach(attr, prog);
> -               else
> +               else if (attr->link_create.attach_type =3D=3D BPF_TRACE_K=
PROBE_MULTI)
>                         ret =3D bpf_kprobe_multi_link_attach(attr, prog);
> +               else if (attr->link_create.attach_type =3D=3D BPF_TRACE_U=
PROBE_MULTI)
> +                       ret =3D bpf_uprobe_multi_link_attach(attr, prog);
>                 break;
>         default:
>                 ret =3D -EINVAL;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c92eb8c6ff08..10284fd46f98 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -23,6 +23,7 @@
>  #include <linux/sort.h>
>  #include <linux/key.h>
>  #include <linux/verification.h>
> +#include <linux/namei.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -2965,3 +2966,239 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_r=
un_ctx *ctx)
>         return 0;
>  }
>  #endif
> +
> +#ifdef CONFIG_UPROBES
> +struct bpf_uprobe_multi_link;
> +
> +struct bpf_uprobe {
> +       struct bpf_uprobe_multi_link *link;
> +       loff_t offset;
> +       struct uprobe_consumer consumer;
> +};
> +
> +struct bpf_uprobe_multi_link {
> +       struct path path;
> +       struct bpf_link link;
> +       u32 cnt;
> +       struct bpf_uprobe *uprobes;
> +};
> +
> +struct bpf_uprobe_multi_run_ctx {
> +       struct bpf_run_ctx run_ctx;
> +       unsigned long entry_ip;
> +};
> +
> +static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *=
uprobes,
> +                                 u32 cnt)
> +{
> +       u32 i;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               uprobe_unregister(d_real_inode(path->dentry), uprobes[i].=
offset,
> +                                 &uprobes[i].consumer);
> +       }
> +}
> +
> +static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> +{
> +       struct bpf_uprobe_multi_link *umulti_link;
> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> +       bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, u=
multi_link->cnt);
> +}
> +
> +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> +{
> +       struct bpf_uprobe_multi_link *umulti_link;
> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> +       path_put(&umulti_link->path);
> +       kvfree(umulti_link->uprobes);
> +       kfree(umulti_link);
> +}
> +
> +static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
> +       .release =3D bpf_uprobe_multi_link_release,
> +       .dealloc =3D bpf_uprobe_multi_link_dealloc,
> +};
> +
> +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> +                          unsigned long entry_ip,
> +                          struct pt_regs *regs)
> +{
> +       struct bpf_uprobe_multi_link *link =3D uprobe->link;
> +       struct bpf_uprobe_multi_run_ctx run_ctx =3D {
> +               .entry_ip =3D entry_ip,
> +       };
> +       struct bpf_prog *prog =3D link->link.prog;
> +       bool sleepable =3D prog->aux->sleepable;
> +       struct bpf_run_ctx *old_run_ctx;
> +       int err =3D 0;
> +
> +       might_fault();
> +
> +       migrate_disable();
> +
> +       if (sleepable)
> +               rcu_read_lock_trace();
> +       else
> +               rcu_read_lock();
> +
> +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> +       err =3D bpf_prog_run(link->link.prog, regs);
> +       bpf_reset_run_ctx(old_run_ctx);
> +
> +       if (sleepable)
> +               rcu_read_unlock_trace();
> +       else
> +               rcu_read_unlock();
> +
> +       migrate_enable();
> +       return err;
> +}
> +
> +static int
> +uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *r=
egs)
> +{
> +       struct bpf_uprobe *uprobe;
> +
> +       uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> +       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> +}
> +
> +static int
> +uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long=
 func, struct pt_regs *regs)
> +{
> +       struct bpf_uprobe *uprobe;
> +
> +       uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> +       return uprobe_prog_run(uprobe, func, regs);
> +}
> +
> +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog)
> +{
> +       struct bpf_uprobe_multi_link *link =3D NULL;
> +       unsigned long __user *uref_ctr_offsets;
> +       unsigned long *ref_ctr_offsets =3D NULL;
> +       struct bpf_link_primer link_primer;
> +       struct bpf_uprobe *uprobes =3D NULL;
> +       unsigned long __user *uoffsets;
> +       void __user *upath;
> +       u32 flags, cnt, i;
> +       struct path path;
> +       char *name;
> +       int err;
> +
> +       /* no support for 32bit archs yet */
> +       if (sizeof(u64) !=3D sizeof(void *))
> +               return -EOPNOTSUPP;
> +
> +       if (prog->expected_attach_type !=3D BPF_TRACE_UPROBE_MULTI)
> +               return -EINVAL;
> +
> +       flags =3D attr->link_create.uprobe_multi.flags;
> +       if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> +               return -EINVAL;
> +
> +       /*
> +        * path, offsets and cnt are mandatory,
> +        * ref_ctr_offsets is optional
> +        */
> +       upath =3D u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> +       uoffsets =3D u64_to_user_ptr(attr->link_create.uprobe_multi.offse=
ts);
> +       cnt =3D attr->link_create.uprobe_multi.cnt;
> +
> +       if (!upath || !uoffsets || !cnt)
> +               return -EINVAL;
> +
> +       uref_ctr_offsets =3D u64_to_user_ptr(attr->link_create.uprobe_mul=
ti.ref_ctr_offsets);
> +
> +       name =3D strndup_user(upath, PATH_MAX);
> +       if (IS_ERR(name)) {
> +               err =3D PTR_ERR(name);
> +               return err;
> +       }
> +
> +       err =3D kern_path(name, LOOKUP_FOLLOW, &path);
> +       kfree(name);
> +       if (err)
> +               return err;
> +
> +       if (!d_is_reg(path.dentry)) {
> +               err =3D -EBADF;
> +               goto error_path_put;
> +       }
> +
> +       err =3D -ENOMEM;
> +
> +       link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> +       uprobes =3D kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> +
> +       if (!uprobes || !link)
> +               goto error_free;
> +
> +       if (uref_ctr_offsets) {
> +               ref_ctr_offsets =3D kvcalloc(cnt, sizeof(*ref_ctr_offsets=
), GFP_KERNEL);
> +               if (!ref_ctr_offsets)
> +                       goto error_free;
> +       }
> +
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
> +#else /* !CONFIG_UPROBES */
> +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_UPROBES */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 7abb382dc6c1..f112a0b948f3 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1039,6 +1039,7 @@ enum bpf_attach_type {
>         BPF_NETFILTER,
>         BPF_TCX_INGRESS,
>         BPF_TCX_EGRESS,
> +       BPF_TRACE_UPROBE_MULTI,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> @@ -1057,6 +1058,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_STRUCT_OPS =3D 9,
>         BPF_LINK_TYPE_NETFILTER =3D 10,
>         BPF_LINK_TYPE_TCX =3D 11,
> +       BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
>         MAX_BPF_LINK_TYPE,
>  };
>
> @@ -1190,6 +1192,13 @@ enum {
>         BPF_F_KPROBE_MULTI_RETURN =3D (1U << 0)
>  };
>
> +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> + */
> +enum {
> +       BPF_F_UPROBE_MULTI_RETURN =3D (1U << 0)
> +};
> +
>  /* link_create.netfilter.flags used in LINK_CREATE command for
>   * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
>   */
> @@ -1626,6 +1635,13 @@ union bpf_attr {
>                                 };
>                                 __u64           expected_revision;
>                         } tcx;
> +                       struct {
> +                               __aligned_u64   path;
> +                               __aligned_u64   offsets;
> +                               __aligned_u64   ref_ctr_offsets;
> +                               __u32           cnt;
> +                               __u32           flags;
> +                       } uprobe_multi;
>                 };
>         } link_create;
>
> --
> 2.41.0
>


--=20
Regards
Yafang

