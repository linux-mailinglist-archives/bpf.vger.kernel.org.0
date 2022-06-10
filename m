Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18C9546FFD
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 01:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiFJXVI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiFJXVH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 19:21:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F2151FFF
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 16:21:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a15so694599lfb.9
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HH002yzt1txZWKcdD2Ec5WnkvdEEaxZvslb4DdPuVlE=;
        b=CzYeV3aWpID8IaoeiEmjnApbohMuhxzuZ4XpSkIf6XsTtGOJGDBU8TdprnPScdvCzE
         OfFG+Uy/dJCGcIHu1Cu2cqgHC2lYAABQ+xDMkdSQtddRE5pTQn/qvlSTPdm/S1rtwqAS
         4WOGward1a3nXKQArZ+ANIrI5KJqDOyMeDWdG2ORBpJ1Ef3Tth/gs9ihwKn3UiEDDdqY
         ZkOD50usJ/Q/HYqvcXQ6x/MIZ6vr+BUI6aG+2gy7ljADEDmDcOqbaWLm8aoSPaado/JU
         uAwNIo01ILdO/PzKuPVguEz3SIMnDjBwVJ32eCA8zJ4Y60kIHvBcUtoJtwVT3QaTIBKc
         eP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HH002yzt1txZWKcdD2Ec5WnkvdEEaxZvslb4DdPuVlE=;
        b=V4vZfUE7lnfYxl18tWMNIEFsagSWuDGKpzvRMpB8QzdZgSAkHY2FKnVX+7Wl887JAT
         b6wnT5xoAQiW59fCaZCofbOtgKFNw25ii9Yh4Q9tbS/gYPB6/oyOvOMZO6SyPsQB3Y05
         EXZBvwxun2ebNoVKdc91P33OXuZIxa1t+dHAEhVrYjDH6+jGde23iod7MTo54LMDHbAG
         x7ka0AEEZwx/E/mOvT4OcdubFVU2sP0Jy2ZZhRZEo16tmUaPV0Gtmt7E2mSaqLzZ2zBX
         d5q98LOa8C9eToV/AYYWAX55bWtRzoqtdv6Z3GCHr5959kNoqCswc3rP53V75uW9hZ7r
         hf5g==
X-Gm-Message-State: AOAM532JFNIQT9MTLGn7ZHIDekYsor1orZ8BsVlv0takwzkScrrmx9P5
        tHRU6my6OQ2WcA+rRbzwUXRNG3Suaf4Nfw==
X-Google-Smtp-Source: ABdhPJx7CKt+tr5EJPPiWByWYF7lWHGO5w5NcHs1A66o2mWAr5dXNfbdDG7PnCZBO7mxRaudYDgu1g==
X-Received: by 2002:a19:ad0a:0:b0:479:4d00:882a with SMTP id t10-20020a19ad0a000000b004794d00882amr16796961lfc.25.1654903264518;
        Fri, 10 Jun 2022 16:21:04 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e16-20020a05651236d000b0047936c0a64bsm35531lfs.36.2022.06.10.16.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 16:21:04 -0700 (PDT)
Message-ID: <c083c5cb2bc42eb455484cfd9ea803bd6a5e9d77.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Date:   Sat, 11 Jun 2022 02:21:02 +0300
In-Reply-To: <CAPhsuW4MMAFEOWn0ehvOZtt3h0w_Z6HaD0UJ2PH47PLHcExKwQ@mail.gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
         <20220608192630.3710333-4-eddyz87@gmail.com>
         <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
         <23ad183ee89f016f7b5cbc1f08ff086b44d9fc0d.camel@gmail.com>
         <CAPhsuW7wPz+jwdT01BjLgpr0zPCkhc2gFzXBhph64FDvjh0oCQ@mail.gmail.com>
         <f712fb0e6e0d72542b047f174f8590888d025918.camel@gmail.com>
         <CAPhsuW4MMAFEOWn0ehvOZtt3h0w_Z6HaD0UJ2PH47PLHcExKwQ@mail.gmail.com>
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

> On Fri, 2022-06-10 at 16:01 -0700, Song Liu wrote:
> 
> In this case, we need to initialize fit_for_inline to true, no?

You are right...

My Last try is below, if you don't like it I'll proceed with your
version.  I just really don't like the "not-cannot" part in the
expression "!inline_state->cannot_inline" :)

static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
{
	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
	struct bpf_reg_state *regs = cur_regs(env);
	struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
	int flags_is_zero =
		register_is_const(flags_reg) && flags_reg->var_off.value == 0;

	if (!state->initialized) {
		state->initialized = 1;
		state->fit_for_inline = flags_is_zero;
		state->callback_subprogno = subprogno;
		return;
	}

	if (!state->fit_for_inline)
		return;

	state->fit_for_inline =
		flags_is_zero &&
		state->callback_subprogno == subprogno;
}

static int optimize_bpf_loop(struct bpf_verifier_env *env)
{
	// ...
	if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) { ... }
	// ...
}

Thanks,
Eduard

