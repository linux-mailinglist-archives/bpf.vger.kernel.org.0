Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560344EA2B0
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiC1WQP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 18:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiC1WPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87102141454
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 15:12:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o13so13217477pgc.12
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MVn6/CGk0t4tXJ2stEzPJqGScoAONmSKX2QhcxJllHs=;
        b=Ez0sZ18vLtgaAAIogDoRIRP2FyKbBZ7onL7+R4Z7F/3Q8eIo09R0cvTkzvOfEp1/WC
         vLhdbtdsCJ6oWWbttxonTKGqsPLFlH6u8MjYmY0tnWWMmHz8x+BQYyf+q83QVNKPHIQo
         pMtppb55k4+0j/geQkBmrVbknxDqPyCXwer4Lv4vjWfKcWzH+fP0j5v+aG5B0GCLJ29n
         5SnJnc/UKpUzJb0ZzNaJbrtkWBKrAfFPeXDPowDBvF6UI2z6tLwpG6/elMfBVrezAJY9
         SNrB//1cBzqLmeydjULS1BNPRDuV+u7oHs0x0/833cchAla3bHiZN8gXw2HVezGsBxd+
         Lv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MVn6/CGk0t4tXJ2stEzPJqGScoAONmSKX2QhcxJllHs=;
        b=WMt6yaOw+vpY6LNl8UNetNK27UszvAVeIq5efY8R5rRKzmilwaTiyMBJkMAgGMiuFa
         KZms6kEqaL0a95TKJQ5rZsAEW3sqtv8SxD3ahvFnn91zqWae9j6RktGxqf4RXhgBHL//
         kDYzf8szirTpK2E3RTTzk1/RHcKc/mluGmbfDGfTSJBjSXbx+CUx+8jTUAdVZwqc7u5X
         XpEDNJ1FsiSsdqC/qzjpXv41f23Vhsci4QHi7kJh3LBPTrUbmjBw2Sqs/tWbAaYUD5FD
         Y6JCnM4PXFt0Q/DL5PPRiJK+GFhqn5IeD69UquKV9zYdPW7rIs8ZOsAJuU7LYGPxB1WU
         ZnSw==
X-Gm-Message-State: AOAM5308mlDTVIsYycR1RbP8qa7xYBf0tH1AnDz3cFMub1ek3B+nfeYP
        GFndisE64YqmyNrelTAn3rVYl2+ngplOXqSjIAbJhCIt
X-Google-Smtp-Source: ABdhPJx2o4TJO/2lhaN9cXB/URKTTcwzM5EsoQjYymZ9+9rVvFp/IpQOJ1kofuFbnYwuM7rudu2TMNRILoFt2AR0wZU=
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id
 g6-20020a05660203c600b0063dcac9bd35mr7486833iov.144.1648503574592; Mon, 28
 Mar 2022 14:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220309163112.24141-1-9erthalion6@gmail.com> <a9a2c8ba-ff17-eafe-5cf4-32e5ef19b656@isovalent.com>
 <20220326090834.f7ukfgjyfhk6sbws@erthalion.local> <6b558a11-7f5e-8a4e-b70b-e4c7d3c3e052@isovalent.com>
In-Reply-To: <6b558a11-7f5e-8a4e-b70b-e4c7d3c3e052@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Mar 2022 14:39:23 -0700
Message-ID: <CAEf4Bzb=YNCBT5rLoXoYwc_gkSW6ZUhd66CP3RHO2dp462mHnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Dmitry Dolgov <9erthalion6@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 27, 2022 at 3:03 PM Quentin Monnet <quentin@isovalent.com> wrot=
e:
>
> 2022-03-26 10:08 UTC+0100 ~ Dmitry Dolgov <9erthalion6@gmail.com>
> >> On Sat, Mar 26, 2022 at 01:38:36AM +0000, Quentin Monnet wrote:
> >> 2022-03-09 17:31 UTC+0100 ~ Dmitrii Dolgov <9erthalion6@gmail.com>
> >>> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie =
for
> >>> BPF perf links") introduced the concept of user specified bpf_cookie,
> >>> which could be accessed by BPF programs using bpf_get_attach_cookie()=
.
> >>> For troubleshooting purposes it is convenient to expose bpf_cookie vi=
a
> >>> bpftool as well, so there is no need to meddle with the target BPF
> >>> program itself.
> >>>
> >>> [...]
> >>>
> >>> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> >>> index 7c384d10e95f..bb6c969a114a 100644
> >>> --- a/tools/bpf/bpftool/pids.c
> >>> +++ b/tools/bpf/bpftool/pids.c
> >>> @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid=
_iter_entry *e)
> >>>     ref->pid =3D e->pid;
> >>>     memcpy(ref->comm, e->comm, sizeof(ref->comm));
> >>>     refs->ref_cnt =3D 1;
> >>> +   refs->has_bpf_cookie =3D e->has_bpf_cookie;
> >>> +   refs->bpf_cookie =3D e->bpf_cookie;
> >>>
> >>>     err =3D hashmap__append(map, u32_as_hash_field(e->id), refs);
> >>>     if (err)
> >>> @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u3=
2 id,
> >>>             if (refs->ref_cnt =3D=3D 0)
> >>>                     break;
> >>>
> >>> +           if (refs->has_bpf_cookie)
> >>> +                   jsonw_lluint_field(json_writer, "bpf_cookie", ref=
s->bpf_cookie);
> >>> +
> >>
> >> Thinking again about this patch, shouldn't the JSON output for the
> >> cookie(s) be an array if we expect to have several cookies for
> >> multi-attach links in the future?
> >
> > Interesting point. My impression is that this could be done together
> > with the other changes about making multi-attach links possible (I
> > didn't miss anything, it's not yet implemented, right?). On the other
> > hand I'm planning to prepare few more patches in similar direction -- s=
o
> > if everyone agrees it has to be extended to an array now, I can tackle
> > this as well.
>
> Correct, it's not implemented yet for multi-attach links. My concern
> here is to avoid changing the JSON structure in the future (to avoid
> breaking changes for tools that would process the JSON). If we know
> we're likely to have several cookies in the future, it may be worth
> using an array =E2=80=9Cfrom start=E2=80=9D (since no version has been ta=
gged yet after
> you added support for the cookie).

The problem with multi-cookie links (like KPROBE_MULTI that was merged
a week ago) is that cookies by themselves are not that helpful. Also,
internally we change their order to be sorted according to resolved
kernel function addresses. So just an array of cookies are not enough,
but asking kernel to preserve all the addresses just for the sake of
reporting them in bpftool seems to much.

So in general, with multi-cookie links, it's not clear what you should
report at all.

>
> Quentin
