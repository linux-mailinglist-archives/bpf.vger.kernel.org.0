Return-Path: <bpf+bounces-15776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F07F67DC
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 20:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6913281B1A
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74364D120;
	Thu, 23 Nov 2023 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMGAuR/d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FFC9A
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 11:53:09 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a03a900956dso235951566b.1
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700769188; x=1701373988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXl2N1bio6SpWJ0oCro0nrwO7Nvq27zR4c92wMLs1yw=;
        b=iMGAuR/doMSTKfi4odUkV1ekAv6NSYWj2ryFhY8wKk0Ut4Rexh9lXGxGSEZOqJmNLV
         PCuRdl0k/fBdm28z1vkYydWoE6lEoDhKhxNwSBeuzor7ApQ0iyO+ekv+iXb9j4qLAm+9
         lxzfQ6eWoCtkx6EViQuUJafZy4VK22zlKbris+wFQNWCwlmZAeTcTYqFQg6DRbiFHh43
         b9Kc8xfWMruQHYHlOhAhwlr+FdiuzcPT08WBopeQqi9MXTy1sFdBNnA8q71IcbidoAFT
         /a1fZwISQhEEwnJiMzRmKEaJIgTWbxxnSS9ZIh1yKWifxe/87N6IFCQKYlKzbV+n+KfP
         f3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700769188; x=1701373988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXl2N1bio6SpWJ0oCro0nrwO7Nvq27zR4c92wMLs1yw=;
        b=i4lBHnkYXrHJA0mqXvSJu+OdD7pyDrz6cdfkRaXQ71ZC3NQpWgSEQ8chvxxk7GZ6CC
         lPmCRMCx7gv9iIZo3ptmpA72P7BlbchHr8jB0MbOKKGhPikABz0E5WWIRajuG7pcsQzo
         gsY/7jX41j220jL5iUGWjdfUHkq50RJbC3KxVO4yqlDDtf4AHGqdOvaycf8Q+w4iMB52
         MFaxy0v4CRS61u+MSXP2tyGZKtuM9tRsXQdQ16Qb0H9iEx6FqhVn8OtgFRmVcX3KnJZ8
         D/slV1XOKq3VZHhdXORhktjFKuYFq2U5+EEP/KdnOAwMx6RVpvBgiV9W0jG40C4wvBnG
         MQRA==
X-Gm-Message-State: AOJu0YwJKe0qYldJLY9rMETpRAodNegAe5lFOELWV3idqfsm2V6WE/oS
	xyIbCxodtgOJjXoObGmr84Y=
X-Google-Smtp-Source: AGHT+IHM7y7GAPg73pO5hFweOk9LRl3g+BoK/R3rTQrGA9suL1aLGWR8UtgfdtRHi4iALohVdCJARQ==
X-Received: by 2002:a17:906:2088:b0:9ee:9d98:7d8c with SMTP id 8-20020a170906208800b009ee9d987d8cmr2922648ejq.6.1700769188032;
        Thu, 23 Nov 2023 11:53:08 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm1149578ejq.124.2023.11.23.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 11:53:07 -0800 (PST)
Date: Thu, 23 Nov 2023 20:49:31 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231123194931.2xmzhjggvozemdk6@erthalion.local>
References: <20231122191816.5572-1-9erthalion6@gmail.com>
 <ZV9g3ZJQrwhSw-kQ@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV9g3ZJQrwhSw-kQ@krava>

> On Thu, Nov 23, 2023 at 03:25:33PM +0100, Jiri Olsa wrote:
> > +	link->prog->aux->attach_depth--;
>
> should we just set it to 0 ? the number is assigned from tgt_prog, so I think we'll
> endup with wrong up number here after detach (for both tgt_prog or kernel function)

> > +	if (tgt_prog) {
> > +		/* Bookkeeping for managing the prog attachment chain. */
> > +		tgt_prog->aux->follower_cnt++;
> > +		prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
> > +	}
>
> missing cleanup/dec if the next bpf_trampoline_link_prog call fails?
> probably better move that accounting after that call

> > +	printf("  attach depth %d", info->attach_depth);
> > +
>
> I think we should print only if the value != 0 like we do for other fields

> > +		if (tgt_prog->type == prog->type &&
> > +			(prog_extension || prog->aux->follower_cnt > 0)) {
> > +			/*
> > +			 * To avoid potential call chain cycles, prevent attaching programs
> > +			 * of the same type. The only exception is standalone fentry/fexit
> > +			 * programs that themselves are not attachment targets.
> > +			 * That means:
> > +			 *  - Cannot attach followed fentry/fexit to another
> > +			 *    fentry/fexit program.
> > +			 *  - Cannot attach program extension to another extension.
>
> would be great to have tests for this

Agree on all points, thanks. Will post the updated version soon.

