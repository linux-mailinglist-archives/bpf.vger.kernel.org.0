Return-Path: <bpf+bounces-70328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142AABB7E40
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F3E4A36DD
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7CB1F8BA6;
	Fri,  3 Oct 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4T4m+n9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A718B0F
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516715; cv=none; b=jiA2y5KUdWU5JeOdeqBA/s+pSlncwpEm5cU7sFLfYw4A1MM+4xOrL+Vy4X806TbrK8/OtJ4mySYrSqUz7CYDpfHtQM1s/6RTWDOutiPAXcruFaUNIoy41kCN9Ue2kafkBt6e37hLyFt2JSoBOPT1wQhgON9ZCZvVYVWs/GaewCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516715; c=relaxed/simple;
	bh=ZCkwtpEgfdVLUlHskQ0wVk2b1a3I2jthOt4sLFiuzVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7y+KeXxwRVtsyKrKA0hAw4gLJkASKWVutEmty1mzj+3OcXI+20W5VLn6PKovRfNAdaho00NZ/Q+vwneSVMhzrNF1IFQ//qtQWvAjwX/NtEvCpfQ8qch/Xkv6IZ1YNsr168MacS82K2UCml5SwIQAgr046MGW7lzAcQInLMYVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4T4m+n9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so2893383b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759516713; x=1760121513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slQB3wMtldCf4MiuiHVRdvJMvO4u4oJ+OACs7uKno9k=;
        b=Q4T4m+n9hRcRezwfko12IBkH2q2HXSt5rGYAZKEBSodQn/aRk3BxN04FJxdleyRfBk
         f3a04/a4kx+2fnwuPndHdOXdof7l3q53KQgdK2ncVAX7E50MAMrcnusLB56oXWuXlTdl
         eY0yJln3DwEtsmi1BEs5S1EljC729uTVd7SnA24QZEmDvLUuEr1wR+nJeDUNCrTRN7pi
         QswS9u9aIf+ASbSeSJeWQ5+3XtCaJ4SYNYEV7TiP+ZTdGzQctx2BpgbgoamjvUFC5qhA
         0cBEXvhjJu6/mKT6h/rxQKbY//s3bXB21/9Ck/aLnbLwtKtOlvpRWaZAfsCfDU2AnVu6
         i9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759516713; x=1760121513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slQB3wMtldCf4MiuiHVRdvJMvO4u4oJ+OACs7uKno9k=;
        b=qGZm0TDBLPVDFlP9kQocR8FX2FYb/QvHcoNq/GqJozCg6frJi5M7WrhA7xekOfVxQu
         3Bv0Yqwlu3F3uDcxj6YAvj+4hqUwlgZUSicO2urnDM0Qzn8xi8TQaO7FPC4mmnwTYxkU
         N4kMejiUIoBHJtfDgk0nlpB+0cx4pwvGLNV34i18hBq2jt78SgISC2uAZTSPHIUGuCSm
         AEqAKz9Ha87bt/SGpitZa3YcBe4rQGrb9f12W87dBb8ZntlmtMSj28CZoH+XebhfEYDV
         hAKE7zqg6NNvH+POPA8mxPZtssD3UAh3i1rieyFaB7yj2i5NcksUMuftdL5iIVGCDYQZ
         9Zbg==
X-Gm-Message-State: AOJu0YyAGeEBVAJJshBPamVLOIFvbbff5V0cKQafTIqQ12wf2KdDJFK4
	/HWsCHmLE/jSKzLHrNf+BeXAPh0wIXDciPDC09TQTD6+qhFfiGkPM5eI5GdZipFB1eSi6f9vxV6
	meQDI8NOoByrut7y4j/G8Z2+EhKV9Rr8=
X-Gm-Gg: ASbGnct83nYyv2Vy9R4/rLFNWEl/3Z8X9Y4V75OWhn32QXcl5LE1S3zEGIT/Jl6ap59
	iz6scLNgKLMbYqfKr95XEQ3+CmzCHxqO2xDvX4It5ljojBkVbyFg77uMpjadOYXpY2TRTo8sp2Z
	IIKZCA9D712BOetuYWoCfrmkSotZ71RElL/oyS7DRCQ6Ckssv+8ItT4FIdVlkpttLjKyTmqfMtR
	sERxG6msz1weM6DYYnhm11HruvvLH/kyepLNp1cLBBDTZw=
X-Google-Smtp-Source: AGHT+IHdrx+lQpv/HR0zjjL1WGEwnl7RbFUi2yxtnNrpH61fcc+nQyroTL5oxK2Rej3cJ/KsSSIFOZAyXsG4WgdCJEE=
X-Received: by 2002:a17:90b:4e83:b0:32e:dcc6:cd3f with SMTP id
 98e67ed59e1d1-339b50fe9b0mr10713062a91.14.1759516713391; Fri, 03 Oct 2025
 11:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-8-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-8-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:38:17 -0700
X-Gm-Features: AS18NWDbY2ah-ZvojnpTPEnARZ8ZH8YGy50JbsGq_6T7fRKOzJb3tKkju9UZLhs
Message-ID: <CAEf4BzYunpO3hBb3T_RGEUcYJBk=awgx+jCS8Naw1nK_SUEHUw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/10] bpf: add kfuncs and helpers support for file dynptrs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add support for file dynptr.
>
> Introduce struct bpf_dynptr_file_impl to hold internal state for file
> dynptrs, with 64-bit size and offset support.
>
> Introduce lifecycle management kfuncs:
>   - bpf_dynptr_from_file() for initialization
>   - bpf_dynptr_file_discard() for destruction
>
> Extend existing helpers to support file dynptrs in:
>   - bpf_dynptr_read()
>   - bpf_dynptr_slice()
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 97 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 2 deletions(-)
>

