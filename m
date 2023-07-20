Return-Path: <bpf+bounces-5544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5889475B94D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 23:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134B5282025
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 21:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F19168BA;
	Thu, 20 Jul 2023 21:08:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EA168A9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 21:08:32 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D04271D
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 14:08:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so1726799a12.3
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689887307; x=1690492107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoHtNL4PXhr0FtPz2N1fQmAbvE6jz3lcgIuE82ALLYE=;
        b=i5AAKTwkXLW0Dv7WigTSfpVDoGA19TtgXik3VrT9egUtK2C9gV1vrZtHGBPIa9Q+6c
         l4l+7WHIOhSiIlUfFjaovIE0l3T9hilGcuBEyXLq2jfOB3Lv2Q5BFDoqtVwgW2jup8nQ
         WZP9FWtV3VqEg1TvGYrbprFU0GW0cCl3TL/6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689887307; x=1690492107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoHtNL4PXhr0FtPz2N1fQmAbvE6jz3lcgIuE82ALLYE=;
        b=axNskPDqHyBqejZ2yBoWoKPC/e/kDF3BEElEER5skIDAyrSfn7yDNphVBCBzKHO2Y/
         K7NsSDdXnU0nvWTlyzjry3iqlNVQH81UPyE8j58vmfgr9gwAlb57QUZE+kptCiEDFsJB
         Nozu9YFyRchhnOh7bOu4+hR1tD4kWCUGreql8mUGIp45sF8MqcXSXsFGgLG+qsB0ZnMq
         rRg+fh9sExWjOjtImb8MKiGk3k8pta1Ss/mYUeU0Rm6a0KaPerZf/kkSpYUryXrvekmO
         GM42f20XG/Orcxkrm3qkyC0+r+6hhHkZYJSKKZAAr9yQgbUrJ1/Is9VBeQpTsRRUJOVg
         5GLw==
X-Gm-Message-State: ABy/qLaWSG20R6Fs0lHrdo77SBS/CMHkPPpmLYinz4iMdrBNrOMFO5Bu
	FX2E9q7aXvfypqvNL+yEdOCs2bjUmhEpDD02RU9viA==
X-Google-Smtp-Source: APBJJlF59GKvvggJx+Z+NiV3vfiHFC863z4aZJyNTGrHiP0+uGJnNY8jUw/pTHec/vQg/JLZYmr66ZDSJkh1ZrrjpPc=
X-Received: by 2002:a05:6402:344f:b0:521:d967:ef83 with SMTP id
 l15-20020a056402344f00b00521d967ef83mr45456edc.5.1689887307415; Thu, 20 Jul
 2023 14:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi3iyagrnN=2uMbq_K0c4FzporQ1pbUmkUZKsiQ22srP3A@mail.gmail.com>
 <c61496fc-9ed4-9e65-1844-10d4e862e07f@oracle.com>
