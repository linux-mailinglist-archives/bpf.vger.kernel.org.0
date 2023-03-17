Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B76BEEB5
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 17:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCQQo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQQo1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 12:44:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795247DB6
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:44:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so22731344ede.8
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679071463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6TgRTi2KerRDtN5G1ixrB17oe7PQy1zG9VGDzld3dc=;
        b=S6WeGgQ/bga+n7LtgVoiitSkZd11tQbPkXk29y6dP8gBU/hl/wUZObkWnnyEuyQYbX
         9uSr9qVI9FzDDG73jyNvzAUeXmwTl0jlzHxEJtBZTOgNtk0PGBm36LCmocK6lxR8PO2V
         EcC7BlxXgJIVj8zWxwpQrnc1bu/0vYJicVTh0SHjh79Q5bdnGDVzBY9vXNX1ymEX7lhg
         8nVrEye74whXJfdDgWw6vaoMhjQ7ZjrFEpIhfnp4pikJ1yJrfr/hs5VR84N/xN2V018K
         dWMpIuqN6Jy9v4nYRkRiLGmyQjnN+Q+TDnHF7GyksI92W7d3Q6JZhkh+2Dj4B8uRUpXQ
         zA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6TgRTi2KerRDtN5G1ixrB17oe7PQy1zG9VGDzld3dc=;
        b=ovkmmCbwWJKKACL5CjNET4SKwssfQ2rCAGFFZgjbttOOfOwl+qZB1zWTk3Wwd/YPtc
         OXS2RirnOL/segpOpohJnNVuUOSuG7nsodh2Aahc/td9O6im/WNPS4hfF72I27U152sy
         JDI3fEgnoKlPD3ygPMk/pKn3WUwGKVWt36lbcfEod60/deM8vu9U93G1ZeYU1810Aanm
         k7qB8s9Mc2zNbDZohc3Ryf2UHf6ql/wKo2wuziWa0yzvVOM/2+FVp8aF+GxltJIiTIeY
         jyoWEszfN7Kujh1vy6BltJj3sNFVc43j1gUujeYuXft4Oa9pyoXfa5kDGDZzM1im5wzA
         Mr9Q==
X-Gm-Message-State: AO0yUKXPV4meWvsxmn8Q5C7iL2lHhEJeTSXt2eyGMaq2JSr5r1HXHpQ6
        uVhAiK0ma0X85J3QWqvHFH1jOij7XhbNGpVHa2Q=
X-Google-Smtp-Source: AK7set/P15NlBL+VquQO9JBxtCQM7sQjK1ybEZSa4mIZMpP8DYhtzO2gaFXvRkm/xGDLoU5VVUfIKgtRYONO1dr7X2k=
X-Received: by 2002:a17:906:b4b:b0:931:c1a:b526 with SMTP id
 v11-20020a1709060b4b00b009310c1ab526mr204ejg.5.1679071462673; Fri, 17 Mar
 2023 09:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230316183013.2882810-1-andrii@kernel.org> <20230316183013.2882810-4-andrii@kernel.org>
 <20230317035432.tznxagpp666ow5aq@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230317035432.tznxagpp666ow5aq@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 09:44:10 -0700
