Return-Path: <bpf+bounces-77920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829ACF6A73
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 05:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 434C1303FE0B
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31527CB04;
	Tue,  6 Jan 2026 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCHN+fAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1767186E2E
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767673269; cv=none; b=N5hr/C/8gsQXHb6fogbyWzDwHnyLGiPJEn1w8ysGS+u/xauXG5db5ZuXMvbaoMDFw8xZDBfZLDlw5G82v8hlKuEHNlhfF+T602s87fYrSU9Ic67Kf7Cqv4vvwr/n3jEtd8FyLT+AgXRbv6H/d+SHtXjJVYM9cm4N52XHiZxm4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767673269; c=relaxed/simple;
	bh=QdiGgC8bGawkE/NfYgtXXjps+ZdKPkdxylhntu8tO68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkEiaJr1OZaCZ8awLtxid3faOlSCUngxkjwFJpQS8+35tSI+j15kKmf18DWithmwNIlxpy8RTDx8tpGNR6iL9fQ7aUD40R2KNmqQcN4C0Fpt91fD8zvyGpCbtPwSLvG3su3b12qSZbykyGEN5dCTYxBfZlhbyGlhnlsbcV+dDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCHN+fAr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43260a5a096so317843f8f.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 20:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767673266; x=1768278066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RnWf8bR9MzpHmNENe1Pna05tYYxiGOL+UoXNiAdXb8=;
        b=dCHN+fAr9wG0o3BMSBj7dsyVEVAWyfU579BfS7pdZLcU5cCQsPR/MXkJ6XFJ3+J9bZ
         JsmDAdrfVNfH7oaANzw+i0vjuHOH20MlKG9I5nm4jKbmN9ZYpq+v/gAVqvyTHLK/PemH
         yt5lhZS1FB8761MFc5jv34PTSkp/3JoUqBwXA+TpNqqj7UHwMybk1rHs0pswxVPMSXmo
         SZZpoBBZJHS5bVC6z3O0YeAx8E0ZqZ1dvplsINcrKD2msYKC9ke/bI2BqPV4ZT7k3Rar
         eFN5ss7A75rKy+DJGJCNtf+78SJJAeyw3fd7EYHv7QJrGgv3gtn/TNhi1Jt7cPmruu/0
         bVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767673266; x=1768278066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RnWf8bR9MzpHmNENe1Pna05tYYxiGOL+UoXNiAdXb8=;
        b=fc2dEhMpfxI2CG8097sxqRkVZ7ACIvyfcPfy6PEE6J7r4XhJRzQFLI195O/2V8ZYRs
         H9L79NB8VICoDgweFBTSJv8o3ps2AeBal3cqebb0IhqqZVJVirb5Vv1QydtX6iTG/cYr
         7AY5rGeK3ntfGHIJpkN0jaqxd8khV2GVtONkGrr2yRvneTth/BHfV9ul30WG/IX3WX1p
         TnatSSVqO9jxSZ6/PfAdCaWobQC8mZUENb+wiB3oS5HEN0jnQYx86rXhxTxFucBysY+j
         IGZsFbo7JoxAwQYDscOUK/ye+1pUQQ7ad10Zkd4TFGnZm89jo8qIOz9V365oZQc41pPL
         wjXw==
X-Forwarded-Encrypted: i=1; AJvYcCV+52f3aS/C9Ux4xVnlq4TyBa2ntTFeR0zvdUp8qjoV3lxTgnH1PwcZXqI80fCCkjR7lwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/dV+0kkM4/1avYVuV/pkdU5W22fQrQPWNuAALjXQ99ECNUJk
	l1ANmaMkvXM2lVt0h36ZFjN9S3ERcEBAX97qsB416PhM8+N0hskrCOWX4LKYc9fx8dpqt3EUw4H
	CQMPiEICn+XncFN5j2BdLLx/e71fH6fM=
X-Gm-Gg: AY/fxX6xESWS6MtOlMPuBleH54u1pEi4HueJtSzSXZEUBkikBfihtRxfa7m6H4Qgx4x
	AC/auUIaW5H/0OzX35B3s/zghk9AxGaNPsj0wK3wq83857u2+vpyWfsyX5hEEZS22FlYDoKkCvy
	lTGap5NHNohkaIh8zMHAN1RNc4kgg08VtFj0RCyOEkEKs7Z2y/MLJCh+m1zChAh0RG4l+WOWgAV
	Oqk+TI6CBWKs/yWRunDgGmv+/fOi2vDf8aBJ9nd3rRgWCsGo9e66+PqVqae0aYSkV0qEJxpX+YV
	Ky0IktHj45Is56Kia+t/o+iMcAdd7B0vmaom6Kk=
X-Google-Smtp-Source: AGHT+IGrNVIBe2BPS/FffT+/FZLhy1duokS4RUbj4ZYSgo+6/ME+WKqfIwPeJgaazC6hjd/emIAeqGklTt6LRXVEM8k=
X-Received: by 2002:a05:6000:4301:b0:432:8667:51c7 with SMTP id
 ffacd0b85a97d-432bca522demr2379580f8f.44.1767673265769; Mon, 05 Jan 2026
 20:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
 <CAEf4BzbCyMWr5tq5i45SB3jPvUFd4zOAYwJG3KBBeaoWmEq8kw@mail.gmail.com> <3389151.aeNJFYEL58@7940hx>
In-Reply-To: <3389151.aeNJFYEL58@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 20:20:54 -0800
X-Gm-Features: AQt7F2qISJSYqOQWH8CWZ2k3IT3E58T_18khV0bzCNj5zV0_W1jo093f_ClmF0Y
Message-ID: <CAADnVQ+EzgMEXAN9oJ8asRj_WYOZh2VQOKDJz8mhkqehr7f=3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:05=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2026/1/6 05:20 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > Hi, all.
> > >
> [......]
> > > Maybe it's possible to reuse the existing bpf_session_cookie() and
> > > bpf_session_is_return(). First, we move the nr_regs from stack to str=
uct
> > > bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the se=
ssion
> > > cookies as flexible array in bpf_tramp_run_ctx like this:
> > >     struct bpf_tramp_run_ctx {
> > >         struct bpf_run_ctx run_ctx;
> > >         u64 bpf_cookie;
> > >         struct bpf_run_ctx *saved_run_ctx;
> > >         u64 func_meta; /* nr_args, cookie_index, etc */
> > >         u64 fsession_cookies[];
> > >     };
> > >
> > > The problem of this approach is that we can't inlined the bpf helper
> > > anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, a=
s
> > > we can't use the "current" in BPF assembly.
> > >
> >
> > We can, as Alexei suggested on your other patch set. Is this still a
> > valid concern?
>
> Yeah, with the support of BPF_MOV64_PERCPU_REG, it's much easier
> now.
>
> So what approach should I use now? Change the prototype of
> bpf_session_is_return/bpf_session_cookie, as Alexei suggested, or
> use the approach here? I think both works, and I'm a little torn
> now. Any suggestions?

I think adding 'void *ctx' to existing kfuncs makes tramp-based
kfuncs faster, since less work needs to be done to store/read
the same data from run_ctx/current.
So that's my preference.

