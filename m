Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A70397DA4
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 02:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhFBAYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 20:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBAYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 20:24:46 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427FEC061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 17:23:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d9so676162ioo.2
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ODO61LLsqMtZRUAwJSLj8afU816yOddIp0bZXjF8/+A=;
        b=VQVM71WnAU+VZ4kP6Yv3ybgaexOyEZ0jLqhdc8BKKqfvI9L0Fq4mg0aX8BNR6XrGCV
         /d3scY/enCAGm/G5O2J0i9WOOcKm1WoPuKmwPwoSq4i6mEPzLmVQeRbdWFNOCuYXJpBR
         QcmDQcJ/wK2cgrF1HQZchbpypsfmDKcMn3JokoWl63fP7sLqEj6GOjbVevRjf5vhVaHk
         +zhP4MP57Rk3f41OXuaba6D4WyMKPV7WP0+14LLen0UgJj8mphsdZi+eAFusD4foS/FM
         hJEKMXcKcZskOLGbKuUfB5j1amNuApBrDBG5KZsyhgRm6gq5UkaUab9xkWjuIMgcEqiN
         jRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ODO61LLsqMtZRUAwJSLj8afU816yOddIp0bZXjF8/+A=;
        b=gI78qFX0jcj7NNDqWAQUIdmKxE088CI5J6so4Bi9m4pI/oSnPLjuNX9HTEVv5e1dpB
         +2hgOoeJifCqAGlSs59wl+d3lemOaQz6ZHyuHIJBnElZeMHbsd1fvFT66FoVaOdWGc88
         0LeDksDZbrooMxjGHM6CHlpfmEyphd5bI2bKuG1XF6wpE4jCGxL5VGRL4cMmAd+3weBQ
         VK2XnOaSj9QQXTkxETP2UC3YyJtgv9VdHwG106jh361ZLduBgUpWgp14+929TRNl30D2
         qKgwmmRJp1s6UOQQKmhhr7Wg6RY6sJJAPmbfvGWB2a0KpZ7B4lIYoBiFQOjeC5sMvpe8
         bRUg==
X-Gm-Message-State: AOAM530mI6ulnkmmLa7gQ85sN/zXYpRbDi39dPvr77N3tDcqxQiOATvm
        w9lWNxZug4vKxfuCvbaLA2Y=
X-Google-Smtp-Source: ABdhPJzUlPQgYjXKLsVPpI9IPMbLW0J1tOot2sSjS0zb6wlh/YB+ZQaA6oAPImxyNgGOPp3QBVfNDA==
X-Received: by 2002:a02:a81a:: with SMTP id f26mr28037173jaj.110.1622593382469;
        Tue, 01 Jun 2021 17:23:02 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id a7sm10946773ilt.2.2021.06.01.17.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 17:23:01 -0700 (PDT)
Date:   Tue, 01 Jun 2021 17:22:51 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Message-ID: <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
In-Reply-To: <8735u3dv2l.fsf@toke.dk>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
 <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> John Fastabend <john.fastabend@gmail.com> writes:
> =

> > Jesper Dangaard Brouer wrote:
> >
> > [...]
> >
> > I'll try to respond to both Toke and Jesper here and make it coherent=
 so
> > we don't split this thread yet again.
> >
> > Wish me luck.
> >
> > @Toke "react" -> "not break" hopefully gives you my opinion on this.
> >
> > @Toke "five fields gives 32 different metadata formats" OK let me tak=
e
> > five fields,
> >
> >  struct meta {
> >    __u32 f1;
> >    __u32 f2;
> >    __u32 f3;
> >    __u32 f4;
> >    __u32 f5;
> >  }
> >
> > I'm still confused why the meta data would change just because the fe=
ature
> > is enabled or disabled. I've written drivers before and I don't want =
to
> > move around where I write f1 based on some combination of features f2=
,f3,f4,f5
> > state of enabled/disabled. If features are mutual exclusive I can bui=
ld a
> > sensible union. If its possible for all fields to enabled then I just=
 lay
> > them out like above.
> =

> The assumption that the layout would be changing as the features were
> enabled came from a discussion I had with Jesper where he pointed out
> that zeroing out the fields that were not active comes with a measurabl=
e
> performance impact. So changing the struct layout to only include the
> fields that are currently used is a way to make sure we don't hurt
> performance.
> =

> If I'm understanding you correctly, what you propose instead is that we=

> just keep the struct layout the same and only write the data that we
> have, leaving the other fields as uninitialised (so essentially
> garbage), right?

Correct.

> =

