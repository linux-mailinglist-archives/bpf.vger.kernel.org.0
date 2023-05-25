Return-Path: <bpf+bounces-1213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883347107EC
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9372814F4
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0FD2FE;
	Thu, 25 May 2023 08:52:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C230849C
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 08:52:15 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2969E
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 01:52:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-513fea21228so3870433a12.3
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685004731; x=1687596731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/481NzSPOMjzBWK6hXA9XoLfrs+OcCW87qlBrMlxA/M=;
        b=WKgLoqwPRQX6gZSfKRwbdyQedHagsqtK7jck+WT4Jf/pjRBogl/BdUaoyUrGRYq47F
         Fjy4JrFTPPEspjeQno4P6wkngKQdcr7izrtgF1BNHAozy6qUPuZqp40DVKg2jHEkHOP8
         TvQL9wCzhlNChYvdeqQl41Mk5wFQQjBHQur+rjCeNh768UwQ6ktGvJtJotyPLD5XMQjB
         p2l2eDC1X/+Z5vmUYRj/gCLHxEsLJS2zW3QxCxSLOg+DLosDJdMX6pIy1f5kZU8xrq3d
         UKxVqz96XQNyxUrBdYc4+Y3sMNBvQ4kMW26UWyY0/a3WYnrYWUhG3wuxu4rgflw08y+v
         8erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685004731; x=1687596731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/481NzSPOMjzBWK6hXA9XoLfrs+OcCW87qlBrMlxA/M=;
        b=UiVlVZFD87Z8Wd7RmSWfe2x6NScbRSxawQ8jcY33NxOiACfCYFAQKpDPAyO8/ExvqJ
         A0UQRNOmI4FTiUeyQobUNA/biZIEyNmnQxMnRVs+klnukgSKrLjKrXxqMHllPknKedX2
         0euZRq5iM4+yvYRHUpcQfq4D9CIg2P/eFkS2WJKy8b8wo9ku0CkcTBAt7yIOy98PFlne
         bH3AwhL3thIOg+05a1Kive4S6PHsP95/e1FeKjSfb184sXrkA8nqFkl6UxXZLO4Vp2M3
         JtVlsSFDmGlNUDSezW59PFqN8T6Y3jeQ3jJYcKXwbGq+DDcc+yIZCHoXWjVuh3EJsZiF
         btgw==
X-Gm-Message-State: AC+VfDxpLqGSu+rufQb4pAORvC2AU3t13rsWtwVw968LNmnjDfkg1/ng
	DFQ3OLeX6+il9t3gm3LjQ0ZS0OrBisbxxg==
X-Google-Smtp-Source: ACHHUZ5S/NtBpkKhuVuCtBfFZf5KAbukSzPFJoa381Rvjp4D7kGIB2ke58GWFWvzxDnFXCBqD1b6Sg==
X-Received: by 2002:a17:906:dac6:b0:973:ad8f:ef9b with SMTP id xi6-20020a170906dac600b00973ad8fef9bmr601431ejb.5.1685004731229;
        Thu, 25 May 2023 01:52:11 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v24-20020a170906b01800b0096f6e2f4d9esm538054ejy.83.2023.05.25.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:52:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 May 2023 10:52:08 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yhs@meta.com>, Jiri Olsa <olsajiri@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yafang Shao <laoar.shao@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function
 representations sorted by name _and_ address
Message-ID: <ZG8huF4hD3uI0ajy@krava>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com>
 <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com>
 <ZGZQuqVD7gNjia7Z@krava>
 <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com>
 <CAADnVQ+xJVVbP8GC_iT3NgYhhyUxEWkT-kvNgRfDVyv4eyAgHA@mail.gmail.com>
 <CAEf4BzZZ1yP1_2zkGQnp_Zusn_z702eSi8h8ExEkTS8sfmk8_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZZ1yP1_2zkGQnp_Zusn_z702eSi8h8ExEkTS8sfmk8_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 22, 2023 at 02:31:01PM -0700, Andrii Nakryiko wrote:
