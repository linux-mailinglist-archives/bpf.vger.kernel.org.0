Return-Path: <bpf+bounces-59464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F12ACBDA3
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 01:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF33A4002
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C632036FA;
	Mon,  2 Jun 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFlyhctV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698C46B8
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905739; cv=none; b=FVYi0AixldhQuYqekUjCTTAZDhw5v+myV9qKfufvLmC3eXahQwtVj2PLjyvKW3hNH1e21Is39CvtsVffo5DWLfNUihkNXqjoOZ217qwmrQxiMV+tzRNTG4i03WO/GOmpp0pJohb65QWGoemhuZ2hgeoXAbVBuiYzCe405TSBeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905739; c=relaxed/simple;
	bh=g561SlhhIXcwl6WURaYh4LY4ykGIgd4EahSkdZz2hWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRDOjbYSuMbktb8juh482CtATeNYfsteWIFwAKOiWin1pUzpyv4EiYSxTNfvqc63+UhloE+Bdb/DCkG8juOldQNpkmXtc/S8/QcWtL8v8Fjg7KLTtJWpIgVDowW17N8MoKeOKuIaIdpnXol8mGZ9qE5lsl33u3wkTVr/XXbTCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFlyhctV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a510432236so749613f8f.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748905736; x=1749510536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tv3UO8xySgKimYIn1DoGkAgyi8QmyhZkXllNEnDyC4=;
        b=kFlyhctVMwoJGZhJDKe6VxviSyISXECDa4xbTzl/c/g2KPhpNsQnd/sfzdfPWRE7fq
         Uvdg2OTKsEp7d3WWbzvIWbvF5UoVUozNOwjpZYqOJDNAId57OoTkh1cDQ4cK9WbaLERZ
         q/3bjJCT93ZKj7n+HIhLD2fDd53FLsAXMDtqklcUTCTID7N60boPA4RAqW/Fm8u1TWKa
         48b+Mx/hVu25SDdpVexMOpAPYIjGgOCyL6c38nuZu0Zk7+oVCpwTHEFELNjaoiyw14Rd
         7Uk5sXwjtKcscCX7syrEDk77zFA/oMwe9erg1E2tsbVMyZtXoicaSiUHz6HhSCD9VONI
         Ivcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748905736; x=1749510536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tv3UO8xySgKimYIn1DoGkAgyi8QmyhZkXllNEnDyC4=;
        b=aW+1uk/0YJ1z2YCa3oTKy5kLWalu4Tv8zLX2CcTGN9N072NxUpZ7Y6k/BmxfTHi667
         Kw/LYCYx7roC836IYvjZRk3IOBo9/+aRksaUnz1c1FNkZROxDvWefPyAhJxkvQ6oyOLx
         mM3MaxKkxy1EXwDqp9RaM2e1VUEcD47fh6kKJ/TR2Qqs2y+h2r24A7IJkQ2iGLxn0k3H
         dTbm64YJsGb2LbIPgcEshnrOhrf67rSGCGsUUgIvENamxRGnZg6AjTPh/04240k1HOxj
         CG+b+hOvVod+h9OBgR8Y0wBkYAhiwzYbFArVzci9GjtTkXBTK5/xDUM6wAku4CmD0XTV
         DFhw==
X-Gm-Message-State: AOJu0YxI4MEBKEVmUJoZ3HF3zLaPA/J5qkuT4+StcFezA5NI2/ZMeTGN
	lkSLRwCKXfNvU1AR5a88vrH0+EcS95QxWJ2ulpO71EtckYLXjbo9NFiNipmgdYLw75yQgh5qNHY
	WMxTk8yljdXZTEsK8k9SPQnhhWG+VmuE=
X-Gm-Gg: ASbGncvhocnzA/J6hDu1huuK+G8iEcJ6NyyGh0Ju3bBw5uOeeoXvPG+ioeGV/P2BX3A
	nW1nntmA0SjY6i/L9IefmlpXDW6YeOKUwco/r6IAbQNHS8Aw/WJErDz+ZjAuyCgQdpGHOP0FdSO
	tkA+WGqvAUQ062d0spm2mLK/kY7gR+UC0QMLHiTYvXZ95UkReMVURFJOoG0pimBw==
X-Google-Smtp-Source: AGHT+IH4+9sCTBcVLNNTbdQutB83CVqldDsxOZ2j0YMmv1o3Um/nEsCd0cA4WsDj1rNJtlcMu4/IuEGRV5SZOqkScls=
X-Received: by 2002:a05:6000:2004:b0:3a3:5ae4:6e81 with SMTP id
 ffacd0b85a97d-3a4fe160ccemr7882643f8f.8.1748905735987; Mon, 02 Jun 2025
 16:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526062555.1106061-1-houtao@huaweicloud.com> <20250526062555.1106061-3-houtao@huaweicloud.com>
In-Reply-To: <20250526062555.1106061-3-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 16:08:45 -0700
X-Gm-Features: AX0GCFsMxMG1f6Y5sdkrMX55WlJvob1s1Be_RiUXFAmg_iwUM1SbUtGYnSI2SdY
Message-ID: <CAADnVQLH3Ut8dF9t=_zB4acbZYuN=9+fgsACossGqFVTPO6EaQ@mail.gmail.com>
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

On Sun, May 25, 2025 at 11:08=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> BPF hash map supports special fields in its value, and BPF program is
> free to manipulate these special fields even after the element is
> deleted from the hash map. For non-preallocated hash map, these special
> fields will be leaked when the map is destroyed. Therefore, implement
> necessary BPF memory allocator dtor to free these special fields.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index dd6c157cb828..2531177d1464 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -128,6 +128,8 @@ struct htab_elem {
>         char key[] __aligned(8);
>  };
>
> +static void check_and_free_fields(struct bpf_htab *htab, struct htab_ele=
m *elem);
> +
>  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
>  {
>         return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
> @@ -464,6 +466,33 @@ static int htab_map_alloc_check(union bpf_attr *attr=
)
>         return 0;
>  }
>
> +static void htab_ma_dtor(void *obj, void *ctx)
> +{
> +       struct bpf_htab *htab =3D ctx;
> +
> +       /* The per-cpu pointer saved in the htab_elem may have been freed
> +        * by htab->pcpu_ma. Therefore, freeing the special fields in the
> +        * per-cpu pointer through the dtor of htab->pcpu_ma instead.
> +        */
> +       if (htab_is_percpu(htab))
> +               return;
> +       check_and_free_fields(htab, obj);
> +}

It seems the selftest in patch 3 might be working "by accident",
but older tests should be crashing?
It looks like you're calling check_and_free_fields() twice now.
Once from htab_elem_free() and then again in htab_ma_dtor() ?

If we're going for dtor then htab should delegate all clean up to it.

I wonder whether htab_put_fd_value() in free_htab_elem() has
similar issue with hash-of-map. Looks correct on the first glance.

