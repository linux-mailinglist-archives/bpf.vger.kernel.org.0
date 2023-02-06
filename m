Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65968C667
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 20:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBFTFp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 14:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFTFo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 14:05:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0988D22A2C;
        Mon,  6 Feb 2023 11:05:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F0760FBE;
        Mon,  6 Feb 2023 19:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27D4C433D2;
        Mon,  6 Feb 2023 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675710343;
        bh=hVPWcHpqTifknv72e5/DXO2ZqY5XUoyE27FE/BcW2zA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FZW6/Fc2yNwzwdlDLCpS3Kn8n3RJS4UnznTqQT2x92u2A11h2iCUsA9vKEny8AZQb
         q8B/TWYGWyGxCm5FaQ+/hcBLaL3ZRgOpU3bRoOMftfNRe3NWQfdg5lZ+y2yafXS/ji
         XWAdMzTEbOXRfyPr7qExxhIMhgVVNuh/wPPBvonLOdpijL/VaNfO6nQ1c7CfFdcbSi
         m+YpuNw8/OIhbFJhLU7V/3HOKI2ZB4QpvWm8WU6CWlb48QenC6Ydbo9/nqRVYyoGYU
         hO0ESdu5r09+xBo562rpeUe4ofDBHmn8MO+Z0Jc2xIJXlgBZUIVuBeRYlfV9TLvaEB
         9jSVUs6ePvZ0w==
Received: by mail-lj1-f174.google.com with SMTP id d8so13090790ljq.9;
        Mon, 06 Feb 2023 11:05:42 -0800 (PST)
X-Gm-Message-State: AO0yUKWfM0UBS0Cukenh/avCvKuLFsl59w+tbsnMUwFTIZ8wrXyewsOs
        Znsx5CFI2RtLV7KOB45OCndz7nfXnP4YAr7Y0j0=
X-Google-Smtp-Source: AK7set+HXYDDW3zPi0zgZoIPXl05ZC1BWwaQES58pTPQKZTH6/tzbUh0ffnK/hjwjVJ/cCre9HvY4YMqnAsdoWWHYus=
X-Received: by 2002:a2e:b5d1:0:b0:290:5f6d:ac18 with SMTP id
 g17-20020a2eb5d1000000b002905f6dac18mr37404ljn.23.1675710341007; Mon, 06 Feb
 2023 11:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com> <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com>
In-Reply-To: <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 6 Feb 2023 11:05:28 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5RiduusLJFTcj6p78aMsv7_XhepvptN7CG+9oV8oHSiA@mail.gmail.com>
Message-ID: <CAPhsuW5RiduusLJFTcj6p78aMsv7_XhepvptN7CG+9oV8oHSiA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 6, 2023 at 10:29 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
[...]
> >>> I should have added it in the commit description, actually we are
> >>> optimizing for "hot paths are less likely to have LSM hooks enabled"
> >>> (eg. socket_sendmsg).
> >> How did you come to that conclusion? Where is there a correlation between
> >> "hot path" and "less likely to be enabled"?
> > I could echo KP's reasoning here. AFAICT, the correlation is that LSMs on
> > hot path will give more performance overhead. In our use cases (Meta),
> > we are very careful with "small" performance hits. 0.25% is significant
> > overhead; 1% overhead will not fly without very good reasons (Do we
> > have to do this? Are there any other alternatives?). If it is possible to
> > achieve similar security on a different hook, we will not enable the hook on
> > the hot path. For example, we may not enable socket_sendmsg, but try
> > to disallow opening such sockets instead.
>
> I'm not asking about BPF. I'm asking about the impact on other LSMs.
> If you're talking strictly about BPF you need to say that. I'm all for
> performance improvement. But as I've said before, it should be for all
> the security modules, not just BPF.

I don't think anything here is BPF specific. Performance-security tradeoff
should be the same for all LSMs. A hook on the hot path is more expensive
than a hook on a cooler path. This is the same for all LSMs, no?

Thanks,
Song
