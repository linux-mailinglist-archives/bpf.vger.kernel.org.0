Return-Path: <bpf+bounces-78596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59668D1430F
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 17:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BADC430AAD26
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC4D374166;
	Mon, 12 Jan 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqEtEnHo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90736E48F
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236721; cv=none; b=lc9SpBHfKo6CbhjApY+Ym27MDw1bQuz6QUq5DJ9/b2dbvK+kaFb2AajUfVtVbFbq8LtJpjqz3fZZycEf5ilqLlcNQYpcRExrgdEIManIUqNmYoJseev8mR/nj5+IwF8EpAQDiaLIBHZhKcCWm/rZwJN+D9vnDO//VJ+45whi07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236721; c=relaxed/simple;
	bh=oPWEAISgUGdw2XwaK6Mfd29eUN8CUkv+wYN3SSiDp4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8KvHLpNJG1dJzf7WN59g0ETja4SpnbsKw5KX8G58knPMFcKDZHnyDgCFmQUsiqf77T9c5PzUIX+0SswZaw8EiGiDXjSjWYbFYrKArAc0YGcMtEyJBdwEkQcc2u/W7XdJy7Ip07XiVMs3vz5M0OdT8NvwFXgmjzx627663msgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqEtEnHo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f47610542so719639b3a.0
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768236716; x=1768841516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOeoOwMHmDzbGFKbniEOK8z4y4bC2uWodfWgqo8H1Yw=;
        b=QqEtEnHotwaNxgvD7cVYK1oBbBrpTJAFGdoU5U5RxscDNelqttmXHwsRLKwrtEtQx2
         TRScMtrrMO0ebzcDKk9OUrBCHpjoZUJLwYeG38Mg1Cm61rG8OfIwxAFZPTH0AwrZz8DT
         Sa9HBxYcSG0Rx2TzZRIZSCC4fjY14ehhIxcdCR4P4K1k89rtWPl/aDAr8mS1gF2dea5+
         uCiKtNMt9xtl+LMFDtuzgH2Kyz8J7y8a8A8xnxJG0RdUXvhp4xigtPECM8blAULpSGVB
         bHmkFfbUZGepWoFUxiQh/ehne1xjNNNeGPwMUAxYrS2x2hiWyV2n8OQH4exGcLfb2lOa
         YtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236716; x=1768841516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOeoOwMHmDzbGFKbniEOK8z4y4bC2uWodfWgqo8H1Yw=;
        b=vZmYhxfTQWvfMMccANppxIrHBRENJ7qukYVsEZ3UKFIqQLN6CyMCcG4mwOfcRYYobO
         7XpTxgxC3GSBD3i+MxAS8W3OQigrKm8TVBiz4NVh47tgmHkl1BsQykI8pGeezdiwJwQP
         3L0q5Y74DWjUZjr5O83qP6RIvlHCMK0/kShzeDsmJwCTl7LEO+/v9gc+2Ih3Ekyl7vsO
         H6Re7X7WVdkCKkXavXm1p0g5XmtNT49zubuWJ6aNRJ8Cf7ZlAkE/QRcR5/PcThiEUc8A
         IxfEimjQZXM8i4/lpfev1XvYhuKx6tBdUa7pcfrF5126l6qsdzMmNdnxH+xwOwuLFpZG
         tPSw==
X-Forwarded-Encrypted: i=1; AJvYcCUhsgLNgQDSSP+iKN+BzeYZUBi33g1DWctGXVt+xg3SbSF6/PuLawfF+I5Vu7hihNtbhGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+oE8Oc9HnrUZf/hT6Ui+tlnxH1rGtiwiN+YSvz54rfsTWO2Rl
	xSlnO2WnM8cjmaYwk3RJVOJ70s1EJnFPEujl53MX8E5z30Yi0pLMC9DHRy8YlSVZp/1avUALhd8
	XtUsb24yyMQk0GgT97M9jwpO7oCAihuY=
X-Gm-Gg: AY/fxX5zXmhEjlYiY1/Waj4r3L3EKHEUfDMpZFVxDwPhXp/pqRACl+LSdqXe2D/OcIC
	7CoaQBz5zXw42rFxenB0l63zFkNOdqwg9IjleMh1m0VwFx2OMYdcbNjMyRUZYNoWPW9OxiFiTzS
	7fsL/zUstgStQqxxTgUwIu7BEOUnoceC7pJ7F0Ausc1YU4agA4oyJ1PvPdn+sDE8vlFbkMnHL9E
	jFyvLnLqQin00/I22QpuvPMMM+y0moDtXUigzopZ/jkEIxU6+QPMrCFtAkCWxxTqak1fqoaQXyt
	UMDIIQ9bGcw=
X-Google-Smtp-Source: AGHT+IHpcL/jrMfaVKYVv2Vmo4D4Rsx+43kF3ghLcsFje4ny2P6YGshIuc0++jR6THqTUOsnyix/wK3BvYdpoDPAuLM=
X-Received: by 2002:a17:90b:4a03:b0:34c:7183:e290 with SMTP id
 98e67ed59e1d1-34f68cb9059mr15734618a91.31.1768236716105; Mon, 12 Jan 2026
 08:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-5-ihor.solodrai@linux.dev> <CAEf4BzYcZ5pLCvfn8uWiKCjpBXBw9dxR_WZnKxVz1Bhf96xOGg@mail.gmail.com>
 <2ea17ba8-3248-4a01-8fed-183ce66aa39c@linux.dev>
