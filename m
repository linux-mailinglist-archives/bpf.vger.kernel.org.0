Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5E6CADC6
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC0Sr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC0SrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:47:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFEEA3
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:47:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id er18so28940245edb.9
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679942843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb/u2crMAE70mg5Qg9sZTasXSBxMAPkXbt5I2pfiLFM=;
        b=dWYwkp0B3QFIzh2qabXxh9RcC+82D+lqlQf5AD/NwwV+oezzbFIBssCCuTlGQrRKeL
         gDicvgwdPJT2qX7fU8soHM6XEnjvOjbfejvH5uQ/ZI5SOKLLUIEorNhI88CPemjeoCsJ
         D+zzAXX8Ily5741wxvlFRznxiG7Xh2XyM4gel29FS5v9rG9siN/rH2eb9C5Q3L1yqDBu
         xRGjiA3T6ZtPjjkp3rNvIa0okfobuTnovq3Fz+bAFbMYBn0hlesXrm9xisEPsZek5KOx
         7qVdKoZOgRjKDnH6inSy7yMTE3IwSptZLrdCtikwhfSxSe+uZet5JvkFYX/BoV5/zzEM
         PGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb/u2crMAE70mg5Qg9sZTasXSBxMAPkXbt5I2pfiLFM=;
        b=S8IBRQrZlZ8la+6S6tJ7vkeR+oIzpDKsChY3dqdFg3pMLqJ1U043yJZsC8g9XiZWkW
         SI+aPrag0LnR6fu2Z8Zd0DQ8Syv5630M8g3gxJ/z7YmzWog3kygV7FIaLJxMP3gPpZfc
         eoODGSOrsGN1uSq4YWc1rU0KPtDZaooDMNpTTSmPxIbw15KYi32Gls1TQ6xe/Qk2AVfI
         WpQLvJ1X4iPEDWYXcmAJXKZL6AluLwbnjSv5TV2g5PQZGiXylLufKAmY+lB16mePmoLF
         JRMAET7JPD9BwoquOXXg8lo9DEXbVnt7Ffg+gnmpOVGQ38//ASQHiMGu7eF8gQacfQ7+
         aCMQ==
X-Gm-Message-State: AAQBX9elNsiU6hZrOmIA3IS0Wzjgvc6hWlRT0fwHRB/1zMk8wB7M4unI
        g8W9YIpQ1lF4nMOQVssAHoQJq8Hfm31ogkqyFJnnIu1ExVc=
X-Google-Smtp-Source: AKy350ZGOEcFCZRQI/E3U8Wr2KTgdvmQK2dDZqUm96M6Q4Mhwk1SabnoWXlKRoEVrRluNrDqzc+iPACIm/fDdH+tios=
X-Received: by 2002:a17:906:6a93:b0:92d:591f:645f with SMTP id
 p19-20020a1709066a9300b0092d591f645fmr6666145ejr.5.1679942842761; Mon, 27 Mar
 2023 11:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230324232745.3959567-1-andrii@kernel.org> <20230324232745.3959567-4-andrii@kernel.org>
 <20230326045944.rjayv2d2xbdlz5m2@MacBook-Pro-6.local>
In-Reply-To: <20230326045944.rjayv2d2xbdlz5m2@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 11:47:10 -0700
Message-ID: <CAEf4BzZR_e8nZTJVSztJJn=yGQCb1HUa0wAms-=DuOvR=cuECg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] veristat: guess and substitue underlying
 program type for freplace (EXT) progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 9:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 24, 2023 at 04:27:45PM -0700, Andrii Nakryiko wrote:
