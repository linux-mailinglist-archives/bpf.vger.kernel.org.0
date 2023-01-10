Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CD664215
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 14:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjAJNjk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 08:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbjAJNjQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 08:39:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8147D9F5;
        Tue, 10 Jan 2023 05:39:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w1so11776207wrt.8;
        Tue, 10 Jan 2023 05:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVIO+JvYs740qnGHN0LmIx/dtTVP82NXXYc0r6pcMqU=;
        b=gvlB5Fp+jjyI37k1TEYFeIvwqw1/aeB6VM/UNQUJcaTEapGc1BZvNRoV9JhQ9fC4Ql
         Jf151ALTmdNoLzdRzA+TFhBd1GyrL7txJNpEwEC3pz8oLq3zUpEFDtGd9RW5/6SLVfzy
         CeP/epbAGzhBd5hp/Ct57/r0ptTlaWTrLhBFp9KEJ+I/K7S2gzFnOEsDO/gTpwCXKLoc
         Qj9LaxTC5X0Ot0fMQtuP4VeIPJ5vW0qYsobQdAIj1tbNjneqRSOzQ4npqmN6JBUuxOhD
         IFELKHUrNIOI29eGnWiCOTQ2a0mGajGkzYPqvy00Sn/gQWTvA5DYptEYxw49LhRc0f3p
         +cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVIO+JvYs740qnGHN0LmIx/dtTVP82NXXYc0r6pcMqU=;
        b=Di7n2aHavGuHHpCydVRnCxkqgnDQCQYSNwTgCvMU82Lrsg1qv9hJi1s+jVy+NeVVvu
         9PsKrFEVZS9Z/8gBM7CN1dFWEs++qiDTOuNktKwEVB5Ff8U0ZbhqFQZUjkbxc5sUUYcI
         ilYKl6/B7oJqYcy6P24FWiV195hdn4BDjQBHzzxoc5e1RKFIAV2NICeF5UIs56zABwZe
         eRpSoUrj106/6NHWJNksERnQdLDNUMbdGKnm+YZOGN5lSQfrGIhv97WL+L72wBAKwlTl
         hu0Su778DeajC+LZzgmrYpaTnMZMb6l3ZS6qpgijbtvGrNbs+H7X2ACSB8y57rZs+Twl
         XW/w==
X-Gm-Message-State: AFqh2ko7CLUKOz2iFBsUJwFDBQ74RNAqQgUp5Sx7EroiNcS2uzlzIbDB
        R2Yh6ZAo3Ya2I04S5BUBxJ8=
X-Google-Smtp-Source: AMrXdXsheiNUTquT8VC/SJbdWmWI5pTpQqzPw2h5ioIB8OoB6RglXeph8VftbKXAzMpF5AFBp5sTkQ==
X-Received: by 2002:a05:6000:1e11:b0:2bb:366b:d5e1 with SMTP id bj17-20020a0560001e1100b002bb366bd5e1mr11594485wrb.30.1673357951477;
        Tue, 10 Jan 2023 05:39:11 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d62c7000000b002bbeda3809csm5729430wrv.11.2023.01.10.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:39:11 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 10 Jan 2023 14:39:08 +0100
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y71qfFoQp6AR8K6D@krava>
References: <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org>
 <Y7xYimp0h4YT72/N@krava>
 <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
 <CAP-5=fVtMEahrPMJNVOqsZGj-GoTxUnWsdzK7M+9F2+DhG_STQ@mail.gmail.com>
 <Y71J2WpaMtked02+@krava>
 <Y71pl/6yrhIWjYOe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71pl/6yrhIWjYOe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 10, 2023 at 10:35:19AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 10, 2023 at 12:19:53PM +0100, Jiri Olsa escreveu:
> > On Mon, Jan 09, 2023 at 11:34:44AM -0800, Ian Rogers wrote:
> > > Oh, just to note. While failing the feature test is disappointing for
> > > a libbpf that isn't very old, we have the newer libbpf to statically
> > > build in. Developers won't be impacted due to the static route. If you
> > > are a distro maintainer, you should just update your libbpf. So we
> > > could just bump the API assumption to 1.0 as I believe that'd have the
> > > advantage of removing feature tests, workarounds, untested code (like
> > > what broke here), etc.
> 
> > > What do you think?
>  
> > yes, seems good.. fedora has libbpf 1.0 already so should not be problem
> > there at least ;-)
> 
> So, I already pushed 1/2 to perf/urgent, can I stick an Acked-by: jolsa
> to the second?

yes

jirka
