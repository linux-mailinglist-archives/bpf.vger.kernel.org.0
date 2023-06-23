Return-Path: <bpf+bounces-3286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7131973BC7E
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E6D281C98
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25183100B6;
	Fri, 23 Jun 2023 16:24:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A5100B1
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:24:38 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3A2710
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:24:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so10482015e9.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687537474; x=1690129474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAepDwhiN3CLBcNNWZJv7GZnSmbtt3RCJndN6OguT7U=;
        b=ke/Dbezme7VtLYgpAH9DUK17kmPfaLnorHjG6N4gcbG0q6YX0Fs3TCJ0n4djyyG9H9
         PhbFjTERBcMHbO4WXkhRh+KV4cuCc8/8W4P+EMd978I0jGryROnNQhDbUjo3n9BG4ig6
         v4UH0QABeITmVHMIjcwcC2wCOWHsVGn/d62jCOGK5p5ZMikS27Z1BFk498OaJ43wuMCg
         jybzERefsEnNhcUTGUOosQ13RkrKmFCfLUwu2LCcACFRZr8aFmjDovs/lbTCGbd0WDaL
         qYN+K1H3QPcJisM1OYsAfimuFwmHL4Pl+0IhWvlQf7oXmbsKIDWtSnYfpj2IMIv3QlfG
         bAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537474; x=1690129474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAepDwhiN3CLBcNNWZJv7GZnSmbtt3RCJndN6OguT7U=;
        b=PzrLOLlfnG4GCBPEDGzj0mqTH1S16U1DTSP7dRHnnTBgjSEKBCrs9Ncd5ekBPEIWMl
         DzT5LUo3I3a/PIlE/dVmbqHnXjYaAp9I4NlmgEzJmJJVFnT0k8La54X8H9Qdhzb4zbCX
         4AqEu0Kh6g3TzwaBDTJD3cD6HXRDetA2gcJIlCow22E+y0Bf4lWNzQUve3Ku36M815No
         w05Ru3rehDfaHutjDRDWtKIOKszIxbBWOfhoWKZSHFYB97crshQNNOvpWrYtX+FJsnZh
         y4VhNLk0eqZiA8V9sFKGC7lXQm168loq6IMYFzGfOAzBBTo7gwqw6p3m23vKUl1Os4Y7
         i5IA==
X-Gm-Message-State: AC+VfDyxbd3YSUXE7cKeBSecxu6Xfayg0qpVYzVn89KwRXFK/G1b+jsd
	zw7zwTguk8Qzh6SkuDvsHpYcBYt/HmNYz3x0OKs=
X-Google-Smtp-Source: ACHHUZ7gydn5Jri6YwfOZpBhw7On5IQF/F0ExUOm+2gPdPD5dVvsMO+SKGDtczDBWQhRKavLWB/12HHT9+bhmdRgJfY=
X-Received: by 2002:a05:600c:2113:b0:3fa:7dfb:b7b9 with SMTP id
 u19-20020a05600c211300b003fa7dfbb7b9mr1447852wml.41.1687537474226; Fri, 23
 Jun 2023 09:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com> <ZJVViQEvUnMQN43b@krava>
In-Reply-To: <ZJVViQEvUnMQN43b@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 09:24:22 -0700
Message-ID: <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
To: Jiri Olsa <olsajiri@gmail.com>
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

On Fri, Jun 23, 2023 at 1:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jun 22, 2023 at 05:18:05PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 20, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding new multi uprobe link that allows to attach bpf program
> > > to multiple uprobes.
> > >
> > > Uprobes to attach are specified via new link_create uprobe_multi
> > > union:
> > >
> > >   struct {
> > >           __u32           flags;
> > >           __u32           cnt;
> > >           __aligned_u64   path;
> > >           __aligned_u64   offsets;
> > >           __aligned_u64   ref_ctr_offsets;
> > >   } uprobe_multi;
> > >
> > > Uprobes are defined for single binary specified in path and multiple
> > > calling sites specified in offsets array with optional reference
> > > counters specified in ref_ctr_offsets array. All specified arrays
> > > have length of 'cnt'.
> > >
> > > The 'flags' supports single bit for now that marks the uprobe as
> > > return probe.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/trace_events.h   |   6 +
> > >  include/uapi/linux/bpf.h       |  14 ++
> > >  kernel/bpf/syscall.c           |  12 +-
> > >  kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++=
++
> > >  tools/include/uapi/linux/bpf.h |  14 ++
> > >  5 files changed, 281 insertions(+), 2 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index a75c54b6f8a3..a96e46cd407e 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3516,6 +3516,11 @@ static int bpf_prog_attach_check_attach_type(c=
onst struct bpf_prog *prog,
> > >                 return prog->enforce_expected_attach_type &&
> > >                         prog->expected_attach_type !=3D attach_type ?
> > >                         -EINVAL : 0;
> > > +       case BPF_PROG_TYPE_KPROBE:
> > > +               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROB=
E_MULTI &&
> > > +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> >
> > should this be UPROBE_MULTI? this looks like your recent bug fix,
> > which already landed
> >
> > > +                       return -EINVAL;
> > > +               fallthrough;
> >
> > and I replaced this with `return 0;` ;)
>
> ugh, yes, will fix
>
> > >         default:
> > >                 return 0;
> > >         }
> > > @@ -4681,7 +4686,8 @@ static int link_create(union bpf_attr *attr, bp=
fptr_t uattr)
> > >                 break;
> > >         case BPF_PROG_TYPE_KPROBE:
> > >                 if (attr->link_create.attach_type !=3D BPF_PERF_EVENT=
 &&
> > > -                   attr->link_create.attach_type !=3D BPF_TRACE_KPRO=
BE_MULTI) {
> > > +                   attr->link_create.attach_type !=3D BPF_TRACE_KPRO=
BE_MULTI &&
> > > +                   attr->link_create.attach_type !=3D BPF_TRACE_UPRO=
BE_MULTI) {
> > >                         ret =3D -EINVAL;
> > >                         goto out;
> > >                 }
> >
> > should this be moved into bpf_prog_attach_check_attach_type() and
> > unify these checks?
>
> ok, perhaps we could move there the whole switch, will check