In-Reply-To: <c61496fc-9ed4-9e65-1844-10d4e862e07f@oracle.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 20 Jul 2023 16:08:16 -0500
Message-ID: <CAO3-PbrZ5W0KOZ5Rydc=bmhQ1ngn5rjkOuCZ9BAMYp6WNbMmEg@mail.gmail.com>
Subject: Re: CAP_SYS_ADMIN required for BTF in modules
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ivan Babrou <ivan@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 12:59=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 20/07/2023 18:40, Ivan Babrou wrote:
> > Hello,
> >
> > I noticed that CAP_SYS_ADMIN is required to attach BTF enabled probes
> > for modules. Attaching them for compiled-in points works just fine
> > without it.
> >
> > The reason is that libbpf calls into bpf_obj_get_next_id:
> >
> > #0  bpf_obj_get_next_id (start_id=3Dstart_id@entry=3D0,
> > next_id=3Dnext_id@entry=3D0x7fffcbffe578, cmd=3Dcmd@entry=3D23) at bpf.=
c:908
> > #1  0x00000000008bc08a in bpf_btf_get_next_id
> > (start_id=3Dstart_id@entry=3D0, next_id=3Dnext_id@entry=3D0x7fffcbffe57=
8) at
> > bpf.c:930
> > #2  0x00000000008ca252 in load_module_btfs
> > (obj=3Dobj@entry=3D0x7fffc4004a40) at libbpf.c:5365
> > #3  0x00000000008ca508 in find_kernel_btf_id
> > (btf_type_id=3D0x7fffcbffe73c, btf_obj_fd=3D0x7fffcbffe738,
> > attach_type=3DBPF_TRACE_FENTRY, attach_name=3D0xf8b647
> > "nfnetlink_rcv_msg", obj=3D0x7fffc4004a40) at libbpf.c:9057
> > #4  find_kernel_btf_id (obj=3D0x7fffc4004a40, attach_name=3D0xf8b647
> > "nfnetlink_rcv_msg", attach_type=3DBPF_TRACE_FENTRY,
> > btf_obj_fd=3D0x7fffcbffe738, btf_type_id=3D0x7fffcbffe73c) at
> > libbpf.c:9042
> > #5  0x00000000008ca755 in libbpf_find_attach_btf_id
> > (btf_type_id=3D0x7fffcbffe73c, btf_obj_fd=3D0x7fffcbffe738,
> > attach_name=3D0xf8b647 "nfnetlink_rcv_msg", prog=3D0x7fffc401d5b0) at
> > libbpf.c:9109
> > #6  libbpf_prepare_prog_load (prog=3D0x7fffc401d5b0,
> > opts=3D0x7fffcbffe7c0, cookie=3D<optimized out>) at libbpf.c:6668
> > #7  0x00000000008c3eb5 in bpf_object_load_prog
> > (obj=3Dobj@entry=3D0x7fffc4004a40, prog=3Dprog@entry=3D0x7fffc401d5b0,
> > insns=3D0x7fffc400ccc0, insns_cnt=3D87,
> > license=3Dlicense@entry=3D0x7fffc4004a50 "GPL",
> >     kern_version=3D<optimized out>, prog_fd=3D0x7fffc401d628) at libbpf=
.c:6741
> > #8  0x00000000008d0294 in bpf_object__load_progs (log_level=3D<optimize=
d
> > out>, obj=3D<optimized out>) at libbpf.c:7085
> > #9  bpf_object_load (extra_log_level=3D0, target_btf_path=3D0x0,
> > obj=3D<optimized out>) at libbpf.c:7656
> > #10 bpf_object__load (obj=3D<optimized out>) at libbpf.c:7703
> > #11 0x00000000008b90e7 in _cgo_58a414c63447_Cfunc_bpf_object__load
> > (v=3D0xc000237bd8) at cgo-gcc-prolog:1232
> > #12 0x000000000046c224 in runtime.asmcgocall () at
> > /usr/local/go/src/runtime/asm_amd64.s:848
> > #13 0x00007fffcbfff260 in ?? ()
> > #14 0x000000000041020e in runtime.persistentalloc.func1 () at
> > /usr/local/go/src/runtime/malloc.go:1393
> > #15 0x000000000046a3a9 in runtime.systemstack () at
> > /usr/local/go/src/runtime/asm_amd64.s:496
> > #16 0x00007fffffffdf6f in ?? ()
> > #17 0x0100000000000000 in ?? ()
> > #18 0x0000000000800000 in
> > github.com/golang/protobuf/ptypes/timestamp.file_github_com_golang_prot=
obuf_ptypes_timestamp_timestamp_proto_init
> > ()
> >     at /home/builder/go/pkg/mod/github.com/golang/protobuf@v1.5.2/ptype=
s/timestamp/timestamp.pb.go:57
> > #19 0x0000000000000000 in ?? ()
> >
> > Here it is in code, where it happens after vmlinux does not find the
> > requested id:
> >
> > * https://github.com/libbpf/libbpf/blob/v1.2.0/src/libbpf.c#L9219
> >
> > And in turn bpf_obj_get_next_id requires CAP_SYS_ADMIN here:
> >
> > * https://elixir.bootlin.com/linux/v6.5-rc1/source/kernel/bpf/syscall.c=
#L3790
> >
> > The requirement comes from commit 34ad558 ("bpf: Add
> > BPF_(PROG|MAP)_GET_NEXT_ID command") from v4.13:
> >
> > * https://github.com/torvalds/linux/commit/34ad558
> >
> > There's also this in the commit message: It is currently limited to
> > CAP_SYS_ADMIN which we can consider to lift it in followup patches.
> >
> > Later in v5.4 commit 341dfcf ("btf: expose BTF info through sysfs")
> > exposed BTF info via sysfs:
> >
> > * https://github.com/torvalds/linux/commit/341dfcf
> >
> > This info is world readable and it doesn't require any special capabili=
ties:
> >
> > static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init =3D {
> >   .attr =3D { .name =3D "vmlinux", .mode =3D 0444, },
> >   .read =3D btf_vmlinux_read,
> > };
> >
> > $ ls -l /sys/kernel/btf/vmlinux
> > -r--r--r-- 1 root root 4438336 Jul 13 06:33 /sys/kernel/btf/vmlinux
> >
> > My question is then: do we still need CAP_SYS_ADMIN? Should it be
> > CAP_BPF / CAP_PERFMON (available since v5.8) or should we drop the
> > requirement completely, since we expose vmlinux btf without any
> > restrictions?
> >
> > I'm happy to submit a patch.
> >
>
> I think it would be possible to gather module BTF data via
> /sys/kernel/btf instead of via iterating through the BTF objects, which
> is where lack of CAP_SYS_ADMIN trips up. The only problem is you won't
> have the BTF id of the module (which you get from the object), but I
> don't currently see that being used anywhere in libbpf. I might be
> missing something though.
>
sysfs does not have BTF exported if required modules have not been
loaded into the kernel. Loading modules would require SYS_ADMIN. Will
that be a problem?


> Alan
>


--=20

Yan