> > +static int guess_prog_type_by_ctx_name(const char *ctx_name,
> > +                                    enum bpf_prog_type *prog_type,
> > +                                    enum bpf_attach_type *attach_type)
> > +{
> > +     /* We need to guess program type based on its declared context ty=
pe.
> > +      * This guess can't be perfect as many different program types mi=
ght
> > +      * share the same context type.  So we can only hope to reasonabl=
y
> > +      * well guess this and get lucky.
> > +      *
> > +      * Just in case, we support both UAPI-side type names and
> > +      * kernel-internal names.
> > +      */
> > +     static struct {
> > +             const char *uapi_name;
> > +             const char *kern_name;
> > +             enum bpf_prog_type prog_type;
> > +             enum bpf_attach_type attach_type;
> > +     } ctx_map[] =3D {
> > +             /* __sk_buff is most ambiguous, for now we assume cgroup_=
skb */
> > +             { "__sk_buff", "sk_buff", BPF_PROG_TYPE_CGROUP_SKB, BPF_C=
GROUP_INET_INGRESS },
> > +             { "bpf_sock", "sock", BPF_PROG_TYPE_CGROUP_SOCK, BPF_CGRO=
UP_INET4_POST_BIND },
> > +             { "bpf_sock_addr", "bpf_sock_addr_kern",  BPF_PROG_TYPE_C=
GROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND },
> > +             { "bpf_sock_ops", "bpf_sock_ops_kern", BPF_PROG_TYPE_SOCK=
_OPS, BPF_CGROUP_SOCK_OPS },
> > +             { "sk_msg_md", "sk_msg", BPF_PROG_TYPE_SK_MSG, BPF_SK_MSG=
_VERDICT },
> > +             { "bpf_cgroup_dev_ctx", "bpf_cgroup_dev_ctx", BPF_PROG_TY=
PE_CGROUP_DEVICE, BPF_CGROUP_DEVICE },
> > +             { "bpf_sysctl", "bpf_sysctl_kern", BPF_PROG_TYPE_CGROUP_S=
YSCTL, BPF_CGROUP_SYSCTL },
> > +             { "bpf_sockopt", "bpf_sockopt_kern", BPF_PROG_TYPE_CGROUP=
_SOCKOPT, BPF_CGROUP_SETSOCKOPT },
> > +             { "sk_reuseport_md", "sk_reuseport_kern", BPF_PROG_TYPE_S=
K_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE },
> > +             { "bpf_sk_lookup", "bpf_sk_lookup_kern", BPF_PROG_TYPE_SK=
_LOOKUP, BPF_SK_LOOKUP },
> > +             { "xdp_md", "xdp_buff", BPF_PROG_TYPE_XDP, BPF_XDP },
> > +             /* tracing types with no expected attach type */
> > +             { "bpf_user_pt_regs_t", "pt_regs", BPF_PROG_TYPE_KPROBE }=
,
> > +             { "bpf_perf_event_data", "bpf_perf_event_data_kern", BPF_=
PROG_TYPE_PERF_EVENT },
> > +             { "bpf_raw_tracepoint_args", NULL, BPF_PROG_TYPE_RAW_TRAC=
EPOINT },
> > +     };
> > +     int i;
> > +
> > +     if (!ctx_name)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctx_map); i++) {
> > +             if (strcmp(ctx_map[i].uapi_name, ctx_name) =3D=3D 0 ||
> > +                 (!ctx_map[i].kern_name || strcmp(ctx_map[i].kern_name=
, ctx_name) =3D=3D 0)) {
>
> I'm struggling to understand above A || (B || C) logic.
> () are redundant?

oh, shoot, should have been A || (B && C). Last minute refactoring
gone wrong. kern_name is optional (for bpf_raw_tracepoint_args), so
this is just to avoid strcmp() on NULL.

>
> > +                     *prog_type =3D ctx_map[i].prog_type;
> > +                     *attach_type =3D ctx_map[i].attach_type;
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     return -ESRCH;
>
> This will never be hit, since "bpf_raw_tracepoint_args", NULL is last and
> it will always succeed.
>
> The idea is to always succeed in guessing and default to raw_tp ?
> ... and there should be only one entry with kern_name =3D=3D NULL...

No-no, it's much simpler than that. It should have been A || (B && C)
above. If we can't guess, we shouldn't just assume raw_tp, that wasn't
the intent.

Unfortunately I didn't see your comments before sending v3, I'll send
v4 with a fix for NULL check.


> But it's not mentioned anywhere in the comments.
> A weird way to implement a default.
> I'm definitely missing something.
