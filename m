Return-Path: <bpf+bounces-76647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6CCC0500
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 457EB301E36D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341B7640E;
	Tue, 16 Dec 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN57LED0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59835979
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765843733; cv=none; b=aUqKS5aXkW9EAXxu6tmuI4oW555clwQPxo/UDStJIMg5r3Lr/5Cz1Wn4qTg0dkvs9KnBDweYAOFKmnRhC77ynyA/gGntvBUvOfPDakZkFKoBKgbX59nr0AtKTz6GSP0us99ZoW6ynt8fXxSDB3lseChQhsDJDC7brotuvE7Fd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765843733; c=relaxed/simple;
	bh=BDtlxoiTlWPfUN8tBY1QuQjsMGcq4gs/D+dsSLZcfZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btICCRXTmZNVNJLsciQIdBQxx6Rwx5f9FiFH0e/rUB4fMkvfs/Dr++LfoTmUBX0TE1D2DwDEJeEvQR1DzSTgZ8KtEVvUVv7ryo6Fe8JwUFqcdfXs8+WF7dxeSZNCisy2plWVpd39LTwTvFIIrVdBkcC02zC/REOsntqjTKIh2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN57LED0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso1930494a91.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765843731; x=1766448531; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vvxqOsb3x++YJiB3GWy1MEQ+QBecYg0dfxA4JSwpJbw=;
        b=KN57LED0IM0ugu6goBi9Ccqr5GNeUZsaSyFEU3UW74GDHjOv3bcXedMeZz8jJPySH7
         cxZ/yErGYI0xwhLOXlNg9RVyNimwvi7wbPL8E/8FP/ugg2KMQowvNY093SbjH9K9zme6
         0wcIvy2oD8MaSzdez4JNnH5lBFUlAGxWSTGpxacxWOKEkm1zfW6dJc8uQs3Net2rNcIb
         amx9OxsoXqQyHVJJYDRvydLqUKdEd4QuVioL7aYgrAMYcPDg/OA89sJDLOQ1WvF6gDhw
         9Ir2ch+ibtwZHQoGN6Lw51HbtZpxRFPd9CScCUQ/3WP+8fFwJJCvjL1IY0sSkyvsmPY0
         TBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765843731; x=1766448531;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvxqOsb3x++YJiB3GWy1MEQ+QBecYg0dfxA4JSwpJbw=;
        b=vJwbp6B1WrdCWy9T4pA3Wj806dy3UdZWtt11s+deawvbQCSeCKSum3cy0XF0Wm2Tss
         FwmxOGvleyTL+RjXaWUhdBdT9iE73DCQhRo76m2ajbfszP7KWjJWzK5s1qlgSfaY5gYD
         UAyJrgZAR0IR514/U+m66KZOw2RGDaNuI+K4jUmba+mmgryQwceh3HCP+Rhu+IBgzLhW
         ywostJbMkjVDgHiNYnVK4t8WNqnyZdVUdToJ+iZNvMtQoQXVm7vsuGxcbAC3Oi+dEoWR
         XQwQQvSSI/vYtQbCRdHrHUs5DY2+di4Xy4hRL/Ewe/0qe9egfTJFWtqIy4VjEvl3tqR2
         fFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn5fYnIHpUadbQrJXX5fbhPKwQmCDjgAB+GzkYxxQwMIkip5BqkBO/GIvVTr6Z1W4ol7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3pgpEKjbBiyUSOoKQJC9o7ThS8iajZIJV+eNEgaI8KihHR7i
	ZVVe+LAeW9cU9+P/1hqTAYE3tP+zzDeZ8CJvIxvSWxdGz0v4NKKPh/0x
X-Gm-Gg: AY/fxX7pEYBYUDPkTXVa2kMPX/6XaaMlqN4ELxpK1PG+1tUh9HLTlSwDjMNo74dOf2B
	bQoqvtzb7GW8K0T3WENQXIQWnlhDJHROw/kcwFnsmE+4kqDTB+0W3/HAni0YUSkrCrTFChZc6J4
	j0NpYnz8JdRvbJEzTba0LwsGiPCANzTgHfnc26/z9LOUzQkQEwGiDT5Vlao4o/ifo1JRfNJ3KXa
	yIJQWnhIQHAENDYWo07QTQQzpDhwDzGix9CymQ2fGHj3mlqGl55n+3xF53LlmhBORWaQVashm/q
	TEROBsyXX03iPQ1b5kjPhakfJ6LeKTdCPzd5UIri3zG071EQaiouWSdAQ9B+jBtFNVxDZhMfZjJ
	VV3W5AUX23sfVK/hcB9YhxJz1tD5+nKhY2LLg38AGYa7e2C36c0fnCnvgd0AukeIihvHcrjBhpC
	Wph4wqOazL
X-Google-Smtp-Source: AGHT+IGE1fKZqLICz33H+to6KkkZSsN7WUsEmhVrRuSFJ9KUEAfXsxGe1xqmNZJ0EJ0p96ga12QS5Q==
X-Received: by 2002:a17:90b:3d0e:b0:340:99fd:9676 with SMTP id 98e67ed59e1d1-34abd6d3501mr10877833a91.10.1765843730465;
        Mon, 15 Dec 2025 16:08:50 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd0b1633dsm12664a91.10.2025.12.15.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:08:49 -0800 (PST)
Message-ID: <b075ce52b87c6399fe4171b3e73098df983c0fc2.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 16:08:46 -0800
In-Reply-To: <20251215091730.1188790-3-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-3-alan.maguire@oracle.com>
Content-Type: multipart/mixed; boundary="=-s0MPYegAAwpUx87Q52AR"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-s0MPYegAAwpUx87Q52AR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

Hi Alan,

Overall makes sense, please fine one suggestion below.

