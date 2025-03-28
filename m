Return-Path: <bpf+bounces-54880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21330A75277
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 23:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C653AFF6D
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95011EC012;
	Fri, 28 Mar 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f80wfZ2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE51922D4
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743200660; cv=none; b=ngw3GRkFlCzF9BW5X1N+JyarMXK5P/UNfv8jYhOEF0xR9LWPVEN9xF1XVx15njF3HVgFxh7j6iZq+2UfqCkBSIcUXvLMVoPPBSnumSMuHTU6u7IRgmjiXLLxOfZun5Uk2hNCVl8aYjjGlmfGI5EZAC7hb20HhfxoeAA9miLcHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743200660; c=relaxed/simple;
	bh=MQOunwfsxlubp5ULYTuzy0epAj4AKIlCCB1x3L3m72k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM1aVBnYO/oWPhZY3PpOhQFoyOVS//edpJjlpWeWiFYwTJ5cRxFsGpxwfVpVRTm8/9xvzExMQm4k2giJNxg5CXLSk5Tl3ZyQAZxnY7hVa2SoUNl9YerB1wZ1s6cSVovA5g5a4cj+yll+mqYNVsfpEaC3loiKFY7pQJ5kLeLgxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f80wfZ2q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe574976so19240195e9.1
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743200657; x=1743805457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypp+8UeuQ9LB9jmXFvraF3DoM7x+JsPEJXu81HBten4=;
        b=f80wfZ2qaa0UFVt92U1814LLgczqmLLSK0NkYelMSJvb8JbSciS3VHPyjOdrFkmTFt
         dtyvevoGs1LOXhl11vX7avoxJrwkuB1LzffvYYP7oS05YSiVT4nxdqSkOGJZ4sa7FIn6
         Yw2+h9ar8czUCyDHrceWwmj+Mj0euUr8gtUshrOxFGHjkvmbSFqT749PtPfyk1+b5zje
         EYn8Nt3n6VEpn9CD6QoCVPLka/eHNCZynzMF1LhnZc6F+3IfaMNY6VCXNNU/s2eE0NfX
         ypqMejjr5Qtinbm22OFB1T69vUenymF2mqFOGumYDd0kRoVfe/rozy+PDCaa+7ozAtRw
         Ax4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743200657; x=1743805457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ypp+8UeuQ9LB9jmXFvraF3DoM7x+JsPEJXu81HBten4=;
        b=aLRD224DVEXWaii7d75E7JhEvPq8h+UobmhyrdIMXhJJ06I6030QZmNgzEhGA6n18A
         gZYvQRCzyucF63L2vsI/as0No5WNQLsH0HMdQQHg5RDwWj70+MsE5d6Y4nn6V1OlE8o9
         7VNrrVBqb/KpxAWDDQQsHbxKCJljlDFhE6s/vNC5PCQpOukRWfOqQBtprP/L+KNWf1pR
         aaXAqeW+9L9a6/FaJwenimNpOTT/BrCzBKqBRgzBPFtSC4PR7yUFXa6hyLOIfl+EjkQW
         7ZOxS9/4X0jTsUgIuA0SYH4mmLB9EAcvOCjWbDvTy8+cVf7P4DgUpQ78KgVWwfxq1IkG
         kOTA==
X-Forwarded-Encrypted: i=1; AJvYcCWDiiQxnVeMKdtBP3xbjKvBbuGVJxChBPRS4cbMMFJy7OHcJISVNajOYUYtl/bwzIYSzUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIP22esqk+Rn7k7uqF53U5FtZ6kxA5IPNLtnKiAKbjCZB+FIr
	rjKEurSu3zvPgpipaiawxaBYY0zoZFukamMztGczZph+j2iRJuIlrB/wrudbE067b8vCv3EZiKe
	juikqo7nEowNu3SKl+6it0gcY594=
X-Gm-Gg: ASbGncux3Y4qA+oSum2217Yjv7BXWw+DicBLIEULEjwRAcumkOdEbh9WSEL/s//lp58
	c4tN+jSpsNjEiBvzHbYehEW+joXbtuCWReuEl9lThZi4M/lNPIfTEUROH2UX9Ytj0gny7j+WUcp
	5zWbn3W+2gmBRC9Nflv6A/QhxhlAZ1WWS8eDN2f2fWug==
X-Google-Smtp-Source: AGHT+IGons9V/usvdVYCTE2rlXKioPxpw0E0rqNpKiHbZ6rtjwhu5CHaI2VBmFoR2wrwqt06plekBl0f/NUsM6RM81E=
X-Received: by 2002:a05:600c:1e88:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-43db61d050amr12560495e9.12.1743200656687; Fri, 28 Mar 2025
 15:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com>
 <196c2eb9-aca9-4533-b927-255569154a73@gmail.com> <CAEf4BzYBWGHT56b5QAN9VD2viVpgLWTH-SXosPqYjqvfbLpqCg@mail.gmail.com>
 <fe7db355-f363-46dc-95d4-9fbc39d5d925@gmail.com>
In-Reply-To: <fe7db355-f363-46dc-95d4-9fbc39d5d925@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Mar 2025 15:24:05 -0700
X-Gm-Features: AQ5f1JpKp6OC3wODH9JHORui2_EkIh-pJPJzjlGaS-ZHdnlM3k0rR-NCNzgMfw4
Message-ID: <CAADnVQJz8viY+EOaPBHemX1r_AVBVHT2R+V6jnyoZ_G31U0p4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line info
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 1:54=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 28/03/2025 20:52, Andrii Nakryiko wrote:
> > On Fri, Mar 28, 2025 at 12:16=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> On 28/03/2025 17:14, Andrii Nakryiko wrote:
> >>> On Wed, Mar 26, 2025 at 11:07=E2=80=AFAM Mykyta Yatsenko
> >>> <mykyta.yatsenko5@gmail.com> wrote:
> >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>>> Introducing new libbpf API getters for BTF.ext func and line info,
> >>>> namely:
> >>>>     bpf_program__func_info
> >>>>     bpf_program__func_info_cnt
> >>>>     bpf_program__func_info_rec_size
> >>>>     bpf_program__line_info
> >>>>     bpf_program__line_info_cnt
> >>>>     bpf_program__line_info_rec_size
> >>>>
> >>>> This change enables scenarios, when user needs to load bpf_program
> >>>> directly using `bpf_prog_load`, instead of higher-level
> >>>> `bpf_object__load`. Line and func info are required for checking BTF
> >>>> info in verifier; verification may fail without these fields if, for
> >>>> example, program calls `bpf_obj_new`.
> >>>>
> >>> Really, bpf_obj_new() needs func_info/line_info? Can you point where
> >>> in the verifier we check this, curious why we do that.
> >> Indirectly, yes:
> >> in verifier.c function check_btf_info_early sets
> >> `env->prog->aux->btf =3D btf;`
> >> only if line_info_cnt or func_info_cnt are non zero.
> >> and then there is a check that errors out:
> >> `verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");`
> >> perhaps this can be improved as well, by setting aux->btf even if no
> >> func info and line info
> > lol, doesn't seem intentional (just in the early days prog BTF was
> > only referenced and used with func_info/line_info, which isn't true
> > anymore), we can probably swap the order and load and remember prog
> > BTF regardless of func_info/line_info. Feel free to send a patch.
> Sure, I'll do it.

No. It's intentional.

The prog must contain func and line info for good debuggability.

