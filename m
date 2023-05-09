Return-Path: <bpf+bounces-254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8D6FCA55
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F0D1C20C33
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2336116;
	Tue,  9 May 2023 15:36:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07F17FEC
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 15:36:22 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6919B9
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 08:36:16 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-757807cb299so131491285a.2
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646575; x=1686238575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPKOpGmCL4mcIusazbcE/54MtjruaeOgBKH2VxPMh1A=;
        b=oTM8iY7wjUpmUbbt3se+sAu1SRXnoWbYh/aVtGlUXI2kn9iJY3VG8B0dZt7MSpHHWq
         Kd7ZcXKusK68xflhqUv2yapmKBhAJfClBa6jYtif+Fgsuh3pFMwiWCQwrtiyN+9q/nQl
         vvnxXQUgQobYAtxaSCStwTb7iy8r8jWNDDa/BgWlTYAhKTHgpKN7gaRnD0T4MvPR2ynF
         cyGrlLXssmayVEeBTgh4K2bk6TZgvwAoIKebQJviytopfrsRDA9XN6eVy3MUqDyebYc9
         emMS8M1NwglZrppK0TCyrgwATQzau8vvmpi7m4sebQuJdkypzwvf27nU/N969sIErpcH
         FJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646575; x=1686238575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPKOpGmCL4mcIusazbcE/54MtjruaeOgBKH2VxPMh1A=;
        b=aCsbLdNUBErNhw0jmH027kW1OfJOf/as3zSY4SoJzUZw55JlNrnixqsN1r5I4TYKED
         /yry35hB3xGNRKn13RuAprlLLffgFS1gUKt4SUO1deh85qfcnH/ZQ3kJz3zWhLn77xo9
         R3fI8DEu81vtHV77nzw/O+Fv3Ti07/q4pzd4eEVzsRBKGyF+bwPlewCMqM39KZX06OPW
         HZe+4sb3FsVHIFViyREwh/mKp8namSMMhMoMnlCGXzyUWRzZqheIV9H7ex5sn8Oo78qr
         rr+UVqJydcvpJ2Zxb9zMJiC8tmoHkZVDgvjrdFu3Axj9rOOzOE8LmXKptucYSLDXrW5s
         852A==
X-Gm-Message-State: AC+VfDxT+bQ32tq5R18mnEEWNpLA68Ly6E4PQ0DnkHSgXlLXyy1M6KzF
	QSzkbxPPg1K+rXaT8uMfKXGa/X0bTEHLWM2+TNg=
X-Google-Smtp-Source: ACHHUZ4IlNB1JnUiY6L3cyuPD6OLg5EEg+cp2yh/kf3VR/i7wz6dxepdQ1t5FlR626AdnznCvPMnJSiCYMO+zERMFuE=
X-Received: by 2002:ad4:5945:0:b0:61c:3c0e:f5a7 with SMTP id
 eo5-20020ad45945000000b0061c3c0ef5a7mr16489046qvb.15.1683646575666; Tue, 09
 May 2023 08:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230424161104.3737-1-laoar.shao@gmail.com> <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com> <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
In-Reply-To: <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 9 May 2023 23:35:39 +0800
Message-ID: <CALOAHbAnGLYV9H2t=4rHxdmXwUhXbsUEvK5-MLPq38JkUR8jGw@mail.gmail.com>
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 2, 2023 at 11:40=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Alan,
>
> wdyt on below?
>

Hi Alexei,

Per my understanding, not only does pahole have issues, but also there
are issues in the kernel.
This panic is caused by the inconsistency between BTF and kallsyms as such:
   bpf_check_attach_target
       tname =3D btf_name_by_offset(btf, t->name_off); // btf
       addr =3D kallsyms_lookup_name(tname); // kallsyms

So if the function displayed in /proc/sys/btf/vmlinux is not the same
with the function displayed in /proc/kallsyms, we will get a wrong
addr.  I think it is not proper to rely wholly on the userspace tools
to make them the same. The kernel should also imrpve the verifier to
make sure they are really the same function.  WDYT?