+1

>
> >
> > > @@ -4748,8 +4754,10 @@ static int link_create(union bpf_attr *attr, b=
pfptr_t uattr)
> > >         case BPF_PROG_TYPE_KPROBE:
> > >                 if (attr->link_create.attach_type =3D=3D BPF_PERF_EVE=
NT)
> > >                         ret =3D bpf_perf_link_attach(attr, prog);
> > > -               else
> > > +               else if (attr->link_create.attach_type =3D=3D BPF_TRA=
CE_KPROBE_MULTI)
> > >                         ret =3D bpf_kprobe_multi_link_attach(attr, pr=
og);
> > > +               else if (attr->link_create.attach_type =3D=3D BPF_TRA=
CE_UPROBE_MULTI)
> > > +                       ret =3D bpf_uprobe_multi_link_attach(attr, pr=
og);
> > >                 break;
> > >         default:
> > >                 ret =3D -EINVAL;
> >
> > [...]
> >
> > > +static void bpf_uprobe_unregister(struct path *path, struct bpf_upro=
be *uprobes,
> > > +                                 u32 cnt)
> > > +{
> > > +       u32 i;
> > > +
> > > +       for (i =3D 0; i < cnt; i++) {
> > > +               uprobe_unregister(d_real_inode(path->dentry), uprobes=
[i].offset,
> > > +                                 &uprobes[i].consumer);
> > > +       }
> > > +}
> > > +
> > > +static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> > > +{
> > > +       struct bpf_uprobe_multi_link *umulti_link;
> > > +
> > > +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_li=
nk, link);
> > > +       bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobe=
s, umulti_link->cnt);
> > > +       path_put(&umulti_link->path);
> > > +}
> > > +
> > > +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> > > +{
> > > +       struct bpf_uprobe_multi_link *umulti_link;
> > > +
> > > +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_li=
nk, link);
> > > +       kvfree(umulti_link->uprobes);
> > > +       kfree(umulti_link);
> > > +}
> > > +
> > > +static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
> > > +       .release =3D bpf_uprobe_multi_link_release,
> > > +       .dealloc =3D bpf_uprobe_multi_link_dealloc,
> > > +};
> > > +
> > > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > +                          unsigned long entry_ip,
> > > +                          struct pt_regs *regs)
> > > +{
> > > +       struct bpf_uprobe_multi_link *link =3D uprobe->link;
> > > +       struct bpf_uprobe_multi_run_ctx run_ctx =3D {
> > > +               .entry_ip =3D entry_ip,
> > > +       };
> > > +       struct bpf_prog *prog =3D link->link.prog;
> > > +       struct bpf_run_ctx *old_run_ctx;
> > > +       int err =3D 0;
> > > +
> > > +       might_fault();
> > > +
> > > +       rcu_read_lock_trace();
> >
> > we don't need this if uprobe is not sleepable, right? why unconditional=
 then?
>
> I won't pretend I understand what rcu_read_lock_trace does ;-)
>
> I tried to follow bpf_prog_run_array_sleepable where it's called
> unconditionally for both sleepable and non-sleepable progs
>
> there are conditional rcu_read_un/lock calls later on
>
> I will check

hm... Alexei can chime in here, but given here we actually are trying
to run one BPF program (not entire array of them), we do know whether
it's going to be sleepable or not. So we can avoid unnecessary
rcu_read_{lock,unlock}_trace() calls. rcu_read_lock_trace() is used
when there is going to be sleepable BPF program executed to protect
BPF maps and other resources from being freed too soon. But if we know
that we don't need sleepable, we can avoid that.

>
> >
> > > +       migrate_disable();
> > > +
> > > +       if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1))
> > > +               goto out;
> > > +
> > > +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > +
> > > +       if (!prog->aux->sleepable)
> > > +               rcu_read_lock();
> > > +
> > > +       err =3D bpf_prog_run(link->link.prog, regs);
> > > +
> > > +       if (!prog->aux->sleepable)
> > > +               rcu_read_unlock();
> > > +
> > > +       bpf_reset_run_ctx(old_run_ctx);
> > > +
> > > +out:
> > > +       __this_cpu_dec(bpf_prog_active);
> > > +       migrate_enable();
> > > +       rcu_read_unlock_trace();
> > > +       return err;
> > > +}
> > > +
> >
> > [...]
> >
> > > +
> > > +       err =3D kern_path(name, LOOKUP_FOLLOW, &path);
> > > +       kfree(name);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       if (!d_is_reg(path.dentry)) {
> > > +               err =3D -EINVAL;
> > > +               goto error_path_put;
> > > +       }
> > > +
> > > +       err =3D -ENOMEM;
> > > +
> > > +       link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> > > +       uprobes =3D kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> > > +       ref_ctr_offsets =3D kvcalloc(cnt, sizeof(*ref_ctr_offsets), G=
FP_KERNEL);
> >
> > ref_ctr_offsets is optional, but we'll unconditionally allocate this ar=
ray?
>
> true :-\ will add the uref_ctr_offsets check
>
> >
> > > +
> > > +       if (!uprobes || !ref_ctr_offsets || !link)
> > > +               goto error_free;
> > > +
> > > +       for (i =3D 0; i < cnt; i++) {
> > > +               if (uref_ctr_offsets && __get_user(ref_ctr_offset, ur=
ef_ctr_offsets + i)) {
> > > +                       err =3D -EFAULT;
> > > +                       goto error_free;
> > > +               }
> > > +               if (__get_user(offset, uoffsets + i)) {
> > > +                       err =3D -EFAULT;
> > > +                       goto error_free;
> > > +               }
> > > +
> > > +               uprobes[i].offset =3D offset;
> > > +               uprobes[i].link =3D link;
> > > +
> > > +               if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > > +                       uprobes[i].consumer.ret_handler =3D uprobe_mu=
lti_link_ret_handler;
> > > +               else
> > > +                       uprobes[i].consumer.handler =3D uprobe_multi_=
link_handler;
> > > +
> > > +               ref_ctr_offsets[i] =3D ref_ctr_offset;
> > > +       }
> > > +
> > > +       link->cnt =3D cnt;
> > > +       link->uprobes =3D uprobes;
> > > +       link->path =3D path;
> > > +
> > > +       bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> > > +                     &bpf_uprobe_multi_link_lops, prog);
> > > +
> > > +       err =3D bpf_link_prime(&link->link, &link_primer);
> > > +       if (err)
> > > +               goto error_free;
> > > +
> > > +       for (i =3D 0; i < cnt; i++) {
> > > +               err =3D uprobe_register_refctr(d_real_inode(link->pat=
h.dentry),
> > > +                                            uprobes[i].offset, ref_c=
tr_offsets[i],
> > > +                                            &uprobes[i].consumer);
> > > +               if (err) {
> > > +                       bpf_uprobe_unregister(&path, uprobes, i);
> >
> > bpf_link_cleanup() will do this through
> > bpf_uprobe_multi_link_release(), no? So you are double unregistering?
> > Either drop cnt to zero, or just don't do this here? Latter is better,
> > IMO.
>
> bpf_link_cleanup path won't call release callback so we have to do that

bpf_link_cleanup() does fput(primer->file); which eventually calls
release callback, no? I'd add printk and simulate failure just to be
sure

>
> I think I can add simple selftest to have this path covered
>
> thanks,
> jirka
>
> >
> > > +                       bpf_link_cleanup(&link_primer);
> > > +                       kvfree(ref_ctr_offsets);
> > > +                       return err;
> > > +               }
> > > +       }
> > > +
> > > +       kvfree(ref_ctr_offsets);
> > > +       return bpf_link_settle(&link_primer);
> > > +
> > > +error_free:
> > > +       kvfree(ref_ctr_offsets);
> > > +       kvfree(uprobes);
> > > +       kfree(link);
> > > +error_path_put:
> > > +       path_put(&path);
> > > +       return err;
> > > +}
> > > +#else /* !CONFIG_UPROBES */
> > > +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct =
bpf_prog *prog)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> >
> > [...]

