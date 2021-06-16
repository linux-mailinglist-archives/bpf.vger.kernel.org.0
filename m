Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345743AA183
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFPQks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 12:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhFPQkr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 12:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623861520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rV563dQo7m5y1S0K2xW4WWnPeVAJwFzr/pJdFlp2kRg=;
        b=WAI6+mFpqaqRRGh+Xq326w1gBzDYDnd68wxLoLNMQ4ihnh8OgaeB4XSnde84OdGg+8YiHj
        idwqVkRqlOVB7f68wsPo1guk5708m1IgykiUBUKGiOAy/JmPBWpjuc+QfCoYGmw0Gh1T02
        6bPO7nBcLc37MivBKvvlX9/5HcjCQW4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-NU9b3Ba4MNW6NeL3pywfKw-1; Wed, 16 Jun 2021 12:38:39 -0400
X-MC-Unique: NU9b3Ba4MNW6NeL3pywfKw-1
Received: by mail-ed1-f70.google.com with SMTP id v12-20020aa7dbcc0000b029038fc8e57037so32850edt.0
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 09:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rV563dQo7m5y1S0K2xW4WWnPeVAJwFzr/pJdFlp2kRg=;
        b=qntLtRLQvOB7WTeCQTCZsNteRJ52sxj0aVZw3yu6Vu0NryMP+BSAkfzbdBLBJXo3hO
         45IwOVw2J4Kz9WoRCxUNpRohCTVilAnQI/QGxCn0sOieJYxwy7P3fcG4JqyHqZy+oZ01
         n+Xp9cT8dKaQgG7H/UyoJFl83H5yX32Pzz4QWjM03gcPq+ayryx+2fnlpUVV+mcT1iP3
         u5k1AsTPDHakm00oBUSv3GJqifFlqxLlTpiIRKRVGz3fez9yrdpLTh6XuNTaGFMZ6YwA
         kNMpERiIJqn4C1Twv0mW3/z7OsmuKwVefrgpL7VTZ0H3nHliM9ivYYeP7Uq5sAXnLQNq
         upRQ==
X-Gm-Message-State: AOAM5309VMgbKCxyr9wA2C+NGS6gnFwhM0B3kqN6SfOG+9UribWsUcmj
        D5YIStAT/ItY9ut7PIPboDnM1ub0kwl/tfzEK/h5N6H+MItpFvczYzC7PZ11DjQiRWHK3zWZIAI
        4UtKKcGo8lag/
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr426409ejc.478.1623861518438;
        Wed, 16 Jun 2021 09:38:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxStRsLIlP9rxp/QI8AhSgSGsGy+DTj5KjZFu8fPauNQTeUOAENsFL+oSLy1pNIyZGWb3g6w==
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr426379ejc.478.1623861518209;
        Wed, 16 Jun 2021 09:38:38 -0700 (PDT)
Received: from krava ([83.240.60.126])
        by smtp.gmail.com with ESMTPSA id r29sm2424547edc.52.2021.06.16.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:38:35 -0700 (PDT)
Date:   Wed, 16 Jun 2021 18:38:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Tony Ambardar <tony.ambardar@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Frank Eigler <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH bpf v1] bpf: fix libelf endian handling in resolv_btfids
Message-ID: <YMopCb5CqOYsl6HR@krava>
References: <20210616092521.800788-1-Tony.Ambardar@gmail.com>
 <caf1dcbd-7a07-993c-e940-1b2689985c5a@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf1dcbd-7a07-993c-e940-1b2689985c5a@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 08:56:42AM -0700, Yonghong Song wrote:
> 
> 
> On 6/16/21 2:25 AM, Tony Ambardar wrote:
> > While patching the .BTF_ids section in vmlinux, resolve_btfids writes type
> > ids using host-native endianness, and relies on libelf for any required
> > translation when finally updating vmlinux. However, the default type of the
> > .BTF_ids section content is ELF_T_BYTE (i.e. unsigned char), and undergoes
> > no translation. This results in incorrect patched values if cross-compiling
> > to non-native endianness, and can manifest as kernel Oops and test failures
> > which are difficult to debug.

nice catch, great libelf can do that ;-)

> > 
> > Explicitly set the type of patched data to ELF_T_WORD, allowing libelf to
> > transparently handle the endian conversions.
> > 
> > Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in ELF object")
> > Cc: stable@vger.kernel.org # v5.10+
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Link: https://lore.kernel.org/bpf/CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com/
> > Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> > ---
> >   tools/bpf/resolve_btfids/main.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index d636643ddd35..f32c059fbfb4 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -649,6 +649,9 @@ static int symbols_patch(struct object *obj)
> >   	if (sets_patch(obj))
> >   		return -1;
> > +	/* Set type to ensure endian translation occurs. */
> > +	obj->efile.idlist->d_type = ELF_T_WORD;
> 
> The change makes sense to me as .BTF_ids contains just a list of
> u32's.
> 
> Jiri, could you double check on this?

the comment in ELF_T_WORD declaration suggests the size depends on
elf's class?

  ELF_T_WORD,                   /* Elf32_Word, Elf64_Word, ... */

data in .BTF_ids section are allways u32

I have no idea how is this handled in libelf (perhaps it's ok),
but just that comment above suggests it could be also 64 bits,
cc-ing Frank and Mark for more insight

thanks,
jirka

> 
> > +
> >   	elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
> >   	err = elf_update(obj->efile.elf, ELF_C_WRITE);
> > 
> 