> On Thu, Apr 27, 2023 at 4:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Tue, Apr 25, 2023 at 5:13=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 24, 2023 at 9:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > The kernel will panic as follows when attaching fexit to mm_init,
> > > >
> > > > [   86.549700] ------------[ cut here ]------------
> > > > [   86.549712] BUG: kernel NULL pointer dereference, address: 00000=
00000000078
> > > > [   86.549713] #PF: supervisor read access in kernel mode
> > > > [   86.549715] #PF: error_code(0x0000) - not-present page
> > > > [   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
> > > > [   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > [   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not =
tainted 6.3.0-rc6+ #12
> > > > [   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
> > > > [   86.549754] Call Trace:
> > > > [   86.549755]  <TASK>
> > > > [   86.549757]  check_preempt_curr+0x5e/0x70
> > > > [   86.549761]  ttwu_do_activate+0xab/0x350
> > > > [   86.549763]  try_to_wake_up+0x314/0x680
> > > > [   86.549765]  wake_up_process+0x15/0x20
> > > > [   86.549767]  insert_work+0xb2/0xd0
> > > > [   86.549772]  __queue_work+0x20a/0x400
> > > > [   86.549774]  queue_work_on+0x7b/0x90
> > > > [   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_help=
er]
> > > > [   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
> > > > [   86.549813]  soft_cursor+0x1cb/0x250
> > > > [   86.549816]  bit_cursor+0x3ce/0x630
> > > > [   86.549818]  fbcon_cursor+0x139/0x1c0
> > > > [   86.549821]  ? __pfx_bit_cursor+0x10/0x10
> > > > [   86.549822]  hide_cursor+0x31/0xd0
> > > > [   86.549825]  vt_console_print+0x477/0x4e0
> > > > [   86.549828]  console_flush_all+0x182/0x440
> > > > [   86.549832]  console_unlock+0x58/0xf0
> > > > [   86.549834]  vprintk_emit+0x1ae/0x200
> > > > [   86.549837]  vprintk_default+0x1d/0x30
> > > > [   86.549839]  vprintk+0x5c/0x90
> > > > [   86.549841]  _printk+0x58/0x80
> > > > [   86.549843]  __warn_printk+0x7e/0x1a0
> > > > [   86.549845]  ? trace_preempt_off+0x1b/0x70
> > > > [   86.549848]  ? trace_preempt_on+0x1b/0x70
> > > > [   86.549849]  ? __percpu_counter_init+0x8e/0xb0
> > > > [   86.549853]  refcount_warn_saturate+0x9f/0x150
> > > > [   86.549855]  mm_init+0x379/0x390
> > > > [   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
> > > > [   86.549862]  mm_init+0x5/0x390
> > > > [   86.549865]  ? mm_alloc+0x4e/0x60
> > > > [   86.549866]  alloc_bprm+0x8a/0x2e0
> > > > [   86.549869]  do_execveat_common.isra.0+0x67/0x240
> > > > [   86.549872]  __x64_sys_execve+0x37/0x50
> > > > [   86.549874]  do_syscall_64+0x38/0x90
> > > > [   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > >
> > > > The reason is that when we attach the btf id of the function mm_ini=
t we
> > > > actually attach the mm_init defined in init/main.c rather than the
> > > > function defined in kernel/fork.c. That can be proved by parsing
> > > > /sys/kernel/btf/vmlinux:
> > > >
> > > > [2493] FUNC 'initcall_blacklist' type_id=3D2477 linkage=3Dstatic
> > > > [2494] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D1
> > > >         'buf' type_id=3D57
> > > > [2495] FUNC 'early_randomize_kstack_offset' type_id=3D2494 linkage=
=3Dstatic
> > > > [2496] FUNC 'mm_init' type_id=3D118 linkage=3Dstatic
> > > > [2497] FUNC 'trap_init' type_id=3D118 linkage=3Dstatic
> > > > [2498] FUNC 'thread_stack_cache_init' type_id=3D118 linkage=3Dstati=
c
> > > >
> > > > From the above information we can find that the FUNCs above and bel=
ow
> > > > mm_init are all defined in init/main.c. So there's no doubt that th=
e
> > > > mm_init is also the function defined in init/main.c.
> > > >
> > > > So when a task calls mm_init and thus the bpf trampoline is trigger=
ed it
> > > > will use the information of the mm_init defined in init/main.c. The=
n the
> > > > panic will occur.
> > > >
> > > > It seems that there're issues in btf, for example it is unnecessary=
 to
> > > > generate btf for the functions annonated with __init. We need to im=
prove
> > > > btf. However we also need to change the function defined in
> > > > kernel/fork.c to task_mm_init to better distinguish them. After it =
is
> > > > renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:
> > > >
> > > > [13970] FUNC 'mm_alloc' type_id=3D13969 linkage=3Dstatic
> > > > [13971] FUNC_PROTO '(anon)' ret_type_id=3D204 vlen=3D3
> > > >         'mm' type_id=3D204
> > > >         'p' type_id=3D197
> > > >         'user_ns' type_id=3D452
> > > > [13972] FUNC 'task_mm_init' type_id=3D13971 linkage=3Dstatic
> > > > [13973] FUNC 'coredump_filter_setup' type_id=3D3804 linkage=3Dstati=
c
> > > > [13974] FUNC_PROTO '(anon)' ret_type_id=3D197 vlen=3D2
> > > >         'orig' type_id=3D197
> > > >         'node' type_id=3D21
> > > > [13975] FUNC 'dup_task_struct' type_id=3D13974 linkage=3Dstatic
> > > >
> > > > And then attaching task_mm_init won't panic. Improving the btf will=
 be
> > > > handled later.
> > >
> > > We're not going to hack the kernel to workaround pahole issue.
> > > Let's fix pahole instead.
> > > cc-ing Alan for ideas.
> >
> > Any comment on it, Alan ?
> > I think we can just skip generating BTF for the functions in
> > __section(".init.text"),  as these functions will be freed after
> > kernel init. There won't be use cases for them.
> >
> > --
> > Regards
> > Yafang



--=20
Regards
Yafang