> On Thu, May 18, 2023 at 5:26 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, May 18, 2023 at 11:26 AM Yonghong Song <yhs@meta.com> wrote:
> > > > I wonder now when the address will be stored as number (not string) we
> > > > could somehow generate relocation records and have the module loader
> > > > do the relocation automatically
> > > >
> > > > not sure how that works for vmlinux when it's loaded/relocated on boot
> > >
> > > Right, actual module address will mostly not match the one in dwarf.
> > > Some during module btf load, we should modify btf address as well
> > > for later use? Yes, may need to reuse some routines used in initial
> > > module relocation.
> >
> >
> > Few thoughts:
> >
> > Initially I felt that single FUNC with multiple DECL_TAG(addr)
> > is better, since BTF for all funcs is the same and it's likely
> > one static inline function that the compiler decided not to inline
> > (like cpumask_weight), so when libbpf wants to attach prog to it
> > the kernel should automatically attach in all places.
> > But then noticed that actually different functions with
> > the same name and proto will be deduplicated into one.
> > Their bodies at different locations will be different.
> > Example: seq_show.
> > In this case it's better to let libbpf pick the exact one to attach.
> > Then realized that even the same function like cpumask_weight()
> > might have different body at different locations due to optimizations.
> > I don't think dwarf contains enough info to distinguish all the combinations.
> >
> > Considering all that it's better to keep one BTF kind_func -> one addr.
> > If it's extended the way Alan is proposing with kind_flag
> > the dedup logic will not combine them due to different addresses.
> 
> I've discussed this w/ Alexei and Yonghong offline, so will summarize
> what I said here. I don't think that we should go the route of adding
> kflag to BTF_KIND_FUNC. As Yonghong pointed out, previously only vlen
> and kind determined byte size of the type, and so adding a third
> variable (kflag), which would apply only to BTF_KIND_FUNC, seems like
> an unnecessary new complication.
> 
> I propose to go with an entirely new kind instead, we have plenty of
> them left. This new kind will be pretty kernel-specific, so could be
> targeted for kernel use cases better without adding unnecessary
> complications to Clang. BTF_KIND_FUNCs generated by Clang for .bpf.o
> files don't need addr, they are meaningless and Clang doesn't know
> anything about addresses anyways. So we can keep Clang unchanged and
> more backwards compatible.
> 
> But now that this new kind (BTF_KIND_KERNEL_FUNC? KFUNC would be
> misleading, unfortunately) is kernel-specific and generated by pahole
> only, besides addr we can add some flags field and use them to mark
> function as defined as kfunc or not, or (as a hypothetical example)
> traceable or not, or maybe we even have inline flag some day, etc.
> Something that makes sense mostly for kernel functions.
> 
> Having said all that, given we are going to break all existing
> BTF-aware tools again with a new kind, we should really couple all
> this work with making BTF self-describing as discussed in [0], so that
> future changes like this won't break older bpftool and other similar
> tools, unnecessarily.

nice, would be great to have this and eventually got rid of new pahole
enable/disable options, makes sense to do this before adding new type

jirka

> 
> Which, btw, is another reason to not use kflag to determine the size
> of btf_type. Proposed solution in [0] assumes that kind + vlen defines
> the size. We should probably have dedicated discussion for
> self-describing BTF, but I think both changes have to be done in the
> same release window.
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/#t
> 
> >
> > Also turned out that the kernel doesn't validate decl_tag string.
> > The following code loads without error:
> > __attribute__((btf_decl_tag("\x10\xf0")));
> >
> > I'm not sure whether we want to tighten decl_tag validation and how.
> > If we keep it as-is we can use func+decl_tag approach
> > to add 4 bytes of addr in the binary format (if 1st byte is not zero).
> > But it feels like a hack, since the kernel needs to be changed
> > anyway to adjust the addresses after module loading and kernel relocation.
> > So func with kind_flag seems like the best approach.
> >
> > Regarding relocation of address in the kernel and modules...
> > We just need to add base_addr to all addrs-es recorded in BTF.
> > Both for kernel and for module BTFs.
> > Shouldn't be too complicated.
> 
> yep, KASLR seems simple enough to handle by the kernel itself at boot time.

