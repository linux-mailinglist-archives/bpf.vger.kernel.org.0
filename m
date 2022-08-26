Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC855A28D9
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 15:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiHZNwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 09:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiHZNwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 09:52:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88705DCFEC;
        Fri, 26 Aug 2022 06:52:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cu2so3361729ejb.0;
        Fri, 26 Aug 2022 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Of/YsPo3VIwZYf98NnfyZslEcJYVsOFUlwkO9ytzjcU=;
        b=QGxR2oOKM07QZbuhFeW2gItQgkUUM8yWwqvEpFsunvj9lmZNF7x3JJbRz0M7dstOxJ
         bVxn0QB7IS/ittCj6QTOAqNJZT08zTMEEEqjuGL/J20Mh2AJ64Y5OmYr7RBVgI/BtU7U
         CEurqAV9QgfpalwP3QACuCbU8mXDNkz6EBjgCG0TbZEx62kjnLLsAkcUr6iGKXw4BUzD
         ryauIYCIacj974frJVliulyL6X8G8O9ZH8PFF3/q8SKKop/XQ/2bH1CiqvXTra4vRj9r
         N8x7OOnf9LITI7ASdbPItFMMSKdXJA2LaIIsAYE4ss2qOzqm2hAYRGqVQnkYiLJRCn9R
         wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Of/YsPo3VIwZYf98NnfyZslEcJYVsOFUlwkO9ytzjcU=;
        b=nTQgHkQ1RHGiZDFT8qLACY3qjMBpj7w+ZBUDLRZY+fZeoZzyzfHn18c5JgPOZOI8nl
         M9x61MDfvrM6r71Jz+HJHfMVjRR97Fu5JSeTe7zXKhksx9pEwPV9eEWw4JbjF4pBnaMm
         MwWV3jXSZ9vFh/eyomwEpDEJfJbVgcuvTDJVC7qUzoIjhV5FD4VjmgsKnsAPFDkDHlQu
         RmeMaPZH5selb+TQgcY1NqsqFmqyMEReI6RQnnSUZDu2oyKVWxlLzbLaMfox6hQCaWOt
         oviN1WDKvIGGHCjZUZg9GxaVhXosAyIQvxRfvD3wzXZfekIC0PZ8jBzdP+Pk0iq446D+
         HM5w==
X-Gm-Message-State: ACgBeo1yJaOw23o0KlIJvxyZd7vOw595xa/gyeH0ghxaH+O6hDII8Zlp
        9aUnk9SLxA90gmuw51hS0TE=
X-Google-Smtp-Source: AA6agR7ZtXe7Be0tK36oRSPbIPSQfqpvBHEds5YVy3E5v31PJZOBDc81t0SVZ9xfkf7h/G9lnxq/cg==
X-Received: by 2002:a17:906:9b8b:b0:732:d464:92ea with SMTP id dd11-20020a1709069b8b00b00732d46492eamr5643923ejc.3.1661521935653;
        Fri, 26 Aug 2022 06:52:15 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id v25-20020a056402175900b004462849aa06sm1339606edx.5.2022.08.26.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 06:52:15 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 26 Aug 2022 15:52:12 +0200
To:     Vitaly Chikunov <vt@altlinux.org>, Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <YwjQDBovX+cX/JDJ@krava>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826025944.hd7htqqwljhse6ht@altlinux.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
> On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
> > Arnaldo,
> > 
> > On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
> > > On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > >
> > > > > I also noticed that after upgrading pahole to v1.24 kernel build (tested on
> > > > > v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
> > > > >
> > > > >     BTFIDS  vmlinux
> > > > >   + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > >   FAILED: load BTF from vmlinux: Invalid argument
> > > > >
> > > > > Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
> > > > > v1.23 resolves the issue.
> > > > >
> > > > 
> > > > Can you try this, from Martin Reboredo (Archlinux):
> > > > 
> > > > Can you try a build of the kernel or the by passing the
> > > > --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> > > > 
> > > > Here's a patch for either in tree scripts/pahole-flags.sh or
> > > > /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
> > > 
> > > This patch helped and kernel builds successfully after applying it.
> > > (Didn't notice this suggestion in release discussion thread.)
> > 
> > Even thought it now compiles with this patch, it does not boot
> > afterwards (in virtme-like env), witch such console messages:
> 
> I'm talking here about 5.15.62. Yes, proposed patch does not apply there
> (since there is no `scripts/pahole-flags.sh`), but I updated
> `scripts/link-vmlinux.sh` with the similar `if` to append
> `--skip_encoding_btf_enum64` which lets then compilation pass.
> 
> Thanks,
> 
> > 
> >   [    0.767649] Run /init as init process
> >   [    0.770858] BPF:[593] ENUM perf_event_task_context
> >   [    0.771262] BPF:size=4 vlen=4
> >   [    0.771511] BPF:
> >   [    0.771680] BPF:Invalid btf_info kind_flag
> >   [    0.772016] BPF:

I can see the same on 5.15, it looks like the libbpf change that
pahole is compiled with is setting the type's kflag for values < 0:
(which is the case for perf_event_task_context enum first value)

  dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API

but IIUC kflag should stay zero for normal enum otherwise the btf meta
verifier screams

if I compile pahole with the libbpf change below I can boot 5.15 kernel
normally

Yonghong, any idea?

thanks,
jirka


---
diff --git a/src/btf.c b/src/btf.c
index 2d14f1a52d7a..53d7516e4b89 100644
--- a/src/btf.c
+++ b/src/btf.c
@@ -2151,10 +2151,6 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 	t = btf_last_type(btf);
 	btf_type_inc_vlen(t);
 
-	/* if negative value, set signedness to signed */
-	if (value < 0)
-		t->info = btf_type_info(btf_kind(t), btf_vlen(t), true);
-
 	btf->hdr->type_len += sz;
 	btf->hdr->str_off += sz;
 	return 0;
