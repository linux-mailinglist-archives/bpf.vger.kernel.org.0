Return-Path: <bpf+bounces-77062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2BCCCDFFB
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40BEB3042188
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214402F60BC;
	Thu, 18 Dec 2025 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acpPqWHt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F46249EB
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766101475; cv=none; b=X/kA4VzozUjNHBIQfOZBzWK1kqCBAhoo/uAWMKtee+mPzQzsrcPu2+hj7CJMeQzKZuvpacGZTOSJMrMw3uU6OskIC3EHgR/0oVmakjYOF7J/HzzbCYboI8rM3OicwWp20nGTT3dND4UdSEVxSPmNuulfXQtomrM0ldT6a6uL85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766101475; c=relaxed/simple;
	bh=dpDKz9XC1lDadaJvoaT1xfoPVclOunzraISeuGt51kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn12S25HaCFqFp90UbrWc7tiyCSDpByA4WtNeWGZ6/SJsOrUMhNQrFA8NTAxOyj7Et/rXWRqZCzUVAhLxVxSpvpQdt+LyeI8QMGjRSE4hAqZAZSe/l2cMfoBz9uvkqK0ajoB249zMbYCMYs7OSynK3FMv/cWxARRqy3rS+XTPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acpPqWHt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so1018533a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766101473; x=1766706273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6G0p9PN9T1UTqnH0s49kOWRSNs+j7DIQkZNCalydgM=;
        b=acpPqWHtGp8mkYIO48iobp5HvTjBiN+zl1SAFJlWCD/H3dwCvBGLRNfM1dOaxJiHA2
         cgXTBEO+8tSS2CVwdazkCMUTDOTi3ozf4/EN7By9iKLfVUY4XseDgcus/lBpbVKw3D52
         DpGQv4d8sJ0nHakX7S4vhytW4tnI2GAtfrVmdon29vkTE/F8fuCS8y7fQMNGjoPYT/A2
         8T6rySSvkWtjPf90P4SgscSG5D1JrAQ21XCoe5vfFSscp3/uZLSJ2I8WTwTCzR4S5Bg0
         XXvglcJAQnGcIASB0HOfRlH+G1o7CUPk2qX3+emN8Mve0q69+4tOaNT6jv6a2jB6qZFg
         Q4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766101473; x=1766706273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6G0p9PN9T1UTqnH0s49kOWRSNs+j7DIQkZNCalydgM=;
        b=HD3ZrZ0o9c4dp8J8QU/Zti2VqPr7JIsny9aqU7GCdHNm7U0biVbvulLi6ttIxB//qr
         5SwhuArpmK8I3ZZblwB8ahQGIsYIF0mfL5WphE6ARwdm1h8ujCigSKtJ/FN9lE95I7E3
         US3JMecG4Dfd2mCu3rgCz9fytgr5S3G5pBT8xifFxqA65B+kVBDU2TEocQubUJIFzEq/
         Ut2ExfTLRiKs9fhSTZONYUIYijVGeXyuNZT2w1qMQXz3I1N8X6R+eK7jkduEOzrtHR7s
         Xswm2CYHP8xZegq5qJDTpBSkAJr5mkvppEB5/bhGx8NM6Jvt1A4fupq9lMg4uRWZNn/m
         KJUA==
X-Forwarded-Encrypted: i=1; AJvYcCVOrn415ybwUck8EFAN1taJ642iJVWu3VDJNnAGoKj7S9qUdNIP2NbjUJxijbxvnkMUDGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5ZjgTcu1TSdOs3MPGf8V+gSELsqFbSv7NR3h1KExFkhXBkew
	hkHIfibU5+iHxZahA3k6ZFLSZMKhLraIqBOXP7Jni2LEY7v+rKxtLgn91jKFrIV2LmNbC9bFbqZ
	wsVhq87VslyGueDX8GGgmC6hIU66ptxETLA==
X-Gm-Gg: AY/fxX4UKzWhFJtdzRBZHM5l6yC+OaFVveidJu7cNSfxfS+7Rl64YWn0YhWaq/GfXJj
	SEKz9ZEmPZV+Op1Wi4fOifsPybSp1BCZL5whDtCDlZPQxEgvsDelbazUp8yHa3r06vIf+21lNcI
	doYOIm6G8lBL73+2/XR4Vn7fKUUIFvE26GhM+GcH+s9qd8xsvHY7ZX3SuXRokS49kLEwFmCHo+M
	DGVvLjnP5Z7RC5LCeqiZdzXxWIIyUH1wCtwkBMzlloUL+jvrt18a121ESNoGU4PagMUX4epEqDh
	jihfPUTBVYs=
