Return-Path: <bpf+bounces-3242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABA73B28F
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796932819AD
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29954210B;
	Fri, 23 Jun 2023 08:19:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159120E4
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:19:28 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A625118
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:19:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b474dac685so5906321fa.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687508365; x=1690100365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ho9jXXCFBi1Z84EFysmMVbeNudVjA25y2j1je8g3Qos=;
        b=JbRptzJUaIqB3Vj1moM3iFbSrak+rYe4BizegK1jcs3Tqfg3xT9nue9UqlFWx4Ate9
         mP+Ta/1HTFwgDZOYcp7IbKNNougDF1cZQ/nblFQiw9kTjQwqX6CTyZ0lIh5Ozp6LrDpf
         t5zLwuHgk0+gndTrXBGo10l84VMm7RcbyXpmeJ3zn7Mfb94nPAWoJ4SdwDd/V+uYfm4k
         WTWEHFVno+MUc7W5+ObFDdOvQyjOeFzzrMFwYk1wPEU7EZSWVkg5Gt6CMleR0D46p5Zj
         IJFagH8kcb0wy+2Ly2bHGTMxyfvPQFhNuTiHKLYBc3+2N9pvRsXu7z5tITV6Z6WHwnkc
         8bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508365; x=1690100365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ho9jXXCFBi1Z84EFysmMVbeNudVjA25y2j1je8g3Qos=;
        b=T5ViOQcayKd5IgShuHPlVtKVGOOj5fk0bZX6ZgNpO5pL1rpwEY2saQTuxMzJ9222w8
         E0HMBj30pDQ9RlkHm2IpbMAhlaeUHjZ1wT3x6HZi7hUL1A43eMW7iQzIFcB7kvqkjNsU
         GATjlxU26mzuFVjy7j92eboLTPdFewDfEx9aSHXMZSJ75xLaEqI3/Ii6T7O1PphBYxat
         v4hgD+DUBywENkFKmEYBN1DrHSXwU/QrK1DGtMn1qs8N4OFH2WjZHJ6aG/9ZMc+hcIFR
         m9sLdeOSU0TRGTy63jCUj4FUnRTYdopu7PnIZMvr1IA+YOB34pC59P1JPnx5O7aC8CFj
         JLrA==
X-Gm-Message-State: AC+VfDyZDlfkMIC4b8ivtEd8kiz2KZU0EHGdFKEiuwWdwjv5yW9fpRdB
	SoVMFwTdIfivU9am+DMeoUk=
X-Google-Smtp-Source: ACHHUZ43t9tyeLnRb9wohNfOl4aJaVmolDnb5urVeONFtjVuTZaMyk+KWaYUJJY6nONR4ZsfYrEb2g==
X-Received: by 2002:a05:6512:3b23:b0:4f9:6221:8fae with SMTP id f35-20020a0565123b2300b004f962218faemr3607219lfv.49.1687508363907;
        Fri, 23 Jun 2023 01:19:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c00c800b003f70a7b4537sm1602675wmm.36.2023.06.23.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:19:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Jun 2023 10:19:21 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
Message-ID: <ZJVViQEvUnMQN43b@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 05:18:05PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new multi uprobe link that allows to attach bpf program
> > to multiple uprobes.
> >
> > Uprobes to attach are specified via new link_create uprobe_multi
> > union:
> >
> >   struct {
> >           __u32           flags;
> >           __u32           cnt;
> >           __aligned_u64   path;
> >           __aligned_u64   offsets;
> >           __aligned_u64   ref_ctr_offsets;
> >   } uprobe_multi;
> >
> > Uprobes are defined for single binary specified in path and multiple
> > calling sites specified in offsets array with optional reference
> > counters specified in ref_ctr_offsets array. All specified arrays
> > have length of 'cnt'.
> >
> > The 'flags' supports single bit for now that marks the uprobe as
> > return probe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/trace_events.h   |   6 +
> >  include/uapi/linux/bpf.h       |  14 ++
> >  kernel/bpf/syscall.c           |  12 +-
> >  kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  14 ++
> >  5 files changed, 281 insertions(+), 2 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a75c54b6f8a3..a96e46cd407e 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3516,6 +3516,11 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
> >                 return prog->enforce_expected_attach_type &&
> >                         prog->expected_attach_type != attach_type ?
> >                         -EINVAL : 0;
> > +       case BPF_PROG_TYPE_KPROBE:
> > +               if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> > +                   attach_type != BPF_TRACE_KPROBE_MULTI)
> 
> should this be UPROBE_MULTI? this looks like your recent bug fix,
> which already landed
> 
> > +                       return -EINVAL;
> > +               fallthrough;
> 
> and I replaced this with `return 0;` ;)

ugh, yes, will fix

> >         default:
> >                 return 0;
> >         }
> > @@ -4681,7 +4686,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >                 break;
> >         case BPF_PROG_TYPE_KPROBE:
> >                 if (attr->link_create.attach_type != BPF_PERF_EVENT &&
> > -                   attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
> > +                   attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI &&
> > +                   attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
> >                         ret = -EINVAL;
> >                         goto out;
> >                 }
> 
> should this be moved into bpf_prog_attach_check_attach_type() and
> unify these checks?

ok, perhaps we could move there the whole switch, will check

