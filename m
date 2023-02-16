Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61E69993D
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBPPur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 10:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBPPuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 10:50:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF94BE8B
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 07:50:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso2015900wmo.3
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeP8NIHB31eLNNVD7V5p2T4G+rfkWsHc004iIUmR4dI=;
        b=MrdM1U2le+A34P5xFE3QXcErpmOoXfE6ww/q4APO+JhQK15gl7pYRn9fboPjXv40Z8
         GSa4dtICETF+3TCXEa+jXw3r8h7oQ3s7LQMEqLpvZKiVaktcBV4Bbebnc4hyNzfmhCba
         e59p0hVnQVxM5kinkDBkyUbTs0OrmfwU96VfEJag0Ie8MQjRSFaX+X4tjRdCaWKtk1S4
         fTt+PAkAf0ur3ujwK1BCE4Wcbnm2LjsrJUmvRoyIg57QmyYQCL10xrQDCwHTgpSR69Nt
         WdWBahfQOpx+uBhZtE9cdL68v74d49PCG30rpjg11pK8m3PI9u3oBEERie8Oykev2Xf0
         TXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeP8NIHB31eLNNVD7V5p2T4G+rfkWsHc004iIUmR4dI=;
        b=Vosnwf4Tv6zYENakuWPYBhbj5d7ChovtPVTIe/1pjBJATdjcff4F0k/YISjtWUdckP
         AY7IMgeA6TL9oEfTQshk+9EGUkp06uEQh8mpji0LfGrvcxmmd9Wxq31DMfF5AgllQMhW
         NY3acDjLprqWv0fCEqizmzMZwr7gYjq/Hv7vN3difleyNpo5HjHffPHHDpriOCYsgY4c
         KKBS33mcJ5MJWEatI6LK6pUh6L05lVO0De3QSnWpvBbUFiqKWi+gzqBQ7rTTiUqdqaRl
         55T+vns1cS5T8S7VHjYbptT6lzIM7NXq8QQyx9johO8r6WFuS0P2BjfvPAQ3BxPFHI5U
         s3mw==
X-Gm-Message-State: AO0yUKUHZeZafKncaK1uLboR1l08CTutsCJ02h/vyiwH00SH1bvkskU8
        d+BgxQAWPlwJ/Fp1TcEHqAc=
X-Google-Smtp-Source: AK7set8pig8ZpGg1ARDEEQ5I6X7mmMcIK7G7T94Ln/uRcP3HusWxUqvKQp7qt5MXNM/Ju3Vx+nDuZQ==
X-Received: by 2002:a05:600c:1817:b0:3df:e472:fe03 with SMTP id n23-20020a05600c181700b003dfe472fe03mr6241296wmp.30.1676562644130;
        Thu, 16 Feb 2023 07:50:44 -0800 (PST)
Received: from krava ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id bd27-20020a05600c1f1b00b003e20cf0408esm2136335wmb.40.2023.02.16.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:50:43 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 16 Feb 2023 16:50:41 +0100
To:     Viktor Malik <vmalik@redhat.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <Y+5Q0UK09HsxM4ht@krava>
References: <cover.1676542796.git.vmalik@redhat.com>
 <e627742ab86ed28632bc9b6c56ef65d7f98eadbc.1676542796.git.vmalik@redhat.com>
 <Y+40os27pQ8det/o@krava>
 <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1992d09a-0ef8-66e3-1da0-5d13c2fecc3d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 03:45:11PM +0100, Viktor Malik wrote:

SNIP

> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 388245e8826e..6a19bd450558 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -24,6 +24,7 @@
> > >   #include <linux/bpf_lsm.h>
> > >   #include <linux/btf_ids.h>
> > >   #include <linux/poison.h>
> > > +#include "../module/internal.h"
> > >   #include "disasm.h"
> > > @@ -16868,6 +16869,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >   	const char *tname;
> > >   	struct btf *btf;
> > >   	long addr = 0;
> > > +	struct module *mod = NULL;
> > >   	if (!btf_id) {
> > >   		bpf_log(log, "Tracing programs must provide btf_id\n");
> > > @@ -17041,7 +17043,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >   			else
> > >   				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
> > >   		} else {
> > > -			addr = kallsyms_lookup_name(tname);
> > > +			if (btf_is_module(btf)) {
> > > +				preempt_disable();
> > 
> > btf_try_get_module takes mutex, so you can't preempt_disable in here,
> > I got this when running the test:
> > 
> > [  691.916989][ T2585] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
> > 
> 
> Hm, do we even need to preempt_disable? IIUC, preempt_disable is used
> in module kallsyms to prevent taking the module lock b/c kallsyms are
> used in the oops path. That shouldn't be an issue here, is that correct?

btf_try_get_module calls try_module_get which disables the preemption,
so no need to call it in here

jirka

> 
> > > +				mod = btf_try_get_module(btf);
> > > +				if (mod)
> > > +					addr = find_kallsyms_symbol_value(mod, tname);
> > > +				else
> > > +					addr = 0;
> > > +				preempt_enable();
> > > +			} else {
> > > +				addr = kallsyms_lookup_name(tname);
> > > +			}
> > >   			if (!addr) {
> > >   				bpf_log(log,
> > >   					"The address of function %s cannot be found\n",
> > > @@ -17105,6 +17117,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >   	tgt_info->tgt_addr = addr;
> > >   	tgt_info->tgt_name = tname;
> > >   	tgt_info->tgt_type = t;
> > > +	if (mod) {
> > > +		if (!prog->aux->mod)
> > > +			prog->aux->mod = mod;
> > 
> > can this actually happen? would it be better to have bpf_check_attach_target
> > just to take take the module ref and return it in tgt_info->tgt_mod and it'd
> > be up to caller to decide what to do with that
> 
> Ok, I'll try to do it that way.
> 
> Thanks for the review!
> Viktor
> 
> > 
> > thanks,
> > jirka
> > 
> > > +		else
> > > +			module_put(mod);
> > > +	}
> > >   	return 0;
> > >   }
> > > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > > index 2e2bf236f558..5cb103a46018 100644
> > > --- a/kernel/module/internal.h
> > > +++ b/kernel/module/internal.h
> > > @@ -256,6 +256,11 @@ static inline bool sect_empty(const Elf_Shdr *sect)
> > >   static inline void init_build_id(struct module *mod, const struct load_info *info) { }
> > >   static inline void layout_symtab(struct module *mod, struct load_info *info) { }
> > >   static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
> > > +static inline unsigned long find_kallsyms_symbol_value(struct module *mod
> > > +						       const char *name)
> > > +{
> > > +	return 0;
> > > +}
> > >   #endif /* CONFIG_KALLSYMS */
> > >   #ifdef CONFIG_SYSFS
> > > -- 
> > > 2.39.1
> > > 
> > 
> 
