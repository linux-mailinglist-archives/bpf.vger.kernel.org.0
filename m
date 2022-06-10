Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD3546F6C
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiFJVzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 17:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbiFJVzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 17:55:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E4274B68
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 14:55:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a29so506722lfk.2
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yXEv/cJAQQbfNfG59EJqZDsTNszhaBKBSNglyu4TwXk=;
        b=ZYm4KqHc00NnGJhbzsd9ot2UgAOEjZ8Kc0/C9CkB+sf/5m/dj0T+ZG92ipQrpN7Xw0
         JvQSGCv/MgWE8ewaZJXcEcbcKkJrWwHgIg8H39dtyZvBPZ8kWoEC6TxDWskHneUxjzQn
         txcaJpNL30irMumYdMsWB27Bz7Hw4tSEQz2ETTuVo17FbOzKsF99vsR7+fAbHehNLtrm
         3eVQulAXg2YRHSx3UcPMDHzPak2r5S7Iyn6McaQe2nrh7QRkgIh3DaBCLJ1y8cSMZDRA
         q1S/ji0dzMzlzWSk/upRO1s4IwweKcUYYSuUNdhcB8uEANaKTBLz3kivJx5BBdeJPTYh
         PIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yXEv/cJAQQbfNfG59EJqZDsTNszhaBKBSNglyu4TwXk=;
        b=yBcEHheUPcJipTT/AtyQmfVWTaxpPzyqVzwZ5Q1uP1B8v8Z+84Dso3WflhI7XEQLEZ
         7YmzRWfqh4msKZ3lWuoZbhyT5zRKe8rXX/eopT0zxh5/QbVC9YrY25xQ9kqWPZDbVaJ/
         p7a5JAiNLY7YWxUnR5Q2g4IQZ9fB+7MYn9yuS8OVwf3EMtoGYggEwxyAXzzNBUiF9/WL
         /NfXhqLbnZ4W+j6Ow2QZniHbaWyfgDSgzX4hZA/AISA05WVLhcWmofvDzW1yZsaKvCDq
         4sZkdpDUCpC5P1/jsgn28PU6t20w2YX5iiCd2TfR4zufhqbvfPB7kxuBh1TK/IDJ/28s
         jyGQ==
X-Gm-Message-State: AOAM531NmB+jF4ilWfbzrQXi5VteHOe1wRZlFWgDONH9j0v2jheVegkn
        DZC7Tkf6rLp/z5rT2rJfGr0=
X-Google-Smtp-Source: ABdhPJzcMmGVvZRHyL+C48aF4J07CrJdqpdWmcPfIImL1gHqgUwbyIQNnjVtvpECPUElsbnv6YXmzg==
X-Received: by 2002:a05:6512:693:b0:479:892:3091 with SMTP id t19-20020a056512069300b0047908923091mr28186701lfe.122.1654898101701;
        Fri, 10 Jun 2022 14:55:01 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h9-20020ac24d29000000b004791b687257sm5920lfk.237.2022.06.10.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:55:00 -0700 (PDT)
Message-ID: <23ad183ee89f016f7b5cbc1f08ff086b44d9fc0d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Date:   Sat, 11 Jun 2022 00:54:59 +0300
In-Reply-To: <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
         <20220608192630.3710333-4-eddyz87@gmail.com>
         <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
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

> On Fri, 2022-06-10 at 13:54 -0700, Song Liu wrote:

> > +
> > +void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> 
> static void ...
> 
> > +{
> > +       struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> > +       struct bpf_reg_state *regs = cur_regs(env);
> > +       struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
> > +
> 
> nit: we usually don't have empty lines here.
> 
> > +       int flags_is_zero =
> > +               register_is_const(flags_reg) && flags_reg->var_off.value == 0;
> 
> If we replace "fit_for_inline" with "not_fit_for_inline", we can make the cannot
> inline case faster with:
> 
>   if (state->not_fit_for_inline)
>       return;
> 
> > +
> > +       if (state->initialized) {
> > +               state->fit_for_inline &=
> > +                       flags_is_zero &&
> > +                       state->callback_subprogno == subprogno;
> > +       } else {
> > +               state->initialized = 1;
> > +               state->fit_for_inline = flags_is_zero;
> > +               state->callback_subprogno = subprogno;
> > +       }
> > +}
> > +

Sorry, I'm not sure that I understand you correctly. Do you want me to
rewrite the code as follows:

struct bpf_loop_inline_state {
	int initialized:1; /* set to true upon first entry */
	int not_fit_for_inline:1; /* false if callback function is thesame
				   * at each call and flags are always zero
				   */
	u32 callback_subprogno; /* valid when fit_for_inline is true */
};

static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
{
	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
	struct bpf_reg_state *regs = cur_regs(env);
	struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
	int flags_is_zero =
		register_is_const(flags_reg) && flags_reg->var_off.value == 0;

	if (state->not_fit_for_inline)
		return;

	if (state->initialized) {
		state->not_fit_for_inline |=
			!flags_is_zero ||
			state->callback_subprogno != subprogno;
	} else {
		state->initialized = 1;
		state->not_fit_for_inline = !flags_is_zero;
		state->callback_subprogno = subprogno;
	}
}

// ...

static int optimize_bpf_loop(struct bpf_verifier_env *env)
{
	// ...
		if (is_bpf_loop_call(insn) && !inline_state->not_fit_for_inline) {
	// ...
}

IMO, the code is less clear after such rewrite, also
`update_loop_inline_state` is not on a hot path (it is called from
`check_helper_call` only when helper is `bpf_loop`). Are you sure this
rewrite is necessary?

Thanks,
Eduard

