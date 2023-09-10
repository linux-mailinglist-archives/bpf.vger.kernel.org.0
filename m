Return-Path: <bpf+bounces-9613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077AF799F5D
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 20:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886BD281071
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036E2881F;
	Sun, 10 Sep 2023 18:54:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4B8469
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:54:13 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3918F
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 11:54:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-403061cdf2bso10625665e9.2
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694372050; x=1694976850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXnkyCJMNVf6M2UxuN74u/5ZjiW+NW+/xo8dH7U1SPQ=;
        b=mXb5IAr1CBnr7scvkKj+D11sfvqLRkdIJQh7L0LBOLJPGbqdiNHB8Zd/YXbpGGP2t+
         EuBHjIdNNiB843VWvgc2TXoHdVs17yqvGkqJiQhTC3JBKodxvIGGQGlm8xGUMZ/YzODw
         XgVKAveGp5vk8YdPbb2oQirMLzveiIDKy4IxYyVH7hU2SWs6sa4/lBQYIPyLyjjJpmNc
         eWj6osgKDbnIK0ca4gSb6M6/Iui7NwS9fHgit3XCF4RH9g+GWF8fojZjEQT2oPLHGc7a
         5puVjnCBA83L88SagAlSXVIAcoZ1oB3wpMCOonmF9ZecgS9r6heM8ApTIHi1DGWNQG3u
         whjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694372050; x=1694976850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXnkyCJMNVf6M2UxuN74u/5ZjiW+NW+/xo8dH7U1SPQ=;
        b=MXfIr17Pta8qEPgvpd/iDJ1mH0lXCkqYwJsCYLa//I2dz8fb6a1rI3gW3NkuWkT9iI
         FQyY4N2kc1ruCVgYC9y3P/IOQWO0VJb1l5e6SeCPphoJEZSaIB2CAoOnXZrOf74z2XdD
         JRrzq7QzBvfZjTNQzc8W4CnPoNwMAQgAAFe322CSl3dorXPclNm6UH//A3Qh4a4AtMJx
         MvIFgGQx0CgS0yGElGVcdAaNrghSPkOzWQgOCsMC/CqfhgHcqTI1Y7iy1Ti0UejQ4qwx
         jT2CrRnok56LX5F19x8uuvqhhDbOYzYG+fDq4uts39liW+WFkrw675duDn7CyNGSELXm
         AC2w==
X-Gm-Message-State: AOJu0YyQ0zz1bjhffqq+KmbFm2ML+dJUvuQHKsm7blq0+f4JOamyWLIZ
	U8TmhWTSYeJg1YQZbFJ6kBs=
X-Google-Smtp-Source: AGHT+IHR5kA6mFvIYqy5l3w8UjUrTwtnFO2q8rL7fTe2xoWgXjsi8y1GdXLmboYnwV/5QwIbdVSfEg==
X-Received: by 2002:a05:600c:d5:b0:400:419c:bbde with SMTP id u21-20020a05600c00d500b00400419cbbdemr7164077wmm.18.1694372049483;
        Sun, 10 Sep 2023 11:54:09 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id o8-20020a1c7508000000b003fed7fa6c00sm11200635wmc.7.2023.09.10.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:54:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 10 Sep 2023 20:54:06 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCHv2 bpf-next 7/9] selftests/bpf: Add test for missed counts
 of perf event link kprobe
Message-ID: <ZP4Qzo5O1mQTurJ4@krava>
References: <20230907071311.254313-1-jolsa@kernel.org>
 <20230907071311.254313-8-jolsa@kernel.org>
 <CAEf4BzZwqq73Gj9pr9A52E2fXbm_Pn+oXX7qmTzw8hEuikK3kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZwqq73Gj9pr9A52E2fXbm_Pn+oXX7qmTzw8hEuikK3kw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 04:25:30PM -0700, Andrii Nakryiko wrote:

SNIP

> > +/*
> > + * Putting kprobe on bpf_fentry_test1 that calls bpf_kfunc_common_test
> > + * kfunc, which has also kprobe on. The latter won't get triggered due
> > + * to kprobe recursion check and kprobe missed counter is incremented.
> > + */
> > +static void test_missed_perf_kprobe(void)
> > +{
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +       struct bpf_link_info info = {};
> > +       struct missed_kprobe *skel;
> > +       __u32 len = sizeof(info);
> > +       int err, prog_fd;
> > +
> > +       skel = missed_kprobe__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "missed_kprobe__open_and_load"))
> > +               goto cleanup;
> > +
> > +       err = missed_kprobe__attach(skel);
> > +       if (!ASSERT_OK(err, "missed_kprobe__attach"))
> > +               goto cleanup;
> > +
> > +       prog_fd = bpf_program__fd(skel->progs.trigger);
> > +       err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +       ASSERT_OK(err, "test_run");
> > +       ASSERT_EQ(topts.retval, 0, "test_run");
> > +
> > +       err = bpf_link_get_info_by_fd(bpf_link__fd(skel->links.test2), &info, &len);
> > +       if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
> > +               goto cleanup;
> > +
> > +       ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "info.type");
> > +       ASSERT_EQ(info.perf_event.type, BPF_PERF_EVENT_KPROBE, "info.perf_event.type");
> > +       ASSERT_EQ(info.perf_event.kprobe.missed, 1, "info.perf_event.kprobe.missed");
> > +
> > +cleanup:
> > +       missed_kprobe__destroy(skel);
> > +}
> > +
> > +void serial_test_missed(void)
> 
> why serial? if you check for kprobe.missed >= 1, it should be fine
> even if some other test calls this testmod kfunc, right?

hm, I think the reason for me was the testmod getting unloaded
in serial_test_bpf_mod_race test.. but it's serial, so I guess
we should be fine

thanks,
jirka

