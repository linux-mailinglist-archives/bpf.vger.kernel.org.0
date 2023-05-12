Return-Path: <bpf+bounces-456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C899C7011A5
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00061C21259
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1763C0;
	Fri, 12 May 2023 21:54:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3028261E8
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 21:54:33 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF67A80
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 14:54:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965fc25f009so1624958966b.3
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683928467; x=1686520467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=quxrjhEWRaKzl9G0M7wT5jkcm7qYKvcRrjLXT2xdmlQ=;
        b=Y4nOgITkPpJWk4ThcJpOSNanmVsblf4voBtWo0hjJm0uJDD7M6EAaVuq9RsUMbzH7D
         uKr+rZGqddc9+Fh5z/Bz/uZnpuea8mdLfd0GDc6lWq4nlf0YVRnpc1HGrRja1uc/UzOE
         L6Zoj1Ua5tNkWdw7kJzB1iUU9zyDP59aJbhJfquAXdYEuh/regPE2PLDR4cdSBMQZ5Gb
         nPaV2x6JEaCr3Cqx9geBH6bxRmngTzFkyFfxevQN/68EV6EfTHEPb0HuR7Y9hoEdPlfk
         s4YwOzUtQO0J++46VgKSMXt1FFmud/BByeSDE0HHR4XklQUWU4/eUyeNSds6xrx86GCl
         njTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928467; x=1686520467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quxrjhEWRaKzl9G0M7wT5jkcm7qYKvcRrjLXT2xdmlQ=;
        b=ZfkI9HGNI0zNIiuc0BvPZlql2it02WKRsMqVp/QNWPWyefV2ILIV9GFhp93FBBYdlH
         x3QT/Gmok5+NuwW5ypBrBDd1udZrxwogf/bT7aMwS39I+mQlME0EPjgt+Jq8YPxWP6Hc
         cDeufD31j8N43MrZ5Hnl0hhHWzL4laTA/2bcZOwagR8HNUFMhC82GsrENn3KXTg/TXYq
         lirEIfuHuyb5UTl134njih5W4pkXzU7xVWCgvvcXrx81/znnSc9d4/Q93ODyTW/HKf7S
         YsojP0KqtJYwTLyM8Z31IWI3ntDweocf/43HHzKlmDI7fKMQDp+10obqzbZdl/EEEKzX
         7tTA==
X-Gm-Message-State: AC+VfDxldr7O6X0jWxOASrL/xC2LC/BgtE04yLwZ5h7gp4oTymEkH/ln
	oAItiwbtZPVGJsNOyBgxSvU=
X-Google-Smtp-Source: ACHHUZ4dsNZ990cYWIFvsZ0iNDAMOAn1TIZfwzVhQhISsPeHscFhz0Ux5XsCthRM2Lng5o3lAAqYOA==
X-Received: by 2002:a17:907:6e03:b0:96a:440b:d5dc with SMTP id sd3-20020a1709076e0300b0096a440bd5dcmr9465376ejc.54.1683928467159;
        Fri, 12 May 2023 14:54:27 -0700 (PDT)
Received: from krava (213-240-85-134.hdsl.highway.telekom.at. [213.240.85.134])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b00959c6cb82basm5909890ejc.105.2023.05.12.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:54:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 12 May 2023 23:54:23 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Lorenz Bauer <lmb@isovalent.com>, Timo Beckers <timo@incline.eu>
Subject: Re: [PATCH bpf-next] bpf: Add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <ZF61j8WJls25BYTl@krava>
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
 <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
 <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
 <CAADnVQKDO8_Hnotf40iHLD-GRmJZpz_ygpkYZGRvey0ENJOc0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKDO8_Hnotf40iHLD-GRmJZpz_ygpkYZGRvey0ENJOc0g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 11:59:34AM -0700, Alexei Starovoitov wrote:
