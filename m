Return-Path: <bpf+bounces-59455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2F5ACBC61
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357DA164C76
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4C021C177;
	Mon,  2 Jun 2025 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMwwLhbJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A71993BD
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896683; cv=none; b=ZTZ2NSFFiuzP+BotroDu+d6lwCk4lHZgCJkh09b8ufey+MJ870Dbos5UFqLaDblEhLs6qtBkj3n1pVOlXH6vXPfjz7jO93aXpxmguItvzFi/pG4+5usq8G9vi3cazTM3GOFxojzG9uI33mt5Y/1rC99/gZfOwLpqgaZvfmQ7OV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896683; c=relaxed/simple;
	bh=v2AU7RGIqDjEhKrdtDnqgCshP3xzmFm20ZWoPQ9A3eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c46MVdyAszY0lCcMHhk6eQJjC0dRxh8r0EsSvdxITVDu5HYEROwWXnjnw935izT8/IstaSJrYTpNGjTXcSSeergfnQVCz98Fgni8JNxKKnP9kK9HCQ7Fl/eEGZTH3u0g5aESewzL0B7Tp9Ron7GBRL0vpdBE9b0tFgTa9KcxWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMwwLhbJ; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-54e816aeca6so6206511e87.2
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748896680; x=1749501480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOCqdVP61jZ/N9LWLn5BLtY5mar7Qj8UJNvpLNGaReQ=;
        b=gMwwLhbJJeMKVId1seeFGO1aUYsKngxdI7CcSnziXDFHNek+P+wDENz6Z3eZZl37Mf
         31PGVF8veEu1xhbw1TMU9DrJi+r5KsLoWkvzXDuvq/vbqZ4tXANKQ3lVB0rka8lgcMOt
         Ri4iEp90/1Yeso6ZqwZpVh8wmkX7t5OKyrHek8oODcnjjC5y4N/MQHyRac9t1Gf1mFgc
         TYEZMPl18pA44BH1X29nwsR3a3h3K6E/tLHkKreNMYJq8JAbHuTHScp3YdhCzmI5SBL/
         QtCH3h5Nv31zArwruAMWj5gUfcmI+WjQ3G3x3cyU2jn6DohA0tJ88PshtBgFW/LagQc5
         N9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896680; x=1749501480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOCqdVP61jZ/N9LWLn5BLtY5mar7Qj8UJNvpLNGaReQ=;
        b=PykZXMzc/U3yVl5hKVKkua3CSbNNCSb6Qwvi5jPhEdGtzuPJVXj+V6cDL70rNwbh+N
         qrFRmUndSbsZa5P6Noxs5mve9sy9wFSQ+KkabxIP/4E80Q3yhKr2PXM86nJ6RZdowCir
         wBxDfodl7WhzxjplkVwJ25zapelKGigloU6F0LeG1jYxlQ0K4LqSiE25hbQDuBT1u8Tb
         lgVo3qkaFqBwodasqg9Y3zuTjrIXkfIZZ6vDSUw1godqXMaUFv2yulFiTeWCAcCWUynj
         Ew0UwCBKeAzN8jDllFvULgSdNB2n7fV/IC6btCWgAldduUbLplznhmaHAeaHs+ElG3/V
         yx8Q==
X-Gm-Message-State: AOJu0YyZxA/7srozp98fQs/qwUxvA5S3v9hIheqAS6aXTefNXAx0kG+I
	s4ndjayiZPgEnKGByOVPUR2QOMO3hN74+W0PostOyTqLgvP2jEn0d4FMXY6/8wmheV4CM5DL0Bq
	AfiBRFza2K4CmP5CWRg4yxem5pSW5BZYUlfG6
X-Gm-Gg: ASbGnctIfi6ZSsWo+dE5a1U84XcPPjZfn4ZJ4EUv5pEAJLeZ0B0kL0r77iXpH2d779A
	pp6+WSuCEjJoGtEfCLZ3lC5XGF0mNJpX+6RuBJNN2n/CLgyAmq2GW4bo6q9bcZbwlyat5kh4u4q
	0ueRy5QBgVT/WjUyubtfXTrK+mJwI5z1MqgX+JuCUB08Gu0yPDAB0147fsStqLsEU7AmJxe56Jh
	eYjsMhJ+OyjCvRm
X-Google-Smtp-Source: AGHT+IHtxXqhaBcnhy0ri5NY0YKBxTzbyc1GpdV7/CHU+ia1l/nyOHgJbcM5tz3rAxbG+SdxQAOeH3i+4PqT2d/8I98=
X-Received: by 2002:a17:907:3cc9:b0:ad8:a115:d53f with SMTP id
 a640c23a62f3a-adb323054edmr1432511466b.40.1748896317208; Mon, 02 Jun 2025
 13:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-3-memxor@gmail.com>
 <CAADnVQ+M20Jn_+hkLuRTJJGZQSVvwZQd0q0RxBV-u7CpTf0Orw@mail.gmail.com>
 <CAP01T757V7+E6H7H10J4L_ULdDtB0T=BQa7==TXDyP_0WCn0QQ@mail.gmail.com> <CAADnVQ+Bh1FdhvjEo_STvYk3Ht6NVpid4H+QcOFnsy32iv8UBg@mail.gmail.com>