X-Google-Smtp-Source: AGHT+IHim5qQUR4sLQVK7zhDOT8E5X5T0TDonVe9DgsTQBiZxLvPcFsh27Y04L5uPUSv2szRRc/f1B0bqu8IOWEY3GQ=
X-Received: by 2002:a17:90b:580e:b0:340:c179:365a with SMTP id
 98e67ed59e1d1-34e91f6c085mr820794a91.0.1766101473318; Thu, 18 Dec 2025
 15:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-6-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-6-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 15:44:21 -0800
X-Gm-Features: AQt7F2oVxYhqZDC0h7vZDzPh1xIxQWT9OcfU2mRNlqQrwDGpm2utwwSxUaxJtOc
Message-ID: <CAEf4BzY+gnT9aET_NDOkzX2iBwLednyK4xGe4S6JmhzN0C5GoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>

typo in subject: "Sorting" -> "sorting", it looks weird capitalized like th=
at

> This patch checks whether the BTF is sorted by name in ascending
> order. If sorted, binary search will be used when looking up types.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2facb57d7e5f..c63d46b7d74b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *btf, __u32 t=
ype_id)
>         return type_id;
>  }
>
> +/*
> + * Assuming that types are sorted by name in ascending order.
> + */

Unnecessary comment, and no, btf_compare_type_names() itself makes no
such assumption, it just compares two provided types by name. Drop the
comment, please.

> +static int btf_compare_type_names(__u32 *a, __u32 *b, const struct btf *=
btf)
> +{
> +       struct btf_type *ta =3D btf_type_by_id(btf, *a);
> +       struct btf_type *tb =3D btf_type_by_id(btf, *b);
> +       const char *na, *nb;
> +
> +       na =3D btf__str_by_offset(btf, ta->name_off);
> +       nb =3D btf__str_by_offset(btf, tb->name_off);
> +       return strcmp(na, nb);
> +}

you use this function only in one place, there is no real point having
it, especially that it uses **a pointer to type ID** as an
interface... just inline its logic in that one loop below

> +
> +static void btf_check_sorted(struct btf *btf)
> +{
> +       const struct btf_type *t;
> +       __u32 i, k, n;
> +       __u32 sorted_start_id;
> +
> +       if (btf->nr_types < 2)
> +               return;

why special casing? does it not work with nr_types =3D 0 or nr_types =3D 1?

> +
> +       sorted_start_id =3D 0;

nit: initialize in declaration


> +       n =3D btf__type_cnt(btf);
> +       for (i =3D btf->start_id; i < n; i++) {
> +               k =3D i + 1;
> +               if (k < n && btf_compare_type_names(&i, &k, btf) > 0)
> +                       return;
> +               if (sorted_start_id =3D=3D 0) {
> +                       t =3D btf_type_by_id(btf, i);
> +                       if (t->name_off)

I'd check actual string, not name_off. Technically, you can have empty
string with non-zero name_off, so why assume anything here?

> +                               sorted_start_id =3D i;
> +               }
> +       }
> +
> +       if (sorted_start_id)
> +               btf->sorted_start_id =3D sorted_start_id;

You actually made code more complicated by extracting that
btf_compare_type_names(). Compare to:

n =3D btf__type_cnt(btf);
btf->sorted_start_id =3D 0;
for (i =3D btf->start_id + 1; i < n; i++) {
   struct btf_type *t1 =3D btf_type_by_id(btf, i - 1);
   struct btf_type *t2 =3D btf_type_by_id(btf, i);
   const char *n1 =3D btf__str_by_offset(btf, t1->name_off);
   const char *n2 =3D btf__str_by_offset(btf, t2->name_off);

   if (strcmp(n1, n2) > 0)
        return;
   if (btf->sorted_start_id =3D=3D 0 && n1[0] !=3D '\0')
        btf->sorted_start_id =3D i - 1;
}


No extra k<n checks, no extra type_by_id lookups. It's minimalistic
and cleaner. And if it so happens that we get single type BTF that is
technically sorted, it doesn't matter, we always fallback to faster
linear search anyways.

Keep it simple.

> +}
> +
>  static __s32 btf_find_by_name_bsearch(const struct btf *btf, const char =
*name,
>                                                 __s32 start_id, __s32 end=
_id)
>  {
> @@ -1147,6 +1187,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf, b
>         err =3D err ?: btf_sanity_check(btf);
>         if (err)
>                 goto done;
> +       btf_check_sorted(btf);
>
>  done:
>         if (err) {
> --
> 2.34.1
>

