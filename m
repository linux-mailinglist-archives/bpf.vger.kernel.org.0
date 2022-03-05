Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B044CE4E1
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiCEMps (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 07:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCEMps (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 07:45:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B431CC7FD
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 04:44:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so22766150ejc.7
        for <bpf@vger.kernel.org>; Sat, 05 Mar 2022 04:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BT/LruK1iU2aEC5IUz8FPhJu685NPizXKAEkqmR3dME=;
        b=NCg8APlFjOE9h2Y+o0xCxjR53+eJdRZt2fXOBbgWJSvktNhRw3C0497CUkWnxANB58
         KdFCGAHfMJ5yt/2zCG8WuUoe7Qe9cuvh9vHK/MWUDStWeBo9DHInYqhfxIXZjiFjusyP
         MZyUM99kZ6KlWhIe8IWyD52SDtMIYajjj3V67bLn1Cx4ZZp/jq6ixlhAsielV4TDA9iS
         CdCLCs+qMoCqCMMWy9uDJaCHhY10MbeVIuf5a9ftZSkFMkN3r88H02UFIg3HHtFEcwX2
         02T2CkiKX6/wnL8quj1fWokjkONEJWBW4qrD0nhum/e5olQGP720XMMFLA3sz1LLMSdc
         CQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BT/LruK1iU2aEC5IUz8FPhJu685NPizXKAEkqmR3dME=;
        b=ZZDQ2Wz4g6LcY5bwRpbbg3TCWt29XeoXmY9WVZp/DI6fGjCbfShxfBFa8vXamQAdtQ
         q9uRMww3cl8Lh47mh6yyDZH7+cYgv0zS+CdkkWeSSxISJmqHG570BBE2VPvxlBSdmMcU
         sTvW5Zq3CFKGiS3Qcws1OwYYTfF0V56u+IQ/cUKqxPSmRiNaya4C1ugSeQXwr1wIq2Cp
         3iLeVg0pM8/8IDKuO3WX0Kxo+0z939gaZKA2coRGQBzbZ9A+ZGhyM6Lf+BK63xW6IZHW
         QxnBNorjGiZT7r7yCboyn2fUTNuRv9EMBVo+sLXO4ONytj27nZhQfD7cV4K/6gtN5TU2
         aH1g==
X-Gm-Message-State: AOAM531n/5wmqbR9eP312aGvOTsu4lLpQ6y0FDPyY8dUBp1rX0pwuV4H
        lovdLXtV8Ay/cVnuyX1ABuY53c3EpLk=
X-Google-Smtp-Source: ABdhPJzVzsYirWXwuBS697QmDrsV2kQ/Y5KjYJ28++zhVK0pkrjsnyMLSVzKPixsXkaqZJrP8zf4rA==
X-Received: by 2002:a17:907:7ea3:b0:6d9:4406:6029 with SMTP id qb35-20020a1709077ea300b006d944066029mr2837442ejc.262.1646484294423;
        Sat, 05 Mar 2022 04:44:54 -0800 (PST)
Received: from erthalion.local (dslb-178-005-230-047.178.005.pools.vodafone-ip.de. [178.5.230.47])
        by smtp.gmail.com with ESMTPSA id sb31-20020a1709076d9f00b006ceb969822esm2816355ejc.76.2022.03.05.04.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 04:44:53 -0800 (PST)
Date:   Sat, 5 Mar 2022 13:44:26 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
Subject: Re: [PATCH bpf-next v5] bpftool: Add bpf_cookie to link output
Message-ID: <20220305124426.qodif327pima6rqj@erthalion.local>
References: <20220304143610.10796-1-9erthalion6@gmail.com>
 <acf30143-dc2c-9651-44b6-af45a1c426ce@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf30143-dc2c-9651-44b6-af45a1c426ce@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 04, 2022 at 08:21:34AM -0800, Yonghong Song wrote:
>
> > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > index 7c384d10e95f..6c6e7c90cc3d 100644
> > --- a/tools/bpf/bpftool/pids.c
> > +++ b/tools/bpf/bpftool/pids.c
> > @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
> >   	ref->pid = e->pid;
> >   	memcpy(ref->comm, e->comm, sizeof(ref->comm));
> >   	refs->ref_cnt = 1;
> > +	refs->bpf_cookie_set = e->bpf_cookie_set;
> > +	refs->bpf_cookie = e->bpf_cookie;
> >   	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
> >   	if (err)
> > @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
> >   		if (refs->ref_cnt == 0)
> >   			break;
> > +		if (refs->bpf_cookie_set)
> > +			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
>
> The original motivation for 'bpf_cookie' is for kprobe to get function
> addresses. In that case, printing with llx (0x...) is better than llu
> since people can easily search it with /proc/kallsyms to get what the
> function it attached to. But on the other hand, other use cases might
> be simply just wanting an int.
>
> I don't have a strong opinion here. Just to speak out loud so other
> people can comment on this too.

Interesting, I didn't know that. The current implementation of
'bpf_cookie' seems to be quite opaque, with no assumptions about what
does it contain, probably it makes sense to keep it like that. But I
don't have a strong opinion here either, would love to hear what others
think.

> > diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> > index f70702fcb224..91366ce33717 100644
> > --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> > +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> > @@ -38,6 +38,18 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
> >   	}
> >   }
> > +/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
> > +static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)
> > +{
> > +	struct bpf_perf_link *perf_link;
> > +	struct perf_event *event;
> > +
> > +	perf_link = container_of(link, struct bpf_perf_link, link);
> > +	event = BPF_CORE_READ(perf_link, perf_file, private_data);
> > +	return BPF_CORE_READ(event, bpf_cookie);
> > +}
> > +
> > +
> >   SEC("iter/task_file")
> >   int iter(struct bpf_iter__task_file *ctx)
> >   {
> > @@ -69,8 +81,21 @@ int iter(struct bpf_iter__task_file *ctx)
> >   	if (file->f_op != fops)
> >   		return 0;
> > +	__builtin_memset(&e, 0, sizeof(e));
> >   	e.pid = task->tgid;
> >   	e.id = get_obj_id(file->private_data, obj_type);
> > +	e.bpf_cookie = 0;
> > +	e.bpf_cookie_set = false;
>
> We already have __builtin_memset(&e, 0, sizeof(e)) in the above, so
> the above e.bpf_cookie and e.bpf_cookie_set assignment is not
> necessary.

Good point, will remote this.
