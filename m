Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAAB3131A1
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 13:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhBHMBM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 07:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhBHL7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 06:59:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E40C06174A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 03:58:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bl23so24161637ejb.5
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LzqefVBsxlS9FvrWIXQWeKK6XX9u3vVW5wQL3trZcNQ=;
        b=gSxlRX/TOQaRETTRfg9s7ZdEvWb6Zlp+2glITouc6n2yjyMrLbPx+28iSxW9+LnPWA
         X8aC/Q7cuPm06aKhnFbUf4QdNldY5/4b1Ymgs7PdI4sMmfBz4IT+LtexPHaI3Eogop3b
         zVmU3smKDJwpkwiECivlU/hhtNhBrb7dssYpvZHiC0/3nOPv5l0iC9Wv4QiwzmvlLAN1
         IOPlkf41SjCr2z2pSnPtt4Yu5JV4vA8AXCuLnueOz249Y5EBaiEIOzYfWOvptpHGZnv2
         /tmoGIWkBk0v7OWi8JpG1ZOOaToiigDwEo6hG7U1y9kddYPblAjg3BbugwsBso2LqKha
         d+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LzqefVBsxlS9FvrWIXQWeKK6XX9u3vVW5wQL3trZcNQ=;
        b=ILPlpxElaLGPMZS0aSNKovImfjmcW3duNlbxbmwuvqrkYMnf7Ys3JHu6zS5x5yx0EF
         UpM3IG4JO+WBSqVdsNBFkZfNaOvIGN27CnvgL64aeZuH00pyO1LzsRdjZRm+yx2k+K6f
         sy+corR/luaJiDiWV4O4DJ7YDbURWG7QpCzzTeqBpEv+PIFWnsDkz7uTHJDEhf2Q3kYf
         fQWEOKhGa2iP5cYt+dfvejvKEmHOx+dxsM50IabHAJAyIa48B5QSigQOxOgu9AeaxHg5
         U6kn+u4s0h/yaEJtT/hHLACyeKSJwhFlcO0odS354YRQiVZeo+Q0edl5dVRna5KNSF1O
         0ZOg==
X-Gm-Message-State: AOAM533WcDws5+9CTv0TDxkWsonAGiPoBBEXvu2rdkWbvpV+nKfgmc0P
        wGsyhNerwI2gCJHN5A0s7CIWuqJWT1IIiPWXh+Q=
X-Google-Smtp-Source: ABdhPJyfB0+91Z0gCEwv+lgbNa/eqd1i0WobNP1y/2eU/ue6lQHCf/f7fswXvGPL5Dug8no0OzbWImJs/vUNi5ln7pw=
X-Received: by 2002:a17:907:3e06:: with SMTP id hp6mr16667339ejc.254.1612785508187;
 Mon, 08 Feb 2021 03:58:28 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com> <87v9b2u6pa.fsf@toke.dk>
In-Reply-To: <87v9b2u6pa.fsf@toke.dk>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Mon, 8 Feb 2021 13:57:52 +0200
Message-ID: <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Gilad Reti <gilad.reti@gmail.com> writes:
>
> > Also, is there a way to set the pin path to all maps/programs at once?
> > For example, bpf_object__pin_maps pins all maps at a specific path,
> > but as far as I was able to find there is no similar function to set
> > the pin path for all maps only (without pinning) so that at loading
> > time libbpf will try to reuse all maps. The only way to achieve a
> > complete reuse of all maps that I could find is to "reverse engineer"
> > libbpf's pin path generation algorithm (i.e. <path>/<map_name>) and
> > set the pin path on each map before load.
>
> You can set the 'pinning' attribute in the map definition - add
> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By default
> this will pin beneath /sys/fs/bpf, but you can customise that by setting
> the pin_root_path attribute in bpf_object_open_opts.

Yes, I am familiar with that feature, but it has some downsides:
1. I need to set it manually on every map (and in cases that I have
only the compiled object file that would be hard).
2. It only works for bpf maps and not bpf programs.
3. It only works for bpf maps that are defined explicitly in the bpf
code and not for implicit (inner) bpf maps (bss, rodata, etc).

>
> -Toke
>
