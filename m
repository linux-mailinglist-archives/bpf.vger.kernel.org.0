Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866B34070C4
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhIJSGk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhIJSGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 14:06:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE3C061574
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:05:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z18so5561003ybg.8
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpEvTwk7W5jjF89Vh7HIRrcr61DUBrgOBwrKVDGsXrA=;
        b=mwfn5/OShCmWuSSUKJ6ZZzKLXmGFtGmfkpkMsLnbnQfqSOeVoR42aWg73UdLncpem5
         hydhHahZPM50HdZsbbWFRTbSQrfSKiStdOLo9TAEPiMP2111rw38+hsAeoIGi20QhBkT
         vQN6Ptn4T/N+cNXGx1oMh6ss/xf+5rzW5BPf7BzmXUkf2uJa2RsQnn1nnhKDjWiuBmcy
         4hVC/69cFTU7lX8ukbV94c3pd/mEpove1slTiBm08FzrFA3/kW5f8kCqNnu4ENNSDUh9
         PnKov1UHrUnGzVjU/jr7XJQdWpgNrcRKFyCELGVyT4jUyjRt0Dwii0S4OEXoIFYjVVnd
         h8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpEvTwk7W5jjF89Vh7HIRrcr61DUBrgOBwrKVDGsXrA=;
        b=jmg1P2wzdNTTVIHGN4XHzHB/2GeZD9bnI4Lj1TcddFFWY/YvtX8D2caGqA5pc/nt+F
         Lu0LFjNec2wUIas13V9oFEH4zhezcXANXDQiSMJnPEbd7k+zztEqNdohOtLFhBaVyWP2
         TCyB05UKIqtRHtT+w5sqlthq6KzWKUCuIMImTSWXl9nwkBBOxeXJOszDc4sUI5sTxJ21
         /gEZXQTwrk2Jz+9TKXfyMjfcQl4hkiujaJoHM1phGsbMj14YiSNJe60cNhvinq1EiEbd
         JdOZ1y9u3ebLVELan5vcPXHKuIKNB/M9vwVaFdBFNgqk4lluhjssHvZHB9i8eZgSaUw0
         dLqg==
X-Gm-Message-State: AOAM532rwbhu+DeBp4JkX6BQWvYt84EQVIgpTEEtMG7W6UisM34ZKMVW
        laZFz52kEzsI1vlV+7eKZqexsa3+LL+lJfPJloE=
X-Google-Smtp-Source: ABdhPJy7Hmp+5chvvaZxnBsBxWN+JGHe3JVJuCT+9IP+lcZ9LkY0UzTFTECtNRBliw4/hjTl27Kh1PQPoQYGKP5cpRc=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr12390617ybi.369.1631297123665;
 Fri, 10 Sep 2021 11:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230111.1959279-1-yhs@fb.com>
 <CAEf4BzZ6eX5GbV4o+4vz2whXyOQd+5_AaVEYn+uvR5=sV=aWZw@mail.gmail.com>
 <CAEf4Bza5SodxX+tU1jtjoAJW-4nZ7WvDA-7wVbTca7s8AkexFg@mail.gmail.com> <5fef8e8c-4881-7973-4a4d-676fc22fdae3@fb.com>
In-Reply-To: <5fef8e8c-4881-7973-4a4d-676fc22fdae3@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Sep 2021 11:05:12 -0700
Message-ID: <CAEf4BzZjkL2GCG6gNBNkLQGRApO+v_3zGoy3b7zQUDFwaJRKjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] bpftool: add support for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 9:39 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/8/21 10:33 PM, Andrii Nakryiko wrote:
> > On Wed, Sep 8, 2021 at 10:28 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>> added bpftool support to dump BTF_KIND_TAG information.
> >>> The new bpftool will be used in later patches to dump
> >>> btf in the test bpf program object file.
> >>>
> >
> > What should be done for `bpftool btf dump file <path> format c` if BTF
> > contains btf_tag? Should it ignore it silently? Should it error out?
> > Or should we corrupt output (as will be the case right now, I think)?
>
> Currently it is silently ignored. The attribute information is mostly
> used in the kernel by verification purpose and the kernel uses its own
> btf to check.
>
> Adding such attributes to vmlinux.h, bpf program BTF will contain these
> attributes but they may not be used by the kernel verifier at least
> for now.
>
> So I think we can delay this as a followup if there is a real need.

Sounds good. Just wanted to confirm that we won't get some libbpf
warning emitted inside vmlinux.h, making it non-compilable.

>
> >
> >>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>> ---
> >>>   tools/bpf/bpftool/btf.c | 18 ++++++++++++++++++
> >>>   1 file changed, 18 insertions(+)
> >>>
> >>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> >>> index f7e5ff3586c9..89c17ea62d8e 100644
> >>> --- a/tools/bpf/bpftool/btf.c
> >>> +++ b/tools/bpf/bpftool/btf.c
> >>> @@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
> >>>          [BTF_KIND_VAR]          = "VAR",
> >>>          [BTF_KIND_DATASEC]      = "DATASEC",
> >>>          [BTF_KIND_FLOAT]        = "FLOAT",
> >>> +       [BTF_KIND_TAG]          = "TAG",
> >>>   };
> >>>
> >>>   struct btf_attach_table {
> >>> @@ -347,6 +348,23 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
> >>>                          printf(" size=%u", t->size);
> >>>                  break;
> >>>          }
> >>> +       case BTF_KIND_TAG: {
> >>> +               const struct btf_tag *tag = (const void *)(t + 1);
> >>> +
> >>> +
> >>
> >> extra empty line?
> >>
> >>> +               if (json_output) {
> >>> +                       jsonw_uint_field(w, "type_id", t->type);
> >>> +                       if (btf_kflag(t))
> >>> +                               jsonw_int_field(w, "comp_id", -1);
> >>> +                       else
> >>> +                               jsonw_uint_field(w, "comp_id", tag->comp_id);
> >>> +               } else if (btf_kflag(t)) {
> >>> +                       printf(" type_id=%u, comp_id=-1", t->type);
> >>> +               } else {
> >>> +                       printf(" type_id=%u, comp_id=%u", t->type, tag->comp_id);
> >>> +               }
> >>
> >> here not using kflag would be more natural as well ;)
> >>
> >>> +               break;
> >>> +       }
> >>>          default:
> >>>                  break;
> >>>          }
> >>> --
> >>> 2.30.2
> >>>