In-Reply-To: <2ea17ba8-3248-4a01-8fed-183ce66aa39c@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jan 2026 08:51:43 -0800
X-Gm-Features: AZwV_Qg0FelBjTSuRjxLeKGaPcvF08JVWSwy_aAsOkGDzWQ7k8l8Eu_znO2CnnE
Message-ID: <CAEf4BzYuchyyw9M6eQo0Gou=09PcM-o_Ay7D8DM1gDitiG6Tbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] resolve_btfids: Support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:15=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 1/9/26 3:25 PM, Andrii Nakryiko wrote:
> > On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> Implement BTF modifications in resolve_btfids to support BPF kernel
> >> functions with implicit arguments.
> >>
> >> For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
> >> prototype is added to BTF that does not have implicit arguments. The
> >> kfunc's prototype is then updated to a new one in BTF. This prototype
> >> is the intended interface for the BPF programs.
> >>
> >> A <func_name>_impl function is added to BTF to make the original kfunc
> >> prototype searchable for the BPF verifier. If a <func_name>_impl
> >> function already exists in BTF, its interpreted as a legacy case, and
> >> this step is skipped.
> >>
> >> Whether an argument is implicit is determined by its type:
> >> currently only `struct bpf_prog_aux *` is supported.
> >>
> >> As a result, the BTF associated with kfunc is changed from
> >>
> >>     __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);
> >>
> >> into
> >>
> >>     bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
> >>     __bpf_kfunc bpf_foo(int arg1);
> >>
> >> For more context see previous discussions and patches [1][2].
> >>
> >> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38=
c9@linux.dev/
> >> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai=
@linux.dev/
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  tools/bpf/resolve_btfids/main.c | 282 +++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 282 insertions(+)
> >>
> >> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfid=
s/main.c
> >> index df39982f51df..b361e726fa36 100644
> >> --- a/tools/bpf/resolve_btfids/main.c
> >> +++ b/tools/bpf/resolve_btfids/main.c
> >> @@ -152,6 +152,18 @@ struct object {
> >>         int nr_typedefs;
> >>  };
> >>
> >> +#define KF_IMPLICIT_ARGS (1 << 16)
> >> +#define KF_IMPL_SUFFIX "_impl"
> >> +#define MAX_BPF_FUNC_REG_ARGS 5
> >> +#define MAX_KFUNCS 256
> >> +#define MAX_DECL_TAGS (MAX_KFUNCS * 4)
> >
> > can't we get that from include/linux/bpf.h? seems like
> > resolve_btfids's main.c include internal headers just fine, so why
> > duplicate definitions?
>
> Hi Andrii, thank you for a quick review.
>
> Including internal include/linux/btf.h directly doesn't work, which is
> probably expected.
>
> resolve_btfids is currently built with:
>
> HOSTCFLAGS_resolve_btfids +=3D -g \
>           -I$(srctree)/tools/include \
>           -I$(srctree)/tools/include/uapi \

so I don't know if that will solve the issue, but I don't think it
makes sense to build resolve_btfids using tools' version of includes.
tools/include is mostly for perf's benefit (maybe so that they don't
accidentally take some kernel-internal dependency, not sure). But
resolve_btfids is built for the kernel during the kernel build, we
should have access to full kernel headers. Try changing this and see
if build errors go away?

>           -I$(LIBBPF_INCLUDE) \
>           -I$(SUBCMD_INCLUDE) \
>           $(LIBELF_FLAGS) \
>           -Wall -Werror
>
> If I add -I$(srctree)/include option and then
>
>     #include <linux/btf.h>
>
> A bunch of build errors happen.
>
> AFAIU we'd have to create a stripped copy of relevant headers in
> tools/include first.  Is that what you're suggesting?

see above, the opposite -- just use -I$(srctree)/include directly

[...]

> >> +               addr =3D id->addr[0];
> >> +               off =3D addr - obj->efile.idlist_addr;
> >> +               set8 =3D data->d_buf + off;
> >> +
> >> +               for (i =3D 0; i < set8->cnt; i++) {
> >> +                       if (set8->pairs[i].flags & flags) {
> >
> > invert condition and continue, reduce nesting?
> >
> >> +                               if (nr_kfuncs >=3D kfunc_ids_sz) {
> >
> > it's silly to set static limits like this: we are not in NMI, you have
> > memory allocator, use it
>
> I kinda like that btf2btf_context is stack allocated, but I see your
> point. It's not necessary to set hard limits in resolve_btfids.
>

I don't think we'll notice the performance difference. We had similar
statically-sized things for BTF processing in pahole, and very quickly
ran into limitations and had to change them to dynamically allocated.
Let's not do this again. realloc() is a bit more annoying to use, but
no big deal, it's C after all.

> >
> >> +                                       pr_err("ERROR: resolve_btfids:=
 too many kfuncs with flags %u - limit %d\n",
> >> +                                              flags, kfunc_ids_sz);
> >> +                                       return -E2BIG;
> >> +                               }
> >> +                               kfunc_ids[nr_kfuncs++] =3D set8->pairs=
[i].id;

[...]

> >> +               err =3D btf__add_decl_tag(btf, tag_name, new_func_id, =
-1);
> >
> > decl_tag can apply to arguments as well (that -1 will be actually >=3D
> > 0), we should copy those as well, no?
>
> I think you're right. Technically decl_tags can point to parameters as
> well.  Is this actually used in kernel BTF?

I don't remember, but it doesn't matter. We have to clone them as well.

>
> For the type tags we don't have to do anything though, because the
> param type should point to the top type tag, right?

Yeah, type tags are part of type chains, if we reuse types, we'll be
reusing type_tags.

>
> >
> >> +               if (err < 0) {
> >> +                       pr_err("ERROR: resolve_btfids: failed to add d=
ecl tag %s for %s\n",
> >> +                              tag_name, tmp_name);
> >> +                       return -EINVAL;
> >> +               }
> >> +       }
> >> +

[...]