In-Reply-To: <CAADnVQ+Bh1FdhvjEo_STvYk3Ht6NVpid4H+QcOFnsy32iv8UBg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 2 Jun 2025 22:31:20 +0200
X-Gm-Features: AX0GCFt3dBDbRL1YN3SPfey_kysmigBFvmvIS99HucQpzARprtUmTE9yMCgjeMQ
Message-ID: <CAP01T74iNAZ0J1SNGu9LM1pAe=5U_Aws70BLjhfJjOmYVrHCJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: Add function to extract program
 source info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 at 22:25, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 2, 2025 at 1:21=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Mon, 2 Jun 2025 at 22:18, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, May 23, 2025 at 6:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > Prepare a function for use in future patches that can extract the f=
ile
> > > > info, line info, and the source line number for a given BPF program
> > > > provided it's program counter.
> > > >
> > > > Only the basename of the file path is provided, given it can be
> > > > excessively long in some cases.
> > > >
> > > > This will be used in later patches to print source info to the BPF
> > > > stream. The source line number is indicated by the return value, an=
d the
> > > > file and line info are provided through out parameters.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  include/linux/bpf.h |  2 ++
> > > >  kernel/bpf/core.c   | 49 +++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  2 files changed, 51 insertions(+)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index d298746f4dcc..4eb4f06f7219 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -3659,4 +3659,6 @@ static inline bool bpf_is_subprog(const struc=
t bpf_prog *prog)
> > > >         return prog->aux->func_idx !=3D 0;
> > > >  }
> > > >
> > > > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip=
, const char **filep, const char **linep);
> > > > +
> > > >  #endif /* _LINUX_BPF_H */
> > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > index 22c278c008ce..7e7fef095bca 100644
> > > > --- a/kernel/bpf/core.c
> > > > +++ b/kernel/bpf/core.c
> > > > @@ -3204,3 +3204,52 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
> > > >
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> > > > +
> > > > +#ifdef CONFIG_BPF_SYSCALL
> > > > +
> > > > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip=
, const char **filep, const char **linep)
> > > > +{
> > > > +       int idx =3D -1, insn_start, insn_end, len;
> > > > +       struct bpf_line_info *linfo;
> > > > +       void **jited_linfo;
> > > > +       struct btf *btf;
> > > > +
> > > > +       btf =3D prog->aux->btf;
> > > > +       linfo =3D prog->aux->linfo;
> > > > +       jited_linfo =3D prog->aux->jited_linfo;
> > > > +
> > > > +       if (!btf || !linfo || !prog->aux->jited_linfo)
> > > > +               return -EINVAL;
> > > > +       len =3D prog->aux->func ? prog->aux->func[prog->aux->func_i=
dx]->len : prog->len;
> > > > +
> > > > +       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
> > > > +       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_id=
x];
> > > > +
> > > > +       insn_start =3D linfo[0].insn_off;
> > > > +       insn_end =3D insn_start + len;
> > > > +
> > > > +       for (int i =3D 0; i < prog->aux->nr_linfo &&
> > > > +            linfo[i].insn_off >=3D insn_start && linfo[i].insn_off=
 < insn_end; i++) {
> > > > +               if (jited_linfo[i] >=3D (void *)ip)
> > > > +                       break;
> > > > +               idx =3D i;
> > > > +       }
> > > > +
> > > > +       if (idx =3D=3D -1)
> > > > +               return -ENOENT;
> > > > +
> > > > +       /* Get base component of the file path. */
> > > > +       *filep =3D btf_name_by_offset(btf, linfo[idx].file_name_off=
);
> > > > +       if (!*filep)
> > > > +               return -ENOENT;
> > > > +       *filep =3D kbasename(*filep);
> > > > +       /* Obtain the source line, and strip whitespace in prefix. =
*/
> > > > +       *linep =3D btf_name_by_offset(btf, linfo[idx].line_off);
> > > > +       if (!*linep)
> > > > +               return -ENOENT;
> > > > +       while (isspace(**linep))
> > > > +               *linep +=3D 1;
> > >
> > > The check_btf_line() in the verifier does:
> > >                 if (!btf_name_by_offset(btf, linfo[i].line_off) ||
> > >                     !btf_name_by_offset(btf, linfo[i].file_name_off))=
 {
> > >                         verbose(env, "Invalid line_info[%u].line_off
> > > or .file_name_off\n", i);
> > >                         err =3D -EINVAL;
> > >                         goto err_free;
> > >                 }
> > >
> > > and later in the verifier we do:
> > >         s =3D ltrim(btf_name_by_offset(btf, linfo->line_off));
> > >         verbose(env, "%s", s); /* source code line */
> > >
> > > so please drop these two checks.
> >
> > There was a kernel crash in CI when these NULL checks were missing.
>
> The math before is probably wrong then.
> idx is invalid ?
> This needs more debugging.

I will take a look.

