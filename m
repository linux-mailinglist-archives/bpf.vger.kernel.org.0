Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E154A139
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 23:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351969AbiFMVTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352605AbiFMVSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 17:18:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9022B29
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 14:02:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d14so8849540eda.12
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RU9jmerW50QBZVJKqWIUvPkRe08OPGFI5407wWPNvyY=;
        b=ek5p7FoVsNFDwLxPPMyXKybPdpqISYkWb4vxgDYmccvh7srYH0wtRTy7tNlsVGvrHd
         lV2w+v5Raz2i+TgzGlVM+MWOPJ1Xjo/5HuKPS+OjWBkguM4u6YdMbK0IeL8i4H0uBE7x
         ZK1QKjnhQABJLQm2n1TaEePOTc30xS0cjNtad7E/4cO0pMTig1YtdEnAYX2CIOcDMUPg
         m70NoPKzBEJLj3FlMbs2xC9EAmChiciGVsV6tR+vg0FTNYzFtkXjhkI3lBfhxLK73MSd
         zMv6PcxQurfVVc1GQlHZ/Bom6KNmdg+ci7RW+iGgpf84rwp8XcNc4SKZfRRSHELKFaaY
         2xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RU9jmerW50QBZVJKqWIUvPkRe08OPGFI5407wWPNvyY=;
        b=AGUnQNEv6t0+nUkK9BX12oIelEGP5/g1hu2GXpmbeNiZ7FYhP/0LzuLXfbhshD5iRh
         s1f/nlrkjZmxYqY0FrWrMVd9EQ3jNpKo8PgdQmOKslEx3+yaS80R0j7YZFVdybdUhA3f
         vsrvbVwHk5Uam8N8zh53C2ETuy0+j1SjC55dsu8Xl0+K1+dNxguf4yoUQWVfGxPlHDLx
         BN/h9YKVcI41GXZ99rqnOGQXWpQLRV/v1KETy9BcwUG5MrlWGH/5ATuycyglhBARUJW7
         40YxOQfRnz9nyQurZF8UTnwQzAW0xhnT+crYH+3LuVolcIaexdvqomExzpigmpuELOD9
         Pa7g==
X-Gm-Message-State: AJIora/znDBkVrQnV4NGNk7i0P5pxJO15HejR9AzZW7DPbN1WaJCN8Op
        C9VKIcIS+uXaWY/OgNhlCWAfq9a1oJ6VWzDMn+k=
X-Google-Smtp-Source: AGRyM1tdHxOnGbDKqoYSUjCp9+UPxbwySr6+rvT5+t23ctOnFRFbmGrsUqXsEJDGGzl6IQbtfsSVmniQfI5Zmp7oV/4=
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id
 n11-20020a05640205cb00b00434eb48754fmr1889439edx.421.1655154119564; Mon, 13
 Jun 2022 14:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220613025244.31595-1-quic_satyap@quicinc.com>
 <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com> <005f01d87f4d$9a075210$ce15f630$@quicinc.com>
In-Reply-To: <005f01d87f4d$9a075210$ce15f630$@quicinc.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Jun 2022 14:01:46 -0700
Message-ID: <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc:     Yonghong Song <yhs@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Mon, Jun 13, 2022 at 10:47 AM Satya Durga Srinivasu Prabhala
<quic_satyap@quicinc.com> wrote:
>
>
> On 6/13/22 9:35 AM, Yonghong Song wrote:
> >
> >
> > On 6/13/22 2:22 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> !-------------------------------------------------------------------|
> >>    This Message Is From an External Sender
> >>    This message came from outside your organization.
> >> |-------------------------------------------------------------------!
> >>
> >> Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com> writes:
> >>
> >>> Below recursion is observed in a rare scenario where __schedule()
> >>> takes rq lock, at around same time task's affinity is being changed,
> >>> bpf function for tracing sched_switch calls migrate_enabled(),
> >>> checks for affinity change (cpus_ptr !=3D cpus_mask) lands into
> >>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
> >>> recursion bug.
> >>
> >> So this only affects tracing programs that attach to tasks that can ha=
ve
> >> their affinity changed? Or do we need to review migrate_enable() vs
> >> preempt_enable() for networking hooks as well?
> >
> > I think that changing from migrate_disable() to preempt_disable()
> > won't work from RT kernel. In fact, the original preempt_disable() to
> > migrate_disable() is triggered by RT kernel discussion.
> >
> > As you mentioned, this is a very special case. Not sure whether we have
> > a good way to fix it or not. Is it possible we can check whether rq loc=
k
> > is held or not under condition cpus_ptr !=3D cpus_mask? If it is,
> > migrate_disable() (or a variant of it) should return an error code
> > to indicate it won't work?
>
> That essentially becomes using preempt_enable/disable().
> If we need migrate_enable/disable() for RT kernels, we can
> add specific check for RT Kernels like below which should fix
> issue for non-RT Kernels?
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2b914a56a2c5..ec1a287dbf5e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1414,7 +1414,11 @@ bpf_prog_run_array(const struct bpf_prog_array
> *array,
>          if (unlikely(!array))
>                  return ret;
>
> +#ifdef CONFIG_PREEMPT_RT
>          migrate_disable();
> +#else
> +       preempt_disable();
> +#endif
>          old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>          item =3D &array->items[0];
>          while ((prog =3D READ_ONCE(item->prog))) {
> @@ -1423,7 +1427,11 @@ bpf_prog_run_array(const struct bpf_prog_array
> *array,
>                  item++;
>          }
>          bpf_reset_run_ctx(old_run_ctx);
> +#ifdef CONFIG_PREEMPT_RT
>          migrate_enable();
> +#else
> +       preempt_enable();
> +#endif

This doesn't solve anything.
Please provide a reproducer.
iirc the task's affinity change can race even with preemption disabled
on this cpu. Why would s/migrate/preemption/ address the deadlock ?
Once there is a reproducer we need to figure out a different way
of addressing it. Maybe we will special case trace_sched_switch.
