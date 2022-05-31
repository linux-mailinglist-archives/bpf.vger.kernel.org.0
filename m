Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CEC539A02
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 01:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348689AbiEaXUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 19:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348688AbiEaXUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 19:20:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BC78D6A0
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:20:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l13so23762799lfp.11
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MSeLrRu24RgS4btUOjL9ry/0YUWVtDZ8aanDCkWdkhk=;
        b=U6m5X2oK/fImz4b7ZftrdlFS+rTntrSPM1dH/18qDNrRPOSdjBQYsbHmPIc47+j85e
         AOlDgRaFd8Jq63rbLuIAre4GQ903a65fJcCCdhKmzA/vECHUt8PA7ZoJl215ojeK5eZG
         o2z9vdezxJ3AszgSGFqARAzJ84IyzXtJFqIQGj6pVYkSI4kF4TPIa8fXmSCEjAgh7k5e
         v5sPE1pdUzZQi6gA9iS5M9Z4qqBpB4uUHiRBglCHB6p9LrQzXyG6U3Trhq1084j12MbB
         y6IUJ/BEZrt+g11vxcGmwJjXjJ2Hn7PJOfxsOfttSX8jM2f8PiKNGHhQiMDd340OSrPg
         0aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MSeLrRu24RgS4btUOjL9ry/0YUWVtDZ8aanDCkWdkhk=;
        b=jupS+6fz5P14FN1iZCzwjbzi01fOtOKZtKCK/2uKws0cZESKJfzP3YdUzpD2KcaOdf
         ajtBpF0yFrmqLAlWKogxj5sEUgzYAMsZg7atwAf2Vb255yWDZbf2PX1j7JbDWWeOyl/Z
         7kgTZaX+3D3nv0sNQMzfOeJuivb6CzY6SlkY5nSv/pHnhfVzWpdTM4daQyWRKXbyceUp
         0gu0Lkh42IM9dp31V3fwF/uxk4SfrVpkG/9vsuKMch7ocumOJb31zhvdVs6+nvfwtN1B
         aY2IFfRBfm5n1dQRVpcYGID2uobC371T0NJBPsh18x1O+i2IZFtHBaGv3QOKLH1q8KUI
         1b5g==
X-Gm-Message-State: AOAM530kjhJjCwAPrjlENqoaHNl3XEKkZDn76eycQ3zKzUG7GIrDAhW/
        O4X3LedFD7Z+mAZtCsVFyvJmRhv3eQv/DA==
X-Google-Smtp-Source: ABdhPJwB+muZOsu9/EJ6eZInNsShgY7uqG3T/bZM0rilkZ9uJd8lw4Cg8tcfZcFM1mnJrRxYGPPm4w==
X-Received: by 2002:a05:6512:3daa:b0:478:55b8:88a9 with SMTP id k42-20020a0565123daa00b0047855b888a9mr41483304lfv.289.1654039202952;
        Tue, 31 May 2022 16:20:02 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e13-20020a19500d000000b00478c1ac6d98sm2761095lfb.248.2022.05.31.16.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 16:20:02 -0700 (PDT)
Message-ID: <b517e19ffbd19b24b630cdeafdb4adb444a8dd56.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: allow BTF specs and func
 infos in test_verifier tests
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Date:   Wed, 01 Jun 2022 02:20:01 +0300
In-Reply-To: <CAPhsuW7wwt+J=oHXeB_8s8Tu63dzgODh56aCFPv-Vp43bofutA@mail.gmail.com>
References: <20220529223646.862464-1-eddyz87@gmail.com>
         <20220529223646.862464-3-eddyz87@gmail.com>
         <CAPhsuW7wwt+J=oHXeB_8s8Tu63dzgODh56aCFPv-Vp43bofutA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Tue, 2022-05-31 at 13:52 -0700, Song Liu wrote:

Hi Song,

Thanks a lot for the review, I'll apply the suggested changes and
provide the v3 in one or two days. My only objection is below.

> >  {
> > -       int fd_prog, expected_ret, alignment_prevented_execution;
> > +       int fd_prog, btf_fd, expected_ret, alignment_prevented_execution;
> >         int prog_len, prog_type = test->prog_type;
> >         struct bpf_insn *prog = test->insns;
> >         LIBBPF_OPTS(bpf_prog_load_opts, opts);        __u32 pflags;
> >         int i, err;
> > 
> > +       fd_prog = -1;
> 
> This is not really necessary.

Actually this one is necessary to avoid compiler warning, note the
following fragment of the do_test_single function below:

static void do_test_single(...)
{
        ...
        if (...) {
                btf_fd = load_btf_for_test(...);
                if (btf_fd < 0)
                        goto fail_log;
                opts.prog_btf_fd = btf_fd;
        }
        ...
        fd_prog = bpf_prog_load(..., &opts);
        ...
close_fds:
        ...
        close(fd_prog);
        close(btf_fd);
        ...
        return;
fail_log:
        ...
        goto close_fds;
}

If load_btf_for_test fails the goto fail_log would eventually jump to
close_fds, where fd_prog would be in an uninitialised state.

Best regards,
Eduard

