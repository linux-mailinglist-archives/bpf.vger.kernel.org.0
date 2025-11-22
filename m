Return-Path: <bpf+bounces-75296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB9C7CADF
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 09:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB50F357C87
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A0296BA7;
	Sat, 22 Nov 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay8RENDt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71B1AA7A6
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763800740; cv=none; b=djbUR0sToXvhNxMLV0RjPHngeGr994ZRzml2a8AC3qrmKltpC/EeLmxi3RTW76ZxeknzkF6pY8YiN+hs1RK2CZ6HO3GxTkfeacxG2GpTmCCVY+hPyT8bb5NKgOLYfJ/SHeSWleiXHz+2rrgvR6xab4iV6lIMDJHJEp/ZJreNT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763800740; c=relaxed/simple;
	bh=yU7rAQ5nfxXHeYO2QephzwP+Ub3TftF3coF3CrSMFrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCUzVISfhzI5K9xaM+5o4+lYC6oy4Sl1FyISxTFOUpGdJR7YmFrEV6atBsy1ouQSXHtJf+8r+QF4tZXJQmckW92MwutwHc2a1cRWrbOziXSOmPQG5tg90sF4nwO/Dgaj2GelmJbjbpnddjENpuioD7ioy3YN8aso2jCyUORIPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay8RENDt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so4090838a12.2
        for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763800737; x=1764405537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU7rAQ5nfxXHeYO2QephzwP+Ub3TftF3coF3CrSMFrw=;
        b=Ay8RENDtLxSjACsd1iDl17q8bTHIfhS1ysyhyWfRH8fTqzJwkCNRVQlabWy61vs7QZ
         gA3FGTt6ETk0bdMInFs6DxIsqgL4XjC1FyRWRxP7nNAR1cvRfc62THXdqMt6PZ9ghXwT
         2HAUhUJsNWlRbxjgRWEXfriJqjfa3Sz6G/pZqlc6nT6FoGiJB8VAPrZENMfLpkxLe95C
         NuzpwkPT3pxBsJY7Iwe34wlaNz297vNRALDfQavUazpDzWyaXMzxZihpLFxDd9eXy9QZ
         P3/kfGv58+l67o/D0Xl6A7mxjbRXw/+MAJKDLFYE+xKzb5rvmM3t9+x/sjlmo+kcmlej
         0RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763800737; x=1764405537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yU7rAQ5nfxXHeYO2QephzwP+Ub3TftF3coF3CrSMFrw=;
        b=no2GS45I+5F8IyZBFRY4fP2K3pvRDex4MVGqyki5ycrlUTmz1Qv1agDXpMykwXXq/u
         jkZf0V5xCG9ihwbSJvCx53sdX9AwyEB3SSZSedz0n5rbzywtQrgw04xaperkAJc/YtRY
         p1jGNc8gRdHnOJGbFyaJrdPZl8DhP8nqbe1Tzb03+Ow14c4ysMyClVWxSPJLLd6g+Kin
         yQyNQ1fRkyLGtW+hjJUa2UGnvnd/F4ZItH3N1iY9TGbjrzY4lP8qj0wpj1hlr0bBYtzC
         6lttSkc6BARG4vI7+PDGqLOKGebF/cx8AxD6p3+HTxlLTbBr6nRWYJZoiOLd29afEVEo
         BBZw==
X-Forwarded-Encrypted: i=1; AJvYcCUzht3Zhg78OqvjVq9Vds3mc9X4T5fP9zuC21Ed67rXsMeQzYXvfH+7K+tVkFFJouRiGhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kxFkNc4Yfbnk0gPACkj7KS58b3FDGpkoH179ETSmFSyFoEQ8
	0ktKgy1W9YV6kJpPB/zmOgzhxnTbdXjj4484sK1VVB3nETgaecrEQUP5p3ot8mHqEvjfNy3YE+Z
	Xcti0PjHNPHs6sZYHJDEAc+3VlNVHM0w=
X-Gm-Gg: ASbGncv3P+DC6X3mOWY7ss4jhPT/O20gD8PzWt9luJhSrDCocLoq6MtslBMgRD8MN49
	UDk1N5Q7RvJnWI/KyDUNfnfPX31DXDx2Ir0bTlepCBIFPmYKKBNb9VTif+b8Ob9fxyvgARHGjFB
	2gazxomsi5wWNsjxn6rkuVDVDhJL2eGAXpwgziVHcNQCT8cA0r/AHkMMk+PxI9+Wp4N7++yJH5j
	n5eu2gdCcDIb7Cv+xvQgaScWmea+PsEe1nChE+lnzgAIDAenuYr2nbMeOlQLocMpo0C8P3mViiG
	aYy/5lU=
X-Google-Smtp-Source: AGHT+IFmdJY9+YQiF9IQtbf0oEezXamPiOlbYohTVao6ZmJ8ujDvn+ttAkHnkEYjLrvcNPu1wvoGl99J50C9XpqpB80=
X-Received: by 2002:a17:907:9289:b0:b73:8cea:62b3 with SMTP id
 a640c23a62f3a-b767184bb90mr546880066b.41.1763800736720; Sat, 22 Nov 2025
 00:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
 <e8f499647614e592845dbdfa23d53e6c62434485.camel@gmail.com> <CAErzpmvpyLE67gEyspuj33+FCczErZJVCZuy6BEZ6miurvL7cw@mail.gmail.com>
In-Reply-To: <CAErzpmvpyLE67gEyspuj33+FCczErZJVCZuy6BEZ6miurvL7cw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 22 Nov 2025 16:38:45 +0800
X-Gm-Features: AWmQ_bl38Rofcgg2oAd_axXnCWXpujoCmWN4EwiItOt0vHPtuGnLk-t3FQcBjQk
Message-ID: <CAErzpmsCDmGvne4+TCbm09RNhfcUYVdsk_X7uoS_tSDKG=0Kqg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 3:32=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Sat, Nov 22, 2025 at 3:42=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2025-11-20 at 15:25 +0800, Donglin Peng wrote:
> >
> > [...]
> >
> > > Additionally, in the linear search branch, I saw there is a NULL chec=
k for
> > > the name returned by btf__name_by_offset. This suggests that checking
> > > name_off =3D=3D 0 alone may not be sufficient to identify an anonymou=
s type,
> > > which is why I used str_is_empty for a more robust check.
> >
> > btf_str_by_offset(btf, offset) returns NULL only when 'offset' is
> > larger then 'btf->hdr.str_len'. However, function btf_check_meta()
> > verifies that this shall not happen by invoking
> > btf_name_offset_valid() check. The btf_check_meta() is invoked for all
> > types by btf_check_all_metas() called from btf_parse_base(),
> > btf_parse_module() and btf_parse_type_sec() -> btf_parse().
> >
> > So, it appears that kernel protects itself from invalid name_off
> > values at BTF load time.
>
> Right. The kernel guarantees that btf_str_by_offsetnever returns NULL,
> and there is no NULL check performed on the name returned by
> btf_find_by_name_kind. The NULL check is included in the libbpf version
> of the function.

Sorry =E2=80=94 my mistake. There=E2=80=99s no NULL check on the name from
btf_str_by_offset in the kernel=E2=80=99s btf_find_by_name_kind. The
libbpf version has it.

>
> >
> > [...]