> If we do this, the BPF program obviously needs to know which fields are=

> valid and which are not. AFAICT you're proposing that this should be
> done out-of-band (i.e., by the system administrator manually ensuring
> BPF program config fits system config)? I think there are a couple of
> problems with this:
> =

> - It requires the system admin to coordinate device config with all of
>   their installed XDP applications. This is error-prone, especially as
>   the number of applications grows (say if different containers have
>   different XDP programs installed on their virtual devices).

A complete "system" will need to be choerent. If I forward into a veth
device the orchestration component needs to ensure program sending
bits there is using the same format the program installed there expects.

If I tailcall/fentry into another program that program the callee and
caller need to agree on the metadata protocol.

I don't see any way around this. Someone has to manage the network.

> =

> - It has synchronisation issues. Say I have an XDP program with optiona=
l
>   support for hardware timestamps and a software fallback. It gets
>   installed in software fallback mode; then the admin has to make sure
>   to enable the hardware timestamps before switching the application
>   into the mode where it will read that metadata field (and the opposit=
e
>   order when disabling the hardware mode).

If you want tell the hardware to use an enable bit then check it on
ingress to the XDP program. What I like about this scheme is as a core
kernel or networking person I don't have to care how you do this. Figure
it out with your hardware and driver.

> =

> Also, we need to be able to deal with different metadata layouts on
> different packets in the same program. Consider the XDP program running=

> on a veth device inside a container above: if this gets packets
> redirected into it from different NICs with different layouts, it needs=

> to be able to figure out which packet came from where.

Again I don't think this is the kernel problem. If you have some setup
where NICs have different metadata then you need a XDP shim to rewrite
metadata. But, as the person who setup this system maybe you should
avoid this for the fast path at least.

> =

> With this in mind I think we have to encode the metadata format into th=
e
> packet metadata itself somehow. This could just be a matter of includin=
g
> the BTF ID as part of the struct itself, so that your example could
> essentially do:
> =

>   if (data->meta_btf_id =3D=3D timestamp_id) {
>     struct timestamp_meta *meta =3D data->meta_data;
>     // do stuff
>   } else {
>     struct normal_meta *meta =3D data->meta_data;
>   }

I'm not sure why you call it meta_btf_id there? Why not just
enabledTstampBit. so


  if (mymeta->enabledTstampBit) { ...} else { //fallback }

> =

> =

> and then, to avoid drivers having to define different layouts we could
> essentially have the two metadata structs be:
> =

>  struct normal_meta {
>   u32 rxhash;
>   u32 padding;
>   u8 vlan;
>  };
> =

> and
> =

>  struct timestamp_meta {
>    u32 rxhash;
>    u32 timestamp;
>    u8 vlan;
>  };

So a union on that u32 with padding and timestamp would suffice but
sure if you want to do it at compile time with btf_id ok. I think
runtime would make more sense. Like this,

 struct meta {
   u32 rxhash;
   u32 timestamp;
    u8 vlan;
    u8 flags;
 }

 if (m->flags) { read timestamp}

> =

> This still gets us exponential growth in the number of metadata structs=
,
> but at least we could create tooling to auto-generate the BTF for the
> variants so the complexity is reduced to just consuming a lot of BTF
> IDs.

auto-generate the BTF? I'm not sure why its needed to be honest. I think
for most simple things you can build a single metadata struct that
will fit. For more complex pipeline updates then we should generate
the BTF with the pipeline using P4 or such IMO.

> =

> Alternatively we could have an explicit bitmap of valid fields, like:
> =

>  struct all_meta {
>    u32 _valid_field_bitmap;
>    u32 rxhash;
>    u32 timestamp;
>    u8 vlan;
>  };

Aha I like this as you can tell from above. Would have just jumped
here but was responding as I was reading. So I think I'll leave above
maybe it is illustrative.

> =

> and if a program reads all_meta->timestamp CO-RE could transparently
> insert a check of the relevant field in the bitmap first. My immediate
> feeling is that this last solution would be nicer: We'd still need to

+1 I think we agree.

> include the packet BTF ID in the packet data to deal with case where
> packets are coming from different interfaces, but we'd avoid having lot=
s
> of different variants with separate BTF IDs. I'm not sure what it would=

> take to teach CO-RE to support such a scheme, though...
> =

> WDYT?

I think we agree to the last option (bitmap field) to start with build
that out I think you cover most hardware that is out today. Then
the more complex cases come as step2. And I think its hard to
understate that the last step above mostly works today, you don't need
to go do a bunch of kernel work.

> =

> -Toke
> =



