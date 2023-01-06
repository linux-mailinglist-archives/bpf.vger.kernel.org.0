Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC1660582
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjAFRRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 12:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjAFRRZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 12:17:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E97012D20
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 09:17:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2279687pjj.4
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 09:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRp4+4WzUTu0sjsRvL11pC0x9hSIC9oeB0YwCCx2a5o=;
        b=EiCDyM+G2Bf1f39te0cfr6LNGqw3Zf5Im1NTIVWTTnaHWCxNw6Ku5m8ojtg+Yk76Y7
         ImgQmp9M3J64/enIzHeIV+T6Bv7HYn9XDaKpPfjwtFmMGi0fjIHAOA8I2pw97Tdo4hl1
         39rFzBO1hs2GZ9lXvoeievZO2nj5Lf/wKEdfBx78ADyyk1IJ0g+doG24kfJ8s+knnv5h
         5NwKHFs7hA+hpalNOgXspmLx80hFLrdy9yirjrITE5DjvelQdvMnuT8k5hTGh5fOFtaD
         +VoL50iFaKUgeQWUw/syor2mClCKLkXW+kvynzXlQqB16y4slKfRH9C4ML81jY80wxZK
         5SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRp4+4WzUTu0sjsRvL11pC0x9hSIC9oeB0YwCCx2a5o=;
        b=OD+Kc4ACbKMEq9H98IRnhyoGSfLqmpDFl2sc/5f7GddMTb9Iw6lNtyNojw9t4IsfYB
         4jHMfZ1SttjjKXIHAk6AO3pJtkkEG7jooobr0n7hy5i9YlNJLtiNZsd757M/ZSQ7Ahr2
         0RTWxHCxGdOWnZY3qz3vhp/RqxZVQSPsesbQ6Z8wlMTpzwDTrdtRQU5MnGlyjdIm8ABi
         b38srchQwSq1x4qIhdbFk0U7QaKsgUdzGEpN5vz7czV5V4H8H200Dfi0ZYj8PpAlcmx7
         wReRrwH82zPbkq6Q3IzIIVLacT2HzHKoSZ/Y6XxZGg6yT5NtUVyf3rXQ7pdyLKwnaaim
         TXAA==
X-Gm-Message-State: AFqh2kopfWL3VSm9Wi/3Hno0bOzP4CbQqXn49Yd4+vojZKgaDDmWvTVu
        qDrrFHqiONMVvxFgBPBNnTaMoTvJfzUAwwMrCCCz2g==
X-Google-Smtp-Source: AMrXdXvK28jpjpTdbhB8rbD/am+xqGYME/I6MwD4+aF7dljE5VZvVsSSzANXLFUs4x39ERAJXRSXKNTy7nf2zxVjUo0=
X-Received: by 2002:a17:90b:46d8:b0:226:6523:7849 with SMTP id
 jx24-20020a17090b46d800b0022665237849mr1454699pjb.66.1673025443405; Fri, 06
 Jan 2023 09:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20230104215949.529093-1-sdf@google.com> <20230104215949.529093-9-sdf@google.com>
 <42984784-2910-bf5a-93a9-bd4db86a5a50@linux.dev>
In-Reply-To: <42984784-2910-bf5a-93a9-bd4db86a5a50@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 6 Jan 2023 09:17:11 -0800
Message-ID: <CAKH8qBt6pkguqfZLLNBvqr9Qi0HSybCdE53ChizdQcB7RgE73Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 08/17] bpf: Support consuming XDP HW metadata
 from fext programs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 5, 2023 at 4:57 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/4/23 1:59 PM, Stanislav Fomichev wrote:
> > -int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> > +static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *netdev)
> >   {
> >       struct bpf_offload_netdev *ondev;
> >       struct bpf_prog_offload *offload;
> >       int err;
> >
> > -     if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
> > -         attr->prog_type != BPF_PROG_TYPE_XDP)
> > -             return -EINVAL;
> > -
> > -     if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> > +     if (!netdev)
>
> nit. I think this check is also unnecessary.
>
> [ ... ]
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 191a4312f4b7..2ec2f53eeff6 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2605,6 +2605,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
> >                       goto free_prog_sec;
> >       }
> >
> > +     if (type == BPF_PROG_TYPE_EXT && dst_prog &&
> > +         bpf_prog_is_dev_bound(dst_prog->aux)) {
> > +             err = bpf_prog_dev_bound_inherit(prog, dst_prog);
> > +             if (err)
> > +                     goto free_prog_sec;
> > +     }
> > +
> >       /* find program type: socket_filter vs tracing_filter */
> >       err = find_prog_type(type, prog);
> >       if (err < 0)
> > @@ -3021,6 +3028,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >                       goto out_put_prog;
> >               }
> >
> > +             if (bpf_prog_is_dev_bound(prog->aux) &&
> > +                 !bpf_prog_dev_bound_match(prog, tgt_prog)) {
> > +                     err = -EINVAL;
> > +                     goto out_put_prog;
> > +             }
>
> This looks good.  One minor comment...

True, fill drop, thanks!

> > +
> >               key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
> >       }
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0d0a49a2c5fd..8c1b1259f30b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16531,11 +16531,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >       if (tgt_prog) {
> >               struct bpf_prog_aux *aux = tgt_prog->aux;
> >
> > -             if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
> > -                     bpf_log(log, "Replacing device-bound programs not supported\n");
> > -                     return -EINVAL;
> > -             }
>
> ... can the above "bpf_prog_is_dev_bound(prog->aux) &&..." check in syscall.c be
> done in the bpf_check_attach_target() here?  Mentally that seems to belong more
> to bpf_check_attach_target().

Sure, I don't see why not, will try!



> > -
> >               for (i = 0; i < aux->func_info_cnt; i++)
> >                       if (aux->func_info[i].type_id == btf_id) {
> >                               subprog = i;
>