Message-ID: <CAEf4BzbC6wqOzacKJP=d4_wersYpRozpVm9OQCRru=d0f+L6HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 8:54=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 16, 2023 at 11:30:10AM -0700, Andrii Nakryiko wrote:
> > Currently, if user-supplied log buffer to collect BPF verifier log turn=
s
> > out to be too small to contain full log, bpf() syscall return -ENOSPC,
> > fails BPF program verification/load, but preserves first N-1 bytes of
> > verifier log (where N is the size of user-supplied buffer).
> >
> > This is problematic in a bunch of common scenarios, especially when
> > working with real-world BPF programs that tend to be pretty complex as
> > far as verification goes and require big log buffers. Typically, it's
> > when debugging tricky cases at log level 2 (verbose). Also, when BPF pr=
ogram
> > is successfully validated, log level 2 is the only way to actually see
> > verifier state progression and all the important details.
> >
> > Even with log level 1, it's possible to get -ENOSPC even if the final
> > verifier log fits in log buffer, if there is a code path that's deep
> > enough to fill up entire log, even if normally it would be reset later
> > on (there is a logic to chop off successfully validated portions of BPF
> > verifier log).
> >
> > In short, it's not always possible to pre-size log buffer. Also, in
> > practice, the end of the log most often is way more important than the
> > beginning.
> >
> > This patch switches BPF verifier log behavior to effectively behave as
> > rotating log. That is, if user-supplied log buffer turns out to be too
> > short, instead of failing with -ENOSPC, verifier will keep overwriting
> > previously written log, effectively treating user's log buffer as a rin=
g
> > buffer.
> >
> > Importantly, though, to preserve good user experience and not require
> > every user-space application to adopt to this new behavior, before
> > exiting to user-space verifier will rotate log (in place) to make it
> > start at the very beginning of user buffer as a continuous
> > zero-terminated string. The contents will be a chopped off N-1 last
> > bytes of full verifier log, of course.
> >
> > Given beginning of log is sometimes important as well, we add
> > BPF_LOG_FIXED (which equals 8) flag to force old behavior, which allows
> > tools like veristat to request first part of verifier log, if necessary=
.
> >
> > On the implementation side, conceptually, it's all simple. We maintain
> > 64-bit logical start and end positions. If we need to truncate the log,
> > start position will be adjusted accordingly to lag end position by
> > N bytes. We then use those logical positions to calculate their matchin=
g
> > actual positions in user buffer and handle wrap around the end of the
> > buffer properly. Finally, right before returning from bpf_check(), we
> > rotate user log buffer contents in-place as necessary, to make log
> > contents contiguous. See comments in relevant functions for details.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h                  |  32 ++-
> >  kernel/bpf/log.c                              | 182 +++++++++++++++++-
> >  kernel/bpf/verifier.c                         |  17 +-
> >  .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
> >  4 files changed, 209 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 83dff25545ee..cff11c99ed9a 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -491,25 +491,42 @@ struct bpf_insn_aux_data {
> >  #define BPF_VERIFIER_TMP_LOG_SIZE    1024
> >
> >  struct bpf_verifier_log {
> > -     u32 level;
> > -     char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
> > +     /* Logical start and end positions of a "log window" of the verif=
ier log.
> > +      * start_pos =3D=3D 0 means we haven't truncated anything.
> > +      * Once truncation starts to happen, start_pos + len_total =3D=3D=
 end_pos,
> > +      * except during log reset situations, in which (end_pos - start_=
pos)
> > +      * might get smaller than len_total (see bpf_vlog_reset()).
> > +      * Generally, (end_pos - start_pos) gives number of useful data i=
n
> > +      * user log buffer.
> > +      */
> > +     u64 start_pos;
> > +     u64 end_pos;
> ...
> >
> > -void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
> > +void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
> >  {
> >       char zero =3D 0;
> >
> >       if (!bpf_verifier_log_needed(log))
> >               return;
> >
> > -     log->len_used =3D new_pos;
> > +     /* if position to which we reset is beyond current log window, th=
en we
> > +      * didn't preserve any useful content and should adjust adjust
> > +      * start_pos to end up with an empty log (start_pos =3D=3D end_po=
s)
> > +      */
> > +     log->end_pos =3D new_pos;
> > +     if (log->end_pos < log->start_pos)
> > +             log->start_pos =3D log->end_pos;
> > +
> >       if (put_user(zero, log->ubuf + new_pos))
>
> Haven't analyzed the code in details and asking based on comments...
> new_pos can be bigger than ubuf size and above write will be out of bound=
s, no?

Oh, great catch! Yes, new_pos is "logical position", so definitely can
go beyond buffer bounds. It should have been `log->ubuf + (new_pos %
log->len_total)`, of course. I'll improve tests to validate that the
buffer beyond allowed boundaries isn't modified at all, to catch this.
