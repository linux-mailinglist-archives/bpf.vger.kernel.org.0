Return-Path: <bpf+bounces-4550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71D74C68C
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2941C20991
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB3DDDF;
	Sun,  9 Jul 2023 17:17:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B979E6;
	Sun,  9 Jul 2023 17:17:34 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA412A;
	Sun,  9 Jul 2023 10:17:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8baa836a5so27876055ad.1;
        Sun, 09 Jul 2023 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688923052; x=1691515052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6Hs9ebDPWkVgkL2jmocwHG7j2woEA29Xy0SFxzTKyg=;
        b=lRWtbrlQpBSF2sBDLc4d8sZx1ebTrHJAZuWV6+HgwmzJx/8ESfjDO2VZQAsiVYt+1r
         Ocgj9YmhyWMRW8bfmYB5raxnyfwWah/CDZnWuvGE4wiOnonaJW3Vkcy0VQidGMETFERG
         DDEGll+NIkwdpI3QNHQrA5Ev2AaOEr7kpTg5OAaWqZzsFSgK+QjSF9FJiSMXS6avLK8o
         bvQljKcXpaZZWlh0h8CJb8REKy5zmuVYezVRefJCiqI9CFbFalqpw4Dsamb+BqvRZiQs
         iXeXEi6X0v7wOJs2YbAyXXlaOXG/NrrIvB0p4DU3l2EItqyC3H9QMK43HM6cYl5TaRuQ
         f0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923052; x=1691515052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Hs9ebDPWkVgkL2jmocwHG7j2woEA29Xy0SFxzTKyg=;
        b=IwFbZkn0oLkdesj0uaXgFJ9erkoxYlBGCBbXEB6TaP+whDCdn8wUQ19/haFgwHvwyX
         Rh2CVwoHEGWEoZINO9G5WgtQJLH49eYukpwbkyag/EBbxASbQiv9i1e7qZWxYKZscqZs
         c97BKIVTlk67YkSPld1oyu170sdctU+ZlGDwJ30Sj83m819uhp8uJ8Oo8eRn4pmrbRdZ
         FVPFpF+g78kyWAmaKjS8dBV7vGyFcCnyLdDviuDJvSaykqfUkn4JvUY9lfdGAfMZeBS+
         dPLXRB+0CXnlg9buiaBPAaKHvo+qjpd9NP16PgTvmytBIl8LwC/Quvr++qLbgmvdpGnp
         8WsQ==
X-Gm-Message-State: ABy/qLaO98a57DEdh29Dpz+O4CknxhVNjAy5q7WXgopgaxYiFZCnUK3e
	cbIljZpvCRK+TH0Pu5hf0DI=
X-Google-Smtp-Source: APBJJlFYK1AsT6jGfXAeUi6syRGRWAdqK7mlwZ84SlpCOH9XivYMheD1R38LM45EWKtLy1dscQALzA==
X-Received: by 2002:a17:902:ce91:b0:1b9:e23a:f761 with SMTP id f17-20020a170902ce9100b001b9e23af761mr482790plg.63.1688923052439;
        Sun, 09 Jul 2023 10:17:32 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:9b44])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a035800b0025be7b69d73sm5104935pjf.12.2023.07.09.10.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 10:17:31 -0700 (PDT)
Date: Sun, 9 Jul 2023 10:17:28 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
Message-ID: <20230709171728.gonedzieinilrvra@MacBook-Pro-8.local>
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707172455.7634-2-daniel@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 07:24:48PM +0200, Daniel Borkmann wrote:
> +
> +#define BPF_MPROG_KEEP	0
> +#define BPF_MPROG_SWAP	1
> +#define BPF_MPROG_FREE	2

Please document how this is suppose to be used.
Patch 2 is using BPF_MPROG_FREE in tcx_entry_needs_release().
Where most of the code treats BPF_MPROG_SWAP and BPF_MPROG_FREE as equivalent.
I can guess what it's for, but a comment would help.

> +
> +#define BPF_MPROG_MAX	64

we've seen buggy user space attaching thousands of tc progs to the same netdev.
I suspect 64 limit will be hit much sooner than expected.

> +
> +#define bpf_mprog_foreach_tuple(entry, fp, cp, t)			\
> +	for (fp = &entry->fp_items[0], cp = &entry->parent->cp_items[0];\
> +	     ({								\
> +		t.prog = READ_ONCE(fp->prog);				\
> +		t.link = cp->link;					\
> +		t.prog;							\
> +	      });							\
> +	     fp++, cp++)
> +
> +#define bpf_mprog_foreach_prog(entry, fp, p)				\
> +	for (fp = &entry->fp_items[0];					\
> +	     (p = READ_ONCE(fp->prog));					\
> +	     fp++)

I have similar questions to Stanislav.
Looks like update/delete/query of bpf_prog should be protected by an external lock
(like RTNL in case of tcx),
but what are the life time rules for 'entry'?
Looking at patch 2 sch_handle_ingress():
struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
I suspect the assumption is that bpf_mprog_entry object should be accessed within
RCU critical section. Since tc/tcx and XDP run in napi we have RCU protection there.
In the future, for cgroups, bpf_prog_run_array_cg() will keep explicit rcu_read_lock()
before accessing bpf_mprog_entry, right?
And bpf_mprog_commit() assumes that RCU protection.
All fine, but we need to document that mprog mechanism is not suitable for sleepable progs.

> +	if (flags & BPF_F_BEFORE) {
> +		tidx = bpf_mprog_pos_before(entry, &rtuple);
> +		if (tidx < -1 || (idx >= -1 && tidx != idx)) {
> +			ret = tidx < -1 ? tidx : -EDOM;
> +			goto out;
> +		}
> +		idx = tidx;
> +	}
> +	if (flags & BPF_F_AFTER) {
> +		tidx = bpf_mprog_pos_after(entry, &rtuple);
> +		if (tidx < 0 || (idx >= -1 && tidx != idx)) {

tidx < 0 vs tidx < -1 for _after vs _before.
Does it have to have this subtle difference?
Can _after and _before have the same semantics for return value?

> +			ret = tidx < 0 ? tidx : -EDOM;
> +			goto out;
> +		}
> +		idx = tidx;
> +	}

