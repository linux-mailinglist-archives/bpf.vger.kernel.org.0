Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3874D313581
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhBHOqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 09:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhBHOp4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 09:45:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66071C06178B
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 06:45:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so25056590ejf.11
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A6rho50iXykT6j8QIC0uvQugU/HUMstd99hpxzKTABY=;
        b=Gy4QTQyWMy4kV8ONPbXNSZ+LVP0z6ITM+geJoUPVomKG28yaCaxQ4O7xatK9jb6Dbv
         6SNcBhJjnqQ2/moehj2OSGpxhtcAOSNjQWEPO0bZnF/VfLSu/kQ2io8VA09+W069MoJR
         PZfqGl6YFge3OBbX1Zoib4Eb81V5ODFt28CX45S3fiyM+b+zczyC5KbBfMPiQnI/IqNk
         geqTxVAVvAMFjJKZTDIBc3xflcDMahFkxdVILCvxUOCoDZnLeqbvBBjg+Tj6fqsv8euW
         8uyfDLhIaifiaa6eoZMTkwgldnjWCd5kTVsNx2OOPTzPEEDzCPl2vH3ekaXmVwYSQQlF
         ykFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A6rho50iXykT6j8QIC0uvQugU/HUMstd99hpxzKTABY=;
        b=Cun3Sy1Ha57dtKJDFjpIMao7xyDeUlwQpMmqchEMvl+v0/FgeYcmY+i1DjfrVW+5OF
         rUx2tlu+9a0oWo3ac/+L70qcsbZ+RN9kI8lSq5d5fomdeZ3Efr7r+AkCM24+9HIBrCNX
         Z1A+2Pd6WykoDmm65yKVJuZb+TKR/ZFVhaE1Be3c0wFAksRihDz97sWq2QBJHBrdQuSX
         tZLntMoucLSeSp3nLKd1al9Xst3Mz/ws4RizveU3n1qli//dT2qnXk5WnPV8jvFux2Re
         YZwRXpGsYGpkmWvAm/GjPpxvuHbc65rrpyVulsiwhIN6/SG8shZB9RdoSZ64AVoyskrh
         A5PA==
X-Gm-Message-State: AOAM533Fjxzl6IdWSzDDwVE1t2TAwd2E+/91qQ1bGUrOjMGzr8+ocTjQ
        uPXDj/QYujy74pmyo4S52jCxrv5rUYdylytTyYhQ+mNASPk=
X-Google-Smtp-Source: ABdhPJyxWJPdIWxDaxOEqA5oD8Ll+Vrojp/pMGGzVAaHm6Y3OOL3abeZNMMGmPonZU125ulCSdTZ1eRVd1rsLOuwz+8=
X-Received: by 2002:a17:906:296a:: with SMTP id x10mr17010533ejd.240.1612795515063;
 Mon, 08 Feb 2021 06:45:15 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk> <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk>
In-Reply-To: <87mtwetz04.fsf@toke.dk>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Mon, 8 Feb 2021 16:44:38 +0200
Message-ID: <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 4:28 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Gilad Reti <gilad.reti@gmail.com> writes:
>
> > On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Gilad Reti <gilad.reti@gmail.com> writes:
> >>
> >> > Also, is there a way to set the pin path to all maps/programs at onc=
e?
> >> > For example, bpf_object__pin_maps pins all maps at a specific path,
> >> > but as far as I was able to find there is no similar function to set
> >> > the pin path for all maps only (without pinning) so that at loading
> >> > time libbpf will try to reuse all maps. The only way to achieve a
> >> > complete reuse of all maps that I could find is to "reverse engineer=
"
> >> > libbpf's pin path generation algorithm (i.e. <path>/<map_name>) and
> >> > set the pin path on each map before load.
> >>
> >> You can set the 'pinning' attribute in the map definition - add
> >> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By default
> >> this will pin beneath /sys/fs/bpf, but you can customise that by setti=
ng
> >> the pin_root_path attribute in bpf_object_open_opts.
> >
> > Yes, I am familiar with that feature, but it has some downsides:
> > 1. I need to set it manually on every map (and in cases that I have
> > only the compiled object file that would be hard).
> > 2. It only works for bpf maps and not bpf programs.
> > 3. It only works for bpf maps that are defined explicitly in the bpf
> > code and not for implicit (inner) bpf maps (bss, rodata, etc).
>
> Ah, right. Well, other than that I don't think there's a way to set pin
> paths in bulk, other than by manually iterating and setting them one at
> a time. But, erm, can't you just do that? :)
>

Sure, I can, but I think we should avoid that. As I said this forces
the user to know libbpf's
pin path naming algorithm, which is not part of the libbpf api afaik.
I think that if we have
a method to pin all maps at a specific path there should also be a
method for reusing them
all from this path, either by exposing the function that builds the
pin path, or a function that
sets all the paths from a root path.

> -Toke
>
