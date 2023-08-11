Return-Path: <bpf+bounces-7607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8767D779870
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 22:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4079F282481
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 20:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF672AB5C;
	Fri, 11 Aug 2023 20:19:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C918468
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 20:19:19 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B2D3;
	Fri, 11 Aug 2023 13:19:18 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58969d4f1b6so26205737b3.2;
        Fri, 11 Aug 2023 13:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691785157; x=1692389957;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZDJSm9RNf/nSpvAQ4JhrwLKn9yLiHfE3C0QiPzYPb8=;
        b=ghumX5DjOChmU9HHpGgBLOKoEiGR+J3aOeBIFbEVQuaykUZDuzjUZT4ZslHE16VIud
         QAR2NfTk2gS2BFtuJIPu9aekyDv3iDGFlVTGwgaYxippwIK4GSqwYrf/YncZbNwExTku
         J7HVkSMRG9FXQvWgmklAY2HZSKlVMv1ZpyysjO0rWUdsZa62fJdOXlPyLdfiP3kEhHtm
         PP4L47xBIKhIkOAK7zsX5MpTDtKjgZYHmkE7o8r0NUOD/dBvbbWur8ZMUuVSbLLFaZ4f
         FOsONDZvJIZBQq6AB1CO1w/4mNGvLj2ZXhZ0buWSCpxM5Ia52tSB1zS6UIWl+UfQbYSK
         DRRg==
X-Gm-Message-State: AOJu0Yw6iIJHVHIf9T3NXnHkLStYcxYZjqL/p6/He4R3+6iq8LIuj1+7
	tsQeBclZnugAvRQg5TogUFM=
X-Google-Smtp-Source: AGHT+IEJP0i/MsbqW/Ls0XJo2q92GFLKjBpom7LnCeGJEMwcGbrl//1iF+MhKB1Qiw0iAeYdco0crg==
X-Received: by 2002:a81:4f94:0:b0:561:429e:acd2 with SMTP id d142-20020a814f94000000b00561429eacd2mr2733067ywb.35.1691785157084;
        Fri, 11 Aug 2023 13:19:17 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id p139-20020a0de691000000b00583b144fe51sm1195843ywe.118.2023.08.11.13.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:19:16 -0700 (PDT)
Date: Fri, 11 Aug 2023 15:19:14 -0500
From: David Vernet <void@manifault.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, tj@kernel.org, clm@meta.com,
	thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Message-ID: <20230811201914.GD542801@maniforge>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com>
 <20230810230141.GA529552@maniforge>
 <ZNVvfYEsLyotn+G1@google.com>
 <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 10:35:03AM -0700, Martin KaFai Lau wrote:
> On 8/10/23 4:15 PM, Stanislav Fomichev wrote:
> > On 08/10, David Vernet wrote:
> > > On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
> > > > On 08/10, David Vernet wrote:
> > > > > Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> > > > > define the .validate() and .update() callbacks in its corresponding
> > > > > struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> > > > > in its own right to ensure that the map is unloaded if an application
> > > > > crashes. For example, with sched_ext, we want to automatically unload
> > > > > the host-wide scheduler if the application crashes. We would likely
> > > > > never support updating elements of a sched_ext struct_ops map, so we'd
> > > > > have to implement these callbacks showing that they _can't_ support
> > > > > element updates just to benefit from the basic lifetime management of
> > > > > struct_ops links.
> > > > > 
> > > > > Let's enable struct_ops maps to work with BPF_F_LINK even if they
> > > > > haven't defined these callbacks, by assuming that a struct_ops map
> > > > > element cannot be updated by default.
> > > > 
> > > > Any reason this is not part of sched_ext series? As you mention,
> > > > we don't seem to have such users in the three?
> > > 
> > > Hi Stanislav,
> > > 
> > > The sched_ext series [0] implements these callbacks. See
> > > bpf_scx_update() and bpf_scx_validate().
> > > 
> > > [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
> > > 
> > > We could add this into that series and remove those callbacks, but this
> > > patch is fixing a UX / API issue with struct_ops links that's not really
> > > relevant to sched_ext. I don't think there's any reason to couple
> > > updating struct_ops map elements with allowing the kernel to manage the
> > > lifetime of struct_ops maps -- just because we only have 1 (non-test)
> 
> Agree the link-update does not necessarily couple with link-creation, so
> removing 'link' update function enforcement is ok. The intention was to
> avoid the struct_ops link inconsistent experience (one struct_ops link
> support update and another struct_ops link does not) because consistency was
> one of the reason for the true kernel backed link support that Kui-Feng did.
> tcp-cc is the only one for now in struct_ops and it can support update, so
> the enforcement is here. I can see Stan's point that removing it now looks
> immature before a struct_ops landed in the kernel showing it does not make
> sense or very hard to support 'link' update. However, the scx patch set has
> shown this point, so I think it is good enough.

Sorry for sending v2 of the patch a bit prematurely. Should have let you
weigh in first.

> For 'validate', it is not related a 'link' update. It is for the struct_ops
> 'map' update. If the loaded struct_ops map is invalid, it will end up having
> a useless struct_ops map and no link can be created from it. I can see some

To be honest I'm actually not sure I understand why .validate() is only
called for when BPF_F_LINK is specified. Is it because it could break
existing programs if they defined a struct_ops map that wasn't valid
_without_ using BPF_F_LINK? Whether or not a map is valid should inform
whether we can load it regardless of whether there's a link, no? It
seems like .init_member() was already doing this as well. That's why I
got confused and conflated the two.

> struct_ops subsystem check all the 'ops' function for NULL before calling
> (like the FUSE RFC). I can also see some future struct_ops will prefer not
> to check NULL at all and prefer to assume a subset of the ops is always
> valid. Does having a 'validate' enforcement is blocking the scx patchset in
> some way? If not, I would like to keep this for now. Once it is removed,

No, it's not blocking scx at all. scx, as with any other struct_ops
implementation, could and does just implement these callbacks. As
Kui-Feng said in [0], this is really just about enabling a sane default
to improve usability. If a struct_ops implementation actually should
have implemented some validation but neglected to, that would be a bug
in exactly the same manner as if it had implemented .validate(), but
neglected to check some corner case that makes the map invalid.

[0]: https://lore.kernel.org/lkml/887699ea-f837-6ed7-50bd-48720cea581c@gmail.com/

> there is no turning back.

Hmm, why there would be no turning back from this? This isn't a UAPI
concern, is it? Whether or not a struct_ops implementation needs to
implement .validate() or can just rely on the default behavior of "no
.validate() callback implies the map is valid" is 100% an implementation
detail that's hidden from the end user. This is meant to be a UX
improvement for a developr defining a struct bpf_struct_ops instance in
the main kernel, not someone defining an instance of that struct_ops
(e.g. struct tcp_congestion_ops) in a BPF prog.