> On Fri, May 12, 2023 at 9:04 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 12/05/2023 03:51, Yafang Shao wrote:
> > > On Wed, May 10, 2023 at 9:03 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >>
> > >> v1.25 of pahole supports filtering out functions with multiple inconsistent
> > >> function prototypes or optimized-out parameters from the BTF representation.
> > >> These present problems because there is no additional info in BTF saying which
> > >> inconsistent prototype matches which function instance to help guide attachment,
> > >> and functions with optimized-out parameters can lead to incorrect assumptions
> > >> about register contents.
> > >>
> > >> So for now, filter out such functions while adding BTF representations for
> > >> functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
> > >> This patch assumes that below linked changes land in pahole for v1.25.
> > >>
> > >> Issues with pahole filtering being too aggressive in removing functions
> > >> appear to be resolved now, but CI and further testing will confirm.
> > >>
> > >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >> ---
> > >>  scripts/pahole-flags.sh | 3 +++
> > >>  1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > >> index 1f1f1d397c39..728d55190d97 100755
> > >> --- a/scripts/pahole-flags.sh
> > >> +++ b/scripts/pahole-flags.sh
> > >> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> > >>         # see PAHOLE_HAS_LANG_EXCLUDE
> > >>         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> > >>  fi
> > >> +if [ "${pahole_ver}" -ge "125" ]; then
> > >> +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> > >> +fi
> > >>
> > >>  echo ${extra_paholeopt}
> > >> --
> > >> 2.31.1
> > >>
> > >
> > > That change looks like a workaround to me.
> > > There may be multiple functions that have the same proto, e.g.:
> > >
> > >   $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
> > > kernel/bpf/ net/core/
> > >   kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
> > > bpf_iter_aux_info *aux)
> > >   net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
> > > bpf_iter_aux_info *aux)
> > >
> > >   $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
> > > bpf_iter_detach_map
> > >   [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
> > >   'aux' type_id=2638
> > >   [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
> > >
> > > We don't know which one it is in the BTF.
> > > However, I'm not against this change, as it can avoid some issues.
> > >
> >
> > In the above case, the BTF representation is consistent though.
> > That is, if I attach fentry progs to either of these functions
> > based on that BTF representation, nothing will crash.
> >
> > That's ultimately what those changes are about; ensuring
> > consistency in BTF representation, so when a function is in
> > BTF we can know the signature of the function can be safely
> > used by fentry for example.
> >
> > The question of being able to identify functions (as opposed
> > to having a consistent representation) is the next step.
> > Finding a way to link between kallsyms and BTF would allow us to
> > have multiple inconsistent functions in BTF, since we could map
> > from BTF -> kallsyms safely. So two functions called "foo"
> > with different function signatures would be okay, because
> > we'd know which was which in kallsyms and could attach
> > safely. Something like a BTF tag for the function that could
> > clarify that mapping - but just for cases where it would
> > otherwise be ambiguous - is probably the way forward
> > longer term.
> >
> > Jiri's talking about this topic at LSF/MM/BPF this week I believe.
> 
> Jiri presented a few ideas during LSFMMBPF.
> 
> I feel the best approach is to add a set of addr-s to BTF
> via a special decl_tag.
> We can also consider extending KIND_FUNC.
> The advantage that every BTF func will have one or more addrs
> associated with it and bpf prog loading logic wouldn't need to do
> fragile name comparison between btf and kallsyms.
> pahole can take addrs from dwarf and optionally double check with kallsyms.

Yonghong summed it up in another email discussion, pasting it in here:

  So overall we have three options as kallsyms representation now:
    (a) "addr module:foo:dir_a/dir_b/core.c"
    (b) "addr module:foo"
    (c) "addr module:foo:btf_id"

  option (a):
    'dir_a/dir_b/core.c' needs to be encoded in BTF.
    user space either check file path or func signature
    to find attach_btf_id and pass to the kernel.
    kernel can find file path in BTF and then lookup
    kallsyms to find addr.

  option (b):
    "addr" needs to be encoded in BTF.
    user space checks func signature to find
    attach_btf_id and pass to the kernel.
    kernel can find addr in BTF and use it.

  option (c):
    if user can decide which function to attach, e.g.,
    through func signature, then no BTF encoding
    is necessary. attach_btf_id is passed to the
    kernel and search kallsyms to find the matching
    btf_id and 'addr' will be available then.

  For option (b) and (c), user space needs to check
  func signature to find which btf_id to use. If
  same-name static functions having the identical
  signatures, then user space would have a hard time
  to differentiate. I think it should be very
  rare same-name static functions in the kernel will have
  identical signatures. But if we want 100% correctness,
  we may need file path in which case option (a)
  is preferable.

  Current option (a) kallsyms format is under review.
  option (c) also needs kallsyms change...


my thoughts so far is that I like the idea of storing functions address
in BTF (option b), because it's the easiest way

on the other hand, user would need debug info to find address for the function
to trace.. but still just for small subset of functions that share same name

also I like Lorenz's idea of storing BTF ID in kalsyms and verifier being
able to lookup address based on BTF ID.. seems like easier kallsyms change,
but it would still require storing objects paths in BTF to pick up the
correct one

cc-ing other folks

jirka

