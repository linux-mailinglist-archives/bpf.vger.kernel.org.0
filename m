Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1252865FA26
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 04:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAFD1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 22:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjAFD1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 22:27:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412367BC3
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 19:26:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s5so692325edc.12
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ3XXuAVxS5rVyqjqMcCPu/tF2/okDTCHYgNzrRdpa8=;
        b=LqxXUCz4afVyIuwW5vFeZz3hyDx+PWVfshzcPJHg5gpRp2PyC+QDOuODGz8FMxnWWt
         y0vTAuRvMr7ZPrLGCjEfQD0BhS8maBaWTGVFZxYlyx7SQMBn1voVy1JOqdqh0EzrzVuJ
         LPKkNUwB60Wh+KMhoQzVC0PjIORWDDyvbFm+yYLD2vzo5ceTwTc0AvmAlRegWuX8ecI4
         3cJh6rB4IKH2lF+HrocTDtLr1Q8BT+agUsdSmdcFiYLBjXRZzD3J+TmyA/qKWwX1eqGx
         CfcOAkRwhBOju+WKgKaFE7yNKyBFeXi6Tbe+WNCaIQ6P7imT/7hkNoJUtR5tY+ea+hYS
         wF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ3XXuAVxS5rVyqjqMcCPu/tF2/okDTCHYgNzrRdpa8=;
        b=v8lzLh3cGFFQrPO3HbCacv/0aTVLm/TCsQ327+H3dJ9TGpwaScBIOiP58E4pa9aKct
         QpXyHZaWueVSl19CBCptGA3yblVHoR/wp+hVoH55PibebgM5LmWMg/AnLYjG3woGuauM
         C+h88xhP24XT81A2SbQQ6C/W+4K+QeifUptR081JyidNfJk35o5h1ZNQpZn78NHIQy2B
         BcpX/2D0PUdWBe0mdC5fPMG1WsJ5Ts09wy++PAQxyQegi9VCPK+OWeh7foirOiQc2TN1
         nhDyPP+5JoAZdVj8UPzuO/xTvi1DgaE41aHGKUhApeBDV/JIbOHeei24pvpG5JzD924x
         QtkA==
X-Gm-Message-State: AFqh2kqGM3kxTwgDuy6ukgerpTHhqGBYhGgXz8RHX96irKyKzIfg8mKo
        Ds/RDjPkDhUU5C3c1wvaEaslBRY4B7tfiMMaSM6hDWEl
X-Google-Smtp-Source: AMrXdXuiFzm55vrVrIfMOzqA7KOJVkEISHhe62pPwj83oBuHwBx8gXctn79uPz54jIEVBhU+CNXU93C1egGcmbqFtBI=
X-Received: by 2002:aa7:d7c6:0:b0:486:9f80:8fbc with SMTP id
 e6-20020aa7d7c6000000b004869f808fbcmr4289363eds.421.1672975617352; Thu, 05
 Jan 2023 19:26:57 -0800 (PST)
MIME-Version: 1.0
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr>
 <Y6sWqgncfvtRHp+b@krava> <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr>
 <42d3f4d8-fa8b-5774-0f6b-b12162c24736@meta.com> <5692f180-5b78-48e0-b974-b60bd58c0839@Spark>
 <Y7PhWlqdG/TjwT75@krava> <1105578275.675049.1672845867568.JavaMail.zimbra@ip-paris.fr>
 <Y7Xyp6sQaAqi8qzw@krava> <Y7X3qEOXeimw1JmF@krava> <Y7acvJqbBJt4V21+@krava>
In-Reply-To: <Y7acvJqbBJt4V21+@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 5 Jan 2023 19:26:45 -0800
Message-ID: <CAADnVQJmRYSyi+aJ2FjcjoonYtJvJwibWr+1Nb63DQihFaMYHg@mail.gmail.com>
Subject: Re: bpf_probe_read_user EFAULT
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Victor Laforet <victor.laforet@ip-paris.fr>,
        bpf <bpf@vger.kernel.org>
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

On Thu, Jan 5, 2023 at 1:47 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Jan 04, 2023 at 11:08:23PM +0100, Jiri Olsa wrote:
> > On Wed, Jan 04, 2023 at 10:42:02PM +0100, Jiri Olsa wrote:
> > > On Wed, Jan 04, 2023 at 04:24:27PM +0100, Victor Laforet wrote:
> > > > Ok thanks. As I understand, tp_btf/+ probes (specifically tp_btf/sched_switch that I need) cannot be sleepable? It is then not possible to read user space memory from the bpf code?
> > >
> > > yes, only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable
>
> we actually allow to create tp_btf program with BPF_F_SLEEPABLE flag,
> because it's TRACING prog type, but still bpf program can't sleep when
> executed in tracepoint context..  so I wonder we should not allow to
> load it, Alexei?
>
> jirka
>
>
> ---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 98a8051ce316..390621d79fbb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16755,10 +16755,14 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>                 return -EINVAL;
>         }
>
> -       if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
> -           prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
> -               verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
> -               return -EINVAL;
> +       if (prog->aux->sleepable) {
> +               if ((prog->type == BPF_PROG_TYPE_TRACING &&
> +                    prog->expected_attach_type == BPF_TRACE_RAW_TP) ||
> +                   (prog->type != BPF_PROG_TYPE_TRACING &&
> +                    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE)) {
> +                       verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
> +                       return -EINVAL;

Ahh. good catch. The sleepable flag makes no difference for tp_btf.
Indeed, let's disable this combo.
I was thinking whether explicit list of
fentry/fexit/fmod_ret || lsm || kprobe would be cleaner?