[...]

> +static int bpf_file_fetch_bytes(struct bpf_dynptr_file_impl *df, u64 off=
set, void *buf, u64 len)
> +{
> +       const void *ptr;
> +
> +       if (!buf || len =3D=3D 0)

len =3D=3D 0 doesn't return error for LOCAL and RINGBUF (at least), I
don't think we should deviate. Just treat len =3D=3D 0 as no-op.

> +               return -EINVAL;
> +
> +       df->freader.buf =3D buf;
> +       df->freader.buf_sz =3D len;
> +       ptr =3D freader_fetch(&df->freader, offset + df->offset, len);
> +       if (!ptr)
> +               return df->freader.err;
> +
> +       if (ptr !=3D buf) /* Force copying into the buffer */
> +               memcpy(buf, ptr, len);
> +
> +       return 0;
> +}
> +
>  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>                      enum bpf_dynptr_type type, u32 offset, u32 size)
>  {
> @@ -1782,6 +1832,8 @@ static int __bpf_dynptr_read(void *dst, u64 len, co=
nst struct bpf_dynptr_kern *s
>         case BPF_DYNPTR_TYPE_SKB_META:
>                 memmove(dst, bpf_skb_meta_pointer(src->data, src->offset =
+ offset), len);
>                 return 0;
> +       case BPF_DYNPTR_TYPE_FILE:
> +               return bpf_file_fetch_bytes(src->data, offset, dst, len);
>         default:
>                 WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\=
n", type);
>                 return -EFAULT;
> @@ -2177,6 +2229,35 @@ void bpf_rb_root_free(const struct btf_field *fiel=
d, void *rb_root,
>         }
>  }
>
> +enum bpf_is_sleepable {
> +       MAY_SLEEP,
> +       MAY_NOT_SLEEP,
> +};

might be a bit of an overkill to have enum for this, but I don't feel
strongly about this

> +
> +static int make_file_dynptr(struct file *file, u32 flags, enum bpf_is_sl=
eepable sleepable,
> +                           struct bpf_dynptr_kern *ptr)
> +{

nit: put it right before bpf_dynptr_from_file()?

> +       struct bpf_dynptr_file_impl *state;
> +
> +       /* flags is currently unsupported */
> +       if (flags) {
> +               bpf_dynptr_set_null(ptr);
> +               return -EINVAL;
> +       }
> +
> +       state =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_=
file_impl));
> +       if (!state) {
> +               bpf_dynptr_set_null(ptr);
> +               return -ENOMEM;
> +       }
> +       state->offset =3D 0;
> +       state->size =3D U64_MAX; /* Don't restrict size, as file may chan=
ge anyways */
> +       freader_init_from_file(&state->freader, NULL, 0, file, sleepable =
=3D=3D MAY_SLEEP);
> +       bpf_dynptr_init(ptr, state, BPF_DYNPTR_TYPE_FILE, 0, 0);
> +       bpf_dynptr_set_rdonly(ptr);
> +       return 0;
> +}
> +
>  __bpf_kfunc_start_defs();
>
>  __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign=
)
> @@ -2720,6 +2801,9 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf=
_dynptr *p, u64 offset,
>         }
>         case BPF_DYNPTR_TYPE_SKB_META:
>                 return bpf_skb_meta_pointer(ptr->data, ptr->offset + offs=
et);
> +       case BPF_DYNPTR_TYPE_FILE:
> +               err =3D bpf_file_fetch_bytes(ptr->data, offset, buffer__o=
pt, buffer__szk);
> +               return err ? NULL : buffer__opt;
>         default:
>                 WARN_ONCE(true, "unknown dynptr type %d\n", type);
>                 return NULL;
> @@ -2814,7 +2898,7 @@ __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_=
dynptr *p, u64 start, u64 end
>         if (start > size || end > size)
>                 return -ERANGE;
>
> -       ptr->offset +=3D start;
> +       bpf_dynptr_advance_offset(ptr, start);
>         bpf_dynptr_set_size(ptr, end - start);
>
>         return 0;
> @@ -4201,11 +4285,20 @@ __bpf_kfunc int bpf_task_work_schedule_resume(str=
uct task_struct *task, struct b
>
>  __bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struc=
t bpf_dynptr *ptr__uninit)
>  {
> -       return 0;
> +       return make_file_dynptr(file, flags, MAY_NOT_SLEEP, (struct bpf_d=
ynptr_kern *)ptr__uninit);
>  }
>
>  __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
>  {
> +       struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)dynptr;
> +       struct bpf_dynptr_file_impl *df;
> +
> +       if (bpf_dynptr_get_type(ptr) =3D=3D BPF_DYNPTR_TYPE_INVALID)
> +               return 0;

nit: let's just do what dynptr_read does:

if (!dynptr->data)
    return 0;

> +
> +       df =3D ptr->data;
> +       freader_cleanup(&df->freader);
> +       bpf_mem_free(&bpf_global_ma, df);
>         return 0;
>  }
>
> --
> 2.51.0
>

