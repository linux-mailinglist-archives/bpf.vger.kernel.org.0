Return-Path: <bpf+bounces-3219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2373ADB8
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 02:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8C928183D
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A30191;
	Fri, 23 Jun 2023 00:18:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04407F
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 00:18:20 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C882129
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:18:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fa23c3e618so1794165e9.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687479497; x=1690071497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McycxMl886goHBfSXbLkKwNtdKFkXhTcIcaJ9Cit48A=;
        b=J06b5znPOCrDwbKzCbme+pz5fDou08sdsFHDKU7CKaldMR1wMpmHHxK1luZDSxzoxO
         TtPs2YVYCt7G9JM6oyhJXnmm3hKH7DmQ+dGp4JgDPpZkmQzQO2fgxozNS0Pj46A/qduj
         fG881u+Gcyw/9RX69aGS6uYYLh12g0ym5qPsdtcTAi9U+H2XD13F0Vgon4X54qoZrlCr
         bRjrkbYPr8Ygj3ECwGN1VAnbqAz/U7TKbAqisAU0Yr3FyD8QO+g9tNPr4u2kMqczLe8V
         cOCVlXUeNPwqxGJAKQlvhkq/Fg6j30H3WSmsPvq45Z2kkKeqZKTwo92TkxugrGHe+qgc
         cYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687479497; x=1690071497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McycxMl886goHBfSXbLkKwNtdKFkXhTcIcaJ9Cit48A=;
        b=fhTvy+7SsgkdCsEGvagNkrU5rHO7FFZhN47XsNo6Fo/+58JrcJikf6ZMNiiNnfesG9
         ApKRtxTrlTxmpO04N0M1brlchlH13MbS1vC1vGST9tMkICX2bdoqb6RmHKbeulHXNVpO
         KmYs6KXsnqgWH/duk+oEaNeS75esfB7vDpBHnWSbyermq0fcVp6mkKjPtfGxpWbtpoOY
         YPp2AmcEo6IaiSJ8LLJEy2rglOBL5irfC7r9o0zY9S35EaB214b5jh1Vw0JDE8dZhb3T
         4X8Tp0darJJj3l/+ZYP/yHOmEtA76/6zzNGg2zEmvNObg3HNzZipq3nW0e/PMRgXgdfJ
         VrzQ==
X-Gm-Message-State: AC+VfDwNXDhfDlBq+kxsRbcnFAD6thALG7Q3RQwS+gwnfmlttYnS1UJS
	2eJFO6wB+XAYHmnPuEIAkz72ZW6mjFrUVkUlQzU=
X-Google-Smtp-Source: ACHHUZ5709R7jiCYmP7tLdOUABzx6/OkVsELNdYchjlRpnfelpZdWljb/7fs7JGi4Tp0iYa6w81Uq+W8XfMBWk4rxOY=
X-Received: by 2002:a1c:6a13:0:b0:3f9:57b:b34a with SMTP id
 f19-20020a1c6a13000000b003f9057bb34amr14108929wmc.6.1687479496799; Thu, 22
 Jun 2023 17:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-2-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 17:18:05 -0700
Message-ID: <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
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

On Tue, Jun 20, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
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
>  kernel/bpf/syscall.c           |  12 +-
>  kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  14 ++
>  5 files changed, 281 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a75c54b6f8a3..a96e46cd407e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3516,6 +3516,11 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>                 return prog->enforce_expected_attach_type &&
>                         prog->expected_attach_type !=3D attach_type ?
>                         -EINVAL : 0;
> +       case BPF_PROG_TYPE_KPROBE:
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI &&
> +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)

should this be UPROBE_MULTI? this looks like your recent bug fix,
which already landed

> +                       return -EINVAL;
> +               fallthrough;

and I replaced this with `return 0;` ;)
>         default:
>                 return 0;
>         }
> @@ -4681,7 +4686,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>                 break;
>         case BPF_PROG_TYPE_KPROBE:
>                 if (attr->link_create.attach_type !=3D BPF_PERF_EVENT &&
> -                   attr->link_create.attach_type !=3D BPF_TRACE_KPROBE_M=
ULTI) {
> +                   attr->link_create.attach_type !=3D BPF_TRACE_KPROBE_M=
ULTI &&
> +                   attr->link_create.attach_type !=3D BPF_TRACE_UPROBE_M=
ULTI) {
>                         ret =3D -EINVAL;
>                         goto out;
>                 }

should this be moved into bpf_prog_attach_check_attach_type() and
unify these checks?

> @@ -4748,8 +4754,10 @@ static int link_create(union bpf_attr *attr, bpfpt=
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

[...]

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
> +       path_put(&umulti_link->path);
> +}
> +
> +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> +{
> +       struct bpf_uprobe_multi_link *umulti_link;
> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
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
> +       struct bpf_run_ctx *old_run_ctx;
> +       int err =3D 0;
> +
> +       might_fault();
> +
> +       rcu_read_lock_trace();

we don't need this if uprobe is not sleepable, right? why unconditional the=
n?

> +       migrate_disable();
> +
> +       if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1))
> +               goto out;
> +
> +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> +
> +       if (!prog->aux->sleepable)
> +               rcu_read_lock();
> +
> +       err =3D bpf_prog_run(link->link.prog, regs);
> +
> +       if (!prog->aux->sleepable)
> +               rcu_read_unlock();
> +
> +       bpf_reset_run_ctx(old_run_ctx);
> +
> +out:
> +       __this_cpu_dec(bpf_prog_active);
> +       migrate_enable();
> +       rcu_read_unlock_trace();
> +       return err;
> +}
> +

[...]

> +
> +       err =3D kern_path(name, LOOKUP_FOLLOW, &path);
> +       kfree(name);
> +       if (err)
> +               return err;
> +
> +       if (!d_is_reg(path.dentry)) {
> +               err =3D -EINVAL;
> +               goto error_path_put;
> +       }
> +
> +       err =3D -ENOMEM;
> +
> +       link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> +       uprobes =3D kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> +       ref_ctr_offsets =3D kvcalloc(cnt, sizeof(*ref_ctr_offsets), GFP_K=
ERNEL);

ref_ctr_offsets is optional, but we'll unconditionally allocate this array?

> +
> +       if (!uprobes || !ref_ctr_offsets || !link)
> +               goto error_free;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               if (uref_ctr_offsets && __get_user(ref_ctr_offset, uref_c=
tr_offsets + i)) {
> +                       err =3D -EFAULT;
> +                       goto error_free;
> +               }
> +               if (__get_user(offset, uoffsets + i)) {
> +                       err =3D -EFAULT;
> +                       goto error_free;
> +               }
> +
> +               uprobes[i].offset =3D offset;
> +               uprobes[i].link =3D link;
> +
> +               if (flags & BPF_F_UPROBE_MULTI_RETURN)
> +                       uprobes[i].consumer.ret_handler =3D uprobe_multi_=
link_ret_handler;
> +               else
> +                       uprobes[i].consumer.handler =3D uprobe_multi_link=
_handler;
> +
> +               ref_ctr_offsets[i] =3D ref_ctr_offset;
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
> +                                            uprobes[i].offset, ref_ctr_o=
ffsets[i],
> +                                            &uprobes[i].consumer);
> +               if (err) {
> +                       bpf_uprobe_unregister(&path, uprobes, i);

bpf_link_cleanup() will do this through
bpf_uprobe_multi_link_release(), no? So you are double unregistering?
Either drop cnt to zero, or just don't do this here? Latter is better,
IMO.

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

[...]

