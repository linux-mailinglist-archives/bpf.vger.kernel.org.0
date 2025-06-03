Return-Path: <bpf+bounces-59475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F1ACBE94
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F83B3A581F
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21D38DD1;
	Tue,  3 Jun 2025 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+6NNMTb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF82C326D
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748918746; cv=none; b=b1fYfvpnrdY5OTeaQ9YoRzyQ4zzZcE/8koDO8eOuLxvXeNiiufyx11Nt84TGYNG8Z7ibsp11VNUohIBwXTB57hsxpuBT6Ze+IvZDhaN/zaDuXF3KDItJyZZMH8P+1trFzKaL3F5rCn3gYvnk1+zfBllLad4BkOAJl3dy59SOs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748918746; c=relaxed/simple;
	bh=5igvRZTLcHEMwcy62oSLt498sliLyBp34eAdu6Bugo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNZyhJ9jeZvcZAgysb9vf6t3YnmpBOCFxl1rkaihheSk78U3Vtv0oJd5NzeSfafFX+Y9NhpGW4y5gC+91kpt68EY1VVYGm99mawhDx/jVRMvhkM/5ekrjzDM/IONu+Dyaj9zx4EVauXNUqWiLRMLj/eSwF1lTPwlW9GFqxt5ISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+6NNMTb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so37188875e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 19:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748918742; x=1749523542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlpZlVhvKSpm9UAt2f2WlH80jb/wvBfBvcWRf79YHMw=;
        b=R+6NNMTbeQv3THuHHQU7OXk69dBuqGc7FlBd2PKuNdcRBuHNcX6NlncHYTt3DhyHVF
         IkZH3ShqqA51xcaK0Xd/cmu0ceUDDUkbelP7JRjE661lQT9VpFP5apdAdquCVHGpTeEF
         BJpnEirJdJUpsbU++MM9AHdqIExEQ4eie1eRpM1FahoFU/Gt/E2H8jFYUMxq45+nMzSH
         bzwtUa3pyv9Gkgha++ne75LB6I+XZXDShXPBEqgSy7k9yedM7zk1VRVGeC4OLapAxDbM
         izeDwDpSH7xok5a04Te/Ha7f2stUAHhEcTUUzgmOiWIEjbV5HVJbg8Nk3yfS/VALbJe/
         lxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748918742; x=1749523542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlpZlVhvKSpm9UAt2f2WlH80jb/wvBfBvcWRf79YHMw=;
        b=W5h7TyXAiW2kJtAwiPwDvZd9jEvibmIzqvov7dZ61Dbj0+HdSCku8o+7HuXddL3EjS
         eXxlPxXQ6ZpI+jgsIDgxnx4i5cv2TtaFMusJ9aFTy64ewFVbtnoIMjEnridLlrwKARkP
         Jx6cuB8PPIbq3rRfp/R7wZ0L4uwEB2D4YV0pC+70E+iPA+IHwQ4hLPgIGrv5X9Fz8qzp
         4B+EPVW1/egZqEYGo1jlKcy+VDn/q2PgceFavFJSwUFmJHmFTpXS54n4fGuYPniDsUkf
         od0RB+qP/ayTJsO5f1vnK1rhFn+wSS8A7HbYgUTEaWNSyj3sFeDSDHBq9Aqn8jSyy8g6
         JGYw==
X-Gm-Message-State: AOJu0Yyq13tx/H2/5EvshRIVYmfVeYC8FzlatGutUSaZjnRkLxUDqBrF
	gPdojVyq4T6wfd++0oe0z4gejKxAGDk8U77AmVT0Fi6przrp/QbBrLl+yoLVt3qEFBFuXoJL/N5
	hiAUt0lq8kxPwXtC1PRDiiMYSxc0TYiDIxS1H
X-Gm-Gg: ASbGncvByj69B8rEuq0iizy2DrpnoXj739bSQ0iTRV9CI+o+UbTQMGjdP6ch34idDIx
	DwMhRrOJWyG1sN32GrMmJVWJAAg/UGXrE6JrQd9if8ul08pAOgUgmyKH+2XM6ylv5/hNtzlbDXp
	z5anU4PkcQcm7EbWafockyp/w+IAjhiB8GIsyTjCw1gY2FlsLtCq7QOvf3h/lTGA==