> Support reading in kind layout fixing endian issues on reading;
> also support writing kind layout section to raw BTF object.
> There is not yet an API to populate the kind layout with meaningful
> information.
>=20
> As part of this, we need to consider multiple valid BTF header
> sizes; the original or the kind layout-extended headers.
> So to support this, the "struct btf" representation is modified
> to always allocate a "struct btf_header" and copy the valid
> portion from the raw data to it; this means we can always safely
> check fields like btf->hdr->kind_layout_len.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 183 insertions(+), 77 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..8835aee6ee84 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -40,42 +40,53 @@ struct btf {
> =20
>  	/*
>  	 * When BTF is loaded from an ELF or raw memory it is stored
> -	 * in a contiguous memory block. The hdr, type_data, and, strs_data
> +	 * in a contiguous memory block. The  type_data, and, strs_data
>  	 * point inside that memory region to their respective parts of BTF
>  	 * representation:
>  	 *
> -	 * +--------------------------------+
> -	 * |  Header  |  Types  |  Strings  |
> -	 * +--------------------------------+
> -	 * ^          ^         ^
> -	 * |          |         |
> -	 * hdr        |         |
> -	 * types_data-+         |
> -	 * strs_data------------+
> +	 * +--------------------------------+---------------------+
> +	 * |  Header  |  Types  |  Strings  |Optional kind layout |
> +	 * +--------------------------------+---------------------+
> +	 * ^          ^         ^           ^
> +	 * |          |         |           |
> +	 * raw_data   |         |           |
> +	 * types_data-+         |           |
> +	 * strs_data------------+           |
> +	 * kind_layout----------------------+
> +	 *
> +	 * A separate struct btf_header is allocated for btf->hdr,
> +	 * and header information is copied into it.  This allows us
> +	 * to handle header data for various header formats; the original,
> +	 * the extended header with kind layout, etc.
>  	 *
>  	 * If BTF data is later modified, e.g., due to types added or
>  	 * removed, BTF deduplication performed, etc, this contiguous
> -	 * representation is broken up into three independently allocated
> -	 * memory regions to be able to modify them independently.
> +	 * representation is broken up into four independent memory
> +	 * regions.
> +	 *
>  	 * raw_data is nulled out at that point, but can be later allocated
>  	 * and cached again if user calls btf__raw_data(), at which point
> -	 * raw_data will contain a contiguous copy of header, types, and
> -	 * strings:
> +	 * raw_data will contain a contiguous copy of header, types, strings
> +	 * and optionally kind_layout.  kind_layout optionally points to a
> +	 * kind_layout array - this allows us to encode information about
> +	 * the kinds known at encoding time.  If kind_layout is NULL no
> +	 * kind information is encoded.
>  	 *
> -	 * +----------+  +---------+  +-----------+
> -	 * |  Header  |  |  Types  |  |  Strings  |
> -	 * +----------+  +---------+  +-----------+
> -	 * ^             ^            ^
> -	 * |             |            |
> -	 * hdr           |            |
> -	 * types_data----+            |
> -	 * strset__data(strs_set)-----+
> +	 * +----------+  +---------+  +-----------+   +-----------+
> +	 * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
> +	 * +----------+  +---------+  +-----------+   +-----------+
> +	 * ^             ^            ^               ^
> +	 * |             |            |               |
> +	 * hdr           |            |               |
> +	 * types_data----+            |               |
> +	 * strset__data(strs_set)-----+               |
> +	 * kind_layout--------------------------------+
>  	 *
> -	 *               +----------+---------+-----------+
> -	 *               |  Header  |  Types  |  Strings  |
> -	 * raw_data----->+----------+---------+-----------+
> +	 *               +----------+---------+-----------+--------------------=
-+
> +	 *               |  Header  |  Types  |  Strings  | Optional kind layou=
t|
> +	 * raw_data----->+----------+---------+-----------+--------------------=
-+
>  	 */
> -	struct btf_header *hdr;
> +	struct btf_header *hdr; /* separately-allocated header data */

Do we want to directly embed this structure?
E.g. as in the diff attached.
No need to bother with calloc/free in such case.

> =20
>  	void *types_data;
>  	size_t types_data_cap; /* used size stored in hdr->type_len */
> @@ -123,6 +134,13 @@ struct btf {
>  	/* whether raw_data is a (read-only) mmap */
>  	bool raw_data_is_mmap;
> =20
> +	/* is BTF modifiable? i.e. is it split into separate sections as descri=
bed above? */
> +	bool modifiable;
> +	/* Points either at raw kind layout data in parsed BTF (if present), or
> +	 * at an allocated kind layout array when BTF is modifiable.
> +	 */
> +	void *kind_layout;
> +
>  	/* BTF object FD, if loaded into kernel */
>  	int fd;
> =20
> @@ -214,7 +232,7 @@ static int btf_add_type_idx_entry(struct btf *btf, __=
u32 type_off)
>  	return 0;
>  }
> =20
> -static void btf_bswap_hdr(struct btf_header *h)
> +static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
>  {
>  	h->magic =3D bswap_16(h->magic);
>  	h->hdr_len =3D bswap_32(h->hdr_len);

[...]

Thanks,
Eduard

--=-s0MPYegAAwpUx87Q52AR
Content-Disposition: attachment; filename="embed-hdr.diff"
Content-Type: text/x-patch; name="embed-hdr.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnRmLmMgYi90b29scy9saWIvYnBmL2J0Zi5jCmlu
ZGV4IDYwOThjOGQxZTI2YS4uYWY0ZWIyN2QyZjU0IDEwMDY0NAotLS0gYS90b29scy9saWIvYnBm
L2J0Zi5jCisrKyBiL3Rvb2xzL2xpYi9icGYvYnRmLmMKQEAgLTExNSw3ICsxMTUsNyBAQCBzdHJ1
Y3QgYnRmIHsKIAkgKiAgICAgICAgICAgICAgIHwgIEhlYWRlciAgfCAgVHlwZXMgIHwgIFN0cmlu
Z3MgIHwgT3B0aW9uYWwga2luZCBsYXlvdXR8CiAJICogcmF3X2RhdGEtLS0tLT4rLS0tLS0tLS0t
LSstLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwogCSAqLwotCXN0
cnVjdCBidGZfaGVhZGVyICpoZHI7IC8qIHNlcGFyYXRlbHktYWxsb2NhdGVkIGhlYWRlciBkYXRh
ICovCisJc3RydWN0IGJ0Zl9oZWFkZXIgaGRyOyAvKiBjb3B5IG9mIHRoZSBoZWFkZXIgZGF0YSAq
LwogCiAJdm9pZCAqdHlwZXNfZGF0YTsKIAlzaXplX3QgdHlwZXNfZGF0YV9jYXA7IC8qIHVzZWQg
c2l6ZSBzdG9yZWQgaW4gaGRyLT50eXBlX2xlbiAqLwpAQCAtMzA3LDQ2ICszMDcsNDEgQEAgc3Rh
dGljIGludCBidGZfcGFyc2VfaGRyKHN0cnVjdCBidGYgKmJ0ZikKIAkJcmV0dXJuIC1FSU5WQUw7
CiAJfQogCi0JLyogQXQgdGhpcyBwb2ludCwgd2UgaGF2ZSBiYXNpYyBoZWFkZXIgaW5mb3JtYXRp
b24sIHNvIGFsbG9jYXRlIGJ0Zi0+aGRyICovCi0JYnRmLT5oZHIgPSBjYWxsb2MoMSwgc2l6ZW9m
KHN0cnVjdCBidGZfaGVhZGVyKSk7Ci0JaWYgKCFidGYtPmhkcikgewotCQlwcl9kZWJ1ZygiQlRG
IGhlYWRlciBhbGxvY2F0aW9uIGZhaWxlZFxuIik7Ci0JCXJldHVybiAtRU5PTUVNOwotCX0KLQlt
ZW1jcHkoYnRmLT5oZHIsIGhkciwgbWluKChzaXplX3QpaGRyX2xlbiwgc2l6ZW9mKHN0cnVjdCBi
dGZfaGVhZGVyKSkpOworCS8qIEF0IHRoaXMgcG9pbnQsIHdlIGhhdmUgYmFzaWMgaGVhZGVyIGlu
Zm9ybWF0aW9uLCBzbyBjb3B5IHRvIGJ0Zi0+aGRyICovCisJbWVtY3B5KCZidGYtPmhkciwgaGRy
LCBtaW4oKHNpemVfdCloZHJfbGVuLCBzaXplb2Yoc3RydWN0IGJ0Zl9oZWFkZXIpKSk7CiAKIAlt
ZXRhX2xlZnQgPSBidGYtPnJhd19zaXplIC0gaGRyX2xlbjsKLQlpZiAobWV0YV9sZWZ0IDwgKGxv
bmcgbG9uZylidGYtPmhkci0+c3RyX29mZiArIGJ0Zi0+aGRyLT5zdHJfbGVuKSB7CisJaWYgKG1l
dGFfbGVmdCA8IChsb25nIGxvbmcpYnRmLT5oZHIuc3RyX29mZiArIGJ0Zi0+aGRyLnN0cl9sZW4p
IHsKIAkJcHJfZGVidWcoIkludmFsaWQgQlRGIHRvdGFsIHNpemU6ICV1XG4iLCBidGYtPnJhd19z
aXplKTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0JaWYgKChsb25nIGxvbmcpYnRmLT5oZHIt
PnR5cGVfb2ZmICsgYnRmLT5oZHItPnR5cGVfbGVuID4gYnRmLT5oZHItPnN0cl9vZmYpIHsKKwlp
ZiAoKGxvbmcgbG9uZylidGYtPmhkci50eXBlX29mZiArIGJ0Zi0+aGRyLnR5cGVfbGVuID4gYnRm
LT5oZHIuc3RyX29mZikgewogCQlwcl9kZWJ1ZygiSW52YWxpZCBCVEYgZGF0YSBzZWN0aW9ucyBs
YXlvdXQ6IHR5cGUgZGF0YSBhdCAldSArICV1LCBzdHJpbmdzIGRhdGEgYXQgJXUgKyAldVxuIiwK
LQkJCSBidGYtPmhkci0+dHlwZV9vZmYsIGJ0Zi0+aGRyLT50eXBlX2xlbiwgYnRmLT5oZHItPnN0
cl9vZmYsCi0JCQkgYnRmLT5oZHItPnN0cl9sZW4pOworCQkJIGJ0Zi0+aGRyLnR5cGVfb2ZmLCBi
dGYtPmhkci50eXBlX2xlbiwgYnRmLT5oZHIuc3RyX29mZiwKKwkJCSBidGYtPmhkci5zdHJfbGVu
KTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0JaWYgKGJ0Zi0+aGRyLT50eXBlX29mZiAlIDQp
IHsKKwlpZiAoYnRmLT5oZHIudHlwZV9vZmYgJSA0KSB7CiAJCXByX2RlYnVnKCJCVEYgdHlwZSBz
ZWN0aW9uIGlzIG5vdCBhbGlnbmVkIHRvIDQgYnl0ZXNcbiIpOwogCQlyZXR1cm4gLUVJTlZBTDsK
IAl9CiAKLQlpZiAoYnRmLT5oZHItPmtpbmRfbGF5b3V0X2xlbiA9PSAwKQorCWlmIChidGYtPmhk
ci5raW5kX2xheW91dF9sZW4gPT0gMCkKIAkJcmV0dXJuIDA7CiAKLQlpZiAoYnRmLT5oZHItPmtp
bmRfbGF5b3V0X29mZiAlIDQpIHsKKwlpZiAoYnRmLT5oZHIua2luZF9sYXlvdXRfb2ZmICUgNCkg
ewogCQlwcl9kZWJ1ZygiQlRGIGtpbmRfbGF5b3V0IHNlY3Rpb24gaXMgbm90IGFsaWduZWQgdG8g
NCBieXRlc1xuIik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KLQlpZiAoYnRmLT5oZHItPmtpbmRf
bGF5b3V0X29mZiA8IGJ0Zi0+aGRyLT5zdHJfb2ZmICsgYnRmLT5oZHItPnN0cl9sZW4pIHsKKwlp
ZiAoYnRmLT5oZHIua2luZF9sYXlvdXRfb2ZmIDwgYnRmLT5oZHIuc3RyX29mZiArIGJ0Zi0+aGRy
LnN0cl9sZW4pIHsKIAkJcHJfZGVidWcoIkludmFsaWQgQlRGIGRhdGEgc2VjdGlvbnMgbGF5b3V0
OiBzdHJpbmdzIGRhdGEgYXQgJXUgKyAldSwga2luZCBsYXlvdXQgZGF0YSBhdCAldSArICV1XG4i
LAotCQkJIGJ0Zi0+aGRyLT5zdHJfb2ZmLCBidGYtPmhkci0+c3RyX2xlbiwKLQkJCSBidGYtPmhk
ci0+a2luZF9sYXlvdXRfb2ZmLCBidGYtPmhkci0+a2luZF9sYXlvdXRfbGVuKTsKKwkJCSBidGYt
Pmhkci5zdHJfb2ZmLCBidGYtPmhkci5zdHJfbGVuLAorCQkJIGJ0Zi0+aGRyLmtpbmRfbGF5b3V0
X29mZiwgYnRmLT5oZHIua2luZF9sYXlvdXRfbGVuKTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQot
CWlmIChidGYtPmhkci0+a2luZF9sYXlvdXRfb2ZmICsgYnRmLT5oZHItPmtpbmRfbGF5b3V0X2xl
biA+IG1ldGFfbGVmdCkgeworCWlmIChidGYtPmhkci5raW5kX2xheW91dF9vZmYgKyBidGYtPmhk
ci5raW5kX2xheW91dF9sZW4gPiBtZXRhX2xlZnQpIHsKIAkJcHJfZGVidWcoIkludmFsaWQgQlRG
IHRvdGFsIHNpemU6ICV1XG4iLCBidGYtPnJhd19zaXplKTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQpAQCAtMzU1LDkgKzM1MCw5IEBAIHN0YXRpYyBpbnQgYnRmX3BhcnNlX2hkcihzdHJ1Y3QgYnRm
ICpidGYpCiAKIHN0YXRpYyBpbnQgYnRmX3BhcnNlX3N0cl9zZWMoc3RydWN0IGJ0ZiAqYnRmKQog
ewotCWNvbnN0IHN0cnVjdCBidGZfaGVhZGVyICpoZHIgPSBidGYtPmhkcjsKKwljb25zdCBzdHJ1
Y3QgYnRmX2hlYWRlciAqaGRyID0gJmJ0Zi0+aGRyOwogCWNvbnN0IGNoYXIgKnN0YXJ0ID0gYnRm
LT5zdHJzX2RhdGE7Ci0JY29uc3QgY2hhciAqZW5kID0gc3RhcnQgKyBidGYtPmhkci0+c3RyX2xl
bjsKKwljb25zdCBjaGFyICplbmQgPSBzdGFydCArIGJ0Zi0+aGRyLnN0cl9sZW47CiAKIAlpZiAo
YnRmLT5iYXNlX2J0ZiAmJiBoZHItPnN0cl9sZW4gPT0gMCkKIAkJcmV0dXJuIDA7CkBAIC0zNzQs
NyArMzY5LDcgQEAgc3RhdGljIGludCBidGZfcGFyc2Vfc3RyX3NlYyhzdHJ1Y3QgYnRmICpidGYp
CiAKIHN0YXRpYyBpbnQgYnRmX3BhcnNlX2tpbmRfbGF5b3V0X3NlYyhzdHJ1Y3QgYnRmICpidGYp
CiB7Ci0JY29uc3Qgc3RydWN0IGJ0Zl9oZWFkZXIgKmhkciA9IGJ0Zi0+aGRyOworCWNvbnN0IHN0
cnVjdCBidGZfaGVhZGVyICpoZHIgPSAmYnRmLT5oZHI7CiAKIAlpZiAoIWhkci0+a2luZF9sYXlv
dXRfbGVuKQogCQlyZXR1cm4gMDsKQEAgLTM4Myw3ICszNzgsNyBAQCBzdGF0aWMgaW50IGJ0Zl9w
YXJzZV9raW5kX2xheW91dF9zZWMoc3RydWN0IGJ0ZiAqYnRmKQogCQlwcl9kZWJ1ZygiSW52YWxp
ZCBCVEYga2luZCBsYXlvdXQgc2VjdGlvblxuIik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KLQli
dGYtPmtpbmRfbGF5b3V0ID0gYnRmLT5yYXdfZGF0YSArIGJ0Zi0+aGRyLT5oZHJfbGVuICsgYnRm
LT5oZHItPmtpbmRfbGF5b3V0X29mZjsKKwlidGYtPmtpbmRfbGF5b3V0ID0gYnRmLT5yYXdfZGF0
YSArIGJ0Zi0+aGRyLmhkcl9sZW4gKyBidGYtPmhkci5raW5kX2xheW91dF9vZmY7CiAKIAlyZXR1
cm4gMDsKIH0KQEAgLTM5Nyw3ICszOTIsNyBAQCBzdGF0aWMgaW50IGJ0Zl90eXBlX3NpemVfdW5r
bm93bihjb25zdCBzdHJ1Y3QgYnRmICpidGYsIGNvbnN0IHN0cnVjdCBidGZfdHlwZSAqdAogCV9f
dTgga2luZCA9IGJ0Zl9raW5kKHQpOwogCV9fdTMyIG9mZiA9IGtpbmQgKiBzaXplb2Yoc3RydWN0
IGJ0Zl9raW5kX2xheW91dCk7CiAKLQlpZiAoIWJ0Zi0+a2luZF9sYXlvdXQgfHwgb2ZmID49IGJ0
Zi0+aGRyLT5raW5kX2xheW91dF9sZW4pIHsKKwlpZiAoIWJ0Zi0+a2luZF9sYXlvdXQgfHwgb2Zm
ID49IGJ0Zi0+aGRyLmtpbmRfbGF5b3V0X2xlbikgewogCQlwcl9kZWJ1ZygiVW5zdXBwb3J0ZWQg
QlRGX0tJTkQ6ICV1XG4iLCBidGZfa2luZCh0KSk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KQEAg
LTUzNSw3ICs1MzAsNyBAQCBzdGF0aWMgaW50IGJ0Zl9ic3dhcF90eXBlX3Jlc3Qoc3RydWN0IGJ0
Zl90eXBlICp0KQogCiBzdGF0aWMgaW50IGJ0Zl9wYXJzZV90eXBlX3NlYyhzdHJ1Y3QgYnRmICpi
dGYpCiB7Ci0Jc3RydWN0IGJ0Zl9oZWFkZXIgKmhkciA9IGJ0Zi0+aGRyOworCXN0cnVjdCBidGZf
aGVhZGVyICpoZHIgPSAmYnRmLT5oZHI7CiAJdm9pZCAqbmV4dF90eXBlID0gYnRmLT50eXBlc19k
YXRhOwogCXZvaWQgKmVuZF90eXBlID0gbmV4dF90eXBlICsgaGRyLT50eXBlX2xlbjsKIAlpbnQg
ZXJyLCB0eXBlX3NpemU7CkBAIC0xMTA1LDcgKzExMDAsNiBAQCB2b2lkIGJ0Zl9fZnJlZShzdHJ1
Y3QgYnRmICpidGYpCiAJCXN0cnNldF9fZnJlZShidGYtPnN0cnNfc2V0KTsKIAkJZnJlZShidGYt
PmtpbmRfbGF5b3V0KTsKIAl9Ci0JZnJlZShidGYtPmhkcik7CiAJYnRmX2ZyZWVfcmF3X2RhdGEo
YnRmKTsKIAlmcmVlKGJ0Zi0+cmF3X2RhdGFfc3dhcHBlZCk7CiAJZnJlZShidGYtPnR5cGVfb2Zm
cyk7CkBAIC0xMTM1LDcgKzExMjksNyBAQCBzdGF0aWMgc3RydWN0IGJ0ZiAqYnRmX25ld19lbXB0
eShzdHJ1Y3QgYnRmX25ld19vcHRzICpvcHRzKQogCWlmIChiYXNlX2J0ZikgewogCQlidGYtPmJh
c2VfYnRmID0gYmFzZV9idGY7CiAJCWJ0Zi0+c3RhcnRfaWQgPSBidGZfX3R5cGVfY250KGJhc2Vf
YnRmKTsKLQkJYnRmLT5zdGFydF9zdHJfb2ZmID0gYmFzZV9idGYtPmhkci0+c3RyX2xlbiArIGJh
c2VfYnRmLT5zdGFydF9zdHJfb2ZmOworCQlidGYtPnN0YXJ0X3N0cl9vZmYgPSBiYXNlX2J0Zi0+
aGRyLnN0cl9sZW4gKyBiYXNlX2J0Zi0+c3RhcnRfc3RyX29mZjsKIAkJYnRmLT5zd2FwcGVkX2Vu
ZGlhbiA9IGJhc2VfYnRmLT5zd2FwcGVkX2VuZGlhbjsKIAl9CiAKQEAgLTExNTcsMjAgKzExNTEs
MTMgQEAgc3RhdGljIHN0cnVjdCBidGYgKmJ0Zl9uZXdfZW1wdHkoc3RydWN0IGJ0Zl9uZXdfb3B0
cyAqb3B0cykKIAlidGYtPnR5cGVzX2RhdGEgPSBidGYtPnJhd19kYXRhICsgaGRyLT5oZHJfbGVu
OwogCWJ0Zi0+c3Ryc19kYXRhID0gYnRmLT5yYXdfZGF0YSArIGhkci0+aGRyX2xlbjsKIAloZHIt
PnN0cl9sZW4gPSBiYXNlX2J0ZiA/IDAgOiAxOyAvKiBlbXB0eSBzdHJpbmcgYXQgb2Zmc2V0IDAg
Ki8KLQlidGYtPmhkciA9IGNhbGxvYygxLCBzaXplb2Yoc3RydWN0IGJ0Zl9oZWFkZXIpKTsKLQlp
ZiAoIWJ0Zi0+aGRyKSB7Ci0JCWZyZWUoYnRmLT5yYXdfZGF0YSk7Ci0JCWZyZWUoYnRmKTsKLQkJ
cmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Ci0JfQotCiAJaWYgKGFkZF9raW5kX2xheW91dCkgewog
CQloZHItPmtpbmRfbGF5b3V0X2xlbiA9IHNpemVvZihraW5kX2xheW91dHMpOwogCQloZHItPmtp
bmRfbGF5b3V0X29mZiA9IHJvdW5kdXAoaGRyLT5zdHJfbGVuLCA0KTsKIAkJYnRmLT5raW5kX2xh
eW91dCA9IGJ0Zi0+cmF3X2RhdGEgKyBoZHItPmhkcl9sZW4gKyBoZHItPmtpbmRfbGF5b3V0X29m
ZjsKIAkJbWVtY3B5KGJ0Zi0+a2luZF9sYXlvdXQsIGtpbmRfbGF5b3V0cywgc2l6ZW9mKGtpbmRf
bGF5b3V0cykpOwogCX0KLQltZW1jcHkoYnRmLT5oZHIsIGhkciwgc2l6ZW9mKCpoZHIpKTsKKwlt
ZW1jcHkoJmJ0Zi0+aGRyLCBoZHIsIHNpemVvZigqaGRyKSk7CiAKIAlyZXR1cm4gYnRmOwogfQpA
QCAtMTIxNiw3ICsxMjAzLDcgQEAgc3RhdGljIHN0cnVjdCBidGYgKmJ0Zl9uZXcoY29uc3Qgdm9p
ZCAqZGF0YSwgX191MzIgc2l6ZSwgc3RydWN0IGJ0ZiAqYmFzZV9idGYsIGIKIAlpZiAoYmFzZV9i
dGYpIHsKIAkJYnRmLT5iYXNlX2J0ZiA9IGJhc2VfYnRmOwogCQlidGYtPnN0YXJ0X2lkID0gYnRm
X190eXBlX2NudChiYXNlX2J0Zik7Ci0JCWJ0Zi0+c3RhcnRfc3RyX29mZiA9IGJhc2VfYnRmLT5o
ZHItPnN0cl9sZW4gKyBiYXNlX2J0Zi0+c3RhcnRfc3RyX29mZjsKKwkJYnRmLT5zdGFydF9zdHJf
b2ZmID0gYmFzZV9idGYtPmhkci5zdHJfbGVuICsgYmFzZV9idGYtPnN0YXJ0X3N0cl9vZmY7CiAJ
fQogCiAJaWYgKGlzX21tYXApIHsKQEAgLTEyMzcsOCArMTIyNCw4IEBAIHN0YXRpYyBzdHJ1Y3Qg
YnRmICpidGZfbmV3KGNvbnN0IHZvaWQgKmRhdGEsIF9fdTMyIHNpemUsIHN0cnVjdCBidGYgKmJh
c2VfYnRmLCBiCiAJaWYgKGVycikKIAkJZ290byBkb25lOwogCi0JYnRmLT5zdHJzX2RhdGEgPSBi
dGYtPnJhd19kYXRhICsgYnRmLT5oZHItPmhkcl9sZW4gKyBidGYtPmhkci0+c3RyX29mZjsKLQli
dGYtPnR5cGVzX2RhdGEgPSBidGYtPnJhd19kYXRhICsgYnRmLT5oZHItPmhkcl9sZW4gKyBidGYt
Pmhkci0+dHlwZV9vZmY7CisJYnRmLT5zdHJzX2RhdGEgPSBidGYtPnJhd19kYXRhICsgYnRmLT5o
ZHIuaGRyX2xlbiArIGJ0Zi0+aGRyLnN0cl9vZmY7CisJYnRmLT50eXBlc19kYXRhID0gYnRmLT5y
YXdfZGF0YSArIGJ0Zi0+aGRyLmhkcl9sZW4gKyBidGYtPmhkci50eXBlX29mZjsKIAogCWVyciA9
IGJ0Zl9wYXJzZV9zdHJfc2VjKGJ0Zik7CiAJZXJyID0gZXJyID86IGJ0Zl9wYXJzZV9raW5kX2xh
eW91dF9zZWMoYnRmKTsKQEAgLTE2OTIsNyArMTY3OSw3IEBAIHN0YXRpYyBjb25zdCB2b2lkICpi
dGZfc3Ryc19kYXRhKGNvbnN0IHN0cnVjdCBidGYgKmJ0ZikKIAogc3RhdGljIHZvaWQgKmJ0Zl9n
ZXRfcmF3X2RhdGEoY29uc3Qgc3RydWN0IGJ0ZiAqYnRmLCBfX3UzMiAqc2l6ZSwgYm9vbCBzd2Fw
X2VuZGlhbikKIHsKLQlzdHJ1Y3QgYnRmX2hlYWRlciAqaGRyID0gYnRmLT5oZHI7CisJY29uc3Qg
c3RydWN0IGJ0Zl9oZWFkZXIgKmhkciA9ICZidGYtPmhkcjsKIAlzdHJ1Y3QgYnRmX3R5cGUgKnQ7
CiAJdm9pZCAqZGF0YSwgKnA7CiAJX191MzIgZGF0YV9zejsKQEAgLTE3NzQsNyArMTc2MSw3IEBA
IGNvbnN0IGNoYXIgKmJ0Zl9fc3RyX2J5X29mZnNldChjb25zdCBzdHJ1Y3QgYnRmICpidGYsIF9f
dTMyIG9mZnNldCkKIHsKIAlpZiAob2Zmc2V0IDwgYnRmLT5zdGFydF9zdHJfb2ZmKQogCQlyZXR1
cm4gYnRmX19zdHJfYnlfb2Zmc2V0KGJ0Zi0+YmFzZV9idGYsIG9mZnNldCk7Ci0JZWxzZSBpZiAo
b2Zmc2V0IC0gYnRmLT5zdGFydF9zdHJfb2ZmIDwgYnRmLT5oZHItPnN0cl9sZW4pCisJZWxzZSBp
ZiAob2Zmc2V0IC0gYnRmLT5zdGFydF9zdHJfb2ZmIDwgYnRmLT5oZHIuc3RyX2xlbikKIAkJcmV0
dXJuIGJ0Zl9zdHJzX2RhdGEoYnRmKSArIChvZmZzZXQgLSBidGYtPnN0YXJ0X3N0cl9vZmYpOwog
CWVsc2UKIAkJcmV0dXJuIGVycm5vID0gRUlOVkFMLCBOVUxMOwpAQCAtMTg5NywyMSArMTg4NCwy
MSBAQCBzdGF0aWMgaW50IGJ0Zl9lbnN1cmVfbW9kaWZpYWJsZShzdHJ1Y3QgYnRmICpidGYpCiAJ
fQogCiAJLyogc3BsaXQgcmF3IGRhdGEgaW50byBtZW1vcnkgcmVnaW9uczsgYnRmLT5oZHIgaXMg
ZG9uZSBhbHJlYWR5LiAqLwotCXR5cGVzID0gbWFsbG9jKGJ0Zi0+aGRyLT50eXBlX2xlbik7CisJ
dHlwZXMgPSBtYWxsb2MoYnRmLT5oZHIudHlwZV9sZW4pOwogCWlmICghdHlwZXMpCiAJCWdvdG8g
ZXJyX291dDsKLQltZW1jcHkodHlwZXMsIGJ0Zi0+dHlwZXNfZGF0YSwgYnRmLT5oZHItPnR5cGVf
bGVuKTsKKwltZW1jcHkodHlwZXMsIGJ0Zi0+dHlwZXNfZGF0YSwgYnRmLT5oZHIudHlwZV9sZW4p
OwogCi0JaWYgKGJ0Zi0+aGRyLT5raW5kX2xheW91dF9sZW4pIHsKLQkJa2luZF9sYXlvdXQgPSBt
YWxsb2MoYnRmLT5oZHItPmtpbmRfbGF5b3V0X2xlbik7CisJaWYgKGJ0Zi0+aGRyLmtpbmRfbGF5
b3V0X2xlbikgeworCQlraW5kX2xheW91dCA9IG1hbGxvYyhidGYtPmhkci5raW5kX2xheW91dF9s
ZW4pOwogCQlpZiAoIWtpbmRfbGF5b3V0KQogCQkJZ290byBlcnJfb3V0OwotCQltZW1jcHkoa2lu
ZF9sYXlvdXQsIGJ0Zi0+cmF3X2RhdGEgKyBidGYtPmhkci0+aGRyX2xlbiArIGJ0Zi0+aGRyLT5r
aW5kX2xheW91dF9vZmYsCi0JCSAgICAgICBidGYtPmhkci0+a2luZF9sYXlvdXRfbGVuKTsKKwkJ
bWVtY3B5KGtpbmRfbGF5b3V0LCBidGYtPnJhd19kYXRhICsgYnRmLT5oZHIuaGRyX2xlbiArIGJ0
Zi0+aGRyLmtpbmRfbGF5b3V0X29mZiwKKwkJICAgICAgIGJ0Zi0+aGRyLmtpbmRfbGF5b3V0X2xl
bik7CiAJfQogCiAJLyogYnVpbGQgbG9va3VwIGluZGV4IGZvciBhbGwgc3RyaW5ncyAqLwotCXNl
dCA9IHN0cnNldF9fbmV3KEJURl9NQVhfU1RSX09GRlNFVCwgYnRmLT5zdHJzX2RhdGEsIGJ0Zi0+
aGRyLT5zdHJfbGVuKTsKKwlzZXQgPSBzdHJzZXRfX25ldyhCVEZfTUFYX1NUUl9PRkZTRVQsIGJ0
Zi0+c3Ryc19kYXRhLCBidGYtPmhkci5zdHJfbGVuKTsKIAlpZiAoSVNfRVJSKHNldCkpIHsKIAkJ
ZXJyID0gUFRSX0VSUihzZXQpOwogCQlnb3RvIGVycl9vdXQ7CkBAIC0xOTE5LDcgKzE5MDYsNyBA
QCBzdGF0aWMgaW50IGJ0Zl9lbnN1cmVfbW9kaWZpYWJsZShzdHJ1Y3QgYnRmICpidGYpCiAKIAkv
KiBvbmx5IHdoZW4gZXZlcnl0aGluZyB3YXMgc3VjY2Vzc2Z1bCwgdXBkYXRlIGludGVybmFsIHN0
YXRlICovCiAJYnRmLT50eXBlc19kYXRhID0gdHlwZXM7Ci0JYnRmLT50eXBlc19kYXRhX2NhcCA9
IGJ0Zi0+aGRyLT50eXBlX2xlbjsKKwlidGYtPnR5cGVzX2RhdGFfY2FwID0gYnRmLT5oZHIudHlw
ZV9sZW47CiAJYnRmLT5zdHJzX2RhdGEgPSBOVUxMOwogCWJ0Zi0+c3Ryc19zZXQgPSBzZXQ7CiAJ
aWYgKGtpbmRfbGF5b3V0KQpAQCAtMTkyNyw5ICsxOTE0LDkgQEAgc3RhdGljIGludCBidGZfZW5z
dXJlX21vZGlmaWFibGUoc3RydWN0IGJ0ZiAqYnRmKQogCS8qIGlmIEJURiB3YXMgY3JlYXRlZCBm
cm9tIHNjcmF0Y2gsIGFsbCBzdHJpbmdzIGFyZSBndWFyYW50ZWVkIHRvIGJlCiAJICogdW5pcXVl
IGFuZCBkZWR1cGxpY2F0ZWQKIAkgKi8KLQlpZiAoYnRmLT5oZHItPnN0cl9sZW4gPT0gMCkKKwlp
ZiAoYnRmLT5oZHIuc3RyX2xlbiA9PSAwKQogCQlidGYtPnN0cnNfZGVkdXBlZCA9IHRydWU7Ci0J
aWYgKCFidGYtPmJhc2VfYnRmICYmIGJ0Zi0+aGRyLT5zdHJfbGVuID09IDEpCisJaWYgKCFidGYt
PmJhc2VfYnRmICYmIGJ0Zi0+aGRyLnN0cl9sZW4gPT0gMSkKIAkJYnRmLT5zdHJzX2RlZHVwZWQg
PSB0cnVlOwogCiAJLyogaW52YWxpZGF0ZSByYXdfZGF0YSByZXByZXNlbnRhdGlvbiAqLwpAQCAt
MTk5NSw3ICsxOTgyLDcgQEAgaW50IGJ0Zl9fYWRkX3N0cihzdHJ1Y3QgYnRmICpidGYsIGNvbnN0
IGNoYXIgKnMpCiAJaWYgKG9mZiA8IDApCiAJCXJldHVybiBsaWJicGZfZXJyKG9mZik7CiAKLQli
dGYtPmhkci0+c3RyX2xlbiA9IHN0cnNldF9fZGF0YV9zaXplKGJ0Zi0+c3Ryc19zZXQpOworCWJ0
Zi0+aGRyLnN0cl9sZW4gPSBzdHJzZXRfX2RhdGFfc2l6ZShidGYtPnN0cnNfc2V0KTsKIAogCXJl
dHVybiBidGYtPnN0YXJ0X3N0cl9vZmYgKyBvZmY7CiB9CkBAIC0yMDAzLDcgKzE5OTAsNyBAQCBp
bnQgYnRmX19hZGRfc3RyKHN0cnVjdCBidGYgKmJ0ZiwgY29uc3QgY2hhciAqcykKIHN0YXRpYyB2
b2lkICpidGZfYWRkX3R5cGVfbWVtKHN0cnVjdCBidGYgKmJ0Ziwgc2l6ZV90IGFkZF9zeikKIHsK
IAlyZXR1cm4gbGliYnBmX2FkZF9tZW0oJmJ0Zi0+dHlwZXNfZGF0YSwgJmJ0Zi0+dHlwZXNfZGF0
YV9jYXAsIDEsCi0JCQkgICAgICBidGYtPmhkci0+dHlwZV9sZW4sIFVJTlRfTUFYLCBhZGRfc3op
OworCQkJICAgICAgYnRmLT5oZHIudHlwZV9sZW4sIFVJTlRfTUFYLCBhZGRfc3opOwogfQogCiBz
dGF0aWMgdm9pZCBidGZfdHlwZV9pbmNfdmxlbihzdHJ1Y3QgYnRmX3R5cGUgKnQpCkBAIC0yMDEz
LDI4ICsyMDAwLDI4IEBAIHN0YXRpYyB2b2lkIGJ0Zl90eXBlX2luY192bGVuKHN0cnVjdCBidGZf
dHlwZSAqdCkKIAogc3RhdGljIHZvaWQgYnRmX2hkcl91cGRhdGVfdHlwZV9sZW4oc3RydWN0IGJ0
ZiAqYnRmLCBpbnQgbmV3X2xlbikKIHsKLQlidGYtPmhkci0+dHlwZV9sZW4gPSBuZXdfbGVuOwot
CWJ0Zi0+aGRyLT5zdHJfb2ZmID0gbmV3X2xlbjsKKwlidGYtPmhkci50eXBlX2xlbiA9IG5ld19s
ZW47CisJYnRmLT5oZHIuc3RyX29mZiA9IG5ld19sZW47CiAJaWYgKGJ0Zi0+a2luZF9sYXlvdXQp
Ci0JCWJ0Zi0+aGRyLT5raW5kX2xheW91dF9vZmYgPSBidGYtPmhkci0+dHlwZV9sZW4gKyByb3Vu
ZHVwKGJ0Zi0+aGRyLT5zdHJfbGVuLCA0KTsKKwkJYnRmLT5oZHIua2luZF9sYXlvdXRfb2ZmID0g
YnRmLT5oZHIudHlwZV9sZW4gKyByb3VuZHVwKGJ0Zi0+aGRyLnN0cl9sZW4sIDQpOwogfQogCiBz
dGF0aWMgdm9pZCBidGZfaGRyX3VwZGF0ZV9zdHJfbGVuKHN0cnVjdCBidGYgKmJ0ZiwgaW50IG5l
d19sZW4pCiB7Ci0JYnRmLT5oZHItPnN0cl9sZW4gPSBuZXdfbGVuOworCWJ0Zi0+aGRyLnN0cl9s
ZW4gPSBuZXdfbGVuOwogCWlmIChidGYtPmtpbmRfbGF5b3V0KQotCQlidGYtPmhkci0+a2luZF9s
YXlvdXRfb2ZmID0gYnRmLT5oZHItPnR5cGVfbGVuICsgcm91bmR1cChuZXdfbGVuLCA0KTsKKwkJ
YnRmLT5oZHIua2luZF9sYXlvdXRfb2ZmID0gYnRmLT5oZHIudHlwZV9sZW4gKyByb3VuZHVwKG5l
d19sZW4sIDQpOwogfQogCiBzdGF0aWMgaW50IGJ0Zl9jb21taXRfdHlwZShzdHJ1Y3QgYnRmICpi
dGYsIGludCBkYXRhX3N6KQogewogCWludCBlcnI7CiAKLQllcnIgPSBidGZfYWRkX3R5cGVfaWR4
X2VudHJ5KGJ0ZiwgYnRmLT5oZHItPnR5cGVfbGVuKTsKKwllcnIgPSBidGZfYWRkX3R5cGVfaWR4
X2VudHJ5KGJ0ZiwgYnRmLT5oZHIudHlwZV9sZW4pOwogCWlmIChlcnIpCiAJCXJldHVybiBsaWJi
cGZfZXJyKGVycik7CiAKLQlidGZfaGRyX3VwZGF0ZV90eXBlX2xlbihidGYsIGJ0Zi0+aGRyLT50
eXBlX2xlbiArIGRhdGFfc3opOworCWJ0Zl9oZHJfdXBkYXRlX3R5cGVfbGVuKGJ0ZiwgYnRmLT5o
ZHIudHlwZV9sZW4gKyBkYXRhX3N6KTsKIAlidGYtPm5yX3R5cGVzKys7CiAJcmV0dXJuIGJ0Zi0+
c3RhcnRfaWQgKyBidGYtPm5yX3R5cGVzIC0gMTsKIH0KQEAgLTIxMzgsOSArMjEyNSw5IEBAIGlu
dCBidGZfX2FkZF9idGYoc3RydWN0IGJ0ZiAqYnRmLCBjb25zdCBzdHJ1Y3QgYnRmICpzcmNfYnRm
KQogCS8qIHJlbWVtYmVyIG9yaWdpbmFsIHN0cmluZ3Mgc2VjdGlvbiBzaXplIGlmIHdlIGhhdmUg
dG8gcm9sbCBiYWNrCiAJICogcGFydGlhbCBzdHJpbmdzIHNlY3Rpb24gY2hhbmdlcwogCSAqLwot
CW9sZF9zdHJzX2xlbiA9IGJ0Zi0+aGRyLT5zdHJfbGVuOworCW9sZF9zdHJzX2xlbiA9IGJ0Zi0+
aGRyLnN0cl9sZW47CiAKLQlkYXRhX3N6ID0gc3JjX2J0Zi0+aGRyLT50eXBlX2xlbjsKKwlkYXRh
X3N6ID0gc3JjX2J0Zi0+aGRyLnR5cGVfbGVuOwogCWNudCA9IGJ0Zl9fdHlwZV9jbnQoc3JjX2J0
ZikgLSAxOwogCiAJLyogcHJlLWFsbG9jYXRlIGVub3VnaCBtZW1vcnkgZm9yIG5ldyB0eXBlcyAq
LwpAQCAtMjIxNCw3ICsyMjAxLDcgQEAgaW50IGJ0Zl9fYWRkX2J0ZihzdHJ1Y3QgYnRmICpidGYs
IGNvbnN0IHN0cnVjdCBidGYgKnNyY19idGYpCiAJICogdXBkYXRlIHR5cGUgY291bnQgYW5kIHZh
cmlvdXMgaW50ZXJuYWwgb2Zmc2V0cyBhbmQgc2l6ZXMgdG8KIAkgKiAiY29tbWl0IiB0aGUgY2hh
bmdlcyBhbmQgbWFkZSB0aGVtIHZpc2libGUgdG8gdGhlIG91dHNpZGUgd29ybGQuCiAJICovCi0J
YnRmX2hkcl91cGRhdGVfdHlwZV9sZW4oYnRmLCBidGYtPmhkci0+dHlwZV9sZW4gKyBkYXRhX3N6
KTsKKwlidGZfaGRyX3VwZGF0ZV90eXBlX2xlbihidGYsIGJ0Zi0+aGRyLnR5cGVfbGVuICsgZGF0
YV9zeik7CiAJYnRmLT5ucl90eXBlcyArPSBjbnQ7CiAKIAloYXNobWFwX19mcmVlKHAuc3RyX29m
Zl9tYXApOwpAQCAtMjIyNSw4ICsyMjEyLDggQEAgaW50IGJ0Zl9fYWRkX2J0ZihzdHJ1Y3QgYnRm
ICpidGYsIGNvbnN0IHN0cnVjdCBidGYgKnNyY19idGYpCiAJLyogemVybyBvdXQgcHJlYWxsb2Nh
dGVkIG1lbW9yeSBhcyBpZiBpdCB3YXMganVzdCBhbGxvY2F0ZWQgd2l0aAogCSAqIGxpYmJwZl9h
ZGRfbWVtKCkKIAkgKi8KLQltZW1zZXQoYnRmLT50eXBlc19kYXRhICsgYnRmLT5oZHItPnR5cGVf
bGVuLCAwLCBkYXRhX3N6KTsKLQltZW1zZXQoYnRmLT5zdHJzX2RhdGEgKyBvbGRfc3Ryc19sZW4s
IDAsIGJ0Zi0+aGRyLT5zdHJfbGVuIC0gb2xkX3N0cnNfbGVuKTsKKwltZW1zZXQoYnRmLT50eXBl
c19kYXRhICsgYnRmLT5oZHIudHlwZV9sZW4sIDAsIGRhdGFfc3opOworCW1lbXNldChidGYtPnN0
cnNfZGF0YSArIG9sZF9zdHJzX2xlbiwgMCwgYnRmLT5oZHIuc3RyX2xlbiAtIG9sZF9zdHJzX2xl
bik7CiAKIAkvKiBhbmQgbm93IHJlc3RvcmUgb3JpZ2luYWwgc3RyaW5ncyBzZWN0aW9uIHNpemU7
IHR5cGVzIGRhdGEgc2l6ZQogCSAqIHdhc24ndCBtb2RpZmllZCwgc28gZG9lc24ndCBuZWVkIHJl
c3RvcmluZywgc2VlIGJpZyBjb21tZW50IGFib3ZlCkBAIC0yNTQ5LDcgKzI1MzYsNyBAQCBpbnQg
YnRmX19hZGRfZmllbGQoc3RydWN0IGJ0ZiAqYnRmLCBjb25zdCBjaGFyICpuYW1lLCBpbnQgdHlw
ZV9pZCwKIAkvKiB1cGRhdGUgcGFyZW50IHR5cGUncyB2bGVuIGFuZCBrZmxhZyAqLwogCXQtPmlu
Zm8gPSBidGZfdHlwZV9pbmZvKGJ0Zl9raW5kKHQpLCBidGZfdmxlbih0KSArIDEsIGlzX2JpdGZp
ZWxkIHx8IGJ0Zl9rZmxhZyh0KSk7CiAKLQlidGZfaGRyX3VwZGF0ZV90eXBlX2xlbihidGYsIGJ0
Zi0+aGRyLT50eXBlX2xlbiArIHN6KTsKKwlidGZfaGRyX3VwZGF0ZV90eXBlX2xlbihidGYsIGJ0
Zi0+aGRyLnR5cGVfbGVuICsgc3opOwogCXJldHVybiAwOwogfQogCkBAIC0yNjU4LDcgKzI2NDUs
NyBAQCBpbnQgYnRmX19hZGRfZW51bV92YWx1ZShzdHJ1Y3QgYnRmICpidGYsIGNvbnN0IGNoYXIg
Km5hbWUsIF9fczY0IHZhbHVlKQogCWlmICh2YWx1ZSA8IDApCiAJCXQtPmluZm8gPSBidGZfdHlw
ZV9pbmZvKGJ0Zl9raW5kKHQpLCBidGZfdmxlbih0KSwgdHJ1ZSk7CiAKLQlidGZfaGRyX3VwZGF0
ZV90eXBlX2xlbihidGYsIGJ0Zi0+aGRyLT50eXBlX2xlbiArIHN6KTsKKwlidGZfaGRyX3VwZGF0
ZV90eXBlX2xlbihidGYsIGJ0Zi0+aGRyLnR5cGVfbGVuICsgc3opOwogCXJldHVybiAwOwogfQog
CkBAIC0yNzI5LDcgKzI3MTYsNyBAQCBpbnQgYnRmX19hZGRfZW51bTY0X3ZhbHVlKHN0cnVjdCBi
dGYgKmJ0ZiwgY29uc3QgY2hhciAqbmFtZSwgX191NjQgdmFsdWUpCiAJdCA9IGJ0Zl9sYXN0X3R5
cGUoYnRmKTsKIAlidGZfdHlwZV9pbmNfdmxlbih0KTsKIAotCWJ0Zl9oZHJfdXBkYXRlX3R5cGVf
bGVuKGJ0ZiwgYnRmLT5oZHItPnR5cGVfbGVuICsgc3opOworCWJ0Zl9oZHJfdXBkYXRlX3R5cGVf
bGVuKGJ0ZiwgYnRmLT5oZHIudHlwZV9sZW4gKyBzeik7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTI5
NjcsNyArMjk1NCw3IEBAIGludCBidGZfX2FkZF9mdW5jX3BhcmFtKHN0cnVjdCBidGYgKmJ0Ziwg
Y29uc3QgY2hhciAqbmFtZSwgaW50IHR5cGVfaWQpCiAJdCA9IGJ0Zl9sYXN0X3R5cGUoYnRmKTsK
IAlidGZfdHlwZV9pbmNfdmxlbih0KTsKIAotCWJ0Zl9oZHJfdXBkYXRlX3R5cGVfbGVuKGJ0Ziwg
YnRmLT5oZHItPnR5cGVfbGVuICsgc3opOworCWJ0Zl9oZHJfdXBkYXRlX3R5cGVfbGVuKGJ0Ziwg
YnRmLT5oZHIudHlwZV9sZW4gKyBzeik7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTMxMDMsNyArMzA5
MCw3IEBAIGludCBidGZfX2FkZF9kYXRhc2VjX3Zhcl9pbmZvKHN0cnVjdCBidGYgKmJ0ZiwgaW50
IHZhcl90eXBlX2lkLCBfX3UzMiBvZmZzZXQsIF9fCiAJdCA9IGJ0Zl9sYXN0X3R5cGUoYnRmKTsK
IAlidGZfdHlwZV9pbmNfdmxlbih0KTsKIAotCWJ0Zl9oZHJfdXBkYXRlX3R5cGVfbGVuKGJ0Ziwg
YnRmLT5oZHItPnR5cGVfbGVuICsgc3opOworCWJ0Zl9oZHJfdXBkYXRlX3R5cGVfbGVuKGJ0Ziwg
YnRmLT5oZHIudHlwZV9sZW4gKyBzeik7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTU1MTQsMTggKzU1
MDEsMTggQEAgc3RhdGljIGludCBidGZfZGVkdXBfY29tcGFjdF90eXBlcyhzdHJ1Y3QgYnRmX2Rl
ZHVwICpkKQogCS8qIHNocmluayBzdHJ1Y3QgYnRmJ3MgaW50ZXJuYWwgdHlwZXMgaW5kZXggYW5k
IHVwZGF0ZSBidGZfaGVhZGVyICovCiAJZC0+YnRmLT5ucl90eXBlcyA9IG5leHRfdHlwZV9pZCAt
IGQtPmJ0Zi0+c3RhcnRfaWQ7CiAJZC0+YnRmLT50eXBlX29mZnNfY2FwID0gZC0+YnRmLT5ucl90
eXBlczsKLQlkLT5idGYtPmhkci0+dHlwZV9sZW4gPSBwIC0gZC0+YnRmLT50eXBlc19kYXRhOwor
CWQtPmJ0Zi0+aGRyLnR5cGVfbGVuID0gcCAtIGQtPmJ0Zi0+dHlwZXNfZGF0YTsKIAluZXdfb2Zm
cyA9IGxpYmJwZl9yZWFsbG9jYXJyYXkoZC0+YnRmLT50eXBlX29mZnMsIGQtPmJ0Zi0+dHlwZV9v
ZmZzX2NhcCwKIAkJCQkgICAgICAgc2l6ZW9mKCpuZXdfb2ZmcykpOwogCWlmIChkLT5idGYtPnR5
cGVfb2Zmc19jYXAgJiYgIW5ld19vZmZzKQogCQlyZXR1cm4gLUVOT01FTTsKIAlkLT5idGYtPnR5
cGVfb2ZmcyA9IG5ld19vZmZzOwotCWQtPmJ0Zi0+aGRyLT5zdHJfb2ZmID0gZC0+YnRmLT5oZHIt
PnR5cGVfbGVuOwotCWQtPmJ0Zi0+cmF3X3NpemUgPSBkLT5idGYtPmhkci0+aGRyX2xlbiArIGQt
PmJ0Zi0+aGRyLT50eXBlX2xlbiArIGQtPmJ0Zi0+aGRyLT5zdHJfbGVuOworCWQtPmJ0Zi0+aGRy
LnN0cl9vZmYgPSBkLT5idGYtPmhkci50eXBlX2xlbjsKKwlkLT5idGYtPnJhd19zaXplID0gZC0+
YnRmLT5oZHIuaGRyX2xlbiArIGQtPmJ0Zi0+aGRyLnR5cGVfbGVuICsgZC0+YnRmLT5oZHIuc3Ry
X2xlbjsKIAlpZiAoZC0+YnRmLT5raW5kX2xheW91dCkgewotCQlkLT5idGYtPmhkci0+a2luZF9s
YXlvdXRfb2ZmID0gZC0+YnRmLT5oZHItPnN0cl9vZmYgKyByb3VuZHVwKGQtPmJ0Zi0+aGRyLT5z
dHJfbGVuLAorCQlkLT5idGYtPmhkci5raW5kX2xheW91dF9vZmYgPSBkLT5idGYtPmhkci5zdHJf
b2ZmICsgcm91bmR1cChkLT5idGYtPmhkci5zdHJfbGVuLAogCQkJCQkJCQkJICAgICAgNCk7Ci0J
CWQtPmJ0Zi0+cmF3X3NpemUgPSByb3VuZHVwKGQtPmJ0Zi0+cmF3X3NpemUsIDQpICsgZC0+YnRm
LT5oZHItPmtpbmRfbGF5b3V0X2xlbjsKKwkJZC0+YnRmLT5yYXdfc2l6ZSA9IHJvdW5kdXAoZC0+
YnRmLT5yYXdfc2l6ZSwgNCkgKyBkLT5idGYtPmhkci5raW5kX2xheW91dF9sZW47CiAJfQogCXJl
dHVybiAwOwogfQpAQCAtNTk4NCw3ICs1OTcxLDcgQEAgaW50IGJ0Zl9fZGlzdGlsbF9iYXNlKGNv
bnN0IHN0cnVjdCBidGYgKnNyY19idGYsIHN0cnVjdCBidGYgKipuZXdfYmFzZV9idGYsCiAJCWdv
dG8gZG9uZTsKIAl9CiAJZGlzdC5zcGxpdF9zdGFydF9pZCA9IGJ0Zl9fdHlwZV9jbnQob2xkX2Jh
c2UpOwotCWRpc3Quc3BsaXRfc3RhcnRfc3RyID0gb2xkX2Jhc2UtPmhkci0+c3RyX2xlbjsKKwlk
aXN0LnNwbGl0X3N0YXJ0X3N0ciA9IG9sZF9iYXNlLT5oZHIuc3RyX2xlbjsKIAogCS8qIFBhc3Mg
b3ZlciBzcmMgc3BsaXQgQlRGOyBnZW5lcmF0ZSB0aGUgbGlzdCBvZiBiYXNlIEJURiB0eXBlIGlk
cyBpdAogCSAqIHJlZmVyZW5jZXM7IHRoZXNlIHdpbGwgY29uc3RpdHV0ZSBvdXIgZGlzdGlsbGVk
IEJURiBzZXQgdG8gYmUKQEAgLTYwNTMsMTQgKzYwNDAsMTQgQEAgaW50IGJ0Zl9fZGlzdGlsbF9i
YXNlKGNvbnN0IHN0cnVjdCBidGYgKnNyY19idGYsIHN0cnVjdCBidGYgKipuZXdfYmFzZV9idGYs
CiAKIGNvbnN0IHN0cnVjdCBidGZfaGVhZGVyICpidGZfaGVhZGVyKGNvbnN0IHN0cnVjdCBidGYg
KmJ0ZikKIHsKLQlyZXR1cm4gYnRmLT5oZHI7CisJcmV0dXJuICZidGYtPmhkcjsKIH0KIAogdm9p
ZCBidGZfc2V0X2Jhc2VfYnRmKHN0cnVjdCBidGYgKmJ0ZiwgY29uc3Qgc3RydWN0IGJ0ZiAqYmFz
ZV9idGYpCiB7CiAJYnRmLT5iYXNlX2J0ZiA9IChzdHJ1Y3QgYnRmICopYmFzZV9idGY7CiAJYnRm
LT5zdGFydF9pZCA9IGJ0Zl9fdHlwZV9jbnQoYmFzZV9idGYpOwotCWJ0Zi0+c3RhcnRfc3RyX29m
ZiA9IGJhc2VfYnRmLT5oZHItPnN0cl9sZW4gKyBiYXNlX2J0Zi0+c3RhcnRfc3RyX29mZjsKKwli
dGYtPnN0YXJ0X3N0cl9vZmYgPSBiYXNlX2J0Zi0+aGRyLnN0cl9sZW4gKyBiYXNlX2J0Zi0+c3Rh
cnRfc3RyX29mZjsKIH0KIAogaW50IGJ0Zl9fcmVsb2NhdGUoc3RydWN0IGJ0ZiAqYnRmLCBjb25z
dCBzdHJ1Y3QgYnRmICpiYXNlX2J0ZikK


--=-s0MPYegAAwpUx87Q52AR--

