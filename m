Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74868EB8D
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 10:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBHJfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 04:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBHJfq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 04:35:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F759C7
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 01:35:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so2111633wmp.1
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 01:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBP52ZyEXZ5E4Wi4vfFAQAoDz8o9VqYxyAvOazs4Wh4=;
        b=WtN2GHEWJJ5KrHTW5Vo723vtDJ+9ZJ/mlW+jo9V+CI78RBDiOmJ02fgq3+7rISNi4E
         1epUSA8y5WFs5t6uBKg989OgVqehrYewJj7Arj4qJF+oa0nWDzeer7ToCWq157pS5nLl
         TH1LoDm+v6ab2iz3oTJzm/azI+FaFZR9jCyojXhTFRxKrlOAgTae0U+C1CQW3KzUtW6b
         HXAD1JHQR/xMZUTJfZ2BGVRUxgsv7SyB2NPhMIpuMJqG9Tn8/vFNE7MsBdLquR/F638o
         e5hCf4avcMPVYij2wnpoAsAYJoTdc2rJA6zG4KY4qSb0byGs99WYXlj/p/OfwMrDeh2h
         Wvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBP52ZyEXZ5E4Wi4vfFAQAoDz8o9VqYxyAvOazs4Wh4=;
        b=KFOsSiu7eyrCb87J9MPfUK44XBRQml+AqfcGL8uhmC/ky7d+KOnUd8bs4d/gMQQVom
         X37ecVod1KIXpQJmv2jibUAxXav6wvxLN5oeD9ZFVZUmQ1+mmD45X/7zw8d8gEQ2EKnp
         DMX5bNspFxuv4/3nDWB64jn0UPnxDMjFoXBlfarfvRcZTuQHDjhfdi026kedSxeLE13x
         IpisRbfE7J1N8VZtM0nFC5xz8HNhwGZR+6qln+Og0hI0uYTvsRFx0WVwIXB9VYbDX02N
         qCy360jz3qi1MxvHIOecACMMrAeDhFnnIVvR5YjcBZFlPhOSdWaxiLIylY/VYdL47hlK
         WEfA==
X-Gm-Message-State: AO0yUKXPsauM55UN2101HwtcLiDY+K3JTt9WYRfPNHXyg0WhY0KISHNs
        iiBZ+XDxITGEmxWF3Oj9fOI=
X-Google-Smtp-Source: AK7set9Mu24xEZizmF4W2owsSOoE+jNP6wJJVPme8ZcYmZlLGkms9cJj6HODKLKd/LPAS801EcDu+g==
X-Received: by 2002:a05:600c:4483:b0:3d3:49db:9b25 with SMTP id e3-20020a05600c448300b003d349db9b25mr5947123wmo.26.1675848930914;
        Wed, 08 Feb 2023 01:35:30 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003dc522dd25esm1427549wmq.30.2023.02.08.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:35:30 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Feb 2023 10:35:28 +0100
To:     David Vernet <void@manifault.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCHv3 bpf-next 2/9] selftests/bpf: Move test_progs helpers to
 testing_helpers object
Message-ID: <Y+Ns4DHVv758IjkT@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-3-jolsa@kernel.org>
 <Y+JiUQFyalc0aV6M@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+JiUQFyalc0aV6M@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 07, 2023 at 08:38:09AM -0600, David Vernet wrote:
> On Fri, Feb 03, 2023 at 05:23:29PM +0100, Jiri Olsa wrote:
> > Moving test_progs helpers to testing_helpers object so they can be
> > used from test_verifier in following changes.
> > 
> > Also adding missing ifndef header guard to testing_helpers.h header.
> > 
> > Using stderr instead of env.stderr because un/load_bpf_testmod helpers
> > will be used outside test_progs. Also at the point of calling them
> > in test_progs the std files are not hijacked yet and stderr is the
> > same as env.stderr.
> 
> Makes sense. Possibly something to clean up at another time but given
> that we were being inconsistent with env.stdout and env.stderr in
> load_bpf_testmod() in the first place, this seems totally fine.

ok

> 
> Acked-by: David Vernet <void@manifault.com>
> 
> Left one question about kern_sync_rcu() below that need not block this
> patch series, and can be addressed in a follow-up if it's even relevant.

SNIP

> > +void unload_bpf_testmod(bool verbose)
> > +{
> > +	if (kern_sync_rcu())
> > +		fprintf(stderr, "Failed to trigger kernel-side RCU sync!\n");
> 
> I realize there's no behavior change here, but out of curiosity, do you
> know why we need a synchronize_rcu() here? In general this feels kind of
> sketchy, and like something we should just put in bpf_testmod_exit() if
> it's really needed for something in the kernel.

it's explained in here:

635599bace25 selftests/bpf: Sync RCU before unloading bpf_testmod

    If some of the subtests use module BTFs through ksyms, they will cause
    bpf_prog to take a refcount on bpf_testmod module, which will prevent it from
    successfully unloading. Module's refcnt is decremented when bpf_prog is freed,
    which generally happens in RCU callback. So we need to trigger
    syncronize_rcu() in the kernel, which can be achieved nicely with
    membarrier(MEMBARRIER_CMD_SHARED) or membarrier(MEMBARRIER_CMD_GLOBAL) syscall.
    So do that in kernel_sync_rcu() and make it available to other test inside the
    test_progs. This synchronize_rcu() is called before attempting to unload
    bpf_testmod.

jirka

> 
> > +	if (delete_module("bpf_testmod", 0)) {
> > +		if (errno == ENOENT) {
> > +			if (verbose)
> > +				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> > +			return;
> > +		}
> > +		fprintf(stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> > +		return;
> > +	}
> > +	if (verbose)
> > +		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> > +}
> > +

SNIP
