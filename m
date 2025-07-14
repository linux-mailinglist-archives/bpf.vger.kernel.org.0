Return-Path: <bpf+bounces-63271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB44DB04AB0
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4FF168473
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D0279910;
	Mon, 14 Jul 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZhg5ioi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8919CD01;
	Mon, 14 Jul 2025 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532208; cv=none; b=CnTV6VO3KWWKWSb0CnZaE2pz7lbEXZ3faoW1OPJbxtfuT7ymVE98xcU6Kmx1IIKpqshKhTc+8R81spmnoRmSS3h0YaRlRStHneIhAYovfeTFqZe+HGX+C4I6numtWAbqqgbSAt+PMzTh3d6JzwnwFAqpdG/0qugMZUKXgL1eybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532208; c=relaxed/simple;
	bh=7yQAdW8SgBlbelXCbyx+6x3Eo2rdkzWH0feLGuqFTXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfHcMhnxlWV3jQN+Mkvv2YlOF8E1asMTb5IqzKu7bFlXnU0bDXFLXCQI/+JafyXQHLk1wNLKpXFRVUqPZ9/57nTtW/S9D2X7UKjkWsIMPDFVnT4Y81q9cM9Tpf4bHm290ljDYE8SvVppZPkSwyedD8/X/nm0SLAGxSKmQTW/Cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZhg5ioi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso2200243f8f.0;
        Mon, 14 Jul 2025 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752532205; x=1753137005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voZKt3OZFqV4HNSRlyMI/mjoMu7OKrG93jyyqd7nrWM=;
        b=HZhg5ioi91Ml1GZ87fOR4V5weTC+q5vODAfowzgyE0U4b2bEySwticsPP9EJgEbXSc
         p630TGApDq4qmgM/dIYgjVSA5ikSJeSZ2fCLy+J0TiZBJVCE4w+v4SmKkUJyN6LZ0uej
         ia/4KdUF2oiGx7I1Tf/f+R1hmZkprLVAQFVRbMuXpuCq2sEx2tFlSrzNslKvdOOow/TB
         DQgxKVtkiXNueaVPYmSmCkb1SFj/Hz5bOmTwToVGBq2zUr4JmU4Z53nh5bLww5AkLCwj
         /40wIG7XsRdDLnWFD3bd4K/Too6fhCFGZ6+Q2Kcw8Xo5x2ZBBEfUQkmqzb50dZNocwB6
         AyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752532205; x=1753137005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voZKt3OZFqV4HNSRlyMI/mjoMu7OKrG93jyyqd7nrWM=;
        b=pZKmTjRLgsG1IBZNfUAVsgzciK9xgOMwNq2SXuWxdKumNuuPNtJ39CsG1iIcAtlqPp
         E88lHM7B43N68/PaGG/wPO/kQlwcUZ8yTOMlmyBsPr3I4zrpmm+C/VglDYoBFQzVBOJG
         8Tm7Bro4huBt7HKi4cuQPPFwUQliJx7jX5At6drYzXfLAqfu9S85zzcQABFjRxfbK7k1
         IEMbqpLLu3jJDiWTI9/eoi/Rzyk9YzASjqErNHDH4rHleEMFFw1uIBfwnae6ZFb2nbul
         mZHSNNZUOEi9UfZmyB6t58+HuLR+ZrhVcIcgVM0/gSVXauyaJfVBCaQnVXroB6PWVQTq
         y46Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL1CehJ4E+Clvfy31o0p8pXoSLeNHpLIiXxr3Drw/Lf1BiUtv5lTLyWtEhJ7wlazTnMtv0HnTwRvSDju6z@vger.kernel.org, AJvYcCWLnCp3B93/YOEcsq6rs8BJazmdxYMT3gn8xz2j75gLVoUgDVYgTXwPZvmLjNMmV2xQAxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2eY4yQaGmnCJoiNf2Cvb35vhI+H/VuTmShiWA+eqZi7yWs1D
	ZMlAYCi+x4sJ2aqy5lQnZLiS+jtpxqkx+70Zu7QjP9GiKus8TD+syrx5NrVkODgZHVqRuAO3tAt
	ykKVqABy/3GAPdFcInFWzz/Nz5DUeT2Y=
X-Gm-Gg: ASbGncu29CJxn6KcLsE26rmAQO5WvSNXWqtrvNHHCTTxD4eXYacvCZgJ4oT1fRvTND7
	i8a3xwO2/VEsk0p2oV0JnIHKVWgDEQMPh+Bu2E8KQ4Pv/peD+ZDvI8sBPVeOqUnQru0ZZdWYHIs
	CVFM80fUuGF01AghEOMpvuwUxL7Yx3j+PGvDlviNxMo6Yij6wcYwfga4wjJcfWRIcmMThX/QGfW
	puBZSxzh77k2JpB2pBQzLbMYF2n+Xxtm0lT
X-Google-Smtp-Source: AGHT+IGRbeX8fmsTNmKi5NQJnQub/iuiFTDd8ihavQgYpw6Dr2yi6L1mh3Ir2506x2DmRqaEm+Uado/mD563wWrauMw=
X-Received: by 2002:a5d:5f52:0:b0:3a6:c923:bc5f with SMTP id
 ffacd0b85a97d-3b5f187ebaamr13502161f8f.17.1752532204746; Mon, 14 Jul 2025
 15:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com> <750dd5f1-a5f8-4ed2-a448-1a57cb5447dc@linux.dev>
In-Reply-To: <750dd5f1-a5f8-4ed2-a448-1a57cb5447dc@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 15:29:53 -0700
X-Gm-Features: Ac12FXzSMKRUSNRy4FW07LRiVVjWQ8Ewfne8bN1Fu_Wa64oMvuCGk59Vmnd-nkY
Message-ID: <CAADnVQLHORFKC3PzJ540xxa_bETBypXu2-z7Z+8c+as97vByXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 2:50=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> On 2025/7/15 03:52, Alexei Starovoitov wrote:
> > On Thu, Jul 10, 2025 at 12:10=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> >>                          } else {
> >> -                               addr =3D kallsyms_lookup_name(tname);
> >> +                               ret =3D bpf_lookup_attach_addr(NULL, t=
name, &addr);
> >>                          }
> > Not sure why your benchmarking doesn't show the difference,
> > but above is a big regression.
> > kallsyms_lookup_name() is a binary search whereas your
> > bpf_lookup_attach_addr() is linear.
> > You should see a massive degradation in multi-kprobe attach speeds.
>
>
> Hi, Alexei. Like I said above, the benchmarking does have
> a difference for the symbol in the modules, which makes
> the attachment time increased from 0.135543s to 0.176904s
> for 8631 symbols. As the symbols in the modules
> is not plentiful, which makes the overhead slight(or not?).
>
> But for the symbol in vmlinux, bpf_lookup_attach_addr() will
> call kallsyms_on_each_match_symbol(), which is also
> a binary search, so the benchmarking has no difference,
> which makes sense.

I see.
Just curious, what was the function count in modules on your system ?
cat /proc/kallsyms|grep '\['|grep -v bpf|wc -l

Only now I read the diff carefully enough to realize that
you're looking for duplicates across vmlinux and that one module.

Why ?
BTF based attachment identifies a specific module.
Even if there are dups between that module and vmlinux the attachment
is not ambiguous.

> I thought we don't need this patch after the pahole fixes this
> problem. Should I send a V4?

pahole should fix it, so this change is not needed.
But pahole will be removing the dups within vmlinux and
within each module independently. Not across them.
I don't think "across" is needed, but you somehow believe that
it's necessary ? (based on this diff)

