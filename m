Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2596B510BF8
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiDZWZo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 18:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353524AbiDZWXp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 18:23:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642761E3C7
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 15:20:33 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e15so445971iob.3
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMcpPSbMWST7iNG5KwlXm/XmtRoIai9JVWoC9E+f4m0=;
        b=X86Ic762rFGS646dUQf09y8P/vemsWCvFVjz0eIkdOALbewVtt9Ik0M7Z/H93Y42Rm
         ca29Ms5CMfbVkzn1rKkoYweM9GlzIVjpJALahJ6tvqU3FnOO1d7p3TttwRtPElQnolFd
         n1OnT7mU4hPS3Hbd7+7NM0t2CEB/rH21Eh+1oaMUeqnIF0yVETDCPvc6nt0FXGF9T5cz
         8TaQuw+Wj7YwV5QLnl/+kGnDZa3KxiF4RNXx+nAXH/vjLjlOcGOjzwZEcEPwH0ZOLUhp
         FXgePYhkjpQurbTWXo5u4wWcH+wHWxtkshcRv5we+yCo4sZ7dZ3xLPbFsL1YWhrs114f
         ZjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMcpPSbMWST7iNG5KwlXm/XmtRoIai9JVWoC9E+f4m0=;
        b=Trd1Oj7Bm6Y7soOO7lQS9CdsY0pG7QalECIXa8hWFR+XQscqezwABTkhGbyzXu5q1I
         Sphy+w/20sFiFMALFH2oD3f8Or8rOZjjJRPTtZ/tUvF80DH8nPnYyZS1DkxQp1FN+GoR
         ZpyZUiZP0MPNQG+eK8RtyyKK/hrpXBRo/bzQIUjL4xBZZ3KlRcmZLHYmr6+NXiq57c0q
         R/QgpQf1tL4B2NTNFi+scUaZfFk1cARI8ewPFEck94ljvsW6LbIfGMZ8vJfhpIJV4agy
         hMwew7RbeGohJlPlpwpXAOrHWaEp+pj07NMDLh/9bMBb+aOUwxCuB3ioImLkauKdwJNZ
         AkEQ==
X-Gm-Message-State: AOAM530JP0cU4lxwf5dYvmuac4hatSeyog2/i2WReWZ6aZk+JFvzJXFe
        NTNIyozRQL01sL8dKurBw6Fv7pVKkLClmWyvyDs=
X-Google-Smtp-Source: ABdhPJzItwjYMGAhApupTohuDsynW8Jy6yxaZ5vYC7F70O+Zfj65esCn/2Cuv/M0207RrX3vrdQnPuciiiwsoUHWFXY=
X-Received: by 2002:a05:6638:2104:b0:326:1e94:efa6 with SMTP id
 n4-20020a056638210400b003261e94efa6mr11350500jaj.234.1651011632435; Tue, 26
 Apr 2022 15:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220426004511.2691730-1-andrii@kernel.org> <20220426004511.2691730-8-andrii@kernel.org>
 <20220426185248.ogbjc7f2rwfzhxqs@MacBook-Pro.local>
