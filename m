Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD768EBF4
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 10:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBHJo7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 04:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBHJox (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 04:44:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3410F3
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 01:44:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o18so16127085wrj.3
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 01:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKSp1c1ETJ4dcX2RhKxgpppw7sRX5esvkLinwT+Fygk=;
        b=BbaML/FxCoWxe0Yyk2Ho3xyzrS5dZ9Xm9DsMq9IOFoAmy+1D9LRJsx0aK41VGPqVx4
         csdEqahoc3JsEhqN4xkbFXogEHDycohVYJfjH1Pr4MrVSbMf3xEdw+/tE4OqcBrGdfjz
         j+61qp2Us6+Dndp+YxWMEW3SwrxgHRukRf0ZL4BQcKCrBXh4HbV4fpk4c+y6FwsAfdmT
         3R053uAacL/rzjs6qOY3VKOnsJGNMp1kqX/r87wNKPDNVXC3kRPb3dvgaMCXd/OYQgA5
         +yCGWv3WX1G99A1CcW1Mi//4g/HN0llHiDSaYvoD4iWX+s1bxpNtkPxXjs2I17steSyq
         mQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKSp1c1ETJ4dcX2RhKxgpppw7sRX5esvkLinwT+Fygk=;
        b=wl/RDpRKTJkWyvXadPTsOW1mR0bX1+tYZYxV4v8Kdqvwo6a+jkJn3KRH3ckyIBAPg4
         byAA+TW/lDELJM5nKv4iPlPu6aWAXy06o+BGDkGxVPoS2fbkAc6u6qrtgJNJBKYPP/6h
         Ckz2/+nyY15byKfn5OWoKPwNAoxRPNBRDNSUqtwIAT3Qzjws/n2WxXNRmV0MkvPC61Mm
         y9mECRIR9Mi4OkUTlJfpK/sANCPzSK4W3m7ZMivG7TySkm+NYHBKnVCjdkqM7GGYTQl1
         cVecGhIKLBKHL/aRaIi3k3bGq6jCk7LAKZ5ZSNpR/6MACSAWqtaRTuvPP+275Y87Fsuh
         8qWg==
X-Gm-Message-State: AO0yUKV0hDGOix2D71BUO26K+W3TsC5sJw0il7tYvDkjnzdH1p3hL4FW
        QQa0EJ8gaSbtXbc9hnWqZB8=
X-Google-Smtp-Source: AK7set9l7Ir3aGO0tAm9zHwBJAtRBrQZCg+FotuPjuJKveUBILO1pOkMIbbUTv+bP/k1dOcUWXM1Fw==
X-Received: by 2002:a5d:5101:0:b0:2c3:ef74:602f with SMTP id s1-20020a5d5101000000b002c3ef74602fmr1346311wrt.55.1675849490151;
        Wed, 08 Feb 2023 01:44:50 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600002c700b002be5bdbe40csm14198182wry.27.2023.02.08.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:44:49 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Feb 2023 10:44:47 +0100
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
Subject: Re: [PATCHv3 bpf-next 3/9] selftests/bpf: Use only stdout in
 un/load_bpf_testmod functions
Message-ID: <Y+NvDzp5vVM5S1Sf@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-4-jolsa@kernel.org>
 <Y+JjIus7zdcEk2IZ@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+JjIus7zdcEk2IZ@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 07, 2023 at 08:41:38AM -0600, David Vernet wrote:
> On Fri, Feb 03, 2023 at 05:23:30PM +0100, Jiri Olsa wrote:
> > We are about to use un/load_bpf_testmod functions in couple tests
> > and it's better  to print output to stdout,  so it's aligned with
> > tests ASSERT macros output, which use stdout as well.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: David Vernet <void@manifault.com>
> 
> Should we remove FILE *stderr from struct test_env? Seems like it might
> be prudent if using it can actually cause a mismatch between testcase
> output and the test runner?

we still seem to use stderr in few places, not sure if it's
in the output hijack window.. I'll try to check

jirka

> 
> > ---
> >  tools/testing/selftests/bpf/testing_helpers.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> > index 3a9e7e8e5b14..fd22c64646fc 100644
> > --- a/tools/testing/selftests/bpf/testing_helpers.c
> > +++ b/tools/testing/selftests/bpf/testing_helpers.c
> > @@ -244,14 +244,14 @@ static int delete_module(const char *name, int flags)
> >  void unload_bpf_testmod(bool verbose)
> >  {
> >  	if (kern_sync_rcu())
> > -		fprintf(stderr, "Failed to trigger kernel-side RCU sync!\n");
> > +		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
> >  	if (delete_module("bpf_testmod", 0)) {
> >  		if (errno == ENOENT) {
> >  			if (verbose)
> >  				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> >  			return;
> >  		}
> > -		fprintf(stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> > +		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> >  		return;
> >  	}
> >  	if (verbose)
> > @@ -270,11 +270,11 @@ int load_bpf_testmod(bool verbose)
> >  
> >  	fd = open("bpf_testmod.ko", O_RDONLY);
> >  	if (fd < 0) {
> > -		fprintf(stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
> > +		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
> >  		return -ENOENT;
> >  	}
> >  	if (finit_module(fd, "", 0)) {
> > -		fprintf(stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
> > +		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
> >  		close(fd);
> >  		return -EINVAL;
> >  	}
> > -- 
> > 2.39.1
> > 