X-Google-Smtp-Source: AGHT+IEPv+jGp4lK6hr0KAkUcndFILIwXFPeilYvOWwzfZJu6HNi7YGHYg9q04gxGpPM3MzQk+tM47AL452TIv7q3UM=
X-Received: by 2002:a05:600c:35c8:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-450d8843261mr135745505e9.12.1748918742085; Mon, 02 Jun 2025
 19:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
 <20250526062555.1106061-3-houtao@huaweicloud.com> <CAADnVQLH3Ut8dF9t=_zB4acbZYuN=9+fgsACossGqFVTPO6EaQ@mail.gmail.com>
 <137a5a3f-c571-5ade-7ea1-d224ec6b36f0@huaweicloud.com>
In-Reply-To: <137a5a3f-c571-5ade-7ea1-d224ec6b36f0@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 19:45:31 -0700
X-Gm-Features: AX0GCFtkYGJWqktM2GEehXkLgYi8KlMWrlnD2cPmsXbuvzLAs6G3YdGVLTKtcts
Message-ID: <CAADnVQLBsYU0xysuqzbZCKbSZP=CLdc8FPaMsvxtrwApwVT6EQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf mem allocator dtor
 for hash map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 7:27=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 6/3/2025 7:08 AM, Alexei Starovoitov wrote:
> > On Sun, May 25, 2025 at 11:08=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> BPF hash map supports special fields in its value, and BPF program is
> >> free to manipulate these special fields even after the element is
> >> deleted from the hash map. For non-preallocated hash map, these specia=
l
> >> fields will be leaked when the map is destroyed. Therefore, implement
> >> necessary BPF memory allocator dtor to free these special fields.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/hashtab.c | 34 ++++++++++++++++++++++++++++++++--
> >>  1 file changed, 32 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index dd6c157cb828..2531177d1464 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >> @@ -128,6 +128,8 @@ struct htab_elem {
> >>         char key[] __aligned(8);
> >>  };
> >>
> >> +static void check_and_free_fields(struct bpf_htab *htab, struct htab_=
elem *elem);
> >> +
> >>  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
> >>  {
> >>         return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
> >> @@ -464,6 +466,33 @@ static int htab_map_alloc_check(union bpf_attr *a=
ttr)
> >>         return 0;
> >>  }
> >>
> >> +static void htab_ma_dtor(void *obj, void *ctx)
> >> +{
> >> +       struct bpf_htab *htab =3D ctx;
> >> +
> >> +       /* The per-cpu pointer saved in the htab_elem may have been fr=
eed
> >> +        * by htab->pcpu_ma. Therefore, freeing the special fields in =
the
> >> +        * per-cpu pointer through the dtor of htab->pcpu_ma instead.
> >> +        */
> >> +       if (htab_is_percpu(htab))
> >> +               return;
> >> +       check_and_free_fields(htab, obj);
> >> +}
> > It seems the selftest in patch 3 might be working "by accident",
> > but older tests should be crashing?
>
> Er, didn't follow the reason why the older test should be crashing.  For
> the per-cpu hash map, the per-cpu pointer gets through
> htab_elem_get_ptr() is valid until one tasks trace RCU gp passes,
> therefore, the bpf prog will always manipulate a valid per-cpu pointer.
> The comment above wants to say is that htab_elem_get_ptr() in
> htab_ma_dtor() may return a freed per-cpu pointer, because the order of
> freeing htab_elem->ptr_to_pptr and htab_elem is nondeterministic.
>
> > It looks like you're calling check_and_free_fields() twice now.
> > Once from htab_elem_free() and then again in htab_ma_dtor() ?
> >
> > If we're going for dtor then htab should delegate all clean up to it.
>
> Yes. check_and_free_fields() is called twice.

I meant that things will be crashing since it's called twice.
In bpf_obj_free_fields()
timer/wq are probably fine to be called multiple times.
list_head/rb_tree/kptr should be fine as well,
but uptr will double unpin.

I doubt we really thought through the consequences of
calling bpf_obj_free_fields() on the same map value multiple times.

> There are three possible
> locations to free the special fields:
>
> 1) when the element is freed through bpf_mem_cache_free()
> 2) before the element is reused
> 3) before the element is freed to slab.
>
> 3) is necessary to ensure these special fields will not be leaked and 1)
> is necessary to ensure these special fields will be freed before it is
> reused. I didn't find a good way to only call it once.

My point is that we have to call it once, especially since
it's recursive in obj_drop, or...
if we have to call it multiple times we need to fix uptr and
review all other special fields carefully.

> Maybe adding a
> bit flag to the pointer of the element to indicate that it has been
> destroyed is OK ? Will try it in the next revision.

Not sure what you have in mind.