> 
> > @@ -4748,8 +4754,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >         case BPF_PROG_TYPE_KPROBE:
> >                 if (attr->link_create.attach_type == BPF_PERF_EVENT)
> >                         ret = bpf_perf_link_attach(attr, prog);
> > -               else
> > +               else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI)
> >                         ret = bpf_kprobe_multi_link_attach(attr, prog);
> > +               else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
> > +                       ret = bpf_uprobe_multi_link_attach(attr, prog);
> >                 break;
> >         default:
> >                 ret = -EINVAL;
> 
> [...]
> 
> > +static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
> > +                                 u32 cnt)
> > +{
> > +       u32 i;
> > +
> > +       for (i = 0; i < cnt; i++) {
> > +               uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> > +                                 &uprobes[i].consumer);
> > +       }
> > +}
> > +
> > +static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> > +{
> > +       struct bpf_uprobe_multi_link *umulti_link;
> > +
> > +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +       bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
> > +       path_put(&umulti_link->path);
> > +}
> > +
> > +static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> > +{
> > +       struct bpf_uprobe_multi_link *umulti_link;
> > +
> > +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +       kvfree(umulti_link->uprobes);
> > +       kfree(umulti_link);
> > +}
> > +
> > +static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
> > +       .release = bpf_uprobe_multi_link_release,
> > +       .dealloc = bpf_uprobe_multi_link_dealloc,
> > +};
> > +
> > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > +                          unsigned long entry_ip,
> > +                          struct pt_regs *regs)
> > +{
> > +       struct bpf_uprobe_multi_link *link = uprobe->link;
> > +       struct bpf_uprobe_multi_run_ctx run_ctx = {
> > +               .entry_ip = entry_ip,
> > +       };
> > +       struct bpf_prog *prog = link->link.prog;
> > +       struct bpf_run_ctx *old_run_ctx;
> > +       int err = 0;
> > +
> > +       might_fault();
> > +
> > +       rcu_read_lock_trace();
> 
> we don't need this if uprobe is not sleepable, right? why unconditional then?

I won't pretend I understand what rcu_read_lock_trace does ;-)

I tried to follow bpf_prog_run_array_sleepable where it's called
unconditionally for both sleepable and non-sleepable progs

there are conditional rcu_read_un/lock calls later on

I will check

> 
> > +       migrate_disable();
> > +
> > +       if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
> > +               goto out;
> > +
> > +       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > +
> > +       if (!prog->aux->sleepable)
> > +               rcu_read_lock();
> > +
> > +       err = bpf_prog_run(link->link.prog, regs);
> > +
> > +       if (!prog->aux->sleepable)
> > +               rcu_read_unlock();
> > +
> > +       bpf_reset_run_ctx(old_run_ctx);
> > +
> > +out:
> > +       __this_cpu_dec(bpf_prog_active);
> > +       migrate_enable();
> > +       rcu_read_unlock_trace();
> > +       return err;
> > +}
> > +
> 
> [...]
> 
> > +
> > +       err = kern_path(name, LOOKUP_FOLLOW, &path);
> > +       kfree(name);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!d_is_reg(path.dentry)) {
> > +               err = -EINVAL;
> > +               goto error_path_put;
> > +       }
> > +
> > +       err = -ENOMEM;
> > +
> > +       link = kzalloc(sizeof(*link), GFP_KERNEL);
> > +       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> > +       ref_ctr_offsets = kvcalloc(cnt, sizeof(*ref_ctr_offsets), GFP_KERNEL);
> 
> ref_ctr_offsets is optional, but we'll unconditionally allocate this array?

true :-\ will add the uref_ctr_offsets check

> 
> > +
> > +       if (!uprobes || !ref_ctr_offsets || !link)
> > +               goto error_free;
> > +
> > +       for (i = 0; i < cnt; i++) {
> > +               if (uref_ctr_offsets && __get_user(ref_ctr_offset, uref_ctr_offsets + i)) {
> > +                       err = -EFAULT;
> > +                       goto error_free;
> > +               }
> > +               if (__get_user(offset, uoffsets + i)) {
> > +                       err = -EFAULT;
> > +                       goto error_free;
> > +               }
> > +
> > +               uprobes[i].offset = offset;
> > +               uprobes[i].link = link;
> > +
> > +               if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > +                       uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
> > +               else
> > +                       uprobes[i].consumer.handler = uprobe_multi_link_handler;
> > +
> > +               ref_ctr_offsets[i] = ref_ctr_offset;
> > +       }
> > +
> > +       link->cnt = cnt;
> > +       link->uprobes = uprobes;
> > +       link->path = path;
> > +
> > +       bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> > +                     &bpf_uprobe_multi_link_lops, prog);
> > +
> > +       err = bpf_link_prime(&link->link, &link_primer);
> > +       if (err)
> > +               goto error_free;
> > +
> > +       for (i = 0; i < cnt; i++) {
> > +               err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> > +                                            uprobes[i].offset, ref_ctr_offsets[i],
> > +                                            &uprobes[i].consumer);
> > +               if (err) {
> > +                       bpf_uprobe_unregister(&path, uprobes, i);
> 
> bpf_link_cleanup() will do this through
> bpf_uprobe_multi_link_release(), no? So you are double unregistering?
> Either drop cnt to zero, or just don't do this here? Latter is better,
> IMO.

bpf_link_cleanup path won't call release callback so we have to do that

I think I can add simple selftest to have this path covered

thanks,
jirka

> 
> > +                       bpf_link_cleanup(&link_primer);
> > +                       kvfree(ref_ctr_offsets);
> > +                       return err;
> > +               }
> > +       }
> > +
> > +       kvfree(ref_ctr_offsets);
> > +       return bpf_link_settle(&link_primer);
> > +
> > +error_free:
> > +       kvfree(ref_ctr_offsets);
> > +       kvfree(uprobes);
> > +       kfree(link);
> > +error_path_put:
> > +       path_put(&path);
> > +       return err;
> > +}
> > +#else /* !CONFIG_UPROBES */
> > +int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> 
> [...]

