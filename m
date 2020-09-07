Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDA25F616
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgIGJQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 05:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIGJQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 05:16:05 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF97C061573
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 02:16:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 11so4676630oiq.6
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 02:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCrN35Zsb6HWTfr4amlFhDV3wfsfMyg2S/fuCqhlb1k=;
        b=q3EzivVe0WoPKYyLWrWKonf/MLlkGDMzzNZ7uwqShudRya+TgZZjGnEAq0M2/qzPUW
         IV2z6Bnpnl7+GQuLiXCKLVhYwV+0jfJtgDzhgFgRletcekdenCgIrStN8IaRK8AaZDE8
         nHE71XHrfBPm2MEhliw8BmdpLXUeNkUXarKBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCrN35Zsb6HWTfr4amlFhDV3wfsfMyg2S/fuCqhlb1k=;
        b=Frr+5Kt69ic5rDBCH7z9oJxGdJubu2RHMwSuqjtdB+CpbC0uG+DuamfV/K29eQd6mj
         tpiw6WCC89rckH+XrlI41Mq8Fn+eZg4rnGgD9rkaqXfP6xdRfOuN5iDvrhF9vzAy1ga/
         rS0SRN36/Gbivi6VGlM0gHfUQj65pj38MZiSVPyNRE1hIQTKQN3asXfmpab7IlZg+PLZ
         hoHM7Rw++a2wWO/+gu5PHx08tYbWc8Nm1zuoYDN4h1vAdOvz28wFO4XgzzMMtqJneyI/
         9//OlOPjeq3KYz/Jetw/deTnErMUxDwdizQZ2x3SWtdpGrzbsjwmlVfhnAdJsrl49654
         2stw==
X-Gm-Message-State: AOAM530gqq8Sm9EczymDTJQVzhrfZIVPKZ4QyLhPSrj7ogynfkB3PHMm
        VADaz63hXiTQF5opQjs0ryv8+0iQ70h29xieASdUrA==
X-Google-Smtp-Source: ABdhPJxtg1b6/aKfZf/mK6W5Dexa56+Q10vCwm2nsStjzIqjofZJ4lprScuZcNP6PLeVNk11iD7TF9vQz9wbqB217sQ=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr12385967oia.110.1599470164895;
 Mon, 07 Sep 2020 02:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-6-lmb@cloudflare.com>
 <20200906230448.rd5rzcgg47qdzblj@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200906230448.rd5rzcgg47qdzblj@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 7 Sep 2020 10:15:53 +0100
Message-ID: <CACAyw99AynYAcV9rE4keTpOfNhEfT4PzEsxGxCYuzwU+BwhJZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: allow specifying a set of BTF IDs for
 helper arguments
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 7 Sep 2020 at 00:05, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Sep 04, 2020 at 12:23:55PM +0100, Lorenz Bauer wrote:
> > Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> > which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> > IDs, one for each argument. This array is only accessed up to the highest
> > numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> > five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> > is a function pointer that is called by the verifier if present. It gets the
> > actual BTF ID of the register, and the argument number we're currently checking.
> > It turns out that the only user check_arg_btf_id ignores the argument, and is
> > simply used to check whether the BTF ID matches one of the socket types.
> I believe the second way, ".check_btf_id", can be removed.  It currently ensures
> it can accept socket types that has "struct sock_common" in it.
>
> Since then, btf_struct_ids_match() has been introduced which I think can be
> used here.  A ".btf_id" pointing to the "struct sock_common" alone is enough.

Yes, I think that is a nice simplification!

>
> If the above is doable, is this change still needed?

I find .btf_id is really unintuitive. By looking at struct
bpf_func_proto is not at all clear how it's used. Having to use the
correct number of BTF_UNUSED to match the right argument also seems
really bug prone to me, and makes it unlikely that the BTF_ID_LIST
will be reused across function prototypes. So I think this is still a
good refactoring.

That said, with your suggestion it would be possible to use a u32 (or
*u32 to ease initialization) instead of struct btf_id_set*.

>
> >
> > Replace both of these mechanisms with explicit btf_id_sets for each argument
> > in a function proto. The verifier can now check that a PTR_TO_BTF_ID is one
> > of several IDs, and the code that does the type checking becomes simpler.
> >
> > Add a small optimisation to btf_set_contains for the common case of a set with
> > a single entry.
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
