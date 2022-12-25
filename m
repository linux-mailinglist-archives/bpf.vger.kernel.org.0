Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E83655D5B
	for <lists+bpf@lfdr.de>; Sun, 25 Dec 2022 15:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLYONn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Dec 2022 09:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLYONm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Dec 2022 09:13:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7FF6265
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 06:13:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m19so12982180edj.8
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2rSsx9VFe4aYwI1HrN2O4MeeohSAZRYLVM211quD+k=;
        b=ITX+plpLI1fCTNVr7r2I1HtN2Uv7cV8S6aIoF8c37NEHVBU7P9WNcP1Fr9hF0WhBzd
         T1fS0eohj5EzQOj9zJpB4YXAI9+zfdvG//v0eTOfldHujn6cSFKNDnoSf5CIGRMIk8Vs
         SqGKLQqq/A4Q2hqr0nhgp0xt1RhTett30/nfRdOtUE0jSHBn/9e3Qo7H7ewMhD0Y+0ib
         3RyZADRurcZb25HlclEM9YyXYdGmlOidqeys4Y62PdLMEWcq+iTHHIG4KTydk0c+qt2X
         wnqw+QGqNOrL+HYIpLB3ZM8TVxA/H89c4zDRvVSKOYDBpFfcUxESqz0DHR9dReFQ+HjJ
         RoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2rSsx9VFe4aYwI1HrN2O4MeeohSAZRYLVM211quD+k=;
        b=LTgCD2c75k3RVS4GV82VtIKklzfGEUv8sUlOasdWzCJzHLnbDmwn2IVTgvXgFjx6xp
         GpJ1ioQpholLt0u9p6/munec2uI2SWCIcz+RIEoQLJ/MX2pIywGCENllFgpfEX53mpLW
         cIurgni6HJq3YJgRfT3YwhNChWNYHpi8UWVzkaXrbo35dia58kuuXczplbT5sFsZnNBR
         /nuRw78MNk4rT0bGb4MyWiFwCW342PRqeojlj4SQknWC4GxWm2J7IDYIWvvnTrKb0OLu
         tf74g2tkNGvcJyRiuzp71WnYebWTHU4JTslFK/88HtCk8MpIgC4VPoVv8bx8c0Gy2bJF
         tG3A==
X-Gm-Message-State: AFqh2kpvG6UsThIAursuFNGkvRZww83Z13TRTwpnjqXXd1pb3L4Kh4Uy
        cnahSZkOUPwv5oDZVnmkIbkiI7j00tA=
X-Google-Smtp-Source: AMrXdXt3RMxcNS3pAtWFoX1Hfvg1EYirI0RMJtNA14w9hrpkKJe7L41qzkHWTkJ1c6vYW9JISi1aMQ==
X-Received: by 2002:a05:6402:1218:b0:475:32d2:74a6 with SMTP id c24-20020a056402121800b0047532d274a6mr17385247edw.11.1671977619786;
        Sun, 25 Dec 2022 06:13:39 -0800 (PST)
Received: from krava ([83.240.62.89])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402070f00b004704658abebsm3637288edx.54.2022.12.25.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 06:13:39 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 25 Dec 2022 15:13:37 +0100
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
Message-ID: <Y6hakaFw+Oph7xmB@krava>
References: <20221223185531.222689-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223185531.222689-1-paul@paul-moore.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 23, 2022 at 01:55:31PM -0500, Paul Moore wrote:

SNIP

> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> index 50854265864d..2795f03f5f34 100644
> --- a/drivers/net/netdevsim/bpf.c
> +++ b/drivers/net/netdevsim/bpf.c
> @@ -109,7 +109,7 @@ nsim_bpf_offload(struct netdevsim *ns, struct bpf_prog *prog, bool oldprog)
>  	     "bad offload state, expected offload %sto be active",
>  	     oldprog ? "" : "not ");
>  	ns->bpf_offloaded = prog;
> -	ns->bpf_offloaded_id = prog ? prog->aux->id : 0;
> +	ns->bpf_offloaded_id = prog ? bpf_prog_get_id(prog) : 0;
>  	nsim_prog_set_loaded(prog, true);
>  
>  	return 0;
> @@ -221,6 +221,7 @@ static int nsim_bpf_create_prog(struct nsim_dev *nsim_dev,
>  	struct nsim_bpf_bound_prog *state;
>  	char name[16];
>  	int ret;
> +	u32 id;
>  
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
>  	if (!state)
> @@ -239,7 +240,8 @@ static int nsim_bpf_create_prog(struct nsim_dev *nsim_dev,
>  		return ret;
>  	}
>  
> -	debugfs_create_u32("id", 0400, state->ddir, &prog->aux->id);
> +	id = bpf_prog_get_id(prog);
> +	debugfs_create_u32("id", 0400, state->ddir, &id);
>  	debugfs_create_file("state", 0400, state->ddir,
>  			    &state->state, &nsim_bpf_string_fops);
>  	debugfs_create_bool("loaded", 0400, state->ddir, &state->is_loaded);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9e7d46d16032..18e965bd7db9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1102,7 +1102,7 @@ struct bpf_prog_aux {
>  	u32 max_pkt_offset;
>  	u32 max_tp_access;
>  	u32 stack_depth;
> -	u32 id;
> +	u32 __id; /* access via bpf_prog_get_id() to check bpf_prog::valid_id */

it breaks bpftool that uses

  BPF_CORE_READ((struct bpf_prog *)ent, aux, id);

and bpffs selftest because of preload iter object uses aux->id

  kernel/bpf/preload/iterators/iterators.bpf.c

it'd be great to have a solution that keep 'id' field,
because it's probably used in many bpf programs already

jirka

>  	u32 func_cnt; /* used by non-func prog as the number of func progs */
>  	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
>  	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
> @@ -1197,7 +1197,8 @@ struct bpf_prog {
>  				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
>  				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
>  				call_get_func_ip:1, /* Do we call get_func_ip() */
> -				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> +				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> +				valid_id:1; /* Is bpf_prog::aux::__id valid? */
>  	enum bpf_prog_type	type;		/* Type of BPF program */
>  	enum bpf_attach_type	expected_attach_type; /* For some prog types */
>  	u32			len;		/* Number of filter blocks */
> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
>  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>  void bpf_prog_put(struct bpf_prog *prog);
>  

SNIP
