Return-Path: <bpf+bounces-7506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF5778400
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 01:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04E7281EE9
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC416FB3;
	Thu, 10 Aug 2023 23:15:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463BF1877
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 23:15:13 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19642D47
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 16:15:11 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-267f18688efso866376a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691709311; x=1692314111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMuVuUELujEyMxUarfaXkK7Kz9zqbETZ2pCK99qy/60=;
        b=tdRltnptjesiJDlumN+KCLy7vDzJPuhqCPr2APhv+S6vcuDOVJlVfyDG2d7+yA/bIN
         Fr5NGa1Yaei0CmzoPhfuSY9lQm+RsEy87Q5jxMWsCvk/WHUbK7LOZVQhFXEBL1CnHJP+
         1U2pDKXskzzJXMdUw+TFBy5zKc3pzE6wL4lxxDhgwz3dr0JvHk7F41bR/UTMUhg7Vnrj
         uanzaJuRRHbmkxthcnerF9V1w9av50HIbK2wzMCpjMLWqNAtLWMEEiFVhuzX3Cto5adS
         P+YaHkiRI08feJD2J7p25BW81Yp1PbSxI3d8vmPCnfAMAqDRu2Km/07jB6aXhK6EqRw+
         tPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691709311; x=1692314111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMuVuUELujEyMxUarfaXkK7Kz9zqbETZ2pCK99qy/60=;
        b=HSkP367YwQmOMyqBhTLApCQFVrVtfc0dFAHRpxqfjKfxpmWJG5EYiRON+aDCQCAV8E
         oQ453AVADMzzUWLKMCyoAFbwyGoCaPGNuEICoUFujhAsbKNgjYZ3LSh15y5Bmsc053us
         cHd1i64BAPX6Sshb9enijDtLtvxFGcIQYlA+4zin9SI0QBLeTgKcbN4m019tLuoBxLJ6
         eRRDguv2LHX2TNck1IvLMzDn/kOEcZSMpVaoj0fdSRw6BqPlHDpZP6MogXD8UV/f7Ml4
         dbailB2h00DtitABSDdEiX21KYSyZb24p8JEQeRdXWnCFRvLFs7t6eABxeC99jFVyazX
         ukgg==
X-Gm-Message-State: AOJu0YwmXwToLdRixKvNSvKnjy98pd0Ln78B9eAwbs0YR8ZqH87Z70c3
	bPvH60/UzY8OVhsk0xZsRlRezM4=
X-Google-Smtp-Source: AGHT+IE2r/FSTHWCgDHBwTpQo4Jb++Ywt93XIGJAIrKRnp9rKjsdBgMqTFoG1A9tllXvBrsdceu7kQQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:4393:b0:263:3437:a0b0 with SMTP id
 in19-20020a17090b439300b002633437a0b0mr9075pjb.3.1691709311296; Thu, 10 Aug
 2023 16:15:11 -0700 (PDT)
Date: Thu, 10 Aug 2023 16:15:09 -0700
In-Reply-To: <20230810230141.GA529552@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810220456.521517-1-void@manifault.com> <ZNVousfpuRFgfuAo@google.com>
 <20230810230141.GA529552@maniforge>
Message-ID: <ZNVvfYEsLyotn+G1@google.com>
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
From: Stanislav Fomichev <sdf@google.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	tj@kernel.org, clm@meta.com, thinker.li@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, David Vernet wrote:
> On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
> > On 08/10, David Vernet wrote:
> > > Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> > > define the .validate() and .update() callbacks in its corresponding
> > > struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> > > in its own right to ensure that the map is unloaded if an application
> > > crashes. For example, with sched_ext, we want to automatically unload
> > > the host-wide scheduler if the application crashes. We would likely
> > > never support updating elements of a sched_ext struct_ops map, so we'd
> > > have to implement these callbacks showing that they _can't_ support
> > > element updates just to benefit from the basic lifetime management of
> > > struct_ops links.
> > > 
> > > Let's enable struct_ops maps to work with BPF_F_LINK even if they
> > > haven't defined these callbacks, by assuming that a struct_ops map
> > > element cannot be updated by default.
> > 
> > Any reason this is not part of sched_ext series? As you mention,
> > we don't seem to have such users in the three?
> 
> Hi Stanislav,
> 
> The sched_ext series [0] implements these callbacks. See
> bpf_scx_update() and bpf_scx_validate(). 
> 
> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
> 
> We could add this into that series and remove those callbacks, but this
> patch is fixing a UX / API issue with struct_ops links that's not really
> relevant to sched_ext. I don't think there's any reason to couple
> updating struct_ops map elements with allowing the kernel to manage the
> lifetime of struct_ops maps -- just because we only have 1 (non-test)
> struct_ops implementation in-tree doesn't mean we shouldn't improve APIs
> where it makes sense.
> 
> Thanks,
> David

Ack. I guess up to you and Martin. Just trying to understand whether I'm
missing something or the patch does indeed fix some use-case :-)

