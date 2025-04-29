Return-Path: <bpf+bounces-56976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F282AA1B8A
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867D83AF575
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98625F978;
	Tue, 29 Apr 2025 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6+pPx6i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CC25E811;
	Tue, 29 Apr 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956229; cv=none; b=QCEs53/GTrt7hjM5aG/1yfSGE5nZ3DgnTV5+MWARd7t+z/QLEQVdKQ0KDYvPibG3ptNzkMwI2X5o7lIIp/ITx8LyHUfc0+1g+rdqsG8ZQ+GtjJ+X9GDlSK47otkGeKOkfE1udgDSuCfeGcBbGNXfkrFgmGA7kONGtPYDJ9H50oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956229; c=relaxed/simple;
	bh=BItqMSD6J6ZfWQL+2Bk9gueOFB2WSrpespcn/UIqe/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fkf8q70v7DYRcStFwoaiE1JWrXA2uAMSDOmZe3uCNBRKK4oi57pN57AT0kpyQchFXH9MTTDgtt4pktNqc6JANbjcKpRLNL1Owh1E2zGevrxHWZ5UmjOoadsNYu4oTA0pqYJAVAcut21v6GDosTAbmWzgiQZAyoX/PXfv5mImmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6+pPx6i; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7398d65476eso209654b3a.1;
        Tue, 29 Apr 2025 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745956227; x=1746561027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCw4+EP96y/MYT/yVn/VPSKOHpbcI+CSChlyzXSJg5U=;
        b=F6+pPx6iPfBLOah5gUlpO2r8WrY4Pc8mC0VSJZboF+KLO2sXTD+Hfi6evT18NSDKkc
         YbJ8GUTRNrmWA5eIVyPHHi1mUmme1fx00c7JuufETvd5oiA0lsa+GZyfyQx2JABnUY6h
         ByK8clW37iUfNlfwYdOlgpVLkwddmU5s99dBrA+Gs5JD90DVZq78+/386Q74P3aJ+Ppn
         T/a9Li4DLjyP2A4E5Z4hPwWnjkwVJd9rZ60sNql4NYJtYc4YuvnHNOFRb1RcrSpjfR6O
         ADUAkuEDdqEp1p4UL1jRIRuttTBITskzdHtFMVhE5OQyayC7Bk9lrRNlAwaEGuCy8bLW
         w5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745956227; x=1746561027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCw4+EP96y/MYT/yVn/VPSKOHpbcI+CSChlyzXSJg5U=;
        b=frXLgnIwjV6aozCxXNsk01PJ8Y/oAIjofWmlwMfeWpMa1qJQprtCYFnh8ISKJ6UEEi
         ENVLNhzsICxfvgFVSQZGbhytCkdGT3kYlhUX1fx+5FSqdOmoVDhnAHMmxh9y5bfZ6Amf
         KnEPGXQuxTF2bl3lqckcetim8zYpxAM9nK8BuijgtDo3WwAzZGcGE6bpRmHhM4BYpvcp
         dFUAXYACRoQ5PN6c1gxX/xx0HIMeTM3uwTAv8A8O1b1CR75nP/wBDvVF0nD3GySi5nVz
         eDIr4iZJl2gnJH8Kj/VqPW+8lcIvyseLjwVzmvwnJA6btE5F1Ej3ghtL2S19ewQ1US38
         tL5w==
X-Forwarded-Encrypted: i=1; AJvYcCVtzSs0UQcVKNtLpLjcbpIjrHm54MoDrd31s19Eg9EgOspMV2/Q3v6Ok7c0KtN7yuvPIV6wQS0nFA==@vger.kernel.org, AJvYcCWWNEw/gY3MCwGBOR7mbXRVOt4OallHcEBode9yUWRgvhlPBBTy9mEVx2nKKRTVte1DnN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRCPJ7P2CweyA/NhdPSqwRIV+RzbAYvKmoK7p1Q1+1EAWL+OD
	F285DeZaAEdkgc+1lxlvpZxJvdaI+bAG8qOS6PUhW3DDd6ULAE6LQ5oA0wv402zqW3uaVTtLNsN
	1Vi+0e40RaoMEx7rgFTkOVhiLVBg=
X-Gm-Gg: ASbGnctgF0sgnYkGAsYHgbIDc+ccxE7B/F/ddViLbMs4aImf0XTTQB9wj8xwCfBkeKk
	Y87+B1oRuyzZhizOSeJiKAt6kEoKJsaETeeRPQxPVkqsTTDH7dUzS2OmbDgP5xUTnmR1j0LwvKx
	6eX/8vOhpYOhgEjnAmp8axvMkUzHlkHtCcALENNA==
X-Google-Smtp-Source: AGHT+IGaUQmZIR4YyKiFl5MEjuWW5cngTwnSpmmdLd+LqEYzTlxjh68CYKM5/i7ygYPrx8jK0qWNfloEMYI90yPPlBE=
X-Received: by 2002:a05:6a00:1888:b0:737:cd8:2484 with SMTP id
 d2e1a72fcca58-74039ab7a4cmr235231b3a.6.1745956226886; Tue, 29 Apr 2025
 12:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com> <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com> <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
 <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
 <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
 <CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
 <CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com> <m2ldrihikq.fsf@gmail.com>
In-Reply-To: <m2ldrihikq.fsf@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Apr 2025 12:50:14 -0700
X-Gm-Features: ATxdqUHcQJ6eRVTblzjR98j8m-bZL0uiz7OUz7OSEkCiXX-dv2_QpMfWoB-YcxI
Message-ID: <CAEf4Bzb_-Wk8eWZyPc7_r2Oq_o_Tgg+2CE+nTom2wOhjcpDw4A@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 12:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> [...]
>
> > Ok, so sleeping on this a bit more, I'm hesitant to do this more
> > generic approach, as now we'll be running a risk of potentially
> > looping indefinitely (the max_depth check I added doesn't completely
> > prevent this).
>
> Is that different from what happens already?

yes, it's different, we don't follow pointers. that identical_structs
recurse only for embedded/nested structs, not structs-by-pointer.
idential_arrays also doesn't follow any references

so it could lead to loop only if BTF is broken and we have one struct
embedding another, while that other embeds its parent, which isn't
legal in BTF and C (so whatever)

>
>   /* Check if given two types are identical STRUCT/UNION definitions */
>   static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1,=
 __u32 id2)
>   {
>           [...]
>           for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, m1++, m2++) {
>                   if (...
>                       !btf_dedup_identical_structs(d, m1->type, m2->type)=
) // <-- recursion,
>                           return false;                                  =
  //     afaiu it is unbounded.
>           }
>           return true;
>   }
>
> E.g. adding an array to mark visited types and stop descend should stop
> inifinite recurusion. I agree with Alan, the patch you shared in the
> evening looks interesting. (But it was butchered by gmail,
> fixing patches by hand is a bit annoyiong, maybe just attach such files?)=
.

yeah, I know that gmail butchers diffs, I just wanted to give a rough
idea, didn't expect anyone wanting to apply it (plus I did it on top
of Github-based libbpf inside pahole's libbpf submodule)

But here you go if you want to play with it ([0]).

And yes, "visited" marks are the solution, but I was thinking that if
we implement a pre-processing deduplication step as we discussed
offline, we won't need to do any of this, so didn't want to pursue
this further. But we can talk about this, of course. So far this
generality doesn't buy us anything, I got byte-for-byte identical
bpf_testmod.ko with Alan's and my changes all the same.

  [0] https://gist.github.com/anakryiko/fd1c84dcad91141d27d8bd33453521d1

>
> [...]