In-Reply-To: <20220426185248.ogbjc7f2rwfzhxqs@MacBook-Pro.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Apr 2022 15:20:21 -0700
Message-ID: <CAEf4BzaJEuuz8jUt_gZXys9AW0jZbGqQ64og88vwzB3gEBMquQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] libbpf: refactor CO-RE relo human
 description formatting routine
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 11:52 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 25, 2022 at 05:45:08PM -0700, Andrii Nakryiko wrote:
> > Refactor how CO-RE relocation is formatted. Now it dumps human-readable
> > representation, currently used by libbpf in either debug or error
> > message output during CO-RE relocation resolution process, into provided
> > buffer. This approach allows for better reuse of this functionality
> > outside of CO-RE relocation resolution, which we'll use in next patch
> > for providing better error message for BPF verifier rejecting BPF
> > program due to unguarded failed CO-RE relocation.
> >
> > It also gets rid of annoying "stitching" of libbpf_print() calls, which
> > was the only place where we did this.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/relo_core.c | 64 +++++++++++++++++++++++----------------
> >  1 file changed, 38 insertions(+), 26 deletions(-)
> >
> > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> > index adaa22160692..13d36a705464 100644
> > --- a/tools/lib/bpf/relo_core.c
> > +++ b/tools/lib/bpf/relo_core.c
> > @@ -1055,51 +1055,66 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
> >   * [<type-id>] (<type-name>) + <raw-spec> => <offset>@<spec>,
> >   * where <spec> is a C-syntax view of recorded field access, e.g.: x.a[3].b
> >   */
> > -static void bpf_core_dump_spec(const char *prog_name, int level, const struct bpf_core_spec *spec)
> > +static int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
> >  {
> >       const struct btf_type *t;
> >       const struct btf_enum *e;
> >       const char *s;
> >       __u32 type_id;
> > -     int i;
> > +     int i, len = 0;
> > +
> > +#define append_buf(fmt, args...)                             \
> > +     ({                                                      \
> > +             int r;                                          \
> > +             r = snprintf(buf, buf_sz, fmt, ##args);         \
> > +             len += r;                                       \
> > +             if (r >= buf_sz)                                \
>
> Do we need to check for r<0 here too or it's highly unlikely?

I decided not to, as this would just mean an implementation bug
(invalid % formatter used in format string), which hopefully will be
caught in testing. It felt a bit too defensive, but if you think it's
better to check, then we can just have if (r < 0) return r; right
after snprintf()?

>
> > +                     r = buf_sz;                             \
> > +             buf += r;                                       \
> > +             buf_sz -= r;                                    \
> > +     })
> >
> >       type_id = spec->root_type_id;
> >       t = btf_type_by_id(spec->btf, type_id);
> >       s = btf__name_by_offset(spec->btf, t->name_off);
> >
> > -     libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
> > +     append_buf("<%s> [%u] %s %s",
> > +                core_relo_kind_str(spec->relo_kind),
> > +                type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
> >
> >       if (core_relo_is_type_based(spec->relo_kind))
> > -             return;
> > +             return len;
> >
> >       if (core_relo_is_enumval_based(spec->relo_kind)) {
> >               t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
> >               e = btf_enum(t) + spec->raw_spec[0];
> >               s = btf__name_by_offset(spec->btf, e->name_off);
> >
> > -             libbpf_print(level, "::%s = %u", s, e->val);
> > -             return;
> > +             append_buf("::%s = %u", s, e->val);
> > +             return len;
> >       }
> >
> >       if (core_relo_is_field_based(spec->relo_kind)) {
> >               for (i = 0; i < spec->len; i++) {
> >                       if (spec->spec[i].name)
> > -                             libbpf_print(level, ".%s", spec->spec[i].name);
> > +                             append_buf(".%s", spec->spec[i].name);
> >                       else if (i > 0 || spec->spec[i].idx > 0)
> > -                             libbpf_print(level, "[%u]", spec->spec[i].idx);
> > +                             append_buf("[%u]", spec->spec[i].idx);
> >               }
> >
> > -             libbpf_print(level, " (");
> > +             append_buf(" (");
> >               for (i = 0; i < spec->raw_len; i++)
> > -                     libbpf_print(level, "%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
> > +                     append_buf("%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
> >
> >               if (spec->bit_offset % 8)
> > -                     libbpf_print(level, " @ offset %u.%u)",
> > -                                  spec->bit_offset / 8, spec->bit_offset % 8);
> > +                     append_buf(" @ offset %u.%u)", spec->bit_offset / 8, spec->bit_offset % 8);
> >               else
> > -                     libbpf_print(level, " @ offset %u)", spec->bit_offset / 8);
> > -             return;
> > +                     append_buf(" @ offset %u)", spec->bit_offset / 8);
> > +             return len;
> >       }
> > +
> > +     return len;
> > +#undef append_buf
> >  }
> >
> >  /*
> > @@ -1168,6 +1183,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
> >       const char *local_name;
> >       __u32 local_id;
> >       const char *spec_str;
> > +     char spec_buf[256];
> >       int i, j, err;
> >
> >       local_id = relo->type_id;
> > @@ -1190,10 +1206,8 @@ int bpf_core_calc_relo_insn(const char *prog_name,
> >               return -EINVAL;
> >       }
> >
> > -     pr_debug("prog '%s': relo #%d: kind <%s> (%d), spec is ", prog_name,
> > -              relo_idx, core_relo_kind_str(relo->kind), relo->kind);
> > -     bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, local_spec);
> > -     libbpf_print(LIBBPF_DEBUG, "\n");
> > +     bpf_core_format_spec(spec_buf, sizeof(spec_buf), local_spec);
> > +     pr_debug("prog '%s': relo #%d: %s\n", prog_name, relo_idx, spec_buf);
>
> Looks great, but return value 'len' doesn't seem to be used in this
> patch or in the following patch.
> What was the intent ?


Yeah, it's not used right now. I wanted to keep snprintf() semantics
where it returns what the length of output would be if we had big
enough buffer (I love that semantics in snprintf). But as it is right
now I just assume that the buffer is big enough and if not output will
be truncated (which is not a big deal in this case). It should be very
hard to fill up 256 characters with
some.struct.access.pattern.and.so.on :)

So it's a nice bonus behavior kept intentionally.
